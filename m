Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706AE38BC7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 04:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhEUCnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 22:43:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhEUCnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 22:43:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 608271F43D2B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 00/11] File system wide monitoring
Date:   Thu, 20 May 2021 22:41:23 -0400
Message-Id: <20210521024134.1032503-1-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This series follow up on my previous proposal [1] to support file system
wide monitoring.  As suggested by Amir, this proposal drops the ring
buffer in favor of a single slot associated with each mark.  This
simplifies a bit the implementation, as you can see in the code.

As a reminder, This proposal is limited to an interface for
administrators to monitor the health of a file system, instead of a
generic inteface for file errors.  Therefore, this doesn't solve the
problem of writeback errors or the need to watch a specific subtree.

In comparison to the previous RFC, this implementation also drops the
per-fs data and location, and leave those as future extensions.

* Implementation

The feature is implemented on top of fanotify, as a new type of fanotify
mark, FAN_ERROR, which a file system monitoring tool can register to
receive error notifications.  When an error occurs a new notification is
generated, in addition followed by this info field:

 - FS generic data: A file system agnostic structure that has a generic
 error code and identifies the filesystem.  Basically, it let's
 userspace know something happened on a monitored filesystem.  Since
 only the first error is recorded since the last read, this also
 includes a counter of errors that happened since the last read.

* Testing

This was tested by watching notifications flowing from an intentionally
corrupted filesystem in different places.  In addition, other events
were watched in an attempt to detect regressions.

Is there a specific testsuite for fanotify I should be running?

* Patches

This patchset is divided as follows: Patch 1 through 5 are refactoring
to fsnotify/fanotify in preparation for FS_ERROR/FAN_ERROR; patch 6 and
7 implement the FS_ERROR API for filesystems to report error; patch 8
add support for FAN_ERROR in fanotify; Patch 9 is an example
implementation for ext4; patch 10 and 11 provide a sample userspace code
and documentation.

I also pushed the full series to:

  https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-single-slot

[1] https://lwn.net/Articles/854545/

Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>
Cc: jack@suse.com
To: amir73il@gmail.com
Cc: dhowells@redhat.com
Cc: khazhy@google.com
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-ext4@vger.kernel.org

Gabriel Krisman Bertazi (11):
  fanotify: Fold event size calculation to its own function
  fanotify: Split fsid check from other fid mode checks
  fanotify: Simplify directory sanity check in DFID_NAME mode
  fanotify: Expose fanotify_mark
  inotify: Don't force FS_IN_IGNORED
  fsnotify: Support FS_ERROR event type
  fsnotify: Introduce helpers to send error_events
  fanotify: Introduce FAN_ERROR event
  ext4: Send notifications on error
  samples: Add fs error monitoring example
  Documentation: Document the FAN_ERROR event

 .../admin-guide/filesystem-monitoring.rst     |  52 +++++
 Documentation/admin-guide/index.rst           |   1 +
 fs/ext4/super.c                               |   8 +
 fs/notify/fanotify/fanotify.c                 |  80 ++++++-
 fs/notify/fanotify/fanotify.h                 |  38 +++-
 fs/notify/fanotify/fanotify_user.c            | 213 ++++++++++++++----
 fs/notify/inotify/inotify_user.c              |   6 +-
 include/linux/fanotify.h                      |   6 +-
 include/linux/fsnotify.h                      |  13 ++
 include/linux/fsnotify_backend.h              |  15 +-
 include/uapi/linux/fanotify.h                 |  10 +
 samples/Kconfig                               |   8 +
 samples/Makefile                              |   1 +
 samples/fanotify/Makefile                     |   3 +
 samples/fanotify/fs-monitor.c                 |  91 ++++++++
 15 files changed, 485 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.31.0


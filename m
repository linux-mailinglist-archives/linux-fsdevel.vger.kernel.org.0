Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725313A8CF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 01:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFOX6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 19:58:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39890 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFOX6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:58:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 214931F432D2
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     kernel@collabora.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 00/14] File system wide monitoring
Date:   Tue, 15 Jun 2021 19:55:42 -0400
Message-Id: <20210615235556.970928-1-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This follows up on the previous version [2].  There is not much design
changes, except to attend to Amir and Darrick's reviews.  Thank you both
so much for the detailed feedback.  It is really appreciated.

I decided not to implement FID mode reporting in this version, since it
can be extended later without prejudice to the user API.

This version also includes a small fix to fsnotify_add_event on patch 1
to prevent adding overflow events to the hash map.

This was tested with LTP for regressions, and also using the sample on
the last patch, with a corrupted image.  I can publish the bad image upon
request.

I also pushed the full series to:

  https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-single-slot

Thank you

Original cover letter
---------------------
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
[2] https://lwn.net/Articles/856916/

Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>
Cc: jack@suse.com
To: amir73il@gmail.com
Cc: dhowells@redhat.com
Cc: khazhy@google.com
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-ext4@vger.kernel.org

Amir Goldstein (1):
  fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info

Gabriel Krisman Bertazi (13):
  fsnotify: Don't call insert hook for overflow events
  fanotify: Fold event size calculation to its own function
  fanotify: Split fsid check from other fid mode checks
  fanotify: Split superblock marks out to a new cache
  inotify: Don't force FS_IN_IGNORED
  fsnotify: Add helper to detect overflow_event
  fsnotify: Support passing argument to insert callback on add_event
  fsnotify: Support FS_ERROR event type
  fsnotify: Introduce helpers to send error_events
  fanotify: Introduce FAN_FS_ERROR event
  ext4: Send notifications on error
  samples: Add fs error monitoring example
  Documentation: Document the FAN_FS_ERROR event

 .../admin-guide/filesystem-monitoring.rst     |  63 +++++
 Documentation/admin-guide/index.rst           |   1 +
 fs/ext4/super.c                               |   8 +
 fs/notify/fanotify/fanotify.c                 | 187 ++++++++++++---
 fs/notify/fanotify/fanotify.h                 |  44 +++-
 fs/notify/fanotify/fanotify_user.c            | 226 +++++++++++++++---
 fs/notify/fsnotify.c                          |  85 ++++---
 fs/notify/inotify/inotify_fsnotify.c          |   2 +-
 fs/notify/inotify/inotify_user.c              |   6 +-
 fs/notify/notification.c                      |  12 +-
 include/linux/fanotify.h                      |   6 +-
 include/linux/fsnotify.h                      |  35 ++-
 include/linux/fsnotify_backend.h              | 104 ++++++--
 include/uapi/linux/fanotify.h                 |  11 +
 samples/Kconfig                               |   9 +
 samples/Makefile                              |   1 +
 samples/fanotify/Makefile                     |   3 +
 samples/fanotify/fs-monitor.c                 |  95 ++++++++
 18 files changed, 752 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.31.0


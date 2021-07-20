Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FDC3CFEC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 18:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhGTP2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbhGTPT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:19:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105BC06139F;
        Tue, 20 Jul 2021 08:59:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8CAD81F4311A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 00/16] File system wide monitoring
Date:   Tue, 20 Jul 2021 11:59:28 -0400
Message-Id: <20210720155944.1447086-1-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is the fourth version of the FAN_FS_ERROR patches.  This applies
the feedback from last version (thanks Amir, Jan), in particular how we
report file handlers for errors not related to a file.  Now it is
reported as an invalid, empty fh.

This was tested with LTP for regressions, and also using the sample on
the last patch, with a corrupted image.  I can publish the bad image
upon request.

In addition, I wrote a man-page that can be pulled from:

  https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error

And I'm sending it shortly for review.

I'm automating my tests in LTP next and will be sharing shortly.

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

Gabriel Krisman Bertazi (15):
  fsnotify: Don't insert unmergeable events in hashtable
  fanotify: Fold event size calculation to its own function
  fanotify: Split fsid check from other fid mode checks
  fsnotify: Reserve mark bits for backends
  fanotify: Split superblock marks out to a new cache
  inotify: Don't force FS_IN_IGNORED
  fsnotify: Add helper to detect overflow_event
  fsnotify: Add wrapper around fsnotify_add_event
  fsnotify: Support passing argument to insert callback on add_event
  fsnotify: Support FS_ERROR event type
  fsnotify: Introduce helpers to send error_events
  fanotify: Introduce FAN_FS_ERROR event
  ext4: Send notifications on error
  samples: Add fs error monitoring example
  docs: Document the FAN_FS_ERROR event

 .../admin-guide/filesystem-monitoring.rst     |  70 +++++
 Documentation/admin-guide/index.rst           |   1 +
 fs/ext4/super.c                               |   8 +
 fs/notify/fanotify/fanotify.c                 | 217 ++++++++++----
 fs/notify/fanotify/fanotify.h                 |  79 ++++-
 fs/notify/fanotify/fanotify_user.c            | 278 +++++++++++++++---
 fs/notify/fsnotify.c                          |  75 ++---
 fs/notify/inotify/inotify_fsnotify.c          |   2 +-
 fs/notify/inotify/inotify_user.c              |   6 +-
 fs/notify/notification.c                      |  16 +-
 include/linux/fanotify.h                      |   8 +-
 include/linux/fsnotify.h                      |  13 +
 include/linux/fsnotify_backend.h              | 140 +++++++--
 include/uapi/linux/fanotify.h                 |   8 +
 samples/Kconfig                               |   9 +
 samples/Makefile                              |   1 +
 samples/fanotify/Makefile                     |   5 +
 samples/fanotify/fs-monitor.c                 | 134 +++++++++
 18 files changed, 897 insertions(+), 173 deletions(-)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.32.0


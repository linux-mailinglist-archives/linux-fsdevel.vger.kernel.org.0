Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369953E053E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhHDQGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:06:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41822 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHDQGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:06:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 469141F4080F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 00/23] File system wide monitoring
Date:   Wed,  4 Aug 2021 12:05:49 -0400
Message-Id: <20210804160612.3575505-1-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is the 5th version of the FAN_FS_ERROR patches.  This applies
the feedback from last version (thanks Amir, Jan).  Biggest changes are
the split up of the FAN_FS_ERROR patch into something more reviewable,
and the removal of the event_info structure due to the perf regression
shown by unixbench.

This was tested with LTP for regressions, and also using the sample on
the last patch, with a corrupted image.  I wrote a new ltp test for this
feature which is being reviewed and is available at:

  https://gitlab.collabora.com/krisman/ltp  -b fan-fs-error

In addition, I wrote a man-page that can be pulled from:

  https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error

And is being reviewed at the list.

I also pushed this full series to:

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
Cc: linux-api@vger.kernel.org
Cc: linux-api@vger.kernel.org

Gabriel Krisman Bertazi (23):
  fsnotify: Don't insert unmergeable events in hashtable
  fanotify: Fold event size calculation to its own function
  fanotify: Split fsid check from other fid mode checks
  fsnotify: Reserve mark bits for backends
  fanotify: Split superblock marks out to a new cache
  inotify: Don't force FS_IN_IGNORED
  fsnotify: Add helper to detect overflow_event
  fsnotify: Add wrapper around fsnotify_add_event
  fsnotify: Support passing argument to insert callback on add_event
  fsnotify: Allow events reported with an empty inode
  fsnotify: Support FS_ERROR event type
  fanotify: Expose helper to estimate file handle encoding length
  fanotify: Allow file handle encoding for unhashed events
  fanotify: Encode invalid file handler when no inode is provided
  fanotify: Require fid_mode for any non-fd event
  fanotify: Reserve UAPI bits for FAN_FS_ERROR
  fanotify: Preallocate per superblock mark error event
  fanotify: Handle FAN_FS_ERROR events
  fanotify: Report fid info for file related file system errors
  fanotify: Emit generic error info type for error event
  ext4: Send notifications on error
  samples: Add fs error monitoring example
  docs: Document the FAN_FS_ERROR event

 .../admin-guide/filesystem-monitoring.rst     |  70 +++++
 Documentation/admin-guide/index.rst           |   1 +
 fs/ext4/super.c                               |   8 +
 fs/kernfs/file.c                              |   6 +-
 fs/notify/fanotify/fanotify.c                 | 186 +++++++++---
 fs/notify/fanotify/fanotify.h                 |  80 +++++-
 fs/notify/fanotify/fanotify_user.c            | 266 +++++++++++++++---
 fs/notify/fsnotify.c                          |  14 +-
 fs/notify/inotify/inotify_fsnotify.c          |   2 +-
 fs/notify/inotify/inotify_user.c              |   6 +-
 fs/notify/notification.c                      |  16 +-
 include/linux/fanotify.h                      |   9 +-
 include/linux/fsnotify.h                      |  20 +-
 include/linux/fsnotify_backend.h              |  76 ++++-
 include/uapi/linux/fanotify.h                 |   8 +
 samples/Kconfig                               |   9 +
 samples/Makefile                              |   1 +
 samples/fanotify/Makefile                     |   5 +
 samples/fanotify/fs-monitor.c                 | 138 +++++++++
 19 files changed, 803 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.32.0


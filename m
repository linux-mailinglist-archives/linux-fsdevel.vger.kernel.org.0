Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C1542E357
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhJNVjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhJNVjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:39:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1304C061570;
        Thu, 14 Oct 2021 14:37:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 57CC61F44F66;
        Thu, 14 Oct 2021 22:37:03 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Dave Chinner <david@fromorbit.com>
Subject: [PATCH v7 00/28] file system-wide error monitoring
Date:   Thu, 14 Oct 2021 18:36:18 -0300
Message-Id: <20211014213646.1139469-1-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This attempts to get the ball rolling again for the FAN_FS_ERROR.  This
version is slightly different from the previous approaches, since it uses
mempool for memory allocation, as suggested by Jan.  It has the
advantage of simplifying a lot the enqueue/dequeue, which is now much
more similar to other event types, but it also means the guarantee that
an error event will be available is diminished.

The way we propagate superblock errors also changed. Now we use
FILEID_ROOT internally, and mangle it prior to copy_to_user.

I am no longer sure how to guarantee that at least one mempoll slot will
be available for each filesystem.  Since we are now tying the poll to
the entire group, a stream of errors in a single file system might
prevent others from emitting an error.  The possibility of this is
reduced since we merge errors to the same filesystem, but it is still
possible that they occur during the small window where the event is
dequeued and before it is freed, in which case another filesystem might
not be able to obtain a slot.

I'm also creating a poll of 32 entries initially to avoid spending too
much memory.  This means that only 32 filesystems can be watched per
group with the FAN_FS_ERROR mark, before fanotify_mark starts returning
ENOMEM.

This was tested with LTP for regressions and also using the sample code
on the last patch, with a corrupted image.  I wrote a new ltp test for
this feature which is being reviewed and is available at:

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

Amir Goldstein (3):
  fsnotify: pass data_type to fsnotify_name()
  fsnotify: pass dentry instead of inode data
  fsnotify: clarify contract for create event hooks

Gabriel Krisman Bertazi (25):
  fsnotify: Don't insert unmergeable events in hashtable
  fanotify: Fold event size calculation to its own function
  fanotify: Split fsid check from other fid mode checks
  inotify: Don't force FS_IN_IGNORED
  fsnotify: Add helper to detect overflow_event
  fsnotify: Add wrapper around fsnotify_add_event
  fsnotify: Retrieve super block from the data field
  fsnotify: Pass group argument to free_event
  fanotify: Support null inode event in fanotify_dfid_inode
  fanotify: Allow file handle encoding for unhashed events
  fanotify: Encode empty file handle when no inode is provided
  fanotify: Require fid_mode for any non-fd event
  fsnotify: Support FS_ERROR event type
  fanotify: Reserve UAPI bits for FAN_FS_ERROR
  fanotify: Pre-allocate pool of error events
  fanotify: Limit number of marks with FAN_FS_ERROR per group
  fanotify: Support enqueueing of error events
  fanotify: Support merging of error events
  fanotify: Report FID entry even for zero-length file_handle
  fanotify: Report fid info for file related file system errors
  fanotify: Emit generic error info for error event
  fanotify: Allow users to request FAN_FS_ERROR events
  ext4: Send notifications on error
  samples: Add fs error monitoring example
  docs: Document the FAN_FS_ERROR event

 .../admin-guide/filesystem-monitoring.rst     |  76 ++++++++
 Documentation/admin-guide/index.rst           |   1 +
 fs/ext4/super.c                               |   8 +
 fs/notify/fanotify/fanotify.c                 | 122 +++++++++++-
 fs/notify/fanotify/fanotify.h                 |  31 +++-
 fs/notify/fanotify/fanotify_user.c            | 173 ++++++++++++++----
 fs/notify/fsnotify.c                          |   7 +-
 fs/notify/group.c                             |   2 +-
 fs/notify/inotify/inotify_fsnotify.c          |   5 +-
 fs/notify/inotify/inotify_user.c              |   6 +-
 fs/notify/notification.c                      |  14 +-
 include/linux/fanotify.h                      |   9 +-
 include/linux/fsnotify.h                      |  58 ++++--
 include/linux/fsnotify_backend.h              |  96 +++++++++-
 include/uapi/linux/fanotify.h                 |   8 +
 kernel/audit_fsnotify.c                       |   3 +-
 kernel/audit_watch.c                          |   3 +-
 samples/Kconfig                               |   9 +
 samples/Makefile                              |   1 +
 samples/fanotify/Makefile                     |   5 +
 samples/fanotify/fs-monitor.c                 | 142 ++++++++++++++
 21 files changed, 685 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.33.0


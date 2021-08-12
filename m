Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394343EAC77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbhHLVk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbhHLVkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:40:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0CC061756;
        Thu, 12 Aug 2021 14:40:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7D0B91F441E9
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 00/21] File system wide monitoring
Date:   Thu, 12 Aug 2021 17:39:49 -0400
Message-Id: <20210812214010.3197279-1-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is the 6th version of the FAN_FS_ERROR patches.  This applies
the feedback from last version (thanks Amir, Jan).

There are important changes in this version. some of which brings us
back to previous versions of this series.  I did my best to avoid
problems that were mentioned during earlier revisions, and I think I
covered everything. But I apologize if this requires reviewers to repeat
some comments.

First of all, despite initializing the error event from inside the
insert callback and abusing the merge logic for err_count update, this
version reverts to a simple insertion code, and configures the event
before sending it to be queued by fsnotify.  This makes the submission
code less trivial, but addresses the potential problem of encoding the
FH while holding the group->notification_lock.

This version also drops the slot replacement code when dequeueing, and
reverts back to the copy-to-stack mechanism.  This simplifies the code a
lot.

The way we report superblock errors also changed.  Now, the handle is
omitted and we return the handle_bytes as 0.

Finally, we no longer play games with predicting the file handle size
beforehand.  Now, the code just allocates space for the largest handle
possible, and assume that is enough.

On another note, this also restores the mark reference owned by the
error event while it is queued.  As Amir explained, this is required to
prevent the mark from going away while the event is queued.

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

Gabriel Krisman Bertazi (21):
  fsnotify: Don't insert unmergeable events in hashtable
  fanotify: Fold event size calculation to its own function
  fanotify: Split fsid check from other fid mode checks
  fsnotify: Reserve mark flag bits for backends
  fanotify: Split superblock marks out to a new cache
  inotify: Don't force FS_IN_IGNORED
  fsnotify: Add helper to detect overflow_event
  fsnotify: Add wrapper around fsnotify_add_event
  fsnotify: Allow events reported with an empty inode
  fsnotify: Support FS_ERROR event type
  fanotify: Allow file handle encoding for unhashed events
  fanotify: Encode invalid file handle when no inode is provided
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
 fs/notify/fanotify/fanotify.c                 | 139 +++++++++-
 fs/notify/fanotify/fanotify.h                 |  69 ++++-
 fs/notify/fanotify/fanotify_user.c            | 256 ++++++++++++++----
 fs/notify/fsnotify.c                          |  19 +-
 fs/notify/inotify/inotify_fsnotify.c          |   2 +-
 fs/notify/inotify/inotify_user.c              |   6 +-
 fs/notify/notification.c                      |  12 +-
 include/linux/fanotify.h                      |   9 +-
 include/linux/fsnotify.h                      |  13 +
 include/linux/fsnotify_backend.h              |  64 ++++-
 include/uapi/linux/fanotify.h                 |   8 +
 samples/Kconfig                               |   9 +
 samples/Makefile                              |   1 +
 samples/fanotify/Makefile                     |   5 +
 samples/fanotify/fs-monitor.c                 | 138 ++++++++++
 18 files changed, 740 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.32.0


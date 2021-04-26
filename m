Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9029636B928
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhDZSnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbhDZSnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2018C061574;
        Mon, 26 Apr 2021 11:42:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B0C611F41E07
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 00/15] File system wide monitoring
Date:   Mon, 26 Apr 2021 14:41:46 -0400
Message-Id: <20210426184201.4177978-1-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

In an attempt to consolidate some of the feedback from the previous
proposals, I wrote a new attempt to solve the file system error reporting
problem.  Before I spend more time polishing it, I'd like to hear your
feedback if I'm going in the wrong direction, in particular with the
modifications to fsnotify.

This RFC follows up on my previous proposals which attempted to leverage
watch_queue[1] and fsnotify[2] to provide a mechanism for file systems
to push error notifications to user space.  This proposal starts by, as
suggested by Darrick, limiting the scope of what I'm trying to do to an
interface for administrators to monitor the health of a file system,
instead of a generic inteface for file errors.  Therefore, this doesn't
solve the problem of writeback errors or the need to watch a specific
subsystem.

* Format

The feature is implemented on top of fanotify, as a new type of fanotify
mark, FAN_ERROR, which a file system monitoring tool can register to
receive notifications.  A notification is split in three parts, and only
the first is guaranteed to exist for any given error event:

 - FS generic data: A file system agnostic structure that has a generic
 error code and identifies the filesystem.  Basically, it let's
 userspace know something happen on a monitored filesystem.

 - FS location data: Identifies where in the code the problem
 happened. (This is important for the use case of analysing frequent
 error points that we discussed earlier).

 - FS specific data: A detailed error report in a filesystem specific
 format that details what the error is.  Ideally, a capable monitoring
 tool can use the information here for error recovery.  For instance,
 xfs can put the xfs_scrub structures here, ext4 can send its error
 reports, etc.  An example of usage is done in the ext4 patch of this
 series.

More details on the information in each record can be found on the
documentation introduced in patch 15.

* Using fanotify

Using fanotify for this kind of thing is slightly tricky because we want
to guarantee delivery in some complicated conditions, for instance, the
file system might want to send an error while holding several locks.

Instead of working around file system constraints at the file system
level, this proposal tries to make the FAN_ERROR submission safe in
those contexts.  This is done with a new mode in fsnotify that
preallocates the memory at group creation to be used for the
notification submission.

This new mode in fsnotify introduces a ring buffer to queue
notifications, which eliminates the allocation path in fsnotify.  From
what I saw, the allocation is the only problem in fsnotify for
filesystems to submit errors in constrained situations.

* Visibility

Since the usecase is limited to a tool for whole file system monitoring,
errors are associated with the superblock and visible filesystem-wide.
It is assumed and required that userspace has CAP_SYS_ADMIN.

* Testing

This was tested with corrupted ext4 images in a few scenarios, which
caused errors to be triggered and monitored with the sample tool
provided in the next to final patch.

* patches

Patches 1-4 massage fanotify attempt to refactor fanotify a bit for
the patches to come.  Patch 5 introduce the ring buffer interface to
fsnotify, while patch 6 enable this support in fanotify.  Patch 7, 8 wire
the FS_ERROR event type, which will be used by filesystems.  In
sequennce, patches 9-12 implement the FAN_ERROR record types and create
the new event.  Patch 13 is an ext4 example implementation supporting
this feature.  Finally, patches 14 and 15 document and provide examples
of a userspace tool that uses this feature.

I also pushed the full series to:

  https://gitlab.collabora.com/krisman/linux -b fanotify-notifications

[1] https://lwn.net/Articles/839310/
[2] https://www.spinics.net/lists/linux-fsdevel/msg187075.html

Gabriel Krisman Bertazi (15):
  fanotify: Fold event size calculation to its own function
  fanotify: Split fsid check from other fid mode checks
  fsnotify: Wire flags field on group allocation
  fsnotify: Wire up group information on event initialization
  fsnotify: Support event submission through ring buffer
  fanotify: Support submission through ring buffer
  fsnotify: Support FS_ERROR event type
  fsnotify: Introduce helpers to send error_events
  fanotify: Introduce generic error record
  fanotify: Introduce code location record
  fanotify: Introduce filesystem specific data record
  fanotify: Introduce the FAN_ERROR mark
  ext4: Send notifications on error
  samples: Add fs error monitoring example
  Documentation: Document the FAN_ERROR framework

 .../admin-guide/filesystem-monitoring.rst     | 103 ++++++
 Documentation/admin-guide/index.rst           |   1 +
 fs/ext4/super.c                               |  60 +++-
 fs/notify/Makefile                            |   2 +-
 fs/notify/dnotify/dnotify.c                   |   2 +-
 fs/notify/fanotify/fanotify.c                 | 127 +++++--
 fs/notify/fanotify/fanotify.h                 |  35 +-
 fs/notify/fanotify/fanotify_user.c            | 319 ++++++++++++++----
 fs/notify/fsnotify.c                          |   2 +-
 fs/notify/group.c                             |  25 +-
 fs/notify/inotify/inotify_fsnotify.c          |   2 +-
 fs/notify/inotify/inotify_user.c              |   4 +-
 fs/notify/notification.c                      |  10 +
 fs/notify/ring.c                              | 199 +++++++++++
 include/linux/fanotify.h                      |  12 +-
 include/linux/fsnotify.h                      |  15 +
 include/linux/fsnotify_backend.h              |  63 +++-
 include/uapi/linux/ext4-notify.h              |  17 +
 include/uapi/linux/fanotify.h                 |  26 ++
 kernel/audit_fsnotify.c                       |   2 +-
 kernel/audit_tree.c                           |   2 +-
 kernel/audit_watch.c                          |   2 +-
 samples/Kconfig                               |   7 +
 samples/Makefile                              |   1 +
 samples/fanotify/Makefile                     |   3 +
 samples/fanotify/fs-monitor.c                 | 135 ++++++++
 26 files changed, 1034 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
 create mode 100644 fs/notify/ring.c
 create mode 100644 include/uapi/linux/ext4-notify.h
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.31.0


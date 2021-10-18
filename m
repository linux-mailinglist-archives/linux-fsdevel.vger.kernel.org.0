Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E259B432A97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhJSACj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSACi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:02:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E17C06161C;
        Mon, 18 Oct 2021 17:00:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5962E1F41A9C;
        Tue, 19 Oct 2021 01:00:24 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 00/32] file system-wide error monitoring
Date:   Mon, 18 Oct 2021 20:59:43 -0300
Message-Id: <20211019000015.1666608-1-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is the 8th version of this patch series.  We are getting close!
Thank you Amir and Jan for your repeated assistance in getting this in
shape.  This version applies all your feedback from previous version, in
particular, it has a resizeable mempool, such that we don't waste to
much space if not needed.

This was tested with LTP for regressions and also using the sample code
on the last patch, with a corrupted image.  I wrote a new ltp test for
this feature which is being reviewed and is available at:

  https://gitlab.collabora.com/krisman/ltp  -b fan-fs-error

In addition, I wrote a man-page that can be pulled from:

  https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error

And is being reviewed at the list.

I also pushed this full series to:

  https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-v8

Thank you

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

Gabriel Krisman Bertazi (29):
  fsnotify: Don't insert unmergeable events in hashtable
  fanotify: Fold event size calculation to its own function
  fanotify: Split fsid check from other fid mode checks
  inotify: Don't force FS_IN_IGNORED
  fsnotify: Add helper to detect overflow_event
  fsnotify: Add wrapper around fsnotify_add_event
  fsnotify: Retrieve super block from the data field
  fsnotify: Protect fsnotify_handle_inode_event from no-inode events
  fsnotify: Pass group argument to free_event
  fanotify: Support null inode event in fanotify_dfid_inode
  fanotify: Allow file handle encoding for unhashed events
  fanotify: Encode empty file handle when no inode is provided
  fanotify: Require fid_mode for any non-fd event
  fsnotify: Support FS_ERROR event type
  fanotify: Reserve UAPI bits for FAN_FS_ERROR
  fanotify: Pre-allocate pool of error events
  fanotify: Dynamically resize the FAN_FS_ERROR pool
  fanotify: Support enqueueing of error events
  fanotify: Support merging of error events
  fanotify: Wrap object_fh inline space in a creator macro
  fanotify: Add helpers to decide whether to report FID/DFID
  fanotify: Report fid entry even for zero-length file_handle
  fanotify: WARN_ON against too large file handles
  fanotify: Report fid info for file related file system errors
  fanotify: Emit generic error info for error event
  fanotify: Allow users to request FAN_FS_ERROR events
  ext4: Send notifications on error
  samples: Add fs error monitoring example
  docs: Document the FAN_FS_ERROR event

 .../admin-guide/filesystem-monitoring.rst     |  76 ++++++++
 Documentation/admin-guide/index.rst           |   1 +
 fs/ext4/super.c                               |   8 +
 fs/notify/fanotify/fanotify.c                 | 116 +++++++++++-
 fs/notify/fanotify/fanotify.h                 |  60 +++++-
 fs/notify/fanotify/fanotify_user.c            | 172 ++++++++++++++----
 fs/notify/fsnotify.c                          |  10 +-
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
 samples/fanotify/fs-monitor.c                 | 142 +++++++++++++++
 21 files changed, 705 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

-- 
2.33.0


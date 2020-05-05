Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29691C5D51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgEEQUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbgEEQUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:20:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D4FC061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 09:20:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so2959525wmb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6TzAOBWWwqsbBXCjafLP2an/PhS60lundPWCqLj6zO8=;
        b=rvRKFBU7hatLcWtNkbsNrxmrGtk3WzDbapIwlxBqXS1fbg0zuqZ34gd0uvFsfYzOpc
         CeR5aJ7o8+Wb+F3hUp3nE92ClMMN2DYJ/MhwQvfqRVfo7hR2nOlL0TuiqkjDPROWGeVD
         rqgNObHA18iwzFLLZ1i3FoZd7e08+u/xPRVNKkBijf9hkzFg3l00SwVvGMF8TbxAVXma
         mbntUT4qehe/i1gay/Ds58H8QO5cogX24+IlwFNFwyzcpFGvyIBGCb//GBOUshdoma9f
         h2wGxb2Su5vJ0UHzADW70/egE0Kl7SYn3T2IvRX3+XWHi8IhP3jk/PD/4+dzN2mr5o5I
         k+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6TzAOBWWwqsbBXCjafLP2an/PhS60lundPWCqLj6zO8=;
        b=jYwbpZmMAI1aIwk/zmar0b1k887S64mVNJAqKHoND3LD933EgjuPDd35+sCGM7IB6l
         FZnyxKSbVyQUX4Ux+ylRi1QvMuSPB5N3x3Yz9Q+9rxvYcuMklPbrdf2Y3fJrWqsY3ox/
         rtW1GzIJYN8V717WvlsModdAJcNO1jrIkeW/GE1kZJassaSe2Vicekwr6QJf9pmvxMFp
         FgSPXL7v6LXQPkAyhXyUlaPxDV4uRz9YaIm+A47D/hTnQitLiuhGQ8dzCNNTnx9TP9X6
         u3igLfNkAh9DBtQFFmG85PE7jQnrQ4a+Dp+5hv1gUkWhxW/KI3ChWyMzsvjLqUQDSDzj
         UwPA==
X-Gm-Message-State: AGi0PubxO+PshoEBqSwQXOf1kM9n83xxU1gQ59OoFoH/OV6vKURHqLft
        eVDOlczTpnunsscQT9SCIQY=
X-Google-Smtp-Source: APiQypKkGp3JhQgBn5krgMR+SoZnkXQ000DS71PiHATXCUQGH2tkHPbM80xFQ++97NIW0UwVzD8ktw==
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr4585355wmn.154.1588695630610;
        Tue, 05 May 2020 09:20:30 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id c128sm1612871wma.42.2020.05.05.09.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:20:30 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 6/7] fsnotify: send event "on child" to sb/mount marks
Date:   Tue,  5 May 2020 19:20:13 +0300
Message-Id: <20200505162014.10352-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505162014.10352-1-amir73il@gmail.com>
References: <20200505162014.10352-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to events "on child" to watching directory, send event flavor
"on child" to sb/mount marks that specified interest in this flavor.
Event "on child" will not be sent on "orphan" children, that is, on
disconnected dentries and on a mount/sb root.

Currently, fanotify allows to set the FAN_EVENT_ON_CHILD flag on
sb/mount marks, but it was ignored.  Mask the flag explicitly until
fanotify implements support for events "on child" with name info
for sb/mount marks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c |  7 ++++--
 fs/notify/fsnotify.c               | 38 ++++++++++++++++++++++++------
 include/linux/fsnotify_backend.h   | 23 ++++++++++++------
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 030534da49e2..36c1327b32f4 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1146,10 +1146,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	/* inode held in place by reference to path; group by fget on fd */
-	if (mark_type == FAN_MARK_INODE)
+	if (mark_type == FAN_MARK_INODE) {
 		inode = path.dentry->d_inode;
-	else
+	} else {
 		mnt = path.mnt;
+		/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount marks */
+		mask &= ~FAN_EVENT_ON_CHILD;
+	}
 
 	/* create/update an inode mark */
 	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE)) {
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 72d332ce8e12..f6da8f263bc0 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -142,23 +142,50 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
-/* Notify this dentry's parent about a child's events. */
+/*
+ * Notify this dentry's parent about a child's events if parent is watching
+ * children or if sb/mount marks are interested in events with file_name info.
+ */
 int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		    int data_type)
 {
+	const struct path *path = fsnotify_data_path(data, data_type);
+	struct mount *mnt = NULL;
+	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
+	__u32 test_mask = mask & FS_EVENTS_POSS_ON_CHILD;
+	__u32 p_mask, marks_mask = 0;
 	struct dentry *parent;
 	struct inode *p_inode;
 	int ret = 0;
 
-	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
+	if (path && path->mnt->mnt_root != dentry)
+		mnt = real_mount(path->mnt);
+
+	/*
+	 * FS_EVENT_ON_CHILD on sb/mount mask implies reporting events as if all
+	 * directories are watched.
+	 */
+	if (!IS_ROOT(dentry))
+		marks_mask |= fsnotify_watches_children(
+						dentry->d_sb->s_fsnotify_mask);
+	if (mnt)
+		marks_mask |= fsnotify_watches_children(
+						mnt->mnt_fsnotify_mask);
+
+
+	if (!(marks_mask & test_mask) && !parent_watched)
 		return 0;
 
 	parent = dget_parent(dentry);
 	p_inode = parent->d_inode;
+	p_mask = fsnotify_inode_watches_children(p_inode);
 
-	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
+	if (p_mask)
+		marks_mask |= p_mask;
+	else if (unlikely(parent_watched))
 		__fsnotify_update_child_dentry_flags(p_inode);
-	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
+
+	if (marks_mask & test_mask) {
 		struct name_snapshot name;
 
 		/* we are notifying a parent so come up with the new mask which
@@ -323,9 +350,6 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 		mnt = real_mount(path->mnt);
 		mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
 	}
-	/* An event "on child" is not intended for a mount/sb mark */
-	if (mask & FS_EVENT_ON_CHILD)
-		mnt_or_sb_mask = 0;
 
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index f0c506405b54..ca461b95662a 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -50,8 +50,12 @@
 #define FS_DIR_MODIFY		0x00080000	/* Directory entry was modified */
 
 #define FS_EXCL_UNLINK		0x04000000	/* do not send events if object is unlinked */
-/* This inode cares about things that happen to its children.  Always set for
- * dnotify and inotify. */
+/*
+ * This inode cares about things that happen to its children.
+ * Always set for dnotify and inotify.
+ * Set on sb/mount marks mask to indicate interest in getting events with
+ * file_name information.
+ */
 #define FS_EVENT_ON_CHILD	0x08000000
 
 #define FS_DN_RENAME		0x10000000	/* file renamed */
@@ -386,14 +390,19 @@ extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
 extern u32 fsnotify_get_cookie(void);
 
-static inline int fsnotify_inode_watches_children(struct inode *inode)
+static inline __u32 fsnotify_watches_children(__u32 mask)
 {
-	/* FS_EVENT_ON_CHILD is set if the inode may care */
-	if (!(inode->i_fsnotify_mask & FS_EVENT_ON_CHILD))
+	/* FS_EVENT_ON_CHILD is set if the object may care */
+	if (!(mask & FS_EVENT_ON_CHILD))
 		return 0;
-	/* this inode might care about child events, does it care about the
+	/* This object might care about child events, does it care about the
 	 * specific set of events that can happen on a child? */
-	return inode->i_fsnotify_mask & FS_EVENTS_POSS_ON_CHILD;
+	return mask & FS_EVENTS_POSS_ON_CHILD;
+}
+
+static inline int fsnotify_inode_watches_children(struct inode *inode)
+{
+	return fsnotify_watches_children(inode->i_fsnotify_mask);
 }
 
 /*
-- 
2.17.1


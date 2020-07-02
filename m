Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD442123EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgGBM6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgGBM6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:58:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3535EC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:58:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so26659731wmh.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9UHJj/S5foceGTwbj6h1USWZWxZvtgWU32uTWxvz3Qs=;
        b=oHqRV9nWiQqEuA2XG6lG45EzZShIsf9uqYxtZAuPJ67b5fZyJFClzUSqQcA2Ly5fR9
         ohQ1TOcgwNJ1/Cb6NQOpd2JcOSm4N3s4djlQv06bO/d+kjTrqEOlKKPmR6mztApsnSwc
         grj1664TpIpSLAWSpx/RMifwD5Q0rOuOmxUpgVctLOrYCqMTeTx+1Ow0h6+pmfHRevjC
         mQK/OKOcap3v9MUO9/WvT6f478yezv6xCyx5NuhCypCk54LuYeCs3YE7WoEr/Il5giip
         zUvG/6NFOEzTFWiqAHeP6zzV/PPQb+j2ZYz+o7GSgomdMhxlUW9Vjbc3hQom/GWRgKWL
         DJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9UHJj/S5foceGTwbj6h1USWZWxZvtgWU32uTWxvz3Qs=;
        b=CCs7UQ4/fA2EaT9TBJeBmTNd5br0ZYpmlfg6dO4UF97utNdL4HQDmDSZrBg63T+Pl0
         HcAwH0Z80+2iAwE0A0/YDl3nbeeJC2xJpNjM5dpG+o61SZpsMn7xkj5iUmbZNmXoaLIT
         m62gfnjsTGY/JWvZsfShikYwQhkzWp9CEep+8v8ZS051Cp9UYqLKw841dgyXnnHLiBwI
         OT+dp5Mp/OF/vn2Uo6CA31pAePdMuPqvt5a/Uary8BHC4ci+MAiu7OxvYRj53vDE8Z2f
         sG3nKtpSTao/sKr0yrwsROGQ8gHgtGZyA1UM/YKnF9i69Fr7VhegW6HeAdNMWdv76uXz
         8Bsw==
X-Gm-Message-State: AOAM533LZ4CrpmClYcCabq2Yulx4rLOJ9AEGCz0n2N6Kwv0Woqig05NO
        uVNB871tWbV7XBPaBUn2ag4=
X-Google-Smtp-Source: ABdhPJwxLRl8PbDYzK0aM7z/zjchrObkAm48cTwL3fHDxR+X/h01HaT6KnWn4FH9L1hMHiUjs++E1A==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr33146316wmj.39.1593694678896;
        Thu, 02 Jul 2020 05:57:58 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:57:58 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 03/10] fsnotify: send event to parent and child with single callback
Date:   Thu,  2 Jul 2020 15:57:37 +0300
Message-Id: <20200702125744.10535-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of calling fsnotify() twice, once with parent inode and once
with child inode, if event should be sent to parent inode, send it
with both parent and child inodes marks in object type iterator and call
the backend handle_event() callback only once.

The parent inode is assigned to the standard "inode" iterator type and
the child inode is assigned to the special "child" iterator type.

In that case, the bit FS_EVENT_ON_CHILD will be set in the event mask,
the dir argment to handle_event will be the parent inode, the file_name
argument to handle_event is non NULL and refers to the name of the child
and the child inode can be accessed with fsnotify_data_inode().

This will allow fanotify to make decisions based on child or parent's
ignored mask.  For example, when a parent is interested in a specific
event on its children, but a specific child wishes to ignore this event,
the event will not be reported.  This is not what happens with current
code, but according to man page, it is the expected behavior.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/kernfs/file.c     | 10 ++++++----
 fs/notify/fsnotify.c | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e23b3f62483c..5b1468bc509e 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -883,6 +883,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
+		struct inode *p_inode = NULL;
 		struct inode *inode;
 		struct qstr name;
 
@@ -899,8 +900,6 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		name = (struct qstr)QSTR_INIT(kn->name, strlen(kn->name));
 		parent = kernfs_get_parent(kn);
 		if (parent) {
-			struct inode *p_inode;
-
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
 			if (p_inode) {
 				fsnotify(p_inode, FS_MODIFY | FS_EVENT_ON_CHILD,
@@ -911,8 +910,11 @@ static void kernfs_notify_workfn(struct work_struct *work)
 			kernfs_put(parent);
 		}
 
-		fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
-			 NULL, 0);
+		if (!p_inode) {
+			fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
+				 NULL, 0);
+		}
+
 		iput(inode);
 	}
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 51ada3cfd2ff..7c6e624b24c9 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -145,15 +145,17 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching.
- * Notify also the child without name info if child inode is watching.
+ * Notify only the child without name info if parent is not watching.
  */
 int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		      int data_type)
 {
+	struct inode *inode = d_inode(dentry);
 	struct dentry *parent;
 	struct inode *p_inode;
 	int ret = 0;
 
+	parent = NULL;
 	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
 		goto notify_child;
 
@@ -165,23 +167,23 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
 		struct name_snapshot name;
 
-		/*
-		 * We are notifying a parent, so set a flag in mask to inform
-		 * backend that event has information about a child entry.
-		 */
+		/* When notifying parent, child should be passed as data */
+		WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
+
+		/* Notify both parent and child with child name info */
 		take_dentry_name_snapshot(&name, dentry);
 		ret = fsnotify(p_inode, mask | FS_EVENT_ON_CHILD, data,
 			       data_type, &name.name, 0);
 		release_dentry_name_snapshot(&name);
+	} else {
+notify_child:
+		/* Notify child without child name info */
+		ret = fsnotify(inode, mask, data, data_type, NULL, 0);
 	}
 
 	dput(parent);
 
-	if (ret)
-		return ret;
-
-notify_child:
-	return fsnotify(d_inode(dentry), mask, data, data_type, NULL, 0);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__fsnotify_parent);
 
@@ -322,12 +324,16 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	struct super_block *sb = to_tell->i_sb;
 	struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
 	struct mount *mnt = NULL;
+	struct inode *child = NULL;
 	int ret = 0;
 	__u32 test_mask, marks_mask;
 
 	if (path)
 		mnt = real_mount(path->mnt);
 
+	if (mask & FS_EVENT_ON_CHILD)
+		child = fsnotify_data_inode(data, data_type);
+
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
 	 * be expensive.  It protects walking the *_fsnotify_marks lists.
@@ -336,21 +342,23 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	 * need SRCU to keep them "alive".
 	 */
 	if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
-	    (!mnt || !mnt->mnt_fsnotify_marks))
+	    (!mnt || !mnt->mnt_fsnotify_marks) &&
+	    (!child || !child->i_fsnotify_marks))
 		return 0;
 
 	/* An event "on child" is not intended for a mount/sb mark */
 	marks_mask = to_tell->i_fsnotify_mask;
-	if (!(mask & FS_EVENT_ON_CHILD)) {
+	if (!child) {
 		marks_mask |= sb->s_fsnotify_mask;
 		if (mnt)
 			marks_mask |= mnt->mnt_fsnotify_mask;
+	} else {
+		marks_mask |= child->i_fsnotify_mask;
 	}
 
 	/*
 	 * if this is a modify event we may need to clear the ignored masks
-	 * otherwise return if neither the inode nor the vfsmount/sb care about
-	 * this type of event.
+	 * otherwise return if none of the marks care about this type of event.
 	 */
 	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
 	if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
@@ -366,6 +374,10 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
 			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
 	}
+	if (child) {
+		iter_info.marks[FSNOTIFY_OBJ_TYPE_CHILD] =
+			fsnotify_first_mark(&child->i_fsnotify_marks);
+	}
 
 	/*
 	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
-- 
2.17.1


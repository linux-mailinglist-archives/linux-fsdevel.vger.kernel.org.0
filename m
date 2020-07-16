Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6D221EB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgGPIm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgGPIm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B84C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so9439568wmj.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ryWTy56nYN5vBtgba5aR4ZZLUrWs457fZRBboLlVPZg=;
        b=XIRYvUJTB1obQ70tszU7lVIh/oSMjMD5ZGIRRmJh5km3do38zfLFlD2xk75Qv8D/73
         coymZYx8tueR/UETMPj9ggUQAfPbq6eWXGuYpso70zUlPDrV2oiHspPC4WlWRYGCF//0
         Q2gQmEIqzTHzT4qJKPtEzLeq3KyQgifHPHgrugTf97zZ+5wvRSbjQxkW0iZS81ttj6Z3
         oD0MWhLDl3AIEooTFyzKtQW4EcT8sLQvWVfPcEFxKnSAPFNSw0CK80ZODnMA3o51zKdn
         976o7t7p2UVbCjROS7uqpVStXyfD09NzFaIWOmnW5x8gIGSlhLgnpIUhUlAcd0PVztEs
         jRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ryWTy56nYN5vBtgba5aR4ZZLUrWs457fZRBboLlVPZg=;
        b=dIl/r16syNSTGX+N4yWLLYOEtMLKFC1qFTJ+lRCVyqsvulkje/Mw91wUJrGHu8KmBn
         YB1hSwyCQFrJyz5yBOLYwyC4bzxdKyJUYlYRk9SA92zZ8gHzFJ1w9urcb2ZKeuydHMUi
         9VTUVZWRL2MoXI+fzJsk0Iq1ezwuQvryDpt5KUdjNf/+aiLnPfxPtidTiHFftukMT33b
         0HIItvLXkiY3QkP6LBjlG6yxroIFPoN5ufsa8zCmmj2w/AsnSnKXUwH4rDb4Bdwbmgr0
         eOzqGst00BaooMiZrclj16f3XMiMAlR9UzchCQEDXGdjQGJhMkw+z5ngZUjEfTO974iJ
         Ow7A==
X-Gm-Message-State: AOAM531qJSA9LazfUE1k/X2/CKrXSoEf4DV5MTEp3KXFfSDbVQavs52B
        66Ytz6SPJswvQnMJKd9Qiwetoe4Q
X-Google-Smtp-Source: ABdhPJzoi+DKQG38jmIfCEbdwg8dnHsOf4VOEKU/RCTKj6+R4YCjdK8hULqiRP9xHR9/Z9I8XxpCeQ==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr3264965wmk.175.1594888976210;
        Thu, 16 Jul 2020 01:42:56 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:55 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 14/22] fsnotify: send event to parent and child with single callback
Date:   Thu, 16 Jul 2020 11:42:22 +0300
Message-Id: <20200716084230.30611-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
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
 fs/kernfs/file.c     | 10 +++++---
 fs/notify/fsnotify.c | 60 ++++++++++++++++++++++++++------------------
 2 files changed, 41 insertions(+), 29 deletions(-)

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
index 51ada3cfd2ff..7120c675e9a6 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -145,17 +145,21 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
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
+	struct name_snapshot name;
+	struct qstr *file_name = NULL;
 	int ret = 0;
 
+	parent = NULL;
 	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
-		goto notify_child;
+		goto notify;
 
 	parent = dget_parent(dentry);
 	p_inode = parent->d_inode;
@@ -163,25 +167,24 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
 		__fsnotify_update_child_dentry_flags(p_inode);
 	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
-		struct name_snapshot name;
+		/* When notifying parent, child should be passed as data */
+		WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
 
-		/*
-		 * We are notifying a parent, so set a flag in mask to inform
-		 * backend that event has information about a child entry.
-		 */
+		/* Notify both parent and child with child name info */
+		inode = p_inode;
 		take_dentry_name_snapshot(&name, dentry);
-		ret = fsnotify(p_inode, mask | FS_EVENT_ON_CHILD, data,
-			       data_type, &name.name, 0);
-		release_dentry_name_snapshot(&name);
+		file_name = &name.name;
+		mask |= FS_EVENT_ON_CHILD;
 	}
 
-	dput(parent);
+notify:
+	ret = fsnotify(inode, mask, data, data_type, file_name, 0);
 
-	if (ret)
-		return ret;
+	if (file_name)
+		release_dentry_name_snapshot(&name);
+	dput(parent);
 
-notify_child:
-	return fsnotify(d_inode(dentry), mask, data, data_type, NULL, 0);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__fsnotify_parent);
 
@@ -322,12 +325,16 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
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
@@ -336,21 +343,20 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
 	 * need SRCU to keep them "alive".
 	 */
 	if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
-	    (!mnt || !mnt->mnt_fsnotify_marks))
+	    (!mnt || !mnt->mnt_fsnotify_marks) &&
+	    (!child || !child->i_fsnotify_marks))
 		return 0;
 
-	/* An event "on child" is not intended for a mount/sb mark */
-	marks_mask = to_tell->i_fsnotify_mask;
-	if (!(mask & FS_EVENT_ON_CHILD)) {
-		marks_mask |= sb->s_fsnotify_mask;
-		if (mnt)
-			marks_mask |= mnt->mnt_fsnotify_mask;
-	}
+	marks_mask = to_tell->i_fsnotify_mask | sb->s_fsnotify_mask;
+	if (mnt)
+		marks_mask |= mnt->mnt_fsnotify_mask;
+	if (child)
+		marks_mask |= child->i_fsnotify_mask;
+
 
 	/*
 	 * if this is a modify event we may need to clear the ignored masks
-	 * otherwise return if neither the inode nor the vfsmount/sb care about
-	 * this type of event.
+	 * otherwise return if none of the marks care about this type of event.
 	 */
 	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
 	if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
@@ -366,6 +372,10 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
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


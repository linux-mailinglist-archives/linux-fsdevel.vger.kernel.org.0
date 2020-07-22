Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D822298CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbgGVM7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732295AbgGVM7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D887AC0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so1922460wmo.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mq4lMGMMRabdtLMbjK6o4L3vb3t6wnKYpHTiwhaTctk=;
        b=LVx/0Bhu7coOa1v5ZMIyZkn3IjHhWCD9xitZW14b5Jke3AzjcN5a6VNMRmshv+EH8J
         tMvAXshJQChlBMT1Neq4gKGwas+YV3KluuhxRg0sFgvF4hMlM88hpaGKOol8h4vu4BJk
         fFM3DEseQ+un/Y/lzUtf6ZJOdZevUHy8j2NEd4z0wukvsF4tVBo9j3AUN7OrrpJzdzw+
         7oSSBNTuphYh0fqp1+FDkYd6R+707vVpI9+2QOiV7JQcbssE96ZiRhNK5JXmu38SOaV3
         Hz7uMTlLjlDxd+TwPPoYc/uBoaQ2PYV5bvvcqX20XVvEgPfq2lc8KOlYjPBt5XLZ2oQV
         fNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mq4lMGMMRabdtLMbjK6o4L3vb3t6wnKYpHTiwhaTctk=;
        b=PqIvoNPU1yC3kkGRL6l618kJM8+qtMu7ypkKKOsKPoNtYXFtqEeFxJghWF56R2BAMN
         /w0lF6jDagJFq0vqAOcFwt+SRSolu8/K825djTDxKagkXPeQ/UJpyupGMH8bVOtT9cCj
         S7dtfTXNJyU/Pb0RkGZcWpbfQufN1MOZ2jACJVIL0Arpr7iEzm6qnPc5VSLUbjjQ9KI8
         6qqNFeXT7z6P3yRD/NRWN8pzI3nwb5P29VPNz9nEonqq0WX7PSU5j4Eu+a9FmLCH36sn
         maNqGRo9xM8ATjo6Z4Mti+s1jT6Adw/0ZzRxmhZNoLLzM4p+F5Coaxs6i3A1X5EiQGtl
         6chw==
X-Gm-Message-State: AOAM530ddzwx9cOXNQqatydtSWwwHTxbT4XwYCSK78d6VdLTdsrOy/oA
        AGk4UyFa1OYfK78QB3fYGfc=
X-Google-Smtp-Source: ABdhPJxmUsElyoKjdxjszpYO9J0AsB8J5TPz4gPENxsenHHOHmDqZtFFepMc6nHqLxCdzOC9JscqWg==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr8094290wml.114.1595422747601;
        Wed, 22 Jul 2020 05:59:07 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:07 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/9] fsnotify: create helper fsnotify_inode()
Date:   Wed, 22 Jul 2020 15:58:44 +0300
Message-Id: <20200722125849.17418-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
References: <20200722125849.17418-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simple helper to consolidate biolerplate code.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/kernfs/file.c         |  6 ++----
 fs/notify/fsnotify.c     |  2 +-
 include/linux/fsnotify.h | 26 +++++++++++---------------
 kernel/trace/trace.c     |  3 +--
 4 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 5b1468bc509e..1d185bffc52f 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -910,10 +910,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
 			kernfs_put(parent);
 		}
 
-		if (!p_inode) {
-			fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
-				 NULL, 0);
-		}
+		if (!p_inode)
+			fsnotify_inode(inode, FS_MODIFY);
 
 		iput(inode);
 	}
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index efa5c1c4908a..277af3d5efce 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -74,7 +74,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 			iput(iput_inode);
 
 		/* for each watch, send FS_UNMOUNT and then remove it */
-		fsnotify(inode, FS_UNMOUNT, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+		fsnotify_inode(inode, FS_UNMOUNT);
 
 		fsnotify_inode_delete(inode);
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index fe4f2bc5b4c2..01b71ad91339 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -38,6 +38,14 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
 }
 
+static inline void fsnotify_inode(struct inode *inode, __u32 mask)
+{
+	if (S_ISDIR(inode->i_mode))
+		mask |= FS_ISDIR;
+
+	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+}
+
 /* Notify this dentry's parent about a child's events. */
 static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 				  const void *data, int data_type)
@@ -111,12 +119,7 @@ static inline int fsnotify_perm(struct file *file, int mask)
  */
 static inline void fsnotify_link_count(struct inode *inode)
 {
-	__u32 mask = FS_ATTRIB;
-
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
-
-	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_inode(inode, FS_ATTRIB);
 }
 
 /*
@@ -131,7 +134,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	u32 fs_cookie = fsnotify_get_cookie();
 	__u32 old_dir_mask = FS_MOVED_FROM;
 	__u32 new_dir_mask = FS_MOVED_TO;
-	__u32 mask = FS_MOVE_SELF;
 	const struct qstr *new_name = &moved->d_name;
 
 	if (old_dir == new_dir)
@@ -140,7 +142,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	if (isdir) {
 		old_dir_mask |= FS_ISDIR;
 		new_dir_mask |= FS_ISDIR;
-		mask |= FS_ISDIR;
 	}
 
 	fsnotify_name(old_dir, old_dir_mask, source, old_name, fs_cookie);
@@ -149,7 +150,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	if (target)
 		fsnotify_link_count(target);
 
-	fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_inode(source, FS_MOVE_SELF);
 	audit_inode_child(new_dir, moved, AUDIT_TYPE_CHILD_CREATE);
 }
 
@@ -174,12 +175,7 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
  */
 static inline void fsnotify_inoderemove(struct inode *inode)
 {
-	__u32 mask = FS_DELETE_SELF;
-
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
-
-	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_inode(inode, FS_DELETE_SELF);
 	__fsnotify_inode_delete(inode);
 }
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb62269724d5..0c655c039506 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1543,8 +1543,7 @@ static void latency_fsnotify_workfn(struct work_struct *work)
 {
 	struct trace_array *tr = container_of(work, struct trace_array,
 					      fsnotify_work);
-	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
-		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_inode(tr->d_max_latency->d_inode, FS_MODIFY);
 }
 
 static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
-- 
2.17.1


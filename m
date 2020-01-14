Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E95413AD54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 16:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgANPRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 10:17:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46930 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANPRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:17:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so12497751wrl.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 07:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMdGC8h/b+0RUp5I4s67e3K7+OCIWfuzPBvZkge9vGs=;
        b=mlH+/4voyFo5BPKOtmGs5yk8e8YbvLhAxRotr+XFsKagwVsiUvxV+zucOvOhCmXvia
         UnVSK9Q2CzkBUwOxkpHTDObIXcKT8Cxy6nKwvZAc9ij6p7b9WSVSBXPGVWQi7DbdLWhR
         YteLZTTNqlymv9Z5vzMYPLeky038tMMOu2di88JUHk4V/MEZoyQfcfWP143icXfjy6dD
         8sjYx/0qzxrSZ3EwRD6pEP0wHN1vDr1H/BO91Tkx7nCjY61Hi2U8zCK0bbmXXQqBM+C4
         ewWzIj6ThLCNdHqV84f5ccsIESPEyfZ9o9/w9dZ0gQWc+PyBoJsubM5iebWXFIxkMYBx
         +DZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LMdGC8h/b+0RUp5I4s67e3K7+OCIWfuzPBvZkge9vGs=;
        b=BFY3txvUerPs7Tfwap4WaFqBgfEUzmj/yrmkUUnx9a4nVZEKOV23wgU/ueSgaHWjBI
         gKIPKjK+HDM5UaMPigZ2c4R79ohD/gAfS/PFWZHbXxWXQtLiFWQEJGp9FZzHg8Agr8HR
         nRbgYmznelSsq60kYgkhF2P0cqKiISvwauB8hygEbE0L0vuyZqXSK8B+QodpYTMd48tX
         Z0jXEqclLiWDvfBgSapZ/KASdHWmxppubW7t+iabEdipdi3bk9btufJvMyCAmcRReu7n
         lTLYWNB0GHIFt3Uf9OVk/FrNDz5VVVbmqiSaNaUjHRsK5oqg98fsr+q1Xg2PUkZ0M0hT
         ecFg==
X-Gm-Message-State: APjAAAVVy4cWufiYdjOVJnzXbeBoYQPMfO2xiOpb7yzvlhKs6OCbDbvS
        WrMSMWNDJXEgHuYGbTftLb8=
X-Google-Smtp-Source: APXvYqz5ZOVjGkDmyOV5pXPF0HQNZP8/yvx63hyGBgg/F6p+hCdZcwrRqs6URuI93TxdSvbGUH4ObQ==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr25214447wrp.292.1579015025307;
        Tue, 14 Jan 2020 07:17:05 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s19sm18276993wmj.33.2020.01.14.07.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:17:04 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/6] fsnotify: simplify arguments passing to fsnotify_parent()
Date:   Tue, 14 Jan 2020 17:16:52 +0200
Message-Id: <20200114151655.29473-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114151655.29473-1-amir73il@gmail.com>
References: <20200114151655.29473-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of passing both dentry and path and having to figure out which
one to use, use the data/data_type convention to simplify the code.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 21 ++++++++++-----------
 include/linux/fsnotify.h         | 14 ++------------
 include/linux/fsnotify_backend.h | 12 ++++++------
 3 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 13578372aee8..a8b281569bbf 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -143,14 +143,18 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 }
 
 /* Notify this dentry's parent about a child's events. */
-int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask)
+int fsnotify_parent(__u32 mask, const void *data, int data_type)
 {
-	struct dentry *parent;
+	struct dentry *parent, *dentry;
 	struct inode *p_inode;
 	int ret = 0;
 
-	if (!dentry)
-		dentry = path->dentry;
+	if (data_type == FSNOTIFY_EVENT_DENTRY)
+		dentry = (struct dentry *)data;
+	else if (data_type == FSNOTIFY_EVENT_PATH)
+		dentry = ((struct path *)data)->dentry;
+	else
+		return 0;
 
 	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
 		return 0;
@@ -168,12 +172,7 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
 		mask |= FS_EVENT_ON_CHILD;
 
 		take_dentry_name_snapshot(&name, dentry);
-		if (path)
-			ret = fsnotify(p_inode, mask, path, FSNOTIFY_EVENT_PATH,
-				       &name.name, 0);
-		else
-			ret = fsnotify(p_inode, mask, dentry,
-				       FSNOTIFY_EVENT_DENTRY, &name.name, 0);
+		ret = fsnotify(p_inode, mask, data, data_type, &name.name, 0);
 		release_dentry_name_snapshot(&name);
 	}
 
@@ -181,7 +180,7 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__fsnotify_parent);
+EXPORT_SYMBOL_GPL(fsnotify_parent);
 
 static int send_to_group(struct inode *to_tell,
 			 __u32 mask, const void *data,
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 5746420bb121..dfdc8a1a3c38 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -30,30 +30,20 @@ static inline int fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 			&dentry->d_name, 0);
 }
 
-/* Notify this dentry's parent about a child's events. */
-static inline int fsnotify_parent(const struct path *path,
-				  struct dentry *dentry, __u32 mask)
-{
-	if (!dentry)
-		dentry = path->dentry;
-
-	return __fsnotify_parent(path, dentry, mask);
-}
-
 /*
  * Simple wrappers to consolidate calls fsnotify_parent()/fsnotify() when
  * an event is on a path/dentry.
  */
 static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 {
-	fsnotify_parent(NULL, dentry, mask);
+	fsnotify_parent(mask, dentry, FSNOTIFY_EVENT_DENTRY);
 	fsnotify(d_inode(dentry), mask, dentry, FSNOTIFY_EVENT_DENTRY, NULL, 0);
 }
 
 static inline int fsnotify_path(struct inode *inode, const struct path *path,
 				__u32 mask)
 {
-	int ret = fsnotify_parent(path, NULL, mask);
+	int ret = fsnotify_parent(mask, path, FSNOTIFY_EVENT_PATH);
 
 	if (ret)
 		return ret;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index cb47759b1ce9..77edd866926f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -351,9 +351,9 @@ struct fsnotify_mark {
 /* called from the vfs helpers */
 
 /* main fsnotify call to send events */
-extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
-		    const struct qstr *name, u32 cookie);
-extern int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask);
+extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
+		    int data_type, const struct qstr *name, u32 cookie);
+extern int fsnotify_parent(__u32 mask, const void *data, int data_type);
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
@@ -508,13 +508,13 @@ static inline void fsnotify_init_event(struct fsnotify_event *event,
 
 #else
 
-static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
-			   const struct qstr *name, u32 cookie)
+static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
+			   int data_type, const struct qstr *name, u32 cookie)
 {
 	return 0;
 }
 
-static inline int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask)
+static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)
 {
 	return 0;
 }
-- 
2.17.1


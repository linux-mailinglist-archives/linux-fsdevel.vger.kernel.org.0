Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857A918BAA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCSPKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33580 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCSPKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so3507084wrd.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/7jTCSsyzZWwp7yRyA/w3XAM2WGW6qSw6oXjdg2EIwQ=;
        b=ncXdvxKew51HtZWn9kntNCK9nGdh+R2FXx6ZOX7e7OwwEobe6rjJ8B0H/pBOE/W2WD
         eSJqg4WeVCc8cwNOwUVAY0fP+GVHX4tz4EE2sq67QDD65U/Jjq364LDihJh8126tHnYo
         prsu+VCWw7PrKRjZuhxFyW2DGpmrqu4MOezKAbq5x/fEn00AnKbrEO1REyxJbo0kNcYU
         fBf57g22YaPmxyKAomPxgxEfJt/+626OWHul+tEioaqJZFP3iPDpNlkD6a3ap87q2oMl
         52kdQPTmu9kAe5xDvcoGeOjAp0SQCyzCyULm3JtWyJNew+3gXIy2BQJGpW6VGCL5SLHH
         MF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/7jTCSsyzZWwp7yRyA/w3XAM2WGW6qSw6oXjdg2EIwQ=;
        b=OqCHUsLj0zeFiNj2OdoRYkvxT/f8rR+1sv07ZRyRnBcI37kmc7Tegry1U+SixMowgu
         wKNXrUgXlHxFzr1vns97BSPmgRGAoc/Ghz1eHi32WK1DCn7kjbQYEC4rSepQshSnndCZ
         7jVHpWLuwUcotWY8/Y/skD3kf39qg9rN/brdUWsfFlluIcI2ibV02TzY6y4MKd/JSbYY
         PweSv4JKhSPA00qFSAkovyz8c0uNPPOtVu/S43w0l66b+fMwWIODRzHXHzxLUmj3f+jc
         2RoD1rwWRjUQpmflZ7AS3a+Hkah5LbxZjwctuzJW5ms738r6fyX7C0BzM2WPZ98soZyP
         PugQ==
X-Gm-Message-State: ANhLgQ1RxOuN0tk6ahbOHxlQS+P6S3dmLL9VPOaIJMFeC1YRUmtOu6Ub
        mEtzGh/PmD1JkWZV48LbToDLS8FF
X-Google-Smtp-Source: ADFU+vsoKD179LvBz4+QCZEnnozAS3NWitgcD663gu3DCcWOfh7tuDY6grbY/KTFo5lFDd/OjKUQow==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr5172762wrl.38.1584630643810;
        Thu, 19 Mar 2020 08:10:43 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:43 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 05/14] fsnotify: simplify arguments passing to fsnotify_parent()
Date:   Thu, 19 Mar 2020 17:10:13 +0200
Message-Id: <20200319151022.31456-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of passing both dentry and path and having to figure out which
one to use, pass data/data_type to simplify the code.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 15 ++++-----------
 include/linux/fsnotify.h         | 14 ++------------
 include/linux/fsnotify_backend.h | 14 ++++++++------
 3 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index a5d6467f89a0..193530f57963 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -143,15 +143,13 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 }
 
 /* Notify this dentry's parent about a child's events. */
-int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask)
+int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
+		    int data_type)
 {
 	struct dentry *parent;
 	struct inode *p_inode;
 	int ret = 0;
 
-	if (!dentry)
-		dentry = path->dentry;
-
 	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
 		return 0;
 
@@ -168,12 +166,7 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
 		mask |= FS_EVENT_ON_CHILD;
 
 		take_dentry_name_snapshot(&name, dentry);
-		if (path)
-			ret = fsnotify(p_inode, mask, path, FSNOTIFY_EVENT_PATH,
-				       &name.name, 0);
-		else
-			ret = fsnotify(p_inode, mask, dentry->d_inode, FSNOTIFY_EVENT_INODE,
-				       &name.name, 0);
+		ret = fsnotify(p_inode, mask, data, data_type, &name.name, 0);
 		release_dentry_name_snapshot(&name);
 	}
 
@@ -181,7 +174,7 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__fsnotify_parent);
+EXPORT_SYMBOL_GPL(fsnotify_parent);
 
 static int send_to_group(struct inode *to_tell,
 			 __u32 mask, const void *data,
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 751da17e003d..860018f3e545 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -38,16 +38,6 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
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
  * an event is on a file/dentry.
@@ -59,7 +49,7 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	fsnotify_parent(NULL, dentry, mask);
+	fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
 	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
 }
 
@@ -75,7 +65,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	ret = fsnotify_parent(path, NULL, mask);
+	ret = fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 5cc838db422a..337c87cf34d6 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -376,9 +376,10 @@ struct fsnotify_mark {
 /* called from the vfs helpers */
 
 /* main fsnotify call to send events */
-extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
-		    const struct qstr *name, u32 cookie);
-extern int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask);
+extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
+		    int data_type, const struct qstr *name, u32 cookie);
+extern int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
+			   int data_type);
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
@@ -533,13 +534,14 @@ static inline void fsnotify_init_event(struct fsnotify_event *event,
 
 #else
 
-static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
-			   const struct qstr *name, u32 cookie)
+static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
+			   int data_type, const struct qstr *name, u32 cookie)
 {
 	return 0;
 }
 
-static inline int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask)
+static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
+				  const void *data, int data_type)
 {
 	return 0;
 }
-- 
2.17.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CEC1612F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgBQNPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54267 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgBQNPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10so17114350wmh.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YEwTGL2sezTfgqALhHfJLmjkjavhlZLO+UQi7Telv5I=;
        b=WP/vQDISp7WSJR0qPlTGzbUn6Ozv9NRlcmSfRfJJjRZ6dV4Qgti8yP18Arvmhxib2I
         wCeDRFIvxaYeYEfWBVEK2Wt/Z2s4Y5Lvcu0e10cI8XbpABYnme9lH07SOUTZFm1QKxAk
         ACNYHbjps4/roUEszUFPNWa6/ueJqegYbvQeK4w86jQPVdsn3j3SOwZNvwMFS1sphIhZ
         mfVUm5fJ9f+jGk05Sq+GamVu8wSKk12YxFaWg/ISlC0zzt5qSyBeWvwtYMwq05yDezQq
         oilOxuzPnAjuMXBKmZYVv86crIyoEDOZGG7v5ULalHgEYcKFRa8z5EGh97wzg379VX8J
         vrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YEwTGL2sezTfgqALhHfJLmjkjavhlZLO+UQi7Telv5I=;
        b=akw3nqJf8NRCBOhzC470H8KmiB7kXjJUrmILjc8hKrnO/MEbc+pahGTfCynyRcPc1J
         L3TZqqPHDK2Qjqp2ISLF9FDFa3Z70yGcxmZzBkn9BOtro0LjYqN7Myzj3BUuqY/Xm3Qj
         ZINltfhOxZH8Lm+DWZIhd+qBIoTCS6x2yKQipdNSb3h7yjGK0ds4u9UMMpJDIrJlnNua
         /ySeNsoh17qMEqyg2ib+6Me9VYb/oJHzHsldtGtjIyV6+G1ALZb9ypLXooPWcHt1t7Bk
         fw/1mu+0/SCGpAOb3UxUOnDJx8sbucp+BkY60kGJ7B+1EHLcaUX5RmLSC9zLDICONRPd
         BJiA==
X-Gm-Message-State: APjAAAWOn0Vqtc5+PoBwgTfXPDZ2E27l7vVJkSxrGuuv01CyGi+joOIs
        yzabe3XT1AqEtss8J5tom7P6TqA7
X-Google-Smtp-Source: APXvYqwcjFBdoa2iVt7DGl6DOgd6Q1jol6/1v1ZFfW+uX5ni+L2QfdKwKR1o7zQ2DU9sKqHSWSdKRQ==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr23605147wmj.117.1581945313213;
        Mon, 17 Feb 2020 05:15:13 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:12 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/16] fsnotify: simplify arguments passing to fsnotify_parent()
Date:   Mon, 17 Feb 2020 15:14:44 +0200
Message-Id: <20200217131455.31107-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
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
 include/linux/fsnotify_backend.h | 13 +++++++------
 3 files changed, 13 insertions(+), 29 deletions(-)

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
index 420aca9fd5f4..af30e0a56f2e 100644
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
index 5cc838db422a..b1f418cc28e1 100644
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
@@ -533,13 +534,13 @@ static inline void fsnotify_init_event(struct fsnotify_event *event,
 
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578B21612F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgBQNPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54259 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgBQNPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so17114155wmh.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWzfkGCr9PabkdnGvHygX5uWAudDgb/h4qPwf2CBTII=;
        b=ZE09DfMrf3qs8HBz6k/1g698JKrsxpTC5SQcfOsV0rZBypdM0nFYs7dQfapbhgoMyd
         FvCpNKJMF58rD9pr2X6y0RGQi6ncEr2qwp2uYWykDGRXJ+xt+vhw/51hrq2MThA6hN9I
         /2Nm8kvxe/SPibuYx+XP2EudF2D9kgpjYe9wDDa0ByYFkmdfNd5vb//cS0fv17fxs/46
         1UhJb5B1AmCEpu8fEjIMTPZclSQ9VRogooEN0EA9E+zs6ulLn0iEJtVZCBfNM30gc19S
         aqxIJJ8H7KU8RjXDZUVhcPR8sqBcCEaAqbX8iy5eEXR5ObHuQSqH2v2TpFZ3nhArmvQV
         5GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OWzfkGCr9PabkdnGvHygX5uWAudDgb/h4qPwf2CBTII=;
        b=Ilbc6rQYdIZPcN/II3e2VATgZV+n9xI0K8xSnwMWHQ7KLQiaIlXGLDknzAh9Ys3CDx
         OdXMR0BtGMQgAqgHBSp0irjf087u8nbJOVfM4Q0V96Yw5oauj/BTPOegM6IMVvykURDY
         dvxlVwHzdBW27GiIWz/Kldvdwxsqx9hjBjqAoavTQuen9NeOCroll6LggajGOHe89z9R
         cRTEyEk5Q0L/mkEtFTmme8KzJ5hWZzoTeOIbI5zfGOcq1Rl0c5soCf/Q9U5RFm/jsAEE
         WLBoT/m4mKeHxacyE02xbZ1+8J+taTr2tbuG9VmJxpx6LxQO+rRX4aMh6AKdcWViA5KX
         t1ZA==
X-Gm-Message-State: APjAAAVozPUtTkO0ZbrvYtyXw0fuBTCtI8Qkv9hu1nVu2NnsO8lRj9/I
        SeiyScrVwl3bEDbseyUCjeA=
X-Google-Smtp-Source: APXvYqzVGHPN1W/8dWacRgeXa+WSaKbWHwTAbylHj9uUhpB5XBFfuGjHuAwsLdjYVK81zV+1B2c2hg==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr22567290wmb.150.1581945309607;
        Mon, 17 Feb 2020 05:15:09 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:09 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/16] fsnotify: factor helpers fsnotify_dentry() and fsnotify_file()
Date:   Mon, 17 Feb 2020 15:14:41 +0200
Message-Id: <20200217131455.31107-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most of the code in fsnotify hooks is boiler plate of one or the other.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 96 +++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 60 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index a2d5d175d3c1..a87d4ab98da7 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -41,16 +41,36 @@ static inline int fsnotify_parent(const struct path *path,
 }
 
 /*
- * Simple wrapper to consolidate calls fsnotify_parent()/fsnotify() when
- * an event is on a path.
+ * Simple wrappers to consolidate calls fsnotify_parent()/fsnotify() when
+ * an event is on a file/dentry.
  */
-static inline int fsnotify_path(struct inode *inode, const struct path *path,
-				__u32 mask)
+static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 {
-	int ret = fsnotify_parent(path, NULL, mask);
+	struct inode *inode = d_inode(dentry);
 
+	if (S_ISDIR(inode->i_mode))
+		mask |= FS_ISDIR;
+
+	fsnotify_parent(NULL, dentry, mask);
+	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+}
+
+static inline int fsnotify_file(struct file *file, __u32 mask)
+{
+	const struct path *path = &file->f_path;
+	struct inode *inode = file_inode(file);
+	int ret;
+
+	if (file->f_mode & FMODE_NONOTIFY)
+		return 0;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= FS_ISDIR;
+
+	ret = fsnotify_parent(path, NULL, mask);
 	if (ret)
 		return ret;
+
 	return fsnotify(inode, mask, path, FSNOTIFY_EVENT_PATH, NULL, 0);
 }
 
@@ -58,8 +78,6 @@ static inline int fsnotify_path(struct inode *inode, const struct path *path,
 static inline int fsnotify_perm(struct file *file, int mask)
 {
 	int ret;
-	const struct path *path = &file->f_path;
-	struct inode *inode = file_inode(file);
 	__u32 fsnotify_mask = 0;
 
 	if (file->f_mode & FMODE_NONOTIFY)
@@ -70,7 +88,7 @@ static inline int fsnotify_perm(struct file *file, int mask)
 		fsnotify_mask = FS_OPEN_PERM;
 
 		if (file->f_flags & __FMODE_EXEC) {
-			ret = fsnotify_path(inode, path, FS_OPEN_EXEC_PERM);
+			ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
 
 			if (ret)
 				return ret;
@@ -79,10 +97,7 @@ static inline int fsnotify_perm(struct file *file, int mask)
 		fsnotify_mask = FS_ACCESS_PERM;
 	}
 
-	if (S_ISDIR(inode->i_mode))
-		fsnotify_mask |= FS_ISDIR;
-
-	return fsnotify_path(inode, path, fsnotify_mask);
+	return fsnotify_file(file, fsnotify_mask);
 }
 
 /*
@@ -229,15 +244,7 @@ static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
  */
 static inline void fsnotify_access(struct file *file)
 {
-	const struct path *path = &file->f_path;
-	struct inode *inode = file_inode(file);
-	__u32 mask = FS_ACCESS;
-
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
-
-	if (!(file->f_mode & FMODE_NONOTIFY))
-		fsnotify_path(inode, path, mask);
+	fsnotify_file(file, FS_ACCESS);
 }
 
 /*
@@ -245,15 +252,7 @@ static inline void fsnotify_access(struct file *file)
  */
 static inline void fsnotify_modify(struct file *file)
 {
-	const struct path *path = &file->f_path;
-	struct inode *inode = file_inode(file);
-	__u32 mask = FS_MODIFY;
-
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
-
-	if (!(file->f_mode & FMODE_NONOTIFY))
-		fsnotify_path(inode, path, mask);
+	fsnotify_file(file, FS_MODIFY);
 }
 
 /*
@@ -261,16 +260,12 @@ static inline void fsnotify_modify(struct file *file)
  */
 static inline void fsnotify_open(struct file *file)
 {
-	const struct path *path = &file->f_path;
-	struct inode *inode = file_inode(file);
 	__u32 mask = FS_OPEN;
 
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
 	if (file->f_flags & __FMODE_EXEC)
 		mask |= FS_OPEN_EXEC;
 
-	fsnotify_path(inode, path, mask);
+	fsnotify_file(file, mask);
 }
 
 /*
@@ -278,16 +273,10 @@ static inline void fsnotify_open(struct file *file)
  */
 static inline void fsnotify_close(struct file *file)
 {
-	const struct path *path = &file->f_path;
-	struct inode *inode = file_inode(file);
-	fmode_t mode = file->f_mode;
-	__u32 mask = (mode & FMODE_WRITE) ? FS_CLOSE_WRITE : FS_CLOSE_NOWRITE;
-
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
+	__u32 mask = (file->f_mode & FMODE_WRITE) ? FS_CLOSE_WRITE :
+						    FS_CLOSE_NOWRITE;
 
-	if (!(file->f_mode & FMODE_NONOTIFY))
-		fsnotify_path(inode, path, mask);
+	fsnotify_file(file, mask);
 }
 
 /*
@@ -295,14 +284,7 @@ static inline void fsnotify_close(struct file *file)
  */
 static inline void fsnotify_xattr(struct dentry *dentry)
 {
-	struct inode *inode = dentry->d_inode;
-	__u32 mask = FS_ATTRIB;
-
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
-
-	fsnotify_parent(NULL, dentry, mask);
-	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_dentry(dentry, FS_ATTRIB);
 }
 
 /*
@@ -311,7 +293,6 @@ static inline void fsnotify_xattr(struct dentry *dentry)
  */
 static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 {
-	struct inode *inode = dentry->d_inode;
 	__u32 mask = 0;
 
 	if (ia_valid & ATTR_UID)
@@ -332,13 +313,8 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 	if (ia_valid & ATTR_MODE)
 		mask |= FS_ATTRIB;
 
-	if (mask) {
-		if (S_ISDIR(inode->i_mode))
-			mask |= FS_ISDIR;
-
-		fsnotify_parent(NULL, dentry, mask);
-		fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
-	}
+	if (mask)
+		fsnotify_dentry(dentry, mask);
 }
 
 #endif	/* _LINUX_FS_NOTIFY_H */
-- 
2.17.1


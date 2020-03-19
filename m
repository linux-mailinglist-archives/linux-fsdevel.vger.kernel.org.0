Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06818BA9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCSPKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34876 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgCSPKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id m3so2715302wmi.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7txMGAZZZvw/5HVd0tg08nWoxYsIQi8ZzJMOkyog8c=;
        b=jkN0da8ZaBoRBkE8IZ2CXGEJQY9OwqyIyjJSBDXqmPwSLeFn5ljBmS9VaFma6EkOXl
         bO0+EApb2CA2DnoOyb1sRkiTK9ZXUnd2viw6SnZwZrGo21nOgwq4lpK6A3BohCPqDDTQ
         Ei8PojTUxas5B+eq5JHwRmYGU3inpjtbtTE8dyY9ZXp0J/47NcWTNmYwbCvmA4QhKF9P
         fZUrxgSyqBUVGrqisbWsgz9UqzzAFOv8E2Ro3+0ewPZQw1cm6Jp7aPlpBwq7AX+NWP5c
         Np8ONnvlReTB3TJhbxNmFHAJ2Ll5LHASp8IA7fq4gafrbmYDeZUPzn+FcJC9A0pH9cI1
         4YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q7txMGAZZZvw/5HVd0tg08nWoxYsIQi8ZzJMOkyog8c=;
        b=PNnAMyuTLL0oXlr8byilGb/fBPJ5COF4LVnuyEuhnr9vxwhXdEKoP0gwlVx7in1Lev
         ujrrXAt+yK8kdJarSVGPpNlRHnaT7jaa9fiGb+eMB+gABwNHNQkcG84O5yLdeypviYx4
         /T012xuGbzdW+QZvUCxfLi1tzcvmvVXFLNBQ1BKuYP7/mrYp0YG5TQshL4s3dNfdGiCF
         VnA25O2FxhXcSkNq8rNn0hl2S4TYHfRqpmLCbONKoBIgtovx9aqx2dfTuDyiEbvUcJN6
         VOE6ATCPnWLtqyDo5VAKi9SzhbFmCEnMH8f3MrDbJSk1NXTGuo1P3/kvXOl5TBcwG3Fy
         gpOA==
X-Gm-Message-State: ANhLgQ3IDPIqtvBerHUAa9xgq5NOT7RlKuJMnzN1g19DDemcdZ2iFqTE
        +a+c8oPvinlnloonaPwSAMHBRvDy
X-Google-Smtp-Source: ADFU+vsCa//1uAFz6oOxDe1foZnIaO3vRqDsqtIKVOcsb24o5H95uoQGVuikFq7mMdV7x/3gb3X57g==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr4212194wmi.120.1584630639118;
        Thu, 19 Mar 2020 08:10:39 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:38 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/14] fsnotify: factor helpers fsnotify_dentry() and fsnotify_file()
Date:   Thu, 19 Mar 2020 17:10:10 +0200
Message-Id: <20200319151022.31456-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most of the code in fsnotify hooks is boiler plate of one or the other.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 99 +++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 62 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index a2d5d175d3c1..f54936aa0365 100644
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
 
@@ -58,19 +78,16 @@ static inline int fsnotify_path(struct inode *inode, const struct path *path,
 static inline int fsnotify_perm(struct file *file, int mask)
 {
 	int ret;
-	const struct path *path = &file->f_path;
-	struct inode *inode = file_inode(file);
 	__u32 fsnotify_mask = 0;
 
-	if (file->f_mode & FMODE_NONOTIFY)
-		return 0;
 	if (!(mask & (MAY_READ | MAY_OPEN)))
 		return 0;
+
 	if (mask & MAY_OPEN) {
 		fsnotify_mask = FS_OPEN_PERM;
 
 		if (file->f_flags & __FMODE_EXEC) {
-			ret = fsnotify_path(inode, path, FS_OPEN_EXEC_PERM);
+			ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
 
 			if (ret)
 				return ret;
@@ -79,10 +96,7 @@ static inline int fsnotify_perm(struct file *file, int mask)
 		fsnotify_mask = FS_ACCESS_PERM;
 	}
 
-	if (S_ISDIR(inode->i_mode))
-		fsnotify_mask |= FS_ISDIR;
-
-	return fsnotify_path(inode, path, fsnotify_mask);
+	return fsnotify_file(file, fsnotify_mask);
 }
 
 /*
@@ -229,15 +243,7 @@ static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
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
@@ -245,15 +251,7 @@ static inline void fsnotify_access(struct file *file)
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
@@ -261,16 +259,12 @@ static inline void fsnotify_modify(struct file *file)
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
@@ -278,16 +272,10 @@ static inline void fsnotify_open(struct file *file)
  */
 static inline void fsnotify_close(struct file *file)
 {
-	const struct path *path = &file->f_path;
-	struct inode *inode = file_inode(file);
-	fmode_t mode = file->f_mode;
-	__u32 mask = (mode & FMODE_WRITE) ? FS_CLOSE_WRITE : FS_CLOSE_NOWRITE;
+	__u32 mask = (file->f_mode & FMODE_WRITE) ? FS_CLOSE_WRITE :
+						    FS_CLOSE_NOWRITE;
 
-	if (S_ISDIR(inode->i_mode))
-		mask |= FS_ISDIR;
-
-	if (!(file->f_mode & FMODE_NONOTIFY))
-		fsnotify_path(inode, path, mask);
+	fsnotify_file(file, mask);
 }
 
 /*
@@ -295,14 +283,7 @@ static inline void fsnotify_close(struct file *file)
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
@@ -311,7 +292,6 @@ static inline void fsnotify_xattr(struct dentry *dentry)
  */
 static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 {
-	struct inode *inode = dentry->d_inode;
 	__u32 mask = 0;
 
 	if (ia_valid & ATTR_UID)
@@ -332,13 +312,8 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
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


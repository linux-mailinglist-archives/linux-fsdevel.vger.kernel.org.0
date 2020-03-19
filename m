Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9018BA9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCSPKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54341 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCSPKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id f130so1647324wmf.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ykQtzazlMMXyRropYxwlMaMqcnSkmw7/TA8y9MsBDPQ=;
        b=H8Mzl5Qe5Le74UGPXY64glF89/3Gli//nV9RmtppQkOU87kbP+HDQNppmW06svzfgm
         sJXqVsvkVxLY4aGczePo9eWOGNsJYl2H4KoghQEF28MyP1AemTcplKnn9YGzqIk0P47L
         a4ITwx5Dbl0Eh9HATOdJqY+Ip8DUVuJIHSoFDt3fZ8Av9ud8d+ftACI8MbxClcqyv94y
         TchMfaP9HQIEjVZS7CnhHNkQdSDwBOk3TP6mBnua4nA5FlaerIp3sT01Zf81GjERfJOL
         4w6/lbYpqKTILtOh2N4cJTONFb4Gt1ZpkOGVB71DDPBRkkRwY469f6G6B4l5MY2XZ0gb
         /4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ykQtzazlMMXyRropYxwlMaMqcnSkmw7/TA8y9MsBDPQ=;
        b=CrS9+ZhBKPYIA0iRVoTwliUjrQUfERkNV+E5p1PErVhlL4K843ymp99fMnLY9cQhfZ
         tZcfh9oJZ2TYGaBEaMU4x8oI7h2sg5XVaeEh3juIoaCIB9O95mz7MILi8I/257fyh4Lh
         jv7wZkSa9RUMbZ8DSmLOv6pXRj8EJeGFwtq2d2DSsZ7dJK/dmUgb17OZbublNF1+eEsf
         fYNVggivQmmsq2/j+CrT0BrDmqVWDUKVquXBtytpBQ0gqCbzrZJkWa8C8/YfKEuUOme7
         43h/PwQPcfqbMEBDnqXiR7iW19quHqZRqQjxSkfiAm/mgoHNeeSSggycmws9YumX77UT
         rO8w==
X-Gm-Message-State: ANhLgQ2gATbZV+stwDkJm7S8fQDZ2GYY8QAHbP+h6SwGqyaGhVRxYrtt
        J5vZC3YMIY/nTXRPBVH08lE=
X-Google-Smtp-Source: ADFU+vv0j+hqyQpU7zGIRpYieaP77GTWV1Zp8Owjlb3ukmz51rbNu/FCMVEUp4RtCIMiDmHJP1rhDw==
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr4192618wmj.94.1584630640468;
        Thu, 19 Mar 2020 08:10:40 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:39 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 03/14] fsnotify: funnel all dirent events through fsnotify_name()
Date:   Thu, 19 Mar 2020 17:10:11 +0200
Message-Id: <20200319151022.31456-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out fsnotify_name() from fsnotify_dirent(), so it can also serve
link and rename events and use this helper to report all directory entry
change events.

Both helpers return void because no caller checks their return value.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f54936aa0365..751da17e003d 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -18,16 +18,24 @@
 #include <linux/bug.h>
 
 /*
- * Notify this @dir inode about a change in the directory entry @dentry.
+ * Notify this @dir inode about a change in a child directory entry.
+ * The directory entry may have turned positive or negative or its inode may
+ * have changed (i.e. renamed over).
  *
  * Unlike fsnotify_parent(), the event will be reported regardless of the
  * FS_EVENT_ON_CHILD mask on the parent inode.
  */
-static inline int fsnotify_dirent(struct inode *dir, struct dentry *dentry,
-				  __u32 mask)
+static inline void fsnotify_name(struct inode *dir, __u32 mask,
+				 struct inode *child,
+				 const struct qstr *name, u32 cookie)
 {
-	return fsnotify(dir, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-			&dentry->d_name, 0);
+	fsnotify(dir, mask, child, FSNOTIFY_EVENT_INODE, name, cookie);
+}
+
+static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
+				   __u32 mask)
+{
+	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
 }
 
 /* Notify this dentry's parent about a child's events. */
@@ -136,10 +144,8 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 		mask |= FS_ISDIR;
 	}
 
-	fsnotify(old_dir, old_dir_mask, source, FSNOTIFY_EVENT_INODE, old_name,
-		 fs_cookie);
-	fsnotify(new_dir, new_dir_mask, source, FSNOTIFY_EVENT_INODE, new_name,
-		 fs_cookie);
+	fsnotify_name(old_dir, old_dir_mask, source, old_name, fs_cookie);
+	fsnotify_name(new_dir, new_dir_mask, source, new_name, fs_cookie);
 
 	if (target)
 		fsnotify_link_count(target);
@@ -194,12 +200,13 @@ static inline void fsnotify_create(struct inode *inode, struct dentry *dentry)
  * Note: We have to pass also the linked inode ptr as some filesystems leave
  *   new_dentry->d_inode NULL and instantiate inode pointer later
  */
-static inline void fsnotify_link(struct inode *dir, struct inode *inode, struct dentry *new_dentry)
+static inline void fsnotify_link(struct inode *dir, struct inode *inode,
+				 struct dentry *new_dentry)
 {
 	fsnotify_link_count(inode);
 	audit_inode_child(dir, new_dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	fsnotify(dir, FS_CREATE, inode, FSNOTIFY_EVENT_INODE, &new_dentry->d_name, 0);
+	fsnotify_name(dir, FS_CREATE, inode, &new_dentry->d_name, 0);
 }
 
 /*
-- 
2.17.1


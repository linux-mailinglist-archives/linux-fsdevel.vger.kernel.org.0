Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D262035C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfEPK07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:26:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34523 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPK07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:26:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so1360169wrt.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A0Dx9rFPmZQefRZr4daUw4n6bOKu6DHR/Y1PSc2RiRM=;
        b=NxIv7Ru/CPrQJspXqnkb8ea01W++OecOZSsF8ijZUtLoruRVUvoDUxXds4nJYCNW4h
         4DZtbXWvr9j+YA3s8dZR57YY0Fe1CNUQCzH4ibLAkRpYzJm4hrF5P3oJo03VGDpPa35w
         dlGYsKydq7Q1Sez1Dp2jhF+TjEjLVIxDWsN18eKzOdqu1il67fCwci39hopYin9WMq8s
         eId8AT+yXDg72pZJxLC3uBIsVve9ld/5dTGWg+eZzgAChSGoH9wc2BqVgF9prXKqHl+j
         gYkAaARDejAyQ4Y/OaBM+JwgmRKlSZfQvU/gOifGDFSugvIrwxLrmNZhUTAhzCkeqpeo
         dVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A0Dx9rFPmZQefRZr4daUw4n6bOKu6DHR/Y1PSc2RiRM=;
        b=Hrrx6pp9dli+WUTssOaF+dYbknM3sPI9F8DqSFtSI5uw6RGb0d1qYlx/sT9SGG1af1
         3gsGgxq1IJPeYXuqYW6+jyPXlJjWls9MqBrlVOwC+Rvgctf/Nvqiog2cMbEoBrik3tZG
         zgbkEoapKE3EvyImVQ66aix6IC+HA/n7hh1I6oH31CoHJkz+wvqSVE8nulp9dslW2kBF
         mg+hKW0XL+Sbc2/cWzON4gYtuPdw/KCSkRsf6dShcFp7W3iLkX0nGN0ATLSZgNLqQrdS
         H4TWvQrGIPRnE+j/suFZEfHaqefD0zHI4oVEorUHETPz3Xff3o975/Qpyd/P3EFYthOD
         0+Cw==
X-Gm-Message-State: APjAAAVHHbNJ8HatbDtxrWQUKAGWvNNOPjOeRqHy8kClvuPEclZpqiIa
        Ft9YPTMBdwtJAvX0jjWZ9MI=
X-Google-Smtp-Source: APXvYqw4TF5UwwX1u75F0wJCXhOzxPxESOc5yLPE9a1uOTEIpCdW9hvkNBOJzSEO/1xOcOPPVwM5kA==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr14804686wrm.151.1558002417463;
        Thu, 16 May 2019 03:26:57 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:26:56 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 03/14] fsnotify: add empty fsnotify_{unlink,rmdir}() hooks
Date:   Thu, 16 May 2019 13:26:30 +0300
Message-Id: <20190516102641.6574-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We would like to move fsnotify_nameremove() calls from d_delete()
into a higher layer where the hook makes more sense and so we can
consider every d_delete() call site individually.

Start by creating empty hook fsnotify_{unlink,rmdir}() and place
them in the proper VFS call sites.  After all d_delete() call sites
will be converted to use the new hook, the new hook will generate the
delete events and fsnotify_nameremove() hook will be removed.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/libfs.c               | 11 ++++++++---
 fs/namei.c               |  2 ++
 include/linux/fsnotify.h | 26 ++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ca1132f1d5c6..4db61ca8cc94 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -10,6 +10,7 @@
 #include <linux/cred.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
+#include <linux/fsnotify.h>
 #include <linux/quotaops.h>
 #include <linux/mutex.h>
 #include <linux/namei.h>
@@ -367,11 +368,15 @@ int simple_remove(struct inode *dir, struct dentry *dentry)
 	 * protect d_delete() from accessing a freed dentry.
 	 */
 	dget(dentry);
-	if (d_is_dir(dentry))
+	if (d_is_dir(dentry)) {
 		ret = simple_rmdir(dir, dentry);
-	else
+		if (!ret)
+			fsnotify_rmdir(dir, dentry);
+	} else {
 		ret = simple_unlink(dir, dentry);
-
+		if (!ret)
+			fsnotify_unlink(dir, dentry);
+	}
 	if (!ret)
 		d_delete(dentry);
 	dput(dentry);
diff --git a/fs/namei.c b/fs/namei.c
index 20831c2fbb34..209c51a5226c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3883,6 +3883,7 @@ int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 	dentry->d_inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
+	fsnotify_rmdir(dir, dentry);
 
 out:
 	inode_unlock(dentry->d_inode);
@@ -3999,6 +4000,7 @@ int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegate
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
+				fsnotify_unlink(dir, dentry);
 			}
 		}
 	}
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 94972e8eb6d1..7f23eddefcd0 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -188,6 +188,19 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode, struct
 	fsnotify(dir, FS_CREATE, inode, FSNOTIFY_EVENT_INODE, &new_dentry->d_name, 0);
 }
 
+/*
+ * fsnotify_unlink - 'name' was unlinked
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ */
+static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
+{
+	/* Expected to be called before d_delete() */
+	WARN_ON_ONCE(d_is_negative(dentry));
+
+	/* TODO: call fsnotify_dirent() */
+}
+
 /*
  * fsnotify_mkdir - directory 'name' was created
  */
@@ -198,6 +211,19 @@ static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
 	fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR);
 }
 
+/*
+ * fsnotify_rmdir - directory 'name' was removed
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ */
+static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	/* Expected to be called before d_delete() */
+	WARN_ON_ONCE(d_is_negative(dentry));
+
+	/* TODO: call fsnotify_dirent() */
+}
+
 /*
  * fsnotify_access - file was read
  */
-- 
2.17.1


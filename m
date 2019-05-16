Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7922C20367
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfEPK1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45101 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfEPK1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so2717035wrq.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9d358PysRh93Ovn290SWir3DJbBZNRuE7uqJqn8lz2E=;
        b=hUaK4FqIbIojd0muP1USNHmCUTxPOfCy8VGGkgL08PykDQ7qtvsgqUzsjkZJ9vAQ61
         phvvW0akXssZbsENnXZ1UvUGIyGkTDecvZ0V/OrplQwDcU7J+14/B2wLDiEiZ0FCrtws
         eSk7wsYuyH6xdzShAXdr9NpYqsTJhuaowo1CaA65LvQtORqyUTQE4Ga+uzvczuaed2mB
         Cqg6t6z1K0jwZBUylCR3P+J0qJQZyuHDVptoVk/mYH7hKO9AllBOHkGr3T/63XK4Ml5k
         ddFZZTs487xSU30Rnuu498UdaTW+JvGSIkCYyjMx8E4WhA71xo0b3g7DiFwgwkQUqjlQ
         a3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9d358PysRh93Ovn290SWir3DJbBZNRuE7uqJqn8lz2E=;
        b=gwuVjb07V0uZfrYPmbitEsdWTqCy9/rwRB1FKhvOZ43iAnaxlnmgwzWS9AxKnlHwdw
         0INPrUyIv72gt4pGGwAmY1W2OuqhuJnCgoLt3jLJksJJU/1VEU7mL0Q6V+5QT91ICl79
         zdWhIohdfI8QTQZsS3cyUU1OsxIm95rDJS8+qN/H4cUVmfFAs7wQWJ9m0F4i9PoOUrBf
         kNkN4zXCXNsaEaNCAJCUl5mAo2gOPn10j214SH+HLYXj0cxN3wAvMBA/aGST7crd+Izo
         NT5VkivkmuJNvdd/amv6Hm62j6n2qMk3fEfnox5wba3HUzwWNr2kchJORDvOhl2qrI7U
         jabA==
X-Gm-Message-State: APjAAAUtUkmiibZtYS380hnhFUb5KoO0mriSoJGJTP7wK7S45549pNWZ
        L9ZAM85vGKPT+YgjWCRB0MjmjAEM
X-Google-Smtp-Source: APXvYqxYA54IEFn5i/FfoNSyMO9P4zWYC4G1jFk53MdmfBLIK0Jd+vmPUEAyHa2ZXP2Fq1hVkEsecw==
X-Received: by 2002:adf:dc4a:: with SMTP id m10mr28625791wrj.0.1558002431194;
        Thu, 16 May 2019 03:27:11 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:27:10 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 14/14] fsnotify: get rid of fsnotify_nameremove()
Date:   Thu, 16 May 2019 13:26:41 +0300
Message-Id: <20190516102641.6574-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For all callers of fsnotify_{unlink,rmdir}(), we made sure that d_parent
and d_name are stable.  Therefore, fsnotify_{unlink,rmdir}() do not need
the safety measures in fsnotify_nameremove() to stabilize parent and name.
We can now simplify those hooks and get rid of fsnotify_nameremove().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 41 --------------------------------
 include/linux/fsnotify.h         |  6 ++---
 include/linux/fsnotify_backend.h |  4 ----
 3 files changed, 2 insertions(+), 49 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8c7cbac7183c..5433e37fb0c5 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -107,47 +107,6 @@ void fsnotify_sb_delete(struct super_block *sb)
 	fsnotify_clear_marks_by_sb(sb);
 }
 
-/*
- * fsnotify_nameremove - a filename was removed from a directory
- *
- * This is mostly called under parent vfs inode lock so name and
- * dentry->d_parent should be stable. However there are some corner cases where
- * inode lock is not held. So to be on the safe side and be reselient to future
- * callers and out of tree users of d_delete(), we do not assume that d_parent
- * and d_name are stable and we use dget_parent() and
- * take_dentry_name_snapshot() to grab stable references.
- */
-void fsnotify_nameremove(struct dentry *dentry, int isdir)
-{
-	struct dentry *parent;
-	struct name_snapshot name;
-	__u32 mask = FS_DELETE;
-
-	/* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
-	if (IS_ROOT(dentry))
-		return;
-
-	if (isdir)
-		mask |= FS_ISDIR;
-
-	parent = dget_parent(dentry);
-	/* Avoid unneeded take_dentry_name_snapshot() */
-	if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
-	    !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
-		goto out_dput;
-
-	take_dentry_name_snapshot(&name, dentry);
-
-	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-		 &name.name, 0);
-
-	release_dentry_name_snapshot(&name);
-
-out_dput:
-	dput(parent);
-}
-EXPORT_SYMBOL(fsnotify_nameremove);
-
 /*
  * Given an inode, first check if we care what happens to our children.  Inotify
  * and dnotify both tell their parents about events.  If we care about any event
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 0145073c2b42..a2d5d175d3c1 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -198,8 +198,7 @@ static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
 	/* Expected to be called before d_delete() */
 	WARN_ON_ONCE(d_is_negative(dentry));
 
-	/* TODO: call fsnotify_dirent() */
-	fsnotify_nameremove(dentry, 0);
+	fsnotify_dirent(dir, dentry, FS_DELETE);
 }
 
 /*
@@ -222,8 +221,7 @@ static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
 	/* Expected to be called before d_delete() */
 	WARN_ON_ONCE(d_is_negative(dentry));
 
-	/* TODO: call fsnotify_dirent() */
-	fsnotify_nameremove(dentry, 1);
+	fsnotify_dirent(dir, dentry, FS_DELETE | FS_ISDIR);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a9f9dcc1e515..c28f6ed1f59b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -355,7 +355,6 @@ extern int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
-extern void fsnotify_nameremove(struct dentry *dentry, int isdir);
 extern u32 fsnotify_get_cookie(void);
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
@@ -525,9 +524,6 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 static inline void fsnotify_sb_delete(struct super_block *sb)
 {}
 
-static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
-{}
-
 static inline void fsnotify_update_flags(struct dentry *dentry)
 {}
 
-- 
2.17.1


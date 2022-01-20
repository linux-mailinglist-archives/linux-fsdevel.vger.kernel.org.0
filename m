Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420AA495625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 22:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347592AbiATVxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 16:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377992AbiATVxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:53:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4BC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 13:53:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p18so14614813wmg.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 13:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owYBj3z3qtZIuCerjEhAIA2+Qt9amCwshWFa8kE1v/8=;
        b=p1XximwjKMNTxrSRh511H4+96wU4ZE8Y5Uc6138UYWGVSmydJhZo99sMhNbeasp1O3
         pq/+V6YxyF1OjlzhC/CLhM2/xtTkV3+8U2pucQOiklZxFgOqVITYNs8yuEHCs4/QWG6x
         /Z/5mmEfdK0XS93SubMncOBKxuLxQJUO/fFnp1XiIQ0KOjph/Zx9GUIoGzJskvpzAceU
         UJ3qsE3Uo06IT5ZnXsE8yONSnMDjcKuNuRficukL4p5VvftcCaFgFaiGPkZ/4y0sLH/J
         GeS0yxRIAbD59nh/mwuorghyHzT/HwctajgXNs+lOYLBf6ARXZ2GShcS4ChSK5i9Pc5m
         XG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owYBj3z3qtZIuCerjEhAIA2+Qt9amCwshWFa8kE1v/8=;
        b=K+7nHEHlYPIpvwaqlUsSrRztC1SGL+ow5cvp5S8A4qFKLYhIBxgbk5jFa1U/qCpORr
         Z+EbaElAhIFgb/MnQ0X/PGGkwHqaXByyhyJdc/T9O41xHGlEnW1NgRgBarvBOtdSnHGY
         8AL7wHSz3Teiro2MnFDP/5S71JykjFj36wet7LshOQ+5kxy/alZiVN1Jm6RXx1hW3Nf1
         VLB7bm5dXDN37uulmkeNQoo1wlSyt2Wu08W6tdCw8ZjZ/9OwNm2eqOfwBtqd1GRQW+/b
         RlscsSerC+7NCc4R8jdLee4ScjQCU60m7rvFs03WzmLdYaigT8VbI2HTPNY04D+BtpLo
         f70Q==
X-Gm-Message-State: AOAM530B3qqpetF8vsbN4ubdqy1S/OUmbIWS+ADKy5nLJ5/UZiqGqM5f
        njIiwk0SiySFWOWsc/umWMs=
X-Google-Smtp-Source: ABdhPJyPmKabZr4saWp986v+Mhx8Q0dGh51Z1XSRBZ+gc8i58TkA3YZTwlBOY45X59bfchIEEeeKRg==
X-Received: by 2002:a1c:1b97:: with SMTP id b145mr10834490wmb.181.1642715588040;
        Thu, 20 Jan 2022 13:53:08 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.153])
        by smtp.gmail.com with ESMTPSA id y8sm4839519wrd.8.2022.01.20.13.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:53:07 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Ivan Delalande <colona@arista.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] fsnotify: invalidate dcache before IN_DELETE event
Date:   Thu, 20 Jan 2022 23:53:04 +0200
Message-Id: <20220120215305.282577-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Apparently, there are some applications that use IN_DELETE event as an
invalidation mechanism and expect that if they try to open a file with
the name reported with the delete event, that it should not contain the
content of the deleted file.

Commit 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
d_delete()") moved the fsnotify delete hook before d_delete() so fsnotify
will have access to a positive dentry.

This allowed a race where opening the deleted file via cached dentry
is now possible after receiving the IN_DELETE event.

To fix the regression, create a new hook fsnotify_delete() that takes
the unlinked inode as an argument and use a helper d_delete_notify() to
pin the inode, so we can pass it to fsnotify_delete() after d_delete().

Backporting hint: this regression is from v5.3. Although patch will
apply with only trivial conflicts to v5.4 and v5.10, it won't build,
because fsnotify_delete() implementation is different in each of those
versions (see fsnotify_link()).

A follow up patch will fix the fsnotify_unlink/rmdir() calls in pseudo
filesystem that do not need to call d_delete().

Reported-by: Ivan Delalande <colona@arista.com>
Link: https://lore.kernel.org/linux-fsdevel/YeNyzoDM5hP5LtGW@visor/
Fixes: 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of d_delete()")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v1:
- Split patch for pseudo filesystem (Jan)
- Fix logic change for DCACHE_NFSFS_RENAMED (Jan)
- btrfs also needs d_delete_notify()
- Make fsnotify_unlink/rmdir() wrappers of fsnotify_delete()
- FS_DELETE event always uses FSNOTIFY_EVENT_INODE data_type


 fs/btrfs/ioctl.c         |  6 ++---
 fs/namei.c               | 10 ++++----
 include/linux/fsnotify.h | 49 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index edfecfe62b4b..a5ee6ffeadf5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3060,10 +3060,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	btrfs_inode_lock(inode, 0);
 	err = btrfs_delete_subvolume(dir, dentry);
 	btrfs_inode_unlock(inode, 0);
-	if (!err) {
-		fsnotify_rmdir(dir, dentry);
-		d_delete(dentry);
-	}
+	if (!err)
+		d_delete_notify(dir, dentry);
 
 out_dput:
 	dput(dentry);
diff --git a/fs/namei.c b/fs/namei.c
index 1f9d2187c765..3c0568d3155b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3973,13 +3973,12 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
 	dentry->d_inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
-	fsnotify_rmdir(dir, dentry);
 
 out:
 	inode_unlock(dentry->d_inode);
 	dput(dentry);
 	if (!error)
-		d_delete(dentry);
+		d_delete_notify(dir, dentry);
 	return error;
 }
 EXPORT_SYMBOL(vfs_rmdir);
@@ -4101,7 +4100,6 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
-				fsnotify_unlink(dir, dentry);
 			}
 		}
 	}
@@ -4109,9 +4107,11 @@ int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
 	inode_unlock(target);
 
 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
-	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
+	if (!error && dentry->d_flags & DCACHE_NFSFS_RENAMED) {
+		fsnotify_unlink(dir, dentry);
+	} else if (!error) {
 		fsnotify_link_count(target);
-		d_delete(dentry);
+		d_delete_notify(dir, dentry);
 	}
 
 	return error;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 3a2d7dc3c607..bb8467cd11ae 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -224,6 +224,43 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
 		      dir, &new_dentry->d_name, 0);
 }
 
+/*
+ * fsnotify_delete - @dentry was unlinked and unhashed
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ *
+ * Note: unlike fsnotify_unlink(), we have to pass also the unlinked inode
+ * as this may be called after d_delete() and old_dentry may be negative.
+ */
+static inline void fsnotify_delete(struct inode *dir, struct inode *inode,
+				   struct dentry *dentry)
+{
+	__u32 mask = FS_DELETE;
+
+	if (S_ISDIR(inode->i_mode))
+		mask |= FS_ISDIR;
+
+	fsnotify_name(mask, inode, FSNOTIFY_EVENT_INODE, dir, &dentry->d_name,
+		      0);
+}
+
+/**
+ * d_delete_notify - delete a dentry and call fsnotify_delete()
+ * @dentry: The dentry to delete
+ *
+ * This helper is used to guaranty that the unlinked inode cannot be found
+ * by lookup of this name after fsnotify_delete() event has been delivered.
+ */
+static inline void d_delete_notify(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+
+	ihold(inode);
+	d_delete(dentry);
+	fsnotify_delete(dir, inode, dentry);
+	iput(inode);
+}
+
 /*
  * fsnotify_unlink - 'name' was unlinked
  *
@@ -231,10 +268,10 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
  */
 static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
 {
-	/* Expected to be called before d_delete() */
-	WARN_ON_ONCE(d_is_negative(dentry));
+	if (WARN_ON_ONCE(d_is_negative(dentry)))
+		return;
 
-	fsnotify_dirent(dir, dentry, FS_DELETE);
+	fsnotify_delete(dir, d_inode(dentry), dentry);
 }
 
 /*
@@ -258,10 +295,10 @@ static inline void fsnotify_mkdir(struct inode *dir, struct dentry *dentry)
  */
 static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	/* Expected to be called before d_delete() */
-	WARN_ON_ONCE(d_is_negative(dentry));
+	if (WARN_ON_ONCE(d_is_negative(dentry)))
+		return;
 
-	fsnotify_dirent(dir, dentry, FS_DELETE | FS_ISDIR);
+	fsnotify_delete(dir, d_inode(dentry), dentry);
 }
 
 /*
-- 
2.34.1


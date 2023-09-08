Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3883F7987DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbjIHN3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbjIHN3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:29:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466A81BF0
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 06:29:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31f2f43d5a0so2047872f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694179747; x=1694784547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMyC3ScyrTeYjFh8h+KwiRcLjeC712NFMfDqpIouhJs=;
        b=SNpecQgA69SOvbkaAh5qeQCjvcVSjqfI7J+UFwerghQ9l5fEc8udocoCj0X1F4aIfC
         3Mlq2yXIy8KfmremZrARMxKMo39jrU2wddobOj0fVR0V6jHLaGVYB0FSI6/JhldTxopQ
         cHNRuntYXKcAVKCiScCSIpO39SCjCnZrTKsVTFhJnDaUkl26F3P6MAMCLG2v9z/6auwz
         L5VhC65u3RS6Ha6Es8b2+ihr3840Si6RKuMZtSgTKz/OtwAU8qodBAV4K0MQvcXRx1md
         hAHz8H8FHs7LXBh2jt5N4819ziu9ffWZBMKJNKKoFsauRm4mIcRVx2eVIxnEGeDVigwK
         debg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694179747; x=1694784547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMyC3ScyrTeYjFh8h+KwiRcLjeC712NFMfDqpIouhJs=;
        b=HzDDyjXlp88CFe8s0vyzfnYngXCYuPcwq8Bcg7VHWuc9Op8EUCvrh8ZsbGF+glHkNH
         uRMErA2fgx2ofTw7VtxgfyUYwvHO+XCZI25GRfZ/A4Y0Y9xNtXSgE03BGQbw7I6Vhc/c
         qPcfpFoC3sFklpyR/EEmWeRfmKnmkGTY+ARFChRP0Ga98+RYzby7V9izMJOvray2q8Qx
         DpSocnV3Ku8z9TLR6eQFT485vhTqRw3ZiJWuuUfWj80NGq3OEdZqP7L0i+5f5stsfXys
         HTB4WBfHsoH22OHpr2h159K+/Jo2Fw5D62ahUXDOcdteTPXgbrnzafFMgGEPHk4tYYpR
         JfyQ==
X-Gm-Message-State: AOJu0YwJRcXsdL5KP0uyjUmt1sCkJaliBveN6ZWrV2TrRlUf2A1cGUFM
        qmPcVK/rPbH38KEDosSWT4o=
X-Google-Smtp-Source: AGHT+IEioFpgrUfLeru0aMMNAhu8vbhug8W1lmjqDJ9OrJbJPWRXsgPK7Ih+CQNW30hQPcx6AsNMtg==
X-Received: by 2002:a5d:5646:0:b0:315:964b:89b9 with SMTP id j6-20020a5d5646000000b00315964b89b9mr1748534wrw.52.1694179747611;
        Fri, 08 Sep 2023 06:29:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c249200b003fe1a96845bsm5248747wms.2.2023.09.08.06.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 06:29:07 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: rename __mnt_{want,drop}_write*() helpers
Date:   Fri,  8 Sep 2023 16:28:59 +0300
Message-Id: <20230908132900.2983519-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908132900.2983519-1-amir73il@gmail.com>
References: <20230908132900.2983519-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before exporting these helpers to modules, make their names more
meaningful.

The names mnt_{get,put)_write_access*() were chosen, because they rhyme
with the inode {get,put)_write_access() helpers, which have a very close
meaning for the inode object.

Suggested-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/r/20230817-anfechtbar-ruhelosigkeit-8c6cca8443fc@brauner/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/inode.c            |  8 ++++----
 fs/internal.h         | 12 ++++++------
 fs/namespace.c        | 34 +++++++++++++++++-----------------
 fs/open.c             |  2 +-
 include/linux/mount.h |  4 ++--
 kernel/acct.c         |  4 ++--
 6 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 35fd688168c5..7febdc9fd1a9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2006,7 +2006,7 @@ void touch_atime(const struct path *path)
 	if (!sb_start_write_trylock(inode->i_sb))
 		return;
 
-	if (__mnt_want_write(mnt) != 0)
+	if (mnt_get_write_access(mnt) != 0)
 		goto skip_update;
 	/*
 	 * File systems can error out when updating inodes if they need to
@@ -2018,7 +2018,7 @@ void touch_atime(const struct path *path)
 	 * of the fs read only, e.g. subvolumes in Btrfs.
 	 */
 	inode_update_time(inode, S_ATIME);
-	__mnt_drop_write(mnt);
+	mnt_put_write_access(mnt);
 skip_update:
 	sb_end_write(inode->i_sb);
 }
@@ -2173,9 +2173,9 @@ static int __file_update_time(struct file *file, int sync_mode)
 	struct inode *inode = file_inode(file);
 
 	/* try to update time settings */
-	if (!__mnt_want_write_file(file)) {
+	if (!mnt_get_write_access_file(file)) {
 		ret = inode_update_time(inode, sync_mode);
-		__mnt_drop_write_file(file);
+		mnt_put_write_access_file(file);
 	}
 
 	return ret;
diff --git a/fs/internal.h b/fs/internal.h
index d64ae03998cc..8260c738980c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -73,8 +73,8 @@ extern int sb_prepare_remount_readonly(struct super_block *);
 
 extern void __init mnt_init(void);
 
-extern int __mnt_want_write_file(struct file *);
-extern void __mnt_drop_write_file(struct file *);
+int mnt_get_write_access_file(struct file *file);
+void mnt_put_write_access_file(struct file *file);
 
 extern void dissolve_on_fput(struct vfsmount *);
 extern bool may_mount(void);
@@ -101,7 +101,7 @@ static inline void put_file_access(struct file *file)
 		i_readcount_dec(file->f_inode);
 	} else if (file->f_mode & FMODE_WRITER) {
 		put_write_access(file->f_inode);
-		__mnt_drop_write(file->f_path.mnt);
+		mnt_put_write_access(file->f_path.mnt);
 	}
 }
 
@@ -130,9 +130,9 @@ static inline void sb_start_ro_state_change(struct super_block *sb)
 	 * mnt_is_readonly() making sure if mnt_is_readonly() sees SB_RDONLY
 	 * cleared, it will see s_readonly_remount set.
 	 * For RW->RO transition, the barrier pairs with the barrier in
-	 * __mnt_want_write() before the mnt_is_readonly() check. The barrier
-	 * makes sure if __mnt_want_write() sees MNT_WRITE_HOLD already
-	 * cleared, it will see s_readonly_remount set.
+	 * mnt_get_write_access() before the mnt_is_readonly() check.
+	 * The barrier makes sure if mnt_get_write_access() sees MNT_WRITE_HOLD
+	 * already cleared, it will see s_readonly_remount set.
 	 */
 	smp_wmb();
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..3fe7c0484e6a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -330,16 +330,16 @@ static int mnt_is_readonly(struct vfsmount *mnt)
  * can determine when writes are able to occur to a filesystem.
  */
 /**
- * __mnt_want_write - get write access to a mount without freeze protection
+ * mnt_get_write_access - get write access to a mount without freeze protection
  * @m: the mount on which to take a write
  *
  * This tells the low-level filesystem that a write is about to be performed to
  * it, and makes sure that writes are allowed (mnt it read-write) before
  * returning success. This operation does not protect against filesystem being
- * frozen. When the write operation is finished, __mnt_drop_write() must be
+ * frozen. When the write operation is finished, mnt_put_write_access() must be
  * called. This is effectively a refcount.
  */
-int __mnt_want_write(struct vfsmount *m)
+int mnt_get_write_access(struct vfsmount *m)
 {
 	struct mount *mnt = real_mount(m);
 	int ret = 0;
@@ -401,7 +401,7 @@ int mnt_want_write(struct vfsmount *m)
 	int ret;
 
 	sb_start_write(m->mnt_sb);
-	ret = __mnt_want_write(m);
+	ret = mnt_get_write_access(m);
 	if (ret)
 		sb_end_write(m->mnt_sb);
 	return ret;
@@ -409,15 +409,15 @@ int mnt_want_write(struct vfsmount *m)
 EXPORT_SYMBOL_GPL(mnt_want_write);
 
 /**
- * __mnt_want_write_file - get write access to a file's mount
+ * mnt_get_write_access_file - get write access to a file's mount
  * @file: the file who's mount on which to take a write
  *
- * This is like __mnt_want_write, but if the file is already open for writing it
+ * This is like mnt_get_write_access, but if @file is already open for write it
  * skips incrementing mnt_writers (since the open file already has a reference)
  * and instead only does the check for emergency r/o remounts.  This must be
- * paired with __mnt_drop_write_file.
+ * paired with mnt_put_write_access_file.
  */
-int __mnt_want_write_file(struct file *file)
+int mnt_get_write_access_file(struct file *file)
 {
 	if (file->f_mode & FMODE_WRITER) {
 		/*
@@ -428,7 +428,7 @@ int __mnt_want_write_file(struct file *file)
 			return -EROFS;
 		return 0;
 	}
-	return __mnt_want_write(file->f_path.mnt);
+	return mnt_get_write_access(file->f_path.mnt);
 }
 
 /**
@@ -445,7 +445,7 @@ int mnt_want_write_file(struct file *file)
 	int ret;
 
 	sb_start_write(file_inode(file)->i_sb);
-	ret = __mnt_want_write_file(file);
+	ret = mnt_get_write_access_file(file);
 	if (ret)
 		sb_end_write(file_inode(file)->i_sb);
 	return ret;
@@ -453,14 +453,14 @@ int mnt_want_write_file(struct file *file)
 EXPORT_SYMBOL_GPL(mnt_want_write_file);
 
 /**
- * __mnt_drop_write - give up write access to a mount
+ * mnt_put_write_access - give up write access to a mount
  * @mnt: the mount on which to give up write access
  *
  * Tells the low-level filesystem that we are done
  * performing writes to it.  Must be matched with
- * __mnt_want_write() call above.
+ * mnt_get_write_access() call above.
  */
-void __mnt_drop_write(struct vfsmount *mnt)
+void mnt_put_write_access(struct vfsmount *mnt)
 {
 	preempt_disable();
 	mnt_dec_writers(real_mount(mnt));
@@ -477,20 +477,20 @@ void __mnt_drop_write(struct vfsmount *mnt)
  */
 void mnt_drop_write(struct vfsmount *mnt)
 {
-	__mnt_drop_write(mnt);
+	mnt_put_write_access(mnt);
 	sb_end_write(mnt->mnt_sb);
 }
 EXPORT_SYMBOL_GPL(mnt_drop_write);
 
-void __mnt_drop_write_file(struct file *file)
+void mnt_put_write_access_file(struct file *file)
 {
 	if (!(file->f_mode & FMODE_WRITER))
-		__mnt_drop_write(file->f_path.mnt);
+		mnt_put_write_access(file->f_path.mnt);
 }
 
 void mnt_drop_write_file(struct file *file)
 {
-	__mnt_drop_write_file(file);
+	mnt_put_write_access_file(file);
 	sb_end_write(file_inode(file)->i_sb);
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
diff --git a/fs/open.c b/fs/open.c
index 98f6601fbac6..a65ce47810cf 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -895,7 +895,7 @@ static int do_dentry_open(struct file *f,
 		error = get_write_access(inode);
 		if (unlikely(error))
 			goto cleanup_file;
-		error = __mnt_want_write(f->f_path.mnt);
+		error = mnt_get_write_access(f->f_path.mnt);
 		if (unlikely(error)) {
 			put_write_access(inode);
 			goto cleanup_file;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 4f40b40306d0..ac3dd2876197 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -92,8 +92,8 @@ extern bool __mnt_is_readonly(struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
 
 extern struct vfsmount *clone_private_mount(const struct path *path);
-extern int __mnt_want_write(struct vfsmount *);
-extern void __mnt_drop_write(struct vfsmount *);
+int mnt_get_write_access(struct vfsmount *mnt);
+void mnt_put_write_access(struct vfsmount *mnt);
 
 extern struct vfsmount *fc_mount(struct fs_context *fc);
 extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
diff --git a/kernel/acct.c b/kernel/acct.c
index 1a9f929fe629..986c8214dabf 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -246,7 +246,7 @@ static int acct_on(struct filename *pathname)
 		filp_close(file, NULL);
 		return PTR_ERR(internal);
 	}
-	err = __mnt_want_write(internal);
+	err = mnt_get_write_access(internal);
 	if (err) {
 		mntput(internal);
 		kfree(acct);
@@ -271,7 +271,7 @@ static int acct_on(struct filename *pathname)
 	old = xchg(&ns->bacct, &acct->pin);
 	mutex_unlock(&acct->lock);
 	pin_kill(old);
-	__mnt_drop_write(mnt);
+	mnt_put_write_access(mnt);
 	mntput(mnt);
 	return 0;
 }
-- 
2.34.1


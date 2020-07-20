Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A4D2269CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbgGTQ3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732133AbgGTP7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFFAC061794;
        Mon, 20 Jul 2020 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Mve+Dlm9ghe+CtbJJNJRDGZqsefQbVhzZmTfjwbVfnE=; b=lPa5yVLloGIdsTwK0lG0MESgU7
        JGay3UB80aIc6ZPD0MHDSOYVV2qNaGs/E6isgE0N/THfb/pPOEehzQVe13Zcg7WO3g9/GgxWt0/D/
        pbaWiudyNCzGu7mBvxK13tykrosoq+9xVxAJnqRrFO+k4l1tEczfvr52mGapxthm9qfiG9HxD5Olb
        dahuUdanft2Q9dcCdsHXo3kB90v2XxbrgC9b2TRbFEC0NNomNe9RUe3QcddtZhgqoM3LhDeA/U/XT
        YbqoWNybv3RdTpiBcN0uwvOeKSJCilgj323HF9Iit6RHVKJp+gp6eWdex4TzLtJkfs1OQyZBm+LIX
        cMM8rlOQ==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYC2-0007mv-DR; Mon, 20 Jul 2020 15:59:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 02/24] fs: add a do_kern_mount helper
Date:   Mon, 20 Jul 2020 17:58:40 +0200
Message-Id: <20200720155902.181712-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720155902.181712-1-hch@lst.de>
References: <20200720155902.181712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like do_mount, but takes a kernel pointer for the destination path.
Switch over the mounts in the init code and devtmpfs to it, which
just happen to work due to the implicit set_fs(KERNEL_DS) during early
init right now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/devtmpfs.c |  4 +-
 fs/namespace.c          | 81 +++++++++++++++++++++++++----------------
 include/linux/fs.h      |  2 +
 init/do_mounts.c        |  8 ++--
 init/do_mounts_initrd.c |  6 +--
 5 files changed, 60 insertions(+), 41 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index c9017e0584c003..03221ca708c91c 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -359,7 +359,7 @@ int __init devtmpfs_mount(void)
 	if (!thread)
 		return 0;
 
-	err = do_mount("devtmpfs", "dev", "devtmpfs", MS_SILENT, NULL);
+	err = do_kern_mount("devtmpfs", "dev", "devtmpfs", MS_SILENT, NULL);
 	if (err)
 		printk(KERN_INFO "devtmpfs: error mounting %i\n", err);
 	else
@@ -385,7 +385,7 @@ static int devtmpfs_setup(void *p)
 	err = ksys_unshare(CLONE_NEWNS);
 	if (err)
 		goto out;
-	err = do_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, NULL);
+	err = do_kern_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, NULL);
 	if (err)
 		goto out;
 	ksys_chdir("/.."); /* will traverse into overmounted root */
diff --git a/fs/namespace.c b/fs/namespace.c
index f30ed401cc6d7a..d208a389aac3c0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3115,12 +3115,11 @@ char *copy_mount_string(const void __user *data)
  * Therefore, if this magic number is present, it carries no information
  * and must be discarded.
  */
-long do_mount(const char *dev_name, const char __user *dir_name,
+static int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
-	struct path path;
 	unsigned int mnt_flags = 0, sb_flags;
-	int retval = 0;
+	int ret = 0;
 
 	/* Discard magic */
 	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
@@ -3133,19 +3132,13 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 	if (flags & MS_NOUSER)
 		return -EINVAL;
 
-	/* ... and get the mountpoint */
-	retval = user_path_at(AT_FDCWD, dir_name, LOOKUP_FOLLOW, &path);
-	if (retval)
-		return retval;
-
-	retval = security_sb_mount(dev_name, &path,
-				   type_page, flags, data_page);
-	if (!retval && !may_mount())
-		retval = -EPERM;
-	if (!retval && (flags & SB_MANDLOCK) && !may_mandlock())
-		retval = -EPERM;
-	if (retval)
-		goto dput_out;
+	ret = security_sb_mount(dev_name, path, type_page, flags, data_page);
+	if (ret)
+		return ret;
+	if (!may_mount())
+		return -EPERM;
+	if ((flags & SB_MANDLOCK) && !may_mandlock())
+		return -EPERM;
 
 	/* Default to relatime unless overriden */
 	if (!(flags & MS_NOATIME))
@@ -3172,7 +3165,7 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 	    ((flags & (MS_NOATIME | MS_NODIRATIME | MS_RELATIME |
 		       MS_STRICTATIME)) == 0)) {
 		mnt_flags &= ~MNT_ATIME_MASK;
-		mnt_flags |= path.mnt->mnt_flags & MNT_ATIME_MASK;
+		mnt_flags |= path->mnt->mnt_flags & MNT_ATIME_MASK;
 	}
 
 	sb_flags = flags & (SB_RDONLY |
@@ -3185,22 +3178,46 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 			    SB_I_VERSION);
 
 	if ((flags & (MS_REMOUNT | MS_BIND)) == (MS_REMOUNT | MS_BIND))
-		retval = do_reconfigure_mnt(&path, mnt_flags);
-	else if (flags & MS_REMOUNT)
-		retval = do_remount(&path, flags, sb_flags, mnt_flags,
-				    data_page);
-	else if (flags & MS_BIND)
-		retval = do_loopback(&path, dev_name, flags & MS_REC);
-	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
-		retval = do_change_type(&path, flags);
-	else if (flags & MS_MOVE)
-		retval = do_move_mount_old(&path, dev_name);
-	else
-		retval = do_new_mount(&path, type_page, sb_flags, mnt_flags,
-				      dev_name, data_page);
-dput_out:
+		return do_reconfigure_mnt(path, mnt_flags);
+	if (flags & MS_REMOUNT)
+		return do_remount(path, flags, sb_flags, mnt_flags, data_page);
+	if (flags & MS_BIND)
+		return do_loopback(path, dev_name, flags & MS_REC);
+	if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
+		return do_change_type(path, flags);
+	if (flags & MS_MOVE)
+		return do_move_mount_old(path, dev_name);
+
+	return do_new_mount(path, type_page, sb_flags, mnt_flags, dev_name,
+			    data_page);
+}
+
+long do_mount(const char *dev_name, const char __user *dir_name,
+		const char *type_page, unsigned long flags, void *data_page)
+{
+	struct path path;
+	int ret;
+
+	ret = user_path_at(AT_FDCWD, dir_name, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ret;
+	ret = path_mount(dev_name, &path, type_page, flags, data_page);
 	path_put(&path);
-	return retval;
+	return ret;
+}
+
+int do_kern_mount(const char *dev_name, const char *dir_name,
+		const char *type_page, unsigned long flags, void *data_page)
+{
+	struct path path;
+	int ret;
+
+	ret = kern_path(dir_name, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ret;
+	ret = path_mount(dev_name, &path, type_page, flags, data_page);
+	path_put(&path);
+	return ret;
 }
 
 static struct ucounts *inc_mnt_namespaces(struct user_namespace *ns)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a1d2685a487868..8f628f9868711d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2337,6 +2337,8 @@ extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(const char *, const char __user *,
 		     const char *, unsigned long, void *);
+int do_kern_mount(const char *dev_name, const char *dir_name,
+		const char *type_page, unsigned long flags, void *data_page);
 extern struct vfsmount *collect_mounts(const struct path *);
 extern void drop_collected_mounts(struct vfsmount *);
 extern int iterate_mounts(int (*)(struct vfsmount *, void *), void *,
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 4f4ceb35805503..2fef92a8ed3c15 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -395,16 +395,16 @@ static int __init do_mount_root(const char *name, const char *fs,
 	int ret;
 
 	if (data) {
-		/* do_mount() requires a full page as fifth argument */
+		/* do_kern_mount() requires a full page as fifth argument */
 		p = alloc_page(GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
 		data_page = page_address(p);
-		/* zero-pad. do_mount() will make sure it's terminated */
+		/* zero-pad. do_kern_mount() will make sure it's terminated */
 		strncpy(data_page, data, PAGE_SIZE);
 	}
 
-	ret = do_mount(name, "/root", fs, flags, data_page);
+	ret = do_kern_mount(name, "/root", fs, flags, data_page);
 	if (ret)
 		goto out;
 
@@ -628,7 +628,7 @@ void __init prepare_namespace(void)
 	mount_root();
 out:
 	devtmpfs_mount();
-	do_mount(".", "/", NULL, MS_MOVE, NULL);
+	do_kern_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index e08669187d63be..604ce78af9acfa 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -62,7 +62,7 @@ static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 	console_on_rootfs();
 	/* move initrd over / and chdir/chroot in initrd root */
 	ksys_chdir("/root");
-	do_mount(".", "/", NULL, MS_MOVE, NULL);
+	do_kern_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 	ksys_setsid();
 	return 0;
@@ -99,7 +99,7 @@ static void __init handle_initrd(void)
 	current->flags &= ~PF_FREEZER_SKIP;
 
 	/* move initrd to rootfs' /old */
-	do_mount("..", ".", NULL, MS_MOVE, NULL);
+	do_kern_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
 	ksys_chroot("..");
 
@@ -113,7 +113,7 @@ static void __init handle_initrd(void)
 	mount_root();
 
 	printk(KERN_NOTICE "Trying to move old root to /initrd ... ");
-	error = do_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
+	error = do_kern_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
 	if (!error)
 		printk("okay\n");
 	else {
-- 
2.27.0


Return-Path: <linux-fsdevel+bounces-54033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379BAFA788
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 21:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB5A7A269E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D1529E11B;
	Sun,  6 Jul 2025 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cVwHrYHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AB13AD3F
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jul 2025 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751831929; cv=none; b=eKxqOD6rnTD9cQFP0ZxxLK1GxLCYr+lcpifo0FJeGnkRoNp8WkMkjIdNSC7PoxEtgUF9viI40JRz6aSJPjptsQeWwSvGEy4YHq2OeFdvuyk/fJG0J9T9bTaxKpN+bzS6JsLj8i2rRbt/hfr45yVotsmLJCJ3sHqBNNBAtlLtd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751831929; c=relaxed/simple;
	bh=NaLoIHwsoWmfoSF0RUSoQs58sECqUH9YIp8xxbhsUd4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b+E07zJ3jAqKtUoZ/Stm60+x5kd+U/oGJIKFedrxW+HNrVfMFeIpW0wGAPh+dwMGrrA6UxOajRLIANeBTihwwZ6Xc5FQXMIv/wUX2+XV6Bmbvg69zV3kCc1mDNL3XM5ZxAuZG1XZP4qSjb5OdYd0j6Yfo+CCiep9IC7e5wKeTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cVwHrYHW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QD9yg3p4P2otu8JBNaD3oaskCoEflVRwLot6mUwxRJU=; b=cVwHrYHWvv94TuKPG8jn71j9d3
	9OZYBbYzFrrQjteJz7Sv4W2USB9uv7xrA2lhfPyjxNsF0xRTiqgpF50ifRzQ9DF7XnzJi5hB9KMfT
	v9IVVTmIDVxRDrYwVH5aVh9jsZmgSSEHA2TUlJd33arKiR5+kOCGad1MbKCSpXrlkNO4j/sBBZigY
	Ri/MqeaxE3oXsaE1J0+7Doe4xE82oMf/cOG5v9bjTlabAYIyPtlLDmH3NfytZjmGSwDGQg9DU+aBM
	QelpAW+JFaECeDVSB9NfVy1tMaOFu0lnkUvam9mOHNvI9IihojEZORU7VFl3uOBlVRwucvVjkHFp4
	gkqnYqsQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYVVc-0000000CoHn-39BC;
	Sun, 06 Jul 2025 19:58:44 +0000
Date: Sun, 6 Jul 2025 20:58:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH][RFC] kernel/acct.c: saner struct file treatment
Message-ID: <20250706195844.GD1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Instead of switching ->f_path.mnt of an opened file to internal
clone, resolve the pathname, get a struct path with ->mnt set to internal
clone, then dentry_open() that to get the file with right ->f_path.mnt
from the very beginning.

	The only subtle part here is that on failure exits we need to
close the file with __fput_sync() and make sure we do that *before*
dropping the original mount.

	With that done, only fs/{file_table,open,namei}.c ever store
anything to file->f_path and only prior to file->f_mode & FMODE_OPENED
becoming true.  Analysis of mount write count handling also becomes
less brittle and convoluted...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/kernel/acct.c b/kernel/acct.c
index 6520baa13669..30ae403ee322 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -44,19 +44,14 @@
  * a struct file opened for write. Fixed. 2/6/2000, AV.
  */
 
-#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/acct.h>
 #include <linux/capability.h>
-#include <linux/file.h>
 #include <linux/tty.h>
-#include <linux/security.h>
-#include <linux/vfs.h>
+#include <linux/statfs.h>
 #include <linux/jiffies.h>
-#include <linux/times.h>
 #include <linux/syscalls.h>
-#include <linux/mount.h>
-#include <linux/uaccess.h>
+#include <linux/namei.h>
 #include <linux/sched/cputime.h>
 
 #include <asm/div64.h>
@@ -217,84 +212,68 @@ static void close_work(struct work_struct *work)
 	complete(&acct->done);
 }
 
-static int acct_on(struct filename *pathname)
+DEFINE_FREE(fput_sync, struct file *, if (!IS_ERR_OR_NULL(_T)) __fput_sync(_T))
+static int acct_on(const char __user *name)
 {
-	struct file *file;
-	struct vfsmount *mnt, *internal;
+	/* Difference from BSD - they don't do O_APPEND */
+	const int open_flags = O_WRONLY|O_APPEND|O_LARGEFILE;
 	struct pid_namespace *ns = task_active_pid_ns(current);
+	struct path path __free(path_put) = {};		// in that order
+	struct path internal __free(path_put) = {};	// in that order
+	struct file *file __free(fput_sync) = NULL;	// in that order
 	struct bsd_acct_struct *acct;
+	struct vfsmount *mnt;
 	struct fs_pin *old;
 	int err;
 
-	acct = kzalloc(sizeof(struct bsd_acct_struct), GFP_KERNEL);
-	if (!acct)
-		return -ENOMEM;
+	err = user_path_at(AT_FDCWD, name, LOOKUP_FOLLOW, &path);
+	if (err)
+		return err;
 
-	/* Difference from BSD - they don't do O_APPEND */
-	file = file_open_name(pathname, O_WRONLY|O_APPEND|O_LARGEFILE, 0);
-	if (IS_ERR(file)) {
-		kfree(acct);
+	mnt = mnt_clone_internal(&path);
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	internal.mnt = mnt;
+	internal.dentry = dget(mnt->mnt_root);
+
+	file = dentry_open(&internal, open_flags, current_cred());
+	if (IS_ERR(file))
 		return PTR_ERR(file);
-	}
 
-	if (!S_ISREG(file_inode(file)->i_mode)) {
-		kfree(acct);
-		filp_close(file, NULL);
+	if (!S_ISREG(file_inode(file)->i_mode))
 		return -EACCES;
-	}
 
 	/* Exclude kernel kernel internal filesystems. */
-	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT)) {
-		kfree(acct);
-		filp_close(file, NULL);
+	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT))
 		return -EINVAL;
-	}
 
 	/* Exclude procfs and sysfs. */
-	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
-		kfree(acct);
-		filp_close(file, NULL);
+	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE)
 		return -EINVAL;
-	}
 
-	if (!(file->f_mode & FMODE_CAN_WRITE)) {
-		kfree(acct);
-		filp_close(file, NULL);
+	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EIO;
-	}
-	internal = mnt_clone_internal(&file->f_path);
-	if (IS_ERR(internal)) {
-		kfree(acct);
-		filp_close(file, NULL);
-		return PTR_ERR(internal);
-	}
-	err = mnt_get_write_access(internal);
-	if (err) {
-		mntput(internal);
-		kfree(acct);
-		filp_close(file, NULL);
-		return err;
-	}
-	mnt = file->f_path.mnt;
-	file->f_path.mnt = internal;
+
+	acct = kzalloc(sizeof(struct bsd_acct_struct), GFP_KERNEL);
+	if (!acct)
+		return -ENOMEM;
 
 	atomic_long_set(&acct->count, 1);
 	init_fs_pin(&acct->pin, acct_pin_kill);
-	acct->file = file;
+	acct->file = no_free_ptr(file);
 	acct->needcheck = jiffies;
 	acct->ns = ns;
 	mutex_init(&acct->lock);
 	INIT_WORK(&acct->work, close_work);
 	init_completion(&acct->done);
 	mutex_lock_nested(&acct->lock, 1);	/* nobody has seen it yet */
-	pin_insert(&acct->pin, mnt);
+	pin_insert(&acct->pin, path.mnt);
 
 	rcu_read_lock();
 	old = xchg(&ns->bacct, &acct->pin);
 	mutex_unlock(&acct->lock);
 	pin_kill(old);
-	mnt_put_write_access(mnt);
-	mntput(mnt);
 	return 0;
 }
 
@@ -319,14 +298,9 @@ SYSCALL_DEFINE1(acct, const char __user *, name)
 		return -EPERM;
 
 	if (name) {
-		struct filename *tmp = getname(name);
-
-		if (IS_ERR(tmp))
-			return PTR_ERR(tmp);
 		mutex_lock(&acct_on_mutex);
-		error = acct_on(tmp);
+		error = acct_on(name);
 		mutex_unlock(&acct_on_mutex);
-		putname(tmp);
 	} else {
 		rcu_read_lock();
 		pin_kill(task_active_pid_ns(current)->bacct);


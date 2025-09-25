Return-Path: <linux-fsdevel+bounces-62811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DFEBA1717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 22:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8568A380D95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F8321287;
	Thu, 25 Sep 2025 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PNV1LCN0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFE1114
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833813; cv=none; b=WuTXk5q3tV8l1mdJCn1rBFNAuUSSn02oGSyKdHeGudGE8NXplNC6yrAHJVN9xKJY3yr4WU38BYhD3rm3iPzd2iqUDV9r42yz6HnIVlGOGXEGR6XdhHdWSCDAC7dS7DSjDcg4OnjEstKMXhFMKqGt+Ns9U8zw8bnql/MUxf+RIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833813; c=relaxed/simple;
	bh=iNxwVSLF4p8Rac5E+hS2RO/WmV7oT0ddZX/vJke1g80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxy/I349+IEf8Ecwy93ouRaFZWTfgtyyydtGR6FeXufvErs98ltkfhbhFSG2dr88pVZXhNzk4nJQpmr6qUNADtfRrmBhp5ZTLKYMKNXnZRMmNKZkgtNnc2No5WRg73Hg7Gtb3ndIZn2HnLVb3FEVAJRxV4B+el+kZQPpL3tCKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PNV1LCN0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t2c3tdgGPQsFIGVQNBQWXTjMHyYSBg2R+1Xdfh0yL3k=; b=PNV1LCN0O3mhLr9hVvMwW+oJYs
	eEEoBAJQuCbITwtrNyGH1HjwfKAkM3AaYDODFlw0tTeYQ3ym8rIn9M/Kk5y/pjshsbyFK8VWdK8Q8
	BimrSzgUTdXiryRng9y/il7RYXB5KERFOZfWrCQivQA8uynTdziHty52fcQB/71iexQuiXplBdqqh
	LUOr2OA2nfMmb1hM8JZdZDBj9EyVu7TT4aGK3aGmCvUFyFJjhV0Q9Pbc7WIDHwhuxkcBbmMKan8Mu
	7wXwismm6d/fakBEQQwn2of8kjB5J2O/dmXTsJUOGP+mElvn0JwtQhRdjfUDzTcvA6Z7MeImipbzd
	NM+EF+fw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1t1D-0000000BG5b-46b5;
	Thu, 25 Sep 2025 20:56:48 +0000
Date: Thu, 25 Sep 2025 21:56:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	John Johansen <john@apparmor.net>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] kernel/acct.c: saner struct file treatment
Message-ID: <20250925205647.GC39973@ZenIV>
References: <20250906090738.GA31600@ZenIV>
 <20250906091339.GB31600@ZenIV>
 <4892af80-8e0b-4ee5-98ac-1cce7e252b6a@sirena.org.uk>
 <klzgui6d2jo2tng5py776uku2xnwzcwi4jt5qf5iulszdtoqxo@q6o2zmvvxcuz>
 <20250925185630.GZ39973@ZenIV>
 <20250925190944.GA39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925190944.GA39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[seems to work properly now]
	Instead of switching ->f_path.mnt of an opened file to internal
clone, get a struct path with ->mnt set to internal clone of that
->f_path.mnt, then dentry_open() that to get the file with right ->f_path.mnt
from the very beginning.

	The only subtle part here is that on failure exits we need to
close the file with __fput_sync() and make sure we do that *before*
dropping the original mount.

	With that done, only fs/{file_table,open,namei}.c ever store
anything to file->f_path and only prior to file->f_mode & FMODE_OPENED
becoming true.  Analysis of mount write count handling also becomes
less brittle and convoluted...

[AV: folded a fix for a bug spotted by Jan Kara - we do need a full-blown
open of the original file, not just user_path_at() or we end up skipping
permission checks]

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/kernel/acct.c b/kernel/acct.c
index 6520baa13669..61630110e29d 100644
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
@@ -217,84 +212,70 @@ static void close_work(struct work_struct *work)
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
+	struct filename *pathname __free(putname) = getname(name);
+	struct file *original_file __free(fput) = NULL;	// in that order
+	struct path internal __free(path_put) = {};	// in that order
+	struct file *file __free(fput_sync) = NULL;	// in that order
 	struct bsd_acct_struct *acct;
+	struct vfsmount *mnt;
 	struct fs_pin *old;
-	int err;
 
-	acct = kzalloc(sizeof(struct bsd_acct_struct), GFP_KERNEL);
-	if (!acct)
-		return -ENOMEM;
+	if (IS_ERR(pathname))
+		return PTR_ERR(pathname);
+	original_file = file_open_name(pathname, open_flags, 0);
+	if (IS_ERR(original_file))
+		return PTR_ERR(original_file);
 
-	/* Difference from BSD - they don't do O_APPEND */
-	file = file_open_name(pathname, O_WRONLY|O_APPEND|O_LARGEFILE, 0);
-	if (IS_ERR(file)) {
-		kfree(acct);
+	mnt = mnt_clone_internal(&original_file->f_path);
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
+	pin_insert(&acct->pin, original_file->f_path.mnt);
 
 	rcu_read_lock();
 	old = xchg(&ns->bacct, &acct->pin);
 	mutex_unlock(&acct->lock);
 	pin_kill(old);
-	mnt_put_write_access(mnt);
-	mntput(mnt);
 	return 0;
 }
 
@@ -319,14 +300,9 @@ SYSCALL_DEFINE1(acct, const char __user *, name)
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


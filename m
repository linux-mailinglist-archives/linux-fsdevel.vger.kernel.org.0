Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2B312E7D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 16:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgABPE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 10:04:29 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:59515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgABPE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:04:29 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MjjOl-1jSjaW31yt-00lBfc; Thu, 02 Jan 2020 16:02:15 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Song Liu <songliubraving@fb.com>,
        Eric Biggers <ebiggers@google.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Waiman Long <longman@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/22] compat_ioctl: simplify the implementation
Date:   Thu,  2 Jan 2020 15:55:33 +0100
Message-Id: <20200102145552.1853992-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K5WlkTNEfH+REKaJDhqjUSdnzSt9VBS40wtvD48rRQ+DNG8JQU5
 1F53SJnrIyH+2LC8JYCsRZ0sIb7G3wP5g9kJdvlY9pVBEAa9XgO0jSZUVzAzSZmsIOPcJuW
 XmKZIBnDYtPLBsrFff6dBSN7OPXTvAEDCStW5zn9uPsvJcQjYh8K7ofbDLkDW67I755bkMX
 iZWpMG7rZoaZ03YuJIFxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eXINiXNcmFM=:FK9dBUizpEm2yXmS8jSHY7
 eqfjK1QBjRc7E6llT2aECiLbUgr3UuMXf04ZCDXs0MSCLoFTZy/0y4D3QvA9PPPptSs9EwLpP
 ojF/Imy4laIiOXW9tDA4nQFsbn+4Kj2PChO1gtBcUCVhbrjgc3jdj7NroMO6AFj5AsPp9K1sL
 70C/rYNMVGYBMah9PRPTUH3sJCuMjkmz6N1f8Snt6yga1bXtHkwn2WDQxX7zjydFg3P1nQvWR
 qQLZHJMCcw/zQcytmQhEGmD5C9EXd1elZNUv3buL9+Rb5Da+22EMNvMJ4DVcqOMiarqGBnSvp
 A6fqPTycn2qt4/vu3m0acvOT3CdXq1+TIR1v4gF87mthmOtp7YCuY1efLKcUAmsQCp02h2dSN
 zt42Qh8mQhupoGV6mLKy/306UZOqqfwQQY4EgW4l9BE6O87aMrsCjRDHdVYoqo8lEizqcHtpt
 8EKBcBMZ8wmyQV7Mzl3V6K1yNTkhWgGLSqUD+XgZVYWZ36xEfZa5LDwotQtUF8X1KrttUQtsQ
 V4BB+V/gCutIyY9QqpW4bea2/INttaX9SDZy84wbfyIs153mNtgkHMJrHIFFYhmp96OebR1A0
 iG4yV/a9I8zNDghtSaRdDFqR+3RyBFEQQ3nMhlaWTNEMgnnXr+AtTX5ZfzRJOej5s+wI6QJ58
 w5gx9+uKGITyZKs5gO0we1qee0CUoag2nLoIiYSeyb/xhz4dM7O3+2IpuyZwjchP+MQoqPSLs
 yQkTrXiGcotapqYRWBCwEqRY8DQebwgk2NB5CrBkkne0pOxzE6mSNW9Tj1KvzZRzw1kRhWr2l
 mqfKtoZtv9pGCcBtSFV7k4QjE1XJI5ZP4VMvAkPP0AX8aSFrRqyB03mChsvSxY9B4lY/C/ENu
 TQ89mD8cPux/2vh8hBnA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that both native and compat ioctl syscalls are
in the same file, a couple of simplifications can
be made, bringing the implementation closer together:

- do_vfs_ioctl(), ioctl_preallocate(), and compat_ioctl_preallocate()
  can become static, allowing the compiler to optimize better

- slightly update the coding style for consistency between
  the functions.

- rather than listing each command in two switch statements
  for the compat case, just call a single function that has
  all the common commands.

As a side-effect, FS_IOC_RESVSP/FS_IOC_RESVSP64 are now available
to x86 compat tasks, along with FS_IOC_RESVSP_32/FS_IOC_RESVSP64_32.
This is harmless for i386 emulation, and can be considered a bugfix
for x32 emulation, which never supported these in the past.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/internal.h          |   6 --
 fs/ioctl.c             | 157 +++++++++++++++++------------------------
 include/linux/falloc.h |   2 -
 include/linux/fs.h     |   4 --
 4 files changed, 64 insertions(+), 105 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 4a7da1df573d..d46247850ad7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -180,11 +180,5 @@ extern void mnt_pin_kill(struct mount *m);
  */
 extern const struct dentry_operations ns_dentry_operations;
 
-/*
- * fs/ioctl.c
- */
-extern int do_vfs_ioctl(struct file *file, unsigned int fd, unsigned int cmd,
-		    unsigned long arg);
-
 /* direct-io.c: */
 int sb_init_dio_done_wq(struct super_block *sb);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 8f22f7817edb..7c9a5df5a597 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -467,7 +467,7 @@ EXPORT_SYMBOL(generic_block_fiemap);
  * Only the l_start, l_len and l_whence fields of the 'struct space_resv'
  * are used here, rest are ignored.
  */
-int ioctl_preallocate(struct file *filp, int mode, void __user *argp)
+static int ioctl_preallocate(struct file *filp, int mode, void __user *argp)
 {
 	struct inode *inode = file_inode(filp);
 	struct space_resv sr;
@@ -495,8 +495,8 @@ int ioctl_preallocate(struct file *filp, int mode, void __user *argp)
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined CONFIG_COMPAT && defined(CONFIG_X86_64)
 /* just account for different alignment */
-int compat_ioctl_preallocate(struct file *file, int mode,
-				struct space_resv_32 __user *argp)
+static int compat_ioctl_preallocate(struct file *file, int mode,
+				    struct space_resv_32 __user *argp)
 {
 	struct inode *inode = file_inode(file);
 	struct space_resv_32 sr;
@@ -521,11 +521,9 @@ int compat_ioctl_preallocate(struct file *file, int mode,
 }
 #endif
 
-static int file_ioctl(struct file *filp, unsigned int cmd,
-		unsigned long arg)
+static int file_ioctl(struct file *filp, unsigned int cmd, int __user *p)
 {
 	struct inode *inode = file_inode(filp);
-	int __user *p = (int __user *)arg;
 
 	switch (cmd) {
 	case FIBMAP:
@@ -542,7 +540,7 @@ static int file_ioctl(struct file *filp, unsigned int cmd,
 		return ioctl_preallocate(filp, FALLOC_FL_ZERO_RANGE, p);
 	}
 
-	return vfs_ioctl(filp, cmd, arg);
+	return -ENOIOCTLCMD;
 }
 
 static int ioctl_fionbio(struct file *filp, int __user *argp)
@@ -661,53 +659,48 @@ static int ioctl_file_dedupe_range(struct file *file,
 }
 
 /*
- * When you add any new common ioctls to the switches above and below
- * please update compat_sys_ioctl() too.
- *
  * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
  * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
+ *
+ * When you add any new common ioctls to the switches above and below,
+ * please ensure they have compatible arguments in compat mode.
  */
-int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
-	     unsigned long arg)
+static int do_vfs_ioctl(struct file *filp, unsigned int fd,
+			unsigned int cmd, unsigned long arg)
 {
-	int error = 0;
 	void __user *argp = (void __user *)arg;
 	struct inode *inode = file_inode(filp);
 
 	switch (cmd) {
 	case FIOCLEX:
 		set_close_on_exec(fd, 1);
-		break;
+		return 0;
 
 	case FIONCLEX:
 		set_close_on_exec(fd, 0);
-		break;
+		return 0;
 
 	case FIONBIO:
-		error = ioctl_fionbio(filp, argp);
-		break;
+		return ioctl_fionbio(filp, argp);
 
 	case FIOASYNC:
-		error = ioctl_fioasync(fd, filp, argp);
-		break;
+		return ioctl_fioasync(fd, filp, argp);
 
 	case FIOQSIZE:
 		if (S_ISDIR(inode->i_mode) || S_ISREG(inode->i_mode) ||
 		    S_ISLNK(inode->i_mode)) {
 			loff_t res = inode_get_bytes(inode);
-			error = copy_to_user(argp, &res, sizeof(res)) ?
-					-EFAULT : 0;
-		} else
-			error = -ENOTTY;
-		break;
+			return copy_to_user(argp, &res, sizeof(res)) ?
+					    -EFAULT : 0;
+		}
+
+		return -ENOTTY;
 
 	case FIFREEZE:
-		error = ioctl_fsfreeze(filp);
-		break;
+		return ioctl_fsfreeze(filp);
 
 	case FITHAW:
-		error = ioctl_fsthaw(filp);
-		break;
+		return ioctl_fsthaw(filp);
 
 	case FS_IOC_FIEMAP:
 		return ioctl_fiemap(filp, argp);
@@ -716,6 +709,7 @@ int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
 		/* anon_bdev filesystems may not have a block size */
 		if (!inode->i_sb->s_blocksize)
 			return -EINVAL;
+
 		return put_user(inode->i_sb->s_blocksize, (int __user *)argp);
 
 	case FICLONE:
@@ -729,24 +723,30 @@ int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
 
 	default:
 		if (S_ISREG(inode->i_mode))
-			error = file_ioctl(filp, cmd, arg);
-		else
-			error = vfs_ioctl(filp, cmd, arg);
+			return file_ioctl(filp, cmd, argp);
 		break;
 	}
-	return error;
+
+	return -ENOIOCTLCMD;
 }
 
 int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	int error;
 	struct fd f = fdget(fd);
+	int error;
 
 	if (!f.file)
 		return -EBADF;
+
 	error = security_file_ioctl(f.file, cmd, arg);
-	if (!error)
-		error = do_vfs_ioctl(f.file, fd, cmd, arg);
+	if (error)
+		goto out;
+
+	error = do_vfs_ioctl(f.file, fd, cmd, arg);
+	if (error == -ENOIOCTLCMD)
+		error = vfs_ioctl(f.file, cmd, arg);
+
+out:
 	fdput(f);
 	return error;
 }
@@ -790,92 +790,63 @@ long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 EXPORT_SYMBOL(compat_ptr_ioctl);
 
 COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
-		       compat_ulong_t, arg32)
+		       compat_ulong_t, arg)
 {
-	unsigned long arg = arg32;
 	struct fd f = fdget(fd);
-	int error = -EBADF;
+	int error;
+
 	if (!f.file)
-		goto out;
+		return -EBADF;
 
 	/* RED-PEN how should LSM module know it's handling 32bit? */
 	error = security_file_ioctl(f.file, cmd, arg);
 	if (error)
-		goto out_fput;
+		goto out;
 
 	switch (cmd) {
-	/* these are never seen by ->ioctl(), no argument or int argument */
-	case FIOCLEX:
-	case FIONCLEX:
-	case FIFREEZE:
-	case FITHAW:
+	/* FICLONE takes an int argument, so don't use compat_ptr() */
 	case FICLONE:
-		goto do_ioctl;
-	/* these are never seen by ->ioctl(), pointer argument */
-	case FIONBIO:
-	case FIOASYNC:
-	case FIOQSIZE:
-	case FS_IOC_FIEMAP:
-	case FIGETBSZ:
-	case FICLONERANGE:
-	case FIDEDUPERANGE:
-		goto found_handler;
-	/*
-	 * The next group is the stuff handled inside file_ioctl().
-	 * For regular files these never reach ->ioctl(); for
-	 * devices, sockets, etc. they do and one (FIONREAD) is
-	 * even accepted in some cases.  In all those cases
-	 * argument has the same type, so we can handle these
-	 * here, shunting them towards do_vfs_ioctl().
-	 * ->compat_ioctl() will never see any of those.
-	 */
-	/* pointer argument, never actually handled by ->ioctl() */
-	case FIBMAP:
-		goto found_handler;
-	/* handled by some ->ioctl(); always a pointer to int */
-	case FIONREAD:
-		goto found_handler;
-	/* these get messy on amd64 due to alignment differences */
+		error = ioctl_file_clone(f.file, arg, 0, 0, 0);
+		break;
+
 #if defined(CONFIG_X86_64)
+	/* these get messy on amd64 due to alignment differences */
 	case FS_IOC_RESVSP_32:
 	case FS_IOC_RESVSP64_32:
 		error = compat_ioctl_preallocate(f.file, 0, compat_ptr(arg));
-		goto out_fput;
+		break;
 	case FS_IOC_UNRESVSP_32:
 	case FS_IOC_UNRESVSP64_32:
 		error = compat_ioctl_preallocate(f.file, FALLOC_FL_PUNCH_HOLE,
 				compat_ptr(arg));
-		goto out_fput;
+		break;
 	case FS_IOC_ZERO_RANGE_32:
 		error = compat_ioctl_preallocate(f.file, FALLOC_FL_ZERO_RANGE,
 				compat_ptr(arg));
-		goto out_fput;
-#else
-	case FS_IOC_RESVSP:
-	case FS_IOC_RESVSP64:
-	case FS_IOC_UNRESVSP:
-	case FS_IOC_UNRESVSP64:
-	case FS_IOC_ZERO_RANGE:
-		goto found_handler;
+		break;
 #endif
 
+	/*
+	 * everything else in do_vfs_ioctl() takes either a compatible
+	 * pointer argument or no argument -- call it with a modified
+	 * argument.
+	 */
 	default:
-		if (f.file->f_op->compat_ioctl) {
+		error = do_vfs_ioctl(f.file, fd, cmd,
+				     (unsigned long)compat_ptr(arg));
+		if (error != -ENOIOCTLCMD)
+			break;
+
+		if (f.file->f_op->compat_ioctl)
 			error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
-			if (error != -ENOIOCTLCMD)
-				goto out_fput;
-		}
-		error = -ENOTTY;
-		goto out_fput;
+		if (error == -ENOIOCTLCMD)
+			error = -ENOTTY;
+		break;
 	}
 
- found_handler:
-	arg = (unsigned long)compat_ptr(arg);
- do_ioctl:
-	error = do_vfs_ioctl(f.file, fd, cmd, arg);
- out_fput:
-	fdput(f);
  out:
+	fdput(f);
+
 	return error;
 }
 #endif
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index 8bf3d79f3e82..f3f0b97b1675 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -51,8 +51,6 @@ struct space_resv_32 {
 #define FS_IOC_UNRESVSP64_32	_IOW ('X', 43, struct space_resv_32)
 #define FS_IOC_ZERO_RANGE_32	_IOW ('X', 57, struct space_resv_32)
 
-int compat_ioctl_preallocate(struct file *, int, struct space_resv_32 __user *);
-
 #endif
 
 #endif /* _FALLOC_H_ */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..daf570bca42a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2552,10 +2552,6 @@ extern int finish_open(struct file *file, struct dentry *dentry,
 			int (*open)(struct inode *, struct file *));
 extern int finish_no_open(struct file *file, struct dentry *dentry);
 
-/* fs/ioctl.c */
-
-extern int ioctl_preallocate(struct file *filp, int mode, void __user *argp);
-
 /* fs/dcache.c */
 extern void __init vfs_caches_init_early(void);
 extern void __init vfs_caches_init(void);
-- 
2.20.0


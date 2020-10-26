Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64401298D23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 13:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775577AbgJZMvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 08:51:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39419 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775568AbgJZMvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:51:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id d3so12345351wma.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60C4XPt+sm3xWxPQ15yIvj05ijHp+1cr7XJSkVPOdlQ=;
        b=k6+CO/eMVpf7nk0Z+zyT2QD0McsXDMJKq6/h8JxvmT9qbp9YNrJPBSeW1pVPXd4JDr
         rcPi9pyCGfJ1WSGjPglHY/5puvAN2XPNXWfbPBBOp0Q1i6wqbMhZrF39VsB2VpTErspz
         sQMCaN6mXrPEu7QqJxUM1ekcAEs1AhsiZSwN6YEDLHJVoNV9XnkQcXabe/BJJkWoZQ/m
         vUFI2d4FV1x5EUiC8rIPFGcdnkUgHW2yjvAZDUVpW7tEgmI8Kru4jPnLP5cV/QsUMVRF
         ofEVqpsXT/eMMIqFE3icTEfj5eFfTcXNLcIlabICCA7bZwtalOCa+JxxNI2QkdrLJJBp
         kq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60C4XPt+sm3xWxPQ15yIvj05ijHp+1cr7XJSkVPOdlQ=;
        b=MWiZwt5vGArvZ7Cu7H0Sx8jApZob9zPcdPj5PUD44aevEqyH+4Rm3btTB+HHJc6IVj
         aZJsr6NAsErH/XZE6a4n9zw5cjLnzVPH2FoaU/kPuxRLdesU1+OHxpx0g2ildJcZg53+
         fX+YHo5dbLGHpwwMYKLeHyZzxA7lIrZYp+L1ZMKacm79wHtgJWEoA+nzz55AxyKGLQWy
         kxr2Q2+hrPMdyVi8oqJRhuOAlzBH2/tEbyZrXKGoZ1mpxdweS2CjkhY6+wGHX9877p9t
         UF9Fj2zBIOAb1sBOI3OhUXrO0/RcWfYAGgx5xQm6fHUmYz35CX5IWturkm4eC3oycySf
         E6ZQ==
X-Gm-Message-State: AOAM5315ydrKb7uyJ6vAHwYtFsHaV2PlBVwxJtOVu2wsWWx3jnehu3hy
        j+PbxVjnSlZgr8kjliVShQQePQ==
X-Google-Smtp-Source: ABdhPJxaQQilFc2jTausbEDQ5JIAOX+eUlm5CpkN1Wkq14ZjblcaExyxD6wTiSK9X2jMx4WBvkki8w==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr16055994wmc.34.1603716676810;
        Mon, 26 Oct 2020 05:51:16 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id r1sm24423262wro.18.2020.10.26.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:51:16 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 1/5] fuse: Definitions and ioctl() for passthrough
Date:   Mon, 26 Oct 2020 12:50:12 +0000
Message-Id: <20201026125016.1905945-2-balsini@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201026125016.1905945-1-balsini@android.com>
References: <20201026125016.1905945-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose the FUSE_PASSTHROUGH interface to userspace and declare all the
basic data structures and functions as the skeleton on top of which the
FUSE passthrough functionality will be built.

As part of this, introduce the new FUSE passthrough ioctl(), which allows
the FUSE daemon to specify a direct connection between a FUSE file and a
lower file system file. Such ioctl() requires userspace to pass the file
descriptor of one of its opened files through the fuse_passthrough_out data
structure introduced in this patch. This structure includes extra fields
for possible future extensions.
Also, add the passthrough functions for the set-up and tear-down of the
data structures and locks that will be used both when fuse_conns and
fuse_files are created/deleted.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/Makefile          |  1 +
 fs/fuse/dev.c             | 40 ++++++++++++++++++++++++++++-----------
 fs/fuse/dir.c             |  1 +
 fs/fuse/file.c            |  4 +++-
 fs/fuse/fuse_i.h          | 26 +++++++++++++++++++++++++
 fs/fuse/inode.c           | 18 +++++++++++++++++-
 fs/fuse/passthrough.c     | 21 ++++++++++++++++++++
 include/uapi/linux/fuse.h | 13 +++++++++++--
 8 files changed, 109 insertions(+), 15 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 3e8cebfb59b7..6971454a2bdf 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-objs := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
+fuse-objs += passthrough.o
 virtiofs-y += virtio_fs.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 02b3c36b3676..bcf1da0260bc 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2222,37 +2222,55 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
-	int err = -ENOTTY;
-
-	if (cmd == FUSE_DEV_IOC_CLONE) {
-		int oldfd;
+	int res;
+	int oldfd;
+	struct fuse_dev *fud;
+	struct fuse_passthrough_out pto;
 
-		err = -EFAULT;
-		if (!get_user(oldfd, (__u32 __user *) arg)) {
+	switch (cmd) {
+	case FUSE_DEV_IOC_CLONE:
+		res = -EFAULT;
+		if (!get_user(oldfd, (__u32 __user *)arg)) {
 			struct file *old = fget(oldfd);
 
-			err = -EINVAL;
+			res = -EINVAL;
 			if (old) {
-				struct fuse_dev *fud = NULL;
+				fud = NULL;
 
 				/*
 				 * Check against file->f_op because CUSE
 				 * uses the same ioctl handler.
 				 */
 				if (old->f_op == file->f_op &&
-				    old->f_cred->user_ns == file->f_cred->user_ns)
+				    old->f_cred->user_ns ==
+					    file->f_cred->user_ns)
 					fud = fuse_get_dev(old);
 
 				if (fud) {
 					mutex_lock(&fuse_mutex);
-					err = fuse_device_clone(fud->fc, file);
+					res = fuse_device_clone(fud->fc, file);
 					mutex_unlock(&fuse_mutex);
 				}
 				fput(old);
 			}
 		}
+		break;
+	case FUSE_DEV_IOC_PASSTHROUGH_OPEN:
+		res = -EFAULT;
+		if (!copy_from_user(&pto,
+				    (struct fuse_passthrough_out __user *)arg,
+				    sizeof(pto))) {
+			res = -EINVAL;
+			fud = fuse_get_dev(file);
+			if (fud)
+				res = fuse_passthrough_open(fud, &pto);
+		}
+		break;
+	default:
+		res = -ENOTTY;
+		break;
 	}
-	return err;
+	return res;
 }
 
 const struct file_operations fuse_dev_operations = {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 26f028bc760b..875799959e33 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -489,6 +489,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	ff->fh = outopen.fh;
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopen.open_flags;
+	fuse_passthrough_setup(fc, ff, &outopen);
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
 			  &outentry.attr, entry_attr_timeout(&outentry), 0);
 	if (!inode) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 83d917f7e542..84daaf084197 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -151,7 +151,7 @@ int fuse_do_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 		if (!err) {
 			ff->fh = outarg.fh;
 			ff->open_flags = outarg.open_flags;
-
+			fuse_passthrough_setup(fc, ff, &outarg);
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return err;
@@ -281,6 +281,8 @@ void fuse_release_common(struct file *file, bool isdir)
 	struct fuse_release_args *ra = ff->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
+	fuse_passthrough_release(&ff->passthrough);
+
 	fuse_prepare_release(fi, ff, file->f_flags, opcode);
 
 	if (ff->flock) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740a8a7d7ae6..32da45ce86e0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -163,6 +163,14 @@ enum {
 struct fuse_conn;
 struct fuse_release_args;
 
+/**
+ * Reference to lower filesystem file for read/write operations handled in
+ * passthrough mode
+ */
+struct fuse_passthrough {
+	struct file *filp;
+};
+
 /** FUSE specific file data */
 struct fuse_file {
 	/** Fuse connection for this file */
@@ -208,6 +216,9 @@ struct fuse_file {
 
 	} readdir;
 
+	/** Container for data related to the passthrough functionality */
+	struct fuse_passthrough passthrough;
+
 	/** RB node to be linked on fuse_conn->polled_files */
 	struct rb_node polled_node;
 
@@ -720,6 +731,9 @@ struct fuse_conn {
 	/* Do not show mount options */
 	unsigned int no_mount_options:1;
 
+	/** Passthrough mode for read/write IO */
+	unsigned int passthrough:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
@@ -755,6 +769,12 @@ struct fuse_conn {
 
 	/** List of device instances belonging to this connection */
 	struct list_head devices;
+
+	/** IDR for passthrough requests */
+	struct idr passthrough_req;
+
+	/** Protects passthrough_req */
+	spinlock_t passthrough_req_lock;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
@@ -1093,4 +1113,10 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
 
+int fuse_passthrough_open(struct fuse_dev *fud,
+			  struct fuse_passthrough_out *pto);
+int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
+			   struct fuse_open_out *openarg);
+void fuse_passthrough_release(struct fuse_passthrough *passthrough);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b..6738dd5ff5d2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -621,6 +621,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
 	spin_lock_init(&fc->bg_lock);
+	spin_lock_init(&fc->passthrough_req_lock);
 	init_rwsem(&fc->killsb);
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
@@ -629,6 +630,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
+	idr_init(&fc->passthrough_req);
 	atomic_set(&fc->num_waiting, 0);
 	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
@@ -965,6 +967,12 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
+			if (arg->flags & FUSE_PASSTHROUGH) {
+				fc->passthrough = 1;
+				/* Prevent further stacking */
+				fc->sb->s_stack_depth =
+					FILESYSTEM_MAX_STACK_DEPTH;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1002,7 +1010,8 @@ void fuse_send_init(struct fuse_conn *fc)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
+		FUSE_PASSTHROUGH;
 	ia->args.opcode = FUSE_INIT;
 	ia->args.in_numargs = 1;
 	ia->args.in_args[0].size = sizeof(ia->in);
@@ -1023,9 +1032,16 @@ void fuse_send_init(struct fuse_conn *fc)
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
 
+static int free_fuse_passthrough(int id, void *p, void *data)
+{
+	return 0;
+}
+
 void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
+	idr_for_each(&fc->passthrough_req, free_fuse_passthrough, NULL);
+	idr_destroy(&fc->passthrough_req);
 	kfree_rcu(fc, rcu);
 }
 EXPORT_SYMBOL_GPL(fuse_free_conn);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
new file mode 100644
index 000000000000..594060c654f8
--- /dev/null
+++ b/fs/fuse/passthrough.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "fuse_i.h"
+
+#include <linux/fuse.h>
+
+int fuse_passthrough_open(struct fuse_dev *fud,
+			  struct fuse_passthrough_out *pto)
+{
+	return -EINVAL;
+}
+
+int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
+			   struct fuse_open_out *openarg)
+{
+	return -EINVAL;
+}
+
+void fuse_passthrough_release(struct fuse_passthrough *passthrough)
+{
+}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada89815..ae06efb25d18 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -342,6 +342,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_PASSTHROUGH	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
@@ -591,7 +592,7 @@ struct fuse_create_in {
 struct fuse_open_out {
 	uint64_t	fh;
 	uint32_t	open_flags;
-	uint32_t	padding;
+	uint32_t	passthrough_fh;
 };
 
 struct fuse_release_in {
@@ -794,6 +795,13 @@ struct fuse_in_header {
 	uint32_t	padding;
 };
 
+struct fuse_passthrough_out {
+	uint32_t	fd;
+	/* For future implementation */
+	uint32_t	len;
+	void		*vec;
+};
+
 struct fuse_out_header {
 	uint32_t	len;
 	int32_t		error;
@@ -869,7 +877,8 @@ struct fuse_notify_retrieve_in {
 };
 
 /* Device ioctls: */
-#define FUSE_DEV_IOC_CLONE	_IOR(229, 0, uint32_t)
+#define FUSE_DEV_IOC_CLONE		_IOR(229, 0, uint32_t)
+#define FUSE_DEV_IOC_PASSTHROUGH_OPEN	_IOW(229, 1, struct fuse_passthrough_out)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.29.0.rc1.297.gfa9743e501-goog


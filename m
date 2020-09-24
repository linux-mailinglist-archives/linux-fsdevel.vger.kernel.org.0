Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ADA2771ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIXNN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgIXNNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:13:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582CCC0613CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so3494396wmi.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBqvHPVRVJk3ZG/oqmQk5EP9lqOerQ2Xy+/srUo/wiA=;
        b=uJnlAv/aL1XmuplMzUvcuFvtfX8FJcXsfcQ0tGZX5elBjleB4pW0N8kFqc3qOKw2id
         JEeg85Lwp9w1EPvA0JfS56hn9SQMsYvE1X14ESMEGHkPbUzHLbVbXaixJUeBFZfHs5eV
         k8U+rIkjiFWQ6zVCP6SFBqwzdohotrPG6AuwsUxlehabP/SGYB1QJNAcERujhcGhmeGY
         RMNqS+yh+CoDUjTEikr7hnOxCG2UPmLaikRbZ5JDAMCBBiloi404F73zE/CoAJO7Le1S
         Fq2TUXHu5HKYnkD24iYibBVdYsHfh5jD8fAuapB34ZzKcXpScU85FC1wKY7isHOL0ASw
         Cnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBqvHPVRVJk3ZG/oqmQk5EP9lqOerQ2Xy+/srUo/wiA=;
        b=ckkbxNUL6l+C3EP318MB1r94X3S1O+GOAFVMIMADjtIVLXI35lbuH9luvOqTAxkcs+
         0ZXdv77RKOQ/rDRoG9AsaQTb8kjqO+wDPMHNzZ7y4gIC8Qv3f9IQN2w2RdwDKP2TuqIQ
         45cz1m27yw3Em2zWjwV9g7dKFPog9hTLU/VPkl/ZJbUbCt+MAtf924Dprnlqo9Wyjcfx
         SmI+2WeGHpjONG2xpkQnmjLBLangy4fjvTENMcz6JMBubvgXj3oAL4JUNftbtaxJluD/
         tvK7juEz7yJ7fq3FxVOS94i47TsMEL212xOoyRQl+s1YrEu3FuDGNLGp0dpYtUb22bMu
         bovA==
X-Gm-Message-State: AOAM5312SOYToD6KkrtJj84OBlzrZdXd0yLu0jVcCTB0ZcWd7nQxGTOj
        hsfTC4QrRUp36tT0k+D4bpICjQ==
X-Google-Smtp-Source: ABdhPJxye7QzFtLjQWsUXkCBuiHSS0YdQllP6GH1279i9l5TAnnWnhbtL6m7W4HYsW+eDiM445QJ2Q==
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr4725630wml.121.1600953203881;
        Thu, 24 Sep 2020 06:13:23 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id k22sm3805044wrd.29.2020.09.24.06.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:13:23 -0700 (PDT)
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
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V9 1/4] fuse: Definitions and ioctl() for passthrough
Date:   Thu, 24 Sep 2020 14:13:15 +0100
Message-Id: <20200924131318.2654747-2-balsini@android.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200924131318.2654747-1-balsini@android.com>
References: <20200924131318.2654747-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce the new FUSE passthrough ioctl(), which allows userspace to
specify a direct connection between a FUSE file and a lower file system
file.
Such ioctl() requires userspace to specify:
- the file descriptor of one of its opened files,
- the unique identifier of the FUSE request associated with a pending
  open/create operation,
both encapsulated into a fuse_passthrough_out data structure.
The ioctl() will search for the pending FUSE request matching the unique
identifier, and update the passthrough file pointer of the request with the
file pointer referenced by the passed file descriptor.
When that pending FUSE request is handled, the passthrough file pointer
is copied to the fuse_file data structure, so that the link between FUSE
and lower file system is consolidated.

In order for the passthrough mode to be successfully activated, the lower
file system file must implement both read_ and write_iter file operations.
This extra check avoids special pseudofiles to be targets for this feature.
An additional enforced limitation is that when FUSE passthrough is enabled,
no further file system stacking is allowed.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/Makefile          |  1 +
 fs/fuse/dev.c             | 57 +++++++++++++++++++++++++++++++++++----
 fs/fuse/dir.c             |  2 ++
 fs/fuse/file.c            | 17 +++++++++---
 fs/fuse/fuse_i.h          | 14 ++++++++++
 fs/fuse/inode.c           |  9 ++++++-
 fs/fuse/passthrough.c     | 55 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h | 12 ++++++++-
 8 files changed, 156 insertions(+), 11 deletions(-)
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
index 02b3c36b3676..c31e6c30fabf 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2219,21 +2219,53 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 	return 0;
 }
 
+static int fuse_passthrough_open(struct fuse_dev *fud,
+				 struct fuse_passthrough_out *pto)
+{
+	int ret;
+	struct fuse_req *req;
+	struct fuse_pqueue *fpq = &fud->pq;
+	struct fuse_conn *fc = fud->fc;
+
+	if (!fc->passthrough)
+		return -EPERM;
+
+	/* This field is reserved for future use */
+	if (pto->len != 0)
+		return -EINVAL;
+
+	spin_lock(&fpq->lock);
+	req = request_find(fpq, pto->unique & ~FUSE_INT_REQ_BIT);
+	if (!req) {
+		spin_unlock(&fpq->lock);
+		return -ENOENT;
+	}
+	__fuse_get_request(req);
+	spin_unlock(&fpq->lock);
+
+	ret = fuse_passthrough_setup(req, pto->fd);
+
+	fuse_put_request(fc, req);
+	return ret;
+}
+
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
-	int err = -ENOTTY;
-
-	if (cmd == FUSE_DEV_IOC_CLONE) {
-		int oldfd;
+	int err;
+	int oldfd;
+	struct fuse_dev *fud;
+	struct fuse_passthrough_out pto;
 
+	switch (cmd) {
+	case FUSE_DEV_IOC_CLONE:
 		err = -EFAULT;
 		if (!get_user(oldfd, (__u32 __user *) arg)) {
 			struct file *old = fget(oldfd);
 
 			err = -EINVAL;
 			if (old) {
-				struct fuse_dev *fud = NULL;
+				fud = NULL;
 
 				/*
 				 * Check against file->f_op because CUSE
@@ -2251,6 +2283,21 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 				fput(old);
 			}
 		}
+		break;
+	case FUSE_DEV_IOC_PASSTHROUGH_OPEN:
+		err = -EFAULT;
+		if (!copy_from_user(&pto,
+				    (struct fuse_passthrough_out __user *)arg,
+				    sizeof(pto))) {
+			err = -EINVAL;
+			fud = fuse_get_dev(file);
+			if (fud)
+				err = fuse_passthrough_open(fud, &pto);
+		}
+		break;
+	default:
+		err = -ENOTTY;
+		break;
 	}
 	return err;
 }
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 26f028bc760b..531de0c5c9e8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -477,6 +477,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[0].value = &outentry;
 	args.out_args[1].size = sizeof(outopen);
 	args.out_args[1].value = &outopen;
+	args.passthrough_filp = NULL;
 	err = fuse_simple_request(fc, &args);
 	if (err)
 		goto out_free_ff;
@@ -489,6 +490,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	ff->fh = outopen.fh;
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopen.open_flags;
+	ff->passthrough_filp = args.passthrough_filp;
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
 			  &outentry.attr, entry_attr_timeout(&outentry), 0);
 	if (!inode) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 83d917f7e542..6c0ec742ce74 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -33,10 +33,12 @@ static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 }
 
 static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
-			  int opcode, struct fuse_open_out *outargp)
+			  int opcode, struct fuse_open_out *outargp,
+			  struct file **passthrough_filp)
 {
 	struct fuse_open_in inarg;
 	FUSE_ARGS(args);
+	int ret;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
@@ -51,7 +53,10 @@ static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 	args.out_args[0].size = sizeof(*outargp);
 	args.out_args[0].value = outargp;
 
-	return fuse_simple_request(fc, &args);
+	ret = fuse_simple_request(fc, &args);
+	*passthrough_filp = args.passthrough_filp;
+
+	return ret;
 }
 
 struct fuse_release_args {
@@ -144,14 +149,16 @@ int fuse_do_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 	/* Default for no-open */
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
 	if (isdir ? !fc->no_opendir : !fc->no_open) {
+		struct file *passthrough_filp;
 		struct fuse_open_out outarg;
 		int err;
 
-		err = fuse_send_open(fc, nodeid, file, opcode, &outarg);
+		err = fuse_send_open(fc, nodeid, file, opcode, &outarg,
+				     &passthrough_filp);
 		if (!err) {
 			ff->fh = outarg.fh;
 			ff->open_flags = outarg.open_flags;
-
+			ff->passthrough_filp = passthrough_filp;
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return err;
@@ -281,6 +288,8 @@ void fuse_release_common(struct file *file, bool isdir)
 	struct fuse_release_args *ra = ff->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
+	fuse_passthrough_release(ff);
+
 	fuse_prepare_release(fi, ff, file->f_flags, opcode);
 
 	if (ff->flock) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740a8a7d7ae6..6c5166447905 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -208,6 +208,12 @@ struct fuse_file {
 
 	} readdir;
 
+	/**
+	 * Reference to lower filesystem file for read/write operations
+	 * handled in pass-through mode
+	 */
+	struct file *passthrough_filp;
+
 	/** RB node to be linked on fuse_conn->polled_files */
 	struct rb_node polled_node;
 
@@ -250,6 +256,8 @@ struct fuse_args {
 	bool page_zeroing:1;
 	bool page_replace:1;
 	bool may_block:1;
+	/** Lower filesystem file pointer used in pass-through mode */
+	struct file *passthrough_filp;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_conn *fc, struct fuse_args *args, int error);
@@ -720,6 +728,9 @@ struct fuse_conn {
 	/* Do not show mount options */
 	unsigned int no_mount_options:1;
 
+	/** Pass-through mode for read/write IO */
+	unsigned int passthrough:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
@@ -1093,4 +1104,7 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
 
+int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd);
+void fuse_passthrough_release(struct fuse_file *ff);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b..eb223130a917 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -965,6 +965,12 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
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
@@ -1002,7 +1008,8 @@ void fuse_send_init(struct fuse_conn *fc)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
+		FUSE_PASSTHROUGH;
 	ia->args.opcode = FUSE_INIT;
 	ia->args.in_numargs = 1;
 	ia->args.in_args[0].size = sizeof(ia->in);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
new file mode 100644
index 000000000000..86ab4eafa7bf
--- /dev/null
+++ b/fs/fuse/passthrough.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "fuse_i.h"
+
+int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd)
+{
+	int ret;
+	int fs_stack_depth;
+	struct file *passthrough_filp;
+	struct inode *passthrough_inode;
+	struct super_block *passthrough_sb;
+
+	/* Passthrough mode can only be enabled at file open/create time */
+	if (req->in.h.opcode != FUSE_OPEN && req->in.h.opcode != FUSE_CREATE) {
+		pr_err("FUSE: invalid OPCODE for request.\n");
+		return -EINVAL;
+	}
+
+	passthrough_filp = fget(fd);
+	if (!passthrough_filp) {
+		pr_err("FUSE: invalid file descriptor for passthrough.\n");
+		return -EINVAL;
+	}
+
+	ret = -EINVAL;
+	if (!passthrough_filp->f_op->read_iter ||
+	    !passthrough_filp->f_op->write_iter) {
+		pr_err("FUSE: passthrough file misses file operations.\n");
+		goto out;
+	}
+
+	passthrough_inode = file_inode(passthrough_filp);
+	passthrough_sb = passthrough_inode->i_sb;
+	fs_stack_depth = passthrough_sb->s_stack_depth + 1;
+	ret = -EEXIST;
+	if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
+		pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
+		goto out;
+	}
+
+	req->args->passthrough_filp = passthrough_filp;
+	return 0;
+out:
+	fput(passthrough_filp);
+	return ret;
+}
+
+void fuse_passthrough_release(struct fuse_file *ff)
+{
+	if (!ff->passthrough_filp)
+		return;
+
+	fput(ff->passthrough_filp);
+	ff->passthrough_filp = NULL;
+}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada89815..0cd9fd83374a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -342,6 +342,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_PASSTHROUGH	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
@@ -794,6 +795,14 @@ struct fuse_in_header {
 	uint32_t	padding;
 };
 
+struct fuse_passthrough_out {
+	uint64_t	unique;
+	uint32_t	fd;
+	/* For future implementation */
+	uint32_t	len;
+	void		*vec;
+};
+
 struct fuse_out_header {
 	uint32_t	len;
 	int32_t		error;
@@ -869,7 +878,8 @@ struct fuse_notify_retrieve_in {
 };
 
 /* Device ioctls: */
-#define FUSE_DEV_IOC_CLONE	_IOR(229, 0, uint32_t)
+#define FUSE_DEV_IOC_CLONE		_IOR(229, 0, uint32_t)
+#define FUSE_DEV_IOC_PASSTHROUGH_OPEN	_IOW(229, 1, struct fuse_passthrough_out)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.28.0.681.g6f77f65b4e-goog


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B047097D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjESM6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjESM6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39511721
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so20135665e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501036; x=1687093036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dreSN/TBgcGUDPBpo8j2BcwxfJZGtLQsZegjRf4HyVg=;
        b=bATZ29LaC7WcoPUxX1wohQTwG/l7CjLyqAR02HONigB5ci6pQCsZroT9dzfI9TC0OP
         k6z6keTzgvPHdn+VgWAnJu0SmOXZoOcx1Pd/Q6YjDl3BwjYiJc51o2Qd+c8byUwfQRkg
         OW/cPOW9N3LsevlTjxp5IFdy4WEtMYWbcLQvQQLTL4m1oWwsIrb045uNXugIhS3NMfju
         KqaC7mwz9fKpJOHVRXREwWRKWbIRbh90NPgiDJlyhDKUjVChNc6OvqembcfiED8m5LVU
         E3slWYlvoQwIoWb5FwIN0cWn0XDmAkhlQJsJWO/j8pqZ8Y/gZ2nUdW56JDxu4cP859RG
         opOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501036; x=1687093036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dreSN/TBgcGUDPBpo8j2BcwxfJZGtLQsZegjRf4HyVg=;
        b=Udbbq4jAwAqp6BVX7oEt8dgw73S02qeIdEE2RhQ77h3CiimSB3x2OPpz+de0ghuIyf
         n9P2FrG6O5tpv7dgCun8XmomIdX488Lj6SOBPrxUKn6k28lQs0sn+ec+tgpAlAEFap2D
         T3PkW6tPIerr4/Re+76EHGw1AJ5gloSIth4wzY/YIexvPgbnVnHu0YAhBpjlfO8fa4+L
         45Tk8nRLOJ64pl8Vgitl4kOVOy1aSVbqUND4GyvmPqDwGAUksox9M8ZPk5i0URV42vey
         VwonAjWr9UyyaLJC86vlc7lIK+AP4oZRblICHKGz6APZwGvDEUPPT7mVWNsUFFGtnqv0
         vPwA==
X-Gm-Message-State: AC+VfDyAotDJs4vQM3/1yJY2+e4qz5TjpOQGyhyxAGk90gAItghjwzdl
        2HmV8VGydyhJZDPp7N/k2RM=
X-Google-Smtp-Source: ACHHUZ7PnWis1BMCXCSABf5uC3MfM5BT4Ena888AsZRzD6lymxE5HEi9yQIw+PWig0zzvf/4TPv3PQ==
X-Received: by 2002:adf:e781:0:b0:306:3284:824f with SMTP id n1-20020adfe781000000b003063284824fmr1777334wrm.8.1684501035829;
        Fri, 19 May 2023 05:57:15 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 02/10] fuse: Definitions and ioctl for passthrough
Date:   Fri, 19 May 2023 15:56:57 +0300
Message-Id: <20230519125705.598234-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519125705.598234-1-amir73il@gmail.com>
References: <20230519125705.598234-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alessio Balsini <balsini@android.com>

Expose the FUSE_PASSTHROUGH capability to user space and declare all the
basic data structures and functions as the skeleton on top of which the
FUSE passthrough functionality will be built.

As part of this, introduce the new FUSE passthrough ioctl, which allows
the FUSE daemon to specify a direct connection between a FUSE file and a
backing file.  The ioctl requires user space to pass the file descriptor
of one of its opened files to the FUSE driver and get an id in return.
This id may be passed in a reply to OPEN with flag FOPEN_PASSTHROUGH
to setup passthrough of read/write operations on the open file.

Also, add the passthrough functions for the set-up and tear-down of the
data structures and locks that will be used both when fuse_conns and
fuse_files are created/deleted.

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/Makefile          |  1 +
 fs/fuse/dev.c             | 33 ++++++++++++++++++++++++--------
 fs/fuse/dir.c             |  7 ++++++-
 fs/fuse/file.c            | 17 +++++++++++++----
 fs/fuse/fuse_i.h          | 27 ++++++++++++++++++++++++++
 fs/fuse/inode.c           | 21 +++++++++++++++++++-
 fs/fuse/passthrough.c     | 40 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h | 13 +++++++++++--
 8 files changed, 143 insertions(+), 16 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 0c48b35c058d..d9e1b47382f3 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
+fuse-y += passthrough.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..cb00234e7843 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2255,16 +2255,19 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
 	int res;
-	int oldfd;
-	struct fuse_dev *fud = NULL;
+	int fd, id;
+	struct fuse_dev *fud = fuse_get_dev(file);
 	struct fd f;
 
+	if (!fud)
+		return -EINVAL;
+
 	switch (cmd) {
 	case FUSE_DEV_IOC_CLONE:
-		if (get_user(oldfd, (__u32 __user *)arg))
+		if (get_user(fd, (__u32 __user *)arg))
 			return -EFAULT;
 
-		f = fdget(oldfd);
+		f = fdget(fd);
 		if (!f.file)
 			return -EINVAL;
 
@@ -2272,17 +2275,31 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		 * Check against file->f_op because CUSE
 		 * uses the same ioctl handler.
 		 */
-		if (f.file->f_op == file->f_op)
-			fud = fuse_get_dev(f.file);
-
 		res = -EINVAL;
-		if (fud) {
+		if (f.file->f_op == file->f_op) {
 			mutex_lock(&fuse_mutex);
 			res = fuse_device_clone(fud->fc, file);
 			mutex_unlock(&fuse_mutex);
 		}
 		fdput(f);
 		break;
+	case FUSE_DEV_IOC_PASSTHROUGH_OPEN:
+		if (get_user(fd, (__u32 __user *)arg))
+			return -EFAULT;
+
+		f = fdget(fd);
+		if (!f.file)
+			return -EINVAL;
+
+		res = fuse_passthrough_open(fud->fc, fd);
+		fdput(f);
+		break;
+	case FUSE_DEV_IOC_PASSTHROUGH_CLOSE:
+		if (get_user(id, (__u32 __user *)arg))
+			return -EFAULT;
+
+		res = fuse_passthrough_close(fud->fc, id);
+		break;
 	default:
 		res = -ENOTTY;
 		break;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 35bc174f9ba2..1894298e7f7a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -619,6 +619,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 {
 	int err;
 	struct inode *inode;
+	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
 	struct fuse_forget_link *forget;
@@ -700,7 +701,11 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	d_instantiate(entry, inode);
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_dir_changed(dir);
-	err = finish_open(file, entry, generic_file_open);
+	err = 0;
+	if (ff->open_flags & FOPEN_PASSTHROUGH)
+		err = fuse_passthrough_setup(fc, ff, &outopen);
+	if (!err)
+		err = finish_open(file, entry, generic_file_open);
 	if (err) {
 		fi = get_fuse_inode(inode);
 		fuse_sync_release(fi, ff, flags);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 89d97f6188e0..96a46a5aa892 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -132,6 +132,7 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
+	int err;
 
 	ff = fuse_file_alloc(fm);
 	if (!ff)
@@ -142,16 +143,17 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
 	if (isdir ? !fc->no_opendir : !fc->no_open) {
 		struct fuse_open_out outarg;
-		int err;
 
 		err = fuse_send_open(fm, nodeid, open_flags, opcode, &outarg);
 		if (!err) {
 			ff->fh = outarg.fh;
 			ff->open_flags = outarg.open_flags;
-
+			if (ff->open_flags & FOPEN_PASSTHROUGH)
+				err = fuse_passthrough_setup(fc, ff, &outarg);
+			if (err)
+				goto out_free_ff;
 		} else if (err != -ENOSYS) {
-			fuse_file_free(ff);
-			return ERR_PTR(err);
+			goto out_free_ff;
 		} else {
 			if (isdir)
 				fc->no_opendir = 1;
@@ -166,6 +168,10 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	ff->nodeid = nodeid;
 
 	return ff;
+
+out_free_ff:
+	fuse_file_free(ff);
+	return ERR_PTR(err);
 }
 
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
@@ -279,6 +285,9 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = ff->release_args;
 
+	fuse_passthrough_put(ff->passthrough);
+	ff->passthrough = NULL;
+
 	/* Inode is NULL on error path of fuse_create_open() */
 	if (likely(fi)) {
 		spin_lock(&fi->lock);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..f52604534ff6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -173,6 +173,16 @@ struct fuse_conn;
 struct fuse_mount;
 struct fuse_release_args;
 
+/**
+ * Reference to backing file for read/write operations in passthrough mode.
+ */
+struct fuse_passthrough {
+	struct file *filp;
+
+	/** refcount */
+	refcount_t count;
+};
+
 /** FUSE specific file data */
 struct fuse_file {
 	/** Fuse connection for this file */
@@ -218,6 +228,9 @@ struct fuse_file {
 
 	} readdir;
 
+	/** Container for data related to the passthrough functionality */
+	struct fuse_passthrough *passthrough;
+
 	/** RB node to be linked on fuse_conn->polled_files */
 	struct rb_node polled_node;
 
@@ -792,6 +805,9 @@ struct fuse_conn {
 	/* Is tmpfile not implemented by fs? */
 	unsigned int no_tmpfile:1;
 
+	/** Passthrough mode for read/write IO */
+	unsigned int passthrough:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
@@ -841,6 +857,9 @@ struct fuse_conn {
 
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
+
+	/** IDR for passthrough files */
+	struct idr passthrough_files_map;
 };
 
 /*
@@ -1324,4 +1343,12 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
+/* passthrough.c */
+int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd);
+int fuse_passthrough_close(struct fuse_conn *fc, int passthrough_fh);
+int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
+			   struct fuse_open_out *openarg);
+void fuse_passthrough_put(struct fuse_passthrough *passthrough);
+void fuse_passthrough_free(struct fuse_passthrough *passthrough);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d66070af145d..271586fac008 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -840,6 +840,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
+	idr_init(&fc->passthrough_files_map);
 	atomic_set(&fc->num_waiting, 0);
 	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
@@ -1209,6 +1210,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->init_security = 1;
 			if (flags & FUSE_CREATE_SUPP_GROUP)
 				fc->create_supp_group = 1;
+			if (flags & FUSE_PASSTHROUGH) {
+				fc->passthrough = 1;
+				/* Prevent further stacking */
+				fm->sb->s_stack_depth =
+					FILESYSTEM_MAX_STACK_DEPTH;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1254,7 +1261,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
-		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP;
+		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
+		FUSE_PASSTHROUGH;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1287,9 +1295,20 @@ void fuse_send_init(struct fuse_mount *fm)
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
 
+static int fuse_passthrough_id_free(int id, void *p, void *data)
+{
+	struct fuse_passthrough *passthrough = p;
+
+	WARN_ON_ONCE(refcount_read(&passthrough->count) != 1);
+	fuse_passthrough_free(passthrough);
+	return 0;
+}
+
 void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
+	idr_for_each(&fc->passthrough_files_map, fuse_passthrough_id_free, NULL);
+	idr_destroy(&fc->passthrough_files_map);
 	kfree_rcu(fc, rcu);
 }
 EXPORT_SYMBOL_GPL(fuse_free_conn);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
new file mode 100644
index 000000000000..fc723e004de9
--- /dev/null
+++ b/fs/fuse/passthrough.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "fuse_i.h"
+
+#include <linux/file.h>
+
+/*
+ * Returns passthrough_fh id that can be passed with FOPEN_PASSTHROUGH
+ * open response and needs to be released with fuse_passthrough_close().
+ */
+int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd)
+{
+	return -EINVAL;
+}
+
+int fuse_passthrough_close(struct fuse_conn *fc, int passthrough_fh)
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
+void fuse_passthrough_put(struct fuse_passthrough *passthrough)
+{
+	if (passthrough && refcount_dec_and_test(&passthrough->count))
+		fuse_passthrough_free(passthrough);
+}
+
+void fuse_passthrough_free(struct fuse_passthrough *passthrough)
+{
+	if (passthrough && passthrough->filp) {
+		fput(passthrough->filp);
+		passthrough->filp = NULL;
+	}
+	kfree(passthrough);
+}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1b9d0dfae72d..3da1f59007cf 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -206,6 +206,10 @@
  *  - add extension header
  *  - add FUSE_EXT_GROUPS
  *  - add FUSE_CREATE_SUPP_GROUP
+ *
+ *  7.39
+ *  - add FUSE_PASSTHROUGH
+ *  - add FOPEN_PASSTHROUGH
  */
 
 #ifndef _LINUX_FUSE_H
@@ -241,7 +245,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 38
+#define FUSE_KERNEL_MINOR_VERSION 39
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -314,6 +318,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_PASSTHROUGH: passthrough read/write operations for this open file
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -322,6 +327,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_PASSTHROUGH	(1 << 7)
 
 /**
  * INIT request/reply flags
@@ -406,6 +412,7 @@ struct fuse_file_lock {
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
+#define FUSE_PASSTHROUGH	(1ULL << 35)
 
 /**
  * CUSE INIT request/reply flags
@@ -698,7 +705,7 @@ struct fuse_create_in {
 struct fuse_open_out {
 	uint64_t	fh;
 	uint32_t	open_flags;
-	uint32_t	padding;
+	uint32_t	passthrough_fh;
 };
 
 struct fuse_release_in {
@@ -989,6 +996,8 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_PASSTHROUGH_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, uint32_t)
+#define FUSE_DEV_IOC_PASSTHROUGH_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.34.1


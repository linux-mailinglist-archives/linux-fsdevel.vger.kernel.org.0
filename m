Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4F2FAA91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394134AbhARTrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437149AbhART3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:29:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11909C0613ED
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:28:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so14084162wrt.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3k05/m40uRSR4btPvYI6O7vzuohmBj54ewg28obuXZU=;
        b=nZDmKYIXzl861tJAcwM89zznkxpBoMcaHlk5cSa3XXPQ816dU/V/qhnZ49JFC/qO/j
         SA9jZ0WtrLMnF3V9AdRUDzG6VKTDSh+EGEthJVYYLc/PFiT2sxMu5nXyYM/OPSF12cTh
         wl8qZEscGHjebta6jda/lriFrpZVAVDPz8RagGg6VJLdDTkIuBw7eu+QSwzHKxBv5w9v
         hZKJw25+WeK3TsGxBkTIrjEK9kskMAm/qXur07QsbXjxdY8V7pRL8+y/TTwPizo6L52o
         JrVPog2T2yCgPqkEfkmpc44oZA0zNPMZqioQudLGTa1hrgz7XI+fsDsuVwKcK+8rkQUK
         guXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3k05/m40uRSR4btPvYI6O7vzuohmBj54ewg28obuXZU=;
        b=TRAjlSzelQHQ707NGZKSkERNZudtEa/JO8MPaAvjkmXHnpJoGS6naWMKtIWmFHaOJ1
         kDNbtgDORGLH7AY/8fBB0RqmLfiwP0/DcWqXeF3y3OpYHYNRcO/OaoEOUdfSMR91k4ZK
         V5ZboBOWJU9MnRBbG2u2dkJdyZG7natIWu2CdSWz2RH+w5JqB6+e2CUWc/KxpTog9OlB
         cmArdx9IialvgSvy6/vaqBk2RGjEJWFz8KCJm3/lv20d/IP/ZRuXmlQ8TsMvllEVKvSs
         ww0kQX4Fo4UM4JRX/1IV+IVmpPSQzfZKhITIqWUdn0J1VflNxtlUTgb982mq3T5uLWmL
         mrNw==
X-Gm-Message-State: AOAM533RkB7RLa/qk6lt6kktKuh8x7vQ7bC7tV5F8mq6rIJHP1jtPR4M
        x+8NH3/OTA3g75yNx9yznRmVsQ==
X-Google-Smtp-Source: ABdhPJyThWJNToHWhfUv81OXPFVc+87u9jbQkd3kcFTrPWs3NJlT/dBZNraLzq9/T1LLX5S5lQo3gQ==
X-Received: by 2002:a05:6000:222:: with SMTP id l2mr944199wrz.392.1610998135725;
        Mon, 18 Jan 2021 11:28:55 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id h5sm33583299wrp.56.2021.01.18.11.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:28:55 -0800 (PST)
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
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND V11 3/7] fuse: Definitions and ioctl for passthrough
Date:   Mon, 18 Jan 2021 19:27:44 +0000
Message-Id: <20210118192748.584213-4-balsini@android.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210118192748.584213-1-balsini@android.com>
References: <20210118192748.584213-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose the FUSE_PASSTHROUGH interface to user space and declare all the
basic data structures and functions as the skeleton on top of which the
FUSE passthrough functionality will be built.

As part of this, introduce the new FUSE passthrough ioctl(), which
allows the FUSE daemon to specify a direct connection between a FUSE
file and a lower file system file. Such ioctl() requires users pace to
pass the file descriptor of one of its opened files through the
fuse_passthrough_out data structure introduced in this patch. This
structure includes extra fields for possible future extensions.
Also, add the passthrough functions for the set-up and tear-down of the
data structures and locks that will be used both when fuse_conns and
fuse_files are created/deleted.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/Makefile          |  1 +
 fs/fuse/dev.c             | 12 ++++++++++++
 fs/fuse/dir.c             |  2 ++
 fs/fuse/file.c            |  4 +++-
 fs/fuse/fuse_i.h          | 27 +++++++++++++++++++++++++++
 fs/fuse/inode.c           | 17 ++++++++++++++++-
 fs/fuse/passthrough.c     | 21 +++++++++++++++++++++
 include/uapi/linux/fuse.h | 11 ++++++++++-
 8 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 8c7021fb2cd4..20ed23aa16fa 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
+fuse-y += passthrough.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ff9f3b83f879..5446f13db5a0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2236,6 +2236,7 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	int res;
 	int oldfd;
 	struct fuse_dev *fud = NULL;
+	struct fuse_passthrough_out pto;
 
 	if (_IOC_TYPE(cmd) != FUSE_DEV_IOC_MAGIC)
 		return -EINVAL;
@@ -2266,6 +2267,17 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			}
 		}
 		break;
+	case _IOC_NR(FUSE_DEV_IOC_PASSTHROUGH_OPEN):
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
 	default:
 		res = -ENOTTY;
 		break;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 78f9f209078c..c9a1b33c5481 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -513,6 +513,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 {
 	int err;
 	struct inode *inode;
+	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
 	struct fuse_forget_link *forget;
@@ -574,6 +575,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	ff->fh = outopen.fh;
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopen.open_flags;
+	fuse_passthrough_setup(fc, ff, &outopen);
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
 			  &outentry.attr, entry_attr_timeout(&outentry), 0);
 	if (!inode) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..953f3034c375 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -158,7 +158,7 @@ int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		if (!err) {
 			ff->fh = outarg.fh;
 			ff->open_flags = outarg.open_flags;
-
+			fuse_passthrough_setup(fc, ff, &outarg);
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return err;
@@ -304,6 +304,8 @@ void fuse_release_common(struct file *file, bool isdir)
 	struct fuse_release_args *ra = ff->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
+	fuse_passthrough_release(&ff->passthrough);
+
 	fuse_prepare_release(fi, ff, file->f_flags, opcode);
 
 	if (ff->flock) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7c4b8cb93f9f..8d39f5304a11 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -180,6 +180,14 @@ struct fuse_conn;
 struct fuse_mount;
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
@@ -225,6 +233,9 @@ struct fuse_file {
 
 	} readdir;
 
+	/** Container for data related to the passthrough functionality */
+	struct fuse_passthrough passthrough;
+
 	/** RB node to be linked on fuse_conn->polled_files */
 	struct rb_node polled_node;
 
@@ -755,6 +766,9 @@ struct fuse_conn {
 	/* Auto-mount submounts announced by the server */
 	unsigned int auto_submounts:1;
 
+	/** Passthrough mode for read/write IO */
+	unsigned int passthrough:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
@@ -798,6 +812,12 @@ struct fuse_conn {
 
 	/** List of filesystems using this connection */
 	struct list_head mounts;
+
+	/** IDR for passthrough requests */
+	struct idr passthrough_req;
+
+	/** Protects passthrough_req */
+	spinlock_t passthrough_req_lock;
 };
 
 /*
@@ -1213,4 +1233,11 @@ void fuse_dax_inode_cleanup(struct inode *inode);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
 
+/* passthrough.c */
+int fuse_passthrough_open(struct fuse_dev *fud,
+			  struct fuse_passthrough_out *pto);
+int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
+			   struct fuse_open_out *openarg);
+void fuse_passthrough_release(struct fuse_passthrough *passthrough);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b0e18b470e91..d5c46eafb419 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -691,6 +691,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
 	spin_lock_init(&fc->bg_lock);
+	spin_lock_init(&fc->passthrough_req_lock);
 	init_rwsem(&fc->killsb);
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
@@ -699,6 +700,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
+	idr_init(&fc->passthrough_req);
 	atomic_set(&fc->num_waiting, 0);
 	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
@@ -1052,6 +1054,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->handle_killpriv_v2 = 1;
 				fm->sb->s_flags |= SB_NOSEC;
 			}
+			if (arg->flags & FUSE_PASSTHROUGH) {
+				fc->passthrough = 1;
+				/* Prevent further stacking */
+				fm->sb->s_stack_depth =
+					FILESYSTEM_MAX_STACK_DEPTH + 1;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1095,7 +1103,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
-		FUSE_HANDLE_KILLPRIV_V2;
+		FUSE_HANDLE_KILLPRIV_V2 | FUSE_PASSTHROUGH;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		ia->in.flags |= FUSE_MAP_ALIGNMENT;
@@ -1123,9 +1131,16 @@ void fuse_send_init(struct fuse_mount *fm)
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
index 54442612c48b..9d7685ce0acd 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -360,6 +360,7 @@ struct fuse_file_lock {
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
+#define FUSE_PASSTHROUGH	(1 << 29)
 
 /**
  * CUSE INIT request/reply flags
@@ -625,7 +626,7 @@ struct fuse_create_in {
 struct fuse_open_out {
 	uint64_t	fh;
 	uint32_t	open_flags;
-	uint32_t	padding;
+	uint32_t	passthrough_fh;
 };
 
 struct fuse_release_in {
@@ -828,6 +829,13 @@ struct fuse_in_header {
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
@@ -905,6 +913,7 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_PASSTHROUGH_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, struct fuse_passthrough_out)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.30.0.284.gd98b1dd5eaa7-goog


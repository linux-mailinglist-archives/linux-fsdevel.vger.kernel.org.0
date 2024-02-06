Return-Path: <linux-fsdevel+bounces-10476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F24984B7C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF276B26825
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF613249F;
	Tue,  6 Feb 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfuwkirq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A16132466
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229505; cv=none; b=ClOg9TDRShLUODK+EOCDOHG/jcKAJadQA0HRcJPvcwsQW3fHDZZ6KxgRNyfnPALQ5McptycbCAjFQ9BhNMNXx76XI/7mKOWHQkRQ4D5E3Wc3n0wM8Eb/LQZ0xARXCJZYwLvfh3ztWa1Jzj0XOYn6+/Fnu69DXTLpd8KoJ27M8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229505; c=relaxed/simple;
	bh=Kq+2LDxQXYPBmn7BmyHfD9Zo7QZ74NQHanx4ZCrmJuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s9n/1IYin3aF6e3caoddyW0fZCeDty6sPoxTLZd/IX7JOGEtVF5fP1rHCm/RMAz+VYVp2PTGmSpcNNAlWrF1XuZc8NSMimjyZccCnQX4PhTPv91TI3hy41nm+I/yLkJGyJPNNF4OSB0wJ7c/2N52Ghc7u7flwDUTvUDxEPpmnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfuwkirq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fe00cb134so9828225e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229502; x=1707834302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+txD8wS3djRCj/7PZtcxqCRkr/lkZ8VWSwV0UYsjoA=;
        b=SfuwkirqSJu6ohBAqjtYZ43Q/Tec6J4keBEF5/NCdNKU9zfOMLBanUEqlQfaHPi51Y
         +y1QoCEM0bzNn96sJzbbkS8WUnckqTrmM+zCtlI9YXiK0Im9K0aOrFgCQ/PNiLySGlRA
         ExY0Pn1dRX9ZVZyrV0m8zys2W6Y9FVJliiwffKORydxaBpJcLGGniDerwzvDVLAzoIRG
         V4brepWE31qwecGN5ocgZcFj7sTDs74/YkW2UkX7i4m9sLzAYK+YzajemJyP3/01YBfb
         QWNHY5b2vxIVW1DfQPePFYTH6dAKMcSgjBWF3vCYkg3s6zXa7ZNOG2Jukpodiu8X8H+3
         f+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229502; x=1707834302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+txD8wS3djRCj/7PZtcxqCRkr/lkZ8VWSwV0UYsjoA=;
        b=rY50szAYaKoMxfGje5Uyyq6BYHN42T35ZfIdiGCDNWKaMS6GN18JxT55J0JRvcIb3N
         L+I3hdcP0WSJBp8+KxU+//aQ4mILT5GxGXhtSEfybyRxg1E2Y3MCDuEeM+I+WiEFEt7z
         oAjKX32/o5IkB8QFvLI2jSm3RjvQDzywTDqiCqN6Af6AfiYqMjR7YW+S/PfbsB0ZLa4a
         VV8TDvQznzSlogc7W3LxmWJ7Few0E1D480QcOlzU3p0Cy3E1824fCtH4faEPg8wkq9Ao
         W5yLQrxqBVYtzZEU8ch1ClWdMwk5f9i+OBghn8xYhA8BltrekoL9b6TuKG3hjIVOqteu
         2ixg==
X-Gm-Message-State: AOJu0Yz72/hwneD51RGHAVmiv/31SzCYuHQYSHUPxx+V/h9rO6Mz0//9
	9GPgTIdvu7E3mFJxggqGtNzVAPMiwNWXdJRl+ByMFsiB8hEdA9ir+6OnPH1/
X-Google-Smtp-Source: AGHT+IF6j8Xb3J+U29DA1otBcDZZnJdRMIOV7YhnaVB6FtU3g09yY0eXjc+tNDheAPaxrWTwFRIb7A==
X-Received: by 2002:a5d:678a:0:b0:33b:28ee:645d with SMTP id v10-20020a5d678a000000b0033b28ee645dmr1430668wru.68.1707229501469;
        Tue, 06 Feb 2024 06:25:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVl44A0SHBaodF3J3AnN5dMa0R1kAuoweB1RuoYtpW3eG+UcIHrYVbVrzlBJhQFU+T06SQDN+Kv0/zzm5N3V7y5+qcV+EObdasRHrIIVw==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:25:01 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 2/9] fuse: introduce FUSE_PASSTHROUGH capability
Date: Tue,  6 Feb 2024 16:24:46 +0200
Message-Id: <20240206142453.1906268-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206142453.1906268-1-amir73il@gmail.com>
References: <20240206142453.1906268-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE_PASSTHROUGH capability to passthrough FUSE operations to backing
files will be made available with kernel config CONFIG_FUSE_PASSTHROUGH.

When requesting FUSE_PASSTHROUGH, userspace needs to specify the
max_stack_depth that is allowed for FUSE on top of backing files.

Introduce the flag FOPEN_PASSTHROUGH and backing_id to fuse_open_out
argument that can be used when replying to OPEN request, to setup
passthrough of io operations on the fuse inode to a backing file.

Introduce a refcounted fuse_backing object that will be used to
associate an open backing file with a fuse inode.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/Kconfig           | 11 ++++++++++
 fs/fuse/Makefile          |  1 +
 fs/fuse/fuse_i.h          | 42 +++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           | 26 ++++++++++++++++++++++++
 fs/fuse/passthrough.c     | 30 ++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h | 14 ++++++++++---
 6 files changed, 121 insertions(+), 3 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 038ed0b9aaa5..8674dbfbe59d 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -52,3 +52,14 @@ config FUSE_DAX
 
 	  If you want to allow mounting a Virtio Filesystem with the "dax"
 	  option, answer Y.
+
+config FUSE_PASSTHROUGH
+	bool "FUSE passthrough operations support"
+	default y
+	depends on FUSE_FS
+	select FS_STACK
+	help
+	  This allows bypassing FUSE server by mapping specific FUSE operations
+	  to be performed directly on a backing file.
+
+	  If you want to allow passthrough operations, answer Y.
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index b734cc2a5e65..6e0228c6d0cb 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
+fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index dede4378c719..cae525147856 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -76,6 +76,15 @@ struct fuse_submount_lookup {
 	struct fuse_forget_link *forget;
 };
 
+/** Container for data related to mapping to backing file */
+struct fuse_backing {
+	struct file *file;
+
+	/** refcount */
+	refcount_t count;
+	struct rcu_head rcu;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -179,6 +188,10 @@ struct fuse_inode {
 #endif
 	/** Submount specific lookup tracking */
 	struct fuse_submount_lookup *submount_lookup;
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	/** Reference to backing file in passthrough mode */
+	struct fuse_backing *fb;
+#endif
 };
 
 /** FUSE inode state bits */
@@ -829,6 +842,12 @@ struct fuse_conn {
 	/* Is statx not implemented by fs? */
 	unsigned int no_statx:1;
 
+	/** Passthrough support for read/write IO */
+	unsigned int passthrough:1;
+
+	/** Maximum stack depth for passthrough backing files */
+	int max_stack_depth;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
@@ -1373,4 +1392,27 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
+/* passthrough.c */
+static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode *fi)
+{
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	return READ_ONCE(fi->fb);
+#else
+	return NULL;
+#endif
+}
+
+static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_inode *fi,
+							  struct fuse_backing *fb)
+{
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	return xchg(&fi->fb, fb);
+#else
+	return NULL;
+#endif
+}
+
+struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
+void fuse_backing_put(struct fuse_backing *fb);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..c771bd3c1336 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -111,6 +111,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	if (IS_ENABLED(CONFIG_FUSE_DAX) && !fuse_dax_inode_alloc(sb, fi))
 		goto out_free_forget;
 
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		fuse_inode_backing_set(fi, NULL);
+
 	return &fi->inode;
 
 out_free_forget:
@@ -129,6 +132,9 @@ static void fuse_free_inode(struct inode *inode)
 #ifdef CONFIG_FUSE_DAX
 	kfree(fi->dax);
 #endif
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		fuse_backing_put(fuse_inode_backing(fi));
+
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
@@ -1284,6 +1290,24 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->create_supp_group = 1;
 			if (flags & FUSE_DIRECT_IO_ALLOW_MMAP)
 				fc->direct_io_allow_mmap = 1;
+			/*
+			 * max_stack_depth is the max stack depth of FUSE fs,
+			 * so it has to be at least 1 to support passthrough
+			 * to backing files.
+			 *
+			 * with max_stack_depth > 1, the backing files can be
+			 * on a stacked fs (e.g. overlayfs) themselves and with
+			 * max_stack_depth == 1, FUSE fs can be stacked as the
+			 * underlying fs of a stacked fs (e.g. overlayfs).
+			 */
+			if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
+			    (flags & FUSE_PASSTHROUGH) &&
+			    arg->max_stack_depth > 0 &&
+			    arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH) {
+				fc->passthrough = 1;
+				fc->max_stack_depth = arg->max_stack_depth;
+				fm->sb->s_stack_depth = arg->max_stack_depth;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1339,6 +1363,8 @@ void fuse_send_init(struct fuse_mount *fm)
 #endif
 	if (fm->fc->auto_submounts)
 		flags |= FUSE_SUBMOUNTS;
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		flags |= FUSE_PASSTHROUGH;
 
 	ia->in.flags = flags;
 	ia->in.flags2 = flags >> 32;
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
new file mode 100644
index 000000000000..e8639c0a9ac6
--- /dev/null
+++ b/fs/fuse/passthrough.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE passthrough to backing file.
+ *
+ * Copyright (c) 2023 CTERA Networks.
+ */
+
+#include "fuse_i.h"
+
+#include <linux/file.h>
+
+struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
+{
+	if (fb && refcount_inc_not_zero(&fb->count))
+		return fb;
+	return NULL;
+}
+
+static void fuse_backing_free(struct fuse_backing *fb)
+{
+	if (fb->file)
+		fput(fb->file);
+	kfree_rcu(fb, rcu);
+}
+
+void fuse_backing_put(struct fuse_backing *fb)
+{
+	if (fb && refcount_dec_and_test(&fb->count))
+		fuse_backing_free(fb);
+}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1f452d9a5024..edfc458e5e8f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -211,6 +211,10 @@
  *  7.39
  *  - add FUSE_DIRECT_IO_ALLOW_MMAP
  *  - add FUSE_STATX and related structures
+ *
+ *  7.40
+ *  - add max_stack_depth to fuse_init_out, add FUSE_PASSTHROUGH init flag
+ *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -246,7 +250,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 39
+#define FUSE_KERNEL_MINOR_VERSION 40
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -354,6 +358,7 @@ struct fuse_file_lock {
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  * FOPEN_CACHE_IO: internal flag for mmap of direct_io (resereved for future use)
+ * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -363,6 +368,7 @@ struct fuse_file_lock {
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 #define FOPEN_CACHE_IO		(1 << 7)
+#define FOPEN_PASSTHROUGH	(1 << 8)
 
 /**
  * INIT request/reply flags
@@ -451,6 +457,7 @@ struct fuse_file_lock {
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
 #define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
+#define FUSE_PASSTHROUGH	(1ULL << 37)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
@@ -763,7 +770,7 @@ struct fuse_create_in {
 struct fuse_open_out {
 	uint64_t	fh;
 	uint32_t	open_flags;
-	uint32_t	padding;
+	int32_t		backing_id;
 };
 
 struct fuse_release_in {
@@ -879,7 +886,8 @@ struct fuse_init_out {
 	uint16_t	max_pages;
 	uint16_t	map_alignment;
 	uint32_t	flags2;
-	uint32_t	unused[7];
+	uint32_t	max_stack_depth;
+	uint32_t	unused[6];
 };
 
 #define CUSE_INIT_INFO_MAX 4096
-- 
2.34.1



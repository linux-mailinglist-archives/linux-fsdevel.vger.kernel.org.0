Return-Path: <linux-fsdevel+bounces-73828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6ED21670
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2999308D516
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9F387379;
	Wed, 14 Jan 2026 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLNxLl3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2137BE8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426768; cv=none; b=IJxU7wWdYwwABb2aNAcAMkDUvdfSG7APna/ooOMC/IomIayArlg/EVV0Ci8J0a6r0Hxgnm+ELFzA3JirLpbO+zwuH9Ha/iBygSxrcH9KDm/R4MGjjl0IAwUX/yUVltd0pRuv6enRl9teUDsBxxB6vQ9uf1UeNU2J9IrY5bqSmp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426768; c=relaxed/simple;
	bh=Am6K2RI/T0WTjL4m6/ZaxMTAl8sLgl+eiAVbx7GUx1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuUyiMcHHukPWRjENdwevcoowzga0+bOV+/Xh5bRDWFuiIGDhbPOd4q3sgxR7UXQbwdQ8iBoKMYdwlRGtYcUsue4HsTt99333+0HPHjTAG48a4lEqJEcVXudsYRYBL4FzxGo66BoZrxD4C4ru3IBRYoNt/TKsG4xYslhRypSbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLNxLl3Z; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cdae63171aso207947a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426727; x=1769031527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTclrm2YHSjptEa7cEmYEVwW7wN9R+aHS7mg59BgCxk=;
        b=MLNxLl3Ze2nQNDScxzPYayKsy6qS850EqM/IRVaW4qBjRsjxPNi8bvneN4zSruspPc
         YeTRpLJGeeNmy/FJ82prWhN4ynBmF3bnmnvPGatoq9phJVYUpJpUZnf0Gxqr2fnipBeu
         LSpO+QmqAIAmMrXRr1U2ZjFLcjyMeR/9TSlOS6oy+4vdqvyD/1XWhoZpSKo/SIByuTX+
         yDYyRGABJYE2vRC7bg4zp3/6SJCxtIeTacZGuM0JHKH5ICvN17OyZPu2VdDjyFbXvQV5
         pz4jIrTWspEzHqLkFyLNyBfcEVG9XdPCNWNni5nAUdjXagXNfCS0U09CcQ1McoVdMKur
         bStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426727; x=1769031527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTclrm2YHSjptEa7cEmYEVwW7wN9R+aHS7mg59BgCxk=;
        b=P4KbC2sYebAgEh8opk1KxX1JJkX852Exs6iJlCx93bYst6xsqzJkMTGRo7g3Ss9g/h
         0l8Icwu+ULVPxyyAyaomskk2ajuByw9ccJSi2GFvhhZ+/9KOkUbGnYqmx/8piA3mHBG5
         2ttUqFyb8ssCV59aGDS0AwRSZJcTJ0TGgKdBzvbDgA+DP3q8T4u3iRFJI94ZDB2TZc+N
         ZgZ4XXa8AQn/SHoQGW5CqWawdO41iQVSafftd35RUQPKmvI3Y6F0+9+XLnyxQ/613CY5
         TJvPjM2j9aS1n+OZA2UP2dnOhegYaIu3QYLoM5dwtk6pHutlrDZYU7K7pZOb9P9E7KZ9
         1TeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIvtaGcbLVYd3gcYRijC5lCQY8l0tCeMO0JDhnCzKKWUI8lesy9piSOk2rvW3x792/vQOPCvATvwHliyig@vger.kernel.org
X-Gm-Message-State: AOJu0YxypL60ByPa4Ob56oTQitcohmC9ziXw0+3/95dapUReOcxFlcu9
	PwEJmtal26QQ1lQ/zhG/jiLW9af5sAKG9d8G2Htf+grtTNiwjypGc7Mv
X-Gm-Gg: AY/fxX4wFPs1EusAwYIRac5ippw4SspU790/Tbq8SEqGDc9fDehSVr6q2k5QH+Rf4sM
	LkSg+d77CTZte8KDUxAKFedxdWHGbTfsC5gk6sDGV1a32FTSzUpbYOGy5CgOJHK+ps8S13mNcHV
	Nld8KrMkX0tgLfvqT+v4GHJPmWcL/LrNBQOidLJmQrr5FSi3+5GR+4qwn2HZ2afawT07K7rx4v4
	MqgzHSH7Gs70nnOl/bTnGv/Z3zr4bJtbRufd2hQwKGkU+vK7hGsaXGCAsdPOlmWEmsYF6apWyKo
	jaKXt3NDNcsKGhhLMHbfpJacTOGfcu8x9RC+nBB4XGF/erPI66je5ALp8USFuEMxW7O1NsTRSFO
	wI7SmQeMhZkeNj8PQY0MwJUgJ5fXD+EWh4Iifac8OSOVvwmv9QpPZLItrwEK/PGqR9WQPyRvAD7
	z9nPbgba98jXV4/G5otyRqeAC7unB3CKnKi+7AwRvfOimL
X-Received: by 2002:a05:6808:221a:b0:450:af35:8b1c with SMTP id 5614622812f47-45c7153d0c1mr2533479b6e.38.1768426726864;
        Wed, 14 Jan 2026 13:38:46 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm11473603b6e.4.2026.01.14.13.38.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:38:46 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 12/19] famfs_fuse: Plumb the GET_FMAP message/response
Date: Wed, 14 Jan 2026 15:31:59 -0600
Message-ID: <20260114213209.29453-13-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
retrieve and cache up the file-to-dax map in the kernel. If this
succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.

Signed-off-by: John Groves <john@groves.net>
---
 MAINTAINERS               |  8 +++++
 fs/fuse/Makefile          |  1 +
 fs/fuse/famfs.c           | 74 +++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c            | 14 +++++++-
 fs/fuse/fuse_i.h          | 70 +++++++++++++++++++++++++++++++++---
 fs/fuse/inode.c           |  8 ++++-
 fs/fuse/iomode.c          |  2 +-
 include/uapi/linux/fuse.h |  7 ++++
 8 files changed, 176 insertions(+), 8 deletions(-)
 create mode 100644 fs/fuse/famfs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 10aa5120d93f..e3d0aa5eb361 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10379,6 +10379,14 @@ F:	fs/fuse/
 F:	include/uapi/linux/fuse.h
 F:	tools/testing/selftests/filesystems/fuse/
 
+FUSE [FAMFS Fabric-Attached Memory File System]
+M:	John Groves <jgroves@micron.com>
+M:	John Groves <John@Groves.net>
+L:	linux-cxl@vger.kernel.org
+L:	linux-fsdevel@vger.kernel.org
+S:	Supported
+F:	fs/fuse/famfs.c
+
 FUTEX SUBSYSTEM
 M:	Thomas Gleixner <tglx@kernel.org>
 M:	Ingo Molnar <mingo@redhat.com>
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 22ad9538dfc4..3f8dcc8cbbd0 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -17,5 +17,6 @@ fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
+fuse-$(CONFIG_FUSE_FAMFS_DAX) += famfs.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
new file mode 100644
index 000000000000..615819cc922d
--- /dev/null
+++ b/fs/fuse/famfs.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2026 Micron Technology, Inc.
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/dax.h>
+#include <linux/iomap.h>
+#include <linux/path.h>
+#include <linux/namei.h>
+#include <linux/string.h>
+
+#include "fuse_i.h"
+
+
+#define FMAP_BUFSIZE PAGE_SIZE
+
+int
+fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)
+{
+	void *fmap_buf __free(kfree) = NULL;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	size_t fmap_bufsize = FMAP_BUFSIZE;
+	u64 nodeid = get_node_id(inode);
+	ssize_t fmap_size;
+	int rc;
+
+	FUSE_ARGS(args);
+
+	/* Don't retrieve if we already have the famfs metadata */
+	if (fi->famfs_meta)
+		return 0;
+
+	fmap_buf = kzalloc(FMAP_BUFSIZE, GFP_KERNEL);
+	if (!fmap_buf)
+		return -EIO;
+
+	args.opcode = FUSE_GET_FMAP;
+	args.nodeid = nodeid;
+
+	/* Variable-sized output buffer
+	 * this causes fuse_simple_request() to return the size of the
+	 * output payload
+	 */
+	args.out_argvar = true;
+	args.out_numargs = 1;
+	args.out_args[0].size = fmap_bufsize;
+	args.out_args[0].value = fmap_buf;
+
+	/* Send GET_FMAP command */
+	rc = fuse_simple_request(fm, &args);
+	if (rc < 0) {
+		pr_err("%s: err=%d from fuse_simple_request()\n",
+		       __func__, rc);
+		return rc;
+	}
+	fmap_size = rc;
+
+	/* We retrieved the "fmap" (the file's map to memory), but
+	 * we haven't used it yet. A call to famfs_file_init_dax() will be added
+	 * here in a subsequent patch, when we add the ability to attach
+	 * fmaps to files.
+	 */
+
+	return 0;
+}
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 093569033ed1..1f64bf68b5ee 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -277,6 +277,16 @@ static int fuse_open(struct inode *inode, struct file *file)
 	err = fuse_do_open(fm, get_node_id(inode), file, false);
 	if (!err) {
 		ff = file->private_data;
+
+		if ((fm->fc->famfs_iomap) && (S_ISREG(inode->i_mode))) {
+			/* Get the famfs fmap - failure is fatal */
+			err = fuse_get_fmap(fm, inode);
+			if (err) {
+				fuse_sync_release(fi, ff, file->f_flags);
+				goto out_nowrite;
+			}
+		}
+
 		err = fuse_finish_open(inode, file);
 		if (err)
 			fuse_sync_release(fi, ff, file->f_flags);
@@ -284,12 +294,14 @@ static int fuse_open(struct inode *inode, struct file *file)
 			fuse_truncate_update_attr(inode, file);
 	}
 
+out_nowrite:
 	if (is_wb_truncate || dax_truncate)
 		fuse_release_nowrite(inode);
 	if (!err) {
 		if (is_truncate)
 			truncate_pagecache(inode, 0);
-		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
+		else if (!(ff->open_flags & FOPEN_KEEP_CACHE) &&
+			 !fuse_file_famfs(fi))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
 	if (dax_truncate)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 2839efb219a9..b66b5ca0bc11 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -223,6 +223,14 @@ struct fuse_inode {
 	 * so preserve the blocksize specified by the server.
 	 */
 	u8 cached_i_blkbits;
+
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	/* Pointer to the file's famfs metadata. Primary content is the
+	 * in-memory version of the fmap - the map from file's offset range
+	 * to DAX memory
+	 */
+	void *famfs_meta;
+#endif
 };
 
 /** FUSE inode state bits */
@@ -1511,11 +1519,8 @@ void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
 
-static inline bool fuse_file_famfs(struct fuse_inode *fuse_inode) /* Will be superseded */
-{
-	(void)fuse_inode;
-	return false;
-}
+static inline int fuse_file_famfs(struct fuse_inode *fi); /* forward */
+
 #define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)	\
 					&& IS_DAX(&fuse_inode->inode)  \
 					&& !fuse_file_famfs(fuse_inode))
@@ -1634,4 +1639,59 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+/* famfs.c */
+
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+void __famfs_meta_free(void *map);
+
+/* Set fi->famfs_meta = NULL regardless of prior value */
+static inline void famfs_meta_init(struct fuse_inode *fi)
+{
+	fi->famfs_meta = NULL;
+}
+
+/* Set fi->famfs_meta iff the current value is NULL */
+static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
+						  void *meta)
+{
+	return cmpxchg(&fi->famfs_meta, NULL, meta);
+}
+
+static inline void famfs_meta_free(struct fuse_inode *fi)
+{
+	famfs_meta_set(fi, NULL);
+}
+
+static inline int fuse_file_famfs(struct fuse_inode *fi)
+{
+	return (READ_ONCE(fi->famfs_meta) != NULL);
+}
+
+int fuse_get_fmap(struct fuse_mount *fm, struct inode *inode);
+
+#else /* !CONFIG_FUSE_FAMFS_DAX */
+
+static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
+						  void *meta)
+{
+	return NULL;
+}
+
+static inline void famfs_meta_free(struct fuse_inode *fi)
+{
+}
+
+static inline int fuse_file_famfs(struct fuse_inode *fi)
+{
+	return 0;
+}
+
+static inline int
+fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)
+{
+	return 0;
+}
+
+#endif /* CONFIG_FUSE_FAMFS_DAX */
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index acabf92a11f8..f2d742d723dc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -120,6 +120,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_inode_backing_set(fi, NULL);
 
+	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+		famfs_meta_set(fi, NULL);
+
 	return &fi->inode;
 
 out_free_forget:
@@ -141,6 +144,9 @@ static void fuse_free_inode(struct inode *inode)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_put(fuse_inode_backing(fi));
 
+	if (S_ISREG(inode->i_mode) && fuse_file_famfs(fi))
+		famfs_meta_free(fi);
+
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
@@ -162,7 +168,7 @@ static void fuse_evict_inode(struct inode *inode)
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode_state_read_once(inode) & I_DIRTY_INODE);
 
-	if (FUSE_IS_VIRTIO_DAX(fi))
+	if (FUSE_IS_VIRTIO_DAX(fi) || fuse_file_famfs(fi))
 		dax_break_layout_final(inode);
 
 	truncate_inode_pages_final(&inode->i_data);
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 31ee7f3304c6..948148316ef0 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -203,7 +203,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (FUSE_IS_VIRTIO_DAX(fi) || !ff->args)
+	if (FUSE_IS_VIRTIO_DAX(fi) || fuse_file_famfs(fi) || !ff->args)
 		return 0;
 
 	/*
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 25686f088e6a..9eff9083d3b5 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -669,6 +669,9 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	/* Famfs / devdax opcodes */
+	FUSE_GET_FMAP           = 54,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -1313,4 +1316,8 @@ struct fuse_uring_cmd_req {
 	uint8_t padding[6];
 };
 
+/* Famfs fmap message components */
+
+#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
+
 #endif /* _LINUX_FUSE_H */
-- 
2.52.0



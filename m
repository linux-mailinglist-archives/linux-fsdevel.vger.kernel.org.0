Return-Path: <linux-fsdevel+bounces-72650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40285CFEB27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 16:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F40CA30CF732
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8539527D;
	Wed,  7 Jan 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjG555wt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9239448F
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800064; cv=none; b=KLafrkfoM1sbheodtRamGNRArXjrhzgo4oqEejfd/A3HoM/TCCKiunVBkzzkaMi6wputkSS7YRljwTFTG83rUPSb5jD6XX5zoZseKrKblFvg4SzKE6Kbj6jqZd8QyMclr6hvKfBj0FGe2QGNKBcQZNaLxTVuQmrH+r1DNZwts5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800064; c=relaxed/simple;
	bh=PCnUhHjPjtOchfmyY/COLS4ltzYEGwOIYlwWEM8c7sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tROAOczf7gryOUGqMsgAh2H/8etozg3DnGZ+k2JCXryCm0nUpMX6TPPnFDRdAaCll0Y2icA0+EgnaGTdxcaIv6PoUyZx7arpqquufpbQS03F2DW4bQeHivZuP37Y9ABoQyM7JDd6kYWkflOHB6PTOcOfPJCWONmHaBEqsTOVvdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjG555wt; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4507605e19aso1483165b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800061; x=1768404861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtZa5/+fDcb2v1caKx2aWM14flK3GsHU5CozFLRvBAM=;
        b=KjG555wtAlNSH05hSqF1h+h9VXHwSKBp7/8X+M1k57h/N/I3tBXyStzNjm4tFHUYrC
         tjFFIk6K5PjAbjXNvWqDPjFb2tAbRrXOuuUoJT7aJpDC76cT8KxxB49DLuzpkQnrotzp
         6GgMc8pNG6WxoapSyJgYsuYggjbYhOtWocAOoo0p8bOr1gIw1km2lUm6D8VKKNIWSRSG
         kSM+Ed6qb4kWjyr82KpXOIHo7HqOHpDSQ4CsF8Dawfhqbo4Garn3Gnpqwwoee9jSRzuJ
         BefrFjoVDWjQmURHlSir3gd7p/OO9JMAQelMkhUQdhqfLlS/frnpecVTijWBA8Ze1Y4e
         xOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800061; x=1768404861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtZa5/+fDcb2v1caKx2aWM14flK3GsHU5CozFLRvBAM=;
        b=HTIviK+pnCqjPqk+ee+Ey63qWldcdB6JGXMayg85O1gS45KlYtgB0rvib8xSpLZA9k
         uwjD5eLu3NmsNmDCrzd2bjIh9KGhuYHFzJdBGdgNk8IQKLHUp9Yao9bL9wRIhRZHH5ds
         GXHDRQeSdOhTdroD7nijIhW+SUroWyDG6iSCcTAWxcdXZbObpG4T5EMANVdDN15s6wd4
         RlZgFILVmeJJJjG2m//Lg7DHYLftZpoK1sh605Z/CEi4cwnL46mTODzh3HLE3h6bSahA
         lvS/cYGBIt04NQnkY/ks3JY011kQljajzc+1jbppu3ZidMQaXtv2AvvaekjQgnrypyfi
         3hpw==
X-Forwarded-Encrypted: i=1; AJvYcCUy9HfigBU5bbeAk4YvCaWK9NOvAQJXjvqOuP1fVleI/Jxmq9VkaNqTHwJSYnpx4+clAGZjLoaCx3KUCQhQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxZKxcGxjlKTbI3NRxqx39NyFOCnCwJrATGaRGgLkQxwX6WfZZh
	E4QjStW3XCchqiSgCRTnI2bbfDGsDzHTl4Tcz5iLPRTWSz/4hdPwN0hH
X-Gm-Gg: AY/fxX5oIq78XLkBFkzy3ftc6zNiwKUnmEeOaBowW4BZM5lzqcndEPIO+5Kg93BrrPI
	Y4bbTiDLbc3W+Lg+hVAu87RcMEjRxDPHtKfwOTpL9TbG4GaFNrAXslE1NK+QQzR8Aun5yZOAjeO
	FTV0TZMHC71keQuoDfdddaH/jP536Mcg9dstStMh5xHqnQuzQUWb0S1kM9DS8gASdcdULmBSmQh
	01WOhysL8PBwsiFmdHCahjT4l6SU7xefiZCa2UW2XtZ1yYqHWjncwUx3rMI0YQpPPmjYGe8/dN2
	x8zqmPKwTja5VO8S7OhE4ZEiwiJx5PgWrkzsdkgcekel/hbbAcQqNVFWYhUXowZjjXIXnRlCciR
	IzhaxjO/A2SZcClTo8a/2FaCqPJAqB3svgJMB3ihcK9YIPI7SwKQY23bNnuEe8PsRJ/Yipj1UUC
	TRCMtSGyKGD8yAzJzxZZpRQ6XwJsuYKed6XiZAzyGBmx2a
X-Google-Smtp-Source: AGHT+IHwCw+2kouS0gewRU1M+KsK1d+ZYKglvGvcMRJpE25Q1Aws6HPVpW7a/OLQu64TjuYD5OcbVw==
X-Received: by 2002:a05:6808:5192:b0:459:b40f:8404 with SMTP id 5614622812f47-45a6bd3d92fmr1103755b6e.29.1767800061183;
        Wed, 07 Jan 2026 07:34:21 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:20 -0800 (PST)
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
	Chen Linxuan <chenlinxuan@uniontech.com>,
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
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 14/21] famfs_fuse: Plumb the GET_FMAP message/response
Date: Wed,  7 Jan 2026 09:33:23 -0600
Message-ID: <20260107153332.64727-15-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
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
 fs/fuse/fuse_i.h          | 47 ++++++++++++++++++++++++-
 fs/fuse/inode.c           |  8 ++++-
 fs/fuse/iomode.c          |  2 +-
 include/uapi/linux/fuse.h |  7 ++++
 8 files changed, 157 insertions(+), 4 deletions(-)
 create mode 100644 fs/fuse/famfs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 90429cb06090..526309943026 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10374,6 +10374,14 @@ F:	fs/fuse/
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
 M:	Thomas Gleixner <tglx@linutronix.de>
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
index 000000000000..0f7e3f00e1e7
--- /dev/null
+++ b/fs/fuse/famfs.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2025 Micron Technology, Inc.
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+
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
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	size_t fmap_bufsize = FMAP_BUFSIZE;
+	u64 nodeid = get_node_id(inode);
+	ssize_t fmap_size;
+	void *fmap_buf;
+	int rc;
+
+	FUSE_ARGS(args);
+
+	/* Don't retrieve if we already have the famfs metadata */
+	if (fi->famfs_meta)
+		return 0;
+
+	fmap_buf = kcalloc(1, FMAP_BUFSIZE, GFP_KERNEL);
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
+	kfree(fmap_buf);
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
index 84d0ee2a501d..691c7850cf4e 100644
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
@@ -1525,11 +1533,14 @@ void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
 
+static inline int fuse_file_famfs(struct fuse_inode *fi); /* forward */
+
 /* This macro is used by virtio_fs, but now it also needs to filter for
  * "not famfs"
  */
 #define FUSE_IS_VIRTIO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)	\
-					&& IS_DAX(&fuse_inode->inode))
+					&& IS_DAX(&fuse_inode->inode)	\
+					&& !fuse_file_famfs(fuse_inode))
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
@@ -1654,4 +1665,38 @@ static inline void famfs_teardown(struct fuse_conn *fc)
 #endif
 }
 
+static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
+						       void *meta)
+{
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	return xchg(&fi->famfs_meta, meta);
+#else
+	return NULL;
+#endif
+}
+
+static inline void famfs_meta_free(struct fuse_inode *fi)
+{
+	/* Stub wil be connected in a subsequent commit */
+}
+
+static inline int fuse_file_famfs(struct fuse_inode *fi)
+{
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	return (READ_ONCE(fi->famfs_meta) != NULL);
+#else
+	return 0;
+#endif
+}
+
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+int fuse_get_fmap(struct fuse_mount *fm, struct inode *inode);
+#else
+static inline int
+fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)
+{
+	return 0;
+}
+#endif
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e0844aabbae..9e121a1d63b7 100644
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
index 5e2c93433823..bfb92a4aa8a9 100644
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
2.49.0



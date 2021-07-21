Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F383D101C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhGUNGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238802AbhGUNGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btFU5FSVk+iL4SOITrWVCSBkmK7PP/wEIEgBG7XWJ4I=;
        b=G/xbttuFOQ4mk8TAdlHLdqLJNXdKw/CjiGGws2oEEJvRywckEnNimENPM8d1cTuUPi9h2B
        Ku+1VWVLsn7Su99z7kYu9tujujuojhyV8ZNiJulxhFstO8jggJvb7zMD/54gQP7R55r0bP
        WsM4d8IxBb6ByGRxXAoRWVhR7TOIUao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-GzAJ7hTqMgKNefHi6qc6oQ-1; Wed, 21 Jul 2021 09:46:58 -0400
X-MC-Unique: GzAJ7hTqMgKNefHi6qc6oQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABE1D10150A0;
        Wed, 21 Jul 2021 13:46:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D66555D9DD;
        Wed, 21 Jul 2021 13:46:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 10/12] netfs: Do encryption in write preparatory phase
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 14:46:48 +0100
Message-ID: <162687520852.276387.2868702028972631448.stgit@warthog.procyon.org.uk>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When dealing with an encrypted or compressed file, we gather together
sufficient pages from the pagecache to constitute a logical
crypto/compression block, allocate a bounce buffer and then ask the
filesystem to encrypt/compress between the buffers.  The bounce buffer is
then passed to the filesystem to upload.

The network filesystem must set a flag to indicate what service is desired
and when the logical blocksize will be.

The netfs library iterates through each block to be processed, providing a
pair of scatterlists to describe the start and end buffers.

Note that it should be possible in future to encrypt/compress DIO writes
also by this same mechanism.

A mock-up block-encryption function for afs is included for illustration.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c         |    1 
 fs/afs/inode.c        |    6 ++
 fs/afs/internal.h     |    5 ++
 fs/afs/super.c        |    7 ++
 fs/afs/write.c        |   49 +++++++++++++++
 fs/netfs/Makefile     |    3 +
 fs/netfs/internal.h   |    5 ++
 fs/netfs/write_back.c |    6 ++
 fs/netfs/write_prep.c |  160 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |    6 ++
 10 files changed, 246 insertions(+), 2 deletions(-)
 create mode 100644 fs/netfs/write_prep.c

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 22030d5191cd..8a6be8d2b426 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -404,6 +404,7 @@ const struct netfs_request_ops afs_req_ops = {
 	.update_i_size		= afs_update_i_size,
 	.init_wreq		= afs_init_wreq,
 	.add_write_streams	= afs_add_write_streams,
+	.encrypt_block		= afs_encrypt_block,
 };
 
 int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index a6ae031461c7..7cad099c3bb1 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -452,10 +452,16 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 static void afs_set_netfs_context(struct afs_vnode *vnode)
 {
 	struct netfs_i_context *ctx = netfs_i_context(&vnode->vfs_inode);
+	struct afs_super_info *as = AFS_FS_S(vnode->vfs_inode.i_sb);
 
 	netfs_i_context_init(&vnode->vfs_inode, &afs_req_ops);
 	ctx->n_wstreams = 1;
 	ctx->bsize = PAGE_SIZE;
+	if (as->fscrypt) {
+		kdebug("ENCRYPT!");
+		ctx->crypto_bsize = ilog2(4096);
+		__set_bit(NETFS_ICTX_ENCRYPTED, &ctx->flags);
+	}
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 32a36b96cc9b..b5f7c3659a0a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -51,6 +51,7 @@ struct afs_fs_context {
 	bool			autocell;	/* T if set auto mount operation */
 	bool			dyn_root;	/* T if dynamic root */
 	bool			no_cell;	/* T if the source is "none" (for dynroot) */
+	bool			fscrypt;	/* T if content encryption is engaged */
 	enum afs_flock_mode	flock_mode;	/* Partial file-locking emulation mode */
 	afs_voltype_t		type;		/* type of volume requested */
 	unsigned int		volnamesz;	/* size of volume name */
@@ -230,6 +231,7 @@ struct afs_super_info {
 	struct afs_volume	*volume;	/* volume record */
 	enum afs_flock_mode	flock_mode:8;	/* File locking emulation mode */
 	bool			dyn_root;	/* True if dynamic root */
+	bool			fscrypt;	/* T if content encryption is engaged */
 };
 
 static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
@@ -1518,6 +1520,9 @@ extern void afs_prune_wb_keys(struct afs_vnode *);
 extern int afs_launder_page(struct page *);
 extern ssize_t afs_file_direct_write(struct kiocb *, struct iov_iter *);
 extern void afs_add_write_streams(struct netfs_write_request *);
+extern bool afs_encrypt_block(struct netfs_write_request *, loff_t, size_t,
+			      struct scatterlist *, unsigned int,
+			      struct scatterlist *, unsigned int);
 
 /*
  * xattr.c
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 29c1178beb72..53f35ec7b17b 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -71,6 +71,7 @@ enum afs_param {
 	Opt_autocell,
 	Opt_dyn,
 	Opt_flock,
+	Opt_fscrypt,
 	Opt_source,
 };
 
@@ -86,6 +87,7 @@ static const struct fs_parameter_spec afs_fs_parameters[] = {
 	fsparam_flag  ("autocell",	Opt_autocell),
 	fsparam_flag  ("dyn",		Opt_dyn),
 	fsparam_enum  ("flock",		Opt_flock, afs_param_flock),
+	fsparam_flag  ("fscrypt",	Opt_fscrypt),
 	fsparam_string("source",	Opt_source),
 	{}
 };
@@ -342,6 +344,10 @@ static int afs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->flock_mode = result.uint_32;
 		break;
 
+	case Opt_fscrypt:
+		ctx->fscrypt = true;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -516,6 +522,7 @@ static struct afs_super_info *afs_alloc_sbi(struct fs_context *fc)
 			as->cell = afs_use_cell(ctx->cell, afs_cell_trace_use_sbi);
 			as->volume = afs_get_volume(ctx->volume,
 						    afs_volume_trace_get_alloc_sbi);
+			as->fscrypt = ctx->fscrypt;
 		}
 	}
 	return as;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 0668389f3466..d2b7cb1a4668 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -13,6 +13,7 @@
 #include <linux/pagevec.h>
 #include <linux/netfs.h>
 #include <linux/fscache.h>
+#include <crypto/skcipher.h>
 #include <trace/events/netfs.h>
 #include "internal.h"
 
@@ -293,6 +294,54 @@ void afs_add_write_streams(struct netfs_write_request *wreq)
 				  afs_upload_to_server_worker);
 }
 
+/*
+ * Encrypt part of a write for fscrypt.
+ */
+bool afs_encrypt_block(struct netfs_write_request *wreq, loff_t pos, size_t len,
+		       struct scatterlist *source_sg, unsigned int n_source,
+		       struct scatterlist *dest_sg, unsigned int n_dest)
+{
+	struct crypto_sync_skcipher *ci;
+	struct crypto_skcipher *tfm;
+	struct skcipher_request *req;
+	u8 session_key[8], iv[8];
+	int ret;
+
+	kenter("%llx", pos);
+
+	ci = crypto_alloc_sync_skcipher("pcbc(fcrypt)", 0, 0);
+	if (IS_ERR(ci)) {
+		_debug("no cipher");
+		ret = PTR_ERR(ci);
+		goto error;
+	}
+	tfm= &ci->base;
+
+	ret = crypto_sync_skcipher_setkey(ci, session_key, sizeof(session_key));
+	if (ret < 0)
+		goto error_ci;
+
+	ret = -ENOMEM;
+	req = skcipher_request_alloc(tfm, GFP_NOFS);
+	if (!req)
+		goto error_ci;
+
+	memset(iv, 0, sizeof(iv));
+	skcipher_request_set_sync_tfm(req, ci);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, source_sg, dest_sg, len, iv);
+	ret = crypto_skcipher_encrypt(req);
+
+	skcipher_request_free(req);
+error_ci:
+	crypto_free_sync_skcipher(ci);
+error:
+	if (ret < 0)
+		wreq->error = ret;
+	kleave(" = %d", ret);
+	return ret == 0;
+}
+
 /*
  * Extend the region to be written back to include subsequent contiguously
  * dirty pages if possible, but don't sleep while doing so.
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index a201fd7b22cf..a7c3a9173ac0 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -4,7 +4,8 @@ netfs-y := \
 	objects.o \
 	read_helper.o \
 	write_back.o \
-	write_helper.o
+	write_helper.o \
+	write_prep.o
 # dio_helper.o
 
 netfs-$(CONFIG_NETFS_STATS) += stats.o
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 6fdf9e5663f7..381ca64062eb 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -65,6 +65,11 @@ void netfs_flush_region(struct netfs_i_context *ctx,
 			struct netfs_dirty_region *region,
 			enum netfs_dirty_trace why);
 
+/*
+ * write_prep.c
+ */
+bool netfs_prepare_wreq(struct netfs_write_request *wreq);
+
 /*
  * stats.c
  */
diff --git a/fs/netfs/write_back.c b/fs/netfs/write_back.c
index 15cc0e1b9acf..7363c3324602 100644
--- a/fs/netfs/write_back.c
+++ b/fs/netfs/write_back.c
@@ -254,7 +254,9 @@ static void netfs_writeback(struct netfs_write_request *wreq)
 
 	kenter("");
 
-	/* TODO: Encrypt or compress the region as appropriate */
+	if (test_bit(NETFS_ICTX_ENCRYPTED, &ctx->flags) &&
+	    !netfs_prepare_wreq(wreq))
+		goto out;
 
 	/* ->outstanding > 0 carries a ref */
 	netfs_get_write_request(wreq, netfs_wreq_trace_get_for_outstanding);
@@ -262,6 +264,8 @@ static void netfs_writeback(struct netfs_write_request *wreq)
 	if (test_bit(NETFS_WREQ_WRITE_TO_CACHE, &wreq->flags))
 		netfs_set_up_write_to_cache(wreq);
 	ctx->ops->add_write_streams(wreq);
+
+out:
 	if (atomic_dec_and_test(&wreq->outstanding))
 		netfs_write_completed(wreq, false);
 }
diff --git a/fs/netfs/write_prep.c b/fs/netfs/write_prep.c
new file mode 100644
index 000000000000..f0a9dfd92a18
--- /dev/null
+++ b/fs/netfs/write_prep.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem high-level write support.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * Allocate a bunch of pages and add them into the xarray buffer starting at
+ * the given index.
+ */
+static int netfs_alloc_buffer(struct xarray *xa, pgoff_t index, unsigned int nr_pages)
+{
+	struct page *page;
+	unsigned int n;
+	int ret;
+	LIST_HEAD(list);
+
+	kenter("");
+
+	n = alloc_pages_bulk_list(GFP_NOIO, nr_pages, &list);
+	if (n < nr_pages) {
+		ret = -ENOMEM;
+	}
+
+	while ((page = list_first_entry_or_null(&list, struct page, lru))) {
+		list_del(&page->lru);
+		ret = xa_insert(xa, index++, page, GFP_NOIO);
+		if (ret < 0)
+			break;
+	}
+
+	while ((page = list_first_entry_or_null(&list, struct page, lru))) {
+		list_del(&page->lru);
+		__free_page(page);
+	}
+	return ret;
+}
+
+/*
+ * Populate a scatterlist from pages in an xarray.
+ */
+static int netfs_xarray_to_sglist(struct xarray *xa, loff_t pos, size_t len,
+				  struct scatterlist *sg, unsigned int n_sg)
+{
+	struct scatterlist *p = sg;
+	struct page *head = NULL;
+	size_t seg, offset, skip = 0;
+	loff_t start = pos;
+	pgoff_t index = start >> PAGE_SHIFT;
+	int j;
+
+	XA_STATE(xas, xa, index);
+
+	sg_init_table(sg, n_sg);
+
+	rcu_read_lock();
+
+	xas_for_each(&xas, head, ULONG_MAX) {
+		kdebug("LOAD %lx %px", head->index, head);
+		if (xas_retry(&xas, head))
+			continue;
+		if (WARN_ON(xa_is_value(head)) || WARN_ON(PageHuge(head)))
+			break;
+		for (j = (head->index < index) ? index - head->index : 0;
+		     j < thp_nr_pages(head); j++
+		     ) {
+			offset = (pos + skip) & ~PAGE_MASK;
+			seg = min(len, PAGE_SIZE - offset);
+
+			kdebug("[%zx] %lx %zx @%zx", p - sg, (head + j)->index, seg, offset);
+			sg_set_page(p++, head + j, seg, offset);
+
+			len -= seg;
+			skip += seg;
+			if (len == 0)
+				break;
+		}
+		if (len == 0)
+			break;
+	}
+
+	rcu_read_unlock();
+	if (len > 0) {
+		WARN_ON(len > 0);
+		return -EIO;
+	}
+
+	sg_mark_end(p - 1);
+	kleave(" = %zd", p - sg);
+	return p - sg;
+}
+
+/*
+ * Perform content encryption on the data to be written before we write it to
+ * the server and the cache.
+ */
+static bool netfs_prepare_encrypt(struct netfs_write_request *wreq)
+{
+	struct netfs_i_context *ctx = netfs_i_context(wreq->inode);
+	struct scatterlist source_sg[16], dest_sg[16];
+	unsigned int bsize = 1 << ctx->crypto_bsize, n_source, n_dest;
+	loff_t pos;
+	size_t n;
+	int ret;
+
+	ret = netfs_alloc_buffer(&wreq->buffer, wreq->first, wreq->last - wreq->first + 1);
+	if (ret < 0)
+		goto error;
+
+	pos = round_down(wreq->start, bsize);
+	n = round_up(wreq->start + wreq->len, bsize) - pos;
+	for (; n > 0; n -= bsize, pos += bsize) {
+		ret = netfs_xarray_to_sglist(&wreq->mapping->i_pages, pos, bsize,
+					     source_sg, ARRAY_SIZE(source_sg));
+		if (ret < 0)
+			goto error;
+		n_source = ret;
+
+		ret = netfs_xarray_to_sglist(&wreq->buffer, pos, bsize,
+					     dest_sg, ARRAY_SIZE(dest_sg));
+		if (ret < 0)
+			goto error;
+		n_dest = ret;
+
+		ret = ctx->ops->encrypt_block(wreq, pos, bsize,
+					      source_sg, n_source, dest_sg, n_dest);
+		if (ret < 0)
+			goto error;
+	}
+
+	iov_iter_xarray(&wreq->source, WRITE, &wreq->buffer, wreq->start, wreq->len);
+	kleave(" = t");
+	return true;
+
+error:
+	wreq->error = ret;
+	kleave(" = f [%d]", ret);
+	return false;
+}
+
+/*
+ * Prepare a write request for writing.  All the pages in the bounding box have
+ * had a ref taken on them and those covering the dirty region have been marked
+ * as being written back and their dirty bits provisionally cleared.
+ */
+bool netfs_prepare_wreq(struct netfs_write_request *wreq)
+{
+	struct netfs_i_context *ctx = netfs_i_context(wreq->inode);
+
+	if (test_bit(NETFS_ICTX_ENCRYPTED, &ctx->flags))
+		return netfs_prepare_encrypt(wreq);
+	return true;
+}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 9d50c2933863..6acf3fb170c3 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -19,6 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/uio.h>
 
+struct scatterlist;
 enum netfs_wreq_trace;
 
 /*
@@ -177,12 +178,14 @@ struct netfs_i_context {
 #endif
 	unsigned long		flags;
 #define NETFS_ICTX_NEW_CONTENT	0		/* Set if file has new content (create/trunc-0) */
+#define NETFS_ICTX_ENCRYPTED	1		/* The file contents are encrypted */
 	spinlock_t		lock;
 	unsigned int		rsize;		/* Maximum read size */
 	unsigned int		wsize;		/* Maximum write size */
 	unsigned int		bsize;		/* Min block size for bounding box */
 	unsigned int		inval_counter;	/* Number of invalidations made */
 	unsigned char		n_wstreams;	/* Number of write streams to allocate */
+	unsigned char		crypto_bsize;	/* log2 of crypto block size */
 };
 
 /*
@@ -358,6 +361,9 @@ struct netfs_request_ops {
 	void (*init_wreq)(struct netfs_write_request *wreq);
 	void (*add_write_streams)(struct netfs_write_request *wreq);
 	void (*invalidate_cache)(struct netfs_write_request *wreq);
+	bool (*encrypt_block)(struct netfs_write_request *wreq, loff_t pos,  size_t len,
+			      struct scatterlist *source_sg, unsigned int n_source,
+			      struct scatterlist *dest_sg, unsigned int n_dest);
 };
 
 /*



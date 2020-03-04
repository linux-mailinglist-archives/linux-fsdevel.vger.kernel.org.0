Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7322517961B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgCDQ7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33751 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729811AbgCDQ7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIKqzjMQYfRTgGM/zTbyuez4nHcsLnOnN8a22yxBVZU=;
        b=egHFIQ/mvgAzPSiYGip3islVPEJ7MkMnH1lG+UaASg3uvEp/P+8j/fmfwzaqx9926P7ErL
        qh2s0Ah3ilhYIap0aUzLcYBpr4k0V3jRsNnqheckBAbCUF17ap+/9Mlcs8Qxa9lb0ZlWI4
        KxDdFjrZzHGZRiWtrzETcqekiZCIgKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-1rMZoVJpPGKlykV8XeqZTw-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: 1rMZoVJpPGKlykV8XeqZTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E87418C35A1;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18BD090796;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6F761225813; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: [PATCH 13/20] fuse, dax: Implement dax read/write operations
Date:   Wed,  4 Mar 2020 11:58:38 -0500
Message-Id: <20200304165845.3081-14-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements basic DAX support. mmap() is not implemented
yet and will come in later patches. This patch looks into implemeting
read/write.

We make use of interval tree to keep track of per inode dax mappings.

Do not use dax for file extending writes, instead just send WRITE message
to daemon (like we do for direct I/O path). This will keep write and
i_size change atomic w.r.t crash.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 fs/fuse/file.c            | 597 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h          |  23 ++
 fs/fuse/inode.c           |   6 +
 include/uapi/linux/fuse.h |   1 +
 4 files changed, 621 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d67b830fb7a..9effdd3dc6d6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,6 +18,12 @@
 #include <linux/swap.h>
 #include <linux/falloc.h>
 #include <linux/uio.h>
+#include <linux/dax.h>
+#include <linux/iomap.h>
+#include <linux/interval_tree_generic.h>
+
+INTERVAL_TREE_DEFINE(struct fuse_dax_mapping, rb, __u64, __subtree_last,
+                     START, LAST, static inline, fuse_dax_interval_tree)=
;
=20
 static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 				      struct fuse_page_desc **desc)
@@ -187,6 +193,242 @@ static void fuse_link_write_file(struct file *file)
 	spin_unlock(&fi->lock);
 }
=20
+static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
+{
+	struct fuse_dax_mapping *dmap =3D NULL;
+
+	spin_lock(&fc->lock);
+
+	if (fc->nr_free_ranges <=3D 0) {
+		spin_unlock(&fc->lock);
+		return NULL;
+	}
+
+	WARN_ON(list_empty(&fc->free_ranges));
+
+	/* Take a free range */
+	dmap =3D list_first_entry(&fc->free_ranges, struct fuse_dax_mapping,
+					list);
+	list_del_init(&dmap->list);
+	fc->nr_free_ranges--;
+	spin_unlock(&fc->lock);
+	return dmap;
+}
+
+/* This assumes fc->lock is held */
+static void __dmap_add_to_free_pool(struct fuse_conn *fc,
+				struct fuse_dax_mapping *dmap)
+{
+	list_add_tail(&dmap->list, &fc->free_ranges);
+	fc->nr_free_ranges++;
+}
+
+static void dmap_add_to_free_pool(struct fuse_conn *fc,
+				struct fuse_dax_mapping *dmap)
+{
+	/* Return fuse_dax_mapping to free list */
+	spin_lock(&fc->lock);
+	__dmap_add_to_free_pool(fc, dmap);
+	spin_unlock(&fc->lock);
+}
+
+/* offset passed in should be aligned to FUSE_DAX_MEM_RANGE_SZ */
+static int fuse_setup_one_mapping(struct inode *inode, loff_t offset,
+				  struct fuse_dax_mapping *dmap, bool writable,
+				  bool upgrade)
+{
+	struct fuse_conn *fc =3D get_fuse_conn(inode);
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_setupmapping_in inarg;
+	FUSE_ARGS(args);
+	ssize_t err;
+
+	WARN_ON(offset % FUSE_DAX_MEM_RANGE_SZ);
+	WARN_ON(fc->nr_free_ranges < 0);
+
+	/* Ask fuse daemon to setup mapping */
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.foffset =3D offset;
+	inarg.fh =3D -1;
+	inarg.moffset =3D dmap->window_offset;
+	inarg.len =3D FUSE_DAX_MEM_RANGE_SZ;
+	inarg.flags |=3D FUSE_SETUPMAPPING_FLAG_READ;
+	if (writable)
+		inarg.flags |=3D FUSE_SETUPMAPPING_FLAG_WRITE;
+	args.opcode =3D FUSE_SETUPMAPPING;
+	args.nodeid =3D fi->nodeid;
+	args.in_numargs =3D 1;
+	args.in_args[0].size =3D sizeof(inarg);
+	args.in_args[0].value =3D &inarg;
+	err =3D fuse_simple_request(fc, &args);
+	if (err < 0) {
+		printk(KERN_ERR "%s request failed at mem_offset=3D0x%llx %zd\n",
+				 __func__, dmap->window_offset, err);
+		return err;
+	}
+
+	pr_debug("fuse_setup_one_mapping() succeeded. offset=3D0x%llx writable=3D=
%d"
+		 " err=3D%zd\n", offset, writable, err);
+
+	dmap->writable =3D writable;
+	if (!upgrade) {
+		dmap->start =3D offset;
+		dmap->end =3D offset + FUSE_DAX_MEM_RANGE_SZ - 1;
+		/* Protected by fi->i_dmap_sem */
+		fuse_dax_interval_tree_insert(dmap, &fi->dmap_tree);
+		fi->nr_dmaps++;
+	}
+	return 0;
+}
+
+static int
+fuse_send_removemapping(struct inode *inode,
+			struct fuse_removemapping_in *inargp,
+			struct fuse_removemapping_one *remove_one)
+{
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_conn *fc =3D get_fuse_conn(inode);
+	FUSE_ARGS(args);
+
+	args.opcode =3D FUSE_REMOVEMAPPING;
+	args.nodeid =3D fi->nodeid;
+	args.in_numargs =3D 2;
+	args.in_args[0].size =3D sizeof(*inargp);
+	args.in_args[0].value =3D inargp;
+	args.in_args[1].size =3D inargp->count * sizeof(*remove_one);
+	args.in_args[1].value =3D remove_one;
+	return fuse_simple_request(fc, &args);
+}
+
+static int dmap_removemapping_list(struct inode *inode, unsigned num,
+				   struct list_head *to_remove)
+{
+	struct fuse_removemapping_one *remove_one, *ptr;
+	struct fuse_removemapping_in inarg;
+	struct fuse_dax_mapping *dmap;
+	int ret, i =3D 0, nr_alloc;
+
+	nr_alloc =3D min_t(unsigned int, num, FUSE_REMOVEMAPPING_MAX_ENTRY);
+	remove_one =3D kmalloc_array(nr_alloc, sizeof(*remove_one), GFP_NOFS);
+	if (!remove_one)
+		return -ENOMEM;
+
+	ptr =3D remove_one;
+	list_for_each_entry(dmap, to_remove, list) {
+		ptr->moffset =3D dmap->window_offset;
+		ptr->len =3D dmap->length;
+		ptr++;
+		i++;
+		num--;
+		if (i >=3D nr_alloc || num =3D=3D 0) {
+			memset(&inarg, 0, sizeof(inarg));
+			inarg.count =3D i;
+			ret =3D fuse_send_removemapping(inode, &inarg,
+						      remove_one);
+			if (ret)
+				goto out;
+			ptr =3D remove_one;
+			i =3D 0;
+		}
+	}
+out:
+	kfree(remove_one);
+	return ret;
+}
+
+/*
+ * Cleanup dmap entry and add back to free list. This should be called w=
ith
+ * fc->lock held.
+ */
+static void dmap_reinit_add_to_free_pool(struct fuse_conn *fc,
+					    struct fuse_dax_mapping *dmap)
+{
+	pr_debug("fuse: freeing memory range start=3D0x%llx end=3D0x%llx "
+		 "window_offset=3D0x%llx length=3D0x%llx\n", dmap->start,
+		 dmap->end, dmap->window_offset, dmap->length);
+	dmap->start =3D dmap->end =3D 0;
+	__dmap_add_to_free_pool(fc, dmap);
+}
+
+/*
+ * Free inode dmap entries whose range falls entirely inside [start, end=
].
+ * Does not take any locks. At this point of time it should only be
+ * called from evict_inode() path where we know all dmap entries can be
+ * reclaimed.
+ */
+static void inode_reclaim_dmap_range(struct fuse_conn *fc, struct inode =
*inode,
+				      loff_t start, loff_t end)
+{
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap, *n;
+	int err, num =3D 0;
+	LIST_HEAD(to_remove);
+
+	pr_debug("fuse: %s: start=3D0x%llx, end=3D0x%llx\n", __func__, start, e=
nd);
+
+	/*
+	 * Interval tree search matches intersecting entries. Adjust the range
+	 * to avoid dropping partial valid entries.
+	 */
+	start =3D ALIGN(start, FUSE_DAX_MEM_RANGE_SZ);
+	end =3D ALIGN_DOWN(end, FUSE_DAX_MEM_RANGE_SZ);
+
+	while (1) {
+		dmap =3D fuse_dax_interval_tree_iter_first(&fi->dmap_tree, start,
+							 end);
+		if (!dmap)
+			break;
+		fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
+		num++;
+		list_add(&dmap->list, &to_remove);
+	}
+
+	/* Nothing to remove */
+	if (list_empty(&to_remove))
+		return;
+
+	WARN_ON(fi->nr_dmaps < num);
+	fi->nr_dmaps -=3D num;
+	/*
+	 * During umount/shutdown, fuse connection is dropped first
+	 * and evict_inode() is called later. That means any
+	 * removemapping messages are going to fail. Send messages
+	 * only if connection is up. Otherwise fuse daemon is
+	 * responsible for cleaning up any leftover references and
+	 * mappings.
+	 */
+	if (fc->connected) {
+		err =3D dmap_removemapping_list(inode, num, &to_remove);
+		if (err) {
+			pr_warn("Failed to removemappings. start=3D0x%llx"
+				" end=3D0x%llx\n", start, end);
+		}
+	}
+	spin_lock(&fc->lock);
+	list_for_each_entry_safe(dmap, n, &to_remove, list) {
+		list_del_init(&dmap->list);
+		dmap_reinit_add_to_free_pool(fc, dmap);
+	}
+	spin_unlock(&fc->lock);
+}
+
+/*
+ * It is called from evict_inode() and by that time inode is going away.=
 So
+ * this function does not take any locks like fi->i_dmap_sem for travers=
ing
+ * that fuse inode interval tree. If that lock is taken then lock valida=
tor
+ * complains of deadlock situation w.r.t fs_reclaim lock.
+ */
+void fuse_cleanup_inode_mappings(struct inode *inode)
+{
+	struct fuse_conn *fc =3D get_fuse_conn(inode);
+	/*
+	 * fuse_evict_inode() has alredy called truncate_inode_pages_final()
+	 * before we arrive here. So we should not have to worry about
+	 * any pages/exception entries still associated with inode.
+	 */
+	inode_reclaim_dmap_range(fc, inode, 0, -1);
+}
+
 void fuse_finish_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff =3D file->private_data;
@@ -1562,32 +1804,364 @@ static ssize_t fuse_direct_write_iter(struct kio=
cb *iocb, struct iov_iter *from)
 	return res;
 }
=20
+static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *t=
o);
 static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *=
to)
 {
 	struct file *file =3D iocb->ki_filp;
 	struct fuse_file *ff =3D file->private_data;
+	struct inode *inode =3D file->f_mapping->host;
=20
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
=20
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_read_iter(iocb, to);
-	else
+	if (IS_DAX(inode))
+		return fuse_dax_read_iter(iocb, to);
+
+	if (ff->open_flags & FOPEN_DIRECT_IO)
 		return fuse_direct_read_iter(iocb, to);
+
+	return fuse_cache_read_iter(iocb, to);
 }
=20
+static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *=
from);
 static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter =
*from)
 {
 	struct file *file =3D iocb->ki_filp;
 	struct fuse_file *ff =3D file->private_data;
+	struct inode *inode =3D file->f_mapping->host;
=20
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
=20
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_write_iter(iocb, from);
-	else
+	if (IS_DAX(inode))
+		return fuse_dax_write_iter(iocb, from);
+
+	if (ff->open_flags & FOPEN_DIRECT_IO)
 		return fuse_direct_write_iter(iocb, from);
+
+	return fuse_cache_write_iter(iocb, from);
+}
+
+static void fuse_fill_iomap_hole(struct iomap *iomap, loff_t length)
+{
+	iomap->addr =3D IOMAP_NULL_ADDR;
+	iomap->length =3D length;
+	iomap->type =3D IOMAP_HOLE;
+}
+
+static void fuse_fill_iomap(struct inode *inode, loff_t pos, loff_t leng=
th,
+			struct iomap *iomap, struct fuse_dax_mapping *dmap,
+			unsigned flags)
+{
+	loff_t offset, len;
+	loff_t i_size =3D i_size_read(inode);
+
+	offset =3D pos - dmap->start;
+	len =3D min(length, dmap->length - offset);
+
+	/* If length is beyond end of file, truncate further */
+	if (pos + len > i_size)
+		len =3D i_size - pos;
+
+	if (len > 0) {
+		iomap->addr =3D dmap->window_offset + offset;
+		iomap->length =3D len;
+		if (flags & IOMAP_FAULT)
+			iomap->length =3D ALIGN(len, PAGE_SIZE);
+		iomap->type =3D IOMAP_MAPPED;
+		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
+				" length 0x%llx\n", __func__, iomap->addr,
+				iomap->offset, iomap->length);
+	} else {
+		/* Mapping beyond end of file is hole */
+		fuse_fill_iomap_hole(iomap, length);
+		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
+				"length 0x%llx\n", __func__, iomap->addr,
+				iomap->offset, iomap->length);
+	}
+}
+
+static int iomap_begin_setup_new_mapping(struct inode *inode, loff_t pos=
,
+					 loff_t length, unsigned flags,
+					 struct iomap *iomap)
+{
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_conn *fc =3D get_fuse_conn(inode);
+	struct fuse_dax_mapping *dmap, *alloc_dmap =3D NULL;
+	int ret;
+	bool writable =3D flags & IOMAP_WRITE;
+
+	alloc_dmap =3D alloc_dax_mapping(fc);
+	if (!alloc_dmap)
+		return -EBUSY;
+
+	/*
+	 * Take write lock so that only one caller can try to setup mapping
+	 * and other waits.
+	 */
+	down_write(&fi->i_dmap_sem);
+	/*
+	 * We dropped lock. Check again if somebody else setup
+	 * mapping already.
+	 */
+	dmap =3D fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos,
+						pos);
+	if (dmap) {
+		fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
+		dmap_add_to_free_pool(fc, alloc_dmap);
+		up_write(&fi->i_dmap_sem);
+		return 0;
+	}
+
+	/* Setup one mapping */
+	ret =3D fuse_setup_one_mapping(inode,
+				     ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
+				     alloc_dmap, writable, false);
+	if (ret < 0) {
+		printk("fuse_setup_one_mapping() failed. err=3D%d"
+			" pos=3D0x%llx, writable=3D%d\n", ret, pos, writable);
+		dmap_add_to_free_pool(fc, alloc_dmap);
+		up_write(&fi->i_dmap_sem);
+		return ret;
+	}
+	fuse_fill_iomap(inode, pos, length, iomap, alloc_dmap, flags);
+	up_write(&fi->i_dmap_sem);
+	return 0;
+}
+
+static int iomap_begin_upgrade_mapping(struct inode *inode, loff_t pos,
+					 loff_t length, unsigned flags,
+					 struct iomap *iomap)
+{
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_dax_mapping *dmap;
+	int ret;
+
+	/*
+	 * Take exclusive lock so that only one caller can try to setup
+	 * mapping and others wait.
+	 */
+	down_write(&fi->i_dmap_sem);
+	dmap =3D fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
+
+	/* We are holding either inode lock or i_mmap_sem, and that should
+	 * ensure that dmap can't reclaimed or truncated and it should still
+	 * be there in tree despite the fact we dropped and re-acquired the
+	 * lock.
+	 */
+	ret =3D -EIO;
+	if (WARN_ON(!dmap))
+		goto out_err;
+
+	/* Maybe another thread already upgraded mapping while we were not
+	 * holding lock.
+	 */
+	if (dmap->writable)
+		goto out_fill_iomap;
+
+	ret =3D fuse_setup_one_mapping(inode,
+				     ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
+				     dmap, true, true);
+	if (ret < 0) {
+		printk("fuse_setup_one_mapping() failed. err=3D%d pos=3D0x%llx\n",
+		       ret, pos);
+		goto out_err;
+	}
+
+out_fill_iomap:
+	fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
+out_err:
+	up_write(&fi->i_dmap_sem);
+	return ret;
+}
+
+/* This is just for DAX and the mapping is ephemeral, do not use it for =
other
+ * purposes since there is no block device with a permanent mapping.
+ */
+static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t leng=
th,
+			    unsigned flags, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_conn *fc =3D get_fuse_conn(inode);
+	struct fuse_dax_mapping *dmap;
+	bool writable =3D flags & IOMAP_WRITE;
+
+	/* We don't support FIEMAP */
+	BUG_ON(flags & IOMAP_REPORT);
+
+	pr_debug("fuse_iomap_begin() called. pos=3D0x%llx length=3D0x%llx\n",
+			pos, length);
+
+	/*
+	 * Writes beyond end of file are not handled using dax path. Instead
+	 * a fuse write message is sent to daemon
+	 */
+	if (flags & IOMAP_WRITE && pos >=3D i_size_read(inode))
+		return -EIO;
+
+	iomap->offset =3D pos;
+	iomap->flags =3D 0;
+	iomap->bdev =3D NULL;
+	iomap->dax_dev =3D fc->dax_dev;
+
+	/*
+	 * Both read/write and mmap path can race here. So we need something
+	 * to make sure if we are setting up mapping, then other path waits
+	 *
+	 * For now, use a semaphore for this. It probably needs to be
+	 * optimized later.
+	 */
+	down_read(&fi->i_dmap_sem);
+	dmap =3D fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
+
+	if (dmap) {
+		if (writable && !dmap->writable) {
+			/* Upgrade read-only mapping to read-write. This will
+			 * require exclusive i_dmap_sem lock as we don't want
+			 * two threads to be trying to this simultaneously
+			 * for same dmap. So drop shared lock and acquire
+			 * exclusive lock.
+			 */
+			up_read(&fi->i_dmap_sem);
+			pr_debug("%s: Upgrading mapping at offset 0x%llx"
+				 " length 0x%llx\n", __func__, pos, length);
+			return iomap_begin_upgrade_mapping(inode, pos, length,
+							   flags, iomap);
+		} else {
+			fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
+			up_read(&fi->i_dmap_sem);
+			return 0;
+		}
+	} else {
+		up_read(&fi->i_dmap_sem);
+		pr_debug("%s: no mapping at offset 0x%llx length 0x%llx\n",
+				__func__, pos, length);
+		if (pos >=3D i_size_read(inode))
+			goto iomap_hole;
+
+		return iomap_begin_setup_new_mapping(inode, pos, length, flags,
+						     iomap);
+	}
+
+	/*
+	 * If read beyond end of file happnes, fs code seems to return
+	 * it as hole
+	 */
+iomap_hole:
+	fuse_fill_iomap_hole(iomap, length);
+	pr_debug("fuse_iomap_begin() returning hole mapping. pos=3D0x%llx lengt=
h_asked=3D0x%llx length_returned=3D0x%llx\n", pos, length, iomap->length)=
;
+	return 0;
+}
+
+static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length=
,
+			  ssize_t written, unsigned flags,
+			  struct iomap *iomap)
+{
+	/* DAX writes beyond end-of-file aren't handled using iomap, so the
+	 * file size is unchanged and there is nothing to do here.
+	 */
+	return 0;
+}
+
+static const struct iomap_ops fuse_iomap_ops =3D {
+	.iomap_begin =3D fuse_iomap_begin,
+	.iomap_end =3D fuse_iomap_end,
+};
+
+static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *t=
o)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
+	ret =3D dax_iomap_rw(iocb, to, &fuse_iomap_ops);
+	inode_unlock_shared(inode);
+
+	/* TODO file_accessed(iocb->f_filp) */
+	return ret;
+}
+
+static bool file_extending_write(struct kiocb *iocb, struct iov_iter *fr=
om)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+
+	return (iov_iter_rw(from) =3D=3D WRITE &&
+		((iocb->ki_pos) >=3D i_size_read(inode)));
+}
+
+static ssize_t fuse_dax_direct_write(struct kiocb *iocb, struct iov_iter=
 *from)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+	struct fuse_io_priv io =3D FUSE_IO_PRIV_SYNC(iocb);
+	ssize_t ret;
+
+	ret =3D fuse_direct_io(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
+	if (ret < 0)
+		return ret;
+
+	fuse_invalidate_attr(inode);
+	fuse_write_update_size(inode, iocb->ki_pos);
+	return ret;
+}
+
+static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *=
from)
+{
+	struct inode *inode =3D file_inode(iocb->ki_filp);
+	ssize_t ret, count;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock(inode);
+	}
+
+	ret =3D generic_write_checks(iocb, from);
+	if (ret <=3D 0)
+		goto out;
+
+	ret =3D file_remove_privs(iocb->ki_filp);
+	if (ret)
+		goto out;
+	/* TODO file_update_time() but we don't want metadata I/O */
+
+	/* Do not use dax for file extending writes as its an mmap and
+	 * trying to write beyong end of existing page will generate
+	 * SIGBUS.
+	 */
+	if (file_extending_write(iocb, from)) {
+		ret =3D fuse_dax_direct_write(iocb, from);
+		goto out;
+	}
+
+	ret =3D dax_iomap_rw(iocb, from, &fuse_iomap_ops);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If part of the write was file extending, fuse dax path will not
+	 * take care of that. Do direct write instead.
+	 */
+	if (iov_iter_count(from) && file_extending_write(iocb, from)) {
+		count =3D fuse_dax_direct_write(iocb, from);
+		if (count < 0)
+			goto out;
+		ret +=3D count;
+	}
+
+out:
+	inode_unlock(inode);
+
+	if (ret > 0)
+		ret =3D generic_write_sync(iocb, ret);
+	return ret;
 }
=20
 static void fuse_writepage_free(struct fuse_writepage_args *wpa)
@@ -2318,6 +2892,11 @@ static int fuse_file_mmap(struct file *file, struc=
t vm_area_struct *vma)
 	return 0;
 }
=20
+static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return -EINVAL; /* TODO */
+}
+
 static int convert_fuse_file_lock(struct fuse_conn *fc,
 				  const struct fuse_file_lock *ffl,
 				  struct file_lock *fl)
@@ -3387,6 +3966,7 @@ static const struct address_space_operations fuse_f=
ile_aops  =3D {
 void fuse_init_file_inode(struct inode *inode)
 {
 	struct fuse_inode *fi =3D get_fuse_inode(inode);
+	struct fuse_conn *fc =3D get_fuse_conn(inode);
=20
 	inode->i_fop =3D &fuse_file_operations;
 	inode->i_data.a_ops =3D &fuse_file_aops;
@@ -3396,4 +3976,9 @@ void fuse_init_file_inode(struct inode *inode)
 	fi->writectr =3D 0;
 	init_waitqueue_head(&fi->page_waitq);
 	INIT_LIST_HEAD(&fi->writepages);
+	fi->dmap_tree =3D RB_ROOT_CACHED;
+
+	if (fc->dax_dev) {
+		inode->i_flags |=3D S_DAX;
+	}
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b41275f73e4c..490549862bda 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -70,16 +70,29 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
=20
+#define START(node) ((node)->start)
+#define LAST(node) ((node)->end)
+
 /** Translation information for file offsets to DAX window offsets */
 struct fuse_dax_mapping {
 	/* Will connect in fc->free_ranges to keep track of free memory */
 	struct list_head list;
=20
+	/* For interval tree in file/inode */
+	struct rb_node rb;
+	/** Start Position in file */
+	__u64 start;
+	/** End Position in file */
+	__u64 end;
+	__u64 __subtree_last;
 	/** Position in DAX window */
 	u64 window_offset;
=20
 	/** Length of mapping, in bytes */
 	loff_t length;
+
+	/* Is this mapping read-only or read-write */
+	bool writable;
 };
=20
 /** FUSE inode */
@@ -167,6 +180,15 @@ struct fuse_inode {
=20
 	/** Lock to protect write related fields */
 	spinlock_t lock;
+
+	/*
+	 * Semaphore to protect modifications to dmap_tree
+	 */
+	struct rw_semaphore i_dmap_sem;
+
+	/** Sorted rb tree of struct fuse_dax_mapping elements */
+	struct rb_root_cached dmap_tree;
+	unsigned long nr_dmaps;
 };
=20
 /** FUSE inode state bits */
@@ -1127,5 +1149,6 @@ unsigned int fuse_len_args(unsigned int numargs, st=
ruct fuse_arg *args);
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
+void fuse_cleanup_inode_mappings(struct inode *inode);
=20
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 36cb9c00bbe5..93bc65607a15 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -86,7 +86,9 @@ static struct inode *fuse_alloc_inode(struct super_bloc=
k *sb)
 	fi->attr_version =3D 0;
 	fi->orig_ino =3D 0;
 	fi->state =3D 0;
+	fi->nr_dmaps =3D 0;
 	mutex_init(&fi->mutex);
+	init_rwsem(&fi->i_dmap_sem);
 	spin_lock_init(&fi->lock);
 	fi->forget =3D fuse_alloc_forget();
 	if (!fi->forget) {
@@ -114,6 +116,10 @@ static void fuse_evict_inode(struct inode *inode)
 	clear_inode(inode);
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
 		struct fuse_conn *fc =3D get_fuse_conn(inode);
+		if (IS_DAX(inode)) {
+			fuse_cleanup_inode_mappings(inode);
+			WARN_ON(fi->nr_dmaps);
+		}
 		fuse_queue_forget(fc, fi->forget, fi->nodeid, fi->nlookup);
 		fi->forget =3D NULL;
 	}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 62633555d547..36d824b82ebc 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -896,6 +896,7 @@ struct fuse_copy_file_range_in {
=20
 #define FUSE_SETUPMAPPING_ENTRIES 8
 #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
+#define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
 struct fuse_setupmapping_in {
 	/* An already open handle */
 	uint64_t	fh;
--=20
2.20.1


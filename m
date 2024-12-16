Return-Path: <linux-fsdevel+bounces-37544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A273C9F3BC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60148188DF79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ED51F5438;
	Mon, 16 Dec 2024 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KG5pCH6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC51F5420
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381863; cv=none; b=MZbTSwxWDRDmcgsxDwwgX6RUKSNs2qrFsJh8lvAnWagAQgonNFaZVUytgPN0RtDFDRxpyPagGEdI6Ig24I3/NWIMdwhPGZiL85Ps0gLEo5T7svBp+Nun9R7ZasT2L1ZKVmFCcsjucYj4nWPF6JmgdPFLQWCeU4/CWs0wGAk73Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381863; c=relaxed/simple;
	bh=XbNMMKs+N2GLJRpAp3jvzYliWQx7+BWD1GM6a51zpA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUOOlYt2tKw0JH4bc2Hfz1k82iSQU4vx7fvDIupBOAMzlAIwfHu4F4Flq4WcRhvgQkaH75pp3xY4uNVLqqiuJ1qHIb/hzknCcj2lhCxhxLoSozggXFFhnJkR5MFPh+dJqmjPvSFlEdaAPXaC5VruARKaLGaBPs70YmJHmvNYDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KG5pCH6u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRE6I8FgHgtFlAE7VENNyok+awl5+fd92X1d4ER5SlQ=;
	b=KG5pCH6uOV9hLEfZPD1g9EjVc3zp0XiCZeRSP4hH0x38ItYXochYr1dgX/1B2fYK44kzt2
	31zyaLEwUVFCJVQX2E+jdtrELQury3k5BVM+eAkuXD0Rwb6hralSD8KgP9PLrobM0rJn2h
	m2m8L92fGP8rU2ByItnqQdEtDrBAZ+E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-A2xgDvC2OM64LTPCax8gog-1; Mon,
 16 Dec 2024 15:44:14 -0500
X-MC-Unique: A2xgDvC2OM64LTPCax8gog-1
X-Mimecast-MFC-AGG-ID: A2xgDvC2OM64LTPCax8gog
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95FF71955F2F;
	Mon, 16 Dec 2024 20:44:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CDBF0195394B;
	Mon, 16 Dec 2024 20:44:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 21/32] afs: Use netfslib for directories
Date: Mon, 16 Dec 2024 20:41:11 +0000
Message-ID: <20241216204124.3752367-22-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In the AFS ecosystem, directories are just a special type of file that is
downloaded and parsed locally.  Download is done by the same mechanism as
ordinary files and the data can be cached.  There is one important semantic
restriction on directories over files: the client must download the entire
directory in one go because, for example, the server could fabricate the
contents of the blob on the fly with each download and give a different
image each time.

So that we can cache the directory download, switch AFS directory support
over to using the netfslib single-object API, thereby allowing directory
content to be stored in the local cache.

To make this work, the following changes are made:

 (1) A directory's contents are now stored in a folio_queue chain attached
     to the afs_vnode (inode) struct rather than its associated pagecache,
     though multipage folios are still used to hold the data.  The folio
     queue is discarded when the directory inode is evicted.

     This also helps with the phasing out of ITER_XARRAY.

 (2) Various directory operations are made to use and unuse the cache
     cookie.

 (3) The content checking, content dumping and content iteration are now
     performed with a standard iov_iter iterator over the contents of the
     folio queue.

 (4) Iteration and modification must be done with the vnode's validate_lock
     held.  In conjunction with (1), this means that the iteration can be
     done without the need to lock pages or take extra refs on them, unlike
     when accessing ->i_pages.

 (5) Convert to using netfs_read_single() to read data.

 (6) Provide a ->writepages() to call netfs_writeback_single() to save the
     data to the cache according to the VM's scheduling whilst holding the
     validate_lock read-locked as (4).

 (7) Change local directory image editing functions:

     (a) Provide a function to get a specific block by number from the
     	 folio_queue as we can no longer use the i_pages xarray to locate
     	 folios by index.  This uses a cursor to remember the current
     	 position as we need to iterate through the directory contents.
     	 The block is kmapped before being returned.

     (b) Make the function in (a) extend the directory by an extra folio if
     	 we run out of space.

     (c) Raise the check of the block free space counter, for those blocks
     	 that have one, higher in the function to eliminate a call to get a
     	 block.

     (d) Remove the page unlocking and putting done during the editing
     	 loops.  This is no longer necessary as the folio_queue holds the
     	 references and the pages are no longer in the pagecache.

     (e) Mark the inode dirty and pin the cache usage till writeback at the
     	 end of a successful edit.

 (8) Don't set the large_folios flag on the inode as we do the allocation
     ourselves rather than the VM doing it automatically.

 (9) Mark the inode as being a single object that isn't uploaded to the
     server.

(10) Enable caching on directories.

(11) Only set the upload key for writeback for regular files.

Notes:

 (*) We keep the ->release_folio(), ->invalidate_folio() and
     ->migrate_folio() ops as we set the mapping pointer on the folio.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dir.c               | 747 +++++++++++++++++++------------------
 fs/afs/dir_edit.c          | 183 ++++-----
 fs/afs/file.c              |   8 +
 fs/afs/inode.c             |  21 +-
 fs/afs/internal.h          |  16 +
 fs/afs/super.c             |   2 +
 fs/afs/write.c             |   4 +-
 include/trace/events/afs.h |   6 +-
 8 files changed, 517 insertions(+), 470 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index f36a28a8f27b..3fa095429794 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -13,6 +13,7 @@
 #include <linux/ctype.h>
 #include <linux/sched.h>
 #include <linux/iversion.h>
+#include <linux/iov_iter.h>
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 #include "afs_fs.h"
@@ -42,15 +43,6 @@ static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags);
-static bool afs_dir_release_folio(struct folio *folio, gfp_t gfp_flags);
-static void afs_dir_invalidate_folio(struct folio *folio, size_t offset,
-				   size_t length);
-
-static bool afs_dir_dirty_folio(struct address_space *mapping,
-		struct folio *folio)
-{
-	BUG(); /* This should never happen. */
-}
 
 const struct file_operations afs_dir_file_operations = {
 	.open		= afs_dir_open,
@@ -75,10 +67,7 @@ const struct inode_operations afs_dir_inode_operations = {
 };
 
 const struct address_space_operations afs_dir_aops = {
-	.dirty_folio	= afs_dir_dirty_folio,
-	.release_folio	= afs_dir_release_folio,
-	.invalidate_folio = afs_dir_invalidate_folio,
-	.migrate_folio	= filemap_migrate_folio,
+	.writepages	= afs_single_writepages,
 };
 
 const struct dentry_operations afs_fs_dentry_operations = {
@@ -105,146 +94,120 @@ struct afs_lookup_cookie {
 	struct afs_fid		fids[50];
 };
 
+static void afs_dir_unuse_cookie(struct afs_vnode *dvnode, int ret)
+{
+	if (ret == 0) {
+		struct afs_vnode_cache_aux aux;
+		loff_t i_size = i_size_read(&dvnode->netfs.inode);
+
+		afs_set_cache_aux(dvnode, &aux);
+		fscache_unuse_cookie(afs_vnode_cache(dvnode), &aux, &i_size);
+	} else {
+		fscache_unuse_cookie(afs_vnode_cache(dvnode), NULL, NULL);
+	}
+}
+
 /*
- * Drop the refs that we're holding on the folios we were reading into.  We've
- * got refs on the first nr_pages pages.
+ * Iterate through a kmapped directory segment, dumping a summary of
+ * the contents.
  */
-static void afs_dir_read_cleanup(struct afs_read *req)
+static size_t afs_dir_dump_step(void *iter_base, size_t progress, size_t len,
+				void *priv, void *priv2)
 {
-	struct address_space *mapping = req->vnode->netfs.inode.i_mapping;
-	struct folio *folio;
-	pgoff_t last = req->nr_pages - 1;
+	do {
+		union afs_xdr_dir_block *block = iter_base;
 
-	XA_STATE(xas, &mapping->i_pages, 0);
+		pr_warn("[%05zx] %32phN\n", progress, block);
+		iter_base += AFS_DIR_BLOCK_SIZE;
+		progress += AFS_DIR_BLOCK_SIZE;
+		len -= AFS_DIR_BLOCK_SIZE;
+	} while (len > 0);
 
-	if (unlikely(!req->nr_pages))
-		return;
+	return len;
+}
 
-	rcu_read_lock();
-	xas_for_each(&xas, folio, last) {
-		if (xas_retry(&xas, folio))
-			continue;
-		BUG_ON(xa_is_value(folio));
-		ASSERTCMP(folio->mapping, ==, mapping);
+/*
+ * Dump the contents of a directory.
+ */
+static void afs_dir_dump(struct afs_vnode *dvnode)
+{
+	struct iov_iter iter;
+	unsigned long long i_size = i_size_read(&dvnode->netfs.inode);
 
-		folio_put(folio);
-	}
+	pr_warn("DIR %llx:%llx is=%llx\n",
+		dvnode->fid.vid, dvnode->fid.vnode, i_size);
 
-	rcu_read_unlock();
+	iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
+	iterate_folioq(&iter, iov_iter_count(&iter), NULL, NULL,
+		       afs_dir_dump_step);
 }
 
 /*
  * check that a directory folio is valid
  */
-static bool afs_dir_check_folio(struct afs_vnode *dvnode, struct folio *folio,
-				loff_t i_size)
+static bool afs_dir_check_block(struct afs_vnode *dvnode, size_t progress,
+				union afs_xdr_dir_block *block)
 {
-	union afs_xdr_dir_block *block;
-	size_t offset, size;
-	loff_t pos;
+	if (block->hdr.magic != AFS_DIR_MAGIC) {
+		pr_warn("%s(%lx): [%zx] bad magic %04x\n",
+		       __func__, dvnode->netfs.inode.i_ino,
+		       progress, ntohs(block->hdr.magic));
+		trace_afs_dir_check_failed(dvnode, progress);
+		trace_afs_file_error(dvnode, -EIO, afs_file_error_dir_bad_magic);
+		return false;
+	}
 
-	/* Determine how many magic numbers there should be in this folio, but
-	 * we must take care because the directory may change size under us.
+	/* Make sure each block is NUL terminated so we can reasonably
+	 * use string functions on it.  The filenames in the folio
+	 * *should* be NUL-terminated anyway.
 	 */
-	pos = folio_pos(folio);
-	if (i_size <= pos)
-		goto checked;
-
-	size = min_t(loff_t, folio_size(folio), i_size - pos);
-	for (offset = 0; offset < size; offset += sizeof(*block)) {
-		block = kmap_local_folio(folio, offset);
-		if (block->hdr.magic != AFS_DIR_MAGIC) {
-			printk("kAFS: %s(%lx): [%llx] bad magic %zx/%zx is %04hx\n",
-			       __func__, dvnode->netfs.inode.i_ino,
-			       pos, offset, size, ntohs(block->hdr.magic));
-			trace_afs_dir_check_failed(dvnode, pos + offset, i_size);
-			kunmap_local(block);
-			trace_afs_file_error(dvnode, -EIO, afs_file_error_dir_bad_magic);
-			goto error;
-		}
-
-		/* Make sure each block is NUL terminated so we can reasonably
-		 * use string functions on it.  The filenames in the folio
-		 * *should* be NUL-terminated anyway.
-		 */
-		((u8 *)block)[AFS_DIR_BLOCK_SIZE - 1] = 0;
-
-		kunmap_local(block);
-	}
-checked:
+	((u8 *)block)[AFS_DIR_BLOCK_SIZE - 1] = 0;
 	afs_stat_v(dvnode, n_read_dir);
 	return true;
-
-error:
-	return false;
 }
 
 /*
- * Dump the contents of a directory.
+ * Iterate through a kmapped directory segment, checking the content.
  */
-static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
+static size_t afs_dir_check_step(void *iter_base, size_t progress, size_t len,
+				 void *priv, void *priv2)
 {
-	union afs_xdr_dir_block *block;
-	struct address_space *mapping = dvnode->netfs.inode.i_mapping;
-	struct folio *folio;
-	pgoff_t last = req->nr_pages - 1;
-	size_t offset, size;
-
-	XA_STATE(xas, &mapping->i_pages, 0);
-
-	pr_warn("DIR %llx:%llx f=%llx l=%llx al=%llx\n",
-		dvnode->fid.vid, dvnode->fid.vnode,
-		req->file_size, req->len, req->actual_len);
-	pr_warn("DIR %llx %x %zx %zx\n",
-		req->pos, req->nr_pages,
-		req->iter->iov_offset,  iov_iter_count(req->iter));
-
-	xas_for_each(&xas, folio, last) {
-		if (xas_retry(&xas, folio))
-			continue;
+	struct afs_vnode *dvnode = priv;
 
-		BUG_ON(folio->mapping != mapping);
+	if (WARN_ON_ONCE(progress % AFS_DIR_BLOCK_SIZE ||
+			 len % AFS_DIR_BLOCK_SIZE))
+		return len;
 
-		size = min_t(loff_t, folio_size(folio), req->actual_len - folio_pos(folio));
-		for (offset = 0; offset < size; offset += sizeof(*block)) {
-			block = kmap_local_folio(folio, offset);
-			pr_warn("[%02lx] %32phN\n", folio->index + offset, block);
-			kunmap_local(block);
-		}
-	}
+	do {
+		if (!afs_dir_check_block(dvnode, progress, iter_base))
+			break;
+		iter_base += AFS_DIR_BLOCK_SIZE;
+		len -= AFS_DIR_BLOCK_SIZE;
+	} while (len > 0);
+
+	return len;
 }
 
 /*
- * Check all the blocks in a directory.  All the folios are held pinned.
+ * Check all the blocks in a directory.
  */
-static int afs_dir_check(struct afs_vnode *dvnode, struct afs_read *req)
+static int afs_dir_check(struct afs_vnode *dvnode)
 {
-	struct address_space *mapping = dvnode->netfs.inode.i_mapping;
-	struct folio *folio;
-	pgoff_t last = req->nr_pages - 1;
-	int ret = 0;
+	struct iov_iter iter;
+	unsigned long long i_size = i_size_read(&dvnode->netfs.inode);
+	size_t checked = 0;
 
-	XA_STATE(xas, &mapping->i_pages, 0);
-
-	if (unlikely(!req->nr_pages))
+	if (unlikely(!i_size))
 		return 0;
 
-	rcu_read_lock();
-	xas_for_each(&xas, folio, last) {
-		if (xas_retry(&xas, folio))
-			continue;
-
-		BUG_ON(folio->mapping != mapping);
-
-		if (!afs_dir_check_folio(dvnode, folio, req->actual_len)) {
-			afs_dir_dump(dvnode, req);
-			ret = -EIO;
-			break;
-		}
+	iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
+	checked = iterate_folioq(&iter, iov_iter_count(&iter), dvnode, NULL,
+				 afs_dir_check_step);
+	if (checked != i_size) {
+		afs_dir_dump(dvnode);
+		return -EIO;
 	}
-
-	rcu_read_unlock();
-	return ret;
+	return 0;
 }
 
 /*
@@ -264,133 +227,136 @@ static int afs_dir_open(struct inode *inode, struct file *file)
 }
 
 /*
- * Read the directory into the pagecache in one go, scrubbing the previous
- * contents.  The list of folios is returned, pinning them so that they don't
- * get reclaimed during the iteration.
+ * Read a file in a single download.
  */
-static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
-	__acquires(&dvnode->validate_lock)
+static ssize_t afs_do_read_single(struct afs_vnode *dvnode, struct file *file)
 {
-	struct address_space *mapping = dvnode->netfs.inode.i_mapping;
-	struct afs_read *req;
+	struct iov_iter iter;
+	ssize_t ret;
 	loff_t i_size;
-	int nr_pages, i;
-	int ret;
-	loff_t remote_size = 0;
-
-	_enter("");
-
-	req = kzalloc(sizeof(*req), GFP_KERNEL);
-	if (!req)
-		return ERR_PTR(-ENOMEM);
+	bool is_dir = (S_ISDIR(dvnode->netfs.inode.i_mode) &&
+		       !test_bit(AFS_VNODE_MOUNTPOINT, &dvnode->flags));
 
-	refcount_set(&req->usage, 1);
-	req->vnode = dvnode;
-	req->key = key_get(key);
-	req->cleanup = afs_dir_read_cleanup;
-
-expand:
 	i_size = i_size_read(&dvnode->netfs.inode);
-	if (i_size < remote_size)
-	    i_size = remote_size;
-	if (i_size < 2048) {
-		ret = afs_bad(dvnode, afs_file_error_dir_small);
-		goto error;
-	}
-	if (i_size > 2048 * 1024) {
-		trace_afs_file_error(dvnode, -EFBIG, afs_file_error_dir_big);
-		ret = -EFBIG;
-		goto error;
+	if (is_dir) {
+		if (i_size < AFS_DIR_BLOCK_SIZE)
+			return afs_bad(dvnode, afs_file_error_dir_small);
+		if (i_size > AFS_DIR_BLOCK_SIZE * 1024) {
+			trace_afs_file_error(dvnode, -EFBIG, afs_file_error_dir_big);
+			return -EFBIG;
+		}
+	} else {
+		if (i_size > AFSPATHMAX) {
+			trace_afs_file_error(dvnode, -EFBIG, afs_file_error_dir_big);
+			return -EFBIG;
+		}
 	}
 
-	_enter("%llu", i_size);
+	/* Expand the storage.  TODO: Shrink the storage too. */
+	if (dvnode->directory_size < i_size) {
+		size_t cur_size = dvnode->directory_size;
 
-	nr_pages = (i_size + PAGE_SIZE - 1) / PAGE_SIZE;
+		ret = netfs_alloc_folioq_buffer(NULL,
+						&dvnode->directory, &cur_size, i_size,
+						mapping_gfp_mask(dvnode->netfs.inode.i_mapping));
+		dvnode->directory_size = cur_size;
+		if (ret < 0)
+			return ret;
+	}
 
-	req->actual_len = i_size; /* May change */
-	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
-	req->data_version = dvnode->status.data_version; /* May change */
-	iov_iter_xarray(&req->def_iter, ITER_DEST, &dvnode->netfs.inode.i_mapping->i_pages,
-			0, i_size);
-	req->iter = &req->def_iter;
+	iov_iter_folio_queue(&iter, ITER_DEST, dvnode->directory, 0, 0, dvnode->directory_size);
 
-	/* Fill in any gaps that we might find where the memory reclaimer has
-	 * been at work and pin all the folios.  If there are any gaps, we will
-	 * need to reread the entire directory contents.
+	/* AFS requires us to perform the read of a directory synchronously as
+	 * a single unit to avoid issues with the directory contents being
+	 * changed between reads.
 	 */
-	i = req->nr_pages;
-	while (i < nr_pages) {
-		struct folio *folio;
-
-		folio = filemap_get_folio(mapping, i);
-		if (IS_ERR(folio)) {
-			afs_invalidate_dir(dvnode, afs_dir_invalid_reclaimed_folio);
-			folio = __filemap_get_folio(mapping,
-						    i, FGP_LOCK | FGP_CREAT,
-						    mapping->gfp_mask);
-			if (IS_ERR(folio)) {
-				ret = PTR_ERR(folio);
-				goto error;
-			}
-			folio_attach_private(folio, (void *)1);
-			folio_unlock(folio);
+	ret = netfs_read_single(&dvnode->netfs.inode, file, &iter);
+	if (ret >= 0) {
+		i_size = i_size_read(&dvnode->netfs.inode);
+		if (i_size > ret) {
+			/* The content has grown, so we need to expand the
+			 * buffer.
+			 */
+			ret = -ESTALE;
+		} else if (is_dir) {
+			int ret2 = afs_dir_check(dvnode);
+
+			if (ret2 < 0)
+				ret = ret2;
+		} else if (i_size < folioq_folio_size(dvnode->directory, 0)) {
+			/* NUL-terminate a symlink. */
+			char *symlink = kmap_local_folio(folioq_folio(dvnode->directory, 0), 0);
+
+			symlink[i_size] = 0;
+			kunmap_local(symlink);
 		}
-
-		req->nr_pages += folio_nr_pages(folio);
-		i += folio_nr_pages(folio);
 	}
 
-	/* If we're going to reload, we need to lock all the pages to prevent
-	 * races.
-	 */
+	return ret;
+}
+
+ssize_t afs_read_single(struct afs_vnode *dvnode, struct file *file)
+{
+	ssize_t ret;
+
+	fscache_use_cookie(afs_vnode_cache(dvnode), false);
+	ret = afs_do_read_single(dvnode, file);
+	fscache_unuse_cookie(afs_vnode_cache(dvnode), NULL, NULL);
+	return ret;
+}
+
+/*
+ * Read the directory into a folio_queue buffer in one go, scrubbing the
+ * previous contents.  We return -ESTALE if the caller needs to call us again.
+ */
+static ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
+	__acquires(&dvnode->validate_lock)
+{
+	ssize_t ret;
+	loff_t i_size;
+
+	i_size = i_size_read(&dvnode->netfs.inode);
+
 	ret = -ERESTARTSYS;
 	if (down_read_killable(&dvnode->validate_lock) < 0)
 		goto error;
 
-	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
-		goto success;
+	/* We only need to reread the data if it became invalid - or if we
+	 * haven't read it yet.
+	 */
+	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) &&
+	    test_bit(AFS_VNODE_DIR_READ, &dvnode->flags))
+		goto valid;
 
 	up_read(&dvnode->validate_lock);
 	if (down_write_killable(&dvnode->validate_lock) < 0)
 		goto error;
 
-	if (!test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
-		trace_afs_reload_dir(dvnode);
-		ret = afs_fetch_data(dvnode, req);
-		if (ret < 0)
-			goto error_unlock;
-
-		task_io_account_read(PAGE_SIZE * req->nr_pages);
+	if (!test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
+		afs_invalidate_cache(dvnode, 0);
 
-		if (req->len < req->file_size) {
-			/* The content has grown, so we need to expand the
-			 * buffer.
-			 */
-			up_write(&dvnode->validate_lock);
-			remote_size = req->file_size;
-			goto expand;
-		}
-
-		/* Validate the data we just read. */
-		ret = afs_dir_check(dvnode, req);
+	if (!test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) ||
+	    !test_bit(AFS_VNODE_DIR_READ, &dvnode->flags)) {
+		trace_afs_reload_dir(dvnode);
+		ret = afs_read_single(dvnode, file);
 		if (ret < 0)
 			goto error_unlock;
 
 		// TODO: Trim excess pages
 
 		set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags);
+		set_bit(AFS_VNODE_DIR_READ, &dvnode->flags);
 	}
 
 	downgrade_write(&dvnode->validate_lock);
-success:
-	return req;
+valid:
+	return i_size;
 
 error_unlock:
 	up_write(&dvnode->validate_lock);
 error:
-	afs_put_read(req);
-	_leave(" = %d", ret);
-	return ERR_PTR(ret);
+	_leave(" = %zd", ret);
+	return ret;
 }
 
 /*
@@ -398,79 +364,69 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
  */
 static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 				 struct dir_context *ctx,
-				 union afs_xdr_dir_block *block,
-				 unsigned blkoff)
+				 union afs_xdr_dir_block *block)
 {
 	union afs_xdr_dirent *dire;
-	unsigned offset, next, curr, nr_slots;
+	unsigned int blknum, base, hdr, pos, next, nr_slots;
 	size_t nlen;
 	int tmp;
 
-	_enter("%llx,%x", ctx->pos, blkoff);
+	blknum	= ctx->pos / AFS_DIR_BLOCK_SIZE;
+	base	= blknum * AFS_DIR_SLOTS_PER_BLOCK;
+	hdr	= (blknum == 0 ? AFS_DIR_RESV_BLOCKS0 : AFS_DIR_RESV_BLOCKS);
+	pos	= DIV_ROUND_UP(ctx->pos, AFS_DIR_DIRENT_SIZE) - base;
 
-	curr = (ctx->pos - blkoff) / sizeof(union afs_xdr_dirent);
+	_enter("%llx,%x", ctx->pos, blknum);
 
 	/* walk through the block, an entry at a time */
-	for (offset = (blkoff == 0 ? AFS_DIR_RESV_BLOCKS0 : AFS_DIR_RESV_BLOCKS);
-	     offset < AFS_DIR_SLOTS_PER_BLOCK;
-	     offset = next
-	     ) {
+	for (unsigned int slot = hdr; slot < AFS_DIR_SLOTS_PER_BLOCK; slot = next) {
 		/* skip entries marked unused in the bitmap */
-		if (!(block->hdr.bitmap[offset / 8] &
-		      (1 << (offset % 8)))) {
-			_debug("ENT[%zu.%u]: unused",
-			       blkoff / sizeof(union afs_xdr_dir_block), offset);
-			next = offset + 1;
-			if (offset >= curr)
-				ctx->pos = blkoff +
-					next * sizeof(union afs_xdr_dirent);
+		if (!(block->hdr.bitmap[slot / 8] &
+		      (1 << (slot % 8)))) {
+			_debug("ENT[%x]: Unused", base + slot);
+			next = slot + 1;
+			if (next >= pos)
+				ctx->pos = (base + next) * sizeof(union afs_xdr_dirent);
 			continue;
 		}
 
 		/* got a valid entry */
-		dire = &block->dirents[offset];
+		dire = &block->dirents[slot];
 		nlen = strnlen(dire->u.name,
-			       sizeof(*block) -
-			       offset * sizeof(union afs_xdr_dirent));
+			       (unsigned long)(block + 1) - (unsigned long)dire->u.name - 1);
 		if (nlen > AFSNAMEMAX - 1) {
-			_debug("ENT[%zu]: name too long (len %u/%zu)",
-			       blkoff / sizeof(union afs_xdr_dir_block),
-			       offset, nlen);
+			_debug("ENT[%x]: Name too long (len %zx)",
+			       base + slot, nlen);
 			return afs_bad(dvnode, afs_file_error_dir_name_too_long);
 		}
 
-		_debug("ENT[%zu.%u]: %s %zu \"%s\"",
-		       blkoff / sizeof(union afs_xdr_dir_block), offset,
-		       (offset < curr ? "skip" : "fill"),
+		_debug("ENT[%x]: %s %zx \"%s\"",
+		       base + slot, (slot < pos ? "skip" : "fill"),
 		       nlen, dire->u.name);
 
 		nr_slots = afs_dir_calc_slots(nlen);
-		next = offset + nr_slots;
+		next = slot + nr_slots;
 		if (next > AFS_DIR_SLOTS_PER_BLOCK) {
-			_debug("ENT[%zu.%u]:"
-			       " %u extends beyond end dir block"
-			       " (len %zu)",
-			       blkoff / sizeof(union afs_xdr_dir_block),
-			       offset, next, nlen);
+			_debug("ENT[%x]: extends beyond end dir block (len %zx)",
+			       base + slot, nlen);
 			return afs_bad(dvnode, afs_file_error_dir_over_end);
 		}
 
 		/* Check that the name-extension dirents are all allocated */
 		for (tmp = 1; tmp < nr_slots; tmp++) {
-			unsigned int ix = offset + tmp;
-			if (!(block->hdr.bitmap[ix / 8] & (1 << (ix % 8)))) {
-				_debug("ENT[%zu.u]:"
-				       " %u unmarked extension (%u/%u)",
-				       blkoff / sizeof(union afs_xdr_dir_block),
-				       offset, tmp, nr_slots);
+			unsigned int xslot = slot + tmp;
+
+			if (!(block->hdr.bitmap[xslot / 8] & (1 << (xslot % 8)))) {
+				_debug("ENT[%x]: Unmarked extension (%x/%x)",
+				       base + slot, tmp, nr_slots);
 				return afs_bad(dvnode, afs_file_error_dir_unmarked_ext);
 			}
 		}
 
 		/* skip if starts before the current position */
-		if (offset < curr) {
-			if (next > curr)
-				ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
+		if (slot < pos) {
+			if (next > pos)
+				ctx->pos = (base + next) * sizeof(union afs_xdr_dirent);
 			continue;
 		}
 
@@ -484,75 +440,110 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 			return 0;
 		}
 
-		ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
+		ctx->pos = (base + next) * sizeof(union afs_xdr_dirent);
 	}
 
 	_leave(" = 1 [more]");
 	return 1;
 }
 
+struct afs_dir_iteration_ctx {
+	struct dir_context	*dir_ctx;
+	int			error;
+};
+
 /*
- * iterate through the data blob that lists the contents of an AFS directory
+ * Iterate through a kmapped directory segment.
  */
-static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
-			   struct key *key, afs_dataversion_t *_dir_version)
+static size_t afs_dir_iterate_step(void *iter_base, size_t progress, size_t len,
+				   void *priv, void *priv2)
 {
-	struct afs_vnode *dvnode = AFS_FS_I(dir);
-	union afs_xdr_dir_block *dblock;
-	struct afs_read *req;
-	struct folio *folio;
-	unsigned offset, size;
+	struct afs_dir_iteration_ctx *ctx = priv2;
+	struct afs_vnode *dvnode = priv;
 	int ret;
 
-	_enter("{%lu},%u,,", dir->i_ino, (unsigned)ctx->pos);
-
-	if (test_bit(AFS_VNODE_DELETED, &AFS_FS_I(dir)->flags)) {
-		_leave(" = -ESTALE");
-		return -ESTALE;
+	if (WARN_ON_ONCE(progress % AFS_DIR_BLOCK_SIZE ||
+			 len % AFS_DIR_BLOCK_SIZE)) {
+		pr_err("Mis-iteration prog=%zx len=%zx\n",
+		       progress % AFS_DIR_BLOCK_SIZE,
+		       len % AFS_DIR_BLOCK_SIZE);
+		return len;
 	}
 
-	req = afs_read_dir(dvnode, key);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-	*_dir_version = req->data_version;
+	do {
+		ret = afs_dir_iterate_block(dvnode, ctx->dir_ctx, iter_base);
+		if (ret != 1)
+			break;
 
-	/* round the file position up to the next entry boundary */
-	ctx->pos += sizeof(union afs_xdr_dirent) - 1;
-	ctx->pos &= ~(sizeof(union afs_xdr_dirent) - 1);
+		ctx->dir_ctx->pos = round_up(ctx->dir_ctx->pos, AFS_DIR_BLOCK_SIZE);
+		iter_base += AFS_DIR_BLOCK_SIZE;
+		len -= AFS_DIR_BLOCK_SIZE;
+	} while (len > 0);
 
-	/* walk through the blocks in sequence */
-	ret = 0;
-	while (ctx->pos < req->actual_len) {
-		/* Fetch the appropriate folio from the directory and re-add it
-		 * to the LRU.  We have all the pages pinned with an extra ref.
-		 */
-		folio = __filemap_get_folio(dir->i_mapping, ctx->pos / PAGE_SIZE,
-					    FGP_ACCESSED, 0);
-		if (IS_ERR(folio)) {
-			ret = afs_bad(dvnode, afs_file_error_dir_missing_page);
-			break;
-		}
+	return len;
+}
 
-		offset = round_down(ctx->pos, sizeof(*dblock)) - folio_pos(folio);
-		size = min_t(loff_t, folio_size(folio),
-			     req->actual_len - folio_pos(folio));
+/*
+ * Iterate through the directory folios.
+ */
+static int afs_dir_iterate_contents(struct inode *dir, struct dir_context *dir_ctx)
+{
+	struct afs_dir_iteration_ctx ctx = { .dir_ctx = dir_ctx };
+	struct afs_vnode *dvnode = AFS_FS_I(dir);
+	struct iov_iter iter;
+	unsigned long long i_size = i_size_read(dir);
 
-		do {
-			dblock = kmap_local_folio(folio, offset);
-			ret = afs_dir_iterate_block(dvnode, ctx, dblock,
-						    folio_pos(folio) + offset);
-			kunmap_local(dblock);
-			if (ret != 1)
-				goto out;
+	/* Round the file position up to the next entry boundary */
+	dir_ctx->pos = round_up(dir_ctx->pos, sizeof(union afs_xdr_dirent));
 
-		} while (offset += sizeof(*dblock), offset < size);
+	if (i_size <= 0 || dir_ctx->pos >= i_size)
+		return 0;
 
-		ret = 0;
-	}
+	iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0, i_size);
+	iov_iter_advance(&iter, round_down(dir_ctx->pos, AFS_DIR_BLOCK_SIZE));
+
+	iterate_folioq(&iter, iov_iter_count(&iter), dvnode, &ctx,
+		       afs_dir_iterate_step);
+
+	if (ctx.error == -ESTALE)
+		afs_invalidate_dir(dvnode, afs_dir_invalid_iter_stale);
+	return ctx.error;
+}
+
+/*
+ * iterate through the data blob that lists the contents of an AFS directory
+ */
+static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
+			   struct file *file, afs_dataversion_t *_dir_version)
+{
+	struct afs_vnode *dvnode = AFS_FS_I(dir);
+	int retry_limit = 100;
+	int ret;
+
+	_enter("{%lu},%llx,,", dir->i_ino, ctx->pos);
+
+	do {
+		if (--retry_limit < 0) {
+			pr_warn("afs_read_dir(): Too many retries\n");
+			ret = -ESTALE;
+			break;
+		}
+		ret = afs_read_dir(dvnode, file);
+		if (ret < 0) {
+			if (ret != -ESTALE)
+				break;
+			if (test_bit(AFS_VNODE_DELETED, &AFS_FS_I(dir)->flags)) {
+				ret = -ESTALE;
+				break;
+			}
+			continue;
+		}
+		*_dir_version = inode_peek_iversion_raw(dir);
+
+		ret = afs_dir_iterate_contents(dir, ctx);
+		up_read(&dvnode->validate_lock);
+	} while (ret == -ESTALE);
 
-out:
-	up_read(&dvnode->validate_lock);
-	afs_put_read(req);
 	_leave(" = %d", ret);
 	return ret;
 }
@@ -564,8 +555,7 @@ static int afs_readdir(struct file *file, struct dir_context *ctx)
 {
 	afs_dataversion_t dir_version;
 
-	return afs_dir_iterate(file_inode(file), ctx, afs_file_key(file),
-			       &dir_version);
+	return afs_dir_iterate(file_inode(file), ctx, file, &dir_version);
 }
 
 /*
@@ -606,7 +596,7 @@ static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
  * - just returns the FID the dentry name maps to if found
  */
 static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
-			     struct afs_fid *fid, struct key *key,
+			     struct afs_fid *fid,
 			     afs_dataversion_t *_dir_version)
 {
 	struct afs_super_info *as = dir->i_sb->s_fs_info;
@@ -620,7 +610,7 @@ static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
 	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
 
 	/* search the directory */
-	ret = afs_dir_iterate(dir, &cookie.ctx, key, _dir_version);
+	ret = afs_dir_iterate(dir, &cookie.ctx, NULL, _dir_version);
 	if (ret < 0) {
 		_leave(" = %d [iter]", ret);
 		return ret;
@@ -787,8 +777,7 @@ static bool afs_server_supports_ibulk(struct afs_vnode *dvnode)
  * files in one go and create inodes for them.  The inode of the file we were
  * asked for is returned.
  */
-static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
-				   struct key *key)
+static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 {
 	struct afs_lookup_cookie *cookie;
 	struct afs_vnode_param *vp;
@@ -816,7 +805,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 		cookie->one_only = true;
 
 	/* search the directory */
-	ret = afs_dir_iterate(dir, &cookie->ctx, key, &data_version);
+	ret = afs_dir_iterate(dir, &cookie->ctx, NULL, &data_version);
 	if (ret < 0)
 		goto out;
 
@@ -925,8 +914,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 /*
  * Look up an entry in a directory with @sys substitution.
  */
-static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
-				       struct key *key)
+static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 {
 	struct afs_sysnames *subs;
 	struct afs_net *net = afs_i2net(dir);
@@ -974,7 +962,6 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
 	afs_put_sysnames(subs);
 	kfree(buf);
 out_p:
-	key_put(key);
 	return ret;
 }
 
@@ -988,7 +975,6 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	struct afs_fid fid = {};
 	struct inode *inode;
 	struct dentry *d;
-	struct key *key;
 	int ret;
 
 	_enter("{%llx:%llu},%p{%pd},",
@@ -1006,15 +992,9 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 		return ERR_PTR(-ESTALE);
 	}
 
-	key = afs_request_key(dvnode->volume->cell);
-	if (IS_ERR(key)) {
-		_leave(" = %ld [key]", PTR_ERR(key));
-		return ERR_CAST(key);
-	}
-
-	ret = afs_validate(dvnode, key);
+	ret = afs_validate(dvnode, NULL);
 	if (ret < 0) {
-		key_put(key);
+		afs_dir_unuse_cookie(dvnode, ret);
 		_leave(" = %d [val]", ret);
 		return ERR_PTR(ret);
 	}
@@ -1024,11 +1004,10 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	    dentry->d_name.name[dentry->d_name.len - 3] == 's' &&
 	    dentry->d_name.name[dentry->d_name.len - 2] == 'y' &&
 	    dentry->d_name.name[dentry->d_name.len - 1] == 's')
-		return afs_lookup_atsys(dir, dentry, key);
+		return afs_lookup_atsys(dir, dentry);
 
 	afs_stat_v(dvnode, n_lookup);
-	inode = afs_do_lookup(dir, dentry, key);
-	key_put(key);
+	inode = afs_do_lookup(dir, dentry);
 	if (inode == ERR_PTR(-ENOENT))
 		inode = afs_try_auto_mntpt(dentry, dir);
 
@@ -1154,7 +1133,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	afs_stat_v(dir, n_reval);
 
 	/* search the directory for this vnode */
-	ret = afs_do_lookup_one(&dir->netfs.inode, dentry, &fid, key, &dir_version);
+	ret = afs_do_lookup_one(&dir->netfs.inode, dentry, &fid, &dir_version);
 	switch (ret) {
 	case 0:
 		/* the filename maps to something */
@@ -1316,18 +1295,21 @@ static void afs_create_success(struct afs_operation *op)
 
 static void afs_create_edit_dir(struct afs_operation *op)
 {
+	struct netfs_cache_resources cres = {};
 	struct afs_vnode_param *dvp = &op->file[0];
 	struct afs_vnode_param *vp = &op->file[1];
 	struct afs_vnode *dvnode = dvp->vnode;
 
 	_enter("op=%08x", op->debug_id);
 
+	fscache_begin_write_operation(&cres, afs_vnode_cache(dvnode));
 	down_write(&dvnode->validate_lock);
 	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) &&
 	    dvnode->status.data_version == dvp->dv_before + dvp->dv_delta)
 		afs_edit_dir_add(dvnode, &op->dentry->d_name, &vp->fid,
 				 op->create.reason);
 	up_write(&dvnode->validate_lock);
+	fscache_end_operation(&cres);
 }
 
 static void afs_create_put(struct afs_operation *op)
@@ -1355,6 +1337,7 @@ static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct afs_operation *op;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
+	int ret;
 
 	_enter("{%llx:%llu},{%pd},%ho",
 	       dvnode->fid.vid, dvnode->fid.vnode, dentry, mode);
@@ -1365,6 +1348,8 @@ static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		return PTR_ERR(op);
 	}
 
+	fscache_use_cookie(afs_vnode_cache(dvnode), true);
+
 	afs_op_set_vnode(op, 0, dvnode);
 	op->file[0].dv_delta = 1;
 	op->file[0].modification = true;
@@ -1374,7 +1359,9 @@ static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	op->create.reason = afs_edit_dir_for_mkdir;
 	op->mtime	= current_time(dir);
 	op->ops		= &afs_mkdir_operation;
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+	afs_dir_unuse_cookie(dvnode, ret);
+	return ret;
 }
 
 /*
@@ -1402,18 +1389,21 @@ static void afs_rmdir_success(struct afs_operation *op)
 
 static void afs_rmdir_edit_dir(struct afs_operation *op)
 {
+	struct netfs_cache_resources cres = {};
 	struct afs_vnode_param *dvp = &op->file[0];
 	struct afs_vnode *dvnode = dvp->vnode;
 
 	_enter("op=%08x", op->debug_id);
 	afs_dir_remove_subdir(op->dentry);
 
+	fscache_begin_write_operation(&cres, afs_vnode_cache(dvnode));
 	down_write(&dvnode->validate_lock);
 	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) &&
 	    dvnode->status.data_version == dvp->dv_before + dvp->dv_delta)
 		afs_edit_dir_remove(dvnode, &op->dentry->d_name,
 				    afs_edit_dir_for_rmdir);
 	up_write(&dvnode->validate_lock);
+	fscache_end_operation(&cres);
 }
 
 static void afs_rmdir_put(struct afs_operation *op)
@@ -1448,6 +1438,8 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (IS_ERR(op))
 		return PTR_ERR(op);
 
+	fscache_use_cookie(afs_vnode_cache(dvnode), true);
+
 	afs_op_set_vnode(op, 0, dvnode);
 	op->file[0].dv_delta = 1;
 	op->file[0].modification = true;
@@ -1476,10 +1468,13 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 	/* Not all systems that can host afs servers have ENOTEMPTY. */
 	if (ret == -EEXIST)
 		ret = -ENOTEMPTY;
+out:
+	afs_dir_unuse_cookie(dvnode, ret);
 	return ret;
 
 error:
-	return afs_put_operation(op);
+	ret = afs_put_operation(op);
+	goto out;
 }
 
 /*
@@ -1542,16 +1537,19 @@ static void afs_unlink_success(struct afs_operation *op)
 
 static void afs_unlink_edit_dir(struct afs_operation *op)
 {
+	struct netfs_cache_resources cres = {};
 	struct afs_vnode_param *dvp = &op->file[0];
 	struct afs_vnode *dvnode = dvp->vnode;
 
 	_enter("op=%08x", op->debug_id);
+	fscache_begin_write_operation(&cres, afs_vnode_cache(dvnode));
 	down_write(&dvnode->validate_lock);
 	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) &&
 	    dvnode->status.data_version == dvp->dv_before + dvp->dv_delta)
 		afs_edit_dir_remove(dvnode, &op->dentry->d_name,
 				    afs_edit_dir_for_unlink);
 	up_write(&dvnode->validate_lock);
+	fscache_end_operation(&cres);
 }
 
 static void afs_unlink_put(struct afs_operation *op)
@@ -1590,6 +1588,8 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_ERR(op))
 		return PTR_ERR(op);
 
+	fscache_use_cookie(afs_vnode_cache(dvnode), true);
+
 	afs_op_set_vnode(op, 0, dvnode);
 	op->file[0].dv_delta = 1;
 	op->file[0].modification = true;
@@ -1636,10 +1636,10 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 		afs_wait_for_operation(op);
 	}
 
-	return afs_put_operation(op);
-
 error:
-	return afs_put_operation(op);
+	ret = afs_put_operation(op);
+	afs_dir_unuse_cookie(dvnode, ret);
+	return ret;
 }
 
 static const struct afs_operation_ops afs_create_operation = {
@@ -1673,6 +1673,8 @@ static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
 		goto error;
 	}
 
+	fscache_use_cookie(afs_vnode_cache(dvnode), true);
+
 	afs_op_set_vnode(op, 0, dvnode);
 	op->file[0].dv_delta = 1;
 	op->file[0].modification = true;
@@ -1683,7 +1685,9 @@ static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
 	op->create.reason = afs_edit_dir_for_create;
 	op->mtime	= current_time(dir);
 	op->ops		= &afs_create_operation;
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+	afs_dir_unuse_cookie(dvnode, ret);
+	return ret;
 
 error:
 	d_drop(dentry);
@@ -1748,6 +1752,8 @@ static int afs_link(struct dentry *from, struct inode *dir,
 		goto error;
 	}
 
+	fscache_use_cookie(afs_vnode_cache(dvnode), true);
+
 	ret = afs_validate(vnode, op->key);
 	if (ret < 0)
 		goto error_op;
@@ -1763,10 +1769,13 @@ static int afs_link(struct dentry *from, struct inode *dir,
 	op->dentry_2		= from;
 	op->ops			= &afs_link_operation;
 	op->create.reason	= afs_edit_dir_for_link;
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+	afs_dir_unuse_cookie(dvnode, ret);
+	return ret;
 
 error_op:
 	afs_put_operation(op);
+	afs_dir_unuse_cookie(dvnode, ret);
 error:
 	d_drop(dentry);
 	_leave(" = %d", ret);
@@ -1810,6 +1819,8 @@ static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		goto error;
 	}
 
+	fscache_use_cookie(afs_vnode_cache(dvnode), true);
+
 	afs_op_set_vnode(op, 0, dvnode);
 	op->file[0].dv_delta = 1;
 
@@ -1818,7 +1829,9 @@ static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	op->create.reason	= afs_edit_dir_for_symlink;
 	op->create.symlink	= content;
 	op->mtime		= current_time(dir);
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+	afs_dir_unuse_cookie(dvnode, ret);
+	return ret;
 
 error:
 	d_drop(dentry);
@@ -1860,6 +1873,7 @@ static void afs_rename_success(struct afs_operation *op)
 
 static void afs_rename_edit_dir(struct afs_operation *op)
 {
+	struct netfs_cache_resources orig_cres = {}, new_cres = {};
 	struct afs_vnode_param *orig_dvp = &op->file[0];
 	struct afs_vnode_param *new_dvp = &op->file[1];
 	struct afs_vnode *orig_dvnode = orig_dvp->vnode;
@@ -1876,6 +1890,10 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 		op->rename.rehash = NULL;
 	}
 
+	fscache_begin_write_operation(&orig_cres, afs_vnode_cache(orig_dvnode));
+	if (new_dvnode != orig_dvnode)
+		fscache_begin_write_operation(&new_cres, afs_vnode_cache(new_dvnode));
+
 	down_write(&orig_dvnode->validate_lock);
 	if (test_bit(AFS_VNODE_DIR_VALID, &orig_dvnode->flags) &&
 	    orig_dvnode->status.data_version == orig_dvp->dv_before + orig_dvp->dv_delta)
@@ -1925,6 +1943,9 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 	d_move(old_dentry, new_dentry);
 
 	up_write(&new_dvnode->validate_lock);
+	fscache_end_operation(&orig_cres);
+	if (new_dvnode != orig_dvnode)
+		fscache_end_operation(&new_cres);
 }
 
 static void afs_rename_put(struct afs_operation *op)
@@ -1977,6 +1998,10 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (IS_ERR(op))
 		return PTR_ERR(op);
 
+	fscache_use_cookie(afs_vnode_cache(orig_dvnode), true);
+	if (new_dvnode != orig_dvnode)
+		fscache_use_cookie(afs_vnode_cache(new_dvnode), true);
+
 	ret = afs_validate(vnode, op->key);
 	afs_op_set_error(op, ret);
 	if (ret < 0)
@@ -2044,45 +2069,43 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 */
 	d_drop(old_dentry);
 
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+out:
+	afs_dir_unuse_cookie(orig_dvnode, ret);
+	if (new_dvnode != orig_dvnode)
+		afs_dir_unuse_cookie(new_dvnode, ret);
+	return ret;
 
 error:
-	return afs_put_operation(op);
-}
-
-/*
- * Release a directory folio and clean up its private state if it's not busy
- * - return true if the folio can now be released, false if not
- */
-static bool afs_dir_release_folio(struct folio *folio, gfp_t gfp_flags)
-{
-	struct afs_vnode *dvnode = AFS_FS_I(folio_inode(folio));
-
-	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, folio->index);
-
-	folio_detach_private(folio);
-
-	/* The directory will need reloading. */
-	afs_invalidate_dir(dvnode, afs_dir_invalid_release_folio);
-	return true;
+	ret = afs_put_operation(op);
+	goto out;
 }
 
 /*
- * Invalidate part or all of a folio.
+ * Write the file contents to the cache as a single blob.
  */
-static void afs_dir_invalidate_folio(struct folio *folio, size_t offset,
-				   size_t length)
+int afs_single_writepages(struct address_space *mapping,
+			  struct writeback_control *wbc)
 {
-	struct afs_vnode *dvnode = AFS_FS_I(folio_inode(folio));
-
-	_enter("{%lu},%zu,%zu", folio->index, offset, length);
-
-	BUG_ON(!folio_test_locked(folio));
+	struct afs_vnode *dvnode = AFS_FS_I(mapping->host);
+	struct iov_iter iter;
+	bool is_dir = (S_ISDIR(dvnode->netfs.inode.i_mode) &&
+		       !test_bit(AFS_VNODE_MOUNTPOINT, &dvnode->flags));
+	int ret = 0;
 
-	/* The directory will need reloading. */
-	afs_invalidate_dir(dvnode, afs_dir_invalid_inval_folio);
+	/* Need to lock to prevent the folio queue and folios from being thrown
+	 * away.
+	 */
+	down_read(&dvnode->validate_lock);
+
+	if (is_dir ?
+	    test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) :
+	    atomic64_read(&dvnode->cb_expires_at) != AFS_NO_CB_PROMISE) {
+		iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
+				     i_size_read(&dvnode->netfs.inode));
+		ret = netfs_writeback_single(mapping, wbc, &iter);
+	}
 
-	/* we clean up only if the entire folio is being invalidated */
-	if (offset == 0 && length == folio_size(folio))
-		folio_detach_private(folio);
+	up_read(&dvnode->validate_lock);
+	return ret;
 }
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 5d092c8c0157..71cce884e434 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -10,6 +10,7 @@
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/iversion.h>
+#include <linux/folio_queue.h>
 #include "internal.h"
 #include "xdr_fs.h"
 
@@ -105,23 +106,57 @@ static void afs_clear_contig_bits(union afs_xdr_dir_block *block,
 }
 
 /*
- * Get a new directory folio.
+ * Get a specific block, extending the directory storage to cover it as needed.
  */
-static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t index)
+static union afs_xdr_dir_block *afs_dir_get_block(struct afs_dir_iter *iter, size_t block)
 {
-	struct address_space *mapping = vnode->netfs.inode.i_mapping;
+	struct folio_queue *fq;
+	struct afs_vnode *dvnode = iter->dvnode;
 	struct folio *folio;
+	size_t blpos = block * AFS_DIR_BLOCK_SIZE;
+	size_t blend = (block + 1) * AFS_DIR_BLOCK_SIZE, fpos = iter->fpos;
+	int ret;
+
+	if (dvnode->directory_size < blend) {
+		size_t cur_size = dvnode->directory_size;
+
+		ret = netfs_alloc_folioq_buffer(
+			NULL, &dvnode->directory, &cur_size, blend,
+			mapping_gfp_mask(dvnode->netfs.inode.i_mapping));
+		dvnode->directory_size = cur_size;
+		if (ret < 0)
+			goto fail;
+	}
 
-	folio = __filemap_get_folio(mapping, index,
-				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
-				    mapping->gfp_mask);
-	if (IS_ERR(folio)) {
-		afs_invalidate_dir(vnode, afs_dir_invalid_edit_get_block);
-		return NULL;
+	fq = iter->fq;
+	if (!fq)
+		fq = dvnode->directory;
+
+	/* Search the folio queue for the folio containing the block... */
+	for (; fq; fq = fq->next) {
+		for (int s = iter->fq_slot; s < folioq_count(fq); s++) {
+			size_t fsize = folioq_folio_size(fq, s);
+
+			if (blend <= fpos + fsize) {
+				/* ... and then return the mapped block. */
+				folio = folioq_folio(fq, s);
+				if (WARN_ON_ONCE(folio_pos(folio) != fpos))
+					goto fail;
+				iter->fq = fq;
+				iter->fq_slot = s;
+				iter->fpos = fpos;
+				return kmap_local_folio(folio, blpos - fpos);
+			}
+			fpos += fsize;
+		}
+		iter->fq_slot = 0;
 	}
-	if (!folio_test_private(folio))
-		folio_attach_private(folio, (void *)1);
-	return folio;
+
+fail:
+	iter->fq = NULL;
+	iter->fq_slot = 0;
+	afs_invalidate_dir(dvnode, afs_dir_invalid_edit_get_block);
+	return NULL;
 }
 
 /*
@@ -209,9 +244,8 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 {
 	union afs_xdr_dir_block *meta, *block;
 	union afs_xdr_dirent *de;
-	struct folio *folio0, *folio;
+	struct afs_dir_iter iter = { .dvnode = vnode };
 	unsigned int need_slots, nr_blocks, b;
-	pgoff_t index;
 	loff_t i_size;
 	int slot;
 
@@ -224,16 +258,13 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		return;
 	}
 
-	folio0 = afs_dir_get_folio(vnode, 0);
-	if (!folio0) {
-		_leave(" [fgp]");
+	meta = afs_dir_get_block(&iter, 0);
+	if (!meta)
 		return;
-	}
 
 	/* Work out how many slots we're going to need. */
 	need_slots = afs_dir_calc_slots(name->len);
 
-	meta = kmap_local_folio(folio0, 0);
 	if (i_size == 0)
 		goto new_directory;
 	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
@@ -245,18 +276,17 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		/* If the directory extended into a new folio, then we need to
 		 * tack a new folio on the end.
 		 */
-		index = b / AFS_DIR_BLOCKS_PER_PAGE;
 		if (nr_blocks >= AFS_DIR_MAX_BLOCKS)
 			goto error_too_many_blocks;
-		if (index >= folio_nr_pages(folio0)) {
-			folio = afs_dir_get_folio(vnode, index);
-			if (!folio)
-				goto error;
-		} else {
-			folio = folio0;
-		}
 
-		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_pos(folio));
+		/* Lower dir blocks have a counter in the header we can check. */
+		if (b < AFS_DIR_BLOCKS_WITH_CTR &&
+		    meta->meta.alloc_ctrs[b] < need_slots)
+			continue;
+
+		block = afs_dir_get_block(&iter, b);
+		if (!block)
+			goto error;
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
@@ -275,24 +305,16 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 			afs_set_i_size(vnode, (b + 1) * AFS_DIR_BLOCK_SIZE);
 		}
 
-		/* Only lower dir blocks have a counter in the header. */
-		if (b >= AFS_DIR_BLOCKS_WITH_CTR ||
-		    meta->meta.alloc_ctrs[b] >= need_slots) {
-			/* We need to try and find one or more consecutive
-			 * slots to hold the entry.
-			 */
-			slot = afs_find_contig_bits(block, need_slots);
-			if (slot >= 0) {
-				_debug("slot %u", slot);
-				goto found_space;
-			}
+		/* We need to try and find one or more consecutive slots to
+		 * hold the entry.
+		 */
+		slot = afs_find_contig_bits(block, need_slots);
+		if (slot >= 0) {
+			_debug("slot %u", slot);
+			goto found_space;
 		}
 
 		kunmap_local(block);
-		if (folio != folio0) {
-			folio_unlock(folio);
-			folio_put(folio);
-		}
 	}
 
 	/* There are no spare slots of sufficient size, yet the operation
@@ -307,8 +329,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	i_size = AFS_DIR_BLOCK_SIZE;
 	afs_set_i_size(vnode, i_size);
 	slot = AFS_DIR_RESV_BLOCKS0;
-	folio = folio0;
-	block = kmap_local_folio(folio, 0);
+	block = afs_dir_get_block(&iter, 0);
 	nr_blocks = 1;
 	b = 0;
 
@@ -328,10 +349,6 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	/* Adjust the bitmap. */
 	afs_set_contig_bits(block, slot, need_slots);
 	kunmap_local(block);
-	if (folio != folio0) {
-		folio_unlock(folio);
-		folio_put(folio);
-	}
 
 	/* Adjust the allocation counter. */
 	if (b < AFS_DIR_BLOCKS_WITH_CTR)
@@ -341,20 +358,16 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	afs_stat_v(vnode, n_dir_cr);
 	_debug("Insert %s in %u[%u]", name->name, b, slot);
 
+	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
+
 out_unmap:
 	kunmap_local(meta);
-	folio_unlock(folio0);
-	folio_put(folio0);
 	_leave("");
 	return;
 
 already_invalidated:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_inval, 0, 0, 0, 0, name->name);
 	kunmap_local(block);
-	if (folio != folio0) {
-		folio_unlock(folio);
-		folio_put(folio);
-	}
 	goto out_unmap;
 
 error_too_many_blocks:
@@ -376,9 +389,8 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 {
 	union afs_xdr_dir_block *meta, *block;
 	union afs_xdr_dirent *de;
-	struct folio *folio0, *folio;
+	struct afs_dir_iter iter = { .dvnode = vnode };
 	unsigned int need_slots, nr_blocks, b;
-	pgoff_t index;
 	loff_t i_size;
 	int slot;
 
@@ -393,31 +405,20 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	}
 	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
 
-	folio0 = afs_dir_get_folio(vnode, 0);
-	if (!folio0) {
-		_leave(" [fgp]");
+	meta = afs_dir_get_block(&iter, 0);
+	if (!meta)
 		return;
-	}
 
 	/* Work out how many slots we're going to discard. */
 	need_slots = afs_dir_calc_slots(name->len);
 
-	meta = kmap_local_folio(folio0, 0);
-
 	/* Find a block that has sufficient slots available.  Each folio
 	 * contains two or more directory blocks.
 	 */
 	for (b = 0; b < nr_blocks; b++) {
-		index = b / AFS_DIR_BLOCKS_PER_PAGE;
-		if (index >= folio_nr_pages(folio0)) {
-			folio = afs_dir_get_folio(vnode, index);
-			if (!folio)
-				goto error;
-		} else {
-			folio = folio0;
-		}
-
-		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_pos(folio));
+		block = afs_dir_get_block(&iter, b);
+		if (!block)
+			goto error;
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
@@ -431,10 +432,6 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 		}
 
 		kunmap_local(block);
-		if (folio != folio0) {
-			folio_unlock(folio);
-			folio_put(folio);
-		}
 	}
 
 	/* Didn't find the dirent to clobber.  Download the directory again. */
@@ -455,34 +452,26 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	/* Adjust the bitmap. */
 	afs_clear_contig_bits(block, slot, need_slots);
 	kunmap_local(block);
-	if (folio != folio0) {
-		folio_unlock(folio);
-		folio_put(folio);
-	}
 
 	/* Adjust the allocation counter. */
 	if (b < AFS_DIR_BLOCKS_WITH_CTR)
 		meta->meta.alloc_ctrs[b] += need_slots;
 
+	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
+
 	inode_set_iversion_raw(&vnode->netfs.inode, vnode->status.data_version);
 	afs_stat_v(vnode, n_dir_rm);
 	_debug("Remove %s from %u[%u]", name->name, b, slot);
 
 out_unmap:
 	kunmap_local(meta);
-	folio_unlock(folio0);
-	folio_put(folio0);
 	_leave("");
 	return;
 
 already_invalidated:
+	kunmap_local(block);
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_inval,
 			   0, 0, 0, 0, name->name);
-	kunmap_local(block);
-	if (folio != folio0) {
-		folio_unlock(folio);
-		folio_put(folio);
-	}
 	goto out_unmap;
 
 error:
@@ -500,9 +489,8 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 {
 	union afs_xdr_dir_block *block;
 	union afs_xdr_dirent *de;
-	struct folio *folio;
+	struct afs_dir_iter iter = { .dvnode = vnode };
 	unsigned int nr_blocks, b;
-	pgoff_t index;
 	loff_t i_size;
 	int slot;
 
@@ -513,19 +501,17 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 		afs_invalidate_dir(vnode, afs_dir_invalid_edit_upd_bad_size);
 		return;
 	}
+
 	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
 
 	/* Find a block that has sufficient slots available.  Each folio
 	 * contains two or more directory blocks.
 	 */
 	for (b = 0; b < nr_blocks; b++) {
-		index = b / AFS_DIR_BLOCKS_PER_PAGE;
-		folio = afs_dir_get_folio(vnode, index);
-		if (!folio)
+		block = afs_dir_get_block(&iter, b);
+		if (!block)
 			goto error;
 
-		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_pos(folio));
-
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
 			goto already_invalidated;
@@ -535,8 +521,6 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 			goto found_dirent;
 
 		kunmap_local(block);
-		folio_unlock(folio);
-		folio_put(folio);
 	}
 
 	/* Didn't find the dirent to clobber.  Download the directory again. */
@@ -554,8 +538,7 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 			   ntohl(de->u.vnode), ntohl(de->u.unique), "..");
 
 	kunmap_local(block);
-	folio_unlock(folio);
-	folio_put(folio);
+	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
 	inode_set_iversion_raw(&vnode->netfs.inode, vnode->status.data_version);
 
 out:
@@ -564,8 +547,6 @@ void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_d
 
 already_invalidated:
 	kunmap_local(block);
-	folio_unlock(folio);
-	folio_put(folio);
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_inval,
 			   0, 0, 0, 0, "..");
 	goto out;
diff --git a/fs/afs/file.c b/fs/afs/file.c
index a9d98d18407c..5bc36bfaa173 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -389,6 +389,14 @@ static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 			rreq->netfs_priv = key;
 		}
 		break;
+	case NETFS_WRITEBACK:
+	case NETFS_WRITETHROUGH:
+	case NETFS_UNBUFFERED_WRITE:
+	case NETFS_DIO_WRITE:
+		if (S_ISREG(rreq->inode->i_mode))
+			rreq->io_streams[0].avail = true;
+		break;
+	case NETFS_WRITEBACK_SINGLE:
 	default:
 		break;
 	}
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 495ecef91679..0ed1e5c35fef 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -110,7 +110,9 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 		inode->i_op	= &afs_dir_inode_operations;
 		inode->i_fop	= &afs_dir_file_operations;
 		inode->i_mapping->a_ops	= &afs_dir_aops;
-		mapping_set_large_folios(inode->i_mapping);
+		__set_bit(NETFS_ICTX_SINGLE_NO_UPLOAD, &vnode->netfs.flags);
+		/* Assume locally cached directory data will be valid. */
+		__set_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 		break;
 	case AFS_FTYPE_SYMLINK:
 		/* Symlinks with a mode of 0644 are actually mountpoints. */
@@ -440,7 +442,8 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 	} __packed key;
 	struct afs_vnode_cache_aux aux;
 
-	if (vnode->status.type != AFS_FTYPE_FILE) {
+	if (vnode->status.type != AFS_FTYPE_FILE &&
+	    vnode->status.type != AFS_FTYPE_DIR) {
 		vnode->netfs.cache = NULL;
 		return;
 	}
@@ -642,6 +645,7 @@ int afs_drop_inode(struct inode *inode)
 void afs_evict_inode(struct inode *inode)
 {
 	struct afs_vnode_cache_aux aux;
+	struct afs_super_info *sbi = AFS_FS_S(inode->i_sb);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 
 	_enter("{%llx:%llu.%d}",
@@ -653,8 +657,21 @@ void afs_evict_inode(struct inode *inode)
 
 	ASSERTCMP(inode->i_ino, ==, vnode->fid.vnode);
 
+	if ((S_ISDIR(inode->i_mode)) &&
+	    (inode->i_state & I_DIRTY) &&
+	    !sbi->dyn_root) {
+		struct writeback_control wbc = {
+			.sync_mode = WB_SYNC_ALL,
+			.for_sync = true,
+			.range_end = LLONG_MAX,
+		};
+
+		afs_single_writepages(inode->i_mapping, &wbc);
+	}
+
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
+	netfs_free_folioq_buffer(vnode->directory);
 
 	afs_set_cache_aux(vnode, &aux);
 	netfs_clear_inode_writeback(inode, &aux);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 20d2f723948d..1744a93aae27 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -720,7 +720,9 @@ struct afs_vnode {
 #define AFS_VNODE_NEW_CONTENT	8		/* Set if file has new content (create/trunc-0) */
 #define AFS_VNODE_SILLY_DELETED	9		/* Set if file has been silly-deleted */
 #define AFS_VNODE_MODIFYING	10		/* Set if we're performing a modification op */
+#define AFS_VNODE_DIR_READ	11		/* Set if we've read a dir's contents */
 
+	struct folio_queue	*directory;	/* Directory contents */
 	struct list_head	wb_keys;	/* List of keys available for writeback */
 	struct list_head	pending_locks;	/* locks waiting to be granted */
 	struct list_head	granted_locks;	/* locks granted on this file */
@@ -729,6 +731,7 @@ struct afs_vnode {
 	ktime_t			locked_at;	/* Time at which lock obtained */
 	enum afs_lock_state	lock_state : 8;
 	afs_lock_type_t		lock_type : 8;
+	unsigned int		directory_size;	/* Amount of space in ->directory */
 
 	/* outstanding callback notification on this file */
 	struct work_struct	cb_work;	/* Work for mmap'd files */
@@ -984,6 +987,16 @@ static inline void afs_invalidate_cache(struct afs_vnode *vnode, unsigned int fl
 			   i_size_read(&vnode->netfs.inode), flags);
 }
 
+/*
+ * Directory iteration management.
+ */
+struct afs_dir_iter {
+	struct afs_vnode	*dvnode;
+	struct folio_queue	*fq;
+	unsigned int		fpos;
+	int			fq_slot;
+};
+
 #include <trace/events/afs.h>
 
 /*****************************************************************************/
@@ -1065,8 +1078,11 @@ extern const struct inode_operations afs_dir_inode_operations;
 extern const struct address_space_operations afs_dir_aops;
 extern const struct dentry_operations afs_fs_dentry_operations;
 
+ssize_t afs_read_single(struct afs_vnode *dvnode, struct file *file);
 extern void afs_d_release(struct dentry *);
 extern void afs_check_for_remote_deletion(struct afs_operation *);
+int afs_single_writepages(struct address_space *mapping,
+			  struct writeback_control *wbc);
 
 /*
  * dir_edit.c
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 7631302c1984..a9bee610674e 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -696,6 +696,8 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 	vnode->volume		= NULL;
 	vnode->lock_key		= NULL;
 	vnode->permit_cache	= NULL;
+	vnode->directory	= NULL;
+	vnode->directory_size	= 0;
 
 	vnode->flags		= 1 << AFS_VNODE_UNSET;
 	vnode->lock_state	= AFS_VNODE_LOCK_NONE;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index ccb6aa8027c5..62570357a0bd 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -182,8 +182,8 @@ void afs_issue_write(struct netfs_io_subrequest *subreq)
  */
 void afs_begin_writeback(struct netfs_io_request *wreq)
 {
-	afs_get_writeback_key(wreq);
-	wreq->io_streams[0].avail = true;
+	if (S_ISREG(wreq->inode->i_mode))
+		afs_get_writeback_key(wreq);
 }
 
 /*
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 7cb5583efb91..d05f2c09efe3 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -930,9 +930,9 @@ TRACE_EVENT(afs_sent_data,
 	    );
 
 TRACE_EVENT(afs_dir_check_failed,
-	    TP_PROTO(struct afs_vnode *vnode, loff_t off, loff_t i_size),
+	    TP_PROTO(struct afs_vnode *vnode, loff_t off),
 
-	    TP_ARGS(vnode, off, i_size),
+	    TP_ARGS(vnode, off),
 
 	    TP_STRUCT__entry(
 		    __field(struct afs_vnode *,		vnode)
@@ -943,7 +943,7 @@ TRACE_EVENT(afs_dir_check_failed,
 	    TP_fast_assign(
 		    __entry->vnode = vnode;
 		    __entry->off = off;
-		    __entry->i_size = i_size;
+		    __entry->i_size = i_size_read(&vnode->netfs.inode);
 			   ),
 
 	    TP_printk("vn=%p %llx/%llx",



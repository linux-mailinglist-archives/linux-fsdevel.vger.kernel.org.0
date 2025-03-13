Return-Path: <linux-fsdevel+bounces-43985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F4AA60616
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A93B069F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824AD1FECCE;
	Thu, 13 Mar 2025 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LB63IxdQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE61FBC85
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741909070; cv=none; b=E2JTXUsyrLopS3fc2lGYTzjAQ4zaTmB/wmw8BSjZyhWWRdaiV3PeR6GVRbQ5jlyFXhd3uHRK8xnfSpqQhHwvyqQX57dsLC396kVHifDT+fYgfd5/z40o5u03yy1RHi3Cyc16SJGB/snIXsrb5b5b7NO+tY01IxOarmdH31YMZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741909070; c=relaxed/simple;
	bh=8djWi7SuWKOGXUwbQY4fSWBD+ETv7VH/9upz2BW8Py4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXRHp0mAgcerhVVPtioThYtHeixQBEqs0mSt8hAK2auheqCjv7y4H20eibPDYpOMIDVPmWNTAt+HFbeQu4bXmnvpFwLSECcuWqC8M0q4iB9qGdQkah9j6hA6eNtLquxay5nDp9jksvNqYwax4D5Ltkgg2H8sBfUDntqyL0gzm5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LB63IxdQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741909066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NFx2gstzGhKTf0+VpOC9RFirA8o4q6xxXCeal6JkFo=;
	b=LB63IxdQGjVrIhHkkOsZ4A3mkPGbHHGf8s/8Il7lGv9vWPPCy1BNSX4CD1wYR9ov5fAaze
	tuHZ7ainytOsssfiysC+VlU5AWdM/mHRUfKJQgXk4ftJunPEFZ0RR/0/ofkkHuE5aYK5KS
	d0V/jzDjyF6p8j7QHd8BQsPHL1rSVpE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-mnQ529y7Pp-V0Pt3_TBoog-1; Thu,
 13 Mar 2025 19:35:53 -0400
X-MC-Unique: mnQ529y7Pp-V0Pt3_TBoog-1
X-Mimecast-MFC-AGG-ID: mnQ529y7Pp-V0Pt3_TBoog_1741908952
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B0F3180899B;
	Thu, 13 Mar 2025 23:35:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4D95300376F;
	Thu, 13 Mar 2025 23:35:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 33/35] ceph: Use netfslib [INCOMPLETE]
Date: Thu, 13 Mar 2025 23:33:25 +0000
Message-ID: <20250313233341.1675324-34-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Implement netfslib support for ceph.

Note that I've put the new code into its own file for now rather than
attempting to modify the old code or putting it into an existing file.  The
old code is just #if'd out for removal in a subsequent patch to make this
patch easier to review.

Note also that this is incomplete as sparse map support and content crypto
support are currently non-functional - but plain I/O should work.

There may also be an inode ref leak due to the way the ceph sometimes takes
and holds on to an extra inode ref under some circumstances.  I'm not sure
these are actually necessary.  For instance, ceph_dirty_folio() will ihold
the inode if ci->i_wrbuffer_ref is 0

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 drivers/block/rbd.c             |    2 +-
 fs/ceph/Makefile                |    2 +-
 fs/ceph/addr.c                  |   46 +-
 fs/ceph/cache.h                 |    5 +
 fs/ceph/caps.c                  |    2 +-
 fs/ceph/crypto.c                |   54 ++
 fs/ceph/file.c                  |   15 +-
 fs/ceph/inode.c                 |   30 +-
 fs/ceph/rdwr.c                  | 1006 +++++++++++++++++++++++++++++++
 fs/ceph/super.h                 |   39 +-
 fs/netfs/internal.h             |    6 +-
 fs/netfs/main.c                 |    4 +-
 fs/netfs/write_issue.c          |    6 +-
 include/linux/ceph/libceph.h    |    3 +-
 include/linux/ceph/osd_client.h |    1 +
 include/linux/netfs.h           |   13 +-
 net/ceph/snapshot.c             |   20 +-
 17 files changed, 1190 insertions(+), 64 deletions(-)
 create mode 100644 fs/ceph/rdwr.c

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 956fc4a8f1da..94bb29c95b0d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -468,7 +468,7 @@ static DEFINE_IDA(rbd_dev_id_ida);
 static struct workqueue_struct *rbd_wq;
 
 static struct ceph_snap_context rbd_empty_snapc = {
-	.nref = REFCOUNT_INIT(1),
+	.group.ref = REFCOUNT_INIT(1),
 };
 
 /*
diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index 1f77ca04c426..e4d3c2d6e9c2 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_CEPH_FS) += ceph.o
 
-ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
+ceph-y := super.o inode.o dir.o file.o locks.o addr.o rdwr.o ioctl.o \
 	export.o caps.o snap.o xattr.o quota.o io.o \
 	mds_client.o mdsmap.o strings.o ceph_frag.o \
 	debugfs.o util.o metric.o
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 27f27ab24446..325fbbce1eaa 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -64,27 +64,30 @@
 	(CONGESTION_ON_THRESH(congestion_kb) -				\
 	 (CONGESTION_ON_THRESH(congestion_kb) >> 2))
 
+#if 0 // TODO: Remove after netfs conversion
 static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
 					struct folio **foliop, void **_fsdata);
 
-static inline struct ceph_snap_context *page_snap_context(struct page *page)
+static struct ceph_snap_context *page_snap_context(struct page *page)
 {
 	if (PagePrivate(page))
 		return (void *)page->private;
 	return NULL;
 }
+#endif // TODO: Remove after netfs conversion
 
 /*
  * Dirty a page.  Optimistically adjust accounting, on the assumption
  * that we won't race with invalidate.  If we do, readjust.
  */
-static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
+bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc;
+	struct netfs_group *group;
 
 	if (folio_test_dirty(folio)) {
 		doutc(cl, "%llx.%llx %p idx %lu -- already dirty\n",
@@ -101,16 +104,28 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 	spin_lock(&ci->i_ceph_lock);
 	if (__ceph_have_pending_cap_snap(ci)) {
 		struct ceph_cap_snap *capsnap =
-				list_last_entry(&ci->i_cap_snaps,
-						struct ceph_cap_snap,
-						ci_item);
-		snapc = ceph_get_snap_context(capsnap->context);
+			list_last_entry(&ci->i_cap_snaps,
+					struct ceph_cap_snap,
+					ci_item);
+		snapc = capsnap->context;
 		capsnap->dirty_pages++;
 	} else {
-		BUG_ON(!ci->i_head_snapc);
-		snapc = ceph_get_snap_context(ci->i_head_snapc);
+		snapc = ci->i_head_snapc;
+		BUG_ON(!snapc);
 		++ci->i_wrbuffer_ref_head;
 	}
+
+	/* Attach a reference to the snap/group to the folio. */
+	group = netfs_folio_group(folio);
+	if (group != &snapc->group) {
+		netfs_set_group(folio, &snapc->group);
+		if (group) {
+			doutc(cl, "Different group %px != %px\n",
+			      group, &snapc->group);
+			netfs_put_group(group);
+		}
+	}
+
 	if (ci->i_wrbuffer_ref == 0)
 		ihold(inode);
 	++ci->i_wrbuffer_ref;
@@ -122,16 +137,10 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 	      snapc, snapc->seq, snapc->num_snaps);
 	spin_unlock(&ci->i_ceph_lock);
 
-	/*
-	 * Reference snap context in folio->private.  Also set
-	 * PagePrivate so that we get invalidate_folio callback.
-	 */
-	VM_WARN_ON_FOLIO(folio->private, folio);
-	folio_attach_private(folio, snapc);
-
-	return ceph_fscache_dirty_folio(mapping, folio);
+	return netfs_dirty_folio(mapping, folio);
 }
 
+#if 0 // TODO: Remove after netfs conversion
 /*
  * If we are truncating the full folio (i.e. offset == 0), adjust the
  * dirty folio counters appropriately.  Only called if there is private
@@ -1236,6 +1245,7 @@ bool is_num_ops_too_big(struct ceph_writeback_ctl *ceph_wbc)
 	return ceph_wbc->num_ops >=
 		(ceph_wbc->from_pool ?  CEPH_OSD_SLAB_OPS : CEPH_OSD_MAX_OPS);
 }
+#endif // TODO: Remove after netfs conversion
 
 static inline
 bool is_write_congestion_happened(struct ceph_fs_client *fsc)
@@ -1244,6 +1254,7 @@ bool is_write_congestion_happened(struct ceph_fs_client *fsc)
 		CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb);
 }
 
+#if 0 // TODO: Remove after netfs conversion
 static inline int move_dirty_folio_in_page_array(struct address_space *mapping,
 		struct writeback_control *wbc,
 		struct ceph_writeback_ctl *ceph_wbc, struct folio *folio)
@@ -1930,6 +1941,7 @@ const struct address_space_operations ceph_aops = {
 	.direct_IO = noop_direct_IO,
 	.migrate_folio = filemap_migrate_folio,
 };
+#endif // TODO: Remove after netfs conversion
 
 static void ceph_block_sigs(sigset_t *oldset)
 {
@@ -2034,6 +2046,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 	return ret;
 }
 
+#if 0 // TODO: Remove after netfs conversion
 static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -2137,6 +2150,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 		ret = vmf_error(err);
 	return ret;
 }
+#endif // TODO: Remove after netfs conversion
 
 void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 			   char	*data, size_t len)
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 20efac020394..d6afca292f08 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -43,6 +43,8 @@ static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
 	}
 }
 
+#if 0 // TODO: Remove after netfs conversion
+
 static inline int ceph_fscache_unpin_writeback(struct inode *inode,
 						struct writeback_control *wbc)
 {
@@ -50,6 +52,7 @@ static inline int ceph_fscache_unpin_writeback(struct inode *inode,
 }
 
 #define ceph_fscache_dirty_folio netfs_dirty_folio
+#endif // TODO: Remove after netfs conversion
 
 static inline bool ceph_is_cache_enabled(struct inode *inode)
 {
@@ -100,6 +103,7 @@ static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
 {
 }
 
+#if 0 // TODO: Remove after netfs conversion
 static inline int ceph_fscache_unpin_writeback(struct inode *inode,
 					       struct writeback_control *wbc)
 {
@@ -107,6 +111,7 @@ static inline int ceph_fscache_unpin_writeback(struct inode *inode,
 }
 
 #define ceph_fscache_dirty_folio filemap_dirty_folio
+#endif // TODO: Remove after netfs conversion
 
 static inline bool ceph_is_cache_enabled(struct inode *inode)
 {
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a8d8b56cf9d2..53f23f351003 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2536,7 +2536,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 	int wait = (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync);
 
 	doutc(cl, "%p %llx.%llx wait=%d\n", inode, ceph_vinop(inode), wait);
-	ceph_fscache_unpin_writeback(inode, wbc);
+	netfs_unpin_writeback(inode, wbc);
 	if (wait) {
 		err = ceph_wait_on_async_create(inode);
 		if (err)
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index a28dea74ca6f..8d4e908da7d8 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -636,6 +636,60 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 	return ret;
 }
 
+#if 0
+int ceph_decrypt_block(struct netfs_io_request *rreq, loff_t pos, size_t len,
+		       struct scatterlist *source_sg, unsigned int n_source,
+		       struct scatterlist *dest_sg, unsigned int n_dest)
+{
+	struct ceph_sparse_extent *map = op->extent.sparse_ext;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	size_t xlen;
+	u64 objno, objoff;
+	u32 ext_cnt = op->extent.sparse_ext_cnt;
+	int i, ret = 0;
+
+	/* Nothing to do for empty array */
+	if (ext_cnt == 0) {
+		dout("%s: empty array, ret 0\n", __func__);
+		return 0;
+	}
+
+	ceph_calc_file_object_mapping(&ci->i_layout, pos, map[0].len,
+				      &objno, &objoff, &xlen);
+
+	for (i = 0; i < ext_cnt; ++i) {
+		struct ceph_sparse_extent *ext = &map[i];
+		int pgsoff = ext->off - objoff;
+		int pgidx = pgsoff >> PAGE_SHIFT;
+		int fret;
+
+		if ((ext->off | ext->len) & ~CEPH_FSCRYPT_BLOCK_MASK) {
+			pr_warn("%s: bad encrypted sparse extent idx %d off %llx len %llx\n",
+				__func__, i, ext->off, ext->len);
+			return -EIO;
+		}
+		fret = ceph_fscrypt_decrypt_pages(inode, &page[pgidx],
+						 off + pgsoff, ext->len);
+		dout("%s: [%d] 0x%llx~0x%llx fret %d\n", __func__, i,
+				ext->off, ext->len, fret);
+		if (fret < 0) {
+			if (ret == 0)
+				ret = fret;
+			break;
+		}
+		ret = pgsoff + fret;
+	}
+	dout("%s: ret %d\n", __func__, ret);
+	return ret;
+}
+
+int ceph_encrypt_block(struct netfs_io_request *wreq, loff_t pos, size_t len,
+		       struct scatterlist *source_sg, unsigned int n_source,
+		       struct scatterlist *dest_sg, unsigned int n_dest)
+{
+}
+#endif
+
 /**
  * ceph_fscrypt_encrypt_pages - encrypt an array of pages
  * @inode: pointer to inode associated with these pages
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 4512215cccc6..94b91b5bc843 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -77,6 +77,7 @@ static __le32 ceph_flags_sys2wire(struct ceph_mds_client *mdsc, u32 flags)
  * need to wait for MDS acknowledgement.
  */
 
+#if 0 // TODO: Remove after netfs conversion
 /*
  * How many pages to get in one call to iov_iter_get_pages().  This
  * determines the size of the on-stack array used as a buffer.
@@ -165,6 +166,7 @@ static void ceph_dirty_pages(struct ceph_databuf *dbuf)
 		if (bvec[i].bv_page)
 			set_page_dirty_lock(bvec[i].bv_page);
 }
+#endif // TODO: Remove after netfs conversion
 
 /*
  * Prepare an open request.  Preallocate ceph_cap to avoid an
@@ -1021,6 +1023,7 @@ int ceph_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#if 0 // TODO: Remove after netfs conversion
 enum {
 	HAVE_RETRIED = 1,
 	CHECK_EOF =    2,
@@ -2234,6 +2237,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	return ret;
 }
+#endif // TODO: Remove after netfs conversion
 
 /*
  * Wrap filemap_splice_read with checks for cap bits on the inode.
@@ -2294,6 +2298,7 @@ static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
 	return ret;
 }
 
+#if 0 // TODO: Remove after netfs conversion
 /*
  * Take cap references to avoid releasing caps to MDS mid-write.
  *
@@ -2488,6 +2493,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ceph_free_cap_flush(prealloc_cf);
 	return written ? written : err;
 }
+#endif // TODO: Remove after netfs conversion
 
 /*
  * llseek.  be sure to verify file size on SEEK_END.
@@ -3160,6 +3166,10 @@ static int ceph_fadvise(struct file *file, loff_t offset, loff_t len, int advice
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		return -EACCES;
 
+	ret = netfs_start_io_read(inode);
+	if (ret < 0)
+		return ret;
+
 	ret = ceph_get_caps(file, CEPH_CAP_FILE_RD, want, -1, &got);
 	if (ret < 0) {
 		doutc(cl, "%llx.%llx, error getting cap\n", ceph_vinop(inode));
@@ -3180,6 +3190,7 @@ static int ceph_fadvise(struct file *file, loff_t offset, loff_t len, int advice
 	      inode, ceph_vinop(inode), ceph_cap_string(got), ret);
 	ceph_put_cap_refs(ceph_inode(inode), got);
 out:
+	netfs_end_io_read(inode);
 	return ret;
 }
 
@@ -3187,8 +3198,8 @@ const struct file_operations ceph_file_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
 	.llseek = ceph_llseek,
-	.read_iter = ceph_read_iter,
-	.write_iter = ceph_write_iter,
+	.read_iter = ceph_netfs_read_iter,
+	.write_iter = ceph_netfs_write_iter,
 	.mmap = ceph_mmap,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index ec9b80fec7be..8f73f3a55a3e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2345,11 +2345,9 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	struct iov_iter iter;
 	struct ceph_fscrypt_truncate_size_header *header;
 	void *p;
-	int retry_op = 0;
 	int len = CEPH_FSCRYPT_BLOCK_SIZE;
 	loff_t i_size = i_size_read(inode);
 	int got, ret, issued;
-	u64 objver;
 
 	ret = __ceph_get_caps(inode, NULL, CEPH_CAP_FILE_RD, 0, -1, &got);
 	if (ret < 0)
@@ -2361,16 +2359,6 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	      i_size, attr->ia_size, ceph_cap_string(got),
 	      ceph_cap_string(issued));
 
-	/* Try to writeback the dirty pagecaches */
-	if (issued & (CEPH_CAP_FILE_BUFFER)) {
-		loff_t lend = orig_pos + CEPH_FSCRYPT_BLOCK_SIZE - 1;
-
-		ret = filemap_write_and_wait_range(inode->i_mapping,
-						   orig_pos, lend);
-		if (ret < 0)
-			goto out;
-	}
-
 	ret = -ENOMEM;
 	dbuf = ceph_databuf_req_alloc(2, 0, GFP_KERNEL);
 	if (!dbuf)
@@ -2382,10 +2370,8 @@ static int fill_fscrypt_truncate(struct inode *inode,
 		goto out;
 
 	iov_iter_bvec(&iter, ITER_DEST, &dbuf->bvec[1], 1, len);
-
-	pos = orig_pos;
-	ret = __ceph_sync_read(inode, &pos, &iter, &retry_op, &objver);
-	if (ret < 0)
+	ret = netfs_unbuffered_read_from_inode(inode, orig_pos, &iter, true);
+	if (ret < 0 && ret != -ENODATA)
 		goto out;
 
 	header = kmap_ceph_databuf_page(dbuf, 0);
@@ -2402,16 +2388,14 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	header->block_size = cpu_to_le32(CEPH_FSCRYPT_BLOCK_SIZE);
 
 	/*
-	 * If we hit a hole here, we should just skip filling
-	 * the fscrypt for the request, because once the fscrypt
-	 * is enabled, the file will be split into many blocks
-	 * with the size of CEPH_FSCRYPT_BLOCK_SIZE, if there
-	 * has a hole, the hole size should be multiple of block
-	 * size.
+	 * If we hit a hole here, we should just skip filling the fscrypt for
+	 * the request, because once the fscrypt is enabled, the file will be
+	 * split into many blocks with the size of CEPH_FSCRYPT_BLOCK_SIZE.  If
+	 * there was a hole, the hole size should be multiple of block size.
 	 *
 	 * If the Rados object doesn't exist, it will be set to 0.
 	 */
-	if (!objver) {
+	if (ret != -ENODATA) {
 		doutc(cl, "hit hole, ppos %lld < size %lld\n", pos, i_size);
 
 		header->data_len = cpu_to_le32(8 + 8 + 4);
diff --git a/fs/ceph/rdwr.c b/fs/ceph/rdwr.c
new file mode 100644
index 000000000000..952c36be2cd9
--- /dev/null
+++ b/fs/ceph/rdwr.c
@@ -0,0 +1,1006 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Ceph netfs-based file read-write operations.
+ *
+ * There are a few funny things going on here.
+ *
+ * The page->private field is used to reference a struct ceph_snap_context for
+ * _every_ dirty page.  This indicates which snapshot the page was logically
+ * dirtied in, and thus which snap context needs to be associated with the osd
+ * write during writeback.
+ *
+ * Similarly, struct ceph_inode_info maintains a set of counters to count dirty
+ * pages on the inode.  In the absence of snapshots, i_wrbuffer_ref ==
+ * i_wrbuffer_ref_head == the dirty page count.
+ *
+ * When a snapshot is taken (that is, when the client receives notification
+ * that a snapshot was taken), each inode with caps and with dirty pages (dirty
+ * pages implies there is a cap) gets a new ceph_cap_snap in the i_cap_snaps
+ * list (which is sorted in ascending order, new snaps go to the tail).  The
+ * i_wrbuffer_ref_head count is moved to capsnap->dirty. (Unless a sync write
+ * is currently in progress.  In that case, the capsnap is said to be
+ * "pending", new writes cannot start, and the capsnap isn't "finalized" until
+ * the write completes (or fails) and a final size/mtime for the inode for that
+ * snap can be settled upon.)  i_wrbuffer_ref_head is reset to 0.
+ *
+ * On writeback, we must submit writes to the osd IN SNAP ORDER.  So, we look
+ * for the first capsnap in i_cap_snaps and write out pages in that snap
+ * context _only_.  Then we move on to the next capsnap, eventually reaching
+ * the "live" or "head" context (i.e., pages that are not yet snapped) and are
+ * writing the most recently dirtied pages.
+ *
+ * Invalidate and so forth must take care to ensure the dirty page accounting
+ * is preserved.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#include <linux/ceph/ceph_debug.h>
+
+#include <linux/backing-dev.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+#include <linux/task_io_accounting_ops.h>
+#include <linux/signal.h>
+#include <linux/iversion.h>
+#include <linux/ktime.h>
+#include <linux/netfs.h>
+#include <trace/events/netfs.h>
+
+#include "super.h"
+#include "mds_client.h"
+#include "cache.h"
+#include "metric.h"
+#include "crypto.h"
+#include <linux/ceph/osd_client.h>
+#include <linux/ceph/striper.h>
+
+struct ceph_writeback_ctl
+{
+	loff_t i_size;
+	u64 truncate_size;
+	u32 truncate_seq;
+	bool size_stable;
+	bool head_snapc;
+};
+
+struct kmem_cache *ceph_io_request_cachep;
+struct kmem_cache *ceph_io_subrequest_cachep;
+
+static struct ceph_io_subrequest *ceph_sreq2io(struct netfs_io_subrequest *subreq)
+{
+	BUILD_BUG_ON(sizeof(struct ceph_io_request) > NETFS_DEF_IO_REQUEST_SIZE);
+	BUILD_BUG_ON(sizeof(struct ceph_io_subrequest) > NETFS_DEF_IO_SUBREQUEST_SIZE);
+
+	return container_of(subreq, struct ceph_io_subrequest, sreq);
+}
+
+/*
+ * Get the snapc from the group attached to a request
+ */
+static struct ceph_snap_context *ceph_wreq_snapc(struct netfs_io_request *wreq)
+{
+	struct ceph_snap_context *snapc =
+		container_of(wreq->group, struct ceph_snap_context, group);
+	return snapc;
+}
+
+#if 0
+static void ceph_put_many_snap_context(struct ceph_snap_context *sc, unsigned int nr)
+{
+	if (sc)
+		netfs_put_group_many(&sc->group, nr);
+}
+#endif
+
+/*
+ * Handle the termination of a write to the server.
+ */
+static void ceph_netfs_write_callback(struct ceph_osd_request *req)
+{
+	struct netfs_io_subrequest *subreq = req->r_subreq;
+	struct ceph_io_subrequest *csub = ceph_sreq2io(subreq);
+	struct ceph_io_request *creq = csub->creq;
+	struct inode *inode = creq->rreq.inode;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+	size_t wrote = req->r_result ? 0 : subreq->len;
+	int err = req->r_result;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
+
+	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
+				  req->r_end_latency, wrote, err);
+
+	if (err) {
+		doutc(cl, "sync_write osd write returned %d\n", err);
+		/* Version changed! Must re-do the rmw cycle */
+		if ((creq->rmw_assert_version && (err == -ERANGE || err == -EOVERFLOW)) ||
+		    (!creq->rmw_assert_version && err == -EEXIST)) {
+			/* We should only ever see this on a rmw */
+			WARN_ON_ONCE(!test_bit(NETFS_RREQ_RMW, &ci->netfs.flags));
+
+			/* The version should never go backward */
+			WARN_ON_ONCE(err == -EOVERFLOW);
+
+			/* FIXME: limit number of times we loop? */
+			set_bit(NETFS_RREQ_REPEAT_RMW, &creq->rreq.flags);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_need_rmw);
+		}
+		ceph_set_error_write(ci);
+	} else {
+		ceph_clear_error_write(ci);
+	}
+
+	csub->req = NULL;
+	ceph_osdc_put_request(req);
+	netfs_write_subrequest_terminated(subreq, err ?: wrote, true);
+}
+
+/*
+ * Issue a subrequest to upload to the server.
+ */
+static void ceph_issue_write(struct netfs_io_subrequest *subreq)
+{
+	struct ceph_io_subrequest *csub = ceph_sreq2io(subreq);
+	struct ceph_snap_context *snapc = ceph_wreq_snapc(subreq->rreq);
+	struct ceph_osd_request *req;
+	struct ceph_io_request *creq = csub->creq;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(subreq->rreq->inode);
+	struct ceph_osd_client *osdc = &fsc->client->osdc;
+	struct inode *inode = subreq->rreq->inode;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+	unsigned long long len;
+	unsigned int rmw = test_bit(NETFS_RREQ_RMW, &ci->netfs.flags) ? 1 : 0;
+
+	doutc(cl, "issue_write R=%08x[%x] ino %llx %lld~%zu -- %srmw\n",
+	      subreq->rreq->debug_id, subreq->debug_index, ci->i_vino.ino,
+	      subreq->start, subreq->len,
+	      rmw ? "" : "no ");
+
+	len = subreq->len;
+	req = ceph_osdc_new_request(osdc, &ci->i_layout, ci->i_vino,
+				    subreq->start, &len,
+				    rmw,	/* which: 0 or 1 */
+				    rmw + 1,	/* num_ops: 1 or 2 */
+				    CEPH_OSD_OP_WRITE,
+				    CEPH_OSD_FLAG_WRITE,
+				    snapc,
+				    ci->i_truncate_seq,
+				    ci->i_truncate_size, false);
+	if (IS_ERR(req)) {
+		netfs_write_subrequest_terminated(subreq, PTR_ERR(req), false);
+		return netfs_prepare_write_failed(subreq);
+	}
+
+	subreq->len = len;
+	doutc(cl, "write op %lld~%zu\n", subreq->start, subreq->len);
+	iov_iter_truncate(&subreq->io_iter, len);
+	osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
+	req->r_inode	= inode;
+	req->r_mtime	= current_time(inode);
+	req->r_callback	= ceph_netfs_write_callback;
+	req->r_subreq	= subreq;
+	csub->req	= req;
+
+	/*
+	 * If we're doing an RMW cycle, set up an assertion that the remote
+	 * data hasn't changed.  If we don't have a version number, then the
+	 * object doesn't exist yet.  Use an exclusive create instead of a
+	 * version assertion in that case.
+	 */
+	if (rmw) {
+		if (creq->rmw_assert_version) {
+			osd_req_op_init(req, 0, CEPH_OSD_OP_ASSERT_VER, 0);
+			req->r_ops[0].assert_ver.ver = creq->rmw_assert_version;
+		} else {
+			osd_req_op_init(req, 0, CEPH_OSD_OP_CREATE,
+					CEPH_OSD_OP_FLAG_EXCL);
+		}
+	}
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	ceph_osdc_start_request(osdc, req);
+}
+
+/*
+ * Prepare a subrequest to upload to the server.
+ */
+static void ceph_prepare_write(struct netfs_io_subrequest *subreq)
+{
+	struct ceph_inode_info *ci = ceph_inode(subreq->rreq->inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(subreq->rreq->inode);
+	u64 objnum, objoff;
+
+	/* Clamp the length to the next object boundary. */
+	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start,
+				      fsc->mount_options->wsize,
+				      &objnum, &objoff,
+				      &subreq->rreq->io_streams[0].sreq_max_len);
+}
+
+/*
+ * Mark the caps as dirty
+ */
+static void ceph_netfs_post_modify(struct inode *inode, void *fs_priv)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_cap_flush **prealloc_cf = fs_priv;
+	int dirty;
+
+	spin_lock(&ci->i_ceph_lock);
+	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR, prealloc_cf);
+	spin_unlock(&ci->i_ceph_lock);
+	if (dirty)
+		__mark_inode_dirty(inode, dirty);
+}
+
+static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
+{
+	struct inode *inode = rreq->inode;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_file_layout *lo = &ci->i_layout;
+	unsigned long max_pages = inode->i_sb->s_bdi->ra_pages;
+	loff_t end = rreq->start + rreq->len, new_end;
+	struct ceph_io_request *priv = container_of(rreq, struct ceph_io_request, rreq);
+	unsigned long max_len;
+	u32 blockoff;
+
+	if (priv) {
+		/* Readahead is disabled by posix_fadvise POSIX_FADV_RANDOM */
+		if (priv->file_ra_disabled)
+			max_pages = 0;
+		else
+			max_pages = priv->file_ra_pages;
+
+	}
+
+	/* Readahead is disabled */
+	if (!max_pages)
+		return;
+
+	max_len = max_pages << PAGE_SHIFT;
+
+	/*
+	 * Try to expand the length forward by rounding up it to the next
+	 * block, but do not exceed the file size, unless the original
+	 * request already exceeds it.
+	 */
+	new_end = umin(round_up(end, lo->stripe_unit), rreq->i_size);
+	if (new_end > end && new_end <= rreq->start + max_len)
+		rreq->len = new_end - rreq->start;
+
+	/* Try to expand the start downward */
+	div_u64_rem(rreq->start, lo->stripe_unit, &blockoff);
+	if (rreq->len + blockoff <= max_len) {
+		rreq->start -= blockoff;
+		rreq->len += blockoff;
+	}
+}
+
+static int ceph_netfs_prepare_read(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct ceph_inode_info *ci = ceph_inode(rreq->inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(rreq->inode);
+	size_t xlen;
+	u64 objno, objoff;
+
+	/* Truncate the extent at the end of the current block */
+	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
+				      &objno, &objoff, &xlen);
+	rreq->io_streams[0].sreq_max_len = umin(xlen, fsc->mount_options->rsize);
+	return 0;
+}
+
+static void ceph_netfs_read_callback(struct ceph_osd_request *req)
+{
+	struct inode *inode = req->r_inode;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
+	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
+	struct netfs_io_subrequest *subreq = req->r_priv;
+	struct ceph_osd_req_op *op = &req->r_ops[0];
+	bool sparse = (op->op == CEPH_OSD_OP_SPARSE_READ);
+	int err = req->r_result;
+
+	ceph_update_read_metrics(&fsc->mdsc->metric, req->r_start_latency,
+				 req->r_end_latency, osd_data->iter.count, err);
+
+	doutc(cl, "result %d subreq->len=%zu i_size=%lld\n", req->r_result,
+	      subreq->len, i_size_read(req->r_inode));
+
+	/* no object means success but no data */
+	if (err == -ENOENT)
+		err = 0;
+	else if (err == -EBLOCKLISTED)
+		fsc->blocklisted = true;
+
+	if (err >= 0) {
+		if (sparse && err > 0)
+			err = ceph_sparse_ext_map_end(op);
+		if (err < subreq->len &&
+		    subreq->rreq->origin != NETFS_DIO_READ)
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		if (IS_ENCRYPTED(inode) && err > 0) {
+#if 0
+			err = ceph_fscrypt_decrypt_extents(inode, osd_data->dbuf,
+							   subreq->start,
+							   op->extent.sparse_ext,
+							   op->extent.sparse_ext_cnt);
+			if (err > subreq->len)
+				err = subreq->len;
+#else
+			pr_err("TODO: Content-decrypt currently disabled\n");
+			err = -EOPNOTSUPP;
+#endif
+		}
+	}
+
+	if (err > 0) {
+		subreq->transferred = err;
+		err = 0;
+	}
+
+	subreq->error = err;
+	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
+	ceph_dec_osd_stopping_blocker(fsc->mdsc);
+	netfs_read_subreq_terminated(subreq);
+}
+
+static void ceph_rmw_read_done(struct netfs_io_request *wreq, struct netfs_io_request *rreq)
+{
+	struct ceph_io_request *cwreq = container_of(wreq, struct ceph_io_request, rreq);
+	struct ceph_io_request *crreq = container_of(rreq, struct ceph_io_request, rreq);
+
+	cwreq->rmw_assert_version = crreq->rmw_assert_version;
+}
+
+static bool ceph_netfs_issue_read_inline(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct inode *inode = rreq->inode;
+	struct ceph_mds_reply_info_parsed *rinfo;
+	struct ceph_mds_reply_info_in *iinfo;
+	struct ceph_mds_request *req;
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	ssize_t err = 0;
+	size_t len, copied;
+	int mode;
+
+	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
+
+	if (subreq->start >= inode->i_size)
+		goto out;
+
+	/* We need to fetch the inline data. */
+	mode = ceph_try_to_choose_auth_mds(inode, CEPH_STAT_CAP_INLINE_DATA);
+	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, mode);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		goto out;
+	}
+	req->r_ino1 = ci->i_vino;
+	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INLINE_DATA);
+	req->r_num_caps = 2;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	if (err < 0)
+		goto out;
+
+	rinfo = &req->r_reply_info;
+	iinfo = &rinfo->targeti;
+	if (iinfo->inline_version == CEPH_INLINE_NONE) {
+		/* The data got uninlined */
+		ceph_mdsc_put_request(req);
+		return false;
+	}
+
+	len = umin(iinfo->inline_len - subreq->start, subreq->len);
+	copied = copy_to_iter(iinfo->inline_data + subreq->start, len, &subreq->io_iter);
+	if (copied) {
+		subreq->transferred += copied;
+		if (copied == len)
+			__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
+		subreq->error = 0;
+	} else {
+		subreq->error = -EFAULT;
+	}
+
+	ceph_mdsc_put_request(req);
+out:
+	netfs_read_subreq_terminated(subreq);
+	return true;
+}
+
+static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct inode *inode = rreq->inode;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
+	struct ceph_osd_request *req = NULL;
+	struct ceph_vino vino = ceph_vino(inode);
+	int extent_cnt;
+	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
+	u64 off = subreq->start, len = subreq->len;
+	int err = 0;
+
+	if (ceph_inode_is_shutdown(inode)) {
+		err = -EIO;
+		goto out;
+	}
+
+	if (ceph_has_inline_data(ci) && ceph_netfs_issue_read_inline(subreq))
+		return;
+
+	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino,
+				    off, &len, 0, 1,
+				    sparse ? CEPH_OSD_OP_SPARSE_READ : CEPH_OSD_OP_READ,
+				    CEPH_OSD_FLAG_READ, /*  read_from_replica will be or'd in */
+				    NULL, ci->i_truncate_seq, ci->i_truncate_size, false);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		req = NULL;
+		goto out;
+	}
+
+	if (sparse) {
+		extent_cnt = __ceph_sparse_read_ext_count(inode, len);
+		err = ceph_alloc_sparse_ext_map(&req->r_ops[0], extent_cnt);
+		if (err)
+			goto out;
+	}
+
+	doutc(cl, "%llx.%llx pos=%llu orig_len=%zu len=%llu\n",
+	      ceph_vinop(inode), subreq->start, subreq->len, len);
+
+	osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
+	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
+		err = -EIO;
+		goto out;
+	}
+	req->r_callback = ceph_netfs_read_callback;
+	req->r_priv = subreq;
+	req->r_inode = inode;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	ceph_osdc_start_request(req->r_osdc, req);
+out:
+	ceph_osdc_put_request(req);
+	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
+	if (err) {
+		subreq->error = err;
+		netfs_read_subreq_terminated(subreq);
+	}
+}
+
+static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
+{
+	struct ceph_io_request *priv = container_of(rreq, struct ceph_io_request, rreq);
+	struct inode *inode = rreq->inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	int got = 0, want = CEPH_CAP_FILE_CACHE;
+	int ret = 0;
+
+	rreq->rsize = 1024 * 1024;
+	rreq->wsize = umin(i_blocksize(inode), fsc->mount_options->wsize);
+
+	switch (rreq->origin) {
+	case NETFS_READAHEAD:
+		goto init_readahead;
+	case NETFS_WRITEBACK:
+	case NETFS_WRITETHROUGH:
+	case NETFS_UNBUFFERED_WRITE:
+	case NETFS_DIO_WRITE:
+		if (S_ISREG(rreq->inode->i_mode))
+			rreq->io_streams[0].avail = true;
+		return 0;
+	default:
+		return 0;
+	}
+
+init_readahead:
+	/*
+	 * If we are doing readahead triggered by a read, fault-in or
+	 * MADV/FADV_WILLNEED, someone higher up the stack must be holding the
+	 * FILE_CACHE and/or LAZYIO caps.
+	 */
+	if (file) {
+		priv->file_ra_pages = file->f_ra.ra_pages;
+		priv->file_ra_disabled = file->f_mode & FMODE_RANDOM;
+		rreq->netfs_priv = priv;
+		return 0;
+	}
+
+	/*
+	 * readahead callers do not necessarily hold Fcb caps
+	 * (e.g. fadvise, madvise).
+	 */
+	ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
+	if (ret < 0) {
+		doutc(cl, "%llx.%llx, error getting cap\n", ceph_vinop(inode));
+		goto out;
+	}
+
+	if (!(got & want)) {
+		doutc(cl, "%llx.%llx, no cache cap\n", ceph_vinop(inode));
+		ret = -EACCES;
+		goto out;
+	}
+	if (ret > 0)
+		priv->caps = got;
+	else
+		ret = -EACCES;
+
+	rreq->io_streams[0].sreq_max_len = fsc->mount_options->rsize;
+out:
+	return ret;
+}
+
+static void ceph_netfs_free_request(struct netfs_io_request *rreq)
+{
+	struct ceph_io_request *creq = container_of(rreq, struct ceph_io_request, rreq);
+
+	if (creq->caps)
+		ceph_put_cap_refs(ceph_inode(rreq->inode), creq->caps);
+}
+
+const struct netfs_request_ops ceph_netfs_ops = {
+	.init_request		= ceph_init_request,
+	.free_request		= ceph_netfs_free_request,
+	.expand_readahead	= ceph_netfs_expand_readahead,
+	.prepare_read		= ceph_netfs_prepare_read,
+	.issue_read		= ceph_netfs_issue_read,
+	.rmw_read_done		= ceph_rmw_read_done,
+	.post_modify		= ceph_netfs_post_modify,
+	.prepare_write		= ceph_prepare_write,
+	.issue_write		= ceph_issue_write,
+};
+
+/*
+ * Get ref for the oldest snapc for an inode with dirty data... that is, the
+ * only snap context we are allowed to write back.
+ */
+static struct ceph_snap_context *
+ceph_get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
+			struct ceph_snap_context *folio_snapc)
+{
+	struct ceph_snap_context *snapc = NULL;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_cap_snap *capsnap = NULL;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+
+	spin_lock(&ci->i_ceph_lock);
+	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
+		doutc(cl, " capsnap %p snapc %p has %d dirty pages\n",
+		      capsnap, capsnap->context, capsnap->dirty_pages);
+		if (!capsnap->dirty_pages)
+			continue;
+
+		/* get i_size, truncate_{seq,size} for folio_snapc? */
+		if (snapc && capsnap->context != folio_snapc)
+			continue;
+
+		if (ctl) {
+			if (capsnap->writing) {
+				ctl->i_size = i_size_read(inode);
+				ctl->size_stable = false;
+			} else {
+				ctl->i_size = capsnap->size;
+				ctl->size_stable = true;
+			}
+			ctl->truncate_size = capsnap->truncate_size;
+			ctl->truncate_seq = capsnap->truncate_seq;
+			ctl->head_snapc = false;
+		}
+
+		if (snapc)
+			break;
+
+		snapc = ceph_get_snap_context(capsnap->context);
+		if (!folio_snapc ||
+		    folio_snapc == snapc ||
+		    folio_snapc->seq > snapc->seq)
+			break;
+	}
+	if (!snapc && ci->i_wrbuffer_ref_head) {
+		snapc = ceph_get_snap_context(ci->i_head_snapc);
+		doutc(cl, " head snapc %p has %d dirty pages\n", snapc,
+		      ci->i_wrbuffer_ref_head);
+		if (ctl) {
+			ctl->i_size = i_size_read(inode);
+			ctl->truncate_size = ci->i_truncate_size;
+			ctl->truncate_seq = ci->i_truncate_seq;
+			ctl->size_stable = false;
+			ctl->head_snapc = true;
+		}
+	}
+	spin_unlock(&ci->i_ceph_lock);
+	return snapc;
+}
+
+/*
+ * Flush dirty data.  We have to start with the oldest snap as that's the only
+ * one we're allowed to write back.
+ */
+static int ceph_writepages(struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	struct ceph_writeback_ctl ceph_wbc;
+	struct ceph_snap_context *snapc;
+	struct ceph_inode_info *ci = ceph_inode(mapping->host);
+	loff_t actual_start = wbc->range_start, actual_end = wbc->range_end;
+	int ret;
+
+	do {
+		snapc = ceph_get_oldest_context(mapping->host, &ceph_wbc, NULL);
+		if (snapc == ci->i_head_snapc) {
+			wbc->range_start = actual_start;
+			wbc->range_end = actual_end;
+		} else {
+			/* Do not respect wbc->range_{start,end}.  Dirty pages
+			 * in that range can be associated with newer snapc.
+			 * They are not writeable until we write all dirty
+			 * pages associated with an older snapc get written.
+			 */
+			wbc->range_start = 0;
+			wbc->range_end = LLONG_MAX;
+		}
+
+		ret = netfs_writepages_group(mapping, wbc, &snapc->group, &ceph_wbc);
+		ceph_put_snap_context(snapc);
+		if (snapc == ci->i_head_snapc)
+			break;
+	} while (ret == 0 && wbc->nr_to_write > 0);
+
+	return ret;
+}
+
+const struct address_space_operations ceph_aops = {
+	.read_folio	= netfs_read_folio,
+	.readahead	= netfs_readahead,
+	.writepages	= ceph_writepages,
+	.dirty_folio	= ceph_dirty_folio,
+	.invalidate_folio = netfs_invalidate_folio,
+	.release_folio	= netfs_release_folio,
+	.direct_IO	= noop_direct_IO,
+	.migrate_folio	= filemap_migrate_folio,
+};
+
+/*
+ * Wrap generic_file_aio_read with checks for cap bits on the inode.
+ * Atomically grab references, so that those bits are not released
+ * back to the MDS mid-read.
+ *
+ * Hmm, the sync read case isn't actually async... should it be?
+ */
+ssize_t ceph_netfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *filp = iocb->ki_filp;
+	struct inode *inode = file_inode(filp);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_file_info *fi = filp->private_data;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+	ssize_t ret;
+	size_t len = iov_iter_count(to);
+	bool dio = iocb->ki_flags & IOCB_DIRECT;
+	int want = 0, got = 0;
+
+	doutc(cl, "%llu~%zu trying to get caps on %p %llx.%llx\n",
+	      iocb->ki_pos, len, inode, ceph_vinop(inode));
+
+	if (ceph_inode_is_shutdown(inode))
+		return -ESTALE;
+
+	if (dio)
+		ret = netfs_start_io_direct(inode);
+	else
+		ret = netfs_start_io_read(inode);
+	if (ret < 0)
+		return ret;
+
+	if (!(fi->flags & CEPH_F_SYNC) && !dio)
+		want |= CEPH_CAP_FILE_CACHE;
+	if (fi->fmode & CEPH_FILE_MODE_LAZY)
+		want |= CEPH_CAP_FILE_LAZYIO;
+
+	ret = ceph_get_caps(filp, CEPH_CAP_FILE_RD, want, -1, &got);
+	if (ret < 0)
+		goto out;
+
+	if ((got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) == 0 ||
+	    dio ||
+	    (fi->flags & CEPH_F_SYNC)) {
+		doutc(cl, "sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
+		      inode, ceph_vinop(inode), iocb->ki_pos, len,
+		      ceph_cap_string(got));
+
+		ret = netfs_unbuffered_read_iter(iocb, to);
+	} else {
+		doutc(cl, "async %p %llx.%llx %llu~%zu got cap refs on %s\n",
+		      inode, ceph_vinop(inode), iocb->ki_pos, len,
+		      ceph_cap_string(got));
+		ret = filemap_read(iocb, to, 0);
+	}
+
+	doutc(cl, "%p %llx.%llx dropping cap refs on %s = %zd\n",
+	      inode, ceph_vinop(inode), ceph_cap_string(got), ret);
+	ceph_put_cap_refs(ci, got);
+
+out:
+	if (dio)
+		netfs_end_io_direct(inode);
+	else
+		netfs_end_io_read(inode);
+	return ret;
+}
+
+/*
+ * Get the most recent snap context in the list to which the inode subscribes.
+ * This is the only one we are allowed to modify.  If a folio points to an
+ * earlier snapshot, it must be flushed first.
+ */
+static struct ceph_snap_context *ceph_get_most_recent_snapc(struct inode *inode)
+{
+	struct ceph_snap_context *snapc;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	/* Get the snap this write is going to belong to. */
+	spin_lock(&ci->i_ceph_lock);
+	if (__ceph_have_pending_cap_snap(ci)) {
+		struct ceph_cap_snap *capsnap =
+			list_last_entry(&ci->i_cap_snaps,
+					struct ceph_cap_snap, ci_item);
+
+		snapc = ceph_get_snap_context(capsnap->context);
+	} else {
+		BUG_ON(!ci->i_head_snapc);
+		snapc = ceph_get_snap_context(ci->i_head_snapc);
+	}
+	spin_unlock(&ci->i_ceph_lock);
+
+	return snapc;
+}
+
+/*
+ * Take cap references to avoid releasing caps to MDS mid-write.
+ *
+ * If we are synchronous, and write with an old snap context, the OSD
+ * may return EOLDSNAPC.  In that case, retry the write.. _after_
+ * dropping our cap refs and allowing the pending snap to logically
+ * complete _before_ this write occurs.
+ *
+ * If we are near ENOSPC, write synchronously.
+ */
+ssize_t ceph_netfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct ceph_snap_context *snapc;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_file_info *fi = file->private_data;
+	struct ceph_osd_client *osdc = &fsc->client->osdc;
+	struct ceph_cap_flush *prealloc_cf;
+	struct ceph_client *cl = fsc->client;
+	ssize_t count, written = 0;
+	loff_t limit = max(i_size_read(inode), fsc->max_file_size);
+	loff_t pos;
+	bool direct_lock = false;
+	u64 pool_flags;
+	u32 map_flags;
+	int err, want = 0, got;
+
+	if (ceph_inode_is_shutdown(inode))
+		return -ESTALE;
+
+	if (ceph_snap(inode) != CEPH_NOSNAP)
+		return -EROFS;
+
+	prealloc_cf = ceph_alloc_cap_flush();
+	if (!prealloc_cf)
+		return -ENOMEM;
+
+	if ((iocb->ki_flags & (IOCB_DIRECT | IOCB_APPEND)) == IOCB_DIRECT)
+		direct_lock = true;
+
+retry_snap:
+	if (direct_lock)
+		netfs_start_io_direct(inode);
+	else
+		netfs_start_io_write(inode);
+
+	if (iocb->ki_flags & IOCB_APPEND) {
+		err = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
+		if (err < 0)
+			goto out;
+	}
+
+	err = generic_write_checks(iocb, from);
+	if (err <= 0)
+		goto out;
+
+	pos = iocb->ki_pos;
+	if (unlikely(pos >= limit)) {
+		err = -EFBIG;
+		goto out;
+	} else {
+		iov_iter_truncate(from, limit - pos);
+	}
+
+	count = iov_iter_count(from);
+	if (ceph_quota_is_max_bytes_exceeded(inode, pos + count)) {
+		err = -EDQUOT;
+		goto out;
+	}
+
+	down_read(&osdc->lock);
+	map_flags = osdc->osdmap->flags;
+	pool_flags = ceph_pg_pool_flags(osdc->osdmap, ci->i_layout.pool_id);
+	up_read(&osdc->lock);
+	if ((map_flags & CEPH_OSDMAP_FULL) ||
+	    (pool_flags & CEPH_POOL_FLAG_FULL)) {
+		err = -ENOSPC;
+		goto out;
+	}
+
+	err = file_remove_privs(file);
+	if (err)
+		goto out;
+
+	doutc(cl, "%p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
+	      inode, ceph_vinop(inode), pos, count,
+	      i_size_read(inode));
+	if (!(fi->flags & CEPH_F_SYNC) && !direct_lock)
+		want |= CEPH_CAP_FILE_BUFFER;
+	if (fi->fmode & CEPH_FILE_MODE_LAZY)
+		want |= CEPH_CAP_FILE_LAZYIO;
+	got = 0;
+	err = ceph_get_caps(file, CEPH_CAP_FILE_WR, want, pos + count, &got);
+	if (err < 0)
+		goto out;
+
+	err = file_update_time(file);
+	if (err)
+		goto out_caps;
+
+	inode_inc_iversion_raw(inode);
+
+	doutc(cl, "%p %llx.%llx %llu~%zd got cap refs on %s\n",
+	      inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
+
+	/* Get the snap this write is going to belong to. */
+	snapc = ceph_get_most_recent_snapc(inode);
+
+	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
+	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) ||
+	    (ci->i_ceph_flags & CEPH_I_ERROR_WRITE)) {
+		struct iov_iter data;
+
+		/* we might need to revert back to that point */
+		data = *from;
+		written = netfs_unbuffered_write_iter_locked(iocb, &data, &snapc->group);
+		if (direct_lock)
+			netfs_end_io_direct(inode);
+		else
+			netfs_end_io_write(inode);
+		if (written > 0)
+			iov_iter_advance(from, written);
+		ceph_put_snap_context(snapc);
+	} else {
+		/*
+		 * No need to acquire the i_truncate_mutex.  Because the MDS
+		 * revokes Fwb caps before sending truncate message to us.  We
+		 * can't get Fwb cap while there are pending vmtruncate.  So
+		 * write and vmtruncate can not run at the same time
+		 */
+		written = netfs_perform_write(iocb, from, &snapc->group, &prealloc_cf);
+		netfs_end_io_write(inode);
+	}
+
+	if (written >= 0) {
+		int dirty;
+
+		spin_lock(&ci->i_ceph_lock);
+		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
+					       &prealloc_cf);
+		spin_unlock(&ci->i_ceph_lock);
+		if (dirty)
+			__mark_inode_dirty(inode, dirty);
+		if (ceph_quota_is_max_bytes_approaching(inode, iocb->ki_pos))
+			ceph_check_caps(ci, CHECK_CAPS_FLUSH);
+	}
+
+	doutc(cl, "%p %llx.%llx %llu~%u  dropping cap refs on %s\n",
+	      inode, ceph_vinop(inode), pos, (unsigned)count,
+	      ceph_cap_string(got));
+	ceph_put_cap_refs(ci, got);
+
+	if (written == -EOLDSNAPC) {
+		doutc(cl, "%p %llx.%llx %llu~%u" "got EOLDSNAPC, retrying\n",
+		      inode, ceph_vinop(inode), pos, (unsigned)count);
+		goto retry_snap;
+	}
+
+	if (written >= 0) {
+		if ((map_flags & CEPH_OSDMAP_NEARFULL) ||
+		    (pool_flags & CEPH_POOL_FLAG_NEARFULL))
+			iocb->ki_flags |= IOCB_DSYNC;
+		written = generic_write_sync(iocb, written);
+	}
+
+	goto out_unlocked;
+out_caps:
+	ceph_put_cap_refs(ci, got);
+out:
+	if (direct_lock)
+		netfs_end_io_direct(inode);
+	else
+		netfs_end_io_write(inode);
+out_unlocked:
+	ceph_free_cap_flush(prealloc_cf);
+	return written ? written : err;
+}
+
+vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
+{
+	struct ceph_snap_context *snapc;
+	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode = file_inode(vma->vm_file);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_file_info *fi = vma->vm_file->private_data;
+	struct ceph_cap_flush *prealloc_cf;
+	struct folio *folio = page_folio(vmf->page);
+	loff_t size = i_size_read(inode);
+	loff_t off = folio_pos(folio);
+	size_t len = folio_size(folio);
+	int want, got, err;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+
+	if (ceph_inode_is_shutdown(inode))
+		return ret;
+
+	prealloc_cf = ceph_alloc_cap_flush();
+	if (!prealloc_cf)
+		return -ENOMEM;
+
+	doutc(cl, "%llx.%llx %llu~%zd getting caps i_size %llu\n",
+	      ceph_vinop(inode), off, len, size);
+	if (fi->fmode & CEPH_FILE_MODE_LAZY)
+		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
+	else
+		want = CEPH_CAP_FILE_BUFFER;
+
+	got = 0;
+	err = ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, off + len, &got);
+	if (err < 0)
+		goto out_free;
+
+	doutc(cl, "%llx.%llx %llu~%zd got cap refs on %s\n", ceph_vinop(inode),
+	      off, len, ceph_cap_string(got));
+
+	/* Get the snap this write is going to belong to. */
+	snapc = ceph_get_most_recent_snapc(inode);
+
+	ret = netfs_page_mkwrite(vmf, &snapc->group, &prealloc_cf);
+
+	doutc(cl, "%llx.%llx %llu~%zd dropping cap refs on %s ret %x\n",
+	      ceph_vinop(inode), off, len, ceph_cap_string(got), ret);
+	ceph_put_cap_refs_async(ci, got);
+out_free:
+	ceph_free_cap_flush(prealloc_cf);
+	if (err < 0)
+		ret = vmf_error(err);
+	return ret;
+}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 14784ad86670..acd5c4821ded 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -470,7 +470,7 @@ struct ceph_inode_info {
 #endif
 };
 
-struct ceph_netfs_request_data {
+struct ceph_netfs_request_data { // TODO: Remove
 	int caps;
 
 	/*
@@ -483,6 +483,29 @@ struct ceph_netfs_request_data {
 	bool file_ra_disabled;
 };
 
+struct ceph_io_request {
+	struct netfs_io_request rreq;
+	u64 rmw_assert_version;
+	int caps;
+
+	/*
+	 * Maximum size of a file readahead request.
+	 * The fadvise could update the bdi's default ra_pages.
+	 */
+	unsigned int file_ra_pages;
+
+	/* Set it if fadvise disables file readahead entirely */
+	bool file_ra_disabled;
+};
+
+struct ceph_io_subrequest {
+	union {
+		struct netfs_io_subrequest sreq;
+		struct ceph_io_request *creq;
+	};
+	struct ceph_osd_request *req;
+};
+
 static inline struct ceph_inode_info *
 ceph_inode(const struct inode *inode)
 {
@@ -1237,8 +1260,10 @@ extern void __ceph_touch_fmode(struct ceph_inode_info *ci,
 			       struct ceph_mds_client *mdsc, int fmode);
 
 /* addr.c */
-extern const struct address_space_operations ceph_aops;
+#if 0 // TODO: Remove after netfs conversion
 extern const struct netfs_request_ops ceph_netfs_ops;
+#endif // TODO: Remove after netfs conversion
+bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio);
 extern int ceph_mmap(struct file *file, struct vm_area_struct *vma);
 extern int ceph_uninline_data(struct file *file);
 extern int ceph_pool_perm_check(struct inode *inode, int need);
@@ -1253,6 +1278,14 @@ static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
 	return true;
 }
 
+/* rdwr.c */
+extern const struct netfs_request_ops ceph_netfs_ops;
+extern const struct address_space_operations ceph_aops;
+
+ssize_t ceph_netfs_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t ceph_netfs_write_iter(struct kiocb *iocb, struct iov_iter *from);
+vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf);
+
 /* file.c */
 extern const struct file_operations ceph_file_fops;
 
@@ -1260,9 +1293,11 @@ extern int ceph_renew_caps(struct inode *inode, int fmode);
 extern int ceph_open(struct inode *inode, struct file *file);
 extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			    struct file *file, unsigned flags, umode_t mode);
+#if 0 // TODO: Remove after netfs conversion
 extern ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 				struct iov_iter *to, int *retry_op,
 				u64 *last_objver);
+#endif
 extern int ceph_release(struct inode *inode, struct file *filp);
 extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 				  char *data, size_t len);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 9724d5a1ddc7..a82eb3be9737 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -264,9 +264,9 @@ static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
 }
 
 /*
- * Check to see if a buffer aligns with the crypto block size.  If it doesn't
- * the crypto layer is going to copy all the data - in which case relying on
- * the crypto op for a free copy is pointless.
+ * Check to see if a buffer aligns with the crypto unit block size.  If it
+ * doesn't the crypto layer is going to copy all the data - in which case
+ * relying on the crypto op for a free copy is pointless.
  */
 static inline bool netfs_is_crypto_aligned(struct netfs_io_request *rreq,
 					   struct iov_iter *iter)
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 0900dea53e4a..d431ba261920 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -139,7 +139,7 @@ static int __init netfs_init(void)
 		goto error_folio_pool;
 
 	netfs_request_slab = kmem_cache_create("netfs_request",
-					       sizeof(struct netfs_io_request), 0,
+					       NETFS_DEF_IO_REQUEST_SIZE, 0,
 					       SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
 					       NULL);
 	if (!netfs_request_slab)
@@ -149,7 +149,7 @@ static int __init netfs_init(void)
 		goto error_reqpool;
 
 	netfs_subrequest_slab = kmem_cache_create("netfs_subrequest",
-						  sizeof(struct netfs_io_subrequest) + 16, 0,
+						  NETFS_DEF_IO_SUBREQUEST_SIZE, 0,
 						  SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
 						  NULL);
 	if (!netfs_subrequest_slab)
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 9b8d99477405..091328596533 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -652,7 +652,8 @@ int netfs_writepages_group(struct address_space *mapping,
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-			wreq->netfs_ops->begin_writeback(wreq);
+			if (wreq->netfs_ops->begin_writeback)
+				wreq->netfs_ops->begin_writeback(wreq);
 		}
 
 		error = netfs_write_folio(wreq, wbc, folio);
@@ -967,7 +968,8 @@ int netfs_writeback_single(struct address_space *mapping,
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
-	if (__test_and_set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
+	if (__test_and_set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags) &&
+	    wreq->netfs_ops->begin_writeback)
 		wreq->netfs_ops->begin_writeback(wreq);
 
 	for (fq = (struct folio_queue *)iter->folioq; fq; fq = fq->next) {
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 733e7f93db66..0c626a7d32f4 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -16,6 +16,7 @@
 #include <linux/writeback.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/netfs.h>
 
 #include <linux/ceph/types.h>
 #include <linux/ceph/messenger.h>
@@ -161,7 +162,7 @@ static inline bool ceph_msgr2(struct ceph_client *client)
  * dirtied.
  */
 struct ceph_snap_context {
-	refcount_t nref;
+	struct netfs_group group;
 	u64 seq;
 	u32 num_snaps;
 	u64 snaps[];
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 7eff589711cc..7f8d28b2c41b 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -246,6 +246,7 @@ struct ceph_osd_request {
 	struct completion r_completion;       /* private to osd_client.c */
 	ceph_osdc_callback_t r_callback;
 
+	struct netfs_io_subrequest *r_subreq;
 	struct inode *r_inode;         	      /* for use by callbacks */
 	struct list_head r_private_item;      /* ditto */
 	void *r_priv;			      /* ditto */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 4049c985b9b4..3253352fcbfa 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -26,6 +26,14 @@ enum netfs_sreq_ref_trace;
 typedef struct mempool_s mempool_t;
 struct folio_queue;
 
+/*
+ * Size of allocations for default netfs_io_(sub)request object slabs and
+ * mempools.  If a filesystem's request and subrequest objects fit within this
+ * size, they can use these otherwise they must provide their own.
+ */
+#define NETFS_DEF_IO_REQUEST_SIZE (sizeof(struct netfs_io_request) + 24)
+#define NETFS_DEF_IO_SUBREQUEST_SIZE (sizeof(struct netfs_io_subrequest) + 16)
+
 /**
  * folio_start_private_2 - Start an fscache write on a folio.  [DEPRECATED]
  * @folio: The folio.
@@ -184,7 +192,10 @@ struct netfs_io_subrequest {
 	struct list_head	rreq_link;	/* Link in req/stream::subrequests */
 	struct list_head	ioq_link;	/* Link in io_stream::io_queue */
 	union {
-		struct iov_iter	io_iter;	/* Iterator for this subrequest */
+		struct {
+			struct iov_iter	io_iter;	/* Iterator for this subrequest */
+			void	*fs_private;	/* Filesystem specific */
+		};
 		struct {
 			struct scatterlist src_sg; /* Source for crypto subreq */
 			struct scatterlist dst_sg; /* Dest for crypto subreq */
diff --git a/net/ceph/snapshot.c b/net/ceph/snapshot.c
index e24315937c45..92f63cbca183 100644
--- a/net/ceph/snapshot.c
+++ b/net/ceph/snapshot.c
@@ -17,6 +17,11 @@
  * the entire structure is freed.
  */
 
+static void ceph_snap_context_kfree(struct netfs_group *group)
+{
+	kfree(group);
+}
+
 /*
  * Create a new ceph snapshot context large enough to hold the
  * indicated number of snapshot ids (which can be 0).  Caller has
@@ -36,8 +41,9 @@ struct ceph_snap_context *ceph_create_snap_context(u32 snap_count,
 	if (!snapc)
 		return NULL;
 
-	refcount_set(&snapc->nref, 1);
-	snapc->num_snaps = snap_count;
+	refcount_set(&snapc->group.ref, 1);
+	snapc->group.free = ceph_snap_context_kfree;
+	snapc->num_snaps  = snap_count;
 
 	return snapc;
 }
@@ -46,18 +52,14 @@ EXPORT_SYMBOL(ceph_create_snap_context);
 struct ceph_snap_context *ceph_get_snap_context(struct ceph_snap_context *sc)
 {
 	if (sc)
-		refcount_inc(&sc->nref);
+		netfs_get_group(&sc->group);
 	return sc;
 }
 EXPORT_SYMBOL(ceph_get_snap_context);
 
 void ceph_put_snap_context(struct ceph_snap_context *sc)
 {
-	if (!sc)
-		return;
-	if (refcount_dec_and_test(&sc->nref)) {
-		/*printk(" deleting snap_context %p\n", sc);*/
-		kfree(sc);
-	}
+	if (sc)
+		netfs_put_group(&sc->group);
 }
 EXPORT_SYMBOL(ceph_put_snap_context);



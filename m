Return-Path: <linux-fsdevel+bounces-15558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1989057A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6262B24BC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D50E535CA;
	Thu, 28 Mar 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ta31L8Y2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC83BBD8
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643764; cv=none; b=SnouTtfRxXnxfviYDFogm9bdk9QtI08Xv05uDyF7ZzYv69OElnfhagh7dPq5xxN18PdREkV8/LVjPsZqu9CpyrMnqQrS2Xx28sC9QcVw+Id639SpHkOKvHBTFKkqdgkuKF41413yE4aikP+0UgPT1tUHgm1KEGr3sOUHzP6rOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643764; c=relaxed/simple;
	bh=slzC21ICZCdWIzonQ/mPvBGa6XbwECTCPt1e6V4fu5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXOx4ge1iKdxK/gVgEeFyMV66gv1zX/3dHeoQBzZF7Twy+osx5eR2MWxHTS6eofhxfD/hdIMOPwQc4vMQ+K3v5M5tvIuiDm9gwTm5TAHwJdcLWX+S/NWQFPr92umqzRBvmeLyuMvPpdKnYwzRIT/cNkx5KgVRh8kj4MB0+Zy8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ta31L8Y2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iC09wgEn+nkMdm87RmEZnZWgl9jjcn1kRzVWvt93hHQ=;
	b=Ta31L8Y2028SD8CiMx0VRqclfdJWminMyfn5GdnL1Yeo7ytrhowvvXIzBF3m3UH4T0cefy
	/WZvnFIN//CB5uWxiYLC4+1ptyDJvi+KGCXeezFwUxDYv8cu9ZjlbyXgfGN4q6nxx7nWux
	VUhPTBWccLEtPXSW6NyySktrc6ypZPg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-Lrvqun6ANEGz38ENu2tjsg-1; Thu, 28 Mar 2024 12:35:58 -0400
X-MC-Unique: Lrvqun6ANEGz38ENu2tjsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBD8888B7A8;
	Thu, 28 Mar 2024 16:35:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3573E3C54;
	Thu, 28 Mar 2024 16:35:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo Li <xiubli@redhat.com>,
	Steve French <sfrench@samba.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH 05/26] mm: Remove the PG_fscache alias for PG_private_2
Date: Thu, 28 Mar 2024 16:33:57 +0000
Message-ID: <20240328163424.2781320-6-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Remove the PG_fscache alias for PG_private_2 and use the latter directly.
Use of this flag for marking pages undergoing writing to the cache should
be considered deprecated and the folios should be marked dirty instead and
the write done in ->writepages().

Note that PG_private_2 itself should be considered deprecated and up for
future removal by the MM folks too.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: Bharath SM <bharathsm@microsoft.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna@kernel.org>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ceph/addr.c           | 11 +++---
 fs/netfs/buffered_read.c |  4 +-
 fs/netfs/fscache_io.c    |  2 +-
 fs/netfs/io.c            |  2 +-
 fs/nfs/file.c            |  8 ++--
 fs/nfs/fscache.h         |  4 +-
 fs/nfs/write.c           |  4 +-
 fs/smb/client/file.c     | 16 ++++----
 include/linux/netfs.h    | 80 ++--------------------------------------
 mm/filemap.c             |  6 +--
 10 files changed, 33 insertions(+), 104 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 57cbae134b37..75690f969ebc 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -500,7 +500,7 @@ const struct netfs_request_ops ceph_netfs_ops = {
 #ifdef CONFIG_CEPH_FSCACHE
 static void ceph_set_page_fscache(struct page *page)
 {
-	set_page_fscache(page);
+	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
 }
 
 static void ceph_fscache_write_terminated(void *priv, ssize_t error, bool was_async)
@@ -798,7 +798,7 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
 	    ceph_inode_to_fs_client(inode)->write_congested)
 		return AOP_WRITEPAGE_ACTIVATE;
 
-	wait_on_page_fscache(page);
+	folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
 
 	err = writepage_nounlock(page, wbc);
 	if (err == -ERESTARTSYS) {
@@ -1073,7 +1073,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 				unlock_page(page);
 				break;
 			}
-			if (PageWriteback(page) || PageFsCache(page)) {
+			if (PageWriteback(page) ||
+			    PagePrivate2(page) /* [DEPRECATED] */) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					doutc(cl, "%p under writeback\n", page);
 					unlock_page(page);
@@ -1081,7 +1082,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				}
 				doutc(cl, "waiting on writeback %p\n", page);
 				wait_on_page_writeback(page);
-				wait_on_page_fscache(page);
+				folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
@@ -1511,7 +1512,7 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 	if (r < 0)
 		return r;
 
-	folio_wait_fscache(folio);
+	folio_wait_private_2(folio); /* [DEPRECATED] */
 	WARN_ON_ONCE(!folio_test_locked(folio));
 	*pagep = &folio->page;
 	return 0;
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 6d49319c82c6..b3fd6e1fa322 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -70,7 +70,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 				if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE,
 							       &subreq->flags)) {
 					trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
-					folio_start_fscache(folio);
+					folio_start_private_2(folio);
 					folio_started = true;
 				}
 			} else {
@@ -506,7 +506,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 
 have_folio:
 	if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags)) {
-		ret = folio_wait_fscache_killable(folio);
+		ret = folio_wait_private_2_killable(folio);
 		if (ret < 0)
 			goto error;
 	}
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 5028f2ae30da..38637e5c9b57 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -183,7 +183,7 @@ void __fscache_clear_page_bits(struct address_space *mapping,
 
 		rcu_read_lock();
 		xas_for_each(&xas, page, last) {
-			end_page_fscache(page);
+			folio_end_private_2(page_folio(page));
 		}
 		rcu_read_unlock();
 	}
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index b3b9827a9709..60a19f96e0ce 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -129,7 +129,7 @@ static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
 				continue;
 			unlocked = folio_next_index(folio) - 1;
 			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
-			folio_end_fscache(folio);
+			folio_end_private_2(folio);
 			have_unlocked = true;
 		}
 	}
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 407c6e15afe2..6bd127e6683d 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -433,7 +433,7 @@ static void nfs_invalidate_folio(struct folio *folio, size_t offset,
 		return;
 	/* Cancel any unstarted writes on this page */
 	nfs_wb_folio_cancel(inode, folio);
-	folio_wait_fscache(folio);
+	folio_wait_private_2(folio); /* [DEPRECATED] */
 	trace_nfs_invalidate_folio(inode, folio);
 }
 
@@ -500,7 +500,7 @@ static int nfs_launder_folio(struct folio *folio)
 	dfprintk(PAGECACHE, "NFS: launder_folio(%ld, %llu)\n",
 		inode->i_ino, folio_pos(folio));
 
-	folio_wait_fscache(folio);
+	folio_wait_private_2(folio); /* [DEPRECATED] */
 	ret = nfs_wb_folio(inode, folio);
 	trace_nfs_launder_folio_done(inode, folio, ret);
 	return ret;
@@ -593,8 +593,8 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 
 	/* make sure the cache has finished storing the page */
-	if (folio_test_fscache(folio) &&
-	    folio_wait_fscache_killable(folio) < 0) {
+	if (folio_test_private_2(folio) && /* [DEPRECATED] */
+	    folio_wait_private_2_killable(folio) < 0) {
 		ret = VM_FAULT_RETRY;
 		goto out;
 	}
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 814363d1d7c7..fbed0027996f 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -103,10 +103,10 @@ extern int nfs_netfs_read_folio(struct file *file, struct folio *folio);
 
 static inline bool nfs_fscache_release_folio(struct folio *folio, gfp_t gfp)
 {
-	if (folio_test_fscache(folio)) {
+	if (folio_test_private_2(folio)) { /* [DEPRECATED] */
 		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
-		folio_wait_fscache(folio);
+		folio_wait_private_2(folio);
 	}
 	fscache_note_page_release(netfs_i_cookie(netfs_inode(folio->mapping->host)));
 	return true;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 5de85d725fb9..2329cbb0e446 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2120,10 +2120,10 @@ int nfs_migrate_folio(struct address_space *mapping, struct folio *dst,
 	if (folio_test_private(src))
 		return -EBUSY;
 
-	if (folio_test_fscache(src)) {
+	if (folio_test_private_2(src)) { /* [DEPRECATED] */
 		if (mode == MIGRATE_ASYNC)
 			return -EBUSY;
-		folio_wait_fscache(src);
+		folio_wait_private_2(src);
 	}
 
 	return migrate_folio(mapping, dst, src, mode);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 16aadce492b2..59da572d3384 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2953,12 +2953,12 @@ static ssize_t cifs_writepages_begin(struct address_space *mapping,
 	}
 
 	if (folio_test_writeback(folio) ||
-	    folio_test_fscache(folio)) {
+	    folio_test_private_2(folio)) { /* [DEPRECATED] */
 		folio_unlock(folio);
 		if (wbc->sync_mode != WB_SYNC_NONE) {
 			folio_wait_writeback(folio);
 #ifdef CONFIG_CIFS_FSCACHE
-			folio_wait_fscache(folio);
+			folio_wait_private_2(folio);
 #endif
 			goto lock_again;
 		}
@@ -4431,8 +4431,8 @@ static vm_fault_t cifs_page_mkwrite(struct vm_fault *vmf)
 	 * be modified.  We then assume the entire folio will need writing back.
 	 */
 #ifdef CONFIG_CIFS_FSCACHE
-	if (folio_test_fscache(folio) &&
-	    folio_wait_fscache_killable(folio) < 0)
+	if (folio_test_private_2(folio) && /* [DEPRECATED] */
+	    folio_wait_private_2_killable(folio) < 0)
 		return VM_FAULT_RETRY;
 #endif
 
@@ -4898,10 +4898,10 @@ static bool cifs_release_folio(struct folio *folio, gfp_t gfp)
 {
 	if (folio_test_private(folio))
 		return 0;
-	if (folio_test_fscache(folio)) {
+	if (folio_test_private_2(folio)) { /* [DEPRECATED] */
 		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
-		folio_wait_fscache(folio);
+		folio_wait_private_2(folio);
 	}
 	fscache_note_page_release(cifs_inode_cookie(folio->mapping->host));
 	return true;
@@ -4910,7 +4910,7 @@ static bool cifs_release_folio(struct folio *folio, gfp_t gfp)
 static void cifs_invalidate_folio(struct folio *folio, size_t offset,
 				 size_t length)
 {
-	folio_wait_fscache(folio);
+	folio_wait_private_2(folio); /* [DEPRECATED] */
 }
 
 static int cifs_launder_folio(struct folio *folio)
@@ -4930,7 +4930,7 @@ static int cifs_launder_folio(struct folio *folio)
 	if (folio_clear_dirty_for_io(folio))
 		rc = cifs_writepage_locked(&folio->page, &wbc);
 
-	folio_wait_fscache(folio);
+	folio_wait_private_2(folio); /* [DEPRECATED] */
 	return rc;
 }
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f5e9c5f84a0c..f36a6d8163d1 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -21,94 +21,22 @@
 
 enum netfs_sreq_ref_trace;
 
-/*
- * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
- * a page is currently backed by a local disk cache
- */
-#define folio_test_fscache(folio)	folio_test_private_2(folio)
-#define PageFsCache(page)		PagePrivate2((page))
-#define SetPageFsCache(page)		SetPagePrivate2((page))
-#define ClearPageFsCache(page)		ClearPagePrivate2((page))
-#define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
-#define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
-
 /**
- * folio_start_fscache - Start an fscache write on a folio.
+ * folio_start_private_2 - Start an fscache write on a folio.  [DEPRECATED]
  * @folio: The folio.
  *
  * Call this function before writing a folio to a local cache.  Starting a
  * second write before the first one finishes is not allowed.
+ *
+ * Note that this should no longer be used.
  */
-static inline void folio_start_fscache(struct folio *folio)
+static inline void folio_start_private_2(struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(folio_test_private_2(folio), folio);
 	folio_get(folio);
 	folio_set_private_2(folio);
 }
 
-/**
- * folio_end_fscache - End an fscache write on a folio.
- * @folio: The folio.
- *
- * Call this function after the folio has been written to the local cache.
- * This will wake any sleepers waiting on this folio.
- */
-static inline void folio_end_fscache(struct folio *folio)
-{
-	folio_end_private_2(folio);
-}
-
-/**
- * folio_wait_fscache - Wait for an fscache write on this folio to end.
- * @folio: The folio.
- *
- * If this folio is currently being written to a local cache, wait for
- * the write to finish.  Another write may start after this one finishes,
- * unless the caller holds the folio lock.
- */
-static inline void folio_wait_fscache(struct folio *folio)
-{
-	folio_wait_private_2(folio);
-}
-
-/**
- * folio_wait_fscache_killable - Wait for an fscache write on this folio to end.
- * @folio: The folio.
- *
- * If this folio is currently being written to a local cache, wait
- * for the write to finish or for a fatal signal to be received.
- * Another write may start after this one finishes, unless the caller
- * holds the folio lock.
- *
- * Return:
- * - 0 if successful.
- * - -EINTR if a fatal signal was encountered.
- */
-static inline int folio_wait_fscache_killable(struct folio *folio)
-{
-	return folio_wait_private_2_killable(folio);
-}
-
-static inline void set_page_fscache(struct page *page)
-{
-	folio_start_fscache(page_folio(page));
-}
-
-static inline void end_page_fscache(struct page *page)
-{
-	folio_end_private_2(page_folio(page));
-}
-
-static inline void wait_on_page_fscache(struct page *page)
-{
-	folio_wait_private_2(page_folio(page));
-}
-
-static inline int wait_on_page_fscache_killable(struct page *page)
-{
-	return folio_wait_private_2_killable(page_folio(page));
-}
-
 /* Marks used on xarray-based buffers */
 #define NETFS_BUF_PUT_MARK	XA_MARK_0	/* - Page needs putting  */
 #define NETFS_BUF_PAGECACHE_MARK XA_MARK_1	/* - Page needs wb/dirty flag wrangling */
diff --git a/mm/filemap.c b/mm/filemap.c
index 7437b2bd75c1..25983f0f96e3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1540,7 +1540,7 @@ EXPORT_SYMBOL(folio_end_private_2);
  * folio_wait_private_2 - Wait for PG_private_2 to be cleared on a folio.
  * @folio: The folio to wait on.
  *
- * Wait for PG_private_2 (aka PG_fscache) to be cleared on a folio.
+ * Wait for PG_private_2 to be cleared on a folio.
  */
 void folio_wait_private_2(struct folio *folio)
 {
@@ -1553,8 +1553,8 @@ EXPORT_SYMBOL(folio_wait_private_2);
  * folio_wait_private_2_killable - Wait for PG_private_2 to be cleared on a folio.
  * @folio: The folio to wait on.
  *
- * Wait for PG_private_2 (aka PG_fscache) to be cleared on a folio or until a
- * fatal signal is received by the calling task.
+ * Wait for PG_private_2 to be cleared on a folio or until a fatal signal is
+ * received by the calling task.
  *
  * Return:
  * - 0 if successful.



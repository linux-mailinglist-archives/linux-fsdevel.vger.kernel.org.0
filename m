Return-Path: <linux-fsdevel+bounces-18327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03348B77FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266131F22B25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818BB172BD7;
	Tue, 30 Apr 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAFjqtiA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE54176FA2
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485682; cv=none; b=iGmGDs0Qcci5Ma6JteOCIrlmiTB/lEFUYpGheyXcOKuO0P6yvjjq7PvHp30F/dp/f39cxAElM9YBZHO4c8boEtUsp1pwvMrsWRyK/rg9qsbuZAcyNXGbsJ+IZRt8+EQPpFCEJ+O8iv6MEccU0OtMDKoKT24yydbrDQ3zZLuTRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485682; c=relaxed/simple;
	bh=uDLEGscOVBPlly99XiNYkmDKEr4xGMupocoTm8v3/T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbQuV2GgNHm6CzILuaRGg4FRmGJpxNXkc1sOA7Mm8toFDCEPeEQInOku5nexYPJnNAZccjp04sXCyl9fM1xFYgpBLisbotBZhmGmx6yjIoDOE0rzNxhZACm5ic12iwSGXPksvxEg55goSmydEeEET/ctrFPBdX1S2BBL/bUYXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAFjqtiA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OVsG9OBgVSx3c03vXIwajhD1GLF/ylpx1YwWnNhnxE=;
	b=AAFjqtiA2//gXm6+PJcp0mwutnWgbXnHY0lYF7u9kSHJ7nz1Os3Bdm9SDF8ldAKTteYFsa
	0N/6dybgcMMGnhwCe4eKILE1EMjMcNZIQXP2yBh2aAnOtuTNGbYHsarR9yY7gQPHXYWqCf
	Vm1GE2hwx3NoIdujlndZ1MnVB6TxtgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-cFq09FDENSWnZLHZpVPMpg-1; Tue, 30 Apr 2024 10:01:13 -0400
X-MC-Unique: cFq09FDENSWnZLHZpVPMpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 006FB800935;
	Tue, 30 Apr 2024 14:01:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 969FF581C8;
	Tue, 30 Apr 2024 14:01:07 +0000 (UTC)
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
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Xiubo Li <xiubli@redhat.com>,
	Steve French <sfrench@samba.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH v2 02/22] netfs: Replace PG_fscache by setting folio->private and marking dirty
Date: Tue, 30 Apr 2024 15:00:33 +0100
Message-ID: <20240430140056.261997-3-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

When dirty data is being written to the cache, setting/waiting on/clearing
the fscache flag is always done in tandem with setting/waiting on/clearing
the writeback flag.  The netfslib buffered write routines wait on and set
both flags and the write request cleanup clears both flags, so the fscache
flag is almost superfluous.

The reason it isn't superfluous is because the fscache flag is also used to
indicate that data just read from the server is being written to the cache.
The flag is used to prevent a race involving overlapping direct-I/O writes
to the cache.

Change this to indicate that a page is in need of being copied to the cache
by placing a magic value in folio->private and marking the folios dirty.
Then when the writeback code sees a folio marked in this way, it only
writes it to the cache and not to the server.

If a folio that has this magic value set is modified, the value is just
replaced and the folio will then be uplodaded too.

With this, PG_fscache is no longer required by the netfslib core, 9p and
afs.

Ceph and nfs, however, still need to use the old PG_fscache-based tracking.
To deal with this, a flag, NETFS_ICTX_USE_PGPRIV2, now has to be set on the
flags in the netfs_inode struct for those filesystems.  This reenables the
use of PG_fscache in that inode.  9p and afs use the netfslib write helpers
so get switched over; cifs, for the moment, does page-by-page manual access
to the cache, so doesn't use PG_fscache and is unaffected.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
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
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ceph/addr.c               |  2 +-
 fs/ceph/inode.c              |  2 +
 fs/netfs/buffered_read.c     | 36 ++++++++++----
 fs/netfs/buffered_write.c    | 93 +++++++++++++++++-------------------
 fs/netfs/fscache_io.c        | 12 +++--
 fs/netfs/internal.h          | 10 ++--
 fs/netfs/io.c                | 18 +++----
 fs/netfs/main.c              |  1 +
 fs/netfs/misc.c              | 10 +---
 fs/netfs/objects.c           |  6 ++-
 fs/nfs/fscache.h             |  2 +
 include/linux/fscache.h      | 22 +++++----
 include/linux/netfs.h        | 20 ++++++--
 include/trace/events/netfs.h |  6 ++-
 14 files changed, 143 insertions(+), 97 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ee9caf7916fb..28ae4976a4f9 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -517,7 +517,7 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
 	struct fscache_cookie *cookie = ceph_fscache_cookie(ci);
 
 	fscache_write_to_cache(cookie, inode->i_mapping, off, len, i_size_read(inode),
-			       ceph_fscache_write_terminated, inode, caching);
+			       ceph_fscache_write_terminated, inode, true, caching);
 }
 #else
 static inline void ceph_set_page_fscache(struct page *page)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 7b2e77517f23..99561fddcb38 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -577,6 +577,8 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 
 	/* Set parameters for the netfs library */
 	netfs_inode_init(&ci->netfs, &ceph_netfs_ops, false);
+	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cache. */
+	__set_bit(NETFS_ICTX_USE_PGPRIV2, &ci->netfs.flags);
 
 	spin_lock_init(&ci->i_ceph_lock);
 
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3298c29b5548..6d49319c82c6 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -10,8 +10,11 @@
 #include "internal.h"
 
 /*
- * Unlock the folios in a read operation.  We need to set PG_fscache on any
+ * Unlock the folios in a read operation.  We need to set PG_writeback on any
  * folios we're going to write back before we unlock them.
+ *
+ * Note that if the deprecated NETFS_RREQ_USE_PGPRIV2 is set then we use
+ * PG_private_2 and do a direct write to the cache from here instead.
  */
 void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 {
@@ -48,14 +51,14 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 	xas_for_each(&xas, folio, last_page) {
 		loff_t pg_end;
 		bool pg_failed = false;
-		bool folio_started;
+		bool wback_to_cache = false;
+		bool folio_started = false;
 
 		if (xas_retry(&xas, folio))
 			continue;
 
 		pg_end = folio_pos(folio) + folio_size(folio) - 1;
 
-		folio_started = false;
 		for (;;) {
 			loff_t sreq_end;
 
@@ -63,10 +66,16 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 				pg_failed = true;
 				break;
 			}
-			if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
-				trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
-				folio_start_fscache(folio);
-				folio_started = true;
+			if (test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)) {
+				if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE,
+							       &subreq->flags)) {
+					trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
+					folio_start_fscache(folio);
+					folio_started = true;
+				}
+			} else {
+				wback_to_cache |=
+					test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 			}
 			pg_failed |= subreq_failed;
 			sreq_end = subreq->start + subreq->len - 1;
@@ -98,6 +107,11 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 				kfree(finfo);
 			}
 			folio_mark_uptodate(folio);
+			if (wback_to_cache && !WARN_ON_ONCE(folio_get_private(folio) != NULL)) {
+				trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
+				folio_attach_private(folio, NETFS_FOLIO_COPY_TO_CACHE);
+				filemap_dirty_folio(folio->mapping, folio);
+			}
 		}
 
 		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
@@ -491,9 +505,11 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 
 have_folio:
-	ret = folio_wait_fscache_killable(folio);
-	if (ret < 0)
-		goto error;
+	if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags)) {
+		ret = folio_wait_fscache_killable(folio);
+		if (ret < 0)
+			goto error;
+	}
 have_folio_no_wait:
 	*_folio = folio;
 	_leave(" = 0");
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index f7455a579f21..57c6eab01261 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -30,21 +30,13 @@ static void netfs_cleanup_buffered_write(struct netfs_io_request *wreq);
 
 static void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
 {
-	if (netfs_group && !folio_get_private(folio))
-		folio_attach_private(folio, netfs_get_group(netfs_group));
-}
+	void *priv = folio_get_private(folio);
 
-#if IS_ENABLED(CONFIG_FSCACHE)
-static void netfs_folio_start_fscache(bool caching, struct folio *folio)
-{
-	if (caching)
-		folio_start_fscache(folio);
-}
-#else
-static void netfs_folio_start_fscache(bool caching, struct folio *folio)
-{
+	if (netfs_group && (!priv || priv == NETFS_FOLIO_COPY_TO_CACHE))
+		folio_attach_private(folio, netfs_get_group(netfs_group));
+	else if (!netfs_group && priv == NETFS_FOLIO_COPY_TO_CACHE)
+		folio_detach_private(folio);
 }
-#endif
 
 /*
  * Decide how we should modify a folio.  We might be attempting to do
@@ -63,11 +55,12 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 						    bool maybe_trouble)
 {
 	struct netfs_folio *finfo = netfs_folio_info(folio);
+	struct netfs_group *group = netfs_folio_group(folio);
 	loff_t pos = folio_file_pos(folio);
 
 	_enter("");
 
-	if (netfs_folio_group(folio) != netfs_group)
+	if (group != netfs_group && group != NETFS_FOLIO_COPY_TO_CACHE)
 		return NETFS_FLUSH_CONTENT;
 
 	if (folio_test_uptodate(folio))
@@ -396,9 +389,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 				folio_clear_dirty_for_io(folio);
 			/* We make multiple writes to the folio... */
 			if (!folio_test_writeback(folio)) {
-				folio_wait_fscache(folio);
 				folio_start_writeback(folio);
-				folio_start_fscache(folio);
 				if (wreq->iter.count == 0)
 					trace_netfs_folio(folio, netfs_folio_trace_wthru);
 				else
@@ -528,6 +519,7 @@ EXPORT_SYMBOL(netfs_file_write_iter);
  */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group)
 {
+	struct netfs_group *group;
 	struct folio *folio = page_folio(vmf->page);
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
@@ -550,7 +542,8 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 		goto out;
 	}
 
-	if (netfs_folio_group(folio) != netfs_group) {
+	group = netfs_folio_group(folio);
+	if (group != netfs_group && group != NETFS_FOLIO_COPY_TO_CACHE) {
 		folio_unlock(folio);
 		err = filemap_fdatawait_range(inode->i_mapping,
 					      folio_pos(folio),
@@ -606,8 +599,6 @@ static void netfs_kill_pages(struct address_space *mapping,
 
 		trace_netfs_folio(folio, netfs_folio_trace_kill);
 		folio_clear_uptodate(folio);
-		if (folio_test_fscache(folio))
-			folio_end_fscache(folio);
 		folio_end_writeback(folio);
 		folio_lock(folio);
 		generic_error_remove_folio(mapping, folio);
@@ -643,8 +634,6 @@ static void netfs_redirty_pages(struct address_space *mapping,
 		next = folio_next_index(folio);
 		trace_netfs_folio(folio, netfs_folio_trace_redirty);
 		filemap_dirty_folio(mapping, folio);
-		if (folio_test_fscache(folio))
-			folio_end_fscache(folio);
 		folio_end_writeback(folio);
 		folio_put(folio);
 	} while (index = next, index <= last);
@@ -700,7 +689,11 @@ static void netfs_pages_written_back(struct netfs_io_request *wreq)
 				if (!folio_test_dirty(folio)) {
 					folio_detach_private(folio);
 					gcount++;
-					trace_netfs_folio(folio, netfs_folio_trace_clear_g);
+					if (group == NETFS_FOLIO_COPY_TO_CACHE)
+						trace_netfs_folio(folio,
+								  netfs_folio_trace_end_copy);
+					else
+						trace_netfs_folio(folio, netfs_folio_trace_clear_g);
 				} else {
 					trace_netfs_folio(folio, netfs_folio_trace_redirtied);
 				}
@@ -724,8 +717,6 @@ static void netfs_pages_written_back(struct netfs_io_request *wreq)
 			trace_netfs_folio(folio, netfs_folio_trace_clear);
 		}
 	end_wb:
-		if (folio_test_fscache(folio))
-			folio_end_fscache(folio);
 		xas_advance(&xas, folio_next_index(folio) - 1);
 		folio_end_writeback(folio);
 	}
@@ -795,7 +786,6 @@ static void netfs_extend_writeback(struct address_space *mapping,
 				   long *_count,
 				   loff_t start,
 				   loff_t max_len,
-				   bool caching,
 				   size_t *_len,
 				   size_t *_top)
 {
@@ -846,8 +836,7 @@ static void netfs_extend_writeback(struct address_space *mapping,
 				break;
 			}
 			if (!folio_test_dirty(folio) ||
-			    folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
+			    folio_test_writeback(folio)) {
 				folio_unlock(folio);
 				folio_put(folio);
 				xas_reset(xas);
@@ -860,7 +849,8 @@ static void netfs_extend_writeback(struct address_space *mapping,
 			if ((const struct netfs_group *)priv != group) {
 				stop = true;
 				finfo = netfs_folio_info(folio);
-				if (finfo->netfs_group != group ||
+				if (!finfo ||
+				    finfo->netfs_group != group ||
 				    finfo->dirty_offset > 0) {
 					folio_unlock(folio);
 					folio_put(folio);
@@ -894,12 +884,14 @@ static void netfs_extend_writeback(struct address_space *mapping,
 
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			folio = fbatch.folios[i];
-			trace_netfs_folio(folio, netfs_folio_trace_store_plus);
+			if (group == NETFS_FOLIO_COPY_TO_CACHE)
+				trace_netfs_folio(folio, netfs_folio_trace_copy_plus);
+			else
+				trace_netfs_folio(folio, netfs_folio_trace_store_plus);
 
 			if (!folio_clear_dirty_for_io(folio))
 				BUG();
 			folio_start_writeback(folio);
-			netfs_folio_start_fscache(caching, folio);
 			folio_unlock(folio);
 		}
 
@@ -925,14 +917,14 @@ static ssize_t netfs_write_back_from_locked_folio(struct address_space *mapping,
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
 	unsigned long long i_size = i_size_read(&ctx->inode);
 	size_t len, max_len;
-	bool caching = netfs_is_cache_enabled(ctx);
 	long count = wbc->nr_to_write;
 	int ret;
 
-	_enter(",%lx,%llx-%llx,%u", folio->index, start, end, caching);
+	_enter(",%lx,%llx-%llx", folio->index, start, end);
 
 	wreq = netfs_alloc_request(mapping, NULL, start, folio_size(folio),
-				   NETFS_WRITEBACK);
+				   group == NETFS_FOLIO_COPY_TO_CACHE ?
+				   NETFS_COPY_TO_CACHE : NETFS_WRITEBACK);
 	if (IS_ERR(wreq)) {
 		folio_unlock(folio);
 		return PTR_ERR(wreq);
@@ -941,7 +933,6 @@ static ssize_t netfs_write_back_from_locked_folio(struct address_space *mapping,
 	if (!folio_clear_dirty_for_io(folio))
 		BUG();
 	folio_start_writeback(folio);
-	netfs_folio_start_fscache(caching, folio);
 
 	count -= folio_nr_pages(folio);
 
@@ -950,7 +941,10 @@ static ssize_t netfs_write_back_from_locked_folio(struct address_space *mapping,
 	 * immediately lockable, is not dirty or is missing, or we reach the
 	 * end of the range.
 	 */
-	trace_netfs_folio(folio, netfs_folio_trace_store);
+	if (group == NETFS_FOLIO_COPY_TO_CACHE)
+		trace_netfs_folio(folio, netfs_folio_trace_copy);
+	else
+		trace_netfs_folio(folio, netfs_folio_trace_store);
 
 	len = wreq->len;
 	finfo = netfs_folio_info(folio);
@@ -973,7 +967,7 @@ static ssize_t netfs_write_back_from_locked_folio(struct address_space *mapping,
 
 		if (len < max_len)
 			netfs_extend_writeback(mapping, group, xas, &count, start,
-					       max_len, caching, &len, &wreq->upper_len);
+					       max_len, &len, &wreq->upper_len);
 	}
 
 cant_expand:
@@ -997,15 +991,18 @@ static ssize_t netfs_write_back_from_locked_folio(struct address_space *mapping,
 
 		iov_iter_xarray(&wreq->iter, ITER_SOURCE, &mapping->i_pages, start,
 				wreq->upper_len);
-		__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-		ret = netfs_begin_write(wreq, true, netfs_write_trace_writeback);
+		if (group != NETFS_FOLIO_COPY_TO_CACHE) {
+			__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
+			ret = netfs_begin_write(wreq, true, netfs_write_trace_writeback);
+		} else {
+			ret = netfs_begin_write(wreq, true, netfs_write_trace_copy_to_cache);
+		}
 		if (ret == 0 || ret == -EIOCBQUEUED)
 			wbc->nr_to_write -= len / PAGE_SIZE;
 	} else {
 		_debug("write discard %zx @%llx [%llx]", len, start, i_size);
 
 		/* The dirty region was entirely beyond the EOF. */
-		fscache_clear_page_bits(mapping, start, len, caching);
 		netfs_pages_written_back(wreq);
 		ret = 0;
 	}
@@ -1058,9 +1055,11 @@ static ssize_t netfs_writepages_begin(struct address_space *mapping,
 
 		/* Skip any dirty folio that's not in the group of interest. */
 		priv = folio_get_private(folio);
-		if ((const struct netfs_group *)priv != group) {
-			finfo = netfs_folio_info(folio);
-			if (finfo->netfs_group != group) {
+		if ((const struct netfs_group *)priv == NETFS_FOLIO_COPY_TO_CACHE) {
+			group = NETFS_FOLIO_COPY_TO_CACHE;
+		} else if ((const struct netfs_group *)priv != group) {
+			finfo = __netfs_folio_info(priv);
+			if (!finfo || finfo->netfs_group != group) {
 				folio_put(folio);
 				continue;
 			}
@@ -1099,14 +1098,10 @@ static ssize_t netfs_writepages_begin(struct address_space *mapping,
 		goto search_again;
 	}
 
-	if (folio_test_writeback(folio) ||
-	    folio_test_fscache(folio)) {
+	if (folio_test_writeback(folio)) {
 		folio_unlock(folio);
 		if (wbc->sync_mode != WB_SYNC_NONE) {
 			folio_wait_writeback(folio);
-#ifdef CONFIG_FSCACHE
-			folio_wait_fscache(folio);
-#endif
 			goto lock_again;
 		}
 
@@ -1265,7 +1260,8 @@ int netfs_launder_folio(struct folio *folio)
 
 	bvec_set_folio(&bvec, folio, len, offset);
 	iov_iter_bvec(&wreq->iter, ITER_SOURCE, &bvec, 1, len);
-	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
+	if (group != NETFS_FOLIO_COPY_TO_CACHE)
+		__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
 	ret = netfs_begin_write(wreq, true, netfs_write_trace_launder);
 
 out_put:
@@ -1274,7 +1270,6 @@ int netfs_launder_folio(struct folio *folio)
 	kfree(finfo);
 	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
 out:
-	folio_wait_fscache(folio);
 	_leave(" = %d", ret);
 	return ret;
 }
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 43a651ed8264..5028f2ae30da 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -166,6 +166,7 @@ struct fscache_write_request {
 	loff_t			start;
 	size_t			len;
 	bool			set_bits;
+	bool			using_pgpriv2;
 	netfs_io_terminated_t	term_func;
 	void			*term_func_priv;
 };
@@ -197,8 +198,9 @@ static void fscache_wreq_done(void *priv, ssize_t transferred_or_error,
 {
 	struct fscache_write_request *wreq = priv;
 
-	fscache_clear_page_bits(wreq->mapping, wreq->start, wreq->len,
-				wreq->set_bits);
+	if (wreq->using_pgpriv2)
+		fscache_clear_page_bits(wreq->mapping, wreq->start, wreq->len,
+					wreq->set_bits);
 
 	if (wreq->term_func)
 		wreq->term_func(wreq->term_func_priv, transferred_or_error,
@@ -212,7 +214,7 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 			      loff_t start, size_t len, loff_t i_size,
 			      netfs_io_terminated_t term_func,
 			      void *term_func_priv,
-			      bool cond)
+			      bool using_pgpriv2, bool cond)
 {
 	struct fscache_write_request *wreq;
 	struct netfs_cache_resources *cres;
@@ -230,6 +232,7 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 	wreq->mapping		= mapping;
 	wreq->start		= start;
 	wreq->len		= len;
+	wreq->using_pgpriv2	= using_pgpriv2;
 	wreq->set_bits		= cond;
 	wreq->term_func		= term_func;
 	wreq->term_func_priv	= term_func_priv;
@@ -257,7 +260,8 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 abandon_free:
 	kfree(wreq);
 abandon:
-	fscache_clear_page_bits(mapping, start, len, cond);
+	if (using_pgpriv2)
+		fscache_clear_page_bits(mapping, start, len, cond);
 	if (term_func)
 		term_func(term_func_priv, ret, false);
 }
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index ec7045d24400..156ab138e224 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -168,7 +168,7 @@ static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
  */
 static inline struct netfs_group *netfs_get_group(struct netfs_group *netfs_group)
 {
-	if (netfs_group)
+	if (netfs_group && netfs_group != NETFS_FOLIO_COPY_TO_CACHE)
 		refcount_inc(&netfs_group->ref);
 	return netfs_group;
 }
@@ -178,7 +178,9 @@ static inline struct netfs_group *netfs_get_group(struct netfs_group *netfs_grou
  */
 static inline void netfs_put_group(struct netfs_group *netfs_group)
 {
-	if (netfs_group && refcount_dec_and_test(&netfs_group->ref))
+	if (netfs_group &&
+	    netfs_group != NETFS_FOLIO_COPY_TO_CACHE &&
+	    refcount_dec_and_test(&netfs_group->ref))
 		netfs_group->free(netfs_group);
 }
 
@@ -187,7 +189,9 @@ static inline void netfs_put_group(struct netfs_group *netfs_group)
  */
 static inline void netfs_put_group_many(struct netfs_group *netfs_group, int nr)
 {
-	if (netfs_group && refcount_sub_and_test(nr, &netfs_group->ref))
+	if (netfs_group &&
+	    netfs_group != NETFS_FOLIO_COPY_TO_CACHE &&
+	    refcount_sub_and_test(nr, &netfs_group->ref))
 		netfs_group->free(netfs_group);
 }
 
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 4261ad6c55b6..b3b9827a9709 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -99,8 +99,9 @@ static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
 }
 
 /*
- * Deal with the completion of writing the data to the cache.  We have to clear
- * the PG_fscache bits on the folios involved and release the caller's ref.
+ * [DEPRECATED] Deal with the completion of writing the data to the cache.  We
+ * have to clear the PG_fscache bits on the folios involved and release the
+ * caller's ref.
  *
  * May be called in softirq mode and we inherit a ref from the caller.
  */
@@ -138,7 +139,7 @@ static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
 }
 
 static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
-				       bool was_async)
+				       bool was_async) /* [DEPRECATED] */
 {
 	struct netfs_io_subrequest *subreq = priv;
 	struct netfs_io_request *rreq = subreq->rreq;
@@ -161,8 +162,8 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
 }
 
 /*
- * Perform any outstanding writes to the cache.  We inherit a ref from the
- * caller.
+ * [DEPRECATED] Perform any outstanding writes to the cache.  We inherit a ref
+ * from the caller.
  */
 static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 {
@@ -222,7 +223,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 		netfs_rreq_unmark_after_write(rreq, false);
 }
 
-static void netfs_rreq_write_to_cache_work(struct work_struct *work)
+static void netfs_rreq_write_to_cache_work(struct work_struct *work) /* [DEPRECATED] */
 {
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);
@@ -230,7 +231,7 @@ static void netfs_rreq_write_to_cache_work(struct work_struct *work)
 	netfs_rreq_do_write_to_cache(rreq);
 }
 
-static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq)
+static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq) /* [DEPRECATED] */
 {
 	rreq->work.func = netfs_rreq_write_to_cache_work;
 	if (!queue_work(system_unbound_wq, &rreq->work))
@@ -409,7 +410,8 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
 
-	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags))
+	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags) &&
+	    test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags))
 		return netfs_rreq_write_to_cache(rreq);
 
 	netfs_rreq_completed(rreq, was_async);
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 5e77618a7940..c5a73c9ed126 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -31,6 +31,7 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READAHEAD]		= "RA",
 	[NETFS_READPAGE]		= "RP",
 	[NETFS_READ_FOR_WRITE]		= "RW",
+	[NETFS_COPY_TO_CACHE]		= "CC",
 	[NETFS_WRITEBACK]		= "WB",
 	[NETFS_WRITETHROUGH]		= "WT",
 	[NETFS_LAUNDER_WRITE]		= "LW",
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 90051ced8e2a..bc1fc54fb724 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -177,13 +177,11 @@ EXPORT_SYMBOL(netfs_clear_inode_writeback);
  */
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 {
-	struct netfs_folio *finfo = NULL;
+	struct netfs_folio *finfo;
 	size_t flen = folio_size(folio);
 
 	_enter("{%lx},%zx,%zx", folio->index, offset, length);
 
-	folio_wait_fscache(folio);
-
 	if (!folio_test_private(folio))
 		return;
 
@@ -248,12 +246,6 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 
 	if (folio_test_private(folio))
 		return false;
-	if (folio_test_fscache(folio)) {
-		if (current_is_kswapd() || !(gfp & __GFP_FS))
-			return false;
-		folio_wait_fscache(folio);
-	}
-
 	fscache_note_page_release(netfs_i_cookie(ctx));
 	return true;
 }
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 610ceb5bd86c..72b52f070270 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -45,8 +45,12 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	refcount_set(&rreq->ref, 1);
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	if (cached)
+	if (cached) {
 		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
+		if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags))
+			/* Filesystem uses deprecated PG_private_2 marking. */
+			__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
+	}
 	if (file && file->f_flags & O_NONBLOCK)
 		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index e3cb4923316b..814363d1d7c7 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -81,6 +81,8 @@ static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
 static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
 {
 	netfs_inode_init(&nfsi->netfs, &nfs_netfs_ops, false);
+	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cache. */
+	__set_bit(NETFS_ICTX_USE_PGPRIV2, &nfsi->netfs.flags);
 }
 extern void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr);
 extern void nfs_netfs_read_completion(struct nfs_pgio_header *hdr);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 6e8562cbcc43..9de27643607f 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -172,9 +172,12 @@ extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t,
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 extern int __fscache_begin_write_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 
-extern void __fscache_write_to_cache(struct fscache_cookie *, struct address_space *,
-				     loff_t, size_t, loff_t, netfs_io_terminated_t, void *,
-				     bool);
+void __fscache_write_to_cache(struct fscache_cookie *cookie,
+			      struct address_space *mapping,
+			      loff_t start, size_t len, loff_t i_size,
+			      netfs_io_terminated_t term_func,
+			      void *term_func_priv,
+			      bool using_pgpriv2, bool cond);
 extern void __fscache_clear_page_bits(struct address_space *, loff_t, size_t);
 
 /**
@@ -597,7 +600,8 @@ static inline void fscache_clear_page_bits(struct address_space *mapping,
  * @i_size: The new size of the inode
  * @term_func: The function to call upon completion
  * @term_func_priv: The private data for @term_func
- * @caching: If PG_fscache has been set
+ * @using_pgpriv2: If we're using PG_private_2 to mark in-progress write
+ * @caching: If we actually want to do the caching
  *
  * Helper function for a netfs to write dirty data from an inode into the cache
  * object that's backing it.
@@ -608,19 +612,21 @@ static inline void fscache_clear_page_bits(struct address_space *mapping,
  * marked with PG_fscache.
  *
  * If given, @term_func will be called upon completion and supplied with
- * @term_func_priv.  Note that the PG_fscache flags will have been cleared by
- * this point, so the netfs must retain its own pin on the mapping.
+ * @term_func_priv.  Note that if @using_pgpriv2 is set, the PG_private_2 flags
+ * will have been cleared by this point, so the netfs must retain its own pin
+ * on the mapping.
  */
 static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 					  struct address_space *mapping,
 					  loff_t start, size_t len, loff_t i_size,
 					  netfs_io_terminated_t term_func,
 					  void *term_func_priv,
-					  bool caching)
+					  bool using_pgpriv2, bool caching)
 {
 	if (caching)
 		__fscache_write_to_cache(cookie, mapping, start, len, i_size,
-					 term_func, term_func_priv, caching);
+					 term_func, term_func_priv,
+					 using_pgpriv2, caching);
 	else if (term_func)
 		term_func(term_func_priv, -ENOBUFS, false);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 100cbb261269..f5e9c5f84a0c 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -143,6 +143,8 @@ struct netfs_inode {
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
 #define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
 #define NETFS_ICTX_NO_WRITE_STREAMING	3	/* Don't engage in write-streaming */
+#define NETFS_ICTX_USE_PGPRIV2	31		/* [DEPRECATED] Use PG_private_2 to mark
+						 * write to cache on read */
 };
 
 /*
@@ -165,16 +167,25 @@ struct netfs_folio {
 	unsigned int		dirty_len;	/* Write-streaming dirty data length */
 };
 #define NETFS_FOLIO_INFO	0x1UL	/* OR'd with folio->private. */
+#define NETFS_FOLIO_COPY_TO_CACHE ((struct netfs_group *)0x356UL) /* Write to the cache only */
 
-static inline struct netfs_folio *netfs_folio_info(struct folio *folio)
+static inline bool netfs_is_folio_info(const void *priv)
 {
-	void *priv = folio_get_private(folio);
+	return (unsigned long)priv & NETFS_FOLIO_INFO;
+}
 
-	if ((unsigned long)priv & NETFS_FOLIO_INFO)
+static inline struct netfs_folio *__netfs_folio_info(const void *priv)
+{
+	if (netfs_is_folio_info(priv))
 		return (struct netfs_folio *)((unsigned long)priv & ~NETFS_FOLIO_INFO);
 	return NULL;
 }
 
+static inline struct netfs_folio *netfs_folio_info(struct folio *folio)
+{
+	return __netfs_folio_info(folio_get_private(folio));
+}
+
 static inline struct netfs_group *netfs_folio_group(struct folio *folio)
 {
 	struct netfs_folio *finfo;
@@ -230,6 +241,7 @@ enum netfs_io_origin {
 	NETFS_READAHEAD,		/* This read was triggered by readahead */
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
+	NETFS_COPY_TO_CACHE,		/* This write is to copy a read to the cache */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
 	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
 	NETFS_LAUNDER_WRITE,		/* This is triggered by ->launder_folio() */
@@ -287,6 +299,8 @@ struct netfs_io_request {
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 #define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
 #define NETFS_RREQ_BLOCKED		10	/* We blocked */
+#define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
+						 * write to cache on read */
 	const struct netfs_request_ops *netfs_ops;
 	void (*cleanup)(struct netfs_io_request *req);
 };
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 447a8c21cf57..e03fafb0c1e3 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -24,6 +24,7 @@
 	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
 #define netfs_write_traces					\
+	EM(netfs_write_trace_copy_to_cache,	"COPY2CACH")	\
 	EM(netfs_write_trace_dio_write,		"DIO-WRITE")	\
 	EM(netfs_write_trace_launder,		"LAUNDER  ")	\
 	EM(netfs_write_trace_unbuffered_write,	"UNB-WRITE")	\
@@ -34,6 +35,7 @@
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
+	EM(NETFS_COPY_TO_CACHE,			"CC")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
 	EM(NETFS_WRITETHROUGH,			"WT")		\
 	EM(NETFS_LAUNDER_WRITE,			"LW")		\
@@ -127,7 +129,9 @@
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
-	EM(netfs_folio_trace_copy_to_cache,	"copy")		\
+	EM(netfs_folio_trace_copy,		"copy")		\
+	EM(netfs_folio_trace_copy_plus,		"copy+")	\
+	EM(netfs_folio_trace_copy_to_cache,	"mark-copy")	\
 	EM(netfs_folio_trace_end_copy,		"end-copy")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\



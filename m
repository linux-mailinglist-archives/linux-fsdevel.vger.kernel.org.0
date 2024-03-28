Return-Path: <linux-fsdevel+bounces-15577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2993C890615
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE87B20C47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C6B13E6A7;
	Thu, 28 Mar 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0G7pEbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA113E05F
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643945; cv=none; b=LNmmDbdUQNOCgxmiUdpdvJRUYd0yfwxgmWgP+o99zfn80/HNuVZ2KY6v6rvAZrMvZn9tZyA5qCNYKBaC2oqFndvEKKL+amJtBlrZvlDpHJwBqXgyq3Gj6U9tQLf88x+yTNqKofu21pWLoh1G99xYuKag8AN7xTX6fAEtaM/HyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643945; c=relaxed/simple;
	bh=YbOsA41M4sFoThuuVNZw07f+V9OfvCH9DdXZ5K83PCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1C52LTTRNIwTp2N44C650LFBq1ko4YeSq/Uskf2zJ8FvWL+3RwNprieaPJSEjHEf9OedzvZt4IMJsWXxddwltQEx5R3L5KZeQSfZHRNfpgNcC4QOKsQ7p+b5DMSFmzkZ1OurQEUUR3YUc6KQY3X6wUYGqcFPFwSFd42iCuwZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0G7pEbt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKP8EIk/90tXduvWfbi83OCfYJOvuR93XNpIpLtR7a4=;
	b=A0G7pEbtCRj5atddv1fKDf+v9JI92Hb/Bb5n3+uPkV+vqKnpW0EOKY/aRrhef7VQkCuzNE
	NifVI8XZ59EYirOvUiMRvQ4H4ECH/3z3JZ/At/8W366smB+bRmiRGs5YLyGaEQt1tmrDHT
	qwafzGpzXUhHLUy0rHktBNQLqh/5zGY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-L7b2-t2COAqIU4q9j17nCQ-1; Thu,
 28 Mar 2024 12:38:57 -0400
X-MC-Unique: L7b2-t2COAqIU4q9j17nCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 334EE3801FF3;
	Thu, 28 Mar 2024 16:38:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5D0D51C05E1F;
	Thu, 28 Mar 2024 16:38:52 +0000 (UTC)
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
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH 24/26] netfs: Remove the old writeback code
Date: Thu, 28 Mar 2024 16:34:16 +0000
Message-ID: <20240328163424.2781320-25-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Remove the old writeback code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c          |  34 ---
 fs/afs/write.c            |  40 ---
 fs/netfs/buffered_write.c | 629 --------------------------------------
 fs/netfs/direct_write.c   |   2 +-
 fs/netfs/output.c         | 477 -----------------------------
 5 files changed, 1 insertion(+), 1181 deletions(-)
 delete mode 100644 fs/netfs/output.c

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 4845e655bc39..a97ceb105cd8 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -60,40 +60,6 @@ static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
 	netfs_write_subrequest_terminated(subreq, len ?: err, false);
 }
 
-#if 0 // TODO: Remove
-static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
-{
-	struct p9_fid *fid = subreq->rreq->netfs_priv;
-	int err, len;
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
-	netfs_write_subrequest_terminated(subreq, len ?: err, false);
-}
-
-static void v9fs_upload_to_server_worker(struct work_struct *work)
-{
-	struct netfs_io_subrequest *subreq =
-		container_of(work, struct netfs_io_subrequest, work);
-
-	v9fs_upload_to_server(subreq);
-}
-
-/*
- * Set up write requests for a writeback slice.  We need to add a write request
- * for each write we want to make.
- */
-static void v9fs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size_t len)
-{
-	struct netfs_io_subrequest *subreq;
-
-	subreq = netfs_create_write_request(wreq, NETFS_UPLOAD_TO_SERVER,
-					    start, len, v9fs_upload_to_server_worker);
-	if (subreq)
-		netfs_queue_write_request(subreq);
-}
-#endif
-
 /**
  * v9fs_issue_read - Issue a read from 9P
  * @subreq: The read to make
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 0ead204c84cb..6ef7d4cbc008 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -156,46 +156,6 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	return afs_put_operation(op);
 }
 
-#if 0 // TODO: Remove
-static void afs_upload_to_server(struct netfs_io_subrequest *subreq)
-{
-	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
-	ssize_t ret;
-
-	_enter("%x[%x],%zx",
-	       subreq->rreq->debug_id, subreq->debug_index, subreq->io_iter.count);
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	ret = afs_store_data(vnode, &subreq->io_iter, subreq->start);
-	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len,
-					  false);
-}
-
-static void afs_upload_to_server_worker(struct work_struct *work)
-{
-	struct netfs_io_subrequest *subreq =
-		container_of(work, struct netfs_io_subrequest, work);
-
-	afs_upload_to_server(subreq);
-}
-
-/*
- * Set up write requests for a writeback slice.  We need to add a write request
- * for each write we want to make.
- */
-void afs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size_t len)
-{
-	struct netfs_io_subrequest *subreq;
-
-	_enter("%x,%llx-%llx", wreq->debug_id, start, start + len);
-
-	subreq = netfs_create_write_request(wreq, NETFS_UPLOAD_TO_SERVER,
-					    start, len, afs_upload_to_server_worker);
-	if (subreq)
-		netfs_queue_write_request(subreq);
-}
-#endif
-
 /*
  * Writeback calls this when it finds a folio that needs uploading.  This isn't
  * called if writeback only has copy-to-cache to deal with.
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 945e646cd2db..2da9905abec9 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -575,632 +575,3 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	return ret;
 }
 EXPORT_SYMBOL(netfs_page_mkwrite);
-
-#if 0 // TODO: Remove
-/*
- * Kill all the pages in the given range
- */
-static void netfs_kill_pages(struct address_space *mapping,
-			     loff_t start, loff_t len)
-{
-	struct folio *folio;
-	pgoff_t index = start / PAGE_SIZE;
-	pgoff_t last = (start + len - 1) / PAGE_SIZE, next;
-
-	_enter("%llx-%llx", start, start + len - 1);
-
-	do {
-		_debug("kill %lx (to %lx)", index, last);
-
-		folio = filemap_get_folio(mapping, index);
-		if (IS_ERR(folio)) {
-			next = index + 1;
-			continue;
-		}
-
-		next = folio_next_index(folio);
-
-		trace_netfs_folio(folio, netfs_folio_trace_kill);
-		folio_clear_uptodate(folio);
-		folio_end_writeback(folio);
-		folio_lock(folio);
-		generic_error_remove_folio(mapping, folio);
-		folio_unlock(folio);
-		folio_put(folio);
-
-	} while (index = next, index <= last);
-
-	_leave("");
-}
-
-/*
- * Redirty all the pages in a given range.
- */
-static void netfs_redirty_pages(struct address_space *mapping,
-				loff_t start, loff_t len)
-{
-	struct folio *folio;
-	pgoff_t index = start / PAGE_SIZE;
-	pgoff_t last = (start + len - 1) / PAGE_SIZE, next;
-
-	_enter("%llx-%llx", start, start + len - 1);
-
-	do {
-		_debug("redirty %llx @%llx", len, start);
-
-		folio = filemap_get_folio(mapping, index);
-		if (IS_ERR(folio)) {
-			next = index + 1;
-			continue;
-		}
-
-		next = folio_next_index(folio);
-		trace_netfs_folio(folio, netfs_folio_trace_redirty);
-		filemap_dirty_folio(mapping, folio);
-		folio_end_writeback(folio);
-		folio_put(folio);
-	} while (index = next, index <= last);
-
-	balance_dirty_pages_ratelimited(mapping);
-
-	_leave("");
-}
-
-/*
- * Completion of write to server
- */
-static void netfs_pages_written_back(struct netfs_io_request *wreq)
-{
-	struct address_space *mapping = wreq->mapping;
-	struct netfs_folio *finfo;
-	struct netfs_group *group = NULL;
-	struct folio *folio;
-	pgoff_t last;
-	int gcount = 0;
-
-	XA_STATE(xas, &mapping->i_pages, wreq->start / PAGE_SIZE);
-
-	_enter("%llx-%llx", wreq->start, wreq->start + wreq->len);
-
-	rcu_read_lock();
-
-	last = (wreq->start + wreq->len - 1) / PAGE_SIZE;
-	xas_for_each(&xas, folio, last) {
-		WARN(!folio_test_writeback(folio),
-		     "bad %llx @%llx page %lx %lx\n",
-		     wreq->len, wreq->start, folio->index, last);
-
-		if ((finfo = netfs_folio_info(folio))) {
-			/* Streaming writes cannot be redirtied whilst under
-			 * writeback, so discard the streaming record.
-			 */
-			folio_detach_private(folio);
-			group = finfo->netfs_group;
-			gcount++;
-			trace_netfs_folio(folio, netfs_folio_trace_clear_s);
-			kfree(finfo);
-		} else if ((group = netfs_folio_group(folio))) {
-			/* Need to detach the group pointer if the page didn't
-			 * get redirtied.  If it has been redirtied, then it
-			 * must be within the same group.
-			 */
-			if (folio_test_dirty(folio)) {
-				trace_netfs_folio(folio, netfs_folio_trace_redirtied);
-				goto end_wb;
-			}
-			if (folio_trylock(folio)) {
-				if (!folio_test_dirty(folio)) {
-					folio_detach_private(folio);
-					gcount++;
-					if (group == NETFS_FOLIO_COPY_TO_CACHE)
-						trace_netfs_folio(folio,
-								  netfs_folio_trace_end_copy);
-					else
-						trace_netfs_folio(folio, netfs_folio_trace_clear_g);
-				} else {
-					trace_netfs_folio(folio, netfs_folio_trace_redirtied);
-				}
-				folio_unlock(folio);
-				goto end_wb;
-			}
-
-			xas_pause(&xas);
-			rcu_read_unlock();
-			folio_lock(folio);
-			if (!folio_test_dirty(folio)) {
-				folio_detach_private(folio);
-				gcount++;
-				trace_netfs_folio(folio, netfs_folio_trace_clear_g);
-			} else {
-				trace_netfs_folio(folio, netfs_folio_trace_redirtied);
-			}
-			folio_unlock(folio);
-			rcu_read_lock();
-		} else {
-			trace_netfs_folio(folio, netfs_folio_trace_clear);
-		}
-	end_wb:
-		xas_advance(&xas, folio_next_index(folio) - 1);
-		folio_end_writeback(folio);
-	}
-
-	rcu_read_unlock();
-	netfs_put_group_many(group, gcount);
-	_leave("");
-}
-
-/*
- * Deal with the disposition of the folios that are under writeback to close
- * out the operation.
- */
-static void netfs_cleanup_buffered_write(struct netfs_io_request *wreq)
-{
-	struct address_space *mapping = wreq->mapping;
-
-	_enter("");
-
-	switch (wreq->error) {
-	case 0:
-		netfs_pages_written_back(wreq);
-		break;
-
-	default:
-		pr_notice("R=%08x Unexpected error %d\n", wreq->debug_id, wreq->error);
-		fallthrough;
-	case -EACCES:
-	case -EPERM:
-	case -ENOKEY:
-	case -EKEYEXPIRED:
-	case -EKEYREJECTED:
-	case -EKEYREVOKED:
-	case -ENETRESET:
-	case -EDQUOT:
-	case -ENOSPC:
-		netfs_redirty_pages(mapping, wreq->start, wreq->len);
-		break;
-
-	case -EROFS:
-	case -EIO:
-	case -EREMOTEIO:
-	case -EFBIG:
-	case -ENOENT:
-	case -ENOMEDIUM:
-	case -ENXIO:
-		netfs_kill_pages(mapping, wreq->start, wreq->len);
-		break;
-	}
-
-	if (wreq->error)
-		mapping_set_error(mapping, wreq->error);
-	if (wreq->netfs_ops->done)
-		wreq->netfs_ops->done(wreq);
-}
-
-/*
- * Extend the region to be written back to include subsequent contiguously
- * dirty pages if possible, but don't sleep while doing so.
- *
- * If this page holds new content, then we can include filler zeros in the
- * writeback.
- */
-static void netfs_extend_writeback(struct address_space *mapping,
-				   struct netfs_group *group,
-				   struct xa_state *xas,
-				   long *_count,
-				   loff_t start,
-				   loff_t max_len,
-				   size_t *_len,
-				   size_t *_top)
-{
-	struct netfs_folio *finfo;
-	struct folio_batch fbatch;
-	struct folio *folio;
-	unsigned int i;
-	pgoff_t index = (start + *_len) / PAGE_SIZE;
-	size_t len;
-	void *priv;
-	bool stop = true;
-
-	folio_batch_init(&fbatch);
-
-	do {
-		/* Firstly, we gather up a batch of contiguous dirty pages
-		 * under the RCU read lock - but we can't clear the dirty flags
-		 * there if any of those pages are mapped.
-		 */
-		rcu_read_lock();
-
-		xas_for_each(xas, folio, ULONG_MAX) {
-			stop = true;
-			if (xas_retry(xas, folio))
-				continue;
-			if (xa_is_value(folio))
-				break;
-			if (folio->index != index) {
-				xas_reset(xas);
-				break;
-			}
-
-			if (!folio_try_get_rcu(folio)) {
-				xas_reset(xas);
-				continue;
-			}
-
-			/* Has the folio moved or been split? */
-			if (unlikely(folio != xas_reload(xas))) {
-				folio_put(folio);
-				xas_reset(xas);
-				break;
-			}
-
-			if (!folio_trylock(folio)) {
-				folio_put(folio);
-				xas_reset(xas);
-				break;
-			}
-			if (!folio_test_dirty(folio) ||
-			    folio_test_writeback(folio)) {
-				folio_unlock(folio);
-				folio_put(folio);
-				xas_reset(xas);
-				break;
-			}
-
-			stop = false;
-			len = folio_size(folio);
-			priv = folio_get_private(folio);
-			if ((const struct netfs_group *)priv != group) {
-				stop = true;
-				finfo = netfs_folio_info(folio);
-				if (!finfo ||
-				    finfo->netfs_group != group ||
-				    finfo->dirty_offset > 0) {
-					folio_unlock(folio);
-					folio_put(folio);
-					xas_reset(xas);
-					break;
-				}
-				len = finfo->dirty_len;
-			}
-
-			*_top += folio_size(folio);
-			index += folio_nr_pages(folio);
-			*_count -= folio_nr_pages(folio);
-			*_len += len;
-			if (*_len >= max_len || *_count <= 0)
-				stop = true;
-
-			if (!folio_batch_add(&fbatch, folio))
-				break;
-			if (stop)
-				break;
-		}
-
-		xas_pause(xas);
-		rcu_read_unlock();
-
-		/* Now, if we obtained any folios, we can shift them to being
-		 * writable and mark them for caching.
-		 */
-		if (!folio_batch_count(&fbatch))
-			break;
-
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-			folio = fbatch.folios[i];
-			if (group == NETFS_FOLIO_COPY_TO_CACHE)
-				trace_netfs_folio(folio, netfs_folio_trace_copy_plus);
-			else
-				trace_netfs_folio(folio, netfs_folio_trace_store_plus);
-
-			if (!folio_clear_dirty_for_io(folio))
-				BUG();
-			folio_start_writeback(folio);
-			folio_unlock(folio);
-		}
-
-		folio_batch_release(&fbatch);
-		cond_resched();
-	} while (!stop);
-}
-
-/*
- * Synchronously write back the locked page and any subsequent non-locked dirty
- * pages.
- */
-static ssize_t netfs_write_back_from_locked_folio(struct address_space *mapping,
-						  struct writeback_control *wbc,
-						  struct netfs_group *group,
-						  struct xa_state *xas,
-						  struct folio *folio,
-						  unsigned long long start,
-						  unsigned long long end)
-{
-	struct netfs_io_request *wreq;
-	struct netfs_folio *finfo;
-	struct netfs_inode *ctx = netfs_inode(mapping->host);
-	unsigned long long i_size = i_size_read(&ctx->inode);
-	size_t len, max_len;
-	long count = wbc->nr_to_write;
-	int ret;
-
-	_enter(",%lx,%llx-%llx", folio->index, start, end);
-
-	wreq = netfs_alloc_request(mapping, NULL, start, folio_size(folio),
-				   group == NETFS_FOLIO_COPY_TO_CACHE ?
-				   NETFS_COPY_TO_CACHE : NETFS_WRITEBACK);
-	if (IS_ERR(wreq)) {
-		folio_unlock(folio);
-		return PTR_ERR(wreq);
-	}
-
-	if (!folio_clear_dirty_for_io(folio))
-		BUG();
-	folio_start_writeback(folio);
-
-	count -= folio_nr_pages(folio);
-
-	/* Find all consecutive lockable dirty pages that have contiguous
-	 * written regions, stopping when we find a page that is not
-	 * immediately lockable, is not dirty or is missing, or we reach the
-	 * end of the range.
-	 */
-	if (group == NETFS_FOLIO_COPY_TO_CACHE)
-		trace_netfs_folio(folio, netfs_folio_trace_copy);
-	else
-		trace_netfs_folio(folio, netfs_folio_trace_store);
-
-	len = wreq->len;
-	finfo = netfs_folio_info(folio);
-	if (finfo) {
-		start += finfo->dirty_offset;
-		if (finfo->dirty_offset + finfo->dirty_len != len) {
-			len = finfo->dirty_len;
-			goto cant_expand;
-		}
-		len = finfo->dirty_len;
-	}
-
-	if (start < i_size) {
-		/* Trim the write to the EOF; the extra data is ignored.  Also
-		 * put an upper limit on the size of a single storedata op.
-		 */
-		max_len = 65536 * 4096;
-		max_len = min_t(unsigned long long, max_len, end - start + 1);
-		max_len = min_t(unsigned long long, max_len, i_size - start);
-
-		if (len < max_len)
-			netfs_extend_writeback(mapping, group, xas, &count, start,
-					       max_len, &len, &wreq->upper_len);
-	}
-
-cant_expand:
-	len = min_t(unsigned long long, len, i_size - start);
-
-	/* We now have a contiguous set of dirty pages, each with writeback
-	 * set; the first page is still locked at this point, but all the rest
-	 * have been unlocked.
-	 */
-	folio_unlock(folio);
-	wreq->start = start;
-	wreq->len = len;
-
-	if (start < i_size) {
-		_debug("write back %zx @%llx [%llx]", len, start, i_size);
-
-		/* Speculatively write to the cache.  We have to fix this up
-		 * later if the store fails.
-		 */
-		wreq->cleanup = netfs_cleanup_buffered_write;
-
-		iov_iter_xarray(&wreq->iter, ITER_SOURCE, &mapping->i_pages, start,
-				wreq->upper_len);
-		if (group != NETFS_FOLIO_COPY_TO_CACHE) {
-			__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-			ret = netfs_begin_write(wreq, true, netfs_write_trace_writeback);
-		} else {
-			ret = netfs_begin_write(wreq, true, netfs_write_trace_copy_to_cache);
-		}
-		if (ret == 0 || ret == -EIOCBQUEUED)
-			wbc->nr_to_write -= len / PAGE_SIZE;
-	} else {
-		_debug("write discard %zx @%llx [%llx]", len, start, i_size);
-
-		/* The dirty region was entirely beyond the EOF. */
-		netfs_pages_written_back(wreq);
-		ret = 0;
-	}
-
-	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
-	_leave(" = 1");
-	return 1;
-}
-
-/*
- * Write a region of pages back to the server
- */
-static ssize_t netfs_writepages_begin(struct address_space *mapping,
-				      struct writeback_control *wbc,
-				      struct netfs_group *group,
-				      struct xa_state *xas,
-				      unsigned long long *_start,
-				      unsigned long long end)
-{
-	const struct netfs_folio *finfo;
-	struct folio *folio;
-	unsigned long long start = *_start;
-	ssize_t ret;
-	void *priv;
-	int skips = 0;
-
-	_enter("%llx,%llx,", start, end);
-
-search_again:
-	/* Find the first dirty page in the group. */
-	rcu_read_lock();
-
-	for (;;) {
-		folio = xas_find_marked(xas, end / PAGE_SIZE, PAGECACHE_TAG_DIRTY);
-		if (xas_retry(xas, folio) || xa_is_value(folio))
-			continue;
-		if (!folio)
-			break;
-
-		if (!folio_try_get_rcu(folio)) {
-			xas_reset(xas);
-			continue;
-		}
-
-		if (unlikely(folio != xas_reload(xas))) {
-			folio_put(folio);
-			xas_reset(xas);
-			continue;
-		}
-
-		/* Skip any dirty folio that's not in the group of interest. */
-		priv = folio_get_private(folio);
-		if ((const struct netfs_group *)priv == NETFS_FOLIO_COPY_TO_CACHE) {
-			group = NETFS_FOLIO_COPY_TO_CACHE;
-		} else if ((const struct netfs_group *)priv != group) {
-			finfo = __netfs_folio_info(priv);
-			if (!finfo || finfo->netfs_group != group) {
-				folio_put(folio);
-				continue;
-			}
-		}
-
-		xas_pause(xas);
-		break;
-	}
-	rcu_read_unlock();
-	if (!folio)
-		return 0;
-
-	start = folio_pos(folio); /* May regress with THPs */
-
-	_debug("wback %lx", folio->index);
-
-	/* At this point we hold neither the i_pages lock nor the page lock:
-	 * the page may be truncated or invalidated (changing page->mapping to
-	 * NULL), or even swizzled back from swapper_space to tmpfs file
-	 * mapping
-	 */
-lock_again:
-	if (wbc->sync_mode != WB_SYNC_NONE) {
-		ret = folio_lock_killable(folio);
-		if (ret < 0)
-			return ret;
-	} else {
-		if (!folio_trylock(folio))
-			goto search_again;
-	}
-
-	if (folio->mapping != mapping ||
-	    !folio_test_dirty(folio)) {
-		start += folio_size(folio);
-		folio_unlock(folio);
-		goto search_again;
-	}
-
-	if (folio_test_writeback(folio)) {
-		folio_unlock(folio);
-		if (wbc->sync_mode != WB_SYNC_NONE) {
-			folio_wait_writeback(folio);
-			goto lock_again;
-		}
-
-		start += folio_size(folio);
-		if (wbc->sync_mode == WB_SYNC_NONE) {
-			if (skips >= 5 || need_resched()) {
-				ret = 0;
-				goto out;
-			}
-			skips++;
-		}
-		goto search_again;
-	}
-
-	ret = netfs_write_back_from_locked_folio(mapping, wbc, group, xas,
-						 folio, start, end);
-out:
-	if (ret > 0)
-		*_start = start + ret;
-	_leave(" = %zd [%llx]", ret, *_start);
-	return ret;
-}
-
-/*
- * Write a region of pages back to the server
- */
-static int netfs_writepages_region(struct address_space *mapping,
-				   struct writeback_control *wbc,
-				   struct netfs_group *group,
-				   unsigned long long *_start,
-				   unsigned long long end)
-{
-	ssize_t ret;
-
-	XA_STATE(xas, &mapping->i_pages, *_start / PAGE_SIZE);
-
-	do {
-		ret = netfs_writepages_begin(mapping, wbc, group, &xas,
-					     _start, end);
-		if (ret > 0 && wbc->nr_to_write > 0)
-			cond_resched();
-	} while (ret > 0 && wbc->nr_to_write > 0);
-
-	return ret > 0 ? 0 : ret;
-}
-
-/*
- * write some of the pending data back to the server
- */
-int netfs_writepages(struct address_space *mapping,
-		     struct writeback_control *wbc)
-{
-	struct netfs_group *group = NULL;
-	loff_t start, end;
-	int ret;
-
-	_enter("");
-
-	/* We have to be careful as we can end up racing with setattr()
-	 * truncating the pagecache since the caller doesn't take a lock here
-	 * to prevent it.
-	 */
-
-	if (wbc->range_cyclic && mapping->writeback_index) {
-		start = mapping->writeback_index * PAGE_SIZE;
-		ret = netfs_writepages_region(mapping, wbc, group,
-					      &start, LLONG_MAX);
-		if (ret < 0)
-			goto out;
-
-		if (wbc->nr_to_write <= 0) {
-			mapping->writeback_index = start / PAGE_SIZE;
-			goto out;
-		}
-
-		start = 0;
-		end = mapping->writeback_index * PAGE_SIZE;
-		mapping->writeback_index = 0;
-		ret = netfs_writepages_region(mapping, wbc, group, &start, end);
-		if (ret == 0)
-			mapping->writeback_index = start / PAGE_SIZE;
-	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
-		start = 0;
-		ret = netfs_writepages_region(mapping, wbc, group,
-					      &start, LLONG_MAX);
-		if (wbc->nr_to_write > 0 && ret == 0)
-			mapping->writeback_index = start / PAGE_SIZE;
-	} else {
-		start = wbc->range_start;
-		ret = netfs_writepages_region(mapping, wbc, group,
-					      &start, wbc->range_end);
-	}
-
-out:
-	_leave(" = %d", ret);
-	return ret;
-}
-EXPORT_SYMBOL(netfs_writepages);
-#endif
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 330ba7cb3f10..e4a9cf7cd234 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -37,7 +37,7 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 	size_t len = iov_iter_count(iter);
 	bool async = !is_sync_kiocb(iocb);
 
-	_enter("");
+	_enter("%lx", iov_iter_count(iter));
 
 	/* We're going to need a bounce buffer if what we transmit is going to
 	 * be different in some way to the source buffer, e.g. because it gets
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
deleted file mode 100644
index 85374322f10f..000000000000
--- a/fs/netfs/output.c
+++ /dev/null
@@ -1,477 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Network filesystem high-level write support.
- *
- * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/pagemap.h>
-#include <linux/slab.h>
-#include <linux/writeback.h>
-#include <linux/pagevec.h>
-#include "internal.h"
-
-/**
- * netfs_create_write_request - Create a write operation.
- * @wreq: The write request this is storing from.
- * @dest: The destination type
- * @start: Start of the region this write will modify
- * @len: Length of the modification
- * @worker: The worker function to handle the write(s)
- *
- * Allocate a write operation, set it up and add it to the list on a write
- * request.
- */
-struct netfs_io_subrequest *netfs_create_write_request(struct netfs_io_request *wreq,
-						       enum netfs_io_source dest,
-						       loff_t start, size_t len,
-						       work_func_t worker)
-{
-	struct netfs_io_subrequest *subreq;
-
-	subreq = netfs_alloc_subrequest(wreq);
-	if (subreq) {
-		INIT_WORK(&subreq->work, worker);
-		subreq->source	= dest;
-		subreq->start	= start;
-		subreq->len	= len;
-
-		switch (subreq->source) {
-		case NETFS_UPLOAD_TO_SERVER:
-			netfs_stat(&netfs_n_wh_upload);
-			break;
-		case NETFS_WRITE_TO_CACHE:
-			netfs_stat(&netfs_n_wh_write);
-			break;
-		default:
-			BUG();
-		}
-
-		subreq->io_iter = wreq->io_iter;
-		iov_iter_advance(&subreq->io_iter, subreq->start - wreq->start);
-		iov_iter_truncate(&subreq->io_iter, subreq->len);
-
-		trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
-				     refcount_read(&subreq->ref),
-				     netfs_sreq_trace_new);
-		atomic_inc(&wreq->nr_outstanding);
-		list_add_tail(&subreq->rreq_link, &wreq->subrequests);
-		trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-	}
-
-	return subreq;
-}
-EXPORT_SYMBOL(netfs_create_write_request);
-
-/*
- * Process a completed write request once all the component operations have
- * been completed.
- */
-static void netfs_write_terminated(struct netfs_io_request *wreq, bool was_async)
-{
-	struct netfs_io_subrequest *subreq;
-	struct netfs_inode *ctx = netfs_inode(wreq->inode);
-	size_t transferred = 0;
-
-	_enter("R=%x[]", wreq->debug_id);
-
-	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
-
-	list_for_each_entry(subreq, &wreq->subrequests, rreq_link) {
-		if (subreq->error || subreq->transferred == 0)
-			break;
-		transferred += subreq->transferred;
-		if (subreq->transferred < subreq->len)
-			break;
-	}
-	wreq->transferred = transferred;
-
-	list_for_each_entry(subreq, &wreq->subrequests, rreq_link) {
-		if (!subreq->error)
-			continue;
-		switch (subreq->source) {
-		case NETFS_UPLOAD_TO_SERVER:
-			/* Depending on the type of failure, this may prevent
-			 * writeback completion unless we're in disconnected
-			 * mode.
-			 */
-			if (!wreq->error)
-				wreq->error = subreq->error;
-			break;
-
-		case NETFS_WRITE_TO_CACHE:
-			/* Failure doesn't prevent writeback completion unless
-			 * we're in disconnected mode.
-			 */
-			if (subreq->error != -ENOBUFS)
-				ctx->ops->invalidate_cache(wreq);
-			break;
-
-		default:
-			WARN_ON_ONCE(1);
-			if (!wreq->error)
-				wreq->error = -EIO;
-			return;
-		}
-	}
-
-	wreq->cleanup(wreq);
-
-	if (wreq->origin == NETFS_DIO_WRITE &&
-	    wreq->mapping->nrpages) {
-		pgoff_t first = wreq->start >> PAGE_SHIFT;
-		pgoff_t last = (wreq->start + wreq->transferred - 1) >> PAGE_SHIFT;
-		invalidate_inode_pages2_range(wreq->mapping, first, last);
-	}
-
-	if (wreq->origin == NETFS_DIO_WRITE)
-		inode_dio_end(wreq->inode);
-
-	_debug("finished");
-	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
-	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
-
-	if (wreq->iocb) {
-		wreq->iocb->ki_pos += transferred;
-		if (wreq->iocb->ki_complete)
-			wreq->iocb->ki_complete(
-				wreq->iocb, wreq->error ? wreq->error : transferred);
-	}
-
-	netfs_clear_subrequests(wreq, was_async);
-	netfs_put_request(wreq, was_async, netfs_rreq_trace_put_complete);
-}
-
-/*
- * Deal with the completion of writing the data to the cache.
- */
-void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
-				       bool was_async)
-{
-	struct netfs_io_subrequest *subreq = _op;
-	struct netfs_io_request *wreq = subreq->rreq;
-	unsigned int u;
-
-	_enter("%x[%x] %zd", wreq->debug_id, subreq->debug_index, transferred_or_error);
-
-	switch (subreq->source) {
-	case NETFS_UPLOAD_TO_SERVER:
-		netfs_stat(&netfs_n_wh_upload_done);
-		break;
-	case NETFS_WRITE_TO_CACHE:
-		netfs_stat(&netfs_n_wh_write_done);
-		break;
-	case NETFS_INVALID_WRITE:
-		break;
-	default:
-		BUG();
-	}
-
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		subreq->error = transferred_or_error;
-		trace_netfs_failure(wreq, subreq, transferred_or_error,
-				    netfs_fail_write);
-		goto failed;
-	}
-
-	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
-		 "Subreq excess write: R%x[%x] %zd > %zu - %zu",
-		 wreq->debug_id, subreq->debug_index,
-		 transferred_or_error, subreq->len, subreq->transferred))
-		transferred_or_error = subreq->len - subreq->transferred;
-
-	subreq->error = 0;
-	subreq->transferred += transferred_or_error;
-
-	if (iov_iter_count(&subreq->io_iter) != subreq->len - subreq->transferred)
-		pr_warn("R=%08x[%u] ITER POST-MISMATCH %zx != %zx-%zx %x\n",
-			wreq->debug_id, subreq->debug_index,
-			iov_iter_count(&subreq->io_iter), subreq->len,
-			subreq->transferred, subreq->io_iter.iter_type);
-
-	if (subreq->transferred < subreq->len)
-		goto incomplete;
-
-	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-out:
-	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
-
-	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
-	u = atomic_dec_return(&wreq->nr_outstanding);
-	if (u == 0)
-		netfs_write_terminated(wreq, was_async);
-	else if (u == 1)
-		wake_up_var(&wreq->nr_outstanding);
-
-	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
-	return;
-
-incomplete:
-	if (transferred_or_error == 0) {
-		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
-			subreq->error = -ENODATA;
-			goto failed;
-		}
-	} else {
-		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-	}
-
-	__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
-	set_bit(NETFS_RREQ_INCOMPLETE_IO, &wreq->flags);
-	goto out;
-
-failed:
-	switch (subreq->source) {
-	case NETFS_WRITE_TO_CACHE:
-		netfs_stat(&netfs_n_wh_write_failed);
-		set_bit(NETFS_RREQ_INCOMPLETE_IO, &wreq->flags);
-		break;
-	case NETFS_UPLOAD_TO_SERVER:
-		netfs_stat(&netfs_n_wh_upload_failed);
-		set_bit(NETFS_RREQ_FAILED, &wreq->flags);
-		wreq->error = subreq->error;
-		break;
-	default:
-		break;
-	}
-	goto out;
-}
-EXPORT_SYMBOL(netfs_write_subrequest_terminated);
-
-static void netfs_write_to_cache_op(struct netfs_io_subrequest *subreq)
-{
-	struct netfs_io_request *wreq = subreq->rreq;
-	struct netfs_cache_resources *cres = &wreq->cache_resources;
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-
-	cres->ops->write(cres, subreq->start, &subreq->io_iter,
-			 netfs_write_subrequest_terminated, subreq);
-}
-
-static void netfs_write_to_cache_op_worker(struct work_struct *work)
-{
-	struct netfs_io_subrequest *subreq =
-		container_of(work, struct netfs_io_subrequest, work);
-
-	netfs_write_to_cache_op(subreq);
-}
-
-/**
- * netfs_queue_write_request - Queue a write request for attention
- * @subreq: The write request to be queued
- *
- * Queue the specified write request for processing by a worker thread.  We
- * pass the caller's ref on the request to the worker thread.
- */
-void netfs_queue_write_request(struct netfs_io_subrequest *subreq)
-{
-	if (!queue_work(system_unbound_wq, &subreq->work))
-		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_wip);
-}
-EXPORT_SYMBOL(netfs_queue_write_request);
-
-/*
- * Set up a op for writing to the cache.
- */
-static void netfs_set_up_write_to_cache(struct netfs_io_request *wreq)
-{
-	struct netfs_cache_resources *cres = &wreq->cache_resources;
-	struct netfs_io_subrequest *subreq;
-	struct netfs_inode *ctx = netfs_inode(wreq->inode);
-	struct fscache_cookie *cookie = netfs_i_cookie(ctx);
-	loff_t start = wreq->start;
-	size_t len = wreq->len;
-	int ret;
-
-	if (!fscache_cookie_enabled(cookie)) {
-		clear_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags);
-		return;
-	}
-
-	_debug("write to cache");
-	ret = fscache_begin_write_operation(cres, cookie);
-	if (ret < 0)
-		return;
-
-	ret = cres->ops->prepare_write(cres, &start, &len, wreq->upper_len,
-				       i_size_read(wreq->inode), true);
-	if (ret < 0)
-		return;
-
-	subreq = netfs_create_write_request(wreq, NETFS_WRITE_TO_CACHE, start, len,
-					    netfs_write_to_cache_op_worker);
-	if (!subreq)
-		return;
-
-	netfs_write_to_cache_op(subreq);
-}
-
-/*
- * Begin the process of writing out a chunk of data.
- *
- * We are given a write request that holds a series of dirty regions and
- * (partially) covers a sequence of folios, all of which are present.  The
- * pages must have been marked as writeback as appropriate.
- *
- * We need to perform the following steps:
- *
- * (1) If encrypting, create an output buffer and encrypt each block of the
- *     data into it, otherwise the output buffer will point to the original
- *     folios.
- *
- * (2) If the data is to be cached, set up a write op for the entire output
- *     buffer to the cache, if the cache wants to accept it.
- *
- * (3) If the data is to be uploaded (ie. not merely cached):
- *
- *     (a) If the data is to be compressed, create a compression buffer and
- *         compress the data into it.
- *
- *     (b) For each destination we want to upload to, set up write ops to write
- *         to that destination.  We may need multiple writes if the data is not
- *         contiguous or the span exceeds wsize for a server.
- */
-int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
-		      enum netfs_write_trace what)
-{
-	struct netfs_inode *ctx = netfs_inode(wreq->inode);
-
-	_enter("R=%x %llx-%llx f=%lx",
-	       wreq->debug_id, wreq->start, wreq->start + wreq->len - 1,
-	       wreq->flags);
-
-	trace_netfs_write(wreq, what);
-	if (wreq->len == 0 || wreq->iter.count == 0) {
-		pr_err("Zero-sized write [R=%x]\n", wreq->debug_id);
-		return -EIO;
-	}
-
-	if (wreq->origin == NETFS_DIO_WRITE)
-		inode_dio_begin(wreq->inode);
-
-	wreq->io_iter = wreq->iter;
-
-	/* ->outstanding > 0 carries a ref */
-	netfs_get_request(wreq, netfs_rreq_trace_get_for_outstanding);
-	atomic_set(&wreq->nr_outstanding, 1);
-
-	/* Start the encryption/compression going.  We can do that in the
-	 * background whilst we generate a list of write ops that we want to
-	 * perform.
-	 */
-	// TODO: Encrypt or compress the region as appropriate
-
-	/* We need to write all of the region to the cache */
-	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
-		netfs_set_up_write_to_cache(wreq);
-
-	/* However, we don't necessarily write all of the region to the server.
-	 * Caching of reads is being managed this way also.
-	 */
-	if (test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
-		ctx->ops->create_write_requests(wreq, wreq->start, wreq->len);
-
-	if (atomic_dec_and_test(&wreq->nr_outstanding))
-		netfs_write_terminated(wreq, false);
-
-	if (!may_wait)
-		return -EIOCBQUEUED;
-
-	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
-		    TASK_UNINTERRUPTIBLE);
-	return wreq->error;
-}
-
-/*
- * Begin a write operation for writing through the pagecache.
- */
-struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len)
-{
-	struct netfs_io_request *wreq;
-	struct file *file = iocb->ki_filp;
-
-	wreq = netfs_alloc_request(file->f_mapping, file, iocb->ki_pos, len,
-				   NETFS_WRITETHROUGH);
-	if (IS_ERR(wreq))
-		return wreq;
-
-	trace_netfs_write(wreq, netfs_write_trace_writethrough);
-
-	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-	iov_iter_xarray(&wreq->iter, ITER_SOURCE, &wreq->mapping->i_pages, wreq->start, 0);
-	wreq->io_iter = wreq->iter;
-
-	/* ->outstanding > 0 carries a ref */
-	netfs_get_request(wreq, netfs_rreq_trace_get_for_outstanding);
-	atomic_set(&wreq->nr_outstanding, 1);
-	return wreq;
-}
-
-static void netfs_submit_writethrough(struct netfs_io_request *wreq, bool final)
-{
-	struct netfs_inode *ictx = netfs_inode(wreq->inode);
-	unsigned long long start;
-	size_t len;
-
-	if (!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
-		return;
-
-	start = wreq->start + wreq->submitted;
-	len = wreq->iter.count - wreq->submitted;
-	if (!final) {
-		len /= wreq->wsize; /* Round to number of maximum packets */
-		len *= wreq->wsize;
-	}
-
-	ictx->ops->create_write_requests(wreq, start, len);
-	wreq->submitted += len;
-}
-
-/*
- * Advance the state of the write operation used when writing through the
- * pagecache.  Data has been copied into the pagecache that we need to append
- * to the request.  If we've added more than wsize then we need to create a new
- * subrequest.
- */
-int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t copied, bool to_page_end)
-{
-	_enter("ic=%zu sb=%llu ws=%u cp=%zu tp=%u",
-	       wreq->iter.count, wreq->submitted, wreq->wsize, copied, to_page_end);
-
-	wreq->iter.count += copied;
-	wreq->io_iter.count += copied;
-	if (to_page_end && wreq->io_iter.count - wreq->submitted >= wreq->wsize)
-		netfs_submit_writethrough(wreq, false);
-
-	return wreq->error;
-}
-
-/*
- * End a write operation used when writing through the pagecache.
- */
-int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb)
-{
-	int ret = -EIOCBQUEUED;
-
-	_enter("ic=%zu sb=%llu ws=%u",
-	       wreq->iter.count, wreq->submitted, wreq->wsize);
-
-	if (wreq->submitted < wreq->io_iter.count)
-		netfs_submit_writethrough(wreq, true);
-
-	if (atomic_dec_and_test(&wreq->nr_outstanding))
-		netfs_write_terminated(wreq, false);
-
-	if (is_sync_kiocb(iocb)) {
-		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
-			    TASK_UNINTERRUPTIBLE);
-		ret = wreq->error;
-	}
-
-	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
-	return ret;
-}



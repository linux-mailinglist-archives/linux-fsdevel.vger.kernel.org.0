Return-Path: <linux-fsdevel+bounces-6730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CA81B858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753E728AC6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DB95820F;
	Thu, 21 Dec 2023 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdsVjBX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759DE55E5E
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3b/58DKZf6q2DKR6s5ZzqWVaDITrZgP9V+mka10flk=;
	b=OdsVjBX2M42Bj/XJ/b/MufBG0az8yaRLnIbcU8wYPjz+s/Ziy2vE7N7MpmQytqcrsj0AtO
	iAa3zWK7+I+0AGCO+OZ7TrjvmWoN6PAAsHYcQYAmBc7qA+hdxa3f2QjM/+lhPZCIF6naiM
	EqoIH0I9K9cNnNdCiUevSmB8XmxcqKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-dRUH2M3gOniG59WajBpQvA-1; Thu, 21 Dec 2023 08:26:16 -0500
X-MC-Unique: dRUH2M3gOniG59WajBpQvA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AFB6868A01;
	Thu, 21 Dec 2023 13:26:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DDD43492BC6;
	Thu, 21 Dec 2023 13:26:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 34/40] netfs: Provide a writepages implementation
Date: Thu, 21 Dec 2023 13:23:29 +0000
Message-ID: <20231221132400.1601991-35-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-1-dhowells@redhat.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Provide an implementation of writepages for network filesystems to delegate
to.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    Changes
    =======
    ver #5)
     - Use netfs_folio_info() rather than open-coding pointer mangling.
     - Use folio_get_private() rather than using folio->private.
     - Don't check the folio private pointer before taking the folio ref during
       writeback pagecache RCU xarray walk.

 fs/netfs/buffered_write.c | 636 ++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h     |   2 +
 2 files changed, 638 insertions(+)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 70cb8e98d068..c078826f7fe6 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -32,6 +32,18 @@ static void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group
 		folio_attach_private(folio, netfs_get_group(netfs_group));
 }
 
+#if IS_ENABLED(CONFIG_FSCACHE)
+static void netfs_folio_start_fscache(bool caching, struct folio *folio)
+{
+	if (caching)
+		folio_start_fscache(folio);
+}
+#else
+static void netfs_folio_start_fscache(bool caching, struct folio *folio)
+{
+}
+#endif
+
 /*
  * Decide how we should modify a folio.  We might be attempting to do
  * write-streaming, in which case we don't want to a local RMW cycle if we can
@@ -475,3 +487,627 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	return ret;
 }
 EXPORT_SYMBOL(netfs_page_mkwrite);
+
+/*
+ * Kill all the pages in the given range
+ */
+static void netfs_kill_pages(struct address_space *mapping,
+			     loff_t start, loff_t len)
+{
+	struct folio *folio;
+	pgoff_t index = start / PAGE_SIZE;
+	pgoff_t last = (start + len - 1) / PAGE_SIZE, next;
+
+	_enter("%llx-%llx", start, start + len - 1);
+
+	do {
+		_debug("kill %lx (to %lx)", index, last);
+
+		folio = filemap_get_folio(mapping, index);
+		if (IS_ERR(folio)) {
+			next = index + 1;
+			continue;
+		}
+
+		next = folio_next_index(folio);
+
+		trace_netfs_folio(folio, netfs_folio_trace_kill);
+		folio_clear_uptodate(folio);
+		if (folio_test_fscache(folio))
+			folio_end_fscache(folio);
+		folio_end_writeback(folio);
+		folio_lock(folio);
+		generic_error_remove_page(mapping, &folio->page);
+		folio_unlock(folio);
+		folio_put(folio);
+
+	} while (index = next, index <= last);
+
+	_leave("");
+}
+
+/*
+ * Redirty all the pages in a given range.
+ */
+static void netfs_redirty_pages(struct address_space *mapping,
+				loff_t start, loff_t len)
+{
+	struct folio *folio;
+	pgoff_t index = start / PAGE_SIZE;
+	pgoff_t last = (start + len - 1) / PAGE_SIZE, next;
+
+	_enter("%llx-%llx", start, start + len - 1);
+
+	do {
+		_debug("redirty %llx @%llx", len, start);
+
+		folio = filemap_get_folio(mapping, index);
+		if (IS_ERR(folio)) {
+			next = index + 1;
+			continue;
+		}
+
+		next = folio_next_index(folio);
+		trace_netfs_folio(folio, netfs_folio_trace_redirty);
+		filemap_dirty_folio(mapping, folio);
+		if (folio_test_fscache(folio))
+			folio_end_fscache(folio);
+		folio_end_writeback(folio);
+		folio_put(folio);
+	} while (index = next, index <= last);
+
+	balance_dirty_pages_ratelimited(mapping);
+
+	_leave("");
+}
+
+/*
+ * Completion of write to server
+ */
+static void netfs_pages_written_back(struct netfs_io_request *wreq)
+{
+	struct address_space *mapping = wreq->mapping;
+	struct netfs_folio *finfo;
+	struct netfs_group *group = NULL;
+	struct folio *folio;
+	pgoff_t last;
+	int gcount = 0;
+
+	XA_STATE(xas, &mapping->i_pages, wreq->start / PAGE_SIZE);
+
+	_enter("%llx-%llx", wreq->start, wreq->start + wreq->len);
+
+	rcu_read_lock();
+
+	last = (wreq->start + wreq->len - 1) / PAGE_SIZE;
+	xas_for_each(&xas, folio, last) {
+		WARN(!folio_test_writeback(folio),
+		     "bad %zx @%llx page %lx %lx\n",
+		     wreq->len, wreq->start, folio_index(folio), last);
+
+		if ((finfo = netfs_folio_info(folio))) {
+			/* Streaming writes cannot be redirtied whilst under
+			 * writeback, so discard the streaming record.
+			 */
+			folio_detach_private(folio);
+			group = finfo->netfs_group;
+			gcount++;
+			trace_netfs_folio(folio, netfs_folio_trace_clear_s);
+			kfree(finfo);
+		} else if ((group = netfs_folio_group(folio))) {
+			/* Need to detach the group pointer if the page didn't
+			 * get redirtied.  If it has been redirtied, then it
+			 * must be within the same group.
+			 */
+			if (folio_test_dirty(folio)) {
+				trace_netfs_folio(folio, netfs_folio_trace_redirtied);
+				goto end_wb;
+			}
+			if (folio_trylock(folio)) {
+				if (!folio_test_dirty(folio)) {
+					folio_detach_private(folio);
+					gcount++;
+					trace_netfs_folio(folio, netfs_folio_trace_clear_g);
+				} else {
+					trace_netfs_folio(folio, netfs_folio_trace_redirtied);
+				}
+				folio_unlock(folio);
+				goto end_wb;
+			}
+
+			xas_pause(&xas);
+			rcu_read_unlock();
+			folio_lock(folio);
+			if (!folio_test_dirty(folio)) {
+				folio_detach_private(folio);
+				gcount++;
+				trace_netfs_folio(folio, netfs_folio_trace_clear_g);
+			} else {
+				trace_netfs_folio(folio, netfs_folio_trace_redirtied);
+			}
+			folio_unlock(folio);
+			rcu_read_lock();
+		} else {
+			trace_netfs_folio(folio, netfs_folio_trace_clear);
+		}
+	end_wb:
+		if (folio_test_fscache(folio))
+			folio_end_fscache(folio);
+		folio_end_writeback(folio);
+	}
+
+	rcu_read_unlock();
+	netfs_put_group_many(group, gcount);
+	_leave("");
+}
+
+/*
+ * Deal with the disposition of the folios that are under writeback to close
+ * out the operation.
+ */
+static void netfs_cleanup_buffered_write(struct netfs_io_request *wreq)
+{
+	struct address_space *mapping = wreq->mapping;
+
+	_enter("");
+
+	switch (wreq->error) {
+	case 0:
+		netfs_pages_written_back(wreq);
+		break;
+
+	default:
+		pr_notice("R=%08x Unexpected error %d\n", wreq->debug_id, wreq->error);
+		fallthrough;
+	case -EACCES:
+	case -EPERM:
+	case -ENOKEY:
+	case -EKEYEXPIRED:
+	case -EKEYREJECTED:
+	case -EKEYREVOKED:
+	case -ENETRESET:
+	case -EDQUOT:
+	case -ENOSPC:
+		netfs_redirty_pages(mapping, wreq->start, wreq->len);
+		break;
+
+	case -EROFS:
+	case -EIO:
+	case -EREMOTEIO:
+	case -EFBIG:
+	case -ENOENT:
+	case -ENOMEDIUM:
+	case -ENXIO:
+		netfs_kill_pages(mapping, wreq->start, wreq->len);
+		break;
+	}
+
+	if (wreq->error)
+		mapping_set_error(mapping, wreq->error);
+	if (wreq->netfs_ops->done)
+		wreq->netfs_ops->done(wreq);
+}
+
+/*
+ * Extend the region to be written back to include subsequent contiguously
+ * dirty pages if possible, but don't sleep while doing so.
+ *
+ * If this page holds new content, then we can include filler zeros in the
+ * writeback.
+ */
+static void netfs_extend_writeback(struct address_space *mapping,
+				   struct netfs_group *group,
+				   struct xa_state *xas,
+				   long *_count,
+				   loff_t start,
+				   loff_t max_len,
+				   bool caching,
+				   size_t *_len,
+				   size_t *_top)
+{
+	struct netfs_folio *finfo;
+	struct folio_batch fbatch;
+	struct folio *folio;
+	unsigned int i;
+	pgoff_t index = (start + *_len) / PAGE_SIZE;
+	size_t len;
+	void *priv;
+	bool stop = true;
+
+	folio_batch_init(&fbatch);
+
+	do {
+		/* Firstly, we gather up a batch of contiguous dirty pages
+		 * under the RCU read lock - but we can't clear the dirty flags
+		 * there if any of those pages are mapped.
+		 */
+		rcu_read_lock();
+
+		xas_for_each(xas, folio, ULONG_MAX) {
+			stop = true;
+			if (xas_retry(xas, folio))
+				continue;
+			if (xa_is_value(folio))
+				break;
+			if (folio_index(folio) != index) {
+				xas_reset(xas);
+				break;
+			}
+
+			if (!folio_try_get_rcu(folio)) {
+				xas_reset(xas);
+				continue;
+			}
+
+			/* Has the folio moved or been split? */
+			if (unlikely(folio != xas_reload(xas))) {
+				folio_put(folio);
+				xas_reset(xas);
+				break;
+			}
+
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
+				xas_reset(xas);
+				break;
+			}
+			if (!folio_test_dirty(folio) ||
+			    folio_test_writeback(folio) ||
+			    folio_test_fscache(folio)) {
+				folio_unlock(folio);
+				folio_put(folio);
+				xas_reset(xas);
+				break;
+			}
+
+			stop = false;
+			len = folio_size(folio);
+			priv = folio_get_private(folio);
+			if ((const struct netfs_group *)priv != group) {
+				stop = true;
+				finfo = netfs_folio_info(folio);
+				if (finfo->netfs_group != group ||
+				    finfo->dirty_offset > 0) {
+					folio_unlock(folio);
+					folio_put(folio);
+					xas_reset(xas);
+					break;
+				}
+				len = finfo->dirty_len;
+			}
+
+			*_top += folio_size(folio);
+			index += folio_nr_pages(folio);
+			*_count -= folio_nr_pages(folio);
+			*_len += len;
+			if (*_len >= max_len || *_count <= 0)
+				stop = true;
+
+			if (!folio_batch_add(&fbatch, folio))
+				break;
+			if (stop)
+				break;
+		}
+
+		xas_pause(xas);
+		rcu_read_unlock();
+
+		/* Now, if we obtained any folios, we can shift them to being
+		 * writable and mark them for caching.
+		 */
+		if (!folio_batch_count(&fbatch))
+			break;
+
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			folio = fbatch.folios[i];
+			trace_netfs_folio(folio, netfs_folio_trace_store_plus);
+
+			if (!folio_clear_dirty_for_io(folio))
+				BUG();
+			folio_start_writeback(folio);
+			netfs_folio_start_fscache(caching, folio);
+			folio_unlock(folio);
+		}
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	} while (!stop);
+}
+
+/*
+ * Synchronously write back the locked page and any subsequent non-locked dirty
+ * pages.
+ */
+static ssize_t netfs_write_back_from_locked_folio(struct address_space *mapping,
+						  struct writeback_control *wbc,
+						  struct netfs_group *group,
+						  struct xa_state *xas,
+						  struct folio *folio,
+						  unsigned long long start,
+						  unsigned long long end)
+{
+	struct netfs_io_request *wreq;
+	struct netfs_folio *finfo;
+	struct netfs_inode *ctx = netfs_inode(mapping->host);
+	unsigned long long i_size = i_size_read(&ctx->inode);
+	size_t len, max_len;
+	bool caching = netfs_is_cache_enabled(ctx);
+	long count = wbc->nr_to_write;
+	int ret;
+
+	_enter(",%lx,%llx-%llx,%u", folio_index(folio), start, end, caching);
+
+	wreq = netfs_alloc_request(mapping, NULL, start, folio_size(folio),
+				   NETFS_WRITEBACK);
+	if (IS_ERR(wreq)) {
+		folio_unlock(folio);
+		return PTR_ERR(wreq);
+	}
+
+	if (!folio_clear_dirty_for_io(folio))
+		BUG();
+	folio_start_writeback(folio);
+	netfs_folio_start_fscache(caching, folio);
+
+	count -= folio_nr_pages(folio);
+
+	/* Find all consecutive lockable dirty pages that have contiguous
+	 * written regions, stopping when we find a page that is not
+	 * immediately lockable, is not dirty or is missing, or we reach the
+	 * end of the range.
+	 */
+	trace_netfs_folio(folio, netfs_folio_trace_store);
+
+	len = wreq->len;
+	finfo = netfs_folio_info(folio);
+	if (finfo) {
+		start += finfo->dirty_offset;
+		if (finfo->dirty_offset + finfo->dirty_len != len) {
+			len = finfo->dirty_len;
+			goto cant_expand;
+		}
+		len = finfo->dirty_len;
+	}
+
+	if (start < i_size) {
+		/* Trim the write to the EOF; the extra data is ignored.  Also
+		 * put an upper limit on the size of a single storedata op.
+		 */
+		max_len = 65536 * 4096;
+		max_len = min_t(unsigned long long, max_len, end - start + 1);
+		max_len = min_t(unsigned long long, max_len, i_size - start);
+
+		if (len < max_len)
+			netfs_extend_writeback(mapping, group, xas, &count, start,
+					       max_len, caching, &len, &wreq->upper_len);
+	}
+
+cant_expand:
+	len = min_t(unsigned long long, len, i_size - start);
+
+	/* We now have a contiguous set of dirty pages, each with writeback
+	 * set; the first page is still locked at this point, but all the rest
+	 * have been unlocked.
+	 */
+	folio_unlock(folio);
+	wreq->start = start;
+	wreq->len = len;
+
+	if (start < i_size) {
+		_debug("write back %zx @%llx [%llx]", len, start, i_size);
+
+		/* Speculatively write to the cache.  We have to fix this up
+		 * later if the store fails.
+		 */
+		wreq->cleanup = netfs_cleanup_buffered_write;
+
+		iov_iter_xarray(&wreq->iter, ITER_SOURCE, &mapping->i_pages, start,
+				wreq->upper_len);
+		__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
+		ret = netfs_begin_write(wreq, true, netfs_write_trace_writeback);
+		if (ret == 0 || ret == -EIOCBQUEUED)
+			wbc->nr_to_write -= len / PAGE_SIZE;
+	} else {
+		_debug("write discard %zx @%llx [%llx]", len, start, i_size);
+
+		/* The dirty region was entirely beyond the EOF. */
+		fscache_clear_page_bits(mapping, start, len, caching);
+		netfs_pages_written_back(wreq);
+		ret = 0;
+	}
+
+	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+	_leave(" = 1");
+	return 1;
+}
+
+/*
+ * Write a region of pages back to the server
+ */
+static ssize_t netfs_writepages_begin(struct address_space *mapping,
+				      struct writeback_control *wbc,
+				      struct netfs_group *group,
+				      struct xa_state *xas,
+				      unsigned long long *_start,
+				      unsigned long long end)
+{
+	const struct netfs_folio *finfo;
+	struct folio *folio;
+	unsigned long long start = *_start;
+	ssize_t ret;
+	void *priv;
+	int skips = 0;
+
+	_enter("%llx,%llx,", start, end);
+
+search_again:
+	/* Find the first dirty page in the group. */
+	rcu_read_lock();
+
+	for (;;) {
+		folio = xas_find_marked(xas, end / PAGE_SIZE, PAGECACHE_TAG_DIRTY);
+		if (xas_retry(xas, folio) || xa_is_value(folio))
+			continue;
+		if (!folio)
+			break;
+
+		if (!folio_try_get_rcu(folio)) {
+			xas_reset(xas);
+			continue;
+		}
+
+		if (unlikely(folio != xas_reload(xas))) {
+			folio_put(folio);
+			xas_reset(xas);
+			continue;
+		}
+
+		/* Skip any dirty folio that's not in the group of interest. */
+		priv = folio_get_private(folio);
+		if ((const struct netfs_group *)priv != group) {
+			finfo = netfs_folio_info(folio);
+			if (finfo->netfs_group != group) {
+				folio_put(folio);
+				continue;
+			}
+		}
+
+		xas_pause(xas);
+		break;
+	}
+	rcu_read_unlock();
+	if (!folio)
+		return 0;
+
+	start = folio_pos(folio); /* May regress with THPs */
+
+	_debug("wback %lx", folio_index(folio));
+
+	/* At this point we hold neither the i_pages lock nor the page lock:
+	 * the page may be truncated or invalidated (changing page->mapping to
+	 * NULL), or even swizzled back from swapper_space to tmpfs file
+	 * mapping
+	 */
+lock_again:
+	if (wbc->sync_mode != WB_SYNC_NONE) {
+		ret = folio_lock_killable(folio);
+		if (ret < 0)
+			return ret;
+	} else {
+		if (!folio_trylock(folio))
+			goto search_again;
+	}
+
+	if (folio->mapping != mapping ||
+	    !folio_test_dirty(folio)) {
+		start += folio_size(folio);
+		folio_unlock(folio);
+		goto search_again;
+	}
+
+	if (folio_test_writeback(folio) ||
+	    folio_test_fscache(folio)) {
+		folio_unlock(folio);
+		if (wbc->sync_mode != WB_SYNC_NONE) {
+			folio_wait_writeback(folio);
+#ifdef CONFIG_NETFS_FSCACHE
+			folio_wait_fscache(folio);
+#endif
+			goto lock_again;
+		}
+
+		start += folio_size(folio);
+		if (wbc->sync_mode == WB_SYNC_NONE) {
+			if (skips >= 5 || need_resched()) {
+				ret = 0;
+				goto out;
+			}
+			skips++;
+		}
+		goto search_again;
+	}
+
+	ret = netfs_write_back_from_locked_folio(mapping, wbc, group, xas,
+						 folio, start, end);
+out:
+	if (ret > 0)
+		*_start = start + ret;
+	_leave(" = %zd [%llx]", ret, *_start);
+	return ret;
+}
+
+/*
+ * Write a region of pages back to the server
+ */
+static int netfs_writepages_region(struct address_space *mapping,
+				   struct writeback_control *wbc,
+				   struct netfs_group *group,
+				   unsigned long long *_start,
+				   unsigned long long end)
+{
+	ssize_t ret;
+
+	XA_STATE(xas, &mapping->i_pages, *_start / PAGE_SIZE);
+
+	do {
+		ret = netfs_writepages_begin(mapping, wbc, group, &xas,
+					     _start, end);
+		if (ret > 0 && wbc->nr_to_write > 0)
+			cond_resched();
+	} while (ret > 0 && wbc->nr_to_write > 0);
+
+	return ret > 0 ? 0 : ret;
+}
+
+/*
+ * write some of the pending data back to the server
+ */
+int netfs_writepages(struct address_space *mapping,
+		     struct writeback_control *wbc)
+{
+	struct netfs_group *group = NULL;
+	loff_t start, end;
+	int ret;
+
+	_enter("");
+
+	/* We have to be careful as we can end up racing with setattr()
+	 * truncating the pagecache since the caller doesn't take a lock here
+	 * to prevent it.
+	 */
+
+	if (wbc->range_cyclic && mapping->writeback_index) {
+		start = mapping->writeback_index * PAGE_SIZE;
+		ret = netfs_writepages_region(mapping, wbc, group,
+					      &start, LLONG_MAX);
+		if (ret < 0)
+			goto out;
+
+		if (wbc->nr_to_write <= 0) {
+			mapping->writeback_index = start / PAGE_SIZE;
+			goto out;
+		}
+
+		start = 0;
+		end = mapping->writeback_index * PAGE_SIZE;
+		mapping->writeback_index = 0;
+		ret = netfs_writepages_region(mapping, wbc, group, &start, end);
+		if (ret == 0)
+			mapping->writeback_index = start / PAGE_SIZE;
+	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
+		start = 0;
+		ret = netfs_writepages_region(mapping, wbc, group,
+					      &start, LLONG_MAX);
+		if (wbc->nr_to_write > 0 && ret == 0)
+			mapping->writeback_index = start / PAGE_SIZE;
+	} else {
+		start = wbc->range_start;
+		ret = netfs_writepages_region(mapping, wbc, group,
+					      &start, wbc->range_end);
+	}
+
+out:
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_writepages);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 506c543f6888..71a70396c2f9 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -398,6 +398,8 @@ int netfs_read_folio(struct file *, struct folio *);
 int netfs_write_begin(struct netfs_inode *, struct file *,
 		      struct address_space *, loff_t pos, unsigned int len,
 		      struct folio **, void **fsdata);
+int netfs_writepages(struct address_space *mapping,
+		     struct writeback_control *wbc);
 bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio);
 int netfs_unpin_writeback(struct inode *inode, struct writeback_control *wbc);
 void netfs_clear_inode_writeback(struct inode *inode, const void *aux);



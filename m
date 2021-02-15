Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B688031BDFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 17:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhBOP5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 10:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231597AbhBOPsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613404007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QE0n7rWrBQ2i7DgbcizqLoWK1/iqYLgeje7wNt2nODM=;
        b=ILKfVJ0EEKdRJ3fnm2gwz0tNQQzpxSs/MTIE2umLsns1t1oVHRCxsBU6p79VsSx9ge8ODS
        XPmzLyrCd/3QVlHQuaLonVRnD9pl9+hfUldY1DPCuauTnnzjzhSRwfepuryPeQ8jZuR/7Y
        drTV41dM7bcIams8R1xNjMB1klfUG/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-JSfeZ1kkO5adpEhXBnjahA-1; Mon, 15 Feb 2021 10:46:45 -0500
X-MC-Unique: JSfeZ1kkO5adpEhXBnjahA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B7DC801962;
        Mon, 15 Feb 2021 15:46:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE26E5B697;
        Mon, 15 Feb 2021 15:46:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/33] netfs: Define an interface to talk to a cache
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Feb 2021 15:46:35 +0000
Message-ID: <161340399569.1303470.1138884774643385730.stgit@warthog.procyon.org.uk>
In-Reply-To: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an interface to the netfs helper library for reading data from the
cache instead of downloading it from the server and support for writing
data just downloaded or cleared to the cache.

The API passes an iov_iter to the cache read/write routines to indicate the
data/buffer to be used.  This is done using the ITER_XARRAY type to provide
direct access to the netfs inode's pagecache.

When the netfs's ->begin_cache_operation() method is called, this must fill
in the cache_resources in the netfs_read_request struct, including the
netfs_cache_ops used by the helper lib to talk to the cache.  The helper
lib does not directly access the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
---

 fs/netfs/read_helper.c        |  230 +++++++++++++++++++++++++++++++++++++++++
 fs/netfs/stats.c              |    3 -
 include/linux/fscache-cache.h |    4 +
 include/linux/fscache.h       |   17 +++
 include/linux/netfs.h         |   48 +++++++++
 5 files changed, 300 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index d179a37b92fd..156941e0de61 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -86,6 +86,8 @@ static void netfs_free_read_request(struct work_struct *work)
 	if (rreq->netfs_priv)
 		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
+	if (rreq->cache_resources.ops)
+		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
 	kfree(rreq);
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
@@ -149,6 +151,32 @@ static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
 	iov_iter_zero(iov_iter_count(&iter), &iter);
 }
 
+static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error)
+{
+	struct netfs_read_subrequest *subreq = priv;
+
+	netfs_subreq_terminated(subreq, transferred_or_error);
+}
+
+/*
+ * Issue a read against the cache.
+ * - Eats the caller's ref on subreq.
+ */
+static void netfs_read_from_cache(struct netfs_read_request *rreq,
+				  struct netfs_read_subrequest *subreq,
+				  bool seek_data)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	struct iov_iter iter;
+
+	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
+			subreq->start + subreq->transferred,
+			subreq->len   - subreq->transferred);
+
+	cres->ops->read(cres, subreq->start, &iter, seek_data,
+			netfs_cache_read_terminated, subreq);
+}
+
 /*
  * Fill a subrequest region with zeroes.
  */
@@ -193,6 +221,141 @@ static void netfs_rreq_completed(struct netfs_read_request *rreq)
 	netfs_put_read_request(rreq);
 }
 
+/*
+ * Deal with the completion of writing the data to the cache.  We have to clear
+ * the PG_fscache bits on the pages involved and release the caller's ref.
+ *
+ * May be called in softirq mode and we inherit a ref from the caller.
+ */
+static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq)
+{
+	struct netfs_read_subrequest *subreq;
+	struct page *page;
+	pgoff_t unlocked = 0;
+	bool have_unlocked = false;
+
+	rcu_read_lock();
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
+
+		xas_for_each(&xas, page, (subreq->start + subreq->len - 1) / PAGE_SIZE) {
+			/* We might have multiple writes from the same huge
+			 * page, but we mustn't unlock a page more than once.
+			 */
+			if (have_unlocked && page->index <= unlocked)
+				continue;
+			unlocked = page->index;
+			unlock_page_fscache(page);
+			have_unlocked = true;
+		}
+	}
+
+	rcu_read_unlock();
+	netfs_rreq_completed(rreq);
+}
+
+static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error)
+{
+	struct netfs_read_subrequest *subreq = priv;
+	struct netfs_read_request *rreq = subreq->rreq;
+
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		subreq->error = transferred_or_error;
+		netfs_stat(&netfs_n_rh_write_failed);
+	} else {
+		subreq->error = 0;
+		netfs_stat(&netfs_n_rh_write_done);
+	}
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
+
+	/* If we decrement nr_wr_ops to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_wr_ops))
+		netfs_rreq_unmark_after_write(rreq);
+
+	netfs_put_subrequest(subreq);
+}
+
+/*
+ * Perform any outstanding writes to the cache.  We inherit a ref from the
+ * caller.
+ */
+static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	struct netfs_read_subrequest *subreq, *next, *p;
+	struct iov_iter iter;
+	loff_t pos;
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_write);
+
+	/* We don't want terminating writes trying to wake us up whilst we're
+	 * still going through the list.
+	 */
+	atomic_inc(&rreq->nr_wr_ops);
+
+	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
+		if (!test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
+			list_del_init(&subreq->rreq_link);
+			netfs_put_subrequest(subreq);
+		}
+	}
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		/* Amalgamate adjacent writes */
+		pos = round_down(subreq->start, PAGE_SIZE);
+		if (pos != subreq->start) {
+			subreq->len += subreq->start - pos;
+			subreq->start = pos;
+		}
+		subreq->len = round_up(subreq->len, PAGE_SIZE);
+
+		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+			next = list_next_entry(subreq, rreq_link);
+			if (next->start > subreq->start + subreq->len)
+				break;
+			subreq->len += next->len;
+			subreq->len = round_up(subreq->len, PAGE_SIZE);
+			list_del_init(&next->rreq_link);
+			netfs_put_subrequest(next);
+		}
+
+		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
+				subreq->start, subreq->len);
+
+		atomic_inc(&rreq->nr_wr_ops);
+		netfs_stat(&netfs_n_rh_write);
+		netfs_get_read_subrequest(subreq);
+		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
+		cres->ops->write(cres, subreq->start, &iter,
+				 netfs_rreq_copy_terminated, subreq);
+	}
+
+	/* If we decrement nr_wr_ops to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_wr_ops))
+		netfs_rreq_unmark_after_write(rreq);
+}
+
+static void netfs_rreq_write_to_cache_work(struct work_struct *work)
+{
+	struct netfs_read_request *rreq =
+		container_of(work, struct netfs_read_request, work);
+
+	netfs_rreq_do_write_to_cache(rreq);
+}
+
+static void netfs_rreq_write_to_cache(struct netfs_read_request *rreq)
+{
+	if (in_softirq()) {
+		rreq->work.func = netfs_rreq_write_to_cache_work;
+		if (!queue_work(system_unbound_wq, &rreq->work))
+			BUG();
+	} else {
+		netfs_rreq_do_write_to_cache(rreq);
+	}
+}
+
 /*
  * Unlock the pages in a read operation.  We need to set PG_fscache on any
  * pages we're going to write back before we unlock them.
@@ -294,7 +457,10 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
 
 	netfs_get_read_subrequest(subreq);
 	atomic_inc(&rreq->nr_rd_ops);
-	netfs_read_from_server(rreq, subreq);
+	if (subreq->source == NETFS_READ_FROM_CACHE)
+		netfs_read_from_cache(rreq, subreq, true);
+	else
+		netfs_read_from_server(rreq, subreq);
 }
 
 /*
@@ -339,6 +505,25 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
 	return false;
 }
 
+/*
+ * Check to see if the data read is still valid.
+ */
+static void netfs_rreq_is_still_valid(struct netfs_read_request *rreq)
+{
+	struct netfs_read_subrequest *subreq;
+
+	if (!rreq->netfs_ops->is_still_valid ||
+	    rreq->netfs_ops->is_still_valid(rreq))
+		return;
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		if (subreq->source == NETFS_READ_FROM_CACHE) {
+			subreq->error = -ESTALE;
+			__set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+		}
+	}
+}
+
 /*
  * Assess the state of a read request and decide what to do next.
  *
@@ -350,6 +535,8 @@ static void netfs_rreq_assess(struct netfs_read_request *rreq)
 	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
 
 again:
+	netfs_rreq_is_still_valid(rreq);
+
 	if (!test_bit(NETFS_RREQ_FAILED, &rreq->flags) &&
 	    test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags)) {
 		if (netfs_rreq_perform_resubmissions(rreq))
@@ -362,6 +549,9 @@ static void netfs_rreq_assess(struct netfs_read_request *rreq)
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
 
+	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags))
+		return netfs_rreq_write_to_cache(rreq);
+
 	netfs_rreq_completed(rreq);
 }
 
@@ -493,7 +683,10 @@ static enum netfs_read_source netfs_cache_prepare_read(struct netfs_read_subrequ
 						       loff_t i_size)
 {
 	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
+	if (cres->ops)
+		return cres->ops->prepare_read(subreq, i_size);
 	if (subreq->start >= rreq->i_size)
 		return NETFS_FILL_WITH_ZEROES;
 	return NETFS_DOWNLOAD_FROM_SERVER;
@@ -584,6 +777,9 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 	case NETFS_DOWNLOAD_FROM_SERVER:
 		netfs_read_from_server(rreq, subreq);
 		break;
+	case NETFS_READ_FROM_CACHE:
+		netfs_read_from_cache(rreq, subreq, false);
+		break;
 	default:
 		BUG();
 	}
@@ -596,9 +792,23 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 	return false;
 }
 
+static void netfs_cache_expand_readahead(struct netfs_read_request *rreq,
+					 loff_t *_start, size_t *_len, loff_t i_size)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+	if (cres->ops && cres->ops->expand_readahead)
+		cres->ops->expand_readahead(cres, _start, _len, i_size);
+}
+
 static void netfs_rreq_expand(struct netfs_read_request *rreq,
 			      struct readahead_control *ractl)
 {
+	/* Give the cache a chance to change the request parameters.  The
+	 * resultant request must contain the original region.
+	 */
+	netfs_cache_expand_readahead(rreq, &rreq->start, &rreq->len, rreq->i_size);
+
 	/* Give the netfs a chance to change the request parameters.  The
 	 * resultant request must contain the original region.
 	 */
@@ -650,6 +860,7 @@ void netfs_readahead(struct readahead_control *ractl,
 	struct netfs_read_request *rreq;
 	struct page *page;
 	unsigned int debug_index = 0;
+	int ret;
 
 	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
 
@@ -667,6 +878,11 @@ void netfs_readahead(struct readahead_control *ractl,
 	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
 			 netfs_read_trace_readahead);
 
+	if (ops->begin_cache_operation) {
+		ret = ops->begin_cache_operation(rreq);
+		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
+			goto cleanup_free;
+	}
 	netfs_rreq_expand(rreq, ractl);
 
 	atomic_set(&rreq->nr_rd_ops, 1);
@@ -692,6 +908,9 @@ void netfs_readahead(struct readahead_control *ractl,
 		netfs_rreq_assess(rreq);
 	return;
 
+cleanup_free:
+	netfs_put_read_request(rreq);
+	return;
 cleanup:
 	if (netfs_priv)
 		ops->cleanup(ractl->mapping, netfs_priv);
@@ -741,6 +960,14 @@ int netfs_readpage(struct file *file,
 	netfs_stat(&netfs_n_rh_readpage);
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
+	if (ops->begin_cache_operation) {
+		ret = ops->begin_cache_operation(rreq);
+		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS) {
+			unlock_page(page);
+			goto out;
+		}
+	}
+
 	netfs_get_read_request(rreq);
 
 	atomic_set(&rreq->nr_rd_ops, 1);
@@ -762,6 +989,7 @@ int netfs_readpage(struct file *file,
 	ret = rreq->error;
 	if (ret == 0 && rreq->submitted < rreq->len)
 		ret = -EIO;
+out:
 	netfs_put_read_request(rreq);
 	return ret;
 }
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index dd7ad66ed07e..9ae538c85378 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -31,10 +31,11 @@ atomic_t netfs_n_rh_write_zskip;
 
 void netfs_stats_show(struct seq_file *m)
 {
-	seq_printf(m, "RdHelp : RA=%u RP=%u WB=%u rr=%u sr=%u\n",
+	seq_printf(m, "RdHelp : RA=%u RP=%u WB=%u WBZ=%u rr=%u sr=%u\n",
 		   atomic_read(&netfs_n_rh_readahead),
 		   atomic_read(&netfs_n_rh_readpage),
 		   atomic_read(&netfs_n_rh_write_begin),
+		   atomic_read(&netfs_n_rh_write_zskip),
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq));
 	seq_printf(m, "RdHelp : ZR=%u sh=%u sk=%u\n",
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 3f0b19dcfae7..3235ddbdcc09 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -304,6 +304,10 @@ struct fscache_cache_ops {
 
 	/* dissociate a cache from all the pages it was backing */
 	void (*dissociate_pages)(struct fscache_cache *cache);
+
+	/* Begin a read operation for the netfs lib */
+	int (*begin_read_operation)(struct netfs_read_request *rreq,
+				    struct fscache_retrieval *op);
 };
 
 extern struct fscache_cookie fscache_fsdef_index;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 1f8dc72369ee..0e4161ce347c 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -37,6 +37,7 @@ struct pagevec;
 struct fscache_cache_tag;
 struct fscache_cookie;
 struct fscache_netfs;
+struct netfs_read_request;
 
 typedef void (*fscache_rw_complete_t)(struct page *page,
 				      void *context,
@@ -217,6 +218,7 @@ extern void __fscache_readpages_cancel(struct fscache_cookie *cookie,
 extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
 extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
 				    bool (*)(void *), void *);
+extern int __fscache_begin_read_operation(struct netfs_read_request *, struct fscache_cookie *);
 
 /**
  * fscache_register_netfs - Register a filesystem as desiring caching services
@@ -831,4 +833,19 @@ void fscache_enable_cookie(struct fscache_cookie *cookie,
 					can_enable, data);
 }
 
+/**
+ * fscache_begin_read_operation - Begin a read operation for the netfs lib
+ * @rreq: The read request being undertaken
+ * @cookie: The cookie representing the cache object
+ */
+static inline
+int fscache_begin_read_operation(struct netfs_read_request *rreq,
+				 struct fscache_cookie *cookie)
+{
+	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+		return __fscache_begin_read_operation(rreq, cookie);
+	else
+		return -ENOBUFS;
+}
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ec9d1240ba49..b2589b39feb8 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -60,6 +60,17 @@ enum netfs_read_source {
 	NETFS_INVALID_READ,
 } __mode(byte);
 
+typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error);
+
+/*
+ * Resources required to do operations on a cache.
+ */
+struct netfs_cache_resources {
+	const struct netfs_cache_ops	*ops;
+	void				*cache_priv;
+	void				*cache_priv2;
+};
+
 /*
  * Descriptor for a single component subrequest.
  */
@@ -89,11 +100,13 @@ struct netfs_read_request {
 	struct work_struct	work;
 	struct inode		*inode;		/* The file being accessed */
 	struct address_space	*mapping;	/* The mapping being accessed */
+	struct netfs_cache_resources cache_resources;
 	struct list_head	subrequests;	/* Requests to fetch I/O from disk or net */
 	void			*netfs_priv;	/* Private data for the netfs */
 	unsigned int		debug_id;
 	unsigned int		cookie_debug_id;
 	atomic_t		nr_rd_ops;	/* Number of read ops in progress */
+	atomic_t		nr_wr_ops;	/* Number of write ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
 	size_t			len;		/* Length of the request */
 	short			error;		/* 0 or error that occurred */
@@ -117,6 +130,7 @@ struct netfs_read_request {
 struct netfs_read_request_ops {
 	bool (*is_cache_enabled)(struct inode *inode);
 	void (*init_rreq)(struct netfs_read_request *rreq, struct file *file);
+	int (*begin_cache_operation)(struct netfs_read_request *rreq);
 	void (*expand_readahead)(struct netfs_read_request *rreq);
 	bool (*clamp_length)(struct netfs_read_subrequest *subreq);
 	void (*issue_op)(struct netfs_read_subrequest *subreq);
@@ -127,6 +141,40 @@ struct netfs_read_request_ops {
 	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 };
 
+/*
+ * Table of operations for access to a cache.  This is obtained by
+ * rreq->ops->begin_cache_operation().
+ */
+struct netfs_cache_ops {
+	/* End an operation */
+	void (*end_operation)(struct netfs_cache_resources *cres);
+
+	/* Read data from the cache */
+	int (*read)(struct netfs_cache_resources *cres,
+		    loff_t start_pos,
+		    struct iov_iter *iter,
+		    bool seek_data,
+		    netfs_io_terminated_t term_func,
+		    void *term_func_priv);
+
+	/* Write data to the cache */
+	int (*write)(struct netfs_cache_resources *cres,
+		     loff_t start_pos,
+		     struct iov_iter *iter,
+		     netfs_io_terminated_t term_func,
+		     void *term_func_priv);
+
+	/* Expand readahead request */
+	void (*expand_readahead)(struct netfs_cache_resources *cres,
+				 loff_t *_start, size_t *_len, loff_t i_size);
+
+	/* Prepare a read operation, shortening it to a cached/uncached
+	 * boundary as appropriate.
+	 */
+	enum netfs_read_source (*prepare_read)(struct netfs_read_subrequest *subreq,
+					       loff_t i_size);
+};
+
 struct readahead_control;
 extern void netfs_readahead(struct readahead_control *,
 			    const struct netfs_read_request_ops *,



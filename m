Return-Path: <linux-fsdevel+bounces-27381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53635960FD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72591F216F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593171C93B0;
	Tue, 27 Aug 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wzwPnOiZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6BC1C6F5F;
	Tue, 27 Aug 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770922; cv=none; b=jm2gfY6YANWSvg129+pGWnaRi1Fw6SnNt6fEfpTTIXpEE3q76kBr4wAVQhhT0/MZ7a/PFlfi6J7GNemthB2drGfo57gG9ETzF1WOjCwRGLfIlJh7hqgZeA15rHa6acBnEpVQmvSzh9MG45kBnHHsQTaysY1tK8mQNooGDbPQMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770922; c=relaxed/simple;
	bh=9sAfGli9gYUmQoujjwPSxkMs08KBa9qqVzVQDT1mDVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG+vGBQo5l2PXQ4G3ZSN9JNZyuLJL9/MNoZe4skIRH0M5Vtoh531xeTHtxc1ygKiUVVQF0Vr3wXdmemgxFSVMLwxjmGJLThZPOaED6ccRg0kw6LN9zOyldFnmoeBTOuDsDBY0RkRXUmOog+2xsVYXCSqsvxf+xcPwCH91E2NYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wzwPnOiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19BAC4DDEF;
	Tue, 27 Aug 2024 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770922;
	bh=9sAfGli9gYUmQoujjwPSxkMs08KBa9qqVzVQDT1mDVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wzwPnOiZBC/VU7qNJH939H0Emvjm0/YWDMpJWfUetGFmZeXlzGLvUmcnm8oECoWu+
	 iN2ka40NOtDhcwheaH6gcaC0FvFORYCptEcPYuOXw11W/CQ0DnR7LA+KQ9EXcWTsjl
	 Z+Cku+LZtuPYJz2oz9nSqsDE/r1KyIXCSBze+Knc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.10 009/273] netfs, ceph: Revert "netfs: Remove deprecated use of PG_private_2 as a second writeback flag"
Date: Tue, 27 Aug 2024 16:35:33 +0200
Message-ID: <20240827143833.738064110@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 8e5ced7804cb9184c4a23f8054551240562a8eda upstream.

This reverts commit ae678317b95e760607c7b20b97c9cd4ca9ed6e1a.

Revert the patch that removes the deprecated use of PG_private_2 in
netfslib for the moment as Ceph is actually still using this to track
data copied to the cache.

Fixes: ae678317b95e ("netfs: Remove deprecated use of PG_private_2 as a second writeback flag")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: ceph-devel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
https: //lore.kernel.org/r/3575457.1722355300@warthog.procyon.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/addr.c               |   19 +++++
 fs/netfs/buffered_read.c     |    8 ++
 fs/netfs/io.c                |  144 +++++++++++++++++++++++++++++++++++++++++++
 include/trace/events/netfs.h |    1 
 4 files changed, 170 insertions(+), 2 deletions(-)

--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -498,6 +498,11 @@ const struct netfs_request_ops ceph_netf
 };
 
 #ifdef CONFIG_CEPH_FSCACHE
+static void ceph_set_page_fscache(struct page *page)
+{
+	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
+}
+
 static void ceph_fscache_write_terminated(void *priv, ssize_t error, bool was_async)
 {
 	struct inode *inode = priv;
@@ -515,6 +520,10 @@ static void ceph_fscache_write_to_cache(
 			       ceph_fscache_write_terminated, inode, true, caching);
 }
 #else
+static inline void ceph_set_page_fscache(struct page *page)
+{
+}
+
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
 {
 }
@@ -706,6 +715,8 @@ static int writepage_nounlock(struct pag
 		len = wlen;
 
 	set_page_writeback(page);
+	if (caching)
+		ceph_set_page_fscache(page);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -789,6 +800,8 @@ static int ceph_writepage(struct page *p
 		return AOP_WRITEPAGE_ACTIVATE;
 	}
 
+	folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
+
 	err = writepage_nounlock(page, wbc);
 	if (err == -ERESTARTSYS) {
 		/* direct memory reclaimer was killed by SIGKILL. return 0
@@ -1062,7 +1075,8 @@ get_more_pages:
 				unlock_page(page);
 				break;
 			}
-			if (PageWriteback(page)) {
+			if (PageWriteback(page) ||
+			    PagePrivate2(page) /* [DEPRECATED] */) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					doutc(cl, "%p under writeback\n", page);
 					unlock_page(page);
@@ -1070,6 +1084,7 @@ get_more_pages:
 				}
 				doutc(cl, "waiting on writeback %p\n", page);
 				wait_on_page_writeback(page);
+				folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
@@ -1254,6 +1269,8 @@ new_request:
 			}
 
 			set_page_writeback(page);
+			if (caching)
+				ceph_set_page_fscache(page);
 			len += thp_size(page);
 		}
 		ceph_fscache_write_to_cache(inode, offset, len, caching);
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -466,7 +466,7 @@ retry:
 	if (!netfs_is_cache_enabled(ctx) &&
 	    netfs_skip_folio_read(folio, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
-		goto have_folio;
+		goto have_folio_no_wait;
 	}
 
 	rreq = netfs_alloc_request(mapping, file,
@@ -507,6 +507,12 @@ retry:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 
 have_folio:
+	if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags)) {
+		ret = folio_wait_private_2_killable(folio);
+		if (ret < 0)
+			goto error;
+	}
+have_folio_no_wait:
 	*_folio = folio;
 	kleave(" = 0");
 	return 0;
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -99,6 +99,146 @@ static void netfs_rreq_completed(struct
 }
 
 /*
+ * [DEPRECATED] Deal with the completion of writing the data to the cache.  We
+ * have to clear the PG_fscache bits on the folios involved and release the
+ * caller's ref.
+ *
+ * May be called in softirq mode and we inherit a ref from the caller.
+ */
+static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
+					  bool was_async)
+{
+	struct netfs_io_subrequest *subreq;
+	struct folio *folio;
+	pgoff_t unlocked = 0;
+	bool have_unlocked = false;
+
+	rcu_read_lock();
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
+
+		xas_for_each(&xas, folio, (subreq->start + subreq->len - 1) / PAGE_SIZE) {
+			if (xas_retry(&xas, folio))
+				continue;
+
+			/* We might have multiple writes from the same huge
+			 * folio, but we mustn't unlock a folio more than once.
+			 */
+			if (have_unlocked && folio->index <= unlocked)
+				continue;
+			unlocked = folio_next_index(folio) - 1;
+			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
+			folio_end_private_2(folio);
+			have_unlocked = true;
+		}
+	}
+
+	rcu_read_unlock();
+	netfs_rreq_completed(rreq, was_async);
+}
+
+static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
+				       bool was_async) /* [DEPRECATED] */
+{
+	struct netfs_io_subrequest *subreq = priv;
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		netfs_stat(&netfs_n_rh_write_failed);
+		trace_netfs_failure(rreq, subreq, transferred_or_error,
+				    netfs_fail_copy_to_cache);
+	} else {
+		netfs_stat(&netfs_n_rh_write_done);
+	}
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
+
+	/* If we decrement nr_copy_ops to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
+		netfs_rreq_unmark_after_write(rreq, was_async);
+
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
+}
+
+/*
+ * [DEPRECATED] Perform any outstanding writes to the cache.  We inherit a ref
+ * from the caller.
+ */
+static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	struct netfs_io_subrequest *subreq, *next, *p;
+	struct iov_iter iter;
+	int ret;
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_copy);
+
+	/* We don't want terminating writes trying to wake us up whilst we're
+	 * still going through the list.
+	 */
+	atomic_inc(&rreq->nr_copy_ops);
+
+	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
+		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
+			list_del_init(&subreq->rreq_link);
+			netfs_put_subrequest(subreq, false,
+					     netfs_sreq_trace_put_no_copy);
+		}
+	}
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		/* Amalgamate adjacent writes */
+		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+			next = list_next_entry(subreq, rreq_link);
+			if (next->start != subreq->start + subreq->len)
+				break;
+			subreq->len += next->len;
+			list_del_init(&next->rreq_link);
+			netfs_put_subrequest(next, false,
+					     netfs_sreq_trace_put_merged);
+		}
+
+		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
+					       subreq->len, rreq->i_size, true);
+		if (ret < 0) {
+			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
+			continue;
+		}
+
+		iov_iter_xarray(&iter, ITER_SOURCE, &rreq->mapping->i_pages,
+				subreq->start, subreq->len);
+
+		atomic_inc(&rreq->nr_copy_ops);
+		netfs_stat(&netfs_n_rh_write);
+		netfs_get_subrequest(subreq, netfs_sreq_trace_get_copy_to_cache);
+		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
+		cres->ops->write(cres, subreq->start, &iter,
+				 netfs_rreq_copy_terminated, subreq);
+	}
+
+	/* If we decrement nr_copy_ops to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
+		netfs_rreq_unmark_after_write(rreq, false);
+}
+
+static void netfs_rreq_write_to_cache_work(struct work_struct *work) /* [DEPRECATED] */
+{
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
+
+	netfs_rreq_do_write_to_cache(rreq);
+}
+
+static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq) /* [DEPRECATED] */
+{
+	rreq->work.func = netfs_rreq_write_to_cache_work;
+	if (!queue_work(system_unbound_wq, &rreq->work))
+		BUG();
+}
+
+/*
  * Handle a short read.
  */
 static void netfs_rreq_short_read(struct netfs_io_request *rreq,
@@ -275,6 +415,10 @@ again:
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
 
+	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags) &&
+	    test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags))
+		return netfs_rreq_write_to_cache(rreq);
+
 	netfs_rreq_completed(rreq, was_async);
 }
 
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -145,6 +145,7 @@
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
 	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_copy_to_cache,	"mark-copy")	\
+	EM(netfs_folio_trace_end_copy,		"end-copy")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
 	EM(netfs_folio_trace_kill_cc,		"kill-cc")	\




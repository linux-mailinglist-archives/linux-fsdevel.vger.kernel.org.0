Return-Path: <linux-fsdevel+bounces-22022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92520910F36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 19:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A756D1C208CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237A1CCCA2;
	Thu, 20 Jun 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ+c30w9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0F1CCCA0
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904839; cv=none; b=hcptIwwPNLmyz8T4SjS91TJJVyR144f9RDH7IjEETWUeUY6r3AfaFgqpgYQwX89Y2dZGA2g+wi856XdNtFehZO1VF3V0n6h4IJaHIfcmQCgaH60DarXA4z1AkQY/8a0nhPNNadqKIvRYrjZPmjJs9CwHBlsz1byO/4ik7KGvxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904839; c=relaxed/simple;
	bh=Zf1//fpCYggsVBIYRns+J2hDWWVM7ei5kP4wEnlVZhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaU2xeO5jb1BqoWQNQzJP4Q7fxpaKVBasXYOCP6Azwa7HnX0qhLPVT7cRt10M1NgVbnE4frmFL+A60ZVKk8IY/3D/een3WEKYx+JE3wshyKOcNUtGeHFm74WOjHfOx7OU5y0OgsEDFHu2R+RTjNFwYSDLkzj/oLc6g5ORmYTjbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQ+c30w9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgHCG13EqsOvPOuMm0ZR+XHws0Ty5xoLcrdq43UuEXc=;
	b=LQ+c30w9pqrTlF/FqPakINUVZBFIlyrtwXOexjunTZWv1kl3FbCI8Iv/xeSIKV1qp42lob
	AHjyp701o+23b8wa07fFAr+gNJP1k2cFirGr2T2Z4nw7AcE4FLoS7N3cmWifYl7WV1S+yc
	IFoj7VxqTSQRg1ZdXjfeYMyRRaDxuNk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-l4eMt56DPRmXn6Gn0fYEZQ-1; Thu,
 20 Jun 2024 13:33:49 -0400
X-MC-Unique: l4eMt56DPRmXn6Gn0fYEZQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7414919560A7;
	Thu, 20 Jun 2024 17:33:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EB9019560B3;
	Thu, 20 Jun 2024 17:33:36 +0000 (UTC)
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
Subject: [PATCH 14/17] netfs: Use new sheaf data type and iterator instead of xarray iter
Date: Thu, 20 Jun 2024 18:31:32 +0100
Message-ID: <20240620173137.610345-15-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Make the netfs write-side routines use the new sheaf struct to hold a
rolling buffer of folios, with the issuer adding folios at the tail and the
collector removing them from the head as they're processed instead of using
an xarray.

This will allow a subsequent patch to simplify the write collector.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h      |  9 ++++-
 fs/netfs/misc.c          | 74 +++++++++++++++++++++++++++++++++++
 fs/netfs/objects.c       |  1 +
 fs/netfs/stats.c         |  4 +-
 fs/netfs/write_collect.c | 84 +++++++++++++++++++++-------------------
 fs/netfs/write_issue.c   | 28 +++++++-------
 include/linux/netfs.h    |  4 ++
 7 files changed, 147 insertions(+), 57 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index a44d480a0fa2..fe0974a95152 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -7,6 +7,7 @@
 
 #include <linux/slab.h>
 #include <linux/seq_file.h>
+#include <linux/sheaf.h>
 #include <linux/netfs.h>
 #include <linux/fscache.h>
 #include <linux/fscache-cache.h>
@@ -63,6 +64,10 @@ static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
 /*
  * misc.c
  */
+int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
+			      bool needs_put);
+struct sheaf *netfs_delete_buffer_head(struct netfs_io_request *wreq);
+void netfs_clear_buffer(struct netfs_io_request *rreq);
 
 /*
  * objects.c
@@ -119,6 +124,7 @@ extern atomic_t netfs_n_wh_write_done;
 extern atomic_t netfs_n_wh_write_failed;
 extern atomic_t netfs_n_wb_lock_skip;
 extern atomic_t netfs_n_wb_lock_wait;
+extern atomic_t netfs_n_sheaf;
 
 int netfs_stats_show(struct seq_file *m, void *v);
 
@@ -152,7 +158,8 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 						loff_t start,
 						enum netfs_io_origin origin);
 void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq);
+			 struct netfs_io_subrequest *subreq,
+			 struct iov_iter *source);
 int netfs_advance_write(struct netfs_io_request *wreq,
 			struct netfs_io_stream *stream,
 			loff_t start, size_t len, bool to_eof);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 83e644bd518f..b4a0943f3c35 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,6 +8,80 @@
 #include <linux/swap.h>
 #include "internal.h"
 
+
+/*
+ * Append a folio to the rolling queue.
+ */
+int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
+			      bool needs_put)
+{
+	struct sheaf *tail = rreq->buffer_tail;
+	unsigned int order = folio_order(folio);
+
+	if (WARN_ON_ONCE(!rreq->buffer && tail) ||
+	    WARN_ON_ONCE(rreq->buffer && !tail))
+		return -EIO;
+
+	if (!tail || rreq->buffer_tail_slot >= sheaf_nr_slots(tail)) {
+		tail = kzalloc(sizeof(*tail), GFP_NOFS);
+		if (!tail)
+			return -ENOMEM;
+		netfs_stat(&netfs_n_sheaf);
+		tail->prev = rreq->buffer_tail;
+		if (tail->prev)
+			tail->prev->next = tail;
+		rreq->buffer_tail = tail;
+		if (!rreq->buffer) {
+			rreq->buffer = tail;
+			iov_iter_sheaf(&rreq->io_iter, ITER_SOURCE, tail, 0, 0, 0);
+		}
+		rreq->buffer_tail_slot = 0;
+	}
+
+	rreq->io_iter.count += PAGE_SIZE << order;
+
+	sheaf_slot_set(tail, rreq->buffer_tail_slot, sheaf_make_folio(folio, needs_put));
+	tail->orders[rreq->buffer_tail_slot] = order;
+	/* Store the counter after setting the slot. */
+	smp_store_release(&rreq->buffer_tail_slot, rreq->buffer_tail_slot + 1);
+	return 0;
+}
+
+/*
+ * Delete the head of a rolling queue.
+ */
+struct sheaf *netfs_delete_buffer_head(struct netfs_io_request *wreq)
+{
+	struct sheaf *head = wreq->buffer, *next = head->next;
+
+	if (next)
+		next->prev = NULL;
+	netfs_stat_d(&netfs_n_sheaf);
+	kfree(head);
+	wreq->buffer = next;
+	return next;
+}
+
+/*
+ * Clear out a rolling queue.
+ */
+void netfs_clear_buffer(struct netfs_io_request *rreq)
+{
+	struct sheaf *p;
+
+	while ((p = rreq->buffer)) {
+		rreq->buffer = p->next;
+		for (int slot = 0; slot < sheaf_nr_slots(p); slot++) {
+			if (!p->slots[slot] || !sheaf_slot_is_folio(p, slot))
+				continue;
+			if (sheaf_slot_is_marked(p, slot))
+				folio_put(sheaf_slot_folio(p, slot));
+		}
+		netfs_stat_d(&netfs_n_sheaf);
+		kfree(p);
+	}
+}
+
 /**
  * netfs_dirty_folio - Mark folio dirty and pin a cache object for writeback
  * @mapping: The mapping the folio belongs to.
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index f4a642727479..d148a955fa55 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -144,6 +144,7 @@ static void netfs_free_request(struct work_struct *work)
 		}
 		kvfree(rreq->direct_bv);
 	}
+	netfs_clear_buffer(rreq);
 
 	if (atomic_dec_and_test(&ictx->io_count))
 		wake_up_var(&ictx->io_count);
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 5fe1c396e24f..84606287c43f 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -41,6 +41,7 @@ atomic_t netfs_n_wh_write_done;
 atomic_t netfs_n_wh_write_failed;
 atomic_t netfs_n_wb_lock_skip;
 atomic_t netfs_n_wb_lock_wait;
+atomic_t netfs_n_sheaf;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
@@ -76,9 +77,10 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_wh_write),
 		   atomic_read(&netfs_n_wh_write_done),
 		   atomic_read(&netfs_n_wh_write_failed));
-	seq_printf(m, "Objs   : rr=%u sr=%u wsc=%u\n",
+	seq_printf(m, "Objs   : rr=%u sr=%u shf=%u wsc=%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq),
+		   atomic_read(&netfs_n_sheaf),
 		   atomic_read(&netfs_n_wh_wstream_conflict));
 	seq_printf(m, "WbLock : skip=%u wait=%u\n",
 		   atomic_read(&netfs_n_wb_lock_skip),
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index e105ac270090..394761041b4a 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -74,42 +74,6 @@ int netfs_folio_written_back(struct folio *folio)
 	return gcount;
 }
 
-/*
- * Get hold of a folio we have under writeback.  We don't want to get the
- * refcount on it.
- */
-static struct folio *netfs_writeback_lookup_folio(struct netfs_io_request *wreq, loff_t pos)
-{
-	XA_STATE(xas, &wreq->mapping->i_pages, pos / PAGE_SIZE);
-	struct folio *folio;
-
-	rcu_read_lock();
-
-	for (;;) {
-		xas_reset(&xas);
-		folio = xas_load(&xas);
-		if (xas_retry(&xas, folio))
-			continue;
-
-		if (!folio || xa_is_value(folio))
-			kdebug("R=%08x: folio %lx (%llx) not present",
-			       wreq->debug_id, xas.xa_index, pos / PAGE_SIZE);
-		BUG_ON(!folio || xa_is_value(folio));
-
-		if (folio == xas_reload(&xas))
-			break;
-	}
-
-	rcu_read_unlock();
-
-	if (WARN_ONCE(!folio_test_writeback(folio),
-		      "R=%08x: folio %lx is not under writeback\n",
-		      wreq->debug_id, folio->index)) {
-		trace_netfs_folio(folio, netfs_folio_trace_not_under_wback);
-	}
-	return folio;
-}
-
 /*
  * Unlock any folios we've finished with.
  */
@@ -117,13 +81,25 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 					  unsigned long long collected_to,
 					  unsigned int *notes)
 {
+	struct sheaf *sheaf = wreq->buffer;
+	unsigned int slot = wreq->buffer_head_slot;
+
+	if (slot >= sheaf_nr_slots(sheaf)) {
+		sheaf = netfs_delete_buffer_head(wreq);
+		slot = 0;
+	}
+
 	for (;;) {
 		struct folio *folio;
 		struct netfs_folio *finfo;
 		unsigned long long fpos, fend;
 		size_t fsize, flen;
 
-		folio = netfs_writeback_lookup_folio(wreq, wreq->cleaned_to);
+		folio = sheaf_slot_folio(sheaf, slot);
+		if (WARN_ONCE(!folio_test_writeback(folio),
+			      "R=%08x: folio %lx is not under writeback\n",
+			      wreq->debug_id, folio->index))
+			trace_netfs_folio(folio, netfs_folio_trace_not_under_wback);
 
 		fpos = folio_pos(folio);
 		fsize = folio_size(folio);
@@ -148,9 +124,25 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 		wreq->cleaned_to = fpos + fsize;
 		*notes |= MADE_PROGRESS;
 
+		/* Clean up the head sheaf.  If we clear an entire sheaf, then
+		 * we can get rid of it provided it's not also the tail sheaf
+		 * being filled by the issuer.
+		 */
+		sheaf_slot_set(sheaf, slot, NULL);
+		slot++;
+		if (slot >= sheaf_nr_slots(sheaf)) {
+			if (READ_ONCE(wreq->buffer_tail) == sheaf)
+				break;
+			sheaf = netfs_delete_buffer_head(wreq);
+			slot = 0;
+		}
+
 		if (fpos + fsize >= collected_to)
 			break;
 	}
+
+	wreq->buffer = sheaf;
+	wreq->buffer_head_slot = slot;
 }
 
 /*
@@ -181,9 +173,12 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+				struct iov_iter source = subreq->io_iter;
+
+				iov_iter_revert(&source, subreq->len - source.count);
 				__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-				netfs_reissue_write(stream, subreq);
+				netfs_reissue_write(stream, subreq, &source);
 			}
 		}
 		return;
@@ -193,6 +188,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 
 	do {
 		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
+		struct iov_iter source;
 		unsigned long long start, len;
 		size_t part;
 		bool boundary = false;
@@ -220,6 +216,14 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			len += to->len;
 		}
 
+		/* Determine the set of buffers we're going to use.  Each
+		 * subreq gets a subset of a single overall contiguous buffer.
+		 */
+		source = from->io_iter;
+		iov_iter_revert(&source, subreq->len - source.count);
+		iov_iter_advance(&source, from->transferred);
+		source.count = len;
+
 		/* Work through the sublist. */
 		subreq = from;
 		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
@@ -242,7 +246,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				boundary = true;
 
 			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			netfs_reissue_write(stream, subreq);
+			netfs_reissue_write(stream, subreq, &source);
 			if (subreq == to)
 				break;
 		}
@@ -309,7 +313,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				boundary = false;
 			}
 
-			netfs_reissue_write(stream, subreq);
+			netfs_reissue_write(stream, subreq, &source);
 			if (!len)
 				break;
 
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index c87e72a3b16d..8c65ac7c5d62 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -211,9 +211,11 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
  * netfs_write_subrequest_terminated() when complete.
  */
 static void netfs_do_issue_write(struct netfs_io_stream *stream,
-				 struct netfs_io_subrequest *subreq)
+				 struct netfs_io_subrequest *subreq,
+				 struct iov_iter *source)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
+	size_t size = subreq->len - subreq->transferred;
 
 	_enter("R=%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len);
 
@@ -221,27 +223,20 @@ static void netfs_do_issue_write(struct netfs_io_stream *stream,
 		return netfs_write_subrequest_terminated(subreq, subreq->error, false);
 
 	// TODO: Use encrypted buffer
-	if (test_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags)) {
-		subreq->io_iter = wreq->io_iter;
-		iov_iter_advance(&subreq->io_iter,
-				 subreq->start + subreq->transferred - wreq->start);
-		iov_iter_truncate(&subreq->io_iter,
-				 subreq->len - subreq->transferred);
-	} else {
-		iov_iter_xarray(&subreq->io_iter, ITER_SOURCE, &wreq->mapping->i_pages,
-				subreq->start + subreq->transferred,
-				subreq->len   - subreq->transferred);
-	}
+	subreq->io_iter = *source;
+	iov_iter_advance(source, size);
+	iov_iter_truncate(&subreq->io_iter, size);
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	stream->issue_write(subreq);
 }
 
 void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq)
+			 struct netfs_io_subrequest *subreq,
+			 struct iov_iter *source)
 {
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	netfs_do_issue_write(stream, subreq);
+	netfs_do_issue_write(stream, subreq, source);
 }
 
 static void netfs_issue_write(struct netfs_io_request *wreq,
@@ -255,7 +250,7 @@ static void netfs_issue_write(struct netfs_io_request *wreq,
 
 	if (subreq->start + subreq->len > wreq->start + wreq->submitted)
 		WRITE_ONCE(wreq->submitted, subreq->start + subreq->len - wreq->start);
-	netfs_do_issue_write(stream, subreq);
+	netfs_do_issue_write(stream, subreq, &wreq->io_iter);
 }
 
 /*
@@ -420,6 +415,9 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		trace_netfs_folio(folio, netfs_folio_trace_store_plus);
 	}
 
+	/* Attach the folio to the rolling buffer. */
+	netfs_buffer_append_folio(wreq, folio, false);
+
 	/* Move the submission point forward to allow for write-streaming data
 	 * not starting at the front of the page.  We don't do write-streaming
 	 * with the cache as the cache requires DIO alignment.
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index aada40d2182b..dc980f107c37 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -234,6 +234,8 @@ struct netfs_io_request {
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
 #define NR_IO_STREAMS 2 //wreq->nr_io_streams
 	struct netfs_group	*group;		/* Writeback group being written back */
+	struct sheaf		*buffer;	/* Head of I/O buffer */
+	struct sheaf		*buffer_tail;	/* Tail of I/O buffer */
 	struct iov_iter		iter;		/* Unencrypted-side iterator */
 	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
 	void			*netfs_priv;	/* Private data for the netfs */
@@ -255,6 +257,8 @@ struct netfs_io_request {
 	short			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
 	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
+	u8			buffer_head_slot; /* First slot in ->buffer */
+	u8			buffer_tail_slot; /* Next slot in ->buffer_tail */
 	unsigned long long	i_size;		/* Size of the file */
 	unsigned long long	start;		/* Start position */
 	atomic64_t		issued_to;	/* Write issuer folio cursor */



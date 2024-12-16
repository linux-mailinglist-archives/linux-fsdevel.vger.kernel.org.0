Return-Path: <linux-fsdevel+bounces-37527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6B9F3B45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356A416E211
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE91DACAF;
	Mon, 16 Dec 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSymeZkp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0454A1DA619
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381735; cv=none; b=sAJLH/RV0wFUqlVbeeuWsp/EsUEYHLlI4DFh04SmhxqgdpUYO3sv+TZQpgIZZsBHUrCdwBWvIcQ19whPlyPm3ittQkJv4DahSA544gltFg6JOF/bRv+wtx2cqS/EXfZRcko3SBbvs1ce8zx57ERtajkojGhykcETzLST7rFPFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381735; c=relaxed/simple;
	bh=Udf0kDJRRM5DeprPgVJuLab+TgWhuMmAcXK/idVSNMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrufheCPvBWUzKuVQGrO0vzIZUfoxJelHJaB+5C/2D/otH08SZ9/h2iCduJuwnId6tEo4KqnWkKf7BWtZxgP/fEyA3F3526y7u5+0TkNUNb8oqu5mXsrjfSeNTdiXTicY0bg9Han84LVLTZ1bmc1MBhC9ViIPsPvgcsUG9GDleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSymeZkp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zm7ejUrBRt4RBLax7NY6iLHLBTpUXXUlxFKgWFT66M=;
	b=jSymeZkpbXGFyAXgFBJ8VNQjbuWQnuqzTOCRnlUQMbz9ln/62pkOwBn/7XbmW2OMnzGrar
	T4eAz1FPyoaeN9ub+ToGGRUanERC2W/60P26Dn0DUku0CEzpgh9/apUEp8MezPt4to5SB5
	BghdytxbpvtmxaHuZKfdZLAKzAv69OQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-iTHYUzFsOdCWPnTTlR5wGg-1; Mon,
 16 Dec 2024 15:42:08 -0500
X-MC-Unique: iTHYUzFsOdCWPnTTlR5wGg-1
X-Mimecast-MFC-AGG-ID: iTHYUzFsOdCWPnTTlR5wGg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B99819560AD;
	Mon, 16 Dec 2024 20:42:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E0C51956053;
	Mon, 16 Dec 2024 20:41:59 +0000 (UTC)
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
Subject: [PATCH v5 04/32] netfs: Add a tracepoint to log the lifespan of folio_queue structs
Date: Mon, 16 Dec 2024 20:40:54 +0000
Message-ID: <20241216204124.3752367-5-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a tracepoint to log the lifespan of folio_queue structs.  For tracing
illustrative purposes, folio_queues are tagged with the debug ID of
whatever they're related to (typically a netfs_io_request) and a debug ID
of their own.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c     | 10 ++++++---
 fs/netfs/internal.h          |  3 ++-
 fs/netfs/misc.c              | 31 +++++++++++++++++----------
 fs/netfs/read_collect.c      |  8 +++++--
 fs/netfs/write_issue.c       |  2 +-
 fs/smb/client/smb2ops.c      |  2 +-
 include/linux/folio_queue.h  | 12 ++++++++---
 include/linux/netfs.h        |  6 ++++--
 include/trace/events/netfs.h | 41 ++++++++++++++++++++++++++++++++++--
 lib/kunit_iov_iter.c         |  4 ++--
 10 files changed, 91 insertions(+), 28 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 78b04763bed6..7ec04d5628d8 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -131,7 +131,8 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 			struct folio_queue *tail = rreq->buffer_tail, *new;
 			size_t added;
 
-			new = netfs_folioq_alloc(GFP_NOFS);
+			new = netfs_folioq_alloc(rreq->debug_id, GFP_NOFS,
+						 netfs_trace_folioq_alloc_read_prep);
 			if (!new)
 				return -ENOMEM;
 			new->prev = tail;
@@ -361,9 +362,11 @@ static int netfs_prime_buffer(struct netfs_io_request *rreq)
 	struct folio_batch put_batch;
 	size_t added;
 
-	folioq = netfs_folioq_alloc(GFP_KERNEL);
+	folioq = netfs_folioq_alloc(rreq->debug_id, GFP_KERNEL,
+				    netfs_trace_folioq_alloc_read_prime);
 	if (!folioq)
 		return -ENOMEM;
+
 	rreq->buffer = folioq;
 	rreq->buffer_tail = folioq;
 	rreq->submitted = rreq->start;
@@ -436,7 +439,8 @@ static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct fo
 {
 	struct folio_queue *folioq;
 
-	folioq = netfs_folioq_alloc(GFP_KERNEL);
+	folioq = netfs_folioq_alloc(rreq->debug_id, GFP_KERNEL,
+				    netfs_trace_folioq_alloc_read_sing);
 	if (!folioq)
 		return -ENOMEM;
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index c562aec3b483..01b013f558f7 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -58,7 +58,8 @@ static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
 /*
  * misc.c
  */
-struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq);
+struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq,
+					    enum netfs_folioq_trace trace);
 int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
 			      bool needs_put);
 struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 6cd7e1ee7a14..afe032551de5 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -10,18 +10,25 @@
 
 /**
  * netfs_folioq_alloc - Allocate a folio_queue struct
+ * @rreq_id: Associated debugging ID for tracing purposes
  * @gfp: Allocation constraints
+ * @trace: Trace tag to indicate the purpose of the allocation
  *
- * Allocate, initialise and account the folio_queue struct.
+ * Allocate, initialise and account the folio_queue struct and log a trace line
+ * to mark the allocation.
  */
-struct folio_queue *netfs_folioq_alloc(gfp_t gfp)
+struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
+				       unsigned int /*enum netfs_folioq_trace*/ trace)
 {
+	static atomic_t debug_ids;
 	struct folio_queue *fq;
 
 	fq = kmalloc(sizeof(*fq), gfp);
 	if (fq) {
 		netfs_stat(&netfs_n_folioq);
-		folioq_init(fq);
+		folioq_init(fq, rreq_id);
+		fq->debug_id = atomic_inc_return(&debug_ids);
+		trace_netfs_folioq(fq, trace);
 	}
 	return fq;
 }
@@ -30,11 +37,14 @@ EXPORT_SYMBOL(netfs_folioq_alloc);
 /**
  * netfs_folioq_free - Free a folio_queue struct
  * @folioq: The object to free
+ * @trace: Trace tag to indicate which free
  *
  * Free and unaccount the folio_queue struct.
  */
-void netfs_folioq_free(struct folio_queue *folioq)
+void netfs_folioq_free(struct folio_queue *folioq,
+		       unsigned int /*enum netfs_trace_folioq*/ trace)
 {
+	trace_netfs_folioq(folioq, trace);
 	netfs_stat_d(&netfs_n_folioq);
 	kfree(folioq);
 }
@@ -43,7 +53,8 @@ EXPORT_SYMBOL(netfs_folioq_free);
 /*
  * Make sure there's space in the rolling queue.
  */
-struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq)
+struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq,
+					    enum netfs_folioq_trace trace)
 {
 	struct folio_queue *tail = rreq->buffer_tail, *prev;
 	unsigned int prev_nr_slots = 0;
@@ -59,11 +70,9 @@ struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rreq)
 		prev_nr_slots = folioq_nr_slots(tail);
 	}
 
-	tail = kmalloc(sizeof(*tail), GFP_NOFS);
+	tail = netfs_folioq_alloc(rreq->debug_id, GFP_NOFS, trace);
 	if (!tail)
 		return ERR_PTR(-ENOMEM);
-	netfs_stat(&netfs_n_folioq);
-	folioq_init(tail);
 	tail->prev = prev;
 	if (prev)
 		/* [!] NOTE: After we set prev->next, the consumer is entirely
@@ -98,7 +107,7 @@ int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio
 	struct folio_queue *tail;
 	unsigned int slot, order = folio_order(folio);
 
-	tail = netfs_buffer_make_space(rreq);
+	tail = netfs_buffer_make_space(rreq, netfs_trace_folioq_alloc_append_folio);
 	if (IS_ERR(tail))
 		return PTR_ERR(tail);
 
@@ -119,7 +128,7 @@ struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq)
 
 	if (next)
 		next->prev = NULL;
-	netfs_folioq_free(head);
+	netfs_folioq_free(head, netfs_trace_folioq_delete);
 	wreq->buffer = next;
 	return next;
 }
@@ -142,7 +151,7 @@ void netfs_clear_buffer(struct netfs_io_request *rreq)
 				folio_put(folio);
 			}
 		}
-		netfs_folioq_free(p);
+		netfs_folioq_free(p, netfs_trace_folioq_clear);
 	}
 }
 
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index e8624f5c7fcc..f7a5cb29dd12 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -103,6 +103,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 		 subreq->transferred, subreq->len))
 		subreq->transferred = subreq->len;
 
+	trace_netfs_folioq(folioq, netfs_trace_folioq_read_progress);
 next_folio:
 	fsize = PAGE_SIZE << subreq->curr_folio_order;
 	fpos = round_down(subreq->start + subreq->consumed, fsize);
@@ -119,9 +120,11 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 		if (folioq) {
 			struct folio *folio = folioq_folio(folioq, slot);
 
-			pr_err("folioq: orders=%02x%02x%02x%02x\n",
+			pr_err("folioq: fq=%x orders=%02x%02x%02x%02x %px\n",
+			       folioq->debug_id,
 			       folioq->orders[0], folioq->orders[1],
-			       folioq->orders[2], folioq->orders[3]);
+			       folioq->orders[2], folioq->orders[3],
+			       folioq);
 			if (folio)
 				pr_err("folio: %llx-%llx ix=%llx o=%u qo=%u\n",
 				       fpos, fend - 1, folio_pos(folio), folio_order(folio),
@@ -222,6 +225,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 			slot = 0;
 			folioq = folioq->next;
 			subreq->curr_folioq = folioq;
+			trace_netfs_folioq(folioq, netfs_trace_folioq_read_progress);
 		}
 		subreq->curr_folioq_slot = slot;
 		if (folioq && folioq_folio(folioq, slot))
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index ff0e82505a0b..87e5cf4a0957 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -161,7 +161,7 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 	 */
 	if (iov_iter_is_folioq(wreq_iter) &&
 	    wreq_iter->folioq_slot >= folioq_nr_slots(wreq_iter->folioq)) {
-		netfs_buffer_make_space(wreq);
+		netfs_buffer_make_space(wreq, netfs_trace_folioq_prep_write);
 	}
 
 	subreq = netfs_alloc_subrequest(wreq);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 87cb1872db28..7121d9e0f404 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4388,7 +4388,7 @@ static struct folio_queue *cifs_alloc_folioq_buffer(ssize_t size)
 			p = kmalloc(sizeof(*p), GFP_NOFS);
 			if (!p)
 				goto nomem;
-			folioq_init(p);
+			folioq_init(p, 0);
 			if (tail) {
 				tail->next = p;
 				p->prev = tail;
diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
index 3abe614ef5f0..4d3f8074c137 100644
--- a/include/linux/folio_queue.h
+++ b/include/linux/folio_queue.h
@@ -37,16 +37,20 @@ struct folio_queue {
 #if PAGEVEC_SIZE > BITS_PER_LONG
 #error marks is not big enough
 #endif
+	unsigned int		rreq_id;
+	unsigned int		debug_id;
 };
 
 /**
  * folioq_init - Initialise a folio queue segment
  * @folioq: The segment to initialise
+ * @rreq_id: The request identifier to use in tracelines.
  *
- * Initialise a folio queue segment.  Note that the folio pointers are
- * left uninitialised.
+ * Initialise a folio queue segment and set an identifier to be used in traces.
+ *
+ * Note that the folio pointers are left uninitialised.
  */
-static inline void folioq_init(struct folio_queue *folioq)
+static inline void folioq_init(struct folio_queue *folioq, unsigned int rreq_id)
 {
 	folio_batch_init(&folioq->vec);
 	folioq->next = NULL;
@@ -54,6 +58,8 @@ static inline void folioq_init(struct folio_queue *folioq)
 	folioq->marks = 0;
 	folioq->marks2 = 0;
 	folioq->marks3 = 0;
+	folioq->rreq_id = rreq_id;
+	folioq->debug_id = 0;
 }
 
 /**
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c69e0f02c30f..5b2f427f8e3e 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -455,8 +455,10 @@ int netfs_start_io_direct(struct inode *inode);
 void netfs_end_io_direct(struct inode *inode);
 
 /* Miscellaneous APIs. */
-struct folio_queue *netfs_folioq_alloc(gfp_t gfp);
-void netfs_folioq_free(struct folio_queue *folioq);
+struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
+				       unsigned int trace /*enum netfs_folioq_trace*/);
+void netfs_folioq_free(struct folio_queue *folioq,
+		       unsigned int trace /*enum netfs_trace_folioq*/);
 
 /**
  * netfs_inode - Get the netfs inode context from the inode
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index c3c309f8fbe1..50aa6745df95 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -191,6 +191,16 @@
 	EM(netfs_trace_donate_to_next,		"to-next")	\
 	E_(netfs_trace_donate_to_deferred_next,	"defer-next")
 
+#define netfs_folioq_traces					\
+	EM(netfs_trace_folioq_alloc_append_folio, "alloc-apf")	\
+	EM(netfs_trace_folioq_alloc_read_prep,	"alloc-r-prep")	\
+	EM(netfs_trace_folioq_alloc_read_prime,	"alloc-r-prime") \
+	EM(netfs_trace_folioq_alloc_read_sing,	"alloc-r-sing")	\
+	EM(netfs_trace_folioq_clear,		"clear")	\
+	EM(netfs_trace_folioq_delete,		"delete")	\
+	EM(netfs_trace_folioq_prep_write,	"prep-wr")	\
+	E_(netfs_trace_folioq_read_progress,	"r-progress")
+
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
@@ -209,6 +219,7 @@ enum netfs_sreq_ref_trace { netfs_sreq_ref_traces } __mode(byte);
 enum netfs_folio_trace { netfs_folio_traces } __mode(byte);
 enum netfs_collect_contig_trace { netfs_collect_contig_traces } __mode(byte);
 enum netfs_donate_trace { netfs_donate_traces } __mode(byte);
+enum netfs_folioq_trace { netfs_folioq_traces } __mode(byte);
 
 #endif
 
@@ -232,6 +243,7 @@ netfs_sreq_ref_traces;
 netfs_folio_traces;
 netfs_collect_contig_traces;
 netfs_donate_traces;
+netfs_folioq_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -317,6 +329,7 @@ TRACE_EVENT(netfs_sreq,
 		    __field(unsigned short,		flags)
 		    __field(enum netfs_io_source,	source)
 		    __field(enum netfs_sreq_trace,	what)
+		    __field(u8,				slot)
 		    __field(size_t,			len)
 		    __field(size_t,			transferred)
 		    __field(loff_t,			start)
@@ -332,15 +345,16 @@ TRACE_EVENT(netfs_sreq,
 		    __entry->len	= sreq->len;
 		    __entry->transferred = sreq->transferred;
 		    __entry->start	= sreq->start;
+		    __entry->slot	= sreq->curr_folioq_slot;
 			   ),
 
-	    TP_printk("R=%08x[%x] %s %s f=%02x s=%llx %zx/%zx e=%d",
+	    TP_printk("R=%08x[%x] %s %s f=%02x s=%llx %zx/%zx s=%u e=%d",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __print_symbolic(__entry->what, netfs_sreq_traces),
 		      __entry->flags,
 		      __entry->start, __entry->transferred, __entry->len,
-		      __entry->error)
+		      __entry->slot, __entry->error)
 	    );
 
 TRACE_EVENT(netfs_failure,
@@ -745,6 +759,29 @@ TRACE_EVENT(netfs_donate,
 		      __entry->amount)
 	    );
 
+TRACE_EVENT(netfs_folioq,
+	    TP_PROTO(const struct folio_queue *fq,
+		     enum netfs_folioq_trace trace),
+
+	    TP_ARGS(fq, trace),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		id)
+		    __field(enum netfs_folioq_trace,	trace)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= fq ? fq->rreq_id : 0;
+		    __entry->id		= fq ? fq->debug_id : 0;
+		    __entry->trace	= trace;
+			   ),
+
+	    TP_printk("R=%08x fq=%x %s",
+		      __entry->rreq, __entry->id,
+		      __print_symbolic(__entry->trace, netfs_folioq_traces))
+	    );
+
 #undef EM
 #undef E_
 #endif /* _TRACE_NETFS_H */
diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 13e15687675a..10a560feb66e 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -392,7 +392,7 @@ static void __init iov_kunit_load_folioq(struct kunit *test,
 		if (folioq_full(p)) {
 			p->next = kzalloc(sizeof(struct folio_queue), GFP_KERNEL);
 			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p->next);
-			folioq_init(p->next);
+			folioq_init(p->next, 0);
 			p->next->prev = p;
 			p = p->next;
 		}
@@ -409,7 +409,7 @@ static struct folio_queue *iov_kunit_create_folioq(struct kunit *test)
 	folioq = kzalloc(sizeof(struct folio_queue), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, folioq);
 	kunit_add_action_or_reset(test, iov_kunit_destroy_folioq, folioq);
-	folioq_init(folioq);
+	folioq_init(folioq, 0);
 	return folioq;
 }
 



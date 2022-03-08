Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99404D2705
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 05:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiCICrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 21:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiCICrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:47:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A2D55FDA
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 18:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646793962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7Kc/H6FWSYcr5qXExPqzb430QVwbzgv+AyHNac4hwo=;
        b=AaRiWUWIbHzrtLSysRnEdKbZ5LZFFCzzAbZvPFjFJOLsmaHV/ipRlegpjCw5Ba8AWl29nL
        J5Fe493GhpXIK3hIP4oLoD0JVERPaAhSCFbwBM6SAzBMMzgOBzM7jZNpiMSQzsnQlnbIik
        tBRBERQkNR7MP61U536gRLy97H6aTDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-HCPTkPayMTCzF72rACPO-Q-1; Tue, 08 Mar 2022 18:27:22 -0500
X-MC-Unique: HCPTkPayMTCzF72rACPO-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A02AE1006AA5;
        Tue,  8 Mar 2022 23:27:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E103F4E2B6;
        Tue,  8 Mar 2022 23:27:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 08/19] netfs: Trace refcounting on the netfs_io_subrequest
 struct
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Mar 2022 23:27:06 +0000
Message-ID: <164678202603.1200972.14726007419792315578.stgit@warthog.procyon.org.uk>
In-Reply-To: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add refcount tracing for the netfs_io_subrequest structure.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com

Link: https://lore.kernel.org/r/164622998584.3564931.5052255990645723639.stgit@warthog.procyon.org.uk/ # v1
---

 fs/netfs/internal.h          |    2 --
 fs/netfs/objects.c           |   32 +++++++++++++++++++++++---------
 fs/netfs/read_helper.c       |   20 +++++++++++---------
 include/linux/netfs.h        |    8 +++++++-
 include/trace/events/netfs.h |   40 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+), 21 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 89b02357500d..a0b7d1bf9f3d 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -25,8 +25,6 @@ void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async);
 void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
 		       enum netfs_rreq_ref_trace what);
 struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq);
-void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async);
-void netfs_get_subrequest(struct netfs_io_subrequest *subreq);
 
 static inline void netfs_see_request(struct netfs_io_request *rreq,
 				     enum netfs_rreq_ref_trace what)
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 4e29c3bb6e5a..39097893e847 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -53,7 +53,8 @@ void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
 		subreq = list_first_entry(&rreq->subrequests,
 					  struct netfs_io_subrequest, rreq_link);
 		list_del(&subreq->rreq_link);
-		netfs_put_subrequest(subreq, was_async);
+		netfs_put_subrequest(subreq, was_async,
+				     netfs_sreq_trace_put_clear);
 	}
 }
 
@@ -101,7 +102,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
 	if (subreq) {
 		INIT_LIST_HEAD(&subreq->rreq_link);
-		refcount_set(&subreq->usage, 2);
+		refcount_set(&subreq->ref, 2);
 		subreq->rreq = rreq;
 		netfs_get_request(rreq, netfs_rreq_trace_get_subreq);
 		netfs_stat(&netfs_n_rh_sreq);
@@ -110,13 +111,18 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 	return subreq;
 }
 
-void netfs_get_subrequest(struct netfs_io_subrequest *subreq)
+void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
+			  enum netfs_sreq_ref_trace what)
 {
-	refcount_inc(&subreq->usage);
+	int r;
+
+	__refcount_inc(&subreq->ref, &r);
+	trace_netfs_sreq_ref(subreq->rreq->debug_id, subreq->debug_index, r + 1,
+			     what);
 }
 
-static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
-				   bool was_async)
+static void netfs_free_subrequest(struct netfs_io_subrequest *subreq,
+				  bool was_async)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 
@@ -126,8 +132,16 @@ static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_subreq);
 }
 
-void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async)
+void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async,
+			  enum netfs_sreq_ref_trace what)
 {
-	if (refcount_dec_and_test(&subreq->usage))
-		__netfs_put_subrequest(subreq, was_async);
+	unsigned int debug_index = subreq->debug_index;
+	unsigned int debug_id = subreq->rreq->debug_id;
+	bool dead;
+	int r;
+
+	dead = __refcount_dec_and_test(&subreq->ref, &r);
+	trace_netfs_sreq_ref(debug_id, debug_index, r - 1, what);
+	if (dead)
+		netfs_free_subrequest(subreq, was_async);
 }
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 620c3be5ec0a..8f277da487b6 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -167,7 +167,7 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
 	if (atomic_dec_and_test(&rreq->nr_copy_ops))
 		netfs_rreq_unmark_after_write(rreq, was_async);
 
-	netfs_put_subrequest(subreq, was_async);
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
 }
 
 /*
@@ -191,7 +191,8 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
 		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
 			list_del_init(&subreq->rreq_link);
-			netfs_put_subrequest(subreq, false);
+			netfs_put_subrequest(subreq, false,
+					     netfs_sreq_trace_put_no_copy);
 		}
 	}
 
@@ -203,7 +204,8 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 				break;
 			subreq->len += next->len;
 			list_del_init(&next->rreq_link);
-			netfs_put_subrequest(next, false);
+			netfs_put_subrequest(next, false,
+					     netfs_sreq_trace_put_merged);
 		}
 
 		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
@@ -219,7 +221,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 
 		atomic_inc(&rreq->nr_copy_ops);
 		netfs_stat(&netfs_n_rh_write);
-		netfs_get_subrequest(subreq);
+		netfs_get_subrequest(subreq, netfs_sreq_trace_get_copy_to_cache);
 		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
 		cres->ops->write(cres, subreq->start, &iter,
 				 netfs_rreq_copy_terminated, subreq);
@@ -342,7 +344,7 @@ static void netfs_rreq_short_read(struct netfs_io_request *rreq,
 	netfs_stat(&netfs_n_rh_short_read);
 	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
 
-	netfs_get_subrequest(subreq);
+	netfs_get_subrequest(subreq, netfs_sreq_trace_get_short_read);
 	atomic_inc(&rreq->nr_outstanding);
 	if (subreq->source == NETFS_READ_FROM_CACHE)
 		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
@@ -376,7 +378,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 			subreq->error = 0;
 			netfs_stat(&netfs_n_rh_download_instead);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
-			netfs_get_subrequest(subreq);
+			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 			atomic_inc(&rreq->nr_outstanding);
 			netfs_read_from_server(rreq, subreq);
 		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
@@ -538,7 +540,7 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 	else if (u == 1)
 		wake_up_var(&rreq->nr_outstanding);
 
-	netfs_put_subrequest(subreq, was_async);
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
 	return;
 
 incomplete:
@@ -683,7 +685,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 
 subreq_failed:
 	rreq->error = subreq->error;
-	netfs_put_subrequest(subreq, false);
+	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_failed);
 	return false;
 }
 
@@ -1030,13 +1032,13 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	 */
 	ractl._nr_pages = folio_nr_pages(folio);
 	netfs_rreq_expand(rreq, &ractl);
+	netfs_get_request(rreq, netfs_rreq_trace_get_hold);
 
 	/* We hold the folio locks, so we can drop the references */
 	folio_get(folio);
 	while (readahead_folio(&ractl))
 		;
 
-	netfs_get_request(rreq, netfs_rreq_trace_get_hold);
 	atomic_set(&rreq->nr_outstanding, 1);
 	do {
 		if (!netfs_rreq_submit_slice(rreq, &debug_index))
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 541aebe828f3..c702bd8ea8da 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -18,6 +18,8 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 
+enum netfs_sreq_ref_trace;
+
 /*
  * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
  * a page is currently backed by a local disk cache
@@ -136,7 +138,7 @@ struct netfs_io_subrequest {
 	loff_t			start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
-	refcount_t		usage;
+	refcount_t		ref;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
 	enum netfs_io_source	source;		/* Where to read from/write to */
@@ -268,6 +270,10 @@ extern int netfs_write_begin(struct file *, struct address_space *,
 			     void *);
 
 extern void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
+extern void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
+				 enum netfs_sreq_ref_trace what);
+extern void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
+				 bool was_async, enum netfs_sreq_ref_trace what);
 extern void netfs_stats_show(struct seq_file *);
 
 #endif /* _LINUX_NETFS_H */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 602f3854da81..ddf34cb476dc 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -64,6 +64,17 @@
 	EM(netfs_rreq_trace_put_subreq,		"PUT SUBREQ ")	\
 	E_(netfs_rreq_trace_new,		"NEW        ")
 
+#define netfs_sreq_ref_traces					\
+	EM(netfs_sreq_trace_get_copy_to_cache,	"GET COPY2C ")	\
+	EM(netfs_sreq_trace_get_resubmit,	"GET RESUBMIT")	\
+	EM(netfs_sreq_trace_get_short_read,	"GET SHORTRD")	\
+	EM(netfs_sreq_trace_new,		"NEW        ")	\
+	EM(netfs_sreq_trace_put_clear,		"PUT CLEAR  ")	\
+	EM(netfs_sreq_trace_put_failed,		"PUT FAILED ")	\
+	EM(netfs_sreq_trace_put_merged,		"PUT MERGED ")	\
+	EM(netfs_sreq_trace_put_no_copy,	"PUT NO COPY")	\
+	E_(netfs_sreq_trace_put_terminated,	"PUT TERM   ")
+
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
@@ -77,6 +88,7 @@ enum netfs_rreq_trace { netfs_rreq_traces } __mode(byte);
 enum netfs_sreq_trace { netfs_sreq_traces } __mode(byte);
 enum netfs_failure { netfs_failures } __mode(byte);
 enum netfs_rreq_ref_trace { netfs_rreq_ref_traces } __mode(byte);
+enum netfs_sreq_ref_trace { netfs_sreq_ref_traces } __mode(byte);
 
 #endif
 
@@ -94,6 +106,7 @@ netfs_sreq_sources;
 netfs_sreq_traces;
 netfs_failures;
 netfs_rreq_ref_traces;
+netfs_sreq_ref_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -264,6 +277,33 @@ TRACE_EVENT(netfs_rreq_ref,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(netfs_sreq_ref,
+	    TP_PROTO(unsigned int rreq_debug_id, unsigned int subreq_debug_index,
+		     int ref, enum netfs_sreq_ref_trace what),
+
+	    TP_ARGS(rreq_debug_id, subreq_debug_index, ref, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq		)
+		    __field(unsigned int,		subreq		)
+		    __field(int,			ref		)
+		    __field(enum netfs_sreq_ref_trace,	what		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= rreq_debug_id;
+		    __entry->subreq	= subreq_debug_index;
+		    __entry->ref	= ref;
+		    __entry->what	= what;
+			   ),
+
+	    TP_printk("W=%08x[%x] %s r=%u",
+		      __entry->rreq,
+		      __entry->subreq,
+		      __print_symbolic(__entry->what, netfs_sreq_ref_traces),
+		      __entry->ref)
+	    );
+
 #endif /* _TRACE_NETFS_H */
 
 /* This part must be outside protection */



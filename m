Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C04D2765
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 05:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiCIBle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiCIBld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6DA3D4CA7
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 17:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646790004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Dm73HKryRcDrtYjImV9fbgn7Spam0xsEHyr2O+F4/s=;
        b=Zpx4cE0CaHA/7rQzxGYUU0ZVYmA7sNXWI43qT/7M35FFH+gtI33BE81oXeQPo7mKzday9c
        otaAKFTnOuPcmORch++Tcaozk+z5vqoy96kvyMYB9vykp4fNHLOMqNJTEFqpucBQMYVuds
        AsLCPpgyb0fXb5EQHz9uU90aN0fwseA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-k5zF9KpjNxWx46Zu0c2c8w-1; Tue, 08 Mar 2022 18:27:02 -0500
X-MC-Unique: k5zF9KpjNxWx46Zu0c2c8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C65A71800D50;
        Tue,  8 Mar 2022 23:27:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D0325FC22;
        Tue,  8 Mar 2022 23:26:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 07/19] netfs: Trace refcounting on the netfs_io_request
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
Date:   Tue, 08 Mar 2022 23:26:49 +0000
Message-ID: <164678200943.1200972.7241495532327787765.stgit@warthog.procyon.org.uk>
In-Reply-To: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add refcount tracing for the netfs_io_request structure.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com

Link: https://lore.kernel.org/r/164622997668.3564931.14456171619219324968.stgit@warthog.procyon.org.uk/ # v1
---

 fs/netfs/internal.h          |   11 +++++++++--
 fs/netfs/objects.c           |   24 +++++++++++++++++-------
 fs/netfs/read_helper.c       |   14 +++++++-------
 include/linux/netfs.h        |    2 +-
 include/trace/events/netfs.h |   35 +++++++++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index cf7a3ddb16a4..89b02357500d 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -20,13 +20,20 @@
 struct netfs_io_request *netfs_alloc_request(const struct netfs_request_ops *ops,
 					     void *netfs_priv,
 					     struct file *file);
-void netfs_get_request(struct netfs_io_request *rreq);
+void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what);
 void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async);
-void netfs_put_request(struct netfs_io_request *rreq, bool was_async);
+void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
+		       enum netfs_rreq_ref_trace what);
 struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq);
 
+static inline void netfs_see_request(struct netfs_io_request *rreq,
+				     enum netfs_rreq_ref_trace what)
+{
+	trace_netfs_rreq_ref(rreq->debug_id, refcount_read(&rreq->ref), what);
+}
+
 /*
  * read_helper.c
  */
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index f7383c28dc6e..4e29c3bb6e5a 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -27,7 +27,7 @@ struct netfs_io_request *netfs_alloc_request(
 		rreq->debug_id	= atomic_inc_return(&debug_ids);
 		INIT_LIST_HEAD(&rreq->subrequests);
 		INIT_WORK(&rreq->work, netfs_rreq_work);
-		refcount_set(&rreq->usage, 1);
+		refcount_set(&rreq->ref, 1);
 		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 		if (ops->init_request)
 			ops->init_request(rreq, file);
@@ -37,9 +37,12 @@ struct netfs_io_request *netfs_alloc_request(
 	return rreq;
 }
 
-void netfs_get_request(struct netfs_io_request *rreq)
+void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what)
 {
-	refcount_inc(&rreq->usage);
+	int r;
+
+	__refcount_inc(&rreq->ref, &r);
+	trace_netfs_rreq_ref(rreq->debug_id, r + 1, what);
 }
 
 void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
@@ -68,9 +71,16 @@ static void netfs_free_request(struct work_struct *work)
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 
-void netfs_put_request(struct netfs_io_request *rreq, bool was_async)
+void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
+		       enum netfs_rreq_ref_trace what)
 {
-	if (refcount_dec_and_test(&rreq->usage)) {
+	unsigned int debug_id = rreq->debug_id;
+	bool dead;
+	int r;
+
+	dead = __refcount_dec_and_test(&rreq->ref, &r);
+	trace_netfs_rreq_ref(debug_id, r - 1, what);
+	if (dead) {
 		if (was_async) {
 			rreq->work.func = netfs_free_request;
 			if (!queue_work(system_unbound_wq, &rreq->work))
@@ -93,7 +103,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->usage, 2);
 		subreq->rreq = rreq;
-		netfs_get_request(rreq);
+		netfs_get_request(rreq, netfs_rreq_trace_get_subreq);
 		netfs_stat(&netfs_n_rh_sreq);
 	}
 
@@ -113,7 +123,7 @@ static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
 	kfree(subreq);
 	netfs_stat_d(&netfs_n_rh_sreq);
-	netfs_put_request(rreq, was_async);
+	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_subreq);
 }
 
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async)
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 181aeda32649..620c3be5ec0a 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -109,7 +109,7 @@ static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_clear_subrequests(rreq, was_async);
-	netfs_put_request(rreq, was_async);
+	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
 }
 
 /*
@@ -799,7 +799,7 @@ void netfs_readahead(struct readahead_control *ractl,
 	return;
 
 cleanup_free:
-	netfs_put_request(rreq, false);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
 	return;
 cleanup:
 	if (netfs_priv)
@@ -858,7 +858,7 @@ int netfs_readpage(struct file *file,
 	netfs_stat(&netfs_n_rh_readpage);
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
-	netfs_get_request(rreq);
+	netfs_get_request(rreq, netfs_rreq_trace_get_hold);
 
 	atomic_set(&rreq->nr_outstanding, 1);
 	do {
@@ -883,7 +883,7 @@ int netfs_readpage(struct file *file,
 		ret = -EIO;
 	}
 out:
-	netfs_put_request(rreq, false);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_readpage);
@@ -1030,13 +1030,13 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	 */
 	ractl._nr_pages = folio_nr_pages(folio);
 	netfs_rreq_expand(rreq, &ractl);
-	netfs_get_request(rreq);
 
 	/* We hold the folio locks, so we can drop the references */
 	folio_get(folio);
 	while (readahead_folio(&ractl))
 		;
 
+	netfs_get_request(rreq, netfs_rreq_trace_get_hold);
 	atomic_set(&rreq->nr_outstanding, 1);
 	do {
 		if (!netfs_rreq_submit_slice(rreq, &debug_index))
@@ -1062,7 +1062,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_write_begin);
 		ret = -EIO;
 	}
-	netfs_put_request(rreq, false);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
 	if (ret < 0)
 		goto error;
 
@@ -1078,7 +1078,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	return 0;
 
 error_put:
-	netfs_put_request(rreq, false);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
 error:
 	folio_unlock(folio);
 	folio_put(folio);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f63de27d6f29..541aebe828f3 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -168,7 +168,7 @@ struct netfs_io_request {
 	loff_t			i_size;		/* Size of the file */
 	loff_t			start;		/* Start position */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
-	refcount_t		usage;
+	refcount_t		ref;
 	unsigned long		flags;
 #define NETFS_RREQ_INCOMPLETE_IO	0	/* Some ioreqs terminated short or with error */
 #define NETFS_RREQ_COPY_TO_CACHE	1	/* Need to write to the cache */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index daf171de2142..602f3854da81 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -55,6 +55,15 @@
 	EM(netfs_fail_short_write_begin,	"short-write-begin")	\
 	E_(netfs_fail_prepare_write,		"prep-write")
 
+#define netfs_rreq_ref_traces					\
+	EM(netfs_rreq_trace_get_hold,		"GET HOLD   ")	\
+	EM(netfs_rreq_trace_get_subreq,		"GET SUBREQ ")	\
+	EM(netfs_rreq_trace_put_complete,	"PUT COMPLT ")	\
+	EM(netfs_rreq_trace_put_failed,		"PUT FAILED ")	\
+	EM(netfs_rreq_trace_put_hold,		"PUT HOLD   ")	\
+	EM(netfs_rreq_trace_put_subreq,		"PUT SUBREQ ")	\
+	E_(netfs_rreq_trace_new,		"NEW        ")
+
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
@@ -67,6 +76,7 @@ enum netfs_read_trace { netfs_read_traces } __mode(byte);
 enum netfs_rreq_trace { netfs_rreq_traces } __mode(byte);
 enum netfs_sreq_trace { netfs_sreq_traces } __mode(byte);
 enum netfs_failure { netfs_failures } __mode(byte);
+enum netfs_rreq_ref_trace { netfs_rreq_ref_traces } __mode(byte);
 
 #endif
 
@@ -83,6 +93,7 @@ netfs_rreq_traces;
 netfs_sreq_sources;
 netfs_sreq_traces;
 netfs_failures;
+netfs_rreq_ref_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -229,6 +240,30 @@ TRACE_EVENT(netfs_failure,
 		      __entry->error)
 	    );
 
+TRACE_EVENT(netfs_rreq_ref,
+	    TP_PROTO(unsigned int rreq_debug_id, int ref,
+		     enum netfs_rreq_ref_trace what),
+
+	    TP_ARGS(rreq_debug_id, ref, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq		)
+		    __field(int,			ref		)
+		    __field(enum netfs_rreq_ref_trace,	what		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= rreq_debug_id;
+		    __entry->ref	= ref;
+		    __entry->what	= what;
+			   ),
+
+	    TP_printk("W=%08x %s r=%u",
+		      __entry->rreq,
+		      __print_symbolic(__entry->what, netfs_rreq_ref_traces),
+		      __entry->ref)
+	    );
+
 #endif /* _TRACE_NETFS_H */
 
 /* This part must be outside protection */



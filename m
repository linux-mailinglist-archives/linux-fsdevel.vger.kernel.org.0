Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148964D4EB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbiCJQSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiCJQSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:18:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC0748F62D
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646929054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXbsOXzkyN9JgejgqHvAKCfU0+Q+YRouEiup8jS1dlo=;
        b=bCX6o7aFuXcovfB/02kS6jXqyLGdAbyrphuyxUujjSMAliIpvweOaZ+P/i15+jam3fNakg
        xxPSMPYzvyvhTLNrnO/leRK24nSXMO60zlfyW+n0Du41hRd/P+ukSWKVnNGu9nr3PI1rNV
        JjDElb7B+ESPu3wL6UOVQapYk1rlZZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-0vYNfF2iPAmUbqj8UFxF8w-1; Thu, 10 Mar 2022 11:17:30 -0500
X-MC-Unique: 0vYNfF2iPAmUbqj8UFxF8w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9D7C51DC;
        Thu, 10 Mar 2022 16:17:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61BC97F0D9;
        Thu, 10 Mar 2022 16:17:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 10/20] netfs: Refactor arguments for
 netfs_alloc_read_request
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
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
Date:   Thu, 10 Mar 2022 16:17:21 +0000
Message-ID: <164692904155.2099075.14717645623034355995.stgit@warthog.procyon.org.uk>
In-Reply-To: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Pass start and len to the rreq allocator. This should ensure that the
fields are set so that ->init_request() can use them.

Also add a parameter to indicates the origin of the request.  Ceph can use
this to tell whether to get caps.

Changes
=======
ver #3)
 - Change the author to me as Jeff feels that most of the patch is my
   changes now.

ver #2)
 - Show the request origin in the netfs_rreq tracepoint.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Co-developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/164622989020.3564931.17517006047854958747.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/164678208569.1200972.12153682697842916557.stgit@warthog.procyon.org.uk/ # v2
---

 fs/netfs/internal.h          |    7 +++++--
 fs/netfs/objects.c           |   13 ++++++++++---
 fs/netfs/read_helper.c       |   23 +++++++++++------------
 include/linux/netfs.h        |    7 +++++++
 include/trace/events/netfs.h |   11 ++++++++++-
 5 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index a0b7d1bf9f3d..89837e904fa7 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -17,9 +17,12 @@
 /*
  * objects.c
  */
-struct netfs_io_request *netfs_alloc_request(const struct netfs_request_ops *ops,
+struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
+					     struct file *file,
+					     const struct netfs_request_ops *ops,
 					     void *netfs_priv,
-					     struct file *file);
+					     loff_t start, size_t len,
+					     enum netfs_io_origin origin);
 void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what);
 void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async);
 void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 39097893e847..986d7a9d25dd 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -11,17 +11,24 @@
 /*
  * Allocate an I/O request and initialise it.
  */
-struct netfs_io_request *netfs_alloc_request(
-	const struct netfs_request_ops *ops, void *netfs_priv,
-	struct file *file)
+struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
+					     struct file *file,
+					     const struct netfs_request_ops *ops,
+					     void *netfs_priv,
+					     loff_t start, size_t len,
+					     enum netfs_io_origin origin)
 {
 	static atomic_t debug_ids;
 	struct netfs_io_request *rreq;
 
 	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
 	if (rreq) {
+		rreq->start	= start;
+		rreq->len	= len;
+		rreq->origin	= origin;
 		rreq->netfs_ops	= ops;
 		rreq->netfs_priv = netfs_priv;
+		rreq->mapping	= mapping;
 		rreq->inode	= file_inode(file);
 		rreq->i_size	= i_size_read(rreq->inode);
 		rreq->debug_id	= atomic_inc_return(&debug_ids);
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 8f277da487b6..dea085715286 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -763,12 +763,13 @@ void netfs_readahead(struct readahead_control *ractl,
 	if (readahead_count(ractl) == 0)
 		goto cleanup;
 
-	rreq = netfs_alloc_request(ops, netfs_priv, ractl->file);
+	rreq = netfs_alloc_request(ractl->mapping, ractl->file,
+				   ops, netfs_priv,
+				   readahead_pos(ractl),
+				   readahead_length(ractl),
+				   NETFS_READAHEAD);
 	if (!rreq)
 		goto cleanup;
-	rreq->mapping	= ractl->mapping;
-	rreq->start	= readahead_pos(ractl);
-	rreq->len	= readahead_length(ractl);
 
 	if (ops->begin_cache_operation) {
 		ret = ops->begin_cache_operation(rreq);
@@ -838,16 +839,15 @@ int netfs_readpage(struct file *file,
 
 	_enter("%lx", folio_index(folio));
 
-	rreq = netfs_alloc_request(ops, netfs_priv, file);
+	rreq = netfs_alloc_request(folio->mapping, file, ops, netfs_priv,
+				   folio_file_pos(folio), folio_size(folio),
+				   NETFS_READPAGE);
 	if (!rreq) {
 		if (netfs_priv)
 			ops->cleanup(folio_file_mapping(folio), netfs_priv);
 		folio_unlock(folio);
 		return -ENOMEM;
 	}
-	rreq->mapping	= folio_file_mapping(folio);
-	rreq->start	= folio_file_pos(folio);
-	rreq->len	= folio_size(folio);
 
 	if (ops->begin_cache_operation) {
 		ret = ops->begin_cache_operation(rreq);
@@ -1008,12 +1008,11 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 	ret = -ENOMEM;
-	rreq = netfs_alloc_request(ops, netfs_priv, file);
+	rreq = netfs_alloc_request(mapping, file, ops, netfs_priv,
+				   folio_file_pos(folio), folio_size(folio),
+				   NETFS_READ_FOR_WRITE);
 	if (!rreq)
 		goto error;
-	rreq->mapping		= folio_file_mapping(folio);
-	rreq->start		= folio_file_pos(folio);
-	rreq->len		= folio_size(folio);
 	rreq->no_unlock_folio	= folio_index(folio);
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 	netfs_priv = NULL;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c702bd8ea8da..7dc741d9b21b 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -150,6 +150,12 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
 };
 
+enum netfs_io_origin {
+	NETFS_READAHEAD,		/* This read was triggered by readahead */
+	NETFS_READPAGE,			/* This read is a synchronous read */
+	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
+} __mode(byte);
+
 /*
  * Descriptor for an I/O helper request.  This is used to make multiple I/O
  * operations to a variety of data stores and then stitch the result together.
@@ -167,6 +173,7 @@ struct netfs_io_request {
 	size_t			submitted;	/* Amount submitted for I/O so far */
 	size_t			len;		/* Length of the request */
 	short			error;		/* 0 or error that occurred */
+	enum netfs_io_origin	origin;		/* Origin of the request */
 	loff_t			i_size;		/* Size of the file */
 	loff_t			start;		/* Start position */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 556859b0f107..f00e3e1821c8 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -21,6 +21,11 @@
 	EM(netfs_read_trace_readpage,		"READPAGE ")	\
 	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
+#define netfs_rreq_origins					\
+	EM(NETFS_READAHEAD,			"RA")		\
+	EM(NETFS_READPAGE,			"RP")		\
+	E_(NETFS_READ_FOR_WRITE,		"RW")
+
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
 	EM(netfs_rreq_trace_copy,		"COPY   ")	\
@@ -101,6 +106,7 @@ enum netfs_sreq_ref_trace { netfs_sreq_ref_traces } __mode(byte);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
 netfs_read_traces;
+netfs_rreq_origins;
 netfs_rreq_traces;
 netfs_sreq_sources;
 netfs_sreq_traces;
@@ -159,17 +165,20 @@ TRACE_EVENT(netfs_rreq,
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		rreq		)
 		    __field(unsigned int,		flags		)
+		    __field(enum netfs_io_origin,	origin		)
 		    __field(enum netfs_rreq_trace,	what		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->rreq	= rreq->debug_id;
 		    __entry->flags	= rreq->flags;
+		    __entry->origin	= rreq->origin;
 		    __entry->what	= what;
 			   ),
 
-	    TP_printk("R=%08x %s f=%02x",
+	    TP_printk("R=%08x %s %s f=%02x",
 		      __entry->rreq,
+		      __print_symbolic(__entry->origin, netfs_rreq_origins),
 		      __print_symbolic(__entry->what, netfs_rreq_traces),
 		      __entry->flags)
 	    );



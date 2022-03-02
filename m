Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC9F4CA731
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 15:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiCBOGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 09:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242538AbiCBOGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:06:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D61186E25
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646229928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IetQs8ytzH9K4JXJeSaAeAjiXEuL1U3Biq66VWVR9d4=;
        b=OL3uq8VZurmWb+YUdVJmtNlAvQuBASTXCeLOPFMxyO0fhLGaW7R01mdKRifZKN5m/rq7/Y
        j6ldVCtqj6CVSeAsk4+hUtdRv4jkkLzIJS3le3fsvcSOOQEzOb5KhAEC2LqXfzlY6OoDLh
        qTjHkKUIxR0rHoZmYg2MFdgT4dTrU8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-5_GE-VIjNbSHUyixARMaYA-1; Wed, 02 Mar 2022 09:05:21 -0500
X-MC-Unique: 5_GE-VIjNbSHUyixARMaYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AC42A0C03;
        Wed,  2 Mar 2022 14:05:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E74926E45;
        Wed,  2 Mar 2022 14:04:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/19] netfs: Refactor arguments for netfs_alloc_read_request
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
Date:   Wed, 02 Mar 2022 14:04:50 +0000
Message-ID: <164622989020.3564931.17517006047854958747.stgit@warthog.procyon.org.uk>
In-Reply-To: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
References: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

Pass start and len to the rreq allocator. This should ensure that the
fields are set so that init_rreq can use them.

Also add a parameter to indicates the origin of the request.  Ceph can use
this to tell whether to get caps.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/netfs/read_helper.c |   25 ++++++++++++++++---------
 include/linux/netfs.h  |    7 +++++++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index a90b3fbcb93f..37125ed95d1a 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -36,8 +36,11 @@ static void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 		__netfs_put_subrequest(subreq, was_async);
 }
 
-static struct netfs_io_request *netfs_alloc_read_request(struct address_space *mapping,
-							   struct file *file)
+static struct netfs_io_request *netfs_alloc_read_request(
+	struct address_space *mapping,
+	struct file *file,
+	loff_t start, size_t len,
+	enum netfs_read_origin origin)
 {
 	static atomic_t debug_ids;
 	struct inode *inode = file ? file_inode(file) : mapping->host;
@@ -46,8 +49,11 @@ static struct netfs_io_request *netfs_alloc_read_request(struct address_space *m
 
 	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
 	if (rreq) {
+		rreq->start	= start;
+		rreq->len	= len;
 		rreq->mapping	= mapping;
 		rreq->inode	= inode;
+		rreq->origin	= origin;
 		rreq->netfs_ops	= ctx->ops;
 		rreq->i_size	= i_size_read(inode);
 		rreq->debug_id	= atomic_inc_return(&debug_ids);
@@ -874,11 +880,12 @@ void netfs_readahead(struct readahead_control *ractl)
 	if (readahead_count(ractl) == 0)
 		return;
 
-	rreq = netfs_alloc_read_request(ractl->mapping, ractl->file);
+	rreq = netfs_alloc_read_request(ractl->mapping, ractl->file,
+					readahead_pos(ractl),
+					readahead_length(ractl),
+					NETFS_READAHEAD);
 	if (!rreq)
 		return;
-	rreq->start	= readahead_pos(ractl);
-	rreq->len	= readahead_length(ractl);
 
 	if (ctx->ops->begin_cache_operation) {
 		ret = ctx->ops->begin_cache_operation(rreq);
@@ -941,11 +948,10 @@ int netfs_readpage(struct file *file, struct page *subpage)
 
 	_enter("%lx", folio_index(folio));
 
-	rreq = netfs_alloc_read_request(mapping, file);
+	rreq = netfs_alloc_read_request(mapping, file, folio_file_pos(folio),
+					folio_size(folio), NETFS_READPAGE);
 	if (!rreq)
 		goto nomem;
-	rreq->start	= folio_file_pos(folio);
-	rreq->len	= folio_size(folio);
 
 	if (ctx->ops->begin_cache_operation) {
 		ret = ctx->ops->begin_cache_operation(rreq);
@@ -1118,7 +1124,8 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 	ret = -ENOMEM;
-	rreq = netfs_alloc_read_request(mapping, file);
+	rreq = netfs_alloc_read_request(mapping, file, folio_file_pos(folio),
+					folio_size(folio), NETFS_READ_FOR_WRITE);
 	if (!rreq)
 		goto error;
 	rreq->start		= folio_file_pos(folio);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 630b0400e9fa..a5434bc80e1c 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -158,6 +158,12 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
 };
 
+enum netfs_read_origin {
+	NETFS_READAHEAD,		/* This read was triggered by readahead */
+	NETFS_READPAGE,			/* This read is a synchronous read */
+	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
+} __mode(byte);
+
 /*
  * Descriptor for a read helper request.  This is used to make multiple I/O
  * requests on a variety of sources and then stitch the result together.
@@ -175,6 +181,7 @@ struct netfs_io_request {
 	size_t			submitted;	/* Amount submitted for I/O so far */
 	size_t			len;		/* Length of the request */
 	short			error;		/* 0 or error that occurred */
+	enum netfs_read_origin	origin;		/* Origin of the read */
 	loff_t			i_size;		/* Size of the file */
 	loff_t			start;		/* Start position */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */



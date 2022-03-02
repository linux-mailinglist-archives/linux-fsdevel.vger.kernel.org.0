Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677354CA795
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 15:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbiCBOKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 09:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiCBOKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:10:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB33FC55A1
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 06:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646230137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPXdfPBWBeCTRCrGi5Wj+acGkh0GlDwybIL4iDevD64=;
        b=BlK4yA+hvuCzWjpHi/SD66bGGCPKWWJLHE+u08tbpNGR3nwLOrh9+L6Q/iopuMWddGhdCb
        5O9/4SwC0vEm8ZICyk1YDrbNzXMrZMK68Ro7DrXSvrtrHqDjH87cD4l8SaULvXz4gl6gJu
        FicD8n9DhnA4EQA4kUBLA3OIHCNoYEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-IS0kHqsxNBiNzrXelOVWNQ-1; Wed, 02 Mar 2022 09:08:54 -0500
X-MC-Unique: IS0kHqsxNBiNzrXelOVWNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D6421006AA6;
        Wed,  2 Mar 2022 14:08:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB9158378A;
        Wed,  2 Mar 2022 14:08:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/19] netfs: Change ->init_rreq() to return an error code
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
Date:   Wed, 02 Mar 2022 14:08:38 +0000
Message-ID: <164623011809.3564931.17244403673288197944.stgit@warthog.procyon.org.uk>
In-Reply-To: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
References: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Change the read-request initialisation function to return an error code so
that the network filesystem can return a failure (ENOMEM, for example).

This will also allow ceph to abort a ->readahead() op if the server refuses
to give it a cap allowing local caching from within the netfslib framework
(errors aren't passed back through ->readahead(), so returning, say,
-ENOBUFS will cause the op to be aborted).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/9p/vfs_addr.c         |    3 ++-
 fs/afs/file.c            |    3 ++-
 fs/netfs/buffered_read.c |   15 +++++++++------
 fs/netfs/objects.c       |   40 ++++++++++++++++++++++++----------------
 include/linux/netfs.h    |    2 +-
 5 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 840111da1172..e50326d11e8f 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -56,12 +56,13 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
  * @rreq: The read request
  * @file: The file being read from
  */
-static void v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
+static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid = file->private_data;
 
 	refcount_inc(&fid->count);
 	rreq->netfs_priv = fid;
+	return 0;
 }
 
 /**
diff --git a/fs/afs/file.c b/fs/afs/file.c
index aef0fbbd834d..2b68b2070248 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -357,9 +357,10 @@ static int afs_symlink_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-static void afs_init_request(struct netfs_io_request *rreq, struct file *file)
+static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	rreq->netfs_priv = key_get(afs_file_key(file));
+	return 0;
 }
 
 static int afs_begin_cache_operation(struct netfs_io_request *rreq)
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 343c0957ae27..64049e123185 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -167,7 +167,7 @@ void netfs_readahead(struct readahead_control *ractl)
 				   readahead_pos(ractl),
 				   readahead_length(ractl),
 				   NETFS_READAHEAD);
-	if (!rreq)
+	if (IS_ERR(rreq))
 		return;
 
 	if (ctx->ops->begin_cache_operation) {
@@ -223,8 +223,10 @@ int netfs_readpage(struct file *file, struct page *subpage)
 
 	rreq = netfs_alloc_request(mapping, file, folio_file_pos(folio),
 				   folio_size(folio), NETFS_READPAGE);
-	if (!rreq)
-		goto nomem;
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
+		goto alloc_error;
+	}
 
 	if (ctx->ops->begin_cache_operation) {
 		ret = ctx->ops->begin_cache_operation(rreq);
@@ -238,7 +240,7 @@ int netfs_readpage(struct file *file, struct page *subpage)
 
 discard:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
-nomem:
+alloc_error:
 	folio_unlock(folio);
 	return ret;
 }
@@ -371,11 +373,12 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 		goto have_folio_no_wait;
 	}
 
-	ret = -ENOMEM;
 	rreq = netfs_alloc_request(mapping, file, folio_file_pos(folio),
 				   folio_size(folio), NETFS_READ_FOR_WRITE);
-	if (!rreq)
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
 		goto error;
+	}
 	rreq->start		= folio_file_pos(folio);
 	rreq->len		= folio_size(folio);
 	rreq->no_unlock_folio	= folio_index(folio);
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 8f99269c5344..d8a07df03427 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -20,26 +20,34 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	struct inode *inode = file ? file_inode(file) : mapping->host;
 	struct netfs_i_context *ctx = netfs_i_context(inode);
 	struct netfs_io_request *rreq;
+	int ret;
 
 	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
-	if (rreq) {
-		rreq->start	= start;
-		rreq->len	= len;
-		rreq->mapping	= mapping;
-		rreq->inode	= inode;
-		rreq->origin	= origin;
-		rreq->netfs_ops	= ctx->ops;
-		rreq->i_size	= i_size_read(inode);
-		rreq->debug_id	= atomic_inc_return(&debug_ids);
-		INIT_LIST_HEAD(&rreq->subrequests);
-		INIT_WORK(&rreq->work, NULL);
-		refcount_set(&rreq->ref, 1);
-		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-		if (ctx->ops->init_request)
-			ctx->ops->init_request(rreq, file);
-		netfs_stat(&netfs_n_rh_rreq);
+	if (!rreq)
+		return ERR_PTR(-ENOMEM);
+
+	rreq->start	= start;
+	rreq->len	= len;
+	rreq->mapping	= mapping;
+	rreq->inode	= inode;
+	rreq->origin	= origin;
+	rreq->netfs_ops	= ctx->ops;
+	rreq->i_size	= i_size_read(inode);
+	rreq->debug_id	= atomic_inc_return(&debug_ids);
+	INIT_LIST_HEAD(&rreq->subrequests);
+	INIT_WORK(&rreq->work, NULL);
+	refcount_set(&rreq->ref, 1);
+	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+
+	if (ctx->ops->init_request) {
+		ret = ctx->ops->init_request(rreq, file);
+		if (ret < 0) {
+			kfree(rreq);
+			return ERR_PTR(ret);
+		}
 	}
 
+	netfs_stat(&netfs_n_rh_rreq);
 	return rreq;
 }
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 725b8fb8e4bb..c925596c1bb3 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -202,7 +202,7 @@ struct netfs_io_request {
  * Operations the network filesystem can/must provide to the helpers.
  */
 struct netfs_request_ops {
-	void (*init_request)(struct netfs_io_request *rreq, struct file *file);
+	int (*init_request)(struct netfs_io_request *rreq, struct file *file);
 	int (*begin_cache_operation)(struct netfs_io_request *rreq);
 	void (*expand_readahead)(struct netfs_io_request *rreq);
 	bool (*clamp_length)(struct netfs_io_subrequest *subreq);



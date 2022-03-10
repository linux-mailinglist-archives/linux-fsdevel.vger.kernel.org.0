Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD684D4EF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbiCJQVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242708AbiCJQUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:20:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6CAD192E0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 08:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646929169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hj8bAINGHaG2GF71IxEolwOwG7LzctTbX0iZeo0PTB4=;
        b=WL0jbdLGFGTvkDbQwfsmOndAYtcxP3shuxU0JlwKzqDRinFrDKtnaXlzGpfzMaulh3ks1r
        h4iJsgARmfGYlDBtZNof2L3purLo9WdvJA+cNQPVF/NEX9R2Qws9Twke/WMLT6Vu2wkxQG
        gBsyvgqSGapJNDTdVK7IIbw+/Zw9ccs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-yZLQgkHPNIaYe5MYKaT8UA-1; Thu, 10 Mar 2022 11:19:15 -0500
X-MC-Unique: yZLQgkHPNIaYe5MYKaT8UA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF33D51E6;
        Thu, 10 Mar 2022 16:17:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 814D3106F979;
        Thu, 10 Mar 2022 16:17:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 11/20] netfs: Change ->init_request() to return an error
 code
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
Date:   Thu, 10 Mar 2022 16:17:34 +0000
Message-ID: <164692905398.2099075.5238033621684646524.stgit@warthog.procyon.org.uk>
In-Reply-To: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Change the request initialisation function to return an error code so that
the network filesystem can return a failure (ENOMEM, for example).

This will also allow ceph to abort a ->readahead() op if the server refuses
to give it a cap allowing local caching from within the netfslib framework
(errors aren't passed back through ->readahead(), so returning, say,
-ENOBUFS will cause the op to be aborted).

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/164678212401.1200972.16537041523832944934.stgit@warthog.procyon.org.uk/ # v2
---

 fs/9p/vfs_addr.c       |    3 ++-
 fs/afs/file.c          |    3 ++-
 fs/netfs/objects.c     |   41 ++++++++++++++++++++++++-----------------
 fs/netfs/read_helper.c |   20 ++++++++++++--------
 include/linux/netfs.h  |    2 +-
 5 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index fdc1033a1546..91d3926c9559 100644
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
index b19d635eed12..6469d7f98ef5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -359,9 +359,10 @@ static int afs_symlink_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-static void afs_init_request(struct netfs_io_request *rreq, struct file *file)
+static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	rreq->netfs_priv = key_get(afs_file_key(file));
+	return 0;
 }
 
 static bool afs_is_cache_enabled(struct inode *inode)
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 986d7a9d25dd..ae18827e156b 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -20,27 +20,34 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 {
 	static atomic_t debug_ids;
 	struct netfs_io_request *rreq;
+	int ret;
 
 	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
-	if (rreq) {
-		rreq->start	= start;
-		rreq->len	= len;
-		rreq->origin	= origin;
-		rreq->netfs_ops	= ops;
-		rreq->netfs_priv = netfs_priv;
-		rreq->mapping	= mapping;
-		rreq->inode	= file_inode(file);
-		rreq->i_size	= i_size_read(rreq->inode);
-		rreq->debug_id	= atomic_inc_return(&debug_ids);
-		INIT_LIST_HEAD(&rreq->subrequests);
-		INIT_WORK(&rreq->work, netfs_rreq_work);
-		refcount_set(&rreq->ref, 1);
-		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-		if (ops->init_request)
-			ops->init_request(rreq, file);
-		netfs_stat(&netfs_n_rh_rreq);
+	if (!rreq)
+		return ERR_PTR(-ENOMEM);
+
+	rreq->start	= start;
+	rreq->len	= len;
+	rreq->origin	= origin;
+	rreq->netfs_ops	= ops;
+	rreq->netfs_priv = netfs_priv;
+	rreq->mapping	= mapping;
+	rreq->inode	= file_inode(file);
+	rreq->i_size	= i_size_read(rreq->inode);
+	rreq->debug_id	= atomic_inc_return(&debug_ids);
+	INIT_LIST_HEAD(&rreq->subrequests);
+	INIT_WORK(&rreq->work, netfs_rreq_work);
+	refcount_set(&rreq->ref, 1);
+	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	if (rreq->netfs_ops->init_request) {
+		ret = rreq->netfs_ops->init_request(rreq, file);
+		if (ret < 0) {
+			kfree(rreq);
+			return ERR_PTR(ret);
+		}
 	}
 
+	netfs_stat(&netfs_n_rh_rreq);
 	return rreq;
 }
 
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index dea085715286..b5176f4320f4 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -768,7 +768,7 @@ void netfs_readahead(struct readahead_control *ractl,
 				   readahead_pos(ractl),
 				   readahead_length(ractl),
 				   NETFS_READAHEAD);
-	if (!rreq)
+	if (IS_ERR(rreq))
 		goto cleanup;
 
 	if (ops->begin_cache_operation) {
@@ -842,11 +842,9 @@ int netfs_readpage(struct file *file,
 	rreq = netfs_alloc_request(folio->mapping, file, ops, netfs_priv,
 				   folio_file_pos(folio), folio_size(folio),
 				   NETFS_READPAGE);
-	if (!rreq) {
-		if (netfs_priv)
-			ops->cleanup(folio_file_mapping(folio), netfs_priv);
-		folio_unlock(folio);
-		return -ENOMEM;
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
+		goto alloc_error;
 	}
 
 	if (ops->begin_cache_operation) {
@@ -887,6 +885,11 @@ int netfs_readpage(struct file *file,
 out:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
 	return ret;
+alloc_error:
+	if (netfs_priv)
+		ops->cleanup(folio_file_mapping(folio), netfs_priv);
+	folio_unlock(folio);
+	return ret;
 }
 EXPORT_SYMBOL(netfs_readpage);
 
@@ -1007,12 +1010,13 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 		goto have_folio_no_wait;
 	}
 
-	ret = -ENOMEM;
 	rreq = netfs_alloc_request(mapping, file, ops, netfs_priv,
 				   folio_file_pos(folio), folio_size(folio),
 				   NETFS_READ_FOR_WRITE);
-	if (!rreq)
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
 		goto error;
+	}
 	rreq->no_unlock_folio	= folio_index(folio);
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 	netfs_priv = NULL;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 7dc741d9b21b..4b99e38f73d9 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -193,7 +193,7 @@ struct netfs_io_request {
  */
 struct netfs_request_ops {
 	bool (*is_cache_enabled)(struct inode *inode);
-	void (*init_request)(struct netfs_io_request *rreq, struct file *file);
+	int (*init_request)(struct netfs_io_request *rreq, struct file *file);
 	int (*begin_cache_operation)(struct netfs_io_request *rreq);
 	void (*expand_readahead)(struct netfs_io_request *rreq);
 	bool (*clamp_length)(struct netfs_io_subrequest *subreq);



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447E1699F66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjBPVus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjBPVuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3AA53816
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8bLco6RK/TV/x/zhGZ3kDinA9d0Eqcu5AZrfy3jfiY=;
        b=YgcXyLvfAQcgKcJxyBMqlaxHCy1cdrzVfWx+Q3ER4ilsarAf/cMROrwAOORYr7VQmqLoJd
        Jm+FxiwByjMcsv9DxDvCnkIj+/zxtmq2IPTJCvEbGHtV4lNWxpEDD8BvhAA2wEI97z6Trw
        Rxys7doYT4eFRazoK4qqef091mI4EL8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-RayOGYqxP7eYvFXjA8177w-1; Thu, 16 Feb 2023 16:48:50 -0500
X-MC-Unique: RayOGYqxP7eYvFXjA8177w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D97085A5A3;
        Thu, 16 Feb 2023 21:48:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A5F2492B17;
        Thu, 16 Feb 2023 21:48:47 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>, linux-rdma@vger.kernel.org
Subject: [PATCH 15/17] cifs: Build the RDMA SGE list directly from an iterator
Date:   Thu, 16 Feb 2023 21:47:43 +0000
Message-Id: <20230216214745.3985496-16-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the depths of the cifs RDMA code, extract part of an iov iterator
directly into an SGE list without going through an intermediate
scatterlist.

Note that this doesn't support extraction from an IOBUF- or UBUF-type
iterator (ie. user-supplied buffer).  The assumption is that the higher
layers will extract those to a BVEC-type iterator first and do whatever is
required to stop the pages from going away.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-rdma@vger.kernel.org

Link: https://lore.kernel.org/r/166697260361.61150.5064013393408112197.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732032518.3186319.1859601819981624629.stgit@warthog.procyon.org.uk/ # rfc
---
 fs/cifs/smbdirect.c | 153 ++++++++++++++++++--------------------------
 fs/cifs/smbdirect.h |   3 +-
 2 files changed, 63 insertions(+), 93 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 0eb32bbfc467..31c4dc8212c3 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -828,16 +828,16 @@ static int smbd_post_send(struct smbd_connection *info,
 	return rc;
 }
 
-static int smbd_post_send_sgl(struct smbd_connection *info,
-	struct scatterlist *sgl, int data_length, int remaining_data_length)
+static int smbd_post_send_iter(struct smbd_connection *info,
+			       struct iov_iter *iter,
+			       int *_remaining_data_length)
 {
-	int num_sgs;
 	int i, rc;
 	int header_length;
+	int data_length;
 	struct smbd_request *request;
 	struct smbd_data_transfer *packet;
 	int new_credits;
-	struct scatterlist *sg;
 
 wait_credit:
 	/* Wait for send credits. A SMBD packet needs one credit */
@@ -881,6 +881,30 @@ static int smbd_post_send_sgl(struct smbd_connection *info,
 	}
 
 	request->info = info;
+	memset(request->sge, 0, sizeof(request->sge));
+
+	/* Fill in the data payload to find out how much data we can add */
+	if (iter) {
+		struct smb_extract_to_rdma extract = {
+			.nr_sge		= 1,
+			.max_sge	= SMBDIRECT_MAX_SEND_SGE,
+			.sge		= request->sge,
+			.device		= info->id->device,
+			.local_dma_lkey	= info->pd->local_dma_lkey,
+			.direction	= DMA_TO_DEVICE,
+		};
+
+		rc = smb_extract_iter_to_rdma(iter, *_remaining_data_length,
+					      &extract);
+		if (rc < 0)
+			goto err_dma;
+		data_length = rc;
+		request->num_sge = extract.nr_sge;
+		*_remaining_data_length -= data_length;
+	} else {
+		data_length = 0;
+		request->num_sge = 1;
+	}
 
 	/* Fill in the packet header */
 	packet = smbd_request_payload(request);
@@ -902,7 +926,7 @@ static int smbd_post_send_sgl(struct smbd_connection *info,
 	else
 		packet->data_offset = cpu_to_le32(24);
 	packet->data_length = cpu_to_le32(data_length);
-	packet->remaining_data_length = cpu_to_le32(remaining_data_length);
+	packet->remaining_data_length = cpu_to_le32(*_remaining_data_length);
 	packet->padding = 0;
 
 	log_outgoing(INFO, "credits_requested=%d credits_granted=%d data_offset=%d data_length=%d remaining_data_length=%d\n",
@@ -918,7 +942,6 @@ static int smbd_post_send_sgl(struct smbd_connection *info,
 	if (!data_length)
 		header_length = offsetof(struct smbd_data_transfer, padding);
 
-	request->num_sge = 1;
 	request->sge[0].addr = ib_dma_map_single(info->id->device,
 						 (void *)packet,
 						 header_length,
@@ -932,23 +955,6 @@ static int smbd_post_send_sgl(struct smbd_connection *info,
 	request->sge[0].length = header_length;
 	request->sge[0].lkey = info->pd->local_dma_lkey;
 
-	/* Fill in the packet data payload */
-	num_sgs = sgl ? sg_nents(sgl) : 0;
-	for_each_sg(sgl, sg, num_sgs, i) {
-		request->sge[i+1].addr =
-			ib_dma_map_page(info->id->device, sg_page(sg),
-			       sg->offset, sg->length, DMA_TO_DEVICE);
-		if (ib_dma_mapping_error(
-				info->id->device, request->sge[i+1].addr)) {
-			rc = -EIO;
-			request->sge[i+1].addr = 0;
-			goto err_dma;
-		}
-		request->sge[i+1].length = sg->length;
-		request->sge[i+1].lkey = info->pd->local_dma_lkey;
-		request->num_sge++;
-	}
-
 	rc = smbd_post_send(info, request);
 	if (!rc)
 		return 0;
@@ -987,8 +993,10 @@ static int smbd_post_send_sgl(struct smbd_connection *info,
  */
 static int smbd_post_send_empty(struct smbd_connection *info)
 {
+	int remaining_data_length = 0;
+
 	info->count_send_empty++;
-	return smbd_post_send_sgl(info, NULL, 0, 0);
+	return smbd_post_send_iter(info, NULL, &remaining_data_length);
 }
 
 /*
@@ -1933,42 +1941,6 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 	return rc;
 }
 
-/*
- * Send the contents of an iterator
- * @iter: The iterator to send
- * @_remaining_data_length: remaining data to send in this payload
- */
-static int smbd_post_send_iter(struct smbd_connection *info,
-			       struct iov_iter *iter,
-			       int *_remaining_data_length)
-{
-	struct scatterlist sgl[SMBDIRECT_MAX_SEND_SGE - 1];
-	unsigned int max_payload = info->max_send_size - sizeof(struct smbd_data_transfer);
-	ssize_t rc;
-
-	/* We're not expecting a user-backed iter */
-	WARN_ON(iov_iter_extract_will_pin(iter));
-
-	do {
-		struct sg_table sgtable = { .sgl = sgl };
-		size_t maxlen = min_t(size_t, *_remaining_data_length, max_payload);
-
-		sg_init_table(sgtable.sgl, ARRAY_SIZE(sgl));
-		rc = netfs_extract_iter_to_sg(iter, maxlen,
-					      &sgtable, ARRAY_SIZE(sgl), 0);
-		if (rc < 0)
-			break;
-		if (WARN_ON_ONCE(sgtable.nents == 0))
-			return -EIO;
-
-		sg_mark_end(&sgl[sgtable.nents - 1]);
-		*_remaining_data_length -= rc;
-		rc = smbd_post_send_sgl(info, sgl, rc, *_remaining_data_length);
-	} while (rc == 0 && iov_iter_count(iter) > 0);
-
-	return rc;
-}
-
 /*
  * Send data to transport
  * Each rqst is transported as a SMBDirect payload
@@ -2129,10 +2101,10 @@ static void destroy_mr_list(struct smbd_connection *info)
 	cancel_work_sync(&info->mr_recovery_work);
 	list_for_each_entry_safe(mr, tmp, &info->mr_list, list) {
 		if (mr->state == MR_INVALIDATED)
-			ib_dma_unmap_sg(info->id->device, mr->sgl,
-				mr->sgl_count, mr->dir);
+			ib_dma_unmap_sg(info->id->device, mr->sgt.sgl,
+				mr->sgt.nents, mr->dir);
 		ib_dereg_mr(mr->mr);
-		kfree(mr->sgl);
+		kfree(mr->sgt.sgl);
 		kfree(mr);
 	}
 }
@@ -2167,11 +2139,10 @@ static int allocate_mr_list(struct smbd_connection *info)
 				    info->mr_type, info->max_frmr_depth);
 			goto out;
 		}
-		smbdirect_mr->sgl = kcalloc(
-					info->max_frmr_depth,
-					sizeof(struct scatterlist),
-					GFP_KERNEL);
-		if (!smbdirect_mr->sgl) {
+		smbdirect_mr->sgt.sgl = kcalloc(info->max_frmr_depth,
+						sizeof(struct scatterlist),
+						GFP_KERNEL);
+		if (!smbdirect_mr->sgt.sgl) {
 			log_rdma_mr(ERR, "failed to allocate sgl\n");
 			ib_dereg_mr(smbdirect_mr->mr);
 			goto out;
@@ -2190,7 +2161,7 @@ static int allocate_mr_list(struct smbd_connection *info)
 
 	list_for_each_entry_safe(smbdirect_mr, tmp, &info->mr_list, list) {
 		ib_dereg_mr(smbdirect_mr->mr);
-		kfree(smbdirect_mr->sgl);
+		kfree(smbdirect_mr->sgt.sgl);
 		kfree(smbdirect_mr);
 	}
 	return -ENOMEM;
@@ -2244,22 +2215,20 @@ static struct smbd_mr *get_mr(struct smbd_connection *info)
 
 /*
  * Transcribe the pages from an iterator into an MR scatterlist.
- * @iter: The iterator to transcribe
- * @_remaining_data_length: remaining data to send in this payload
  */
 static int smbd_iter_to_mr(struct smbd_connection *info,
 			   struct iov_iter *iter,
-			   struct scatterlist *sgl,
-			   unsigned int num_pages)
+			   struct sg_table *sgt,
+			   unsigned int max_sg)
 {
-	struct sg_table sgtable = { .sgl = sgl };
 	int ret;
 
-	sg_init_table(sgl, num_pages);
+	memset(sgt->sgl, 0, max_sg * sizeof(struct scatterlist));
 
-	ret = netfs_extract_iter_to_sg(iter, iov_iter_count(iter),
-				       &sgtable, num_pages, 0);
+	ret = netfs_extract_iter_to_sg(iter, iov_iter_count(iter), sgt, max_sg, 0);
 	WARN_ON(ret < 0);
+	if (sgt->nents > 0)
+		sg_mark_end(&sgt->sgl[sgt->nents - 1]);
 	return ret;
 }
 
@@ -2296,25 +2265,27 @@ struct smbd_mr *smbd_register_mr(struct smbd_connection *info,
 	dir = writing ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 	smbdirect_mr->dir = dir;
 	smbdirect_mr->need_invalidate = need_invalidate;
-	smbdirect_mr->sgl_count = num_pages;
+	smbdirect_mr->sgt.nents = 0;
+	smbdirect_mr->sgt.orig_nents = 0;
 
-	log_rdma_mr(INFO, "num_pages=0x%x count=0x%zx\n",
-		    num_pages, iov_iter_count(iter));
-	smbd_iter_to_mr(info, iter, smbdirect_mr->sgl, num_pages);
+	log_rdma_mr(INFO, "num_pages=0x%x count=0x%zx depth=%u\n",
+		    num_pages, iov_iter_count(iter), info->max_frmr_depth);
+	smbd_iter_to_mr(info, iter, &smbdirect_mr->sgt, info->max_frmr_depth);
 
-	rc = ib_dma_map_sg(info->id->device, smbdirect_mr->sgl, num_pages, dir);
+	rc = ib_dma_map_sg(info->id->device, smbdirect_mr->sgt.sgl,
+			   smbdirect_mr->sgt.nents, dir);
 	if (!rc) {
 		log_rdma_mr(ERR, "ib_dma_map_sg num_pages=%x dir=%x rc=%x\n",
 			num_pages, dir, rc);
 		goto dma_map_error;
 	}
 
-	rc = ib_map_mr_sg(smbdirect_mr->mr, smbdirect_mr->sgl, num_pages,
-		NULL, PAGE_SIZE);
-	if (rc != num_pages) {
+	rc = ib_map_mr_sg(smbdirect_mr->mr, smbdirect_mr->sgt.sgl,
+			  smbdirect_mr->sgt.nents, NULL, PAGE_SIZE);
+	if (rc != smbdirect_mr->sgt.nents) {
 		log_rdma_mr(ERR,
-			"ib_map_mr_sg failed rc = %d num_pages = %x\n",
-			rc, num_pages);
+			"ib_map_mr_sg failed rc = %d nents = %x\n",
+			rc, smbdirect_mr->sgt.nents);
 		goto map_mr_error;
 	}
 
@@ -2346,8 +2317,8 @@ struct smbd_mr *smbd_register_mr(struct smbd_connection *info,
 
 	/* If all failed, attempt to recover this MR by setting it MR_ERROR*/
 map_mr_error:
-	ib_dma_unmap_sg(info->id->device, smbdirect_mr->sgl,
-		smbdirect_mr->sgl_count, smbdirect_mr->dir);
+	ib_dma_unmap_sg(info->id->device, smbdirect_mr->sgt.sgl,
+			smbdirect_mr->sgt.nents, smbdirect_mr->dir);
 
 dma_map_error:
 	smbdirect_mr->state = MR_ERROR;
@@ -2414,8 +2385,8 @@ int smbd_deregister_mr(struct smbd_mr *smbdirect_mr)
 
 	if (smbdirect_mr->state == MR_INVALIDATED) {
 		ib_dma_unmap_sg(
-			info->id->device, smbdirect_mr->sgl,
-			smbdirect_mr->sgl_count,
+			info->id->device, smbdirect_mr->sgt.sgl,
+			smbdirect_mr->sgt.nents,
 			smbdirect_mr->dir);
 		smbdirect_mr->state = MR_READY;
 		if (atomic_inc_return(&info->mr_ready_count) == 1)
diff --git a/fs/cifs/smbdirect.h b/fs/cifs/smbdirect.h
index be2cf18b7fec..83f239f376f0 100644
--- a/fs/cifs/smbdirect.h
+++ b/fs/cifs/smbdirect.h
@@ -288,8 +288,7 @@ struct smbd_mr {
 	struct list_head	list;
 	enum mr_state		state;
 	struct ib_mr		*mr;
-	struct scatterlist	*sgl;
-	int			sgl_count;
+	struct sg_table		sgt;
 	enum dma_data_direction	dir;
 	union {
 		struct ib_reg_wr	wr;


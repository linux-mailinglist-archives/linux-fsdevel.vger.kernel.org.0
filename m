Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99EA61169D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJ1P7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJ1P5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B649D21345B
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666972611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYX9C4tV+uCYpsSIy4eEzmHqt/2Pk0X68HjqPEsanbk=;
        b=TxuAFMPuRZpMFl0JoDje+Q4XeE697HnYv/g+H6syRsicFh+dH3BRnxB7ZrMCJ2vmeI5Gte
        WedtZguUIeStHhNgC1U3BI25bsYRerLRhrPTzx69lpRIovsJB7j1rvfYh+2SFQs/Ttfsr0
        MtJ7otzSBGfJjYWvBjQE/S2qxiOKHcc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-Hfz3-hoFOkeCyx0xKcYQpw-1; Fri, 28 Oct 2022 11:56:46 -0400
X-MC-Unique: Hfz3-hoFOkeCyx0xKcYQpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FF2229AA389;
        Fri, 28 Oct 2022 15:56:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35B0AC15BA8;
        Fri, 28 Oct 2022 15:56:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 8/9] cifs: Build the RDMA SGE list directly from an
 iterator
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Oct 2022 16:56:43 +0100
Message-ID: <166697260361.61150.5064013393408112197.stgit@warthog.procyon.org.uk>
In-Reply-To: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
References: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---

 fs/cifs/smbdirect.c |   89 ++++++++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 57 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 7f1a1e190650..c4465d6a2fc6 100644
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
@@ -1932,39 +1940,6 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
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
-	do {
-		struct sg_table sgtable = { .sgl = sgl };
-		size_t maxlen = min_t(size_t, *_remaining_data_length, max_payload);
-
-		sg_init_table(sgtable.sgl, ARRAY_SIZE(sgl));
-		rc = netfs_extract_iter_to_sg(iter, maxlen,
-					      &sgtable, ARRAY_SIZE(sgl));
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



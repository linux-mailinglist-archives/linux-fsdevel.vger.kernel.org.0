Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD1614F7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 17:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKAQfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKAQeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C71D320
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667320333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6P7/llVoRVswYjqvNRXAGnL+tR0OiKnMSoeQk+0UX2U=;
        b=eW2MUbvk2KSpohNCe03487knpaYBDlNWvR5elM4fec5TMuIHiSA8WZBIoEfkiv24cDVc4G
        ynLSOLf55GxQEwuNUq80N2E8Fwtt0yqmF9kJOfrNa0yYM1dSM/vIWTai0XdDOLQUe4boSY
        P3QjxNP28rgb3vgscMH0m7smxumYK94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-g5JkT2nmMBmOLcb12MnIVg-1; Tue, 01 Nov 2022 12:32:08 -0400
X-MC-Unique: g5JkT2nmMBmOLcb12MnIVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64A58857D0E;
        Tue,  1 Nov 2022 16:32:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C17EB1121320;
        Tue,  1 Nov 2022 16:32:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 11/12] cifs: Build the RDMA SGE list directly from an
 iterator
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-rdma@vger.kernel.org, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Nov 2022 16:32:05 +0000
Message-ID: <166732032518.3186319.1859601819981624629.stgit@warthog.procyon.org.uk>
In-Reply-To: <166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk>
References: <166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-rdma@vger.kernel.org
---

 fs/cifs/smbdirect.c |   89 ++++++++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 57 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 4ee4f040f3db..3f1f952a1e6b 100644
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



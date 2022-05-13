Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3E85266AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382319AbiEMP7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381614AbiEMP7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 11:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42A5313DC2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652457575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9oCOXRPG0g6PpjFTfCJDhjwOb8P4DxoHY+MR0WqL1E=;
        b=gcA1ZcnqTscPMd9/fmizqnI4IQ0b2X7mas5T5ckvX5w4JfEvj0GYZ/1zDXLRsWQS7XlCQE
        H+G6Ag0G8vSWCX2BzvtisXv7W+L5McyRCnZbL/paB14OmGy455Tdhl/hsXuLD5MW7tXPMS
        NQ/lcNwo83mom7IE5AlpvUfj91Lfd4Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-7g0V2bhNOeiIalRoepJNbQ-1; Fri, 13 May 2022 11:59:30 -0400
X-MC-Unique: 7g0V2bhNOeiIalRoepJNbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97827185A7B2;
        Fri, 13 May 2022 15:59:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF36AC50944;
        Fri, 13 May 2022 15:59:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <165211416682.3154751.17287804906832979514.stgit@warthog.procyon.org.uk>
References: <165211416682.3154751.17287804906832979514.stgit@warthog.procyon.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/6] cifs: Make the cifs RDMA code use iterators 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1663521.1652457567.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 13 May 2022 16:59:27 +0100
Message-ID: <1663522.1652457567@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the cifs RDMA code to use iterators rather than page lists and
transcribe the iterators into scatterlists.

NOTE!  This compiles, but is untested (I don't know how to set up RDMA in
Samba and cifs).  It also wants merging into a previous patch to avoid
build errors there.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/cifs/smb2pdu.c   |   23 +---
 fs/cifs/smbdirect.c |  284 +++++++++++++++++-----------------------------=
------
 fs/cifs/smbdirect.h |    4 =

 3 files changed, 106 insertions(+), 205 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 6bb9a90b018f..d9a06704daa8 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4054,10 +4054,8 @@ smb2_new_read_req(void **buf, unsigned int *total_l=
en,
 		struct smbd_buffer_descriptor_v1 *v1;
 		bool need_invalidate =3D server->dialect =3D=3D SMB30_PROT_ID;
 =

-		rdata->mr =3D smbd_register_mr(
-				server->smbd_conn, rdata->pages,
-				rdata->nr_pages, rdata->page_offset,
-				rdata->tailsz, true, need_invalidate);
+		rdata->mr =3D smbd_register_mr(server->smbd_conn, &rdata->iter,
+					     true, need_invalidate);
 		if (!rdata->mr)
 			return -EAGAIN;
 =

@@ -4477,24 +4475,15 @@ smb2_async_writev(struct cifs_writedata *wdata,
 		struct smbd_buffer_descriptor_v1 *v1;
 		bool need_invalidate =3D server->dialect =3D=3D SMB30_PROT_ID;
 =

-		wdata->mr =3D smbd_register_mr(
-				server->smbd_conn, wdata->pages,
-				wdata->nr_pages, wdata->page_offset,
-				wdata->tailsz, false, need_invalidate);
+		wdata->mr =3D smbd_register_mr(server->smbd_conn, &wdata->iter,
+					     false, need_invalidate);
 		if (!wdata->mr) {
 			rc =3D -EAGAIN;
 			goto async_writev_out;
 		}
 		req->Length =3D 0;
 		req->DataOffset =3D 0;
-		if (wdata->nr_pages > 1)
-			req->RemainingBytes =3D
-				cpu_to_le32(
-					(wdata->nr_pages - 1) * wdata->pagesz -
-					wdata->page_offset + wdata->tailsz
-				);
-		else
-			req->RemainingBytes =3D cpu_to_le32(wdata->tailsz);
+		req->RemainingBytes =3D cpu_to_le32(iov_iter_count(&wdata->iter));
 		req->Channel =3D SMB2_CHANNEL_RDMA_V1_INVALIDATE;
 		if (need_invalidate)
 			req->Channel =3D SMB2_CHANNEL_RDMA_V1;
@@ -4517,7 +4506,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (wdata->mr) {
 		iov[0].iov_len +=3D sizeof(struct smbd_buffer_descriptor_v1);
-		rqst.rq_npages =3D 0;
+		iov_iter_advance(&wdata->iter, iov_iter_count(&wdata->iter));
 	}
 #endif
 	cifs_dbg(FYI, "async write at %llu %u bytes\n",
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 31ef64eb7fbb..5c311de5c9ac 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -34,12 +34,6 @@ static int smbd_post_recv(
 		struct smbd_response *response);
 =

 static int smbd_post_send_empty(struct smbd_connection *info);
-static int smbd_post_send_data(
-		struct smbd_connection *info,
-		struct kvec *iov, int n_vec, int remaining_data_length);
-static int smbd_post_send_page(struct smbd_connection *info,
-		struct page *page, unsigned long offset,
-		size_t size, int remaining_data_length);
 =

 static void destroy_mr_list(struct smbd_connection *info);
 static int allocate_mr_list(struct smbd_connection *info);
@@ -975,24 +969,6 @@ static int smbd_post_send_sgl(struct smbd_connection =
*info,
 	return rc;
 }
 =

-/*
- * Send a page
- * page: the page to send
- * offset: offset in the page to send
- * size: length in the page to send
- * remaining_data_length: remaining data to send in this payload
- */
-static int smbd_post_send_page(struct smbd_connection *info, struct page =
*page,
-		unsigned long offset, size_t size, int remaining_data_length)
-{
-	struct scatterlist sgl;
-
-	sg_init_table(&sgl, 1);
-	sg_set_page(&sgl, page, size, offset);
-
-	return smbd_post_send_sgl(info, &sgl, size, remaining_data_length);
-}
-
 /*
  * Send an empty message
  * Empty message is used to extend credits to peer to for keep live
@@ -1004,35 +980,6 @@ static int smbd_post_send_empty(struct smbd_connecti=
on *info)
 	return smbd_post_send_sgl(info, NULL, 0, 0);
 }
 =

-/*
- * Send a data buffer
- * iov: the iov array describing the data buffers
- * n_vec: number of iov array
- * remaining_data_length: remaining data to send following this packet
- * in segmented SMBD packet
- */
-static int smbd_post_send_data(
-	struct smbd_connection *info, struct kvec *iov, int n_vec,
-	int remaining_data_length)
-{
-	int i;
-	u32 data_length =3D 0;
-	struct scatterlist sgl[SMBDIRECT_MAX_SGE];
-
-	if (n_vec > SMBDIRECT_MAX_SGE) {
-		cifs_dbg(VFS, "Can't fit data to SGL, n_vec=3D%d\n", n_vec);
-		return -EINVAL;
-	}
-
-	sg_init_table(sgl, n_vec);
-	for (i =3D 0; i < n_vec; i++) {
-		data_length +=3D iov[i].iov_len;
-		sg_set_buf(&sgl[i], iov[i].iov_base, iov[i].iov_len);
-	}
-
-	return smbd_post_send_sgl(info, sgl, data_length, remaining_data_length)=
;
-}
-
 /*
  * Post a receive request to the transport
  * The remote peer can only send data when a receive request is posted
@@ -1976,6 +1923,42 @@ int smbd_recv(struct smbd_connection *info, struct =
msghdr *msg)
 	return rc;
 }
 =

+/*
+ * Send the contents of an iterator
+ * @iter: The iterator to send
+ * @_remaining_data_length: remaining data to send in this payload
+ */
+static int smbd_post_send_iter(struct smbd_connection *info,
+			       struct iov_iter *iter,
+			       int *_remaining_data_length)
+{
+	struct scatterlist sgl;
+	struct page *page;
+	ssize_t len;
+	size_t offset, maxlen;
+	int i =3D 0, rc;
+
+	do {
+		maxlen =3D min_t(size_t, *_remaining_data_length, PAGE_SIZE);
+		len =3D iov_iter_get_pages(iter, &page, maxlen, 1, &offset);
+		if (len <=3D 0)
+			return len;
+
+		sg_init_table(&sgl, 1);
+		sg_set_page(&sgl, page, len, offset);
+
+		iov_iter_advance(iter, len);
+		*_remaining_data_length -=3D len;
+
+		log_write(INFO, "sending page i=3D%d offset=3D%zu size=3D%zu remaining_=
data_length=3D%d\n",
+			  i, offset, len, *_remaining_data_length);
+		rc =3D smbd_post_send_sgl(info, &sgl, len, *_remaining_data_length);
+		put_page(page);
+	} while (rc =3D=3D 0);
+
+	return rc;
+}
+
 /*
  * Send data to transport
  * Each rqst is transported as a SMBDirect payload
@@ -1986,17 +1969,10 @@ int smbd_send(struct TCP_Server_Info *server,
 	int num_rqst, struct smb_rqst *rqst_array)
 {
 	struct smbd_connection *info =3D server->smbd_conn;
-	struct kvec vec;
-	int nvecs;
-	int size;
-	unsigned int buflen, remaining_data_length;
-	int start, i, j;
-	int max_iov_size =3D
-		info->max_send_size - sizeof(struct smbd_data_transfer);
-	struct kvec *iov;
-	int rc;
 	struct smb_rqst *rqst;
-	int rqst_idx;
+	struct iov_iter iter;
+	unsigned int remaining_data_length;
+	int rc, i, rqst_idx;
 =

 	if (info->transport_status !=3D SMBD_CONNECTED) {
 		rc =3D -EAGAIN;
@@ -2025,108 +2001,30 @@ int smbd_send(struct TCP_Server_Info *server,
 	rqst_idx =3D 0;
 next_rqst:
 	rqst =3D &rqst_array[rqst_idx];
-	iov =3D rqst->rq_iov;
 =

 	cifs_dbg(FYI, "Sending smb (RDMA): idx=3D%d smb_len=3D%lu\n",
 		rqst_idx, smb_rqst_len(server, rqst));
 	for (i =3D 0; i < rqst->rq_nvec; i++)
-		dump_smb(iov[i].iov_base, iov[i].iov_len);
-
-
-	log_write(INFO, "rqst_idx=3D%d nvec=3D%d rqst->rq_npages=3D%d rq_pagesz=3D=
%d rq_tailsz=3D%d buflen=3D%lu\n",
-		  rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
-		  rqst->rq_tailsz, smb_rqst_len(server, rqst));
-
-	start =3D i =3D 0;
-	buflen =3D 0;
-	while (true) {
-		buflen +=3D iov[i].iov_len;
-		if (buflen > max_iov_size) {
-			if (i > start) {
-				remaining_data_length -=3D
-					(buflen-iov[i].iov_len);
-				log_write(INFO, "sending iov[] from start=3D%d i=3D%d nvecs=3D%d rema=
ining_data_length=3D%d\n",
-					  start, i, i - start,
-					  remaining_data_length);
-				rc =3D smbd_post_send_data(
-					info, &iov[start], i-start,
-					remaining_data_length);
-				if (rc)
-					goto done;
-			} else {
-				/* iov[start] is too big, break it */
-				nvecs =3D (buflen+max_iov_size-1)/max_iov_size;
-				log_write(INFO, "iov[%d] iov_base=3D%p buflen=3D%d break to %d vector=
s\n",
-					  start, iov[start].iov_base,
-					  buflen, nvecs);
-				for (j =3D 0; j < nvecs; j++) {
-					vec.iov_base =3D
-						(char *)iov[start].iov_base +
-						j*max_iov_size;
-					vec.iov_len =3D max_iov_size;
-					if (j =3D=3D nvecs-1)
-						vec.iov_len =3D
-							buflen -
-							max_iov_size*(nvecs-1);
-					remaining_data_length -=3D vec.iov_len;
-					log_write(INFO,
-						"sending vec j=3D%d iov_base=3D%p iov_len=3D%zu remaining_data_leng=
th=3D%d\n",
-						  j, vec.iov_base, vec.iov_len,
-						  remaining_data_length);
-					rc =3D smbd_post_send_data(
-						info, &vec, 1,
-						remaining_data_length);
-					if (rc)
-						goto done;
-				}
-				i++;
-				if (i =3D=3D rqst->rq_nvec)
-					break;
-			}
-			start =3D i;
-			buflen =3D 0;
-		} else {
-			i++;
-			if (i =3D=3D rqst->rq_nvec) {
-				/* send out all remaining vecs */
-				remaining_data_length -=3D buflen;
-				log_write(INFO, "sending iov[] from start=3D%d i=3D%d nvecs=3D%d rema=
ining_data_length=3D%d\n",
-					  start, i, i - start,
-					  remaining_data_length);
-				rc =3D smbd_post_send_data(info, &iov[start],
-					i-start, remaining_data_length);
-				if (rc)
-					goto done;
-				break;
-			}
-		}
-		log_write(INFO, "looping i=3D%d buflen=3D%d\n", i, buflen);
-	}
-
-	/* now sending pages if there are any */
-	for (i =3D 0; i < rqst->rq_npages; i++) {
-		unsigned int offset;
-
-		rqst_page_get_length(rqst, i, &buflen, &offset);
-		nvecs =3D (buflen + max_iov_size - 1) / max_iov_size;
-		log_write(INFO, "sending pages buflen=3D%d nvecs=3D%d\n",
-			buflen, nvecs);
-		for (j =3D 0; j < nvecs; j++) {
-			size =3D max_iov_size;
-			if (j =3D=3D nvecs-1)
-				size =3D buflen - j*max_iov_size;
-			remaining_data_length -=3D size;
-			log_write(INFO, "sending pages i=3D%d offset=3D%d size=3D%d remaining_=
data_length=3D%d\n",
-				  i, j * max_iov_size + offset, size,
-				  remaining_data_length);
-			rc =3D smbd_post_send_page(
-				info, rqst->rq_pages[i],
-				j*max_iov_size + offset,
-				size, remaining_data_length);
-			if (rc)
-				goto done;
-		}
-	}
+		dump_smb(rqst->rq_iov[i].iov_base, rqst->rq_iov[i].iov_len);
+
+
+	log_write(INFO, "rqst_idx=3D%d nvec=3D%d rqst->rq_iter=3D%zd buflen=3D%l=
u\n",
+		  rqst_idx, rqst->rq_nvec, iov_iter_count(&rqst->rq_iter),
+		  smb_rqst_len(server, rqst));
+
+	/* Send the metadata pages. */
+	iov_iter_kvec(&iter, WRITE, rqst->rq_iov, rqst->rq_nvec,
+		      rqst->rq_iov[0].iov_len +
+		      (rqst->rq_nvec > 1 ? rqst->rq_iov[1].iov_len : 0));
+
+	rc =3D smbd_post_send_iter(info, &iter, &remaining_data_length);
+	if (rc < 0)
+		goto done;
+
+	/* And then the data pages if there are any */
+	rc =3D smbd_post_send_iter(info, &rqst->rq_iter, &remaining_data_length)=
;
+	if (rc < 0)
+		goto done;
 =

 	rqst_idx++;
 	if (rqst_idx < num_rqst)
@@ -2336,6 +2234,35 @@ static struct smbd_mr *get_mr(struct smbd_connectio=
n *info)
 	goto again;
 }
 =

+/*
+ * Transcribe the pages from an iterator into an MR scatterlist.
+ * @iter: The iterator to transcribe
+ * @_remaining_data_length: remaining data to send in this payload
+ */
+static int smbd_iter_to_mr(struct smbd_connection *info,
+			   struct iov_iter *iter,
+			   struct scatterlist *sgl,
+			   unsigned int num_pages)
+{
+	struct page *page;
+	ssize_t len;
+	size_t offset, maxlen;
+
+	sg_init_table(sgl, num_pages);
+
+	for (;;) {
+		maxlen =3D min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
+		len =3D iov_iter_get_pages(iter, &page, maxlen, 1, &offset);
+		if (len <=3D 0)
+			return len;
+
+		sg_set_page(sgl, page, len, offset);
+		sgl++;
+		put_page(page);
+		iov_iter_advance(iter, len);
+	}
+}
+
 /*
  * Register memory for RDMA read/write
  * pages[]: the list of pages to register memory with
@@ -2346,14 +2273,15 @@ static struct smbd_mr *get_mr(struct smbd_connecti=
on *info)
  * return value: the MR registered, NULL if failed.
  */
 struct smbd_mr *smbd_register_mr(
-	struct smbd_connection *info, struct page *pages[], int num_pages,
-	int offset, int tailsz, bool writing, bool need_invalidate)
+	struct smbd_connection *info, struct iov_iter *iter,
+	bool writing, bool need_invalidate)
 {
 	struct smbd_mr *smbdirect_mr;
-	int rc, i;
+	int rc, num_pages;
 	enum dma_data_direction dir;
 	struct ib_reg_wr *reg_wr;
 =

+	num_pages =3D iov_iter_npages(iter, info->max_frmr_depth + 1);
 	if (num_pages > info->max_frmr_depth) {
 		log_rdma_mr(ERR, "num_pages=3D%d max_frmr_depth=3D%d\n",
 			num_pages, info->max_frmr_depth);
@@ -2365,32 +2293,16 @@ struct smbd_mr *smbd_register_mr(
 		log_rdma_mr(ERR, "get_mr returning NULL\n");
 		return NULL;
 	}
+
+	dir =3D writing ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	smbdirect_mr->dir =3D dir;
 	smbdirect_mr->need_invalidate =3D need_invalidate;
 	smbdirect_mr->sgl_count =3D num_pages;
-	sg_init_table(smbdirect_mr->sgl, num_pages);
-
-	log_rdma_mr(INFO, "num_pages=3D0x%x offset=3D0x%x tailsz=3D0x%x\n",
-			num_pages, offset, tailsz);
-
-	if (num_pages =3D=3D 1) {
-		sg_set_page(&smbdirect_mr->sgl[0], pages[0], tailsz, offset);
-		goto skip_multiple_pages;
-	}
 =

-	/* We have at least two pages to register */
-	sg_set_page(
-		&smbdirect_mr->sgl[0], pages[0], PAGE_SIZE - offset, offset);
-	i =3D 1;
-	while (i < num_pages - 1) {
-		sg_set_page(&smbdirect_mr->sgl[i], pages[i], PAGE_SIZE, 0);
-		i++;
-	}
-	sg_set_page(&smbdirect_mr->sgl[i], pages[i],
-		tailsz ? tailsz : PAGE_SIZE, 0);
+	log_rdma_mr(INFO, "num_pages=3D0x%x count=3D0x%zx\n",
+		    num_pages, iov_iter_count(iter));
+	smbd_iter_to_mr(info, iter, smbdirect_mr->sgl, num_pages);
 =

-skip_multiple_pages:
-	dir =3D writing ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
-	smbdirect_mr->dir =3D dir;
 	rc =3D ib_dma_map_sg(info->id->device, smbdirect_mr->sgl, num_pages, dir=
);
 	if (!rc) {
 		log_rdma_mr(ERR, "ib_dma_map_sg num_pages=3D%x dir=3D%x rc=3D%x\n",
diff --git a/fs/cifs/smbdirect.h b/fs/cifs/smbdirect.h
index a87fca82a796..3a0d39e148e8 100644
--- a/fs/cifs/smbdirect.h
+++ b/fs/cifs/smbdirect.h
@@ -298,8 +298,8 @@ struct smbd_mr {
 =

 /* Interfaces to register and deregister MR for RDMA read/write */
 struct smbd_mr *smbd_register_mr(
-	struct smbd_connection *info, struct page *pages[], int num_pages,
-	int offset, int tailsz, bool writing, bool need_invalidate);
+	struct smbd_connection *info, struct iov_iter *iter,
+	bool writing, bool need_invalidate);
 int smbd_deregister_mr(struct smbd_mr *mr);
 =

 #else


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB7770143
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjHDNRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjHDNQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2F4EDB
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/BKSXxxhhMTfoeqsWRqFb0Oq6eukia0RhTi4EGOEeI=;
        b=h3Q/wBuBmxpkvQMhHDEQRfsx6biauQUfUjaqdtLvTxWKrP/LabSGDALWDwEwZQ1aKQzufs
        afIUE62EHBWT1vorrvKydVg/efIp46yen/LVc9GmVQYt2BENqnjvMWqLPxL8iyMptw7U0Z
        NfJZaNvQWGLH+3s05gMyLRyhB+tfbyU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-EwXe6hFBMXSXqLNuy816gg-1; Fri, 04 Aug 2023 09:14:07 -0400
X-MC-Unique: EwXe6hFBMXSXqLNuy816gg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 585A9805951;
        Fri,  4 Aug 2023 13:14:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37D29201EE6E;
        Fri,  4 Aug 2023 13:14:05 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 18/18] ceph: Don't use data_pages
Date:   Fri,  4 Aug 2023 14:13:27 +0100
Message-ID: <20230804131327.2574082-19-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---
 fs/ceph/addr.c                  | 16 +++++-----------
 fs/ceph/file.c                  | 34 +++++++++++++++------------------
 include/linux/ceph/osd_client.h |  1 +
 net/ceph/osd_client.c           | 16 ++--------------
 4 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7571606cf61f..7557f4a85ef0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -277,11 +277,6 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 		}
 	}
 
-	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-		ceph_put_page_vector(osd_data->pages,
-				     calc_pages_for(osd_data->offset,
-					osd_data->length), false);
-	}
 	netfs_subreq_terminated(subreq, err, false);
 	iput(req->r_inode);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
@@ -2007,7 +2002,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	struct ceph_osd_request *rd_req = NULL, *wr_req = NULL;
 	struct rb_node **p, *parent;
 	struct ceph_pool_perm *perm;
-	struct page **pages;
+	struct ceph_databuf *dbuf;
 	size_t pool_ns_len;
 	int err = 0, err2 = 0, have = 0;
 
@@ -2107,14 +2102,13 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		goto out_unlock;
 
 	/* one page should be large enough for STAT data */
-	pages = ceph_alloc_page_vector(1, GFP_KERNEL);
-	if (IS_ERR(pages)) {
-		err = PTR_ERR(pages);
+	dbuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_KERNEL);
+	if (!dbuf) {
+		err = -ENOMEM;
 		goto out_unlock;
 	}
 
-	osd_req_op_raw_data_in_pages(rd_req, 0, pages, PAGE_SIZE,
-				     0, false, true);
+	osd_req_op_raw_data_in_databuf(rd_req, 0, dbuf);
 	ceph_osdc_start_request(&fsc->client->osdc, rd_req);
 
 	wr_req->r_mtime = ci->netfs.inode.i_mtime;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5d16469a3690..caf557187ca8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -977,6 +977,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
+	struct ceph_databuf *dbuf;
 	ssize_t ret;
 	u64 off = *ki_pos;
 	u64 len = iov_iter_count(to);
@@ -1041,16 +1042,14 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 
 		num_pages = calc_pages_for(read_off, read_len);
 		page_off = offset_in_page(off);
-		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
-		if (IS_ERR(pages)) {
+		dbuf = ceph_databuf_alloc(num_pages, read_len, GFP_KERNEL);
+		if (!dbuf) {
 			ceph_osdc_put_request(req);
-			ret = PTR_ERR(pages);
+			ret = -ENOMEM;
 			break;
 		}
 
-		osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
-						 offset_in_page(read_off),
-						 false, false);
+		osd_req_op_extent_osd_databuf(req, 0, dbuf);
 
 		op = &req->r_ops[0];
 		if (sparse) {
@@ -1137,7 +1136,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 				break;
 			}
 		}
-		ceph_release_page_vector(pages, num_pages);
+		ceph_databuf_release(dbuf);
 
 		if (ret < 0) {
 			if (ret == -EBLOCKLISTED)
@@ -1625,7 +1624,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_osd_request *req;
-	struct page **pages;
+	struct ceph_databuf *dbuf = NULL;
 	u64 len;
 	int num_pages;
 	int written = 0;
@@ -1691,9 +1690,9 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		 * an array of pagecache pages.
 		 */
 		num_pages = calc_pages_for(write_pos, write_len);
-		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
-		if (IS_ERR(pages)) {
-			ret = PTR_ERR(pages);
+		dbuf = ceph_databuf_alloc(num_pages, num_pages * PAGE_SIZE, GFP_KERNEL);
+		if (!dbuf) {
+			ret = -ENOMEM;
 			break;
 		}
 
@@ -1722,7 +1721,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 					NULL, ci->i_truncate_seq,
 					ci->i_truncate_size, false);
 			if (IS_ERR(req)) {
-				ceph_release_page_vector(pages, num_pages);
 				ret = PTR_ERR(req);
 				break;
 			}
@@ -1730,7 +1728,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			/* Something is misaligned! */
 			if (read_len != CEPH_FSCRYPT_BLOCK_SIZE) {
 				ceph_osdc_put_request(req);
-				ceph_release_page_vector(pages, num_pages);
 				ret = -EIO;
 				break;
 			}
@@ -1739,15 +1736,14 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			op = &req->r_ops[0];
 
 			if (first) {
-				osd_req_op_extent_osd_data_pages(req, 0, pages,
-							 CEPH_FSCRYPT_BLOCK_SIZE,
-							 offset_in_page(first_pos),
-							 false, false);
+				iov_iter_advance(&dbuf->iter, offset_in_page(first_pos));
+				osd_req_op_extent_osd_databuf(req, 0, dbuf,
+							 CEPH_FSCRYPT_BLOCK_SIZE);
+				dbuf = NULL;
 				/* We only expect a single extent here */
 				ret = __ceph_alloc_sparse_ext_map(op, 1);
 				if (ret) {
 					ceph_osdc_put_request(req);
-					ceph_release_page_vector(pages, num_pages);
 					break;
 				}
 			}
@@ -1766,7 +1762,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 				ret = __ceph_alloc_sparse_ext_map(op, 1);
 				if (ret) {
 					ceph_osdc_put_request(req);
-					ceph_release_page_vector(pages, num_pages);
 					break;
 				}
 
@@ -1998,6 +1993,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 
 	}
 
+	ceph_databuf_release(dbuf);
 	if (ret != -EOLDSNAPC && written > 0) {
 		ret = written;
 		iocb->ki_pos = pos;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 1a1137787487..c26a7866695a 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -110,6 +110,7 @@ struct ceph_osd_data {
 	enum ceph_osd_data_type	type;
 	struct ceph_databuf	*dbuf;
 	struct iov_iter		iter;
+	size_t			length;
 };
 
 struct ceph_osd_req_op {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6fb78ae14f03..95daf4cdb07b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -127,6 +127,7 @@ static void ceph_osd_iter_init(struct ceph_osd_data *osd_data,
 {
 	osd_data->type = CEPH_OSD_DATA_TYPE_ITER;
 	osd_data->iter = *iter;
+	osd_data->length = iter->count;
 }
 
 /*
@@ -239,19 +240,6 @@ void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_databuf);
 
-static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
-{
-	switch (osd_data->type) {
-	case CEPH_OSD_DATA_TYPE_NONE:
-		return 0;
-	case CEPH_OSD_DATA_TYPE_ITER:
-		return iov_iter_count(&osd_data->iter);
-	default:
-		WARN(true, "unrecognized data type %d\n", (int)osd_data->type);
-		return 0;
-	}
-}
-
 static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
 {
 	ceph_osd_data_init(osd_data);
@@ -4475,7 +4463,7 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 			if (data) {
 				if (lreq->reply) {
 					WARN_ON(data->type !=
-							CEPH_MSG_DATA_PAGES);
+							CEPH_MSG_DATA_DATABUF);
 					*lreq->preply_pages = data->pages;
 					*lreq->preply_len = data->length;
 					data->own_pages = false;


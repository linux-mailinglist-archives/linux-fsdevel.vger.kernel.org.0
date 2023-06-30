Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310F8743ED0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjF3P2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjF3P1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456EB4223
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTUg/mVQyhhJfywizixeKkySOuaXp8UTsLqq+KCOGUE=;
        b=WNg25deKgrYEnpvnf5CNUMEsLfb1WLiLr6bYEZeUOAerZEFq45j1dIcC5xS6t+XQcp1Y+I
        ooSPYx2aHhts0hRDYgK7sWBwsN14OzqG1tPRLaoLHnIj9uf3R6QN32GE7AzrHQ0FSL2/42
        JIpKtx1oebZT07ZsQDNrNadCnDTmA4M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-ykgDuP25MHy7G1d5_4sdcQ-1; Fri, 30 Jun 2023 11:26:03 -0400
X-MC-Unique: ykgDuP25MHy7G1d5_4sdcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21B6D1C0512E;
        Fri, 30 Jun 2023 15:26:02 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF05540C6CCD;
        Fri, 30 Jun 2023 15:25:59 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: [RFC PATCH 11/11] scsi: Use extract_iter_to_sg()
Date:   Fri, 30 Jun 2023 16:25:24 +0100
Message-ID: <20230630152524.661208-12-dhowells@redhat.com>
In-Reply-To: <20230630152524.661208-1-dhowells@redhat.com>
References: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use extract_iter_to_sg() to build a scatterlist from an iterator.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: James E.J. Bottomley <jejb@linux.ibm.com>
cc: Martin K. Petersen <martin.petersen@oracle.com>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-scsi@vger.kernel.org
---
 drivers/vhost/scsi.c | 79 +++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 56 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index bb10fa4bb4f6..7bb41e2a0d64 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -75,6 +75,9 @@ struct vhost_scsi_cmd {
 	u32 tvc_prot_sgl_count;
 	/* Saved unpacked SCSI LUN for vhost_scsi_target_queue_cmd() */
 	u32 tvc_lun;
+	/* Cleanup modes for scatterlists */
+	unsigned int tvc_need_unpin;
+	unsigned int tvc_prot_need_unpin;
 	/* Pointer to the SGL formatted memory from virtio-scsi */
 	struct scatterlist *tvc_sgl;
 	struct scatterlist *tvc_prot_sgl;
@@ -327,14 +330,13 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 	struct vhost_scsi_inflight *inflight = tv_cmd->inflight;
 	int i;
 
-	if (tv_cmd->tvc_sgl_count) {
+	if (tv_cmd->tvc_need_unpin && tv_cmd->tvc_sgl_count)
 		for (i = 0; i < tv_cmd->tvc_sgl_count; i++)
-			put_page(sg_page(&tv_cmd->tvc_sgl[i]));
-	}
-	if (tv_cmd->tvc_prot_sgl_count) {
+			unpin_user_page(sg_page(&tv_cmd->tvc_sgl[i]));
+
+	if (tv_cmd->tvc_prot_need_unpin && tv_cmd->tvc_prot_sgl_count)
 		for (i = 0; i < tv_cmd->tvc_prot_sgl_count; i++)
-			put_page(sg_page(&tv_cmd->tvc_prot_sgl[i]));
-	}
+			unpin_user_page(sg_page(&tv_cmd->tvc_prot_sgl[i]));
 
 	sbitmap_clear_bit(&svq->scsi_tags, se_cmd->map_tag);
 	vhost_scsi_put_inflight(inflight);
@@ -606,38 +608,6 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
 	return cmd;
 }
 
-/*
- * Map a user memory range into a scatterlist
- *
- * Returns the number of scatterlist entries used or -errno on error.
- */
-static int
-vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
-		      struct iov_iter *iter,
-		      struct scatterlist *sgl,
-		      bool write)
-{
-	struct page **pages = cmd->tvc_upages;
-	struct scatterlist *sg = sgl;
-	ssize_t bytes;
-	size_t offset;
-	unsigned int npages = 0;
-
-	bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
-				VHOST_SCSI_PREALLOC_UPAGES, &offset);
-	/* No pages were pinned */
-	if (bytes <= 0)
-		return bytes < 0 ? bytes : -EFAULT;
-
-	while (bytes) {
-		unsigned n = min_t(unsigned, PAGE_SIZE - offset, bytes);
-		sg_set_page(sg++, pages[npages++], n, offset);
-		bytes -= n;
-		offset = 0;
-	}
-	return npages;
-}
-
 static int
 vhost_scsi_calc_sgls(struct iov_iter *iter, size_t bytes, int max_sgls)
 {
@@ -661,24 +631,19 @@ vhost_scsi_calc_sgls(struct iov_iter *iter, size_t bytes, int max_sgls)
 static int
 vhost_scsi_iov_to_sgl(struct vhost_scsi_cmd *cmd, bool write,
 		      struct iov_iter *iter,
-		      struct scatterlist *sg, int sg_count)
+		      struct scatterlist *sg, int sg_count,
+		      unsigned int *need_unpin)
 {
-	struct scatterlist *p = sg;
-	int ret;
+	struct sg_table sgt = { .sgl = sg };
+	ssize_t ret;
 
-	while (iov_iter_count(iter)) {
-		ret = vhost_scsi_map_to_sgl(cmd, iter, sg, write);
-		if (ret < 0) {
-			while (p < sg) {
-				struct page *page = sg_page(p++);
-				if (page)
-					put_page(page);
-			}
-			return ret;
-		}
-		sg += ret;
-	}
-	return 0;
+	ret = extract_iter_to_sg(iter, LONG_MAX, &sgt, sg_count,
+				 write ? WRITE_FROM_ITER : READ_INTO_ITER);
+	if (ret > 0)
+		sg_mark_end(sg + sgt.nents - 1);
+
+	*need_unpin = iov_iter_extract_will_pin(iter);
+	return ret;
 }
 
 static int
@@ -702,7 +667,8 @@ vhost_scsi_mapal(struct vhost_scsi_cmd *cmd,
 
 		ret = vhost_scsi_iov_to_sgl(cmd, write, prot_iter,
 					    cmd->tvc_prot_sgl,
-					    cmd->tvc_prot_sgl_count);
+					    cmd->tvc_prot_sgl_count,
+					    &cmd->tvc_prot_need_unpin);
 		if (ret < 0) {
 			cmd->tvc_prot_sgl_count = 0;
 			return ret;
@@ -719,7 +685,8 @@ vhost_scsi_mapal(struct vhost_scsi_cmd *cmd,
 		  cmd->tvc_sgl, cmd->tvc_sgl_count);
 
 	ret = vhost_scsi_iov_to_sgl(cmd, write, data_iter,
-				    cmd->tvc_sgl, cmd->tvc_sgl_count);
+				    cmd->tvc_sgl, cmd->tvc_sgl_count,
+				    &cmd->tvc_need_unpin);
 	if (ret < 0) {
 		cmd->tvc_sgl_count = 0;
 		return ret;


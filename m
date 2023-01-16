Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73A066D2D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjAPXOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjAPXNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D392ED79
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EU0pOV6WBLH3AThSCCtWqw1z4qNF39IxpGe04ts73SI=;
        b=KMOzHRIJJUWXBlyRWBI/M6tafkITKUDRyjvzdXGhznL4aBIYbHRP/+WCdb4MA9aTTbHWHZ
        y870npR6fRffOMvDSkMlXyJoGzcAWt+LULKM/5GvfFBbFg/8GCXuuVFlOCgNI46H1jSj+L
        gRGm52/wLSvCgTqwuCVjUZuOJGKdn74=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-RByxuKzUOKioXzZbR3mJUw-1; Mon, 16 Jan 2023 18:10:06 -0500
X-MC-Unique: RByxuKzUOKioXzZbR3mJUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0ACC71C0432B;
        Mon, 16 Jan 2023 23:10:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57C3C1121319;
        Mon, 16 Jan 2023 23:10:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 17/34] scsi: [RFC] Use netfs_extract_iter_to_sg()
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:10:03 +0000
Message-ID: <167391060380.2311931.5962669831677025433.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use netfs_extract_iter_to_sg() to build a scatterlist from an iterator.

Note that if this fits, netfs_extract_iter_to_sg() should move to core
code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: James E.J. Bottomley <jejb@linux.ibm.com>
cc: Martin K. Petersen <martin.petersen@oracle.com>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-scsi@vger.kernel.org
---

 drivers/vhost/scsi.c |   78 +++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 55 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 5d10837d19ec..af897cc4036d 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -34,6 +34,7 @@
 #include <linux/virtio_scsi.h>
 #include <linux/llist.h>
 #include <linux/bitmap.h>
+#include <linux/netfs.h>
 
 #include "vhost.h"
 
@@ -75,6 +76,9 @@ struct vhost_scsi_cmd {
 	u32 tvc_prot_sgl_count;
 	/* Saved unpacked SCSI LUN for vhost_scsi_target_queue_cmd() */
 	u32 tvc_lun;
+	/* Cleanup modes for scatterlists */
+	unsigned int tvc_cleanup_mode;
+	unsigned int tvc_prot_cleanup_mode;
 	/* Pointer to the SGL formatted memory from virtio-scsi */
 	struct scatterlist *tvc_sgl;
 	struct scatterlist *tvc_prot_sgl;
@@ -339,11 +343,13 @@ static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 
 	if (tv_cmd->tvc_sgl_count) {
 		for (i = 0; i < tv_cmd->tvc_sgl_count; i++)
-			put_page(sg_page(&tv_cmd->tvc_sgl[i]));
+			page_put_unpin(sg_page(&tv_cmd->tvc_sgl[i]),
+				       tv_cmd->tvc_cleanup_mode);
 	}
 	if (tv_cmd->tvc_prot_sgl_count) {
 		for (i = 0; i < tv_cmd->tvc_prot_sgl_count; i++)
-			put_page(sg_page(&tv_cmd->tvc_prot_sgl[i]));
+			page_put_unpin(sg_page(&tv_cmd->tvc_prot_sgl[i]),
+				       tv_cmd->tvc_prot_cleanup_mode);
 	}
 
 	sbitmap_clear_bit(&svq->scsi_tags, se_cmd->map_tag);
@@ -631,41 +637,6 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
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
-	unsigned int npages = 0, gup_flags = 0;
-
-	gup_flags |= write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF;
-
-	bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
-				   VHOST_SCSI_PREALLOC_UPAGES, &offset,
-				   gup_flags);
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
@@ -689,24 +660,19 @@ vhost_scsi_calc_sgls(struct iov_iter *iter, size_t bytes, int max_sgls)
 static int
 vhost_scsi_iov_to_sgl(struct vhost_scsi_cmd *cmd, bool write,
 		      struct iov_iter *iter,
-		      struct scatterlist *sg, int sg_count)
+		      struct scatterlist *sg, int sg_count,
+		      unsigned int *cleanup_mode)
 {
-	struct scatterlist *p = sg;
-	int ret;
+	struct sg_table sgt = { .sgl = sg };
+	unsigned int gup_flags = write ? FOLL_SOURCE_BUF : FOLL_DEST_BUF;
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
+	ret = netfs_extract_iter_to_sg(iter, LONG_MAX, &sgt, sg_count, gup_flags);
+	if (ret > 0)
+		sg_mark_end(sg + sgt.nents - 1);
+
+	*cleanup_mode = iov_iter_extract_mode(iter, gup_flags);
+	return ret;
 }
 
 static int
@@ -730,7 +696,8 @@ vhost_scsi_mapal(struct vhost_scsi_cmd *cmd,
 
 		ret = vhost_scsi_iov_to_sgl(cmd, write, prot_iter,
 					    cmd->tvc_prot_sgl,
-					    cmd->tvc_prot_sgl_count);
+					    cmd->tvc_prot_sgl_count,
+					    &cmd->tvc_prot_cleanup_mode);
 		if (ret < 0) {
 			cmd->tvc_prot_sgl_count = 0;
 			return ret;
@@ -747,7 +714,8 @@ vhost_scsi_mapal(struct vhost_scsi_cmd *cmd,
 		  cmd->tvc_sgl, cmd->tvc_sgl_count);
 
 	ret = vhost_scsi_iov_to_sgl(cmd, write, data_iter,
-				    cmd->tvc_sgl, cmd->tvc_sgl_count);
+				    cmd->tvc_sgl, cmd->tvc_sgl_count,
+				    &cmd->tvc_cleanup_mode);
 	if (ret < 0) {
 		cmd->tvc_sgl_count = 0;
 		return ret;



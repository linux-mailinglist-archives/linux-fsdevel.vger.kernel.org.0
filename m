Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4180952BE9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiERPLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 11:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiERPLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 11:11:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F05B875;
        Wed, 18 May 2022 08:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10318B81BD9;
        Wed, 18 May 2022 15:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439A5C385A9;
        Wed, 18 May 2022 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652886676;
        bh=9W71JbdZqORON3ZtMJgsQNIwd/tY1dgG9++fufgZKwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpS827J0FpXk4qMRKfP+Hq5MO//kSLfG/2gJaudQpOvEBGjoeUR4ao0EJWYcvFdXS
         kqjNEYG/zzwGx7BsV2TYGmAvdOwkw5Ike7tK6BdbJRrLxPhtr3B9aEZ+FONWrvSmij
         kj64goLQtUrRivIM4iuEfo8q1IagOIYR19gukMfaWmGgkkn8Dz/O4TkkQvbIKxrfJp
         beMzi4EZLz4/jGALPVUVLx/AIYoWTBPzVbSNSmeQzzst8TNmcNX7y5oaWJZ/HMQ2jV
         1F7kGvwLQzjzaco50YOKEZX5MH2/YVYvwVReOLjq4sFnR8X+tbR+7j5ABBpF3D5i66
         WQxbpkd6lmLRg==
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        xiubli@redhat.com, idryomov@gmail.com
Subject: [PATCH 4/4] ceph: switch to netfs_direct_read_iter
Date:   Wed, 18 May 2022 11:11:11 -0400
Message-Id: <20220518151111.79735-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518151111.79735-1-jlayton@kernel.org>
References: <20220518151111.79735-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 41 +++++++++++++++++++++++++++++------------
 fs/ceph/file.c |  3 +--
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 475df4efd2c7..938679a7a1e3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -201,7 +201,6 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	struct ceph_fs_client *fsc = ceph_inode_to_client(req->r_inode);
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
 	struct netfs_io_subrequest *subreq = req->r_priv;
-	int num_pages;
 	int err = req->r_result;
 
 	ceph_update_read_metrics(&fsc->mdsc->metric, req->r_start_latency,
@@ -216,13 +215,18 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	else if (err == -EBLOCKLISTED)
 		fsc->blocklisted = true;
 
-	if (err >= 0 && err < subreq->len)
-		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	if (err >= 0) {
+		if (err < subreq->len)
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		iov_iter_advance(&subreq->iter, err);
+	}
+	if (!iov_iter_is_bvec(&subreq->iter))
+		ceph_put_page_vector(osd_data->pages,
+				     calc_pages_for(osd_data->alignment,
+				     osd_data->length),
+				     false);
 
 	netfs_subreq_terminated(subreq, err, true);
-
-	num_pages = calc_pages_for(osd_data->alignment, osd_data->length);
-	ceph_put_page_vector(osd_data->pages, num_pages, false);
 	iput(req->r_inode);
 }
 
@@ -287,6 +291,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_osd_request *req;
 	struct ceph_vino vino = ceph_vino(inode);
+	struct iov_iter *iter = &subreq->iter;
 	struct page **pages;
 	size_t page_off;
 	int err = 0;
@@ -310,16 +315,28 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		__func__, subreq->start, subreq->len, len, rreq->debug_id,
 		subreq->debug_index, iov_iter_count(&subreq->iter));
 
-	err = iov_iter_get_pages_alloc(&subreq->iter, &pages, len, &page_off);
-	if (err < 0) {
-		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
-		goto out;
+	if (iov_iter_is_bvec(iter)) {
+		/*
+		 * FIXME: remove force cast, ideally by plumbing an IOV_ITER osd_data
+		 * 	  variant.
+		 */
+		osd_req_op_extent_osd_data_bvecs(req, 0, (__force struct bio_vec *)iter->bvec,
+				iter->nr_segs, len);
+		goto submit;
 	}
 
-	/* FIXME: adjust the len in req downward if necessary */
-	len = err;
+	err = iov_iter_get_pages_alloc(&subreq->iter, &pages, len, &page_off);
+	if (err < len) {
+		if (err < 0) {
+			dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
+			goto out;
+		}
+		len = err;
+		req->r_ops[0].extent.length = err;
+	}
 
 	osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false, false);
+submit:
 	req->r_callback = finish_netfs_read;
 	req->r_priv = subreq;
 	req->r_inode = inode;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 8c8226c0feac..81ce6753fa67 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1634,8 +1634,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		if (ci->i_inline_version == CEPH_INLINE_NONE) {
 			if (!retry_op && (iocb->ki_flags & IOCB_DIRECT)) {
-				ret = ceph_direct_read_write(iocb, to,
-							     NULL, NULL);
+				ret = netfs_direct_read_iter(iocb, to);
 				if (ret >= 0 && ret < len)
 					retry_op = CHECK_EOF;
 			} else {
-- 
2.36.1


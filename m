Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE11355CC47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiF0PzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbiF0Py6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:54:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC147665;
        Mon, 27 Jun 2022 08:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05ECEB818AD;
        Mon, 27 Jun 2022 15:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2129AC341CB;
        Mon, 27 Jun 2022 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656345293;
        bh=oKiqry2h2v27qNzqjdNlARqLDfGm6Lm0tMY1S1ZdLl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhagteGm2jZkW4MgfuWbyQ1Ot99UCFZd9oEnP/887j+/ysesVTuTmvWEb7p+T45cs
         G1UyLxMYu0+EhR5TFGtvS/SRqGutbv5Ku4bVGrdTfFj7hQ3sOVcy6JhcV7rsgvL7ce
         SitcAYW/keP2Goa6tamCMiOUIVbc59IqfSJnA+9qghTZPIm0L5VcIj+9qjZWH9uwOB
         EGR/qwY0suWeNqWdtK4XOEg8fZ2M1kPec0bgwb+dLzyXVCmQVWdfobgeKFMiVczLdY
         g10lyhZlpjyormbpknemKaUrU/ZalcQCD1ajKiQDkfrFn+t89UlFHix+0jlr7PumoC
         TRrbFNRtKVIgw==
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] ceph: use osd_req_op_extent_osd_iter for netfs reads
Date:   Mon, 27 Jun 2022 11:54:49 -0400
Message-Id: <20220627155449.383989-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627155449.383989-1-jlayton@kernel.org>
References: <20220627155449.383989-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The netfs layer has already pinned the pages involved before calling
issue_op, so we can just pass down the iter directly instead of calling
iov_iter_get_pages_alloc.

Instead of having to allocate a page array, use CEPH_MSG_DATA_ITER and
pass it the iov_iter directly to clone.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index fe6147f20dee..63165668079c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -220,7 +220,6 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
 	struct netfs_io_subrequest *subreq = req->r_priv;
 	struct ceph_osd_req_op *op = &req->r_ops[0];
-	int num_pages;
 	int err = req->r_result;
 	bool sparse = (op->op == CEPH_OSD_OP_SPARSE_READ);
 
@@ -242,9 +241,6 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
 	netfs_subreq_terminated(subreq, err, false);
-
-	num_pages = calc_pages_for(osd_data->alignment, osd_data->length);
-	ceph_put_page_vector(osd_data->pages, num_pages, false);
 	iput(req->r_inode);
 }
 
@@ -312,8 +308,6 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	struct ceph_osd_request *req;
 	struct ceph_vino vino = ceph_vino(inode);
 	struct iov_iter iter;
-	struct page **pages;
-	size_t page_off;
 	int err = 0;
 	u64 len = subreq->len;
 	bool sparse = ceph_test_mount_opt(fsc, SPARSEREAD);
@@ -341,17 +335,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 
 	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
 	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
-	err = iov_iter_get_pages_alloc(&iter, &pages, len, &page_off);
-	if (err < 0) {
-		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
-		goto out;
-	}
-
-	/* should always give us a page-aligned read */
-	WARN_ON_ONCE(page_off);
-	len = err;
-
-	osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0, false, false);
+	osd_req_op_extent_osd_iter(req, 0, &iter);
 	req->r_callback = finish_netfs_read;
 	req->r_priv = subreq;
 	req->r_inode = inode;
-- 
2.36.1


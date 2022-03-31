Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE24EDD83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbiCaPk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiCaPhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F0422B6C7;
        Thu, 31 Mar 2022 08:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 568CB61AEA;
        Thu, 31 Mar 2022 15:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21972C340F3;
        Thu, 31 Mar 2022 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740738;
        bh=lmWTG2rDKdWATJjrv7Z1WOhsCaXCriPANqr5jvzR8pQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkzVHaKYAO7Yv8LmFQxsmGuurqT7hT519lOTqhI2k8dRbuInnALf7lw+rxCNH6GBH
         H9ZPQ1p6TTcrLwvEwgeyvwd3g2TQXHnHoJ8udhG0+uqgn7/DR5twThHl0ZoV+ZBuke
         LaOxdGRFJ67I1OEwkXvA+4x3LKYJL6TgFc9U3ofOA2NWX3AWlCWfSEhtMyjk0aRHU3
         mOrdU39YJTriuEiGZeNylE2uQTBQM9KHeDi9ySnj+g1e/PUe3LvxgyNXJcvsupSNxr
         1a/+56YOj8SWgXzwlXOv2BQffuAg1YKOEpuoQWjIxPOOVrBu4KYYOXL30mGC6M9WIe
         WFcOdqYZOd8lA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 51/54] ceph: add fscrypt decryption support to ceph_netfs_issue_op
Date:   Thu, 31 Mar 2022 11:31:27 -0400
Message-Id: <20220331153130.41287-52-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Force the use of sparse reads when the inode is encrypted, and add the
appropriate code to decrypt the extent map after receiving.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 15bc455bc87f..13a37a568a1d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -18,6 +18,7 @@
 #include "mds_client.h"
 #include "cache.h"
 #include "metric.h"
+#include "crypto.h"
 #include <linux/ceph/osd_client.h>
 #include <linux/ceph/striper.h>
 
@@ -217,7 +218,8 @@ static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 
 static void finish_netfs_read(struct ceph_osd_request *req)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(req->r_inode);
+	struct inode *inode = req->r_inode;
+	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
 	struct netfs_read_subrequest *subreq = req->r_priv;
 	struct ceph_osd_req_op *op = &req->r_ops[0];
@@ -232,15 +234,24 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	     subreq->len, i_size_read(req->r_inode));
 
 	/* no object means success but no data */
-	if (sparse && err >= 0)
-		err = ceph_sparse_ext_map_end(op);
-	else if (err == -ENOENT)
+	if (err == -ENOENT)
 		err = 0;
 	else if (err == -EBLOCKLISTED)
 		fsc->blocklisted = true;
 
-	if (err >= 0 && err < subreq->len)
-		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	if (err >= 0) {
+		if (sparse && err > 0)
+			err = ceph_sparse_ext_map_end(op);
+		if (err < subreq->len)
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		if (IS_ENCRYPTED(inode) && err > 0) {
+			err = ceph_fscrypt_decrypt_extents(inode, osd_data->pages,
+					subreq->start, op->extent.sparse_ext,
+					op->extent.sparse_ext_cnt);
+			if (err > subreq->len)
+				err = subreq->len;
+		}
+	}
 
 	netfs_subreq_terminated(subreq, err, true);
 
@@ -315,13 +326,16 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 	size_t page_off;
 	int err = 0;
 	u64 len = subreq->len;
-	bool sparse = ceph_test_mount_opt(fsc, SPARSEREAD);
+	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
+	u64 off = subreq->start;
 
 	if (ci->i_inline_version != CEPH_INLINE_NONE &&
 	    ceph_netfs_issue_op_inline(subreq))
 		return;
 
-	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino, subreq->start, &len,
+	ceph_fscrypt_adjust_off_and_len(inode, &off, &len);
+
+	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino, off, &len,
 			0, 1, sparse ? CEPH_OSD_OP_SPARSE_READ : CEPH_OSD_OP_READ,
 			CEPH_OSD_FLAG_READ | fsc->client->osdc.client->options->read_from_replica,
 			NULL, ci->i_truncate_seq, ci->i_truncate_size, false);
@@ -341,7 +355,7 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 	}
 
 	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
+	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, off, len);
 	err = iov_iter_get_pages_alloc(&iter, &pages, len, &page_off);
 	if (err < 0) {
 		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
-- 
2.35.1


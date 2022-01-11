Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3748B722
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350910AbiAKTR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350580AbiAKTRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E34C028BF6;
        Tue, 11 Jan 2022 11:16:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0393B81D26;
        Tue, 11 Jan 2022 19:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3E4C36AF2;
        Tue, 11 Jan 2022 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928603;
        bh=P8sVB33NWHzlHstTbhByVQTgljDhm1yEWEhkCJF9FHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKTC19ykBNBYRmCOIJx8SxEVe3+UiKGmSqW/acquYlgOT/f2OZQYCgEsW2CzgQWAs
         rFyG/HNHcZl6tNu0SpHPQO3WvBomuftvv10yWdHIrqQUG2H7xANvVghDCTdN/m/Ojn
         SNIr9uC1luV8nYgmZQ79heNqwWStTfTRF2MZ8rLQUuj74ceQl6lZlEX1w1RTIwzTK3
         vZDezQjj+hnlaunCohjSidxcssPKybp3eysTVZayvxw6ohgXBR72KMGoQINc/5NPzk
         onrLrX+tp6nnG67o172ukwg8kgv2Asdbq/CIhjzxcpBSCvv1ECk0lro+L37wtG/Uwx
         E54EwDdZmJ5BA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 46/48] ceph: add fscrypt decryption support to ceph_netfs_issue_op
Date:   Tue, 11 Jan 2022 14:16:06 -0500
Message-Id: <20220111191608.88762-47-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b3d9459c9bbd..dbc587a41fea 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -18,6 +18,7 @@
 #include "mds_client.h"
 #include "cache.h"
 #include "metric.h"
+#include "crypto.h"
 #include <linux/ceph/osd_client.h>
 #include <linux/ceph/striper.h>
 
@@ -200,7 +201,7 @@ static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
 	rreq->len = roundup(rreq->len, lo->stripe_unit);
 }
 
-static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
+static size_t __ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 {
 	struct inode *inode = subreq->rreq->mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
@@ -211,13 +212,18 @@ static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 	/* Truncate the extent at the end of the current block */
 	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
 				      &objno, &objoff, &xlen);
-	subreq->len = min(xlen, fsc->mount_options->rsize);
-	return true;
+	return min(xlen, fsc->mount_options->rsize);
 }
 
+static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
+{
+	subreq->len = __ceph_netfs_clamp_length(subreq);
+	return true;
+}
 static void finish_netfs_read(struct ceph_osd_request *req)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(req->r_inode);
+	struct inode *inode = req->r_inode;
+	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
 	struct netfs_read_subrequest *subreq = req->r_priv;
 	int num_pages;
@@ -235,8 +241,16 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	else if (err == -EBLOCKLISTED)
 		fsc->blocklisted = true;
 
-	if (err >= 0 && err < subreq->len)
-		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	if (err >= 0) {
+		if (err < subreq->len)
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		if (IS_ENCRYPTED(inode)) {
+			err = ceph_fscrypt_decrypt_pages(inode, osd_data->pages,
+							 subreq->start, err);
+			if (err > subreq->len)
+				err = subreq->len;
+		}
+	}
 
 	netfs_subreq_terminated(subreq, err, true);
 
@@ -258,8 +272,11 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 	size_t page_off;
 	int err = 0;
 	u64 len = subreq->len;
+	u64 off = subreq->start;
+
+	fscrypt_adjust_off_and_len(inode, &off, &len);
 
-	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino, subreq->start, &len,
+	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino, off, &len,
 			0, 1, CEPH_OSD_OP_READ,
 			CEPH_OSD_FLAG_READ | fsc->client->osdc.client->options->read_from_replica,
 			NULL, ci->i_truncate_seq, ci->i_truncate_size, false);
@@ -270,7 +287,7 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 	}
 
 	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
+	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, off, len);
 	err = iov_iter_get_pages_alloc(&iter, &pages, len, &page_off);
 	if (err < 0) {
 		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
-- 
2.34.1


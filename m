Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDF75A35FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbiH0Ig2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiH0IgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:36:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF78EB2D9F;
        Sat, 27 Aug 2022 01:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di9w4/4zZrdblMneJtuXTD416WiNIhM1x91YiK0eC+hqk0adLaA1+tyK2M9IvHCt5kqzBRX2Em5mQjAKD+mUMnxPzD/99QIPVXO58aChEcENOS6dcFjD0qhPjHC15+7b3G3yhrRTI1BBZh860PolkxVP+AWolTHspe6QQsvfEdLYPjxfnVg69iHvK0nPoJHKc8QJr8yDrKPiagA1ZuKstTX3B865gY0r38aUfyKT4bemeWaG1gAu7g1Lynjk1h3NWElCwkctjPwfk6YOB7n1aLUQtW37BJ14A4z+bGUkWpCQ4dETa/in611TQRLyZM0nRfTkNgkRxxEmWLGNjFUeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfeJQm0LK+R1tjTZehVFwsPGW1k7GJS7dUu3qTkFBT0=;
 b=gfDBDg1HSqlbtOz0TLnuoeQiLbmFGyD+gampdyl5FRA+YAcnK03YJNOMxYvM1C6qJxWJZDLguPsnu+VKGMHlL05WQxJ+OJB5RjfxG5e6h65HncpKvDESbngV89oIH0wFNP3/IiZ3/6NlagvX6//qTu0Sn0oXfYUtu9vPNBar5Yh4Zo7tGrptpkB8nWQqCXeIUSU65aFCGhOxOLCzLTAejJFXymthrrvUvS3eqJGlCiDUWSLd1MWq+enLaFXDpMBTvWSg4+H94HHjrkfGyivywVsUh2FFKpgV4OnX6TBr6kaqYJM+IB+YqPGn4c0FOW2o9ni/b8tR7Yf2xbiD8xLKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfeJQm0LK+R1tjTZehVFwsPGW1k7GJS7dUu3qTkFBT0=;
 b=KM3NwaQ2RwpVuLEbosVDHnRdrK4qs9JgI+ehoErF0dwRjdCn3WTSO+wOd9HzV/RsiWZYSX7EIm71844yQp30uLy4wKY0E6ogOa04WMNe1kFJg0Tn1lqjbxphtvLPT1oJJdTTuQk/6rwqGyRCWPfgDaJhZnwt/ZIjqDjAc60N8QgJvT2TIgtnCgi/moMlr7O1iA11j+/i21KNn0ewQNIVDjAq5iPkLxeHOqFICjOmSGQvuIcwQDBViKKRfBp9uzF7OdRNQC1TU6/CXeGWwBMBfgyOk7703fdZwcuAHcrSUCuOzUnGVgD82iC0UE/Vms5F9v4iTopYsdD5pH9sFwsukA==
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 08:36:15 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::c) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 08:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 08:36:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sat, 27 Aug 2022 08:36:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sat, 27 Aug 2022 01:36:12 -0700
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 27 Aug 2022 01:36:12 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/6] block, bio, fs: convert most filesystems to pin_user_pages_fast()
Date:   Sat, 27 Aug 2022 01:36:05 -0700
Message-ID: <20220827083607.2345453-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827083607.2345453-1-jhubbard@nvidia.com>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c15a54-adf0-42fd-6f7c-08da880733f3
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0158:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UbbcK2DBVR1SHEGT2Wll47zeWPfFOjIu4YP10+EUoo9+n6wJ8O8ygqCjRNNbVht8jCwESPFiQYKQ+v+YC12KiHHe7/0fXpXzmfHJsPLlJDO/bObRRCQMiEfkorZ3w6EmVnBaCgwtTV6xf9/s6MHKG/XimeTxmFNGFjr+cO9JTaSaAKMsLIvt4PBmyopGTduOZr7tP00Bco/FJuOi3ZeYEiweaZMJRhKO5s9+oUINJaWIhfUGYGsfnnzTDbeQvE58slg+ad+r80SDmiz2eKob+rozIJ3VfvvJLNYphz1PqT3Fm3KzS9P60JQRRPjl55baBnlhFGmpWeiKZ16W9W0VWdTNy2Hsgwajysv+mJePwrZIUID/LjtJ9zv6teOWWzGvIBb7pnxNeMb7CGHYCVmD4tSPHlxG7D7CYmm8gYoXe+W9ilndGyM/mypxeNVprugGfleLcLib2fsBa4jQVwyxPhZGQsH/8sgoIGOgkgXajGD8sT96IQIePxsIKwhDfylJydmk9r8m1NcTPx+yru6xdCZ0+Su+q44uLPCvKfKfOFo45Zbhm2YotOuSWiYOkueQBd9LVLnf+1pDL/aseXz6lCXlqOJrq2avT/GzasXZgg1nd7sFKmeLf1ey4rRRhRhn53pYinTaWod7ytUnnWq32MTbud4q1jxDlVZK9LAtT9ZMQPSXDwPkzfP7heACba5SBCA5K8N/hHErYj6Diput/7sO2xMa+M1R3ulBljMKXR0eoVpDXgVPveX90t9nbIr4Sc/Rw++X+l8dgPomIptP1+uQmQ55VCisSyUSkbRxes=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(40470700004)(36840700001)(46966006)(36860700001)(41300700001)(478600001)(2906002)(8936002)(36756003)(4326008)(8676002)(70586007)(30864003)(83380400001)(7416002)(5660300002)(40480700001)(82740400003)(70206006)(82310400005)(47076005)(26005)(1076003)(426003)(336012)(186003)(107886003)(54906003)(2616005)(6666004)(40460700003)(356005)(81166007)(316002)(86362001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 08:36:14.1587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c15a54-adf0-42fd-6f7c-08da880733f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use dio_w_*() wrapper calls, in place of get_user_pages_fast(),
get_page() and put_page().

This converts the Direct IO parts of most filesystems over to using
FOLL_PIN (pin_user_page*()) page pinning.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/bio.c          | 27 ++++++++++++++-------------
 block/blk-map.c      |  7 ++++---
 fs/direct-io.c       | 40 ++++++++++++++++++++--------------------
 fs/iomap/direct-io.c |  2 +-
 4 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea2..6c6110f7054e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1125,7 +1125,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		dio_w_unpin_user_page(bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1162,7 +1162,7 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 	}
 
 	if (same_page)
-		put_page(page);
+		dio_w_unpin_user_page(page);
 	return 0;
 }
 
@@ -1176,7 +1176,7 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
 	if (same_page)
-		put_page(page);
+		dio_w_unpin_user_page(page);
 	return 0;
 }
 
@@ -1187,10 +1187,10 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be mapped
  *
- * Pins pages from *iter and appends them to @bio's bvec array. The
- * pages will have to be released using put_page() when done.
- * For multi-segment *iter, this function only adds pages from the
- * next non-empty segment of the iov iterator.
+ * Pins pages from *iter and appends them to @bio's bvec array. The pages will
+ * have to be released using dio_w_unpin_user_page when done. For multi-segment
+ * *iter, this function only adds pages from the next non-empty segment of the
+ * iov iterator.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1218,8 +1218,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size = iov_iter_get_pages2(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
-				  nr_pages, &offset);
+	size = dio_w_iov_iter_pin_pages(iter, pages,
+					UINT_MAX - bio->bi_iter.bi_size,
+					nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
@@ -1252,7 +1253,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)
-		put_page(pages[i++]);
+		dio_w_unpin_user_page(pages[i++]);
 
 	return ret;
 }
@@ -1444,9 +1445,9 @@ void bio_set_pages_dirty(struct bio *bio)
  * have been written out during the direct-IO read.  So we take another ref on
  * the BIO and re-dirty the pages in process context.
  *
- * It is expected that bio_check_pages_dirty() will wholly own the BIO from
- * here on.  It will run one put_page() against each page and will run one
- * bio_put() against the BIO.
+ * It is expected that bio_check_pages_dirty() will wholly own the BIO from here
+ * on.  It will run one dio_w_unpin_user_page() against each page and will run
+ * one bio_put() against the BIO.
  */
 
 static void bio_dirty_fn(struct work_struct *work);
diff --git a/block/blk-map.c b/block/blk-map.c
index 7196a6b64c80..4e333ad9776d 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -254,7 +254,8 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		size_t offs, added = 0;
 		int npages;
 
-		bytes = iov_iter_get_pages_alloc2(iter, &pages, LONG_MAX, &offs);
+		bytes = dio_w_iov_iter_pin_pages_alloc(iter, &pages, LONG_MAX,
+						       &offs);
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
@@ -276,7 +277,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
 						     max_sectors, &same_page)) {
 					if (same_page)
-						put_page(page);
+						dio_w_unpin_user_page(page);
 					break;
 				}
 
@@ -289,7 +290,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		 * release the pages we didn't map into the bio, if any
 		 */
 		while (j < npages)
-			put_page(pages[j++]);
+			dio_w_unpin_user_page(pages[j++]);
 		kvfree(pages);
 		/* couldn't stuff something into bio? */
 		if (bytes) {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index f669163d5860..05c044c55374 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -169,8 +169,8 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
 	ssize_t ret;
 
-	ret = iov_iter_get_pages2(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
-				&sdio->from);
+	ret = dio_w_iov_iter_pin_pages(sdio->iter, dio->pages, LONG_MAX,
+				       DIO_PAGES, &sdio->from);
 
 	if (ret < 0 && sdio->blocks_available && dio_op == REQ_OP_WRITE) {
 		struct page *page = ZERO_PAGE(0);
@@ -181,7 +181,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		 */
 		if (dio->page_errors == 0)
 			dio->page_errors = ret;
-		get_page(page);
+		dio_w_pin_user_page(page);
 		dio->pages[0] = page;
 		sdio->head = 0;
 		sdio->tail = 1;
@@ -197,7 +197,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		sdio->to = ((ret - 1) & (PAGE_SIZE - 1)) + 1;
 		return 0;
 	}
-	return ret;	
+	return ret;
 }
 
 /*
@@ -324,7 +324,7 @@ static void dio_aio_complete_work(struct work_struct *work)
 static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio);
 
 /*
- * Asynchronous IO callback. 
+ * Asynchronous IO callback.
  */
 static void dio_bio_end_aio(struct bio *bio)
 {
@@ -449,7 +449,7 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 static inline void dio_cleanup(struct dio *dio, struct dio_submit *sdio)
 {
 	while (sdio->head < sdio->tail)
-		put_page(dio->pages[sdio->head++]);
+		dio_w_unpin_user_page(dio->pages[sdio->head++]);
 }
 
 /*
@@ -716,7 +716,7 @@ static inline int dio_bio_add_page(struct dio_submit *sdio)
 		 */
 		if ((sdio->cur_page_len + sdio->cur_page_offset) == PAGE_SIZE)
 			sdio->pages_in_io--;
-		get_page(sdio->cur_page);
+		dio_w_pin_user_page(sdio->cur_page);
 		sdio->final_block_in_bio = sdio->cur_page_block +
 			(sdio->cur_page_len >> sdio->blkbits);
 		ret = 0;
@@ -725,7 +725,7 @@ static inline int dio_bio_add_page(struct dio_submit *sdio)
 	}
 	return ret;
 }
-		
+
 /*
  * Put cur_page under IO.  The section of cur_page which is described by
  * cur_page_offset,cur_page_len is put into a BIO.  The section of cur_page
@@ -787,7 +787,7 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
  * An autonomous function to put a chunk of a page under deferred IO.
  *
  * The caller doesn't actually know (or care) whether this piece of page is in
- * a BIO, or is under IO or whatever.  We just take care of all possible 
+ * a BIO, or is under IO or whatever.  We just take care of all possible
  * situations here.  The separation between the logic of do_direct_IO() and
  * that of submit_page_section() is important for clarity.  Please don't break.
  *
@@ -832,13 +832,13 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 	 */
 	if (sdio->cur_page) {
 		ret = dio_send_cur_page(dio, sdio, map_bh);
-		put_page(sdio->cur_page);
+		dio_w_unpin_user_page(sdio->cur_page);
 		sdio->cur_page = NULL;
 		if (ret)
 			return ret;
 	}
 
-	get_page(page);		/* It is in dio */
+	dio_w_pin_user_page(page); /* It is in dio */
 	sdio->cur_page = page;
 	sdio->cur_page_offset = offset;
 	sdio->cur_page_len = len;
@@ -853,7 +853,7 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 		ret = dio_send_cur_page(dio, sdio, map_bh);
 		if (sdio->bio)
 			dio_bio_submit(dio, sdio);
-		put_page(sdio->cur_page);
+		dio_w_unpin_user_page(sdio->cur_page);
 		sdio->cur_page = NULL;
 	}
 	return ret;
@@ -890,7 +890,7 @@ static inline void dio_zero_block(struct dio *dio, struct dio_submit *sdio,
 	 * We need to zero out part of an fs block.  It is either at the
 	 * beginning or the end of the fs block.
 	 */
-	if (end) 
+	if (end)
 		this_chunk_blocks = dio_blocks_per_fs_block - this_chunk_blocks;
 
 	this_chunk_bytes = this_chunk_blocks << sdio->blkbits;
@@ -954,7 +954,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				ret = get_more_blocks(dio, sdio, map_bh);
 				if (ret) {
-					put_page(page);
+					dio_w_unpin_user_page(page);
 					goto out;
 				}
 				if (!buffer_mapped(map_bh))
@@ -999,7 +999,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				/* AKPM: eargh, -ENOTBLK is a hack */
 				if (dio_op == REQ_OP_WRITE) {
-					put_page(page);
+					dio_w_unpin_user_page(page);
 					return -ENOTBLK;
 				}
 
@@ -1012,7 +1012,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 				if (sdio->block_in_file >=
 						i_size_aligned >> blkbits) {
 					/* We hit eof */
-					put_page(page);
+					dio_w_unpin_user_page(page);
 					goto out;
 				}
 				zero_user(page, from, 1 << blkbits);
@@ -1052,7 +1052,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 						  sdio->next_block_for_io,
 						  map_bh);
 			if (ret) {
-				put_page(page);
+				dio_w_unpin_user_page(page);
 				goto out;
 			}
 			sdio->next_block_for_io += this_chunk_blocks;
@@ -1067,8 +1067,8 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 				break;
 		}
 
-		/* Drop the ref which was taken in get_user_pages() */
-		put_page(page);
+		/* Drop the ref which was taken in [get|pin]_user_pages() */
+		dio_w_unpin_user_page(page);
 	}
 out:
 	return ret;
@@ -1288,7 +1288,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		ret2 = dio_send_cur_page(dio, &sdio, &map_bh);
 		if (retval == 0)
 			retval = ret2;
-		put_page(sdio.cur_page);
+		dio_w_unpin_user_page(sdio.cur_page);
 		sdio.cur_page = NULL;
 	}
 	if (sdio.bio)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4eb559a16c9e..fc7763c418d1 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -202,7 +202,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	get_page(page);
+	dio_w_pin_user_page(page);
 	__bio_add_page(bio, page, len, 0);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
-- 
2.37.2


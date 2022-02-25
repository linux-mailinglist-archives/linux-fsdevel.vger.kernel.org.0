Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3D4C4091
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiBYIvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 03:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbiBYIvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:51:14 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3912317AEC4;
        Fri, 25 Feb 2022 00:50:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEcuxonxnpTUmRleoW6WM6DYYUTvp6aRGwo8+06mNJt5fp3R2W8edtdCLha1z9a3tooNu+1L69N1WLBqX4rzNC4Ko8T6ehrDWFDtBWalbjqQMYAvPacLicQLmeRnjs6gZDTo7QBV3CgFXi3pKnDcQABTs+arND0aOP+Mxy8WP7dqpZUqQl/UIfgBK4r9SwtWwQC2EldZWdOVGX+dL6+ctABelOV70rlLJcd56nSvSj3ameF2rAsz4IuGMQpruCCVsyb8dED5Uq+p94QCIifBn4USuPviK6lFcl7UL4gcx+6NgykwWbUGit4E7p+/d11cMz7KoRH6TaYoe5I6kwzkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpGZ4D4kOXbjY11gED52E3qdRR7ord22Md9fFluP4Sk=;
 b=J+tpkgUCmc3tS1ZEmjNWxGNhhAjbEBP3YIy+pY6iSuKQbtHM8xTATv5HB8FJRY8r8dCPvC42TG+PtJDm10qUoQ/JKfIKRUy61SgDuYtt7yLhZnQQoEl2L94ebDW0R+gRJd//jmRjp3tK9u2v7mbFqm/UXtiJKdXDV8/P1VX77vh1CES2sxdQqNsYNN016pQuO1W6gfliz/us5hRcp23DTDB4RFY5krihgn5IaQI018YxcVA90EQWMNbNR79bEjdhFBOfzwP0KHP7XKWqC/gHhAhZXydQdIy4Gg/vBPFiLfiGj7GlcGnzmtt20hW/FFVGXF1eqCpplBeYkkie6AIRYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpGZ4D4kOXbjY11gED52E3qdRR7ord22Md9fFluP4Sk=;
 b=DjTK0haWTYIr4n/145v8RajRmD3wYMIRMrd1znySIjlBD5ITNSvUOF59i2WIesFFDChCQMpCjrj9U8nuPnS1uuao9J2Sm8cmZlC4YTw5KWXDhZMjsX6zTV3U8P6GphcsPkiDdMEYwLCYy2ie0fU7WFiGev/gFbHwwu9gzmfto7/4NxS3Cov7Ay9Ri0JtwpB1ewne1Fd8tP6qyJYDJ8fmbSGecJyWqX/U1GdvFUWzosD38KVqQDhbZvbcDJHnI+FV4eOz/+Na+2hhpFvUnvDSUzfBQVTd9/SCXgaNJNsq/QAtTYxcsPOw3fx5LSYGd86pkmthF8lB+yvV3+M3DKNvkA==
Received: from MWHPR1601CA0023.namprd16.prod.outlook.com
 (2603:10b6:300:da::33) by CO6PR12MB5457.namprd12.prod.outlook.com
 (2603:10b6:5:355::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 08:50:41 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::7) by MWHPR1601CA0023.outlook.office365.com
 (2603:10b6:300:da::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 25 Feb 2022 08:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 08:50:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 08:50:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 00:50:39 -0800
Received: from sandstorm.attlocal.net (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 00:50:37 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
CC:     <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 4/7] block, bio, fs: initial pin_user_pages_fast() changes
Date:   Fri, 25 Feb 2022 00:50:22 -0800
Message-ID: <20220225085025.3052894-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225085025.3052894-1-jhubbard@nvidia.com>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da1004e2-f5ad-4439-b72a-08d9f83be6ef
X-MS-TrafficTypeDiagnostic: CO6PR12MB5457:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5457662F868ADEBA5EB7E135A83E9@CO6PR12MB5457.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4jpCwG3jip3+F70tpFrej0AYMVbTi05Y0CCyl4iIDdU6RHU2YkQ2PQg8wpVhcjKwI+ScOUWteHJ9f7CSoYle9B5V5DDj6BUV3WdtQ/6UT/aX/X6hevW3vSyjjEf53L34WpDFTQjKTHeBCt5TrApT2X2U7XM4xU5QKdk2kpQp0DVzEEhBEPE+rOpjTfgfGon5jw+BTbUvHD7GG19Z0hnoeboX7PuL7ahOfbqE1REwDyxWIA3lPtp6qnKtWxKi+OND4RTmwoJ3UIvDrJBr3l2u60FickaYm9Cr5p+UOnmE0Dd4iJS+SSL756VGlny8CnAQRiy8YLA2LRRBI46nW1oR/xbLna4//XfSiKAqMtpdEbJQC2Rg6v4o9M8imNCThR2KSwhYxsEqOTHqMitAS5DQKx1MeKY4TrPt0TQ2JM0XqV0WajwzZIYCdbURtJKJHFahlqSW6LOlFExP+AxSVHC8qgwQGwVCuvsdIAQNV5nlOWTB2N5a6IivN8Z4Z/IPICthmba7+BYHIU0yNuWJaAjhfa061WPbX9laqNzjfyvpskrg6I0Q9nt6HzlP+IZGgVrsxGGWv5UsLyBZpnA5wi5TfywqhfzGynxZaDjHRnvLe5/s7wNtHT+dp40wCewwlNsLptVy825VyNWxFhY31+O6LdwErxAv3Rd7XRrmv+MgSvSKXdbSlTNA2cZtrH9gVi4neA6BeGVqk6xUfmv8c3Mdm+BYeBozbCwaUKl/kC7/3s=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6636002)(2616005)(316002)(1076003)(426003)(336012)(186003)(26005)(2906002)(6666004)(107886003)(82310400004)(110136005)(54906003)(83380400001)(36860700001)(4326008)(81166007)(5660300002)(356005)(921005)(36756003)(8936002)(7416002)(40460700003)(8676002)(86362001)(70206006)(70586007)(47076005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:50:40.9458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1004e2-f5ad-4439-b72a-08d9f83be6ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use dio_w_*() wrapper calls, in place of get_user_pages_fast(), get_page()
and put_page().

This sets up core parts of the block, bio, and direct-io subsystems to use
dio_*() wrapper calls.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 block/bio.c          | 18 +++++++++---------
 block/blk-map.c      |  4 ++--
 fs/direct-io.c       | 24 ++++++++++++------------
 fs/iomap/direct-io.c |  2 +-
 lib/iov_iter.c       |  4 ++--
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4679d6539e2d..8541245c53bd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1102,7 +1102,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		dio_w_unpin_user_page(bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1133,7 +1133,7 @@ static void bio_put_pages(struct page **pages, size_t size, size_t off)
 	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
 
 	for (i = 0; i < nr; i++)
-		put_page(pages[i]);
+		dio_w_unpin_user_page(pages[i]);
 }
 
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
@@ -1144,9 +1144,9 @@ static void bio_put_pages(struct page **pages, size_t size, size_t off)
  * @iter: iov iterator describing the region to be mapped
  *
  * Pins pages from *iter and appends them to @bio's bvec array. The
- * pages will have to be released using put_page() when done.
- * For multi-segment *iter, this function only adds pages from the
- * next non-empty segment of the iov iterator.
+ * pages will have to be released using unpin_user_page() when done. For
+ * multi-segment *iter, this function only adds pages from the next non-empty
+ * segment of the iov iterator.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1180,7 +1180,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
 			if (same_page)
-				put_page(page);
+				dio_w_unpin_user_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len))) {
 				bio_put_pages(pages + i, left, offset);
@@ -1237,7 +1237,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 			break;
 		}
 		if (same_page)
-			put_page(page);
+			dio_w_unpin_user_page(page);
 		offset = 0;
 	}
 
@@ -1434,8 +1434,8 @@ void bio_set_pages_dirty(struct bio *bio)
  * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO from
- * here on.  It will run one put_page() against each page and will run one
- * bio_put() against the BIO.
+ * here on.  It will run one unpin_user_page() against each page and will run
+ * one bio_put() against the BIO.
  */
 
 static void bio_dirty_fn(struct work_struct *work);
diff --git a/block/blk-map.c b/block/blk-map.c
index c7f71d83eff1..5f0d04c5dd9d 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -275,7 +275,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
 						     max_sectors, &same_page)) {
 					if (same_page)
-						put_page(page);
+						dio_w_unpin_user_page(page);
 					break;
 				}
 
@@ -289,7 +289,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		 * release the pages we didn't map into the bio, if any
 		 */
 		while (j < npages)
-			put_page(pages[j++]);
+			dio_w_unpin_user_page(pages[j++]);
 		kvfree(pages);
 		/* couldn't stuff something into bio? */
 		if (bytes)
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 7dbbbfef300d..0d7104aa40c3 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -183,7 +183,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 		 */
 		if (dio->page_errors == 0)
 			dio->page_errors = ret;
-		get_page(page);
+		dio_w_pin_user_page(page);
 		dio->pages[0] = page;
 		sdio->head = 0;
 		sdio->tail = 1;
@@ -452,7 +452,7 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 static inline void dio_cleanup(struct dio *dio, struct dio_submit *sdio)
 {
 	while (sdio->head < sdio->tail)
-		put_page(dio->pages[sdio->head++]);
+		dio_w_unpin_user_page(dio->pages[sdio->head++]);
 }
 
 /*
@@ -717,7 +717,7 @@ static inline int dio_bio_add_page(struct dio_submit *sdio)
 		 */
 		if ((sdio->cur_page_len + sdio->cur_page_offset) == PAGE_SIZE)
 			sdio->pages_in_io--;
-		get_page(sdio->cur_page);
+		dio_w_pin_user_page(sdio->cur_page);
 		sdio->final_block_in_bio = sdio->cur_page_block +
 			(sdio->cur_page_len >> sdio->blkbits);
 		ret = 0;
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
+	dio_w_pin_user_page(page);		/* It is in dio */
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
@@ -953,7 +953,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				ret = get_more_blocks(dio, sdio, map_bh);
 				if (ret) {
-					put_page(page);
+					dio_w_unpin_user_page(page);
 					goto out;
 				}
 				if (!buffer_mapped(map_bh))
@@ -998,7 +998,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 
 				/* AKPM: eargh, -ENOTBLK is a hack */
 				if (dio->op == REQ_OP_WRITE) {
-					put_page(page);
+					dio_w_unpin_user_page(page);
 					return -ENOTBLK;
 				}
 
@@ -1011,7 +1011,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 				if (sdio->block_in_file >=
 						i_size_aligned >> blkbits) {
 					/* We hit eof */
-					put_page(page);
+					dio_w_unpin_user_page(page);
 					goto out;
 				}
 				zero_user(page, from, 1 << blkbits);
@@ -1051,7 +1051,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 						  sdio->next_block_for_io,
 						  map_bh);
 			if (ret) {
-				put_page(page);
+				dio_w_unpin_user_page(page);
 				goto out;
 			}
 			sdio->next_block_for_io += this_chunk_blocks;
@@ -1067,7 +1067,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 		}
 
 		/* Drop the ref which was taken in get_user_pages() */
-		put_page(page);
+		dio_w_unpin_user_page(page);
 	}
 out:
 	return ret;
@@ -1289,7 +1289,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		ret2 = dio_send_cur_page(dio, &sdio, &map_bh);
 		if (retval == 0)
 			retval = ret2;
-		put_page(sdio.cur_page);
+		dio_w_unpin_user_page(sdio.cur_page);
 		sdio.cur_page = NULL;
 	}
 	if (sdio.bio)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 67cf9c16f80c..4e818648a1aa 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -192,7 +192,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	get_page(page);
+	dio_w_pin_user_page(page);
 	__bio_add_page(bio, page, len, 0);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..f15a3ef5a481 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1538,7 +1538,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 
 		addr = first_iovec_segment(i, &len, start, maxsize, maxpages);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		res = get_user_pages_fast(addr, n, gup_flags, pages);
+		res = dio_w_pin_user_pages_fast(addr, n, gup_flags, pages);
 		if (unlikely(res <= 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
@@ -1667,7 +1667,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
-		res = get_user_pages_fast(addr, n, gup_flags, p);
+		res = dio_w_pin_user_pages_fast(addr, n, gup_flags, p);
 		if (unlikely(res <= 0)) {
 			kvfree(p);
 			*pages = NULL;
-- 
2.35.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F235A74D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 06:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiHaETQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 00:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiHaES6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:18:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20406AB1A1;
        Tue, 30 Aug 2022 21:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+j+d3FvY66F0aMEl7B+PQ5BZOul1SJb8BLmRimlYmHt8CmZ0y16zxS0FWAEFUSqoF56bRAeVgVdXmbi6YUQD0kwrrtC774h2IHfhFmuzG+Mpz93q81eX6GrPpino4qSXI+FlyXElKuFabxngqjacZpWYBToEHs6yXApwhe9XQEj06v+wP8tB8haglyxiKri7d3AzZDNQYBBqUvmsJNOylPdp6i9e84nBk/ClkZpdAhoKPpihjNg6+IhO95CZAykoyYMl7AbU77hvjxAH9Mswj63m453JzgZmSVfA0m9HU6MRpys2/HyFBSsZX6lPiRJ8XM14eidbTBb74lPChEuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfeJQm0LK+R1tjTZehVFwsPGW1k7GJS7dUu3qTkFBT0=;
 b=Xt5Dz4oHReAJ+fOFynd15laRtaWyFre2FxCC/ZhmpCWYgXJeZUaXMxgwp7A/pc2isdzbpeJMPThBJstUxz0YxMWL5Js4WjsmyWiH8LWCH54cNSfaRGLC7bcMW02SjQ8sU9aXapn5sWBhgWq7c3DSm07Lx0z7jo89HtaP5paif/ZdD4yojtLv7c8IkQvS5KrXa6nOREJH199JBBDPV4ELQO+sQy3utMEJ84necT53NLF+1NNIALggO4bRDZI5OyYOY4LiNWJB1yDl5ww0/yd0ZLb/IArloWKlvQBb9ZW8mQBJ47wsyA4LlLuUGzzbBFq1mIJYeY2opGquGrQa1F4Vww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfeJQm0LK+R1tjTZehVFwsPGW1k7GJS7dUu3qTkFBT0=;
 b=sMviMMM5Pfy6gaKGkXpH6Ov7jbKbP5kJdCn5JCyOyPJye0sJfOneZbGBA5GPr0y2RtuXrZlkeRZ0Eb4kpVKHh6U+prAC1xfGgoLQAtmGokzu6XcgBCb0vg34ShDWGyymhsi1tmv89v+cb3UmxaF5TnfBwbiH06OcHZMi7i7E6DyAiNma0vDfTg+hh/SMlRzZuXe5Qse7cGmiejEGSd2JQsuxzmJ3ds65vV3Z+sbD3uVw8X2n+tGTwwzrDezC2c60pH51zFGyuPGFrMDc71nYscO0rK7I+0Wy2XKvmLNWW5drDrdklY7L/twgVj4+V8xOpON7JOjUicTH5JOZ26rODg==
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Wed, 31 Aug
 2022 04:18:54 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::fa) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 04:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 04:18:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 04:18:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 30 Aug
 2022 21:18:52 -0700
Received: from sandstorm.attlocal.net (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 30 Aug 2022 21:18:51 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 5/7] block, bio, fs: convert most filesystems to pin_user_pages_fast()
Date:   Tue, 30 Aug 2022 21:18:41 -0700
Message-ID: <20220831041843.973026-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831041843.973026-1-jhubbard@nvidia.com>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72f01052-aa3f-4585-c39a-08da8b07ea83
X-MS-TrafficTypeDiagnostic: PH7PR12MB7018:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97zKzFb3Z81LCu3QlMr48Z3zpnlwu6BdgKnKqlo0vY396kq7/YCWh29s9mdSkjgzksQ5g3FLqToxsMHyphHDQh3Q3hvnd0QJqT9Yh47w00r0KnejIJ62OF5EtmK0sDvRUtJGdsxK6iwJfqYHfsZjx7qAfQszauRbmwONF2fpV/jCI59Lw0RbdBvMsdS01/h7LDhuPqfbKR5c4qe+FMJ1OwGFp9syvlji6oCfunqxR97SPvCEJbB+pZ2EojwD2o8aT+FEb4f7cwOsImoknT9sk8Fj0HR86oVfMFB9+pct5z2Ef9KUX684POMOmPbVN9SDNFBk7A56RhLvt8/SvVCqdIFa+X5PkJoWpWlU2t7pgksmFlh5eoypdrN3zvHyarHLM94iPguz68+QklVyXKJOWxTyiik0us28PCq/FbWyRNuKokYyNSgXdnH5zPK89qjrG/r/tK9ZzQUdQhshbTeuw+PKpTd/yJcyU1+/FeVPCFUg0VE9+4JLWXhdND9o2RjOnzsQ483JOmkIIfAHgFSXzmEJpGGIc/XPd8k1SfX6xfLk1qbVML41f5eQvsrZ4aOSF3yzp3RGxapkEViNp+5iUi7n2rKT/RTd9vUXScoYI5CEwV1UX2YOQL1h69FTZq9GEJaBhOaHmV8POOQOEfDONw2Kd7MlI4kfco39vLlqFbFiPn8JEdcIeDkCQxIal0Dm1Oxvw8CdM6sOGwPfz50pYJHY5dnJPLvZx/TSB4ij4mH+S1wtcjlw2eC+D5JtTnWSS9Nza91uhOQ1v4OWsUW+QyBeaYt+FpvoIBmfHMntkmQ=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(8936002)(4326008)(6666004)(7416002)(2616005)(36756003)(82740400003)(356005)(70586007)(40460700003)(30864003)(26005)(5660300002)(82310400005)(40480700001)(8676002)(86362001)(2906002)(107886003)(47076005)(186003)(426003)(336012)(81166007)(1076003)(83380400001)(54906003)(36860700001)(70206006)(316002)(6916009)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:18:54.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f01052-aa3f-4585-c39a-08da8b07ea83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
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


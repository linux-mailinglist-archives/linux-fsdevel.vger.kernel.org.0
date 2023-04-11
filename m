Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569756DDAC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 14:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDKM3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 08:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDKM3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:29:32 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CEB3A97
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 05:29:27 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230411122925euoutp012b1c34a013006af6aa05890c21da004e~U4TIJOVKf0605006050euoutp01_
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 12:29:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230411122925euoutp012b1c34a013006af6aa05890c21da004e~U4TIJOVKf0605006050euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681216165;
        bh=l7peqDnGhiOjw0ljVfPNDYGwu5jQ8i9/ouCQ6iiHQ5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BeGheTcdFlFG0Wy/rnM5V3J1/7UuTP2b7hrT0YCLH3mEZsS66F/accCZV0rybI1ZW
         T6lLMoTjtYTrD8djfrYre+eYhpCFlyPe1R5X7SI9wc4DU7C8vyn7cN8trYygUKURw8
         Wu/0T/zi8O9pfVHfeeQV7kiZfKILmuM+4jXtTnts=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230411122924eucas1p23bed121ab289f68a56408d8d79c0df63~U4TGdJ_6P3227632276eucas1p2o;
        Tue, 11 Apr 2023 12:29:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5A.9A.10014.3A255346; Tue, 11
        Apr 2023 13:29:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230411122923eucas1p1dfc182a2c785eeb362b9d670dfe3ba2f~U4TGDwBJQ1913619136eucas1p1q;
        Tue, 11 Apr 2023 12:29:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230411122923eusmtrp21cfb01c80494ecf51988510dd7078da0~U4TGCeyKw0100601006eusmtrp2n;
        Tue, 11 Apr 2023 12:29:23 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-07-643552a3af96
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7B.58.22108.3A255346; Tue, 11
        Apr 2023 13:29:23 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230411122923eusmtip2e2017259e26006e17d70d3dee3efbbc0~U4TF2Bbap1393113931eusmtip22;
        Tue, 11 Apr 2023 12:29:23 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hubcap@omnibond.com, brauner@kernel.org, martin@omnibond.com,
        willy@infradead.org, hch@lst.de, minchan@kernel.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk,
        akpm@linux-foundation.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        mcgrof@kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 2/3] mpage: split submit_bio and bio end_io handler for
 reads and writes
Date:   Tue, 11 Apr 2023 14:29:19 +0200
Message-Id: <20230411122920.30134-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411122920.30134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0wTZxjmu7veHZ11Z2HxC9Nt1qARMxxxNZ863C+SXcKSGcElIxrs6A3N
        2opXkLpmplOyrUD4tYECna3Oza6YIFXRAg3ya6xIIVpxUKBIVtyAkG1UlvKjdpRjmf89z/c+
        7/s875uPxqV/iOLoY5pcjtcoVDJSTDT+PN/36uUDcuVrj24BZKq/SqK60VISTXfMAtR6/VsM
        Dd1xYOinui4MfTVagiGndztqcboI5Gkykch3NSxCrvowjgbLJgD6ce5PCgV+KKBQc8MlEvWH
        ukVoMWgi35KytYZ7BHvdmsB63Hms3WYkWftsBcX+cn6RYA2VXpJtHjKQ7MLwiIgtuWEDbMD+
        Emv3z2D712SI31ByqmMnOX7HviPiow+r/6FyHAm632ZLMQN4IisENA2Z1+E9N1UIxLSUsQLY
        83gAE8gTAFt8IUIgAQCnFm3LJHqlo+17Oy4UrgDY5bGIBDIJYOflIioyl2QS4BfGlbmxjBdA
        S+ABiBCcGQNw3NtDRUbFMIehI3Qfi2CCiYdPJ++LIljC7IYWX7FIsHsZtra58QiOZvbAOttf
        QNCsg65q/0okfFlz9mbtSiTINEfD74ZGMKE5Bc49rCYFHAOnum9QAt4Aww7zqkYPJwYXV5sL
        ACx11JPCafbCkl5VBOLMNljftEOQvw0v9SwBQbEWDs6sEyKshRWN53DhWQK//lIqqGXQMe9f
        NYXQc8a0ekQW+sqcVBnYVPPMMjXPLFPzv68F4DawnsvTqrM57U4Nl5+oVai1eZrsxKzjajtY
        /ox3n3bP3QbWqb8T2wFGg3YAaVwWKwmmyJVSiVJx6jOOP57J56k4bTt4kSZk6yXbk11ZUiZb
        kct9ynE5HP9fFaOj4wxY/Gbvh1F7ZLqBrq3FtfsyxqqkLSPMTcp4Acv45teZDp1jprZB35B6
        19Oo2z/5e1uB0rxbPsymn64UH7J0JCUXlAXGysnUiQWqeJdVt4WPN2amPZ/63sbcfH+s0bdl
        KfNE2gPbfL45Sd1o7a+ydlYtXUsJudPe1ed03ik+cKuwj67p1RBFZ5Lf96uH5ZWYUxN+LqB7
        c0qVZQg+2nqt66w6pmm6ZeOJ4E7jC7x8PuVj56jK3f/OpM4fdf6j6gHPwEk3kd76SpNpfE3R
        laJw3UKfSx+Vfmj8tCO0q+SD0lHw+SaL3GznW/v15oOfNATTyjfHlU9X7O09+Ji4yJ3akCoj
        tEcVSQk4r1X8C1Rb5vP7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7qLg0xTDO7MU7WYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnXZn5jL9ipVfH4Uz9TA+MX
        pS5GTg4JAROJg4s3MXcxcnEICSxllLg2aQ0TREJC4vbCJkYIW1jiz7UuNoii54wSe29MY+9i
        5OBgE9CSaOxkB4mLCDxjlJi9YQsrSAMzSNGvR7wgtrBAtETD/P1sIDaLgKrEv5eXwGp4BSwl
        FtzrYYVYIC+x/+BZZhCbU8BKYvWqD2CLhYBqLrTPg6oXlDg58wkLxHx5ieats5knMArMQpKa
        hSS1gJFpFaNIamlxbnpusaFecWJucWleul5yfu4mRmAMbzv2c/MOxnmvPuodYmTiYDzEKMHB
        rCTC+8PFNEWINyWxsiq1KD++qDQntfgQoynQ3ROZpUST84FJJK8k3tDMwNTQxMzSwNTSzFhJ
        nNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgcnOzFGrsHqbxTrXK9M7GqY9YZ1e7Pw+9oPj9v+m
        3k2np69VOlqkfkN+zuJlk+vVygSKFX3XRKb7tjW/0J9mcujVt6Z11ytqsh5dy552rFpL/2O9
        aaM7r8fxF9aiCUuSdysXKi8r0qprUXZ8W790L7/Zk4tp4hyntFIXqpx9uHPe9V9/X1XyVK1Z
        WGEUaj2rZLXYjkPH7vO8DWhYmTO1xTn1hNPfHfLXL78L2pG4dKH1kh83L4Z0fg7Nrrit2ua6
        5UXzI1aDvxfYs8MtLYMV3ly/dFj+6VR/V8ZEvlt/WTqqFPh/dal6R7jXrd+WX5Aes/OhXeyH
        v5tWz3lpY5B0U+Dr4snzM/pqzh2Z2hI5s1aJpTgj0VCLuag4EQBqd7ZaagMAAA==
X-CMS-MailID: 20230411122923eucas1p1dfc182a2c785eeb362b9d670dfe3ba2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230411122923eucas1p1dfc182a2c785eeb362b9d670dfe3ba2f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230411122923eucas1p1dfc182a2c785eeb362b9d670dfe3ba2f
References: <20230411122920.30134-1-p.raghav@samsung.com>
        <CGME20230411122923eucas1p1dfc182a2c785eeb362b9d670dfe3ba2f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the submit_bio() and bio end_io handler for reads and writes similar
to other aops.
This is a prep patch before we convert end_io handlers to use folios.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/mpage.c | 54 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 22b9de5ddd68..d9540c1b7427 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -43,23 +43,41 @@
  * status of that page is hard.  See end_buffer_async_read() for the details.
  * There is no point in duplicating all that complexity.
  */
-static void mpage_end_io(struct bio *bio)
+static void mpage_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-		page_endio(page, bio_op(bio),
+	bio_for_each_segment_all(bv, bio, iter_all)
+		page_endio(bv->bv_page, REQ_OP_READ,
 			   blk_status_to_errno(bio->bi_status));
-	}
 
 	bio_put(bio);
 }
 
-static struct bio *mpage_bio_submit(struct bio *bio)
+static void mpage_write_end_io(struct bio *bio)
 {
-	bio->bi_end_io = mpage_end_io;
+	struct bio_vec *bv;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bv, bio, iter_all)
+		page_endio(bv->bv_page, REQ_OP_WRITE,
+			   blk_status_to_errno(bio->bi_status));
+
+	bio_put(bio);
+}
+
+static struct bio *mpage_bio_submit_read(struct bio *bio)
+{
+	bio->bi_end_io = mpage_read_end_io;
+	guard_bio_eod(bio);
+	submit_bio(bio);
+	return NULL;
+}
+
+static struct bio *mpage_bio_submit_write(struct bio *bio)
+{
+	bio->bi_end_io = mpage_write_end_io;
 	guard_bio_eod(bio);
 	submit_bio(bio);
 	return NULL;
@@ -265,7 +283,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	 * This folio will go to BIO.  Do we need to send this BIO off first?
 	 */
 	if (args->bio && (args->last_block_in_bio != blocks[0] - 1))
-		args->bio = mpage_bio_submit(args->bio);
+		args->bio = mpage_bio_submit_read(args->bio);
 
 alloc_new:
 	if (args->bio == NULL) {
@@ -278,7 +296,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 	length = first_hole << blkbits;
 	if (!bio_add_folio(args->bio, folio, length, 0)) {
-		args->bio = mpage_bio_submit(args->bio);
+		args->bio = mpage_bio_submit_read(args->bio);
 		goto alloc_new;
 	}
 
@@ -286,7 +304,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	nblocks = map_bh->b_size >> blkbits;
 	if ((buffer_boundary(map_bh) && relative_block == nblocks) ||
 	    (first_hole != blocks_per_page))
-		args->bio = mpage_bio_submit(args->bio);
+		args->bio = mpage_bio_submit_read(args->bio);
 	else
 		args->last_block_in_bio = blocks[blocks_per_page - 1];
 out:
@@ -294,7 +312,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 confused:
 	if (args->bio)
-		args->bio = mpage_bio_submit(args->bio);
+		args->bio = mpage_bio_submit_read(args->bio);
 	if (!folio_test_uptodate(folio))
 		block_read_full_folio(folio, args->get_block);
 	else
@@ -356,7 +374,7 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 		args.bio = do_mpage_readpage(&args);
 	}
 	if (args.bio)
-		mpage_bio_submit(args.bio);
+		mpage_bio_submit_read(args.bio);
 }
 EXPORT_SYMBOL(mpage_readahead);
 
@@ -373,7 +391,7 @@ int mpage_read_folio(struct folio *folio, get_block_t get_block)
 
 	args.bio = do_mpage_readpage(&args);
 	if (args.bio)
-		mpage_bio_submit(args.bio);
+		mpage_bio_submit_read(args.bio);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_read_folio);
@@ -577,7 +595,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
 	if (bio && mpd->last_block_in_bio != blocks[0] - 1)
-		bio = mpage_bio_submit(bio);
+		bio = mpage_bio_submit_write(bio);
 
 alloc_new:
 	if (bio == NULL) {
@@ -596,7 +614,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	wbc_account_cgroup_owner(wbc, &folio->page, folio_size(folio));
 	length = first_unmapped << blkbits;
 	if (!bio_add_folio(bio, folio, length, 0)) {
-		bio = mpage_bio_submit(bio);
+		bio = mpage_bio_submit_write(bio);
 		goto alloc_new;
 	}
 
@@ -606,7 +624,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	folio_start_writeback(folio);
 	folio_unlock(folio);
 	if (boundary || (first_unmapped != blocks_per_page)) {
-		bio = mpage_bio_submit(bio);
+		bio = mpage_bio_submit_write(bio);
 		if (boundary_block) {
 			write_boundary_block(boundary_bdev,
 					boundary_block, 1 << blkbits);
@@ -618,7 +636,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 
 confused:
 	if (bio)
-		bio = mpage_bio_submit(bio);
+		bio = mpage_bio_submit_write(bio);
 
 	/*
 	 * The caller has a ref on the inode, so *mapping is stable
@@ -652,7 +670,7 @@ mpage_writepages(struct address_space *mapping,
 	blk_start_plug(&plug);
 	ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
 	if (mpd.bio)
-		mpage_bio_submit(mpd.bio);
+		mpage_bio_submit_write(mpd.bio);
 	blk_finish_plug(&plug);
 	return ret;
 }
-- 
2.34.1


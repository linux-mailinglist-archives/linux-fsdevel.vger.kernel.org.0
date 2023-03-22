Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13F6C4C5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 14:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCVNuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCVNup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:50:45 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7B637E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 06:50:22 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230322135017euoutp02fc54f8a8c60ce0a91e5ea4c1198af102~OwgBeOZTA1714617146euoutp026
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 13:50:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230322135017euoutp02fc54f8a8c60ce0a91e5ea4c1198af102~OwgBeOZTA1714617146euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679493017;
        bh=ayJOnQy0cJGhVp2X4oA4O9yHIEvSlM4NjOeswQrRlbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxLxuMv8Fbh+flqd2wfT4DFjYUWiYF+pAGZG9jq1MkD34NB7EFUWc69IwJhVM8BCY
         Cije3dHiyaTah0viBkegX6iXobpP9SoDCR/sAOgdWL3qRZkb2osNgxPr76u1Cm7yv5
         upYfW+rPBqS1isBzkPhwoeVQo9mPdo3Cv7ETQCjA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230322135016eucas1p25117e603c54a51fa479f59756c985bea~Owf-8x0Je2739227392eucas1p2l;
        Wed, 22 Mar 2023 13:50:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7E.84.09503.8970B146; Wed, 22
        Mar 2023 13:50:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230322135015eucas1p1bd186e83b322213cc852c4ad6eb47090~Owf-hW9Mr1936419364eucas1p1R;
        Wed, 22 Mar 2023 13:50:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230322135015eusmtrp27e8edde4a243950d6e8a8590cf408615~Owf-ghEWR0726007260eusmtrp2D;
        Wed, 22 Mar 2023 13:50:15 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-e0-641b0798d498
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 99.6E.09583.7970B146; Wed, 22
        Mar 2023 13:50:15 +0000 (GMT)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230322135015eusmtip26a172e30dde79a8b20bac498b7926a53~Owf-T0JHc1265312653eusmtip2f;
        Wed, 22 Mar 2023 13:50:15 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        willy@infradead.org, brauner@kernel.org, akpm@linux-foundation.org,
        minchan@kernel.org, hubcap@omnibond.com, martin@omnibond.com
Cc:     mcgrof@kernel.org, devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 1/5] zram: remove zram_page_end_io function
Date:   Wed, 22 Mar 2023 14:50:09 +0100
Message-Id: <20230322135013.197076-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322135013.197076-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djPc7oz2KVTDCZt57GYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjuKySUnNySxLLdK3S+DKOLrzD2vBFq6K
        P5cMGxjPcHQxcnBICJhITD4u3MXIxSEksIJR4tq9X0wQzhdGic9HrjBCOJ8ZJY6+uMrSxcgJ
        1vF30kJmiMRyRokZb59CVb1klFh3fjsryFw2AS2Jxk52kLiIwBlGiSlNMxhBupkF7jNKnN4L
        NklYwEZi17OJ7CA2i4CqxNb2p2BxXgEriYd/u9ghtslL7D94lhnE5hSwlni0aBobRI2gxMmZ
        T1ggZspLNG+dzQxRv5pT4vJPNwjbRaKj4zMrhC0s8er4FqiZMhL/d85ngrCrJZ7e+A32jYRA
        C6NE/871bJCAsZboO5MDYjILaEqs36UPEXWU2LpSB8Lkk7jxVhDiAD6JSdumM0OEeSU62oQg
        ZitJ7Pz5BGqnhMTlpjlA97ID2R4SnaoTGBVnIXlkFpJHZiEsXcDIvIpRPLW0ODc9tdgwL7Vc
        rzgxt7g0L10vOT93EyMw8Z3+d/zTDsa5rz7qHWJk4mA8xCjBwawkwuvGLJEixJuSWFmVWpQf
        X1Sak1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1OqgSl22rPgSSeD3h7RYztWIX9b
        Ldg4pton7aa7foLH1LxbHassXMNSm1vncBqICRXy7rpcGrXxwoz/s3xXNz9ZktKse31+2P+7
        fDaJa83S0xYzCK7UmvL+nWS+xqHIt/Yflqtc++4afUGRa33qa76Vay3Wxx8I3vBFXHF+pI7f
        hg+nPrQf1F19bPOrp9c8FyV5Pg+fe2y9fuqjjIuzfTpevUtdN9nwyokHO6qn//mSwnH5Aad8
        9yyLf5L3Dizl7+Yo/teot6X9weGnBfbz1qa6T32oyO6nZzNzA9sqSfaM9Wmb/P9sy3Vd+n3N
        MbkJFuvdpgQcer3y98E1h9ojeyaUJLSGveITrsgLjTL8Vp2508RGiaU4I9FQi7moOBEAWm4G
        0OsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7rT2aVTDNr3alvMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBbtd/uYLPbe0rbYs/cki8XlXXPYLO6t+c9qcXL9f2aLGxOeMlos
        +/qe3eLz0hZ2i90bF7FZnP97nNXi9485bA6CHrMbLrJ4bF6h5XH5bKnHplWdbB6bPk1i9zgx
        4zeLR8PUW2wev27fYfXo27KK0ePzJjmPTU/eMgVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlro
        GZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlHN35h7VgC1fFn0uGDYxnOLoYOTkkBEwk/k5a
        yNzFyMUhJLCUUeLhtU2MEAkJidsLm6BsYYk/17rYIIqeM0o8W3WGtYuRg4NNQEuisZMdpEZE
        4AajRPsqPZAaZpCay09nM4MkhAVsJHY9mwhWxCKgKrG1/SkLiM0rYCXx8G8XO8QCeYn9B8+C
        1XMKWEs8WjSNDcQWAqq5vH8SK0S9oMTJmU/AepmB6pu3zmaewCgwC0lqFpLUAkamVYwiqaXF
        uem5xUZ6xYm5xaV56XrJ+bmbGIHRuu3Yzy07GFe++qh3iJGJg/EQowQHs5IIrxuzRIoQb0pi
        ZVVqUX58UWlOavEhRlOguycyS4km5wPTRV5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6Yklq
        dmpqQWoRTB8TB6dUAxPbn39uX3UDP0/cNsl0f2OOVGjumYzJU78I87p8dtJd/ufstAPqPTP6
        WWU948/0THqW+1TZeMeFJW8t7wdELhS+wFOo2m+64ax2lC/HZ+EA9uBpT/bUrfrtaH3rRswP
        h63i7zZqG2S1il3Zddwtz+XZ9+mH98Y5/Jhx/ZXBlLqorbVxUwtMHoXd1P4VZBsRI3v0pxXL
        4xTW+K5F53gCs+Y0BH/4vWDvGRnGukuP+A/s4lplmSEt7S+kEjG1Lfa8+Y2T6SyzOMSEF65d
        uOBbi+eBmqq5rT5GefqHZ80K79i469bZ+0r/uS/4nr9z4JbH7xSB6z+Tf1lMqr2z38zsK6Pc
        81/r9khvuio35/rLAt1LSizFGYmGWsxFxYkAUAi+E18DAAA=
X-CMS-MailID: 20230322135015eucas1p1bd186e83b322213cc852c4ad6eb47090
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230322135015eucas1p1bd186e83b322213cc852c4ad6eb47090
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135015eucas1p1bd186e83b322213cc852c4ad6eb47090
References: <20230322135013.197076-1-p.raghav@samsung.com>
        <CGME20230322135015eucas1p1bd186e83b322213cc852c4ad6eb47090@eucas1p1.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zram_page_end_io function is called when alloc_page is used (for
partial IO) to trigger writeback from the user space. The pages used for
this operation is never locked or have the writeback set. So, it is safe
to remove zram_page_end_io function that unlocks or marks writeback end
on the page.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/zram/zram_drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b7bb52f8dfbd..2341f4009b0f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -606,15 +606,6 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 	atomic64_dec(&zram->stats.bd_count);
 }
 
-static void zram_page_end_io(struct bio *bio)
-{
-	struct page *page = bio_first_page_all(bio);
-
-	page_endio(page, op_is_write(bio_op(bio)),
-			blk_status_to_errno(bio->bi_status));
-	bio_put(bio);
-}
-
 /*
  * Returns 1 if the submission is successful.
  */
@@ -634,9 +625,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 		return -EIO;
 	}
 
-	if (!parent)
-		bio->bi_end_io = zram_page_end_io;
-	else
+	if (parent)
 		bio_chain(bio, parent);
 
 	submit_bio(bio);
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CCB6D4585
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjDCNWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjDCNWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:22:30 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225C455BC
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 06:22:27 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230403132225euoutp02cc4b61be594d53f234d8027e9e78743d~Sb3HpNHWk1374213742euoutp02l
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 13:22:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230403132225euoutp02cc4b61be594d53f234d8027e9e78743d~Sb3HpNHWk1374213742euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680528146;
        bh=r3yJCwvgy++or0tEjkGksO6JgkEF47Bw1cuUMKfgKoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWltD6KkZIQiLs6rw7FKqP0kHRAAW0lYwBmUNzefo4Vc5oXK4N7RNkDQibfTOfl7Z
         I/0o0jF3ciGeBau/sXEVvO9q6x1elNyuG0Iaer1trBR7e4ZITxAThf1z4eDtnOkLRn
         8miNtIU3MXpzqC/SC9TgDLLQvc94kF8B/bkHURvA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230403132224eucas1p27eef4cb0f80d1f84327e722cb3e4bc85~Sb3GIBA7H2688526885eucas1p2U;
        Mon,  3 Apr 2023 13:22:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CA.F2.09966.013DA246; Mon,  3
        Apr 2023 14:22:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f~Sb3FmBsJj2689126891eucas1p2k;
        Mon,  3 Apr 2023 13:22:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230403132223eusmtrp210c81c0bd1e7b9dfa5cc043be99aaf05~Sb3FlI5ir0199801998eusmtrp2f;
        Mon,  3 Apr 2023 13:22:23 +0000 (GMT)
X-AuditID: cbfec7f4-d4fff700000026ee-44-642ad3104b1c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.16.08862.F03DA246; Mon,  3
        Apr 2023 14:22:23 +0100 (BST)
Received: from localhost (unknown [106.210.248.30]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230403132223eusmtip1f594e7a855855fa3ec15e1be498a2f26~Sb3FXqusJ2519425194eusmtip1C;
        Mon,  3 Apr 2023 13:22:23 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, minchan@kernel.org, martin@omnibond.com,
        hubcap@omnibond.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de
Cc:     devel@lists.orangefs.org, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 1/5] zram: always chain bio to the parent in
 read_from_bdev_async
Date:   Mon,  3 Apr 2023 15:22:17 +0200
Message-Id: <20230403132221.94921-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403132221.94921-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djP87oCl7VSDJa8FrKYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRXDYpqTmZZalF+nYJ
        XBmTXn5kKdjNWzGzZQtrA+Mk7i5GTg4JAROJ3guTGEFsIYEVjBJff9d2MXIB2V8YJc7N+MwI
        4XxmlJj9YzMrTMfXKUuYIRLLGSVeHf7OBuG8YJTYtekTkMPBwSagJdHYyQ4SFxG4xSjxpmc2
        E4jDLHCfUWLe7r1MIKOEBcIk9hzdzgJiswioSqzcc5AZpJlXwFLi7Q1TiG3yEvsPnmUGsTkF
        rCQap88Fu5VXQFDi5MwnYK3MQDXNW2eDXSQhsJ9TovncZWaIZheJ7+fWMkHYwhKvjm9hh7Bl
        JP7vnA8Vr5Z4euM3VHMLo0T/zvVgH0gIWEv0nckBMZkFNCXW79KHiDpKrNxuAWHySdx4Kwhx
        AZ/EpG3TmSHCvBIdbUIQs5Ukdv58ArVTQuJy0xwWCNtDYueqHuYJjIqzkPwyC8kvsxDWLmBk
        XsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYFE//O/5lB+PyVx/1DjEycTAeYpTgYFYS
        4VXt0koR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqttezJZSCA9sSQ1OzW1ILUIJsvEwSnVwLSN
        tyyKR2MSu8wEf+4r6+52nRd5WfAz5KN0SWjJs6j2CUVyB8Vd5V6tq3ve+H83d/GkOJbs09b/
        Mln9Zl8wsY1uUbXXmpta8cBzwxu96ykfSwL/indy+t7telJxQuHePi6nGv6wly8/WanevfTp
        V02dxor1Cv/rOysOyRzQXOtffMYmXqtpk6inqI7b637uO9fcWHf/m3skhXOvSXOxY/DchjJe
        nSN1qlx1LTO3bj5d8720PLY19MVhlVsl4ha71Xgn/OjOTZy4cpoWx9olEhf/fvxircXTuOtQ
        aHKLY/rW1dt2lvh6Tj5SrhIhG/JzqdyLO/c1lhrwb7x/RkN38Qk+3m2bKw/x8vbVtgfnK7EU
        ZyQaajEXFScCAAdAxD/5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7r8l7VSDG4/1baYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmTXn5kKdjNWzGzZQtrA+Mk
        7i5GTg4JAROJr1OWMHcxcnEICSxllOj9/p8JIiEhcXthEyOELSzx51oXG0TRM0aJv+efsnYx
        cnCwCWhJNHayg8RFQOLLLhxnAXGYBZ4zSqyZ8psZpFtYIERi7eZDbCA2i4CqxMo9B5lBmnkF
        LCXe3jCFWCAvsf/gWbByTgEricbpc8EWCwGVfL14ixXE5hUQlDg58wkLiM0MVN+8dTbzBEaB
        WUhSs5CkFjAyrWIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM4W3Hfm7ewTjv1Ue9Q4xMHIyH
        GCU4mJVEeFW7tFKEeFMSK6tSi/Lji0pzUosPMZoCnT2RWUo0OR+YRPJK4g3NDEwNTcwsDUwt
        zYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpj6bNMVbC+WRxj7Lbgs83CpTrNKVGXel5uu
        m59kHZrMHs71ecXPc+GXpe83vX7z/Y2a9WTu9Qbb+rcx7nM7K/3H5FlOz5E11yelSnw3War1
        57KmHPPBJ8ozez9tePon5KPl4tUSN2pKNfM7f367kdMcMXGflfCCndtzVF/EaUlY3963IWdr
        Ne+TP4LeYrt/8qlcFOWa1s6bvTXqeo5wvdSjTU86tfYI7q7qV53NeDmE58B+MdspfD6Jt2ds
        fPopP2/5+SW3p3CIWzyRvvpE/NnV2Mb7l6KOb2pbc5DD1GeJ38qXb4280hesCtvzKtNPm+ma
        mFZJs0pm4d39L3dXz363NH3/4R0ywe7ZPHoPfTl+KrEUZyQaajEXFScCAJm7B9lqAwAA
X-CMS-MailID: 20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f
References: <20230403132221.94921-1-p.raghav@samsung.com>
        <CGME20230403132223eucas1p2a27e8239b8bda4fc16b675a9473fd61f@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zram_bvec_read() is called with the bio set to NULL only in
writeback_store() function. When a writeback is triggered,
zram_bvec_read() is called only if ZRAM_WB flag is not set. That will
result only calling zram_read_from_zspool() in __zram_bvec_read().

rw_page callback used to call read_from_bdev_async with a NULL parent
bio but that has been removed since commit 3222d8c2a7f8
("block: remove ->rw_page").

We can now safely always call bio_chain() as read_from_bdev_async() will
be called with a parent bio set. A WARN_ON_ONCE is added if this function
is called with parent set to NULL.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/zram/zram_drv.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3feadfb96114..d16d0630b178 100644
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
@@ -634,11 +625,10 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 		return -EIO;
 	}
 
-	if (!parent)
-		bio->bi_end_io = zram_page_end_io;
-	else
-		bio_chain(bio, parent);
+	if (WARN_ON_ONCE(!parent))
+		return -EINVAL;
 
+	bio_chain(bio, parent);
 	submit_bio(bio);
 	return 1;
 }
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702C56CBD89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjC1L11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC1L1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:27:25 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48DAAB
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 04:27:22 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230328112720euoutp01d145f4467fbac74c2558575fa4cda16f~Qka66gzTP0345803458euoutp019
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:27:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230328112720euoutp01d145f4467fbac74c2558575fa4cda16f~Qka66gzTP0345803458euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680002840;
        bh=V4uAY23rx6LbYgOeA+xAE8iXiLJZoHXfAuLkczsvSEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g693ybURzQsLeFqRIYnYKiIo8yQ5CSmuybp+IfxL5pizPUyGj5Xjvcc47ckjr6oE+
         EZp90lFWAUo/dtTnIQq4K++4Nw8sJMVdCasU2R8ZIatq3y1Sdasl5IXoX/tb3BhFNt
         2fdzj4sATJg3SRSu4rcTvDpIZF19GYjbawOxHtBY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230328112718eucas1p2a740048df8ba642e0aa035d009115284~Qka5NmZGW2759927599eucas1p28;
        Tue, 28 Mar 2023 11:27:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 34.51.09503.61FC2246; Tue, 28
        Mar 2023 12:27:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1~Qka44T5zZ0111901119eucas1p2j;
        Tue, 28 Mar 2023 11:27:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230328112718eusmtrp16f41b0a32e8b05be0788a2ac4a06450a~Qka43kbO80876308763eusmtrp1S;
        Tue, 28 Mar 2023 11:27:18 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-78-6422cf16dae4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FD.19.08862.61FC2246; Tue, 28
        Mar 2023 12:27:18 +0100 (BST)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230328112718eusmtip24e9e179b1b56e4e1504088728ba93515~Qka4o8oxA2590125901eusmtip29;
        Tue, 28 Mar 2023 11:27:18 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     martin@omnibond.com, axboe@kernel.dk, minchan@kernel.org,
        akpm@linux-foundation.org, hubcap@omnibond.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/5] zram: remove the call to page_endio in the bio end_io
 handler
Date:   Tue, 28 Mar 2023 13:27:12 +0200
Message-Id: <20230328112716.50120-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328112716.50120-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87pi55VSDO5u0bWYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjuKySUnNySxLLdK3S+DKWHXlNkvBae6K
        x1MdGhjPcXYxcnJICJhIfFm2j72LkYtDSGAFo8SkB+vYIJwvjBKnts9ngXA+M0p86m1nhmk5
        ++EOVMtyRompb5ZDOS8ZJe43ngLq5+BgE9CSaOwEi4sInGGUWLy8EWwus8B9RolvL88zgYwS
        FgiRmPNyKSuIzSKgKvF/wxl2EJtXwFLi5uZdrBDr5CX2HzzLDDKUU8BKYtpvK4gSQYmTM5+w
        gNjMQCXNW2czg8yXEFjPKfHi4CdGiF4XiQdTf7BB2MISr45vYYewZSROT+5hgbCrJZ7e+A3V
        3MIo0b9zPdgHEgLWEn1nckBMZgFNifW79CHKHSUeb9/JClHBJ3HjrSDECXwSk7ZNZ4YI80p0
        tAlBVCtJ7Pz5BGqphMTlpjlQSz0kut6+Zp3AqDgLyTOzkDwzC2HvAkbmVYziqaXFuempxYZ5
        qeV6xYm5xaV56XrJ+bmbGIEp8PS/4592MM599VHvECMTB+MhRgkOZiUR3s3eiilCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamDLuB69miqjWil/8L32T
        YtEtqegLFncjF282WcVzwCV+x/SChPVvL7DV7WLcV9Sp0/ufn0P9xeQA261GCmJbc/QmBvnx
        5jw4ybLS7rRwgO1s7jXPra84TGoRqJXJtVJv5P6uec3fKZUj6D3/wz3XHoezKt+5lPpTIlY6
        VzIhLvsew6TG7nvKLtfNzofr8Uyr6G78U9U5MX+OpqvNCb/9f11qVcyZeTJ4vljVn/y8dNGX
        kguMZtVdrXGbw0MPmhzKlYx8O33b/38NXSXPpTf+KZ78S+bHiUleDM6iUsIiu952xL17p+nY
        2SIYyjgz5fu+vTxaL1jehMb1p016co8lU/CJnKVHXOkF6wPvH15RYinOSDTUYi4qTgQAxT+M
        ovADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7pi55VSDG5/ErGYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjtKzKcovLUlVyMgvLrFVija0MNIztLTQ
        MzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWHXlNkvBae6Kx1MdGhjPcXYxcnJICJhInP1w
        h72LkYtDSGApo8TnA6+ZIRISErcXNjFC2MISf651sUEUPWeUmN/+Hcjh4GAT0JJo7ARrFhG4
        wSix9ukvVhCHGaTo7r7XrCDdwgJBEuc+LQezWQRUJf5vOMMOYvMKWErc3LyLFWKDvMT+g2eZ
        QYZyClhJTPttBRIWAiq5euY9I0S5oMTJmU9YQGxmoPLmrbOZJzAKzEKSmoUktYCRaRWjSGpp
        cW56brGhXnFibnFpXrpecn7uJkZgtG479nPzDsZ5rz7qHWJk4mA8xCjBwawkwrvZWzFFiDcl
        sbIqtSg/vqg0J7X4EKMp0NkTmaVEk/OB6SKvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEk
        NTs1tSC1CKaPiYNTqoHJRfDAQtvep+LeO8qrU7//Z11v5VD4/Offx9Yb3X4ffHM6/qpwX0LV
        oQttD8xeebE1fPH7mcw87bx6RM+fWqb/LTH/5vAwyW74ql2xUNRb5Kqo17IXs/TtzTZd63uc
        2ceyL0w4rLJZ3FpANqD64M3Le754C577/Ssp5pdt4s5gy8Alxi5HvS4aGpwM59m6Z/Op21r1
        U1Q5ZGar5yhFc3TevFay6uzKpk/LAnf/mdb4YsG3uJ+d++63WWw4dHbTy8Jb03f/nSlgVLb/
        bOyPE7NXXngvMe26p7qF6Z7bm9VK+M8u7HMW55+26N6xuVfyfV8dfXHzRitftIak7Sv+BbfZ
        p8W33VtwetuJC7v6jyy5E6fEUpyRaKjFXFScCADMRL1hXwMAAA==
X-CMS-MailID: 20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1
References: <20230328112716.50120-1-p.raghav@samsung.com>
        <CGME20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zram_page_end_io function is called when alloc_page is used (for
partial IO) to trigger writeback from the user space. The pages used for
this operation is never locked or have the writeback set. So, it is safe
to remove the call to page_endio() function that unlocks or marks
writeback end on the page.

Rename the endio handler from zram_page_end_io to zram_read_end_io as
the call to page_endio() is removed and to associate the callback to the
operation it is used in.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/zram/zram_drv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b7bb52f8dfbd..3300e7eda2f6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -606,12 +606,8 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 	atomic64_dec(&zram->stats.bd_count);
 }
 
-static void zram_page_end_io(struct bio *bio)
+static void zram_read_end_io(struct bio *bio)
 {
-	struct page *page = bio_first_page_all(bio);
-
-	page_endio(page, op_is_write(bio_op(bio)),
-			blk_status_to_errno(bio->bi_status));
 	bio_put(bio);
 }
 
@@ -635,7 +631,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 	}
 
 	if (!parent)
-		bio->bi_end_io = zram_page_end_io;
+		bio->bi_end_io = zram_read_end_io;
 	else
 		bio_chain(bio, parent);
 
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C156C4C66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 14:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjCVNvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCVNvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:51:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD075A6E7
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 06:50:46 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230322135019euoutp01d31ee6d55f265cc11c4b4828d89c30d5~OwgDPZm1v1804518045euoutp01i
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 13:50:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230322135019euoutp01d31ee6d55f265cc11c4b4828d89c30d5~OwgDPZm1v1804518045euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679493019;
        bh=5/+0KaEbpjyZkaLqtYLBQz1+pPqkvr1OOiQOg6+VTQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsCW33O+y//g7yZSiWUmZFyW1iX5GhKRBk/wos093lNoKU7oN+ONmCmnW6Yfy3C2X
         w4SFKZ0FUJuYgM2ehVYaW1z8F/NEdAnEOIalrhVrkD8U6hCCLUL7Fayj14BIqgLNZv
         rHkzlVEMDZRKXe5G0KSZmc0i7oBQOasfkP8+SNDA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230322135017eucas1p2629dcfb1875f78654e25001786cb234f~OwgBPtNpR2731127311eucas1p2j;
        Wed, 22 Mar 2023 13:50:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 91.38.10014.9970B146; Wed, 22
        Mar 2023 13:50:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230322135017eucas1p1350c6e130fa367263432fa35894bdf1e~OwgAwlFQT1542115421eucas1p1C;
        Wed, 22 Mar 2023 13:50:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230322135017eusmtrp271a5c4fe6e5c76bbc457c0ee9d299624~OwgAvzLhg0726007260eusmtrp2I;
        Wed, 22 Mar 2023 13:50:17 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-14-641b079936f1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9B.6E.09583.9970B146; Wed, 22
        Mar 2023 13:50:17 +0000 (GMT)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230322135016eusmtip2064511fdb3f41a6d5ea559782138fbae~OwgAjsse92536025360eusmtip2u;
        Wed, 22 Mar 2023 13:50:16 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        willy@infradead.org, brauner@kernel.org, akpm@linux-foundation.org,
        minchan@kernel.org, hubcap@omnibond.com, martin@omnibond.com
Cc:     mcgrof@kernel.org, devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFC v2 3/5] mpage: split bi_end_io callback for reads and writes
Date:   Wed, 22 Mar 2023 14:50:11 +0100
Message-Id: <20230322135013.197076-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322135013.197076-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djPc7oz2aVTDBquKFrMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBYrVx9lsmi/28dksfeWtsWevSdZLC7vmsNmcW/Nf1aLk+v/M1vc
        mPCU0WLZ1/fsFp+XtrBb7N64iM3i/N/jrBa/f8xhcxDymN1wkcVj8wotj8tnSz02repk89j0
        aRK7x4kZv1k8GqbeYvPYfbOBzePX7TusHn1bVjF6fN4k57HpyVumAJ4oLpuU1JzMstQifbsE
        roxVG/wL/vFU/F3n28B4jKuLkZNDQsBE4uqnRrYuRi4OIYEVjBJPXj9jgXC+MEp8OPuFHcL5
        zCixrPEVG0zL6z2ToVqWM0rcPfIMynnJKPH17HzGLkYODjYBLYnGTrBuEYEzjBJTmmYwgjjM
        Av8ZJXoPLwQbJSzgJbFs+gcmEJtFQFXi6OOdzCA2r4CVxJGHE5kh1slL7D94FszmFLCWeLRo
        GhtEjaDEyZlPWEBsZqCa5q2zmUEWSAjs5pTYee0YM8gVEgIuEg0dxhBzhCVeHd/CDmHLSPzf
        OZ8Jwq6WeHrjN1RvC6NE/871bBC91hJ9Z3JATGYBTYn1u/Qhyh0lnkxqhZrOJ3HjrSDEBXwS
        k7ZNhwrzSnS0CUFUK0ns/PkEaqmExOWmOSwQtofE0Zet7BMYFWch+WUWkl9mIexdwMi8ilE8
        tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzApnv53/OsOxhWvPuodYmTiYDzEKMHBrCTC68Ys
        kSLEm5JYWZValB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qBacq06uq4
        wmNxqi+OpEXbeJ8w2363geH/Amndq6Zf3+n53pqTfDbirozYO+5//eZX67+d2VuUqCo94YbK
        skie5cVvy2b1sUwou/P/dckTLaNLXFyThCbUvsmdvccnZF/YOeuJ94K+HnL6HTZXvlfgalXx
        1JpH/68JbFo1jWnW9eX1N7n8tNe1qk1+FGbka9N2OcFsMWuF05vsnvK5hzpXZPt+2rP+9L3X
        jT/2b5WN2uC5xtVf5OXGjZ/NBbatdFq7/tETibbs+Rd89PumawqusFWKmxdeUavOe/1cPMuW
        GSsNo/c3T1pxWNn8Pnfq56RNzdlemrZPdh8LXW55MDpoQvIaOdfIWR9U32a5s5nN9VNiKc5I
        NNRiLipOBACnmJFN+QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7oz2aVTDGb+Y7aYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmrNvgX/OOp+LvOt4HxGFcX
        IyeHhICJxOs9k9m6GLk4hASWMkp09B1mhkhISNxe2MQIYQtL/LnWBVX0nFFiy6lf7F2MHBxs
        AloSjZ3sIDUiAjcYJdpX6YHUMAt0Mkmc+DITLCEs4CWxbPoHJhCbRUBV4ujjnWALeAWsJI48
        nAi1TF5i/8GzYDangLXEo0XT2EBsIaCay/snsULUC0qcnPmEBcRmBqpv3jqbeQKjwCwkqVlI
        UgsYmVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExu+2Yz+37GBc+eqj3iFGJg7GQ4wSHMxK
        IrxuzBIpQrwpiZVVqUX58UWlOanFhxhNge6eyCwlmpwPTCB5JfGGZgamhiZmlgamlmbGSuK8
        ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M7Yfd/v7W55q/vP501as9vL2nzL9smMe87eXj/TlH
        E092Ppn8mDPq3cIlj61CVaun8R0yENb9Unfmvv7ve8G8PGUSh4XOu9pELJA+63j3Zp9K3I1e
        R7vS+06njteVdj4I5zrz+8sHH++r8659C57/RbKsoax2q/QP7SfGL5aevZbAvY/v7PGj/y0X
        lVtW9rFmc+zx8p3W//jy/G8REn5r1YPu/t2nJWzod0Er5lNmxfT7LN5XpmUExq99sWpBaP+m
        bSePShycV7y+/vqvTXbX9s/S+Rf78/vjlydOmbC5swWbTJ1rOOuV1o1L6hWvvJfe1ZRofDz5
        HPts6fjy//6se7W6788NeFTz2rimMt0nvlGJpTgj0VCLuag4EQD9lYbvaAMAAA==
X-CMS-MailID: 20230322135017eucas1p1350c6e130fa367263432fa35894bdf1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230322135017eucas1p1350c6e130fa367263432fa35894bdf1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135017eucas1p1350c6e130fa367263432fa35894bdf1e
References: <20230322135013.197076-1-p.raghav@samsung.com>
        <CGME20230322135017eucas1p1350c6e130fa367263432fa35894bdf1e@eucas1p1.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the bi_end_io handler for reads and writes similar to other aops.
This is a prep patch before we convert end_io handlers to use folios.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/mpage.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 22b9de5ddd68..3a545bf0f184 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -43,14 +43,28 @@
  * status of that page is hard.  See end_buffer_async_read() for the details.
  * There is no point in duplicating all that complexity.
  */
-static void mpage_end_io(struct bio *bio)
+static void mpage_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
 		struct page *page = bv->bv_page;
-		page_endio(page, bio_op(bio),
+		page_endio(page, REQ_OP_READ,
+			   blk_status_to_errno(bio->bi_status));
+	}
+
+	bio_put(bio);
+}
+
+static void mpage_write_end_io(struct bio *bio)
+{
+	struct bio_vec *bv;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bv, bio, iter_all) {
+		struct page *page = bv->bv_page;
+		page_endio(page, REQ_OP_WRITE,
 			   blk_status_to_errno(bio->bi_status));
 	}
 
@@ -59,7 +73,11 @@ static void mpage_end_io(struct bio *bio)
 
 static struct bio *mpage_bio_submit(struct bio *bio)
 {
-	bio->bi_end_io = mpage_end_io;
+	if (op_is_write(bio_op(bio)))
+		bio->bi_end_io = mpage_write_end_io;
+	else
+		bio->bi_end_io = mpage_read_end_io;
+
 	guard_bio_eod(bio);
 	submit_bio(bio);
 	return NULL;
-- 
2.34.1


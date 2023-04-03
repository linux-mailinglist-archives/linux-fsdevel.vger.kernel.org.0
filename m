Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8456D4593
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 15:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjDCNWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 09:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjDCNWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:22:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0E955BC
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 06:22:31 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230403132227euoutp025754d395ae13df8f14406d682b822425~Sb3JIP4Ow1375413754euoutp02m
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 13:22:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230403132227euoutp025754d395ae13df8f14406d682b822425~Sb3JIP4Ow1375413754euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680528147;
        bh=C4y5H34/b66lYzmCayiry+Dr/iI1gotrFjxRhbqI+PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXp2XaelSwCkYKfkU9KMaQBicOuPO5FCl6eazPBuaqDzxeI0oeAp8adbZL8WddZmx
         X7uAsdaOnFuuiLwMj/35Lgs8J5U4FynuBTYEt2GUI96Y7F7qp/ZfxHo532agr5ULM5
         JawW7/UyfI363OcIirmZR3Qt5uDyxChn97iVJZfQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230403132226eucas1p27c60b550a84a0f9a8d83aeb35c2131a7~Sb3Hq6jkH1831918319eucas1p26;
        Mon,  3 Apr 2023 13:22:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.F4.09503.113DA246; Mon,  3
        Apr 2023 14:22:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230403132225eucas1p15848db3c850e950b21b339d5861080e1~Sb3HLozNU1121911219eucas1p1e;
        Mon,  3 Apr 2023 13:22:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230403132225eusmtrp222d08e847a640f99b1692735673dfaa4~Sb3HK3YsO0200802008eusmtrp2N;
        Mon,  3 Apr 2023 13:22:25 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-b8-642ad3114817
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EF.16.08862.113DA246; Mon,  3
        Apr 2023 14:22:25 +0100 (BST)
Received: from localhost (unknown [106.210.248.30]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230403132225eusmtip18dbb686db7c510460cd06cbef5485d8b~Sb3G_SMEG2613126131eusmtip1C;
        Mon,  3 Apr 2023 13:22:25 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, minchan@kernel.org, martin@omnibond.com,
        hubcap@omnibond.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de
Cc:     devel@lists.orangefs.org, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 4/5] mpage: use folios in bio end_io handler
Date:   Mon,  3 Apr 2023 15:22:20 +0200
Message-Id: <20230403132221.94921-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403132221.94921-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djP87qCl7VSDPZftbKYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRXDYpqTmZZalF+nYJ
        XBkLXl5iKZjAW/Hn0j62BsY7XF2MnBwSAiYS16etY+li5OIQEljBKDF50wF2COcLo0Tr6g9Q
        zmdGiRNrTrDCtBxa9IEJIrGcUWL7yV1sEM4LRolvsx4ADePgYBPQkmjsBOsWEbjFKPGmZzZY
        B7PAfUaJebv3MoGMEhawl9jZupYRxGYRUJV4daYDzOYVsJSYd/ITI8Q6eYn9B88yg9icAlYS
        jdPnQtUISpyc+YQFxGYGqmneOpsZon43p8SRWzwQtovE/5MroeLCEq+Ob2GHsGUk/u+czwRh
        V0s8vfGbGeQ4CYEWRon+nevZQD6QELCW6DuTA2IyC2hKrN+lD1HuKPFkww1miAo+iRtvBSEu
        4JOYtG06VJhXoqNNCKJaSWLnzydQSyUkLjfNYYEo8ZDYdttuAqPiLCSvzELyyiyEtQsYmVcx
        iqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEpsXT/45/2sE499VHvUOMTByMhxglOJiVRHhV
        u7RShHhTEiurUovy44tKc1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTAJO134
        cCdwdq20nBjzy44lUamL4oTnOPB08ER7JUsdXLMvd3KZ69cltVWPp00X51yW8upqb/NmlaUp
        +5pSAtW51DeYmW4x/rR3l+5kpmk6V1ytergcLzj8O/9fsGr/pqTqN9wn3eR0LYV/LL1bNMnp
        ncn2n2FtU9Yo11xRmPLkkLFDxCdXvbQFlf53P1qbrv611PyMzyXuy286unetOR0b/slo3Wv9
        L6+uFExiClURbqiWP5ammViYa8lyum6lZ+AR4a+1Yf3FCqsnpT4MqTpcIW71bdeqjm1lphNz
        vmjXqOy2nudlPyEk4a9uzfq4pdvK7hZpX7a6LVyctDQ1jdU/a8rNv7uyja6VaVVl6CqxFGck
        GmoxFxUnAgBD5PXH+gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7qCl7VSDKZOl7KYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkLXl5iKZjAW/Hn0j62BsY7
        XF2MnBwSAiYShxZ9YOpi5OIQEljKKDG3aTcrREJC4vbCJkYIW1jiz7UuNhBbSOAZo8SZztgu
        Rg4ONgEticZOdpBeEZDwsgvHWUAcZoHnjBJrpvxmBmkQFrCX2Nm6FmwQi4CqxKszHWA2r4Cl
        xLyTn6AWyEvsP3gWrJ5TwEqicfpcRohllhJfL95ihagXlDg58wkLiM0MVN+8dTbzBEaBWUhS
        s5CkFjAyrWIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM4W3Hfm7ewTjv1Ue9Q4xMHIyHGCU4
        mJVEeFW7tFKEeFMSK6tSi/Lji0pzUosPMZoC3T2RWUo0OR+YRPJK4g3NDEwNTcwsDUwtzYyV
        xHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpiymk/w5G2oWj4r4iKrZdfjvPB16yJijvkc2Jnm
        WDdd5JXYulznR9H9u4Ry3H4J/3X/LFgXUO//L6H1ghvz+woPFR9nWeZnobVbo+w5T/voWmQd
        +iAo0H6I78Tq2Tu0pktYhS2N1J+7bkZuTmj9m0+t0nV7tp2wrO97Kv/xh+CNZadbah/8/757
        OdPL7sYPC3a++6l9bLKr7irvLbtf3Z1SlS0Z9rrwk5mNvnva6/zmywuLVgZoHdoafePuIuuf
        1yeznihwWjFRaElt+A+rm79DOXvurOLm9XO772+Q8+P0YunoHuEqjxUzvDj3zD45c+7aJYHp
        p4RjGD4HX/p/gM307p3dEnGeWyQSbRbufzJPiaU4I9FQi7moOBEAW9tMD2oDAAA=
X-CMS-MailID: 20230403132225eucas1p15848db3c850e950b21b339d5861080e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230403132225eucas1p15848db3c850e950b21b339d5861080e1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230403132225eucas1p15848db3c850e950b21b339d5861080e1
References: <20230403132221.94921-1-p.raghav@samsung.com>
        <CGME20230403132225eucas1p15848db3c850e950b21b339d5861080e1@eucas1p1.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use folios in the bio end_io handler. This conversion does the appropriate
handling on the folios in the respective end_io callback and removes the
call to page_endio(), which is soon to be removed.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/mpage.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 3a545bf0f184..6f43b7c9d4de 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -45,13 +45,15 @@
  */
 static void mpage_read_end_io(struct bio *bio)
 {
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
+	int err = blk_status_to_errno(bio->bi_status);
 
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-		page_endio(page, REQ_OP_READ,
-			   blk_status_to_errno(bio->bi_status));
+	bio_for_each_folio_all(fi, bio) {
+		if (!err)
+			folio_mark_uptodate(fi.folio);
+		else
+			folio_set_error(fi.folio);
+		folio_unlock(fi.folio);
 	}
 
 	bio_put(bio);
@@ -59,13 +61,15 @@ static void mpage_read_end_io(struct bio *bio)
 
 static void mpage_write_end_io(struct bio *bio)
 {
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
+	int err = blk_status_to_errno(bio->bi_status);
 
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-		page_endio(page, REQ_OP_WRITE,
-			   blk_status_to_errno(bio->bi_status));
+	bio_for_each_folio_all(fi, bio) {
+		if (err) {
+			folio_set_error(fi.folio);
+			mapping_set_error(fi.folio->mapping, err);
+		}
+		folio_end_writeback(fi.folio);
 	}
 
 	bio_put(bio);
-- 
2.34.1


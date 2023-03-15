Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA996BB230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 13:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjCOMeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 08:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjCOMd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:33:59 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14FD9F07B
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 05:32:45 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230315123237euoutp027bb9e9e8d78287b9db5038bebc8ae656~Ml7NUBpl12858728587euoutp02B
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 12:32:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230315123237euoutp027bb9e9e8d78287b9db5038bebc8ae656~Ml7NUBpl12858728587euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678883557;
        bh=xHtHdDL6PMtjzG/s1BTeKZDoZWNicuamGwZqbWGaFWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ax8djDHzSaL2h5KoBK8rAqoscnHFdpLvekOgdxRLNhFJdvc1CU+XEdZujT1yApZJr
         kHnV6wwVOwl4uP6Di2aFvMjU0yWRB0/YRhHvWMJMkZU4PxscvptOypNRqC1/Oq5eG0
         I+iCVezVB6IDbnkfc2g2QIEUb7Cipw9xnaVVF8sE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230315123236eucas1p278affb4e64241546f64afed338efca1c~Ml7L6vXGB3026530265eucas1p21;
        Wed, 15 Mar 2023 12:32:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.70.09503.3EAB1146; Wed, 15
        Mar 2023 12:32:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd~Ml7LeOs-D2051320513eucas1p16;
        Wed, 15 Mar 2023 12:32:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230315123235eusmtrp1bdff96dbbe94408780a8ff5c68ddbd05~Ml7LdnDW41056310563eusmtrp1z;
        Wed, 15 Mar 2023 12:32:35 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-1e-6411bae38811
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AF.AF.09583.3EAB1146; Wed, 15
        Mar 2023 12:32:35 +0000 (GMT)
Received: from localhost (unknown [106.210.248.172]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230315123235eusmtip2887f4bfaca2837bb071b662d96499d3a~Ml7LNopEC0183701837eusmtip2L;
        Wed, 15 Mar 2023 12:32:35 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hubcap@omnibond.com, senozhatsky@chromium.org, martin@omnibond.com,
        willy@infradead.org, minchan@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, mcgrof@kernel.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC PATCH 2/3] mpage: use bio_for_each_folio_all in mpage_end_io()
Date:   Wed, 15 Mar 2023 13:32:32 +0100
Message-Id: <20230315123233.121593-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315123233.121593-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87qPdwmmGGzdY2ExZ/0aNovVd/vZ
        LF4f/sRosX/zFCaLmwd2Mlm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovPS1vYLXZvXMRmcf7vcVaL3z/msDkIesxuuMjisXmFlsfls6Uem1Z1snls+jSJ3ePE
        jN8sHg1Tb7F5/Lp9h9Wjb8sqRo/Pm+Q8Nj15yxTAHcVlk5Kak1mWWqRvl8CVsbjnHGtBE3tF
        59mrjA2Md1i7GDk5JARMJF4c3MrcxcjFISSwglHiadNeNgjnC6NE55857BDOZ0aJJ33Pgco4
        wFpOvTKHiC9nlNi9+h1U0UtGiYbrm1hAitgEtCQaO8HiIgJngJpbJoKNZRa4zyhxvek3O8hy
        YQEfie+LrzOB2CwCqhKvvu9gBrF5BawkbuxYwQRxoLzE/oNnweKcAtYSq1dOZ4OoEZQ4OfMJ
        C4jNDFTTvHU22BMSAqs5JW5uWgT1nYvE5O9XWSBsYYlXx7ewQ9gyEqcn90DFqyWe3vgN1dzC
        KNG/cz0bxJ/WEn1nckBMZgFNifW79CHKHSU2LZrCClHBJ3HjrSDECXwSk7ZNhwYQr0RHmxBE
        tZLEzp9PoJZKSFxumsMCUeIh8esh6wRGxVlIfpmF5JdZCGsXMDKvYhRPLS3OTU8tNsxLLdcr
        TswtLs1L10vOz93ECEyBp/8d/7SDce6rj3qHGJk4GA8xSnAwK4nwhrMIpAjxpiRWVqUW5ccX
        leakFh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgSTZeLglGpg8l9d4PL5A9ObJH/2iyl7lJaI
        cG7PsZfX7PE1Yrgua7ZMK1Zn4+ojhz5v/c0Yqv06hquyKdh2ru8v3Xu+TT8n/edUnhQ4W9h6
        8kqOamdrlnAFPTb50mOfZvPaPPx6Zo/B/rebk5r/XzxU/K1UTfd/h5/UdlstU+XHbw4Zpm9Z
        uz34dldLCFdL75GZh1NkC6+e8BEK/PVufwr3lYPxl/XWtt0wyZ2WsHG3+tqKZN4496btT3cF
        799YksTJas0963T64tL7B29vVvh2om5yq1uX49xVNWs3CsjM6nvC7qenElF8rnXR9l+5/Cxt
        /Ekv0xjTbnkIfrJTusm+8tKdhcVH4xum7a+fYqXR4NOzTu6dEktxRqKhFnNRcSIAl7DQVfAD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7qPdwmmGCw+oWAxZ/0aNovVd/vZ
        LF4f/sRosX/zFCaLmwd2Mlm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovPS1vYLXZvXMRmcf7vcVaL3z/msDkIesxuuMjisXmFlsfls6Uem1Z1snls+jSJ3ePE
        jN8sHg1Tb7F5/Lp9h9Wjb8sqRo/Pm+Q8Nj15yxTAHaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
        Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsbjnHGtBE3tF59mrjA2Md1i7GDk4JARMJE69
        Mu9i5OIQEljKKHHx9Ha2LkZOoLiExO2FTYwQtrDEn2tdbBBFzxkl9v+YDtbMJqAl0djJDhIX
        EbjBKDH10i9GEIcZpOjZTZANnBzCAj4S3xdfZwKxWQRUJV5938EMYvMKWEnc2LGCCWKDvMT+
        g2fB4pwC1hKrV04Hu0IIqOb+vV1MEPWCEidnPmEBsZmB6pu3zmaewCgwC0lqFpLUAkamVYwi
        qaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHxuu3Yzy07GFe++qh3iJGJg/EQowQHs5IIbziLQIoQ
        b0piZVVqUX58UWlOavEhRlOguycyS4km5wMTRl5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6
        YklqdmpqQWoRTB8TB6dUA5Ogrvrp7c5vJvz2W8954tbK9U2WAsxGDS/s2TfMZdBYeGt6+xd3
        7ZUvZS4oL5k5uZV7nhKD7Q++AqVn6kUMfjvT+Qze8L64vyr7ecq6ok9ruosD1+7aVpiSlv9I
        8+vLvSn9wf2SSYrzfxvyesXOmeGlZCKY1XDGQFKwfUp82/y4XDaNQ63b1+tuerWqePKTW/c9
        UzSSyqV3HFEOn10nd9Byo03tifUST1/5va0Xc/57W7XuED/3ksUMh01vN5a7aAavFmzbdOSW
        b2OYW8w33ugJp3fOXbdlBqtWJMsGfbGfobssDRT3MXttu9YQlDthWWXUlftH9nje4X3DIdnk
        76vPyjurtO5ChbB54b1Zt5RYijMSDbWYi4oTARrtJ/1gAwAA
X-CMS-MailID: 20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd
References: <20230315123233.121593-1-p.raghav@samsung.com>
        <CGME20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bio_for_each_folio_all to iterate through folios in a bio so that
the folios can be directly passed to the folio_endio() function.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/mpage.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 40e86e839e77..bfcc139938a8 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -45,14 +45,11 @@
  */
 static void mpage_end_io(struct bio *bio)
 {
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-		folio_endio(page_folio(page), bio_op(bio),
-			   blk_status_to_errno(bio->bi_status));
-	}
+	bio_for_each_folio_all(fi, bio)
+		folio_endio(fi.folio, bio_op(bio),
+			    blk_status_to_errno(bio->bi_status));
 
 	bio_put(bio);
 }
-- 
2.34.1


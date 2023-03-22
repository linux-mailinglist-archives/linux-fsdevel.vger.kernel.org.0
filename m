Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1686C4C58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 14:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCVNuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCVNup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:50:45 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EF0637E5
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 06:50:22 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230322135018euoutp02f7ea7d5dda63045c42f9a453515c299a~OwgCPZRDi1787317873euoutp02w
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 13:50:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230322135018euoutp02f7ea7d5dda63045c42f9a453515c299a~OwgCPZRDi1787317873euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679493018;
        bh=B7mV7FXyoTd1l8VtYDL/Y6/ww7FK/3anjYTB9ana5Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3kZYXG7gxRoA/syaoUAWSE3836oL/3vMQg6n4Pog4cc/CWBbpD883LaemojNNVtc
         HmB4uByLwCiVHTVmDNnRliYXqdTAhhy9SSZqwHHar9pHcz+/9/8GsXkR9fZImR9tr2
         tOXl7dYx20ooyXimmvn5pEuCWtK4gC8pPRWcawkc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230322135016eucas1p249e0287ce2648121944ff9859e7ca930~OwgAmbtE_0614806148eucas1p2s;
        Wed, 22 Mar 2023 13:50:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CF.84.09503.8970B146; Wed, 22
        Mar 2023 13:50:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230322135016eucas1p2ee1b64175f621ee425f7f48cb908dc20~OwgAQ7_-H2731127311eucas1p2h;
        Wed, 22 Mar 2023 13:50:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230322135016eusmtrp2b58b16b46a6e5ebd71064b4e97c60834~OwgAQS0ON0726007260eusmtrp2H;
        Wed, 22 Mar 2023 13:50:16 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-e2-641b07981cc7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0D.52.08862.8970B146; Wed, 22
        Mar 2023 13:50:16 +0000 (GMT)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230322135016eusmtip2fb1d581c86b27c823127c62671bcf838~OwgACUjVU2536025360eusmtip2t;
        Wed, 22 Mar 2023 13:50:16 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        willy@infradead.org, brauner@kernel.org, akpm@linux-foundation.org,
        minchan@kernel.org, hubcap@omnibond.com, martin@omnibond.com
Cc:     mcgrof@kernel.org, devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 2/5] orangefs: use folios in orangefs_readahead
Date:   Wed, 22 Mar 2023 14:50:10 +0100
Message-Id: <20230322135013.197076-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322135013.197076-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUwTZxjfe3e9HnUlxynpgyXqGl0iIgy3jINNxzKml21uc9k/28iwsTc+
        bIG01M8sqQVhMlddA44B4uKAIX40FEHrIAjM1aZFsoEWKehGyjJ1xNljG59l3K5m/ve8v+f3
        9SQvhTMB2Uoqr6CYNxZo9RpSQXT8OHNjY7VcrXvOLrzI1jnOkezZsWMk+6AvhNjutkqMvX3V
        hbHlYzaM7RrZwHZ2eQh28Eodyd45tyhjPY5FnB0+PoHYpr8eylmhsVTOft96mmQHFtwydm66
        jsyI4WotPxFcW3MCN9hv5pwtR0jOGbLLuevVcwRnqRohudnAqIyzXWxBnOBcxTmDk9i7yz5U
        vKzj9Xl7eGPylp2K3HmLV14UpvZN+KZxCzojr0BRFNAvgO2SF6tACoqhmxEErNeR9JhC0C4c
        JkQWQwsIbn+7/bHizC1BJuHfIShvXyMJ7iE4WnV1yYqiSDoBDh2Ri/gK2oeg0lqNRAFO30Xg
        7frPdDmdAYsNdpnIJ+h1MHIqXoSVdDr0+JsIKWs1dPf04+IcRb8E46dPkBInBjxfBwnJcjWU
        tNfiYhbQZ6PAHj6PJHEmBM57IkbL4b77YuTkeFh0ncKk+SBMDM9FxKUIjrkcpFgIltJsPr04
        4vR6cFxJluivwu/NLiQxomF4MkaqEA32jq9wCVbCZ2WMxNaAayYYCQUYtNZFynAQulxCHEfP
        1DxxTM0Tx9T8n/sNwluQijebDDm8KaWA35tk0hpM5oKcpF2FBida+n/esDt0GZ28/yipF2EU
        6kVA4ZoVyq046BilTrv/AG8szDaa9bypF6kpQqNSbtjs2cXQOdpifjfPF/HGx1uMilppwaoa
        aqvfvEHqR/kdo8NvpK8dchzsN2b5SpPTb1E2vKfSuz+/uOVa56Z7W7dc+CGjXqGv/3hqWcev
        mYfmJ7Ev6ROdif4d3UmzZZ8M5Lw/L5+qT3vv2VUXFi69o6oFf9M24Wb5DPNWSYojRP8z0Kha
        wxuZOHdrOFr4/M/+hdTJdeON3n0fZMVuU28e6BP+ZtxlwY7nY+yqweRZX/603/bwpiE2YU/e
        AVncUP6n17jo1Fd+znXEPira/XTsU368QdNz2PpRUyuuft276UHe9jEt9cdvbeq0obTwHLFz
        /dHCePPditTOhvE42dsGa/adoGdvdt/GRE27MTHrl9RiXVngi9fsmRrClKtNScCNJu2//oZi
        vu4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7oz2KVTDL5vk7OYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjtKzKcovLUlVyMgvLrFVija0MNIztLTQ
        MzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL+NNwmr3gH0fF0zM/mBsYV7J3MXJySAiYSKy8
        9pm1i5GLQ0hgKaNE29d7bBAJCYnbC5sYIWxhiT/Xutggip4zSuw/sxSom4ODTUBLorETbJCI
        wA1GifZVeiA1zCA1l5/OZgZJCAs4SPxfMokVpJ5FQFXi1nwZkDCvgJXEwevLWCDmy0vsP3gW
        rJxTwFri0aJpYDcIAdVc3g/SClIvKHFy5hOwemag+uats5knMArMQpKahSS1gJFpFaNIamlx
        bnpusaFecWJucWleul5yfu4mRmC0bjv2c/MOxnmvPuodYmTiYDzEKMHBrCTC68YskSLEm5JY
        WZValB9fVJqTWnyI0RTo7InMUqLJ+cB0kVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKa
        nZpakFoE08fEwSnVwKQYde9M9jO1DWsZWzs/Ws3uWfpi1/0DW0LWaG5ruswxtWSi3GTXw3lP
        jIwFmpd8Lm9Z3CSzf8Et5Yp3fpuWdsaUtL/g07z/fe/yMHnhWq2/4ofK1eu+bv6dwx9f3Xri
        s/zN5slG7ZeW3/vOyqPzoudbS4LrZY9efb4Yt8i/64ykZ/p32EXJd5c+tfl/Y8oB/y6ulqWn
        n9fnWUZ+Krios3bDxW8lVUvdHWr3ns6+GBf9ufaA7cMZZRrWW+b+qGV8/me+5S6lb2J9xhqR
        f46Eny0488F+ZuP6ILmyzHnrdKwKrc3drCPW8yzp2ZAuobnfTvKxa1rOY68zFsvWvF+1kuvv
        on8f5+98uGRvs6bYZ1YlluKMREMt5qLiRAAQHpt+XwMAAA==
X-CMS-MailID: 20230322135016eucas1p2ee1b64175f621ee425f7f48cb908dc20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230322135016eucas1p2ee1b64175f621ee425f7f48cb908dc20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135016eucas1p2ee1b64175f621ee425f7f48cb908dc20
References: <20230322135013.197076-1-p.raghav@samsung.com>
        <CGME20230322135016eucas1p2ee1b64175f621ee425f7f48cb908dc20@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert orangefs_readahead() from using struct page to struct folio.
This conversion removes the call to page_endio() which is soon to be
removed, and simplifies the final page handling.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/orangefs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index aefdf1d3be7c..9014bbcc8031 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -244,7 +244,7 @@ static void orangefs_readahead(struct readahead_control *rac)
 	struct iov_iter iter;
 	struct inode *inode = rac->mapping->host;
 	struct xarray *i_pages;
-	struct page *page;
+	struct folio *folio;
 	loff_t new_start = readahead_pos(rac);
 	int ret;
 	size_t new_len = 0;
@@ -275,9 +275,10 @@ static void orangefs_readahead(struct readahead_control *rac)
 		ret = 0;
 
 	/* clean up. */
-	while ((page = readahead_page(rac))) {
-		page_endio(page, false, ret);
-		put_page(page);
+	while ((folio = readahead_folio(rac))) {
+		if (!ret)
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 	}
 }
 
-- 
2.34.1


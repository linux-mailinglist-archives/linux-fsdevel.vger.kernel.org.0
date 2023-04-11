Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D436DDAD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDKM3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 08:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDKM3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:29:31 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C02709
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 05:29:26 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230411122925euoutp023e077a9d57149bd52355c3b1b051a492~U4THwCfVL0164001640euoutp02S
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 12:29:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230411122925euoutp023e077a9d57149bd52355c3b1b051a492~U4THwCfVL0164001640euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681216165;
        bh=PIVtaWRdXFvvGvca/utIz/lLXjHseGY076GdVp9CofQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+NcSqyqbq11RtsrC+miaqtF9/zatU92pOylTRwd7fqlJapAX0PouHP1PgEAx/uXx
         DyeEETwwsyKbo+sFwMBF1sju9QKbpPx1/GJyuzdssfrueHqz7EcEhAZP0KLactXS2B
         wP3ZGLEpiAXdItnsQ4DEPTcKYoI50y18gs5kxSuc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230411122923eucas1p2f756a287f9f45b8c76bdbd7f81d949db~U4TF8Df2y3228532285eucas1p2t;
        Tue, 11 Apr 2023 12:29:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B8.9A.10014.3A255346; Tue, 11
        Apr 2023 13:29:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230411122923eucas1p27e097fa66db8e166d14658bc7c6f180b~U4TFlFxcc3003730037eucas1p27;
        Tue, 11 Apr 2023 12:29:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230411122923eusmtrp1f4a4812316778b3dcb34ac05a45a01dd~U4TFkUivq0646206462eusmtrp1S;
        Tue, 11 Apr 2023 12:29:23 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-03-643552a3acbc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B7.FB.34412.2A255346; Tue, 11
        Apr 2023 13:29:23 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230411122922eusmtip22c05afaf469dd0ad10bc0ac238306b53~U4TFSq8M32761927619eusmtip2k;
        Tue, 11 Apr 2023 12:29:22 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hubcap@omnibond.com, brauner@kernel.org, martin@omnibond.com,
        willy@infradead.org, hch@lst.de, minchan@kernel.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk,
        akpm@linux-foundation.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        mcgrof@kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 1/3] orangefs: use folios in orangefs_readahead
Date:   Tue, 11 Apr 2023 14:29:18 +0200
Message-Id: <20230411122920.30134-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411122920.30134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djP87qLg0xTDJqvyVnMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBYrVx9lsmi/28dksfeWtsWevSdZLC7vmsNmcW/Nf1aLk+v/M1vc
        mPCU0WLZ1/fsFp+XtrBb7N64iM3i/N/jrBa/f8xhcxDymN1wkcVj8wotj8tnSz02repk89j0
        aRK7x4kZv1k8GqbeYvPYfbOBzePX7TusHn1bVjF6fN4k57HpyVumAJ4oLpuU1JzMstQifbsE
        roxzS26zFjRwV9x9e5+pgbGZs4uRg0NCwERic593FyMXh5DACkaJnS93sEA4Xxglbm+7ygTh
        fGaUeHFlKWMXIydYx97Pe9lBbCGB5YwS7Yf8IYpeMkpM2rCLCWQsm4CWRGMnO0hcROAWo8SC
        z1cYQRxmgfuMEg9vnQLrFhZwkliyeQYriM0ioCrxbv1fZpBmXgFLifbFTBDL5CX2HzzLDGJz
        ClhJrF71AewIXgFBiZMzn7CA2MxANc1bZzODzJcQ2M0p0X15KRtEs4vE5glHWCFsYYlXx7ew
        Q9gyEqcn97BA2NUST2/8hmpuYZTo37meDRIw1hJ9Z3JATGYBTYn1u/Qhyh0l9n7bxwhRwSdx
        460gxAl8EpO2TWeGCPNKdLQJQVQrSez8+QRqqYTE5aY5UEs9JH71HWefwKg4C8kzs5A8Mwth
        7wJG5lWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBSfH0v+NfdzCuePVR7xAjEwfjIUYJ
        DmYlEd4fLqYpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZODil
        GphqHNS0w+S2T33e+sH0yKvojbIasw2dJDimru7lqnjlPI+zvK2fd2WoG8cu7iMT21e0ud5w
        vNP461p/f631ZjFFiaMJMz71rDgWIOqy4P3nFTwPapimFmS+4m6NO5Woz7L1ksTTZb2LRHb6
        bVl3/FT4057jG9Z3B9a3xHDd/GbHetz4wPYU9ZNOj0pfHjP9/jDHfq9zwaklGxavmJLBvHpR
        e2fCag+Hz9+bpNinsTsIv3hkmtT4pb8i/ynPnD3qUwvurTg2N9nrm+8Tp97ST1s6V2z//SFB
        6bBS7JPLbhci+VZfnXyH7y3XzRX227o/SKyfZH0+b2FcYfv6b7enmlTZyyonf5OedzNDR+DZ
        df4dSizFGYmGWsxFxYkAYICW5vkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7qLg0xTDF58YLSYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnnltxmLWjgrrj79j5TA2Mz
        ZxcjJ4eEgInE3s972bsYuTiEBJYySty8ep4NIiEhcXthEyOELSzx51oXWFxI4DmjxJQPrF2M
        HBxsAloSjZ1gvSICzxglZm/YwgpSwwxS8+sRL4gtLOAksWTzDLA4i4CqxLv1f5lBenkFLCXa
        FzNBjJeX2H/wLDOIzSlgJbF61QdGiFWWEhfa54G18goISpyc+YQFYry8RPPW2cwTGAVmIUnN
        QpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzB+tx37uWUH48pXH/UOMTJxMB5ilOBg
        VhLh/eFimiLEm5JYWZValB9fVJqTWnyI0RTo7InMUqLJ+cAEklcSb2hmYGpoYmZpYGppZqwk
        zutZ0JEoJJCeWJKanZpakFoE08fEwSnVwLQ93KVDxE3m+9vDar+Mz0p8/1bln2KS8P2w0b97
        3lMzqht59tmv+yM8sbzajeF+3MY9BwWrzrM8z8wt3XzhRsdn4+o4l7e6cufMz0W+512x//iT
        I2dm7cqqZbuo4FT3uoZl8ZkGkX3+nA+Xne74dXSPaV3jWcFdpS8KPx+b++CB992C3Us/Zs91
        /RFmfCb/ucYU9i/8obeMYo/6zThy03ZXQLj86b663BOLyn6V+K1j33Fv95t/ndcSv9nruDOo
        3rnC929L3s7/Fuxpnkn8TKJFD2oyXnkFbD8h2CWzUX+6mOq1Vfe+Bl0o9evQuBo62aXz56Wy
        pD2TXpp0qV9fffT1PlZHs9opi+X0GpnYZq9UYinOSDTUYi4qTgQAQYdjlmgDAAA=
X-CMS-MailID: 20230411122923eucas1p27e097fa66db8e166d14658bc7c6f180b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230411122923eucas1p27e097fa66db8e166d14658bc7c6f180b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230411122923eucas1p27e097fa66db8e166d14658bc7c6f180b
References: <20230411122920.30134-1-p.raghav@samsung.com>
        <CGME20230411122923eucas1p27e097fa66db8e166d14658bc7c6f180b@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert orangefs_readahead() from using struct page to struct folio.
This conversion removes the call to page_endio() which is soon to be
removed, and simplifies the final page handling.

The page error flags is not required to be set in the error case as
orangefs doesn't depend on them.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mike Marshall <hubcap@omnibond.com>
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


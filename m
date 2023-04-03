Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05A6D4589
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 15:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjDCNWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 09:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjDCNWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:22:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F8911646
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 06:22:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230403132226euoutp0152f31b2ebbaaef44516decbe4f0d0252~Sb3IHoZmj1624316243euoutp011
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 13:22:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230403132226euoutp0152f31b2ebbaaef44516decbe4f0d0252~Sb3IHoZmj1624316243euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680528146;
        bh=cv+Hj0FwPtC3HT2R3DDLLPaYMWixtk1Tvm8cFC27+6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B39O5prHjZY0V7xuyRpKWUkJhlL0o/dYBrAbqOAY8Wj+XGSawtVbwCkB8ZooCJsVK
         sjQbZYJgRELCcwxoaywLcVa6kbH5RSuTWfojHZ9KvOLyiRXK0u/fhvXXZLIa8Ws2iB
         R4O4ttoX5iWGfhcl5DnEgDqA/34PsVWAMkCn8fLw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230403132224eucas1p1dd063339ab3dd7e50f716c30dfa6c3d7~Sb3Gm84Sm0205602056eucas1p1F;
        Mon,  3 Apr 2023 13:22:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F9.F9.10014.013DA246; Mon,  3
        Apr 2023 14:22:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230403132224eucas1p28f82802bc40d4feb5a30bb59c6536ab3~Sb3GIDjiU1827918279eucas1p2r;
        Mon,  3 Apr 2023 13:22:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230403132224eusmtrp2743cb3eb410ee96b9ce1aef1859b792d~Sb3GHEWDm0200802008eusmtrp2K;
        Mon,  3 Apr 2023 13:22:24 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-c8-642ad310e985
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 35.ED.09583.013DA246; Mon,  3
        Apr 2023 14:22:24 +0100 (BST)
Received: from localhost (unknown [106.210.248.30]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230403132224eusmtip1acb8b48c14dc2c7e83cb18c349594e39~Sb3F5SUdL2319123191eusmtip1F;
        Mon,  3 Apr 2023 13:22:24 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, minchan@kernel.org, martin@omnibond.com,
        hubcap@omnibond.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de
Cc:     devel@lists.orangefs.org, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 2/5] orangefs: use folios in orangefs_readahead
Date:   Mon,  3 Apr 2023 15:22:18 +0200
Message-Id: <20230403132221.94921-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403132221.94921-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbVRjGc+5tb28LbS6FjBdsmHQhxo5P0eSg6EBJvENJ/GPLUGegGTes
        o+WjBb+2aJFFXJ2MTCcTqizMCYNqpYyNFnATNhHHx7Y6B0yYwWImH+2EEgsE6srt4v77vec8
        z/ucJzk0Kf9bGE1riss5fbFaq6QkgvM/rYwmME5VQXKLNxmbrRYKt00eo/Bc/yLCFzs+I/D4
        JTuBz7ZdIXD1ZA2Beye2457eQQF2OswUnrL4hXjQ6ifxWO0Mwt8se0R46cxhEe5ub6Lw6PqA
        EK/5zFSGnG0wXhewHS0q1jlcwdpaj1CsbfG4iP355JqANZ6YoNjucSPFrt7+XcjWnGtF7JIt
        hrW5FohXQl+TpBdwWs2bnD7puXzJ/mvVnWSpU/L2qmlRZES3aRMS08A8CQ6fhzIhCS1nWhA0
        Tp8i+MGLoGv8uogflhB4710jH1gWTHNBSzMCu/sm4oe7CC5M24UmRNMUo4LKI5vuCGYCwfzR
        hs29JHMHwVfdvURgVTjzPJjrbgkDLGDioGrkXxRgKZMG89UnBHzcVrj44/BmtJh5Girrvgxq
        wmDwC9emhryvqepsIAMBwFwQw8ySB/HmLOi5+rmQ53CYHTgn4lkBfnsjwfNBmBlbC5oPIzhm
        t1KBCsA8AzVD2gCSzONgdSTx8kxoGrkZVMhgbCGMf4IMjp+vI/ljKXz0oZxXK8G+4gqGAjg/
        MAdbsTD5XT9Zi2LrHypT/1CZ+v9zTyGyFUVyFQZdIWdILebeSjSodYaK4sLEfSU6G7r/G69u
        DCx3oZbZfxL7EEGjPgQ0qYyQxplUBXJpgfqddzl9SZ6+QssZ+tAjtEAZKd3+7OA+OVOoLueK
        OK6U0z+4JWhxtJEQxp0ROW64VvMqI+bTxVvKLrXtbnRny/bGjA4owrL8rriMj6ui38+VlnZ6
        PnFEJZat+iLjfxlzmLWIbF+On4rB27z+7PeG9damuY3s3e6dLz8qO5SzUzOx1xeeGVqZ8ETS
        XIngrNKzRbPeczJ5aij39KEd3pW/kmbJHNWNowq33rX4hkaXQjt9irLxK79m3X1xx/cK5T1L
        VGvPS9gtaJjek/Cbcw93sCTWnnG5PHPI+0JXyGi+rj/qT1vdq7HNiLvV91hnjiWhVlGUkhOa
        536qexf2HjiQa4g//cPwH7ZPN1K3edY70tRprxc15m+NLZSnX7bc+ToiUhbSvqt55NuQVKXA
        sF+doiL1BvV/z9DeiPwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7oCl7VSDE79EbCYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkX2rcyF1zmqvjV9Ym9gfE2
        RxcjJ4eEgInE267XbF2MXBxCAksZJVZMnscOkZCQuL2wiRHCFpb4c60LqugZo8TeDVeAijg4
        2AS0JBo72UHiIiDxZReOs4A4zALPGSXWTPnNDNItLOAkMWf6dVYQm0VAVaL53HewqbwClhJv
        2qeyQGyQl9h/8CxYPaeAlUTj9LlgNUJANV8v3mKFqBeUODnzCVg9M1B989bZzBMYBWYhSc1C
        klrAyLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMIq3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBW
        EuFV7dJKEeJNSaysSi3Kjy8qzUktPsRoCnT3RGYp0eR8YBrJK4k3NDMwNTQxszQwtTQzVhLn
        9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgcilVf7KCv+Lyc/6jD2JqbHY0XMnU0pn2dG/oFBvj
        dTsktU4r2bfY74izZbxxUbaxzv/BLhvR54YWTzrONwrx83T4Hvwad+eOF39h2uKjrxVOCQto
        nnHr5pB5L6U0tasvlX/OOh1fRc0bkmn+cdqax3m/Hz4o6BnBfn2yIr/3kew6tqoF2TIT4+sD
        5Bu7p+h83uXn/P3OTCZjtereyvd/FjNOOGV/OqJ3rZL25H3PHi8y8OV37mfqV899l3PAbqmA
        WvoxNfOGvZav762ZKbtJ/EGHVq7elQAF11leb6ZU3Pz8LOyAqwK74BYpJ2/HR1cab/4OdnRZ
        MuWqGFOz2CzjeynHKpymrpu4b8m61GAlluKMREMt5qLiRADatwx8awMAAA==
X-CMS-MailID: 20230403132224eucas1p28f82802bc40d4feb5a30bb59c6536ab3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230403132224eucas1p28f82802bc40d4feb5a30bb59c6536ab3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230403132224eucas1p28f82802bc40d4feb5a30bb59c6536ab3
References: <20230403132221.94921-1-p.raghav@samsung.com>
        <CGME20230403132224eucas1p28f82802bc40d4feb5a30bb59c6536ab3@eucas1p2.samsung.com>
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


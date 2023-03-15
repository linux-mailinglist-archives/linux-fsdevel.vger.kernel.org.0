Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3506BB234
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjCOMeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjCOMeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:34:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794639F069
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 05:32:44 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230315123237euoutp021145607cb153bec6cc52d2ece8405029~Ml7NG4Xlx2618426184euoutp02d
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 12:32:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230315123237euoutp021145607cb153bec6cc52d2ece8405029~Ml7NG4Xlx2618426184euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678883557;
        bh=Dyt/yPdeYY+WSauc7HCejFF6ehE2pQBkEGu9AWh2ZjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBeOb9g47+WTg0gPxup2I2BPLrkSw+oMGg6E1+/Fv6cjB0d1wJU/olmOnbTN1+W+x
         A9x8m2a9PBcQWg/2hjC09UBMDLEaQcPF6aHtaQ0OnA9qPg9NJ0uBu0Jh526Olghp1A
         lJJOTS9swRM/LeXUbPt6wyEui41MZYWZWxXTMPWs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230315123235eucas1p2a826de56db29b259200ca5b32853ec59~Ml7LWvFV91506715067eucas1p2v;
        Wed, 15 Mar 2023 12:32:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.70.09503.3EAB1146; Wed, 15
        Mar 2023 12:32:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230315123234eucas1p2503d83ad0180cecde02e924d7b143535~Ml7K6PVSi2825828258eucas1p2k;
        Wed, 15 Mar 2023 12:32:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230315123234eusmtrp15eee728631fe9cf040f7e0e808da32d1~Ml7K5pMfN1056310563eusmtrp1v;
        Wed, 15 Mar 2023 12:32:34 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-16-6411bae3a382
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.AF.09583.2EAB1146; Wed, 15
        Mar 2023 12:32:34 +0000 (GMT)
Received: from localhost (unknown [106.210.248.172]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230315123234eusmtip1bb76bd37b558769186fe3dea555acaba~Ml7KooprZ1241212412eusmtip1o;
        Wed, 15 Mar 2023 12:32:34 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hubcap@omnibond.com, senozhatsky@chromium.org, martin@omnibond.com,
        willy@infradead.org, minchan@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, mcgrof@kernel.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Date:   Wed, 15 Mar 2023 13:32:31 +0100
Message-Id: <20230315123233.121593-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315123233.121593-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7qPdwmmGMz6K2YxZ/0aNovVd/vZ
        LF4f/sRosX/zFCaLmwd2Mlm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovPS1vYLXZvXMRmcf7vcVaL3z/msDkIesxuuMjisXmFlsfls6Uem1Z1snls+jSJ3ePE
        jN8sHg1Tb7F5/Lp9h9Wjb8sqRo/Pm+Q8Nj15yxTAHcVlk5Kak1mWWqRvl8CVcefSF+aCX9IV
        Uw42sjUw/hDrYuTkkBAwkbjVfJCli5GLQ0hgBaPEsY4JzBDOF0aJ53Mvs0M4nxklNvTPYoFp
        mTSzG6plOaPEhW232SCcl4wSfzb9YO1i5OBgE9CSaOwE6xYROMMo8aRlIlgRs8B9RonrTb/Z
        QUYJCzhLLPj0F8xmEVCV2L/0P9gKXgEriU8dDYwQ6+Ql9h88ywxicwpYS6xeOZ0NokZQ4uTM
        J2D1zEA1zVtngx0uIbCaU2LLi59MEM0uEle//YUaJCzx6vgWdghbRuL05B6of6olnt74DdXc
        wijRv3M9G8gLEkDb+s7kgJjMApoS63fpQ0QdJY7O1oAw+SRuvBWEuIBPYtK26cwQYV6JjjYh
        iNlKEjt/PoHaKSFxuWkO1E4PifbJ8xknMCrOQvLLLCS/zEJYu4CReRWjeGppcW56arFhXmq5
        XnFibnFpXrpecn7uJkZgEjz97/inHYxzX33UO8TIxMF4iFGCg1lJhDecRSBFiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dUA5Op/IR+faGgzX7/tGLNVbK4
        jCb9O/GqhVdo0y3VyQlKkpE3JvXWa9vKdUlVXjUJX/WMvb5jspJjUd93Ru+s+KwNwgI6y5ru
        J7C+mrI26NmKcxnMd50PuL9YvvHxD0Nffv3ttWE969bt2T17PV+OMPd+0bp3rucFlzXGZ6yf
        13B7QU3fxnmrqkveKLH5rnpX8eqd9usoCV3ZeN+kYoGUwNJfE1jYzU9Fupg0CRqZal23FixP
        tXzyKfCNyY9/T7ZIzbN83903+d1ua56aqUkuC7UvuRrabv/Se9OmMdh+vr7NVqFek6T/D7lY
        8rnXB/E+PdEru0y6faZDo9yln6vKdV3uGyl3Cpxn/5F94H+MEktxRqKhFnNRcSIAbEuepvED
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7qPdgmmGLS+M7OYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjtKzKcovLUlVyMgvLrFVija0MNIztLTQ
        MzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuHPpC3PBL+mKKQcb2RoYf4h1MXJySAiYSEya
        2c3SxcjFISSwlFFi/dRWVoiEhMTthU2MELawxJ9rXWwQRc8ZJVqmHANKcHCwCWhJNHayg8RF
        BG4wSky99IsRxGEGKXp28w7YJGEBZ4kFn/6yg9gsAqoS+5f+ZwGxeQWsJD51NEBtkJfYf/As
        M4jNKWAtsXrldDYQWwio5v69XUwQ9YISJ2c+AetlBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSW
        Fuem5xYb6RUn5haX5qXrJefnbmIERuy2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzhLAIpQrwp
        iZVVqUX58UWlOanFhxhNge6eyCwlmpwPTBl5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6Ykl
        qdmpqQWpRTB9TBycUg1MUzzL5sVKCv6bHXAk+mfYwtANbkc32j2bPG+jg02jlNQdjbabWW73
        m3K3aXZImd9k/xB/W/vhj0lftaoc3m6fKNp910/pr1iTwb+LinF2hjXcfzX2lxt4H9GXdN6w
        xvLFj9Wtc65fcn9S773j8vvKrCnyOhYxk1/OnRXhP2/GNYc79seTT59/8qOjeWXhtg0Vb609
        Xt1ZvVdRTbDpHs/3aQZKp89Os7y2tkx33+OV1qKJd8NjxV98X3C17eatoIwllxOOHms28/Di
        2Ln6xzTG29rzzEtPNTypPzXPKXFH9YEvrYEX9LhrHKMfTYkzmspV/eaDxvSksgxnzUy3h9Jr
        S1T8vrT8/pin/y7dte+toBJLcUaioRZzUXEiAFEdsWVhAwAA
X-CMS-MailID: 20230315123234eucas1p2503d83ad0180cecde02e924d7b143535
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315123234eucas1p2503d83ad0180cecde02e924d7b143535
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315123234eucas1p2503d83ad0180cecde02e924d7b143535
References: <20230315123233.121593-1-p.raghav@samsung.com>
        <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

page_endio() already works on folios by converting a page in to a folio as
the first step. Convert page_endio to folio_endio by taking a folio as the
first parameter.

Instead of doing a page to folio conversion in the page_endio()
function, the consumers of this API do this conversion and call the
folio_endio() function in this patch.
The following patches will convert the consumers of this API to use native
folio functions to pass to folio_endio().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 fs/mpage.c                    | 2 +-
 fs/orangefs/inode.c           | 2 +-
 include/linux/pagemap.h       | 2 +-
 mm/filemap.c                  | 8 +++-----
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aa490da3cef2..f441251c9138 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -610,7 +610,7 @@ static void zram_page_end_io(struct bio *bio)
 {
 	struct page *page = bio_first_page_all(bio);
 
-	page_endio(page, op_is_write(bio_op(bio)),
+	folio_endio(page_folio(page), op_is_write(bio_op(bio)),
 			blk_status_to_errno(bio->bi_status));
 	bio_put(bio);
 }
diff --git a/fs/mpage.c b/fs/mpage.c
index 22b9de5ddd68..40e86e839e77 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -50,7 +50,7 @@ static void mpage_end_io(struct bio *bio)
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
 		struct page *page = bv->bv_page;
-		page_endio(page, bio_op(bio),
+		folio_endio(page_folio(page), bio_op(bio),
 			   blk_status_to_errno(bio->bi_status));
 	}
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index aefdf1d3be7c..b12d099510ea 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -276,7 +276,7 @@ static void orangefs_readahead(struct readahead_control *rac)
 
 	/* clean up. */
 	while ((page = readahead_page(rac))) {
-		page_endio(page, false, ret);
+		folio_endio(page_folio(page), false, ret);
 		put_page(page);
 	}
 }
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fdcd595d2294..80eab64b834f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1076,7 +1076,7 @@ int filemap_migrate_folio(struct address_space *mapping, struct folio *dst,
 #else
 #define filemap_migrate_folio NULL
 #endif
-void page_endio(struct page *page, bool is_write, int err);
+void folio_endio(struct folio *folio, bool is_write, int err);
 
 void folio_end_private_2(struct folio *folio);
 void folio_wait_private_2(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c654..a89940f74974 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1626,13 +1626,11 @@ void folio_end_writeback(struct folio *folio)
 EXPORT_SYMBOL(folio_end_writeback);
 
 /*
- * After completing I/O on a page, call this routine to update the page
+ * After completing I/O on a folio, call this routine to update the folio
  * flags appropriately
  */
-void page_endio(struct page *page, bool is_write, int err)
+void folio_endio(struct folio *folio, bool is_write, int err)
 {
-	struct folio *folio = page_folio(page);
-
 	if (!is_write) {
 		if (!err) {
 			folio_mark_uptodate(folio);
@@ -1653,7 +1651,7 @@ void page_endio(struct page *page, bool is_write, int err)
 		folio_end_writeback(folio);
 	}
 }
-EXPORT_SYMBOL_GPL(page_endio);
+EXPORT_SYMBOL_GPL(folio_endio);
 
 /**
  * __folio_lock - Get a lock on the folio, assuming we need to sleep to get it.
-- 
2.34.1


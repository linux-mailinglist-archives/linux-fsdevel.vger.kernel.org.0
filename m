Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5478E6FDE0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 14:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjEJMr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbjEJMr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 08:47:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBF930DA
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 05:47:22 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230510124718euoutp01cb6cccbc14ba1b4874121abea06ab755~dyQBRqVFW2200222002euoutp01M
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 12:47:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230510124718euoutp01cb6cccbc14ba1b4874121abea06ab755~dyQBRqVFW2200222002euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683722838;
        bh=yQDc+kOAIE1uNanTmn5CeXJvT/CwzXTmmHedSea//Uo=;
        h=From:To:CC:Subject:Date:References:From;
        b=eSTTAIB5kqSTxT7v04TOlT9/xsxst1tv+Zi9ULD1W4cDKkc5rRqKBLyPWthD1tFiD
         slzLujoKXLZUa07o8YsahdzNly59EeOw2FEkF6n6+0hbsXPhdLPapFbew5f4iaxiN8
         vASZmJHQNNUtI58sm/4s1iphHe3PNAe4jLvnm4FA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230510124718eucas1p27dbb62ec37e4b792da0792086e25ad44~dyQBEgi381889318893eucas1p2X;
        Wed, 10 May 2023 12:47:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D4.B0.37758.6529B546; Wed, 10
        May 2023 13:47:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230510124718eucas1p2c11356c0628b9acb44c1174fd45fa4b7~dyQAzGl210656906569eucas1p2H;
        Wed, 10 May 2023 12:47:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230510124718eusmtrp1a9a5b4d229ef743b661ca6312ca141ea~dyQAyhyG11062210622eusmtrp1N;
        Wed, 10 May 2023 12:47:18 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-a5-645b9256a229
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 27.0E.10549.6529B546; Wed, 10
        May 2023 13:47:18 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230510124718eusmtip1828a062b2bf069822ad464c0bb21f720~dyQAoRHU41816218162eusmtip1u;
        Wed, 10 May 2023 12:47:18 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 10 May 2023 13:47:17 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <willy@infradead.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <mcgrof@kernel.org>, <gost.dev@samsung.com>,
        <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] filemap: remove page_endio()
Date:   Wed, 10 May 2023 14:47:16 +0200
Message-ID: <20230510124716.73655-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7phk6JTDP4cU7WYs34Nm8XK1UeZ
        LPbsPclicXnXHDaLe2v+s1rcmPCU0eL3jzlsDuwem1doeWxa1cnmsenTJHaPEzN+s3jsvtnA
        5vF5k1wAWxSXTUpqTmZZapG+XQJXxqPJ55kLXvBXzHrSxtLA+Jeni5GTQ0LARKKh9zNbFyMX
        h5DACkaJ9gdH2SGcL4wSs98sY4JwPjNKdMzYzQjTsvzoP6jEckaJvu/H2OCq5s99DpXZwigx
        ceJR1i5GDg42AS2Jxk52kG4RATOJjQ+OMILUMAvsAxp75SIzSEJYQFdi5c8mVhCbRUBV4s7P
        XywgNq+ApUTLknawORIC8hKLH0hAhAUlTs58AlbCDBRu3jqbGcKWkDj44gUzxKVKEg2bz7BA
        2LUSe5sPgP0mIXCHQ+Jt30tWiISLxJNrk5ggbGGJV8e3sEPYMhKnJ/dANVdLPL3xmxmiuYVR
        on/nejaIg6wl+s7kQNQ4Stxo+wh1J5/EjbeCEPfwSUzaNp0ZIswr0dEmBFGtJrH63huWCYzK
        s5B8MwvJN7OQfLOAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYNo5/e/41x2MK159
        1DvEyMTBeIhRgoNZSYTXOzQqRYg3JbGyKrUoP76oNCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU
        1ILUIpgsEwenVAOT3+MWRrsrXfmSMd82T1vw+NTWH08ZVCsS5Y1+ajWyb/tXVFjs0Mh2SfvJ
        JiXvkG9Cr7V42KWYRBR+HlnLFBEvr1fN/r8xwz3I2Uqi5IlO1LcC/nDJ/X8eTMnS/MMR+G7P
        /dtTbVurKlzWfnevXiaXW3dm+YU/Olbz310VSk5yaHyinl38/H4qD2+bsgafUpDRzmrJXxrT
        H/DEKmhnRJy28XtlyPA98M73HZKnDH9Ne/XKpEcwYdXJBcty13P80zXufiOQtDFK+kngrdge
        13V6tRkHS1Y38loHWR1qKvXkrF8rLOwfcZBx+zfDmA62Y8YxWos8/60XKVNYPCHaof1vq4xh
        lZTU1705j5t2K7EUZyQaajEXFScCAH8a3AaqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7phk6JTDH5eF7aYs34Nm8XK1UeZ
        LPbsPclicXnXHDaLe2v+s1rcmPCU0eL3jzlsDuwem1doeWxa1cnmsenTJHaPEzN+s3jsvtnA
        5vF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+
        XYJexqPJ55kLXvBXzHrSxtLA+Jeni5GTQ0LARGL50X9MXYxcHEICSxklZnWtYoRIyEhs/HKV
        FcIWlvhzrYuti5EDqOgjo8Q+IYj6LYwSB55OYASJswloSTR2soOUiwiYSWx8cIQRpIZZYB+j
        RMeVi8wgCWEBXYmVP5vAZrIIqErc+fmLBcTmFbCUaFnSzgoyR0JAXmLxAwmIsKDEyZlPwEqY
        gcLNW2czQ9gSEgdfvGCGOE1JomHzGRYIu1ai89VptgmMQrOQtM9C0j4LSfsCRuZVjCKppcW5
        6bnFhnrFibnFpXnpesn5uZsYgRG27djPzTsY5736qHeIkYmD8RCjBAezkgivd2hUihBvSmJl
        VWpRfnxRaU5q8SFGU6B3JjJLiSbnA2M8ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7
        NbUgtQimj4mDU6qBqXJ25HWjyReSav9GXDrYat24Mrdy2RUNls0HmyXnrDN59OFyyfYcb4v5
        Mtf+7u9ftu1sQ5/ceqa7sWmX14mIntSTLjjHKrORuyzhkOR20bTvQW7/L2+V1Ki+dtTaaLfG
        aRvmK4LpE1TXl5grbXl/rMgsJZBrg6jdMtbajCALg69FsZMEzvsfUpPV1C5xbH3UnHHmwYdz
        N/bN0Vjuz35f56zAqis7Nqxfp2hfHJQgHNrzOIovimuvmojkrLbYFRFCXFdCPjNGSDHtXuff
        OvuDIfPtDT6TTp7TaH3/Zm7T6w8GLPyOL3bmhx5dtGaB0G8Jne0xKl51RV/3rv0VqLDi1Rq/
        JZzsen0X0mb8sa3ap8RSnJFoqMVcVJwIAD8TcA45AwAA
X-CMS-MailID: 20230510124718eucas1p2c11356c0628b9acb44c1174fd45fa4b7
X-Msg-Generator: CA
X-RootMTR: 20230510124718eucas1p2c11356c0628b9acb44c1174fd45fa4b7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230510124718eucas1p2c11356c0628b9acb44c1174fd45fa4b7
References: <CGME20230510124718eucas1p2c11356c0628b9acb44c1174fd45fa4b7@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

page_endio() is not used anymore. Remove it.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
This is a leftover patch from [1]. As ZRAM page_endio usage has been
removed, this patch can be merged safely.
[1]https://lore.kernel.org/linux-fsdevel/20230411122920.30134-1-p.raghav@samsung.com/

 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 30 ------------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..c1ae5ebc375f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1078,8 +1078,6 @@ int filemap_migrate_folio(struct address_space *mapping, struct folio *dst,
 #else
 #define filemap_migrate_folio NULL
 #endif
-void page_endio(struct page *page, bool is_write, int err);
-
 void folio_end_private_2(struct folio *folio);
 void folio_wait_private_2(struct folio *folio);
 int folio_wait_private_2_killable(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index 2d3d70c64dfd..570bc8c3db87 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1628,36 +1628,6 @@ void folio_end_writeback(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_end_writeback);
 
-/*
- * After completing I/O on a page, call this routine to update the page
- * flags appropriately
- */
-void page_endio(struct page *page, bool is_write, int err)
-{
-	struct folio *folio = page_folio(page);
-
-	if (!is_write) {
-		if (!err) {
-			folio_mark_uptodate(folio);
-		} else {
-			folio_clear_uptodate(folio);
-			folio_set_error(folio);
-		}
-		folio_unlock(folio);
-	} else {
-		if (err) {
-			struct address_space *mapping;
-
-			folio_set_error(folio);
-			mapping = folio_mapping(folio);
-			if (mapping)
-				mapping_set_error(mapping, err);
-		}
-		folio_end_writeback(folio);
-	}
-}
-EXPORT_SYMBOL_GPL(page_endio);
-
 /**
  * __folio_lock - Get a lock on the folio, assuming we need to sleep to get it.
  * @folio: The folio to lock
-- 
2.39.2


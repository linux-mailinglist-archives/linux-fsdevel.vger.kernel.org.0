Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0846CBD8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 13:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjC1L1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 07:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjC1L13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:27:29 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D38CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 04:27:26 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230328112722euoutp019a8c408b220bfcab09601b68c6317966~Qka8_B1m40435404354euoutp01t
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:27:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230328112722euoutp019a8c408b220bfcab09601b68c6317966~Qka8_B1m40435404354euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680002842;
        bh=Qd/EHq/hNi9U0eDQzSkYHva3vzVuhQ3/uVr2IhrtsQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drjE9jpUzOwvKJrVY1iPOEPDBI27vBqwRWG6il8vuZYyNEyvF6xBLiF4Bd4xSnZkc
         khY2nUF+KDemqhNUQEnNdRD902LjMfSzeHSnDrTvdNr8Q8xVYscrY9hnWflP+iFEkz
         Afy6ntAMmTCyit7LuLu7bVEafMfaYQvM4EaRrdX4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230328112721eucas1p29c3e5a9281c3f21042a2ffafdd0866eb~Qka7TOoBk2371323713eucas1p2a;
        Tue, 28 Mar 2023 11:27:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 38.51.09503.81FC2246; Tue, 28
        Mar 2023 12:27:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230328112720eucas1p2bbb42b49da00b4f2299049bf6bafce48~Qka65Z-hg0535105351eucas1p2X;
        Tue, 28 Mar 2023 11:27:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230328112720eusmtrp2ce3dc34f33115a65d99589fcad9b4c0a~Qka63UKs50134701347eusmtrp2U;
        Tue, 28 Mar 2023 11:27:20 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-80-6422cf18967a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.81.09583.81FC2246; Tue, 28
        Mar 2023 12:27:20 +0100 (BST)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230328112720eusmtip2188f4b42b34ffb070ff5ffc1e476b9e4~Qka6sYigr0132101321eusmtip28;
        Tue, 28 Mar 2023 11:27:20 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     martin@omnibond.com, axboe@kernel.dk, minchan@kernel.org,
        akpm@linux-foundation.org, hubcap@omnibond.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 5/5] filemap: remove page_endio()
Date:   Tue, 28 Mar 2023 13:27:16 +0200
Message-Id: <20230328112716.50120-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328112716.50120-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djPc7oS55VSDN5ftLaYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjuKySUnNySxLLdK3S+DKeNs9i7VgHl/F
        +vsfGBsYz3J3MXJySAiYSPzddpipi5GLQ0hgBaPEqZNXGUESQgJfGCUuX7CCSHxmlFi37gYj
        TMeOt//ZIRLLGSVWt79hhHBeMkqsfTOPuYuRg4NNQEuisROsSETgDKPE4uWNbCAOs8B9Rolv
        L88zgYwSFjCUWDH3CZjNIqAqsXzuOzYQm1fAUmLD9IssEOvkJfYfPAs2lFPASmLabyuIEkGJ
        kzOfgJUwA5U0b53NDDJfQmA1p8S8C49ZIXpdJG5828AEYQtLvDq+hR3ClpH4v3M+VLxa4umN
        31DNLYwS/TvXs4EskxCwlug7kwNiMgtoSqzfpQ9R7ijRd2MlI0QFn8SNt4IQJ/BJTNo2nRki
        zCvR0SYEUa0ksfPnE6ilEhKXm+ZAPeUhcWz3JfYJjIqzkDwzC8kzsxD2LmBkXsUonlpanJue
        WmyYl1quV5yYW1yal66XnJ+7iRGYAk//O/5pB+PcVx/1DjEycTAeYpTgYFYS4d3srZgixJuS
        WFmVWpQfX1Sak1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1OqgWnhq0ct997f5QqV
        ebnEf/WulTx8M0NPeZvyVFit3O7yK/yj8Z8v01cHffgxg9Psn62CsmHS6z6t+mk6qecuaF+r
        WxLlGjxpo7HWscVPw9M22CmcEr6VeLaDR/dr/Oaol+I9/+t+S/12XvB9Bn/nZpsvpjUFDRa8
        p5afeL9raeVKnQVXl1X19jVdM7WsfHH1w4dfKYLNGvtv5jtXdyafjCrz/fbrJVfaD0XhD7d6
        XsqJOP55tKLXOeWIQtWDJOXjVw0NnR3+9BzdXRx+2uvo08aYls0/hBv6tgb9MmvY9Wza2eAc
        1VP22oYVB6f43m696b6hsf22g0ye63vfh8tlTSbd3FS4VOyKXi1z9MYjV3KUWIozEg21mIuK
        EwHKEU1A8AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7oS55VSDKY+VLSYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjtKzKcovLUlVyMgvLrFVija0MNIztLTQ
        MzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeNs9i7VgHl/F+vsfGBsYz3J3MXJySAiYSOx4
        +5+9i5GLQ0hgKaPEsekrGSESEhK3FzZB2cISf651sUEUPWeUWDGvC6iDg4NNQEuisROsWUTg
        BqPE2qe/WEEcZpCiu/tes4J0CwsYSqyY+4QJxGYRUJVYPvcdG4jNK2ApsWH6RRaIDfIS+w+e
        ZQYZyilgJTHttxVIWAio5OqZ94wQ5YISJ2c+AStnBipv3jqbeQKjwCwkqVlIUgsYmVYxiqSW
        Fuem5xYb6RUn5haX5qXrJefnbmIExuu2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrybvRVThHhT
        EiurUovy44tKc1KLDzGaAp09kVlKNDkfmDDySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNL
        UrNTUwtSi2D6mDg4pRqYNJN2fz/6QVTltN8ZF97WlRk3LhiW3Gc8ad27onHbTaaClaem7VN7
        7lAqpSIsl116c96/MOvOhUt3ph+ds/2soKH+l3uvF9q9YpXl5FVp0lv5+zsPy6cX+ctZ7ghn
        PDLSjRL3Mpzx+F/biQX9fZb1fJOWicQKnVx2Zp7StQBd3Rm+Rco73+mGHr7OL2Mr87HVXNym
        8saWVzU/Hk18ULqxwEm2SZ1nelPnFP2V/fynJmsYnefq/Zox61Ak85/w9MVuh0IL9/xKE534
        5cDE8vAnqo+XBObzHa0+/fCj1INph7ZkXOlVZA5+Gn9ONL51BssFI/0Gsdvn4yXm2Ga0MQvP
        2xTsycD/VbS//bH6rMJ0JZbijERDLeai4kQAvVarymADAAA=
X-CMS-MailID: 20230328112720eucas1p2bbb42b49da00b4f2299049bf6bafce48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230328112720eucas1p2bbb42b49da00b4f2299049bf6bafce48
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230328112720eucas1p2bbb42b49da00b4f2299049bf6bafce48
References: <20230328112716.50120-1-p.raghav@samsung.com>
        <CGME20230328112720eucas1p2bbb42b49da00b4f2299049bf6bafce48@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

page_endio() is not used anymore. Remove it.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 30 ------------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fdcd595d2294..73ee6ead90dd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1076,8 +1076,6 @@ int filemap_migrate_folio(struct address_space *mapping, struct folio *dst,
 #else
 #define filemap_migrate_folio NULL
 #endif
-void page_endio(struct page *page, bool is_write, int err);
-
 void folio_end_private_2(struct folio *folio);
 void folio_wait_private_2(struct folio *folio);
 int folio_wait_private_2_killable(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index 6f3a7e53fccf..a770a207825d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1625,36 +1625,6 @@ void folio_end_writeback(struct folio *folio)
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
2.34.1


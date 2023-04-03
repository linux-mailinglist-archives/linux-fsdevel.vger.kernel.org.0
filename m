Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29D96D4591
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjDCNWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 09:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDCNWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:22:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFF4D1
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 06:22:31 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230403132227euoutp02aa305be746b2445e2a0ed661aec2826a~Sb3JgdzQ31374713747euoutp02w
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 13:22:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230403132227euoutp02aa305be746b2445e2a0ed661aec2826a~Sb3JgdzQ31374713747euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680528148;
        bh=Qd/EHq/hNi9U0eDQzSkYHva3vzVuhQ3/uVr2IhrtsQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGRaqrsHJe/tM105jDHB0ftOz4tp9ykwUxKohoKXQeZyo/fTZFWFs7pnTJgch+XaC
         wL30I+NBkQCi7jwOHC0BVgsqKS06FTu2EMa4YOhiV+gpeTOSStNq5avdwfH/LZxBth
         /X293VQRjzjIueCXtZeJnU/zJdCzUIg7CEnR4EaQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230403132226eucas1p225350ac5d8a5d0d5516b7d1cf8fb6e30~Sb3ILi-3G1849718497eucas1p2G;
        Mon,  3 Apr 2023 13:22:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3D.F2.09966.213DA246; Mon,  3
        Apr 2023 14:22:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230403132226eucas1p182e09f5da7bc0bd284d6a8494cd40903~Sb3HzyLKr0206102061eucas1p1D;
        Mon,  3 Apr 2023 13:22:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230403132226eusmtrp2a7dbad3b8c19268ae7c0dcce1a593f16~Sb3HyusYY0200802008eusmtrp2Q;
        Mon,  3 Apr 2023 13:22:26 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-4b-642ad3126dbf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.ED.09583.113DA246; Mon,  3
        Apr 2023 14:22:26 +0100 (BST)
Received: from localhost (unknown [106.210.248.30]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230403132225eusmtip27a6506bf3fe6270d1a4735114f57705d~Sb3HhyA592060320603eusmtip2R;
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
Subject: [PATCH v2 5/5] filemap: remove page_endio()
Date:   Mon,  3 Apr 2023 15:22:21 +0200
Message-Id: <20230403132221.94921-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403132221.94921-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87pCl7VSDPquylrMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBYrVx9lsmi/28dksfeWtsWevSdZLC7vmsNmcW/Nf1aLk+v/M1vc
        mPCU0WLZ1/fsFp+XtrBb7N64iM3i/N/jrBa/f8xhcxDymN1wkcVj8wotj8tnSz02repk89j0
        aRK7x4kZv1k8GqbeYvPYfbOBzePX7TusHn1bVjF6fN4k57HpyVumAJ4oLpuU1JzMstQifbsE
        roy33bNYC+bxVay//4GxgfEsdxcjJ4eEgInE3VlvGLsYuTiEBFYwSjQ+XMvexcgB5HxhlOgM
        A6kREvjMKHFkth5M/bK+OUwQ9csZJe4f2gzV/IJRYv7BJYwgzWwCWhKNnewgcRGBW4wSb3pm
        g3UwC9xnlJi3ey8TyChhoFEdTzexgdgsAqoSy1a2gdm8ApYSSz+/YYJYJy+x/+BZZhCbU8BK
        onH6XEaIGkGJkzOfsIDYzEA1zVtnM4MskBDYzimxZNJmZpArJARcJDY+TIaYIyzx6vgWdghb
        RuL/zvlQ86slnt74DdXbwijRv3M9G0SvtUTfmRwQk1lAU2L9Ln2IckeJBW/vQ03nk7jxVhDi
        Aj6JSdumQ4V5JTrahCCqlSR2/nwCtVRC4nLTHBYI20Oi4d1JpgmMirOQ/DILyS+zEPYuYGRe
        xSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZgST/87/mUH4/JXH/UOMTJxMB5ilOBgVhLh
        Ve3SShHiTUmsrEotyo8vKs1JLT7EKM3BoiTOq217MllIID2xJDU7NbUgtQgmy8TBKdXAVPVB
        2jnXXPIek2HW7FY540knNwrvXf1fqUwpeQYvv1q25uS1TprezWLzTGXXrVrzpdui0S1H9Pd7
        9ylyR43OfJntN6n4DXecy/qTmck/9/49fdut8FXkl3PxC2ZH2nxW5vc815S32SS1NX9FCZ/A
        7KfTdnBObiu/MydR+tdjjfCNZ2+95tsyR+eO+ZNqvnyRKUX7yzjKY3/E9fx5dvv5HE2vdbO4
        8yv7rrw873AraWHBaq+Ap+9fWE5z1izR6PJoOHm+zGTd8QV7th94NuXUtnk8H5IqHeqnPP1w
        RsQy6puBSY95mdj7osCDq7gO+GXcU1Mr/rhJKnBuebrfUs5Dx47Y8lWtZb3TWWqmPmffViWW
        4oxEQy3mouJEAPWTzgX4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7pCl7VSDA4tZ7KYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlvu2exFszjq1h//wNjA+NZ
        7i5GTg4JAROJZX1zmLoYuTiEBJYySpxumsEIkZCQuL2wCcoWlvhzrYsNxBYSeMYosfBuYRcj
        BwebgJZEYyc7SK8ISHjZheMsIA6zwHNGiTVTfjODNAgDbeh4ugmsmUVAVWLZyjYwm1fAUmLp
        5zdMEAvkJfYfPAtWzylgJdE4fS4jxDJLia8Xb7FC1AtKnJz5hAXEZgaqb946m3kCo8AsJKlZ
        SFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbwtmM/t+xgXPnqo94hRiYOxkOMEhzM
        SiK8ql1aKUK8KYmVValF+fFFpTmpxYcYTYHunsgsJZqcD0wieSXxhmYGpoYmZpYGppZmxkri
        vJ4FHYlCAumJJanZqakFqUUwfUwcnFINTDxHo9drrbvzV2V7wYpNCa1enCkzFmk4ye/O3tt2
        XNxmio7Sy+bzieunTODQaLq12+xdiq7KcgnV9Jv+/GuNzkz7fl+5TTxkV+C32iyf+OZLfayL
        w9j62y/PXdQ+mZmh6FOcgeDbk89FDtw9kLbQAJgO+2wiHBwOdKdck77HvXr3igD22NeSFqIT
        +3d3Oi1SXPJ+99V3p1ga+I3ktzTY1ii2GSvseHLk2se/JpcFbmnsktac03jnfvqVRU+t5/9e
        FTz9rOjiFXaLU0wbXs5rD5q0/oLxNstP87YZla85rvr7Hcd0kdOemx9Gq+xUu7/tt+otkU0Z
        9eUGs+OipGXvmM5p2hE841RwQ8HlmCX79ZVYijMSDbWYi4oTAWqlwddqAwAA
X-CMS-MailID: 20230403132226eucas1p182e09f5da7bc0bd284d6a8494cd40903
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230403132226eucas1p182e09f5da7bc0bd284d6a8494cd40903
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230403132226eucas1p182e09f5da7bc0bd284d6a8494cd40903
References: <20230403132221.94921-1-p.raghav@samsung.com>
        <CGME20230403132226eucas1p182e09f5da7bc0bd284d6a8494cd40903@eucas1p1.samsung.com>
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


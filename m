Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE06C4C67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 14:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjCVNvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjCVNvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:51:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A005D75C
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 06:50:46 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230322135020euoutp0113e7ce017b3ee951f426c540acd330a7~OwgEHCQey1803618036euoutp01L
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 13:50:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230322135020euoutp0113e7ce017b3ee951f426c540acd330a7~OwgEHCQey1803618036euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679493020;
        bh=Qd/EHq/hNi9U0eDQzSkYHva3vzVuhQ3/uVr2IhrtsQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJmJT4/TDHDQkIqtbVSMoahNTDwVKD1u4vrCHnRXcUm63vWUcZ+RGNJzDFvbLlc0V
         6z5abCG9rWAFXS9+BMc1UvhiwMd1V3GY5dCE99DNVCd2MHxpcFaDDuC/Y+xsZsdjBC
         LOTBVHFCv32cWVZ6WYvSmWiesLszDxGcA9ywsTbI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230322135018eucas1p25c3a3715ad75a1e888ca3a12b22cd7e0~OwgCe8JE70616106161eucas1p2d;
        Wed, 22 Mar 2023 13:50:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.94.09503.A970B146; Wed, 22
        Mar 2023 13:50:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230322135018eucas1p2dd82762cf7d2c0c5b5482a1d150ba369~OwgCAskCN0614706147eucas1p21;
        Wed, 22 Mar 2023 13:50:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230322135018eusmtrp258a3a526308b718ec79346250679f051~OwgB--C8t0726007260eusmtrp2M;
        Wed, 22 Mar 2023 13:50:18 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-e7-641b079ac88c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.6E.09583.A970B146; Wed, 22
        Mar 2023 13:50:18 +0000 (GMT)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230322135018eusmtip2b06034e3955f717af8c7e270000bacfb~OwgBwcMLu2805428054eusmtip2B;
        Wed, 22 Mar 2023 13:50:18 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        willy@infradead.org, brauner@kernel.org, akpm@linux-foundation.org,
        minchan@kernel.org, hubcap@omnibond.com, martin@omnibond.com
Cc:     mcgrof@kernel.org, devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 5/5] filemap: remove page_endio()
Date:   Wed, 22 Mar 2023 14:50:13 +0100
Message-Id: <20230322135013.197076-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322135013.197076-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7qz2KVTDL6/NbeYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjuKySUnNySxLLdK3S+DKeNs9i7VgHl/F
        +vsfGBsYz3J3MXJySAiYSMy/fZW5i5GLQ0hgBaPEnb0TWCGcL4wSfYeuMEI4nxkl9s57xATT
        smjxH6iq5YwSN+cfYYFwXjJKHD+8mr2LkYODTUBLorGTHSQuInCGUWJK0wxGkG5mgfuMEqf3
        soDYwgJGEl0LVoDZLAKqEu+WPGcHsXkFrCSmbwK5A2SbvMT+g2eZQWxOAWuJR4umsUHUCEqc
        nPmEBWKmvETz1tlgT0gIrOaUWDTlHQtEs4vEnWMvmSFsYYlXx7ewQ9gyEv93zod6p1ri6Y3f
        UM0tjBL9O9ezgXwgAbSt70wOiMksoCmxfpc+RLmjxO8nR5khKvgkbrwVhDiBT2LStulQYV6J
        jjYhiGoliZ0/n0AtlZC43DQH6jAPiR/377JMYFScheSZWUiemYWwdwEj8ypG8dTS4tz01GLD
        vNRyveLE3OLSvHS95PzcTYzAJHj63/FPOxjnvvqod4iRiYPxEKMEB7OSCK8bs0SKEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcV5t25PJQgLpiSWp2ampBalFMFkmDk6pBqb+t7ndbze/rGjIOBr+
        Ue/T/g8yjJzzRfPKb92tTzhzsbHi3XHuq/vcJy7v+cBx46mSsbLwn8sOJ39v3Vm15PbhspcT
        55ltqOLlbbUJnRaumGpzW37vrkmFhxyTOY6yHJU9oljxTYnbqb+AbfNOeZ2ESY7Nj374LfP/
        d+e74kSGr56r092azvGkx0/73HHl5buEV9u9qwxm5q5bwD/LnNe4o3WpiwFr5priKp43J7tf
        WOpv2qHh6bZkRmHKHJtmsVkKt/Z37I2XrrZ6I8F02ldbyGKjQ7vi46UfOOd/9iieaKBfLiz7
        vO/rWdVvr3+GNHz7EdtwWu3Jgt2emRpTjip+nRzE3/xqZcjT4/7is6OUWIozEg21mIuKEwF3
        fQZ+8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7qz2KVTDOb0S1rMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBbtd/uYLPbe0rbYs/cki8XlXXPYLO6t+c9qcXL9f2aLGxOeMlos
        +/qe3eLz0hZ2i90bF7FZnP97nNXi9485bA6CHrMbLrJ4bF6h5XH5bKnHplWdbB6bPk1i9zgx
        4zeLR8PUW2wev27fYfXo27KK0ePzJjmPTU/eMgVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlro
        GZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlvO2exVowj69i/f0PjA2MZ7m7GDk5JARMJBYt
        /sPaxcjFISSwlFFi5bvfTBAJCYnbC5sYIWxhiT/XuthAbCGB54wS6/r9uxg5ONgEtCQaO9lB
        wiICNxgl2lfpgcxhBim5/HQ2M0hCWMBIomvBChYQm0VAVeLdkudgDbwCVhLTN01ghZgvL7H/
        4Fmwek4Ba4lHi6ZB7bKSuLx/EitEvaDEyZlPwOYwA9U3b53NPIFRYBaS1CwkqQWMTKsYRVJL
        i3PTc4uN9IoTc4tL89L1kvNzNzECo3XbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEV43ZokUId6U
        xMqq1KL8+KLSnNTiQ4ymQHdPZJYSTc4Hpou8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS
        1OzU1ILUIpg+Jg5OqQamqAs7O4KSZc9I+En2a19JXN/2+fsCjTPheYaHv2xWUWgSVvnxM475
        e/Up5SRhl6arN3Mq9k6//Vh1355v6jNV/X6fqC49d2vWhNjVZhXrfnAWvvNMX3WDzfj8FJmU
        2+WJi9/0s99eX1ontXpC/5Sv5/afvKp45snlrrgnt+7MS1ukVxNnsvZbjO7OPr6uT56L46bp
        Wc6UCtrKnBXne/zZjwdu8ZWM4rU65s/m3NVlvv2m8qSVTjb/0otFflXvH9hZ1YRGH9sYe613
        yVmHW3OmvLF93rND7clW+/rl5yVjPq/bfdYk7wDP0kIx8xn9YlnelwojX+9LsghMaJZo+G51
        u6KUzfdsfiaH2EErXptyJZbijERDLeai4kQAusTwxl8DAAA=
X-CMS-MailID: 20230322135018eucas1p2dd82762cf7d2c0c5b5482a1d150ba369
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230322135018eucas1p2dd82762cf7d2c0c5b5482a1d150ba369
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135018eucas1p2dd82762cf7d2c0c5b5482a1d150ba369
References: <20230322135013.197076-1-p.raghav@samsung.com>
        <CGME20230322135018eucas1p2dd82762cf7d2c0c5b5482a1d150ba369@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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


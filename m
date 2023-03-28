Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99C86CBD95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 13:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjC1L1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjC1L1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:27:30 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B21725
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 04:27:28 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230328112722euoutp02a31a09c71ba1093b67231acd859d3ed6~Qka824Hpg3247732477euoutp02n
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:27:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230328112722euoutp02a31a09c71ba1093b67231acd859d3ed6~Qka824Hpg3247732477euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680002842;
        bh=C4y5H34/b66lYzmCayiry+Dr/iI1gotrFjxRhbqI+PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOQeOheNVR3TOZRUeQLXiB9Fxu+PcuYHKieaWtx2g3+sxEx86tj7vwcSVUFDblKMz
         Vj9tVHIZqhGlVhs5bIfLHmUm6Q8p7o9xtBiSeHx+scxD1HY0YSnL9ots26OszOY10S
         VMBk19gD3UFgy+dC35ln638RaAPyCp6CALsLljU8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230328112720eucas1p208a91e75a4df810cf7dd3781ee8559e2~Qka7MHLqp0948509485eucas1p2J;
        Tue, 28 Mar 2023 11:27:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 07.51.09503.81FC2246; Tue, 28
        Mar 2023 12:27:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230328112720eucas1p1148c03b8664f6c212c7189454a36b796~Qka6blNGF1794717947eucas1p1w;
        Tue, 28 Mar 2023 11:27:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230328112720eusmtrp269ad4302d80bafe5b32231e8e7b2f8b3~Qka6a46bI0134701347eusmtrp2R;
        Tue, 28 Mar 2023 11:27:20 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-7e-6422cf189df9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.71.09583.71FC2246; Tue, 28
        Mar 2023 12:27:20 +0100 (BST)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230328112719eusmtip21f0b4a5953ca974547d94cb63d3c29a0~Qka6Ka8Ob2590125901eusmtip2_;
        Tue, 28 Mar 2023 11:27:19 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     martin@omnibond.com, axboe@kernel.dk, minchan@kernel.org,
        akpm@linux-foundation.org, hubcap@omnibond.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 4/5] mpage: use folios in bio end_io handler
Date:   Tue, 28 Mar 2023 13:27:15 +0200
Message-Id: <20230328112716.50120-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328112716.50120-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djPc7oS55VSDK73mlrMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBbtd/uYLPbe0rbYs/cki8XlXXPYLO6t+c9qcXL9f2aLGxOeMlos
        +/qe3eLz0hZ2i90bF7FZnP97nNXi9485bA6CHrMbLrJ4bF6h5XH5bKnHplWdbB6bPk1i9zgx
        4zeLR8PUW2wev27fYfXo27KK0ePzJjmPTU/eMgVwR3HZpKTmZJalFunbJXBlLHh5iaVgAm/F
        n0v72BoY73B1MXJySAiYSNxdco+9i5GLQ0hgBaPE3R9TGCGcL4wSDw88hHI+M0rc2H+WCabl
        7YwNLCC2kMByRokj32Igil4ySqzufA+U4OBgE9CSaOwEGysicIZRYvHyRjYQh1ngPqPEt5fn
        wSYJC9hI/Ft/ghHEZhFQlWj83sEKYvMKWEqcmjmPDWKbvMT+g2eZQYZyClhJTPttBVEiKHFy
        5hOwI5iBSpq3zmYGmS8hsJpTYt2ebhaIXheJg3t3Q10tLPHq+BZ2CFtG4v/O+VDxaomnN35D
        NbcwSvTvXM8GskxCwFqi70wOiMksoCmxfpc+RLmjRPeBc0wQFXwSN94KQpzAJzFp23RmiDCv
        REebEES1ksTOn0+glkpIXG6aA3WYh8S7xm3sExgVZyF5ZhaSZ2Yh7F3AyLyKUTy1tDg3PbXY
        MC+1XK84Mbe4NC9dLzk/dxMjMAWe/nf80w7Gua8+6h1iZOJgPMQowcGsJMK72VsxRYg3JbGy
        KrUoP76oNCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU1ILUIpgsEwenVAOThLLt5OUcTX9E5VRj
        LlxZEpZlfk58h/HiR0+mNf97UlP+3+/OxIoLR1telpy5IK1kK3/DJaP692n/LXavDS7xFvxh
        2Salu+Gim3vSimvnL99+fVnZ9GVKiOD7rJMTZzyNl1UtK/D+eVNo16cK7m2yKZ6f3iWGHj30
        1NNwUvL1+8yHZhy8nNDS1qty0Of1194lDEcvh6T1C/4/Y/Zfqfj67kZfy69tTC2CqSo/cppL
        V12KzPr3a7vvqc+VIpn7FvouamR7laK+w2Ni3JSDZ30UONxbN2Ww3ztq09/w8AKv9KzkrZ2K
        Uzcpiz96cSKav8tLNp3bdVmwiGV75JmYyyovXzEFPKl9r5Etefk3A+9HJZbijERDLeai4kQA
        /LdiXPADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7oS55VSDDbMZrKYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjtKzKcovLUlVyMgvLrFVija0MNIztLTQ
        MzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWPDyEkvBBN6KP5f2sTUw3uHqYuTkkBAwkXg7
        YwNLFyMXh5DAUkaJV09es0IkJCRuL2xihLCFJf5c62KDKHrOKHF/7n+gIg4ONgEticZOdpC4
        iMANRom1T3+xgjjMIEV390FMEhawkfi3/gTYJBYBVYnG7x1gcV4BS4lTM+exQWyQl9h/8Cwz
        yFBOASuJab+tQMJCQCVXz7xnhCgXlDg58wkLiM0MVN68dTbzBEaBWUhSs5CkFjAyrWIUSS0t
        zk3PLTbSK07MLS7NS9dLzs/dxAiM123Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeDd7K6YI8aYk
        VlalFuXHF5XmpBYfYjQFOnsis5Rocj4wYeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5ak
        ZqemFqQWwfQxcXBKNTAlPHR9UXHFs9y11PaUL7v3dQnTfoFVp6P17f9F+Hx/LfOS+0W3jGj7
        LDbGQ9sXXtX8XewT+m3J9YN1M2ZbKM3KWuj0yvb4Iiv+CUITebjP+X+Oj1DLMYh8vXH3SwOG
        H12pkpuOXl124ov8MTuWtKNZBz71HPin5Nm53LnskUXbrDn9olknAjLim49779Ap3p+xfoK2
        w+XqWR8EJdY4ZrfwGER9qnGX331c4I+f5XrmlbvfNTZcqUzPWph3S5wnvLLmpXqC+KkHzuZX
        Xj23LzoTJWfLdL7twZOUTsOSrwu6V2r3VcbNEC+Xcur3zO/bwJjZcG1d/sZf19l36vJZ3d34
        9u7iY0o/5jqG7/edP0WJpTgj0VCLuag4EQAOWOnYYAMAAA==
X-CMS-MailID: 20230328112720eucas1p1148c03b8664f6c212c7189454a36b796
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230328112720eucas1p1148c03b8664f6c212c7189454a36b796
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230328112720eucas1p1148c03b8664f6c212c7189454a36b796
References: <20230328112716.50120-1-p.raghav@samsung.com>
        <CGME20230328112720eucas1p1148c03b8664f6c212c7189454a36b796@eucas1p1.samsung.com>
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116046BB23C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 13:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjCOMeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 08:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjCOMeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:34:04 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD159F06B
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 05:32:46 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230315123238euoutp02e21dbfadc49e45e717255deebf1fbe50~Ml7NzwvOK2839728397euoutp02P
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 12:32:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230315123238euoutp02e21dbfadc49e45e717255deebf1fbe50~Ml7NzwvOK2839728397euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678883558;
        bh=TULy0kQ0Ifdivo2QO7TanxedWWhPvjo0gfRuQDzW2ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WG5nv/yIUioUZMemmI/vXGBGCC4mPMP4y7q7hrLObungT2ku5O7R3EVoS3PfQSHj3
         I8MTWMnapaCRQJHG/BY21xHO7gKzTp9LHWWniksNA49VFZcApTLwGa93cuuQGrIhsO
         o/AjQ5qm6e1N7LRsiufjhXZOGYU4eNMfrw8QvWkw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230315123236eucas1p26b7742c95fa09b82c73c845d74efce5e~Ml7MbQpp61818518185eucas1p2w;
        Wed, 15 Mar 2023 12:32:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 21.94.10014.4EAB1146; Wed, 15
        Mar 2023 12:32:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230315123236eucas1p1116e1b8537191310bd03dd267b9f8eb8~Ml7MCxzO32770827708eucas1p15;
        Wed, 15 Mar 2023 12:32:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230315123236eusmtrp1df4436f51fa48eb1490ddbb6b35c616f~Ml7MBtYA-1056310563eusmtrp13;
        Wed, 15 Mar 2023 12:32:36 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-6e-6411bae42153
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.BF.09583.4EAB1146; Wed, 15
        Mar 2023 12:32:36 +0000 (GMT)
Received: from localhost (unknown [106.210.248.172]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230315123235eusmtip24e5b07e7103e1457f04af28b9d08add0~Ml7LyK5g50183701837eusmtip2M;
        Wed, 15 Mar 2023 12:32:35 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hubcap@omnibond.com, senozhatsky@chromium.org, martin@omnibond.com,
        willy@infradead.org, minchan@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, mcgrof@kernel.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC PATCH 3/3] orangefs: use folio in orangefs_readahead()
Date:   Wed, 15 Mar 2023 13:32:33 +0100
Message-Id: <20230315123233.121593-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315123233.121593-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87pPdgmmGOz8o2gxZ/0aNovVd/vZ
        LF4f/sRosX/zFCaLmwd2Mlm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovPS1vYLXZvXMRmcf7vcVaL3z/msDkIesxuuMjisXmFlsfls6Uem1Z1snls+jSJ3ePE
        jN8sHg1Tb7F5/Lp9h9Wjb8sqRo/Pm+Q8Nj15yxTAHcVlk5Kak1mWWqRvl8CVceTGE8aCPRwV
        Px+zNjB+Y+ti5OSQEDCRWNYxkRXEFhJYwSjx4112FyMXkP2FUWLzvodsEM5nRokHH1qZYTr+
        7L/GBNGxnFFie781RNFLRokD6x8DdXBwsAloSTR2soPERQTOMEo8aZkINolZ4D6jxPWm3+wg
        3cICLhIXN60Bm8oioCpx78tnMJtXwEqi4clLqPvkJfYfPAsW5xSwlli9cjobRI2gxMmZT1hA
        bGagmuats5lBFkgIrOaU+PH5GdSpLhJ3n+1ggbCFJV4d38IOYctInJ7cAxWvlnh64zdUcwuj
        RP/O9WAvSABt6zuTA2IyC2hKrN+lD1HuKNF19wk7RAWfxI23ghAn8ElM2jadGSLMK9HRJgRR
        rSSx8+cTqKUSEpeb5kAt9ZB40zCLfQKj4iwkz8xC8swshL0LGJlXMYqnlhbnpqcWG+ellusV
        J+YWl+al6yXn525iBCbA0/+Of93BuOLVR71DjEwcjIcYJTiYlUR4w1kEUoR4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUwGR58dUekeLrKqb/3VyxlWj5d
        gvlVQ1Dcpqkp8j2JQd05qp93iWjvvTLvv/jk2vQ7eZXGVvcv/X3FulJ0ewv3RY63PAXXfutE
        l1kHa/0RN4vfp/rnr7KtyUmtn7VOxcy/Bfdo9d04PX+nvNmtnUut26wizp7kerZ7YtbdjkLu
        qg+5hm+rVrjMFEsLLetvdGssu7w7T/1a5x6Phcma5qdP6Zzm0ljxk3nGt9nasemWa04K11gW
        H+W7uaduzld986Ivt/gkuhqr67fEfwgISl7ieLRnWWBw47FjAvozDz2aISUdW//g49NQidiP
        ammWiVa3ppdnG3bsMdy3f+HclQsXVB3nW+Bs233unX+gurejEktxRqKhFnNRcSIAJJ8D/O8D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7pPdgmmGKydyW4xZ/0aNovVd/vZ
        LF4f/sRosX/zFCaLmwd2Mlm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovPS1vYLXZvXMRmcf7vcVaL3z/msDkIesxuuMjisXmFlsfls6Uem1Z1snls+jSJ3ePE
        jN8sHg1Tb7F5/Lp9h9Wjb8sqRo/Pm+Q8Nj15yxTAHaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
        Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXceTGE8aCPRwVPx+zNjB+Y+ti5OSQEDCR+LP/
        GlMXIxeHkMBSRomePROYIRISErcXNjFC2MISf651sUEUPWeUONu7hLWLkYODTUBLorGTHSQu
        InCDUWLqpV+MIA4zSNGzm3dYQbqFBVwkLm5aAzaVRUBV4t6Xz2A2r4CVRMOTl1BnyEvsP3gW
        LM4pYC2xeuV0sLgQUM39e7uYIOoFJU7OfMICYjMD1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuL
        c9Nzi430ihNzi0vz0vWS83M3MQLjdduxn1t2MK589VHvECMTB+MhRgkOZiUR3nAWgRQh3pTE
        yqrUovz4otKc1OJDjKZAd09klhJNzgcmjLySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU
        7NTUgtQimD4mDk6pBqad3btWbtv3zqCizPyUK0t4RO/fhdvV/19bHR/DN/lp0xWxNUnJogJz
        dZ89uhN5yOXb41NyT00XXz+meGO6a8r9eXndm1kMrNj+1OSuXfDq1blnD4pZA9+FmTa8/fT4
        80yJ7Ukuzn9ybkWtFbSt4+lkjN6rfOLCbCm9jZv7Cw5Z30irqqvn5ig42/fSbXKcb69E/KNb
        u/qYlPxfpRwr4L660PvOUpW0yCtS87cn8fCc3LfTx/iC0pcNC8XFn6/J/SP8/2SM55qmzT+8
        Hm+XuK8scCuz5ROLy33Wh/2OR5YxsSZeLHH0+i0peFJ2RdIy128XjxctblwhXHBVKOKP0bnD
        HQonuJ5OM3Z2PrdSOmmjEktxRqKhFnNRcSIAw1K8PGADAAA=
X-CMS-MailID: 20230315123236eucas1p1116e1b8537191310bd03dd267b9f8eb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315123236eucas1p1116e1b8537191310bd03dd267b9f8eb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315123236eucas1p1116e1b8537191310bd03dd267b9f8eb8
References: <20230315123233.121593-1-p.raghav@samsung.com>
        <CGME20230315123236eucas1p1116e1b8537191310bd03dd267b9f8eb8@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use folio and its corresponding function in orangefs_readahead() so that
folios can be directly passed to the folio_endio().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/orangefs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index b12d099510ea..7e03d60bd406 100644
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
@@ -275,9 +275,9 @@ static void orangefs_readahead(struct readahead_control *rac)
 		ret = 0;
 
 	/* clean up. */
-	while ((page = readahead_page(rac))) {
-		folio_endio(page_folio(page), false, ret);
-		put_page(page);
+	while ((folio = readahead_folio(rac))) {
+		folio_endio(folio, false, ret);
+		folio_put(folio);
 	}
 }
 
-- 
2.34.1


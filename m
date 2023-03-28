Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8136CBD90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 13:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjC1L1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjC1L1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:27:30 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646281FFB
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 04:27:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230328112721euoutp029c41f180d6cc992bf0598c94aaa21488~Qka8A4kgK3159331593euoutp02x
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:27:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230328112721euoutp029c41f180d6cc992bf0598c94aaa21488~Qka8A4kgK3159331593euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680002841;
        bh=5/+0KaEbpjyZkaLqtYLBQz1+pPqkvr1OOiQOg6+VTQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8veZPRUscTbo+csuyoBzJR3U41Q+EmfypVD8wc3G9EESXJDZizknQm0BysjftENp
         7A7p+glY1oSYzot0AYfTKdxnMFGYgLUMcXjGSitN+JrzARRrIZHLf3dtA6cPZ8MyYv
         S+79mloau2Nn8yJ7L9kJGA/quO8JGZfTHftIr/DU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230328112720eucas1p22832e14ccc0ab8aa31019946721f05ee~Qka6fKv8z0111901119eucas1p2l;
        Tue, 28 Mar 2023 11:27:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 75.51.09503.81FC2246; Tue, 28
        Mar 2023 12:27:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230328112719eucas1p2b0f94ad7b06990203081d2b125dfc6ac~Qka531zRT0949409494eucas1p26;
        Tue, 28 Mar 2023 11:27:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230328112719eusmtrp2e345237a90bdb05950bbce0a693b0b7e~Qka53IS6i0134701347eusmtrp2Q;
        Tue, 28 Mar 2023 11:27:19 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-7c-6422cf18c5ba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9D.71.09583.71FC2246; Tue, 28
        Mar 2023 12:27:19 +0100 (BST)
Received: from localhost (unknown [106.210.248.108]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230328112719eusmtip1eb2b40496aafbd97f77244d6662ebaed~Qka5ppj340337303373eusmtip1Z;
        Tue, 28 Mar 2023 11:27:19 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     martin@omnibond.com, axboe@kernel.dk, minchan@kernel.org,
        akpm@linux-foundation.org, hubcap@omnibond.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/5] mpage: split bi_end_io callback for reads and writes
Date:   Tue, 28 Mar 2023 13:27:14 +0200
Message-Id: <20230328112716.50120-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328112716.50120-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djP87oS55VSDObuZ7eYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRXDYpqTmZZalF+nYJ
        XBmrNvgX/OOp+LvOt4HxGFcXIyeHhICJxNsNrewgtpDACkaJs1fUIOwvjBINy0Qg7M+MEi/u
        MMHUN+zuYuli5AKKL2eUeLrxLitE0UtGiQVtHl2MHBxsAloSjZ3sIDUiAmcYJRYvb2QDcZgF
        /jNKfJq0EmySsICnxJofEM0sAqoSO24eZwGxeQUsJRo3dbJAbJOX2H/wLDPIUE4BK4lpv60g
        SgQlTs58AlbCDFTSvHU2M8h8CYHdnBJtZ9qZIXpdJI7tOs4IYQtLvDq+hR3ClpH4v3M+1DfV
        Ek9v/IZqbmGU6N+5ng1kmYSAtUTfmRwQk1lAU2L9Ln2IckeJPc+fQVXwSdx4KwhxAp/EpG3T
        mSHCvBIdbUIQ1UoSO38+gVoqIXG5aQ7UUx4Sb66fYp/AqDgLyTOzkDwzC2HvAkbmVYziqaXF
        uempxYZ5qeV6xYm5xaV56XrJ+bmbGIHJ8PS/4592MM599VHvECMTB+MhRgkOZiUR3s3eiilC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamJqfzn6/1/JZ
        weobU2e3OQYtmGy+wfFPzQNdhe9HmRIOBfAue9e3n+frvWXu05+JfGo8k7z5dlwHi9U0VZ0s
        nu0TJx+r2P/rqcDuRd7Na7fODrVMmPpbkLdPPzz2qN0cfs7T/w6a/dr39NrH3bbndy48OFe7
        oWnWczWhebZlzH4uM1IVVYoCdC33rQhz6vXfGKG3j2U6S3j1pYoujeRD6/Q+noreWfpCzit5
        h+GThbFWj6W8zj27efWpoFWUlM2/f5bX/EXrX2Sk2D1e/YrfsXY62+ObmubXVqW/WWfZ85Nz
        zeV5kdd6+F7NsOC+nnoqP+7Vok/Hjsxmn78m2MxfeO2G1XcX7d3YHNzWLv2/p+WeEktxRqKh
        FnNRcSIAqWfy0vUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7ri55VSDA4flraYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRejZF+aUlqQoZ+cUl
        tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmrNvgX/OOp+LvOt4HxGFcX
        IyeHhICJRMPuLpYuRi4OIYGljBIt22cxQSQkJG4vbGKEsIUl/lzrYoMoes4o8b5vN1ARBweb
        gJZEYyc7SFxE4AajxNqnv1hBHGaBTiaJF6t2gHULC3hKrPlxlxXEZhFQldhx8zgLiM0rYCnR
        uKmTBWKDvMT+g2eZQYZyClhJTPttBRIWAiq5euY9I0S5oMTJmU/AypmBypu3zmaewCgwC0lq
        FpLUAkamVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHxu+3Yzy07GFe++qh3iJGJg/EQowQH
        s5II72ZvxRQh3pTEyqrUovz4otKc1OJDjKZAZ09klhJNzgcmkLySeEMzA1NDEzNLA1NLM2Ml
        cV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqbNdol5y11cd7bsqjn1/OjxXdtePowstgldtexz
        7QTxe4uf/Vx2V2BLkMaGwz4934pi4+bdehheql7Z9kRmmYlXov3zeW/UO1WtYt2cc5LOmi7O
        Nq2vf/up5enH1OJZlw9lryhRU9qaELrj1oym7cxKt1J0voRz/uabUD7ZXXyO+BXT1m+/GR7Y
        yur/S3LW8/m+TuLiI4Ujq47JlumGFPg/sWWWtpy02WzLsquCQomCp3NlQ09v/fhXm8vv70Su
        dtb7weI7nPe/qk87Ev7kyuNfsV/0Ts/Ym31+ve0l8VxzD9EYYVuLs2r1C4+terNI44HQ62+V
        uRfag7nS8mKcdv3wkXsx1b5x742HpzVWyIoqsRRnJBpqMRcVJwIALLf4ZWgDAAA=
X-CMS-MailID: 20230328112719eucas1p2b0f94ad7b06990203081d2b125dfc6ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230328112719eucas1p2b0f94ad7b06990203081d2b125dfc6ac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230328112719eucas1p2b0f94ad7b06990203081d2b125dfc6ac
References: <20230328112716.50120-1-p.raghav@samsung.com>
        <CGME20230328112719eucas1p2b0f94ad7b06990203081d2b125dfc6ac@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the bi_end_io handler for reads and writes similar to other aops.
This is a prep patch before we convert end_io handlers to use folios.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/mpage.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 22b9de5ddd68..3a545bf0f184 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -43,14 +43,28 @@
  * status of that page is hard.  See end_buffer_async_read() for the details.
  * There is no point in duplicating all that complexity.
  */
-static void mpage_end_io(struct bio *bio)
+static void mpage_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
 		struct page *page = bv->bv_page;
-		page_endio(page, bio_op(bio),
+		page_endio(page, REQ_OP_READ,
+			   blk_status_to_errno(bio->bi_status));
+	}
+
+	bio_put(bio);
+}
+
+static void mpage_write_end_io(struct bio *bio)
+{
+	struct bio_vec *bv;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bv, bio, iter_all) {
+		struct page *page = bv->bv_page;
+		page_endio(page, REQ_OP_WRITE,
 			   blk_status_to_errno(bio->bi_status));
 	}
 
@@ -59,7 +73,11 @@ static void mpage_end_io(struct bio *bio)
 
 static struct bio *mpage_bio_submit(struct bio *bio)
 {
-	bio->bi_end_io = mpage_end_io;
+	if (op_is_write(bio_op(bio)))
+		bio->bi_end_io = mpage_write_end_io;
+	else
+		bio->bi_end_io = mpage_read_end_io;
+
 	guard_bio_eod(bio);
 	submit_bio(bio);
 	return NULL;
-- 
2.34.1


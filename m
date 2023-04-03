Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402766D458C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjDCNWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 09:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjDCNWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:22:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D7B11664
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 06:22:30 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230403132226euoutp028884535c7c43ccfdf90369c071189911~Sb3Id4z9O1375413754euoutp02l
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 13:22:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230403132226euoutp028884535c7c43ccfdf90369c071189911~Sb3Id4z9O1375413754euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680528146;
        bh=5/+0KaEbpjyZkaLqtYLBQz1+pPqkvr1OOiQOg6+VTQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r++2oaFN0N0+G2S72qO8e7Cw6GtX3TD1d5DuTTMDG1WzMvdZZCbjPPf5CdK/g82XQ
         0i0Ws6YK2Ki8ER/EpnURSfsgnkLG91B92CBR6PYPIK182Btxcn7MN6l0oov3BfAmk7
         IcYiJhbCpv60tSR/+MHwNvetQdvPDop0fg+0ibg4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230403132225eucas1p2eeb69651b019e4e779166e8b360a7342~Sb3HE0Gyc2688526885eucas1p2X;
        Mon,  3 Apr 2023 13:22:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.F4.09503.113DA246; Mon,  3
        Apr 2023 14:22:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230403132224eucas1p21fd296fbd4af70220331bb19023f4169~Sb3Gsa2HH2688526885eucas1p2W;
        Mon,  3 Apr 2023 13:22:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230403132224eusmtrp2025b29c3cb119969b17b4113d6677db0~Sb3GrwLJb0200802008eusmtrp2L;
        Mon,  3 Apr 2023 13:22:24 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-b4-642ad311da86
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.16.08862.013DA246; Mon,  3
        Apr 2023 14:22:24 +0100 (BST)
Received: from localhost (unknown [106.210.248.30]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230403132224eusmtip14497bed1922f57dfc44ffe4d39a2dff3~Sb3Ge5UWK2612826128eusmtip1B;
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
Subject: [PATCH v2 3/5] mpage: split bi_end_io callback for reads and writes
Date:   Mon,  3 Apr 2023 15:22:19 +0200
Message-Id: <20230403132221.94921-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403132221.94921-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87qCl7VSDDY8F7aYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRXDYpqTmZZalF+nYJ
        XBmrNvgX/OOp+LvOt4HxGFcXIyeHhICJxPobP9i7GLk4hARWMEo8vvKeCcL5wijx7MoDNgjn
        M6PE1Ksb2GFaph04AZVYzijRv+kJC4TzglHi36W1QP0cHGwCWhKNnWBzRQRuMUq86ZkNNpdZ
        4D6jxLzde8GKhAV8JP5szQKZyiKgKtHd+RhsA6+ApcTDh0+htslL7D94lhnE5hSwkmicPpcR
        okZQ4uRMkMWcQDPlJZq3zmaGqN/OKXHnkTuE7SLxbNNsqDnCEq+Ob4GyZST+75zPBGFXSzy9
        8ZsZ5DYJgRagb3auZwO5TULAWqLvTA6IySygKbF+lz5EuaPEk/cgI0Eq+CRuvBWEuIBPYtK2
        6cwQYV6JjjYhiGoliZ0/n0AtlZC43DSHBcL2kPgyeSbzBEbFWUh+mYXkl1kIexcwMq9iFE8t
        Lc5NTy02zEst1ytOzC0uzUvXS87P3cQITImn/x3/tINx7quPeocYmTgYDzFKcDArifCqdmml
        CPGmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamAqttqR/yBv
        ydQfFxWDgvY2Ho27WX4+RfTF4kd2Hus3ZDlMaVBc0Op+j9P5Vsqki/kNBielS/ustp6VODZb
        6cdH5dlyOjm2quvXHGDM3xevlSG5zcRS6cj5nTOOlk3vbDh6rC3M5N/db7MeTlq+99RF94lp
        /urrT3pZ+n2ut7c3O8WhNO1awKq7r3r7Cyz89Hd/M+600jwWmr3XJVyUn6nJ6GPdq4OZKn9k
        u812zn/4LkDrpsHyNU7sseeFFtku8gis8ruwouvumklRSQbnrx8Tf8V+0jzdiZnh3cr6j/NZ
        i8TmXamS+lr1wX1+UerFdfoTPjRlzHtjenfvSuHNL+6s8Lb5+f5wy6XSzfP8uHclK7EUZyQa
        ajEXFScCAKlZdtP4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7oCl7VSDHa1mVnMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBYrVx9lsmi/28dksfeWtsWevSdZLC7vmsNmcW/Nf1aLk+v/M1vc
        mPCU0WLZ1/fsFp+XtrBb7N64iM3i/N/jrBa/f8xhcxDymN1wkcVj8wotj8tnSz02repk89j0
        aRK7x4kZv1k8GqbeYvPYfbOBzePX7TusHn1bVjF6fN4k57HpyVumAJ4oPZui/NKSVIWM/OIS
        W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxVG/wL/vFU/F3n28B4jKuL
        kZNDQsBEYtqBE2xdjFwcQgJLGSX27j3NDJGQkLi9sIkRwhaW+HOtC6roGaPEkcW9TF2MHBxs
        AloSjZ3sIHERkPiyC8dZQBxmgeeMEmum/GYGKRIW8JH4szULZBCLgKpEd+djdhCbV8BS4uHD
        p+wQC+Ql9h88C7aYU8BKonH6XLDFQkA1Xy/eYoWoF5Q4OfMJC4jNDFTfvHU28wRGgVlIUrOQ
        pBYwMq1iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjN9tx35u3sE479VHvUOMTByMhxglOJiV
        RHhVu7RShHhTEiurUovy44tKc1KLDzGaAt09kVlKNDkfmEDySuINzQxMDU3MLA1MLc2MlcR5
        PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYWtk2Z9ofOMXaHtvQfubwJRHfVZ8PmmZeWqcb5Hzo
        kVoxo6WU6ok0qQXrNh8yXqyT473U8YHE8urqKwX/8qvDTxzqWOdfp56zYetPkcOaxZvjLC5a
        HbVeobM3/z+DuJDIp6ZPquc2TprcqaF1d0byz92rDJIk754/y+hSW7eW7cK0uqDc5hNF78Pf
        Z01LvS33cPJWsfNJfjpRhpNWssgHvj5rd+fp2quKvnWbPgvE2y89tEav5cO3F46JS15avTyl
        817+UuTLfx9eu+g99rWZt69M2bH/5Mt/zD1Hpl27dU8st6F2svtd29rER18jeKPUr7rHz4qI
        7eo6u9DzoXNJY4nbHb8dp0+ufJif+Xx3rBJLcUaioRZzUXEiAM3/pTloAwAA
X-CMS-MailID: 20230403132224eucas1p21fd296fbd4af70220331bb19023f4169
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230403132224eucas1p21fd296fbd4af70220331bb19023f4169
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230403132224eucas1p21fd296fbd4af70220331bb19023f4169
References: <20230403132221.94921-1-p.raghav@samsung.com>
        <CGME20230403132224eucas1p21fd296fbd4af70220331bb19023f4169@eucas1p2.samsung.com>
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


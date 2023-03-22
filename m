Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6546C4C6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 14:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCVNvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCVNvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:51:03 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56195CEC5
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 06:50:46 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230322135019euoutp025ff4ed6b8ae9e64f3a0b6f9755ec20da~OwgDWCT371713617136euoutp02T
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 13:50:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230322135019euoutp025ff4ed6b8ae9e64f3a0b6f9755ec20da~OwgDWCT371713617136euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679493019;
        bh=bEycODUs3a19v9Q2MRV2ibzIXf/1C8rKj/6UCd36MJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OE3TuYV5eG6ueLT9Sql/pOs/SAiAfvuG9xGrrLCYnBTCQN1Jetoz8yGgrvjYrBXx2
         rIOzqRA7jVp/mT/D6jN4n61A1V2fCkQ6ezxS41zL3/s8KjHZacM9S9muGz0fZyaEke
         4+J7lecYRdBLfp6Nwl6izQyYpgRHc8PJUy8MH08M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230322135018eucas1p12b4ac5ea50ea365ccac025b8b1a287ac~OwgBtgsgg3054630546eucas1p1f;
        Wed, 22 Mar 2023 13:50:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C2.38.10014.A970B146; Wed, 22
        Mar 2023 13:50:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230322135017eucas1p2d29ffaf8dbbd79761ba56e8198d9c933~OwgBSi9ph0617106171eucas1p26;
        Wed, 22 Mar 2023 13:50:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230322135017eusmtrp2fde4c0580c077ed043cd9b7695a7b4e2~OwgBR1bDu0670606706eusmtrp2b;
        Wed, 22 Mar 2023 13:50:17 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-16-641b079a66c5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.6E.09583.9970B146; Wed, 22
        Mar 2023 13:50:17 +0000 (GMT)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230322135017eusmtip28d89f9c0a2f04dd9e9c07a1b728a61a7~OwgBFYop52536025360eusmtip2v;
        Wed, 22 Mar 2023 13:50:17 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        willy@infradead.org, brauner@kernel.org, akpm@linux-foundation.org,
        minchan@kernel.org, hubcap@omnibond.com, martin@omnibond.com
Cc:     mcgrof@kernel.org, devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 4/5] mpage: use folios in bio end_io handler
Date:   Wed, 22 Mar 2023 14:50:12 +0100
Message-Id: <20230322135013.197076-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322135013.197076-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djPc7qz2KVTDK48YbWYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjuKySUnNySxLLdK3S+DK+Pn0NHtBC1/F
        pcaTjA2M67i7GDk4JARMJG78Tu1i5OIQEljBKHFq10dWCOcLo0TntmlQzmdGiTltW1m6GDnB
        Olq39LBDJJYzSkz+uJcJwnnJKLH20ScmkLlsAloSjZ1gRSICZxglpjTNYATpZha4zyhxei/Y
        JGEBW4mFF3cygtSzCKhKrLyWDhLmFbCSmDxhMSPEMnmJ/QfPMoPYnALWEo8WTWODqBGUODnz
        CQvESHmJ5q2zmUF2SQis5pTY3XufDaLZRWIGMDYgbGGJV8e3sEPYMhL/d85ngrCrJZ7e+A3V
        3MIo0b9zPRskYKwl+s7kgJjMApoS63fpQ5Q7Shx5sgGqgk/ixltBiBP4JCZtm84MEeaV6GgT
        gqhWktj58wnUUgmJy01zoEHoIXFk8RT2CYyKs5A8MwvJM7MQ9i5gZF7FKJ5aWpybnlpsnJda
        rlecmFtcmpeul5yfu4kRmABP/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuF1Y5ZIEeJNSaysSi3K
        jy8qzUktPsQozcGiJM6rbXsyWUggPbEkNTs1tSC1CCbLxMEp1cBUOmvnyuO/+XtP28QvuPbg
        /D0dMQ3f7qzXS+8YOIh07ZzFxGb40Kt69223OfPUVi23ZtlkEJOzS/zkn/MzY6P21r3inb9X
        8bnXyvrGKW575C4tjVMIMBb8fr46yulxYOLPLakZwS8c2zSq5Y+VrA3bEXIzafP0Ok6N6fMu
        xnhrhB8U5Pd/OHv20okeC72Z7GL/yE58LyRqlRiboLlrw9SdZc9S7bcE6573mfogSmvJuzMr
        MycfnGBZ86zI/8SM1TYlbWGRseU7eMtq0xVZ0j8fShY/bFFybJrTfq52TV9dnvqKQp16QW6d
        6ZtXNn3pWsKpV9i4yizxQLyDNav5NKt5Ujza+9/22+r61GdEJimxFGckGmoxFxUnAgAAX9Yv
        7wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7oz2aVTDOZ3qVnMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBbtd/uYLPbe0rbYs/cki8XlXXPYLO6t+c9qcXL9f2aLGxOeMlos
        +/qe3eLz0hZ2i90bF7FZnP97nNXi9485bA6CHrMbLrJ4bF6h5XH5bKnHplWdbB6bPk1i9zgx
        4zeLR8PUW2wev27fYfXo27KK0ePzJjmPTU/eMgVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlro
        GZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl/Hx6mr2gha/iUuNJxgbGddxdjJwcEgImEq1b
        eti7GLk4hASWMkocPd/GBJGQkLi9sIkRwhaW+HOtiw2i6DmjRPOLxUAJDg42AS2Jxk52kBoR
        gRuMEu2r9EBqmEFqLj+dzQySEBawlVh4cSdYPYuAqsTKa+kgYV4BK4nJExZDzZeX2H/wLFg5
        p4C1xKNF09hAbCGgmsv7J7FC1AtKnJz5hAXEZgaqb946m3kCo8AsJKlZSFILGJlWMYqklhbn
        pucWG+kVJ+YWl+al6yXn525iBEbrtmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8bswSKUK8KYmV
        ValF+fFFpTmpxYcYTYHOnsgsJZqcD0wXeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZ
        qakFqUUwfUwcnFINTE4BrvUTLrs37+vZoLbew6/4sbxV/vy5lneOs7V5sgn2dWXO5rPVrJX9
        cjLzfNOKzNceh8onWGaffW++69hu8Q2dJdNPLPCYtFj3v4pixLbJL9OenVzLe+ai5L+O4+dd
        z/tMbv5owLgs3V5I2y2h/nvWrrOiSWYFHV+/X5Y+8saWd2WSZbH9TAtX66d8ai8D54R9vr43
        59z+sv1rl3uWX3MPO//Ha+viY0veJd4y3queKvJnzcanLI+WSb5N/eWrWjZLomDDJL6LStxM
        lj6vWH989PeI+pPjcFtMr/pYxfYPT6e+aD64W25HyoHfU74c6VZXFPqcGrjDcP2S6S8TXWea
        i4dt93rYulo13EBq2RolluKMREMt5qLiRADBlbKOXwMAAA==
X-CMS-MailID: 20230322135017eucas1p2d29ffaf8dbbd79761ba56e8198d9c933
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230322135017eucas1p2d29ffaf8dbbd79761ba56e8198d9c933
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230322135017eucas1p2d29ffaf8dbbd79761ba56e8198d9c933
References: <20230322135013.197076-1-p.raghav@samsung.com>
        <CGME20230322135017eucas1p2d29ffaf8dbbd79761ba56e8198d9c933@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
 fs/mpage.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 3a545bf0f184..103505551896 100644
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
+		struct folio *folio = fi.folio;
+
+		if (!err)
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 	}
 
 	bio_put(bio);
@@ -59,13 +61,21 @@ static void mpage_read_end_io(struct bio *bio)
 
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
+		struct folio *folio = fi.folio;
+
+		if (err) {
+			struct address_space *mapping;
+
+			folio_set_error(folio);
+			mapping = folio_mapping(folio);
+			if (mapping)
+				mapping_set_error(mapping, err);
+		}
+		folio_end_writeback(folio);
 	}
 
 	bio_put(bio);
-- 
2.34.1


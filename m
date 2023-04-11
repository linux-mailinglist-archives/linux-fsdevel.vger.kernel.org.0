Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9956DDACC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDKM3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 08:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjDKM3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:29:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05592212E
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 05:29:32 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230411122926euoutp018f0e8f568edf26e1fa3d7bc8f5a3f4d3~U4TInkiEA0478604786euoutp01Z
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 12:29:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230411122926euoutp018f0e8f568edf26e1fa3d7bc8f5a3f4d3~U4TInkiEA0478604786euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681216166;
        bh=1qC6zHvAgcTgYm8ljFpJs+7FVJXDek+LLyQQCiQNxfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6k7bPGMEm2WHoEuC8ctkZLXXHIOTQHQqoV82xAuO9/lme4BfzpuXcLwM22tTO2wG
         L3UTTJPx6bmJ5ObCRUWkgAaYB1PogBSfjKjSwToyDIL80kxUwhaOZn2anIaaf4esh3
         /HVXMrUTHDMOG6Y1maEiN1Ktyk/5rrfuuZnaq0Po=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230411122924eucas1p2a842969709d6b49b03f7c346bb6d7103~U4THBHNHL3227732277eucas1p2w;
        Tue, 11 Apr 2023 12:29:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8E.9A.10014.4A255346; Tue, 11
        Apr 2023 13:29:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230411122924eucas1p16c6abcf91a3e04c6a0a225606ca0044d~U4TGnGH0t0202002020eucas1p1Q;
        Tue, 11 Apr 2023 12:29:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230411122924eusmtrp241d6a59a92a6a323b6b491c16e7e34ca~U4TGmSAGr0100601006eusmtrp2p;
        Tue, 11 Apr 2023 12:29:24 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-0a-643552a43e97
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.58.22108.4A255346; Tue, 11
        Apr 2023 13:29:24 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230411122924eusmtip2237fca85463f83e9b9eeb88cf4b5bc78~U4TGX3VXf1077210772eusmtip2d;
        Tue, 11 Apr 2023 12:29:23 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hubcap@omnibond.com, brauner@kernel.org, martin@omnibond.com,
        willy@infradead.org, hch@lst.de, minchan@kernel.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk,
        akpm@linux-foundation.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        mcgrof@kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 3/3] mpage: use folios in bio end_io handler
Date:   Tue, 11 Apr 2023 14:29:20 +0200
Message-Id: <20230411122920.30134-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411122920.30134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djP87pLgkxTDG4vUrOYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSxWrj7KZNF+t4/JYu8tbYs9e0+yWFzeNYfN4t6a/6wWJ9f/Z7a4
        MeEpo8Wyr+/ZLT4vbWG32L1xEZvF+b/HWS1+/5jD5iDkMbvhIovH5hVaHpfPlnpsWtXJ5rHp
        0yR2jxMzfrN4NEy9xeax+2YDm8ev23dYPfq2rGL0+LxJzmPTk7dMATxRXDYpqTmZZalF+nYJ
        XBmfVs5iKTjAU7FhzgbGBsb5XF2MnBwSAiYSzdeesHUxcnEICaxglLh64wiU84VR4tWerSwQ
        zmdGiRcb7zHBtDx+8h2qajmjxOIFR6Gcl4wS70+uYOxi5OBgE9CSaOxkB4mLCNxilFjw+Qoj
        iMMscJ9R4uGtU+wgo4QF7CWm/lrEDGKzCKhK/Hu+AWwFr4ClxJztz6HWyUvsP3gWrIZTwEpi
        9aoPjBA1ghInZz5hAbGZgWqat85mBlkgIbCbU2LHrL9QzS4SPRsuMUPYwhKvjm9hh7BlJP7v
        nA9VUy3x9MZvqOYWRon+nevZQF6QELCW6DuTA2IyC2hKrN+lD1HuKLF651xWiAo+iRtvBSFO
        4JOYtG06M0SYV6KjTQiiWkli588nUEslJC43zWGBsD0kep68ZZ3AqDgLyTOzkDwzC2HvAkbm
        VYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIGp8fS/4193MK549VHvECMTB+MhRgkOZiUR
        3h8upilCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamOzU
        7oU1f7de6Xhuweqs+6svS2UJcdZ7mhucv530/YhS/YlT+gvM/nxcw57I2iOSnb/c2Xt/eFTH
        0cTF91gDyp1O25gs38f5YnqvtM8UDbvle9Mt6103TLWaESNuGi23cZZy3OK3rl84s3bb8riG
        7yp6df9SeMHO5RLWJrvrzXO0UzQ7IoR13U3N+IqOvc7i4X7Cs3bTiqyb7x9l1eutk9y6maNA
        8uPR9C+JFjYzOI70mz8UfS282HPSo0O8FlKM0+QXe1hduZ8WVKPwscPNQveRmvLDBz/15E+V
        fdORyK1zXm/z0Vjv+Yz190o+3dorFNXnVCHz6cr9V0yRlyvVSs/0XRdZ9fOSslq0TYyHEktx
        RqKhFnNRcSIAMaz5YvwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7pLgkxTDNqW8lrMWb+GzWL13X42
        i9eHPzFa7N88hcni5oGdTBYrVx9lsmi/28dksfeWtsWevSdZLC7vmsNmcW/Nf1aLk+v/M1vc
        mPCU0WLZ1/fsFp+XtrBb7N64iM3i/N/jrBa/f8xhcxDymN1wkcVj8wotj8tnSz02repk89j0
        aRK7x4kZv1k8GqbeYvPYfbOBzePX7TusHn1bVjF6fN4k57HpyVumAJ4oPZui/NKSVIWM/OIS
        W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxPK2exFBzgqdgwZwNjA+N8
        ri5GTg4JAROJx0++s3UxcnEICSxllJg/7QUbREJC4vbCJkYIW1jiz7UuqKLnjBIL52xj7WLk
        4GAT0JJo7GQHiYsIPGOUmL1hCytIAzNI0a9HvCC2sIC9xNRfi5hBbBYBVYl/zzcwgdi8ApYS
        c7Y/Z4JYIC+x/+BZsBpOASuJ1as+gC0WAqq50D6PFaJeUOLkzCcsEPPlJZq3zmaewCgwC0lq
        FpLUAkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIExvO3Yz807GOe9+qh3iJGJg/EQowQH
        s5II7w8X0xQh3pTEyqrUovz4otKc1OJDjKZAd09klhJNzgcmkbySeEMzA1NDEzNLA1NLM2Ml
        cV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqZ644a9izas16pqZj209yzDXsk63we8Vq+UDWf+
        uj858OvviVEyD5tS7nZNkEuSCPhzeGtvxZsE4Vsf8+aKfeq4qcv5YnFx9SYvscVmCpKdy6Pu
        Ofov8JZxiPz2LnZFTMI3b8lLLm+nvhNJd5dfobXNyCVgJou70brwfdcZ8nUMs3qK0oMyJnFo
        2J9VUFW/xpDeu0T4aMGvpWVW4hW/6pf89MvfISCd+Lb67WOPomwfjsA5Hg7XPvYwq3CEmnu/
        mvc8R/l88+U8bd79nIcWWeVu81I5pPOIz9n/bPVRW7t/c+bYZ5s9WLCa89wnNw6v/YJ+zEVT
        Jy7eNI+l7/VSw4/fLmy9vGnpD/lbzHfNtymxFGckGmoxFxUnAgCIKuLiagMAAA==
X-CMS-MailID: 20230411122924eucas1p16c6abcf91a3e04c6a0a225606ca0044d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230411122924eucas1p16c6abcf91a3e04c6a0a225606ca0044d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230411122924eucas1p16c6abcf91a3e04c6a0a225606ca0044d
References: <20230411122920.30134-1-p.raghav@samsung.com>
        <CGME20230411122924eucas1p16c6abcf91a3e04c6a0a225606ca0044d@eucas1p1.samsung.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/mpage.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index d9540c1b7427..242e213ee064 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -45,24 +45,32 @@
  */
 static void mpage_read_end_io(struct bio *bio)
 {
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
+	int err = blk_status_to_errno(bio->bi_status);
 
-	bio_for_each_segment_all(bv, bio, iter_all)
-		page_endio(bv->bv_page, REQ_OP_READ,
-			   blk_status_to_errno(bio->bi_status));
+	bio_for_each_folio_all(fi, bio) {
+		if (err)
+			folio_set_error(fi.folio);
+		else
+			folio_mark_uptodate(fi.folio);
+		folio_unlock(fi.folio);
+	}
 
 	bio_put(bio);
 }
 
 static void mpage_write_end_io(struct bio *bio)
 {
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
+	int err = blk_status_to_errno(bio->bi_status);
 
-	bio_for_each_segment_all(bv, bio, iter_all)
-		page_endio(bv->bv_page, REQ_OP_WRITE,
-			   blk_status_to_errno(bio->bi_status));
+	bio_for_each_folio_all(fi, bio) {
+		if (err) {
+			folio_set_error(fi.folio);
+			mapping_set_error(fi.folio->mapping, err);
+		}
+		folio_end_writeback(fi.folio);
+	}
 
 	bio_put(bio);
 }
-- 
2.34.1


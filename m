Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C945542019
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbiFHAQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835798AbiFGX5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:57:00 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74568FCEF8
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6wfIImN1V5bWomaOl/DuvOp7dK2fJI8QCN7xBf4qf0c=; b=hx0/lo8z2AAlDPLfoeh2rkTH8r
        CN4Y8iuhV6PuN+eBZ0+r/O32ER8AxdV6kuJlG7Djs8vUKTW2G+33SPHa3zathSfXYORePgByYGX4Y
        g6aAyLxKImV/xsoVDcMkknVVgOXG3sm03ItcJW1WGp94H1tdGFKvpbjj0+iv1C6+XYBynXkZvx1Zj
        3hY0xqcXs0CWTwRWr3MZTdZ94Dat1S1dY9lzT8FF2FRQa8zzC/t8Iws6htcSo+2qJI2UjZ5Dk/AqG
        VsnXB/gDhwpsHWU6Pm4LGuJ0IR8DCrod2/jWyQeJ1+AeWIEDcLP43Qa8FyHAANsEzx+1FLngENtKq
        c0XCBo1g==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyifo-004ttn-D5; Tue, 07 Jun 2022 23:31:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 10/10] iov_iter_bvec_advance(): don't bother with bvec_iter
Date:   Tue,  7 Jun 2022 23:31:43 +0000
Message-Id: <20220607233143.1168114-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
References: <Yp/e+KFSksyDILpJ@zeniv-ca.linux.org.uk>
 <20220607233143.1168114-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do what we do for iovec/kvec; that ends up generating better code,
AFAICS.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8275b28e886b..93ceb13ec7b5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -870,17 +870,22 @@ static void pipe_advance(struct iov_iter *i, size_t size)
 
 static void iov_iter_bvec_advance(struct iov_iter *i, size_t size)
 {
-	struct bvec_iter bi;
+	const struct bio_vec *bvec, *end;
 
-	bi.bi_size = i->count;
-	bi.bi_bvec_done = i->iov_offset;
-	bi.bi_idx = 0;
-	bvec_iter_advance(i->bvec, &bi, size);
+	if (!i->count)
+		return;
+	i->count -= size;
+
+	size += i->iov_offset;
 
-	i->bvec += bi.bi_idx;
-	i->nr_segs -= bi.bi_idx;
-	i->count = bi.bi_size;
-	i->iov_offset = bi.bi_bvec_done;
+	for (bvec = i->bvec, end = bvec + i->nr_segs; bvec < end; bvec++) {
+		if (likely(size < bvec->bv_len))
+			break;
+		size -= bvec->bv_len;
+	}
+	i->iov_offset = size;
+	i->nr_segs -= bvec - i->bvec;
+	i->bvec = bvec;
 }
 
 static void iov_iter_iovec_advance(struct iov_iter *i, size_t size)
-- 
2.30.2


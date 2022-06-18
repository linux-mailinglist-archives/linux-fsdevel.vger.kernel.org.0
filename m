Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89275502F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiFRFfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiFRFfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B48867D19
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6wfIImN1V5bWomaOl/DuvOp7dK2fJI8QCN7xBf4qf0c=; b=SYSSJFYooCHZIMGZhYmTrWAnrB
        /kBhT/cBBWcu5xR2HEUmko9OMADUyJUppjorWb+Lva2gZlJRB/fR8bfRnoVS5BtNHQiiu60floO6K
        /hhCwjB4QLShfNXT5aAFd+Ic+X16sPxs4fAQJNcFclxkOsldaTqs7Yp/n48yXe5JawOGgNZqOpML4
        m4PnH3rmxIiqcnMYD4SIXk+enjcpT9iERec9B+K8qNg3CDry1j69y1qXqxcJ25UbXqteGBZnJsuRD
        irvLGNe3inIBWpNHNEOIjzyEKqqf5zwdMepX9R6rPlW6y7H4Frv4z7un4YexxRxtkIqcYdoRqzGF3
        gdpxHTOw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7U-001VQ6-9p;
        Sat, 18 Jun 2022 05:35:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 10/10] iov_iter_bvec_advance(): don't bother with bvec_iter
Date:   Sat, 18 Jun 2022 06:35:16 +0100
Message-Id: <20220618053538.359065-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618053538.359065-1-viro@zeniv.linux.org.uk>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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


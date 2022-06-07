Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9853F4E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiFGEOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiFGEOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:14:02 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF79033E0A
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 21:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6wfIImN1V5bWomaOl/DuvOp7dK2fJI8QCN7xBf4qf0c=; b=Zhlrq57iIVSjnqlmjM6lAcsNC8
        DosyABp2tYc4iTW5p3zZgYbD9CsYQm0WFz27wRrgJi8i1Yt9sAMxXMZUQa/mJt0Kdg9I+ejBr3cFs
        aRVNus0imXtmeej2XFdKY3J+zxJ8PQkmopz3Yfk/sF6wBnVKbQiu7SqU1YrGVGdMjlRR0XGum4HMv
        6joGoALz0hyWPehEDrjdSBsfPntUjOjqEuKu9CfcuqfP/1fSkh3XQI74PD35q2KZd5BlWMY1YGN+l
        Q1JCt8sgFVORbDUw6Qe2c6iRLyCQmWxAmO3n10sxg6PptehfeIAJab+m+uXTNKWEXGmVbglxOyb1g
        jgQy/RbQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyQbO-004YrN-Qr; Tue, 07 Jun 2022 04:13:58 +0000
Date:   Tue, 7 Jun 2022 04:13:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 9/9] iov_iter_bvec_advance(): don't bother with bvec_iter
Message-ID: <Yp7QhjR1h0KpgI9N@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
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


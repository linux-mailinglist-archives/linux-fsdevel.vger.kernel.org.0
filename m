Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D9055042E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiFRLPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiFRLOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 07:14:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFFC22B06
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c9Qc1yz17z0wRLxAuSUHXx+qnX2+o4P0wDFDhEoDKVM=; b=ZX+x/rON+NV9Ts5ZFwTjJ4Cjme
        fxV8yDrqqox0aa8oF1HtEQrtsTf8fTBDKyfmuEPmlFolDvuXf7nPy2jO4wC3EqSCr97CZjvwXDZzZ
        5UUBk+/JfYxJ1NEfH6F2yiF6LqW89yJHcA8SdGA1/cm0GPNoR2ky9NBgQJyt8HxinaiLmuo6yU9Nf
        t/SCu6nyG1YOMujoYStHGXeKsARrqWQJeUykEjrimw3FffcZekISRI9krvAOv56P0XizQYYskOJOc
        hUclGwJU89JgTKrmqLFevMw/hcOLKRWuEfvTr+7N6O89L5OVSZR8q36qY3DZJ6HBFM26LYLJ3hjBJ
        VvjSOXNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2WPl-001alH-HR;
        Sat, 18 Jun 2022 11:14:53 +0000
Date:   Sat, 18 Jun 2022 12:14:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 31/31] expand those iov_iter_advance()...
Message-ID: <Yq2zrRXT+RLW2+C7@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-32-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618053538.359065-32-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[braino fixed]
From fe8e2809c7db0ec65403b31b50906f3f481a9b10 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 11 Jun 2022 04:04:33 -0400
Subject: [PATCH 31/31] expand those iov_iter_advance()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 68a2e2a68aa1..38e7605a6794 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1279,7 +1279,8 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 		return 0;
 
 	maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
-	iov_iter_advance(i, maxsize);
+	i->iov_offset += maxsize;
+	i->count -= maxsize;
 	return maxsize;
 }
 
@@ -1367,7 +1368,13 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		for (int k = 0; k < n; k++)
 			get_page(p[k] = page + k);
 		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
-		iov_iter_advance(i, maxsize);
+		i->count -= maxsize;
+		i->iov_offset += maxsize;
+		if (i->iov_offset == i->bvec->bv_len) {
+			i->iov_offset = 0;
+			i->bvec++;
+			i->nr_segs--;
+		}
 		return maxsize;
 	}
 	if (iov_iter_is_pipe(i))
-- 
2.30.2


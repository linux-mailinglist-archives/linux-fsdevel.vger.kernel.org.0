Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02F024CDB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 08:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHUGHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 02:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUGHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:07:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5694C061385;
        Thu, 20 Aug 2020 23:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=csBfSNWoqycX+qwrSd8VYEM/dpU2DB6oNeP8NG+28Xc=; b=qTzxO5ukJYkNNSGikvE5RnQCsQ
        +KhwGfIq6hKk3uBbnfLAgUR6FOhqgOt59pJRlc0mbEP8P4TjhIuEZGm4ZoWQ5tHFIPDTLxVx3sE7F
        7xfpj0y+M3F4xbaUxu+WQAk/K7vicbV335ik6f4aVmA5z0XxD5zPq3ld4vSv42DrYWQMkfC7lXOEC
        69UtcSsu2hfM4jhvRLl5r/P8l8UgaIOV0jsqM9XRd7i9P//Oowm/NKHFN800e6HDD2igBVHRvF79f
        8hsaUc3M6hvOlT4S5EGBd2yDs1FLYAilAgstS28qEoeSxvHfcH49rBEXEKfH2ZwQSLRl2YgW+zm76
        BaSKRdoA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k90Cl-0000M6-0v; Fri, 21 Aug 2020 06:07:11 +0000
Date:   Fri, 21 Aug 2020 07:07:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        riteshh@linux.ibm.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200821060710.GC31091@infradead.org>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:58:41PM +0530, Anju T Sudhakar wrote:
> From: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> __bio_try_merge_page() may return same_page = 1 and merged = 0. 
> This could happen when bio->bi_iter.bi_size + len > UINT_MAX. 
> Handle this case in iomap_add_to_ioend() by incrementing write_count.
> This scenario mostly happens where we have too much dirty data accumulated. 
> 
> w/o the patch we hit below kernel warning,

I think this is better fixed in the block layer rather than working
around the problem in the callers.  Something like this:

diff --git a/block/bio.c b/block/bio.c
index c63ba04bd62967..ef321cd1072e4e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -879,8 +879,10 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len)
+			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+				*same_page = false;
 				return false;
+			}
 			bv->bv_len += len;
 			bio->bi_iter.bi_size += len;
 			return true;

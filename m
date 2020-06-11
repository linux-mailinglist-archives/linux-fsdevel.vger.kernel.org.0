Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF251F6D56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 20:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFKSUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgFKSUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:20:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0FC03E96F;
        Thu, 11 Jun 2020 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UbcUAIkCTY1gDrnsL4VkJ1RkOA6N4Sm7pv2NznSHhOI=; b=t6lWNyQMHlGsflggtFHw96ugnq
        jogP3C9fdI//O5qicfXeP5RJS1zZymhpTOL7/VNnj+EtbNAGm3hk+zOuzXDw+GHLttZ2tRusCtQKN
        zK7H/vl/d/PGMFiMMd/7SqwmDrjnD76P52lPTDH6R0Wb++484Vytj74YYEKgm66seJ0SsYCB8TRHg
        8xt6EPhR+kYGun8OLhLdae7Lk7HAXrnzH7bX9AmU5iuPwhvWdbyFzvybtXoSCMxAWzweuwpuSsUvt
        0WGCahvAMJx5LLN3eahufbheqtIMTD0jG3Amhr1CXGkYE4xk1l5A1el626ynF5WO7PBuY8msFDRg1
        JtjdbcCQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjRoT-0007dC-CF; Thu, 11 Jun 2020 18:20:29 +0000
Date:   Thu, 11 Jun 2020 11:20:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 20/51] block: Add bio_for_each_thp_segment_all
Message-ID: <20200611182029.GC8681@bombadil.infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
 <20200610201345.13273-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610201345.13273-21-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:13:14PM -0700, Matthew Wilcox wrote:
> +static inline void bvec_thp_advance(const struct bio_vec *bvec,
> +				struct bvec_iter_all *iter_all)
> +{
> +	struct bio_vec *bv = &iter_all->bv;
> +	unsigned int page_size = thp_size(bvec->bv_page);
> +
> +	if (iter_all->done) {
> +		bv->bv_page += thp_nr_pages(bv->bv_page);
> +		bv->bv_offset = 0;
> +	} else {
> +		BUG_ON(bvec->bv_offset >= page_size);
> +		bv->bv_page = bvec->bv_page;
> +		bv->bv_offset = bvec->bv_offset & (page_size - 1);
> +	}
> +	bv->bv_len = min(page_size - bv->bv_offset,
> +			 bvec->bv_len - iter_all->done);
> +	iter_all->done += bv->bv_len;
> +
> +	if (iter_all->done == bvec->bv_len) {
> +		iter_all->idx++;
> +		iter_all->done = 0;
> +	}
> +}

If, for example, we have an order-2 page followed by two order-0 pages
(thanks, generic/127!) in the bvec, we'll end up skipping the third
page because we calculate the size based on bvec->bv_page instead of
bv->bv_page.

+++ b/include/linux/bvec.h
@@ -166,15 +166,19 @@ static inline void bvec_thp_advance(const struct bio_vec *bvec,
                                struct bvec_iter_all *iter_all)
 {
        struct bio_vec *bv = &iter_all->bv;
-       unsigned int page_size = thp_size(bvec->bv_page);
+       unsigned int page_size;
 
        if (iter_all->done) {
                bv->bv_page += thp_nr_pages(bv->bv_page);
+               page_size = thp_size(bv->bv_page);
                bv->bv_offset = 0;
        } else {
-               BUG_ON(bvec->bv_offset >= page_size);
-               bv->bv_page = bvec->bv_page;
-               bv->bv_offset = bvec->bv_offset & (page_size - 1);
+               bv->bv_page = thp_head(bvec->bv_page +
+                               (bvec->bv_offset >> PAGE_SHIFT));
+               page_size = thp_size(bv->bv_page);
+               bv->bv_offset = bvec->bv_offset -
+                               (bv->bv_page - bvec->bv_page) * PAGE_SIZE;
+               BUG_ON(bv->bv_offset >= page_size);
        }
        bv->bv_len = min(page_size - bv->bv_offset,
                         bvec->bv_len - iter_all->done);

The previous code also wasn't handling the case fixed in 6bedf00e55e5
where a split bio might end up splitting a bvec.  That BUG_ON can probably
come out after a few months of testing.

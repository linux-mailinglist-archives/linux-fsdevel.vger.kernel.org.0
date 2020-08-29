Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0525687A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgH2O64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2O6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:58:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F0AC061236;
        Sat, 29 Aug 2020 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lZ/1nHdWsM0stEqTySawdkzFBJIINrqQZQrdzHezIOg=; b=TCYOE32QtYXHxXN0opcVrwM5Mz
        kBQ37SOSJy8j01V9eIlDS81eUB7wNOxLci8NDVQbTQWRfFzr8iKJZ/JEQ0ovCMLfGtjRYma+8oVi3
        4GTrI/hVgiqsk4TiUa2cRVSLeODaBl1P+DEqRJQraWYo59jMIPdcnERuHCe4wKdzg1+kmi7DFhelg
        R7XPoLtbH7pCyVq75ml/4QsU3dxx8VPdS4IcOSKlIwOuPQqKVWQqg3KsTsoFcUzV4XwyzjXaixfIn
        1SkOjl+dNuSLeDzMtGDXOJXSOxQM8ZNIJK/NEznoVucjU3VlUGeXow8D2EsSe7RbxTylDxd4+pA/d
        HB7xWj9Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC2Jd-0003cW-VL; Sat, 29 Aug 2020 14:58:50 +0000
Date:   Sat, 29 Aug 2020 15:58:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iov_iter: introduce iov_iter_pin_user_pages*()
 routines
Message-ID: <20200829145849.GB12470@infradead.org>
References: <20200829080853.20337-1-jhubbard@nvidia.com>
 <20200829080853.20337-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829080853.20337-3-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 01:08:52AM -0700, John Hubbard wrote:
> The new routines are:
>     iov_iter_pin_user_pages()
>     iov_iter_pin_user_pages_alloc()
> 
> and those correspond to these pre-existing routines:
>     iov_iter_get_pages()
>     iov_iter_get_pages_alloc()
> 
> Also, pipe_get_pages() and related are changed so as to pass
> down a "use_pup" (use pin_user_page() instead of get_page()) bool
> argument.
> 
> Unlike the iov_iter_get_pages*() routines, the
> iov_iter_pin_user_pages*() routines assert that only ITER_IOVEC or
> ITER_PIPE items are passed in. They then call pin_user_page*(), instead
> of get_user_pages_fast() or get_page().
> 
> Why: In order to incrementally change Direct IO callers from calling
> get_user_pages_fast() and put_page(), over to calling
> pin_user_pages_fast() and unpin_user_page(), there need to be mid-level
> routines that specifically call one or the other systems, for both page
> acquisition and page release.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/uio.h |   5 ++
>  lib/iov_iter.c      | 110 ++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 107 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 3835a8a8e9ea..29b0504a27cc 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -229,6 +229,11 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages);
>  
>  const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
>  
> +ssize_t iov_iter_pin_user_pages(struct iov_iter *i, struct page **pages,
> +			size_t maxsize, unsigned int maxpages, size_t *start);
> +ssize_t iov_iter_pin_user_pages_alloc(struct iov_iter *i, struct page ***pages,
> +			size_t maxsize, size_t *start);
> +
>  static inline size_t iov_iter_count(const struct iov_iter *i)
>  {
>  	return i->count;
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 5e40786c8f12..f25555eb3279 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1269,7 +1269,8 @@ static inline ssize_t __pipe_get_pages(struct iov_iter *i,
>  				size_t maxsize,
>  				struct page **pages,
>  				int iter_head,
> -				size_t *start)
> +				size_t *start,
> +				bool use_pup)
>  {
>  	struct pipe_inode_info *pipe = i->pipe;
>  	unsigned int p_mask = pipe->ring_size - 1;
> @@ -1280,7 +1281,11 @@ static inline ssize_t __pipe_get_pages(struct iov_iter *i,
>  	maxsize = n;
>  	n += *start;
>  	while (n > 0) {
> -		get_page(*pages++ = pipe->bufs[iter_head & p_mask].page);
> +		if (use_pup)
> +			pin_user_page(*pages++ = pipe->bufs[iter_head & p_mask].page);
> +		else
> +			get_page(*pages++ = pipe->bufs[iter_head & p_mask].page);

Maybe this would become a little more readable with a local variable
and a little more verbosity:

		struct page *page = pipe->bufs[iter_head & p_mask].page;

		if (use_pup)
			pin_user_page(page);
		else
			get_page(page);

		*pages++ = page;


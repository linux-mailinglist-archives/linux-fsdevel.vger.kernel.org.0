Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6103145C81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 20:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgAVTdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 14:33:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVTdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kcpRCIsS+8zPHI9N27JqUU0XiwisZ8cI+0KOaDjpraE=; b=YRxBn3Rbvezdzr+TsmjTNiO/Q
        tGEMNhUpWdydXTRrbh6/NlD7o6FOOKpo7CWlNb4M+OltymMa4moglgAvP96Y7V9BrGKYOhn8WBcg1
        gDs4V24iN7Hc3LVZs0iv0Cw3O2ZH4SJxX9ewjH17PoYrOXEjZgAU9kAjzimYsfqnxW1vLeTlZGGOq
        kYyBCUVbrLaxpbrMh5tWzkOIttVg8tGOeAlau2bM7b+o3Zv23e3ZqoIDCIxp166Paz2BwHhFbWeTA
        FcO4tiMz4gM4HUmd1nVUwjfihan2fy7zx6x5CXGqGoEChKLHyxH97tcEHEhlrAQLgZAHUHZMbQ8Bj
        C2Y5mitYw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuLkQ-0003aF-Li; Wed, 22 Jan 2020 19:33:06 +0000
Date:   Wed, 22 Jan 2020 11:33:06 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] iov_iter: Add ITER_MAPPING
Message-ID: <20200122193306.GB4675@bombadil.infradead.org>
References: <3577430.1579705075@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3577430.1579705075@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 02:57:55PM +0000, David Howells wrote:
> An alternative could be to have an "ITER_ARRAY" that just has the page
> pointers and not the offset/length info.  This decreases the redundancy and
> increases the max payload-per-array-page to 2M.

We could also have an ITER_XARRAY which you just pass &mapping->i_pages
to.  I don't think you use any other part of the mapping, so that would
be a more generic version that is equally efficient.

> +	rcu_read_lock();						\
> +	for (page = xas_load(&xas); page; page = xas_next(&xas)) {	\
> +		if (xas_retry(&xas, page))				\
> +			continue;					\
> +		if (xa_is_value(page))					\
> +			break;						\

Do you also want to check for !page?  That would be a bug in the caller.

> +		if (PageCompound(page))					\
> +			break;						\

It's perfectly legal to have compound pages in the page cache.  Call
find_subpage(page, xas.xa_index) unconditionally.

> +		if (page_to_pgoff(page) != xas.xa_index)		\
> +			break;						\

... and you can ditch this if the pages are pinned as find_subpage()
will bug in this case.

> +		__v.bv_page = page;					\
> +		offset = (i->mapping_start + skip) & ~PAGE_MASK;	\
> +		seg = PAGE_SIZE - offset;			\
> +		__v.bv_offset = offset;				\
> +		__v.bv_len = min(n, seg);			\
> +		(void)(STEP);					\
> +		n -= __v.bv_len;				\
> +		skip += __v.bv_len;				\

Do we want STEP to be called with PAGE_SIZE chunks, or if they have a
THP, can we have it called with larger than a PAGE_SIZE chunk?

> +#define iterate_all_kinds(i, n, v, I, B, K, M) {		\
>  	if (likely(n)) {					\
>  		size_t skip = i->iov_offset;			\
>  		if (unlikely(i->type & ITER_BVEC)) {		\
> @@ -86,6 +119,9 @@
>  			struct kvec v;				\
>  			iterate_kvec(i, n, v, kvec, skip, (K))	\
>  		} else if (unlikely(i->type & ITER_DISCARD)) {	\
> +		} else if (unlikely(i->type & ITER_MAPPING)) {	\
> +			struct bio_vec v;			\
> +			iterate_mapping(i, n, v, skip, (M));	\

bio_vec?

> -#define iterate_and_advance(i, n, v, I, B, K) {			\
> +#define iterate_and_advance(i, n, v, I, B, K, M) {		\
>  	if (unlikely(i->count < n))				\
>  		n = i->count;					\
>  	if (i->count) {						\
> @@ -119,6 +155,9 @@
>  			i->kvec = kvec;				\
>  		} else if (unlikely(i->type & ITER_DISCARD)) {	\
>  			skip += n;				\
> +		} else if (unlikely(i->type & ITER_MAPPING)) {	\
> +			struct bio_vec v;			\
> +			iterate_mapping(i, n, v, skip, (M))	\

again?


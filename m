Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD455E249
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbiF1McQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbiF1McN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8552E9C3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A0AF61555
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71880C3411D;
        Tue, 28 Jun 2022 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656419531;
        bh=BrXJpFc5SPKHipNl4Z7WHwqqttui7QNUe7n/T6riw/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3UL7oXu5quaiLQhwOC+U6KNWt3xtdC44G+kl9JpGhx4q6b2Ec/pNwBgOqZmraUOf
         ojRRfYqAI/8CMoVfw1GGbG135Lc+GDhJJdKhLqoWyQvhKQadXXHaiTC1mT44bhgb9j
         o8GLw+aDaZMlz6cNdEDzsSyPCGGs1sxCEUrcyryj/WPOATSGO0DzSucHqmN/84lpgU
         MIRbublsbwV44UFODPfFVFqOfGH50X4iRWMh/UjlycVMB6mkCJiLoX25DKAupBLpbI
         mM3rHbsjOfJzJJq/B19FPoUYz7NiGkutASfUVi/MSz/iwe3KTKBNw4M53pC9rPAjYn
         VZn0w18ooUjXg==
Date:   Tue, 28 Jun 2022 14:32:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 08/44] copy_page_{to,from}_iter(): switch iovec variants
 to generic
Message-ID: <20220628123205.4mh7luq5lha2c2qe@wittgenstein>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-8-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-8-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:15:16AM +0100, Al Viro wrote:
> we can do copyin/copyout under kmap_local_page(); it shouldn't overflow
> the kmap stack - the maximal footprint increase only by one here.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Assuming the WARN_ON(1) removals are intentional,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

>  lib/iov_iter.c | 191 ++-----------------------------------------------
>  1 file changed, 4 insertions(+), 187 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 6dd5330f7a99..4c658a25e29c 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -168,174 +168,6 @@ static int copyin(void *to, const void __user *from, size_t n)
>  	return n;
>  }
>  
> -static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t bytes,
> -			 struct iov_iter *i)
> -{
> -	size_t skip, copy, left, wanted;
> -	const struct iovec *iov;
> -	char __user *buf;
> -	void *kaddr, *from;
> -
> -	if (unlikely(bytes > i->count))
> -		bytes = i->count;
> -
> -	if (unlikely(!bytes))
> -		return 0;
> -
> -	might_fault();
> -	wanted = bytes;
> -	iov = i->iov;
> -	skip = i->iov_offset;
> -	buf = iov->iov_base + skip;
> -	copy = min(bytes, iov->iov_len - skip);
> -
> -	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_writeable(buf, copy)) {
> -		kaddr = kmap_atomic(page);
> -		from = kaddr + offset;
> -
> -		/* first chunk, usually the only one */
> -		left = copyout(buf, from, copy);
> -		copy -= left;
> -		skip += copy;
> -		from += copy;
> -		bytes -= copy;
> -
> -		while (unlikely(!left && bytes)) {
> -			iov++;
> -			buf = iov->iov_base;
> -			copy = min(bytes, iov->iov_len);
> -			left = copyout(buf, from, copy);
> -			copy -= left;
> -			skip = copy;
> -			from += copy;
> -			bytes -= copy;
> -		}
> -		if (likely(!bytes)) {
> -			kunmap_atomic(kaddr);
> -			goto done;
> -		}
> -		offset = from - kaddr;
> -		buf += copy;
> -		kunmap_atomic(kaddr);
> -		copy = min(bytes, iov->iov_len - skip);
> -	}
> -	/* Too bad - revert to non-atomic kmap */
> -
> -	kaddr = kmap(page);
> -	from = kaddr + offset;
> -	left = copyout(buf, from, copy);
> -	copy -= left;
> -	skip += copy;
> -	from += copy;
> -	bytes -= copy;
> -	while (unlikely(!left && bytes)) {
> -		iov++;
> -		buf = iov->iov_base;
> -		copy = min(bytes, iov->iov_len);
> -		left = copyout(buf, from, copy);
> -		copy -= left;
> -		skip = copy;
> -		from += copy;
> -		bytes -= copy;
> -	}
> -	kunmap(page);
> -
> -done:
> -	if (skip == iov->iov_len) {
> -		iov++;
> -		skip = 0;
> -	}
> -	i->count -= wanted - bytes;
> -	i->nr_segs -= iov - i->iov;
> -	i->iov = iov;
> -	i->iov_offset = skip;
> -	return wanted - bytes;
> -}
> -
> -static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t bytes,
> -			 struct iov_iter *i)
> -{
> -	size_t skip, copy, left, wanted;
> -	const struct iovec *iov;
> -	char __user *buf;
> -	void *kaddr, *to;
> -
> -	if (unlikely(bytes > i->count))
> -		bytes = i->count;
> -
> -	if (unlikely(!bytes))
> -		return 0;
> -
> -	might_fault();
> -	wanted = bytes;
> -	iov = i->iov;
> -	skip = i->iov_offset;
> -	buf = iov->iov_base + skip;
> -	copy = min(bytes, iov->iov_len - skip);
> -
> -	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_readable(buf, copy)) {
> -		kaddr = kmap_atomic(page);
> -		to = kaddr + offset;
> -
> -		/* first chunk, usually the only one */
> -		left = copyin(to, buf, copy);
> -		copy -= left;
> -		skip += copy;
> -		to += copy;
> -		bytes -= copy;
> -
> -		while (unlikely(!left && bytes)) {
> -			iov++;
> -			buf = iov->iov_base;
> -			copy = min(bytes, iov->iov_len);
> -			left = copyin(to, buf, copy);
> -			copy -= left;
> -			skip = copy;
> -			to += copy;
> -			bytes -= copy;
> -		}
> -		if (likely(!bytes)) {
> -			kunmap_atomic(kaddr);
> -			goto done;
> -		}
> -		offset = to - kaddr;
> -		buf += copy;
> -		kunmap_atomic(kaddr);
> -		copy = min(bytes, iov->iov_len - skip);
> -	}
> -	/* Too bad - revert to non-atomic kmap */
> -
> -	kaddr = kmap(page);
> -	to = kaddr + offset;
> -	left = copyin(to, buf, copy);
> -	copy -= left;
> -	skip += copy;
> -	to += copy;
> -	bytes -= copy;
> -	while (unlikely(!left && bytes)) {
> -		iov++;
> -		buf = iov->iov_base;
> -		copy = min(bytes, iov->iov_len);
> -		left = copyin(to, buf, copy);
> -		copy -= left;
> -		skip = copy;
> -		to += copy;
> -		bytes -= copy;
> -	}
> -	kunmap(page);
> -
> -done:
> -	if (skip == iov->iov_len) {
> -		iov++;
> -		skip = 0;
> -	}
> -	i->count -= wanted - bytes;
> -	i->nr_segs -= iov - i->iov;
> -	i->iov = iov;
> -	i->iov_offset = skip;
> -	return wanted - bytes;
> -}
> -
>  #ifdef PIPE_PARANOIA
>  static bool sanity(const struct iov_iter *i)
>  {
> @@ -848,24 +680,14 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
>  static size_t __copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
>  			 struct iov_iter *i)
>  {
> -	if (likely(iter_is_iovec(i)))
> -		return copy_page_to_iter_iovec(page, offset, bytes, i);
> -	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
> +	if (unlikely(iov_iter_is_pipe(i))) {
> +		return copy_page_to_iter_pipe(page, offset, bytes, i);
> +	} else {
>  		void *kaddr = kmap_local_page(page);
>  		size_t wanted = _copy_to_iter(kaddr + offset, bytes, i);
>  		kunmap_local(kaddr);
>  		return wanted;
>  	}
> -	if (iov_iter_is_pipe(i))
> -		return copy_page_to_iter_pipe(page, offset, bytes, i);
> -	if (unlikely(iov_iter_is_discard(i))) {
> -		if (unlikely(i->count < bytes))
> -			bytes = i->count;
> -		i->count -= bytes;
> -		return bytes;
> -	}
> -	WARN_ON(1);
> -	return 0;
>  }
>  
>  size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
> @@ -896,17 +718,12 @@ EXPORT_SYMBOL(copy_page_to_iter);
>  size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
>  			 struct iov_iter *i)
>  {
> -	if (unlikely(!page_copy_sane(page, offset, bytes)))
> -		return 0;
> -	if (likely(iter_is_iovec(i)))
> -		return copy_page_from_iter_iovec(page, offset, bytes, i);
> -	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
> +	if (page_copy_sane(page, offset, bytes)) {
>  		void *kaddr = kmap_local_page(page);
>  		size_t wanted = _copy_from_iter(kaddr + offset, bytes, i);
>  		kunmap_local(kaddr);
>  		return wanted;
>  	}
> -	WARN_ON(1);
>  	return 0;
>  }
>  EXPORT_SYMBOL(copy_page_from_iter);
> -- 
> 2.30.2
> 

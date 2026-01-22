Return-Path: <linux-fsdevel+bounces-75134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bg/BCZpcmnckQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:15:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE986C274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF023004241
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC3366831;
	Thu, 22 Jan 2026 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fImvKL0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701E353EEB;
	Thu, 22 Jan 2026 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104451; cv=none; b=T75+6b0ip8JYyD0mZR8uf3K773GugWtngzstv9yof35sMRi/WT7JlNOsYOUtf7EJawiIef3JeJCbEcTNIU8EfApf9oVarSe9KnLjeWdubST58IGaIkq+mVpxDwf5XEYqS/4A5WK7rICkgu02/rCjjT7iBQKPqWOwMdC5d8zVfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104451; c=relaxed/simple;
	bh=3F9xs/Wx5X8eUulHYb7gq4GDQ1Z7/z4zRETNhjtaUM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG16GlNZ2OixqI0kWdsklfgILib/NldBUPs0REFyNNqIlo36xv3OryANFPpr092sWmlwKl+EffbxQYM6nvuLVm8tUdrXH+9xaspaxp+oNktWcpYvb3zKKyBWxBgIoCKKnNCiuEyOznJ3HrBILI6LTvn2lQiDxPvMDU3/0VMnEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fImvKL0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D001AC116D0;
	Thu, 22 Jan 2026 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769104449;
	bh=3F9xs/Wx5X8eUulHYb7gq4GDQ1Z7/z4zRETNhjtaUM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fImvKL0IxYCGNU456oEDCT9+++DuwQeQdblK+uLoiEifeJpu0ZQG7m7xWox5cssz7
	 F3w+dUWJssCC8slwI324TTVw1/xH+Yu4U94kFeYRIIMbm8ty8cEZESHJWssRfqqb3z
	 MjirhOqEens+4sJg5ldS89YlRpinnqYUPco31BJCU2NwaZ1YHs9HYTfZeJkXDWGtDp
	 SmCBmo1pLVlpse0IKbCWYVEEdieAJTT4Oxx5Z12CqH0LasSec9n4QQ6NclXKI5C/dM
	 D95R9XQgB9neT87nXcEPAm+RU3Tao1bVuijPnHBIwpPrLePujTrpEwGgO6nti1/JVg
	 r2xbmKSE8Zzqw==
Date: Thu, 22 Jan 2026 09:54:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/14] block: refactor get_contig_folio_len
Message-ID: <20260122175409.GY5945@frogsfrogsfrogs>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074425.4005867-2-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75134-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 6CE986C274
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 08:44:08AM +0100, Christoph Hellwig wrote:
> Move all of the logic to find the contigous length inside a folio into
> get_contig_folio_len instead of keeping some of it in the caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I like that this change makes it easier for me to guess what
get_contig_folio_len does just by looking at the arguments.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bio.c | 62 +++++++++++++++++++++++------------------------------
>  1 file changed, 27 insertions(+), 35 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 2359c0723b88..18dfdaba0c73 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1172,33 +1172,35 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
>  	bio_set_flag(bio, BIO_CLONED);
>  }
>  
> -static unsigned int get_contig_folio_len(unsigned int *num_pages,
> -					 struct page **pages, unsigned int i,
> -					 struct folio *folio, size_t left,
> +static unsigned int get_contig_folio_len(struct page **pages,
> +					 unsigned int *num_pages, size_t left,
>  					 size_t offset)
>  {
> -	size_t bytes = left;
> -	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, bytes);
> -	unsigned int j;
> +	struct folio *folio = page_folio(pages[0]);
> +	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, left);
> +	unsigned int max_pages, i;
> +	size_t folio_offset, len;
> +
> +	folio_offset = PAGE_SIZE * folio_page_idx(folio, pages[0]) + offset;
> +	len = min(folio_size(folio) - folio_offset, left);
>  
>  	/*
> -	 * We might COW a single page in the middle of
> -	 * a large folio, so we have to check that all
> -	 * pages belong to the same folio.
> +	 * We might COW a single page in the middle of a large folio, so we have
> +	 * to check that all pages belong to the same folio.
>  	 */
> -	bytes -= contig_sz;
> -	for (j = i + 1; j < i + *num_pages; j++) {
> -		size_t next = min_t(size_t, PAGE_SIZE, bytes);
> +	left -= contig_sz;
> +	max_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> +	for (i = 1; i < max_pages; i++) {
> +		size_t next = min_t(size_t, PAGE_SIZE, left);
>  
> -		if (page_folio(pages[j]) != folio ||
> -		    pages[j] != pages[j - 1] + 1) {
> +		if (page_folio(pages[i]) != folio ||
> +		    pages[i] != pages[i - 1] + 1)
>  			break;
> -		}
>  		contig_sz += next;
> -		bytes -= next;
> +		left -= next;
>  	}
> -	*num_pages = j - i;
>  
> +	*num_pages = i;
>  	return contig_sz;
>  }
>  
> @@ -1222,8 +1224,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
>  	ssize_t size;
> -	unsigned int num_pages, i = 0;
> -	size_t offset, folio_offset, left, len;
> +	unsigned int i = 0;
> +	size_t offset, left, len;
>  	int ret = 0;
>  
>  	/*
> @@ -1244,23 +1246,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		return size ? size : -EFAULT;
>  
>  	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> -	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
> -		struct page *page = pages[i];
> -		struct folio *folio = page_folio(page);
> +	for (left = size; left > 0; left -= len) {
>  		unsigned int old_vcnt = bio->bi_vcnt;
> +		unsigned int nr_to_add;
>  
> -		folio_offset = ((size_t)folio_page_idx(folio, page) <<
> -			       PAGE_SHIFT) + offset;
> -
> -		len = min(folio_size(folio) - folio_offset, left);
> -
> -		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> -
> -		if (num_pages > 1)
> -			len = get_contig_folio_len(&num_pages, pages, i,
> -						   folio, left, offset);
> -
> -		if (!bio_add_folio(bio, folio, len, folio_offset)) {
> +		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
> +		if (!bio_add_page(bio, pages[i], len, offset)) {
>  			WARN_ON_ONCE(1);
>  			ret = -EINVAL;
>  			goto out;
> @@ -1275,8 +1266,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  			 * single pin per page.
>  			 */
>  			if (offset && bio->bi_vcnt == old_vcnt)
> -				unpin_user_folio(folio, 1);
> +				unpin_user_folio(page_folio(pages[i]), 1);
>  		}
> +		i += nr_to_add;
>  		offset = 0;
>  	}
>  
> -- 
> 2.47.3
> 
> 


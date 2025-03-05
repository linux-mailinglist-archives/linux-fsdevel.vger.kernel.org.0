Return-Path: <linux-fsdevel+bounces-43204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF1A4F482
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 03:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC89D16F75F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 02:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B857C152E12;
	Wed,  5 Mar 2025 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmSlFTpD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF8DF5C;
	Wed,  5 Mar 2025 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140960; cv=none; b=BNhZcfvj5UMur8pFjGjX4K01llTZABgkv/gwhR9INbiVKnMhFwDk10v5yMt5RbbFTZglmeH3k1gVYAGYIEQgk6GUXudMSORODs6Tx62NSa/rYrU8UTYccKQqQVumC+30ywWFd+4iZSRjyzDPMVZYgl4/wvXySikaeMDHtb7iYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140960; c=relaxed/simple;
	bh=HrTE4/dsZ1WOZns7PZXyGnQ+Hayn0r6Z+pnAOXHtrEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlsAQWNeyBGk5nGSGiZyC20lRarnXA1E7jRk2PdUYlNF3oPUUTEh+i9XEyTYA71wpf645YFEz6EJH0FwqGmzfOniP/49VCu5cUJN26Yk1/txBL5Z6UpWHvvTQYQJulPTwIa12XaA7ThW8dBauNW99s98xuAOc3nvbsQg1DkSx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmSlFTpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0D7C4CEE5;
	Wed,  5 Mar 2025 02:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741140959;
	bh=HrTE4/dsZ1WOZns7PZXyGnQ+Hayn0r6Z+pnAOXHtrEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmSlFTpDqYyENMRU9+6WyBwMtku2KWD3sGx0ufCS2x9/yDhq8dzDhVryIkoiev2vX
	 Tg2JoLVfoXqPvsfRSxHMTiB4vFJnfbogIxlBitwgeDUDoyuRSJewUTtVdHii0aT5iT
	 g7LomQgTynH//1RGJR3yBAAdGW4z9uI3kqsKy9OBeE36yfDm0v+iV94IUqPekW89Oa
	 j3aFSPJADsk0U6XYAB+6ipo+gm11Zl6IxC3zKqD430B2M0tC4eJRRfqYqUqE0Ifj9H
	 PKg3iDUvir29uP3SycqIO9K/hurclUGTUIF6zs2ALUO2BDV8Ur7zflKErQ79uwKwCP
	 u6U9OduUqLXKQ==
Date: Tue, 4 Mar 2025 18:15:57 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fscrypt: Change fscrypt_encrypt_pagecache_blocks() to
 take a folio
Message-ID: <20250305021557.GA20133@sol.localdomain>
References: <20250304170224.523141-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304170224.523141-1-willy@infradead.org>

On Tue, Mar 04, 2025 at 05:02:23PM +0000, Matthew Wilcox (Oracle) wrote:
> ext4 and ceph already have a folio to pass; f2fs needs to be properly
> converted but this will do for now.  This removes a reference
> to page->index and page->mapping as well as removing a call to
> compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> This is against next-20250304 and will have conflicts with the ceph tree
> if applied to mainline.  It might be easiest for Christian to carry it?

That's fine with me.

Acked-by: Eric Biggers <ebiggers@kernel.org>

> +struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
> +		size_t len, size_t offs, gfp_t gfp_flags)
>  {
> -	const struct inode *inode = page->mapping->host;
> +	const struct inode *inode = folio->mapping->host;
>  	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
>  	const unsigned int du_bits = ci->ci_data_unit_bits;
>  	const unsigned int du_size = 1U << du_bits;
>  	struct page *ciphertext_page;
> -	u64 index = ((u64)page->index << (PAGE_SHIFT - du_bits)) +
> +	u64 index = ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
>  		    (offs >> du_bits);
>  	unsigned int i;

'i' should be changed to size_t to match len and offs.

>  	int err;
>  
> -	if (WARN_ON_ONCE(!PageLocked(page)))
> +	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> +	if (WARN_ON_ONCE(!folio_test_locked(folio)))
>  		return ERR_PTR(-EINVAL);

I'm not sure you considered using VM_WARN_ON_ONCE_FOLIO() here?  TBH I'm fine
with BUG_ON, but sometimes people complain about it.  That's why fs/crypto/
sticks to WARN_ON_ONCE these days.

- Eric


Return-Path: <linux-fsdevel+bounces-17569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD708AFCA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 01:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262D11C221E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 23:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A7F3FB94;
	Tue, 23 Apr 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/1ENwD6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F22D7B8;
	Tue, 23 Apr 2024 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915281; cv=none; b=IzTstIB/bvxEj/upnDTqtG6tXQvrTsFQ91QDfiD/BObZPhpw9FP0sVQvrwtNKtC2U4RVfiit2VJULpsF4M1GVbY1Il5oBv7vTLEsoR2+aPRzpqEHGTaWcF2leuCA4dRUzaDStm0eDWE85Z+trFma/S+VhT4eaUAftDGyZsiAtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915281; c=relaxed/simple;
	bh=LzAcy+XvCVX5N1spjFF+GDeLAm7nYydUoetmvgeGi/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViW2NdSCVLZqbM2e6EwiP5Y9iFWzHnj0rpIIC5z2RcFBmmwc0iooz5R9xaf9q2hbV9KKX3ubz2Bub9fz/0v9g0spxoSN55772wFSluunP3QY70a5aSEQ4KTZ4zFDbhVJ6db0E9ogLoGnNVeJnWVhmkNrGQR0LNZFlsMCi3CWQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/1ENwD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68753C3277B;
	Tue, 23 Apr 2024 23:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713915280;
	bh=LzAcy+XvCVX5N1spjFF+GDeLAm7nYydUoetmvgeGi/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/1ENwD6whocj16yE+tzly6+1EzemOrzDFOidz4hWg6YPzpZ71V7ES1bnNGqxg9PJ
	 fA+oIyAFE99cmHim7k7KvUsyk+dcmKN0WIRnNEOVG1aUbqEwufskeV3UIi97C3236h
	 /YjiKBCC/GMgnUNPiLCOYKpF9Qmf3QZUEUe6lAmbxCI32pbhhslIvTJC9I8w5daD4Y
	 V6f+XG24TvcgcCwXu3BuVkCKFtYVSyUcePaDWoApXnLfm5cYTMGg+YMRa+PrMkexgn
	 Sdv3fxNpFUqiO4gZxd1KOxNR0hZbsI26O5UblDywQmpVZinlNumBJdt2CqOeZgmfal
	 2ydpow0owFuHw==
Date: Tue, 23 Apr 2024 16:34:38 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/6] fscrypt: Convert bh_get_inode_and_lblk_num to use a
 folio
Message-ID: <20240423233438.GA32430@sol.localdomain>
References: <20240423225552.4113447-1-willy@infradead.org>
 <20240423225552.4113447-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423225552.4113447-2-willy@infradead.org>

On Tue, Apr 23, 2024 at 11:55:32PM +0100, Matthew Wilcox (Oracle) wrote:
> Remove uses of page->index, page_mapping() and b_page.  Saves a call
> to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/crypto/inline_crypt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index b4002aea7cdb..40de69860dcf 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -284,7 +284,7 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
>  				      const struct inode **inode_ret,
>  				      u64 *lblk_num_ret)
>  {
> -	struct page *page = bh->b_page;
> +	struct folio *folio = bh->b_folio;
>  	const struct address_space *mapping;
>  	const struct inode *inode;
>  
> @@ -292,13 +292,13 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
>  	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
>  	 * for a non-pagecache page.  fscrypt doesn't care about these.
>  	 */
> -	mapping = page_mapping(page);
> +	mapping = folio_mapping(folio);
>  	if (!mapping)
>  		return false;
>  	inode = mapping->host;
>  
>  	*inode_ret = inode;
> -	*lblk_num_ret = ((u64)page->index << (PAGE_SHIFT - inode->i_blkbits)) +
> +	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
>  			(bh_offset(bh) >> inode->i_blkbits);
>  	return true;
>  }

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


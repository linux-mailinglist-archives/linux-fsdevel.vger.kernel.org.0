Return-Path: <linux-fsdevel+bounces-34648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43989C72AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA7D28294D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB92038D3;
	Wed, 13 Nov 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="inGQxMTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3020262B;
	Wed, 13 Nov 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506826; cv=none; b=ZKFFY9RuN7mkVVnUtU4ODFjx6SDgEuMdSBU4hVQ2V31iC1AfpQKjGFEWmXBLOcX0BfX60ZUGmIW/hC0wQUPF6RqTSKcH5+fN6GL5u52LMkXLwKWnZHfYdQnFYI5E55H44kPYWxK9HIYIdjpWADX9Qa5FyKy1ESd3HLJLlxsECeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506826; c=relaxed/simple;
	bh=hvrsf78D8NDDYEOvAPxQVc4YqoPVqijYme2H01oDTdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3b163qeQKrXmW3w+Imskm2JmDAB3eD5to+rurr0HJ8iFk6Bf3M+WK7bok6shMPfnpJIMwDs1pum0TpjjtS+VDhg7SwiL7y3//kcZAsV74LnOkXsplE6OyYzRmoKjmSBzu1QlqF2XD6lFTChWMeUz5fIecGsaY2En1NNCQ/ltkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=inGQxMTw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KJXNvaen1Bz/rhEZ0wYr3yvxXXNeIsAd3hY4qgJzB/M=; b=inGQxMTwLPZKyqpgIPyzxCSSm6
	bLCxt2bPzP7//fGxa1Rbqys8CPMTp/GYxKU+oA17V9AdpIfXRuq22xedRJS4TsaPdad/Q6C/d4+fy
	S07P45BSBklhLxAE5DYtOXrp1wfrAAmUpPCA3zOnljEqgNdpJoQuUDUo2t5myQ/dWxnT5cbB/vpwN
	MgdBXDNpr3W8hozvV5d1tFsSIGoGWhx1FDCcspDR9ZBz2ZQMHhlyTJ9YxkU4raQ9NKDYL0l1oO/XV
	fWPpM9Tsal3SHug4dR0UtihyzJouDViAWvGdzL/yqVrmO/CLmaj0VmrNDJtAKfnoFgwH2a2QqwHBX
	s1eWsa7A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBE1K-0000000GRES-1KUI;
	Wed, 13 Nov 2024 14:06:58 +0000
Date: Wed, 13 Nov 2024 14:06:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@lst.de, hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com, Hannes Reinecke <hare@kernel.org>
Subject: Re: [RFC 2/8] fs/mpage: avoid negative shift for large blocksize
Message-ID: <ZzSygjfVvyrV1jy6@casper.infradead.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-3-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113094727.1497722-3-mcgrof@kernel.org>

On Wed, Nov 13, 2024 at 01:47:21AM -0800, Luis Chamberlain wrote:
> +++ b/fs/mpage.c
> @@ -181,7 +181,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  	if (folio_buffers(folio))
>  		goto confused;
>  
> -	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
> +	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);

	block_in_file = folio_pos(folio) >> blkbits;
?

> @@ -527,7 +527,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
>  	 * The page has no buffers: map it to disk
>  	 */
>  	BUG_ON(!folio_test_uptodate(folio));
> -	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
> +	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);

Likewise.


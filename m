Return-Path: <linux-fsdevel+bounces-12861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCC5867F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ADA1F2F49C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D32312EBDE;
	Mon, 26 Feb 2024 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JGn+ddpk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77012C815;
	Mon, 26 Feb 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970329; cv=none; b=fXw9A1/6MkgSmvUxMdIWrqnVhOoVtVViKNylQgz6I7COLnD4yVyPLYkJASimjE273Tt23K4niLpyyf72VMnJoHHjQtRnxIlD731RmqP4vbk8tMsFwqFd/7kcxHKY87scVSm3UKU8c4Go6CjPmZ/Gr0+K8fvJKElxZDDtPC5EIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970329; c=relaxed/simple;
	bh=JCKGyXmXmi33uTluuNOUyXMVPJdU5wG6Bzr+GONc22A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr1A8LyvAMFv23tMqK0gxvrDKW6n/AcYw7xJiqJIJAvSmxw9yb1NBrkSKu1qZ4h3u0fLVzNUgXQI5W1xmCRMKWOmTdlsct28EGwRtaeZYaEn+KxMnXd9t1IW0MAOYuWv2tiEZf9OXuZ523sbU8J43U2lg7rVy5KnLqx1Q95HnD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JGn+ddpk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=29RQZolZJ+S71Y+xqolEPeXKycR8yatJmFhICqJiOuE=; b=JGn+ddpkrdBTTW6om/gUMcO+ha
	pBUlwhCxIymXSDTVQ2PS/YUum0YlBaQoERJsHAfkOI0kU8bdOq2WUcqzjFm+7NInu9R7M9ZNEgjh9
	BfTnjLwVQVeMt9hDDFVhKdHgQqtHkPljk7v9WPXSF+KYsC4utfxOQP4E8S9kKY19GIEZvBEzCD3bV
	mbrA/wD0H633S2uXVjCXsvoZzexM8sEeU67m6PvCd4zuC5uLp8o4svfLErdr6IlyPca2T6zjNxXQn
	eepmZFZCY/LmfekHWR5QnZX0D3SCKQw1oYZ0IdjbqhpG937wvZ70jZCPrxxR189CiHAJ6CfuxuqHI
	iAkwOwQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1refFT-00000000Dcf-1Gir;
	Mon, 26 Feb 2024 17:58:43 +0000
Date: Mon, 26 Feb 2024 17:58:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, djwong@kernel.org,
	gost.dev@samsung.com, linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 10/13] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZdzRU0sMqFYlNC01@casper.infradead.org>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094936.2677493-11-kernel@pankajraghav.com>

On Mon, Feb 26, 2024 at 10:49:33AM +0100, Pankaj Raghav (Samsung) wrote:
> +++ b/fs/iomap/direct-io.c
> @@ -239,14 +239,23 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  	struct page *page = ZERO_PAGE(0);
>  	struct bio *bio;
>  
> -	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> +	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
> +
> +	bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> +				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  				  GFP_KERNEL);
> +
>  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	__bio_add_page(bio, page, len, 0);
> +	while (len) {
> +		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> +
> +		__bio_add_page(bio, page, io_len, 0);
> +		len -= io_len;
> +	}

I thought we were going to use the huge_zero_page for this?


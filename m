Return-Path: <linux-fsdevel+bounces-18916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B18A8BE868
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AFFB286CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C7016C69B;
	Tue,  7 May 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SpiBK44a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC81649D3;
	Tue,  7 May 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097638; cv=none; b=l/pHSOcT6el9wIdkcrKKigHNyeTAs/jj/Uy6mx4YI3ZEfuWPmgfQyfs5dkUCkVKI1bo/2rF4aQEc+9yqc6BJJiv5dtCeWkR/x0P7SUkY2j2fyawp1SdMjTlwF2kHoYTMc3PwXFVsYp+VSrXdAQrqiiYBTDlZUWpK4xP1go8//M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097638; c=relaxed/simple;
	bh=6+Gkl/pRAYqQQn7gSCq0pRNOmE+2kE7WdPcvYkYcoPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhtbGMXZhT1ceOijliAQH+37TTlL7NtGGg3pcIgWNofePTXyHCHC3I0vH7+5shOHR08CPvmEIlFQ/R8nmzr/wuZV/5udQvGNuXy0sW3t6IF1/d6mlbxqaiveW4R74S+07WS+aCFEvZGS/3xlmpqPGBdH+T2Caf20TkV4x81KX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SpiBK44a; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ry5qXfj/Y6VuUjlQ1iK9ZLpA72CsG7mprzoo7D4E3bg=; b=SpiBK44aWoWuuaBLExkMFMiHu6
	59YnYanRygofKHL+QFtmNCWPfEw5RUMULVykGljX/cX6mslfgct4hX/Wmz2hesYaVwBdaPy7U9TET
	6af/i+mb+e6B+B0gbG7i4Kzmtaf8SX+ITnr2SEjC7gzbazcSUGiKHfdJKav8LffZ47Gd1/VLK9kgV
	WrL8V6l3wZUt8T+QH7TCNmp8Hc79tPUppdhsue2bmXiGg+LIOq+/QBSSc+d0xPE2FqVxQt36LSa0Q
	DIzTOUjF/P7IySbT2YfZUOsWQbZMdNg0BqEerQcLYx8+Xmrw2if9KkAMTAjsg/crFC0494N6pwsRn
	jxH6214A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4NEy-0000000DYyd-30hx;
	Tue, 07 May 2024 16:00:28 +0000
Date: Tue, 7 May 2024 17:00:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com, hare@suse.de,
	ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v5 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZjpQHA1zcLhUZa_D@casper.infradead.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-8-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503095353.3798063-8-mcgrof@kernel.org>

On Fri, May 03, 2024 at 02:53:49AM -0700, Luis Chamberlain wrote:
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
>  	iomap_dio_submit_bio(iter, dio, bio, pos);

If the len is more than PAGE_SIZE * BIO_MAX_VECS, __bio_add_page()
will fail silently.  I hate this interface.

You should be doing something like ...

	while (len) {
		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);

		while (!bio || bio_add_page() < io_len) {
			if (bio)
				iomap_dio_submit_bio(iter, dio, bio, pos);
			bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
					REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
		 	fscrypt_set_bio_crypt_ctx(bio, inode,
					pos >> inode->i_blkbits, GFP_KERNEL);
		}
	}


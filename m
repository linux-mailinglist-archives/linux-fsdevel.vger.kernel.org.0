Return-Path: <linux-fsdevel+bounces-11388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D87853605
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6941C26BF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274826AD7;
	Tue, 13 Feb 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YskmkGD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895EBA2D;
	Tue, 13 Feb 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841839; cv=none; b=RBo5oMPY3pLb7+OzwXcapXPaHayykD5+LtzmrggOjlaMXFk9ZqoKv91sQWoHg7StLUrtd9icEC6qzDH5uOELYqlVN+ceVE9rNTH/2Ej/lWlf+u/TcMP0AGwZH1woxcB+J/j0/dZ7eeY+b4n55evTOWg4gpkOqFvtNerIR2jqd+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841839; c=relaxed/simple;
	bh=hMxkyWbU9VziSWd2szBRjdbMM8H6CHlLIrWJd+iY0Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFK9KvYIYLVCFP1SMg8Sfc+T0bKNNQgSAf6yQ2V7ia8D88zdFTcoJuijgq5EB3xjpqUyxGcIh+18hauEYh9qAneO2W0F1l78JDnUUghm2S7752GOTfUuB29RwrqBkwxaZ7aIELXM4J6N1X8Ifn1g8qo+rJf16ZxvgPZe9mA+0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YskmkGD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CA5C433C7;
	Tue, 13 Feb 2024 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841838;
	bh=hMxkyWbU9VziSWd2szBRjdbMM8H6CHlLIrWJd+iY0Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YskmkGD7Xmy8wrH9BYZ8OAidJ3RZKciXSWaiiJlpmFlBevuKSQxq96FFEABloZzrT
	 mnVmrf7tMi4wB1+qAuP3Ygs6DOqwaePDcHJ05v0hC65Q/p9Uz+eekZrBapEqWU5/8+
	 hHkRMTJvaFK7rWs3VaKssashfMq4kzsMksFlRrc0yUZd2LdHY4VEqHzxA1KL84j7N4
	 d7l3lbEuKapaoQNS7IFdMO05XItoZF6o/wpMmJoFVVfpHIftP0lmxY/itQFq2AJDQ4
	 5+ZLccg8Xw6RKTF2alntVOML74AHDV34irK/Oj0bs4+vyUxwrZl9GpRnAYi3kohV/Y
	 /gGgI1ys/2G2g==
Date: Tue, 13 Feb 2024 08:30:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 10/14] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240213163037.GR6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-11-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:09AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/iomap/direct-io.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bcd3f8cf5ea4..04f6c5548136 100644
> --- a/fs/iomap/direct-io.c
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

What was the result of all that discussion about using the PMD-sized
zero-folio the last time this patch was submitted?  Did that prove to be
unwieldly, or did it require enough extra surgery to become its own
series?

(The code here looks good to me.)

--D

> +
> +		__bio_add_page(bio, page, io_len, 0);
> +		len -= io_len;
> +	}
>  	iomap_dio_submit_bio(iter, dio, bio, pos);
>  }
>  
> -- 
> 2.43.0
> 
> 


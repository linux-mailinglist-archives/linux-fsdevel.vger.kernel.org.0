Return-Path: <linux-fsdevel+bounces-5275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B8809596
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D111C20AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FEC57319
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neI12TK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EC840C4;
	Thu,  7 Dec 2023 22:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20215C433C8;
	Thu,  7 Dec 2023 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701987016;
	bh=sBNd3oxL6+a22NEO/VDNFOidep38poCkeBZb+XkzywM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neI12TK/fHjGgZNDnLArNdLQEFClIYknp5Ch25AvJ3uzwa2mhmCuGfWn6SZmc4Xyh
	 gQMahdRIXK77n5/TMkaJuK/OTaGAPpUr8VBnnr4q3wtd7Fji08gZbr7yFVPHi4KIgb
	 kPw8zNI7nHJ/VS+tzDxLN1M0wA5VuigBoMI9/5Yj/pDRS49Sl+6w9ez2hmAT7NjNC7
	 qQdXIGld6g178tGepH6B2006iUsLwQmpAinMxrh1bo76odHAfwiueeCK5A2UhUESZZ
	 nVUMpRinVsxy8gbJ5s20Klo6zNQG6cK7+fyob9qhJiofGyOE3G4twLx4NuUzZqYJo8
	 EHr/yFHXpV51A==
Date: Thu, 7 Dec 2023 15:10:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <ZXJCxbAm1_V7lPnF@kbusch-mbp>
References: <20230814144100.596749-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814144100.596749-1-willy@infradead.org>

On Mon, Aug 14, 2023 at 03:41:00PM +0100, Matthew Wilcox (Oracle) wrote:
>  void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
> -	struct bvec_iter_all iter_all;
> -	struct bio_vec *bvec;
> +	struct folio_iter fi;
> +
> +	bio_for_each_folio_all(fi, bio) {
> +		struct page *page;
> +		size_t done = 0;
>  
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		if (mark_dirty && !PageCompound(bvec->bv_page))
> -			set_page_dirty_lock(bvec->bv_page);
> -		bio_release_page(bio, bvec->bv_page);
> +		if (mark_dirty) {
> +			folio_lock(fi.folio);
> +			folio_mark_dirty(fi.folio);
> +			folio_unlock(fi.folio);
> +		}
> +		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> +		do {
> +			bio_release_page(bio, page++);
> +			done += PAGE_SIZE;
> +		} while (done < fi.length);
>  	}
>  }

Is it okay to release same-folio pages while creating the bio instead of
releasing all the pages at the completion? If so, the completion could
provide just the final bio_release_page() instead looping. I'm more
confirming if that's an appropriate way to use folios here.


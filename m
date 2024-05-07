Return-Path: <linux-fsdevel+bounces-18921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DE68BE872
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558DD1C24228
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A816C694;
	Tue,  7 May 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HQUiArRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498916ABE8;
	Tue,  7 May 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098325; cv=none; b=AbbTU34A5CKE4d7ZQGpEW1BO7mc47m7rGtu+TU2Km3qRuZvkRqRP5oE3xyi5xDgJ87Be+ekFY8cumGcBTxPtN8suZXWWowNOmBoFpxrl3LUdPZqHuVJFoEJ2RhsVVU1sawrQAqLbNTRrjNfYyrtUuqJrbx8xDPa5miDH7kgCsi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098325; c=relaxed/simple;
	bh=32D9Avvo/JmPxk6s4LLVVPFdTG7yE78G0MZWlCvl7wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQkW9Diz4q6wPttvjpF5Wpu4YJIJULES4/7Ze8B4c6WWsJeyNS0tuzcbheggAQrnsGb2jHyuXCqFo2XgvjjPUNcsLWGuyh0zUGg4tYgM37BVStPO05mHNuNo4wretTyALDWIvTTOJ2IupF7A0HvkhQABgPgc6ymJjzMJdCpxkD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HQUiArRA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WsCCissf8szKJC0YOGfb02GAiXDtjCBGSd20eGfpyFQ=; b=HQUiArRAxQpVcgnY87kkoL/vVH
	mVNUZPzv3tlcOtZpBrMMNgMnev0FcQCOZPgGRE4HarTjgyECeI97T68rHasPAbF7ojRzJA1PgdG91
	D87zQsWXKvH8cOeh0Mf56yB3gh7Pw+DhU27acAmatmIxjy7Jy/mqFY54cbWEK+SifjODYySDfZ8hs
	+7dvyiLOaiVnIXKvpg0+BdD20CU3U/8gsiRlEhnMPwesB08UlTnTo2Da8EbczxjovXLRwS3al+0Xg
	qKHk9cBrHB/4DlkkjRR2MzhqK6PvaL8+qV4O00S6Rj+IVfxSuGFOQwNm+9kAQHmagNWp4rUF+81O9
	XdQ9nilQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4NQ6-0000000Dafv-1f0L;
	Tue, 07 May 2024 16:11:58 +0000
Date: Tue, 7 May 2024 17:11:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v5 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZjpSzi-HiZkx_Kdq@casper.infradead.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-8-mcgrof@kernel.org>
 <ZjpQHA1zcLhUZa_D@casper.infradead.org>
 <ZjpSZ2KjpUHPs_1Z@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpSZ2KjpUHPs_1Z@infradead.org>

On Tue, May 07, 2024 at 09:10:15AM -0700, Christoph Hellwig wrote:
> On Tue, May 07, 2024 at 05:00:28PM +0100, Matthew Wilcox wrote:
> > If the len is more than PAGE_SIZE * BIO_MAX_VECS, __bio_add_page()
> > will fail silently.  I hate this interface.
> 
> No, it won't.  You can pass an arbitray len to it.
> 
> > 
> > You should be doing something like ...
> > 
> > 	while (len) {
> > 		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> > 
> > 		while (!bio || bio_add_page() < io_len) {
> > 			if (bio)
> > 				iomap_dio_submit_bio(iter, dio, bio, pos);
> > 			bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> > 					REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> > 		 	fscrypt_set_bio_crypt_ctx(bio, inode,
> > 					pos >> inode->i_blkbits, GFP_KERNEL);
> > 		}
> > 	}
> 
> Wee, no.  The right way is:
> 
> 	bio = iomap_dio_alloc_bio(iter, dio, 1,
> 			REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> 	__bio_add_page(bio, page, len, 0);

no?  len can be > PAGE_SIZE.  and that can be true in the folio version
too, because we won't necessarily be able to allocate the THP.

> 	fscrypt_set_bio_crypt_ctx(bio, inode,
> 			pos >> inode->i_blkbits, GFP_KERNEL);
> 
> (or even better the folio version)


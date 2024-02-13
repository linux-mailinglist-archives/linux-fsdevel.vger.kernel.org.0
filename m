Return-Path: <linux-fsdevel+bounces-11437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A877B853D2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86D01C27B97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5547461678;
	Tue, 13 Feb 2024 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7eXOBiu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4A4501B;
	Tue, 13 Feb 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859841; cv=none; b=UO9MHRXroS0L+mH5TjQsqCMLy7G5pXxetMtqM++1ghN5gHGoBJZ8/SISet/PI/HQsZZf5joocfAIl3GnP36QV95a3Wakjk5E4J3I2D3+v2QALTXGTdM9Ft018w7F9z+qfYvK02qOiwD0wlaF+748rk7W28Ow43IVwdrAqRxmaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859841; c=relaxed/simple;
	bh=9X9GQyhvkWNmvG1Gu8mRVXEfxB+77vFWQKzoIce99lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXIqACJ6ev+pZPXnSDwZTCXT8fycjKmSi7iap0ZrlvLGbDd1pCiSSjzF0xNvmN/OGv8X2JeIrl0upag8PH0HNxQvLBhAs3WKWyt3ZdIW8fqyF/2PJfTZvROwgxwmp56K3Ie/Mxnaq7c0eyMgHLhEKWffw94EOgl5b3p/Y/VCPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7eXOBiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C8BC433C7;
	Tue, 13 Feb 2024 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707859841;
	bh=9X9GQyhvkWNmvG1Gu8mRVXEfxB+77vFWQKzoIce99lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7eXOBiuggM/wGeuiUFMm3PU3dXQ+ZLqQrv6ZQn/m/9yK7QHfgK6lhTagkIPxZBq6
	 bRlmV8vbS3wCXcSFKQeQO3MoXu0uu9s8uLiC6eEf09qYaFBybPdo9ZbcDvGT1ISe7a
	 Ccn/2uag8Bvt60GxJhqjkPaleE9NshSYrPdF2Qi1dpW8OEgUDl1LrI4iKpm1UcpaYa
	 oH6UglTMhfeRit7IDGYuG3wOUILzp6RrBwrXP5AVKx1N+vSlmpDfJP1pzEYZVrNRxS
	 o0/DeMbvaCpPKCmmsq4sIMfsj0FNOkzy42gmHMJKDaIgCmSkhU7naIYnEQ1IegB34t
	 DdxVA7WqDOJYw==
Date: Tue, 13 Feb 2024 13:30:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 10/14] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240213213040.GX616564@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-11-kernel@pankajraghav.com>
 <20240213163037.GR6184@frogsfrogsfrogs>
 <5kodxnrvjq5dsjgjfeps6wte774c2sl75bn3fg3hh46q3wkwk5@2tru4htvqmrq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5kodxnrvjq5dsjgjfeps6wte774c2sl75bn3fg3hh46q3wkwk5@2tru4htvqmrq>

On Tue, Feb 13, 2024 at 10:27:32PM +0100, Pankaj Raghav (Samsung) wrote:
> On Tue, Feb 13, 2024 at 08:30:37AM -0800, Darrick J. Wong wrote:
> > On Tue, Feb 13, 2024 at 10:37:09AM +0100, Pankaj Raghav (Samsung) wrote:
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > 
> > > iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> > > < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> > > size < page_size. This is true for most filesystems at the moment.
> > > 
> > > If the block size > page size, this will send the contents of the page
> > > next to zero page(as len > PAGE_SIZE) to the underlying block device,
> > > causing FS corruption.
> > > 
> > > iomap is a generic infrastructure and it should not make any assumptions
> > > about the fs block size and the page size of the system.
> > > 
> > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > > ---
> > >  fs/iomap/direct-io.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index bcd3f8cf5ea4..04f6c5548136 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -239,14 +239,23 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> > >  	struct page *page = ZERO_PAGE(0);
> > >  	struct bio *bio;
> > >  
> > > -	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> > > +	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
> > > +
> > > +	bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> > > +				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> > >  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> > >  				  GFP_KERNEL);
> > > +
> > >  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
> > >  	bio->bi_private = dio;
> > >  	bio->bi_end_io = iomap_dio_bio_end_io;
> > >  
> > > -	__bio_add_page(bio, page, len, 0);
> > > +	while (len) {
> > > +		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> > 
> > What was the result of all that discussion about using the PMD-sized
> > zero-folio the last time this patch was submitted?  Did that prove to be
> > unwieldly, or did it require enough extra surgery to become its own
> > series?
> > 
> 
> It proved a bit unwieldly to me at least as I did not know any straight
> forward way to do it at the time. So I thought I will keep this approach
> as it is, and add support for the PMD-sized zero folio for later
> improvement.
> 
> > (The code here looks good to me.)
> 
> Thanks!

In that case I'll throw it on the testing pile and let's ask brauner to
merge this for 6.9 if nothing blows up.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> > 
> > --D
> > 
> > > +
> > > +		__bio_add_page(bio, page, io_len, 0);
> > > +		len -= io_len;
> > > +	}
> > >  	iomap_dio_submit_bio(iter, dio, bio, pos);
> > >  }
> > >  
> > > -- 
> > > 2.43.0
> > > 
> > > 
> 


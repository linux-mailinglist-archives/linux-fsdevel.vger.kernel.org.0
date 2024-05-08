Return-Path: <linux-fsdevel+bounces-19080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C9F8BFBCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571901C21BE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC081AD7;
	Wed,  8 May 2024 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="kwhWSZcq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE642628B;
	Wed,  8 May 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167218; cv=none; b=dEg3PbAR0Id0V0ZTIQsC7l84fGuVuVSZ2ILgH+pM43ZcfpXGxwPnD1r7Wu/dPKw4qhzSwiED3+h2Xx0YqH/q1+Fb9i343MylgMUUpoVR5d9TqCNJVkZ2gLlKMHiQ9YagP2pIjzbq8t2IS9mCz3PyUARfyBMppw96Q1sQTJy8EBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167218; c=relaxed/simple;
	bh=Nu6O2eMAVkIMziV3ZRSR/eCfiqPiKf6sn09cg0ygOoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+ihHYbo1FvDTuMfW19UajF/5YpasZCNP+0cmdltDCHIHJZ3JPluzM4zWqhvHnVPBMxbFJBDz7ZC58XgGbyl5oyKJS0W9XBQPcPQuE/Xfe/DZjT5GQWDfmWF3IXCJ8icIFC4ncrnZNU/TGs/jFhRoPefiMoOIY5MJOSDodLopsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=kwhWSZcq; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VZCNr6w5lz9sQg;
	Wed,  8 May 2024 13:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715167213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1un4/swOYqLsaMeeUpem8iiB/EUo0Jbdf4dJTwbApE=;
	b=kwhWSZcqfxeUqy4w1ehrBrcL7c7QvNY6vH49D8wxGPTQs4HDilQDAovRKcID5Le1IApaTr
	I1h2y6zMSnT83BwIhGl53JK2STiGOp5vW3tgBVnbl/xxLX3FwAi554PQUW+jvAlVhTJ8s7
	PRRLTseJatMAldsJZbEkba59lcCay+0jzb9uQwi+e/mVEhkcxv14GmiFmrlb/7Y7Yo+Uaq
	sDGXNl9aREvM4AXSmkm5Vv3Mxp/IgBTM/vo9Ly2W0zmwWNxinNQDIepQWvNdf/CIH9f/Rn
	2L6oCVWyobMBGqG24+1bNOaZ9uQftwbST42yyRV3bzFqoFifLmTXnxxyUxk4Hg==
Date: Wed, 8 May 2024 11:20:05 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com
Subject: Re: [PATCH v5 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240508112005.4zhxgcre73omr37s@quentin>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-8-mcgrof@kernel.org>
 <ZjpQHA1zcLhUZa_D@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpQHA1zcLhUZa_D@casper.infradead.org>

On Tue, May 07, 2024 at 05:00:28PM +0100, Matthew Wilcox wrote:
> On Fri, May 03, 2024 at 02:53:49AM -0700, Luis Chamberlain wrote:
> > +	bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> > +				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> >  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> >  				  GFP_KERNEL);
> > +
> >  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
> >  	bio->bi_private = dio;
> >  	bio->bi_end_io = iomap_dio_bio_end_io;
> >  
> > -	__bio_add_page(bio, page, len, 0);
> > +	while (len) {
> > +		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> > +
> > +		__bio_add_page(bio, page, io_len, 0);
> > +		len -= io_len;
> > +	}
> >  	iomap_dio_submit_bio(iter, dio, bio, pos);
> 
> If the len is more than PAGE_SIZE * BIO_MAX_VECS, __bio_add_page()
> will fail silently.  I hate this interface.

I added a WARN_ON_ONCE() at the start of the function so that it does
not silently fail:
	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));

This function is used to do only sub block zeroing, and I don't think we will
cross 1MB block size in the forseeable future, and even if we do, we have
this to warn us about so that it can be changed?

> 
> You should be doing something like ...
> 
> 	while (len) {
> 		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> 
> 		while (!bio || bio_add_page() < io_len) {
> 			if (bio)
> 				iomap_dio_submit_bio(iter, dio, bio, pos);
> 			bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> 					REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> 		 	fscrypt_set_bio_crypt_ctx(bio, inode,
> 					pos >> inode->i_blkbits, GFP_KERNEL);
> 		}
> 	}

-- 
Pankaj Raghav


Return-Path: <linux-fsdevel+bounces-68421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B805C5B6E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 06:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42B924E981F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 05:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA032D8783;
	Fri, 14 Nov 2025 05:56:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B02D8385;
	Fri, 14 Nov 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099783; cv=none; b=HcIytOrJvQo0JXkidq2yt3LQCibbxqPR1oA+/DFyNjOtSuu+/hmAU41EvmuU2XVhY4Zu4nWu1GMkOh1ZM1PLuujn8SNZD6eF25fyFrKHRvvRXnwrDJ6zrKLAEM03jJ09hKpPnu5J/pbPS5RxHEBA7Zp1+ItyxkIIzR77cjc5/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099783; c=relaxed/simple;
	bh=AT6Nan9/IDWwAadRvICdCkRPK6A9bCCG11X4frtXGSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb9HsuKcP77fp512IeE7mPihBuliNedr3wSWJXhQADqXvoXFYAyn3hTjczPReuXVUo7Frh7Tc0Me1pMEVCFjAF43cprvXJQoPlRkZ6IgeN+uPagjNof9w/+Ca4uNvGZom46DQG4KsirLLzDcZFdtGcROWTTkkB8Y1Hu0TP/2oWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D3B9227A88; Fri, 14 Nov 2025 06:56:15 +0100 (CET)
Date: Fri, 14 Nov 2025 06:56:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6/9] blk-crypto: optimize bio splitting in
 blk_crypto_fallback_encrypt_bio
Message-ID: <20251114055615.GA27241@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-7-hch@lst.de> <20251114002210.GA30712@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114002210.GA30712@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 13, 2025 at 04:22:10PM -0800, Eric Biggers wrote:
> > --- a/block/blk-crypto-fallback.c
> > +++ b/block/blk-crypto-fallback.c
> > @@ -152,35 +152,26 @@ static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
> >  
> >  	src_bio->bi_status = enc_bio->bi_status;
> 
> There can now be multiple enc_bios completing for the same src_bio, so
> this needs something like:
> 
> 	if (enc_bio->bi_status)
> 		cmpxchg(&src_bio->bi_status, 0, enc_bio->bi_status);

Yes.

> > -static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
> > +static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
> > +		unsigned int nr_segs)
> >  {
> > -	unsigned int nr_segs = bio_segments(bio_src);
> > -	struct bvec_iter iter;
> > -	struct bio_vec bv;
> >  	struct bio *bio;
> >  
> > -	bio = bio_kmalloc(nr_segs, GFP_NOIO);
> > -	if (!bio)
> > -		return NULL;
> > -	bio_init_inline(bio, bio_src->bi_bdev, nr_segs, bio_src->bi_opf);
> > +	bio = bio_alloc_bioset(bio_src->bi_bdev, nr_segs, bio_src->bi_opf,
> > +			GFP_NOIO, &crypto_bio_split);
> 
> Rename crypto_bio_split => enc_bio_set?

Sure.

> >  static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
> >  {
> 
> I don't think this patch makes sense by itself, since it leaves the
> bio_ptr argument that is used to return a single enc_bio.  It does get
> updated later in the series, but it seems that additional change to how
> this function is called should go earlier in the series.

I'll look into it.

> 
> > +	/* Encrypt each page in the origin bio */
> 
> Maybe origin => source, so that consistent terminology is used.

Ok.

> 
> > +		if (++enc_idx == enc_bio->bi_max_vecs) {
> > +			/*
> > +			 * Each encrypted bio will call bio_endio in the
> > +			 * completion handler, so ensure the remaining count
> > +			 * matches the number of submitted bios.
> > +			 */
> > +			bio_inc_remaining(src_bio);
> > +			submit_bio(enc_bio);
> 
> The above comment is a bit confusing and could be made clearer.  When we
> get here for the first time for example, we increment remaining from 1
> to 2.  It doesn't match the number of bios submitted so far, but rather
> is one more than it.  The extra one pairs with the submit_bio() outside
> the loop.  Maybe consider the following:
> 
> 			/*
> 			 * For each additional encrypted bio submitted,
> 			 * increment the source bio's remaining count.  Each
> 			 * encrypted bio's completion handler calls bio_endio on
> 			 * the source bio, so this keeps the source bio from
> 			 * completing until the last encrypted bio does.
> 			 */

Yeah.  The comment is a leftover from a previous version that worked a
little differently.

> > +out_ioerror:
> > +	while (enc_idx > 0)
> > +		mempool_free(enc_bio->bi_io_vec[enc_idx--].bv_page,
> > +			     blk_crypto_bounce_page_pool);
> > +	bio_put(enc_bio);
> > +	src_bio->bi_status = BLK_STS_IOERR;
> 
> This error path doesn't seem correct at all.  It would need to free the
> full set of pages in enc_bio, not just the ones initialized so far.

As of this patch the pages are allocated as we go, so I think this is
correct.

> It
> would also need to use cmpxchg() to correctly set an error on the
> src_bio considering that blk_crypto_fallback_encrypt_endio() be trying
> to do it concurrently too, and then call bio_endio() on it.

Yeah.

> (It's annoying that encryption errors need to be handled at all.  When I
> eventually convert this to use lib/crypto/, the encryption functions are
> just going to return void.  But for now this is using the traditional
> API, which can fail, so technically errors need to be handled...)

I can't wait for the library conversion to happen :)



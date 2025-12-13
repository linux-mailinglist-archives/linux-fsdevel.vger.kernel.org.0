Return-Path: <linux-fsdevel+bounces-71222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA7CBA1E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 01:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0AFB30B7587
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 00:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AFB21D3CA;
	Sat, 13 Dec 2025 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka8jYNwD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFE1A3166;
	Sat, 13 Dec 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765585870; cv=none; b=mFHHU6m41VQjJytVH718FweSLyW/SM1k3GmwCRE9L3lkzxpdAY9UAuAaZ2zaktahUDMdBgQTMJxu6rLJlhao8hrKP88WkBV/1Z19tJ0Bge/sLQ/05jeqoH7YPTBo0RtdEX75NSjBcoNvK/ziUZxZO8wD4Hovq+YOAa3ahlF6ErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765585870; c=relaxed/simple;
	bh=17ENiVl2xlE53A1TFdyck5BEFA8vxguuF0MPpBPJssM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRiJauSCZvCFbAP1S/FvGGj9RP1HcHEdGkPQuWBuF1m8fV/9sFgoKz7HSELL0+GMN6JaeJ7oH+e9BPayZqS4AjwBkuzUHdbz7QQjTuqyL+J9I0nW8kcmxyX1zQdP72JqyXIOoXbLSu+/KCGxks2Pb/U4uY8St0mFzSIke9S8mgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka8jYNwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C02C4CEF1;
	Sat, 13 Dec 2025 00:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765585870;
	bh=17ENiVl2xlE53A1TFdyck5BEFA8vxguuF0MPpBPJssM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ka8jYNwDDJzWG/LmApz3i6asZgNIjTw275ntgUthJByZ9eYO/iwjZgg4qz+dMkSDW
	 KBkNjkFRXSAc09GqCwzs5OeWSOIaA1qOgSHQjr2EHeQD1wJifNR6tYtAySGUzmGGBe
	 VZu0waIkEgGz/MFAMUfo1+DgNtOa/+Hb7ek7h+CEazKuBEyImXhkBR/1fed6CwLrRm
	 WODueBs9wpMhTGSR+v/dP1XvW18Vnq/NiIL+Fhg83acrNfUujL/cQXekGVzfvW6arc
	 cij8i4Fh6aFzjQSeZy7SNFwZFCU2ad1GWYQwS4D9/TqiEpolssiB19saxtyMySF9V6
	 uQx4K854R08ug==
Date: Fri, 12 Dec 2025 16:31:08 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 3/9] block: merge bio_split_rw_at into bio_split_io_at
Message-ID: <20251213003108.GA2696@quark>
References: <20251210152343.3666103-1-hch@lst.de>
 <20251210152343.3666103-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210152343.3666103-4-hch@lst.de>

On Wed, Dec 10, 2025 at 04:23:32PM +0100, Christoph Hellwig wrote:
> bio_split_rw_at passes the queues dma_alignment into bio_split_io_at,
> which that already checks unconditionally.  Remove the len_align_mask
> argument from bio_split_io_at and switch all users of bio_split_rw_at
> to directly call bio_split_io_at.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]
>  int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
> -		unsigned *segs, unsigned max_bytes, unsigned len_align_mask)
> +		unsigned *segs, unsigned max_bytes)
>  {
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
>  	unsigned nsegs = 0, bytes = 0, gaps = 0;
>  	struct bvec_iter iter;
>  
>  	bio_for_each_bvec(bv, bio, iter) {
> -		if (bv.bv_offset & lim->dma_alignment ||
> -		    bv.bv_len & len_align_mask)
> +		if (bv.bv_offset & lim->dma_alignment)
>  			return -EINVAL;

So this commit actually removes the alignment check for bv_len and
leaves just the one for bv_offset.  Does that make sense?  The commit
message doesn't really explain the actual change.

Also, 'git grep bio_split_rw_at' still finds a result after this commit.

- Eric


Return-Path: <linux-fsdevel+bounces-71844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CAACD7416
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 017CC303295B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098EB32D42A;
	Mon, 22 Dec 2025 22:16:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ED41F91E3;
	Mon, 22 Dec 2025 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441781; cv=none; b=WhPENahdlOAIjBORhBWsotdQbz6HQTq+m/Qh5GiRuG2LtsJ4O/YQvRpv4hM2KHO1xVEkRIyzadqR7+yjrOXSqrSSoN1gHboHvy2U6W4qPPqGgw+UPIGJJ1YfCk/YZy75HKKYzXyed4ejysBwHL2OB+255W8T8nx4mQqTRCLG4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441781; c=relaxed/simple;
	bh=lgWMEwMSMdYvi6EpotEZCJ6tv7AvvJ/E+I3LGWq1PDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOTD0y4mMDCdUWKymuniB5Fhdp/Nir9pP1G6d8tN70K7JO792NBiCSKRWu21t5m7oJnS3ygbcK1lYVROg/Gd4Pzqjye4Ug8X9v2pwO4wed9T5BongdZaQ5fbZrUIqA3W5aiShTByXy/KTMGV8jCl42BVDCNtmd+OmI+l2823yMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8EA2868B05; Mon, 22 Dec 2025 23:16:15 +0100 (CET)
Date: Mon, 22 Dec 2025 23:16:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted
 bio page allocation
Message-ID: <20251222221615.GB17420@lst.de>
References: <20251217060740.923397-1-hch@lst.de> <20251217060740.923397-8-hch@lst.de> <20251219200244.GE1602@sol> <20251219202533.GA397103@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219202533.GA397103@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 19, 2025 at 12:25:33PM -0800, Eric Biggers wrote:
> 
> Also, this shows that the decrement of 'nr_segs' is a bit out-of-place
> (as was 'enc_idx').  nr_segs is used only when allocating a bio, so it
> could be decremented only when starting a new one:
> 
>         submit_bio(enc_bio);
>         nr_segs -= nr_enc_pages;                                 
>         goto new_bio;                                            

I've just killed nr_segs entirely.  While bio_segments() is a bit
expensive, it is totally shadowed by encrypting an entire bio.
This simplifies things quite a bit.


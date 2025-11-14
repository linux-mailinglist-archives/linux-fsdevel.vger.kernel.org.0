Return-Path: <linux-fsdevel+bounces-68422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E8EC5B6F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 06:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9341D34FDE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 05:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1172D8793;
	Fri, 14 Nov 2025 05:56:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B02609CC;
	Fri, 14 Nov 2025 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099809; cv=none; b=Pw7EMXZAMxKUDokYfj2rdPWGq6g5QQP8jKV7c2nyauX3WJyKDRcP1XE7dfTyT52yaISrFvTU5OE58xyj8xL2kDodNgPEMOIrboujvcAgIt0AiRUsUCelvuA0kpp9gN6W07csVFEA6sp6dYyH5ENheT+/PYXO1ak1pWY2MpFH8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099809; c=relaxed/simple;
	bh=w8zi8aWG3u2VUVCLC8UllALoYBTmPnZineayRFAqdZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVHoNjxaqCDBSbO0Tfb7Hh7dZG+LZ93jBS0JSuUWCFOKEwWcm/dFFqOW3AJ6sDgceogQlAO28f003LbucxYbDo6glRHee1wjw8MqxJ0J+byw7kbv+hQPVcMJqYNZqzt8iVWzxt+I80AfCWumszvreouH74SV/IMTpr2HPnJpNSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 00C8D227A88; Fri, 14 Nov 2025 06:56:43 +0100 (CET)
Date: Fri, 14 Nov 2025 06:56:43 +0100
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
Subject: Re: [PATCH 7/9] blk-crypto: handle the fallback above the block
 layer
Message-ID: <20251114055643.GB27241@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-8-hch@lst.de> <20251114003738.GC30712@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114003738.GC30712@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 13, 2025 at 04:37:38PM -0800, Eric Biggers wrote:
> This omits some important details.  Maybe:
> 
> /*
>  * bio READ case: Set up a fallback crypt context in the bio's bi_private, clear
>  * the bio's original crypt context, and set bi_end_io appropriately to trigger
>  * decryption when the bio is ended.  Returns true if bio submission should
>  * continue, or false if aborted with bio_endio already called.
>  */

I'll incorporate it.

> > - */
> > -bool __blk_crypto_bio_prep(struct bio **bio_ptr)
> > +bool __blk_crypto_submit_bio(struct bio *bio)
> 
> Similarly, this could at least use a comment about what the return value
> means.  It's true if the caller should continue with submission, or
> false if blk-crypto took ownership of the bio (either by completing the
> bio right away or by arranging for it to be completed later).

Ok.



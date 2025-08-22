Return-Path: <linux-fsdevel+bounces-58836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6C1B31FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25421D62DA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EADB266EF1;
	Fri, 22 Aug 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OScDwhmY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8D393DDE;
	Fri, 22 Aug 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877372; cv=none; b=JJUnRYtiARPCtNtnDVLnXmBR88XJuuZSJrIGLTC8MoEf+sO1KPrY4JNYjKEMj1ZGW7qwo6hg9ria/GFXewAckg7mDDsV1FcZV5e4ni+qMkqkY23ItvfnQjDx4dDn00xOPqzaeQinxUWgsSSXaY9XWyk5r2UY4hPshSz4FKsFhro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877372; c=relaxed/simple;
	bh=/hzsVQSkfJ6QBVmTl5vUXx/rmY42E1n/mJcPii4C3G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQlbxKvHsqAnMUQrJNpS79g+hjj+OPGSbperOxeBffds+6poq3JpUOApHfRRqdBsd0JjsiMszIVVKdrh50gQ7j6Wh9H3SqZwk3mIttrk5Y3qGiPKl23yj7UkiBtHJaxDHI6MJra0oTrQIrPtZduF4LvFcVDxFuxGyoEUOJIjigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OScDwhmY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=43Mla2218ScZ1MjOpPJJMLZiIlV7AewdRiSitAL+2Sc=; b=OScDwhmYFXtHbYzrpyc7oxKleK
	/SHYuDXoWVWUmChQD3UZgFx3BcZwufKRenvIrrMDmgbeToW2BeEL/syklPDKx+spmwd7ZPlDhrFTI
	NzVkYBKheUB2VOJoS7YxBRLlOY3QZHo9kCm8JwOuTWvzmWfCClX3Qorr7vjFIgBgdxrDqsHBOiaLX
	sv/0grSKYpeghiEjJuhp0OS6VKnB1JV/IHwg5Ns7+amEomBcHIfbUpHU3EE+CgWv2nF7rdceTk3za
	CH7YxPaGfgH0DOLgNNVR1NQwhlqw+VJ+Rp+EVvPCd93y9U8MbxPj+nK0bwmN/C8rz/NPpHLww6i6N
	hZ6kja9w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upTuh-00000009cnq-2DKq;
	Fri, 22 Aug 2025 15:42:47 +0000
Date: Fri, 22 Aug 2025 16:42:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Fengnan Chang <changfengnan@bytedance.com>, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
Message-ID: <aKiP966iRv5gEBwm@casper.infradead.org>
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822150550.GP7942@frogsfrogsfrogs>

On Fri, Aug 22, 2025 at 08:05:50AM -0700, Darrick J. Wong wrote:
> On Fri, Aug 22, 2025 at 04:26:06PM +0800, Fengnan Chang wrote:
> > When use io_uring with direct IO, we could use per-cpu bio cache
> > from bio_alloc_bioset, So pass IOCB_ALLOC_CACHE flag to alloc
> > bio helper.
> >  
> > +	if (iter->flags & IOMAP_ALLOC_CACHE)
> > +		bio_opf |= REQ_ALLOC_CACHE;
> 
> Is there a reason /not/ to use the per-cpu bio cache unconditionally?

AIUI it's not safe because completions might happen on a different CPU
from the submission.  At least, there's nowhere that sets REQ_ALLOC_CACHE
unconditionally.

This could do with some better documentation ..


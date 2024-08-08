Return-Path: <linux-fsdevel+bounces-25447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A1994C462
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 20:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FF1F2564A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9D1474A5;
	Thu,  8 Aug 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CkzykHs6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4135080C13
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142021; cv=none; b=WHLxU2EbsecmlscLXWbsoKk4OSJ+ITR3p1XhNlyAHiVp4rdnx7R4zwuqHch5oN9U12s7E6qVR1l4k3lhDbPA0Dr6usxtNj5LEoWVTXXSVTjghF1mveYYWIf+Vh7Z3CKQfZuA9RrmDLvc0H/kLjc9KpcPsMnYNPI/K6rXXOBvKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142021; c=relaxed/simple;
	bh=Tmi8G0u11GadqqU8x1CDaiIuIelrhpvcEPATZ/jbg9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md4PcseqCHyNH9sUfotGPpbXTCncP2yDKf386K/AV6KeRmflfAGTET/FqLPMHVrw9/Zc4AqevevL2AC3HuVcW1/jSeaKwhmXooI0Ns/AxTKL91SsHj+IVHHhbpygnGIestO2543F7cIek9lwf46rzdSSY/bgKxi6YcWwjToONqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CkzykHs6; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Aug 2024 11:33:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723142017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9gHGOt9FPEl0EXI7QFx2sNXwvm3rxL5jF8Uqu3Gc0K8=;
	b=CkzykHs69r4gMuFTUMVsIjvjHD/xTZKFmY4YYjQuaMvOCCmONbMKp0H/38gSyY1UDEHdAG
	7oPYaN2grWwvOTVjXU0U/7jEqhhrBGHOBqjlAwyS24DPik/2mfS0+ZIEhiazzAETcUH1l3
	fYlvLmt3dgG0TCBVkz/S+f5ZoZmeJE4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, 
	song@kernel.org, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	willy@infradead.org
Subject: Re: [PATCH v4 bpf-next 02/10] lib/buildid: add single folio-based
 file reader abstraction
Message-ID: <csmgbp57f7o2tbuodolhzb5d2fjdu7l5zwmi7gbvq77bx7s72y@i5kalfb4inwy>
References: <20240807234029.456316-1-andrii@kernel.org>
 <20240807234029.456316-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807234029.456316-3-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 07, 2024 at 04:40:21PM GMT, Andrii Nakryiko wrote:
> Add freader abstraction that transparently manages fetching and local
> mapping of the underlying file page(s) and provides a simple direct data
> access interface.
> 
> freader_fetch() is the only and single interface necessary. It accepts
> file offset and desired number of bytes that should be accessed, and
> will return a kernel mapped pointer that caller can use to dereference
> data up to requested size. Requested size can't be bigger than the size
> of the extra buffer provided during initialization (because, worst case,
> all requested data has to be copied into it, so it's better to flag
> wrongly sized buffer unconditionally, regardless if requested data range
> is crossing page boundaries or not).
> 
> If folio is not paged in, or some of the conditions are not satisfied,
> NULL is returned and more detailed error code can be accessed through
> freader->err field. This approach makes the usage of freader_fetch()
> cleaner.
> 
> To accommodate accessing file data that crosses folio boundaries, user
> has to provide an extra buffer that will be used to make a local copy,
> if necessary. This is done to maintain a simple linear pointer data
> access interface.
> 
> We switch existing build ID parsing logic to it, without changing or
> lifting any of the existing constraints, yet. This will be done
> separately.
> 
> Given existing code was written with the assumption that it's always
> working with a single (first) page of the underlying ELF file, logic
> passes direct pointers around, which doesn't really work well with
> freader approach and would be limiting when removing the single page (folio)
> limitation. So we adjust all the logic to work in terms of file offsets.
> 
> There is also a memory buffer-based version (freader_init_from_mem())
> for cases when desired data is already available in kernel memory. This
> is used for parsing vmlinux's own build ID note. In this mode assumption
> is that provided data starts at "file offset" zero, which works great
> when parsing ELF notes sections, as all the parsing logic is relative to
> note section's start.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>


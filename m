Return-Path: <linux-fsdevel+bounces-70022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC16C8E812
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 538DC342E6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175C27B357;
	Thu, 27 Nov 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CYQmgCUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD91F29A1;
	Thu, 27 Nov 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250693; cv=none; b=NBsGO6uyBrQlDPkjnpwWvo2n6bltBXCaJU3duaAPCBEVufz7GNEw0Dk1L9mC8jHojUzUzt1WVvV4mtUhAQUULgR0AJuO/B9jTe1PAIc/CczvM5wGIXFwbmIK/Yi4KwhVCVHJaiL785IZfvY8QTNA+qK7CtzP/njeBO78EgDONW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250693; c=relaxed/simple;
	bh=IrO2NI5LdLw2Mtoz/E/zS7gcWmiLajbS9kpudUE3yog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imha5X9OrVeP63aUYRTxpMYP1Sw3oxCgXZUGGzkKLNiZ0YAWEOpGj/poaAStZTAYGppVqOZDoGZfqc499r2s2b2WS9BXvL7goX0J9ts/YWnquAvWmAts+quRd8GqUVOGe8p2GVbuSKQQgDtkbidB77h6+bKag/g71Us54/UdM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CYQmgCUv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hXTayqT+jWC2OgM/D+gkYwRW+R7pRP8DmuGQlMggZQc=; b=CYQmgCUvV3s7sDVVXn6jnlyHJK
	tp3nf4E0tS2EK9cGXAh4jWdxwhgMyeUAaCERWDTPY80RC4MgmsR6bDEfa41goO1al4Up8kezWmzmR
	jBeoqtJURsmRakBPyRWvGdgAMMpAJhNnkQAGGhZ8rLfW3c4rgKaoFjQh5GknE8Z3gzNCuhfqByMHj
	Mxe5nfXIRW+HuXw5PHKZvfRTJLMaL62mi41dBf1iJj+NmmqmYlXJJJ62IeALQPZLI7V7j7v2cYoFj
	tTQBnqzQxmEPWXhjES5zcZEl/XO5a186Zo4rWekftkgWlhQgBCwSjmW3VNk3vlJi+E/+QJMmjF+Jk
	24QY9O5A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOcCD-0000000Bn0y-3rnR;
	Thu, 27 Nov 2025 13:38:05 +0000
Date: Thu, 27 Nov 2025 13:38:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Sokolowski <jan.sokolowski@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/1] idr: do not create idr if new id would be
 outside given range
Message-ID: <aShUPdV18CIxvV-G@casper.infradead.org>
References: <20251127092732.684959-1-jan.sokolowski@intel.com>
 <20251127092732.684959-2-jan.sokolowski@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127092732.684959-2-jan.sokolowski@intel.com>

On Thu, Nov 27, 2025 at 10:27:32AM +0100, Jan Sokolowski wrote:
> @@ -88,6 +89,11 @@ int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
>  	if (ret)
>  		return ret;
>  
> +	if (WARN_ON_ONCE(id < start || (id >= end && end != 0))) {
> +		idr_remove(idr, id);
> +		return -EINVAL;
> +	}

This is certainly the wrong way to fix any problem that does exist.
And it should return -ENOSPC, not -EINVAL.  -EINVAL is "the arguments
are wrong", not "the data structure is full".

I'll go read the thread now.


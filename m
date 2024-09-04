Return-Path: <linux-fsdevel+bounces-28466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EC996B034
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FDD2830BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 04:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC579823AC;
	Wed,  4 Sep 2024 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBVRJ2hw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19656635
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 04:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425889; cv=none; b=jFPTg6i1Ark99PI78UETqADeTMqkalscMbmyLFlBDu0baNIuDsoLNpRgoY2q0vwWU775XdUDvKx14d0fU8NnlT4b2KvGJ2WjXNA+hp7tQjHgcqag4qVyP4hKzT43r7rrp7DbPX3B2H1MinKxeJyryAWaKLEOiT/ZoR0/+8iCB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425889; c=relaxed/simple;
	bh=H33YrW/3/bNdTRoqJM5b0XGVNgXJhzcB8gderaNSFck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKmlGyVVlGOoYN79j/kTXpFvm5S0Prq/rpO64Grd7ArGo9DlVRzzBZAiWp/T0bLSLKQDmQc2fiUbJ20qBG5xQP2j5E7NZj4gGOTXYvrK/0PVb4zxhGFyrVR4J2ZfYQvchlchBCOoVLy7qXMybreNVubFqe8hzT2LEdzpi+WFiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBVRJ2hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5503C4CEC2;
	Wed,  4 Sep 2024 04:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725425888;
	bh=H33YrW/3/bNdTRoqJM5b0XGVNgXJhzcB8gderaNSFck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBVRJ2hwr0XLnXDFe0cqY9kIuuhpitenSQgacbMySvMlSNk4yOMlwcbFrZIV0UWeP
	 O0CEARxylYUxHwkkAQDVYh8pfIqQ+DOpOLeDLCYHY0Pt6Rkp2TBj3GhLW0zLUi04RX
	 t/YA5iHYZL1WHNgDAC9uWifBL7lYAakTBbS+aMtlfiHGpGbsJV4gwqvzlX/4SSNEHM
	 5qeg2hADXofYqDeBzCPDktcQJ/CtxooIfbEv6qPxzQUnIzYrSD4ekvxaJTNT2b+XWa
	 6Yk4xN4uo9WrOblQJoMTtFGpi6VYdLqACGJUE9SkM/uIXEcdMriG7rWna+TM0BG7th
	 OeRF6Omrssvdw==
Date: Wed, 4 Sep 2024 07:55:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] slab: port kmem_cache_create() to struct
 kmem_cache_args
Message-ID: <ZtfoOG2b1H8ttWRL@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-3-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-3-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:44PM +0200, Christian Brauner wrote:
> Port kmem_cache_create() to struct kmem_cache_args.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/slab_common.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 0f13c045b8d1..ac0832dac01e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -439,8 +439,12 @@ struct kmem_cache *
>  kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  		slab_flags_t flags, void (*ctor)(void *))
>  {
> -	return do_kmem_cache_create_usercopy(name, size, UINT_MAX, align, flags,
> -					     0, 0, ctor);
> +	struct kmem_cache_args kmem_args = {
> +		.align	= align,
> +		.ctor	= ctor,
> +	};
> +
> +	return __kmem_cache_create_args(name, size, &kmem_args, flags);
>  }
>  EXPORT_SYMBOL(kmem_cache_create);
>  
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.


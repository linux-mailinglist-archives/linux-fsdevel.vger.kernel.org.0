Return-Path: <linux-fsdevel+bounces-45695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FEA7AFDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72571188D9C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47EA25A2AC;
	Thu,  3 Apr 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QShP1hdS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B819259CB9
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709911; cv=none; b=Gskz6clI1KgWhSGGU/CqdP7rEvzLOcgSEgqrOT5pQ3pQ+penH1lzQ9O8FHg5VSYFpoG7piDP0IMvNvBc2c10qaz4ekH5/5PaDCbk4+E88aB9ju0IOHZzmPQQAyRnkwZMVIXAT6hib5aLCQDk69oBTYjMgzN6BoAfL58S6ehhkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709911; c=relaxed/simple;
	bh=fxOCdVENU+2Q6zEzQmg1nl9FzugDNN+KR7ZyQSEpjkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLVx1R4lCLqZ7plNHZvLRVlGC07iS5N7WLGUksptQLmzBRyvzK0k8XvUT3v2sOlVcVEy9GFtfjocIMOivZVW8BJkZQFqKj5vaUDMixf2iMF83XGCJPFqzdX7Sk89EqKaloj1KLc5vVdaF8a3XQrKwhINJAg0aMcM6V6aTR5jeIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QShP1hdS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso9134675e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743709906; x=1744314706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvJx/Nf83BWDQrNZJzmSlvuvHulVYJrNODaU2UiR8ZI=;
        b=QShP1hdSD3tQ5TlTQb3ZXkW49frdz2rRkauMuOxzKeC7qo6WLURsNGqPGLR7l8gibx
         02NrNKfuuY84IHby8pO6O/eYKl3mPzzEIH4ZwKZU8gPjlIgdLKYDUqdoz0APS90NIoTs
         ABy2fkCNEn0Ezu6G49nRkxMnT5FG6lzMOf/dMsx3Z+/lC2JQJVrnb621rpjfkHqY7Mzd
         /GllZ/kwkx4RSi2xiZVrQhyoPAb9VK7c+DHFaBTyF3H1eFMMCLnSFFjK/14E7L6xDIM4
         8xB6KtAfdu9dwa3ggCH/nWWQqmwx7Z8ec7zYor+YXWQ3k1PrWdEDPqmotaJy8+FDrkC5
         wwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709906; x=1744314706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvJx/Nf83BWDQrNZJzmSlvuvHulVYJrNODaU2UiR8ZI=;
        b=GsGt5mfMcNVWEznC4V3vJWIEL5rHVDVus+c2vUA5CxXnK3lPIRbeGI8MpTdSW+Lxlb
         yMk/ZmFLLibJEA0P9fQ5WteSZ/ncxlHLr8etgqN1eU/+MW9TbY/LooHR8NtlK73eGm6F
         7ObosZMQFhg8Z9YiH8VacNiyKU6lUUmmd3QxoTxJifsg8s1bj9FMu8R6pN9w2drQJUWT
         OatCi82OacxiBX4nxqBLUnXHgkGgi9M8Ggz47HOvY+icnkywGizQ4P3iwhEPR6kPt1IT
         1YGz/lxrYpGilWPu5s68U8fu2DBRFVqLSoHMgrRCG4Y4/LMDOQJMPu4DqjllqKmEJutv
         Pnsw==
X-Forwarded-Encrypted: i=1; AJvYcCWjuT1IilYMYptKvF4rgi/XuPy0NA7yRajZsDlFhe2/Ayjg+jaFYMh94Hjr0I989drb5sKw6qlr6ky0ZA0X@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6npOqieHEJa3LvWbqBXMEq2Oa/Z7daHg2NCPeaqK2fuqdSzx
	kyGbUDWhAdy2WDZ2seYALecHwtlOhx3ITa8qjT0v5dXpmp6rkMHvu68P39K1xXk=
X-Gm-Gg: ASbGncvEc9drMPatE2MODrm0SeqF1ADMvstgxnTSpDJiJqykXspmWOJpZBnc2MQPHzB
	wRg7335JzSWgEUb/e4lfhNT5MhwmFvX4acp5cGimFGDh+dJaq1KMKOaHapu16eeCcYAXeIHi3bm
	Nz91KBi7yrvg2As4G82AIJHq9KaVEb9HP93OfLVuY3V+2FYarIP395DuP4TS71s9OQYDy/ca2vb
	LebAElAfp48NjxejHnEyPRNkutVVcn8C3huvdsdQSf5UKgPH4uW26XBwhFjB9yzxpdhd/QkL5JB
	g0G2mz5T9ggRWQbuI42gJ26c5vcg53VGdm4XNNELCiUraP58BPVY9TU=
X-Google-Smtp-Source: AGHT+IGh2WWnx/ttbx6Lz7h8enrheV1fo3XO0n5YEs4nTyeGyFq/Ko8pVniqm/t/CvcNY5sKH0IMXA==
X-Received: by 2002:a05:6000:2405:b0:391:4999:776c with SMTP id ffacd0b85a97d-39cba975d5dmr455082f8f.40.1743709906313;
        Thu, 03 Apr 2025 12:51:46 -0700 (PDT)
Received: from localhost (109-81-82-69.rct.o2.cz. [109.81.82.69])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c30096b9csm2610336f8f.13.2025.04.03.12.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:51:46 -0700 (PDT)
Date: Thu, 3 Apr 2025 21:51:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
Message-ID: <Z-7m0CjNWecCLDSq@tiehlicka>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka>
 <Z-48K0OdNxZXcnkB@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-48K0OdNxZXcnkB@tiehlicka>

Add Andrew

Also, Dave do you want me to redirect xlog_cil_kvmalloc to kvmalloc or
do you preffer to do that yourself?

On Thu 03-04-25 09:43:41, Michal Hocko wrote:
> There are users like xfs which need larger allocations with NOFAIL
> sementic. They are not using kvmalloc currently because the current
> implementation tries too hard to allocate through the kmalloc path
> which causes a lot of direct reclaim and compaction and that hurts
> performance a lot (see 8dc9384b7d75 ("xfs: reduce kvmalloc overhead for
> CIL shadow buffers") for more details).
> 
> kvmalloc does support __GFP_RETRY_MAYFAIL semantic to express that
> kmalloc (physically contiguous) allocation is preferred and we should go
> more aggressive to make it happen. There is currently no way to express
> that kmalloc should be very lightweight and as it has been argued [1]
> this mode should be default to support kvmalloc(NOFAIL) with a
> lightweight kmalloc path which is currently impossible to express as
> __GFP_NOFAIL cannot be combined by any other reclaim modifiers.
> 
> This patch makes all kmalloc allocations GFP_NOWAIT unless
> __GFP_RETRY_MAYFAIL is provided to kvmalloc. This allows to support both
> fail fast and retry hard on physically contiguous memory with vmalloc
> fallback.
> 
> There is a potential downside that relatively small allocations (smaller
> than PAGE_ALLOC_COSTLY_ORDER) could fallback to vmalloc too easily and
> cause page block fragmentation. We cannot really rule that out but it
> seems that xlog_cil_kvmalloc use doesn't indicate this to be happening.
> 
> [1] https://lore.kernel.org/all/Z-3i1wATGh6vI8x8@dread.disaster.area/T/#u
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/slub.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b46f87662e71..2da40c2f6478 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4972,14 +4972,16 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
>  	 * We want to attempt a large physically contiguous block first because
>  	 * it is less likely to fragment multiple larger blocks and therefore
>  	 * contribute to a long term fragmentation less than vmalloc fallback.
> -	 * However make sure that larger requests are not too disruptive - no
> -	 * OOM killer and no allocation failure warnings as we have a fallback.
> +	 * However make sure that larger requests are not too disruptive - i.e.
> +	 * do not direct reclaim unless physically continuous memory is preferred
> +	 * (__GFP_RETRY_MAYFAIL mode). We still kick in kswapd/kcompactd to start
> +	 * working in the background but the allocation itself.
>  	 */
>  	if (size > PAGE_SIZE) {
>  		flags |= __GFP_NOWARN;
>  
>  		if (!(flags & __GFP_RETRY_MAYFAIL))
> -			flags |= __GFP_NORETRY;
> +			flags &= ~__GFP_DIRECT_RECLAIM;
>  
>  		/* nofail semantic is implemented by the vmalloc fallback */
>  		flags &= ~__GFP_NOFAIL;
> -- 
> 2.49.0
> 

-- 
Michal Hocko
SUSE Labs


Return-Path: <linux-fsdevel+bounces-46047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB3CA81E5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 09:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0EE4206D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211325A2D4;
	Wed,  9 Apr 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WXI/Fx7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472851A76D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184111; cv=none; b=sUTWCNhSIyoyEDn0R2ujpqukoBdrGjEu1dLyTMohGD7SZvlKPjurXRBsPVi2SRwhiiKfBYyH8iALCagGUwqayZNdjk++JXw7HVuXsdK6jxROEbVLjCPknWpwe9ZG+f2HfooHo6QOkO+Y9mumJa52Pk6JI8UeOzpRzhFdjE377hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184111; c=relaxed/simple;
	bh=MdqzTPnWdzsRYU4e8cvFsST9bM2ogwsNmXCLs5QTXio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO88AIrTU8Nzj1UyJPoR8bvL1slos31pJed2Lprw8kmdxST0CBZqFBowyJfnX18QTcy5tapbm1KBaeezLrLq2YYP8OhXr43jP12EnQRZXKC+C4aYWfby/3MlEp54Ycj9gnkvRosn/HgNByRKrq/5lvX1ZA6KrmgmM7oCv5tFf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WXI/Fx7S; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso1106660366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744184107; x=1744788907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFNv7QLtmE5OhC4XcLYqWap2xLAwyvJzlbgmFqui90g=;
        b=WXI/Fx7SNAwOEU/Dxt6P0BMKZBqwUdBPsBQSnqrm66cHy2IS59dQ582UkUb8Lt4hX9
         wjRoQp9T6UjeOXrDXXQuagv4i6VJ3LgE7mDeGrpIR6ualxz5pn4PHFlk5Oe2gvmqcYQW
         5h3H5rFHmeKnvaaFcFDEYGLLP/d+jRWf6B+rZ8kM6IHoZxugv8Z10oAeYCA7Uvxdom5/
         ZjzpkpgJ/5+8RHckVlOnwyLmm4ioREMMtdNZ8le+j4r+i08xQONj5OPxaTlSkYfeFWCe
         2tvyVXUBorZ9HbEjNDwmmJ2kO+ZCOkR8BYJDfgho6fnbARB13NoMBZzB8eo3d87YVoLw
         aZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744184107; x=1744788907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFNv7QLtmE5OhC4XcLYqWap2xLAwyvJzlbgmFqui90g=;
        b=CAAChXhIq7+U5anrp5xozhJRo2fo87bvtgXVM6zrCgOmgfTnw4XoPESHW9qcpSG/OA
         lsufiDLs4AKUuujy/Qr/H5kxRf5OOzB1WFHikXdaaGJG7Oa9EDVFgPAXYCjco5jWLPIE
         R/EUgiSNGJQsh7q3DQ4O014BFXYFzBDw0JlwyO184/kScjR+pspLZY0UPjyYcfYqF4aD
         6sh31QVSmihXHc2V2tCxhluA++SHqkQhINrMs2HJZ7idKXd0+JbNJqLfUI3HDxgaSPIJ
         FSi0XkFjXftS83smNyPRZSzrPexEOcyTPgz6XQAtKiiOjScsvA60t24Qn8BQPanb3J6Y
         eVEw==
X-Forwarded-Encrypted: i=1; AJvYcCXBM93zOdvY503hMy8gSBgdMDg6uChoW54NDCRwW1WrhnsoF3ihU/9+WUH07H4G+YhnmFTn3AWuAJZguG2l@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgefYcOSJ2uJTEiOnpPp+594zXIBoYkd5EWzsNFmnuqw8h1we
	yMflVSWCGRuZ01LbdgbNkVaGZuC8NUcPVVXADwJwuhSOjjYtXSijBIZr5fmPwcwsUvwVrfFupdp
	r2rs=
X-Gm-Gg: ASbGncsIuqn19lXumr6jAy2MqUtp+uCP5F4UWWSX5Szt12Eq232A9RMXpeGusQ/tLhC
	RC16rldHC072Ncsnv270QBRClRV1e9aDslfLSNKIcNKN8DfD/L2j8pooTFhvs/ruA+AlmHlHAfZ
	6r2wOQDBN6fg7cAB4DVTyZc4MeuQh+0dB5M0jOrkIk2w4bbcqVtK/CjeRyjQC4J3VPpdLsg4sCG
	DD61mNWx03aJ7y4iagC148soZF2IwQFLSAg/Q+mXjm5nYA8e5+8yXJZ5YfK+YpX/caJA1oFCNbZ
	v9ZQSZUaNbGCX6whwS1y+k+Rrnoy/wk=
X-Google-Smtp-Source: AGHT+IEaPbCdxlIk8b/nB0E1ieda3Y+YGsWC6h68PydAy/rXVgPqPM2Zl70/wdKTDZf8mWjEePFT9A==
X-Received: by 2002:a17:907:3f16:b0:ac4:751:5f16 with SMTP id a640c23a62f3a-aca9b68a90dmr191381866b.30.1744184107551;
        Wed, 09 Apr 2025 00:35:07 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-acaa1ccc157sm48729066b.142.2025.04.09.00.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:35:07 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:35:06 +0200
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
Message-ID: <Z_YjKs5YPk66vmy8@tiehlicka>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka>
 <Z-48K0OdNxZXcnkB@tiehlicka>
 <Z-7m0CjNWecCLDSq@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-7m0CjNWecCLDSq@tiehlicka>

On Thu 03-04-25 21:51:46, Michal Hocko wrote:
> Add Andrew

Andrew, do you want me to repost the patch or can you take it from this
email thread?
 
> Also, Dave do you want me to redirect xlog_cil_kvmalloc to kvmalloc or
> do you preffer to do that yourself?
> 
> On Thu 03-04-25 09:43:41, Michal Hocko wrote:
> > There are users like xfs which need larger allocations with NOFAIL
> > sementic. They are not using kvmalloc currently because the current
> > implementation tries too hard to allocate through the kmalloc path
> > which causes a lot of direct reclaim and compaction and that hurts
> > performance a lot (see 8dc9384b7d75 ("xfs: reduce kvmalloc overhead for
> > CIL shadow buffers") for more details).
> > 
> > kvmalloc does support __GFP_RETRY_MAYFAIL semantic to express that
> > kmalloc (physically contiguous) allocation is preferred and we should go
> > more aggressive to make it happen. There is currently no way to express
> > that kmalloc should be very lightweight and as it has been argued [1]
> > this mode should be default to support kvmalloc(NOFAIL) with a
> > lightweight kmalloc path which is currently impossible to express as
> > __GFP_NOFAIL cannot be combined by any other reclaim modifiers.
> > 
> > This patch makes all kmalloc allocations GFP_NOWAIT unless
> > __GFP_RETRY_MAYFAIL is provided to kvmalloc. This allows to support both
> > fail fast and retry hard on physically contiguous memory with vmalloc
> > fallback.
> > 
> > There is a potential downside that relatively small allocations (smaller
> > than PAGE_ALLOC_COSTLY_ORDER) could fallback to vmalloc too easily and
> > cause page block fragmentation. We cannot really rule that out but it
> > seems that xlog_cil_kvmalloc use doesn't indicate this to be happening.
> > 
> > [1] https://lore.kernel.org/all/Z-3i1wATGh6vI8x8@dread.disaster.area/T/#u
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/slub.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index b46f87662e71..2da40c2f6478 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4972,14 +4972,16 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
> >  	 * We want to attempt a large physically contiguous block first because
> >  	 * it is less likely to fragment multiple larger blocks and therefore
> >  	 * contribute to a long term fragmentation less than vmalloc fallback.
> > -	 * However make sure that larger requests are not too disruptive - no
> > -	 * OOM killer and no allocation failure warnings as we have a fallback.
> > +	 * However make sure that larger requests are not too disruptive - i.e.
> > +	 * do not direct reclaim unless physically continuous memory is preferred
> > +	 * (__GFP_RETRY_MAYFAIL mode). We still kick in kswapd/kcompactd to start
> > +	 * working in the background but the allocation itself.
> >  	 */
> >  	if (size > PAGE_SIZE) {
> >  		flags |= __GFP_NOWARN;
> >  
> >  		if (!(flags & __GFP_RETRY_MAYFAIL))
> > -			flags |= __GFP_NORETRY;
> > +			flags &= ~__GFP_DIRECT_RECLAIM;
> >  
> >  		/* nofail semantic is implemented by the vmalloc fallback */
> >  		flags &= ~__GFP_NOFAIL;
> > -- 
> > 2.49.0
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs


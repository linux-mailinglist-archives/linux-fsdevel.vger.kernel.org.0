Return-Path: <linux-fsdevel+bounces-45600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB5BA79CD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2405D1733BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478824113A;
	Thu,  3 Apr 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TSWHoy7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C123F422
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743664969; cv=none; b=XiRW2Nxl8S90m3IsrtoSWw6XF2is7v/G503wLJChcUbmrDXRB1IKQR6nsceQj1w2z0rDdrSZDfzg+87KYnAa8tf6Hsls20isDWbr+8hDMsrDrNVArv2wQnzuNTceBg+DBMQNnX6JX+yG5TxHcl/udtTLmlC1WSHB1Yo2LuhkbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743664969; c=relaxed/simple;
	bh=FO410BSFVlQOV0QN78f0n3VXDiOcSF0PfN3Jjykz7Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcFiCif0vgEYAqSbjY4apZJOagefwItjMaTMXsybz0SLVxK9MbAkq+xEKqmBgqJoAoFmmSLVXHSyl9r+8nW/EtGnZOih6AIwm9yLJmF+zR/Pswl8sjVD8NrloSM9f1o7S6z16dhah/MTm3+HECBgOK+uGcA1vS0/jHWBnHMdf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TSWHoy7q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso2603645e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 00:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743664965; x=1744269765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qsvZgx94LpNiH7bsvaOm+wd6d767CLq7Qj7GevcR80=;
        b=TSWHoy7qKAJt/HvzZu7+aNWc/lf76c6P3FMLZGecoEHISZbHjLkJwTwBJvRkkFlCuB
         je5/E8o8OgYzmmbxI09Q82omAvb9Y7SwN9nWypinosLK+y1EpsAxtd4vtsXaMjPYWrsw
         qwDS1eirPVc4q8l5a+QoLW2FdqSSCV82qKQULOo0896D9VECI8y9j7CeOqWxmhEaSjon
         gdmzAVaNh/nitcYkihhTK4E6CMQRaHYoz0upf6e1uhxOjBsBYNEZO3PZdyTzJ3i9Uhku
         bDCnBNuZmpelIhc+s6hnzi9nz663hdruU8L7Sit1zVX066zjA/m0jpINDwgoSdRQvVJd
         B5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743664965; x=1744269765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qsvZgx94LpNiH7bsvaOm+wd6d767CLq7Qj7GevcR80=;
        b=NWqckz+/ehYP53LnWJ0M2e4pKCqY86mbfXLwDgLFN2g8nilorOYUaMil5QoBhEFfQL
         t2HicmSXyu+1+MaAlLMl2W4R07RcdO5QjoqkAAMINLoZ0YSfnyn8EuHNb13cdRd3Rcj6
         pchlwa9TRORJf3UZrndcAehCmjprpHcu1+rPA9FO205PuQWDMy0mqGXdCykunNtmgfRg
         LX6NTHzaaudmcvwQ2+5VvVCT9YIcBC5iYUmPl0U8tq4daMD/7bE+5t0J+TJZ2x7iF8x4
         z0LYUUWXxhV2UJmyYMrjK6FfC6hBOFaXETC+PDSqyOrnjlUte6eTt/2cNh14udqjszoa
         xmYw==
X-Forwarded-Encrypted: i=1; AJvYcCUfvr2lwaPktllrHfwjOx+aYMbmLD4onxvKkMmwn3caxDlXq/wcho9ZyqCtgjlNk+BfdF9W+hZ9sYN3aYHz@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQ6iJELOTp1wZJB0Inkid5qpcExNxdZS362P7dxl9q5il4Vk5
	5au+yiRZYQ6bWYF80kLSUGAgLlkNx0Ulx2o24ZbK7vd64s0KTyAiuNpK6yy+plk=
X-Gm-Gg: ASbGncsx6uVb9tq04K5z5acw7wjW28wTDz9kWZahuUtARCVTlbVUpSvbuNsqL9IdEoQ
	uKCaPWAVvk8RZjKaD2Hu9fDwWyHaoYUyYwPcsc3Ew864WX0DOrkllGS4IDiLrvTufamdTMXC8Pp
	ZTamkWTlvD0t45G4ciQlTgn8VKMjyR6tscMqCQEBfnHh2CYlOMOcj/s5/xNJlP5iOoi1ztJksuL
	kGhO2KczFYjC7yPqX/vYmsOdemZXecn3sLj/t5ilPa3JQ3n18sQEAt9aF3l10ziWyDvcX4IuQ5q
	MuH2iz/6h6ah0imZ9WXVUr3CwgMkINhXc25iq4jOUA+MP0AZiR902w0=
X-Google-Smtp-Source: AGHT+IFghQQVMJEwJv3TH5fwoOtmpQiB/vJEk3mApbx86ikuS8MDaGrsUMgmPS2nUiK//ZwBDckelQ==
X-Received: by 2002:a05:600c:1e21:b0:43c:ec28:d301 with SMTP id 5b1f17b1804b1-43eb5c70cc3mr52822185e9.26.1743664965426;
        Thu, 03 Apr 2025 00:22:45 -0700 (PDT)
Received: from localhost (109-81-82-69.rct.o2.cz. [109.81.82.69])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ec342babfsm9992235e9.1.2025.04.03.00.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 00:22:45 -0700 (PDT)
Date: Thu, 3 Apr 2025 09:22:43 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <Z-43Q__lSUta2IrM@tiehlicka>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>

On Wed 02-04-25 21:37:40, Shakeel Butt wrote:
> On Wed, Apr 02, 2025 at 02:24:45PM +0200, Michal Hocko wrote:
> > diff --git a/mm/util.c b/mm/util.c
> > index 60aa40f612b8..8386f6976d7d 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -601,14 +601,18 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
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
> >  			flags |= __GFP_NORETRY;
> > +		else
> > +			flags &= ~__GFP_DIRECT_RECLAIM;
> 
> I think you wanted the following instead:
> 
> 		if (!(flags & __GFP_RETRY_MAYFAIL))
> 			flags &= ~__GFP_DIRECT_RECLAIM;

You are absolutely right. Not sure what I was thinking... I will send a
full patch with a changelog to wrap the situation up.

-- 
Michal Hocko
SUSE Labs


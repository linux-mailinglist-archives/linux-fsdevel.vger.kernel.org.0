Return-Path: <linux-fsdevel+bounces-45694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C63A7AFD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CC8189007B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62414254856;
	Thu,  3 Apr 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OIBVjPGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF81E633C
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709795; cv=none; b=RmZEOWE7+CeStTzDFdI/qr5eoT7n8jOJ/izkTplp6P1W8IV/RsoVXtDiRQ6w93fffOcxSAuE+Be11+exfprt3Z5uPIQ+j4NthEJT9BfCPaTR1CaE657fUtlFT09XzkU2NtXzEx/oZcgYa10DJ4f5G6bTNsSaKjVS7ieQQDwuihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709795; c=relaxed/simple;
	bh=4k6PPlSzsnZZRkjeVGzLo0bJFjFgyMpZrMA0V0qavtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a74cvLYIFZQUUX4LWe/SxPd5pcO5TWKNDwvoIIjt2DbRmIyj+FsgMPG8ZwmUZNkJj0RuSwYWgb7pM6vMqmxvJHiPgnADyTPz/U/8F8ZK4uy2I0iKDA9lJSDPWni6U6VZ0bL0YUcIYRnSO65OULKTEfFxbcHpsNOKrF7cyX53+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OIBVjPGj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso8432315e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743709792; x=1744314592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMantzy2s72seOmCcl9SpDsFXi5byVpuIAT7u7eYgNU=;
        b=OIBVjPGjNmZoBFuQF2qbHJxU/pGw9YCTQjq40iCAcw6CnOdqqMx1S8oUUGTERS2j1H
         +1vpBdS1Ngk9ci486Nk4Jbr3lbKCzUi5PBWSUjG24QwCHLyVqIReiUKXRyvx+aj2YTqD
         NnU5W2GcxUqzTcMW1J9TB8SMhv2hWs2t3UYYY4dK7QNCT4By/E3vx73BZkRu0fxGh8Gj
         gBLBMaqVapK5t/tlcxPWRMg+ozny99F+J/K0uxz/kZtf4PjQNiFv1BWItAsFtXJ73Uva
         YGZ0aibvyMhd2ZOnUGPkajSYUr0q/cQjG9Fp8o+iGoxQwDk31Xk4zyQHwSDNMkSQ6k6e
         vFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709792; x=1744314592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMantzy2s72seOmCcl9SpDsFXi5byVpuIAT7u7eYgNU=;
        b=k41jQjVYQGGrkaWseXIby00Y3489J5hL33pWgn+arL1t9iHNdtCs2RlzXsBNiK6RX7
         rnBvABPw5dqLrQDi1H2IyiYmNRuXoZsHbcWf3XLTKBwKy63k8cVHeLEE03GJ/BF4BlYa
         zRsA6yigo+CNiyQkzyuSWqSvCh3QjYQOmFft3BgnWcy+vQkADsPylE+rtzn8yYlN9ZMJ
         nLJHrsMPiAWBf1V/6N7e0gEcXjboTf3ngq9r4xwYgWjDOjQmmdjMPkkh08w30PWthPvB
         YKgWE/GnczlxTA8y1N4tT2J9REEoQiB5+Nf7Cck/ytv0JbuXfKuGCqXDF+xag+nTpIh8
         AZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYCmC0YQ7B/B5T+82qhc85fc56F8AyvnfvCGG28EDC48v1s1dqQt9xfYM9+VPp6pXe8ZtAD8gYRm6com4T@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWcTd1kEvPuQisdF6nTkjiUsPvYg8RvpDdY0rgNtsoVzkm9rX
	YWZs4WaD/jCJCaCjE/IB7vwL7sbIq4dnQjnj3EtVHMsYzEIMNk8RAAwiNIUzUns=
X-Gm-Gg: ASbGncvbmuFXQeM7wCh6ArcnhRUEvZSO2ZGbEAt79Wt/R7HjBDZ7TRZnsJb7nNJznpR
	flcQR04PmYqnb4SgdpFqRZCf4zsOmk8TG7ZxAp1GyjxtuAVhh3BypaNtFufNj3f0f+EiFyLhwER
	VVQ66e8Zba3pcWhwWmg91f6Y8+9JIMIDBydrWLlRxL+Tphv0vXeymk95n+Er8NHwJW6L2zqgyVA
	/uNMZATE0RYDlGnYwB1rlYV7Io0gG4GH/akO4QGD90mtLbASkmGkBo9kg6YeZmb2nIsDk0kKK3M
	kiyx9moGeMW9mFngS+CfrzIAI3Y1SWUO7EpTHa10U5Pa0eHUp4fn/W0RO8dwlb3FBg==
X-Google-Smtp-Source: AGHT+IHz8+YVKnZDHNWuHQTnMwBCAJXrGqeDjBuxgEkh1ulItLUELMCnkYHOcOkcHzzQy7hOZoXLkA==
X-Received: by 2002:a05:6000:2512:b0:391:253b:405d with SMTP id ffacd0b85a97d-39d0de62927mr66671f8f.41.1743709791855;
        Thu, 03 Apr 2025 12:49:51 -0700 (PDT)
Received: from localhost (109-81-82-69.rct.o2.cz. [109.81.82.69])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c3020da49sm2517510f8f.80.2025.04.03.12.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:49:51 -0700 (PDT)
Date: Thu, 3 Apr 2025 21:49:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kees Cook <kees@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, joel.granados@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
Message-ID: <Z-7mXukKN1eB_AQx@tiehlicka>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka>
 <Z-48K0OdNxZXcnkB@tiehlicka>
 <202504030920.EB65CCA2@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504030920.EB65CCA2@keescook>

On Thu 03-04-25 09:21:50, Kees Cook wrote:
> On Thu, Apr 03, 2025 at 09:43:39AM +0200, Michal Hocko wrote:
[...]
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
> 
> I think a word is missing here? "...but do the allocation..." or
> "...allocation itself happens" ?

Thinking about this some more I would just cut this short and go with
"We still kick in kswapd/kcompactd to start working in the background"

Does that sound better?
-- 
Michal Hocko
SUSE Labs


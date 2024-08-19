Return-Path: <linux-fsdevel+bounces-26234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA71E956517
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F0CB20FC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23B15AD95;
	Mon, 19 Aug 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QZIo3YC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D53156CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054278; cv=none; b=N5+E/8wzhDnVazxsRIh88Ni7UhOhuPC1dExhl6NcaUNvr+qQjCglPgcMHmm04YZLm4byRoobGsqV5F/DEPIc8HYco/CCFDZpLzm2uNcfz/oy6EAs6TxoUGfI0k2kXf20O5Pb+QQnZSf1wHHY4+usfSYnmMt1voKs4MdTCrmt53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054278; c=relaxed/simple;
	bh=U1cBYUo1/m0S7vFwT4ORl8nBgVYXQf12N28xq0lHaMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP8dKwPjNnW7c6K6tfyT/BNA17unL3m8IC46Y53D3xCiAIazK5vd4z9IqbFz9B9ClXB+HfbVp8z2ezPpTBXnlAwCRp//c/wubEY0fu/7jEjdQB3OdQoa+SgbGYBgmnTaPb/RhevUyAf88NTFtyC7Q1Dmz80PTh/UBhpOZ2oOYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QZIo3YC0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so145630a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724054274; x=1724659074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=arnGtTyoS5RDdw2W3dSzbJ5CUs+i0D7zxAci5MUC2T8=;
        b=QZIo3YC0IKrDazUJ6iLK4jgMgTlerin1NRYLQzqYviIYJVGVmR+3l8WdjJVljlUFjv
         khYwN3QofxtwmXxxHX0gM593D6VoBoMeHQ9HmAB37OexdzY6kbmLiuMbiXAFLTFfOc7g
         1KcvQpy/E/W6kPf9MUrmAe2fQxYaz0wPTjvKMt3+eyVeO8JjNanc9U7PsabUvsXYIRvW
         yyyqICdqTJXYLDAW9jgfLtIMCTgU8RuDkU8ORA+YCfLrYIeIql+513eRU+CvGMBkV1Oq
         OZBzkpjL27FZbU9ebpPzYiUkM3TTZxjMlC2EvX7maCEhMgWhSfI6x//kBVmzfqtXn2N/
         NBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054274; x=1724659074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arnGtTyoS5RDdw2W3dSzbJ5CUs+i0D7zxAci5MUC2T8=;
        b=bwuWxXLFFw0IiCIHSugs7KagD5DBDk+jqgPjdLCa4coPLJQ0d7KT+Q/MBglttXa+9S
         NqbZS1PuMe987QPICz+829yBRZwcy1FeWTGTwS1StY1m8hybMTh3C41E/ZSmtfF9lPsz
         Nporlj5hQ8X1nJmTfmmVPUK0ejI445O+68fg3so7uszm5lhTRO73nkyHb1IWcN+kzQEi
         r/Id+5yUjFqXO32XPKHsRF/bAiiCNIfbB4H2Qj+AtAGU4G61uhS3LDqpeY5IvRnhIfvI
         qlpyg9izUvxhGAYGBb25QEfLePXF/NKXUop6Z6IxkwZfmh4PHwmbbxjz4csy6S0AF7NQ
         UGcA==
X-Forwarded-Encrypted: i=1; AJvYcCVGZUkeFYOXlzy2EH3PS1qcl1MasOmx5lbq8Hzf9OW+dpfzFVQQvFpQuh/lB8Y6OkNW/35WuPiydSqE0uYY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx070I8hYJxUc+8ODtNnerdyFaAMFFaVeV0D1qVOYSlLzeuYPkz
	H2rd0QYhWaKxb+WSXiJeEAYfxWXtQUtdtK5boeFeb3xyBDYhauAZsnNF1bxx7NQ=
X-Google-Smtp-Source: AGHT+IEQgoJGknYLZ16yIzD+XS2lqDcmI5iK2qcYT0XI1UhOu4JBsyHp+IcQGr4Y23idFaQQJh18vw==
X-Received: by 2002:a05:6402:84b:b0:5be:bcdf:4110 with SMTP id 4fb4d7f45d1cf-5beca263a7cmr7293268a12.0.1724054274369;
        Mon, 19 Aug 2024 00:57:54 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bedf8a0628sm2514761a12.34.2024.08.19.00.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:57:54 -0700 (PDT)
Date: Mon, 19 Aug 2024 09:57:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <ZsL7AUhrYda5r6Iy@tiehlicka>
References: <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
 <Zr8LMv89fkfpmBlO@tiehlicka>
 <CALOAHbDRA1zZ3SgZU=OUH=3YXH71U-ZHhuBk4sBOWyF6c4yaSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDRA1zZ3SgZU=OUH=3YXH71U-ZHhuBk4sBOWyF6c4yaSA@mail.gmail.com>

On Sat 17-08-24 10:29:31, Yafang Shao wrote:
> On Fri, Aug 16, 2024 at 4:17 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > Andrew, could you merge the following before PF_MEMALLOC_NORECLAIM can
> > be removed from the tree altogether please? For the full context the
> > email thread starts here: https://lore.kernel.org/all/20240812090525.80299-1-laoar.shao@gmail.com/T/#u
> > ---
> > From f17d36975ec343d9388aa6dbf9ca8d1b58ed09ce Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Fri, 16 Aug 2024 10:10:00 +0200
> > Subject: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
> >
> > PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> > that such a allocation contex is inherently unsafe if the context
> > doesn't fully control all allocations called from this context. Any
> > potential __GFP_NOFAIL request from withing PF_MEMALLOC_NORECLAIM
> > context would BUG_ON if the allocation would fail.
> >
> > [1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/
> >
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Documenting the risk is a good first step. For this change:
> 
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> 
> Even without the PF_MEMALLOC_NORECLAIM flag, the underlying risk
> remains, as users can still potentially set both ~__GPF_DIRECT_RECLAIM
> and __GFP_NOFAIL.

Users can configure all sorts of nonsensical gfp flags combination. That
is a sad reality of the interface. But we do assume that kernel code is
somehow sane.

Besides that Barry is working on making this less likely by droppong
__GFP_NOFAIL and replace it by GFP_NOFAIL which always includes
__GFP_DIRECT_RECLAIM. Sure nothing will prevent callers from clearing
that flag explicitly but we have no real defense afains broken code.

> PF_MEMALLOC_NORECLAIM does not create this risk; it
> only exacerbates it. The core problem lies in the complexity of the
> various GFP flags and the lack of robust management for them. While we
> have extensive documentation on these flags, it can still be
> confusing, particularly for new developers who haven't yet encountered
> real-world issues.
> 
> For instance:
> 
>   * %GFP_NOWAIT is for kernel allocations that should not stall for direct
>   * reclaim,
>   #define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
> 
> Initially, it wasn't clear to me why setting __GFP_KSWAPD_RECLAIM and
> __GFP_NOWARN would prevent direct reclaim. It only became apparent
> after I studied the entire code path of page allocation. I believe
> other newcomers to kernel development may face similar confusion as I
> did early in my experience.
> 
> The real issue we need to address is improving the management of these
> GFP flags, though I don't have a concrete solution at this time.

Welcome to the club. Changing this interface is a _huge_ undertaking.
Just have a look how many users of the gfp flags we have in the kernel.
I can tell you from a first hand experience that even minor tweaks are
really hard to make.
-- 
Michal Hocko
SUSE Labs


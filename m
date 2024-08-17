Return-Path: <linux-fsdevel+bounces-26159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1989554E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EA1B22488
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E26011713;
	Sat, 17 Aug 2024 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4IXN3Ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA89CA6F
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861813; cv=none; b=pApAIlzteJNmTUuZz7zAsplnqf2TYOYvzhDNybNzua6Oj/SVXinD9CDDJBZsfv4GJ9qXJo2GXB2uiF18XGEP84S+vXG/dyTY6wlzvg0BD7sSU/4JzfCu3IiD3vDhwkiArawmSdE6/U1iUDI3krUYi6em8QyeNTOzN+FNR7PeVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861813; c=relaxed/simple;
	bh=DBeM50R2TnxapFKHUPymHn8nk6fiMezCFuy35Yyb4YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B63aNO3Q6oexnDdf3CCxbMNrZgEFbUbFSHZScCmY6KGPJYlwkdKpxGSls4KqaDoibZubAfERqEKATHUaWYHBWdppIVb6V+GHdPayBU64xGn/KEe/3Fl6sQzaoLuAHZZGZquuxa1JwvO9K9VI4oV19pLPeSGuCVPMTO+8P6H9M2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4IXN3Ko; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45007373217so32214601cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 19:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723861810; x=1724466610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwAZjQgeVGZrYr9IuVBFyd4iX8rZTH/EnHUupg2Amrw=;
        b=G4IXN3KoGaN0/K61wmsaQjYrwWoUMw1WeZXg/rmNYWdUk5SuOLHF/MlAL2OSMc3+lz
         QzgXz0o8OP683eHLMVHRNgr2VU7/55fo3vNOosa0qltmoaXmmTMswrzNbO3m+j0My1Jz
         LK3arwhqs3EFLeggQjLpvSvS1ojqmhmSFIQRF0tv4L0Iq6eB2R8G9ABcwzPjOiKBxjO0
         Xk2XFxcUMpuKhVKLywo9Yi/GEtZBqng1xq117DVW40eJeFm13svwNLfknjfhk+XqP6JJ
         uTg4RtpVB+8YuhjO0xMQgpMTwj8nCQUzjYnbCTYlK7FvgANcsJmJAEyI/X/AgMtBTMAI
         rziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723861810; x=1724466610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwAZjQgeVGZrYr9IuVBFyd4iX8rZTH/EnHUupg2Amrw=;
        b=WmLrSQFTzTlEZcokBfVJ+bEXuoYBV3n7qhusYyTWFmc8gXgSi+Rw4kM5KG+CwVxnwJ
         AVI1t0Cq1G6t3UfmP23a3VFaPEfSYLKdJcOHR1LCbqloXpFK/0yUnCE+IE54Ukg3y1NM
         dedQ5obDyGk5J668Tyf8ebelvXdYqofiuo0pMrOfnwmQSX+rzZOWX/IYwM77n6QBO0VI
         ZVZLx9xdUa8YFQmGAeg/Wiry2GStQeYU1e9mTm9c3sb12baeszErobvw79k4r8sod5SM
         RcJ0sH3tUzjk4VXASfhT/4nTcOsG5toyXHgpBOaNsIiVAP6cmj9Q6XXGSq8R6Et38vLT
         ymNw==
X-Forwarded-Encrypted: i=1; AJvYcCUmgb+11Dnm4wBATreitmK8bZsiwvBhhvNvRLV+VZuWpMLLb2dB1GdpqjoJ+k9VWrT39wDhb5CzZ1gAO6xQ0QQ36lrGRg3lLIgTUviiXg==
X-Gm-Message-State: AOJu0Yx32UnvoQplQmxu7sJs3NW8xPdolvCAzrLldoi+J4XN7P7C42q6
	EiP475eZDNCEbxpHISHDRYgDHCuDnRZoXGJV4lAXaTRPHYuo9Ox1bZzDaP/uopJcxm7Ppb/zJzq
	5mLZZ+CVmBbN/cxQ3qRsToViOq54=
X-Google-Smtp-Source: AGHT+IH6/NH2oVuhgX6MdpvQ/jEnsYAyd6PV0KjqWitQwCLEl4gYN0YgHFSjzxPSCRIM1jsvzR/hFGchPXrQbfMKxME=
X-Received: by 2002:a05:6214:3203:b0:6b2:9e53:fe50 with SMTP id
 6a1803df08f44-6bf7d5b4121mr103159136d6.22.1723861810360; Fri, 16 Aug 2024
 19:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-2-laoar.shao@gmail.com> <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka> <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka> <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka> <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka> <Zr8LMv89fkfpmBlO@tiehlicka>
In-Reply-To: <Zr8LMv89fkfpmBlO@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 17 Aug 2024 10:29:31 +0800
Message-ID: <CALOAHbDRA1zZ3SgZU=OUH=3YXH71U-ZHhuBk4sBOWyF6c4yaSA@mail.gmail.com>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	david@fromorbit.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 4:17=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> Andrew, could you merge the following before PF_MEMALLOC_NORECLAIM can
> be removed from the tree altogether please? For the full context the
> email thread starts here: https://lore.kernel.org/all/20240812090525.8029=
9-1-laoar.shao@gmail.com/T/#u
> ---
> From f17d36975ec343d9388aa6dbf9ca8d1b58ed09ce Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 16 Aug 2024 10:10:00 +0200
> Subject: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
>
> PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> that such a allocation contex is inherently unsafe if the context
> doesn't fully control all allocations called from this context. Any
> potential __GFP_NOFAIL request from withing PF_MEMALLOC_NORECLAIM
> context would BUG_ON if the allocation would fail.
>
> [1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Documenting the risk is a good first step. For this change:

Acked-by: Yafang Shao <laoar.shao@gmail.com>

Even without the PF_MEMALLOC_NORECLAIM flag, the underlying risk
remains, as users can still potentially set both ~__GPF_DIRECT_RECLAIM
and __GFP_NOFAIL. PF_MEMALLOC_NORECLAIM does not create this risk; it
only exacerbates it. The core problem lies in the complexity of the
various GFP flags and the lack of robust management for them. While we
have extensive documentation on these flags, it can still be
confusing, particularly for new developers who haven't yet encountered
real-world issues.

For instance:

  * %GFP_NOWAIT is for kernel allocations that should not stall for direct
  * reclaim,
  #define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)

Initially, it wasn't clear to me why setting __GFP_KSWAPD_RECLAIM and
__GFP_NOWARN would prevent direct reclaim. It only became apparent
after I studied the entire code path of page allocation. I believe
other newcomers to kernel development may face similar confusion as I
did early in my experience.

The real issue we need to address is improving the management of these
GFP flags, though I don't have a concrete solution at this time.

Since I don't have a better alternative yet, I'm not strongly opposed
to reverting the PF_MEMALLOC_NORECLAIM flag if it is deemed the root
cause of the problem.

--=20
Regards
Yafang


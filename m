Return-Path: <linux-fsdevel+bounces-8380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5504C8358C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9C21F2257E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDCA38FAE;
	Sun, 21 Jan 2024 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LL0oHCvn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB001E4B3
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705880406; cv=none; b=jFpxzdeU2Si8LRYku+wphNOTeIqJy/RtmRAzX4dix2dY8epnyZMzfsDuDlcl3/spmtWFve9ho6IrsXIptQarLhzsF6/Dtj6+dXR3E5UpYI/srCNEXV9VMp0LolwrfBug6RTEj+LUr7tt8LToBVFevuajn+TvV8jfEh9tuqDt14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705880406; c=relaxed/simple;
	bh=SZc1NI/EZk1iJ8ESuXFylUUNLhNjkoITNYsKTA65vog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9k8uAv+gP0Ywlb1eVKXW6wEjHXH3Wm8bPHjgaLghX9vRgm5EwABZAIfqiEHTg3e3tmtXHt722r4vgygrbaVsUo+pVQ87l1lqp2TIvnRAM4hcMqPX4km3+M9SrQLD35BRVr5nQBiHZGFKebKmyA4PgzuKsLZNnJsb+iFWJwD+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=LL0oHCvn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783182d4a0aso225410385a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1705880403; x=1706485203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZc1NI/EZk1iJ8ESuXFylUUNLhNjkoITNYsKTA65vog=;
        b=LL0oHCvn/V0HqXuYRNJ8eJxQhiK2C70RyA+RFQqei0Hu/RbHt6DKD6/YW/yWgPT6Vj
         1pVF6tt+pvDOWOmXekVEkFgrJGPCUFghgnNxuVDrVFwes3c8dK7zQSWMSMIlXPAnsZPq
         3TOGjZHqXUzFXpYz7tmXf7iyDA+kSjsZsdN7UIwU4EWxee16+2zUjKwRdkMfIV0EISt4
         UMfL1Gddd6Mwl3968eZLnsqfHQtle0g2QjrFxqDj9g3m2aGAM0Z9eQ6ENJOdxNstGgbM
         /rsBzNTwnfWA9lAI/xKNtOgd5iiEJqC9UMq8wdyCnASQt/zuFEjjlVaQ2UB8kCEOZO6V
         93RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705880403; x=1706485203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZc1NI/EZk1iJ8ESuXFylUUNLhNjkoITNYsKTA65vog=;
        b=MfkYu55nmvWvra7dOEqyQky7DCz6duLQQLxjs0o6QmBsSc4fm/GwnqM9gSmsDpZ6T4
         WEBcnc3dB3QHiglQZwfxsfIk/ARm8VQ3J/rh+xa++5yju58xHtN6X/CSEJ2aK/6/STia
         Q/R34Lv6dVzNFlKPpviHUmlVPuUtPxKGWrjbbr0Yjy/pn2nv4fYh4nGji1uAx2d76oKG
         Ts56I674tjUi3wgZ/2QEkFmA5fXxmuSWpuUkRWxn40qJchhb/UEDE+WOK9DRmWKORCuR
         dY3EWSnzonZDOvH4+rfetw0OMIg4d/HFftGUX+DiFmWJdjtBJSoauH2o/VjxvwEeDn3T
         +YZw==
X-Gm-Message-State: AOJu0YxspKnNOdiwhSDGdeuBMNJkaaIPn2uJyZw6gPYmNcRYfN7MO9q+
	VKH7g3GCtKMMv8oVRRVtQGNovLbtFhVYJwIL5oHYPGK1z+VEGoW/8WxM7D9qfa63FLtAVFPggjj
	z2Z5MewnouB9LlOOLM1WniPy/enwONHuXv0eH7KfMyjMDGZeQ/mE=
X-Google-Smtp-Source: AGHT+IH5ycIqMi3jDrjLoeYUHtQzDyjfbrB05D64wCkwHBvitYAAjRqtVj46x2LsSIh2GQ8dvjslhXTJ0TJhNa/4OaY=
X-Received: by 2002:a05:620a:28d3:b0:783:9899:a165 with SMTP id
 l19-20020a05620a28d300b007839899a165mr3085566qkp.31.1705880402961; Sun, 21
 Jan 2024 15:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
 <115288f8-bd28-f01f-dd91-63015dcc635d@suse.cz> <ZFvGP211N+CuGEUT@moria.home.lan>
In-Reply-To: <ZFvGP211N+CuGEUT@moria.home.lan>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 21 Jan 2024 18:39:26 -0500
Message-ID: <CA+CK2bBmqL5coj7=hXfyj2sBZ+go9ozjZihzp4hmykxpKfQphA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Memory profiling using code tagging
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 12:28=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Mar 28, 2023 at 06:28:21PM +0200, Vlastimil Babka wrote:
> > On 2/22/23 20:31, Suren Baghdasaryan wrote:
> > > We would like to continue the discussion about code tagging use for
> > > memory allocation profiling. The code tagging framework [1] and its
> > > applications were posted as an RFC [2] and discussed at LPC 2022. It
> > > has many applications proposed in the RFC but we would like to focus
> > > on its application for memory profiling. It can be used as a
> > > low-overhead solution to track memory leaks, rank memory consumers by
> > > the amount of memory they use, identify memory allocation hot paths
> > > and possible other use cases.
> > > Kent Overstreet and I worked on simplifying the solution, minimizing
> > > the overhead and implementing features requested during RFC review.
> >
> > IIRC one large objection was the use of page_ext, I don't recall if you
> > found another solution to that?
>
> Hasn't been addressed yet, but we were just talking about moving the
> codetag pointer from page_ext to page last night for memory overhead
> reasons.
>
> The disadvantage then is that the memory overhead doesn't go down if you
> disable memory allocation profiling at boot time...
>
> But perhaps the performance overhead is low enough now that this is not
> something we expect to be doing as much?
>
> Choices, choices...

I would like to participate in this discussion, specifically to
discuss how to make this profiling applicable at the scale
environment. Where we have many machines in the fleet, but the memory
and performance overheads must be much smaller compared to what is
currently proposed.

There are several ideas that we can discuss:
1. Filtering files that are going to be tagged at the build time.
For example, If a specific driver does not need to be tagged it can be
filtered out during build time.

2. Reducing the memory overhead by not using page_ext pointer, but
instead use n-bits in the page->flags.

The number of buckets is actually not that large, there is no need to
keep 8-byte pointer in page_ext, it could be an idx in an array of a
specific size. There could be buckets that contain several stacks.

3. Using static branches for performance optimizations, especially for
the cases when profiling is disabled.

4. Optionally enable only a specific allocator profiling:
kmalloc/pgalloc/vmalloc/pcp etc.

Pasha


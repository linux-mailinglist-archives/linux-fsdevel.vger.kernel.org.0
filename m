Return-Path: <linux-fsdevel+bounces-21658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B3F9078AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 18:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA9A1F22592
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF88132134;
	Thu, 13 Jun 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KOwz7Fox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E22B17FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297434; cv=none; b=TJxQ3cNY7IWmCT8yzPvZYvenV1a2Pe4SSAWObfsfT9zy7ALMeoQ5OrYG2W1u/4QWUfMn5lXed/+xyIT/6fxzdNsRgdXeUSbdcIRnLjk22ZlvKv9A/5xmuEji9TBkbuVCM5DeE2UcOsCHZiY8+YmRRsxxSP1phWXvi2MhDgPIW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297434; c=relaxed/simple;
	bh=91rjHWfqxTOGztj0zBNywmYUrS6otdLE39NRyBM6T9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQH4qji32Y7cWrJ2qA7ytUVNTph+QHNGFyOKanR1F/jPw8jMthoOKwKf5cJIAHqt4zpbHgVot86Sh7aMZ2TgTucFcLlLxR0ZGiDIjYOJQNKenx9gl1MvAkV2Xx+UbUaCFyLMFQD+PJoC0Man+37+g516GJQug5BHYFliQAO9Jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KOwz7Fox; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so146443266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718297430; x=1718902230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kGUfdjMjAIbrnKn5yz/1VobC5vlTgVC/FlKj6pp1/y8=;
        b=KOwz7FoxKkvS1PDjJVKvofQIZ1rdNmQPv7B+Mv67zyZ50PK5Ahr1Ybt7c74CQyHkaI
         wdiNpqsa9y49bLWYNJc2fji79RKLHQXa8jRrUaIIFGO5zueqVXea01O7Obp9uS1t2HfG
         /Y3hCbb1me4toEt6VCBMexz6c0JMJ7IM8QW/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297430; x=1718902230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGUfdjMjAIbrnKn5yz/1VobC5vlTgVC/FlKj6pp1/y8=;
        b=qFEMP6Ys1fqeMi1fvNKhaNWqAZkC+tVSKiXUHhpchPXYdSnfj0cGUGxm8JlLDI0PYG
         /lWs3V4amHCOQjoI3hrm3WVP3A6uLpepF7vb6j7hbNJ2V+j6Gsk6Yv5/98ZIU+17R6Zo
         vDjl5n0zIpwlHZrQC99QWLAtqV0u7iDNghsTuJI/CnVj1AG5FaT//fHxcmKXfVp+QMBs
         xRAgrCbKgxDyTOFoXuC7sQDPHtUEHiZ/AFCekvFPmDu6NjP5wzb+WwypdLdb3+QBOmV9
         YI2gbYoq9l+RlB+R6pnMTmLzSBONPOcgU2hfZ9KJMVSvlIXPZxaqUiVKxEcDClbUO4xm
         Xldg==
X-Forwarded-Encrypted: i=1; AJvYcCUoXMqd1gEnFAk/pv3OwXgPxlBtVFRYLCOwgb0PFiSPiF/8A/TTnor4TCMZGqd6T/41ISDAOGlc6qIqs7iADwL+fvwTcprMS4WbdGKEKw==
X-Gm-Message-State: AOJu0Yy2gpp98SryCaPV/XADQcSY8UKP2b1D2lwQHcj6x0vumiumB0fA
	dfqPs8dAC6cJyBEMPQ2ngM2TuXiq6uktuRWrn/Sg87pbh9v+JCw+oY/HXvbwBm1xIlWAsFEGwRa
	XuEwUCQ==
X-Google-Smtp-Source: AGHT+IGANDhUtaAsiVy/gR9Y9R9gkW1/OqQCnzpwOt2s3vMDzU1ijtpluZtPjfD7P7hY87acXFgb3A==
X-Received: by 2002:a17:906:b089:b0:a68:cc6f:cb5a with SMTP id a640c23a62f3a-a6f60de69a0mr19673966b.68.1718297430123;
        Thu, 13 Jun 2024 09:50:30 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f4111csm89588566b.150.2024.06.13.09.50.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 09:50:29 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6efae34c83so167210966b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 09:50:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9YiGJuql4QY9o1WOPgJb5dHs2QZf4nfOVV3O4Kbo48dH+OCCb2dvY02L7Rmygm1CoqJXgdG4WzJzoTlMJSIX0DI/zSzxstoywwjdUvQ==
X-Received: by 2002:a17:906:37cf:b0:a6f:1979:7b6d with SMTP id
 a640c23a62f3a-a6f60dc571cmr22187866b.55.1718297429016; Thu, 13 Jun 2024
 09:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com> <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
In-Reply-To: <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 09:50:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijfQyv1BMHj5CFqj6C4LKaEzq4b==+Y-V3HPgDO7HR3A@mail.gmail.com>
Message-ID: <CAHk-=wijfQyv1BMHj5CFqj6C4LKaEzq4b==+Y-V3HPgDO7HR3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 23:10, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> On Wed, Jun 12, 2024 at 06:23:18PM -0700, Linus Torvalds wrote:
> > So I have no problem with your patch 2/2 - moving the lockref data
> > structure away from everything else that can be shared read-only makes
> > a ton of sense independently of anything else.
> >
> > Except you also randomly increased a retry count in there, which makes no sense.
>
> Cmon man, that's a change which unintentionally crept into the patch and
> I failed to notice.

Heh. It wasn't entirely obvious that it was unintentional, since the
series very much was about that whole rety thing.

But good.

> I was playing with a bpftrace probe reporting how many spins were
> performed waiting for the lock. For my intentional usage with ls it was
> always < 30 or so. The random-ass intruder which messes with my bench on
> occasion needed over 100.

Ok. So keeping it at 100 is likely fine.

Of course, one option is to simply get rid of the retry count
entirely, and just make it all be entirely unconditional.

The fallback to locking is not technically required at all for the
USE_CMPXCHG_LOCKREF case.

That has some unfairness issues, though. But my point is mostly that
the count is probably not hugely important or meaningful.

> I tested your code and confirm it fixes the problem, nothing blows up
> either and I fwiw I don't see any bugs in it.

I was more worried about some fat-fingering than any huge conceptual
bugs, and any minor testing with performance checks would find that.

Just as an example: my first attempt switched the while(likely(..)) to
the if (unlikely(..)) in the loop, but didn't add the "!" to negate
the test.

I caught it immediately and obviously never sent that broken thing out
(and it was one reason why I decided I needed to make the code more
readable with that lockref_locked() helper macro). But that's mainly
the kind of thing I was worried about.

> When writing the commit message feel free to use mine in whatever capacity
> (including none) you want.

Ack.
> I think lockref claiming to be a general locking facility means it
> should not be suffering the degradation problem to begin with, so that
> would be the real problem as far as lockref goes.

Well, it was certainly originally meant to be generic, but after more
than a decade, the number of users is three. And the two non-dcache
users are pretty darn random.

So it's effectively really just a dcache special case with two
filesystems that started using it just because the authors had clearly
seen the vfs use of it...

> All that aside, you did not indicate how do you want to move forward
> regarding patch submission.

lockref is fairly unusual, and is pretty much mine. The initial
concept was from Waiman Long:

   https://lore.kernel.org/all/1372268603-46748-1-git-send-email-Waiman.Long@hp.com/

but I ended up redoing it pretty much from scratch, and credited him
as author for the initial commit.

It's _technically_ a locking thing, but realistically it has never
been locking tree and it's effectively a dcache thing.

           Linus


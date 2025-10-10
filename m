Return-Path: <linux-fsdevel+bounces-63800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24920BCE29D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1036519A323B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F371226165;
	Fri, 10 Oct 2025 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YJa5BOps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5C2222D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118724; cv=none; b=fIJxgHP9tnv1HloqLEpfGkKmJCeNO0F1JMk3vX8c4tl/DrUxJwz4I4SECL7MbXCDJFYchF6gJCY568khksVbAHSAHjYBodon8B1cQ3i9jxOq83IbkMybfzY5XfDfWnkLlO0NV1VTuvuh5j0gMz1L7W3WIwLW6OoP59Rwu8E+dMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118724; c=relaxed/simple;
	bh=KAnQlIqX+V2TujbkNXT6qEjCuWozWITKkXtK7W4Igk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrVuSt/EuqtbAqwDSxAfHCzJhpvbnGFvEUKpgUk0W6kDx+85W/Vlkn7pQamqv8GoHsBCZGlUq0g8Ag8AYl6vATnvZv95U5mFxrO88qrgNy3HrP+gQolrFl8Db21lWiOlSDjkpQC+ILDvMGPc7N///ng7bIfOjt6yNvn7bVItneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YJa5BOps; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so4805861a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760118720; x=1760723520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QvQdAr9DjpPt7bc+ApQ1ILGDgUPpqYxsi4QQUD3UZbU=;
        b=YJa5BOps87h1QqJ0I1CjRUGcJ/3iib6S22tqRmMFfNAm+6E6F1U5f7VUUGK0Sy1f+m
         qS1QGE4NeUCBOHxTgSaV/wJgCgadJoy4Zbd6CCsq56YNEYkAeRuiLnpC9AbiVGna2Rgs
         6gC4LWKerf9cJkcNZcG487FUrsaf/3nLopMa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118720; x=1760723520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvQdAr9DjpPt7bc+ApQ1ILGDgUPpqYxsi4QQUD3UZbU=;
        b=D2iZfl5cRcCVLRr2pR+hr3843+llh2u5dIyOk9ho/IfscXZ8H1jxXM87M+UZ1Bz5tE
         K1RtBuSgJRcNml3+aWND0dvGdLnFkDksB5hEoagBk4nYDxZ0Rhw1HCAjsxm7STY0sLoa
         1FoNyt85rEy9bCqaCVGO3+2PFAe0SGwP74Dn7tSsRgiKUj5tpk+R6qqQLqIszdkbSfpk
         gxrQa0fGlqSKdZ6jO819jdV5QgELlfhCsJ8u5ps4glu0vju/Vd1wDk1d6VEOjF0CHO3t
         fhJlq8NsBXTMhVirSColMlUdjpO1s74+AHUt00+pk4u6x/ot1fc3mcF8mB0DzkpZ1bHW
         w+0A==
X-Forwarded-Encrypted: i=1; AJvYcCXN5NYP0S2FYhDRMQWLFK/nrq7rsb4XSPKdYs8gxeEu7UbgnhC+Er2XX4G9ujUt0LUKPpl1plWbiP5uVrgl@vger.kernel.org
X-Gm-Message-State: AOJu0YwwuMglfrl7LK2SeGWKOMEeCoxR/gDWObO19JyONdNUaFo7ZcnN
	hWoIrUSDkA2QBItVBffsyYf2DePIvUp/sbq6x8AL+Fih7HXsF4yHnBzT6A2ETJjDeu0jfVLiHEN
	AVZoQLqQ=
X-Gm-Gg: ASbGncsH/Kx508V7y0ympdoP8v9eRI5KXE7tbhCoBCLRKbGQUoKnctk8MDGp/z6FoRm
	AJcmqiuATMr+M5WZgOyADRZ1iZIZJpS6tYHMuDpb/l/BjqpJXaWx/NCckoNuPYKkiJkpNGk4BZU
	fTBmVsw52NRzLJOULKOdtTpqW6l/EgB/TTmUY8lnWgxjOQ/ooDi7BMT2nL1w/IQ+Q6tl86Gnq9q
	PT4MvFhmweq38A3nzHyObIhntxXaTxH23WnLUPmCuGYN5zCWoMvhcdM8/ryOrkYGEFVPPxqodvQ
	3CUdxrj6l0VmQg0fuU4rMN8AywA+nJ/A/sfIrnHVAYgPxxEzEbRA2LfqjeFbsJ1Z4O43yhYvqx+
	rEhCtwyLPcO/CoDekTCJV5fQlSsWZdeRlU6q/EIhLNoPHy9QFDBCGtkmdVU/RlgdC4AeU5IXaR/
	60FmatC8WPUvvw17k=
X-Google-Smtp-Source: AGHT+IEPpaRXzheGsqZc3XBGHOFJesQYCN2ZFc4OhhJ0FTYgL70siIAd51yyES6M7xHo30oz2SkOFg==
X-Received: by 2002:a05:6402:518a:b0:62a:91d5:885d with SMTP id 4fb4d7f45d1cf-639d5b8a1ddmr11799870a12.16.1760118719703;
        Fri, 10 Oct 2025 10:51:59 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c133f58sm2854604a12.30.2025.10.10.10.51.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:51:58 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso4323810a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 10:51:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUE/A/bEhmMJY9FUQEVPUPj6vnsepsYO3XtqPbQl8nwoL1SiNhh+JeAp+k1ph9mMVvZ0w/ceMtiziPejHSl@vger.kernel.org
X-Received: by 2002:a05:6402:90c:b0:634:cb54:810e with SMTP id
 4fb4d7f45d1cf-639d5c57aa7mr10472315a12.31.1760118718242; Fri, 10 Oct 2025
 10:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
 <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com> <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
In-Reply-To: <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Oct 2025 10:51:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>
X-Gm-Features: AS18NWDeOGtC5F9tBQ5g_zOvePSOzRo7FmLhKL0Jh1LjZOkog6ZFSNNw2rY-UUo
Message-ID: <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 03:10, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> > So honestly I'd be inclined to go back to "just deal with the
> > trivially small reads", and scratch this extra complexity.
>
> I will play with it a bit more, but, yes, this my feel too.

There's a couple of reasons I think this optimization ends up being
irrelevant for larger reads, with the obvious one being that ocne you
have bigger reads, the cost of the copy will swamp the other latency
issues.

But perhaps most importantly, if you do reads that are page-sized (or
bigger), you by definition are no longer doing the thing that started
this whole thing in the first place: hammering over and over on the
same page reference count in multiple threads.

(Of course, you can do exactly one page read over and over again, but
at some point it just has to be called outright stupid and an
artificial load)

IOW, I think the only reasonable way that you actually get that
cacheline ping-pong case is that you have some load that really does
access some *small* data in a file from multiple threads, where there
is then patterns where there are lots of those small fields on the
same page (eg it's some metadata that everybody ends up accessing).

If I recall correctly, the case Willy had a customer doing was reading
64-byte entries in a page. And then I really can see multiple threads
just reading the same page concurrently.

But even if the entries are "just" one page in size, suddenly it makes
no sense for a half-way competent app to re-read the whole page over
and over and over again in threads. If an application really does
that, then it's on the application to fix its silly behavior, not the
kernel to try to optimize for that insanity.

So that's why I think that original "just 256 bytes" is likely
perfectly sufficient.

Bigger IO simply doesn't make much sense for this particular "avoid
reference counting", and while the RCU path is certainly clever and
low-latency, and avoiding atomics is always a good thing, at the same
time it's also a very limited thing that then can't do some basic
things (like the whole "mark page accessed" etc)

Anyway, I may well be wrong, but let's start out with a minimal patch.
I think your first version with just the sequence number fixed would
likely be perfectly fine for integration into 6.19 - possibly with any
tweaking you come up with.

And any benchmarking should probably do exactly that "threaded 64-byte
read" that Willy had a real use-case for.

Then, if people come up with actual real loads where it would make
sense to expand on this, we can do so later.

Sounds like a plan?

                Linus


Return-Path: <linux-fsdevel+bounces-21942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F090F8D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 00:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01E91C20E3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 22:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B108615B0F4;
	Wed, 19 Jun 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kjiz/w52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C315B0F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834950; cv=none; b=SiQf3o2bcC3cSAnrCSnmenN/5fSbCcxDv/N7Of4rZ10OQCbo1MVhxBhzxgFXsMV9bZwJjqTGPK1C9Itr4PcHbWdg0B2ij3SlQ4y/Sg2gmY1JOgAAV9hESFp29pS7UzPw6NDaY+Eey5oOmFFXFKzxpwtE/ctZtJx26orMozYjSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834950; c=relaxed/simple;
	bh=6Ugp9AjDvLdrGfZ2Gc3KyD9j96fDjsRmwWHbTNcx4uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5UhsVe/SObshmH4S5CUvlTO1NrBYDYQYNIBz8UyicltXwq9437HZ12Ytr5/oO56+Cvzv0uoSoUkTgswf4u32GsEj0pcbNzLK++ntBpqbsC9R5CAVl7DBFe/ocDt8OyDrrlbpVzIudVx7GVqoWT4j77DzWGe/8J8gcSSfRHDmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kjiz/w52; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52c82101407so370902e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718834946; x=1719439746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5TBej0Qrn5f3Tc52ZOH5w1pM/xl9vd39Rilu9Xl7GPI=;
        b=Kjiz/w522dqCCTzwm8Bq2ouRxsppVKLx/IkQrAqlHsVnMpYP+AwDiXxvp6mIB2MVwy
         vBGl6lhI50rcYzkzt2eSMe1FyfevI7CmI2m0gtQv87LNd9pbfrbV7ZGgIARFdoEHOMeW
         4xFaeGM5QtDIjRj+hWw5gFak3rq/Tu51imW3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834946; x=1719439746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TBej0Qrn5f3Tc52ZOH5w1pM/xl9vd39Rilu9Xl7GPI=;
        b=rLUFQk/6b/wHR6YQfERzJoF57+OLYRm9528SCRN/yrrj/oJmEH4vaoaBFNuFJFxHXP
         WRQoL2GhColzpmIrdh6xjqR4660UZwW/JqeKUMCoxLXy0/As4MVy9PxlQCQ9EJQgPABs
         PbALWFs2wJ7oZ4amb3kyGZUOGclchkT/O/1qj2OA1ujUyrWPfceOmWbb4adnArc4GZi2
         nNIHEZJnkIKyktQx2lWCmupWGPhhz9XNdORKl6I1fJC6sNBmpvg3bd2mv1bB7FV8rteb
         FkHyQ4F4H3eOXgHS4csJYwBMlwhDgMjYcqnT+4U1RrA7N0b1h+fAKzD4o6yqfvQEE7mw
         2/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXzcMKd5NeHLvjLrRnAFHbtNFeIsjfWKZqljQQMUtl7grgAORqt+Vs1uN//AKgQ+ew/Fzfr8z2UxIqDeNRdLFJLW4fv76UipQUPqpq7XA==
X-Gm-Message-State: AOJu0Yy1rcGj/tZYONqZUy3eUOtjtem0NzF366YZG9VI4V/cR1JXSjSR
	BkhJJFrEROJQBnvNLxfem7fZK71w1mGgRZmlaYP/fhvwXTO5M5oWB6BBl/SRIUCAIvAvUxeF/i7
	HA2nAOg==
X-Google-Smtp-Source: AGHT+IEI5L9P3iu07xhEW+lJfzf8OaLpwknRUO29ypTkgUw2oHUsA7kOoGHy4H8A7hdkmkGk1vKCow==
X-Received: by 2002:a05:6512:3046:b0:52c:84ac:8fa2 with SMTP id 2adb3069b0e04-52ccaa2a9aamr2949418e87.7.1718834946184;
        Wed, 19 Jun 2024 15:09:06 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287244bsm1873152e87.180.2024.06.19.15.09.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 15:09:05 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaea28868dso2654651fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 15:09:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFeaEUckxY4PhyvTd3QhY8AG1VKETPFTF4lUDK/ZLXiBWd3K4+/uRmZbtR+QDWPOqiehwxydk1Ab5ObBNJD3J4f6gRXwd7Pg98u57iyg==
X-Received: by 2002:a2e:9085:0:b0:2eb:e7dd:1f88 with SMTP id
 38308e7fff4ca-2ec3ced133fmr29700641fa.25.1718834944648; Wed, 19 Jun 2024
 15:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <ZnNDbe8GZJ1gNuzk@casper.infradead.org>
In-Reply-To: <ZnNDbe8GZJ1gNuzk@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 15:08:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>
Message-ID: <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 13:45, Matthew Wilcox <willy@infradead.org> wrote:
>
> Funnily, I'm working on rosebush v2 today.  It's in no shape to send out
> (it's failing ~all of its selftests) but *should* greatly improve the
> cache friendliness of the hash table.  And it's being written with the
> dcache as its first customer.

I'm interested to see if you can come up with something decent, but
I'm not hugely optimistic.

From what I saw, you planned on comparing with rhashtable hash chains of 10.

But that's not what the dentry cache uses at all. rhashtable is way
too slow. It's been ages since I ran the numbers, but the dcache array
is just sized to be "large enough".

In fact, my comment about my workload being better if the hash table
was smaller was because we really are pretty aggressive with the
dcache hash table size. I think our scaling factor is 13 - as in "one
entry per 8kB of memory".

Which is almost certainly wasting memory, but name lookup really does
show up as a hot thing on many loads.

Anyway, what it means is that the dcache hash chain is usually *one*.
Not ten. And has none of the rhashtable overheads.

So if your "use linear lookups to make the lookup faster" depends on
comparing with ten entry chains of rhashtable, you might be in for a
very nasty surprise.

In my profiles, the first load of the hash table tends to be the
expensive one. Not the chain following.

Of course, my profiles are not only just one random load, they are
also skewed by the fact that I reboot so much. So maybe my dentry
cache just doesn't grow sufficiently big during my testing, and thus
my numbers are skewed even for just my own loads.

Benchmarking is hard.

Anyway, that was just a warning that if you're comparing against
rhashtable, you have almost certainly already lost before you even got
started.

             Linus


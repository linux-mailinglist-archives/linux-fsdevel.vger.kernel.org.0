Return-Path: <linux-fsdevel+bounces-22164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2A7912EFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 22:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC78B2776C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D417BB12;
	Fri, 21 Jun 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WAp6Exow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09BC17B4FE
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003228; cv=none; b=P+s077SQKIFl6lP8gNggMM6g68zPrjtsouw0WVe8yKG5urawyQxDoFB5jJ2pZA1WJMJe2PWaKDTV7Zp7hZl58T8BrlHYAtbR9Srar+rU73Ld8PK+1RGeaim0J/LUFvTlrjvyF3WwFuV2gsm5n+Ko6xgBIZyJnkBL79zNWarLqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003228; c=relaxed/simple;
	bh=YWZe1Lj9Vz+tStN44K7jpQj+Z+3vyQq0YL6FgPpbD54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHw6HCwZPlij7BzolZ+TAZl/Q+/wkpmKndNCTyAa5zbAJxo8ewMwHDLAVA4IFYQWztGRKoZLImh2LGBqLCCHodBRdQrlrenzgPpqHQvNtnZGVqBrh+Jqte7a2NmCvGSEvP5fUBVFbx/VLL83jP7Py3haZaWZ9/4QQfh11g4XUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WAp6Exow; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso24170381fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719003225; x=1719608025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aka5C4EsbSufYMzFLVzRVqI0mEYp4vGgv996ytXzems=;
        b=WAp6Exow6AXYRoHPkRJ3Fh7gJ4SCirvZ5zyKEj8FGexUA1LZZltt+353sJ/5xiD1e5
         ntLXjGA1Gox1r82TlymHsCrxIn+RgKez/z509adeqAEt/NIRo18BBMGsjHNf9o+EjQGb
         wQJ1oF1ULwt/CWaQtdGxBpE88iElTCYpVSu9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003225; x=1719608025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aka5C4EsbSufYMzFLVzRVqI0mEYp4vGgv996ytXzems=;
        b=IgUZ88fk6E79LG+Xqw72OO+VYw+2l4L/8lZjNf/yqoRp0FbYDL2TRQ+XL6tfLwlexd
         wA5yfjpkFpsW5NgvVHH/w4U2LKoyluniH+SpXVyDnMwgSPbu7PJELwTHcawtuFAJPopi
         JPXHt+KF9A58BQzjLR/9mVjWdgMlsjZ6NtX298/fI+EoD9KnQ1w0zV+zj/NFE9ZeNshb
         K93DPNfTn8yDZ0A6J8yF0pWPgSMwrEg9UMZ1NeIufr8rLxAFhU22RFNByJWe5FVRr9GA
         aEUXgB6X4nF9FKn8h/FRFK5nQWofzANhrDu5NV7lnkGCaj3PLjvC+mTySLwkXEzYk7W3
         o9Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWsgYht7FL2fTfFf4qcmBAM3InyCXA1FX664h0OGNkfCn7ELmUzL46U4ayKO8jUd19h2wCA999J0nfu++NBkh8zr3cf0eK63VxJa9MlVA==
X-Gm-Message-State: AOJu0YwiH5g+hhp0VyR9dPaMeFeoI9gagwuKBnhBQnKyA0PQ9V8g7dXQ
	cGD47+zH6tz0tsnIuk+YJ3dKv9CzXoEWDULQFLs+GVCRXoTSiQ0njfQNaPLxo1T3BuSdh5Tzgxi
	yXspnsw==
X-Google-Smtp-Source: AGHT+IF1+9r2y9LJZClb5It2/n2OWWpPVHds3WzmOJES/3EX8C0+38l67+RQElfJkpSfsQ7K6HM3lw==
X-Received: by 2002:a05:6512:3d9e:b0:52c:89b5:27bc with SMTP id 2adb3069b0e04-52ccaa974b5mr6729239e87.42.1719003224755;
        Fri, 21 Jun 2024 13:53:44 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf5492f5sm119814266b.125.2024.06.21.13.53.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 13:53:44 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d10354955so2726583a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 13:53:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWB/v/QLQS6x1IIJhye7IL1JBERlRt1o8gHsXapvgWMat0FShUCWYFY21yXtOvMh9t/BkKNQUP4elAOTUQXoTRdVExU4BTgALS7uqEr9A==
X-Received: by 2002:a50:cd85:0:b0:57a:322c:b1a5 with SMTP id
 4fb4d7f45d1cf-57d07ede1demr6003602a12.38.1719003223715; Fri, 21 Jun 2024
 13:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <ZnNDbe8GZJ1gNuzk@casper.infradead.org> <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>
 <ZnXc2qDZsZrCIxSQ@casper.infradead.org>
In-Reply-To: <ZnXc2qDZsZrCIxSQ@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Jun 2024 13:53:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrwcJVBJjjqD4cMrYhH=A-fmD0SQJyW7r7noyQAXnBSg@mail.gmail.com>
Message-ID: <CAHk-=wjrwcJVBJjjqD4cMrYhH=A-fmD0SQJyW7r7noyQAXnBSg@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 13:04, Matthew Wilcox <willy@infradead.org> wrote:
>
> What I was reacting to in your email was this:
>
> : And on my arm64 machine, it turns out that the best optimization for the
> : load I tested would be to make that hash table smaller to actually be a
> : bit denser in the cache, But that's such a load-dependent optimization
> : that I'm not doing this.
>
> And that's exactly what rosebush does; it starts out incredibly small
> (512 bytes) and then resizes as the buckets overflow.  So if you suspect
> that a denser hashtable would give you better performance, then maybe
> it'll help.

Well, I was more going "ok, on the exact load _I_ was running, it
would probably help to use a smaller hash table", but I suspect that
in real life our actual hash tables are better.

My benchmark is somewhat real-world in that yes, I benchmark what I
do. But what I do is ridiculously limited. Using git and building
kernels and running a web browser for email does not require 64GB of
RAM.

But that's what I have in what is now my "small" machine, literally
because I wanted to populate every memory channel.

Not because I needed the size, but because I wanted the memory channel
bandwidth.

IOW, my machines tend to be completely over-specced wrt memory. The
kernel build can use about as many cores as you can throw at it, but
even with multiple trees, and everything cached, and hundreds of
parallel compilers going, I just don't use that much RAM. The kernel
build system is pretty damn lean (ask the poor people who do GUI tools
with C++ and the situation changes, but the kernel build is actually
pretty good on resource use).

So the kernel - very reasonably - provisions me with a big hash table,
because I literally have memory to waste.

And it turns out that since _all_ I do on the arm64 box in particular
(it's headless, so not even a web browser) is to build kernels. I
could "tweak" the config for that.

But while it might benchmark better, it would likely not be better in reality.

I'm going to be on the road this weekend, but if you have something
that you think is past the "debug build" stage and is worth
benchmarking, I can try to run it on my machines next week.

              Linus


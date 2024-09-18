Return-Path: <linux-fsdevel+bounces-29643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD297BD5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90782B28834
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE518B471;
	Wed, 18 Sep 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y5QQ0Ze2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF5189F5D
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667523; cv=none; b=pwaqIIufUEt7OgXGIfJss8oetpZQ5Nip0hhQRCQ20Gg6ryFAnlvYOqSll7OYoI/Nf4c3u/fKsBEO26AgU+QQit0zVDiRCP4UZb7/4/soYh46sU6ouUkXU4QYqDHe5U5sZ3hhxX7zMI3Z+d8hLicPQYMhNv4AIzxcGzpO7Vj9H4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667523; c=relaxed/simple;
	bh=jJVr2CDyy7rQp2h2UjSJiI9buPJ4d++KINwnkdK6qcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkVsP6AoBMfLtKV2MAUILi5ykEBetpPnaHKljH+Q0vDXhwabOfGi79sh8pBg5XPw9+SKf70sFg0uk6KqyD5wHES4yftlMV3v+SGQPD7j1fxAqmlAmx6tUiooDeVO9k03Zixzv6yYXtd34E+j8uOjJ9EBcWJaTpQm9nrzWevicHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y5QQ0Ze2; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so73777801fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726667519; x=1727272319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+OjIl9uDxGAJUC7PJ0lAX4rCR6IE5m7Lsi7Ws5gE7Fw=;
        b=Y5QQ0Ze2C2/Lyp3vpbQlEVIwUiAcRTMyC8tJNNyncaeNz+Fp9s60R858g9u6hMDnwA
         AG39e/vi9vbeT1LhsUCquDaK8DqKRQ392I6QMniUMEHf3SR/6m0FPa3ma7R5Tm0R5uN3
         0mscOYZU5Q5pn4BoUEg60al7/N2nqkeIZ1PL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726667519; x=1727272319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OjIl9uDxGAJUC7PJ0lAX4rCR6IE5m7Lsi7Ws5gE7Fw=;
        b=FfwxN4S1BauIufu4VKjtzeApmenLDX7/wEC+ZYGz6nA5d2udMpPEMR4Gr2lnea0zbj
         NL+TlXlSlqOjrpndJnXYgucnObIpNpZLSzvJkDozJDz7ic4u0+Zz/j9w0f5B0BL23BJi
         Aft/mspBEbrpVq6LgkcItyvb89k4Ffe3MGLBj5hm2n+Bkw41QyDwFI4iyRYkn4+wm9bz
         QBjq2uWcc73b86CnZ3x7iSwWSbuPBDfaw8ZeyonIvn0hM1UBAt/FQuSxR1qwtHdiVqHO
         L4y+JYzPWCtJ6/KpI4RoisJBkOlcZutr4revLHUOL9mlLRZhhXMmL714PkniNtEgc1MI
         6eRg==
X-Forwarded-Encrypted: i=1; AJvYcCUprsByrHdRic4yg1kzOXr3wezm6zNJ/YTxju4e6HcwURMH2UxUD27E4ZXJw76SzBn800ddjQTYCuigU88i@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz85fsPwyJoQiQoRilGGgsxeKaClA1EAHJ6UrKYgs+WaX/g697
	Ux3vx9TV4Z/vEIK9jaDmiRd64U1EpHk9Y1jD9IOojmKVfRmcw+ukC+GZG4gxijm28qKtH+79a9E
	lVBCUbg==
X-Google-Smtp-Source: AGHT+IGp4/JV69FbO0tfVo2Yz3i473bhguCtNNrc7jKQ7gv89lJUsVqUhiUIwbNYAtDaP1Qk0qlplQ==
X-Received: by 2002:a05:651c:556:b0:2f7:631a:6e0c with SMTP id 38308e7fff4ca-2f787f44858mr135516061fa.35.1726667519010;
        Wed, 18 Sep 2024 06:51:59 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d2e1eb5sm13251471fa.27.2024.09.18.06.51.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 06:51:57 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-536584f6c84so8662439e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 06:51:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJtQJbYA/xirZWtHD4cDG4L7gz8EigaE/dF6CCetoLJglePM2ZifLXzanp/p6eFS+c92og0BPwp8x0Xgk6@vger.kernel.org
X-Received: by 2002:a05:6512:4019:b0:52e:fc7b:39cb with SMTP id
 2adb3069b0e04-53678fce759mr13328998e87.26.1726667516650; Wed, 18 Sep 2024
 06:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
In-Reply-To: <ZurXAco1BKqf8I2E@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 15:51:39 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>
Message-ID: <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 15:35, Matthew Wilcox <willy@infradead.org> wrote:
>
> Oh god, that's it.
>
> there should have been an xas_reset() after calling xas_split_alloc().

I think it is worse than that.

Even *without* an xas_split_alloc(), I think the old code was wrong,
because it drops the xas lock without doing the xas_reset.

> i wonder if xas_split_alloc() should call xas_reset() to prevent this
> from ever being a problem again?

See above: I think the code in filemap_add_folio() was buggy entirely
unrelated to the xas_split_alloc(), although it is probably *much*
easier to trigger issues with it (ie the alloc will just make any
races much bigger)

But even when it doesn't do the alloc, it takes and drops the lock,
and it's unclear how much xas state it just randomly re-uses over the
lock drop.

(Maybe none of the other operations end up mattering, but it does look
very wrong).

So I think it might be better to do the xas_reset() when you do the
xas_lock_irq(), no? Isn't _that_ the a more logical point where "any
old state is unreliable, now we need to reset the walk"?

                   Linus


Return-Path: <linux-fsdevel+bounces-25431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A2A94C251
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398521F2419C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BB618F2F4;
	Thu,  8 Aug 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a0Q6z2wr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9DD8003F
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133484; cv=none; b=aFBGz1o0qSuyI5XEvJSFR4RIyMIBK32cbMkxWx6OqBkKfu4dR8Yviw+uLMifUNGDJJ9CVaJ5Glbumi90ERx+UhTruLJv3R8lymfMQvQZnTPPJ1DX2undjt5QOaMDrblUcPiuk8VRZLGYG2bxybM7sWqO8+9d+rXUM3vIKTYsoIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133484; c=relaxed/simple;
	bh=AdKmFqksDmNclyIkEncPJZfDqK2vHjO7yPng37E+E0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fI+/Z/qLZLckS0TZxBt7lq2tBZITkC2OdyIWjG7bkmnzcoBxeJ3HEgVaHTsR2x+y7U0tK+28K2I+e7RLH+tyryGIc7ObScByiKUILVDEO1htVqlZPtUXPOim2/03q0hD8ks2zlXppV8kAaqlRwgiAg0riUblfixpIHzbE6BTV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a0Q6z2wr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso1128211a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723133479; x=1723738279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKQvCncQGxuRHIk0L9mOtoKBGHkt2/dJnHYSaRcyDAk=;
        b=a0Q6z2wrqR8dv+Fg8eecf4mdJ+91NN4605sM7u//DONi8o/65Qex1XbDT49B1xel2m
         Y+m6MdFXe6WBOuEpEjje8wRTSPuw0IQ4Fk2gdgw4WU7pV6X9pXXu1b1h8AdqLp9UGQwp
         Mo3gOqnOWPU8f8Q7UNe3HaLyPPPqwMg2D/11g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133479; x=1723738279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKQvCncQGxuRHIk0L9mOtoKBGHkt2/dJnHYSaRcyDAk=;
        b=oEsCsY+3OxUpXywszV/QnWnzLIUvCI5163rRHCv0qvDf8Aod8KBDoyRDcWOIkI/tSa
         IbFcuSJkDNQXL2ZFZ+RmGCGVLwx3tM+4rmarOA4/MVSMswNq2IfqjIFJ6x9xDTfYkfm/
         LWjwPWHm3VE0YEOrr+X03nCi3/X8nctcFUrjlwv3RCqt7jK0kmN7oOWzFZWuO0qufHIZ
         hpx6Xta/yHjkIAE559mMIXu459/SbgX7TLre+Ydjk30Uqyxar1aCRJrZj5wPhXRWdsRs
         4V03j29eOP/S8OmBpzNYH1cmjoeO3r+gd4M8RiKy14krqvAezJ6yJPbOwIA/KrtDuqXH
         nWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdI6LMb+Zi9od8lQwzA/i/uJxA6B3ixKRN5/Ez9qYE5vRJv7a/wtU3OzgcYfJMtO65z2rd/RF9aA0GQ4zH3Y4ozE7cZR3mPLcxDnRBFg==
X-Gm-Message-State: AOJu0YxMJjvTI3eIpuHtgRCsmYoHqgB63jkLbyBV709rXPaKm6668bA0
	gzSt6SnSvPaCwZLPDnxPkY2tLQN7NJo67JYC4TjUij0pK6YvvTeO3XrNQaygtFufY21LCBYD+oD
	Omwl4sQ==
X-Google-Smtp-Source: AGHT+IFu+2t4A5wAd+QJd7GQ7pzdsK7eo7wmaKbiJ1E0MeoE50Uz0J7LhRf2XKXVHKje6oWnPQJZGg==
X-Received: by 2002:a17:907:ea6:b0:a7d:ea36:b294 with SMTP id a640c23a62f3a-a8090c83627mr186845166b.26.1723133479094;
        Thu, 08 Aug 2024 09:11:19 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80df8sm752038866b.160.2024.08.08.09.11.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 09:11:18 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso106573466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 09:11:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN2fXfZLdrdX5MYcQBSCoIl5YHG1tytFdxV3/LtZQlr0n1qNlGFzKVxSPqOF//ZhYLiHjH+oeDm9kUOaid38vksYtqd3hIheMZ8TpIuw==
X-Received: by 2002:a17:907:d2da:b0:a72:8762:1f5d with SMTP id
 a640c23a62f3a-a8090e9e1ecmr183599366b.55.1723133478002; Thu, 08 Aug 2024
 09:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808025029.GB5334@ZenIV> <CAHk-=wgse0ui5sJgNGSvqvYw_BDTcObqdqcwN1BxgCqKBiiGzQ@mail.gmail.com>
 <20240808-dates-pechschwarz-0cccfed2c605@brauner>
In-Reply-To: <20240808-dates-pechschwarz-0cccfed2c605@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Aug 2024 09:11:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivmMgGiSnUm35WVm9=yNM1=jrHG4fgWo09XWwWZzvTMw@mail.gmail.com>
Message-ID: <CAHk-=wivmMgGiSnUm35WVm9=yNM1=jrHG4fgWo09XWwWZzvTMw@mail.gmail.com>
Subject: Re: [RFC] why do we need smp_rmb/smp_wmb pair in fd_install()/expand_fdtable()?
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 06:20, Christian Brauner <brauner@kernel.org> wrote:
>
> But then multiple times people brought up that supposedly smp_rmb() and
> smp_wmb() are cheaper because they only do load or store ordering
> whereas smp_{load,store}_{acquire,release}() do load and store ordering.

It really can go either way.

But I think we've reached a point where release/acquire is "typically
cheaper", and the reason is simply arm64.

As mentioned, on x86 none of this matters. And on older architectures
that were designed around the concept of separate memory barriers, the
rmb/wmb model thus matches that architecture model and tends to be
natural and likely the best impedance match.

But the arm64 memory ordering was created after people had figured out
the rules of good memory ordering, and so we have this:

   https://developer.arm.com/documentation/102336/0100/Load-Acquire-and-Store-Release-instructions

and this particular quote:

 "Weaker ordering requirements that are imposed by Load-Acquire and
  Store-Release instructions allow for micro-architectural
  optimizations, which could reduce some of the performance impacts that
  are otherwise imposed by an explicit memory barrier.

  If the ordering requirement is satisfied using either a Load-Acquire
  or Store-Release, then it would be preferable to use these
  instructions instead of a DMB"

iow we now have a relevant architecture that gets memory ordering
right, and that officially prefers release/acquire ordering.

End result: we *used* to prefer rmb/wmb pairs, because (a) it was how
we did memory ordering originally, (b) relevant architectures didn't
care, and (c) it matched the questionable architectures.

And now, in the last few years, the equation has simply shifted.

So rmb/wmb has gone from "this is the only way to do it" to "this is
the legacy way to do it and it performs ok everywhere" to "this is the
historical way that some people are more used to".

For new code, release/acquire is preferred. And if it's *critical*
code, maybe it's even worth converting from wmb/rmb to
release/acquire.

Partly because of that "it should be better on arm64", but also partly
because I think release/acquire is both a better model conceptually,
_and_ is more self-documenting (ie it's a nice explicit hand-off in
ways that some of our subtler "this wmb pairs with that rmb" code is
very much not at all self-documenting and needs very explicit and
clear comments).

Now, I'm not saying you shouldn't add a comment about a
release/acquire pair, but at the same time, the very fact that you
release a _particular_ variable and acquire that variable elsewhere
*is* a big clue. So when I'm saying it's "more self-documenting", I
want to emphasize that "more". I'm not claiming it's _completely_
self-documenting ;)

        Linus


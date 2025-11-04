Return-Path: <linux-fsdevel+bounces-66980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9544C32BB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 20:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A126D4E7236
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F7E33EB0A;
	Tue,  4 Nov 2025 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BvU1RC60"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E22E62A6
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283288; cv=none; b=Bm/TR8GswkmijSjG7sqe35MM7doviszMlKE/sksjP+vlRnW4urc3Q9ZvNlPuetUdFQax22OVm5In4TFh/c8zb1SPGsSsDnWFRcCv4t7sD1we6ile9DPt0WF4wCAvmDJEvmjhDFNNWDrXdZT5eidGq0/aZwBIJoOY9QjT0TWMijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283288; c=relaxed/simple;
	bh=9PbXECyM/ppEw73G19W07knzHtFK2i4sPouqb3V9IkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fytGqvsBPrKFfSO07lcY+j6+5jbEcMSWJBLTl+cmC9vDNzhk9m0YxxjGUPbhjd6sFrSjPQawCYuwnk8bQwHRm4miuPBaeqy1bCr43TQWHicTjNZj7aqNgYpZEfw2j0+3mAPdRtdZn4TgiMo4+hzAGmR0yYxSRTGkODbgjgbVuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BvU1RC60; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so6376319a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 11:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762283284; x=1762888084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q+hzUPNbXmbOEbK0/6dvG/NjDNLu+WmiU1f8ZDEUtyo=;
        b=BvU1RC60Rd542J8K8PyaflxbcCz2Q0wJKDIHJxctI4INj/efvhmKq/oxwxWboFJa8n
         DHzqsNlsMXEQxAGB4CuXaRoz5anEWU0h3YAdm0YZAh1gy56MVBKdNbipJxrRHP0wZbmb
         nEzs1PV7aI85lB27yqhE/ORQN2/Pmwo4vjlUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762283284; x=1762888084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+hzUPNbXmbOEbK0/6dvG/NjDNLu+WmiU1f8ZDEUtyo=;
        b=KjasWRnldVCqKhc5A4rnv9nn/kR02Sh3G7yXrEAlkYeVC2U7GJL36EHEJrjSKLtUaU
         DIxwbXtWX73AWx/ncGwBKX/lBCCRjqzHFu1eAAJxQpHac0PB71vtifRI3jE29mlQ+E5s
         U1tnGBPnyQ2cQhtZOYZePxpMs0o0BxM3jRVnAnrmhIiB9WyOtEDwnsEOAfLXxuaRaoQO
         +iwE9cXhhk6dQbHxu18uiIupil4dvON74AMd3uZo78lDetZ4zzUq/I6F6RaeeELa62RU
         MoW4RF/XRg6aANjDFwWvZKONp9qah1OR3IRKFnvimAiYM9rIXsxGID9FEa0KwlIOavIe
         2x5w==
X-Forwarded-Encrypted: i=1; AJvYcCVPbtf4md397bxm9NhrJwHu1JRxRavd8O6hTt08TAc989Nx/3/kBC44/+Y8WdQoHvlGG0i+dqx9SZcs9Pb8@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyIxXWbliEj5JzHzNBt/o6Es1Kx2pbhnRQFfDrFri7nwgibqq
	q0/ZxD5At3iAG1RDXgjm5dc4qKGqryTAmjUD4FFCqryBG4HQd42EfgxIXEiacuneyFhaVvSMr8p
	CKBKVLPw3Gw==
X-Gm-Gg: ASbGnct2lMZ3t3exqDV1/KmqzY2ba6JHExkT2g1FfoTXH2BYCwn4HFZr13ppZ0CDP+i
	spl6tVSipH1K9v9KJPSFfVwwmBwge1NuIoNJHtXOWNuGhTcGMyX+Cl9okgFSGBIZJNgHKdyLuss
	zB2eQCRlpl1XgNmRwoNeCrK7FYqx0otKEuegk1dIIGuQchubxiRj/z65/8h+TpaO/A8gxBcEqAK
	BDMB0DYOHlXatoPsRX+KYmG6hMdguZtQ9bm7YkcMks62UNxsQXJrf4LdHwb5Dq+Vjmi4Rg+WKta
	sd0Sh/B+aMHaKwPYsMmWtbYFyJdPAZaE+oiQ3BTIDNPnwmXpt2p80WUjcNou0cTAccjh7mQ+4ZQ
	1uXMrrPlblHuvZDdUCqhOzV1rNh3KNjU2Oy9Qh4BT0R+OKNFmLgKwxQw1C1u+wUFr4H7518eBYe
	r/4sJgDH71ObTM8gP7P2qkkjqOZq0t+XMhZMzysvBifKO5XCnzug==
X-Google-Smtp-Source: AGHT+IEOFyI4Bcntcmj3IlbYnPhgs1pvadCSSg1tzOHlVXrGlEo8kqhd3kY+AtbPKGuI6h+ZkZuXgg==
X-Received: by 2002:a05:6402:84d:b0:640:36d9:54fe with SMTP id 4fb4d7f45d1cf-64105a4cce7mr294124a12.24.1762283283974;
        Tue, 04 Nov 2025 11:08:03 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e67eb65bsm2762346a12.4.2025.11.04.11.08.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 11:08:02 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7200568b13so279415066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 11:08:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdFWh0msNAnaZtNIZOt32gu/W3cNzAFNhNXHDwkfPow4DSGcLWHuvUP84TyLcr50zsBxwZ0pH50dpSE7ij@vger.kernel.org
X-Received: by 2002:a17:907:3d44:b0:b72:5a54:1720 with SMTP id
 a640c23a62f3a-b7265682b6bmr19875966b.57.1762283282425; Tue, 04 Nov 2025
 11:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com> <aQozS2ZHX4x1APvb@google.com>
In-Reply-To: <aQozS2ZHX4x1APvb@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Nov 2025 04:07:44 +0900
X-Gmail-Original-Message-ID: <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnsJnu_LlkWN2ZcU9tBsfAEnxyUDvIiSqWsCKYbcoFT1Otlp3W0KDjsg8g
Message-ID: <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Sean Christopherson <seanjc@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 02:09, Sean Christopherson <seanjc@google.com> wrote:
>
> What exactly is the bug?  Is the problem that module usage of runtime_const_ptr()
> doesn't get patched on module load, and so module code ends up using the
> 0x0123456789abcdef placeholder?

Yes. The runtime-const fixup is intentionally simplistic, because the
ordering concerns with the more generic instruction rewriting was
painful (and architecture-specific).

And as part of being simple and stupid, it doesn't deal with modules,
and only runs early at boot.

> Just to make sure I understand the impact, doesn't this also affect all flavors
> of "nocheck" uaccesses?  E.g. access_ok() + __copy_{from,to}_user()?

The access_ok() issue happens with those too, but I don't think there
was any way to then trigger the speculative leak with non-canonical
addresses that way.  Iirc, you needed a load-load gadget and only had
a few cycles in which to do it.

But in theory, yes.

> Looking at the assembly, I assume get_user() is faster than __get_user() due to
> the LFENCE in ASM_BARRIER_NOSPEC?

The access_ok() itself is also slower than the address masking, with
the whole "add size and check for overflow" dance that a plain
get_user() simply doesn't need.

Of course, at some point it can be advantageous to only check the
address once, and then do multiple __get_user() calls, and that was
obviously the *original* advantage (along with inlining the
single-instruction __get_user).

But with SMAP, the inlining advantage hasn't existed for years, and
the "avoid 3*N cheap ALU instructions by using a much more expensive
access_ok()" is dubious even for somewhat larger values of N.

> Assuming __{get,put}_user() are slower on x86 in all scenarios, would it make
> sense to kill them off entirely for x86?  E.g. could we reroute them to the
> "checked" variants?

Sadly, no. We've wanted to do that many times for various other
reasons, and we really should, but because of historical semantics,
some horrendous users still use "__get_user()" for addresses that
might be user space or might be kernel space depending on use-case.

Maybe we should bite the bullet and just break any remaining cases of
that horrendous historical pattern. There might not be any actual
relevant ones left, and they should all be easyish to fix if we just
*find* them. But we had that pattern in at least some tracing code,
and I'd expect some random drivers too, just because it *used* to
historically work to do "the user access path does access_ok(), the
kernel access path doesn't, and then both can use __get_user()".

In fact, Josh Poimboeuf tried to do that __get_user() fix fairly
recently, but he hit at least the "coco" code mis-using this thing.

See vc_read_mem() in arch/x86/coco/sev/vc-handle.c.

Are there others? Probably not very many. But *finding* all those
cases is the painful part.

Anybody want a new pet project?

              Linus


Return-Path: <linux-fsdevel+bounces-67007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75CFC331BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 22:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB79418C094E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97027346791;
	Tue,  4 Nov 2025 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDwme/zD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2B2FC00C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293209; cv=none; b=dL1LngMeWJ5caHA9z8lznFg8oaSTNgJiCrnD0if+0AoPXisphNoNv26jYZ7oFWRD/mOoT7cWesBVijgdmvS9LAyVAseYlKuErptJ/vPpBRhB4VcjOkNs0ZzGScV3ymK0DC1eeVPWXT2GhCcyGtha/Vdc7F6ld+Z5rIzzNwvyIhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293209; c=relaxed/simple;
	bh=FiI9p9fL07foN9U6NE+nplVhbZVds5ennOI07GP8Ozs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rJEPbU28J48JvQIYxC90LnDn8pvGVNcsp3z9vynrVRc6NLmvlEy4MJxwkqYch4xIzQ6qjrT3uiYRwIOOhsDFjlOgxqkkFFhUXfphqcFUfKEMmr0mzeK7pfCbu/s4uUZoJ1ZbPYV2MFMVcUCo4egIR9ZuwBl/uU2CnfOH4Cys7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDwme/zD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so2179078a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762293207; x=1762898007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXD0qHrs8srMCRrDjUfBB17xsmweOCKSQJGW+x1+97c=;
        b=PDwme/zDc9oDY2DHSk5HfRhPNtieTuL6Pp0TWqmOrIFGXl9638VwxpnQDMJVw7InLG
         iFqagsIePnaIU/vNtJK6WABN08WpeNdCwkFjhU+eD/OpAIKLtZnhynGy64iSwo4FwC4C
         zThA9JsBOexRfaJQmf1Q1GzRJawTy0AKfusiOrv+59VEQ4dC924ngrCsy0Izk2jC9BI+
         q2FQbJruRQrkzBp6ezTRB2T/7W7xYXiTxaWxkJ2NYaplRGL9DkxL0Ez4psQ+vEHF2Ejh
         HJ8N4fIn3H+oqTpKp2002WsaOnsOhSbZsl1wT1N4FqRh4KcM10ycRv9dkgTuuDcl7hA3
         0Z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762293207; x=1762898007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXD0qHrs8srMCRrDjUfBB17xsmweOCKSQJGW+x1+97c=;
        b=c6ygBnRb64RgwZHDf63ixpv3pXsayAQLpY7AJYQfFfK9Y62xRnjXj8P/piJRtZbiQ2
         6CdbQAwJdYqX17NdiIMJ3pbi1buqgeB9vbxICptt1uZh9h6Gx3y22Ri8C7jx2uwc10BM
         UFhWxwManKw70s0o/b7ehliU7a3vSFFal9HBiV9XZ+6DqnJFjPJkh0ZwAVyrcojwoxY4
         q2cx+biClEj7rSjBMuUfY17q1BDRH34A2+TNJRyCaPSweQpYFG1lVHKe22o/MrQMRHmm
         2D8KlRtUumWPdW6BTNYNGUUtGpALQcsOKXMbBk9UjtTHfwPavL3XW2AgYRAQ0yAkoi1y
         QccA==
X-Forwarded-Encrypted: i=1; AJvYcCUvlWcoSSlLmuyHaRvZZ49xBrJxEJtLxPbbarLTv/Siqw7O0lzkyOX1IqVYHCAwIzEmsZLSN0jiQuvh/l4j@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+NvMRbhr+3BF+KVA7AM7ZWxA7YmclvOyIxspsS5gp6S9c0ML8
	+G12XgCcRXSZHOUEjgXREnaADIpkorf4bNTQhRLj6xb60y+ejLBxA9zbf2O+bKE61qarv42S2yG
	+rn1zvA==
X-Google-Smtp-Source: AGHT+IH1XoNQfghiAg7S86NH4YPLrBciXDQBVrF/kug/MKIjKX8NM65/a5W+DsUMJHgdpwqsqGgojgCN3sg=
X-Received: from pja8.prod.google.com ([2002:a17:90b:5488:b0:340:cddf:785a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cb:b0:330:bca5:13d9
 with SMTP id 98e67ed59e1d1-341a6de7a07mr874146a91.32.1762293206792; Tue, 04
 Nov 2025 13:53:26 -0800 (PST)
Date: Tue, 4 Nov 2025 13:53:24 -0800
In-Reply-To: <CAHk-=wgYPbj1yQu3=wvMvfX2knKEmaeCoaG9wkPXmM1LoVxRuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <aQozS2ZHX4x1APvb@google.com> <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
 <CAHk-=wgYPbj1yQu3=wvMvfX2knKEmaeCoaG9wkPXmM1LoVxRuQ@mail.gmail.com>
Message-ID: <aQp11AiTJpg_m_MG@google.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
From: Sean Christopherson <seanjc@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 05, 2025, Linus Torvalds wrote:
> On Wed, 5 Nov 2025 at 04:07, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Sadly, no. We've wanted to do that many times for various other
> > reasons, and we really should, but because of historical semantics,
> > some horrendous users still use "__get_user()" for addresses that
> > might be user space or might be kernel space depending on use-case.

Eww.

> > Maybe we should bite the bullet and just break any remaining cases of
> > that horrendous historical pattern. [...]
> 
> What I think is probably the right approach is to just take the normal
> __get_user() calls - the ones that are obviously to user space, and
> have an access_ok() - and just replace them with get_user().
> 
> That should all be very simple and straightforward for any half-way
> normal code, and you won't see any downsides.
> 
> And in the unlikely case that you can measure any performance impact
> because you had one single access_ok() and many __get_user() calls,
> and *if* you really really care, that kind of code should be using
> "user_read_access_begin()" and friends anyway, because unlike the
> range checking, the *real* performance issue is almost certainly going
> to be the cost of the CLAC/STAC instructions.
> 
> Put another way: __get_user() is simply always wrong these days.
> Either it's wrong because it's a bad historical optimization that
> isn't an optimization any more, or it's wrong because it's mis-using
> the old semantics to play tricks with kernel-vs-user memory.
> 
> So we shouldn't try to "fix" __get_user(). We should aim to get rid of it.

Curiosity got the better of me :-)

TL;DR: I agree, we should kill __get_user().


KVM x86's use case is a bit of a snowflake.  KVM does the access_ok() check when
host userspace configures memory regions for the guest, and then does __get_user()
when reading guest PTEs (i.e. when walking the guest's page tables for shadow
paging).

For each access_ok(), there are potentially billions (with a 'b') of __get_user()
calls throughout the lifetime of the guest when KVM is using shadow paging.  E.g.
just booting a Linux guest hits the __get_user() in arch/x86/kvm/mmu/paging_tmpl.h
a few million times.  So if there's any chance that split access_ok() + __get_user()
provides a performance advantage, then it should show up in KVM's shadow paging
use case.

Unless I botched the measurements, get_user() is straight up faster on both Intel
(EMR) and AMD (Turin).  Over tens of millions of calls, get_user() is 12%+ faster
on Intel and 25%+ faster on AMD, relative to __get_user().  The extra overhead is
pretty much entirely due to the LFENCE, as open coding the equivalent via
__uaccess_begin_nospec()+unsafe_get_user()+__uaccess_end(), to avoid the CALL+RET,
yields identical numbers to __get_user().  Dropping the LFENCE, by using
__uaccess_begin(), manages to eke out a victory over get_user() by ~2 cycles, but
that's not remotely worth having to think about whether or not the LFENCE is necessary.

The only setup I can think of that _might_ benefit from __get_user() would be
ancient CPUs without EPT/NPT (i.e. CPUs on which KVM _must_ use shadow paging)
and without SMAP, but those CPUs are so old that IMO they simply aren't relevant
when it comes to performance.  Or I suppose the horrors where RET is actually
something else entirely, but that's also a "don't care", at least as far as KVM
is concerned.

Cycles per guest PTE read:

                __get_user()    get_user()      open-coded      open-coded, no LFENCE
Intel (EMR)		75.1          67.6            75.3                       65.5
AMD (Turin)             68.1          51.1            67.5                       49.3


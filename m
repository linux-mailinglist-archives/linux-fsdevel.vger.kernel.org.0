Return-Path: <linux-fsdevel+bounces-66620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FBC26919
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C751A65F8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141F2EB859;
	Fri, 31 Oct 2025 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofEdIBD5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D570405F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935477; cv=none; b=C9qYWVKvAvzKIaYPknoKu3E0iOpK3+XYb3d4434biJeHj60xGyBsCF/F5wVUjDeAKvKh5m/aKajUw15qPF0kmqpnFZgMKeu+gTQuhi6X6/ZEtql3U2hm3vnE0VjRGU4wsVUvrvwkERo5G1iDGAADOYIIR3xhNCdRscW2A3ObCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935477; c=relaxed/simple;
	bh=4EmsAdmUDoKsJ3nHoaGiAdPdYRnKJhE+ODFWyv6RuBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HUOvlLz7OO+uzobg/3T+v/g8x+tucgz+7UIyCD52ClweJJ1vHpVPrFVAXsI/ql6Fl8DkbIiSt+qou8vgeOJhQFU1RKYx6ZZYaeRt4cC8LgekDFzZbi5Jwpr1ZUaDJxrz04z8tub1XdjAOuUqAfABVdJv+y9i2h7ngnN2T9KI7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofEdIBD5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475da25c4c4so21934655e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761935474; x=1762540274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EmsAdmUDoKsJ3nHoaGiAdPdYRnKJhE+ODFWyv6RuBg=;
        b=ofEdIBD5JBOP5kcIE/toSN5tiSEArQhh/unIU0S/XVGi4GRRHrACIKQDhQ+ULjCz11
         adKGdXRR4Wd6VaH1tRwN3eF4JaXVvTDPxrhibiOgr7GQlKQU/LqcEcBWcVuQNtqYuN+T
         wmFqM8PCjrSwSVdDW4VM5WOiTgK45tO4u3/G5t2AqNpR326uZHMALoooTESIB4vqTOjk
         PDfiESH12MfwteksEkmPrz7eG4wV2yD0VncEudKifOSjQm3lKosYYSKFpOAdL0qsNe+3
         ZyotL2imxUeSEHeMo0pUdrhOlALvV1p7jD+3YSBIYI2qZ9788NkOVoqBaxb0WKPp4zXP
         pZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761935474; x=1762540274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EmsAdmUDoKsJ3nHoaGiAdPdYRnKJhE+ODFWyv6RuBg=;
        b=w8mynVRgO5bNiWjTwdNqIpIpgxkS+k9C5AF6l5BLwkc5X9rvbj1vgkkYSui0VWdWOn
         C1H4xqZBaviCeTjGgHg9hHFwTBkqor73s4w0SKbakRaMAACHu2nm9BUbF1u6cWPxaOGd
         y5ikjLyp6p3OVjvtU2LY0Cg3FH5UY7ARetOWRPxmXnuNEXkY9ccD+Uof5WbvUYFOBRet
         4TcdEOGfapXN3mPShF/o2VXHzZ88w6DrCdVC+W+CxIfhIOpflc6+VruPPdzvbVZU4bpO
         vTpD7nGmBjoioJAuhDhKgDtYLyA3yU8xcTNmhLulBiigHFNyPfmvKahpLKigJWLKh81L
         WY2g==
X-Forwarded-Encrypted: i=1; AJvYcCU/IcxAAOhEGQv/YCBW3HIjbfav/iUT4i9XHJHfHkf8FCceJvW/a4wcrOzTOcOnu2ZjjkhQh1grezKD6f8C@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XOu4ihZ/SyBRtUSM462VNcP4qQVMW0hhDzwhLPauntlkMdFB
	vP2oiHW6W8TT/d4xMSQymaGAllELZeruBYQS4Xm4Avx9NSv6paRElsdwKsxqC/pvSO+PtruBBfF
	aF3wMAX/9neM0cA==
X-Google-Smtp-Source: AGHT+IF0oSz4CxTQF0nqeQnWSAmNxvR2sRC2JSlBMi4CM6sxr7VzMzJzOGlnc5XOQifgEAhMHxR06Z4dSq+21Q==
X-Received: from wmat7.prod.google.com ([2002:a05:600c:6d07:b0:477:17a3:394a])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:528d:b0:46e:1d01:11dd with SMTP id 5b1f17b1804b1-47730802d2fmr44933805e9.2.1761935473616;
 Fri, 31 Oct 2025 11:31:13 -0700 (PDT)
Date: Fri, 31 Oct 2025 18:31:12 +0000
In-Reply-To: <DDVS9ITBCE2Z.RSTLCU79EX8G@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk> <20250924152214.7292-3-roypat@amazon.co.uk>
 <e25867b6-ffc0-4c7c-9635-9b3f47b186ca@intel.com> <DDVS9ITBCE2Z.RSTLCU79EX8G@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDWPZY3AA7BX.1Y05FOYIHAI07@google.com>
Subject: Re: [PATCH v7 06/12] KVM: guest_memfd: add module param for disabling
 TLB flushing
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, Dave Hansen <dave.hansen@intel.com>, 
	"Roy, Patrick" <roypat@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"song@kernel.org" <song@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Cali, Marco" <xmarcalx@amazon.co.uk>, 
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>, "tabba@google.com" <tabba@google.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 30, 2025 at 4:05 PM UTC, Brendan Jackman wrote:
> On Thu Sep 25, 2025 at 6:27 PM UTC, Dave Hansen wrote:
>> On 9/24/25 08:22, Roy, Patrick wrote:
>>> Add an option to not perform TLB flushes after direct map manipulations.
>>
>> I'd really prefer this be left out for now. It's a massive can of worms.
>> Let's agree on something that works and has well-defined behavior before
>> we go breaking it on purpose.
>
> As David pointed out in the MM Alignment Session yesterday, I might be
> able to help here. In [0] I've proposed a way to break up the direct map
> by ASI's "sensitivity" concept, which is weaker than the "totally absent
> from the direct map" being proposed here, but it has kinda similar
> implementation challenges.
>
> Basically it introduces a thing called a "freetype" that extends the
> idea of migratetype. Like the existing idea of migratetype, it's used to
> physically group pages when allocating, and you can index free pages by
> it, i.e. each freetype gets its own freelist. But it can also encode
> other information than mobility (and the other stuff that's encoded in
> migratetype...).
>
> Could it make sense to use that logic to just have entire pageblocks
> that are absent from the direct map? Then when allocating memory for the
> guest_memfd we get it from one of those pageblocks. Then we only have to
> flush the TLB if there's no memory left in pageblocks of this freetype
> (so the allocator has to flip another pageblock over to the "no direct
> map" freetype, after removing it from the direct map).
>
> I haven't yet investigated this properly, I'll start doing that now.
> But I thought I'd immediately drop this note in case anyone can
> immediately see a reason why this doesn't work.

I spent some time poking around and I think there's only one issue here:
in this design the mapping/unmapping of the direct map happens while
allocating. But, it might need to allocate a pagetable to break down a
page.

In my ASI-specific presentation of that feature, I dodged this issue by
just requiring the whole ASI direct map to be set up at pageblock
granularity. This totally dodges the recursion issue since we just never
have to break down pages. (Actually, Dave Hansen suggested for the
initial implementation I simplify it by just doing all the ASI stuff at
4k, which achieves the same thing).

I guess we'd like to avoid globally fragmenting the whole direct map
just in case someone wants to use guest_memfd at some point? And, I
guess we could just instantaneously fragment it all at the instant that
someone wants to do that, but that's still a bit yucky.

If we just ignore this issue and try to allocate pagetables, it's
possible for a pathological physmap state to emerge where we get into
the allocator path that [un]maps a pageblock, but then need to allocate
a page to [un]map it, and that allocation in turn gets into the
[un]mapping path, and suddenly, turtles.

I think the simplest answer to that is to just fail the [un]map path if
we detect we're recursive, with something like a PF_MEMALLOC_* flag.
But this feels a bit yucky.

Other ideas might include: don't actually fragment the whole physmap,
but at least pre-allocate the pagetables down to pageblock granularity.
Or alternatively, this could point to an issue in the way I injected
[un]mapping into the allocator, and fixing that design flaw would solve
the problem.

I'll have to think about this some more on Monday but sharing my
thoughts now in case anyone has an idea already...

I've dumped the (untested) branch where I've adapted [0] for the
NO_DIRECT_MAP usecase here:

https://github.com/bjackman/linux/tree/demo-guest_memfd-physmap

> [0] https://lore.kernel.org/all/20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com/T/#t


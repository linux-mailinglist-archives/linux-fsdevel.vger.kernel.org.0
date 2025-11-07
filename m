Return-Path: <linux-fsdevel+bounces-67432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E53EC3FDC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20203AA398
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181BB32721A;
	Fri,  7 Nov 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpBHtU6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5203271F9
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517568; cv=none; b=CEW5aWty0xpRFHO6by/RCYbZr8G5LIGx7SKMIchdU6U1k3zVpjjHPrXL7GrYAHkbIKHMz9A12Ag3lzAcQO3mv22/e7VAy5YcCLlSVtLtfb/1esLU6ET80Q8eXeEw5BDHYqV1LOYYRW6IyQ7xTHSf1GIQnvsQxZLIi4RO5H4WDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517568; c=relaxed/simple;
	bh=Tfpbm92o9W7BVvnGiM2caH4qh7ZyE+P+DguJ0PvN6mQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G3xjhrhPDmHYj3QPJALc5Udio9iMxoUz0XriNrwEB23F5CCOSv3UzLYtVtZerIMsTEJ8iPHuRICkTFF7BoeFlqy/IL21xGirC/2L77CG6aDyZ1oR4Wx5+fuqgQckOxt45gGiT+WFUP4oHIa3oiNTqd5iyQNmyYEJTz+hoWNk2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpBHtU6H; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b5fcada9d24so76669766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 04:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762517565; x=1763122365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiMZz3p9r1cXUEtJOvXENsRsqsu1S4GTx2JzdMxXhCI=;
        b=tpBHtU6H+uXNawvpoCU6gmGnXVQWUKcfsKVxFE+D8QNj4HARSbp6TnAW6uvuj4qgb8
         Ep6t/ejz9fVp7xs12kzya9XyD+fL48Jsc0TA3Uf7VJUEMUb9sf0ChK/1XFEsVfINkdYk
         zPsgwUwryAKVbT0ly27gQYkH/kmjXN0DXEazIYsEjFTFtkMizU20NR2yHMLilOQiO4G5
         2QrFv625cl3ZQSIa1OIcFSPzk1+YbeXbrz2NQLQAFOn8sMMBITasCBJlzgTFHXMgD2c3
         GseWHjVlUX+pH0Ph1H8STTfMMp5FrZrI6eUcHQ+SORgQkwjsiSyHnhSY9AgYmT57gAxN
         xm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762517565; x=1763122365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiMZz3p9r1cXUEtJOvXENsRsqsu1S4GTx2JzdMxXhCI=;
        b=HUeOYuPcVeYsktwE0id0zeGcp2yQSnCBazReJ8njn4y/09tSyubmkWM3r6evdZk7KO
         er8k7d9J8rnib9KCQxNMWsr9m+O4kmM1x96Cbd8fSUBB9qwszaWzjvSNr2k5JfbVkbzO
         yLAVA2SuNZmf0GFAlGwBqJZmWegePUaVoVS1nfXmE60eJ6uwbieejCOxTPU/Jj+LI+LT
         5h3pBDROMvFMtmTsVM1ZRcFlVdz0+gOM7GHO2wEEs00fhliqp7V4LV/qYAVozE3bg7Qz
         j5b4+2YrwfExafHWEJx/w44UKWxHlw9XOc72pNJctjVfX53pAfWiP1fCfxtiIESxMyr7
         iU1g==
X-Forwarded-Encrypted: i=1; AJvYcCUOWFUmms43GMA9FQ0s/Ny9U2MigBppewFk9O1wW0Q4ZRw1PUVbaHgH8EPW9Tss3WHXsy4k8Z7lpX4Gz3gn@vger.kernel.org
X-Gm-Message-State: AOJu0YwXO77/wTmkS+LpLVTNjTk7XhmGQxnAbYF9qQDoSNFOjzRSOMvi
	L/fn+WNtgtk8roH80+/9itufRLFm5Ik0/JXyxRS1/YazNQgfDanoTg4K8nXaZ36YFvPQ9a6bdsg
	3Q+JOrpXgHLiEU8te5Q==
X-Google-Smtp-Source: AGHT+IFz1d7JwOnWSoe0fVf8qRe2tAmBflmhL4Mg+i45pACLer1ETGlr4r2lHbYGUH0n6LT169uz4zsABZFzda8=
X-Received: from ejdaz21.prod.google.com ([2002:a17:906:8f15:b0:b72:5aa5:2d0b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d16:b0:b6d:7e04:7a24 with SMTP id a640c23a62f3a-b72c0ac01aemr279299066b.36.1762517565061;
 Fri, 07 Nov 2025 04:12:45 -0800 (PST)
Date: Fri, 7 Nov 2025 12:12:43 +0000
In-Reply-To: <0f7186b3-16bd-44b7-a3fe-637af9d25dd3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <fe38b1a43364f72d1ce7a6217e53a33c9c0bb0c5.1762422915.git.lorenzo.stoakes@oracle.com>
 <yja2mhwa4bzatbthjjq5rolqlkfgcbmppic3caaiwi6jc63rbc@cims6rqnotvj>
 <043dcbdb-e069-46e7-8f79-8fdaf354fb44@lucifer.local> <aQ24HAAxYLhIvV5U@google.com>
 <0f7186b3-16bd-44b7-a3fe-637af9d25dd3@lucifer.local>
Message-ID: <aQ3iO40QYEM6Dxfs@google.com>
Subject: Re: [PATCH v2 1/5] mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jann Horn <jannh@google.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Fri, Nov 07, 2025 at 09:44:22AM +0000, Lorenzo Stoakes wrote:
> On Fri, Nov 07, 2025 at 09:13:00AM +0000, Alice Ryhl wrote:
> > On Thu, Nov 06, 2025 at 02:54:33PM +0000, Lorenzo Stoakes wrote:
> > > +cc Alice for rust stuff
> > >
> > > On Thu, Nov 06, 2025 at 02:27:56PM +0000, Pedro Falcato wrote:
> > > > On Thu, Nov 06, 2025 at 10:46:12AM +0000, Lorenzo Stoakes wrote:
> > > > >  /*
> > > > >   * vm_flags in vm_area_struct, see mm_types.h.
> > > > >   * When changing, update also include/trace/events/mmflags.h
> > > > > @@ -296,6 +298,7 @@ extern unsigned int kobjsize(const void *objp);
> > > > >  #define VM_UFFD_MISSING	0
> > > > >  #endif /* CONFIG_MMU */
> > > > >  #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> > > > > +#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
> > > >
> > > > Don't we also need an adjustment on the rust side for this BIT()? Like we
> > > > for f04aad36a07c ("mm/ksm: fix flag-dropping behavior in ksm_madvise").
> > >
> > > That's a bit unhelpful if rust can't cope with extremely basic assignments like
> > > that and we just have to know to add helpers :/
> > >
> > > We do BIT() stuff for e.g. VM_HIGH_ARCH_n, VM_UFFD_MINOR_BIT,
> > > VM_ALLOW_ANY_UNCACHED_BIT, VM_DROPPABLE_BIT and VM_SEALED_BIT too and no such
> > > helpers there, So not sure if this is required?
> > >
> > > Alice - why is it these 'non-trivial' defines were fine but VM_MERGEABLE was
> > > problematic? That seems strange.
> > >
> > > I see [0], so let me build rust here and see if it moans, if it moans I'll add
> > > it.
> > >
> > > [0]:https://lore.kernel.org/oe-kbuild-all/CANiq72kOhRdGtQe2UVYmDLdbw6VNkiMtdFzkQizsfQV0gLY1Hg@mail.gmail.com/
> >
> > When you use #define to declare a constant whose right-hand-side
> > contains a function-like macro such as BIT(), bindgen does not define a
> > Rust version of that constant. However, VM_MAYBE_GUARD is not referenced
> > in Rust anywhere, so that isn't a problem.
> >
> > It was a problem with VM_MERGEABLE because rust/kernel/mm/virt.rs
> > references it.
> >
> > Note that it's only the combination of #define and function-like macro
> > that triggers this condition. If the constant is defined using another
> > mechanism such as enum {}, then bindgen will generate the constant no
> > matter how complex the right-hand-side is. The problem is that bindgen
> > can't tell whether a #define is just a constant or not.
> 
> Thanks, I guess we can update as we go as rust needs. Or I can do a big update
> as part of my VMA flag series respin?

Whenever you think is a good time works for me.

I think it would be nice to move those constants so they use enum {}
instead of #define at some point.

Alice


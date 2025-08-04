Return-Path: <linux-fsdevel+bounces-56633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F9B1A00B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 12:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85CC3BC20A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443C4252904;
	Mon,  4 Aug 2025 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh2Gn0q0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4681D5CF2;
	Mon,  4 Aug 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304871; cv=none; b=b5VphjqpHvKTXGlnKOp68hfAGc+NPVccUyln8omoPCg3CzYpj8kAtrCASjhxsG+nIlLFYr+crIjZiTgzb4iZGWSWitu2RHlsba3CQUEcJ+RrFJKUlHe3+PZIdnRcV6+TUQPNhtlBd2FcKmF5Qfw6Pg6we2198TP7BbilWgeyp5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304871; c=relaxed/simple;
	bh=LLYmh07tODzNKrSqXaL0z3ysxtPy/JmLxTic6NiwVjE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov2B4Z+1XE7OwKefx/80lvOVxzdoz0RgshwJgXxU4+HcVH4yh+C9ZFPjK9ar1tJloWMBdZIsbuMEAqg+30p0cI8d8KsEN1ejUQztOX+wxsmXhDyoBbNI7qI79QdZGwA+FwK7Radx7o/FK/VQQHy2AYpDR2UXsuztWAmGuyh7iwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh2Gn0q0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-33211f7f06eso35695241fa.2;
        Mon, 04 Aug 2025 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754304868; x=1754909668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4RxvHMamXD48DKrjLVxOGxx8Xo0bomZZqlvqy6+mMo=;
        b=Uh2Gn0q05+FYkWk0VZulC4Q/x7+Yq8YKAgFG8Zgy0lXIKYjRxrUY01lGBijYFcWzI9
         czAGM84crafWTALrr2y7nFIqOB8c/KLZRLDMPxzE9Ip8JouprTpkzDfmvytNaKwhNlSy
         8rmfj5d279xMnRcDO/8XvjeC72IWIRxrE3JqhezxFdnPlBcu4zDWuwQ9xtFKMVnlHzdw
         CtdPeXs63CMRXYKQfIeAjPhZswnmsSzE7czti+pHuGuvVkbxKHH2oL08cYUy4yPjfP/+
         DFoXeUr7wWjwGgNAsY0zInJFA0o+0yXia5SKyKub2ckNpNc+L/aSH6fDntuTS+AOZ9zc
         xt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754304868; x=1754909668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4RxvHMamXD48DKrjLVxOGxx8Xo0bomZZqlvqy6+mMo=;
        b=L2k0w2eopkCw+wo7lSvRcthu+P6ngN0GBh3oE8S99h7ARNfuNwcJ3sqaTSyvTBj8Ob
         RTSXMzCFRRW2CIgn4FDiu3z2jxl8WNnd0fQc0LFxy5UoxCq7EvsihPil25VUu0CRtASJ
         62jUrqE+AJYaIkd6EQ+QqwhBHUI+mYL59VhAMFuiBFvPp+k6fxDA5i7RHGObo59NHIUs
         SC0liQsrwFN2jfN8OlF9NAehnRMRtktr0GMMkok+yymTk5Xh8WlKlMf+PnrLYfQRFy9s
         Au/+ijwa3sXmZQtHcB9r0K94mTtQlI9y0fXRkO0DrRVQR+ijX+dMq4/fDNqPg6q42BUW
         xLDw==
X-Forwarded-Encrypted: i=1; AJvYcCUNfsY32aenR5TTYjLopQxJcJW0YI1xBB15q1f/KgaN0jxS+wet7xInMsnHq3fJNe2g0zRHDb9pHNzyXGHDLg==@vger.kernel.org, AJvYcCV/LudbpFr3ZPYbKPc3NK9XAPQg0rMwtpxN0Xty5Ekj2F1hmmn76FzkZq7PEUxB1C97ixU=@vger.kernel.org, AJvYcCVnN3c06z5ESZ1w1IyzYUF3altTy9tMBWdDjhgwvwHEYFYEeSxVI3DxnZVmWdG4ScY6m3ok3flBauiIrBMf@vger.kernel.org, AJvYcCWpsnTL3WvYW42tMrSExp3+NyfUBc6M0ldR1s7ZPBt74xruaoSI55CEUpkcyk5YF61O5Cw73UnMfoPOOw==@vger.kernel.org, AJvYcCXGCNjxKLGpTSlJtKBHuDRqI6JhZ66Ka9+FjLr4fpklNr9f+Www1vShUoVavwQWGB+SgtwBuUc2/JzksrmzBfsvV/4n@vger.kernel.org, AJvYcCXin6r0nuOsGKAL5x+yojTjbWF1YZjXeAY0ylQCgisn9tOqxyGbdNobIuDq93XJM8/l7uN90yKk/yYs@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2En5uTOoAn20N13788kkpolieOSeTRTfBgVEGUewKM2qeSwM
	8uxeiVJ4+KMxNhIvlvpil10gu80jPi1Hvwm9tx55Pu/2bk0w0iptlU0A
X-Gm-Gg: ASbGnctajp32N59rDl1u87AMGHhdS7VjKpeOfg6gYAkEHPsB6sAmXkESHOoaYNuibS0
	lozIQfUJel+4HJA3JC/ruIT2LLwF1EyvefBW1TVVPGNC4dv9v2MdeagVhSCbZ2kxi6TF3WwbFMe
	YBMTdGTBMGK3SzgfzwA4W4fiYQDRi3c/Uk4cCya9Ep4Z2vK8IlMVHbysYVH6qHwLrCG16t3N63M
	EwlT8h0QoxNEsFfn9/RmFWrzjANfWwyV7uaeJysIG2VHjmf5g7oCIywY8Ao3GKWP19r4dVBV+8t
	9iMLuARGEXs+h2EgkrgUrFhzVMAfweC5fXHNn8H79DEjQs/QtRm7IDFgpzFzRzML5qm6O6/H4Uo
	2CEb5YbUZSHOAjx8FhaGn/4bhEc365o3b3Ouz9X58xwgVk7bDUW84ha/tfCy4
X-Google-Smtp-Source: AGHT+IGJZZFcFy8qBb/9BVJvSpxogtzfM17wxVB5B1bfSxKSrolhCiqzChAu468YcmIMkpSbHFvpbA==
X-Received: by 2002:a05:651c:20ce:20b0:332:4a77:ad9f with SMTP id 38308e7fff4ca-3325677af91mr12521651fa.24.1754304867614;
        Mon, 04 Aug 2025 03:54:27 -0700 (PDT)
Received: from pc636 (host-95-203-22-207.mobileonline.telia.com. [95.203.22.207])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238271bdfsm16396311fa.6.2025.08.04.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:54:26 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 4 Aug 2025 12:54:21 +0200
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Harry Yoo <harry.yoo@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: update core kernel code to use vm_flags_t
 consistently
Message-ID: <aJCRXVP-ZFEPtl1Y@pc636>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
 <aIgSpAnU8EaIcqd9@hyeyoo>
 <73764aaa-2186-4c8e-8523-55705018d842@lucifer.local>
 <aIkVRTouPqhcxOes@pc636>
 <69860c97-8a76-4ce5-b1d6-9d7c8370d9cd@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69860c97-8a76-4ce5-b1d6-9d7c8370d9cd@lucifer.local>

Hello, Lorenzo!

> So sorry Ulad, I meant to get back to you on this sooner!
> 
> On Tue, Jul 29, 2025 at 08:39:01PM +0200, Uladzislau Rezki wrote:
> > On Tue, Jul 29, 2025 at 06:25:39AM +0100, Lorenzo Stoakes wrote:
> > > Andrew - FYI there's nothing to worry about here, the type remains
> > > precisely the same, and I'll send a patch to fix this trivial issue so when
> > > later this type changes vmalloc will be uaffected.
> > >
> > > On Tue, Jul 29, 2025 at 09:15:51AM +0900, Harry Yoo wrote:
> > > > [Adding Uladzislau to Cc]
> > >
> > > Ulad - could we PLEASE get rid of 'vm_flags' in vmalloc? It's the precise
> > > same name and (currently) type as vma->vm_flags and is already the source
> > > of confusion.
> > >
> > You mean all "vm_flags" variable names? "vm_struct" has flags as a
> > member. So you want:
> >
> > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
> > 29:                          pgprot_t pgprot, unsigned long vm_flags)
> > 39:             vm_flags |= VM_DEFER_KMEMLEAK;
> > 41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
> > 45:                              pgprot, vm_flags, NUMA_NO_NODE,
> > 51:                                      pgprot, vm_flags, NUMA_NO_NODE,
> > 85:                          pgprot_t pgprot, unsigned long vm_flags)
> > 259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> > 266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> > 376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
> > 385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
> > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/vmalloc.c
> > 3853: * @vm_flags:                additional vm area flags (e.g. %VM_NO_GUARD)
> > 3875:                   pgprot_t prot, unsigned long vm_flags, int node,
> > 3894:   if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> > 3912:                             VM_UNINITIALIZED | vm_flags, start, end, node,
> > 3977:   if (!(vm_flags & VM_DEFER_KMEMLEAK))
> > 4621:   vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
> > 29:                          pgprot_t pgprot, unsigned long vm_flags)
> > 39:             vm_flags |= VM_DEFER_KMEMLEAK;
> > 41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
> > 45:                              pgprot, vm_flags, NUMA_NO_NODE,
> > 51:                                      pgprot, vm_flags, NUMA_NO_NODE,
> > 85:                          pgprot_t pgprot, unsigned long vm_flags)
> > 259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> > 266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> > 376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
> > 385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
> > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags ./include/linux/vmalloc.h
> > 172:                    pgprot_t prot, unsigned long vm_flags, int node,
> > urezki@pc638:~/data/backup/coding/linux-not-broken.git$
> >
> > to rename all those "vm_flags" to something, for example, like "flags"?
> 
> Yeah, sorry I know it's a churny pain, but I think it's such a silly source
> of confusion _in general_, not only this series where I made a mistake (of
> course entirely my fault but certainly more understandable given the
> naming), but in the past I've certainly sat there thinking 'hmmm wait' :)
> 
> Really I think we should rename 'vm_struct' too, but if that causes _too
> much_ churn fair enough.
> 
> I think even though it's long-winded, 'vmalloc_flags' would be good, both
> in fields and local params as it makes things very very clear.
>
> 
> Equally 'vm_struct' -> 'vmalloc_struct' would be a good change.
> 
Uh.. This could be a pain :) I will have a look and see what we can do.

Thanks!

--
Uladzislau Rezki


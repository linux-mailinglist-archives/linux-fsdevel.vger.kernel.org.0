Return-Path: <linux-fsdevel+bounces-56730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C8B1B14B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 11:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F943A1A73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA6265CCD;
	Tue,  5 Aug 2025 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaqdWXeH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47685191F92;
	Tue,  5 Aug 2025 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386700; cv=none; b=s6Nd7jQCm+XROs5yCpCHsjR4KEuBAS93WPkYUxiULR/GDKp/z8d9QU1yC2vLGHeBCW6ApO89Hjm8uxZ7b3voqnx3IkvWcVgTBqVQT4dKXv0Q/E7/OvAWfExj2Wy7wVecZAbG4W+DklBNJt4SgJ2wB0CQpC/3q1sGbBZfXISUeaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386700; c=relaxed/simple;
	bh=PtcIziWKmeZojE8NbukEIlxT+NCLvvfcRfGscENjViM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P83KCJ6DGd0veSH4gg3xDDVDsE9VQbxkof+8vOwIBuitl1glNCKYRe5xaIIakFnMjWeow8NOexqoMZrTJRvc6bFjR4h0UPu+zwwYKt2x11crgzunvA6HhDZnSWbqQBij/10iLECUpXGjv2GCNgGPbFifRPWbKGpZfLRzTv+rnE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaqdWXeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73A3C4CEF7;
	Tue,  5 Aug 2025 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754386699;
	bh=PtcIziWKmeZojE8NbukEIlxT+NCLvvfcRfGscENjViM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaqdWXeHFq4oltQn9PTlA505X/oL+/hHqNtgIoY7zKJ2rAIIyFMHaM+0OG/yh2pw4
	 a4OPg6vNpHqwYzZOYWH9z2eFj0o9qdjphfKwQATxpDET/tUKgH15v5CCmaccGtiziI
	 K47HqBXpuuIazHWs7f7nOBdJzkPcC6o7Uz2XE0NjVLokbL/vEdh4tvhC3lSlpz6wIJ
	 cRJvBI/3D77VRI3Nw6Ov+py/jFgFc5Ni8OH6Dnx4eGST8kP5vZjYp9Nb+FQNxwUhWq
	 2m2r86L7YkwtCZGME114r4pdSCFeteEHhrAOdiqvbKwV054IIClCJwCyv020K+cNSI
	 X5cmccT7jkP9Q==
Date: Tue, 5 Aug 2025 12:37:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
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
Message-ID: <aJHQ9XCLtibFjt93@kernel.org>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
 <aIgSpAnU8EaIcqd9@hyeyoo>
 <73764aaa-2186-4c8e-8523-55705018d842@lucifer.local>
 <aIkVRTouPqhcxOes@pc636>
 <69860c97-8a76-4ce5-b1d6-9d7c8370d9cd@lucifer.local>
 <aJCRXVP-ZFEPtl1Y@pc636>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJCRXVP-ZFEPtl1Y@pc636>

On Mon, Aug 04, 2025 at 12:54:21PM +0200, Uladzislau Rezki wrote:
> Hello, Lorenzo!
> 
> > So sorry Ulad, I meant to get back to you on this sooner!
> > 
> > On Tue, Jul 29, 2025 at 08:39:01PM +0200, Uladzislau Rezki wrote:
> > > On Tue, Jul 29, 2025 at 06:25:39AM +0100, Lorenzo Stoakes wrote:
> > > > Andrew - FYI there's nothing to worry about here, the type remains
> > > > precisely the same, and I'll send a patch to fix this trivial issue so when
> > > > later this type changes vmalloc will be uaffected.
> > > >
> > > > On Tue, Jul 29, 2025 at 09:15:51AM +0900, Harry Yoo wrote:
> > > > > [Adding Uladzislau to Cc]
> > > >
> > > > Ulad - could we PLEASE get rid of 'vm_flags' in vmalloc? It's the precise
> > > > same name and (currently) type as vma->vm_flags and is already the source
> > > > of confusion.
> > > >
> > > You mean all "vm_flags" variable names? "vm_struct" has flags as a
> > > member. So you want:
> > >
> > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
> > > 29:                          pgprot_t pgprot, unsigned long vm_flags)
> > > 39:             vm_flags |= VM_DEFER_KMEMLEAK;
> > > 41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
> > > 45:                              pgprot, vm_flags, NUMA_NO_NODE,
> > > 51:                                      pgprot, vm_flags, NUMA_NO_NODE,
> > > 85:                          pgprot_t pgprot, unsigned long vm_flags)
> > > 259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> > > 266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> > > 376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
> > > 385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
> > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/vmalloc.c
> > > 3853: * @vm_flags:                additional vm area flags (e.g. %VM_NO_GUARD)
> > > 3875:                   pgprot_t prot, unsigned long vm_flags, int node,
> > > 3894:   if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> > > 3912:                             VM_UNINITIALIZED | vm_flags, start, end, node,
> > > 3977:   if (!(vm_flags & VM_DEFER_KMEMLEAK))
> > > 4621:   vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
> > > 29:                          pgprot_t pgprot, unsigned long vm_flags)
> > > 39:             vm_flags |= VM_DEFER_KMEMLEAK;
> > > 41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
> > > 45:                              pgprot, vm_flags, NUMA_NO_NODE,
> > > 51:                                      pgprot, vm_flags, NUMA_NO_NODE,
> > > 85:                          pgprot_t pgprot, unsigned long vm_flags)
> > > 259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> > > 266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> > > 376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
> > > 385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
> > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags ./include/linux/vmalloc.h
> > > 172:                    pgprot_t prot, unsigned long vm_flags, int node,
> > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$
> > >
> > > to rename all those "vm_flags" to something, for example, like "flags"?
> > 
> > Yeah, sorry I know it's a churny pain, but I think it's such a silly source
> > of confusion _in general_, not only this series where I made a mistake (of
> > course entirely my fault but certainly more understandable given the
> > naming), but in the past I've certainly sat there thinking 'hmmm wait' :)
> > 
> > Really I think we should rename 'vm_struct' too, but if that causes _too
> > much_ churn fair enough.

Well, it's not that terrible :)

~/git/linux$ git grep -w vm_struct | wc -l
173

> > I think even though it's long-winded, 'vmalloc_flags' would be good, both
> > in fields and local params as it makes things very very clear.
> > 
> > Equally 'vm_struct' -> 'vmalloc_struct' would be a good change.

Do we really need the _struct suffix?
How about vmalloc_area?

It also seems that struct vmap_area can be made private to mm/.

> Uh.. This could be a pain :) I will have a look and see what we can do.
> 
> Thanks!
> 
> --
> Uladzislau Rezki

-- 
Sincerely yours,
Mike.


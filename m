Return-Path: <linux-fsdevel+bounces-56777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80133B1B82F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DE2168B71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED4627F015;
	Tue,  5 Aug 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zu+U3pL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F61C8603;
	Tue,  5 Aug 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410445; cv=none; b=sG45V+GdoMCFbtHP7VEmUL6bBUdZbUd8hiDEKg74MKdZBpnjaKs4yu4uwGYiR6Oki7jRfXlLmomHtb53k3HabVuLHE1n1g+c/f9M0z2AziGhIYzH45Q1x7ze7HXsQ/AQg/4CbepgcYz9E6DuE71W0sZqtyuzHlZTzFq8/phv8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410445; c=relaxed/simple;
	bh=BglbfbCfxjDdNAl+FJxNAK3U0aRdh/ewx/iXRTko+dM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCmNbeoNjxCiJOkQpA5AgctmWxrwYxOk64myWn6QfJKVFwLD9eZPsterRDrBgUAlXvak5oXqwn8pjfSS4/PZlT0jFZsr7WcS4ipaxi4Gn6RXxmjPGjbdu8tB+CBF96xZJ8joZ+Q+aRtuJWOa+31mDqWadGk6qdXVOy0PucI5B+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zu+U3pL5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-332631e47afso714441fa.0;
        Tue, 05 Aug 2025 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410442; x=1755015242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ut5lsjSSswYnbLzk6rrdmu5+CeAKFhijQRi1rB1wfMg=;
        b=Zu+U3pL5o4ZPJwIdkXISpU2dyfPB0+TNZSjkYcKaYSD+SRRfTxkyiY1CToGY5wFqXg
         d8melksPoN+JtITTK/3buDk8xEYbfYAarJDpRVujvYiOcWyWF7oQh2Bih2TJHc50/B2G
         9ZSAO+oT9l+ky/3GyCE1N/l6yabchtlYwVZ+jVHSjdVj6iebKyEv27RnIb7aN9pPx0JD
         m4TSkoDO2Yc6tLTV92FnvVCzzvf4ITl6fFll+GlPKPIj/SaRddi5H5EkcddCdZcWoTAi
         RwT2OhbFiB8+sd9j9pLdRESRxpfojA4PvSkmWNZIRK9A5+KcBdYgxbVvRXdnnlCEuZB6
         7ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410442; x=1755015242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut5lsjSSswYnbLzk6rrdmu5+CeAKFhijQRi1rB1wfMg=;
        b=wx79USt3Ijrv7F9dJ5zPWyZw9psisLB0mYeorSbrDyQjqfUBf8xXKgZWmCy9+bpmEI
         NsOQSPKcZhmj5okJHTHaeXJrCjt0+0kEDXMSSCqFF4ypECrAjg9Mqa+uoy6XQW8jMA6Z
         HhOYGAXrHy+bCSq0JJESfwr/muam04OZYoZLFL4Mw3/dUD+hzWy5Mz70SPM/lGsPlqGR
         FW9wV55/f5JWjawM1SacamRoVoYwv7sX5bhAWUq4WGl1su2Q/HM2Ix5r+roprpqF1sPH
         XBRQgUBk5WMsQ6kaxNXK1ylwKYXYSl5+uX46312Actj1UgIG67sg/BcVmq97aabj5nnW
         Y96Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBXXl7Ln8ePOt/LelC/47AUjsVXvr3aPHOVL7QwGqVc5pFYT1j1Z2e1MNh3RiYjrnwUBQzS243SljyeA==@vger.kernel.org, AJvYcCUYCQuoHFFsYcLtOpmBwSDPF0KAghyxY5nF8FAvFG4Q+VvV2lijReZePpr67eT/bw/AFL/CTrEMmFo/KilbGE0D5wSK@vger.kernel.org, AJvYcCUa0UAeg0sZyqKo/pYjy0MGDl3e7b/NsFK1EKVj+A2xR4u5QXE9yYMF+ogf3tuqwRaXeCyw8igidhx7IYy3@vger.kernel.org, AJvYcCVRzqnQEWpS4yisO12QA03J8rA0KSLDSkQO9l6MXGLXU1kz2EuLKVXQjReyetwSbyw+eB1rw3Mmqi4WJIUyPg==@vger.kernel.org, AJvYcCVjEelcX7AjVqrAjOGe/iWWj+BaB4QwssPJxvQQRTSUxlrifa0jfXjaHVmeoKISzeZMxgcGPS4E2Om8@vger.kernel.org, AJvYcCWKdVjmu7PtpdRJn0EnQxgGH/0ush9kKfGE1O6tpN/2LAPHeGQ6MMxHWmCHE7vu6cioOgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgVvFVN1d7cyE2qfbqHEjKPXhjt7TIYRSMIjSxMUH+zl6P/8El
	PC34RCwbFvWQEtOmGfQZuUUdqoV9xsgEsXPydgi5zNJ0+eAJ45Zjc7N8
X-Gm-Gg: ASbGncv2m1NdzzRQhE1BgT7wneFjtgaQUh42bE1MXtBKurH6VPUQM3n7S/FFB7eujIL
	80Sejdzh4+vE5PRMl3xJVPUWnfk8vKDcXphHC3zUk0g4FtZIcnpYCB9Hzz5XfaiLWosaEnV0fIn
	/s/gDY+7JkzAQXU6scowMADMhEJPRb+9ZGRGtnETnNmwW5nyQOoNCDCap9+RBTO1KT90DejATDa
	RZBXMxPEA2BqPI+TTnAEY6w8WiF7ngq+154gH+UZncedd4YGQnFPS796Fl/g3sJX5rLsaOLlBBw
	JB9VsbWJQaM9wjqYVQ0l62+8xq1jV0UK5JDGiJcmslAc5GtEReC9yiDUOGbJep4F20AZKrEDbyg
	lrlIOfVOliLyfdhnOD8yMSnqzpAQU0YP0g+rLanYoASb9qPS1XQ==
X-Google-Smtp-Source: AGHT+IH0xPAx9h/e+86wx2UChAIDs8RS46jNjVMEpxxiiDlgZAALsSVVnEbgPp+pN/RR7dfa5MNCmA==
X-Received: by 2002:a05:651c:b0f:b0:332:341d:9531 with SMTP id 38308e7fff4ca-3327b9157d5mr10915411fa.12.1754410441379;
        Tue, 05 Aug 2025 09:14:01 -0700 (PDT)
Received: from pc636 (host-95-203-18-142.mobileonline.telia.com. [95.203.18.142])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272ff7sm20616811fa.7.2025.08.05.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:14:00 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 5 Aug 2025 18:13:56 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Message-ID: <aJItxJNfn8B2JBbn@pc636>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
 <aIgSpAnU8EaIcqd9@hyeyoo>
 <73764aaa-2186-4c8e-8523-55705018d842@lucifer.local>
 <aIkVRTouPqhcxOes@pc636>
 <69860c97-8a76-4ce5-b1d6-9d7c8370d9cd@lucifer.local>
 <aJCRXVP-ZFEPtl1Y@pc636>
 <aJHQ9XCLtibFjt93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJHQ9XCLtibFjt93@kernel.org>

On Tue, Aug 05, 2025 at 12:37:57PM +0300, Mike Rapoport wrote:
> On Mon, Aug 04, 2025 at 12:54:21PM +0200, Uladzislau Rezki wrote:
> > Hello, Lorenzo!
> > 
> > > So sorry Ulad, I meant to get back to you on this sooner!
> > > 
> > > On Tue, Jul 29, 2025 at 08:39:01PM +0200, Uladzislau Rezki wrote:
> > > > On Tue, Jul 29, 2025 at 06:25:39AM +0100, Lorenzo Stoakes wrote:
> > > > > Andrew - FYI there's nothing to worry about here, the type remains
> > > > > precisely the same, and I'll send a patch to fix this trivial issue so when
> > > > > later this type changes vmalloc will be uaffected.
> > > > >
> > > > > On Tue, Jul 29, 2025 at 09:15:51AM +0900, Harry Yoo wrote:
> > > > > > [Adding Uladzislau to Cc]
> > > > >
> > > > > Ulad - could we PLEASE get rid of 'vm_flags' in vmalloc? It's the precise
> > > > > same name and (currently) type as vma->vm_flags and is already the source
> > > > > of confusion.
> > > > >
> > > > You mean all "vm_flags" variable names? "vm_struct" has flags as a
> > > > member. So you want:
> > > >
> > > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
> > > > 29:                          pgprot_t pgprot, unsigned long vm_flags)
> > > > 39:             vm_flags |= VM_DEFER_KMEMLEAK;
> > > > 41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
> > > > 45:                              pgprot, vm_flags, NUMA_NO_NODE,
> > > > 51:                                      pgprot, vm_flags, NUMA_NO_NODE,
> > > > 85:                          pgprot_t pgprot, unsigned long vm_flags)
> > > > 259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> > > > 266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> > > > 376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
> > > > 385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
> > > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/vmalloc.c
> > > > 3853: * @vm_flags:                additional vm area flags (e.g. %VM_NO_GUARD)
> > > > 3875:                   pgprot_t prot, unsigned long vm_flags, int node,
> > > > 3894:   if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> > > > 3912:                             VM_UNINITIALIZED | vm_flags, start, end, node,
> > > > 3977:   if (!(vm_flags & VM_DEFER_KMEMLEAK))
> > > > 4621:   vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> > > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
> > > > 29:                          pgprot_t pgprot, unsigned long vm_flags)
> > > > 39:             vm_flags |= VM_DEFER_KMEMLEAK;
> > > > 41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
> > > > 45:                              pgprot, vm_flags, NUMA_NO_NODE,
> > > > 51:                                      pgprot, vm_flags, NUMA_NO_NODE,
> > > > 85:                          pgprot_t pgprot, unsigned long vm_flags)
> > > > 259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> > > > 266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> > > > 376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
> > > > 385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
> > > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags ./include/linux/vmalloc.h
> > > > 172:                    pgprot_t prot, unsigned long vm_flags, int node,
> > > > urezki@pc638:~/data/backup/coding/linux-not-broken.git$
> > > >
> > > > to rename all those "vm_flags" to something, for example, like "flags"?
> > > 
> > > Yeah, sorry I know it's a churny pain, but I think it's such a silly source
> > > of confusion _in general_, not only this series where I made a mistake (of
> > > course entirely my fault but certainly more understandable given the
> > > naming), but in the past I've certainly sat there thinking 'hmmm wait' :)
> > > 
> > > Really I think we should rename 'vm_struct' too, but if that causes _too
> > > much_ churn fair enough.
> 
> Well, it's not that terrible :)
> 
> ~/git/linux$ git grep -w vm_struct | wc -l
> 173
> 
Indeed :)


> > > I think even though it's long-winded, 'vmalloc_flags' would be good, both
> > > in fields and local params as it makes things very very clear.
> > > 
> > > Equally 'vm_struct' -> 'vmalloc_struct' would be a good change.
> 
> Do we really need the _struct suffix?
> How about vmalloc_area?
> 
I think, we should not use vmalloc_ prefix here, because vmalloc
operates within its own range: VMALLOC_START:VMALLOC_END, therefore
it might be confusing also.

others can use another regions. vmap_mapping?

>
> It also seems that struct vmap_area can be made private to mm/.
> 
I agree. Also it can be even moved under vmalloc.c. There is only one
user which needs it globally, it is usercopy.c. It uses find_vmap_area()
which is wrong. See:

<snip>
	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
		struct vmap_area *area = find_vmap_area(addr);

		if (!area)
			usercopy_abort("vmalloc", "no area", to_user, 0, n);

		if (n > area->va_end - addr) {
			offset = addr - area->va_start;
			usercopy_abort("vmalloc", NULL, to_user, offset, n);
		}
		return;
	}
<snip>

we can add a function which just assign va_start, va_end as input
parameters and use them in the usercopy.c. 

Thanks!

--
Uladzislau Rezki


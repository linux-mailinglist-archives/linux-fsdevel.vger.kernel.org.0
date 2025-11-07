Return-Path: <linux-fsdevel+bounces-67418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA27C3F1C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 10:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17BD34ED41B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F37318151;
	Fri,  7 Nov 2025 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+8kokxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9418318141
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506785; cv=none; b=o6lrwZLiOR8apougHF6/Ys0usPRzgxs4p6L98v4Nyk/Ivpu+q4/NJQAoFfL/zeP9zNHZj18BqtaHgGmymvFxXE6J3K7xjtHCl7pyNHcTs83+TT1ssHF/Ts09TnKSFigJdl/A6nB/4Nbf6q8bFLDs6rOvtZZfjyzEQrs8TbuwwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506785; c=relaxed/simple;
	bh=+R07ubDuBhff2ujrABNBpUwsrjtH0A9CyxuTQ0jmk/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FGro05gIxqvJ8Fj4LqKwnOsHllxNTAiYY83iCuUHVbMHXawL9QPMe3SLpCLPtO9+lHw0b21Lgn9ZGYi/mTBCBrdUC90lKWqOPgU5wA2jLSO+jZ9/A7qdWIDgqU71YV1PnGI543p3NCqeY2gJ3kH2NWHnWyVA+zcD9qlrOqqGx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+8kokxi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47769a0a13bso5152225e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 01:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762506781; x=1763111581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6hr5KyHBQ4i3KpvRUNSLwzvnbvgDhJcoWyAtNcMbQg=;
        b=o+8kokxiq8sV7eembw85qpl/iqp7HCScn0Plv9OSCqxXkMrZYV5YYb3pHXCsGn/VwQ
         DbRpL6BeW6hgXoFdsJJSgzf6HRL9m3pyCfDp+zJNQbfbp0KsRAsz/sxoHzXCDZ55L0BL
         xigvoBUKNvmYrRNu3QOGd6GzT/GB/1XrdjgE3nKBIhyVfJlm+DZqsn1/SxMEw83Sz8TD
         o4X8EBshU6VrvdtW2TBXu9FAeNR8qc4sJXcAc+zFGKB/eYpXo6ac3uLqCO/zWmTZ+pQ5
         hGUZsyjSoSeehI8uXQ7jYGwplcBaxCzxjYEt4SBAfTNUGjx2PE40cTpZPH+quhq0Wx6L
         +9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762506781; x=1763111581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6hr5KyHBQ4i3KpvRUNSLwzvnbvgDhJcoWyAtNcMbQg=;
        b=Nu/bIP7mx1+jyiUuwlb+wBHfDVsMZpyedTSatORUdxM1qK/mi72CVVzZSLlVrXDbzj
         m3mEGD9c+w07mNQdh4GX0vQkr6f76+9np/kwFeSROv8jzN2rzrsisuWJLUe6BQcuqghE
         agoKXqWda1oieo/ed4geuMYJF9m797nT5+RJ82QfQpqst5zN7qR3hENIvZ62y86eA8Xi
         nrfnO+KBoSEr2RWi0KmLN5/8vSMqOdhHnPj8gxPprtcWSip6Xq9F1/ZJ3Wbo3ZW7EP06
         agr6GtlOyG2ZrZrMCK7t8lCXd1hFrfeIjB6GxYvxUkPfelgTAJ2dhMoJb82UpscaU2S9
         dGdw==
X-Forwarded-Encrypted: i=1; AJvYcCUvNauT5YOH9AqAD81fcwU5nClPfjoN80Qb0TZqP9siALfNNAeNIf40wrQ6xH7FLRPNFx414fJr1i4GE+GJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/weYYsvQ8JzZFEG5CF4pskYw5wlAkYai3/7+mQNKa0qmuhCPF
	YDFtHssVXolTeOt8qoOlwxRS8QwVA13ZdFK7KG5u7Zr55d5YtYhs1j7KGsspT0Sv6LeQC5YcjbT
	xmbN3/0q/syaGVUkToA==
X-Google-Smtp-Source: AGHT+IHUZEz+bT2nDPlYtV/C/QNEpv2U8khomuJk8Z2Iy1Z4Tlg4ge5tYPMjbGtCECv4gTvvdLMJU3QqC9ERcYo=
X-Received: from wmcu6.prod.google.com ([2002:a7b:c046:0:b0:476:4b14:2edf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4592:b0:477:3e07:217a with SMTP id 5b1f17b1804b1-4776bcc9c7emr20623525e9.36.1762506781268;
 Fri, 07 Nov 2025 01:13:01 -0800 (PST)
Date: Fri, 7 Nov 2025 09:13:00 +0000
In-Reply-To: <043dcbdb-e069-46e7-8f79-8fdaf354fb44@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <fe38b1a43364f72d1ce7a6217e53a33c9c0bb0c5.1762422915.git.lorenzo.stoakes@oracle.com>
 <yja2mhwa4bzatbthjjq5rolqlkfgcbmppic3caaiwi6jc63rbc@cims6rqnotvj> <043dcbdb-e069-46e7-8f79-8fdaf354fb44@lucifer.local>
Message-ID: <aQ24HAAxYLhIvV5U@google.com>
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

On Thu, Nov 06, 2025 at 02:54:33PM +0000, Lorenzo Stoakes wrote:
> +cc Alice for rust stuff
> 
> On Thu, Nov 06, 2025 at 02:27:56PM +0000, Pedro Falcato wrote:
> > On Thu, Nov 06, 2025 at 10:46:12AM +0000, Lorenzo Stoakes wrote:
> > > Currently, if a user needs to determine if guard regions are present in a
> > > range, they have to scan all VMAs (or have knowledge of which ones might
> > > have guard regions).
> > >
> > > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> > > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> > > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> > > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> > > operation at a virtual address level.
> > >
> > > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> > > that guard regions exist in ranges.
> > >
> > > This patch remedies the situation by establishing a new VMA flag,
> > > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> > > uncertain because we cannot reasonably determine whether a
> > > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> > > additionally VMAs may change across merge/split).
> > >
> > > We utilise 0x800 for this flag which makes it available to 32-bit
> > > architectures also, a flag that was previously used by VM_DENYWRITE, which
> > > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> > > bee reused yet.
> > >
> > > We also update the smaps logic and documentation to identify these VMAs.
> > >
> > > Another major use of this functionality is that we can use it to identify
> > > that we ought to copy page tables on fork.
> > >
> > > We do not actually implement usage of this flag in mm/madvise.c yet as we
> > > need to allow some VMA flags to be applied atomically under mmap/VMA read
> > > lock in order to avoid the need to acquire a write lock for this purpose.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  Documentation/filesystems/proc.rst | 1 +
> > >  fs/proc/task_mmu.c                 | 1 +
> > >  include/linux/mm.h                 | 3 +++
> > >  include/trace/events/mmflags.h     | 1 +
> > >  mm/memory.c                        | 4 ++++
> > >  tools/testing/vma/vma_internal.h   | 3 +++
> > >  6 files changed, 13 insertions(+)
> > >
> > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > index 0b86a8022fa1..b8a423ca590a 100644
> > > --- a/Documentation/filesystems/proc.rst
> > > +++ b/Documentation/filesystems/proc.rst
> > > @@ -591,6 +591,7 @@ encoded manner. The codes are the following:
> > >      sl    sealed
> > >      lf    lock on fault pages
> > >      dp    always lazily freeable mapping
> > > +    gu    maybe contains guard regions (if not set, definitely doesn't)
> > >      ==    =======================================
> >
> > The nittiest
> > of nits:     =============================================================
> 
> Sigh :) OK will fix.
> 
> >
> >
> > >
> > >  Note that there is no guarantee that every flag and associated mnemonic will
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 8a9894aefbca..a420dcf9ffbb 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -1147,6 +1147,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> > >  		[ilog2(VM_MAYSHARE)]	= "ms",
> > >  		[ilog2(VM_GROWSDOWN)]	= "gd",
> > >  		[ilog2(VM_PFNMAP)]	= "pf",
> > > +		[ilog2(VM_MAYBE_GUARD)]	= "gu",
> > >  		[ilog2(VM_LOCKED)]	= "lo",
> > >  		[ilog2(VM_IO)]		= "io",
> > >  		[ilog2(VM_SEQ_READ)]	= "sr",
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 6e5ca5287e21..2a5516bff75a 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -271,6 +271,8 @@ extern struct rw_semaphore nommu_region_sem;
> > >  extern unsigned int kobjsize(const void *objp);
> > >  #endif
> > >
> > > +#define VM_MAYBE_GUARD_BIT 11
> > > +
> > >  /*
> > >   * vm_flags in vm_area_struct, see mm_types.h.
> > >   * When changing, update also include/trace/events/mmflags.h
> > > @@ -296,6 +298,7 @@ extern unsigned int kobjsize(const void *objp);
> > >  #define VM_UFFD_MISSING	0
> > >  #endif /* CONFIG_MMU */
> > >  #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> > > +#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
> >
> > Don't we also need an adjustment on the rust side for this BIT()? Like we
> > for f04aad36a07c ("mm/ksm: fix flag-dropping behavior in ksm_madvise").
> 
> That's a bit unhelpful if rust can't cope with extremely basic assignments like
> that and we just have to know to add helpers :/
> 
> We do BIT() stuff for e.g. VM_HIGH_ARCH_n, VM_UFFD_MINOR_BIT,
> VM_ALLOW_ANY_UNCACHED_BIT, VM_DROPPABLE_BIT and VM_SEALED_BIT too and no such
> helpers there, So not sure if this is required?
> 
> Alice - why is it these 'non-trivial' defines were fine but VM_MERGEABLE was
> problematic? That seems strange.
> 
> I see [0], so let me build rust here and see if it moans, if it moans I'll add
> it.
> 
> [0]:https://lore.kernel.org/oe-kbuild-all/CANiq72kOhRdGtQe2UVYmDLdbw6VNkiMtdFzkQizsfQV0gLY1Hg@mail.gmail.com/

When you use #define to declare a constant whose right-hand-side
contains a function-like macro such as BIT(), bindgen does not define a
Rust version of that constant. However, VM_MAYBE_GUARD is not referenced
in Rust anywhere, so that isn't a problem.

It was a problem with VM_MERGEABLE because rust/kernel/mm/virt.rs
references it.

Note that it's only the combination of #define and function-like macro
that triggers this condition. If the constant is defined using another
mechanism such as enum {}, then bindgen will generate the constant no
matter how complex the right-hand-side is. The problem is that bindgen
can't tell whether a #define is just a constant or not.

Alice


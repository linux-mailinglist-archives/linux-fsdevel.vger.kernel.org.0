Return-Path: <linux-fsdevel+bounces-56270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 702CFB152EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 20:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796AB188C42E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12792512C3;
	Tue, 29 Jul 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKD71RjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098F2512FC;
	Tue, 29 Jul 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814350; cv=none; b=Ed+BaaqKX354sS7GTKESdpb6+Pew3IgXMlPhfTQEybQe78HzMGDiA0yy+Ck2v8pjPDmZeaC+1e09TfzF6m78NmWH96GeFSyw7OzdyHtN6c8kxAoohvdZGKQr06zX1w8ruhUIIGRMoJkrmFWVOzNx1jqiAhOC0rM1lmwJEoEpJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814350; c=relaxed/simple;
	bh=K0MGb4ayzYxYJZKg1HWu8KpfAsEMhfWFw3xLTjemhe4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0wxXbYPDf4qe3QnA7aZ37GmQ0TQy8ZitdH0gW2zxPt5KhR7kD/WqyGm59PRG68l89NixYmiWEzEjNldezOal7IR0+R1X2l590IabEksIYD+zmGX6PgG/fIay31CmHNAC1Gkjxd3vF8oEDfhw7jhq7kr4L+WdAxaBIr3fUBxq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKD71RjS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3321296ad03so14875391fa.3;
        Tue, 29 Jul 2025 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753814347; x=1754419147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYRfCV3hbQi5DsgzlDild2w/1OeWF4e+oM87WSvfwwM=;
        b=NKD71RjSND1rXmAnXQfIgEf/HiGuyRbmfQkAATxvz+XDc3wuAS4PYMTAnFTc+hOFBB
         jFfTAut7lO3fvht+3On5gRaIfl+2JUu+C2CyqgxTS8W35LGqMXdhSUjejCV9hA/o8SY3
         0PSeXZbieKdSiw5El+lB3jlElLjLihmZthWvrMhStg80B4X/+WwjaahcIn6GBi4Qcplc
         7DOUDEExmM8rm8f+iQ5+1OL4gAnBtqzmlfM/R2yn2i3XNKsLWCbKBBoyp47IhnsZEusl
         BN9pcQGornc7ZtX5pT62Tk+O+efm5f0pzlCljOdXohw3AYM1UNB3P3sLQR1I5+qIVlUx
         Ejdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753814347; x=1754419147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYRfCV3hbQi5DsgzlDild2w/1OeWF4e+oM87WSvfwwM=;
        b=ETVj2lztD/LuqAtTkiKADtNHw4Q05ZsmQHRw2PfE8PioK+rCQtRMNWSFrrfbJvYg7z
         yXRmJVzVlryxeBfl9Wjy6LiSSBP2n1Y4jvtotrvRwkZBK/LmnuxPBfGYYgI1QzV3qSxO
         uiw8sjGT7Wa/JBqentDjhBYcLWLHaY1zwuuh5Pzrropba0vzam+jLwaA3lRhEm71xBuu
         /fyKJdilhXPNZFR4MG5sOuqa+BU19MuE737r5wI+vU5aezSKSJQ7Qwidf3KZcjZTAYhY
         oXVtAZktdJmFMFdgqby9ZMTjlIs9tv5xAVBDXvKkutoouH/niCvCDm9s0opY2KOEYe5z
         nUVA==
X-Forwarded-Encrypted: i=1; AJvYcCUEeTIxbUN2CE4tUJnrmqEQFxQHf1uZauPv8SXH8X0ghrgmrLGHIla6QoShg0pXfvPfPgSFiNMD/c+fZadKdiRIMrr1@vger.kernel.org, AJvYcCUyamA+dDJFs+Gt5I97dmtdIlstFucMr54YDE5QByl7ACLKp0oBVJ19+nIrkXHiFQS5HbJEi5jd7xfE3w==@vger.kernel.org, AJvYcCWkT1IgC3VG91RjSdJMFzqqK4E8v4wvNmAROFhZrUxPH3v2UkelvSmGI4t9w342WTybEKnHTV8F/BxW@vger.kernel.org, AJvYcCWz/Wm1TtJzQejTERj4aS627Iv40fp656dSi4LyMJoYBbnv8bVVXTAB1OKQzsGzFl2/elUtClpXLwf6lthY@vger.kernel.org, AJvYcCX3uv/CC6AuisHfr0+afv3eMKAK3LKvGKei7ZJJLWYQTu6S9/zFG4MD8w2DWAaaZX8IN9I=@vger.kernel.org, AJvYcCXKzSDjDDuvTo97HgVYICke64JFan/hUVRZPFof1kgZ1jCIT4Wgz6+JqNHrz5wY3qR8mWmxzer23nM7QcRocA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTdNZwefZStZbNrgd3WMdamCOz2MJV+yvWB6mBvx6R0qaMmp6
	9SqSXYLpmSA5xQ7xhuN1Ay4Qi3dRJU9Fw0OtWE/gMSugHzYXHIjbZ7AU
X-Gm-Gg: ASbGncvgm47JZ0K/0uVnx0Ig1KIcA6t2OJx8xHF5d5Q5y34tQMfUUZ0+FxMDYKNZtzX
	/JT1Z5/lfU0l0j1VePujvsEBkS+sNjTFsmqvAB5x7bvAYwQ+D2GQG5URpzdP3vv4jScz0DYmx6f
	h650+jK1UQC3xPzgX7swzmOMB18Ssdbq+xu2Wc19pbWPJ31eFTIwrgo71iUOo0YlXWFQH939At1
	8tuFtLoi4kVGhMJ7iGpHq4sa6frFdcWm3jKThEOoEWiCcfKS+QTOn75Komw4uGe157VIWOgbgMA
	Y53AB8IqlGKk5cdwyYeHiVMV0soCfNfoXfP0r3gX/Crj8d3D2Hm18+LloVlJaaGw
X-Google-Smtp-Source: AGHT+IF9yvJyPiTzwXfrNX8PT/G9myfdCCK3lbY+TklU3bxii0UFYjkiLDeONxAItTuHZBzIFqK+RA==
X-Received: by 2002:a05:6512:3414:b0:553:241d:4e77 with SMTP id 2adb3069b0e04-55b7c011afdmr184040e87.22.1753814346295;
        Tue, 29 Jul 2025 11:39:06 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332219ce7aesm832441fa.34.2025.07.29.11.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:39:04 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 29 Jul 2025 20:39:01 +0200
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
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
	Uladzislau Rezki <urezki@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: update core kernel code to use vm_flags_t
 consistently
Message-ID: <aIkVRTouPqhcxOes@pc636>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
 <aIgSpAnU8EaIcqd9@hyeyoo>
 <73764aaa-2186-4c8e-8523-55705018d842@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73764aaa-2186-4c8e-8523-55705018d842@lucifer.local>

On Tue, Jul 29, 2025 at 06:25:39AM +0100, Lorenzo Stoakes wrote:
> Andrew - FYI there's nothing to worry about here, the type remains
> precisely the same, and I'll send a patch to fix this trivial issue so when
> later this type changes vmalloc will be uaffected.
> 
> On Tue, Jul 29, 2025 at 09:15:51AM +0900, Harry Yoo wrote:
> > [Adding Uladzislau to Cc]
> 
> Ulad - could we PLEASE get rid of 'vm_flags' in vmalloc? It's the precise
> same name and (currently) type as vma->vm_flags and is already the source
> of confusion.
> 
You mean all "vm_flags" variable names? "vm_struct" has flags as a
member. So you want:

urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
29:                          pgprot_t pgprot, unsigned long vm_flags)
39:             vm_flags |= VM_DEFER_KMEMLEAK;
41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
45:                              pgprot, vm_flags, NUMA_NO_NODE,
51:                                      pgprot, vm_flags, NUMA_NO_NODE,
85:                          pgprot_t pgprot, unsigned long vm_flags)
259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/vmalloc.c
3853: * @vm_flags:                additional vm area flags (e.g. %VM_NO_GUARD)
3875:                   pgprot_t prot, unsigned long vm_flags, int node,
3894:   if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
3912:                             VM_UNINITIALIZED | vm_flags, start, end, node,
3977:   if (!(vm_flags & VM_DEFER_KMEMLEAK))
4621:   vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags mm/execmem.c
29:                          pgprot_t pgprot, unsigned long vm_flags)
39:             vm_flags |= VM_DEFER_KMEMLEAK;
41:     if (vm_flags & VM_ALLOW_HUGE_VMAP)
45:                              pgprot, vm_flags, NUMA_NO_NODE,
51:                                      pgprot, vm_flags, NUMA_NO_NODE,
85:                          pgprot_t pgprot, unsigned long vm_flags)
259:    unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
266:    p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
376:    unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
385:            p = execmem_vmalloc(range, size, pgprot, vm_flags);
urezki@pc638:~/data/backup/coding/linux-not-broken.git$ grep -rn vm_flags ./include/linux/vmalloc.h
172:                    pgprot_t prot, unsigned long vm_flags, int node,
urezki@pc638:~/data/backup/coding/linux-not-broken.git$

to rename all those "vm_flags" to something, for example, like "flags"?

Thanks!

--
Uladzislau Rezki


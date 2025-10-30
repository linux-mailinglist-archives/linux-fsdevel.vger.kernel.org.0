Return-Path: <linux-fsdevel+bounces-66458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6DAC1FDD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41A1424706
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3BD342CBB;
	Thu, 30 Oct 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6eub5k+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AF632
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824610; cv=none; b=TQ85Cgd8v7+0s/N8pqmCXxbLkjdiXFqmCFt/iMoIzHTYLQBOHs45sH4yLiZqfF3lS1GQyHC5xAT+2q4TzjEFvfurU0CsHFkvMPyBMLUB7d4SJdZ2N6GUCS8pIo36/Cqc+JXr9UGsTETN9sQ7537NdQwaomVccHnd/0WiXbRAu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824610; c=relaxed/simple;
	bh=8K202zcT/5Asm+XAnj+oZfeb7i++8K1HRzH59kLoZlc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E+1InJlZ+YhYRxM8mTZk8PitocPTBWFd8I8HSBIGGnfDORuz/x68/rDjKIT12CVpiTARAz57iIq6TeyJXyMq3h1ESAhKIA0pnfc5btardHWHzwVM5Tbdq0J6UWOBZgSeo5Ud4E3LTh6YWlU8Qid9JEbMEJ0MA5w7L5IzIeD/nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6eub5k+; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429b51f3fd8so376359f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761824607; x=1762429407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDSI58A/HQKOUf6eeXjJJOZLO/JqDx1ROCyXyTZAY7w=;
        b=e6eub5k+S99WJGRdh3tMlYUvQRHbfhXapbdzJLS42qfE5/7K7jEApuqdBsz5RD+aG6
         KsVtxKTip2zxubSN7O7gGykzcshX9Jba+DCbkxmt3h2UeoH9GUV6Rjk8yp0CYLLPRAz+
         3ryGYmpRZLOnXJlb3r44zO7glDOUp5ziTMDX3KHo5xm1WEh8Daboaq1al6GeL4b3nKKR
         z7JrDM96WlVI0/NvzmwBw9c5/t6YK8pV3tFPZT7ucSkB9es4eXNmzI+5GhmN8mvLCOZk
         wIiN0aZ4IGLj26y9lX9pZ8p/O5DrL9wFIAgN5ikhYnYq8PjyOPffgWjEukr1W7py3d7z
         R1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761824607; x=1762429407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDSI58A/HQKOUf6eeXjJJOZLO/JqDx1ROCyXyTZAY7w=;
        b=rz1icI9tr0RvcoJXuuKIVAasybrqYSzqmJpNwb4GJVTkKLDa2nmUFSoIxlM6yJpi34
         BsEqyv+egi3+NIK9+f3xkqo8jOw+Sx7CZ9dnDgDODNPotvZG9rRkn5+AnR+20isK/swf
         4Yzda68wrwNxpe8UIVgVShQXd7KFphYFm/wsFT0KTeD+wMfLmBmw8OfQU5IE8GOX/NtG
         KTKqA1/WbTAAehy6/nUcVb1MEq5BAijHjr7IKzV69MNgZ7YeMQJzLalLeKwDS8b9VRUs
         A6bZqS+SbMpA0Fj0NP8DmVRaaU8Byp5Qywzj9PwCfjcEVW7Y+Xi1kyszoSY4BF8bRYi9
         4qpg==
X-Forwarded-Encrypted: i=1; AJvYcCXbQymHK7aCoH20fxliFEfPlJHjymO7eMp1HFiuqxJ+VZgjsRL6pML05NgvBIzH7uQ+b+dTAXcrRbmS4cq+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6kq1qCNf9x7K4Sjycy9EkFPgQEJ4AWfx4ZPtKCJU7yi0iUbT
	LahVhVON1C7LvMu9n1AaI1lDrR3L3kBsoYxZLc2Gug0CzNi2CV18Z6iP0k38mkxmFFccY+vCFrE
	XX3zu5WlNnmlMRESxYQ==
X-Google-Smtp-Source: AGHT+IHzjpoD898gBgMNPMdZP5uEYogpZiJA8uErDROog5MEOI5DpnJbAzYLVH3kmqrIf4gyzUsqqY51Um1rkCk=
X-Received: from wrme11.prod.google.com ([2002:adf:e38b:0:b0:3ec:e23c:988f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:290f:b0:429:58f:325 with SMTP id ffacd0b85a97d-429aef830c6mr5166773f8f.24.1761824606490;
 Thu, 30 Oct 2025 04:43:26 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:43:25 +0000
In-Reply-To: <4e6d3f7b-551f-4cbf-8c00-2b9bb1f54d68@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <CAA1CXcCiS37Kw78pam3=htBX5FvtbFOWvYNA0nPWLyE93HPtwA@mail.gmail.com> <4e6d3f7b-551f-4cbf-8c00-2b9bb1f54d68@lucifer.local>
Message-ID: <aQNPXcxcxcX3Lwv0@google.com>
Subject: Re: [PATCH 0/4] initial work on making VMA flags a bitmap
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Peter Xu <peterx@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Pedro Falcato <pfalcato@suse.de>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 30, 2025 at 08:33:10AM +0000, Lorenzo Stoakes wrote:
> +cc Alice - could you help look at this? It seems I have broken the rust
> bindings here :)
> 
> Thanks!
> 
> On Wed, Oct 29, 2025 at 09:07:07PM -0600, Nico Pache wrote:
> > Hey Lorenzo,
> >
> > I put your patchset into the Fedora Koji system to run some CI on it for you.
> >
> > It failed to build due to what looks like some Rust bindings.
> >
> > Heres the build: https://koji.fedoraproject.org/koji/taskinfo?taskID=138547842
> >
> > And x86 build logs:
> > https://kojipkgs.fedoraproject.org//work/tasks/7966/138547966/build.log
> >
> > The error is pretty large but here's a snippet if you want an idea
> >
> > error[E0425]: cannot find value `VM_READ` in crate `bindings`
> >    --> rust/kernel/mm/virt.rs:399:44
> >     |
> > 399 |     pub const READ: vm_flags_t = bindings::VM_READ as vm_flags_t;
> >     |                                            ^^^^^^^ not found in `bindings`
> > error[E0425]: cannot find value `VM_WRITE` in crate `bindings`
> >    --> rust/kernel/mm/virt.rs:402:45
> >     |
> > 402 |     pub const WRITE: vm_flags_t = bindings::VM_WRITE as vm_flags_t;
> >     |                                             ^^^^^^^^ not found
> > in `bindings`
> > error[E0425]: cannot find value `VM_EXEC` in crate `bindings`
> >      --> rust/kernel/mm/virt.rs:405:44
> >       |
> >   405 |     pub const EXEC: vm_flags_t = bindings::VM_EXEC as vm_flags_t;
> >       |                                            ^^^^^^^ help: a
> > constant with a similar name exists: `ET_EXEC`
> >       |
> >      ::: /builddir/build/BUILD/kernel-6.18.0-build/kernel-6.18-rc3-16-ge53642b87a4f/linux-6.18.0-0.rc3.e53642b87a4f.31.bitvma.fc44.x86_64/rust/bindings/bindings_generated.rs:13881:1
> >       |
> > 13881 | pub const ET_EXEC: u32 = 2;
> >       | ---------------------- similarly named constant `ET_EXEC` defined here
> > error[E0425]: cannot find value `VM_SHARED` in crate `bindings`
> >    --> rust/kernel/mm/virt.rs:408:46
> >     |
> > 408 |     pub const SHARED: vm_flags_t = bindings::VM_SHARED as vm_flags_t;
> >     |                                              ^^^^^^^^^ not found
> > in `bindings`
> >
> > In the next version Ill do the same and continue with the CI testing for you!
> 
> Thanks much appreciated :)
> 
> It seems I broke the rust bindings (clearly), have pinged Alice to have a
> look!
> 
> May try and repro my side to see if there's something trivial that I could
> take a look at.
> 
> I ran this through mm self tests, allmodconfig + a bunch of other checks
> but ofc enabling rust was not one, I should probably update my scripts [0]
> to do that too :)
> 
> Cheers, Lorenzo
> 
> [0]:https://github.com/lorenzo-stoakes/review-scripts

I can help convert the Rust bindings to work with this approach. I see
there is a nice and simple vma_test() method for checking a flag, but I
don't see any equivalent method for setting or unsetting a given bit.
What would be the best function for Rust to call to set or unset a given
bit in the vma flags?

Alice


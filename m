Return-Path: <linux-fsdevel+bounces-66412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE636C1E304
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 04:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E89C134BCAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 03:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588262F6586;
	Thu, 30 Oct 2025 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaz064tm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A126657D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793659; cv=none; b=fmonE3rcV1GF7nUEmLg2EIpvaPx0ImfIN+hiYmDqffLJlJMY2gqOyguqITux3MI8zk4FzESbuaDYNXeBD52Tg7dilyeOUwUJ/fBktOIUT10D4rXkMVRU7jC5YmxupIYWKdfUCt20oJso5XtIrkfYmZtvoyBfpQDNBMLxsf6MnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793659; c=relaxed/simple;
	bh=646IL+Zrykg6Qc9jPOQV2i5OhKMGMAT3ELcoy1hQF18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcgRSQQSVxq1kB7ppzrd0WIIB5NYbPdzf9YMfKlM+B09klIg03Cperu4nY48C+grcc/1YfFh9X6dVQ/CWk1cNCg470wdC+jx0wWd6jXQKHHatgrhLyvOfQUvbw8dS68A80fM2zCVKdWmKNRgt7zbzaXSN7EjcQxQZT9qrwSVZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaz064tm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761793657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wN0XWQ1N0rtxB4cj1GaEpvY3UQhVabXBsS/QmbEqpk=;
	b=eaz064tm7hYNBF30k+bmcWVMkSqIpsiyOJ+nmTwIGUYBdXJ930DGjyjTJPakHuV9W5LZZt
	tlSuho9V5X1DvpfwqnqkzTnd1ZhQz8wfF2Te04wt1MqpJxvWr3RROtyCGnW0ZTXprtZVSg
	StefAhGuVfiMqRd7SGQYQLBcUHT9Pqo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-tJaGFMAwMYKmRx8T4wBbqg-1; Wed, 29 Oct 2025 23:07:35 -0400
X-MC-Unique: tJaGFMAwMYKmRx8T4wBbqg-1
X-Mimecast-MFC-AGG-ID: tJaGFMAwMYKmRx8T4wBbqg_1761793653
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78495d5ab26so35724037b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 20:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761793653; x=1762398453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wN0XWQ1N0rtxB4cj1GaEpvY3UQhVabXBsS/QmbEqpk=;
        b=NRTq+MIWra+anecCt3Ug1ki2zNDoT3rzUQTq9C/eDDRrfL3+QQV3xEdumEzDmedmMs
         W0JEGQx06mcVSRDmdaZotlR/40aBj5iaGpB+YcZOlVV/5vP8zpooo0cDNXyik/bYxmKL
         EM9hR+THTSyV7emurEoZ0DPmnlBqpz7mBZCNqb4X16m5tWfuuPh2Vs2VO7RoU6DplF06
         TaKGd1QhmfudKzMqLEWzM/zH8CfUZilA81aH+wZAhvVMaq7TDAWJS/8UEvD0bjj6Dfor
         ZKq0y3+crfUWS0RRFdKTpGNJK5FdX3G4YM53QtcWsp8Fk4kzpDmE8CrxFqI+NLXSccKR
         W/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXMl9nVRaJiuW4zaGDRReSK4M81UOxa5v3f3maKkSgm2YH6ymw+bXQiwoVnqce//NnD6OviLzoMLmcUGrDA@vger.kernel.org
X-Gm-Message-State: AOJu0YwHWLHmJiEHyBKFeUGFdR2QFfFVgH+7D8JE8o8T1RoKTPRASMKs
	fzUfAotNcgtjuEpKRY0ppl74CBRTjaufgXZNCfY/H9BZEnmyham653aYTnZVTcrT9cLeg5Ibjeu
	y72KlSzJ5aOUVcXXOmm3F6h7Wq3jPIV6G9htT2h7kXGtOZefD051jojzMgVaYUwKMVe/+z9AaZT
	org5+1UWzG7nI14HkVxR54XBsUorgmA5lX3Ay6TUSIsQ==
X-Gm-Gg: ASbGncvbKR2/1+bVLYfp16T8QH0f0Of9NpbW+b7884R95JLGL9herZK/5cphV5rbr6b
	t9dyxplgd9I8oos/0O44Fp3Wv7IuYqWraIek4FWrZQ7sWd49eAAcJDNrhuv0VfKCgaUPxv5DeVO
	SeLfQ9fVbRO/SrWiQxZrUN1u3fPYtfOozpQM5Si9f0ZiY/5O2K7nWcb1Kxafwxu8UY4gsDMQ==
X-Received: by 2002:a05:690e:1248:b0:63e:1521:c29f with SMTP id 956f58d0204a3-63f829a2809mr1659523d50.17.1761793653224;
        Wed, 29 Oct 2025 20:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC5CkcBnh/sb8uhkM3WgOJU7Y4/I4RGXP2TJxmJQ2XYo9gh6ekWqrMeIKQHHjyKjrwn97kwUnbrionRddMKeM=
X-Received: by 2002:a05:690e:1248:b0:63e:1521:c29f with SMTP id
 956f58d0204a3-63f829a2809mr1659506d50.17.1761793652731; Wed, 29 Oct 2025
 20:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Oct 2025 21:07:07 -0600
X-Gm-Features: AWmQ_bmIFH7DQx94H00ZendIrBM5Leqedwdezzz2vnEqWrhrlST8xh1cZBn-MjI
Message-ID: <CAA1CXcCiS37Kw78pam3=htBX5FvtbFOWvYNA0nPWLyE93HPtwA@mail.gmail.com>
Subject: Re: [PATCH 0/4] initial work on making VMA flags a bitmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:50=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> We are in the rather silly situation that we are running out of VMA flags
> as they are currently limited to a system word in size.
>
> This leads to absurd situations where we limit features to 64-bit
> architectures only because we simply do not have the ability to add a fla=
g
> for 32-bit ones.
>
> This is very constraining and leads to hacks or, in the worst case, simpl=
y
> an inability to implement features we want for entirely arbitrary reasons=
.
>
> This also of course gives us something of a Y2K type situation in mm wher=
e
> we might eventually exhaust all of the VMA flags even on 64-bit systems.
>
> This series lays the groundwork for getting away from this limitation by
> establishing VMA flags as a bitmap whose size we can increase in future
> beyond 64 bits if required.
>
> This is necessarily a highly iterative process given the extensive use of
> VMA flags throughout the kernel, so we start by performing basic steps.
>
> Firstly, we declare VMA flags by bit number rather than by value, retaini=
ng
> the VM_xxx fields but in terms of these newly introduced VMA_xxx_BIT
> fields.
>
> While we are here, we use sparse annotations to ensure that, when dealing
> with VMA bit number parameters, we cannot be passed values which are not
> declared as such - providing some useful type safety.
>
> We then introduce an opaque VMA flag type, much like the opaque mm_struct
> flag type introduced in commit bb6525f2f8c4 ("mm: add bitmap mm->flags
> field"), which we establish in union with vma->vm_flags (but still set at
> system word size meaning there is no functional or data type size change)=
.
>
> We update the vm_flags_xxx() helpers to use this new bitmap, introducing
> sensible helpers to do so.
>
> We then provide vma_flags_test() and vma_test() to allow for testing of V=
MA
> flag bits, and utilise these across the memory management subsystem.
>
> Since it would be entirely inefficient to do away with the bitwise
> operations used throughout the kernel with respect to VMA flags, we permi=
t
> these to exist, providing helpers for these operations against the new
> bitmap.
>
> These operate on the assumption that such operations will only be require=
d
> for flags which can exist within a system word. This allows the fundament=
al
> flags to be used efficiently as before.
>
> This series lays the foundation for further work to expand the use of
> bitmap VMA flags and eventually eliminate these arbitrary restrictions.
>
>
> ANDREW/REVIEWS NOTES:
>
> Apologies, but the nature of this series is that it's going to be a littl=
e
> painful, I've based it on [0] to make life a bit easier. Let me know if y=
ou
> need rebases etc.

Hey Lorenzo,

I put your patchset into the Fedora Koji system to run some CI on it for yo=
u.

It failed to build due to what looks like some Rust bindings.

Heres the build: https://koji.fedoraproject.org/koji/taskinfo?taskID=3D1385=
47842

And x86 build logs:
https://kojipkgs.fedoraproject.org//work/tasks/7966/138547966/build.log

The error is pretty large but here's a snippet if you want an idea

error[E0425]: cannot find value `VM_READ` in crate `bindings`
   --> rust/kernel/mm/virt.rs:399:44
    |
399 |     pub const READ: vm_flags_t =3D bindings::VM_READ as vm_flags_t;
    |                                            ^^^^^^^ not found in `bind=
ings`
error[E0425]: cannot find value `VM_WRITE` in crate `bindings`
   --> rust/kernel/mm/virt.rs:402:45
    |
402 |     pub const WRITE: vm_flags_t =3D bindings::VM_WRITE as vm_flags_t;
    |                                             ^^^^^^^^ not found
in `bindings`
error[E0425]: cannot find value `VM_EXEC` in crate `bindings`
     --> rust/kernel/mm/virt.rs:405:44
      |
  405 |     pub const EXEC: vm_flags_t =3D bindings::VM_EXEC as vm_flags_t;
      |                                            ^^^^^^^ help: a
constant with a similar name exists: `ET_EXEC`
      |
     ::: /builddir/build/BUILD/kernel-6.18.0-build/kernel-6.18-rc3-16-ge536=
42b87a4f/linux-6.18.0-0.rc3.e53642b87a4f.31.bitvma.fc44.x86_64/rust/binding=
s/bindings_generated.rs:13881:1
      |
13881 | pub const ET_EXEC: u32 =3D 2;
      | ---------------------- similarly named constant `ET_EXEC` defined h=
ere
error[E0425]: cannot find value `VM_SHARED` in crate `bindings`
   --> rust/kernel/mm/virt.rs:408:46
    |
408 |     pub const SHARED: vm_flags_t =3D bindings::VM_SHARED as vm_flags_=
t;
    |                                              ^^^^^^^^^ not found
in `bindings`

In the next version Ill do the same and continue with the CI testing for yo=
u!

Cheers,
-- Nico

>
> [0]: https://lore.kernel.org/linux-mm/cover.1761756437.git.lorenzo.stoake=
s@oracle.com/
>
> Lorenzo Stoakes (4):
>   mm: declare VMA flags by bit
>   mm: simplify and rename mm flags function for clarity
>   mm: introduce VMA flags bitmap type
>   mm: introduce and use VMA flag test helpers
>
>  fs/proc/task_mmu.c               |   4 +-
>  include/linux/hugetlb.h          |   2 +-
>  include/linux/mm.h               | 341 +++++++++++++-------
>  include/linux/mm_inline.h        |   2 +-
>  include/linux/mm_types.h         | 120 ++++++-
>  include/linux/userfaultfd_k.h    |  12 +-
>  kernel/fork.c                    |   4 +-
>  mm/filemap.c                     |   4 +-
>  mm/gup.c                         |  16 +-
>  mm/hmm.c                         |   6 +-
>  mm/huge_memory.c                 |  34 +-
>  mm/hugetlb.c                     |  48 +--
>  mm/internal.h                    |   8 +-
>  mm/khugepaged.c                  |   2 +-
>  mm/ksm.c                         |  12 +-
>  mm/madvise.c                     |   8 +-
>  mm/memory.c                      |  77 +++--
>  mm/mempolicy.c                   |   4 +-
>  mm/migrate.c                     |   4 +-
>  mm/migrate_device.c              |  10 +-
>  mm/mlock.c                       |   8 +-
>  mm/mmap.c                        |  16 +-
>  mm/mmap_lock.c                   |   4 +-
>  mm/mprotect.c                    |  12 +-
>  mm/mremap.c                      |  18 +-
>  mm/mseal.c                       |   2 +-
>  mm/msync.c                       |   4 +-
>  mm/nommu.c                       |  16 +-
>  mm/oom_kill.c                    |   4 +-
>  mm/pagewalk.c                    |   2 +-
>  mm/rmap.c                        |  16 +-
>  mm/swap.c                        |   3 +-
>  mm/userfaultfd.c                 |  33 +-
>  mm/vma.c                         |  37 ++-
>  mm/vma.h                         |   6 +-
>  mm/vmscan.c                      |   4 +-
>  tools/testing/vma/vma.c          |  20 +-
>  tools/testing/vma/vma_internal.h | 536 +++++++++++++++++++++++++++----
>  38 files changed, 1037 insertions(+), 422 deletions(-)
>
> --
> 2.51.0
>



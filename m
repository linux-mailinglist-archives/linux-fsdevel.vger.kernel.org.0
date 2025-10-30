Return-Path: <linux-fsdevel+bounces-66440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0372EC1F416
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA28A4028C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25CD341674;
	Thu, 30 Oct 2025 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cylN6+Zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C5278E5D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816055; cv=none; b=fzE6FS0FJhmKNhDmEZQu6JPXyatB2jKS8ELkNKMQ4u3J9j6TU9a5mp+tUtWosUo10KSFdbwtlo1NaD+TPrmwdEx5c6EkDB9vW70wKIc05uGme0jRfFiZsz9QmW/6Nor6SN7pcJ7lK0nhxA02kthTdO3TPeo2S4aT78Or3AVltoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816055; c=relaxed/simple;
	bh=4bNUm9dD8Ce6TUSW8cjR+CpkXCgQZKEzl6dy6GJtnYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdWpZ3ftIcmdFVM40KbJpFLcgfmXWJhZ8cCfM1HFMT/xB4C94XLOXYQ6pmPi7BxftKBrIAIzgaVNhaeWBu71J7UP/GPlHFcMmv2awpM2PANb5TuEqOKoql+PVryyWBXq0YF1Wfy+uOZFbvjmYdebnM9V6Ri1N8vmR37JmaVHtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cylN6+Zo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761816052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrnKVX90qOg0KXOFerofsL+qXt9ZrtN/DGELABhsPnQ=;
	b=cylN6+ZoONmKgLM4/xVRYBfU3QM+/cs2LMGtEsgpEbB1V6z0FdvyRz2sPMVmyUjAlIkXK2
	6M4atjvXs9WKbNQPwlAzVQp1FSFAl7sCdQ5odpUotZ2YNuHrA5gmzn3VxgBOKWSvHWkGsU
	7/qFgI11aYjg26zgwHGQngeyyrgbSUA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-qCQBtJnVN5qxGLBJrmX89w-1; Thu, 30 Oct 2025 05:20:49 -0400
X-MC-Unique: qCQBtJnVN5qxGLBJrmX89w-1
X-Mimecast-MFC-AGG-ID: qCQBtJnVN5qxGLBJrmX89w_1761816048
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78120957aceso11627127b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 02:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816048; x=1762420848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrnKVX90qOg0KXOFerofsL+qXt9ZrtN/DGELABhsPnQ=;
        b=ahSkZBoXq7BWsazHDRe7NtsdmJ5SChzFv5ypy0pn7UAbI1X8sZlmImECGA7KmTl2Hr
         bdPcEnJmRL6Gfpbi5FRDzbqWdGgAFxdOort4z13ZmqZdyhSJlFsp7kae5tlRJzTxfS6n
         BErQ6iTtyK7oV+AgitVOBPZUCKncLNTpZSR9+e/qZvi1cUn28qkOym6Z4tSv9drnfbxV
         sqmU0I7nWwAXUvGvc+24H6sEJHDopN1XgrJl2/sDHfxIysQv7Ene9No5vW/0ijjaavY+
         hgsk2+Lo9V+6XhZSm/3KhuthETr2JJKXUHmWyG4vRxkJg3Pu2gDVhWXEqfwrbvLpmlEC
         8rMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeCNt7bqL7xxfMsN+ufmrHlztvk+MfJ9DFZnZvFy1eymKaE+8XitglxOZQ2LSPIKoogrVqhmMwUT7lvHfl@vger.kernel.org
X-Gm-Message-State: AOJu0YzFNtKiQ+PBJxULCqH51camUWt8s1+A1s0FTSAD8YxC/NMjKCsg
	gc4XJGqKdq6NwE7pukgOOFSnFYV+LEXH8yUQLj66I2hr0uPuUlZdtgCZgPMQ/lawl6RjzgQzOqe
	/YaZs1OdMdW0FTbHw2Aw24/KWtcvGsgnYfIS7d9pZCkcCipdFXAnz4bGeE3HhfkH+JEjzqGLds6
	WgjMCcDL4o/NbCux2CpkZ2iaUlTohBudUJ2wsT7cJYAA==
X-Gm-Gg: ASbGnctX/rN9hShDVs7NHv0b7o6gi4mI3MjSIQVoVpy9K1bHV8Cf121C+cz3YD5at9I
	a5mf4JfJ9xZC44ed1YtASfL8XhFQK6IDeTWmMLt4+wZDiDp2RoSrUEXdlxt9/HBRI2HMZ+op9LY
	p0Cyh02qeFJ6iDrNaPFgGbjdiXugE2UlUvUPq8itq72IyMwS8Ltu9g6svTKtANmD2CpTvYvw==
X-Received: by 2002:a05:690c:4c11:b0:784:8239:95bb with SMTP id 00721157ae682-78628fb8a75mr58292017b3.51.1761816048397;
        Thu, 30 Oct 2025 02:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI5kI0F21WL+QZ1OA4Dk5ECCGXkdTRNA09ZYjLWlY5M89loSfEtpTmKAv4OFS+49Y22AUCQe8xd4jVF4QnaWI=
X-Received: by 2002:a05:690c:4c11:b0:784:8239:95bb with SMTP id
 00721157ae682-78628fb8a75mr58291307b3.51.1761816047984; Thu, 30 Oct 2025
 02:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <CAA1CXcCiS37Kw78pam3=htBX5FvtbFOWvYNA0nPWLyE93HPtwA@mail.gmail.com> <4e6d3f7b-551f-4cbf-8c00-2b9bb1f54d68@lucifer.local>
In-Reply-To: <4e6d3f7b-551f-4cbf-8c00-2b9bb1f54d68@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Thu, 30 Oct 2025 03:20:21 -0600
X-Gm-Features: AWmQ_blJjXz4EnpEZUUXNRpsB4nZ3dPXcyhHU9r2Z2YEnS4O1uwurODA2NiBlJ8
Message-ID: <CAA1CXcBP1MYdBi55kdF83B5OD6uMoFmyKP95mWJx7gkwZDQxKg@mail.gmail.com>
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
	linux-mm@kvack.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 2:34=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +cc Alice - could you help look at this? It seems I have broken the rust
> bindings here :)

From a first glance it looks trivial to fix, there are a bunch of
bindings of the VM_* flags.

for example

kernel/mm/virt.rs:    pub const MIXEDMAP: vm_flags_t =3D
bindings::VM_MIXEDMAP as vm_flags_t;

I believe this just needs to be converted to
'bindings::VM_MIXEDMAP_BIT' if I understand your series correctly
(havent fully looked at the details).

>
> Thanks!
>
> On Wed, Oct 29, 2025 at 09:07:07PM -0600, Nico Pache wrote:
> > Hey Lorenzo,
> >
> > I put your patchset into the Fedora Koji system to run some CI on it fo=
r you.
> >
> > It failed to build due to what looks like some Rust bindings.
> >
> > Heres the build: https://koji.fedoraproject.org/koji/taskinfo?taskID=3D=
138547842
> >
> > And x86 build logs:
> > https://kojipkgs.fedoraproject.org//work/tasks/7966/138547966/build.log
> >
> > The error is pretty large but here's a snippet if you want an idea
> >
> > error[E0425]: cannot find value `VM_READ` in crate `bindings`
> >    --> rust/kernel/mm/virt.rs:399:44
> >     |
> > 399 |     pub const READ: vm_flags_t =3D bindings::VM_READ as vm_flags_=
t;
> >     |                                            ^^^^^^^ not found in `=
bindings`
> > error[E0425]: cannot find value `VM_WRITE` in crate `bindings`
> >    --> rust/kernel/mm/virt.rs:402:45
> >     |
> > 402 |     pub const WRITE: vm_flags_t =3D bindings::VM_WRITE as vm_flag=
s_t;
> >     |                                             ^^^^^^^^ not found
> > in `bindings`
> > error[E0425]: cannot find value `VM_EXEC` in crate `bindings`
> >      --> rust/kernel/mm/virt.rs:405:44
> >       |
> >   405 |     pub const EXEC: vm_flags_t =3D bindings::VM_EXEC as vm_flag=
s_t;
> >       |                                            ^^^^^^^ help: a
> > constant with a similar name exists: `ET_EXEC`
> >       |
> >      ::: /builddir/build/BUILD/kernel-6.18.0-build/kernel-6.18-rc3-16-g=
e53642b87a4f/linux-6.18.0-0.rc3.e53642b87a4f.31.bitvma.fc44.x86_64/rust/bin=
dings/bindings_generated.rs:13881:1
> >       |
> > 13881 | pub const ET_EXEC: u32 =3D 2;
> >       | ---------------------- similarly named constant `ET_EXEC` defin=
ed here
> > error[E0425]: cannot find value `VM_SHARED` in crate `bindings`
> >    --> rust/kernel/mm/virt.rs:408:46
> >     |
> > 408 |     pub const SHARED: vm_flags_t =3D bindings::VM_SHARED as vm_fl=
ags_t;
> >     |                                              ^^^^^^^^^ not found
> > in `bindings`
> >
> > In the next version Ill do the same and continue with the CI testing fo=
r you!
>
> Thanks much appreciated :)
>
> It seems I broke the rust bindings (clearly), have pinged Alice to have a
> look!
>
> May try and repro my side to see if there's something trivial that I coul=
d
> take a look at.
>
> I ran this through mm self tests, allmodconfig + a bunch of other checks
> but ofc enabling rust was not one, I should probably update my scripts [0=
]
> to do that too :)

Ah cool, thanks for sharing your scripts, Ill take a look into those!

Cheers,
-- Nico
>
> Cheers, Lorenzo
>
> [0]:https://github.com/lorenzo-stoakes/review-scripts
>



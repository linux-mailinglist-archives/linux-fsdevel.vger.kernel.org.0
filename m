Return-Path: <linux-fsdevel+bounces-73498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1BD1AED5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28B4301FF93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C230DD21;
	Tue, 13 Jan 2026 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHGGo0Kr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE1A41
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330953; cv=none; b=GRhkT9kJKJGVxKGNPu7L0NNLSX7k5ypmtl/J/+NsT1mOEFajC2kDRS+oMt+0EULwMJUWRrNb89Eg3KZfC+R3BuEXk9LDCeMZR2Xgn4S27jJgIy1Fy8lolS2x+hD6UjqI940ZLeGWvAMTk8oyRBI1JkaVaBCSM5s7Y/gZmEefPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330953; c=relaxed/simple;
	bh=Cbv+hExUS3ISBTO3PKaDYQDdOIvgbF46iS1gqiLJAiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H129auGwp4uLJwJPIlxXgaQkpkEGxpXd9hBWqI3aGZyjvg+SU9/S98OHQ589D1d1Y03TaeWMfXfTuOqQ8+0/tIz6Y3dVEdm3ny8cyZehhGMkGcjFQuy+HL1POhdiEcXK3ZgyzYxBqrKUPkGiqTom17dBu/tsGl8+ToeARV8BbNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHGGo0Kr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47774d3536dso1376455e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 11:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768330950; x=1768935750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIS8Bi5jNE2DkmmZ5WwRSmIsst4XTLDDwGlWPY82bXM=;
        b=NHGGo0KrggwyRkye2xta1PYZtUQVhcCdZymeOE50jI1m/EFowFSp3bLV722bioTSuB
         DnwGzsT+GB52/N0ETSzK+SqjWRddbztLj0Ski8T9WJXhd2QdvaIYQqwrVu/5w9mxm484
         uQ5YeAMy2qafrgcVaSUuginE+psSxUY6dlrPBOmIjCfMpw/tJhsDfHVDzOb0mGcANe34
         WtMEaqA/7ItJ9vtNV9kJmJpRAmWAF6xY78RcutRP1i2h+XDwq+gGCNUOBVGGDVUDbYFN
         8p3/E3IeoTVLNqZEkU/UdHOSvrrmSumpqnIyCZZiU2cYdnuV1TI3WhzUDC4KLxxqKdSw
         a10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768330950; x=1768935750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZIS8Bi5jNE2DkmmZ5WwRSmIsst4XTLDDwGlWPY82bXM=;
        b=jHQdHGCUTVRTsnBBEDEQSLtXON5H66ibSGMjhKAvUiSXnAkiVfhJz7jkWmcP9tdVvE
         uZc0Tnkk/v8i/uLBKBrJpj19ijQH4XqEC6pVPFumiuTqhUzHUFaD49LmTYqNC30WHzjR
         5Kn4ZaZ0LdKiiA6x/nF5CtKYoBOht6YtZ7MOBw847NUHMZwlpevrpiBm0OTGp2FMfPUt
         l7U/S1sZ1a7iBsp4/Ww271P7nUU1pcskKKPfqFmnUlu6Fm9hDKxeXbm2Ib5qX+/x8Sn7
         lHv6BltT42S9UO/rECfEaLFF77TwnB/q2tYSfQn3hr4IsxCdtMNHRzaXmOuMZJTWfOEJ
         AbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn3EWNmOOTOfMzZpKjycQOWXoj6iUski6PbHLAxvWYiJ3VLomSjkZfsc5FVFCur8vkhJmvaAd5LiD/gWv9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bfEF3HB7iTSBHk5rNSGLO5frpobP/ZDqE0xsPLcOT465TjJX
	xmXTZu9WFuFcotmNRcig4+rdu90ntCUatrwHBltVScgJa1hZ6FeUUcwvApXQH2ISlxcB8QWmrx0
	tbfDvyv8GZimK8/aZt7e7B3nIbVQPWmMydoFcv+t8
X-Gm-Gg: AY/fxX6MIE1etxcj4xcvGgmKkVpoJzWnFE/D5WQB3YpCEuBkK7iBcAG9ijgR5ZNTtoR
	jSdVW8GUTGLUZbM/UdEmEXGDnnXUHyUJTbn0Q9kK9PB7wwOvUWBMpxgvX6aEVcBYupafnpKcE2l
	IoE+EskooAMT2croUoephh2tA6LDgc8g41vGhZBclrh5Q9ElBTpJXDdDKvlLXYOLFJMzrZziGVf
	jC2jvp4qL4vBVx1xKSQG+gmtTDg1N584oY6+b9IJ6HWlkyYntbAkacxysbUs9sqBbpKBPWVkP2A
	sQdR5H8ZouTsqwWFkTFWwosynw==
X-Received: by 2002:a05:600c:3d96:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47ee37a442fmr654855e9.11.1768330950087; Tue, 13 Jan 2026
 11:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a35e5a0bcfa00e84af24cbafc0653e74deda64a.1764064556.git.lorenzo.stoakes@oracle.com>
 <20260113185142.254821-1-clm@meta.com>
In-Reply-To: <20260113185142.254821-1-clm@meta.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 13 Jan 2026 20:02:17 +0100
X-Gm-Features: AZwV_QinHrnB7GFUH7LdFq-Z9yTmo4373JOvDPLiYEMAAKIw7pSmxnIv0pV5FbQ
Message-ID: <CAH5fLgidETM3aSVvLRxnA4oaaYWH_KN+qGMkQQf_GpWsjHkpXw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: declare VMA flags by bit
To: Chris Mason <clm@meta.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
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
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Pedro Falcato <pfalcato@suse.de>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 7:52=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> On Tue, 25 Nov 2025 10:00:59 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracl=
e.com> wrote:
>
> [ ... ]
> >
> > Finally, we update the rust binding helper as now it cannot auto-detect=
 the
> > flags at all.
> >
>
> I did a run of all the MM commits from 6.18 to today's linus, and this on=
e
> had a copy/paste error.   I'd normally just send a patch for this, but in
> terms of showing the review output:
>
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 2e43c66635a2c..4c327db01ca03 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT =3D X=
A_PRESENT;
>
> [ ... ]
>
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD =3D VM_MAYREAD;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE =3D VM_MAYWRITE;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC =3D VM_MAYEXEC;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE =3D VM_MAYEXEC;
>                                                    ^^^^^^^^^^
>
> Should this be VM_MAYSHARE instead of VM_MAYEXEC? This appears to be a
> copy-paste error that would cause Rust code using VmFlags::MAYSHARE to
> get bit 6 (VM_MAYEXEC) instead of bit 7 (VM_MAYSHARE).
>
> The pattern of the preceding lines shows each constant should reference
> its matching flag:
>
>     RUST_CONST_HELPER_VM_MAYREAD  =3D VM_MAYREAD
>     RUST_CONST_HELPER_VM_MAYWRITE =3D VM_MAYWRITE
>     RUST_CONST_HELPER_VM_MAYEXEC  =3D VM_MAYEXEC
>     RUST_CONST_HELPER_VM_MAYSHARE =3D VM_MAYSHARE  <- expected
>
> > +const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP =3D VM_PFNMAP;

Uh, good catch. Do you want to send a fix patch?

Alice


Return-Path: <linux-fsdevel+bounces-68502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FCC5D866
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 204583608E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3086324B07;
	Fri, 14 Nov 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYOZzKO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D623958A
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129321; cv=none; b=e6bJs6fkwuQe3S7XXZzH8nMkUpCE+1BdVjW027EKeyF2TkG2SDUHJjcPp7yezgAxU7iwEaIQt8rF+s70bnYS8+46dYSqIpo3XvGTks/8YZFCzmNoV9Egq6S3rgxiCGFwTjDTcnA5qALYKOdIiKDDr/RL9Hg11Z8Lms8MX8Pw2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129321; c=relaxed/simple;
	bh=oyt5yWDh2i4q0kX2N2Yql05RhNakuSpF89r2uusw1tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1tgrB0cHFxOc+5HOoasFAqDq+arF2RQc43EbKW1wwfj80NOaaVMXSuxfID4kLTQ4+8AoVji7XQN/P2eIRxWj2eysw/Xw/XA4noN7M/ahp9UJQpfWtyW2Sc2qH7i70ROPaAFYfuVQPk5OrlIA95DOW1lVbIiAnBcjR6R6XlXjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYOZzKO/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b387483bbso1684593f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763129313; x=1763734113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IXxo8d8j8VJ21Y+Lzck+HpFvoDGSHFT7itc7J4IXHQ=;
        b=jYOZzKO/snO4SXg+i+bXSmCY29AJLUHAh5y0WXNcVwXAaZG9IgRHoZrpTUBtdbcuu9
         ++Vcr8DSacZDo5ipnkInk9qvplFEkKTUwOgmc3ENe1Q/ovea2QmZxQvsCxEuzHUvPFyZ
         1YbFaCHI0gm9W+jQL68wJfo/DQ4B88YXNcmO3cUkOsGW35aitacKItZzQcmtomcSDBH9
         u33vsa4Dav3Z37qDvNprEATyXHRnaU00a2NJhCjigqAalyVKyLD4sGny2QlrPDhcQztd
         jszMq0RpEgos0jtiJMd0U5iLuYfj9sIS3Edq/UDUl85i1cXCEVU8R+mRkBe1HrU92Tu6
         Bqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763129313; x=1763734113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IXxo8d8j8VJ21Y+Lzck+HpFvoDGSHFT7itc7J4IXHQ=;
        b=YvApv2fNUN7PTKemX3anYbxfBfADRapXDftJJ+vUxnopCdj0BJ98InVqu5JLI1FCd6
         rKavCFrXrCjud9cj8pQvV2T0QEyyjzlTylKDnlC/S/mdyFWKGxt8Y4UffzN8pb2D0D0L
         mSwcBztZ050HDS1z/YCQKixvM4h9HevZ83fcoxBtBIjKgOoeZ+279ycEM7diA38Dkotk
         S1Zxj4yDs17V20Cd6uZrvalE+diLhwDVWSFCaYKECj5y4pxsWMbaOJB0CCuytl/01J7u
         Wd/nc8F9C5+BefyAarz3aUQJA0MKyWXuOmuEuPFY6ZlqNKEmX4+q8ZizcIPEPda/hpBN
         e02A==
X-Forwarded-Encrypted: i=1; AJvYcCXsURdkYjUffdU7H8DqfeCeTaDmc/gYKFQP5xLKBRUK7vAgD2Ld+RF5h9GSSTx3dc+Xc8uSDyBb6qRaLSoe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iByWlfiNyw5jeW4C12Ec57fa4NvyitYH5yKgRb3hHqGU+c/9
	BB/el1f446U6n64rJgFXZgzqMuCaDXoPXb8GW5leIUn0w1A1VdRa6r5Bdt1BZcmTqD9Uo2sykVE
	gqq8o2M7Q4xU1B/nYq13gBHMRWkdRILxnCc7DP90M
X-Gm-Gg: ASbGncv0lMHBl80Z1LlI9ivVg9/Qp15DvEEcMQp/ZQuOvbG0HLgyy45kbjX3ZOCOs7c
	4Im7tHCz55/kbxzO1yT4UFVsU1azyU+dte7mx5mwEs1wtzhDU8i0bEAPzjqaYg+moxyNoA170iz
	3WWjLuLJriumh8nXh2wDckoyxHbPIwCKZuEXL7/lg/QTNP9O9QTqi5Kf8isTem2ZdPd1PnyYUzy
	nbr9T6CjVf7wpw7q8Era+mNlM4giRdQ1RA8AWFwLlXkgzPZOmX7gYlhGwZK9cAtZGoHS4PeCjQ3
	bm3M66ZN6HCinSN0207fbwApZQ==
X-Google-Smtp-Source: AGHT+IG4uRI0PEq0NpCoNDKGJg8OF/SBz8TfroxjeXZLoJ/rlBcIJ1dSo30wyhO9fuhyg8jXgMGwvEzpXnS5vWaUElc=
X-Received: by 2002:a05:6000:2dc9:b0:42b:3131:5436 with SMTP id
 ffacd0b85a97d-42b5934140fmr3150253f8f.16.1763129312876; Fri, 14 Nov 2025
 06:08:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
 <aRcztRaDVyiDO7aH@google.com> <e98d913e-71bc-4b58-95ec-8ae054c43120@lucifer.local>
In-Reply-To: <e98d913e-71bc-4b58-95ec-8ae054c43120@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 14 Nov 2025 15:08:21 +0100
X-Gm-Features: AWmQ_blLOyoFop_bk6_FefgrlF5VT0ZZlbzlSQ-G0fF4lbhgUPVCotLgW7GR15A
Message-ID: <CAH5fLghqBxnXv_3uir6hD7=J-Xs=i8B-B7++7J2vCMwZ-5+wyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: declare VMA flags by bit
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

On Fri, Nov 14, 2025 at 3:02=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Nov 14, 2025 at 01:50:45PM +0000, Alice Ryhl wrote:
> > On Fri, Nov 14, 2025 at 01:26:08PM +0000, Lorenzo Stoakes wrote:
> > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings=
_helper.h
> > > index 2e43c66635a2..4c327db01ca0 100644
> > > --- a/rust/bindings/bindings_helper.h
> > > +++ b/rust/bindings/bindings_helper.h
> > > @@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT =3D=
 XA_PRESENT;
> > >
> > >  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC =3D XA_FLAGS_ALLOC;
> > >  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 =3D XA_FLAGS_ALLOC1;
> > > +
> > >  const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE =3D VM_MERGEABLE;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_READ =3D VM_READ;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_WRITE =3D VM_WRITE;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_EXEC =3D VM_EXEC;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_SHARED =3D VM_SHARED;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD =3D VM_MAYREAD;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE =3D VM_MAYWRITE;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC =3D VM_MAYEXEC;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE =3D VM_MAYEXEC;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP =3D VM_PFNMAP;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_IO =3D VM_IO;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_DONTCOPY =3D VM_DONTCOPY;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_DONTEXPAND =3D VM_DONTEXPAND;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_LOCKONFAULT =3D VM_LOCKONFAULT=
;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_ACCOUNT =3D VM_ACCOUNT;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_NORESERVE =3D VM_NORESERVE;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_HUGETLB =3D VM_HUGETLB;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_SYNC =3D VM_SYNC;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_ARCH_1 =3D VM_ARCH_1;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_WIPEONFORK =3D VM_WIPEONFORK;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_DONTDUMP =3D VM_DONTDUMP;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_SOFTDIRTY =3D VM_SOFTDIRTY;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_MIXEDMAP =3D VM_MIXEDMAP;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_HUGEPAGE =3D VM_HUGEPAGE;
> > > +const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE =3D VM_NOHUGEPAGE;
> >
> > I got this error:
> >
> > error[E0428]: the name `VM_SOFTDIRTY` is defined multiple times
> >       --> rust/bindings/bindings_generated.rs:115967:1
> >        |
> > 13440  | pub const VM_SOFTDIRTY: u32 =3D 0;
> >        | -------------------------------- previous definition of the va=
lue `VM_SOFTDIRTY` here
> > ...
> > 115967 | pub const VM_SOFTDIRTY: vm_flags_t =3D 0;
> >        | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `VM_SOFTDIRTY` redefin=
ed here
> >        |
> >        =3D note: `VM_SOFTDIRTY` must be defined only once in the value =
namespace of this module
> >
>
> That's odd, obviously I build tested this and didn't get the same error.
>
> Be good to know what config options to enable for testing for rust. I rep=
ro'd
> the previously reported issues, and new ones since I'm now declaring thes=
e
> values consistently using BIT().
>
> But in my build locally, no errors with LLVM=3D1 and CONFIG_RUST=3Dy.

I got this error because my config defines VM_SOFTDIRTY as VM_NONE,
which bindgen can resolve to zero. You probably have a config where
it's defined using a function-like macro, so bindgen did not generate
a duplicate for you.

> > Please add the constants in rust/bindgen_parameters next to
> > ARCH_KMALLOC_MINALIGN to avoid this error. This ensures that only the
> > version from bindings_helper.h is generated.
>
> As in
>
> --block-list-item <VM_blah> for every flag?

Yes.

Alice


Return-Path: <linux-fsdevel+bounces-73509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD6D1B0EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0809F30383AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492136D4F5;
	Tue, 13 Jan 2026 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6AQi4f4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1C36BCD2
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332688; cv=none; b=RS6PCx8x2GvOOHkynl22Q8iTmcHsc0SdxYv7e0DAi3XuxiCndzrprFQH9I98oxJKseR/cB7SJX1tMOT24ioJaaWONsilzDSu+xzBzIrrKZhIUZt00nfMfVdC3XCn1CnXxyTQkuaUaHP4GCRmPBy2Cxt/FNgoMlr0xsEQhRDNfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332688; c=relaxed/simple;
	bh=bpglvmPPezJCgiUE6xLigLk8EJ5tu/n5B3woSgkck2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBP5usADCpsUHsayq73uQJjimieEx4YsWMMkRa8swpre03pybXEd9sFw9RMKVWKT1onIUqEEizMHHy3E5FwfTh4kCICw3ba5IJzD7qZDLzue/7gApxTemHrnJxjJvYraMFWigoLyIChcGCP3R0XJbH43du8NN+X1THeII5XEkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6AQi4f4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc305914so5620704f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 11:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768332685; x=1768937485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8NmhJSqiWlvWOSbMuKunlzIFlo/O2hOznQMiuzwn84=;
        b=b6AQi4f4IsLV7fxMGNF1JaIlAiu0hXoh0/KMVtPDb2Sb24WE5ELZgJR+rbFAomrVGI
         /uk1ejwgwCNBDVlmr+Vd4X5jqmj9IGRlP6R4b6W6tlkoF29vfZ0lc19apvHzCgSNoc5n
         RaTrKtJRo2w64Am4a/ZplZVPrCjUkMm4s+QOO2n0ndX8kZIKpN982FfYqhBZBRXp7XTy
         a23n/tqfyJZKCUsqt8/xWF6uy4MY9QRB8+hHOcZOmkEK9oGF5B1aeiGhebkJBby2XIQz
         AdtFKw563eeMy+6RPG1uHmgFqQu1a4Vgf+ijYx+FF4SyTqSTyqJ0ElKMoo7AFCu5/X+S
         mAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332685; x=1768937485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8NmhJSqiWlvWOSbMuKunlzIFlo/O2hOznQMiuzwn84=;
        b=EMtgqIGoKLR0OGx/WyUz3sB+yEEhzp2ZYlAt+/85Zzdm3TUmVNOvQX3pLtNvDcA+Hf
         x+pbHLoVkNN5Taqra378k/pc4lGwAViSRC/hQ9YMQfZecvHU0ZcCNpMmyiU7+iqQSJ6J
         hta1Vef1yhNVW8UEwGddFd0oJrWhbxnqtOEN3cOle18uRfC96RXuDFlKHcT5MqhmIq/j
         5V3p/ilNmJpF1moBVTzYwEGQ/N3hi3fnGetWi7wwlf4sQzi3oRi0VgMjVinCZNjQQkpt
         RaTTA5kIGR1YVoOUSvjulP/2TzxtODMf0bkhbgALIESujqGm3bCq06nQLQfhC2I/8ZUG
         hExA==
X-Forwarded-Encrypted: i=1; AJvYcCWGy2rbKPEa88S0X6MQsxvRVpZRQMocAnxcYqqBrtgZnVCELEkBu/xRzlEQIKe0+jVqdOUWNW9SXKu1Yi0k@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLxVVuTAD84iU9yw3Ln02Ak7lg7MPABVo9ExFJmr5dWtQ0mv0
	sW9kUbUhXD4zAIFDm7xzdYwfwyaJ0pfsbGXUQ0pUbk7SgdlB2G9qwR56pY5R9XyJlCpAR9ZFzGc
	w6lW/t52Rs6A+aRehblbYPQFmdb4FddQghMR4MAJJ
X-Gm-Gg: AY/fxX5mgIL5EWDSSCfa6u6VZqi2bloAIOsCXrlmK0LL9npKbjtldGidfIlSIBrxBuk
	SDZXyE6T40jJ2DIS5kEsgb4oXX2Tr0aG9/Xkx9uGQUyNG8eIpEZHA1YYrF3nT/kB6zAlM8fY5YS
	e8lhBcmoYFnkSceBKJFcQ3+8DvO72OzVLOS6nBPzag4RL5oPgmimW8wf3LK7tXBrKO5IROIm8Xb
	coZqAgI09jfjBLvtPRo00tO7zXqn5Y3AydS0eunl2ZS00+P2CnpUHwD8saW8bn1xwSYtiyUBs+U
	O4kc12n/h8UiWEqdB1btK2Zi7/hcedhc1V3E
X-Received: by 2002:a05:6000:1843:b0:42f:bad7:af76 with SMTP id
 ffacd0b85a97d-4342c5011ecmr58277f8f.15.1768332684204; Tue, 13 Jan 2026
 11:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a35e5a0bcfa00e84af24cbafc0653e74deda64a.1764064556.git.lorenzo.stoakes@oracle.com>
 <20260113185142.254821-1-clm@meta.com> <CAH5fLgidETM3aSVvLRxnA4oaaYWH_KN+qGMkQQf_GpWsjHkpXw@mail.gmail.com>
 <070b76bf-0d18-450c-a1a1-29f3a8b4925a@lucifer.local>
In-Reply-To: <070b76bf-0d18-450c-a1a1-29f3a8b4925a@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 13 Jan 2026 20:31:11 +0100
X-Gm-Features: AZwV_Qi6YpsOIS766x38_eMGva8u3MAQ2J7-LTNUdm_KuxBa4ITTN06VU3-8A0Y
Message-ID: <CAH5fLggUzj532WOuHjx0Uz97eiRVSpJ-xtCwiP6h1g_Rg3WoPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: declare VMA flags by bit
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>, 
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

On Tue, Jan 13, 2026 at 8:14=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Jan 13, 2026 at 08:02:17PM +0100, Alice Ryhl wrote:
> > On Tue, Jan 13, 2026 at 7:52=E2=80=AFPM Chris Mason <clm@meta.com> wrot=
e:
> > >
> > > On Tue, 25 Nov 2025 10:00:59 +0000 Lorenzo Stoakes <lorenzo.stoakes@o=
racle.com> wrote:
> > >
> > > [ ... ]
> > > >
> > > > Finally, we update the rust binding helper as now it cannot auto-de=
tect the
> > > > flags at all.
> > > >
> > >
> > > I did a run of all the MM commits from 6.18 to today's linus, and thi=
s one
> > > had a copy/paste error.   I'd normally just send a patch for this, bu=
t in
> > > terms of showing the review output:
> > >
> > > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindin=
gs_helper.h
> > > > index 2e43c66635a2c..4c327db01ca03 100644
> > > > --- a/rust/bindings/bindings_helper.h
> > > > +++ b/rust/bindings/bindings_helper.h
> > > > @@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT =
=3D XA_PRESENT;
> > >
> > > [ ... ]
> > >
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD =3D VM_MAYREAD;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE =3D VM_MAYWRITE;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC =3D VM_MAYEXEC;
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE =3D VM_MAYEXEC;
> > >                                                    ^^^^^^^^^^
> > >
> > > Should this be VM_MAYSHARE instead of VM_MAYEXEC? This appears to be =
a
> > > copy-paste error that would cause Rust code using VmFlags::MAYSHARE t=
o
> > > get bit 6 (VM_MAYEXEC) instead of bit 7 (VM_MAYSHARE).
> > >
> > > The pattern of the preceding lines shows each constant should referen=
ce
> > > its matching flag:
> > >
> > >     RUST_CONST_HELPER_VM_MAYREAD  =3D VM_MAYREAD
> > >     RUST_CONST_HELPER_VM_MAYWRITE =3D VM_MAYWRITE
> > >     RUST_CONST_HELPER_VM_MAYEXEC  =3D VM_MAYEXEC
> > >     RUST_CONST_HELPER_VM_MAYSHARE =3D VM_MAYSHARE  <- expected
> > >
> > > > +const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP =3D VM_PFNMAP;
> >
> > Uh, good catch. Do you want to send a fix patch?
>
> It's in 6.18 so would need to be a Cc: stable patch with a Fixes etc. rat=
her
> than a fix-patch, unless that's what you meant?

That's what I meant, yeah.

Alice


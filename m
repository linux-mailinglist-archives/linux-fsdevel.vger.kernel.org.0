Return-Path: <linux-fsdevel+bounces-54762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC4B02C44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597057B5CB7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5DB28A727;
	Sat, 12 Jul 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BqRr21UL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F263D994
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752342814; cv=none; b=hyeTLymxq4znQQC0Fe3AED0ghSWlf8XMFHmFxqx3yV187imbNV01iAz/hQzTMjHKXHZwWzYOi+UpSwGLSxOPmruMRSKGPotvcEX/yBcIeWWYhpcDzcLzxsJ49ftm5IY56If40Ru7hXD/APWx13bGRty8/lcGWyBjafT4ygViGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752342814; c=relaxed/simple;
	bh=+1/Vlrp3LRvVrxvdxBs0B2p6QwaoTvL2sUXR6QBqiJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPU1d1boNqoO3bGek8CpGCQtbgu14JjozvwFx3dtIbUNEBCg2GHDu2BHwgt1EGU4KZ1n/7mVfapIOK9y10yMsfF5xrQD/JzMoBB0uf7y9HBz8AUyAnEqF78ldHAquP8VjEGOQyvHMCSO4ES7t4VaD/x/+HVLQaXmYlEbIT102rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BqRr21UL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e389599fso144855ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752342812; x=1752947612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1/Vlrp3LRvVrxvdxBs0B2p6QwaoTvL2sUXR6QBqiJY=;
        b=BqRr21UL8FUpCt8g2BHwEo9wfPQrsecWgEyMdzcoQ+TFlY1I57KlbqZqYaS0HQ03IM
         FcioCNU4/3j7OjnR4m5PiRBi7RQZubBGXYoRj+pR6R66HFQ0Ek4wguXF7hleWcMqBWpK
         JKZnvFwNXRT3yl1bMw2p4FmGnJusNouPpsoa7gM1VD+THklId16yTsbwOf1ySq2qJnU4
         uli4ghqoZPQUhONBhaAD6l52bE+RKu+oHAKfIMO5EwbAHfM0qFqMFtn3c4UouBjFXY6g
         26FiDLAAXp50Vrx+xq8ObBKxvi5pcHFPtDTdXFnydW1Cx8sHleXA+r0ZWQvhx0yBZqI9
         sJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752342812; x=1752947612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1/Vlrp3LRvVrxvdxBs0B2p6QwaoTvL2sUXR6QBqiJY=;
        b=tLjsPKi8m1L6kfHUIqJ+nokaXuLdJiypx8kW4LQfvf6pgj1ABvO5WMWrLyj608vWS5
         AadlElwEQSkcj77Od6RKN2/IF+TKJ8uNoBJMzOJGtBMqeYp44lM9T4Zvn5AqHwnuOwBM
         GzJWbNQfBrYs4Nw1peC0oRkVjoQdU3vRJbt8W5A5+9DZJQIyREjU3GoqNmbYXGVXERPE
         3qJKV347BUBE08H6c/66pPXT1viKcsCxmF8etoGuRrRpmxSj/z3QkBQ97LQRJAjATKVg
         IqMx9NIvsuN8rHp204x1eG0FeMoyrlyOgPgTOK97xSYKsh1n8M9OEFbMVN6do8PujQx6
         svvA==
X-Forwarded-Encrypted: i=1; AJvYcCXi2O2hMRiqRLOdb8LOT1jG7COtPxbZZBvcHc9Cdit6CEqzQuL231FKtzwGOHSsbLxuHq9Ykwu4rTs3fWo/@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdTYTrq9KBfJTbb8idruR/e/DTrI7yBnKOFhtxoifnxfwROGq
	87QufPq5UTc3hC0D0sEbXyk6Ryu/dN2OPgAwtPYnlFIfRVRndOULNn/ymbTb0kREsk2aKxov7Ic
	peoYZzsvoghOWqa+nkVMNKyKmXkpL9Ibo2OfX6HCy
X-Gm-Gg: ASbGncvGWs1vSv87W3DORliX2jCoeTf6ASxrrnaOt1yiut1sKG3ndG5Ltw+psQeWVq/
	O4M1xpK/+PGC5kublDw8zIgWNpo+q4B964tt38cy2HaaxKXtKXC97z8Ta5w+VBcz2l9wCiKIYCo
	/gFFd/NH/KPLujIwqCwIpw3j8F9pwCd/SLUtxbtAbZCUmgn9cT6Ws3o3Ol7rRFFNHgOqUJWOmJX
	nqCF28sB4axPvSx69LWDrQBkk1Q8MNCcJJm1TEq
X-Google-Smtp-Source: AGHT+IGXZjTxB3NipN6zL4wxoHLscGMTCymyrebDMnTbZldyzqeNacRyryboTJLi0nmJu4tdqjI5M8LT+EiWQEHNhyg=
X-Received: by 2002:a17:903:8cb:b0:216:48d4:b3a8 with SMTP id
 d9443c01a7336-23df6985bd5mr1838155ad.16.1752342811290; Sat, 12 Jul 2025
 10:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com> <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
 <20250702232517.k2nqwggxfpfp3yym@amd.com> <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
 <20250703041210.uc4ygp4clqw2h6yd@amd.com> <CAGtprH9sckYupyU12+nK-ySJjkTgddHmBzrq_4P1Gemck5TGOQ@mail.gmail.com>
 <20250703203944.lhpyzu7elgqmplkl@amd.com> <CAGtprH9_zS=QMW9y8krZ5Hq5jTL3Y9v0iVxxUY2+vSe9Mz83Tw@mail.gmail.com>
 <20250712001055.3in2lnjz6zljydq2@amd.com>
In-Reply-To: <20250712001055.3in2lnjz6zljydq2@amd.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sat, 12 Jul 2025 10:53:17 -0700
X-Gm-Features: Ac12FXzBIe6hc0vRvgKfa9hTZJEZVmuxsY2_E0PJwlI__Cgm8PredUOA4GmiwtU
Message-ID: <CAGtprH-fSW219J3gxD3UFLKhSvBj-kqUDezRXPFqTjj90po_xQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
To: Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com, 
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 5:11=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> >
> > Wishful thinking on my part: It would be great to figure out a way to
> > promote these pagetable entries without relying on the guest, if
> > possible with ABI updates, as I think the host should have some
> > control over EPT/NPT granularities even for Confidential VMs. Along
>
> I'm not sure how much it would buy us. For example, for a 2MB hugetlb
> SNP guest boot with 16GB of memory I see 622 2MB hugepages getting
> split, but only about 30 or so of those get merged back to 2MB folios
> during guest run-time. These are presumably the set of 2MB regions we
> could promote back up, but it's not much given that we wouldn't expect
> that value to grow proportionally for larger guests: it's really
> separate things like the number of vCPUs (for shared GHCB pages), number
> of virtio buffers, etc. that end up determining the upper bound on how
> many pages might get split due to 4K private->shared conversion, and
> these would vary all that much from get to get outside maybe vCPU
> count.
>
> For 1GB hugetlb I see about 6 1GB pages get split, and only 2 get merged
> during run-time and would be candidates for promotion.
>

Thanks for the great analysis here. I think we will need to repeat
such analysis for other scenarios such as usage with accelerators.

> This could be greatly improved from the guest side by using
> higher-order allocations to create pools of shared memory that could
> then be used to reduce the number of splits caused by doing
> private->shared conversions on random ranges of malloc'd memory,
> and this could be done even without special promotion support on the
> host for pretty much the entirety of guest memory. The idea there would
> be to just making optimized guests avoid the splits completely, rather
> than relying on the limited subset that hardware can optimize without
> guest cooperation.

Yes, it would be great to improve the situation from the guest side,
e.g. I tried with a rough draft [1], the conclusion there was that we
need to set aside "enough" guest memory as CMA to cause all the DMA go
through 2M aligned buffers. It's hard to figure out how much is
"enough", but we could start somewhere. That being said, the host
still has to manage memory this way by splitting/merging at runtime
because I don't think it's possible to enforce all conversions to
happen at 2M (or any at 1G) granularity. So it's also very likely that
even if guests do significant chunk of conversions at hugepage
granularity, host still needs to split pages all the way to 4K for all
shared regions unless we can bake another restriction in the
conversion ABI that guests can only convert the same ranges to private
as were converted before to shared.

[1] https://lore.kernel.org/lkml/20240112055251.36101-1-vannapurve@google.c=
om/

>
> > the similar lines, it would be great to have "page struct"-less memory
> > working for Confidential VMs, which should greatly reduce the toil
> > with merge/split operations and will render the conversions mostly to
> > be pagetable manipulations.
>
> FWIW, I did some profiling of split/merge vs. overall conversion time
> (by that I mean all cycles spent within kvm_gmem_convert_execute_work()),
> and while split/merge does take quite a few more cycles than your
> average conversion operation (~100x more), the total cycles spent
> splitting/merging ended up being about 7% of the total cycles spent
> handling conversions (1043938460 cycles in this case).
>
> For 1GB, a split/merge take >1000x more than a normal conversion
> operation (46475980 cycles vs 320 in this sample), but it's probably
> still not too bad vs the overall conversion path, and as mentioned above
> it only happens about 6x for 16GB SNP guest so I don't think split/merge
> overhead is a huge deal for current guests, especially if we work toward
> optimizing guest-side usage of shared memory in the future. (There is
> potential for this to crater performance for a very poorly-optimized
> guest however but I think the guest should bear some burden for that
> sort of thing: e.g. flipping the same page back-and-forth between
> shared/private vs. caching it for continued usage as shared page in the
> guest driver path isn't something we should put too much effort into
> optimizing.)
>

As per discussions in the past, guest_memfd private pages are simply
only managed by guest_memfd. We don't need and effectively don't want
the kernel to manage guest private memory. So effectively we can get
rid of page structs in theory just for private pages as well and
allocate page structs only for shared memory on conversion and
deallocate on conversion back to private.

And when we have base core-mm allocators that hand out raw pfns to
start with, we don't even need shared memory ranges to be backed by
page structs.

Few hurdles we need to cross:
1) Invent a new filemap equivalent that maps guest_memfd offsets to pfns
2) Modify TDX EPT management to work with pfns and not page structs
3) Modify generic KVM NPT/EPT management logic to work with pfns and
not rely on page structs
4) Modify memory error/hwpoison handling to route all memory errors on
such pfns to guest_memfd.

I believe there are obvious benefits (reduced complexity, reduced
memory footprint etc) if we go this route and we are very likely to go
this route for future usecases even if we decide to live with
conversion costs today.


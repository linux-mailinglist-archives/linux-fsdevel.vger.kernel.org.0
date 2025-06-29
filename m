Return-Path: <linux-fsdevel+bounces-53235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E7DAECF91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF3216E6CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061C0239573;
	Sun, 29 Jun 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxXS9YGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03DC23771C
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jun 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751221719; cv=none; b=HBZm3wmIhbxj4Mj7uDfAMaHAfHorzhCmRb8z15DAo3nLnT3XF3jAt2euCLTIcb+Y9T7Dm61oM/mNzMMZYqtf8jtEghe6G1cWdiulmealqzVkHgIDAvjKlSnAGssZeZnB1/r/mwGRSSPEPTLcg+SMNBoyU/nJhn+nqvunWwmDVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751221719; c=relaxed/simple;
	bh=l0ew/rNxvpqXTq4nv93IRDOxuX6/hTc/lyPn4AugHqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oi7+PItq6+uNozbM+ZU94KIVsksYvgzCxf2gE2jrhWqmoLxfmNFD7JLw/Xdim2Ke7nMnXjJ+/10SBN4kJ5nvI4JWB5bvTU6hhIL9taDAMLMdjJha1nIl9Crmlt9oajK1NTTgwVqH0rsdSCCmj2mY06B+TzMnq+7E8QfM0VJoIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxXS9YGg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e389599fso190195ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jun 2025 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751221716; x=1751826516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1l9JIPjHLpLWpV87RrF/MILzYtSbQffXmt07qUOMzw=;
        b=JxXS9YGgSAu4i7johcgfPrXRvZyZs6EHCky5iiUutCuFIJcPBMjn/wnBGQgwTMM5f2
         a/WBG68xvgkrSNPuZL1rVdfq2MNNPJNH5Oqbpt30t9fLMMWzr4JkZpKJmHCGRB/A/LoD
         LgS+G/cu+rDOy2KHgA6yS7gZ7BP1t3s0dPl/TQQBL6CUaZYpw6/m4ablT6D4O/caVcYw
         OXYmJsVn/i+4ZDsKFJcwyXu/xqPogfy9ugbX43LyAvWZIFrk2vmph8CW3wW5BMBk4Hdj
         nrAgVWsdkxP+xIFWsnICSnq4F/aQWttDL+Zup3va2TVkuw65Q1xOXmUHXqPGT33Ffwxz
         ZJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751221716; x=1751826516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1l9JIPjHLpLWpV87RrF/MILzYtSbQffXmt07qUOMzw=;
        b=Ekh2F78Hd+MegxXpbeDCL4B/6dvAUeR6LOA3eTzry8MBxo+siBEsqikMfu+TC3S0iI
         dxtCzWQiRFs7ZDj9G84uzUbaNQ3GDtZ8YEhCJpZppgon9VcSLDTsA7sirI8zmjTP+vxk
         OMK54L3KrbVUkgFeM3vxczUmDh//5CEbW2vIp8UWJ2R72A0B9mkl8cdRSfbRa5/4vAdr
         sWGfwypF8GCq6bkgmRHLf/ihhdi9IZpYgd9XAy8JVaq6ilHcGO6X8KLq3lfa3B1dyWkd
         sj7khs/8PLNtgyuAWP83YP7wChAVPZNUQE+0Y9warcGzhghTurhyKykz56IQf+Vp5TxZ
         EAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy93EioefipkLJWq/wV+7E4n45QfPbqHm492G2yY6NpFdxYxiUTR4Ytuu9yJGmD085ZoXScOCaN/xSRPaX@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmEFyxukUPd41jmxpyH5ThkG31vT/Ee/j+ujcJmYvoTcEch18
	7nOFgmTneCwZwaPtCBfA0O/pGNa83UxYIDHOmMxEtpdgmwHDaco1H0HyIUN/M6ZHv/aNoJxFUT2
	8mYaSrtGvbfFd7q164GOzJeEdffifWOeyhrsWOkz7
X-Gm-Gg: ASbGncvHmM4SoVOCx1yiayVHhiIrHjae/Bb9owHP0E9VM8D6sEVUMQGIuOGxIE4Vlk7
	Q0KpxEFbyX8z5WFrwDEjTW/wmKu2cYe4aP99VCEQl00T7vyAPiDjjQ/Mhtx+CsFlZr0hzJz114Y
	8bmGQQTyjSAlKRH5qrzIJE3ZGYAKLko+S0L8RaeSFKloTJdGCCvOOrFNAvNJf+TM1TA3f9Mf04n
	CEd
X-Google-Smtp-Source: AGHT+IHdVA75hLFFAdHVzvO4EeTa+FUWamKY84vMMfGu7CzFa8alTxmn/cBaHHTKvAmeb6d7cowOhMdsvEuUdRooiZc=
X-Received: by 2002:a17:902:e84a:b0:234:bca7:2934 with SMTP id
 d9443c01a7336-23ae8e8bdffmr3053245ad.6.1751221715515; Sun, 29 Jun 2025
 11:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <aFPGlAGEPzxlxM5g@yzhao56-desk.sh.intel.com>
 <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
In-Reply-To: <d15bfdc8-e309-4041-b4c7-e8c3cdf78b26@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sun, 29 Jun 2025 11:28:22 -0700
X-Gm-Features: Ac12FXwYsllFJOo6Hodgf2pKamvDOx3QsF86HEiXlTZ2qWaN29U0KjYTlrTOQmg
Message-ID: <CAGtprH-Kzn2kOGZ4JuNtUT53Hugw64M-_XMmhz_gCiDS6BAFtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-fsdevel@vger.kernel.org, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 1:59=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> On 6/19/2025 4:13 PM, Yan Zhao wrote:
> > On Wed, May 14, 2025 at 04:41:39PM -0700, Ackerley Tng wrote:
> >> Hello,
> >>
> >> This patchset builds upon discussion at LPC 2024 and many guest_memfd
> >> upstream calls to provide 1G page support for guest_memfd by taking
> >> pages from HugeTLB.
> >>
> >> This patchset is based on Linux v6.15-rc6, and requires the mmap suppo=
rt
> >> for guest_memfd patchset (Thanks Fuad!) [1].
> >>
> >> For ease of testing, this series is also available, stitched together,
> >> at https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-supp=
ort-rfc-v2
> >
> > Just to record a found issue -- not one that must be fixed.
> >
> > In TDX, the initial memory region is added as private memory during TD'=
s build
> > time, with its initial content copied from source pages in shared memor=
y.
> > The copy operation requires simultaneous access to both shared source m=
emory
> > and private target memory.
> >
> > Therefore, userspace cannot store the initial content in shared memory =
at the
> > mmap-ed VA of a guest_memfd that performs in-place conversion between s=
hared and
> > private memory. This is because the guest_memfd will first unmap a PFN =
in shared
> > page tables and then check for any extra refcount held for the shared P=
FN before
> > converting it to private.
>
> I have an idea.
>
> If I understand correctly, the KVM_GMEM_CONVERT_PRIVATE of in-place
> conversion unmap the PFN in shared page tables while keeping the content
> of the page unchanged, right?

That's correct.

>
> So KVM_GMEM_CONVERT_PRIVATE can be used to initialize the private memory
> actually for non-CoCo case actually, that userspace first mmap() it and
> ensure it's shared and writes the initial content to it, after it
> userspace convert it to private with KVM_GMEM_CONVERT_PRIVATE.

I think you mean pKVM by non-coco VMs that care about private memory.
Yes, initial memory regions can start as shared which userspace can
populate and then convert the ranges to private.

>
> For CoCo case, like TDX, it can hook to KVM_GMEM_CONVERT_PRIVATE if it
> wants the private memory to be initialized with initial content, and
> just do in-place TDH.PAGE.ADD in the hook.

I think this scheme will be cleaner:
1) Userspace marks the guest_memfd ranges corresponding to initial
payload as shared.
2) Userspace mmaps and populates the ranges.
3) Userspace converts those guest_memfd ranges to private.
4) For both SNP and TDX, userspace continues to invoke corresponding
initial payload preparation operations via existing KVM ioctls e.g.
KVM_SEV_SNP_LAUNCH_UPDATE/KVM_TDX_INIT_MEM_REGION.
   - SNP/TDX KVM logic fetches the right pfns for the target gfns
using the normal paths supported by KVM and passes those pfns directly
to the right trusted module to initialize the "encrypted" memory
contents.
       - Avoiding any GUP or memcpy from source addresses.

i.e. for TDX VMs, KVM_TDX_INIT_MEM_REGION still does the in-place TDH.PAGE.=
ADD.

Since we need to support VMs that will/won't use in-place conversion,
I think operations like KVM_TDX_INIT_MEM_REGION can introduce explicit
flags to allow userspace to indicate whether to assume in-place
conversion or not. Maybe
kvm_tdx_init_mem_region.source_addr/kvm_sev_snp_launch_update.uaddr
can be null in the scenarios where in-place conversion is used.


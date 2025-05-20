Return-Path: <linux-fsdevel+bounces-49503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3979FABD8BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D918896F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C071E22D7A8;
	Tue, 20 May 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGX3rd49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56022CBE8
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746143; cv=none; b=fR3AXaKjEbSyMkVwt2ZGLTo7F80rALBI3jijj38/Fgx+SF+C0UTPicoTGj10VKeOXTQuM5mit6O89kp8lTqAlJ/4RYpehskeZKDAs3hKyFUuN4HI29rebglLvwBGmt1hcy87FPZfZgUAe0GDYvO1eppRjGyFl/NovznQyOnQNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746143; c=relaxed/simple;
	bh=Szc2Bu+IbxSEL3yt3pLQjE2rd6R91vDAuTQXabgWV/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeWVGxBWdcerpM4t6nn3clI19qtCrPgyQ0jNwdW2lFVGw41QyClLlPeWfYY1saWUP94QFuJb8f7X/fYHvOEsfLLWx0aNPPNsxoBOjp4uJx54MBeYypsDPNC5c9R+wPzuwHuaSZQqyTe+PuIs1BkCBZxPTVS9avH+O5eDo0xvFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGX3rd49; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231ba6da557so523365ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747746140; x=1748350940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G51NjueMtgwdkSkAq4nxlm82fg57frn9bjK0YUuFTbY=;
        b=jGX3rd49MakNMRNT2ylEsZ/AepcUOTcHmlTBBFkey7JQW3EegFn4PMDBrxTdOqTuJi
         U7etRMPG4Ab3zyk9IaysBCh+wfknbro7fvEa896ZTTlLTEF8n2+X6oIf/IgmjVDgD0fC
         BDPvlCoMnfnZZedfzRjlYN0paYYU5i8cChilf8LtU7bqUvU/A9f0g1RfAYzbyaPFzCM5
         bVA6M7v1c4KdwsoQtgTWMy35Deb9SZu3Sw2gVleH6my2BfOpSZlsnzIx6e4kdh/8o7bi
         K0hl7KuD3KTKYtbrp5PqtVSBAqA98XY65vMJR+BX92dYoOlIMpw2IEK1zp/R2xHc3MJe
         5caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746140; x=1748350940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G51NjueMtgwdkSkAq4nxlm82fg57frn9bjK0YUuFTbY=;
        b=hvlxoqWMGFA72Tax4QcyAKd36iHHNZqaXn+c4hphX02dFjNS55owjeiksO7yav/bmj
         M0NzfXvAPVYKnXVoq983nBi9SoW/H+9zHvx59jCyInjG0yDn5xDMpuUCnAN6vsVf04XV
         YaxCsYPt7Ni32+1/KX3XEyzsBMbOjRnCybnl9yIAhKnr29KToiN+DGNOv6JS2C67W6yz
         PZ5pEYGNexu1pRO7p2BGl5n+gLVU7Z3Wdlbj+aNbs9ycbEWVWshIJbXWZBi3VCUg9gGz
         x+u4GaTw2zrH2ykwpC5FWZTtV7s45ydJ+WZFfGOrDufF281eAQ4AV7RUu3hQb4NaHOZd
         TFsg==
X-Forwarded-Encrypted: i=1; AJvYcCU3JHOuWranr0e+71h6ZhjuXXNUUBuZ3D7KAIQqqezGbHSkq8gSamjmMTcyFV7/8FdEuxYdkiiExt7ETMSy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy50tVOw60SM7LpR5t3OAjmjmTqTH/+mWlE2Aec1OfMih0aN30I
	uD6K+eBwtKeW6dGRo2UroXKFNbLNawfB8amXf7q+PgA20GeiXJW8vbr3F9rmLhjPRX9UqcAPW2I
	zfMxwhxmPSb4zQpu99Nt4Y2AqoKtUuj61CbwtOSzz
X-Gm-Gg: ASbGncvXqCNaEJVcWGayYmvDZ8VIa42a2PFQq49HGU8tCFPHab/oMIn18vxLX1fTnHW
	ndcIXzE2/+FPiBarruxuhqLnyGFDrNjR41N4yyZPt99QT6Xt0MzB102s9aFkl5peLA265XrCW6o
	1kQjkQobef0Afgqzqxo+VbPdEyKsjuTzsVL2LQ5S0GpzhiXLBHUV/jQ1Of+xlehRTrkFHmHq6fW
	UvE
X-Google-Smtp-Source: AGHT+IENsMjdA7e7SkDhYjjQmP6hDXAt2xKgihGIflXdn8EzSlt5WSL+7YEji7uYL6DeVUvbwnXXwaz9JyzL1XUjkKA=
X-Received: by 2002:a17:902:cecd:b0:231:d7cf:cf18 with SMTP id
 d9443c01a7336-23203eee503mr7578955ad.1.1747746139014; Tue, 20 May 2025
 06:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
In-Reply-To: <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 20 May 2025 06:02:06 -0700
X-Gm-Features: AX0GCFsldswygKR-GoZQ5DpCzbCzOo98e7cVAofAkIc30PsIDhwcqCcCF6oRMqo
Message-ID: <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Fuad Tabba <tabba@google.com>
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
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 2:23=E2=80=AFAM Fuad Tabba <tabba@google.com> wrote=
:
>
> Hi Ackerley,
>
> On Thu, 15 May 2025 at 00:43, Ackerley Tng <ackerleytng@google.com> wrote=
:
> >
> > The two new guest_memfd ioctls KVM_GMEM_CONVERT_SHARED and
> > KVM_GMEM_CONVERT_PRIVATE convert the requested memory ranges to shared
> > and private respectively.
>
> I have a high level question about this particular patch and this
> approach for conversion: why do we need IOCTLs to manage conversion
> between private and shared?
>
> In the presentations I gave at LPC [1, 2], and in my latest patch
> series that performs in-place conversion [3] and the associated (by
> now outdated) state diagram [4], I didn't see the need to have a
> userspace-facing interface to manage that. KVM has all the information
> it needs to handle conversions, which are triggered by the guest. To
> me this seems like it adds additional complexity, as well as a user
> facing interface that we would need to maintain.
>
> There are various ways we could handle conversion without explicit
> interference from userspace. What I had in mind is the following (as
> an example, details can vary according to VM type). I will use use the
> case of conversion from shared to private because that is the more
> complicated (interesting) case:
>
> - Guest issues a hypercall to request that a shared folio become private.
>
> - The hypervisor receives the call, and passes it to KVM.
>
> - KVM unmaps the folio from the guest stage-2 (EPT I think in x86
> parlance), and unmaps it from the host. The host however, could still
> have references (e.g., GUP).
>
> - KVM exits to the host (hypervisor call exit), with the information
> that the folio has been unshared from it.
>
> - A well behaving host would now get rid of all of its references
> (e.g., release GUPs), perform a VCPU run, and the guest continues
> running as normal. I expect this to be the common case.
>
> But to handle the more interesting situation, let's say that the host
> doesn't do it immediately, and for some reason it holds on to some
> references to that folio.
>
> - Even if that's the case, the guest can still run *. If the guest
> tries to access the folio, KVM detects that access when it tries to
> fault it into the guest, sees that the host still has references to
> that folio, and exits back to the host with a memory fault exit. At
> this point, the VCPU that has tried to fault in that particular folio
> cannot continue running as long as it cannot fault in that folio.

Are you talking about the following scheme?
1) guest_memfd checks shareability on each get pfn and if there is a
mismatch exit to the host.
2) host user space has to guess whether it's a pending refcount or
whether it's an actual mismatch.
3) guest_memfd will maintain a third state
"pending_private_conversion" or equivalent which will transition to
private upon the last refcount drop of each page.

If conversion is triggered by userspace (in case of pKVM, it will be
triggered from within the KVM (?)):
* Conversion will just fail if there are extra refcounts and userspace
can try to get rid of extra refcounts on the range while it has enough
context without hitting any ambiguity with memory fault exit.
* guest_memfd will not have to deal with this extra state from 3 above
and overall guest_memfd conversion handling becomes relatively
simpler.

Note that for x86 CoCo cases, memory conversion is already triggered
by userspace using KVM ioctl, this series is proposing to use
guest_memfd ioctl to do the same.
 - Allows not having to keep track of separate shared/private range
information in KVM.
 - Simpler handling of the conversion process done per guest_memfd
rather than for full range.
     - Userspace can handle the rollback as needed, simplifying error
handling in guest_memfd.
 - guest_memfd is single source of truth and notifies the users of
shareability change.
     - e.g. IOMMU, userspace, KVM MMU all can be registered for
getting notifications from guest_memfd directly and will get notified
for invalidation upon shareability attribute updates.


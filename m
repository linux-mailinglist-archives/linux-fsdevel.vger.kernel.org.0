Return-Path: <linux-fsdevel+bounces-49533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75289ABDFE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E535A3BC433
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AEC26AA9E;
	Tue, 20 May 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3Te78t5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A94263C6A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756985; cv=none; b=rPYE4oSLAFP7eTu1bp2pX4CQjM9KQByRHT5iPOYwA3tvYzpRVhFA0ZXNfXYMGQo6oGS8oc2sgKB482wFDG2lVknhJmPy3c267kTOQDnx/b9Mquk6QPoPxh58hCMjDyegBU6N/5Zx6ZurYmRqvWof2nfvNgjH4lBKZOAzVXXwxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756985; c=relaxed/simple;
	bh=FGGVtwJI+rk7bDClnSBYqIzTUVaLE5OUyLIc/e73RHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PG6pgQaMh2+11z588w8sRehZuOcLASCt10LnaJvHew+wKEqsBvktUrl8pLTcT8W0aycE+Z2oBn3R3pt3nV0gksGjxqK4d/sFZH4dL0h2WYfrxsgEhx/ZOeNMaX1DIchcG29k2BqXMezt8+abVzivK/Bsl39Xff2oo9fNF5P93ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3Te78t5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231f61dc510so785515ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747756983; x=1748361783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP+IgKh5WuP7/61GoXCSgoWlxqk6ttGptinEY/thQH0=;
        b=C3Te78t5grg/IDGvwV4ObABC7Hh1KU/U2gtZMO6Y8XLWaa67vjUX2vXM3XTybfIlfF
         9wmKijKk9t6AqXPbQ/OtSiOYyDobckZOSf2Xdgv3PRCtM43yrTLLtvxf2sCwsAP3jqgx
         8eXDgagmqd+I38MKinGv8rWREeTxoOJdxPFlWDXb/kxqDGNpQX8SOrbuoNZCcF7jbuuy
         th1JjRCFmM8LwUsTaFVtUB0Sx555YM1QFpu3GJWl3x1Olz1kBxvvFwPFhNc5hZvu7o56
         x/p5W9FdwKVl9Bjb9NJDcn0ZFbqrS8+E7e8NwmzWzBQhM4CMx22J56RKNQ+X0Hm6FZrw
         +NGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747756983; x=1748361783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP+IgKh5WuP7/61GoXCSgoWlxqk6ttGptinEY/thQH0=;
        b=YPxL7ivCGXI8JWdYiyNYKb1ObZdbOQuqxhjCpgupGWyCMKjEMVYCWP2dakQJ9QAu5J
         J2kKcemIDtf7JJg5cs03WEGlmRCZ0kS8Ny2dHL/zZWhLf0yRZjwlzpkcWQlbSdVatvTs
         tnk+op6SiHHRmOQLcDt4Le1cqVEw7DMjUufFUJvBbe7/HoavvQGTnWk4uvmqcoMbTgQo
         rjZuDC35OBhTz/jsbo8kYlxrIY8LBe8OTlbc1cf7qll4Je4YkOyZ8VD515jSEexwgaPb
         NRdjL+66nGZwlNG0h6ypdzraM+hJkKtffwW2tMHrGNEBweT9SuJE8bKNCuBA4gD8y4zM
         W/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU7RrXXZ3LFwfGcjXNPZ689ZMh7zDbX0lPBueYAuMY/XhKjaKhedTrYHk/MnUdxWBvCZ59Lc41ACndSOtdO@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwyrm+dPUZt9HSTTrK591zZASX7eFrXtkOvRrmbefApXvQ/w3
	dhpnQ7gL3U7s185L8GdFFHeWjj3m95kW8LtgYf7ENgET8GT0gvBy/80Kgo+Dc4DnEDQCv9WWeI4
	VFXR7wZ5Pmo16E0+ccxKOezC8pU4N2zaWn687NqQz
X-Gm-Gg: ASbGncv3GZeElfn3P8xVxTCT5AKAyQrUmbqF1Dln6x4VaJ8RjxB2Iw4jaLr62sZoDCc
	rcedLeyWeXgH7zLBa8KPdy7SALu2GZEI18h90Net1CGaNXrk6nut1ditnW8Dh1kaDnIz9UZ/PAn
	Cmsx0ZicyloqJ0KW3E7TcrmwuD3rlP2WyDfwhiiUddHDwMGWSYWp2JE+SRwxIkLlz34yZ3iWyE7
	oso
X-Google-Smtp-Source: AGHT+IHIqS2Dqz8t9Kspjt12t3UanzbX0TZpQnWe3Ht48Uo1xURTRGgrxqIt9Z9aa1RVZDHLDUDlIsXJxb1nUq6AGcg=
X-Received: by 2002:a17:903:4b4f:b0:231:fb83:9c3d with SMTP id
 d9443c01a7336-231ffdc5e60mr8624145ad.20.1747756982425; Tue, 20 May 2025
 09:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com> <CA+EHjTy7iBNBb9DRdtgq8oYmvgykhSNvZL3FrRV4XF90t3XgBg@mail.gmail.com>
In-Reply-To: <CA+EHjTy7iBNBb9DRdtgq8oYmvgykhSNvZL3FrRV4XF90t3XgBg@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 20 May 2025 09:02:50 -0700
X-Gm-Features: AX0GCFsR8m63CkFf_0gOE0SYuixW7eqLNNVHBhmGF8G-ihHN6Drh2TEMsr5J4cg
Message-ID: <CAGtprH_7jSpwF77j1GW8rjSrbtZZ2OW2iGck5=Wk67+VnF9vjQ@mail.gmail.com>
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

On Tue, May 20, 2025 at 7:34=E2=80=AFAM Fuad Tabba <tabba@google.com> wrote=
:
>
> Hi Vishal,
>
> On Tue, 20 May 2025 at 15:11, Vishal Annapurve <vannapurve@google.com> wr=
ote:
> >
> > On Tue, May 20, 2025 at 6:44=E2=80=AFAM Fuad Tabba <tabba@google.com> w=
rote:
> > >
> > > Hi Vishal,
> > >
> > > On Tue, 20 May 2025 at 14:02, Vishal Annapurve <vannapurve@google.com=
> wrote:
> > > >
> > > > On Tue, May 20, 2025 at 2:23=E2=80=AFAM Fuad Tabba <tabba@google.co=
m> wrote:
> > > > >
> > > > > Hi Ackerley,
> > > > >
> > > > > On Thu, 15 May 2025 at 00:43, Ackerley Tng <ackerleytng@google.co=
m> wrote:
> > > > > >
> > > > > > The two new guest_memfd ioctls KVM_GMEM_CONVERT_SHARED and
> > > > > > KVM_GMEM_CONVERT_PRIVATE convert the requested memory ranges to=
 shared
> > > > > > and private respectively.
> > > > >
> > > > > I have a high level question about this particular patch and this
> > > > > approach for conversion: why do we need IOCTLs to manage conversi=
on
> > > > > between private and shared?
> > > > >
> > > > > In the presentations I gave at LPC [1, 2], and in my latest patch
> > > > > series that performs in-place conversion [3] and the associated (=
by
> > > > > now outdated) state diagram [4], I didn't see the need to have a
> > > > > userspace-facing interface to manage that. KVM has all the inform=
ation
> > > > > it needs to handle conversions, which are triggered by the guest.=
 To
> > > > > me this seems like it adds additional complexity, as well as a us=
er
> > > > > facing interface that we would need to maintain.
> > > > >
> > > > > There are various ways we could handle conversion without explici=
t
> > > > > interference from userspace. What I had in mind is the following =
(as
> > > > > an example, details can vary according to VM type). I will use us=
e the
> > > > > case of conversion from shared to private because that is the mor=
e
> > > > > complicated (interesting) case:
> > > > >
> > > > > - Guest issues a hypercall to request that a shared folio become =
private.
> > > > >
> > > > > - The hypervisor receives the call, and passes it to KVM.
> > > > >
> > > > > - KVM unmaps the folio from the guest stage-2 (EPT I think in x86
> > > > > parlance), and unmaps it from the host. The host however, could s=
till
> > > > > have references (e.g., GUP).
> > > > >
> > > > > - KVM exits to the host (hypervisor call exit), with the informat=
ion
> > > > > that the folio has been unshared from it.
> > > > >
> > > > > - A well behaving host would now get rid of all of its references
> > > > > (e.g., release GUPs), perform a VCPU run, and the guest continues
> > > > > running as normal. I expect this to be the common case.
> > > > >
> > > > > But to handle the more interesting situation, let's say that the =
host
> > > > > doesn't do it immediately, and for some reason it holds on to som=
e
> > > > > references to that folio.
> > > > >
> > > > > - Even if that's the case, the guest can still run *. If the gues=
t
> > > > > tries to access the folio, KVM detects that access when it tries =
to
> > > > > fault it into the guest, sees that the host still has references =
to
> > > > > that folio, and exits back to the host with a memory fault exit. =
At
> > > > > this point, the VCPU that has tried to fault in that particular f=
olio
> > > > > cannot continue running as long as it cannot fault in that folio.
> > > >
> > > > Are you talking about the following scheme?
> > > > 1) guest_memfd checks shareability on each get pfn and if there is =
a
> > > > mismatch exit to the host.
> > >
> > > I think we are not really on the same page here (no pun intended :) )=
.
> > > I'll try to answer your questions anyway...
> > >
> > > Which get_pfn? Are you referring to get_pfn when faulting the page
> > > into the guest or into the host?
> >
> > I am referring to guest fault handling in KVM.
> >
> > >
> > > > 2) host user space has to guess whether it's a pending refcount or
> > > > whether it's an actual mismatch.
> > >
> > > No need to guess. VCPU run will let it know exactly why it's exiting.
> > >
> > > > 3) guest_memfd will maintain a third state
> > > > "pending_private_conversion" or equivalent which will transition to
> > > > private upon the last refcount drop of each page.
> > > >
> > > > If conversion is triggered by userspace (in case of pKVM, it will b=
e
> > > > triggered from within the KVM (?)):
> > >
> > > Why would conversion be triggered by userspace? As far as I know, it'=
s
> > > the guest that triggers the conversion.
> > >
> > > > * Conversion will just fail if there are extra refcounts and usersp=
ace
> > > > can try to get rid of extra refcounts on the range while it has eno=
ugh
> > > > context without hitting any ambiguity with memory fault exit.
> > > > * guest_memfd will not have to deal with this extra state from 3 ab=
ove
> > > > and overall guest_memfd conversion handling becomes relatively
> > > > simpler.
> > >
> > > That's not really related. The extra state isn't necessary any more
> > > once we agreed in the previous discussion that we will retry instead.
> >
> > Who is *we* here? Which entity will retry conversion?
>
> Userspace will re-attempt the VCPU run.

Then KVM will have to keep track of the ranges that need conversion
across exits. I think it's cleaner to let userspace make the decision
and invoke conversion without carrying additional state in KVM about
guest request.

>
> > >
> > > > Note that for x86 CoCo cases, memory conversion is already triggere=
d
> > > > by userspace using KVM ioctl, this series is proposing to use
> > > > guest_memfd ioctl to do the same.
> > >
> > > The reason why for x86 CoCo cases conversion is already triggered by
> > > userspace using KVM ioctl is that it has to, since shared memory and
> > > private memory are two separate pages, and userspace needs to manage
> > > that. Sharing memory in place removes the need for that.
> >
> > Userspace still needs to clean up memory usage before conversion is
> > successful. e.g. remove IOMMU mappings for shared to private
> > conversion. I would think that memory conversion should not succeed
> > before all existing users let go of the guest_memfd pages for the
> > range being converted.
>
> Yes. Userspace will know that it needs to do that on the VCPU exit,
> which informs it of the guest's hypervisor request to unshare (convert
> from shared to private) the page.
>
> > In x86 CoCo usecases, userspace can also decide to not allow
> > conversion for scenarios where ranges are still under active use by
> > the host and guest is erroneously trying to take away memory. Both
> > SNP/TDX spec allow failure of conversion due to in use memory.
>
> How can the guest erroneously try to take away memory? If the guest
> sends a hypervisor request asking for a conversion of memory that
> doesn't belong to it, then I would expect the hypervisor to prevent
> that.

Making a range as private is effectively disallowing host from
accessing those ranges -> so taking away memory.

>
> I don't see how having an IOCTL to trigger the conversion is needed to
> allow conversion failure. How is that different from userspace
> ignoring or delaying releasing all references it has for the
> conversion request?
>
> > >
> > > This series isn't using the same ioctl, it's introducing new ones to
> > > perform a task that as far as I can tell so far, KVM can handle by
> > > itself.
> >
> > I would like to understand this better. How will KVM handle the
> > conversion process for guest_memfd pages? Can you help walk an example
> > sequence for shared to private conversion specifically around
> > guest_memfd offset states?
>
> To make sure that we are discussing the same scenario: can you do the
> same as well please --- walk me through an example sequence for shared
> to private conversion specifically around guest_memfd offset states
> With the IOCTLs involved?
>
> Here is an example that I have implemented and tested with pKVM. Note
> that there are alternatives, the flow below is architecture or even
> vm-type dependent. None of this code is code KVM code and the
> behaviour could vary.
>
>
> Assuming the folio is shared with the host:
>
> Guest sends unshare hypercall to the hypervisor
> Hypervisor forwards request to KVM (gmem) (having done due diligence)
> KVM (gmem) performs an unmap_folio(), exits to userspace with

For x86 CoCo VM usecases I was talking about, userspace would like to
avoid unmap_mapping_range() on the range before it's safe to unshare
the range.

> KVM_EXIT_UNSHARE and all the information about the folio being
> unshared
>
> Case 1:
> Userspace removes any remaining references (GUPs, IOMMU Mappings etc...)
> Userspace calls vcpu_run(): KVM (gmem) sees that there aren't any
> references, sets state to PRIVATE
>
> Case 2 (alternative 1):
> Userspace doesn't release its references
> Userspace calls vcpu_run(): KVM (gmem) sees that there are still
> references, exits back to userspace with KVM_EXIT_UNSHARE
>
> Case 2 (alternative 2):
> Userspace doesn't release its references
> Userspace calls vcpu_run(): KVM (gmem) sees that there are still
> references, unmaps folio from guest, but allows it to run (until it
> tries to fault in the folio)
> Guest tries to fault in folio that still has reference, KVM does not
> allow that (it sees that the folio is shared, and it doesn't fault in
> shared folios to confidential guests)
> KVM exits back to userspace with KVM_EXIT_UNSHARE
>
> As I mentioned, the alternatives above are _not_ set in core KVM code.
> They can vary by architecture of VM type, depending on the policy,
> support, etc..
>
> Now for your example please on how this would work with IOCTLs :)
>
> Thanks,
> /fuad
>
> > >
> > > >  - Allows not having to keep track of separate shared/private range
> > > > information in KVM.
> > >
> > > This patch series is already tracking shared/private range informatio=
n in KVM.
> > >
> > > >  - Simpler handling of the conversion process done per guest_memfd
> > > > rather than for full range.
> > > >      - Userspace can handle the rollback as needed, simplifying err=
or
> > > > handling in guest_memfd.
> > > >  - guest_memfd is single source of truth and notifies the users of
> > > > shareability change.
> > > >      - e.g. IOMMU, userspace, KVM MMU all can be registered for
> > > > getting notifications from guest_memfd directly and will get notifi=
ed
> > > > for invalidation upon shareability attribute updates.
> > >
> > > All of these can still be done without introducing a new ioctl.
> > >
> > > Cheers,
> > > /fuad


Return-Path: <linux-fsdevel+bounces-49516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E41ABDD2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6EE1897837
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30A6247287;
	Tue, 20 May 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hl/BooP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767801DFD84
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751669; cv=none; b=logdLU2kGgzdOJOb7hy+xCOLLH4JRXZ3pEf7yi5FQrt3ABPFS4nEcVRlhpsRLoXxCyk/Tt1gRUOxLLVRip1sJOiZnIAi2hzr5vyGzYh0ERbPc23vJdVrwiGPB4IPDuv7qfuG0WSOPBSWNo0tIT4B5Z5M9K0bD7IVr/J4uGzQ8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751669; c=relaxed/simple;
	bh=mNFyed1F6DrHqM8zOgSCAdvd/yLPgRuXpu7QQKLIDd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8R1KS/CI4YogvG7sE8TBrNs+l18/VesIW+bDMz9izAw6Bf705wLLCQ9yGEkKUN2I1sgcIIMRgMao71JZXcRlO4Rn9mgKYZ6K9mEcI3PM4X2VjoeDlGBDi9//C6IrExw1RBz/Ci0SDKPaKjAebacqeYx568MXgdjYSlbOey6iyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hl/BooP/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-48b7747f881so1042621cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747751666; x=1748356466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0P2IqjvcCUOqznaXOXK895YsSeeP/H/xxEi3DHBfCY=;
        b=Hl/BooP/XqE40sQ83evDyG+lzouhUdaaUFaPFWp5SlwtWrtyExKwE1mgPAFXHy+PaT
         YkgDiBw+fhHIJSzIJyRWLpQMYXLvULzNcwdZwqJ+m1empL2DAugdGRQAEBbEySdMibVE
         uHtDY+xpYcY2YoBU9siICqtJnHYLOvVe5K9eztoSxIdErawREqoqAk8bZyCWYGmA8u+6
         LKcnAUKhrI3+f3nvPnqHJNHmjpL3atOo04KWa8LGRCHPu0yhbI2Mc59GQe8Jn9lgj2IX
         wzm3kKNWXbDk5qphIwBu1IgsIK5NaNajKOyT8TuCBSm+iglBnRYQAeTFTaixTqtoeeLL
         Sq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747751666; x=1748356466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0P2IqjvcCUOqznaXOXK895YsSeeP/H/xxEi3DHBfCY=;
        b=hrMEILTskVWZt19H5Tt00/9NChW31iinL5G70hyHWRyZd4pOk6G2f1Y6bP7w5L5Gjk
         X5wF1gVj0ggZxu0Mr8ynnLQ/rB5v0xhThHeRgU77Y2UPkM3JM77mvfFpvbJMjlFCPt62
         Ft+PTeHn9R8CJ45Z42XiXBjAACTzS12eqmUfcMxaBmvwIWDaDtCan3peRt2RlHCntrzx
         pMxC1yxabsp4DfeyocdWYPRWCqu2kqXRwW6+0QAJQM4Un+SWrm6nEXhtPORWzA0CWbeI
         J4bXR6B5lnVz4O5mqPbgMpQn121hRLqjBJC814y34MTz8aiukGYMBanxBWqZ97HSJ4eB
         1v4g==
X-Forwarded-Encrypted: i=1; AJvYcCU+kxAZ3eHRhXijo8mDPKD2MOzF9LVMXVoX4UNi5H98V8N66WX9IkYr6pQWcIWvzcDf1DILEtZPUgFf3gYW@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlFJ9pgnniT55+rnAJXTRfc1UC/ggFq8rTrXx4LhFJV5qHtod
	hrk43QaNP2CHIaR0X92tX+aAd2I1Joq/fXZIA2x25AWIBNRRPgKmEYoVpQf/S/ixfPywEBL0d14
	PkXSvnlqW6Ekxcstzm24eaELgs+KtU3SKLb5Xhjim
X-Gm-Gg: ASbGnctAaZ3H7rLUY/c+z91XBa3rQVWxUbWmhG/ya66muy6RpCv2QonXXRFONKFyIvo
	j2LBhjDw2iGDEYRqn0lhz765VV2XufjpERcMZpHePZciYfGGav5miKZOHmzk7HFWyR9EUu6kWjA
	wfDjeXGwpbatHYaoATbu0QA/fmhNBdSYaSo10u/QXTU7EnI4nbJlKYzoc9Mw2wOyYVDIYV+Uyu
X-Google-Smtp-Source: AGHT+IFq6QHuKVGpcJOYykEJd+54LhE6lJ5aZDCK7UqOGv7vWK/rlbhRvqzoyV3nEFreQqOalTu7rjwWEpWUr0hZeLw=
X-Received: by 2002:ac8:5a08:0:b0:47d:4e8a:97f0 with SMTP id
 d75a77b69052e-4960136a0a5mr10783031cf.29.1747751665479; Tue, 20 May 2025
 07:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com> <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
In-Reply-To: <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 20 May 2025 15:33:49 +0100
X-Gm-Features: AX0GCFt089q6agCPPB7UyDi-PWzBYyB89JwxkyNf6w9tWUw1XGRX3RdPGBlte3M
Message-ID: <CA+EHjTy7iBNBb9DRdtgq8oYmvgykhSNvZL3FrRV4XF90t3XgBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Vishal Annapurve <vannapurve@google.com>
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

Hi Vishal,

On Tue, 20 May 2025 at 15:11, Vishal Annapurve <vannapurve@google.com> wrot=
e:
>
> On Tue, May 20, 2025 at 6:44=E2=80=AFAM Fuad Tabba <tabba@google.com> wro=
te:
> >
> > Hi Vishal,
> >
> > On Tue, 20 May 2025 at 14:02, Vishal Annapurve <vannapurve@google.com> =
wrote:
> > >
> > > On Tue, May 20, 2025 at 2:23=E2=80=AFAM Fuad Tabba <tabba@google.com>=
 wrote:
> > > >
> > > > Hi Ackerley,
> > > >
> > > > On Thu, 15 May 2025 at 00:43, Ackerley Tng <ackerleytng@google.com>=
 wrote:
> > > > >
> > > > > The two new guest_memfd ioctls KVM_GMEM_CONVERT_SHARED and
> > > > > KVM_GMEM_CONVERT_PRIVATE convert the requested memory ranges to s=
hared
> > > > > and private respectively.
> > > >
> > > > I have a high level question about this particular patch and this
> > > > approach for conversion: why do we need IOCTLs to manage conversion
> > > > between private and shared?
> > > >
> > > > In the presentations I gave at LPC [1, 2], and in my latest patch
> > > > series that performs in-place conversion [3] and the associated (by
> > > > now outdated) state diagram [4], I didn't see the need to have a
> > > > userspace-facing interface to manage that. KVM has all the informat=
ion
> > > > it needs to handle conversions, which are triggered by the guest. T=
o
> > > > me this seems like it adds additional complexity, as well as a user
> > > > facing interface that we would need to maintain.
> > > >
> > > > There are various ways we could handle conversion without explicit
> > > > interference from userspace. What I had in mind is the following (a=
s
> > > > an example, details can vary according to VM type). I will use use =
the
> > > > case of conversion from shared to private because that is the more
> > > > complicated (interesting) case:
> > > >
> > > > - Guest issues a hypercall to request that a shared folio become pr=
ivate.
> > > >
> > > > - The hypervisor receives the call, and passes it to KVM.
> > > >
> > > > - KVM unmaps the folio from the guest stage-2 (EPT I think in x86
> > > > parlance), and unmaps it from the host. The host however, could sti=
ll
> > > > have references (e.g., GUP).
> > > >
> > > > - KVM exits to the host (hypervisor call exit), with the informatio=
n
> > > > that the folio has been unshared from it.
> > > >
> > > > - A well behaving host would now get rid of all of its references
> > > > (e.g., release GUPs), perform a VCPU run, and the guest continues
> > > > running as normal. I expect this to be the common case.
> > > >
> > > > But to handle the more interesting situation, let's say that the ho=
st
> > > > doesn't do it immediately, and for some reason it holds on to some
> > > > references to that folio.
> > > >
> > > > - Even if that's the case, the guest can still run *. If the guest
> > > > tries to access the folio, KVM detects that access when it tries to
> > > > fault it into the guest, sees that the host still has references to
> > > > that folio, and exits back to the host with a memory fault exit. At
> > > > this point, the VCPU that has tried to fault in that particular fol=
io
> > > > cannot continue running as long as it cannot fault in that folio.
> > >
> > > Are you talking about the following scheme?
> > > 1) guest_memfd checks shareability on each get pfn and if there is a
> > > mismatch exit to the host.
> >
> > I think we are not really on the same page here (no pun intended :) ).
> > I'll try to answer your questions anyway...
> >
> > Which get_pfn? Are you referring to get_pfn when faulting the page
> > into the guest or into the host?
>
> I am referring to guest fault handling in KVM.
>
> >
> > > 2) host user space has to guess whether it's a pending refcount or
> > > whether it's an actual mismatch.
> >
> > No need to guess. VCPU run will let it know exactly why it's exiting.
> >
> > > 3) guest_memfd will maintain a third state
> > > "pending_private_conversion" or equivalent which will transition to
> > > private upon the last refcount drop of each page.
> > >
> > > If conversion is triggered by userspace (in case of pKVM, it will be
> > > triggered from within the KVM (?)):
> >
> > Why would conversion be triggered by userspace? As far as I know, it's
> > the guest that triggers the conversion.
> >
> > > * Conversion will just fail if there are extra refcounts and userspac=
e
> > > can try to get rid of extra refcounts on the range while it has enoug=
h
> > > context without hitting any ambiguity with memory fault exit.
> > > * guest_memfd will not have to deal with this extra state from 3 abov=
e
> > > and overall guest_memfd conversion handling becomes relatively
> > > simpler.
> >
> > That's not really related. The extra state isn't necessary any more
> > once we agreed in the previous discussion that we will retry instead.
>
> Who is *we* here? Which entity will retry conversion?

Userspace will re-attempt the VCPU run.

> >
> > > Note that for x86 CoCo cases, memory conversion is already triggered
> > > by userspace using KVM ioctl, this series is proposing to use
> > > guest_memfd ioctl to do the same.
> >
> > The reason why for x86 CoCo cases conversion is already triggered by
> > userspace using KVM ioctl is that it has to, since shared memory and
> > private memory are two separate pages, and userspace needs to manage
> > that. Sharing memory in place removes the need for that.
>
> Userspace still needs to clean up memory usage before conversion is
> successful. e.g. remove IOMMU mappings for shared to private
> conversion. I would think that memory conversion should not succeed
> before all existing users let go of the guest_memfd pages for the
> range being converted.

Yes. Userspace will know that it needs to do that on the VCPU exit,
which informs it of the guest's hypervisor request to unshare (convert
from shared to private) the page.

> In x86 CoCo usecases, userspace can also decide to not allow
> conversion for scenarios where ranges are still under active use by
> the host and guest is erroneously trying to take away memory. Both
> SNP/TDX spec allow failure of conversion due to in use memory.

How can the guest erroneously try to take away memory? If the guest
sends a hypervisor request asking for a conversion of memory that
doesn't belong to it, then I would expect the hypervisor to prevent
that.

I don't see how having an IOCTL to trigger the conversion is needed to
allow conversion failure. How is that different from userspace
ignoring or delaying releasing all references it has for the
conversion request?

> >
> > This series isn't using the same ioctl, it's introducing new ones to
> > perform a task that as far as I can tell so far, KVM can handle by
> > itself.
>
> I would like to understand this better. How will KVM handle the
> conversion process for guest_memfd pages? Can you help walk an example
> sequence for shared to private conversion specifically around
> guest_memfd offset states?

To make sure that we are discussing the same scenario: can you do the
same as well please --- walk me through an example sequence for shared
to private conversion specifically around guest_memfd offset states
With the IOCTLs involved?

Here is an example that I have implemented and tested with pKVM. Note
that there are alternatives, the flow below is architecture or even
vm-type dependent. None of this code is code KVM code and the
behaviour could vary.


Assuming the folio is shared with the host:

Guest sends unshare hypercall to the hypervisor
Hypervisor forwards request to KVM (gmem) (having done due diligence)
KVM (gmem) performs an unmap_folio(), exits to userspace with
KVM_EXIT_UNSHARE and all the information about the folio being
unshared

Case 1:
Userspace removes any remaining references (GUPs, IOMMU Mappings etc...)
Userspace calls vcpu_run(): KVM (gmem) sees that there aren't any
references, sets state to PRIVATE

Case 2 (alternative 1):
Userspace doesn't release its references
Userspace calls vcpu_run(): KVM (gmem) sees that there are still
references, exits back to userspace with KVM_EXIT_UNSHARE

Case 2 (alternative 2):
Userspace doesn't release its references
Userspace calls vcpu_run(): KVM (gmem) sees that there are still
references, unmaps folio from guest, but allows it to run (until it
tries to fault in the folio)
Guest tries to fault in folio that still has reference, KVM does not
allow that (it sees that the folio is shared, and it doesn't fault in
shared folios to confidential guests)
KVM exits back to userspace with KVM_EXIT_UNSHARE

As I mentioned, the alternatives above are _not_ set in core KVM code.
They can vary by architecture of VM type, depending on the policy,
support, etc..

Now for your example please on how this would work with IOCTLs :)

Thanks,
/fuad

> >
> > >  - Allows not having to keep track of separate shared/private range
> > > information in KVM.
> >
> > This patch series is already tracking shared/private range information =
in KVM.
> >
> > >  - Simpler handling of the conversion process done per guest_memfd
> > > rather than for full range.
> > >      - Userspace can handle the rollback as needed, simplifying error
> > > handling in guest_memfd.
> > >  - guest_memfd is single source of truth and notifies the users of
> > > shareability change.
> > >      - e.g. IOMMU, userspace, KVM MMU all can be registered for
> > > getting notifications from guest_memfd directly and will get notified
> > > for invalidation upon shareability attribute updates.
> >
> > All of these can still be done without introducing a new ioctl.
> >
> > Cheers,
> > /fuad


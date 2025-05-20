Return-Path: <linux-fsdevel+bounces-49538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D574CABE24C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 20:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC7A3B472F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0523D280306;
	Tue, 20 May 2025 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NkPcs4a1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEC27FB2E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764361; cv=none; b=Q0DWNihTdr+ZzxS+Swsp9317r1dE8PRpA+mJIVhBAAwkfo+zq65O8zWWZcHkjqOqQ4Qq9VXM6711hIK04diIwK2WT7PYjQzz7VAcBTMIvnvDi/yYivbmgDRTbQQq4/PtRAyZxsd7EzNSKyDFe4Ranin9D5psnQVg4QXGX5M61mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764361; c=relaxed/simple;
	bh=tEijWLw113LWR96iE64iBpJTmYXBUT2RkrfOthW2vG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4spr+wIt4EsL3ncwbLZSPLTnW2McUilTv0ZNrkLtdgunJ0k56X7upRIzG68ewh0LC9bzCgZt7Mwld510uEJN0QbuaBPzQ7SMst7gUQ5bZ6U9EKkQBHLdBImVfhwvhXm5kY8J0gw+yDqayyclb9Z3CN2+VokJg/GrQEn3sVIbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NkPcs4a1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47e9fea29easo1342541cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747764358; x=1748369158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F8AFconSLtX/NPzQMDe9nPFlH5MwE2Du+V+6LjrvmQ=;
        b=NkPcs4a1CP2l1sgDBLe2yRI2OP6J+8FYeMvqku9DAVl0UssYwtPEc6orjLM8AVP1JF
         0pIu/eU/15KRooTE/DclWb/Jioo5o7+mzsgLlDOs7I6L+pjMP+HjhhuoyzVXJzwSayIm
         XOLbttQcqQUfQCx2C//Thr8PN3SSp2rzqhw84kvjaLIIA4wjxCLp3SGIe+a+HW+XAOfe
         3wXqLAlCK8D9EQHtBBGesPaBIcsSXJGiyS+S2lOsCjmwG7xr0HBCnrOrf1nA2PntOru1
         iWBCrbj63zt9OTDaOt5+MrVzzLfoZsvk4gmQ9aGfvYSy1yZrkNotAnzyGSdhdjzFRJqC
         QSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747764358; x=1748369158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F8AFconSLtX/NPzQMDe9nPFlH5MwE2Du+V+6LjrvmQ=;
        b=j8hnUvyQD86TfQ5nMuwNwDpugNIhzbwj2xyZgXT/2hFDoNpxJ5U2sNlBczcNswhkH7
         32s2CM2D7kTIHrwzaAZpRoEmrc/Xicflm1d/ZnVSeKp9cGZmivVFitXv40X05QkpBMar
         qN0Gupbi/LTkUI5xblS56+V5ls4h+t4n5chFo4UL2xutC6113M2q7BwS9PkBovSg/YiA
         dBsZxDJMIxclHQFmUUY9IXjZlHr7DDVAKRXFv+R24Dx+XML1aVzUQv+7hty7TyxMsTwl
         i0nXLM3qQwnmDG1Nc2/K22Hn8AQn17TBPTjaI3uXdRNDL5RVe7YZTkaz+vEVZwTlwwhy
         8iKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+jeFTWDWj4d/i7hllifJOBsCpeyK82lDSQquv9NetF4eIeoug+hGf/KqZyb3bfLsDxhU/ZqClDQth7bGc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr2qbuniWURw3xsxQro9xNuEgMfLUH7owQsLYwCfvg2xqug19m
	CBQP2tpvJggFUMkbsPDwabfebjhxGHQ0ChoS8IDPX6zNaYcJYng8hYsLCnIyQC8dBB9UgD+IcEZ
	OHqZzyHtD2tbSf8hpkDtTesBnTFv9OuKpSjCfv8a2
X-Gm-Gg: ASbGncvVb6bRcc/0P+zScqv69i38ElnLBLFagMF9hYuvOm6CAIij1p9UEgyDGOigBeg
	3mgc0D+0fvMbJLmC+8hFbxy4ot34QQhV2bCMHLwPKW1uXprcVxl47uG2idKU4/FfD1jLI4CV57y
	8JUmENETXHu/YD6asSWIujVgxP4KOoMdQZbDlOJk3y9STR
X-Google-Smtp-Source: AGHT+IEEkipZt0OxybJVx9mt4Ln4z0SxseWk9zthND56+2gK2l+Yv26CBC8ueNBJ+3EMCIWEBp5ZyDofnXei1I2cFY8=
X-Received: by 2002:ac8:5a41:0:b0:494:b24f:c6df with SMTP id
 d75a77b69052e-49601267f27mr11401751cf.25.1747764357678; Tue, 20 May 2025
 11:05:57 -0700 (PDT)
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
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <CA+EHjTy7iBNBb9DRdtgq8oYmvgykhSNvZL3FrRV4XF90t3XgBg@mail.gmail.com> <CAGtprH_7jSpwF77j1GW8rjSrbtZZ2OW2iGck5=Wk67+VnF9vjQ@mail.gmail.com>
In-Reply-To: <CAGtprH_7jSpwF77j1GW8rjSrbtZZ2OW2iGck5=Wk67+VnF9vjQ@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 20 May 2025 19:05:19 +0100
X-Gm-Features: AX0GCFtaVo1OQso2b2Ub915ZtA3AkWxho65J0pdDhwf-I6NJzR0_EVjbMI_nFmI
Message-ID: <CA+EHjTzMhKCoftfJUuL0WUZW4DdqOHgVDcn0Cmf-0r--8rBdbg@mail.gmail.com>
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

On Tue, 20 May 2025 at 17:03, Vishal Annapurve <vannapurve@google.com> wrot=
e:
>
> On Tue, May 20, 2025 at 7:34=E2=80=AFAM Fuad Tabba <tabba@google.com> wro=
te:
> >
> > Hi Vishal,
> >
> > On Tue, 20 May 2025 at 15:11, Vishal Annapurve <vannapurve@google.com> =
wrote:
> > >
> > > On Tue, May 20, 2025 at 6:44=E2=80=AFAM Fuad Tabba <tabba@google.com>=
 wrote:
> > > >
> > > > Hi Vishal,
> > > >
> > > > On Tue, 20 May 2025 at 14:02, Vishal Annapurve <vannapurve@google.c=
om> wrote:
> > > > >
> > > > > On Tue, May 20, 2025 at 2:23=E2=80=AFAM Fuad Tabba <tabba@google.=
com> wrote:
> > > > > >
> > > > > > Hi Ackerley,
> > > > > >
> > > > > > On Thu, 15 May 2025 at 00:43, Ackerley Tng <ackerleytng@google.=
com> wrote:
> > > > > > >
> > > > > > > The two new guest_memfd ioctls KVM_GMEM_CONVERT_SHARED and
> > > > > > > KVM_GMEM_CONVERT_PRIVATE convert the requested memory ranges =
to shared
> > > > > > > and private respectively.
> > > > > >
> > > > > > I have a high level question about this particular patch and th=
is
> > > > > > approach for conversion: why do we need IOCTLs to manage conver=
sion
> > > > > > between private and shared?
> > > > > >
> > > > > > In the presentations I gave at LPC [1, 2], and in my latest pat=
ch
> > > > > > series that performs in-place conversion [3] and the associated=
 (by
> > > > > > now outdated) state diagram [4], I didn't see the need to have =
a
> > > > > > userspace-facing interface to manage that. KVM has all the info=
rmation
> > > > > > it needs to handle conversions, which are triggered by the gues=
t. To
> > > > > > me this seems like it adds additional complexity, as well as a =
user
> > > > > > facing interface that we would need to maintain.
> > > > > >
> > > > > > There are various ways we could handle conversion without expli=
cit
> > > > > > interference from userspace. What I had in mind is the followin=
g (as
> > > > > > an example, details can vary according to VM type). I will use =
use the
> > > > > > case of conversion from shared to private because that is the m=
ore
> > > > > > complicated (interesting) case:
> > > > > >
> > > > > > - Guest issues a hypercall to request that a shared folio becom=
e private.
> > > > > >
> > > > > > - The hypervisor receives the call, and passes it to KVM.
> > > > > >
> > > > > > - KVM unmaps the folio from the guest stage-2 (EPT I think in x=
86
> > > > > > parlance), and unmaps it from the host. The host however, could=
 still
> > > > > > have references (e.g., GUP).
> > > > > >
> > > > > > - KVM exits to the host (hypervisor call exit), with the inform=
ation
> > > > > > that the folio has been unshared from it.
> > > > > >
> > > > > > - A well behaving host would now get rid of all of its referenc=
es
> > > > > > (e.g., release GUPs), perform a VCPU run, and the guest continu=
es
> > > > > > running as normal. I expect this to be the common case.
> > > > > >
> > > > > > But to handle the more interesting situation, let's say that th=
e host
> > > > > > doesn't do it immediately, and for some reason it holds on to s=
ome
> > > > > > references to that folio.
> > > > > >
> > > > > > - Even if that's the case, the guest can still run *. If the gu=
est
> > > > > > tries to access the folio, KVM detects that access when it trie=
s to
> > > > > > fault it into the guest, sees that the host still has reference=
s to
> > > > > > that folio, and exits back to the host with a memory fault exit=
. At
> > > > > > this point, the VCPU that has tried to fault in that particular=
 folio
> > > > > > cannot continue running as long as it cannot fault in that foli=
o.
> > > > >
> > > > > Are you talking about the following scheme?
> > > > > 1) guest_memfd checks shareability on each get pfn and if there i=
s a
> > > > > mismatch exit to the host.
> > > >
> > > > I think we are not really on the same page here (no pun intended :)=
 ).
> > > > I'll try to answer your questions anyway...
> > > >
> > > > Which get_pfn? Are you referring to get_pfn when faulting the page
> > > > into the guest or into the host?
> > >
> > > I am referring to guest fault handling in KVM.
> > >
> > > >
> > > > > 2) host user space has to guess whether it's a pending refcount o=
r
> > > > > whether it's an actual mismatch.
> > > >
> > > > No need to guess. VCPU run will let it know exactly why it's exitin=
g.
> > > >
> > > > > 3) guest_memfd will maintain a third state
> > > > > "pending_private_conversion" or equivalent which will transition =
to
> > > > > private upon the last refcount drop of each page.
> > > > >
> > > > > If conversion is triggered by userspace (in case of pKVM, it will=
 be
> > > > > triggered from within the KVM (?)):
> > > >
> > > > Why would conversion be triggered by userspace? As far as I know, i=
t's
> > > > the guest that triggers the conversion.
> > > >
> > > > > * Conversion will just fail if there are extra refcounts and user=
space
> > > > > can try to get rid of extra refcounts on the range while it has e=
nough
> > > > > context without hitting any ambiguity with memory fault exit.
> > > > > * guest_memfd will not have to deal with this extra state from 3 =
above
> > > > > and overall guest_memfd conversion handling becomes relatively
> > > > > simpler.
> > > >
> > > > That's not really related. The extra state isn't necessary any more
> > > > once we agreed in the previous discussion that we will retry instea=
d.
> > >
> > > Who is *we* here? Which entity will retry conversion?
> >
> > Userspace will re-attempt the VCPU run.
>
> Then KVM will have to keep track of the ranges that need conversion
> across exits. I think it's cleaner to let userspace make the decision
> and invoke conversion without carrying additional state in KVM about
> guest request.

I disagree. I think it's cleaner not to introduce a user interface,
and just to track the reason for the last exit, along with the
required additional data. KVM is responsible already for handling the
workflow, why delegate this last part to the VMM?

> >
> > > >
> > > > > Note that for x86 CoCo cases, memory conversion is already trigge=
red
> > > > > by userspace using KVM ioctl, this series is proposing to use
> > > > > guest_memfd ioctl to do the same.
> > > >
> > > > The reason why for x86 CoCo cases conversion is already triggered b=
y
> > > > userspace using KVM ioctl is that it has to, since shared memory an=
d
> > > > private memory are two separate pages, and userspace needs to manag=
e
> > > > that. Sharing memory in place removes the need for that.
> > >
> > > Userspace still needs to clean up memory usage before conversion is
> > > successful. e.g. remove IOMMU mappings for shared to private
> > > conversion. I would think that memory conversion should not succeed
> > > before all existing users let go of the guest_memfd pages for the
> > > range being converted.
> >
> > Yes. Userspace will know that it needs to do that on the VCPU exit,
> > which informs it of the guest's hypervisor request to unshare (convert
> > from shared to private) the page.
> >
> > > In x86 CoCo usecases, userspace can also decide to not allow
> > > conversion for scenarios where ranges are still under active use by
> > > the host and guest is erroneously trying to take away memory. Both
> > > SNP/TDX spec allow failure of conversion due to in use memory.
> >
> > How can the guest erroneously try to take away memory? If the guest
> > sends a hypervisor request asking for a conversion of memory that
> > doesn't belong to it, then I would expect the hypervisor to prevent
> > that.
>
> Making a range as private is effectively disallowing host from
> accessing those ranges -> so taking away memory.

You said "erroneously" earlier. My question is, how can the guest
*erroneously* try to take away memory? This is the normal flow of
guest/host relations. The memory is the guest's: it decides when to
share it with the host, and it can take it away.

> >
> > I don't see how having an IOCTL to trigger the conversion is needed to
> > allow conversion failure. How is that different from userspace
> > ignoring or delaying releasing all references it has for the
> > conversion request?
> >
> > > >
> > > > This series isn't using the same ioctl, it's introducing new ones t=
o
> > > > perform a task that as far as I can tell so far, KVM can handle by
> > > > itself.
> > >
> > > I would like to understand this better. How will KVM handle the
> > > conversion process for guest_memfd pages? Can you help walk an exampl=
e
> > > sequence for shared to private conversion specifically around
> > > guest_memfd offset states?
> >
> > To make sure that we are discussing the same scenario: can you do the
> > same as well please --- walk me through an example sequence for shared
> > to private conversion specifically around guest_memfd offset states
> > With the IOCTLs involved?
> >
> > Here is an example that I have implemented and tested with pKVM. Note
> > that there are alternatives, the flow below is architecture or even
> > vm-type dependent. None of this code is code KVM code and the
> > behaviour could vary.
> >
> >
> > Assuming the folio is shared with the host:
> >
> > Guest sends unshare hypercall to the hypervisor
> > Hypervisor forwards request to KVM (gmem) (having done due diligence)
> > KVM (gmem) performs an unmap_folio(), exits to userspace with
>
> For x86 CoCo VM usecases I was talking about, userspace would like to
> avoid unmap_mapping_range() on the range before it's safe to unshare
> the range.

Why? There is no harm in userspace unmapping before the memory isn't
shared. I don't see the problem with that.

You still haven't responded to my question from the previous email:
can you please return the favor and walk me through an example
sequence for shared to private conversion specifically around
guest_memfd offset states with the IOCTLs involved? :D

Thanks!
/fuad


> > KVM_EXIT_UNSHARE and all the information about the folio being
> > unshared
> >
> > Case 1:
> > Userspace removes any remaining references (GUPs, IOMMU Mappings etc...=
)
> > Userspace calls vcpu_run(): KVM (gmem) sees that there aren't any
> > references, sets state to PRIVATE
> >
> > Case 2 (alternative 1):
> > Userspace doesn't release its references
> > Userspace calls vcpu_run(): KVM (gmem) sees that there are still
> > references, exits back to userspace with KVM_EXIT_UNSHARE
> >
> > Case 2 (alternative 2):
> > Userspace doesn't release its references
> > Userspace calls vcpu_run(): KVM (gmem) sees that there are still
> > references, unmaps folio from guest, but allows it to run (until it
> > tries to fault in the folio)
> > Guest tries to fault in folio that still has reference, KVM does not
> > allow that (it sees that the folio is shared, and it doesn't fault in
> > shared folios to confidential guests)
> > KVM exits back to userspace with KVM_EXIT_UNSHARE
> >
> > As I mentioned, the alternatives above are _not_ set in core KVM code.
> > They can vary by architecture of VM type, depending on the policy,
> > support, etc..
> >
> > Now for your example please on how this would work with IOCTLs :)
> >
> > Thanks,
> > /fuad
> >
> > > >
> > > > >  - Allows not having to keep track of separate shared/private ran=
ge
> > > > > information in KVM.
> > > >
> > > > This patch series is already tracking shared/private range informat=
ion in KVM.
> > > >
> > > > >  - Simpler handling of the conversion process done per guest_memf=
d
> > > > > rather than for full range.
> > > > >      - Userspace can handle the rollback as needed, simplifying e=
rror
> > > > > handling in guest_memfd.
> > > > >  - guest_memfd is single source of truth and notifies the users o=
f
> > > > > shareability change.
> > > > >      - e.g. IOMMU, userspace, KVM MMU all can be registered for
> > > > > getting notifications from guest_memfd directly and will get noti=
fied
> > > > > for invalidation upon shareability attribute updates.
> > > >
> > > > All of these can still be done without introducing a new ioctl.
> > > >
> > > > Cheers,
> > > > /fuad


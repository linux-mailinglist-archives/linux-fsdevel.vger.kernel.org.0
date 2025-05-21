Return-Path: <linux-fsdevel+bounces-49579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D11CABF468
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8953B9FD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE802266584;
	Wed, 21 May 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzN+Anh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75852638A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831012; cv=none; b=hVjuhbUYhy1W/ZqIpXBeEGHAx7TOInLyyfO9u3Hux3JMJjVZlIndXmjO8U74wSJZMzR2eP31G5/Wh1rMeQvGO180jquN+dPzN9sm9W+uJlpUPKRR5h+ibOEJ7euV2ecI+tz4i3wlQv5OZQcT0VbwSF+q+Bdfa9atXiWpr6gLs7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831012; c=relaxed/simple;
	bh=7oL7SEGEv+GubdsDb4WaQtWC2EFyMsHMPBvDifCrwI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdXVrXq5RG80K96UlHvPUh8gnWu+0RO+h6xPCYWAld9HpMu21ylrh686oJQY0lSu0b/PZXOsKDuJlvqIsULuMCwU/sRSyEQl79dJJyTPgz9R5bzRRg1iSdW5GOc65jSgpnidCDxrZtfsA4JGjrCheOTDIABm65IWNppQ8UdJ71o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzN+Anh9; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47666573242so1412541cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747831008; x=1748435808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhOxX7GZJR1nMVA/99p6GgBY9LCpqb0ybHQEVY3+G+8=;
        b=GzN+Anh9SXPNBu4+K8GKCmiHQ8csgan2MFidBcWFs/I1AFWAb5ndrh2LgFo8B8NPu9
         1b130xBvpF8H7ZO4LC15W/RHk+fMFCoqqIYThZum2zre0FsOYT5MeM0wfhSgU+SWaDYy
         R5LOGHmSlkr9/pysKpriMzshFx1icFpGXRaWa8K49Jr8uz4R4H9983p23HRAypNq6h/y
         tmBnvGcDKaSLU52Bucg6icSQaHQ7QMFFPMPrPdw4F3POyQJVENzp5pc2wxprIPNDmgzW
         Sv4S+RphTxKbjbkkUOrOWF76Z4pke572SU6M4tt9ytPyb8lKVBtqJDP+w+RkRVfeI6eD
         3UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747831008; x=1748435808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhOxX7GZJR1nMVA/99p6GgBY9LCpqb0ybHQEVY3+G+8=;
        b=ukV9WHTpwDPsrTFou8JUNNYAokiYywVilLWNwMIgay6sb+fHSaT7NnfBvINYB52MdO
         EH5pxKhs/fnAWTn1eeAyu5VVqvR4Fh90eRg5nG5NTobseWkHoF5U5fTGsZmbrYpR7wBZ
         KmYxD3dXBKBjWMY5fLRtzv1eO8SjCbfQK3C2OtEPpo/QUcW3RVpzJ4pnM77vT9K3TqWL
         nxZ/Jyk+LGzBy6rgtmGjd4ArtJX+HgkZkjQvq+OnnaWQAnza5r33BLikqtsN2jKp2fbd
         p3Ll9CdkArKshyS6+gNV5FHVAeGsBMG9h+BCEAgbNF5JRFgHjV5x7r34rgTKGh3w2xxN
         cJuw==
X-Forwarded-Encrypted: i=1; AJvYcCXjii91gniOG8144D+dB2uhpQvAUMY4Ygyf3I25RfyuMDae9Ea5SoxXUZVe1fmXqj3QwUTjizXsPt98iUpK@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOwR4tj+VYlwOmSd2uAXkGil2Y9iWhzf2aQ3C8etenpUTTQTD
	RDFU/79qXyr6aF+4qJUE4I0SHwMNZzJK/kR4Y4Qxpke+WFzkzgcYwPcu2KiOXLntAn1poPXmEY7
	+zNEeZfx0jNOm8M05v52ltnQdkSdW3Yv/M3kBAkpg
X-Gm-Gg: ASbGncv2aqyPJyf/dfZbMNqviPHeCvQzkzhn98iRmC79QuhEOj15QZ2i7OyXwww/g7u
	oLWvLSHOf8v4IaRnbFeu39f4dspb14Kzk1cVRU69oolYBc10yiliIGiUtTg2Bu+O1dnRPOI9zkR
	sNbmDRogBL4CWss50Ck/eETC5YRw93rTiE76SE+SVUqHHEoEooxTwaL2i0LJX3o3mM03ScnV/R
X-Google-Smtp-Source: AGHT+IFY66dlLlKuFxZkep1OQ65CB781Xtkbpoye4R8cp7mOpqmlNk1HCRlIz+wlZqXNcRJ+H29kF9yeLtsiq9TDuRw=
X-Received: by 2002:ac8:5ac3:0:b0:467:8416:d99e with SMTP id
 d75a77b69052e-49601270e7amr14952771cf.21.1747831007773; Wed, 21 May 2025
 05:36:47 -0700 (PDT)
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
 <CA+EHjTy7iBNBb9DRdtgq8oYmvgykhSNvZL3FrRV4XF90t3XgBg@mail.gmail.com>
 <CAGtprH_7jSpwF77j1GW8rjSrbtZZ2OW2iGck5=Wk67+VnF9vjQ@mail.gmail.com>
 <CA+EHjTzMhKCoftfJUuL0WUZW4DdqOHgVDcn0Cmf-0r--8rBdbg@mail.gmail.com> <diqzecwjnk95.fsf@ackerleytng-ctop.c.googlers.com>
In-Reply-To: <diqzecwjnk95.fsf@ackerleytng-ctop.c.googlers.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 21 May 2025 13:36:11 +0100
X-Gm-Features: AX0GCFvnLnxUGWsMjAJTYI2xsyes-uz3yow7QxS80ZGJNCBU78AJ08LLOHU0p3Q
Message-ID: <CA+EHjTyY5C1QgkoAqvJ0kHM4nUvKc1e1nQ0Uq+BANtVEnZH90w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Ackerley Tng <ackerleytng@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
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

Hi Ackerley,

On Tue, 20 May 2025 at 20:40, Ackerley Tng <ackerleytng@google.com> wrote:
>
> Fuad Tabba <tabba@google.com> writes:
>
> Let me try to bridge the gap here beginning with the flow we were
> counting on for a shared to private conversion, for TDX:
>
> 1. Guest sends unshare hypercall to the hypervisor
>
> 2. (For x86 IIUC hypervisor is the same as KVM) KVM forwards the request
>    to userspace via a KVM_EXIT_HYPERCALL, with KVM_HC_MAP_GPA_RANGE as
>    the hypercall number.
>
>    KVM also records that the guest wanted a shared to private
>    conversion, the gpa and size of the request (no change from now, KVM
>    already records that information in struct kvm_run) [1]
>
> 3. Userspace will do necessary coordination in userspace, then call the
>    conversion ioctl, passing the parameters along to the ioctl.
>
> 4. Ioctl goes to guest_memfd, guest_memfd unmaps the pages, checks
>    refcounts. If there's anything unexpected, error out to userspace. If
>    all is well, flip shareability, exit to userspace with success.
>
> 5. Userspace calls vcpu_run() again, the handler for
>    KVM_HC_MAP_GPA_RANGE will tell the guest that userspace was able to
>    fulfill guest request with hypercall.ret set to 0 and then the guest
>    will continue.
>
> 6. On the next fault guest_memfd will allow the private fault from the
>    guest.
>
>
> The flow you're proposing works too, with some changes, but it's
> probably okay for x86 to have a slightly different flow anyway: (I
> refactored the steps you outlined)
>
> > 1. Guest sends unshare hypercall to the hypervisor
>
> Same
>
> > 2. Hypervisor forwards request to KVM (gmem) (having done due diligence=
)
>
> For x86 IIUC hypervisor is the same as KVM, so there's no forwarding to K=
VM.
>
> > 3. KVM (gmem) performs an unmap_folio(), exits to userspace with
> >    KVM_EXIT_UNSHARE and all the information about the folio being unsha=
red
>
> The KVM_EXIT_UNSHARE here would correspond to x86's
> KVM_HC_MAP_GPA_RANGE.
>
> Unmapping before exiting with KVM_EXIT_UNSHARE here might be a little
> premature since userspace may have to do some stuff before permitting
> the conversion. For example, the memory may be mapped into another
> userspace driver process, which needs to first be stopped.
>
> But no issue though, as long as we don't flip shareability, if the host
> uses the memory, the kvm_gmem_fault_shared() will just happen again,
> nullifying the unmapping.
>
> We could just shift the unmapping till after vcpu_run() is called
> again.
>
> > 4. Userspace will do necessary coordination in userspace, then do
> >    vcpu_run()
>
> There's another layer here, at least for x86, as to whether the
> coordination was successful. For x86's KVM_HC_MAP_GPA_RANGE, userspace
> can indicate a non-zero hypercall.ret for error.
>
> For unsuccessful coordinations, userspace sets hypercall.ret to error
> and the vcpu_run() handler doesn't try the conversion. Guest is informed
> of hypercall error and guest will figure it out.
>
> > 5. Successful coordination, case 1: vcpu_run() knows the last exit was
> >    KVM_EXIT_UNSHARE and will set state to PRIVATE
>
> For case 1, userspace will set hypercall.ret =3D=3D 0, guest_memfd will d=
o
> the conversion, basically calling the same function that the ioctl calls
> within guest_memfd.
>
> > 5. Successful coordination, case 2, alternative 1: vcpu_run() knows
> >    the last exit was KVM_EXIT_UNSHARE
>
> Exit to userspace with KVM_EXIT_MEMORY_FAULT.
>
> > 5. Successful coordination, case 2, alternative 2: vcpu_run() knows
> >    the last exit was KVM_EXIT_UNSHARE
>
> Forward hypercall.ret =3D=3D 0 to the guest. Since the conversion was not
> performed, the next fault will be mismatched and there will be a
> KVM_EXIT_MEMORY_FAULT.

So far so good. With regard to the flow, in the code that I had, all
the specific details were arm64, and even pKVM specific. None of it
was baked into core KVM code, since of course, different
architectures, and even different VM types, will vary significantly.
Arm CCA for example is closer to TDX than it is to pKVM. Moreover, it
was just a hack at getting something reasonable that works, as a proof
of concept.

This is one of the reasons I'm not a fan of having a userspace IOCTL
as an additional required step as part of this protocol. KVM exits
already exist (*), and we need them anyway here. The flow above is
VM-type specific, and since much of it isn't exposed to the user: it's
easy (and likely) to change. Having an IOCTL and adding another step
in the process makes it more difficult to change things later.

(*) Try saying that ten times fast! Note: first word is exit, second
word is exist :)

> > Hi Vishal,
> >
> > On Tue, 20 May 2025 at 17:03, Vishal Annapurve <vannapurve@google.com> =
wrote:
> >>
> >> On Tue, May 20, 2025 at 7:34=E2=80=AFAM Fuad Tabba <tabba@google.com> =
wrote:
> >> >
> >> > Hi Vishal,
> >> >
> >> > On Tue, 20 May 2025 at 15:11, Vishal Annapurve <vannapurve@google.co=
m> wrote:
> >> > >
> >> > > On Tue, May 20, 2025 at 6:44=E2=80=AFAM Fuad Tabba <tabba@google.c=
om> wrote:
> >> > > >
> >> > > > Hi Vishal,
> >> > > >
> >> > > > On Tue, 20 May 2025 at 14:02, Vishal Annapurve <vannapurve@googl=
e.com> wrote:
> >> > > > >
> >> > > > > On Tue, May 20, 2025 at 2:23=E2=80=AFAM Fuad Tabba <tabba@goog=
le.com> wrote:
> >> > > > > >
> >> > > > > > Hi Ackerley,
> >> > > > > >
> >> > > > > > On Thu, 15 May 2025 at 00:43, Ackerley Tng <ackerleytng@goog=
le.com> wrote:
> >> > > > > > >
> >> > > > > > > The two new guest_memfd ioctls KVM_GMEM_CONVERT_SHARED and
> >> > > > > > > KVM_GMEM_CONVERT_PRIVATE convert the requested memory rang=
es to shared
> >> > > > > > > and private respectively.
> >> > > > > >
> >> > > > > > I have a high level question about this particular patch and=
 this
> >> > > > > > approach for conversion: why do we need IOCTLs to manage con=
version
> >> > > > > > between private and shared?
> >> > > > > >
> >> > > > > > In the presentations I gave at LPC [1, 2], and in my latest =
patch
> >> > > > > > series that performs in-place conversion [3] and the associa=
ted (by
> >> > > > > > now outdated) state diagram [4], I didn't see the need to ha=
ve a
> >> > > > > > userspace-facing interface to manage that. KVM has all the i=
nformation
> >> > > > > > it needs to handle conversions, which are triggered by the g=
uest. To
> >> > > > > > me this seems like it adds additional complexity, as well as=
 a user
> >> > > > > > facing interface that we would need to maintain.
> >> > > > > >
> >> > > > > > There are various ways we could handle conversion without ex=
plicit
> >> > > > > > interference from userspace. What I had in mind is the follo=
wing (as
> >> > > > > > an example, details can vary according to VM type). I will u=
se use the
> >> > > > > > case of conversion from shared to private because that is th=
e more
> >> > > > > > complicated (interesting) case:
> >> > > > > >
> >> > > > > > - Guest issues a hypercall to request that a shared folio be=
come private.
> >> > > > > >
> >> > > > > > - The hypervisor receives the call, and passes it to KVM.
> >> > > > > >
> >> > > > > > - KVM unmaps the folio from the guest stage-2 (EPT I think i=
n x86
> >> > > > > > parlance), and unmaps it from the host. The host however, co=
uld still
> >> > > > > > have references (e.g., GUP).
> >> > > > > >
> >> > > > > > - KVM exits to the host (hypervisor call exit), with the inf=
ormation
> >> > > > > > that the folio has been unshared from it.
> >> > > > > >
> >> > > > > > - A well behaving host would now get rid of all of its refer=
ences
> >> > > > > > (e.g., release GUPs), perform a VCPU run, and the guest cont=
inues
> >> > > > > > running as normal. I expect this to be the common case.
> >> > > > > >
> >> > > > > > But to handle the more interesting situation, let's say that=
 the host
> >> > > > > > doesn't do it immediately, and for some reason it holds on t=
o some
> >> > > > > > references to that folio.
> >> > > > > >
> >> > > > > > - Even if that's the case, the guest can still run *. If the=
 guest
> >> > > > > > tries to access the folio, KVM detects that access when it t=
ries to
> >> > > > > > fault it into the guest, sees that the host still has refere=
nces to
> >> > > > > > that folio, and exits back to the host with a memory fault e=
xit. At
> >> > > > > > this point, the VCPU that has tried to fault in that particu=
lar folio
> >> > > > > > cannot continue running as long as it cannot fault in that f=
olio.
> >> > > > >
> >> > > > > Are you talking about the following scheme?
> >> > > > > 1) guest_memfd checks shareability on each get pfn and if ther=
e is a
> >> > > > > mismatch exit to the host.
> >> > > >
> >> > > > I think we are not really on the same page here (no pun intended=
 :) ).
> >> > > > I'll try to answer your questions anyway...
> >> > > >
> >> > > > Which get_pfn? Are you referring to get_pfn when faulting the pa=
ge
> >> > > > into the guest or into the host?
> >> > >
> >> > > I am referring to guest fault handling in KVM.
> >> > >
> >> > > >
> >> > > > > 2) host user space has to guess whether it's a pending refcoun=
t or
> >> > > > > whether it's an actual mismatch.
> >> > > >
> >> > > > No need to guess. VCPU run will let it know exactly why it's exi=
ting.
> >> > > >
> >> > > > > 3) guest_memfd will maintain a third state
> >> > > > > "pending_private_conversion" or equivalent which will transiti=
on to
> >> > > > > private upon the last refcount drop of each page.
> >> > > > >
> >> > > > > If conversion is triggered by userspace (in case of pKVM, it w=
ill be
> >> > > > > triggered from within the KVM (?)):
> >> > > >
> >> > > > Why would conversion be triggered by userspace? As far as I know=
, it's
> >> > > > the guest that triggers the conversion.
> >> > > >
> >> > > > > * Conversion will just fail if there are extra refcounts and u=
serspace
> >> > > > > can try to get rid of extra refcounts on the range while it ha=
s enough
> >> > > > > context without hitting any ambiguity with memory fault exit.
> >> > > > > * guest_memfd will not have to deal with this extra state from=
 3 above
> >> > > > > and overall guest_memfd conversion handling becomes relatively
> >> > > > > simpler.
> >> > > >
> >> > > > That's not really related. The extra state isn't necessary any m=
ore
> >> > > > once we agreed in the previous discussion that we will retry ins=
tead.
> >> > >
> >> > > Who is *we* here? Which entity will retry conversion?
> >> >
> >> > Userspace will re-attempt the VCPU run.
> >>
> >> Then KVM will have to keep track of the ranges that need conversion
> >> across exits. I think it's cleaner to let userspace make the decision
> >> and invoke conversion without carrying additional state in KVM about
> >> guest request.
> >
> > I disagree. I think it's cleaner not to introduce a user interface,
> > and just to track the reason for the last exit, along with the
> > required additional data. KVM is responsible already for handling the
> > workflow, why delegate this last part to the VMM?
> >
>
> I believe Fuad's concern is the complexity of adding and maintaining
> another ioctl, as opposed to having vcpu_run() do the conversions.
>
> I think the two options are basically the same in that both are actually
> adding some form of user contract, just in different places.
>
> For the ioctl approach, in this RFCv2 I added a error_offset field so
> that userspace has a hint of where the conversion had an issue. the
> ioctl also returns errors to indicate what went wrong, like -EINVAL or
> -ENOMEM if perhaps splitting the page required memory and there wasn't
> any, or the kernel ran out of memory trying to update mappability.
>
> If we want to provide the same level of error information for the
> vcpu_run() approach, we should probably add error_offset to
> KVM_EXIT_MEMORY_FAULT so that on a conversion failure we could re-exit
> to userspace with more information about the error_offset.
>
>
> So what we're really comparing is two ways to perform the conversion (1)
> via a direct ioctl and (2) via vcpu_run().

That's exactly right.

> I think having a direct ioctl is cleaner because it doesn't involve
> vCPUs for a memory operation.
>
> Conceptually, the conversion is a memory operation belonging to memory
> in the guest_memfd. Hence, the conversion operation is better addressed
> directly to the memory via a direct ioctl.
>
> For this same reason, we didn't want to do the conversion via the
> KVM_SET_MEMORY_ATTRIBUTES ioctl. KVM_SET_MEMORY_ATTRIBUTES is an
> operation for KVM's view of guest_memfd, which is linked to but not
> directly the same as a memory operation.
>
> By having a direct ioctl over using KVM_SET_MEMORY_ATTRIBUTES, we avoid
> having a dependency where memslots must first be bound to guest_memfd
> for the conversion to work.
>
> When rebooting, the memslots may not yet be bound to the guest_memfd,
> but we want to reset the guest_memfd's to private. If we use
> KVM_SET_MEMORY_ATTRIBUTES to convert, we'd be forced to first bind, then
> convert. If we had a direct ioctl, we don't have this restriction.
>
> If we do the conversion via vcpu_run() we would be forced to handle
> conversions only with a vcpu_run() and only the guest can initiate a
> conversion.
>
> On a guest boot for TDX, the memory is assumed to be private. If the we
> gave it memory set as shared, we'd just have a bunch of
> KVM_EXIT_MEMORY_FAULTs that slow down boot. Hence on a guest reboot, we
> will want to reset the guest memory to private.
>
> We could say the firmware should reset memory to private on guest
> reboot, but we can't force all guests to update firmware.

Here is where I disagree. I do think that this is the CoCo guest's
responsibility (and by guest I include its firmware) to fix its own
state after a reboot. How would the host even know that a guest is
rebooting if it's a CoCo guest?

Either the host doesn't (or cannot even) know that the guest is
rebooting, in which case I don't see how having an IOCTL would help.
Or somehow the host does know that, i.e., via a hypercall that
indicates that. In which case, we could have it so that for that type
of VM, we would reconvert its pages to private on a reboot.

Additionally, we could introduce range operations for
sharing/unsharing, to avoid having to have an exit for every one.

> >> >
> >> > > >
> >> > > > > Note that for x86 CoCo cases, memory conversion is already tri=
ggered
> >> > > > > by userspace using KVM ioctl, this series is proposing to use
> >> > > > > guest_memfd ioctl to do the same.
> >> > > >
> >> > > > The reason why for x86 CoCo cases conversion is already triggere=
d by
> >> > > > userspace using KVM ioctl is that it has to, since shared memory=
 and
> >> > > > private memory are two separate pages, and userspace needs to ma=
nage
> >> > > > that. Sharing memory in place removes the need for that.
> >> > >
> >> > > Userspace still needs to clean up memory usage before conversion i=
s
> >> > > successful. e.g. remove IOMMU mappings for shared to private
> >> > > conversion. I would think that memory conversion should not succee=
d
> >> > > before all existing users let go of the guest_memfd pages for the
> >> > > range being converted.
> >> >
> >> > Yes. Userspace will know that it needs to do that on the VCPU exit,
> >> > which informs it of the guest's hypervisor request to unshare (conve=
rt
> >> > from shared to private) the page.
> >> >
> >> > > In x86 CoCo usecases, userspace can also decide to not allow
> >> > > conversion for scenarios where ranges are still under active use b=
y
> >> > > the host and guest is erroneously trying to take away memory. Both
> >> > > SNP/TDX spec allow failure of conversion due to in use memory.
> >> >
> >> > How can the guest erroneously try to take away memory? If the guest
> >> > sends a hypervisor request asking for a conversion of memory that
> >> > doesn't belong to it, then I would expect the hypervisor to prevent
> >> > that.
> >>
> >> Making a range as private is effectively disallowing host from
> >> accessing those ranges -> so taking away memory.
> >
> > You said "erroneously" earlier. My question is, how can the guest
> > *erroneously* try to take away memory? This is the normal flow of
> > guest/host relations. The memory is the guest's: it decides when to
> > share it with the host, and it can take it away.
> >
>
> See above, it's not really erroneous as long as we
> kvm_gmem_fault_shared() can still happen, since after unmapping, any
> host access will just fault the page again.

I was confused by the word "erroneous", as you would expect that for a
CoCo guest, the host wouldn't (or shouldn't) know the intention behind
a CoCo guest's access. I would expect that erroneous guest accesses
would be handled by the hypervisor. But I think we're on the same page
now.

> >> >
> >> > I don't see how having an IOCTL to trigger the conversion is needed =
to
> >> > allow conversion failure. How is that different from userspace
> >> > ignoring or delaying releasing all references it has for the
> >> > conversion request?
> >> >
> >> > > >
> >> > > > This series isn't using the same ioctl, it's introducing new one=
s to
> >> > > > perform a task that as far as I can tell so far, KVM can handle =
by
> >> > > > itself.
> >> > >
> >> > > I would like to understand this better. How will KVM handle the
> >> > > conversion process for guest_memfd pages? Can you help walk an exa=
mple
> >> > > sequence for shared to private conversion specifically around
> >> > > guest_memfd offset states?
> >> >
> >> > To make sure that we are discussing the same scenario: can you do th=
e
> >> > same as well please --- walk me through an example sequence for shar=
ed
> >> > to private conversion specifically around guest_memfd offset states
> >> > With the IOCTLs involved?
> >> >
> >> > Here is an example that I have implemented and tested with pKVM. Not=
e
> >> > that there are alternatives, the flow below is architecture or even
> >> > vm-type dependent. None of this code is code KVM code and the
> >> > behaviour could vary.
> >> >
> >> >
> >> > Assuming the folio is shared with the host:
> >> >
> >> > Guest sends unshare hypercall to the hypervisor
> >> > Hypervisor forwards request to KVM (gmem) (having done due diligence=
)
> >> > KVM (gmem) performs an unmap_folio(), exits to userspace with
> >>
> >> For x86 CoCo VM usecases I was talking about, userspace would like to
> >> avoid unmap_mapping_range() on the range before it's safe to unshare
> >> the range.
> >
> > Why? There is no harm in userspace unmapping before the memory isn't
> > shared. I don't see the problem with that.
> >
>
> Yes, no harm done, just possible remapping after unmapping.
>
> > You still haven't responded to my question from the previous email:
> > can you please return the favor and walk me through an example
> > sequence for shared to private conversion specifically around
> > guest_memfd offset states with the IOCTLs involved? :D
> >
>
> Right at the top :)

Thank you Ackerley!

Cheers,
/fuad

>
> > Thanks!
> > /fuad
> >
> >
> >> > KVM_EXIT_UNSHARE and all the information about the folio being
> >> > unshared
> >> >
> >> > Case 1:
> >> > Userspace removes any remaining references (GUPs, IOMMU Mappings etc=
...)
> >> > Userspace calls vcpu_run(): KVM (gmem) sees that there aren't any
> >> > references, sets state to PRIVATE
> >> >
> >> > Case 2 (alternative 1):
> >> > Userspace doesn't release its references
> >> > Userspace calls vcpu_run(): KVM (gmem) sees that there are still
> >> > references, exits back to userspace with KVM_EXIT_UNSHARE
> >> >
> >> > Case 2 (alternative 2):
> >> > Userspace doesn't release its references
> >> > Userspace calls vcpu_run(): KVM (gmem) sees that there are still
> >> > references, unmaps folio from guest, but allows it to run (until it
> >> > tries to fault in the folio)
> >> > Guest tries to fault in folio that still has reference, KVM does not
> >> > allow that (it sees that the folio is shared, and it doesn't fault i=
n
> >> > shared folios to confidential guests)
> >> > KVM exits back to userspace with KVM_EXIT_UNSHARE
> >> >
> >> > As I mentioned, the alternatives above are _not_ set in core KVM cod=
e.
> >> > They can vary by architecture of VM type, depending on the policy,
> >> > support, etc..
> >> >
> >> > Now for your example please on how this would work with IOCTLs :)
> >> >
> >> > Thanks,
> >> > /fuad
> >> >
> >> > > >
> >> > > > >  - Allows not having to keep track of separate shared/private =
range
> >> > > > > information in KVM.
> >> > > >
> >> > > > This patch series is already tracking shared/private range infor=
mation in KVM.
> >> > > >
> >> > > > >  - Simpler handling of the conversion process done per guest_m=
emfd
> >> > > > > rather than for full range.
> >> > > > >      - Userspace can handle the rollback as needed, simplifyin=
g error
> >> > > > > handling in guest_memfd.
> >> > > > >  - guest_memfd is single source of truth and notifies the user=
s of
> >> > > > > shareability change.
> >> > > > >      - e.g. IOMMU, userspace, KVM MMU all can be registered fo=
r
> >> > > > > getting notifications from guest_memfd directly and will get n=
otified
> >> > > > > for invalidation upon shareability attribute updates.
> >> > > >
> >> > > > All of these can still be done without introducing a new ioctl.
> >> > > >
> >> > > > Cheers,
> >> > > > /fuad


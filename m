Return-Path: <linux-fsdevel+bounces-49544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B557ABE3E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 21:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF5D4C3111
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A32D283125;
	Tue, 20 May 2025 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZOpKewe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D226B2CC
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770043; cv=none; b=lGVytaJFBJPRChaltX1MNceNlroaPY2wTcTMv1sRNUwNf3MQkN+13IvA2KgdtR33J6NI/M0CQ2zQKQQ0cYtezpd+FT4n+u6YbSNkaXcg2ujEHcb9BUf+qQspe30SnGacfp99q8VFdl+kjVJJqCJUwfSUGJcQFojIdC3a/GUdpxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770043; c=relaxed/simple;
	bh=fm+502XADc2G9nNO2APQpwxYeviPs9VHoh+nNJsZHt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MyU+QVFqducEuSX+EmsFyRdBrVU/9VtvBRBpcIt2Cl3IbLtAyYgc20Kp+zWPcKZafAQNJDkb5YqJ0QjBm0ukAaU/PVpr6AQgzxW/+waVOHWOWb8vyfE7ZsbHVPMha2bDGkl4i4lhpzznmQLUKMlHUCbf22idc3B+dN+TGJhXd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZOpKewe; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742a091d290so4147111b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747770041; x=1748374841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iA4tiCdrSOL4EHJEWVD9nbZEVH0SDu5YlSIWNe/VkgI=;
        b=iZOpKewe+/ZeshrFBgvJHjVTZ0yMnIHAfZdtqMNZ0P4pmaNO9+jUiksnWXlXkakCwT
         lRivOP3iGTn28vcqzZFnswd30MC9/VxJh3xTYTdn1B8hREDrbHX4qkhWC2Ilw5pZAwoa
         fXBb9ic8hBQg4NX0fm/RMSiIGawtVSbQJWh95w7cl6sscpnRJtsoEf1yHjUYfGB94CBc
         NisxlbD8cehrECn6VFQ/Snj80ltgsyAOPYxV0MrPpY6d2WnWfqJURzhzeaznhVoklv85
         4zYPkPqnS/vcLKKkGP7INfrl/gqAb6HFajhzZZDMI/chkYD/6V3WQsKj8cS/JyVYqbix
         2Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747770041; x=1748374841;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iA4tiCdrSOL4EHJEWVD9nbZEVH0SDu5YlSIWNe/VkgI=;
        b=Fwpe8jqtkPfJNzA17CXjJ3uVvV0Asb3tm1Sc+39blNs1fajwCJoVtZBIpr+HQlUbI3
         e/uVlA0awul9XFiZGRVBOEa+g3N1xp+XINqJ/PuRNeVQsXXB7mlFkpu10Dy9ib4tR5g2
         9Op+ac4Esf2SkXooZJ3AKAxS7jbv9RN/UL6wjIBUseym86LSUOInsRdWPtEQYhgETpEg
         ph2pAZ9ifDyRFwR2W2JsfO9aOGPMxRWvEIsciGgukaaymIETEiOPDG7ps8+TU3KEQe9G
         3g88jB511p4xFIfUSCHmZwBxENOo0JZsVmnNe9XrFMU6+GZkiyFVuTM6H4fzYq18GXpP
         rssw==
X-Forwarded-Encrypted: i=1; AJvYcCUUq5y4MVfNjcgWEHqT8LtYuz93+jbLNZvgbwAX83B202sbw3MDEYRZJRMFxUg3sEBLguoXNj4T2eNiTDvO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LH/PNCDbE7fw9ud41l+ipSjPPUWIqGN6rsPdFuUNUc0unM/9
	dlNMfgf9n5jVXhBePOwfZFbYQAK35bTMZpDxTRDJBUbQnm0CDSSfH9Igah1XKPjeisSjfj0KYec
	4tCd9ta1wq9pf2ivInR0EnzWJEw==
X-Google-Smtp-Source: AGHT+IH6YYNKkDpHJYVNEQ5xKgCYEMiinbQ21xBPWMVlsfcl+0SsrbzzEJh9BSPuaHYUz+vKJx4qQDH8jk+v7sFYOQ==
X-Received: from pfgt17.prod.google.com ([2002:a05:6a00:1391:b0:73e:780:270e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a88f:b0:736:33fd:f57d with SMTP id d2e1a72fcca58-742a98a32e1mr18985282b3a.17.1747770040431;
 Tue, 20 May 2025 12:40:40 -0700 (PDT)
Date: Tue, 20 May 2025 12:40:38 -0700
In-Reply-To: <CA+EHjTzMhKCoftfJUuL0WUZW4DdqOHgVDcn0Cmf-0r--8rBdbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <CA+EHjTy7iBNBb9DRdtgq8oYmvgykhSNvZL3FrRV4XF90t3XgBg@mail.gmail.com>
 <CAGtprH_7jSpwF77j1GW8rjSrbtZZ2OW2iGck5=Wk67+VnF9vjQ@mail.gmail.com> <CA+EHjTzMhKCoftfJUuL0WUZW4DdqOHgVDcn0Cmf-0r--8rBdbg@mail.gmail.com>
Message-ID: <diqzecwjnk95.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
From: Ackerley Tng <ackerleytng@google.com>
To: Fuad Tabba <tabba@google.com>, Vishal Annapurve <vannapurve@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Fuad Tabba <tabba@google.com> writes:

Let me try to bridge the gap here beginning with the flow we were
counting on for a shared to private conversion, for TDX:

1. Guest sends unshare hypercall to the hypervisor

2. (For x86 IIUC hypervisor is the same as KVM) KVM forwards the request
   to userspace via a KVM_EXIT_HYPERCALL, with KVM_HC_MAP_GPA_RANGE as
   the hypercall number.

   KVM also records that the guest wanted a shared to private
   conversion, the gpa and size of the request (no change from now, KVM
   already records that information in struct kvm_run) [1]

3. Userspace will do necessary coordination in userspace, then call the
   conversion ioctl, passing the parameters along to the ioctl.

4. Ioctl goes to guest_memfd, guest_memfd unmaps the pages, checks
   refcounts. If there's anything unexpected, error out to userspace. If
   all is well, flip shareability, exit to userspace with success.

5. Userspace calls vcpu_run() again, the handler for
   KVM_HC_MAP_GPA_RANGE will tell the guest that userspace was able to
   fulfill guest request with hypercall.ret set to 0 and then the guest
   will continue.

6. On the next fault guest_memfd will allow the private fault from the
   guest.


The flow you're proposing works too, with some changes, but it's
probably okay for x86 to have a slightly different flow anyway: (I
refactored the steps you outlined)

> 1. Guest sends unshare hypercall to the hypervisor

Same

> 2. Hypervisor forwards request to KVM (gmem) (having done due diligence)

For x86 IIUC hypervisor is the same as KVM, so there's no forwarding to KVM=
.

> 3. KVM (gmem) performs an unmap_folio(), exits to userspace with
>    KVM_EXIT_UNSHARE and all the information about the folio being unshare=
d

The KVM_EXIT_UNSHARE here would correspond to x86's
KVM_HC_MAP_GPA_RANGE.

Unmapping before exiting with KVM_EXIT_UNSHARE here might be a little
premature since userspace may have to do some stuff before permitting
the conversion. For example, the memory may be mapped into another
userspace driver process, which needs to first be stopped.

But no issue though, as long as we don't flip shareability, if the host
uses the memory, the kvm_gmem_fault_shared() will just happen again,
nullifying the unmapping.

We could just shift the unmapping till after vcpu_run() is called
again.

> 4. Userspace will do necessary coordination in userspace, then do
>    vcpu_run()

There's another layer here, at least for x86, as to whether the
coordination was successful. For x86's KVM_HC_MAP_GPA_RANGE, userspace
can indicate a non-zero hypercall.ret for error.

For unsuccessful coordinations, userspace sets hypercall.ret to error
and the vcpu_run() handler doesn't try the conversion. Guest is informed
of hypercall error and guest will figure it out.

> 5. Successful coordination, case 1: vcpu_run() knows the last exit was
>    KVM_EXIT_UNSHARE and will set state to PRIVATE

For case 1, userspace will set hypercall.ret =3D=3D 0, guest_memfd will do
the conversion, basically calling the same function that the ioctl calls
within guest_memfd.

> 5. Successful coordination, case 2, alternative 1: vcpu_run() knows
>    the last exit was KVM_EXIT_UNSHARE

Exit to userspace with KVM_EXIT_MEMORY_FAULT.

> 5. Successful coordination, case 2, alternative 2: vcpu_run() knows
>    the last exit was KVM_EXIT_UNSHARE

Forward hypercall.ret =3D=3D 0 to the guest. Since the conversion was not
performed, the next fault will be mismatched and there will be a
KVM_EXIT_MEMORY_FAULT.

> Hi Vishal,
>
> On Tue, 20 May 2025 at 17:03, Vishal Annapurve <vannapurve@google.com> wr=
ote:
>>
>> On Tue, May 20, 2025 at 7:34=E2=80=AFAM Fuad Tabba <tabba@google.com> wr=
ote:
>> >
>> > Hi Vishal,
>> >
>> > On Tue, 20 May 2025 at 15:11, Vishal Annapurve <vannapurve@google.com>=
 wrote:
>> > >
>> > > On Tue, May 20, 2025 at 6:44=E2=80=AFAM Fuad Tabba <tabba@google.com=
> wrote:
>> > > >
>> > > > Hi Vishal,
>> > > >
>> > > > On Tue, 20 May 2025 at 14:02, Vishal Annapurve <vannapurve@google.=
com> wrote:
>> > > > >
>> > > > > On Tue, May 20, 2025 at 2:23=E2=80=AFAM Fuad Tabba <tabba@google=
.com> wrote:
>> > > > > >
>> > > > > > Hi Ackerley,
>> > > > > >
>> > > > > > On Thu, 15 May 2025 at 00:43, Ackerley Tng <ackerleytng@google=
.com> wrote:
>> > > > > > >
>> > > > > > > The two new guest_memfd ioctls KVM_GMEM_CONVERT_SHARED and
>> > > > > > > KVM_GMEM_CONVERT_PRIVATE convert the requested memory ranges=
 to shared
>> > > > > > > and private respectively.
>> > > > > >
>> > > > > > I have a high level question about this particular patch and t=
his
>> > > > > > approach for conversion: why do we need IOCTLs to manage conve=
rsion
>> > > > > > between private and shared?
>> > > > > >
>> > > > > > In the presentations I gave at LPC [1, 2], and in my latest pa=
tch
>> > > > > > series that performs in-place conversion [3] and the associate=
d (by
>> > > > > > now outdated) state diagram [4], I didn't see the need to have=
 a
>> > > > > > userspace-facing interface to manage that. KVM has all the inf=
ormation
>> > > > > > it needs to handle conversions, which are triggered by the gue=
st. To
>> > > > > > me this seems like it adds additional complexity, as well as a=
 user
>> > > > > > facing interface that we would need to maintain.
>> > > > > >
>> > > > > > There are various ways we could handle conversion without expl=
icit
>> > > > > > interference from userspace. What I had in mind is the followi=
ng (as
>> > > > > > an example, details can vary according to VM type). I will use=
 use the
>> > > > > > case of conversion from shared to private because that is the =
more
>> > > > > > complicated (interesting) case:
>> > > > > >
>> > > > > > - Guest issues a hypercall to request that a shared folio beco=
me private.
>> > > > > >
>> > > > > > - The hypervisor receives the call, and passes it to KVM.
>> > > > > >
>> > > > > > - KVM unmaps the folio from the guest stage-2 (EPT I think in =
x86
>> > > > > > parlance), and unmaps it from the host. The host however, coul=
d still
>> > > > > > have references (e.g., GUP).
>> > > > > >
>> > > > > > - KVM exits to the host (hypervisor call exit), with the infor=
mation
>> > > > > > that the folio has been unshared from it.
>> > > > > >
>> > > > > > - A well behaving host would now get rid of all of its referen=
ces
>> > > > > > (e.g., release GUPs), perform a VCPU run, and the guest contin=
ues
>> > > > > > running as normal. I expect this to be the common case.
>> > > > > >
>> > > > > > But to handle the more interesting situation, let's say that t=
he host
>> > > > > > doesn't do it immediately, and for some reason it holds on to =
some
>> > > > > > references to that folio.
>> > > > > >
>> > > > > > - Even if that's the case, the guest can still run *. If the g=
uest
>> > > > > > tries to access the folio, KVM detects that access when it tri=
es to
>> > > > > > fault it into the guest, sees that the host still has referenc=
es to
>> > > > > > that folio, and exits back to the host with a memory fault exi=
t. At
>> > > > > > this point, the VCPU that has tried to fault in that particula=
r folio
>> > > > > > cannot continue running as long as it cannot fault in that fol=
io.
>> > > > >
>> > > > > Are you talking about the following scheme?
>> > > > > 1) guest_memfd checks shareability on each get pfn and if there =
is a
>> > > > > mismatch exit to the host.
>> > > >
>> > > > I think we are not really on the same page here (no pun intended :=
) ).
>> > > > I'll try to answer your questions anyway...
>> > > >
>> > > > Which get_pfn? Are you referring to get_pfn when faulting the page
>> > > > into the guest or into the host?
>> > >
>> > > I am referring to guest fault handling in KVM.
>> > >
>> > > >
>> > > > > 2) host user space has to guess whether it's a pending refcount =
or
>> > > > > whether it's an actual mismatch.
>> > > >
>> > > > No need to guess. VCPU run will let it know exactly why it's exiti=
ng.
>> > > >
>> > > > > 3) guest_memfd will maintain a third state
>> > > > > "pending_private_conversion" or equivalent which will transition=
 to
>> > > > > private upon the last refcount drop of each page.
>> > > > >
>> > > > > If conversion is triggered by userspace (in case of pKVM, it wil=
l be
>> > > > > triggered from within the KVM (?)):
>> > > >
>> > > > Why would conversion be triggered by userspace? As far as I know, =
it's
>> > > > the guest that triggers the conversion.
>> > > >
>> > > > > * Conversion will just fail if there are extra refcounts and use=
rspace
>> > > > > can try to get rid of extra refcounts on the range while it has =
enough
>> > > > > context without hitting any ambiguity with memory fault exit.
>> > > > > * guest_memfd will not have to deal with this extra state from 3=
 above
>> > > > > and overall guest_memfd conversion handling becomes relatively
>> > > > > simpler.
>> > > >
>> > > > That's not really related. The extra state isn't necessary any mor=
e
>> > > > once we agreed in the previous discussion that we will retry inste=
ad.
>> > >
>> > > Who is *we* here? Which entity will retry conversion?
>> >
>> > Userspace will re-attempt the VCPU run.
>>
>> Then KVM will have to keep track of the ranges that need conversion
>> across exits. I think it's cleaner to let userspace make the decision
>> and invoke conversion without carrying additional state in KVM about
>> guest request.
>
> I disagree. I think it's cleaner not to introduce a user interface,
> and just to track the reason for the last exit, along with the
> required additional data. KVM is responsible already for handling the
> workflow, why delegate this last part to the VMM?
>

I believe Fuad's concern is the complexity of adding and maintaining
another ioctl, as opposed to having vcpu_run() do the conversions.

I think the two options are basically the same in that both are actually
adding some form of user contract, just in different places.

For the ioctl approach, in this RFCv2 I added a error_offset field so
that userspace has a hint of where the conversion had an issue. the
ioctl also returns errors to indicate what went wrong, like -EINVAL or
-ENOMEM if perhaps splitting the page required memory and there wasn't
any, or the kernel ran out of memory trying to update mappability.

If we want to provide the same level of error information for the
vcpu_run() approach, we should probably add error_offset to
KVM_EXIT_MEMORY_FAULT so that on a conversion failure we could re-exit
to userspace with more information about the error_offset.


So what we're really comparing is two ways to perform the conversion (1)
via a direct ioctl and (2) via vcpu_run().

I think having a direct ioctl is cleaner because it doesn't involve
vCPUs for a memory operation.

Conceptually, the conversion is a memory operation belonging to memory
in the guest_memfd. Hence, the conversion operation is better addressed
directly to the memory via a direct ioctl.

For this same reason, we didn't want to do the conversion via the
KVM_SET_MEMORY_ATTRIBUTES ioctl. KVM_SET_MEMORY_ATTRIBUTES is an
operation for KVM's view of guest_memfd, which is linked to but not
directly the same as a memory operation.

By having a direct ioctl over using KVM_SET_MEMORY_ATTRIBUTES, we avoid
having a dependency where memslots must first be bound to guest_memfd
for the conversion to work.

When rebooting, the memslots may not yet be bound to the guest_memfd,
but we want to reset the guest_memfd's to private. If we use
KVM_SET_MEMORY_ATTRIBUTES to convert, we'd be forced to first bind, then
convert. If we had a direct ioctl, we don't have this restriction.

If we do the conversion via vcpu_run() we would be forced to handle
conversions only with a vcpu_run() and only the guest can initiate a
conversion.

On a guest boot for TDX, the memory is assumed to be private. If the we
gave it memory set as shared, we'd just have a bunch of
KVM_EXIT_MEMORY_FAULTs that slow down boot. Hence on a guest reboot, we
will want to reset the guest memory to private.

We could say the firmware should reset memory to private on guest
reboot, but we can't force all guests to update firmware.

>> >
>> > > >
>> > > > > Note that for x86 CoCo cases, memory conversion is already trigg=
ered
>> > > > > by userspace using KVM ioctl, this series is proposing to use
>> > > > > guest_memfd ioctl to do the same.
>> > > >
>> > > > The reason why for x86 CoCo cases conversion is already triggered =
by
>> > > > userspace using KVM ioctl is that it has to, since shared memory a=
nd
>> > > > private memory are two separate pages, and userspace needs to mana=
ge
>> > > > that. Sharing memory in place removes the need for that.
>> > >
>> > > Userspace still needs to clean up memory usage before conversion is
>> > > successful. e.g. remove IOMMU mappings for shared to private
>> > > conversion. I would think that memory conversion should not succeed
>> > > before all existing users let go of the guest_memfd pages for the
>> > > range being converted.
>> >
>> > Yes. Userspace will know that it needs to do that on the VCPU exit,
>> > which informs it of the guest's hypervisor request to unshare (convert
>> > from shared to private) the page.
>> >
>> > > In x86 CoCo usecases, userspace can also decide to not allow
>> > > conversion for scenarios where ranges are still under active use by
>> > > the host and guest is erroneously trying to take away memory. Both
>> > > SNP/TDX spec allow failure of conversion due to in use memory.
>> >
>> > How can the guest erroneously try to take away memory? If the guest
>> > sends a hypervisor request asking for a conversion of memory that
>> > doesn't belong to it, then I would expect the hypervisor to prevent
>> > that.
>>
>> Making a range as private is effectively disallowing host from
>> accessing those ranges -> so taking away memory.
>
> You said "erroneously" earlier. My question is, how can the guest
> *erroneously* try to take away memory? This is the normal flow of
> guest/host relations. The memory is the guest's: it decides when to
> share it with the host, and it can take it away.
>

See above, it's not really erroneous as long as we
kvm_gmem_fault_shared() can still happen, since after unmapping, any
host access will just fault the page again.

>> >
>> > I don't see how having an IOCTL to trigger the conversion is needed to
>> > allow conversion failure. How is that different from userspace
>> > ignoring or delaying releasing all references it has for the
>> > conversion request?
>> >
>> > > >
>> > > > This series isn't using the same ioctl, it's introducing new ones =
to
>> > > > perform a task that as far as I can tell so far, KVM can handle by
>> > > > itself.
>> > >
>> > > I would like to understand this better. How will KVM handle the
>> > > conversion process for guest_memfd pages? Can you help walk an examp=
le
>> > > sequence for shared to private conversion specifically around
>> > > guest_memfd offset states?
>> >
>> > To make sure that we are discussing the same scenario: can you do the
>> > same as well please --- walk me through an example sequence for shared
>> > to private conversion specifically around guest_memfd offset states
>> > With the IOCTLs involved?
>> >
>> > Here is an example that I have implemented and tested with pKVM. Note
>> > that there are alternatives, the flow below is architecture or even
>> > vm-type dependent. None of this code is code KVM code and the
>> > behaviour could vary.
>> >
>> >
>> > Assuming the folio is shared with the host:
>> >
>> > Guest sends unshare hypercall to the hypervisor
>> > Hypervisor forwards request to KVM (gmem) (having done due diligence)
>> > KVM (gmem) performs an unmap_folio(), exits to userspace with
>>
>> For x86 CoCo VM usecases I was talking about, userspace would like to
>> avoid unmap_mapping_range() on the range before it's safe to unshare
>> the range.
>
> Why? There is no harm in userspace unmapping before the memory isn't
> shared. I don't see the problem with that.
>

Yes, no harm done, just possible remapping after unmapping.

> You still haven't responded to my question from the previous email:
> can you please return the favor and walk me through an example
> sequence for shared to private conversion specifically around
> guest_memfd offset states with the IOCTLs involved? :D
>

Right at the top :)

> Thanks!
> /fuad
>
>
>> > KVM_EXIT_UNSHARE and all the information about the folio being
>> > unshared
>> >
>> > Case 1:
>> > Userspace removes any remaining references (GUPs, IOMMU Mappings etc..=
.)
>> > Userspace calls vcpu_run(): KVM (gmem) sees that there aren't any
>> > references, sets state to PRIVATE
>> >
>> > Case 2 (alternative 1):
>> > Userspace doesn't release its references
>> > Userspace calls vcpu_run(): KVM (gmem) sees that there are still
>> > references, exits back to userspace with KVM_EXIT_UNSHARE
>> >
>> > Case 2 (alternative 2):
>> > Userspace doesn't release its references
>> > Userspace calls vcpu_run(): KVM (gmem) sees that there are still
>> > references, unmaps folio from guest, but allows it to run (until it
>> > tries to fault in the folio)
>> > Guest tries to fault in folio that still has reference, KVM does not
>> > allow that (it sees that the folio is shared, and it doesn't fault in
>> > shared folios to confidential guests)
>> > KVM exits back to userspace with KVM_EXIT_UNSHARE
>> >
>> > As I mentioned, the alternatives above are _not_ set in core KVM code.
>> > They can vary by architecture of VM type, depending on the policy,
>> > support, etc..
>> >
>> > Now for your example please on how this would work with IOCTLs :)
>> >
>> > Thanks,
>> > /fuad
>> >
>> > > >
>> > > > >  - Allows not having to keep track of separate shared/private ra=
nge
>> > > > > information in KVM.
>> > > >
>> > > > This patch series is already tracking shared/private range informa=
tion in KVM.
>> > > >
>> > > > >  - Simpler handling of the conversion process done per guest_mem=
fd
>> > > > > rather than for full range.
>> > > > >      - Userspace can handle the rollback as needed, simplifying =
error
>> > > > > handling in guest_memfd.
>> > > > >  - guest_memfd is single source of truth and notifies the users =
of
>> > > > > shareability change.
>> > > > >      - e.g. IOMMU, userspace, KVM MMU all can be registered for
>> > > > > getting notifications from guest_memfd directly and will get not=
ified
>> > > > > for invalidation upon shareability attribute updates.
>> > > >
>> > > > All of these can still be done without introducing a new ioctl.
>> > > >
>> > > > Cheers,
>> > > > /fuad


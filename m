Return-Path: <linux-fsdevel+bounces-57487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE935B220BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F35F2A13F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889D2E2640;
	Tue, 12 Aug 2025 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+11peqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB72E1751
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987083; cv=none; b=P9XvE3gzKHClB95fSeDdp3crbWrH3phSPAMvg17mjoWSoXR/r9FGCOuh/aUUewgOD4pHjkT+SipfXrh3hEhTqiBdg0eKJKFA1WH1uz+fzHkbX6uVWR+j0pFD1U/l5VXYDO23cT/TqF1xK2lvna6up6a1tVKAUfVCKEPeAGyhFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987083; c=relaxed/simple;
	bh=cSDzSaZ4CKCL1NUR9ReIVfNZeYk0MZZWkgdJ0rjrBys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM0LPAVDbPumztd8DI7whmubB1k8lU4FLUQzSHyL2GLUesJ/1452mDErgac4L/OTooA+gejC7cre6AHv+s8ejytgyV0g3R3gt5Y4LOQWvL6wKu5YJyMA1u3Ac5COYFtLaEDM+p27Sp6NqUjB0hUYTapCXtbTPpoSOqyNB1SIMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+11peqR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so51355e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754987079; x=1755591879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bneKlVsaWJ9LwBazq6i/ZM98csppJP4SCJnqnbu7S2c=;
        b=a+11peqR6g+BERzV3r76XWsXvtD0+UHqNdqxP3czCfd9eA7QN0b7SyaiEEs1Ei0ngq
         S8HBZWmcAlj44Ug3LAaYcrPfoa3ibCmJ/tYwacovrZnrS2SpOp80F2dRvlKjMESRexx6
         Y1xr69EsMXivv6NGLN9hnlv2QPoeauhcGZqGFQ8nVYLkFFDXPrbmlxbf0B2jnymOwMYl
         isjGXtGhPG2VxvPTFMURP/Th3PnWh2DNDDnHGa4W7UYPtbZ+Q1DQwJUJPKhtYxKCuYtq
         BNkMivZ2Ys8O8FwlUuN1pKTgwL7xttsDCTTw34pkUgcwJ1QWbX10EdmX6SjvG6C+OsKy
         8Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987079; x=1755591879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bneKlVsaWJ9LwBazq6i/ZM98csppJP4SCJnqnbu7S2c=;
        b=ln/5NQxkfCQMRFXz5Cd93rsguq170G9PjYq3oPAwmGRzNsgJ6XkBc6RN/2Corhxuoz
         kZs/kT6jCHJaY1mlNB6lJ8gpBSBfiWdb5yS1KmwMC0ATR1XVBtoHLq3i3xHsn17zGDKd
         jgF5G+ouKKvVtPEfsgAzTz2RlbqQ4KYGJpPpoM69VLZmzNCHyKe8AsPV9yD06gSn35sM
         I77Qb8LiixJV1Jl859SnjK/Dmsbxaemp/Q81959CCRuEXHX49JMVww2DOihn21eLuCXr
         9ONFu7xezkhExwSiHmdX3apBr6yGMPnOORQI3JsUpeduCTI/JfiXLLjig74FMixd8q3p
         eslQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/7oqCIBx1CHT2rn73+GZKEWqY/NB8igDJaY1sfsniO4EZnuEMJvrhJIuV3J8UDo5FSyJJ/ddmZ2cwiXIb@vger.kernel.org
X-Gm-Message-State: AOJu0YwEmFm2Zwnic/rTJ4iT5vUJJxgXqktqJBthK3rgq/dS1tlUuvpZ
	aMnIcrk2hOezQ2N1FYid+thgEklp8nNE5ids8Q9da5EbOsU7DbP56OTLr6yPRVT72FhLvjR1jIg
	sQYXfiFk3uyCjxPdkplJFPWm+9MiL2mnON8p4lcdW38d02ud39xRuPSXV
X-Gm-Gg: ASbGncs2voAZ0MgS8IHt2r/9PjV6z3pqHERsDTjqDhQeR4zgLc/6OQGkkGAKwVGVGai
	CTpap+B5C1/nzu/D9oBrzfuRRtXTJ1Yw/2qkONBYu5T4i9gRgPwjUxId4Ko+8rmV4NQ9Es8Z6F0
	vjXxCXZpyxG+1ViK/LwmVDno1qX0Q0yc87SKvcI4dQ4KYI3oGU1yO/rJDUKSO9ieAYJA1rD+dmk
	orOdGAP0nmRhjL2TKbEW4oBuv08rT55dfjC
X-Google-Smtp-Source: AGHT+IG/qyfF019YZUtxf0yP7+Ftaes5KMmyohuSN7pp/hczy5CVky7X7Edkb3DmCvgfjP8sJWg7D7zcGL13KnCyMKE=
X-Received: by 2002:a05:600c:899:b0:458:b4ae:41a0 with SMTP id
 5b1f17b1804b1-45a118d4771mr584345e9.5.1754987078235; Tue, 12 Aug 2025
 01:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com> <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
 <20250702232517.k2nqwggxfpfp3yym@amd.com> <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
 <20250703041210.uc4ygp4clqw2h6yd@amd.com>
In-Reply-To: <20250703041210.uc4ygp4clqw2h6yd@amd.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 12 Aug 2025 09:23:52 +0100
X-Gm-Features: Ac12FXxVRNQ9gNwKyAuJ3h4ftK0vQMzMuNHgVqkbKXa4WFdUTM-o4on2lZ1GtQM
Message-ID: <CA+EHjTxZO-1nvDhxM7oBdpgrVq2NcgKrGvrCoiPqX4NPWGvt4w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
To: Michael Roth <michael.roth@amd.com>
Cc: Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
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
	mic@digikod.net, mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com, 
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
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

Hi,

On Thu, 3 Jul 2025 at 05:12, Michael Roth <michael.roth@amd.com> wrote:
>
> On Wed, Jul 02, 2025 at 05:46:23PM -0700, Vishal Annapurve wrote:
> > On Wed, Jul 2, 2025 at 4:25=E2=80=AFPM Michael Roth <michael.roth@amd.c=
om> wrote:
> > >
> > > On Wed, Jun 11, 2025 at 02:51:38PM -0700, Ackerley Tng wrote:
> > > > Michael Roth <michael.roth@amd.com> writes:
> > > >
> > > > > On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
> > > > >> Track guest_memfd memory's shareability status within the inode =
as
> > > > >> opposed to the file, since it is property of the guest_memfd's m=
emory
> > > > >> contents.
> > > > >>
> > > > >> Shareability is a property of the memory and is indexed using th=
e
> > > > >> page's index in the inode. Because shareability is the memory's
> > > > >> property, it is stored within guest_memfd instead of within KVM,=
 like
> > > > >> in kvm->mem_attr_array.
> > > > >>
> > > > >> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still b=
e
> > > > >> retained to allow VMs to only use guest_memfd for private memory=
 and
> > > > >> some other memory for shared memory.
> > > > >>
> > > > >> Not all use cases require guest_memfd() to be shared with the ho=
st
> > > > >> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVAT=
E,
> > > > >> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory=
 as
> > > > >> private to the guest, and therefore not mappable by the
> > > > >> host. Otherwise, memory is shared until explicitly converted to
> > > > >> private.
> > > > >>
> > > > >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > > >> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> > > > >> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > > > >> Co-developed-by: Fuad Tabba <tabba@google.com>
> > > > >> Signed-off-by: Fuad Tabba <tabba@google.com>
> > > > >> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
> > > > >> ---
> > > > >>  Documentation/virt/kvm/api.rst |   5 ++
> > > > >>  include/uapi/linux/kvm.h       |   2 +
> > > > >>  virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++=
++++++-
> > > > >>  3 files changed, 129 insertions(+), 2 deletions(-)
> > > > >>
> > > > >> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt=
/kvm/api.rst
> > > > >> index 86f74ce7f12a..f609337ae1c2 100644
> > > > >> --- a/Documentation/virt/kvm/api.rst
> > > > >> +++ b/Documentation/virt/kvm/api.rst
> > > > >> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_a=
ddr.
> > > > >>  The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed =
for CoCo VMs.
> > > > >>  This is validated when the guest_memfd instance is bound to the=
 VM.
> > > > >>
> > > > >> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then t=
he 'flags' field
> > > > >> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.  Setting GUEST_MEMFD_FL=
AG_INIT_PRIVATE
> > > > >> +will initialize the memory for the guest_memfd as guest-only an=
d not faultable
> > > > >> +by the host.
> > > > >> +
> > > > >
> > > > > KVM_CAP_GMEM_CONVERSION doesn't get introduced until later, so it=
 seems
> > > > > like this flag should be deferred until that patch is in place. I=
s it
> > > > > really needed at that point though? Userspace would be able to se=
t the
> > > > > initial state via KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls.
> > > > >
> > > >
> > > > I can move this change to the later patch. Thanks! Will fix in the =
next
> > > > revision.
> > > >
> > > > > The mtree contents seems to get stored in the same manner in eith=
er case so
> > > > > performance-wise only the overhead of a few userspace<->kernel sw=
itches
> > > > > would be saved. Are there any other reasons?
> > > > >
> > > > > Otherwise, maybe just settle on SHARED as a documented default (s=
ince at
> > > > > least non-CoCo VMs would be able to reliably benefit) and let
> > > > > CoCo/GUEST_MEMFD_FLAG_SUPPORT_SHARED VMs set PRIVATE at whatever
> > > > > granularity makes sense for the architecture/guest configuration.
> > > > >
> > > >
> > > > Because shared pages are split once any memory is allocated, having=
 a
> > > > way to INIT_PRIVATE could avoid the split and then merge on
> > > > conversion. I feel that is enough value to have this config flag, w=
hat
> > > > do you think?
> > > >
> > > > I guess we could also have userspace be careful not to do any alloc=
ation
> > > > before converting.
>
> (Re-visiting this with the assumption that we *don't* intend to use mmap(=
) to
> populate memory (in which case you can pretty much ignore my previous
> response))
>
> I'm still not sure where the INIT_PRIVATE flag comes into play. For SNP,
> userspace already defaults to marking everything private pretty close to
> guest_memfd creation time, so the potential for allocations to occur
> in-between seems small, but worth confirming.
>
> But I know in the past there was a desire to ensure TDX/SNP could
> support pre-allocating guest_memfd memory (and even pre-faulting via
> KVM_PRE_FAULT_MEMORY), but I think that could still work right? The
> fallocate() handling could still avoid the split if the whole hugepage
> is private, though there is a bit more potential for that fallocate()
> to happen before userspace does the "manually" shared->private
> conversion. I'll double-check on that aspect, but otherwise, is there
> still any other need for it?

It's not just about performance. I think that the need is more a
matter of having a consistent API with the hypervisors guest_memfd is
going to support. Memory in guest_memfd is shared by default, but in
pKVM for example, it's private by default. Therefore, it would be good
to have a way to ensure that all guest_memfd allocations can be made
private from the get-go.

Cheers,
/fuad

> > >
> > > I assume we do want to support things like preallocating guest memory=
 so
> > > not sure this approach is feasible to avoid splits.
> > >
> > > But I feel like we might be working around a deeper issue here, which=
 is
> > > that we are pre-emptively splitting anything that *could* be mapped i=
nto
> > > userspace (i.e. allocated+shared/mixed), rather than splitting when
> > > necessary.
> > >
> > > I know that was the plan laid out in the guest_memfd calls, but I've =
run
> > > into a couple instances that have me thinking we should revisit this.
> > >
> > > 1) Some of the recent guest_memfd seems to be gravitating towards hav=
ing
> > >    userspace populate/initialize guest memory payload prior to boot v=
ia
> > >    mmap()'ing the shared guest_memfd pages so things work the same as
> > >    they would for initialized normal VM memory payload (rather than
> > >    relying on back-channels in the kernel to user data into guest_mem=
fd
> > >    pages).
> > >
> > >    When you do this though, for an SNP guest at least, that memory
> > >    acceptance is done in chunks of 4MB (with accept_memory=3Dlazy), a=
nd
> > >    because that will put each 1GB page into an allocated+mixed state,
> >
> > I would like your help in understanding why we need to start
> > guest_memfd ranges as shared for SNP guests. guest_memfd ranges being
> > private simply should mean that certain ranges are not faultable by
> > the userspace.
>
> It's seeming like I probably misremembered, but I thought there was a
> discussion on guest_memfd call a month (or so?) ago about whether to
> continue to use backchannels to populate guest_memfd pages prior to
> launch. It was in the context of whether to keep using kvm_gmem_populate(=
)
> for populating guest_memfd pages by copying them in from separate
> userspace buffer vs. simply populating them directly from userspace.
> I thought we were leaning on the latter since it was simpler all-around,
> which is great for SNP since that is already how it populates memory: by
> writing to it from userspace, which kvm_gmem_populate() then copies into
> guest_memfd pages. With shared gmem support, we just skip the latter now
> in the kernel rather needing changes to how userspace handles things in
> that regard. But maybe that was just wishful thinking :)
>
> But you raise some very compelling points on why this might not be a
> good idea even if that was how that discussion went.
>
> >
> > Will following work?
> > 1) Userspace starts all guest_memfd ranges as private.
> > 2) During early guest boot it starts issuing PSC requests for
> > converting memory from shared to private
> >     -> KVM forwards this request to userspace
> >     -> Userspace checks that the pages are already private and simply
> > does nothing.
> > 3) Pvalidate from guest on that memory will result in guest_memfd
> > offset query which will cause the RMP table entries to actually get
> > populated.
>
> That would work, but there will need to be changes on userspace to deal
> with how SNP populates memory pre-boot just like normal VMs do. We will
> instead need to copy that data into separate buffers, and pass those in
> as the buffer hva instead of the shared hva corresponding to that GPA.
>
> But that seems reasonable if it avoids so many other problems.
>
> >
> > >    we end up splitting every 1GB to 4K and the guest can't even
> > >    accept/PVALIDATE it 2MB at that point even if userspace doesn't to=
uch
> > >    anything in the range. As some point the guest will convert/accept
> > >    the entire range, at which point we could merge, but for SNP we'd
> > >    need guest cooperation to actually use a higher-granularity in sta=
ge2
> > >    page tables at that point since RMP entries are effectively all sp=
lit
> > >    to 4K.
> > >
> > >    I understand the intent is to default to private where this wouldn=
't
> > >    be an issue, and we could punt to userspace to deal with it, but i=
t
> > >    feels like an artificial restriction to place on userspace. And if=
 we
> > >    do want to allow/expect guest_memfd contents to be initialized pre=
-boot
> > >    just like normal memory, then userspace would need to jump through
> > >    some hoops:
> > >
> > >    - if defaulting to private: add hooks to convert each range that's=
 being
> > >      modified to a shared state prior to writing to it
> >
> > Why is that a problem?
>
> These were only problems if we went the above-mentioned way of
> populating memory pre-boot via mmap() instead of other backchannels. If
> we don't do that, then both these things cease to be problems. Sounds goo=
ds
> to me. :)
>
> >
> > >    - if defaulting to shared: initialize memory in-place, then covert
> > >      everything else to private to avoid unecessarily splitting folio=
s
> > >      at run-time
> > >
> > >    It feels like implementations details are bleeding out into the AP=
I
> > >    to some degree here (e.g. we'd probably at least need to document
> > >    this so users know how to take proper advantage of hugepage suppor=
t).
> >
> > Does it make sense to keep the default behavior as INIT_PRIVATE for
> > SNP VMs always even without using hugepages?
>
> Yes!
>
> Though, revisiting discussion around INIT_PRIVATE (without the baggage
> of potentially relying on mmap() to populate memory), I'm still not sure =
why
> it's needed. I responded in the context of Ackerley's initial reply
> above.
>
> >
> > >
> > > 2) There are some use-cases for HugeTLB + CoCo that have come to my
> > >    attention recently that put a lot of weight on still being able to
> > >    maximize mapping/hugepage size when accessing shared mem from user=
space,
> > >    e.g. for certain DPDK workloads that accessed shared guest buffers
> > >    from host userspace. We don't really have a story for this, and I
> > >    wouldn't expect us to at this stage, but I think it ties into #1 s=
o
> > >    might be worth considering in that context.
> >
> > Major problem I see here is that if anything in the kernel does a GUP
> > on shared memory ranges (which is very likely to happen), it would be
> > difficult to get them to let go of the whole hugepage before it can be
> > split safely.
> >
> > Another problem is guest_memfd today doesn't support management of
> > large user space page table mappings, this can turnout to be
> > significant work to do referring to hugetlb pagetable management
> > logic.
>
> Yah that was more line-of-sight that might be possible by going this
> route, but the refcount'ing issue above is a showstopper as always. I'd
> somehow convinced myself that supporting fine-grained splitting somehow
> worked around it, but you still have no idea what page you need to avoid
> converting and fancy splitting doesn't get you past that. More wishful
> thinking. =3D\
>
> Thanks,
>
> Mike
>
> >
> > >
> > > I'm still fine with the current approach as a starting point, but I'm
> > > wondering if improving both #1/#2 might not be so bad and maybe even
> > > give us some more flexibility (for instance, Sean had mentioned leavi=
ng
> > > open the option of tracking more than just shareability/mappability, =
and
> > > if there is split/merge logic associated with those transitions then
> > > re-scanning each of these attributes for a 1G range seems like it cou=
ld
> > > benefit from some sort of intermediate data structure to help determi=
ne
> > > things like what mapping granularity is available for guest/userspace
> > > for a particular range.
> > >
> > > One approach I was thinking of was that we introduce a data structure
> > > similar to KVM's memslot->arch.lpage_info() where we store informatio=
n
> > > about what 1G/2M ranges are shared/private/mixed, and then instead of
> > > splitting ahead of time we just record that state into this data
> > > structure (using the same write lock as with the
> > > shareability/mappability state), and then at *fault* time we split th=
e
> > > folio if our lpage_info-like data structure says the range is mixed.
> > >
> > > Then, if guest converts a 2M/4M range to private while lazilly-accept=
ing
> > > (for instance), we can still keep the folio intact as 1GB, but mark
> > > the 1G range in the lpage_info-like data structure as mixed so that w=
e
> > > still inform KVM/etc. they need to map it as 2MB or lower in stage2
> > > page tables. In that case, even at guest fault-time, we can leave the
> > > folio unsplit until userspace tries to touch it (though in most cases
> > > it never will and we can keep most of the guest's 1G intact for the
> > > duration of its lifetime).
> > >
> > > On the userspace side, another nice thing there is if we see 1G is in=
 a
> > > mixed state, but 2M is all-shared, then we can still leave the folio =
as 2M,
> > > and I think the refcount'ing logic would still work for the most part=
,
> > > which makes #2 a bit easier to implement as well.
> > >
> > > And of course, we wouldn't need the INIT_PRIVATE then since we are on=
ly
> > > splitting when necessary.
> > >
> > > But I guess this all comes down to how much extra pain there is in
> > > tracking a 1G folio that's been split into a mixed of 2MB/4K regions,
> > > but I think we'd get a lot more mileage out of getting that working a=
nd
> > > just completely stripping out all of the merging logic for initial
> > > implementation (other than at cleanup time), so maybe complexity-wise
> > > it balances out a bit?
> > >
> > > Thanks,
> > >
> > > Mike
> > >
> > > >
> > > > >>  See KVM_SET_USER_MEMORY_REGION2 for additional details.
> > > > >>
> > > > >>  4.143 KVM_PRE_FAULT_MEMORY
> > > > >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > > >> index 4cc824a3a7c9..d7df312479aa 100644
> > > > >> --- a/include/uapi/linux/kvm.h
> > > > >> +++ b/include/uapi/linux/kvm.h
> > > > >> @@ -1567,7 +1567,9 @@ struct kvm_memory_attributes {
> > > > >>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> > > > >>
> > > > >>  #define KVM_CREATE_GUEST_MEMFD    _IOWR(KVMIO,  0xd4, struct kv=
m_create_guest_memfd)
> > > > >> +
> > > > >>  #define GUEST_MEMFD_FLAG_SUPPORT_SHARED   (1UL << 0)
> > > > >> +#define GUEST_MEMFD_FLAG_INIT_PRIVATE     (1UL << 1)
> > > > >>
> > > > >>  struct kvm_create_guest_memfd {
> > > > >>    __u64 size;
> > > > >> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > > >> index 239d0f13dcc1..590932499eba 100644
> > > > >> --- a/virt/kvm/guest_memfd.c
> > > > >> +++ b/virt/kvm/guest_memfd.c
> > > > >> @@ -4,6 +4,7 @@
> > > > >>  #include <linux/falloc.h>
> > > > >>  #include <linux/fs.h>
> > > > >>  #include <linux/kvm_host.h>
> > > > >> +#include <linux/maple_tree.h>
> > > > >>  #include <linux/pseudo_fs.h>
> > > > >>  #include <linux/pagemap.h>
> > > > >>
> > > > >> @@ -17,6 +18,24 @@ struct kvm_gmem {
> > > > >>    struct list_head entry;
> > > > >>  };
> > > > >>
> > > > >> +struct kvm_gmem_inode_private {
> > > > >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > > > >> +  struct maple_tree shareability;
> > > > >> +#endif
> > > > >> +};
> > > > >> +
> > > > >> +enum shareability {
> > > > >> +  SHAREABILITY_GUEST =3D 1, /* Only the guest can map (fault) f=
olios in this range. */
> > > > >> +  SHAREABILITY_ALL =3D 2,   /* Both guest and host can fault fo=
lios in this range. */
> > > > >> +};
> > > > >> +
> > > > >> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pg=
off_t index);
> > > > >> +
> > > > >> +static struct kvm_gmem_inode_private *kvm_gmem_private(struct i=
node *inode)
> > > > >> +{
> > > > >> +  return inode->i_mapping->i_private_data;
> > > > >> +}
> > > > >> +
> > > > >>  /**
> > > > >>   * folio_file_pfn - like folio_file_page, but return a pfn.
> > > > >>   * @folio: The folio which contains this index.
> > > > >> @@ -29,6 +48,58 @@ static inline kvm_pfn_t folio_file_pfn(struct=
 folio *folio, pgoff_t index)
> > > > >>    return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1=
));
> > > > >>  }
> > > > >>
> > > > >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > > > >> +
> > > > >> +static int kvm_gmem_shareability_setup(struct kvm_gmem_inode_pr=
ivate *private,
> > > > >> +                                loff_t size, u64 flags)
> > > > >> +{
> > > > >> +  enum shareability m;
> > > > >> +  pgoff_t last;
> > > > >> +
> > > > >> +  last =3D (size >> PAGE_SHIFT) - 1;
> > > > >> +  m =3D flags & GUEST_MEMFD_FLAG_INIT_PRIVATE ? SHAREABILITY_GU=
EST :
> > > > >> +                                              SHAREABILITY_ALL;
> > > > >> +  return mtree_store_range(&private->shareability, 0, last, xa_=
mk_value(m),
> > > > >> +                           GFP_KERNEL);
> > > > >
> > > > > One really nice thing about using a maple tree is that it should =
get rid
> > > > > of a fairly significant startup delay for SNP/TDX when the entire=
 xarray gets
> > > > > initialized with private attribute entries via KVM_SET_MEMORY_ATT=
RIBUTES
> > > > > (which is the current QEMU default behavior).
> > > > >
> > > > > I'd originally advocated for sticking with the xarray implementat=
ion Fuad was
> > > > > using until we'd determined we really need it for HugeTLB support=
, but I'm
> > > > > sort of thinking it's already justified just based on the above.
> > > > >
> > > > > Maybe it would make sense for KVM memory attributes too?
> > > > >
> > > > >> +}
> > > > >> +
> > > > >> +static enum shareability kvm_gmem_shareability_get(struct inode=
 *inode,
> > > > >> +                                           pgoff_t index)
> > > > >> +{
> > > > >> +  struct maple_tree *mt;
> > > > >> +  void *entry;
> > > > >> +
> > > > >> +  mt =3D &kvm_gmem_private(inode)->shareability;
> > > > >> +  entry =3D mtree_load(mt, index);
> > > > >> +  WARN(!entry,
> > > > >> +       "Shareability should always be defined for all indices i=
n inode.");
> > > > >> +
> > > > >> +  return xa_to_value(entry);
> > > > >> +}
> > > > >> +
> > > > >> +static struct folio *kvm_gmem_get_shared_folio(struct inode *in=
ode, pgoff_t index)
> > > > >> +{
> > > > >> +  if (kvm_gmem_shareability_get(inode, index) !=3D SHAREABILITY=
_ALL)
> > > > >> +          return ERR_PTR(-EACCES);
> > > > >> +
> > > > >> +  return kvm_gmem_get_folio(inode, index);
> > > > >> +}
> > > > >> +
> > > > >> +#else
> > > > >> +
> > > > >> +static int kvm_gmem_shareability_setup(struct maple_tree *mt, l=
off_t size, u64 flags)
> > > > >> +{
> > > > >> +  return 0;
> > > > >> +}
> > > > >> +
> > > > >> +static inline struct folio *kvm_gmem_get_shared_folio(struct in=
ode *inode, pgoff_t index)
> > > > >> +{
> > > > >> +  WARN_ONCE("Unexpected call to get shared folio.")
> > > > >> +  return NULL;
> > > > >> +}
> > > > >> +
> > > > >> +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> > > > >> +
> > > > >>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm=
_memory_slot *slot,
> > > > >>                                pgoff_t index, struct folio *foli=
o)
> > > > >>  {
> > > > >> @@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(stru=
ct vm_fault *vmf)
> > > > >>
> > > > >>    filemap_invalidate_lock_shared(inode->i_mapping);
> > > > >>
> > > > >> -  folio =3D kvm_gmem_get_folio(inode, vmf->pgoff);
> > > > >> +  folio =3D kvm_gmem_get_shared_folio(inode, vmf->pgoff);
> > > > >>    if (IS_ERR(folio)) {
> > > > >>            int err =3D PTR_ERR(folio);
> > > > >>
> > > > >> @@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops=
 =3D {
> > > > >>    .fallocate      =3D kvm_gmem_fallocate,
> > > > >>  };
> > > > >>
> > > > >> +static void kvm_gmem_free_inode(struct inode *inode)
> > > > >> +{
> > > > >> +  struct kvm_gmem_inode_private *private =3D kvm_gmem_private(i=
node);
> > > > >> +
> > > > >> +  kfree(private);
> > > > >> +
> > > > >> +  free_inode_nonrcu(inode);
> > > > >> +}
> > > > >> +
> > > > >> +static void kvm_gmem_destroy_inode(struct inode *inode)
> > > > >> +{
> > > > >> +  struct kvm_gmem_inode_private *private =3D kvm_gmem_private(i=
node);
> > > > >> +
> > > > >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > > > >> +  /*
> > > > >> +   * mtree_destroy() can't be used within rcu callback, hence c=
an't be
> > > > >> +   * done in ->free_inode().
> > > > >> +   */
> > > > >> +  if (private)
> > > > >> +          mtree_destroy(&private->shareability);
> > > > >> +#endif
> > > > >> +}
> > > > >> +
> > > > >>  static const struct super_operations kvm_gmem_super_operations =
=3D {
> > > > >>    .statfs         =3D simple_statfs,
> > > > >> +  .destroy_inode  =3D kvm_gmem_destroy_inode,
> > > > >> +  .free_inode     =3D kvm_gmem_free_inode,
> > > > >>  };
> > > > >>
> > > > >>  static int kvm_gmem_init_fs_context(struct fs_context *fc)
> > > > >> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_g=
mem_iops =3D {
> > > > >>  static struct inode *kvm_gmem_inode_make_secure_inode(const cha=
r *name,
> > > > >>                                                  loff_t size, u6=
4 flags)
> > > > >>  {
> > > > >> +  struct kvm_gmem_inode_private *private;
> > > > >>    struct inode *inode;
> > > > >> +  int err;
> > > > >>
> > > > >>    inode =3D alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name)=
;
> > > > >>    if (IS_ERR(inode))
> > > > >>            return inode;
> > > > >>
> > > > >> +  err =3D -ENOMEM;
> > > > >> +  private =3D kzalloc(sizeof(*private), GFP_KERNEL);
> > > > >> +  if (!private)
> > > > >> +          goto out;
> > > > >> +
> > > > >> +  mt_init(&private->shareability);
> > > > >> +  inode->i_mapping->i_private_data =3D private;
> > > > >> +
> > > > >> +  err =3D kvm_gmem_shareability_setup(private, size, flags);
> > > > >> +  if (err)
> > > > >> +          goto out;
> > > > >> +
> > > > >>    inode->i_private =3D (void *)(unsigned long)flags;
> > > > >>    inode->i_op =3D &kvm_gmem_iops;
> > > > >>    inode->i_mapping->a_ops =3D &kvm_gmem_aops;
> > > > >> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_se=
cure_inode(const char *name,
> > > > >>    WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> > > > >>
> > > > >>    return inode;
> > > > >> +
> > > > >> +out:
> > > > >> +  iput(inode);
> > > > >> +
> > > > >> +  return ERR_PTR(err);
> > > > >>  }
> > > > >>
> > > > >>  static struct file *kvm_gmem_inode_create_getfile(void *priv, l=
off_t size,
> > > > >> @@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct =
kvm_create_guest_memfd *args)
> > > > >>    if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
> > > > >>            valid_flags |=3D GUEST_MEMFD_FLAG_SUPPORT_SHARED;
> > > > >>
> > > > >> +  if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
> > > > >> +          valid_flags |=3D GUEST_MEMFD_FLAG_INIT_PRIVATE;
> > > > >> +
> > > > >>    if (flags & ~valid_flags)
> > > > >>            return -EINVAL;
> > > > >>
> > > > >> @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct=
 kvm_memory_slot *slot,
> > > > >>    if (!file)
> > > > >>            return -EFAULT;
> > > > >>
> > > > >> +  filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> > > > >> +
> > > > >
> > > > > I like the idea of using a write-lock/read-lock to protect write/=
read access
> > > > > to shareability state (though maybe not necessarily re-using file=
map's
> > > > > invalidate lock), it's simple and still allows concurrent faultin=
g in of gmem
> > > > > pages. One issue on the SNP side (which also came up in one of th=
e gmem calls)
> > > > > is if we introduce support for tracking preparedness as discussed=
 (e.g. via a
> > > > > new SHAREABILITY_GUEST_PREPARED state) the
> > > > > SHAREABILITY_GUEST->SHAREABILITY_GUEST_PREPARED transition would =
occur at
> > > > > fault-time, and so would need to take the write-lock and no longe=
r allow for
> > > > > concurrent fault-handling.
> > > > >
> > > > > I was originally planning on introducing a new rw_semaphore with =
similar
> > > > > semantics to the rw_lock that Fuad previously had in his restrict=
ed mmap
> > > > > series[1] (and simiar semantics to filemap invalidate lock here).=
 The main
> > > > > difference, to handle setting SHAREABILITY_GUEST_PREPARED within =
fault paths,
> > > > > was that in the case of a folio being present for an index, the f=
olio lock would
> > > > > also need to be held in order to update the shareability state. B=
ecause
> > > > > of that, fault paths (which will always either have or allocate f=
olio
> > > > > basically) can rely on the folio lock to guard shareability state=
 in a more
> > > > > granular way and so can avoid a global write lock.
> > > > >
> > > > > They would still need to hold the read lock to access the tree ho=
wever.
> > > > > Or more specifically, any paths that could allocate a folio need =
to take
> > > > > a read lock so there isn't a TOCTOU situation where shareability =
is
> > > > > being updated for an index for which a folio hasn't been allocate=
d, but
> > > > > then just afterward the folio gets faulted in/allocated while the
> > > > > shareability state is already being updated which the understand =
that
> > > > > there was no folio around that needed locking.
> > > > >
> > > > > I had a branch with in-place conversion support for SNP[2] that a=
dded this
> > > > > lock reworking on top of Fuad's series along with preparation tra=
cking,
> > > > > but I'm now planning to rebase that on top of the patches from th=
is
> > > > > series that Sean mentioned[3] earlier:
> > > > >
> > > > >   KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
> > > > >   KVM: Query guest_memfd for private/shared status
> > > > >   KVM: guest_memfd: Skip LRU for guest_memfd folios
> > > > >   KVM: guest_memfd: Introduce KVM_GMEM_CONVERT_SHARED/PRIVATE ioc=
tls
> > > > >   KVM: guest_memfd: Introduce and use shareability to guard fault=
ing
> > > > >   KVM: guest_memfd: Make guest mem use guest mem inodes instead o=
f anonymous inodes
> > > > >
> > > > > but figured I'd mention it here in case there are other things to=
 consider on
> > > > > the locking front.
> > > > >
> > > > > Definitely agree with Sean though that it would be nice to start =
identifying a
> > > > > common base of patches for the in-place conversion enablement for=
 SNP, TDX, and
> > > > > pKVM so the APIs/interfaces for hugepages can be handled separate=
ly.
> > > > >
> > > > > -Mike
> > > > >
> > > > > [1] https://lore.kernel.org/kvm/20250328153133.3504118-1-tabba@go=
ogle.com/
> > > > > [2] https://github.com/mdroth/linux/commits/mmap-swprot-v10-snp0-=
wip2/
> > > > > [3] https://lore.kernel.org/kvm/aC86OsU2HSFZkJP6@google.com/
> > > > >
> > > > >>    folio =3D __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prep=
ared, max_order);
> > > > >>    if (IS_ERR(folio)) {
> > > > >>            r =3D PTR_ERR(folio);
> > > > >> @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct=
 kvm_memory_slot *slot,
> > > > >>            *page =3D folio_file_page(folio, index);
> > > > >>    else
> > > > >>            folio_put(folio);
> > > > >> -
> > > > >>  out:
> > > > >> +  filemap_invalidate_unlock_shared(file_inode(file)->i_mapping)=
;
> > > > >>    fput(file);
> > > > >>    return r;
> > > > >>  }
> > > > >> --
> > > > >> 2.49.0.1045.g170613ef41-goog
> > > > >>
> > > >


Return-Path: <linux-fsdevel+bounces-53765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864FAF6955
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 07:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB1A17C427
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 05:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B9028EA70;
	Thu,  3 Jul 2025 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YURrSHVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061728D8E7
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519452; cv=none; b=BIqVxld7wCaU6xcZNH92tl7R055XDum2BbYReFVCHONMVWXlfg3P7MR/Hb9Xv/z7VSFtQyi2wdFGFtyL4rlYdCZYXN3xn0RcmhZDgc9S9/2lDR4bxTRXjExazS9oU/OLntADIF8T4eeC+ir5IOS12w2Mh3iMp7ZYt8K7i81Z664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519452; c=relaxed/simple;
	bh=vIzIJZDIFkfsEmy2wcQ+uT289kzzzIyMOaOdvEv4wY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOOW/ltQqZtiANUEXbeuL6NfCKJx2JKmG+OvNYpxsmuJN7DXjb39bl1y0ScImaa36IWOnRK6gJFsXodK5iN2rmKUQMrAiblXEEyhU0Ze0Z61/7l4ExjTR5iPIhPicT5C+ts4UmnAzELWSPqW44LP8X4+szA+rUgM+HRZ32Nd7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YURrSHVt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237f18108d2so115785ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 22:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751519450; x=1752124250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r6oSrJdvma/ppArIPNGYIDzwnPe2WkOtZUjd7ymxvs=;
        b=YURrSHVt6hXT01y7ipzaV7XX1umnZL8cyy5nDKbQWyPjbL2a32u5R8x+VaGvetVESy
         vKES2dehUD3M1vslEQx4Cty6qQ8/v0nN6u8dty74bo3IzvyfJrhwmKop92w1oc2F2LbK
         ZX6S8QPSoeq4No98J95TvW5EVBDJcVb5dsRkswF87QHqOnIzZxHOE84k8N2nTH2QV+5w
         ZzFUj3nuZSrLyMzyqUU5Cmlv3dtq9k+TSz9iDHkhzo6uqY17MpuGyB0GCEsoEvmMsK5C
         uDgNSOrB2jHwSb+kb8MWZTrcdvjeCJoMnRytNTm7tDkFK2dD+99I2uul7MB5qzicHfWc
         MwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751519450; x=1752124250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r6oSrJdvma/ppArIPNGYIDzwnPe2WkOtZUjd7ymxvs=;
        b=MCa68gPfHneNVGeSAx/JLsU8nSiDmAC5gMG7cOPrbFC8RPLNmgGZa0RP/OAZmrbS5f
         FihkgbsEFX0fiFLUybnGDFOd0ciXxYZ+juVRjNiM7xidoc+8hCLrRUSNsjx2f9jZP+Qj
         xSm6cskwovU6XKH2rWCaZOXKtkY8lX7RdNuuR/s02PpPiqlPK2jhRFB/bHDp7dFjDOeF
         QD/hLtiKZety/run1LzRFo6EElDEyuQd7JULMsscl3o64gVypg7Lsq5S1SP/2C5/5PMp
         zOFLUJZX/ILWPSiYpH/N2Yd4V1kGt7iXPqfPjWzKrGr5FDNXtpHpprdGHyI6ajsJsCaQ
         ccIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1uP2H1siPdqY3TzZ0FlZGmdDgltwUS14oEXvAy1Hx9qFXtOqKqPPvsIMiqCOpdlzybDOsGrvyL4DiwwHN@vger.kernel.org
X-Gm-Message-State: AOJu0YwLoUAZWZiMgBHxqIsGhrfekxNi/A0Xb3qSxL2i0GQ987XiPD+j
	TBuQfmIMDnhFSucVAnRINEqy8xpiiiy+HBtcqEXz1v44FsIahbSKbu4QrxT6j4JTdtewwse1fsE
	a2TiejfF1sQ/CDWDUtwMLTeB1612d67s5YOZGGwkB
X-Gm-Gg: ASbGncvwTiL9QL7vmGvNjCPLZOoPXAN8FiKfq1jbv8mlFccWwiBX4OoyMTQ4V4dwxJ0
	UDbE9D9eQ4iZgweWx7soyx1sXup5bVm5FzD/L3qTMVcFYvBfHfw9UuDFSKGsw5sPVo4UZ4UZffK
	bIHJtj/D9e6bb6hgAs/b0DD2vJp+L/ds+JUz767M/5j6YZwwy4jLrzAHwHAHiX9fk0KVEbAWi3k
	SP7
X-Google-Smtp-Source: AGHT+IGzGo02E222/kLb1ya42jzy/0z9IuFo8tQBDelKleWoDxoJxYoeX1rAgbuzvdnV8n2Qt9RhRKHi0TjqJpdGL9I=
X-Received: by 2002:a17:902:e551:b0:234:b2bf:e67f with SMTP id
 d9443c01a7336-23c7abfdd8dmr1343185ad.9.1751519449201; Wed, 02 Jul 2025
 22:10:49 -0700 (PDT)
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
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 2 Jul 2025 22:10:36 -0700
X-Gm-Features: Ac12FXxFL8lZ310LgZl8pxf1aGMnD30R2b-bcyCXa70teYKtmh3oAVTF6sRTjrM
Message-ID: <CAGtprH9sckYupyU12+nK-ySJjkTgddHmBzrq_4P1Gemck5TGOQ@mail.gmail.com>
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

On Wed, Jul 2, 2025 at 9:12=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
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

I am assuming in-place conversion with huge page backing for the
discussion below.

Looks like there are three scenarios/usecases we are discussing here:
1) Pre-allocating guest_memfd file offsets
   - Userspace can use fallocate to do this for hugepages by keeping
the file ranges marked private.
2) Prefaulting guest EPT/NPT entries
3) Populating initial guest payload into guest_memfd memory
   - Userspace can mark certain ranges as shared, populate the
contents and convert the ranges back to private. So mmap will come in
handy here.

>
> I'm still not sure where the INIT_PRIVATE flag comes into play. For SNP,
> userspace already defaults to marking everything private pretty close to
> guest_memfd creation time, so the potential for allocations to occur
> in-between seems small, but worth confirming.

Ok, I am not much worried about whether the INIT_PRIVATE flag gets
supported or not, but more about the default setting that different
CVMs start with. To me, it looks like all CVMs should start as
everything private by default and if there is a way to bake that
configuration during guest_memfd creation time that would be good to
have instead of doing "create and convert" operations and there is a
fairly low cost to support this flag.

>
> But I know in the past there was a desire to ensure TDX/SNP could
> support pre-allocating guest_memfd memory (and even pre-faulting via
> KVM_PRE_FAULT_MEMORY), but I think that could still work right? The
> fallocate() handling could still avoid the split if the whole hugepage
> is private, though there is a bit more potential for that fallocate()
> to happen before userspace does the "manually" shared->private
> conversion. I'll double-check on that aspect, but otherwise, is there
> still any other need for it?

This usecase of being able to preallocate should still work with
in-place conversion assuming all ranges are private before
pre-population.

>
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

You remember it correctly and that's how userspace should pre-populate
guest memory contents with in-place conversion support available.
Userspace can simply do the following scheme as an example:
1) Create guest_memfd with the INIT_PRIVATE flag or if we decide to
not go that way, create a guest_memfd file and set all ranges as
private.
2) Preallocate the guest_memfd ranges.
3) Convert the needed ranges to shared, populate the initial guest
payload and then convert those ranges back to private.

Important point here is that guest_memfd ranges can be marked as
private before pre-allocating guest_memfd ranges.

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

Initial guest memory payload generally carries a much smaller
footprint so I ignored that detail in the above sequence. As I said
above, userspace should be able to use guest_memfd ranges to directly
populate contents by converting those ranges to shared.

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

I think there wouldn't be a problem even if we pre-populated memory
pre-boot via mmap(). Using mmap() seems a preferable option to me.


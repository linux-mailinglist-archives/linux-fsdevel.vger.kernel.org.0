Return-Path: <linux-fsdevel+bounces-53750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87EAF66E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594684E8120
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E16B14B08A;
	Thu,  3 Jul 2025 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAoaOZD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406E1805B
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751503599; cv=none; b=UPK/Sk2kJDA/Q7yz12toG/nM6sZGvP8bWw3qxvyH7QLLVSYln3s4vv0KcFnqH4BtuZ2R/UhyiBu51pvRW631a7D5ZzrKI4S3DfKPlpCUxvz1cbZTvOFiXsuSHViTqJiMUc2lj4WpvCU3InN3brFeaIwZV5+jQNHswi6iJ9VveDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751503599; c=relaxed/simple;
	bh=Dss28tXwUBPjF4KJOVaxxYmlQF8cO/NGRl1EEBihF5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR241dGxy+wXA0sH6dGc+qjZX7k0cFK8+G9tKLL+dDAiyfsEd1yNJtdPHkuDdRrgPgRseZ7T4oSjEhEvbJW+SG3GKEWSEw6eQ0irpT6Hb11ARgGyv6P4X15hh+lc57UxnyYw0ytLpdNOJUKxGU+raGwyAazz9fBtsvEVnKh5sGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAoaOZD/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2357c61cda7so46855ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 17:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751503597; x=1752108397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9N6IJt20gs/+DQi4MafGjTwI4DPH2GK/FsmnFJa+sQ=;
        b=OAoaOZD/KQWMZYDNs0KQruELZE5kn4bawsAsQrOkBaoJfNhtUkRUmSJlHsV5YJbh5W
         ZnMGh9n2tsYmil2InPi6UCEPO3GS2e64iC1CEuxXjcYnRrpMtXkVCYeBlZCTuVVRlHhF
         yslxH3t//j/31VZ5tIe7PzyeDy153uQJZI8egwE7TJ1ertgFl+avbVd0TR2NM19LDZN9
         gnox6DXvSyiAPaQuWzsZ2b1Uj2e3oIDooU3Og3aoTnwsJAnRLNvij542mZ3g+fxhv/I6
         o7dakKxSaIvZ/dZQUtJy82fv7SazIyDa9uxM02c/maEPA7rhULgS+MCYdOU7n2QqXd3u
         XtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751503597; x=1752108397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9N6IJt20gs/+DQi4MafGjTwI4DPH2GK/FsmnFJa+sQ=;
        b=ld6y3hasvaNVZ/8WAQrXwldiVa/xatc2TaXRsDdtYFep8RnIfa08YHe8zVfF5F9fVp
         wEWzPCOlYzAPeYBDIVEHT8lxMprl2X4IzWTI0r+WpVfQfHl0oprBCaUK4HvNpCh875FY
         xTjx13IZJNg7kFVX1wBKW37NbWDjZY5pPHM3Pph5eALBJbArqyRnI5vVeSXSwVTPFDxQ
         O+YZRZNMWfw8Yi8yH/+AGFS43BNYbf7py6wOj6N2W3/yQwp7ULP8mE0oiBIo8OyUZX5w
         a4VdCWWFumJtpE2vrYiljMDEotX7Sr8sK2GyVOZmcOTXC4hahiqizo3Uxw7R4erFv1HK
         u5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUD+fehfput7KDqRCuHaWWynvL7+9n2oFs0v8L0/XEeDslFD0T9wSMbDUm+OiJpv8SYTiv62LthtVEoScnW@vger.kernel.org
X-Gm-Message-State: AOJu0YyaesMzxTbR+tEUXosT5LvV/JxN2UOay6G8Z8rXAHJSZsfxeXOP
	am+0JS6XmvdM9LE3OoGOJY5HMEneMbCWKP0oPfOkzSpNwY0AYKqYGzF5YYO5PLzDO0ildIizV1i
	Gaar4uhIjv//vxxwGDtHebbPtda4KRWPT8+qInpJz
X-Gm-Gg: ASbGncuOeknWp5V8TcVZOx0tKe7w5GkehEaF5ubSOa3BU0bprKV8aXeXagkzx6gjrr4
	9nwaBgCRUcUN3h4CeHHuh85Mv0XQvGdCNwP9z5CYxXEvJ5uNjA06k4QF3rjjuprGWpcVsY7AS+S
	GI1JiyIvPnOu5OzmAk0RB17n/N9y9/QUY7QDUgrc+E4YBIAYN2w4vhX4zqP+Ss2mtEgXzqmdnG
X-Google-Smtp-Source: AGHT+IFqtODNTLrZVuad1sQYaPdmQfRnlEc3nSEqCJfHgwJ5vOTesI9JxfvY4RDpdi8YNxXYREIHnCxevz5N2hE2n9Y=
X-Received: by 2002:a17:902:c40e:b0:231:ed22:e230 with SMTP id
 d9443c01a7336-23c7abf6e06mr689335ad.15.1751503596115; Wed, 02 Jul 2025
 17:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com> <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
 <20250702232517.k2nqwggxfpfp3yym@amd.com>
In-Reply-To: <20250702232517.k2nqwggxfpfp3yym@amd.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 2 Jul 2025 17:46:23 -0700
X-Gm-Features: Ac12FXwczeQJDEwSa02SdMNrIr9mhfyrz4lzx7KibcBZZTGCldOTiqSU-9IkxFE
Message-ID: <CAGtprH-=f1FBOS=xWciBU6KQJ9LJQ5uZoms83aSRBDsC3=tpZA@mail.gmail.com>
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

On Wed, Jul 2, 2025 at 4:25=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
>
> On Wed, Jun 11, 2025 at 02:51:38PM -0700, Ackerley Tng wrote:
> > Michael Roth <michael.roth@amd.com> writes:
> >
> > > On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
> > >> Track guest_memfd memory's shareability status within the inode as
> > >> opposed to the file, since it is property of the guest_memfd's memor=
y
> > >> contents.
> > >>
> > >> Shareability is a property of the memory and is indexed using the
> > >> page's index in the inode. Because shareability is the memory's
> > >> property, it is stored within guest_memfd instead of within KVM, lik=
e
> > >> in kvm->mem_attr_array.
> > >>
> > >> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
> > >> retained to allow VMs to only use guest_memfd for private memory and
> > >> some other memory for shared memory.
> > >>
> > >> Not all use cases require guest_memfd() to be shared with the host
> > >> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
> > >> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
> > >> private to the guest, and therefore not mappable by the
> > >> host. Otherwise, memory is shared until explicitly converted to
> > >> private.
> > >>
> > >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > >> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> > >> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > >> Co-developed-by: Fuad Tabba <tabba@google.com>
> > >> Signed-off-by: Fuad Tabba <tabba@google.com>
> > >> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
> > >> ---
> > >>  Documentation/virt/kvm/api.rst |   5 ++
> > >>  include/uapi/linux/kvm.h       |   2 +
> > >>  virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++=
++-
> > >>  3 files changed, 129 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm=
/api.rst
> > >> index 86f74ce7f12a..f609337ae1c2 100644
> > >> --- a/Documentation/virt/kvm/api.rst
> > >> +++ b/Documentation/virt/kvm/api.rst
> > >> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
> > >>  The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for =
CoCo VMs.
> > >>  This is validated when the guest_memfd instance is bound to the VM.
> > >>
> > >> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the '=
flags' field
> > >> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.  Setting GUEST_MEMFD_FLAG_I=
NIT_PRIVATE
> > >> +will initialize the memory for the guest_memfd as guest-only and no=
t faultable
> > >> +by the host.
> > >> +
> > >
> > > KVM_CAP_GMEM_CONVERSION doesn't get introduced until later, so it see=
ms
> > > like this flag should be deferred until that patch is in place. Is it
> > > really needed at that point though? Userspace would be able to set th=
e
> > > initial state via KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls.
> > >
> >
> > I can move this change to the later patch. Thanks! Will fix in the next
> > revision.
> >
> > > The mtree contents seems to get stored in the same manner in either c=
ase so
> > > performance-wise only the overhead of a few userspace<->kernel switch=
es
> > > would be saved. Are there any other reasons?
> > >
> > > Otherwise, maybe just settle on SHARED as a documented default (since=
 at
> > > least non-CoCo VMs would be able to reliably benefit) and let
> > > CoCo/GUEST_MEMFD_FLAG_SUPPORT_SHARED VMs set PRIVATE at whatever
> > > granularity makes sense for the architecture/guest configuration.
> > >
> >
> > Because shared pages are split once any memory is allocated, having a
> > way to INIT_PRIVATE could avoid the split and then merge on
> > conversion. I feel that is enough value to have this config flag, what
> > do you think?
> >
> > I guess we could also have userspace be careful not to do any allocatio=
n
> > before converting.
>
> I assume we do want to support things like preallocating guest memory so
> not sure this approach is feasible to avoid splits.
>
> But I feel like we might be working around a deeper issue here, which is
> that we are pre-emptively splitting anything that *could* be mapped into
> userspace (i.e. allocated+shared/mixed), rather than splitting when
> necessary.
>
> I know that was the plan laid out in the guest_memfd calls, but I've run
> into a couple instances that have me thinking we should revisit this.
>
> 1) Some of the recent guest_memfd seems to be gravitating towards having
>    userspace populate/initialize guest memory payload prior to boot via
>    mmap()'ing the shared guest_memfd pages so things work the same as
>    they would for initialized normal VM memory payload (rather than
>    relying on back-channels in the kernel to user data into guest_memfd
>    pages).
>
>    When you do this though, for an SNP guest at least, that memory
>    acceptance is done in chunks of 4MB (with accept_memory=3Dlazy), and
>    because that will put each 1GB page into an allocated+mixed state,

I would like your help in understanding why we need to start
guest_memfd ranges as shared for SNP guests. guest_memfd ranges being
private simply should mean that certain ranges are not faultable by
the userspace.

Will following work?
1) Userspace starts all guest_memfd ranges as private.
2) During early guest boot it starts issuing PSC requests for
converting memory from shared to private
    -> KVM forwards this request to userspace
    -> Userspace checks that the pages are already private and simply
does nothing.
3) Pvalidate from guest on that memory will result in guest_memfd
offset query which will cause the RMP table entries to actually get
populated.

>    we end up splitting every 1GB to 4K and the guest can't even
>    accept/PVALIDATE it 2MB at that point even if userspace doesn't touch
>    anything in the range. As some point the guest will convert/accept
>    the entire range, at which point we could merge, but for SNP we'd
>    need guest cooperation to actually use a higher-granularity in stage2
>    page tables at that point since RMP entries are effectively all split
>    to 4K.
>
>    I understand the intent is to default to private where this wouldn't
>    be an issue, and we could punt to userspace to deal with it, but it
>    feels like an artificial restriction to place on userspace. And if we
>    do want to allow/expect guest_memfd contents to be initialized pre-boo=
t
>    just like normal memory, then userspace would need to jump through
>    some hoops:
>
>    - if defaulting to private: add hooks to convert each range that's bei=
ng
>      modified to a shared state prior to writing to it

Why is that a problem?

>    - if defaulting to shared: initialize memory in-place, then covert
>      everything else to private to avoid unecessarily splitting folios
>      at run-time
>
>    It feels like implementations details are bleeding out into the API
>    to some degree here (e.g. we'd probably at least need to document
>    this so users know how to take proper advantage of hugepage support).

Does it make sense to keep the default behavior as INIT_PRIVATE for
SNP VMs always even without using hugepages?

>
> 2) There are some use-cases for HugeTLB + CoCo that have come to my
>    attention recently that put a lot of weight on still being able to
>    maximize mapping/hugepage size when accessing shared mem from userspac=
e,
>    e.g. for certain DPDK workloads that accessed shared guest buffers
>    from host userspace. We don't really have a story for this, and I
>    wouldn't expect us to at this stage, but I think it ties into #1 so
>    might be worth considering in that context.

Major problem I see here is that if anything in the kernel does a GUP
on shared memory ranges (which is very likely to happen), it would be
difficult to get them to let go of the whole hugepage before it can be
split safely.

Another problem is guest_memfd today doesn't support management of
large user space page table mappings, this can turnout to be
significant work to do referring to hugetlb pagetable management
logic.

>
> I'm still fine with the current approach as a starting point, but I'm
> wondering if improving both #1/#2 might not be so bad and maybe even
> give us some more flexibility (for instance, Sean had mentioned leaving
> open the option of tracking more than just shareability/mappability, and
> if there is split/merge logic associated with those transitions then
> re-scanning each of these attributes for a 1G range seems like it could
> benefit from some sort of intermediate data structure to help determine
> things like what mapping granularity is available for guest/userspace
> for a particular range.
>
> One approach I was thinking of was that we introduce a data structure
> similar to KVM's memslot->arch.lpage_info() where we store information
> about what 1G/2M ranges are shared/private/mixed, and then instead of
> splitting ahead of time we just record that state into this data
> structure (using the same write lock as with the
> shareability/mappability state), and then at *fault* time we split the
> folio if our lpage_info-like data structure says the range is mixed.
>
> Then, if guest converts a 2M/4M range to private while lazilly-accepting
> (for instance), we can still keep the folio intact as 1GB, but mark
> the 1G range in the lpage_info-like data structure as mixed so that we
> still inform KVM/etc. they need to map it as 2MB or lower in stage2
> page tables. In that case, even at guest fault-time, we can leave the
> folio unsplit until userspace tries to touch it (though in most cases
> it never will and we can keep most of the guest's 1G intact for the
> duration of its lifetime).
>
> On the userspace side, another nice thing there is if we see 1G is in a
> mixed state, but 2M is all-shared, then we can still leave the folio as 2=
M,
> and I think the refcount'ing logic would still work for the most part,
> which makes #2 a bit easier to implement as well.
>
> And of course, we wouldn't need the INIT_PRIVATE then since we are only
> splitting when necessary.
>
> But I guess this all comes down to how much extra pain there is in
> tracking a 1G folio that's been split into a mixed of 2MB/4K regions,
> but I think we'd get a lot more mileage out of getting that working and
> just completely stripping out all of the merging logic for initial
> implementation (other than at cleanup time), so maybe complexity-wise
> it balances out a bit?
>
> Thanks,
>
> Mike
>
> >
> > >>  See KVM_SET_USER_MEMORY_REGION2 for additional details.
> > >>
> > >>  4.143 KVM_PRE_FAULT_MEMORY
> > >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > >> index 4cc824a3a7c9..d7df312479aa 100644
> > >> --- a/include/uapi/linux/kvm.h
> > >> +++ b/include/uapi/linux/kvm.h
> > >> @@ -1567,7 +1567,9 @@ struct kvm_memory_attributes {
> > >>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> > >>
> > >>  #define KVM_CREATE_GUEST_MEMFD    _IOWR(KVMIO,  0xd4, struct kvm_cr=
eate_guest_memfd)
> > >> +
> > >>  #define GUEST_MEMFD_FLAG_SUPPORT_SHARED   (1UL << 0)
> > >> +#define GUEST_MEMFD_FLAG_INIT_PRIVATE     (1UL << 1)
> > >>
> > >>  struct kvm_create_guest_memfd {
> > >>    __u64 size;
> > >> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > >> index 239d0f13dcc1..590932499eba 100644
> > >> --- a/virt/kvm/guest_memfd.c
> > >> +++ b/virt/kvm/guest_memfd.c
> > >> @@ -4,6 +4,7 @@
> > >>  #include <linux/falloc.h>
> > >>  #include <linux/fs.h>
> > >>  #include <linux/kvm_host.h>
> > >> +#include <linux/maple_tree.h>
> > >>  #include <linux/pseudo_fs.h>
> > >>  #include <linux/pagemap.h>
> > >>
> > >> @@ -17,6 +18,24 @@ struct kvm_gmem {
> > >>    struct list_head entry;
> > >>  };
> > >>
> > >> +struct kvm_gmem_inode_private {
> > >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > >> +  struct maple_tree shareability;
> > >> +#endif
> > >> +};
> > >> +
> > >> +enum shareability {
> > >> +  SHAREABILITY_GUEST =3D 1, /* Only the guest can map (fault) folio=
s in this range. */
> > >> +  SHAREABILITY_ALL =3D 2,   /* Both guest and host can fault folios=
 in this range. */
> > >> +};
> > >> +
> > >> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_=
t index);
> > >> +
> > >> +static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode=
 *inode)
> > >> +{
> > >> +  return inode->i_mapping->i_private_data;
> > >> +}
> > >> +
> > >>  /**
> > >>   * folio_file_pfn - like folio_file_page, but return a pfn.
> > >>   * @folio: The folio which contains this index.
> > >> @@ -29,6 +48,58 @@ static inline kvm_pfn_t folio_file_pfn(struct fol=
io *folio, pgoff_t index)
> > >>    return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
> > >>  }
> > >>
> > >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > >> +
> > >> +static int kvm_gmem_shareability_setup(struct kvm_gmem_inode_privat=
e *private,
> > >> +                                loff_t size, u64 flags)
> > >> +{
> > >> +  enum shareability m;
> > >> +  pgoff_t last;
> > >> +
> > >> +  last =3D (size >> PAGE_SHIFT) - 1;
> > >> +  m =3D flags & GUEST_MEMFD_FLAG_INIT_PRIVATE ? SHAREABILITY_GUEST =
:
> > >> +                                              SHAREABILITY_ALL;
> > >> +  return mtree_store_range(&private->shareability, 0, last, xa_mk_v=
alue(m),
> > >> +                           GFP_KERNEL);
> > >
> > > One really nice thing about using a maple tree is that it should get =
rid
> > > of a fairly significant startup delay for SNP/TDX when the entire xar=
ray gets
> > > initialized with private attribute entries via KVM_SET_MEMORY_ATTRIBU=
TES
> > > (which is the current QEMU default behavior).
> > >
> > > I'd originally advocated for sticking with the xarray implementation =
Fuad was
> > > using until we'd determined we really need it for HugeTLB support, bu=
t I'm
> > > sort of thinking it's already justified just based on the above.
> > >
> > > Maybe it would make sense for KVM memory attributes too?
> > >
> > >> +}
> > >> +
> > >> +static enum shareability kvm_gmem_shareability_get(struct inode *in=
ode,
> > >> +                                           pgoff_t index)
> > >> +{
> > >> +  struct maple_tree *mt;
> > >> +  void *entry;
> > >> +
> > >> +  mt =3D &kvm_gmem_private(inode)->shareability;
> > >> +  entry =3D mtree_load(mt, index);
> > >> +  WARN(!entry,
> > >> +       "Shareability should always be defined for all indices in in=
ode.");
> > >> +
> > >> +  return xa_to_value(entry);
> > >> +}
> > >> +
> > >> +static struct folio *kvm_gmem_get_shared_folio(struct inode *inode,=
 pgoff_t index)
> > >> +{
> > >> +  if (kvm_gmem_shareability_get(inode, index) !=3D SHAREABILITY_ALL=
)
> > >> +          return ERR_PTR(-EACCES);
> > >> +
> > >> +  return kvm_gmem_get_folio(inode, index);
> > >> +}
> > >> +
> > >> +#else
> > >> +
> > >> +static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_=
t size, u64 flags)
> > >> +{
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static inline struct folio *kvm_gmem_get_shared_folio(struct inode =
*inode, pgoff_t index)
> > >> +{
> > >> +  WARN_ONCE("Unexpected call to get shared folio.")
> > >> +  return NULL;
> > >> +}
> > >> +
> > >> +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> > >> +
> > >>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_mem=
ory_slot *slot,
> > >>                                pgoff_t index, struct folio *folio)
> > >>  {
> > >> @@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(struct v=
m_fault *vmf)
> > >>
> > >>    filemap_invalidate_lock_shared(inode->i_mapping);
> > >>
> > >> -  folio =3D kvm_gmem_get_folio(inode, vmf->pgoff);
> > >> +  folio =3D kvm_gmem_get_shared_folio(inode, vmf->pgoff);
> > >>    if (IS_ERR(folio)) {
> > >>            int err =3D PTR_ERR(folio);
> > >>
> > >> @@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops =3D=
 {
> > >>    .fallocate      =3D kvm_gmem_fallocate,
> > >>  };
> > >>
> > >> +static void kvm_gmem_free_inode(struct inode *inode)
> > >> +{
> > >> +  struct kvm_gmem_inode_private *private =3D kvm_gmem_private(inode=
);
> > >> +
> > >> +  kfree(private);
> > >> +
> > >> +  free_inode_nonrcu(inode);
> > >> +}
> > >> +
> > >> +static void kvm_gmem_destroy_inode(struct inode *inode)
> > >> +{
> > >> +  struct kvm_gmem_inode_private *private =3D kvm_gmem_private(inode=
);
> > >> +
> > >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> > >> +  /*
> > >> +   * mtree_destroy() can't be used within rcu callback, hence can't=
 be
> > >> +   * done in ->free_inode().
> > >> +   */
> > >> +  if (private)
> > >> +          mtree_destroy(&private->shareability);
> > >> +#endif
> > >> +}
> > >> +
> > >>  static const struct super_operations kvm_gmem_super_operations =3D =
{
> > >>    .statfs         =3D simple_statfs,
> > >> +  .destroy_inode  =3D kvm_gmem_destroy_inode,
> > >> +  .free_inode     =3D kvm_gmem_free_inode,
> > >>  };
> > >>
> > >>  static int kvm_gmem_init_fs_context(struct fs_context *fc)
> > >> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_=
iops =3D {
> > >>  static struct inode *kvm_gmem_inode_make_secure_inode(const char *n=
ame,
> > >>                                                  loff_t size, u64 fl=
ags)
> > >>  {
> > >> +  struct kvm_gmem_inode_private *private;
> > >>    struct inode *inode;
> > >> +  int err;
> > >>
> > >>    inode =3D alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
> > >>    if (IS_ERR(inode))
> > >>            return inode;
> > >>
> > >> +  err =3D -ENOMEM;
> > >> +  private =3D kzalloc(sizeof(*private), GFP_KERNEL);
> > >> +  if (!private)
> > >> +          goto out;
> > >> +
> > >> +  mt_init(&private->shareability);
> > >> +  inode->i_mapping->i_private_data =3D private;
> > >> +
> > >> +  err =3D kvm_gmem_shareability_setup(private, size, flags);
> > >> +  if (err)
> > >> +          goto out;
> > >> +
> > >>    inode->i_private =3D (void *)(unsigned long)flags;
> > >>    inode->i_op =3D &kvm_gmem_iops;
> > >>    inode->i_mapping->a_ops =3D &kvm_gmem_aops;
> > >> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure=
_inode(const char *name,
> > >>    WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> > >>
> > >>    return inode;
> > >> +
> > >> +out:
> > >> +  iput(inode);
> > >> +
> > >> +  return ERR_PTR(err);
> > >>  }
> > >>
> > >>  static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_=
t size,
> > >> @@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_=
create_guest_memfd *args)
> > >>    if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
> > >>            valid_flags |=3D GUEST_MEMFD_FLAG_SUPPORT_SHARED;
> > >>
> > >> +  if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
> > >> +          valid_flags |=3D GUEST_MEMFD_FLAG_INIT_PRIVATE;
> > >> +
> > >>    if (flags & ~valid_flags)
> > >>            return -EINVAL;
> > >>
> > >> @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm=
_memory_slot *slot,
> > >>    if (!file)
> > >>            return -EFAULT;
> > >>
> > >> +  filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> > >> +
> > >
> > > I like the idea of using a write-lock/read-lock to protect write/read=
 access
> > > to shareability state (though maybe not necessarily re-using filemap'=
s
> > > invalidate lock), it's simple and still allows concurrent faulting in=
 of gmem
> > > pages. One issue on the SNP side (which also came up in one of the gm=
em calls)
> > > is if we introduce support for tracking preparedness as discussed (e.=
g. via a
> > > new SHAREABILITY_GUEST_PREPARED state) the
> > > SHAREABILITY_GUEST->SHAREABILITY_GUEST_PREPARED transition would occu=
r at
> > > fault-time, and so would need to take the write-lock and no longer al=
low for
> > > concurrent fault-handling.
> > >
> > > I was originally planning on introducing a new rw_semaphore with simi=
lar
> > > semantics to the rw_lock that Fuad previously had in his restricted m=
map
> > > series[1] (and simiar semantics to filemap invalidate lock here). The=
 main
> > > difference, to handle setting SHAREABILITY_GUEST_PREPARED within faul=
t paths,
> > > was that in the case of a folio being present for an index, the folio=
 lock would
> > > also need to be held in order to update the shareability state. Becau=
se
> > > of that, fault paths (which will always either have or allocate folio
> > > basically) can rely on the folio lock to guard shareability state in =
a more
> > > granular way and so can avoid a global write lock.
> > >
> > > They would still need to hold the read lock to access the tree howeve=
r.
> > > Or more specifically, any paths that could allocate a folio need to t=
ake
> > > a read lock so there isn't a TOCTOU situation where shareability is
> > > being updated for an index for which a folio hasn't been allocated, b=
ut
> > > then just afterward the folio gets faulted in/allocated while the
> > > shareability state is already being updated which the understand that
> > > there was no folio around that needed locking.
> > >
> > > I had a branch with in-place conversion support for SNP[2] that added=
 this
> > > lock reworking on top of Fuad's series along with preparation trackin=
g,
> > > but I'm now planning to rebase that on top of the patches from this
> > > series that Sean mentioned[3] earlier:
> > >
> > >   KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
> > >   KVM: Query guest_memfd for private/shared status
> > >   KVM: guest_memfd: Skip LRU for guest_memfd folios
> > >   KVM: guest_memfd: Introduce KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
> > >   KVM: guest_memfd: Introduce and use shareability to guard faulting
> > >   KVM: guest_memfd: Make guest mem use guest mem inodes instead of an=
onymous inodes
> > >
> > > but figured I'd mention it here in case there are other things to con=
sider on
> > > the locking front.
> > >
> > > Definitely agree with Sean though that it would be nice to start iden=
tifying a
> > > common base of patches for the in-place conversion enablement for SNP=
, TDX, and
> > > pKVM so the APIs/interfaces for hugepages can be handled separately.
> > >
> > > -Mike
> > >
> > > [1] https://lore.kernel.org/kvm/20250328153133.3504118-1-tabba@google=
.com/
> > > [2] https://github.com/mdroth/linux/commits/mmap-swprot-v10-snp0-wip2=
/
> > > [3] https://lore.kernel.org/kvm/aC86OsU2HSFZkJP6@google.com/
> > >
> > >>    folio =3D __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared=
, max_order);
> > >>    if (IS_ERR(folio)) {
> > >>            r =3D PTR_ERR(folio);
> > >> @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm=
_memory_slot *slot,
> > >>            *page =3D folio_file_page(folio, index);
> > >>    else
> > >>            folio_put(folio);
> > >> -
> > >>  out:
> > >> +  filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> > >>    fput(file);
> > >>    return r;
> > >>  }
> > >> --
> > >> 2.49.0.1045.g170613ef41-goog
> > >>
> >


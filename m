Return-Path: <linux-fsdevel+bounces-49753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9034AC20AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA91F18962EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A174B227B88;
	Fri, 23 May 2025 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3EMGKi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47230226520
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995164; cv=none; b=jyE0eADgk/TfN6Yo9JxDpeeA2L1I3XxIvvFVYMheWR+mkz35xUXA3BD1PEw7tU5uMBY1Gqz1RcB55rirw6mlmpgH0mLhGVgCPI/IzjDZlsX1W6se/CMcFChExs/1pCYqsGx9o3CrJudrkDATJ8aJaVZrdBEasElvhMh3wSOvijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995164; c=relaxed/simple;
	bh=Pji3pOrxIsdrF6N7TOopnNprznlfL8393By8J52sO2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0tYxabcDdlB58Zu9OeBs+7Ze4T9/c5/rgn6iLsnWmf9BQdUKz0gcdaBJc90cd6f4ERJU+/v0edd99xPUM3CGgsXuLN+raT/3irtxDMQM42sVhdPM1JiyeFf/rHtXXTX0e4Ju828krQlaEQsnyKWByfFkJxizshr25mnA18opC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3EMGKi+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-48b7747f881so208441cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747995161; x=1748599961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tb9MyJc2bCS8IIcbG5oS2rW0sKmwPpiIghmBwRh5La8=;
        b=w3EMGKi+cPpivPfkOuNZpDjyCE4PYW/26YgPlZJ9U49NwUHRnLT4p7EH3AB691RTB6
         Hui6Fjk8JOQCGT+3wAC+ee7MPe3lsEY2mzjUJ/W8nUiNfeRU5gxgQ8byLqnLtIDl8/Xu
         lEE3BogGlx8bO6MVuqXdSTl0Sd/koXACB01BKPLFYFaw+U981kPu7YDSVU/LJXBAPLfH
         Y987L5MwGido5hQzcinE3kYxVAKRToIakGaClJDe7sCi78hwQZFnQO+910jfUdusplkh
         kYImnw9yq/95UfvHbguON+AZmXfoygNlbZ6PBuG9ASF4b2HMRQR5tlMwGdu8/Z7pWYIq
         YjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995161; x=1748599961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tb9MyJc2bCS8IIcbG5oS2rW0sKmwPpiIghmBwRh5La8=;
        b=DrMMYt2sQQ/56H/108tD/wL1BYipumcaC8YeRUxF8nqsA2aQttVXsS2CoM0L4NCxg2
         s7cK42lubJRH50oJhwhYe96DT4vD0fFRKv1cZkl/Gc8YxnBbMsr5E+iaSASfAtZ2P9XT
         L8B1IDs7qCs4CXnju+ZEG8J/AZBJuVSr1EsYaZ9qqomB30zI1JSJx7RqtNBcw7R/oEBL
         M5FP5UXs/bgoe43u9Xm3JVnTpeNLXoORLJuNE7Eht3Nec2/AVsCgsUzk1cytsOX24ZWE
         hkjDEGXEhfC95Gjvy0fpj4g78VFZckxjHHeyLf8ekNdI7TP5zp+EA/E1V4/UKY6O579s
         QUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN5MC2PvyMgUQ00F4Qoopo/gOS3P29MfUIVMuyfqOmycrP+FANCCVPBaZUoVUOD51uPZpo5O4ashLFbfw/@vger.kernel.org
X-Gm-Message-State: AOJu0YxDC9U599rHjIL4mHXUDBJPd55bzQ1+BSn+huq64PHa8Nj/wsVl
	MaWbwrnXqZvuF3TdhYhg8hJzjFX0rZQjtnHG/YrIU4S8I3dCOKk574RBHXaqfISC7wgiZgKJ1/5
	2WKTlL0Nrb5z/tJw+4aE9gyhqJdeHVrgddsuNQjlk
X-Gm-Gg: ASbGncsAw30NaKM9SpcBbn5l37Gf2WY+sVQ1g3WvC0r8Pny1HI6TRdluoh7uUjpQNyA
	pLCWSX0+O2IQ0ioKR23ojQvnR9pu2kcvuJr8rfeI8NXLN2Y2B/jcSG9XM6HVUlC63WJU3WeXpTp
	9fHrsvsD/iFQMuwZG85mkiMUv5VrJ8ulYTpesjjyTtfOE=
X-Google-Smtp-Source: AGHT+IEkIIS4aNjnOZldCQ1+78h6aJmwPwAW5h7vR8N5+0fx6Rl0x1SYbJYgMD0+JUZ/omAoMfiFpgjWvd8MxNA8Oqo=
X-Received: by 2002:a05:622a:5cf:b0:47d:4e8a:97f0 with SMTP id
 d75a77b69052e-49e35da50e0mr2300641cf.29.1747995160362; Fri, 23 May 2025
 03:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGtprH_7jSpwF77j1GW8rjSrbtZZ2OW2iGck5=Wk67+VnF9vjQ@mail.gmail.com>
 <CA+EHjTzMhKCoftfJUuL0WUZW4DdqOHgVDcn0Cmf-0r--8rBdbg@mail.gmail.com>
 <diqzecwjnk95.fsf@ackerleytng-ctop.c.googlers.com> <CA+EHjTyY5C1QgkoAqvJ0kHM4nUvKc1e1nQ0Uq+BANtVEnZH90w@mail.gmail.com>
 <CAGtprH-fE=G923ctBAcq5zFna+2WULhmHDSbXUsZKUrin29b4g@mail.gmail.com>
 <CA+EHjTxvufYVA8LQWRKEX7zA0gWLQUHVO2LvwKc5JXVu-XAEEA@mail.gmail.com>
 <CAGtprH_TfKT3oRPCLbh-ojLGXSfOQ2XA39pVhr47gb3ikPtUkw@mail.gmail.com>
 <CA+EHjTxJZ_pb7+chRoZxvkxuib2YjbiHg=_+f4bpRt2xDFNCzQ@mail.gmail.com>
 <aC86OsU2HSFZkJP6@google.com> <CA+EHjTxjt-mb_WbtVymaBvCb1EdJAVMV_uGb4xDs_ewg4k0C4g@mail.gmail.com>
 <aC9QPoEUw_nLHhV4@google.com>
In-Reply-To: <aC9QPoEUw_nLHhV4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 23 May 2025 11:12:03 +0100
X-Gm-Features: AX0GCFsTSgoQuYeHe63NUWNK_TXQp_3mL71CbShDN1o-eae1QjvK7sqPLnnLNQo
Message-ID: <CA+EHjTzMYSHKuxMJbpMx594RsL64aph1dWj06zx_01=ZuQU+Bg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Sean Christopherson <seanjc@google.com>
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
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Sean,


On Thu, 22 May 2025 at 17:26, Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, May 22, 2025, Fuad Tabba wrote:
> > On Thu, 22 May 2025 at 15:52, Sean Christopherson <seanjc@google.com> wrote:
> > > On Wed, May 21, 2025, Fuad Tabba wrote:
> > > > How does the host userspace find that out? If the host userspace is capable
> > > > of finding that out, then surely KVM is also capable of finding out the same.
> > >
> > > Nope, not on x86.  Well, not without userspace invoking a new ioctl, which would
> > > defeat the purpose of adding these ioctls.
> > >
> > > KVM is only responsible for emulating/virtualizing the "CPU".  The chipset, e.g.
> > > the PCI config space, is fully owned by userspace.  KVM doesn't even know whether
> > > or not PCI exists for the VM.  And reboot may be emulated by simply creating a
> > > new KVM instance, i.e. even if KVM was somehow aware of the reboot request, the
> > > change in state would happen in an entirely new struct kvm.
> > >
> > > That said, Vishal and Ackerley, this patch is a bit lacking on the documentation
> > > front.  The changelog asserts that:
> > >
> > >   A guest_memfd ioctl is used because shareability is a property of the memory,
> > >   and this property should be modifiable independently of the attached struct kvm
> > >
> > > but then follows with a very weak and IMO largely irrelevant justification of:
> > >
> > >   This allows shareability to be modified even if the memory is not yet bound
> > >   using memslots.
> > >
> > > Allowing userspace to change shareability without memslots is one relatively minor
> > > flow in one very specific use case.
> > >
> > > The real justification for these ioctls is that fundamentally, shareability for
> > > in-place conversions is a property of a guest_memfd instance and not a struct kvm
> > > instance, and so needs to owned by guest_memfd.
> >
> > Thanks for the clarification Sean. I have a couple of followup
> > questions/comments that you might be able to help with:
> >
> > From a conceptual point of view, I understand that the in-place conversion is
> > a property of guest_memfd. But that doesn't necessarily mean that the
> > interface between kvm <-> guest_memfd is a userspace IOCTL.
>
> kvm and guest_memfd aren't the communication endpoints for in-place conversions,
> and more importantly, kvm isn't part of the control plane.  kvm's primary role
> (for guest_memfd with in-place conversions) is to manage the page tables to map
> memory into the guest.
>
> kvm *may* also explicitly provide a communication channel between the guest and
> host, e.g. when conversions are initiated via hypercalls, but in some cases the
> communication channel may be created through pre-existing mechanisms, e.g. a
> shared memory buffer or emulated I/O (such as the PCI reset case).
>
>   guest => kvm (dumb pipe) => userspace => guest_memfd => kvm (invalidate)
>
> And in other cases, kvm might not be in that part of the picture at all, e.g. if
> the userspace VMM provides an interface to the VM owner (which could also be the
> user running the VM) to reset the VM, then the flow would look like:
>
>   userspace => guest_memfd => kvm (invalidate)
>
> A decent comparison is vCPUs.  KVM _could_ route all ioctls through the VM, but
> that's unpleasant for all parties, as it'd be cumbersome for userspace, and
> unnecessarily complex and messy for KVM.  Similarly, routing guest_memfd state
> changes through KVM_SET_MEMORY_ATTRIBUTES is awkward from both design and mechanical
> perspectives.
>
> Even if we disagree on how ugly/pretty routing conversions through kvm would be,
> which I'll allow is subjective, the bigger problem is that bouncing through
> KVM_SET_MEMORY_ATTRIBUTES would create an unholy mess of an ABI.
>
> Today, KVM_SET_MEMORY_ATTRIBUTES is handled entirely within kvm, and any changes
> take effect irrespective of any memslot bindings.  And that didn't happen by
> chance; preserving and enforcing attribute changes independently of memslots was
> a key design requirement, precisely because memslots are ephemeral to a certain
> extent.
>
> Adding support for in-place guest_memfd conversion will require new ABI, and so
> will be a "breaking" change for KVM_SET_MEMORY_ATTRIBUTES no matter what.  E.g.
> KVM will need to reject KVM_MEMORY_ATTRIBUTE_PRIVATE for VMs that elect to use
> in-place guest_memfd conversions.  But very critically, KVM can cripsly enumerate
> the lack of KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_CAP_MEMORY_ATTRIBUTES, the
> behavior will be very straightforward to document (e.g. CAP X is mutually excusive
> with KVM_MEMORY_ATTRIBUTE_PRIVATE), and it will be opt-in, i.e. won't truly be a
> breaking change.
>
> If/when we move shareability to guest_memfd, routing state changes through
> KVM_SET_MEMORY_ATTRIBUTES will gain a subtle dependency on userspace having to
> create memslots in order for state changes to take effect.  That wrinkle would be
> weird and annoying to document, e.g. "if CAP X is enabled, the ioctl ordering is
> A => B => C, otherwise the ordering doesn't matter", and would create many more
> conundrums:
>
>   - If a memslot needs to exist in order for KVM_SET_MEMORY_ATTRIBUTES to take effect,
>     what should happen if that memslot is deleted?
>   - If a memslot isn't found, should KVM_SET_MEMORY_ATTRIBUTES fail and report
>     an error, or silently do nothing?
>   - If KVM_SET_MEMORY_ATTRIBUTES affects multiple memslots that are bound to
>     multiple guest_memfd, how does KVM guarantee atomicity?  What happens if one
>     guest_memfd conversion succeeds, but a later fails?
>
> > We already communicate directly between the two. Other, even less related
> > subsystems within the kernel also interact without going through userspace.
> > Why can't we do the same here? I'm not suggesting it not be owned by
> > guest_memfd, but that we communicate directly.
>
> I'm not concerned about kvm communicating with guest_memfd, as you note it's all
> KVM.  As above, my concerns are all about KVM's ABI and who owns/controls what.
>
> > From a performance point of view, I would expect the common case to be that
> > when KVM gets an unshare request from the guest, it would be able to unmap
> > those pages from the (cooperative) host userspace, and return back to the
> > guest. In this scenario, the host userspace wouldn't even need to be
> > involved.
>
> Hard NAK, at least from an x86 perspective.  Userspace is the sole decision maker
> with respect to what memory is state of shared vs. private, full stop.  The guest
> can make *requests* to convert memory, but ultimately it's host userspace that
> decides whether or not to honor the request.
>
> We've litigated this exact issue multiple times.  All state changes must be
> controlled by userspace, because userspace is the only entity that can gracefully
> handle exceptions and edge cases, and is the only entity with (almost) full
> knowledge of the system.  We can discuss this again if necessary, but I'd much
> prefer to not rehash all of those conversations.
>
> > Having a userspace IOCTL as part of this makes that trip unnecessarily longer
> > for the common case.
>
> I'm very skeptical that an exit to userspace is going to even be measurable in
> terms of the cost to convert memory.  Conversion is going to require multiple
> locks, modifications to multiple sets of page tables with all the associated TLB
> maintenance, possibly cache maintenance, and probably a few other things I'm
> forgetting.  The cost of a few user<=>kernel transitions is likely going to be a
> drop in the bucket.
>
> If I'm wrong, and there are flows where the user<=>kernel transitions are the
> long pole, then we could certainly exploring adding a way for userspace to opt
> into a "fast path" conversion.  But it would need to be exactly that, an optional
> fast path that can fall back to the "slow" userspace-driven conversion as needed.

Thanks for this very thorough explanation. I know that we have
litigated this issue, but not this _exact_ issue. My understanding was
that the main reason for using IOCTLs for memory attributes is that
userspace needs to manage private and shared memory seperately,
including allocation and punching holes where necessary.

That said, no need to discuss this again. If it turns out that
user<->kernel transitions are a bottleneck we could look into an
opt-in fast path as you said.

Cheers,
/fuad


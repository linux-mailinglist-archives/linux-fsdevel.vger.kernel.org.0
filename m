Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95637BA53F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 18:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbjJEQPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 12:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbjJEQNi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:38 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D46995
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 07:43:19 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d81afd5273eso1126508276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696516999; x=1697121799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EE8iPYu9LpRlrA3P5svRFO6CzOzjvPUAMSGvj485Oxk=;
        b=inptMAmDcUZ1iBCTY/rT4ZJ75tNZgRwaf6/zv4O44QzEe+ZBaFB053c+VOj3C4QipE
         zMd3KGrBNxPCRXwqq1eVQpP9HB/gPjmGNvFGD/oshJzSOEdaCYIrYk80LOKEJGLs6wzF
         IzrmKnbTd8vJPVU4VxrBBFi1dwoGbLrnE+ePMOrSam8Z3FyJiYZRJOyaw7Gc6ehQdczz
         kuadF+lYJQ6jNTREZqwL7fMtvowk4Lg/LP8kG4CiqDg5BDXkY4OEB5cCttwxjLvLAtJH
         c1vJ5f88oeq9RNFpgmcs5T/k9u5AUAMp4qdytFz3UEGHD+Z+7oNCmB0arvYqa1lVa+AN
         J2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696516999; x=1697121799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EE8iPYu9LpRlrA3P5svRFO6CzOzjvPUAMSGvj485Oxk=;
        b=UMsKfOszN8RCI5/XrqAGx4a+8/SRgY1sznADksSzLbb87zMtz4D2cj8vNfv4OWPpML
         BlLyAuZ99xBQY207mVuDpgXq0aSNKlAtMxGw7HmFkP9XUzUV9JJJiw07foCHlYQFNwb9
         8vctGYTkTnBLw6ZY+9jdsdalCGzJ/GRTo5Tf851TaKjun7TR7Zks90nG24LPK2CVp1zG
         ULm0uiuUwwKO3nBROgsPxeqoYlBqb5NA47eEONOBngtg3TeNDExUH2Qzuluf965RMt3q
         ZhRfGwb2mavbB1S7imgHp7zrKIXbAZiQRF3ythcbSozC9DXvaRE7urY6D73Xn7H77jcC
         /UzQ==
X-Gm-Message-State: AOJu0Ywt9g8rrGJW0/zcNW67JHqz2mNQpt7vPDhjlmA/ysXhZrAMIY6s
        aZqONknjTTWm38AiXLKFeAS+qGjEG6jPS2rkVTXqKQ==
X-Google-Smtp-Source: AGHT+IGOqTvtxfqWgNnMMFc4737tOPznDx2Ec+u1Qc6vg6Ytf9IAjo7xOI8HjQPL083wFsBnlWD0qahO/3mYB56VT9A=
X-Received: by 2002:a25:23ce:0:b0:d91:5a1b:eea with SMTP id
 j197-20020a2523ce000000b00d915a1b0eeamr4876224ybj.50.1696516998560; Thu, 05
 Oct 2023 07:43:18 -0700 (PDT)
MIME-Version: 1.0
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 5 Oct 2023 15:42:42 +0100
Message-ID: <CA+EHjTwTgEVtea7wgef5G6EEgFa0so_GbNXTMZNKyFE=ucyV0g@mail.gmail.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, KVM <kvm@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        KVMARM <kvmarm@lists.linux.dev>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sean,

On Tue, Oct 3, 2023 at 9:51=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Oct 03, 2023, Fuad Tabba wrote:
> > On Tue, Oct 3, 2023 at 4:59=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > > On Tue, Oct 03, 2023, Fuad Tabba wrote:
> > > > > +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> > > > > +
> > > >
> > > > In pKVM, we don't want to allow setting (or clearing) of PRIVATE/SH=
ARED
> > > > attributes from userspace.
> > >
> > > Why not?  The whole thing falls apart if userspace doesn't *know* the=
 state of a
> > > page, and the only way for userspace to know the state of a page at a=
 given moment
> > > in time is if userspace controls the attributes.  E.g. even if KVM we=
re to provide
> > > a way for userspace to query attributes, the attributes exposed to us=
rspace would
> > > become stale the instant KVM drops slots_lock (or whatever lock prote=
cts the attributes)
> > > since userspace couldn't prevent future changes.
> >
> > I think I might not quite understand the purpose of the
> > KVM_SET_MEMORY_ATTRIBUTES ABI. In pKVM, all of a protected guest's memo=
ry is
> > private by default, until the guest shares it with the host (via a
> > hypercall), or another guest (future work). When the guest shares it,
> > userspace is notified via KVM_EXIT_HYPERCALL. In many use cases, usersp=
ace
> > doesn't need to keep track directly of all of this, but can reactively =
un/map
> > the memory being un/shared.
>
> Yes, and then userspace needs to tell KVM, via KVM_SET_MEMORY_ATTRIBUTES,=
 that
> userspace has agreed to change the state of the page.  Userspace may not =
need/want
> to explicitly track the state of pages, but userspace still needs to tell=
 KVM what
> userspace wants.
>
> KVM is primarily an accelerator, e.g. KVM's role is to make things go fas=
t (relative
> to doing things in userspace) and provide access to resources/instruction=
s that
> require elevated privileges.  As a general rule, we try to avoid defining=
 the vCPU
> model, security policies, etc. in KVM, because hardcoding policy into KVM=
 (and the
> kernel as a whole) eventually limits the utility of KVM.
>
> As it pertains to PRIVATE vs. SHARED, KVM's role is to define and enforce=
 the basic
> rules, but KVM shouldn't do things like define when it is (il)legal to co=
nvert
> memory to/from SHARED, what pages can be converted, what happens if the g=
uest and
> userspace disagree, etc.

Thanks for clarifying that. My initial understanding of the purpose of
KVM_SET_MEMORY_ATTRIBUTES wasn't clear. Now I see how having the
userspace view in KVM would avoid the need to hardcore many policies,
and I can see how this could come in handy in the future when we start
going into multi-sharing, for example.

> > > Why does pKVM need to prevent userspace from stating *its* view of at=
tributes?
> > >
> > > If the goal is to reduce memory overhead, that can be solved by using=
 an internal,
> > > non-ABI attributes flag to track pKVM's view of SHARED vs. PRIVATE.  =
If the guest
> > > attempts to access memory where pKVM and userspace don't agree on the=
 state,
> > > generate an exit to userspace.  Or kill the guest.  Or do something e=
lse entirely.
> >
> > For the pKVM hypervisor the guest's view of the attributes doesn't
> > matter. The hypervisor at the end of the day is the ultimate arbiter
> > for what is shared and with how. For pKVM (at least in my port of
> > guestmem), we use the memory attributes from guestmem essentially to
> > control which memory can be mapped by the host.
>
> The guest's view absolutely matters.  The guest's view may not be express=
ed at
> access time, e.g. as you note below, pKVM and other software-protected VM=
s don't
> have a dedicated shared vs. private bit like TDX and SNP.  But the view i=
s still
> there, e.g. in the pKVM model, the guest expresses its desire for shared =
vs.
> private via hypercall, and IIRC, the guest's view is tracked by the hyper=
visor
> in the stage-2 PTEs.  pKVM itself may track the guest's view on things, b=
ut the
> view is still the guest's.

This was poorly worded on my part. You're right that in practice the
pKVM hypervisor is the one tracking the guest's view, based on the
hypercalls from the guest.

> E.g. if the guest thinks a page is private, but in reality KVM and host u=
serspace
> have it as shared, then the guest may unintentionally leak data to the un=
trusted
> world.
>
> IIUC, you have implemented guest_memfd support in pKVM by changing the at=
tributes
> when the guest makes the hypercall.  This can work, but only so long as t=
he guest
> and userspace are well-behaved, and it will likely paint pKVM into a corn=
er in
> the long run.
>
> E.g. if the guest makes a hypercall to convert memory to PRIVATE, but the=
re is
> no memslot or the memslot doesn't support private memory, then unless the=
re is
> policy baked into KVM, or an ABI for the guest<=3D>host hypercall interfa=
ce that
> allows unwinding the program counter, you're stuck.  Returning an error f=
or the
> hypercall straight from KVM is undesirable as that would put policy into =
KVM that
> doesn't need to be there, e.g. that would prevent userspace from manipula=
ting
> memslots in response to (un)share requests from the guest.  It's a simila=
r story
> if KVM marks the page as PRIVATE, as that would prevent userspace from re=
turning
> an error for the hypercall, i.e. would prevent usersepace from denying th=
e request
> to convert to PRIVATE.

Ack.

> > One difference between pKVM and TDX (as I understand it), is that TDX
> > uses the msb of the guest's IPA to indicate whether memory is shared
> > or private, and that can generate a mismatch on guest memory access
> > between what it thinks the state is, and what the sharing state in
> > reality is. pKVM doesn't have that. Memory is private by default, and
> > can be shared in-place, both in the guest's IPA space as well as the
> > underlying physical page.
>
> TDX's shared bit and SNP's encryption bit are just a means of hardware en=
forcement.
> pKVM does have a hardware bit because hardware doesn't provide any enforc=
ement.
> But as above, pKVM does have an equivalent *somewhere*.
>
> > > > The other thing, which we need for pKVM anyway, is to make
> > > > kvm_vm_set_mem_attributes() global, so that it can be called from o=
utside of
> > > > kvm_main.c (already have a local patch for this that declares it in
> > > > kvm_host.h),
> > >
> > > That's no problem, but I am definitely opposed to KVM modifying attri=
butes that
> > > are owned by userspace.
> > >
> > > > and not gate this function by KVM_GENERIC_MEMORY_ATTRIBUTES.
> > >
> > > As above, I am opposed to pKVM having a completely different ABI for =
managing
> > > PRIVATE vs. SHARED.  I have no objection to pKVM using unclaimed flag=
s in the
> > > attributes to store extra metadata, but if KVM_SET_MEMORY_ATTRIBUTES =
doesn't work
> > > for pKVM, then we've failed miserably and should revist the uAPI.
> >
> > Like I said, pKVM doesn't need a userspace ABI for managing PRIVATE/SHA=
RED,
> > just a way of tracking in the host kernel of what is shared (as opposed=
 to
> > the hypervisor, which already has the knowledge). The solution could si=
mply
> > be that pKVM does not enable KVM_GENERIC_MEMORY_ATTRIBUTES, has its own
> > tracking of the status of the guest pages, and only selects KVM_PRIVATE=
_MEM.
>
> At the risk of overstepping my bounds, I think that effectively giving th=
e guest
> full control over what is shared vs. private is a mistake.  It more or le=
ss locks
> pKVM into a single model, and even within that model, dealing with errors=
 and/or
> misbehaving guests becomes unnecessarily problematic.
>
> Using KVM_SET_MEMORY_ATTRIBUTES may not provide value *today*, e.g. the u=
serspace
> side of pKVM could simply "reflect" all conversion hypercalls, and termin=
ate the
> VM on errors.  But the cost is very minimal, e.g. a single extra ioctl() =
per
> converion, and the upside is that pKVM won't be stuck if a use case comes=
 along
> that wants to go beyond "all conversion requests either immediately succe=
ed or
> terminate the guest".

Now that I understand the purpose of KVM_SET_MEMORY_ATTRIBUTES, I
agree. However, pKVM needs to track at the host kernel (i.e., EL1)
whether guest memory is shared or private.

One approach would be to add another flag to the attributes that
tracks the host kernel view. The way KVM_SET_MEMORY_ATTRIBUTES is
implemented now, userspace can zero it, so in that case, that
operation would need to be masked to avoid that.

Another approach would be to have a pKVM-specific xarray (or similar)
to do the tracking, but since there is a structure that's already
doing something similar (i.e.,the attributes array), it seems like it
would be unnecessary overhead.

Do you have any ideas or preferences?

Cheers,
/fuad

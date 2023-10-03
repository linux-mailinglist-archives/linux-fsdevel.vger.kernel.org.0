Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE06C7B72C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 22:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbjJCUv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbjJCUv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:51:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1710AAD
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 13:51:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a21e8ee1b7so1884747b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696366314; x=1696971114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iN51NFJCcwM1r+zCqreeXDah/vTq4bXHZX6Qt4tveaY=;
        b=I53tIslNZ2g0S11bZf2QYnC3TXU8GsQ5TZKgbNeBXYQ0DYf8vjlKsDuSKtkPJSP2Ac
         ydwJwoppI5azIlbho2hAMJuFvAvip0xKq/EBAjakEatheib2Pp1e7S8uznEtJnq+ZRcQ
         r2wlYLRae2qT3yrfBtc0ngMAKazXNYaX3eQaILAsLAHMv0HDMn18oM7uYBNKKMJ1XYc9
         r0+sMJB7qK1XfBGr81onrTY0UoVDUFf+kDkH/c4zWvCyJYROrxDA7fTkV4EbEcs+Vjk8
         KmriiWNCuL7dzYmgZNrVMuSKYwjv9rV+C+JkhtP1ug8ouQNTvhpH3yQcylRVfvX0lo73
         MOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696366314; x=1696971114;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iN51NFJCcwM1r+zCqreeXDah/vTq4bXHZX6Qt4tveaY=;
        b=ZxieqWzOX/F1KKf6uhr/h++Z8D7zGnZ6zHbV2W9E+u/cCxDixE1Y6SsC9c8Z1jHsm1
         h4Mgt0guG7SbZHOxzV56QTYhK6fCrjnKeKaBb0+CPiWKZoM08YWlDPc4Hn9RghlTWorG
         EsN3xo+d75ADwDk8fmf0JmFDQTX+O4TlrNoggI0ak8DD05MrHhx2vOYfZW7zM37mYAoy
         AhBTpm3wCxfrcwyZWTWy1cTvsqRr5NX/+QAshlXTMSfkVGeq1YtFj/VZQfzqMUVuvXfs
         vUrGRTx53IjzwPEakXCbXReOP8L0kumrOrbf1v5g9iTmWmzCHcYZecXR/LxoQJNUfm2V
         0O5Q==
X-Gm-Message-State: AOJu0YxzdMADAN8F2nsuQzM/nCTa1kkVHI8SjXJ81id5mNXo4JNDUrSt
        8pq+UgldSgwaAAKTljBmlClfI1SWf3g=
X-Google-Smtp-Source: AGHT+IH9SpWB5ZYki6B4kneRjXWww1fW5aqwjgYpBvf3LyPRvX5qN4iOqywaVkHZ9PW5pYyi5WCeWQUyODc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:b83:b0:59b:b0b1:d75a with SMTP id
 ck3-20020a05690c0b8300b0059bb0b1d75amr85511ywb.4.1696366314084; Tue, 03 Oct
 2023 13:51:54 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:51:52 -0700
In-Reply-To: <CA+EHjTzx+0pxh7DYONZUeJsm1GCiC6L8Vg_Tm9MLVEae-FKuQg@mail.gmail.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
 <CA+EHjTzSUXx8P9gWmUERg4owxH6r6yNPm1_RL-BzS_2CNPtRKw@mail.gmail.com>
 <ZRw6X2BptZnRPNK7@google.com> <CA+EHjTzx+0pxh7DYONZUeJsm1GCiC6L8Vg_Tm9MLVEae-FKuQg@mail.gmail.com>
Message-ID: <ZRx-6F6NSd9QU8QT@google.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
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
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023, Fuad Tabba wrote:
> On Tue, Oct 3, 2023 at 4:59=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > On Tue, Oct 03, 2023, Fuad Tabba wrote:
> > > > +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> > > > +
> > >
> > > In pKVM, we don't want to allow setting (or clearing) of PRIVATE/SHAR=
ED
> > > attributes from userspace.
> >
> > Why not?  The whole thing falls apart if userspace doesn't *know* the s=
tate of a
> > page, and the only way for userspace to know the state of a page at a g=
iven moment
> > in time is if userspace controls the attributes.  E.g. even if KVM were=
 to provide
> > a way for userspace to query attributes, the attributes exposed to usrs=
pace would
> > become stale the instant KVM drops slots_lock (or whatever lock protect=
s the attributes)
> > since userspace couldn't prevent future changes.
>=20
> I think I might not quite understand the purpose of the
> KVM_SET_MEMORY_ATTRIBUTES ABI. In pKVM, all of a protected guest's memory=
 is
> private by default, until the guest shares it with the host (via a
> hypercall), or another guest (future work). When the guest shares it,
> userspace is notified via KVM_EXIT_HYPERCALL. In many use cases, userspac=
e
> doesn't need to keep track directly of all of this, but can reactively un=
/map
> the memory being un/shared.

Yes, and then userspace needs to tell KVM, via KVM_SET_MEMORY_ATTRIBUTES, t=
hat
userspace has agreed to change the state of the page.  Userspace may not ne=
ed/want
to explicitly track the state of pages, but userspace still needs to tell K=
VM what
userspace wants.

KVM is primarily an accelerator, e.g. KVM's role is to make things go fast =
(relative
to doing things in userspace) and provide access to resources/instructions =
that
require elevated privileges.  As a general rule, we try to avoid defining t=
he vCPU
model, security policies, etc. in KVM, because hardcoding policy into KVM (=
and the
kernel as a whole) eventually limits the utility of KVM.

As it pertains to PRIVATE vs. SHARED, KVM's role is to define and enforce t=
he basic
rules, but KVM shouldn't do things like define when it is (il)legal to conv=
ert
memory to/from SHARED, what pages can be converted, what happens if the gue=
st and
userspace disagree, etc.

> > Why does pKVM need to prevent userspace from stating *its* view of attr=
ibutes?
> >
> > If the goal is to reduce memory overhead, that can be solved by using a=
n internal,
> > non-ABI attributes flag to track pKVM's view of SHARED vs. PRIVATE.  If=
 the guest
> > attempts to access memory where pKVM and userspace don't agree on the s=
tate,
> > generate an exit to userspace.  Or kill the guest.  Or do something els=
e entirely.
>=20
> For the pKVM hypervisor the guest's view of the attributes doesn't
> matter. The hypervisor at the end of the day is the ultimate arbiter
> for what is shared and with how. For pKVM (at least in my port of
> guestmem), we use the memory attributes from guestmem essentially to
> control which memory can be mapped by the host.

The guest's view absolutely matters.  The guest's view may not be expressed=
 at
access time, e.g. as you note below, pKVM and other software-protected VMs =
don't
have a dedicated shared vs. private bit like TDX and SNP.  But the view is =
still
there, e.g. in the pKVM model, the guest expresses its desire for shared vs=
.
private via hypercall, and IIRC, the guest's view is tracked by the hypervi=
sor
in the stage-2 PTEs.  pKVM itself may track the guest's view on things, but=
 the
view is still the guest's.

E.g. if the guest thinks a page is private, but in reality KVM and host use=
rspace
have it as shared, then the guest may unintentionally leak data to the untr=
usted
world.

IIUC, you have implemented guest_memfd support in pKVM by changing the attr=
ibutes
when the guest makes the hypercall.  This can work, but only so long as the=
 guest
and userspace are well-behaved, and it will likely paint pKVM into a corner=
 in
the long run.

E.g. if the guest makes a hypercall to convert memory to PRIVATE, but there=
 is
no memslot or the memslot doesn't support private memory, then unless there=
 is
policy baked into KVM, or an ABI for the guest<=3D>host hypercall interface=
 that
allows unwinding the program counter, you're stuck.  Returning an error for=
 the
hypercall straight from KVM is undesirable as that would put policy into KV=
M that
doesn't need to be there, e.g. that would prevent userspace from manipulati=
ng
memslots in response to (un)share requests from the guest.  It's a similar =
story
if KVM marks the page as PRIVATE, as that would prevent userspace from retu=
rning
an error for the hypercall, i.e. would prevent usersepace from denying the =
request
to convert to PRIVATE.

> One difference between pKVM and TDX (as I understand it), is that TDX
> uses the msb of the guest's IPA to indicate whether memory is shared
> or private, and that can generate a mismatch on guest memory access
> between what it thinks the state is, and what the sharing state in
> reality is. pKVM doesn't have that. Memory is private by default, and
> can be shared in-place, both in the guest's IPA space as well as the
> underlying physical page.

TDX's shared bit and SNP's encryption bit are just a means of hardware enfo=
rcement.
pKVM does have a hardware bit because hardware doesn't provide any enforcem=
ent.
But as above, pKVM does have an equivalent *somewhere*.

> > > The other thing, which we need for pKVM anyway, is to make
> > > kvm_vm_set_mem_attributes() global, so that it can be called from out=
side of
> > > kvm_main.c (already have a local patch for this that declares it in
> > > kvm_host.h),
> >
> > That's no problem, but I am definitely opposed to KVM modifying attribu=
tes that
> > are owned by userspace.
> >
> > > and not gate this function by KVM_GENERIC_MEMORY_ATTRIBUTES.
> >
> > As above, I am opposed to pKVM having a completely different ABI for ma=
naging
> > PRIVATE vs. SHARED.  I have no objection to pKVM using unclaimed flags =
in the
> > attributes to store extra metadata, but if KVM_SET_MEMORY_ATTRIBUTES do=
esn't work
> > for pKVM, then we've failed miserably and should revist the uAPI.
>=20
> Like I said, pKVM doesn't need a userspace ABI for managing PRIVATE/SHARE=
D,
> just a way of tracking in the host kernel of what is shared (as opposed t=
o
> the hypervisor, which already has the knowledge). The solution could simp=
ly
> be that pKVM does not enable KVM_GENERIC_MEMORY_ATTRIBUTES, has its own
> tracking of the status of the guest pages, and only selects KVM_PRIVATE_M=
EM.

At the risk of overstepping my bounds, I think that effectively giving the =
guest
full control over what is shared vs. private is a mistake.  It more or less=
 locks
pKVM into a single model, and even within that model, dealing with errors a=
nd/or
misbehaving guests becomes unnecessarily problematic.

Using KVM_SET_MEMORY_ATTRIBUTES may not provide value *today*, e.g. the use=
rspace
side of pKVM could simply "reflect" all conversion hypercalls, and terminat=
e the
VM on errors.  But the cost is very minimal, e.g. a single extra ioctl() pe=
r
converion, and the upside is that pKVM won't be stuck if a use case comes a=
long
that wants to go beyond "all conversion requests either immediately succeed=
 or
terminate the guest".

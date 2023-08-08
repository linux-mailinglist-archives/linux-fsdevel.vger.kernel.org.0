Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C00774CCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 23:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjHHVSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 17:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjHHVSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:18:12 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9559211F
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 14:13:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56463e0340cso6299735a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691529208; x=1692134008;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2U8op5NWCZxGer1aWuXuZ1d6J73Ge5+Hk7EgkvJJLAs=;
        b=EiApR7LgfgrJOIT4RH8vwTp7YvtN3WX8F65amcCZ5tUQpyv/ZsbnzElbxtLH3YiRAr
         Xco5OB//pxBTUJ1Hz9I9wbK8VFMOtBI25Tou7znxlR4xLwF5hwG16hAzm3VNuOm7qNVv
         RXaphvZexnvsjJwdUedz4miwZlrHjyPKGJ4tg41nXpc1Cr1tDeUR45j+cXRmHY2zeNeJ
         aD2FSNHH9s2X0AH/332mpiw5dSfBYPcqgRab/m5d5fFkQb+ZWPzwvwukMvExFid52TaS
         W3qOIOCRBt/UK+p15DAoWro/GC9Q6ni0EalNj49A0OSEsHwDkeyMMKxa0prAwizF/XXF
         JV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691529208; x=1692134008;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2U8op5NWCZxGer1aWuXuZ1d6J73Ge5+Hk7EgkvJJLAs=;
        b=BfHJBEN1ubECwusSFCsyULi7vmgS6rTbnt8+2RWTD9aAGRBH9xvbeu15Ak5P+hPG4U
         soA/4U4gIwos9dA1iZdevG6V/PILr/l8vYvKD+sfcOu15x5y7pkfmnAdx4VW42lVbgcq
         Q884Z7xViH0Ql6o4tGu6axdYalQirc8uKOqOLWnekdR4LnoOMJqR4Umg3D5v4K3Yq8Wl
         LCI3uJFkXemTjbln+S1GeNMH0GGslTagfJNnE8vZ2lshmGCUMAOo792YeleaoK91uH4D
         dUbQD6ET4Adx8uY4tEp5J0vw+7K+vil8yVaBhFZP1RMYrXmRxuwyu3m1hjTMVXvCfR3v
         mtoQ==
X-Gm-Message-State: AOJu0YwnpsvNAhKcnWUrSRnyEg8wR4hj5i0SaPt2sBnRgYG1J+0wJdNA
        IhxAQN9SRiPmOmzRSdJnMCNbo2ACP6s=
X-Google-Smtp-Source: AGHT+IF3VhVvM3seA6Kd3G1yrwf0aF3MmO0cqr5SVZX1MHXlsabrjEav/SHlO1qK0PHGPVCVUrfGthX1EsA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:b242:0:b0:563:e937:5e87 with SMTP id
 t2-20020a63b242000000b00563e9375e87mr12735pgo.5.1691529208021; Tue, 08 Aug
 2023 14:13:28 -0700 (PDT)
Date:   Tue, 8 Aug 2023 14:13:26 -0700
In-Reply-To: <diqzv8dq3116.fsf@ackerleytng-ctop.c.googlers.com>
Mime-Version: 1.0
References: <20230718234512.1690985-13-seanjc@google.com> <diqzv8dq3116.fsf@ackerleytng-ctop.c.googlers.com>
Message-ID: <ZNKv9ul2I7A4V7IF@google.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023, Ackerley Tng wrote:
> I=E2=80=99d like to propose an alternative to the refcounting approach be=
tween
> the gmem file and associated kvm, where we think of KVM=E2=80=99s memslot=
s as
> users of the gmem file.
>=20
> Instead of having the gmem file pin the VM (i.e. take a refcount on
> kvm), we could let memslot take a refcount on the gmem file when the
> memslots are configured.
>=20
> Here=E2=80=99s a POC patch that flips the refcounting (and modified selft=
ests in
> the next commit):
> https://github.com/googleprodkernel/linux-cc/commit/7f487b029b89b9f3e9b09=
4a721bc0772f3c8c797
>=20
> One side effect of having the gmem file pin the VM is that now the gmem
> file becomes sort of a false handle on the VM:
>=20
> + Closing the file destroys the file pointers in the VM and invalidates
>   the pointers

Yeah, this is less than ideal.  But, it's also how things operate today.  K=
VM
doesn't hold references to VMAs or files, e.g. if userspace munmap()s memor=
y,
any and all SPTEs pointing at the memory are zapped.  The only difference w=
ith
gmem is that KVM needs to explicitly invalidate file pointers, instead of t=
hat
happening behind the scenes (no more VMAs to find).  Again, I agree the res=
ulting
code is more complex than I would prefer, but from a userspace perspective =
I
don't see this as problematic.

> + Keeping the file open keeps the VM around in the kernel even though
>   the VM fd may already be closed.

That is perfectly ok.  There is plenty of prior art, as well as plenty of w=
ays
for userspace to shoot itself in the foot.  E.g. open a stats fd for a vCPU=
 and
the VM and all its vCPUs will be kept alive.  And conceptually it's sound,
anything created in the scope of a VM _should_ pin the VM.

> I feel that memslots form a natural way of managing usage of the gmem
> file. When a memslot is created, it is using the file; hence we take a
> refcount on the gmem file, and as memslots are removed, we drop
> refcounts on the gmem file.

Yes and no.  It's definitely more natural *if* the goal is to allow guest_m=
emfd
memory to exist without being attached to a VM.  But I'm not at all convinc=
ed
that we want to allow that, or that it has desirable properties.  With TDX =
and
SNP in particuarly, I'm pretty sure that allowing memory to outlive the VM =
is
very underisable (more below).

> The KVM pointer is shared among all the bindings in gmem=E2=80=99s xarray=
, and we can
> enforce that a gmem file is used only with one VM:
>=20
> + When binding a memslot to the file, if a kvm pointer exists, it must
>   be the same kvm as the one in this binding
> + When the binding to the last memslot is removed from a file, NULL the
>   kvm pointer.

Nullifying the KVM pointer isn't sufficient, because without additional act=
ions
userspace could extract data from a VM by deleting its memslots and then bi=
nding
the guest_memfd to an attacker controlled VM.  Or more likely with TDX and =
SNP,
induce badness by coercing KVM into mapping memory into a guest with the wr=
ong
ASID/HKID.

I can think of three ways to handle that:

  (a) prevent a different VM from *ever* binding to the gmem instance
  (b) free/zero physical pages when unbinding
  (c) free/zero when binding to a different VM

Option (a) is easy, but that pretty much defeats the purpose of decopuling
guest_memfd from a VM.

Option (b) isn't hard to implement, but it screws up the lifecycle of the m=
emory,
e.g. would require memory when a memslot is deleted.  That isn't necessaril=
y a
deal-breaker, but it runs counter to how KVM memlots currently operate.  Me=
mslots
are basically just weird page tables, e.g. deleting a memslot doesn't have =
any
impact on the underlying data in memory.  TDX throws a wrench in this as re=
moving
a page from the Secure EPT is effectively destructive to the data (can't be=
 mapped
back in to the VM without zeroing the data), but IMO that's an oddity with =
TDX and
not necessarily something we want to carry over to other VM types.

There would also be performance implications (probably a non-issue in pract=
ice),
and weirdness if/when we get to sharing, linking and/or mmap()ing gmem.  E.=
g. what
should happen if the last memslot (binding) is deleted, but there outstandi=
ng userspace
mappings?

Option (c) is better from a lifecycle perspective, but it adds its own flav=
or of
complexity, e.g. the performant way to reclaim TDX memory requires the TDMR
(effectively the VM pointer), and so a deferred relcaim doesn't really work=
 for
TDX.  And I'm pretty sure it *can't* work for SNP, because RMP entries must=
 not
outlive the VM; KVM can't reuse an ASID if there are pages assigned to that=
 ASID
in the RMP, i.e. until all memory belonging to the VM has been fully freed.

> Could binding gmem files not on creation, but at memslot configuration
> time be sufficient and simpler?

After working through the flows, I think binding on-demand would simplify t=
he
refcounting (stating the obvious), but complicate the lifecycle of the memo=
ry as
well as the contract between KVM and userspace, and would break the separat=
ion of
concerns between the inode (physical memory / data) and file (VM's view / m=
appings).

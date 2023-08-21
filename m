Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75296782F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjHURaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjHURaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:30:12 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B510B
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 10:30:09 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bf60f85d78so31945955ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692639009; x=1693243809;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxPb6xmjGnrDhupKfwNZ6FElkwCeLY+o5DimQNV4hqs=;
        b=EeilR+Ekgkx+cSM5iMGGI6Y6JUlPzIKJDzTMUqkf7lLLOnc6FpewNmU25aBx4uml07
         kpJ/Y2FJC3CTbM1zhPEns2ri5EF0FucsNsARO2qiyP1aSTS0C5sBildhbwq/ouHiNd0i
         qimLz+UE3zMmYJlBAqicri/5Fr6eTbJDWgtrq6dGUFxvLf98ghheK+KjfPI1ki9rbrDx
         OwUj//jjlLo2noDnvWoDubwgN3vUsxvZ3ojvOIltLuZiZqNVPxwjvpAuB6SyalToGMao
         EwF+zqvM7lCbm29FshYcImlpUndLxfSZBxyjQ8MgJRIV/NshYNyfOiLuklOGwcxVfF2o
         7bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692639009; x=1693243809;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PxPb6xmjGnrDhupKfwNZ6FElkwCeLY+o5DimQNV4hqs=;
        b=NfzymweoBZEhll/EPS/PlJYldbQPxghA7bKqmrPEbBzNSIR01lrFdyVMmjuj5sxk41
         EYw/q1iIXvxerttLArAg0aRErJ3aov2Yxmkzw90i3PSGhGHIV0xw9kR09qRfwArhdtUe
         +FaQTHxHVPrOa2MHJAXlKL0JvyRNK6plUI1U65cfJ0dh9kQzh3ItUssBjs25rzu8tGOg
         cjxj4IqEEFxxcwgOk70DOtTHVi12kyA83kbjr+VLfOOifvBzVmOjFwmeyGXIzkbvhAJ8
         HndjvxN6hciod+8CljJQdsyZmi98mHRGfS+k+B/8Y/Efoyw1qcwb870ThvO51DN5rt3i
         32KA==
X-Gm-Message-State: AOJu0YylNEGOxD2TPrcNtrf+4XlBys2G2vsLM1OpSHHiVk1IdyGkd22a
        LphACGlJC+T1lH6MRWGn3M2Vwf85mYyj6SjFWQ==
X-Google-Smtp-Source: AGHT+IGoB8kJFRFmo//ezk9L60YAhs5f0Yw/TjMFB9a7nGOG7yPY7ezvdJVQyEjAsqVqDpDGeq6SzFD6orSBmlYJBQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:903:22cd:b0:1b8:9533:65b0 with
 SMTP id y13-20020a17090322cd00b001b8953365b0mr3304261plg.5.1692639009082;
 Mon, 21 Aug 2023 10:30:09 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:30:07 +0000
In-Reply-To: <ZNvaJ3igvcvTZ/8k@google.com> (message from Sean Christopherson
 on Tue, 15 Aug 2023 13:03:51 -0700)
Mime-Version: 1.0
Message-ID: <diqzzg2ktiao.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Aug 15, 2023, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> >> I feel that memslots form a natural way of managing usage of the gmem
>> >> file. When a memslot is created, it is using the file; hence we take =
a
>> >> refcount on the gmem file, and as memslots are removed, we drop
>> >> refcounts on the gmem file.
>> >
>> > Yes and no.  It's definitely more natural *if* the goal is to allow gu=
est_memfd
>> > memory to exist without being attached to a VM.  But I'm not at all co=
nvinced
>> > that we want to allow that, or that it has desirable properties.  With=
 TDX and
>> > SNP in particuarly, I'm pretty sure that allowing memory to outlive th=
e VM is
>> > very underisable (more below).
>> >
>>
>> This is a little confusing, with the file/inode split in gmem where the
>> physical memory/data is attached to the inode and the file represents
>> the VM's view of that memory, won't the memory outlive the VM?
>
> Doh, I overloaded the term "VM".  By "VM" I meant the virtual machine as =
a "thing"
> the rest of the world sees and interacts with, not the original "struct k=
vm" object.
>
> Because yes, you're absolutely correct that the memory will outlive "stru=
ct kvm",
> but it won't outlive the virtual machine, and specifically won't outlive =
the
> ASID (SNP) / HKID (TDX) to which it's bound.
>

Yup we agree on this now :) The memory should not outlive the the ASID
(SNP) / HKID (TDX) to which it's bound.

>> This [1] POC was built based on that premise, that the gmem inode can be
>> linked to another file and handed off to another VM, to facilitate
>> intra-host migration, where the point is to save the work of rebuilding
>> the VM's memory in the destination VM.
>>
>> With this, the bindings don't outlive the VM, but the data/memory
>> does. I think this split design you proposed is really nice.
>>
>> >> The KVM pointer is shared among all the bindings in gmem=E2=80=99s xa=
rray, and we can
>> >> enforce that a gmem file is used only with one VM:
>> >>
>> >> + When binding a memslot to the file, if a kvm pointer exists, it mus=
t
>> >>   be the same kvm as the one in this binding
>> >> + When the binding to the last memslot is removed from a file, NULL t=
he
>> >>   kvm pointer.
>> >
>> > Nullifying the KVM pointer isn't sufficient, because without additiona=
l actions
>> > userspace could extract data from a VM by deleting its memslots and th=
en binding
>> > the guest_memfd to an attacker controlled VM.  Or more likely with TDX=
 and SNP,
>> > induce badness by coercing KVM into mapping memory into a guest with t=
he wrong
>> > ASID/HKID.
>> >
>> > I can think of three ways to handle that:
>> >
>> >   (a) prevent a different VM from *ever* binding to the gmem instance
>> >   (b) free/zero physical pages when unbinding
>> >   (c) free/zero when binding to a different VM
>> >
>> > Option (a) is easy, but that pretty much defeats the purpose of decopu=
ling
>> > guest_memfd from a VM.
>> >
>> > Option (b) isn't hard to implement, but it screws up the lifecycle of =
the memory,
>> > e.g. would require memory when a memslot is deleted.  That isn't neces=
sarily a
>> > deal-breaker, but it runs counter to how KVM memlots currently operate=
.  Memslots
>> > are basically just weird page tables, e.g. deleting a memslot doesn't =
have any
>> > impact on the underlying data in memory.  TDX throws a wrench in this =
as removing
>> > a page from the Secure EPT is effectively destructive to the data (can=
't be mapped
>> > back in to the VM without zeroing the data), but IMO that's an oddity =
with TDX and
>> > not necessarily something we want to carry over to other VM types.
>> >
>> > There would also be performance implications (probably a non-issue in =
practice),
>> > and weirdness if/when we get to sharing, linking and/or mmap()ing gmem=
.  E.g. what
>> > should happen if the last memslot (binding) is deleted, but there outs=
tanding userspace
>> > mappings?
>> >
>> > Option (c) is better from a lifecycle perspective, but it adds its own=
 flavor of
>> > complexity, e.g. the performant way to reclaim TDX memory requires the=
 TDMR
>> > (effectively the VM pointer), and so a deferred relcaim doesn't really=
 work for
>> > TDX.  And I'm pretty sure it *can't* work for SNP, because RMP entries=
 must not
>> > outlive the VM; KVM can't reuse an ASID if there are pages assigned to=
 that ASID
>> > in the RMP, i.e. until all memory belonging to the VM has been fully f=
reed.
>> >
>>
>> If we are on the same page that the memory should outlive the VM but not
>> the bindings, then associating the gmem inode to a new VM should be a
>> feature and not a bug.
>>
>> What do we want to defend against here?
>>
>> (a) Malicious host VMM
>>
>> For a malicious host VMM to read guest memory (with TDX and SNP), it can
>> create a new VM with the same HKID/ASID as the victim VM, rebind the
>> gmem inode to a VM crafted with an image that dumps the memory.
>>
>> I believe it is not possible for userspace to arbitrarily select a
>> matching HKID unless userspace uses the intra-host migration ioctls, but=
 if the
>> migration ioctl is used, then EPTs are migrated and the memory dumper VM
>> can't successfully run a different image from the victim VM. If the
>> dumper VM needs to run the same image as the victim VM, then it would be
>> a successful migration rather than an attack. (Perhaps we need to clean
>> up some #MCs here but that can be a separate patch).
>
> From a guest security perspective, throw TDX and SNP out the window.  As =
far as
> the design of guest_memfd is concerned, I truly do not care what security=
 properties
> they provide, I only care about whether or not KVM's support for TDX and =
SNP is
> clean, robust, and functionally correct.
>
> Note, I'm not saying I don't care about TDX/SNP.  What I'm saying is that=
 I don't
> want to design something that is beneficial only to what is currently a v=
ery
> niche class of VMs that require specific flavors of hardware.
>
>> (b) Malicious host kernel
>>
>> A malicious host kernel can allow a malicious host VMM to re-use a HKID
>> for the dumper VM, but this isn't something a better gmem design can
>> defend against.
>
> Yep, completely out-of-scope.
>
>> (c) Attacks using gmem for software-protected VMs
>>
>> Attacks using gmem for software-protected VMs are possible since there
>> is no real encryption with HKID/ASID (yet?). The selftest for [1]
>> actually uses this lack of encryption to test that the destination VM
>> can read the source VM's memory after the migration. In the POC [1], as
>> long as both destination VM knows where in the inode's memory to read,
>> it can read what it wants to.
>
> Encryption is not required to protect guest memory from less privileged s=
oftware.
> The selftests don't rely on lack of encryption, they rely on KVM incorpor=
ating
> host userspace into the TCB.
>
> Just because this RFC doesn't remove the VMM from the TCB for SW-protecte=
d VMS,
> doesn't mean we _can't_ remove the VMM from the TCB.  pKVM has already sh=
own that
> such an implementation is possible.  We didn't tackle pKVM-like support i=
n the
> initial implementation because it's non-trivial, doesn't yet have a concr=
ete use
> case to fund/drive development, and would have significantly delayed supp=
ort for
> the use cases people do actually care about.
>
> There are certainly benefits from memory being encrypted, but it's neithe=
r a
> requirement nor a panacea, as proven by the never ending stream of specul=
ative
> execution attacks.
>
>> This is a problem for software-protected VMs, but I feel that it is also=
 a
>> separate issue from gmem's design.
>
> No, I don't want guest_memfd to be just be a vehicle for SNP/TDX VMs.  Ha=
ving line
> of sight to removing host userspace from the TCB is absolutely a must hav=
e for me,
> and having line of sight to improving KVM's security posture for "regular=
" VMs is
> even more of a must have.  If guest_memfd doesn't provide us a very direc=
t path to
> (eventually) achieving those goals, then IMO it's a failure.
>
> Which leads me to:
>
> (d) Buggy components
>
> Today, for all intents and purposes, guest memory *must* be mapped writab=
le in
> the VMM, which means it is all too easy for a benign-but-buggy host compo=
nent to
> corrupt guest memory.  There are ways to mitigate potential problems, e.g=
. by
> developing userspace to adhere to the principle of least privilege inasmu=
ch as
> possible, but such mitigations would be far less robust than what can be =
achieved
> via guest_memfd, and practically speaking I don't see us (Google, but als=
o KVM in
> general) making progress on deprivileging userspace without forcing the i=
ssue.
>

Thanks for adding this point! I should clarify that when I asked about
what we want to defend against, I meant that in response to the point
that nulling the KVM pointer is insufficient. IIUC (d) explains what the
whole of gmem is meant to defend against.

I agree with you that nulling the KVM pointer is insufficient to keep
host userspace out of the TCB. Among the three options (a) preventing a
different VM (HKID/ASID) from binding to the gmem instance, or zeroing
the memory either (b) on unbinding, or (c) on binding to another VM
(HKID/ASID),

(a) sounds like adding a check issued to TDX/SNP upon binding and this
    check would just return OK for software-protected VMs (line of sight
    to removing host userspace from TCB).

Or, we could go further for software-protected VMs and add tracking in
the inode to prevent the same inode from being bound to different
"HKID/ASID"s, perhaps like this:

+ On first binding, store the KVM pointer in the inode - not file (but
  not hold a refcount)
+ On rebinding, check that the KVM matches the pointer in the inode
+ On intra-host migration, update the KVM pointer in the inode to allow
  binding to the new struct kvm

I think you meant associating the file with a struct kvm at creation
time as an implementation for (a), but technically since the inode is
the representation of memory, tracking of struct kvm should be with the
inode instead of the file.

(b) You're right that this messes up the lifecycle of the memory and
    wouldn't work with intra-host migration.

(c) sounds like doing the clearing on a check similar to that of (a)

If we track struct kvm with the inode, then I think (a), (b) and (c) can
be independent of the refcounting method. What do you think?

>> >> Could binding gmem files not on creation, but at memslot configuratio=
n
>> >> time be sufficient and simpler?
>> >
>> > After working through the flows, I think binding on-demand would simpl=
ify the
>> > refcounting (stating the obvious), but complicate the lifecycle of the=
 memory as
>> > well as the contract between KVM and userspace,
>>
>> If we are on the same page that the memory should outlive the VM but not
>> the bindings, does it still complicate the lifecycle of the memory and
>> the userspace/KVM contract? Could it just be a different contract?
>
> Not entirely sure I understand what you're asking.  Does this question go=
 away
> with my clarification about struct kvm vs. virtual machine?
>

Yes, this question goes away. Thanks!

>> > and would break the separation of
>> > concerns between the inode (physical memory / data) and file (VM's vie=
w / mappings).
>>
>> Binding on-demand is orthogonal to the separation of concerns between
>> inode and file, because it can be built regardless of whether we do the
>> gmem file/inode split.
>>
>> + This flip-the-refcounting POC is built with the file/inode split and
>> + In [2] (the delayed binding approach to solve intra-host migration), I
>>   also tried flipping the refcounting, and that without the gmem
>>   file/inode split. (Refcounting in [2] is buggy because the file can't
>>   take a refcount on KVM, but it would work without taking that refcount=
)
>>
>> [1] https://lore.kernel.org/lkml/cover.1691446946.git.ackerleytng@google=
.com/T/
>> [2] https://github.com/googleprodkernel/linux-cc/commit/dd5ac5e53f14a1ef=
9915c9c1e4cc1006a40b49df

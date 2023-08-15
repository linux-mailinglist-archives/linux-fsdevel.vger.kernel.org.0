Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F177D21E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 20:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbjHOSn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 14:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbjHOSno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:43:44 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2610F4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 11:43:41 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-565ea69bb0cso641920a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692125021; x=1692729821;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSvYsD6+1EOsLwMbZUcg1SbKGoI2rKHIFLeuHZgRRx8=;
        b=3GbaBNZWweXPbCUfjNMBCMIO1/9pik3Ou7FeHEWzr8nKjSkzvqGcURow0A8T+s1N/W
         RVe6VK7Cczc0hkFYSPIsM+jZix/6+Avk/pXQMvDNFYcZzDKKROk6r/GnFpEmHHYj2KFW
         h93ooZKanquSe6AJs+58Zz6N7PTRsHyBuSQ388gemOe4SoUihxzHiPkARWazsr3ZZAz0
         OcYltDEsS3pdqe1uhroxEJVJrBI209UjBYz0S7Ir9y59ufYp5G/tA7HIMpi+zHCVIaVP
         g8K5m646ssrl0DCyD/aPBQgyLNjNw/h6F2pb8fxpumb9nBAkrhKWZXYmHJ6A2HGZPyrg
         dUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692125021; x=1692729821;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JSvYsD6+1EOsLwMbZUcg1SbKGoI2rKHIFLeuHZgRRx8=;
        b=APkD/SGpzPT8a1s76eRq21Ak6yo9bq8XcbkAiR55KDNiuOIGwQBAs16pkra9COwEvL
         Kvt8hSJohlhMgXkqbuC1Kxg+7lm+f6/bxBGJ+W5npK7WrzCFJjLGKxFm1j9WeX7TyPY0
         trGkExzOQK2i/8Q79cdW6ILTN+yj5qfxlr4bXLtEt6DVys29AKs8fEfmvXLmyCH0cKtI
         yW87VLjI8JqfBauQgC6A9uo9xIT0+q47YFdD1rGlYuTPgUQJYW4HPp0OHSiTGAW0u/qP
         fZ2V38uBuOMpqeYL9SDMUOZTvq9v5fK214Hpc7h5WUye7ZdW+VAsOI26cbgnVed/8+LY
         bgBg==
X-Gm-Message-State: AOJu0YzyGZkYyNXG9Y6tBmqr0WUjPZ0OTUGqGlQ4y89w2gY2BYhB+L6D
        yjx1bFn+rrAiMhLy/748D4hdHGHT7gYymTlplw==
X-Google-Smtp-Source: AGHT+IFNCwiTqbLEpaHtcY7JBuMDew3z5ESL3Ou2Kgu6Eu67p23Z+gfY19LxZRmFi4kbANuVSsG1veuDWoQmibZMwA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:903:645:b0:1b7:d4d2:c385 with SMTP
 id kh5-20020a170903064500b001b7d4d2c385mr4788682plb.1.1692125021245; Tue, 15
 Aug 2023 11:43:41 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:43:39 +0000
In-Reply-To: <ZNKv9ul2I7A4V7IF@google.com> (message from Sean Christopherson
 on Tue, 8 Aug 2023 14:13:26 -0700)
Mime-Version: 1.0
Message-ID: <diqzh6p02lk4.fsf@ackerleytng-ctop.c.googlers.com>
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

> On Mon, Aug 07, 2023, Ackerley Tng wrote:
>> I=E2=80=99d like to propose an alternative to the refcounting approach b=
etween
>> the gmem file and associated kvm, where we think of KVM=E2=80=99s memslo=
ts as
>> users of the gmem file.
>>
>> Instead of having the gmem file pin the VM (i.e. take a refcount on
>> kvm), we could let memslot take a refcount on the gmem file when the
>> memslots are configured.
>>
>> Here=E2=80=99s a POC patch that flips the refcounting (and modified self=
tests in
>> the next commit):
>> https://github.com/googleprodkernel/linux-cc/commit/7f487b029b89b9f3e9b0=
94a721bc0772f3c8c797
>>
>> One side effect of having the gmem file pin the VM is that now the gmem
>> file becomes sort of a false handle on the VM:
>>
>> + Closing the file destroys the file pointers in the VM and invalidates
>>   the pointers
>
> Yeah, this is less than ideal.  But, it's also how things operate today. =
 KVM
> doesn't hold references to VMAs or files, e.g. if userspace munmap()s mem=
ory,
> any and all SPTEs pointing at the memory are zapped.  The only difference=
 with
> gmem is that KVM needs to explicitly invalidate file pointers, instead of=
 that
> happening behind the scenes (no more VMAs to find).  Again, I agree the r=
esulting
> code is more complex than I would prefer, but from a userspace perspectiv=
e I
> don't see this as problematic.
>
>> + Keeping the file open keeps the VM around in the kernel even though
>>   the VM fd may already be closed.
>
> That is perfectly ok.  There is plenty of prior art, as well as plenty of=
 ways
> for userspace to shoot itself in the foot.  E.g. open a stats fd for a vC=
PU and
> the VM and all its vCPUs will be kept alive.  And conceptually it's sound=
,
> anything created in the scope of a VM _should_ pin the VM.
>

Thanks for explaining!

>> I feel that memslots form a natural way of managing usage of the gmem
>> file. When a memslot is created, it is using the file; hence we take a
>> refcount on the gmem file, and as memslots are removed, we drop
>> refcounts on the gmem file.
>
> Yes and no.  It's definitely more natural *if* the goal is to allow guest=
_memfd
> memory to exist without being attached to a VM.  But I'm not at all convi=
nced
> that we want to allow that, or that it has desirable properties.  With TD=
X and
> SNP in particuarly, I'm pretty sure that allowing memory to outlive the V=
M is
> very underisable (more below).
>

This is a little confusing, with the file/inode split in gmem where the
physical memory/data is attached to the inode and the file represents
the VM's view of that memory, won't the memory outlive the VM?

This [1] POC was built based on that premise, that the gmem inode can be
linked to another file and handed off to another VM, to facilitate
intra-host migration, where the point is to save the work of rebuilding
the VM's memory in the destination VM.

With this, the bindings don't outlive the VM, but the data/memory
does. I think this split design you proposed is really nice.

>> The KVM pointer is shared among all the bindings in gmem=E2=80=99s xarra=
y, and we can
>> enforce that a gmem file is used only with one VM:
>>
>> + When binding a memslot to the file, if a kvm pointer exists, it must
>>   be the same kvm as the one in this binding
>> + When the binding to the last memslot is removed from a file, NULL the
>>   kvm pointer.
>
> Nullifying the KVM pointer isn't sufficient, because without additional a=
ctions
> userspace could extract data from a VM by deleting its memslots and then =
binding
> the guest_memfd to an attacker controlled VM.  Or more likely with TDX an=
d SNP,
> induce badness by coercing KVM into mapping memory into a guest with the =
wrong
> ASID/HKID.
>
> I can think of three ways to handle that:
>
>   (a) prevent a different VM from *ever* binding to the gmem instance
>   (b) free/zero physical pages when unbinding
>   (c) free/zero when binding to a different VM
>
> Option (a) is easy, but that pretty much defeats the purpose of decopulin=
g
> guest_memfd from a VM.
>
> Option (b) isn't hard to implement, but it screws up the lifecycle of the=
 memory,
> e.g. would require memory when a memslot is deleted.  That isn't necessar=
ily a
> deal-breaker, but it runs counter to how KVM memlots currently operate.  =
Memslots
> are basically just weird page tables, e.g. deleting a memslot doesn't hav=
e any
> impact on the underlying data in memory.  TDX throws a wrench in this as =
removing
> a page from the Secure EPT is effectively destructive to the data (can't =
be mapped
> back in to the VM without zeroing the data), but IMO that's an oddity wit=
h TDX and
> not necessarily something we want to carry over to other VM types.
>
> There would also be performance implications (probably a non-issue in pra=
ctice),
> and weirdness if/when we get to sharing, linking and/or mmap()ing gmem.  =
E.g. what
> should happen if the last memslot (binding) is deleted, but there outstan=
ding userspace
> mappings?
>
> Option (c) is better from a lifecycle perspective, but it adds its own fl=
avor of
> complexity, e.g. the performant way to reclaim TDX memory requires the TD=
MR
> (effectively the VM pointer), and so a deferred relcaim doesn't really wo=
rk for
> TDX.  And I'm pretty sure it *can't* work for SNP, because RMP entries mu=
st not
> outlive the VM; KVM can't reuse an ASID if there are pages assigned to th=
at ASID
> in the RMP, i.e. until all memory belonging to the VM has been fully free=
d.
>

If we are on the same page that the memory should outlive the VM but not
the bindings, then associating the gmem inode to a new VM should be a
feature and not a bug.

What do we want to defend against here?

(a) Malicious host VMM

For a malicious host VMM to read guest memory (with TDX and SNP), it can
create a new VM with the same HKID/ASID as the victim VM, rebind the
gmem inode to a VM crafted with an image that dumps the memory.

I believe it is not possible for userspace to arbitrarily select a
matching HKID unless userspace uses the intra-host migration ioctls, but if=
 the
migration ioctl is used, then EPTs are migrated and the memory dumper VM
can't successfully run a different image from the victim VM. If the
dumper VM needs to run the same image as the victim VM, then it would be
a successful migration rather than an attack. (Perhaps we need to clean
up some #MCs here but that can be a separate patch)

(b) Malicious host kernel

A malicious host kernel can allow a malicious host VMM to re-use a HKID
for the dumper VM, but this isn't something a better gmem design can
defend against.

(c) Attacks using gmem for software-protected VMs

Attacks using gmem for software-protected VMs are possible since there
is no real encryption with HKID/ASID (yet?). The selftest for [1]
actually uses this lack of encryption to test that the destination VM
can read the source VM's memory after the migration. In the POC [1], as
long as both destination VM knows where in the inode's memory to read,
it can read what it wants to. This is a problem for software-protected
VMs, but I feel that it is also a separate issue from gmem's design.

>> Could binding gmem files not on creation, but at memslot configuration
>> time be sufficient and simpler?
>
> After working through the flows, I think binding on-demand would simplify=
 the
> refcounting (stating the obvious), but complicate the lifecycle of the me=
mory as
> well as the contract between KVM and userspace,

If we are on the same page that the memory should outlive the VM but not
the bindings, does it still complicate the lifecycle of the memory and
the userspace/KVM contract? Could it just be a different contract?

> and would break the separation of
> concerns between the inode (physical memory / data) and file (VM's view /=
 mappings).

Binding on-demand is orthogonal to the separation of concerns between
inode and file, because it can be built regardless of whether we do the
gmem file/inode split.

+ This flip-the-refcounting POC is built with the file/inode split and
+ In [2] (the delayed binding approach to solve intra-host migration), I
  also tried flipping the refcounting, and that without the gmem
  file/inode split. (Refcounting in [2] is buggy because the file can't
  take a refcount on KVM, but it would work without taking that refcount)

[1] https://lore.kernel.org/lkml/cover.1691446946.git.ackerleytng@google.co=
m/T/
[2] https://github.com/googleprodkernel/linux-cc/commit/dd5ac5e53f14a1ef991=
5c9c1e4cc1006a40b49df

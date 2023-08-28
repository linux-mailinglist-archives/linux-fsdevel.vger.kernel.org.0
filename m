Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC4178BB3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 00:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjH1W4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 18:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjH1W4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:56:18 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AA513E
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 15:56:14 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5702003a908so806497a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693263374; x=1693868174;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=45FPDFU2bi5QNrTegRTZSI4D/kTsLJ5aPvVquLb6Kb4=;
        b=pLOLnQlAccDWO/O5kVLkKwA9wRVSEEkjq7uLC+mlmD7Vfw3vEYXCkgTxxXccxGMWgZ
         wRGNqorlmNPayZTm3R+GqSyo7GngRdVoeiMDanQ2qTLDbFHAwVr7soK6dbWp8LVur1IJ
         7Dj7NDy10jedqv9lpI8G9Si/rF4w8XfNDjmoH8zHrZK+nE/CztRtHvsfpP2cZBuR/WSb
         r1GFzm2yEAVnnjHec8JxS7mw13lbH162cn2tJ8OGbc1nr9IEbWJ5p7u+QgsCm1qR34DM
         OtkAkqUjCP9VneeTOmcCYfI7wZJzfHg/Vici91Fsjq4cCd2IzQiQr/mxwrVo3egZBd6/
         M4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263374; x=1693868174;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45FPDFU2bi5QNrTegRTZSI4D/kTsLJ5aPvVquLb6Kb4=;
        b=dd3oegWLlz51QvzgstQ5PB5kGXR3LjuBWL97vjT7W5b0mYX5rbReNWARJAC7F+L/4Z
         6VOXgV9lzb5f9uZLUgKPcQmDZrhRc5zlWP8loM+Zoz1p52XGrmBxMBo922uJLl7/oxKq
         Nrd9LWEohDgw6BsNGkx4rBLlQy/MhrDff9dsKVAiLhLONWxL/uQTY0lcjKmQVwmGyUF3
         dk4cRW7eOeMGlyupDqHm5VqswoTRCMrYp8QcNMCqGAVnuqZV2toKHGrCG4gn/5C5qT3W
         A5VtWHiqNs0DX5bMuR0p4Qxt0DEAyNR9sR3/nFHlvbgMoz/K4rOhsaTidS9ZUdhtwItD
         IYNw==
X-Gm-Message-State: AOJu0YxA764cpV1Rj0NJUbs4iRTX4JJ8B6WEKivk0crU1GHifNXThnWH
        phGm7Uyd3OKEcq86ywO7zls6EcTKMVTSGUwe2w==
X-Google-Smtp-Source: AGHT+IHiRfp4dtsSrmAF/uBzjUu2XQ3xTysjq4Ohm5oUAXB2N+6Zi644lMyKLSW9uEB1MtUrJ1+LGs2ibik7KIYLPQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:8f09:0:b0:566:2d6:f71b with SMTP
 id n9-20020a638f09000000b0056602d6f71bmr5097167pgd.12.1693263374002; Mon, 28
 Aug 2023 15:56:14 -0700 (PDT)
Date:   Mon, 28 Aug 2023 22:56:12 +0000
In-Reply-To: <ZOO782YGRY0YMuPu@google.com> (message from Sean Christopherson
 on Mon, 21 Aug 2023 12:33:07 -0700)
Mime-Version: 1.0
Message-ID: <diqzttsiu67n.fsf@ackerleytng-ctop.c.googlers.com>
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
Content-Type: text/plain; charset="UTF-8"
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

> On Mon, Aug 21, 2023, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > On Tue, Aug 15, 2023, Ackerley Tng wrote:
>> >> Sean Christopherson <seanjc@google.com> writes:
>> >> > Nullifying the KVM pointer isn't sufficient, because without additional actions
>> >> > userspace could extract data from a VM by deleting its memslots and then binding
>> >> > the guest_memfd to an attacker controlled VM.  Or more likely with TDX and SNP,
>> >> > induce badness by coercing KVM into mapping memory into a guest with the wrong
>> >> > ASID/HKID.
>> >> >
>> >> > I can think of three ways to handle that:
>> >> >
>> >> >   (a) prevent a different VM from *ever* binding to the gmem instance
>> >> >   (b) free/zero physical pages when unbinding
>> >> >   (c) free/zero when binding to a different VM
>> >> >
>> >> > Option (a) is easy, but that pretty much defeats the purpose of decopuling
>> >> > guest_memfd from a VM.
>> >> >
>> >> > Option (b) isn't hard to implement, but it screws up the lifecycle of the memory,
>> >> > e.g. would require memory when a memslot is deleted.  That isn't necessarily a
>> >> > deal-breaker, but it runs counter to how KVM memlots currently operate.  Memslots
>> >> > are basically just weird page tables, e.g. deleting a memslot doesn't have any
>> >> > impact on the underlying data in memory.  TDX throws a wrench in this as removing
>> >> > a page from the Secure EPT is effectively destructive to the data (can't be mapped
>> >> > back in to the VM without zeroing the data), but IMO that's an oddity with TDX and
>> >> > not necessarily something we want to carry over to other VM types.
>> >> >
>> >> > There would also be performance implications (probably a non-issue in practice),
>> >> > and weirdness if/when we get to sharing, linking and/or mmap()ing gmem.  E.g. what
>> >> > should happen if the last memslot (binding) is deleted, but there outstanding userspace
>> >> > mappings?
>> >> >
>> >> > Option (c) is better from a lifecycle perspective, but it adds its own flavor of
>> >> > complexity, e.g. the performant way to reclaim TDX memory requires the TDMR
>> >> > (effectively the VM pointer), and so a deferred relcaim doesn't really work for
>> >> > TDX.  And I'm pretty sure it *can't* work for SNP, because RMP entries must not
>> >> > outlive the VM; KVM can't reuse an ASID if there are pages assigned to that ASID
>> >> > in the RMP, i.e. until all memory belonging to the VM has been fully freed.
>
> ...
>
>> I agree with you that nulling the KVM pointer is insufficient to keep
>> host userspace out of the TCB. Among the three options (a) preventing a
>> different VM (HKID/ASID) from binding to the gmem instance, or zeroing
>> the memory either (b) on unbinding, or (c) on binding to another VM
>> (HKID/ASID),
>>
>> (a) sounds like adding a check issued to TDX/SNP upon binding and this
>>     check would just return OK for software-protected VMs (line of sight
>>     to removing host userspace from TCB).
>>
>> Or, we could go further for software-protected VMs and add tracking in
>> the inode to prevent the same inode from being bound to different
>> "HKID/ASID"s, perhaps like this:
>>
>> + On first binding, store the KVM pointer in the inode - not file (but
>>   not hold a refcount)
>> + On rebinding, check that the KVM matches the pointer in the inode
>> + On intra-host migration, update the KVM pointer in the inode to allow
>>   binding to the new struct kvm
>>
>> I think you meant associating the file with a struct kvm at creation
>> time as an implementation for (a), but technically since the inode is
>> the representation of memory, tracking of struct kvm should be with the
>> inode instead of the file.
>>
>> (b) You're right that this messes up the lifecycle of the memory and
>>     wouldn't work with intra-host migration.
>>
>> (c) sounds like doing the clearing on a check similar to that of (a)
>
> Sort of, though it's much nastier, because it requires the "old" KVM instance to
> be alive enough to support various operations.  I.e. we'd have to make stronger
> guarantees about exactly when the handoff/transition could happen.
>

Good point!

>> If we track struct kvm with the inode, then I think (a), (b) and (c) can
>> be independent of the refcounting method. What do you think?
>
> No go.  Because again, the inode (physical memory) is coupled to the virtual machine
> as a thing, not to a "struct kvm".  Or more concretely, the inode is coupled to an
> ASID or an HKID, and there can be multiple "struct kvm" objects associated with a
> single ASID.  And at some point in the future, I suspect we'll have multiple KVM
> objects per HKID too.
>
> The current SEV use case is for the migration helper, where two KVM objects share
> a single ASID (the "real" VM and the helper).  I suspect TDX will end up with
> similar behavior where helper "VMs" can use the HKID of the "real" VM.  For KVM,
> that means multiple struct kvm objects being associated with a single HKID.
>
> To prevent use-after-free, KVM "just" needs to ensure the helper instances can't
> outlive the real instance, i.e. can't use the HKID/ASID after the owning virtual
> machine has been destroyed.
>
> To put it differently, "struct kvm" is a KVM software construct that _usually_,
> but not always, is associated 1:1 with a virtual machine.
>
> And FWIW, stashing the pointer without holding a reference would not be a complete
> solution, because it couldn't guard against KVM reusing a pointer.  E.g. if a
> struct kvm was unbound and then freed, KVM could reuse the same memory for a new
> struct kvm, with a different ASID/HKID, and get a false negative on the rebinding
> check.

I agree that inode (physical memory) is coupled to the virtual machine
as a more generic concept.

I was hoping that in the absence of CC hardware providing a HKID/ASID,
the struct kvm pointer could act as a representation of the "virtual
machine". You're definitely right that KVM could reuse a pointer and so
that idea doesn't stand.

I thought about generating UUIDs to represent "virtual machines" in the
absence of CC hardware, and this UUID could be transferred during
intra-host migration, but this still doesn't take host userspace out of
the TCB. A malicious host VMM could just use the migration ioctl to copy
the UUID to a malicious dumper VM, which would then pass checks with a
gmem file linked to the malicious dumper VM. This is fine for HKID/ASIDs
because the memory is encrypted; with UUIDs there's no memory
encryption.

Circling back to the original topic, was associating the file with
struct kvm at gmem file creation time meant to constrain the use of the
gmem file to one struct kvm, or one virtual machine, or something else?

Follow up questions:

1. Since the physical memory's representation is the inode and should be
   coupled to the virtual machine (as a concept, not struct kvm), should
   the binding/coupling be with the file, or the inode?

2. Should struct kvm still be bound to the file/inode at gmem file
   creation time, since

   + struct kvm isn't a good representation of a "virtual machine"
   + we currently don't have anything that really represents a "virtual
     machine" without hardware support


I'd also like to bring up another userspace use case that Google has:
re-use of gmem files for rebooting guests when the KVM instance is
destroyed and rebuilt.

When rebooting a VM there are some steps relating to gmem that are
performance-sensitive:

a.      Zeroing pages from the old VM when we close a gmem file/inode
b. Deallocating pages from the old VM when we close a gmem file/inode
c.   Allocating pages for the new VM from the new gmem file/inode
d.      Zeroing pages on page allocation

We want to reuse the gmem file to save re-allocating pages (b. and c.),
and one of the two page zeroing allocations (a. or d.).

Binding the gmem file to a struct kvm on creation time means the gmem
file can't be reused with another VM on reboot. Also, host userspace is
forced to close the gmem file to allow the old VM to be freed.

For other places where files pin KVM, like the stats fd pinning vCPUs, I
guess that matters less since there isn't much of a penalty to close and
re-open the stats fd.

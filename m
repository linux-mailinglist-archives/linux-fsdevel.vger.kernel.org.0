Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1464EBD09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 10:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbiC3JAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 05:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbiC3JAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:00:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E79460F9;
        Wed, 30 Mar 2022 01:58:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A60ED23A;
        Wed, 30 Mar 2022 01:58:32 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C9EC3F66F;
        Wed, 30 Mar 2022 01:58:28 -0700 (PDT)
Message-ID: <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
Date:   Wed, 30 Mar 2022 09:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-GB
To:     Quentin Perret <qperret@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, maz@kernel.org,
        will@kernel.org
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <YjyS6A0o4JASQK+B@google.com> <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com> <YkIFW25WgV2WIQHb@google.com>
 <YkM7eHCHEBe5NkNH@google.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <YkM7eHCHEBe5NkNH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/03/2022 18:01, Quentin Perret wrote:
> On Monday 28 Mar 2022 at 18:58:35 (+0000), Sean Christopherson wrote:
>> On Mon, Mar 28, 2022, Quentin Perret wrote:
>>> Hi Sean,
>>>
>>> Thanks for the reply, this helps a lot.
>>>
>>> On Monday 28 Mar 2022 at 17:13:10 (+0000), Sean Christopherson wrote:
>>>> On Thu, Mar 24, 2022, Quentin Perret wrote:
>>>>> For Protected KVM (and I suspect most other confidential computing
>>>>> solutions), guests have the ability to share some of their pages back
>>>>> with the host kernel using a dedicated hypercall. This is necessary
>>>>> for e.g. virtio communications, so these shared pages need to be mapped
>>>>> back into the VMM's address space. I'm a bit confused about how that
>>>>> would work with the approach proposed here. What is going to be the
>>>>> approach for TDX?
>>>>>
>>>>> It feels like the most 'natural' thing would be to have a KVM exit
>>>>> reason describing which pages have been shared back by the guest, and to
>>>>> then allow the VMM to mmap those specific pages in response in the
>>>>> memfd. Is this something that has been discussed or considered?
>>>>
>>>> The proposed solution is to exit to userspace with a new exit reason, KVM_EXIT_MEMORY_ERROR,
>>>> when the guest makes the hypercall to request conversion[1].  The private fd itself
>>>> will never allow mapping memory into userspace, instead userspace will need to punch
>>>> a hole in the private fd backing store.  The absense of a valid mapping in the private
>>>> fd is how KVM detects that a pfn is "shared" (memslots without a private fd are always
>>>> shared)[2].
>>>
>>> Right. I'm still a bit confused about how the VMM is going to get the
>>> shared page mapped in its page-table. Once it has punched a hole into
>>> the private fd, how is it supposed to access the actual physical page
>>> that the guest shared?
>>
>> The guest doesn't share a _host_ physical page, the guest shares a _guest_ physical
>> page.  Until host userspace converts the gfn to shared and thus maps the gfn=>hva
>> via mmap(), the guest is blocked and can't read/write/exec the memory.  AFAIK, no
>> architecture allows in-place decryption of guest private memory.  s390 allows a
>> page to be "made accessible" to the host for the purposes of swap, and other
>> architectures will have similar behavior for migrating a protected VM, but those
>> scenarios are not sharing the page (and they also make the page inaccessible to
>> the guest).
> 
> I see. FWIW, since pKVM is entirely MMU-based, we are in fact capable of
> doing in-place sharing, which also means it can retain the content of
> the page as part of the conversion.
> 
> Also, I'll ask the Arm CCA developers to correct me if this is wrong, but
> I _believe_ it should be technically possible to do in-place sharing for
> them too.

In general this isn't possible as the physical memory could be
encrypted, so some temporary memory is required. We have prototyped
having a single temporary page for the setup when populating the guest's
initial memory - this has the nice property of not requiring any
additional allocation during the process but with the downside of
effectively two memcpy()s per page (one to the temporary page and
another, with optional encryption, into the now private page).

>>> Is there an assumption somewhere that the VMM should have this page mapped in
>>> via an alias that it can legally access only once it has punched a hole at
>>> the corresponding offset in the private fd or something along those lines?
>>
>> Yes, the VMM must have a completely separate VMA.  The VMM doesn't haven't to
>> wait until the conversion to mmap() the shared variant, though obviously it will
>> potentially consume double the memory if the VMM actually populates both the
>> private and shared backing stores.
> 
> Gotcha. This is what confused me I think -- in this approach private and
> shared pages are in fact entirely different.
> 
> In which scenario could you end up with both the private and shared
> pages live at the same time? Would this be something like follows?
> 
>  - userspace creates a private fd, fallocates into it, and associates
>    the <fd, offset, size> tuple with a private memslot;
> 
>  - userspace then mmaps anonymous memory (for ex.), and associates it
>    with a standard memslot, which happens to be positioned at exactly
>    the right offset w.r.t to the private memslot (with this offset
>    defined by the bit that is set for the private addresses in the gpa
>    space);
> 
>  - the guest runs, and accesses both 'aliases' of the page without doing
>    an explicit share hypercall.
> 
> Is there another option?

AIUI you can have both private and shared "live" at the same time. But
you can have a page allocated both in the private fd and in the same
location in the (shared) memslot in the VMM's memory map. In this
situation the private fd page effectively hides the shared page.

> Is implicit sharing a thing? E.g., if a guest makes a memory access in
> the shared gpa range at an address that doesn't have a backing memslot,
> will KVM check whether there is a corresponding private memslot at the
> right offset with a hole punched and report a KVM_EXIT_MEMORY_ERROR? Or
> would that just generate an MMIO exit as usual?

My understanding is that the guest needs some way of tagging whether a
page is expected to be shared or private. On the architectures I'm aware
of this is done by effectively stealing a bit from the IPA space and
pretending it's a flag bit.

So when a guest access causes a fault, the flag bit (really part of the
intermediate physical address) is compared against whether the page is
present in the private fd. If they correspond (i.e. a private access and
the private fd has a page, or a shared access and there's a hole in the
private fd) then the appropriate page is mapped and the guest continues.
If there's a mismatch then a KVM_EXIT_MEMORY_ERROR exit is trigged and
the VMM is expected to fix up the situation (either convert the page or
kill the guest if this was unexpected).

>>>> The key point is that KVM never decides to convert between shared and private, it's
>>>> always a userspace decision.  Like normal memslots, where userspace has full control
>>>> over what gfns are a valid, this gives userspace full control over whether a gfn is
>>>> shared or private at any given time.
>>>
>>> I'm understanding this as 'the VMM is allowed to punch holes in the
>>> private fd whenever it wants'. Is this correct?
>>
>> From the kernel's perspective, yes, the VMM can punch holes at any time.  From a
>> "do I want to DoS my guest" perspective, the VMM must honor its contract with the
>> guest and not spuriously unmap private memory.
>>
>>> What happens if it does so for a page that a guest hasn't shared back?
>>
>> When the hole is punched, KVM will unmap the corresponding private SPTEs.  If the
>> guest is still accessing the page as private, the next access will fault and KVM
>> will exit to userspace with KVM_EXIT_MEMORY_ERROR.  Of course the guest is probably
>> hosed if the hole punch was truly spurious, as at least hardware-based protected VMs
>> effectively destroy data when a private page is unmapped from the guest private SPTEs.
>>
>> E.g. Linux guests for TDX and SNP will panic/terminate in such a scenario as they
>> will get a fault (injected by trusted hardware/firmware) saying that the guest is
>> trying to access an unaccepted/unvalidated page (TDX and SNP require the guest to
>> explicit accept all private pages that aren't part of the guest's initial pre-boot
>> image).
> 
> I suppose this is necessary is to prevent the VMM from re-fallocating
> in a hole it previously punched and re-entering the guest without
> notifying it?

I don't know specifically about TDX/SNP, but one thing we want to
prevent with CCA is the VMM deallocating/reallocating a private page
without the guest being aware (i.e. corrupting the guest's state). So
punching a hole will taint the address such that a future access by the
guest is fatal (unless the guest first jumps through the right hoops to
acknowledge that it was expecting such a thing).

>>>> Another important detail is that this approach means the kernel and KVM treat the
>>>> shared backing store and private backing store as independent, albeit related,
>>>> entities.  This is very deliberate as it makes it easier to reason about what is
>>>> and isn't allowed/required.  E.g. the kernel only needs to handle freeing private
>>>> memory, there is no special handling for conversion to shared because no such path
>>>> exists as far as host pfns are concerned.  And userspace doesn't need any new "rules"
>>>> for protecting itself against a malicious guest, e.g. userspace already needs to
>>>> ensure that it has a valid mapping prior to accessing guest memory (or be able to
>>>> handle any resulting signals).  A malicious guest can DoS itself by instructing
>>>> userspace to communicate over memory that is currently mapped private, but there
>>>> are no new novel attack vectors from the host's perspective as coercing the host
>>>> into accessing an invalid mapping after shared=>private conversion is just a variant
>>>> of a use-after-free.
>>>
>>> Interesting. I was (maybe incorrectly) assuming that it would be
>>> difficult to handle illegal host accesses w/ TDX. IOW, this would
>>> essentially crash the host. Is this remotely correct or did I get that
>>> wrong?
>>
>> Handling illegal host kernel accesses for both TDX and SEV-SNP is extremely
>> difficult, bordering on impossible.  That's one of the biggest, if not _the_
>> biggest, motivations for the private fd approach.  On "conversion", the page that is
>> used to back the shared variant is a completely different, unrelated host physical
>> page.  Whether or not the private/shared backing page is freed is orthogonal to
>> what version is mapped into the guest.  E.g. if the guest converts a 4kb chunk of
>> a 2mb hugepage, the private backing store could keep the physical page on hole
>> punch (example only, I don't know if this is the actual proposed implementation).
>>
>> The idea is that it'll be much, much more difficult for the host to perform an
>> illegal access if the actual private memory is not mapped anywhere (modulo the
>> kernel's direct map, which we may or may not leave intact).  The private backing
>> store just needs to ensure it properly sanitizing pages before freeing them.
> 
> Understood.
> 
> I'm overall inclined to think that while this abstraction works nicely
> for TDX and the likes, it might not suit pKVM all that well in the
> current form, but it's close.
> 
> What do you think of extending the model proposed here to also address
> the needs of implementations that support in-place sharing? One option
> would be to have KVM notify the private-fd backing store when a page is
> shared back by a guest, which would then allow host userspace to mmap
> that particular page in the private fd instead of punching a hole.
> 
> This should retain the main property you're after: private pages that
> are actually mapped in the guest SPTE aren't mmap-able, but all the
> others are fair game.
> 
> Thoughts?

How do you propose this works if the page shared by the guest then needs
to be made private again? If there's no hole punched then it's not
possible to just repopulate the private-fd. I'm struggling to see how
that could work. Having said that; if we can work out a way to safely
mmap() pages from the private-fd there's definitely some benefits to be
had - e.g. it could be used to populate the initial memory before the
guest is started.

Steve

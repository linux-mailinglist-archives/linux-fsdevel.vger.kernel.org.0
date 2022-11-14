Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB47D6281E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 15:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiKNOCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 09:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiKNOCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:02:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FEA2AC7F;
        Mon, 14 Nov 2022 06:02:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9CA5722B02;
        Mon, 14 Nov 2022 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668434558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mayE7Lg0BQ8hDkq+3cJ1RU+23EhKOBsT9P5RmwpQqZg=;
        b=CRVfTYw9S79rQb/maxbJb5Rb+xGiQrI/zNIQUn8hti/eA+HHOydrfJXOCPvacAZvtp+qfG
        NyUu7a0lynHJoULvD0Ym4rGHZQ8ntVqyIgSyza22+c5pXt6yBQC3quckfvjk+eCJo2n6CU
        DJTqPmMf+ZSOKq19iXMVwvt3TIeiv7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668434558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mayE7Lg0BQ8hDkq+3cJ1RU+23EhKOBsT9P5RmwpQqZg=;
        b=edS4ElukmcUiY4HgCNAWi+BGiMSz4zN4KxQqC3YhbOyfv7rJQWyINb0mhFlFH83SBx0dEJ
        qVX43crJKTJVDaBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02E9A13A92;
        Mon, 14 Nov 2022 14:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q2I1AH5KcmM7XQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 14 Nov 2022 14:02:38 +0000
Message-ID: <20a11042-2cfb-8f42-9d80-6672e155ca2c@suse.cz>
Date:   Mon, 14 Nov 2022 15:02:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        mhocko@suse.com, Muchun Song <songmuchun@bytedance.com>,
        wei.w.wang@intel.com
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221101113729.GA4015495@chaop.bj.intel.com>
 <20221101151944.rhpav47pdulsew7l@amd.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221101151944.rhpav47pdulsew7l@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/1/22 16:19, Michael Roth wrote:
> On Tue, Nov 01, 2022 at 07:37:29PM +0800, Chao Peng wrote:
>> > 
>> >   1) restoring kernel directmap:
>> > 
>> >      Currently SNP (and I believe TDX) need to either split or remove kernel
>> >      direct mappings for restricted PFNs, since there is no guarantee that
>> >      other PFNs within a 2MB range won't be used for non-restricted
>> >      (which will cause an RMP #PF in the case of SNP since the 2MB
>> >      mapping overlaps with guest-owned pages)
>> 
>> Has the splitting and restoring been a well-discussed direction? I'm
>> just curious whether there is other options to solve this issue.
> 
> For SNP it's been discussed for quite some time, and either splitting or
> removing private entries from directmap are the well-discussed way I'm
> aware of to avoid RMP violations due to some other kernel process using
> a 2MB mapping to access shared memory if there are private pages that
> happen to be within that range.
> 
> In both cases the issue of how to restore directmap as 2M becomes a
> problem.
> 
> I was also under the impression TDX had similar requirements. If so,
> do you know what the plan is for handling this for TDX?
> 
> There are also 2 potential alternatives I'm aware of, but these haven't
> been discussed in much detail AFAIK:
> 
> a) Ensure confidential guests are backed by 2MB pages. shmem has a way to
>    request 2MB THP pages, but I'm not sure how reliably we can guarantee
>    that enough THPs are available, so if we went that route we'd probably
>    be better off requiring the use of hugetlbfs as the backing store. But
>    obviously that's a bit limiting and it would be nice to have the option
>    of using normal pages as well. One nice thing with invalidation
>    scheme proposed here is that this would "Just Work" if implement
>    hugetlbfs support, so an admin that doesn't want any directmap
>    splitting has this option available, otherwise it's done as a
>    best-effort.
> 
> b) Implement general support for restoring directmap as 2M even when
>    subpages might be in use by other kernel threads. This would be the
>    most flexible approach since it requires no special handling during
>    invalidations, but I think it's only possible if all the CPA
>    attributes for the 2M range are the same at the time the mapping is
>    restored/unsplit, so some potential locking issues there and still
>    chance for splitting directmap over time.

I've been hoping that

c) using a mechanism such as [1] [2] where the goal is to group together
these small allocations that need to increase directmap granularity so
maximum number of large mappings are preserved. But I guess that means
knowing at allocation time that this will happen. So I've been wondering how
this would be possible to employ in the SNP/UPM case? I guess it depends on
how we expect the private/shared conversions to happen in practice, and I
don't know the details. I can imagine the following complications:

- a memfd_restricted region is created such that it's 2MB large/aligned,
i.e. like case a) above, we can allocate it normally. Now, what if a 4k page
in the middle is to be temporarily converted to shared for some
communication between host and guest (can such thing happen?). With the
punch hole approach, I wonder if we end up fragmenting directmap
unnecessarily? IIUC the now shared page will become backed by some other
page (as the memslot supports both private and shared pages simultaneously).
But does it make sense to really split the direct mapping (and e.g. the
shmem page?) We could leave the whole 2MB unmapped without splitting if we
didn't free the private 4k subpage.

- a restricted region is created that's below 2MB. If something like [1] is
merged, it could be used for the backing pages to limit directmap
fragmentation. But then in case it's eventually fallocated to become larger
and gain one more more 2MB aligned ranges, the result is suboptimal. Unless
in that case we migrate the existing pages to a THP-backed shmem, kinda like
khugepaged collapses hugepages. But that would have to be coordinated with
the guest, maybe not even possible?

[1] https://lore.kernel.org/all/20220127085608.306306-1-rppt@kernel.org/
[2] https://lwn.net/Articles/894557/

>> 
>> > 
>> >      Previously we were able to restore 2MB mappings to some degree
>> >      since both shared/restricted pages were all pinned, so anything
>> >      backed by a THP (or hugetlb page once that is implemented) at guest
>> >      teardown could be restored as 2MB direct mapping.
>> > 
>> >      Invalidation seems like the most logical time to have this happen,
>> 
>> Currently invalidation only happens at user-initiated fallocate(). It
>> does not cover the VM teardown case where the restoring might also be
>> expected to be handled.
> 
> Right, I forgot to add that in my proposed changes I added invalidations
> for any still-allocated private pages present when the restricted memfd
> notifier is unregistered. This was needed to avoid leaking pages back to
> the kernel that still need directmap or RMP table fixups. I also added
> similar invalidations for memfd->release(), since it seems possible that
> userspace might close() it before shutting down guest, but maybe the
> latter is not needed if KVM takes a reference on the FD during life of
> the guest.
> 
>> 
>> >      but whether or not to restore as 2MB requires the order to be 2MB
>> >      or larger, and for GPA range being invalidated to cover the entire
>> >      2MB (otherwise it means the page was potentially split and some
>> >      subpages free back to host already, in which case it can't be
>> >      restored as 2MB).
>> > 
>> >   2) Potentially less invalidations:
>> >       
>> >      If we pass the entire folio or compound_page as part of
>> >      invalidation, we only needed to issue 1 invalidation per folio.
>> 
>> I'm not sure I agree, the current invalidation covers the whole range
>> that passed from userspace and the invalidation is invoked only once for
>> each usrspace fallocate().
> 
> That's true, it only reduces invalidations if we decide to provide a
> struct page/folio as part of the invalidation callbacks, which isn't
> the case yet. Sorry for the confusion.
> 
>> 
>> > 
>> >   3) Potentially useful for hugetlbfs support:
>> > 
>> >      One issue with hugetlbfs is that we don't support splitting the
>> >      hugepage in such cases, which was a big obstacle prior to UPM. Now
>> >      however, we may have the option of doing "lazy" invalidations where
>> >      fallocate(PUNCH_HOLE, ...) won't free a shmem-allocate page unless
>> >      all the subpages within the 2M range are either hole-punched, or the
>> >      guest is shut down, so in that way we never have to split it. Sean
>> >      was pondering something similar in another thread:
>> > 
>> >        https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-mm%2FYyGLXXkFCmxBfu5U%40google.com%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C3aba56bf7d574c749ea708dabbfe2224%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638028997419628807%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=c7gSLjJEAxuX8xmMiTDMUHNwUdQNKN00xqtAZAEeow8%3D&amp;reserved=0
>> > 
>> >      Issuing invalidations with folio-granularity ties in fairly well
>> >      with this sort of approach if we end up going that route.
>> 
>> There is semantics difference between the current one and the proposed
>> one: The invalidation range is exactly what userspace passed down to the
>> kernel (being fallocated) while the proposed one will be subset of that
>> (if userspace-provided addr/size is not aligned to power of two), I'm
>> not quite confident this difference has no side effect.
> 
> In theory userspace should not be allocating/hole-punching restricted
> pages for GPA ranges that are already mapped as private in the xarray,
> and KVM could potentially fail such requests (though it does currently).
> 
> But if we somehow enforced that, then we could rely on
> KVM_MEMORY_ENCRYPT_REG_REGION to handle all the MMU invalidation stuff,
> which would free up the restricted fd invalidation callbacks to be used
> purely to handle doing things like RMP/directmap fixups prior to returning
> restricted pages back to the host. So that was sort of my thinking why the
> new semantics would still cover all the necessary cases.
> 
> -Mike
> 
>> 
>> > 
>> > I need to rework things for v9, and we'll probably want to use struct
>> > folio instead of struct page now, but as a proof-of-concept of sorts this
>> > is what I'd added on top of v8 of your patchset to implement 1) and 2):
>> > 
>> >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommit%2F127e5ea477c7bd5e4107fd44a04b9dc9e9b1af8b&amp;data=05%7C01%7Cmichael.roth%40amd.com%7C3aba56bf7d574c749ea708dabbfe2224%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638028997419628807%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=jOFT0iLmeU7rKniEkWOsTf2%2FPI13EAw4Qm7arI1q970%3D&amp;reserved=0
>> > 
>> > Does an approach like this seem reasonable? Should be work this into the
>> > base restricted memslot support?
>> 
>> If the above mentioned semantics difference is not a problem, I don't
>> have strong objection on this.
>> 
>> Sean, since you have much better understanding on this, what is your
>> take on this?
>> 
>> Chao
>> > 
>> > Thanks,
>> > 
>> > Mike


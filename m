Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11835649D6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 22:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiGCUyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 16:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiGCUyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 16:54:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9A5F62;
        Sun,  3 Jul 2022 13:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDD1EB80CD1;
        Sun,  3 Jul 2022 20:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7147DC341CB;
        Sun,  3 Jul 2022 20:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656881668;
        bh=7Q/L+jJXVD6j6D4idRT999HADd2inFVONm+H47jI4ZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lztQvJSwPELrQ+3skd5KG1BWwRWMi7tDTCIbxCj5p/hqsfP+zKWvHwAacgWZBhAHi
         EAuQ4riC4wNpa6/BgGZUw3B2L1AXwJNy0j66b8UKCXdFs7Bp3vnkZH1RmQwVqrv0eD
         z2z4BwRxq2D1e3+MduH0OvjybgMTdVRiU2+NrDGqkEMhyx+xMpYtjRGP3pjgLLeKtk
         TfR4c2sIO8N4eLxEN6T2wo89tisKfwktoJUAuTdDM9CgyNgRKdwZLny3asoICDGfoc
         NPbaeHkylKcFnJgyRyRi2/To9JIPzEWivWCc7pDROMmzY/vMwLd/Wnb9FZq1bwSd6T
         Leen/M5d3ZVPg==
Message-ID: <48e40b61-f506-72a1-0839-08bc9db483cc@kernel.org>
Date:   Sun, 3 Jul 2022 13:54:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 09/14] mm/mshare: Do not free PTEs for mshare'd PTEs
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>,
        Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, Kees Cook <keescook@chromium.org>,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        markhemm@googlemail.com, Peter Collingbourne <pcc@google.com>,
        Mike Rapoport <rppt@kernel.org>, sieberf@amazon.com,
        sjpark@amazon.de, Suren Baghdasaryan <surenb@google.com>,
        tst@schoebel-theuer.de, Iurii Zaikin <yzaikin@google.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <f96de8e7757aabc8e38af8aacbce4c144133d42d.1649370874.git.khalid.aziz@oracle.com>
 <CAGsJ_4xC0sB0x2orOcKgx4p0fa5Y0bR9qeviq1_Q7VmhMk2d6A@mail.gmail.com>
 <e5bebb34-5858-815c-9c2c-254a95b86b07@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <e5bebb34-5858-815c-9c2c-254a95b86b07@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/29/22 10:38, Khalid Aziz wrote:
> On 5/30/22 22:24, Barry Song wrote:
>> On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> 
>> wrote:
>>>
>>> mshare'd PTEs should not be removed when a task exits. These PTEs
>>> are removed when the last task sharing the PTEs exits. Add a check
>>> for shared PTEs and skip them.
>>>
>>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>>> ---
>>>   mm/memory.c | 22 +++++++++++++++++++---
>>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index c77c0d643ea8..e7c5bc6f8836 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -419,16 +419,25 @@ void free_pgtables(struct mmu_gather *tlb, 
>>> struct vm_area_struct *vma,
>>>                  } else {
>>>                          /*
>>>                           * Optimization: gather nearby vmas into one 
>>> call down
>>> +                        * as long as they all belong to the same mm 
>>> (that
>>> +                        * may not be the case if a vma is part of 
>>> mshare'd
>>> +                        * range
>>>                           */
>>>                          while (next && next->vm_start <= vma->vm_end 
>>> + PMD_SIZE
>>> -                              && !is_vm_hugetlb_page(next)) {
>>> +                              && !is_vm_hugetlb_page(next)
>>> +                              && vma->vm_mm == tlb->mm) {
>>>                                  vma = next;
>>>                                  next = vma->vm_next;
>>>                                  unlink_anon_vmas(vma);
>>>                                  unlink_file_vma(vma);
>>>                          }
>>> -                       free_pgd_range(tlb, addr, vma->vm_end,
>>> -                               floor, next ? next->vm_start : ceiling);
>>> +                       /*
>>> +                        * Free pgd only if pgd is not allocated for an
>>> +                        * mshare'd range
>>> +                        */
>>> +                       if (vma->vm_mm == tlb->mm)
>>> +                               free_pgd_range(tlb, addr, vma->vm_end,
>>> +                                       floor, next ? next->vm_start 
>>> : ceiling);
>>>                  }
>>>                  vma = next;
>>>          }
>>> @@ -1551,6 +1560,13 @@ void unmap_page_range(struct mmu_gather *tlb,
>>>          pgd_t *pgd;
>>>          unsigned long next;
>>>
>>> +       /*
>>> +        * If this is an mshare'd page, do not unmap it since it might
>>> +        * still be in use.
>>> +        */
>>> +       if (vma->vm_mm != tlb->mm)
>>> +               return;
>>> +
>>
>> expect unmap, have you ever tested reverse mapping in vmscan, especially
>> folio_referenced()? are all vmas in those processes sharing page table 
>> still
>> in the rmap of the shared page?
>> without shared PTE, if 1000 processes share one page, we are reading 1000
>> PTEs, with it, are we reading just one? or are we reading the same PTE
>> 1000 times? Have you tested it?
>>
> 
> We are treating mshared region same as threads sharing address space. 
> There is one PTE that is being used by all processes and the VMA 
> maintained in the separate mshare mm struct that also holds the shared 
> PTE is the one that gets added to rmap. This is a different model with 
> mshare in that it adds an mm struct that is separate from the mm structs 
> of the processes that refer to the vma and pte in mshare mm struct. Do 
> you see issues with rmap in this model?

I think this patch is actually the most interesting bit of the series by 
far.  Most of the rest is defining an API (which is important!) and 
figuring out semantics.  This patch changes something rather fundamental 
about how user address spaces work: what vmas live in them.  So let's 
figure out its effects.

I admit I'm rather puzzled about what vm_mm is for in the first place. 
In current kernels (without your patch), I think it's a pretty hard 
requirement for vm_mm to equal the mm for all vmas in an mm.  After a 
quick and incomplete survey, vm_mm seems to be mostly used as a somewhat 
lazy way to find the mm.  Let's see:

file_operations->mmap doesn't receive an mm_struct.  Instead it infers 
the mm from vm_mm.  (Why?  I don't know.)

Some walk_page_range users seem to dig the mm out of vm_mm instead of 
mm_walk.

Some manual address space walkers start with an mm, don't bother passing 
it around, and dig it back out of of vm_mm.  For example, unuse_vma() 
and all its helpers.

The only real exception I've found so far is rmap: AFAICS (on quick 
inspection -- I could be wrong), rmap can map from a folio to a bunch of 
vmas, and the vmas' mms are not stored separately but instead determined 
by vm_mm.



Your patch makes me quite nervous.  You're potentially breaking any 
kernel code path that assumes that mms only contain vmas that have vm_mm 
== mm.  And you're potentially causing rmap to be quite confused.  I 
think that if you're going to take this approach, you need to clearly 
define the new semantics of vm_mm and audit or clean up every user of 
vm_mm in the tree.  This may be nontrivial (especially rmap), although a 
cleanup of everything else to stop using vm_mm might be valuable.

But I'm wondering if it would be better to attack this from a different 
direction.  Right now, there's a hardcoded assumption that an mm owns 
every page table it references.  That's really the thing you're 
changing.  To me, it seems that a magical vma that shares page tables 
should still be a vma that belongs to its mm_struct -- munmap() and 
potentialy other m***() operations should all work on it, existing 
find_vma() users should work, etc.

So maybe instead there should be new behavior (by a VM_ flag or 
otherwise) that indicates that a vma owns its PTEs.  It could even be a 
vm_operation, although if anyone ever wants regular file mappings to 
share PTEs, then a vm_operation doesn't really make sense.


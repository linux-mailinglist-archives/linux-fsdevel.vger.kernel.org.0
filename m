Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FBE767DAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjG2JgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjG2JgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F21B4
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jul 2023 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690623327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bWqJqgkrC5EioI6ENy0pfk/g25n5XtUYg/1+69k8UA=;
        b=SmB+fDh2MiLxbTT5BcVRJJhPl2VY404gGo9LC0s1wkTJ/I5F2/7oww7/MQb2q7N1kgw5L6
        ZHaa+oocJSHU+eBSAVHGfBwIOTzV9mcaPhEtLgcviH8sbbWkfTvBTN9jHppRPiRpTR/aFF
        X+p2wKKekAiw4lS/mYzbBVnSuvsbyuo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-HtYHq8ddPbGg2PR3Z63JYA-1; Sat, 29 Jul 2023 05:35:25 -0400
X-MC-Unique: HtYHq8ddPbGg2PR3Z63JYA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbb0c01e71so15408395e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jul 2023 02:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690623324; x=1691228124;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :content-language:references:cc:to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bWqJqgkrC5EioI6ENy0pfk/g25n5XtUYg/1+69k8UA=;
        b=Y8V8OwElh0OEAYS3XmkylhYWS9ZEa3PNiP2it8urd5UIcjn3fGUD48KqmEE0FffFso
         Rdq/WMPuBiqMQEj4YrkS6LHRb/pAvC9PFkbM8G27sOH8M/+2rCdmjQA5oqXe4cH3/wlm
         ceVNY4bF2TTiXI/rVlJmN9wP7sERQ5llmeAnTE0ohJpT3GG5tQn6nUvssOdSB5n7kWqj
         v3KOSR7OEpY+rOLV9fgVZLGzYZgyZv7zjfPzIumPaAEB0TTFX5/GpgVfkD3Cj+cNym0b
         0ONn1ICRwdtE49IdlrbnRBl6b4nQJ0PUwNx2dBkxMe7HQtEEqwMjAKL0AtmeoD2tURHe
         GmVQ==
X-Gm-Message-State: ABy/qLZgLF/GgdMgWDYfTBQ/qi2keajt7CF2ae/60HhKtM7fzr/uPurn
        +ggtIG9oHOQeHYJwJe7aPaZ0SfL8rLEx3YRdciFAwbCdkW+Os9L7MJEW8sHUBpSci/kgEE+e0JE
        x8FTqH6sFEU77/Z/NeK3CrLTQ6zDx3og5GA==
X-Received: by 2002:a05:600c:22c8:b0:3fe:16c8:65fa with SMTP id 8-20020a05600c22c800b003fe16c865famr787764wmg.4.1690623324353;
        Sat, 29 Jul 2023 02:35:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF5HKDUHU/Q4DZ3GTAP9JDBn+VvrtxbWt9uwss6Myi9d3auLmATkPId9YkbyExNVQJTLirffg==
X-Received: by 2002:a05:600c:22c8:b0:3fe:16c8:65fa with SMTP id 8-20020a05600c22c800b003fe16c865famr787741wmg.4.1690623323834;
        Sat, 29 Jul 2023 02:35:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:e700:4a51:80ee:e9e3:910c? (p200300cbc706e7004a5180eee9e3910c.dip0.t-ipconnect.de. [2003:cb:c706:e700:4a51:80ee:e9e3:910c])
        by smtp.gmail.com with ESMTPSA id t20-20020a7bc3d4000000b003fe146fae45sm1650033wmj.46.2023.07.29.02.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 02:35:23 -0700 (PDT)
Message-ID: <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com>
Date:   Sat, 29 Jul 2023 11:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   David Hildenbrand <david@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com>
Content-Language: en-US
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
In-Reply-To: <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29.07.23 00:35, David Hildenbrand wrote:
>> The original reason for not setting FOLL_NUMA all the time is
>> documented in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting
>> page faults from gup/gup_fast") from way back in 2012:
>>
>>            * If FOLL_FORCE and FOLL_NUMA are both set, handle_mm_fault
>>            * would be called on PROT_NONE ranges. We must never invoke
>>            * handle_mm_fault on PROT_NONE ranges or the NUMA hinting
>>            * page faults would unprotect the PROT_NONE ranges if
>>            * _PAGE_NUMA and _PAGE_PROTNONE are sharing the same pte/pmd
>>            * bitflag. So to avoid that, don't set FOLL_NUMA if
>>            * FOLL_FORCE is set.
>>
>> but I don't think the original reason for this is *true* any more.
>>
>> Because then two years later in 2014, in commit c46a7c817e66 ("x86:
>> define _PAGE_NUMA by reusing software bits on the PMD and PTE levels")
>> Mel made the code able to distinguish between PROT_NONE and NUMA
>> pages, and he changed the comment above too.
> 
> 

Sleeping over it and looking into some nasty details, I realized the following things:


(1) The pte_protnone() comment in include/linux/pgtable.h is
     either wrong or misleading.

     Especially the "For PROT_NONE VMAs, the PTEs are not marked
     _PAGE_PROTNONE" is *wrong* nowadays on x86.

     Doing an mprotect(PROT_NONE) will also result in pte_protnone()
     succeeding, because the pages *are* marked _PAGE_PROTNONE.

     The comment should be something like this

     /*
      * In an inaccessible (PROT_NONE) VMA, pte_protnone() *may* indicate
      * "yes". It is perfectly valid to indicate "no" in that case,
      * which is why our default implementation defaults to "always no".
      *
      * In an accessible VMA, however, pte_protnone() *reliably*
      * indicates PROT_NONE page protection due to NUMA hinting. NUMA
      * hinting faults only apply in accessible VMAs.
      *
      * So, to reliably distinguish between PROT_NONE due to an
      * inaccessible VMA and NUMA hinting, looking at the VMA
      * accessibility is sufficient.
      */

     I'll send that as a separate patch.


(2) Consequently, commit c46a7c817e66 from 2014 does not tell the whole
     story.

     commit 21d9ee3eda77 ("mm: remove remaining references to NUMA
     hinting bits and helpers") from 2015 made the distinction again
     impossible.

     Setting FOLL_FORCE | FOLL_HONOR_NUMA_HINT would end up never making
     progress in GUP with an inaccessible (PROT_NONE) VMA.

     (a) GUP sees the pte_protnone() and triggers a NUMA hinting fault,
         although NUMA hinting does not apply.

     (b) handle_mm_fault() refuses to do anything with pte_protnone() in
         an inaccessible VMA. And even if it would do something, the new
         PTE would end up as pte_protnone() again.
  
     So, GUP will keep retrying. I have a reproducer that triggers that
     using ptrace read in an inaccessible VMA.

     It's easy to make that work in GUP, simply by looking at the VMA
     accessibility.

     See my patch proposal, that cleanly decouples FOLL_FORCE from
     FOLL_HONOR_NUMA_HINT.


(3) follow_page() does not check VMA permissions and, therefore, my
     "implied FOLL_FORCE" assumption is not actually completely wrong.

     And especially callers that dont't pass FOLL_WRITE really expect
     follow_page() to work even if the VMA is inaccessible.

     But the interaction with NUMA hinting is just nasty, absolutely
     agreed.

     As raised in another comment, I'm looking into removing the
     "foll_flags" parameter from follow_page() completely and cleanly
     documenting the semantics of follow_page().

     IMHO, the less follow_page(), the better. Let's see what we can do
     to improve that.


So this would be the patch I would suggest as the first fix we can also
backport to stable.

Gave it a quick test, also with my ptrace read reproducer (trigger
FOLL_FORCE on inaccessible VMA; make sure it works and that the pages don't
suddenly end up readable in the page table). Seems to work.

I'll follow up with cleanups and moving FOLL_HONOR_NUMA_HINT setting to the
relevant callers (especially KVM). Further, I'll add a selftest to make
sure that ptrace on inaccessible VMAs keeps working as expected.



 From 36c1aeb9aa3e859762f671776601a71179247d17 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 28 Jul 2023 21:57:04 +0200
Subject: [PATCH] mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT

As it turns out, unfortunately commit 474098edac26 ("mm/gup: replace
FOLL_NUMA by gup_can_follow_protnone()") missed that follow_page() and
follow_trans_huge_pmd() never set FOLL_NUMA because they really don't want
NUMA hinting faults.

As spelled out in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting page
faults from gup/gup_fast"): "Other follow_page callers like KSM should not
use FOLL_NUMA, or they would fail to get the pages if they use follow_page
instead of get_user_pages."

While we didn't get BUG reports on the changed follow_page() semantics yet
(and it's just a matter of time), liubo reported [1] that smaps_rollup
results are imprecise, because they miss accounting of pages that are
mapped PROT_NONE due to NUMA hinting.

As KVM really depends on these NUMA hinting faults, removing the
pte_protnone()/pmd_protnone() handling in GUP code completely is not really
an option.

To fix the issues at hand, let's revive FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
to restore the original behavior and add better comments.

Set FOLL_HONOR_NUMA_FAULT independent of FOLL_FORCE. To make that
combination work in inaccessible VMAs, we have to perform proper VMA
accessibility checks in gup_can_follow_protnone().

Move gup_can_follow_protnone() to internal.h which feels more
appropriate and is required as long as FOLL_HONOR_NUMA_FAULT is an
internal flag.

As Linus notes [2], this handling doesn't make sense for many GUP users.
So we should really see if we instead let relevant GUP callers specify it
manually, and not trigger NUMA hinting faults from GUP as default.

[1] https://lore.kernel.org/r/20230726073409.631838-1-liubo254@huawei.com
[2] https://lore.kernel.org/r/CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com

Reported-by: liubo <liubo254@huawei.com>
Reported-by: Peter Xu <peterx@redhat.com>
Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: liubo <liubo254@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/mm.h | 15 ---------------
  mm/gup.c           | 18 ++++++++++++++----
  mm/huge_memory.c   |  2 +-
  mm/internal.h      | 31 +++++++++++++++++++++++++++++++
  4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2dd73e4f3d8e..f8d7fa3c01c1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3400,21 +3400,6 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
  	return 0;
  }
  
-/*
- * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
- * a (NUMA hinting) fault is required.
- */
-static inline bool gup_can_follow_protnone(unsigned int flags)
-{
-	/*
-	 * FOLL_FORCE has to be able to make progress even if the VMA is
-	 * inaccessible. Further, FOLL_FORCE access usually does not represent
-	 * application behaviour and we should avoid triggering NUMA hinting
-	 * faults.
-	 */
-	return flags & FOLL_FORCE;
-}
-
  typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
  extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
  			       unsigned long size, pte_fn_t fn, void *data);
diff --git a/mm/gup.c b/mm/gup.c
index 76d222ccc3ff..54b8d77f3a3d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -597,7 +597,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
  	pte = ptep_get(ptep);
  	if (!pte_present(pte))
  		goto no_page;
-	if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
+	if (pte_protnone(pte) && !gup_can_follow_protnone(vma, flags))
  		goto no_page;
  
  	page = vm_normal_page(vma, address, pte);
@@ -714,7 +714,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
  	if (likely(!pmd_trans_huge(pmdval)))
  		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
  
-	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(flags))
+	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
  		return no_page_table(vma, flags);
  
  	ptl = pmd_lock(mm, pmd);
@@ -851,6 +851,10 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
  	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
  		return NULL;
  
+	/*
+	 * We never set FOLL_HONOR_NUMA_FAULT because callers don't expect
+	 * to fail on PROT_NONE-mapped pages.
+	 */
  	page = follow_page_mask(vma, address, foll_flags, &ctx);
  	if (ctx.pgmap)
  		put_dev_pagemap(ctx.pgmap);
@@ -1200,6 +1204,12 @@ static long __get_user_pages(struct mm_struct *mm,
  
  	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
  
+	/*
+	 * For now, always trigger NUMA hinting faults. Some GUP users like
+	 * KVM really require it to benefit from autonuma.
+	 */
+	gup_flags |= FOLL_HONOR_NUMA_FAULT;
+
  	do {
  		struct page *page;
  		unsigned int foll_flags = gup_flags;
@@ -2551,7 +2561,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
  		struct page *page;
  		struct folio *folio;
  
-		if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
+		if (pte_protnone(pte) && !gup_can_follow_protnone(NULL, flags))
  			goto pte_unmap;
  
  		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
@@ -2971,7 +2981,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
  		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
  			     pmd_devmap(pmd))) {
  			if (pmd_protnone(pmd) &&
-			    !gup_can_follow_protnone(flags))
+			    !gup_can_follow_protnone(NULL, flags))
  				return 0;
  
  			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb3678360b97..ef6bdc4a6fec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1468,7 +1468,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
  		return ERR_PTR(-EFAULT);
  
  	/* Full NUMA hinting faults to serialise migration in fault paths */
-	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(flags))
+	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
  		return NULL;
  
  	if (!pmd_write(*pmd) && gup_must_unshare(vma, flags, page))
diff --git a/mm/internal.h b/mm/internal.h
index a7d9e980429a..7db17259c51a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -937,6 +937,8 @@ enum {
  	FOLL_FAST_ONLY = 1 << 20,
  	/* allow unlocking the mmap lock */
  	FOLL_UNLOCKABLE = 1 << 21,
+	/* Honor (trigger) NUMA hinting faults on PROT_NONE-mapped pages. */
+	FOLL_HONOR_NUMA_FAULT = 1 << 22,
  };
  
  /*
@@ -1004,6 +1006,35 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
  	return !PageAnonExclusive(page);
  }
  
+/*
+ * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
+ * a (NUMA hinting) fault is required.
+ */
+static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
+					   unsigned int flags)
+{
+	/*
+	 * If callers don't want to honor NUMA hinting faults, no need to
+	 * determine if we would actually have to trigger a NUMA hinting fault.
+	 */
+	if (!(flags & FOLL_HONOR_NUMA_FAULT))
+		return true;
+
+	/* We really need the VMA ... */
+	if (!vma)
+		return false;
+
+	/*
+	 * ... because NUMA hinting faults only apply in accessible VMAs. In
+	 * inaccessible (PROT_NONE) VMAs, NUMA hinting faults don't apply.
+	 *
+	 * Requiring a fault here even for inaccessible VMAs would mean that
+	 * FOLL_FORCE cannot make any progress, because handle_mm_fault()
+	 * refuses to process NUMA hinting faults in inaccessible VMAs.
+	 */
+	return !vma_is_accessible(vma);
+}
+
  extern bool mirrored_kernelcore;
  
  static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
-- 
2.41.0



-- 
Cheers,

David / dhildenb


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A13A4D1734
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 13:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbiCHMZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 07:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiCHMZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00DDF46674
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 04:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646742265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lzfc4QEw7p5WC1/8oMj3J+9qTYddtexZan7JWLr/2Y=;
        b=gR4FHBuQSv74m8iRIs7FU8hMxivEHNlCDsuCVY47p+y03f5ZHcfFNpwqYOtXWskwqct3jx
        EbCccvj0VkfLtdNmeNbey9EUiElUPVdxAY1lyeGLTWDZWoTwaZA8yciPu+dW/KCjahH+xs
        qVHLfU1AXdd1uncFR+asnZo/FF81Jo8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-LhmvcO65OjCRmMQllWb9Gg-1; Tue, 08 Mar 2022 07:24:21 -0500
X-MC-Unique: LhmvcO65OjCRmMQllWb9Gg-1
Received: by mail-wm1-f70.google.com with SMTP id 26-20020a05600c22da00b00388307f3503so1031968wmg.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 04:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=3lzfc4QEw7p5WC1/8oMj3J+9qTYddtexZan7JWLr/2Y=;
        b=FMfo5uPuHnmgYyfmAuRdJ/4NHkIjw4XcExfJ37fGUAOOOj9VdwoShYIAJJsl8r32NG
         aLT+iBBApxcJs777FIAYg80K3ezH0ttdqafQsgMy2DE7ewal4o+fI72Oyfp/S4+bil1a
         4BsSD5CFsygqR+fDGRqtbkx2fd4I55M56c5dydiGf4j5J3sXCE62L72AsvowdqFdgcZq
         Ux+xq5lTQ5LJ1DmOw4ISvtLA/xgXbJeQLZlpufCBs79obzIF38l8vg8RXRm1T6gTYVQo
         0OARZgamaX2qh3zt2yuKbLw3gSBMunzxYbFIICUIlveXuPSFUymsFnkS9ZGkLKD+6gvK
         24Pg==
X-Gm-Message-State: AOAM533gkPTNgmgT2kcZJcZ0WS3NqeYe3ACxO+XPb7TCVgf2uNKq7kun
        kTOY6HfTiKBk9B/Kkx+09pnaflocXjPZ4tKaZjBOtGZUdumjMqc7rBuJsKD0OLpcVKUZh68yOra
        Kp5fz+ya7IjEBzDdljOVOqm5yDQ==
X-Received: by 2002:a05:600c:210e:b0:385:d649:b4ca with SMTP id u14-20020a05600c210e00b00385d649b4camr3358189wml.114.1646742260690;
        Tue, 08 Mar 2022 04:24:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx7FxwmpEe8eRh5iWWatpDmptV36AngOfntBp9MEiG4m4k0mfYo9xu3yrvx85EDMuZHTpq/g==
X-Received: by 2002:a05:600c:210e:b0:385:d649:b4ca with SMTP id u14-20020a05600c210e00b00385d649b4camr3358170wml.114.1646742260415;
        Tue, 08 Mar 2022 04:24:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b00389c3a281d7sm2634913wms.0.2022.03.08.04.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 04:24:20 -0800 (PST)
Message-ID: <1bdb0184-696c-0f1a-3054-d88391c32e64@redhat.com>
Date:   Tue, 8 Mar 2022 13:24:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
 <2266e1a8-ac79-94a1-b6e2-47475e5986c5@redhat.com>
 <81f2f76d-24ef-c23b-449e-0b8fdec506e1@redhat.com>
Organization: Red Hat
In-Reply-To: <81f2f76d-24ef-c23b-449e-0b8fdec506e1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.03.22 13:11, David Hildenbrand wrote:
> On 08.03.22 09:37, David Hildenbrand wrote:
>> On 08.03.22 09:21, David Hildenbrand wrote:
>>> On 08.03.22 00:18, Linus Torvalds wrote:
>>>> On Mon, Mar 7, 2022 at 2:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>>>>>
>>>>> After generic_file_read_iter() returns a short or empty read, we fault
>>>>> in some pages with fault_in_iov_iter_writeable(). This succeeds, but
>>>>> the next call to generic_file_read_iter() returns -EFAULT and we're
>>>>> not making any progress.
>>>>
>>>> Since this is s390-specific, I get the very strong feeling that the
>>>>
>>>>   fault_in_iov_iter_writeable ->
>>>>     fault_in_safe_writeable ->
>>>>       __get_user_pages_locked ->
>>>>         __get_user_pages
>>>>
>>>> path somehow successfully finds the page, despite it not being
>>>> properly accessible in the page tables.
>>>
>>> As raised offline already, I suspect
>>>
>>> shrink_active_list()
>>> ->page_referenced()
>>>  ->page_referenced_one()
>>>   ->ptep_clear_flush_young_notify()
>>>    ->ptep_clear_flush_young()
>>>
>>> which results on s390x in:
>>>
>>> static inline pte_t pte_mkold(pte_t pte)
>>> {
>>> 	pte_val(pte) &= ~_PAGE_YOUNG;
>>> 	pte_val(pte) |= _PAGE_INVALID;
>>> 	return pte;
>>> }
>>>
>>> static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>>> 					    unsigned long addr, pte_t *ptep)
>>> {
>>> 	pte_t pte = *ptep;
>>>
>>> 	pte = ptep_xchg_direct(vma->vm_mm, addr, ptep, pte_mkold(pte));
>>> 	return pte_young(pte);
>>> }
>>>
>>>
>>> _PAGE_INVALID is the actual HW bit, _PAGE_PRESENT is a
>>> pure SW bit. AFAIU, pte_present() still holds:
>>>
>>> static inline int pte_present(pte_t pte)
>>> {
>>> 	/* Bit pattern: (pte & 0x001) == 0x001 */
>>> 	return (pte_val(pte) & _PAGE_PRESENT) != 0;
>>> }
>>>
>>>
>>> pte_mkyoung() will revert that action:
>>>
>>> static inline pte_t pte_mkyoung(pte_t pte)
>>> {
>>> 	pte_val(pte) |= _PAGE_YOUNG;
>>> 	if (pte_val(pte) & _PAGE_READ)
>>> 		pte_val(pte) &= ~_PAGE_INVALID;
>>> 	return pte;
>>> }
>>>
>>>
>>> and pte_modify() will adjust it properly again:
>>>
>>> /*
>>>  * The following pte modification functions only work if
>>>  * pte_present() is true. Undefined behaviour if not..
>>>  */
>>> static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>> {
>>> 	pte_val(pte) &= _PAGE_CHG_MASK;
>>> 	pte_val(pte) |= pgprot_val(newprot);
>>> 	/*
>>> 	 * newprot for PAGE_NONE, PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX
>>> 	 * has the invalid bit set, clear it again for readable, young pages
>>> 	 */
>>> 	if ((pte_val(pte) & _PAGE_YOUNG) && (pte_val(pte) & _PAGE_READ))
>>> 		pte_val(pte) &= ~_PAGE_INVALID;
>>> 	/*
>>> 	 * newprot for PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX has the page
>>> 	 * protection bit set, clear it again for writable, dirty pages
>>> 	 */
>>> 	if ((pte_val(pte) & _PAGE_DIRTY) && (pte_val(pte) & _PAGE_WRITE))
>>> 		pte_val(pte) &= ~_PAGE_PROTECT;
>>> 	return pte;
>>> }
>>>
>>>
>>>
>>> Which leaves me wondering if there is a way in GUP whereby
>>> we would lookup that page and not clear _PAGE_INVALID,
>>> resulting in GUP succeeding but faults via the MMU still
>>> faulting on _PAGE_INVALID.
>>
>>
>> follow_page_pte() has this piece of code:
>>
>> 	if (flags & FOLL_TOUCH) {
>> 		if ((flags & FOLL_WRITE) &&
>> 		    !pte_dirty(pte) && !PageDirty(page))
>> 			set_page_dirty(page);
>> 		/*
>> 		 * pte_mkyoung() would be more correct here, but atomic care
>> 		 * is needed to avoid losing the dirty bit: it is easier to use
>> 		 * mark_page_accessed().
>> 		 */
>> 		mark_page_accessed(page);
>> 	}
>>
>> Which at least to me suggests that, although the page is marked accessed and GUP
>> succeeds, that the PTE might still have _PAGE_INVALID set after we succeeded GUP.
>>
>>
>> On s390x, there is no HW dirty bit, so we might just be able to do a proper
>> pte_mkyoung() here instead of the mark_page_accessed().
>>
> 
> Something hacky like this should be able to show if what I suspect is the case.
> It compiles, but I didn't actually test it.
That would be the alternative that also takes the mkdirty into account:


From 1e51e8a93894f87c0a4d0e908391e0628ae56afe Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 8 Mar 2022 12:51:26 +0100
Subject: [PATCH] mm/gup: fix buffered I/O on s390x with pagefaults disabled

On s390x, we actually need a pte_mkyoung() / pte_mkdirty() instead of
going via the page and leaving the PTE unmodified. E.g., if we only
mark the page accessed via mark_page_accessed() when doing a FOLL_TOUCH,
we'll miss to clear the HW invalid bit in the pte and subsequent accesses
via the MMU would still require a pagefault.

Otherwise, buffered I/O will loop forever because it will keep stumling
over the set HW invalid bit, requiring a page fault.

Reported-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a9d4d724aef7..de3311feb377 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -587,15 +587,33 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		}
 	}
 	if (flags & FOLL_TOUCH) {
-		if ((flags & FOLL_WRITE) &&
-		    !pte_dirty(pte) && !PageDirty(page))
-			set_page_dirty(page);
 		/*
-		 * pte_mkyoung() would be more correct here, but atomic care
-		 * is needed to avoid losing the dirty bit: it is easier to use
-		 * mark_page_accessed().
+		 * We have to be careful with updating the PTE on architectures
+		 * that have a HW dirty bit: while updating the PTE we might
+		 * lose that bit again and we'd need an atomic update: it is
+		 * easier to leave the PTE untouched for these architectures.
+		 *
+		 * s390x doesn't have a hw referenced / dirty bit and e.g., sets
+		 * the hw invalid bit in pte_mkold(), to catch further
+		 * references. We have to update the PTE here to e.g., clear the
+		 * invalid bit; otherwise, callers that rely on not requiring
+		 * an MMU fault once GUP(FOLL_TOUCH) succeeded will loop forever
+		 * because the page won't actually be accessible via the MMU.
 		 */
-		mark_page_accessed(page);
+		if (IS_ENABLED(CONFIG_S390)) {
+			pte = pte_mkyoung(pte);
+			if (flags & FOLL_WRITE)
+				pte = pte_mkdirty(pte);
+			if (!pte_same(pte, *ptep)) {
+				set_pte_at(vma->vm_mm, address, ptep, pte);
+				update_mmu_cache(vma, address, ptep);
+			}
+		} else {
+			if ((flags & FOLL_WRITE) &&
+			    !pte_dirty(pte) && !PageDirty(page))
+				set_page_dirty(page);
+			mark_page_accessed(page);
+		}
 	}
 	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
 		/* Do not mlock pte-mapped THP */
-- 
2.35.1


-- 
Thanks,

David / dhildenb


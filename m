Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4894D1933
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiCHNdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 08:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiCHNda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28AC46449
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 05:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646746350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSB2Ol/nnrrRd3g4Qot/m3+tnisbJitEe8TFiqjPaUA=;
        b=WueKDvNBY4uX4uXzl8uhVbjPCqn/HlrfpxmyRO3fH5+rwiIkBKEL3AouJp1jApI4n/3YLA
        8kQxordpKESCiMh38soni2zD0RodBWWn1GsU65zLKbnP7J+a3mfobaPvckNwcKG21x3lY/
        RORlorx1MHgHV6wns377a16xiUSJ+iw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-1apdc4EcNzia4kwNKucyeA-1; Tue, 08 Mar 2022 08:32:29 -0500
X-MC-Unique: 1apdc4EcNzia4kwNKucyeA-1
Received: by mail-wm1-f69.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso914767wmz.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 05:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=iSB2Ol/nnrrRd3g4Qot/m3+tnisbJitEe8TFiqjPaUA=;
        b=ev/8X5ijHxVzljh+3sYI0dc+Mz/5INtPaceZPS1/dROo+7NR6OEgDayeybZvW5/oUh
         QBUgvggHCgGpDwBA9QODMRIy8Dzdv6cxWxsLhOxtzd6LwV4w6EX5ZQeMfY/iIMFymq1Q
         YGMw7KTe/EdvhOTL//pT58CyjbY9SD4N49gGem8uIW1lN+/GAPCbcmSmMAE/nI8MrApH
         gTJ14lgk3Ngdxv9IUfT5niIl/H5WOOTRgW9PDechAn1kHw3hajAC+uIAtImg+zY31Lis
         9+s3AAcVjQHttkBgS8qjegFCHuSI8LcF8tdB0y0ZsZ/nvJU8lhq65SAx8wy0iKJFnILx
         xAcQ==
X-Gm-Message-State: AOAM531pNP2NfdyPldVwrgoCfHv4PUp9A5SQ3WIM17A/AZve2unYUnyY
        V5A9Do2Q0zNihLGTXADtHBaj9RCHQsw4P52GoXh3SR5iEODnQHO9f7h6W4zCrlxQlGhhQR0F4Wu
        0MtzmdZeMpPxkwa9BHWXLyOQwow==
X-Received: by 2002:a1c:f003:0:b0:381:17f5:21b8 with SMTP id a3-20020a1cf003000000b0038117f521b8mr3549020wmb.158.1646746347797;
        Tue, 08 Mar 2022 05:32:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmpaWAjeRm0d1i/b5jSMA7gKRkARjJJZmqUgvv3qpUXLmIJkGjHmpvaHNXbNDVRpDo9Z4ZIQ==
X-Received: by 2002:a1c:f003:0:b0:381:17f5:21b8 with SMTP id a3-20020a1cf003000000b0038117f521b8mr3549001wmb.158.1646746347524;
        Tue, 08 Mar 2022 05:32:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c4e9400b003898e252cd4sm2599464wmq.12.2022.03.08.05.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 05:32:26 -0800 (PST)
Message-ID: <da799fa7-b6c6-eb70-27e4-0c5d8592bd34@redhat.com>
Date:   Tue, 8 Mar 2022 14:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
 <2266e1a8-ac79-94a1-b6e2-47475e5986c5@redhat.com>
 <81f2f76d-24ef-c23b-449e-0b8fdec506e1@redhat.com>
 <1bdb0184-696c-0f1a-3054-d88391c32e64@redhat.com>
 <20220308142047.7a725518@thinkpad>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
In-Reply-To: <20220308142047.7a725518@thinkpad>
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

On 08.03.22 14:20, Gerald Schaefer wrote:
> On Tue, 8 Mar 2022 13:24:19 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
> [...]
>>
>> From 1e51e8a93894f87c0a4d0e908391e0628ae56afe Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Tue, 8 Mar 2022 12:51:26 +0100
>> Subject: [PATCH] mm/gup: fix buffered I/O on s390x with pagefaults disabled
>>
>> On s390x, we actually need a pte_mkyoung() / pte_mkdirty() instead of
>> going via the page and leaving the PTE unmodified. E.g., if we only
>> mark the page accessed via mark_page_accessed() when doing a FOLL_TOUCH,
>> we'll miss to clear the HW invalid bit in the pte and subsequent accesses
>> via the MMU would still require a pagefault.
>>
>> Otherwise, buffered I/O will loop forever because it will keep stumling
>> over the set HW invalid bit, requiring a page fault.
>>
>> Reported-by: Andreas Gruenbacher <agruenba@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/gup.c | 32 +++++++++++++++++++++++++-------
>>  1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index a9d4d724aef7..de3311feb377 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -587,15 +587,33 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>>  		}
>>  	}
>>  	if (flags & FOLL_TOUCH) {
>> -		if ((flags & FOLL_WRITE) &&
>> -		    !pte_dirty(pte) && !PageDirty(page))
>> -			set_page_dirty(page);
>>  		/*
>> -		 * pte_mkyoung() would be more correct here, but atomic care
>> -		 * is needed to avoid losing the dirty bit: it is easier to use
>> -		 * mark_page_accessed().
>> +		 * We have to be careful with updating the PTE on architectures
>> +		 * that have a HW dirty bit: while updating the PTE we might
>> +		 * lose that bit again and we'd need an atomic update: it is
>> +		 * easier to leave the PTE untouched for these architectures.
>> +		 *
>> +		 * s390x doesn't have a hw referenced / dirty bit and e.g., sets
>> +		 * the hw invalid bit in pte_mkold(), to catch further
>> +		 * references. We have to update the PTE here to e.g., clear the
>> +		 * invalid bit; otherwise, callers that rely on not requiring
>> +		 * an MMU fault once GUP(FOLL_TOUCH) succeeded will loop forever
>> +		 * because the page won't actually be accessible via the MMU.
>>  		 */
>> -		mark_page_accessed(page);
>> +		if (IS_ENABLED(CONFIG_S390)) {
>> +			pte = pte_mkyoung(pte);
>> +			if (flags & FOLL_WRITE)
>> +				pte = pte_mkdirty(pte);
>> +			if (!pte_same(pte, *ptep)) {
>> +				set_pte_at(vma->vm_mm, address, ptep, pte);
>> +				update_mmu_cache(vma, address, ptep);
>> +			}
>> +		} else {
>> +			if ((flags & FOLL_WRITE) &&
>> +			    !pte_dirty(pte) && !PageDirty(page))
>> +				set_page_dirty(page);
>> +			mark_page_accessed(page);
>> +		}
>>  	}
>>  	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
>>  		/* Do not mlock pte-mapped THP */
> 
> Thanks David, your analysis looks valid, at least it seems that you found
> a scenario where we would have HW invalid bit set due to pte_mkold() in
> ptep_clear_flush_young(), and still GUP would find and return that page, IIUC.
> 
> I think pte handling should be similar to pmd handling in follow_trans_huge_pmd()
> -> touch_pmd(), or cow_user_page() (see comment on software "accessed" bits),
> which is more or less what your patch does.
> 
> Some possible concerns:
> - set_page_dirty() would not be done any more for s390, is that intended and ok?

I strongly assume so, because the page is mapped via a PTE, which is
writable and dirty. This is similar to THP logic.

> - using set_pte_at() here seems a bit dangerous, as I'm not sure if this will
>   always only operate on invalid PTEs. Using it on active valid PTEs could
>   result in TLB issues because of missing flush. Also not sure about kvm impact.
>   Using ptep_set_access_flags() seems safer, again similar to touch_pmd() and
>   also cow_user_page().

Yeah, I sticked to what follow_pfn_pte() does for simplicity for now.
But I agree that following what touch_pmd() does looks saner --
ptep_set_access_flags().

> 
> Looking at cow_user_page(), I also wonder if the arch_faults_on_old_pte()
> logic could be used here. I must admit that I did not really understand the
> "losing the dirty bit" part of the comment, but it seems that we might need
> to not only check for arch_faults_on_old_pte(), but also for something like
> "arch_faults_for_dirty_pte".
> 
> Last but not least, IIUC, this issue should affect all archs that return
> true on arch_faults_on_old_pte(). After all, the basic problem seems to be
> that a pagefault is required for PTEs marked as old, in combination with
> GUP still returning a valid page. So maybe this should not be restricted
> to IS_ENABLED(CONFIG_S390).

Yeah, as raised, the IS_ENABLED(CONFIG_S390) part is just a quick hack
to see if this would fix the issue.

arch_faults_on_dirty_pte / arch_faults_on_old_pte might be a
replacement. We just would have to be careful for architectures that
e.g., have arch_faults_on_old_pte=true and
arch_faults_on_dirty_pte=false (i.e., hw dirty bit but no hw accessed
bit). Would have to think about how to handle that properly ...

Thanks!

-- 
Thanks,

David / dhildenb


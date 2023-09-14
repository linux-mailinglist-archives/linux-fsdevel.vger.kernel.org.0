Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC53B7A0D87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 20:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbjINSwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbjINSvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F25394ECD
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694717149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yvl0oZS06u+Mc5pUy8196yl56j2FK2OsnzUd+32T3ds=;
        b=h3GSZFjV/bL4Q4zfYfuI02e0Zs4HeXTkmOsD/kPjqzcu4f98VhA5ZcUkMJuEbxcRkFhbew
        orJ6/RFTULF62dGSPz/2s2Q7Z5r1AA4MWOda3oAhegY6BhwSxdxDIaHRZ/doQ+w909cevZ
        lrCDLcrHMI+XrTW3jNpTmJzQSuxpFOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-OgcP5R48OTeuLsNYXOd48g-1; Thu, 14 Sep 2023 14:45:47 -0400
X-MC-Unique: OgcP5R48OTeuLsNYXOd48g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40474e7323dso5179595e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 11:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694717146; x=1695321946;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yvl0oZS06u+Mc5pUy8196yl56j2FK2OsnzUd+32T3ds=;
        b=itzays5D+tSbP5+YyXe64KP5zA1D102ju2l2cDynIjY6gQh71jGN1qCA9r6aJwr+FA
         7BeEeadozy82f2lhQolquPw/aEaFS41PI+/caSQ5N7f7px5uuyT6IxJ5svrHeev8DLC1
         CXLOa3HwKX5fiz+6j4sqMabAX00O2B7yLmAX6aZ7HDEde9TZIRLu27piAy+pspnpLI8e
         pGqKhdNh5rI4Oy2MGm6sRjcBpMOh/a2Wu6RJC8UOLS6e1Le+2cg0zYczkUvAgSx5Fk3S
         U1PgA7njdvWcrbIFVnIYlVlhXu4uQIr3tIKZhg9dX8zXME3zPvTa+y8QWBoaRM3R2p/N
         pWsg==
X-Gm-Message-State: AOJu0YzVZOsTx2DqMsVvCYWROQmdH5GnehYC3ENDffa/Zy3vEK00AIQb
        4XS4JVqm0qEDMfzFtGuKaaZVYUiR6KZGJ8Ecp/9DN6mxd7j3zro9ORkBEVaRDG+TKJz5qg64P57
        XyXcfY0uFUCnrtQg/qgChoLV8cQ==
X-Received: by 2002:a5d:6603:0:b0:317:5e5e:60e0 with SMTP id n3-20020a5d6603000000b003175e5e60e0mr5665418wru.28.1694717146327;
        Thu, 14 Sep 2023 11:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Q3PlMjzGnGFHx6HU3sWTqn5GaqBgVvM4/5Qktf8taBcPNuKuptBpP34W65Xvm7xkb6quGg==
X-Received: by 2002:a5d:6603:0:b0:317:5e5e:60e0 with SMTP id n3-20020a5d6603000000b003175e5e60e0mr5665391wru.28.1694717145824;
        Thu, 14 Sep 2023 11:45:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:600:4630:4a91:d07:7095? (p200300cbc71c060046304a910d077095.dip0.t-ipconnect.de. [2003:cb:c71c:600:4630:4a91:d07:7095])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d604f000000b0031779a6b451sm2408478wrt.83.2023.09.14.11.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:45:45 -0700 (PDT)
Message-ID: <f6e350f4-1bf3-ca10-93f8-c11db44ce62b@redhat.com>
Date:   Thu, 14 Sep 2023 20:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
References: <20230914152620.2743033-1-surenb@google.com>
 <20230914152620.2743033-3-surenb@google.com>
 <ZQNMze6SXdIm13CW@casper.infradead.org>
 <e77b75f9-ab9e-f20b-6484-22f73524c159@redhat.com>
Organization: Red Hat
In-Reply-To: <e77b75f9-ab9e-f20b-6484-22f73524c159@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.09.23 20:43, David Hildenbrand wrote:
> On 14.09.23 20:11, Matthew Wilcox wrote:
>> On Thu, Sep 14, 2023 at 08:26:12AM -0700, Suren Baghdasaryan wrote:
>>> +++ b/include/linux/userfaultfd_k.h
>>> @@ -93,6 +93,23 @@ extern int mwriteprotect_range(struct mm_struct *dst_mm,
>>>    extern long uffd_wp_range(struct vm_area_struct *vma,
>>>    			  unsigned long start, unsigned long len, bool enable_wp);
>>>    
>>> +/* remap_pages */
>>> +extern void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
>>> +extern void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
>>> +extern ssize_t remap_pages(struct mm_struct *dst_mm,
>>> +			   struct mm_struct *src_mm,
>>> +			   unsigned long dst_start,
>>> +			   unsigned long src_start,
>>> +			   unsigned long len, __u64 flags);
>>> +extern int remap_pages_huge_pmd(struct mm_struct *dst_mm,
>>> +				struct mm_struct *src_mm,
>>> +				pmd_t *dst_pmd, pmd_t *src_pmd,
>>> +				pmd_t dst_pmdval,
>>> +				struct vm_area_struct *dst_vma,
>>> +				struct vm_area_struct *src_vma,
>>> +				unsigned long dst_addr,
>>> +				unsigned long src_addr);
>>
>> Drop the 'extern' markers from function declarations.
>>
>>> +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
>>> +			 struct mm_struct *src_mm,
>>> +			 pmd_t *dst_pmd, pmd_t *src_pmd,
>>> +			 pmd_t dst_pmdval,
>>> +			 struct vm_area_struct *dst_vma,
>>> +			 struct vm_area_struct *src_vma,
>>> +			 unsigned long dst_addr,
>>> +			 unsigned long src_addr)
>>> +{
>>> +	pmd_t _dst_pmd, src_pmdval;
>>> +	struct page *src_page;
>>> +	struct anon_vma *src_anon_vma, *dst_anon_vma;
>>> +	spinlock_t *src_ptl, *dst_ptl;
>>> +	pgtable_t pgtable;
>>> +	struct mmu_notifier_range range;
>>> +
>>> +	src_pmdval = *src_pmd;
>>> +	src_ptl = pmd_lockptr(src_mm, src_pmd);
>>> +
>>> +	BUG_ON(!pmd_trans_huge(src_pmdval));
>>> +	BUG_ON(!pmd_none(dst_pmdval));
>>> +	BUG_ON(!spin_is_locked(src_ptl));
>>> +	mmap_assert_locked(src_mm);
>>> +	mmap_assert_locked(dst_mm);
>>> +	BUG_ON(src_addr & ~HPAGE_PMD_MASK);
>>> +	BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
>>> +
>>> +	src_page = pmd_page(src_pmdval);
>>> +	BUG_ON(!PageHead(src_page));
>>> +	BUG_ON(!PageAnon(src_page));
>>
>> Better to add a src_folio = page_folio(src_page);
>> and then folio_test_anon() here.
>>
>>> +	if (unlikely(page_mapcount(src_page) != 1)) {
>>
>> Brr, this is going to miss PTE mappings of this folio.  I think you
>> actually want folio_mapcount() instead, although it'd be more efficient
>> to look at folio->_entire_mapcount == 1 and _nr_pages_mapped == 0.
>> Not wure what a good name for that predicate would be.
> 
> We have
> 
>    * It only works on non shared anonymous pages because those can
>    * be relocated without generating non linear anon_vmas in the rmap
>    * code.
>    *
>    * It provides a zero copy mechanism to handle userspace page faults.
>    * The source vma pages should have mapcount == 1, which can be
>    * enforced by using madvise(MADV_DONTFORK) on src vma.
> 
> Use PageAnonExclusive(). As long as KSM is not involved and you don't
> use fork(), that flag should be good enough for that use case here.
>
... and similarly don't do any of that swapcount stuff and only check if 
the swap pte is anon exclusive.

-- 
Cheers,

David / dhildenb


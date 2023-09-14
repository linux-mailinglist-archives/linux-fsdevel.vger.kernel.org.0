Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258857A0D79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbjINSu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 14:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbjINSuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07F79E5827
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694717022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0akcrrxPTvMntGm3gQRHZF2Md0/HBRzawwdcPZ7RPas=;
        b=NnETkKMxgRzXYJHyd0e1mbnsKiTeYFpJLRACAag7SlUOVv90GGYffMiAp5gXAuV48uxQl+
        c9d8xFj8zqPypLE0rSvqre3K/TyxluJqM8l2NcKw6nChBGpR0Jm1qzT80Yf8bzgC2evr+o
        PIsKVfCq0pAyvTNMWUJdBwRROX1pdxs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-1ZgSlSskPfmNzeq89EWFeQ-1; Thu, 14 Sep 2023 14:43:40 -0400
X-MC-Unique: 1ZgSlSskPfmNzeq89EWFeQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31fb093a53aso828053f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 11:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694717019; x=1695321819;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0akcrrxPTvMntGm3gQRHZF2Md0/HBRzawwdcPZ7RPas=;
        b=mq/FnsO6KRkZnXePKACc9ylcM0Q87LsvcxaYeFeyn4Qvkw97KcLDvKSqVwli08Sz5I
         CbTF/Kr9HInjfHa9/kA7aHevv/PbdTFBufVmO/bWnME9pMiLCge6OkxMJtk73R5Yf+Ek
         U9svZ9BTpgmV+OwOIJXgxkNScgRNY4/PzEs4brNmr9fQQHKlLJocYpmbnwnNgWbO7UEn
         D7PMKLWNmczFlODbEibB6mK8wLmOBuDnq3aoIuhFMyXhbLA0LbDHjL0FQ3IQt7SarY2a
         GYQActD024DQlCCgpIrVkUXoyRZKmk+EwpB+F09XM6myyRy/RpT81xuMDeqnB3Tk+rCR
         yUQg==
X-Gm-Message-State: AOJu0Yxz/MJpgC80B9RQfUuk/Vtvm0nM/TQ6vF1GOipS9LnMnUEyIboy
        qHWLn2vQ6kNpC4bCgcKn6zhdawH8sjZD6oGXH5i6UoYLN6jDaTKMRS2MVapr0JrkFrCUKVR2F8n
        EmfnvAjm8YJ8xoRqZftCuTYFC/A==
X-Received: by 2002:adf:f782:0:b0:31a:d551:c2c9 with SMTP id q2-20020adff782000000b0031ad551c2c9mr5368584wrp.6.1694717019429;
        Thu, 14 Sep 2023 11:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh7NWNMxRoWhcImoY2+JKuaYIz/StTxRyV5OHnf5w7KYP/JyxfK3mH80nh87mgTPUaRf1QtA==
X-Received: by 2002:adf:f782:0:b0:31a:d551:c2c9 with SMTP id q2-20020adff782000000b0031ad551c2c9mr5368560wrp.6.1694717018868;
        Thu, 14 Sep 2023 11:43:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:600:4630:4a91:d07:7095? (p200300cbc71c060046304a910d077095.dip0.t-ipconnect.de. [2003:cb:c71c:600:4630:4a91:d07:7095])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b0031accc7228asm2463536wru.34.2023.09.14.11.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:43:38 -0700 (PDT)
Message-ID: <e77b75f9-ab9e-f20b-6484-22f73524c159@redhat.com>
Date:   Thu, 14 Sep 2023 20:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
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
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQNMze6SXdIm13CW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.09.23 20:11, Matthew Wilcox wrote:
> On Thu, Sep 14, 2023 at 08:26:12AM -0700, Suren Baghdasaryan wrote:
>> +++ b/include/linux/userfaultfd_k.h
>> @@ -93,6 +93,23 @@ extern int mwriteprotect_range(struct mm_struct *dst_mm,
>>   extern long uffd_wp_range(struct vm_area_struct *vma,
>>   			  unsigned long start, unsigned long len, bool enable_wp);
>>   
>> +/* remap_pages */
>> +extern void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
>> +extern void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
>> +extern ssize_t remap_pages(struct mm_struct *dst_mm,
>> +			   struct mm_struct *src_mm,
>> +			   unsigned long dst_start,
>> +			   unsigned long src_start,
>> +			   unsigned long len, __u64 flags);
>> +extern int remap_pages_huge_pmd(struct mm_struct *dst_mm,
>> +				struct mm_struct *src_mm,
>> +				pmd_t *dst_pmd, pmd_t *src_pmd,
>> +				pmd_t dst_pmdval,
>> +				struct vm_area_struct *dst_vma,
>> +				struct vm_area_struct *src_vma,
>> +				unsigned long dst_addr,
>> +				unsigned long src_addr);
> 
> Drop the 'extern' markers from function declarations.
> 
>> +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
>> +			 struct mm_struct *src_mm,
>> +			 pmd_t *dst_pmd, pmd_t *src_pmd,
>> +			 pmd_t dst_pmdval,
>> +			 struct vm_area_struct *dst_vma,
>> +			 struct vm_area_struct *src_vma,
>> +			 unsigned long dst_addr,
>> +			 unsigned long src_addr)
>> +{
>> +	pmd_t _dst_pmd, src_pmdval;
>> +	struct page *src_page;
>> +	struct anon_vma *src_anon_vma, *dst_anon_vma;
>> +	spinlock_t *src_ptl, *dst_ptl;
>> +	pgtable_t pgtable;
>> +	struct mmu_notifier_range range;
>> +
>> +	src_pmdval = *src_pmd;
>> +	src_ptl = pmd_lockptr(src_mm, src_pmd);
>> +
>> +	BUG_ON(!pmd_trans_huge(src_pmdval));
>> +	BUG_ON(!pmd_none(dst_pmdval));
>> +	BUG_ON(!spin_is_locked(src_ptl));
>> +	mmap_assert_locked(src_mm);
>> +	mmap_assert_locked(dst_mm);
>> +	BUG_ON(src_addr & ~HPAGE_PMD_MASK);
>> +	BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
>> +
>> +	src_page = pmd_page(src_pmdval);
>> +	BUG_ON(!PageHead(src_page));
>> +	BUG_ON(!PageAnon(src_page));
> 
> Better to add a src_folio = page_folio(src_page);
> and then folio_test_anon() here.
> 
>> +	if (unlikely(page_mapcount(src_page) != 1)) {
> 
> Brr, this is going to miss PTE mappings of this folio.  I think you
> actually want folio_mapcount() instead, although it'd be more efficient
> to look at folio->_entire_mapcount == 1 and _nr_pages_mapped == 0.
> Not wure what a good name for that predicate would be.

We have

  * It only works on non shared anonymous pages because those can
  * be relocated without generating non linear anon_vmas in the rmap
  * code.
  *
  * It provides a zero copy mechanism to handle userspace page faults.
  * The source vma pages should have mapcount == 1, which can be
  * enforced by using madvise(MADV_DONTFORK) on src vma.

Use PageAnonExclusive(). As long as KSM is not involved and you don't 
use fork(), that flag should be good enough for that use case here.

[...]

>> +			/*
>> +			 * Pin the page while holding the lock to be sure the
>> +			 * page isn't freed under us
>> +			 */
>> +			spin_lock(src_ptl);
>> +			if (!pte_same(orig_src_pte, *src_pte)) {
>> +				spin_unlock(src_ptl);
>> +				err = -EAGAIN;
>> +				goto out;
>> +			}
>> +
>> +			folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
>> +			if (!folio || !folio_test_anon(folio) ||
>> +			    folio_estimated_sharers(folio) != 1) {
> 
> I wonder if we also want to fail if folio_test_large()?  While we don't
> have large anon folios today, it seems to me that trying to migrate one
> of them like this is just not going to work.

Yes, refuse any PTE-mapped large folios.


-- 
Cheers,

David / dhildenb


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF7151185
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 22:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBCVBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 16:01:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11345 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCVBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:01:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e388a030000>; Mon, 03 Feb 2020 13:00:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 13:01:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 13:01:14 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 21:01:14 +0000
Subject: Re: [PATCH v3 07/12] mm/gup: track FOLL_PIN pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-8-jhubbard@nvidia.com>
 <20200203134024.htczuqghduajb3yx@box>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <44f9e71f-dc65-fb37-dd6d-228270170aad@nvidia.com>
Date:   Mon, 3 Feb 2020 13:01:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203134024.htczuqghduajb3yx@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580763651; bh=xdyrRhrFRwm8PgNsPaTnG7fESTt9E/IE4SCifoyTh/g=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZlOdaNKeCwGQCefKwQkyzz5HO3exK9puspru1qNqq8OeTYhh79QWmjMtrfnso5+/i
         okdRSSlKjbVj6W3rH8UK/+NXzDNQQSIFzmO/yAxm2o28hb6D9mOZq7R3erjxiHtkJg
         Pq9boyDlD9aiomyCHOcEdWTjh1LL6mxNXdSseAKDijaCu8YQP9ylcUSgfrO+BG3Ktk
         5dNjBCi3KJfawkDCi9Laqgj825rrHLwsKcNDBOAjF5PR8AbP2BDizrMjAO0QnCE6LA
         BNJqk2jhW8zGG9ac3sM5E6VfkmA1W1V1JqBYxqnsaL6hHsS+lzpNh3QdGs6DPM5mbC
         6hWoULMfVb8tg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/20 5:40 AM, Kirill A. Shutemov wrote:
> On Fri, Jan 31, 2020 at 07:40:24PM -0800, John Hubbard wrote:
>> @@ -4405,7 +4392,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>>  same_page:
>>  		if (pages) {
>>  			pages[i] = mem_map_offset(page, pfn_offset);
>> -			get_page(pages[i]);
>> +			if (!try_grab_page(pages[i], flags)) {
>> +				spin_unlock(ptl);
>> +				remainder = 0;
>> +				err = -ENOMEM;
>> +				WARN_ON_ONCE(1);
> 
> The WARN_ON_ONCE deserve a comment. And I guess you can put it into 'if'
> condition.

OK, I've changed it to the following, which I *think* is an accurate comment, but
I'm still a bit new to huge pages:

		if (pages) {
			pages[i] = mem_map_offset(page, pfn_offset);
			/*
			 * try_grab_page() should always succeed here, because:
			 * a) we hold the ptl lock, and b) we've just checked
			 * that the huge page is present in the page tables. If
			 * the huge page is present, then the tail pages must
			 * also be present. The ptl prevents the head page and
			 * tail pages from being rearranged in any way. So this
			 * page must be available at this point, unless the page
			 * refcount overflowed:
			 */
			if (WARN_ON_ONCE(!try_grab_page(pages[i], flags))) {
				spin_unlock(ptl);
				remainder = 0;
				err = -ENOMEM;
				break;
			}
		}


> 
>> +				break;
>> +			}
>>  		}
>>  
>>  		if (vmas)
>> @@ -4965,6 +4958,12 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>>  	struct page *page = NULL;
>>  	spinlock_t *ptl;
>>  	pte_t pte;
>> +
>> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
>> +			 (FOLL_PIN | FOLL_GET)))
>> +		return NULL;
>> +
>>  retry:
>>  	ptl = pmd_lockptr(mm, pmd);
>>  	spin_lock(ptl);
>> @@ -4977,8 +4976,11 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>>  	pte = huge_ptep_get((pte_t *)pmd);
>>  	if (pte_present(pte)) {
>>  		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
>> -		if (flags & FOLL_GET)
>> -			get_page(page);
>> +		if (unlikely(!try_grab_page(page, flags))) {
>> +			WARN_ON_ONCE(1);
> 
> Ditto.


OK, I've added a similar comment as the one above. Now it looks like this:

	if (pte_present(pte)) {
		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
		/*
		 * try_grab_page() should always succeed here, because: a) we
		 * hold the pmd (ptl) lock, and b) we've just checked that the
		 * huge pmd (head) page is present in the page tables. The ptl
		 * prevents the head page and tail pages from being rearranged
		 * in any way. So this page must be available at this point,
		 * unless the page refcount overflowed:
		 */
		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
			page = NULL;
			goto out;
		}



thanks,
-- 
John Hubbard
NVIDIA


> 
>> +			page = NULL;
>> +			goto out;
>> +		}
>>  	} else {
>>  		if (is_hugetlb_entry_migration(pte)) {
>>  			spin_unlock(ptl);
> 

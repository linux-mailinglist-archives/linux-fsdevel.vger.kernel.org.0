Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D932E2D5962
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 12:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgLJLj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 06:39:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:54458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgLJLj7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:39:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A472DAE4A;
        Thu, 10 Dec 2020 11:39:15 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 10 Dec 2020 11:25:02 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] mm/hugetlb: Optimize the code with the help of
 the compiler
In-Reply-To: <20201210035526.38938-13-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-13-songmuchun@bytedance.com>
User-Agent: Roundcube Webmail
Message-ID: <375d6bad6bb37e3626f71bfabc20b384@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-12-10 04:55, Muchun Song wrote:
> We cannot optimize if a "struct page" crosses page boundaries. If
> it is true, we can optimize the code with the help of a compiler.
> When free_vmemmap_pages_per_hpage() returns zero, most functions are
> optimized by the compiler.

As I said earlier, I would squash this patch with patch#10 and
remove the !is_power_of_2 check in hugetlb_vmemmap_init and leave
only the check for the boot parameter.
That should be enough.

>  static inline bool is_hugetlb_free_vmemmap_enabled(void)
>  {
> -	return hugetlb_free_vmemmap_enabled;
> +	return hugetlb_free_vmemmap_enabled &&
> +	       is_power_of_2(sizeof(struct page));

Why? hugetlb_free_vmemmap_enabled can only become true
if the is_power_of_2 check succeeds in early_hugetlb_free_vmemmap_param.
The "is_power_of_2" check here can go.

> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 0a1c0d33a316..5f5e90c81cd2 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -21,7 +21,7 @@ void free_huge_page_vmemmap(struct hstate *h, struct
> page *head);
>   */
>  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate 
> *h)
>  {
> -	return h->nr_free_vmemmap_pages;
> +	return h->nr_free_vmemmap_pages && is_power_of_2(sizeof(struct 
> page));

If hugetlb_free_vmemmap_enabled is false, hugetlb_vmemmap_init() leaves
h->nr_free_vmemmap_pages unset to 0, so no need for the is_power_of_2 
check here.


-- 
Oscar Salvador
SUSE L3

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96A2E0D69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 17:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgLVQde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 11:33:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:46128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbgLVQde (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:33:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56F11B769;
        Tue, 22 Dec 2020 16:32:52 +0000 (UTC)
Date:   Tue, 22 Dec 2020 17:32:48 +0100
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
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v11 03/11] mm/hugetlb: Free the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20201222163248.GB31385@linux>
References: <20201222142440.28930-1-songmuchun@bytedance.com>
 <20201222142440.28930-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222142440.28930-4-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 10:24:32PM +0800, Muchun Song wrote:
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index 5d0767cb424a..eff5b13a6945 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -37,6 +37,13 @@ void dump_mm(const struct mm_struct *mm);
>  			BUG();						\
>  		}							\
>  	} while (0)
> +#define VM_WARN_ON_PAGE(cond, page)					\
> +	do {								\
> +		if (unlikely(cond)) {					\
> +			dump_page(page, "VM_WARN_ON_PAGE(" __stringify(cond)")");\
> +			WARN_ON(1);					\
> +		}							\
> +	} while (0)
>  #define VM_WARN_ON_ONCE_PAGE(cond, page)	({			\
>  	static bool __section(".data.once") __warned;			\
>  	int __ret_warn_once = !!(cond);					\
> @@ -60,6 +67,7 @@ void dump_mm(const struct mm_struct *mm);
>  #define VM_BUG_ON_MM(cond, mm) VM_BUG_ON(cond)
>  #define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
> +#define VM_WARN_ON_PAGE(cond, page) BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)

Take this off this patch and make it a preparation patch prior to this one.
A new VM_WARN_ON_ macro does not make much sense in this patch as it is
not related.

I will have a look later today at the other changes, but so far looks good.

-- 
Oscar Salvador
SUSE L3

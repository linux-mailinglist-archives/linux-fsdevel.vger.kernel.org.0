Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179583417DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 10:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCSJAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 05:00:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhCSJAA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:00:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63818AC1F;
        Fri, 19 Mar 2021 08:59:58 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:59:53 +0100
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
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [PATCH v19 7/8] mm: hugetlb: add a kernel parameter
 hugetlb_free_vmemmap
Message-ID: <20210319085948.GA5695@linux>
References: <20210315092015.35396-1-songmuchun@bytedance.com>
 <20210315092015.35396-8-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315092015.35396-8-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 05:20:14PM +0800, Muchun Song wrote:
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -34,6 +34,7 @@
>  #include <linux/gfp.h>
>  #include <linux/kcore.h>
>  #include <linux/bootmem_info.h>
> +#include <linux/hugetlb.h>
>  
>  #include <asm/processor.h>
>  #include <asm/bios_ebda.h>
> @@ -1557,7 +1558,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  {
>  	int err;
>  
> -	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> +	if ((is_hugetlb_free_vmemmap_enabled()  && !altmap) ||
> +	    end - start < PAGES_PER_SECTION * sizeof(struct page))
>  		err = vmemmap_populate_basepages(start, end, node, NULL);
>  	else if (boot_cpu_has(X86_FEATURE_PSE))
>  		err = vmemmap_populate_hugepages(start, end, node, altmap);

I've been thinking about this some more.

Assume you opt-in the hugetlb-vmemmap feature, and assume you pass a valid altmap
to vmemmap_populate.
This will lead to use populating the vmemmap array with hugepages.

What if then, a HugeTLB gets allocated and falls within that memory range (backed
by hugetpages)?
AFAIK, this will get us in trouble as currently the code can only operate on memory
backed by PAGE_SIZE pages, right?

I cannot remember, but I do not think nothing prevents that from happening?
Am I missing anything?

-- 
Oscar Salvador
SUSE L3

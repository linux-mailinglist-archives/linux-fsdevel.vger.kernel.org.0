Return-Path: <linux-fsdevel+bounces-29689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFB997C4AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1121E2831FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 07:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F31191F97;
	Thu, 19 Sep 2024 07:12:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8FE1917CC;
	Thu, 19 Sep 2024 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729949; cv=none; b=t3nsSd+dY/DFe2e8QifSMcivaFyDONazYYOMjacGNoTU6ravgEDIPv74PsocsKsnF3fTbrjTKHk7qCL0E8UMHgdfb2j+ikRwBzLLLredvbqjXDr6zfpzlvpunrif70e+6pcGf87NTXIbW0Ib+LXxbk7YsYiVlXJm16BXaJ2bCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729949; c=relaxed/simple;
	bh=/jgnX+ABOI2z3m4Qx4fkTR24jfiYP85AWYoL8PMuYjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gH/3L/rSTr6BnIjR14is2rd7zB8PEueUKn4oXuoWz+JYsqIBRhAO7sPpHYH51GheT1PxPWMTjAvYVnZy3u7IwlQNotzVUzvIzlUSfD2GGT6CcuUzEcUZb7bDb2QazIjmZVnK8l+4gMhwmfQKZZ0BwD7ZtV5shvdKkZV8igpwitc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 190C81007;
	Thu, 19 Sep 2024 00:12:50 -0700 (PDT)
Received: from [10.163.34.169] (unknown [10.163.34.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 109FE3F64C;
	Thu, 19 Sep 2024 00:12:11 -0700 (PDT)
Message-ID: <6191a730-1a0f-476e-8041-a0a51094b6b3@arm.com>
Date: Thu, 19 Sep 2024 12:42:08 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/7] mm: Use pmdp_get() for accessing PMD entries
To: kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Muchun Song <muchun.song@linux.dev>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>
References: <20240917073117.1531207-5-anshuman.khandual@arm.com>
 <202409190244.JcrD4CwD-lkp@intel.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202409190244.JcrD4CwD-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/19/24 00:37, kernel test robot wrote:
> Hi Anshuman,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on char-misc/char-misc-testing]
> [also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus brauner-vfs/vfs.all dennis-percpu/for-next linus/master v6.11]
> [cannot apply to akpm-mm/mm-everything next-20240918]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/m68k-mm-Change-pmd_val/20240917-153331
> base:   char-misc/char-misc-testing
> patch link:    https://lore.kernel.org/r/20240917073117.1531207-5-anshuman.khandual%40arm.com
> patch subject: [PATCH V2 4/7] mm: Use pmdp_get() for accessing PMD entries
> config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240919/202409190244.JcrD4CwD-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240919/202409190244.JcrD4CwD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409190244.JcrD4CwD-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/asm-generic/bug.h:22,
>                     from arch/openrisc/include/asm/bug.h:5,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/mm.h:6,
>                     from include/linux/pagemap.h:8,
>                     from mm/pgtable-generic.c:10:
>    mm/pgtable-generic.c: In function 'pmd_clear_bad':
>>> arch/openrisc/include/asm/pgtable.h:369:36: error: lvalue required as unary '&' operand
>      369 |                __FILE__, __LINE__, &(e), pgd_val(e))
>          |                                    ^
>    include/linux/printk.h:437:33: note: in definition of macro 'printk_index_wrap'
>      437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                                 ^~~~~~~~~~~
>    arch/openrisc/include/asm/pgtable.h:368:9: note: in expansion of macro 'printk'
>      368 |         printk(KERN_ERR "%s:%d: bad pgd %p(%08lx).\n", \
>          |         ^~~~~~
>    include/asm-generic/pgtable-nop4d.h:25:50: note: in expansion of macro 'pgd_ERROR'
>       25 | #define p4d_ERROR(p4d)                          (pgd_ERROR((p4d).pgd))
>          |                                                  ^~~~~~~~~
>    include/asm-generic/pgtable-nopud.h:32:50: note: in expansion of macro 'p4d_ERROR'
>       32 | #define pud_ERROR(pud)                          (p4d_ERROR((pud).p4d))
>          |                                                  ^~~~~~~~~
>    include/asm-generic/pgtable-nopmd.h:36:50: note: in expansion of macro 'pud_ERROR'
>       36 | #define pmd_ERROR(pmd)                          (pud_ERROR((pmd).pud))
>          |                                                  ^~~~~~~~~
>    mm/pgtable-generic.c:54:9: note: in expansion of macro 'pmd_ERROR'
>       54 |         pmd_ERROR(pmdp_get(pmd));
>          |         ^~~~~~~~~
> 
> 
> vim +369 arch/openrisc/include/asm/pgtable.h
> 
> 61e85e367535a7 Jonas Bonn 2011-06-04  363  
> 61e85e367535a7 Jonas Bonn 2011-06-04  364  #define pte_ERROR(e) \
> 61e85e367535a7 Jonas Bonn 2011-06-04  365  	printk(KERN_ERR "%s:%d: bad pte %p(%08lx).\n", \
> 61e85e367535a7 Jonas Bonn 2011-06-04  366  	       __FILE__, __LINE__, &(e), pte_val(e))
> 61e85e367535a7 Jonas Bonn 2011-06-04  367  #define pgd_ERROR(e) \
> 61e85e367535a7 Jonas Bonn 2011-06-04  368  	printk(KERN_ERR "%s:%d: bad pgd %p(%08lx).\n", \
> 61e85e367535a7 Jonas Bonn 2011-06-04 @369  	       __FILE__, __LINE__, &(e), pgd_val(e))
> 61e85e367535a7 Jonas Bonn 2011-06-04  370  
> 

This build failure can be fixed with dropping address output from
pxd_ERROR() helpers as is being done for the x86 platform. Similar
fix is also required for the UM architecture as well.

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 60c6ce7ff2dc..831efb71ab54 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -362,11 +362,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pfn_pte(pfn, prot)  __pte((((pfn) << PAGE_SHIFT)) | pgprot_val(prot))
 
 #define pte_ERROR(e) \
-       printk(KERN_ERR "%s:%d: bad pte %p(%08lx).\n", \
-              __FILE__, __LINE__, &(e), pte_val(e))
+       printk(KERN_ERR "%s:%d: bad pte (%08lx).\n", \
+              __FILE__, __LINE__, pte_val(e))
 #define pgd_ERROR(e) \
-       printk(KERN_ERR "%s:%d: bad pgd %p(%08lx).\n", \
-              __FILE__, __LINE__, &(e), pgd_val(e))
+       printk(KERN_ERR "%s:%d: bad pgd (%08lx).\n", \
+              __FILE__, __LINE__, pgd_val(e))
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD]; /* defined in head.S */


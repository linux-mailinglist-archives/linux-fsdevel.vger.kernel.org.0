Return-Path: <linux-fsdevel+bounces-29693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983297C566
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84022825D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC8198A37;
	Thu, 19 Sep 2024 07:55:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2C19884B;
	Thu, 19 Sep 2024 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732522; cv=none; b=UZBsnWd7jNJSdtnYj9cysALATVqaxIndPOaAujHHm6E0qXmo4O2fnyH6KLsq4WWQbv2/BTnOymilDAWa5k/K8RzAXZvhl1z2FIWhU3QBzkycYptWY8PEXFjcKnHGRCYJycUfc7NhwPCKSm1ffoEQtjqUOmRN8y+rJV5dtD1tsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732522; c=relaxed/simple;
	bh=vcFB/ifStaTfpFcCwe3/ujVWgWHMMcWMbHSX2N+2PTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMn+FcyLVEgYLKSn+KUkqfsl1EGzSAt8P9NIvuTdm7RjLNhTDkhPKWuW99SXR8qRhJcOE/J8R3CURvWBV0IfJCWVH4X1ghxF+TY7woeWCaKfqujxur0SoOJp4Fibz2J7uWLHW8TWt5/+inDx0n2HQxQKSuAgpMiQKoEg1aKGUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 157351007;
	Thu, 19 Sep 2024 00:55:49 -0700 (PDT)
Received: from [10.163.34.169] (unknown [10.163.34.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D82B3F71A;
	Thu, 19 Sep 2024 00:55:10 -0700 (PDT)
Message-ID: <8f43251a-5418-4c54-a9b0-29a6e9edd879@arm.com>
Date: Thu, 19 Sep 2024 13:25:08 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
To: kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Muchun Song
 <muchun.song@linux.dev>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>
References: <20240917073117.1531207-8-anshuman.khandual@arm.com>
 <202409190310.ViHBRe12-lkp@intel.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202409190310.ViHBRe12-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/24 02:00, kernel test robot wrote:
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
> patch link:    https://lore.kernel.org/r/20240917073117.1531207-8-anshuman.khandual%40arm.com
> patch subject: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
> config: arm-footbridge_defconfig (https://download.01.org/0day-ci/archive/20240919/202409190310.ViHBRe12-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240919/202409190310.ViHBRe12-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409190310.ViHBRe12-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/arm/kernel/asm-offsets.c:12:
>    In file included from include/linux/mm.h:30:
>>> include/linux/pgtable.h:1245:18: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
>     1245 |         pgd_t old_pgd = pgdp_get(pgd);
>          |                         ^
>    arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
>      154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
>          |                                            ^
>    include/linux/pgtable.h:1243:48: note: 'pgd' declared here
>     1243 | static inline int pgd_none_or_clear_bad(pgd_t *pgd)
>          |                                                ^

arm (32) platform currently overrides pgdp_get() helper in the platform but
defines that like the exact same version as the generic one, albeit with a
typo which can be fixed with something like this.

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index be91e376df79..aedb32d49c2a 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -151,7 +151,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
-#define pgdp_get(pgpd)         READ_ONCE(*pgdp)
+#define pgdp_get(pgdp)         READ_ONCE(*pgdp)
 
 #define pud_page(pud)          pmd_page(__pmd(pud_val(pud)))
 #define pud_write(pud)         pmd_write(__pmd(pud_val(pud)))

Regardless there is another problem here. On arm platform there are multiple
pgd_t definitions available depending on various configs but some are arrays
instead of a single data element, although platform pgdp_get() helper remains
the same for all.

arch/arm/include/asm/page-nommu.h:typedef unsigned long pgd_t[2];
arch/arm/include/asm/pgtable-2level-types.h:typedef struct { pmdval_t pgd[2]; } pgd_t;
arch/arm/include/asm/pgtable-2level-types.h:typedef pmdval_t pgd_t[2];
arch/arm/include/asm/pgtable-3level-types.h:typedef struct { pgdval_t pgd; } pgd_t;
arch/arm/include/asm/pgtable-3level-types.h:typedef pgdval_t pgd_t;

I guess it might need different pgdp_get() variants depending applicable pgd_t
definition. Will continue looking into this further but meanwhile copied Russel
King in case he might be able to give some direction.


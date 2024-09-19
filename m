Return-Path: <linux-fsdevel+bounces-29691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D3997C4C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297A71C227EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 07:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF761925BD;
	Thu, 19 Sep 2024 07:21:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C518BC04;
	Thu, 19 Sep 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730508; cv=none; b=Z7ofzgU28ZuLG2nGI/fOKHiOlxGgE3DyK35zv7rHLqC6/9bfE+qsPRhr5MWctztri64d4Q9qn6xBGd3Kcs7GGgDdi8sXzhLuF8XqoHEWlcZhPC9q8zzKVnLIH8RCCzT/z2XkwQpEX2iF+k79AD6CX/VNzvE2gAUTFFP/CnogWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730508; c=relaxed/simple;
	bh=VAlXauhmpJIBCNb5x68k00aw24L/Vnm6Od+3QyvKnkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsaXWCcOnaTz6ZGDL28JmDhKwC16cKx2VGIVT8lCOwDn/3diA9+vpE2jeQ1U7ukf9jSdFDLwsRQiBt48kK0fM2IXiZRJvmSZHexrd1Iz5atjXMT5KQ71CmGeVukYvi2qzNIeYje8K8Ucduxe2wIrqMZ7zUMAwjFC6DhptPD7rOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56B1A13D5;
	Thu, 19 Sep 2024 00:22:15 -0700 (PDT)
Received: from [10.163.34.169] (unknown [10.163.34.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5A43F64C;
	Thu, 19 Sep 2024 00:21:37 -0700 (PDT)
Message-ID: <b0548a9f-6201-47e3-81cd-0d3b1de0a8e5@arm.com>
Date: Thu, 19 Sep 2024 12:51:33 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/7] mm: Use pmdp_get() for accessing PMD entries
To: kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
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
 <202409190205.YJ5gtx3T-lkp@intel.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202409190205.YJ5gtx3T-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/19/24 00:27, kernel test robot wrote:
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
> config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240919/202409190205.YJ5gtx3T-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240919/202409190205.YJ5gtx3T-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409190205.YJ5gtx3T-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from mm/pgtable-generic.c:10:
>    In file included from include/linux/pagemap.h:11:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      548 |         val = __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>          |                                                   ^
>    In file included from mm/pgtable-generic.c:10:
>    In file included from include/linux/pagemap.h:11:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>          |                                                   ^
>    In file included from mm/pgtable-generic.c:10:
>    In file included from include/linux/pagemap.h:11:
>    In file included from include/linux/highmem.h:12:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      585 |         __raw_writeb(value, PCI_IOBASE + addr);
>          |                             ~~~~~~~~~~ ^
>    include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      693 |         readsb(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      701 |         readsw(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      709 |         readsl(PCI_IOBASE + addr, buffer, count);
>          |                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      718 |         writesb(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      727 |         writesw(PCI_IOBASE + addr, buffer, count);
>          |                 ~~~~~~~~~~ ^
>    include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      736 |         writesl(PCI_IOBASE + addr, buffer, count);

Not sure if the above warnings are actually caused by this patch.

>          |                 ~~~~~~~~~~ ^
>>> mm/pgtable-generic.c:54:2: error: cannot take the address of an rvalue of type 'pgd_t'
>       54 |         pmd_ERROR(pmdp_get(pmd));
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/pgtable-nopmd.h:36:28: note: expanded from macro 'pmd_ERROR'
>       36 | #define pmd_ERROR(pmd)                          (pud_ERROR((pmd).pud))
>          |                                                  ^~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/pgtable-nopud.h:32:28: note: expanded from macro 'pud_ERROR'
>       32 | #define pud_ERROR(pud)                          (p4d_ERROR((pud).p4d))
>          |                                                  ^~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/pgtable-nop4d.h:25:28: note: expanded from macro 'p4d_ERROR'
>       25 | #define p4d_ERROR(p4d)                          (pgd_ERROR((p4d).pgd))
>          |                                                  ^~~~~~~~~~~~~~~~~~~~
>    arch/um/include/asm/pgtable-2level.h:31:67: note: expanded from macro 'pgd_ERROR'
>       31 |         printk("%s:%d: bad pgd %p(%08lx).\n", __FILE__, __LINE__, &(e), \
>          |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>       32 |                pgd_val(e))
>          |                ~~~~~~~~~~~
>    include/linux/printk.h:465:60: note: expanded from macro 'printk'
>      465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>          |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
>    include/linux/printk.h:437:19: note: expanded from macro 'printk_index_wrap'
>      437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                                 ^~~~~~~~~~~
>    12 warnings and 1 error generated.
> 
> 
> vim +/pgd_t +54 mm/pgtable-generic.c
> 
>     46	
>     47	/*
>     48	 * Note that the pmd variant below can't be stub'ed out just as for p4d/pud
>     49	 * above. pmd folding is special and typically pmd_* macros refer to upper
>     50	 * level even when folded
>     51	 */
>     52	void pmd_clear_bad(pmd_t *pmd)
>     53	{
>   > 54		pmd_ERROR(pmdp_get(pmd));
>     55		pmd_clear(pmd);
>     56	}
>     57	
> 

But the above build error can be fixed with the following change.

diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 8a5032ec231f..f442c1e3156a 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -43,13 +43,13 @@
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 
 #define pte_ERROR(e) \
-        printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+        printk("%s:%d: bad pte (%016lx).\n", __FILE__, __LINE__, \
               pte_val(e))
 #define pmd_ERROR(e) \
-        printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+        printk("%s:%d: bad pmd (%016lx).\n", __FILE__, __LINE__, \
               pmd_val(e))
 #define pgd_ERROR(e) \
-        printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+        printk("%s:%d: bad pgd (%016lx).\n", __FILE__, __LINE__, \
               pgd_val(e))
 
 #define pud_none(x)    (!(pud_val(x) & ~_PAGE_NEWPAGE))


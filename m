Return-Path: <linux-fsdevel+bounces-29670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96797C04B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 21:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FF01F2246D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372D01CA691;
	Wed, 18 Sep 2024 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdAgvYU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72E1C9848;
	Wed, 18 Sep 2024 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686528; cv=none; b=RUabuT9MalgilKzR6+XVQFblbRdWHGbg724xfXYCUSSdto4VI5DMrbDrSsMDw8vxtIRsyCf6BkyXTzb9X1i/b+v06jqPIlyo4yr8VviIZKUBNuxWmdt/dKMZqVED1EV10PMpJmHlK0NAf2otXwUfJUp74mH4sDCFA6Jh3dJWbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686528; c=relaxed/simple;
	bh=jiSr/3bRQvO46NDAj1FS7wvhNJZPRxUey4jB9tQEUxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdfT+6jtD0hqfocUQOxj68DBV1Qb5zguBN3tisUkp6HyiSGR3KxXTp1fT3Wfu08M8zevccFUgCKF15w75gCSiPHcjxa1okQgvti0XbFLlS9rX+t7SIsrGtU+08xiuQ9b8k0fpdiBYrKyk0iiYJTcGI56XQli3zAqL5g4iJp4qew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdAgvYU0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726686527; x=1758222527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jiSr/3bRQvO46NDAj1FS7wvhNJZPRxUey4jB9tQEUxI=;
  b=PdAgvYU0o3OQGDX68JqjyfnQm/Xpqhb1NCg9cWZ7CXk9A60EkzHgDYbl
   mwbg/frT7rUViUG9pGe07p/xnFMi9qgzgbucXa5SxBd4sNuWr1yP//MmI
   f1DB70vx9GH0sWGRVS4YIJuoH5+L/xd0nr54sD/hpOrnaDGKo8+Lp38WA
   4nAelBsDsJjiPLZzNeI8+ZhfIBzqck7aI9aTQ9KFCNR/idpV3vmpt1xCx
   Ki0y2MyHmldfU1Qp0GMmDeMG6e16si8CtGYSfToE37Sq1t+FHlrk8mOyy
   rJEY7hoE6q0ybxG6o7crZExu1mTzQyvR+fzjriNYXISTSv3aEo7i7gOda
   w==;
X-CSE-ConnectionGUID: NYGkuzGOQi2TAq8HTRxHeQ==
X-CSE-MsgGUID: hDOMIjuFRVSyPjxkULzy7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="36194252"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="36194252"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 12:08:44 -0700
X-CSE-ConnectionGUID: E2/7ThRkRaOBRTJVwSLyGw==
X-CSE-MsgGUID: OO27+qXXTP69v+TQeImesw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="92975592"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Sep 2024 12:08:39 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sr02W-000CXe-0w;
	Wed, 18 Sep 2024 19:08:36 +0000
Date: Thu, 19 Sep 2024 03:07:42 +0800
From: kernel test robot <lkp@intel.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 4/7] mm: Use pmdp_get() for accessing PMD entries
Message-ID: <202409190244.JcrD4CwD-lkp@intel.com>
References: <20240917073117.1531207-5-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917073117.1531207-5-anshuman.khandual@arm.com>

Hi Anshuman,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus brauner-vfs/vfs.all dennis-percpu/for-next linus/master v6.11]
[cannot apply to akpm-mm/mm-everything next-20240918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/m68k-mm-Change-pmd_val/20240917-153331
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240917073117.1531207-5-anshuman.khandual%40arm.com
patch subject: [PATCH V2 4/7] mm: Use pmdp_get() for accessing PMD entries
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240919/202409190244.JcrD4CwD-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240919/202409190244.JcrD4CwD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409190244.JcrD4CwD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/openrisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from include/linux/pagemap.h:8,
                    from mm/pgtable-generic.c:10:
   mm/pgtable-generic.c: In function 'pmd_clear_bad':
>> arch/openrisc/include/asm/pgtable.h:369:36: error: lvalue required as unary '&' operand
     369 |                __FILE__, __LINE__, &(e), pgd_val(e))
         |                                    ^
   include/linux/printk.h:437:33: note: in definition of macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   arch/openrisc/include/asm/pgtable.h:368:9: note: in expansion of macro 'printk'
     368 |         printk(KERN_ERR "%s:%d: bad pgd %p(%08lx).\n", \
         |         ^~~~~~
   include/asm-generic/pgtable-nop4d.h:25:50: note: in expansion of macro 'pgd_ERROR'
      25 | #define p4d_ERROR(p4d)                          (pgd_ERROR((p4d).pgd))
         |                                                  ^~~~~~~~~
   include/asm-generic/pgtable-nopud.h:32:50: note: in expansion of macro 'p4d_ERROR'
      32 | #define pud_ERROR(pud)                          (p4d_ERROR((pud).p4d))
         |                                                  ^~~~~~~~~
   include/asm-generic/pgtable-nopmd.h:36:50: note: in expansion of macro 'pud_ERROR'
      36 | #define pmd_ERROR(pmd)                          (pud_ERROR((pmd).pud))
         |                                                  ^~~~~~~~~
   mm/pgtable-generic.c:54:9: note: in expansion of macro 'pmd_ERROR'
      54 |         pmd_ERROR(pmdp_get(pmd));
         |         ^~~~~~~~~


vim +369 arch/openrisc/include/asm/pgtable.h

61e85e367535a7 Jonas Bonn 2011-06-04  363  
61e85e367535a7 Jonas Bonn 2011-06-04  364  #define pte_ERROR(e) \
61e85e367535a7 Jonas Bonn 2011-06-04  365  	printk(KERN_ERR "%s:%d: bad pte %p(%08lx).\n", \
61e85e367535a7 Jonas Bonn 2011-06-04  366  	       __FILE__, __LINE__, &(e), pte_val(e))
61e85e367535a7 Jonas Bonn 2011-06-04  367  #define pgd_ERROR(e) \
61e85e367535a7 Jonas Bonn 2011-06-04  368  	printk(KERN_ERR "%s:%d: bad pgd %p(%08lx).\n", \
61e85e367535a7 Jonas Bonn 2011-06-04 @369  	       __FILE__, __LINE__, &(e), pgd_val(e))
61e85e367535a7 Jonas Bonn 2011-06-04  370  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


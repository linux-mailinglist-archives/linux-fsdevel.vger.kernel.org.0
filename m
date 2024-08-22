Return-Path: <linux-fsdevel+bounces-26788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1749095BAEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8D6B24BC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6321CC880;
	Thu, 22 Aug 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSuJDmEp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E61EEE3
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341701; cv=none; b=YNqk1S7Yepkull8KBWTV/la9PM2NLsMELNY9DTatfPQa0CYordvnFFZy6KInBMh6AcPxFmLX/pG1/VPZZE0uWnNSN/9n3bl+UN1+cto0Pf/Iamy7Z3V5Jzd44UzbvzaQ8IZKTpkhGht+am5Dn4Xhuo7jdojYu8htCCM1TPhiPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341701; c=relaxed/simple;
	bh=MjMjpWVrOz+O8htmSr9RFUj1g+A9bVqWtgL1r0TVOrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGiBhClN18OKuo33wWdyHl6af1dlZFw0RiFBI7Dk+SrTlOq0W9V18EZ+s2bj8/bezZvyk3Y2SYt947+vB24bYhxEbpKag0AlJAVuttNu+IgIK8qpbeAj4kdaMh1wPBBZ682jfjmJBOcrHYVEMbogHc1bH0WhuJzG1duBaxqfD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSuJDmEp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724341700; x=1755877700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MjMjpWVrOz+O8htmSr9RFUj1g+A9bVqWtgL1r0TVOrA=;
  b=QSuJDmEp+gVKg9ZfZryuDbrq/DX4Ogl8ruZsspASieMEKHxAgbd3OgBX
   Ds1wORjK/7W96lx+G6ElEGQo+8/M/AjXMZJyadEdSwIWWasx5J50Z8dNG
   iifh6wUZbl7VOM53Mk/QeT6t/6TlZsONO+ak+R1baYv9FQANIj5Qy5+f5
   7JvAFCFRTnGz0YwbLHW2izPmX+YzGbtd9VIwoB7iX2pNDGAi/bJkD6HbA
   1NpXzMzQoAjpy/P2Jf7gU19eHCL/Kfa1aNo/Gikww0Z72swDkf4xGkT7Q
   wg+pYjktM90LyMkLKrzTIm575JcC7pKCygRAwYhyZC0WKxEm/hHAQmqwV
   w==;
X-CSE-ConnectionGUID: aQctoJTLR/WNJP0G50xcpg==
X-CSE-MsgGUID: uTW1LtUSSemKJmJTbuqEMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26520131"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="26520131"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:48:19 -0700
X-CSE-ConnectionGUID: tf/E7vG4T/q7CoRjEHkc9A==
X-CSE-MsgGUID: 3FS5+AGpR2+XsOBvkOTRhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="65830071"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Aug 2024 08:48:17 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shA2p-000Cwa-0E;
	Thu, 22 Aug 2024 15:48:15 +0000
Date: Thu, 22 Aug 2024 23:47:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 01/10] mm: Remove PageActive
Message-ID: <202408222357.ksCAhSZQ-lkp@intel.com>
References: <20240821193445.2294269-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821193445.2294269-2-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on arm64/for-next/core tip/x86/core tip/x86/mm linus/master v6.11-rc4 next-20240822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Remove-PageActive/20240822-033717
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240821193445.2294269-2-willy%40infradead.org
patch subject: [PATCH 01/10] mm: Remove PageActive
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240822/202408222357.ksCAhSZQ-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408222357.ksCAhSZQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408222357.ksCAhSZQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/mm/pgtable-frag.c:10:
   In file included from include/linux/mm.h:2199:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/mm/pgtable-frag.c:142:2: error: call to undeclared function 'SetPageActive'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     142 |         SetPageActive(page);
         |         ^
   4 warnings and 1 error generated.


vim +/SetPageActive +142 arch/powerpc/mm/pgtable-frag.c

32cc0b7c9d508e Hugh Dickins 2023-07-11  135  
32cc0b7c9d508e Hugh Dickins 2023-07-11  136  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
32cc0b7c9d508e Hugh Dickins 2023-07-11  137  void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
32cc0b7c9d508e Hugh Dickins 2023-07-11  138  {
32cc0b7c9d508e Hugh Dickins 2023-07-11  139  	struct page *page;
32cc0b7c9d508e Hugh Dickins 2023-07-11  140  
32cc0b7c9d508e Hugh Dickins 2023-07-11  141  	page = virt_to_page(pgtable);
32cc0b7c9d508e Hugh Dickins 2023-07-11 @142  	SetPageActive(page);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


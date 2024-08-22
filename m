Return-Path: <linux-fsdevel+bounces-26724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4B95B677
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E642848BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8681CB151;
	Thu, 22 Aug 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jd9E+dne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42D1CB121
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332992; cv=none; b=B3K6/Bi4EISYY6vkBdIvJJfBxmrxl4bMxT7g2kHqnYKOGO75SsBMyXuHd/HIRrbVhcDveK/oCyP2T2JQ6K/fCzatuvjxAeFJryIQga7n7zw4rDAiLxzH3cEkE6e9hEvTiBkT+wBTccB1z0xbYx2z+IFtmXE+5Ckp74SPpN/Gdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332992; c=relaxed/simple;
	bh=ihfoIIwBY7vjnM53NdhthRQd9G4rdan23hMoqFFnwRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJrUHSzDqU1Jqb2uZSj7Pzi6jcUKDS5SqihUBt2fz+NWN6neORSTsezlSrXsS01J8BXZokHjEx1eH2AgVotv1TiDuSfuRdqM9o1s3VsoO4+BoI3yb5I93M8Q3YyuUjzNHht9eW4wIMaYxGeIr5f/vsJlYqbE8YWOB2493PwqJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jd9E+dne; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724332990; x=1755868990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ihfoIIwBY7vjnM53NdhthRQd9G4rdan23hMoqFFnwRU=;
  b=Jd9E+dneNRI2bU/rDxl6XkKCUhL0Gz4oIrLGunotQOdQDqe0jd4ajLJE
   MdXK6yJVSbjKDSRJ+NGvVnnP95EBf0lvzlEhXaVv4drB6pXP0od8eHy4L
   mj/A+jenO15Ow6q/gFNRDshhA1Wo1o6ylOzXq+JF/HIsk8ofQxWogdKpL
   qHWMq2M+r6FEdEIQoB2h4KetT6adOB0liwIqg10C6yFQMAjbaTTUwnZAs
   G+9xtH+/LRT1g7N5FaTXy8q1UTvbqR3HEbtsQ3nUnIqvqmj9681o4qcf5
   wkBuriBOIMVoHMCGRQLZEKqc4x8Ufm6uzdXr8M2xSJ7SSfYfhiv9YS1I6
   w==;
X-CSE-ConnectionGUID: JHKvpy5BRtK69vql1gRrLg==
X-CSE-MsgGUID: yL4dru9UR1mICNOaCfU75w==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33898396"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="33898396"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:23:09 -0700
X-CSE-ConnectionGUID: 2ZdZ/EYTT7aGUaUazgxAXw==
X-CSE-MsgGUID: vZp1On1BRwebNdaaRu+52A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="92186233"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Aug 2024 06:23:07 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sh7mL-000CmR-1O;
	Thu, 22 Aug 2024 13:23:05 +0000
Date: Thu, 22 Aug 2024 21:22:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 01/10] mm: Remove PageActive
Message-ID: <202408222044.zZMToCKk-lkp@intel.com>
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
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240822/202408222044.zZMToCKk-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408222044.zZMToCKk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408222044.zZMToCKk-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/mm/pgtable-frag.c: In function 'pte_free_defer':
>> arch/powerpc/mm/pgtable-frag.c:142:9: error: implicit declaration of function 'SetPageActive' [-Wimplicit-function-declaration]
     142 |         SetPageActive(page);
         |         ^~~~~~~~~~~~~


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


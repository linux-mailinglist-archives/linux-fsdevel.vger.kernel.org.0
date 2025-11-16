Return-Path: <linux-fsdevel+bounces-68622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C43CFC61EA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 23:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F4D84E4475
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 22:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3796030E843;
	Sun, 16 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tz8+GG+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00783090E8;
	Sun, 16 Nov 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763332755; cv=none; b=hOkKdbtCDRYwOUkqGyK5k8PLigtm8AewA5MPieTnlkTvnaJp/X57ntRIacOfWJpR/+P2ZnUU7uxzb5UN7J/rTTHFueXholHhCkgy+GgRutqrM6QD33x6gR0qacsAjaB8vObHt/hGtExEVePCGL96WNecxOi6pmzA4hqfuu+h5Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763332755; c=relaxed/simple;
	bh=axivBqRhfsA8y2ZQJpQxZddTtACDe6CgCnQ3nRedy3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJEGqYeGrF0R+XGAUdmZ1fWhmU94OCnwZCst2ILgiD8CQ4fG1D1G19YfT320LsurOyRiR45OPdJT5rwuiHrA/S3cKFzjIbhHGZRvRBPF8uqDNTzFLQubAmUtiYir19V8851n0OxeoQ6lgnP/ZT5bGeN0eD73/xLs5bKXEiUX6Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tz8+GG+W; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763332754; x=1794868754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axivBqRhfsA8y2ZQJpQxZddTtACDe6CgCnQ3nRedy3c=;
  b=Tz8+GG+WqZlaDixKcnaz6REF9BLclHBTh3sBUUxKH/8Tiw+x+d/4waPM
   PQaSgngZvCFzKNozfySj6nO84Tpv/cSSvmVMOwcxEKuNP9XQp+1X4ZZv9
   yPCpbnPDIel/ADE9jgKCzwVSxtRRebEH6gXpx62D3qqAdJzn8SmRUNDxX
   IgQAzNQn0Qe0DwFnTjAAWe2oocARIoDq9953WoCvw8dBCRSiSFzvByfLf
   o7vWkdwRDhfMRX532fHV5tvPqauXjmzWfwtZWp2O2JwdO2xXRMQePWWWo
   54v43UK5v7sOLglUhtfTnzLNKgAe8hcZFytJ8Ji/MS26W9kEwFCGyKB1v
   g==;
X-CSE-ConnectionGUID: b3PEV4UTSrOxJXYaS7CVjA==
X-CSE-MsgGUID: jq3MxouYRM2frvebPZgQqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="75654070"
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="75654070"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 14:39:13 -0800
X-CSE-ConnectionGUID: nPGUdiYcQvOTOddza7SVMA==
X-CSE-MsgGUID: JCCZNBKkRAaEd7ykp321+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="195434281"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Nov 2025 14:39:09 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKlOk-00097p-1a;
	Sun, 16 Nov 2025 22:39:06 +0000
Date: Mon, 17 Nov 2025 06:38:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
	linmiaohe@huawei.com, ziy@nvidia.com
Cc: oe-kbuild-all@lists.linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, william.roche@oracle.com,
	harry.yoo@oracle.com, tony.luck@intel.com,
	wangkefeng.wang@huawei.com, willy@infradead.org,
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de,
	muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce
 uniform_split_unmapped_folio_to_zero_order
Message-ID: <202511170614.JnCyqo45-lkp@intel.com>
References: <20251116014721.1561456-2-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116014721.1561456-2-jiaqiyan@google.com>

Hi Jiaqi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc5]
[cannot apply to akpm-mm/mm-everything next-20251114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaqi-Yan/mm-huge_memory-introduce-uniform_split_unmapped_folio_to_zero_order/20251116-094846
base:   linus/master
patch link:    https://lore.kernel.org/r/20251116014721.1561456-2-jiaqiyan%40google.com
patch subject: [PATCH v1 1/2] mm/huge_memory: introduce uniform_split_unmapped_folio_to_zero_order
config: arc-randconfig-001-20251117 (https://download.01.org/0day-ci/archive/20251117/202511170614.JnCyqo45-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251117/202511170614.JnCyqo45-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511170614.JnCyqo45-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/mm.h:6,
                    from arch/arc/kernel/asm-offsets.c:8:
   include/linux/huge_mm.h: In function 'uniform_split_unmapped_folio_to_zero_order':
>> include/linux/huge_mm.h:575:33: error: 'page' undeclared (first use in this function)
     575 |         VM_WARN_ON_ONCE_PAGE(1, page);
         |                                 ^~~~
   include/linux/mmdebug.h:55:27: note: in definition of macro 'VM_WARN_ON_ONCE_PAGE'
      55 |                 dump_page(page, "VM_WARN_ON_ONCE_PAGE(" __stringify(cond)")");\
         |                           ^~~~
   include/linux/huge_mm.h:575:33: note: each undeclared identifier is reported only once for each function it appears in
     575 |         VM_WARN_ON_ONCE_PAGE(1, page);
         |                                 ^~~~
   include/linux/mmdebug.h:55:27: note: in definition of macro 'VM_WARN_ON_ONCE_PAGE'
      55 |                 dump_page(page, "VM_WARN_ON_ONCE_PAGE(" __stringify(cond)")");\
         |                           ^~~~
   make[3]: *** [scripts/Makefile.build:182: arch/arc/kernel/asm-offsets.s] Error 1 shuffle=3849756084
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1280: prepare0] Error 2 shuffle=3849756084
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=3849756084
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=3849756084
   make: Target 'prepare' not remade because of errors.


vim +/page +575 include/linux/huge_mm.h

   567	
   568	static inline bool
   569	can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
   570	{
   571		return false;
   572	}
   573	static inline int uniform_split_unmapped_folio_to_zero_order(struct folio *folio)
   574	{
 > 575		VM_WARN_ON_ONCE_PAGE(1, page);
   576		return -EINVAL;
   577	}
   578	static inline int
   579	split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
   580			unsigned int new_order)
   581	{
   582		VM_WARN_ON_ONCE_PAGE(1, page);
   583		return -EINVAL;
   584	}
   585	static inline int split_huge_page(struct page *page)
   586	{
   587		VM_WARN_ON_ONCE_PAGE(1, page);
   588		return -EINVAL;
   589	}
   590	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


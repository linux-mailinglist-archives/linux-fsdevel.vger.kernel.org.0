Return-Path: <linux-fsdevel+bounces-58808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF48AB31A2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A1D189F51A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199233043CE;
	Fri, 22 Aug 2025 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqeO1ozl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75632303CBD;
	Fri, 22 Aug 2025 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870397; cv=none; b=R9zcu7yEjiNVNuIOAB04QNcahizGsbVlOWTl5pLH5kYk/gNSsn7w96oDoDdy99A1AEvlor7ZdhpkibhNyq2rGTr8P1ZaORz7fnNwOjmqianGcIzzuoai9ChwOAOgFJewNsnysp0HWfVQOmiQ7Yq9i736fWAKqf6dI/PAZ7+GXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870397; c=relaxed/simple;
	bh=J0+pZ+2m0Dv0vL74QouwXOMlr21iON6x4zZIvX0pgZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIdHAh8hWDhabL9kX6Bv0La4XqHbNI0RtbRD3Flqu5WTkcmlrGPsVhxuX99sKsJgYwxByBoC6UbvkGNl+bFXoUWBid/BKcvj6D6I3e5KSMS6IPb/fNCHig+o78f8MEFmZG8hMKQbfLma2fnxMZtp8QGzQFM/yWfftbEiYIebQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqeO1ozl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755870394; x=1787406394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J0+pZ+2m0Dv0vL74QouwXOMlr21iON6x4zZIvX0pgZY=;
  b=NqeO1ozluqGhg3koB5VOIXGtmPtp39Hme+zyoIaoCfYVJ+2c6Pndudym
   5B9Np3PeZThqkzc1QI7+yOdcdcSlt4BrglflgazySTn6U4wXWJDEYC5eI
   IX3geefshO9pM3YhmYJiOH8d9zqi2H3QBQSvODqlXgQfNPf4PBJ4HS5ST
   eY2aEikxpePBQZJGGNvrmgxXvWegQULppBGokKodT061yDg3lphrkBSUD
   p2T/z/S2ycfX4FGxZLHthxWdi1g2QMNcFcCOrjWJgiY8q/Mkfqd2RD0wi
   4L4tNZqA2FG2XAH9ftM9kZoFM0SWCWf+Q1HgvTkIqrfyoNE41AI4GWybN
   w==;
X-CSE-ConnectionGUID: QnIdLKXvT32OKzJOXi9A4Q==
X-CSE-MsgGUID: 4Jfs9foVSVCL6IkuHdIylg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58127713"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58127713"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 06:46:33 -0700
X-CSE-ConnectionGUID: ZLmg3LI9Ra+rLL4muaRPrQ==
X-CSE-MsgGUID: DpwzIgtRQ9iTSF6OFHtLtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168614614"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Aug 2025 06:46:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upS68-000LLR-27;
	Fri, 22 Aug 2025 13:46:28 +0000
Date: Fri, 22 Aug 2025 21:46:04 +0800
From: kernel test robot <lkp@intel.com>
To: Boris Burkov <boris@bur.io>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com, shakeel.butt@linux.dev, wqu@suse.com,
	willy@infradead.org, mhocko@kernel.org, muchun.song@linux.dev,
	roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v4 1/3] mm/filemap: add AS_KERNEL_FILE
Message-ID: <202508222105.tg88NxnV-lkp@intel.com>
References: <f09c4e2c90351d4cb30a1969f7a863b9238bd291.1755812945.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f09c4e2c90351d4cb30a1969f7a863b9238bd291.1755812945.git.boris@bur.io>

Hi Boris,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on kdave/for-next linus/master v6.17-rc2 next-20250822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Boris-Burkov/mm-filemap-add-AS_KERNEL_FILE/20250822-055741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/f09c4e2c90351d4cb30a1969f7a863b9238bd291.1755812945.git.boris%40bur.io
patch subject: [PATCH v4 1/3] mm/filemap: add AS_KERNEL_FILE
config: x86_64-buildonly-randconfig-006-20250822 (https://download.01.org/0day-ci/archive/20250822/202508222105.tg88NxnV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508222105.tg88NxnV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508222105.tg88NxnV-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/filemap.c: In function 'filemap_add_folio':
>> mm/filemap.c:967:40: error: 'root_mem_cgroup' undeclared (first use in this function); did you mean 'parent_mem_cgroup'?
     967 |                 tmp = set_active_memcg(root_mem_cgroup);
         |                                        ^~~~~~~~~~~~~~~
         |                                        parent_mem_cgroup
   mm/filemap.c:967:40: note: each undeclared identifier is reported only once for each function it appears in


vim +967 mm/filemap.c

   957	
   958	int filemap_add_folio(struct address_space *mapping, struct folio *folio,
   959					pgoff_t index, gfp_t gfp)
   960	{
   961		void *shadow = NULL;
   962		int ret;
   963		struct mem_cgroup *tmp;
   964		bool kernel_file = test_bit(AS_KERNEL_FILE, &mapping->flags);
   965	
   966		if (kernel_file)
 > 967			tmp = set_active_memcg(root_mem_cgroup);
   968		ret = mem_cgroup_charge(folio, NULL, gfp);
   969		if (kernel_file)
   970			set_active_memcg(tmp);
   971		if (ret)
   972			return ret;
   973	
   974		__folio_set_locked(folio);
   975		ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
   976		if (unlikely(ret)) {
   977			mem_cgroup_uncharge(folio);
   978			__folio_clear_locked(folio);
   979		} else {
   980			/*
   981			 * The folio might have been evicted from cache only
   982			 * recently, in which case it should be activated like
   983			 * any other repeatedly accessed folio.
   984			 * The exception is folios getting rewritten; evicting other
   985			 * data from the working set, only to cache data that will
   986			 * get overwritten with something else, is a waste of memory.
   987			 */
   988			WARN_ON_ONCE(folio_test_active(folio));
   989			if (!(gfp & __GFP_WRITE) && shadow)
   990				workingset_refault(folio, shadow);
   991			folio_add_lru(folio);
   992		}
   993		return ret;
   994	}
   995	EXPORT_SYMBOL_GPL(filemap_add_folio);
   996	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


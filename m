Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A469B6FE84E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 02:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjEKAF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 20:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjEKAF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 20:05:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C03A85;
        Wed, 10 May 2023 17:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683763554; x=1715299554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f4m0KrKFZizelSk4rn1WQzUKjIw/z/A6Lc1teZbLrT0=;
  b=btiiRh043LfM/U6nqo4XNw+NEKu5WZ+WB1O8K5rh1rhFMwYVaebS5wRc
   cgBIhF0qD/sImn4GcWze00lXKOTxfGGWdu1vp5cpGDm9c0TR2oMvDJFo1
   FPsd45Re4te7o+juMfYGh1fGx228FGruSrEYd04Q/L3J+ChqAcqxTfimN
   r/6SgGspcEG9SiI1W8BL24iLZP8QPhuSGlIihwf6DjxTMk8UTQx8rFL9m
   dEfhV611sh3rYvY80deshNvA8/5iyZt82JvOZF0Qpy/G86b/nho8Uoxwf
   b963zb5zFRaN77yf4NkWilaO+AEwGicHPB5xMGx/7Ety+VIa3GwtHbMFp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="350384794"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="350384794"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 17:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="730119715"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="730119715"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 May 2023 17:05:49 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwtob-0003fM-0E;
        Thu, 11 May 2023 00:05:49 +0000
Date:   Thu, 11 May 2023 08:04:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 04/12] mm: page_alloc: collect mem statistic into
 show_mem.c
Message-ID: <202305110807.YVsoVagW-lkp@intel.com>
References: <20230508071200.123962-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508071200.123962-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kefeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-page_alloc-move-mirrored_kernelcore-into-mm_init-c/20230508-145724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230508071200.123962-5-wangkefeng.wang%40huawei.com
patch subject: [PATCH 04/12] mm: page_alloc: collect mem statistic into show_mem.c
config: loongarch-randconfig-s051-20230509 (https://download.01.org/0day-ci/archive/20230511/202305110807.YVsoVagW-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/be69df472e4d9a6b09a17b854d3aeb9722fc2675
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kefeng-Wang/mm-page_alloc-move-mirrored_kernelcore-into-mm_init-c/20230508-145724
        git checkout be69df472e4d9a6b09a17b854d3aeb9722fc2675
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305110807.YVsoVagW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/show_mem.c:336:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/show_mem.c:336:17: sparse:     expected void *ptr
   mm/show_mem.c:336:17: sparse:     got int [noderef] __percpu *
>> mm/show_mem.c:336:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/show_mem.c:336:17: sparse:     expected void *ptr
   mm/show_mem.c:336:17: sparse:     got int [noderef] __percpu *
>> mm/show_mem.c:336:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/show_mem.c:336:17: sparse:     expected void *ptr
   mm/show_mem.c:336:17: sparse:     got int [noderef] __percpu *
>> mm/show_mem.c:336:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/show_mem.c:336:17: sparse:     expected void *ptr
   mm/show_mem.c:336:17: sparse:     got int [noderef] __percpu *

vim +336 mm/show_mem.c

   207	
   208	/*
   209	 * Show free area list (used inside shift_scroll-lock stuff)
   210	 * We also calculate the percentage fragmentation. We do this by counting the
   211	 * memory on each free list with the exception of the first item on the list.
   212	 *
   213	 * Bits in @filter:
   214	 * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
   215	 *   cpuset.
   216	 */
   217	void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
   218	{
   219		unsigned long free_pcp = 0;
   220		int cpu, nid;
   221		struct zone *zone;
   222		pg_data_t *pgdat;
   223	
   224		for_each_populated_zone(zone) {
   225			if (zone_idx(zone) > max_zone_idx)
   226				continue;
   227			if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
   228				continue;
   229	
   230			for_each_online_cpu(cpu)
   231				free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
   232		}
   233	
   234		printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
   235			" active_file:%lu inactive_file:%lu isolated_file:%lu\n"
   236			" unevictable:%lu dirty:%lu writeback:%lu\n"
   237			" slab_reclaimable:%lu slab_unreclaimable:%lu\n"
   238			" mapped:%lu shmem:%lu pagetables:%lu\n"
   239			" sec_pagetables:%lu bounce:%lu\n"
   240			" kernel_misc_reclaimable:%lu\n"
   241			" free:%lu free_pcp:%lu free_cma:%lu\n",
   242			global_node_page_state(NR_ACTIVE_ANON),
   243			global_node_page_state(NR_INACTIVE_ANON),
   244			global_node_page_state(NR_ISOLATED_ANON),
   245			global_node_page_state(NR_ACTIVE_FILE),
   246			global_node_page_state(NR_INACTIVE_FILE),
   247			global_node_page_state(NR_ISOLATED_FILE),
   248			global_node_page_state(NR_UNEVICTABLE),
   249			global_node_page_state(NR_FILE_DIRTY),
   250			global_node_page_state(NR_WRITEBACK),
   251			global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B),
   252			global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
   253			global_node_page_state(NR_FILE_MAPPED),
   254			global_node_page_state(NR_SHMEM),
   255			global_node_page_state(NR_PAGETABLE),
   256			global_node_page_state(NR_SECONDARY_PAGETABLE),
   257			global_zone_page_state(NR_BOUNCE),
   258			global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
   259			global_zone_page_state(NR_FREE_PAGES),
   260			free_pcp,
   261			global_zone_page_state(NR_FREE_CMA_PAGES));
   262	
   263		for_each_online_pgdat(pgdat) {
   264			if (show_mem_node_skip(filter, pgdat->node_id, nodemask))
   265				continue;
   266			if (!node_has_managed_zones(pgdat, max_zone_idx))
   267				continue;
   268	
   269			printk("Node %d"
   270				" active_anon:%lukB"
   271				" inactive_anon:%lukB"
   272				" active_file:%lukB"
   273				" inactive_file:%lukB"
   274				" unevictable:%lukB"
   275				" isolated(anon):%lukB"
   276				" isolated(file):%lukB"
   277				" mapped:%lukB"
   278				" dirty:%lukB"
   279				" writeback:%lukB"
   280				" shmem:%lukB"
   281	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
   282				" shmem_thp: %lukB"
   283				" shmem_pmdmapped: %lukB"
   284				" anon_thp: %lukB"
   285	#endif
   286				" writeback_tmp:%lukB"
   287				" kernel_stack:%lukB"
   288	#ifdef CONFIG_SHADOW_CALL_STACK
   289				" shadow_call_stack:%lukB"
   290	#endif
   291				" pagetables:%lukB"
   292				" sec_pagetables:%lukB"
   293				" all_unreclaimable? %s"
   294				"\n",
   295				pgdat->node_id,
   296				K(node_page_state(pgdat, NR_ACTIVE_ANON)),
   297				K(node_page_state(pgdat, NR_INACTIVE_ANON)),
   298				K(node_page_state(pgdat, NR_ACTIVE_FILE)),
   299				K(node_page_state(pgdat, NR_INACTIVE_FILE)),
   300				K(node_page_state(pgdat, NR_UNEVICTABLE)),
   301				K(node_page_state(pgdat, NR_ISOLATED_ANON)),
   302				K(node_page_state(pgdat, NR_ISOLATED_FILE)),
   303				K(node_page_state(pgdat, NR_FILE_MAPPED)),
   304				K(node_page_state(pgdat, NR_FILE_DIRTY)),
   305				K(node_page_state(pgdat, NR_WRITEBACK)),
   306				K(node_page_state(pgdat, NR_SHMEM)),
   307	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
   308				K(node_page_state(pgdat, NR_SHMEM_THPS)),
   309				K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
   310				K(node_page_state(pgdat, NR_ANON_THPS)),
   311	#endif
   312				K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
   313				node_page_state(pgdat, NR_KERNEL_STACK_KB),
   314	#ifdef CONFIG_SHADOW_CALL_STACK
   315				node_page_state(pgdat, NR_KERNEL_SCS_KB),
   316	#endif
   317				K(node_page_state(pgdat, NR_PAGETABLE)),
   318				K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
   319				pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
   320					"yes" : "no");
   321		}
   322	
   323		for_each_populated_zone(zone) {
   324			int i;
   325	
   326			if (zone_idx(zone) > max_zone_idx)
   327				continue;
   328			if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
   329				continue;
   330	
   331			free_pcp = 0;
   332			for_each_online_cpu(cpu)
   333				free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
   334	
   335			show_node(zone);
 > 336			printk(KERN_CONT

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

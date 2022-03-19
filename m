Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412474DE6EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 09:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiCSIPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiCSIPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:15:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834A1F634E;
        Sat, 19 Mar 2022 01:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647677649; x=1679213649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5/j8SFIJOg+tuUIcMYd0AoAB00s/OJZR63GPCgz2T7U=;
  b=cm5JPduv9EzaGjf0A+41iIDDDzbznVjpCtXS5EMOK+t3LTyftbi6LCof
   RxGmI22renaR/ellaLGmR9hBZdyi0Tq9zQXjdfYmNMY60O7MkSDwaY7MX
   rjjHuMgCC0FYC/6a78VYpny1235gY8cMeP7D49CNgRVIYh1w7k678NUxa
   8AsfD8oWDhxd6RRRAX24PV3rkusZ+UwtoopotSi6IrWC1EBaACqhMJ9gf
   vuKq6YLSODovomEB52UpwypNh5WzGwSTl/LgkoSLe4siueRhOmFHdEk2O
   ERHUBHZeb1N/pkevKqgIavGHJXsZVPUvICyO7ON8TbR7TNS8hEmsXbk2u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="320491412"
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="320491412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 01:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="691598370"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 01:14:04 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVUDr-000Fiu-9z; Sat, 19 Mar 2022 08:14:03 +0000
Date:   Sat, 19 Mar 2022 16:13:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, david@fromorbit.com,
        djwong@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v6 2/6] x86/mce: relocate set{clear}_mce_nospec()
 functions
Message-ID: <202203191637.PK2oJUeq-lkp@intel.com>
References: <20220319062833.3136528-3-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319062833.3136528-3-jane.chu@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jane,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on nvdimm/libnvdimm-for-next]
[also build test WARNING on device-mapper-dm/for-next linus/master v5.17-rc8 next-20220318]
[cannot apply to tip/x86/mm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jane-Chu/DAX-poison-recovery/20220319-143144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220319/202203191637.PK2oJUeq-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/71b9b09529b207ce15667c1f5fba4b727b6754e6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jane-Chu/DAX-poison-recovery/20220319-143144
        git checkout 71b9b09529b207ce15667c1f5fba4b727b6754e6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/pat/ fs/fuse/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/pat/set_memory.c:1935:5: warning: no previous prototype for 'set_mce_nospec' [-Wmissing-prototypes]
    1935 | int set_mce_nospec(unsigned long pfn, bool unmap)
         |     ^~~~~~~~~~~~~~
>> arch/x86/mm/pat/set_memory.c:1968:5: warning: no previous prototype for 'clear_mce_nospec' [-Wmissing-prototypes]
    1968 | int clear_mce_nospec(unsigned long pfn)
         |     ^~~~~~~~~~~~~~~~


vim +/set_mce_nospec +1935 arch/x86/mm/pat/set_memory.c

  1927	
  1928	#ifdef CONFIG_X86_64
  1929	/*
  1930	 * Prevent speculative access to the page by either unmapping
  1931	 * it (if we do not require access to any part of the page) or
  1932	 * marking it uncacheable (if we want to try to retrieve data
  1933	 * from non-poisoned lines in the page).
  1934	 */
> 1935	int set_mce_nospec(unsigned long pfn, bool unmap)
  1936	{
  1937		unsigned long decoy_addr;
  1938		int rc;
  1939	
  1940		/* SGX pages are not in the 1:1 map */
  1941		if (arch_is_platform_page(pfn << PAGE_SHIFT))
  1942			return 0;
  1943		/*
  1944		 * We would like to just call:
  1945		 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
  1946		 * but doing that would radically increase the odds of a
  1947		 * speculative access to the poison page because we'd have
  1948		 * the virtual address of the kernel 1:1 mapping sitting
  1949		 * around in registers.
  1950		 * Instead we get tricky.  We create a non-canonical address
  1951		 * that looks just like the one we want, but has bit 63 flipped.
  1952		 * This relies on set_memory_XX() properly sanitizing any __pa()
  1953		 * results with __PHYSICAL_MASK or PTE_PFN_MASK.
  1954		 */
  1955		decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
  1956	
  1957		if (unmap)
  1958			rc = set_memory_np(decoy_addr, 1);
  1959		else
  1960			rc = set_memory_uc(decoy_addr, 1);
  1961		if (rc)
  1962			pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
  1963		return rc;
  1964	}
  1965	EXPORT_SYMBOL(set_mce_nospec);
  1966	
  1967	/* Restore full speculative operation to the pfn. */
> 1968	int clear_mce_nospec(unsigned long pfn)
  1969	{
  1970		return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
  1971	}
  1972	EXPORT_SYMBOL(clear_mce_nospec);
  1973	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889794DE70A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 09:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbiCSI0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiCSI0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:26:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77EE27CE29;
        Sat, 19 Mar 2022 01:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647678308; x=1679214308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cU11GNeosPZBQkVRru6KUOZgbrqb9oXf2R1mmb41wX8=;
  b=nUbblIjBgh5iYzbCT8+H9R0bogbl5Mjdn8yD1xCPy1Fi7Ub4N3mkVxMa
   FN80DRtYvvJYgYS4VcGcMm3zOJcUhjTVQ3yxTZLDRgQmeuf1n0VTAtxqw
   YlbKWdIyVtRd1EWFd4BO+TAbSCRO2njdfIa4528zPB+nlUlzqMLUvFqQb
   TFeFLhCA5dpMmpulaDuO1Qn6MWFL73Xd6iEmWAhpxeU6ilSr528mB3UKr
   XDW/Y9g4msxUC08b91LltEezmKQgOX15VX5i0tUiFV2PiP+a/DTFyU80E
   OI4l+ke5YucHsZRFxkRYUQ5D3Ckmx3kTi3HapXolAXtyTO1WBKFrbN5Ug
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343721168"
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="343721168"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 01:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="822924166"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2022 01:25:04 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVUOV-000FjU-HW; Sat, 19 Mar 2022 08:25:03 +0000
Date:   Sat, 19 Mar 2022 16:24:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, david@fromorbit.com,
        djwong@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v6 2/6] x86/mce: relocate set{clear}_mce_nospec()
 functions
Message-ID: <202203191603.mQUQZZV5-lkp@intel.com>
References: <20220319062833.3136528-3-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319062833.3136528-3-jane.chu@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220319/202203191603.mQUQZZV5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/71b9b09529b207ce15667c1f5fba4b727b6754e6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jane-Chu/DAX-poison-recovery/20220319-143144
        git checkout 71b9b09529b207ce15667c1f5fba4b727b6754e6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/pat/ fs/fuse/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/pat/set_memory.c:1935:5: warning: no previous prototype for function 'set_mce_nospec' [-Wmissing-prototypes]
   int set_mce_nospec(unsigned long pfn, bool unmap)
       ^
   arch/x86/mm/pat/set_memory.c:1935:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int set_mce_nospec(unsigned long pfn, bool unmap)
   ^
   static 
>> arch/x86/mm/pat/set_memory.c:1968:5: warning: no previous prototype for function 'clear_mce_nospec' [-Wmissing-prototypes]
   int clear_mce_nospec(unsigned long pfn)
       ^
   arch/x86/mm/pat/set_memory.c:1968:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int clear_mce_nospec(unsigned long pfn)
   ^
   static 
   2 warnings generated.


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

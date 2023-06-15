Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073BC731E02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 18:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjFOQmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjFOQlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:41:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381D26BE;
        Thu, 15 Jun 2023 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686847308; x=1718383308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTdtQ48myodzviQFiluUyD/WYttOZ7wHOsyrQVk4600=;
  b=mcqyMS2noeM720S+aSmOABbNdgJV7qco1TtkwL3g0CBVJJl7XUTBL4Ac
   18JViy1HgMwf8Kj7364sgWCYO4DZitE/h0s4BOKzNx2LZ1JR/+wQoFeJA
   J8GbG+eQazrTzjMtqC2jEb5wIFIB8CdlWmqI4RKTAR400pZ8Zf5+SSUtk
   U/WY8XI6w8IEtznMvJ058iEEev4CBYe47NENa8mZSUarYiotKLXZPCA1o
   A0Zlgr2TpD/HYPJYvLSUjtEUGJIzDghJqx06RuFNYIBxm1z8q2VGsFZSq
   uYZXL4Ges8y2R2zVKQttHuqjx7DeIZck/x+aqHI+gVCnCJAA/6gRe8RVP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="422608736"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="422608736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:41:47 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745644899"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745644899"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 09:41:40 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9q2V-0000Ag-18;
        Thu, 15 Jun 2023 16:41:39 +0000
Date:   Fri, 16 Jun 2023 00:40:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v19 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202306160006.dNg0cOoc-lkp@intel.com>
References: <20230615141144.665148-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615141144.665148-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20230615]
[cannot apply to linus/master v6.4-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230615-225037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230615141144.665148-3-usama.anjum%40collabora.com
patch subject: [PATCH v19 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230616/202306160006.dNg0cOoc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch akpm-mm mm-everything
        git checkout akpm-mm/mm-everything
        b4 shazam https://lore.kernel.org/r/20230615141144.665148-3-usama.anjum@collabora.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/proc/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306160006.dNg0cOoc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from include/linux/pagewalk.h:5,
                    from fs/proc/task_mmu.c:2:
   fs/proc/task_mmu.c: In function 'pagemap_scan_args_valid':
>> fs/proc/task_mmu.c:2148:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2148 |                 if (!access_ok((void __user *)arg->vec,
         |                                ^
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   fs/proc/task_mmu.c:2148:22: note: in expansion of macro 'access_ok'
    2148 |                 if (!access_ok((void __user *)arg->vec,
         |                      ^~~~~~~~~


vim +2148 fs/proc/task_mmu.c

  2115	
  2116	static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned long start,
  2117					   struct page_region __user *vec)
  2118	{
  2119		/* Detect illegal size, flags, len and masks */
  2120		if (arg->size != sizeof(struct pm_scan_arg))
  2121			return -EINVAL;
  2122		if (!arg->flags)
  2123			return -EINVAL;
  2124		if (arg->flags & ~PM_SCAN_OPS)
  2125			return -EINVAL;
  2126		if (!arg->len)
  2127			return -EINVAL;
  2128		if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
  2129		     arg->return_mask) & ~PM_SCAN_BITS_ALL)
  2130			return -EINVAL;
  2131		if (!arg->required_mask && !arg->anyof_mask &&
  2132		    !arg->excluded_mask)
  2133			return -EINVAL;
  2134		if (!arg->return_mask)
  2135			return -EINVAL;
  2136	
  2137		/* Validate memory range */
  2138		if (!IS_ALIGNED(start, PAGE_SIZE))
  2139			return -EINVAL;
  2140		if (!access_ok((void __user *)start, arg->len))
  2141			return -EFAULT;
  2142	
  2143		if (IS_PM_SCAN_GET(arg->flags)) {
  2144			if (!arg->vec)
  2145				return -EINVAL;
  2146			if (arg->vec_len == 0)
  2147				return -EINVAL;
> 2148			if (!access_ok((void __user *)arg->vec,
  2149				       arg->vec_len * sizeof(struct page_region)))
  2150				return -EFAULT;
  2151		}
  2152	
  2153		if (IS_PM_SCAN_WP(arg->flags) && !IS_PM_SCAN_GET(arg->flags) &&
  2154		    arg->max_pages)
  2155			return -EINVAL;
  2156	
  2157		return 0;
  2158	}
  2159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

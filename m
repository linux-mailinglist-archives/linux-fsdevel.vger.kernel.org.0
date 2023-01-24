Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C029E6794B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjAXKEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 05:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjAXKEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:04:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35B923846;
        Tue, 24 Jan 2023 02:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674554638; x=1706090638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8mR/uvzv2jV6r7LTK/xqyg4Ig58IGy9kGuy8OKDjYJU=;
  b=Gdy5cbeNUeFdvemCZIqIT8eP4XDT5q8wEQkbru9F126JJkc1RC1SukKk
   vuS3SYldyxlMOHur10Ffk94zuwV3GHkz9fVACQ2iYFDWfwA27UaogixSa
   6zMIc8BC/ACPvuhYTaDjSnU6I/vzFSgVa9J0Nz473e860X90spSXhPxeA
   ZXkrUqNjrtu3ExfGdohAXMOCTbZvER9KXfu5g9N1Laz0bU7900tPQDOlV
   RbdrclGRi+XiSt9eslpWkXTG6ozdyPI0kpK3AB4jr6HQFxxqzBQQr16uM
   yQRcqZYjcX/dvcFPoSxZhOTACNwye2glgNOoEEIr0KKxCSNIA/KUac46N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328351348"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="328351348"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 02:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="786021876"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="786021876"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2023 02:03:49 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKG9c-0006Jw-1l;
        Tue, 24 Jan 2023 10:03:48 +0000
Date:   Tue, 24 Jan 2023 18:02:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v8 3/4] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <202301241708.pfzy132a-lkp@intel.com>
References: <20230124084323.1363825-4-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124084323.1363825-4-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.2-rc5]
[cannot apply to next-20230124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230124-164601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230124084323.1363825-4-usama.anjum%40collabora.com
patch subject: [PATCH v8 3/4] fs/proc/task_mmu: Implement IOCTL to get and/or the clear info about PTEs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230124/202301241708.pfzy132a-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8d3b72e0605d479fbc5c2bc6f4ba9ddfecdb9ccb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230124-164601
        git checkout 8d3b72e0605d479fbc5c2bc6f4ba9ddfecdb9ccb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
   fs/proc/task_mmu.c:1880:14: warning: unused variable 'pmd_wt' [-Wunused-variable]
    1880 |         bool pmd_wt;
         |              ^~~~~~
   fs/proc/task_mmu.c:1876:22: warning: unused variable 'len' [-Wunused-variable]
    1876 |         unsigned int len;
         |                      ^~~
   fs/proc/task_mmu.c: In function 'do_pagemap_cmd':
>> fs/proc/task_mmu.c:1971:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1971 |         vec = (struct page_region *)untagged_addr(arg->vec);
         |               ^


vim +1971 fs/proc/task_mmu.c

  1960	
  1961	static long do_pagemap_cmd(struct mm_struct *mm, struct pagemap_scan_arg *arg)
  1962	{
  1963		unsigned long empty_slots, vec_index = 0;
  1964		unsigned long __user start, end;
  1965		unsigned long __start, __end;
  1966		struct page_region __user *vec;
  1967		struct pagemap_scan_private p;
  1968		int ret;
  1969	
  1970		start = (unsigned long)untagged_addr(arg->start);
> 1971		vec = (struct page_region *)untagged_addr(arg->vec);
  1972		if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
  1973			return -EINVAL;
  1974		if (IS_GET_OP(arg) && ((arg->vec_len == 0) ||
  1975		    (!access_ok((void __user *)vec, arg->vec_len * sizeof(struct page_region)))))
  1976			return -ENOMEM;
  1977		if ((arg->flags & ~PAGEMAP_WP_ENGAGE) || (arg->required_mask & ~PAGEMAP_OP_MASK) ||
  1978		    (arg->anyof_mask & ~PAGEMAP_OP_MASK) || (arg->excluded_mask & ~PAGEMAP_OP_MASK) ||
  1979		    (arg->return_mask & ~PAGEMAP_OP_MASK))
  1980			return -EINVAL;
  1981		if (IS_GET_OP(arg) && ((!arg->required_mask && !arg->anyof_mask && !arg->excluded_mask) ||
  1982					!arg->return_mask))
  1983			return -EINVAL;
  1984		/* The non-WT flags cannot be obtained if PAGEMAP_WP_ENGAGE is also specified. */
  1985		if (IS_WP_ENGAGE_OP(arg) && ((arg->required_mask & PAGEMAP_NONWT_OP_MASK) ||
  1986		    (arg->anyof_mask & PAGEMAP_NONWT_OP_MASK)))
  1987			return -EINVAL;
  1988	
  1989		end = start + arg->len;
  1990		p.max_pages = arg->max_pages;
  1991		p.found_pages = 0;
  1992		p.flags = arg->flags;
  1993		p.required_mask = arg->required_mask;
  1994		p.anyof_mask = arg->anyof_mask;
  1995		p.excluded_mask = arg->excluded_mask;
  1996		p.return_mask = arg->return_mask;
  1997		p.prev.len = 0;
  1998		p.vec_len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
  1999	
  2000		if (IS_GET_OP(arg)) {
  2001			p.vec = kmalloc_array(p.vec_len, sizeof(struct page_region), GFP_KERNEL);
  2002			if (!p.vec)
  2003				return -ENOMEM;
  2004		} else {
  2005			p.vec = NULL;
  2006		}
  2007		__start = __end = start;
  2008		while (__end < end) {
  2009			p.vec_index = 0;
  2010			empty_slots = arg->vec_len - vec_index;
  2011			if (p.vec_len > empty_slots)
  2012				p.vec_len = empty_slots;
  2013	
  2014			__end = (__start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
  2015			if (__end > end)
  2016				__end = end;
  2017	
  2018			mmap_read_lock(mm);
  2019			ret = walk_page_range(mm, __start, __end, &pagemap_scan_ops, &p);
  2020			mmap_read_unlock(mm);
  2021			if (!(!ret || ret == -ENOSPC))
  2022				goto free_data;
  2023	
  2024			__start = __end;
  2025			if (IS_GET_OP(arg) && p.vec_index) {
  2026				if (copy_to_user(&vec[vec_index], p.vec,
  2027						 p.vec_index * sizeof(struct page_region))) {
  2028					ret = -EFAULT;
  2029					goto free_data;
  2030				}
  2031				vec_index += p.vec_index;
  2032			}
  2033		}
  2034		ret = export_prev_to_out(&p, vec, &vec_index);
  2035		if (!ret)
  2036			ret = vec_index;
  2037	free_data:
  2038		if (IS_GET_OP(arg))
  2039			kfree(p.vec);
  2040	
  2041		return ret;
  2042	}
  2043	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

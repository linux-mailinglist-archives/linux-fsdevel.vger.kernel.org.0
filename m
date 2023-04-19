Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EFE6E7D94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjDSPCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjDSPCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:02:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52102D70;
        Wed, 19 Apr 2023 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681916554; x=1713452554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxhNswNe27Bu1wFIy8adyR69jvAG2hd0hxx1n7+ZJKA=;
  b=eyJDYaKRbOT+ahUfvFOpKJ2tL3cH9/LaV0dC/K1w/iIahVSB7H1n7VMl
   rg89kQSwNF248cbdd8rGCoPPKFcyZtjMJiswfT+Fdg3IR+Pz1fVqgqAa/
   2aYR+UBk89a3zjX5lbO+iwd+6T8scQtrLMgcWawu91CB76ee9xFPqbU0Z
   imQkXBj4Sew++eRYvNPMDyy5jMWsCKABO9jvQPWUO0Jc0gOwPdSIZl1ch
   mjXOIsHnveSqszEHK8q0Lmwi3fCLVIRu3meO9GnLodyqOqiO4LotwvQCr
   OoI4jAw5iYNhOeelu3FA2JpU1SZv42TvkJNbWrMSB3kHbXp3N/j2i7GZc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334281308"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="334281308"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 08:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="724079847"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="724079847"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Apr 2023 08:01:53 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp9Jg-000ewB-0Z;
        Wed, 19 Apr 2023 15:01:52 +0000
Date:   Wed, 19 Apr 2023 23:01:26 +0800
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
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Subject: Re: [PATCH v15 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202304192224.WAXXv4Fk-lkp@intel.com>
References: <20230419110716.4113627-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419110716.4113627-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230418]
[cannot apply to akpm-mm/mm-everything linus/master v6.3-rc7 v6.3-rc6 v6.3-rc5 v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230419-190920
patch link:    https://lore.kernel.org/r/20230419110716.4113627-3-usama.anjum%40collabora.com
patch subject: [PATCH v15 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: i386-randconfig-a014-20230417 (https://download.01.org/0day-ci/archive/20230419/202304192224.WAXXv4Fk-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b4a176ae0c875b07b49d2e3539699065438be9b1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230419-190920
        git checkout b4a176ae0c875b07b49d2e3539699065438be9b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304192224.WAXXv4Fk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/proc/task_mmu.c:2177:6: error: use of undeclared identifier 'vma'
                                           vma->vm_mm, start, end);
                                           ^
   1 error generated.


vim +/vma +2177 fs/proc/task_mmu.c

  2128	
  2129	static long do_pagemap_scan(struct mm_struct *mm,
  2130				   struct pm_scan_arg __user *uarg)
  2131	{
  2132		unsigned long start, end, walk_start, walk_end;
  2133		unsigned long empty_slots, vec_index = 0;
  2134		struct mmu_notifier_range range;
  2135		struct page_region __user *vec;
  2136		struct pagemap_scan_private p;
  2137		struct pm_scan_arg arg;
  2138		int ret = 0;
  2139	
  2140		if (copy_from_user(&arg, uarg, sizeof(arg)))
  2141			return -EFAULT;
  2142	
  2143		start = untagged_addr((unsigned long)arg.start);
  2144		vec = (struct page_region *)untagged_addr((unsigned long)arg.vec);
  2145	
  2146		ret = pagemap_scan_args_valid(&arg, start, vec);
  2147		if (ret)
  2148			return ret;
  2149	
  2150		end = start + arg.len;
  2151		p.max_pages = arg.max_pages;
  2152		p.found_pages = 0;
  2153		p.flags = arg.flags;
  2154		p.required_mask = arg.required_mask;
  2155		p.anyof_mask = arg.anyof_mask;
  2156		p.excluded_mask = arg.excluded_mask;
  2157		p.return_mask = arg.return_mask;
  2158		p.cur.len = 0;
  2159		p.cur.start = 0;
  2160		p.vec = NULL;
  2161		p.vec_len = PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
  2162	
  2163		/*
  2164		 * Allocate smaller buffer to get output from inside the page walk
  2165		 * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
  2166		 * we want to return output to user in compact form where no two
  2167		 * consecutive regions should be continuous and have the same flags.
  2168		 * So store the latest element in p.cur between different walks and
  2169		 * store the p.cur at the end of the walk to the user buffer.
  2170		 */
  2171		p.vec = kmalloc_array(p.vec_len, sizeof(*p.vec), GFP_KERNEL);
  2172		if (!p.vec)
  2173			return -ENOMEM;
  2174	
  2175		if (p.flags & PM_SCAN_OP_WP) {
  2176			mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
> 2177						vma->vm_mm, start, end);
  2178			mmu_notifier_invalidate_range_start(&range);
  2179		}
  2180	
  2181		walk_start = walk_end = start;
  2182		while (walk_end < end && !ret) {
  2183			p.vec_index = 0;
  2184	
  2185			empty_slots = arg.vec_len - vec_index;
  2186			p.vec_len = min(p.vec_len, empty_slots);
  2187	
  2188			walk_end = (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK;
  2189			if (walk_end > end)
  2190				walk_end = end;
  2191	
  2192			ret = mmap_read_lock_killable(mm);
  2193			if (ret)
  2194				goto free_data;
  2195			ret = walk_page_range(mm, walk_start, walk_end,
  2196					      &pagemap_scan_ops, &p);
  2197			mmap_read_unlock(mm);
  2198	
  2199			if (ret && ret != -ENOSPC && ret != PM_SCAN_FOUND_MAX_PAGES)
  2200				goto free_data;
  2201	
  2202			walk_start = walk_end;
  2203			if (p.vec_index) {
  2204				if (copy_to_user(&vec[vec_index], p.vec,
  2205						 p.vec_index * sizeof(*p.vec))) {
  2206					/*
  2207					 * Return error even though the OP succeeded
  2208					 */
  2209					ret = -EFAULT;
  2210					goto free_data;
  2211				}
  2212				vec_index += p.vec_index;
  2213			}
  2214		}
  2215	
  2216		if (p.flags & PM_SCAN_OP_WP)
  2217			mmu_notifier_invalidate_range_end(&range);
  2218	
  2219		if (p.cur.len) {
  2220			if (copy_to_user(&vec[vec_index], &p.cur, sizeof(*p.vec))) {
  2221				ret = -EFAULT;
  2222				goto free_data;
  2223			}
  2224			vec_index++;
  2225		}
  2226	
  2227		ret = vec_index;
  2228	
  2229	free_data:
  2230		kfree(p.vec);
  2231		return ret;
  2232	}
  2233	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

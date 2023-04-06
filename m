Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9163F6D9631
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbjDFLqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 07:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbjDFLqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:46:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3893B5FCF;
        Thu,  6 Apr 2023 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680781351; x=1712317351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0A6pzuzFn2elHyZpdsZZeMbmY8fDQBiyiiSii7bFRJc=;
  b=dkagKEd9c4MBRldGB2cqKWG/BocoIoFF9yxNZFod3kKr51lPfzwzgkjE
   ZDlTx8REXEm0fqhGVFgI+vhkY63Z247qhMSI9kKdTdSVi88TzmTFGkKHQ
   utLi7gLQWRVEPheBjYGZDFBQa2kuqd7/NKMdhMLgKyVUdB6jrnc1mpqvX
   HI8CW1AzURo/jM7kRfbT0+5aCcZMLz4JncWxAlo708YkfBDdYEDV6v5Y4
   6L551EyOIRvRowilpwLHLtP2cc8jRMVty5LTnJq9lS4oNqJ1g9parPwm8
   o2IyX2ZwZ8DTg1ts4SCgQBHIWOliYu6o1a19tJlpeMnLi2byiuidkrfRP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="341446556"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="341446556"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 04:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="689638841"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="689638841"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Apr 2023 04:40:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkNyz-000RKs-0W;
        Thu, 06 Apr 2023 11:40:49 +0000
Date:   Thu, 6 Apr 2023 19:40:21 +0800
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
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202304061914.N1Hmx12N-lkp@intel.com>
References: <20230406074005.1784728-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406074005.1784728-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20230406]
[cannot apply to linus/master v6.3-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230406-154314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230406074005.1784728-3-usama.anjum%40collabora.com
patch subject: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: arc-randconfig-r023-20230405 (https://download.01.org/0day-ci/archive/20230406/202304061914.N1Hmx12N-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f13abb36f64c77913509da8ca157512d2fb9f031
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230406-154314
        git checkout f13abb36f64c77913509da8ca157512d2fb9f031
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304061914.N1Hmx12N-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
>> fs/proc/task_mmu.c:1921:37: error: 'HPAGE_SIZE' undeclared (first use in this function); did you mean 'PAGE_SIZE'?
    1921 |                     ((end - start < HPAGE_SIZE) ||
         |                                     ^~~~~~~~~~
         |                                     PAGE_SIZE
   fs/proc/task_mmu.c:1921:37: note: each undeclared identifier is reported only once for each function it appears in
>> fs/proc/task_mmu.c:1939:35: error: passing argument 1 of 'uffd_wp_range' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1939 |                     uffd_wp_range(vma, start, HPAGE_SIZE, true) < 0)
         |                                   ^~~
         |                                   |
         |                                   struct vm_area_struct *
   In file included from include/linux/mm_inline.h:9,
                    from fs/proc/task_mmu.c:3:
   include/linux/userfaultfd_k.h:215:52: note: expected 'struct mm_struct *' but argument is of type 'struct vm_area_struct *'
     215 | static inline long uffd_wp_range(struct mm_struct *dst_mm,
         |                                  ~~~~~~~~~~~~~~~~~~^~~~~~
>> fs/proc/task_mmu.c:1939:40: warning: passing argument 2 of 'uffd_wp_range' makes pointer from integer without a cast [-Wint-conversion]
    1939 |                     uffd_wp_range(vma, start, HPAGE_SIZE, true) < 0)
         |                                        ^~~~~
         |                                        |
         |                                        long unsigned int
   include/linux/userfaultfd_k.h:216:57: note: expected 'struct vm_area_struct *' but argument is of type 'long unsigned int'
     216 |                                  struct vm_area_struct *vma,
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~^~~
>> fs/proc/task_mmu.c:1939:21: error: too few arguments to function 'uffd_wp_range'
    1939 |                     uffd_wp_range(vma, start, HPAGE_SIZE, true) < 0)
         |                     ^~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:215:20: note: declared here
     215 | static inline long uffd_wp_range(struct mm_struct *dst_mm,
         |                    ^~~~~~~~~~~~~
   fs/proc/task_mmu.c:1965:35: error: passing argument 1 of 'uffd_wp_range' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1965 |                     uffd_wp_range(vma, addr, PAGE_SIZE, true) < 0)
         |                                   ^~~
         |                                   |
         |                                   struct vm_area_struct *
   include/linux/userfaultfd_k.h:215:52: note: expected 'struct mm_struct *' but argument is of type 'struct vm_area_struct *'
     215 | static inline long uffd_wp_range(struct mm_struct *dst_mm,
         |                                  ~~~~~~~~~~~~~~~~~~^~~~~~
   fs/proc/task_mmu.c:1965:40: warning: passing argument 2 of 'uffd_wp_range' makes pointer from integer without a cast [-Wint-conversion]
    1965 |                     uffd_wp_range(vma, addr, PAGE_SIZE, true) < 0)
         |                                        ^~~~
         |                                        |
         |                                        long unsigned int
   include/linux/userfaultfd_k.h:216:57: note: expected 'struct vm_area_struct *' but argument is of type 'long unsigned int'
     216 |                                  struct vm_area_struct *vma,
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~^~~
   fs/proc/task_mmu.c:1965:21: error: too few arguments to function 'uffd_wp_range'
    1965 |                     uffd_wp_range(vma, addr, PAGE_SIZE, true) < 0)
         |                     ^~~~~~~~~~~~~
   include/linux/userfaultfd_k.h:215:20: note: declared here
     215 | static inline long uffd_wp_range(struct mm_struct *dst_mm,
         |                    ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1921 fs/proc/task_mmu.c

  1891	
  1892	static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
  1893					  unsigned long end, struct mm_walk *walk)
  1894	{
  1895		struct pagemap_scan_private *p = walk->private;
  1896		bool is_written, is_file, is_present, is_swap;
  1897		struct vm_area_struct *vma = walk->vma;
  1898		unsigned long addr = end;
  1899		spinlock_t *ptl;
  1900		int ret = 0;
  1901		pte_t *pte;
  1902	
  1903	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  1904		ptl = pmd_trans_huge_lock(pmd, vma);
  1905		if (ptl) {
  1906			unsigned long n_pages = (end - start)/PAGE_SIZE;
  1907	
  1908			is_written = !is_pmd_uffd_wp(*pmd);
  1909			is_file = vma->vm_file;
  1910			is_present = pmd_present(*pmd);
  1911			is_swap = is_swap_pmd(*pmd);
  1912	
  1913			spin_unlock(ptl);
  1914	
  1915			/*
  1916			 * Break huge page into small pages if the WP operation need to
  1917			 * be performed is on a portion of the huge page or if max_pages
  1918			 * pages limit would exceed.
  1919			 */
  1920			if (is_written && PM_SCAN_OP_IS_WP(p) &&
> 1921			    ((end - start < HPAGE_SIZE) ||
  1922			     (p->max_pages &&
  1923			      (p->max_pages - p->found_pages) < n_pages))) {
  1924	
  1925				split_huge_pmd(vma, pmd, start);
  1926				goto process_smaller_pages;
  1927			}
  1928	
  1929			if (p->max_pages &&
  1930			    p->found_pages + n_pages > p->max_pages)
  1931				n_pages = p->max_pages - p->found_pages;
  1932	
  1933			ret = pagemap_scan_output(is_written, is_file, is_present,
  1934						  is_swap, p, start, n_pages);
  1935			if (ret < 0)
  1936				return ret;
  1937	
  1938			if (is_written && PM_SCAN_OP_IS_WP(p) &&
> 1939			    uffd_wp_range(vma, start, HPAGE_SIZE, true) < 0)
  1940				ret = -EINVAL;
  1941	
  1942			return ret;
  1943		}
  1944	process_smaller_pages:
  1945		if (pmd_trans_unstable(pmd))
  1946			return 0;
  1947	#endif
  1948	
  1949		for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
  1950			pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
  1951	
  1952			is_written = !is_pte_uffd_wp(*pte);
  1953			is_file = vma->vm_file;
  1954			is_present = pte_present(*pte);
  1955			is_swap = is_swap_pte(*pte);
  1956	
  1957			pte_unmap_unlock(pte, ptl);
  1958	
  1959			ret = pagemap_scan_output(is_written, is_file, is_present,
  1960						  is_swap, p, addr, 1);
  1961			if (ret < 0)
  1962				return ret;
  1963	
  1964			if (is_written && PM_SCAN_OP_IS_WP(p) &&
  1965			    uffd_wp_range(vma, addr, PAGE_SIZE, true) < 0)
  1966				return -EINVAL;
  1967		}
  1968	
  1969		cond_resched();
  1970		return ret;
  1971	}
  1972	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

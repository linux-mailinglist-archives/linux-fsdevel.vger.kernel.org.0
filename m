Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6437A686043
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 08:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjBAHFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 02:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjBAHFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:05:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDDEE398;
        Tue, 31 Jan 2023 23:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675235127; x=1706771127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z5PhnpmOAJuOc0Bq/L9mnpqUibI5L8+buBwNICS6zF8=;
  b=OksAj4sGo/g9GaSWuBOpoksQGFKLCwXLu4QrDJLMvSa4fs4+qqexxye0
   rnjq534doOPX3m7eIWQ5em4iUOED5EnQ3BSnT4J6Q1gfkULhQC+qPx8O0
   hGvWx7czm+O/F6iixKl43yAVMk5HO5+7Rg8k2/F5BN2ya94PdZH3/vJIP
   CiAYqKrFUf8O0TlVsKnZgYe+9Up7FhKRXkOwYxMcrOOKxWcmW/r/uuumR
   EOy0fRWD9i/Pjp2j9TCJpYS5+r1DMvEN+AbZp5oqpluu/bw/S5g20dYZN
   6bOzbw+5OUl7TQLejO+a1Czf69fxTDNPo5n8eHQjavmtVSd0MbaBqAqBc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="326724098"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="326724098"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 23:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="642303771"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="642303771"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2023 23:05:12 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN7B9-0005CK-2j;
        Wed, 01 Feb 2023 07:05:11 +0000
Date:   Wed, 1 Feb 2023 15:04:58 +0800
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v9 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <202302011447.7lSFpVO5-lkp@intel.com>
References: <20230131083257.3302830-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131083257.3302830-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shuah-kselftest/fixes]
[also build test ERROR on linus/master v6.2-rc6]
[cannot apply to shuah-kselftest/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230131-163537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git fixes
patch link:    https://lore.kernel.org/r/20230131083257.3302830-3-usama.anjum%40collabora.com
patch subject: [PATCH v9 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or the clear info about PTEs
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230201/202302011447.7lSFpVO5-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/11677b6b7fda958031115ea40aa219fc32c7dea4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-Add-UFFD-WP-Async-support/20230131-163537
        git checkout 11677b6b7fda958031115ea40aa219fc32c7dea4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/proc/task_mmu.c:1907:5: error: implicit declaration of function 'uffd_wp_range' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                   uffd_wp_range(walk->mm, vma, start, HPAGE_SIZE, true);
                                   ^
   fs/proc/task_mmu.c:1927:3: error: implicit declaration of function 'uffd_wp_range' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   uffd_wp_range(walk->mm, vma, start, addr - start, true);
                   ^
   2 errors generated.


vim +/uffd_wp_range +1907 fs/proc/task_mmu.c

  1874	
  1875	static inline int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
  1876						 unsigned long end, struct mm_walk *walk)
  1877	{
  1878		struct pagemap_scan_private *p = walk->private;
  1879		struct vm_area_struct *vma = walk->vma;
  1880		unsigned long addr = end;
  1881		spinlock_t *ptl;
  1882		int ret = 0;
  1883		pte_t *pte;
  1884	
  1885	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  1886		ptl = pmd_trans_huge_lock(pmd, vma);
  1887		if (ptl) {
  1888			bool pmd_wt;
  1889	
  1890			pmd_wt = !is_pmd_uffd_wp(*pmd);
  1891			/*
  1892			 * Break huge page into small pages if operation needs to be performed is
  1893			 * on a portion of the huge page.
  1894			 */
  1895			if (pmd_wt && IS_WP_ENGAGE_OP(p) && (end - start < HPAGE_SIZE)) {
  1896				spin_unlock(ptl);
  1897				split_huge_pmd(vma, pmd, start);
  1898				goto process_smaller_pages;
  1899			}
  1900			if (IS_GET_OP(p))
  1901				ret = pagemap_scan_output(pmd_wt, vma->vm_file, pmd_present(*pmd),
  1902							  is_swap_pmd(*pmd), p, start,
  1903							  (end - start)/PAGE_SIZE);
  1904			spin_unlock(ptl);
  1905			if (!ret) {
  1906				if (pmd_wt && IS_WP_ENGAGE_OP(p))
> 1907					uffd_wp_range(walk->mm, vma, start, HPAGE_SIZE, true);
  1908			}
  1909			return ret;
  1910		}
  1911	process_smaller_pages:
  1912		if (pmd_trans_unstable(pmd))
  1913			return 0;
  1914	#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
  1915	
  1916		pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
  1917		if (IS_GET_OP(p)) {
  1918			for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
  1919				ret = pagemap_scan_output(!is_pte_uffd_wp(*pte), vma->vm_file,
  1920							  pte_present(*pte), is_swap_pte(*pte), p, addr, 1);
  1921				if (ret)
  1922					break;
  1923			}
  1924		}
  1925		pte_unmap_unlock(pte - 1, ptl);
  1926		if ((!ret || ret == -ENOSPC) && IS_WP_ENGAGE_OP(p) && (addr - start))
  1927			uffd_wp_range(walk->mm, vma, start, addr - start, true);
  1928	
  1929		cond_resched();
  1930		return ret;
  1931	}
  1932	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

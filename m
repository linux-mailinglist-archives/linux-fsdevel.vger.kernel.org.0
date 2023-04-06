Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E326D96B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 14:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjDFMFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 08:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbjDFME6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:04:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03589974E;
        Thu,  6 Apr 2023 05:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680782597; x=1712318597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y0+dFDwT+bRH/eVHXMTL+q8aR+Moi88tLPH/nkhsKhc=;
  b=oCL/PTZIQ7iK6pS0Qbp89WOVAwMbogTGUnUGlp6ffdZmWn9f24yM0M8V
   1XgTnt39idyegrOGc7+wlw/AvYaN3hTXU7s2zPJqGUpuzDmF1LvB9VBdi
   hAJwGPAQM1Fz0FjEtIvzZmVvsIXEYSCQSKF0G3bXTz5QOujWGP6Ar+TFT
   vxKFbsR7LauKRVl/hAzFEnwCs3P/OopbIxqInGcI8qnHqMdgeDmlKZ+mj
   66rZggJfidTuTx6IgPnyh3XybTtL7Bg+KTDL76zIhJd4ktMKT0SPwheOa
   sKrDWwrqbOlRLOIKXkXEr1uTpMycgo2jMymJXrbEThw30ppjMpzZs0ooC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="429001074"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="429001074"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 05:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="1016843428"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="1016843428"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Apr 2023 05:01:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkOJJ-000RLK-1Z;
        Thu, 06 Apr 2023 12:01:49 +0000
Date:   Thu, 6 Apr 2023 20:00:52 +0800
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
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202304061924.m0OL9fIj-lkp@intel.com>
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
config: arm-randconfig-r021-20230405 (https://download.01.org/0day-ci/archive/20230406/202304061924.m0OL9fIj-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/f13abb36f64c77913509da8ca157512d2fb9f031
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230406-154314
        git checkout f13abb36f64c77913509da8ca157512d2fb9f031
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304061924.m0OL9fIj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/proc/task_mmu.c:1965:47: error: too few arguments to function call, expected 5, have 4
                       uffd_wp_range(vma, addr, PAGE_SIZE, true) < 0)
                       ~~~~~~~~~~~~~                           ^
   include/linux/userfaultfd_k.h:215:20: note: 'uffd_wp_range' declared here
   static inline long uffd_wp_range(struct mm_struct *dst_mm,
                      ^
   1 error generated.


vim +1965 fs/proc/task_mmu.c

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
> 1965			    uffd_wp_range(vma, addr, PAGE_SIZE, true) < 0)
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

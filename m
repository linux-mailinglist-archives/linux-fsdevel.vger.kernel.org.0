Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868596E6D3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjDRUFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 16:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDRUFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:05:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16E51FD7;
        Tue, 18 Apr 2023 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681848314; x=1713384314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MESHOGE+6HB9L0+Pxz2Yf8K9mFxsBzR+eoMqR4IqWFE=;
  b=DOEvAulM6XMvBVa2yWRE0tnzDL72XwND8mFCqIubQ4OPsiOfvuMf+DZ6
   8dWTIrAF8dZYIkfLTOWFxQZVdT3yoP68oei4UZZrUVIxaocgF7v2IaeXU
   QB11emoP2s/VjhD52cIOR+UqufWFwPPRK2ZjM0dVDzMZJryq3CqcWWfoQ
   IVNSEcrBTDFD3yqXHoGi8DwsNAURKm3QMac0fOnVYhvXpgic/uDwSG2qO
   YcG2uUcz4ABuDMkpUJebAXgZVuoZtRBvgL+0isfgDEDTJE8oYVDAGRDuf
   cE6gItV1knfLXnMmRXmowxm48oiHBnPLY5wiP6fGhvva0jhPYdydfsEa2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="344024377"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="344024377"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 13:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780609861"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="780609861"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2023 13:05:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1porZZ-000dzb-10;
        Tue, 18 Apr 2023 20:05:05 +0000
Date:   Wed, 19 Apr 2023 04:04:09 +0800
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
Subject: Re: [PATCH v14 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <202304190331.VR44lj9J-lkp@intel.com>
References: <20230418062008.1434826-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418062008.1434826-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muhammad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20230417]
[cannot apply to linus/master v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230418-142225
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230418062008.1434826-3-usama.anjum%40collabora.com
patch subject: [PATCH v14 2/5] fs/proc/task_mmu: Implement IOCTL to get and optionally clear info about PTEs
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230419/202304190331.VR44lj9J-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4fe2396ba406868e01de910812e7e3c719ba11be
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muhammad-Usama-Anjum/userfaultfd-UFFD_FEATURE_WP_ASYNC/20230418-142225
        git checkout 4fe2396ba406868e01de910812e7e3c719ba11be
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190331.VR44lj9J-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'do_pagemap_scan':
   fs/proc/task_mmu.c:2205:17: error: implicit declaration of function 'flush_tlb_mm_range'; did you mean 'flush_tlb_range'? [-Werror=implicit-function-declaration]
    2205 |                 flush_tlb_mm_range(mm, start, end, PAGE_SHIFT, false);
         |                 ^~~~~~~~~~~~~~~~~~
         |                 flush_tlb_range
   In file included from include/linux/highmem.h:14,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from include/linux/mm_inline.h:7,
                    from fs/proc/task_mmu.c:3:
   include/linux/highmem-internal.h: In function 'pagemap_scan_pmd_entry':
>> include/linux/highmem-internal.h:271:9: warning: 'orig_pte' is used uninitialized [-Wuninitialized]
     271 |         __kunmap_atomic(__addr);                                \
         |         ^~~~~~~~~~~~~~~
   fs/proc/task_mmu.c:1934:22: note: 'orig_pte' was declared here
    1934 |         pte_t *pte, *orig_pte;
         |                      ^~~~~~~~
   cc1: some warnings being treated as errors


vim +/orig_pte +271 include/linux/highmem-internal.h

13f876ba77ebd5 Thomas Gleixner       2020-11-03  251  
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  252  /**
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  253   * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic() - deprecated!
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  254   * @__addr:       Virtual address to be unmapped
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  255   *
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  256   * Unmaps an address previously mapped by kmap_atomic() and re-enables
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  257   * pagefaults. Depending on PREEMP_RT configuration, re-enables also
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  258   * migration and preemption. Users should not count on these side effects.
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  259   *
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  260   * Mappings should be unmapped in the reverse order that they were mapped.
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  261   * See kmap_local_page() for details on nesting.
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  262   *
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  263   * @__addr can be any address within the mapped page, so there is no need
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  264   * to subtract any offset that has been added. In contrast to kunmap(),
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  265   * this function takes the address returned from kmap_atomic(), not the
e7392b4eca84e8 Fabio M. De Francesco 2022-05-13  266   * page passed to it. The compiler will warn you if you pass the page.
13f876ba77ebd5 Thomas Gleixner       2020-11-03  267   */
13f876ba77ebd5 Thomas Gleixner       2020-11-03  268  #define kunmap_atomic(__addr)					\
13f876ba77ebd5 Thomas Gleixner       2020-11-03  269  do {								\
13f876ba77ebd5 Thomas Gleixner       2020-11-03  270  	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
13f876ba77ebd5 Thomas Gleixner       2020-11-03 @271  	__kunmap_atomic(__addr);				\
13f876ba77ebd5 Thomas Gleixner       2020-11-03  272  } while (0)
13f876ba77ebd5 Thomas Gleixner       2020-11-03  273  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

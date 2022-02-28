Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5384C7465
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 18:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiB1RpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 12:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiB1Rnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:43:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D2F9A985;
        Mon, 28 Feb 2022 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069720; x=1677605720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4h1YWtV6F2Q6sNCl+7xob39bvg1TMmI6b4u3dRROqA4=;
  b=CVnpusEK/Eramn9TgpeNNSwap1EzIugiOMh0a14eYIcR7T8XB9T3G5bC
   BLrrMcv9yH7GRS4Snie/X7+jLqyJJBSZD9oXvqTsuB0ewSyzMuPQ9g6Vs
   pK+4uFkJ7rGXyZq7zGk4UYA6w4ajELA9VPczbcCqijOpbW4/S387l7cQZ
   P0bwzo4fJV1gFb8Wp8XXPDOJgmjvtJQaGwI+gNo2BQPiF1GsPvPXY6BVC
   k6dTHxkV2KaZgVknKrzCNamLde4rwHMtVVJuL7DYzq3altgmM7xzsox0y
   m0KzGHZG0BhZeSUlpgruL/hhO8ntbl+e8unSjvSoO8BwOhEhBnS1Wgxgu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="277599710"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="277599710"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="608524532"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2022 09:35:14 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjvW-0007ZL-5q; Mon, 28 Feb 2022 17:35:14 +0000
Date:   Tue, 1 Mar 2022 01:35:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, apopple@nvidia.com, shy828301@gmail.com,
        rcampbell@nvidia.com, hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3 4/6] mm: pvmw: add support for walking devmap pages
Message-ID: <202202281913.ZakSkynK-lkp@intel.com>
References: <20220228063536.24911-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228063536.24911-5-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Muchun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on next-20220225]
[cannot apply to linus/master v5.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Muchun-Song/Fix-some-bugs-related-to-ramp-and-dax/20220228-143753
base:   https://github.com/hnaz/linux-mm master
config: riscv-randconfig-r012-20220227 (https://download.01.org/0day-ci/archive/20220228/202202281913.ZakSkynK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/4b08af172f30c61ae5f43ec23642e2767371247e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Muchun-Song/Fix-some-bugs-related-to-ramp-and-dax/20220228-143753
        git checkout 4b08af172f30c61ae5f43ec23642e2767371247e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/page_vma_mapped.c:113:13: error: call to __compiletime_assert_258 declared with 'error' attribute: BUILD_BUG failed
           if ((pfn + HPAGE_PMD_NR - 1) < pvmw->pfn)
                      ^
   include/linux/huge_mm.h:105:26: note: expanded from macro 'HPAGE_PMD_NR'
   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                            ^
   include/linux/huge_mm.h:104:26: note: expanded from macro 'HPAGE_PMD_ORDER'
   #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                            ^
   include/linux/huge_mm.h:307:28: note: expanded from macro 'HPAGE_PMD_SHIFT'
   #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
                              ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:335:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:328:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:73:1: note: expanded from here
   __compiletime_assert_258
   ^
   1 error generated.


vim +/error +113 mm/page_vma_mapped.c

9188af981d385d Andrew Morton      2022-02-25  109  
9188af981d385d Andrew Morton      2022-02-25  110  /* Returns true if the two ranges overlap.  Careful to not overflow. */
9188af981d385d Andrew Morton      2022-02-25  111  static bool check_pmd(unsigned long pfn, struct page_vma_mapped_walk *pvmw)
9188af981d385d Andrew Morton      2022-02-25  112  {
9188af981d385d Andrew Morton      2022-02-25 @113  	if ((pfn + HPAGE_PMD_NR - 1) < pvmw->pfn)
9188af981d385d Andrew Morton      2022-02-25  114  		return false;
9188af981d385d Andrew Morton      2022-02-25  115  	if (pfn > pvmw->pfn + pvmw->nr_pages - 1)
9188af981d385d Andrew Morton      2022-02-25  116  		return false;
9188af981d385d Andrew Morton      2022-02-25  117  	return true;
ace71a19cec5eb Kirill A. Shutemov 2017-02-24  118  }
ace71a19cec5eb Kirill A. Shutemov 2017-02-24  119  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

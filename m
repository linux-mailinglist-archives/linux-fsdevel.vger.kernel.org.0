Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D03451E42E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 06:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445508AbiEGExv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 00:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbiEGExu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 00:53:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F869CE8;
        Fri,  6 May 2022 21:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651899005; x=1683435005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J/3K4Vwk1O/C7U6JgPB5V1dfiV3hQe4EsWkA0JGHPKQ=;
  b=azYWsdJQ98eBuG9wDClHblEOCFj/Z/FQRsccwKwCkSRiRqxIVZQ1yk9e
   09cAzC/mg51FyplAvwzGrg+PsJmTEzQuDurHAzgpiqD/igKEhFktz8MgA
   ATTgvltbgfjcGRbpou6XgsQqw7zZ4PY2WEKlvdOf+CLAsUQK4xVQL5nR0
   o+fLRcv09tq1VcDVlsPAgBT3iVdr/8L9kyzSfLA/oKqw9a3pGAajKJKsx
   tGq3ANuiQNZIjdwlwq3xYQm+S5mGmZV8/IVpBDB6iLcUPBkFtaETDIhQe
   SztqIBrVHsj6psq6AiDZtdSaAKlfe35D/Wm1AyjxyL7d3FQUpMGgGKi+V
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="329198979"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="329198979"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 21:50:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="736067130"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2022 21:50:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnCOG-000EDc-Rm;
        Sat, 07 May 2022 04:50:00 +0000
Date:   Sat, 7 May 2022 12:49:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH v2] mm/ksm: introduce ksm_force for each process
Message-ID: <202205071229.7ltA0xmX-lkp@intel.com>
References: <20220507014318.642353-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507014318.642353-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20220506]
[cannot apply to hnaz-mm/master kees/for-next/pstore linus/master v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/mm-ksm-introduce-ksm_force-for-each-process/20220507-094557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: hexagon-randconfig-r045-20220506 (https://download.01.org/0day-ci/archive/20220507/202205071229.7ltA0xmX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af4cf1c6b8ed0d8102fc5e69acdc2fcbbcdaa9a7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bc6a122b9e10290755c811e7fa23dd60d39303e2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-ksm-introduce-ksm_force-for-each-process/20220507-094557
        git checkout bc6a122b9e10290755c811e7fa23dd60d39303e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/ksm.c:343:3: error: use of undeclared identifier 'turn'
                   turn false;
                   ^
   1 error generated.


vim +/turn +343 mm/ksm.c

   336	
   337	/* Check if vma is qualified for ksmd scanning */
   338	static bool ksm_vma_check(struct vm_area_struct *vma)
   339	{
   340		unsigned long vm_flags = vma->vm_flags;
   341	
   342		if (!(vma->vm_flags & VM_MERGEABLE) && !(vma->vm_mm->ksm_force))
 > 343			turn false;
   344	
   345		if (vm_flags & (VM_SHARED	| VM_MAYSHARE	|
   346				VM_PFNMAP	| VM_IO | VM_DONTEXPAND |
   347				VM_HUGETLB	| VM_MIXEDMAP))
   348			return false;       /* just ignore this vma*/
   349	
   350		if (vma_is_dax(vma))
   351			return false;
   352	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

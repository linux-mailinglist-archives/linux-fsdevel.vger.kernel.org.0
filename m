Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED0C51E428
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 06:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445489AbiEGEhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 00:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348022AbiEGEhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 00:37:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84D35AA4C;
        Fri,  6 May 2022 21:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651898043; x=1683434043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OKcHYO1LwvnDmPe+0JelqjqAsho2N3yrYYHr1TvoAyg=;
  b=B7n+3wetbK4efgxjQNnCKPNFnN7ySXuqrHqrhIntK88Y0OQvHTa7lLaK
   GRTg+FnHu4VobQwcA1PDdaSmMEa2KlnsXKicYErS4Teqx8EydGg7UylyG
   sjUn0AGDr7hNMGshIKYRSaAt6Nu2QFl4qQhzXMVGvtIv20ViB+dZ4BvaW
   zxdWGSGuralQPAr3MbG3qsHRvu4mCV7OFa+xJnbV7z1tJtsJO/Be+z5cL
   d7kNygK320GK3wA8QLpMpDc09ZUQ1iLUoxUQgUII2AFwk6ozHPZVY+GQ/
   ZGu1JKUbV9c9hcNl22IWFpgxDFVTRSju5nfQN0MvBdfJsOk5qFXkzCPFD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268274097"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="268274097"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 21:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="550151171"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2022 21:34:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnC8l-000ECu-SY;
        Sat, 07 May 2022 04:33:59 +0000
Date:   Sat, 7 May 2022 12:33:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH v2] mm/ksm: introduce ksm_force for each process
Message-ID: <202205071213.kLZzW7OV-lkp@intel.com>
References: <20220507014318.642353-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507014318.642353-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220507/202205071213.kLZzW7OV-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bc6a122b9e10290755c811e7fa23dd60d39303e2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-ksm-introduce-ksm_force-for-each-process/20220507-094557
        git checkout bc6a122b9e10290755c811e7fa23dd60d39303e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/ksm.c: In function 'ksm_vma_check':
>> mm/ksm.c:343:17: error: 'turn' undeclared (first use in this function)
     343 |                 turn false;
         |                 ^~~~
   mm/ksm.c:343:17: note: each undeclared identifier is reported only once for each function it appears in
>> mm/ksm.c:343:21: error: expected ';' before 'false'
     343 |                 turn false;
         |                     ^~~~~~
         |                     ;


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

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCEF4F9688
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiDHNUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiDHNUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:20:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5855ECC5E;
        Fri,  8 Apr 2022 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649423908; x=1680959908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v11wVOUBXjF91c7/a49xOWZxnE+WntSYIN4gsgCmFPE=;
  b=SahQEznnpXn7SU6+7w5Gl25KsiyCrJSaNLPpch0lbrD1gcXH0I9Y5rTN
   rWzYIesX0S/nHAuSCQ6bCgTV+nl22zFP/rpzPHq2+S9E7KSoqBl/F3o6T
   ttdYrmaubql3eyubVMTfZFVtCGqUmOoV2j+xHiIp9ZOoUXhllN6AKvyh0
   tOWZxMyLsZ2kx2OqGjaYqQDDsTPqxaDmWzwu0gJO12Pp0x60Zj0zsLRGW
   Pc2S4yOUJeARXp1tCOYf3r7d6VAOtIlmJ5Ky/qLmE+jJwt4Y9a3fc9W9T
   k6fTz5V89oVySBwB70G+zWNuoWNYyHb4MiPmXV+p5HtXV3MqmQGbshjfI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="286578786"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="286578786"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="795089080"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 08 Apr 2022 06:18:25 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncoVN-0000Hk-2Q;
        Fri, 08 Apr 2022 13:18:25 +0000
Date:   Fri, 8 Apr 2022 21:17:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org,
        willy@infradead.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, hch@lst.de, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, bhe@redhat.com
Subject: Re: [PATCH v5 RESEND 1/3] vmcore: Convert copy_oldmem_page() to take
 an iov_iter
Message-ID: <202204082128.JKXXDGpa-lkp@intel.com>
References: <20220408090636.560886-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408090636.560886-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Baoquan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on s390/features linus/master v5.18-rc1 next-20220408]
[cannot apply to tip/x86/core hnaz-mm/master arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/Convert-vmcore-to-use-an-iov_iter/20220408-170846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: sh-randconfig-s032-20220408 (https://download.01.org/0day-ci/archive/20220408/202204082128.JKXXDGpa-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a5e42962f5c0bea73aa382a2415094b4bd6c6c73
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baoquan-He/Convert-vmcore-to-use-an-iov_iter/20220408-170846
        git checkout a5e42962f5c0bea73aa382a2415094b4bd6c6c73
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/crash_dump.c:23:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem * @@
   arch/sh/kernel/crash_dump.c:23:36: sparse:     expected void const *addr
   arch/sh/kernel/crash_dump.c:23:36: sparse:     got void [noderef] __iomem *

vim +23 arch/sh/kernel/crash_dump.c

    13	
    14	ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
    15				 size_t csize, unsigned long offset)
    16	{
    17		void  __iomem *vaddr;
    18	
    19		if (!csize)
    20			return 0;
    21	
    22		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
  > 23		csize = copy_to_iter(vaddr + offset, csize, iter);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

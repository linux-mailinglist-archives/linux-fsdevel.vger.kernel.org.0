Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5C4FA106
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 03:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiDIB23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 21:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiDIB22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:28:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC0B6447;
        Fri,  8 Apr 2022 18:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649467582; x=1681003582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MRTsxtZf69YOsOVHMqropvkNoaDiDYTx9UcAx6U8urQ=;
  b=N+6SF42qGm2oNvxr47hCNAK6AzM0kEOSXEitRaR5A+RLd3k217AMcMly
   6gHsK9+i7mG/rui2qAY/02vUXz1oa6miz40pxlWpaXfm4cw827GOV83wO
   /mEGG9euO9XBA2yT9vql4oOb4NdVZTS/a8lIgizyjt19lLjcSir35CUww
   tC+f/wv61W70pGc/BUxRUUQk43lCgmzNt+phczTSo75zIL1PoW2b8mYbU
   gqs0Jr4LzSfYdKKK3V+1maj3n9a0KN8cw8PigwMoFlbR4PmorFwRGXvfo
   ghxmpjcCawaeoqsNwv5ovrUMAzYEuDm78z/uhAuvzQKDWMJoiAcSr0SYB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="242333867"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="242333867"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:26:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="698431628"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:26:18 -0700
Date:   Sat, 9 Apr 2022 09:24:12 +0800
From:   Philip Li <philip.li@intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
        willy@infradead.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        hch@lst.de, yangtiezhu@loongson.cn, amit.kachhap@arm.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [kbuild-all] Re: [PATCH v5 RESEND 1/3] vmcore: Convert
 copy_oldmem_page() to take an iov_iter
Message-ID: <YlDgPA96Gmlmzxxa@rli9-dbox>
References: <20220408090636.560886-2-bhe@redhat.com>
 <202204082128.JKXXDGpa-lkp@intel.com>
 <YlDbJSy4AI3/cODr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlDbJSy4AI3/cODr@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 09, 2022 at 09:02:29AM +0800, Baoquan He wrote:
> On 04/08/22 at 09:17pm, kernel test robot wrote:
> > Hi Baoquan,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on powerpc/next]
> > [also build test WARNING on s390/features linus/master v5.18-rc1 next-20220408]
> > [cannot apply to tip/x86/core hnaz-mm/master arm64/for-next/core]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/Convert-vmcore-to-use-an-iov_iter/20220408-170846
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> > config: sh-randconfig-s032-20220408 (https://download.01.org/0day-ci/archive/20220408/202204082128.JKXXDGpa-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 11.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> 
> Thanks for reporting this, do I need to try this on ppc system?
> 
> I tried on x86_64 system, for the 1st step, I got this:
> 
> [ ~]# wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> /root/bin/make.cross: No such file or directory
> 
> What else should I do to proceed?

not sure whether mkdir -p /root/bin works? I can reproduce this if i don't have ~/bin dir.

We will look into this to make reproduce step clearer.

> 
> Thanks
> Baoquan
> 
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-dirty
> >         # https://github.com/intel-lab-lkp/linux/commit/a5e42962f5c0bea73aa382a2415094b4bd6c6c73
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Baoquan-He/Convert-vmcore-to-use-an-iov_iter/20220408-170846
> >         git checkout a5e42962f5c0bea73aa382a2415094b4bd6c6c73
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > >> arch/sh/kernel/crash_dump.c:23:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem * @@
> >    arch/sh/kernel/crash_dump.c:23:36: sparse:     expected void const *addr
> >    arch/sh/kernel/crash_dump.c:23:36: sparse:     got void [noderef] __iomem *
> > 
> > vim +23 arch/sh/kernel/crash_dump.c
> > 
> >     13	
> >     14	ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
> >     15				 size_t csize, unsigned long offset)
> >     16	{
> >     17		void  __iomem *vaddr;
> >     18	
> >     19		if (!csize)
> >     20			return 0;
> >     21	
> >     22		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> >   > 23		csize = copy_to_iter(vaddr + offset, csize, iter);
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> > 
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

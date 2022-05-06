Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22D751DDF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443980AbiEFQ6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443977AbiEFQ6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:58:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710A56D851
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651856096; x=1683392096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C4xl3D7B9gT1f6Bq0vyZdhuycmcUGIGXjPtyEFigCCE=;
  b=Xdhh8jp9HW18T8+4aaMa8qbyjSGfaxpZfEnzw+49sn0TDnw5dj9F753d
   ro56TCZSJqvYzCGDhVbxs+BWyea/WIv+a8drGDWZ6mltk5SzgYrDSj75G
   D8I0cErkp4v63/DmzAjwz67YivWzxlXAx48Sy4trsEZ6IB9jKlY4z78s/
   SMqK1SUKNuLQh6G0oOWrfBlCCUqS9OUmgCRLQYkD6/nxcYjYiBjBEUxzw
   ykdqP2TjOPoazSSB0JEZqTmmuECScbvbJEKJPaYCX5IOj0Pg9ZtfIAGWK
   bVIcLkXC42Mg99L0SQc22w0CyJNE64XVUpQnzRWOcExwfk2dv2umWZIFv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="249051637"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="249051637"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 09:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="633013528"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 May 2022 09:54:46 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn1E6-000Dfy-7m;
        Fri, 06 May 2022 16:54:46 +0000
Date:   Sat, 7 May 2022 00:54:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang Chen <liangchen.linux@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, hch@infradead.org,
        jmoyer@redhat.com, jack@suse.cz, lczerner@redhat.com,
        Liang Chen <liangchen.linux@gmail.com>
Subject: Re: [PATCH] fs: Fix page cache inconsistency when mixing buffered
 and AIO DIO for bdev
Message-ID: <202205070030.wgFHZ8hk-lkp@intel.com>
References: <20220506135709.46872-1-lchen@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506135709.46872-1-lchen@localhost.localdomain>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Liang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Chen/fs-Fix-page-cache-inconsistency-when-mixing-buffered-and-AIO-DIO-for-bdev/20220506-215958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: riscv-randconfig-r024-20220506 (https://download.01.org/0day-ci/archive/20220507/202205070030.wgFHZ8hk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/2b2bda510e6c93a57581021c675b023d2f43e81e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-Chen/fs-Fix-page-cache-inconsistency-when-mixing-buffered-and-AIO-DIO-for-bdev/20220506-215958
        git checkout 2b2bda510e6c93a57581021c675b023d2f43e81e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/fops.c:423:5: warning: no previous prototype for function 'blkdev_sb_init_dio_done_wq' [-Wmissing-prototypes]
   int blkdev_sb_init_dio_done_wq(struct super_block *sb)
       ^
   block/fops.c:423:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blkdev_sb_init_dio_done_wq(struct super_block *sb)
   ^
   static 
   1 warning generated.


vim +/blkdev_sb_init_dio_done_wq +423 block/fops.c

   422	
 > 423	int blkdev_sb_init_dio_done_wq(struct super_block *sb)
   424	{
   425		struct workqueue_struct *old;
   426		struct workqueue_struct *wq = alloc_workqueue("dio/%s",
   427							     WQ_MEM_RECLAIM, 0,
   428							     sb->s_id);
   429		if (!wq)
   430		       return -ENOMEM;
   431		/*
   432		 * This has to be atomic as more DIOs can race to create the workqueue
   433		 */
   434		old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
   435		/* Someone created workqueue before us? Free ours... */
   436		if (old)
   437			destroy_workqueue(wq);
   438	       return 0;
   439	}
   440	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

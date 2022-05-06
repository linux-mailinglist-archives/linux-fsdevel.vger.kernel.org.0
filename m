Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8D51DE90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 20:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350721AbiEFSHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 14:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiEFSHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 14:07:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657AE62BE6
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651860207; x=1683396207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PYHT9DTyAILlttcu5SPgyhjivhDNJ61BZUCUAE8Az+M=;
  b=D9tkZsB55980zvURZbVjIeEvv19p+T2I8VOD8X5VJ7kLAiBPRGVmYF5P
   l8snCw6y8/mtiDfSQzkWoRXnyOtZ2HbMWkdftj5gfYax+bRbbMh977sXs
   BW3fSjJR8KtpqKWsoNQtnratDXe/Of8a9IZJFUvUAEgBXvTfogi7NE3AE
   MyAthiLD4vy1tKk90gndPX1TPEz/n8b1P7N/WaKlHa7kbED4fKFqsuzan
   AHCA0Q/4ahvVTwdPSWcuXB8zjAB/ZBvtgQ7NpfxKQ5ELt1lwj+A0RdBut
   y9g/FBhcEzfdccLm8iLQcFjZP8zqml0YBQDxf3zR+ltEkG2UePzB5Rr3T
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="267376975"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="267376975"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="537996690"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 May 2022 11:03:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn2IV-000DjY-R6;
        Fri, 06 May 2022 18:03:23 +0000
Date:   Sat, 7 May 2022 02:02:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang Chen <liangchen.linux@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, hch@infradead.org, jmoyer@redhat.com,
        jack@suse.cz, lczerner@redhat.com,
        Liang Chen <liangchen.linux@gmail.com>
Subject: Re: [PATCH] fs: Fix page cache inconsistency when mixing buffered
 and AIO DIO for bdev
Message-ID: <202205070158.7Io6lIxQ-lkp@intel.com>
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
[also build test WARNING on v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Chen/fs-Fix-page-cache-inconsistency-when-mixing-buffered-and-AIO-DIO-for-bdev/20220506-215958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arc-randconfig-r043-20220506 (https://download.01.org/0day-ci/archive/20220507/202205070158.7Io6lIxQ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2b2bda510e6c93a57581021c675b023d2f43e81e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-Chen/fs-Fix-page-cache-inconsistency-when-mixing-buffered-and-AIO-DIO-for-bdev/20220506-215958
        git checkout 2b2bda510e6c93a57581021c675b023d2f43e81e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/fops.c:423:5: warning: no previous prototype for 'blkdev_sb_init_dio_done_wq' [-Wmissing-prototypes]
     423 | int blkdev_sb_init_dio_done_wq(struct super_block *sb)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~


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

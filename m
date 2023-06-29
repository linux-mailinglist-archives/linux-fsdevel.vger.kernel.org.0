Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C13474253C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjF2MDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 08:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjF2MDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:03:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623232D69;
        Thu, 29 Jun 2023 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688040220; x=1719576220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MBbSbcK9F4Hh8jsyxNjcbnUbWXs38VmIRaYcEIVQG+g=;
  b=UdNzH6ao7xb40vcc8ab0hXM6gdgQWWi02flZwYqSYISzUTZ1/GW6moGW
   ini4jEtICfDP7oF9PrhV5QLelK+f5R4xh3sR4MEhOE6dDElR4m/PNqu5j
   9O8lMlF7ZIQPaswu4Fja8c4POa/4s/Zi4CukxO+EbkZBre7XC07F7jitx
   JYf0L80NvJG7svT6q3DWiMs0+c8TwuWWv1gCKWsG8LX6bjC+oUG9S4cka
   qfwBrCRh+VtGt/2fuQqPQcLcmMcDUVKwTxethVIgevMQ5+3pdFHC8l8sl
   XxTy/4Wr2ytNIhf6+m5pFdFLHYUSQMODHLlx3xXa4dCTGXPup6H8tdqqk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="425759056"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="425759056"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 05:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="667488588"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="667488588"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2023 05:03:25 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEqMu-000E7d-21;
        Thu, 29 Jun 2023 12:03:24 +0000
Date:   Thu, 29 Jun 2023 20:02:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org,
        djwong@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH v12 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <202306291954.zqVvCUZ5-lkp@intel.com>
References: <20230629081651.253626-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629081651.253626-3-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Shiyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Shiyang-Ruan/xfs-fix-the-calculation-for-end-and-length/20230629-161913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230629081651.253626-3-ruansy.fnst%40fujitsu.com
patch subject: [PATCH v12 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230629/202306291954.zqVvCUZ5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306291954.zqVvCUZ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306291954.zqVvCUZ5-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/xfs/xfs_notify_failure.c: In function 'xfs_dax_notify_failure_freeze':
>> fs/xfs/xfs_notify_failure.c:127:33: error: 'FREEZE_HOLDER_KERNEL' undeclared (first use in this function)
     127 |         while (freeze_super(sb, FREEZE_HOLDER_KERNEL) != 0) {
         |                                 ^~~~~~~~~~~~~~~~~~~~
   fs/xfs/xfs_notify_failure.c:127:33: note: each undeclared identifier is reported only once for each function it appears in
>> fs/xfs/xfs_notify_failure.c:127:16: error: too many arguments to function 'freeze_super'
     127 |         while (freeze_super(sb, FREEZE_HOLDER_KERNEL) != 0) {
         |                ^~~~~~~~~~~~
   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:988,
                    from fs/xfs/kmem.h:11,
                    from fs/xfs/xfs_linux.h:24,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/xfs_notify_failure.c:6:
   include/linux/fs.h:2289:12: note: declared here
    2289 | extern int freeze_super(struct super_block *super);
         |            ^~~~~~~~~~~~
   fs/xfs/xfs_notify_failure.c: In function 'xfs_dax_notify_failure_thaw':
   fs/xfs/xfs_notify_failure.c:140:32: error: 'FREEZE_HOLDER_KERNEL' undeclared (first use in this function)
     140 |         error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
         |                                ^~~~~~~~~~~~~~~~~~~~
>> fs/xfs/xfs_notify_failure.c:140:17: error: too many arguments to function 'thaw_super'
     140 |         error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
         |                 ^~~~~~~~~~
   include/linux/fs.h:2290:12: note: declared here
    2290 | extern int thaw_super(struct super_block *super);
         |            ^~~~~~~~~~
>> fs/xfs/xfs_notify_failure.c:148:24: error: 'FREEZE_HOLDER_USERSPACE' undeclared (first use in this function)
     148 |         thaw_super(sb, FREEZE_HOLDER_USERSPACE);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
   fs/xfs/xfs_notify_failure.c:148:9: error: too many arguments to function 'thaw_super'
     148 |         thaw_super(sb, FREEZE_HOLDER_USERSPACE);
         |         ^~~~~~~~~~
   include/linux/fs.h:2290:12: note: declared here
    2290 | extern int thaw_super(struct super_block *super);
         |            ^~~~~~~~~~


vim +/FREEZE_HOLDER_KERNEL +127 fs/xfs/xfs_notify_failure.c

   119	
   120	static void
   121	xfs_dax_notify_failure_freeze(
   122		struct xfs_mount	*mp)
   123	{
   124		struct super_block 	*sb = mp->m_super;
   125	
   126		/* Wait until no one is holding the FREEZE_HOLDER_KERNEL. */
 > 127		while (freeze_super(sb, FREEZE_HOLDER_KERNEL) != 0) {
   128			// Shall we just wait, or print warning then return -EBUSY?
   129			delay(HZ / 10);
   130		}
   131	}
   132	
   133	static void
   134	xfs_dax_notify_failure_thaw(
   135		struct xfs_mount	*mp)
   136	{
   137		struct super_block	*sb = mp->m_super;
   138		int			error;
   139	
 > 140		error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
   141		if (error)
   142			xfs_emerg(mp, "still frozen after notify failure, err=%d",
   143				  error);
   144		/*
   145		 * Also thaw userspace call anyway because the device is about to be
   146		 * removed immediately.
   147		 */
 > 148		thaw_super(sb, FREEZE_HOLDER_USERSPACE);
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

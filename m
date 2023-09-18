Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65B57A53AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 22:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjIRUPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRUPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:15:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC88F
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695068139; x=1726604139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aMOXzZtb6Dhzgg3FncXrqWcdk3Q4Jq+gAqROF/yQJ2w=;
  b=gFOqT6vZ/bIWRNq+OEEedOTYBXjUBAPMWsMariR6LflJVU1p+G5TObyK
   NW5Y6Mpe6Q+5Cy2+e36ewLenT3r1zXdANYVimQ+8E+Yv38n4FfBOEz8bQ
   Zx67m83xCrg8DCUbHd3xCZUAbqNO4WtbNwGPxA7mrbqS9uNB2M0mgY4Np
   LsTTfv/Q2dALgBbJuxb2BzZQGAj1qPEBRKaS4rnw2XxdO0mAYkGHnrIrq
   FPjKIGYE0aSIXLjmDrII5UbaipbgbpX0+MME3yxQzBieMLjtbMhM2w4x5
   80AO1vL4IGDpZzWWnHVafTrQqktmPlWnoMltK4J/x00IDXX+zXYiTcSBd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="360015481"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="360015481"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 13:15:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="869693678"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="869693678"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Sep 2023 13:15:36 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiKeW-0006Qw-2g;
        Mon, 18 Sep 2023 20:15:30 +0000
Date:   Tue, 19 Sep 2023 04:13:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>
Subject: Re: [PATCH v4 07/10] fuse: Remove fuse_direct_write_iter code path /
 use IOCB_DIRECT
Message-ID: <202309190423.cEQ7h6ai-lkp@intel.com>
References: <20230918150313.3845114-8-bschubert@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918150313.3845114-8-bschubert@ddn.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bernd,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-fuse/for-next]
[also build test WARNING on linus/master v6.6-rc2 next-20230918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bernd-Schubert/fuse-direct-IO-can-use-the-write-through-code-path/20230919-005745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20230918150313.3845114-8-bschubert%40ddn.com
patch subject: [PATCH v4 07/10] fuse: Remove fuse_direct_write_iter code path / use IOCB_DIRECT
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230919/202309190423.cEQ7h6ai-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309190423.cEQ7h6ai-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309190423.cEQ7h6ai-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/fuse/file.c:1060: warning: Function parameter or member 'iocb' not described in 'fuse_write_flags'
>> fs/fuse/file.c:1060: warning: expecting prototype for Note(). Prototype was for fuse_write_flags() instead


vim +1060 fs/fuse/file.c

338f2e3f3341a9 Miklos Szeredi 2019-09-10  1054  
abb63dd79fa5c1 Bernd Schubert 2023-09-18  1055  /**
abb63dd79fa5c1 Bernd Schubert 2023-09-18  1056   * Note: iocb->ki_flags & IOCB_DIRECT cannot be trusted here,
abb63dd79fa5c1 Bernd Schubert 2023-09-18  1057   *       it might be set when FOPEN_DIRECT_IO is used.
abb63dd79fa5c1 Bernd Schubert 2023-09-18  1058   */
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1059  static unsigned int fuse_write_flags(struct kiocb *iocb)
338f2e3f3341a9 Miklos Szeredi 2019-09-10 @1060  {
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1061  	unsigned int flags = iocb->ki_filp->f_flags;
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1062  
91b94c5d6ae55d Al Viro        2022-05-22  1063  	if (iocb_is_dsync(iocb))
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1064  		flags |= O_DSYNC;
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1065  	if (iocb->ki_flags & IOCB_SYNC)
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1066  		flags |= O_SYNC;
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1067  
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1068  	return flags;
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1069  }
338f2e3f3341a9 Miklos Szeredi 2019-09-10  1070  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719A84B3B3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Feb 2022 13:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiBMMND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Feb 2022 07:13:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiBMMNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:13:02 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64675BD2A;
        Sun, 13 Feb 2022 04:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644754376; x=1676290376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yzLnWnxNGxbK29grs7DUzHv3uNkGGxIZFs8Q6SDa+ro=;
  b=ZvHS5GbHQ2aaZ3ZhVW/LE4tCT84QHzjEKZvFvgxX9Zagzaf+baftEgsO
   2TpgJYfLltEjge2KIDCC/a7Jg4rGQB+u4Yj9naE8JMQd13lMO5hL2+6+n
   ktVO24qR/j5O/NGhFkLPcZxxSV8LikIXvgK1E5tFpRb40vFm6Z+04BXqT
   cp2o8BQFk+tcbvVlfUpAHHvhv2y9FvXjlrwesZeqaNfWg4HL/NcAJnsgB
   Qulc2NrsIpjDg15290OsSF/hB9WrAFdD40HimDrjcZn7Jf4UhLO/hEGim
   WVLi35NNN9YLuwLXfq6eS8lEOJDq2/B1DPTUJxtwkUYQB2vz7UEQd5XCs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="250150616"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="250150616"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 04:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="569517523"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2022 04:12:53 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJDkK-0007Tf-Lp; Sun, 13 Feb 2022 12:12:52 +0000
Date:   Sun, 13 Feb 2022 20:12:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Ni <nizhen@uniontech.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zhen Ni <nizhen@uniontech.com>
Subject: Re: [PATCH] sched: move deadline_period sysctls to deadline.c
Message-ID: <202202132047.Oh4JMFtB-lkp@intel.com>
References: <20220211070014.30764-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211070014.30764-1-nizhen@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Zhen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master kees/for-next/pstore v5.17-rc3 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhen-Ni/sched-move-deadline_period-sysctls-to-deadline-c/20220211-150312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git c8eaf6ac76f40f6c59fc7d056e2e08c4a57ea9c7
config: arm-randconfig-c002-20220213 (https://download.01.org/0day-ci/archive/20220213/202202132047.Oh4JMFtB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c785b6fd90f2f1a7dc49c7fcbd30ad54ecff0e75
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhen-Ni/sched-move-deadline_period-sysctls-to-deadline-c/20220211-150312
        git checkout c785b6fd90f2f1a7dc49c7fcbd30ad54ecff0e75
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/sched/deadline.c:49:20: error: 'sched_dl_sysctl_init' defined but not used [-Werror=unused-function]
      49 | static void __init sched_dl_sysctl_init(void)
         |                    ^~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/sched_dl_sysctl_init +49 kernel/sched/deadline.c

    48	
  > 49	static void __init sched_dl_sysctl_init(void)
    50	{
    51		register_sysctl_init("kernel", sched_dl_sysctls);
    52	}
    53	#else
    54	#define sched_dl_sysctl_init() do { } while (0)
    55	#endif
    56	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

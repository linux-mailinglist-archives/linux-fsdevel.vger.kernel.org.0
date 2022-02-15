Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538694B64B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiBOHr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:47:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiBOHrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:47:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1E8A302;
        Mon, 14 Feb 2022 23:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644911263; x=1676447263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y0bK4/YVa6yni5c6SCvDJQZbNovCVQ7HiRI/cjiwXe8=;
  b=ROMjvbYY1zK31QO1CAh8EdQNq93w9bltIoJWgTQgUCGmRgZRwgbr4fIS
   Bo2LfmFcyG9SybAFkOFToc3BRU2jQVlnSGSF+TYMsQL0UCEhGEjiP8NYo
   we1MR5YvdPeOJLBFzttCB3BClvdCvxC18EYmFUwHum80z7bI/mLU5bMZ8
   IjhiS/sLCbyrADt044V9NWPwoLhW9qdK0UUEPWplmIZLNGp/Ww6FwB67B
   0thq6IKEdCZB3nUlLG3IDr4mI/PsEoHRw7f8PZ6gQ5u6jbHKFj1Ikitna
   kkCQhs2oXAWCKzp0aDgMFJA2LmvkfVJbik7Q1DWDYc7tpsoRaO/yMTHQb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237683108"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="237683108"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 23:47:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="486016918"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2022 23:47:40 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJsYl-0009Qk-A6; Tue, 15 Feb 2022 07:47:39 +0000
Date:   Tue, 15 Feb 2022 15:47:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Ni <nizhen@uniontech.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zhen Ni <nizhen@uniontech.com>
Subject: Re: [PATCH 3/8] sched: Move rt_period/runtime sysctls to rt.c
Message-ID: <202202151509.TszSxsaB-lkp@intel.com>
References: <20220215052214.5286-4-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215052214.5286-4-nizhen@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Zhen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master kees/for-next/pstore v5.17-rc4]
[cannot apply to next-20220214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhen-Ni/sched-Move-a-series-of-sysctls-starting-with-sys-kernel-sched_/20220215-132416
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 3624ba7b5e2acc02b01301ea5fd3534971eb9896
config: parisc-randconfig-r023-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151509.TszSxsaB-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f93266963b3b3629980fa3384a5e37fd13f4c350
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhen-Ni/sched-Move-a-series-of-sysctls-starting-with-sys-kernel-sched_/20220215-132416
        git checkout f93266963b3b3629980fa3384a5e37fd13f4c350
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/rcu/rcutorture.c: In function 'rcu_torture_disable_rt_throttle':
>> kernel/rcu/rcutorture.c:921:26: error: 'sysctl_sched_rt_runtime' undeclared (first use in this function); did you mean 'sysctl_sched_rr_timeslice'?
     921 |         old_rt_runtime = sysctl_sched_rt_runtime;
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
         |                          sysctl_sched_rr_timeslice
   kernel/rcu/rcutorture.c:921:26: note: each undeclared identifier is reported only once for each function it appears in
   kernel/rcu/rcutorture.c: In function 'rcu_torture_enable_rt_throttle':
   kernel/rcu/rcutorture.c:930:9: error: 'sysctl_sched_rt_runtime' undeclared (first use in this function); did you mean 'sysctl_sched_rr_timeslice'?
     930 |         sysctl_sched_rt_runtime = old_rt_runtime;
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         sysctl_sched_rr_timeslice


vim +921 kernel/rcu/rcutorture.c

450efca7182a51 Joel Fernandes (Google  2018-06-10  909) 
450efca7182a51 Joel Fernandes (Google  2018-06-10  910) static void rcu_torture_disable_rt_throttle(void)
450efca7182a51 Joel Fernandes (Google  2018-06-10  911) {
450efca7182a51 Joel Fernandes (Google  2018-06-10  912) 	/*
450efca7182a51 Joel Fernandes (Google  2018-06-10  913) 	 * Disable RT throttling so that rcutorture's boost threads don't get
450efca7182a51 Joel Fernandes (Google  2018-06-10  914) 	 * throttled. Only possible if rcutorture is built-in otherwise the
450efca7182a51 Joel Fernandes (Google  2018-06-10  915) 	 * user should manually do this by setting the sched_rt_period_us and
450efca7182a51 Joel Fernandes (Google  2018-06-10  916) 	 * sched_rt_runtime sysctls.
450efca7182a51 Joel Fernandes (Google  2018-06-10  917) 	 */
450efca7182a51 Joel Fernandes (Google  2018-06-10  918) 	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
450efca7182a51 Joel Fernandes (Google  2018-06-10  919) 		return;
450efca7182a51 Joel Fernandes (Google  2018-06-10  920) 
450efca7182a51 Joel Fernandes (Google  2018-06-10 @921) 	old_rt_runtime = sysctl_sched_rt_runtime;
450efca7182a51 Joel Fernandes (Google  2018-06-10  922) 	sysctl_sched_rt_runtime = -1;
450efca7182a51 Joel Fernandes (Google  2018-06-10  923) }
450efca7182a51 Joel Fernandes (Google  2018-06-10  924) 

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

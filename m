Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D54E4B6AA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiBOLYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:24:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiBOLYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:24:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A3C10819F;
        Tue, 15 Feb 2022 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644924230; x=1676460230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=46LFxJCiFqOVmiEgnWu34/ezZcwww1Q9UDY5Wf4Fb8c=;
  b=do2k2pGuXrFRIatNNhEcYReCuYXyvcsd+kJrrW/83hjB60lJMaIzpMyu
   /UKO9h5eyubJ8oA70bzNuF7bMAGk/6Ct+/L0D7kvrPF1UdUfTUl314jSH
   Iiausse4jkjtZ7f6B3lRdGRkfxSntW9YSuHLawVv7fMmYWR9BMl75wq5s
   fBNTsz9dB8TonGBrSaDOtQQwHRT/FcviGsUfzqe6t8Sd0UnYFrxcH4+IY
   C5fEwWg2QWCW7p8fqdRIhdISxGmtM8gzu1/UBcdZFATXTSiqAW9UzTiii
   9pZv4q5QF3UDWa4xB1X3J8YEw3N7yOYNyBEb38IcBm5Ly3m9QxrIG6ajt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249164819"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="249164819"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 03:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="502379528"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2022 03:23:46 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJvvt-0009at-W4; Tue, 15 Feb 2022 11:23:45 +0000
Date:   Tue, 15 Feb 2022 19:23:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Ni <nizhen@uniontech.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: Re: [PATCH 3/8] sched: Move rt_period/runtime sysctls to rt.c
Message-ID: <202202151705.Uez40mBM-lkp@intel.com>
References: <20220215052214.5286-4-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215052214.5286-4-nizhen@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
[also build test ERROR on linus/master kees/for-next/pstore v5.17-rc4]
[cannot apply to next-20220214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhen-Ni/sched-Move-a-series-of-sysctls-starting-with-sys-kernel-sched_/20220215-132416
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 3624ba7b5e2acc02b01301ea5fd3534971eb9896
config: hexagon-randconfig-r033-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151705.Uez40mBM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f93266963b3b3629980fa3384a5e37fd13f4c350
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhen-Ni/sched-Move-a-series-of-sysctls-starting-with-sys-kernel-sched_/20220215-132416
        git checkout f93266963b3b3629980fa3384a5e37fd13f4c350
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/rcu/rcutorture.c:380:16: warning: variable 'started' set but not used [-Wunused-but-set-variable]
           unsigned long started;
                         ^
   kernel/rcu/rcutorture.c:381:16: warning: variable 'completed' set but not used [-Wunused-but-set-variable]
           unsigned long completed;
                         ^
   kernel/rcu/rcutorture.c:384:21: warning: variable 'ts' set but not used [-Wunused-but-set-variable]
           unsigned long long ts;
                              ^
>> kernel/rcu/rcutorture.c:921:19: error: use of undeclared identifier 'sysctl_sched_rt_runtime'; did you mean 'sysctl_sched_rr_timeslice'?
           old_rt_runtime = sysctl_sched_rt_runtime;
                            ^~~~~~~~~~~~~~~~~~~~~~~
                            sysctl_sched_rr_timeslice
   include/linux/sched/sysctl.h:37:12: note: 'sysctl_sched_rr_timeslice' declared here
   extern int sysctl_sched_rr_timeslice;
              ^
   kernel/rcu/rcutorture.c:922:2: error: use of undeclared identifier 'sysctl_sched_rt_runtime'
           sysctl_sched_rt_runtime = -1;
           ^
   kernel/rcu/rcutorture.c:930:2: error: use of undeclared identifier 'sysctl_sched_rt_runtime'
           sysctl_sched_rt_runtime = old_rt_runtime;
           ^
   kernel/rcu/rcutorture.c:1620:21: warning: variable 'ts' set but not used [-Wunused-but-set-variable]
           unsigned long long ts;
                              ^
   4 warnings and 3 errors generated.


vim +921 kernel/rcu/rcutorture.c

450efca7182a516 Joel Fernandes (Google  2018-06-10  909) 
450efca7182a516 Joel Fernandes (Google  2018-06-10  910) static void rcu_torture_disable_rt_throttle(void)
450efca7182a516 Joel Fernandes (Google  2018-06-10  911) {
450efca7182a516 Joel Fernandes (Google  2018-06-10  912) 	/*
450efca7182a516 Joel Fernandes (Google  2018-06-10  913) 	 * Disable RT throttling so that rcutorture's boost threads don't get
450efca7182a516 Joel Fernandes (Google  2018-06-10  914) 	 * throttled. Only possible if rcutorture is built-in otherwise the
450efca7182a516 Joel Fernandes (Google  2018-06-10  915) 	 * user should manually do this by setting the sched_rt_period_us and
450efca7182a516 Joel Fernandes (Google  2018-06-10  916) 	 * sched_rt_runtime sysctls.
450efca7182a516 Joel Fernandes (Google  2018-06-10  917) 	 */
450efca7182a516 Joel Fernandes (Google  2018-06-10  918) 	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
450efca7182a516 Joel Fernandes (Google  2018-06-10  919) 		return;
450efca7182a516 Joel Fernandes (Google  2018-06-10  920) 
450efca7182a516 Joel Fernandes (Google  2018-06-10 @921) 	old_rt_runtime = sysctl_sched_rt_runtime;
450efca7182a516 Joel Fernandes (Google  2018-06-10  922) 	sysctl_sched_rt_runtime = -1;
450efca7182a516 Joel Fernandes (Google  2018-06-10  923) }
450efca7182a516 Joel Fernandes (Google  2018-06-10  924) 

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

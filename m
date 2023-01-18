Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D15672CC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 00:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjARXo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 18:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjARXoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:44:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC2E4CE76;
        Wed, 18 Jan 2023 15:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674085464; x=1705621464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Yh3EAC0PxCdi2jFquKgMR9NhSAoOEHy7pAX3WXIBO8=;
  b=VTjrJBqoRR1pqkBa6JoDhzSkA1jguwvcENUYIfJJIz845NIuhJ4olPhc
   d1ir/nCjpRYoNgj18+bcmfHlxeLRpeJH0RcuEifT9UiBANi+SithfrCO+
   OFqR9c/aQjkpp1HRrV3Kq3+5/27skJLZ/gIJ9x2JkqGH4hT0PWbdnKh6D
   RpOJwOHGIE7NkBpAIm9q+zV8NWIyaccYeck0RmAT7Qo+4f/6fX3e1gjSn
   9sCxCnTXkkWoya/QuXqBm8CONJesoYfROFUJNB7f19X5vDLGrs+/laGna
   FwrMfzi9BFROvA+zlcVfzXSumTfsUs+MvTWG5UQWIY3u0PldH9uRn1kMo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304820202"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="304820202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:44:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="748679199"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="748679199"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2023 15:44:20 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pII6N-0000ow-1E;
        Wed, 18 Jan 2023 23:44:19 +0000
Date:   Thu, 19 Jan 2023 07:43:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        adobriyan@gmail.com, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <202301190722.ouyr6mLZ-lkp@intel.com>
References: <20230118201055.147228-4-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118201055.147228-4-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gregory,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc4 next-20230118]
[cannot apply to tip/core/entry]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/ptrace-syscall_user_dispatch-Implement-Syscall-User-Dispatch-Suspension/20230119-041259
patch link:    https://lore.kernel.org/r/20230118201055.147228-4-gregory.price%40memverge.com
patch subject: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter for sud configuration
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230119/202301190722.ouyr6mLZ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bd6833b41ed48c444c09346f695efe229deec2e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gregory-Price/ptrace-syscall_user_dispatch-Implement-Syscall-User-Dispatch-Suspension/20230119-041259
        git checkout bd6833b41ed48c444c09346f695efe229deec2e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/sched.h:31,
                    from arch/m68k/kernel/asm-offsets.c:15:
>> include/linux/syscall_user_dispatch.h:45:5: warning: no previous prototype for 'syscall_user_dispatch_get_config' [-Wmissing-prototypes]
      45 | int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/syscall_user_dispatch.h:51:5: warning: no previous prototype for 'syscall_user_dispatch_set_config' [-Wmissing-prototypes]
      51 | int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from include/linux/sched.h:31,
                    from arch/m68k/kernel/asm-offsets.c:15:
>> include/linux/syscall_user_dispatch.h:45:5: warning: no previous prototype for 'syscall_user_dispatch_get_config' [-Wmissing-prototypes]
      45 | int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/syscall_user_dispatch.h:51:5: warning: no previous prototype for 'syscall_user_dispatch_set_config' [-Wmissing-prototypes]
      51 | int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/syscall_user_dispatch_get_config +45 include/linux/syscall_user_dispatch.h

    44	
  > 45	int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
    46		void __user *data)
    47	{
    48		return -EINVAL;
    49	}
    50	
  > 51	int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
    52		void __user *data)
    53	{
    54		return -EINVAL;
    55	}
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

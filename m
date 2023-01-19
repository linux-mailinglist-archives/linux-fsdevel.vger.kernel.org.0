Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AEE672F13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 03:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjASCjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 21:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:39:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980FD69B37;
        Wed, 18 Jan 2023 18:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674095977; x=1705631977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G/dmJqT2Xj1iMyfuzcvUrdcL1Qhb/ASAsS90qZQMtJ8=;
  b=fOCGk3bI+zXZT515dPdiW9FuYQQlrRLMrT3ZuBqjxLJozvdihR5Bv5gn
   XyEuWDXdXyBMxBnaUC4thUGkZrKw/9/xMwmFdqllHF/EOOxdAkHMNlcNW
   CiUW/HvdjOe1xPraZyRAmCwZKmcJvZqXAB/fCLBYMdhm5pNw1Z2QP0nSW
   lXEzgPPC3ZYmCMrB1WyTatpI8n2A9+erZ8KszJgvNGbbtDuIJ5Mc2emXX
   TY10UWwIyP2SUG+LXaUnSdW5I4VyWPiSloyR99WpbUcZPmAo8cg5uWgCl
   Sh1l0yyva2hToMKrY7314p4K2f2+fW5jTXznPINkVR8O52iSfD2g4FKpu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323857732"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323857732"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 18:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="692253881"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="692253881"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Jan 2023 18:39:32 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIKpq-0000yo-0g;
        Thu, 19 Jan 2023 02:39:26 +0000
Date:   Thu, 19 Jan 2023 10:39:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <202301191010.U5yAKr05-lkp@intel.com>
References: <20230118201055.147228-4-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118201055.147228-4-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20230119/202301191010.U5yAKr05-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/bd6833b41ed48c444c09346f695efe229deec2e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gregory-Price/ptrace-syscall_user_dispatch-Implement-Syscall-User-Dispatch-Suspension/20230119-041259
        git checkout bd6833b41ed48c444c09346f695efe229deec2e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/entry/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/entry/syscall_user_dispatch.c:128:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed char [usertype] *[assigned] selector @@     got char [noderef] __user *selector @@
   kernel/entry/syscall_user_dispatch.c:128:33: sparse:     expected signed char [usertype] *[assigned] selector
   kernel/entry/syscall_user_dispatch.c:128:33: sparse:     got char [noderef] __user *selector
>> kernel/entry/syscall_user_dispatch.c:156:31: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected char [noderef] __user *selector @@     got signed char [usertype] *[addressable] selector @@
   kernel/entry/syscall_user_dispatch.c:156:31: sparse:     expected char [noderef] __user *selector
   kernel/entry/syscall_user_dispatch.c:156:31: sparse:     got signed char [usertype] *[addressable] selector

vim +128 kernel/entry/syscall_user_dispatch.c

   114	
   115	int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
   116			void __user *data)
   117	{
   118		struct syscall_user_dispatch *sd = &task->syscall_dispatch;
   119		struct syscall_user_dispatch_config config;
   120	
   121		if (size != sizeof(struct syscall_user_dispatch_config))
   122			return -EINVAL;
   123	
   124		if (sd->selector) {
   125			config.mode = PR_SYS_DISPATCH_ON;
   126			config.offset = sd->offset;
   127			config.len = sd->len;
 > 128			config.selector = sd->selector;
   129			config.on_dispatch = sd->on_dispatch;
   130		} else {
   131			config.mode = PR_SYS_DISPATCH_OFF;
   132			config.offset = 0;
   133			config.len = 0;
   134			config.selector = NULL;
   135			config.on_dispatch = false;
   136		}
   137		if (copy_to_user(data, &config, sizeof(config)))
   138			return -EFAULT;
   139	
   140		return 0;
   141	}
   142	
   143	int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
   144			void __user *data)
   145	{
   146		struct syscall_user_dispatch_config config;
   147		int ret;
   148	
   149		if (size != sizeof(struct syscall_user_dispatch_config))
   150			return -EINVAL;
   151	
   152		if (copy_from_user(&config, data, sizeof(config)))
   153			return -EFAULT;
   154	
   155		ret = set_syscall_user_dispatch(config.mode, config.offset, config.len,
 > 156				config.selector);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

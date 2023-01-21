Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83967665B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 14:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjAUNFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 08:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAUNFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:05:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720B2B0A7;
        Sat, 21 Jan 2023 05:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674306328; x=1705842328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hQqpAboKcp0CU8eDrws4JPIasl3/c8rUFWjk4p58ebE=;
  b=FxaTTy7VA4/eUBx7ADs5k2VWhx435auA+At2gPhj27d64GdhPZCtTqnF
   0qWTNLCqds8T8rcZ5PkGrCf/5rv3xc+dgHreq8/V4417CkBkVzUSKmg2y
   0+w9jQ26i5bYOXJfGtVBJMzpbwxAhA9667uZ1SeVzx0SHvyccxaAH3Wpq
   gXhWWTGmHYVbJfTbRg9Uu32UVMiF5h6iP8VaTcxIObvjLmM6elKxVQ4Ov
   GHHnlVMkif10LEk2anL0rKa4Vhl49ufCVacCHc6ZNfhEqZiaUmX0kcQ5z
   a7eAQkv6QI9xlvCxwvSnoN1jlZaQklJZlj+CU4i5yfB/72OWizz6C6FmN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="412015627"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="412015627"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 05:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="654087127"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="654087127"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2023 05:05:22 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJDYf-00045G-0s;
        Sat, 21 Jan 2023 13:05:21 +0000
Date:   Sat, 21 Jan 2023 21:04:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v4 2/3] fs/proc/array: Add Syscall User Dispatch to proc
 status
Message-ID: <202301212030.oAj9QJnD-lkp@intel.com>
References: <20230121102316.331935-3-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121102316.331935-3-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gregory,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2-rc4 next-20230120]
[cannot apply to tip/core/entry]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/ptrace-syscall_user_dispatch-Implement-Syscall-User-Dispatch-Suspension/20230121-182401
patch link:    https://lore.kernel.org/r/20230121102316.331935-3-gregory.price%40memverge.com
patch subject: [PATCH v4 2/3] fs/proc/array: Add Syscall User Dispatch to proc status
config: arc-randconfig-r043-20230119 (https://download.01.org/0day-ci/archive/20230121/202301212030.oAj9QJnD-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a2cb8440d45e7d3030e7349c7c598971a951e5f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gregory-Price/ptrace-syscall_user_dispatch-Implement-Syscall-User-Dispatch-Suspension/20230121-182401
        git checkout a2cb8440d45e7d3030e7349c7c598971a951e5f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/current.h:5,
                    from arch/arc/include/asm/current.h:20,
                    from include/linux/sched.h:12,
                    from include/linux/time_namespace.h:6,
                    from fs/proc/array.c:59:
   fs/proc/array.c: In function 'task_syscall_user_dispatch':
>> include/linux/thread_info.h:168:52: error: 'TIF_SYSCALL_USER_DISPATCH' undeclared (first use in this function); did you mean 'PR_SET_SYSCALL_USER_DISPATCH'?
     168 |         test_ti_thread_flag(current_thread_info(), TIF_##fl)
         |                                                    ^~~~
   fs/proc/array.c:435:29: note: in expansion of macro 'test_syscall_work'
     435 |                             test_syscall_work(SYSCALL_USER_DISPATCH));
         |                             ^~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:168:52: note: each undeclared identifier is reported only once for each function it appears in
     168 |         test_ti_thread_flag(current_thread_info(), TIF_##fl)
         |                                                    ^~~~
   fs/proc/array.c:435:29: note: in expansion of macro 'test_syscall_work'
     435 |                             test_syscall_work(SYSCALL_USER_DISPATCH));
         |                             ^~~~~~~~~~~~~~~~~


vim +168 include/linux/thread_info.h

3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  164  
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  165  #define set_syscall_work(fl)						\
5903f61e035320 Gabriel Krisman Bertazi 2020-11-23  166  	set_ti_thread_flag(current_thread_info(), TIF_##fl)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  167  #define test_syscall_work(fl) \
5903f61e035320 Gabriel Krisman Bertazi 2020-11-23 @168  	test_ti_thread_flag(current_thread_info(), TIF_##fl)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  169  #define clear_syscall_work(fl) \
5903f61e035320 Gabriel Krisman Bertazi 2020-11-23  170  	clear_ti_thread_flag(current_thread_info(), TIF_##fl)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  171  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

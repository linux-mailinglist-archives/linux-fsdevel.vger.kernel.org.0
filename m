Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C686F9284
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 16:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjEFO12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 10:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjEFO10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 10:27:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C019936;
        Sat,  6 May 2023 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683383245; x=1714919245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1CM9sz3xyD29vV94S0eoChIFsorjvoMRR3Da8zuVnF4=;
  b=LYIxqVd95isXWzUD7qg6HeqbAc+p3SORCfxHFfHNQh784mvMtGo/z96X
   if9qDa91Ikzqv2uvIIO0BXp2JrrTtg6G3t2WfM3HlnB8OQLkdFizGjH0C
   ljjIBZ5XqNiKY2nmQxuTycGWFfXuFm4v6KaB4vLUw4WVBHOVgWFLxVfI4
   mf1fv+BqQhGrb3rqGLZx2GS9URZ4HWmg1U4jlMVttygW0AD6tk03P9cEe
   /7Vf3dqvj+mUiDDlsyOrBLjb4v/Q+PUmhx2F2Vb99ATNP0F0FmCdtm64q
   Bo4dEGLDrtLgXie+qs+bWLA3QEY46MGnxik//cNWRLzmK0gyS0FE/0fAq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="338596535"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="338596535"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 07:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="730733076"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="730733076"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2023 07:27:17 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvIsW-0000Lp-2f;
        Sat, 06 May 2023 14:27:16 +0000
Date:   Sat, 6 May 2023 22:27:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     chengkaitao <chengkaitao@didiglobal.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, brauner@kernel.org,
        muchun.song@linux.dev
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        viro@zeniv.linux.org.uk, zhengqi.arch@bytedance.com,
        ebiederm@xmission.com, Liam.Howlett@oracle.com,
        chengzhihao1@huawei.com, pilgrimtao@gmail.com,
        haolee.swjtu@gmail.com, yuzhao@google.com, willy@infradead.org,
        vasily.averin@linux.dev, vbabka@suse.cz, surenb@google.com,
        sfr@canb.auug.org.au, mcgrof@kernel.org, sujiaxun@uniontech.com,
        feng.tang@intel.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: memcontrol: protect the memory in cgroup from
 being oom killed
Message-ID: <202305062204.ob5SRKVX-lkp@intel.com>
References: <20230506114948.6862-2-chengkaitao@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506114948.6862-2-chengkaitao@didiglobal.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi chengkaitao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tj-cgroup/for-next linus/master v6.3 next-20230505]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/chengkaitao/mm-memcontrol-protect-the-memory-in-cgroup-from-being-oom-killed/20230506-195043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230506114948.6862-2-chengkaitao%40didiglobal.com
patch subject: [PATCH v3 1/2] mm: memcontrol: protect the memory in cgroup from being oom killed
config: i386-randconfig-a011-20230501 (https://download.01.org/0day-ci/archive/20230506/202305062204.ob5SRKVX-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a2779b308166286f77728f04043cb7a17a16dd46
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review chengkaitao/mm-memcontrol-protect-the-memory-in-cgroup-from-being-oom-killed/20230506-195043
        git checkout a2779b308166286f77728f04043cb7a17a16dd46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305062204.ob5SRKVX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/page_counter.c:44:36: warning: overflow in expression; result is -2147483648 with type 'long' [-Winteger-overflow]
           if (protected == PAGE_COUNTER_MAX + 1)
                                             ^
   1 warning generated.
--
   mm/memcontrol.c:1739:2: error: implicit declaration of function 'seq_buf_do_printk' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           seq_buf_do_printk(&s, KERN_INFO);
           ^
>> mm/memcontrol.c:6445:37: warning: overflow in expression; result is -2147483648 with type 'long' [-Winteger-overflow]
           else if (value == PAGE_COUNTER_MAX + 1)
                                              ^
   mm/memcontrol.c:6743:34: warning: overflow in expression; result is -2147483648 with type 'long' [-Winteger-overflow]
                   oom_protect = PAGE_COUNTER_MAX + 1;
                                                  ^
   2 warnings and 1 error generated.


vim +/long +44 mm/page_counter.c

    15	
    16	static void propagate_protected_usage(struct page_counter *c,
    17					      unsigned long usage)
    18	{
    19		unsigned long protected, old_protected;
    20		long delta;
    21	
    22		if (!c->parent)
    23			return;
    24	
    25		protected = min(usage, READ_ONCE(c->min));
    26		old_protected = atomic_long_read(&c->min_usage);
    27		if (protected != old_protected) {
    28			old_protected = atomic_long_xchg(&c->min_usage, protected);
    29			delta = protected - old_protected;
    30			if (delta)
    31				atomic_long_add(delta, &c->parent->children_min_usage);
    32		}
    33	
    34		protected = min(usage, READ_ONCE(c->low));
    35		old_protected = atomic_long_read(&c->low_usage);
    36		if (protected != old_protected) {
    37			old_protected = atomic_long_xchg(&c->low_usage, protected);
    38			delta = protected - old_protected;
    39			if (delta)
    40				atomic_long_add(delta, &c->parent->children_low_usage);
    41		}
    42	
    43		protected = READ_ONCE(c->oom_protect);
  > 44		if (protected == PAGE_COUNTER_MAX + 1)
    45			protected = atomic_long_read(&c->children_oom_protect_usage);
    46		else
    47			protected = min(usage, protected);
    48		old_protected = atomic_long_read(&c->oom_protect_usage);
    49		if (protected != old_protected) {
    50			old_protected = atomic_long_xchg(&c->oom_protect_usage, protected);
    51			delta = protected - old_protected;
    52			if (delta)
    53				atomic_long_add(delta, &c->parent->children_oom_protect_usage);
    54		}
    55	}
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4358BB4A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Aug 2022 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiHGO3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Aug 2022 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiHGO3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:29:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D3D6551;
        Sun,  7 Aug 2022 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659882577; x=1691418577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ec+9X1cwyjRbQc8NJ24vIRGWj7FRNthES/25WYKDWBI=;
  b=f+5MMB69QD1kJ+RX/nGkMwY0mUhHO6/BapaaLs9+8OGWH5zaUTZvfIJv
   On0dS7RGvP27aacHlw6tBHqUqRPDAiMobMauuVH1Yxx7HiCesNZW85q3A
   78h58BXPNSzFwTk9Up6toc/ij79BxXcKtuLJuWCQ7O1znIjcet+i75KQb
   A9Fmg1Nz3vTfd1cpn2GAGjOGsBXh2M5nXwLnRbP4nbRC/2XxrgueseLnR
   GzyV0pqgs5wn/DwwWf4K7dh/rO59HZK+1Dp5ah3Gncbc1KG5AV6fBS5Ed
   iRUfw9Ext6TJoNFGs2h7Y7/tFi+0DBMDsqEnnVCSn1bWJlWP2rR7oiVgM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="289199048"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="289199048"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 07:29:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="554625951"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2022 07:29:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKhHa-000LMN-0O;
        Sun, 07 Aug 2022 14:29:34 +0000
Date:   Sun, 7 Aug 2022 22:28:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH 1/3] proc: Add get_task_cmdline_kernel() function
Message-ID: <202208072219.zrLROtui-lkp@intel.com>
References: <20220801152016.36498-2-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801152016.36498-2-deller@gmx.de>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Helge,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/x86/mm]
[also build test WARNING on linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Helge-Deller/Dump-command-line-of-faulting-process-to-syslog/20220801-232209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8f1d56f64f8d6b80dea2d1978d10071132a695c5
config: hexagon-randconfig-r005-20220801 (https://download.01.org/0day-ci/archive/20220807/202208072219.zrLROtui-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/82149c3c87cadf0a362c3015753f97c7582f31e4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Helge-Deller/Dump-command-line-of-faulting-process-to-syslog/20220801-232209
        git checkout 82149c3c87cadf0a362c3015753f97c7582f31e4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:84:
   In file included from kernel/sched/sched.h:50:
>> include/linux/proc_fs.h:222:64: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                  ^
   include/linux/proc_fs.h:222:72: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                          ^
   include/linux/proc_fs.h:222:80: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                                  ^
   kernel/sched/core.c:3577:20: warning: unused function 'rq_has_pinned_tasks' [-Wunused-function]
   static inline bool rq_has_pinned_tasks(struct rq *rq)
                      ^
   kernel/sched/core.c:5505:20: warning: unused function 'sched_tick_start' [-Wunused-function]
   static inline void sched_tick_start(int cpu) { }
                      ^
   kernel/sched/core.c:5506:20: warning: unused function 'sched_tick_stop' [-Wunused-function]
   static inline void sched_tick_stop(int cpu) { }
                      ^
   kernel/sched/core.c:6200:20: warning: unused function 'sched_core_cpu_starting' [-Wunused-function]
   static inline void sched_core_cpu_starting(unsigned int cpu) {}
                      ^
   kernel/sched/core.c:6201:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
   static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
                      ^
   kernel/sched/core.c:6202:20: warning: unused function 'sched_core_cpu_dying' [-Wunused-function]
   static inline void sched_core_cpu_dying(unsigned int cpu) {}
                      ^
   9 warnings generated.
--
   In file included from kernel/sched/fair.c:54:
   In file included from kernel/sched/sched.h:50:
>> include/linux/proc_fs.h:222:64: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                  ^
   include/linux/proc_fs.h:222:72: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                          ^
   include/linux/proc_fs.h:222:80: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                                  ^
   kernel/sched/fair.c:5512:6: warning: no previous prototype for function 'init_cfs_bandwidth' [-Wmissing-prototypes]
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
        ^
   kernel/sched/fair.c:5512:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
   ^
   static 
   kernel/sched/fair.c:11697:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
   void free_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11697:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11699:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/fair.c:11699:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   kernel/sched/fair.c:11704:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
   void online_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11704:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void online_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11706:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
   void unregister_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11706:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:489:20: warning: unused function 'list_del_leaf_cfs_rq' [-Wunused-function]
   static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
                      ^
   kernel/sched/fair.c:510:19: warning: unused function 'tg_is_idle' [-Wunused-function]
   static inline int tg_is_idle(struct task_group *tg)
                     ^
   kernel/sched/fair.c:2961:20: warning: unused function 'account_numa_enqueue' [-Wunused-function]
   static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p)
                      ^
   kernel/sched/fair.c:2965:20: warning: unused function 'account_numa_dequeue' [-Wunused-function]
   static inline void account_numa_dequeue(struct rq *rq, struct task_struct *p)
                      ^
   kernel/sched/fair.c:2969:20: warning: unused function 'update_scan_period' [-Wunused-function]
   static inline void update_scan_period(struct task_struct *p, int new_cpu)
                      ^
   kernel/sched/fair.c:4171:20: warning: unused function 'cfs_rq_is_decayed' [-Wunused-function]
   static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
                      ^
   kernel/sched/fair.c:4185:20: warning: unused function 'remove_entity_load_avg' [-Wunused-function]
   static inline void remove_entity_load_avg(struct sched_entity *se) {}
                      ^
   kernel/sched/fair.c:5493:20: warning: unused function 'sync_throttle' [-Wunused-function]
   static inline void sync_throttle(struct task_group *tg, int cpu) {}
                      ^
   kernel/sched/fair.c:5506:19: warning: unused function 'throttled_lb_pair' [-Wunused-function]
   static inline int throttled_lb_pair(struct task_group *tg,
                     ^
   kernel/sched/fair.c:5518:37: warning: unused function 'tg_cfs_bandwidth' [-Wunused-function]
   static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
                                       ^
   kernel/sched/fair.c:5522:20: warning: unused function 'destroy_cfs_bandwidth' [-Wunused-function]
   static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
                      ^
   kernel/sched/fair.c:5523:20: warning: unused function 'update_runtime_enabled' [-Wunused-function]
   static inline void update_runtime_enabled(struct rq *rq) {}
                      ^
   kernel/sched/fair.c:5524:20: warning: unused function 'unthrottle_offline_cfs_rqs' [-Wunused-function]
   static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
                      ^
   21 warnings generated.
--
   In file included from kernel/sched/build_policy.c:34:
   In file included from kernel/sched/sched.h:50:
>> include/linux/proc_fs.h:222:64: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                  ^
   include/linux/proc_fs.h:222:72: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                          ^
   include/linux/proc_fs.h:222:80: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                                  ^
   In file included from kernel/sched/build_policy.c:45:
   kernel/sched/rt.c:259:6: warning: no previous prototype for function 'unregister_rt_sched_group' [-Wmissing-prototypes]
   void unregister_rt_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/rt.c:259:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_rt_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/rt.c:261:6: warning: no previous prototype for function 'free_rt_sched_group' [-Wmissing-prototypes]
   void free_rt_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/rt.c:261:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_rt_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/rt.c:263:5: warning: no previous prototype for function 'alloc_rt_sched_group' [-Wmissing-prototypes]
   int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/rt.c:263:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   6 warnings generated.
--
   In file included from kernel/sched/build_utility.c:35:
>> include/linux/proc_fs.h:222:64: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                  ^
   include/linux/proc_fs.h:222:72: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                          ^
   include/linux/proc_fs.h:222:80: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
                                                                                  ^
   3 warnings generated.


vim +222 include/linux/proc_fs.h

   221	
 > 222	static inline void get_task_cmdline_kernel(struct task_struct *, char *, size_t) { }
   223	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

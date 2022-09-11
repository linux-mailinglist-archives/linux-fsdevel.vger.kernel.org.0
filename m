Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3757C5B50DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 21:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIKT2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIKT2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 15:28:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA002409B;
        Sun, 11 Sep 2022 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662924495; x=1694460495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s4EuC07vAwIDjbOA589p6Ip1/+sYbFGuGKpwv4CLn/I=;
  b=APe6SVxUjmDJSeZm2gCzn13ETF2ODZ7UqnEczuZe+omSblpG9V2vLk6h
   HOj2TunIf900HL/GyOzw9p4wGgUO3lHux9u78thntqq6MZlqyJfMxVN8q
   kGokH3QdTUC3tCKr93zMoPdwzxuncoEykY3THUWONNrpgKyGNya//isph
   FJKp38Or6ac7JbVo+a5t39eJElfjY+XXF/f5ZH6CiKGGwRuIYfuDFq857
   xgnulWFiTPKSTaAVCcBV+wRZUGCT3Sf09PK/3Kv4LwfWAYt2WpByi0GEa
   dtPpljy3/rx0D3k8N2RUqLKd5KKUZwae06/1Bly/YCaxF1eUH0FlhOaXh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="384042899"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="384042899"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 12:28:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="860940810"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2022 12:28:10 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXSce-0001ix-1o;
        Sun, 11 Sep 2022 19:28:04 +0000
Date:   Mon, 12 Sep 2022 03:27:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-ia64@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@openvz.org
Subject: Re: [PATCH v3 1/2] Add CABA tree to task_struct
Message-ID: <202209120356.YizhqUik-lkp@intel.com>
References: <20220908140313.313020-2-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908140313.313020-2-ptikhomirov@virtuozzo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Pavel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on kees/for-next/execve tip/sched/core linus/master v6.0-rc4 next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/Introduce-CABA-helper-process-tree/20220908-220639
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
config: ia64-randconfig-s041-20220911 (https://download.01.org/0day-ci/archive/20220912/202209120356.YizhqUik-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/17a897a33137d4f49f99c8be8d619f6f711fccdb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pavel-Tikhomirov/Introduce-CABA-helper-process-tree/20220908-220639
        git checkout 17a897a33137d4f49f99c8be8d619f6f711fccdb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash arch/ia64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/ia64/kernel/mca.c:504:1: sparse: sparse: symbol 'search_mca_table' was not declared. Should it be static?
   arch/ia64/kernel/mca.c:607:1: sparse: sparse: symbol 'ia64_mca_register_cpev' was not declared. Should it be static?
   arch/ia64/kernel/mca.c:831:5: sparse: sparse: symbol 'ia64_mca_ucmc_extension' was not declared. Should it be static?
   arch/ia64/kernel/mca.c:1793:36: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct *group_leader @@
   arch/ia64/kernel/mca.c:1793:36: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   arch/ia64/kernel/mca.c:1793:36: sparse:     got struct task_struct *group_leader
>> arch/ia64/kernel/mca.c:1796:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *caba @@     got struct task_struct *p @@
   arch/ia64/kernel/mca.c:1796:17: sparse:     expected struct task_struct [noderef] __rcu *caba
   arch/ia64/kernel/mca.c:1796:17: sparse:     got struct task_struct *p
   arch/ia64/kernel/mca.c:2106:43: sparse: sparse: Using plain integer as NULL pointer

vim +1796 arch/ia64/kernel/mca.c

  1770	
  1771	/* Minimal format of the MCA/INIT stacks.  The pseudo processes that run on
  1772	 * these stacks can never sleep, they cannot return from the kernel to user
  1773	 * space, they do not appear in a normal ps listing.  So there is no need to
  1774	 * format most of the fields.
  1775	 */
  1776	
  1777	static void
  1778	format_mca_init_stack(void *mca_data, unsigned long offset,
  1779			const char *type, int cpu)
  1780	{
  1781		struct task_struct *p = (struct task_struct *)((char *)mca_data + offset);
  1782		struct thread_info *ti;
  1783		memset(p, 0, KERNEL_STACK_SIZE);
  1784		ti = task_thread_info(p);
  1785		ti->flags = _TIF_MCA_INIT;
  1786		ti->preempt_count = 1;
  1787		ti->task = p;
  1788		ti->cpu = cpu;
  1789		p->stack = ti;
  1790		p->__state = TASK_UNINTERRUPTIBLE;
  1791		cpumask_set_cpu(cpu, &p->cpus_mask);
  1792		INIT_LIST_HEAD(&p->tasks);
  1793		p->parent = p->real_parent = p->group_leader = p;
  1794		INIT_LIST_HEAD(&p->children);
  1795		INIT_LIST_HEAD(&p->sibling);
> 1796		p->caba = p;
  1797		INIT_LIST_HEAD(&p->cabds);
  1798		INIT_LIST_HEAD(&p->cabd);
  1799		strncpy(p->comm, type, sizeof(p->comm)-1);
  1800	}
  1801	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

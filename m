Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA35539CC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 07:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbiFAFov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 01:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244172AbiFAFou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:44:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458E4C7AB;
        Tue, 31 May 2022 22:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654062289; x=1685598289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1sqm3JQDoLDrhWARKDhFVitl2lkVt0q//HmMCX54PtQ=;
  b=Kso7eyiXGnMmWZW7T/JDjhBAaTAdpC9Rsn7cIwV5yqI7dEnUzRafQvoy
   wVqW+VSm6VLMUXw+K0qOlG4zCEUDwoSH1r/reSq4M1REDHXfKiJ6YiEyd
   EWVubmEshCAse006B3TdSTmOUPevzzD2EqRfHyJVZ4prmDpNeYQ+y+UiX
   HRXrM+Y5UiQfy5eVy9oHb/KSu7UBtnkwN3pYpX7S+rP6TE0gXexsgAkFu
   YpAjBVMTCWhgmFiWXKwdcltgPKNU/Px/0aqRKCrPYI6uBdrHC45byglOI
   DX1KWHSR6xAq1oqpvdXwloDUdP5Zxh7NV1jYPdoCUsehZQIgQwyq0djSl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255957487"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="255957487"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 22:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="904299326"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2022 22:44:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwH9y-0003bM-92;
        Wed, 01 Jun 2022 05:44:46 +0000
Date:   Wed, 1 Jun 2022 13:44:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>, ebiederm@xmission.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v3] proc: Fix a dentry lock race between release_task and
 lookup
Message-ID: <202206011314.dh4oSNjS-lkp@intel.com>
References: <20220601023622.4191510-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601023622.4191510-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Zhihao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18 next-20220601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhihao-Cheng/proc-Fix-a-dentry-lock-race-between-release_task-and-lookup/20220601-102513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 700170bf6b4d773e328fa54ebb70ba444007c702
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220601/202206011314.dh4oSNjS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9dfec748ded82f145043dc08a944e1a9af7a640d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhihao-Cheng/proc-Fix-a-dentry-lock-race-between-release_task-and-lookup/20220601-102513
        git checkout 9dfec748ded82f145043dc08a944e1a9af7a640d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/proc/base.c:1929:15: warning: no previous prototype for function 'proc_pid_make_base_inode' [-Wmissing-prototypes]
   struct inode *proc_pid_make_base_inode(struct super_block *sb,
                 ^
   fs/proc/base.c:1929:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct inode *proc_pid_make_base_inode(struct super_block *sb,
   ^
   static 
   1 warning generated.


vim +/proc_pid_make_base_inode +1929 fs/proc/base.c

  1928	
> 1929	struct inode *proc_pid_make_base_inode(struct super_block *sb,
  1930					       struct task_struct *task, umode_t mode)
  1931	{
  1932		struct inode *inode;
  1933		struct proc_inode *ei;
  1934		struct pid *pid;
  1935	
  1936		inode = proc_pid_make_inode(sb, task, mode);
  1937		if (!inode)
  1938			return NULL;
  1939	
  1940		/* Let proc_flush_pid find this directory inode */
  1941		ei = PROC_I(inode);
  1942		pid = ei->pid;
  1943		spin_lock(&pid->lock);
  1944		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
  1945		spin_unlock(&pid->lock);
  1946	
  1947		return inode;
  1948	}
  1949	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

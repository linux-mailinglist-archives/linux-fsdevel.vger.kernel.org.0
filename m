Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE44DB8E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 20:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbiCPTiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 15:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiCPTit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:38:49 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC166211D;
        Wed, 16 Mar 2022 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647459454; x=1678995454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VoK7NCHknJwS9CczrBoyoyzwwOqpTK80AgOJjhOYGzQ=;
  b=TI011b3GxCKjXdsI65+orEqr0HKZoJxyaTALmWQ7Nj49PWhXLO4KcYEj
   DkAqT2yhTRVKXJ3kNr00l0+UzF3nTkRlNpOgCGhnNuqU5uxmEKJDhNuv4
   A2HXplAiF9PqPqeq34Ji9JIQvNEUTU4rp1LngkdXUESUzrPZfxW2XD/Z4
   inRN7S/8fi1lmxBk6dhAYQYmTW/QpLTg5buU553DurZeFr2gMXmjSmTSx
   CWIkgkos3GofpJVL8vtmWGYUzPfBQEyAfpEKkEgAuTwVCCaN2yGAil8ZC
   uWbWDxYcS2yEDVVA32wRP+rlmCIQQS/SbhIHmn3a+hpU+rPFkHiLFAfOp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317416690"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317416690"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="513158149"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2022 12:37:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUZSa-000CoG-0a; Wed, 16 Mar 2022 19:37:28 +0000
Date:   Thu, 17 Mar 2022 03:37:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 04/22] cachefiles: notify user daemon with anon_fd
 when looking up cookie
Message-ID: <202203170323.idYrKxCZ-lkp@intel.com>
References: <20220316131723.111553-5-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-5-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeffle,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on rostedt-trace/for-next linus/master v5.17-rc8]
[cannot apply to xiang-erofs/dev-test dhowells-fs/fscache-next next-20220316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220316-214711
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: ia64-randconfig-r033-20220317 (https://download.01.org/0day-ci/archive/20220317/202203170323.idYrKxCZ-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ef29cbdc09ec1e6ab918eaf5a16fa7ba8d23fb54
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220316-214711
        git checkout ef29cbdc09ec1e6ab918eaf5a16fa7ba8d23fb54
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash fs/cachefiles/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from fs/cachefiles/daemon.c:13:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   fs/cachefiles/daemon.c: In function 'cachefiles_ondemand_fd_write_iter':
>> fs/cachefiles/daemon.c:160:26: error: invalid use of undefined type 'struct iov_iter'
     160 |         size_t len = iter->count;
         |                          ^~


vim +160 fs/cachefiles/daemon.c

   153	
   154	static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
   155							 struct iov_iter *iter)
   156	{
   157		struct cachefiles_object *object = kiocb->ki_filp->private_data;
   158		struct cachefiles_cache *cache = object->volume->cache;
   159		struct file *file = object->file;
 > 160		size_t len = iter->count;
   161		loff_t pos = kiocb->ki_pos;
   162		const struct cred *saved_cred;
   163		int ret;
   164	
   165		if (!file)
   166			return -ENOBUFS;
   167	
   168		cachefiles_begin_secure(cache, &saved_cred);
   169		ret = __cachefiles_prepare_write(object, file, &pos, &len, true);
   170		cachefiles_end_secure(cache, saved_cred);
   171		if (ret < 0)
   172			return ret;
   173	
   174		ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
   175		if (!ret)
   176			ret = len;
   177	
   178		return ret;
   179	}
   180	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

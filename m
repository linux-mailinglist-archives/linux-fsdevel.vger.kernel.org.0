Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A104E7DD6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiCYUyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiCYUyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:54:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C550E16;
        Fri, 25 Mar 2022 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648241549; x=1679777549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P3gwNXe0u8BsPFKCZRFA9VltWIcjiuRgNKGEuiruPN4=;
  b=EpRaQlMnz3FJSTYspef0y0Z+QDbk3Hjm8KhHZVPY4BlRHstE14+DKenD
   +74Q2LMPMLWmiJIHJuKrD9AjYRkIlY8wTxMrNe9gTwfTGezUfk/ltzlLE
   9i9lkhaOMJlM0EDXUnT0BEm9r/IgJK8X8ieLtcUihYVaDTMeKCN9dWqVk
   J9NXQ2dveElqz9hAkdNNC4Wamx6DVGawZwXXW8f1J3pJkYn0TI5jW4AOv
   3BZd9gMsifVmxCHKI3hOewBBNdXrGO3J2GlgXlPvZl4WSoE2++BtiQ6MO
   pJAnrGilI2WelGuOfjY73R6/WzYpEZISLR5y033RA0BJlU15J6e6+g4yq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="238653260"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="238653260"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 13:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="826145419"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2022 13:52:24 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXqv2-000Mad-9K; Fri, 25 Mar 2022 20:52:24 +0000
Date:   Sat, 26 Mar 2022 04:52:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com
Subject: Re: [PATCH v6 03/22] cachefiles: notify user daemon with anon_fd
 when looking up cookie
Message-ID: <202203260406.Ay5o7T9U-lkp@intel.com>
References: <20220325122223.102958-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-4-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeffle,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on rostedt-trace/for-next linus/master v5.17]
[cannot apply to xiang-erofs/dev-test dhowells-fs/fscache-next next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220325-203555
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: csky-defconfig (https://download.01.org/0day-ci/archive/20220326/202203260406.Ay5o7T9U-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ec8aa2f84eb47244377e4b822dd77d82ee54714a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220325-203555
        git checkout ec8aa2f84eb47244377e4b822dd77d82ee54714a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: fs/cachefiles/daemon.o: in function `cachefiles_ondemand_daemon_read':
>> daemon.c:(.text+0x97c): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/interface.o: in function `cachefiles_ondemand_daemon_read':
   interface.c:(.text+0x1ec): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/io.o: in function `cachefiles_ondemand_daemon_read':
   io.c:(.text+0x720): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/key.o: in function `cachefiles_ondemand_daemon_read':
   key.c:(.text+0x0): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/main.o: in function `cachefiles_ondemand_daemon_read':
   main.c:(.text+0x0): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/namei.o: in function `cachefiles_ondemand_daemon_read':
   namei.c:(.text+0xf8): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/security.o: in function `cachefiles_ondemand_daemon_read':
   security.c:(.text+0x24): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/volume.o: in function `cachefiles_ondemand_daemon_read':
   volume.c:(.text+0x0): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/xattr.o: in function `cachefiles_ondemand_daemon_read':
   xattr.c:(.text+0x0): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

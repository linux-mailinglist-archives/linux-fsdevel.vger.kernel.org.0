Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29EF7135DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjE0RQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 May 2023 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjE0RQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 May 2023 13:16:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50BEBB;
        Sat, 27 May 2023 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685207773; x=1716743773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eI4v3Kbvvfcjabeh6H6ktAqjlUA5edg4THJ0FK8h8A8=;
  b=e5AHF406cXxJ/QgVpJedtDqEJD61J7z96j6Ak7rGmbLf+0ni7eAX9uWj
   7s9gdLaXeg9Trq6ZnMJ5vS6WOgnh1USGEF+ibhoBln9M0Wj0NTZOSg4EX
   nsllYVkjgJauRfvyaVeQc2F59lA0uw1cd4OAj65e/TwmHt96O7a79zPgl
   n7249uBboHqhPiOQFYuBcBuRylyROv+mHOocIaU2rq/EA7pvlkYtoXIFJ
   Ka+RVQ4pY+g25+wTieHNGnZBKCd7F9/fYIHiJLp5mzo+stTnQUJ5wyxAg
   3jxz69lYnc194VSXi9QfSDwlkUfjLT63O0YbzjFgBMs+Uu+gTPlBmar6x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="334046264"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="334046264"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 10:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="879868893"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="879868893"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2023 10:16:11 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2xWU-000K5w-04;
        Sat, 27 May 2023 17:16:10 +0000
Date:   Sun, 28 May 2023 01:15:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        jlayton@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: add counter for write delegation recall due to
 conflict with GETATTR
Message-ID: <202305280121.3RAeAt4l-lkp@intel.com>
References: <1685122722-18287-3-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685122722-18287-3-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dai,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dai-Ngo/NFSD-handle-GETATTR-conflict-with-write-delegation/20230527-013936
base:   linus/master
patch link:    https://lore.kernel.org/r/1685122722-18287-3-git-send-email-dai.ngo%40oracle.com
patch subject: [PATCH 2/2] NFSD: add counter for write delegation recall due to conflict with GETATTR
config: i386-randconfig-i074-20230526 (https://download.01.org/0day-ci/archive/20230528/202305280121.3RAeAt4l-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a90d0ca71c9459b76f9faa8c704c029ac8066d00
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dai-Ngo/NFSD-handle-GETATTR-conflict-with-write-delegation/20230527-013936
        git checkout a90d0ca71c9459b76f9faa8c704c029ac8066d00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305280121.3RAeAt4l-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/nfsd/trace.c:4:
   In file included from fs/nfsd/trace.h:17:
   In file included from fs/nfsd/xdr4.h:40:
   In file included from fs/nfsd/state.h:42:
   In file included from fs/nfsd/nfsd.h:28:
>> fs/nfsd/stats.h:99:40: error: use of undeclared identifier 'NFSD_STATS_WDELEG_GETATTR'
           percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
                                                 ^
   1 error generated.
--
   In file included from fs/nfsd/export.c:21:
   In file included from fs/nfsd/nfsd.h:28:
>> fs/nfsd/stats.h:99:40: error: use of undeclared identifier 'NFSD_STATS_WDELEG_GETATTR'
           percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
                                                 ^
   fs/nfsd/export.c:1005:17: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
           struct inode            *inode;
                                    ^
   1 warning and 1 error generated.


vim +/NFSD_STATS_WDELEG_GETATTR +99 fs/nfsd/stats.h

    96	
    97	static inline void nfsd_stats_wdeleg_getattr_inc(void)
    98	{
  > 99		percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

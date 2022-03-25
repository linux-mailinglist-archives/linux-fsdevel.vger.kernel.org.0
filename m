Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA84E7CFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 01:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiCYX15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 19:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiCYX1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:27:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0BB4A3F0;
        Fri, 25 Mar 2022 16:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648250778; x=1679786778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XkoxMwHd9gW4bb7hINhoqrJqu4OqA0ycYEJM8nkG41Y=;
  b=M7SEuDo02qJ92C1ljlz5RJHBSPVtnvmGGUEqquHcbAKADXfTTXlhLjoW
   sAuUC1XAoHiFbkMA4V9bHVrk5t85kEJxHxWwYudV6n4kIEiJ6yH6TE98X
   JDkNVbN+F7v7IUXIjw8y5aiTjbqGOvO26TCSCNo+3MG4BRnfowYtf9dfS
   u0iOZhFoSa6L8UhBgxdrSDqy5khDVsTEffeUAOz2KS/PJgxPM4CQ8AVuz
   YKelimFVjq8Skyfvma7v7vF2ITzVdcTDeOju5eSJKOk7BZpW4ZY4bnNIJ
   vbqFIKdFzNLNvtMZBHJPo+IPG8up9EFhcWAzQdKSH21TZ7lr6HT8t/Y4k
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="283615523"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="283615523"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="553371036"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2022 16:26:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXtJq-000Mii-Nz; Fri, 25 Mar 2022 23:26:10 +0000
Date:   Sat, 26 Mar 2022 07:25:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v6 03/22] cachefiles: notify user daemon with anon_fd
 when looking up cookie
Message-ID: <202203260720.uA5o7k5w-lkp@intel.com>
References: <20220325122223.102958-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-4-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220326/202203260720.uA5o7k5w-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ec8aa2f84eb47244377e4b822dd77d82ee54714a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220325-203555
        git checkout ec8aa2f84eb47244377e4b822dd77d82ee54714a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from fs/cachefiles/cache.c:11:
>> fs/cachefiles/internal.h:285:9: warning: no previous prototype for function 'cachefiles_ondemand_daemon_read' [-Wmissing-prototypes]
   ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
           ^
   fs/cachefiles/internal.h:285:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
   ^
   static 
   1 warning generated.
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/daemon.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/interface.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/io.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/key.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/main.o:(.text+0x38C0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/namei.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/security.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/volume.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/xattr.o:(.text+0x0)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

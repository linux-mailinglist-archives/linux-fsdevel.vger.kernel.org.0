Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67C56BFEE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 02:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCSBrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 21:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCSBrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 21:47:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C29E212B5;
        Sat, 18 Mar 2023 18:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679190422; x=1710726422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eOsxwQrAAk4DobA/boytcGZ7cOIXNcghw+rywK7hwm8=;
  b=fcOuUca8KvphVyWTPXsxEY1OwbCvKa9QRZ3gp7dwX3m8fW5Xj/yxf2uK
   sKDV2tajZm372l2oihwzeLNSQqRmLKWZYJsuP+saq8E6yojkTCtNWctXb
   Bmx2a3vbHuV7t2JfR19RmTpUm06PHyQ/rEP4oSmdNzkFcUWOVpyuxWeaR
   lo9TTERnpkb+/U/xPaoKbpjpHWpWTyq0tm6W6wgCrCGndm/czPgj1UCIP
   AKjBBjpKfU+VKo6iO1FyZRiALvYsL2/WUd7XjJp20qT+KCrKgV1a27gCD
   DIQKuxTaTQ0F1cHlOtz4dQEtBcaBKnmvfKbNInGBpVzEl7GGmsf2v6YvN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="401049006"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="401049006"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 18:47:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="744950653"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="744950653"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2023 18:46:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdi8P-000AKg-2R;
        Sun, 19 Mar 2023 01:46:57 +0000
Date:   Sun, 19 Mar 2023 09:46:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <202303190922.Wk376onx-lkp@intel.com>
References: <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Lorenzo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/fs-proc-kcore-Avoid-bounce-buffer-for-ktext-data/20230319-082147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes%40gmail.com
patch subject: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
config: sparc64-randconfig-r015-20230319 (https://download.01.org/0day-ci/archive/20230319/202303190922.Wk376onx-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a28f374d35bd294a529fcba0b69c8b0e2b66fa6c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lorenzo-Stoakes/fs-proc-kcore-Avoid-bounce-buffer-for-ktext-data/20230319-082147
        git checkout a28f374d35bd294a529fcba0b69c8b0e2b66fa6c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/vdso/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303190922.Wk376onx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/wait.h:11,
                    from include/linux/swait.h:8,
                    from include/linux/completion.h:12,
                    from include/linux/mm_types.h:14,
                    from include/linux/uio.h:10,
                    from include/linux/vmalloc.h:12,
                    from include/asm-generic/io.h:994,
                    from arch/sparc/include/asm/io.h:22,
                    from arch/sparc/vdso/vclock_gettime.c:18:
>> arch/sparc/include/asm/current.h:18:30: warning: call-clobbered register used for global register variable
      18 | register struct task_struct *current asm("g4");
         |                              ^~~~~~~
   arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
     254 | __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
         | ^~~~~~~~~~~~~~~~~~~~
   arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous prototype for '__vdso_clock_gettime_stick' [-Wmissing-prototypes]
     282 | __vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous prototype for '__vdso_gettimeofday' [-Wmissing-prototypes]
     307 | __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
         | ^~~~~~~~~~~~~~~~~~~
   arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototype for '__vdso_gettimeofday_stick' [-Wmissing-prototypes]
     343 | __vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +18 arch/sparc/include/asm/current.h

^1da177e4c3f41 include/asm-sparc/current.h Linus Torvalds  2005-04-16  16  
ba89f59ab825d4 include/asm-sparc/current.h David S. Miller 2007-11-16  17  #ifdef CONFIG_SPARC64
ba89f59ab825d4 include/asm-sparc/current.h David S. Miller 2007-11-16 @18  register struct task_struct *current asm("g4");
ba89f59ab825d4 include/asm-sparc/current.h David S. Miller 2007-11-16  19  #endif
^1da177e4c3f41 include/asm-sparc/current.h Linus Torvalds  2005-04-16  20  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

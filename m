Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A0577981
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 04:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiGRCFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jul 2022 22:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiGRCFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:05:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5513D3A;
        Sun, 17 Jul 2022 19:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658109922; x=1689645922;
  h=subject:references:in-reply-to:to:cc:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=XvbJNiAUBYCFA1BgcjNoBuChcRw2xE7D5d4i2rcVp4A=;
  b=BOT2ym6//iQJZpYmZBq+amNCrZg31pt+Uuph/eC01fP9AV1z13Nu6pYQ
   ez7mj0AnsaRzSen2cswaTc49Y9Lwk3kSfzhg2KOckKGtlWlwYkC85zH0X
   0EbRGwlOa6iT/ZCuChfv0kDSRhRGdEvqUDHNIv2mBKtAM8L7AnFO1usbv
   Y27TedUiDt40a1DpcwxEYVelgXXyjkWp3kWbMAXoM9xc6IsjXirQowS+7
   ZooUjGNJANBuLzlLziV4vSOpN0++DcB8ebuGR8bcESfPK7bx/mJYdq5AK
   FQoUDh4JNguc2vldnQU8ZuqSxmWuHbXdRwcy+5eUlLi1qjT6t1SwzzAPn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="350074140"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="350074140"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 19:05:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="655076055"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.248]) ([10.249.172.248])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 19:05:20 -0700
Subject: Re: [PATCH] posix_acl: Use try_cmpxchg in get_acl
References: <202207162205.iBwToBEr-lkp@intel.com>
In-Reply-To: <202207162205.iBwToBEr-lkp@intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, Alexander Viro <viro@zeniv.linux.org.uk>
From:   kernel test robot <rong.a.chen@intel.com>
X-Forwarded-Message-Id: <202207162205.iBwToBEr-lkp@intel.com>
Message-ID: <fae1386b-a95e-b44f-362d-06b268e790de@intel.com>
Date:   Mon, 18 Jul 2022 10:05:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Uros,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc6 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url: 
https://github.com/intel-lab-lkp/linux/commits/Uros-Bizjak/posix_acl-Use-try_cmpxchg-in-get_acl/20220715-014002
base: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
4a57a8400075bc5287c5c877702c68aeae2a033d
config: powerpc-sam440ep_defconfig 
(https://download.01.org/0day-ci/archive/20220716/202207162205.iBwToBEr-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
         wget 
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
-O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # 
https://github.com/intel-lab-lkp/linux/commit/8291d21630df3a57adf6d0ed8a1cded2a2700f66
         git remote add linux-review https://github.com/intel-lab-lkp/linux
         git fetch --no-tags linux-review 
Uros-Bizjak/posix_acl-Use-try_cmpxchg-in-get_acl/20220715-014002
         git checkout 8291d21630df3a57adf6d0ed8a1cded2a2700f66
         # save the config file
         mkdir build_dir && cp config build_dir/.config
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross 
W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

    In file included from include/linux/kernel.h:20,
                     from fs/posix_acl.c:14:
    fs/posix_acl.c: In function 'get_acl':
>> include/linux/atomic/atomic-arch-fallback.h:90:34: error: initialization of 'struct posix_acl **' from incompatible pointer type 'void **' [-Werror=incompatible-pointer-types]
       90 |         typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
          |                                  ^
    include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
       78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
          |                                             ^
    include/linux/atomic/atomic-instrumented.h:1978:9: note: in 
expansion of macro 'arch_try_cmpxchg'
     1978 |         arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
          |         ^~~~~~~~~~~~~~~~
    fs/posix_acl.c:167:23: note: in expansion of macro 'try_cmpxchg'
      167 |         if (unlikely(!try_cmpxchg(p, &sentinel, acl)))
          |                       ^~~~~~~~~~~
    cc1: some warnings being treated as errors


vim +90 include/linux/atomic/atomic-arch-fallback.h

29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  86  29f006fdefe6f8 include/linux/atomic-arch-fallback.h 
Peter Zijlstra 2020-08-29  87  #ifndef arch_try_cmpxchg
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  88  #define arch_try_cmpxchg(_ptr, _oldp, _new) \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  89  ({ \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29 @90  	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  91  	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  92  	if (unlikely(___r != ___o)) \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  93  		*___op = ___r; \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  94  	likely(___r == ___o); \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  95  })
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  96  #endif /* arch_try_cmpxchg */
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 
2020-08-29  97
-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

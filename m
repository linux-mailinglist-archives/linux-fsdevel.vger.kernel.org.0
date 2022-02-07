Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4432F4AC867
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiBGSTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 13:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiBGSMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:12:54 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 10:12:53 PST
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDC2C0401D9;
        Mon,  7 Feb 2022 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644257573; x=1675793573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9jtlciL9JDhXsZpBNGevebG0Pcet92BqXyuEzYTIPU8=;
  b=ML8cvVpRs8VbVgMGfU63I3TOLbvIr8lzXHWAhbHSoYtT8InWInmrvzuy
   ktzJsbvE9okzMhc9wuO8IK/UyhCkmzkDhKL9Ry4S58GBiGzuwM0yqJGV2
   JXziBwJt4T/fBv7HZ1G4N5Bj4UIxDJaj/TZ3wH/oM6B/zyhIr5deiJo0s
   m1UA5pOlgQfqxIlyeevJfaFMcoLDMJiDpQ342U6paKdWgdduCbAcLqkE8
   3wzEIzZDDAmZ9zv7uC8uku77+PYW+14JwTWuAsP4K4UjOot48GX7cYNN6
   LivZbhcyBW+assdP6tOGs78FZlYuDCigWf01x6Xf+dHgHOvrC6ygBhpLk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248725038"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="248725038"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 10:11:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="481665736"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Feb 2022 10:11:47 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH8UN-0000qN-4m; Mon, 07 Feb 2022 18:11:47 +0000
Date:   Tue, 8 Feb 2022 02:10:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>, mpatocka@redhat.com
Cc:     kbuild-all@lists.01.org, javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk, msnitzer@redhat.com
Subject: Re: [PATCH v2 07/10] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202202080206.J6kilCeY-lkp@intel.com>
References: <20220207141348.4235-8-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-8-nj.shetty@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v5.17-rc3 next-20220207]
[cannot apply to device-mapper-dm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: microblaze-buildonly-randconfig-r003-20220207 (https://download.01.org/0day-ci/archive/20220208/202202080206.J6kilCeY-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6bb6ea64499e1ac27975e79bb2eee89f07861893
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
        git checkout 6bb6ea64499e1ac27975e79bb2eee89f07861893
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/byteorder/big_endian.h:5,
                    from arch/microblaze/include/uapi/asm/byteorder.h:8,
                    from include/asm-generic/bitops/le.h:6,
                    from include/asm-generic/bitops.h:35,
                    from ./arch/microblaze/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/microblaze/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/nvme/target/admin-cmd.c:7:
   drivers/nvme/target/admin-cmd.c: In function 'nvmet_execute_identify_ns':
>> include/uapi/linux/byteorder/big_endian.h:34:26: warning: conversion from 'unsigned int' to '__le16' {aka 'short unsigned int'} changes value from '524288' to '0' [-Woverflow]
      34 | #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
         |                          ^
   include/linux/byteorder/generic.h:88:21: note: in expansion of macro '__cpu_to_le32'
      88 | #define cpu_to_le32 __cpu_to_le32
         |                     ^~~~~~~~~~~~~
   drivers/nvme/target/admin-cmd.c:534:29: note: in expansion of macro 'cpu_to_le32'
     534 |                 id->mssrl = cpu_to_le32(BIO_MAX_VECS << (PAGE_SHIFT - SECTOR_SHIFT));
         |                             ^~~~~~~~~~~


vim +34 include/uapi/linux/byteorder/big_endian.h

5921e6f8809b161 David Howells 2012-10-13  15  
5921e6f8809b161 David Howells 2012-10-13  16  #define __constant_htonl(x) ((__force __be32)(__u32)(x))
5921e6f8809b161 David Howells 2012-10-13  17  #define __constant_ntohl(x) ((__force __u32)(__be32)(x))
5921e6f8809b161 David Howells 2012-10-13  18  #define __constant_htons(x) ((__force __be16)(__u16)(x))
5921e6f8809b161 David Howells 2012-10-13  19  #define __constant_ntohs(x) ((__force __u16)(__be16)(x))
5921e6f8809b161 David Howells 2012-10-13  20  #define __constant_cpu_to_le64(x) ((__force __le64)___constant_swab64((x)))
5921e6f8809b161 David Howells 2012-10-13  21  #define __constant_le64_to_cpu(x) ___constant_swab64((__force __u64)(__le64)(x))
5921e6f8809b161 David Howells 2012-10-13  22  #define __constant_cpu_to_le32(x) ((__force __le32)___constant_swab32((x)))
5921e6f8809b161 David Howells 2012-10-13  23  #define __constant_le32_to_cpu(x) ___constant_swab32((__force __u32)(__le32)(x))
5921e6f8809b161 David Howells 2012-10-13  24  #define __constant_cpu_to_le16(x) ((__force __le16)___constant_swab16((x)))
5921e6f8809b161 David Howells 2012-10-13  25  #define __constant_le16_to_cpu(x) ___constant_swab16((__force __u16)(__le16)(x))
5921e6f8809b161 David Howells 2012-10-13  26  #define __constant_cpu_to_be64(x) ((__force __be64)(__u64)(x))
5921e6f8809b161 David Howells 2012-10-13  27  #define __constant_be64_to_cpu(x) ((__force __u64)(__be64)(x))
5921e6f8809b161 David Howells 2012-10-13  28  #define __constant_cpu_to_be32(x) ((__force __be32)(__u32)(x))
5921e6f8809b161 David Howells 2012-10-13  29  #define __constant_be32_to_cpu(x) ((__force __u32)(__be32)(x))
5921e6f8809b161 David Howells 2012-10-13  30  #define __constant_cpu_to_be16(x) ((__force __be16)(__u16)(x))
5921e6f8809b161 David Howells 2012-10-13  31  #define __constant_be16_to_cpu(x) ((__force __u16)(__be16)(x))
5921e6f8809b161 David Howells 2012-10-13  32  #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
5921e6f8809b161 David Howells 2012-10-13  33  #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
5921e6f8809b161 David Howells 2012-10-13 @34  #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
5921e6f8809b161 David Howells 2012-10-13  35  #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
5921e6f8809b161 David Howells 2012-10-13  36  #define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
5921e6f8809b161 David Howells 2012-10-13  37  #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
5921e6f8809b161 David Howells 2012-10-13  38  #define __cpu_to_be64(x) ((__force __be64)(__u64)(x))
5921e6f8809b161 David Howells 2012-10-13  39  #define __be64_to_cpu(x) ((__force __u64)(__be64)(x))
5921e6f8809b161 David Howells 2012-10-13  40  #define __cpu_to_be32(x) ((__force __be32)(__u32)(x))
5921e6f8809b161 David Howells 2012-10-13  41  #define __be32_to_cpu(x) ((__force __u32)(__be32)(x))
5921e6f8809b161 David Howells 2012-10-13  42  #define __cpu_to_be16(x) ((__force __be16)(__u16)(x))
5921e6f8809b161 David Howells 2012-10-13  43  #define __be16_to_cpu(x) ((__force __u16)(__be16)(x))
5921e6f8809b161 David Howells 2012-10-13  44  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

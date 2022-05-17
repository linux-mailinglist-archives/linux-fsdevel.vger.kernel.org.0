Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A25529893
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 06:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiEQENN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 00:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiEQENJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 00:13:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4A53FD96;
        Mon, 16 May 2022 21:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652760788; x=1684296788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1drYWkhJXlza+p8qJe1jaRor29et4ZBJVwKRLeAW2M8=;
  b=SiGl200o+/Cm2HNH10aLAdWCKrnkzGLuzsLoWWSTWTAn3ioW6jA8nODT
   cXjOaUy6E393lzwiu5aNJ2YN84WeRBmWtwdFwv04fqDJMp/npZaEntdjn
   4W+1xF2chcWA4pI+YNbpx/oq7pEKo/zuxXUIXkcLCYLjQpYJvNXK8Hkq9
   O07M0GCI9B/0MjupVK8obb0fh4UANapDzBY+0gGdzHn9wDr7RGclUkvPT
   l9Ms5Gb60tnlNJY2/dSnxPdG2PvMaYEssDF4/Wes0AmGrh+2i71vNrRy/
   gbbXfEUt5BCKaiuFhrYaSHGm7JPVLqN47rDHnNTvE2mSsDd3j2MgLjrjh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="268630910"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="268630910"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 21:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="699868498"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 May 2022 21:13:04 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqoZz-0000ap-DK;
        Tue, 17 May 2022 04:13:03 +0000
Date:   Tue, 17 May 2022 12:12:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
        dsterba@suse.com, hch@lst.de
Cc:     kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        jiangbo.365@bytedance.com, linux-block@vger.kernel.org,
        gost.dev@samsung.com, p.raghav@samsung.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 11/13] null_blk: allow non power of 2 zoned devices
Message-ID: <202205171251.o9RZslnw-lkp@intel.com>
References: <20220516165416.171196-12-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516165416.171196-12-p.raghav@samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Pankaj,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220516]
[also build test ERROR on v5.18-rc7]
[cannot apply to axboe-block/for-next kdave/for-next device-mapper-dm/for-next linus/master v5.18-rc7 v5.18-rc6 v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220517-015435
base:    3f7bdc402fb06f897ff1f492a2d42e1f7c2efedb
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220517/202205171251.o9RZslnw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1fc6f61076425c29e51cfa376f8dee4dbf588ed1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pankaj-Raghav/block-make-blkdev_nr_zones-and-blk_queue_zone_no-generic-for-npo2-zsze/20220517-015435
        git checkout 1fc6f61076425c29e51cfa376f8dee4dbf588ed1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/block/null_blk/zoned.o: in function `null_init_zoned_dev':
>> zoned.c:(.text+0x9c6): undefined reference to `__udivdi3'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

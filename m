Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C972D8D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 06:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbjFME4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjFME4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:56:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D0B18C;
        Mon, 12 Jun 2023 21:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686632193; x=1718168193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+pfpcXRcQFvk6OesL4K/G5j69/YtksX7w3CMXTIy6Mg=;
  b=AxAGGHXtDU9LRjQuy4+IQa+HjFnXylJSg9DSeo5tCsjdX/L+jUsDHUSN
   aMoT8wvP9IwW4aeMPp2oo5rULUNhps3L/Q7db+JmznSyDzdhIIuhxGDLZ
   eL+6Td9XWyGuYKymmXMOXsQ+Spq5d3SEZ/cXckBYVWHbgrcIJc8Orrm1Z
   sxUcf1sgCE9mbUro6Euy6J41RpewY+iekjwNzvD4ICiweacSCzme9o4jC
   wIPNfcgeJhl5mn/7SUBcgo77HjmGuixtIS/2sn1nx2j/C1V1rlAtgXIlj
   oi33Xf8pCKI9EoUohf55AjlZESeL70uabA8firmlYcDmSehi9vP3XSBX/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="347881349"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="347881349"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741289441"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="741289441"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2023 21:56:30 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8w4z-00011U-0M;
        Tue, 13 Jun 2023 04:56:29 +0000
Date:   Tue, 13 Jun 2023 12:56:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <202306131212.dPssLmeY-lkp@intel.com>
References: <20230612161614.10302-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612161614.10302-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.4-rc6]
[also build test ERROR on linus/master next-20230609]
[cannot apply to axboe-block/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/block-Add-config-option-to-not-allow-writing-to-mounted-devices/20230613-001910
base:   v6.4-rc6
patch link:    https://lore.kernel.org/r/20230612161614.10302-1-jack%40suse.cz
patch subject: [PATCH] block: Add config option to not allow writing to mounted devices
config: arc-randconfig-r043-20230612 (https://download.01.org/0day-ci/archive/20230613/202306131212.dPssLmeY-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout v6.4-rc6
        b4 shazam https://lore.kernel.org/r/20230612161614.10302-1-jack@suse.cz
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306131212.dPssLmeY-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/bdev.c: In function 'blkdev_get_whole':
>> block/bdev.c:606:59: error: 'struct block_device' has no member named 'bd_writers'
     606 |                 if (mode & FMODE_EXCL && atomic_read(&bdev->bd_writers) > 0)
         |                                                           ^~
   block/bdev.c:627:33: error: 'struct block_device' has no member named 'bd_writers'
     627 |                 atomic_inc(&bdev->bd_writers);
         |                                 ^~
   block/bdev.c: In function 'blkdev_put_whole':
   block/bdev.c:637:33: error: 'struct block_device' has no member named 'bd_writers'
     637 |                 atomic_dec(&bdev->bd_writers);
         |                                 ^~


vim +606 block/bdev.c

   599	
   600	static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
   601	{
   602		struct gendisk *disk = bdev->bd_disk;
   603		int ret;
   604	
   605		if (IS_ENABLED(BLK_DEV_WRITE_HARDENING)) {
 > 606			if (mode & FMODE_EXCL && atomic_read(&bdev->bd_writers) > 0)
   607				return -EBUSY;
   608			if (mode & FMODE_WRITE && bdev->bd_holders > 0)
   609				return -EBUSY;
   610		}
   611		if (disk->fops->open) {
   612			ret = disk->fops->open(bdev, mode);
   613			if (ret) {
   614				/* avoid ghost partitions on a removed medium */
   615				if (ret == -ENOMEDIUM &&
   616				     test_bit(GD_NEED_PART_SCAN, &disk->state))
   617					bdev_disk_changed(disk, true);
   618				return ret;
   619			}
   620		}
   621	
   622		if (!atomic_read(&bdev->bd_openers))
   623			set_init_blocksize(bdev);
   624		if (test_bit(GD_NEED_PART_SCAN, &disk->state))
   625			bdev_disk_changed(disk, false);
   626		if (IS_ENABLED(BLK_DEV_WRITE_HARDENING) && mode & FMODE_WRITE)
   627			atomic_inc(&bdev->bd_writers);
   628		atomic_inc(&bdev->bd_openers);
   629		return 0;
   630	}
   631	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

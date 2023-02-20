Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492169D074
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjBTPTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 10:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjBTPTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:19:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C001166DA;
        Mon, 20 Feb 2023 07:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676906348; x=1708442348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=daUuz6PCkNi/Pv0EW1m00p8WjYzG3GsLrXsE65CvLaI=;
  b=jUBbTQX2DZ1o/ejy8MPmJW/79k7HTsKUxT8nsz/liWg4sejPF+JYFTyt
   9Q5L4eLBiecXJ1hecOf1UW0LV+NIHVJExfXA+QQpnTWGzpFch0vZgxo3U
   Uno/+vkJqh/YtIWPnCjJ+3vs7N/qeTceNp1O4eYEgmU2QLT1iUVE18UdO
   yuIeEex6yIu0FyBTaMBnvfoXjm41EnCrh4pf4+2CYgc+Ba4s5MrZm6hSD
   BLToNg7Dl91lIF/GKc3JlzH6jWr96vzTvzFWkG2QZB6NMPc6M9SCQ+7Iv
   K+8NVKzcOEBo/lX7rvziFKyNgg9QsabAxD9dLVZJt2eVGMqY04Al9OAny
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="331087846"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="331087846"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 07:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="814167593"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="814167593"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2023 07:18:21 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pU7vo-000E13-1K;
        Mon, 20 Feb 2023 15:18:20 +0000
Date:   Mon, 20 Feb 2023 23:18:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     oe-kbuild-all@lists.linux.dev, bvanassche@acm.org, hare@suse.de,
        ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 4/8] fs, block: copy_file_range for def_blk_ops for
 direct block device.
Message-ID: <202302202321.zfUe705N-lkp@intel.com>
References: <20230220105336.3810-5-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220105336.3810-5-nj.shetty@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on device-mapper-dm/for-next]
[also build test WARNING on linus/master v6.2 next-20230220]
[cannot apply to axboe-block/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Add-copy-offload-support-infrastructure/20230220-205057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
patch link:    https://lore.kernel.org/r/20230220105336.3810-5-nj.shetty%40samsung.com
patch subject: [PATCH v7 4/8] fs, block: copy_file_range for def_blk_ops for direct block device.
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230220/202302202321.zfUe705N-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0f95ad2cb727ac6ac8406a01ff216d9237b403b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Add-copy-offload-support-infrastructure/20230220-205057
        git checkout 0f95ad2cb727ac6ac8406a01ff216d9237b403b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302202321.zfUe705N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/fops.c:614:9: warning: no previous prototype for 'blkdev_copy_file_range' [-Wmissing-prototypes]
     614 | ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
         |         ^~~~~~~~~~~~~~~~~~~~~~


vim +/blkdev_copy_file_range +614 block/fops.c

   613	
 > 614	ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
   615					struct file *file_out, loff_t pos_out,
   616					size_t len, unsigned int flags)
   617	{
   618		struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
   619		struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
   620		int comp_len;
   621	
   622		comp_len = blkdev_copy_offload(in_bdev, pos_in, out_bdev, pos_out, len,
   623				    NULL, NULL, GFP_KERNEL);
   624		if (comp_len != len)
   625			comp_len = generic_copy_file_range(file_in, pos_in + comp_len,
   626				file_out, pos_out + comp_len, len - comp_len, flags);
   627	
   628		return comp_len;
   629	}
   630	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

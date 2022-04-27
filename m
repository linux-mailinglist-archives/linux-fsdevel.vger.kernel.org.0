Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF5510DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 03:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356767AbiD0Bgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 21:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356752AbiD0Bgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:36:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AF0ABF7C;
        Tue, 26 Apr 2022 18:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651023204; x=1682559204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G8Dj4gKe1sLtxGIzX7r31BTbZr1Rfh1JubY3941+Lps=;
  b=iZWmNND73J9xO2ilEdBw3UwKC+FuMsiuAB15XvzCvAZTxNgha9loA542
   f2iDXJ6eFJhyigcQ4bx6uOLi+KghHDeshqDTGMK0aEWWyUbp4z2zU3FD/
   refX2DW3CPXFmqhpVIPmuOxU4DAqZdKSNAV3ql29VYLdcx4a+V/b+QFQ+
   2Wg2alxUOz5IUPTZM0pWbYwz8fOrOsloZYCu90fjd6m8HXomZgeSXvfpy
   KIvBDvroaHOGMytF962qBC0qAcQn4vnSVB89rAkY/igvIbYIoRksa1nzf
   ta69AgVWwfUuaI7IGLLVj0AmsdGA7TzWMgR6+CmPzvZ05jhnmZz/Q8dR0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="253157462"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="253157462"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 18:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="617279875"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Apr 2022 18:33:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njWYO-0004BM-D3;
        Wed, 27 Apr 2022 01:33:16 +0000
Date:   Wed, 27 Apr 2022 09:33:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4 04/10] block: add emulation for copy
Message-ID: <202204270913.Ecb3uQx1-lkp@intel.com>
References: <20220426101241.30100-5-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-5-nj.shetty@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220422]
[cannot apply to axboe-block/for-next device-mapper-dm/for-next linus/master v5.18-rc4 v5.18-rc3 v5.18-rc2 v5.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
base:    e7d6987e09a328d4a949701db40ef63fbb970670
config: hexagon-randconfig-r041-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270913.Ecb3uQx1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c406c5145dc7d628d4197f6726c23a3f1179b88e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout c406c5145dc7d628d4197f6726c23a3f1179b88e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   block/blk-lib.c:178:5: warning: no previous prototype for function 'blk_copy_offload' [-Wmissing-prototypes]
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
       ^
   block/blk-lib.c:178:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
   ^
   static 
>> block/blk-lib.c:276:5: warning: no previous prototype for function 'blk_submit_rw_buf' [-Wmissing-prototypes]
   int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
       ^
   block/blk-lib.c:276:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
   ^
   static 
   2 warnings generated.


vim +/blk_submit_rw_buf +276 block/blk-lib.c

   275	
 > 276	int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
   277					sector_t sector, unsigned int op, gfp_t gfp_mask)
   278	{
   279		struct request_queue *q = bdev_get_queue(bdev);
   280		struct bio *bio, *parent = NULL;
   281		sector_t max_hw_len = min_t(unsigned int, queue_max_hw_sectors(q),
   282				queue_max_segments(q) << (PAGE_SHIFT - SECTOR_SHIFT)) << SECTOR_SHIFT;
   283		sector_t len, remaining;
   284		int ret;
   285	
   286		for (remaining = buf_len; remaining > 0; remaining -= len) {
   287			len = min_t(int, max_hw_len, remaining);
   288	retry:
   289			bio = bio_map_kern(q, buf, len, gfp_mask);
   290			if (IS_ERR(bio)) {
   291				len >>= 1;
   292				if (len)
   293					goto retry;
   294				return PTR_ERR(bio);
   295			}
   296	
   297			bio->bi_iter.bi_sector = sector >> SECTOR_SHIFT;
   298			bio->bi_opf = op;
   299			bio_set_dev(bio, bdev);
   300			bio->bi_end_io = NULL;
   301			bio->bi_private = NULL;
   302	
   303			if (parent) {
   304				bio_chain(parent, bio);
   305				submit_bio(parent);
   306			}
   307			parent = bio;
   308			sector += len;
   309			buf = (char *) buf + len;
   310		}
   311		ret = submit_bio_wait(bio);
   312		bio_put(bio);
   313	
   314		return ret;
   315	}
   316	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E43510D11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 02:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356337AbiD0APc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 20:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiD0APb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:15:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21273674F6;
        Tue, 26 Apr 2022 17:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651018342; x=1682554342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IJKeTxABZvXswFfO4b9L3mkC7AWJ8dJxlHjKnja64Dw=;
  b=U93hT1g8PULfDll3QXbBWcPYTCI+ZvmKElKTqmFGsbkAK/RZbFbj6BGU
   dogPRbwrOv4ubLlcFk0nZBX4iSDpo/KsHBhs5867mxKBMAdpzOzEZx1cp
   UC9w2pDR4o0tWfZaUPAyMfbQ6iSlrOCdeHVUHKO1qY/r2J0/O4n6Yp0EV
   YYoPQQ1WJnV/F7dTtQKpi+TDvn38KEGV2m5NgljH1KOVZ7UE174rmixBg
   OG2wI+20hiWDAAIa9MpK4T4W9qmfGWP7H3bBUl31QJKrMLAUx7/GHBUWR
   8p6NJwgpjh1FMVQIGOERtD6ietKwrQtasKDYckUOsdRCKW62D0rxg35fU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328704083"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="328704083"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="807761334"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2022 17:12:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njVHx-00046e-BM;
        Wed, 27 Apr 2022 00:12:13 +0000
Date:   Wed, 27 Apr 2022 08:11:24 +0800
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
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v4 02/10] block: Add copy offload support infrastructure
Message-ID: <202204270754.pM0Ewhl5-lkp@intel.com>
References: <20220426101241.30100-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-3-nj.shetty@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: hexagon-randconfig-r041-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270754.pM0Ewhl5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3e91cba65ef73ba116953031d5548da7fd33a150
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout 3e91cba65ef73ba116953031d5548da7fd33a150
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/blk-lib.c:178:5: warning: no previous prototype for function 'blk_copy_offload' [-Wmissing-prototypes]
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
       ^
   block/blk-lib.c:178:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
   ^
   static 
   1 warning generated.


vim +/blk_copy_offload +178 block/blk-lib.c

   173	
   174	/*
   175	 * blk_copy_offload	- Use device's native copy offload feature
   176	 * Go through user provide payload, prepare new payload based on device's copy offload limits.
   177	 */
 > 178	int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
   179			struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
   180	{
   181		struct request_queue *sq = bdev_get_queue(src_bdev);
   182		struct request_queue *dq = bdev_get_queue(dst_bdev);
   183		struct bio *read_bio, *write_bio;
   184		struct copy_ctx *ctx;
   185		struct cio *cio;
   186		struct page *token;
   187		sector_t src_blk, copy_len, dst_blk;
   188		sector_t remaining, max_copy_len = LONG_MAX;
   189		unsigned long flags;
   190		int ri = 0, ret = 0;
   191	
   192		cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
   193		if (!cio)
   194			return -ENOMEM;
   195		cio->rlist = rlist;
   196		spin_lock_init(&cio->lock);
   197	
   198		max_copy_len = min_t(sector_t, sq->limits.max_copy_sectors, dq->limits.max_copy_sectors);
   199		max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
   200				(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;
   201	
   202		for (ri = 0; ri < nr_srcs; ri++) {
   203			cio->rlist[ri].comp_len = rlist[ri].len;
   204			src_blk = rlist[ri].src;
   205			dst_blk = rlist[ri].dst;
   206			for (remaining = rlist[ri].len; remaining > 0; remaining -= copy_len) {
   207				copy_len = min(remaining, max_copy_len);
   208	
   209				token = alloc_page(gfp_mask);
   210				if (unlikely(!token)) {
   211					ret = -ENOMEM;
   212					goto err_token;
   213				}
   214	
   215				ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
   216				if (!ctx) {
   217					ret = -ENOMEM;
   218					goto err_ctx;
   219				}
   220				ctx->cio = cio;
   221				ctx->range_idx = ri;
   222				ctx->start_sec = dst_blk;
   223	
   224				read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
   225						gfp_mask);
   226				if (!read_bio) {
   227					ret = -ENOMEM;
   228					goto err_read_bio;
   229				}
   230				read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
   231				__bio_add_page(read_bio, token, PAGE_SIZE, 0);
   232				/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
   233				read_bio->bi_iter.bi_size = copy_len;
   234				ret = submit_bio_wait(read_bio);
   235				bio_put(read_bio);
   236				if (ret)
   237					goto err_read_bio;
   238	
   239				write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
   240						gfp_mask);
   241				if (!write_bio) {
   242					ret = -ENOMEM;
   243					goto err_read_bio;
   244				}
   245				write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
   246				__bio_add_page(write_bio, token, PAGE_SIZE, 0);
   247				/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
   248				write_bio->bi_iter.bi_size = copy_len;
   249				write_bio->bi_end_io = bio_copy_end_io;
   250				write_bio->bi_private = ctx;
   251	
   252				spin_lock_irqsave(&cio->lock, flags);
   253				++cio->refcount;
   254				spin_unlock_irqrestore(&cio->lock, flags);
   255	
   256				submit_bio(write_bio);
   257				src_blk += copy_len;
   258				dst_blk += copy_len;
   259			}
   260		}
   261	
   262		/* Wait for completion of all IO's*/
   263		return cio_await_completion(cio);
   264	
   265	err_read_bio:
   266		kfree(ctx);
   267	err_ctx:
   268		__free_page(token);
   269	err_token:
   270		rlist[ri].comp_len = min_t(sector_t, rlist[ri].comp_len, (rlist[ri].len - remaining));
   271	
   272		cio->io_err = ret;
   273		return cio_await_completion(cio);
   274	}
   275	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

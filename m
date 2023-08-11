Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC0779B74
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjHKXkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 19:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjHKXkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:40:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34461E4B;
        Fri, 11 Aug 2023 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691797202; x=1723333202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3lUJN/mS9FWRE1mPMsvlLsvA89Qs/V7b+ntFDqCqCcE=;
  b=VeXfWtb5DOnPE8xhZ4wBrJXojvTviM4Zu0Cb1sh8EMs2gZqvWFM6v1cG
   PkUeLeEHunX/5qMbDxZQcFSlLclc7G7BaKqmXR8kgF1J/2VjxjIpgUbd6
   PVugPSsjpySQNowLWmtgRHtmdeBvxtUJOkpXy/Az3tqsT6oKoQia+Uh5V
   3wBbOSQnQUldToS36VTbmLK4B/iXtPVYizzKb6nfcpv+1zlG+WpJpmam2
   lBnXz1qcG3LQCvVoW8+9iWKXqAo7Z/i6n8FdaGQnotb8e/Lfy7g/eYvbs
   ErFQ0Ykd5p7S6DKU+i/QrLunKVtsPIs4ldPX/P7e0CP4tcAGXdxkPWgPC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="435677453"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="435677453"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 16:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="682698421"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="682698421"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2023 16:39:54 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUbjW-00086b-0G;
        Fri, 11 Aug 2023 23:39:54 +0000
Date:   Sat, 12 Aug 2023 07:39:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        martin.petersen@oracle.com, mcgrof@kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 07/11] nvme: add copy offload support
Message-ID: <202308120736.Od5Pc9vy-lkp@intel.com>
References: <20230811105300.15889-8-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811105300.15889-8-nj.shetty@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f7dc24b3413851109c4047b22997bd0d95ed52a2]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-and-sysfs-for-copy-offload-support/20230811-192259
base:   f7dc24b3413851109c4047b22997bd0d95ed52a2
patch link:    https://lore.kernel.org/r/20230811105300.15889-8-nj.shetty%40samsung.com
patch subject: [PATCH v14 07/11] nvme: add copy offload support
config: arm64-randconfig-r013-20230812 (https://download.01.org/0day-ci/archive/20230812/202308120736.Od5Pc9vy-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120736.Od5Pc9vy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120736.Od5Pc9vy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/core.c:782:2: warning: variable 'dst_lba' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     782 |         __rq_for_each_bio(bio, req) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:1008:6: note: expanded from macro '__rq_for_each_bio'
    1008 |         if ((rq->bio))                  \
         |             ^~~~~~~~~
   drivers/nvme/host/core.c:804:33: note: uninitialized use occurs here
     804 |         cmnd->copy.sdlba = cpu_to_le64(dst_lba);
         |                                        ^~~~~~~
   include/linux/byteorder/generic.h:86:21: note: expanded from macro 'cpu_to_le64'
      86 | #define cpu_to_le64 __cpu_to_le64
         |                     ^
   include/uapi/linux/byteorder/little_endian.h:32:51: note: expanded from macro '__cpu_to_le64'
      32 | #define __cpu_to_le64(x) ((__force __le64)(__u64)(x))
         |                                                   ^
   drivers/nvme/host/core.c:782:2: note: remove the 'if' if its condition is always true
     782 |         __rq_for_each_bio(bio, req) {
         |         ^
   include/linux/blk-mq.h:1008:2: note: expanded from macro '__rq_for_each_bio'
    1008 |         if ((rq->bio))                  \
         |         ^
   drivers/nvme/host/core.c:772:13: note: initialize the variable 'dst_lba' to silence this warning
     772 |         u64 dst_lba, src_lba, n_lba;
         |                    ^
         |                     = 0
   1 warning generated.


vim +782 drivers/nvme/host/core.c

   765	
   766	static inline blk_status_t nvme_setup_copy_offload(struct nvme_ns *ns,
   767							   struct request *req,
   768							   struct nvme_command *cmnd)
   769	{
   770		struct nvme_copy_range *range = NULL;
   771		struct bio *bio;
   772		u64 dst_lba, src_lba, n_lba;
   773		u16 nr_range = 1, control = 0, seg = 1;
   774	
   775		if (blk_rq_nr_phys_segments(req) != COPY_MAX_SEGMENTS)
   776			return BLK_STS_IOERR;
   777	
   778		/*
   779		 * First bio contains information about source and last bio contains
   780		 * information about destination.
   781		 */
 > 782		__rq_for_each_bio(bio, req) {
   783			if (seg == blk_rq_nr_phys_segments(req)) {
   784				dst_lba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
   785				if (n_lba != bio->bi_iter.bi_size >> ns->lba_shift)
   786					return BLK_STS_IOERR;
   787			} else {
   788				src_lba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
   789				n_lba = bio->bi_iter.bi_size >> ns->lba_shift;
   790			}
   791			seg++;
   792		}
   793	
   794		if (req->cmd_flags & REQ_FUA)
   795			control |= NVME_RW_FUA;
   796	
   797		if (req->cmd_flags & REQ_FAILFAST_DEV)
   798			control |= NVME_RW_LR;
   799	
   800		memset(cmnd, 0, sizeof(*cmnd));
   801		cmnd->copy.opcode = nvme_cmd_copy;
   802		cmnd->copy.nsid = cpu_to_le32(ns->head->ns_id);
   803		cmnd->copy.control = cpu_to_le16(control);
   804		cmnd->copy.sdlba = cpu_to_le64(dst_lba);
   805		cmnd->copy.nr_range = 0;
   806	
   807		range = kmalloc_array(nr_range, sizeof(*range),
   808				      GFP_ATOMIC | __GFP_NOWARN);
   809		if (!range)
   810			return BLK_STS_RESOURCE;
   811	
   812		range[0].slba = cpu_to_le64(src_lba);
   813		range[0].nlb = cpu_to_le16(n_lba - 1);
   814	
   815		req->special_vec.bv_page = virt_to_page(range);
   816		req->special_vec.bv_offset = offset_in_page(range);
   817		req->special_vec.bv_len = sizeof(*range) * nr_range;
   818		req->rq_flags |= RQF_SPECIAL_PAYLOAD;
   819	
   820		return BLK_STS_OK;
   821	}
   822	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

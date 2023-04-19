Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED246E818C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjDSS4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 14:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDSS4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:56:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E614469A;
        Wed, 19 Apr 2023 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681930567; x=1713466567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QRGqBX37NR8aEdfN3qUrMJ+8qUa0XUBdBpWqWnI2SgM=;
  b=Ug/MSnTrVgBnR27xaTHG0PYUn0eAu/B/8BW69EKX0LMM9yWOAPKQCH4h
   VuWE2TrE29wv0uHqC4QxmSwNDSv5nmOXfzMZNGov6h3xvvRJ61b0pQFwJ
   R7K2u8ZDcFb/Er5TVI/gtuPfw1doObPXUJrTrpb1ahl3vSH2ssE3lMAyD
   YRJn5hFu67W24tuoNc98wWQPGK7PZt9CtJ1s+dTJNDO9aWX4wzkAErPR8
   RnTH75irG/en2MKX05MI4ZAol7O5i0YKPE5OnIES1UoEd0ltAtKBd1Xwn
   uc44sU3RH+0a7FyjSBuuxoEV870fZepELzHf7Yfpd/dLVW6+gIwt8tsUE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="343015569"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="343015569"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 11:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="780939661"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="780939661"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2023 11:56:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppCyH-000f74-01;
        Wed, 19 Apr 2023 18:56:01 +0000
Date:   Thu, 20 Apr 2023 02:55:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, bvanassche@acm.org, hare@suse.de,
        ming.lei@redhat.com, dlemoal@kernel.org, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 6/9] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202304200240.fsLkpzvk-lkp@intel.com>
References: <20230419114320.13674-7-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419114320.13674-7-nj.shetty@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230418]
[cannot apply to axboe-block/for-next device-mapper-dm/for-next linus/master v6.3-rc7 v6.3-rc6 v6.3-rc5 v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Add-copy-offload-support-infrastructure/20230419-204352
patch link:    https://lore.kernel.org/r/20230419114320.13674-7-nj.shetty%40samsung.com
patch subject: [PATCH v10 6/9] nvmet: add copy command support for bdev and file ns
config: m68k-randconfig-s032-20230416 (https://download.01.org/0day-ci/archive/20230420/202304200240.fsLkpzvk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/420b04f7ba9a54898d62c1d60905f8cf952afde2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Add-copy-offload-support-infrastructure/20230419-204352
        git checkout 420b04f7ba9a54898d62c1d60905f8cf952afde2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304200240.fsLkpzvk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le16 [usertype] mssrl @@
   drivers/nvme/target/io-cmd-bdev.c:55:27: sparse:     expected unsigned int [usertype] val
   drivers/nvme/target/io-cmd-bdev.c:55:27: sparse:     got restricted __le16 [usertype] mssrl
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/io-cmd-bdev.c:55:27: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:57:29: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le16 [usertype] mssrl @@
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse:     expected unsigned int [usertype] val
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse:     got restricted __le16 [usertype] mssrl
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:60:27: sparse: sparse: cast from restricted __le16

vim +55 drivers/nvme/target/io-cmd-bdev.c

    12	
    13	void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
    14	{
    15		/* Logical blocks per physical block, 0's based. */
    16		const __le16 lpp0b = to0based(bdev_physical_block_size(bdev) /
    17					      bdev_logical_block_size(bdev));
    18	
    19		/*
    20		 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
    21		 * NAWUPF, and NACWU are defined for this namespace and should be
    22		 * used by the host for this namespace instead of the AWUN, AWUPF,
    23		 * and ACWU fields in the Identify Controller data structure. If
    24		 * any of these fields are zero that means that the corresponding
    25		 * field from the identify controller data structure should be used.
    26		 */
    27		id->nsfeat |= 1 << 1;
    28		id->nawun = lpp0b;
    29		id->nawupf = lpp0b;
    30		id->nacwu = lpp0b;
    31	
    32		/*
    33		 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
    34		 * NOWS are defined for this namespace and should be used by
    35		 * the host for I/O optimization.
    36		 */
    37		id->nsfeat |= 1 << 4;
    38		/* NPWG = Namespace Preferred Write Granularity. 0's based */
    39		id->npwg = lpp0b;
    40		/* NPWA = Namespace Preferred Write Alignment. 0's based */
    41		id->npwa = id->npwg;
    42		/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
    43		id->npdg = to0based(bdev_discard_granularity(bdev) /
    44				    bdev_logical_block_size(bdev));
    45		/* NPDG = Namespace Preferred Deallocate Alignment */
    46		id->npda = id->npdg;
    47		/* NOWS = Namespace Optimal Write Size */
    48		id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
    49	
    50		/*Copy limits*/
    51		if (bdev_max_copy_sectors(bdev)) {
    52			id->msrc = id->msrc;
    53			id->mssrl = cpu_to_le16((bdev_max_copy_sectors(bdev) <<
    54					SECTOR_SHIFT) / bdev_logical_block_size(bdev));
  > 55			id->mcl = cpu_to_le32(id->mssrl);
    56		} else {
    57			id->msrc = (u8)to0based(BIO_MAX_VECS - 1);
    58			id->mssrl = cpu_to_le16((BIO_MAX_VECS << PAGE_SHIFT) /
    59					bdev_logical_block_size(bdev));
    60			id->mcl = cpu_to_le32(id->mssrl);
    61		}
    62	}
    63	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

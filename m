Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555A8513772
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiD1O5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiD1O5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:57:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40598B1AB0;
        Thu, 28 Apr 2022 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651157630; x=1682693630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=laK4u97EX9doYugJxLEEbIUOUAx/Qz9PAszFYjC5IiA=;
  b=TuKL3jA6BdXeu16KLOsm/GUBQL5ZMqxA2INSrBS4JQyu7PHjxgyeQXKP
   9JDmVDC1V11rKk8IQ9HUH0P1XZuqu1L/GU4TzaotiBGCNNZQk8Fdm/f0y
   dl6GpSVUMF+qpSURpWj9qHmXVckqZz/BjeA1IDjdMnSeqhflWv6j24WpC
   mcxYIKh+pybMCOIfGKK4qFPqvT3UjxZgTHO5qJU5h9kOQATKv6wW68gLR
   V7yGqDh4sDe5/i8JwbbK0ITLwbew7RdAtBfBsP+W0mVkVmzZb15xHqlgN
   TnWEViRG5IRiGlo65CBrDjQIuyOmwiIyf4Ozv8XVuEsNG+DCewJqmTPsc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266127998"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="266127998"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 07:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="514327844"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2022 07:53:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk5WY-0005Sd-BN;
        Thu, 28 Apr 2022 14:53:42 +0000
Date:   Thu, 28 Apr 2022 22:53:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     kbuild-all@lists.01.org, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v4 06/10] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202204282248.B5VfX8LS-lkp@intel.com>
References: <20220426101241.30100-7-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-7-nj.shetty@samsung.com>
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
config: s390-randconfig-s032-20220427 (https://download.01.org/0day-ci/archive/20220428/202204282248.B5VfX8LS-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/6a9ea8570c34a7222786ca4d129578f48426d2f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout 6a9ea8570c34a7222786ca4d129578f48426d2f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/md/ drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/io-cmd-bdev.c:56:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:56:26: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:56:26: sparse:     got restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:59:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:59:34: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:59:34: sparse:     got restricted __le16
--
>> drivers/nvme/target/admin-cmd.c:537:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/admin-cmd.c:537:26: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/admin-cmd.c:537:26: sparse:     got restricted __le16

vim +56 drivers/nvme/target/io-cmd-bdev.c

    12	
    13	void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
    14	{
    15		const struct queue_limits *ql = &bdev_get_queue(bdev)->limits;
    16		/* Number of logical blocks per physical block. */
    17		const u32 lpp = ql->physical_block_size / ql->logical_block_size;
    18		/* Logical blocks per physical block, 0's based. */
    19		const __le16 lpp0b = to0based(lpp);
    20	
    21		/*
    22		 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
    23		 * NAWUPF, and NACWU are defined for this namespace and should be
    24		 * used by the host for this namespace instead of the AWUN, AWUPF,
    25		 * and ACWU fields in the Identify Controller data structure. If
    26		 * any of these fields are zero that means that the corresponding
    27		 * field from the identify controller data structure should be used.
    28		 */
    29		id->nsfeat |= 1 << 1;
    30		id->nawun = lpp0b;
    31		id->nawupf = lpp0b;
    32		id->nacwu = lpp0b;
    33	
    34		/*
    35		 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
    36		 * NOWS are defined for this namespace and should be used by
    37		 * the host for I/O optimization.
    38		 */
    39		id->nsfeat |= 1 << 4;
    40		/* NPWG = Namespace Preferred Write Granularity. 0's based */
    41		id->npwg = lpp0b;
    42		/* NPWA = Namespace Preferred Write Alignment. 0's based */
    43		id->npwa = id->npwg;
    44		/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
    45		id->npdg = to0based(ql->discard_granularity / ql->logical_block_size);
    46		/* NPDG = Namespace Preferred Deallocate Alignment */
    47		id->npda = id->npdg;
    48		/* NOWS = Namespace Optimal Write Size */
    49		id->nows = to0based(ql->io_opt / ql->logical_block_size);
    50	
    51		/*Copy limits*/
    52		if (ql->max_copy_sectors) {
    53			id->mcl = cpu_to_le32((ql->max_copy_sectors << 9) / ql->logical_block_size);
    54			id->mssrl = cpu_to_le16((ql->max_copy_range_sectors << 9) /
    55					ql->logical_block_size);
  > 56			id->msrc = to0based(ql->max_copy_nr_ranges);
    57		} else {
    58			if (ql->zoned == BLK_ZONED_NONE) {
    59				id->msrc = to0based(BIO_MAX_VECS);
    60				id->mssrl = cpu_to_le16(
    61						(BIO_MAX_VECS << PAGE_SHIFT) / ql->logical_block_size);
    62				id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl) * BIO_MAX_VECS);
    63	#ifdef CONFIG_BLK_DEV_ZONED
    64			} else {
    65				/* TODO: get right values for zoned device */
    66				id->msrc = to0based(BIO_MAX_VECS);
    67				id->mssrl = cpu_to_le16(min((BIO_MAX_VECS << PAGE_SHIFT),
    68						ql->chunk_sectors) / ql->logical_block_size);
    69				id->mcl = cpu_to_le32(min(le16_to_cpu(id->mssrl) * BIO_MAX_VECS,
    70							ql->chunk_sectors));
    71	#endif
    72			}
    73		}
    74	}
    75	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

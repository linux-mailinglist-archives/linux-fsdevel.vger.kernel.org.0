Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7134B085A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 09:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiBJIbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 03:31:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiBJIbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:31:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCDF1128;
        Thu, 10 Feb 2022 00:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644481901; x=1676017901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8c00mtbRrdA18FyTX012jqJDs1wrgVfFCJpPUSIXoOg=;
  b=kIaWDprOJ97uL3HXho1jQnTXl9egIlImJKQv4Q4EYGozZgcs8CUF2hYJ
   HMBCjXQyTDiOts33c7LCStVk+P51p3WbcsWo4vUUgyFDqFPtyis3pbK9H
   pRss22b87SaV4BtqFPyHzOmyHiEaWvR9rR0KFlFzA1tfDd2+oKyiVJr5+
   GIoiMBXPsasDZUztzRUVjzPyhKDQ2ZaW+Q/izG3uZEznlpA3mJMMDEm7m
   s4OYh4P6SksnbDglqdT6Parlr07NKxKwbvbo6T/2vW0gC0hDJXnX9tIea
   Vm2oFc88E9t6vr8ZhzkVsLZby0wvcPCxG7VKvVlMAuKHxLf9zDM0opful
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="248273487"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="248273487"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 00:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="629615271"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2022 00:31:34 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nI4rW-0002yF-8m; Thu, 10 Feb 2022 08:31:34 +0000
Date:   Thu, 10 Feb 2022 16:31:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>, mpatocka@redhat.com
Cc:     kbuild-all@lists.01.org, javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nj.shetty@samsung.com
Subject: Re: [PATCH v2 07/10] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202202101647.VtWTgalm-lkp@intel.com>
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
[also build test WARNING on linus/master v5.17-rc3 next-20220209]
[cannot apply to device-mapper-dm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm64-randconfig-s032-20220207 (https://download.01.org/0day-ci/archive/20220210/202202101647.VtWTgalm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/6bb6ea64499e1ac27975e79bb2eee89f07861893
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
        git checkout 6bb6ea64499e1ac27975e79bb2eee89f07861893
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/io-cmd-bdev.c:52:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] mcl @@     got restricted __le64 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:52:25: sparse:     expected restricted __le32 [usertype] mcl
   drivers/nvme/target/io-cmd-bdev.c:52:25: sparse:     got restricted __le64 [usertype]
>> drivers/nvme/target/io-cmd-bdev.c:53:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] mssrl @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:53:27: sparse:     expected restricted __le16 [usertype] mssrl
   drivers/nvme/target/io-cmd-bdev.c:53:27: sparse:     got restricted __le32 [usertype]
>> drivers/nvme/target/io-cmd-bdev.c:55:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:55:26: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:55:26: sparse:     got restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:58:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:58:34: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:58:34: sparse:     got restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:59:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] mssrl @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:59:35: sparse:     expected restricted __le16 [usertype] mssrl
   drivers/nvme/target/io-cmd-bdev.c:59:35: sparse:     got restricted __le32 [usertype]
>> drivers/nvme/target/io-cmd-bdev.c:61:35: sparse: sparse: cast to restricted __le32
>> drivers/nvme/target/io-cmd-bdev.c:61:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:61:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] mcl @@     got restricted __le64 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:61:33: sparse:     expected restricted __le32 [usertype] mcl
   drivers/nvme/target/io-cmd-bdev.c:61:33: sparse:     got restricted __le64 [usertype]
   drivers/nvme/target/io-cmd-bdev.c:65:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/io-cmd-bdev.c:65:34: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/io-cmd-bdev.c:65:34: sparse:     got restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:66:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] mssrl @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:66:35: sparse:     expected restricted __le16 [usertype] mssrl
   drivers/nvme/target/io-cmd-bdev.c:66:35: sparse:     got restricted __le32 [usertype]
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/io-cmd-bdev.c:68:35: sparse: sparse: cast from restricted __le16
   drivers/nvme/target/io-cmd-bdev.c:68:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] mcl @@     got restricted __le64 [usertype] @@
   drivers/nvme/target/io-cmd-bdev.c:68:33: sparse:     expected restricted __le32 [usertype] mcl
   drivers/nvme/target/io-cmd-bdev.c:68:33: sparse:     got restricted __le64 [usertype]
--
>> drivers/nvme/target/admin-cmd.c:533:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] msrc @@     got restricted __le16 @@
   drivers/nvme/target/admin-cmd.c:533:26: sparse:     expected unsigned char [usertype] msrc
   drivers/nvme/target/admin-cmd.c:533:26: sparse:     got restricted __le16
>> drivers/nvme/target/admin-cmd.c:534:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] mssrl @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/admin-cmd.c:534:27: sparse:     expected restricted __le16 [usertype] mssrl
   drivers/nvme/target/admin-cmd.c:534:27: sparse:     got restricted __le32 [usertype]
>> drivers/nvme/target/admin-cmd.c:535:27: sparse: sparse: cast to restricted __le32
>> drivers/nvme/target/admin-cmd.c:535:27: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/admin-cmd.c:535:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] mcl @@     got restricted __le64 [usertype] @@
   drivers/nvme/target/admin-cmd.c:535:25: sparse:     expected restricted __le32 [usertype] mcl
   drivers/nvme/target/admin-cmd.c:535:25: sparse:     got restricted __le64 [usertype]

vim +52 drivers/nvme/target/io-cmd-bdev.c

    11	
    12	void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
    13	{
    14		const struct queue_limits *ql = &bdev_get_queue(bdev)->limits;
    15		/* Number of logical blocks per physical block. */
    16		const u32 lpp = ql->physical_block_size / ql->logical_block_size;
    17		/* Logical blocks per physical block, 0's based. */
    18		const __le16 lpp0b = to0based(lpp);
    19	
    20		/*
    21		 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
    22		 * NAWUPF, and NACWU are defined for this namespace and should be
    23		 * used by the host for this namespace instead of the AWUN, AWUPF,
    24		 * and ACWU fields in the Identify Controller data structure. If
    25		 * any of these fields are zero that means that the corresponding
    26		 * field from the identify controller data structure should be used.
    27		 */
    28		id->nsfeat |= 1 << 1;
    29		id->nawun = lpp0b;
    30		id->nawupf = lpp0b;
    31		id->nacwu = lpp0b;
    32	
    33		/*
    34		 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
    35		 * NOWS are defined for this namespace and should be used by
    36		 * the host for I/O optimization.
    37		 */
    38		id->nsfeat |= 1 << 4;
    39		/* NPWG = Namespace Preferred Write Granularity. 0's based */
    40		id->npwg = lpp0b;
    41		/* NPWA = Namespace Preferred Write Alignment. 0's based */
    42		id->npwa = id->npwg;
    43		/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
    44		id->npdg = to0based(ql->discard_granularity / ql->logical_block_size);
    45		/* NPDG = Namespace Preferred Deallocate Alignment */
    46		id->npda = id->npdg;
    47		/* NOWS = Namespace Optimal Write Size */
    48		id->nows = to0based(ql->io_opt / ql->logical_block_size);
    49	
    50		/*Copy limits*/
    51		if (ql->max_copy_sectors) {
  > 52			id->mcl = cpu_to_le64((ql->max_copy_sectors << 9) / ql->logical_block_size);
  > 53			id->mssrl = cpu_to_le32((ql->max_copy_range_sectors << 9) /
    54					ql->logical_block_size);
  > 55			id->msrc = to0based(ql->max_copy_nr_ranges);
    56		} else {
    57			if (ql->zoned == BLK_ZONED_NONE) {
    58				id->msrc = to0based(BIO_MAX_VECS);
    59				id->mssrl = cpu_to_le32(
    60						(BIO_MAX_VECS << PAGE_SHIFT) / ql->logical_block_size);
  > 61				id->mcl = cpu_to_le64(le32_to_cpu(id->mssrl) * BIO_MAX_VECS);
    62	#ifdef CONFIG_BLK_DEV_ZONED
    63			} else {
    64				/* TODO: get right values for zoned device */
    65				id->msrc = to0based(BIO_MAX_VECS);
    66				id->mssrl = cpu_to_le32(min((BIO_MAX_VECS << PAGE_SHIFT),
    67						ql->chunk_sectors) / ql->logical_block_size);
    68				id->mcl = cpu_to_le64(min(le32_to_cpu(id->mssrl) * BIO_MAX_VECS,
    69							ql->chunk_sectors));
    70	#endif
    71			}
    72		}
    73	}
    74	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

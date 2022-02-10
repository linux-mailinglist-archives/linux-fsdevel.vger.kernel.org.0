Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D75D4B06D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 08:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiBJHJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 02:09:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiBJHJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:09:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9190D6D;
        Wed,  9 Feb 2022 23:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644476979; x=1676012979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=584MwG2iZL/ZKEmSpY0r/AEBoG/ID+aoMKFMo/Oh1Hg=;
  b=JE9Ucnq37UIQaf8Z0GNPRA/ArsP5CqLUza+4UdOS3RZgqIGFAwFJVhPP
   3xJaOc6Yq/24cHQXAIdNe6jOpZcUKQMcKLY9468yEN6jMWpWObwkm1nV/
   aP0cdEOxCVn4bN06yTKSoaE/uFFM3zVxV5Nu7/qbZWdEM6DE9Y6wN0y1k
   w5alR2eqpdRzgrOceFHHd2wAeeRmDY57mB7EUNZSUk8BroXnZnERdnI5w
   I4rIYQMUZUyizhFxlfZBFeMcO876JUhaa+IiAvo630dFRAyj8/EAtdklF
   hKzQKHKbgo0jJdGysYqtXjNu1xqyvsift89boVtwXSQPsXnBYKF8pEE57
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="247010974"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="247010974"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 23:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="482643883"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Feb 2022 23:09:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nI3a7-0002rA-1q; Thu, 10 Feb 2022 07:09:31 +0000
Date:   Thu, 10 Feb 2022 15:08:52 +0800
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
        nj.shetty@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH v2 06/10] nvme: add copy support
Message-ID: <202202101447.DEcXWmHU-lkp@intel.com>
References: <20220207141348.4235-7-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-7-nj.shetty@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
config: arm64-randconfig-s032-20220207 (https://download.01.org/0day-ci/archive/20220210/202202101447.DEcXWmHU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/22cbc1d3df11aaadd02b27ce5dcb702f9a8f4272
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
        git checkout 22cbc1d3df11aaadd02b27ce5dcb702f9a8f4272
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvme/host/ drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/core.c:1793:42: sparse: sparse: cast to restricted __le64
   drivers/nvme/host/core.c:1793:42: sparse: sparse: cast from restricted __le32
>> drivers/nvme/host/core.c:1795:48: sparse: sparse: cast to restricted __le32
>> drivers/nvme/host/core.c:1795:48: sparse: sparse: cast from restricted __le16
>> drivers/nvme/host/core.c:903:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] dspec @@     got restricted __le32 [usertype] @@
   drivers/nvme/host/core.c:903:26: sparse:     expected restricted __le16 [usertype] dspec
   drivers/nvme/host/core.c:903:26: sparse:     got restricted __le32 [usertype]

vim +1793 drivers/nvme/host/core.c

  1774	
  1775	static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
  1776					       struct nvme_id_ns *id)
  1777	{
  1778		struct nvme_ctrl *ctrl = ns->ctrl;
  1779		struct request_queue *queue = disk->queue;
  1780	
  1781		if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
  1782			queue->limits.copy_offload = 0;
  1783			queue->limits.max_copy_sectors = 0;
  1784			queue->limits.max_copy_range_sectors = 0;
  1785			queue->limits.max_copy_nr_ranges = 0;
  1786			blk_queue_flag_clear(QUEUE_FLAG_COPY, queue);
  1787			return;
  1788		}
  1789	
  1790		/* setting copy limits */
  1791		blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, queue);
  1792		queue->limits.copy_offload = 0;
> 1793		queue->limits.max_copy_sectors = le64_to_cpu(id->mcl) *
  1794			(1 << (ns->lba_shift - 9));
> 1795		queue->limits.max_copy_range_sectors = le32_to_cpu(id->mssrl) *
  1796			(1 << (ns->lba_shift - 9));
  1797		queue->limits.max_copy_nr_ranges = id->msrc + 1;
  1798	}
  1799	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

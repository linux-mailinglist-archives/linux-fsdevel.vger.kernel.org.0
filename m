Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C457B51391C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349679AbiD1P6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348580AbiD1P6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:58:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083D18B2E;
        Thu, 28 Apr 2022 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651161323; x=1682697323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BimimfYrZUnTbXW408UFheZhJCa7AI21cga9+oD2hA=;
  b=EZst4Pbs5+KuuLWn5XzI6rhNqYdkapoyxSu6PLTHQcmBbvX6rkncejHK
   4LvLxmo1yf97CD7qDkJvZDzv034uvF0QytL+oXLMza1avfDIaBukyYAi3
   EJwF3AhSdL9LtXGdVvCFMhre5/TU4ps6qX5dfhLsNRwpCqIjC9rDuUUkd
   6/HE7iZfwwZiHyIT8Qu8s1dX7vpCVN1Or2xI7Q1PG6qWeQ31gmDrb2ag5
   XVmd7rNU8tuZiEMTGVYM7qXcAL2MOzLWkRVCOKr1kxwxeUj5PmepNuwec
   WmjHDPyGptWxyxbdZKyUvpuXydWQofdvuu2nrAaGzRylgg+LRocMajDlS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266490779"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="266490779"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="514363012"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2022 08:55:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk6U6-0005VH-CQ;
        Thu, 28 Apr 2022 15:55:14 +0000
Date:   Thu, 28 Apr 2022 23:54:46 +0800
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
        Nitesh Shetty <nj.shetty@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v4 07/10] dm: Add support for copy offload.
Message-ID: <202204282336.7AY0GVKz-lkp@intel.com>
References: <20220426101241.30100-8-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-8-nj.shetty@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: s390-randconfig-s032-20220427 (https://download.01.org/0day-ci/archive/20220428/202204282336.7AY0GVKz-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/913c8c5197fea28ee3c8424e16eadd8b159a91f0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout 913c8c5197fea28ee3c8424e16eadd8b159a91f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/md/dm.c:1602:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted blk_status_t @@     got int @@
   drivers/md/dm.c:1602:24: sparse:     expected restricted blk_status_t
   drivers/md/dm.c:1602:24: sparse:     got int

vim +1602 drivers/md/dm.c

  1582	
  1583	/*
  1584	 * Select the correct strategy for processing a non-flush bio.
  1585	 */
  1586	static blk_status_t __split_and_process_bio(struct clone_info *ci)
  1587	{
  1588		struct bio *clone;
  1589		struct dm_target *ti;
  1590		unsigned len;
  1591	
  1592		ti = dm_table_find_target(ci->map, ci->sector);
  1593		if (unlikely(!ti))
  1594			return BLK_STS_IOERR;
  1595		else if (unlikely(ci->is_abnormal_io))
  1596			return __process_abnormal_io(ci, ti);
  1597	
  1598		if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
  1599					max_io_len(ti, ci->sector) < ci->sector_count)) {
  1600			DMERR("%s: Error IO size(%u) is greater than maximum target size(%llu)\n",
  1601					__func__, ci->sector_count, max_io_len(ti, ci->sector));
> 1602			return -EIO;
  1603		}
  1604		/*
  1605		 * Only support bio polling for normal IO, and the target io is
  1606		 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
  1607		 */
  1608		ci->submit_as_polled = ci->bio->bi_opf & REQ_POLLED;
  1609	
  1610		len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
  1611		setup_split_accounting(ci, len);
  1612		clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
  1613		__map_bio(clone);
  1614	
  1615		ci->sector += len;
  1616		ci->sector_count -= len;
  1617	
  1618		return BLK_STS_OK;
  1619	}
  1620	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

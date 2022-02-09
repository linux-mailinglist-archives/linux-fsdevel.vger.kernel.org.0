Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289924AE847
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 05:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346132AbiBIEIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 23:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347094AbiBIDjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:39:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2058DC06174F;
        Tue,  8 Feb 2022 19:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644377970; x=1675913970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UUr2oeyzfQDDRtI6hlTLxPqoP/+EpMIGE8+TwWUBk0o=;
  b=ez4stKHhDDVl6yT1xk5D8g+3iUmg6vrCg8TAcWNDTtW/xjyZoVHkRtZ5
   AkML9UxVY1ZAhD/aTHvD0/3HXMB2dpsSCRydZH82ctlxsBCTB2U96Xgky
   6CE1Ffq0Udon1BOWvX0OHPNOF3GER6T7MJTggDfsPXGg+ZBoP1ivFgiWr
   9Lnn0vGK9LR2fXDionZhp+FoMQGhojvuhSQgfNXqQzgFyAM2aPkT8ECtb
   6PukQzvp23a5vkpBXcCI7xCABAid6MlSUqkj0wlwHZfUEVnV2FJnnBTCw
   xpNL6Zk1jhro343tWtHiX6vAKur/bWm7Bstd/yrOxlOjFHfvU46ZNM2g1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335513823"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="335513823"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 19:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="771204809"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2022 19:39:23 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHdpD-0001Al-6Z; Wed, 09 Feb 2022 03:39:23 +0000
Date:   Wed, 9 Feb 2022 11:39:03 +0800
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
Subject: Re: [PATCH v2 04/10] block: Introduce a new ioctl for copy
Message-ID: <202202091048.qDQvi6ab-lkp@intel.com>
References: <20220207141348.4235-5-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-5-nj.shetty@samsung.com>
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
[also build test WARNING on next-20220208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220209/202202091048.qDQvi6ab-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> block/ioctl.c:145:10-17: WARNING opportunity for memdup_user

vim +145 block/ioctl.c

   126	
   127	static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
   128			unsigned long arg)
   129	{
   130		struct copy_range crange, *ranges;
   131		size_t payload_size = 0;
   132		int ret;
   133	
   134		if (!(mode & FMODE_WRITE))
   135			return -EBADF;
   136	
   137		if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
   138			return -EFAULT;
   139	
   140		if (unlikely(!crange.nr_range || crange.reserved || crange.nr_range >= MAX_COPY_NR_RANGE))
   141			return -EINVAL;
   142	
   143		payload_size = (crange.nr_range * sizeof(struct range_entry)) + sizeof(crange);
   144	
 > 145		ranges = kmalloc(payload_size, GFP_KERNEL);
   146		if (!ranges)
   147			return -ENOMEM;
   148	
   149		if (copy_from_user(ranges, (void __user *)arg, payload_size)) {
   150			ret = -EFAULT;
   151			goto out;
   152		}
   153	
   154		ret = blkdev_issue_copy(bdev, ranges->nr_range, ranges->range_list, bdev, GFP_KERNEL, 0);
   155		if (copy_to_user((void __user *)arg, ranges, payload_size))
   156			ret = -EFAULT;
   157	out:
   158		kfree(ranges);
   159		return ret;
   160	}
   161	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

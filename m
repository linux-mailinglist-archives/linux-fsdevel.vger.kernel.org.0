Return-Path: <linux-fsdevel+bounces-9198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82883EC85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 10:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA49C282C3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE451EB4A;
	Sat, 27 Jan 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VA112hqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01BA1EA72;
	Sat, 27 Jan 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706349501; cv=none; b=X1zq7/4eGScG7rfz0xDeQNvWd5LVnbh15kVv8rRuUqKXfaCC0ryCzIAcwL58TBCCld1VE5rwU/pprx7Fhh5K7CG9N+1D4OTEnOAvWVXTdXlNs/qAdDgf8e2y7YHvawRbgsdR0Kf3aMyQC5Gw1DzjOOQ41MM6UeM1HIDqyor6h0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706349501; c=relaxed/simple;
	bh=r+T7mnQmtI5J+JZqBTfH0y2lgNd/RUDtr9kKlTXAe0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHXMth1Rex+pOwUTT2NsJSUSdJB2x0z1Xc2EaFAniNbyBozLMyr5+ZLvHv7gC6/HbMtflqr0qPLNxkJqnZpjFi4Ooc/rV1XbrYuhOyWUn2O1cu8phBGgj9iqV0e3J/p5KFMv5zDKOIXmiQ9ESwPS+xY57bYfap1G5SYcBbuSPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VA112hqr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706349500; x=1737885500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r+T7mnQmtI5J+JZqBTfH0y2lgNd/RUDtr9kKlTXAe0w=;
  b=VA112hqrYRupkh7rKxM6DbxY+kTCWm+p1LKfc5LR0Tx/oE32VK66tpIx
   9z9IfaDb4y5z1xZvwXalxyN2IFgd4gGgY98S2qhMK7GMPTXQniaxSERsc
   1NY877O/+myrgO3Yp14LL6KlIrXJbi9LlY7cE+/Bwt4dD2+aQyp3W7wjk
   4tmvnOHpgZ0BTvOfLOhk+TIJ6l8gvr1LeapzV+FmBRZlyozG7FEyomO1Y
   V+Kt+hK/hpRDCoWLSZ1cWD7+s2AtweTIc4V/SXXEtqW7aOLXi7uzU5Z+B
   UoJD3+ygQRqXtZvZFtBpcmXUQgNsQmbFQua7Y41i0fNe9WK+mUQ4aW2P9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9341796"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9341796"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 01:58:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2947041"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Jan 2024 01:58:13 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTfRz-00025e-0m;
	Sat, 27 Jan 2024 09:58:11 +0000
Date: Sat, 27 Jan 2024 17:57:59 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Chris Mason <chris.mason@fusionio.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
	Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 5/5] block: remove gfp_flags from blkdev_zone_mgmt
Message-ID: <202401271724.LJfDQ6VB-lkp@intel.com>
References: <20240123-zonefs_nofs-v1-5-cc0b0308ef25@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-zonefs_nofs-v1-5-cc0b0308ef25@wdc.com>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/zonefs-pass-GFP_KERNEL-to-blkdev_zone_mgmt-call/20240123-174911
base:   7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf
patch link:    https://lore.kernel.org/r/20240123-zonefs_nofs-v1-5-cc0b0308ef25%40wdc.com
patch subject: [PATCH 5/5] block: remove gfp_flags from blkdev_zone_mgmt
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240127/202401271724.LJfDQ6VB-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401271724.LJfDQ6VB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401271724.LJfDQ6VB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/md/dm-zoned-metadata.c: In function 'dmz_reset_zone':
>> drivers/md/dm-zoned-metadata.c:1659:23: error: too many arguments to function 'blkdev_zone_mgmt'
    1659 |                 ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
         |                       ^~~~~~~~~~~~~~~~
   In file included from drivers/md/dm-zoned.h:12,
                    from drivers/md/dm-zoned-metadata.c:8:
   include/linux/blkdev.h:327:5: note: declared here
     327 | int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
         |     ^~~~~~~~~~~~~~~~


vim +/blkdev_zone_mgmt +1659 drivers/md/dm-zoned-metadata.c

3b1a94c88b798d Damien Le Moal     2017-06-07  1639  
3b1a94c88b798d Damien Le Moal     2017-06-07  1640  /*
3b1a94c88b798d Damien Le Moal     2017-06-07  1641   * Reset a zone write pointer.
3b1a94c88b798d Damien Le Moal     2017-06-07  1642   */
3b1a94c88b798d Damien Le Moal     2017-06-07  1643  static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
3b1a94c88b798d Damien Le Moal     2017-06-07  1644  {
3b1a94c88b798d Damien Le Moal     2017-06-07  1645  	int ret;
3b1a94c88b798d Damien Le Moal     2017-06-07  1646  
3b1a94c88b798d Damien Le Moal     2017-06-07  1647  	/*
3b1a94c88b798d Damien Le Moal     2017-06-07  1648  	 * Ignore offline zones, read only zones,
3b1a94c88b798d Damien Le Moal     2017-06-07  1649  	 * and conventional zones.
3b1a94c88b798d Damien Le Moal     2017-06-07  1650  	 */
3b1a94c88b798d Damien Le Moal     2017-06-07  1651  	if (dmz_is_offline(zone) ||
3b1a94c88b798d Damien Le Moal     2017-06-07  1652  	    dmz_is_readonly(zone) ||
3b1a94c88b798d Damien Le Moal     2017-06-07  1653  	    dmz_is_rnd(zone))
3b1a94c88b798d Damien Le Moal     2017-06-07  1654  		return 0;
3b1a94c88b798d Damien Le Moal     2017-06-07  1655  
3b1a94c88b798d Damien Le Moal     2017-06-07  1656  	if (!dmz_is_empty(zone) || dmz_seq_write_err(zone)) {
8f22272af7a727 Hannes Reinecke    2020-06-02  1657  		struct dmz_dev *dev = zone->dev;
3b1a94c88b798d Damien Le Moal     2017-06-07  1658  
6c1b1da58f8c7a Ajay Joshi         2019-10-27 @1659  		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
3b1a94c88b798d Damien Le Moal     2017-06-07  1660  				       dmz_start_sect(zmd, zone),
c4d4977392621f Johannes Thumshirn 2024-01-23  1661  				       zmd->zone_nr_sectors, GFP_KERNEL);
3b1a94c88b798d Damien Le Moal     2017-06-07  1662  		if (ret) {
3b1a94c88b798d Damien Le Moal     2017-06-07  1663  			dmz_dev_err(dev, "Reset zone %u failed %d",
b71228739851a9 Hannes Reinecke    2020-05-11  1664  				    zone->id, ret);
3b1a94c88b798d Damien Le Moal     2017-06-07  1665  			return ret;
3b1a94c88b798d Damien Le Moal     2017-06-07  1666  		}
3b1a94c88b798d Damien Le Moal     2017-06-07  1667  	}
3b1a94c88b798d Damien Le Moal     2017-06-07  1668  
3b1a94c88b798d Damien Le Moal     2017-06-07  1669  	/* Clear write error bit and rewind write pointer position */
3b1a94c88b798d Damien Le Moal     2017-06-07  1670  	clear_bit(DMZ_SEQ_WRITE_ERR, &zone->flags);
3b1a94c88b798d Damien Le Moal     2017-06-07  1671  	zone->wp_block = 0;
3b1a94c88b798d Damien Le Moal     2017-06-07  1672  
3b1a94c88b798d Damien Le Moal     2017-06-07  1673  	return 0;
3b1a94c88b798d Damien Le Moal     2017-06-07  1674  }
3b1a94c88b798d Damien Le Moal     2017-06-07  1675  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


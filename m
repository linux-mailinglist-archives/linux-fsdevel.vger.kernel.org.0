Return-Path: <linux-fsdevel+bounces-72251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B2CEA9D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 21:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09F20301D64C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 20:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7A270ED2;
	Tue, 30 Dec 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1QFYAfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF91C4A24;
	Tue, 30 Dec 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126862; cv=none; b=U50OqwbJFy61N+bbyBvtw5C2qWl97ILSlI/LrmxkPW6/aJ42rgWvBPIcZxJxFFFsCzYTXwnjyO+8REpw0+WgbNcl4Ibx90EFXV0AyySayOwgjTzmZaFpeyP/jCZsB3u80YIycYDlqeFb/d383OiA+g51YNyRy0rvTzdgGJuhY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126862; c=relaxed/simple;
	bh=Wc0iK0oNUrBiKY76jJFMsmF3cAIUm6ISoNB2BRSUIB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bob3joxmJvBp3qTVthsHM4U4ViJyY3+hf2kFyXKU4qGHPp/zU1RHmReUGDVoM94UEd7LJ8v9ENtYmrM8H4h7BZo0eW/SadFz2a8xksFHX9Qn4V/yyIykTpDftaZl134EKi8LCNJoQkBkirSD524TMCdf2XbCrPE16POyXTavqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1QFYAfp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767126860; x=1798662860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wc0iK0oNUrBiKY76jJFMsmF3cAIUm6ISoNB2BRSUIB8=;
  b=Q1QFYAfpwRE8utDNh/VTjRUxoH1PoW7GXoYltbgojGdxVVUnmQZjVEHW
   oIZyhMTi18mTxDlNQjHsA7eod36I54/dZ512+wk4zrkpnPUKg6RU2IkqX
   /YYUJqwZSVypDITLukQELP0PRNMwzPGDdV3rhR18TLWSrmxfB+CKoWT28
   RJeXvvtcztpyHabqUwqPtUdY0l3AlS0HntRMrTcOfgUq+i+EX+Eu6s4c0
   DHuYikfmgh4v8S6WVytocRfnOmaUhNN2aV9+PR7eXi5KZx4QBBm5KISFI
   PUYWNNhptKyukz3y56xwSww806LKlb0noVi+ZWtawLqGSjn2iExqBRQAY
   Q==;
X-CSE-ConnectionGUID: hP/BJFBBRfaOhHPqAKMHlQ==
X-CSE-MsgGUID: vVLY2nNLQUy/dRwTxCJmOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="72563602"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="72563602"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 12:34:19 -0800
X-CSE-ConnectionGUID: RzQTmgrDTWeph3B3bsyazw==
X-CSE-MsgGUID: CbIiXqDoQIquYPl7Bc2V9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="224787160"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 30 Dec 2025 12:34:17 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vagQ2-0000000081Q-3Zc1;
	Tue, 30 Dec 2025 20:34:14 +0000
Date: Tue, 30 Dec 2025 21:34:11 +0100
From: kernel test robot <lkp@intel.com>
To: Yuto Ohnuki <ytohnuki@amazon.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Yuto Ohnuki <ytohnuki@amazon.com>
Subject: Re: [PATCH] fs: remove stale and duplicate forward declarations
Message-ID: <202512302108.nIV8r5ES-lkp@intel.com>
References: <20251229071401.98146-1-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229071401.98146-1-ytohnuki@amazon.com>

Hi Yuto,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.16-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuto-Ohnuki/fs-remove-stale-and-duplicate-forward-declarations/20251229-151612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251229071401.98146-1-ytohnuki%40amazon.com
patch subject: [PATCH] fs: remove stale and duplicate forward declarations
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251230/202512302108.nIV8r5ES-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251230/202512302108.nIV8r5ES-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512302108.nIV8r5ES-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from block/bdev.c:14:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
--
   In file included from block/ioctl.c:4:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
   block/ioctl.c: In function 'blkdev_getgeo':
>> block/ioctl.c:564:40: error: passing argument 2 of 'disk->fops->getgeo' from incompatible pointer type [-Wincompatible-pointer-types]
     564 |         ret = disk->fops->getgeo(disk, &geo);
         |                                        ^~~~
         |                                        |
         |                                        struct hd_geometry *
   block/ioctl.c:564:40: note: expected 'struct hd_geometry *' but argument is of type 'struct hd_geometry *'
--
   In file included from drivers/md/md.c:43:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
>> drivers/md/md.c:8421:27: error: initialization of 'int (*)(struct gendisk *, struct hd_geometry *)' from incompatible pointer type 'int (*)(struct gendisk *, struct hd_geometry *)' [-Wincompatible-pointer-types]
    8421 |         .getgeo         = md_getgeo,
         |                           ^~~~~~~~~
   drivers/md/md.c:8421:27: note: (near initialization for 'md_fops.getgeo')
--
   In file included from include/linux/blk-mq.h:5,
                    from drivers/md/dm-core.h:15,
                    from drivers/md/dm-builtin.c:2:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
   In file included from drivers/md/dm.h:14,
                    from drivers/md/dm-core.h:21:
>> include/linux/device-mapper.h:571:54: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
     571 | int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |                                                      ^~~~~~~~~~~
   include/linux/device-mapper.h:572:54: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
     572 | int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |                                                      ^~~~~~~~~~~
--
   In file included from include/linux/blk-mq.h:5,
                    from drivers/md/dm-core.h:15,
                    from drivers/md/dm.c:9:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
   In file included from drivers/md/dm.h:14,
                    from drivers/md/dm-core.h:21:
>> include/linux/device-mapper.h:571:54: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
     571 | int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |                                                      ^~~~~~~~~~~
   include/linux/device-mapper.h:572:54: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
     572 | int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |                                                      ^~~~~~~~~~~
   drivers/md/dm.c: In function 'dm_blk_getgeo':
>> drivers/md/dm.c:410:36: error: passing argument 2 of 'dm_get_geometry' from incompatible pointer type [-Wincompatible-pointer-types]
     410 |         return dm_get_geometry(md, geo);
         |                                    ^~~
         |                                    |
         |                                    struct hd_geometry *
   include/linux/device-mapper.h:571:67: note: expected 'struct hd_geometry *' but argument is of type 'struct hd_geometry *'
     571 | int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |                                               ~~~~~~~~~~~~~~~~~~~~^~~
   drivers/md/dm.c: At top level:
>> drivers/md/dm.c:839:5: error: conflicting types for 'dm_get_geometry'; have 'int(struct mapped_device *, struct hd_geometry *)'
     839 | int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo)
         |     ^~~~~~~~~~~~~~~
   include/linux/device-mapper.h:571:5: note: previous declaration of 'dm_get_geometry' with type 'int(struct mapped_device *, struct hd_geometry *)'
     571 | int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |     ^~~~~~~~~~~~~~~
>> drivers/md/dm.c:849:5: error: conflicting types for 'dm_set_geometry'; have 'int(struct mapped_device *, struct hd_geometry *)'
     849 | int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo)
         |     ^~~~~~~~~~~~~~~
   include/linux/device-mapper.h:572:5: note: previous declaration of 'dm_set_geometry' with type 'int(struct mapped_device *, struct hd_geometry *)'
     572 | int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |     ^~~~~~~~~~~~~~~
>> drivers/md/dm.c:3784:19: error: initialization of 'int (*)(struct gendisk *, struct hd_geometry *)' from incompatible pointer type 'int (*)(struct gendisk *, struct hd_geometry *)' [-Wincompatible-pointer-types]
    3784 |         .getgeo = dm_blk_getgeo,
         |                   ^~~~~~~~~~~~~
   drivers/md/dm.c:3784:19: note: (near initialization for 'dm_blk_dops.getgeo')
   drivers/md/dm.c:3795:19: error: initialization of 'int (*)(struct gendisk *, struct hd_geometry *)' from incompatible pointer type 'int (*)(struct gendisk *, struct hd_geometry *)' [-Wincompatible-pointer-types]
    3795 |         .getgeo = dm_blk_getgeo,
         |                   ^~~~~~~~~~~~~
   drivers/md/dm.c:3795:19: note: (near initialization for 'dm_rq_blk_dops.getgeo')
--
   In file included from include/linux/blk-mq.h:5,
                    from drivers/md/dm-core.h:15,
                    from drivers/md/dm-ioctl.c:9:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
   In file included from drivers/md/dm.h:14,
                    from drivers/md/dm-core.h:21:
>> include/linux/device-mapper.h:571:54: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
     571 | int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |                                                      ^~~~~~~~~~~
   include/linux/device-mapper.h:572:54: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
     572 | int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |                                                      ^~~~~~~~~~~
   drivers/md/dm-ioctl.c: In function 'dev_set_geometry':
>> drivers/md/dm-ioctl.c:1111:33: error: passing argument 2 of 'dm_set_geometry' from incompatible pointer type [-Wincompatible-pointer-types]
    1111 |         r = dm_set_geometry(md, &geometry);
         |                                 ^~~~~~~~~
         |                                 |
         |                                 struct hd_geometry *
   include/linux/device-mapper.h:572:67: note: expected 'struct hd_geometry *' but argument is of type 'struct hd_geometry *'
     572 | int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo);
         |                                               ~~~~~~~~~~~~~~~~~~~~^~~
--
   In file included from drivers/nvdimm/btt.c:8:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
>> drivers/nvdimm/btt.c:1493:33: error: initialization of 'int (*)(struct gendisk *, struct hd_geometry *)' from incompatible pointer type 'int (*)(struct gendisk *, struct hd_geometry *)' [-Wincompatible-pointer-types]
    1493 |         .getgeo =               btt_getgeo,
         |                                 ^~~~~~~~~~
   drivers/nvdimm/btt.c:1493:33: note: (near initialization for 'btt_fops.getgeo')
--
   In file included from include/linux/blk-mq.h:5,
                    from drivers/memstick/core/mspro_block.c:11:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
>> drivers/memstick/core/mspro_block.c:206:27: error: initialization of 'int (*)(struct gendisk *, struct hd_geometry *)' from incompatible pointer type 'int (*)(struct gendisk *, struct hd_geometry *)' [-Wincompatible-pointer-types]
     206 |         .getgeo         = mspro_block_bd_getgeo,
         |                           ^~~~~~~~~~~~~~~~~~~~~
   drivers/memstick/core/mspro_block.c:206:27: note: (near initialization for 'ms_block_bdops.getgeo')
--
   In file included from drivers/nvme/host/core.c:8:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
>> drivers/nvme/host/core.c:2616:27: error: initialization of 'int (*)(struct gendisk *, struct hd_geometry *)' from incompatible pointer type 'int (*)(struct gendisk *, struct hd_geometry *)' [-Wincompatible-pointer-types]
    2616 |         .getgeo         = nvme_getgeo,
         |                           ^~~~~~~~~~~
   drivers/nvme/host/core.c:2616:27: note: (near initialization for 'nvme_bdev_ops.getgeo')
--
   In file included from include/linux/blk-mq.h:5,
                    from include/linux/blk-integrity.h:5,
                    from drivers/nvme/host/ioctl.c:6:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
   In file included from drivers/nvme/host/ioctl.c:10:
>> drivers/nvme/host/nvme.h:946:46: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
     946 | int nvme_getgeo(struct gendisk *disk, struct hd_geometry *geo);
         |                                              ^~~~~~~~~~~
--
   In file included from include/linux/blk-mq.h:5,
                    from include/linux/blktrace_api.h:5,
                    from include/trace/events/block.h:8,
                    from drivers/nvme/host/multipath.c:9:
>> include/linux/blkdev.h:1656:48: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^~~~~~~~~~~
   In file included from drivers/nvme/host/multipath.c:10:
>> drivers/nvme/host/nvme.h:946:46: warning: 'struct hd_geometry' declared inside parameter list will not be visible outside of this definition or declaration
     946 | int nvme_getgeo(struct gendisk *disk, struct hd_geometry *geo);
         |                                              ^~~~~~~~~~~
>> drivers/nvme/host/multipath.c:603:27: error: initialization of 'int (*)(struct gendisk *, struct hd_geometry *)' from incompatible pointer type 'int (*)(struct gendisk *, struct hd_geometry *)' [-Wincompatible-pointer-types]
     603 |         .getgeo         = nvme_getgeo,
         |                           ^~~~~~~~~~~
   drivers/nvme/host/multipath.c:603:27: note: (near initialization for 'nvme_ns_head_ops.getgeo')
..


vim +8421 drivers/md/md.c

e8c59ac4197443 Christoph Hellwig 2022-07-19  8410  
7e0adbfc20c50b Christoph Hellwig 2020-06-07  8411  const struct block_device_operations md_fops =
^1da177e4c3f41 Linus Torvalds    2005-04-16  8412  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  8413  	.owner		= THIS_MODULE,
c62b37d96b6eb3 Christoph Hellwig 2020-07-01  8414  	.submit_bio	= md_submit_bio,
a39907fa2fdb73 Al Viro           2008-03-02  8415  	.open		= md_open,
a39907fa2fdb73 Al Viro           2008-03-02  8416  	.release	= md_release,
b492b852cd8c99 NeilBrown         2009-05-26  8417  	.ioctl		= md_ioctl,
aa98aa31987ad9 Arnd Bergmann     2009-12-14  8418  #ifdef CONFIG_COMPAT
aa98aa31987ad9 Arnd Bergmann     2009-12-14  8419  	.compat_ioctl	= md_compat_ioctl,
aa98aa31987ad9 Arnd Bergmann     2009-12-14  8420  #endif
a885c8c4316e1c Christoph Hellwig 2006-01-08 @8421  	.getgeo		= md_getgeo,
a564e23f0f9975 Christoph Hellwig 2020-07-08  8422  	.check_events	= md_check_events,
118cf084adb396 Christoph Hellwig 2020-11-03  8423  	.set_read_only	= md_set_read_only,
e8c59ac4197443 Christoph Hellwig 2022-07-19  8424  	.free_disk	= md_free_disk,
^1da177e4c3f41 Linus Torvalds    2005-04-16  8425  };
^1da177e4c3f41 Linus Torvalds    2005-04-16  8426  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


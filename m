Return-Path: <linux-fsdevel+bounces-16534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F589EEAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81FFB232BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DD6156885;
	Wed, 10 Apr 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CS1mlwJY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8E15573B
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740790; cv=none; b=D1AmKLntREeyLDybaVcD5X7KirY6zaXPTBVwo3Ec8I8QVXZizo+Hrl3qeHSBcttu7p9RiA8uNUzQdOVOUqCl7XJoU0RAk7mTNcEOR66kRy8tcz2NNZxA+wksNQQO78r5+Y8T+eUsnm7lvMQVxvmIWAL53fjdacWQ20dqwXKkRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740790; c=relaxed/simple;
	bh=opEHOJQennBg2n6ESefu4UyWnIHbNMCaI+CVW0QFi3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMLVQX6j6uDXIRenK0QrmnxwZDcH7DLPIfK87iuxaXmg1ndcZCgzz/e7zb0exQcXm4K8iB21wLnoaKGCPHWRvjuTPyLxu+2FEqkkLCd0RqDOZU9RQwiWEoHDMOLgUBPFYaBcsAcfXAHRf9DMIsmVmqbwHr2sZP1Cq3UWm5AKMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CS1mlwJY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712740788; x=1744276788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=opEHOJQennBg2n6ESefu4UyWnIHbNMCaI+CVW0QFi3U=;
  b=CS1mlwJYx5j2C4rjK7Sis5birTCljpStucmg4X7T7JyF2YK+18iXbyz3
   hp4ENY8y+hLpi9CyjXONwjAdnacrnSWGaiE/ory2ffMDH2Ug+RSLq1XAx
   PIZBqi2ycBjk4DYRNAW2sa+Nc8oXDtBBFh7ISJTVXHAYPAirkcxb+beqZ
   kjqCz4O49W5qUV2OOu1IZHqFULHpaADs/D+mnanEFMe6Jdip5ShspW5Mc
   GujGD+RyTJbKaEu2XHqafA98LJO5ijb6tnnmpM34QasUlvVnSWNGD6sfW
   Hc3j40rpo4Q1dbJeaTAXQnmICR1zIDBZZcey4oy8HZrsp+Fuy06XBB4+C
   Q==;
X-CSE-ConnectionGUID: UUodwFExSb6y4lkTA7yxIA==
X-CSE-MsgGUID: fGyvTEfGQOOv7wjGOjzLww==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19479680"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19479680"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 02:19:34 -0700
X-CSE-ConnectionGUID: RWpPj5yWTlG4h6xjC7cSxQ==
X-CSE-MsgGUID: JMx5S2VOS1KjzaPHU6KUYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57937858"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Apr 2024 02:19:32 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruU77-00079y-1z;
	Wed, 10 Apr 2024 09:19:29 +0000
Date: Wed, 10 Apr 2024 17:18:57 +0800
From: kernel test robot <lkp@intel.com>
To: John Groves <John@groves.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Groves <John@groves.net>,
	john@jagalactic.com
Subject: Re: [PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored
 via stack address
Message-ID: <202404101632.62NM3BlE-lkp@intel.com>
References: <7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fec50db7033ea478773b159e0e2efb135270e3b7]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Groves/sget_dev-bug-fix-dev_t-passed-by-value-but-stored-via-stack-address/20240410-073305
base:   fec50db7033ea478773b159e0e2efb135270e3b7
patch link:    https://lore.kernel.org/r/7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john%40groves.net
patch subject: [PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored via stack address
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240410/202404101632.62NM3BlE-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404101632.62NM3BlE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404101632.62NM3BlE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/super.c: In function 'set_bdev_super':
>> fs/super.c:1311:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1311 |         u64 devno = (u64)data;
         |                     ^
   fs/super.c: In function 'super_s_dev_test':
   fs/super.c:1324:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1324 |         u64 devno = (u64)fc->sget_key;
         |                     ^
   fs/super.c: In function 'sget_dev':
>> fs/super.c:1354:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1354 |         fc->sget_key = (void *)devno;
         |                        ^
   fs/super.c: In function 'mount_bdev':
   fs/super.c:1654:67: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1654 |         s = sget(fs_type, test_bdev_super, set_bdev_super, flags, (void *)devno);
         |                                                                   ^


vim +1311 fs/super.c

  1308	
  1309	static int set_bdev_super(struct super_block *s, void *data)
  1310	{
> 1311		u64 devno = (u64)data;
  1312	
  1313		s->s_dev = (dev_t)devno;
  1314		return 0;
  1315	}
  1316	
  1317	static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
  1318	{
  1319		return set_bdev_super(s, fc->sget_key);
  1320	}
  1321	
  1322	static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
  1323	{
  1324		u64 devno = (u64)fc->sget_key;
  1325	
  1326		return !(s->s_iflags & SB_I_RETIRED) &&
  1327			s->s_dev == (dev_t)devno;
  1328	}
  1329	
  1330	/**
  1331	 * sget_dev - Find or create a superblock by device number
  1332	 * @fc: Filesystem context.
  1333	 * @dev: device number
  1334	 *
  1335	 * Find or create a superblock using the provided device number that
  1336	 * will be stored in fc->sget_key.
  1337	 *
  1338	 * If an extant superblock is matched, then that will be returned with
  1339	 * an elevated reference count that the caller must transfer or discard.
  1340	 *
  1341	 * If no match is made, a new superblock will be allocated and basic
  1342	 * initialisation will be performed (s_type, s_fs_info, s_id, s_dev will
  1343	 * be set). The superblock will be published and it will be returned in
  1344	 * a partially constructed state with SB_BORN and SB_ACTIVE as yet
  1345	 * unset.
  1346	 *
  1347	 * Return: an existing or newly created superblock on success, an error
  1348	 *         pointer on failure.
  1349	 */
  1350	struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
  1351	{
  1352		u64 devno = (u64)dev;
  1353	
> 1354		fc->sget_key = (void *)devno;
  1355		return sget_fc(fc, super_s_dev_test, super_s_dev_set);
  1356	}
  1357	EXPORT_SYMBOL(sget_dev);
  1358	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


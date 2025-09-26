Return-Path: <linux-fsdevel+bounces-62904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D8BA48B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 18:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A941B26EE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C7233149;
	Fri, 26 Sep 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpTvJD6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A018287E
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902704; cv=none; b=tkNrPBSbXxulJngSbg5zWk9iR+YkAuxCMZ9T6FARgdXrxqzs5OlyuBb9vG/1fbHEvump3gNBPc0mrQRVdCKZRfRywPDfXg634EyYfze0lMcFoHP8xXMqPlxWxCih9DyykI7VxldXNiXxMAiZZv4QHzxre9DJb1V5oQQHLhjYw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902704; c=relaxed/simple;
	bh=wUGJE+ti/MRdA0xp+XI2NHmw0de32U8bLNCQZPLQAFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E98/0yQnVi5BRD1eQKBiVMunE/i4zjodI2FTOttRL9/6UgWnpxMfXakynGGcBJQFAUvwBX0q5N4wHQ6xMAXb+kR8Bv2WA0irE3DXL5XRRyAVmJPjxVkejnH9KsvMblCPZYni2AkzRHCUl//HpJfMxcB3tkt8IIhyIMU04vew6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpTvJD6k; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758902703; x=1790438703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wUGJE+ti/MRdA0xp+XI2NHmw0de32U8bLNCQZPLQAFE=;
  b=UpTvJD6kbb4Vwbw2sdFONbAMDIu9OjnLG9VBCcyoxqtQ/dwu4v7Z+4CT
   H4Z86T2KJCLvAotOMaQ3jKLyo8p/xBqPakU6hmUQho1DXzYCkpAfvXudX
   g+ThFAr8EnEwnB36QM4K7AMw3A3L5Or8iv2O8PFpp3qrChRZGn/BZrsTf
   ofahaszXU19AyCsEvE+DQ/XyIztKzTXBEDMZkpy5BKRbeSF9WbeaS70Qe
   31NUBoQsS7biEWzTxRvtbcjOBJhZmk1r4y2HKvMp4i9VMnU+PzJSB0wjm
   0bj8wbLRleGARYOa6hlYPjr1WYq285++xQ2ngwvgjull9ZWb3WLJRNSYn
   w==;
X-CSE-ConnectionGUID: kyu4lADiTRCFk7UaPbW60A==
X-CSE-MsgGUID: x41J9Q0sQFa3xbc6aEOv6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="83850156"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="83850156"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 09:05:02 -0700
X-CSE-ConnectionGUID: CndS3x/QQduuWq+XClxM8A==
X-CSE-MsgGUID: bjQGFKfXRwiA8SLER519ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="208393799"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 26 Sep 2025 09:05:00 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2AwG-0006OZ-1s;
	Fri, 26 Sep 2025 16:04:54 +0000
Date: Sat, 27 Sep 2025 00:03:58 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@ownmail.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs
Message-ID: <202509262333.TsoLDUkJ-lkp@intel.com>
References: <20250926025015.1747294-12-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926025015.1747294-12-neilb@ownmail.net>

Hi NeilBrown,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on next-20250925]
[cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus viro-vfs/for-next linus/master v6.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/debugfs-rename-end_creating-to-debugfs_end_creating/20250926-105302
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250926025015.1747294-12-neilb%40ownmail.net
patch subject: [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs
config: x86_64-buildonly-randconfig-003-20250926 (https://download.01.org/0day-ci/archive/20250926/202509262333.TsoLDUkJ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509262333.TsoLDUkJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509262333.TsoLDUkJ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   Warning: fs/namei.c:2815 function parameter 'de' not described in 'end_dirop'
   Warning: fs/namei.c:2836 function parameter 'de' not described in 'end_dirop_mkdir'
   Warning: fs/namei.c:2836 function parameter 'parent' not described in 'end_dirop_mkdir'
   Warning: fs/namei.c:3276 function parameter 'idmap' not described in 'start_creating'
   Warning: fs/namei.c:3276 function parameter 'parent' not described in 'start_creating'
   Warning: fs/namei.c:3276 function parameter 'name' not described in 'start_creating'
   Warning: fs/namei.c:3303 function parameter 'idmap' not described in 'start_removing'
   Warning: fs/namei.c:3303 function parameter 'parent' not described in 'start_removing'
   Warning: fs/namei.c:3303 function parameter 'name' not described in 'start_removing'
   Warning: fs/namei.c:3332 function parameter 'idmap' not described in 'start_creating_killable'
   Warning: fs/namei.c:3332 function parameter 'parent' not described in 'start_creating_killable'
   Warning: fs/namei.c:3332 function parameter 'name' not described in 'start_creating_killable'
   Warning: fs/namei.c:3363 function parameter 'idmap' not described in 'start_removing_killable'
   Warning: fs/namei.c:3363 function parameter 'parent' not described in 'start_removing_killable'
   Warning: fs/namei.c:3363 function parameter 'name' not described in 'start_removing_killable'
   Warning: fs/namei.c:3386 function parameter 'parent' not described in 'start_creating_noperm'
   Warning: fs/namei.c:3386 function parameter 'name' not described in 'start_creating_noperm'
   Warning: fs/namei.c:3411 function parameter 'parent' not described in 'start_removing_noperm'
   Warning: fs/namei.c:3411 function parameter 'name' not described in 'start_removing_noperm'
>> Warning: fs/namei.c:3437 function parameter 'parent' not described in 'start_creating_dentry'
>> Warning: fs/namei.c:3437 function parameter 'child' not described in 'start_creating_dentry'
   Warning: fs/namei.c:3470 function parameter 'parent' not described in 'start_removing_dentry'
   Warning: fs/namei.c:3470 function parameter 'child' not described in 'start_removing_dentry'
--
   fs/ecryptfs/inode.c: In function 'ecryptfs_rename':
>> fs/ecryptfs/inode.c:630:14: error: implicit declaration of function 'start_renaming_two_dentry'; did you mean 'start_renaming_two_dentrys'? [-Wimplicit-function-declaration]
     630 |         rc = start_renaming_two_dentry(&rd, lower_old_dentry, lower_new_dentry);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~
         |              start_renaming_two_dentrys


vim +630 fs/ecryptfs/inode.c

   602	
   603	static int
   604	ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
   605			struct dentry *old_dentry, struct inode *new_dir,
   606			struct dentry *new_dentry, unsigned int flags)
   607	{
   608		int rc;
   609		struct dentry *lower_old_dentry;
   610		struct dentry *lower_new_dentry;
   611		struct dentry *lower_old_dir_dentry;
   612		struct dentry *lower_new_dir_dentry;
   613		struct inode *target_inode;
   614		struct renamedata rd = {};
   615	
   616		if (flags)
   617			return -EINVAL;
   618	
   619		lower_old_dir_dentry = ecryptfs_dentry_to_lower(old_dentry->d_parent);
   620		lower_new_dir_dentry = ecryptfs_dentry_to_lower(new_dentry->d_parent);
   621	
   622		lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
   623		lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
   624	
   625		target_inode = d_inode(new_dentry);
   626	
   627		rd.mnt_idmap  = &nop_mnt_idmap;
   628		rd.old_parent = lower_old_dir_dentry;
   629		rd.new_parent = lower_new_dir_dentry;
 > 630		rc = start_renaming_two_dentry(&rd, lower_old_dentry, lower_new_dentry);
   631		if (rc)
   632			return rc;
   633	
   634		rc = vfs_rename(&rd);
   635		if (rc)
   636			goto out_lock;
   637		if (target_inode)
   638			fsstack_copy_attr_all(target_inode,
   639					      ecryptfs_inode_to_lower(target_inode));
   640		fsstack_copy_attr_all(new_dir, d_inode(lower_new_dir_dentry));
   641		if (new_dir != old_dir)
   642			fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dentry));
   643	out_lock:
   644		end_renaming(&rd);
   645		return rc;
   646	}
   647	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


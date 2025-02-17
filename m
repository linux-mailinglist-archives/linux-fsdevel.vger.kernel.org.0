Return-Path: <linux-fsdevel+bounces-41865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91001A388BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075CC178653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A868B225A34;
	Mon, 17 Feb 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiMXywYq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01074225A20;
	Mon, 17 Feb 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807942; cv=none; b=ftE/XeVuebLzzYzC7SMLfcsn1HS9r1RgHbgAjYPYM/kZhCzlnGybGeXIIcYJi6e28U5G6GoNzu4hzm5XCDjgwGixr7vSw5OSA+qxSrTEhMn145zoggGu5MLaibzYLdKCM6xcXpJwSF5wa7Gb4fgmVu4HyCoU+7OWrBMryvoqsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807942; c=relaxed/simple;
	bh=jDV83z/r74TiljhPheEnQ5RAJnBmf54S+/B/rxRetTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7tkEp87UFnsbccFAdb87AVyrxadH2Q6f1+YXu3+meEIMJvvwTWsMgo71SPnaYanK2EqypYAYjDRR+pw/2fOIw/r3VMIudb/HwvIfieCt4KPFlpntohTWouXS8HcRRLvLOZWJZFrU37DienRL3FXu1bYw5MN0TD9eqKS6wTMF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiMXywYq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739807940; x=1771343940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jDV83z/r74TiljhPheEnQ5RAJnBmf54S+/B/rxRetTA=;
  b=iiMXywYqY+jHxNjTg/r49ZJ6B7ThQFuozRfMK9CMY+hJBqY4ay3XUmcP
   bpF4J0HMAu1OvGfZQNYG6rnJNlrhIxDAOk/27Snf2ljgUxyCVm+G5XJZw
   ciGbxvvneuEIEFJJEwWpsvAvewbK+9P38B372SV7z/mDlLOVlLld1/4g7
   En/h9sDde201HK6KHgFxPHIvfzaV0ZnNx7rJEB9vO2LKwceyT4/SaPiwf
   qlMKw05K49nzn8Dq8lxZTgJt6rZ3fvJehQMh3q1GZdjCKmUMZ0xB2p3ix
   yLqdyzkJ+ENm+IktnXOi9b70+tPcaO0YTFxUbXM68gy4YLuTCOSOdIZvC
   w==;
X-CSE-ConnectionGUID: G9PWxie1QBy4/FEQs02ljw==
X-CSE-MsgGUID: u3b6v9m5R7e/NrLeUZGVWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51902113"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="51902113"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 07:58:57 -0800
X-CSE-ConnectionGUID: OMcK6skFQFyQN8of5wZ6sw==
X-CSE-MsgGUID: 7r8HL4v0SAGlPMiaYG6bbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119078576"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Feb 2025 07:58:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tk3WG-001DJ9-1W;
	Mon, 17 Feb 2025 15:58:52 +0000
Date: Mon, 17 Feb 2025 23:58:24 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <202502172326.hdZnGqWS-lkp@intel.com>
References: <20250214052204.3105610-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214052204.3105610-2-neilb@suse.de>

Hi NeilBrown,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on trondmy-nfs/linux-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus cifs/for-next xfs-linux/for-next linus/master v6.14-rc3 next-20250217]
[cannot apply to ericvh-v9fs/for-next tyhicks-ecryptfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfs-change-mkdir-inode_operation-to-return-alternate-dentry-if-needed/20250214-141741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250214052204.3105610-2-neilb%40suse.de
patch subject: [PATCH 1/3] Change inode_operations.mkdir to return struct dentry *
config: um-randconfig-r122-20250217 (https://download.01.org/0day-ci/archive/20250217/202502172326.hdZnGqWS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250217/202502172326.hdZnGqWS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502172326.hdZnGqWS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/hostfs/hostfs_kern.c:689:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected struct dentry * @@     got int @@
   fs/hostfs/hostfs_kern.c:689:24: sparse:     expected struct dentry *
   fs/hostfs/hostfs_kern.c:689:24: sparse:     got int

vim +689 fs/hostfs/hostfs_kern.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  681  
456289e0bd14ce NeilBrown         2025-02-14  682  static struct dentry *hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
549c7297717c32 Christian Brauner 2021-01-21  683  				   struct dentry *dentry, umode_t mode)
^1da177e4c3f41 Linus Torvalds    2005-04-16  684  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  685  	char *file;
^1da177e4c3f41 Linus Torvalds    2005-04-16  686  	int err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  687  
c5322220eb91b9 Al Viro           2010-06-06  688  	if ((file = dentry_name(dentry)) == NULL)
f1adc05e773830 Jeff Dike         2007-05-08 @689  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  690  	err = do_mkdir(file, mode);
e9193059b1b373 Al Viro           2010-06-06  691  	__putname(file);
456289e0bd14ce NeilBrown         2025-02-14  692  	if (err)
456289e0bd14ce NeilBrown         2025-02-14  693  		return ERR_PTR(err);
456289e0bd14ce NeilBrown         2025-02-14  694  	else
456289e0bd14ce NeilBrown         2025-02-14  695  		return dentry;
^1da177e4c3f41 Linus Torvalds    2005-04-16  696  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  697  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


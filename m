Return-Path: <linux-fsdevel+bounces-30962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F699901AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101DF282931
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73913156C5E;
	Fri,  4 Oct 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTvF3lbH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB2146D65;
	Fri,  4 Oct 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039378; cv=none; b=kDAyyxlTFSUEPKiki0k6uijGPtI5j6Xat/L2CqM5L+9tJMTn4s6IHxHx0wg27DtPpRRjqLxug76zjofvHcfNej67K0rzNIwCnJ2iD+LjcIf4QHCTPBZkkkWYtwLPKrd1PVEKgPloe2Yc+1H7Io+d78Hg7eTVlmTBGJ4kAn9n9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039378; c=relaxed/simple;
	bh=AYq+Depz6SZzgWi309iNgbm1eMigTRimnQb8POgFbds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSVqoVchTwnUilFr6V54zW5Je7ubFCgvd2idRrrWgvEVmjE+bl58Ke7jRSX67uKY0+p2Niip1kORJyLcbcU+N+QBeuzcA3TnpawA8RkGbeEfU2gYyLLVXRhkfoNJCXkLTcDcX5KRAhiyQes5GjmuWGQde4vMOW9TOD8S/P3t0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTvF3lbH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728039377; x=1759575377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AYq+Depz6SZzgWi309iNgbm1eMigTRimnQb8POgFbds=;
  b=VTvF3lbH70hfCk7xnxPdrKADNoD5GehKbAxzJ6QA48xstAOxH3MBg2G7
   1REL4xwsLKlAiLc4jTMiBRSiMRgXEIP774gLWqW8tmyYMYUnUYXYZ4b/M
   zuZEYIXV7Oy2bJ6FHhXxidfrWqJZWYO8zzJswFnGz65gbdxdoMLU87OSu
   ivgrdx7avCk8EXWOYNC7M1XhY0MT3mjac/Hgvn07Ju7UvKjmdNHznLsFZ
   +J5O0ChzYu5LUs8cf7DeMBzIdcRSXZtvALTMLbfICXVenzUEYfKU3mbsU
   7OVmaSUTDvgQmZRCdWQi9jwgAlaycsQrKVVD8+JEQTnh1QIpYrS6A2eGR
   A==;
X-CSE-ConnectionGUID: MyuqwGzwTB2KrZLYFibz+Q==
X-CSE-MsgGUID: piG7NdRVRw2MOigJJqVY2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27392549"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27392549"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 03:56:16 -0700
X-CSE-ConnectionGUID: 1s6oyzRRRUyGPVMEB7cNdg==
X-CSE-MsgGUID: vr8Wd7JVRDGF8l/R/hoZIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74500301"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Oct 2024 03:56:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swfyl-0001X3-2c;
	Fri, 04 Oct 2024 10:56:11 +0000
Date: Fri, 4 Oct 2024 18:55:30 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 3/7] vfs: convert vfs inode iterators to
 super_iter_inodes_unsafe()
Message-ID: <202410041848.j3wt7yFP-lkp@intel.com>
References: <20241002014017.3801899-4-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-4-david@fromorbit.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on xfs-linux/for-next axboe-block/for-next linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/vfs-replace-invalidate_inodes-with-evict_inodes/20241002-094254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241002014017.3801899-4-david%40fromorbit.com
patch subject: [PATCH 3/7] vfs: convert vfs inode iterators to super_iter_inodes_unsafe()
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20241004/202410041848.j3wt7yFP-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410041848.j3wt7yFP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410041848.j3wt7yFP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/inode.c:874: warning: Function parameter or struct member 'inode' not described in 'evict_inode_fn'
>> fs/inode.c:874: warning: Function parameter or struct member 'data' not described in 'evict_inode_fn'
>> fs/inode.c:874: warning: expecting prototype for evict_inodes(). Prototype was for evict_inode_fn() instead


vim +874 fs/inode.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  863  
63997e98a3be68 Al Viro        2010-10-25  864  /**
63997e98a3be68 Al Viro        2010-10-25  865   * evict_inodes	- evict all evictable inodes for a superblock
63997e98a3be68 Al Viro        2010-10-25  866   * @sb:		superblock to operate on
63997e98a3be68 Al Viro        2010-10-25  867   *
63997e98a3be68 Al Viro        2010-10-25  868   * Make sure that no inodes with zero refcount are retained.  This is
1751e8a6cb935e Linus Torvalds 2017-11-27  869   * called by superblock shutdown after having SB_ACTIVE flag removed,
63997e98a3be68 Al Viro        2010-10-25  870   * so any inode reaching zero refcount during or after that call will
63997e98a3be68 Al Viro        2010-10-25  871   * be immediately evicted.
^1da177e4c3f41 Linus Torvalds 2005-04-16  872   */
f3df82b20474b6 Dave Chinner   2024-10-02  873  static int evict_inode_fn(struct inode *inode, void *data)
^1da177e4c3f41 Linus Torvalds 2005-04-16 @874  {
f3df82b20474b6 Dave Chinner   2024-10-02  875  	struct list_head *dispose = data;
250df6ed274d76 Dave Chinner   2011-03-22  876  
250df6ed274d76 Dave Chinner   2011-03-22  877  	spin_lock(&inode->i_lock);
f3df82b20474b6 Dave Chinner   2024-10-02  878  	if (atomic_read(&inode->i_count) ||
f3df82b20474b6 Dave Chinner   2024-10-02  879  	    (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))) {
250df6ed274d76 Dave Chinner   2011-03-22  880  		spin_unlock(&inode->i_lock);
f3df82b20474b6 Dave Chinner   2024-10-02  881  		return INO_ITER_DONE;
250df6ed274d76 Dave Chinner   2011-03-22  882  	}
63997e98a3be68 Al Viro        2010-10-25  883  
63997e98a3be68 Al Viro        2010-10-25  884  	inode->i_state |= I_FREEING;
02afc410f363f9 Dave Chinner   2011-03-22  885  	inode_lru_list_del(inode);
250df6ed274d76 Dave Chinner   2011-03-22  886  	spin_unlock(&inode->i_lock);
f3df82b20474b6 Dave Chinner   2024-10-02  887  	list_add(&inode->i_lru, dispose);
ac05fbb4006241 Josef Bacik    2015-03-04  888  
ac05fbb4006241 Josef Bacik    2015-03-04  889  	/*
f3df82b20474b6 Dave Chinner   2024-10-02  890  	 * If we've run long enough to need rescheduling, abort the
f3df82b20474b6 Dave Chinner   2024-10-02  891  	 * iteration so we can return to evict_inodes() and dispose of the
f3df82b20474b6 Dave Chinner   2024-10-02  892  	 * inodes before collecting more inodes to evict.
ac05fbb4006241 Josef Bacik    2015-03-04  893  	 */
f3df82b20474b6 Dave Chinner   2024-10-02  894  	if (need_resched())
f3df82b20474b6 Dave Chinner   2024-10-02  895  		return INO_ITER_ABORT;
f3df82b20474b6 Dave Chinner   2024-10-02  896  	return INO_ITER_DONE;
ac05fbb4006241 Josef Bacik    2015-03-04  897  }
63997e98a3be68 Al Viro        2010-10-25  898  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


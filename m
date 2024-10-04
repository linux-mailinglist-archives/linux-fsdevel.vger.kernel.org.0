Return-Path: <linux-fsdevel+bounces-30953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50040990055
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13911F248D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18117148FF2;
	Fri,  4 Oct 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfaZTAg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C3140E50;
	Fri,  4 Oct 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035656; cv=none; b=JfRfTKbj480jeC8SmfNQd+yOBs1LioU9Yb2wozEMgK4X9sSnTcUFISSylmPRQdr5kuhnbER6vIldAENLDcSkiGZO8ri2YJNcMnXZYzSmeEFhU8yta8VzRRBoQztLJ5vjvhSYg8c69vRKXgTt5oPO42cu4TJgeYn4bTvz9qHJRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035656; c=relaxed/simple;
	bh=No1Zczym9zA0U6AM4Yjp5S/GQIC28WW4I8Vm9nagyu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKz7AHKQ/FQptmTfItMKYFR83Pe40DLr9wB2/j+n094MOysZfnhisi0gTppSry8nNXQtGWuNEEJL//en6IPepOowLuNGbOnTMths2cy3fjM9s27morswAR4gcC9gpMnNTylf9RX6bPA8GNQwOcXogmXaj0fQkFdCq0HpkhOKkIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfaZTAg0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728035654; x=1759571654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=No1Zczym9zA0U6AM4Yjp5S/GQIC28WW4I8Vm9nagyu4=;
  b=PfaZTAg0vSIy0ahotVo3UXtTfsSGbOXPd1uEslgcoPqJGfIqDIBZp1XW
   ip9new+kYKDRoZuCB5Q8jNegxbCcbp0tKsqnx+eK23ldRleu84KtdSywD
   ZEJEZh0Xwll+5ny2nCMjxjRyOeV5zw3b1Gykcisqae/wrlHJQGY9Jmb57
   atf2G15i1aBRsGCxLpsbcmqQnBlZVuXcWqD2znGL3FVQHVYHXIf1HvUCt
   3pXQk8IafW94sS2EAjwhfLxnDNoirG2rjl2df278SZUidahbim2qlmDuc
   GnlcXwGxWYD9ysMR7E5dOol1K9piLfasS401/bW901YWJ0xoPKZjdvvpX
   A==;
X-CSE-ConnectionGUID: SVKyQ/zGTpKXrdkSaGdsUg==
X-CSE-MsgGUID: gXvyGQb3RbyABxd79AOXaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="44719853"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="44719853"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:54:13 -0700
X-CSE-ConnectionGUID: KAiSxmwPSmyNaOWcpdDlMw==
X-CSE-MsgGUID: Fiw1YLBmTsqRkSqmTltRbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="79420510"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Oct 2024 02:54:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swf0j-0001RK-0I;
	Fri, 04 Oct 2024 09:54:09 +0000
Date: Fri, 4 Oct 2024 17:53:56 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 2/7] vfs: add inode iteration superblock method
Message-ID: <202410041724.REiCiIEQ-lkp@intel.com>
References: <20241002014017.3801899-3-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-3-david@fromorbit.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on xfs-linux/for-next axboe-block/for-next linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/vfs-replace-invalidate_inodes-with-evict_inodes/20241002-094254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241002014017.3801899-3-david%40fromorbit.com
patch subject: [PATCH 2/7] vfs: add inode iteration superblock method
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20241004/202410041724.REiCiIEQ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410041724.REiCiIEQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410041724.REiCiIEQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/super.c:183: warning: Function parameter or struct member 'private_data' not described in 'super_iter_inodes'
>> fs/super.c:183: warning: Function parameter or struct member 'flags' not described in 'super_iter_inodes'
>> fs/super.c:241: warning: bad line: 
>> fs/super.c:260: warning: Function parameter or struct member 'private_data' not described in 'super_iter_inodes_unsafe'


vim +183 fs/super.c

   169	
   170	/**
   171	 * super_iter_inodes - iterate all the cached inodes on a superblock
   172	 * @sb: superblock to iterate
   173	 * @iter_fn: callback to run on every inode found.
   174	 *
   175	 * This function iterates all cached inodes on a superblock that are not in
   176	 * the process of being initialised or torn down. It will run @iter_fn() with
   177	 * a valid, referenced inode, so it is safe for the caller to do anything
   178	 * it wants with the inode except drop the reference the iterator holds.
   179	 *
   180	 */
   181	int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
   182			void *private_data, int flags)
 > 183	{
   184		struct inode *inode, *old_inode = NULL;
   185		int ret = 0;
   186	
   187		spin_lock(&sb->s_inode_list_lock);
   188		list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
   189			spin_lock(&inode->i_lock);
   190			if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
   191				spin_unlock(&inode->i_lock);
   192				continue;
   193			}
   194	
   195			/*
   196			 * Skip over zero refcount inode if the caller only wants
   197			 * referenced inodes to be iterated.
   198			 */
   199			if ((flags & INO_ITER_REFERENCED) &&
   200			    !atomic_read(&inode->i_count)) {
   201				spin_unlock(&inode->i_lock);
   202				continue;
   203			}
   204	
   205			__iget(inode);
   206			spin_unlock(&inode->i_lock);
   207			spin_unlock(&sb->s_inode_list_lock);
   208			iput(old_inode);
   209	
   210			ret = iter_fn(inode, private_data);
   211	
   212			old_inode = inode;
   213			if (ret == INO_ITER_ABORT) {
   214				ret = 0;
   215				break;
   216			}
   217			if (ret < 0)
   218				break;
   219	
   220			cond_resched();
   221			spin_lock(&sb->s_inode_list_lock);
   222		}
   223		spin_unlock(&sb->s_inode_list_lock);
   224		iput(old_inode);
   225		return ret;
   226	}
   227	
   228	/**
   229	 * super_iter_inodes_unsafe - unsafely iterate all the inodes on a superblock
   230	 * @sb: superblock to iterate
   231	 * @iter_fn: callback to run on every inode found.
   232	 *
   233	 * This is almost certainly not the function you want. It is for internal VFS
   234	 * operations only. Please use super_iter_inodes() instead. If you must use
   235	 * this function, please add a comment explaining why it is necessary and the
   236	 * locking that makes it safe to use this function.
   237	 *
   238	 * This function iterates all cached inodes on a superblock that are attached to
   239	 * the superblock. It will pass each inode to @iter_fn unlocked and without
   240	 * having performed any existences checks on it.
 > 241	
   242	 * @iter_fn must perform all necessary state checks on the inode itself to
   243	 * ensure safe operation. super_iter_inodes_unsafe() only guarantees that the
   244	 * inode exists and won't be freed whilst the callback is running.
   245	 *
   246	 * @iter_fn must not block. It is run in an atomic context that is not allowed
   247	 * to sleep to provide the inode existence guarantees. If the callback needs to
   248	 * do blocking operations it needs to track the inode itself and defer those
   249	 * operations until after the iteration completes.
   250	 *
   251	 * @iter_fn must provide conditional reschedule checks itself. If rescheduling
   252	 * or deferred processing is needed, it must return INO_ITER_ABORT to return to
   253	 * the high level function to perform those operations. It can then restart the
   254	 * iteration again. The high level code must provide forwards progress
   255	 * guarantees if they are necessary.
   256	 *
   257	 */
   258	void super_iter_inodes_unsafe(struct super_block *sb, ino_iter_fn iter_fn,
   259			void *private_data)
 > 260	{
   261		struct inode *inode;
   262		int ret;
   263	
   264		rcu_read_lock();
   265		spin_lock(&sb->s_inode_list_lock);
   266		list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
   267			ret = iter_fn(inode, private_data);
   268			if (ret == INO_ITER_ABORT)
   269				break;
   270		}
   271		spin_unlock(&sb->s_inode_list_lock);
   272		rcu_read_unlock();
   273	}
   274	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


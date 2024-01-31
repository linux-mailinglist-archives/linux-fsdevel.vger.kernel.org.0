Return-Path: <linux-fsdevel+bounces-9611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5577E843466
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 04:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D848A1F255F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558C1101C5;
	Wed, 31 Jan 2024 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMB4GXxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228151079B;
	Wed, 31 Jan 2024 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670937; cv=none; b=inxw35jhz6otsq3t4M1Nk3GP+W3h07T/wLT6m8fgna4AHM5xFPL9U+gP2h0ExEjGy2wxLxkjTYYa9keYWbIAuQ1etoEt2YyZhrVzzrth7i+UYXoxztPC3YtdlcdCPb6j7sDX08dwFzODE4kxKZLRsP2HQGFgFvHwM+5OZuxjJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670937; c=relaxed/simple;
	bh=0RbtyAoevYTA/aBIg2R+WyxfDIR33+IIy7Yy2oDfsjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXj7Y+LVqT7n6C0LBNKhIEM7qemnIEx6hZX8YNFahz5XstWa1aifJJkjHSNM4DPDZl0O5QNIQm1zgNbQ6db9KVswRTptWseODo6RgDwwFHr7j3eoPcghTJCFLpeLphIYg909ThkZ+89Nq0UVnXkbZOkCtb5zX0rqZD4LDl7GDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMB4GXxO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706670936; x=1738206936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0RbtyAoevYTA/aBIg2R+WyxfDIR33+IIy7Yy2oDfsjk=;
  b=SMB4GXxOIWj0lebNvKBu3xOLiw+Gcq5mOwgscSq3IYjwmZ/lhe78uHZV
   qoOtBHSgiDQ63nGM5zVNJX+dRa1IV2lA2pNnpZuK5aZohUCPPdRZvL9ZQ
   swc8t6jylWHBvrq/D7+6jZJ+A92fbpk6Igec8SMD2K3OuX7f3HFsHB7Ci
   JUY55fIVk6C2EnGJVKSdZaiBFhQUm+H9WlvHXELY8gVYaW80v75oVZ/Tt
   t3dg3aF0St9tFC0u4oHscumcVh3qsxSG2MM3zei/Ns/O3MSmjGPpg5BbO
   g/RvN1dl7pb22HaThJhIQk7BF+9lN5p/jK4JlTnR8y4FmycK6BpQ3653P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2412884"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2412884"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 19:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119476638"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="1119476638"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2024 19:15:33 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV14O-00015c-2O;
	Wed, 31 Jan 2024 03:15:30 +0000
Date: Wed, 31 Jan 2024 11:14:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: Introduce buffered_write_operations
Message-ID: <202401311058.81kC2rCv-lkp@intel.com>
References: <20240130055414.2143959-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130055414.2143959-2-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kleikamp-shaggy/jfs-next]
[also build test WARNING on akpm-mm/mm-everything linus/master v6.8-rc2 next-20240130]
[cannot apply to tytso-ext4/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Introduce-buffered_write_operations/20240130-135555
base:   https://github.com/kleikamp/linux-shaggy jfs-next
patch link:    https://lore.kernel.org/r/20240130055414.2143959-2-willy%40infradead.org
patch subject: [PATCH 1/3] fs: Introduce buffered_write_operations
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240131/202401311058.81kC2rCv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401311058.81kC2rCv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401311058.81kC2rCv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/filemap.c:4060: warning: Function parameter or struct member 'ops' not described in 'filemap_write_iter'


vim +4060 mm/filemap.c

^1da177e4c3f41 Linus Torvalds          2005-04-16  4043  
e4dd9de3c66bc7 Jan Kara                2009-08-17  4044  /**
21878deb477823 Matthew Wilcox (Oracle  2024-01-30  4045)  * filemap_write_iter - write data to a file
e4dd9de3c66bc7 Jan Kara                2009-08-17  4046   * @iocb:	IO state structure
8174202b34c30e Al Viro                 2014-04-03  4047   * @from:	iov_iter with data to write
e4dd9de3c66bc7 Jan Kara                2009-08-17  4048   *
21878deb477823 Matthew Wilcox (Oracle  2024-01-30  4049)  * This is a wrapper around __filemap_write_iter() to be used by most
e4dd9de3c66bc7 Jan Kara                2009-08-17  4050   * filesystems. It takes care of syncing the file in case of O_SYNC file
9608703e488cf7 Jan Kara                2021-04-12  4051   * and acquires i_rwsem as needed.
21878deb477823 Matthew Wilcox (Oracle  2024-01-30  4052)  *
a862f68a8b3600 Mike Rapoport           2019-03-05  4053   * Return:
21878deb477823 Matthew Wilcox (Oracle  2024-01-30  4054)  * * negative error code if no data has been written at all or if
a862f68a8b3600 Mike Rapoport           2019-03-05  4055   *   vfs_fsync_range() failed for a synchronous write
a862f68a8b3600 Mike Rapoport           2019-03-05  4056   * * number of bytes written, even for truncated writes
e4dd9de3c66bc7 Jan Kara                2009-08-17  4057   */
21878deb477823 Matthew Wilcox (Oracle  2024-01-30  4058) ssize_t filemap_write_iter(struct kiocb *iocb, struct iov_iter *from,
21878deb477823 Matthew Wilcox (Oracle  2024-01-30  4059) 		const struct buffered_write_operations *ops)
^1da177e4c3f41 Linus Torvalds          2005-04-16 @4060  {
^1da177e4c3f41 Linus Torvalds          2005-04-16  4061  	struct file *file = iocb->ki_filp;
148f948ba877f4 Jan Kara                2009-08-17  4062  	struct inode *inode = file->f_mapping->host;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4063  	ssize_t ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4064  
5955102c9984fa Al Viro                 2016-01-22  4065  	inode_lock(inode);
3309dd04cbcd2c Al Viro                 2015-04-09  4066  	ret = generic_write_checks(iocb, from);
3309dd04cbcd2c Al Viro                 2015-04-09  4067  	if (ret > 0)
21878deb477823 Matthew Wilcox (Oracle  2024-01-30  4068) 		ret = __filemap_write_iter(iocb, from, ops);
5955102c9984fa Al Viro                 2016-01-22  4069  	inode_unlock(inode);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4070  
e259221763a404 Christoph Hellwig       2016-04-07  4071  	if (ret > 0)
e259221763a404 Christoph Hellwig       2016-04-07  4072  		ret = generic_write_sync(iocb, ret);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4073  	return ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4074  }
21878deb477823 Matthew Wilcox (Oracle  2024-01-30  4075) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


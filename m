Return-Path: <linux-fsdevel+bounces-20382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F18D28CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 01:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C611C24677
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 23:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECFC13F44C;
	Tue, 28 May 2024 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAh2ZWC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEDE13F42E;
	Tue, 28 May 2024 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939776; cv=none; b=FmzNPxtTkPku3BqnI8qfOqXLILqGAVMcc5IEv4HKZ957p4DUncESjzbQg4VONswcXIJpBKwlwcOSHiniJ++Z/n7Q/wh/et1JwqoXv0FxmNsq2SeXheHs7G7PnkdVJnJWaEq+yxtQM+8QWDKkmdf9gBf/BgKjyFnqnN+CFwgHDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939776; c=relaxed/simple;
	bh=H7Aq7SkYqkg/33RZpajXoaZxlAVoWB5QrkHq25KdXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVsPMjSaLdx/DG7iez5ymWynBrhjN65LA8xZDE5EDhdmVjNLGe8GzNR3ynsgrnanG6FoEKP6w6/ZybBCKHcCnTTfMbeQKlhSPADe97C4kFG3k8vmoz2LTv5XpW1uoPsJpQA1n7K4r+b4F2KcdF0tB7YSRrD7nZj4KYtELPaQ9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAh2ZWC1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716939775; x=1748475775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H7Aq7SkYqkg/33RZpajXoaZxlAVoWB5QrkHq25KdXWY=;
  b=LAh2ZWC1Tc0yYcbcHS3cGlQTAf8mTHayzeSCPNXwBF+0JQ0w0Sl+oS2O
   1PVjxt8X2MMTH62GU0bvK5TCWKU/PPGJYTUr1H6hcmjVp5GnFAOo7wg2K
   YFNRlqKd7qzsbGVQSrMWjRHE5ObXjl4/TAy5LwZj8JfcIYjDGGF3R+9we
   my8GfHIZmrmDOn7NIrOMv3Yh/HQqgyiOjNBxZvz8SnsKkEFVoOink8jTZ
   jKkjXpkq9xay76kuXcgcsj9n8BqjjHTFuGJsgiUKHJIONgqw8weuoXSWg
   b/emzvr7UBQHvBa1+Kg2EI5hnWCa4k23jrOQQoZXwQcAJkpU+CEkRggy+
   g==;
X-CSE-ConnectionGUID: ksojs6Y9RhGrVEhMSJcUig==
X-CSE-MsgGUID: rqZFuLBwSvC7CgvMuRo9Xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13157168"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13157168"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:42:54 -0700
X-CSE-ConnectionGUID: e0kKPqBJRO6JERvxF4VmfQ==
X-CSE-MsgGUID: vfLCMKsxT+Cjx9nXtdUuzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72676222"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 28 May 2024 16:42:52 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sC6Sv-000Csl-22;
	Tue, 28 May 2024 23:42:49 +0000
Date: Wed, 29 May 2024 07:42:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/7] fs: Introduce buffered_write_operations
Message-ID: <202405290745.X6owMB05-lkp@intel.com>
References: <20240528164829.2105447-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528164829.2105447-2-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10-rc1 next-20240528]
[cannot apply to tytso-ext4/dev jack-fs/for_next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Introduce-buffered_write_operations/20240529-005213
base:   linus/master
patch link:    https://lore.kernel.org/r/20240528164829.2105447-2-willy%40infradead.org
patch subject: [PATCH 1/7] fs: Introduce buffered_write_operations
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20240529/202405290745.X6owMB05-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405290745.X6owMB05-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405290745.X6owMB05-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/filemap.c:4097: warning: Function parameter or struct member 'fsdata' not described in '__filemap_write_iter'
   mm/filemap.c:4146: warning: Function parameter or struct member 'ops' not described in 'filemap_write_iter'
>> mm/filemap.c:4146: warning: Function parameter or struct member 'fsdata' not described in 'filemap_write_iter'


vim +4097 mm/filemap.c

^1da177e4c3f41 Linus Torvalds          2005-04-16  4072  
e4dd9de3c66bc7 Jan Kara                2009-08-17  4073  /**
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4074)  * __filemap_write_iter - write data to a file
e4dd9de3c66bc7 Jan Kara                2009-08-17  4075   * @iocb: IO state structure (file, offset, etc.)
8174202b34c30e Al Viro                 2014-04-03  4076   * @from: iov_iter with data to write
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4077)  * @ops: How to inform the filesystem that a write is starting/finishing.
e4dd9de3c66bc7 Jan Kara                2009-08-17  4078   *
e4dd9de3c66bc7 Jan Kara                2009-08-17  4079   * This function does all the work needed for actually writing data to a
e4dd9de3c66bc7 Jan Kara                2009-08-17  4080   * file. It does all basic checks, removes SUID from the file, updates
e4dd9de3c66bc7 Jan Kara                2009-08-17  4081   * modification times and calls proper subroutines depending on whether we
e4dd9de3c66bc7 Jan Kara                2009-08-17  4082   * do direct IO or a standard buffered write.
e4dd9de3c66bc7 Jan Kara                2009-08-17  4083   *
9608703e488cf7 Jan Kara                2021-04-12  4084   * It expects i_rwsem to be grabbed unless we work on a block device or similar
e4dd9de3c66bc7 Jan Kara                2009-08-17  4085   * object which does not need locking at all.
e4dd9de3c66bc7 Jan Kara                2009-08-17  4086   *
e4dd9de3c66bc7 Jan Kara                2009-08-17  4087   * This function does *not* take care of syncing data in case of O_SYNC write.
e4dd9de3c66bc7 Jan Kara                2009-08-17  4088   * A caller has to handle it. This is mainly due to the fact that we want to
9608703e488cf7 Jan Kara                2021-04-12  4089   * avoid syncing under i_rwsem.
a862f68a8b3600 Mike Rapoport           2019-03-05  4090   *
a862f68a8b3600 Mike Rapoport           2019-03-05  4091   * Return:
a862f68a8b3600 Mike Rapoport           2019-03-05  4092   * * number of bytes written, even for truncated writes
a862f68a8b3600 Mike Rapoport           2019-03-05  4093   * * negative error code if no data has been written at all
e4dd9de3c66bc7 Jan Kara                2009-08-17  4094   */
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4095) ssize_t __filemap_write_iter(struct kiocb *iocb, struct iov_iter *from,
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4096) 		const struct buffered_write_operations *ops, void *fsdata)
^1da177e4c3f41 Linus Torvalds          2005-04-16 @4097  {
^1da177e4c3f41 Linus Torvalds          2005-04-16  4098  	struct file *file = iocb->ki_filp;
fb5527e68d4956 Jeff Moyer              2006-10-19  4099  	struct address_space *mapping = file->f_mapping;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4100  	struct inode *inode = mapping->host;
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4101  	ssize_t ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4102  
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4103  	ret = file_remove_privs(file);
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4104  	if (ret)
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4105  		return ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4106  
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4107  	ret = file_update_time(file);
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4108  	if (ret)
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4109  		return ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4110  
2ba48ce513c4e5 Al Viro                 2015-04-09  4111  	if (iocb->ki_flags & IOCB_DIRECT) {
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4112  		ret = generic_file_direct_write(iocb, from);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4113  		/*
fbbbad4bc2101e Matthew Wilcox          2015-02-16  4114  		 * If the write stopped short of completing, fall back to
fbbbad4bc2101e Matthew Wilcox          2015-02-16  4115  		 * buffered writes.  Some filesystems do this for writes to
fbbbad4bc2101e Matthew Wilcox          2015-02-16  4116  		 * holes, for example.  For DAX files, a buffered write will
fbbbad4bc2101e Matthew Wilcox          2015-02-16  4117  		 * not succeed (even if it did, DAX does not handle dirty
fbbbad4bc2101e Matthew Wilcox          2015-02-16  4118  		 * page-cache pages correctly).
^1da177e4c3f41 Linus Torvalds          2005-04-16  4119  		 */
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4120  		if (ret < 0 || !iov_iter_count(from) || IS_DAX(inode))
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4121  			return ret;
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4122  		return direct_write_fallback(iocb, from, ret,
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4123) 				filemap_perform_write(iocb, from, ops, fsdata));
fb5527e68d4956 Jeff Moyer              2006-10-19  4124  	}
44fff0fa08ec5a Christoph Hellwig       2023-06-01  4125  
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4126) 	return filemap_perform_write(iocb, from, ops, fsdata);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4127  }
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4128) EXPORT_SYMBOL(__filemap_write_iter);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4129  
e4dd9de3c66bc7 Jan Kara                2009-08-17  4130  /**
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4131)  * filemap_write_iter - write data to a file
e4dd9de3c66bc7 Jan Kara                2009-08-17  4132   * @iocb:	IO state structure
8174202b34c30e Al Viro                 2014-04-03  4133   * @from:	iov_iter with data to write
e4dd9de3c66bc7 Jan Kara                2009-08-17  4134   *
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4135)  * This is a wrapper around __filemap_write_iter() to be used by most
e4dd9de3c66bc7 Jan Kara                2009-08-17  4136   * filesystems. It takes care of syncing the file in case of O_SYNC file
9608703e488cf7 Jan Kara                2021-04-12  4137   * and acquires i_rwsem as needed.
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4138)  *
a862f68a8b3600 Mike Rapoport           2019-03-05  4139   * Return:
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4140)  * * negative error code if no data has been written at all or if
a862f68a8b3600 Mike Rapoport           2019-03-05  4141   *   vfs_fsync_range() failed for a synchronous write
a862f68a8b3600 Mike Rapoport           2019-03-05  4142   * * number of bytes written, even for truncated writes
e4dd9de3c66bc7 Jan Kara                2009-08-17  4143   */
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4144) ssize_t filemap_write_iter(struct kiocb *iocb, struct iov_iter *from,
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4145) 		const struct buffered_write_operations *ops, void *fsdata)
^1da177e4c3f41 Linus Torvalds          2005-04-16 @4146  {
^1da177e4c3f41 Linus Torvalds          2005-04-16  4147  	struct file *file = iocb->ki_filp;
148f948ba877f4 Jan Kara                2009-08-17  4148  	struct inode *inode = file->f_mapping->host;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4149  	ssize_t ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4150  
5955102c9984fa Al Viro                 2016-01-22  4151  	inode_lock(inode);
3309dd04cbcd2c Al Viro                 2015-04-09  4152  	ret = generic_write_checks(iocb, from);
3309dd04cbcd2c Al Viro                 2015-04-09  4153  	if (ret > 0)
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4154) 		ret = __filemap_write_iter(iocb, from, ops, fsdata);
5955102c9984fa Al Viro                 2016-01-22  4155  	inode_unlock(inode);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4156  
e259221763a404 Christoph Hellwig       2016-04-07  4157  	if (ret > 0)
e259221763a404 Christoph Hellwig       2016-04-07  4158  		ret = generic_write_sync(iocb, ret);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4159  	return ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4160  }
1e90da36c016f4 Matthew Wilcox (Oracle  2024-05-28  4161) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-34705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9220C9C7E56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 23:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8D0285E30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 22:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6929218C01B;
	Wed, 13 Nov 2024 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUtXDAuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6513959D
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537587; cv=none; b=d9rT8/0MdKyGGQsa9MLtnlFyUe3/HiYHsAXsLve5wPACVvwzoVmZCscaqqKEW1cqURyxBvfJGr67XYQ8XjiCPN4BRFLxWU/HDU9sAuNe484VR5n16xgBzTcKKsrQPvfRbQJkqg78f/9mj1JD+CXSrO+jy5j+u39HgNosLQ+4vN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537587; c=relaxed/simple;
	bh=ntXYvb24hd8LDTDLKkvbIR+JdrRF6BWHrPmkA1F1AI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DakwbjVrCz96PbfbPhiMiQvqJ61UlT7SD52kBC4xz1Y/fSJopC71tQO7n13G8NQu7hy/Q9c+JpH/9xwwQ4jPAB1rlmFxp0TnbO38MT0Fdr58LH8agBlpbsvleuxg2jGqTMnAuWRiPXuOY5y18SxZ71JpGp4AleO00EV02T0yfc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUtXDAuq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731537586; x=1763073586;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ntXYvb24hd8LDTDLKkvbIR+JdrRF6BWHrPmkA1F1AI4=;
  b=ZUtXDAuq52zSO4JrNVXru8RoVc3XFtPMWZKiPuFWuqbe9oCTf855HggG
   wlNt8rVwSdouUZlXskRXz3tcIPbGH327VxSQ7WKHUOen1zRDlnIf4vE7/
   eLhZcNn39npLJ0om8GOiyvRTNF+gCy0ovEfbVmgbxoZVwBpcYc7LujKZs
   cud3rvpDcZ24XxI2jFAIkMoU/Ds4pF1rIh4mMD+gR6TlhoCfbfPQmHsom
   5ECy9PEH5LIeH0/JA3mytezoxLqJyKUszis5HJr30APEvZqoUAXLzaPGp
   fCyHPgwAMdE9wBA2CmTIF/v4noBEEyAHRICWeVlDI7fvLNLFU9HeQXfCo
   w==;
X-CSE-ConnectionGUID: qtmlpF+mR8+GbNlf2MOrEA==
X-CSE-MsgGUID: kwaCSgmLR+CzzBf4Kc8ARg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42869945"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="42869945"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:39:46 -0800
X-CSE-ConnectionGUID: hQYo/dZsRQ6Z9Wuqm2XFsQ==
X-CSE-MsgGUID: ScSe+HB5SQ+Q2dichODPBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="92051712"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Nov 2024 14:39:44 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBM1W-0000nX-0o;
	Wed, 13 Nov 2024 22:39:42 +0000
Date: Thu, 14 Nov 2024 06:39:21 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:next.getname 17/17] ipc/mqueue.c:886:9: error: implicit
 declaration of function 'audit_inode'
Message-ID: <202411140656.wyWgEvw4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git next.getname
head:   25ea033155f4d083b5a20417d53754b11a39c3bb
commit: 25ea033155f4d083b5a20417d53754b11a39c3bb [17/17] RIP filename::uptr
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20241114/202411140656.wyWgEvw4-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140656.wyWgEvw4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140656.wyWgEvw4-lkp@intel.com/

All errors (new ones prefixed by >>):

   ipc/mqueue.c: In function 'prepare_open':
>> ipc/mqueue.c:886:9: error: implicit declaration of function 'audit_inode' [-Wimplicit-function-declaration]
     886 |         audit_inode(name, dentry, 0);
         |         ^~~~~~~~~~~


vim +/audit_inode +886 ipc/mqueue.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  867  
066cc813e94a34 Al Viro           2017-12-01  868  static int prepare_open(struct dentry *dentry, int oflag, int ro,
066cc813e94a34 Al Viro           2017-12-01  869  			umode_t mode, struct filename *name,
614b84cf4e4a92 Serge Hallyn      2009-04-06  870  			struct mq_attr *attr)
^1da177e4c3f41 Linus Torvalds    2005-04-16  871  {
745ca2475a6ac5 David Howells     2008-11-14  872  	static const int oflag2acc[O_ACCMODE] = { MAY_READ, MAY_WRITE,
^1da177e4c3f41 Linus Torvalds    2005-04-16  873  						  MAY_READ | MAY_WRITE };
765927b2d50871 Al Viro           2012-06-26  874  	int acc;
066cc813e94a34 Al Viro           2017-12-01  875  
9b20d7fc5250f5 Al Viro           2017-12-01  876  	if (d_really_is_negative(dentry)) {
9b20d7fc5250f5 Al Viro           2017-12-01  877  		if (!(oflag & O_CREAT))
9b20d7fc5250f5 Al Viro           2017-12-01  878  			return -ENOENT;
066cc813e94a34 Al Viro           2017-12-01  879  		if (ro)
066cc813e94a34 Al Viro           2017-12-01  880  			return ro;
066cc813e94a34 Al Viro           2017-12-01  881  		audit_inode_parent_hidden(name, dentry->d_parent);
066cc813e94a34 Al Viro           2017-12-01  882  		return vfs_mkobj(dentry, mode & ~current_umask(),
066cc813e94a34 Al Viro           2017-12-01  883  				  mqueue_create_attr, attr);
066cc813e94a34 Al Viro           2017-12-01  884  	}
9b20d7fc5250f5 Al Viro           2017-12-01  885  	/* it already existed */
066cc813e94a34 Al Viro           2017-12-01 @886  	audit_inode(name, dentry, 0);
9b20d7fc5250f5 Al Viro           2017-12-01  887  	if ((oflag & (O_CREAT|O_EXCL)) == (O_CREAT|O_EXCL))
9b20d7fc5250f5 Al Viro           2017-12-01  888  		return -EEXIST;
765927b2d50871 Al Viro           2012-06-26  889  	if ((oflag & O_ACCMODE) == (O_RDWR | O_WRONLY))
af4a5372e4166e Al Viro           2017-12-01  890  		return -EINVAL;
765927b2d50871 Al Viro           2012-06-26  891  	acc = oflag2acc[oflag & O_ACCMODE];
4609e1f18e19c3 Christian Brauner 2023-01-13  892  	return inode_permission(&nop_mnt_idmap, d_inode(dentry), acc);
^1da177e4c3f41 Linus Torvalds    2005-04-16  893  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  894  

:::::: The code at line 886 was first introduced by commit
:::::: 066cc813e94a344ae4482af310d324739955c3b5 do_mq_open(): move all work prior to dentry_open() into a helper

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


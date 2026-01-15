Return-Path: <linux-fsdevel+bounces-74024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2809D2916A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 23:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 720343046980
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB762E22B5;
	Thu, 15 Jan 2026 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4wNpOb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD9215055
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517242; cv=none; b=eDhOBZ+WOtWoFqPHaISyxHTeH246H4SjhzgiFbIGZGjZth2dSyQaziL46CHhcZQFIeMmPl0ja8z9LSvFEu+7yS+q8lqyUNFZEsASPmwTsM3tdzybk8LVrUFEJVCKlVBCI9iRFFO0BDUvoPC9CKAp8KQOM2MQPXVH8TRr1CvOZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517242; c=relaxed/simple;
	bh=NyuUVj5QrIjopuwqQPjikd5PjXu4iYddZhGtjoXfZwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idl4JxQv03qbQRMy3e/deEas6cQYWaWigHzSmpylJz78+zL0w4QvgXbRQ60j8jm0xsbM6dxWv1yZ9LU6pqhrnYwfxjmhmzrMBh6OD0htlHnvIZp/KdTCedGPNJU2ttsek+MD/vN+bk/oabaMljnd1Fg3ZUpo5eYIGOJpPPiqsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4wNpOb4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517241; x=1800053241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NyuUVj5QrIjopuwqQPjikd5PjXu4iYddZhGtjoXfZwA=;
  b=Y4wNpOb4H7Kj7FkmaE+V2SppXom/4oIfl1BYPkJMvK+pxe/ZokccRS/Z
   mIvMHY+6dY7y/g/O69QpA0z8DeVHtYSn/a/3xjmtD5D/IeflhVclXVrag
   TnnDjaANhnn2JkrWvf3bzYfdHWrX+zuUOcqUuE/i42xD5D/gCX8THvhuK
   mhSqJ7BgMEv4a5ii+74s9Ay9fijla4/w5eiKY+Kamx1eyGJifWiEDxG4b
   X1RPtMJjd63VCpxH/4thvEU4U9yPUvwQKuQ905yjB1NjYDs7Om3xDZuH5
   9Sx9AO+CESbM2d5iWYFJIsqXSLYjdjX6VznXqUSt38EokWuuIZPz1N3nc
   g==;
X-CSE-ConnectionGUID: vcsT3yIjT4mYQsAXbk+UZQ==
X-CSE-MsgGUID: Z9LxqDZ9TuashBHGQSCTGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="73678737"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="73678737"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:20 -0800
X-CSE-ConnectionGUID: gbMbEkvzRaqXXJLIvsq/Og==
X-CSE-MsgGUID: iGVcOU/jRMOhHYlbatZgug==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jan 2026 14:47:19 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgW7Y-00000000K4i-3OxB;
	Thu, 15 Jan 2026 22:47:16 +0000
Date: Fri, 16 Jan 2026 06:46:19 +0800
From: kernel test robot <lkp@intel.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] posix_acl: make posix_acl_to_xattr() alloc the buffer
Message-ID: <202601160622.QW5z6XIJ-lkp@intel.com>
References: <20260115122341.556026-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115122341.556026-1-mszeredi@redhat.com>

Hi Miklos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on kdave/for-next ceph-client/testing mszeredi-fuse/for-next gfs2/for-next linus/master v6.19-rc5 next-20260115]
[cannot apply to ceph-client/for-linus kleikamp-shaggy/jfs-next ericvh-v9fs/for-next hubcap/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miklos-Szeredi/posix_acl-make-posix_acl_to_xattr-alloc-the-buffer/20260115-202602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260115122341.556026-1-mszeredi%40redhat.com
patch subject: [PATCH] posix_acl: make posix_acl_to_xattr() alloc the buffer
config: arm-randconfig-r131-20260116 (https://download.01.org/0day-ci/archive/20260116/202601160622.QW5z6XIJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601160622.QW5z6XIJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601160622.QW5z6XIJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/gfs2/acl.c:87:22: sparse: sparse: Using plain integer as NULL pointer

vim +87 fs/gfs2/acl.c

    82	
    83	int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
    84	{
    85		int error;
    86		size_t len = 0;
  > 87		char *data = 0;
    88		const char *name = gfs2_acl_name(type);
    89	
    90		if (acl) {
    91			data = posix_acl_to_xattr(&init_user_ns, acl, &len, GFP_NOFS);
    92			if (data == NULL)
    93				return -ENOMEM;
    94		}
    95	
    96		error = __gfs2_xattr_set(inode, name, data, len, 0, GFS2_EATYPE_SYS);
    97		if (error)
    98			goto out;
    99		set_cached_acl(inode, type, acl);
   100	out:
   101		kfree(data);
   102		return error;
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


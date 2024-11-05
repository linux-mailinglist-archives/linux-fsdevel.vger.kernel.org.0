Return-Path: <linux-fsdevel+bounces-33655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643379BCB14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89501F23B66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DBB1D2B39;
	Tue,  5 Nov 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zu13r4TA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698E1D2F46
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804127; cv=none; b=itjdiDLFbwwLtgflr8PZd3Yldp6zwuvTuc97jhswYHiMLIUxX0/Od1s59tVzl4ud04Y6f28GXz0uboqSkghgUD0f+wgCHAV3HyImd3XRRSkHexmH3JgO86afqkcJnj/t8OSezNZpl1w1zbstWlgm+m7IUotz/ELfsJrtUJOFdz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804127; c=relaxed/simple;
	bh=QxlVY9iIc87G65qsh55TWdv+Ql7CEdjQwusBDD0Rh6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEe2+wui5k6cf09cGYg+TVgNq/k/YfzQUVx+sKcvyAnoGVQGJNzuYB3MrnAH04ycsK/OFPQ7pb5zKUJF8AlioPiMnUkM8DFTYri/WW+bn0Cg+LCagr+n4vRpBEfYAY020oqRnWDkCLk3Yjz0mSxtczbQLSNRkoVy+WzGw5mAO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zu13r4TA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730804126; x=1762340126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QxlVY9iIc87G65qsh55TWdv+Ql7CEdjQwusBDD0Rh6U=;
  b=Zu13r4TA+LrNCA4rXXy9o1y8EYGT/4lu0ZYiTS+vlh6OwoxvGiZmeGS+
   djqN15GFzt5TacgfgS+I+i/N7nSaq7lGIax42U4tAcobjowZD2lrtcKUL
   4POidK3waIP0V7ICEVVXE0gmH5dWsHRU2B/S+aNCOg6Wnrg05li7BPrkK
   ekBEbqPPHqXsllvvhUPlbYJpH/U8GmpUPg4BSTuRgRzNc73aSgAsTbUj7
   k0G189rGo5YUqyv0CdwuXCiGFYlxaHd8Eyg1FluJbZe2XZRSH12/LxRvx
   jRPdcG7zzvr7bLTM+Npst08QBqPG3IZbWN9uHN8pdOtx7Qs3/u3P+SGVB
   w==;
X-CSE-ConnectionGUID: f14WOt2oT3qdC8Cebk7vJQ==
X-CSE-MsgGUID: 2RVD7K7iQYWhrSZeTQrZBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34232865"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34232865"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:55:26 -0800
X-CSE-ConnectionGUID: nBt0j7+TRbScQ9epErXFZg==
X-CSE-MsgGUID: UQ9+UextR9aE5JsRi0u58w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="83493956"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2024 02:55:23 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8HDV-000lwH-0D;
	Tue, 05 Nov 2024 10:55:21 +0000
Date: Tue, 5 Nov 2024 18:54:41 +0800
From: kernel test robot <lkp@intel.com>
To: David Disseldorp <ddiss@suse.de>, linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v2 2/9] initramfs_test: kunit tests for initramfs
 unpacking
Message-ID: <202411051801.XD3QJjcO-lkp@intel.com>
References: <20241104141750.16119-3-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104141750.16119-3-ddiss@suse.de>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on brauner-vfs/vfs.all linus/master v6.12-rc6 next-20241105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Disseldorp/init-add-initramfs_internal-h/20241104-223438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20241104141750.16119-3-ddiss%40suse.de
patch subject: [PATCH v2 2/9] initramfs_test: kunit tests for initramfs unpacking
config: arm-randconfig-004-20241105 (https://download.01.org/0day-ci/archive/20241105/202411051801.XD3QJjcO-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411051801.XD3QJjcO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411051801.XD3QJjcO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> init/initramfs_test.c:210:9: error: call to undeclared function 'filp_open'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           file = filp_open(c[0].fname, O_RDONLY, 0);
                  ^
>> init/initramfs_test.c:210:31: error: use of undeclared identifier 'O_RDONLY'
           file = filp_open(c[0].fname, O_RDONLY, 0);
                                        ^
>> init/initramfs_test.c:217:8: error: call to undeclared function 'kernel_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           len = kernel_read(file, cpio_srcbuf, c[0].filesize, NULL);
                 ^
   init/initramfs_test.c:217:8: note: did you mean 'kref_read'?
   include/linux/kref.h:34:28: note: 'kref_read' declared here
   static inline unsigned int kref_read(const struct kref *kref)
                              ^
   3 errors generated.


vim +/filp_open +210 init/initramfs_test.c

   176	
   177	static void __init initramfs_test_data(struct kunit *test)
   178	{
   179		char *err, *cpio_srcbuf;
   180		size_t len;
   181		struct file *file;
   182		struct initramfs_test_cpio c[] = { {
   183			.magic = "070701",
   184			.ino = 1,
   185			.mode = S_IFREG | 0777,
   186			.uid = 0,
   187			.gid = 0,
   188			.nlink = 1,
   189			.mtime = 1,
   190			.filesize = sizeof("ASDF") - 1,
   191			.devmajor = 0,
   192			.devminor = 1,
   193			.rdevmajor = 0,
   194			.rdevminor = 0,
   195			.namesize = sizeof("initramfs_test_data"),
   196			.csum = 0,
   197			.fname = "initramfs_test_data",
   198			.data = "ASDF",
   199		} };
   200	
   201		/* +6 for max name and data 4-byte padding */
   202		cpio_srcbuf = kmalloc(CPIO_HDRLEN + c[0].namesize + c[0].filesize + 6,
   203				      GFP_KERNEL);
   204	
   205		len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
   206	
   207		err = unpack_to_rootfs(cpio_srcbuf, len);
   208		KUNIT_EXPECT_NULL(test, err);
   209	
 > 210		file = filp_open(c[0].fname, O_RDONLY, 0);
   211		if (!file) {
   212			KUNIT_FAIL(test, "open failed");
   213			goto out;
   214		}
   215	
   216		/* read back file contents into @cpio_srcbuf and confirm match */
 > 217		len = kernel_read(file, cpio_srcbuf, c[0].filesize, NULL);
   218		KUNIT_EXPECT_EQ(test, len, c[0].filesize);
   219		KUNIT_EXPECT_MEMEQ(test, cpio_srcbuf, c[0].data, len);
   220	
   221		fput(file);
   222		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
   223	out:
   224		kfree(cpio_srcbuf);
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


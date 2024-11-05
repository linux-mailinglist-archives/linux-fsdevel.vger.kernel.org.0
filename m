Return-Path: <linux-fsdevel+bounces-33658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A51869BCBCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 12:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368DC1F2453D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 11:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321EA1D47BB;
	Tue,  5 Nov 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpU1p/VP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AD1CB53A
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805988; cv=none; b=RjM7w0RI0LbUms5djrQw9ZVqvVCR0AAID5e0m5YRYofT4LzgPuzv1jHQANqnRJ9C9e8tfc6F5NTeXD0DDvJSwdRVWuQhyKsqvLFrDMtDplRkcgHAc5vck4FOp5qB9FWj1em50P1y0phifA8wOeD3/aDoFXs2GaTQHu8nVBn848E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805988; c=relaxed/simple;
	bh=0hqff2fCCaFhjPdhAxjY9BCq5dN3IJqlXh6p2aXSa+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG4eeD7OOxZZlQZ7P6K0+mlpU0zvLvovcPmwdJm9nAdCpswItZmsibQw6LSSk8yBiSSubD6ZSPYNtTgB2+nq0VIj3BRde69PuChHRYZBX1em/VVf7psxDDCnv3B2UfOIiy+Zppu0m+/qLzSP6PA478+7vuZk2LipT5csEhsKtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpU1p/VP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730805985; x=1762341985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0hqff2fCCaFhjPdhAxjY9BCq5dN3IJqlXh6p2aXSa+M=;
  b=IpU1p/VP3j+aUcwV/0oaMz6yVhIcXp50mATLo12+R2fd8tJZ9WS0ccM1
   mWUH5p1gxdqKZnankdXpHjbe1DnqcSV/BoNFCU/2RONXiyzCKK9cWc95h
   U6BSC++dvqHL0LanCNjZ6XZD97yNuzxRHUBkE/+jJi/JIoioHyQdq0GgI
   1ZcsSJdnjFcNOJm/B/lZ0Num09OmtL3Y2EYTGZlJxJZfPcUYkNTE6SODP
   YIJb/O/P7a6o1LF7vTZzN3c0Xy213aOEXKpYRExfLrurHBBaYY3owrbEd
   IJ965Xa23ZsgTQl3pyOH5RpkOHGGsFfONXY+Izd+1GnkQ7H9eV+0g5Aik
   A==;
X-CSE-ConnectionGUID: TeW5kDdoTRaZEHWLtrQrsg==
X-CSE-MsgGUID: z8P+jwJSRSazmUz5U2yY7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30710711"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30710711"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 03:26:25 -0800
X-CSE-ConnectionGUID: cTLqRaxvTdqM8Ep2GyUuYg==
X-CSE-MsgGUID: /kRIwFSaSzmin/rD2DNVOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84374443"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2024 03:26:25 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8HhW-000lyN-0d;
	Tue, 05 Nov 2024 11:26:22 +0000
Date: Tue, 5 Nov 2024 19:26:13 +0800
From: kernel test robot <lkp@intel.com>
To: David Disseldorp <ddiss@suse.de>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v2 2/9] initramfs_test: kunit tests for initramfs
 unpacking
Message-ID: <202411051848.VyTNtYY8-lkp@intel.com>
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241105/202411051848.VyTNtYY8-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411051848.VyTNtYY8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411051848.VyTNtYY8-lkp@intel.com/

All errors (new ones prefixed by >>):

   init/initramfs_test.c: In function 'initramfs_test_data':
>> init/initramfs_test.c:210:16: error: implicit declaration of function 'filp_open' [-Werror=implicit-function-declaration]
     210 |         file = filp_open(c[0].fname, O_RDONLY, 0);
         |                ^~~~~~~~~
>> init/initramfs_test.c:210:38: error: 'O_RDONLY' undeclared (first use in this function)
     210 |         file = filp_open(c[0].fname, O_RDONLY, 0);
         |                                      ^~~~~~~~
   init/initramfs_test.c:210:38: note: each undeclared identifier is reported only once for each function it appears in
>> init/initramfs_test.c:217:15: error: implicit declaration of function 'kernel_read'; did you mean 'kref_read'? [-Werror=implicit-function-declaration]
     217 |         len = kernel_read(file, cpio_srcbuf, c[0].filesize, NULL);
         |               ^~~~~~~~~~~
         |               kref_read
   cc1: some warnings being treated as errors


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


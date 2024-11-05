Return-Path: <linux-fsdevel+bounces-33705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725959BD96E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 00:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C221C22636
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 23:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051D216425;
	Tue,  5 Nov 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9foGuAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABAD216200
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730847894; cv=none; b=iByYgQPt/58pHCaOPGvaM0sYmP5pZA3QTaA/b3aNkuR0+WK+GO+/u409jZCmXg596Rq6MK7Dr8tHH1adb26FWESYxppd9nZaW3DbRkqI5lQo6QTi2IVx9Zt5kixLEmSjDqMixenwI8/NJ3WQ/LczLBeiVJ8dfaxT7VpzucR0xes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730847894; c=relaxed/simple;
	bh=1oqdj3tBKBYW5FvOBtC5bU1wi8ylXUHzV7oahrFapI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBODRyd9Kbkgd+fy/FmL1L+f09wYsbVGI0rHHMdRraIaGm9EqU/Y9UJExP5RksQydS72H+ZYgtH6//tIysEM0Lmwgxr158YyIi0nKi+Bg3GTwy7fiJ+cGS0+GMAgh9SujtwL6D87NSyg4MbmDmpiQPQxgBAmTR6Ug9NN7GBt6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9foGuAc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730847893; x=1762383893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1oqdj3tBKBYW5FvOBtC5bU1wi8ylXUHzV7oahrFapI0=;
  b=O9foGuAclSZDnrYW1pqjqjYZwneT5rvbCELIUjm89cegtuneaQuSiXQN
   UMV8DKV+xGV6bS6/UaSpDwciAY/jZBjQ0oEV4VTcYM/JGnr2F5ZDktByR
   Ye8SBUUjfcxjrh4+HcqScMy6VQzonwidfIToMW4a/17mn5zvXizw4SR7E
   lgtM7iOeVecpWkfWqIQNfojipJqwGiZRuHvYxXAuR1jpxOZtCRuvgAkGQ
   Ppb2WQPgzysICTtJKMfMbmjpg4/MF3jgT3CjeAUbnHirfxRzmwNHggGUV
   hqqi73UhInKHKv6BFwbdknmz75nEKd4xuZIjMG7nrx0xEuueYUBw6W/Bb
   Q==;
X-CSE-ConnectionGUID: t7dJ7PSRTdG1aJ1nqJBhhQ==
X-CSE-MsgGUID: R/g/tovRQ4WWanif88QkfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="42002971"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="42002971"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 15:04:52 -0800
X-CSE-ConnectionGUID: 2NMqHK+5QBGFs1bL8XnVkg==
X-CSE-MsgGUID: wZ6WcuS0QFmJmeA6RhMqCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="107531476"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Nov 2024 15:04:51 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8SbR-000mYf-0P;
	Tue, 05 Nov 2024 23:04:49 +0000
Date: Wed, 6 Nov 2024 07:04:21 +0800
From: kernel test robot <lkp@intel.com>
To: David Disseldorp <ddiss@suse.de>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v2 2/9] initramfs_test: kunit tests for initramfs
 unpacking
Message-ID: <202411060625.exdzruA8-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on brauner-vfs/vfs.all linus/master v6.12-rc6 next-20241105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Disseldorp/init-add-initramfs_internal-h/20241104-223438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20241104141750.16119-3-ddiss%40suse.de
patch subject: [PATCH v2 2/9] initramfs_test: kunit tests for initramfs unpacking
config: arm64-randconfig-002-20241106 (https://download.01.org/0day-ci/archive/20241106/202411060625.exdzruA8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411060625.exdzruA8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060625.exdzruA8-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x0 (section: .data) -> initramfs_test_extract (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x30 (section: .data) -> initramfs_test_fname_overrun (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x60 (section: .data) -> initramfs_test_data (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x90 (section: .data) -> initramfs_test_csum (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xc0 (section: .data) -> initramfs_test_hardlink (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xf0 (section: .data) -> initramfs_test_many (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


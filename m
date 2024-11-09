Return-Path: <linux-fsdevel+bounces-34125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFCB9C28CD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88BB283587
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7D58BE5;
	Sat,  9 Nov 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbsxxWlz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAC23A9;
	Sat,  9 Nov 2024 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111988; cv=none; b=JAv6cw29l72p6UhoO2RegB3EWnlDkRLl+GoDxVVlsLijsgSDnuDMRfrK1oflZwnEjoIMec7buSZ0Jg3ymJFhr1hHiQSXYqt+qmPqSX0AIUsUfCfOon3aZVOnvexJ8RKWmo7ehwU2xBLvAcY37a1LgBNbT/JnCYH2syej/p1qXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111988; c=relaxed/simple;
	bh=ZmXu0HwvoenLIZbkHNIAg7KS/uJlYe3PcAhRHRcH9dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2YOTqD5VJMraj3PdO7mxwB3adF5lwMa/OlXxUynrEsfFtuqxfsZlrM4iwwQfXhF+NMVZ4AusSwmYfShCMDE1fa3YiaHudbsHxmhRnUqitm8zExTHD02gKCM2dBjB69zEj28UFsL842QE72TOs0CNpFQ91Gg13rS8t+dX0s+cWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbsxxWlz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731111986; x=1762647986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZmXu0HwvoenLIZbkHNIAg7KS/uJlYe3PcAhRHRcH9dU=;
  b=kbsxxWlzI3h/2duJvl5xTNGffaRFmaKmgfGHBM3aTIWgzOGkgUWUP1d5
   m7afRmvYf1Xzew0o2/GSy+unhR4yVbIWnyiBYT6fFSTR6B1RESINjaCGt
   4OxaSNV92oMOuWbpjqkHVj4hX0PlU0F/GNlHzvPWC1WO//yI/QX7iRklT
   3eaIwJ4GszfPieGN3A5z+xvCnKWJ1DpgDeu3Jo4+NU7EWqrAEpXkTE+uh
   h21I4GJ8ffGX2zGE9wHM2Zy/Q7APLE8S3yGRxg8NXPR/PWPPWacRMHORd
   T9eoFVQA5H/QFrIurM6UGSiy8kTClYm+S2KbdUy8AdaHrbOZ3fVZciR+Z
   A==;
X-CSE-ConnectionGUID: 6lx2BvEFQqGP3YrJRBaVOw==
X-CSE-MsgGUID: GcJyGIawTUydBTWMQJv/tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="30892537"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="30892537"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 16:26:26 -0800
X-CSE-ConnectionGUID: IT7/5PGAT5eZlurXLmRbrg==
X-CSE-MsgGUID: L8OH6U2LTeiBgRJMO6oP5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="86060092"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Nov 2024 16:26:24 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9ZIz-000ruo-2f;
	Sat, 09 Nov 2024 00:26:21 +0000
Date: Sat, 9 Nov 2024 08:25:55 +0800
From: kernel test robot <lkp@intel.com>
To: David Disseldorp <ddiss@suse.de>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v3 2/9] initramfs_test: kunit tests for initramfs
 unpacking
Message-ID: <202411090808.exzPhnlj-lkp@intel.com>
References: <20241107002044.16477-3-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107002044.16477-3-ddiss@suse.de>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on brauner-vfs/vfs.all linus/master v6.12-rc6 next-20241108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Disseldorp/init-add-initramfs_internal-h/20241107-083002
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20241107002044.16477-3-ddiss%40suse.de
patch subject: [PATCH v3 2/9] initramfs_test: kunit tests for initramfs unpacking
config: sh-randconfig-r122-20241108 (https://download.01.org/0day-ci/archive/20241109/202411090808.exzPhnlj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241109/202411090808.exzPhnlj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411090808.exzPhnlj-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x0 (section: .data) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x1c (section: .data) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x38 (section: .data) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x54 (section: .data) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x70 (section: .data) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x8c (section: .data) -> set_reset_devices (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


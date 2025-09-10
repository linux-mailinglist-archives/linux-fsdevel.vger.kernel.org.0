Return-Path: <linux-fsdevel+bounces-60868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF56AB5240A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 00:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B37583903
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563832D3EEA;
	Wed, 10 Sep 2025 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgfTGvFa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB72877DC
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541733; cv=none; b=tnRzaBqjX9LwKiWRaxEds74QrkGB7ySwZYT/W2yfY2vU4vxeUimlvdg43bG0bWWx9lD2CfsvGIvZogKVLqVLfcuf9Usl2SWPefQkrCPKfxVNg52hzAel647kq4le6e8mqJZ4II+TKWTOmOzFZN0dAIYg9wGvL5XWSIovg7tU14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541733; c=relaxed/simple;
	bh=kaX8rJ5nTqr77iJ9DUkOLuqk1egeY/+7BDFRyxDTl+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B86+R7Bw86eNTUzBZg5TEyhYI0ES6uI0xrGesydNkgmBbpjI+oSc9ynox7bvrNAMqbG4CQVcoW6HeqiIWUPZrB9q9vilk18jt1NS0P6sshldeGAUBea1ySTMjy3cOeDqEVIZqU1wYd7dfo8/t+IDnlYzByW52w94G7w3u5Rf3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgfTGvFa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757541732; x=1789077732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kaX8rJ5nTqr77iJ9DUkOLuqk1egeY/+7BDFRyxDTl+0=;
  b=BgfTGvFani94s2u+rLC4AonJhI274WPGYRBvXNrO2pKuf8UvDTf4G43t
   LPQY02eyeEC1na72SyYqO1IDI006uSZS87Doq3SETH5PncuCs3ScrOPRM
   BGsrPf8eqpMYKtlIi6NAdItAOSkHE7ZBeATetFOsj26KB5mHIDFQNfYgs
   Kb+/DMFeCMRCyo5tqfnLdW1rham4gWMHHhq3gpr/rQx46Rejf5dXhE5IM
   De54dXAOVGODR1L4CueaMGWWbL8BvR+W6eKn2D/snOqEWV/Pg5e+Su8Nz
   ziLWuAErpFFCFJpduKXKKNNYwQzBKYchezDUNGBQFMVkKjcaKW36ur5Xf
   w==;
X-CSE-ConnectionGUID: YnyO6arJTPa+gI/D6LjXIQ==
X-CSE-MsgGUID: iD0BzUdtQJqrfwrEetb/bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="47437894"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="47437894"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 15:02:11 -0700
X-CSE-ConnectionGUID: 5bMekvClScaGUpSIvEgNGA==
X-CSE-MsgGUID: nRJjacm7T8Gtqn1UIzvGiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="174321018"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Sep 2025 15:02:10 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwStD-0006KB-2O;
	Wed, 10 Sep 2025 22:02:07 +0000
Date: Thu, 11 Sep 2025 06:01:49 +0800
From: kernel test robot <lkp@intel.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org, frank.li@vivo.com
Cc: oe-kbuild-all@lists.linux.dev, Slava.Dubeyko@ibm.com
Subject: Re: [PATCH] hfs: introduce KUnit tests for HFS string operations
Message-ID: <202509110508.vlALr05g-lkp@intel.com>
References: <20250909234614.880671-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909234614.880671-1-slava@dubeyko.com>

Hi Viacheslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.17-rc5 next-20250910]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Viacheslav-Dubeyko/hfs-introduce-KUnit-tests-for-HFS-string-operations/20250910-074850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250909234614.880671-1-slava%40dubeyko.com
patch subject: [PATCH] hfs: introduce KUnit tests for HFS string operations
config: i386-buildonly-randconfig-001-20250910 (https://download.01.org/0day-ci/archive/20250911/202509110508.vlALr05g-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509110508.vlALr05g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509110508.vlALr05g-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "hfs_compare_dentry" [fs/hfs/string_test.ko] undefined!
>> ERROR: modpost: "hfs_hash_dentry" [fs/hfs/string_test.ko] undefined!
>> ERROR: modpost: "hfs_strcmp" [fs/hfs/string_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


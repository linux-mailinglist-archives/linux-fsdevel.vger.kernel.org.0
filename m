Return-Path: <linux-fsdevel+bounces-38135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E10C89FCA4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 11:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF797A1339
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194391D222B;
	Thu, 26 Dec 2024 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N21mJZ2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D61BF804
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735208821; cv=none; b=Wp2FIR5RpF1LEcg8lBIb7NlIqAFmPE1w6FO0qt6B3upMSvTzAXSVDT8RRCYrU/ylOU5UuXjUxd/df9Di/j52u9vg1ssvvE7i+ND8s54TVUJ8CQaphU8sa7v0JpuZFpLX2/hTyqx2R0YQ1REaE0v6L562GxZMErzYXKM5vs7+Gyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735208821; c=relaxed/simple;
	bh=sgH2XTjrdFG8F3Fmey1jz9VgKw6fT4tJw2vjo6uGXJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k0r1LLBOHtamdSVgnxffe7d84staTwVWOojuuAbCJsEvQDtO5trJYkK4otoAbGvvpa7N1BMzEdPhVd7vPlAR3JaloSHLVaWR80VHTcOG+xrg42z7vZdF3dUUce/VF38vjEZp+1pFF7miu49wED0ImZwgnrkUQQa7PQs72F4MR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N21mJZ2V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735208820; x=1766744820;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sgH2XTjrdFG8F3Fmey1jz9VgKw6fT4tJw2vjo6uGXJ0=;
  b=N21mJZ2VCDX+pcB4F4bZB4v1AGmW115WkPSr2cXQQHVl1eKH/w8sf5N+
   HU1/9J+35wggg8cfRxyzaAn54GDkdg9o/25I308TljVHiYrTrArPv1ZdQ
   em9o7k8nP/OnWiHW4Uk58huMrleD71NZvLZ/M4G/Mj8RO9DQm1A1SOPB5
   re+JvA9eNmrSFLAS0glvqwus0u4fG6mSLetlYm2tgrB0Ex0+SIG0PuyUg
   QxPnnAVwiAGkCqEr+1P4ezGa93uigk6/K7HIa7bjoxS5SwuJxMKnem47t
   xMfg/t4lm/UfScG2QTof6LnRSNF+R1Aq+7y2VWNdCEhyqfu8IDMIPby6K
   Q==;
X-CSE-ConnectionGUID: 9qTFAqFORkm695XXPTUjfA==
X-CSE-MsgGUID: ayYrI8NsT+uZU1Xf9EzAog==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35533103"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35533103"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 02:27:00 -0800
X-CSE-ConnectionGUID: ERLgufTIQHaoe2lx0QdT9Q==
X-CSE-MsgGUID: iuMTuSQuS5GzkQEKmpSIaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103971267"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Dec 2024 02:26:59 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQl4y-0002Th-1G;
	Thu, 26 Dec 2024 10:26:56 +0000
Date: Thu, 26 Dec 2024 18:26:32 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.debugfs 10/18] or1k-linux-ld:
 drivers/net/netdevsim/hwstats.o:(.data+0x0): multiple definition of
 `debugfs_ops';
 drivers/net/wireless/broadcom/b43legacy/debugfs.o:(.data+0x0): first defined
 here
Message-ID: <202412261812.h1ObeFD3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.debugfs
head:   edd14476c23067c1b707ebbcf685fb1ec9339acf
commit: 58332475a51f58a77f7196323ef95bb53684559f [10/18] netdevsim: don't embed file_operations into your structs
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20241226/202412261812.h1ObeFD3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241226/202412261812.h1ObeFD3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412261812.h1ObeFD3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> or1k-linux-ld: drivers/net/netdevsim/hwstats.o:(.data+0x0): multiple definition of `debugfs_ops'; drivers/net/wireless/broadcom/b43legacy/debugfs.o:(.data+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


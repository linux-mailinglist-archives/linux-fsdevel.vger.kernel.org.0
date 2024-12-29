Return-Path: <linux-fsdevel+bounces-38213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0CA9FDDA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 07:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90683A1684
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 06:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF52943F;
	Sun, 29 Dec 2024 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjrKqPBq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC623774
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735454523; cv=none; b=S/U/d8Z47D9gTZNCv+dXj6xUAEbufPl/YITCXKsjii17KoPZv7Qxjtl4yqcgpnV2jbNIprJKJ3Ex39hbLcXAEKN+04ZPMcv7z2UoM3ypR293mbsOviLjBMpOAAdcCI7Lb8kYn704UJq8t9p/w9Q3XFr8hXapc4akVAQLSFC1gjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735454523; c=relaxed/simple;
	bh=J47T/90KCX1ESLsvBBq+vAUBOio51VT+EyQRdzAGwnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fnd4FWRwGX0ODzYUii8WdznDOL1OAUucWUB8GfcexbsrHAYkdGqab5YDLAU1E4vkpB3F+phi3HTHuk5uzuF7tBA/uMmAp3R2xMcCObdLu+/Q9UCUYjcasJyBfkIyxoJmAyOyIMiVdtXo9Ml+BhVjndbUdXqXcjSgAnQn0oyXxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjrKqPBq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735454522; x=1766990522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J47T/90KCX1ESLsvBBq+vAUBOio51VT+EyQRdzAGwnI=;
  b=hjrKqPBqV87HJerLqhGfZoilSR1LNEiEs7N1GAionIBXD3Pvo0mKeU9K
   ym2tRjyUbxLIGCrIP/r2n6bvFgiiw74GxGLOQL0hvzN7+B8HLX7/BPl17
   dPaOZPp4ntBPf3woQ+CNtIqQhf1veJurVoL2O4V0EGiN1ePI965XuB+Us
   lPdIpnT7+jn0g1U7eWSW3sSlCwJ7JiahkCWZ/L9XrPkvRCMf+A0Fwx1HI
   31lQ8oDwGIn7MyZw5N/9xPx6Xo0dCYNI8MhKTumQlWnXyfXCQwWAwfA2T
   0zB2vqRB7mw5TBTWTU+pQ5edge5Bsx3X46FVRBTXoEy6UPk/GTlXiWf0s
   Q==;
X-CSE-ConnectionGUID: F/ycDdFoQEGw1MnwnSi8Cw==
X-CSE-MsgGUID: SkCkuuw8TH2XwGXnukJSzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="53181630"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="53181630"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 22:42:01 -0800
X-CSE-ConnectionGUID: V6vmU2J4Sqay3nJjYZK5sw==
X-CSE-MsgGUID: urskXO9nQhm9NxJu42MeMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105576109"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Dec 2024 22:42:00 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRmzu-0004X7-0b;
	Sun, 29 Dec 2024 06:41:58 +0000
Date: Sun, 29 Dec 2024 14:41:55 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.debugfs 20/20] include/linux/debugfs.h:366:16:
 warning: returning 'void *' from a function with return type 'int' makes
 integer from pointer without a cast
Message-ID: <202412291442.Nzfv9Uwh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.debugfs
head:   b41a25033d7a1783290826fb565d082a0c7a55c4
commit: b41a25033d7a1783290826fb565d082a0c7a55c4 [20/20] saner replacement for debugfs_rename()
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20241229/202412291442.Nzfv9Uwh-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241229/202412291442.Nzfv9Uwh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412291442.Nzfv9Uwh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/panic.c:35:
   include/linux/debugfs.h: In function 'debugfs_change_name':
>> include/linux/debugfs.h:366:16: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
     366 |         return ERR_PTR(-ENODEV);
         |                ^~~~~~~~~~~~~~~~


vim +366 include/linux/debugfs.h

c6468808149032 Nicolai Stange 2016-03-22  362  
b41a25033d7a17 Al Viro        2024-12-28  363  static inline int __printf(2, 3) debugfs_change_name(struct dentry *dentry,
b41a25033d7a17 Al Viro        2024-12-28  364  					const char *fmt, ...)
cfc94cdf8e0f14 Jan Kara       2007-05-09  365  {
cfc94cdf8e0f14 Jan Kara       2007-05-09 @366  	return ERR_PTR(-ENODEV);
cfc94cdf8e0f14 Jan Kara       2007-05-09  367  }
cfc94cdf8e0f14 Jan Kara       2007-05-09  368  

:::::: The code at line 366 was first introduced by commit
:::::: cfc94cdf8e0f14e692a5a40ef3cc10f464b2511b debugfs: add rename for debugfs files

:::::: TO: Jan Kara <jack@suse.cz>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


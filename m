Return-Path: <linux-fsdevel+bounces-38212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CFC9FDDA0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 07:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A61882787
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E520208AD;
	Sun, 29 Dec 2024 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vu+32jn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC14249EB
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735453861; cv=none; b=OPduGMDUh4ra3eVlg4BZm+HAW/iwseqQus7JZULoKt7o9I3U5FasnIApM0pev3fMyXUiAim703U06RI3N9py3sTUMxkmzPxIesPPukQt7GUkP/dHK+nxuaw9eOzDyG4BdhZW4HQ/l8XvB7F+eop0A3NF7eMC35RXWO0SQoWP22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735453861; c=relaxed/simple;
	bh=LMSj/cD2Xl6GDpxsZazwBcFTO8kMvDOOZNB4zpDIjSc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YiMoqv6hGsU/rOzEJSOo1RYHG3xEh/Lqe1PK1s8GCvlV57FDoHTj8uyicr2wWjVI4vKs97z4t2uI1lDM6t2KmYLN45DtJqxr4p8JLuX9ifLi/WulLRMGlSLUMR5bsoSxJlzrw673Q6rieJ9/Atc1z7VUKYg04JZk/K0aZVQDbs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vu+32jn/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735453860; x=1766989860;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LMSj/cD2Xl6GDpxsZazwBcFTO8kMvDOOZNB4zpDIjSc=;
  b=Vu+32jn/Z0MYAZRBjDYXO/KGZsEHkOjAcENvC1Q25DGmL76MKePVuopq
   wbpgvbxFCCfYrHD/1yumGo+hIafevhqYVy0V1ic3cHy+0xc73diNqE4ja
   QiAqu9xfEUmQ5QdBucYoo6oJ9EptwqscxH54ZNA/uKApRyr+K89a4rSh4
   joBW+iGj82NmYWfiZwor2Okne6vJ90/RlISvPcKzUuNwtuDXi3TgvIRii
   j10U8T3HPEytJKTcUAlUYPAYpLC/ecb6jTd3xD54U5s2TywP7aCMKisE4
   D8bFPI+TZFESJcj4zd2eZWMTP/mT3jX0YW2rGouj7g+TrTHQDqW7jVJUz
   g==;
X-CSE-ConnectionGUID: 3pljCKIxT7ekssKOOdav9A==
X-CSE-MsgGUID: xcOS1rPlT+6RMGuCHZjz6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35923752"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35923752"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 22:30:59 -0800
X-CSE-ConnectionGUID: nyFoTYfhSPe1DZByzW8EjA==
X-CSE-MsgGUID: i03hrQL0SX+vfqK6bz0rmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101346047"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 28 Dec 2024 22:30:57 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRmpB-0004We-32;
	Sun, 29 Dec 2024 06:30:53 +0000
Date: Sun, 29 Dec 2024 14:30:33 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.debugfs 20/20]
 drivers/net/bonding/bond_debugfs.c:66:2: error: use of undeclared identifier
 'err'
Message-ID: <202412291628.UQQUijmc-lkp@intel.com>
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
config: s390-randconfig-001-20241229 (https://download.01.org/0day-ci/archive/20241229/202412291628.UQQUijmc-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241229/202412291628.UQQUijmc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412291628.UQQUijmc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/bonding/bond_debugfs.c:66:2: error: use of undeclared identifier 'err'
      66 |         err = debugfs_change_name(bond->debug_dir, "%s", bond->dev->name);
         |         ^
   drivers/net/bonding/bond_debugfs.c:67:6: error: use of undeclared identifier 'err'
      67 |         if (err) {
         |             ^
   2 errors generated.


vim +/err +66 drivers/net/bonding/bond_debugfs.c

    63	
    64	void bond_debug_reregister(struct bonding *bond)
    65	{
  > 66		err = debugfs_change_name(bond->debug_dir, "%s", bond->dev->name);
    67		if (err) {
    68			netdev_warn(bond->dev, "failed to reregister, so just unregister old one\n");
    69			bond_debug_unregister(bond);
    70		}
    71	}
    72	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


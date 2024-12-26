Return-Path: <linux-fsdevel+bounces-38137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6E9FCB3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 14:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6176D162707
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785F31D4341;
	Thu, 26 Dec 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apLqUBzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939181EA65
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735220723; cv=none; b=duAyPJExij/Yn0sg8Ruspaf5O6Z/0PuBEuE6/4BACySRBcx0br/2ZRkkvHTOg9SenHHuyWsjAIx2/d+TxT52O08EmO3/LaKYco9zimT4eZSOiHYnv4AP+aePt99ylhawt/68wHVdEsLZjxj3Ev+fd9BfchjlpuIH8xvA1dFd4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735220723; c=relaxed/simple;
	bh=72jqLT5KdUhx5l7bPyF5Qy83+89aaUDh0CR/ykXdl4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TLIjKEYxcfMUKU7kICIPrW2R1ENTEzqARJvvWgIBlsieahyM+dutcnaSefZtRe2uc/wBlOWEoB90fOQ90Mphyi/PIW6TVtccUPATRdAqdAMf0cEUqZ+DbnDCaTC2nei/ykpwOVtmKmAEFWIdU+vkm6zJivFeO2P2WCqmQK0zaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apLqUBzt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735220722; x=1766756722;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=72jqLT5KdUhx5l7bPyF5Qy83+89aaUDh0CR/ykXdl4U=;
  b=apLqUBztUFhhvYHsmFJ9xMeZpp/mzhSQxniqbCjW38ULKoZaR+SWvVqD
   jfGmow9P51157J6kWoBEXCFEXLdc7OgJEgQn2MVfbaNphGqJ/jWroI/IM
   fXZCDk0HF6NrtBwuKTQ6cKxhOT05LbITSyKuL0s/ne1yGBbV6MMaqspXk
   qnPTufUmhB/Q/Wq2BFa8PB4Ra6AXqsyrYKqoCUz/biSAG4gocuOyjCLaS
   Mg2u1bop7j8Qq1aDxT4dwhYqF9XfMxfolpiPOvuiwhXpviWlg3rcHU5h0
   8uwFeVtn/u7yeo5LJP9QR0q43TeKA5nJlz48fuON/Q6YGkgxZFFR2b7hM
   g==;
X-CSE-ConnectionGUID: bTUjerdwQomMUmWNpzsUsw==
X-CSE-MsgGUID: YXSNG8e3Rbukt4NeLMApLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="47010376"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="47010376"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 05:45:22 -0800
X-CSE-ConnectionGUID: +JX9V32AQOukkZLYUWy4sw==
X-CSE-MsgGUID: 0sj2U9nuSsyLVkFKFWNdFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130909049"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Dec 2024 05:45:20 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQoAw-0002bi-0M;
	Thu, 26 Dec 2024 13:45:18 +0000
Date: Thu, 26 Dec 2024 21:44:40 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.debugfs 10/18] alpha-linux-ld:
 drivers/net/netdevsim/hwstats.o:(.data.rel+0x0): multiple definition of
 `debugfs_ops';
 drivers/net/wireless/broadcom/b43legacy/debugfs.o:(.data.rel+0x0): first
 defined here
Message-ID: <202412262154.UXjUsZtG-lkp@intel.com>
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
commit: 128048c2dc3cfcc04c1437816cf4db1e5d3305ed [10/18] netdevsim: don't embed file_operations into your structs
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241226/202412262154.UXjUsZtG-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241226/202412262154.UXjUsZtG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412262154.UXjUsZtG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> alpha-linux-ld: drivers/net/netdevsim/hwstats.o:(.data.rel+0x0): multiple definition of `debugfs_ops'; drivers/net/wireless/broadcom/b43legacy/debugfs.o:(.data.rel+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


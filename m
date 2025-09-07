Return-Path: <linux-fsdevel+bounces-60462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB83B478B3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 04:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41FD2063A1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 02:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B71A01C6;
	Sun,  7 Sep 2025 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0vWrx2H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244BDFC1D
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757211484; cv=none; b=ZeU1W8SX6ADT1ILSVL42Z6SI17hsXJ+OZ+ldLz5nzoqUuVXYTi/m62aSns5wBylw/j1rUoMBqshy+hhR+n4EChTEi2SkyYxltRnkm9F3XINGrDW+x7BT1ODFGBeINv/Kv32wmwMUSMGoRWLy2Q4MJIZgC7y4EZx6QKXF172XNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757211484; c=relaxed/simple;
	bh=cm4G7KoIwtQuhL6NLnCWALNLTdV6r+4o7J4FRio5OcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9btBydXQyFxM52DiISEpDeXjEEdk6Ptq82lNYHLe7MgkoBjsuu6Cy40YNeQVnArKL54dRrtg+UrUsGrG2Eh5d/qEuuIuApHubdJSY1kwoL+MZp0v+6jaPX1WnGAp3XDJ8JRjlJ/oRUmWaHPIl3+Hq5A985jscB7CdHEGjOrQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0vWrx2H; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757211482; x=1788747482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cm4G7KoIwtQuhL6NLnCWALNLTdV6r+4o7J4FRio5OcE=;
  b=F0vWrx2HnqMp8wfPShRCURFRnx1f5FHjeqq8G92BOy1jixfJrO2OVg7M
   ISugpnlo4tNSZhNc9bKkUhcCknVvbhVX0X2yh06EER8EcTcraiFEtk5to
   oddZziMbVaC+0AKRWTM18Pck2X1GrzlGD9OQZaruufdGYZtMNM8qX7zL7
   W6I+rucyWgkjQc8fSrk1qA0Q4SnpdZmayHApQeyPr7t+ZQRF+BU9qkDdw
   zksGmnaHklYHSnU3/11aUVR4WjzMAgZ98QfWGVfkwKRSgtJy5nryU/A/q
   w0+DKSAl1s0YmiCZoNsT5Eyc24H76t67VTphUQn2nTW0IeEZIQg8Ce8iw
   A==;
X-CSE-ConnectionGUID: wEh0Hti/TbKAsiRRx7GEPg==
X-CSE-MsgGUID: gf/NQOnITeK2ilLm5kw7Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="70128574"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="70128574"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 19:18:02 -0700
X-CSE-ConnectionGUID: AUCl7j+ySPGIuKkJm/WOLA==
X-CSE-MsgGUID: yHmN+5CRQtCtt7eHPaszlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="172044037"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Sep 2025 19:17:59 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv4yb-0001x7-0o;
	Sun, 07 Sep 2025 02:17:57 +0000
Date: Sun, 7 Sep 2025 10:17:00 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@ownmail.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] VFS/audit: introduce kern_path_parent() for audit
Message-ID: <202509070916.8uBFTDCH-lkp@intel.com>
References: <20250906050015.3158851-6-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906050015.3158851-6-neilb@ownmail.net>

Hi NeilBrown,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on pcmoore-audit/next viro-vfs/for-next linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/fs-proc-Don-t-look-root-inode-when-creating-self-and-thread-self/20250906-130248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250906050015.3158851-6-neilb%40ownmail.net
patch subject: [PATCH 5/6] VFS/audit: introduce kern_path_parent() for audit
config: x86_64-buildonly-randconfig-001-20250907 (https://download.01.org/0day-ci/archive/20250907/202509070916.8uBFTDCH-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070916.8uBFTDCH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070916.8uBFTDCH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/namei.c:2804 function parameter 'path' not described in 'kern_path_parent'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


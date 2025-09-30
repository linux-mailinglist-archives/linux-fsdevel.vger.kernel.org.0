Return-Path: <linux-fsdevel+bounces-63062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BBCBAAE93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 03:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAAD3BA613
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 01:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2011E5213;
	Tue, 30 Sep 2025 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SX7reB4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A516A956;
	Tue, 30 Sep 2025 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196865; cv=none; b=FAY3AcyxvlW7LMp3xjBBsPc3tZNSfdSFVQpmSvCqau+yk33Onc04IPJux3N7mQiYI65qnLSgssc/gPU2ZMByeTcb9V2RLAWHq+sHpNFpxlYiEHIonkcUfs/pab0ufYLBc1LSJ2IUgHkXe0m7ra5AV4HqF5FdKR7vQ0EnOfCz0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196865; c=relaxed/simple;
	bh=HgStWjYtyMljxtoehnaC6lpeJVqBYQGuOxxP3cAccdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy/dkjDbFHBxdbXgKfcbUJpnJ1PorazpTynLcfj2au7AX0n2BtQWHse8v/zK8GBWI0gYABdWZep8ZCHLCoidn8Q8BakWPxFcbVCzmKGQA5bHSyQTclCkJHutzPG9KX6LWOpnCZyra4XDLPxgReKsflw5Qqag5rZ3azuqiNHcCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SX7reB4g; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759196863; x=1790732863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HgStWjYtyMljxtoehnaC6lpeJVqBYQGuOxxP3cAccdo=;
  b=SX7reB4gVCAQUD9IzDUK226+xSQ2f2iYapIrxNETlDYlhPIZAHBl6BD6
   VooHxfwmze/12erEjqP4wZCgJfDQZ2xCWiwco2TZQGphZXPkl4kBRWgND
   cj4ya4dK9pCxrs2W3DBGHiVNRaQdXXb+an6x/USlHPKs1QzTJyW2d9Hkm
   20+4ICnz5w0F9+9nZeeHxBvD+8y/Nn5Fv06ZuStH01fsEGlnfW0kePc0z
   x3zlAXn0VX2/GUOaiXBRa+/prbvJWqIUY9g2pqo2wsxbvnDy8b2kfKNWo
   0GQPKWYRWIsHz45f2KKvoijt07NujGQ61ZmPaQmo0+BRkPqjxU/enh3ws
   w==;
X-CSE-ConnectionGUID: f74dK5EmQ1+LUvw+F/owiw==
X-CSE-MsgGUID: CoDFkA7oQn2kwx4fv9zvfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61404394"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61404394"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 18:47:42 -0700
X-CSE-ConnectionGUID: MC0JFXgtTmCRKCgKeYCDXg==
X-CSE-MsgGUID: FGhQtfEzRxa6drq++mMHtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="209335217"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Sep 2025 18:47:39 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3PSq-0000ol-2H;
	Tue, 30 Sep 2025 01:47:36 +0000
Date: Tue, 30 Sep 2025 09:47:09 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, clm@fb.com, dsterba@suse.com,
	xiubli@redhat.com, idryomov@gmail.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
	willy@infradead.org, jack@suse.cz, brauner@kernel.org,
	agruenba@redhat.com
Subject: Re: [PATCH] fs: Make wbc_to_tag() extern and use it in fs.
Message-ID: <202509300954.4OaImb0r-lkp@intel.com>
References: <20250929095544.308392-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929095544.308392-1-sunjunchao@bytedance.com>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on ceph-client/testing ceph-client/for-linus tytso-ext4/dev jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev gfs2/for-next akpm-mm/mm-everything linus/master v6.17 next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Sun/fs-Make-wbc_to_tag-extern-and-use-it-in-fs/20250929-175656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20250929095544.308392-1-sunjunchao%40bytedance.com
patch subject: [PATCH] fs: Make wbc_to_tag() extern and use it in fs.
config: s390-randconfig-001-20250930 (https://download.01.org/0day-ci/archive/20250930/202509300954.4OaImb0r-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250930/202509300954.4OaImb0r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509300954.4OaImb0r-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-mmio.o
>> ERROR: modpost: "wbc_to_tag" [fs/btrfs/btrfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


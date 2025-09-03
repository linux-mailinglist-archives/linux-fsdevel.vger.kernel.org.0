Return-Path: <linux-fsdevel+bounces-60039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A7B4130C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 05:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74C5701435
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 03:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8022D0615;
	Wed,  3 Sep 2025 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoaXdbBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69E2C3272;
	Wed,  3 Sep 2025 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871007; cv=none; b=YIzTMqjL166YZ33o9Z+6vatvp9pjldoYosd2R1TVVL2DpzBQ17Vmj+eueKlPUYu5SvMPHgJoanAXf0BTCCABMZv8NlExsIKzvJ+abNoVErNym42Wz60ro8MUiX6z2T4YaqFJPHkH7e5hZ3iEUPLhjq/1x/ttXZRoOx0cANLDtjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871007; c=relaxed/simple;
	bh=3/H3D++jBOi0YL40SQsDdbNfj63iF0hF6QE19mQ6O/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJi+VMhHSZ+oJFhrS/8F0He0orh+471lMmVfExp19k5AMgAEzCaTpUr0WRyEACLpSC6VYIkRc3zgWyJN6i0BO/yTDjd8YR+IkfHSw1aZd2E1SZHSWEEOPhazgPgU2SBa+49aTJ3kw8+cUJeTfIZc/2/wQncLv3qOACC4Tsdm5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoaXdbBI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756871006; x=1788407006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3/H3D++jBOi0YL40SQsDdbNfj63iF0hF6QE19mQ6O/Y=;
  b=PoaXdbBI9XXTga4jXc/S36C879w1/80kMdrtGBrPtzIeyWDLsmUNDc+s
   Q/3U9tl53VI8wAxUotqvhFkvkh92HKdMJJ/Jkgy9sqinGniqUDPXul1S0
   Ww133wlN2UkXpd6h+BJotQmPjO1EpBXcMNZjcoP5rUV+3f0eu9C7Lxpi9
   4TNnD2jcRD1iMZhpn4wcmFOZusJ8xxypDe7fAjN7wVu4QjgGZQSZuIEQw
   1nRKFu009JJ9IyS/h7NWM0EBo3+u9JbUF2zMVg4vkvLFWjywGQthpOHi6
   Um9AICbK73HEVc3GgcMTo0+T+I+zgIsqo/ESpTqprlgXrcsPaYCJl96F1
   Q==;
X-CSE-ConnectionGUID: ztxgv99cQlaiVCfF/NXMsQ==
X-CSE-MsgGUID: 4LvdJlO1TMiwg/H67tQ8SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59239526"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="59239526"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:43:25 -0700
X-CSE-ConnectionGUID: BNOKFyPcQhSe/ezBefGvdA==
X-CSE-MsgGUID: LOBuq2HDTz6A7jRiIA9b6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="170749413"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Sep 2025 20:43:23 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uteP2-0003KP-2H;
	Wed, 03 Sep 2025 03:43:20 +0000
Date: Wed, 3 Sep 2025 11:43:13 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Christian Brauner <christian@brauner.io>
Cc: oe-kbuild-all@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.com>,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2, udf: update to use mmap_prepare
Message-ID: <202509031109.QugeBzTq-lkp@intel.com>
References: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on gfs2/for-next linus/master v6.17-rc4 next-20250902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/gfs2-udf-update-to-use-mmap_prepare/20250902-200024
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250902115341.292100-1-lorenzo.stoakes%40oracle.com
patch subject: [PATCH] gfs2, udf: update to use mmap_prepare
config: x86_64-randconfig-004-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031109.QugeBzTq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031109.QugeBzTq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031109.QugeBzTq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/gfs2/file.c:591 function parameter 'desc' not described in 'gfs2_mmap_prepare'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-59926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB11B3F2DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 05:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552A33BAF11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 03:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE335962;
	Tue,  2 Sep 2025 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMdYpNYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09E7258CF9;
	Tue,  2 Sep 2025 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784795; cv=none; b=Cqcmn2CehpAbhgwS70QzKTFtJr3BbmrSGyVaiS9o9gwAgJ5rKupVSB6GryrEOP7iVltLjR/vHbm8IdCEviUwjWDgdmD8fmi0M+vXeMlbBYedTFxSdqq+Lm2rdPz62TyHQ13DgQIpIyFX0raRVrpoD08tD5bZypj+1g1xp6JHWBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784795; c=relaxed/simple;
	bh=MbdFjBKNCYlEpTeflOH1Ld6ATVHUTpagje8J5OIEUcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yzkc0ljJ0XQacAsOCeMe5lM0776SyfYkOsnFwIpLRlDRzmTT7Ke/06UHKifwgh4X81+EwToyFmrxg9A+ABQyMJ7qEz5PFYFuI3HEzVu193xyeK+A9A7dnMnWry/RiNYph2N+aXj5wqHfNWrb6qG4qlG+7dvGGog29Nb1EMJ9uUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMdYpNYQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756784794; x=1788320794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MbdFjBKNCYlEpTeflOH1Ld6ATVHUTpagje8J5OIEUcA=;
  b=dMdYpNYQ6lNI281u0LDwhhlxfa22ZA5GF+A9widKB1dMSIHoNdJV/YFC
   Khh6nVIBipVpJHCbBbTsH5kWGmVzMRzU3Fi/KHEf6ZBdWgxxbJ74bbqhE
   mgDTDyinA0qWEyhe1S9gIfpx4t0eSusCZyrzMM7wxVgT/r97lhIUqp89h
   5EhoqNkoOhefe8UN2jejrJfZY07yZApg6ntrFAMJr43xzTMSvvJ64NG2c
   cHzUM10OFPMWKmYCbcJ/IoDkf8axERR8Du8m9qjpG+9OnmnTTGFk7WYI5
   l7D7oAQyLjmw1+uevrlcPhzXrQwbdug8A7aigYst9jV9K5/Oj+EgBHo7Q
   Q==;
X-CSE-ConnectionGUID: rjWqmlu7Rxix4+PoAAuOSQ==
X-CSE-MsgGUID: TGhdtlSES0+OwFGa+ysrfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="69649219"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="69649219"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 20:46:33 -0700
X-CSE-ConnectionGUID: ZIOzoUkBTOqJsKDuNg8Z6g==
X-CSE-MsgGUID: p0xqsWG7SQSDyDlFPerGdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="172008043"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 01 Sep 2025 20:46:32 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utHyX-0001P5-3D;
	Tue, 02 Sep 2025 03:46:30 +0000
Date: Tue, 2 Sep 2025 11:46:03 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: cache max and min order inside btrfs_fs_info
Message-ID: <202509021022.B3V4xUho-lkp@intel.com>
References: <d1a3793b551f0a6ccaf8907cc5aa06d8f5b3d5c2.1756703958.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a3793b551f0a6ccaf8907cc5aa06d8f5b3d5c2.1756703958.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on next-20250901]
[cannot apply to linus/master v6.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-support-all-block-sizes-which-is-no-larger-than-page-size/20250901-132648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/d1a3793b551f0a6ccaf8907cc5aa06d8f5b3d5c2.1756703958.git.wqu%40suse.com
patch subject: [PATCH 2/4] btrfs: cache max and min order inside btrfs_fs_info
config: x86_64-buildonly-randconfig-004-20250902 (https://download.01.org/0day-ci/archive/20250902/202509021022.B3V4xUho-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250902/202509021022.B3V4xUho-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509021022.B3V4xUho-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/btrfs/extent_map.c:10:
   fs/btrfs/btrfs_inode.h: In function 'btrfs_set_inode_mapping_order':
>> fs/btrfs/btrfs_inode.h:530:31: warning: unused variable 'fs_info' [-Wunused-variable]
     530 |         struct btrfs_fs_info *fs_info = inode->root->fs_info;
         |                               ^~~~~~~
--
   In file included from fs/btrfs/tests/../transaction.h:15,
                    from fs/btrfs/tests/delayed-refs-tests.c:4:
   fs/btrfs/tests/../btrfs_inode.h: In function 'btrfs_set_inode_mapping_order':
>> fs/btrfs/tests/../btrfs_inode.h:530:31: warning: unused variable 'fs_info' [-Wunused-variable]
     530 |         struct btrfs_fs_info *fs_info = inode->root->fs_info;
         |                               ^~~~~~~


vim +/fs_info +530 fs/btrfs/btrfs_inode.h

   527	
   528	static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
   529	{
 > 530		struct btrfs_fs_info *fs_info = inode->root->fs_info;
   531		/* Metadata inode should not reach here. */
   532		ASSERT(is_data_inode(inode));
   533	
   534		/* We only allow BITS_PER_LONGS blocks for each bitmap. */
   535	#ifdef CONFIG_BTRFS_EXPERIMENTAL
   536		mapping_set_folio_order_range(inode->vfs_inode.i_mapping, fs_info->block_min_order,
   537					      fs_info->block_max_order);
   538	#endif
   539	}
   540	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


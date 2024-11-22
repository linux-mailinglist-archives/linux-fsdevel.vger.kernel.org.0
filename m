Return-Path: <linux-fsdevel+bounces-35543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB459D593E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 07:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A503B22F03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC5C170A01;
	Fri, 22 Nov 2024 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8BPAbAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DC376F1;
	Fri, 22 Nov 2024 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732255677; cv=none; b=Q3oY/7y9OGYoGM+frm/JGofGWR3ZtRMkWGCvYunlAyj3VBWBa2MHA0VIBi2dpfVT2ZLTZVb0KUN/Nx+bJlvf/pM/kswnLuxlyCpdbCzviH56leTArJVS9R3cIqE2Vud1Z0pIPHBhZ8k15YcyjQGkgaVPFYp5QtpO/icaq2V4H28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732255677; c=relaxed/simple;
	bh=PdOiAaswSVXNtBFTnHQFz/h1L9gKw8twpWDYv8mq0J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls6FYXaP4Kcf5GWmfH1vCZQv2Mm5dNEws6GWiE30vf01F2Tkz2PZcjt0TXbmSO0BxZQjMDmFItM/xpBpNs+HLvMX1U5nbssQGauFKE/3ENQcjUaKKrA9YCHRK97CBKC00esbwidTtzQySSI962pvvDtTvPRU72jAkpnKVpG5GiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8BPAbAZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732255676; x=1763791676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PdOiAaswSVXNtBFTnHQFz/h1L9gKw8twpWDYv8mq0J0=;
  b=U8BPAbAZNJMUEBSflHq/narLMvbKAD6AYqeG+FAO1LlHwkglMlL/zKsM
   Q0S6ZDpuXOdqJH6Y95nxHCM4fIdMCdu6q9XzqY4gxHwgbPkpimhhRlPAD
   oRGFsa7ErXaJT3yJBcVF8e/UWfPO4pl5YR58M/5GG/htb9vAHnEkcftnP
   BTajXjzULNYVK/3GUimy+Kz1Phev/jChj1n0bGHafz6HnkFwI0L9g8LgD
   rNklLtswF5p31j0PHRsb+qG4OpemGojeRZf50iTcGnnyhmSDkHOd6WHZM
   Tc70ImIT4jyW3ONoe9eyF5QnmaZQAJO8IySNCoKzrT+VDENy1F5FD7SaW
   w==;
X-CSE-ConnectionGUID: Nqnqu38oSBKdXAPZpO81zA==
X-CSE-MsgGUID: 8tlfL79STJa+T4SGotiddA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43462466"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="43462466"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 22:07:54 -0800
X-CSE-ConnectionGUID: PLNtIHXbSSW2pxH4jx++fA==
X-CSE-MsgGUID: IgErV6zhTym+m/Np/FKfSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="90466297"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Nov 2024 22:07:52 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEMpZ-0003ih-15;
	Fri, 22 Nov 2024 06:07:49 +0000
Date: Fri, 22 Nov 2024 14:07:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
Message-ID: <202411221326.eoWoxSKf-lkp@intel.com>
References: <20241121123855.645335-3-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121123855.645335-3-ojaswin@linux.ibm.com>

Hi Ojaswin,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on brauner-vfs/vfs.all jack-fs/for_next linus/master v6.12 next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ojaswin-Mujoo/quota-flush-quota_release_work-upon-quota-writeback/20241121-204331
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20241121123855.645335-3-ojaswin%40linux.ibm.com
patch subject: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
config: arc-randconfig-001-20241122 (https://download.01.org/0day-ci/archive/20241122/202411221326.eoWoxSKf-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411221326.eoWoxSKf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411221326.eoWoxSKf-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ext4/super.c: In function 'ext4_acquire_dquot':
>> fs/ext4/super.c:6912:13: error: 'freeze_protected' undeclared (first use in this function); did you mean 'freeze_processes'?
    6912 |         if (freeze_protected)
         |             ^~~~~~~~~~~~~~~~
         |             freeze_processes
   fs/ext4/super.c:6912:13: note: each undeclared identifier is reported only once for each function it appears in


vim +6912 fs/ext4/super.c

  6893	
  6894	static int ext4_acquire_dquot(struct dquot *dquot)
  6895	{
  6896		int ret, err;
  6897		handle_t *handle;
  6898	
  6899		handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
  6900					    EXT4_QUOTA_INIT_BLOCKS(dquot->dq_sb));
  6901		if (IS_ERR(handle))
  6902			return PTR_ERR(handle);
  6903		ret = dquot_acquire(dquot);
  6904		if (ret < 0)
  6905			ext4_error_err(dquot->dq_sb, -ret,
  6906				      "Failed to acquire dquot type %d",
  6907				      dquot->dq_id.type);
  6908		err = ext4_journal_stop(handle);
  6909		if (!ret)
  6910			ret = err;
  6911	
> 6912		if (freeze_protected)
  6913			sb_end_intwrite(dquot->dq_sb);
  6914	
  6915		return ret;
  6916	}
  6917	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


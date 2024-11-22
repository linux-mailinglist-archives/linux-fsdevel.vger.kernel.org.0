Return-Path: <linux-fsdevel+bounces-35542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0B69D591A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 06:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0442830D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 05:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2EC1632C2;
	Fri, 22 Nov 2024 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtuaoBJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039413C3D6;
	Fri, 22 Nov 2024 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732253156; cv=none; b=cVptJPN+r2Zl+ab57rka6JXtmwAJSZQe8xgUwhH1sp6CY2J4IXxLxLSX5qAuY9cyD7qYQMZED6U4yC1g3kABIq9s2Ck1IS0vv250j5rNLjPPCeWl3zeRiTLWozm/KM+9rQp/va3SbA7OsJ77tvwt68URqVOV3I4BWpG+vSokHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732253156; c=relaxed/simple;
	bh=jfouwNKiq6I0rT6PIrM3V66NZunqhYiTrtxFRTjDejw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHeiTUmFdHhVKxuk8ROo6EwavoK6ZqEWd1P81ZSpdoUEcxUUeXhJ2zLWcaSDw1J+7Vn2XupUFqf4J04gpq7FvOLEnLgDdQvLAVbPUdSnBtD2sseIP72JWd/77KhIqCGKzsejytvN5ArFFxZSuSs6JMO2RrKJDaK2FjjmQoskymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtuaoBJp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732253152; x=1763789152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jfouwNKiq6I0rT6PIrM3V66NZunqhYiTrtxFRTjDejw=;
  b=WtuaoBJp5reWbZ9V+elUcfCTen9npSk+C/YJz/ccDoyS/dpVoeq2m5WS
   NZnBveBJxyFQoERyzLuP+uzlsWVI8+JTeJs2Rk4ulKmAIy7jh6UW0dOOP
   2zvibaD3mk5kBkC1m7DLgNHF4Em8eHmaLJdF0Pn4JZxI02lFU+MuBox8s
   dkK/hDP8SnOLhSi4cZ105TIEZDAX8VQeBgphCl/lB2Pm40JVdOncCy/sD
   t6Kgwh0DpRFiYqI7V8oUrj66ic0nBi/VDGjer6PO5l3dOQQKZexPMgZ8k
   p+Vnz/CqcN54WnDP0DBPaJliEMXvSAXAJJ3VwlDIeRvd3Sq99cDCLH5N9
   g==;
X-CSE-ConnectionGUID: OHlJlS2VQjOjyChMOhOgYg==
X-CSE-MsgGUID: N+gA8MjsROuVrqGSb+V5Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="35255653"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="35255653"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 21:25:51 -0800
X-CSE-ConnectionGUID: B7aXpogaSZezi4g4yJXrxw==
X-CSE-MsgGUID: ZNQcJWJ1Syym179desVAGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="121342598"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2024 21:25:48 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEMAr-0003hT-2N;
	Fri, 22 Nov 2024 05:25:45 +0000
Date: Fri, 22 Nov 2024 13:25:37 +0800
From: kernel test robot <lkp@intel.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
Message-ID: <202411221352.NvzmPEy3-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20241122 (https://download.01.org/0day-ci/archive/20241122/202411221352.NvzmPEy3-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411221352.NvzmPEy3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411221352.NvzmPEy3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/ext4/super.c:27:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/ext4/super.c:6912:6: error: use of undeclared identifier 'freeze_protected'; did you mean 'freeze_processes'?
    6912 |         if (freeze_protected)
         |             ^~~~~~~~~~~~~~~~
         |             freeze_processes
   include/linux/freezer.h:46:12: note: 'freeze_processes' declared here
      46 | extern int freeze_processes(void);
         |            ^
   1 warning and 1 error generated.


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


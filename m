Return-Path: <linux-fsdevel+bounces-52896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F68AE80A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 13:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BA168B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1D72BEC2B;
	Wed, 25 Jun 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBWXkvij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238929ACF9;
	Wed, 25 Jun 2025 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849893; cv=none; b=hsygjHZunpiZ96mZEWIEPBJUQstb/Wdkd5teZMlteuD07rrM4i8hIrM8oI2hUylYFYAWvLXzh1AteFbcrYanI1ncwhBvNN64LC/km5svoNgM4OJSeFVU4rF0uUMatWDlbToFvZxOC6zsZALTAEwmtxo1pDm80K8WyHo9I7N8+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849893; c=relaxed/simple;
	bh=P4G3trloAWpcB1GNXQBtfIed3GuOFg6SZBVv40Mj4BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlQnTznTSvrQZY+WbNfDEOiBbUBXeRVbvatcuvAHHkjRK7JEd0DupLnbPEUrPZLsTPjB2oUb7KH6n4GBP+rMY1lA2vfALtIPQIb8vxmneSeH9MVjju2w2zLN+BdjWvXqSD9l0PCDXhwp4EyhCjvmggylU8ad8/ihAOmiRsKDV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBWXkvij; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750849892; x=1782385892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P4G3trloAWpcB1GNXQBtfIed3GuOFg6SZBVv40Mj4BI=;
  b=fBWXkvij12kXhZu9oxoK/CP/wuxRca84yA3qj8BRbF80bfcyuRGj5Puu
   vKJr8hzZPR2jI7YrZwSKT9eIuktoEy9CC1VtW8ttv78D3SOnJyVlht+jW
   Da6GVx1lIislx1nW5cNTF8sgtmN2wBCNBB444ahjASVpy5LwwTB0I63CF
   UGvvnV2Rawm14I2F/9ZMOEv12jWl52AZqVWBh2ftPEOu7gwnfEbPBc0af
   kAFg9qmwcnt8HZwEn2lCLtQAhE4dQjkFgFItyuxQaLutiKA9whvhyXQrJ
   t34Q6AzFGEqROucHKKD5CKtsjNuKGWJjDOsgLLMsJM1l4MoH1T1Szovcv
   g==;
X-CSE-ConnectionGUID: Z8+0V3uCRbOb0a1hZrTmuw==
X-CSE-MsgGUID: FMWgKP3MSd2cTeBdC1LVmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53180219"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53180219"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:11:31 -0700
X-CSE-ConnectionGUID: 3E/jnHXVQRmZNSmNFnk2kQ==
X-CSE-MsgGUID: zFE+wDJOSUGEa8J01jfj2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152318891"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 Jun 2025 04:11:28 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUO2I-000T2o-0E;
	Wed, 25 Jun 2025 11:11:26 +0000
Date: Wed, 25 Jun 2025 19:10:31 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, djwong@kernel.org, anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v3 12/16] fuse: use iomap for buffered writes
Message-ID: <202506251857.gt3y42uZ-lkp@intel.com>
References: <20250624022135.832899-13-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-13-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on xfs-linux/for-next linus/master v6.16-rc3 next-20250625]
[cannot apply to gfs2/for-next mszeredi-fuse/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/iomap-pass-more-arguments-using-struct-iomap_writepage_ctx/20250624-102709
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250624022135.832899-13-joannelkoong%40gmail.com
patch subject: [PATCH v3 12/16] fuse: use iomap for buffered writes
config: arm64-randconfig-003-20250625 (https://download.01.org/0day-ci/archive/20250625/202506251857.gt3y42uZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250625/202506251857.gt3y42uZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506251857.gt3y42uZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_cache_write_iter':
>> file.c:(.text+0x880c): undefined reference to `iomap_file_buffered_write'
>> file.c:(.text+0x880c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_file_buffered_write'
>> aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x360): undefined reference to `iomap_release_folio'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


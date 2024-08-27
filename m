Return-Path: <linux-fsdevel+bounces-27459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42904961973
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBB3285210
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4291D414F;
	Tue, 27 Aug 2024 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyiBWm8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C51D3631
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795542; cv=none; b=LUOSyRJG2txZkCGzJEbPCpG3VHr+FSRhwWf5dJEFjCUB3nPuq7hqe4/sRki3+EbUXnnBoSUwiKmzGkSM8OZ5embNQ0/yNlfIx8H6diUz0bDUGJffD+Xt6IOO/HUYdNUXTjldSpehlx5JsQTx/ClFxCFE18b+jYmPOn6Bg/mPk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795542; c=relaxed/simple;
	bh=dkzf2aDi4L8Ri6W/1MIwZYUaW+wPvWex3hg2ipdUIlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD3MnpMb7N+h8vgjHDAuff57o+adb9HklPHxb9izzwJiqIElaybdrPKUh5dHkLWFfEDB6d3QRAZ6D3RyGFSrviBx4y3e9DL0Cb9QdYekJsFUVtT30PKphLQOUVswIoFPW4Wu/mgmp7A1zS0q3lY3X5vveG27dOt6rlf9RdutTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyiBWm8k; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724795541; x=1756331541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dkzf2aDi4L8Ri6W/1MIwZYUaW+wPvWex3hg2ipdUIlg=;
  b=QyiBWm8kd2rsQfuBwLK5nb9Uxrr3cU20kZrNyWjA5wTds9ENPmEyvbnJ
   2xtjJ4Cl6lA8P9TfXSqgRtihcd5BLbD3J2U7gOaQ7SGcrhAFFFxsD9cUC
   u7RVG62rornyPRgC78W1QfOaUAivOeNt+KiWLCU5GhdVG33Z6iT6KumLE
   FCOFPvVAS4EijYH1QYHONJPTxZqJHTBDELDblIFjpF/Qu5haulTnPvRRE
   b9WVBsqZwbd/5ty3s05iCqH0Lnb1uTN1dTFqpcYypaiYsKzYZtNfezGvG
   Dbx/NfPdjFYSJvV/QtlwqOXyciB7fn3z0RShnxGsUXlVfztRBZg96jXNa
   Q==;
X-CSE-ConnectionGUID: 3Mus+536RnWiCS0Oc9qDkw==
X-CSE-MsgGUID: D3Hlog1dQIu+HFF4GPWsjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27094274"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="27094274"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:52:21 -0700
X-CSE-ConnectionGUID: 3FERiylgSFSxt4iwDgOkfA==
X-CSE-MsgGUID: /vDw5U+9ReqbtFmKUtiwFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63002571"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2024 14:52:18 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj46q-000K7G-0C;
	Tue, 27 Aug 2024 21:52:16 +0000
Date: Wed, 28 Aug 2024 05:51:56 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v5 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
Message-ID: <202408280419.yuu33o7t-lkp@intel.com>
References: <20240826203234.4079338-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826203234.4079338-3-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v6.11-rc5 next-20240827]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-add-optional-kernel-enforced-timeout-for-requests/20240827-043354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20240826203234.4079338-3-joannelkoong%40gmail.com
patch subject: [PATCH v5 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
config: arc-randconfig-002-20240827 (https://download.01.org/0day-ci/archive/20240828/202408280419.yuu33o7t-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280419.yuu33o7t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280419.yuu33o7t-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/fuse/sysctl.c:30:5: error: redefinition of 'fuse_sysctl_register'
      30 | int fuse_sysctl_register(void)
         |     ^~~~~~~~~~~~~~~~~~~~
   In file included from fs/fuse/sysctl.c:9:
   fs/fuse/fuse_i.h:1495:19: note: previous definition of 'fuse_sysctl_register' with type 'int(void)'
    1495 | static inline int fuse_sysctl_register(void) { return 0; }
         |                   ^~~~~~~~~~~~~~~~~~~~
>> fs/fuse/sysctl.c:38:6: error: redefinition of 'fuse_sysctl_unregister'
      38 | void fuse_sysctl_unregister(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/fuse_i.h:1496:20: note: previous definition of 'fuse_sysctl_unregister' with type 'void(void)'
    1496 | static inline void fuse_sysctl_unregister(void) { return; }
         |                    ^~~~~~~~~~~~~~~~~~~~~~


vim +/fuse_sysctl_register +30 fs/fuse/sysctl.c

    29	
  > 30	int fuse_sysctl_register(void)
    31	{
    32		fuse_table_header = register_sysctl("fs/fuse", fuse_sysctl_table);
    33		if (!fuse_table_header)
    34			return -ENOMEM;
    35		return 0;
    36	}
    37	
  > 38	void fuse_sysctl_unregister(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


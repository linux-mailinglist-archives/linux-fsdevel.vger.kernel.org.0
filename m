Return-Path: <linux-fsdevel+bounces-24587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C86940A33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11D51C23212
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A11190667;
	Tue, 30 Jul 2024 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETc2Vx0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7108190497
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325774; cv=none; b=LJkOxe001WvucBF5IroE5qC+PnjJ0aRaLX9J7Fw3b9ar4ip6QNfUy86u8q3tq/5zClrQbvJ4YVUOEhbeZTNxTVfLQ9g06DgNiLam/9v89DqqT+uvyGPCtUCyI4lCE+orT+9/ov+etsr5WznT49S3DBupFO14ix08QknRnIPvNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325774; c=relaxed/simple;
	bh=Cpc9+KNt2kuD9XBVB2X8qiD3/P2HWXSVYh3TymEO7d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTDWV9NHJDaoDHf96/PZTLU9AjAts0U6Gug53o4HRbwtdnnU8O82rUOQ7EwyxLZyHB2acLLTImXOlRrUm7n7AE106nUYy4j25e50cFBFUxxVzPPgqyGFY7+X8R49bzD6Uj/NYk/K2swC4beRJrGIgelRPTdOiyaiaSUCt+Ys77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETc2Vx0M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722325772; x=1753861772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cpc9+KNt2kuD9XBVB2X8qiD3/P2HWXSVYh3TymEO7d4=;
  b=ETc2Vx0M9hIEUPGgh/8Oq5lijV49avcVB+zj8AaDYtwwZKzyqVr+Vwe7
   XxJe2HDo8HreWXIGkEgAuaeDm2cFAfKPHdXCgLS8ETkkwIcE78H56UHJ8
   F1IC/Krp+cOW5EfWyrzGx2dqlEqSmXqwNnA+HUGOi8oMzjzRD3gEOksZ3
   WmCNHmGBc6V8OzfeQwuj0mazTDSv99w3mS4aMmm3PevJeMEe4VwDLWqyf
   8rq4cMaAX7TTe/mza+1k6CCRYihuxrCj/UnKT/BjJugMCeMXVcTHUIfYA
   oyPNHGjMkGcOWlsC5uY9agFpKoxnZxTgI+1/FHUPpQgEYJOsnT2UT8lzK
   w==;
X-CSE-ConnectionGUID: JH5mhbYHQTuwOt5+RKgDwA==
X-CSE-MsgGUID: gv27neNAR9iN6mKIH9dDuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37634274"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="37634274"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 00:49:32 -0700
X-CSE-ConnectionGUID: 1Ayf5Tn3R7yRbs1nay1xFw==
X-CSE-MsgGUID: iNHTh/i7SaSpF0FFuRRKeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="84893779"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2024 00:49:29 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYhbq-000sdE-2o;
	Tue, 30 Jul 2024 07:49:26 +0000
Date: Tue, 30 Jul 2024 15:49:16 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
Message-ID: <202407301513.fphdIYEE-lkp@intel.com>
References: <20240730002348.3431931-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730002348.3431931-3-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v6.11-rc1 next-20240730]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-add-optional-kernel-enforced-timeout-for-requests/20240730-085106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20240730002348.3431931-3-joannelkoong%40gmail.com
patch subject: [PATCH v2 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
config: i386-buildonly-randconfig-001-20240730 (https://download.01.org/0day-ci/archive/20240730/202407301513.fphdIYEE-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407301513.fphdIYEE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407301513.fphdIYEE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> fs/fuse/sysctl.c:30:30: error: macro "fuse_sysctl_register" passed 1 arguments, but takes just 0
      30 | int fuse_sysctl_register(void)
         |                              ^
   In file included from fs/fuse/sysctl.c:9:
   fs/fuse/fuse_i.h:1501: note: macro "fuse_sysctl_register" defined here
    1501 | #define fuse_sysctl_register()          (0)
         | 
>> fs/fuse/sysctl.c:31:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      31 | {
         | ^
>> fs/fuse/sysctl.c:38:33: error: macro "fuse_sysctl_unregister" passed 1 arguments, but takes just 0
      38 | void fuse_sysctl_unregister(void)
         |                                 ^
   fs/fuse/fuse_i.h:1502: note: macro "fuse_sysctl_unregister" defined here
    1502 | #define fuse_sysctl_unregister()        do { } while (0)
         | 
   fs/fuse/sysctl.c:39:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      39 | {
         | ^
>> fs/fuse/sysctl.c:13:25: warning: 'fuse_sysctl_table' defined but not used [-Wunused-variable]
      13 | static struct ctl_table fuse_sysctl_table[] = {
         |                         ^~~~~~~~~~~~~~~~~
>> fs/fuse/sysctl.c:11:33: warning: 'fuse_table_header' defined but not used [-Wunused-variable]
      11 | static struct ctl_table_header *fuse_table_header;
         |                                 ^~~~~~~~~~~~~~~~~


vim +/fuse_sysctl_register +30 fs/fuse/sysctl.c

    10	
  > 11	static struct ctl_table_header *fuse_table_header;
    12	
  > 13	static struct ctl_table fuse_sysctl_table[] = {
    14		{
    15			.procname	= "default_request_timeout",
    16			.data		= &fuse_default_req_timeout,
    17			.maxlen		= sizeof(fuse_default_req_timeout),
    18			.mode		= 0644,
    19			.proc_handler	= proc_douintvec,
    20		},
    21		{
    22			.procname	= "max_request_timeout",
    23			.data		= &fuse_max_req_timeout,
    24			.maxlen		= sizeof(fuse_max_req_timeout),
    25			.mode		= 0644,
    26			.proc_handler	= proc_douintvec,
    27		},
    28	};
    29	
  > 30	int fuse_sysctl_register(void)
  > 31	{
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


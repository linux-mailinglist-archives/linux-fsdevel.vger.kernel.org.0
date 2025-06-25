Return-Path: <linux-fsdevel+bounces-52955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBE9AE8B2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E592D5A7B18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2E12DAFDA;
	Wed, 25 Jun 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLLPqjHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CD28D8FE;
	Wed, 25 Jun 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870989; cv=none; b=MdNjlUINSSPjhQC24zbLqAaoVlSpZrMLHIpZoEfPcaOGCcf6iSHyvoPRCfmErDm1DAmJJ3lRPhc765MvXxKfAnl1v+UGxlyctVwPBJ1CVka+Peu6j3sani4AvQuLJdwaqTaQXyY5kTinbntlzthI2JVT8nJmG2sPnzbRTm6Ao2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870989; c=relaxed/simple;
	bh=0+ImX5Z5+yST+Npw31q/8a7InEoeRMTLz6Y4D6JHFtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxU3e9j/0PZSAwl7LUBgyG1gcPJg44tY6emQ84Aa7q60jl1NvoGgUjtcLn03+R9Dxu1wU1cxDmGPZ0PwRVnaqOJIGfqE0WghSlLVeRY/UsRIrBYichap8wstFvWUOxTegIAGPE4mXYyQddZK7Fvae5JLG8y2KWTlA3BoCoVn1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLLPqjHW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750870988; x=1782406988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0+ImX5Z5+yST+Npw31q/8a7InEoeRMTLz6Y4D6JHFtI=;
  b=dLLPqjHWXaGqeSnjkuEa1a7bz8sbdqIX/773yiy+IXxJsinUJ/Jr3VqB
   6VhcSuC6lSW8TeAjvBobWFu/At+rE/fNKhwhQdjfe0FNbHohs/D/WxMz+
   a7GRfgLjqLjdwi3KKIT5M/biLWNss/AY0YA5giqTf7i+HOLuIdMDJKpIy
   TPbNdudHtcOCiRqK5L4sqDl1tRqv/hZnMsK5rQ1UvEe/O3kER5asOx5Kk
   l17++GzDo60pbDprtFPIV8uhdT1hCnM4rwkFY2iB5eQsSl9z7I06NL/bq
   xgCQgA/nqeD1W7Vg+ISanyJm4zO9MGyauy4wOMTLN1nckR38ryqrNb8+Q
   g==;
X-CSE-ConnectionGUID: 4vIlUPlDQDmI4VsvWzq/1g==
X-CSE-MsgGUID: 7FsA+Na/RLWpQ5EGg90yow==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="78581520"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="78581520"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:03:07 -0700
X-CSE-ConnectionGUID: gy67ZgwNTDKWcXsuBplZwg==
X-CSE-MsgGUID: e9r7QM1LQyqQI9aTuVfkMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="157767066"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 10:03:04 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUTWY-000TLm-0J;
	Wed, 25 Jun 2025 17:03:02 +0000
Date: Thu, 26 Jun 2025 01:02:51 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, djwong@kernel.org, anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v3 14/16] fuse: use iomap for folio laundering
Message-ID: <202506260003.qJL8KxcS-lkp@intel.com>
References: <20250624022135.832899-15-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-15-joannelkoong@gmail.com>

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
patch link:    https://lore.kernel.org/r/20250624022135.832899-15-joannelkoong%40gmail.com
patch subject: [PATCH v3 14/16] fuse: use iomap for folio laundering
config: arm64-randconfig-003-20250625 (https://download.01.org/0day-ci/archive/20250626/202506260003.qJL8KxcS-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506260003.qJL8KxcS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506260003.qJL8KxcS-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepages':
   file.c:(.text+0xbf0): undefined reference to `iomap_writepages'
   file.c:(.text+0xbf0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_writepages'
   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepage_finish':
   file.c:(.text+0x1fd8): undefined reference to `iomap_finish_folio_write'
   file.c:(.text+0x1fd8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_finish_folio_write'
   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_cache_write_iter':
   file.c:(.text+0x888c): undefined reference to `iomap_file_buffered_write'
   file.c:(.text+0x888c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_file_buffered_write'
   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_launder_folio':
>> file.c:(.text+0x8f74): undefined reference to `iomap_writeback_folio'
>> file.c:(.text+0x8f74): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_writeback_folio'
   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_iomap_writeback_range':
   file.c:(.text+0x90d8): undefined reference to `iomap_start_folio_write'
   file.c:(.text+0x90d8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_start_folio_write'
   aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x370): undefined reference to `iomap_dirty_folio'
   aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x3a0): undefined reference to `iomap_release_folio'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


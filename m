Return-Path: <linux-fsdevel+bounces-54341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E3DAFE3B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0291C4052E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E0283FEB;
	Wed,  9 Jul 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzW535K+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C0271443;
	Wed,  9 Jul 2025 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052211; cv=none; b=NLrTLLSLR5E2p3qJ9Pnt9GCseieRJiqQesEmuIxkvZqb/F1HRHJ4h4MbyfxUGAOZZBQderHCdz1x4ufJzuVV9K185KgKKNjWyWmt3BAbt5CD9A88M9lbOC+g0FYh3uY0puT5T80RaowmubNcNkXMfJJqhq+CBEGX0yaKha3zzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052211; c=relaxed/simple;
	bh=IJjJgM4OeRcDQZbbuj3g79bHehoQC7+ut1sOtWZkbZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okCDQxW0jI0GlMzkSwtRKb/4YIxvVjCkHOgRTNhSJkCYQxOfRKcPm74CtVU9zOrlR4Qaq33QftQC72GcaIkXnSlNQ7egGxy5OkePpioXJvzOSq/WhDB0uGb2/yzGdbIcNsm2lC3rEbdG6vkFAr1PYzHY7+oiyRqrsw5OKtSXJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzW535K+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752052210; x=1783588210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IJjJgM4OeRcDQZbbuj3g79bHehoQC7+ut1sOtWZkbZs=;
  b=QzW535K+xfDaHCNexMYzWVCUvLjy2T+RkUb3NyQa1550zSztnkeh8TGn
   3fcICDvc3vbCF+6xYGyvQGBgYzYoVOI9PP6ESL8LO3hDHCo5YwzGvs7OJ
   7fcQgL3hDjE75xmurGu/xxBtPWRqaSaAyTEtgc+VMHFldojTxmPiEGWoa
   yhhGpS50Odmqhp43lnSVi0r/Sap4pEMGgw3oNZLGDAoSPEXiCal4/kU3i
   eeS5Wj8y07Kve6GR/OHwOJjOje6DUT5mYnXzq42Dey2nOG21OqjO7plJP
   j/YW1PXgd3dfgDzYpnNyNeOvdZ3+PI+JIgyNDLNtd8Y6hn3W0njQXSsEy
   Q==;
X-CSE-ConnectionGUID: +aJockTGRDqTm4GMhZ330A==
X-CSE-MsgGUID: 8OLsZH+aQy+dUUhUM8it6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54163374"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54163374"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:10:09 -0700
X-CSE-ConnectionGUID: 3G6X9a/9QZGs4/E1Nu1G6A==
X-CSE-MsgGUID: 8VeCwGwHRoyx12QvGTKIaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155458330"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Jul 2025 02:10:07 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZQoW-0003Kz-1d;
	Wed, 09 Jul 2025 09:10:04 +0000
Date: Wed, 9 Jul 2025 17:09:19 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 01/14] iomap: header diet
Message-ID: <202507091656.dMTKUTBY-lkp@intel.com>
References: <20250708135132.3347932-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708135132.3347932-2-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on xfs-linux/for-next gfs2/for-next linus/master v6.16-rc5 next-20250708]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/iomap-pass-more-arguments-using-the-iomap-writeback-context/20250708-225155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250708135132.3347932-2-hch%40lst.de
patch subject: [PATCH 01/14] iomap: header diet
config: arc-randconfig-001-20250709 (https://download.01.org/0day-ci/archive/20250709/202507091656.dMTKUTBY-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250709/202507091656.dMTKUTBY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507091656.dMTKUTBY-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/iomap/buffered-io.c: In function 'iomap_dirty_folio':
>> fs/iomap/buffered-io.c:642:9: error: implicit declaration of function 'filemap_dirty_folio'; did you mean 'iomap_dirty_folio'? [-Werror=implicit-function-declaration]
     return filemap_dirty_folio(mapping, folio);
            ^~~~~~~~~~~~~~~~~~~
            iomap_dirty_folio
   fs/iomap/buffered-io.c: In function 'iomap_write_iter':
>> fs/iomap/buffered-io.c:930:58: error: 'BDP_ASYNC' undeclared (first use in this function); did you mean 'I_SYNC'?
     unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
                                                             ^~~~~~~~~
                                                             I_SYNC
   fs/iomap/buffered-io.c:930:58: note: each undeclared identifier is reported only once for each function it appears in
>> fs/iomap/buffered-io.c:945:12: error: implicit declaration of function 'balance_dirty_pages_ratelimited_flags' [-Werror=implicit-function-declaration]
      status = balance_dirty_pages_ratelimited_flags(mapping,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_unshare_iter':
>> fs/iomap/buffered-io.c:1309:3: error: implicit declaration of function 'balance_dirty_pages_ratelimited'; did you mean 'pr_alert_ratelimited'? [-Werror=implicit-function-declaration]
      balance_dirty_pages_ratelimited(iter->inode->i_mapping);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      pr_alert_ratelimited
   fs/iomap/buffered-io.c: In function 'iomap_zero_iter':
>> fs/iomap/buffered-io.c:1376:3: error: implicit declaration of function 'folio_mark_accessed'; did you mean 'folio_wait_locked'? [-Werror=implicit-function-declaration]
      folio_mark_accessed(folio);
      ^~~~~~~~~~~~~~~~~~~
      folio_wait_locked
   fs/iomap/buffered-io.c: In function 'iomap_alloc_ioend':
   fs/iomap/buffered-io.c:1624:26: error: implicit declaration of function 'wbc_to_write_flags'; did you mean 'do_pipe_flags'? [-Werror=implicit-function-declaration]
              REQ_OP_WRITE | wbc_to_write_flags(wbc),
                             ^~~~~~~~~~~~~~~~~~
                             do_pipe_flags
   fs/iomap/buffered-io.c:1629:2: error: implicit declaration of function 'wbc_init_bio'; did you mean 'arc_init_IRQ'? [-Werror=implicit-function-declaration]
     wbc_init_bio(wbc, bio);
     ^~~~~~~~~~~~
     arc_init_IRQ
   fs/iomap/buffered-io.c: In function 'iomap_add_to_ioend':
   fs/iomap/buffered-io.c:1748:2: error: implicit declaration of function 'wbc_account_cgroup_owner'; did you mean 'pr_cont_cgroup_name'? [-Werror=implicit-function-declaration]
     wbc_account_cgroup_owner(wbc, folio, len);
     ^~~~~~~~~~~~~~~~~~~~~~~~
     pr_cont_cgroup_name
   fs/iomap/buffered-io.c: In function 'iomap_writepages':
>> fs/iomap/buffered-io.c:1965:18: error: implicit declaration of function 'writeback_iter'; did you mean 'write_lock_irq'? [-Werror=implicit-function-declaration]
     while ((folio = writeback_iter(mapping, wbc, folio, &error)))
                     ^~~~~~~~~~~~~~
                     write_lock_irq
>> fs/iomap/buffered-io.c:1965:16: warning: assignment to 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     while ((folio = writeback_iter(mapping, wbc, folio, &error)))
                   ^
   cc1: some warnings being treated as errors


vim +642 fs/iomap/buffered-io.c

8306a5f5630552 Matthew Wilcox (Oracle  2021-04-28  634) 
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  635) bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  636) {
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  637) 	struct inode *inode = mapping->host;
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  638) 	size_t len = folio_size(folio);
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  639) 
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  640) 	ifs_alloc(inode, folio, 0);
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  641) 	iomap_set_range_dirty(folio, 0, len);
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10 @642) 	return filemap_dirty_folio(mapping, folio);
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  643) }
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  644) EXPORT_SYMBOL_GPL(iomap_dirty_folio);
4ce02c67972211 Ritesh Harjani (IBM     2023-07-10  645) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


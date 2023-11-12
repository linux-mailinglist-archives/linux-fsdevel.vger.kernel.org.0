Return-Path: <linux-fsdevel+bounces-2762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002117E8E62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 05:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AEC1C20869
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 04:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A6E23BD;
	Sun, 12 Nov 2023 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIg+qXqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D523B7
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 04:52:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623432D6B
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 20:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699764778; x=1731300778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KNrqoAhaBmaC8C417KV79YPfsTBe/AyX3hjvicbv0d8=;
  b=GIg+qXqsVPHmv8RcaB1Yfe1W3ZyJEdb6pRIX3MU7dncPA5Kgr7misKgQ
   1Vg+2MR9u64PIJVaftVQMfcHHtvXygf7oCIgpaKSU2NvfuJHI4zPWGDa5
   8CXwO5fhZN06nFg9GwxL/a78GU+Ef007kzQkI4XBwgei5LrABk+osGHPf
   GX2rpBUPrlQRP6malCPetKvupNZTbR1uV5HUoi4l0/imrLvTN0kvGW59x
   KyTqQxvzeQc6XxHU/VDrXVXd8AzuEUxl5EiG1+i1azTV9bOXUnxoC2ciV
   kjxO5s3GiWY0iSmZnifYqScBtbCKu/HvafLHiD5y+89ZnmCDjDMf3MLnX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="454611420"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="454611420"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:52:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="937481356"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="937481356"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Nov 2023 20:52:55 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r22Sq-000Ax4-2K;
	Sun, 12 Nov 2023 04:52:52 +0000
Date: Sun, 12 Nov 2023 12:52:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size >
 PAGE_SIZE
Message-ID: <202311121240.AN8GbAbe-lkp@intel.com>
References: <20231109210608.2252323-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109210608.2252323-4-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master next-20231110]
[cannot apply to v6.6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/buffer-Return-bool-from-grow_dev_folio/20231110-051651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231109210608.2252323-4-willy%40infradead.org
patch subject: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size > PAGE_SIZE
config: hexagon-comet_defconfig (https://download.01.org/0day-ci/archive/20231112/202311121240.AN8GbAbe-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311121240.AN8GbAbe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311121240.AN8GbAbe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __muloti4
   >>> referenced by buffer.c
   >>>               fs/buffer.o:(bdev_getblk) in archive vmlinux.a
   >>> referenced by buffer.c
   >>>               fs/buffer.o:(bdev_getblk) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-2408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7671A7E5C6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951361C2097F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B3328D2;
	Wed,  8 Nov 2023 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLZe7V0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D572321BB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 17:33:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA7B1BE3
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699464814; x=1731000814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EGVZa3uIV7Y1uh056ZyDHWlaLGFFcM7jdHDo+LXgQOM=;
  b=CLZe7V0ROL3nV9iGFGtWCAGz/O3rCsw62jDf81Yaza5zCNbasRJVQF0p
   t1LvcVMob87R+VETd19itL93SzVUPkcuQJ3DQYfmlesgGR1I9h3Mv2oax
   /WIpMAK1vzs2haCX85iVWoRkMNgp1xfn3eqbQaj9MExOQ8w7UmDIuSVGw
   7OLBSGf2xARKWUvVzE5VOyzl5uCPE8DjEOy7nWvfyuRtyh+WYDhtW8IfE
   fnpmdrhkcp+MVMQZ/sglkJyj9ioReV5zFxtIVoSy8OKFWT+tW55ybT0Ja
   vcqeL+sE1nKpA/animD7PkD09udqeF7GDAD9plHIZsToeHlHz/dDmSriV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="454118747"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="454118747"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 09:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="4254657"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Nov 2023 09:33:32 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r0mQj-00085k-0c;
	Wed, 08 Nov 2023 17:33:29 +0000
Date: Thu, 9 Nov 2023 01:30:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] buffer: Calculate block number inside
 folio_init_buffers()
Message-ID: <202311090123.FRvXagQt-lkp@intel.com>
References: <20231107194152.3374087-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107194152.3374087-3-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master next-20231108]
[cannot apply to v6.6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/buffer-Return-bool-from-grow_dev_folio/20231108-035905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231107194152.3374087-3-willy%40infradead.org
patch subject: [PATCH 2/5] buffer: Calculate block number inside folio_init_buffers()
config: i386-randconfig-141-20231108 (https://download.01.org/0day-ci/archive/20231109/202311090123.FRvXagQt-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311090123.FRvXagQt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311090123.FRvXagQt-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/buffer.o: in function `folio_init_buffers':
>> fs/buffer.c:1003: undefined reference to `__divdi3'


vim +1003 fs/buffer.c

   993	
   994	/*
   995	 * Initialise the state of a blockdev folio's buffers.
   996	 */ 
   997	static sector_t folio_init_buffers(struct folio *folio,
   998			struct block_device *bdev, int size)
   999	{
  1000		struct buffer_head *head = folio_buffers(folio);
  1001		struct buffer_head *bh = head;
  1002		bool uptodate = folio_test_uptodate(folio);
> 1003		sector_t block = folio_pos(folio) / size;
  1004		sector_t end_block = blkdev_max_block(bdev, size);
  1005	
  1006		do {
  1007			if (!buffer_mapped(bh)) {
  1008				bh->b_end_io = NULL;
  1009				bh->b_private = NULL;
  1010				bh->b_bdev = bdev;
  1011				bh->b_blocknr = block;
  1012				if (uptodate)
  1013					set_buffer_uptodate(bh);
  1014				if (block < end_block)
  1015					set_buffer_mapped(bh);
  1016			}
  1017			block++;
  1018			bh = bh->b_this_page;
  1019		} while (bh != head);
  1020	
  1021		/*
  1022		 * Caller needs to validate requested block against end of device.
  1023		 */
  1024		return end_block;
  1025	}
  1026	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-36158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864EF9DE9D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 16:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CF9280E43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A9149C4D;
	Fri, 29 Nov 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEbhqk2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E463145A17;
	Fri, 29 Nov 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895003; cv=none; b=Hakqp3qXxpnEjAcOgZgD5czBMNWkJSwlOACJ6+bNhCo3jqD/nSt1iqNmXFplyoCtjfQFhQYFyxSKBmRVtPEMOAeJYLAwffpkySsXhntjQ2mc/NxZDuRrb/WqapNgQ5zRyeon0JdJzl4hLwYHGlb3mPToCFmYGTaeMcGtNKtG/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895003; c=relaxed/simple;
	bh=9ZR8meMzxqoVA1ARLMYuDfRXGJGKTDRavNgddjOtIR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngdSEj1yZrPrHqp3Fj8JtGTg3pRxYo03uTJRR55Z9vHE83NvWngCjb1yFos7UBZDXXfHa5cyf+BaMbsGM2/bG/guK9MSJ3ArctZOwjE5WZlyNJgo3FTiFQUgpdyLmtKNFqPlIUFs0JUlrQabkMXK2uT7w52qlF7ZpFKJ/Y0HRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEbhqk2G; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732895000; x=1764431000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ZR8meMzxqoVA1ARLMYuDfRXGJGKTDRavNgddjOtIR4=;
  b=ZEbhqk2GRphT4pel5lSIsW9q3MAa5nt9zf2fD4gdXN8ubROUwT4ongoL
   D2v4sw/9SYt+DIMRRrHTH2R+3FIsQ54V5RCWcD4s2DqsPVoEPAeT4Kv4y
   itJlVC16CLVO/nAm7ePS+W97a4mq9xDMhyZf1kec9VVorgJ5f/QVbW4QD
   tUDOW7XSFLU+glxnudx33E4ZIl0Yi/uOwuInkD3NONmVt2RuZryKr1kG4
   PEARJbj/3f/YI7IpxNyLXtGlGXlb6YL4sonJQkRAhBqnotLycgbzteKXF
   4HiFqEwCvypYqRgCnumZxg4JH0kyCv75DjKbXTYogNWInvLO6hIO0r/xR
   g==;
X-CSE-ConnectionGUID: 6NbtZjFJTCmvrpBCXvXvrQ==
X-CSE-MsgGUID: ofqV0DG2TRyI+ZeMreUDrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="35995819"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="35995819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 07:43:19 -0800
X-CSE-ConnectionGUID: 9pqMYTlqQ+yd1qxvuew+Hw==
X-CSE-MsgGUID: IG1KKfyRSlS+g6yX1kimSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97555294"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Nov 2024 07:43:16 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tH39G-0000T9-0g;
	Fri, 29 Nov 2024 15:43:14 +0000
Date: Fri, 29 Nov 2024 23:42:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 5/5] ceph: Use a folio in ceph_writepages_start()
Message-ID: <202411292322.iv4hDiEQ-lkp@intel.com>
References: <20241129055058.858940-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129055058.858940-6-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20241128]
[cannot apply to ceph-client/testing ceph-client/for-linus v6.12]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/ceph-Do-not-look-at-the-index-of-an-encrypted-page/20241129-135252
base:   linus/master
patch link:    https://lore.kernel.org/r/20241129055058.858940-6-willy%40infradead.org
patch subject: [PATCH 5/5] ceph: Use a folio in ceph_writepages_start()
config: x86_64-buildonly-randconfig-002-20241129 (https://download.01.org/0day-ci/archive/20241129/202411292322.iv4hDiEQ-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411292322.iv4hDiEQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411292322.iv4hDiEQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ceph/addr.c:4:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/ceph/addr.c:1178:39: warning: variable 'page' is uninitialized when used here [-Wuninitialized]
    1178 |                                         fscrypt_encrypt_pagecache_blocks(page,
         |                                                                          ^~~~
   fs/ceph/addr.c:1043:20: note: initialize the variable 'page' to silence this warning
    1043 |                 struct page *page;
         |                                  ^
         |                                   = NULL
   4 warnings generated.


vim +/page +1178 fs/ceph/addr.c

1d3576fd10f0d7a Sage Weil               2009-10-06   941  
1d3576fd10f0d7a Sage Weil               2009-10-06   942  /*
1d3576fd10f0d7a Sage Weil               2009-10-06   943   * initiate async writeback
1d3576fd10f0d7a Sage Weil               2009-10-06   944   */
1d3576fd10f0d7a Sage Weil               2009-10-06   945  static int ceph_writepages_start(struct address_space *mapping,
1d3576fd10f0d7a Sage Weil               2009-10-06   946  				 struct writeback_control *wbc)
1d3576fd10f0d7a Sage Weil               2009-10-06   947  {
1d3576fd10f0d7a Sage Weil               2009-10-06   948  	struct inode *inode = mapping->host;
1d3576fd10f0d7a Sage Weil               2009-10-06   949  	struct ceph_inode_info *ci = ceph_inode(inode);
5995d90d2d19f33 Xiubo Li                2023-06-12   950  	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
38d46409c4639a1 Xiubo Li                2023-06-12   951  	struct ceph_client *cl = fsc->client;
fc2744aa12da718 Yan, Zheng              2013-05-31   952  	struct ceph_vino vino = ceph_vino(inode);
2a2d927e35dd8dc Yan, Zheng              2017-09-01   953  	pgoff_t index, start_index, end = -1;
80e755fedebc8de Sage Weil               2010-03-31   954  	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04   955) 	struct folio_batch fbatch;
1d3576fd10f0d7a Sage Weil               2009-10-06   956  	int rc = 0;
93407472a21b82f Fabian Frederick        2017-02-27   957  	unsigned int wsize = i_blocksize(inode);
1d3576fd10f0d7a Sage Weil               2009-10-06   958  	struct ceph_osd_request *req = NULL;
1f934b00e907527 Yan, Zheng              2017-08-30   959  	struct ceph_writeback_ctl ceph_wbc;
590e9d9861f5f21 Yan, Zheng              2017-09-03   960  	bool should_loop, range_whole = false;
af9cc401ce7452f Yan, Zheng              2018-03-04   961  	bool done = false;
1702e79734104d7 Jeff Layton             2021-12-07   962  	bool caching = ceph_is_cache_enabled(inode);
7d41870d65db028 Xiubo Li                2023-03-08   963  	xa_mark_t tag;
1d3576fd10f0d7a Sage Weil               2009-10-06   964  
503d4fa6ee28e8d NeilBrown               2022-03-22   965  	if (wbc->sync_mode == WB_SYNC_NONE &&
503d4fa6ee28e8d NeilBrown               2022-03-22   966  	    fsc->write_congested)
503d4fa6ee28e8d NeilBrown               2022-03-22   967  		return 0;
503d4fa6ee28e8d NeilBrown               2022-03-22   968  
38d46409c4639a1 Xiubo Li                2023-06-12   969  	doutc(cl, "%llx.%llx (mode=%s)\n", ceph_vinop(inode),
1d3576fd10f0d7a Sage Weil               2009-10-06   970  	      wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
1d3576fd10f0d7a Sage Weil               2009-10-06   971  	      (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
1d3576fd10f0d7a Sage Weil               2009-10-06   972  
5d6451b1489ad17 Jeff Layton             2021-08-31   973  	if (ceph_inode_is_shutdown(inode)) {
6c93df5db628e71 Yan, Zheng              2016-04-15   974  		if (ci->i_wrbuffer_ref > 0) {
38d46409c4639a1 Xiubo Li                2023-06-12   975  			pr_warn_ratelimited_client(cl,
38d46409c4639a1 Xiubo Li                2023-06-12   976  				"%llx.%llx %lld forced umount\n",
38d46409c4639a1 Xiubo Li                2023-06-12   977  				ceph_vinop(inode), ceph_ino(inode));
6c93df5db628e71 Yan, Zheng              2016-04-15   978  		}
a341d4df87487ae Yan, Zheng              2015-07-01   979  		mapping_set_error(mapping, -EIO);
1d3576fd10f0d7a Sage Weil               2009-10-06   980  		return -EIO; /* we're in a forced umount, don't write! */
1d3576fd10f0d7a Sage Weil               2009-10-06   981  	}
95cca2b44e54b00 Yan, Zheng              2017-07-11   982  	if (fsc->mount_options->wsize < wsize)
3d14c5d2b6e15c2 Yehuda Sadeh            2010-04-06   983  		wsize = fsc->mount_options->wsize;
1d3576fd10f0d7a Sage Weil               2009-10-06   984  
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04   985) 	folio_batch_init(&fbatch);
1d3576fd10f0d7a Sage Weil               2009-10-06   986  
590e9d9861f5f21 Yan, Zheng              2017-09-03   987  	start_index = wbc->range_cyclic ? mapping->writeback_index : 0;
590e9d9861f5f21 Yan, Zheng              2017-09-03   988  	index = start_index;
1d3576fd10f0d7a Sage Weil               2009-10-06   989  
7d41870d65db028 Xiubo Li                2023-03-08   990  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
7d41870d65db028 Xiubo Li                2023-03-08   991  		tag = PAGECACHE_TAG_TOWRITE;
7d41870d65db028 Xiubo Li                2023-03-08   992  	} else {
7d41870d65db028 Xiubo Li                2023-03-08   993  		tag = PAGECACHE_TAG_DIRTY;
7d41870d65db028 Xiubo Li                2023-03-08   994  	}
1d3576fd10f0d7a Sage Weil               2009-10-06   995  retry:
1d3576fd10f0d7a Sage Weil               2009-10-06   996  	/* find oldest snap context with dirty data */
05455e1177f7684 Yan, Zheng              2017-09-02   997  	snapc = get_oldest_context(inode, &ceph_wbc, NULL);
1d3576fd10f0d7a Sage Weil               2009-10-06   998  	if (!snapc) {
1d3576fd10f0d7a Sage Weil               2009-10-06   999  		/* hmm, why does writepages get called when there
1d3576fd10f0d7a Sage Weil               2009-10-06  1000  		   is no dirty data? */
38d46409c4639a1 Xiubo Li                2023-06-12  1001  		doutc(cl, " no snap context with dirty data?\n");
1d3576fd10f0d7a Sage Weil               2009-10-06  1002  		goto out;
1d3576fd10f0d7a Sage Weil               2009-10-06  1003  	}
38d46409c4639a1 Xiubo Li                2023-06-12  1004  	doutc(cl, " oldest snapc is %p seq %lld (%d snaps)\n", snapc,
38d46409c4639a1 Xiubo Li                2023-06-12  1005  	      snapc->seq, snapc->num_snaps);
fc2744aa12da718 Yan, Zheng              2013-05-31  1006  
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1007  	should_loop = false;
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1008  	if (ceph_wbc.head_snapc && snapc != last_snapc) {
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1009  		/* where to start/end? */
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1010  		if (wbc->range_cyclic) {
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1011  			index = start_index;
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1012  			end = -1;
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1013  			if (index > 0)
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1014  				should_loop = true;
38d46409c4639a1 Xiubo Li                2023-06-12  1015  			doutc(cl, " cyclic, start at %lu\n", index);
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1016  		} else {
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1017  			index = wbc->range_start >> PAGE_SHIFT;
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1018  			end = wbc->range_end >> PAGE_SHIFT;
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1019  			if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1020  				range_whole = true;
38d46409c4639a1 Xiubo Li                2023-06-12  1021  			doutc(cl, " not cyclic, %lu to %lu\n", index, end);
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1022  		}
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1023  	} else if (!ceph_wbc.head_snapc) {
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1024  		/* Do not respect wbc->range_{start,end}. Dirty pages
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1025  		 * in that range can be associated with newer snapc.
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1026  		 * They are not writeable until we write all dirty pages
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1027  		 * associated with 'snapc' get written */
1582af2eaaf17cb Yan, Zheng              2018-03-06  1028  		if (index > 0)
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1029  			should_loop = true;
38d46409c4639a1 Xiubo Li                2023-06-12  1030  		doutc(cl, " non-head snapc, range whole\n");
1d3576fd10f0d7a Sage Weil               2009-10-06  1031  	}
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1032  
7d41870d65db028 Xiubo Li                2023-03-08  1033  	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
7d41870d65db028 Xiubo Li                2023-03-08  1034  		tag_pages_for_writeback(mapping, index, end);
7d41870d65db028 Xiubo Li                2023-03-08  1035  
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1036  	ceph_put_snap_context(last_snapc);
1d3576fd10f0d7a Sage Weil               2009-10-06  1037  	last_snapc = snapc;
1d3576fd10f0d7a Sage Weil               2009-10-06  1038  
af9cc401ce7452f Yan, Zheng              2018-03-04  1039  	while (!done && index <= end) {
5b64640cf65be4a Yan, Zheng              2016-01-07  1040  		int num_ops = 0, op_idx;
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1041) 		unsigned i, nr_folios, max_pages, locked_pages = 0;
5b64640cf65be4a Yan, Zheng              2016-01-07  1042  		struct page **pages = NULL, **data_pages;
1d3576fd10f0d7a Sage Weil               2009-10-06  1043  		struct page *page;
0e5ecac71683665 Yan, Zheng              2017-08-31  1044  		pgoff_t strip_unit_end = 0;
5b64640cf65be4a Yan, Zheng              2016-01-07  1045  		u64 offset = 0, len = 0;
a0102bda5bc0991 Jeff Layton             2020-07-30  1046  		bool from_pool = false;
1d3576fd10f0d7a Sage Weil               2009-10-06  1047  
0e5ecac71683665 Yan, Zheng              2017-08-31  1048  		max_pages = wsize >> PAGE_SHIFT;
1d3576fd10f0d7a Sage Weil               2009-10-06  1049  
1d3576fd10f0d7a Sage Weil               2009-10-06  1050  get_more_pages:
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1051) 		nr_folios = filemap_get_folios_tag(mapping, &index,
7d41870d65db028 Xiubo Li                2023-03-08  1052  						   end, tag, &fbatch);
38d46409c4639a1 Xiubo Li                2023-06-12  1053  		doutc(cl, "pagevec_lookup_range_tag got %d\n", nr_folios);
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1054) 		if (!nr_folios && !locked_pages)
1d3576fd10f0d7a Sage Weil               2009-10-06  1055  			break;
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1056) 		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
fd15ba4cb00a43f Matthew Wilcox (Oracle  2024-10-02  1057) 			struct folio *folio = fbatch.folios[i];
fd15ba4cb00a43f Matthew Wilcox (Oracle  2024-10-02  1058) 
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1059) 			doutc(cl, "? %p idx %lu\n", folio, folio->index);
1d3576fd10f0d7a Sage Weil               2009-10-06  1060  			if (locked_pages == 0)
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1061) 				folio_lock(folio);  /* first page */
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1062) 			else if (!folio_trylock(folio))
1d3576fd10f0d7a Sage Weil               2009-10-06  1063  				break;
1d3576fd10f0d7a Sage Weil               2009-10-06  1064  
1d3576fd10f0d7a Sage Weil               2009-10-06  1065  			/* only dirty pages, or our accounting breaks */
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1066) 			if (unlikely(!folio_test_dirty(folio)) ||
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1067) 			    unlikely(folio->mapping != mapping)) {
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1068) 				doutc(cl, "!dirty or !mapping %p\n", folio);
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1069) 				folio_unlock(folio);
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1070  				continue;
1d3576fd10f0d7a Sage Weil               2009-10-06  1071  			}
af9cc401ce7452f Yan, Zheng              2018-03-04  1072  			/* only if matching snap context */
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1073) 			pgsnapc = page_snap_context(&folio->page);
af9cc401ce7452f Yan, Zheng              2018-03-04  1074  			if (pgsnapc != snapc) {
38d46409c4639a1 Xiubo Li                2023-06-12  1075  				doutc(cl, "page snapc %p %lld != oldest %p %lld\n",
af9cc401ce7452f Yan, Zheng              2018-03-04  1076  				      pgsnapc, pgsnapc->seq, snapc, snapc->seq);
1582af2eaaf17cb Yan, Zheng              2018-03-06  1077  				if (!should_loop &&
1582af2eaaf17cb Yan, Zheng              2018-03-06  1078  				    !ceph_wbc.head_snapc &&
1582af2eaaf17cb Yan, Zheng              2018-03-06  1079  				    wbc->sync_mode != WB_SYNC_NONE)
1582af2eaaf17cb Yan, Zheng              2018-03-06  1080  					should_loop = true;
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1081) 				folio_unlock(folio);
af9cc401ce7452f Yan, Zheng              2018-03-04  1082  				continue;
1d3576fd10f0d7a Sage Weil               2009-10-06  1083  			}
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1084) 			if (folio_pos(folio) >= ceph_wbc.i_size) {
38d46409c4639a1 Xiubo Li                2023-06-12  1085  				doutc(cl, "folio at %lu beyond eof %llu\n",
a628304ebe6ab02 Matthew Wilcox (Oracle  2022-02-09  1086) 				      folio->index, ceph_wbc.i_size);
c95f1c5f436badb Erqi Chen               2019-07-24  1087  				if ((ceph_wbc.size_stable ||
a628304ebe6ab02 Matthew Wilcox (Oracle  2022-02-09  1088) 				    folio_pos(folio) >= i_size_read(inode)) &&
a628304ebe6ab02 Matthew Wilcox (Oracle  2022-02-09  1089) 				    folio_clear_dirty_for_io(folio))
a628304ebe6ab02 Matthew Wilcox (Oracle  2022-02-09  1090) 					folio_invalidate(folio, 0,
a628304ebe6ab02 Matthew Wilcox (Oracle  2022-02-09  1091) 							folio_size(folio));
a628304ebe6ab02 Matthew Wilcox (Oracle  2022-02-09  1092) 				folio_unlock(folio);
af9cc401ce7452f Yan, Zheng              2018-03-04  1093  				continue;
af9cc401ce7452f Yan, Zheng              2018-03-04  1094  			}
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1095) 			if (strip_unit_end && (folio->index > strip_unit_end)) {
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1096) 				doutc(cl, "end of strip unit %p\n", folio);
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1097) 				folio_unlock(folio);
1d3576fd10f0d7a Sage Weil               2009-10-06  1098  				break;
1d3576fd10f0d7a Sage Weil               2009-10-06  1099  			}
fd15ba4cb00a43f Matthew Wilcox (Oracle  2024-10-02  1100) 			if (folio_test_writeback(folio) ||
fd15ba4cb00a43f Matthew Wilcox (Oracle  2024-10-02  1101) 			    folio_test_private_2(folio) /* [DEPRECATED] */) {
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1102  				if (wbc->sync_mode == WB_SYNC_NONE) {
fd15ba4cb00a43f Matthew Wilcox (Oracle  2024-10-02  1103) 					doutc(cl, "%p under writeback\n", folio);
fd15ba4cb00a43f Matthew Wilcox (Oracle  2024-10-02  1104) 					folio_unlock(folio);
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1105  					continue;
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1106  				}
fd15ba4cb00a43f Matthew Wilcox (Oracle  2024-10-02  1107) 				doutc(cl, "waiting on writeback %p\n", folio);
fd15ba4cb00a43f Matthew Wilcox (Oracle  2024-10-02  1108) 				folio_wait_writeback(folio);
fd15ba4cb00a43f Matthew Wilcox (Oracle  2024-10-02  1109) 				folio_wait_private_2(folio); /* [DEPRECATED] */
1d3576fd10f0d7a Sage Weil               2009-10-06  1110  			}
1d3576fd10f0d7a Sage Weil               2009-10-06  1111  
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1112) 			if (!folio_clear_dirty_for_io(folio)) {
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1113) 				doutc(cl, "%p !clear_page_dirty_for_io\n", folio);
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1114) 				folio_unlock(folio);
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1115  				continue;
1d3576fd10f0d7a Sage Weil               2009-10-06  1116  			}
1d3576fd10f0d7a Sage Weil               2009-10-06  1117  
e5975c7c8eb6aea Alex Elder              2013-03-14  1118  			/*
e5975c7c8eb6aea Alex Elder              2013-03-14  1119  			 * We have something to write.  If this is
e5975c7c8eb6aea Alex Elder              2013-03-14  1120  			 * the first locked page this time through,
5b64640cf65be4a Yan, Zheng              2016-01-07  1121  			 * calculate max possinle write size and
5b64640cf65be4a Yan, Zheng              2016-01-07  1122  			 * allocate a page array
e5975c7c8eb6aea Alex Elder              2013-03-14  1123  			 */
1d3576fd10f0d7a Sage Weil               2009-10-06  1124  			if (locked_pages == 0) {
5b64640cf65be4a Yan, Zheng              2016-01-07  1125  				u64 objnum;
5b64640cf65be4a Yan, Zheng              2016-01-07  1126  				u64 objoff;
dccbf08005df800 Ilya Dryomov            2018-02-17  1127  				u32 xlen;
5b64640cf65be4a Yan, Zheng              2016-01-07  1128  
1d3576fd10f0d7a Sage Weil               2009-10-06  1129  				/* prepare async write request */
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1130) 				offset = folio_pos(folio);
dccbf08005df800 Ilya Dryomov            2018-02-17  1131  				ceph_calc_file_object_mapping(&ci->i_layout,
dccbf08005df800 Ilya Dryomov            2018-02-17  1132  							      offset, wsize,
5b64640cf65be4a Yan, Zheng              2016-01-07  1133  							      &objnum, &objoff,
dccbf08005df800 Ilya Dryomov            2018-02-17  1134  							      &xlen);
dccbf08005df800 Ilya Dryomov            2018-02-17  1135  				len = xlen;
8c71897be2ddfd8 Henry C Chang           2011-05-03  1136  
3fb99d483e614bc Yanhu Cao               2017-07-21  1137  				num_ops = 1;
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1138) 				strip_unit_end = folio->index +
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  1139  					((len - 1) >> PAGE_SHIFT);
88486957f9fbf52 Alex Elder              2013-03-14  1140  
5b64640cf65be4a Yan, Zheng              2016-01-07  1141  				BUG_ON(pages);
88486957f9fbf52 Alex Elder              2013-03-14  1142  				max_pages = calc_pages_for(0, (u64)len);
6da2ec56059c3c7 Kees Cook               2018-06-12  1143  				pages = kmalloc_array(max_pages,
6da2ec56059c3c7 Kees Cook               2018-06-12  1144  						      sizeof(*pages),
fc2744aa12da718 Yan, Zheng              2013-05-31  1145  						      GFP_NOFS);
88486957f9fbf52 Alex Elder              2013-03-14  1146  				if (!pages) {
a0102bda5bc0991 Jeff Layton             2020-07-30  1147  					from_pool = true;
a0102bda5bc0991 Jeff Layton             2020-07-30  1148  					pages = mempool_alloc(ceph_wb_pagevec_pool, GFP_NOFS);
e5975c7c8eb6aea Alex Elder              2013-03-14  1149  					BUG_ON(!pages);
88486957f9fbf52 Alex Elder              2013-03-14  1150  				}
5b64640cf65be4a Yan, Zheng              2016-01-07  1151  
5b64640cf65be4a Yan, Zheng              2016-01-07  1152  				len = 0;
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1153) 			} else if (folio->index !=
09cbfeaf1a5a67b Kirill A. Shutemov      2016-04-01  1154  				   (offset + len) >> PAGE_SHIFT) {
a0102bda5bc0991 Jeff Layton             2020-07-30  1155  				if (num_ops >= (from_pool ?  CEPH_OSD_SLAB_OPS :
5b64640cf65be4a Yan, Zheng              2016-01-07  1156  							     CEPH_OSD_MAX_OPS)) {
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1157) 					folio_redirty_for_writepage(wbc, folio);
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1158) 					folio_unlock(folio);
5b64640cf65be4a Yan, Zheng              2016-01-07  1159  					break;
5b64640cf65be4a Yan, Zheng              2016-01-07  1160  				}
5b64640cf65be4a Yan, Zheng              2016-01-07  1161  
5b64640cf65be4a Yan, Zheng              2016-01-07  1162  				num_ops++;
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1163) 				offset = folio_pos(folio);
5b64640cf65be4a Yan, Zheng              2016-01-07  1164  				len = 0;
1d3576fd10f0d7a Sage Weil               2009-10-06  1165  			}
1d3576fd10f0d7a Sage Weil               2009-10-06  1166  
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1167) 			/* note position of first page in fbatch */
38d46409c4639a1 Xiubo Li                2023-06-12  1168  			doutc(cl, "%llx.%llx will write page %p idx %lu\n",
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1169) 			      ceph_vinop(inode), folio, folio->index);
2baba25019ec564 Yehuda Sadeh            2009-12-18  1170  
5b64640cf65be4a Yan, Zheng              2016-01-07  1171  			if (atomic_long_inc_return(&fsc->writeback_count) >
5b64640cf65be4a Yan, Zheng              2016-01-07  1172  			    CONGESTION_ON_THRESH(
503d4fa6ee28e8d NeilBrown               2022-03-22  1173  				    fsc->mount_options->congestion_kb))
503d4fa6ee28e8d NeilBrown               2022-03-22  1174  				fsc->write_congested = true;
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1175  
d55207717ded95c Jeff Layton             2022-08-25  1176  			if (IS_ENCRYPTED(inode)) {
d55207717ded95c Jeff Layton             2022-08-25  1177  				pages[locked_pages] =
d55207717ded95c Jeff Layton             2022-08-25 @1178  					fscrypt_encrypt_pagecache_blocks(page,
d55207717ded95c Jeff Layton             2022-08-25  1179  						PAGE_SIZE, 0,
d55207717ded95c Jeff Layton             2022-08-25  1180  						locked_pages ? GFP_NOWAIT : GFP_NOFS);
d55207717ded95c Jeff Layton             2022-08-25  1181  				if (IS_ERR(pages[locked_pages])) {
d55207717ded95c Jeff Layton             2022-08-25  1182  					if (PTR_ERR(pages[locked_pages]) == -EINVAL)
38d46409c4639a1 Xiubo Li                2023-06-12  1183  						pr_err_client(cl,
38d46409c4639a1 Xiubo Li                2023-06-12  1184  							"inode->i_blkbits=%hhu\n",
38d46409c4639a1 Xiubo Li                2023-06-12  1185  							inode->i_blkbits);
d55207717ded95c Jeff Layton             2022-08-25  1186  					/* better not fail on first page! */
d55207717ded95c Jeff Layton             2022-08-25  1187  					BUG_ON(locked_pages == 0);
d55207717ded95c Jeff Layton             2022-08-25  1188  					pages[locked_pages] = NULL;
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1189) 					folio_redirty_for_writepage(wbc, folio);
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1190) 					folio_unlock(folio);
d55207717ded95c Jeff Layton             2022-08-25  1191  					break;
d55207717ded95c Jeff Layton             2022-08-25  1192  				}
d55207717ded95c Jeff Layton             2022-08-25  1193  				++locked_pages;
d55207717ded95c Jeff Layton             2022-08-25  1194  			} else {
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1195) 				pages[locked_pages++] = &folio->page;
d55207717ded95c Jeff Layton             2022-08-25  1196  			}
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1197  
d55207717ded95c Jeff Layton             2022-08-25  1198  			fbatch.folios[i] = NULL;
a38da1eafb17612 Matthew Wilcox (Oracle  2024-11-29  1199) 			len += folio_size(folio);
1d3576fd10f0d7a Sage Weil               2009-10-06  1200  		}
1d3576fd10f0d7a Sage Weil               2009-10-06  1201  
1d3576fd10f0d7a Sage Weil               2009-10-06  1202  		/* did we get anything? */
1d3576fd10f0d7a Sage Weil               2009-10-06  1203  		if (!locked_pages)
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1204) 			goto release_folios;
1d3576fd10f0d7a Sage Weil               2009-10-06  1205  		if (i) {
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1206  			unsigned j, n = 0;
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1207) 			/* shift unused page to beginning of fbatch */
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1208) 			for (j = 0; j < nr_folios; j++) {
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1209) 				if (!fbatch.folios[j])
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1210  					continue;
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1211  				if (n < j)
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1212) 					fbatch.folios[n] = fbatch.folios[j];
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1213  				n++;
0713e5f24b7deb8 Yan, Zheng              2017-08-31  1214  			}
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1215) 			fbatch.nr = n;
1d3576fd10f0d7a Sage Weil               2009-10-06  1216  
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1217) 			if (nr_folios && i == nr_folios &&
1d3576fd10f0d7a Sage Weil               2009-10-06  1218  			    locked_pages < max_pages) {
38d46409c4639a1 Xiubo Li                2023-06-12  1219  				doutc(cl, "reached end fbatch, trying for more\n");
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1220) 				folio_batch_release(&fbatch);
1d3576fd10f0d7a Sage Weil               2009-10-06  1221  				goto get_more_pages;
1d3576fd10f0d7a Sage Weil               2009-10-06  1222  			}
1d3576fd10f0d7a Sage Weil               2009-10-06  1223  		}
1d3576fd10f0d7a Sage Weil               2009-10-06  1224  
5b64640cf65be4a Yan, Zheng              2016-01-07  1225  new_request:
d55207717ded95c Jeff Layton             2022-08-25  1226  		offset = ceph_fscrypt_page_offset(pages[0]);
5b64640cf65be4a Yan, Zheng              2016-01-07  1227  		len = wsize;
5b64640cf65be4a Yan, Zheng              2016-01-07  1228  
5b64640cf65be4a Yan, Zheng              2016-01-07  1229  		req = ceph_osdc_new_request(&fsc->client->osdc,
5b64640cf65be4a Yan, Zheng              2016-01-07  1230  					&ci->i_layout, vino,
5b64640cf65be4a Yan, Zheng              2016-01-07  1231  					offset, &len, 0, num_ops,
1f934b00e907527 Yan, Zheng              2017-08-30  1232  					CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
1f934b00e907527 Yan, Zheng              2017-08-30  1233  					snapc, ceph_wbc.truncate_seq,
1f934b00e907527 Yan, Zheng              2017-08-30  1234  					ceph_wbc.truncate_size, false);
5b64640cf65be4a Yan, Zheng              2016-01-07  1235  		if (IS_ERR(req)) {
5b64640cf65be4a Yan, Zheng              2016-01-07  1236  			req = ceph_osdc_new_request(&fsc->client->osdc,
5b64640cf65be4a Yan, Zheng              2016-01-07  1237  						&ci->i_layout, vino,
5b64640cf65be4a Yan, Zheng              2016-01-07  1238  						offset, &len, 0,
5b64640cf65be4a Yan, Zheng              2016-01-07  1239  						min(num_ops,
5b64640cf65be4a Yan, Zheng              2016-01-07  1240  						    CEPH_OSD_SLAB_OPS),
5b64640cf65be4a Yan, Zheng              2016-01-07  1241  						CEPH_OSD_OP_WRITE,
54ea0046b6fe36e Ilya Dryomov            2017-02-11  1242  						CEPH_OSD_FLAG_WRITE,
1f934b00e907527 Yan, Zheng              2017-08-30  1243  						snapc, ceph_wbc.truncate_seq,
1f934b00e907527 Yan, Zheng              2017-08-30  1244  						ceph_wbc.truncate_size, true);
5b64640cf65be4a Yan, Zheng              2016-01-07  1245  			BUG_ON(IS_ERR(req));
5b64640cf65be4a Yan, Zheng              2016-01-07  1246  		}
d55207717ded95c Jeff Layton             2022-08-25  1247  		BUG_ON(len < ceph_fscrypt_page_offset(pages[locked_pages - 1]) +
d55207717ded95c Jeff Layton             2022-08-25  1248  			     thp_size(pages[locked_pages - 1]) - offset);
5b64640cf65be4a Yan, Zheng              2016-01-07  1249  
1464de9f813e355 Xiubo Li                2023-05-09  1250  		if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
1464de9f813e355 Xiubo Li                2023-05-09  1251  			rc = -EIO;
1464de9f813e355 Xiubo Li                2023-05-09  1252  			goto release_folios;
1464de9f813e355 Xiubo Li                2023-05-09  1253  		}
5b64640cf65be4a Yan, Zheng              2016-01-07  1254  		req->r_callback = writepages_finish;
5b64640cf65be4a Yan, Zheng              2016-01-07  1255  		req->r_inode = inode;
5b64640cf65be4a Yan, Zheng              2016-01-07  1256  
5b64640cf65be4a Yan, Zheng              2016-01-07  1257  		/* Format the osd request message and submit the write */
5b64640cf65be4a Yan, Zheng              2016-01-07  1258  		len = 0;
5b64640cf65be4a Yan, Zheng              2016-01-07  1259  		data_pages = pages;
5b64640cf65be4a Yan, Zheng              2016-01-07  1260  		op_idx = 0;
5b64640cf65be4a Yan, Zheng              2016-01-07  1261  		for (i = 0; i < locked_pages; i++) {
d55207717ded95c Jeff Layton             2022-08-25  1262  			struct page *page = ceph_fscrypt_pagecache_page(pages[i]);
d55207717ded95c Jeff Layton             2022-08-25  1263  
d55207717ded95c Jeff Layton             2022-08-25  1264  			u64 cur_offset = page_offset(page);
1702e79734104d7 Jeff Layton             2021-12-07  1265  			/*
1702e79734104d7 Jeff Layton             2021-12-07  1266  			 * Discontinuity in page range? Ceph can handle that by just passing
1702e79734104d7 Jeff Layton             2021-12-07  1267  			 * multiple extents in the write op.
1702e79734104d7 Jeff Layton             2021-12-07  1268  			 */
5b64640cf65be4a Yan, Zheng              2016-01-07  1269  			if (offset + len != cur_offset) {
1702e79734104d7 Jeff Layton             2021-12-07  1270  				/* If it's full, stop here */
3fb99d483e614bc Yanhu Cao               2017-07-21  1271  				if (op_idx + 1 == req->r_num_ops)
5b64640cf65be4a Yan, Zheng              2016-01-07  1272  					break;
1702e79734104d7 Jeff Layton             2021-12-07  1273  
1702e79734104d7 Jeff Layton             2021-12-07  1274  				/* Kick off an fscache write with what we have so far. */
1702e79734104d7 Jeff Layton             2021-12-07  1275  				ceph_fscache_write_to_cache(inode, offset, len, caching);
1702e79734104d7 Jeff Layton             2021-12-07  1276  
1702e79734104d7 Jeff Layton             2021-12-07  1277  				/* Start a new extent */
5b64640cf65be4a Yan, Zheng              2016-01-07  1278  				osd_req_op_extent_dup_last(req, op_idx,
5b64640cf65be4a Yan, Zheng              2016-01-07  1279  							   cur_offset - offset);
38d46409c4639a1 Xiubo Li                2023-06-12  1280  				doutc(cl, "got pages at %llu~%llu\n", offset,
38d46409c4639a1 Xiubo Li                2023-06-12  1281  				      len);
5b64640cf65be4a Yan, Zheng              2016-01-07  1282  				osd_req_op_extent_osd_data_pages(req, op_idx,
5b64640cf65be4a Yan, Zheng              2016-01-07  1283  							data_pages, len, 0,
a0102bda5bc0991 Jeff Layton             2020-07-30  1284  							from_pool, false);
5b64640cf65be4a Yan, Zheng              2016-01-07  1285  				osd_req_op_extent_update(req, op_idx, len);
5b64640cf65be4a Yan, Zheng              2016-01-07  1286  
5b64640cf65be4a Yan, Zheng              2016-01-07  1287  				len = 0;
5b64640cf65be4a Yan, Zheng              2016-01-07  1288  				offset = cur_offset;
5b64640cf65be4a Yan, Zheng              2016-01-07  1289  				data_pages = pages + i;
5b64640cf65be4a Yan, Zheng              2016-01-07  1290  				op_idx++;
5b64640cf65be4a Yan, Zheng              2016-01-07  1291  			}
5b64640cf65be4a Yan, Zheng              2016-01-07  1292  
d55207717ded95c Jeff Layton             2022-08-25  1293  			set_page_writeback(page);
8e5ced7804cb918 David Howells           2024-07-30  1294  			if (caching)
8e5ced7804cb918 David Howells           2024-07-30  1295  				ceph_set_page_fscache(page);
8ff2d290c8ce77c Jeff Layton             2021-04-05  1296  			len += thp_size(page);
5b64640cf65be4a Yan, Zheng              2016-01-07  1297  		}
1702e79734104d7 Jeff Layton             2021-12-07  1298  		ceph_fscache_write_to_cache(inode, offset, len, caching);
5b64640cf65be4a Yan, Zheng              2016-01-07  1299  
1f934b00e907527 Yan, Zheng              2017-08-30  1300  		if (ceph_wbc.size_stable) {
1f934b00e907527 Yan, Zheng              2017-08-30  1301  			len = min(len, ceph_wbc.i_size - offset);
5b64640cf65be4a Yan, Zheng              2016-01-07  1302  		} else if (i == locked_pages) {
e1966b49446a439 Yan, Zheng              2015-06-18  1303  			/* writepages_finish() clears writeback pages
e1966b49446a439 Yan, Zheng              2015-06-18  1304  			 * according to the data length, so make sure
e1966b49446a439 Yan, Zheng              2015-06-18  1305  			 * data length covers all locked pages */
8ff2d290c8ce77c Jeff Layton             2021-04-05  1306  			u64 min_len = len + 1 - thp_size(page);
1f934b00e907527 Yan, Zheng              2017-08-30  1307  			len = get_writepages_data_length(inode, pages[i - 1],
1f934b00e907527 Yan, Zheng              2017-08-30  1308  							 offset);
5b64640cf65be4a Yan, Zheng              2016-01-07  1309  			len = max(len, min_len);
e1966b49446a439 Yan, Zheng              2015-06-18  1310  		}
d55207717ded95c Jeff Layton             2022-08-25  1311  		if (IS_ENCRYPTED(inode))
d55207717ded95c Jeff Layton             2022-08-25  1312  			len = round_up(len, CEPH_FSCRYPT_BLOCK_SIZE);
d55207717ded95c Jeff Layton             2022-08-25  1313  
38d46409c4639a1 Xiubo Li                2023-06-12  1314  		doutc(cl, "got pages at %llu~%llu\n", offset, len);
1d3576fd10f0d7a Sage Weil               2009-10-06  1315  
d55207717ded95c Jeff Layton             2022-08-25  1316  		if (IS_ENCRYPTED(inode) &&
d55207717ded95c Jeff Layton             2022-08-25  1317  		    ((offset | len) & ~CEPH_FSCRYPT_BLOCK_MASK))
38d46409c4639a1 Xiubo Li                2023-06-12  1318  			pr_warn_client(cl,
38d46409c4639a1 Xiubo Li                2023-06-12  1319  				"bad encrypted write offset=%lld len=%llu\n",
38d46409c4639a1 Xiubo Li                2023-06-12  1320  				offset, len);
d55207717ded95c Jeff Layton             2022-08-25  1321  
5b64640cf65be4a Yan, Zheng              2016-01-07  1322  		osd_req_op_extent_osd_data_pages(req, op_idx, data_pages, len,
a0102bda5bc0991 Jeff Layton             2020-07-30  1323  						 0, from_pool, false);
5b64640cf65be4a Yan, Zheng              2016-01-07  1324  		osd_req_op_extent_update(req, op_idx, len);
e5975c7c8eb6aea Alex Elder              2013-03-14  1325  
5b64640cf65be4a Yan, Zheng              2016-01-07  1326  		BUG_ON(op_idx + 1 != req->r_num_ops);
e5975c7c8eb6aea Alex Elder              2013-03-14  1327  
a0102bda5bc0991 Jeff Layton             2020-07-30  1328  		from_pool = false;
5b64640cf65be4a Yan, Zheng              2016-01-07  1329  		if (i < locked_pages) {
5b64640cf65be4a Yan, Zheng              2016-01-07  1330  			BUG_ON(num_ops <= req->r_num_ops);
5b64640cf65be4a Yan, Zheng              2016-01-07  1331  			num_ops -= req->r_num_ops;
5b64640cf65be4a Yan, Zheng              2016-01-07  1332  			locked_pages -= i;
5b64640cf65be4a Yan, Zheng              2016-01-07  1333  
5b64640cf65be4a Yan, Zheng              2016-01-07  1334  			/* allocate new pages array for next request */
5b64640cf65be4a Yan, Zheng              2016-01-07  1335  			data_pages = pages;
6da2ec56059c3c7 Kees Cook               2018-06-12  1336  			pages = kmalloc_array(locked_pages, sizeof(*pages),
5b64640cf65be4a Yan, Zheng              2016-01-07  1337  					      GFP_NOFS);
5b64640cf65be4a Yan, Zheng              2016-01-07  1338  			if (!pages) {
a0102bda5bc0991 Jeff Layton             2020-07-30  1339  				from_pool = true;
a0102bda5bc0991 Jeff Layton             2020-07-30  1340  				pages = mempool_alloc(ceph_wb_pagevec_pool, GFP_NOFS);
5b64640cf65be4a Yan, Zheng              2016-01-07  1341  				BUG_ON(!pages);
5b64640cf65be4a Yan, Zheng              2016-01-07  1342  			}
5b64640cf65be4a Yan, Zheng              2016-01-07  1343  			memcpy(pages, data_pages + i,
5b64640cf65be4a Yan, Zheng              2016-01-07  1344  			       locked_pages * sizeof(*pages));
5b64640cf65be4a Yan, Zheng              2016-01-07  1345  			memset(data_pages + i, 0,
5b64640cf65be4a Yan, Zheng              2016-01-07  1346  			       locked_pages * sizeof(*pages));
5b64640cf65be4a Yan, Zheng              2016-01-07  1347  		} else {
9182bf4af1f077d Matthew Wilcox (Oracle  2024-11-29  1348) 			struct folio *folio;
9182bf4af1f077d Matthew Wilcox (Oracle  2024-11-29  1349) 
5b64640cf65be4a Yan, Zheng              2016-01-07  1350  			BUG_ON(num_ops != req->r_num_ops);
9182bf4af1f077d Matthew Wilcox (Oracle  2024-11-29  1351) 			folio = ceph_fscrypt_pagecache_folio(pages[i - 1]);
9182bf4af1f077d Matthew Wilcox (Oracle  2024-11-29  1352) 			index = folio->index + 1;
5b64640cf65be4a Yan, Zheng              2016-01-07  1353  			/* request message now owns the pages array */
5b64640cf65be4a Yan, Zheng              2016-01-07  1354  			pages = NULL;
5b64640cf65be4a Yan, Zheng              2016-01-07  1355  		}
e5975c7c8eb6aea Alex Elder              2013-03-14  1356  
c453bdb535341b5 Jeff Layton             2023-10-04  1357  		req->r_mtime = inode_get_mtime(inode);
a8af0d682ae0c9c Jeff Layton             2022-06-30  1358  		ceph_osdc_start_request(&fsc->client->osdc, req);
1d3576fd10f0d7a Sage Weil               2009-10-06  1359  		req = NULL;
1d3576fd10f0d7a Sage Weil               2009-10-06  1360  
5b64640cf65be4a Yan, Zheng              2016-01-07  1361  		wbc->nr_to_write -= i;
5b64640cf65be4a Yan, Zheng              2016-01-07  1362  		if (pages)
5b64640cf65be4a Yan, Zheng              2016-01-07  1363  			goto new_request;
5b64640cf65be4a Yan, Zheng              2016-01-07  1364  
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1365  		/*
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1366  		 * We stop writing back only if we are not doing
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1367  		 * integrity sync. In case of integrity sync we have to
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1368  		 * keep going until we have written all the pages
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1369  		 * we tagged for writeback prior to entering this loop.
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1370  		 */
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1371  		if (wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
af9cc401ce7452f Yan, Zheng              2018-03-04  1372  			done = true;
1d3576fd10f0d7a Sage Weil               2009-10-06  1373  
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1374) release_folios:
38d46409c4639a1 Xiubo Li                2023-06-12  1375  		doutc(cl, "folio_batch release on %d folios (%p)\n",
38d46409c4639a1 Xiubo Li                2023-06-12  1376  		      (int)fbatch.nr, fbatch.nr ? fbatch.folios[0] : NULL);
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1377) 		folio_batch_release(&fbatch);
1d3576fd10f0d7a Sage Weil               2009-10-06  1378  	}
1d3576fd10f0d7a Sage Weil               2009-10-06  1379  
1d3576fd10f0d7a Sage Weil               2009-10-06  1380  	if (should_loop && !done) {
1d3576fd10f0d7a Sage Weil               2009-10-06  1381  		/* more to do; loop back to beginning of file */
38d46409c4639a1 Xiubo Li                2023-06-12  1382  		doutc(cl, "looping back to beginning of file\n");
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1383  		end = start_index - 1; /* OK even when start_index == 0 */
f275635ee0b6641 Yan, Zheng              2017-09-01  1384  
f275635ee0b6641 Yan, Zheng              2017-09-01  1385  		/* to write dirty pages associated with next snapc,
f275635ee0b6641 Yan, Zheng              2017-09-01  1386  		 * we need to wait until current writes complete */
f275635ee0b6641 Yan, Zheng              2017-09-01  1387  		if (wbc->sync_mode != WB_SYNC_NONE &&
f275635ee0b6641 Yan, Zheng              2017-09-01  1388  		    start_index == 0 && /* all dirty pages were checked */
f275635ee0b6641 Yan, Zheng              2017-09-01  1389  		    !ceph_wbc.head_snapc) {
f275635ee0b6641 Yan, Zheng              2017-09-01  1390  			struct page *page;
f275635ee0b6641 Yan, Zheng              2017-09-01  1391  			unsigned i, nr;
f275635ee0b6641 Yan, Zheng              2017-09-01  1392  			index = 0;
f275635ee0b6641 Yan, Zheng              2017-09-01  1393  			while ((index <= end) &&
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1394) 			       (nr = filemap_get_folios_tag(mapping, &index,
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1395) 						(pgoff_t)-1,
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1396) 						PAGECACHE_TAG_WRITEBACK,
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1397) 						&fbatch))) {
f275635ee0b6641 Yan, Zheng              2017-09-01  1398  				for (i = 0; i < nr; i++) {
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1399) 					page = &fbatch.folios[i]->page;
f275635ee0b6641 Yan, Zheng              2017-09-01  1400  					if (page_snap_context(page) != snapc)
f275635ee0b6641 Yan, Zheng              2017-09-01  1401  						continue;
f275635ee0b6641 Yan, Zheng              2017-09-01  1402  					wait_on_page_writeback(page);
f275635ee0b6641 Yan, Zheng              2017-09-01  1403  				}
590a2b5f0a9b740 Vishal Moola (Oracle    2023-01-04  1404) 				folio_batch_release(&fbatch);
f275635ee0b6641 Yan, Zheng              2017-09-01  1405  				cond_resched();
f275635ee0b6641 Yan, Zheng              2017-09-01  1406  			}
f275635ee0b6641 Yan, Zheng              2017-09-01  1407  		}
f275635ee0b6641 Yan, Zheng              2017-09-01  1408  
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1409  		start_index = 0;
1d3576fd10f0d7a Sage Weil               2009-10-06  1410  		index = 0;
1d3576fd10f0d7a Sage Weil               2009-10-06  1411  		goto retry;
1d3576fd10f0d7a Sage Weil               2009-10-06  1412  	}
1d3576fd10f0d7a Sage Weil               2009-10-06  1413  
1d3576fd10f0d7a Sage Weil               2009-10-06  1414  	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
1d3576fd10f0d7a Sage Weil               2009-10-06  1415  		mapping->writeback_index = index;
1d3576fd10f0d7a Sage Weil               2009-10-06  1416  
1d3576fd10f0d7a Sage Weil               2009-10-06  1417  out:
1d3576fd10f0d7a Sage Weil               2009-10-06  1418  	ceph_osdc_put_request(req);
2a2d927e35dd8dc Yan, Zheng              2017-09-01  1419  	ceph_put_snap_context(last_snapc);
38d46409c4639a1 Xiubo Li                2023-06-12  1420  	doutc(cl, "%llx.%llx dend - startone, rc = %d\n", ceph_vinop(inode),
38d46409c4639a1 Xiubo Li                2023-06-12  1421  	      rc);
1d3576fd10f0d7a Sage Weil               2009-10-06  1422  	return rc;
1d3576fd10f0d7a Sage Weil               2009-10-06  1423  }
1d3576fd10f0d7a Sage Weil               2009-10-06  1424  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


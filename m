Return-Path: <linux-fsdevel+bounces-20381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A68D28C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 01:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4801C247BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370F213DDBF;
	Tue, 28 May 2024 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiMGPdJC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB073AC0F;
	Tue, 28 May 2024 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939176; cv=none; b=imq4rSdGKQhIKa7mnhzmBZtkxd87PbOcD29OJc2I1D3dKP7ktIXu+9HIiaDLQycW88b/gkD58bf7+sz/VHXeITqJ7nFcWUH/ttdtBvnB17qMAc2kpl+2nmVOmqczak08Zz8/q9Hu35jyhUzkDC/No/95LktqpoJtxnmvtDnZvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939176; c=relaxed/simple;
	bh=h9fhzysPsCiidwmTP22MYeTE5zTE65ef2fk1cKfix7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfBRYvjsBfwRyVRq6NPDt3jqBJjnW6AINLVZkymp/CAY7bWEgtpKA4E7wnqEd101qs4X6eMZgHv1YLGDcqL9q78D6mMTSa52GaUsS+vlcgrNwoquNilpdX0EJt4KzdJu2MqXCPHfCfvlTR74QFigGrYcLJWXEtM1PVEN3nTpPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiMGPdJC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716939174; x=1748475174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h9fhzysPsCiidwmTP22MYeTE5zTE65ef2fk1cKfix7s=;
  b=fiMGPdJCGB+opSdbFVEfbsI7S6s7zKdZ6VMNAjyOuOCealMJv/u9pnf6
   jHlryAUPEmbm2QrVP4564oABrAJqIIbeStWRlfp03tJXii4FPbJoUMKlS
   qUBukEnWTBZD3muEfTM1yIACDhZRwNDfUSK4XbJR+DzMGbM3QCMaAdGIH
   Tg3C/5l1XxkbIr60vNlJ3AAQdVlqKmIB8tII7Qmh4fUW5FYlj36Y4CAEm
   BvFenOWgDq7LhSPJ2KPZphFYS3FtM9mLAR0MA+7b9BWY1fzIYTgHOO480
   5+1zxSSFfgJtsh++T6tbrW4iyZ6gTcjSo5F+84wkylb+DQKUQrxLO1u1p
   Q==;
X-CSE-ConnectionGUID: NppT1KRnQv+sOkx2V9Tgpw==
X-CSE-MsgGUID: OKgz7P5WSEG30fkGgdEfng==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30842631"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30842631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:32:54 -0700
X-CSE-ConnectionGUID: 6R/9eJX7Tm2fzbgFoMX6jQ==
X-CSE-MsgGUID: nbSlpXfsQDiC/MBOkLwibw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="35302321"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 28 May 2024 16:32:51 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sC6JF-000Cs5-0p;
	Tue, 28 May 2024 23:32:49 +0000
Date: Wed, 29 May 2024 07:31:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] iomap: Return the folio from iomap_write_begin()
Message-ID: <202405290732.YLYLE1Zi-lkp@intel.com>
References: <20240528164829.2105447-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528164829.2105447-8-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10-rc1 next-20240528]
[cannot apply to tytso-ext4/dev jack-fs/for_next hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Introduce-buffered_write_operations/20240529-005213
base:   linus/master
patch link:    https://lore.kernel.org/r/20240528164829.2105447-8-willy%40infradead.org
patch subject: [PATCH 7/7] iomap: Return the folio from iomap_write_begin()
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20240529/202405290732.YLYLE1Zi-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405290732.YLYLE1Zi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405290732.YLYLE1Zi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/iomap/buffered-io.c:9:
   In file included from include/linux/iomap.h:7:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/iomap/buffered-io.c:9:
   In file included from include/linux/iomap.h:7:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/iomap/buffered-io.c:9:
   In file included from include/linux/iomap.h:7:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/iomap/buffered-io.c:9:
   In file included from include/linux/iomap.h:7:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> fs/iomap/buffered-io.c:802:7: warning: variable 'status' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     802 |                 if (!iomap_valid) {
         |                     ^~~~~~~~~~~~
   fs/iomap/buffered-io.c:826:17: note: uninitialized use occurs here
     826 |         return ERR_PTR(status);
         |                        ^~~~~~
   fs/iomap/buffered-io.c:802:3: note: remove the 'if' if its condition is always false
     802 |                 if (!iomap_valid) {
         |                 ^~~~~~~~~~~~~~~~~~~
     803 |                         iter->iomap.flags |= IOMAP_F_STALE;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     804 |                         goto out_unlock;
         |                         ~~~~~~~~~~~~~~~~
     805 |                 }
         |                 ~
   fs/iomap/buffered-io.c:773:12: note: initialize the variable 'status' to silence this warning
     773 |         int status;
         |                   ^
         |                    = 0
   8 warnings generated.


vim +802 fs/iomap/buffered-io.c

69f4a26c1e0c7c Gao Xiang               2021-08-03  766  
07d07cfe38427e Matthew Wilcox (Oracle  2024-05-28  767) static struct folio *iomap_write_begin(struct iomap_iter *iter, loff_t pos,
07d07cfe38427e Matthew Wilcox (Oracle  2024-05-28  768) 		size_t len)
afc51aaa22f26c Darrick J. Wong         2019-07-15  769  {
471859f57d4253 Andreas Gruenbacher     2023-01-15  770  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
fad0a1ab34f777 Christoph Hellwig       2021-08-10  771  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
d1bd0b4ebfe052 Matthew Wilcox (Oracle  2021-11-03  772) 	struct folio *folio;
07d07cfe38427e Matthew Wilcox (Oracle  2024-05-28  773) 	int status;
afc51aaa22f26c Darrick J. Wong         2019-07-15  774  
1b5c1e36dc0e0f Christoph Hellwig       2021-08-10  775  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
1b5c1e36dc0e0f Christoph Hellwig       2021-08-10  776  	if (srcmap != &iter->iomap)
c039b997927263 Goldwyn Rodrigues       2019-10-18  777  		BUG_ON(pos + len > srcmap->offset + srcmap->length);
afc51aaa22f26c Darrick J. Wong         2019-07-15  778  
afc51aaa22f26c Darrick J. Wong         2019-07-15  779  	if (fatal_signal_pending(current))
07d07cfe38427e Matthew Wilcox (Oracle  2024-05-28  780) 		return ERR_PTR(-EINTR);
afc51aaa22f26c Darrick J. Wong         2019-07-15  781  
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09  782) 	if (!mapping_large_folio_support(iter->inode->i_mapping))
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09  783) 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09  784) 
07c22b56685dd7 Andreas Gruenbacher     2023-01-15  785  	folio = __iomap_get_folio(iter, pos, len);
9060bc4d3aca61 Andreas Gruenbacher     2023-01-15  786  	if (IS_ERR(folio))
07d07cfe38427e Matthew Wilcox (Oracle  2024-05-28  787) 		return folio;
d7b64041164ca1 Dave Chinner            2022-11-29  788  
d7b64041164ca1 Dave Chinner            2022-11-29  789  	/*
d7b64041164ca1 Dave Chinner            2022-11-29  790  	 * Now we have a locked folio, before we do anything with it we need to
d7b64041164ca1 Dave Chinner            2022-11-29  791  	 * check that the iomap we have cached is not stale. The inode extent
d7b64041164ca1 Dave Chinner            2022-11-29  792  	 * mapping can change due to concurrent IO in flight (e.g.
d7b64041164ca1 Dave Chinner            2022-11-29  793  	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
d7b64041164ca1 Dave Chinner            2022-11-29  794  	 * reclaimed a previously partially written page at this index after IO
d7b64041164ca1 Dave Chinner            2022-11-29  795  	 * completion before this write reaches this file offset) and hence we
d7b64041164ca1 Dave Chinner            2022-11-29  796  	 * could do the wrong thing here (zero a page range incorrectly or fail
d7b64041164ca1 Dave Chinner            2022-11-29  797  	 * to zero) and corrupt data.
d7b64041164ca1 Dave Chinner            2022-11-29  798  	 */
471859f57d4253 Andreas Gruenbacher     2023-01-15  799  	if (folio_ops && folio_ops->iomap_valid) {
471859f57d4253 Andreas Gruenbacher     2023-01-15  800  		bool iomap_valid = folio_ops->iomap_valid(iter->inode,
d7b64041164ca1 Dave Chinner            2022-11-29  801  							 &iter->iomap);
d7b64041164ca1 Dave Chinner            2022-11-29 @802  		if (!iomap_valid) {
d7b64041164ca1 Dave Chinner            2022-11-29  803  			iter->iomap.flags |= IOMAP_F_STALE;
d7b64041164ca1 Dave Chinner            2022-11-29  804  			goto out_unlock;
d7b64041164ca1 Dave Chinner            2022-11-29  805  		}
d7b64041164ca1 Dave Chinner            2022-11-29  806  	}
d7b64041164ca1 Dave Chinner            2022-11-29  807  
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09  808) 	if (pos + len > folio_pos(folio) + folio_size(folio))
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09  809) 		len = folio_pos(folio) + folio_size(folio) - pos;
afc51aaa22f26c Darrick J. Wong         2019-07-15  810  
c039b997927263 Goldwyn Rodrigues       2019-10-18  811  	if (srcmap->type == IOMAP_INLINE)
bc6123a84a71b5 Matthew Wilcox (Oracle  2021-05-02  812) 		status = iomap_write_begin_inline(iter, folio);
1b5c1e36dc0e0f Christoph Hellwig       2021-08-10  813  	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
d1bd0b4ebfe052 Matthew Wilcox (Oracle  2021-11-03  814) 		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
afc51aaa22f26c Darrick J. Wong         2019-07-15  815  	else
bc6123a84a71b5 Matthew Wilcox (Oracle  2021-05-02  816) 		status = __iomap_write_begin(iter, pos, len, folio);
afc51aaa22f26c Darrick J. Wong         2019-07-15  817  
afc51aaa22f26c Darrick J. Wong         2019-07-15  818  	if (unlikely(status))
afc51aaa22f26c Darrick J. Wong         2019-07-15  819  		goto out_unlock;
afc51aaa22f26c Darrick J. Wong         2019-07-15  820  
07d07cfe38427e Matthew Wilcox (Oracle  2024-05-28  821) 	return folio;
afc51aaa22f26c Darrick J. Wong         2019-07-15  822  
afc51aaa22f26c Darrick J. Wong         2019-07-15  823  out_unlock:
7a70a5085ed028 Andreas Gruenbacher     2023-01-15  824  	__iomap_put_folio(iter, pos, 0, folio);
afc51aaa22f26c Darrick J. Wong         2019-07-15  825  
07d07cfe38427e Matthew Wilcox (Oracle  2024-05-28  826) 	return ERR_PTR(status);
afc51aaa22f26c Darrick J. Wong         2019-07-15  827  }
afc51aaa22f26c Darrick J. Wong         2019-07-15  828  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-20383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F57D8D28CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 01:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FE31C248A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 23:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35F13FD6B;
	Tue, 28 May 2024 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUq42k4J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644F13F43B;
	Tue, 28 May 2024 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939778; cv=none; b=qcPE3pmLgtYKtYZURo0XofS+Di6uVNMX6Zvio8uzXXi/D2vTc20LVrWQOLFmHBLC3JjZU2lOOyDCJmxanw+zhzidzO5h0LLHgCG0lmbqa2R0og4QuGkcqx8QrHD3CTNd9aT6xivk5fTRv2UBP8cRCvzxHViRXcI2C3TPGLkKHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939778; c=relaxed/simple;
	bh=KcjPY5SJnd0eiA9+BlsLrswqW7Klqo/AjPPcGTCEdHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVDMXh3RWrsLFPQMym41QI3TD6zuHTJ3W1W1dGocr5GxbUfwlUw8ePfSPDA+5K3O/AP2mF7WWxifVW6StcQ/gKEXKFPXrPTdmUQ35PAf4msgQnGEhA7eIRenpwzzWQzTRL+Abd43D1Lf+fRjK1oe/qRGFe6dgNAxsTZvMJywbVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUq42k4J; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716939776; x=1748475776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KcjPY5SJnd0eiA9+BlsLrswqW7Klqo/AjPPcGTCEdHc=;
  b=KUq42k4J51iLQdzMxykoviehWAXM/8BUhbxdMeOdpF+9O4KQsOH8+PB2
   wjZj/i7MqbsBUl+D0evKuJsfol1TgA6+tV6bChVH9n8RCHjFLVoieC31X
   iQNR5XzOXsWJ7pYwp6ovOrl83i71Y8b7iUFtH4fme7+O3LFRX6ERA3nQD
   aQXTVc5EQrxjuenqlJsZPChQnb4tb0qSasMYN674td8ytRZdtxAt5mUrY
   zjDrelIxM6sqfNJHEt4TwOEjCEsRzQaM6TbEJJg2BndnVKCR5ImiwfK8M
   ze9B6+t0v3ey3XIUyJXoPJKw9/O0MdwRCLXY97vcLXKMJH5GzLhQ1zPeu
   w==;
X-CSE-ConnectionGUID: vUr9cObdRdahMbjn8AsP8A==
X-CSE-MsgGUID: BYyhUzVFSu2PHvlJjNOzHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13157175"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13157175"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:42:54 -0700
X-CSE-ConnectionGUID: DywyVgqnTZq2s/0WS4uMmA==
X-CSE-MsgGUID: q2jI9BgzTKe9Dy/ANqrnTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72676221"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 28 May 2024 16:42:52 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sC6Sv-000Csn-27;
	Tue, 28 May 2024 23:42:49 +0000
Date: Wed, 29 May 2024 07:42:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/7] ext4: Convert to buffered_write_operations
Message-ID: <202405290727.QWBqNxqa-lkp@intel.com>
References: <20240528164829.2105447-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528164829.2105447-7-willy@infradead.org>

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
patch link:    https://lore.kernel.org/r/20240528164829.2105447-7-willy%40infradead.org
patch subject: [PATCH 6/7] ext4: Convert to buffered_write_operations
config: hexagon-defconfig (https://download.01.org/0day-ci/archive/20240529/202405290727.QWBqNxqa-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405290727.QWBqNxqa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405290727.QWBqNxqa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ext4/inline.c:7:
   In file included from include/linux/iomap.h:7:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/ext4/inline.c:7:
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
   In file included from fs/ext4/inline.c:7:
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
   In file included from fs/ext4/inline.c:7:
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
>> fs/ext4/inline.c:914:7: warning: variable 'folio' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     914 |                 if (ret == -ENOSPC &&
         |                     ^~~~~~~~~~~~~~~~~
     915 |                     ext4_should_retry_alloc(inode->i_sb, &retries))
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ext4/inline.c:956:9: note: uninitialized use occurs here
     956 |         return folio;
         |                ^~~~~
   fs/ext4/inline.c:914:3: note: remove the 'if' if its condition is always true
     914 |                 if (ret == -ENOSPC &&
         |                 ^~~~~~~~~~~~~~~~~~~~~
     915 |                     ext4_should_retry_alloc(inode->i_sb, &retries))
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     916 |                         goto retry_journal;
>> fs/ext4/inline.c:914:7: warning: variable 'folio' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
     914 |                 if (ret == -ENOSPC &&
         |                     ^~~~~~~~~~~~~~
   fs/ext4/inline.c:956:9: note: uninitialized use occurs here
     956 |         return folio;
         |                ^~~~~
   fs/ext4/inline.c:914:7: note: remove the '&&' if its condition is always true
     914 |                 if (ret == -ENOSPC &&
         |                     ^~~~~~~~~~~~~~~~~
>> fs/ext4/inline.c:907:6: warning: variable 'folio' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     907 |         if (ret && ret != -ENOSPC)
         |             ^~~~~~~~~~~~~~~~~~~~~
   fs/ext4/inline.c:956:9: note: uninitialized use occurs here
     956 |         return folio;
         |                ^~~~~
   fs/ext4/inline.c:907:2: note: remove the 'if' if its condition is always false
     907 |         if (ret && ret != -ENOSPC)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
     908 |                 goto out_journal;
         |                 ~~~~~~~~~~~~~~~~
   fs/ext4/inline.c:901:6: warning: variable 'folio' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     901 |         if (IS_ERR(handle)) {
         |             ^~~~~~~~~~~~~~
   fs/ext4/inline.c:956:9: note: uninitialized use occurs here
     956 |         return folio;
         |                ^~~~~
   fs/ext4/inline.c:901:2: note: remove the 'if' if its condition is always false
     901 |         if (IS_ERR(handle)) {
         |         ^~~~~~~~~~~~~~~~~~~~~
     902 |                 ret = PTR_ERR(handle);
         |                 ~~~~~~~~~~~~~~~~~~~~~~
     903 |                 goto out;
         |                 ~~~~~~~~~
     904 |         }
         |         ~
   fs/ext4/inline.c:891:21: note: initialize the variable 'folio' to silence this warning
     891 |         struct folio *folio;
         |                            ^
         |                             = NULL
   11 warnings generated.


vim +914 fs/ext4/inline.c

9c3569b50f12e47 Tao Ma                  2012-12-10  877  
9c3569b50f12e47 Tao Ma                  2012-12-10  878  /*
9c3569b50f12e47 Tao Ma                  2012-12-10  879   * Prepare the write for the inline data.
8d6ce136790268f Shijie Luo              2020-01-23  880   * If the data can be written into the inode, we just read
9c3569b50f12e47 Tao Ma                  2012-12-10  881   * the page and make it uptodate, and start the journal.
9c3569b50f12e47 Tao Ma                  2012-12-10  882   * Otherwise read the page, makes it dirty so that it can be
9c3569b50f12e47 Tao Ma                  2012-12-10  883   * handle in writepages(the i_disksize update is left to the
9c3569b50f12e47 Tao Ma                  2012-12-10  884   * normal ext4_da_write_end).
9c3569b50f12e47 Tao Ma                  2012-12-10  885   */
8ca000469995a1f Matthew Wilcox (Oracle  2024-05-28  886) struct folio *ext4_da_write_inline_data_begin(struct address_space *mapping,
8ca000469995a1f Matthew Wilcox (Oracle  2024-05-28  887) 		struct inode *inode, loff_t pos, size_t len)
9c3569b50f12e47 Tao Ma                  2012-12-10  888  {
09355d9d038a159 Ritesh Harjani          2022-01-17  889  	int ret;
9c3569b50f12e47 Tao Ma                  2012-12-10  890  	handle_t *handle;
9a9d01f081ea29a Matthew Wilcox          2023-03-24  891  	struct folio *folio;
9c3569b50f12e47 Tao Ma                  2012-12-10  892  	struct ext4_iloc iloc;
625ef8a3acd111d Lukas Czerner           2018-10-02  893  	int retries = 0;
9c3569b50f12e47 Tao Ma                  2012-12-10  894  
9c3569b50f12e47 Tao Ma                  2012-12-10  895  	ret = ext4_get_inode_loc(inode, &iloc);
9c3569b50f12e47 Tao Ma                  2012-12-10  896  	if (ret)
8ca000469995a1f Matthew Wilcox (Oracle  2024-05-28  897) 		return ERR_PTR(ret);
9c3569b50f12e47 Tao Ma                  2012-12-10  898  
bc0ca9df3b2abb1 Jan Kara                2014-01-06  899  retry_journal:
9924a92a8c21757 Theodore Ts'o           2013-02-08  900  	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
9c3569b50f12e47 Tao Ma                  2012-12-10  901  	if (IS_ERR(handle)) {
9c3569b50f12e47 Tao Ma                  2012-12-10  902  		ret = PTR_ERR(handle);
9c3569b50f12e47 Tao Ma                  2012-12-10  903  		goto out;
9c3569b50f12e47 Tao Ma                  2012-12-10  904  	}
9c3569b50f12e47 Tao Ma                  2012-12-10  905  
9c3569b50f12e47 Tao Ma                  2012-12-10  906  	ret = ext4_prepare_inline_data(handle, inode, pos + len);
9c3569b50f12e47 Tao Ma                  2012-12-10 @907  	if (ret && ret != -ENOSPC)
52e4477758eef45 Jan Kara                2014-01-06  908  		goto out_journal;
9c3569b50f12e47 Tao Ma                  2012-12-10  909  
9c3569b50f12e47 Tao Ma                  2012-12-10  910  	if (ret == -ENOSPC) {
8bc1379b82b8e80 Theodore Ts'o           2018-06-16  911  		ext4_journal_stop(handle);
9c3569b50f12e47 Tao Ma                  2012-12-10  912  		ret = ext4_da_convert_inline_data_to_extent(mapping,
8ca000469995a1f Matthew Wilcox (Oracle  2024-05-28  913) 							    inode);
bc0ca9df3b2abb1 Jan Kara                2014-01-06 @914  		if (ret == -ENOSPC &&
bc0ca9df3b2abb1 Jan Kara                2014-01-06  915  		    ext4_should_retry_alloc(inode->i_sb, &retries))
bc0ca9df3b2abb1 Jan Kara                2014-01-06  916  			goto retry_journal;
9c3569b50f12e47 Tao Ma                  2012-12-10  917  		goto out;
9c3569b50f12e47 Tao Ma                  2012-12-10  918  	}
9c3569b50f12e47 Tao Ma                  2012-12-10  919  
36d116e99da7e45 Matthew Wilcox (Oracle  2022-02-22  920) 	/*
36d116e99da7e45 Matthew Wilcox (Oracle  2022-02-22  921) 	 * We cannot recurse into the filesystem as the transaction
36d116e99da7e45 Matthew Wilcox (Oracle  2022-02-22  922) 	 * is already started.
36d116e99da7e45 Matthew Wilcox (Oracle  2022-02-22  923) 	 */
9a9d01f081ea29a Matthew Wilcox          2023-03-24  924  	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
9a9d01f081ea29a Matthew Wilcox          2023-03-24  925  					mapping_gfp_mask(mapping));
8ca000469995a1f Matthew Wilcox (Oracle  2024-05-28  926) 	if (IS_ERR(folio))
52e4477758eef45 Jan Kara                2014-01-06  927  		goto out_journal;
9c3569b50f12e47 Tao Ma                  2012-12-10  928  
9c3569b50f12e47 Tao Ma                  2012-12-10  929  	down_read(&EXT4_I(inode)->xattr_sem);
9c3569b50f12e47 Tao Ma                  2012-12-10  930  	if (!ext4_has_inline_data(inode)) {
9c3569b50f12e47 Tao Ma                  2012-12-10  931  		ret = 0;
9c3569b50f12e47 Tao Ma                  2012-12-10  932  		goto out_release_page;
9c3569b50f12e47 Tao Ma                  2012-12-10  933  	}
9c3569b50f12e47 Tao Ma                  2012-12-10  934  
9a9d01f081ea29a Matthew Wilcox          2023-03-24  935  	if (!folio_test_uptodate(folio)) {
6b87fbe4155007c Matthew Wilcox          2023-03-24  936  		ret = ext4_read_inline_folio(inode, folio);
9c3569b50f12e47 Tao Ma                  2012-12-10  937  		if (ret < 0)
9c3569b50f12e47 Tao Ma                  2012-12-10  938  			goto out_release_page;
9c3569b50f12e47 Tao Ma                  2012-12-10  939  	}
188c299e2a26cc3 Jan Kara                2021-08-16  940  	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
188c299e2a26cc3 Jan Kara                2021-08-16  941  					    EXT4_JTR_NONE);
362eca70b53389b Theodore Ts'o           2018-07-10  942  	if (ret)
362eca70b53389b Theodore Ts'o           2018-07-10  943  		goto out_release_page;
9c3569b50f12e47 Tao Ma                  2012-12-10  944  
9c3569b50f12e47 Tao Ma                  2012-12-10  945  	up_read(&EXT4_I(inode)->xattr_sem);
8ca000469995a1f Matthew Wilcox (Oracle  2024-05-28  946) 	goto out;
9c3569b50f12e47 Tao Ma                  2012-12-10  947  out_release_page:
9c3569b50f12e47 Tao Ma                  2012-12-10  948  	up_read(&EXT4_I(inode)->xattr_sem);
9a9d01f081ea29a Matthew Wilcox          2023-03-24  949  	folio_unlock(folio);
9a9d01f081ea29a Matthew Wilcox          2023-03-24  950  	folio_put(folio);
8ca000469995a1f Matthew Wilcox (Oracle  2024-05-28  951) 	folio = ERR_PTR(ret);
52e4477758eef45 Jan Kara                2014-01-06  952  out_journal:
9c3569b50f12e47 Tao Ma                  2012-12-10  953  	ext4_journal_stop(handle);
52e4477758eef45 Jan Kara                2014-01-06  954  out:
9c3569b50f12e47 Tao Ma                  2012-12-10  955  	brelse(iloc.bh);
8ca000469995a1f Matthew Wilcox (Oracle  2024-05-28  956) 	return folio;
9c3569b50f12e47 Tao Ma                  2012-12-10  957  }
9c3569b50f12e47 Tao Ma                  2012-12-10  958  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


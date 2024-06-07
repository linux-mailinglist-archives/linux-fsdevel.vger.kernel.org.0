Return-Path: <linux-fsdevel+bounces-21169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183BE90010D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD811C22DFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC9916F902;
	Fri,  7 Jun 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+fAN17D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37515EFB0
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756677; cv=none; b=AWAsB7F5Jj2ZEW7BqelLhOmSyoiLz9xVdGPNY+59QnnjcprADIzWHpd2WTB98P8fqtulkc0BGx8ygf3ePC178PPFdLxs0/2Esqm105vrMGC9E7EWfkzXc/7FyuKiVuyUEELdqvzFK6gsjtL2pPZTkYx7piG/OllBtUh7W1lPj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756677; c=relaxed/simple;
	bh=KXKX2hpoqPDyjxFWwHbVt7FldDYd6Q2Z1q6izU5a+38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W8bEciZ3Z0VniHqD/0FjFZLKRqCWLN8sXHfCpNp+XWakhKHjnR9R4agpaUkKs4Vtvz2Vg8ounP8ot/oWdFwxLUImT6Tr7LsfSUosYMAn1j8yGUByUlhfVc+dkjJ+IkiHKXiPxHD74IgYBT43Q7qOz+Fj+QA2rk7qyaWebCG3ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+fAN17D; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717756675; x=1749292675;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KXKX2hpoqPDyjxFWwHbVt7FldDYd6Q2Z1q6izU5a+38=;
  b=Q+fAN17D6SelEc06B+sceyHpo0XPOB8qh2B/GEL2LEte30Nvkdr7f1kj
   /caO6l1Gwv/UJ47IZnnPJwJjytHcZFQknnzE+Y9bdqAQg9XZmLUnJwU0l
   36kFaShauTyFTBSBPwA3n0jsjkquXgAvu6sL2e1YCpOEJkiBBYqWP1K2z
   V7jbmWXvnT1L9fCqzyGDqWfzfWVSQDC70SHaf6xVCA1cIzofBIeNImXxy
   zoFWbByMvH9Be7bn/uSCC+cxSykTVZmcJ1zg3dZhLt1pIVkF4zsPerJRc
   K/R2R2B9k+DKA6INh2k2WjgFD0psjpoG0CQL2diYkxQOtGxBP+a3aSPAq
   g==;
X-CSE-ConnectionGUID: pdaVN0p2R42FLD4PUW80sQ==
X-CSE-MsgGUID: N0BcZT+fSl+TdxUIMFDSIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="17399461"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="17399461"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 03:37:54 -0700
X-CSE-ConnectionGUID: qNLH/A35Q5GalO00ljY1Ag==
X-CSE-MsgGUID: oH8b4QRfSUO+xegJPHxCbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="42740648"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 07 Jun 2024 03:37:52 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFWyk-0004eM-2V;
	Fri, 07 Jun 2024 10:37:50 +0000
Date: Fri, 7 Jun 2024 18:36:52 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.fd 11/19] fs/ocfs2/cluster/heartbeat.c:1784:3: error:
 cannot jump from this goto statement to its label
Message-ID: <202406071842.7tICjBRZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
head:   e0288728ff8a4703675c4c8e2ea8a0122b7675f6
commit: 3cc074209e634318e4f9fd4a813dae7703d2aa78 [11/19] switch simple users of fdget() to CLASS(fd, ...)
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240607/202406071842.7tICjBRZ-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406071842.7tICjBRZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406071842.7tICjBRZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/ocfs2/cluster/heartbeat.c:25:
   In file included from fs/ocfs2/cluster/tcp.h:15:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from fs/ocfs2/cluster/heartbeat.c:25:
   In file included from fs/ocfs2/cluster/tcp.h:15:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from fs/ocfs2/cluster/heartbeat.c:25:
   In file included from fs/ocfs2/cluster/tcp.h:15:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> fs/ocfs2/cluster/heartbeat.c:1784:3: error: cannot jump from this goto statement to its label
    1784 |                 goto out;
         |                 ^
   fs/ocfs2/cluster/heartbeat.c:1786:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1786 |         CLASS(fd, f)(fd);
         |                   ^
   fs/ocfs2/cluster/heartbeat.c:1781:3: error: cannot jump from this goto statement to its label
    1781 |                 goto out;
         |                 ^
   fs/ocfs2/cluster/heartbeat.c:1786:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1786 |         CLASS(fd, f)(fd);
         |                   ^
   fs/ocfs2/cluster/heartbeat.c:1777:3: error: cannot jump from this goto statement to its label
    1777 |                 goto out;
         |                 ^
   fs/ocfs2/cluster/heartbeat.c:1786:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1786 |         CLASS(fd, f)(fd);
         |                   ^
   fs/ocfs2/cluster/heartbeat.c:1772:3: error: cannot jump from this goto statement to its label
    1772 |                 goto out;
         |                 ^
   fs/ocfs2/cluster/heartbeat.c:1786:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1786 |         CLASS(fd, f)(fd);
         |                   ^
   17 warnings and 4 errors generated.


vim +1784 fs/ocfs2/cluster/heartbeat.c

a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1754  
ebc4185497eac6 Jan Kara          2023-09-27  1755  /*
1d3aa0b97c5567 Christian Brauner 2024-01-23  1756   * this is acting as commit; we set up all of hr_bdev_file and hr_task or
ebc4185497eac6 Jan Kara          2023-09-27  1757   * nothing
ebc4185497eac6 Jan Kara          2023-09-27  1758   */
45b997737a8025 Christoph Hellwig 2015-10-03  1759  static ssize_t o2hb_region_dev_store(struct config_item *item,
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1760  				     const char *page,
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1761  				     size_t count)
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1762  {
45b997737a8025 Christoph Hellwig 2015-10-03  1763  	struct o2hb_region *reg = to_o2hb_region(item);
e6c352dbc0f4dc Joel Becker       2007-02-03  1764  	struct task_struct *hb_task;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1765  	long fd;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1766  	int sectsize;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1767  	char *p = (char *)page;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1768  	ssize_t ret = -EINVAL;
76d9fc2954d057 Sunil Mushran     2011-05-04  1769  	int live_threshold;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1770  
1d3aa0b97c5567 Christian Brauner 2024-01-23  1771  	if (reg->hr_bdev_file)
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1772  		goto out;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1773  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1774  	/* We can't heartbeat without having had our node number
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1775  	 * configured yet. */
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1776  	if (o2nm_this_node() == O2NM_MAX_NODES)
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1777  		goto out;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1778  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1779  	fd = simple_strtol(p, &p, 0);
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1780  	if (!p || (*p && (*p != '\n')))
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1781  		goto out;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1782  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1783  	if (fd < 0 || fd >= INT_MAX)
a7f6a5fb4bde14 Mark Fasheh       2005-12-15 @1784  		goto out;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1785  
3cc074209e6343 Al Viro           2024-05-31  1786  	CLASS(fd, f)(fd);
3cc074209e6343 Al Viro           2024-05-31  1787  	if (fd_empty(f))
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1788  		goto out;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1789  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1790  	if (reg->hr_blocks == 0 || reg->hr_start_block == 0 ||
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1791  	    reg->hr_block_bytes == 0)
3cc074209e6343 Al Viro           2024-05-31  1792  		goto out;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1793  
516384815d6105 Al Viro           2024-05-31  1794  	if (!S_ISBLK(fd_file(f)->f_mapping->host->i_mode))
3cc074209e6343 Al Viro           2024-05-31  1795  		goto out;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1796  
516384815d6105 Al Viro           2024-05-31  1797  	reg->hr_bdev_file = bdev_file_open_by_dev(fd_file(f)->f_mapping->host->i_rdev,
ebc4185497eac6 Jan Kara          2023-09-27  1798  			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
1d3aa0b97c5567 Christian Brauner 2024-01-23  1799  	if (IS_ERR(reg->hr_bdev_file)) {
1d3aa0b97c5567 Christian Brauner 2024-01-23  1800  		ret = PTR_ERR(reg->hr_bdev_file);
1d3aa0b97c5567 Christian Brauner 2024-01-23  1801  		reg->hr_bdev_file = NULL;
3cc074209e6343 Al Viro           2024-05-31  1802  		goto out;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1803  	}
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1804  
ebc4185497eac6 Jan Kara          2023-09-27  1805  	sectsize = bdev_logical_block_size(reg_bdev(reg));
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1806  	if (sectsize != reg->hr_block_bytes) {
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1807  		mlog(ML_ERROR,
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1808  		     "blocksize %u incorrect for device, expected %d",
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1809  		     reg->hr_block_bytes, sectsize);
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1810  		ret = -EINVAL;
2903ff019b346a Al Viro           2012-08-28  1811  		goto out3;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1812  	}
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1813  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1814  	o2hb_init_region_params(reg);
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1815  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1816  	/* Generation of zero is invalid */
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1817  	do {
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1818  		get_random_bytes(&reg->hr_generation,
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1819  				 sizeof(reg->hr_generation));
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1820  	} while (reg->hr_generation == 0);
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1821  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1822  	ret = o2hb_map_slot_data(reg);
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1823  	if (ret) {
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1824  		mlog_errno(ret);
2903ff019b346a Al Viro           2012-08-28  1825  		goto out3;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1826  	}
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1827  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1828  	ret = o2hb_populate_slot_data(reg);
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1829  	if (ret) {
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1830  		mlog_errno(ret);
2903ff019b346a Al Viro           2012-08-28  1831  		goto out3;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1832  	}
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1833  
c4028958b6ecad David Howells     2006-11-22  1834  	INIT_DELAYED_WORK(&reg->hr_write_timeout_work, o2hb_write_timeout);
e0cbb79805083b Junxiao Bi        2016-05-27  1835  	INIT_DELAYED_WORK(&reg->hr_nego_timeout_work, o2hb_nego_timeout);
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1836  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1837  	/*
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1838  	 * A node is considered live after it has beat LIVE_THRESHOLD
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1839  	 * times.  We're not steady until we've given them a chance
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1840  	 * _after_ our first read.
76d9fc2954d057 Sunil Mushran     2011-05-04  1841  	 * The default threshold is bare minimum so as to limit the delay
76d9fc2954d057 Sunil Mushran     2011-05-04  1842  	 * during mounts. For global heartbeat, the threshold doubled for the
76d9fc2954d057 Sunil Mushran     2011-05-04  1843  	 * first region.
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1844  	 */
76d9fc2954d057 Sunil Mushran     2011-05-04  1845  	live_threshold = O2HB_LIVE_THRESHOLD;
76d9fc2954d057 Sunil Mushran     2011-05-04  1846  	if (o2hb_global_heartbeat_active()) {
76d9fc2954d057 Sunil Mushran     2011-05-04  1847  		spin_lock(&o2hb_live_lock);
a8f70de37bbb99 Akinobu Mita      2013-11-12  1848  		if (bitmap_weight(o2hb_region_bitmap, O2NM_MAX_REGIONS) == 1)
76d9fc2954d057 Sunil Mushran     2011-05-04  1849  			live_threshold <<= 1;
76d9fc2954d057 Sunil Mushran     2011-05-04  1850  		spin_unlock(&o2hb_live_lock);
76d9fc2954d057 Sunil Mushran     2011-05-04  1851  	}
d2eece376648d2 Sunil Mushran     2011-07-24  1852  	++live_threshold;
d2eece376648d2 Sunil Mushran     2011-07-24  1853  	atomic_set(&reg->hr_steady_iterations, live_threshold);
a84ac334dcb44c Junxiao Bi        2016-01-14  1854  	/* unsteady_iterations is triple the steady_iterations */
a84ac334dcb44c Junxiao Bi        2016-01-14  1855  	atomic_set(&reg->hr_unsteady_iterations, (live_threshold * 3));
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1856  
e6c352dbc0f4dc Joel Becker       2007-02-03  1857  	hb_task = kthread_run(o2hb_thread, reg, "o2hb-%s",
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1858  			      reg->hr_item.ci_name);
e6c352dbc0f4dc Joel Becker       2007-02-03  1859  	if (IS_ERR(hb_task)) {
e6c352dbc0f4dc Joel Becker       2007-02-03  1860  		ret = PTR_ERR(hb_task);
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1861  		mlog_errno(ret);
2903ff019b346a Al Viro           2012-08-28  1862  		goto out3;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1863  	}
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1864  
e6c352dbc0f4dc Joel Becker       2007-02-03  1865  	spin_lock(&o2hb_live_lock);
e6c352dbc0f4dc Joel Becker       2007-02-03  1866  	reg->hr_task = hb_task;
e6c352dbc0f4dc Joel Becker       2007-02-03  1867  	spin_unlock(&o2hb_live_lock);
e6c352dbc0f4dc Joel Becker       2007-02-03  1868  
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1869  	ret = wait_event_interruptible(o2hb_steady_queue,
0986fe9b50f425 Joseph Qi         2015-11-05  1870  				atomic_read(&reg->hr_steady_iterations) == 0 ||
0986fe9b50f425 Joseph Qi         2015-11-05  1871  				reg->hr_node_deleted);
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1872  	if (ret) {
d2eece376648d2 Sunil Mushran     2011-07-24  1873  		atomic_set(&reg->hr_steady_iterations, 0);
d2eece376648d2 Sunil Mushran     2011-07-24  1874  		reg->hr_aborted_start = 1;
d2eece376648d2 Sunil Mushran     2011-07-24  1875  	}
e6c352dbc0f4dc Joel Becker       2007-02-03  1876  
d2eece376648d2 Sunil Mushran     2011-07-24  1877  	if (reg->hr_aborted_start) {
d2eece376648d2 Sunil Mushran     2011-07-24  1878  		ret = -EIO;
2903ff019b346a Al Viro           2012-08-28  1879  		goto out3;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1880  	}
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1881  
0986fe9b50f425 Joseph Qi         2015-11-05  1882  	if (reg->hr_node_deleted) {
0986fe9b50f425 Joseph Qi         2015-11-05  1883  		ret = -EINVAL;
0986fe9b50f425 Joseph Qi         2015-11-05  1884  		goto out3;
0986fe9b50f425 Joseph Qi         2015-11-05  1885  	}
0986fe9b50f425 Joseph Qi         2015-11-05  1886  
e6df3a663a5d1e Joel Becker       2007-02-06  1887  	/* Ok, we were woken.  Make sure it wasn't by drop_item() */
e6df3a663a5d1e Joel Becker       2007-02-06  1888  	spin_lock(&o2hb_live_lock);
e6df3a663a5d1e Joel Becker       2007-02-06  1889  	hb_task = reg->hr_task;
e7d656baf6607a Sunil Mushran     2010-10-06  1890  	if (o2hb_global_heartbeat_active())
e7d656baf6607a Sunil Mushran     2010-10-06  1891  		set_bit(reg->hr_region_num, o2hb_live_region_bitmap);
e6df3a663a5d1e Joel Becker       2007-02-06  1892  	spin_unlock(&o2hb_live_lock);
e6df3a663a5d1e Joel Becker       2007-02-06  1893  
e6df3a663a5d1e Joel Becker       2007-02-06  1894  	if (hb_task)
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1895  		ret = count;
e6df3a663a5d1e Joel Becker       2007-02-06  1896  	else
e6df3a663a5d1e Joel Becker       2007-02-06  1897  		ret = -EIO;
e6df3a663a5d1e Joel Becker       2007-02-06  1898  
18c50cb0d3c293 Sunil Mushran     2010-10-06  1899  	if (hb_task && o2hb_global_heartbeat_active())
4664954c9421ce Christoph Hellwig 2022-07-13  1900  		printk(KERN_NOTICE "o2hb: Heartbeat started on region %s (%pg)\n",
ebc4185497eac6 Jan Kara          2023-09-27  1901  		       config_item_name(&reg->hr_item), reg_bdev(reg));
18c50cb0d3c293 Sunil Mushran     2010-10-06  1902  
2903ff019b346a Al Viro           2012-08-28  1903  out3:
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1904  	if (ret < 0) {
1d3aa0b97c5567 Christian Brauner 2024-01-23  1905  		fput(reg->hr_bdev_file);
1d3aa0b97c5567 Christian Brauner 2024-01-23  1906  		reg->hr_bdev_file = NULL;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1907  	}
e455ed22906c02 Christoph Hellwig 2020-09-21  1908  out:
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1909  	return ret;
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1910  }
a7f6a5fb4bde14 Mark Fasheh       2005-12-15  1911  

:::::: The code at line 1784 was first introduced by commit
:::::: a7f6a5fb4bde142b622706e2006ba33f793e13ed [PATCH] OCFS2: The Second Oracle Cluster Filesystem

:::::: TO: Mark Fasheh <mark.fasheh@oracle.com>
:::::: CC: Joel Becker <joel.becker@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


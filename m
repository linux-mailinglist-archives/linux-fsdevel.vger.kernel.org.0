Return-Path: <linux-fsdevel+bounces-21171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 205AC900128
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906B31F23724
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB6186295;
	Fri,  7 Jun 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdF+Jfe1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E117B4FB
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757337; cv=none; b=tbQuKfdVZGjJZK5l1qUxgLTQTTPs/ThmBchhqVyJh6gYRw+0AOJUUCyIywyK9ujNvijC6R+QGp1MIxM8ZVAuF+FuUYlMskYLWsIeb4yAwYb1ugGCNkH0ajfwu/N5J6lV5gnPC+vWc+2ZlRYU6CiuSUcx+6G/DdIrpuG9Htqn7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757337; c=relaxed/simple;
	bh=UdJ8pqCZTZN19Q75F6lxK3JlggntmwXkgFnQMXmM408=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KNL+HvI1Sgn+lsx0lBPxwOl76XJH9Uxbehm5b8e+foTiE/zElm6GbZG5ZNXBFWUSnTZFYSu6uTFetdUQRrNljvLG6cslUdwB5fGNiVMxeybv0QBoNNK8FG+oOI0PxOCrZf5fl4XA/3ydYohIhAsQYSu0tjW7QGdkmvx6NUmFloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdF+Jfe1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717757335; x=1749293335;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UdJ8pqCZTZN19Q75F6lxK3JlggntmwXkgFnQMXmM408=;
  b=UdF+Jfe1xK4V5gd6/0neNLm+tforXmRVY+BPeIMRsEvOnVXxg32bhfgW
   vYia4aEPxb1aF1Yl6SzTHx7z//8c4rulsNYXmjR1p2g1HPRr9EfLUDtlG
   a0j1GaJ6lhM8FtKAAhB01ShCuwxbpY0ZRYr7tSZ8A96qC8JzYRDW1Hyle
   U7Y6gtVGi+j/qHnw5EK9JMIZyIAg1jax9wI3dENill+Ic/KkrgySvogi/
   r7jmjav+BRypPStCMmFWONFYjdUrrc8ix4tkEmTZ+wQq6rFeDbnNk2Mji
   qxqrzENY/zEVrJigE8zlhRoabE+a4LIeSx5tHjstt2RMjDQLv0+o/EGW6
   w==;
X-CSE-ConnectionGUID: H32R2Ff9REyiw6yP00YsXQ==
X-CSE-MsgGUID: m5LBsmBaQVmz7sjFW43kmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14653180"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14653180"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 03:48:55 -0700
X-CSE-ConnectionGUID: y/MTbcz/QdusSpzniVd+XQ==
X-CSE-MsgGUID: RQe78EPVRjOxFQ/T9NmWkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38140049"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 07 Jun 2024 03:48:53 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFX9P-0004f8-0d;
	Fri, 07 Jun 2024 10:48:51 +0000
Date: Fri, 7 Jun 2024 18:47:54 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.fd 11/19] fs/select.c:860:3: error: cannot jump from
 this goto statement to its label
Message-ID: <202406071836.yx9rpD7U-lkp@intel.com>
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
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240607/202406071836.yx9rpD7U-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406071836.yx9rpD7U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406071836.yx9rpD7U-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/select.c:22:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:5:
   In file included from include/linux/tracepoint.h:22:
   In file included from include/linux/static_call.h:135:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/select.c:33:
   In file included from include/net/busy_poll.h:15:
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
   In file included from fs/select.c:33:
   In file included from include/net/busy_poll.h:15:
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
   In file included from fs/select.c:33:
   In file included from include/net/busy_poll.h:15:
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
>> fs/select.c:860:3: error: cannot jump from this goto statement to its label
     860 |                 goto out;
         |                 ^
   fs/select.c:862:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
     862 |         CLASS(fd, f)(fd);
         |                   ^
   13 warnings and 1 error generated.


vim +860 fs/select.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  844  
4a4b69f79ba728 Vadim Lobanov     2006-06-23  845  /*
4a4b69f79ba728 Vadim Lobanov     2006-06-23  846   * Fish for pollable events on the pollfd->fd file descriptor. We're only
4a4b69f79ba728 Vadim Lobanov     2006-06-23  847   * interested in events matching the pollfd->events mask, and the result
4a4b69f79ba728 Vadim Lobanov     2006-06-23  848   * matching that mask is both recorded in pollfd->revents and returned. The
4a4b69f79ba728 Vadim Lobanov     2006-06-23  849   * pwait poll_table will be used by the fd-provided poll handler for waiting,
626cf236608505 Hans Verkuil      2012-03-23  850   * if pwait->_qproc is non-NULL.
4a4b69f79ba728 Vadim Lobanov     2006-06-23  851   */
fb3679372bd796 Al Viro           2017-07-16  852  static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
cbf55001b2ddb8 Eliezer Tamir     2013-07-08  853  				     bool *can_busy_poll,
fb3679372bd796 Al Viro           2017-07-16  854  				     __poll_t busy_flag)
^1da177e4c3f41 Linus Torvalds    2005-04-16  855  {
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  856  	int fd = pollfd->fd;
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  857  	__poll_t mask = 0, filter;
^1da177e4c3f41 Linus Torvalds    2005-04-16  858  
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  859  	if (fd < 0)
a0f8dcfc607d8d Christoph Hellwig 2018-03-05 @860  		goto out;
a9a08845e9acbd Linus Torvalds    2018-02-11  861  	mask = EPOLLNVAL;
3cc074209e6343 Al Viro           2024-05-31  862  	CLASS(fd, f)(fd);
3cc074209e6343 Al Viro           2024-05-31  863  	if (fd_empty(f))
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  864  		goto out;
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  865  
fb3679372bd796 Al Viro           2017-07-16  866  	/* userland u16 ->events contains POLL... bitmap */
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  867  	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  868  	pwait->_key = filter | busy_flag;
516384815d6105 Al Viro           2024-05-31  869  	mask = vfs_poll(fd_file(f), pwait);
cbf55001b2ddb8 Eliezer Tamir     2013-07-08  870  	if (mask & busy_flag)
cbf55001b2ddb8 Eliezer Tamir     2013-07-08  871  		*can_busy_poll = true;
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  872  	mask &= filter;		/* Mask out unneeded events. */
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  873  
a0f8dcfc607d8d Christoph Hellwig 2018-03-05  874  out:
fb3679372bd796 Al Viro           2017-07-16  875  	/* ... and so does ->revents */
c71d227fc4133f Al Viro           2017-11-29  876  	pollfd->revents = mangle_poll(mask);
4a4b69f79ba728 Vadim Lobanov     2006-06-23  877  	return mask;
^1da177e4c3f41 Linus Torvalds    2005-04-16  878  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  879  

:::::: The code at line 860 was first introduced by commit
:::::: a0f8dcfc607d8d113090ff36eee2ee406463bb0e fs: cleanup do_pollfd

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


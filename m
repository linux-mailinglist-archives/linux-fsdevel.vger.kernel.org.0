Return-Path: <linux-fsdevel+bounces-25596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DB94DD44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 16:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652C0B21042
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6153415FA92;
	Sat, 10 Aug 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lORvRQ2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3C15855D
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Aug 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723300107; cv=none; b=k6PhQedwPEkSC6CKKIHyqat3AL4BCvXz1BcXmKG53hwfaQVdJalFX0WXpD1w8JrAK68t/qs6ngh9+ds2eJZQ5zYoN5swFyJK998PVgQFSZ7kBvblrpBddow1bEW8cPQNdvid7nXlVv3ZWfsnOfArQEAHsRZO9Idqsy89a4+bBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723300107; c=relaxed/simple;
	bh=lkOT+UCDJQm437RHMwQ8TUrYFAd62KM9GJ4l6tm7S4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j0bp9wM2EQ1QI2Bj4C6BBd3AC6rsPTeqVcmpZ2mnzdrX04aC663hHE9YaYDN5L6bpA1bVi6O3+p2yr0SU6pcGNsMP7uIfrHtJ2vlzPb9rID1V4EY4Jdcn7nPhOVK8mxJcmmAZfpUgmYwNyI8vi6Oy/lhKL931j52Zu4j3do3yyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lORvRQ2u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723300106; x=1754836106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lkOT+UCDJQm437RHMwQ8TUrYFAd62KM9GJ4l6tm7S4o=;
  b=lORvRQ2u3WPPN2XHdyDRvdURF8SqXTiCcbdtzy6P4kbCuXxTtIVUz2US
   6C4TdgSvLPXP1JFnHpT5lNSO6MdGA6BB8nRk6psGcKjXyiB2gkJVIMRem
   gZpPdSw2hIb/xK5NlqmYmtMFnmId2rdx3mIKUnnXXPAD4phIX55OCGtqI
   vWhfR3NikV5oWdOraEbBKXbygYyJazKRdqULnAXWzkWw4DQIkJRh/DZzu
   QfRzDfkRxfoWYs+4cRxg+1tvabpWL2UaNNnbl6hHo1+w5fa/Qid78ZwbU
   krWVgmV5KluTL1pk3mFOHr6iebHj01ZR+cbE1KZxx9+/UVWHHHYMIqSs6
   A==;
X-CSE-ConnectionGUID: b7B+TQoERZCZaAGa4Z23Lw==
X-CSE-MsgGUID: 43HFMzQHReewYwzJAbmm6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="32873191"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="32873191"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 07:28:25 -0700
X-CSE-ConnectionGUID: /ZwGlQOMQIifn0yngAIWaA==
X-CSE-MsgGUID: t8ukzf9mQdeXC3SBr+e0wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="57782414"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 10 Aug 2024 07:28:23 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scn4v-000A0x-17;
	Sat, 10 Aug 2024 14:28:21 +0000
Date: Sat, 10 Aug 2024 22:28:03 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [viro-vfs:work.fd 3/39] fs/namei.c:2499:27: warning: comparison of
 distinct pointer types ('struct file *' and 'typeof (*(((struct task_struct
 *const)get_lowcore()->current_task)->cred)) *' (aka 'const struct cred *'))
Message-ID: <202408102222.D1kJSPiW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
head:   9d58a36411c167b4126de90e5fe844270b858082
commit: f3270beef0d85432783be702bb9509879415e747 [3/39] struct fd: representation change
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240810/202408102222.D1kJSPiW-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408102222.D1kJSPiW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408102222.D1kJSPiW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bpf.h:20:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:458:10: warning: array index 3 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:42: warning: array index 2 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:53: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from fs/namei.c:41:
   In file included from include/linux/init_task.h:18:
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
   In file included from fs/namei.c:41:
   In file included from include/linux/init_task.h:18:
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
   In file included from fs/namei.c:41:
   In file included from include/linux/init_task.h:18:
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
   fs/namei.c:2496:4: error: expected ')'
    2496 |                         return ERR_PTR(-EBADF);
         |                         ^
   fs/namei.c:2495:6: note: to match this '('
    2495 |                 if (!fd_file(f))
         |                    ^
   fs/namei.c:2499:20: error: member reference type 'unsigned long' is not a pointer
    2499 |                         if (fd_file(f)->f_cred != current_cred() &&
         |                             ~~~~~~~~~~  ^
>> fs/namei.c:2499:27: warning: comparison of distinct pointer types ('struct file *' and 'typeof (*(((struct task_struct *const)get_lowcore()->current_task)->cred)) *' (aka 'const struct cred *')) [-Wcompare-distinct-pointer-types]
    2499 |                         if (fd_file(f)->f_cred != current_cred() &&
         |                             ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/namei.c:2500:32: error: member reference type 'unsigned long' is not a pointer
    2500 |                             !ns_capable(fd_file(f)->f_cred->user_ns, CAP_DAC_READ_SEARCH)) {
         |                                         ~~~~~~~~~~  ^
   fs/namei.c:2500:69: error: too few arguments to function call, expected 2, have 1
    2500 |                             !ns_capable(fd_file(f)->f_cred->user_ns, CAP_DAC_READ_SEARCH)) {
         |                              ~~~~~~~~~~                                                  ^
   include/linux/capability.h:149:13: note: 'ns_capable' declared here
     149 | extern bool ns_capable(struct user_namespace *ns, int cap);
         |             ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/namei.c:2500:71: error: expected ')'
    2500 |                             !ns_capable(fd_file(f)->f_cred->user_ns, CAP_DAC_READ_SEARCH)) {
         |                                                                                            ^
   fs/namei.c:2499:8: note: to match this '('
    2499 |                         if (fd_file(f)->f_cred != current_cred() &&
         |                             ^
   include/linux/file.h:49:20: note: expanded from macro 'fd_file'
      49 | #define fd_file(f) ((struct file *)((f).word & ~(FDPUT_FPUT|FDPUT_POS_UNLOCK))
         |                    ^
   fs/namei.c:2504:3: error: expected ')'
    2504 |                 }
         |                 ^
   fs/namei.c:2499:7: note: to match this '('
    2499 |                         if (fd_file(f)->f_cred != current_cred() &&
         |                            ^
   fs/namei.c:2504:3: error: expected statement
    2504 |                 }
         |                 ^
   fs/namei.c:2506:24: error: member reference type 'unsigned long' is not a pointer
    2506 |                 dentry = fd_file(f)->f_path.dentry;
         |                          ~~~~~~~~~~  ^
   fs/namei.c:2506:37: error: expected ')'
    2506 |                 dentry = fd_file(f)->f_path.dentry;
         |                                                   ^
   fs/namei.c:2506:12: note: to match this '('
    2506 |                 dentry = fd_file(f)->f_path.dentry;
         |                          ^
   include/linux/file.h:49:20: note: expanded from macro 'fd_file'
      49 | #define fd_file(f) ((struct file *)((f).word & ~(FDPUT_FPUT|FDPUT_POS_UNLOCK))
         |                    ^
   fs/namei.c:2506:10: error: incompatible pointer types assigning to 'struct dentry *' from 'struct file *' [-Werror,-Wincompatible-pointer-types]
    2506 |                 dentry = fd_file(f)->f_path.dentry;
         |                        ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/namei.c:2513:26: error: member reference type 'unsigned long' is not a pointer
    2513 |                 nd->path = fd_file(f)->f_path;
         |                            ~~~~~~~~~~  ^
   fs/namei.c:2513:32: error: expected ')'
    2513 |                 nd->path = fd_file(f)->f_path;
         |                                              ^
   fs/namei.c:2513:14: note: to match this '('
    2513 |                 nd->path = fd_file(f)->f_path;
         |                            ^
   include/linux/file.h:49:20: note: expanded from macro 'fd_file'
      49 | #define fd_file(f) ((struct file *)((f).word & ~(FDPUT_FPUT|FDPUT_POS_UNLOCK))
         |                    ^
   fs/namei.c:2513:12: error: assigning to 'struct path' from incompatible type 'struct file *'
    2513 |                 nd->path = fd_file(f)->f_path;
         |                          ^ ~~~~~~~~~~~~~~~~~~
   26 warnings and 15 errors generated.


vim +2499 fs/namei.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  2423  
edc2b1da779887 Al Viro         2018-07-09  2424  /* must be paired with terminate_walk() */
c8a53ee5ee4fca Al Viro         2015-05-12  2425  static const char *path_init(struct nameidata *nd, unsigned flags)
31e6b01f4183ff Nicholas Piggin 2011-01-07  2426  {
740a16782750a5 Aleksa Sarai    2019-12-07  2427  	int error;
c8a53ee5ee4fca Al Viro         2015-05-12  2428  	const char *s = nd->name->name;
31e6b01f4183ff Nicholas Piggin 2011-01-07  2429  
6c6ec2b0a3e038 Jens Axboe      2020-12-17  2430  	/* LOOKUP_CACHED requires RCU, ask caller to retry */
6c6ec2b0a3e038 Jens Axboe      2020-12-17  2431  	if ((flags & (LOOKUP_RCU | LOOKUP_CACHED)) == LOOKUP_CACHED)
6c6ec2b0a3e038 Jens Axboe      2020-12-17  2432  		return ERR_PTR(-EAGAIN);
6c6ec2b0a3e038 Jens Axboe      2020-12-17  2433  
c0eb027e5aef70 Linus Torvalds  2017-04-02  2434  	if (!*s)
c0eb027e5aef70 Linus Torvalds  2017-04-02  2435  		flags &= ~LOOKUP_RCU;
edc2b1da779887 Al Viro         2018-07-09  2436  	if (flags & LOOKUP_RCU)
edc2b1da779887 Al Viro         2018-07-09  2437  		rcu_read_lock();
03fa86e9f79d8b Al Viro         2022-07-04  2438  	else
03fa86e9f79d8b Al Viro         2022-07-04  2439  		nd->seq = nd->next_seq = 0;
c0eb027e5aef70 Linus Torvalds  2017-04-02  2440  
bcba1e7d0d520a Al Viro         2021-04-01  2441  	nd->flags = flags;
bcba1e7d0d520a Al Viro         2021-04-01  2442  	nd->state |= ND_JUMPED;
ab87f9a56c8ee9 Aleksa Sarai    2019-12-07  2443  
ab87f9a56c8ee9 Aleksa Sarai    2019-12-07  2444  	nd->m_seq = __read_seqcount_begin(&mount_lock.seqcount);
ab87f9a56c8ee9 Aleksa Sarai    2019-12-07  2445  	nd->r_seq = __read_seqcount_begin(&rename_lock.seqcount);
ab87f9a56c8ee9 Aleksa Sarai    2019-12-07  2446  	smp_rmb();
ab87f9a56c8ee9 Aleksa Sarai    2019-12-07  2447  
bcba1e7d0d520a Al Viro         2021-04-01  2448  	if (nd->state & ND_ROOT_PRESET) {
b18825a7c8e37a David Howells   2013-09-12  2449  		struct dentry *root = nd->root.dentry;
b18825a7c8e37a David Howells   2013-09-12  2450  		struct inode *inode = root->d_inode;
93893862fb7ba7 Al Viro         2017-04-15  2451  		if (*s && unlikely(!d_can_lookup(root)))
368ee9ba565d6e Al Viro         2015-05-08  2452  			return ERR_PTR(-ENOTDIR);
5b6ca027d85b74 Al Viro         2011-03-09  2453  		nd->path = nd->root;
5b6ca027d85b74 Al Viro         2011-03-09  2454  		nd->inode = inode;
5b6ca027d85b74 Al Viro         2011-03-09  2455  		if (flags & LOOKUP_RCU) {
ab87f9a56c8ee9 Aleksa Sarai    2019-12-07  2456  			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
8f47a0167c567d Al Viro         2015-05-09  2457  			nd->root_seq = nd->seq;
5b6ca027d85b74 Al Viro         2011-03-09  2458  		} else {
5b6ca027d85b74 Al Viro         2011-03-09  2459  			path_get(&nd->path);
5b6ca027d85b74 Al Viro         2011-03-09  2460  		}
368ee9ba565d6e Al Viro         2015-05-08  2461  		return s;
5b6ca027d85b74 Al Viro         2011-03-09  2462  	}
5b6ca027d85b74 Al Viro         2011-03-09  2463  
31e6b01f4183ff Nicholas Piggin 2011-01-07  2464  	nd->root.mnt = NULL;
31e6b01f4183ff Nicholas Piggin 2011-01-07  2465  
8db52c7e7ee1bd Aleksa Sarai    2019-12-07  2466  	/* Absolute pathname -- fetch the root (LOOKUP_IN_ROOT uses nd->dfd). */
8db52c7e7ee1bd Aleksa Sarai    2019-12-07  2467  	if (*s == '/' && !(flags & LOOKUP_IN_ROOT)) {
740a16782750a5 Aleksa Sarai    2019-12-07  2468  		error = nd_jump_root(nd);
740a16782750a5 Aleksa Sarai    2019-12-07  2469  		if (unlikely(error))
740a16782750a5 Aleksa Sarai    2019-12-07  2470  			return ERR_PTR(error);
ef55d91700d54f Al Viro         2015-12-05  2471  		return s;
8db52c7e7ee1bd Aleksa Sarai    2019-12-07  2472  	}
8db52c7e7ee1bd Aleksa Sarai    2019-12-07  2473  
8db52c7e7ee1bd Aleksa Sarai    2019-12-07  2474  	/* Relative pathname -- get the starting-point it is relative to. */
8db52c7e7ee1bd Aleksa Sarai    2019-12-07  2475  	if (nd->dfd == AT_FDCWD) {
e41f7d4ee5bdb0 Al Viro         2011-02-22  2476  		if (flags & LOOKUP_RCU) {
31e6b01f4183ff Nicholas Piggin 2011-01-07  2477  			struct fs_struct *fs = current->fs;
c28cc36469554d Nicholas Piggin 2011-01-07  2478  			unsigned seq;
31e6b01f4183ff Nicholas Piggin 2011-01-07  2479  
c28cc36469554d Nicholas Piggin 2011-01-07  2480  			do {
c28cc36469554d Nicholas Piggin 2011-01-07  2481  				seq = read_seqcount_begin(&fs->seq);
31e6b01f4183ff Nicholas Piggin 2011-01-07  2482  				nd->path = fs->pwd;
ef55d91700d54f Al Viro         2015-12-05  2483  				nd->inode = nd->path.dentry->d_inode;
c28cc36469554d Nicholas Piggin 2011-01-07  2484  				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
c28cc36469554d Nicholas Piggin 2011-01-07  2485  			} while (read_seqcount_retry(&fs->seq, seq));
e41f7d4ee5bdb0 Al Viro         2011-02-22  2486  		} else {
e41f7d4ee5bdb0 Al Viro         2011-02-22  2487  			get_fs_pwd(current->fs, &nd->path);
ef55d91700d54f Al Viro         2015-12-05  2488  			nd->inode = nd->path.dentry->d_inode;
e41f7d4ee5bdb0 Al Viro         2011-02-22  2489  		}
31e6b01f4183ff Nicholas Piggin 2011-01-07  2490  	} else {
582aa64a04a579 Jeff Layton     2012-12-11  2491  		/* Caller must check execute permissions on the starting path component */
c8a53ee5ee4fca Al Viro         2015-05-12  2492  		struct fd f = fdget_raw(nd->dfd);
31e6b01f4183ff Nicholas Piggin 2011-01-07  2493  		struct dentry *dentry;
31e6b01f4183ff Nicholas Piggin 2011-01-07  2494  
254beb4164efec Al Viro         2024-05-31  2495  		if (!fd_file(f))
368ee9ba565d6e Al Viro         2015-05-08  2496  			return ERR_PTR(-EBADF);
31e6b01f4183ff Nicholas Piggin 2011-01-07  2497  
42bd2af5950456 Linus Torvalds  2024-04-10  2498  		if (flags & LOOKUP_LINKAT_EMPTY) {
254beb4164efec Al Viro         2024-05-31 @2499  			if (fd_file(f)->f_cred != current_cred() &&
254beb4164efec Al Viro         2024-05-31  2500  			    !ns_capable(fd_file(f)->f_cred->user_ns, CAP_DAC_READ_SEARCH)) {
42bd2af5950456 Linus Torvalds  2024-04-10  2501  				fdput(f);
42bd2af5950456 Linus Torvalds  2024-04-10  2502  				return ERR_PTR(-ENOENT);
42bd2af5950456 Linus Torvalds  2024-04-10  2503  			}
42bd2af5950456 Linus Torvalds  2024-04-10  2504  		}
42bd2af5950456 Linus Torvalds  2024-04-10  2505  
254beb4164efec Al Viro         2024-05-31  2506  		dentry = fd_file(f)->f_path.dentry;
31e6b01f4183ff Nicholas Piggin 2011-01-07  2507  
edc2b1da779887 Al Viro         2018-07-09  2508  		if (*s && unlikely(!d_can_lookup(dentry))) {
2903ff019b346a Al Viro         2012-08-28  2509  			fdput(f);
368ee9ba565d6e Al Viro         2015-05-08  2510  			return ERR_PTR(-ENOTDIR);
2903ff019b346a Al Viro         2012-08-28  2511  		}
31e6b01f4183ff Nicholas Piggin 2011-01-07  2512  
254beb4164efec Al Viro         2024-05-31  2513  		nd->path = fd_file(f)->f_path;
e41f7d4ee5bdb0 Al Viro         2011-02-22  2514  		if (flags & LOOKUP_RCU) {
34a26b99b78148 Al Viro         2015-05-11  2515  			nd->inode = nd->path.dentry->d_inode;
34a26b99b78148 Al Viro         2015-05-11  2516  			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
5590ff0d5528b6 Ulrich Drepper  2006-01-18  2517  		} else {
2903ff019b346a Al Viro         2012-08-28  2518  			path_get(&nd->path);
34a26b99b78148 Al Viro         2015-05-11  2519  			nd->inode = nd->path.dentry->d_inode;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2520  		}
34a26b99b78148 Al Viro         2015-05-11  2521  		fdput(f);
e41f7d4ee5bdb0 Al Viro         2011-02-22  2522  	}
8db52c7e7ee1bd Aleksa Sarai    2019-12-07  2523  
adb21d2b526f7f Aleksa Sarai    2019-12-07  2524  	/* For scoped-lookups we need to set the root to the dirfd as well. */
adb21d2b526f7f Aleksa Sarai    2019-12-07  2525  	if (flags & LOOKUP_IS_SCOPED) {
adb21d2b526f7f Aleksa Sarai    2019-12-07  2526  		nd->root = nd->path;
adb21d2b526f7f Aleksa Sarai    2019-12-07  2527  		if (flags & LOOKUP_RCU) {
adb21d2b526f7f Aleksa Sarai    2019-12-07  2528  			nd->root_seq = nd->seq;
adb21d2b526f7f Aleksa Sarai    2019-12-07  2529  		} else {
adb21d2b526f7f Aleksa Sarai    2019-12-07  2530  			path_get(&nd->root);
bcba1e7d0d520a Al Viro         2021-04-01  2531  			nd->state |= ND_ROOT_GRABBED;
adb21d2b526f7f Aleksa Sarai    2019-12-07  2532  		}
adb21d2b526f7f Aleksa Sarai    2019-12-07  2533  	}
adb21d2b526f7f Aleksa Sarai    2019-12-07  2534  	return s;
9b4a9b14a793bc Al Viro         2009-04-07  2535  }
9b4a9b14a793bc Al Viro         2009-04-07  2536  

:::::: The code at line 2499 was first introduced by commit
:::::: 254beb4164efececb3e7b85019e0102c36e86e62 introduce fd_file(), convert all accessors to it.

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


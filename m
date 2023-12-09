Return-Path: <linux-fsdevel+bounces-5420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA780B6D8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 23:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342F91C2084B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 22:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4B1E517;
	Sat,  9 Dec 2023 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OG/GZDzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD6B125;
	Sat,  9 Dec 2023 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702160933; x=1733696933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=go2OpyoHuQJfkvWrYMKtRz7dEGNntOkffUckFpnEvWM=;
  b=OG/GZDzs2z6yc8VBw5qpXV9u+0TxJParyizd2mpfQPHxqZjSRPrlFrEl
   SqFhhiRBltbAdkWmrBnNggFwDNJbYFSA8kfmnR71s9LWXVgkTBKvUWoji
   Zzb5+t145OamoiMl52Nh+qDlUBs8/4JrpjHZp/fDAsCI8uYhhUjiX/MtQ
   aQLTbj8Ro/eyMBmUjXV6/Y9/bIsqJXq0B8oYoV2lz2Xn55BSC9a+p+3W2
   eFVNZO6sulShr7e8h9s5PmguGXiZ/Wgdt2rV76DozIVcKOrdpGGhAQjkn
   BuLQQxvwjwHsiJOULYwM/PyyDIMvONqrZEx8pZa0HFPTVR2D3TNQG+s9t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="398389814"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="398389814"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 14:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="772505822"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="772505822"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2023 14:28:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rC5oR-000G2z-0M;
	Sat, 09 Dec 2023 22:28:43 +0000
Date: Sun, 10 Dec 2023 06:28:38 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com,
	gregory.price@memverge.com, corbet@lwn.net, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	peterz@infradead.org, jgroves@micron.com, ravis.opensrc@micron.com,
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com
Subject: Re: [PATCH v2 11/11] mm/mempolicy: extend set_mempolicy2 and mbind2
 to support weighted interleave
Message-ID: <202312100606.2aOpv2T5-lkp@intel.com>
References: <20231209065931.3458-12-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209065931.3458-12-gregory.price@memverge.com>

Hi Gregory,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on deller-parisc/for-next powerpc/next powerpc/fixes s390/features jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master linus/master v6.7-rc4]
[cannot apply to tip/x86/asm geert-m68k/for-next geert-m68k/for-linus next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/mm-mempolicy-implement-the-sysfs-based-weighted_interleave-interface/20231209-150314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231209065931.3458-12-gregory.price%40memverge.com
patch subject: [PATCH v2 11/11] mm/mempolicy: extend set_mempolicy2 and mbind2 to support weighted interleave
config: x86_64-randconfig-123-20231210 (https://download.01.org/0day-ci/archive/20231210/202312100606.2aOpv2T5-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100606.2aOpv2T5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100606.2aOpv2T5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   mm/mempolicy.c: note: in included file (through include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h, ...):
   include/linux/rcupdate.h:778:9: sparse: sparse: context imbalance in 'queue_folios_pte_range' - unexpected unlock
   mm/mempolicy.c: note: in included file (through arch/x86/include/asm/uaccess.h, include/linux/uaccess.h, include/linux/sched/task.h, ...):
   arch/x86/include/asm/uaccess_64.h:88:24: sparse: sparse: cast removes address space '__user' of expression
>> mm/mempolicy.c:1681:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *weights_ptr @@     got void [noderef] __user * @@
   mm/mempolicy.c:1681:29: sparse:     expected unsigned char *weights_ptr
   mm/mempolicy.c:1681:29: sparse:     got void [noderef] __user *
>> mm/mempolicy.c:1684:45: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void const [noderef] __user *src @@     got unsigned char *weights_ptr @@
   mm/mempolicy.c:1684:45: sparse:     expected void const [noderef] __user *src
   mm/mempolicy.c:1684:45: sparse:     got unsigned char *weights_ptr
   mm/mempolicy.c:2042:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *weights_ptr @@     got void [noderef] __user * @@
   mm/mempolicy.c:2042:29: sparse:     expected unsigned char *weights_ptr
   mm/mempolicy.c:2042:29: sparse:     got void [noderef] __user *
>> mm/mempolicy.c:2043:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char *weights_ptr @@
   mm/mempolicy.c:2043:36: sparse:     expected void [noderef] __user *to
   mm/mempolicy.c:2043:36: sparse:     got unsigned char *weights_ptr

vim +1681 mm/mempolicy.c

  1629	
  1630	SYSCALL_DEFINE5(mbind2, const struct iovec __user *, vec, size_t, vlen,
  1631			const struct mpol_args __user *, uargs, size_t, usize,
  1632			unsigned long, flags)
  1633	{
  1634		struct mpol_args kargs;
  1635		struct mempolicy_args margs;
  1636		nodemask_t policy_nodes;
  1637		unsigned long __user *nodes_ptr;
  1638		struct iovec iovstack[UIO_FASTIOV];
  1639		struct iovec *iov = iovstack;
  1640		struct iov_iter iter;
  1641		unsigned char weights[MAX_NUMNODES];
  1642		unsigned char *weights_ptr;
  1643		int err;
  1644	
  1645		if (!vec || !vlen)
  1646			return -EINVAL;
  1647	
  1648		err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
  1649		if (err)
  1650			return -EINVAL;
  1651	
  1652		err = validate_mpol_flags(kargs.mode, &kargs.mode_flags);
  1653		if (err)
  1654			return err;
  1655	
  1656		margs.mode = kargs.mode;
  1657		margs.mode_flags = kargs.mode_flags;
  1658		margs.addr = kargs.addr;
  1659	
  1660		/* if home node given, validate it is online */
  1661		if (flags & MPOL_MF_HOME_NODE) {
  1662			if ((kargs.home_node >= MAX_NUMNODES) ||
  1663				!node_online(kargs.home_node))
  1664				return -EINVAL;
  1665			margs.home_node = kargs.home_node;
  1666		} else
  1667			margs.home_node = NUMA_NO_NODE;
  1668		flags &= ~MPOL_MF_HOME_NODE;
  1669	
  1670		if (kargs.pol_nodes) {
  1671			nodes_ptr = u64_to_user_ptr(kargs.pol_nodes);
  1672			err = get_nodes(&policy_nodes, nodes_ptr,
  1673					kargs.pol_maxnodes);
  1674			if (err)
  1675				return err;
  1676			margs.policy_nodes = &policy_nodes;
  1677		} else
  1678			margs.policy_nodes = NULL;
  1679	
  1680		if (kargs.mode == MPOL_WEIGHTED_INTERLEAVE) {
> 1681			weights_ptr = u64_to_user_ptr(kargs.il_weights);
  1682			err = copy_struct_from_user(&weights,
  1683						    sizeof(weights),
> 1684						    weights_ptr,
  1685						    kargs.pol_maxnodes);
  1686			if (err)
  1687				return err;
  1688			margs.il_weights = weights;
  1689		} else {
  1690			margs.il_weights = NULL;
  1691			flags |= MPOL_F_GWEIGHT;
  1692		}
  1693	
  1694		/* For each address range in vector, do_mbind */
  1695		err = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov,
  1696				   &iter);
  1697		if (err)
  1698			return err;
  1699		while (iov_iter_count(&iter)) {
  1700			unsigned long start, len;
  1701	
  1702			start = untagged_addr((unsigned long)iter_iov_addr(&iter));
  1703			len = iter_iov_len(&iter);
  1704			err = do_mbind(start, len, &margs, flags);
  1705			if (err)
  1706				break;
  1707			iov_iter_advance(&iter, iter_iov_len(&iter));
  1708		}
  1709	
  1710		kfree(iov);
  1711		return err;
  1712	}
  1713	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


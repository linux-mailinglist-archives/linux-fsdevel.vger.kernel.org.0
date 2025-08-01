Return-Path: <linux-fsdevel+bounces-56513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15957B18207
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DCE4E80B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CF1248871;
	Fri,  1 Aug 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHE97O80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C434524467B;
	Fri,  1 Aug 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754052975; cv=none; b=i7i70QyxrkrAGJDgAo81iZJGcCZiOxolpM2dgLHzVQX50TuuBjrKN8FXQJbNF7UJRrpLqStnEagehUPVwgFhznXl2J+XjXlsAJIBrgzrcFaGrA+KOWg4HIoHyKrgAImiNhgltC6DDV2s7W+tL0mmft4xxC3rjpUD4l/w0OMCky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754052975; c=relaxed/simple;
	bh=Rtzfcvwkul30C1tQ3bVX6Wtto5iApIgC11igXrCtIyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJss9XlcmxfR5djrsPKxLNYqtVNObuyypHDV72uhty8liRHY3tKuk3rQM6s2TtUs9xpHcOUgbK3Nf4JPwAkj8NDXExFdoz4EPHnequCSCqi4Q8LS0/FtF2l7ng+DK5EEx/KLwXJEWT1j0x3J7wV82G/WAQD6lC0ghpAWri5AquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHE97O80; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754052974; x=1785588974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rtzfcvwkul30C1tQ3bVX6Wtto5iApIgC11igXrCtIyY=;
  b=SHE97O80f0KOsTklh14ECZD0S8NxW2WzWVhnPfMfX6bmBSvnehURjw+D
   GcghGjdNOgUNeqpMz05L6X7S5EBdz7PaMKjFiX0b+6EgnmcBBOXdeYQHM
   aoO4//iI6fIV0xQNIKsMrXlc2YIAKY52WLqd6dyLCscVsAmc65fqcec1C
   Vtp9oAKp0Ip1V7byepRbOPvr/TKDuRCmWYc/QGr1+NhhFaJHn56HYIaas
   NLjj/a30lUfMBWZ4K2IDFb3eldUIhZbD+ptUhdMsgEveToQbjNcYbnzaj
   kAUvmPmCVi7vsjubAyp3Wem/G94oSE7jo1BZb9Z2105CuVivVz4kCyPnB
   w==;
X-CSE-ConnectionGUID: S7p8VNFlS5egxdNpzp+yBQ==
X-CSE-MsgGUID: x1YMLABIRQ6i8GDYQzkFug==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56478317"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56478317"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 05:56:13 -0700
X-CSE-ConnectionGUID: BGb912eYQgiEW6HwicwKVQ==
X-CSE-MsgGUID: WW8OaP5zRP2oOXCNEXCcJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="167820732"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 01 Aug 2025 05:56:06 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhpIq-0004dA-0y;
	Fri, 01 Aug 2025 12:56:04 +0000
Date: Fri, 1 Aug 2025 20:56:00 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
	david@redhat.com, vbabka@suse.cz, peterx@redhat.com,
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
	andrii@kernel.org, ryan.roberts@arm.com,
	christophe.leroy@csgroup.eu, tjmercier@google.com,
	kaleshsingh@google.com, aha310510@gmail.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	surenb@google.com
Subject: Re: [PATCH 2/3] fs/proc/task_mmu: factor out proc_maps_private
 fields used by PROCMAP_QUERY
Message-ID: <202508012010.9IA7JflG-lkp@intel.com>
References: <20250731220024.702621-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731220024.702621-3-surenb@google.com>

Hi Suren,

kernel test robot noticed the following build errors:

[auto build test ERROR on 01da54f10fddf3b01c5a3b80f6b16bbad390c302]

url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/selftests-proc-test-PROCMAP_QUERY-ioctl-while-vma-is-concurrently-modified/20250801-060200
base:   01da54f10fddf3b01c5a3b80f6b16bbad390c302
patch link:    https://lore.kernel.org/r/20250731220024.702621-3-surenb%40google.com
patch subject: [PATCH 2/3] fs/proc/task_mmu: factor out proc_maps_private fields used by PROCMAP_QUERY
config: riscv-randconfig-002-20250801 (https://download.01.org/0day-ci/archive/20250801/202508012010.9IA7JflG-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508012010.9IA7JflG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508012010.9IA7JflG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/proc/task_nommu.c:207:13: error: no member named 'mm' in 'struct proc_maps_private'
     207 |         mm = priv->mm;
         |              ~~~~  ^
   fs/proc/task_nommu.c:229:31: error: no member named 'mm' in 'struct proc_maps_private'
     229 |         struct mm_struct *mm = priv->mm;
         |                                ~~~~  ^
   fs/proc/task_nommu.c:262:8: error: no member named 'mm' in 'struct proc_maps_private'
     262 |         priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
         |         ~~~~  ^
   fs/proc/task_nommu.c:263:27: error: no member named 'mm' in 'struct proc_maps_private'
     263 |         if (IS_ERR_OR_NULL(priv->mm)) {
         |                            ~~~~  ^
   fs/proc/task_nommu.c:264:19: error: no member named 'mm' in 'struct proc_maps_private'
     264 |                 int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
         |                           ~~~~  ^
   fs/proc/task_nommu.c:264:38: error: no member named 'mm' in 'struct proc_maps_private'
     264 |                 int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
         |                                              ~~~~  ^
   fs/proc/task_nommu.c:279:12: error: no member named 'mm' in 'struct proc_maps_private'
     279 |         if (priv->mm)
         |             ~~~~  ^
   fs/proc/task_nommu.c:280:16: error: no member named 'mm' in 'struct proc_maps_private'
     280 |                 mmdrop(priv->mm);
         |                        ~~~~  ^
   8 errors generated.


vim +207 fs/proc/task_nommu.c

fe441980161751 Ben Wolsieffer          2023-09-15  191  
fe441980161751 Ben Wolsieffer          2023-09-15  192  static void *m_start(struct seq_file *m, loff_t *ppos)
^1da177e4c3f41 Linus Torvalds          2005-04-16  193  {
dbf8685c8e2140 David Howells           2006-09-27  194  	struct proc_maps_private *priv = m->private;
fe441980161751 Ben Wolsieffer          2023-09-15  195  	unsigned long last_addr = *ppos;
dbf8685c8e2140 David Howells           2006-09-27  196  	struct mm_struct *mm;
0c563f14804356 Matthew Wilcox (Oracle  2022-09-06  197) 
fe441980161751 Ben Wolsieffer          2023-09-15  198  	/* See proc_get_vma(). Zero at the start or after lseek. */
fe441980161751 Ben Wolsieffer          2023-09-15  199  	if (last_addr == -1UL)
0c563f14804356 Matthew Wilcox (Oracle  2022-09-06  200) 		return NULL;
dbf8685c8e2140 David Howells           2006-09-27  201  
dbf8685c8e2140 David Howells           2006-09-27  202  	/* pin the task and mm whilst we play with them */
2c03376d2db005 Oleg Nesterov           2014-10-09  203  	priv->task = get_proc_task(priv->inode);
dbf8685c8e2140 David Howells           2006-09-27  204  	if (!priv->task)
ec6fd8a4355cda Al Viro                 2011-02-15  205  		return ERR_PTR(-ESRCH);
dbf8685c8e2140 David Howells           2006-09-27  206  
27692cd56e2aa6 Oleg Nesterov           2014-10-09 @207  	mm = priv->mm;
578d7699e5c2ad Ben Wolsieffer          2023-09-14  208  	if (!mm || !mmget_not_zero(mm)) {
578d7699e5c2ad Ben Wolsieffer          2023-09-14  209  		put_task_struct(priv->task);
578d7699e5c2ad Ben Wolsieffer          2023-09-14  210  		priv->task = NULL;
27692cd56e2aa6 Oleg Nesterov           2014-10-09  211  		return NULL;
578d7699e5c2ad Ben Wolsieffer          2023-09-14  212  	}
dbf8685c8e2140 David Howells           2006-09-27  213  
d8ed45c5dcd455 Michel Lespinasse       2020-06-08  214  	if (mmap_read_lock_killable(mm)) {
8a713e7df3352b Konstantin Khlebnikov   2019-07-11  215  		mmput(mm);
578d7699e5c2ad Ben Wolsieffer          2023-09-14  216  		put_task_struct(priv->task);
578d7699e5c2ad Ben Wolsieffer          2023-09-14  217  		priv->task = NULL;
8a713e7df3352b Konstantin Khlebnikov   2019-07-11  218  		return ERR_PTR(-EINTR);
8a713e7df3352b Konstantin Khlebnikov   2019-07-11  219  	}
8a713e7df3352b Konstantin Khlebnikov   2019-07-11  220  
fe441980161751 Ben Wolsieffer          2023-09-15  221  	vma_iter_init(&priv->iter, mm, last_addr);
47fecca15c0944 Oleg Nesterov           2014-10-09  222  
fe441980161751 Ben Wolsieffer          2023-09-15  223  	return proc_get_vma(priv, ppos);
dbf8685c8e2140 David Howells           2006-09-27  224  }
dbf8685c8e2140 David Howells           2006-09-27  225  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


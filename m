Return-Path: <linux-fsdevel+bounces-55181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B7B07BC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 19:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE3318820C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A32F5491;
	Wed, 16 Jul 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYNDzC3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E91A841F;
	Wed, 16 Jul 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685631; cv=none; b=rC89sz9WDA2rvqPjPsfoAYf6YJIfKUPWIYHshwbx28QbqDj8iii5P8s2QA7lXIpCzuzvuRMIlWjbQXKoMdnqBzVMQM0rsJ/ZF9+73QqRY+ohyLnjN5hnDKNbJtwfD45C2eQsiw+xcp2AF5/JfLzO8i9VezWhafSVKO2b6lhksbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685631; c=relaxed/simple;
	bh=ozLL/QFmo2pHoj2feRI+FxBikPSiw+DVoWzCKsX0F7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdQ8RloUUpxlwDwMPS95dB2MMrrdsVvqQ9n7CtAqlctqebfPKb42JTf4OTXn2uN1dBuG3iove0WnbpiWiuRUQsx+Ej+J/Ag5SmLLU0QmuPht+BzzL6ZGSX/Rjsb5qF3xENb/+RugaXgBFOZlC2zwa8jyARjOPU9ec1BuRW1a024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYNDzC3e; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752685626; x=1784221626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ozLL/QFmo2pHoj2feRI+FxBikPSiw+DVoWzCKsX0F7w=;
  b=XYNDzC3eEMJcaGAMOMGq5b0YORD7YiutdPElcNYuc+wAHtUdJHmCQ9xj
   g4YxQJeYIcaEWZj5d4J7icpnUvQXJvbBNwnx/x0loNODujFL1G2F2odLk
   a+M2K4XnCX7dhOjr8Jl9zKy/oYHF/9dexqp7++jD2PTmwA8rYQEvBHGxc
   G055GfJS/OsgsYOqY0JVrJGHfm97+pdkJvPoaXShgXSIEjVE717utLQf2
   pY8cTjSnfVsKFoQvSanzBEKrOxnIAzBL1ClkGYNDZuoeteeIJYBDl2cR3
   Ry/BIjxrp2np1WonbNwla7BFpRcTbYuA2p27jlMz5PkB76NDhOo2hPI4q
   A==;
X-CSE-ConnectionGUID: j98//VqDSFyyLuu38aHxxQ==
X-CSE-MsgGUID: q74EI4YBRx61V7bT/W2Dyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55062031"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="55062031"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 10:07:05 -0700
X-CSE-ConnectionGUID: zAyo8EnIQBKBo6vorC2p4g==
X-CSE-MsgGUID: lnn9ExV0QgK+ytn/+P6euA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="163188380"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Jul 2025 10:07:01 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc5as-000CfR-0h;
	Wed, 16 Jul 2025 17:06:58 +0000
Date: Thu, 17 Jul 2025 01:06:26 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Gao <wegao@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Mark Brown <broonie@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Brahmajit Das <brahmajit.xyz@gmail.com>,
	Andrei Vagin <avagin@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Wei Gao <wegao@suse.com>
Subject: Re: [PATCH] fs/proc: Use inode_get_dev() for device numbers in
 procmap_query
Message-ID: <202507170038.QWz19iZa-lkp@intel.com>
References: <20250716142732.3385310-1-wegao@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716142732.3385310-1-wegao@suse.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on akpm-mm/mm-everything crng-random/master linus/master v6.16-rc6 next-20250716]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Gao/fs-proc-Use-inode_get_dev-for-device-numbers-in-procmap_query/20250716-103031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250716142732.3385310-1-wegao%40suse.com
patch subject: [PATCH] fs/proc: Use inode_get_dev() for device numbers in procmap_query
config: i386-buildonly-randconfig-002-20250716 (https://download.01.org/0day-ci/archive/20250717/202507170038.QWz19iZa-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507170038.QWz19iZa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507170038.QWz19iZa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/proc/task_mmu.c:521:26: error: call to undeclared function 'inode_get_dev'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     521 |                 karg.dev_major = MAJOR(inode_get_dev(inode));
         |                                        ^
   fs/proc/task_mmu.c:521:26: note: did you mean 'inode_get_bytes'?
   include/linux/fs.h:3567:8: note: 'inode_get_bytes' declared here
    3567 | loff_t inode_get_bytes(struct inode *inode);
         |        ^
   1 error generated.


vim +/inode_get_dev +521 fs/proc/task_mmu.c

   453	
   454	static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
   455	{
   456		struct procmap_query karg;
   457		struct vm_area_struct *vma;
   458		struct mm_struct *mm;
   459		const char *name = NULL;
   460		char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
   461		__u64 usize;
   462		int err;
   463	
   464		if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
   465			return -EFAULT;
   466		/* argument struct can never be that large, reject abuse */
   467		if (usize > PAGE_SIZE)
   468			return -E2BIG;
   469		/* argument struct should have at least query_flags and query_addr fields */
   470		if (usize < offsetofend(struct procmap_query, query_addr))
   471			return -EINVAL;
   472		err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
   473		if (err)
   474			return err;
   475	
   476		/* reject unknown flags */
   477		if (karg.query_flags & ~PROCMAP_QUERY_VALID_FLAGS_MASK)
   478			return -EINVAL;
   479		/* either both buffer address and size are set, or both should be zero */
   480		if (!!karg.vma_name_size != !!karg.vma_name_addr)
   481			return -EINVAL;
   482		if (!!karg.build_id_size != !!karg.build_id_addr)
   483			return -EINVAL;
   484	
   485		mm = priv->mm;
   486		if (!mm || !mmget_not_zero(mm))
   487			return -ESRCH;
   488	
   489		err = query_vma_setup(mm);
   490		if (err) {
   491			mmput(mm);
   492			return err;
   493		}
   494	
   495		vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
   496		if (IS_ERR(vma)) {
   497			err = PTR_ERR(vma);
   498			vma = NULL;
   499			goto out;
   500		}
   501	
   502		karg.vma_start = vma->vm_start;
   503		karg.vma_end = vma->vm_end;
   504	
   505		karg.vma_flags = 0;
   506		if (vma->vm_flags & VM_READ)
   507			karg.vma_flags |= PROCMAP_QUERY_VMA_READABLE;
   508		if (vma->vm_flags & VM_WRITE)
   509			karg.vma_flags |= PROCMAP_QUERY_VMA_WRITABLE;
   510		if (vma->vm_flags & VM_EXEC)
   511			karg.vma_flags |= PROCMAP_QUERY_VMA_EXECUTABLE;
   512		if (vma->vm_flags & VM_MAYSHARE)
   513			karg.vma_flags |= PROCMAP_QUERY_VMA_SHARED;
   514	
   515		karg.vma_page_size = vma_kernel_pagesize(vma);
   516	
   517		if (vma->vm_file) {
   518			const struct inode *inode = file_user_inode(vma->vm_file);
   519	
   520			karg.vma_offset = ((__u64)vma->vm_pgoff) << PAGE_SHIFT;
 > 521			karg.dev_major = MAJOR(inode_get_dev(inode));
   522			karg.dev_minor = MINOR(inode_get_dev(inode));
   523			karg.inode = inode->i_ino;
   524		} else {
   525			karg.vma_offset = 0;
   526			karg.dev_major = 0;
   527			karg.dev_minor = 0;
   528			karg.inode = 0;
   529		}
   530	
   531		if (karg.build_id_size) {
   532			__u32 build_id_sz;
   533	
   534			err = build_id_parse(vma, build_id_buf, &build_id_sz);
   535			if (err) {
   536				karg.build_id_size = 0;
   537			} else {
   538				if (karg.build_id_size < build_id_sz) {
   539					err = -ENAMETOOLONG;
   540					goto out;
   541				}
   542				karg.build_id_size = build_id_sz;
   543			}
   544		}
   545	
   546		if (karg.vma_name_size) {
   547			size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
   548			const struct path *path;
   549			const char *name_fmt;
   550			size_t name_sz = 0;
   551	
   552			get_vma_name(vma, &path, &name, &name_fmt);
   553	
   554			if (path || name_fmt || name) {
   555				name_buf = kmalloc(name_buf_sz, GFP_KERNEL);
   556				if (!name_buf) {
   557					err = -ENOMEM;
   558					goto out;
   559				}
   560			}
   561			if (path) {
   562				name = d_path(path, name_buf, name_buf_sz);
   563				if (IS_ERR(name)) {
   564					err = PTR_ERR(name);
   565					goto out;
   566				}
   567				name_sz = name_buf + name_buf_sz - name;
   568			} else if (name || name_fmt) {
   569				name_sz = 1 + snprintf(name_buf, name_buf_sz, name_fmt ?: "%s", name);
   570				name = name_buf;
   571			}
   572			if (name_sz > name_buf_sz) {
   573				err = -ENAMETOOLONG;
   574				goto out;
   575			}
   576			karg.vma_name_size = name_sz;
   577		}
   578	
   579		/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
   580		query_vma_teardown(mm, vma);
   581		mmput(mm);
   582	
   583		if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
   584						       name, karg.vma_name_size)) {
   585			kfree(name_buf);
   586			return -EFAULT;
   587		}
   588		kfree(name_buf);
   589	
   590		if (karg.build_id_size && copy_to_user(u64_to_user_ptr(karg.build_id_addr),
   591						       build_id_buf, karg.build_id_size))
   592			return -EFAULT;
   593	
   594		if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize)))
   595			return -EFAULT;
   596	
   597		return 0;
   598	
   599	out:
   600		query_vma_teardown(mm, vma);
   601		mmput(mm);
   602		kfree(name_buf);
   603		return err;
   604	}
   605	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


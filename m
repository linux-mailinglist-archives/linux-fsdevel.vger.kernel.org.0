Return-Path: <linux-fsdevel+bounces-18747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CADD8BBED4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 01:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01371C20BE9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 23:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882184FC8;
	Sat,  4 May 2024 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQeXvMD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5884DE3;
	Sat,  4 May 2024 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714865817; cv=none; b=diggkn15FaiCFGtMLow2F0qHNsy2lUhOiowCCabHODLgVnCeW9bLM5hdcY9JXabPm/fPHVkQHTJkBoNwEnzXdeTMzyq7Y2STjcd3GIIQ++VdbSzBSGTRT6G7PyydtutWsX9nG0IkKdgUN69pJbTWdRVLV/NIiBLxT2YfDMftGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714865817; c=relaxed/simple;
	bh=eNUF5q53kgcxTNwLMvW0eSWpasObSLmHaJNbFU9SVtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDm6tFNoUiSmxwOME5a5cLDMd+UFICmLGhknjLjFfR/+gfA53nhskzbgBcIMWvk5OhsZBtJ0Vlxi3OhmiXyaGLn4UlpiR1wyN7s/aXosZY6JsoJ3m/UIwClpOwaScdltcacfmMxeErGyEoRmw5m5P3TRcWK2fa4QzNdxZRHJ/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQeXvMD7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714865815; x=1746401815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eNUF5q53kgcxTNwLMvW0eSWpasObSLmHaJNbFU9SVtA=;
  b=gQeXvMD7nZNQW+FMw7liXSRJUoJqAnLcVs0YUPOTmmBx3tyNMSdivooZ
   NJZuEQjBhPWKVjXBj8K6dxrp0jVxD3MZtf97XB8mYqO0VEEpD/hwi9E4f
   lSjFrZ1OlPUL2+DEgVKSrBXIURwxV617LEgZHwT4mnHrB5B3IKqC8ob7R
   jqtPWJVZ2jbkWRrnoe56Mm7lwTpcEHNePGp6xPZyHLTitsSQHzr6UYuBg
   I6NzWpj5rP2ndturxqMZ/NHk22WGz+OwMOwPtGFNebs+vg8tluQoRQmxi
   ipmwCwaSN6WDkjAga0U+II5EhFKT7T8uBkTPjoQ+R+0/mn/g0LswpQ7ti
   Q==;
X-CSE-ConnectionGUID: W0oN3Ep7S6CGbutpB3alvw==
X-CSE-MsgGUID: doErS0d3RM+hdfTRgNBaxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14451890"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14451890"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 16:36:55 -0700
X-CSE-ConnectionGUID: C1P0q9J8Suqwy51IYvURXw==
X-CSE-MsgGUID: RveStZAaRqCY5o4QYl2m4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="50977820"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 May 2024 16:36:52 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3Ovx-000DGS-31;
	Sat, 04 May 2024 23:36:49 +0000
Date: Sun, 5 May 2024 07:36:27 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for
 /proc/<pid>/maps
Message-ID: <202405050750.5oyajnPF-lkp@intel.com>
References: <20240504003006.3303334-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504003006.3303334-3-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240503]
[also build test WARNING on v6.9-rc6]
[cannot apply to bpf-next/master bpf/master perf-tools-next/perf-tools-next tip/perf/core perf-tools/perf-tools brauner-vfs/vfs.all linus/master acme/perf/core v6.9-rc6 v6.9-rc5 v6.9-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/fs-procfs-extract-logic-for-getting-VMA-name-constituents/20240504-083146
base:   next-20240503
patch link:    https://lore.kernel.org/r/20240504003006.3303334-3-andrii%40kernel.org
patch subject: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240505/202405050750.5oyajnPF-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240505/202405050750.5oyajnPF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405050750.5oyajnPF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/proc/task_mmu.c: In function 'do_procmap_query':
>> fs/proc/task_mmu.c:505:48: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     505 |         if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
         |                                                ^
   fs/proc/task_mmu.c:512:48: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     512 |         if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
         |                                                ^


vim +505 fs/proc/task_mmu.c

   378	
   379	static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
   380	{
   381		struct procfs_procmap_query karg;
   382		struct vma_iterator iter;
   383		struct vm_area_struct *vma;
   384		struct mm_struct *mm;
   385		const char *name = NULL;
   386		char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
   387		__u64 usize;
   388		int err;
   389	
   390		if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
   391			return -EFAULT;
   392		if (usize > PAGE_SIZE)
   393			return -E2BIG;
   394		if (usize < offsetofend(struct procfs_procmap_query, query_addr))
   395			return -EINVAL;
   396		err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
   397		if (err)
   398			return err;
   399	
   400		if (karg.query_flags & ~PROCFS_PROCMAP_EXACT_OR_NEXT_VMA)
   401			return -EINVAL;
   402		if (!!karg.vma_name_size != !!karg.vma_name_addr)
   403			return -EINVAL;
   404		if (!!karg.build_id_size != !!karg.build_id_addr)
   405			return -EINVAL;
   406	
   407		mm = priv->mm;
   408		if (!mm || !mmget_not_zero(mm))
   409			return -ESRCH;
   410		if (mmap_read_lock_killable(mm)) {
   411			mmput(mm);
   412			return -EINTR;
   413		}
   414	
   415		vma_iter_init(&iter, mm, karg.query_addr);
   416		vma = vma_next(&iter);
   417		if (!vma) {
   418			err = -ENOENT;
   419			goto out;
   420		}
   421		/* user wants covering VMA, not the closest next one */
   422		if (!(karg.query_flags & PROCFS_PROCMAP_EXACT_OR_NEXT_VMA) &&
   423		    vma->vm_start > karg.query_addr) {
   424			err = -ENOENT;
   425			goto out;
   426		}
   427	
   428		karg.vma_start = vma->vm_start;
   429		karg.vma_end = vma->vm_end;
   430	
   431		if (vma->vm_file) {
   432			const struct inode *inode = file_user_inode(vma->vm_file);
   433	
   434			karg.vma_offset = ((__u64)vma->vm_pgoff) << PAGE_SHIFT;
   435			karg.dev_major = MAJOR(inode->i_sb->s_dev);
   436			karg.dev_minor = MINOR(inode->i_sb->s_dev);
   437			karg.inode = inode->i_ino;
   438		} else {
   439			karg.vma_offset = 0;
   440			karg.dev_major = 0;
   441			karg.dev_minor = 0;
   442			karg.inode = 0;
   443		}
   444	
   445		karg.vma_flags = 0;
   446		if (vma->vm_flags & VM_READ)
   447			karg.vma_flags |= PROCFS_PROCMAP_VMA_READABLE;
   448		if (vma->vm_flags & VM_WRITE)
   449			karg.vma_flags |= PROCFS_PROCMAP_VMA_WRITABLE;
   450		if (vma->vm_flags & VM_EXEC)
   451			karg.vma_flags |= PROCFS_PROCMAP_VMA_EXECUTABLE;
   452		if (vma->vm_flags & VM_MAYSHARE)
   453			karg.vma_flags |= PROCFS_PROCMAP_VMA_SHARED;
   454	
   455		if (karg.build_id_size) {
   456			__u32 build_id_sz = BUILD_ID_SIZE_MAX;
   457	
   458			err = build_id_parse(vma, build_id_buf, &build_id_sz);
   459			if (!err) {
   460				if (karg.build_id_size < build_id_sz) {
   461					err = -ENAMETOOLONG;
   462					goto out;
   463				}
   464				karg.build_id_size = build_id_sz;
   465			}
   466		}
   467	
   468		if (karg.vma_name_size) {
   469			size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
   470			const struct path *path;
   471			const char *name_fmt;
   472			size_t name_sz = 0;
   473	
   474			get_vma_name(vma, &path, &name, &name_fmt);
   475	
   476			if (path || name_fmt || name) {
   477				name_buf = kmalloc(name_buf_sz, GFP_KERNEL);
   478				if (!name_buf) {
   479					err = -ENOMEM;
   480					goto out;
   481				}
   482			}
   483			if (path) {
   484				name = d_path(path, name_buf, name_buf_sz);
   485				if (IS_ERR(name)) {
   486					err = PTR_ERR(name);
   487					goto out;
   488				}
   489				name_sz = name_buf + name_buf_sz - name;
   490			} else if (name || name_fmt) {
   491				name_sz = 1 + snprintf(name_buf, name_buf_sz, name_fmt ?: "%s", name);
   492				name = name_buf;
   493			}
   494			if (name_sz > name_buf_sz) {
   495				err = -ENAMETOOLONG;
   496				goto out;
   497			}
   498			karg.vma_name_size = name_sz;
   499		}
   500	
   501		/* unlock and put mm_struct before copying data to user */
   502		mmap_read_unlock(mm);
   503		mmput(mm);
   504	
 > 505		if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
   506						       name, karg.vma_name_size)) {
   507			kfree(name_buf);
   508			return -EFAULT;
   509		}
   510		kfree(name_buf);
   511	
   512		if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
   513						       build_id_buf, karg.build_id_size))
   514			return -EFAULT;
   515	
   516		if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize)))
   517			return -EFAULT;
   518	
   519		return 0;
   520	
   521	out:
   522		mmap_read_unlock(mm);
   523		mmput(mm);
   524		kfree(name_buf);
   525		return err;
   526	}
   527	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


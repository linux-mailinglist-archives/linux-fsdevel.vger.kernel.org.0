Return-Path: <linux-fsdevel+bounces-18708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290348BB918
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 03:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D45BB2117F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 01:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBD16AC0;
	Sat,  4 May 2024 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZ9Iyauj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267B17E9;
	Sat,  4 May 2024 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714786274; cv=none; b=A0mgE+iMVBGogIZoBX6bgl/B+xvBlY2nZNdgzx31IYa7LEhOUwWzDR7lGIOO6I5j3xscD3nqs8FabjuK/2Os1ByGO7F8oTNyPfG5xurhy/78VK7PhKiwRvnnvB1hGOJAZeVQbqEc1a+2y75tWLcjIWuYa7F3RSvp4JduhGrb5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714786274; c=relaxed/simple;
	bh=PyxY0oE69hZ0c4dm+MXzuFqcMWQum1NUbC5k6H+O7Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGLrBWGX0vQId1bLwLTambdyz86TxKB3yw4AKjQhEQS0jycEIYOp0hmCmoPNde0DuNx2ktiZTv4EGGb1kUAxgPcJvOAgOoR2a4VYZD0f46yJ1GTtXNVy+5JajmNyDrtRpNOsvTtNMf0gBk+GbAkaeMbCU8jWLzDe0JIZn5qCCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZ9Iyauj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714786273; x=1746322273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PyxY0oE69hZ0c4dm+MXzuFqcMWQum1NUbC5k6H+O7Ys=;
  b=BZ9Iyaujr9EgzYodeXUH43MmD/XKHMLWsEycR7p90PImAcY5qtBm7NBL
   2LSlZ8/wvBA/W2RaY3pylS3/7ipeuGOh3+QnSV9V2QM+vjcrot64llf9C
   VFIZdkfy7n7eA8nIiISd6QanxZGCLfEy9nrjw31KHbWINmDGGpUHlL/KY
   kXE28Kbsg64xuP8SH1LyS6457KA9AVn/PzcCBrnMI7H+IFjhLd1p6mVT0
   jZ4sFrVnJRKQe9LHApdnCU2sXTe50TrqMUhRO6NVhsyVkkeDDnMdQQJcu
   LWUc0cOqJmWyo/PCaKhrLWZavuaL0C/EO159M3T+KetOElUCnatfHSdNW
   w==;
X-CSE-ConnectionGUID: cfegiyrcReq5LJGGyGAuxw==
X-CSE-MsgGUID: cwYYUCTpTgmMzMUUGbs1DQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="22019866"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="22019866"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 18:31:12 -0700
X-CSE-ConnectionGUID: CsKHDJlLRT26MVLiY1ayRA==
X-CSE-MsgGUID: fosB1S7HTi2Sy+DTtD4eHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="58812264"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 May 2024 18:31:09 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s34F0-000CIO-0z;
	Sat, 04 May 2024 01:31:06 +0000
Date: Sat, 4 May 2024 09:30:58 +0800
From: kernel test robot <lkp@intel.com>
To: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, keescook@chromium.org, mcgrof@kernel.org,
	j.granados@samsung.com, allen.lkml@gmail.com
Subject: Re: [PATCH v3] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <202405040817.bJeHlwXS-lkp@intel.com>
References: <20240502235603.19290-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502235603.19290-1-apais@linux.microsoft.com>

Hi Allen,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/execve]
[also build test ERROR on brauner-vfs/vfs.all linus/master v6.9-rc6 next-20240503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Allen-Pais/fs-coredump-Enable-dynamic-configuration-of-max-file-note-size/20240503-075758
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/20240502235603.19290-1-apais%40linux.microsoft.com
patch subject: [PATCH v3] fs/coredump: Enable dynamic configuration of max file note size
config: powerpc64-randconfig-001-20240504 (https://download.01.org/0day-ci/archive/20240504/202405040817.bJeHlwXS-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405040817.bJeHlwXS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405040817.bJeHlwXS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/compat_binfmt_elf.c:17:
   In file included from include/linux/elfcore-compat.h:6:
   In file included from include/linux/elfcore.h:11:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/compat_binfmt_elf.c:144:
>> fs/binfmt_elf.c:1598:14: error: use of undeclared identifier 'core_file_note_size_max'
    1598 |         if (size >= core_file_note_size_max) {
         |                     ^
   1 warning and 1 error generated.


vim +/core_file_note_size_max +1598 fs/binfmt_elf.c

  1569	
  1570	/*
  1571	 * Format of NT_FILE note:
  1572	 *
  1573	 * long count     -- how many files are mapped
  1574	 * long page_size -- units for file_ofs
  1575	 * array of [COUNT] elements of
  1576	 *   long start
  1577	 *   long end
  1578	 *   long file_ofs
  1579	 * followed by COUNT filenames in ASCII: "FILE1" NUL "FILE2" NUL...
  1580	 */
  1581	static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm)
  1582	{
  1583		unsigned count, size, names_ofs, remaining, n;
  1584		user_long_t *data;
  1585		user_long_t *start_end_ofs;
  1586		char *name_base, *name_curpos;
  1587		int i;
  1588	
  1589		/* *Estimated* file count and total data size needed */
  1590		count = cprm->vma_count;
  1591		if (count > UINT_MAX / 64)
  1592			return -EINVAL;
  1593		size = count * 64;
  1594	
  1595		names_ofs = (2 + 3 * count) * sizeof(data[0]);
  1596	 alloc:
  1597		/* paranoia check */
> 1598		if (size >= core_file_note_size_max) {
  1599			pr_warn_once("coredump Note size too large: %u "
  1600			"(does kernel.core_file_note_size_max sysctl need adjustment?)\n",
  1601			size);
  1602			return -EINVAL;
  1603		}
  1604		size = round_up(size, PAGE_SIZE);
  1605		/*
  1606		 * "size" can be 0 here legitimately.
  1607		 * Let it ENOMEM and omit NT_FILE section which will be empty anyway.
  1608		 */
  1609		data = kvmalloc(size, GFP_KERNEL);
  1610		if (ZERO_OR_NULL_PTR(data))
  1611			return -ENOMEM;
  1612	
  1613		start_end_ofs = data + 2;
  1614		name_base = name_curpos = ((char *)data) + names_ofs;
  1615		remaining = size - names_ofs;
  1616		count = 0;
  1617		for (i = 0; i < cprm->vma_count; i++) {
  1618			struct core_vma_metadata *m = &cprm->vma_meta[i];
  1619			struct file *file;
  1620			const char *filename;
  1621	
  1622			file = m->file;
  1623			if (!file)
  1624				continue;
  1625			filename = file_path(file, name_curpos, remaining);
  1626			if (IS_ERR(filename)) {
  1627				if (PTR_ERR(filename) == -ENAMETOOLONG) {
  1628					kvfree(data);
  1629					size = size * 5 / 4;
  1630					goto alloc;
  1631				}
  1632				continue;
  1633			}
  1634	
  1635			/* file_path() fills at the end, move name down */
  1636			/* n = strlen(filename) + 1: */
  1637			n = (name_curpos + remaining) - filename;
  1638			remaining = filename - name_curpos;
  1639			memmove(name_curpos, filename, n);
  1640			name_curpos += n;
  1641	
  1642			*start_end_ofs++ = m->start;
  1643			*start_end_ofs++ = m->end;
  1644			*start_end_ofs++ = m->pgoff;
  1645			count++;
  1646		}
  1647	
  1648		/* Now we know exact count of files, can store it */
  1649		data[0] = count;
  1650		data[1] = PAGE_SIZE;
  1651		/*
  1652		 * Count usually is less than mm->map_count,
  1653		 * we need to move filenames down.
  1654		 */
  1655		n = cprm->vma_count - count;
  1656		if (n != 0) {
  1657			unsigned shift_bytes = n * 3 * sizeof(data[0]);
  1658			memmove(name_base - shift_bytes, name_base,
  1659				name_curpos - name_base);
  1660			name_curpos -= shift_bytes;
  1661		}
  1662	
  1663		size = name_curpos - (char *)data;
  1664		fill_note(note, "CORE", NT_FILE, size, data);
  1665		return 0;
  1666	}
  1667	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


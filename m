Return-Path: <linux-fsdevel+bounces-18913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2364E8BE717
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 17:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F502813E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38025161914;
	Tue,  7 May 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbtvZcyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90FA161318;
	Tue,  7 May 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094756; cv=none; b=pTQfuDvEPOiy9Mm61XO43YKEge5Gd1xp0EGloQ2e3TwX0CVB9aULXjnapkjRiNolVqrOhjkUQLNoAcb9WUgNO+WYJlaNZvZx2mPPrSWIIYcA7c6E7qqwSz2Z232f7NHs278oD9dwDtQC4C2IsLDvd+/PXlM2A3plXVrNmIONE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094756; c=relaxed/simple;
	bh=sDXlhsNL5aaev9Nug91UWPEjiW+dKOlplEJl0WJcwro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceALo2cTTZDyPR6ALGWUhFjCeCJFnxlfmya26y8IkJsDWOrAedr2J8VYAKjTWPMkAoRhbFsOjVNGS8AlemdbvqRRRCKdUvaSyfpNSa77LYw7a908/6dmGgb7l/cBLyJ/ZtxsiZjVAO/7nT+I61qPwl09ATIhVrHbSdsZXM7OZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbtvZcyp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715094755; x=1746630755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sDXlhsNL5aaev9Nug91UWPEjiW+dKOlplEJl0WJcwro=;
  b=cbtvZcypOR1EoR2tlweJaMtsm/Fgx3Plro0XA+DVNjn1xYqEUbEZ0tZK
   /OcbFCkHgLNiz/KZAEgZzPpTV4BSpuggaTsJlRfGR5p4hZPfpXkjeyoug
   rJjP3MF6/kR6L/0Tv6b+QzpIOiJvkeh0LKcjsOhDoE/rI5eBq5U9SGAVR
   dE4kCZZq9Myk0gdRk1NBdYphz9kMne9V4PjPoEqRCSEraKKgAZk75Cfub
   40SDWiKdwNK961++jsusyyNDt9TmNChXpTacmobaBzHKlQV6lppsejn5X
   QfWcz9GnTHADXqjJ4OcBziqXVACan9aTivbqqZ8pv1LVZzOFaj6HQwVoe
   w==;
X-CSE-ConnectionGUID: f4vlALN/RAiSuPGDEoWFuA==
X-CSE-MsgGUID: TcNHsktsRvGQ8Lgo1U2iSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14684884"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="14684884"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:12:34 -0700
X-CSE-ConnectionGUID: QnsjyMUSRxuQuZTqlOlNMg==
X-CSE-MsgGUID: gHdADgIIRwWIs7FK4UGgQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="29077414"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 May 2024 08:12:31 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4MUW-0002Et-2V;
	Tue, 07 May 2024 15:12:28 +0000
Date: Tue, 7 May 2024 23:11:33 +0800
From: kernel test robot <lkp@intel.com>
To: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, ebiederm@xmission.com, keescook@chromium.org,
	mcgrof@kernel.org, j.granados@samsung.com, allen.lkml@gmail.com
Subject: Re: [PATCH v4] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <202405072249.fLkavX40-lkp@intel.com>
References: <20240506193700.7884-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506193700.7884-1-apais@linux.microsoft.com>

Hi Allen,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/execve]
[also build test ERROR on brauner-vfs/vfs.all linus/master v6.9-rc7 next-20240507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Allen-Pais/fs-coredump-Enable-dynamic-configuration-of-max-file-note-size/20240507-033907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/20240506193700.7884-1-apais%40linux.microsoft.com
patch subject: [PATCH v4] fs/coredump: Enable dynamic configuration of max file note size
config: loongarch-randconfig-001-20240507 (https://download.01.org/0day-ci/archive/20240507/202405072249.fLkavX40-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240507/202405072249.fLkavX40-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405072249.fLkavX40-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/binfmt_elf.c: In function 'fill_files_note':
>> fs/binfmt_elf.c:1598:21: error: 'core_file_note_size_min' undeclared (first use in this function)
    1598 |         if (size >= core_file_note_size_min) {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~
   fs/binfmt_elf.c:1598:21: note: each undeclared identifier is reported only once for each function it appears in


vim +/core_file_note_size_min +1598 fs/binfmt_elf.c

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
> 1598		if (size >= core_file_note_size_min) {
  1599			pr_warn_once("coredump Note size too large: %u (does kernel.core_file_note_size_min sysctl need adjustment?\n",
  1600				      size);
  1601			return -EINVAL;
  1602		}
  1603		size = round_up(size, PAGE_SIZE);
  1604		/*
  1605		 * "size" can be 0 here legitimately.
  1606		 * Let it ENOMEM and omit NT_FILE section which will be empty anyway.
  1607		 */
  1608		data = kvmalloc(size, GFP_KERNEL);
  1609		if (ZERO_OR_NULL_PTR(data))
  1610			return -ENOMEM;
  1611	
  1612		start_end_ofs = data + 2;
  1613		name_base = name_curpos = ((char *)data) + names_ofs;
  1614		remaining = size - names_ofs;
  1615		count = 0;
  1616		for (i = 0; i < cprm->vma_count; i++) {
  1617			struct core_vma_metadata *m = &cprm->vma_meta[i];
  1618			struct file *file;
  1619			const char *filename;
  1620	
  1621			file = m->file;
  1622			if (!file)
  1623				continue;
  1624			filename = file_path(file, name_curpos, remaining);
  1625			if (IS_ERR(filename)) {
  1626				if (PTR_ERR(filename) == -ENAMETOOLONG) {
  1627					kvfree(data);
  1628					size = size * 5 / 4;
  1629					goto alloc;
  1630				}
  1631				continue;
  1632			}
  1633	
  1634			/* file_path() fills at the end, move name down */
  1635			/* n = strlen(filename) + 1: */
  1636			n = (name_curpos + remaining) - filename;
  1637			remaining = filename - name_curpos;
  1638			memmove(name_curpos, filename, n);
  1639			name_curpos += n;
  1640	
  1641			*start_end_ofs++ = m->start;
  1642			*start_end_ofs++ = m->end;
  1643			*start_end_ofs++ = m->pgoff;
  1644			count++;
  1645		}
  1646	
  1647		/* Now we know exact count of files, can store it */
  1648		data[0] = count;
  1649		data[1] = PAGE_SIZE;
  1650		/*
  1651		 * Count usually is less than mm->map_count,
  1652		 * we need to move filenames down.
  1653		 */
  1654		n = cprm->vma_count - count;
  1655		if (n != 0) {
  1656			unsigned shift_bytes = n * 3 * sizeof(data[0]);
  1657			memmove(name_base - shift_bytes, name_base,
  1658				name_curpos - name_base);
  1659			name_curpos -= shift_bytes;
  1660		}
  1661	
  1662		size = name_curpos - (char *)data;
  1663		fill_note(note, "CORE", NT_FILE, size, data);
  1664		return 0;
  1665	}
  1666	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


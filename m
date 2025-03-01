Return-Path: <linux-fsdevel+bounces-42889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D3A4AD8C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD67D189648C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B62F1E8329;
	Sat,  1 Mar 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LD1Tu4N6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FB1BD01F;
	Sat,  1 Mar 2025 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740858355; cv=none; b=hVYuRWvJ9rbnrmxFyu2CvzkfvTTmycopxIUmwQct4Uqanu+B5AWXjSJAgocwcev7lJWLGQxH+3eHutCQzcTyJD3cr9ZN5kCjylowSIOsd+ums/M34XPdzI+BNRWpr9/ncDKQQaFIL7mSFwwCzhyH/YNZzHz4Cw78dZ/AW19+c24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740858355; c=relaxed/simple;
	bh=7RHZLlYISYOOa3uduTet2ow5tjmMF06rhNmws47c1BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXtptTX+ScuU9ZIUPhlsl2+ngCpPLo9TUD/yaIVywqeTmMVNhEMW0gF4QVM1S2Z2dzbX8x1ws54MG65YxcsTbGENK50OV/lYmt/iVxaQFdWkWJAJLQZt1guLdYvXeXJZZ1A/jliXwKuWyTwZZ92T5W4hh01cLKk70EOAFbCg2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LD1Tu4N6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740858353; x=1772394353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7RHZLlYISYOOa3uduTet2ow5tjmMF06rhNmws47c1BA=;
  b=LD1Tu4N6P9GKcX+uwaRHoW2/FLc4MX7zs0thsEVBtMr9i69PuwP6zC8Z
   SC1OjyGMe6RtXp6z73ZrUK3sNZbXY+DgE7LnUXu6lzx2e3lCBMRNuUqGi
   mP4M9QeLKFqc4iLeAqDmfrcDzM/MJZzmDLTWsBCgsASyqBHgF9yyYcGdt
   aLqX+b05OGgW0Hg+WWw6KSK5PEeRIsZ4+jqHQpEC0WSRtF10LRndSNHGP
   S9wbnDeIjG1GOCfUFkEVjUXQFwwrmRU2//0RodovI18wcgktLCt7T9SDj
   DAcebzo0iUBbKjAFuGjOuo0uFahq5O0+8sWTQdmpp/PARb8+nt9ulBeW1
   Q==;
X-CSE-ConnectionGUID: 73fVMWznTBqZ8aKW7vU9AA==
X-CSE-MsgGUID: /dfF785cQKOU6UzEhrR9dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41795675"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="41795675"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 11:45:52 -0800
X-CSE-ConnectionGUID: DPGE4HeRQOum/28skPyxlQ==
X-CSE-MsgGUID: 0B5sZDrTRqCYBgUdNpzkhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="117415055"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 01 Mar 2025 11:45:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toSmL-000GdC-0S;
	Sat, 01 Mar 2025 19:45:41 +0000
Date: Sun, 2 Mar 2025 03:44:41 +0800
From: kernel test robot <lkp@intel.com>
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 08/12] xfs: Iomap SW-based atomic write support
Message-ID: <202503020355.fr9QWxQJ-lkp@intel.com>
References: <20250227180813.1553404-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227180813.1553404-9-john.g.garry@oracle.com>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xfs-linux/for-next]
[also build test WARNING on tytso-ext4/dev linus/master v6.14-rc4]
[cannot apply to brauner-vfs/vfs.all next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/xfs-Pass-flags-to-xfs_reflink_allocate_cow/20250228-021818
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20250227180813.1553404-9-john.g.garry%40oracle.com
patch subject: [PATCH v3 08/12] xfs: Iomap SW-based atomic write support
config: hexagon-randconfig-001-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020355.fr9QWxQJ-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020355.fr9QWxQJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020355.fr9QWxQJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/xfs/xfs_iomap.c:1029:8: warning: variable 'iomap_flags' set but not used [-Wunused-but-set-variable]
    1029 |         u16                     iomap_flags = 0;
         |                                 ^
   1 warning generated.


vim +/iomap_flags +1029 fs/xfs/xfs_iomap.c

  1011	
  1012	static int
  1013	xfs_atomic_write_sw_iomap_begin(
  1014		struct inode		*inode,
  1015		loff_t			offset,
  1016		loff_t			length,
  1017		unsigned		flags,
  1018		struct iomap		*iomap,
  1019		struct iomap		*srcmap)
  1020	{
  1021		struct xfs_inode	*ip = XFS_I(inode);
  1022		struct xfs_mount	*mp = ip->i_mount;
  1023		struct xfs_bmbt_irec	imap, cmap;
  1024		xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
  1025		xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
  1026		int			nimaps = 1, error;
  1027		unsigned int		reflink_flags;
  1028		bool			shared = false;
> 1029		u16			iomap_flags = 0;
  1030		unsigned int		lockmode = XFS_ILOCK_EXCL;
  1031		u64			seq;
  1032	
  1033		if (xfs_is_shutdown(mp))
  1034			return -EIO;
  1035	
  1036		reflink_flags = XFS_REFLINK_CONVERT | XFS_REFLINK_ATOMIC_SW;
  1037	
  1038		/*
  1039		 * Set IOMAP_F_DIRTY similar to xfs_atomic_write_iomap_begin()
  1040		 */
  1041		if (offset + length > i_size_read(inode))
  1042			iomap_flags |= IOMAP_F_DIRTY;
  1043	
  1044		error = xfs_ilock_for_iomap(ip, flags, &lockmode);
  1045		if (error)
  1046			return error;
  1047	
  1048		error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
  1049				&nimaps, 0);
  1050		if (error)
  1051			goto out_unlock;
  1052	
  1053		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
  1054				&lockmode, reflink_flags);
  1055		/*
  1056		 * Don't check @shared. For atomic writes, we should error when
  1057		 * we don't get a COW mapping
  1058		 */
  1059		if (error)
  1060			goto out_unlock;
  1061	
  1062		end_fsb = imap.br_startoff + imap.br_blockcount;
  1063	
  1064		length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
  1065		trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
  1066		if (imap.br_startblock != HOLESTARTBLOCK) {
  1067			seq = xfs_iomap_inode_sequence(ip, 0);
  1068			error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
  1069			if (error)
  1070				goto out_unlock;
  1071		}
  1072		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
  1073		xfs_iunlock(ip, lockmode);
  1074		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
  1075	
  1076	out_unlock:
  1077		if (lockmode)
  1078			xfs_iunlock(ip, lockmode);
  1079		return error;
  1080	}
  1081	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


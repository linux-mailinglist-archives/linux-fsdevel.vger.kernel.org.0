Return-Path: <linux-fsdevel+bounces-20927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759528FAE73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B261C2458D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4341442F0;
	Tue,  4 Jun 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgXt9qy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3E91428F5;
	Tue,  4 Jun 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492306; cv=none; b=nLNkgm41kK7Vukk7ltq9/p3yfTloAOnAN7TxFQoid7HMVZCOw3g0WD5YNzDMjP90Gt+/XSOb2oumCzi6Q/XWUNy0QO3HDXJQQoZC96G45JEr3eS4Smum6HunFuSgYFy/G8HOHxbOEkwasj7nvUaX7zf+5c1JMP/hhcwRz9XCQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492306; c=relaxed/simple;
	bh=n0+6Zr+fVpwoIm04mx+e+RHQbAYONFbtegnmjOCnEFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmdWdOKXOFEKMep41RfnbLEx20of95CJq12Y2Ar4M3YJ8GATAu3kwvT8rEpG7fGBOXLM8nxSSgqTEIFRxFaC0L7Xb1fWtfkq+3HA3WG9dLUYDa4EyAiz2xyFL0ZCRQDSmZ9w2LLl5A/6HpDZByU0sx1S4AdrgJJnB2NzDqColO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgXt9qy3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717492305; x=1749028305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n0+6Zr+fVpwoIm04mx+e+RHQbAYONFbtegnmjOCnEFE=;
  b=VgXt9qy3+TtdqoI+231qDTjfMHkUBHatgeHYKuacqPmfF7hdW+9WJxA5
   QXTdRZyW4JbAQQNYPq/TKViEgaQYaRZdrl50ECl/t+qs6j/udUohGPafv
   lPo3DAMSVfqwKlLw51pTkStT1p3aBUkONEQoNEv5yfi8whuLnT38Ce1Rm
   5kX0jl4cdVXfCJ+eCMZzwDkbWBtKxtyjVjQdTuE8VPKIFmkwpYzNPtHnJ
   ATpJZL2fpNiaOtcyJGQykMcFsPFbdDhf3fG1TwzpZmGpIhjnCkRDoDJ7+
   5C8m1o9Tl1ZEkaO8btyBF4JaNxzmkItQYXUvpyhB2YjJa9Pn6m2/Lmwmw
   g==;
X-CSE-ConnectionGUID: RhufaxHJQRKTlUe07Isbew==
X-CSE-MsgGUID: +MPAa+qmSNaweFnS57qW1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17854982"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="17854982"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:11:44 -0700
X-CSE-ConnectionGUID: KaKEcYXXR8KSoqyaybARGA==
X-CSE-MsgGUID: aXf4mTjmQP6psAbqM4zCxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37299304"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2024 02:11:41 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEQCg-000MzV-1v;
	Tue, 04 Jun 2024 09:11:38 +0000
Date: Tue, 4 Jun 2024 17:10:50 +0800
From: kernel test robot <lkp@intel.com>
To: Hyeonwoo Cha <chw1119@hanyang.ac.kr>, david.sterba@suse.com
Cc: oe-kbuild-all@lists.linux.dev, aivazian.tigran@gmail.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tytso@mit.edu, adilger.kernel@dilger.ca,
	hirofumi@mail.parknet.co.jp, sfr@canb.auug.org.au,
	chw1119@hanyang.ac.kr, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH v2] Fix issue in mark_buffer_dirty_inode
Message-ID: <202406041616.S1kIWWZc-lkp@intel.com>
References: <20240604060636.87652-1-chw1119@hanyang.ac.kr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604060636.87652-1-chw1119@hanyang.ac.kr>

Hi Hyeonwoo,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.10-rc2 next-20240604]
[cannot apply to jack-fs/for_next tytso-ext4/dev vfs-idmapping/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hyeonwoo-Cha/Fix-issue-in-mark_buffer_dirty_inode/20240604-140958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20240604060636.87652-1-chw1119%40hanyang.ac.kr
patch subject: [PATCH v2] Fix issue in mark_buffer_dirty_inode
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240604/202406041616.S1kIWWZc-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406041616.S1kIWWZc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406041616.S1kIWWZc-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/affs/namei.c: In function 'affs_symlink':
>> fs/affs/namei.c:377:9: error: expected ',' or ';' before 'mark_buffer_dirty_fsync'
     377 |         mark_buffer_dirty_fsync(bh, mapping);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> fs/affs/namei.c:376:31: warning: unused variable 'mapping' [-Wunused-variable]
     376 |         struct address_space *mapping = inode->i_mapping
         |                               ^~~~~~~


vim +377 fs/affs/namei.c

   314	
   315	int
   316	affs_symlink(struct mnt_idmap *idmap, struct inode *dir,
   317		     struct dentry *dentry, const char *symname)
   318	{
   319		struct super_block	*sb = dir->i_sb;
   320		struct buffer_head	*bh;
   321		struct inode		*inode;
   322		char			*p;
   323		int			 i, maxlen, error;
   324		char			 c, lc;
   325	
   326		pr_debug("%s(%lu,\"%pd\" -> \"%s\")\n",
   327			 __func__, dir->i_ino, dentry, symname);
   328	
   329		maxlen = AFFS_SB(sb)->s_hashsize * sizeof(u32) - 1;
   330		inode  = affs_new_inode(dir);
   331		if (!inode)
   332			return -ENOSPC;
   333	
   334		inode->i_op = &affs_symlink_inode_operations;
   335		inode_nohighmem(inode);
   336		inode->i_data.a_ops = &affs_symlink_aops;
   337		inode->i_mode = S_IFLNK | 0777;
   338		affs_mode_to_prot(inode);
   339	
   340		error = -EIO;
   341		bh = affs_bread(sb, inode->i_ino);
   342		if (!bh)
   343			goto err;
   344		i  = 0;
   345		p  = (char *)AFFS_HEAD(bh)->table;
   346		lc = '/';
   347		if (*symname == '/') {
   348			struct affs_sb_info *sbi = AFFS_SB(sb);
   349			while (*symname == '/')
   350				symname++;
   351			spin_lock(&sbi->symlink_lock);
   352			while (sbi->s_volume[i])	/* Cannot overflow */
   353				*p++ = sbi->s_volume[i++];
   354			spin_unlock(&sbi->symlink_lock);
   355		}
   356		while (i < maxlen && (c = *symname++)) {
   357			if (c == '.' && lc == '/' && *symname == '.' && symname[1] == '/') {
   358				*p++ = '/';
   359				i++;
   360				symname += 2;
   361				lc = '/';
   362			} else if (c == '.' && lc == '/' && *symname == '/') {
   363				symname++;
   364				lc = '/';
   365			} else {
   366				*p++ = c;
   367				lc   = c;
   368				i++;
   369			}
   370			if (lc == '/')
   371				while (*symname == '/')
   372					symname++;
   373		}
   374		*p = 0;
   375		inode->i_size = i + 1;
 > 376		struct address_space *mapping = inode->i_mapping
 > 377		mark_buffer_dirty_fsync(bh, mapping);
   378		affs_brelse(bh);
   379		mark_inode_dirty(inode);
   380	
   381		error = affs_add_entry(dir, inode, dentry, ST_SOFTLINK);
   382		if (error)
   383			goto err;
   384	
   385		return 0;
   386	
   387	err:
   388		clear_nlink(inode);
   389		mark_inode_dirty(inode);
   390		iput(inode);
   391		return error;
   392	}
   393	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


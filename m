Return-Path: <linux-fsdevel+bounces-28709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D807396D347
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 11:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168461C23335
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D71991C9;
	Thu,  5 Sep 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/1E0dYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6621991B4;
	Thu,  5 Sep 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528569; cv=none; b=Q2AZGgJ9BWnvJIpLoYtXXLtkU9UzDONFuKtEoUJi8rxxivd3w5w+haS+S+R6PNN/EH+UOTKWmNLsUXnQgg7clqaPdn/NJ5zw/zR5xW3kk/UxoqSCljI0iN9xlkxabXNnT4WFwprYchZtNO28rP8FMJdD/bSO4svUHRdefEzu6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528569; c=relaxed/simple;
	bh=eREH9W1o7gULhFJHUk1Riw6dl9QsxJdAN7EUozX80D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1eq2Q248ufe78crrYsOoPeTvvs9fHv2z7yxQDRtvoonKMlk9c2ply+G6JFeBZnjJXDXe9D18vmod6pk9OLR7p6xKMTMwV5KCE/5j5iSRLx6cF9SHbAyOcBNZHMXONxOx08KcHuxgBbWe6mhXMMSAFydXFGF6mdiqPKGv24G00M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/1E0dYn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725528567; x=1757064567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eREH9W1o7gULhFJHUk1Riw6dl9QsxJdAN7EUozX80D0=;
  b=B/1E0dYngxfLEtPJIRsQ5L2/NGaDqjy2v9nH5w1SFuPWSY7j2ZaLCNLr
   6FqEcCH9/O10jPSE7MoL1BKC+iGpZb/oeOhrIIFDK6+1dI80W49Tsm7Be
   QnL/sC9T7WZnP/P+LzXJoaO4US7toOuFAEO2wSMQUXdOg4qltrH7OaXmS
   /q96oIjQEiF6FYQQka9yJjArVRd/XD0l3zAQztttRmNL7jY5Ie9tw3mqS
   drWmCoooY7S06NsBeekS2quQznWbpr1L34zT/eQE37QNOaBsOAm5UnOha
   4+hILHMNfrmsxI0FN5QOwFG3ARMhSCZXaeJ+6DbkJhZR3s9yjVClEQl/w
   Q==;
X-CSE-ConnectionGUID: KVH3ETUpQZa9JMy1Mv5f7Q==
X-CSE-MsgGUID: prBX62d4TwqClwzRIGjZ2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24391221"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24391221"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 02:29:26 -0700
X-CSE-ConnectionGUID: jnItSODjSG+XVlD9zXpVMQ==
X-CSE-MsgGUID: mcITcjsVSNGmtXpYuqBsGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="96352852"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Sep 2024 02:29:21 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sm8nn-0009AN-1F;
	Thu, 05 Sep 2024 09:29:19 +0000
Date: Thu, 5 Sep 2024 17:28:46 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <202409051713.LFVMScXi-lkp@intel.com>
References: <20240902095203.1559361-2-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902095203.1559361-2-mhocko@kernel.org>

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tip/sched/core brauner-vfs/vfs.all linus/master v6.11-rc6]
[cannot apply to next-20240904]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Hocko/bcachefs-do-not-use-PF_MEMALLOC_NORECLAIM/20240902-200126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240902095203.1559361-2-mhocko%40kernel.org
patch subject: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240905/202409051713.LFVMScXi-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409051713.LFVMScXi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409051713.LFVMScXi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/inode.c:157: warning: Function parameter or struct member 'gfp' not described in 'inode_init_always_gfp'
>> fs/inode.c:157: warning: expecting prototype for inode_init_always(). Prototype was for inode_init_always_gfp() instead


vim +157 fs/inode.c

bd9b51e79cb0b8 Al Viro             2014-11-18  147  
2cb1599f9b2ecd David Chinner       2008-10-30  148  /**
6e7c2b4dd36d83 Masahiro Yamada     2017-05-08  149   * inode_init_always - perform inode structure initialisation
0bc02f3fa433a9 Randy Dunlap        2009-01-06  150   * @sb: superblock inode belongs to
0bc02f3fa433a9 Randy Dunlap        2009-01-06  151   * @inode: inode to initialise
2cb1599f9b2ecd David Chinner       2008-10-30  152   *
2cb1599f9b2ecd David Chinner       2008-10-30  153   * These are initializations that need to be done on every inode
2cb1599f9b2ecd David Chinner       2008-10-30  154   * allocation as the fields are not initialised by slab allocation.
2cb1599f9b2ecd David Chinner       2008-10-30  155   */
6185335c11aac8 Michal Hocko        2024-09-02  156  int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp)
^1da177e4c3f41 Linus Torvalds      2005-04-16 @157  {
6e1d5dcc2bbbe7 Alexey Dobriyan     2009-09-21  158  	static const struct inode_operations empty_iops;
bd9b51e79cb0b8 Al Viro             2014-11-18  159  	static const struct file_operations no_open_fops = {.open = no_open};
^1da177e4c3f41 Linus Torvalds      2005-04-16  160  	struct address_space *const mapping = &inode->i_data;
^1da177e4c3f41 Linus Torvalds      2005-04-16  161  
^1da177e4c3f41 Linus Torvalds      2005-04-16  162  	inode->i_sb = sb;
^1da177e4c3f41 Linus Torvalds      2005-04-16  163  	inode->i_blkbits = sb->s_blocksize_bits;
^1da177e4c3f41 Linus Torvalds      2005-04-16  164  	inode->i_flags = 0;
5a9b911b8a24ed Mateusz Guzik       2024-06-11  165  	inode->i_state = 0;
8019ad13ef7f64 Peter Zijlstra      2020-03-04  166  	atomic64_set(&inode->i_sequence, 0);
^1da177e4c3f41 Linus Torvalds      2005-04-16  167  	atomic_set(&inode->i_count, 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  168  	inode->i_op = &empty_iops;
bd9b51e79cb0b8 Al Viro             2014-11-18  169  	inode->i_fop = &no_open_fops;
edbb35cc6bdfc3 Eric Biggers        2020-10-30  170  	inode->i_ino = 0;
a78ef704a8dd43 Miklos Szeredi      2011-10-28  171  	inode->__i_nlink = 1;
3ddcd0569cd68f Linus Torvalds      2011-08-06  172  	inode->i_opflags = 0;
d0a5b995a30834 Andreas Gruenbacher 2016-09-29  173  	if (sb->s_xattr)
d0a5b995a30834 Andreas Gruenbacher 2016-09-29  174  		inode->i_opflags |= IOP_XATTR;
92361636e0153b Eric W. Biederman   2012-02-08  175  	i_uid_write(inode, 0);
92361636e0153b Eric W. Biederman   2012-02-08  176  	i_gid_write(inode, 0);
^1da177e4c3f41 Linus Torvalds      2005-04-16  177  	atomic_set(&inode->i_writecount, 0);
^1da177e4c3f41 Linus Torvalds      2005-04-16  178  	inode->i_size = 0;
c75b1d9421f80f Jens Axboe          2017-06-27  179  	inode->i_write_hint = WRITE_LIFE_NOT_SET;
^1da177e4c3f41 Linus Torvalds      2005-04-16  180  	inode->i_blocks = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  181  	inode->i_bytes = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  182  	inode->i_generation = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  183  	inode->i_pipe = NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  184  	inode->i_cdev = NULL;
61ba64fc076887 Al Viro             2015-05-02  185  	inode->i_link = NULL;
84e710da2a1dfa Al Viro             2016-04-15  186  	inode->i_dir_seq = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  187  	inode->i_rdev = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  188  	inode->dirtied_when = 0;
6146f0d5e47ca4 Mimi Zohar          2009-02-04  189  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


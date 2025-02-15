Return-Path: <linux-fsdevel+bounces-41767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6604A36BF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 05:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56F7170050
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 04:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D518950A;
	Sat, 15 Feb 2025 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViylrUhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C21714D7;
	Sat, 15 Feb 2025 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739592660; cv=none; b=sC+XhdDKANIDB1gSsjCnvg2WdBqM2kSOYoA9i1xtvq3JL6YNXRK70fqbg/pI18BTTuHNbxwqjHSkxnESE8V0P9Yzb1P3CE8JLjzSgyjsQ3owgWYPaiS33rJ+t0NOfWVhpjjeTVBmJ0/wJGeNADpH2SB47DYAlGruuc5QdZdAEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739592660; c=relaxed/simple;
	bh=3Es96yiweOVuX8TpMQ2C9w014YwlugLJ7ksbEKEAo1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0DajfNQrbHkZntzbiQlNn4KmSpO3gtas4M94pXNXncB7W/p0AQ/qyce354vfI/xvoXqkS4R7mW+rtwawePr3bia6hOql1tSZli+I3gxnGMi7YxDfp6ILfyAbGv1G33dPUkFl+X7/agk9MSJ6TYNzNkEE1wEZ2r/XJ6WkTJLJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViylrUhi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739592658; x=1771128658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Es96yiweOVuX8TpMQ2C9w014YwlugLJ7ksbEKEAo1U=;
  b=ViylrUhincyZP4RP34R1atiFBjtMolXZLc1bZGMLHUkQzySfZP58vMzC
   AsIDMltbn7rm02y7H/E3dNFKOkhXxq2IzTsPMlwPJ1rHzk39b3IikAA7M
   uG+hrMtoNZTX8pHTWGQeKULM+DgLRmhaHFv+qMABzBrbRyzSTsLqLcMQs
   ZlDBi+ihoSOgBgu57RGqxD9tfWPU6Lg8Jz3Zyjm/WYZiL1DqgIw8N9Et5
   jxiMtN51td8q7wFiRug8DY957d1n9kKO0zkxe9eXIqMRIXSH6Z4L1dkst
   p3BaPdUfYP9PI6mPkH+99rtoOeMiWNFrD/Yhj48NDcKWvQ1XwOiCoJwW6
   A==;
X-CSE-ConnectionGUID: CkLrFsydQlauwA0iT1ybcA==
X-CSE-MsgGUID: em1S292YTmKjgpC4lkyBIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40221664"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40221664"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 20:10:57 -0800
X-CSE-ConnectionGUID: Q1bKLB5ERQq+tOPgb6THtw==
X-CSE-MsgGUID: 9aGfC/PNT86DjBXMFPbQVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118831898"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Feb 2025 20:10:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tj9W0-001AUV-0y;
	Sat, 15 Feb 2025 04:10:52 +0000
Date: Sat, 15 Feb 2025 12:10:16 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] VFS: Change vfs_mkdir() to return the dentry.
Message-ID: <202502151124.LyMTodTU-lkp@intel.com>
References: <20250214052204.3105610-4-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214052204.3105610-4-neilb@suse.de>

Hi NeilBrown,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on trondmy-nfs/linux-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus cifs/for-next xfs-linux/for-next linus/master v6.14-rc2 next-20250214]
[cannot apply to ericvh-v9fs/for-next tyhicks-ecryptfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfs-change-mkdir-inode_operation-to-return-alternate-dentry-if-needed/20250214-141741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250214052204.3105610-4-neilb%40suse.de
patch subject: [PATCH 3/3] VFS: Change vfs_mkdir() to return the dentry.
config: x86_64-buildonly-randconfig-001-20250215 (https://download.01.org/0day-ci/archive/20250215/202502151124.LyMTodTU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502151124.LyMTodTU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502151124.LyMTodTU-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/smb/server/vfs.c: In function 'ksmbd_vfs_mkdir':
>> fs/smb/server/vfs.c:226:9: error: 'entry' undeclared (first use in this function); did you mean 'dentry'?
     226 |         entry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
         |         ^~~~~
         |         dentry
   fs/smb/server/vfs.c:226:9: note: each undeclared identifier is reported only once for each function it appears in


vim +226 fs/smb/server/vfs.c

   196	
   197	/**
   198	 * ksmbd_vfs_mkdir() - vfs helper for smb create directory
   199	 * @work:	work
   200	 * @name:	directory name that is relative to share
   201	 * @mode:	directory create mode
   202	 *
   203	 * Return:	0 on success, otherwise error
   204	 */
   205	int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
   206	{
   207		struct mnt_idmap *idmap;
   208		struct path path;
   209		struct dentry *dentry, *d;
   210		int err;
   211	
   212		dentry = ksmbd_vfs_kern_path_create(work, name,
   213						    LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
   214						    &path);
   215		if (IS_ERR(dentry)) {
   216			err = PTR_ERR(dentry);
   217			if (err != -EEXIST)
   218				ksmbd_debug(VFS, "path create failed for %s, err %d\n",
   219					    name, err);
   220			return err;
   221		}
   222	
   223		idmap = mnt_idmap(path.mnt);
   224		mode |= S_IFDIR;
   225		d = dentry;
 > 226		entry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
   227		err = PTR_ERR_OR_ZERO(dentry);
   228		if (!err && dentry != d)
   229			ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
   230	
   231		done_path_create(&path, dentry);
   232		if (err)
   233			pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
   234		return err;
   235	}
   236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


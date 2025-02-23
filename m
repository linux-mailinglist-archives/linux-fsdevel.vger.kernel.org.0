Return-Path: <linux-fsdevel+bounces-42359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A429A40DC4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 10:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C024116BA46
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F0204594;
	Sun, 23 Feb 2025 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haB+2jbj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B702036FE
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740303904; cv=none; b=nec2gFv5WY1ZAMeao6YnevgLIkvWAEdRED9O8SHlfIGHjeFkybs/3LRYc+9/3DFmXT0a7sJ6m9shvsUArgw2cAQKjUiCPp6M7T2+muvugTylzYSffaNWoXeCxWEEUkN3XErDV79p2DjWVeVZhA+bWKffqKe3NhOjs78VTn8qjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740303904; c=relaxed/simple;
	bh=Im2TcUetA6RUtHfr36TfEnTJea1N1NyI4OZgt4vXCAg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UQa8DR/7uII5FHFmfHGtdwdlusNnXGkRK/Pdp3c79Ysm6poAYrfqpbvXK47EolwEkayGEC3vaF624cJfxlrtC5PggxcWfPzzAdK9s3lCrMclGJOcT2vD+G2lP+1pqTlwwSEfY7l0ifZc421kCIkJhlkqhMFuMdgWNxNYqUiGY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haB+2jbj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740303902; x=1771839902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Im2TcUetA6RUtHfr36TfEnTJea1N1NyI4OZgt4vXCAg=;
  b=haB+2jbj5qx4utOwg3V+nl1lEDb+oLCI5vvB53EwCq5J6GOmhP3L3TAd
   68I4CaJWOQyCooa3FeXKRkMXqx2wRE1R0gSmf9O5bBPxRgI/X2EImMEz1
   2RCqSzxSsuAH3EGoHHGClGpEdSvzLDlA6Ao6A0pEnFT1Azh1Lx2ytDsg2
   S5yYdLuh1MjO7v6GpNNYkTN2qP7XVUDqqaJuxiS6owFT9+ODzISjfElFC
   z9sPEDHVH5l/xJR8X/oJrolgcBiR51vn7Em77P6QMnCSX7BYUvGIx33h3
   5DVL9DObzmqUQxQ9Edb300giBDpvM8ktlx5L6Fyx57c8EqVsGxcfV41Is
   g==;
X-CSE-ConnectionGUID: gqhMiXelTfi4i8mZjk9C3w==
X-CSE-MsgGUID: b5X4A4TpRIWC9Rau/8WYBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="44980664"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44980664"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 01:45:02 -0800
X-CSE-ConnectionGUID: vjrbofnKRYOjdSFzYeL/AA==
X-CSE-MsgGUID: Dud4tnowQym2gIkw8K9MEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120885761"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 23 Feb 2025 01:45:01 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tm8Xi-0007FH-1r;
	Sun, 23 Feb 2025 09:44:58 +0000
Date: Sun, 23 Feb 2025 17:44:45 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.dcache 2/2] fs/dcache.c:3011: warning: Function
 parameter or struct member 'ops' not described in 'd_splice_alias_ops'
Message-ID: <202502231747.l7oQ2cZ7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache
head:   107a7f3910694e43dc91f4aa7eb3405158257785
commit: 107a7f3910694e43dc91f4aa7eb3405158257785 [2/2] Get rid of d_set_d_op() in procfs
config: x86_64-buildonly-randconfig-003-20250223 (https://download.01.org/0day-ci/archive/20250223/202502231747.l7oQ2cZ7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250223/202502231747.l7oQ2cZ7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502231747.l7oQ2cZ7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/dcache.c:3011: warning: Function parameter or struct member 'ops' not described in 'd_splice_alias_ops'
>> fs/dcache.c:3011: warning: expecting prototype for d_splice_alias(). Prototype was for d_splice_alias_ops() instead


vim +3011 fs/dcache.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  2985  
3f70bd51cb4405 J. Bruce Fields   2014-02-18  2986  /**
3f70bd51cb4405 J. Bruce Fields   2014-02-18  2987   * d_splice_alias - splice a disconnected dentry into the tree if one exists
3f70bd51cb4405 J. Bruce Fields   2014-02-18  2988   * @inode:  the inode which may have a disconnected dentry
3f70bd51cb4405 J. Bruce Fields   2014-02-18  2989   * @dentry: a negative dentry which we want to point to the inode.
3f70bd51cb4405 J. Bruce Fields   2014-02-18  2990   *
da093a9b76efca J. Bruce Fields   2014-02-17  2991   * If inode is a directory and has an IS_ROOT alias, then d_move that in
da093a9b76efca J. Bruce Fields   2014-02-17  2992   * place of the given dentry and return it, else simply d_add the inode
da093a9b76efca J. Bruce Fields   2014-02-17  2993   * to the dentry and return NULL.
3f70bd51cb4405 J. Bruce Fields   2014-02-18  2994   *
908790fa3b779d J. Bruce Fields   2014-02-17  2995   * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
908790fa3b779d J. Bruce Fields   2014-02-17  2996   * we should error out: directories can't have multiple aliases.
908790fa3b779d J. Bruce Fields   2014-02-17  2997   *
3f70bd51cb4405 J. Bruce Fields   2014-02-18  2998   * This is needed in the lookup routine of any filesystem that is exportable
3f70bd51cb4405 J. Bruce Fields   2014-02-18  2999   * (via knfsd) so that we can build dcache paths to directories effectively.
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3000   *
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3001   * If a dentry was found and moved, then it is returned.  Otherwise NULL
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3002   * is returned.  This matches the expected return value of ->lookup.
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3003   *
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3004   * Cluster filesystems may call this function with a negative, hashed dentry.
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3005   * In that case, we know that the inode will be a regular file, and also this
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3006   * will only occur during atomic_open. So we need to check for the dentry
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3007   * being already hashed only in the final case.
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3008   */
107a7f3910694e Al Viro           2025-02-22  3009  struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
107a7f3910694e Al Viro           2025-02-22  3010  				  const struct dentry_operations *ops)
3f70bd51cb4405 J. Bruce Fields   2014-02-18 @3011  {
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3012  	if (IS_ERR(inode))
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3013  		return ERR_CAST(inode);
3f70bd51cb4405 J. Bruce Fields   2014-02-18  3014  
770bfad846ab66 David Howells     2006-08-22  3015  	BUG_ON(!d_unhashed(dentry));
770bfad846ab66 David Howells     2006-08-22  3016  
de689f5e366373 Al Viro           2016-03-09  3017  	if (!inode)
b5ae6b15bd73e3 Al Viro           2014-10-12  3018  		goto out;
de689f5e366373 Al Viro           2016-03-09  3019  
b96809173e94ea Al Viro           2016-04-11  3020  	security_d_instantiate(dentry, inode);
873feea09ebc98 Nicholas Piggin   2011-01-07  3021  	spin_lock(&inode->i_lock);
9eaef27b36a6b7 Trond Myklebust   2006-10-21  3022  	if (S_ISDIR(inode->i_mode)) {
b5ae6b15bd73e3 Al Viro           2014-10-12  3023  		struct dentry *new = __d_find_any_alias(inode);
b5ae6b15bd73e3 Al Viro           2014-10-12  3024  		if (unlikely(new)) {
a03e283bf5c3d4 Eric W. Biederman 2015-08-15  3025  			/* The reference to new ensures it remains an alias */
a03e283bf5c3d4 Eric W. Biederman 2015-08-15  3026  			spin_unlock(&inode->i_lock);
1836750115f20b Al Viro           2011-07-12  3027  			write_seqlock(&rename_lock);
b5ae6b15bd73e3 Al Viro           2014-10-12  3028  			if (unlikely(d_ancestor(new, dentry))) {
1836750115f20b Al Viro           2011-07-12  3029  				write_sequnlock(&rename_lock);
b5ae6b15bd73e3 Al Viro           2014-10-12  3030  				dput(new);
b5ae6b15bd73e3 Al Viro           2014-10-12  3031  				new = ERR_PTR(-ELOOP);
dd179946db2493 David Howells     2011-08-16  3032  				pr_warn_ratelimited(
dd179946db2493 David Howells     2011-08-16  3033  					"VFS: Lookup of '%s' in %s %s"
dd179946db2493 David Howells     2011-08-16  3034  					" would have caused loop\n",
dd179946db2493 David Howells     2011-08-16  3035  					dentry->d_name.name,
dd179946db2493 David Howells     2011-08-16  3036  					inode->i_sb->s_type->name,
dd179946db2493 David Howells     2011-08-16  3037  					inode->i_sb->s_id);
b5ae6b15bd73e3 Al Viro           2014-10-12  3038  			} else if (!IS_ROOT(new)) {
076515fc926793 Al Viro           2018-03-10  3039  				struct dentry *old_parent = dget(new->d_parent);
ef69f0506d8f3a Al Viro           2023-11-23  3040  				int err = __d_unalias(dentry, new);
b5ae6b15bd73e3 Al Viro           2014-10-12  3041  				write_sequnlock(&rename_lock);
b5ae6b15bd73e3 Al Viro           2014-10-12  3042  				if (err) {
b5ae6b15bd73e3 Al Viro           2014-10-12  3043  					dput(new);
b5ae6b15bd73e3 Al Viro           2014-10-12  3044  					new = ERR_PTR(err);
dd179946db2493 David Howells     2011-08-16  3045  				}
076515fc926793 Al Viro           2018-03-10  3046  				dput(old_parent);
b5ae6b15bd73e3 Al Viro           2014-10-12  3047  			} else {
b5ae6b15bd73e3 Al Viro           2014-10-12  3048  				__d_move(new, dentry, false);
b5ae6b15bd73e3 Al Viro           2014-10-12  3049  				write_sequnlock(&rename_lock);
9eaef27b36a6b7 Trond Myklebust   2006-10-21  3050  			}
b5ae6b15bd73e3 Al Viro           2014-10-12  3051  			iput(inode);
b5ae6b15bd73e3 Al Viro           2014-10-12  3052  			return new;
770bfad846ab66 David Howells     2006-08-22  3053  		}
b5ae6b15bd73e3 Al Viro           2014-10-12  3054  	}
b5ae6b15bd73e3 Al Viro           2014-10-12  3055  out:
107a7f3910694e Al Viro           2025-02-22  3056  	__d_add(dentry, inode, ops);
770bfad846ab66 David Howells     2006-08-22  3057  	return NULL;
770bfad846ab66 David Howells     2006-08-22  3058  }
107a7f3910694e Al Viro           2025-02-22  3059  

:::::: The code at line 3011 was first introduced by commit
:::::: 3f70bd51cb4405dc5cf8624292ffa474679fc9c7 dcache: move d_splice_alias

:::::: TO: J. Bruce Fields <bfields@redhat.com>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


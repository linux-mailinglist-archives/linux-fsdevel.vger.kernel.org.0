Return-Path: <linux-fsdevel+bounces-76012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKWjAdnZf2mJygIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 23:55:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6502EC775F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 23:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E74173005D00
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0432E2EC55C;
	Sun,  1 Feb 2026 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmiHIpZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FC26A0B9
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Feb 2026 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986516; cv=none; b=WH9XGWRd/Xrt3EiLxuVsuKpQ5hZ9cukUjc5A+mk/Cix9KlQii2QP/Z4YSjZs7579qP1bsA5zasJDOmoCWOj6R+VPOT0AWpexEyYE+mbeJIQEJMtpOlWTDZQTgma34PMLTv0lHKTiZP9+CtJbVfnneGmJvp5TEjyaDjVMd4cbjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986516; c=relaxed/simple;
	bh=AADVXV62MJdxCLet4QqojGJdxzxqPvcR7wX7Ssri9vo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JVu0wJD5UCXc8zDTTcXW7mq1l9D3JQwli7UaoWdoQdp31UqqWT7A1zrO8/i8pSq6m8o23XbFIR7Bmq2g9Sa161KmjkLDmUK5zXOTrq+SjeX5S79wbVPZqN5GGcPij0q7d5aWnRtNOvEEdK9M0df3YVdvZVuiw+RWediehHJ042E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmiHIpZ6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769986514; x=1801522514;
  h=date:from:to:cc:subject:message-id;
  bh=AADVXV62MJdxCLet4QqojGJdxzxqPvcR7wX7Ssri9vo=;
  b=OmiHIpZ6MWRcllmYBmMms6Rqy9eHyIcbnr6xDVXMvC95BF7dKg7c9c4d
   KvNiZsavVsInHaJUa9Rq6gneVuQhFfGZX1PuaTJ5kb5fkXuJ2tYrNOfaT
   oSS3rj7Z1XriAFeBb48w4L1X0/JazHoPzA0RBL59iJ1VzKwA3DbF3xpWH
   O/PbqDvAWNjAQQ6IRx6dcdyObEkuCEpi5x+ywEYfOTLDsCkLAoGNLqFdm
   UrSJCFFbtvJaf8Z7xl5obkIk8PPbP7J8TUVW1dGWxGzH07+jF/b5SBoER
   wTlZZoAJy4WZYCE8r3POToS++QvTNw1HAIQmupn/2BSBmy5CUGfi5v9oq
   g==;
X-CSE-ConnectionGUID: UTsSwvqcRpOVzf52cg00wQ==
X-CSE-MsgGUID: N9vvoCHjQvuA+WGGxyDcPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71205387"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="71205387"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 14:55:13 -0800
X-CSE-ConnectionGUID: doKqf15vRTqxx/wJss/xxw==
X-CSE-MsgGUID: Z4m9iE0NReev7xGF2dOgRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="209242250"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 01 Feb 2026 14:55:11 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmgLV-00000000f5U-2NMZ;
	Sun, 01 Feb 2026 22:55:09 +0000
Date: Mon, 02 Feb 2026 06:54:51 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.coda 1/4] fs/coda/dir.c:471:1: warning: label
 'bad' defined but not used
Message-ID: <202602020633.nOeExEVJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76012-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6502EC775F
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.coda
head:   00a1de29cfe3a361a653e043d5277a5d4263b90b
commit: 59769809e38dc6250c396dd38f95d2ba05be2ced [1/4] coda: is_bad_inode() is always false there
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20260202/202602020633.nOeExEVJ-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260202/202602020633.nOeExEVJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602020633.nOeExEVJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/coda/dir.c: In function 'coda_dentry_revalidate':
>> fs/coda/dir.c:471:1: warning: label 'bad' defined but not used [-Wunused-label]
     471 | bad:
         | ^~~


vim +/bad +471 fs/coda/dir.c

b625032b10222c Fabian Frederick 2015-02-17  438  
^1da177e4c3f41 Linus Torvalds   2005-04-16  439  /* called when a cache lookup succeeds */
5be1fa8abd7b04 Al Viro          2024-12-08  440  static int coda_dentry_revalidate(struct inode *dir, const struct qstr *name,
5be1fa8abd7b04 Al Viro          2024-12-08  441  				  struct dentry *de, unsigned int flags)
^1da177e4c3f41 Linus Torvalds   2005-04-16  442  {
34286d6662308d Nicholas Piggin  2011-01-07  443  	struct inode *inode;
^1da177e4c3f41 Linus Torvalds   2005-04-16  444  	struct coda_inode_info *cii;
^1da177e4c3f41 Linus Torvalds   2005-04-16  445  
0b728e1911cbe6 Al Viro          2012-06-10  446  	if (flags & LOOKUP_RCU)
34286d6662308d Nicholas Piggin  2011-01-07  447  		return -ECHILD;
34286d6662308d Nicholas Piggin  2011-01-07  448  
2b0143b5c986be David Howells    2015-03-17  449  	inode = d_inode(de);
a7400222e3eb7d Al Viro          2014-10-21  450  	if (!inode || is_root_inode(inode))
^1da177e4c3f41 Linus Torvalds   2005-04-16  451  		goto out;
^1da177e4c3f41 Linus Torvalds   2005-04-16  452  
2b0143b5c986be David Howells    2015-03-17  453  	cii = ITOC(d_inode(de));
^1da177e4c3f41 Linus Torvalds   2005-04-16  454  	if (!(cii->c_flags & (C_PURGE | C_FLUSH)))
^1da177e4c3f41 Linus Torvalds   2005-04-16  455  		goto out;
^1da177e4c3f41 Linus Torvalds   2005-04-16  456  
^1da177e4c3f41 Linus Torvalds   2005-04-16  457  	shrink_dcache_parent(de);
^1da177e4c3f41 Linus Torvalds   2005-04-16  458  
^1da177e4c3f41 Linus Torvalds   2005-04-16  459  	/* propagate for a flush */
^1da177e4c3f41 Linus Torvalds   2005-04-16  460  	if (cii->c_flags & C_FLUSH) 
^1da177e4c3f41 Linus Torvalds   2005-04-16  461  		coda_flag_inode_children(inode, C_FLUSH);
^1da177e4c3f41 Linus Torvalds   2005-04-16  462  
84d08fa888e7c2 Al Viro          2013-07-05  463  	if (d_count(de) > 1)
^1da177e4c3f41 Linus Torvalds   2005-04-16  464  		/* pretend it's valid, but don't change the flags */
^1da177e4c3f41 Linus Torvalds   2005-04-16  465  		goto out;
^1da177e4c3f41 Linus Torvalds   2005-04-16  466  
^1da177e4c3f41 Linus Torvalds   2005-04-16  467  	/* clear the flags. */
b5ce1d83a62fc1 Yoshihisa Abe    2010-10-25  468  	spin_lock(&cii->c_lock);
^1da177e4c3f41 Linus Torvalds   2005-04-16  469  	cii->c_flags &= ~(C_VATTR | C_PURGE | C_FLUSH);
b5ce1d83a62fc1 Yoshihisa Abe    2010-10-25  470  	spin_unlock(&cii->c_lock);
^1da177e4c3f41 Linus Torvalds   2005-04-16 @471  bad:
^1da177e4c3f41 Linus Torvalds   2005-04-16  472  	return 0;
^1da177e4c3f41 Linus Torvalds   2005-04-16  473  out:
^1da177e4c3f41 Linus Torvalds   2005-04-16  474  	return 1;
^1da177e4c3f41 Linus Torvalds   2005-04-16  475  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  476  

:::::: The code at line 471 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


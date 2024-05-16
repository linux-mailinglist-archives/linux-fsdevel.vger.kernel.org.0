Return-Path: <linux-fsdevel+bounces-19626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4308C7DCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E62282045
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC0F157E9B;
	Thu, 16 May 2024 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="If106jzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFF157A76
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892434; cv=none; b=SWn0HVF1AIkr+e8vKGK6cGr16dTQEht//RdTnibWDJA6X1vRhQQfyhMFOx5SgM6gbirgy4y7M0WBuLh4QXEhxkiTMg92wmAFqxNaJo/By/1uXvPGmSJMjV/SJ9Ztd96auQeYvJLH7T4Cotp3hDkwAB62Pd3Lqt8mrNNZwx68hK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892434; c=relaxed/simple;
	bh=280i5dWRybdaAkMbFSD7O5UetUHSt+pWDkAiPdCi6JU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fsOmRoJ1FM49Y+SF0L7Nhdt/nN8NKx3reg0tvpRKyt+HVVibbT6tNiyy0NwMfe6mJUpQqL1Kzy4lu8IknyphECjwxr7SG4PwMRmqIkAU6spaBjfaYXVe2J0fG9875KP1YEI2lGt+lF/ztk2k5PYLw827vgWwNvjSSUcyr0W3Wcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=If106jzG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715892433; x=1747428433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=280i5dWRybdaAkMbFSD7O5UetUHSt+pWDkAiPdCi6JU=;
  b=If106jzGVw/QqIfnV8yMwuSfLFMNXLyQtSii9tlaMs7RTd/2Va6niAiQ
   cR1SYDEDdXWbBAvbAVkIpbzObR+TQD9yoLSyKO69dlfzeJS+w+lAtHoYp
   Kq2S3Cg3jVKSL1yl0jhhGaZVXeXgk46b4wiPO1vIIpV2hchaJTn4Ie5a6
   se75jjZCR91kClI8q14+9GmGwjT4ZseYEW3z1WoYcS8XvspkvLbyv4F+F
   spXU9jzFsNUJfZW1ucd7a+uU1XX3cYZWpJDvxKjVJNs1hdn2qeboMVcPz
   56YdFDgK20u4IsoaugXNzodAI83fFekkn8GnHdx9iqwTvuZ2xBR5uPs5B
   A==;
X-CSE-ConnectionGUID: 4Vdndp25T4ebfGeH3xfL0A==
X-CSE-MsgGUID: NEZuziOTQOOhe9vYFS0Nrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15868860"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="15868860"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 13:47:10 -0700
X-CSE-ConnectionGUID: 8KfTznPGRqCZo2Ic1t6tlA==
X-CSE-MsgGUID: scsp8ofuQYGM9PJEIU2Ang==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="32102372"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 May 2024 13:47:08 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7i0H-000Elt-2s;
	Thu, 16 May 2024 20:47:05 +0000
Date: Fri, 17 May 2024 04:47:01 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:untested.persistency 57/58]
 security/integrity/ima/ima_fs.c:430:20: error: use of undeclared identifier
 'ima_policy'
Message-ID: <202405170447.fAkCQdzn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git untested.persistency
head:   b3c987f7369f15318ee1284d9203737f09294b7e
commit: c6429afc4eb7e8fd9044f85e21c53285f1b96a8b [57/58] ima_fs: don't bother with removal of files in directory we'll be removing
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240517/202405170447.fAkCQdzn-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405170447.fAkCQdzn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405170447.fAkCQdzn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/integrity/ima/ima_fs.c:430:20: error: use of undeclared identifier 'ima_policy'
     430 |         securityfs_remove(ima_policy);
         |                           ^
   security/integrity/ima/ima_fs.c:431:2: error: use of undeclared identifier 'ima_policy'
     431 |         ima_policy = NULL;
         |         ^
   2 errors generated.


vim +/ima_policy +430 security/integrity/ima/ima_fs.c

f4bd857bc8ed99 Mimi Zohar      2009-02-04  397  
4af4662fa4a9dc Mimi Zohar      2009-02-04  398  /*
4af4662fa4a9dc Mimi Zohar      2009-02-04  399   * ima_release_policy - start using the new measure policy rules.
4af4662fa4a9dc Mimi Zohar      2009-02-04  400   *
4af4662fa4a9dc Mimi Zohar      2009-02-04  401   * Initially, ima_measure points to the default policy rules, now
f4bd857bc8ed99 Mimi Zohar      2009-02-04  402   * point to the new policy rules, and remove the securityfs policy file,
f4bd857bc8ed99 Mimi Zohar      2009-02-04  403   * assuming a valid policy.
4af4662fa4a9dc Mimi Zohar      2009-02-04  404   */
4af4662fa4a9dc Mimi Zohar      2009-02-04  405  static int ima_release_policy(struct inode *inode, struct file *file)
4af4662fa4a9dc Mimi Zohar      2009-02-04  406  {
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  407  	const char *cause = valid_policy ? "completed" : "failed";
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  408  
80eae209d63ac6 Petko Manolov   2015-12-02  409  	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
9a11a18902bc3b Eric Richter    2016-10-13  410  		return seq_release(inode, file);
80eae209d63ac6 Petko Manolov   2015-12-02  411  
0112721df4edbd Sasha Levin     2015-12-22  412  	if (valid_policy && ima_check_policy() < 0) {
0112721df4edbd Sasha Levin     2015-12-22  413  		cause = "failed";
0112721df4edbd Sasha Levin     2015-12-22  414  		valid_policy = 0;
0112721df4edbd Sasha Levin     2015-12-22  415  	}
0112721df4edbd Sasha Levin     2015-12-22  416  
de636769c8c735 Petr Vorel      2018-04-24  417  	pr_info("policy update %s\n", cause);
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  418  	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  419  			    "policy_update", cause, !valid_policy, 0);
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  420  
4af4662fa4a9dc Mimi Zohar      2009-02-04  421  	if (!valid_policy) {
4af4662fa4a9dc Mimi Zohar      2009-02-04  422  		ima_delete_rules();
f4bd857bc8ed99 Mimi Zohar      2009-02-04  423  		valid_policy = 1;
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  424  		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
4af4662fa4a9dc Mimi Zohar      2009-02-04  425  		return 0;
4af4662fa4a9dc Mimi Zohar      2009-02-04  426  	}
80eae209d63ac6 Petko Manolov   2015-12-02  427  
4af4662fa4a9dc Mimi Zohar      2009-02-04  428  	ima_update_policy();
2068626d1345f2 Mimi Zohar      2017-06-27  429  #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
4af4662fa4a9dc Mimi Zohar      2009-02-04 @430  	securityfs_remove(ima_policy);
4af4662fa4a9dc Mimi Zohar      2009-02-04  431  	ima_policy = NULL;
2068626d1345f2 Mimi Zohar      2017-06-27  432  #elif defined(CONFIG_IMA_WRITE_POLICY)
38d859f991f3a0 Petko Manolov   2015-12-02  433  	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
ffb122de9a60bd Petr Vorel      2018-04-20  434  #elif defined(CONFIG_IMA_READ_POLICY)
ffb122de9a60bd Petr Vorel      2018-04-20  435  	inode->i_mode &= ~S_IWUSR;
38d859f991f3a0 Petko Manolov   2015-12-02  436  #endif
4af4662fa4a9dc Mimi Zohar      2009-02-04  437  	return 0;
4af4662fa4a9dc Mimi Zohar      2009-02-04  438  }
4af4662fa4a9dc Mimi Zohar      2009-02-04  439  

:::::: The code at line 430 was first introduced by commit
:::::: 4af4662fa4a9dc62289c580337ae2506339c4729 integrity: IMA policy

:::::: TO: Mimi Zohar <zohar@linux.vnet.ibm.com>
:::::: CC: James Morris <jmorris@namei.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


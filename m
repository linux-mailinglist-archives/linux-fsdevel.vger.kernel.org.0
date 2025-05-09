Return-Path: <linux-fsdevel+bounces-48628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DBFAB1934
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3F27B90AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E823314B;
	Fri,  9 May 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9Mdw/11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F90230D0F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805712; cv=none; b=n1cbwcGU4NS0ZAYN3ZDlRK/tRZlMIg1g8x7ugShD5INCjud+I5giEX2yrc5fc1JoXJ4i6tIkw43ouABL3if1MHKYW7phzU3SzsgrBnNCHOOH7cCw5S/1JoSSO/OmtCkYBDoj5XSme5q91qC1Kf1hueyREIqyeERqaYh4BD4z3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805712; c=relaxed/simple;
	bh=sQE2inl0YIg6+YUK95+sm+7J1pVM4PS8ilMmjVAujok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M+gRxvbg/BBLtb0KM4e5cceWB8kUVbJ0zqHuC2XKXXeHcjO0Pic7eC+ylOW3UTG8x6tkqKa5Tc6Iu4kYwttRiCzTaPrRCJyxA0p9cDMqU4Y71gn0hsx9tJ5SdAK++MaxFf2tTAScUXUyY997hDAgor/i4HqDdYK8SPc1hiF1QJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9Mdw/11; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746805710; x=1778341710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sQE2inl0YIg6+YUK95+sm+7J1pVM4PS8ilMmjVAujok=;
  b=Z9Mdw/11OTnH2wBojULp+KRswqJ/JZhp4gggrAaetOKPvCI5eE/9GsFw
   ECKG9JzL3m5jTqg2Urz9hyUGwuGMtOO6YK4NAlQHmSrtgCSxLhMMzmOng
   XntIKqpXhVSVYkRwuP/HXFsKT0zH2WXInK+IcjsljJ3Dgubt3Luz+vdqY
   XdIAsnLjxQAidLb/NfY4XqgI2gzReWoZNCStIrLX+x8qyAnOu3I2ZWEzv
   YeewEQ0Prhnuiw0QTnM0gaVGQylmd28vrBqLSTZylzul7e9INpweOrIRt
   c89K4XTESv2g2Pr7AoIpe2RB+NwvIvTXXsPGPqi1/UlVNo8mOAZluqUuR
   Q==;
X-CSE-ConnectionGUID: R1w+fb1KTlKT7ARjDv0TPg==
X-CSE-MsgGUID: AobQ3syzSKy9e5oLwlcEiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59271290"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59271290"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 08:48:30 -0700
X-CSE-ConnectionGUID: 5FbhNDtoRNekGnsArQMQPg==
X-CSE-MsgGUID: UJhFLO0/Qe+/L/U78ZiLvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="137637550"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 May 2025 08:48:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDPxa-000CDT-0t;
	Fri, 09 May 2025 15:48:26 +0000
Date: Fri, 9 May 2025 23:47:36 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:untested.securityfs 6/8]
 security/integrity/ima/ima_fs.c:524:27: error: 'ima_policy' undeclared; did
 you mean 'vma_policy'?
Message-ID: <202505092310.0UXOhVZP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git untested.securityfs
head:   b0b8e25f92ec20e266859de5f823b4e39b8e2f9d
commit: 08433f2507554980bc891d8b17c1968c81cb144b [6/8] ima_fs: don't bother with removal of files in directory we'll be removing
config: i386-buildonly-randconfig-006-20250509 (https://download.01.org/0day-ci/archive/20250509/202505092310.0UXOhVZP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505092310.0UXOhVZP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505092310.0UXOhVZP-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/integrity/ima/ima_fs.c: In function 'ima_release_policy':
>> security/integrity/ima/ima_fs.c:524:27: error: 'ima_policy' undeclared (first use in this function); did you mean 'vma_policy'?
     524 |         securityfs_remove(ima_policy);
         |                           ^~~~~~~~~~
         |                           vma_policy
   security/integrity/ima/ima_fs.c:524:27: note: each undeclared identifier is reported only once for each function it appears in


vim +524 security/integrity/ima/ima_fs.c

f4bd857bc8ed99 Mimi Zohar      2009-02-04  491  
4af4662fa4a9dc Mimi Zohar      2009-02-04  492  /*
4af4662fa4a9dc Mimi Zohar      2009-02-04  493   * ima_release_policy - start using the new measure policy rules.
4af4662fa4a9dc Mimi Zohar      2009-02-04  494   *
4af4662fa4a9dc Mimi Zohar      2009-02-04  495   * Initially, ima_measure points to the default policy rules, now
f4bd857bc8ed99 Mimi Zohar      2009-02-04  496   * point to the new policy rules, and remove the securityfs policy file,
f4bd857bc8ed99 Mimi Zohar      2009-02-04  497   * assuming a valid policy.
4af4662fa4a9dc Mimi Zohar      2009-02-04  498   */
4af4662fa4a9dc Mimi Zohar      2009-02-04  499  static int ima_release_policy(struct inode *inode, struct file *file)
4af4662fa4a9dc Mimi Zohar      2009-02-04  500  {
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  501  	const char *cause = valid_policy ? "completed" : "failed";
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  502  
80eae209d63ac6 Petko Manolov   2015-12-02  503  	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
9a11a18902bc3b Eric Richter    2016-10-13  504  		return seq_release(inode, file);
80eae209d63ac6 Petko Manolov   2015-12-02  505  
0112721df4edbd Sasha Levin     2015-12-22  506  	if (valid_policy && ima_check_policy() < 0) {
0112721df4edbd Sasha Levin     2015-12-22  507  		cause = "failed";
0112721df4edbd Sasha Levin     2015-12-22  508  		valid_policy = 0;
0112721df4edbd Sasha Levin     2015-12-22  509  	}
0112721df4edbd Sasha Levin     2015-12-22  510  
de636769c8c735 Petr Vorel      2018-04-24  511  	pr_info("policy update %s\n", cause);
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  512  	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  513  			    "policy_update", cause, !valid_policy, 0);
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  514  
4af4662fa4a9dc Mimi Zohar      2009-02-04  515  	if (!valid_policy) {
4af4662fa4a9dc Mimi Zohar      2009-02-04  516  		ima_delete_rules();
f4bd857bc8ed99 Mimi Zohar      2009-02-04  517  		valid_policy = 1;
0716abbb58e3c4 Dmitry Kasatkin 2014-10-03  518  		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
4af4662fa4a9dc Mimi Zohar      2009-02-04  519  		return 0;
4af4662fa4a9dc Mimi Zohar      2009-02-04  520  	}
80eae209d63ac6 Petko Manolov   2015-12-02  521  
4af4662fa4a9dc Mimi Zohar      2009-02-04  522  	ima_update_policy();
2068626d1345f2 Mimi Zohar      2017-06-27  523  #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
4af4662fa4a9dc Mimi Zohar      2009-02-04 @524  	securityfs_remove(ima_policy);
4af4662fa4a9dc Mimi Zohar      2009-02-04  525  	ima_policy = NULL;
2068626d1345f2 Mimi Zohar      2017-06-27  526  #elif defined(CONFIG_IMA_WRITE_POLICY)
38d859f991f3a0 Petko Manolov   2015-12-02  527  	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
ffb122de9a60bd Petr Vorel      2018-04-20  528  #elif defined(CONFIG_IMA_READ_POLICY)
ffb122de9a60bd Petr Vorel      2018-04-20  529  	inode->i_mode &= ~S_IWUSR;
38d859f991f3a0 Petko Manolov   2015-12-02  530  #endif
4af4662fa4a9dc Mimi Zohar      2009-02-04  531  	return 0;
4af4662fa4a9dc Mimi Zohar      2009-02-04  532  }
4af4662fa4a9dc Mimi Zohar      2009-02-04  533  

:::::: The code at line 524 was first introduced by commit
:::::: 4af4662fa4a9dc62289c580337ae2506339c4729 integrity: IMA policy

:::::: TO: Mimi Zohar <zohar@linux.vnet.ibm.com>
:::::: CC: James Morris <jmorris@namei.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


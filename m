Return-Path: <linux-fsdevel+bounces-25745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A194FB38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5C5B22513
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4AAD55;
	Tue, 13 Aug 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O27ZVhRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117E1862A;
	Tue, 13 Aug 2024 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513381; cv=none; b=Mjqg5dVBNJBPMfODsEd5rPOL79PpA5LPAFQh/uKgvBj/tIaGbD6Sw7TcbjIrV8MdCgZ0+y2xpz7bfz1IZTB3zKz5Kel7ErIjWYxtmmvpsePn6TdF4dhuPVCW7K+CRYqpciDcZIdWZN+Mc2z5nUJaI0rvokGYbBYe+5wSvuRxf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513381; c=relaxed/simple;
	bh=E8BiRqRglbFFjW1zOqdbDtYCEbx4rmgVM86pankZnus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cawYD7HtZHqRHddcj3lr7/oMMcATpyg+PRyXGBHuJnaCNR34+g1IphIoMvqCeJ/LrIIthryH7xPrLeuZnXzD4QdArTeWRG5OPS1SuJumql+cV8V7kuG8he7jGIkIDGzaj83c95w2SuE8DC559NHIpG6b6xgnszmrh8x9mwuFzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O27ZVhRb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723513379; x=1755049379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E8BiRqRglbFFjW1zOqdbDtYCEbx4rmgVM86pankZnus=;
  b=O27ZVhRbO3Hl7dZzNmtNCP4TN+xwlzU7O1MERnDqFcVliTtAbAzc8sKK
   P9587IBHPOXg4o8wEmj+DJafSw/PHvXoMVBiLU/1s9y/9kw5wfIFvWACj
   W6iAmO1LV3hKDYItmu4edKfv7QOW2nkJYxbm2ENFtPWlyti0r6F4VIhh3
   fgQhgCUEvUnv1rhReOdPS2TaaODawckuZoC/RdWehNQ1ISBCjzGBZdIla
   2AYXDZ2Ho04ez0VAz4O7jZAexDh1nlXbRGsgvZBWk2DvB+G0iTe8tuPCK
   jyLDsMgKGPpJT1T01pKFNydRbt8cNjT5kBszdRNdMWrrM5KELe4dh4Ug4
   Q==;
X-CSE-ConnectionGUID: NvFwCcCrSCuyPeA3byH78A==
X-CSE-MsgGUID: eDBTcuyORTCpKYfYmv8t1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21523501"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="21523501"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:42:58 -0700
X-CSE-ConnectionGUID: 6Xjlq1HySSi/7o6roMn35w==
X-CSE-MsgGUID: qP+sttF1Rz+gbYxEI21S6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="81733529"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2024 18:42:56 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdgYm-000CJ7-2L;
	Tue, 13 Aug 2024 01:42:52 +0000
Date: Tue, 13 Aug 2024 09:42:29 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: oe-kbuild-all@lists.linux.dev,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
	Casey Schaufler <casey@schaufler-ca.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] fs,security: Fix file_set_fowner LSM hook inconsistencies
Message-ID: <202408130946.6oMWnayg-lkp@intel.com>
References: <20240812144936.1616628-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812144936.1616628-1-mic@digikod.net>

Hi Mickaël,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-selinux/next]
[also build test WARNING on linus/master v6.11-rc3 next-20240812]
[cannot apply to brauner-vfs/vfs.all]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micka-l-Sala-n/fs-security-Fix-file_set_fowner-LSM-hook-inconsistencies/20240813-004648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20240812144936.1616628-1-mic%40digikod.net
patch subject: [PATCH] fs,security: Fix file_set_fowner LSM hook inconsistencies
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240813/202408130946.6oMWnayg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408130946.6oMWnayg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408130946.6oMWnayg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   security/smack/smack_lsm.c: In function 'smack_file_send_sigiotask':
>> security/smack/smack_lsm.c:1913:22: warning: variable 'file' set but not used [-Wunused-but-set-variable]
    1913 |         struct file *file;
         |                      ^~~~


vim +/file +1913 security/smack/smack_lsm.c

7898e1f8e9eb1b Casey Schaufler 2011-01-17  1895  
e114e473771c84 Casey Schaufler 2008-02-04  1896  /**
e114e473771c84 Casey Schaufler 2008-02-04  1897   * smack_file_send_sigiotask - Smack on sigio
e114e473771c84 Casey Schaufler 2008-02-04  1898   * @tsk: The target task
e114e473771c84 Casey Schaufler 2008-02-04  1899   * @fown: the object the signal come from
e114e473771c84 Casey Schaufler 2008-02-04  1900   * @signum: unused
e114e473771c84 Casey Schaufler 2008-02-04  1901   *
e114e473771c84 Casey Schaufler 2008-02-04  1902   * Allow a privileged task to get signals even if it shouldn't
e114e473771c84 Casey Schaufler 2008-02-04  1903   *
e114e473771c84 Casey Schaufler 2008-02-04  1904   * Returns 0 if a subject with the object's smack could
e114e473771c84 Casey Schaufler 2008-02-04  1905   * write to the task, an error code otherwise.
e114e473771c84 Casey Schaufler 2008-02-04  1906   */
e114e473771c84 Casey Schaufler 2008-02-04  1907  static int smack_file_send_sigiotask(struct task_struct *tsk,
e114e473771c84 Casey Schaufler 2008-02-04  1908  				     struct fown_struct *fown, int signum)
e114e473771c84 Casey Schaufler 2008-02-04  1909  {
2f823ff8bec03a Casey Schaufler 2013-05-22  1910  	struct smack_known *skp;
b17103a8b8ae9c Casey Schaufler 2018-11-09  1911  	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
dcb569cf6ac99c Casey Schaufler 2018-09-18  1912  	const struct cred *tcred;
e114e473771c84 Casey Schaufler 2008-02-04 @1913  	struct file *file;
e114e473771c84 Casey Schaufler 2008-02-04  1914  	int rc;
ecfcc53fef3c35 Etienne Basset  2009-04-08  1915  	struct smk_audit_info ad;
e114e473771c84 Casey Schaufler 2008-02-04  1916  
e114e473771c84 Casey Schaufler 2008-02-04  1917  	/*
e114e473771c84 Casey Schaufler 2008-02-04  1918  	 * struct fown_struct is never outside the context of a struct file
e114e473771c84 Casey Schaufler 2008-02-04  1919  	 */
e114e473771c84 Casey Schaufler 2008-02-04  1920  	file = container_of(fown, struct file, f_owner);
7898e1f8e9eb1b Casey Schaufler 2011-01-17  1921  
ecfcc53fef3c35 Etienne Basset  2009-04-08  1922  	/* we don't log here as rc can be overriden */
32192c8e14ea34 Mickaël Salaün  2024-08-12  1923  	skp = smk_of_task(smack_cred(rcu_dereference(fown->cred)));
c60b906673eebb Casey Schaufler 2016-08-30  1924  	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
c60b906673eebb Casey Schaufler 2016-08-30  1925  	rc = smk_bu_note("sigiotask", skp, tkp, MAY_DELIVER, rc);
dcb569cf6ac99c Casey Schaufler 2018-09-18  1926  
dcb569cf6ac99c Casey Schaufler 2018-09-18  1927  	rcu_read_lock();
dcb569cf6ac99c Casey Schaufler 2018-09-18  1928  	tcred = __task_cred(tsk);
dcb569cf6ac99c Casey Schaufler 2018-09-18  1929  	if (rc != 0 && smack_privileged_cred(CAP_MAC_OVERRIDE, tcred))
ecfcc53fef3c35 Etienne Basset  2009-04-08  1930  		rc = 0;
dcb569cf6ac99c Casey Schaufler 2018-09-18  1931  	rcu_read_unlock();
ecfcc53fef3c35 Etienne Basset  2009-04-08  1932  
ecfcc53fef3c35 Etienne Basset  2009-04-08  1933  	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_TASK);
ecfcc53fef3c35 Etienne Basset  2009-04-08  1934  	smk_ad_setfield_u_tsk(&ad, tsk);
c60b906673eebb Casey Schaufler 2016-08-30  1935  	smack_log(skp->smk_known, tkp->smk_known, MAY_DELIVER, rc, &ad);
e114e473771c84 Casey Schaufler 2008-02-04  1936  	return rc;
e114e473771c84 Casey Schaufler 2008-02-04  1937  }
e114e473771c84 Casey Schaufler 2008-02-04  1938  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


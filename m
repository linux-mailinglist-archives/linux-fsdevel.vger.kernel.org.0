Return-Path: <linux-fsdevel+bounces-10196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B6D848A52
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2481F234AF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 01:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A653115B7;
	Sun,  4 Feb 2024 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSXOCzry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C310F7;
	Sun,  4 Feb 2024 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707011632; cv=none; b=QUmAm+KoLl/CSEdXx1PdxGPJOy35fSUY+ROzUhgtX8RdIRvuzS6E4WBDvYExLkCdrIhIFsSsyYhv9fWv+tg2VHh2reJSbzynOAfa29o9uH6r49Vvsz5lRygIcdmM1kBtKE548sWJLJoFdPMyFBLFQaRNuR1OsxH2cJf+d7Cyayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707011632; c=relaxed/simple;
	bh=tfGBp5nvVFWf5Zm9OLpbTlKSokt3hxQsAP3obbJSHmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx8oaX/DqerrgOnrGPVsnn901FUdI7yawXeu+SLLD+rMpct3X62P4KvmCHLUt9+dIUhDPQ7zr0XT2DaIuUD5R4mlI3ohFtt85r3Wg7olyLnev3p0wCocxcPzsT0dUOxg5/uxtRJLuPALl8ryLRuOcmdqvLD9I+EOBieniwAlRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSXOCzry; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707011630; x=1738547630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tfGBp5nvVFWf5Zm9OLpbTlKSokt3hxQsAP3obbJSHmA=;
  b=MSXOCzryvJMJni/OLrkVx8CTMpacsobJfoMm3F/SemRhvAl3nxtI0mtH
   QvJ1kc1gAqSEU0JRS3xqROHd9vo2byugVHqJjm/gn8NKqIA/1qBULsNWa
   e6f2M2yppaBfYs5U5puzI/tbK1kv9i9s941W9QCPgcj+xYg5cPy8UfC0j
   QKjkcBWpLwQjd5TGl3whonRoQ5OVSDfRIqRRC8BLB63Z7Ki4pP4QA2SEf
   jNPm0SNbDYDN3VVXk6Lli0dr//i6wVILbDV4lldSocDS9KhSdkv6HT2mN
   1KQdvuUbF5VzkVQfPnc2mjZranPx5LlriMuODSJloom6MlzeHAA8nf3BV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="263819"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="263819"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 17:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="622509"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 03 Feb 2024 17:53:46 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWRhR-0005s4-0N;
	Sun, 04 Feb 2024 01:53:39 +0000
Date: Sun, 4 Feb 2024 09:53:17 +0800
From: kernel test robot <lkp@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] tomoyo: replace current->in_execve flag with
 security_execve_abort() hook
Message-ID: <202402040956.6IuNw6B3-lkp@intel.com>
References: <2a901d27-dba5-4ff4-9e47-373c54965253@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a901d27-dba5-4ff4-9e47-373c54965253@I-love.SAKURA.ne.jp>

Hi Tetsuo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/execve]
[also build test WARNING on linux/master tip/sched/core linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/LSM-add-security_execve_abort-hook/20240203-185605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/2a901d27-dba5-4ff4-9e47-373c54965253%40I-love.SAKURA.ne.jp
patch subject: [PATCH v2 2/3] tomoyo: replace current->in_execve flag with security_execve_abort() hook
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240204/202402040956.6IuNw6B3-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040956.6IuNw6B3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040956.6IuNw6B3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/tomoyo/tomoyo.c:30: warning: Excess function parameter 'bprm' description in 'tomoyo_execve_abort'


vim +30 security/tomoyo/tomoyo.c

ee18d64c1f6320 David Howells   2009-09-02  23  
0f2a55d5bb2372 Tetsuo Handa    2011-07-14  24  /**
89cebc094231d4 Tetsuo Handa    2024-02-03  25   * tomoyo_execve_abort - Target for security_execve_abort().
0f2a55d5bb2372 Tetsuo Handa    2011-07-14  26   *
89cebc094231d4 Tetsuo Handa    2024-02-03  27   * @bprm: void
0f2a55d5bb2372 Tetsuo Handa    2011-07-14  28   */
89cebc094231d4 Tetsuo Handa    2024-02-03  29  static void tomoyo_execve_abort(void)
f7433243770c77 Kentaro Takeda  2009-02-05 @30  {
89cebc094231d4 Tetsuo Handa    2024-02-03  31  	/* Restore old_domain_info saved by execve() request. */
8c6cb983cd52d7 Tetsuo Handa    2019-01-19  32  	struct tomoyo_task *s = tomoyo_task(current);
43fc460907dc56 Casey Schaufler 2018-09-21  33  
89cebc094231d4 Tetsuo Handa    2024-02-03  34  	if (s->old_domain_info) {
8c6cb983cd52d7 Tetsuo Handa    2019-01-19  35  		atomic_dec(&s->domain_info->users);
8c6cb983cd52d7 Tetsuo Handa    2019-01-19  36  		s->domain_info = s->old_domain_info;
8c6cb983cd52d7 Tetsuo Handa    2019-01-19  37  		s->old_domain_info = NULL;
f7433243770c77 Kentaro Takeda  2009-02-05  38  	}
ec8e6a4e062e2e Tetsuo Handa    2010-02-11  39  }
ec8e6a4e062e2e Tetsuo Handa    2010-02-11  40  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


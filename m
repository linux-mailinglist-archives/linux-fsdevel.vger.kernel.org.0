Return-Path: <linux-fsdevel+bounces-7020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94281FF30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 12:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC901C22369
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591CA11199;
	Fri, 29 Dec 2023 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bah1vHAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09510A36;
	Fri, 29 Dec 2023 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703849826; x=1735385826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jXpLHm3Y0MAniZ7pNG5aFvqoCCSnZ/QB13PROwYSaT8=;
  b=bah1vHAgKd0F16QnKtzcmLBAg379AwRKSusj1s2II9twMOje6gkwGpWM
   yNtfSOPQX94TfmtUVVjv05tgi+Bx74U+dU/flizPFmbvC/mAa8Yab5mQX
   +Io+pkRXoZrw+ssI3EKjfBd1tZ9/i6oP9S6Ie9/VLqZBtS5caeQ93VYD+
   WRsL9crS2fNhGlLzd2X5fQDh8hK0vtBFh2+eMUX9f45+NyedWRQI/Z3o2
   PUK73ul/z9PWPItM8h3gasBnPwt2ooChlI23AzbKdeamZasGdVjQVfX7c
   V/rc2wcHGkOqC0XMP3hCHqf+v5lyuhEYSc+dRETaKnkbJNlRq5gr2RWsB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="381615577"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="381615577"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 03:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="771950637"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="771950637"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Dec 2023 03:36:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJBAe-000HOd-0D;
	Fri, 29 Dec 2023 11:36:56 +0000
Date: Fri, 29 Dec 2023 19:35:58 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Wilcox <willy@infradead.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Cc: oe-kbuild-all@lists.linux.dev, Maria Yu <quic_aiquny@quicinc.com>,
	kernel@quicinc.com, quic_pkondeti@quicinc.com, keescook@chromium.or,
	viro@zeniv.linux.org.uk, brauner@kernel.org, oleg@redhat.com,
	dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Message-ID: <202312291936.G87eGfCo-lkp@intel.com>
References: <ZY30k7OCtxrdR9oP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY30k7OCtxrdR9oP@casper.infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on arnd-asm-generic/master brauner-vfs/vfs.all vfs-idmapping/for-next linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox/Re-PATCH-kernel-Introduce-a-write-lock-unlock-wrapper-for-tasklist_lock/20231229-062352
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/ZY30k7OCtxrdR9oP%40casper.infradead.org
patch subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for tasklist_lock
config: i386-randconfig-011-20231229 (https://download.01.org/0day-ci/archive/20231229/202312291936.G87eGfCo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231229/202312291936.G87eGfCo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312291936.G87eGfCo-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/locking/spinlock_debug.c: In function 'do_raw_write_lock_irq':
>> kernel/locking/spinlock_debug.c:217:9: error: implicit declaration of function 'arch_write_lock_irq'; did you mean '_raw_write_lock_irq'? [-Werror=implicit-function-declaration]
     217 |         arch_write_lock_irq(&lock->raw_lock);
         |         ^~~~~~~~~~~~~~~~~~~
         |         _raw_write_lock_irq
   cc1: some warnings being treated as errors


vim +217 kernel/locking/spinlock_debug.c

   213	
   214	void do_raw_write_lock_irq(rwlock_t *lock)
   215	{
   216		debug_write_lock_before(lock);
 > 217		arch_write_lock_irq(&lock->raw_lock);
   218		debug_write_lock_after(lock);
   219	}
   220	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


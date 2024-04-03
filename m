Return-Path: <linux-fsdevel+bounces-16043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F67E897455
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2C028135E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DF14A4E9;
	Wed,  3 Apr 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSQvN18p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2123143869;
	Wed,  3 Apr 2024 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159279; cv=none; b=WysVQ44QwEJc9J4QjbI4/PORqp6Zz7kEJTcnGdmew41NM8ZR2WS5j+tHtzJz2aSdLIbQAFrW8WlxYF/a4iyCqFDN3M3Dbmg9p4wh25ECUSVIdFh84Nf0zV7TojfioywbzSJYSRt9faNCi4F29lqdayyv8H7Wv86PpuBBA0/L030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159279; c=relaxed/simple;
	bh=wzzfIE273kK/KSd802a4HQaAZTBLYE4XpaXSQtu0YcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOomeMP0keHlgo1rG9LCnF1zGva4jCylnAByYW4Cdi7/Yu/bfJ1uRWdFGY8p5D8BGvFK0q1y9Z4cqM9++QfiJXMT0hrR8RWNTBfHCUTMSYP8V3Wjde96zU+szcdeQjyNrI9HoCh98VYyeOGVcwcIYfk0B+CdS5TTBbeazfImsc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSQvN18p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712159279; x=1743695279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wzzfIE273kK/KSd802a4HQaAZTBLYE4XpaXSQtu0YcQ=;
  b=lSQvN18pfmZNZ3cQe6C7SnKzJuLykRjKjBO4ByNAXzelSvsj+wKuVU/V
   Dedv5/DtBF9R5hBkPIi3UaEbFa4oXMnd040+OeurcTsgfKV2s0xUI08yq
   L89vhS/2c9Pu39W5wyD3aKWaGi+6/O/JvjXi9RAIQkQsgtUSKT9+NbztM
   r559e2WZKNqEACYe2NUP7hnIY87G1bees6y87uOzY3Crgn6nOZ+Cu/d8F
   J+K3IS1SmPHMyI/GEzeUqiKEN2p1JMmAE+kbPP9kieJax1o4bcn4ULO9W
   BgRYlHjsn3ZOj0zp4NN3Q63Sh3j5GQy/3gbh1WFpWwnonp1KBgQK/uXvf
   w==;
X-CSE-ConnectionGUID: UGoyrI8bQwGV7sTXj+muHg==
X-CSE-MsgGUID: I6q8bCmeTzykcBlCN96BsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18558390"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18558390"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:47:58 -0700
X-CSE-ConnectionGUID: xFH3pTNqRYKDyd2CjLd83Q==
X-CSE-MsgGUID: fkgl5cVSTnqwRuFhVMznNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18397626"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 03 Apr 2024 08:47:54 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs2q7-0002Mc-2t;
	Wed, 03 Apr 2024 15:47:51 +0000
Date: Wed, 3 Apr 2024 23:40:32 +0800
From: kernel test robot <lkp@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, brauner@kernel.org,
	amir73il@gmail.com, hu1.chen@intel.com
Cc: oe-kbuild-all@lists.linux.dev, miklos@szeredi.hu,
	malini.bhandaru@intel.com, tim.c.chen@intel.com,
	mikko.ylinen@intel.com, lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH v1 2/3] fs: Optimize credentials reference count for
 backing file ops
Message-ID: <202404032344.SKdrnkhI-lkp@intel.com>
References: <20240403021808.309900-3-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403021808.309900-3-vinicius.gomes@intel.com>

Hi Vinicius,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.9-rc2 next-20240403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vinicius-Costa-Gomes/cred-Add-a-light-version-of-override-revert_creds/20240403-101954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20240403021808.309900-3-vinicius.gomes%40intel.com
patch subject: [PATCH v1 2/3] fs: Optimize credentials reference count for backing file ops
config: i386-randconfig-061-20240403 (https://download.01.org/0day-ci/archive/20240403/202404032344.SKdrnkhI-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404032344.SKdrnkhI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404032344.SKdrnkhI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/backing-file.c: note: in included file (through include/linux/sched/signal.h, include/linux/rcuwait.h, include/linux/percpu-rwsem.h, ...):
>> include/linux/cred.h:182:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] __rcu *cred @@
   include/linux/cred.h:182:41: sparse:     expected struct cred const *old
   include/linux/cred.h:182:41: sparse:     got struct cred const [noderef] __rcu *cred
>> include/linux/cred.h:182:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] __rcu *cred @@
   include/linux/cred.h:182:41: sparse:     expected struct cred const *old
   include/linux/cred.h:182:41: sparse:     got struct cred const [noderef] __rcu *cred
>> include/linux/cred.h:182:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] __rcu *cred @@
   include/linux/cred.h:182:41: sparse:     expected struct cred const *old
   include/linux/cred.h:182:41: sparse:     got struct cred const [noderef] __rcu *cred
>> include/linux/cred.h:182:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] __rcu *cred @@
   include/linux/cred.h:182:41: sparse:     expected struct cred const *old
   include/linux/cred.h:182:41: sparse:     got struct cred const [noderef] __rcu *cred
>> include/linux/cred.h:182:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] __rcu *cred @@
   include/linux/cred.h:182:41: sparse:     expected struct cred const *old
   include/linux/cred.h:182:41: sparse:     got struct cred const [noderef] __rcu *cred

vim +182 include/linux/cred.h

58319057b78476 Andy Lutomirski      2015-09-04  174  
dd60a254548056 Vinicius Costa Gomes 2024-04-02  175  /*
dd60a254548056 Vinicius Costa Gomes 2024-04-02  176   * Override creds without bumping reference count. Caller must ensure
dd60a254548056 Vinicius Costa Gomes 2024-04-02  177   * reference remains valid or has taken reference. Almost always not the
dd60a254548056 Vinicius Costa Gomes 2024-04-02  178   * interface you want. Use override_creds()/revert_creds() instead.
dd60a254548056 Vinicius Costa Gomes 2024-04-02  179   */
dd60a254548056 Vinicius Costa Gomes 2024-04-02  180  static inline const struct cred *override_creds_light(const struct cred *override_cred)
dd60a254548056 Vinicius Costa Gomes 2024-04-02  181  {
dd60a254548056 Vinicius Costa Gomes 2024-04-02 @182  	const struct cred *old = current->cred;
dd60a254548056 Vinicius Costa Gomes 2024-04-02  183  
dd60a254548056 Vinicius Costa Gomes 2024-04-02  184  	rcu_assign_pointer(current->cred, override_cred);
dd60a254548056 Vinicius Costa Gomes 2024-04-02  185  	return old;
dd60a254548056 Vinicius Costa Gomes 2024-04-02  186  }
dd60a254548056 Vinicius Costa Gomes 2024-04-02  187  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-20142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1D8CEBF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 23:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752E01F22532
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A04E85C65;
	Fri, 24 May 2024 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqQwe6oO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36A78C78;
	Fri, 24 May 2024 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587849; cv=none; b=ndh1dAm+0qsN9tfJb38gzO89t7c0BFFq7mNFGODaZ2b6BRlPD/xDYBm9/zmbZFuM1Eo20uy4T8c4/1ph5MidsFlpVZrwRaL1x9MLSMnjsxhGSx01NKT3Hxmo+Uf5wHvtAVQUI3V19G2Y7KNcWGrF8eFM/Hxbz1TWHjmII14l0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587849; c=relaxed/simple;
	bh=zevuABG5iL7ZenQ6zpwcJu0RCL7KnwzT9M9hFHiu0Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT0ri0+5n3MKTD6Z7tNv+Ynki3gVBIBMYZ56NI+SoBBuy08VOamV1j2GY3bR0ZPxmCzUGGsjpMwTg61b74wQt4YBixC6icYKQWF96bbaDRNPUY5BpM4Dmy7CUiYK/iKP6jvJJ5MI2I9yrq6n6SvqfyGNYOP6DxXg8e0Htm9McYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqQwe6oO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716587847; x=1748123847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zevuABG5iL7ZenQ6zpwcJu0RCL7KnwzT9M9hFHiu0Ww=;
  b=QqQwe6oOsYNuw1RYXj/lMjiPzfZYCxFCF3S02bcfiSt5XMcRB9jxNsdu
   2IvTxl5EM972VG6tXhDcra0oB7I/nnzrhyu6Htv2TsVSsotF2H49UnW6k
   9fC3sBcwHlMqIeTbaReeYfbQtczFcBjJe5Yueys2cO6TfjgvkrXbDmOTz
   B26Wj57k8ird+nci8wn2delHFoAz9CtqIHNI79v7zUJf4QSfueoBBe3Zj
   VXMGSNPRb9Vmtb+vODC0HpEm8iTNvf7a3gcxF7L0j5/05GHVxcaa55sRV
   577voSK8XqHevuQkE2+l7f/x2zbIwP3pM9hqM1XtbW96PKpuZtF2OoQvY
   A==;
X-CSE-ConnectionGUID: 57hvSddpR3OgxCvV4QQ+YQ==
X-CSE-MsgGUID: QSzYmkvpRYeUNuVvRNbk7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="13208146"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="13208146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 14:57:26 -0700
X-CSE-ConnectionGUID: zTjUPtnFSEyRutSyi8ep5Q==
X-CSE-MsgGUID: 8SXzsfxxSwKuPbQd5ZWk8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="64956874"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 24 May 2024 14:57:23 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAcue-0005wp-27;
	Fri, 24 May 2024 21:57:20 +0000
Date: Sat, 25 May 2024 05:56:41 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com,
	ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com,
	jorgelo@chromium.org, Adrian Ratiu <adrian.ratiu@collabora.com>,
	Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 1/2] proc: pass file instead of inode to proc_mem_open
Message-ID: <202405250507.0z0WHg9L-lkp@intel.com>
References: <20240524192858.3206-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524192858.3206-1-adrian.ratiu@collabora.com>

Hi Adrian,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on kees/for-next/kspp linus/master v6.9 next-20240523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Ratiu/proc-restrict-proc-pid-mem/20240525-033201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20240524192858.3206-1-adrian.ratiu%40collabora.com
patch subject: [PATCH v4 1/2] proc: pass file instead of inode to proc_mem_open
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20240525/202405250507.0z0WHg9L-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240525/202405250507.0z0WHg9L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405250507.0z0WHg9L-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/proc/task_nommu.c: In function 'maps_open':
>> fs/proc/task_nommu.c:262:34: error: passing argument 1 of 'proc_mem_open' from incompatible pointer type [-Werror=incompatible-pointer-types]
     262 |         priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
         |                                  ^~~~~
         |                                  |
         |                                  struct inode *
   In file included from fs/proc/task_nommu.c:13:
   fs/proc/internal.h:298:46: note: expected 'struct file *' but argument is of type 'struct inode *'
     298 | struct mm_struct *proc_mem_open(struct file *file, unsigned int mode);
         |                                 ~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/proc_mem_open +262 fs/proc/task_nommu.c

b76437579d1344 Siddhesh Poyarekar 2012-03-21  251  
b76437579d1344 Siddhesh Poyarekar 2012-03-21  252  static int maps_open(struct inode *inode, struct file *file,
b76437579d1344 Siddhesh Poyarekar 2012-03-21  253  		     const struct seq_operations *ops)
662795deb854b3 Eric W. Biederman  2006-06-26  254  {
dbf8685c8e2140 David Howells      2006-09-27  255  	struct proc_maps_private *priv;
dbf8685c8e2140 David Howells      2006-09-27  256  
27692cd56e2aa6 Oleg Nesterov      2014-10-09  257  	priv = __seq_open_private(file, ops, sizeof(*priv));
ce34fddb5bafb4 Oleg Nesterov      2014-10-09  258  	if (!priv)
ce34fddb5bafb4 Oleg Nesterov      2014-10-09  259  		return -ENOMEM;
ce34fddb5bafb4 Oleg Nesterov      2014-10-09  260  
2c03376d2db005 Oleg Nesterov      2014-10-09  261  	priv->inode = inode;
27692cd56e2aa6 Oleg Nesterov      2014-10-09 @262  	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
27692cd56e2aa6 Oleg Nesterov      2014-10-09  263  	if (IS_ERR(priv->mm)) {
27692cd56e2aa6 Oleg Nesterov      2014-10-09  264  		int err = PTR_ERR(priv->mm);
27692cd56e2aa6 Oleg Nesterov      2014-10-09  265  
27692cd56e2aa6 Oleg Nesterov      2014-10-09  266  		seq_release_private(inode, file);
27692cd56e2aa6 Oleg Nesterov      2014-10-09  267  		return err;
27692cd56e2aa6 Oleg Nesterov      2014-10-09  268  	}
27692cd56e2aa6 Oleg Nesterov      2014-10-09  269  
ce34fddb5bafb4 Oleg Nesterov      2014-10-09  270  	return 0;
662795deb854b3 Eric W. Biederman  2006-06-26  271  }
662795deb854b3 Eric W. Biederman  2006-06-26  272  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-20138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840448CEBA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 23:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC3A281DC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544D8529E;
	Fri, 24 May 2024 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGsQVoaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF643C47C;
	Fri, 24 May 2024 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584777; cv=none; b=ig1O0U7fMj/CICqAaFAotSYIyz8crm2fu+UQpwpzLKybxgUiv3hWE7DrxhY5/zI0wmmWI4bizc+cdcI+YIjLFaNSNoMY5d8DheI8/Rhj4tEiecTvaAkSGNpr0fBFe2ztprviDwuXHSxKfe/ruJZGLINqBtJ1Vp+ii7KaLKTIoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584777; c=relaxed/simple;
	bh=i2FYvQ/BuCKRsKhUyvuotfGtwF1qiSXoUMR8uyOnvAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHg5Nc78JUPZDfw9VeG8CBzoHpmn0GCfqkl2j84wybuMwqE3UKktyeiL3HmwrHKuUk9xYs2xgv/dO87kzjkt9gnjPzxIA4cQIqKYAoOwkpzuUj4KgYa0c4iKkJwp+uX3hV0MblMNqbu9QE+6qeXhpOTWtZSFOXCoaaOrdX19RT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGsQVoaz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716584775; x=1748120775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i2FYvQ/BuCKRsKhUyvuotfGtwF1qiSXoUMR8uyOnvAg=;
  b=mGsQVoazfreoJ4VR+jVsWh/U0L5a0weCmoOf0jNA4VmQ6mj7tGiDckFV
   wYOC8SZSBmHFSXbp9zu3xznKZK7P91ntdMXeFdXm45dh4wyA4JoB/iqqc
   N5U+JUblgIcAZbnp6NG1DNBIXNc/p/9Bb05KthJQHjizCtQ3lxiMNSnZv
   X+SlyozcuJcSTzm44/6Rfs/vbI8FwtzyifS023UFnhjMBQwcR/BlKKbP4
   64BpmiP/ZdEd3bAEF3D6fKdMryf6rjC6vGK3PBdrKYZIAU4j/+vnvqEJE
   kHOnSE5FzUZ1hYZ6jo6YrF8UTBZJGDtJHjic+DIzty0v4CYen4szU2nvP
   w==;
X-CSE-ConnectionGUID: RwRlITcQTgWntLv1y3flew==
X-CSE-MsgGUID: Y44mRza0TOKNicZIZ37Ezg==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="23546283"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="23546283"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 14:06:14 -0700
X-CSE-ConnectionGUID: dg0+kzl/TTiFuWKJa05m+Q==
X-CSE-MsgGUID: bBCnSzmmQreu0Xqb9a7bkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="34112530"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 24 May 2024 14:06:10 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAc6x-0005ul-1D;
	Fri, 24 May 2024 21:06:00 +0000
Date: Sat, 25 May 2024 05:05:28 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com,
	inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 1/2] proc: pass file instead of inode to proc_mem_open
Message-ID: <202405250413.EENbErWw-lkp@intel.com>
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
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240525/202405250413.EENbErWw-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7aa382fd7257d9bd4f7fc50bb7078a3c26a1628c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240525/202405250413.EENbErWw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405250413.EENbErWw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/proc/task_nommu.c:3:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/proc/task_nommu.c:262:27: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct file *' [-Werror,-Wincompatible-pointer-types]
     262 |         priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
         |                                  ^~~~~
   fs/proc/internal.h:298:46: note: passing argument to parameter 'file' here
     298 | struct mm_struct *proc_mem_open(struct file *file, unsigned int mode);
         |                                              ^
   1 warning and 1 error generated.


vim +262 fs/proc/task_nommu.c

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


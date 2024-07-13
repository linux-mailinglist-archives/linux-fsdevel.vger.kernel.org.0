Return-Path: <linux-fsdevel+bounces-23632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2DB9303C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 07:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D54283C92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 05:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B5C1B969;
	Sat, 13 Jul 2024 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnslRWrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD01BE46;
	Sat, 13 Jul 2024 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720848612; cv=none; b=BTCTQ8mJd8CpBZIliS4yQJEbQdY0EJydFC3fkPqVUQrWftX1QaGHlX6H07ab1u58ugWlgdClV7QywUcBv/tYsPND8cVP+FinfktAQPFXOTxlVhYDVOO8OOeE7QZKaojBkj8BV85LsNQbqfycZyrR27DlDHeF8onWNmZmyP2zHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720848612; c=relaxed/simple;
	bh=jmwJ71WEXluaTqG3XovhPZ2kzJJLnXc/RYX99R4FzDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOiPnZ9hG6/G+QB3+PdvpXW7398B9yWP+yHPB7zZJ2b9nom82bZ5ibsGpX6LCw3DfIjf/P1fY4OE3rry/5soWWFN+VTew7INaFQPclw9lOChgirbGLb+A/dnyLmzeuGBzvJeYuIftq7Nd6kv95O9+kMIbrBbTeexuyHg0zVN7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnslRWrf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720848611; x=1752384611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jmwJ71WEXluaTqG3XovhPZ2kzJJLnXc/RYX99R4FzDw=;
  b=EnslRWrfn5YhCHYI6uYwJDzaSkJntFLdl1wt5Je7iKOLDmzKG7AHicXr
   ZHVWlNICh1RppmA3Dvk7plXpVmGnD7c7ml+mh/vZn7sMS9wGFcfV3E5N7
   6uXUM+jOSzkmFlYVuWkqXqF4xr2c0BCLHvM7h5XUK+/ky/IP66nTsncIw
   4XXoI9Q8sEfoA+nN9alLrsiUpLOEZQO2JWeYmQ5p/EvhuJksb8kSXpimt
   RjGtG9U2ntu1PFtO1t6CgcLjwPMcQCLcTWpa7NXqV3NkueSjcNCDuiyM6
   jYaG5XQ7RlrW/PSmqUxKDGN1XX1SnR6I42Oz2Qzfn53MbZvMDNeyJxbnG
   A==;
X-CSE-ConnectionGUID: l5FO5h2rQkmSOAvDkrxnqA==
X-CSE-MsgGUID: br9Kg1riTX+SP6Js5qlqKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="28894537"
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="28894537"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 22:30:10 -0700
X-CSE-ConnectionGUID: UePz+lSnTgGDV7cxYxkupQ==
X-CSE-MsgGUID: m0al2iJcRAGaAvPo10n2CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="48846570"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 12 Jul 2024 22:30:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSVKc-000bjX-1U;
	Sat, 13 Jul 2024 05:30:02 +0000
Date: Sat, 13 Jul 2024 13:29:28 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Kisel <romank@linux.microsoft.com>, akpm@linux-foundation.org,
	apais@linux.microsoft.com, ardb@kernel.org, bigeasy@linutronix.de,
	brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz,
	keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nagvijay@microsoft.com, oleg@redhat.com, tandersen@netflix.com,
	vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v2 1/1] binfmt_elf, coredump: Log the reason of the
 failed core dumps
Message-ID: <202407131345.6cPoXZGa-lkp@intel.com>
References: <20240712215223.605363-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712215223.605363-2-romank@linux.microsoft.com>

Hi Roman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 831bcbcead6668ebf20b64fdb27518f1362ace3a]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kisel/binfmt_elf-coredump-Log-the-reason-of-the-failed-core-dumps/20240713-055749
base:   831bcbcead6668ebf20b64fdb27518f1362ace3a
patch link:    https://lore.kernel.org/r/20240712215223.605363-2-romank%40linux.microsoft.com
patch subject: [PATCH v2 1/1] binfmt_elf, coredump: Log the reason of the failed core dumps
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240713/202407131345.6cPoXZGa-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407131345.6cPoXZGa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407131345.6cPoXZGa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/coredump.c:6:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/coredump.c:875:34: warning: format specifies type 'long' but the argument has type 'ssize_t' (aka 'int') [-Wformat]
     874 |                         pr_err_ratelimited("Core dump of %s(PID %d) failed when writing out, error %ld\n",
         |                                                                                                    ~~~
         |                                                                                                    %zd
     875 |                                 current->comm, current->pid, n);
         |                                                              ^
   include/linux/printk.h:672:45: note: expanded from macro 'pr_err_ratelimited'
     672 |         printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                            ~~~     ^~~~~~~~~~~
   include/linux/printk.h:658:17: note: expanded from macro 'printk_ratelimited'
     658 |                 printk(fmt, ##__VA_ARGS__);                             \
         |                        ~~~    ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
     464 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   fs/coredump.c:878:34: warning: format specifies type 'long' but the argument has type 'ssize_t' (aka 'int') [-Wformat]
     877 |                         pr_err_ratelimited("Core dump of %s(PID %d) partially written out, only %ld(of %d) bytes written\n",
         |                                                                                                 ~~~
         |                                                                                                 %zd
     878 |                                 current->comm, current->pid, n, nr);
         |                                                              ^
   include/linux/printk.h:672:45: note: expanded from macro 'pr_err_ratelimited'
     672 |         printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                            ~~~     ^~~~~~~~~~~
   include/linux/printk.h:658:17: note: expanded from macro 'printk_ratelimited'
     658 |                 printk(fmt, ##__VA_ARGS__);                             \
         |                        ~~~    ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
     464 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   3 warnings generated.


vim +875 fs/coredump.c

   854	
   855	/*
   856	 * Core dumping helper functions.  These are the only things you should
   857	 * do on a core-file: use only these functions to write out all the
   858	 * necessary info.
   859	 */
   860	static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
   861	{
   862		struct file *file = cprm->file;
   863		loff_t pos = file->f_pos;
   864		ssize_t n;
   865		if (cprm->written + nr > cprm->limit)
   866			return 0;
   867	
   868	
   869		if (dump_interrupted())
   870			return 0;
   871		n = __kernel_write(file, addr, nr, &pos);
   872		if (n != nr) {
   873			if (n < 0)
   874				pr_err_ratelimited("Core dump of %s(PID %d) failed when writing out, error %ld\n",
 > 875					current->comm, current->pid, n);
   876			else
   877				pr_err_ratelimited("Core dump of %s(PID %d) partially written out, only %ld(of %d) bytes written\n",
   878					current->comm, current->pid, n, nr);
   879	
   880			return 0;
   881		}
   882		file->f_pos = pos;
   883		cprm->written += n;
   884		cprm->pos += n;
   885	
   886		return 1;
   887	}
   888	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


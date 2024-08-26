Return-Path: <linux-fsdevel+bounces-27134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7A295EE40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E392C1F22B50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106301547E7;
	Mon, 26 Aug 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZXu2l/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD6146D5A;
	Mon, 26 Aug 2024 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667241; cv=none; b=q3KAzgYk7/ssC/OkYKfOz3RrxWtRsVP5gVmW56zvuivpNo9uyAT0rbBGGHQVaKo7zR2xWku4h2cf/ts3urwsza+5fv938Pejx14qq6bm+nEtexN8ItqGqlpbHShTcSGfVMg+gqw4EbTWEn9aq98DD+cGlEe95mArUF+mdw9Ah9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667241; c=relaxed/simple;
	bh=3OMh0I6YDGa+H54lyN0aZeKV/jasJN3FKzzG5FqwCZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKAR5Ih128LkGsnk5Sha8UaPgdC6ulFc4l6Qn8JxgFbXOvoz1KBMNNZczBSE/uq59Yx1wXOplIURVfz8g8TM43YQJdchM3kNeYhPS/ejBi69uh9BXPReA8BEM6ojlgpB2HyZNuNVgGGyqcIsOAi/dDK6kxaf6+uafmYH33bQzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZXu2l/y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724667239; x=1756203239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3OMh0I6YDGa+H54lyN0aZeKV/jasJN3FKzzG5FqwCZc=;
  b=fZXu2l/y3+EUsVjdUXllCwg319KvR9Jn3KbszwHRinQTIhzAHJyIlEgI
   YgIbvlxiqitTpovCoWt918fXmuuaSQHy1e76PABagoztuMWfGodr+2G1m
   n7ZhiNnHGISIuz26zWvIXx1r2CGqHpIUtjt2Pdy6UYVIZDjkqeMjS3XvK
   juvRMroOIZ46FPEzMqzx32I45f+YDtb/W3U9qCr+6RCjinXKgnfdemxFb
   b+6tmFrAmEIPdsoyb5W6vGGGne89BE8WOiQh9spMzU1dJN0P7bCqfGBmg
   T0gqTT61uCAj1kt5garcXXD5Vb78o3RHVUHA2rnID/22rwHILPaM8GUSh
   Q==;
X-CSE-ConnectionGUID: hikeqfFQQAy4Xzi7HpN7hg==
X-CSE-MsgGUID: LMuIbSs4SimboBXhJfMtOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23257018"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23257018"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:13:58 -0700
X-CSE-ConnectionGUID: j2hGswy3Tqa//Z8Y2y8Osg==
X-CSE-MsgGUID: FKbHAQ2HT1Woa5mT7v3qTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62437513"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 26 Aug 2024 03:13:53 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siWjO-000GsF-2m;
	Mon, 26 Aug 2024 10:13:50 +0000
Date: Mon, 26 Aug 2024 18:13:45 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 07/17] mm: Define VM_DROPPABLE for powerpc/32
Message-ID: <202408261734.UAvnH7Mv-lkp@intel.com>
References: <315e3a268b165b6edad7dcb723b0d8a506a56c4e.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315e3a268b165b6edad7dcb723b0d8a506a56c4e.1724309198.git.christophe.leroy@csgroup.eu>

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes shuah-kselftest/next shuah-kselftest/fixes linus/master v6.11-rc5 next-20240823]
[cannot apply to crng-random/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/asm-generic-unaligned-h-Extract-common-header-for-vDSO/20240826-103525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/315e3a268b165b6edad7dcb723b0d8a506a56c4e.1724309198.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH v2 07/17] mm: Define VM_DROPPABLE for powerpc/32
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240826/202408261734.UAvnH7Mv-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261734.UAvnH7Mv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408261734.UAvnH7Mv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/debug_page_ref.c:6:
   In file included from include/trace/events/page_ref.h:11:
   include/trace/events/mmflags.h:168:5: warning: 'VM_DROPPABLE' is not defined, evaluates to 0 [-Wundef]
     168 | #if VM_DROPPABLE != VM_NONE
         |     ^
   include/trace/events/mmflags.h:168:21: warning: 'VM_NONE' is not defined, evaluates to 0 [-Wundef]
     168 | #if VM_DROPPABLE != VM_NONE
         |                     ^
   In file included from mm/debug_page_ref.c:6:
   In file included from include/trace/events/page_ref.h:135:
   In file included from include/trace/define_trace.h:95:
   In file included from include/trace/events/page_ref.h:11:
   include/trace/events/mmflags.h:168:5: warning: 'VM_DROPPABLE' is not defined, evaluates to 0 [-Wundef]
     168 | #if VM_DROPPABLE != VM_NONE
         |     ^
   include/trace/events/mmflags.h:168:21: warning: 'VM_NONE' is not defined, evaluates to 0 [-Wundef]
     168 | #if VM_DROPPABLE != VM_NONE
         |                     ^
   In file included from mm/debug_page_ref.c:6:
   In file included from include/trace/events/page_ref.h:135:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:94:
   In file included from include/trace/events/page_ref.h:11:
>> include/trace/events/mmflags.h:169:10: warning: 'IF_HAVE_VM_DROPPABLE' macro redefined [-Wmacro-redefined]
     169 | # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
         |          ^
   include/trace/events/mmflags.h:171:10: note: previous definition is here
     171 | # define IF_HAVE_VM_DROPPABLE(flag, name)
         |          ^
   5 warnings generated.


vim +/IF_HAVE_VM_DROPPABLE +169 include/trace/events/mmflags.h

7677f7fd8be766 Axel Rasmussen     2021-05-04  167  
41e2c674b334ed Christophe Leroy   2024-08-22 @168  #if VM_DROPPABLE != VM_NONE
9651fcedf7b92d Jason A. Donenfeld 2022-12-08 @169  # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
9651fcedf7b92d Jason A. Donenfeld 2022-12-08  170  #else
9651fcedf7b92d Jason A. Donenfeld 2022-12-08  171  # define IF_HAVE_VM_DROPPABLE(flag, name)
9651fcedf7b92d Jason A. Donenfeld 2022-12-08  172  #endif
9651fcedf7b92d Jason A. Donenfeld 2022-12-08  173  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


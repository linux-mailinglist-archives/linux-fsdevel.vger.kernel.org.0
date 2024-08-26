Return-Path: <linux-fsdevel+bounces-27251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8FF95FBC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524F51C21EB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363519B3F9;
	Mon, 26 Aug 2024 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BupbacOo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5019992B;
	Mon, 26 Aug 2024 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708079; cv=none; b=fSqxKXsu7cKZmeLXjqz7W+FWu9tCQaNcz3XSq+RsWQluXgdWKR/rFEvd2oPd1kAfBuooEi6Orhtjb0xYuE3lfH+sgo8H6J0nl8OjjF/SxaOvSHslRoCVq+BjdPaJTNCE34YjUoZ/f67qLm0grPoemT4tovOAKWTJZBR5TE7bfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708079; c=relaxed/simple;
	bh=f6QVJ7gqPlOJSdYw6NwfRnwjtN71dpr2Yeva23qqdXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/a6nafIQwPPn/AQ6kGN+n3jyuZBcIlbkAT5S5Ue7wSk8KrLhDIpqMRtYOEyVxAv/HkCH6tLhT4vbTJqPaJm4z0vv2NJwfkJ+jptXBY18sTMiRKlzodxU8Fg8nrHTiKYJHQk9teKdmcRXcgjGKKySB5if2cFkpdW5BSEY6kLKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BupbacOo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724708077; x=1756244077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6QVJ7gqPlOJSdYw6NwfRnwjtN71dpr2Yeva23qqdXQ=;
  b=BupbacOoMmqT3KnKPl/JPcq4K8Brb5EleBhUTGjrfkGTsbNNqj4GHreD
   hj3iV1Ynrqa2eesLEt49BjRHuKGiAYNIegbw5HjHR+E9cAqL0ihI8ombR
   Z2UG576G176oSWVlyY+1Tdd9ad16Rvd29JkDhd7lEdobgcc8sCGRod+tj
   LBPdro3r/y1b7Re+VDvMW8abOZDhLOeoiRI8HIE3++Otr/YzkxDsWvLME
   gXpcwXjWh72mcydxGvG3C+bz1Dz0o8C/qhRV81lnmnnXLfUxsC3YjHZ6g
   bzD+5KPv2FDwIDTtdU2PxHS6+JaE6nFI5qum9rbDG8KHG8VLz9Z5uZpHx
   Q==;
X-CSE-ConnectionGUID: FqqkaVnbQvqq0cJAkJwvbg==
X-CSE-MsgGUID: DDdZtAKsRmGoI1w2JYxCxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23025216"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23025216"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 14:34:36 -0700
X-CSE-ConnectionGUID: eZLAVeVBSbC/mqEo8Mbbug==
X-CSE-MsgGUID: QnvKqTknQ4GeCeBOqGKUpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66801034"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Aug 2024 14:34:30 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sihM4-000Hcg-1d;
	Mon, 26 Aug 2024 21:34:28 +0000
Date: Tue, 27 Aug 2024 05:34:16 +0800
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
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 07/17] mm: Define VM_DROPPABLE for powerpc/32
Message-ID: <202408270553.2S5d14Ar-lkp@intel.com>
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
[also build test WARNING on powerpc/fixes shuah-kselftest/next shuah-kselftest/fixes linus/master v6.11-rc5 next-20240826]
[cannot apply to crng-random/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/asm-generic-unaligned-h-Extract-common-header-for-vDSO/20240826-103525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/315e3a268b165b6edad7dcb723b0d8a506a56c4e.1724309198.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH v2 07/17] mm: Define VM_DROPPABLE for powerpc/32
config: um-randconfig-r122-20240826 (https://download.01.org/0day-ci/archive/20240827/202408270553.2S5d14Ar-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270553.2S5d14Ar-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270553.2S5d14Ar-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   mm/debug_page_ref.c: note: in included file (through include/trace/events/page_ref.h):
>> include/trace/events/mmflags.h:168:5: sparse: sparse: undefined preprocessor identifier 'VM_DROPPABLE'
>> include/trace/events/mmflags.h:168:21: sparse: sparse: undefined preprocessor identifier 'VM_NONE'
   mm/debug_page_ref.c: note: in included file (through include/trace/events/page_ref.h, include/trace/define_trace.h, include/trace/events/page_ref.h):
>> include/trace/events/mmflags.h:168:5: sparse: sparse: undefined preprocessor identifier 'VM_DROPPABLE'
>> include/trace/events/mmflags.h:168:21: sparse: sparse: undefined preprocessor identifier 'VM_NONE'
   mm/debug_page_ref.c: note: in included file (through include/trace/events/page_ref.h, include/trace/trace_events.h, include/trace/define_trace.h, ...):
   include/trace/events/mmflags.h:169:10: sparse: sparse: preprocessor token IF_HAVE_VM_DROPPABLE redefined
   mm/debug_page_ref.c: note: in included file (through include/trace/events/page_ref.h):
   include/trace/events/mmflags.h:171:10: sparse: this was the original definition

vim +/VM_DROPPABLE +168 include/trace/events/mmflags.h

   167	
 > 168	#if VM_DROPPABLE != VM_NONE
   169	# define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
   170	#else
   171	# define IF_HAVE_VM_DROPPABLE(flag, name)
   172	#endif
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


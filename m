Return-Path: <linux-fsdevel+bounces-26348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C73957F45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78001B226B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 07:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6791818990F;
	Tue, 20 Aug 2024 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQsk0Jih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822C181B9A;
	Tue, 20 Aug 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138429; cv=none; b=bWF77HE7BtHAdX/+fiaOlio/Xfocj57e/pr3wPNl78Rcs8rPQe8BkU3fYfKAdJVtM0sMmp08vs9RLeYNCH/Dojf9kFuv4D4gpPjk3fImv3MrI1RYM/IgahKxHvINn2gmB/KU/4yqEv52HJiW7yG4x/mwLmAZAHVOLkupjbpHfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138429; c=relaxed/simple;
	bh=SKFbGFSwJ55rWUmbm1hpW9JrvmpDPslIScuSlfAiMQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU7vgJwTnHkqme9k+KbSLji8Ufh70M/z3dUP7apvTspkWQp2Ge6SIBMPH+jCz//OGHSJ9MmW1ROgfu6jwem3B+lgayXLpJdDdcpu8I94sduxpLTGtYEhwGGv43PfA9Tmuu9gpsrzLBn81Wri7o2stAkmR0FI2OD4evvJ0ldRsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQsk0Jih; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724138428; x=1755674428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SKFbGFSwJ55rWUmbm1hpW9JrvmpDPslIScuSlfAiMQU=;
  b=gQsk0Jihhb/7QHr/fu8MzYyj2wtn0WIjMwWZMeiqFtHp8GCWStKPySgg
   rVcwv9VTev5/DtViNjDp2YuHiCD+r9EOf0VOmTwl2xx4HpnCbwkfUlxna
   uugxVJ+ehhZSvXXlJ4PaJSVPVYpTHq3cwKGkjne6heSJB1RxEW1RB3YQX
   M+z4XlUCjQtoDuK+6h0jnlX9nu+U5NOvZIUU5Egnb9BQM7531UmNl8uR+
   wuxN74WWGK54v5Rl5Ou6du91+VWTZwT5UBSudz/luDYPUfUuK9d2dKnGR
   L7bLidAkE3HcB10PkzKJ2SgVkb73YwvRVuH1o7ykXzRT88TZo6cRonrnc
   g==;
X-CSE-ConnectionGUID: 04Gf8w/dTU6YmMlMaHQXxw==
X-CSE-MsgGUID: gEEPg8hHQgmfu5dw1LLj2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="13106938"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="13106938"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:20:27 -0700
X-CSE-ConnectionGUID: OyIb2tPlTIeb0hT0TnPI+Q==
X-CSE-MsgGUID: Wiuvg/1ST0uhXBN1FEW5qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60682926"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Aug 2024 00:20:20 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgJAA-0009q2-1A;
	Tue, 20 Aug 2024 07:20:18 +0000
Date: Tue, 20 Aug 2024 15:19:39 +0800
From: kernel test robot <lkp@intel.com>
To: Matteo Croce <technoboy85@gmail.com>, bpf@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-input@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: use kfunc hooks instead of program types
Message-ID: <202408201510.KPb6hCTA-lkp@intel.com>
References: <20240820000245.61787-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820000245.61787-1-technoboy85@gmail.com>

Hi Matteo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Matteo-Croce/bpf-use-kfunc-hooks-instead-of-program-types/20240820-080354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240820000245.61787-1-technoboy85%40gmail.com
patch subject: [PATCH bpf-next] bpf: use kfunc hooks instead of program types
config: i386-buildonly-randconfig-001-20240820 (https://download.01.org/0day-ci/archive/20240820/202408201510.KPb6hCTA-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201510.KPb6hCTA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408201510.KPb6hCTA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/filter.c:12084:38: warning: unused variable 'bpf_kfunc_set_sock_addr' [-Wunused-const-variable]
    12084 | static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
          |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/bpf_kfunc_set_sock_addr +12084 net/core/filter.c

05421aecd4ed65 Joanne Koong  2023-03-01  12083  
53e380d2144190 Daan De Meyer 2023-10-11 @12084  static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
53e380d2144190 Daan De Meyer 2023-10-11  12085  	.owner = THIS_MODULE,
53e380d2144190 Daan De Meyer 2023-10-11  12086  	.set = &bpf_kfunc_check_set_sock_addr,
53e380d2144190 Daan De Meyer 2023-10-11  12087  };
53e380d2144190 Daan De Meyer 2023-10-11  12088  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


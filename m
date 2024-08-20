Return-Path: <linux-fsdevel+bounces-26345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29254957EDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 08:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41E41F23DF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5E616C685;
	Tue, 20 Aug 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eakh25fN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E312D766;
	Tue, 20 Aug 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137168; cv=none; b=ko9iwVA7yI6712kDX+Ay5XcPq4lAKRAWl65etpwjyvPXyUkob0ZhE+jAkjXeBYwVcPLiWpJ3l4uepC4nA6VMGUapq5KWLpnwRfERuUTXmvlzTABCCMZ24/HwvtMIz4mLtz3tjDnRjsndrlKIuh/xOZ4DPgFdn1t2JU1XXY0c5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137168; c=relaxed/simple;
	bh=ceJN4hD+c8q/5gVBSghMlvhoCIY5qZSVrjy/wQ0K38A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgzS+1AGKckHnCOgJRGK/fJD3GlzgVA/0hkfTCCAeQ2NbKOUVPRqHWOmpaQnOxz3Lm8tVVCbmu51aQilO+YVnG5KxeTTNkDwUw8PbdcNQ+szeCCkk31WLWpOZwK6qxG2ZHKD0FVXyf647B1sdpvoSsgD/omfu3dRoo0Q5lNV5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eakh25fN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137167; x=1755673167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ceJN4hD+c8q/5gVBSghMlvhoCIY5qZSVrjy/wQ0K38A=;
  b=eakh25fNL3qxlTKl3m0GwGk4C3+y3Pq6m4xNSTabiN9Ws4qKioB8Eji2
   mcTA+LjB4ABb4OuHPOuJhW3YDMT2TKjLN0J4wz1/P531Ny3YFNluoKbE0
   mzymNN8K/yVy/5m9B9H+aQBTwkffUpEAvc+JuyWgkCeIERlncpNbnTtc0
   hlZNEp4ZENDoSgNm6fH4sox4aEuzxsP3NkxAH385RfUxJoxs7uoRfR/ja
   nCHQYdm+zUqEXW/C+ydln4ETcyJrr2Q6RAfdbLJa5y8b2e0MxXlDs98KF
   agHvbKTayEzRtekGXOAZDuwnzScFQnRaFyDBonSCfbXB1ftA3mdBpIQNv
   w==;
X-CSE-ConnectionGUID: rhDTgsCXRZC7ONXXjFfjcQ==
X-CSE-MsgGUID: wBzbMC0GRKezluC0FKFxqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="21957374"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="21957374"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 23:59:26 -0700
X-CSE-ConnectionGUID: oO9t0kOESQqyYSjwloreQg==
X-CSE-MsgGUID: u/LflQ0JQVmTDom/q3Dv1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60675858"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 19 Aug 2024 23:59:19 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgIpp-0009os-2N;
	Tue, 20 Aug 2024 06:59:17 +0000
Date: Tue, 20 Aug 2024 14:58:43 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: use kfunc hooks instead of program types
Message-ID: <202408201433.eqBpp8z9-lkp@intel.com>
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
config: arc-randconfig-002-20240820 (https://download.01.org/0day-ci/archive/20240820/202408201433.eqBpp8z9-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201433.eqBpp8z9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408201433.eqBpp8z9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/filter.c:12084:38: warning: 'bpf_kfunc_set_sock_addr' defined but not used [-Wunused-const-variable=]
   12084 | static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~


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


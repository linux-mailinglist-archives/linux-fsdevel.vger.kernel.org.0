Return-Path: <linux-fsdevel+bounces-76492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFUwLFAPhWms7wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 22:44:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29774F7CD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 22:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAFB6302B525
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 21:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BBD332EB3;
	Thu,  5 Feb 2026 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNmKigJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF732BF23;
	Thu,  5 Feb 2026 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327814; cv=none; b=jTR2EKXDDVgjo+othby8FYXJ/mgHK2WYph3d6+85z/1e9N/kHkGflIf2jzkVXZye0UBA4CsFWlMyIri4CEwyOEf+0AuHUeC3bT1zBSiltJIVm/RirEIqSSVs8jFrd86u8XsN0OK1CrLk/xEFKfs3cciPkKomOhehH5PT3xAOPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327814; c=relaxed/simple;
	bh=47iYUzwhRATVtovzUuaC7RiQ590D0Xz/pYXWrUljWNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rziHefi/023/CdkFkMPWS/Nw+7xn1KKFa+IEAr0oy7vLqhBwhWfKvNwUiRupFxmg6FKztgPpeJW4XYgisjBJCIEtITMH8gi/P8BsAxikyrzmye/Mfy3KGhKczKyxT5a83s3TCM0YUWj047QoaXEH+cSUHhXvyWCBHxsVguwHB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNmKigJB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770327813; x=1801863813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=47iYUzwhRATVtovzUuaC7RiQ590D0Xz/pYXWrUljWNg=;
  b=GNmKigJBXWQKxAyTzCw+7VJRzJcTGsjPwJtrP2p3skgFfOROMWZ3if6S
   RxVGuyhBjtgNSnvQd+Sd3i4dO7sLqv5kLp9QPiKcAlw7Sq/s+9s6GapAq
   ginALImymar3pVc6t3xMZvOElE7bWyohdlNi1cSk3fMFL+nro8NXdkL3P
   TGayboonkms9dG06c6NeGw39KTyoII5s4Mnq38JB/RVy4CCtx1Gr5/eQj
   yq+we5FQLL4uWyPY/T4EMRzljzKMFFDmvzentY+aJVE2ZqHVl+afH97rx
   yOOxiz65TKnfdOS/OE64MxNmyiHJiL37yUiw6pm0nxLtBFyvF8/zPkq1T
   w==;
X-CSE-ConnectionGUID: xB73g1lvT9S+AsF4HQBQdQ==
X-CSE-MsgGUID: rVtOXohQQFm9WlHCxppVOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82906658"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82906658"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:43:32 -0800
X-CSE-ConnectionGUID: xbJwisGWRUS3YD0GgYyw5w==
X-CSE-MsgGUID: uRBDmptqSIaCVOaxrZB5QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="241237293"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2026 13:43:28 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo78I-000000004Ef-2u05;
	Thu, 05 Feb 2026 21:43:26 +0000
Date: Thu, 5 Feb 2026 22:43:00 +0100
From: kernel test robot <lkp@intel.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, ast@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
Message-ID: <202602052225.8AVOJuNQ-lkp@intel.com>
References: <20260205104541.171034-1-alexander@mihalicyn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205104541.171034-1-alexander@mihalicyn.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[lists.linux.dev,iogearbox.net,kernel.org,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io];
	TAGGED_FROM(0.00)[bounces-76492-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 29774F7CD6
X-Rspamd-Action: no action

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master brauner-vfs/vfs.all linus/master v6.16-rc1 next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Mikhalitsyn/bpf-use-FS_USERNS_DELEGATABLE-for-bpffs/20260205-184845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260205104541.171034-1-alexander%40mihalicyn.com
patch subject: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260205/202602052225.8AVOJuNQ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602052225.8AVOJuNQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602052225.8AVOJuNQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/inode.c:1084:14: error: use of undeclared identifier 'FS_USERNS_DELEGATABLE'; did you mean 'CFTYPE_NS_DELEGATABLE'?
    1084 |         .fs_flags       = FS_USERNS_DELEGATABLE,
         |                           ^~~~~~~~~~~~~~~~~~~~~
         |                           CFTYPE_NS_DELEGATABLE
   include/linux/cgroup-defs.h:137:2: note: 'CFTYPE_NS_DELEGATABLE' declared here
     137 |         CFTYPE_NS_DELEGATABLE   = (1 << 2),     /* writeable beyond delegation boundaries */
         |         ^
   1 error generated.


vim +1084 kernel/bpf/inode.c

  1077	
  1078	static struct file_system_type bpf_fs_type = {
  1079		.owner		= THIS_MODULE,
  1080		.name		= "bpf",
  1081		.init_fs_context = bpf_init_fs_context,
  1082		.parameters	= bpf_fs_parameters,
  1083		.kill_sb	= bpf_kill_super,
> 1084		.fs_flags	= FS_USERNS_DELEGATABLE,
  1085	};
  1086	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


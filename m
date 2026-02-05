Return-Path: <linux-fsdevel+bounces-76468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MTkC4nahGna5wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 18:59:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCA5F6419
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 18:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5820030078B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518E304BDE;
	Thu,  5 Feb 2026 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxKGDeJz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C577303CAA;
	Thu,  5 Feb 2026 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314370; cv=none; b=Zo0USpi/4c0wmdbvrD2gKzRFhrr/1oQ/pFASP/kH8OMhN0pe4+BisoBlq2pYWpYLBvis114qq1zNhmPw/QoV+h0ifniHunObAgbV773oSM2R/GpHyuAU9h3aNYqThXmfGC8Jh+OkytkSa6W8cUAx65dW2DhqbrBhP38E0iffBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314370; c=relaxed/simple;
	bh=QPnMGMiiqKGmwJXq9xUjekruFfRDSmqjNebQDbWjscg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9449ewNO3Iicd1sX+2+wkbw7MAfdrBSo8OuvzyWsBhZuxKvmPMaml8bED6dxT+BHA5E5FqtyNEMmgtiJWCqBbJLVG/8t2gWGVbNaFiuBlN0vAUpA/m2PE/a084Kr90tjkcM//jFDycqESONgJudynQOPAB8Gk40Tn62O+LlSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxKGDeJz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770314370; x=1801850370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPnMGMiiqKGmwJXq9xUjekruFfRDSmqjNebQDbWjscg=;
  b=DxKGDeJzHFWs8z1oBdM38Nw4cYlVyBYOQlmURJZ07uC7UcckyITyHs5D
   yW9rMkAZeMGyr8AyZv7RR6QWj9LJpZpHOPJgMnsRmBhlmReWNB1XpqGDu
   gWF1fTQDZGIm9xGNEDkgylHJyVEXiJD21OWGFDHo6SYTior7U4wOTT1lM
   yhQxl+AiKRXeuOYVjSzzG2wHxocQoty5qlzSkfq3bomofiMAudHdmb+4a
   La1m4PWOG+hc5Xbn984UvOQ3vI3q1vyvmMKYJBNYS3E9TzKywb+smih+X
   E+hyQnriTiK/dQZ97wZBcjq09t8QsJKs5D9PhdWQsy8SNqTxKR+cophtW
   Q==;
X-CSE-ConnectionGUID: xgWg5Dd8SC+UpaPAc9dvcg==
X-CSE-MsgGUID: gimbldOFRXG+T86jeSeFLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82957294"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82957294"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:59:29 -0800
X-CSE-ConnectionGUID: 1Qo+LnH2Rw2K6QGdWD9sPg==
X-CSE-MsgGUID: DNX37lliSDuSAIS8oirMcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="233552840"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 09:59:25 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo3dS-00000000k5A-16zC;
	Thu, 05 Feb 2026 17:59:22 +0000
Date: Fri, 6 Feb 2026 01:58:31 +0800
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
Message-ID: <202602060128.qfggT7Pd-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[lists.linux.dev,iogearbox.net,kernel.org,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io];
	TAGGED_FROM(0.00)[bounces-76468-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 0BCA5F6419
X-Rspamd-Action: no action

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master brauner-vfs/vfs.all linus/master v6.19-rc8 next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Mikhalitsyn/bpf-use-FS_USERNS_DELEGATABLE-for-bpffs/20260205-184845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260205104541.171034-1-alexander%40mihalicyn.com
patch subject: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
config: i386-buildonly-randconfig-002-20260205 (https://download.01.org/0day-ci/archive/20260206/202602060128.qfggT7Pd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602060128.qfggT7Pd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602060128.qfggT7Pd-lkp@intel.com/

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


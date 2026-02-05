Return-Path: <linux-fsdevel+bounces-76490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBZbEG0GhWlW7gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 22:06:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F5F7762
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 22:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EB20300D379
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 21:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A27330679;
	Thu,  5 Feb 2026 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgKBbatO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082033065B;
	Thu,  5 Feb 2026 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325593; cv=none; b=BF3M9Kv4uJhzmAPJPdzS7I90+M9dR5wj07G+cL2yHk0cqawGBAbXKkJ8mtVuEraACpL0O3gylhcn8oRLJLNEUvOkTt2UvUY9ITFVQBMOSUzKN6E8NbANwnSsXtix91R5zNA4cpoQhrIddefO1xpYhfxLKfMH3p1wJidMHm/I/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325593; c=relaxed/simple;
	bh=Z+Gp5uU+cXToQxMdneOWEY256y13sJwMpQre9qwnCdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMzTYhN6cpq6XvGA9D9OgjD/sSD8EadP8X41oHkiGoY0hqiooP3l3ExwHtT8KwqZE8t1HoyqHO96hlTZ/OCPE4E4Ngq7zmWrrqpNYC4s2ovxykz8X0VyQkRRgAUJWxOsjwiuPPLqd1WnOwiZ2QMBxZ96Yk71bMFuadYpVoKMtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgKBbatO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770325593; x=1801861593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+Gp5uU+cXToQxMdneOWEY256y13sJwMpQre9qwnCdE=;
  b=YgKBbatO9unBncjThfz6hD6z1FQyIrCbjBKLie1msmIvKRaicFqFRI1p
   y29xmW2zygHar0CVFgsyPA7LEQGrUhVd25CXBlTpjwPecEBkww2rJ5UnB
   sJLDT83NxfH5Xjd4Xc+eNxJf/qqY8GeyS8GuIpMpNdGXRRUQRMr8HuRTl
   89tKKVOq0zdgu0t+/3SCbGs7m36RnDqJg+2gu1iuQsaOVBfnZzCNVRmBW
   hL+YTpquo5XZM0qHhc5lEP8MuTwNiwji0zxOt8kBmIuiS3n+M/ErzxMQh
   TiGbRRLZikZ/+8ef7muF7gcKaTBEXhPLQCNsK2/PhPdm0gZxJs1VZnUjF
   g==;
X-CSE-ConnectionGUID: jHgphJidRSWpFLdVBA+JHA==
X-CSE-MsgGUID: gzQrVsNpRRSJiwBgUGDucw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="75384454"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="75384454"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:06:32 -0800
X-CSE-ConnectionGUID: 9xwoUwpIQv2z608plc28Yg==
X-CSE-MsgGUID: 5pcUzSvnQ/C/jFZUpEJpeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="233611783"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 13:06:29 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo6YU-000000004ET-20Oi;
	Thu, 05 Feb 2026 21:06:26 +0000
Date: Thu, 5 Feb 2026 22:06:00 +0100
From: kernel test robot <lkp@intel.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Daniel Borkmann <daniel@iogearbox.net>,
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
Message-ID: <202602052226.GPe8h4sA-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,iogearbox.net,kernel.org,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io];
	TAGGED_FROM(0.00)[bounces-76490-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: B62F5F7762
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
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260205/202602052226.GPe8h4sA-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602052226.GPe8h4sA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602052226.GPe8h4sA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/inode.c:1084:27: error: 'FS_USERNS_DELEGATABLE' undeclared here (not in a function); did you mean 'CFTYPE_NS_DELEGATABLE'?
    1084 |         .fs_flags       = FS_USERNS_DELEGATABLE,
         |                           ^~~~~~~~~~~~~~~~~~~~~
         |                           CFTYPE_NS_DELEGATABLE


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


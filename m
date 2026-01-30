Return-Path: <linux-fsdevel+bounces-75935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGEQEEBTfGmwLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 07:44:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DCB7AE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 07:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4BFD301C6F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 06:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3433890E;
	Fri, 30 Jan 2026 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMlp+gHT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E333120C;
	Fri, 30 Jan 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769755447; cv=none; b=IwEJgtwhKBHYrzZ8IaPys9D5rYYXH9vm51H2jDONDpJj9UkPY6K+A6j9AOz0/IzxoTPPW1Z+Js+00Mz8KgO+Nqp0D+blhFB6+bWxiRcc+Fe8pDu3H50Qc3uwXKWBJsjOq7KWnYyGz8oiu2gs1wQ73C4nbYu5mBDIyis2si38MKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769755447; c=relaxed/simple;
	bh=wrrzZRomTXxLMU8ISyp2Xzik5/V5pqCs87PE/IqGcVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE9go1fyLLGCYyk38IMVTiT3Jc6Bzr8a7ouyaSPJ+bImpXghii/6/dl6UP98cAQQsaPzFI9iv1Og6KKOKX36If2rM3rg9prvibMg+dqzTBRp/1c90i335sjUfg6Klx+/JVN4lPPf0HegAmJ9AKdwQ1EuZQRUsJKjFQh4SBwGIEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMlp+gHT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769755446; x=1801291446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wrrzZRomTXxLMU8ISyp2Xzik5/V5pqCs87PE/IqGcVQ=;
  b=eMlp+gHTBOqQpyMLKHUI3XV5F+CIxhjjRuLj4Ywh/7OFqqalNdrEYCaW
   ZGIse18yNQndMaGJSi4FUC857lq61rwu/WFlx2wb7ab1oLFNphqEJ+4gs
   MHodmpE47FeeH4/iAdBUukJnthtn7uarytNNVaS57zFzRG0VP9rHYtyfS
   R3oWPzC+orj2GK3D9gfC+7TFX/XM9+Huw5n/ruhGln5gUbctFWyx48ISg
   RWNwkf9vPTnJDnQo+xlsVgloHx7C88PuETKy8juuGBWs03JZdl1gvSxjF
   go2KhtbaRdO0GM0EuZvrJ5djyF9E54UDaGSOTUxiyVDwVytrRQdOOYyhg
   Q==;
X-CSE-ConnectionGUID: nM+pnKt2QYmzPQju7s1b/w==
X-CSE-MsgGUID: Lvme+ybDRuqnU5/FJX4e/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="88419703"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="88419703"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 22:44:06 -0800
X-CSE-ConnectionGUID: VjKh33a3StiQLpQQIfJUgA==
X-CSE-MsgGUID: F3LW/Y8jQ6Sz+7nhKq+F3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="213273923"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jan 2026 22:44:04 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vliEb-000000002Qz-28Tl;
	Fri, 30 Jan 2026 06:44:01 +0000
Date: Fri, 30 Jan 2026 07:43:08 +0100
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org, surenb@google.com, shakeel.butt@linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
Message-ID: <202601300733.c69u3XEU-lkp@intel.com>
References: <20260129215340.3742283-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129215340.3742283-1-andrii@kernel.org>
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75935-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: AC6DCB7AE1
X-Rspamd-Action: no action

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master]
[cannot apply to akpm-mm/mm-everything linus/master v6.16-rc1 next-20260129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/procfs-avoid-fetching-build-ID-while-holding-VMA-lock/20260130-055639
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260129215340.3742283-1-andrii%40kernel.org
patch subject: [PATCH v2 mm-stable] procfs: avoid fetching build ID while holding VMA lock
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260130/202601300733.c69u3XEU-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601300733.c69u3XEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601300733.c69u3XEU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: lib/buildid.c:348 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * Parse build ID of ELF file

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


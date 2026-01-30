Return-Path: <linux-fsdevel+bounces-75925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEuoDLwrfGkYLAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 04:55:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2DB6F24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 04:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 050B33006027
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 03:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A9320CAA;
	Fri, 30 Jan 2026 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHB8lySj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A7221FCD;
	Fri, 30 Jan 2026 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745333; cv=none; b=jbrBDI4uuiGDld1QyozaAvLMa86ld0bXyYMxBQp3XReAS2ECmOwIXm1c4a+VVroS6atX86bsp8U31vWFhGZyk5KxlKdg3RPBSwspYAp7K5tKnN2Pk/O8j1G+ashH+VIo0o2tA+eZVX6/AtP4gQsVrcNysbXNlfuJVMovsz/yd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745333; c=relaxed/simple;
	bh=lCApoAs780KvAuXMjci54Pk5bdt1ic49wr2Ha4ZQ0NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdTn3BBXqMMf5Drnns4f+Qt0uFwjAv+3xp3lo3w1SrKiE0RQ7G8nlaeSUlXCtesK6BD1y4KNNEXY1fCFdAQ7LhFhMl9Z6vsmkr+0SwixI2+Hi+furbn5jH7L5A/N+wAPxUyVtQHfPFf24mXWwjYPPBby/UCHYbCr5nME4qtH8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHB8lySj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769745331; x=1801281331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lCApoAs780KvAuXMjci54Pk5bdt1ic49wr2Ha4ZQ0NI=;
  b=EHB8lySjUio5eD44dwImH+w9gokm3QnJqaWpTRvjjwDLdyFU9OLes5ak
   ZiXHfWXClzp2kMdkyTf4fv2+f8EEwCo3h/8ndAdbqzdbGZ8rd2/YCcoqO
   zz2sfaiS7/I4Agka49sAfcnCVHgNO98XMOmTasjdLC59B21EK/ELxhvlE
   4QVsJInP6gTJg2A5N+3q2EBoWdyETTHLfwASwbNwEUHudV52S9UQSu5z+
   cLGEJk3Tv2eNJ6ASY2GnSaOAqV5Rkeh2pSbU5+qnGk1acgUQ8BHmDSRUS
   ekSZFbeUvO5uXZzCTZwGgAv8PlQkWul3sYqdhpI6JebdydNG06EbxMWQO
   Q==;
X-CSE-ConnectionGUID: YpWM/CK/Rmub9WvxGiE3AA==
X-CSE-MsgGUID: h2P3IDGQRNuwvPpWzwJ9iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="71048411"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="71048411"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 19:55:30 -0800
X-CSE-ConnectionGUID: 5JwofcPES8yhw6zqynO64Q==
X-CSE-MsgGUID: 9GWOSkM7TeqVnLGsYipAuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="240005118"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Jan 2026 19:55:28 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlfbR-00000000c96-3Iqw;
	Fri, 30 Jan 2026 03:55:25 +0000
Date: Fri, 30 Jan 2026 11:54:52 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org, surenb@google.com, shakeel.butt@linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
Message-ID: <202601301121.zr5U6ixA-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75925-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 7BA2DB6F24
X-Rspamd-Action: no action

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master linus/master v6.19-rc7]
[cannot apply to akpm-mm/mm-everything next-20260129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/procfs-avoid-fetching-build-ID-while-holding-VMA-lock/20260130-055639
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260129215340.3742283-1-andrii%40kernel.org
patch subject: [PATCH v2 mm-stable] procfs: avoid fetching build ID while holding VMA lock
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260130/202601301121.zr5U6ixA-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601301121.zr5U6ixA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601301121.zr5U6ixA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: lib/buildid.c:348 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * Parse build ID of ELF file

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


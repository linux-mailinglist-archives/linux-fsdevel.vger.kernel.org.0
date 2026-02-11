Return-Path: <linux-fsdevel+bounces-76924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO+OGgnpi2kcdAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:27:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1A120C78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA50301E953
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5C318ED7;
	Wed, 11 Feb 2026 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WD5x0vJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3730E835;
	Wed, 11 Feb 2026 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776831; cv=none; b=LXt/ySIA5kE1mf+igLf2EOJTrLYsXJd+rYPvXdCF9APrIBuQNFlmsz332OIXPa3touQ7gwKcoXxppAfHxmoMWESx629shl7O/8158lc6ZokdPRLmMWUn37TYAK0SaQpsYwCzg7a+d2TqMu2PSZrtaqmONLpc5f4cC6zEOfEj3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776831; c=relaxed/simple;
	bh=VizfXMgRo2x7m5BVGIEfIafHca9AtaxrlxlbbTdRmIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6hH5/kKIKwLKgN1C2E6/i8TDkylwtgcy/Ljt2FXg8Ib5CwODyu5C5k0ZkGCJkobFEx0s6PhTVmG11Gb9F/z09G+NSEDfLzagImHOiS1gr2aeFEqf3wBtcUFbWAKI8GMhePFnbbgpuk8WObbdd5NVfSREhZamzp9yCWqe7Yd7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WD5x0vJQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770776831; x=1802312831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VizfXMgRo2x7m5BVGIEfIafHca9AtaxrlxlbbTdRmIY=;
  b=WD5x0vJQgcAd8bx5PhzcAqz4yovk/c0LFbtlz/Xhe2hAR1Q5/bK9WetG
   ysOzWholnLd6FyW8Zjm2RlxGpbBXkIwRiDOLsSQbyXaRI6w6VwOoggFtp
   +KKJEP8z00eeEWwJ3I//SkZA4A9leyDcgYTy7wZ+SLCjTb7X2Kln733va
   59X1mmEd9pfT4TocK+viH4yBT2jV7rI4AP1bzDG6OSC0wNTEXi0V3cATA
   g94v2bG+8XYyPWuyw4XAtpNlmZQgadURZNQkv2rxq0VogHROQG8VNvXH2
   kua/FkDqbxfZXqnfrBSSJfDp9R0Ml2Fb5ZSwsoPyxXNTtbo2jzq6gR3rM
   w==;
X-CSE-ConnectionGUID: ABylNRcrQMWTzcnl0FIxag==
X-CSE-MsgGUID: Ci9Stw1CTZGMpq/S9JB1JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83020648"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="83020648"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 18:27:10 -0800
X-CSE-ConnectionGUID: zOjUMskXSMSSc4vXN1XptQ==
X-CSE-MsgGUID: hO9bm3NCQWyRxyKt+aYzcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="217052525"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Feb 2026 18:27:09 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpzwY-00000000pbA-3OTB;
	Wed, 11 Feb 2026 02:27:06 +0000
Date: Wed, 11 Feb 2026 10:26:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>, hirofumi@mail.parknet.co.jp
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
Message-ID: <202602111002.F4q2b5Gx-lkp@intel.com>
References: <20260210222310.357755-3-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210222310.357755-3-ethan.ferguson@zetier.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76924-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0B1A120C78
X-Rspamd-Action: no action

Hi Ethan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9f2693489ef8558240d9e80bfad103650daed0af]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/fat-Add-FS_IOC_GETFSLABEL-ioctl/20260211-062606
base:   9f2693489ef8558240d9e80bfad103650daed0af
patch link:    https://lore.kernel.org/r/20260210222310.357755-3-ethan.ferguson%40zetier.com
patch subject: [PATCH 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20260211/202602111002.F4q2b5Gx-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260211/202602111002.F4q2b5Gx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602111002.F4q2b5Gx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'fat_get_entry',
       inlined from 'fat_rename_volume_label_dentry' at fs/fat/dir.c:1435:7:
>> fs/fat/dir.c:121:12: warning: 'bh' is used uninitialized [-Wuninitialized]
     121 |         if (*bh && *de &&
         |            ^
   fs/fat/dir.c: In function 'fat_rename_volume_label_dentry':
   fs/fat/dir.c:1430:29: note: 'bh' was declared here
    1430 |         struct buffer_head *bh;
         |                             ^~


vim +/bh +121 fs/fat/dir.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  115  
^1da177e4c3f41 Linus Torvalds     2005-04-16  116  static inline int fat_get_entry(struct inode *dir, loff_t *pos,
^1da177e4c3f41 Linus Torvalds     2005-04-16  117  				struct buffer_head **bh,
^1da177e4c3f41 Linus Torvalds     2005-04-16  118  				struct msdos_dir_entry **de)
^1da177e4c3f41 Linus Torvalds     2005-04-16  119  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  120  	/* Fast stuff first */
^1da177e4c3f41 Linus Torvalds     2005-04-16 @121  	if (*bh && *de &&
f08b4988f229fb Cruz Julian Bishop 2012-10-04  122  	   (*de - (struct msdos_dir_entry *)(*bh)->b_data) <
f08b4988f229fb Cruz Julian Bishop 2012-10-04  123  				MSDOS_SB(dir->i_sb)->dir_per_block - 1) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  124  		*pos += sizeof(struct msdos_dir_entry);
^1da177e4c3f41 Linus Torvalds     2005-04-16  125  		(*de)++;
^1da177e4c3f41 Linus Torvalds     2005-04-16  126  		return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  127  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  128  	return fat__get_entry(dir, pos, bh, de);
^1da177e4c3f41 Linus Torvalds     2005-04-16  129  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  130  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


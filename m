Return-Path: <linux-fsdevel+bounces-77540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOXWHo5olWk/QgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:21:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D0C1539F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9E2F3031003
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B7430EF66;
	Wed, 18 Feb 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYL7IBq6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC730E0E9;
	Wed, 18 Feb 2026 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399302; cv=none; b=hjPjyq0oO3Ixg+IA+uaUnX50SKk9DqmyWFMQiAXvQsV6nPrzq+7URN0l3JrZcOUC5JgV36SaDHuLVByEa3rJPjwrITe7DBZvVvkm/PUXOQ6+z1GoTmIpFdzb8YnumF6kgErmBEW4sxO3C7cRyZ2e6ssoBGLn6HojQ/eCliqICBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399302; c=relaxed/simple;
	bh=4Li4B/SJ9Tx6T5Pps+a8yTbGBDQgw0+lzLC0NU4sPk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/2+zuq12iNhPtCvQtkL/8AR/PtJEWjm5r7yCnSghJsj2bjSTdGxw1GpYE/wzJP2ODrW0PlRF+EzqplbkW1fkiTKGCxmNUP0o0UPDlICWhKyEMHyV+mYQNEhKHh9p1z2U1t37U0vK8+LHZhPa6vmnHyKmy1E4PaRoegYrenbcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYL7IBq6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771399301; x=1802935301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Li4B/SJ9Tx6T5Pps+a8yTbGBDQgw0+lzLC0NU4sPk4=;
  b=jYL7IBq6BlxmWyQ9PSP16D1L3ztLez4SJc8rhmN3EhsdLg6uPwrOuSNs
   Nwv7JkjXdQIyNDhIn7KlxSq5X6in0zqqs2Aub5eJM7Ka75O1SPwsG27jP
   WKUJXxzsqR/ppollKfcdSJcET6r9rZAQCEb+cQSqyA3ZAtgOxWEA8Zvbv
   pO+oLdjD0q6Fx9PXnGc5KmYinyQ68WxyXxy7/GgDzsJJ1T4OZcQ19WB67
   crtGAaDNOcajy+HJgMTiOYJ/Fow3KarxywcR5E+M6PHaqndSKi0Z0eCwX
   xiT/UpJfxRgdHoLMQ9pnq7fbhqAWoEv+tkINJfsb37Zgpy57uM3Xu4AW7
   Q==;
X-CSE-ConnectionGUID: YFzWQFpxSnizlJohV+NZnA==
X-CSE-MsgGUID: o1W+Tu3ITjqJ1SZmIrrc9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72462803"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72462803"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 23:21:41 -0800
X-CSE-ConnectionGUID: Fa9oi4MiTLyLFpO3aqZ3uQ==
X-CSE-MsgGUID: F55gO+CmSK26lvp5rIBBvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="213363603"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Feb 2026 23:21:39 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsbsO-0000000129E-48lV;
	Wed, 18 Feb 2026 07:21:37 +0000
Date: Wed, 18 Feb 2026 15:21:00 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>, hirofumi@mail.parknet.co.jp
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
Message-ID: <202602181513.zGRm1yrD-lkp@intel.com>
References: <20260217230628.719475-3-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217230628.719475-3-ethan.ferguson@zetier.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77540-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 09D0C1539F5
X-Rspamd-Action: no action

Hi Ethan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9f2693489ef8558240d9e80bfad103650daed0af]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/fat-Add-FS_IOC_GETFSLABEL-ioctl/20260218-071019
base:   9f2693489ef8558240d9e80bfad103650daed0af
patch link:    https://lore.kernel.org/r/20260217230628.719475-3-ethan.ferguson%40zetier.com
patch subject: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
config: i386-randconfig-014-20260218 (https://download.01.org/0day-ci/archive/20260218/202602181513.zGRm1yrD-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602181513.zGRm1yrD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602181513.zGRm1yrD-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/fat/file.o: in function `fat_convert_volume_label_str':
   fs/fat/file.c:184:(.text+0x108): undefined reference to `msdos_format_name'
>> ld: fs/fat/file.c:193:(.text+0x12a): undefined reference to `msdos_format_name'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


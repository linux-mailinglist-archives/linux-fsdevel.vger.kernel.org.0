Return-Path: <linux-fsdevel+bounces-32784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AE49AE90A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230611C2151A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375951E2009;
	Thu, 24 Oct 2024 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I72LaHE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D07CF16;
	Thu, 24 Oct 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780741; cv=none; b=LUlsVUKG3TeaIjN2UfqwRoAC6Rj4w4yG+YGasX3CL8bKDoSSvyCZ7gCagxRbx8EYZPKFMVy4ZWsIrEoDvYvsRknfmJDWQNUnyFV31UW+gL4VQQQMr1tgKlP+apWYQDZoth2C/uld1QBvt2GhLQPbzQl727l3k+OFUiPlIwNfbeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780741; c=relaxed/simple;
	bh=UOhI2z8bUD1H8XPNqw8r8CcHu55ylmwLfgFW8p34T0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KymByZYlv7LBSaZFY2jSneRSPJgrpyTaOsmhDBPV3LUHatkfXNMfXrCSku1wld4EUamejGQkDD2D3dYTAYS5QamSOjNnWA4hpP0IMPvVonTggY/KkdxGfrodzn8QnFbaZPFrN1z09sC/oRaJGbPBLLIn5RqaYAT67g9TEm8JjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I72LaHE5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729780739; x=1761316739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UOhI2z8bUD1H8XPNqw8r8CcHu55ylmwLfgFW8p34T0Y=;
  b=I72LaHE5Hck4YlUahIAsnHep8nSKb2ndQuq/1qu8ZqBuBVAnVEQ08iuY
   dTQe0xgQXZhr4ScONEzf89ZoI0JzslpPAjqt9i9Li69e5rSaMeBvjKt+z
   xiQECOMdgYuyd/mzJXq53/QSJl4uv9BB49lMSxCwE5R3c2gM1pG4MrTNF
   lIO7UwmfDDvjdXNEQy5tcbb7KsCkTovMNstn5Ngl7ehaaiUozy56rpPEy
   6pOF9CgltheGbBcxxVXB9T7CAKrSSo++AbFljbNvsXjIUIxxyooCtRRmg
   Tc7/9Ldxdi6RieFWHOCk0rc2P/RQGXbyBdTrwaA+/GGotvDh4z2LCZHWH
   Q==;
X-CSE-ConnectionGUID: T2y0wQZoQNywe15RuUKS7g==
X-CSE-MsgGUID: F+nA6+WYTKGClZqfl4+liw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17042073"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="17042073"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 07:38:59 -0700
X-CSE-ConnectionGUID: /pt0RsxpSbiesuSAeUBIqw==
X-CSE-MsgGUID: GDg+ccIcQkytvgpjaSNG8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80191661"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 07:38:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3yzH-000WX4-23;
	Thu, 24 Oct 2024 14:38:55 +0000
Date: Thu, 24 Oct 2024 22:38:49 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: elide zero range flush from partial eof zeroing
Message-ID: <202410242220.ZfBg7XEr-lkp@intel.com>
References: <20241023143029.11275-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023143029.11275-1-bfoster@redhat.com>

Hi Brian,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Foster/iomap-elide-zero-range-flush-from-partial-eof-zeroing/20241023-223311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241023143029.11275-1-bfoster%40redhat.com
patch subject: [PATCH] iomap: elide zero range flush from partial eof zeroing
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20241024/202410242220.ZfBg7XEr-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410242220.ZfBg7XEr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410242220.ZfBg7XEr-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: fs/iomap/buffered-io.o: in function `iomap_zero_iter':
>> buffered-io.c:(.text+0x3f5c): undefined reference to `__moddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


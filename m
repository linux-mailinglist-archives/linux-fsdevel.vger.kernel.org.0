Return-Path: <linux-fsdevel+bounces-58075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A6EB28DBE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 14:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2541CC6952
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86E22E2DFD;
	Sat, 16 Aug 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEJQoFsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50881E47BA;
	Sat, 16 Aug 2025 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755347936; cv=none; b=McA5PaPoQPSYEVPfTA6mM2pUE5XycjslCc6jAdjEQxVwu2Kzrxr809K7U0JVu+pL7Rmz42Y2qOVmebz8sfD4CclZ7XxcjSl3cA8vpm+a/GXjLc75At8H1r7Yi+xyy1Y1nPgIW9pt5mr+niFMKiRiBQQdqXsxdKLixbQxQ7HehIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755347936; c=relaxed/simple;
	bh=9Ff9XpXiB0v1ne2KOkPiaqcFp1+8SqSRbJO7Ur2WlXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITWPFRB3GBFBGnEFNOH3lN816ECBrcb68Q7jQuoMiWkYl9NQ4bo6Am03YR4pM0E8A/rKndHgD0j0tkJyDeaZhrcQ2qURQ8Dc2iF004JEtyoBEifLsJ303TjHa4cWPckmjjizWPO+OScOva12tbvnUHoE5Nxum7FGopC0+uOMteg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEJQoFsg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755347934; x=1786883934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Ff9XpXiB0v1ne2KOkPiaqcFp1+8SqSRbJO7Ur2WlXo=;
  b=HEJQoFsggjhccBTQa+GG85VOKixp0M6J/9vmLS1CprXSexOtnas5jYke
   HIuzqky2grAeqqo0LE626wN4NHHtgH7hYMShGo2acGU6dgmGH4EF3181Z
   6QT8awX04vaIP+AEODYW/e/VxaQkBYeNv9VHyEaRkHhsIOZ3N3w1Hi2+i
   +7y3m9VU6+KBV18plpYn3G+AsOYTNBSKKcMsDpaR/2s18Nq3gbqiHHch+
   g6u9oVEpSqUdVzXBbOTn8PH08/EyOki3Kt15QeKPhfW2j2JmTTSaMEoW5
   3TzieTvbxOwt07B8W+jH/uMMuAwO96ox/p2sC5h8MACovjRWE8elvM5Lm
   A==;
X-CSE-ConnectionGUID: Duhv+9jPS9up4h9iFbmC5Q==
X-CSE-MsgGUID: s/QA/zKmSNydt3u1eZ/jyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57791381"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57791381"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 05:38:54 -0700
X-CSE-ConnectionGUID: tUtM56dmQgmETyjyvMS6iA==
X-CSE-MsgGUID: F2DpgUMHRCyHS+sAVqky4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166827334"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 16 Aug 2025 05:38:52 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unGBM-000Cs8-2m;
	Sat, 16 Aug 2025 12:38:49 +0000
Date: Sat, 16 Aug 2025 20:38:24 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>, linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: oe-kbuild-all@lists.linux.dev, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Message-ID: <202508162026.aFXpZAKm-lkp@intel.com>
References: <20250815171056.103751-2-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815171056.103751-2-ethan.ferguson@zetier.com>

Hi Ethan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 37816488247ddddbc3de113c78c83572274b1e2e]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/exfat-Add-support-for-FS_IOC_-GET-SET-FSLABEL/20250816-011428
base:   37816488247ddddbc3de113c78c83572274b1e2e
patch link:    https://lore.kernel.org/r/20250815171056.103751-2-ethan.ferguson%40zetier.com
patch subject: [PATCH 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
config: nios2-randconfig-r121-20250816 (https://download.01.org/0day-ci/archive/20250816/202508162026.aFXpZAKm-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250816/202508162026.aFXpZAKm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508162026.aFXpZAKm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/exfat/super.c:656:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const [usertype] *ucs1 @@     got restricted __le16 * @@
   fs/exfat/super.c:656:28: sparse:     expected unsigned short const [usertype] *ucs1
   fs/exfat/super.c:656:28: sparse:     got restricted __le16 *

vim +656 fs/exfat/super.c

   639	
   640	int exfat_write_volume_label(struct super_block *sb)
   641	{
   642		int ret;
   643		struct exfat_sb_info *sbi = EXFAT_SB(sb);
   644		struct buffer_head *bh;
   645		struct exfat_dentry *ep;
   646	
   647		ret = exfat_get_volume_label_ptrs(sb, &bh, &ep);
   648		if (ret < 0)
   649			goto cleanup;
   650	
   651		mutex_lock(&sbi->s_lock);
   652		memcpy(ep->dentry.volume_label.volume_label, sbi->volume_label,
   653					sizeof(sbi->volume_label));
   654	
   655		ep->dentry.volume_label.char_count =
 > 656			UniStrnlen(ep->dentry.volume_label.volume_label,
   657					EXFAT_VOLUME_LABEL_LEN);
   658		mutex_unlock(&sbi->s_lock);
   659	
   660	cleanup:
   661		if (bh) {
   662			exfat_update_bh(bh, true);
   663			brelse(bh);
   664		}
   665	
   666		return ret;
   667	}
   668	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


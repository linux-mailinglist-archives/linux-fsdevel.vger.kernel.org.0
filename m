Return-Path: <linux-fsdevel+bounces-52912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB9AE860B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EC61638FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215F265CBE;
	Wed, 25 Jun 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ow4JylV7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8B25BF0F;
	Wed, 25 Jun 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861085; cv=none; b=L5su9v8dPmjAirra4XOIlweKiuWl4j3K7TCDOnRl4dZo/EyDVUr1z0MCJgQ8uiLbYRdihBP4Y56WF1KjT6MNkQ3P9oeo++GQy1BybYpfUBiCVn9wAbsXnWEo3hZfK+g4wHFrp9Srur20sHMMpayHmMF26+tLtyHjIrmDIKcj13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861085; c=relaxed/simple;
	bh=M4G5XDxRuWGuM0Ue4i3Qt7POHiiyrCSIdxYPmlP+Yhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPthsI44xvMrx0J9ZfS/p4grIyC370lMOtmS5//SOgmTxbXcXRQCem3BDQTTKC5OAa6yN4e/rGL7owypkkD1Iefe1yK3Z5nciT4o+ymrbka/gAoyJCinbYZbKjUHMAwnhQ8X7xJ4YEOdBEV8vkfztpOGYJ9zyz76hka1/ukAC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ow4JylV7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750861084; x=1782397084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M4G5XDxRuWGuM0Ue4i3Qt7POHiiyrCSIdxYPmlP+Yhk=;
  b=Ow4JylV7E/MiEsVaJA4CZtIC/X3Kg6IjI49v+50CFJq4+WDhnzr5+Kpx
   u+Ktp0o6iNCRttnc+HwYSxaZ0ynmEsBT/F7nM86/Qk/IoMjnq7U0X03hM
   U+NlNhSNGq37YT5jAVJc+tFSnrJy6hTZuWdrANgJuLhvsODwbqm0zcYSk
   Wv3mokhHxcwvt3qbekvs72Rrc6WNWhXe/GiZ74WwcSpKlkjW/nk9hmmzF
   S34/XDAxoXsmZgRTprLVMxyDwifyCTV6BHHoRTu2OwnQsqSdYHnxjSCbI
   Ojd8TWKBFygK+J9sYHq8uUmIK988RP7twpDKyXHa9fcePnh3ERFxAnD9u
   A==;
X-CSE-ConnectionGUID: vT2SbaOHQZOATg9jOfYC7w==
X-CSE-MsgGUID: 0EQGdEoXQRKqBkYMBqDQXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53197826"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53197826"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 07:17:49 -0700
X-CSE-ConnectionGUID: kltvbGmNTs2VqFyO5g4Z5w==
X-CSE-MsgGUID: gGNfuW1XSeS7l+BDROKwjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151658653"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 25 Jun 2025 07:17:45 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUQwZ-000TB8-1Q;
	Wed, 25 Jun 2025 14:17:43 +0000
Date: Wed, 25 Jun 2025 22:17:42 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, djwong@kernel.org, anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v3 13/16] fuse: use iomap for writeback
Message-ID: <202506252117.9V3HTO0i-lkp@intel.com>
References: <20250624022135.832899-14-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-14-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on xfs-linux/for-next linus/master v6.16-rc3 next-20250625]
[cannot apply to gfs2/for-next mszeredi-fuse/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/iomap-pass-more-arguments-using-struct-iomap_writepage_ctx/20250624-102709
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250624022135.832899-14-joannelkoong%40gmail.com
patch subject: [PATCH v3 13/16] fuse: use iomap for writeback
config: arm64-randconfig-003-20250625 (https://download.01.org/0day-ci/archive/20250625/202506252117.9V3HTO0i-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250625/202506252117.9V3HTO0i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506252117.9V3HTO0i-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepages':
>> file.c:(.text+0xa30): undefined reference to `iomap_writepages'
>> file.c:(.text+0xa30): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_writepages'
   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepage_finish':
>> file.c:(.text+0x1fd8): undefined reference to `iomap_finish_folio_write'
>> file.c:(.text+0x1fd8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_finish_folio_write'
   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_cache_write_iter':
   file.c:(.text+0x888c): undefined reference to `iomap_file_buffered_write'
   file.c:(.text+0x888c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_file_buffered_write'
   aarch64-linux-ld: fs/fuse/file.o: in function `fuse_iomap_writeback_range':
>> file.c:(.text+0x9258): undefined reference to `iomap_start_folio_write'
>> file.c:(.text+0x9258): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iomap_start_folio_write'
>> aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x370): undefined reference to `iomap_dirty_folio'
   aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x3a0): undefined reference to `iomap_release_folio'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


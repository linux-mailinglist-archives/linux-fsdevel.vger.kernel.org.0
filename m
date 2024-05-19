Return-Path: <linux-fsdevel+bounces-19726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5898C9580
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 19:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44917B20F78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D254D9FE;
	Sun, 19 May 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmWVBFa8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B91DFDE;
	Sun, 19 May 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716138960; cv=none; b=CEbvGcLxXP3ZdKGSkFD7hxj1MKzjn9MvtvyV19LDjkcQWXDk8+brmmOGQDFgbl8n3D7FrcYkIxxqa7ciLAM8Bem3UWMK15ZQinqiegVmpOVJUiUI2C6vkbFBiFC1qIPP4actLkxHMUHdvBfr7US1efGd2kz1ePu7K1q9zI0QixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716138960; c=relaxed/simple;
	bh=avh4UAL3tymowqZ8PsD+NwycV25qlnYN+5GxzSUxlJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfPgfd0FtTXFcUi/Cj+48lsmjyf3UY45CkZ9MzrGwXH66r8ivKsFM6q5guqQV9zNoMEIFNPOqDFVuUC7Q8aT3aQKvopsZ3HSBNiH2CG6qwNhH6uKYFpS8I9eKfGEYijEwChsQu+LL612e/j9J7f5iW0Dqw/Dt6yIw4EYSB314gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmWVBFa8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716138958; x=1747674958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avh4UAL3tymowqZ8PsD+NwycV25qlnYN+5GxzSUxlJM=;
  b=lmWVBFa8p8rkDk7WgxMVNhrufn+fwsjLgRHB9/MhjNPxtomXirjWATJV
   LjvpZCion9+VGdkkL9pO6StYetm7PMEyRjvwsx6udzUUw3U1CmVYa4F5h
   ej6ZfmLe2StaxeV01d9BFDUgUiqZ+mZNaypLbXBiuLX3mwdL/64hfejZh
   Va88nKFbRvyJZ2hsjNWH5xyMvf9knE+7mmHNF/gVeTyZa3YHdarcgp9UF
   DAnZgskl0jczkHl3Ii6mvOVVgIPm22CVwueWWreWBaL4AjBuKn78EkkFl
   i+NIqIV26psOv6YIGPA386duZ7SQd4R5zqwITUaZOTvQJkpTCYb0+YL44
   w==;
X-CSE-ConnectionGUID: 3ZFh9HnvTnOQ5/vbX46rNg==
X-CSE-MsgGUID: ORMcOc+7QOKExLEtd3IfBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="16090167"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="16090167"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 10:15:58 -0700
X-CSE-ConnectionGUID: xV1w0CkHRt+EncUXpdUJsQ==
X-CSE-MsgGUID: 4Yvu+Z0jSyOEenpHX3KT2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="32144069"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 19 May 2024 10:15:53 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8k8W-000435-1r;
	Sun, 19 May 2024 17:15:52 +0000
Date: Mon, 20 May 2024 01:14:57 +0800
From: kernel test robot <lkp@intel.com>
To: Wen Yang <wen.yang@linux.dev>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, Wen Yang <wen.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Dylan Yudaken <dylany@fb.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: introduce ratelimited wakeup for non-semaphore
 eventfd
Message-ID: <202405200111.frRQbI4n-lkp@intel.com>
References: <20240519144124.4429-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519144124.4429-1-wen.yang@linux.dev>

Hi Wen,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.9 next-20240517]
[cannot apply to vfs-idmapping/for-next hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Yang/eventfd-introduce-ratelimited-wakeup-for-non-semaphore-eventfd/20240519-224440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20240519144124.4429-1-wen.yang%40linux.dev
patch subject: [PATCH] eventfd: introduce ratelimited wakeup for non-semaphore eventfd
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240520/202405200111.frRQbI4n-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405200111.frRQbI4n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405200111.frRQbI4n-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: fs/eventfd.o: in function `eventfd_write':
>> eventfd.c:(.text+0x998): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


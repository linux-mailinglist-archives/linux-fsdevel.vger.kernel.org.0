Return-Path: <linux-fsdevel+bounces-19728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A338C96BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 23:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B36A1C20BC3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159E871757;
	Sun, 19 May 2024 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqHZEb6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB196D1B9;
	Sun, 19 May 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716153497; cv=none; b=fVPc1BjmTyWhNZaFnhID4dWsdBV+ERENvBCKqXMHkTS0CF2fObIwf1sr81RUgX7nhw6JSnfRv8YEAdHMdMa59l3AO3na7UZ9ipvDBhfTmk4OeflcGdOppNMek81Q41IzWItUxh3x4EOx2Q+rGSGBTGRmIRfW7/O7bwHojWUlv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716153497; c=relaxed/simple;
	bh=A8v8ftVXYdDsWNVE031nUsbr2Ww/YGTybMXOH9tQ1Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5k6kkoRY+wq9pbIBt+vEtGa/O/ZRjdK9O4r8WNPYgmoTiX0dHjZogi+dWmnD0gw6WM45lnzW/SCwGFip+ofs7ytqmfBN0cXeoMMdhQ0VS03Wu6luFiCYNWkEO8R/9CZLBeRGWAaj58bD9H4+ZArQ9/oYtwYUvXUdnVWsvt+yeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqHZEb6l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716153496; x=1747689496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A8v8ftVXYdDsWNVE031nUsbr2Ww/YGTybMXOH9tQ1Io=;
  b=gqHZEb6l+j6+LPeBEgXIY0vH1pdm+8ZAoLgZjFaGygUPweGU3y3iv5jR
   aNsWop9G+6bjzGlA19fmIc/wi4ru7QKis6AcIcyI2Whodsm+6SK/2n1zf
   s8CdNwjM0DeNRm/Mub10gNh0O1IjH9dpXf3XGZVlilbSa/UZVpo/lX/8O
   Mz0cnptwWQcjXeFB/8QEKPvWSn18kmTTvEjLGUjvbEY5VqtBz60FYhiT6
   mdX40f7vwkcW0ZxENdgyvzUOi5gnI+x4oKdkVABx0J6epOFuc3UZYjbvB
   BZBY0ZHCGki1HCPZ8IUAL/cOYsDKQ9O11zeZetYYY8f5Z8gOvhJOpE7N+
   A==;
X-CSE-ConnectionGUID: SGsrSxNoTfCxwHVVD1m02g==
X-CSE-MsgGUID: ZVdiK2qyQNmZGtZLQ2ck4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12391412"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="12391412"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 14:18:16 -0700
X-CSE-ConnectionGUID: bZ3ikktdTzSYqoga+0tJtQ==
X-CSE-MsgGUID: aWR0LS+MSVaEeVYiNnoY+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="32355542"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 May 2024 14:18:12 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8nuz-0004BU-2c;
	Sun, 19 May 2024 21:18:09 +0000
Date: Mon, 20 May 2024 05:18:01 +0800
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
Message-ID: <202405200456.29VvtOKg-lkp@intel.com>
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
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240520/202405200456.29VvtOKg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405200456.29VvtOKg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405200456.29VvtOKg-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: fs/eventfd.o: in function `eventfd_write':
>> eventfd.c:(.text+0x1740): undefined reference to `__aeabi_uldivmod'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-27256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7795FDA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 01:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35BB5B22307
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3319DF4B;
	Mon, 26 Aug 2024 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSTHEojy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87F1482E6;
	Mon, 26 Aug 2024 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713178; cv=none; b=oIQn6IZYg7pXeMt3b4hdOKAxhKbYXXeEbR0I403SVE6QtKt0QlEAEN97A6YOhEW5/sWtU3BVwXXK2AP8DNGN/lYlL3/TuX8JWkDFosspBaw+hdtWMXEx+otQZVQ84S8VVBU6z7hsACJrVWDB5n3Ki+d3rbISOJED44Cdiy6IraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713178; c=relaxed/simple;
	bh=j/xdvk5yqOYi7SqQ3cgkkE/vRKi8AEeOTmezkqrgBrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3Ku04+2p31KQt7A+UO5TH0xOpuW007L++Or4vP/fcV7GR8u+dPsYj8A64Ei6GrQEzxC7IGGrBRUjjVeiOVFAiIt3hwKRHt4zVxTg9iLvPTeDa3mLXny6u1ieR9FNPAGbsnDGjQUKtsOMnOTUrkvddmsLdyBAdO0A5J7w0H+mgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSTHEojy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724713176; x=1756249176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j/xdvk5yqOYi7SqQ3cgkkE/vRKi8AEeOTmezkqrgBrs=;
  b=WSTHEojyorFU52B7E+mg2qYudJ+j5X0mbJAyedb/5N3u0NW81eA6OymS
   wDQ6iPbtLFLYYtsUqPyNUatNfYYLwLvitYi64S/uOKGnf0vxLsqeTpF65
   fZx/TXfds4tOKIxFqIkW0V0TZvRKn3w5O3B5JBVVM4fjrD7ZAIL3JeQpz
   hqpFwWcVIUgSGiRevBkdkGrbU0Uy+BMyFCtqPhzA+mAbM6u9HEO6JeOWO
   I4Pt5DtSXkr4sga+175GBXTB3GUSY6FeBJuDyDTkiZTSM88QRfJKtIhlh
   VDJWNC4THZVsgwkdYNO+dtCHPyHdquCl9wCsd3Ie+6nNTPYqAvsgCr9Gv
   g==;
X-CSE-ConnectionGUID: eY5lUzrcR5iqdY8j/Svg9w==
X-CSE-MsgGUID: iVR4ldkrRaquFEGoZiHf+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23047116"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23047116"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:59:36 -0700
X-CSE-ConnectionGUID: gB2c0a4jSlm2+s5Ef4e1mw==
X-CSE-MsgGUID: 2f2hlUuZR1Ki9PYIbqMxMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="93454149"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Aug 2024 15:59:32 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siigM-000Hg6-1A;
	Mon, 26 Aug 2024 22:59:30 +0000
Date: Tue, 27 Aug 2024 06:58:44 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, krisman@kernel.org,
	Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH 4/5] tmpfs: Expose filesystem features via sysfs
Message-ID: <202408270618.4ue8oNhS-lkp@intel.com>
References: <20240823173332.281211-5-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823173332.281211-5-andrealmeid@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/tmpfs-Add-casefold-lookup-support/20240826-135457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240823173332.281211-5-andrealmeid%40igalia.com
patch subject: [PATCH 4/5] tmpfs: Expose filesystem features via sysfs
config: i386-randconfig-063-20240827 (https://download.01.org/0day-ci/archive/20240827/202408270618.4ue8oNhS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270618.4ue8oNhS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270618.4ue8oNhS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/shmem.c:5515:1: sparse: sparse: symbol 'dev_attr_casefold' was not declared. Should it be static?

vim +/dev_attr_casefold +5515 mm/shmem.c

  5512	
  5513	#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
  5514	#if IS_ENABLED(CONFIG_UNICODE)
> 5515	DEVICE_STRING_ATTR_RO(casefold, 0444, "supported");
  5516	#endif
  5517	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


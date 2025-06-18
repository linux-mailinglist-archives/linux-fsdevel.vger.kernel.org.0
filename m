Return-Path: <linux-fsdevel+bounces-52045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D5ADEE46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D684A24EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1982EA720;
	Wed, 18 Jun 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ks7sAMqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB822E3AEB;
	Wed, 18 Jun 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254412; cv=none; b=B7SljnbInsNP2lFAN0TLmPC5AU5g0GnWTyIRY2sYmd1OCaq2noxo+kTHrePFQ4z7xTgPmaz16QVWeRMqHTJ2WkvhHdGw7UqlG6Ikf4o38fAfxkU7w5MJhNnuREdTUv1IfxdwxjWklD7LdXzOTTeljUNhCIG+Hute5xsZjBbepNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254412; c=relaxed/simple;
	bh=0EMji8aqYWbdtX5rYc4WRUDxhll/CDjjpQIcNC2+O/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4fNQ5vFDBHrspow7P5zS2wRUSyBWnW4G0v5eRNB2PndJm9lx53tHH2MHTyhYXanY0VbRoEQ3Cvgm4Fp9n0nqbKLweGjD0Qo3lR1ZDQiVscFNP48Br8dOmb735iOWqf3gdPuelxKqQGGX842aUAX84Efk6ZX/iftnn2hXucsosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ks7sAMqi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750254411; x=1781790411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0EMji8aqYWbdtX5rYc4WRUDxhll/CDjjpQIcNC2+O/0=;
  b=Ks7sAMqirpeSZ6iSnuOyt2wKsVWchz1vYmqQ5DGYZ+amqtwOafXvDcm4
   TmeSWHn/cV1G2IuyC/JaYDUBWayF5uCb9Uomyu9YYuxL49HlfMThZA7y8
   Avve6gT1N57kIS6WINrN0qrbKlhhA6Gr5c/36AQhSIMAf1mjekXZnVVLR
   GsU0B539mgPAbM67S2m3+Bi7660o2WRA9ZZK/tK2bDSQkQ9wGWjhXL9HC
   xUep4R870r8m5go1mjGK7XjM022E52YxGqkxyADKeHUOWKcbNMFw5Fl7F
   vmNS5m2r74dsSZ/GIwkPCkhphXszQYw+925wuxHxvMWrBh/Vqhrv1NbJs
   w==;
X-CSE-ConnectionGUID: 0lBNZEAxRqeEqgcB8olCzw==
X-CSE-MsgGUID: wMUzT/8+SASAMYodnWR4Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63141581"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63141581"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:46:50 -0700
X-CSE-ConnectionGUID: 9p5yASy0Sfm8Lm+zwO+x/g==
X-CSE-MsgGUID: JhV9hFieQqSHrQw9zY7XQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149586255"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2025 06:46:49 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRt7m-000Jpa-2C;
	Wed, 18 Jun 2025 13:46:46 +0000
Date: Wed, 18 Jun 2025 21:46:25 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Lawrence <paullawrence@google.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Paul Lawrence <paullawrence@google.com>
Subject: Re: [PATCH v1 1/2] fuse: Add backing file option to lookup
Message-ID: <202506182126.iGTKLLEc-lkp@intel.com>
References: <20250617221456.888231-2-paullawrence@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617221456.888231-2-paullawrence@google.com>

Hi Paul,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v6.16-rc2 next-20250618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Lawrence/fuse-Add-backing-file-option-to-lookup/20250618-061717
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20250617221456.888231-2-paullawrence%40google.com
patch subject: [PATCH v1 1/2] fuse: Add backing file option to lookup
config: i386-randconfig-001-20250618 (https://download.01.org/0day-ci/archive/20250618/202506182126.iGTKLLEc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250618/202506182126.iGTKLLEc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506182126.iGTKLLEc-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/fuse/inode.c: In function 'fuse_inode_backing_eq':
>> fs/fuse/inode.c:479:44: error: 'struct fuse_inode' has no member named 'backing_inode'
     479 |                 && fii->backing_inode == fi->backing_inode;
         |                                            ^~
>> fs/fuse/inode.c:480:1: warning: control reaches end of non-void function [-Wreturn-type]
     480 | }
         | ^


vim +479 fs/fuse/inode.c

   471	
   472	static int fuse_inode_backing_eq(struct inode *inode, void *_nodeidp)
   473	{
   474		struct fuse_inode_identifier *fii =
   475			(struct fuse_inode_identifier *) _nodeidp;
   476		struct fuse_inode *fi = get_fuse_inode(inode);
   477	
   478		return fii->nodeid == fi->nodeid
 > 479			&& fii->backing_inode == fi->backing_inode;
 > 480	}
   481	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-74248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E05D38971
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C14F43042B4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 22:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA0A314A7C;
	Fri, 16 Jan 2026 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z27LjIhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881D1C3BF7;
	Fri, 16 Jan 2026 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768603655; cv=none; b=YWx5tuwJ/yBJ4OIWRLYkSjL6qjUv2JFyRDE36DNGTqenfz+WJxBHyGckdcHmMuEZo5LfrCS7+DAEmafm4ljM06hKYQw18BmwnMnAaGxW9CJIWEkoDudWzrszdo6SXDTspGZSPXVR1QKOowXaF1n/jGrnE9lk3qFau6xk319PJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768603655; c=relaxed/simple;
	bh=ft7oBiD8rhWcMGq/GD4pRfUpcGvOzQ2H/GYUPzcJ0Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTa7gH/Hllws7F1APoBEeZfkRv923/69uFRB0MC6cQiyTvNCNzqSEPBuikckPQ0gq6VmM4JUT4t7wCuiLVM3C5DFQTpW+v3bfBC2oueqOoIZkobnXct9XDNxAjZSSTPhmDRRdOgDqRbTaZx3i47XqzoAosaQvU1Dj6I52HnSXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z27LjIhX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768603653; x=1800139653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ft7oBiD8rhWcMGq/GD4pRfUpcGvOzQ2H/GYUPzcJ0Og=;
  b=Z27LjIhX+o7fq1PevKhj6/TlSIXoUKzqKKZYNfO2so++hmrWVsGdCZYC
   qhE8tjOsVYG3xjyCNRcr/prDwsq0Xxe7juFpOBfMiB3QfU037zHrCpfhb
   mIXI9ae/Wz0Pu03rbcwF0vyBsV9Qy75C4TLf+8B/4fBzXZpO/qRSuNHw1
   92VfkBKyXmtFQ6/vLTWmix/JIJRTBIxouD6+ywfHFDwItz8hxtNqIXOe0
   cq5Gqv7qapaqp1h0EhRPvPaXF4V3BZiS2nBFgkEsjCe+kvYUxV0CM9hmI
   w9ZEb5Sin7rV6pMdUNDMtN1eqMhLB9yHp6GvH63xkuBco1SWF/0fR9bOY
   Q==;
X-CSE-ConnectionGUID: CMwpypx6S+GJ+nUbDoPj+A==
X-CSE-MsgGUID: A5tVUpEOS66BK+cs2QjPAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="87496869"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="87496869"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 14:47:28 -0800
X-CSE-ConnectionGUID: hB8/qJmrS4etYteS2y1Iww==
X-CSE-MsgGUID: io6o7vAtSK+BQBlZ4hT9/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="236625710"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jan 2026 14:47:24 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgsbB-00000000LJc-3rVs;
	Fri, 16 Jan 2026 22:47:21 +0000
Date: Sat, 17 Jan 2026 06:47:12 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Coddington <bcodding@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 4/4] NFSD: Sign filehandles
Message-ID: <202601170612.qqi8Q8Xx-lkp@intel.com>
References: <9c9cd6131574a45f2603c9248ba205a79b00fea3.1768573690.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9cd6131574a45f2603c9248ba205a79b00fea3.1768573690.git.bcodding@hammerspace.com>

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bfd453acb5637b5df881cef4b21803344aa9e7ac]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/nfsd-Convert-export-flags-to-use-BIT-macro/20260116-223927
base:   bfd453acb5637b5df881cef4b21803344aa9e7ac
patch link:    https://lore.kernel.org/r/9c9cd6131574a45f2603c9248ba205a79b00fea3.1768573690.git.bcodding%40hammerspace.com
patch subject: [PATCH v1 4/4] NFSD: Sign filehandles
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260117/202601170612.qqi8Q8Xx-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601170612.qqi8Q8Xx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601170612.qqi8Q8Xx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfsd/nfsfh.c:162:30: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
     161 |                 pr_warn("NFSD: unable to sign filehandles, fh_size %lu would be greater"
         |                                                                    ~~~
         |                                                                    %u
     162 |                         " than fh_maxsize %d.\n", fh->fh_size + sizeof(hash), fhp->fh_maxsize);
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:565:37: note: expanded from macro 'pr_warn'
     565 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                    ~~~     ^~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +162 fs/nfsd/nfsfh.c

   140	
   141	/*
   142	 * Intended to be called when encoding, appends an 8-byte MAC
   143	 * to the filehandle hashed from the server's fh_key:
   144	 */
   145	int fh_append_mac(struct svc_fh *fhp, struct net *net)
   146	{
   147		struct nfsd_net *nn = net_generic(net, nfsd_net_id);
   148		struct knfsd_fh *fh = &fhp->fh_handle;
   149		siphash_key_t *fh_key = nn->fh_key;
   150		u64 hash;
   151	
   152		if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
   153			return 0;
   154	
   155		if (!fh_key) {
   156			pr_warn("NFSD: unable to sign filehandles, fh_key not set.\n");
   157			return -EINVAL;
   158		}
   159	
   160		if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
   161			pr_warn("NFSD: unable to sign filehandles, fh_size %lu would be greater"
 > 162				" than fh_maxsize %d.\n", fh->fh_size + sizeof(hash), fhp->fh_maxsize);
   163			return -EINVAL;
   164		}
   165	
   166		fh->fh_auth_type = FH_AT_MAC;
   167		hash = siphash(&fh->fh_raw, fh->fh_size, fh_key);
   168		memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
   169		fh->fh_size += sizeof(hash);
   170	
   171		return 0;
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


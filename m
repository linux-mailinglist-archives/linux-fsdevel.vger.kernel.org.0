Return-Path: <linux-fsdevel+bounces-54324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32836AFDD97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 04:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8EF3BF11E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 02:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731731D8DFB;
	Wed,  9 Jul 2025 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiaZ0XsF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1251C32FF;
	Wed,  9 Jul 2025 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028952; cv=none; b=Vep14L8kszlLu+mhxCY9eEPAytP0sGEF5QkCLmoREdViu990W2Ctu/QMKqCgsFoRERFRvd/Ir2/ra3fS8j/ZoA+LWKvQ2/NiQwwPGzuBqAAa8QtIzXc57E0dDgqUe02JwEVHnPjJIbTkIFIkUsljyi+wZnvahWDArTzjUiR7Ja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028952; c=relaxed/simple;
	bh=xglNHnUKEdCNHWEZUbyP1kgYRLDTNgnIgCGRAbmV9TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVX8+WMklpTv+UGAWdz0hEA5qTnOhTrgDKXl3rgxTQ9qYctCnG3WLa6jD57QKvd5qLx1qyhmGQfJngYNq5V/wJkGrIHHGRJUg733mbyppElJomVhoPSR7KtV14jva2kPhr3kZKsXOGm2UUfB+PHJPsN31hk0aRpmwv47cgJGDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiaZ0XsF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752028951; x=1783564951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xglNHnUKEdCNHWEZUbyP1kgYRLDTNgnIgCGRAbmV9TY=;
  b=XiaZ0XsFlZdrVXZKf6axemcA1BeWynOkjxaDjNcXA26aqWZBeaS5rqsh
   5hvY3VCx2Agsj+rlvGSDDaxFcuv5TuN7R51mvp/ZAUQ5wwgsG478Z4nfn
   1FR48p+t+DlbUJjBMJlx92MFJzO6XWIA9I+rMTtoorxZF6sdn25Xmrdcx
   SjW1Z0MrZza2ok7hYfZFQ5Koip6n5VaiSVa8GcFDKQ86cHJwuGFp+F/AZ
   wOcQ5wBUK0oQzmC7hphMdKY+09myTPpM9n/kXjdROOmaIFFVAxf27TQTt
   aNEMxxXBM1c59i/4XgOFCEob+TcmmkwDuUgrKNAUUqJkooJhQPHjyJ1fv
   Q==;
X-CSE-ConnectionGUID: DXkI2VHrTAqqoZ8WFmJprQ==
X-CSE-MsgGUID: nQ/0cMemRyG3SLd9qhqrNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71861557"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71861557"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 19:42:30 -0700
X-CSE-ConnectionGUID: tytLHidlQRG86rBxSg+7Kw==
X-CSE-MsgGUID: TUVthDdhTX+U4YWnIEJPfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161204389"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Jul 2025 19:42:27 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZKlN-0002zX-0w;
	Wed, 09 Jul 2025 02:42:25 +0000
Date: Wed, 9 Jul 2025 10:42:13 +0800
From: kernel test robot <lkp@intel.com>
To: Yuwen Chen <ywen.chen@foxmail.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, Yuwen Chen <ywen.chen@foxmail.com>
Subject: Re: [PATCH] f2fs: improve the performance of f2fs_lookup
Message-ID: <202507091026.yb48YXt5-lkp@intel.com>
References: <tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505@qq.com>

Hi Yuwen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jaegeuk-f2fs/dev-test]
[also build test WARNING on jaegeuk-f2fs/dev brauner-vfs/vfs.all linus/master v6.16-rc5 next-20250708]
[cannot apply to tytso-ext4/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuwen-Chen/f2fs-improve-the-performance-of-f2fs_lookup/20250708-184528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/tencent_0D8BB6ABAB0880DB7BFCCE35EDBC3DCFF505%40qq.com
patch subject: [PATCH] f2fs: improve the performance of f2fs_lookup
config: arc-randconfig-001-20250709 (https://download.01.org/0day-ci/archive/20250709/202507091026.yb48YXt5-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250709/202507091026.yb48YXt5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507091026.yb48YXt5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/libfs.c:1908 function parameter 'prealloc' not described in 'generic_ci_match'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


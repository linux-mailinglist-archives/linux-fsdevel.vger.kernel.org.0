Return-Path: <linux-fsdevel+bounces-51040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB29AD22B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC0A3A3CA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28920AF98;
	Mon,  9 Jun 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVKsMRhF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3621019C;
	Mon,  9 Jun 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483706; cv=none; b=AGM7R7N7sZpuHM0u10f7HBFH2HmEm/jUzk4ZvLc9v7ZRnpaIQdQZ1vBlUdoiJSJWtliUoyNS0/Gc2GqkegLgexRn033gK9oNWSWW7TISzg9GwKDaNZvQY/1ROrvdDkUzaaS9UdW1vNVUIoOcKsWGyngNL+EnMVNGR+tECSNZzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483706; c=relaxed/simple;
	bh=oLninvSAGUYHt2k8oA6A6XsoeCG63qFLupVzHad1EYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8AS/MA5RjnHFATN40y//XeFhPo7MxCh13fB20aKqYloO9MjMYuqV0eJxOmzmRrK5R1EmSqDzrNpxO3iOm9r2mLkqCf5r2AlL4nCPeA3f2jMhT3tHyOBxjqMWIUG15teO7ZnUXSOhHjGnwA6lpPjmq9YJ98fYryNYYVAzFF9+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVKsMRhF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749483705; x=1781019705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oLninvSAGUYHt2k8oA6A6XsoeCG63qFLupVzHad1EYM=;
  b=lVKsMRhF/5XEK8Gz4rxde9ac0QRuSrl0vVGE7lCpR3TZOBMVTgzqO7uy
   lYQoeLGTNz6mmfx56SCcm/pP18YHfyWg4vQmMf0V+FcnmNnr6fS8ZC456
   Y+JMTmrwmQfxa5Kt24Fhy6JmbyZWOjg0FqHqnf33FvvPQELz/qWUw5sfn
   sjPrI+PFTlOTG1iWG28HcwTpS7Io9E5JcPb74sl3RDlpYqNecGQrPuLqM
   D/btZXkzRgdncvs6k86Gxy+s/yyNOXEbZiGosJOnoawyMBzVLStdc4GTk
   jodYOPF6bog7JhuLeXVs+xXKdavRQD0SB+PVn7/wZag4fG0Ixm5yMAH61
   A==;
X-CSE-ConnectionGUID: sPXBfHRlSXSC9+AwQtELvg==
X-CSE-MsgGUID: 9x+VMEJMRieZ8rBZXRlPnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51476339"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="51476339"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 08:41:41 -0700
X-CSE-ConnectionGUID: ZG1wlEDuTmWBChkjQMEgyw==
X-CSE-MsgGUID: IPmBLu+KS2mHIke0OJNJOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="177455852"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Jun 2025 08:41:15 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOeca-000797-2c;
	Mon, 09 Jun 2025 15:41:12 +0000
Date: Mon, 9 Jun 2025 23:40:25 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <202506092301.jUMzAZW1-lkp@intel.com>
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-add-mmap_prepare-compatibility-layer-for-nested-file-systems/20250609-172628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250609092413.45435-1-lorenzo.stoakes%40oracle.com
patch subject: [PATCH] mm: add mmap_prepare() compatibility layer for nested file systems
config: arc-randconfig-002-20250609 (https://download.01.org/0day-ci/archive/20250609/202506092301.jUMzAZW1-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250609/202506092301.jUMzAZW1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506092301.jUMzAZW1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/mmap.c:1921 function parameter 'vma' not described in 'compat_vma_mmap_prepare'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-49408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006CFABBEFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3928A3A546E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B81A83E5;
	Mon, 19 May 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FffsN5Ae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E74127817A;
	Mon, 19 May 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660833; cv=none; b=hS6Ao+1pFkzw/E60byDJgL40FsRbLqT1jWv7PsKnlqvhtntkcry6YYGFf/j/QUDg41R19xnBX6KgdVBlPmusktm8rnxbcVvEPvsdwFxYQ92O2Mtgqwz5YcfY2VuJEhiwdgXOu8fZ8AmEzlltSJabhLZ9eLTKoxdi4U8wD2JhqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660833; c=relaxed/simple;
	bh=9iouOGh3QjslBE1M2A6Y6TE92/zQWmx9Bc23waFCt4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMXCljz4SZnYWqfT5WBryTOsf1MQe1qQ2ztzQzaltu7sqvckabnUzrJ6zpHqqBYu7dmNhb+/EyhTfgevnsgPBM1BgwsctCpzOlMKqbDr8DETNc1gPxifg6zAQPnjF7pyHrPZALuOGPdeIBn4owjQd/lyn8Efala2v+YuGnIpt00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FffsN5Ae; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747660832; x=1779196832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9iouOGh3QjslBE1M2A6Y6TE92/zQWmx9Bc23waFCt4U=;
  b=FffsN5Aepn8mo8V4gsGX4alLw1wSzMIHntb9h8yNpLaOqFcgAsk0F/tq
   +1Pw8d74tDtoYxf4yMoUMjzZOFZjFODZTP+iPAkU+GcJqo009zPhrZX4g
   twAoqiMLQleB5qh2DevRjJl87Pw17Kyv/aoTR7VdFntWa8LWWzKgChLb+
   8kRYlgOWBx3O9HdIVdXEHepGfp3c7aq9cceOcKOn7EWEpIYKeWrX0dYlv
   oP6141/lq21tgXOhIJgy/BxNfCUc5oVI2PqbqFVKyB8x94ah6FwGQSW9y
   oWSJiWI7nbLxwqC3lfxDk7le35IxdHkpsxyzS+2KGMaL6gnIs23TgUpza
   A==;
X-CSE-ConnectionGUID: hTCDBz2YQ0mbjDGSGUEs8w==
X-CSE-MsgGUID: yYAOOEi2S9um35Hymji4TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="52191871"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="52191871"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:20:31 -0700
X-CSE-ConnectionGUID: w/erx1NHSqmJhMrNaGbHVQ==
X-CSE-MsgGUID: DEZHvtGbTIe3bNhcttCyoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139268403"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 May 2025 06:20:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uH0Pp-000LWa-25;
	Mon, 19 May 2025 13:20:25 +0000
Date: Mon, 19 May 2025 21:19:50 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Message-ID: <202505192132.NsAm4haK-lkp@intel.com>
References: <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-ksm-have-KSM-VMA-checks-not-require-a-VMA-pointer/20250519-165315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes%40oracle.com
patch subject: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
config: x86_64-buildonly-randconfig-001-20250519 (https://download.01.org/0day-ci/archive/20250519/202505192132.NsAm4haK-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250519/202505192132.NsAm4haK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505192132.NsAm4haK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vma.c:2589:15: error: call to undeclared function 'ksm_vma_flags'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2589 |         map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
         |                      ^
   mm/vma.c:2761:10: error: call to undeclared function 'ksm_vma_flags'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2761 |         flags = ksm_vma_flags(mm, NULL, flags);
         |                 ^
   2 errors generated.


vim +/ksm_vma_flags +2589 mm/vma.c

  2586	
  2587	static void update_ksm_flags(struct mmap_state *map)
  2588	{
> 2589		map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
  2590	}
  2591	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


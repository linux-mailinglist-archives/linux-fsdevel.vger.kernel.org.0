Return-Path: <linux-fsdevel+bounces-38133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9389FC790
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 03:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0388C1628C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 02:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB64E13BC35;
	Thu, 26 Dec 2024 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eac9famI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB44D8CE
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735179298; cv=none; b=dFJlA3lSI6nxlzf3iQzRm/2jPRw4Mx1F0ykj2M6J9Sjl7QctHiZKYUahtCOAdUI4crJNnniyMEWgXy+jSfx+2Rh6j2t59nmkiE8bx96AEUkx8uH7rc7tdksA1cPNsWTUKNy5YNalSEdH5O42GOz2UytGMlMd/wOD06c7v9EAAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735179298; c=relaxed/simple;
	bh=bfY/PNKBLy1svnPyhlJzJ1u/d8+E6R8CVJTVi1IGL3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YkejFt2KEadLmJzxiEATSXzx7s0ietlRi4k0Gnm4ja4Y03p/8pmfHOJhLlYkK51+L5C7tXZl1TQGabuHmIYQ1QOoz3C3IiQtOrIp2VTZRBWHp3Zn8bdTFxXMizT25WFpD3slFjsDQu9cx2OXLp5dSvRg4ILu/U6pPxI0nxAM3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eac9famI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735179297; x=1766715297;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bfY/PNKBLy1svnPyhlJzJ1u/d8+E6R8CVJTVi1IGL3M=;
  b=Eac9famIlKPorxNWsoFeS7cXxK0FNqULs2woSneSpWrfPOP878CC5LOO
   UqHspGXynG4fomo/fTV2OzaG29f+GOH6dtwnT4xm+7lmETBb+/m7KURD8
   sm4IcGjPDQW3qGVI+7ZaYDQn7sQHqBdjkMdz/AR7QFE18P1YIWXfIqk7f
   5sFs+xBm6aIK27rIPvgHSQJc/FUGJSY/9mXbmyXQnWQmE6x8fG6Tk5qKm
   kKNVCwtjdhbJjei2hB9rE2k1wpI7/EaflzfEX4gtwO2enQrfpenk65Sno
   A/86HzhYZY0/o7lkmHzxzhf7TI4zIs1Aw6nmdCYgHAH10BTWOYj9JkKL1
   w==;
X-CSE-ConnectionGUID: 5xW4JerpQHuh6uVK2Kn8PA==
X-CSE-MsgGUID: k1snmnfdRge1GzPDv3regw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35312530"
X-IronPort-AV: E=Sophos;i="6.12,264,1728975600"; 
   d="scan'208";a="35312530"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 18:14:56 -0800
X-CSE-ConnectionGUID: ZJJJHE7JQRSvpm4DwArQXg==
X-CSE-MsgGUID: 1Nw2So0LRaKYFH1N6qpqYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,264,1728975600"; 
   d="scan'208";a="100176920"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Dec 2024 18:14:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQdOm-0002IA-0M;
	Thu, 26 Dec 2024 02:14:52 +0000
Date: Thu, 26 Dec 2024 10:14:26 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.debugfs 17/18] mm/slub.c:7576:38: error: too many
 arguments provided to function-like macro invocation
Message-ID: <202412261018.IBubSniL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.debugfs
head:   e98a67d7c1e4a22fa9b851507e25ecdc5b8cea6d
commit: 3c2d1b64cb4320860923a2097f5891efa2d7060e [17/18] slub: don't mess with ->d_name
config: x86_64-buildonly-randconfig-002-20241226 (https://download.01.org/0day-ci/archive/20241226/202412261018.IBubSniL-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241226/202412261018.IBubSniL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412261018.IBubSniL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/slub.c:49:
   In file included from mm/internal.h:13:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/slub.c:7576:38: error: too many arguments provided to function-like macro invocation
    7576 |                 (void *)(unsigned long)TRACK_FREE, &slab_debugfs_fops);
         |                                                    ^
   include/linux/debugfs.h:125:9: note: macro 'debugfs_create_file' defined here
     125 | #define debugfs_create_file(name, mode, parent, data, fops)                     \
         |         ^
>> mm/slub.c:7575:2: error: use of undeclared identifier 'debugfs_create_file'
    7575 |         debugfs_create_file("free_traces", 0400, slab_cache_dir, s,
         |         ^
   2 warnings and 2 errors generated.


vim +7576 mm/slub.c

  7562	
  7563	static void debugfs_slab_add(struct kmem_cache *s)
  7564	{
  7565		struct dentry *slab_cache_dir;
  7566	
  7567		if (unlikely(!slab_debugfs_root))
  7568			return;
  7569	
  7570		slab_cache_dir = debugfs_create_dir(s->name, slab_debugfs_root);
  7571	
  7572		debugfs_create_file_aux("alloc_traces", 0400, slab_cache_dir, s,
  7573			(void *)(unsigned long)TRACK_ALLOC, &slab_debugfs_fops);
  7574	
> 7575		debugfs_create_file("free_traces", 0400, slab_cache_dir, s,
> 7576			(void *)(unsigned long)TRACK_FREE, &slab_debugfs_fops);
  7577	}
  7578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


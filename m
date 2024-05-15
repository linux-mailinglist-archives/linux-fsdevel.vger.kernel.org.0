Return-Path: <linux-fsdevel+bounces-19484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9954D8C5EBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 03:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6061C21111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D7257D;
	Wed, 15 May 2024 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3QOzuiY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02645EDF
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736254; cv=none; b=C84eKjD1L2Huu/3PalNI7ir7MAyVl3X1hmPHdMg1ADz1w0LARoN/T21necniaWpMSyCAUpJz1qRu7IpYtxS5DnI9sJTnQRZpgOSf+zp2IuPuwz6mVR6gLmscKXG/iJ/aHruQ7njwsJFL87Ori7ecu+O/TXFD8aJbD2Ys0Nl27W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736254; c=relaxed/simple;
	bh=uwFcfdzx44uwtXhg5LJeZCjDv0LXrlANCCvKcXvL5BM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nj1SLCP6slM/4TpvVITRBTBuW27bdUjzbDL4OxPL3HEAsikYiJfkx4QganKC131nAaVtlkVEkcffbUZOWMHw9YuB4BDjTEjr+7IKixvRtl2lIL34MMCCjpHhaEn2wiUzpKf7DMyPlacu+BcIrCVL7eyWTPNpgIQAA7xRl7mPdH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3QOzuiY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715736252; x=1747272252;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uwFcfdzx44uwtXhg5LJeZCjDv0LXrlANCCvKcXvL5BM=;
  b=G3QOzuiYF0rUntvg0h0Iun3+rwP3iR8XJXtx9leXnJWRmzIXvUS0smcD
   Ia/5blhAzn8TEJrFW8/2atVHfnVNsYb2gKITr6xUGn0cZjgY7k+PbxGeO
   ECXURwfxLH0oQmz20A4sD1GISIDVWsRoEOcQpUO9wVshM5gj6K3LsVXXU
   l9ef6126OcW8zxqjZgBgTfY95TQiPsLcLapWktwNcrhyTfQ1uiJKG3YHr
   6USM7ujvTQjcUFQwAmzFiqAAgPpym47yV9KIYgU0KV4WTUASZ+dAvNmjY
   xtnVMy86XjZZDkOvWalehy1AvmrJcf6y2gt0wsPqJzHVmbkz3SihF2Jt2
   A==;
X-CSE-ConnectionGUID: DMztDL4jQfyM7uhzt2dFnQ==
X-CSE-MsgGUID: Ti8h2wZbR+KuMBhyeGlqww==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11976467"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="11976467"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 18:24:11 -0700
X-CSE-ConnectionGUID: yKRTRpAFS4C/wGIs7WB6JQ==
X-CSE-MsgGUID: 45L+dKl5TV28UwgXIjAhmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="62063290"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 May 2024 18:24:10 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s73NH-000CCt-1c;
	Wed, 15 May 2024 01:24:07 +0000
Date: Wed, 15 May 2024 09:24:00 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:untested.persistency 41/58] arch/s390/hypfs/inode.c:331:3:
 error: call to undeclared function 'd_mark_discardable'; ISO C99 and later
 do not support implicit function declarations
Message-ID: <202405150917.hqI6d508-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git untested.persistency
head:   2860da18a75c4e0e4d477417ac9ae9f1d37c676c
commit: 2ecf285ca491683e16fc72b963cdbb23dc2b4c7a [41/58] convert hypfs
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240515/202405150917.hqI6d508-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240515/202405150917.hqI6d508-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405150917.hqI6d508-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/hypfs/inode.c:15:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/s390/hypfs/inode.c:331:3: error: call to undeclared function 'd_mark_discardable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     331 |                 d_mark_discardable(dentry);
         |                 ^
   arch/s390/hypfs/inode.c:331:3: note: did you mean 'd_make_discardable'?
   include/linux/dcache.h:617:13: note: 'd_make_discardable' declared here
     617 | extern void d_make_discardable(struct dentry *dentry);
         |             ^
   5 warnings and 1 error generated.


vim +/d_mark_discardable +331 arch/s390/hypfs/inode.c

   316	
   317	static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
   318						char *data, umode_t mode)
   319	{
   320		struct dentry *dentry;
   321		struct inode *inode;
   322	
   323		inode_lock(d_inode(parent));
   324		dentry = start_creating_persistent(parent, name);
   325		if (IS_ERR(dentry)) {
   326			dentry = ERR_PTR(-ENOMEM);
   327			goto fail;
   328		}
   329		inode = hypfs_make_inode(parent->d_sb, mode);
   330		if (!inode) {
 > 331			d_mark_discardable(dentry);
   332			dentry = ERR_PTR(-ENOMEM);
   333			goto fail;
   334		}
   335		if (S_ISREG(mode)) {
   336			inode->i_fop = &hypfs_file_ops;
   337			if (data)
   338				inode->i_size = strlen(data);
   339			else
   340				inode->i_size = 0;
   341		} else if (S_ISDIR(mode)) {
   342			inode->i_op = &simple_dir_inode_operations;
   343			inode->i_fop = &simple_dir_operations;
   344			inc_nlink(d_inode(parent));
   345		} else
   346			BUG();
   347		inode->i_private = data;
   348		d_instantiate(dentry, inode);
   349	fail:
   350		inode_unlock(d_inode(parent));
   351		return dentry;
   352	}
   353	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


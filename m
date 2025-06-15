Return-Path: <linux-fsdevel+bounces-51682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F433ADA115
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 07:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F461170647
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 05:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6E20DD72;
	Sun, 15 Jun 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EU30NRlv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70D335BA
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749965539; cv=none; b=hmZYyfxZbUoQ9FYnQgvqg/pmB+NcDi7mkIoJTuKCvwnLjPjhJ8hzNNm1QaMDZHgDzyVSxaFULYhw5HZGkX2tGvOMDWhlKG4u1iKgAYH7ItMSlxMBfxg9uOz9IA7GBjO6C9PEvN7Mwk2IdWGD0at0KzyEn3irNKm+eIORuesJl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749965539; c=relaxed/simple;
	bh=LMYzYKCO63+mT4SYwhOUngHpkGDfI0GnJgoH1q9kcqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rr1WiBJQkZZN8tDySynxDyiVbnlHTSo5YklCa8xN53lgPMYlSdh3x1wGQ21Yz/sZVppGrTOtxv3jS7oGAVAIhD90X4hN2sb4Gec9UeRnPaKv0Lh9heXDJ1Jq9HLEckCEohrcF0whQSnF1+HaOKaZrh3d27r9HYl+Zu5HrN11nSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EU30NRlv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749965538; x=1781501538;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LMYzYKCO63+mT4SYwhOUngHpkGDfI0GnJgoH1q9kcqE=;
  b=EU30NRlvGNM3k/B4506R68OdIIUgIQfgCA6MPjz0qs54fNwtMnRNX2Fc
   PkWkwV7EpBWPNph7Juxa2j0JTvVGpFRVnkC81AYobsq1hWdd2v+g1UTnr
   4vKOxZthVYxOBUdi0Ku9AGom7/BpOQNBQOioKhz59CDdFx8fYXOj6kB/k
   SYyvtLaqig1MSigaU+oReIDzG4VmWgPhVHKpnsZvIeHQDAmhvUo3eBgsS
   25PVQuo+C163pN/HGKOeaAZ92rPr7B8Rz0mr5QWnA2FXFhm1y/vgze3bI
   GRoKe+LydpObVq2amA11AKOtG+wiofuTgBPhHpd2HgIsWCKMkD5jbfDpy
   A==;
X-CSE-ConnectionGUID: 0x/qiwquTMapNTPW1LlY9g==
X-CSE-MsgGUID: Eq9xtp6DQ1mmDXsg/BocLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="74667469"
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="74667469"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 22:32:17 -0700
X-CSE-ConnectionGUID: 8URcwQvzSYuhSr7lhC8Cxw==
X-CSE-MsgGUID: OlmoXDINT/OuvVCgQyOAwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="149085060"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Jun 2025 22:32:15 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQfyX-000E8u-2N;
	Sun, 15 Jun 2025 05:32:13 +0000
Date: Sun, 15 Jun 2025 13:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.debugfs 9/9] block/blk-mq-debugfs.c:524:22: warning:
 initialization discards 'const' qualifier from pointer target type
Message-ID: <202506151309.YyHBG85s-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.debugfs
head:   dadb85bad8e5007cbd0e52309e3a8d8e2d125544
commit: dadb85bad8e5007cbd0e52309e3a8d8e2d125544 [9/9] blk-mq-debugfs: use debugfs_aux_data()
config: i386-buildonly-randconfig-003-20250615 (https://download.01.org/0day-ci/archive/20250615/202506151309.YyHBG85s-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250615/202506151309.YyHBG85s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506151309.YyHBG85s-lkp@intel.com/

All warnings (new ones prefixed by >>):

   block/blk-mq-debugfs.c: In function 'blk_mq_debugfs_show':
>> block/blk-mq-debugfs.c:524:22: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     524 |         void *data = debugfs_get_aux(m->file);
         |                      ^~~~~~~~~~~~~~~
   block/blk-mq-debugfs.c: In function 'blk_mq_debugfs_write':
   block/blk-mq-debugfs.c:534:22: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     534 |         void *data = debugfs_get_aux(file);
         |                      ^~~~~~~~~~~~~~~
   block/blk-mq-debugfs.c: In function 'blk_mq_debugfs_open':
   block/blk-mq-debugfs.c:549:22: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     549 |         void *data = debugfs_get_aux(file);
         |                      ^~~~~~~~~~~~~~~


vim +/const +524 block/blk-mq-debugfs.c

   520	
   521	static int blk_mq_debugfs_show(struct seq_file *m, void *v)
   522	{
   523		const struct blk_mq_debugfs_attr *attr = m->private;
 > 524		void *data = debugfs_get_aux(m->file);
   525	
   526		return attr->show(data, m);
   527	}
   528	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


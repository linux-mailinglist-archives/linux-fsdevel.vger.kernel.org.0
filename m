Return-Path: <linux-fsdevel+bounces-51684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20B9ADA12A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 08:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2FC16FE97
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4BF261593;
	Sun, 15 Jun 2025 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pnm6mPr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB979D0
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749969986; cv=none; b=KfobZHhnOBtFTeuvyfJO/a9r/XKctw59vc0eZLIVnA+WHKFkqcmsQg7yovMZDNcnk937/eISD4E23kbdwGyekzs/tfRNzHyvEIMEITiVoarz2iaFOo3YxQmYLb/l+5KzMOPeB9D5LjtPjX0hIFVAihMw5mPZZ/dLhuIKEp+Q6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749969986; c=relaxed/simple;
	bh=JjB1jVSppunW0xdA6ALMtZWkebeD988Ayx7XVCdJesQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cvpLp3HIriILSPF2a7qprkNWeCvcSW6Sss+8Slg3n9uAVzm4TGnJWJdqEw1lVRmV4SCQJ0ak61I6IVLgUxPcGD3rGsJQ1BcQaZ98Y7uAh06M4BRsdh+Q+7js8iwwLPAG+paQgsD7jBFZUw33mGDYZlbclWnLGb3j1I6DaqXSxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pnm6mPr0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749969984; x=1781505984;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JjB1jVSppunW0xdA6ALMtZWkebeD988Ayx7XVCdJesQ=;
  b=Pnm6mPr0qZNIGfaX+HfFFrdyQeocawQ09TtkCntVGSPhe7/preuApH+j
   LHT549bsoJcZGAMdQB3EVT87iDhc4UQKobXq83mm2HxCq6n5NgGWfCuUC
   zFkHxwt5cs+z+YSWKrw2xKeoMNfIk0R7rC7QFAT4tjCvOm0fMaTDKcOvI
   X+XspPJNVGhFFr8MDJwWNyaFMt8PwEVETKy5NJitKrM5OSWZzaZYkM3YB
   aj/AaiAvb0Ql1vzVBgMj1od18uWeX2GLqczZyAzzFbdhhnKzVgv4wzOPl
   mQwFA1aordTE9qjRIPsh1oPmniwrsjt8/lv6TLk9wsxuVSMJAOrUoL8I+
   g==;
X-CSE-ConnectionGUID: vyIG88kFRZqBGS6kQjeY0w==
X-CSE-MsgGUID: urrypUIKT4SPqrc0EL5anA==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="52278559"
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="52278559"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 23:46:24 -0700
X-CSE-ConnectionGUID: NAG8V3PYR1q9jopA8dvQ7A==
X-CSE-MsgGUID: Gu7CQvcnSJWIffF3scUHCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="148071400"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Jun 2025 23:46:23 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQh8G-000EAs-0K;
	Sun, 15 Jun 2025 06:46:20 +0000
Date: Sun, 15 Jun 2025 14:45:20 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.debugfs 9/9] block/blk-mq-debugfs.c:524:8: error:
 initializing 'void *' with an expression of type 'const void *' discards
 qualifiers
Message-ID: <202506151407.6kH54qkk-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-006-20250615 (https://download.01.org/0day-ci/archive/20250615/202506151407.6kH54qkk-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250615/202506151407.6kH54qkk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506151407.6kH54qkk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-mq-debugfs.c:524:8: error: initializing 'void *' with an expression of type 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     524 |         void *data = debugfs_get_aux(m->file);
         |               ^      ~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-mq-debugfs.c:534:8: error: initializing 'void *' with an expression of type 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     534 |         void *data = debugfs_get_aux(file);
         |               ^      ~~~~~~~~~~~~~~~~~~~~~
   block/blk-mq-debugfs.c:549:8: error: initializing 'void *' with an expression of type 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     549 |         void *data = debugfs_get_aux(file);
         |               ^      ~~~~~~~~~~~~~~~~~~~~~
   3 errors generated.


vim +524 block/blk-mq-debugfs.c

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


Return-Path: <linux-fsdevel+bounces-25594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2D94DD37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 16:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2076A1F21977
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924BB1586C0;
	Sat, 10 Aug 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWWXommG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF118E0E
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Aug 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723299507; cv=none; b=fPuKiU0c9Tv8iZnXSnfKHZAO7g8uPNPy2xTSjalGORrvzgmWfGCMyrdoVY9wNeKATUXYA3Urr+qlKQaj9oBvA47+EhtO45IDfSpXtB4xUcqFJfns9Np17Y0mbqaYMVydTeZSM/XL5jRdUY8rwGCNqmKnDkllZBlbbEBB1tclJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723299507; c=relaxed/simple;
	bh=J0gf7Ws1pzgHx+xPz2nMIZvebflqt7n166SsKVj06YE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VWRpkjTpDK2wWoFFYseqYS1DlyIh+f6nJqq20fhJY73vxB9MCROUunsGqzgU3u4SJbCjQtNhyNKkY/ahPj5mFtiHtloXE3+Jhd6TgIqvJNuJJV4kkgtM1N6QVy8sU5kbEpAOepmZ3fOowFeP299RCYV8ap4dhlnxNTe28DlKcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWWXommG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723299505; x=1754835505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J0gf7Ws1pzgHx+xPz2nMIZvebflqt7n166SsKVj06YE=;
  b=BWWXommG0cGml5YuZa3U3yfjHYvj6bNKccBW6+4YgH8zngE95TGGbjwB
   8+DEvOyunx1dYio0BE6+FTIMH6realDjo1drWU3y7orEcL8OtDkENobBh
   hxruUPFUPhmALab0HLXKhguMo4Hgviq0BA8uCwJg/5e5nLF8NzEEGoJVL
   85rus6P6bRE1ZW2uIZfEqis8dUR3F0R8jT7W4OUTmrR2J4s7s43N8EyH7
   2pN6Lz+QZeIgw73Lei5ms+I4BYCeQYx+7JuvVMDx9hZ2ugY+Q0IRC9l3J
   372l+tHbJ/pGo4X/J2XfqLFPp8Os1CiPrsDrjTEC5XPbGP4eADlpmh7VG
   g==;
X-CSE-ConnectionGUID: lR9A5EmXQQGZrNaP/T3j3Q==
X-CSE-MsgGUID: JjujWPa5QgGAsize8oHeew==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="38970875"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="38970875"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 07:18:24 -0700
X-CSE-ConnectionGUID: fCPayLSyT/mMR1rdhXp6qw==
X-CSE-MsgGUID: kCBVr5S+SX+2BHBu6iPX9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="95355831"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 10 Aug 2024 07:18:23 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scmvE-000A0K-3B;
	Sat, 10 Aug 2024 14:18:20 +0000
Date: Sat, 10 Aug 2024 22:17:48 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [viro-vfs:work.fd 3/39] include/linux/file.h:60:34: error: expected
 ')' before ';' token
Message-ID: <202408102233.hZjt9tS1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
head:   9d58a36411c167b4126de90e5fe844270b858082
commit: f3270beef0d85432783be702bb9509879415e747 [3/39] struct fd: representation change
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20240810/202408102233.hZjt9tS1-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408102233.hZjt9tS1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408102233.hZjt9tS1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel_read_file.h:5,
                    from include/linux/security.h:26,
                    from include/linux/perf_event.h:62,
                    from include/linux/perf/riscv_pmu.h:12,
                    from arch/riscv/include/asm/kvm_vcpu_pmu.h:12,
                    from arch/riscv/include/asm/kvm_host.h:23,
                    from arch/riscv/kernel/asm-offsets.c:14:
   include/linux/file.h: In function 'fdput':
>> include/linux/file.h:60:34: error: expected ')' before ';' token
      60 |                 fput(fd_file(fd));
         |                     ~            ^
         |                                  )
   include/linux/file.h:60:35: error: expected ';' before '}' token
      60 |                 fput(fd_file(fd));
         |                                   ^
         |                                   ;
      61 | }
         | ~                                  
   include/linux/file.h: In function 'fdput_pos':
   include/linux/file.h:94:43: error: expected ')' before ';' token
      94 |                 __f_unlock_pos(fd_file(f));
         |                               ~           ^
         |                                           )
   include/linux/file.h:95:18: error: expected ';' before '}' token
      95 |         fdput(f);
         |                  ^
         |                  ;
      96 | }
         | ~                 
   make[3]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1193: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +60 include/linux/file.h

254beb4164efec Al Viro 2024-05-31  56  
a5b470ba06aa3f Al Viro 2012-08-27  57  static inline void fdput(struct fd fd)
a5b470ba06aa3f Al Viro 2012-08-27  58  {
f3270beef0d854 Al Viro 2024-05-31  59  	if (fd.word & FDPUT_FPUT)
254beb4164efec Al Viro 2024-05-31 @60  		fput(fd_file(fd));
a5b470ba06aa3f Al Viro 2012-08-27  61  }
a5b470ba06aa3f Al Viro 2012-08-27  62  

:::::: The code at line 60 was first introduced by commit
:::::: 254beb4164efececb3e7b85019e0102c36e86e62 introduce fd_file(), convert all accessors to it.

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


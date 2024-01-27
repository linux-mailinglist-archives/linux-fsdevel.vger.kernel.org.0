Return-Path: <linux-fsdevel+bounces-9227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6B383F126
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 00:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23381C20B07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA41F95B;
	Sat, 27 Jan 2024 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kV5khqQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B81F946
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396408; cv=none; b=q9U9uZpQHqShSjcEOn2VnNf92JD/PzT3aes/+4avcJMbIQmrpHKd+/g94NZIstFALvSTkth4Lv0/YH2C/bVlfEdA/Ew/dqQCsbDM0S3nU6l+TSZL/qW2/wMaEaOas3hBF08ZsS4MPX0FtEdnOoaLGEQYdYGZJ1KB02NtNloRuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396408; c=relaxed/simple;
	bh=lkPngZIXwGFpYH6hbUtp4ELeCarFHaY6ZnN3Le4kYCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ObdKtgNkX2XX56gWHchdiWEJ6fMY8vq2poWzaeNVYQsOZ0k8H/88IMqGFlLumPzbbzymGdVer209lwJqBJOJiRH34kR/zTR/8o3LiZ9CnppSWRqN70e7Gd3W2Mq3A9ZAt4urZPtGHilKBMBfCtm8W6dkYxqvafB9SegiIBhBjHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kV5khqQX; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706396406; x=1737932406;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lkPngZIXwGFpYH6hbUtp4ELeCarFHaY6ZnN3Le4kYCk=;
  b=kV5khqQX10K3o4S3GCYi3ZPDbzbG7t46IH0dHYLNOxXfAztyJERtOZ8Y
   gM5uhyFmFhG2l19HqW8KY8HsdnHza/SCyRSkL4kFR+yQ6jdTX7wDHyuJQ
   sCXAYAaA3euWudE8fvc4h2ruEnZZ393ekNVViq98g/JVlzlUTvk8YLYvu
   +Uu6L462zfPmgtVxhVG0doXvyzTdxF/f9SrIVnuKjMuBSROQR+DvuH/5H
   Vhhgj3dxxxUi6v1A6sIp129+R0ys9K46Ck65vN7vCYxWPw4+J6LYVvwjB
   dVcoUYdyHC1q9FxU2bfbzKy0GSKZdJ9Q9xTBWE//oUOTmBtKtK2cOIGhj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="466989418"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="466989418"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 15:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="737018513"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="737018513"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2024 15:00:04 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTrec-0002pi-0w;
	Sat, 27 Jan 2024 23:00:02 +0000
Date: Sun, 28 Jan 2024 06:59:08 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.alpha 5/8] arch/alpha/kernel/io.c:655:1: error:
 redefinition of 'scr_memcpyw'
Message-ID: <202401280650.Us2Lrkgl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.alpha
head:   267674e3b4fd1ff6cedf9b22cd304daa75297966
commit: 1fb71c4d2bcacd6510fbe411016475ccc15b1a03 [5/8] alpha: missing includes
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240128/202401280650.Us2Lrkgl-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401280650.Us2Lrkgl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401280650.Us2Lrkgl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/alpha/kernel/io.c:655:1: error: redefinition of 'scr_memcpyw'
     655 | scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
         | ^~~~~~~~~~~
   In file included from arch/alpha/kernel/io.c:10:
   include/linux/vt_buffer.h:42:20: note: previous definition of 'scr_memcpyw' with type 'void(u16 *, const u16 *, unsigned int)' {aka 'void(short unsigned int *, const short unsigned int *, unsigned int)'}
      42 | static inline void scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
         |                    ^~~~~~~~~~~


vim +/scr_memcpyw +655 arch/alpha/kernel/io.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  650  
^1da177e4c3f41 Linus Torvalds 2005-04-16  651  /* A version of memcpy used by the vga console routines to move data around
^1da177e4c3f41 Linus Torvalds 2005-04-16  652     arbitrarily between screen and main memory.  */
^1da177e4c3f41 Linus Torvalds 2005-04-16  653  
^1da177e4c3f41 Linus Torvalds 2005-04-16  654  void
^1da177e4c3f41 Linus Torvalds 2005-04-16 @655  scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
^1da177e4c3f41 Linus Torvalds 2005-04-16  656  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  657  	const u16 __iomem *ios = (const u16 __iomem *) s;
^1da177e4c3f41 Linus Torvalds 2005-04-16  658  	u16 __iomem *iod = (u16 __iomem *) d;
^1da177e4c3f41 Linus Torvalds 2005-04-16  659  	int s_isio = __is_ioaddr(s);
^1da177e4c3f41 Linus Torvalds 2005-04-16  660  	int d_isio = __is_ioaddr(d);
^1da177e4c3f41 Linus Torvalds 2005-04-16  661  
^1da177e4c3f41 Linus Torvalds 2005-04-16  662  	if (s_isio) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  663  		if (d_isio) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  664  			/* FIXME: Should handle unaligned ops and
^1da177e4c3f41 Linus Torvalds 2005-04-16  665  			   operation widening.  */
^1da177e4c3f41 Linus Torvalds 2005-04-16  666  
^1da177e4c3f41 Linus Torvalds 2005-04-16  667  			count /= 2;
^1da177e4c3f41 Linus Torvalds 2005-04-16  668  			while (count--) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  669  				u16 tmp = __raw_readw(ios++);
^1da177e4c3f41 Linus Torvalds 2005-04-16  670  				__raw_writew(tmp, iod++);
^1da177e4c3f41 Linus Torvalds 2005-04-16  671  			}
^1da177e4c3f41 Linus Torvalds 2005-04-16  672  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  673  		else
^1da177e4c3f41 Linus Torvalds 2005-04-16  674  			memcpy_fromio(d, ios, count);
^1da177e4c3f41 Linus Torvalds 2005-04-16  675  	} else {
^1da177e4c3f41 Linus Torvalds 2005-04-16  676  		if (d_isio)
^1da177e4c3f41 Linus Torvalds 2005-04-16  677  			memcpy_toio(iod, s, count);
^1da177e4c3f41 Linus Torvalds 2005-04-16  678  		else
^1da177e4c3f41 Linus Torvalds 2005-04-16  679  			memcpy(d, s, count);
^1da177e4c3f41 Linus Torvalds 2005-04-16  680  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  681  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  682  

:::::: The code at line 655 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


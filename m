Return-Path: <linux-fsdevel+bounces-30730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C740298DF49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADAB282CA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A21D096B;
	Wed,  2 Oct 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpWibrko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8C1D0953
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883324; cv=none; b=A1jvXW0af/XLca9wuG+dJgMGoZPE0dd8WVbfsN19RvASNxsk4MzxPdpPfrW0ZsoJIDsEEXKJwQogmcS1KGGathcuUxdCNXjEDlWo8C0Z8NirZcSr7COSWWG01v0Y7lCFYTWGQHHzinNjTgp/3juMX+bbEWBAub8VsjsiNlwwA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883324; c=relaxed/simple;
	bh=Rq/HcJAbR9WHQ83k5hEzQ+OVk7NsDlsdsyId+Da4S7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lCUrqPNAOhTtmVIS6bnscT16GEfSFuFqaKg3aU/DB5qHCt3IslHI7gbJxvx4AYwEwzo1tE7uDTp8BKr63zK/zSgkQyO376KixA1G1kbB+pmg36FiEPWtgHIjRKJutAhRIvQwA9X2LuZBDKu1USrFC84OeQoDWoIbB9gcotkhW6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpWibrko; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727883322; x=1759419322;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rq/HcJAbR9WHQ83k5hEzQ+OVk7NsDlsdsyId+Da4S7A=;
  b=EpWibrkos2f8LiF1rVq4w9mXS5UTw9G6bJYZI8pMazyWQCyKBr/MX8vp
   jCBzH3WfDIfpd4Fj69PGyF4kH4pMbR0cwmSSeCTzyrbWy22qb4Rog8/Yn
   LqygEiSf/448zarfE1RzTf/GHD0KE9T3Ue96kT9oV0C+gsqzKeIXwYMEC
   4EvoCODwrMdFyQH1tFO0yJXgV1ZWkmme/tGlZTTu2rFzoBDYijhu2vi3d
   hTtbIGc4CpYRLquLKPCPQEzpayP7swIWUR6spQJrKpqJwO63spYNnz5tx
   AfbRJd5WGgx7yiOkAp0eSc2ja5t4afZ8+QOueJqmOs5WRWDe6B9vcU369
   g==;
X-CSE-ConnectionGUID: uH1Wd7auR2GDEUqqHs2tHQ==
X-CSE-MsgGUID: Wy8SoNZ0QyKf+pK0+Lzm3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="44516554"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="44516554"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 08:35:20 -0700
X-CSE-ConnectionGUID: UXcqZzWoTFer4T+juVz4Fg==
X-CSE-MsgGUID: Ep3Iyda9QyaqH/juug2V6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="74461725"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 Oct 2024 08:35:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sw1Nk-000UA7-2l;
	Wed, 02 Oct 2024 15:35:16 +0000
Date: Wed, 2 Oct 2024 23:35:15 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.fd 1/31] drivers/block/ataflop.c:428:13: error:
 conflicting types for 'fd_error'; have 'void(void)'
Message-ID: <202410022344.sMXwiZCW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
head:   f8d355c905903186d23c995fe5515d949d4aa9f5
commit: 4601d30d36153ce6a6b8ee3b6b722f93df2519c0 [1/31] introduce struct fderr, convert overlayfs uses to that
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20241002/202410022344.sMXwiZCW-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410022344.sMXwiZCW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410022344.sMXwiZCW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/block/ataflop.c:428:13: error: conflicting types for 'fd_error'; have 'void(void)'
     428 | static void fd_error( void );
         |             ^~~~~~~~
   In file included from include/linux/blkdev.h:27,
                    from include/linux/blk-mq.h:5,
                    from drivers/block/ataflop.c:70:
   include/linux/file.h:64:20: note: previous definition of 'fd_error' with type 'long int(struct fderr)'
      64 | static inline long fd_error(struct fderr f)
         |                    ^~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +428 drivers/block/ataflop.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  421  
^1da177e4c3f41 Linus Torvalds    2005-04-16  422  static void fd_select_side( int side );
^1da177e4c3f41 Linus Torvalds    2005-04-16  423  static void fd_select_drive( int drive );
^1da177e4c3f41 Linus Torvalds    2005-04-16  424  static void fd_deselect( void );
24ed960abf1d50 Kees Cook         2017-08-28  425  static void fd_motor_off_timer(struct timer_list *unused);
24ed960abf1d50 Kees Cook         2017-08-28  426  static void check_change(struct timer_list *unused);
7d12e780e003f9 David Howells     2006-10-05  427  static irqreturn_t floppy_irq (int irq, void *dummy);
^1da177e4c3f41 Linus Torvalds    2005-04-16 @428  static void fd_error( void );
^1da177e4c3f41 Linus Torvalds    2005-04-16  429  static int do_format(int drive, int type, struct atari_format_descr *desc);
^1da177e4c3f41 Linus Torvalds    2005-04-16  430  static void do_fd_action( int drive );
^1da177e4c3f41 Linus Torvalds    2005-04-16  431  static void fd_calibrate( void );
^1da177e4c3f41 Linus Torvalds    2005-04-16  432  static void fd_calibrate_done( int status );
^1da177e4c3f41 Linus Torvalds    2005-04-16  433  static void fd_seek( void );
^1da177e4c3f41 Linus Torvalds    2005-04-16  434  static void fd_seek_done( int status );
^1da177e4c3f41 Linus Torvalds    2005-04-16  435  static void fd_rwsec( void );
24ed960abf1d50 Kees Cook         2017-08-28  436  static void fd_readtrack_check(struct timer_list *unused);
^1da177e4c3f41 Linus Torvalds    2005-04-16  437  static void fd_rwsec_done( int status );
^1da177e4c3f41 Linus Torvalds    2005-04-16  438  static void fd_rwsec_done1(int status);
^1da177e4c3f41 Linus Torvalds    2005-04-16  439  static void fd_writetrack( void );
^1da177e4c3f41 Linus Torvalds    2005-04-16  440  static void fd_writetrack_done( int status );
24ed960abf1d50 Kees Cook         2017-08-28  441  static void fd_times_out(struct timer_list *unused);
^1da177e4c3f41 Linus Torvalds    2005-04-16  442  static void finish_fdc( void );
^1da177e4c3f41 Linus Torvalds    2005-04-16  443  static void finish_fdc_done( int dummy );
^1da177e4c3f41 Linus Torvalds    2005-04-16  444  static void setup_req_params( int drive );
05bdb9965305bb Christoph Hellwig 2023-06-08  445  static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
05bdb9965305bb Christoph Hellwig 2023-06-08  446  		unsigned int cmd, unsigned long param);
^1da177e4c3f41 Linus Torvalds    2005-04-16  447  static void fd_probe( int drive );
^1da177e4c3f41 Linus Torvalds    2005-04-16  448  static int fd_test_drive_present( int drive );
^1da177e4c3f41 Linus Torvalds    2005-04-16  449  static void config_types( void );
05bdb9965305bb Christoph Hellwig 2023-06-08  450  static int floppy_open(struct gendisk *disk, blk_mode_t mode);
ae220766d87cd6 Christoph Hellwig 2023-06-08  451  static void floppy_release(struct gendisk *disk);
^1da177e4c3f41 Linus Torvalds    2005-04-16  452  

:::::: The code at line 428 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


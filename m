Return-Path: <linux-fsdevel+bounces-21279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C23901122
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 11:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCB62831BD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650414E2FF;
	Sat,  8 Jun 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TitATOXr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3781643A
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jun 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717839034; cv=none; b=jA1JVhMe5G9VJhmXBj0oggjwvFBw1deUWgw7cbxYQueGpX4YsJxk2v9tfVNs1nBjnGn4b1iB3YECC95Zv1/QmI3vgb1GVaHfRsRYLCYbM5dcO2T6LUrhjA0llD/u7fSZM9DwPyh7iSlNvob3AA72rcs6DDINZq0/a+rTYO0EJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717839034; c=relaxed/simple;
	bh=Z6c5/t6jFIRvWoiZS93ST0wklyV9fib/5onlCugxGow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eqD/5N8CtTpgsTSH5zCmlqvtZEEkh8Y4ZiUob3oPinCe50bLpYVq/ZuI1kCK5AUhCmqHuOC9NuvbU9GPFzrTDBLIjybLZl0DbZ9ogKdPPyQY7zH6C6Eg/43VhTjLQbNCJiaGi0ZTdSp32wzDxYYTmpBYrYjyRKQGkVlXyPJ+11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TitATOXr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717839031; x=1749375031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z6c5/t6jFIRvWoiZS93ST0wklyV9fib/5onlCugxGow=;
  b=TitATOXr83WRU5zkU/PTeHSzH4q0V4G0uoox6BJZMT4P07smV0hcOlsD
   gtupm70JEt6H+P0EpJGxx4P5ikGIQlRmYfkxF9/Obte+6GQe0jf2+zwLg
   Xm2PX4WTTmGfEi+pRgi3MFTIRqEYD3m3ovHvkS1E44B25U1qdrsuKQaP9
   ME7npmZAfzW96iMcpKAf0c06js/LljUKhP3n3Rcc2ywXeJ4IJ5fnoQEsv
   uVvcRaHVC6CcsiOov4I1QIZ2m4IOhwcBe4d1EqrBLMsEGgmyFM3c85wOE
   X7Qn05phk7IEtGEfD6Qqpzc6us778rbD7xGmqFGGYj1Y3gZz2CJnRkUk6
   Q==;
X-CSE-ConnectionGUID: NXGGxW/8ThyQk6ATxrAeeg==
X-CSE-MsgGUID: 1gxsPTBvTaOUfGxoEHVGbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="18419660"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="18419660"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 02:30:31 -0700
X-CSE-ConnectionGUID: +MM4L5kISpO684GRl+oE6w==
X-CSE-MsgGUID: FpbcClQJS/2/gnKFeu+S/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="38660177"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Jun 2024 02:30:30 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFsP5-0001Na-2c;
	Sat, 08 Jun 2024 09:30:27 +0000
Date: Sat, 8 Jun 2024 17:30:05 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.fd 7/20] drivers/block/ataflop.c:428:13: error:
 conflicting types for 'fd_error'; have 'void(void)'
Message-ID: <202406081712.rMU6ThCf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
head:   dc0f4cebf5202edcf915fa1ac5854b627ebf2036
commit: d6fe5281318c10a7351da7775bffa4ad5fe2e9a0 [7/20] introduce struct fderr, convert overlayfs uses to that
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240608/202406081712.rMU6ThCf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081712.rMU6ThCf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081712.rMU6ThCf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/block/ataflop.c:428:13: error: conflicting types for 'fd_error'; have 'void(void)'
     428 | static void fd_error( void );
         |             ^~~~~~~~
   In file included from include/linux/blkdev.h:27,
                    from include/linux/blk-mq.h:5,
                    from drivers/block/ataflop.c:70:
   include/linux/file.h:58:20: note: previous definition of 'fd_error' with type 'long int(struct fderr)'
      58 | static inline long fd_error(struct fderr f)
         |                    ^~~~~~~~


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


Return-Path: <linux-fsdevel+bounces-39576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6747A15BCA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 08:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444431889D9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C228614B942;
	Sat, 18 Jan 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmaBaIxe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8A13AA27
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737186583; cv=none; b=jz99pBHBvznRyOSoP5Jh/wZHpZQoRjVPuYEu0vBaBpkpe5GskdBVAP/UD5Dto4362cOZNLqb2BKZ3TMseaYVvP+94hmbiolkuAavOEm769AUhNX5n9z0WgNrV26LsNtqla8uYAze4B2dqiRK1uoJhyG1j6+vXWFwpnRUyYT4uAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737186583; c=relaxed/simple;
	bh=naCV2a6hsdnVykBflCp49aRvepBykIAaOBcJl0QMnDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y/N0ZmGQbxUNNSNYDJOxSq4jwStdW1i6p0D+PJ9kcaEtyN+6ochipv8fZSvaFUsgvZ3RNv+TDEoLQdYUCMzUwUWQW4JyCnWSvLsieakncUcW0R4JOkX+Y59XvYrjjYOZbBJh8N35tZrHG2NLY04oF/yvAu6QNJDfcBob0Z9Q2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmaBaIxe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737186581; x=1768722581;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=naCV2a6hsdnVykBflCp49aRvepBykIAaOBcJl0QMnDc=;
  b=MmaBaIxeNkdSCi5LS/090nXh9GIIocnk3LHqXlHUs/FOcfRUJTEkVbsh
   72uUi1iUK0NVsSKWCbnuedah7+JHfumkMgXT64egjBNzd7+AJd/gjSdGI
   9uVDEi1lk3D1dLBU5gXu7rRc8e97Qwt9NVBBqYVpUmyPeyrzNI15n7ylv
   tSKr3EvqYg6Hg8R0wiYdA2uAn5k6TWKKMyYLd36I43N1+27J44ENj/n5m
   92bzJzFwkTFCj+K23YCHmTx0S6ukLJDYxr6X1syRgWrZw6mSXuj0+KJSD
   k9WlliFlS9hjK3JGtRwlaBr+7HslVQvwx1CMywTle4AQbGrSK00r+gjY1
   Q==;
X-CSE-ConnectionGUID: vVTk8kliTWGL7zP+lv/PbQ==
X-CSE-MsgGUID: Ly7DbkJnQIyzQSTcpLimtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37533082"
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="37533082"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 23:49:40 -0800
X-CSE-ConnectionGUID: w6BZSUwESMCjLroxKTGWOQ==
X-CSE-MsgGUID: sxi7UMVySxiQ38g/LJ/UmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="105823258"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Jan 2025 23:49:38 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZ3aK-000UCN-0V;
	Sat, 18 Jan 2025 07:49:36 +0000
Date: Sat, 18 Jan 2025 15:48:35 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [viro-vfs:work.ufs 3/3] fs/ufs/super.c:1246:22: warning: variable
 'ufstype' set but not used
Message-ID: <202501181533.2SkfgJga-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.ufs
head:   d6ae2b2cfce0ae88189b7e6a2d2bf5109b5de0af
commit: 8cfcc910ecb377c1be493019dc67c42fa783b734 [3/3] ufs: convert ufs to the new mount API
config: csky-randconfig-002-20250118 (https://download.01.org/0day-ci/archive/20250118/202501181533.2SkfgJga-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501181533.2SkfgJga-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501181533.2SkfgJga-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ufs/super.c: In function 'ufs_reconfigure':
>> fs/ufs/super.c:1246:22: warning: variable 'ufstype' set but not used [-Wunused-but-set-variable]
    1246 |         unsigned int ufstype;
         |                      ^~~~~~~


vim +/ufstype +1246 fs/ufs/super.c

  1238	
  1239	static int ufs_reconfigure(struct fs_context *fc)
  1240	{
  1241		struct ufs_sb_private_info * uspi;
  1242		struct ufs_super_block_first * usb1;
  1243		struct ufs_super_block_third * usb3;
  1244		struct ufs_fs_context *ctx = fc->fs_private;
  1245		struct super_block *sb = fc->root->d_sb;
> 1246		unsigned int ufstype;
  1247		unsigned int flags;
  1248	
  1249		sync_filesystem(sb);
  1250		mutex_lock(&UFS_SB(sb)->s_lock);
  1251		uspi = UFS_SB(sb)->s_uspi;
  1252		flags = UFS_SB(sb)->s_flags;
  1253		usb1 = ubh_get_usb_first(uspi);
  1254		usb3 = ubh_get_usb_third(uspi);
  1255		
  1256		ufstype = UFS_SB(sb)->s_flavour;
  1257	
  1258		if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb)) {
  1259			UFS_SB(sb)->s_on_err = ctx->on_err;
  1260			mutex_unlock(&UFS_SB(sb)->s_lock);
  1261			return 0;
  1262		}
  1263		
  1264		/*
  1265		 * fs was mouted as rw, remounting ro
  1266		 */
  1267		if (fc->sb_flags & SB_RDONLY) {
  1268			ufs_put_super_internal(sb);
  1269			usb1->fs_time = ufs_get_seconds(sb);
  1270			if ((flags & UFS_ST_MASK) == UFS_ST_SUN
  1271			  || (flags & UFS_ST_MASK) == UFS_ST_SUNOS
  1272			  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86) 
  1273				ufs_set_fs_state(sb, usb1, usb3,
  1274					UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time));
  1275			ubh_mark_buffer_dirty (USPI_UBH(uspi));
  1276			sb->s_flags |= SB_RDONLY;
  1277		} else {
  1278		/*
  1279		 * fs was mounted as ro, remounting rw
  1280		 */
  1281	#ifndef CONFIG_UFS_FS_WRITE
  1282			pr_err("ufs was compiled with read-only support, can't be mounted as read-write\n");
  1283			mutex_unlock(&UFS_SB(sb)->s_lock);
  1284			return -EINVAL;
  1285	#else
  1286			if (ufstype != UFS_MOUNT_UFSTYPE_SUN && 
  1287			    ufstype != UFS_MOUNT_UFSTYPE_SUNOS &&
  1288			    ufstype != UFS_MOUNT_UFSTYPE_44BSD &&
  1289			    ufstype != UFS_MOUNT_UFSTYPE_SUNx86 &&
  1290			    ufstype != UFS_MOUNT_UFSTYPE_UFS2) {
  1291				pr_err("this ufstype is read-only supported\n");
  1292				mutex_unlock(&UFS_SB(sb)->s_lock);
  1293				return -EINVAL;
  1294			}
  1295			if (!ufs_read_cylinder_structures(sb)) {
  1296				pr_err("failed during remounting\n");
  1297				mutex_unlock(&UFS_SB(sb)->s_lock);
  1298				return -EPERM;
  1299			}
  1300			sb->s_flags &= ~SB_RDONLY;
  1301	#endif
  1302		}
  1303		UFS_SB(sb)->s_on_err = ctx->on_err;
  1304		mutex_unlock(&UFS_SB(sb)->s_lock);
  1305		return 0;
  1306	}
  1307	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


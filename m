Return-Path: <linux-fsdevel+bounces-15947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581AA896156
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B46D1F28200
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 00:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B58363C7;
	Wed,  3 Apr 2024 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIaB3c0d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776041843;
	Wed,  3 Apr 2024 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103894; cv=none; b=ktmEBLAMPzBpseHhMbWryH4vIodATHHAllKhYIvL9ecBVeh8V4vYGOj/LSlMsD4LcKVbRjP80GqAfUXk1MPZJS+u9cScj1CUSAyyHYWTXmIU5gZn1UU3j6yViiJshQMbLLCv8mVb7xzYEFNHwfPFe2O1w+PRLDo56HuZ8e06CzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103894; c=relaxed/simple;
	bh=ZdqtK3ZZfETjnpTi81gJ5nlOHi2ROi6+EkBjJs+SqA8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jxPsOR+TNsKeyrq/FYWeJy5RCOY40EJ22Qf7DTvohhsN2/aPrHVboVVidcltPaHUKOI5HBRpbjohqMJRzvED13IaVHMjy1T/Jn3Dfpw7UFWt7oqa5QIP7p9P4rmg/KtHbF8cPyFk9Xzh9laggKYrk6C/dTRf5zQcdSE080lhXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIaB3c0d; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712103891; x=1743639891;
  h=date:from:to:cc:subject:message-id;
  bh=ZdqtK3ZZfETjnpTi81gJ5nlOHi2ROi6+EkBjJs+SqA8=;
  b=kIaB3c0dw+c3RszJlCIUnDribIR3jTYBfZ6lUj8ECBoJPYkGoFme23zw
   fpzjpqhrO4SNyGBrdRZzqf+Wk+juULo9k0ux1/LCt9N0Q81nghdvIMLSS
   PGQgn/llknBFnb7f+Ogb1+aWLXnGdPMeLCA+LF5L9ofvUPnwgvKy81oMe
   72O33+D51ldJJc5hNlT0ZZPloKtlfeqHnEg0eK5E7BrCeQSEOiWAqZs10
   WA2TIabthS4anHlJiksDSonFyFQmFK1r4Iqti3eeIC1F7WMBl9e4jnJT6
   g7fJVMTenAisYwlcTkN3c6lnU9vQnFPFrInlQGZgUbUe8wawCDIKvb+do
   g==;
X-CSE-ConnectionGUID: jAg0L+n6RDuHKppxymXlAg==
X-CSE-MsgGUID: I4mp2qH2RHex5cr1QFbt0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18674628"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18674628"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 17:24:49 -0700
X-CSE-ConnectionGUID: vEjj95jXQwuHDE5mRRIX5A==
X-CSE-MsgGUID: y62IkkeASwCpzElDPyHKCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18224102"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 02 Apr 2024 17:24:44 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rroQj-0001fF-0x;
	Wed, 03 Apr 2024 00:24:41 +0000
Date: Wed, 03 Apr 2024 08:24:38 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-usb@vger.kernel.org, nouveau@lists.freedesktop.org,
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 c0b832517f627ead3388c6f0c74e8ac10ad5774b
Message-ID: <202404030831.bzhKcrln-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: c0b832517f627ead3388c6f0c74e8ac10ad5774b  Add linux-next specific files for 20240402

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202404021504.YTP51bL3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404021556.0JVcNC13-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404021638.QKhbdQ4E-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404021700.LbyYZGFd-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404022106.mYwpypit-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "__drm_atomic_helper_private_obj_duplicate_state" [drivers/gpu/drm/display/drm_display_helper.ko] undefined!
ERROR: modpost: "drm_kms_helper_hotplug_event" [drivers/gpu/drm/display/drm_display_helper.ko] undefined!
arch/csky/include/asm/cmpxchg.h:138:25: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
arch/csky/include/asm/cmpxchg.h:141:25: error: implicit declaration of function 'cmpxchg_emu_u16' [-Werror=implicit-function-declaration]
arch/riscv/include/asm/cmpxchg.h:329:23: warning: assignment to 'const struct gre_protocol *' from 'uintptr_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
arch/riscv/include/asm/cmpxchg.h:329:23: warning: assignment to 'struct bdi_writeback *' from 'uintptr_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
arch/riscv/include/asm/cmpxchg.h:329:23: warning: assignment to 'struct rtrs_clt_path *' from 'uintptr_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
arch/riscv/include/asm/cmpxchg.h:329:23: warning: assignment to 'struct tty_struct *' from 'uintptr_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
arch/riscv/include/asm/cmpxchg.h:329:23: warning: assignment to 'z_erofs_next_pcluster_t' {aka 'void *'} from 'uintptr_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
cfi_probe.c:(.xiptext+0xdb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc_noprof
cfi_util.c:(.xiptext+0x40b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc_noprof
drivers/gpu/drm/display/drm_dp_mst_topology.c:5074:(.text+0x4da0): undefined reference to `drm_kms_helper_hotplug_event'
drivers/gpu/drm/display/drm_dp_mst_topology.c:5088:(.text+0x40a8): undefined reference to `__drm_atomic_helper_private_obj_duplicate_state'
drivers/gpu/drm/lima/lima_drv.c:387:13: error: cast to smaller integer type 'enum lima_gpu_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
drivers/gpu/drm/panthor/panthor_sched.c:2048:6: error: variable 'csg_mod_mask' set but not used [-Werror,-Wunused-but-set-variable]
drivers/gpu/drm/pl111/pl111_versatile.c:488:24: error: cast to smaller integer type 'enum versatile_clcd' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set but not used [-Werror,-Wunused-but-set-variable]
drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: error: variable 'num_relocs' set but not used [-Werror,-Wunused-but-set-variable]
drivers/s390/char/hmcdrv_cache.c:221:13: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
drivers/s390/char/hmcdrv_cache.c:221:13: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
drivers/s390/char/hmcdrv_cache.c:221:13: error: non-extern declaration of '__pcpu_unique__alloc_tag_cntr' follows extern declaration
drivers/s390/char/hmcdrv_ftp.c:196:21: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
drivers/s390/char/hmcdrv_ftp.c:196:21: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
drivers/s390/char/hmcdrv_ftp.c:196:21: error: non-extern declaration of '__pcpu_unique__alloc_tag_cntr' follows extern declaration
drivers/s390/char/hmcdrv_ftp.c:196:21: error: non-extern declaration of '_alloc_tag_cntr' follows extern declaration
drivers/s390/char/hmcdrv_ftp.c:196:21: error: weak declaration cannot have internal linkage
drm_dp_helper.c:(.text+0x36e8): undefined reference to `devm_backlight_device_register'
drm_dp_mst_topology.c:(.text+0x350c): undefined reference to `__drm_atomic_helper_private_obj_duplicate_state'
drm_dp_mst_topology.c:(.text+0x3f00): undefined reference to `drm_kms_helper_hotplug_event'
include/asm-generic/io.h:547:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
include/linux/alloc_tag.h:43:2: error: "Memory allocation profiling is incompatible with ARCH_NEEDS_WEAK_PER_CPU"
include/linux/gfp.h:295:9: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/gfp.h:295:9: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/gfp.h:295:9: error: non-extern declaration of '__pcpu_unique__alloc_tag_cntr' follows extern declaration
include/linux/gfp.h:295:9: error: non-extern declaration of '_alloc_tag_cntr' follows extern declaration
include/linux/gfp.h:295:9: error: weak declaration cannot have internal linkage
include/linux/mm.h:2862:22: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/mm.h:2862:22: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/mm.h:2862:22: error: non-extern declaration of '__pcpu_unique__alloc_tag_cntr' follows extern declaration
include/linux/mm.h:2862:22: error: non-extern declaration of '_alloc_tag_cntr' follows extern declaration
include/linux/mm.h:2862:22: error: weak declaration cannot have internal linkage
include/linux/pagemap.h:558:10: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/pagemap.h:558:10: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/pagemap.h:558:10: error: non-extern declaration of '__pcpu_unique__alloc_tag_cntr' follows extern declaration
ld.lld: error: undefined symbol: __drm_atomic_helper_private_obj_duplicate_state
ld.lld: error: undefined symbol: drm_kms_helper_hotplug_event
lib/test_lockup.c:310:10: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
lib/test_lockup.c:310:10: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
lib/test_lockup.c:310:10: error: non-extern declaration of '__pcpu_unique__alloc_tag_cntr' follows extern declaration

Unverified Error/Warning (likely false positive, please contact us if interested):

WARNING: modpost: "strcpy" [net/core/net_test.ko] has no CRC!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- alpha-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- alpha-randconfig-r012-20220524
|   `-- WARNING:modpost:strcpy-net-core-net_test.ko-has-no-CRC
|-- alpha-randconfig-r051-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-hisi_defconfig
|   |-- drm_dp_mst_topology.c:(.text):undefined-reference-to-__drm_atomic_helper_private_obj_duplicate_state
|   `-- drm_dp_mst_topology.c:(.text):undefined-reference-to-drm_kms_helper_hotplug_event
|-- arm-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-r062-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-004-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-r051-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-r133-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-randconfig-r012-20230202
|   |-- arch-csky-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-csky-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- i386-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-011-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-015-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-016-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-051-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-053-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-062-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-141-20240402
|   |-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:maybe-return-EFAULT-instead-of-the-bytes-remaining
|   |-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:possible-spectre-second-half.-pwm
|   |-- drivers-pwm-core.c-pwm_cdev_ioctl()-warn:potential-spectre-issue-cdata-pwm-r
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-allmodconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-m5272c3_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-mac_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-randconfig-r006-20220328
|   `-- drm_dp_helper.c:(.text):undefined-reference-to-devm_backlight_device_register
|-- m68k-randconfig-r054-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- microblaze-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- microblaze-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-cavium_octeon_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-cu1830-neo_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-loongson2k_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-allmodconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-randconfig-r052-20240402
|   |-- drivers-firmware-arm_scmi-raw_mode.c:WARNING:scmi_dbg_raw_mode_reset_fops:write()-has-stream-semantic-safe-to-change-nonseekable_open-stream_open.
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-randconfig-r063-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- openrisc-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- openrisc-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- openrisc-or1klitex_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-amigaone_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-mpc5200_defconfig
|   |-- drivers-gpu-drm-display-drm_dp_mst_topology.c:(.text):undefined-reference-to-__drm_atomic_helper_private_obj_duplicate_state
|   `-- drivers-gpu-drm-display-drm_dp_mst_topology.c:(.text):undefined-reference-to-drm_kms_helper_hotplug_event
|-- powerpc-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-randconfig-r132-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-sam440ep_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-stx_gp3_defconfig
|   |-- ERROR:__drm_atomic_helper_private_obj_duplicate_state-drivers-gpu-drm-display-drm_display_helper.ko-undefined
|   `-- ERROR:drm_kms_helper_hotplug_event-drivers-gpu-drm-display-drm_display_helper.ko-undefined
|-- powerpc64-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc64-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc64-randconfig-003-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-randconfig-r011-20230105
|   `-- arch-riscv-include-asm-cmpxchg.h:warning:assignment-to-struct-bdi_writeback-from-uintptr_t-aka-long-unsigned-int-makes-pointer-from-integer-without-a-cast
|-- riscv-randconfig-r036-20230619
|   |-- arch-riscv-include-asm-cmpxchg.h:warning:assignment-to-const-struct-gre_protocol-from-uintptr_t-aka-long-unsigned-int-makes-pointer-from-integer-without-a-cast
|   |-- arch-riscv-include-asm-cmpxchg.h:warning:assignment-to-struct-rtrs_clt_path-from-uintptr_t-aka-long-unsigned-int-makes-pointer-from-integer-without-a-cast
|   `-- arch-riscv-include-asm-cmpxchg.h:warning:assignment-to-z_erofs_next_pcluster_t-aka-void-from-uintptr_t-aka-long-unsigned-int-makes-pointer-from-integer-without-a-cast
|-- riscv-randconfig-r061-20240402
|   `-- arch-riscv-include-asm-cmpxchg.h:warning:assignment-to-struct-tty_struct-from-uintptr_t-aka-long-unsigned-int-makes-pointer-from-integer-without-a-cast
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-randconfig-002-20240402
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-randconfig-r064-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-randconfig-r113-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-randconfig-r131-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-i386_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-003-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-005-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-006-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-011-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-012-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-014-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-016-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-074-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-123-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-161-20240402
|   |-- drivers-usb-dwc2-hcd_ddma.c-dwc2_cmpl_host_isoc_dma_desc()-warn:variable-dereferenced-before-check-qtd-urb-(see-line-)
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- xtensa-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- xtensa-buildonly-randconfig-r002-20220225
|   |-- cfi_probe.c:(.xiptext):dangerous-relocation:windowed-longcall-crosses-1GB-boundary-return-may-fail:__kmalloc_noprof
|   `-- cfi_util.c:(.xiptext):dangerous-relocation:windowed-longcall-crosses-1GB-boundary-return-may-fail:__kmalloc_noprof
|-- xtensa-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
`-- xtensa-virt_defconfig
    |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
    `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
clang_recent_errors
|-- arm-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-aspeed_g4_defconfig
|   |-- ld.lld:error:undefined-symbol:__drm_atomic_helper_private_obj_duplicate_state
|   |-- ld.lld:error:undefined-symbol:drm_kms_helper_hotplug_event
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-003-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-004-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-r123-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-003-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-r112-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-r121-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-allmodconfig
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-allyesconfig
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-randconfig-r062-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-randconfig-r111-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-003-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-004-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-005-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-006-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-003-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-004-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-005-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-006-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-012-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-013-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-014-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-052-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-054-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-061-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-063-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-randconfig-r053-20240402
|   |-- drivers-firmware-arm_scmi-raw_mode.c:WARNING:scmi_dbg_raw_mode_reset_fops:write()-has-stream-semantic-safe-to-change-nonseekable_open-stream_open.
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-bios-shadowof.c:error:cast-from-void-(-)(const-void-)-to-void-(-)(void-)-converts-to-incompatible-function-type-Werror-Wcast-function-type-strict
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-chrp32_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-maple_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-mpc5200_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-sequoia_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-randconfig-002-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-qxl-qxl_cmd.c:error:variable-count-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-qxl-qxl_ioctl.c:error:variable-num_relocs-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-randconfig-002-20240328
|   |-- drivers-s390-char-hmcdrv_cache.c:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- drivers-s390-char-hmcdrv_cache.c:error:non-extern-declaration-of-__pcpu_unique__alloc_tag_cntr-follows-extern-declaration
|   |-- drivers-s390-char-hmcdrv_cache.c:error:section-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- drivers-s390-char-hmcdrv_ftp.c:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- drivers-s390-char-hmcdrv_ftp.c:error:non-extern-declaration-of-__pcpu_unique__alloc_tag_cntr-follows-extern-declaration
|   |-- drivers-s390-char-hmcdrv_ftp.c:error:non-extern-declaration-of-_alloc_tag_cntr-follows-extern-declaration
|   |-- drivers-s390-char-hmcdrv_ftp.c:error:section-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- drivers-s390-char-hmcdrv_ftp.c:error:weak-declaration-cannot-have-internal-linkage
|   |-- include-linux-alloc_tag.h:error:Memory-allocation-profiling-is-incompatible-with-ARCH_NEEDS_WEAK_PER_CPU
|   |-- include-linux-gfp.h:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-linux-gfp.h:error:non-extern-declaration-of-__pcpu_unique__alloc_tag_cntr-follows-extern-declaration
|   |-- include-linux-gfp.h:error:non-extern-declaration-of-_alloc_tag_cntr-follows-extern-declaration
|   |-- include-linux-gfp.h:error:section-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-linux-gfp.h:error:weak-declaration-cannot-have-internal-linkage
|   |-- include-linux-mm.h:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-linux-mm.h:error:non-extern-declaration-of-__pcpu_unique__alloc_tag_cntr-follows-extern-declaration
|   |-- include-linux-mm.h:error:non-extern-declaration-of-_alloc_tag_cntr-follows-extern-declaration
|   |-- include-linux-mm.h:error:section-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-linux-mm.h:error:weak-declaration-cannot-have-internal-linkage
|   |-- include-linux-pagemap.h:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-linux-pagemap.h:error:non-extern-declaration-of-__pcpu_unique__alloc_tag_cntr-follows-extern-declaration
|   |-- include-linux-pagemap.h:error:section-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- lib-test_lockup.c:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- lib-test_lockup.c:error:non-extern-declaration-of-__pcpu_unique__alloc_tag_cntr-follows-extern-declaration
|   `-- lib-test_lockup.c:error:section-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|-- um-allmodconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-randconfig-r061-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-x86_64_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-allmodconfig
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-buildonly-randconfig-001-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-004-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-013-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-015-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-071-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-072-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-073-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-075-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-076-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-101-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-102-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-103-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-104-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-121-20240402
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
`-- x86_64-randconfig-122-20240402
    |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
    `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node

elapsed time: 1204m

configs tested: 180
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240402   gcc  
arc                   randconfig-002-20240402   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240402   gcc  
arm                   randconfig-002-20240402   clang
arm                   randconfig-003-20240402   clang
arm                   randconfig-004-20240402   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240402   clang
arm64                 randconfig-002-20240402   clang
arm64                 randconfig-003-20240402   clang
arm64                 randconfig-004-20240402   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240402   gcc  
csky                  randconfig-002-20240402   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240402   clang
hexagon               randconfig-002-20240402   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240402   gcc  
i386         buildonly-randconfig-002-20240402   gcc  
i386         buildonly-randconfig-003-20240402   clang
i386         buildonly-randconfig-004-20240402   clang
i386         buildonly-randconfig-005-20240402   clang
i386         buildonly-randconfig-006-20240402   clang
i386                                defconfig   clang
i386                  randconfig-001-20240402   gcc  
i386                  randconfig-002-20240402   clang
i386                  randconfig-003-20240402   clang
i386                  randconfig-004-20240402   clang
i386                  randconfig-005-20240402   clang
i386                  randconfig-006-20240402   clang
i386                  randconfig-011-20240402   gcc  
i386                  randconfig-012-20240402   clang
i386                  randconfig-013-20240402   clang
i386                  randconfig-014-20240402   clang
i386                  randconfig-015-20240402   gcc  
i386                  randconfig-016-20240402   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240402   gcc  
loongarch             randconfig-002-20240402   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240402   gcc  
nios2                 randconfig-002-20240402   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240402   gcc  
parisc                randconfig-002-20240402   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      chrp32_defconfig   clang
powerpc                       maple_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc               randconfig-001-20240402   clang
powerpc               randconfig-002-20240402   gcc  
powerpc               randconfig-003-20240402   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     sequoia_defconfig   clang
powerpc64             randconfig-001-20240402   gcc  
powerpc64             randconfig-002-20240402   gcc  
powerpc64             randconfig-003-20240402   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240402   clang
riscv                 randconfig-002-20240402   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240402   gcc  
s390                  randconfig-002-20240402   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                    randconfig-001-20240402   gcc  
sh                    randconfig-002-20240402   gcc  
sh                           se7206_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240402   gcc  
sparc64               randconfig-002-20240402   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240402   gcc  
um                    randconfig-002-20240402   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240402   clang
x86_64       buildonly-randconfig-002-20240402   clang
x86_64       buildonly-randconfig-003-20240402   clang
x86_64       buildonly-randconfig-004-20240402   clang
x86_64       buildonly-randconfig-005-20240402   clang
x86_64       buildonly-randconfig-006-20240402   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240402   clang
x86_64                randconfig-002-20240402   clang
x86_64                randconfig-003-20240402   gcc  
x86_64                randconfig-004-20240402   clang
x86_64                randconfig-005-20240402   gcc  
x86_64                randconfig-006-20240402   gcc  
x86_64                randconfig-011-20240402   gcc  
x86_64                randconfig-012-20240402   gcc  
x86_64                randconfig-013-20240402   clang
x86_64                randconfig-014-20240402   gcc  
x86_64                randconfig-015-20240402   clang
x86_64                randconfig-016-20240402   gcc  
x86_64                randconfig-071-20240402   clang
x86_64                randconfig-072-20240402   clang
x86_64                randconfig-073-20240402   clang
x86_64                randconfig-074-20240402   gcc  
x86_64                randconfig-075-20240402   clang
x86_64                randconfig-076-20240402   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240402   gcc  
xtensa                randconfig-002-20240402   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fsdevel+bounces-14743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9687EB1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1DE1C20FBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BC4E1C8;
	Mon, 18 Mar 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzE5Fdln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92F1E48A;
	Mon, 18 Mar 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772452; cv=none; b=BuYMEzxFo2FoMgNrmqEQw42DPmELS/mR8r4qISy+YFx9Z9tE9LI7NE3Y7nPKjhD9ltG7X4s0wLDIpKF18l4E6pBrcjCBFHi8eeT3kbT+oJUc7W+Ksn1rbULiz8aTOVTy6FY05twVkf43UYuBvOqR7+bqP3sBolCbGCN39MQOFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772452; c=relaxed/simple;
	bh=MOxrcp8dNBjE239ED4v6NC3w2CWiNwiSbQh9zF+bW5g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PduClR1NdXtLt2gaMstV6JEKGBndDddfFoJz8AfthFtVM0EvUD7KtwmZ+QGhlJ9sn5zpDiXFvfffO1cl5oktzdmlQesq0MDxV97k7EgQt7NAdxa1ari7Q/qPwDhJEODX8RSVbJAP1QOwOGVaE40Wv58gnYm8haBwMdn4sv1cv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzE5Fdln; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710772450; x=1742308450;
  h=date:from:to:cc:subject:message-id;
  bh=MOxrcp8dNBjE239ED4v6NC3w2CWiNwiSbQh9zF+bW5g=;
  b=nzE5Fdlna8x/+bN8nSM0Sx5T1tTgjjJPa1mKqCN6J+7gRHNxcR2mMi+G
   geqpPMcWUVUM3iOs7fJZS7uxYLjlPMwpChxMy3uzG9Bpo412uFwZ85Eyg
   YbA778P/jDQBFWFKeeyFPOpxmcjHS4RvhqY/YPu2svLqgMbgeO9D6JtMS
   kfdNfWUYAafSNkfRmtkNazMrUx7i6j1qvpUmjBC0L0rUZZ43mviIDtoNm
   GPfM1byow4VMgIMe5KeasPe5hEX3IMPyEtzzzACTGaJp4LYaUmBivbK09
   EgqdeBmh6X6iSgDI/5KqDCJMrL+eeWzokQAv5Lm4IJHbW4ZZzPUN+ODyr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="9360744"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="9360744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 07:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13960516"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Mar 2024 07:34:05 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmE3u-000H1A-16;
	Mon, 18 Mar 2024 14:34:02 +0000
Date: Mon, 18 Mar 2024 22:33:25 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
 netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 2e93f143ca010a5013528e1cfdc895f024fe8c21
Message-ID: <202403182219.XrvfZx4s-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 2e93f143ca010a5013528e1cfdc895f024fe8c21  Add linux-next specific files for 20240318

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- arc-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- arm-allmodconfig
|   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- arm-allyesconfig
|   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- arm64-defconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-randconfig-001-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-randconfig-004-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-randconfig-011-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-randconfig-141-20240318
|   `-- fs-exfat-dir.c-__exfat_get_dentry_set()-warn:missing-unwind-goto
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- m68k-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- m68k-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- mips-allyesconfig
|   |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
|   |-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- nios2-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- nios2-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- openrisc-allyesconfig
|   |-- (.head.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-no-symbol
|   |-- (.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-no-symbol
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- main.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-symbol-__muldi3-defined-in-.text-section-in-..-lib-gcc-or1k-linux-..-libgcc.a(_muldi3.o)
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- parisc-randconfig-001-20240318
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- parisc-randconfig-r113-20240318
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- powerpc-randconfig-002-20240318
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- powerpc64-randconfig-002-20240318
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- powerpc64-randconfig-003-20240318
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- riscv-randconfig-001-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sh-sdk7786_defconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc-randconfig-001-20240318
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   `-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|-- sparc-randconfig-002-20240318
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   `-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc64-randconfig-001-20240318
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- sparc64-randconfig-002-20240318
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc64-randconfig-r131-20240318
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-002-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-buildonly-randconfig-003-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-buildonly-randconfig-005-20240318
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-072-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-randconfig-073-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-randconfig-076-20240318
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
`-- x86_64-randconfig-161-20240318
    |-- drivers-pinctrl-pinctrl-aw9523.c-aw9523_gpio_get_multiple()-error:uninitialized-symbol-ret-.
    `-- drivers-pinctrl-pinctrl-aw9523.c-aw9523_pconf_set()-error:uninitialized-symbol-rc-.
clang_recent_errors
|-- arm-defconfig
|   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- arm-randconfig-002-20240318
|   `-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|-- arm-randconfig-003-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- hexagon-randconfig-r121-20240318
|   |-- fs-libfs.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- mips-randconfig-r111-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- powerpc-allyesconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- powerpc-randconfig-001-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- riscv-allmodconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- riscv-allyesconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- s390-defconfig
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- x86_64-randconfig-002-20240318
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
`-- x86_64-randconfig-074-20240318
    `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead

elapsed time: 729m

configs tested: 179
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240318   gcc  
arc                   randconfig-002-20240318   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           omap1_defconfig   gcc  
arm                   randconfig-001-20240318   clang
arm                   randconfig-002-20240318   clang
arm                   randconfig-003-20240318   clang
arm                   randconfig-004-20240318   gcc  
arm                         s5pv210_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240318   gcc  
arm64                 randconfig-002-20240318   gcc  
arm64                 randconfig-003-20240318   clang
arm64                 randconfig-004-20240318   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240318   gcc  
csky                  randconfig-002-20240318   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240318   clang
hexagon               randconfig-002-20240318   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240318   gcc  
i386         buildonly-randconfig-002-20240318   clang
i386         buildonly-randconfig-003-20240318   clang
i386         buildonly-randconfig-004-20240318   clang
i386         buildonly-randconfig-005-20240318   gcc  
i386         buildonly-randconfig-006-20240318   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240318   gcc  
i386                  randconfig-002-20240318   clang
i386                  randconfig-003-20240318   gcc  
i386                  randconfig-004-20240318   gcc  
i386                  randconfig-005-20240318   gcc  
i386                  randconfig-006-20240318   gcc  
i386                  randconfig-011-20240318   gcc  
i386                  randconfig-012-20240318   clang
i386                  randconfig-013-20240318   clang
i386                  randconfig-014-20240318   clang
i386                  randconfig-015-20240318   clang
i386                  randconfig-016-20240318   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240318   gcc  
loongarch             randconfig-002-20240318   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   clang
mips                       bmips_be_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240318   gcc  
nios2                 randconfig-002-20240318   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240318   gcc  
parisc                randconfig-002-20240318   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   motionpro_defconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240318   clang
powerpc               randconfig-002-20240318   gcc  
powerpc               randconfig-003-20240318   clang
powerpc                     redwood_defconfig   clang
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240318   clang
powerpc64             randconfig-002-20240318   gcc  
powerpc64             randconfig-003-20240318   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240318   gcc  
riscv                 randconfig-002-20240318   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240318   clang
s390                  randconfig-002-20240318   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240318   gcc  
sh                    randconfig-002-20240318   gcc  
sh                          sdk7786_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240318   gcc  
sparc64               randconfig-002-20240318   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240318   gcc  
um                    randconfig-002-20240318   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240318   gcc  
x86_64       buildonly-randconfig-002-20240318   gcc  
x86_64       buildonly-randconfig-003-20240318   gcc  
x86_64       buildonly-randconfig-004-20240318   gcc  
x86_64       buildonly-randconfig-005-20240318   gcc  
x86_64       buildonly-randconfig-006-20240318   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240318   gcc  
x86_64                randconfig-002-20240318   clang
x86_64                randconfig-003-20240318   clang
x86_64                randconfig-004-20240318   clang
x86_64                randconfig-005-20240318   clang
x86_64                randconfig-006-20240318   gcc  
x86_64                randconfig-011-20240318   clang
x86_64                randconfig-012-20240318   clang
x86_64                randconfig-013-20240318   gcc  
x86_64                randconfig-014-20240318   gcc  
x86_64                randconfig-015-20240318   clang
x86_64                randconfig-016-20240318   gcc  
x86_64                randconfig-071-20240318   gcc  
x86_64                randconfig-072-20240318   gcc  
x86_64                randconfig-073-20240318   gcc  
x86_64                randconfig-074-20240318   clang
x86_64                randconfig-075-20240318   gcc  
x86_64                randconfig-076-20240318   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240318   gcc  
xtensa                randconfig-002-20240318   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


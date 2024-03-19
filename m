Return-Path: <linux-fsdevel+bounces-14813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E3987FFEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A869FB2357E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3048651B3;
	Tue, 19 Mar 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m37FHjxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF2D2F5;
	Tue, 19 Mar 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859849; cv=none; b=W4Tfcg7hqRFo5WL4K5xKH06bdN/BFyj4/g6SP7Qdl1Bqc7hT99Tb9GSiiRdLy89z7Momm39x9+68kmlc9xEiD8WySeP6+ADu3eLy0nYU85L2K43t4CeEhOHmpxTPuwfHOxwyNYyX54/DYPI8zdC3oCos4TSAXybYDGfpVgxa4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859849; c=relaxed/simple;
	bh=4P3Vr+dmIZy2ewXhfikDzX4XHklTqvlfspDJd7ZuTYM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LoR/v2ssm/1R7BXvJ35MskzAbsYxNwey0Oi4UkyRzC62bXoYYx8vd6RCM6O46Bj3T+LVraNPBTYzowcCwtfZvP5oG3axLumAx5ckpXtyrJKK8EvWeByOSzxBxP9Ty0XInw9kt+dMMBdd2esV2KZqYOpXmdwwRamToFu56C7P3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m37FHjxI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710859847; x=1742395847;
  h=date:from:to:cc:subject:message-id;
  bh=4P3Vr+dmIZy2ewXhfikDzX4XHklTqvlfspDJd7ZuTYM=;
  b=m37FHjxINeZQ3UgDy4ArS/17yf1pMH6fvpKjB/tmdK1h0/s/81Z24fH8
   oCX05bJxG10ghSUb6jd3mVbKE8Ugt6xlre0ZZDAf0Vg4+ZdCHZH/4yTZb
   VTq0dnvvtxJkVESRFW0M58DXF0vhE2Pd5GDUjAHhYRXkopNz79h/bZTA9
   lRCy6O4yWGOK2AP1hAW/gW4XqALqNpRpfEUrhYBkWXLd1sJsRaZoy7ZJs
   IqN6aM9SCrZ1LaSHwbZetriwiHclPx/2FbGbzk3sn2jcpTJUHWAURy6gz
   6JeTiZMGcbxiSiuvZdGaPSb4iFXdVC7+lKegPzVych58SFe0spzCE1uAP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16465449"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="16465449"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 07:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="14220684"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Mar 2024 07:50:40 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmanU-000Hpt-0K;
	Tue, 19 Mar 2024 14:50:36 +0000
Date: Tue, 19 Mar 2024 22:49:57 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 intel-xe@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 226d3c72fcde130a99d760895ebdd20e78e02cb5
Message-ID: <202403192251.b8370mLE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 226d3c72fcde130a99d760895ebdd20e78e02cb5  Add linux-next specific files for 20240319

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
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
|-- arm-omap2plus_defconfig
|   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- arm-randconfig-r062-20240319
|   `-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|-- arm64-defconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-buildonly-randconfig-005-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-randconfig-011-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-randconfig-062-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- loongarch-randconfig-002-20240319
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- loongarch-randconfig-r051-20240319
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
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
|-- parisc-randconfig-002-20240319
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- powerpc-randconfig-001-20240319
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sh-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sh-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc-randconfig-001-20240319
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- sparc-randconfig-002-20240319
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- um-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- um-randconfig-r122-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-randconfig-014-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-randconfig-071-20240319
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
`-- x86_64-randconfig-161-20240319
    |-- drivers-mtd-devices-mchp48l640.c-mchp48l640_read_page()-warn:Please-consider-using-kzalloc-instead-of-kmalloc
    |-- drivers-mtd-devices-mchp48l640.c-mchp48l640_write_page()-warn:Please-consider-using-kzalloc-instead-of-kmalloc
    |-- drivers-usb-dwc2-hcd.c-dwc2_alloc_split_dma_aligned_buf()-warn:Please-consider-using-kmem_cache_zalloc-instead-of-kmem_cache_alloc
    |-- drivers-usb-typec-tcpm-tcpm.c-tcpm_pd_svdm()-error:uninitialized-symbol-modep_prime-.
    |-- fs-exfat-dir.c-__exfat_get_dentry_set()-warn:missing-unwind-goto
    |-- mm-userfaultfd.c-mfill_atomic()-warn:inconsistent-returns-ctx-map_changing_lock-.
    `-- mm-userfaultfd.c-uffd_move_lock()-error:we-previously-assumed-src_vmap-could-be-null-(see-line-)
clang_recent_errors
|-- arm-defconfig
|   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- arm-randconfig-003-20240319
|   `-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
|-- arm-randconfig-r111-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- arm64-allmodconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- hexagon-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- hexagon-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- hexagon-randconfig-r053-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-buildonly-randconfig-002-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-randconfig-002-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- i386-randconfig-061-20240319
|   |-- drivers-gpu-drm-xe-xe_hw_engine_class_sysfs.c:error:unused-function-pdev_to_xe_device-Werror-Wunused-function
|   `-- drivers-gpu-drm-xe-xe_hw_engine_class_sysfs.c:error:unused-function-to_xe_device-Werror-Wunused-function
|-- i386-randconfig-141-20240319
|   `-- fs-exfat-dir.c-__exfat_get_dentry_set()-warn:missing-unwind-goto
|-- powerpc-allyesconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- powerpc-randconfig-002-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- powerpc64-randconfig-r123-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- riscv-allmodconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- riscv-allyesconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- s390-allmodconfig
|   |-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- s390-defconfig
|   `-- kernel-bpf-bpf_struct_ops.c:warning:bitwise-operation-between-different-enumeration-types-(-enum-bpf_type_flag-and-enum-bpf_reg_type-)
|-- x86_64-allmodconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-allyesconfig
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-buildonly-randconfig-001-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-randconfig-003-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
|-- x86_64-randconfig-072-20240319
|   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
`-- x86_64-randconfig-121-20240319
    `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead

elapsed time: 724m

configs tested: 177
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240319   gcc  
arc                   randconfig-002-20240319   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       multi_v4t_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240319   clang
arm                   randconfig-002-20240319   gcc  
arm                   randconfig-003-20240319   clang
arm                   randconfig-004-20240319   clang
arm                        realview_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240319   gcc  
arm64                 randconfig-002-20240319   clang
arm64                 randconfig-003-20240319   clang
arm64                 randconfig-004-20240319   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240319   gcc  
csky                  randconfig-002-20240319   gcc  
hexagon                          alldefconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240319   clang
hexagon               randconfig-002-20240319   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240319   clang
i386         buildonly-randconfig-002-20240319   clang
i386         buildonly-randconfig-003-20240319   clang
i386         buildonly-randconfig-004-20240319   clang
i386         buildonly-randconfig-005-20240319   gcc  
i386         buildonly-randconfig-006-20240319   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240319   clang
i386                  randconfig-002-20240319   clang
i386                  randconfig-003-20240319   clang
i386                  randconfig-004-20240319   clang
i386                  randconfig-005-20240319   clang
i386                  randconfig-006-20240319   gcc  
i386                  randconfig-011-20240319   gcc  
i386                  randconfig-012-20240319   clang
i386                  randconfig-013-20240319   gcc  
i386                  randconfig-014-20240319   clang
i386                  randconfig-015-20240319   clang
i386                  randconfig-016-20240319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240319   gcc  
loongarch             randconfig-002-20240319   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                  decstation_64_defconfig   gcc  
mips                            gpr_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240319   gcc  
nios2                 randconfig-002-20240319   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240319   gcc  
parisc                randconfig-002-20240319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240319   gcc  
powerpc               randconfig-002-20240319   clang
powerpc               randconfig-003-20240319   clang
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240319   gcc  
powerpc64             randconfig-002-20240319   clang
powerpc64             randconfig-003-20240319   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240319   gcc  
riscv                 randconfig-002-20240319   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240319   gcc  
s390                  randconfig-002-20240319   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240319   gcc  
sh                    randconfig-002-20240319   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240319   gcc  
sparc64               randconfig-002-20240319   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240319   gcc  
um                    randconfig-002-20240319   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240319   clang
x86_64       buildonly-randconfig-002-20240319   clang
x86_64       buildonly-randconfig-003-20240319   clang
x86_64       buildonly-randconfig-004-20240319   clang
x86_64       buildonly-randconfig-005-20240319   clang
x86_64       buildonly-randconfig-006-20240319   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240319   clang
x86_64                randconfig-002-20240319   clang
x86_64                randconfig-003-20240319   clang
x86_64                randconfig-004-20240319   gcc  
x86_64                randconfig-005-20240319   gcc  
x86_64                randconfig-006-20240319   gcc  
x86_64                randconfig-011-20240319   clang
x86_64                randconfig-012-20240319   clang
x86_64                randconfig-013-20240319   gcc  
x86_64                randconfig-014-20240319   gcc  
x86_64                randconfig-015-20240319   clang
x86_64                randconfig-016-20240319   clang
x86_64                randconfig-071-20240319   gcc  
x86_64                randconfig-072-20240319   clang
x86_64                randconfig-073-20240319   gcc  
x86_64                randconfig-074-20240319   clang
x86_64                randconfig-075-20240319   clang
x86_64                randconfig-076-20240319   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240319   gcc  
xtensa                randconfig-002-20240319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


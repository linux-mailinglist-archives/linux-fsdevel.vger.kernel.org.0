Return-Path: <linux-fsdevel+bounces-19127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767998C058E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 22:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA0F1F22E9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC6131198;
	Wed,  8 May 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANyJqN9c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C42130AC1;
	Wed,  8 May 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199564; cv=none; b=cWoJfDfZYgf8e6+A2tZf70zhrG8t9YnINv6nYpSz7QKKmrcdG5Kv2DZ2uprwUbPhQfQK7oxVqJoDRjT8vYIZF4QlXpwhGw8VpRwbzv8XYVaeP8T+3b/6Z4NE/kbmgYDJuhaxg+3mhYgZeGU3Iydlr7rbhmAGPtlOC0H3h6nzmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199564; c=relaxed/simple;
	bh=x5m+Bxi2uHmpbeuLRqTaxQJMyfC2uinkFDmq4CoGi18=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ku7rC6d1vANkPcSIkExOk4lYPfvJnXGoL1oOHs2EHLQYwcWUdFxvIrkiJIBcHPPTLMH6fYz1T3I5llUeIPhE+zr47K69m0E1Lot+FRiwYlVKR2yu0okSO9EO8RDHpfcsrlKPaXoPANOso7D6QEoQvj6Q8DoZFcOYrlbOF+vk9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANyJqN9c; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715199558; x=1746735558;
  h=date:from:to:cc:subject:message-id;
  bh=x5m+Bxi2uHmpbeuLRqTaxQJMyfC2uinkFDmq4CoGi18=;
  b=ANyJqN9cS1ouINoXLYQTYeBjYPsUkS0g4a1f1ZavBlH0fDVXakqh8K62
   Sdzvm9Tkt4hAQ3DkZs0DaZPtZJFCkbB/pmB1AaTbV26w9ifh/6uOaYxcb
   spLSytXULzwlj0353dlk/CWQI9aK41fBFYK3u+4b1dMSg1Qg+RrTJ/yBj
   u8rVM6wHJapb7U4IsBkf/XcQgpJS82URI8pFU4v64oQM4omQ8qLGO5Mcn
   YfFFLmJnD204ikGmjawC3yAEN2BO7gyMwc/z+KqIlgdUmZeDm9ElHEwSw
   5dInL+2+eTL4ygYedEV9Fj7heO0n0RBHs6t5aK7AugZMqAJ7SgkgeBSav
   A==;
X-CSE-ConnectionGUID: 121xmquKRQeUZOUW60ZzhQ==
X-CSE-MsgGUID: 9l427FNfSkWhlZH2ZjgoZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14034707"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14034707"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 13:19:13 -0700
X-CSE-ConnectionGUID: QmWksXvVRV+N85TH6JxZgQ==
X-CSE-MsgGUID: VxK5iFmcTkCGBBt4PW2aDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33518006"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 May 2024 13:19:04 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4nkl-00044q-1H;
	Wed, 08 May 2024 20:19:03 +0000
Date: Thu, 09 May 2024 04:18:09 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-bcachefs@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: [linux-next:master] BUILD REGRESSION
 e7b4ef8fffaca247809337bb78daceb406659f2d
Message-ID: <202405090459.KTjp30CK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: e7b4ef8fffaca247809337bb78daceb406659f2d  Add linux-next specific files for 20240508

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405081723.DMgbeqcp-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405081726.OX8xkyJA-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405081838.tuETPvPf-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405081922.Kqo84cI8-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405082029.Es9umH7n-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405082039.0al6Fpg8-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405082200.tBrEs5CZ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405082221.43rfWxz5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202405082259.44DzHvaN-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

(.text+0x390): undefined reference to `mpfs_reset_controller_register'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:320:(.text+0x570): undefined reference to `kunit_binary_assert_format'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:322:(.text+0x658): undefined reference to `kunit_mem_assert_format'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:58:(.text+0x370): undefined reference to `kunit_binary_ptr_assert_format'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:58:(.text+0x380): undefined reference to `__kunit_do_failed_assertion'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:58:(.text+0x388): undefined reference to `__kunit_abort'
aarch64-linux-ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:77:(.text+0x44c): undefined reference to `kunit_unary_assert_format'
alpha-linux-ld: (.text+0x39c): undefined reference to `mpfs_reset_controller_register'
arc-elf-ld: clk-mpfs.c:(.text+0x20e): undefined reference to `mpfs_reset_controller_register'
arch/arm64/include/asm/pgtable.h:1102:16: error: implicit declaration of function 'pud_valid'; did you mean 'pmd_valid'? [-Werror=implicit-function-declaration]
clk-mpfs.c:(.text+0x284): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `mpfs_reset_controller_register'
csky-linux-ld: panel-lg-sw43408.c:(.text+0x2f8): undefined reference to `drm_dsc_pps_payload_pack'
drivers/bluetooth/btintel.h:373:13: warning: 'btintel_hw_error' defined but not used [-Wunused-function]
drivers/gpu/drm/xlnx/zynqmp_disp.c:984:14: error: logical not is only applied to the left hand side of this comparison [-Werror,-Wlogical-not-parentheses]
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:320:(.text+0x568): relocation truncated to fit: R_AARCH64_ADR_PREL_PG_HI21 against undefined symbol `kunit_binary_assert_format'
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:320:(.text+0x568): undefined reference to `kunit_binary_assert_format'
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:58:(.text+0x368): relocation truncated to fit: R_AARCH64_ADR_PREL_PG_HI21 against undefined symbol `kunit_binary_ptr_assert_format'
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:58:(.text+0x368): undefined reference to `kunit_binary_ptr_assert_format'
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:58:(.text+0x380): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__kunit_do_failed_assertion'
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:58:(.text+0x388): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__kunit_abort'
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c:77:(.text+0x44c): relocation truncated to fit: R_AARCH64_ADR_PREL_PG_HI21 against undefined symbol `kunit_unary_assert_format'
fs/coredump.c:67:27: warning: 'core_file_note_size_min' defined but not used [-Wunused-const-variable=]
fs/coredump.c:67:27: warning: unused variable 'core_file_note_size_min' [-Wunused-const-variable]
include/kunit/test.h:444:(.text+0x34c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `kunit_kmalloc_array'
include/kunit/test.h:444:(.text+0x34c): undefined reference to `kunit_kmalloc_array'
ld.lld: error: undefined symbol: drm_dsc_pps_payload_pack
powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-trace.o' being placed in section `.stubs'
powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-trace.o' being placed in section `.stubs'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/dma/fsl-edma-common.c:439 fsl_edma_set_tcd_regs() warn: statement has no effect 31
drivers/dma/fsl-edma-common.c:495 fsl_edma_fill_tcd() warn: statement has no effect 31
drivers/dma/fsl-edma-main.c:567 fsl_edma_probe() warn: statement has no effect 31
drivers/dma/fsl-edma-main.c:696 fsl_edma_resume_early() warn: statement has no effect 31
{standard input}:2020: Error: unknown pseudo-op: `.lbb32'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- alpha-randconfig-r022-20221009
|   |-- (.text):undefined-reference-to-mpfs_reset_controller_register
|   `-- alpha-linux-ld:(.text):undefined-reference-to-mpfs_reset_controller_register
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arc-randconfig-002-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- arc-randconfig-r002-20230428
|   `-- arc-elf-ld:clk-mpfs.c:(.text):undefined-reference-to-mpfs_reset_controller_register
|-- arc-randconfig-r062-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- arc-randconfig-r064-20240508
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-randconfig-001-20240508
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|-- arm64-defconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-randconfig-001-20240508
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-randconfig-003-20240508
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-__kunit_abort
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-__kunit_do_failed_assertion
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_binary_assert_format
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_binary_ptr_assert_format
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_mem_assert_format
|   |-- aarch64-linux-ld:drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_unary_assert_format
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):relocation-truncated-to-fit:R_AARCH64_ADR_PREL_PG_HI21-against-undefined-symbol-kunit_binary_assert_format
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):relocation-truncated-to-fit:R_AARCH64_ADR_PREL_PG_HI21-against-undefined-symbol-kunit_binary_ptr_assert_format
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):relocation-truncated-to-fit:R_AARCH64_ADR_PREL_PG_HI21-against-undefined-symbol-kunit_unary_assert_format
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-__kunit_abort
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-__kunit_do_failed_assertion
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_binary_assert_format
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3-test.c:(.text):undefined-reference-to-kunit_binary_ptr_assert_format
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   |-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|   |-- include-kunit-test.h:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-kunit_kmalloc_array
|   `-- include-kunit-test.h:(.text):undefined-reference-to-kunit_kmalloc_array
|-- arm64-randconfig-r013-20230528
|   `-- arch-arm64-include-asm-pgtable.h:error:implicit-declaration-of-function-pud_valid
|-- arm64-randconfig-r053-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- csky-randconfig-001-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- csky-randconfig-002-20240508
|   |-- csky-linux-ld:panel-lg-sw43408.c:(.text):undefined-reference-to-drm_dsc_pps_payload_pack
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   |-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|   `-- panel-lg-sw43408.c:(.text):undefined-reference-to-drm_dsc_pps_payload_pack
|-- i386-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-003-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-buildonly-randconfig-004-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-006-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-001-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-004-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-006-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-011-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-051-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-052-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- i386-randconfig-053-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-054-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- loongarch-randconfig-001-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- panel-lg-sw43408.c:(.text):undefined-reference-to-drm_dsc_pps_payload_pack
|-- loongarch-randconfig-002-20240508
|   `-- drivers-bluetooth-btintel.h:warning:btintel_hw_error-defined-but-not-used
|-- m68k-allmodconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- m68k-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-randconfig-r052-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:implicit-declaration-of-function-seq_puts
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:invalid-use-of-undefined-type-struct-seq_file
|   |-- drivers-gpu-drm-arm-display-komeda-komeda_dev.c:error:type-defaults-to-int-in-declaration-of-DEFINE_SHOW_ATTRIBUTE
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- microblaze-randconfig-r131-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- mips-mtx1_defconfig
|   `-- drivers-bluetooth-btintel.h:warning:btintel_hw_error-defined-but-not-used
|-- mips-randconfig-r014-20220214
|   `-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|-- nios2-allmodconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- nios2-randconfig-001-20240508
|   `-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|-- nios2-randconfig-002-20240508
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- openrisc-randconfig-r021-20221218
|   `-- clk-mpfs.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-mpfs_reset_controller_register
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-nouveau-nvif-object.c:error:memcpy-accessing-or-more-bytes-at-offsets-and-overlaps-bytes-at-offset
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- parisc-randconfig-001-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|-- parisc-randconfig-r061-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- powerpc64-buildonly-randconfig-r004-20211025
|   `-- powerpc64le-linux-ld:warning:orphan-section-stubs-from-drivers-dma-fsl-edma-trace.o-being-placed-in-section-.stubs
|-- powerpc64-randconfig-r026-20220201
|   `-- powerpc64-linux-ld:warning:orphan-section-stubs-from-drivers-dma-fsl-edma-trace.o-being-placed-in-section-.stubs
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sh-allmodconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-allyesconfig
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- sh-randconfig-r005-20230812
|   `-- standard-input:Error:unknown-pseudo-op:lbb32
|-- sh-randconfig-r063-20240508
|   `-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc-randconfig-r132-20240508
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- um-allyesconfig
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- kernel-bpf-verifier.c:error:pcpu_hot-undeclared-(first-use-in-this-function)
|-- x86_64-buildonly-randconfig-005-20240508
|   `-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
|-- x86_64-randconfig-006-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- x86_64-randconfig-014-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- x86_64-randconfig-016-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-102-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|-- x86_64-randconfig-103-20240508
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-104-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdxcp-amdgpu_xcp_drv.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-161-20240508
|   |-- drivers-gpu-drm-bridge-cadence-cdns-mhdp8546-core.c-cdns_mhdp_atomic_enable()-warn:inconsistent-returns-mhdp-link_mutex-.
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
|-- xtensa-randconfig-r111-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
`-- xtensa-randconfig-r121-20240508
    |-- drivers-regulator-rtq2208-regulator.c:warning:rtq2208_regulator_ldo_ops-defined-but-not-used
    `-- fs-coredump.c:warning:core_file_note_size_min-defined-but-not-used
clang_recent_errors
|-- arm-defconfig
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-randconfig-002-20240508
|   |-- drivers-gpu-drm-drm_mm.c:error:function-drm_mm_node_scanned_block-is-not-needed-and-will-not-be-emitted-Werror-Wunneeded-internal-declaration
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm-randconfig-004-20240508
|   `-- fs-coredump.c:warning:unused-variable-core_file_note_size_min
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|   |-- drivers-gpu-drm-xlnx-zynqmp_disp.c:error:logical-not-is-only-applied-to-the-left-hand-side-of-this-comparison-Werror-Wlogical-not-parentheses
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-randconfig-002-20240508
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- arm64-randconfig-004-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- hexagon-allmodconfig
|   |-- drivers-gpu-drm-xlnx-zynqmp_disp.c:error:logical-not-is-only-applied-to-the-left-hand-side-of-this-comparison-Werror-Wlogical-not-parentheses
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- hexagon-allyesconfig
|   |-- drivers-gpu-drm-xlnx-zynqmp_disp.c:error:logical-not-is-only-applied-to-the-left-hand-side-of-this-comparison-Werror-Wlogical-not-parentheses
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- hexagon-randconfig-001-20240508
|   `-- ld.lld:error:undefined-symbol:drm_dsc_pps_payload_pack
|-- i386-buildonly-randconfig-001-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-buildonly-randconfig-002-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-buildonly-randconfig-005-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- fs-coredump.c:warning:unused-variable-core_file_note_size_min
|-- i386-randconfig-002-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-003-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-005-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-013-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-014-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-015-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-016-20240508
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-061-20240508
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-062-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- i386-randconfig-063-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- i386-randconfig-141-20240508
|   |-- drivers-dma-fsl-edma-common.c-fsl_edma_fill_tcd()-warn:statement-has-no-effect
|   |-- drivers-dma-fsl-edma-common.c-fsl_edma_set_tcd_regs()-warn:statement-has-no-effect
|   |-- drivers-dma-fsl-edma-main.c-fsl_edma_probe()-warn:statement-has-no-effect
|   |-- drivers-dma-fsl-edma-main.c-fsl_edma_resume_early()-warn:statement-has-no-effect
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- net-ipv6-route.c-rt6_fill_node()-error:we-previously-assumed-dst-could-be-null-(see-line-)
|-- i386-randconfig-r054-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-xlnx-zynqmp_disp.c:error:logical-not-is-only-applied-to-the-left-hand-side-of-this-comparison-Werror-Wlogical-not-parentheses
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-xlnx-zynqmp_disp.c:error:logical-not-is-only-applied-to-the-left-hand-side-of-this-comparison-Werror-Wlogical-not-parentheses
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-xlnx-zynqmp_disp.c:error:logical-not-is-only-applied-to-the-left-hand-side-of-this-comparison-Werror-Wlogical-not-parentheses
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_cursor.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-phy-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display_irq.c:error:arithmetic-between-different-enumeration-types-(-enum-transcoder-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_dpll_mgr.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-intel_dpll_id-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_hotplug.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_pipe_crc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_tc.c:error:arithmetic-between-different-enumeration-types-(-enum-intel_display_power_domain-and-enum-tc_port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_vdsc.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_universal_plane.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-skl_watermark.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-xlnx-zynqmp_disp.c:error:logical-not-is-only-applied-to-the-left-hand-side-of-this-comparison-Werror-Wlogical-not-parentheses
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   |-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|   `-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|-- x86_64-allnoconfig
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-display-exynos
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-reserved-memory-qcom
|   `-- net-ipv6-udp.c:trace-events-udp.h-is-included-more-than-once.
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-xlnx-zynqmp_disp.c:error:logical-not-is-only-applied-to-the-left-hand-side-of-this-comparison-Werror-Wlogical-not-parentheses
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-buildonly-randconfig-002-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   `-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|-- x86_64-randconfig-003-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- x86_64-randconfig-015-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- x86_64-randconfig-073-20240508
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-all_hub-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-flush_type-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-inst-not-described-in-gmc_v12_0_flush_gpu_tlb_pasid
|   |-- drivers-gpu-drm-amd-amdgpu-gmc_v12_0.c:warning:Function-parameter-or-struct-member-vmhub-not-described-in-gmc_v12_0_flush_gpu_tlb
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-addr-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-fence-description-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-flags-description-in-sdma_v7_0_vm_write_pte
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ib-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-job-description-in-sdma_v7_0_ring_emit_mem_sync
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-ring-description-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Excess-function-parameter-vm-description-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-addr-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-flags-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_copy_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ib-not-described-in-sdma_v7_0_emit_fill_buffer
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-job-not-described-in-sdma_v7_0_ring_emit_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-pd_addr-not-described-in-sdma_v7_0_ring_emit_vm_flush
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-ring-not-described-in-sdma_v7_0_ring_pad_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-seq-not-described-in-sdma_v7_0_ring_emit_fence
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-timeout-not-described-in-sdma_v7_0_ring_test_ib
|   |-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-value-not-described-in-sdma_v7_0_vm_write_pte
|   `-- drivers-gpu-drm-amd-amdgpu-sdma_v7_0.c:warning:Function-parameter-or-struct-member-vmid-not-described-in-sdma_v7_0_ring_emit_vm_flush
|-- x86_64-randconfig-076-20240508
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-101-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
|-- x86_64-randconfig-121-20240508
|   |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
|   `-- fs-bcachefs-sb-clean.c:sparse:sparse:cast-to-restricted-__le16
`-- x86_64-randconfig-122-20240508
    |-- drivers-regulator-rtq2208-regulator.c:warning:unused-variable-rtq2208_regulator_ldo_ops
    `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used

elapsed time: 742m

configs tested: 161
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240508   gcc  
arc                   randconfig-002-20240508   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                   randconfig-001-20240508   gcc  
arm                   randconfig-002-20240508   clang
arm                   randconfig-003-20240508   clang
arm                   randconfig-004-20240508   clang
arm                             rpc_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240508   gcc  
arm64                 randconfig-002-20240508   clang
arm64                 randconfig-003-20240508   gcc  
arm64                 randconfig-004-20240508   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240508   gcc  
csky                  randconfig-002-20240508   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240508   clang
hexagon               randconfig-002-20240508   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240508   clang
i386         buildonly-randconfig-002-20240508   clang
i386         buildonly-randconfig-003-20240508   gcc  
i386         buildonly-randconfig-004-20240508   gcc  
i386         buildonly-randconfig-005-20240508   clang
i386         buildonly-randconfig-006-20240508   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240508   gcc  
i386                  randconfig-002-20240508   clang
i386                  randconfig-003-20240508   clang
i386                  randconfig-004-20240508   gcc  
i386                  randconfig-005-20240508   clang
i386                  randconfig-006-20240508   gcc  
i386                  randconfig-011-20240508   gcc  
i386                  randconfig-012-20240508   gcc  
i386                  randconfig-013-20240508   clang
i386                  randconfig-014-20240508   clang
i386                  randconfig-015-20240508   clang
i386                  randconfig-016-20240508   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240508   gcc  
loongarch             randconfig-002-20240508   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240508   gcc  
nios2                 randconfig-002-20240508   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240508   gcc  
parisc                randconfig-002-20240508   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                     ksi8560_defconfig   gcc  
powerpc                      makalu_defconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240508   clang
x86_64       buildonly-randconfig-002-20240508   clang
x86_64       buildonly-randconfig-003-20240508   clang
x86_64       buildonly-randconfig-004-20240508   clang
x86_64       buildonly-randconfig-005-20240508   gcc  
x86_64       buildonly-randconfig-006-20240508   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240508   gcc  
x86_64                randconfig-002-20240508   clang
x86_64                randconfig-003-20240508   clang
x86_64                randconfig-004-20240508   gcc  
x86_64                randconfig-005-20240508   gcc  
x86_64                randconfig-006-20240508   gcc  
x86_64                randconfig-011-20240508   clang
x86_64                randconfig-012-20240508   clang
x86_64                randconfig-013-20240508   gcc  
x86_64                randconfig-014-20240508   gcc  
x86_64                randconfig-015-20240508   clang
x86_64                randconfig-016-20240508   gcc  
x86_64                randconfig-071-20240508   gcc  
x86_64                randconfig-072-20240508   gcc  
x86_64                randconfig-073-20240508   clang
x86_64                randconfig-074-20240508   gcc  
x86_64                randconfig-075-20240508   gcc  
x86_64                randconfig-076-20240508   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


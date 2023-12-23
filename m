Return-Path: <linux-fsdevel+bounces-6818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF781D307
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 08:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F47F2853B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E78F6C;
	Sat, 23 Dec 2023 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHn3ev2Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4F8BEA;
	Sat, 23 Dec 2023 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703317571; x=1734853571;
  h=date:from:to:cc:subject:message-id;
  bh=tRD2d23yR/etjAPYqXgW6vmhGIV69h7SsFViMmb7w24=;
  b=KHn3ev2ZGCE2FjVeoHdr7Zb6STEEdmET7EsRB8sJgfwrBFEjymXFI0+q
   bL8FxMyhabLq4Ne48PLWSbuM0OlM9DZdHvL9lf5WxaAC7LQi+aREVY4mW
   VigAFJegyf6JPgPKJpVLTeqZ+MDjTW70P4pPxHYYdDvvc1CKiW5Nda1WU
   3OkfrPpMrOeaCTtL70PH0szrpxZzjXew+O9m158bdSz6LeKqRyjPKlbOt
   2A2SFgd/MnBH5O6Vuwp0xtVEg+ntK+HLUoyxmlYFyYJlGLjW1+gt+Myl2
   xSREU1yWmlsYH9cAxvr4gdzNimf5rqSagbHdXwsXOELP5/QDfWyD8obAf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="14868162"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="14868162"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 23:45:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="770554474"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="770554474"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 22 Dec 2023 23:45:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGwhc-000AQv-1K;
	Sat, 23 Dec 2023 07:45:46 +0000
Date: Sat, 23 Dec 2023 15:44:46 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 alsa-devel@alsa-project.org, amd-gfx@lists.freedesktop.org,
 ceph-devel@vger.kernel.org, dmaengine@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, kasan-dev@googlegroups.com,
 kunit-dev@googlegroups.com, linux-arm-msm@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-bcachefs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com
Subject: [linux-next:master] BUILD REGRESSION
 39676dfe52331dba909c617f213fdb21015c8d10
Message-ID: <202312231534.UWFO81PH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 39676dfe52331dba909c617f213fdb21015c8d10  Add linux-next specific files for 20231222

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202312222155.w90Evz26-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312230634.3AIMQ3OP-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312230642.EBF6kiYY-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312231042.LGJY7ydP-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312231258.L3C56jBw-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/dma/xilinx/xdma.c:555: warning: Function parameter or member 'dst_addr' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:555: warning: Function parameter or member 'filled_descs_num' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:555: warning: Function parameter or member 'size' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:555: warning: Function parameter or member 'src_addr' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:555: warning: Function parameter or member 'sw_desc' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:555: warning: Function parameter or struct member 'dst_addr' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:555: warning: Function parameter or struct member 'filled_descs_num' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:555: warning: Function parameter or struct member 'size' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:555: warning: Function parameter or struct member 'src_addr' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:555: warning: Function parameter or struct member 'sw_desc' not described in 'xdma_fill_descs'
drivers/dma/xilinx/xdma.c:729:1: warning: no previous prototype for 'xdma_prep_interleaved_dma' [-Wmissing-prototypes]
drivers/dma/xilinx/xdma.c:729:1: warning: no previous prototype for function 'xdma_prep_interleaved_dma' [-Wmissing-prototypes]
drivers/dma/xilinx/xdma.c:757:68: warning: operator '?:' has lower precedence than '+'; '+' will be evaluated first [-Wparentheses]
drivers/dma/xilinx/xdma.c:894:3: warning: variable 'desc' is uninitialized when used here [-Wuninitialized]
lib/aolib.h:366:16: error: variable 'key2' has initializer but incomplete type
lib/aolib.h:366:34: error: storage size of 'key2' isn't known
lib/aolib.h:369:46: error: invalid use of undefined type 'struct tcp_ao_add'
lib/aolib.h:382:16: error: variable 'tmp' has initializer but incomplete type
lib/aolib.h:382:27: error: storage size of 'tmp' isn't known
lib/aolib.h:390:43: error: 'TCP_AO_ADD_KEY' undeclared (first use in this function)
lib/aolib.h:406:16: error: variable 'ao2' has initializer but incomplete type
lib/aolib.h:406:32: error: storage size of 'ao2' isn't known
lib/aolib.h:418:16: error: variable 'ao' has initializer but incomplete type
lib/aolib.h:418:32: error: storage size of 'ao' isn't known
lib/kconfig.c:47:16: error: variable 'tmp' has initializer but incomplete type
lib/kconfig.c:47:27: error: storage size of 'tmp' isn't known
lib/kconfig.c:64:41: error: 'TCP_AO_ADD_KEY' undeclared (first use in this function)
lib/repair.c:115:6: error: conflicting types for 'test_ao_checkpoint'; have 'void(int,  struct tcp_ao_repair *)'
lib/repair.c:117:31: error: invalid application of 'sizeof' to incomplete type 'struct tcp_ao_repair'
lib/repair.c:122:39: error: 'TCP_AO_REPAIR' undeclared (first use in this function); did you mean 'TCP_REPAIR'?
lib/repair.c:222:6: error: conflicting types for 'test_ao_restore'; have 'void(int,  struct tcp_ao_repair *)'
lib/sock.c:136:5: error: conflicting types for 'test_prepare_key_sockaddr'; have 'int(struct tcp_ao_add *, const char *, void *, size_t,  _Bool,  _Bool,  uint8_t,  uint8_t,  uint8_t,  uint8_t,  uint8_t,  uint8_t,  uint8_t,  const char *)' {aka 'int(struct tcp_ao_add *, const char *, void *, long unsigned int,  _Bool,  _Bool,  unsigned char,  unsigned char,  unsigned char,  unsigned char,  unsigned char,  unsigned char,  unsigned char,  const char *)'}
lib/sock.c:142:30: error: invalid application of 'sizeof' to incomplete type 'struct tcp_ao_add'
lib/sock.c:144:11: error: invalid use of undefined type 'struct tcp_ao_add'
lib/sock.c:161:26: error: 'TCP_AO_MAXKEYLEN' undeclared (first use in this function); did you mean 'TCP_MD5SIG_MAXKEYLEN'?
lib/sock.c:167:16: error: variable 'tmp' has initializer but incomplete type
lib/sock.c:167:34: error: storage size of 'tmp' isn't known
lib/sock.c:174:43: error: 'TCP_AO_GET_KEYS' undeclared (first use in this function)
lib/sock.c:180:5: error: conflicting types for 'test_get_one_ao'; have 'int(int,  struct tcp_ao_getsockopt *, void *, size_t,  uint8_t,  uint8_t,  uint8_t)' {aka 'int(int,  struct tcp_ao_getsockopt *, void *, long unsigned int,  unsigned char,  unsigned char,  unsigned char)'}
lib/sock.c:199:14: error: invalid use of undefined type 'struct tcp_ao_getsockopt'
lib/sock.c:203:5: error: conflicting types for 'test_get_ao_info'; have 'int(int,  struct tcp_ao_info_opt *)'
lib/sock.c:205:30: error: invalid application of 'sizeof' to incomplete type 'struct tcp_ao_info_opt'
lib/sock.c:207:12: error: invalid use of undefined type 'struct tcp_ao_info_opt'
lib/sock.c:209:41: error: 'TCP_AO_INFO' undeclared (first use in this function); did you mean 'TCP_CC_INFO'?
lib/sock.c:216:5: error: conflicting types for 'test_set_ao_info'; have 'int(int,  struct tcp_ao_info_opt *)'
lib/sock.c:227:5: error: conflicting types for 'test_cmp_getsockopt_setsockopt'; have 'int(const struct tcp_ao_add *, const struct tcp_ao_getsockopt *)'
lib/sock.c:233:38: error: invalid use of undefined type 'const struct tcp_ao_add'
lib/sock.c:240:14: error: invalid use of undefined type 'const struct tcp_ao_getsockopt'
lib/sock.c:299:5: error: conflicting types for 'test_cmp_getsockopt_setsockopt_ao'; have 'int(const struct tcp_ao_info_opt *, const struct tcp_ao_info_opt *)'
lib/sock.c:303:14: error: invalid use of undefined type 'const struct tcp_ao_info_opt'
lib/sock.c:337:39: error: invalid application of 'sizeof' to incomplete type 'struct tcp_ao_getsockopt'
lib/sock.c:338:16: error: variable 'info' has initializer but incomplete type
lib/sock.c:338:32: error: storage size of 'info' isn't known
powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data794' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data794'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/dma/xilinx/xdma.c:894 xdma_channel_isr() error: potentially dereferencing uninitialized 'desc'.
fs/smb/client/file.c:2744:(.text+0x95ae): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
include/linux/pagemap.h:231:(.text+0x968c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
include/linux/syscalls.h:257:9: internal compiler error: in change_address_1, at emit-rtl.cc:2287
sound/pci/hda/cs35l41_hda_property.c:176:27: warning: unused variable 'cs_gpiod' [-Wunused-variable]
sound/pci/hda/cs35l41_hda_property.c:177:28: warning: unused variable 'spi' [-Wunused-variable]
{standard input}:21016: Warning: overflow in branch to .L4838; converted into longer instruction sequence
{standard input}:26527: Error: pcrel too far
{standard input}:6990: Warning: overflow in branch to .L1661; converted into longer instruction sequence

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-randconfig-002-20231222
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-member-sw_desc-not-described-in-xdma_fill_descs
|-- arc-randconfig-r122-20231222
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-randconfig-001-20231222
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-randconfig-002-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-randconfig-003-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-randconfig-004-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-defconfig
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-pvr_dev-description-in-pvr_mmu_backing_page
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt_offset-description-in-pvr_mmu_op_context
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arm64-randconfig-002-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-randconfig-003-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-randconfig-r061-20231222
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-net-ethernet-intel-ice-ice_base.c:error:storage-size-of-desc-isn-t-known
|   |-- drivers-net-ethernet-intel-ice-ice_base.c:error:variable-desc-has-initializer-but-incomplete-type
|   |-- drivers-net-ethernet-intel-ice-ice_base.c:warning:unused-variable-desc
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-randconfig-r063-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- csky-buildonly-randconfig-r004-20230509
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:no-previous-prototype-for-xdma_prep_interleaved_dma
|-- csky-randconfig-001-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- csky-randconfig-r023-20220124
|   |-- fs-smb-client-file.c:(.text):relocation-truncated-to-fit:R_CKCORE_PCREL_IMM16BY4-against-__jump_table
|   `-- include-linux-pagemap.h:(.text):relocation-truncated-to-fit:R_CKCORE_PCREL_IMM16BY4-against-__jump_table
|-- csky-randconfig-r111-20231222
|   |-- arch-csky-kernel-vdso-vgettimeofday.c:sparse:sparse:function-__vdso_clock_gettime-with-external-linkage-has-definition
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-buildonly-randconfig-002-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-buildonly-randconfig-006-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-001-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-002-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-004-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-005-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-006-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-051-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-052-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-054-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-061-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-141-20231222
|   |-- drivers-ata-ata_piix.c-piix_init_sata_map()-error:buffer-overflow-map
|   |-- fs-ceph-addr.c-writepages_finish()-error:page-dereferencing-possible-ERR_PTR()
|   |-- lib-kunit-device.c-kunit_device_register_with_driver()-warn:passing-zero-to-ERR_CAST
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-r121-20231222
|   `-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- loongarch-loongson3_defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- loongarch-randconfig-001-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- loongarch-randconfig-002-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- loongarch-randconfig-r131-20231222
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- sound-pci-hda-cs35l41_hda_property.c:warning:unused-variable-cs_gpiod
|   `-- sound-pci-hda-cs35l41_hda_property.c:warning:unused-variable-spi
|-- m68k-allmodconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- m68k-allyesconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- m68k-defconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- nios2-allmodconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- nios2-allyesconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- nios2-randconfig-001-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- nios2-randconfig-002-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- nios2-randconfig-r064-20231222
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- parisc-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-tty-serial-8250_parisc.o
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- parisc-randconfig-001-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-ppc64_defconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-randconfig-001-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-randconfig-002-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-randconfig-003-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc64-randconfig-001-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc64-randconfig-002-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc64-randconfig-003-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc64-randconfig-r035-20211208
|   `-- powerpc64-linux-ld:warning:orphan-section-bss..Lubsan_data794-from-kernel-ptrace.o-being-placed-in-section-.bss..Lubsan_data794
|-- powerpc64-randconfig-r113-20231222
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-randconfig-002-20231222
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- s390-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_diag_mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_eckd_mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_fba_mod.o
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- s390-defconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sh-allmodconfig
|   |-- include-linux-syscalls.h:internal-compiler-error:in-change_address_1-at-emit-rtl.cc
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- standard-input:Error:pcrel-too-far
|-- sh-allnoconfig
|   |-- standard-input:Error:pcrel-too-far
|   `-- standard-input:Warning:overflow-in-branch-to-.L1609-converted-into-longer-instruction-sequence
|-- sh-allyesconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sh-randconfig-001-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sh-randconfig-002-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sh-randconfig-r032-20220320
|   `-- standard-input:Warning:overflow-in-branch-to-.L4838-converted-into-longer-instruction-sequence
|-- sh-randconfig-r123-20231222
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   |-- standard-input:Error:pcrel-too-far
|   `-- standard-input:Warning:overflow-in-branch-to-.L1661-converted-into-longer-instruction-sequence
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sparc-allnoconfig
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-randconfig-001-20231222
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc-randconfig-002-20231222
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-pagecv_flag-set-but-not-used
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sparc-randconfig-r133-20231222
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   |-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_register
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_prepare
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_request
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_residue
|   `-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_unregister
|-- sparc64-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sparc64-allyesconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sparc64-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-randconfig-001-20231222
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-pagecv_flag-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   `-- fbcon.c:(.text):undefined-reference-to-fb_is_primary_device
|-- sparc64-randconfig-002-20231222
|   `-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|-- x86_64-allnoconfig
|   `-- include-linux-sched.h:linux-cache.h-is-included-more-than-once.
|-- x86_64-buildonly-randconfig-001-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-buildonly-randconfig-002-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-buildonly-randconfig-003-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-buildonly-randconfig-004-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-buildonly-randconfig-005-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-buildonly-randconfig-006-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-011-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-014-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-015-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-072-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-073-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-075-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-076-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-101-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-102-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-103-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-161-20231222
|   |-- drivers-atm-idt77252.c-idt77252_rx_raw()-warn:possible-spectre-second-half.-vc
|   |-- drivers-atm-idt77252.c-idt77252_rx_raw()-warn:potential-spectre-issue-card-vcs-r
|   |-- drivers-dma-xilinx-xdma.c-xdma_channel_isr()-error:potentially-dereferencing-uninitialized-desc-.
|   |-- drivers-hwmon-pmbus-ltc4286.c-ltc4286_probe()-warn:passing-zero-to-dev_err_probe
|   |-- drivers-scsi-mpi3mr-mpi3mr_app.c-mpi3mr_bsg_build_sgl()-warn:missing-unwind-goto
|   |-- drivers-scsi-mpi3mr-mpi3mr_app.c-mpi3mr_map_data_buffer_dma()-warn:returning-instead-of-ENOMEM-is-sloppy
|   |-- fs-bcachefs-inode.c-bch2_delete_dead_inodes()-error:potentially-using-uninitialized-ret-.
|   |-- lib-kunit-device.c-kunit_device_register_with_driver()-warn:passing-zero-to-ERR_CAST
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-rhel-8.3-bpf
|   |-- lib-aolib.h:error:TCP_AO_ADD_KEY-undeclared-(first-use-in-this-function)
|   |-- lib-aolib.h:error:invalid-use-of-undefined-type-struct-tcp_ao_add
|   |-- lib-aolib.h:error:storage-size-of-ao-isn-t-known
|   |-- lib-aolib.h:error:storage-size-of-ao2-isn-t-known
|   |-- lib-aolib.h:error:storage-size-of-key2-isn-t-known
|   |-- lib-aolib.h:error:storage-size-of-tmp-isn-t-known
|   |-- lib-aolib.h:error:variable-ao-has-initializer-but-incomplete-type
|   |-- lib-aolib.h:error:variable-ao2-has-initializer-but-incomplete-type
|   |-- lib-aolib.h:error:variable-key2-has-initializer-but-incomplete-type
|   |-- lib-aolib.h:error:variable-tmp-has-initializer-but-incomplete-type
|   |-- lib-kconfig.c:error:TCP_AO_ADD_KEY-undeclared-(first-use-in-this-function)
|   |-- lib-kconfig.c:error:storage-size-of-tmp-isn-t-known
|   |-- lib-kconfig.c:error:variable-tmp-has-initializer-but-incomplete-type
|   |-- lib-repair.c:error:TCP_AO_REPAIR-undeclared-(first-use-in-this-function)
|   |-- lib-repair.c:error:conflicting-types-for-test_ao_checkpoint-have-void(int-struct-tcp_ao_repair-)
|   |-- lib-repair.c:error:conflicting-types-for-test_ao_restore-have-void(int-struct-tcp_ao_repair-)
|   |-- lib-repair.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-tcp_ao_repair
|   |-- lib-sock.c:error:TCP_AO_GET_KEYS-undeclared-(first-use-in-this-function)
|   |-- lib-sock.c:error:TCP_AO_INFO-undeclared-(first-use-in-this-function)
|   |-- lib-sock.c:error:TCP_AO_MAXKEYLEN-undeclared-(first-use-in-this-function)
|   |-- lib-sock.c:error:conflicting-types-for-test_cmp_getsockopt_setsockopt-have-int(const-struct-tcp_ao_add-const-struct-tcp_ao_getsockopt-)
|   |-- lib-sock.c:error:conflicting-types-for-test_cmp_getsockopt_setsockopt_ao-have-int(const-struct-tcp_ao_info_opt-const-struct-tcp_ao_info_opt-)
|   |-- lib-sock.c:error:conflicting-types-for-test_get_ao_info-have-int(int-struct-tcp_ao_info_opt-)
|   |-- lib-sock.c:error:conflicting-types-for-test_get_one_ao-have-int(int-struct-tcp_ao_getsockopt-void-size_t-uint8_t-uint8_t-uint8_t)-aka-int(int-struct-tcp_ao_getsockopt-void-long-unsigned-int-unsigned-c
|   |-- lib-sock.c:error:conflicting-types-for-test_prepare_key_sockaddr-have-int(struct-tcp_ao_add-const-char-void-size_t-_Bool-_Bool-uint8_t-uint8_t-uint8_t-uint8_t-uint8_t-uint8_t-uint8_t-const-char-)-aka-
|   |-- lib-sock.c:error:conflicting-types-for-test_set_ao_info-have-int(int-struct-tcp_ao_info_opt-)
|   |-- lib-sock.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-tcp_ao_add
|   |-- lib-sock.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-tcp_ao_getsockopt
|   |-- lib-sock.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-tcp_ao_info_opt
|   |-- lib-sock.c:error:invalid-use-of-undefined-type-const-struct-tcp_ao_add
|   |-- lib-sock.c:error:invalid-use-of-undefined-type-const-struct-tcp_ao_getsockopt
|   |-- lib-sock.c:error:invalid-use-of-undefined-type-const-struct-tcp_ao_info_opt
|   |-- lib-sock.c:error:invalid-use-of-undefined-type-struct-tcp_ao_add
|   |-- lib-sock.c:error:invalid-use-of-undefined-type-struct-tcp_ao_getsockopt
|   |-- lib-sock.c:error:invalid-use-of-undefined-type-struct-tcp_ao_info_opt
|   |-- lib-sock.c:error:storage-size-of-info-isn-t-known
|   |-- lib-sock.c:error:storage-size-of-tmp-isn-t-known
|   |-- lib-sock.c:error:variable-info-has-initializer-but-incomplete-type
|   `-- lib-sock.c:error:variable-tmp-has-initializer-but-incomplete-type
`-- xtensa-randconfig-001-20231222
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-fs-exportfs-exportfs.o
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
    `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
clang_recent_errors
|-- arm-defconfig
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_poweroff_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_shdwc_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arm-randconfig-r052-20231222
|   `-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_poweroff_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-pvr_dev-description-in-pvr_mmu_backing_page
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt_offset-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:no-previous-prototype-for-function-xdma_prep_interleaved_dma
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-pvr_dev-description-in-pvr_mmu_backing_page
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt_offset-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- hexagon-allmodconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- hexagon-allyesconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- hexagon-randconfig-001-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-allmodconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-013-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-014-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-016-20231222
|   `-- drivers-net-ethernet-intel-ice-ice_base.c:error:variable-has-incomplete-type-struct-xsk_cb_desc
|-- mips-randconfig-r051-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- mips-randconfig-r054-20231222
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:no-previous-prototype-for-function-xdma_prep_interleaved_dma
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:no-previous-prototype-for-function-xdma_prep_interleaved_dma
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- s390-randconfig-002-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:no-previous-prototype-for-function-xdma_prep_interleaved_dma
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:no-previous-prototype-for-function-xdma_prep_interleaved_dma
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-001-20231222
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Excess-function-parameter-context-description-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:warning:Function-parameter-or-struct-member-state-not-described-in-dc_state_rem_all_planes_for_stream
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dc_dmub_srv.c:warning:Function-parameter-or-struct-member-context-not-described-in-populate_subvp_cmd_drr_info
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-006-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-121-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   |-- mm-kasan-common.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-gfp_t-usertype-flags-got-unsigned-long-usertype-size
|   `-- mm-kasan-common.c:sparse:sparse:symbol-unpoison_slab_object-was-not-declared.-Should-it-be-static
|-- x86_64-randconfig-122-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-123-20231222
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   |-- mm-kasan-common.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-gfp_t-usertype-flags-got-unsigned-long-usertype-size
|   `-- mm-kasan-common.c:sparse:sparse:symbol-unpoison_slab_object-was-not-declared.-Should-it-be-static
|-- x86_64-randconfig-r132-20231222
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path-noderef-__rcu
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
`-- x86_64-rhel-8.3-rust
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
    `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create

elapsed time: 1537m

configs tested: 177
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231222   gcc  
arc                   randconfig-002-20231222   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                   randconfig-001-20231222   gcc  
arm                   randconfig-002-20231222   gcc  
arm                   randconfig-003-20231222   gcc  
arm                   randconfig-004-20231222   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231222   gcc  
arm64                 randconfig-002-20231222   gcc  
arm64                 randconfig-003-20231222   gcc  
arm64                 randconfig-004-20231222   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231222   gcc  
csky                  randconfig-002-20231222   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231222   clang
hexagon               randconfig-002-20231222   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231222   gcc  
i386         buildonly-randconfig-002-20231222   gcc  
i386         buildonly-randconfig-003-20231222   gcc  
i386         buildonly-randconfig-004-20231222   gcc  
i386         buildonly-randconfig-005-20231222   gcc  
i386         buildonly-randconfig-006-20231222   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231222   gcc  
i386                  randconfig-002-20231222   gcc  
i386                  randconfig-003-20231222   gcc  
i386                  randconfig-004-20231222   gcc  
i386                  randconfig-005-20231222   gcc  
i386                  randconfig-006-20231222   gcc  
i386                  randconfig-011-20231222   clang
i386                  randconfig-012-20231222   clang
i386                  randconfig-013-20231222   clang
i386                  randconfig-014-20231222   clang
i386                  randconfig-015-20231222   clang
i386                  randconfig-016-20231222   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231222   gcc  
loongarch             randconfig-002-20231222   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        qi_lb60_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231222   gcc  
nios2                 randconfig-002-20231222   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231222   gcc  
parisc                randconfig-002-20231222   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231222   gcc  
powerpc               randconfig-002-20231222   gcc  
powerpc               randconfig-003-20231222   gcc  
powerpc64             randconfig-001-20231222   gcc  
powerpc64             randconfig-002-20231222   gcc  
powerpc64             randconfig-003-20231222   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231222   gcc  
riscv                 randconfig-002-20231222   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231222   clang
s390                  randconfig-002-20231222   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231222   gcc  
sh                    randconfig-002-20231222   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231222   gcc  
sparc64               randconfig-002-20231222   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231222   gcc  
um                    randconfig-002-20231222   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231222   gcc  
x86_64       buildonly-randconfig-002-20231222   gcc  
x86_64       buildonly-randconfig-003-20231222   gcc  
x86_64       buildonly-randconfig-004-20231222   gcc  
x86_64       buildonly-randconfig-005-20231222   gcc  
x86_64       buildonly-randconfig-006-20231222   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231222   clang
x86_64                randconfig-002-20231222   clang
x86_64                randconfig-003-20231222   clang
x86_64                randconfig-004-20231222   clang
x86_64                randconfig-005-20231222   clang
x86_64                randconfig-006-20231222   clang
x86_64                randconfig-011-20231222   gcc  
x86_64                randconfig-012-20231222   gcc  
x86_64                randconfig-013-20231222   gcc  
x86_64                randconfig-014-20231222   gcc  
x86_64                randconfig-015-20231222   gcc  
x86_64                randconfig-016-20231222   gcc  
x86_64                randconfig-071-20231222   gcc  
x86_64                randconfig-072-20231222   gcc  
x86_64                randconfig-073-20231222   gcc  
x86_64                randconfig-074-20231222   gcc  
x86_64                randconfig-075-20231222   gcc  
x86_64                randconfig-076-20231222   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20231222   gcc  
xtensa                randconfig-002-20231222   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


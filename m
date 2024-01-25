Return-Path: <linux-fsdevel+bounces-8942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F483C84C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15CCB21AE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC65130E2A;
	Thu, 25 Jan 2024 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfxGgY4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440458AAE;
	Thu, 25 Jan 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200932; cv=none; b=LRVNhItzLT2YrKYR49/Tggqega0RIiIxgJL1xwl06K6cyYEFI20Zq5S9Ogrt35TjMDsVdnheIHc4HHhsVltGFC8pEy4ZDIRwSu30v1xJezhG8bzko+dapy3e7cz6Ut6SBW16Xjlzdswh5a0UdNC2h/WPB1UGdIK3xCgN090fHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200932; c=relaxed/simple;
	bh=unKZxtZkNvgDgI5CInfVc1fnq6EYgeAlrqhGEyQdlhk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RjqbcDwE/JtNHeYyHqURAJVCgpXJOp8G35vIoemqQ1A6f3EnHBTdY50/Taoe49oLPCULwmT81U6I+EvpRsX4YnoUmLyZH2VsrxtWZD2o68/+B46JgCTYo+a/GUrdPaROv/4JKN+dgAMqKiqHVufyiofwp+ylw/0Oe6tvRAY0UjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfxGgY4p; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706200930; x=1737736930;
  h=date:from:to:cc:subject:message-id;
  bh=unKZxtZkNvgDgI5CInfVc1fnq6EYgeAlrqhGEyQdlhk=;
  b=QfxGgY4pLgPwKh0qCb0lE8qNe1QicQYC9lhI36/MzueFyjlURghm2lI6
   HKtKbPHRcrvUgRJZStlSZ9Kol+9AwSEeDXBzHqjCW6i2Z8JmTggAZVc3b
   rtERXufNhxJSQqJ7DyrPMTSET2UG9XbZGhM2MSd7nNker7leQnLfiMVAL
   cinU7f08/MCXDqYQUQMN7rNdFIjgB+43jILwYcpOR6daeJrst6dAyS9kt
   HSC599q142ll5lAZceLveR7iodk/NbNkHdCQpdbwdXiohTT3giDcDjFN0
   xlUpCmRev2urX1afCjT783sV/ppQKJpLJqfxw9p0mn8j2AG5oUo2sfjnY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2088007"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2088007"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28817207"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Jan 2024 08:42:04 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT2nh-0000Cm-2R;
	Thu, 25 Jan 2024 16:42:01 +0000
Date: Fri, 26 Jan 2024 00:41:14 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 01af33cc9894b4489fb68fa35c40e9fe85df63dc
Message-ID: <202401260007.1GUNDTMR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 01af33cc9894b4489fb68fa35c40e9fe85df63dc  Add linux-next specific files for 20240125

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202401251829.0m6Eo4LI-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202401252355.PhD9im8z-lkp@intel.com

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-allyesconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-randconfig-002-20240125
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- arm-randconfig-003-20240125
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- i386-randconfig-061-20240125
|   |-- include-linux-mm_inline.h:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-anon_vma_name-anon_name-got-struct-anon_vma_name-noderef-__rcu-anon_name
|   |-- mm-madvise.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-kref-kref-got-struct-kref-noderef-__rcu
|   |-- mm-madvise.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-anon_vma_name-noderef-__rcu-anon_name-got-struct-anon_vma_name
|   `-- mm-madvise.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-anon_vma_name-got-struct-anon_vma_name-noderef-__rcu-anon_name
|-- i386-randconfig-062-20240125
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
|-- i386-randconfig-063-20240125
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
|-- i386-randconfig-141-20240125
|   |-- fs-bcachefs-btree_locking.c-bch2_trans_relock()-warn:passing-zero-to-PTR_ERR
|   |-- fs-bcachefs-buckets.c-bch2_trans_account_disk_usage_change()-error:we-previously-assumed-trans-disk_res-could-be-null-(see-line-)
|   `-- mm-huge_memory.c-thpsize_create()-warn:Calling-kobject_put-get-with-state-initialized-unset-from-line:
|-- microblaze-randconfig-r123-20240125
|   `-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-csum-got-unsigned-int-assigned-csum
|-- mips-allyesconfig
|   |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
|   `-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
`-- parisc-randconfig-r112-20240125
    |-- include-linux-mm_inline.h:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-anon_vma_name-anon_name-got-struct-anon_vma_name-noderef-__rcu-anon_name
    |-- lib-checksum_kunit.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-__wsum-usertype-sum-got-unsigned-int-assigned-csum
    |-- mm-madvise.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-kref-kref-got-struct-kref-noderef-__rcu
    |-- mm-madvise.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-anon_vma_name-noderef-__rcu-anon_name-got-struct-anon_vma_name
    `-- mm-madvise.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-anon_vma_name-got-struct-anon_vma_name-noderef-__rcu-anon_name
clang_recent_errors
|-- arm-defconfig
|   |-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_CYCLIC-not-described-in-enum-atc_status
|   `-- drivers-dma-at_hdmac.c:warning:Enum-value-ATC_IS_PAUSED-not-described-in-enum-atc_status
|-- hexagon-randconfig-r121-20240125
|   |-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static
|   |-- drivers-usb-gadget-function-f_ncm.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-unsigned-short-usertype-max_segment_size-got-restricted-__le16-usertype
|   `-- net-core-sock_diag.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- mips-randconfig-r122-20240125
|   `-- drivers-usb-cdns3-cdns3-gadget.c:sparse:sparse:restricted-__le32-degrades-to-integer
|-- powerpc-randconfig-r132-20240125
|   `-- drivers-regulator-qcom_smd-regulator.c:sparse:sparse:symbol-smd_vreg_rpm-was-not-declared.-Should-it-be-static
|-- x86_64-randconfig-121-20240125
|   `-- fs-proc-task_mmu.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-noderef-__rcu-f-got-struct-file
`-- x86_64-randconfig-123-20240125
    |-- include-linux-mm_inline.h:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-anon_vma_name-anon_name-got-struct-anon_vma_name-noderef-__rcu-anon_name
    |-- mm-madvise.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-kref-kref-got-struct-kref-noderef-__rcu
    |-- mm-madvise.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-anon_vma_name-noderef-__rcu-anon_name-got-struct-anon_vma_name
    `-- mm-madvise.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-anon_vma_name-got-struct-anon_vma_name-noderef-__rcu-anon_name

elapsed time: 750m

configs tested: 165
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240125   gcc  
arc                   randconfig-002-20240125   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240125   gcc  
arm                   randconfig-002-20240125   gcc  
arm                   randconfig-003-20240125   gcc  
arm                   randconfig-004-20240125   gcc  
arm                        vexpress_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240125   gcc  
arm64                 randconfig-002-20240125   gcc  
arm64                 randconfig-003-20240125   gcc  
arm64                 randconfig-004-20240125   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240125   gcc  
csky                  randconfig-002-20240125   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240125   clang
hexagon               randconfig-002-20240125   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240125   gcc  
i386         buildonly-randconfig-002-20240125   gcc  
i386         buildonly-randconfig-003-20240125   gcc  
i386         buildonly-randconfig-004-20240125   gcc  
i386         buildonly-randconfig-005-20240125   gcc  
i386         buildonly-randconfig-006-20240125   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240125   gcc  
i386                  randconfig-002-20240125   gcc  
i386                  randconfig-003-20240125   gcc  
i386                  randconfig-004-20240125   gcc  
i386                  randconfig-005-20240125   gcc  
i386                  randconfig-006-20240125   gcc  
i386                  randconfig-011-20240125   clang
i386                  randconfig-012-20240125   clang
i386                  randconfig-013-20240125   clang
i386                  randconfig-014-20240125   clang
i386                  randconfig-015-20240125   clang
i386                  randconfig-016-20240125   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240125   gcc  
loongarch             randconfig-002-20240125   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                          rb532_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240125   gcc  
nios2                 randconfig-002-20240125   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240125   gcc  
parisc                randconfig-002-20240125   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20240125   gcc  
powerpc               randconfig-002-20240125   gcc  
powerpc               randconfig-003-20240125   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc64             randconfig-001-20240125   gcc  
powerpc64             randconfig-002-20240125   gcc  
powerpc64             randconfig-003-20240125   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240125   gcc  
riscv                 randconfig-002-20240125   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240125   clang
s390                  randconfig-002-20240125   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240125   gcc  
sh                    randconfig-002-20240125   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240125   gcc  
sparc64               randconfig-002-20240125   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240125   gcc  
um                    randconfig-002-20240125   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240125   gcc  
x86_64       buildonly-randconfig-002-20240125   gcc  
x86_64       buildonly-randconfig-003-20240125   gcc  
x86_64       buildonly-randconfig-004-20240125   gcc  
x86_64       buildonly-randconfig-005-20240125   gcc  
x86_64       buildonly-randconfig-006-20240125   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240125   clang
x86_64                randconfig-002-20240125   clang
x86_64                randconfig-003-20240125   clang
x86_64                randconfig-004-20240125   clang
x86_64                randconfig-005-20240125   clang
x86_64                randconfig-006-20240125   clang
x86_64                          rhel-8.3-rust   clang
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240125   gcc  
xtensa                randconfig-002-20240125   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


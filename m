Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81789404138
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 00:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbhIHXAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 19:00:06 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:25953
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229997AbhIHXAF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 19:00:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPu0b+JDkq/ZC0JxyB6BNg3OwZ7ji3o5UjovTzBdWtMzL1SocATjZ2O7Jysh9BJOh8h+djd59LFwqE4Q1uPVGjJQJFLrsbGhzas1PQCJKpYh665ZJtwArqj4zns1Xkho4HsAq9ou6rCIcMJXkcog7XbudBPTWPMOnMj2jbcMod5lHPbpYKQdG0qP8ly7CjcQa8YHLdorPdUDRD//c5tFcaRCy51JKa0lLl4NsC8JILNjxmrhLSNQji5OLVvoNiqLzb3YdtAzEua4c7d6C/yKDWMgAXM2mHeAgwe93KXTwd4rh2OPaZTj0KcNy5t6RLc/Q6bjoB/hLq95kQJXrOhA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7Wh2FFXsJRDtCqhHeo4NGZGQQSRx6vJ90yxYFUVmHqY=;
 b=OFn8JEyWPasNOG1h5TOQMV/whVBs0BWXi472ElAlTTqzfUHBKhLBseEZxniBcKIUc2UtzU2NvjuYA2XPWkcWPSoBnhn4wMqBw8voldmrln3xURmzb6lljCP5OFtKb9SjVxII0vBKmVQbyI+0Wb0vkSBorDZItQu20KgO2iMezmF53/EoLLaPMbMWITonw2WS7iQEPpamKQjsrUgfOoEYlnu1EccdtM3Acxr+FJtUL1CbuJkDCZxcl7qMifCGlE/H8hoyGE0vowHjkzYlVCobnjN5NMycpiuIzLWRFNPReUU7P0mXi8ywuulU0MQojOQihKMNI8CMkHeuZGaq39BKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Wh2FFXsJRDtCqhHeo4NGZGQQSRx6vJ90yxYFUVmHqY=;
 b=bU+w2z9vlwNclNtevXBdzfIrg5DLck5syjSbqsD3R50+ARmaTzDju6S2ggOSpaWWkBFRnGG9vyYGrRoWA10v3G36/F/6AZ+trQalpNOCAR2Hu4TTdwNZVqH4fZ2fPFU8v+4WnXOJgAxDk+olxKWLgbDFO6bPFlQPkkl+wwagcwQ=
Received: from DM5PR18CA0081.namprd18.prod.outlook.com (2603:10b6:3:3::19) by
 BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 22:58:54 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::9d) by DM5PR18CA0081.outlook.office365.com
 (2603:10b6:3:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 22:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:58:53 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:58:51 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-graphics-maintainer@vmware.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Baoquan He" <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 0/8] Implement generic cc_platform_has() helper function
Date:   Wed, 8 Sep 2021 17:58:31 -0500
Message-ID: <cover.1631141919.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8edaccc-5d97-45c7-b500-08d9731c3b44
X-MS-TrafficTypeDiagnostic: BN9PR12MB5195:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51955B56FFF2FA3E4078B327ECD49@BN9PR12MB5195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPQV3Dld0tKh03daLbVsw8fNE40OpEf6zkH4Hh4z7l/FAYUN/MPv82J4MeHd87eSFtlQ8dRQ5QO+7UZ8ghypbyg1l34pNPEPcVI3RWyRii4bHyLgflt+hmUWSgMSpIkxR4V9+bs36hzwwCdIDa3A5cN252dbn9p3L8xUCpM3c8uCkjL2D70B4NzpTGMqGRowi5LbfviG+v7XzaRQV6nsJr5MpzreseU11nNTcIh8kePueBrzl2QLFLER3V62KEiPALgln4ipFMHqLeekGgR3KXItUimhMnszmnAk8eXUJOW3yjaPRwl/54zrhkoMQDvQPSbMxCbt6Om1ibNsjtR8o5F7K33JEhRDaKSqW5NftdqCeb5teCpBR5xMecmhFenFiYmbHvX3gsaRYNiSRU0DRgqwxBMA8W0kvqdcRAWma8peJ1A8mQlOfKpbDKQyMopWExjcSvXe09Q5L5br9wiOSBQyrShpkvyQNZvEanwBZ75wYYoYsbO0Gfp5nci8o666rmnhxGfNc8ixysJ66NOKYTP5mcITphxkY/rJswvgO+4qvZWbFwKXav+9NDKU1I8Hdky3P6/cjpB290suAG6ib8SCgu8sO6QP4eznN3AngfsaYrqdD7nczfasB2zApCzy2XIZr443JHT08SR6BFZqDBw4EBFc1nRqKMUdGtNmpRdEYzkJlTQlCSRjLKo09VwObdWxFzqECBKKdRHJQoq36HFHkriIhqK+8owFy+4NRo5jziTWZr+STXGQt3CO/l+j9XjB4c0XigDlF9tBvkEcd4t5ycgWWxQy5EfUO5JKd1XQImAeAp1GUKGEzUuqHgFixX4hfsAsMdrwmU2gji+ef0OjBiqaYvrrXQIbTd2fL7tdCgumDFgrxgJcT4+VfDYQhdDqJUyDeGf/9JEymi7Nehxt22yklmAa907ANajbWk8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(4326008)(7416002)(478600001)(7696005)(81166007)(47076005)(8936002)(2616005)(36860700001)(26005)(6666004)(83380400001)(966005)(2906002)(336012)(426003)(186003)(316002)(86362001)(70206006)(70586007)(8676002)(7406005)(5660300002)(16526019)(921005)(36756003)(82740400003)(356005)(82310400003)(110136005)(54906003)(41533002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:58:53.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8edaccc-5d97-45c7-b500-08d9731c3b44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series provides a generic helper function, cc_platform_has(),
to replace the sme_active(), sev_active(), sev_es_active() and
mem_encrypt_active() functions.

It is expected that as new confidential computing technologies are
added to the kernel, they can all be covered by a single function call
instead of a collection of specific function calls all called from the
same locations.

The powerpc and s390 patches have been compile tested only. Can the
folks copied on this series verify that nothing breaks for them. Also,
a new file, arch/powerpc/platforms/pseries/cc_platform.c, has been
created for powerpc to hold the out of line function.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Will Deacon <will@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>

---

Patches based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
  4b93c544e90e ("thunderbolt: test: split up test cases in tb_test_credit_alloc_all")

Changes since v2:
- Changed the name from prot_guest_has() to cc_platform_has()
- Took the cc_platform_has() function out of line. Created two new files,
  cc_platform.c, in both x86 and ppc to implment the function. As a
  result, also changed the attribute defines into enums.
- Removed any received Reviewed-by's and Acked-by's given changes in this
  version.
- Added removal of new instances of mem_encrypt_active() usage in powerpc
  arch.
- Based on latest Linux tree to pick up powerpc changes related to the
  mem_encrypt_active() function.

Changes since v1:
- Moved some arch ioremap functions within #ifdef CONFIG_AMD_MEM_ENCRYPT
  in prep for use of prot_guest_has() by TDX.
- Added type includes to the the protected_guest.h header file to prevent
  build errors outside of x86.
- Made amd_prot_guest_has() EXPORT_SYMBOL_GPL
- Used amd_prot_guest_has() in place of checking sme_me_mask in the
  arch/x86/mm/mem_encrypt.c file.

Tom Lendacky (8):
  x86/ioremap: Selectively build arch override encryption functions
  mm: Introduce a function to check for confidential computing features
  x86/sev: Add an x86 version of cc_platform_has()
  powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
  x86/sme: Replace occurrences of sme_active() with cc_platform_has()
  x86/sev: Replace occurrences of sev_active() with cc_platform_has()
  x86/sev: Replace occurrences of sev_es_active() with cc_platform_has()
  treewide: Replace the use of mem_encrypt_active() with
    cc_platform_has()

 arch/Kconfig                                 |  3 +
 arch/powerpc/include/asm/mem_encrypt.h       |  5 --
 arch/powerpc/platforms/pseries/Kconfig       |  1 +
 arch/powerpc/platforms/pseries/Makefile      |  2 +
 arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++
 arch/powerpc/platforms/pseries/svm.c         |  5 +-
 arch/s390/include/asm/mem_encrypt.h          |  2 -
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/io.h                    |  8 ++
 arch/x86/include/asm/kexec.h                 |  2 +-
 arch/x86/include/asm/mem_encrypt.h           | 14 +---
 arch/x86/kernel/Makefile                     |  3 +
 arch/x86/kernel/cc_platform.c                | 21 +++++
 arch/x86/kernel/crash_dump_64.c              |  4 +-
 arch/x86/kernel/head64.c                     |  4 +-
 arch/x86/kernel/kvm.c                        |  3 +-
 arch/x86/kernel/kvmclock.c                   |  4 +-
 arch/x86/kernel/machine_kexec_64.c           | 19 +++--
 arch/x86/kernel/pci-swiotlb.c                |  9 +-
 arch/x86/kernel/relocate_kernel_64.S         |  2 +-
 arch/x86/kernel/sev.c                        |  6 +-
 arch/x86/kvm/svm/svm.c                       |  3 +-
 arch/x86/mm/ioremap.c                        | 18 ++--
 arch/x86/mm/mem_encrypt.c                    | 57 +++++++------
 arch/x86/mm/mem_encrypt_identity.c           |  3 +-
 arch/x86/mm/pat/set_memory.c                 |  3 +-
 arch/x86/platform/efi/efi_64.c               |  9 +-
 arch/x86/realmode/init.c                     |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  4 +-
 drivers/gpu/drm/drm_cache.c                  |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c          |  6 +-
 drivers/iommu/amd/init.c                     |  7 +-
 drivers/iommu/amd/iommu.c                    |  3 +-
 drivers/iommu/amd/iommu_v2.c                 |  3 +-
 drivers/iommu/iommu.c                        |  3 +-
 fs/proc/vmcore.c                             |  6 +-
 include/linux/cc_platform.h                  | 88 ++++++++++++++++++++
 include/linux/mem_encrypt.h                  |  4 -
 kernel/dma/swiotlb.c                         |  4 +-
 40 files changed, 267 insertions(+), 114 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
 create mode 100644 arch/x86/kernel/cc_platform.c
 create mode 100644 include/linux/cc_platform.h


base-commit: 4b93c544e90e2b28326182d31ee008eb80e02074
-- 
2.33.0


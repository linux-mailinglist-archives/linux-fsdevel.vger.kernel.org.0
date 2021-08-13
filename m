Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1E3EBA7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhHMRAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:00:18 -0400
Received: from mail-bn1nam07on2045.outbound.protection.outlook.com ([40.107.212.45]:20905
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233944AbhHMRAR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:00:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YecWqdxpsUyhpB1XAJVOmdJO6pp43+eN37KdIh9u8lCdySkg5f7E5AA95L9jlKPvGyRWb8xcYfXGpz4RZqS5vzIjc/AixahbV0V6vQ5vVCbAs1htAyusl4QRNQEnrvkcHMPob6Wc4yByOvCYQVpooxq2Tp9voFShxje7t55jQnIWeDvlWCzxe/Q3yRfWFzpyBZGLR1YKIqaHj8GA+Ngf7OPqT4x2IbM+2C+wAeEG8WrWZQj2V9oq3mW6v1V6jZiSfDNWnznMx5NwiGWhkdwrsFXiHJPvezyBLwzy8CN9pq4l88yEVrQ9uGNFfZu8pEtrHcfUAUSF1OubcaA5WxXO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWzTLcRgQIBHZlbZOTVWx1Rv9q0wGjrnFS2LFcomRVM=;
 b=O6+Nx+/iaAY60NOM2EKEKVXtCuzvCLFmpWGnqxO6DQ0l3o9WISBB8QkUhYuhWyF/90Eco7dgAz4S0vDIIXEgkZH/573AVDfP/I8/sTC0h4E1MHGYdsTw/Z2XIeMq8PNpXjC25yyHPwBfCdqv6H2bKgFDOM/QrE06uj2iKbVJgIEKkDaImxFOgkbP6e6WnaT3z0Rg6AR+ra24QV1sPp09B8I+gwfnSrMGW8KmVHXKzWo8LxbuwDN5XhkncNxTsfuCJNeEQ2Io8HpPO1QlmEKw1URD/kBqZRZglTiDD/Q8TZDE0YBfWAlSjGw9nLUA6fbYI9F6TZBXkzY5OI8eOpegOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWzTLcRgQIBHZlbZOTVWx1Rv9q0wGjrnFS2LFcomRVM=;
 b=GP2tPUUoOmnmbDnKYTQ/sRPzj1ugGRdcBqma7+D9V5ordvm1GHahoKzFCuNmn0ORbxaWukZCi8ReJ1cA3nGxtzI4INF+oGj0HVLbCPRHXBD+Qsiimv8toD2aO7rOlfUsQaHiDsw2eU4rBCRjqL3tYHiQrFtuL4QBjuLa8WobFOQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 16:59:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 16:59:47 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
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
Subject: [PATCH v2 00/12] Implement generic prot_guest_has() helper function
Date:   Fri, 13 Aug 2021 11:59:19 -0500
Message-Id: <cover.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0181.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA0PR11CA0181.namprd11.prod.outlook.com (2603:10b6:806:1bc::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 16:59:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a40d64de-b98f-4120-9263-08d95e7bc1bf
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5518687F1DE01326E42EEAB2ECFA9@DM6PR12MB5518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Tlc8p598j4x5j/Lp8tz9PLueR/DIMP/xJV8yoxqvGn3wufIX0iALoCSnB6xHvPaobgaxv5qA/ym4kTHjgj17Gg88m3kGRKzi1O2/OixN85iUGAxMqmOtAy/9dKVRJz8FB02/S2vY5Ghg/KFhOluMg0Lsfi7dQrTapoBm9uFuUBXdDvALipbFlkAQQz3/d+m2YNVoESsNfxicYs4umn7mzKSbUK6Lew8LB2JraprUxxyhfneCxbTRivywfHGt/qSATpYGzlrRpH5o7AErQPorPyTVblM6rfCySZ1+aS/oQFsFeO0gYP3rNbF3tPgmfOBeKDfeGB8vHzMwO64vHxkVrJ8CB4U9kFQQvLplo3nsw5u7CZrmFMNUPbaY0BIwOr6u1Fpqu8Mg1LWq8todTYpPv5ocir6Fu0kvxX5ARwhC9IC5vzXPHGUBIx2JXT8RuszsxDL9+GRreLgCTR6DwCva/oVBP1x6/NFDEUXnwsyY4PcRS1gT152ddDfCkGJj7O0IX84ktid4Csby4zQIoYjcLBNmbAFY2EdkcDx5aPgfBSRtOUe8Cw+xyc7TLgWzLyocW9BN5fI2vmczOGQBlH4HAMn2iUhJe7dPe1xDI+N28M0dTjgT72Y6FNRvuCEe9B+QkZIr0tBoW8ezEZRkejd37kPxZFAo0S0bl52kt8r3+1iOoWZPKtxC1fPu6p0FsMhW4i9mtcpw70c21FAuvmzJ73pr2wOU96NCigUcLKhFjb+lbV4+m0KRyqOlKMZXgKqjQgS2u9O0WEFn2m41O6N4uLCwIoM798gbQC9vCMHiZ0tCJPzqvzg21mXgARxlNtEbZOxMH2J8zFNCo5vTlBt4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(66946007)(66476007)(966005)(66556008)(478600001)(921005)(7696005)(8936002)(8676002)(26005)(52116002)(6666004)(36756003)(186003)(86362001)(2906002)(7406005)(7416002)(83380400001)(2616005)(38100700002)(956004)(38350700002)(5660300002)(4326008)(6486002)(316002)(54906003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+cNFt6anDiaWU3AK+8p9O5t7ynHjjKJp3ojthH0Zk8QoI1GDqL0paf3WfbCs?=
 =?us-ascii?Q?73rxogGxgP4TYedg+o6cTXd9khz40t+q/+OeHEOu4VQ4Yv/+v8FtTe2QSgjL?=
 =?us-ascii?Q?yRZJf+yxILobMp7Bjiv4EVi627qpSOHMGRUwWUqV9ynDmkRo+7t//+hS+CJI?=
 =?us-ascii?Q?RR5Her4lR+fGWnN+2vEW4K3FmgQIiER12JR04HDzCq9gmA/D5XowL9HDjVAe?=
 =?us-ascii?Q?DKxJ9eQsLDRRaoW8FvbXSxAAoSc4uyNKRTHDxOyK3HIRAXA0PsbUXRFfo8eq?=
 =?us-ascii?Q?inRp1efyQCjYK+3DQ9kA8XShY8XWoqbaoXrCDXND59RzA+QAC4nsc9T8aNcT?=
 =?us-ascii?Q?fjsNR+dGuZS2mHV0LEdxH5SFYaYVuydfPrxCPN75Tm+VCwE9XW0NV6YM/JEw?=
 =?us-ascii?Q?ASc0/c3ORcbHePik8bwpkI+H1NwxozpE/G7Gc85XAdjolNoNtOoD/p59XSyF?=
 =?us-ascii?Q?9ExR//vLRXCVwAetqc6YuODZ2MW29Kmv4ehHjKHZ37b0z4amJK1nnHoQSYzj?=
 =?us-ascii?Q?iWv0BnqNdcxTY8gbqnsk0vdLDOR6J08a3CES7G6TaQS9ZoBqXQZqi1twUGfI?=
 =?us-ascii?Q?YB4Wsxm44D4OiX4gBTRnjxP4o9+ACdYCisktYhvrs0ua/iDh/KEG7BN9lEKV?=
 =?us-ascii?Q?dYlbO1h0p03SkPZr0I+zqVtJ5qELEYGFEAK8qjXcjI5RXk/oMSFOLWN5P4GD?=
 =?us-ascii?Q?T5t3JIoVeF+2MJ/5WHVGL3YD4Bf3jRwo7hk5B0BEhbjHME1GhuUmqmN7OPil?=
 =?us-ascii?Q?/r+DEeYN4ktk6aWvDyX56obhpICoyDzauv9fMhw8UBiJUhhen2WrbAgEk95Z?=
 =?us-ascii?Q?TlZLN7Td3jf8FkNKUqlaVzyju+FRUTMFgr6tI+Hv4e7NDnxeMTnakJiuZG1z?=
 =?us-ascii?Q?pov8I2uOLmtVukMxymrdRNpkcnnPBPwKv+Gr0MlFN9jUE3M6exCvuYmete6K?=
 =?us-ascii?Q?y+7X1F1Zq258SCGZozazKkg4QUEnc/FO3vgiKM6TpxWi4d9sKoU81fXWKxS8?=
 =?us-ascii?Q?/TM1+2tgxiF9i2KfH0Wi3vHhBuYsnUV7NpQQGpYRuVHdDr2J1VvERZb2zhEI?=
 =?us-ascii?Q?R0IW4z22+5fol3PBZ3iEIJHYLLZmEEINbZ9czrabrNQFqBxlwGSC3SDEqW/C?=
 =?us-ascii?Q?3RlndvmCdqL97VywfrGRrHgIRjbh8tKxcKnWhOutVuKiEK4HcuocFACAVGgs?=
 =?us-ascii?Q?lpLqjiGRfdU81J+46M+4YA0QEKBtf2W43cDhzKt4pZDxg6NPyZpvZYAhSL5Q?=
 =?us-ascii?Q?ETk9hARbR8CH3+OR/9xsEeBZbKd1QBOyrVXYFnkZH47vmnHQzWzxfdyoFtzW?=
 =?us-ascii?Q?w+LYu/MDYFySZ0nakn5+az9P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40d64de-b98f-4120-9263-08d95e7bc1bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 16:59:47.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYp6yT+9lSoVV7NLlbbh020IR6qxssckMjTIgYmpR7D6u6pyPE7XxnAMYb5IEyfY+PXxRhCV//fDcjgg9wtbPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series provides a generic helper function, prot_guest_has(),
to replace the sme_active(), sev_active(), sev_es_active() and
mem_encrypt_active() functions.

It is expected that as new protected virtualization technologies are
added to the kernel, they can all be covered by a single function call
instead of a collection of specific function calls all called from the
same locations.

The powerpc and s390 patches have been compile tested only. Can the
folks copied on this series verify that nothing breaks for them.

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

---

Patches based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
  0b52902cd2d9 ("Merge branch 'efi/urgent'")

Changes since v1:
- Move some arch ioremap functions within #ifdef CONFIG_AMD_MEM_ENCRYPT
  in prep for use of prot_guest_has() by TDX.
- Add type includes to the the protected_guest.h header file to prevent
  build errors outside of x86.
- Make amd_prot_guest_has() EXPORT_SYMBOL_GPL
- Use amd_prot_guest_has() in place of checking sme_me_mask in the
  arch/x86/mm/mem_encrypt.c file.

Tom Lendacky (12):
  x86/ioremap: Selectively build arch override encryption functions
  mm: Introduce a function to check for virtualization protection
    features
  x86/sev: Add an x86 version of prot_guest_has()
  powerpc/pseries/svm: Add a powerpc version of prot_guest_has()
  x86/sme: Replace occurrences of sme_active() with prot_guest_has()
  x86/sev: Replace occurrences of sev_active() with prot_guest_has()
  x86/sev: Replace occurrences of sev_es_active() with prot_guest_has()
  treewide: Replace the use of mem_encrypt_active() with
    prot_guest_has()
  mm: Remove the now unused mem_encrypt_active() function
  x86/sev: Remove the now unused mem_encrypt_active() function
  powerpc/pseries/svm: Remove the now unused mem_encrypt_active()
    function
  s390/mm: Remove the now unused mem_encrypt_active() function

 arch/Kconfig                               |  3 ++
 arch/powerpc/include/asm/mem_encrypt.h     |  5 --
 arch/powerpc/include/asm/protected_guest.h | 30 +++++++++++
 arch/powerpc/platforms/pseries/Kconfig     |  1 +
 arch/s390/include/asm/mem_encrypt.h        |  2 -
 arch/x86/Kconfig                           |  1 +
 arch/x86/include/asm/io.h                  |  8 +++
 arch/x86/include/asm/kexec.h               |  2 +-
 arch/x86/include/asm/mem_encrypt.h         | 13 +----
 arch/x86/include/asm/protected_guest.h     | 29 +++++++++++
 arch/x86/kernel/crash_dump_64.c            |  4 +-
 arch/x86/kernel/head64.c                   |  4 +-
 arch/x86/kernel/kvm.c                      |  3 +-
 arch/x86/kernel/kvmclock.c                 |  4 +-
 arch/x86/kernel/machine_kexec_64.c         | 19 +++----
 arch/x86/kernel/pci-swiotlb.c              |  9 ++--
 arch/x86/kernel/relocate_kernel_64.S       |  2 +-
 arch/x86/kernel/sev.c                      |  6 +--
 arch/x86/kvm/svm/svm.c                     |  3 +-
 arch/x86/mm/ioremap.c                      | 18 +++----
 arch/x86/mm/mem_encrypt.c                  | 60 +++++++++++++++-------
 arch/x86/mm/mem_encrypt_identity.c         |  3 +-
 arch/x86/mm/pat/set_memory.c               |  3 +-
 arch/x86/platform/efi/efi_64.c             |  9 ++--
 arch/x86/realmode/init.c                   |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
 drivers/gpu/drm/drm_cache.c                |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c        |  6 +--
 drivers/iommu/amd/init.c                   |  7 +--
 drivers/iommu/amd/iommu.c                  |  3 +-
 drivers/iommu/amd/iommu_v2.c               |  3 +-
 drivers/iommu/iommu.c                      |  3 +-
 fs/proc/vmcore.c                           |  6 +--
 include/linux/mem_encrypt.h                |  4 --
 include/linux/protected_guest.h            | 40 +++++++++++++++
 kernel/dma/swiotlb.c                       |  4 +-
 37 files changed, 232 insertions(+), 105 deletions(-)
 create mode 100644 arch/powerpc/include/asm/protected_guest.h
 create mode 100644 arch/x86/include/asm/protected_guest.h
 create mode 100644 include/linux/protected_guest.h

-- 
2.32.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6333D827C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhG0W0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:26:48 -0400
Received: from mail-dm3nam07on2041.outbound.protection.outlook.com ([40.107.95.41]:19744
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231730AbhG0W0m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9Id0MgxE+d86OU5IRH9zmd43UxECaZ+B5kjhSPCMQydhfr7AKcRTj+vupBwOaPAAtKUT31LnFYhX2WMyXbi6v4zKOS/JDEFLi5mrQQN6Wi18iBDQPmfWx6uQdCcmBEsQGjY+i7E++8oJ+i6sxeux0X+4muPQw2C07FBX0rkByp73ulXOccfbLdApnpWFtm7w6mUJrru6zrxf6zIpF/21iiDdldnmRyZwtzorpUugAr1aPWDfNxU5zRQlbxdEHFFmJAKE4bu0u8Rrcgmpnl6spvXsW+0ZjE7r20KfDT0wGlEvHsuqKHwwhW1h211A9U6A/c+JIJZRQ4vXKKMHp3xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh9WV4Bi2lUQnfZE/QgCYWFV0BrT697DbKGp9nczLr0=;
 b=A3C5gfFkOUw50sa4VQJIhHr83BuR+F7vkU2zOTa6HUgjorVejVCHWJ42ue+pAI3som2ESAeLNtE0FddI1+hd4duJ/ycSIfu2Cpv0VJ6XiKl6FMS5FvMSt4xz8NHm1L06r1KzV5sfEJ/g3KrMcNYblHi9dL1NA/U0olosuNCfeB5YDz5GbRFMrjRywCoSrE6ljKcYAD2JDhEMOicr1CqlEUJE7plkgw/ZafslUp0Md8aDT5H8B52ASLzS6TUwoDx9Gqz4+AjkmD45Cc6E5nCYpf2Gb6BcPYZUc/hij8fLI9vYxu+yveM01UbmLz788OIDKTlEd6NGfxxgOppsb6TbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh9WV4Bi2lUQnfZE/QgCYWFV0BrT697DbKGp9nczLr0=;
 b=IMiZo1TudiL9gYAUloUs9Pf7ipEHBGXHLJtHZtM4pKx9RkKvgftSQ3Izw1i4A5+tQcu2j/HfcRrXXIwAxk/rJh4u+yMdKw2jqJLq8RMqU/UmrLNaKLs5vYBPn0TvjauY2af0/2AAZoq5JC6HBpqWgc5EyQK+qkutB8UjA+5ITWw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 22:26:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:26:39 +0000
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
Subject: [PATCH 00/11] Implement generic prot_guest_has() helper function
Date:   Tue, 27 Jul 2021 17:26:03 -0500
Message-Id: <cover.1627424773.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:806:27::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR13CA0129.namprd13.prod.outlook.com (2603:10b6:806:27::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.11 via Frontend Transport; Tue, 27 Jul 2021 22:26:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dd6f380-a94d-4189-a68f-08d9514d9a5e
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB541624EC7B23BCC92BBA1C2AECE99@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypg0SFNtbzBB0RsnmARVE4LdePcQWM4LVL+7KnUssFPsFUJN+vrCDPIJ6eYPtAMhOjH1zr4NkhdDEDuFXEdB4jfeVUvhbXzJ/qCqbbfkLvHYOr4QS4sXm7/m4cphJaWvwF0mh2Xj+Sub3hmiqHaG6AbZ+cktNeWNnntN4jHIWLjLj/odyglhVQuqb71EEzcr0FQpgzcH/z9dHui/ZayHGKglPRGkW6ynARRrWyjT+lvrH16kNTj8EQEttlJ9E/BJ18DwQQQUdwl0id086c7CGYPtC2hbg6hMCc7lRgOlpVu0mimRU0zqcFsIvGKt1NMLObQdyen8oi/Lh9jJc7VxdrlAwFMhqLPzjvvTeCJMrwmr5qMwQpZreZxzYQhbyC1EIH1znxiYplKIZOS2UBmQKZZ2xId8UA1ApswOmOfSfcx3CzyBKVGm7NzRjav4jy9VxWV1bKUJPmyo2m4CWfX5noP81OHGVdl2Xm13829ULb2dIek3V2dXgJIc11+GC4t0USqV7/kcX9//y8ZJE9dzZ3Q8merXFkOP7eqTO75g4aHu1XYb8UNl16DjfiCcCLEC0bQkoZIvvhIa585mciqZTR4oJ5VBkFkaihas+vE1Cr5n3vgvvT5ForNNUW7D+Nsj2yVZRqLHJPe69BBVZgrvCo4lo90zcuIZECd+fy6KupEK4SlLUGUy5iy6Jf0W5QDwsaWTvWOOiPPCN6ehc4hEBisJrd/y4SxSvUjG4iX6hCEkX+EsdDY3u7Hs/2ylXgSMJ2Imq8O1rMVxvKvjPDeberLewqjt/BesWeCS3fgNztqLWVA2QQD+5CJeF3t+7xPw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(66556008)(508600001)(966005)(5660300002)(2906002)(6486002)(83380400001)(7416002)(316002)(54906003)(956004)(2616005)(26005)(7696005)(52116002)(8676002)(7406005)(921005)(36756003)(186003)(86362001)(6666004)(38100700002)(38350700002)(4326008)(8936002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aJnRTpan4y5HRpkYVUnzMWiZ4RxV25R9l2eVHtxCLQyM3DYnzrliquhdbrLj?=
 =?us-ascii?Q?k1yifCAMe99mX2I3/KEGRuxnquZ/4ru44MV/Rl1ovfUhyCDCFkqzkmiq2umY?=
 =?us-ascii?Q?UUiD1P4ZZNXEMByxNCu/sMDnDqCBDd9x0DwHn6m38L6bHH/UcrtrmR2MGstE?=
 =?us-ascii?Q?ciD+SVGn8kuKbcSR3Ag5Hh+AMC+HAcjANDav4++LMsuwu5AkzuSyts2txCOF?=
 =?us-ascii?Q?vauZ39Gm6jBGqFZ4RwaX11J2SBLbKy2pmZgSEPuw8ORt4XjaEq5qb922BvI8?=
 =?us-ascii?Q?nlEI5p224WvGG+0whgW3Kl45c8Gklm7goT6aLwr4bp5AKlwWMuSkTwHQEF6+?=
 =?us-ascii?Q?EWIavbRPP5DcbVxzW2Qzmi2Js4KVPPiU4LyqtBwmKfhk0j1mlM8DQlTT8z8d?=
 =?us-ascii?Q?+1F0l7ObQDKBvHWvrrpQS3KzWDdyOfF3dqAXoOAB0pgoGoLNEIk986hZB7cH?=
 =?us-ascii?Q?/r9sI+MjU3BfuWh6kfknRBqPQOmmS+3sQhb/MKhPF0uPAZFo+hfoiWOQk97B?=
 =?us-ascii?Q?t9FNGuthQXPBIngIduZySMXfhCGuMNqJH+NRZUGnntpP5Kh/xIRkmaENsDaL?=
 =?us-ascii?Q?XxYf1qPn/iInAt2pdYE3j/tqYfL3M289D1o2UHtiAkbWij68tk+fBXbWxWh2?=
 =?us-ascii?Q?8wlzGRSUoWrh72xkMpRjb/3wjpPSVyljZTYXcCLR64j5SNnUG0LzB2GOzy1W?=
 =?us-ascii?Q?DwWDrkWLciLWQHRl/72bSNiWeJJL9c7kWQpFf2QFlY+O8XvIf8ein9qEcd1F?=
 =?us-ascii?Q?F/vC2l+9jupfr7buDz5ozI9ODuf4vDNDr6k23OdV23D7Gon3jtPivmnVk1NX?=
 =?us-ascii?Q?Q6OFKaexHuAwuUJKJKpJ01YKrvmTVHU4jJE7V3cU0JwgRPV0ev7h5nh90rbf?=
 =?us-ascii?Q?6lSR8g5TV3Owdxn5En0x4p5ZxwEGmo7YfJzMp/3O04mMzhVuokOyr9eX5lLe?=
 =?us-ascii?Q?s4tR2z1v/3+zghl85PMUzIxLlpKitIQDVlXnEdEx/E0Xxv8ssxAQSvp5TzCZ?=
 =?us-ascii?Q?OVzjJtLQ0B0mWKp9Iwcm2HC1E7f51KTQSI1FZ/ogpQNWR0S64rvykj1ES5OX?=
 =?us-ascii?Q?BAbquEpO+73c9kjqDdgjWFoOfYpeVWWF9r45TjZRV+LygQqk7uQsMP42858E?=
 =?us-ascii?Q?7nbhgq1Ui2NEXUAl/QKmLbFweGnhZWo3E15IwTNsLpf5ubxO7vKrSpW8pcVn?=
 =?us-ascii?Q?0cJ7scFgi7bfHX2JL7l8XRq+7fMPmXn6s4jQ/jV8N+lVrgUgSp8QC3NyOw/m?=
 =?us-ascii?Q?4HidL1Tz7f09rPhgXrpS7TCn1HNV0UQSejP2CvomnJladVJxskMWYI0PUx+x?=
 =?us-ascii?Q?h9p4/Zv/sYdDUWImLwoK+L/K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd6f380-a94d-4189-a68f-08d9514d9a5e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:26:39.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31LZpPx2OLl8h3x8z4/dqP6dzfZSbFJk98bRtjbtIgeHtv4SPsg04KM72vwoC/bmaKL1Ny770jXOYIABe9+a6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
  commit 79e920060fa7 ("Merge branch 'WIP/fixes'")

Tom Lendacky (11):
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
 arch/x86/include/asm/kexec.h               |  2 +-
 arch/x86/include/asm/mem_encrypt.h         | 13 +----
 arch/x86/include/asm/protected_guest.h     | 27 ++++++++++
 arch/x86/kernel/crash_dump_64.c            |  4 +-
 arch/x86/kernel/head64.c                   |  4 +-
 arch/x86/kernel/kvm.c                      |  3 +-
 arch/x86/kernel/kvmclock.c                 |  4 +-
 arch/x86/kernel/machine_kexec_64.c         | 19 +++----
 arch/x86/kernel/pci-swiotlb.c              |  9 ++--
 arch/x86/kernel/relocate_kernel_64.S       |  2 +-
 arch/x86/kernel/sev.c                      |  6 +--
 arch/x86/kvm/svm/svm.c                     |  3 +-
 arch/x86/mm/ioremap.c                      | 16 +++---
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
 include/linux/protected_guest.h            | 37 +++++++++++++
 kernel/dma/swiotlb.c                       |  4 +-
 36 files changed, 218 insertions(+), 104 deletions(-)
 create mode 100644 arch/powerpc/include/asm/protected_guest.h
 create mode 100644 arch/x86/include/asm/protected_guest.h
 create mode 100644 include/linux/protected_guest.h

-- 
2.32.0


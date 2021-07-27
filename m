Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA593D82C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhG0W2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:28:21 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:51599
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233379AbhG0W2D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:28:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/CyODtLAIKHPu4OZ5HkOG8fOXcidjGJjV302Mc73LEfK7hirYJDzCGrWegs9WokcTGxp+zQKhg++GLeBAKAOMalbkAV7QH9Fk88E/790JvjvX16e5WbVGH3abdNrTf7LrrHkksQZHz+cH1rckOUmBgSbzTwWLy9Hg6jZSdpus/jyGhcKSVROBNDLsNLaVzpg6hYyyR0ZX4gVsnM4pVlHh29VTH/nqXgmRgtD4Ap9YcHcZeN+MzfdiAD7e+lsnfpOR/ar55ftDqk2zxEecsIUsqkh3K7/WAEII+nUXyex6IqKzB19kNjcIFS/AOBG9uVnXyS7EdyrR8E0uLcPNtRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXN4zJvX7fQnk2nAZcPyim1SCQt+IA2vttWwJbsOBZ4=;
 b=HHYwJtnnCHcspdicxprqO6148ZhcfHQkKaMqjzb/92vhhibaY/pBn+bb0NMBgRvQDIM05/VamV4j+I/JMLwxa3dsW73B23GaQsr7zUCnFNayQb42a8JwWFWQ3f05sjCPLXipXtVQIunRevCm11EJDlWH1Rno6ip5WgO+C5c3zUJQPVIT1iNzpVHdHGzu5IMBsBVvuqiOy5WJ6S0hOQ1Q7ss850Q02KKT1WwXAQ3nDzIPYc1Q2vRhn3Ugj7cm9QPw1K9z6hRldQlyOS7DvVthgyn8irrdDm945D0QzzOpCIgsDKATpBQM/LOmAq/XHpbPRNNv1a1V8v9A0N9LsfmKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXN4zJvX7fQnk2nAZcPyim1SCQt+IA2vttWwJbsOBZ4=;
 b=SyKasOPlEm3GGOCpRIDYFV3idTz2YvN34xQTuCO7HyiA82fD+Mt1SW32rRWFTq9QG+rM9WH/+td7XrFxts9kH9K9MGjo7ZyUR7gwMurMbtpvJEX0lPsdS5i638HKSZmIlVx+dXvnzr9NpzsdNZpwICVZd3dVoND10o3jCmof4Ok=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:28:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:28:00 +0000
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
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: [PATCH 08/11] mm: Remove the now unused mem_encrypt_active() function
Date:   Tue, 27 Jul 2021 17:26:11 -0500
Message-Id: <fc1205e6c5cdd7ef6c4135093fb141018ca2b70d.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN6PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:805:106::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.2 via Frontend Transport; Tue, 27 Jul 2021 22:27:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 440c7b55-25c3-4298-6cdb-08d9514dcab3
X-MS-TrafficTypeDiagnostic: DM6PR12MB5520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55201CADADE0F38F5694A64DECE99@DM6PR12MB5520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WB6gDe2S35FRxPUP7RUdFzxC1YI+kVwsS2ex2pjWrBkj17JIl8PYfwmX7u2Yn589xPAWoDmsYmnLvlJK+hFaoDzEzt4b1QNobjkONp1CjgUmWb/B+OxnPtIF8z+VyoxBEBVjRQZ6VTvahVLh2F89rO/itJX11xM1AipQYrzR2lujhPJy1P7LziuT8o49gvHTG/QHNkf/a9u1kmOy8ean5GSVrYjtiZLXxMpxl6J4urcYbSo9UFY6xuZWdhvi6GwYjTPOnSVhaA9MFozJJyG5hyeUhMhoMK14X6qShv/OXc7WLQ6JvhLVwsuZacp1zMnIFpq1cL38TDmofmKWK5EcB8odvBXoxrvXbdvwvZyaUgk9OILGs9EudFSe22AmRaLHRWFvP8A/C7zSTn6Y0ZJHtJUiVMOeMyPbED4o2g/GquUvrIiJ8mT4KWqTV7ejovzGRNGMWn+UhaCdaA7amFhlW41RKBIZV5hVnTNaoTKAJqQ7Le1btIipiI2eyx7L9vFA3WN/3FuUr610+uuQM4tFM6Bg72HxZUmh+ub3YQxDONyB4/6+pbYst1MpQyMCcwDdgoK/zphKYiAhO9UV2PRaA204tHFJOlGP+BcHrjtWQWruRFQ7BtZzgl6GNb/NuH2jHbjYwd3C7nMcH14wm/on94t67mIoFBHBpc2ACnB49IY3WLFU44ZTINWqkH+7cmvo76lZHtdDHaQdz224+RWS87jUVUFJHrnCO5g3AWozjAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(52116002)(186003)(478600001)(38350700002)(921005)(5660300002)(38100700002)(956004)(8676002)(6486002)(54906003)(4326008)(2616005)(7416002)(7696005)(86362001)(8936002)(316002)(66556008)(6666004)(66476007)(36756003)(66946007)(2906002)(83380400001)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3NbPnPP9I7JALLiYBRw1I6VwYZMsnOeGvhd3dHNamDc8Q128muqLW4AtRjRT?=
 =?us-ascii?Q?s0u0hox8FU+K8vIjCiADtpTNBjdLMkFT/Fx176iOkmi4NYRMxJkoe2o3sbRP?=
 =?us-ascii?Q?/0HWn8T4JtpJ73af9s4TJaz0fjVMqV/zoQ8UhVGxK4myd1RmU8y07bLfR+aC?=
 =?us-ascii?Q?PyIvy81ufP8SK429pJwlQFp3dDnoxYKHw7Gln89vlmZLblh8n6wE/mPHX4g2?=
 =?us-ascii?Q?F+GhoUNF0Lhnl61o8f9vXHdy3z5f9y6SkEYD2wbZeg+G1jgUfT1/FOMfW8XT?=
 =?us-ascii?Q?L+N1flZaBi6epEy+Kd5D0Gc8mSXMXdhDCkp8i+gPThOtaU/YgA9QhQISLUe8?=
 =?us-ascii?Q?gzbClFdcvou+TNq3yC3omtZMYn6u4f/0HLvJAMvtmO11rWDH0Ul0lkToVas0?=
 =?us-ascii?Q?vOQkX+BJgtaPjs/wDwR6C+7Xt5KHX9OQd8MdDl/j8O8gyUb4Lw/sgi5V4FrW?=
 =?us-ascii?Q?pvBud468/GU4J7hy1hL51R2YqRV51vWRrj/pQHUWPm+EWHwHVXEtBHC2sZLf?=
 =?us-ascii?Q?kQ3gMeEb0UKg0iCgzi4c2N+J3KSpJAH7gt92MINz3iNRmZCstgxIe3lxwaUK?=
 =?us-ascii?Q?O4jFRI/paFZNcEanJojZZ4QM6yiguf82XwFjnehC2FMmgJ1vcq8TQbzVJWkr?=
 =?us-ascii?Q?2YNTOOAueOSTKYtCiVaz8ERHj9kFtP3148B1j0zmr+xw2x267rf2IDbWST9M?=
 =?us-ascii?Q?UlQYwyJ4sxwBRwJyfXY1NXuNlIvGgjq01i1vHXo0LrWzlMVYWtu/LBKUwLqr?=
 =?us-ascii?Q?1b6Ibvpa2u1lbEVXVLQn2zHqqn2hGyQ2evmVJpRxiRBw4+WeddmOWOf/+K7l?=
 =?us-ascii?Q?8vXcR3PSvIJpItN5k6xB6wmMFFZUL6Sru9izXYuTyIiRxQM0pnFo3hNSkbrE?=
 =?us-ascii?Q?YnvG+tIntVOHRrHv1+EKdnPi1u8oRb7ERD3t2aFPbVzxz9LmcSz5QAargMg6?=
 =?us-ascii?Q?QZdb1QCu7ZxgY5NE9e3AEL+6mj304LXZ/7jFzu2Qd1qYJxVhd8XfhgZppqqg?=
 =?us-ascii?Q?DHyvLl9HpId8GFZtPBVqYekUuP5ZADVpJWuMHBAjxrQs+sHjkpt8XyAL0VRP?=
 =?us-ascii?Q?fClM4Da48RyRECLACfw/BNIVWfHJQFp133DJ06JRYXiuD5RC/jf3g16W7/DB?=
 =?us-ascii?Q?7TUVBWHs5Pre55sgGijTt5E2Am+b9OAU5AztiUp879kFkGXCFN8IU2sP8MgB?=
 =?us-ascii?Q?vUOGwNamfacv1tzadFc4NoHDsDUWJP0ffVrPrk/rCtYU70PVhlqgJMr/bQ40?=
 =?us-ascii?Q?Qu5r4UXKCZ/HxTLkdiqCqIsopqkrhp5n1y6E3KAHNdktS8L31aops3p6st9I?=
 =?us-ascii?Q?vsAh09dlQdt2IopxlnuPaYg8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440c7b55-25c3-4298-6cdb-08d9514dcab3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:28:00.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnbSSh5hLkL+L4otK3IGb1kwigDVAt3HlEhpSUKc4PZsjvryPBHKnkWfUfAnG50w0GbnFJ8QvAAho+XaiLF3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mem_encrypt_active() function has been replaced by prot_guest_has(),
so remove the implementation.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 include/linux/mem_encrypt.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 5c4a18a91f89..ae4526389261 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -16,10 +16,6 @@
 
 #include <asm/mem_encrypt.h>
 
-#else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
-
-static inline bool mem_encrypt_active(void) { return false; }
-
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.32.0


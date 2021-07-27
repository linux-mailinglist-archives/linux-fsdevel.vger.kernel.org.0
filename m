Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A421E3D82E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhG0W2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:28:53 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:51599
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233589AbhG0W2t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:28:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhQuwOLJ2gpMkA/hhmWDhkcO4h101gNJcd+LNj7kxdRPCyX7NEfS7FYsIJFsMSrJebQHhjja+gSHiqIsZDKXyvZax4HvnGdpmSyoKsZzAvDaCMHPa5WRtGQQUpQ983jNF52HZJ8g6NosU8R390SSXQrJbIXarGO1SgZDOTDLDj/q4KBU7kNcOC6mkanQMMueiZtOqaWONQIGYKez5P8nGNMojVjOzLKoozrUmKLiNRe8WgV6zGmdCKrg6BS5ueKEN2Z/kqDYo8Q7UUsgjxQKfU5CwjrO3InoI5H6xfwsKp3aSnaLH5AB0dVNn4SGWTm/gEPBELM5cTAAdrxTbt8JAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOc7Jt90RzSIyXApvkZ+E9zVGpogBRNBjC+MOc1fLos=;
 b=ERvepvtMTaG2au729FgLIcbKyQ1sgHpqJC/Z/zHyfbAPCuOWdCDTN8o9+Jx3bQ056zbroIJplExoDCCdkWFhUspylddkL99dcHBEOOG/aYJT0s3mqYTTZs/PotFlKAMVgjzEVc9UJAq3UsULH/ODCwdoGmlZ73xoA+cA1mRxRtUM/ShWyv2EQHyVtZZO4KrGrPvbjecItWa8NyHxg8JzQSq+R+iRGsd/99g6Ys3V7QIkCKqErKxupjphGoBVCokQvXw/QoiZuafvtYv/9aH5Nkzeevo7tO3kSjP7wowC1EAPA1Mn4L/6NvLHLS4Rr0uNF2dQAd3RWBG1Tpa+vFAFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOc7Jt90RzSIyXApvkZ+E9zVGpogBRNBjC+MOc1fLos=;
 b=ups2inZqRdXRqnGXvmXq8ghDyJAIrSx8PCNzRDySM6J+5w1uDf2UDfqQI4vUnzN/s/PIsCJmNBSf2i1KB/CcMrtww4Y5IB0xxMpyUOdNFpvl7x30IxKd7JafJ7EQXa0r856u7vqoh9GaksT/S1cTKUOpPzL/84x23tDqHIfxqqg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:28:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:28:30 +0000
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
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 11/11] s390/mm: Remove the now unused mem_encrypt_active() function
Date:   Tue, 27 Jul 2021 17:26:14 -0500
Message-Id: <161de897babd0db0f6a10f081fb17e4a93f2f2b6.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:806:122::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN7PR04CA0097.namprd04.prod.outlook.com (2603:10b6:806:122::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Tue, 27 Jul 2021 22:28:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08d9b086-de40-4fb6-7255-08d9514ddc93
X-MS-TrafficTypeDiagnostic: DM6PR12MB5520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB552014A485083DC8EC60E262ECE99@DM6PR12MB5520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lu1YRcr6SYEHdH4JLAaA1FiMVXFY7iK8xbfbvHqBK0s4cVyWOGD2CqQrfjLPxxtyVBBshs7trJ8mrs/F+8+9J4pXLSSzCqUW1qqg2uEBU9JepihGxDE7q7ahwtRLJ5Q0JnZ7LP0d0xT4fV3bnn8D0EZ9u90LfHLQx9Oh1//19LJiiU4ODOjDo2hRjZPsXmRaoRDX7uGO0zLic4VpvBtrMNSTo3D94izSceZ+2hcdS7Qia0KlaKPEa7k7iouGcDT6tsONzeULbIMXLjyPd2wtkXSMXyDAZLVPT6TBMNvEf9XojRskHLpe07fD+jSE9upby359Y9+ZxhvIn4Da8HVUV1d0u4uTSlakoR2lHRaD5zqrElYDG1tzaY5sjPVwnDb2snJCGfaDd0ds4XFnJtmcWVHiSw2ub6ZeYCN4QNgz17jpq1foU7ctUA7dplwD/wtWbPqBpVkZu6S77DvvcVrtjYqiYQ8O0tlqk8qgyA0ICW/r9xd5monjzjk7VkNHoeC/e56bUrtYmxoDOQNuGvL/vSkwexPY5haqjl/c9PKzmfXLvKrtwcvwj0jSKFxrSYKtcorn/Aj9ZwZpT3IOVPwv3SqduiT6FqkCPfvGAWU0EBKFpX+XG6Uj2cphm4xYoWWszIZAGOQKzjxVNasW4u94k6i+MK0rQMxB7+8/lMPjf7ax3WHHgLo2VF75rKA/ZDXnVtLGJCVOomnO4fXLERURZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(52116002)(186003)(478600001)(38350700002)(921005)(5660300002)(38100700002)(956004)(8676002)(6486002)(54906003)(4326008)(2616005)(7416002)(7696005)(86362001)(8936002)(316002)(66556008)(6666004)(66476007)(36756003)(66946007)(2906002)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8dKYWFVJqel5abi/uq6H5mISnd8oZUULAJ9D1dJ05rpNyewpha/oQoxngXZF?=
 =?us-ascii?Q?7AnxOPR9J8h4l16pmsy+cNQjABpR0LkK7ZjucjWDUj62+000RKq8EVh9cG3z?=
 =?us-ascii?Q?uPdZDod38e02lx3UzZOzvdyOQxLsBAMGb8JWU/8VXZBko7tSe+HCat/eb6lf?=
 =?us-ascii?Q?1ib165vfazY4jbWO2h1VThIP+9ocUJb7YhvhqbDASwRRc0sBcb/Ti2Pmqhp6?=
 =?us-ascii?Q?8Kc8jzV2CRt6DuEjjVa6xHQxDmIXbKOW3C6sKbFVhlMYBbEh8e4lGauNBr7h?=
 =?us-ascii?Q?bhaEvjXFWss3gnE/UDzg0sPuaGph0EBaWC5ReB5+yqa8FDkzw6YEikvuWlcb?=
 =?us-ascii?Q?qpnQ0I44181XJofhEVlctl7rqI49uOQcRm+8Li2ZFcT6xghNcJSI5xvF0fv8?=
 =?us-ascii?Q?pEBWGY6XuR6TgyeV6Ts0ovQHHQYvi18RyhsQpVzaeD1UG5Zy8nWqWhzYDf3U?=
 =?us-ascii?Q?KkkOP6xXRiAxw6gEiWyCGZ5Sd+37X7CqpDmN0rCZg2XTOrt7U9/xr6gwlET8?=
 =?us-ascii?Q?b71I6jKHjtELQeTpbdDQsbmrHL9vzU8HePN9rNYbupPK44VNvjIB5jA2lvZR?=
 =?us-ascii?Q?xJsw3zsxLBvi4U3HfvEA77Vn7kh7+wyg6I7YWdfcL0g86+06bRtEmE9mFlAn?=
 =?us-ascii?Q?hBhCiYRRgTPrS/qN+9jGyuuqsLkPl9/uzMPFlj3APBr3Nuyhf1noAq6TTVXk?=
 =?us-ascii?Q?p2jybgBiuW5ItzuRIHm6lGmalF0Znu4Myx/BmLhTVCgSXX7XN696J23HN/WB?=
 =?us-ascii?Q?7BqIuNGFtVEcbp8kEbv01wKWOwWGUbgLl3i6hCXyCwDvAFLKx2PxQEbC4guP?=
 =?us-ascii?Q?ngE9wpg+dUjcsBI/6G438ouJonry87lIFchcYYUrVQAAoRBZohgKro1NxpOL?=
 =?us-ascii?Q?Udcedr56fM/mVx793ZNMnZ3zT/LJK4uv6kNPEin5ZEZPP9CWBXQjJCVOloBg?=
 =?us-ascii?Q?ZelaDZbcqJ/hbyebDRPAEVXm4na388pFzaNWb2cqCSTzWRt6RoeGzZxjkFLc?=
 =?us-ascii?Q?5so+CdQvoZA96NYiEChZhCsh84lP4rvJJgCQM5mx97wme6C6gacDSoyoVUUw?=
 =?us-ascii?Q?2TQo1XGCEZ7pqLta63Ohxushqc6KTLP2AbwlobC1uXCqH7x6rrU4Scvn3Nco?=
 =?us-ascii?Q?yVrqPNgFwRO23AikDwDNGr5EOvSo5rfG0mgkwhplLdMEFOdKz2sjT7HaemSZ?=
 =?us-ascii?Q?8ZwQLWraBT0OobUaKRG76OyqW3LQi4iX20ATTJIKawbbayO3hhUdBvh6CtZz?=
 =?us-ascii?Q?7Hgn0hJBXopvTFRRv+VBdRUCm1GCrZ5/yzgo3BJ8is/635pniKEk/7s1csga?=
 =?us-ascii?Q?q4sGDo7O8IyecvQ4arVgQYxD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d9b086-de40-4fb6-7255-08d9514ddc93
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:28:30.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jb6mfJuOci7WkLLKlz+2k6H3V0iGL32kUjdMnaDEMajHeJaLyZjE0dyUIzKU+hPhB7pEUZYJh37I9zi6kg0+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mem_encrypt_active() function has been replaced by prot_guest_has(),
so remove the implementation. Since the default implementation of the
prot_guest_has() matches the s390 implementation of mem_encrypt_active(),
prot_guest_has() does not need to be implemented in s390 (the config
option ARCH_HAS_PROTECTED_GUEST is not set).

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/s390/include/asm/mem_encrypt.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index 2542cbf7e2d1..08a8b96606d7 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -4,8 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-static inline bool mem_encrypt_active(void) { return false; }
-
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 
-- 
2.32.0


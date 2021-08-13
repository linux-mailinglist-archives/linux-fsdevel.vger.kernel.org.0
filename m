Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36CE3EBAF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhHMRCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:02:23 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:46753
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233488AbhHMRCL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdzhasWLY7+wdhMr6yc8bPeXjosupBKufB2vD47GWEeO2YtIrCmp/2cUVsIXfF4PRdRupDM7gUndOaB4DOI+GAjKt9r+JptoKAH9Y4M7qNPlzrBpeXdpKW005Ug2MrtDBtobYXWxdsNcJg33CduLG5iwrRRf5vd/J5eleaNPBy15kcXCz0LBQjSmpZYmpWPz6ingC6EV/rLpKFKQVCZjDtBiu+ZsmP4GGzcMyr0megzS8RSL4nmOpJbackZhM1Z2oA1NehtRmJk2MjTo5hKbivODPtSG8ewBP/UX6SkGhwO5/Njm2PDzEi+/WDkIuykk/7S8SOc+qeJLJHRTriiAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOc7Jt90RzSIyXApvkZ+E9zVGpogBRNBjC+MOc1fLos=;
 b=CiJnaGpVhb2i2Sb6gpKf2PJgbVimJ313L6swmBNS1bmFnTHpbqzICfQBn+oKgTAvoPlkww9wTu4ztZw/hSM6fuYj1C+/tTi4lFs3PoQU8ftrPP4eNdDbqRT2QP8P6X5I2QdXSajvqYfpu+LuFEFa+m5io/tOfTwNRMn1xtg95mYJpR1YaYUNYl1wwFHWsTP7z7yhIZ7L5wMCBOH3DBhO0YUryz+KnHLTfVM+JsREibyQDMOOKAzfogLW9IJXIlxzyPHHGor6PPeEuna1CINg29RScGHW5/gK0jtBSN36lC42YF1P6vyv2OOhGjFexGgrr/qErVrpHOVns5AQ33xPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOc7Jt90RzSIyXApvkZ+E9zVGpogBRNBjC+MOc1fLos=;
 b=cvCn+kBi9twREmL2FRvZkvzrcxrIWg/Vczif2BufUklG8MclDErqBwh4hBUnzT1Xzdl27KE+xSU2m5d2jen6Mh7yFQgMiZlB9BeD/yX0YgwtZ7tyIGy2oD61qEopFsMwkvqR/qprsXF96hSIdRL1KnjuMdBXx9DXXyC+b5eUBmY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 17:01:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:01:30 +0000
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
Subject: [PATCH v2 12/12] s390/mm: Remove the now unused mem_encrypt_active() function
Date:   Fri, 13 Aug 2021 11:59:31 -0500
Message-Id: <15e98b235f285fcf742cc3bb199998024b1ebba9.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:806:d0::20) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA0PR11CA0045.namprd11.prod.outlook.com (2603:10b6:806:d0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 17:01:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97db68b-fe93-411b-80f0-08d95e7bff25
X-MS-TrafficTypeDiagnostic: DM4PR12MB5247:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5247B78F963D07C828CDC208ECFA9@DM4PR12MB5247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grMQzeDl97gTCVkfUeFz8dHUfkC083KlFJcsOlhxSXl6ExpSREMccDvn5HEYXRWEnGyjlAxSixW7DIGc34Wq7OV1gTVF+nFMioGks2UEbph+t87Nx9dNae9qS/YYerfvAwHU1xJIbBbMC2g8Fux+wRDB54Xtv+hmb1LokuuUe0vP9T/2v4AsF3lCywMuwqBF39t7dYEAXgcaqQgycr2/h0SyPGKbzolcgyy5z74o+IvVkfNQf1TagsBUnIEqkjuALN5WqC/+nb1CSqvCHWvj8P+8X8GlxjU3EdqR0U8Rx5MbCw3xp084eZ9d8wuKSHQwdHHmgz4tbZuRTUh8IbNjKKVHW/jodC56g89bPYm6p+dqdEV8Sj3wy3Jndwt4gEJga4rMJVBoar33daxIiELYR2ATRc1/19vfyS3hpxVssexyLJLvKUx634ayGG5WUscZtk71j5Y/JVIqwJg9Snif3bV738VeURX+c9MXt5JlktG990L4Z0sQPGa4WXlEvjRfSR+3bhFAC88WjrFNDHhrZXQSqq+I6SBge8LsRy3hWNGIzFUpwh0B7N4954hn8Jq5HFPQEomPR6vN85H+8aOy5dWdGtCusP/ukVXM7xQ6juYiJQiiHKpjFnWCiBcxoPAwjaYTgtz7O4eXu8NgxQuzM74CG5M3HdNmbBc9cISKc1VeKFQyPQAQLgVWFFKZh6/+zvKyM18mrq8uUptE3tKzTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(186003)(956004)(83380400001)(2616005)(86362001)(921005)(2906002)(66476007)(5660300002)(7696005)(6486002)(478600001)(8676002)(8936002)(66946007)(7416002)(4326008)(52116002)(66556008)(54906003)(316002)(38350700002)(36756003)(6666004)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o07gkAnIE43NvcO0FJBHn22MvQrb8WljlkApAv1s2zfw+4T+XTu6qOLRIfSw?=
 =?us-ascii?Q?h0m2LmuQy4b2/Q3qTygnNJYb9EGj9M+Rzfk16FAAba7OqbZMBsbMR5TpwrRh?=
 =?us-ascii?Q?KpvklpD+c9ZOcsdUp9Y0+lEuDM3VieJRJVKYsiEsw19BDtaxcMlalMXl7Lms?=
 =?us-ascii?Q?+J2gfvs8m+xDcZY1VpmEYOJV0fsOolpsvC0IQaB6/BsbxoG7GjuiKgOkUK3+?=
 =?us-ascii?Q?3YZAislMOo6B3w99zpaGezZotkq+3JssLa4kTeckuIvEa0fWbY+UKS07X0Qs?=
 =?us-ascii?Q?z1eyW1UqdONWU/YhWtDDtmu7sATAOwetxbZoeXXj08wUP60Z8PkInSGK8UBI?=
 =?us-ascii?Q?yW5yNy7ypu471tBVP1agH0Iw8EHPtVcr2khNzqPvghwr0f9slfpzvJfYOpdp?=
 =?us-ascii?Q?IzBFZ6yGaZi1lUM/ZrCwroZ3cT9v5vKxKshH7obAxfL1K3Br8e3Vj6RtMP5V?=
 =?us-ascii?Q?6/j2DmIqOqsTnYpp8sUdR0ca4QYZ0HyAPEEIz5ij1YtsiVemdxXl6UHirC5k?=
 =?us-ascii?Q?2bQjJ+LRDjAf2AitnUeCFPkO00TY0rNLV8Le5ONtVJrA6oKCaLUbvIDhjVRh?=
 =?us-ascii?Q?Mliktis+/AR8LKfhr545kU4395zB9xlLklbMAxKchKLS0CAW8ydKxoBAizI0?=
 =?us-ascii?Q?JJ+AUWu4IeaDvb2Nr77zTHGw/T108zjf9n3kVF6gSjjJqpOZ46te9os3OEVq?=
 =?us-ascii?Q?8wyO720UVrFEtLCYZ8LzPxOtuGXIxqKNEJmm4ObGT7h8wSyzmgHm+2Qd2+d1?=
 =?us-ascii?Q?OC3mq8u0aI783SuTTSMKX1PHhjG5SUMevCDYo7TI+cWUnFqUocWTsi2is1EE?=
 =?us-ascii?Q?yAm+Uewt8BAp0oBloGdCxSaYV4P5wqmcvVQF2rDotQrXHam+umDGH45a9VbW?=
 =?us-ascii?Q?0pV02EcN6potM8nv3GZDEOoQghjOShct7c/Fw2oQngVO6pFo85UGt12gD+8h?=
 =?us-ascii?Q?eC5xv58XaqP6JQP27nfIDiP3ObCAJdqRxb5YvbEUXF5bxG5n35BTez8sIhFR?=
 =?us-ascii?Q?9D6ZLI6wcparNW5GuTNc9k2OZvjfrWA/12vN+WtZscryfU1x+7s/UqzOfsOz?=
 =?us-ascii?Q?14l9WXVaT0Pdd5j7OXBQtPE2qZT5i8lrL5WFUwt7/8WmM1Uq8H/GV9Kl8veh?=
 =?us-ascii?Q?wU8QKmJafa2flnjkJJxg1eiRTPznIHuaYlyr0JMQSPJrkE2xeFxAl/EuWoF6?=
 =?us-ascii?Q?KUgGgsBpnuuy6Tovfovsu3ilaRbvx4Hl2lHTaXnquOAvOr0doMuuWIw/Cm4T?=
 =?us-ascii?Q?/DROkKg+Hl9CIpwHjyC27ckboP16F7fqCoWfqdr+QuenYC7RRZtSpQqTVwNj?=
 =?us-ascii?Q?enl9lZexnUsPuDPIUGdmBXjJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97db68b-fe93-411b-80f0-08d95e7bff25
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:01:30.5705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79QSgY8tSfMuDR3NEHC0s2qy2S0QX6r8krTSJFSNV1bOxqb3KTdHiH9Cm0DkGtrz7IxXDhV1Sx3sY7Eog5Wrrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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


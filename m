Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313E23EBAED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhHMRCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:02:19 -0400
Received: from mail-bn1nam07on2089.outbound.protection.outlook.com ([40.107.212.89]:32130
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233775AbhHMRBy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:01:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYFBFXyS7zBmFpLmwto6ua/cunvT2A+NJzpVt7003CpOGzSG9zrl9GHcldr9IIx0qFpSONuTWyPytYqESUkp7fdQ5+/hlkJGZya5u9TUZOHVlq3elJGW1TuJIm0vc+mJKWWXLiPP2S839mCBd4APhwIi/t4jKszBmeuu298KuPBK96wHkwGD2A8Dcm2IkoCWTF6XlLp+s/hzsSNy/8TZSKfb2EwXzz2D3/gh6xB8MBOnqul4JB9HrYqhmf6H8uMoqfB3Dk3JmBvN1iyMYKvEarWdh6mNgoQGNN57HyiiaeM9Be9Sxsw97NBm2BZP4B4Xxla9Ju7N6iORe1e2CXufPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4naflCbBggOcnOdpK1E+FdYlswu1/63kE7BSki7t2w=;
 b=N0RzPTl6prooxb8HoYNPlJEpctuWwsJwclD9tDtBGUyspPVmAYuhaHCrfnxZRfZ/IYRZLFTyokP9W1l/WxSNME6gllm1h+iO9XMwC8l2/Nv/pltzSEet/cdMipuipYhIw1OPA7VuCbp3czWxtg9u55QfUy7i9IBK1Z+WL9WCDTOgv5tZFESfmeShD9tvhH/35KULiSHx+uH5cboB+RKR4EXnV1lMDBL15YGiAiK+aWy3zrs02QiYt+zKOCD/586a+Tx2iObpI6U87Fz/Fswhr9J+m5ODyKGZiklRl9I2cvl6Dhq7YCiP2lHvvCt3BgbA3pA9/0kl7l0eBlbrU5Vdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4naflCbBggOcnOdpK1E+FdYlswu1/63kE7BSki7t2w=;
 b=obzfaEnfL90ut9QeKBxl4jjiGcKEA398Y/CB0l5k1Hhu4KQ4xeO5KuQJW49x08K175wsTuc60dasHax3KfZFy0jRcHVv6j5RJofLotEWJySqTA/xCcwy6enmoo0AUx/KNg/e0u/ijuLNXaMOlQFV6piA/qiElouZJlKX/IIqKX4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 17:01:22 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:01:22 +0000
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2 11/12] powerpc/pseries/svm: Remove the now unused mem_encrypt_active() function
Date:   Fri, 13 Aug 2021 11:59:30 -0500
Message-Id: <b74abd3d88b473133986f9003731439756b4b24f.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN2PR01CA0037.prod.exchangelabs.com (2603:10b6:804:2::47)
 To DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN2PR01CA0037.prod.exchangelabs.com (2603:10b6:804:2::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Fri, 13 Aug 2021 17:01:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b9bb524-aaee-4f58-5cdb-08d95e7bfa1d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5341D636342A9003FDF27F57ECFA9@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JtQyQ2mfuMBiIzxbf3FgQJRHntRZCnylGgjdgQ6KtcbaKDSwXjUlMy6hOjR+8FFoUmjM7PHecycBJoklNU0SuK4tmlZZduNxFOfuzAiQvwQP+04306dY4Qb0+QSGA9akGd1DiwG+wdKS7NmWfRyy6Abh54TvVajc89X9TNTaabWBD+Xp26caSjJjA7+FQAp3mxgo4v9PZcWLWnWsSq0fvGZvegd2l8J53+zU+oKtCTOA826sb1DALEjPvmJJ/fWOYWU4OhOheoZdWtOGn9DWoVmAi6JhGQlgvtPScUArvjVQ7x7gc3EPPkLW8CWDIORFKCcaXZgc2LTQ6dWNqh2NweE+4RYPlJYzwL0AhCmcbKt42JJX1034Kwu3LU4NaxqV/o5qQHZxwVpieI6PK54EzZQdYzUdclHWXv/xcCVT0VzcWvVSLFnsUAxXY9GKUyljiNa0b/N5v3/iwnYmVM7JuFfZ6p+k0LXgGzuSWndBV2QOvyVw/AO43s2NyU58bhjPrWC4kevY4Sc0dnI4vzLoPHPzkt8Spci8sa5eyWy/SU9cdZQ22oAKA/gkS8NGkyo4T0COVL9inOdIRQ5mWp+PCtR3XDG4HjN6kwNViyBn65/HTpxUnEo7AiIei7H9OJEhNKBdHBENwJET53S+eUZmhW6z44fMsUI3f9KiLKjIFlQSyLMH1EnRtVsjqJFqBYuVe2v2Wi6jh1OYZ0RYzzy9JjPVooB5aWsGgl6lwbXQVPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(86362001)(8676002)(2616005)(4744005)(5660300002)(6666004)(54906003)(36756003)(38100700002)(7696005)(38350700002)(921005)(52116002)(8936002)(2906002)(478600001)(83380400001)(4326008)(186003)(6486002)(7416002)(26005)(956004)(66476007)(66556008)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9KSpmt7KuqAqjBh6FIgEkPVMCXquJf/axsKW5Sg0lTVdmWMuz1mE/GXXxQEB?=
 =?us-ascii?Q?PNgq0aWpySMhXB8PIFMt/W2ir0O7+yZzi+56gv8+uENqoja1328krfkIIJo1?=
 =?us-ascii?Q?rCGO7Qbe69SQqFmb2cUI4ZvprplW9bvMqrnAw2rpf83u2plZvMad0oTe7x1g?=
 =?us-ascii?Q?K1PFEvmhRoJA1iiSTZhn1gQzh6hlcZ9HYKG1wNSYYWf05SmZsUKDunea+iKh?=
 =?us-ascii?Q?B0569e4fiyoe/qXfQTmTGMyizU3yK2H5v3BORqbftFGfV/UI/lne+m4vqs8O?=
 =?us-ascii?Q?r/nAJTA74DywSNqW11kgKHL4cXSMeCuQSj0cAcbGwn95+jxRFpnJMGnVDVhq?=
 =?us-ascii?Q?WNUX0luuia7EenEj+f3xsMBhUSyKQiQalhuT6ehyxId/o2zz2MGydn4+Ry34?=
 =?us-ascii?Q?+PSjXQl7psbk75e4gsaU/8Ox9NNorTWscpg8fFAUJUPnOZc4GhsLZfdfo+2T?=
 =?us-ascii?Q?h36Vost6K7puVy4QwHcaml7UAZKxvA2yww7Ur6xJ52HzXJ9kNqUY/L/+W38G?=
 =?us-ascii?Q?5NmrbU7fbeK85uVULjvxsb1kEYc7AVg6UZrTnFqqBuNe3do+ftXOx2hoVftq?=
 =?us-ascii?Q?X4QpTDX1btt1VygvGvtogeS6K+IOKCXbgrreho3oWoY8mNRptT8/HO1TtZta?=
 =?us-ascii?Q?X6l7nlEggs+phEXP42hCvJ27+8r53xdzGeeG/3hOWiuM9RRKRi9akqpx4kvi?=
 =?us-ascii?Q?zR3qMaX1hcW1aFw8Ry0FBJ3Aq/negCEV8N/ZWEyrcBXy2kZ43EWp2IkcOFfq?=
 =?us-ascii?Q?E2ZLRQSwuJqNUfwLNiYAxVpXoG2IoSuz/SF4jQ15naKyBUaMOO8VIjrYpgEp?=
 =?us-ascii?Q?3YxS4FX/l14tWrLJwmyPsiHlORg8AgjzVKYqxF5QlFNEC4cfn0FK7E17xLG7?=
 =?us-ascii?Q?mFFCYprGKY0eouy9xq/xkQjF4OUAuzW/cbs14TyzqtqVM38fhTV3AM2R8SPA?=
 =?us-ascii?Q?tIMjgbvKZ2BKJB8hc6MD+VvrFswpdzlstIuz8eppMT+d8DKBST7EgIWfIHNU?=
 =?us-ascii?Q?RFkIAzfqk7tLWrzFEIolFKdCEq/gAPAMyF1OFXBfG7wZKFH3hYgqERW/SYHS?=
 =?us-ascii?Q?urXH4TGPPekDyJJlMOFvXpIkl0XieMwLbw0k/8MV7cwzIQR48SjHCUZ+wt8k?=
 =?us-ascii?Q?hTzV7wl+8A789wYQxQatp3S2hhOGJ8yYS9Sy5DSe+lfl/JUwsbaSTSP0NAnE?=
 =?us-ascii?Q?x0OtLw+g2GJrEhAaMiVHJzuuOobpPF2qDLC3coBB92htkNbeC8PnE2acDxpD?=
 =?us-ascii?Q?ZLj+2Pn6MxKMRSfT//Me5h5ny+Yj5zfuBSJ8OWzG+wH9Shued3ngS4pHlIhi?=
 =?us-ascii?Q?N/QgXH2Cfu/n6UhqDKjS+ORs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9bb524-aaee-4f58-5cdb-08d95e7bfa1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:01:22.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+ogCzMTYNLgQ4o9KAbSyEHE8vZrzb7gCZwcuD0mjlH/WaB6UG8mIJeT61Kbtsf6ypxim47iVZrkUTV6eNqrWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mem_encrypt_active() function has been replaced by prot_guest_has(),
so remove the implementation.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/powerpc/include/asm/mem_encrypt.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
index ba9dab07c1be..2f26b8fc8d29 100644
--- a/arch/powerpc/include/asm/mem_encrypt.h
+++ b/arch/powerpc/include/asm/mem_encrypt.h
@@ -10,11 +10,6 @@
 
 #include <asm/svm.h>
 
-static inline bool mem_encrypt_active(void)
-{
-	return is_secure_guest();
-}
-
 static inline bool force_dma_unencrypted(struct device *dev)
 {
 	return is_secure_guest();
-- 
2.32.0


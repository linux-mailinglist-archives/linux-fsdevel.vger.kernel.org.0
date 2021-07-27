Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09FC3D82DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhG0W2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:28:49 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:51599
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233086AbhG0W2m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:28:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IODcJV8Kss3MMrfqAelTlOx5inSIuo7dqPJUVDg8K4rOUajwhBlaTG3zLEpvgm7D0O+XoCKpOTR5WkG7RQ6JMlcriBUvKGYOgIfNsykO5uRffZ7HVDML0Os73PXByQTZGq8/aVtYdCpIPWcBVcFCBHtWIbqnRz9YbOyKy6NxjROS/62lu365WSXEZ7sk6DamypJ78LaA6tEgxz2XkVy9x7Lk4g6W5f4uU284XQKjhqDwSq/r824+MXN0i0A22zakY2N1A1vCpPDPKKbEBKZAVPKR96w+62k8ryVbT2NCMNnCsJU8299XzN7dKXZ60dP2NkMUoK+5/fI8BFcrznUNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4naflCbBggOcnOdpK1E+FdYlswu1/63kE7BSki7t2w=;
 b=iIPh2rEBT+oHALshyHjZn3rwn/TTc2cQQN/LLwpRQBR2D2iukoILlqoluHJQ3xqfVzG3iWMNXy3bKgu2SJi5rjbAe3aehchB2BHw354bhK4zdAuLsnCnZiJT//UVWBPlwY9ryKFhI+KjtfR0ErsA+jCMFqmNiSPaJnQjPXWe1RiPeMGhn+9vix0LZyFcs1G48msrLrPh9+SpSp7dvsWLiPLzrb0doaSTkIQ69o+mcYZ0yRgCtnQryXJaqpDqbcmvxchQv4LdpBy01AKBzn1RkBW7Lpl+S2FeDzqpHqGYAovZEgcm64PpcB5eFz8hgQbgFDEMDK4zxhbyMbn2nS/9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4naflCbBggOcnOdpK1E+FdYlswu1/63kE7BSki7t2w=;
 b=OgYJAZmsOOfZF6ybEL9Bl3P5RcHc0GxOtXUOsmQcyYfFr5a+LDjnCxcKNEdSAOprochI+Iyfn9E4J9b0sJBw+fyd88NKGOk7yvZb/o07OH7n5Ne295WRr4CQqS+QMvAKsTidtMZNdnKgWTaeHuZCcDCRTegkPB0zi/Bo/uLQiRM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:28:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:28:20 +0000
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
Subject: [PATCH 10/11] powerpc/pseries/svm: Remove the now unused mem_encrypt_active() function
Date:   Tue, 27 Jul 2021 17:26:13 -0500
Message-Id: <ce42e6ff7debc5b724c63352817e4346439d3160.1627424774.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:806:6e::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR11CA0010.namprd11.prod.outlook.com (2603:10b6:806:6e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 22:28:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2ff93a6-8c75-4220-83a9-08d9514dd6b2
X-MS-TrafficTypeDiagnostic: DM6PR12MB5520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55209266F66CADE6727BA1E3ECE99@DM6PR12MB5520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TR3e+7vboeNn96OGJH/uyylPHctUUGnJSZMIA2ijuITPzdFvOVMYAoal/j8eVuJ5JAjiyYlmWv9cLppj7WmbocsicyjE0AVuA3XBqvfPf+GH71yIw4yW9J/TB7q/tfA13JpFcZMlEhow9TnXhra5pzdf+8xpUkm1LzKH0Jjq7VCGzHdlmELGbqXyMkQoDNZqSV1sJkyDSVbIGi20TzBFPMGaP2Z4od1HdaHaSln4SaDDQQQSxFGgh5CMAxk0q8WATYzsp4k0U/68Gu+N7pBcKz2CH08/0WhEko4bnTs3aqpnNy8VlGQqlEc3WI/1WlEZA7fx+jivCpp87fU9+eRdH3iFsBM2JS8meDv25I2kUyIRt+5oclbUDJb1LDNdiC88qIGyPzMgGtk1g04Q4gfPZcxdBXWynqV90TVIWpzozx/2louqjAAhL+THKHrJUYE05tujTR31VwcWMBW4gkBjmE3ABWnfO0ACoW/YB3LScJH1okjh4rxxLEQQN2yqk4WrZWQ/Yb3IN+7ENrkCa01g4q7XrEKiD8DUuFrk6PWxuQ2GYaulMcZ13R1lSnikE7FhxUA+5iveWRsfn2jy4DO/x7VrzejHuZUowbPjIAK42EbKxOpy2w2UVGcB24VFreA47IsIu4NkUdfg5bHjyIjQmZjcr3kNoKjaCGDDWuA0eXo1kQUvXqefOuZMGJ7mV0wB/R+VFWJWIyZ1Ng2SWzJDu9M4yS+5jsXEhJnS5iQJDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(52116002)(186003)(478600001)(38350700002)(921005)(5660300002)(38100700002)(956004)(8676002)(6486002)(54906003)(4326008)(2616005)(7416002)(7696005)(86362001)(8936002)(316002)(66556008)(6666004)(66476007)(36756003)(66946007)(2906002)(83380400001)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?33XF5xyV6fSMw3mBCWiOHJrlKtNzKeJ6/jRgmcl8RZYEr1Vi6JiElIyMpiOC?=
 =?us-ascii?Q?9+zwKk2nCv/fQvEkn4PQsdV59SWL4lyHFU5QopsGnK0eh00aIpOkFKGWY2Fu?=
 =?us-ascii?Q?8aXmURCD9kstB8NClzK3Rk2gjyQUbEdGjco6x3g3zuy8WMSDVSwL2xY/K+xt?=
 =?us-ascii?Q?6XG74Jys1erg/n5OHktqH4mIetUzRpDp9/6VfJo214rBIA35S4WhOn5XmSfJ?=
 =?us-ascii?Q?jDIHNxja59sr1O2x16/gfH8vh5qqbz/+oXD5HEYKqaBhXxzn6ZlkQJ3Zq0RH?=
 =?us-ascii?Q?dFJR4MB5Jn3c1mAa/D56lHvqzr7KvaLe4QFCjaUOx9cPzGRLts1lBQ9eb9Ak?=
 =?us-ascii?Q?1zSh2aioycePqhFntOln3Kamhc1W+eBKk6+nI4BJXBbvuRr5eANOeA7C6SwZ?=
 =?us-ascii?Q?BAR4g5BpZiC5UZ9dx9+YLBSyVNM/FpxahsiRvrVfKViw9wQnonQEhWQAaFJB?=
 =?us-ascii?Q?BQxUHB3Jmt/mCq57S20Z9a6tM/9e4UModS5iimgQx0SDYmv6RiZS0CHzM598?=
 =?us-ascii?Q?B/D/ro0+S2kn/Tw6NRu1YfYbTi5sl+YpYU00362j9JVxM6XYDmkY0gRusWaZ?=
 =?us-ascii?Q?CcvSb3OqbJ7sUotrVhyvlVpTSgsDDWqlRN2NLtDUhp0L+XnLzerAxyP1bGFn?=
 =?us-ascii?Q?wJdbHZza1l6u7s7XqMrnibPaGVJH9yuCUYRyezByek4A8hXZeNpv3d6aO3Rz?=
 =?us-ascii?Q?teIxHnnpVfWBcfEGWfMHyucA8Entxxx+uQrEuVho9ucBJCLywWZ4MXRU2LEn?=
 =?us-ascii?Q?gWZtdnc7FSraxU3HqTTgsM1mCLyZls4SimBB7udd+bX4jBtbDmV95K++ZjkD?=
 =?us-ascii?Q?D6XHykJK04u/s1gtiMkSbvR473nC0jltyuQEx0LpKe3Am7bt87avHd2W8+td?=
 =?us-ascii?Q?6djBJH5VP5x3W5+60NLgGPlwvKtm/0MAeY1hNse87F4HXXrA7Scj47I/5zZ1?=
 =?us-ascii?Q?pn8gitU04mTXFyQ4sRGVEDMUZ71h5L6HUezkXig+OJN0ZnMmwalqI4i+qRat?=
 =?us-ascii?Q?KDJq38cFj/dIPINUBWJhoN5SUi0srC3i5DaFKGNMPY9jdMmEperBEZBYpmxY?=
 =?us-ascii?Q?XnLxmN0N3WxAWQhC7x10qRzyDskphfFkwWVGrHkV/IfG0IZy0P5sSaNfxKVQ?=
 =?us-ascii?Q?+DRbQP8igDrWZCLvhqEN6x67EYVOpPFE6dXkCdHhBs8FXP4JK07Avj4QZc4e?=
 =?us-ascii?Q?PzU/X8mn73iqAIQN5uur85oHQp8/HF88gRNK6jAotV1wrEz8wBdjid2U5O8Y?=
 =?us-ascii?Q?WY11jD/9JLM1FOl7FgrYgVDv5ysBItsvT/kTDdiotQ4l+27sx+YIdGXA8IGn?=
 =?us-ascii?Q?aecQt1f94b714YykypFf8I3U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ff93a6-8c75-4220-83a9-08d9514dd6b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:28:20.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sK+QPL1UQy1x9YBjf2wLCNl6K8ELA+qcyL1NCrg8TKafLNREDqaRZrt8bwe+VFZXfpQiQOVdt50NIH1p+iGXeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
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


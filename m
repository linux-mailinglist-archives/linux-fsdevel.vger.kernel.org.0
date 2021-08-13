Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39F83EBAD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhHMRB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 13:01:57 -0400
Received: from mail-bn1nam07on2076.outbound.protection.outlook.com ([40.107.212.76]:51015
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232683AbhHMRBe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:01:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGRZJcPy6P5tF1JUO5XcwXANZ3wLbqu9Mzdwp3/jqNtMBnChgJHPUEmgXlRrw+rFryMrye9e0ItZuIFC1xw99+dkpWlMKx7+cx6ZFVRSLtG0roDeOhfjL2FJ3RiNaw/gu+jxRPzFAjyPS8LqXhFdL1CKedeX0zDR5fQP/wHQCDtTzp2yDTaZr5JEkhAAqzQqcGv2J0T1QWyRBkZmQ+qiHktML8FX6PonOB+eQjWpH29Jmm4Synms5aZryeR2khgFMXy15pKTqIML0NqbA8dF7IpOTaui491oqTN/37uILJs+oYlWUXRWXWPlVSePahiRl3cg6W7Xm3vGeMK1s8NySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4M8Xyn5Mawk/DMXQ+3RqHw1cVkBCe7o51wVYlspL74=;
 b=ad70PkG1HbketO00GR6OYsp0DlPRDnmCZBn7KuMBCuEdUe11elF4g49vC366ZR5/QnH85q8YMjYyYGdu1MNTsvQzoc/NX0ccJWCHdi3zntQEYvIv/Hi2qnWYHGQzz9gObYcNwk3gfbQLHxlZZPK8adGWlJ03liLxg7QL53DoPtPPO9p1UCdGLQXKkma8ilup166DbolurPrXR9BHBfEH7+ig/M+niktsmi62NofZDlOiAY9uhC0rpaTJXhU1z+cYucGSAG83dBzpJadU8aQmi94kXVt561h25sClHdyg9T5h44M6vNcrAPafrvHHRqovnPukUEKMzD+KUBfy0RKOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4M8Xyn5Mawk/DMXQ+3RqHw1cVkBCe7o51wVYlspL74=;
 b=OI3NOJ6xgsYOfRLc7GVIhAvYHLW3XHCCHbHCXBBVz2AUaKNrRqpSiMuXbc/ij5I/FJtRPEncMTCBvOjsZ23hTHLUYOTJXUdK/SMcUVcHfqeT6q8lsKque3MkUHjhQnfQChnq6XOnr3TVp5Kcrxu2RRdgys9r/Z0rBjWj4B36Hzk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 17:01:05 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 17:01:05 +0000
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
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 09/12] mm: Remove the now unused mem_encrypt_active() function
Date:   Fri, 13 Aug 2021 11:59:28 -0500
Message-Id: <83e4a62108eec470ac0b3f2510b982794d2b7989.1628873970.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:806:27::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SA9PR13CA0145.namprd13.prod.outlook.com (2603:10b6:806:27::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Fri, 13 Aug 2021 17:01:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6fbfaa6-dda4-49a6-4d7b-08d95e7befe3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB534145796C21EBA9F8E398C0ECFA9@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsRZPUIl67uI750ilxgHe6DIXAmWRO5kypnhEq2k1RUnQErZB8nyHisrmBcnURRrT/j9z3I8G1crJXkGLzEj2TNLfcztYPRwuNk2IYgR9AeYoHlUAk5BTiEapp46hCzcnA1XUmzyUoYKLiDxjIcU7Y7dr2XZmSUXcyqxJMo8GPnc2ivqdlgVuWqw0H5THWO5JDBhj2KwWbQet/Ez+PozdqRR91D+6j4SUZ83wS6rb8G1fgxnaUomxMtdEsiUcHwx04sZYubT2NJKCWG3aAGndx+v2qLBO2/4izX8FMPRYSQXx/PckI1GeVaMzw4Qv0LSUm6x4pWnS92uwSA7AcSncm17Y1Upv+j+H1rMIs0z4s0OaFatH+Hzq96V4uC3grC/1CgHiIvH3EEqEK597YdRrWXG65yjKidyd1wifEMVapTywKfdaBCFfapONptAjPqz/tK8KecWzWSgMQR3tETvIA3xf++dOB+YBJeJfNnGDV8FCVgdRqd+m8TZIWZDGMeOEW3f5/qve5A0p9rGuKo+YsT/oVgP23H3MJaZDyAqhKp9bEXcVz/M3WEy2H51+5P3I2qFWCGxYAv0Vf4HWugT9NbifeqmU8/h5NhBho59pq5bFFVK11T9FwbDLXkg99h3t3xu3nqjDfQXC9adTgnN6MQafp03FYQzjAHg2EKlaxxojNUhJ40S+WhZuiPLSpRcMdaNGpO+gt2Geodp+tOxHfQ3A/gFpM6sIBlQPmy43EQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(86362001)(8676002)(2616005)(4744005)(5660300002)(6666004)(54906003)(36756003)(38100700002)(7696005)(38350700002)(921005)(52116002)(8936002)(2906002)(478600001)(83380400001)(4326008)(186003)(6486002)(7416002)(26005)(956004)(66476007)(66556008)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6ar5e+Ojeb3PldAJH8Q+kPp57d/P2Iu6+UENf89dF1v2YHuDyzkA7FgbzpW?=
 =?us-ascii?Q?HtKaHYzMqK6x78PFUdnYMXtbiLbicJF2JQrmBu58mcSifzTGPBfCnAUvdtCD?=
 =?us-ascii?Q?sO+cZ/WCSC1WK15KofMD3vTCxroYwIBX6gyTOiJjyhsZVcofr3JVdV+ZHElH?=
 =?us-ascii?Q?bmzFhjVNozfYDlWbPgaSH8D1zErZuf7Tu7lHh1rn19GjBEtEWWoGw6+vmpbN?=
 =?us-ascii?Q?mt7iFkRRrXR4zZ9MqG2LflZG1D/N7tHqkdFJOV85pyEFiOftztWLGR1b7HyQ?=
 =?us-ascii?Q?/nYLNHkgOltSd8t1umzvfA2kxaN1PbWBHYTX6hPw/hpdmHStFZBZkG46lwdv?=
 =?us-ascii?Q?JhKuu9fy72WSSR90noteT8WenrvaELFHFu6tmb7BoWsOnYxZ1aUiBM0I7scv?=
 =?us-ascii?Q?4DIpPiOXhTQfnWK6cT0RBlWCNnPqcdN6Jt+QCCRMDSb1fyQNZS24SsVYisTf?=
 =?us-ascii?Q?C1aSotjWE22U/ncrHiXZ7H6vE4WfEow1bFoQbkyXx42o7fMfelc8xi8qIg1M?=
 =?us-ascii?Q?86sK7FVDV7WjApE8NPXwyXTTJsPEK996l4sxZhqP7Vqg7I/Z7NZ9M+735E9t?=
 =?us-ascii?Q?dyp4O1G4sIyFmCrLuqLMjrlFZL1BSdv22ublL3NFYhTE1ruLNXGrTKpjsLDR?=
 =?us-ascii?Q?HB+UOzwbxV2YJXfaubN9w0lQs+K+kpMlKX6x2c3rhf8Hgl59GfpcAjzc1Lar?=
 =?us-ascii?Q?Qhe0p8VR8Ea47yG0RPmKa7TjJ2nGV0Hd3oj8nYruZN4LaQeGHDd7UdlxHDPZ?=
 =?us-ascii?Q?X56TvLOFFC/wov/i+zqFPLZ5RuqKg64ovyHGXB1M/iVyrHjch+1Avw60EYzn?=
 =?us-ascii?Q?o+Pa+efhzcueZrff1XSAcxSFaIKu6Yybvbbb9P8w0XikeuguU1waI4I/Tk05?=
 =?us-ascii?Q?+aKhkVv3zGrpwk6bOo1yNKTtwhM4oa8fGXS3oJ3/2kJKo7bIm54BNv9+mpQU?=
 =?us-ascii?Q?Lj1amIKxoCrx8nV+dFS+FcDSTbm9A8NSDrOaugMOOU6NE5vQLuF4wHPjN14d?=
 =?us-ascii?Q?7NV2MnVgdm3/qKylDsvQfHm4EBa+UqVRvPCJUShE8N9aCF+ssswRub6aMLcc?=
 =?us-ascii?Q?fCTFNfHJr2CyCG9eA57yQYr7MgaWz1qY8Z6THhh44Fj37rT7bsPbKXXD/hxN?=
 =?us-ascii?Q?IWuTU9lPYS7jynYAyJ8Nf8+0SCaiQmnh85fxd/arJfhQxP79X5Df1wVCI0LT?=
 =?us-ascii?Q?at/Wc3qfE+UGxUd9Ss7xOz5pOOL+JQ9fgSyqnt8RO6KTXO05cuI7GAw3UmTd?=
 =?us-ascii?Q?YnZjp7ZkrrrvRdDtRqilLZxsLDGkz670Z7hBrb0Qn2rWrYv9RgA4b6zmaj22?=
 =?us-ascii?Q?qPMshIMOJqpEEfODG32Zi6Qn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fbfaa6-dda4-49a6-4d7b-08d95e7befe3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:01:05.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNNo5l1Xy/99nFOfZ7LPRQ2GEYF/10iEoMuYmMWPDKhWsythOAaJWMFV7nInBuTIOfKdoEtdeQ9ttdZGyhncMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mem_encrypt_active() function has been replaced by prot_guest_has(),
so remove the implementation.

Reviewed-by: Joerg Roedel <jroedel@suse.de>
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


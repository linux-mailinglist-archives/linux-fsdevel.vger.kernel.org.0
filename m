Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC34DE683
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 07:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbiCSGbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 02:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbiCSGbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 02:31:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC11AA8EB;
        Fri, 18 Mar 2022 23:30:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J3vT3G008826;
        Sat, 19 Mar 2022 06:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WQKHDFQRLfFyRpEZMEyBctbWgbBoX4FGjzPfRUszb30=;
 b=t1R1skXFl0/py/dFvPrVZIuN/L88yN/JhbV11zNNKItaHWe3d2xVKxJw+kJJe3klFSd3
 DU6LbVFHv/ov8urretgjBcjxySjeJf/1ya6MGugutAF5M39MEp2XzNSAFnj1FeDdbioD
 Iz2PxgfvZD5NfKTCFdSdNON4O49agES8F67p5y4nceuNZRnQisfkl0X7GRvH19yZtlQK
 NHK6r7pd/fdBxf0/FrU9nH3rUnrSu3zb3jS8r6dSeMw+pcANjlRM7tzQiR9HMriLuEhl
 t1zbZLV5K69NDA/1AfOPiaMdVbZoOJsKKxPQOyQbOLH9fH5JRnLE3phGkZXS0G8D0HEM fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qt0354-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:29:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22J6NKgK011462;
        Sat, 19 Mar 2022 06:29:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 3ew49r0aqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:29:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc/JfKrIre9Fz+46SPaOPsf1VDhrGsVne8S4b6ECJ8ANbdrfDk9d+fZBCYlIZh5iBFTmWbtjNSxE8Qi0UAPgaw2TLKG87Y6JRBroWvsykpsUZglrLPoNIQj7VfSmxuaZ4cuEmZLG2rRxaJWUcveOixPv/SjurnxaPNfjzzfXtXRj59MZ6F+oBhm4ISVCAuhy5S8mjsJR/OxZx4JJTf5A68JhX6Yj9bCYmNR90G611qT+c8bSgxbiVkbU4/MV6KPMfTTJb5j8Ertg0JMSslai4lXzX7qawDp5UlZjMkyGTSzGIDFIoe6ihhjgDWr8zLhu5n2QcNkV23odwueD4wkuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQKHDFQRLfFyRpEZMEyBctbWgbBoX4FGjzPfRUszb30=;
 b=oYxPXSa/gF4hbSgvzO+mTgPZnQsU7sviNHA01EF2HaUdpyYAkk2mYfTsRYW90yGLBpSIXcLFAQLEM+jJ+oyT3FpFrBfXyqCVn+d4HY2EMsybYvzJOsLVXDcxNZo8R5/phiAIEtkmlnwOpPtg52R/FLOQt+eFw+LG/2/lkwuWRgWzQHB8LXBbtcBWLq5wsZl2shYX+gyJ+ElP5K1eMUFAKUQgTwT3TveOmlOTCrwVaumILD6hXZhgEeKWJZv6p06jzmZyTPRa9eg0qVQEyQfrl5VVDy6AMyPm8Vz0wvDHCuyJHRJLuejr96tMx1ibm/kmpBpvlgx+vE1hZOPawFQSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQKHDFQRLfFyRpEZMEyBctbWgbBoX4FGjzPfRUszb30=;
 b=jOkggDncy4ABO/2FGl/PThoP2QZOiitPoYj+l58y2VUrNvvjoA3m/GBrybgDZz39dmIA1fHprCWxH/hGxBecZE63lzKGTKIwNGhMnfmej8Filk/5ZySL4i1j6/W24OoTm1kPS6fGMSA7rzMl65KLYzmideML9Cl2HkuwN8aTDDs=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY4PR10MB1798.namprd10.prod.outlook.com (2603:10b6:903:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sat, 19 Mar
 2022 06:29:11 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%8]) with mapi id 15.20.5081.019; Sat, 19 Mar 2022
 06:29:11 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v6 2/6] x86/mce: relocate set{clear}_mce_nospec() functions
Date:   Sat, 19 Mar 2022 00:28:29 -0600
Message-Id: <20220319062833.3136528-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220319062833.3136528-1-jane.chu@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e4c18c2-78bc-4be2-def2-08da0971c786
X-MS-TrafficTypeDiagnostic: CY4PR10MB1798:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB17984982AC80E7485C28D72AF3149@CY4PR10MB1798.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJzPb5HF6sq8LUjs1TWk9/2M/m32buQlX4rTuFYsjI+StLR6OVnNA26XiwQs9kf0+l6Hn2R8HbZHvJnndfhY3BFGdaHfyHG941TFlezBvqsHMN/wBw3pwOqXy/+SYBMfGftbYV8Ltrn3rn+h1bz/zY3qbAFhtck+6Q9aakaZiHdbDId5rMhBGHvOb8GEcPrwP5eLVkvPFIkY6c6i3SojPboJUZV62NyEGfVD2OJbZbXl4oSc27u5kLFT9GsMJUWoIyFI1t9glpBRwKBmx2L9uVy110sEX8cCd2hCTp4l1kUZtNaAT4oBjqz4SH2nUOxbnT5ibZMCxjEWXPVtdiXInJPX8OiQWD0nJF2DI8HCEapB13/zhbpI2vQK01Lkh2gKGGFkV4Io9ErC0sGnHvRrH/AfBUWOK9+QJrA+lJ4wcaNgpth4IWMoZ6/iXxTU+RODm580relGjEYyWOFDp2cWtqGvj/9bXZzHSgNpX+w2QqW+T/rYPqXP6wl8a0b+uQ46LQVw5GIwnPImP+PQAqQz4vxk5KcnyfCMKxVeHxxF9WX2wRna2o1UrUaiMtTQC8yAlc67RD3XcAxL7yW+MZqSOkPpeIflFg4IZ2RJ8IR6OtYMQEuKLMnYEVN5J56DfiD1ZCmlJOlyGrjt6FvOVfsxz5V3mRhutg3ih4/zvGzN+lzcaxM0KdELNOIMeljbYo0CvbnrS0nAwTDBSYYa3USsmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(6512007)(66476007)(8676002)(83380400001)(66556008)(316002)(6506007)(2906002)(38100700002)(66946007)(508600001)(44832011)(5660300002)(8936002)(7416002)(36756003)(1076003)(6486002)(86362001)(186003)(2616005)(921005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PrMeU8AxzAbXdLKkzUKZ/8otCZ2GB72QbcGg53PtAuPzSPTOF368LZzh3Q2o?=
 =?us-ascii?Q?p210pajmrzz9wNlIrUZKzmc+R+TDGMnk4HKMJ2E+jIJ2lBUOLo6WdSCgU9Kj?=
 =?us-ascii?Q?hg82GBmgxXxaKAe9lB5qMmQ1Rv36xTLoTuOqIxLu02ZBj8lenqE2DXGlYbNy?=
 =?us-ascii?Q?uq/ApYQk5hjA24dJaEGadr3gSGK9z+MwQ2duhNSJXlrY0HuJiDFnEJRk4xMS?=
 =?us-ascii?Q?/7GD2gEt3XZzjn2JLGbwCkGRkqRH6cZJinxxbVDx44nFNIg4qv/4AOdGnUQZ?=
 =?us-ascii?Q?Hs4EFa+qlQz0yPz4y7bub5I/kxIzD3I85WgHJzsGXlUmpBACcKxM+nFMT3/I?=
 =?us-ascii?Q?gEK3lSbN/kFygCrK+9G0PIROlwO4DmgPlr27L3FNcm4aAeQEwP68eTfk29iZ?=
 =?us-ascii?Q?f++oN9xErVpueMriQlv5HO7I80D0o33ca3+K7/t7L/jtYxJIt1d/F4c+vto4?=
 =?us-ascii?Q?W0N3JfLgabb2wEsvk31b5XL58h3aIPIO6oaNvey51Vfof5enqeg7mTheY8zQ?=
 =?us-ascii?Q?65x9orQu2tzGcy3qYmo6gWt+RWurUYIlKc3WhkC9FpjFJn9QzsJfyDX/iLXs?=
 =?us-ascii?Q?YyWljCJ8wcx51bdxaqSiq/ixGrdkXzrl+RKod3VPl7VZg46wHAoVNWqCTMsL?=
 =?us-ascii?Q?CUmOY/OnZ7DqWyQ/klMzQxl3y6d8wyFJCu/i7pYNU5wD3swXf6ZUSvyHzYHe?=
 =?us-ascii?Q?lMURRis/t4Dk0rEDFMFYhHMWaT5tdfGqROrJFderoOa+2xt+Cao1www2cid9?=
 =?us-ascii?Q?j7ExdYy7U6Vc9W2PpKQAmFiL4YIE98zq/mwtLdqt5CgQvOLN3Z12DEj52hWZ?=
 =?us-ascii?Q?CFn2XCi30ZIy0z/edX2ww3knPx0M1gGHkSNKzu9lBDkT9lK8f5MALPbUCLlZ?=
 =?us-ascii?Q?U80kTBTfcs0q5pBu0o/CgTxMRHkVVOKCdJkqbY25TuzGUJeU1Abi0kIRGs7J?=
 =?us-ascii?Q?/3QkMgpAz0ozRr9hxjXJFDBJ/GHtsXcpHA+any+z8JDlPXWACtSV7/WkHjwb?=
 =?us-ascii?Q?k3GcHfrXKiMBu5KiyqnIsgySEc06oja8pR2K+tisk1fBN8GkX9DC97mg22Md?=
 =?us-ascii?Q?8gRbNiHtPfkz8vH5xqEqnn5t7QnRBStO4xdEMV73i4ZGEvcSlFsV5GOruhka?=
 =?us-ascii?Q?OFRX25ZAcJOXWbqzqp4p9EsFtztA93qD1jm86XHlKPNVprIFE4zYfc3C+HbA?=
 =?us-ascii?Q?kjYTvUXnMerVABtsNuhFAz2n4wAg/sPk9ClauqlstyOYUZuk9HTmaNTrmRjq?=
 =?us-ascii?Q?hX3yOsjlCG69uXnizJcgpA2oKKTO0ciNwXbDiiPvo/dLVLjLRD30+ihtRKko?=
 =?us-ascii?Q?Z6s+BQmMF+Z+bc+ANnwP/xj7ft7gW3BWzVVrPtHLgLE+EKMCuWEA7UwvlkiS?=
 =?us-ascii?Q?MEWvw4juW17TXcrnSPBNsK1eFNAnE/Pb7KVi0Zcw9/axFNHr8iRJTyEtntCt?=
 =?us-ascii?Q?iKmKNkr6TbYKKDHjmKxOY793OtOGM/UIJivXTIVrcausGnCqhKMPf2imhP6y?=
 =?us-ascii?Q?TX86xdeePr/9a5Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4c18c2-78bc-4be2-def2-08da0971c786
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2022 06:29:11.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+ii/Utbdphpt5o61LBD6WW0BbzQpKItzZvYxtL4774C7KwqJY0FAScfZJADsdM0QKId5kbqoKlcMZH0CuOlmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1798
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10290 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203190038
X-Proofpoint-GUID: DE_shnLN9dgY0rLACOAvIoz8_7VtjjNW
X-Proofpoint-ORIG-GUID: DE_shnLN9dgY0rLACOAvIoz8_7VtjjNW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Relocate the twin mce functions to arch/x86/mm/pat/set_memory.c
file where they belong.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/include/asm/set_memory.h | 52 -------------------------------
 arch/x86/mm/pat/set_memory.c      | 48 ++++++++++++++++++++++++++++
 include/linux/set_memory.h        |  9 +++---
 3 files changed, 53 insertions(+), 56 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ff0f2d90338a..648be0bd20df 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -88,56 +88,4 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
 
 extern int kernel_set_to_readonly;
 
-#ifdef CONFIG_X86_64
-/*
- * Prevent speculative access to the page by either unmapping
- * it (if we do not require access to any part of the page) or
- * marking it uncacheable (if we want to try to retrieve data
- * from non-poisoned lines in the page).
- */
-static inline int set_mce_nospec(unsigned long pfn, bool unmap)
-{
-	unsigned long decoy_addr;
-	int rc;
-
-	/* SGX pages are not in the 1:1 map */
-	if (arch_is_platform_page(pfn << PAGE_SHIFT))
-		return 0;
-	/*
-	 * We would like to just call:
-	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
-	 * but doing that would radically increase the odds of a
-	 * speculative access to the poison page because we'd have
-	 * the virtual address of the kernel 1:1 mapping sitting
-	 * around in registers.
-	 * Instead we get tricky.  We create a non-canonical address
-	 * that looks just like the one we want, but has bit 63 flipped.
-	 * This relies on set_memory_XX() properly sanitizing any __pa()
-	 * results with __PHYSICAL_MASK or PTE_PFN_MASK.
-	 */
-	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
-
-	if (unmap)
-		rc = set_memory_np(decoy_addr, 1);
-	else
-		rc = set_memory_uc(decoy_addr, 1);
-	if (rc)
-		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
-	return rc;
-}
-#define set_mce_nospec set_mce_nospec
-
-/* Restore full speculative operation to the pfn. */
-static inline int clear_mce_nospec(unsigned long pfn)
-{
-	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
-}
-#define clear_mce_nospec clear_mce_nospec
-#else
-/*
- * Few people would run a 32-bit kernel on a machine that supports
- * recoverable errors because they have too much memory to boot 32-bit.
- */
-#endif
-
 #endif /* _ASM_X86_SET_MEMORY_H */
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 042cfac6272b..9abc6077d768 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1925,6 +1925,54 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
+#ifdef CONFIG_X86_64
+/*
+ * Prevent speculative access to the page by either unmapping
+ * it (if we do not require access to any part of the page) or
+ * marking it uncacheable (if we want to try to retrieve data
+ * from non-poisoned lines in the page).
+ */
+int set_mce_nospec(unsigned long pfn, bool unmap)
+{
+	unsigned long decoy_addr;
+	int rc;
+
+	/* SGX pages are not in the 1:1 map */
+	if (arch_is_platform_page(pfn << PAGE_SHIFT))
+		return 0;
+	/*
+	 * We would like to just call:
+	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
+	 * but doing that would radically increase the odds of a
+	 * speculative access to the poison page because we'd have
+	 * the virtual address of the kernel 1:1 mapping sitting
+	 * around in registers.
+	 * Instead we get tricky.  We create a non-canonical address
+	 * that looks just like the one we want, but has bit 63 flipped.
+	 * This relies on set_memory_XX() properly sanitizing any __pa()
+	 * results with __PHYSICAL_MASK or PTE_PFN_MASK.
+	 */
+	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
+
+	if (unmap)
+		rc = set_memory_np(decoy_addr, 1);
+	else
+		rc = set_memory_uc(decoy_addr, 1);
+	if (rc)
+		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
+	return rc;
+}
+EXPORT_SYMBOL(set_mce_nospec);
+
+/* Restore full speculative operation to the pfn. */
+int clear_mce_nospec(unsigned long pfn)
+{
+	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
+}
+EXPORT_SYMBOL(clear_mce_nospec);
+
+#endif
+
 int set_memory_x(unsigned long addr, int numpages)
 {
 	if (!(__supported_pte_mask & _PAGE_NX))
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index f36be5166c19..d6263d7afb55 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -42,20 +42,21 @@ static inline bool can_set_direct_map(void)
 #endif
 #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
-#ifndef set_mce_nospec
+#ifdef CONFIG_X86_64
+int set_mce_nospec(unsigned long pfn, bool unmap);
+int clear_mce_nospec(unsigned long pfn);
+#else
 static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 {
 	return 0;
 }
-#endif
-
-#ifndef clear_mce_nospec
 static inline int clear_mce_nospec(unsigned long pfn)
 {
 	return 0;
 }
 #endif
 
+
 #ifndef CONFIG_ARCH_HAS_MEM_ENCRYPT
 static inline int set_memory_encrypted(unsigned long addr, int numpages)
 {
-- 
2.18.4


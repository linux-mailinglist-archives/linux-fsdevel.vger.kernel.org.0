Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34374A02B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 22:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345188AbiA1Vci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 16:32:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22068 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346088AbiA1Vch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:32:37 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SK3uGl030747;
        Fri, 28 Jan 2022 21:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BpLrUXu27m8TBMebgxcTEGYDfcF1R7IFdRjAS5rNhVM=;
 b=iGl1mYVeaeq/aqbhyl5y6gx2j5/YEpTzIYC5sgNFsJbWEI1oftAcjVc5PrBPEeIpIgE3
 gTyviA1TTsrggHQDlLcQAMsL4qjb0f4OnK4raMlF2226tqctcoOBOtAq7WGexF9o2+6c
 5HrxyB/CorQSNkRSrb9wHfypMV2keChhZnWwINBiX3Yrgm8vi7+BWgahLrEEZfwQZRtP
 /Fn72OkDWOf0BlaKT2JC8cs3+oZ+5jVkhrCfYpXi9/7Ls3iHlyF9kIvPY/yBS0VUcru1
 3RbhKDG4+dBc+u7QFLtbcyl8GHBnSHdEIspLQEqQkMEQxUruGYSoUVosAC/35H3QNPjL uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvquvmpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SLPpxW033639;
        Fri, 28 Jan 2022 21:32:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3020.oracle.com with ESMTP id 3dv6e5qdkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxBN+B6YXR14h4wVBQpUdDU54vqdou8Tp1oBnfdFSDqSMYKHAXSUG7nCFydb8y2QKa4X51Xejd8c+OBBTCn6jD2Rsy+/eguoKZ3wJ8LAy18Kbv4Ph638unhvL47cRGBsIoFR+7BDosguq+QfcutG3/K8AHZ7Ince5Ub11UeuNCM6BEYMH6sED1HhBu9TaTDYVR0bLuJvNvkOR4//OENJnqVvZmry+XDGdnaSCGvJGv2maigTPWrUNfcKmSIZSKS1wql0xmq23SuF0LKhXqcysYama3CcUFO8n2PzNFtdlXGvxTi93uwzW69a5JCmhHWiCijEKW4M11deJUlMMmxgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpLrUXu27m8TBMebgxcTEGYDfcF1R7IFdRjAS5rNhVM=;
 b=Cz+3CQEGWxXSadLR44ME+xy7qcjKDXqBbtA60JsXfC7r1PMFPVFN1qprgUCpngq8F25Hy/4z4tTFdjtHoJp85M0aOWBx3I+wOTpMmW5sSDlwrfuJ4YNwFaUCGG52VeRm+JdXz02Rpi880G9Y+Tl5aEAlKIEOv8MhxI0D1TgGqrqH3w/B0+GL07FTxHOc83/R49iJnxsbEScPNV5lHFIoU6nD0rC5XkFdN/gEAgFOcqfLJlibOeYEL3vHdqrJa7+6rXUYtuvSq/HYp/93KIetcDqDsVYswHx1T4Kp/nxHNsJXt8JRZc6+TWSNUv3FZh8GoPGdXILYpY0OzFxAlS3O5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpLrUXu27m8TBMebgxcTEGYDfcF1R7IFdRjAS5rNhVM=;
 b=eA3DmuvnCUBDbDUZb0h0BPiR8kJJKizCOgasrUz2crN+2P702tK3XQkvaFnWV6J11uMRq2ITUr0NFaWJonjGydJbsC3VtOWmmWfVMIkbm6TvehtdK5atApxUIgPwkDpHyBLxY+btSg6FugWzuogy6SEdk3uiSxiL1dWpaiKPmHU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB5753.namprd10.prod.outlook.com (2603:10b6:510:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 28 Jan
 2022 21:32:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 21:32:18 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v5 1/7] mce: fix set_mce_nospec to always unmap the whole page
Date:   Fri, 28 Jan 2022 14:31:44 -0700
Message-Id: <20220128213150.1333552-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220128213150.1333552-1-jane.chu@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:806:121::16) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0572d86c-9145-4902-3db3-08d9e2a5a8f7
X-MS-TrafficTypeDiagnostic: PH0PR10MB5753:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5753DA2187773932C4674308F3229@PH0PR10MB5753.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJU9Souj4t6evylVhzF2rmAgSkuphGJW/kgCaO4tW9gQAgp2REUTmI9DyGJ6OgWpyxtv+Z0t33iuEMHLP6jt7e1khuuYbztumPp+TQBD6dvfbyTTuLTwep6tSk1Q+BU362gjt9qkdl8qocXidacd74rGE/Wn7jnqiugBhGAgo54mFM+BdfaM6I1TDHv+GV5Pid/E9OGfJYagsq4p8Q+ZuTckND/uV7aHDu0c+og5Y+SuFNskkbBbTS7QIAueKxC7d7iUrhI/10Sewd3qxUHCut4bChGL43+nLCcVsEreHX8b3VVuBVWlaaQ2vdPhqcPfTThC546Fp5BDttM//w+PPcsqlV6lyzX2fW4FznPTV+RYWtOcpXUq95wZBOqn13sD7fc2DzGcK4y4H7lxvuCP/UxX9stOAv6qWImQohpGk+NzAGfZA1xs7YVKNgRpalY5B5uD1CzrGPBGQWfayMJS+wQi6b7bzuRmYKp6KBh0oHRkhxDSVolDuwAQ24gHMgNpdcLs2eSE1yi1IwQlcxiLVVJ7UbzeXZg45CozZcwXtK/Ns26AqweC1zmch/BlhP9O4YuNuB5IjMLyASTwCuFYSymQHX2ztSFLBKeArnhIwVnH37dTk6kR3MVhK72NuJXH48xOCifU/Sod/CHmNCrkBO8sbBzpiigwxRg4oU1x4jLvuni6DsQFRYk2x/Y+KGoAYHM/Zt2f191oEz/dtYGjK3afWHpnbKPOl5F9im4es2ZKs8WfJCJ9bE8NqsuCIKJbCgHkekMSS2PQv73f39VbLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(8676002)(36756003)(38100700002)(508600001)(86362001)(966005)(6486002)(2906002)(6666004)(2616005)(8936002)(6506007)(316002)(52116002)(66556008)(6512007)(5660300002)(66476007)(66946007)(44832011)(1076003)(7416002)(186003)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DqtLifwj4dIUOiJl+FCS/b9k1Ym/js74fHVbIknJCd2+gbIJkPsxFl336jvh?=
 =?us-ascii?Q?ncWTvYHkys7yXg2jOTfXstnNMAV5VITUsXohOJljmBTFRyZrRToQ/5Liu4cc?=
 =?us-ascii?Q?727FvEnDw+B+ht5HpKk4pyW8kekJWJQivmjKQ3NOOWGs8fpaHZC6I1swDw+q?=
 =?us-ascii?Q?HNymPw3NzzV189O7LLq0sDngBP8muRa1gC2Ret9JKclKiBKA6NTdgQ9A3aDy?=
 =?us-ascii?Q?EVmEIdfam1C5VRG0P3rQUblekVITZyHTCvzF6nHMhVdmCvzcau1nvGw+SXlj?=
 =?us-ascii?Q?/QgPuxoR3z09zJ2v8Ht+7jKyuiVqzNFz8/0VSMZXIkLKRh3TXY+MT52N9mD0?=
 =?us-ascii?Q?lT409vQeyNO0Kk/eHUgmIdbeOP9LZ7bAU2kYrWsW3hnICQOFI7A7IiviQPaV?=
 =?us-ascii?Q?xrvUOPOjLsBZmi6K2Ohy5N7Sh9rDG5OoCyuf0uNV3bSagqUGifUO5cr6v6ip?=
 =?us-ascii?Q?YIKZPkQzVvX5CJSjP/iRbgdl4P91aJOgX9wQFXErVOGA19e8bSTPSJysLP7D?=
 =?us-ascii?Q?ZxtYv287/KxUhzzEcYoLY0iEwPp7gWjnQcWKzNjkjG8Q5c9xPMgGrkUMaNWA?=
 =?us-ascii?Q?vOfrde8spM/JesbV7I6GHQCVks+8dOZ5cso7ChyCrQ9oYOfqA+jJtYm9/fQ2?=
 =?us-ascii?Q?U7pbmFTKv5SIh8rXNnThIB+1nj0bpjNPRJPCt25KqkSez8TtqsLFOUlVFNIZ?=
 =?us-ascii?Q?PJbYoJlNKXk1+7QhlQueKq3fRS19YYICiSa6ZQegJdk+73j/49/UBdRc5LYs?=
 =?us-ascii?Q?MZ/H9VwODYkjKiZHDNEKWeVnBaR5YZTFIK6MZR3Jj4KLRAHyJe+KzFsI+oT9?=
 =?us-ascii?Q?uGmyix29EsxOL+Vp5PDmlD7tX6MU3M6XNkMaPIaeEDl2X4cKckL/ZRV/indl?=
 =?us-ascii?Q?K5dR+HLSKGQjX0i08EHI8oujadHw8/x4InJdLkTazPzVbij4fM9vNGy/wyCt?=
 =?us-ascii?Q?TXsODFUHT0cxyANVF1mpLsC+fiQ5YaZlQb0a+g/UsDbXbu39mdQ6GZlwmnWx?=
 =?us-ascii?Q?0dA+7dSl5SL1TjxHL3cixoqWAs/PalScVsuaK0I/bTyVhZjqIQEXSQfzVlY7?=
 =?us-ascii?Q?7rXdowLdYfI+rnbTG8kSjlWXlBoGzksDZ4+Z7ds+dHpmw8zlYqymKQw8qCh1?=
 =?us-ascii?Q?uWW57tqZFBQnMRzbf0wZ2RC2lJfKJ8J3RZMgtJcnUv27mOTFn6JioH+mGQcx?=
 =?us-ascii?Q?dM0qYXDYIkac9XbsImcwcr5royp5jcNeVDg7f8DsKkzb4FyFvoK/JykeAulN?=
 =?us-ascii?Q?PJFo/YYj2lTFifrfZXu2hc9Xe7ZtdtoaJMSaJo7xANc3LPWg3evAmXyIEtQW?=
 =?us-ascii?Q?mbMIXnc1KQkrbCPZv88MEKp+Yjd3xfAOiXqST4GqPhIuZFKZwRcSnp0DMUHE?=
 =?us-ascii?Q?ozC4dGmGh9uCt7k8HLkE4j8xqtwiqSLFDSo3mSSwLkHOCLB8ZbDmFJzpUMvh?=
 =?us-ascii?Q?p5xo662Bti5vb/ykvmXBzsPHAXBUCaR6g94p+MeiIfwGJhzN3M4HHMCzAfmV?=
 =?us-ascii?Q?btdTaq9+j5JTT/nHAqDlSRZo7UwIYj/lbU2zFI0Oss54L5tPRcj9aBi1VvGf?=
 =?us-ascii?Q?4HVW0p1o52Yx4ViJHZiUuPiA6bVJVY23CTnu2JlaRGGh54JSMM85qMSKgzdy?=
 =?us-ascii?Q?/5fuXj425Gq4Qv4CljcYxejOZFkq0xSViyu+rOBB00G2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0572d86c-9145-4902-3db3-08d9e2a5a8f7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 21:32:18.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T8IuRnDHICBhvmaiAGm+4QXcWCT9CmEZWRojN8xwq63qEppI7r4eH4797ls8CYfY7ov+OnK/o6dhD0UQJFPWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5753
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280122
X-Proofpoint-GUID: l2_mKZQfgxw-YKmRbpeQAnOPgVc4aTMP
X-Proofpoint-ORIG-GUID: l2_mKZQfgxw-YKmRbpeQAnOPgVc4aTMP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mark poisoned page as not present, and to reverse the 'np' effect,
restate the _PAGE_PRESENT bit. Please refer to discussions here for
reason behind the decision.
https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/

Fixes: 284ce4011ba6 ("x86/memory_failure: Introduce {set, clear}_mce_nospec()")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/include/asm/set_memory.h | 17 +++++------------
 arch/x86/kernel/cpu/mce/core.c    |  6 +++---
 arch/x86/mm/pat/set_memory.c      |  8 +++++++-
 include/linux/set_memory.h        |  2 +-
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ff0f2d90338a..aef6677da291 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -50,6 +50,7 @@ int set_memory_decrypted(unsigned long addr, int numpages);
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
+int _set_memory_present(unsigned long addr, int numpages);
 
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
@@ -89,13 +90,8 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
 extern int kernel_set_to_readonly;
 
 #ifdef CONFIG_X86_64
-/*
- * Prevent speculative access to the page by either unmapping
- * it (if we do not require access to any part of the page) or
- * marking it uncacheable (if we want to try to retrieve data
- * from non-poisoned lines in the page).
- */
-static inline int set_mce_nospec(unsigned long pfn, bool unmap)
+/* Prevent speculative access to a page by marking it not-present */
+static inline int set_mce_nospec(unsigned long pfn)
 {
 	unsigned long decoy_addr;
 	int rc;
@@ -117,10 +113,7 @@ static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 	 */
 	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
 
-	if (unmap)
-		rc = set_memory_np(decoy_addr, 1);
-	else
-		rc = set_memory_uc(decoy_addr, 1);
+	rc = set_memory_np(decoy_addr, 1);
 	if (rc)
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
 	return rc;
@@ -130,7 +123,7 @@ static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 /* Restore full speculative operation to the pfn. */
 static inline int clear_mce_nospec(unsigned long pfn)
 {
-	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
+	return _set_memory_present((unsigned long) pfn_to_kaddr(pfn), 1);
 }
 #define clear_mce_nospec clear_mce_nospec
 #else
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..8d12739f283d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -613,7 +613,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 
 	pfn = mce->addr >> PAGE_SHIFT;
 	if (!memory_failure(pfn, 0)) {
-		set_mce_nospec(pfn, whole_page(mce));
+		set_mce_nospec(pfn);
 		mce->kflags |= MCE_HANDLED_UC;
 	}
 
@@ -1297,7 +1297,7 @@ static void kill_me_maybe(struct callback_head *cb)
 
 	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
 	if (!ret) {
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
 		sync_core();
 		return;
 	}
@@ -1321,7 +1321,7 @@ static void kill_me_never(struct callback_head *cb)
 	p->mce_count = 0;
 	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
 	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
 }
 
 static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..68d84c8bd977 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1816,7 +1816,7 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 }
 
 /*
- * _set_memory_prot is an internal helper for callers that have been passed
+ * __set_memory_prot is an internal helper for callers that have been passed
  * a pgprot_t value from upper layers and a reservation has already been taken.
  * If you want to set the pgprot to a specific page protocol, use the
  * set_memory_xx() functions.
@@ -1983,6 +1983,12 @@ int set_memory_global(unsigned long addr, int numpages)
 				    __pgprot(_PAGE_GLOBAL), 0);
 }
 
+int _set_memory_present(unsigned long addr, int numpages)
+{
+	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_PRESENT), 0);
+}
+EXPORT_SYMBOL_GPL(_set_memory_present);
+
 /*
  * __set_memory_enc_pgtable() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index f36be5166c19..9ad898d40e7e 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -43,7 +43,7 @@ static inline bool can_set_direct_map(void)
 #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
 #ifndef set_mce_nospec
-static inline int set_mce_nospec(unsigned long pfn, bool unmap)
+static inline int set_mce_nospec(unsigned long pfn)
 {
 	return 0;
 }
-- 
2.18.4


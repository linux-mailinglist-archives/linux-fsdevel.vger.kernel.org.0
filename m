Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8B48B655
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350366AbiAKTAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:00:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19258 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350328AbiAKTAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:00:20 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BI21Nh014936;
        Tue, 11 Jan 2022 18:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=UXtfIKwkptTjTLkC/HHXgr6CT19lCc/Qyppb1ppyxFI=;
 b=qr6R+8Yw1150MDTDHA3hUMAGHUXjFRXzRDTNJ6GAhOINYG8A21eb95TfCOt9giBJS3Br
 jCQS8cVi8LfDHEoUuK5asTHzPIBL6O3PLD8+H/ctb18lv+U3gM3XB8A/xwKjEEdNhRLz
 coQL4D0Wy9Oqq9F9U6SgK1o1Jho/IJz/PAQmJQcmNbnBNi6meqokG8RaFPFH05SstCf3
 SY72rAU4N8swmQxhlROdbo9FKqfxXpZHN/dh+Ex6EqnVx8TtMRV1RZ85vnG05gCy0lKK
 zhAMoH+x1Ok+IIHmY3HZ+6vDOxSvw3qsGgjR99AKxyDu6qaPmWBq4eHH1EQaJBRIG9S7 WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9c20s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:59:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BIpcm9110933;
        Tue, 11 Jan 2022 18:59:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3df42n7d4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK9ICO0ldsiv7veOkz1FJEsu8tXPA6yzr1Ee907poLyic+HcuuESShZLu1Vbi2o93DEt9Kum/0YkNOh2xSs8HUFpZY7ewu82H0IvVkcxmH55pKlDWYXO1W2NlfLK42qkOp2+GftYBj8ayEWfyMERWiE2bMfSmjrSdlvUtsA25ioEHEdG2i00iAy7KufCbzN4rQh72gXSpWtnVJTX0eoHJcIcOugWT52QZI/hcMcUDwdUvijcrkrbg5/dDRTUkypPt5OmgUhhOEOci3dVRvdIijZsV/el6LKzlnOQd77KQJiGIvkyxm6eeBud5Gx9VIQBudcMG8zSBKiny/x8Rual4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXtfIKwkptTjTLkC/HHXgr6CT19lCc/Qyppb1ppyxFI=;
 b=NCGdYnRoNsO6Yh2jbhJUno8LX1UHfK8z3gNAqIWArDmdYgNvel5jQu9a5CCPYwKf/uQeWvh5p5K7tQVK5EjBP/60JPAOv5e6Pd3WfFEHCvOZ5iX5NXhsRn9mCWFQfUPbVUTZh24bT4xfqHpWV05DeN54MXll+v6AhX4HzxJ8ojgwMwruqg3WfI/w3vAnk/HC8ZLe7oMeSTthW9VW/WGFxdRcix43bwexeW3De2FC7FxEJnBvM0Pzv3gU0uNMNcSU7sw/CA+ihGXRgLDAHlAuJ2nu67ZnMBpW39dT7vhZt6Z8fw84GOr6s/+/VRS/lZQrvcdin/D0WBim+sRp3oXguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXtfIKwkptTjTLkC/HHXgr6CT19lCc/Qyppb1ppyxFI=;
 b=dLigXDEOTkFIriO9sVk+7aeVV8S/v7/j2ycIlMgfxvj1QyN4v5c2Mpv88BdgbFx0g2szgdWQuCYUR9FqfWoQ/JYnmmmr2OZo9X/FWivCE/eXc5HDW9eTFKJNrdlCSyM9Y/9hL7DK/K/wfkB/WhjNXPsyOorkvOYuIAyXwoH1o+A=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 18:59:49 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:59:49 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3 1/7] mce: fix set_mce_nospec to always unmap the whole page
Date:   Tue, 11 Jan 2022 11:59:24 -0700
Message-Id: <20220111185930.2601421-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220111185930.2601421-1-jane.chu@oracle.com>
References: <20220111185930.2601421-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31df977c-208c-4ed9-63eb-08d9d5348aec
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5647:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5647D604E1491C5F1B252613F3519@SJ0PR10MB5647.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axuuJKQEwI+ofLgGZ954h3VMMtSYhSze1cB5XWJQ/XDGTTICviSnm2VsdVuBczwP41s+2dWawAQ8QTpnDuVcjxeN7rVAlNwDfULpotZN8Ea1pMMG6A0XrZrCLiH0q+6sTvRtaF/MCfYf0VhiBSDQJEJDJX9zM9l/uP5KK4zqGfaHgeNb2c8h4mYaQt0YrWOsRdAlNWOeI3pWkzYL6+5n/cdt+CI2Q7GodbGxOgP/9YkDcF57LMYwZEg95iI/f+2VeePdZHkzdjpTCnyLxmLA5Gyjy82ODr9wbLNuN9jniJNLDVSAgf2bj6ucHT3OyEQ/BrVkx0sbVwTt9A0hppHtTuNKOOa3aYwjcTRkur6Lf/dY+zNdWAX+hTacmKyvdJRIamvYlIIehWwJNnoXfdBqVvC9yAlvdv1qMcC9NCnYkjubmQthAOR+51Qzt6jwATUJYUQ9UeUa1hjbo+1NUvxp66H0lrjXm9RPd2ac+kt1k4t5OR8V6G+kRbe/ylJxxZEukGY0qZCmnNIhFC2cu5c/HfrU+CwSjfaGRkpvH3x9eRuBoq8srI3iRNPec+KRzFuI5R2Rt9QkuVx3YcLPqqdjP2p+1JBOQ4sR+jdnCAUxtj2ujuf6/9Y/i728jeVhP8qamXaHScDYTV5nKxgLIIzKmOwJiR0gS2wvN597P3wwO0qDUghzwOgLMWs99TtxiceJithnoFovQ7thCWwbBD9hQ6E13CrEZIwKPYY5DxZhDHSHH9Oy2zwSsuXBMoThjzVOJVbWxqGKQB0RzTBAoukfBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66476007)(508600001)(6512007)(44832011)(66556008)(66946007)(86362001)(83380400001)(1076003)(38100700002)(6486002)(36756003)(316002)(8936002)(6666004)(2616005)(966005)(921005)(7416002)(6506007)(2906002)(186003)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZ0iJsPdZqfnbQdW3Joj5xaMrOvwWwOWG+uoULkanMpwTVEiGb1mefMNkE0n?=
 =?us-ascii?Q?dBuDXcMAsW5oxRkyXMp8XU8O/p4kD9tYResoWpHutt0aghNpLNZaZS2SjtOm?=
 =?us-ascii?Q?P2BPMB7Mj5EeGjrEA7dK+KJwOAvh5MsygDtAA1/yVbZd7gkhm78044Vvkum+?=
 =?us-ascii?Q?TlInbZQRbU7ljm4+5soQY2kGs7atEFF6/3UTnodQWncj80CV6xA77a0Flvci?=
 =?us-ascii?Q?6vrwdEYL4smBiDpjpRTohWx9sAcFgNzVj5Ex3TyLvHAzeGaQV5OETEXT7i0S?=
 =?us-ascii?Q?wRFteQ6NiGApmATFfQVF82pidUoijwkvgGabtf4YzthuSDzaR1vwFdspZEqj?=
 =?us-ascii?Q?MbWTHo+7RXMWSzDBTPM5Bu2ktBuXYtToEo89EX5n/THZJ1xREOREThieI0Cn?=
 =?us-ascii?Q?0evUCChe7MWcZOuLjfNFJ0OZu3Hpl09Et1IYJQ169LoKv2BxqFsQR/KYMv8i?=
 =?us-ascii?Q?HPJVAzb7aNwKxk1sWRH5BRJGTq50otgxOlYHljK+9gHQbQAt+YdgdPeGN28S?=
 =?us-ascii?Q?toZ30fwuOsFapZEfPeE0EeRibhgjlcM+SLoQjXLmYDOzfMVydEAgYezSezCN?=
 =?us-ascii?Q?8zkM8bLw99fsF2I0ak0eu2cG9ZsvmWzTuCVM20tjsP8fFkWrxYXYoPBQ4P6v?=
 =?us-ascii?Q?ihrdQvG9s8aVIJUltbWOle8gePX1Vu/CNPaNMmYWhVMz5IC3rQ7eFYyJ9M8v?=
 =?us-ascii?Q?LvVvx4cNMzaFbE6s4f0MlRch9/QMP/jaaiMENvHmTG2+01uMx9u0y+fAxPKs?=
 =?us-ascii?Q?Zmh+KwJLk/jhX05aLKRbHm4ob2uRAcMletHEX+sJlYLMz0hrv8Y3dugI9MW4?=
 =?us-ascii?Q?vpNo4kyOVf9UqfQvoty70n3SJ2H+2R5TDWeEEPglgAbqWH3Wevy4pQdLPRWp?=
 =?us-ascii?Q?1bjINqmUU9kmpLmy7veEdIOatOkQD2pd/y0X62OdPStvVtMOKfgesO9epdvH?=
 =?us-ascii?Q?ZyHMiVCABujI1lIxpxN1rUps+345AfNz/b9yy0N16k/bjkq+Io/YqAL2mDRT?=
 =?us-ascii?Q?2MnXvuAlQybgTzXaxFxfUvfmaMQkwucT602RhiY7en7btvAD17E3WtPiF6Yo?=
 =?us-ascii?Q?BPrser0oweG03GVioiNindowzGaJnn6FEyNUg009vPI/qPa/eCd3avckeJq0?=
 =?us-ascii?Q?Jd1/GH5MJ8m2I2XZFONXbaX9pZ+h03UF0hggPmisUeLvmwAgXhmzWoyowYBT?=
 =?us-ascii?Q?K2bZKZqH4Ew/KUdR/MUCemoVv/4ZPc0VRwnBBR+gWnOffk0hZwxG0mbnmQ6S?=
 =?us-ascii?Q?oDoiwa5QD4B9IDoR9qJcN3ZT8x4Zn9h7ZZJ9Qpf1dV1UPUHZVMX4PSN8nt+M?=
 =?us-ascii?Q?E28o8mzKLq1I4UCtdqBw/49LnCpyhvVIAy8HMiafg8S4oSB/73l6CBZKLAjh?=
 =?us-ascii?Q?VmcWcNeFGYfKucTyQwyjg06Jl4K6zQrJxcIlfUE4GmDxucqSv5PmIfCVcFat?=
 =?us-ascii?Q?1RoqUN6Y5lXWwoUTz9PMfXJWTHrOD6Whfx6oRrdmLl8LRU6epUxnBS95LHhc?=
 =?us-ascii?Q?CEWQ7Vi7DIo7W8EpUu50lj6oyjPxCx6cH79f2Pnx+Jci5O5YyLK30v0OWj8L?=
 =?us-ascii?Q?8kVd3cVBOnuMC2UXd3VbV3GciifkVBGmHYu45+Oex227bqAnCKhnlQyIFG4a?=
 =?us-ascii?Q?EpckBULlGH4uDwIfIlF0URtFBhm08VzD0dD03wFlUQzq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31df977c-208c-4ed9-63eb-08d9d5348aec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:59:49.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYaNuf7EGHmcxYQw47B4gXJqSS7IiB9lBdVPCEcDcAeW4wtk8C/f3xddrHeAl2GtyEMRGMGVhwy/DgtE/M5HPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110101
X-Proofpoint-GUID: KM9JFGo0v3FiEvTJgBv9OpJXFuqxLf1k
X-Proofpoint-ORIG-GUID: KM9JFGo0v3FiEvTJgBv9OpJXFuqxLf1k
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
index 872617542bbc..63539dfc6ae1 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -49,6 +49,7 @@ int set_memory_decrypted(unsigned long addr, int numpages);
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
+int _set_memory_present(unsigned long addr, int numpages);
 
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
@@ -88,13 +89,8 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
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
@@ -113,10 +109,7 @@ static inline int set_mce_nospec(unsigned long pfn, bool unmap)
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
@@ -126,7 +119,7 @@ static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 /* Restore full speculative operation to the pfn. */
 static inline int clear_mce_nospec(unsigned long pfn)
 {
-	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
+	return _set_memory_present((unsigned long) pfn_to_kaddr(pfn), 1);
 }
 #define clear_mce_nospec clear_mce_nospec
 #else
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ed365337a3b..814c016b75ab 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -601,7 +601,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 
 	pfn = mce->addr >> PAGE_SHIFT;
 	if (!memory_failure(pfn, 0)) {
-		set_mce_nospec(pfn, whole_page(mce));
+		set_mce_nospec(pfn);
 		mce->kflags |= MCE_HANDLED_UC;
 	}
 
@@ -1255,7 +1255,7 @@ static void kill_me_maybe(struct callback_head *cb)
 
 	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
 	if (!ret) {
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
 		sync_core();
 		return;
 	}
@@ -1279,7 +1279,7 @@ static void kill_me_never(struct callback_head *cb)
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


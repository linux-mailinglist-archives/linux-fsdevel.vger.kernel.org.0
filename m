Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6134F343
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhC3V2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50270 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhC3V1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULNipb130302;
        Tue, 30 Mar 2021 21:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=h9M1QscLLjk4WbpjAPe7cGX4t+n3aWpsMfiMaeRoEkU=;
 b=xUm2yJ+PUSZFOs1US3yOFPmhiYbH4daGe8lDTBo0u5i4Ddw+GJG6OJzOFPF5SfW2fQ0s
 L60aaZG0EDG5MPO/Z9I6YEmE75xpUq4lMaltkt9DYnX3Keg0/aKIOAvHcFhXoiOtOT5E
 ANSVCcUFA/Ga9rkcuwNR0D7dAiJoMTApLb6pjln7HWyeN5gjFxCjZQZNrU+C6LR+MsON
 NaimmkTrgjOyYdrWVi1wpXGjAnt7y4ynMmMTzddzJosX+g/9zqYQtqOSHsjNUCvmpNe1
 5FiVX8+j6Njjk41ElRUbUxlej7jn1w4kDOTwP7YXB7IeLbUAHcTqg4ETDPKTDMruAk0e xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37mabqr8q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPZCG125027;
        Tue, 30 Mar 2021 21:27:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 37mabnk7ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPVGaD/gLe91pBvE8wmWg6GvIiYYnOtvO3w1fGPo9SoeG1bLXXx8VyKguUoNkrBIlA+f2aNsgoyKH7zjH56PGCAh8n0u4beFrn1CMF5ZZ1iMf17qqHmkPUbGp1Goo6RdWJNz/jS3lkXOfKt1mq7nK0AfUJVlqcQojjEKx4HmLeCPzYICDLJJQRZmrJOPbuNPwV6AoMm4tsfmTAiDRCn9CYj05I4EB84WwYDNx+5fmwzPXkjTkS9ZuiJSL6KBB2tFeV8MOTdHJffM/E+ZtaNhZx1Q/Nf/4nIqouPjRLgvixkqpAnTZe3ato8PIj7SRVdXkH1RBLkBNxhqg6pDFvxF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9M1QscLLjk4WbpjAPe7cGX4t+n3aWpsMfiMaeRoEkU=;
 b=XK/7ZvR5y90EDiWomrEVHEzfbsYv3mQloFGJCw1qvspUDkGdx6OndTLSoUBTYv9XEqLFquSTJr/+SJJs+KYShPQPVvt7fnQ4KmUOOoljOO79C4/QuphM+wddxdxhGs89h+VtQHIZ25w9p7Kw2Sj4l1BZozR8hqYNhsGwutBs4yKgVWQDEa8yJQN3XvyuGYZAn3aOaIuwdpFmrdDtlVCoqNBwY/YRd+RetgOjpvTqWfx/6Spr9EqLg7inlY3K6Vd/ZnEb951Qp5Sz0gQHT+fJ1ks9VLQyMbkMPG9aaMT+Q79kVz1KFEEhkF7KN+s7W3tz6qUabTWEcNCE7G6qnnrLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9M1QscLLjk4WbpjAPe7cGX4t+n3aWpsMfiMaeRoEkU=;
 b=sgcQYoTkD5cJ06Y+ULGrxxmacTRxyQabmTXizUGkegi1wUprG5B6V4qxUQsmJurkR7e8l982auoUEA3U+2oH+DI3cGqptWJ2YIaftjQNvGgkzNpTfFc/a5T6bm3vBwhxsjgFU2CuQk2US2KEEvBQTavJRCn4u6xxjWzZCgCnR2Y=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3679.namprd10.prod.outlook.com (2603:10b6:208:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:01 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:01 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: [RFC v2 28/43] x86/mm/numa: add numa_isolate_memblocks()
Date:   Tue, 30 Mar 2021 14:36:03 -0700
Message-Id: <1617140178-8773-29-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.8]
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0837dc0b-dfc6-4fbb-fbc1-08d8f3c28e24
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3679F1D72CB64F57CF6FCD74EC7D9@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kv7gMLgjefEV6Z22xxu9YD0v9/HhkmXnOiMzsUDdZ38U/fGCvS09D+pPKcF4bRGEa67hf0yPrDPqguZnIaPsekHy2VLDmNUIjcJ7+lf0xOHl3NY/yal72C3buzPH9bKCnjlNWO2TH/9Nf5C/UBbuVOQmQjJues2APGPJTl404aQ2t78ZBCGmoVq60J6JOB5MSO0BeaeC1ZKpu3KRCy8H+QDLrU35fbqBkhjwM/WyF5VG+4/TpFNaN5HtjIhRVjzLLmAQSWLnxkIjVMGe3udWajbysSXUew5weIm3bjkKN/fotVk6GD5ucHaOVMLfF23lT2qy5UD1fG5+7d22MZwY0lloPYZKPP7k/ogtOxtMYmTbb3mggyjLelnYVFiLbOsFyGNucZ4e47RTLdMQx8bXaDBayx3UKHaz33OHfxwDGyIj538bl7STN351SQiL/STQg2pKlf6cB6/93swCOghGZP50Q98S8r4hPZEu7LXeVsXbMhH/MxgKm5QGv8APMW8nBzT5ATx546iINi5Oqt+j2BAm5uSCmTulyn3qjuPRO6mwM7I2Ug4EY1Ub+P2nXzOx7iLbWkN+vEJKCtFY+DqJyaixUvWGSuzsIJ+wyc4KYwbEJ0JUvGUxQb6VVJ8kLXV6q3Eh1BIDViL6Amgpl0pRCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(956004)(2906002)(66476007)(16526019)(8676002)(316002)(2616005)(7406005)(8936002)(44832011)(83380400001)(38100700001)(6486002)(26005)(66946007)(66556008)(7416002)(186003)(6666004)(4326008)(86362001)(52116002)(36756003)(5660300002)(478600001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qpCQmMFasH8/9o4rHIiwB2+X95wGOCTmcdGPg3Z5nS7tPIV0V5rPQgbH6Ix9?=
 =?us-ascii?Q?DgZI23QgSlIzDzK87uElUhvpLRXZRpiZhsTOkGoLmjclqgieps4gnYSsbIRm?=
 =?us-ascii?Q?5IKFJhuJxflDPSJRrwoSmH2mAH0SIx49dTO9UyKgsibfalqjatwR70TbWA4R?=
 =?us-ascii?Q?4vcEAqfZp+CDGpqEUCinZAfkXRBlUywG5pDWR5Y9cPIYmSXuQoJDcHbfBpH+?=
 =?us-ascii?Q?A7tjVwU3a/rMUie0Pl6GtAnK1L0aNYteJWvlFdYeLvtYRRIA8UyPtdCcP8Vh?=
 =?us-ascii?Q?qpSnajrKgY1D6L46DAq4Km8e3xOm9waBuRbx4nW1pPN6OLm9GtNSw+zEbx0X?=
 =?us-ascii?Q?CgXixQmyKMMQ6dE0oGJ7M+g6qUO/Njn3d2ycAmxroItsaVMMnrsg6xVVv/qV?=
 =?us-ascii?Q?rbXxBwxW7rPiSGRpXmZLmThOliLjjCbGxcsA6momZIhC8GECP20dAdK7jIuG?=
 =?us-ascii?Q?jN4IJD+KMwhinDb3qdaHtpNH9MOaZPVGgGJcn3kGiHuMoZUMut4S2v9NDtmU?=
 =?us-ascii?Q?UBteQJs/BHBqaXQZLFB0EHB4KMULlFZuXqif0QfHzqyeofdi4JOOFRUA699o?=
 =?us-ascii?Q?uL5W2AxP8an1WBtBpRUyy1PKEcXlVNAfTUtMyAoIuk8ApiHsMDs0lLn0Sw1S?=
 =?us-ascii?Q?5+tOyxPcHF3O2LL1W/IdITmVPB1hDjn6y7VVrqAxOjO96CBfIoKIxR/kawOX?=
 =?us-ascii?Q?xlE68W0FSdm47B2Z82fitVtXL928MnId8+s3Wy0XBEgYpE0OEg3pV5iApZxt?=
 =?us-ascii?Q?vXenF+oUiB4gz1vKc9+wg2t+biR8MUKA3M5UtKroONEJeE6foyNkuXVPN9uw?=
 =?us-ascii?Q?X2bsrYJV9X3Z+iLQYUT6mGLYpwttdgn7sGQ1F7uzN9rLAITJOSgNbDfvpl8w?=
 =?us-ascii?Q?cVAwTXXDiPwGjcHkov+4XLbQrcckn6pYu/PBL3ALlo/1sWJ4dmSOqI06uEwF?=
 =?us-ascii?Q?yrmx9fsWHUVkbtpI/LZrvTjtiUSo+S/ZqKRa4swpZEUu4fmLD4EhKSimDUoi?=
 =?us-ascii?Q?6ObSy9tr/6FU08edhpnPbId7m1afuCyiLi0d8KnkFhl0+jRVGUzU1WYRxD33?=
 =?us-ascii?Q?6KQMwBapgUvPG3ZpmxNcxlE2GD/cRtj9KWxIKv9pa5C4aiuVZKB08CfaC/j9?=
 =?us-ascii?Q?I/q7LEzgOsqtZ9VXAb4h0cEiDaCtbanFQjdN3oq5xnxjiNXIAB13pD99YizW?=
 =?us-ascii?Q?nc4HNPVzEaAP89+yjo09CsqrpGmMTSLFAbPE9BEB/7xqPvcgl82SLlSG+1za?=
 =?us-ascii?Q?pKSV+eQ8IIiRMFceB0bH8AQE8WRADvELr9Z98f3iSzHopv5RVUdl/4swaYx4?=
 =?us-ascii?Q?QFs9tJxAbzV2avlVx8Rhrehx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0837dc0b-dfc6-4fbb-fbc1-08d8f3c28e24
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:00.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rH2Exzj5EMON0Ji56RP2Fs+VlxJR3gcSJCq9sRDbMlW/wVlB1Di27WcxhU1S4eT3+JZe9UtwUvMF54yvAdPHyAUYyor8/o5TvV0xRq7+o0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: No3OIjo6MZsQ_2HJXAsOgactNtqt76Ck
X-Proofpoint-GUID: No3OIjo6MZsQ_2HJXAsOgactNtqt76Ck
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a way for a caller external to numa to ensure memblocks in the
memblock reserved list do not cross node boundaries and have a node id
assigned to them.  This will be used by PKRAM to ensure initialization of
page structs for preserved pages can be deferred and multithreaded
efficiently.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/include/asm/numa.h |  4 ++++
 arch/x86/mm/numa.c          | 32 ++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0d..632b5b6d8cb3 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -41,6 +41,7 @@ static inline void set_apicid_to_node(int apicid, s16 node)
 }
 
 extern int numa_cpu_node(int cpu);
+extern void __init numa_isolate_memblocks(void);
 
 #else	/* CONFIG_NUMA */
 static inline void set_apicid_to_node(int apicid, s16 node)
@@ -51,6 +52,9 @@ static inline int numa_cpu_node(int cpu)
 {
 	return NUMA_NO_NODE;
 }
+static inline void numa_isolate_memblocks(void)
+{
+}
 #endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 5eb4dc2b97da..dd85098f9d72 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -473,6 +473,25 @@ static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
 	return true;
 }
 
+void __init numa_isolate_memblocks(void)
+{
+	int i;
+
+	/*
+	 * Iterate over all memory known to the x86 architecture,
+	 * and use those ranges to set the nid in memblock.reserved.
+	 * This will split up the memblock regions along node
+	 * boundaries and will set the node IDs as well.
+	 */
+	for (i = 0; i < numa_meminfo.nr_blks; i++) {
+		struct numa_memblk *mb = numa_meminfo.blk + i;
+		int ret;
+
+		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
+		WARN_ON_ONCE(ret);
+	}
+}
+
 /*
  * Mark all currently memblock-reserved physical memory (which covers the
  * kernel's own memory ranges) as hot-unswappable.
@@ -491,19 +510,8 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	 * used by the kernel, but those regions are not split up
 	 * along node boundaries yet, and don't necessarily have their
 	 * node ID set yet either.
-	 *
-	 * So iterate over all memory known to the x86 architecture,
-	 * and use those ranges to set the nid in memblock.reserved.
-	 * This will split up the memblock regions along node
-	 * boundaries and will set the node IDs as well.
 	 */
-	for (i = 0; i < numa_meminfo.nr_blks; i++) {
-		struct numa_memblk *mb = numa_meminfo.blk + i;
-		int ret;
-
-		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
-		WARN_ON_ONCE(ret);
-	}
+	numa_isolate_memblocks();
 
 	/*
 	 * Now go over all reserved memblock regions, to construct a
-- 
1.8.3.1


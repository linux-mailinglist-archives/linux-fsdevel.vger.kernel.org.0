Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8036E4A02C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 22:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351437AbiA1Vcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 16:32:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31424 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351334AbiA1Vcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:32:42 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SK3sbF028584;
        Fri, 28 Jan 2022 21:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Tenm3Cr/HWLEXvF1vxqr+qnt0+OskmnhIiwTMO1NGDM=;
 b=IlVxUoS+0RAUVqvl7jlXLvZ/rvrg0bhU4wFZAg6kFiHo8W/lpqivr1F5FJSCDCwDLN5L
 qxnSa5q8nWK0Lde8cujMnryfSrF+e6viPz1r4jr6IrIG0J9Ud21yW73cjHhlPgVxgewS
 Sh9Pxsy6UF64fX1XZPhoL1rrEjCXXYd03/2l+LvZzAWrkW6CxYKuRp0fgbtoDWoKONPU
 vdx03Dj1U6ZipTprMwo0hW1UimVSYtyntltdYez3Vyk2X6UdeUiFWuHaPiGX4rbajmDG
 S6KshOt2miCvw51Ah51bJWJ2oosCESuQcEXtbkBCKbcc8e5F7ASzubT+PUXjC3hWQmfZ og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwrxmhm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SLR9Kl184419;
        Fri, 28 Jan 2022 21:32:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3030.oracle.com with ESMTP id 3dr726n00c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQv1rXi8Tm7dAdRJ5l+VqZwK9/T0c2kY4J5JLJYjzktuh5ewPTO90w8QYL+4vRAjvTlfFtvbqOo6lfr9inMj+O6t28Fas5v+puGWSWlqkK41vTD6GibOPdbPIfYMbb8ZsM/1xhXS41kTZwj+aiEayg25iqWUMkm+ePpQ48IpylSnb/xEtVEvkniXd/ViH3NFtYC8xlWubRwfU8RalX+vUE7f1nBDwjZNziuWuJsnE2Lpy0rfN8yZnaqcWkQtfncEZNfTfVj/OJxg48Lzz3USsSxcDG5RpaQFvDAQ01cnrN9wjQwKq/jms9EnW4oCLubhXJ+RrNPY5zoIRrVoDLdahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tenm3Cr/HWLEXvF1vxqr+qnt0+OskmnhIiwTMO1NGDM=;
 b=MKOwiYbAzHAWgw8wzyzQQi4kx+sZYjYV+1PIycEn5rNOzz9P13nSpMMrwPivPBHyx5YAZYHH+3SaerPk9uRDKIGWf7LOWp6TV+3enej/B9/Z1gbY67RRUpuvml/zm9QfnHr8L3/P0MhCr/pLgqY47weVj2aG8ekRrM8tl3YfxdMVytdveJ6zV7gNOiy9xMzK7+A32PO4Ly8yixB1LH76JreZYD7sFEwBKz6wnhiZPqlWqxnrjNOwJMv1QF2JuuRfp2BAKvWgmyT/QjsAlMO6ZzRkMEliSatS86JJQJA6HVVVH31+RusBtFe/GjEC+mWgz6JuXmpbxLUmPK4RO+wEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tenm3Cr/HWLEXvF1vxqr+qnt0+OskmnhIiwTMO1NGDM=;
 b=a62GfRfTKqr6BtQsjIslMH7N7YSnCiPIalIEDonKP2FQRepVRLrD+g12hVnlQqfpVXeKVIpmDBSsLw7vXlwRatG4UrmEK6qyOAZOm2dL2PDbDQXdO7PFwu29AVLSmg51xxHBC1bUXpB8G84rWK4A9VKH5oDVCVwqfLAsitqJUrI=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 21:32:30 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 21:32:30 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v5 5/7] pmem: add pmem_recovery_write() dax op
Date:   Fri, 28 Jan 2022 14:31:48 -0700
Message-Id: <20220128213150.1333552-6-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220128213150.1333552-1-jane.chu@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:806:121::16) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 021d91db-8d9f-430a-aebc-08d9e2a5aff2
X-MS-TrafficTypeDiagnostic: DS7PR10MB5022:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5022A514A0CDD4E35FDFB2F8F3229@DS7PR10MB5022.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrRKMZdDtVdCRC0Ltz1JX46KKxWIIDoBj+4b9fCyC6npLlvRJ3w6vBQh1HNZI1GJkUEuNdpHxmS1IcQGyYRP5AgXxXmhBvWOdsQPy1QpU2SIbznCjwou6xpQkYrJrQ/exDCCykgJ/jCqtRHYurEQthighAmOH0YJ7qI/DVmTmPWQcsU5TNMFHE1Cojla90ft0BjPAaFqbFE68/aAeMjEKXsacTHMKUJdvnayRZ8dl5lxWzY6W0pG8wbk2MA1NjuhhGgM2GlfGyAE3z/P49DjxdbT6nd+zgojxIKWyHjRHGFxDvqQOIZrNYi1LdXsGatXH/COr5hosNm6eXsNsrWqrFyxZwSNLkzPrpl/QsACOrdTpTPPrnkpsYAzeq4+QuBS7z0C0gxoAdQ3IYrnCDveqw4MJyxgDxvzXnizQXX7/7ZJawYd6hgdTS9TlQdX+37IBSZcOag7dd4X72VAKfUP1HfU994ty4GUTX8LsVUBro1ocY5BnUEDrj127HgBpjSI31y+4I76h8MImDqISNxJilmvihGxYOZmbLAZhRPz3Ts7RumqaRqnffQNutooxm5Me9VO9geoLZwArVsniCWYDaw0EEKXR5Blqce6O1nF32QouwCvwz+2UnaPTGs4XO8CKiQPkxCEX0uwhgbzM1q/37fr2xa/q9TxHyZelBNdUhdZaxkL+tDWXFQRkEBfgTeOCPRgM9GvZppTg4nkyfABWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(6666004)(83380400001)(2906002)(8936002)(52116002)(66946007)(508600001)(66556008)(66476007)(36756003)(86362001)(6486002)(316002)(186003)(1076003)(2616005)(7416002)(38100700002)(921005)(5660300002)(44832011)(8676002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dn9JKSuYRCoR534ZVZE2ZNC2DxHSuqE/qCKJCUhCg4DB5W0x6sB35XIaCdGu?=
 =?us-ascii?Q?6AVEcu3+VjagJ9eWq63M1PiM5z0oeg25znfKg/8F/Xkkq56Ngs/kN4oFnDt5?=
 =?us-ascii?Q?LBjOpgti+oCNmCKORe8lJmi9okM4N5acsnxRvllNF8V2m9xrKFXxok/tEATj?=
 =?us-ascii?Q?uYaKWmVYHDK4nG0XcPLT+/Ly5IZDwqt38lju+zGIsUBedaYWzH+FEO3kMbEz?=
 =?us-ascii?Q?tkH7RB5bCaid6ketieaO7tnwVcDTDPspdr0Et6LjenfHWP2N7MfWP5+XE7CM?=
 =?us-ascii?Q?vO7xTYsY72va6z/jtpERwNMub/Ion3lDSDn4C67eGpNt70BpqVaV3DN+v/3C?=
 =?us-ascii?Q?cX35l8S04Jyde2tocqmcw+cqwHlti8fhoeR1IurRaHqGi/TyqK/IFWCXoLyB?=
 =?us-ascii?Q?Fm9As7wsuWik6/0CIwbjo8U66W5M8tX24Aj7bS+riiYfwIJL0iMnukPx7Ssn?=
 =?us-ascii?Q?ru8fL6OiA9MRgnnvWop3OT9BuRuaEKxz7pbRVC9BdYo9xlqNvGWIG8YVcAB2?=
 =?us-ascii?Q?wnWPewa/cWROqSBmdrCTMsf00ihHqBeebLibjKYBRGEO3DEudx4tmVyVoK4E?=
 =?us-ascii?Q?Y3CeAz+oh5HMwaQpIo3g+gqNj7knPMAwp/sd24hgLdsEsRqrJItdC5oKIQ8o?=
 =?us-ascii?Q?mBHsLslNGW+Bx5+teouFuQ70PnkDrrRjW3TqkSWjA7f+1oKjBAqUbQ6UZXOV?=
 =?us-ascii?Q?ycs8nFkhXDg0YSL4ihux/LU8fhggiu9P+mG8KgjulAW4dlZ8I2pHUypbfvMj?=
 =?us-ascii?Q?K7VYhYOxAkss7Dbw45iRr7ADfbA/zpgvkOUV0HbYUxXBpvrH1EyMTCjhUYi4?=
 =?us-ascii?Q?ReCy8LNiEDOpSHGvr/3Ig8FmzKJsMgHTefR1yCcCRQ0O+W1akZAgwtsdHJEj?=
 =?us-ascii?Q?Z4yE2uKZe2EwdckSl8ZAEYrGKgQA0xjXfG6DDCWhOM3BvwW6DqynGhsajRJV?=
 =?us-ascii?Q?hUFCsikuwoTBKTx+7zm20ANWVAq3lhEMBcuVbCzP55vQGtkVoEA5DFh83vU9?=
 =?us-ascii?Q?oPmaK67WBDBKGGCYbl/usPu836YRmohDpSTaH6WzeTr0nm2EhOc16NURJT6O?=
 =?us-ascii?Q?IVXyNFyTPcnmErFkY+/qwDohlaRbGkmFwCMpnt0L7UA3SN/IonJg7CfLSDb2?=
 =?us-ascii?Q?lfWFqwYS9g9cWEV3Auadk9gnGKYg0CQosaUaqVymtdSxM7n0+Q8zSNHsIgqW?=
 =?us-ascii?Q?fuQ+boLP+/Ie1Gb+nxulc0uJaUwYMXVOt5yZVFTX2jEfJMse3Hkq66oNGcrc?=
 =?us-ascii?Q?Mgf3E0SnMa4SawNQ/CXD5wjNuYiw5sR/CeuYWbe95264kN9n4GOqebMVNodE?=
 =?us-ascii?Q?0GcL2xzwMcvPabmlS5qYZioXcBmG6Hqa1SEJYaMjIyd7wUZI4uZvbf4FRpxL?=
 =?us-ascii?Q?ccvM8IItGoXwkcxGDa2S8ewhLMJcxmpYse+vxNNvBSTZqvP6xCncJM3t8bbE?=
 =?us-ascii?Q?sl5nxDYJyaMCVAGvDX1E3hXmeoi4Xyg5YuBeYUfS1j3+cU94azEyj06FqT+j?=
 =?us-ascii?Q?mvMVBloHXAWadgweqn3bkQT2PDiExfRDPD7Py6Hkz65OYF49sA370O4+xdTK?=
 =?us-ascii?Q?X5pgb+aTs4ZkJGiL5gpeuoZHFSNP71wfhmUNoZ3vsAUcnqiZ5WD0Ezpz1Olq?=
 =?us-ascii?Q?zJCj6MR45NzXAQniWzgQHcwrAIh3TXhRyg1pSp1m26OA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021d91db-8d9f-430a-aebc-08d9e2a5aff2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 21:32:30.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6tAy222+JoMXuaPOJyz2BmpA5ReQ8T5iRBtuZrg+SOYD2Py/6g+Db5078wxY3xWl43Q+rsJla3cXjm1qFCCeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280122
X-Proofpoint-GUID: pfHzixXDIkZRc-QPo8hc2oFoRLFGwbHJ
X-Proofpoint-ORIG-GUID: pfHzixXDIkZRc-QPo8hc2oFoRLFGwbHJ
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pmem_recovery_write() consists of clearing poison via DSM,
clearing page HWPoison bit, re-state _PAGE_PRESENT bit,
cacheflush, write, and finally clearing bad-block record.

A competing pread thread is held off during recovery write
by the presence of bad-block record. A competing recovery_write
thread is serialized by a lock.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 82 +++++++++++++++++++++++++++++++++++++++----
 drivers/nvdimm/pmem.h |  1 +
 2 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 638e64681db9..f2d6b34d48de 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -69,6 +69,14 @@ static void hwpoison_clear(struct pmem_device *pmem,
 	}
 }
 
+static void pmem_clear_badblocks(struct pmem_device *pmem, sector_t sector,
+				long cleared_blks)
+{
+	badblocks_clear(&pmem->bb, sector, cleared_blks);
+	if (pmem->bb_state)
+		sysfs_notify_dirent(pmem->bb_state);
+}
+
 static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 		phys_addr_t offset, unsigned int len)
 {
@@ -88,9 +96,7 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 		dev_dbg(dev, "%#llx clear %ld sector%s\n",
 				(unsigned long long) sector, cleared,
 				cleared > 1 ? "s" : "");
-		badblocks_clear(&pmem->bb, sector, cleared);
-		if (pmem->bb_state)
-			sysfs_notify_dirent(pmem->bb_state);
+		pmem_clear_badblocks(pmem, sector, cleared);
 	}
 
 	arch_invalidate_pmem(pmem->virt_addr + offset, len);
@@ -257,10 +263,15 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
 {
+	bool bad_pmem;
+	bool do_recovery = false;
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
-	if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
-					PFN_PHYS(nr_pages))))
+	bad_pmem = is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
+				PFN_PHYS(nr_pages));
+	if (bad_pmem && kaddr)
+		do_recovery = dax_recovery_started(pmem->dax_dev, kaddr);
+	if (bad_pmem && !do_recovery)
 		return -EIO;
 
 	if (kaddr)
@@ -301,10 +312,68 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
 }
 
+/*
+ * The recovery write thread started out as a normal pwrite thread and
+ * when the filesystem was told about potential media error in the
+ * range, filesystem turns the normal pwrite to a dax_recovery_write.
+ *
+ * The recovery write consists of clearing poison via DSM, clearing page
+ * HWPoison bit, reenable page-wide read-write permission, flush the
+ * caches and finally write.  A competing pread thread needs to be held
+ * off during the recovery process since data read back might not be valid.
+ * And that's achieved by placing the badblock records clearing after
+ * the completion of the recovery write.
+ *
+ * Any competing recovery write thread needs to be serialized, and this is
+ * done via pmem device level lock .recovery_lock.
+ */
 static size_t pmem_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	return 0;
+	size_t rc, len, off;
+	phys_addr_t pmem_off;
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+	struct device *dev = pmem->bb.dev;
+	sector_t sector;
+	long cleared, cleared_blk;
+
+	mutex_lock(&pmem->recovery_lock);
+
+	/* If no poison found in the range, go ahead with write */
+	off = (unsigned long)addr & ~PAGE_MASK;
+	len = PFN_PHYS(PFN_UP(off + bytes));
+	if (!is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512, len)) {
+		rc = _copy_from_iter_flushcache(addr, bytes, i);
+		goto write_done;
+	}
+
+	/* Not page-aligned range cannot be recovered */
+	if (off || !(PAGE_ALIGNED(bytes))) {
+		dev_warn(dev, "Found poison, but addr(%p) or bytes(%#lx) not page aligned\n",
+			addr, bytes);
+		rc = (size_t) -EIO;
+		goto write_done;
+	}
+
+	pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
+	sector = (pmem_off - pmem->data_offset) / 512;
+	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + pmem_off, len);
+	cleared_blk = cleared / 512;
+	if (cleared_blk > 0) {
+		hwpoison_clear(pmem, pmem->phys_addr + pmem_off, cleared);
+	} else {
+		dev_warn(dev, "pmem_recovery_write: cleared_blk: %ld\n",
+			cleared_blk);
+		rc = (size_t) -EIO;
+		goto write_done;
+	}
+	arch_invalidate_pmem(pmem->virt_addr + pmem_off, bytes);
+	rc = _copy_from_iter_flushcache(addr, bytes, i);
+	pmem_clear_badblocks(pmem, sector, cleared_blk);
+
+write_done:
+	mutex_unlock(&pmem->recovery_lock);
+	return rc;
 }
 
 static const struct dax_operations pmem_dax_ops = {
@@ -495,6 +564,7 @@ static int pmem_attach_disk(struct device *dev,
 		goto out_cleanup_dax;
 	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
 	set_dax_recovery(dax_dev);
+	mutex_init(&pmem->recovery_lock);
 	pmem->dax_dev = dax_dev;
 
 	rc = device_add_disk(dev, disk, pmem_attribute_groups);
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 59cfe13ea8a8..971bff7552d6 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -24,6 +24,7 @@ struct pmem_device {
 	struct dax_device	*dax_dev;
 	struct gendisk		*disk;
 	struct dev_pagemap	pgmap;
+	struct mutex		recovery_lock;
 };
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-- 
2.18.4


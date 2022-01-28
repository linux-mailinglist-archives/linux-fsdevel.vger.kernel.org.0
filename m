Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DDD4A02C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 22:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351533AbiA1Vc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 16:32:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38010 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351409AbiA1Vcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:32:46 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SK400L004896;
        Fri, 28 Jan 2022 21:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZJT6fQ4VAi0pfbDSZoiY3HULZbw7hCfF5pcYH5wYyhY=;
 b=0KnI2O0SECai7DbkgNSk/8cABl0oHHGPDF97rgbsrRjUzt0ik4DEiV8l5/RjsAMTynAt
 LfKffDB7oTeTj0G001BE194pqMG7bSmPRWJG5qAn6A2YD7cLAhIBmqC5g+f98Cy44hym
 kSOCs4qgST6RshP0V+H3y9YRthkbnTb7dBbsPK9YLfnpjNr4Udfs+2Nfw3LE1uTQPZB3
 CwurVzZRUEX7QDgJctcjZYUHAQNH+pRruHNHHF/VqxIMIMktiMfGjOl/LguP1yAUBBxQ
 ZLuOyahS8p0PH33Ubrl5MZOGpy8cUmPE2pksIHea1cAoONfuDMuhKbXFPB/vwshZ8Qth tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnkcm8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SLQv3h134958;
        Fri, 28 Jan 2022 21:32:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3dtaxd6uvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYZv8yyyD1xQkBaVKKiK1FrMW942uUO+lXr8Y3wyLrXAK+cW2y3gE9U0rVzeVteCxg+x059s4iZH7C+cFbpLUs0PehedmVKgklrqPktD9saGnimD/7oTms2E4LfF6qznZRNJ6BPIsVdPFZWIVzfqxivvjcisyasY9AnKEF7da3f9kVPRzhbxNKNFotYBV4ZVgmUbXIVBF5wscO5Kwe4c0MCXzuxrGZ+YBbX+KvcX5egKm7HMd2HcqVZlp38+sZB6expmhWghfDpnjh53fQv01A4XO8F+/iVCGaHOa21d5INm81mJK6YDJhH/Su9O0Puuzh5ZgSuS0CElNYec+glYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJT6fQ4VAi0pfbDSZoiY3HULZbw7hCfF5pcYH5wYyhY=;
 b=SCTX9sGslHoMs9nTkeqlm2vPS5UFliaCD6eog7VeC7c1Wss3PsOpp/rLtfN5SAPAmzbKj7cIH8gl0DY7zjiSuHqyUASPUZDNHfMpW/COUuwEH7oafoJDdltiR8UbHMJsYoD9BXMJaFJ55Ni8j2p/T/g+5CINSnQeqBhpLjKHq7DSc7W7tXyfZBa4yBU60jgKmnTtYyHpc9YHyQYHyxn0OJX2q9oc447xFlbE3u5CmeBDiKpElNHUMnkUDA/yUeRdUkf0eYaXSU0lgWF2FJU+QrxkG84vM2RVpgc8lPOPNjhi8TZuozVmiFcRldCRD570KicbjcxzQt5aHg7k3jKVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJT6fQ4VAi0pfbDSZoiY3HULZbw7hCfF5pcYH5wYyhY=;
 b=C6516n2lvBCvTjW1oTAr/rA5slhSEbgyjM8iV72cFDAEVs64H7LJf23iH/f4nEKGBUuEOH/ayxNJ2O7HJ841TOx3nh/cgEC7TI1wlltTWqEHMZC/qFnSS3Ebl5L92QpSFJsIN9Dk4q+UhltOrScmNfb+akXCgAvWz788WogCbKg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 21:32:27 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 21:32:27 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v5 4/7] dax: add dax_recovery_write to dax_op and dm target type
Date:   Fri, 28 Jan 2022 14:31:47 -0700
Message-Id: <20220128213150.1333552-5-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220128213150.1333552-1-jane.chu@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:806:121::16) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe1fce86-950a-4fe1-a2d4-08d9e2a5ae61
X-MS-TrafficTypeDiagnostic: DS7PR10MB5022:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5022B1AC049BB5A7A38949D7F3229@DS7PR10MB5022.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PK96djq+rcDihCPOkNuvhspW1mF4JAdOedUFUI9WZMQ/waLSI1CSAaR6nl7XyXqdpu2lXg2romUouNXa5f/ynXXHOye6FJ2RIHwbtJbjru4ySnKMx67onyDIicPaZDsheNvjxk3Rg/6+7y0s+9sCdvJFQXBplcaqKV1sVOHiEYq8BoeyT7SYxhJDiFiyW+sXvniDRSMUNieIAzeR8NX3ddF//zAagRYeo44WvraU3bR/oGcjcmTSmE5zW52E28wuuQ8drEjnKT+FvoW75Qt0ua3kCs882lBKiw1E+dt5VJaORPQq8jWSXe70JwURvVNtOKDUkFHIyDaZprA5xFeGRlv97JOjFmHqeUlx91yl5FJkjmK7FfKrJbThatBa24xfqIeCWe0hphRVQnerd/QcwZwl3VubyO2+A2mP4gFyPrUJ5t4aScZ31+AwjIG2OHP0+4WIJ5ct/r3dycvbTItGIsNUVDS3AkNssaogAUiLfrxV58Gs3iG1VX5HTDRNjl+Kp7auiGGKfHtG9VL652db6MsB0NVQuI4fJMBURVRelwd6O6rMIIp2zLuVI4lwADpkc23MGyS+oaNouzQzIvEppHl2olxeXB7OJZheOOyKpeUa0yJulTuHRuRHcbptehNmfRWyzZk5ACMhFHBoMhQKbAI8NiIQZHZrntpEal+m+JPS1eQfU0XtGvojkG0aJeW/X6nff+3mtYzuPwI2/LcDfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(6666004)(83380400001)(2906002)(8936002)(52116002)(66946007)(508600001)(66556008)(66476007)(36756003)(86362001)(6486002)(316002)(186003)(1076003)(2616005)(7416002)(38100700002)(921005)(5660300002)(44832011)(8676002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0UZKwt7FFeJCwqgFGvwu8CH+xKKa8MCGu7c4nTKYxq3pWGv1QVBMh4yfMMUk?=
 =?us-ascii?Q?b7z/LPrr2htBOQpTrIlNlSIE8DncALSYRVfLvCI595pffmpUtOjrNnWVdKIW?=
 =?us-ascii?Q?Znj12Z8qvBOy9ps65Yop6mEZQWIKl+F3olWU7V4bSIHH87Av4kqfLiIxtn6A?=
 =?us-ascii?Q?PUmarIw4UVwGmApMMrIYnm98EVYApJP2hORDnEL62jMAw4T7OZIUwGwzQ5qk?=
 =?us-ascii?Q?Nd0ExL/SptR2s0ttgSDG0ossMiYh2z9wM5dYwP1+0vIplIMG+liWP8pfWSPk?=
 =?us-ascii?Q?nQ7oxCevcBrLANZ66M3u7UouhI1j3uzJIfjK9LvDI/P22GySDPu7tZHc3X0B?=
 =?us-ascii?Q?lUdSz1AQprE1IeHtcl2uRVHRhfrCHjiMun7dO3qKOQf6XVHWoMXkICRTPHwX?=
 =?us-ascii?Q?zqK7Tmsp0/xz2M0oQOI3yEbuI6GouOABan+y2yaNZayZQo3tBjMroEqKuWQa?=
 =?us-ascii?Q?BCJO7bvnAAlumOdqbObINzjGq6N9WTvtOmtdf3oCmGRAbm4ylaYPJfyJuse+?=
 =?us-ascii?Q?jD1m2jK99BmbEHP3sekM02DCvUymFRP22euCUHQDJxs6kJmOkJwQAJuXqkgK?=
 =?us-ascii?Q?z5y++2WDHv5wjD35ylqafMKsZ7vPBPlw4VqHIkXlvCIZQcE/oCp2oO9M678+?=
 =?us-ascii?Q?udXXlMv7i16zOutTMAHZAusbtwX3JxArd6L+6LehwRnnvmfuvjyTqgebGtUq?=
 =?us-ascii?Q?KZId8mly9XF01MK/yFnV6AhT0gfOOFy7JoYyv50SaYSSch/U3W3c9h/A2xZ1?=
 =?us-ascii?Q?XnJqQy0ehQGM49p6kk8c95CYXgSwzphlXECOTqd2uLpzFgIIS1m4HoDVUrmt?=
 =?us-ascii?Q?XJnRHr804aePQW1ohyXtdlniNc+0ZURM2PsiQ15CoSqcdIdSM0rEeWIMpCjT?=
 =?us-ascii?Q?WhNZM6uVs9aP909ybBvZy30zZeSeVbxKiwh2C28eKSE/ekncyECmcjlOt/pa?=
 =?us-ascii?Q?MTqzcrhV8HKksb2ADK7htPQBvJJfo+VkchZHjIsEfk4cEBrnO3or46nNWr5r?=
 =?us-ascii?Q?qKWFgSkD706J+w3a53Dmq4O+PQdgKMPVJKdGdKrC9ZWCLNXBWhUrGTv/eyRg?=
 =?us-ascii?Q?PH9ZJYaTTkUjoZHXu4uLcVELv4gCKENwNxlhpKqhr4hXyVSz3FftYdHhBvTl?=
 =?us-ascii?Q?AuYJEt+UNBHd1jDpYk5VOSUOb0P57DbYlVOIW1g5euCFoDsBiEY7mvfR4Sfh?=
 =?us-ascii?Q?oFU5E4lopQy/iO4WiJfqDaYx3mzmpNu/6h3QO+myToIBuHhxwpTliqppqFZM?=
 =?us-ascii?Q?at5kjUT/lNNS2Uri35ySJ1MjhRGNBwKCrMf1xrHZ9r6+KNizGPPhdfTyAzQI?=
 =?us-ascii?Q?z7GA8K5tqkvUOjZPtvE9QOQUFxa3FLT0/abhG22fipJy3lGielSdo8PNDI2u?=
 =?us-ascii?Q?8BI/rQN5bG0vSJ0xyrYuE6yqYyNzKTGPLmmw1J2oQZ7rJEiexX8n1khIUhi4?=
 =?us-ascii?Q?EQvr6yb0vMCzC+PLrkdfbmBQL5XFNeCN7RivoJANcQi7NWw27Vcfxj500gO7?=
 =?us-ascii?Q?fPJdm0cVKARFWxOUrHXKphmVwDq5Ye3X+p02OvaiajXTbSW7srFU8SGePy8g?=
 =?us-ascii?Q?EF6hcOPsjGgk8vA4ciQO8xBqH0AjOWxCfmvfNG7BLQeUyvgY2fbRYQRJGvA3?=
 =?us-ascii?Q?7EYhwdkfzgUrGGeptdaqVzSymEztoLZTMBqZE/r+RBVm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1fce86-950a-4fe1-a2d4-08d9e2a5ae61
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 21:32:27.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AI8qKuhZ9p07PVbnioYHhfvgwzzQx4xTRDIwt7RbHhi/UNc7FDpNpM3RiWVwDGmYCc66XN6l3ocF968FuQ8QsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280122
X-Proofpoint-GUID: VmCf48OGqgyb8L_4Ll2DzdWghemN1nFE
X-Proofpoint-ORIG-GUID: VmCf48OGqgyb8L_4Ll2DzdWghemN1nFE
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dax_recovery_write() dax op is only required for DAX device that
export DAXDEV_RECOVERY indicating its capability to recover from
poisons.

DM may be nested, if part of the base dax devices forming a DM
device support dax recovery, the DM device is marked with such
capability.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c           | 17 +++++++++++++++++
 drivers/md/dm-linear.c        | 12 ++++++++++++
 drivers/md/dm-log-writes.c    | 12 ++++++++++++
 drivers/md/dm-stripe.c        | 13 +++++++++++++
 drivers/md/dm.c               | 27 +++++++++++++++++++++++++++
 drivers/nvdimm/pmem.c         |  7 +++++++
 include/linux/dax.h           | 16 ++++++++++++++++
 include/linux/device-mapper.h |  9 +++++++++
 8 files changed, 113 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index f4f607d9698b..a136fa6b3e36 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -195,6 +195,23 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+			void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (!dax_recovery_capable(dax_dev) || !dax_dev->ops->recovery_write)
+		return (size_t)-EOPNOTSUPP;
+	return dax_dev->ops->recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_write);
+
+bool dax_recovery_started(struct dax_device *dax_dev, void **kaddr)
+{
+	if (!kaddr || !dax_recovery_capable(dax_dev))
+		return false;
+	return test_bit(DAXDEV_RECOVERY, (unsigned long *)kaddr);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_started);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 1b97a11d7151..831c565bf024 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -188,9 +188,20 @@ static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
+static size_t linear_dax_recovery_write(struct dm_target *ti, pgoff_t pgoff,
+	void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
+
+	if (!dax_recovery_capable(dax_dev))
+		return (size_t) -EOPNOTSUPP;
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+};
+
 #else
 #define linear_dax_direct_access NULL
 #define linear_dax_zero_page_range NULL
+#define	linear_dax_recovery_write NULL
 #endif
 
 static struct target_type linear_target = {
@@ -208,6 +219,7 @@ static struct target_type linear_target = {
 	.iterate_devices = linear_iterate_devices,
 	.direct_access = linear_dax_direct_access,
 	.dax_zero_page_range = linear_dax_zero_page_range,
+	.dax_recovery_write = linear_dax_recovery_write,
 };
 
 int __init dm_linear_init(void)
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 139b09b06eda..22c2d64ef963 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -927,9 +927,20 @@ static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages << PAGE_SHIFT);
 }
 
+static size_t log_writes_dax_recovery_write(struct dm_target *ti,
+	pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
+
+	if (!dax_recovery_capable(dax_dev))
+		return (size_t) -EOPNOTSUPP;
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define log_writes_dax_direct_access NULL
 #define log_writes_dax_zero_page_range NULL
+#define	log_writes_dax_recovery_write NULL
 #endif
 
 static struct target_type log_writes_target = {
@@ -947,6 +958,7 @@ static struct target_type log_writes_target = {
 	.io_hints = log_writes_io_hints,
 	.direct_access = log_writes_dax_direct_access,
 	.dax_zero_page_range = log_writes_dax_zero_page_range,
+	.dax_recovery_write = log_writes_dax_recovery_write,
 };
 
 static int __init dm_log_writes_init(void)
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index e566115ec0bb..78c52c8865ef 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -332,9 +332,21 @@ static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
+static size_t stripe_dax_recovery_write(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
+
+	if (!dax_recovery_capable(dax_dev))
+		return (size_t) -EOPNOTSUPP;
+
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define stripe_dax_direct_access NULL
 #define stripe_dax_zero_page_range NULL
+#define	stripe_dax_recovery_write NULL
 #endif
 
 /*
@@ -471,6 +483,7 @@ static struct target_type stripe_target = {
 	.io_hints = stripe_io_hints,
 	.direct_access = stripe_dax_direct_access,
 	.dax_zero_page_range = stripe_dax_zero_page_range,
+	.dax_recovery_write = stripe_dax_recovery_write,
 };
 
 int __init dm_stripe_init(void)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c0ae8087c602..bdc142258ace 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1054,6 +1054,32 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 	return ret;
 }
 
+static size_t dm_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct mapped_device *md = dax_get_private(dax_dev);
+	sector_t sector = pgoff * PAGE_SECTORS;
+	struct dm_target *ti;
+	long ret = 0;
+	int srcu_idx;
+
+	ti = dm_dax_get_live_target(md, sector, &srcu_idx);
+
+	if (!ti)
+		goto out;
+
+	if (!ti->type->dax_recovery_write) {
+		ret = (size_t)-EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = ti->type->dax_recovery_write(ti, pgoff, addr, bytes, i);
+out:
+	dm_put_live_table(md, srcu_idx);
+
+	return ret;
+}
+
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  It is
  * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_* zone management
@@ -2980,6 +3006,7 @@ static const struct block_device_operations dm_rq_blk_dops = {
 static const struct dax_operations dm_dax_ops = {
 	.direct_access = dm_dax_direct_access,
 	.zero_page_range = dm_dax_zero_page_range,
+	.recovery_write = dm_dax_recovery_write,
 };
 
 /*
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index e8823813a8df..638e64681db9 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -301,9 +301,16 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
 }
 
+static size_t pmem_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	return 0;
+}
+
 static const struct dax_operations pmem_dax_ops = {
 	.direct_access = pmem_dax_direct_access,
 	.zero_page_range = pmem_dax_zero_page_range,
+	.recovery_write = pmem_recovery_write,
 };
 
 static ssize_t write_cache_show(struct device *dev,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 2fc776653c6e..1b3d6ebf3e49 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -30,6 +30,9 @@ struct dax_operations {
 			sector_t, sector_t);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
+	/* recovery_write: optional operation. */
+	size_t (*recovery_write)(struct dax_device *, pgoff_t, void *, size_t,
+				struct iov_iter *);
 };
 
 #if IS_ENABLED(CONFIG_DAX)
@@ -43,6 +46,9 @@ void set_dax_synchronous(struct dax_device *dax_dev);
 void set_dax_recovery(struct dax_device *dax_dev);
 bool dax_recovery_capable(struct dax_device *dax_dev);
 int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr);
+bool dax_recovery_started(struct dax_device *dax_dev, void **kaddr);
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
+		size_t bytes, struct iov_iter *i);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
@@ -101,6 +107,16 @@ static inline int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr)
 {
 	return -EINVAL;
 }
+static inline bool dax_recovery_started(struct dax_device *dax_dev,
+			void **kaddr)
+{
+	return false;
+}
+static inline size_t dax_recovery_write(struct dax_device *dax_dev,
+		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
+{
+	return 0;
+}
 #endif
 
 void set_dax_nocache(struct dax_device *dax_dev);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index b26fecf6c8e8..4f134ba63d3c 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -150,6 +150,14 @@ typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
+/*
+ * Returns:
+ *   != 0 : number of bytes transferred, or size_t casted negative error code
+ *   0    : failure
+ */
+typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i);
+
 void dm_error(const char *message);
 
 struct dm_dev {
@@ -199,6 +207,7 @@ struct target_type {
 	dm_io_hints_fn io_hints;
 	dm_dax_direct_access_fn direct_access;
 	dm_dax_zero_page_range_fn dax_zero_page_range;
+	dm_dax_recovery_write_fn dax_recovery_write;
 
 	/* For internal device-mapper use. */
 	struct list_head list;
-- 
2.18.4


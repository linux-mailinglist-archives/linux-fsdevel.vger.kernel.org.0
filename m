Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB54A02CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 22:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351558AbiA1VdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 16:33:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38236 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351354AbiA1Vcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:32:46 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SK3xK2005724;
        Fri, 28 Jan 2022 21:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YNdmcW56aleJoC16aj/By1K5R67/T3TMnT3Wjs2Vhpc=;
 b=JQjLNKe/MeuXEMmdmI7XbzuMB3oDnownzsySReyUa/n1suxlVy2NrspwxSFj9ClYTxsF
 77R9fhBH/3l1Zt2g+DsfRVmCU6su6b4/z6GZPSVD+s+l5CTkJOGQ1AMC+GkLWt1dxCxD
 ERQX4+GT9rUT8Cfpf5JVRQCsaVnBaDoArkifdcmH2YkgKudeRwuFCN+ecZhH+UQvVNdZ
 UJuVTG4x3e6nPzFJYW7UADKNuj3ooBYhHRTotQBWp0w6mcrTxnA9OWXSdKz861bH6e4g
 Rn8Lq2UfCyVPjxhPshc1l2nE9nNeJAJbIaSar+d2Wymusgp5TJ4/iuh6uIGEbqyalgMb Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwub4cvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SLRAqG184491;
        Fri, 28 Jan 2022 21:32:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 3dr726n024-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 21:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz/rEBVYNeVeVqdkFJSRmaCxneBdAG9ZtgqeHbcwRvBLgnRc098ezZ1Xoj+SRN7utfijAZcpELocPxDTtMmWm2W1FFdaxuB+ZFaQYi/cGGytl4aL5vOq3/k0AO3M+0kyTpIf/NAW2weHNNGTOi1nWMstpS7PGw3Fg3H8VGrtx35DNnRRoeYk82GjpwQjlKVyN3cVKllnGIhLtUbXvx51rmyjQKPlmbPufaZuQo2xVQkrgcyXi5xkvb26MILKo+iOqaC855selMpayTYjvQwrJVR2w5e3FlkJu0pXNvEyWzWkbwA3a7aK6V67MiLjmThgje8ngN5OeMW9RhehcVby0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNdmcW56aleJoC16aj/By1K5R67/T3TMnT3Wjs2Vhpc=;
 b=CKO4oPXyS9VtwiyXlVxGYYOMc1tM+yN49z8fHIONuEtdBJ3GEpG616/vRXTBbVr8LhcORdzPTYa4pWpSlrYaSdyLhaRKmiCOqkezWmhtr32iR5tknkYSb2JRlh48xAQNY0Td7ISdFkTCJwkxnHrTro2HklS06vj+NrOV76/+8OLQy13n+2lvdlonOO6DIdV3sykHJCbw5Ea8MVzO/jzwtCk6QpzrVjrltKsMs/GNbNlrPtZRfumyuARzq+prIrLSNTEtAH9pz0qJYM12oAkZUVoC2KfM4voOlV1og70NaEtEVt14JWYjk3B6EKmoWlNeONTSA45Al4HV61YX8ipyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNdmcW56aleJoC16aj/By1K5R67/T3TMnT3Wjs2Vhpc=;
 b=y5EgdOQ95iATwe8DuvnU55oxBfjiHMqEgUzZxp63fVdYFaNgOPCyRN0RvI4Uuzd9zRXwA90iW5hyrd5Nm9/9ecXd1+XC/x/mdrG9tJxuAzpHDXoQzJ2fAz8mUrx3MaxHWfMbnQbtggdQyXNEjRgu919eN5vCw2S1iyc9WOC6OUg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 21:32:32 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 21:32:32 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v5 6/7] dax: add recovery_write to dax_iomap_iter in failure path
Date:   Fri, 28 Jan 2022 14:31:49 -0700
Message-Id: <20220128213150.1333552-7-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220128213150.1333552-1-jane.chu@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:806:121::16) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 735031a9-4eef-4c8b-24bc-08d9e2a5b18a
X-MS-TrafficTypeDiagnostic: DS7PR10MB5022:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB502272960C8913518521B004F3229@DS7PR10MB5022.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHUiZFZSvrvzTECb8svQVbU335TU5NhA0EOPEucoiEUcKtROlsxHYW/G2+yiTPPFx8TRK199V599pc3+vRCKiy0L07z15IbsqhalW7M/o5wHAz9jHQEtiBFk7sBSCc/Z/cMzZ+G2bEMwPxuPQFXVf/R5PUTrcij6el0aNoFYknzV+QWNJToaCh1Mst23UzL+KL16mtwHQ7OfSR9Dek+1pmPWl9kJBdY9qh7ecATbjLXb71DFa+2k/vUjbTaZsBpZXXuNhrHzwxT5U/RsqoNPrrQqjnO4g1hFEIVZKZvkR/fBjOEdt+ZIBfnMzDvnOzdpavpRpNKnzV/pkpHUq12LlQQCr6MMf8MLrD/qaOmTRXdqwckqBZxBbQiSv7a8oMtG5m8D7hTdPT2pRwELCvQxchBDbEuQ+QXZo3CBJWR6w4/A5YpqLX7Ksan6YGm0rwWS6pfpzYqUESbkTKvduo6nzSTS8Aga8pyBDW4+7W9pkj0BCXZuhqbKmjdr2/fVOGol234tbjR1vCkc5RBm+KLq+8KxoNZ21m6U96CuR5zU/589SlH2XMZ8oDbBbrVTWSJMGix/4IMDyOs6/1w34uRJTCiLnqtpN6YdMmjJLslYgPyU/uSU6+clu5LXy3NWCkfht+8YVt8JvLlTnt0EmOxG9c1v2X5HOuy8kjgFP2clxbUC597mkXIRNn43s97nsE13ZMrKKy8IN00xlKkFI+RaGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(6666004)(83380400001)(2906002)(8936002)(52116002)(66946007)(508600001)(66556008)(66476007)(36756003)(86362001)(6486002)(316002)(186003)(1076003)(2616005)(7416002)(38100700002)(921005)(5660300002)(44832011)(8676002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34kDvhgJuealC8TDJchq52Qc62r2OYvSaEEZx78Vt3eeHZnIDdKuL8s/n8St?=
 =?us-ascii?Q?z244tECZeO5oHkB2cxXnSKNo2sbaEYg2XjbRc6XKQVFJ17kI25VZeaj/kyj4?=
 =?us-ascii?Q?3LDz7llU4ZA80BbLrd+8hH0lv1zukarsVZ4W1mRW0oXBVXXTWpK000v61Uc3?=
 =?us-ascii?Q?SMIPIJPg+v3a4BZOI/r3dcFwD4mMdxI13g49RR2HkhK8LE9YN2SlW9es3W2W?=
 =?us-ascii?Q?bxyaGN9bVtNPuZyfLPTNkaCn3WFLRBTmHd45X8Rf1MCn5wKNGHYD5qly3ZLt?=
 =?us-ascii?Q?lufmdh8mvs8SPxn3Ge4nlCB+pdl1olxECXBwMnt4csNTpWzxLiJoAKJIfLoU?=
 =?us-ascii?Q?Se/Xit0WYLarcoE7HzVLE3lcCuJ8XXSrnh26MrgEA+oFflkHwtoHCFCIXUrS?=
 =?us-ascii?Q?ihATeozJISa3jQpfXKx71pnOZ+O8fzgDDKwRT6cOqZW0hV5RqLFmI55oIzp7?=
 =?us-ascii?Q?CN8VAm9pMRB1NWyOudI5c6j8go/SPV7ke9wZuLZpmliMj8db+2P64O/eQuqN?=
 =?us-ascii?Q?1tRFvlmw1/k0oq24KSb429q9VgqlBiEvdYpOo4vdLfpJBHu1aP0TzmJoBHW2?=
 =?us-ascii?Q?BykfKTgNPMxX6lA2nQkUXb57RE00VL11o4AThYf7DQB2VClyCD0ZodXKxTd0?=
 =?us-ascii?Q?bICghxMOuyptt0/8r1oa0AXllhpt1GDUAhCQoPDDWGJvP1NDlqJoMU74toVs?=
 =?us-ascii?Q?MpN+AORCDQBNkMC9EEnQE07YtTmfY7F37OCTuTpN5lsOyh+yNxwP54tOfqck?=
 =?us-ascii?Q?GYYeLKoueg5a4ARxdS7WPHOHZBz4dKA1qhOIZBLJV8DDgycV5MTZLl7h/1gX?=
 =?us-ascii?Q?9ocB0cpPDYcBU6gSFT7YbaO3pao31pFkkZjd9D3FDVYoPVqonJ5IT2hx690A?=
 =?us-ascii?Q?1gu1/B4gujDpLjw5w81nIhmXzwHpQDDFYZyMw4g7x7WO5KJ7XQqoJsUxPlWC?=
 =?us-ascii?Q?Y/q/2fpWzCHMKqGu+pycMJSx853C0pPem/JhzwXo11+gQbxsAp5Tt0O7uVMF?=
 =?us-ascii?Q?q8mvOmuApvWEXqsmWfWHdPDpHOmxKhkjebrQHUEScLXzuWf1vE6OeWZubIF2?=
 =?us-ascii?Q?AdSA4TSqIedD1F/NnPcQtfMRniWW8fudulld5lJoL/rGHlIhngHY59CebrA4?=
 =?us-ascii?Q?9Z6Fhxl7CVn7bov8yCBEXdMSS1gt/u/yXkMcFiyjBKWKSunxmwITiJ1Xnq85?=
 =?us-ascii?Q?yDyD6syLujR6vy2FUBIvLeIBO6cRxcXNJRb7uBbXlJbvkmtejdBPg8k3tGTG?=
 =?us-ascii?Q?UDBzhPZ94tXAXITo+dl7/UJrttHXPEVcHFH9hb6q9L9Qy5sUgxwQm/Ub2lZI?=
 =?us-ascii?Q?7DY3nE2o12UKUP2yNVQxDw4cGTDEr6ArRS9tcqOiuRSNxUBTapWW5VBtdsov?=
 =?us-ascii?Q?7pbv1cN49bv8Ztv2G0RqIjViCAuqUkzumUzuYvdwrVgx/jvgkT3FFTpXjQ5t?=
 =?us-ascii?Q?qraFAtz98gQMBCNZs5qIOrwWV7NAmQcerIbHMuSpDVxDmrz4NZ1v0J/Q0jQy?=
 =?us-ascii?Q?24d2AxNVkeAU0vIwqUT4x48zovSEhoHLPVuQikqcpzPvn/iGJeUmtTlmOtQO?=
 =?us-ascii?Q?RWJ6V6g2AoR+w20DEElLiQn2AWc3w8twMtm7aDYmfZC5UHKt5JHwvP2cSsQn?=
 =?us-ascii?Q?RS+//AoxBoZUi1H0geZQ6z1h2QkckUUq/3L7yfSaO4eN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735031a9-4eef-4c8b-24bc-08d9e2a5b18a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 21:32:32.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bL/L5hP8gAtm7qHotDUVO9CFj7Uoo0M/M+xsv7x6H6B8/Lhm9LBu/LeQXYCxHo0ojeO6Rpbs72c0iYOMf19KDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280122
X-Proofpoint-GUID: UZwckryaTJEVRlm0H2FJP-UvsoJZYcC2
X-Proofpoint-ORIG-GUID: UZwckryaTJEVRlm0H2FJP-UvsoJZYcC2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dax_iomap_iter() fails if the destination range contains poison.
Add recovery_write to the failure code path.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 fs/dax.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index cd03485867a7..236675bd5946 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1199,6 +1199,8 @@ int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(dax_truncate_page);
 
+typedef size_t (*iter_func_t)(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i);
 static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		struct iov_iter *iter)
 {
@@ -1210,6 +1212,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	ssize_t ret = 0;
 	size_t xfer;
 	int id;
+	iter_func_t write_func = dax_copy_from_iter;
 
 	if (iov_iter_rw(iter) == READ) {
 		end = min(end, i_size_read(iomi->inode));
@@ -1249,6 +1252,17 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
 				&kaddr, NULL);
+		if ((map_len == -EIO) && (iov_iter_rw(iter) == WRITE)) {
+			if (dax_prep_recovery(dax_dev, &kaddr) < 0) {
+				ret = map_len;
+				break;
+			}
+			map_len = dax_direct_access(dax_dev, pgoff,
+					PHYS_PFN(size), &kaddr, NULL);
+			if (map_len > 0)
+				write_func = dax_recovery_write;
+		}
+
 		if (map_len < 0) {
 			ret = map_len;
 			break;
@@ -1261,12 +1275,17 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			map_len = end - pos;
 
 		if (iov_iter_rw(iter) == WRITE)
-			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
-					map_len, iter);
+			xfer = write_func(dax_dev, pgoff, kaddr, map_len, iter);
 		else
 			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 
+		if (xfer == (ssize_t) -EIO) {
+			pr_warn("dax_ioma_iter: write_func returns -EIO\n");
+			ret = -EIO;
+			break;
+		}
+
 		pos += xfer;
 		length -= xfer;
 		done += xfer;
-- 
2.18.4


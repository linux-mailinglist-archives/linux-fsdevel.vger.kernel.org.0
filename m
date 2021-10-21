Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E404356BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhJUAOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:14:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231348AbhJUAOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:14:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KLtHCg000751;
        Thu, 21 Oct 2021 00:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mMKPxxZP2e+K4hCIEILD333DY0RfxD/67zs0FCuASD0=;
 b=pf209cCFJTZeZk7IS5DkXhx7oz/yS2N+sSxUm9/HSRkXUkTqEbbK9mysgf39jYcfR37n
 ddXIZsJE4RyaDfkhF0XsVRWstjhyr/yUzWlAzz2KG7JzMmBx5CiCq5xfVdj9XyCwtfmr
 W73vL1xaIZ11TroecE/HPflUy2o/9TMbtcLDym+paD1VhmSimLOHWxR3WxQadsw2jFZU
 ji8KmL1pghE/zYQMCHJ/BM4pcmVlTnesDHO9SohKuz93WtrZ60wtpNCqF45A4AB0Dj1Z
 oRt4iCotL5AO5K+XfC0IpDlJJQkeFmOOdoqLnHWPPiNX6gXZInoda6a7bq5xTj2q4/rB zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkw4ua95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L0Assm065243;
        Thu, 21 Oct 2021 00:11:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3bqmsh8r22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIs3dWsX+TZLc7Dv+f4lluY6CKNYT5C+YHN7Pt28K7oqkU+DHdvNsSSvxFMuQVJvhnEByleiL0LIFWj/eEQbV1AseD37S88jKI/mX/uKhNWQh6pbINJs/+HqIP5S0QM69V34uYAT3yWSRzSd/sH9UGPzd7XebKlYHv4H3xxsNmFXT3re8xooUgQ0Th6+ot1oylCDTnHDpuLPxIZdVHlrZfw1NBXZ4ZAKxtegEvIr3oE/ihM9qG28gIItUPO7CMnLyLFdXYlJrb+lee+V4UgoAUYnYxehKnTM6MJKQDbG2Fn/6O1buRYm2uyi5hUCMDRpWL3bsx794nWbPVmQT0W/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMKPxxZP2e+K4hCIEILD333DY0RfxD/67zs0FCuASD0=;
 b=lYSx9Yu7pR8laP8Cy7cVHP8MSsWq4Z4Yh7Yp3CIeNgYYW0YU0dgRNUtF5p+3z8h5iJQvA/o/OTlUtupsGQ2rCyFKVhTlrQBmv2L8TMV5iYm6egpHP+miVcPEhacdGYGbteZEAH1tZaWxn79rLamjBBbshzlQpha2nnzgco0sbStLDMcAe9ZZXAN6UHbPZIKrKEnfziC2VCfkMmVdkLzTn2ss2Bs0vG5c5xB6xX6hJKC6myx+cEECm5KVFDL4Ll7bBav44l7XD6bPiSmIeJmw/pgw3mwFd6c5XD5IdaSUOS5NUtTOsLuU+l5+SwhJfWW35oZ1ZtCUgUtW55M2PBK1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMKPxxZP2e+K4hCIEILD333DY0RfxD/67zs0FCuASD0=;
 b=POhbYpAVllGP2L2BfMqVKLnQa6mwHkBpwqKKxfWUXRTWn088G7/EMEwi9MAEm+JpZ6MUwMww2toFupyerSCYQHFHgGXl96A1ZhY1qnZJa/rLOtXHnpmzNxwt/Q7+046ZSH/ikIsP1yW0iQzPp+RwXTuJMACMnzmsp/iy6uPuHZU=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2759.namprd10.prod.outlook.com (2603:10b6:a02:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 00:11:47 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 00:11:47 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 3/6] pmem: pmem_dax_direct_access() to honor the DAXDEV_F_RECOVERY flag
Date:   Wed, 20 Oct 2021 18:10:56 -0600
Message-Id: <20211021001059.438843-4-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211021001059.438843-1-jane.chu@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1d) by SN4PR0801CA0003.namprd08.prod.outlook.com (2603:10b6:803:29::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 00:11:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e34304-e552-4085-9c9c-08d994275f70
X-MS-TrafficTypeDiagnostic: BYAPR10MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR10MB27590F9EDF903E0A493BFE8BF3BF9@BYAPR10MB2759.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ialZt7rdQ9aIEx7M/r1Pi4gWS0ZLaaRPf+kP0X6J2SL6126a62SaXhTkN6n7FJG/ef5/Qky12S+Vv6sSrwzepM+36PAACUSxw0ZhH/9vIaTCXEjDmwwgx0e0l29DSp7impHapoT3RBR8iJPOBZjdl5na8zLkD6pkBsWPzIKhX1Of9b8qTUX5V3HpTH7tYAoyximAuEIC2KQMhSMubwvEvcrbormZ+VPrTV/uj0HuCKVp40Q5e3I4ETTCZyVXAfpgK8+gaF9kk00o3p083ahihYTeDP2VW+fr3e+3ePz9T20tnqPHKkRSYVuKIXuRy8d+h4sCiCwhAZAakh3zb+bi1J6sv7VPGgY1FthOAyKpGedtwM94n9u/nscYnabbV1lYzEWMiqoTnZKADIJkMR0OHrB6hFF21GpbjIyO2eZ+qrZbz6ovg2cT12aHwEirG5T7iuB9cJJ56kj0DQzcORK3SQaNHhT9KaUsnd4CAQOgB4OfStuLlrn0rrDySsnkgWHSO3s9ipjO+1OTDq0071imlQK2iP5qMQ6fUbxLwjQOi6TGrjn6OPZI3OobYIjnCQg/jqWiGNu8a/rf1yMNY3XtLg+l6sXI28iA6d91yGs48Y5CXPaU8BsvwlF8NglqPDhA9cv5Jh6vWmRJ6GPSFDImQrXCaq03uyI72fIbLBR9b/5TQwR+jbWMg+O4UWk4JsxB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(1076003)(66946007)(66476007)(7416002)(6666004)(38100700002)(83380400001)(36756003)(66556008)(921005)(508600001)(6486002)(8676002)(4744005)(86362001)(186003)(7696005)(52116002)(8936002)(44832011)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3t1vODUDhznxz3ZhH0NnQG9j3KKZWfQpcPjrUWSZ1ZoBZW1gCjSXNOLwlWI9?=
 =?us-ascii?Q?8sJob0c1KCg7Aqpf1awq4UEYc0UnXHK1rP+VGL8SoI/+KYVWw8j2IFEwUmVF?=
 =?us-ascii?Q?qE6DYnkmog6RQQffsko8frYRzgeletjVWaQc9/UJ8YwfClgKvg/BV2M9xZWW?=
 =?us-ascii?Q?cM8EI6Q6val5RnxvwHxlr8/+o2maU2Orq5VVS6yuDX2Yu+HtjUVd0sKOGtAj?=
 =?us-ascii?Q?HRAY8qnvmEuwusKULqM96f4ZSoXhlyGwqPzQiB6SwkVO+Ppys6b9NLx2iQ49?=
 =?us-ascii?Q?jNca95vXQeZr/i7GgOjU6Ac1a1kv1V4rclLkOlyjBPR4a0VuhSbqEVuNKXW5?=
 =?us-ascii?Q?2f98sYLhnvX2whSU1861E92+vswTLjwngcaWSr9RfDb1yruH8J9CxmB71G+K?=
 =?us-ascii?Q?Kov9n79qMDhxT+m5FNXd8seT1QAu53VPDuK7QvGap9kxwSIsQIpsevYev1Sh?=
 =?us-ascii?Q?GZ90mgLfmlbXAj+IJ8makU0m1wjiPqHugNOFZeBwyhPYpJZyiHjviYUxOSLh?=
 =?us-ascii?Q?ILSBnNaYrRLrfDasrTaPML3PG4CThJzrG24pFBMKn5aQ0li1frIFuPKTB3T9?=
 =?us-ascii?Q?W8/5sHkLNMvTYmRWb5clPiPans21FuXCo7CFI7bNb5NJ9KgtMlFkiVROUyjY?=
 =?us-ascii?Q?inIfSxscIpZmAIpvMB8EVsNfkdkXaMqWlyEeQQndrX7PvaLwEMM0j8tETJmg?=
 =?us-ascii?Q?+4VIwTMmuZjlsWgb87DZ2vXRYI9/7j3YgcqXAkaKCXB07z1rpkoxpzlZqhkP?=
 =?us-ascii?Q?6J0ZxC6c8Pd7763mZMeJUK71m6z1Jy3UNd63aKJR89/s8AX1ECWa8SyQZ1fI?=
 =?us-ascii?Q?L3wq/e8aN3M6wKGGvmUIvd0IsoqVJ9tMEsD1YA8duj2C6VynfT2HHj2lY02W?=
 =?us-ascii?Q?3Prm8PYBo7CiJhPBm17tdmG0jsGcm6TalxbwbvH9M/SdWBkmP1KMxJyOs2wP?=
 =?us-ascii?Q?yxni6jwbV5EoHbjTWMuscO1sFj5zLkEvsdnpx2g+PIBAnBAqTTJ8KUYV0Esm?=
 =?us-ascii?Q?YnAzRzvBShdZ3YL0WWQnAbM+yPSMAlkzYgz3OqfbV4hM2d9jpzs00cGIxHNP?=
 =?us-ascii?Q?A04Y06MC3U7Hd8PM+dxxLeJWNpeJQL605Y3LM2+z5FZq8wRYc32CXEvKVlbe?=
 =?us-ascii?Q?FqtfwUQPzt+4ATI8baC58HwI82UUVeaqVxQUZNpgHTa6TW2g8CTlcp/dmAfE?=
 =?us-ascii?Q?UHS8qIG6ykfB9equq2qufafOTkPIF4MIP4mFdvJqqlGvi5MhWhjBpnBwi5KJ?=
 =?us-ascii?Q?j8CwEcWR3GGzELaWcRNlhJYL75kHf3wzZxrfyA1nTvc9YfI/JK0V3qyebrKA?=
 =?us-ascii?Q?ULHtbpq1lEIwW90lVKMiY6y+x0MfX1zXRoNtP6wftH4gRA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e34304-e552-4085-9c9c-08d994275f70
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:11:47.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2759
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210000
X-Proofpoint-GUID: BSrYvwcrth4GIo732G3Bx8_-w7XVfbUy
X-Proofpoint-ORIG-GUID: BSrYvwcrth4GIo732G3Bx8_-w7XVfbUy
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let pmem_dax_direct_access() skip badblock checking if the caller
intends to do data recovery by providing the DAXDEV_F_RECOVERY flag.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index b0b7fd40560e..ed699416655b 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -260,8 +260,9 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
-	if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
-					PFN_PHYS(nr_pages))))
+	if (unlikely(!(flags & DAXDEV_F_RECOVERY) &&
+		is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
+				PFN_PHYS(nr_pages))))
 		return -EIO;
 
 	if (kaddr)
-- 
2.18.4


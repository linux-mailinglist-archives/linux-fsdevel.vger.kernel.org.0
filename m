Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D732B48B665
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350485AbiAKTAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:00:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22694 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350363AbiAKTAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:00:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BI29Gn021730;
        Tue, 11 Jan 2022 19:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1rfp+soIZ7vej1qqNdpuKGA18JLBYpfc5va5jA1zcDc=;
 b=fLajsfihsSE4gxWT3Qq0BdXAny+rOBrHrYZ6Zut3Fye8nCUWUdmTRpQxEe/wp5OAcjh8
 6wR6m7Z3U9VVf4QyTWfxnDxzyZHzCY9GkwDwPmN6fhX4T+P2CH9jrvM7M34Y7XntZ6ft
 BmXiYWQilrZmN+IitJQqT0N2PplHiptkVkkikGM3uAkN6Jz2uArDY3A5emrxmvOv6WAQ
 wNeHUoMEWqWys2LD03DyK295OBOStyxlfRaiiJiO7z0l9ZT/b+NBcr5u28yC+tbG99Eb
 IjOS3qdM2ytuSuNYnZA1yDTTPxi1o6pZY/anEAvKXAkX1muvnwDC3VzzJkRpUW8ZL6QZ uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nkw16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 19:00:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BJ0AW5034629;
        Tue, 11 Jan 2022 19:00:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 3deyqxmg1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 19:00:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4v75P6xUhVmhRbApTQBowErakpQISU2Zzfyjsc4IfrcVfxI9DbHMCNo76OB+Z6crVXa+zMv0VoBKMmsBLDmWiX394IQEu+Qqrmo1z76maiy+sfX9IyW7fxuY8mn8DkFqdEzQ0TR2CwK3FvVkw+VX2UD5Nj920ZLwhWxM3RKggTPUoprN+urDrO8vS7ewEAdrK6POqPfDS8iW11NecN4lNBB2U9ZQw6XuwebPvanlzP0HgsRjLLe5UWc1xFkfIpU5IrOwIIEIxB1GV2Nvd7fPUh4LMXfuHb/iX2S8Lm5jX7mn0oucYHny7dMgN1jhxhvwPJQBVvoRSPpnTZLVnZsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rfp+soIZ7vej1qqNdpuKGA18JLBYpfc5va5jA1zcDc=;
 b=bcy02MlWZrt4e0YfhWSPA/Zb8CO/ZWIz0N3PGA9jw0PcGAOwqnC752JaFugvSzEtjTYCupIZcWj8IM/0MLSMIpZICKlkcP0snFpsRcVS4jYxFisxuRqVzfju5G+xMW/2JhL31P8rbHWaHSfuF7nTQZnXNpiPmHBpNHg2gVd8ydwH6kjRMwPiuIzlfdgA9VxhYIJ34AlBVLaJlctZhO8ihIPTuItfZEKTm5qtaoxNVRm+SR0ToMICVtOYf8qvg66dmdmAXnUxQmLU1gjE9rLveal0btFTI8lTgRuimwNVDGw6xQd3g4A1K6BOIk/eA8bVDV1WezfZrA+iiidKwf+oBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rfp+soIZ7vej1qqNdpuKGA18JLBYpfc5va5jA1zcDc=;
 b=xJ0kDcHRvPhGbEtjm+OUfH4oXAIgyOkrcAQ0JvB7rDlfGCEhVKDBPp7MNpXtk71bNA99x9sj9TXdUD7nFV5CILjysDpPTez8kNnXdXV937HN/tb5xQZHNv77FB/Hnf9R1OAG99khbDggnoDrIWFQfC9zZIg6ksTYSJGLyQs4NLw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 19:00:03 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 19:00:03 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3 6/7] dax: add recovery_write to dax_iomap_iter in failure path
Date:   Tue, 11 Jan 2022 11:59:29 -0700
Message-Id: <20220111185930.2601421-7-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220111185930.2601421-1-jane.chu@oracle.com>
References: <20220111185930.2601421-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33fc787e-538d-4917-6bfb-08d9d53492f8
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4495:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4495D8EA82C6D5748F952BFBF3519@SJ0PR10MB4495.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9S/VVEVSLAdW5qpwLzsQohMB8LGbKdujBaZlVrk7Kh4Qy9qOJw4RzDluyIY6AMuFPQrKbG4hZPssl9ZSTWfwIkRUcW5ltjNwAur3Ko6pk3IFWvjQoYrUYu7QEroCY+TbWasF0uIfwJBOn9rTK+p3ZZ7d6E9gUJHK18D38VnuxXZ0ZXxqsnDad3JPedk3FtX+3hisEcINA3uBS+BG59ZhT7ZyODul25qfIC4sNpwZrxnRgh9jva0MmNGGnzfwF/0JgPS9rTzTZADOdO078IVfw1n/zhjPlYCC2KbWu7Y+PCzrEPZG7gn8XL8n1slKPUGFi5/3mFZnn2/TtdjYn/2VXze7yEwm1yMBxqM1ipybiEoqyDQVbvCIkxHLD0SuthKRH7Td0ljEFgJM5dZ++AhWqCJmFIdjdDkWYFUFbWsvmM6hJnA6TuQ+UQwfo9835zAFX1czrUOPqt4E/Zv70bjWPcLOizwdRAFQqt/ZqaREjIq/ZwDdB7BtRE3X87kxAJcCpYgYaHGmaHtITfGQAnkVaYkX3hIUMvkHfLe88oKd9fF9Se9yrU4+N2vPb3rHkg8CGtxS4+v9zkJIN6VHr5y7coZCHdFG5v/RH1bd9N1nu13s8nMtvPMuCRhowH71nLST/a9kX/03RF579wwf1Q3WG3ASRimql6DwAZEZocVf+3Eo70M6wbENmHgkn+fHjwAU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(6666004)(5660300002)(83380400001)(6486002)(36756003)(38100700002)(2906002)(66556008)(921005)(66476007)(66946007)(7416002)(52116002)(186003)(8676002)(508600001)(8936002)(6506007)(6512007)(316002)(44832011)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p1OKUxPASkGdc8om1psOMzY2Aj+O55Is35JHfAHpV5AGeFgrBs+1wWAl7KBu?=
 =?us-ascii?Q?ExJ3qN1CqquwEYVylFuDURPTZFIyuKGJlqOdLp9uJxLCTGVyCs+R/1Xv/YKj?=
 =?us-ascii?Q?yEpYlLHcU3CsjkGw7fIyJa/PsL5sRZMAM1W3ibgPEwgtcJQMvkfXTP6Ah9By?=
 =?us-ascii?Q?tMqmpCTXhBgWPfwIyj68XExZ8XTfJacipo23B44ZgdTZvMhQ+6mCDwzG/WyQ?=
 =?us-ascii?Q?PLPTmNJuebzssDJJjoxwpL09shRutenE3USNxYP6OP8WdTpWJ/3ZCo+zQiUr?=
 =?us-ascii?Q?FMRZIv5STtyW25WiO44E9YQfrI6PbjioSTaOqr3VmNlCawFFGMahc3Hk2XI5?=
 =?us-ascii?Q?dS7OpnEvJ5EO9bBWmEU2m6WYGqxTmBvdxQqQ+jkXa0AhPc2FjmIflaVKxV0W?=
 =?us-ascii?Q?IpH+h7UNE34Qim2u2iVlWsUNkZs5CmaXZhFhaGc+rWrUOpVDqeRWXDRFUBNC?=
 =?us-ascii?Q?WMClfODend6WLgllh7rRgpS8q1Dwsbck6S21wmilU5TaaSpfQipHUb6Ros1z?=
 =?us-ascii?Q?0nYX+6JeH78v/3LDabAKRJqUlmye9HEHngDTllpGmXlkxIcakSSxjtysnq2P?=
 =?us-ascii?Q?Wqwtm3vISLIxlSVAFVsI3OHlYQUqeEev22eulmh1klo2c+T7fR5NRAC1fpQE?=
 =?us-ascii?Q?Anju8xhIfHJWJ1iZO4POmZfWI+fElpyLqtYaLwcyk3+gj5mAG+Ojw/2YNM3Q?=
 =?us-ascii?Q?ChydIq68wAxS65Mk8bLbB3LaKxOpkQwAa4O+gP6IrFqloXtaVF5dhBP9jjZs?=
 =?us-ascii?Q?xXnI2Gi0ryW2P5hkNcqX93ZYeinE1nuXlEM4kUu645I9vKFhN1SryeNcyezT?=
 =?us-ascii?Q?dsFnSYkIoPuxLgVwVOPG62jTmiXpc09cFQOCC23MQ+/GWk+Z09ViEVzigzwW?=
 =?us-ascii?Q?Koy4/jWcTXo1hV/AAXf5hfxcolo9najT5BzUDKo+6m2rLymrrSTmglwknEz2?=
 =?us-ascii?Q?qSMQP2x2jzCIRImmUiajiFHBTNgfVmTIIR0kDPk1IYAmRrM1UewIoxFHRXmp?=
 =?us-ascii?Q?GMz8V0kwnNFdpZSf7vLm+LkgNtyrxDclwsOzB8rfJv3idzH8gGzrzlhNaRQm?=
 =?us-ascii?Q?nTuJ0E953KSCPKhmzyU84hXx161+1bdFLD+4kdmkVJUM9DQ3W9pDlK3Y4+P3?=
 =?us-ascii?Q?YZElCKi7It+7sRYU+Cmw5P+i1OeJ9F5ciHDJLKcOUF2GwfeTUywhE/lrTHpE?=
 =?us-ascii?Q?uJ2wMEyQsYV47LTXGCdODlygy0kRgDJdTLDaaFCyAKpl/QcuEl5F4O5J7yYa?=
 =?us-ascii?Q?k/FzbFgN55m2OjMES84htsYw6c6N3/bMt2NrbAClOYX210kVbIWLJkIXTW1W?=
 =?us-ascii?Q?H6g+ozpyWYJY+zP4hTwS21eCQS8O11Q11Zdv2OL5EZKdT/gNIhqlbntf5+/4?=
 =?us-ascii?Q?2b+vRgl20gQ1cLLGxzCtN9mVRwWq5LGGf0qvidCCzaGrMkNKkdGUIP1X31G0?=
 =?us-ascii?Q?0NoxG9/tfy7a0hQyranoxGyMw58xQH40RZLFGrDA7kgpzJMsuFuiTM5C7ReG?=
 =?us-ascii?Q?IJdfzD/HSdxHJxhuOQOncSG8ycU16fRT32fK9ofhHZZcmlbH8v/HBZXPyvoB?=
 =?us-ascii?Q?VoQT9U5X6weJOWLLZGT9sd9SqOSYQmWaqVQ5VFBbd/pyCpgYwTdUDY999rJR?=
 =?us-ascii?Q?bIcZpG603tA8DJrENqY5ztSAfJkEoB+GkEzVaPQmA7kz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fc787e-538d-4917-6bfb-08d9d53492f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 19:00:03.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmOinlmYMoCAHchzsAzyY2vqpMqbxLlasauFwMror1n99rxilA1JGTTjOgEFy4GjN2K7qZvOAWwn2AS9J7BBIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110102
X-Proofpoint-GUID: rlgtq_5w5jJ7F6d3QEklQLH5R1rUc3_f
X-Proofpoint-ORIG-GUID: rlgtq_5w5jJ7F6d3QEklQLH5R1rUc3_f
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dax_iomap_iter() fails if the destination range contains poison.
Add recovery_write to the failure code path.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 fs/dax.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index e0eecd8e3a8f..c16362d3993c 100644
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
@@ -1264,14 +1278,21 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		 * The userspace address for the memory copy has already been
 		 * validated via access_ok() in either vfs_read() or
 		 * vfs_write(), depending on which operation we are doing.
+		 *	xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
+		 *			map_len, iter);
 		 */
 		if (iov_iter_rw(iter) == WRITE)
-			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
-					map_len, iter);
+			xfer = write_func(dax_dev, pgoff, kaddr, map_len, iter);
 		else
 			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 
+		if (xfer == (ssize_t) -EIO) {
+			pr_warn("dax_ioma_iter: write_func returns-EIO\n");
+			ret = -EIO;
+			break;
+		}
+
 		pos += xfer;
 		length -= xfer;
 		done += xfer;
-- 
2.18.4


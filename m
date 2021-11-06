Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76151446BBD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Nov 2021 02:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhKFBU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 21:20:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64668 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233587AbhKFBUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 21:20:25 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5MiUTY004533;
        Sat, 6 Nov 2021 01:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=c+GNFDrFMiooQMFPEQGlkC52Llu9IBjyO3DT8fpTVH0=;
 b=OWV3IxT0feLWyiHVuluR7g66EIQdQZTFa8bF/3u+4ANW/ZHVSZZzj7r9RXzjBmqtZqPg
 sIo67R2ofjqaSQyuGtkzT0aG71viKmnBfZ7nTw5xjYWlPDxeA9FnUPkr4grP1F1ITp11
 BEfHCFfsv2BME82hLB9ibxVknmzW8E8P65my+WcSBm5bKSd3djPRYWF92DwBtrGociWQ
 H02ikuoqv5JX/G87Qch6bhRkxMXYuf7kfAzOfjOmpyLbOMDzV2XubpKwtb0wUA3Y+XAh
 XJwoCAqBuFndJBa0eBrQzFUkWe8MeNqGyykxkHCSRkOfDvs1q9rsVrafCm+kOfiWRZhR QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7k5gp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Nov 2021 01:17:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A615rjQ064774;
        Sat, 6 Nov 2021 01:17:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3c5fra86fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 Nov 2021 01:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw4y7+gvYI5/vkXRi4jdV2U4QGrHMzVC34+2kTEKjzXb7zSxMenD47KX1IEQE097VUr5Xax3f78VsWGkM0blPROVA2KmUdTVXqPV4Ew4RCB5afmseZT4XWpTF/2y02RCX429sMgiYr79Jn1SBMZItsjSOFHknI9KMHHBYRBF3sa64MRgmbR7jknlkuheT2v+5BI6+vAhDhAqKUYM3Xct9PqchsljzSuG3YQaQdLX0k8ijxuUrKxhjt8RqoIKskbbZgop22rmZfzYzzZbxlJpfkaPvKxJTuxUCWpzbJRFOfM23oCewa75AIxb5mEDCUQYReYnHPdp3S9+9YCBY8Dv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+GNFDrFMiooQMFPEQGlkC52Llu9IBjyO3DT8fpTVH0=;
 b=I5XGXmspM0rfBe9K+KnjLfWS4CEranBTHz3PJXinHp1aGKu5ju+r9Rehitbnug8gp0/W3jUKMUAOuuaeHeu0l/IG1xnQb7uKH/4c87cTfV4VMXV6tdli7vMTlWq98rbYjbQBos+bTVpzfdgluacDmEZOOi9Y4BdIkrFG7nx4T+zyGv4qYMoHTri4rUF3xbNfIH/MRL9mVlfCM5iVBx6XUJO62QZF+5E1NVCI+ikkDq2DnhUm9qkkD5VhgVFx8UgYJ94KObDJiKgtTxFWfRoL62qGEYv1/GTcTj0/HKfXFrTbYLLwjKDCAHrvL+8WJoCz+IJUh8A8YNcm6y00tYHZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+GNFDrFMiooQMFPEQGlkC52Llu9IBjyO3DT8fpTVH0=;
 b=IFsItyLgdwVHWD03YY/225hAdoJ3LMi9AWG9RsElaVd0qEtPia1vND0a3P8nPJozjWQ6iDmeYOeXwDK0fKJUoQnqC5NLWyLhsqou0ycoIZCPojn8acCszR8pS946Qh22l2NHRXJ/yT3ijUH4kst1ptvz6lBiO8oPjEWpvuzZH4A=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5890.namprd10.prod.outlook.com (2603:10b6:a03:3ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Sat, 6 Nov
 2021 01:17:13 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.013; Sat, 6 Nov 2021
 01:17:13 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Date:   Fri,  5 Nov 2021 19:16:38 -0600
Message-Id: <20211106011638.2613039-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211106011638.2613039-1-jane.chu@oracle.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1c) by SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Sat, 6 Nov 2021 01:17:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3a5fe25-00db-411b-1651-08d9a0c32a31
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5890:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5890D3C8F371157D99447E78F38F9@SJ0PR10MB5890.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8lN4WQn8vgs29dN3eW8aEm7O1FDMLSZtI9scVD7shXvHMP/5zJm1sgPDMUU7c/40eePadtjofBwjhxpUMiDW1x4Kp8isvCKI070G0urN/JZyCgxIm1yWewVLWN14nDrt6WZeDrg2hqZnr2IKtMejrf3D6S2sVH6JdUv2ThkbHJ+S59Ho59s6f9p0QUxfsuHKDKlfoRbvxzhir8P4mvNEYLNrE9D+b/KnlnW2okBo0hAcat4h9TnuP87dOwtq0hWcLX1H/+iKZ4LgE9NNtW0wIaFpBajf+5cN/OVIbX7xvcod1vJAD7sNCBNSwoiXotwvm4CyeQzNWeaIDmQNu+ISB2XDlBKT/Hii0sEaA69idMsEW6pk9BxQatHTEqokslI3SR00TFAUK09o7AZeD//BphQCj4iaqfFncQWrBBsZ2mpin/IO9+kdAJ7GWRv5ev8E142xQxncwiz7KAx6RDJb6Vw/KiyHZoK3BiaRWgN4y5WKwWf7jVz7hQnqm0fJ/goRqxTwm/2/6Zec7+2iP8Cx+5QZ5WasWnv/Ti5Cz+wOJINd7/XfRsBcHEv7jYb4p6jf02hm8Njdu2O9Wx7dQw9cnGLjuAHHDU6nwYAoLspgfaoFXNk7Ns8K9wPL0oR/m4yebF/vqRb6N/m7RzNzQPBW3DFGNl/cOlP/tI5SQ7ejRbJ9CACWExr6/+dDq0hShNMmYEP1kh2HlMdv8ScEUDaQFN/9FhKF6KYxJrmt1EB1LU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(921005)(36756003)(8676002)(316002)(86362001)(66476007)(66946007)(508600001)(2906002)(44832011)(6486002)(83380400001)(2616005)(5660300002)(186003)(52116002)(7416002)(7696005)(1076003)(6666004)(38100700002)(8936002)(66556008)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DjQAfA7cdzLYsIHL2GD14ScvUs5h2xheFKca+ftoQnzohGlOhTCq8euL9laU?=
 =?us-ascii?Q?VMolmDB9ElzldgAMPpfpn8EOmcmQGTG/jaqKqifVtcoMPdpPsakarCJR9O7F?=
 =?us-ascii?Q?FwaS/pfKMVhAhznd/tvwMgGzDhGOkN3hgzvwiaODS2WMX1ez+PNvRROwq0ts?=
 =?us-ascii?Q?3eJ7R6RrbA5upL5HoP5a9IelMSixNzVuQ2sgUA2L4MAwDGMKai/oNZsCvooX?=
 =?us-ascii?Q?2hI82jfAIa/O7BNXJZLc0XWinw5K+eoBgrSd+0VNAedUIrZ5nZ31kcjHfnX+?=
 =?us-ascii?Q?5FHpa57bW3pD3OyOjteO9OTUHAGBw5HrCFO8UTkWmaEFWa/LAakbUANMhHxT?=
 =?us-ascii?Q?OK3939VWdiyZkx6N6MpGQUMv/wcdFsgiVmvl8Ir+293mO45QSMepwAxK66XG?=
 =?us-ascii?Q?R4/75NDzas8p7I91Oe5ONIUn3AtzNbkyoNgJf1oD24uw0z0aO3DAE0MfcYcN?=
 =?us-ascii?Q?ZP2tuyEoc2VR0BCKYuqZEnuMsM8b+Nz6m6K6WiWGHaUJivUdEFwbxXzMVSyC?=
 =?us-ascii?Q?Erp5CPPygekimc0VDYxkLDun4Lfwntb07AuJKbvLOo+vKl6wAf7AgxuRliTp?=
 =?us-ascii?Q?qUZhyZwfPUgAC3mZbYLoi9axSO2Y8o3EqRm70mDHdXEqkR/kp5jDrkA2KcD9?=
 =?us-ascii?Q?aiYhmB752uRcojPCG2uRIRsqsXcAhVQ9kLnsleFoBQhoare4LcWO1LAZn527?=
 =?us-ascii?Q?qxjRwI5mj/Z7kxNYLsDxyRX1q3wAoJnzY2H8NH/4+I+7qYY0HibOR6Cvzw93?=
 =?us-ascii?Q?dWLrqAqa9hGjg10wwVagdeLTwGUeMZ5QqYMwUoSSsu+jG/HFgYt2RAtZOJZC?=
 =?us-ascii?Q?ajQvYrcocVHmB2/e62mDDdkpAqsJ6YUSL27foJtk11OEFDIWffxN1Rbc36bM?=
 =?us-ascii?Q?yTZlSEqsfd6Attrbxm9BsV526BgZ+Dj4E4lYmYVkzi483OQxVa4Wc3OxnNba?=
 =?us-ascii?Q?kLKgZTUqGqJtfj3FIYeDJ6zbS7jU+jyetx7Wov/r1okt7ETaaiTdN1FWE2QU?=
 =?us-ascii?Q?fxFOV5s5eIW3lM2jrjpyKRa4dxSYMwTI5ewS4HH1yaeMxJNFjwyEMaFRijeh?=
 =?us-ascii?Q?tA71cIc7FzinzPJBV+pgnPeWT0h3ILfjMo6gOhjwCb2F2GZMIJ8Qw2UCx3ZQ?=
 =?us-ascii?Q?QOLBSpfCo1JMQQtoZl3xL+4DExGWfboEgCbdv5Z5q5xj6L2LHjQC0DRFcc+0?=
 =?us-ascii?Q?iNAwrKN4zYBe4gSfyZOGbTEkFp1dWlr1cn1C7XV8VX8cDkJU/aDxC82fNthh?=
 =?us-ascii?Q?7NtiDP9adrEZReTEATN5W4/Vdh5RDZ5A0Ff6M238X/6E7etl5h0o5bk52cZ4?=
 =?us-ascii?Q?CaGT+D6RbJmsm3EK3hBpOgMyELRuT2qzi/IHtqOh9QqSNNl1jU4Zom8S1WSg?=
 =?us-ascii?Q?zaLYdRm+Q3Id+UaEfyTOHkIlSziLJSBhseppUk0YfbG6kSw4cm6DWdYg5wXV?=
 =?us-ascii?Q?iNVFumbFc2mOd1NeUoUib1XG7mjf/MBXXLVaXlYXVsL+YFDovDkZrBy1xJDh?=
 =?us-ascii?Q?3I0QIqk9b4oJlynlxWqX9mqG+YUvEPZvvKpt7UyyHejciuYOECDOT13Pa2xc?=
 =?us-ascii?Q?QaCF7M+fmBizXJckCf5zgin7YSVTMm1u66WEio2uW8O7ahqGazzphxoxwX52?=
 =?us-ascii?Q?12Yy/EKOYlhOD9ZCt8zn/e4SAS2fozYKaHsENJN5y75t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a5fe25-00db-411b-1651-08d9a0c32a31
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2021 01:17:13.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zb0nlpiDQVi6hP2CxTIL9rA0Lj9ujTB8CmkxIMuIz8TU4FiH3ZPjVUPJlD7Uc3GVnwsA0V3PKX870Q6byNzucQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5890
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10159 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111060005
X-Proofpoint-ORIG-GUID: BB5v6OVno30v7F4afHqD5xMuINTcBkMn
X-Proofpoint-GUID: BB5v6OVno30v7F4afHqD5xMuINTcBkMn
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For /dev/pmem based dax, enable DAX_OP_RECOVERY mode for
dax_direct_access to translate 'kaddr' over a range that
may contain poison(s); and enable dax_copy_to_iter to
read as much data as possible up till a poisoned page is
encountered; and enable dax_copy_from_iter to clear poison
among a page-aligned range, and then write the good data over.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/md/dm.c       |  2 ++
 drivers/nvdimm/pmem.c | 75 ++++++++++++++++++++++++++++++++++++++++---
 fs/dax.c              | 24 +++++++++++---
 3 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dc354db22ef9..9b3dac916f22 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1043,6 +1043,7 @@ static size_t dm_dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (!ti)
 		goto out;
 	if (!ti->type->dax_copy_from_iter) {
+		WARN_ON(mode == DAX_OP_RECOVERY);
 		ret = copy_from_iter(addr, bytes, i);
 		goto out;
 	}
@@ -1067,6 +1068,7 @@ static size_t dm_dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (!ti)
 		goto out;
 	if (!ti->type->dax_copy_to_iter) {
+		WARN_ON(mode == DAX_OP_RECOVERY);
 		ret = copy_to_iter(addr, bytes, i);
 		goto out;
 	}
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 3dc99e0bf633..8ae6aa678c51 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
 	if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
-					PFN_PHYS(nr_pages))))
+				 PFN_PHYS(nr_pages)) && mode == DAX_OP_NORMAL))
 		return -EIO;
 
 	if (kaddr)
@@ -303,20 +303,85 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 }
 
 /*
- * Use the 'no check' versions of copy_from_iter_flushcache() and
- * copy_mc_to_iter() to bypass HARDENED_USERCOPY overhead. Bounds
- * checking, both file offset and device offset, is handled by
- * dax_iomap_actor()
+ * Even though the 'no check' versions of copy_from_iter_flushcache()
+ * and copy_mc_to_iter() are used to bypass HARDENED_USERCOPY overhead,
+ * 'read'/'write' aren't always safe when poison is consumed. They happen
+ * to be safe because the 'read'/'write' range has been guaranteed
+ * be free of poison(s) by a prior call to dax_direct_access() on the
+ * caller stack.
+ * But on a data recovery code path, the 'read'/'write' range is expected
+ * to contain poison(s), and so poison(s) is explicit checked, such that
+ * 'read' can fetch data from clean page(s) up till the first poison is
+ * encountered, and 'write' requires the range be page aligned in order
+ * to restore the poisoned page's memory type back to "rw" after clearing
+ * the poison(s).
+ * In the event of poison related failure, (size_t) -EIO is returned and
+ * caller may check the return value after casting it to (ssize_t).
+ *
+ * TODO: add support for CPUs that support MOVDIR64B instruction for
+ * faster poison clearing, and possibly smaller error blast radius.
  */
 static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i, int mode)
 {
+	phys_addr_t pmem_off;
+	size_t len, lead_off;
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+	struct device *dev = pmem->bb.dev;
+
+	if (unlikely(mode == DAX_OP_RECOVERY)) {
+		lead_off = (unsigned long)addr & ~PAGE_MASK;
+		len = PFN_PHYS(PFN_UP(lead_off + bytes));
+		if (is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512, len)) {
+			if (lead_off || !(PAGE_ALIGNED(bytes))) {
+				dev_warn(dev, "Found poison, but addr(%p) and/or bytes(%#lx) not page aligned\n",
+					addr, bytes);
+				return (size_t) -EIO;
+			}
+			pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
+			if (pmem_clear_poison(pmem, pmem_off, bytes) !=
+						BLK_STS_OK)
+				return (size_t) -EIO;
+		}
+	}
+
 	return _copy_from_iter_flushcache(addr, bytes, i);
 }
 
 static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i, int mode)
 {
+	int num_bad;
+	size_t len, lead_off;
+	unsigned long bad_pfn;
+	bool bad_pmem = false;
+	size_t adj_len = bytes;
+	sector_t sector, first_bad;
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+	struct device *dev = pmem->bb.dev;
+
+	if (unlikely(mode == DAX_OP_RECOVERY)) {
+		sector = PFN_PHYS(pgoff) / 512;
+		lead_off = (unsigned long)addr & ~PAGE_MASK;
+		len = PFN_PHYS(PFN_UP(lead_off + bytes));
+		if (pmem->bb.count)
+			bad_pmem = !!badblocks_check(&pmem->bb, sector,
+					len / 512, &first_bad, &num_bad);
+		if (bad_pmem) {
+			bad_pfn = PHYS_PFN(first_bad * 512);
+			if (bad_pfn == pgoff) {
+				dev_warn(dev, "Found poison in page: pgoff(%#lx)\n",
+					pgoff);
+				return -EIO;
+			}
+			adj_len = PFN_PHYS(bad_pfn - pgoff) - lead_off;
+			dev_WARN_ONCE(dev, (adj_len > bytes),
+					"out-of-range first_bad?");
+		}
+		if (adj_len == 0)
+			return (size_t) -EIO;
+	}
+
 	return _copy_mc_to_iter(addr, bytes, i);
 }
 
diff --git a/fs/dax.c b/fs/dax.c
index bea6df1498c3..7640be6b6a97 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1219,6 +1219,8 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		unsigned offset = pos & (PAGE_SIZE - 1);
 		const size_t size = ALIGN(length + offset, PAGE_SIZE);
 		const sector_t sector = dax_iomap_sector(iomap, pos);
+		long nr_page = PHYS_PFN(size);
+		int dax_mode = DAX_OP_NORMAL;
 		ssize_t map_len;
 		pgoff_t pgoff;
 		void *kaddr;
@@ -1232,8 +1234,13 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (ret)
 			break;
 
-		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
-					    DAX_OP_NORMAL, &kaddr, NULL);
+		map_len = dax_direct_access(dax_dev, pgoff, nr_page, dax_mode,
+					    &kaddr, NULL);
+		if (unlikely(map_len == -EIO)) {
+			dax_mode = DAX_OP_RECOVERY;
+			map_len = dax_direct_access(dax_dev, pgoff, nr_page,
+						    dax_mode, &kaddr, NULL);
+		}
 		if (map_len < 0) {
 			ret = map_len;
 			break;
@@ -1252,11 +1259,20 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		 */
 		if (iov_iter_rw(iter) == WRITE)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
-					map_len, iter, DAX_OP_NORMAL);
+					map_len, iter, dax_mode);
 		else
 			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
-					map_len, iter, DAX_OP_NORMAL);
+					map_len, iter, dax_mode);
 
+		/*
+		 * If dax data recovery is enacted via DAX_OP_RECOVERY,
+		 * recovery failure would be indicated by a -EIO return
+		 * in 'xfer' casted as (size_t).
+		 */
+		if ((ssize_t)xfer == -EIO) {
+			ret = -EIO;
+			break;
+		}
 		pos += xfer;
 		length -= xfer;
 		done += xfer;
-- 
2.18.4


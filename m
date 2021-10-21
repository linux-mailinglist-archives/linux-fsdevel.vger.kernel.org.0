Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7594356C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhJUAOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:14:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35304 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231449AbhJUAOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:14:44 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KM5Sgc000812;
        Thu, 21 Oct 2021 00:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=CZBG0ZI3xO0HS+NJlup+RHX+AYJe0yMKmRUGBcXXnDQ=;
 b=ZIS8SCuqKDBtWnTLawk1Dv/C32HFVf5Qq8g6McKTZSD4JmOg8EOgJY0R0lDZ8/SdKeAj
 eO0MljrBhjgQngPK/PwOAe2/woBbpmD/6rzgWryCijh2F6bVzaUrAfThkigfkFoaRz+N
 l7HQtT9AgFmA8qzPjQYC+AIUywmNdh/AbG5zbs01QD/Mmjz/A3CePMDQ5+0fMSIo2udI
 oW5lfRfMVsaj7OSUPLpqvGBP3HnoXHInJ4t+IR+auKKrxfbPQgXlfD63hJxpW+lGoU3w
 G7f1A/QQXbqHoapISlL0Q3JvjAxH1799fCclf02gA4+e18PGUZoNiI1ol/AsFRAOYiD2 Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkw4uaa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:12:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19L0BaoJ180521;
        Thu, 21 Oct 2021 00:12:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3bqkv0x74x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 00:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbkF/Vls4feA5Idfg2KERYCH3yphk1xkSq/d9PLLXOW9cQ9ymYzzfz4v37s/zu+26vWXcRL6uevErAFwj1SzNj3S5LjMFHkobB7ZSdGMBDb72EqvFqfGh5Yw63whdMyLrDKv/KCErJ+4ZQH13iby5MfzIAg22OcDzaXSMEs/s6bRNGXmm1vkA8iAKuuMgojOtw3+8mk4L1CsJLOVsIXFyCmqp2FO/9EOkF5D999UmyY2G/MZNUT2iXCIhCqx+zW3pCLyqhCeTU1MS9Luj/e9csaeJYN/9jtdhIZWNjbdcx5UC4pLywGXetRiVriB3O2eeejpeZ/Z6n7pQ9UJ5JDktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZBG0ZI3xO0HS+NJlup+RHX+AYJe0yMKmRUGBcXXnDQ=;
 b=VobLBt/GzW9jRkU+dqPaGqmFptiHFqNIyx8lrXwzLjZHAedwfHrtpKRsD9nV2bHVmCzAWHjOvhOID+PwvVWeDYW7lSJRe6UaoLNfisx9r0avvgP/nFTlotPhjbbHlP71Xogr2V8QtWjozpyQDt4LWBQfDC/yMcWFq6mfMnTv5dxzTHoHJc1vMNjWJkNY92+YMiHFELNNXECJKAtjxbpVF2V9SdzdsuVs+GdUUWRQNNXYwSqRfVvuTdQoBlv9LthXuOnT/nBrAvzIei2G7Q7E0IRTR90UrFZF9UwC3Wb0jEW9lMIztUA3L0XtZTghMmSrOGNVcRMD8LmCr2pPBRqogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZBG0ZI3xO0HS+NJlup+RHX+AYJe0yMKmRUGBcXXnDQ=;
 b=BE3ECGEtxa9REAKXoui9NlRQdFlRY99hBsivQ3d2nygPUjU0lJaZBtvyPnTmU5zk4mxzN+y/51TjhpBMrZqS7QDWfl1PEND2XgD5HYBou6I6+4fi9sQkOFBDD9O9f9gOs1CLYsyBQsm/XhrS5qbY3K2HNpdssBGtHBjRf44eMAk=
Authentication-Results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2759.namprd10.prod.outlook.com (2603:10b6:a02:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 00:11:58 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 00:11:58 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 5/6] dax,pmem: Add data recovery feature to pmem_copy_to/from_iter()
Date:   Wed, 20 Oct 2021 18:10:58 -0600
Message-Id: <20211021001059.438843-6-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20211021001059.438843-1-jane.chu@oracle.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1d) by SN4PR0801CA0003.namprd08.prod.outlook.com (2603:10b6:803:29::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 00:11:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ffa4db-15d3-499f-a894-08d9942765ba
X-MS-TrafficTypeDiagnostic: BYAPR10MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2759FC4AB29B9CF7987A56BBF3BF9@BYAPR10MB2759.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmEX2epLGYlRwyw7bKWTM3QJ/xGFG7I1YYudye7DFk2+l6pvORl+GXJmNmye5hBZ7ZTKReYsQxxzQHYHbSXv2KrpLDrdBpEEWsI0BJq1gkAiUyk22sUfC7vgDzRNQfoXgaTgUJFloynJXEgWtv2nX6Ln3teGMIEebuE4kj6PzuL6gtVqckJoTdWCiCeueQg6/SX87kewfCEEWOfJiOkC+J8ehXVpPj0wmmI9N4aYzIlDZkEu88d56dkuq/Xm6ffMe3AwW8UA+x1xIgvrfvDLDfL5aF9OMMjwntWYc3xwirltZbGSwIx8SCpzVqt5gSVej1jhhj29M+DJWL8t9FVxRgZXd4SXvdFy92OvtQuZBWWz6CiHVTegsDFjMU2Gc+qpqDoVz523wvcTA0lIB/0cWt+f/LIz7ZSQ/21d5zPHO0MKSXHFVQPottVOjsoF3lt2ZxdouLnwJpMH5D8TjKGIiHGgx9jKontfoyCE+M0fVttg1yVcfjOAGb+tAc39hntT9UIloT8hId6SPHLySOAZd2CnBOIgN8zq2F3An/+D6CHG7Zw8t7t7M8zbzeuglclLPt7xANoWfKaGYW7uzKSvM0BMf8jdCAZ0m+ImCj4uRpaCOlPKJBSZir3KAUNHCOcdz2lT7Fcw5Q89nquLVKnVQyZMBF3ys0OCGX9id9UwFgX7Km/uLrgX4O1L+kSCbBq8t/zTHe9GBdyFXJX8R1ex+5LN/kfLgkXR8fQv8YVh7a4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(1076003)(66946007)(66476007)(7416002)(38100700002)(83380400001)(36756003)(66556008)(921005)(508600001)(6486002)(8676002)(86362001)(186003)(7696005)(52116002)(8936002)(44832011)(2616005)(2906002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qKRFLVA+L/hlQG4sjPnJIPupHiECM2Ie9obJ/FXDRNj8XIhi8XssVFOkGDk?=
 =?us-ascii?Q?JUhMGBTrUqYRfwt6DVYgz0/5ESqVZYXalBWdTq6/m4YyA/zztUGE+tVwAubu?=
 =?us-ascii?Q?YS7XATCr/7tBtQO0lMbqLO61L7pC1Y/oljTVD41lPCEGxiRq0sxTXx+Z00l0?=
 =?us-ascii?Q?iD6oD8/oTkN0Ycddar3UdkRtSSW6JnHhPlUq5GVSFDa3xEbB9Z2jhgEgAAFK?=
 =?us-ascii?Q?wMOi2jwZJA1BgxgejSyvUPHoJ7W6lML9bZII0GMEKn/Rkt+AgHhQv0EEEtDH?=
 =?us-ascii?Q?q/535BSf8S+g01KEApARLksHl0j4IN+jO97pfb0o6FbvjL3//ecJcHeZFFMA?=
 =?us-ascii?Q?1jHDbTUH2M32ecl7wyTgi5Dx3g2cwe+AXgof86g9wJxFFRYe00iBuVEwSl4C?=
 =?us-ascii?Q?sxnxboqNXjemazmCHxJ8y9NSSZW/CgpYKyClFNpV0UloPHXcvok+T2bK2Dgs?=
 =?us-ascii?Q?zY/n2FqW2srM36nAneXBiFcdvaJYArwytwT1ZCc9A9gWKiXnxZlfX/XJK5RT?=
 =?us-ascii?Q?w4kFdh5KPLWBBe+WLVo7FAttHoPrfvl9P6k7ZyGZK96TSgn5+uwy3j8WLqJp?=
 =?us-ascii?Q?aCwYsBNeiN85XnR40Mqrinl/7HgR+9b90VjL6UZIsKsOFx0tFAdFUm1GYM7C?=
 =?us-ascii?Q?rMLHbjsBuTB2i8EVFr88LBg+RjYeM4ZKGFXwHWg7N5mNbLGIk5M7LhVvfUcG?=
 =?us-ascii?Q?pocioU+lJZQmrAZpmApjSZz+I3JB7XNRUV1eSilj40O9v+KbGih+c3Q83plB?=
 =?us-ascii?Q?xtXHqSGYFzeNoJdAw1DL5v4c22W87SSLgY1li5WikENs82iQHY1j9DZaYygU?=
 =?us-ascii?Q?rKosvpOx/qQdBLCeEJCLwJ2vi0QKo7FTqt4QQZMZgfTB9dPscPmrqMky6QYJ?=
 =?us-ascii?Q?F30Fn5wsB8I2ae62gUsI4NgHfK378V//n96ScPtnI3nt8gcW9bhkuof0B0h3?=
 =?us-ascii?Q?Fi4/LcP+/b6abGqhM/+/VWq3/6vB2Dg/QSLMx2WLFZ2Vl2Ux+z0fNJogkApg?=
 =?us-ascii?Q?ujfTv6vVt8Fer/6i/ko5WfgoWX8fbB79IGQTOMR2ivmv0Bqi9NXQF6/aTjQg?=
 =?us-ascii?Q?mca1bHsLFjX8Er17fY65vPIedruROJj1f6dgMNXSSVtrvAOgg+zz+DcLwj0H?=
 =?us-ascii?Q?jXpV1JnaAfCbfJi1R1ggz6dsDdE8gPv0miZ21ySU3HNjf9hc7aGtgendMOoW?=
 =?us-ascii?Q?DSsZsNAqvoaRYk2jwdyHxKqBoH+Z3g6IJUvZGPvk5vci8FRzEbiYigo8cVLH?=
 =?us-ascii?Q?A6mh/93JtzQSVPQ1pFYUgRdxzK5oJOi4OliIiJ0UJt69Kraxiritk/EMtNSl?=
 =?us-ascii?Q?koQl/0pigSfUtqoFu1Cu5w11Oo48/bqXMC47wFxPRewtIw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ffa4db-15d3-499f-a894-08d9942765ba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 00:11:58.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jane.chu@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2759
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210000
X-Proofpoint-GUID: 2GNaifIXaztcZirYLUBeXCikFjLzvFMM
X-Proofpoint-ORIG-GUID: 2GNaifIXaztcZirYLUBeXCikFjLzvFMM
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When DAXDEV_F_RECOVERY flag is set, pmem_copy_to_iter() shall read
as much data as possible up till the first poisoned page is
encountered, and pmem_copy_from_iter() shall try to clear poison(s)
within the page aligned range prior to writing.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 72 ++++++++++++++++++++++++++++++++++++++++---
 fs/dax.c              |  5 +++
 2 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index e2a1c35108cd..c456f84d2f6f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -305,21 +305,83 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
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
+ * However with the introduction of DAXDEV_F_RECOVERY, the 'read'/'write'
+ * range may contain poison(s), so the functions perform explicit check
+ * on poison, and 'read' end up fetching only non-poisoned page(s) up
+ * till  the first poison is encountered while 'write' require the range
+ * is page aligned in order to restore the poisoned page's memory type
+ * back to "rw" after clearing the poison(s).
+ * In the event of poison related failure, (size_t) -EIO is returned and
+ * caller may check the return value after casting it to (ssize_t).
  */
 static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
+	phys_addr_t pmem_off;
+	size_t len, lead_off;
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+	struct device *dev = pmem->bb.dev;
+
+	if (flags & DAXDEV_F_RECOVERY) {
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
+					BLK_STS_OK)
+				return (size_t) -EIO;
+		}
+	}
+
 	return _copy_from_iter_flushcache(addr, bytes, i);
 }
 
 static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 	void *addr, size_t bytes, struct iov_iter *i, unsigned long flags)
 {
-	return _copy_mc_to_iter(addr, bytes, i);
+	int num_bad;
+	size_t len, lead_off;
+	unsigned long bad_pfn;
+	bool bad_pmem = false;
+	size_t adj_len = bytes;
+	sector_t sector, first_bad;
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+	struct device *dev = pmem->bb.dev;
+
+	if (flags & DAXDEV_F_RECOVERY) {
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
+					 pgoff);
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
+	return _copy_mc_to_iter(addr, adj_len, i);
 }
 
 static const struct dax_operations pmem_dax_ops = {
diff --git a/fs/dax.c b/fs/dax.c
index 69433c6cd6c4..b9286668dc46 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1246,6 +1246,11 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
 					map_len, iter, dax_flag);
 
+		if ((ssize_t)xfer == -EIO) {
+			ret = -EIO;
+			break;
+		}
+
 		pos += xfer;
 		length -= xfer;
 		done += xfer;
-- 
2.18.4


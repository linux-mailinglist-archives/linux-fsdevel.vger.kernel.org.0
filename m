Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B049D442
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 22:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiAZVMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 16:12:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51726 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbiAZVMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:12:09 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKZF5X011980;
        Wed, 26 Jan 2022 21:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YNdmcW56aleJoC16aj/By1K5R67/T3TMnT3Wjs2Vhpc=;
 b=fg0VkXb6/1HZCdK9s57f++Tmzl0uW7b61jMP+H3qzQLFLHa6N/5HIJ9UlCaEySTAtjOQ
 BRwz2iBqmZeErZ3l6kUfO7U/aHpfcdv+6au9S+YwBIPgf8jtQMZsmDNmlDgaof+QVTR6
 DmhPNfHDEbQqbrQeVYzVYuwQ+k9KkR0LRlYec7Wx2UwUkkAuOagznsRqVtqnHfqG3oNM
 OJbBCFDDn5rs/O2fPibnRV2SiqHFM0IRoSkzt6XaY+K81/tD3hPr+/GufOvjDf61i+8M
 8QKAAkgn41t/Op0ZePUT5K4BC5kIz/n2NNS/JJ5d16vbWTN/afC9euKExeVtVT7jfgQX ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaaf95x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:11:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QL72lQ016295;
        Wed, 26 Jan 2022 21:11:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3dr7220b16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:11:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RayrrZ99J+Q/P1zcp9Lm5mVlhdhjobAgBDOmoelJcHiOqKrqf7MQ2Rog/Y2jJLSMb2NrHmILWgCu4QK6kOKYKcP82bqZRcoGs4o+4iX7ubNP8oZcTjeYHpnonc531fu2J+jXnGZFA6hQO7t0FezXHbY51zydLrNYm4clfwlG8PLDDo73hKOKCObNqL959pUJ74bBJY6A91PyKW/w93m/TpjS/0WNwpnH+Ock8q99jz5cBDqtAd7MOVeqJOo7SXo3s6sDY1iYpu3u5Zqxo0d5RRWohK+Dr87m0Ye1LhXV1AHDZIVJ2MXO6yP3cRnPzoYnI4hpwtlAcoo45knagm/Etw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNdmcW56aleJoC16aj/By1K5R67/T3TMnT3Wjs2Vhpc=;
 b=HS6YSh/zar5m5CDNcewnxG0713FYsYqUjCxA33o3HBjPPz+socoOfC5fB/f60UyjDyfP4aDxuTI2USEp1MMwmroRuoLlbLQtgc3Haef7uZfpq8SyNXkbDNHnLwfa9lHSRduawN5GxBaU5UR6Hk3TC1QmI/oDtzyJjkK/bg1hJMNzRrSazlvkk42nXq7KKlqRhI/VgMTZuRzcbcBZN8L521iwmy3daWc1frRBUYyB6hKSspzT7PqeUN2snh66yoIjQUTohiMJWgZGuC3j4QpEVAa7OdmjCVotnAXqqygJSe3ahcRAXoqK07ZDkdleScs2fwZFnaJHu44j5crES9Sa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNdmcW56aleJoC16aj/By1K5R67/T3TMnT3Wjs2Vhpc=;
 b=LOS1BoxlvlgwsFA0TP8YOVk7nQkJ8J7yLKpgG1AvHrCqMYRmA5+MmPhTynX+FlnUbuAP5pN0hn9ExI8YpH4ntZfLYFcjBQeu+IWocBrvTZCXem0GnA3M8dS4OfEXJ95kMB6qRGX4qNoPTn2MBQQeiFWB6Zr/C1Q9uuFwwz/Eqxc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BL0PR10MB3044.namprd10.prod.outlook.com (2603:10b6:208:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 21:11:53 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 21:11:53 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v4 6/7] dax: add recovery_write to dax_iomap_iter in failure path
Date:   Wed, 26 Jan 2022 14:11:15 -0700
Message-Id: <20220126211116.860012-7-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126211116.860012-1-jane.chu@oracle.com>
References: <20220126211116.860012-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:806:24::27) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27cbd4cb-d671-4e36-ee51-08d9e11079f3
X-MS-TrafficTypeDiagnostic: BL0PR10MB3044:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB3044197B91626BBC5C63BCEFF3209@BL0PR10MB3044.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uj15tosVqqVeO22TocfR2zps4usq1fVP7u4PTj3c1Ta165KtZypEoGJhLT99xhMnSJAX3m7mcA5WKbaWdJOqZ3/h2lFDUJLGTOPeY+B2OIf6vAIXTBpVUlH82y4Ajx5ndILTJCiMWmbP52PwNTgSredRnELDBWrkZrLhXoszdX7jg87cnFv2Ia1t/fjvEvwDrqSKHPF3jjgXHe6B7Gj/GwJLAPsJqqwdLPJMLxzBue7o/LMxHJryLzYwEDrcS3HBANWZLyEfZM+epQldeNsnSnX6NlxMVcZm3cgVq+7cvzUXsojrDdqQ48cM7DJrJyVQ1PShh595YaRflnaMF3nlGcOVts18Q4cHBOtIPxP9pa6lUiD8wndOi675FZpU53vWV9iIVadi52Fr3SNscPo+1p2rzHiT88v5kTFGnhtudf+WEiJF9PdLhWKJ7qSC2eSg2eiB1m7DY5M2cyNO0jpX8C7dhZzixYgLEFfcm/dcZehKYyC7xz123NlMsdv1BlEMoHqAsVEksBQ74+kz+MbKT8ueSCD6CZPljGlD/igklHl6Tgfz2fp+h5hS1DEsioOA8pLQg0vy2vwFQrDQMygfHod5EvhBaL8h9iTCo/9n0DaR4JCqiYS4EBkGpM6pe1vJGnW4CjM+oI0ymdE8FJ2qciOxWaL3v0NyEAwvOyh3SJfsykHn5sx1LMZ6ZQ8hBpRW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8676002)(36756003)(86362001)(1076003)(52116002)(83380400001)(921005)(7416002)(8936002)(2906002)(6666004)(186003)(508600001)(6486002)(5660300002)(44832011)(6506007)(2616005)(6512007)(66476007)(66946007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prqTXOVcPFpTNupPz0KxL9HvwqelE2Jep3xLv4OP/sFImGWQIQY1aPW+bKuc?=
 =?us-ascii?Q?KOlmvbykAuTcN2b9ClfHm9MTzDcNegjOnrk372w/ch7WlKWDn7Wq+NKV65CV?=
 =?us-ascii?Q?rErMTuy+I57kN+kZzyBoEDa9TGJLI9/jLe9z9trq/ROn3rU8rap30BhuScIP?=
 =?us-ascii?Q?lqHPkDpS+qGx46rxnIvIshVpB4jv0pATEbQteCfkKSbo44oLWemv/+dIbEOV?=
 =?us-ascii?Q?cA4nd7iBcp3cmS37LnXMhe32hwVA4cTOIbH19hCvCm6i9NPami/Ctb49ZixZ?=
 =?us-ascii?Q?bsZ9eVuAuz8iJ5YNJ/KRGsUuFK+VhgdZ+T7rYp1z0QTxnqn60rIhOZT1eC86?=
 =?us-ascii?Q?dwY+thux/ibxxFFBFqAuJzLvnBX0jcCYouHrdPRQfzsVy6kLli2C9US5jfHk?=
 =?us-ascii?Q?Iqv2S2PRh/GvlL6GL5NOcw4tP+VrcXovx0UUIT1KZRYh/+9fSN8trTz1bV85?=
 =?us-ascii?Q?ixXou7KVNd2n7cgb/c4O08ww+CwLMSd3Wt0w5YlGAwH814nURESFFH945m7e?=
 =?us-ascii?Q?i9fOB9Qp89T8KfUpNNpGf4AvQgTNJhOOKqOkdhgy2C2lU/0RRTahCy4qO2/B?=
 =?us-ascii?Q?TJ6vWEhyfaiBmMdHfkxaK6R71YQAATmy0FnAnWwyB91QPDyNoCzkXicd9YIR?=
 =?us-ascii?Q?J5tzgZjAiMT26L22/cg5yGpWPLCzIE5+FLGWqXKi6Oq2enyj1OGbdGqlcPCD?=
 =?us-ascii?Q?v/yGnbjR8cWpP24kJOxeHuAmWPyVIuFJ4SyG7E56S9K1JFkYgvwf70H2eSE7?=
 =?us-ascii?Q?3zjycqAkVXCjyFySnunc/JfXmPUL8s0gEPT7wmMt9fHoWR7a7OlIVSWXPrDM?=
 =?us-ascii?Q?YsvdDsPmNUs3r4aSfUKrEgBd4Rq6Vi2wlwAdbOHE5TFdGplrAFHBTIRpMo5n?=
 =?us-ascii?Q?NAZz2BLcnrhDpKx4joVVTfj3Yov6XE0bkOyZVDkQed5YNxZmxKFDQ5Gl8WWx?=
 =?us-ascii?Q?Y1JFUO8MmhEKxkYHZyA2jfwARCn1I3bEBd6SEoFLRD68b6ekEyAE1YaZADuN?=
 =?us-ascii?Q?SMKu2Y2aBVnyEr75UQLj6WaxRnRYMj0lD0m9FcP1uokC0vEqyjIVUiJKDtT6?=
 =?us-ascii?Q?x60mP5YovLgQYdGK6jczBepJ5mQYaatzZCeQPBIouzdwAjeuB5SOG9bOOXci?=
 =?us-ascii?Q?3buHWcv0j7JtRpQfnuNJhbZmOda44zTDxuVyQGqZ5NLz0YGWz/PnxW1E8zF8?=
 =?us-ascii?Q?5J5XiWNGhoBsLwX4evNO+0lWpJ1qFPLNnAqgSj6Umn1Kpzm1ZEHi42BhQx0j?=
 =?us-ascii?Q?Ynf/RsR8yWGibk74BrAntyVgI1lynDlSIyVuwfyavtjNrGOyTrcU3AchU0r1?=
 =?us-ascii?Q?5/4/ct/914WstdXLTQ7/AvZ7h1h9Uqq7upT010X1KI8F6XcTTUbGrPO5+JAa?=
 =?us-ascii?Q?s1Svfs/dKHAwEOnvYUMKPdUdsR2wjH17Ns2DfQX0zJjyv9oj5RqFw/8VqFDq?=
 =?us-ascii?Q?Tt51p6AFO2uh1iWHFMSUNQTS+sOV8emnzP/o3TMKEw6BR0dGB/jP8WBgKEuo?=
 =?us-ascii?Q?9xLQskg3/V0ykkJ1EvEexDnsJ/EoXBWJhWolG6OOpuCbImh4ZN65iCIzC++i?=
 =?us-ascii?Q?YFvoF86WjIIMIh8wwXBxY4lNAfw39IYYHMtWZWFimLcXPv6Z535SRD8+iN/z?=
 =?us-ascii?Q?xgP+XoqFxcFrZbt6URsl69schx4gJQl+3fgc6ad26lDc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cbd4cb-d671-4e36-ee51-08d9e11079f3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 21:11:53.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX107dEI9safjv/ts2u6fifTTPbEt46Xy3ogcDE0UOsZENVm0lDkSGLdnZ6a6yAe6NZXNvswEJNMYcXiY9I7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260122
X-Proofpoint-GUID: q24lQjtz-8q50fhX-v_YwNRxVDqnnL-I
X-Proofpoint-ORIG-GUID: q24lQjtz-8q50fhX-v_YwNRxVDqnnL-I
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


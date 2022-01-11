Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95E548B64D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350321AbiAKTAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:00:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3482 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350308AbiAKTAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:00:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BI2LpB027852;
        Tue, 11 Jan 2022 18:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=AXxFQXYyRw+qe3jyXLdF/I63gargUEjxH/mEdBHX4zY=;
 b=qOsAHLvBKJtGKdm8LkkuC/0IrHZTJ+Red957KSY4x55sUP3CUhq910h3rrYvhQAuPAdG
 +NNctHXmHFvof3iJz0iC+VzT0ifixVrxzgFpN3Gt5VXe0nvMrlZvyvUkGtflylTCZ7V2
 CvtQJp6LrteiR2sAkCY18SLf5FjxlGnEq+m9qxnZMRU7cMLUtXMfTrU54qERanfjQd7X
 Iwo1yErJlvPtf9botr0PsuLNHTBY2GLPGTdfsZimLgttACByrlfh9l1HiQO+SFH+AS56
 /UOOG/FdG1LML1faLtHSVxQAcDrhwGg4Hlj7GJS+ARpglebx367aL9TEmWjKVZQvl6Bs lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74bwqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:59:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BIpx74169195;
        Tue, 11 Jan 2022 18:59:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3df2e568wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsT0HtUzBf+Ef+wFfEZt4EINK3iMJWbkKqx+RB8d5kkTaGtcDH1bo+8EuPiBttB19Cgp0u52EoMvtGXS1YWiRqLP8M+PQfD9PcjLlUSxQlbE/2wlsWe0S039ZIxEYD85sdVFLAHYjiB0rirPHcjK266at55L4lpWZ/QC+cb84JNscEnNBil99wBb6UKlpk9OH0nXLxTIU3sZSTRw1fhbubl1aaDgqOIc3EPh9o3HAJ8whb3TEG/chyL2SgUINy1reGPTVqaSA7I8dwSH3YGrD6nri+5kCtMds8oBPQ3+JODmxnbEPIzs6m7fHOCRFa2XpJeDuE3BXsl9TWRvHxX7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXxFQXYyRw+qe3jyXLdF/I63gargUEjxH/mEdBHX4zY=;
 b=AGlbgqL5JG3duZhrQp07pgt7DYFpm3/gxrzKBhXdCN54mYAamNEEohYp7ypx77e2HMdz30rszig6x9GKjg351WZE8EDXDK6wqzXlIOwqFS1xIAxeWyYxa9Ji3zi2BS/Is+hVfT0xULRlYltZLEJQarK18eyNuiXd9KwmNVZ3IWlCpLR9BncjmmCsMIewE09KIHcEXSJmWbpfFtEb01Of2KKckjzcdxFctgHLiAaFlcOGkumpXntIDEuJG9aeWdnx0e6clw59gBEBjAT/FzoasTLNmr3jZABQoaViaF5aiqzl74lOHyKI92yNTkKfscQJK5FNC+kfCspBMR6GMR/o5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXxFQXYyRw+qe3jyXLdF/I63gargUEjxH/mEdBHX4zY=;
 b=SP8SnJzjr7Lxl2/QQ67pLIKlPpmsBq7SsaOKPPS47dwoy0I7h2/ifWJSenPGq2LT3oHDLFiSJOQEduLpcQA8uMV87sAXLp0+l3FKSbyPrueJjxKI7EBdkAlWzujDa40WGjjU/BHBFKfMj9dpRmZ6W0ZQrUQ2rwDClCWcSBJG3RM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 18:59:52 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:59:52 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3 2/7] dax: introduce dax device flag DAXDEV_RECOVERY
Date:   Tue, 11 Jan 2022 11:59:25 -0700
Message-Id: <20220111185930.2601421-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220111185930.2601421-1-jane.chu@oracle.com>
References: <20220111185930.2601421-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6872c48b-9dbf-47d2-7bd5-08d9d5348c7b
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5647:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56473D01873F6F809626C1B8F3519@SJ0PR10MB5647.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZKU0B8f9uS6AiZuco4uz1f8hgjjT4i2RridnoUkBjpdSe+5uCBEiWdlJ+oX8tC24vc0FGINAvP8BrE0LLT73DulNBE11MLwYS5qrGqeKBn9PvqF1SzYiHHtlbDcLkpibTJarbNyICFxDIMM4qTUfTe6OvIdKBkXh4K0DQeDHo47KleYYIUrvnphiISR8zkLbe1UMd8wqwki9sT2xohWZptrMFgJcF8ckfsR+FDe+FiyeY9Nd9fxXisvAku7yaLSYhlccWbZ03iSHNFsAZ3ixUk3ubALgZ4edWaN57hF4NJan5o8HwVS3r8rUX6vvA6KIVj3BbO+SMvUrOn+dxMwKtkUJvKvFp8AqOlAWSjVfeUE9zQ0RDI08at3Eogw5qkBbErSIIVZ+sy3s4bvhoiw1pymgG5KzPSwmuSTcLeROxhQQcmNmnjkn+A5DE4BBn1VuojadPkpMmnV6HRmTyYzK3QEPa2xOd1qw+WwTx5D96ArREf/DxdJre2ayU/xCv3Q2yvzg8ufaHqaRzCjUjeell6BaIt5RAaIvBl73pjax8kKS4RBLcEOpdQ+AgrvqEXJOZgA3/kzQ5AVPljsPQNEj6GrctqPd2u2eDrRS1xDzfR39L8wdvDSWQHKG+A9slrW6Kk9HgpBi3UumJJbnu9RiRlOIk2zjMziWclBavTSPHoNuI0Rb40LYdJsxMpZTb2T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66476007)(508600001)(6512007)(44832011)(66556008)(66946007)(86362001)(83380400001)(1076003)(38100700002)(6486002)(36756003)(316002)(8936002)(6666004)(2616005)(921005)(7416002)(6506007)(2906002)(186003)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/kp/8H/lUfpBP1ZnIj/Rbr03DCJscVM+qZskoHu57XUs4WJihPi8yqJURDbF?=
 =?us-ascii?Q?HNIj7NA2PjPCNQIQ3IaI4dVHFemxQqd9TwpdJarp+Vdw4Rb34CdcDJPxOclS?=
 =?us-ascii?Q?0nbTQbF1wMJbrIsK6MKUYvM0TAgT5r2dMDdcnmHEDawxg1lS9yjowwBs6Jjb?=
 =?us-ascii?Q?or59NTG5EaRx6j63+alt29BStQfks6lsy3nJAoKc9/I8BFQNxB2+8FcegwVM?=
 =?us-ascii?Q?n2xxwAVoZJ/47TWWKKiFt7+kyZvPTVGXCNy9ZgJKhXdewN4ZeP0BbO0EqTqg?=
 =?us-ascii?Q?6f2/Cdz4TiiTNdhgdAXCSaOdZYGZVPHPWLBevj0R2AGIvwukjaTruLFA0KdJ?=
 =?us-ascii?Q?4CND5HByudQ4lhJ1fBvP0gh+eIjfw/s1JyV42pom2uAaQkDP2V3bAAt/+Pty?=
 =?us-ascii?Q?g1kYsKZ0XPxKqmr161fnUXlo4zB7/vR6igB0uAOU63Z2nkgX5BfgtIZS1xyT?=
 =?us-ascii?Q?NJqfV6QUpPljAB4n+PdFL0N5IKpjbgZscoSQvl2hwsn5RIUO/fvlOt/JFB4q?=
 =?us-ascii?Q?A/fxL9VxJ+A+Wneu9RQ80kRXaikTph6/uZQ/WRy+TJLkhHy1MDtrqVTITO4n?=
 =?us-ascii?Q?Tuw2pGe7Oqq1QM6ExJbwXem2CbJSMZ5pIHn3OiJmYMnRgDO2b7dAtEFW1wjf?=
 =?us-ascii?Q?JkBy8SctpyUhnmcjzpZ07M3qO72Ayd0KPRxcfEFSqrHGFPTMX5DW2On5wqmL?=
 =?us-ascii?Q?BxB67wOA/RLMczVwSTvK9gGXMF3df2B6smwJYvP1hVBWdMDCyAZ3oquKrPJL?=
 =?us-ascii?Q?B+NqA7V1MvZPxzbmAjmzKxFg7lIMohfdP80GZMDBpdtkQ/6he2G4lmCxulsf?=
 =?us-ascii?Q?kDrmXPG0DNIDCMlub0ZpZEkmxstM6yaToFOhRdSRTAqHDOiA94h1BOhL2xoH?=
 =?us-ascii?Q?uYzOZmZm2S9pyva/+QH+bz1TuJX/RuPexR48/6KEMUG7KJgYMS8IH4NVU9W0?=
 =?us-ascii?Q?+EbRUkbIuUtYBfWNkSv9EQ5SVr41PNZu2PIcbQlTjRoNNEpb9l+RiOb1NT3N?=
 =?us-ascii?Q?QdQAW4MZcaoI7+Gnlsi5rE5cm8f0DH/8bDaronN7SpmurTVEI88A4KpCdY9+?=
 =?us-ascii?Q?p8SPthhgmaqXAHiDHyr+KvrzTuPtA0lItHHuwsuXyvtI18+l9kxQG4mL00pP?=
 =?us-ascii?Q?emsRmjmCSyZlkD4wT7uUmB2MQgbgo+4gfwcixGS4k7jeNAO1RnloDERI5LmO?=
 =?us-ascii?Q?9y3tifUM9BI9qYtORiQsXbpqn1+4rnNQZzqPPrJkmntEOoNLKwNooDnTjLk1?=
 =?us-ascii?Q?qrao2ytOHNVFs8IgCyguZnL4eamtf63qCw1mFxE9UftT+H1V7QZS/3v/PeNN?=
 =?us-ascii?Q?P8sKDuwX/PF7PDwrs3qpaTxhOGTTFvJZHc1drAGVjTWuyIpd2n4Jv9JAJ/DR?=
 =?us-ascii?Q?ipZm1bf3KVAzTPWc3FkMcs/KE/FpmmQS2g4vwzml2YmjHDacOZ9uMhwHSxFD?=
 =?us-ascii?Q?tJ24cZKjTTHLoiJDrQBZz7Vn53Hkk5QHE3o3w68tkCKFuwBg1iGnil/oLL5V?=
 =?us-ascii?Q?FJ98ohFwPtjbsOxzWH/+EVgFGbCHbvUBX+Oe3OiDYqkXAeooRDVtFnqYl02i?=
 =?us-ascii?Q?H84/DBGPmNlut+vdLha/m16xMiBb6aUtyVgAniNL8dFkkzieGVAT8JY0gOAx?=
 =?us-ascii?Q?DGMnMgfyb3bEQLS4075FSqLmjRLm6judbSh/z026OA5V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6872c48b-9dbf-47d2-7bd5-08d9d5348c7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:59:52.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rhZUh51ZnpVgSPxuHYmohiYJ70tH3ICC3R74RkZp06YrYMtnMzXEPmH6JGih0Sfk72mFnEMrAeAGSIm9wpjoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110101
X-Proofpoint-ORIG-GUID: wv7hQH7Ahn5yg0LCetQHDGm7ICNxwlrh
X-Proofpoint-GUID: wv7hQH7Ahn5yg0LCetQHDGm7ICNxwlrh
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce dax device flag DAXDEV_RECOVERY to indicate a device
that is capable of recoverying from media poison.
For MD raid DAX devices, the capability is allowed for partial
device as oppose to the entire device. And the final poison
detection and repair rely on the provisioning base drivers.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c   | 34 ++++++++++++++++++++++++++++++++++
 drivers/nvdimm/pmem.c |  1 +
 include/linux/dax.h   |  3 +++
 3 files changed, 38 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e7152a6c4cc4..bfb2f5d0921e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -105,6 +105,8 @@ enum dax_device_flags {
 	DAXDEV_WRITE_CACHE,
 	/* flag to check if device supports synchronous flush */
 	DAXDEV_SYNC,
+	/* flag to indicate device capable of poison recovery */
+	DAXDEV_RECOVERY,
 };
 
 /**
@@ -227,6 +229,38 @@ bool dax_alive(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(dax_alive);
 
+/* set by driver */
+/* for md: set if any participant target has the capability */
+void set_dax_recovery(struct dax_device *dax_dev)
+{
+	set_bit(DAXDEV_RECOVERY, &dax_dev->flags);
+}
+EXPORT_SYMBOL_GPL(set_dax_recovery);
+
+/* query by dax, and md drivers, and .... */
+/* can be true for md raid, but untrue for a target within */
+bool dax_recovery_capable(struct dax_device *dax_dev)
+{
+	return test_bit(DAXDEV_RECOVERY, &dax_dev->flags);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_capable);
+
+/* requested by fs */
+/* can be true for md raid, and ought to be true for the target
+ * because kaddr ought to fall into the target which complained
+ * about BB and only pmem do that. however in theory, this could
+ * be true for md but untrue for a target strip
+ */
+int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr)
+{
+	if (dax_recovery_capable(dax_dev)) {
+		set_bit(DAXDEV_RECOVERY, (unsigned long *)kaddr);
+		return 0;
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(dax_prep_recovery);
+
 /*
  * Note, rcu is not protecting the liveness of dax_dev, rcu is ensuring
  * that any fault handlers or operations that might have seen
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4190c8c46ca8..10d7781c6424 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -506,6 +506,7 @@ static int pmem_attach_disk(struct device *dev,
 	if (rc)
 		goto out_cleanup_dax;
 	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
+	set_dax_recovery(dax_dev);
 	pmem->dax_dev = dax_dev;
 
 	rc = device_add_disk(dev, disk, pmem_attribute_groups);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 87ae4c9b1d65..768bb9ae31c1 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -49,6 +49,9 @@ void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool __dax_synchronous(struct dax_device *dax_dev);
+void set_dax_recovery(struct dax_device *dax_dev);
+bool dax_recovery_capable(struct dax_device *dax_dev);
+int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr);
 static inline bool dax_synchronous(struct dax_device *dax_dev)
 {
 	return  __dax_synchronous(dax_dev);
-- 
2.18.4


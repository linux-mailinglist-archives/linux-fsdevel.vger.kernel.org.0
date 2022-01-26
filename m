Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4232949D43E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 22:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiAZVMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 16:12:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1798 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232243AbiAZVME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:12:04 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKZLjN022453;
        Wed, 26 Jan 2022 21:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jojUtbcLCG50ylx9yqExazUQrPPzxIhDmCE2ac6VeZQ=;
 b=JAzgOvznb0xYd8J5wcGfozN3WmcLRBPTQA7LtvMrVTGx5w5uLeNKOOwnULJ1F4v22q5/
 Nf6n9Q1mETEYN+XcVWBQTXZ5nTUTN8VnTf+4Ed1VZNY5Mq9yjTwCmo8PFnhD3wORFuUh
 chQfgCkxFl8nRP4tFI88EScADqQPZHVt0AtrTrjayScLRuQHwWKSXoNeXmAw9qGXFKEA
 qJguiAaKKa4h6p9hcGz8Azbm868Guk4Tjo3Iwz8vyYVviV31aLymrkzVqIRSyJtMZjdJ
 IwTdx3LiM3/wu0GG8bkaFoTxxlp6uHtvmiFK9+DknbSZ5Bf6hjwM9N23eHlqda3PQAhI IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfq3up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:11:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QL72LM016259;
        Wed, 26 Jan 2022 21:11:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3dr7220axh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:11:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxF+KZo7rFsZk/L2+NgJVKF64bFIhxSpTjA1xsb/Iyn6PcBhxUQhMV3/4Wkhgpay2vXhjTiUoW1nLhEVlG5s1MR48u8tdgOn1J5I/iBV2YeLIWX6P7q/H2kDZOzxOgDzW76PDDuJpxF5cx9kOE8jJDGtVPFd29W2mC1GR3GoD26XmXUidOmWK8/8unFabop71ZXOj7naMvn9nAxOI9cPAT5SS5nTIZ1n0I5xx3fkZeY58Te9nLVTXJCsZ2E43OjAr6ArFLhqx5ln1pdCDW/bWycwNcfyrW5fofLdS+sNj5OaKK6CUcznm3BpxkGM34gHd69TlXVJySJ08Uzo5+SZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jojUtbcLCG50ylx9yqExazUQrPPzxIhDmCE2ac6VeZQ=;
 b=BlQYCTIZmNxmVSv35hxbjAtd4P7Yp7AjJZFcOoQ7LTRVzkCTG9tanugprMNoQZ+u4X4jAJtwMVTzmx2mF8tCFV6VsRVn8Br+2W4rMc5R12t5iXW71DrkNR3xeQ8sAus/qhZdQXIxFEv4W2xQL3DmUsfx3sBn7e2PYxO7yS7ePHzg8yqtTDsJitIx/zfhe9DUpiMRDYbq9jurXWuRyxHMc0aktYH5KrUmkUoQG7c6fiExMaGC3ZJrIZoX40Z/0YWdG0TlWDS+bAuK8jo6J2YjpSgnI2LKk4NeMHtyLEa05LVHCiD1cKDodL5cg/oKHCqJnjb+72FtNq8Qp5y0RdAQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jojUtbcLCG50ylx9yqExazUQrPPzxIhDmCE2ac6VeZQ=;
 b=wQkHa8BVou91jk4FmBYcXayYCuUzGPjodG4fQnEEPR+sdZOVGGZ5PMVWYcE19NHAnVj389zeDJvVNG9ZVynME7i4O4Ki9ExQnaoRSQnhTKyi+nK5PtCMJt/AfRC0clyMbf7iD8M/R+wxR5JXjKV0DF+Zg5pQ7TtNjY/RLJFkQB8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BL0PR10MB3044.namprd10.prod.outlook.com (2603:10b6:208:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 21:11:46 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 21:11:46 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v4 4/7] dax: add dax_recovery_write to dax_op and dm target type
Date:   Wed, 26 Jan 2022 14:11:13 -0700
Message-Id: <20220126211116.860012-5-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126211116.860012-1-jane.chu@oracle.com>
References: <20220126211116.860012-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:806:24::27) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b14d8967-6e38-4e7a-1ea4-08d9e110760f
X-MS-TrafficTypeDiagnostic: BL0PR10MB3044:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB304463663C78144BA8655A3AF3209@BL0PR10MB3044.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cP2zX8XRKVq9YpqYL1SpYh6wrMMm8jD4XBEDqsTGs7r6ZtVh1t4CFGOV9/v5SeMy1dEPWPik+6x14/c2ufq6Yy3veXSED1LggavqxZA4fz7LnMV1E2RtCDibHkaDLvkKHmZCbBN7Hdr6HuTGxpNvuB42+xhGuB9rbdvq3WFZ4jZZdagvBGpjSmWIlW34w5hbZUga7A5BnD7b/MJn6JXzOLjAJCBzTYZ+ukFLsGel6XFAonBnoLYudE/jJkszmbz43C9WRldg/bvG2Es3vf3lpH8el5B6WXwndtgvfw4XaRY2kwkbUd8OdKjqQc4QpSgUkKRggp2nri/NE3qjjky6/eHQg3+H5CikAx+2OR7k7kILZFEeUYkA4RR+tcHKFaE461E8Ak272LWj4j1BieUc2EYqSIw+iRjA0fKQ7DOQbN4P4+0vAIPvjN+Vp8da7WzmqVMSPPTFd+xmX6jrJp6szaZzrEK3RBt/845KN40p/TvxdrdgHCfXdQjPwL/znDX3IHLuxdMUiABggE5MamdA3vaOP6c7gWhqyF8vkWBYa/U5Ln3oY7YPFhSw8kym/oZixTipZvvaJWhg3/VlCwJhIEPDgfx06+Sd2mnbx1Zbrcz/RuQhjEq1bbZ9YLg3DPO6xGgb/ZSo/Nn2ExdWGg6q+b9C/O+YHo9XOVGMKkpKGxVCRuEoyV9trRwmop11xf90
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8676002)(36756003)(86362001)(1076003)(52116002)(83380400001)(921005)(7416002)(8936002)(2906002)(6666004)(186003)(508600001)(6486002)(5660300002)(44832011)(6506007)(2616005)(6512007)(66476007)(66946007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxX3tarjO0u5quYHpCGSbfaPlQ6gbNKZIn4K4UT021Hxr6p9+FGSHw15ywAn?=
 =?us-ascii?Q?ukzzMwDOUp4K7kFWyE1ZsO/GHwYo/5gNJtjQadDTNr2D5QYwrdn9/5yXf67X?=
 =?us-ascii?Q?V3ef4yAAMpnGIoWFKNIZ62kuwWtwJqtUkLOie7BeDlz+J/z8WN1nP30e0iw9?=
 =?us-ascii?Q?T5PL+YKdfFRoosP5REXL1kwiq4PvjBOUqYCLHYXp6QiBljwMUE5hr50GGfEB?=
 =?us-ascii?Q?ygnalTAY+D+EUR3uNGpi0VgXAJ+l0edhDHV9zRzbB6co4zVPUd8fRYMFR4CE?=
 =?us-ascii?Q?1gu8xR/gxFBG/uOvAOjy+i6t372a1U0jEoXYZrLMIV8iC3rPhSSlvJMyEtOl?=
 =?us-ascii?Q?5xDZUU7XmU3fReoHx9DQHduJ+rXQF3TCp0ars9rvUzWDBwtsNjNdwy7d98E/?=
 =?us-ascii?Q?m0YJQNF4LDDfE+6Ws14NTFDc9QDq3CKKFCFmjiuu65fR8k1c0nQfFhoTSwU5?=
 =?us-ascii?Q?XqNWX4fW0rWJedaKP7stPV/+ok9PWVS64scF1n8epnmevbez+KguY77x0fSP?=
 =?us-ascii?Q?ZwPH9+Sqiv6PCber54/rzOolPNgJhVEI3gRry6CHAYO9GNkdncM9BNJe95s7?=
 =?us-ascii?Q?DksnvoylYnwQHtcMoiKDRiiIj5cKYjTvvGgZuvd2V/O4c1oAP3+WK8JJmUyh?=
 =?us-ascii?Q?Qd+HksZGR4jmfCG7JYfHrunEICPB8J9NSYSOKPlpJnYzAAitNinhEj92VdpF?=
 =?us-ascii?Q?TO+pHdvmsqFTzJSDRg6Jqugo663FuFN+fosaAx0ca5r7wA6wBQ/ZYdYFQTjp?=
 =?us-ascii?Q?2SYG99nveFHr2nbo/3kSyGYK/9oRaBZNQRIK8aKggZnQl5L9UdbBOMKJQunO?=
 =?us-ascii?Q?+UOo419Y13bSlR/ROvja0brjALkm1fnAfPwIK0H2Hh1cQ9fYWqaUjRDbLDw9?=
 =?us-ascii?Q?tcbzTXW0TpP3Q452ZImxCff3JvFDmIPZrMLXQKQgoG4yDa3Ny+PnHgdeKJVD?=
 =?us-ascii?Q?OUtg5wUYoWTQ1yGTKCj7U67UZ+SRhRL+h0yVRHknJt18Bg1FtAjLirpnyvah?=
 =?us-ascii?Q?MdadswFeqJwk2MhoCuM4J0uleXfSIs6o3LdhAJGLgGOnQs/daez+KJ+u7GD7?=
 =?us-ascii?Q?3WbQ9JNuQQC9p7RrZegrG7SfnDXMntCiQp4g+HA9ukSCVgq9miaDn6n3QL/Y?=
 =?us-ascii?Q?vFTfIF4i2B4I7yZK+zZj2RijIpoOA0cpKwKolpREBZHHnX2A9+5WUqskpci4?=
 =?us-ascii?Q?bk8mFRF3n8L7Feq7W66M6rFr5fxqLkQB/H5hYlN6ILbTDUS4IJHdVehHEvNX?=
 =?us-ascii?Q?eH8jUcwk0nRpBt7x7uFjZ97/3MV6k+Jir4tHwR02BzOGU+88USPY9UHnoYkh?=
 =?us-ascii?Q?BorXHTO0dXHL2BAvYD/aT1D02z80Oyl06wA09evcxDxR6nbXvGg3SkOdqP0J?=
 =?us-ascii?Q?/hpLg+m1yRjIsMHeqtLG+cKcsxDCo9QmkT27WI9MfjISGhyiWfUkBJC9x4Af?=
 =?us-ascii?Q?qrMhJd9ZH2/rsPmnpdI0JKklO/cAjJWOIx7tBN/niyuIicV9bM9Ly7bRDVrY?=
 =?us-ascii?Q?IIs9YJbbgmo9/MH6L4CSgpZA9HfaN3F8ty3dwsIv7y1zzbSHXZHSOeiMI886?=
 =?us-ascii?Q?JxRkx8bWrJxySA7Jp4Vm+NYPgsAAMVl3pEiwtC87NOaGFdBQzE3pBx1ujgAS?=
 =?us-ascii?Q?Bu1IpDn4XXUktvSZqpUAhdA7n/6XnolkLzYX8o1C2AvS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14d8967-6e38-4e7a-1ea4-08d9e110760f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 21:11:46.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCzMIPlVDG0OeM/bmCpzvj+qpqBFvAA+W6rMdmgAiWCaYH5pQXXFMR5B35x39VPEWYXUzOzGi3YccnWpTEYYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260122
X-Proofpoint-GUID: UtpwDzrsMyn7sjlKGB4UXPz_KtZLNZUB
X-Proofpoint-ORIG-GUID: UtpwDzrsMyn7sjlKGB4UXPz_KtZLNZUB
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
 include/linux/dax.h           | 18 ++++++++++++++++++
 include/linux/device-mapper.h |  9 +++++++++
 8 files changed, 115 insertions(+)

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
index 5449a0a81c83..0b4ce58b2659 100644
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
@@ -138,6 +141,9 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t st
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr);
+bool dax_recovery_started(struct dax_device *dax_dev, void **kaddr);
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
+		size_t bytes, struct iov_iter *i);
 #else
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
@@ -170,6 +176,18 @@ static inline int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr)
 {
 	return -EINVAL;
 }
+
+static inline bool dax_recovery_started(struct dax_device *dax_dev,
+			void **kaddr)
+{
+	return false;
+}
+
+static size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	return 0;
+}
 #endif
 
 int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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


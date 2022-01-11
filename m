Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB32D48B650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350360AbiAKTAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:00:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19128 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350327AbiAKTAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:00:21 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BI20pl023216;
        Tue, 11 Jan 2022 19:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=2msqype7/aQ7LOHA5CYvYF8unFqt4ZpqGiAl6zmWNq4=;
 b=Ifue/qXGqAAw+MvCMA13MPcBt1kTIgbs2cMvExgH7VRvpuSBTNja7FvyR3Yci3K07xc3
 dY4hVynu/umEbFwW9T7V7opnv9wfKFs1PrWy4HNzpbrUVZbANq6BpMSEDClCIZ08gDJZ
 hsSeHPjaTFuxKQO9bcVMe7kAYYXev+15h8YP+mKd52hYUHSi067gKsGf/9oKOX5JOsU2
 ki99THG1ZPcUYhkXz2PLWC8Wvd5HMBu15c6jKffBhjlSxPXaNjWf1cnOHx25uDJ2XBkG
 b7u/DZX4OCqPrdwKQgJnj4yYGX3oLvTbp/SZJFhdJIXBYFbZwm1ZdNmG/gsmha7PQRge ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtgcb2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 19:00:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BIpcbw110950;
        Tue, 11 Jan 2022 19:00:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3df42n7d9x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 19:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbj0hMZlsDJrrZHn0Tu9pd0+Lgr9PLvVtQxJguOBPtAES7N/DbPQUla6MmiIaoygHZKbzy+N9l9qFe5nGPef9XBp7HhKhY7J3QpGo4TDzgDHQBTNNY7fhiBIdVcjx46+mt/8KTt4tJq9rb+XhROpSDlHJvuVOYDl+3bxpjOoykkrVAnfOYkIRY/fYbAowQeMxE23CHLYwbw0p6NdlQz3xoyNZoz/LQFLDYxN1rMYGGhJFmnCD1LPfIyLf1NrmvXbSOBcDvwZNOj493R5H9as4GZm18KfN226OxXQqa37ocm5cp4RnOidww/HQahMy4hU5Di1km1njzccbqX0rIlt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2msqype7/aQ7LOHA5CYvYF8unFqt4ZpqGiAl6zmWNq4=;
 b=cy9AoZGQVMVMQenzTgUl9eXX0X0DsxOMncNwBHzhg1OJnhgK5aR8XT17T5C6mO5/qovtNlLxhb/x3UQyot1wJ/y4oZUM6b+nYV9dH1/A1AX0R/mtx+A3HGs/quLz+Fkk6mHNPt3O6H6rlrKYf/WsXngHsFHJsj+1stNM8qH/0hhcJj9Vh5CNbJ2KbWlqJLI4uEmoEdZhZ4ILsaUZj6A9mjELiqaQwUfzTVT26pLVMyRieDDGWCV+N7hrRMX26W5ZhVVaXnRGdsX0n3/idj2T1+T8y/sjVqWZ0yzclz0EVCx+h8K1s5F/BHt0NM77c6bAiq+ut6KbYT7jxa0bqKmNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2msqype7/aQ7LOHA5CYvYF8unFqt4ZpqGiAl6zmWNq4=;
 b=yjBTvk3sCqK61DFBHevPovabMU8cAcufVh4ZBhk7S6KuJjf2yp246FAD2cgSzQeFRaxHrvQ02h3XFZRPzbZOQ+4HA9RC96qRp7GFtt0Sdv8bPhYni+CshKzkzVlXnwMgO7ndpef1b4gbSm/8dMxT1jhiw1qSieCXB0spAt8JXxw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 18:59:58 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:59:58 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3 4/7] dax: add dax_recovery_write to dax_op and dm target type
Date:   Tue, 11 Jan 2022 11:59:27 -0700
Message-Id: <20220111185930.2601421-5-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220111185930.2601421-1-jane.chu@oracle.com>
References: <20220111185930.2601421-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a721fa54-670d-41f1-23bd-08d9d5348f9f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5647:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56470660D89A0CEF594C14C0F3519@SJ0PR10MB5647.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVPQiQg43pHekpT2PeqzyQlCOET7eg8HfzabQCQycETyOCcj+42CA3L3H1XG0swlsDC+ZBDCqu5PAD3lniP8AZHC02sDQhuDNEu66D2x4e2BWFiZH6b0Xx5rCYrQyXD1PDpqNH44moIoObe0O9Y8QOmEQLWVJXI3gmcwOuSr4PWAjXEIAXILKuFYtl+5PbLpV4t8mRPoXkjmQPGfcBB7pArI9KYZqjNI+Iq6J5/sybmpBlvbMW0J4E9Yvg8J1An+NIUefZf3AusaEAfQgIhM3WUL1cx7xOZezHgyB5b5+uZFHie8DMhRyhlBgpk2rPzvP3gAVkjTgvMSymDLmBhJI5R6ZQidvEWlAuoRF94xdDB9RGsHxqodgv3lmS6zRjKUHUTHzMQBIvYodTnvw/5HWHZWqbPOphMuv0kUm6FwvLaX4MsynADd5djKXyH3nOlwVWwLkSaYUZqpYvSuIjv4xxFE5YCZPfVOb8iaUTBY61qSkHYbFhw7n7Fw8XA4edkaxqOqSdrZOJ5ujNZt0uddZiwxgVUIMFop9PqfMZEOc8UMeO50lO5aSB5InUgovTgpEhbS2m675My+jLop4cJ8+59DQS+50f5V67B0gK1OtfXrzJRT/0EqwDcxseuqztn0H5bxVmgnohyDe5GF3Yf9SNnQtdHQi6ORFgS65XV9e+Hdb8VW5ifowAQTFSTOaS7l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66476007)(508600001)(6512007)(44832011)(66556008)(66946007)(86362001)(83380400001)(1076003)(38100700002)(6486002)(36756003)(316002)(8936002)(6666004)(2616005)(921005)(7416002)(6506007)(2906002)(186003)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7bPbTokppciK+3K3mEvbVG7lx9IzoeUkWPvHn+DwBSPzEBST2ggFVBmmEut?=
 =?us-ascii?Q?PJ2Lw2sPrjQ5gAqspStPWKWl/vt6gnrVPNAWOOF0MXCvmwN7C2vDeYv4n6wi?=
 =?us-ascii?Q?IQ30L3E2MKJ0sAB2u0M2aOXjdjD8YolMdlx9HSmluDmFpDVnWCwRRiKn7Kzq?=
 =?us-ascii?Q?xMPjVTNqzALYO0uMYWBUM7XPcOgmrW8Nyt1vH7OwdwePli71KGyNEyPnO7dX?=
 =?us-ascii?Q?LZLl05XoxNh6vhXpnKTzHhTVgeas0UV+MkYMVNY6nqGdPpzlgv++tW4sjLX6?=
 =?us-ascii?Q?JS1q0PM2u8xKKDWyxTHdbYvupAz9kSWbz1Rt+sOMTCXkjHvczDDaAXRFMu4X?=
 =?us-ascii?Q?DBYrz29PgIX0Ilh3ujakyCOnkWSppu9YvSGHvAVBIxXn6f83RnLeHxkMIyjQ?=
 =?us-ascii?Q?fRwv1GmgbvYC+QqDhq0fTjsqRkfWY+qxQpjqlrWUXcUxni9F2mVK+8OEh5Ko?=
 =?us-ascii?Q?KZk3jl4f5YdQKXcJlTNIeJIDLp5EHflNz9V3GAHjwC/poy6P1DPhrfR1qSWs?=
 =?us-ascii?Q?KuyibhcvvwX95Ej3ZPhrh79blxSnsnl76nwVSiadYQUEikJLRrkCItuauJv4?=
 =?us-ascii?Q?TU4Px+8DAd7Ln3WnSQ1VGiQHURcobyjeQVWdTDCrR/2HoIcULiWcjK2lwP5x?=
 =?us-ascii?Q?AAK11qwZyIGp3nxVPhKhvWXZERH/ARQYdpwL6Vl98hXHyDFRgWzzv+eGPXyv?=
 =?us-ascii?Q?8eWmdILVaMnNFtTRBEx8Yut1lCcLmKNGg4l6fq3O3WBvH5Z8myoy3Q6Dtu1i?=
 =?us-ascii?Q?62+jqWdn2l8m0lCDKydNUjzUczt/7IQ6Zk+J30+GZ9V0iQVqQH46Fk3NR+1h?=
 =?us-ascii?Q?WHq4R6XjZmsIyYkVvZal5pFFkFXNN/r2xzvj58reXVERvKXhw9zks3F+87WJ?=
 =?us-ascii?Q?8L3AxfJY6PfhcyBGK6I1T01s/9tf1hoHZIEEn3dYLTgcFyvoyQ0qD+9GkTh6?=
 =?us-ascii?Q?xchsgvkLBQ7rNsmKaw3azBYz5gpaARXziVZlW3RrJW0WdUk+G0OO33ZPN0wz?=
 =?us-ascii?Q?p+K5nSZxMJnGFsYsW/Jct7ygSoemd571UEen3+pQbWiVrz9rGFqAvk/sKnx8?=
 =?us-ascii?Q?QurwayS2684gnSzth6Skp7K63yHW7Y1u5xiL49VkKeEuWEwEu3dtR7ITVOza?=
 =?us-ascii?Q?p/NRnEcBX+X+O8JqhTqtbE7vULlogXsAVD2+7e4r/ZbBu4Un13Oe6pcy+w9K?=
 =?us-ascii?Q?GStKsIHxEU+wYouVnokGixsPFecZo1NA+H5Uqo+ku1g9FVioeFcFACo1Y1qN?=
 =?us-ascii?Q?NgA9VZg0b6ss9be4SbeB8fdLJowchY4gLNfq4MlNcR6FcQi89ayP9srRZ4Nb?=
 =?us-ascii?Q?Bm77axLI1joYrLcfN28XOXPAXUiasY+fwTpZ8itA7GZfut92D49pPg695KyD?=
 =?us-ascii?Q?Ev+7D+WFLj6R/22hToEhx4iZ62rg0vt/FbyBVq1NGw84GnkgDX5XXzseV+VD?=
 =?us-ascii?Q?KIj1yVUvNFSKm3jd5m7S1r7NNbT9QboUEc98QXljLIZntBL4PY0+hSx5cTtF?=
 =?us-ascii?Q?XAx7+OMdQmNLmbg1JoKEo6yYnK3knh6WVAC7OzlmkWDnFvp0BqofNCknjL+7?=
 =?us-ascii?Q?Q9B+pTN6nJ5CYXGorIfO7QiYq5TvjBl1QpTv8uoPyxlVaSNWGYADM/TpTlPm?=
 =?us-ascii?Q?j7vuV+4C9tzFkH+otgiauzU3hQ0fn2biuGiszIV9awnQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a721fa54-670d-41f1-23bd-08d9d5348f9f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:59:57.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTFHIM2kPVl5p8S3YvX6eZfR1SytdOP/HyJyZmwfx/oxTTIvCiEky5vPlsTkT3Hb+mlx+pJf5oGWWztMj6KeBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110101
X-Proofpoint-GUID: GeMyAZSBlAIXSIlWyQoVBnMHjHnndsAN
X-Proofpoint-ORIG-GUID: GeMyAZSBlAIXSIlWyQoVBnMHjHnndsAN
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
 drivers/dax/super.c           | 19 +++++++++++++++++++
 drivers/md/dm-linear.c        | 13 +++++++++++++
 drivers/md/dm-log-writes.c    | 14 ++++++++++++++
 drivers/md/dm-stripe.c        | 13 +++++++++++++
 drivers/md/dm.c               | 27 +++++++++++++++++++++++++++
 drivers/nvdimm/pmem.c         |  7 +++++++
 include/linux/dax.h           |  6 ++++++
 include/linux/device-mapper.h |  3 +++
 8 files changed, 102 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index bfb2f5d0921e..84560173f1f0 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -162,6 +162,16 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 }
 EXPORT_SYMBOL_GPL(dax_copy_to_iter);
 
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
+		size_t bytes, struct iov_iter *i)
+{
+	if (!dax_recovery_capable(dax_dev) || !dax_dev->ops->recovery_write)
+		return (size_t)-EOPNOTSUPP;
+
+	return dax_dev->ops->recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_write);
+
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages)
 {
@@ -261,6 +271,15 @@ int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr)
 }
 EXPORT_SYMBOL_GPL(dax_prep_recovery);
 
+bool dax_recovery_started(struct dax_device *dax_dev, void **kaddr)
+{
+	if (!kaddr || !dax_recovery_capable(dax_dev))
+		return false;
+
+	return test_bit(DAXDEV_RECOVERY, (unsigned long *)kaddr);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_started);
+
 /*
  * Note, rcu is not protecting the liveness of dax_dev, rcu is ensuring
  * that any fault handlers or operations that might have seen
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 90de42f6743a..b8b558ef9fdd 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -204,11 +204,23 @@ static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
+static size_t linear_dax_recovery_write(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
+
+	if (!dax_recovery_capable(dax_dev))
+		return (size_t) -EOPNOTSUPP;
+
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define linear_dax_direct_access NULL
 #define linear_dax_copy_from_iter NULL
 #define linear_dax_copy_to_iter NULL
 #define linear_dax_zero_page_range NULL
+#define linear_dax_recovery_write NULL
 #endif
 
 static struct target_type linear_target = {
@@ -228,6 +240,7 @@ static struct target_type linear_target = {
 	.dax_copy_from_iter = linear_dax_copy_from_iter,
 	.dax_copy_to_iter = linear_dax_copy_to_iter,
 	.dax_zero_page_range = linear_dax_zero_page_range,
+	.dax_recovery_write = linear_dax_recovery_write,
 };
 
 int __init dm_linear_init(void)
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index cdb22e7a1d0d..6d6402d5ac80 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -1003,11 +1003,24 @@ static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages << PAGE_SHIFT);
 }
 
+static size_t log_writes_dax_recovery_write(struct dm_target *ti,
+					    pgoff_t pgoff, void *addr, size_t bytes,
+					    struct iov_iter *i)
+{
+	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
+
+	if (!dax_recovery_capable(dax_dev))
+		return (size_t) -EOPNOTSUPP;
+
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define log_writes_dax_direct_access NULL
 #define log_writes_dax_copy_from_iter NULL
 #define log_writes_dax_copy_to_iter NULL
 #define log_writes_dax_zero_page_range NULL
+#define log_writes_dax_recovery_write NULL
 #endif
 
 static struct target_type log_writes_target = {
@@ -1027,6 +1040,7 @@ static struct target_type log_writes_target = {
 	.dax_copy_from_iter = log_writes_dax_copy_from_iter,
 	.dax_copy_to_iter = log_writes_dax_copy_to_iter,
 	.dax_zero_page_range = log_writes_dax_zero_page_range,
+	.dax_recovery_write = log_writes_dax_recovery_write,
 };
 
 static int __init dm_log_writes_init(void)
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 50dba3f39274..b3035f32121f 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -348,11 +348,23 @@ static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
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
 #define stripe_dax_copy_from_iter NULL
 #define stripe_dax_copy_to_iter NULL
 #define stripe_dax_zero_page_range NULL
+#define stripe_dax_recovery_write NULL
 #endif
 
 /*
@@ -491,6 +503,7 @@ static struct target_type stripe_target = {
 	.dax_copy_from_iter = stripe_dax_copy_from_iter,
 	.dax_copy_to_iter = stripe_dax_copy_to_iter,
 	.dax_zero_page_range = stripe_dax_zero_page_range,
+	.dax_recovery_write = stripe_dax_recovery_write,
 };
 
 int __init dm_stripe_init(void)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4e997c02bb0a..d4ea3afb918e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1102,6 +1102,32 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 	return ret;
 }
 
+static size_t dm_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+				    void *addr, size_t bytes, struct iov_iter *i)
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
+ out:
+	dm_put_live_table(md, srcu_idx);
+
+	return ret;
+}
+
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  It is
  * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_* zone management
@@ -3027,6 +3053,7 @@ static const struct dax_operations dm_dax_ops = {
 	.copy_from_iter = dm_dax_copy_from_iter,
 	.copy_to_iter = dm_dax_copy_to_iter,
 	.zero_page_range = dm_dax_zero_page_range,
+	.recovery_write = dm_dax_recovery_write,
 };
 
 /*
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 10d7781c6424..a68e7d3ed27e 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -319,11 +319,18 @@ static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 	return _copy_mc_to_iter(addr, bytes, i);
 }
 
+static size_t pmem_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	return 0;
+}
+
 static const struct dax_operations pmem_dax_ops = {
 	.direct_access = pmem_dax_direct_access,
 	.copy_from_iter = pmem_copy_from_iter,
 	.copy_to_iter = pmem_copy_to_iter,
 	.zero_page_range = pmem_dax_zero_page_range,
+	.recovery_write = pmem_recovery_write,
 };
 
 static ssize_t write_cache_show(struct device *dev,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 768bb9ae31c1..7747b8076f6e 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -39,6 +39,9 @@ struct dax_operations {
 			struct iov_iter *);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
+	/* recovery_write: optional operation. */
+	size_t (*recovery_write)(struct dax_device *, pgoff_t, void *, size_t,
+			struct iov_iter *);
 };
 
 #if IS_ENABLED(CONFIG_DAX)
@@ -52,6 +55,7 @@ bool __dax_synchronous(struct dax_device *dax_dev);
 void set_dax_recovery(struct dax_device *dax_dev);
 bool dax_recovery_capable(struct dax_device *dax_dev);
 int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr);
+bool dax_recovery_started(struct dax_device *dax_dev, void **kaddr);
 static inline bool dax_synchronous(struct dax_device *dax_dev)
 {
 	return  __dax_synchronous(dax_dev);
@@ -203,6 +207,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
+		size_t bytes, struct iov_iter *i);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index a7df155ea49b..896c4a18b50d 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -151,6 +151,8 @@ typedef size_t (*dm_dax_copy_iter_fn)(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
+typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i);
 
 void dm_error(const char *message);
 
@@ -203,6 +205,7 @@ struct target_type {
 	dm_dax_copy_iter_fn dax_copy_from_iter;
 	dm_dax_copy_iter_fn dax_copy_to_iter;
 	dm_dax_zero_page_range_fn dax_zero_page_range;
+	dm_dax_recovery_write_fn dax_recovery_write;
 
 	/* For internal device-mapper use. */
 	struct list_head list;
-- 
2.18.4


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3A049D434
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 22:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiAZVME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 16:12:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32578 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232080AbiAZVMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:12:00 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKYohX016830;
        Wed, 26 Jan 2022 21:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HACBNB6Dlbd22EoArX9+ZdfgySBwzu2+nWVxtO7kBp8=;
 b=MAH5MqsYDic8uLdLHCY1b3OBfmO4bMzuJ7zoMbegubb0hGeEuCnNp19BUIHoFAhv98sZ
 2h6lGE6Z+p7DCZe6AFs56Hf0X4vsNKEW/2H0M6ZPdpEELg1EBeSAVw43WToQPvtsnW+Z
 0NdfR/T/9G1ZT78GtRAnjThV3p6pldWzo3ffXny/yusziKDYiA51EJNhYj+0k19k1Dp2
 uMoe5fLYQwqRaT8fp920fFej+jRX7uWLjZ/Egj57JAxrQpBnV99P6GiM89LK9EhmKvJp
 QOuk8gsVlUlZeThrYKlp6xvBZLSS2SrDQy7g3u6V9Bs0WkDRO+rJRirv75X4xDZxwiH1 /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s77su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:11:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QL6Ue9020718;
        Wed, 26 Jan 2022 21:11:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3020.oracle.com with ESMTP id 3drbcrx866-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIOn0s96CyEcacouOftluGugM7r+Y3rVt9GkVAOhIIgnDWPR0Y/rQr5LjdUhRFIOaVy0NlpXw1UHgzf7GppsoLRC6/MwQ1T6WQIff/l4WLp1nIkd3k0rxUp8xBlWkssyVKH5zbiS5jHSULXFxruAd5H7U6yqebFw9adOHhotjcF4brzBfw6E+agV91z/ZWYgKOn+irugthEIC/p11pfRUQ6I6Nrk5ydjgt4ENx56nVvCmq6J0aZ3gYCv4O9cNGj49lrlidnTw2thTZQvWsHcEANw8dmVQRSKuKd2TCs9Tb17d7KCqOGLM/bP5qK0rr0BufmQxYrN0Isq5oflukrrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HACBNB6Dlbd22EoArX9+ZdfgySBwzu2+nWVxtO7kBp8=;
 b=SpdwPcQ88WKvsiW6IWHnWbJHZIAjO3UQ9EGYIAmKndtM0fZE1OaLhCLC/GLS1nxOSIpurlmOcV1uIqMVeMflcBzlfhGja9eua7glBjWZWw1GOVo30nhldNcHQ8o5IZGqo/e1YHFsWyrbYMn9x7urPURY1mBQqlIPToRdvYMGl/9skayFZbRu3qeVIi2wppGA1grLhiox6wZoCeAmFo+UBq+u9i0hN0m8gJFwM59l63OTqjkdW8AVHYG3WLqU8ftV7IF/h8mTf3I0CQU5+jtQEhxODEM2nd1qGcJjqaP9rz5IBi1q4LaxbDNz++0JHCIduZft013zv2bc9BnDKZbJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HACBNB6Dlbd22EoArX9+ZdfgySBwzu2+nWVxtO7kBp8=;
 b=HkfRDgNU6LDw5cykL6TNUxOKbjwRhNW0iyQvmQnfuDsmvvYfkkyJbKj1LwWWHo73CMLlDDdkaHhz/597zEX1jhBJvZbPswFv+owmiEsbZN9EO1hvyx1Vxc9mYfaApoeDzgoa7vtD19u93rEQuv9pQPBUfTtB48ymZqPu1TYi7Os=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM8PR10MB5494.namprd10.prod.outlook.com (2603:10b6:8:21::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Wed, 26 Jan 2022 21:11:43 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 21:11:43 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v4 3/7] dm: make dm aware of target's DAXDEV_RECOVERY capability
Date:   Wed, 26 Jan 2022 14:11:12 -0700
Message-Id: <20220126211116.860012-4-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126211116.860012-1-jane.chu@oracle.com>
References: <20220126211116.860012-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:806:24::27) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9654b01-5e64-4be3-8a6d-08d9e110743b
X-MS-TrafficTypeDiagnostic: DM8PR10MB5494:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB54945C7B2533B1575623097AF3209@DM8PR10MB5494.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7u2fgOv1cQvtFOAc6HvFJ0dR4eZ1ubczcLWLyvILeLj30bsdR3tfiDKP48hygVXcfQYO/UpoZgG8qUDMTIOszFmSbocWaIWFwl6gGmm7EzdcCIMKiTq5tn9mMiZwlD/Wi2vBRJkR2OYW6/w0G+dc5J2oJ7qoIBUcuNKYzvnz7AvCiSpQTjdBkz6uts5kCbbwtzNM9mpn/nCmY4Bzh3J64vatJT6T8AJoPNJ7LBpCSJSjVpqUZpGrbN2SLAuaCusn/yPhs17Pf7ribB2bymNzayHASU7fErHqQp/tmQxtl5BMfxWVTgDqbBFGdicFuGW8xfs7ubFQK6l2xEMqLwhdBunUrq+IFO/JfYr/TgollWT9j2x7JUJ6AMrHu6uBl9LRZx/Wbr/xO7hf7XCY5+34DZASmOy30OyCskOFACIgipiKty2k6wlblqLmu6D9+ChxH8TCPfCjCimoqDMC3XaK4tEQ2qLS8on2xLD/oHuzgqtvfMKYmuHfhYR4M9dMIsKUdjckdKPvlP9ZiMoxnR5uIuBX0p8rFWxJVfvnxzdgWuuCxfNVbTL7nffKimF0m/MpICHnTXjtChRHCVe/pwBw24QEMSCdysuxwGF2h15N4b4n5OEMpgV/9Sz9hnzFL2KnhJNf8EyTvP468YCn/Jn+XpNmcafJZXb7YxR5k2xtFml0158/AU8/vYR/mOOVfDa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(52116002)(86362001)(186003)(8676002)(6666004)(7416002)(6486002)(1076003)(8936002)(921005)(508600001)(6512007)(66476007)(2906002)(6506007)(83380400001)(2616005)(5660300002)(66556008)(36756003)(44832011)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kiMUGc1gJAUG7UuqQvNVUZCiT/0DH4w8QiRT71EW93ofFogfYhugOu/ppMXA?=
 =?us-ascii?Q?1uypfQF2pH0WrNsm4GaRzlJA6wAQdWnPX6Du7t2UiuZWydYehkLaMgWy6Zvm?=
 =?us-ascii?Q?fY7fWdGvLx8kGit6jcQ3yn77Kp7Y961774byFWxta+Khb5xpFkSiDGFiGIky?=
 =?us-ascii?Q?3n5QiuqEkJGc/p+1znKfWjCgbJCOVW6AkCeb0RI4ra5PFg9rOHX4KqLMpBbu?=
 =?us-ascii?Q?sI0Uz/1pakYm6rVZn9nzEPm6Qxo1lojLYc091JaI2ZhQRsMLyaC5O4JwbfUZ?=
 =?us-ascii?Q?UURRpIW672ENMQObqhWZnDuSXegVxq3xZigaKnMcguOUsc0vaOq43DwQa9aQ?=
 =?us-ascii?Q?MO513J13sKGu6PI7/eGb/GFpU48U5lr2FpFsZyHWSMVe2R+BydWZ4hDGaKc1?=
 =?us-ascii?Q?C2JeGYbvIZEjraWLq+b7Ff/NLhQcHsy4kBhJHxUtyHXrits68gSmmg6ez6Bx?=
 =?us-ascii?Q?BKUkEi7m0tVe3FYtUr/6tfc7EF2vEIM+07u1CNueAZEksi60aB5I5XVgJuJv?=
 =?us-ascii?Q?4iaM9HrjXig5lb6tQgmgyJyL3onNmXGe1ejuGBaiwal/0k+a6qIc1xyt+T/r?=
 =?us-ascii?Q?kes1IwkUcuTpOsbOfzIv9N3u2WensOxbIfQ7Jmq/wpaOUHmNsKRaQqJMxBcX?=
 =?us-ascii?Q?1nKnFAKkTCuWaMnNuiJAK4rpS7fg7Hr+2+pjzigH/8TCctKvT8SCkJnDPDHo?=
 =?us-ascii?Q?n9fK6A2STuhEaZaRdTvYQFkJOOgsnExdPAVrHSSFl+Hstnfn+Ly3bsI54+KG?=
 =?us-ascii?Q?JEigIQIr+PumhHGCE/8uwCynJj0NCgGZdgw4086jeWnXa93HOQoN9cpK3dL3?=
 =?us-ascii?Q?5vdh6nNI/0twWywJ37Xy5gA5hrLunbTrGeJ172YZM2qTxqTi7oE6lxLss9C+?=
 =?us-ascii?Q?kpG902U6UhMrXEuoPVv2zeLL9t9Haa6nV7A+Vxrl3zvIwOjrYvC775jmkGjq?=
 =?us-ascii?Q?KwwD0O4c7aFgSwlLk5WN9oDsNYIIIOvLh54glGckhy6SC5RZLubRvYYzHiWx?=
 =?us-ascii?Q?vOgSYcnbF3UswuhvrkHZqxnuV+VLLVXNv7koJrqpJlb0DNipo2d1aZShtrhI?=
 =?us-ascii?Q?nv/sk4OlcQYTsVWSC8PRQfo1ya2SEzc1gbGJke0EHpJzFt2B/QLqSJI2dP1T?=
 =?us-ascii?Q?Zdc9u8wbRj42Jq9cQOBxh2gukJ1ypgeblKvMl3JJkxiZt0Hj+gFBzx+1BOOC?=
 =?us-ascii?Q?+7q6jlGSDdUXpclROlh9KeIlmYYGU1g1zdbytsYj5IKwpAXwWfSB8Eigs9Xk?=
 =?us-ascii?Q?tw+gie8ERJTg6sgGlnCecKPUF94H0V39JdJzJ3/vyjmo2llz1q7fQalf3PXF?=
 =?us-ascii?Q?dfRqjH7LqiPDg5eGCgRisQMzG6ZVmUjnELTbw5ClXOnlIqMVdZPsRwT8L9z1?=
 =?us-ascii?Q?iiv4HfzBRxCjRA3mpUMbBzTCYdkYb3wbh+2ggre8/pBHQiItYLXe1uZnT7QF?=
 =?us-ascii?Q?SwBhCSgLN6YSYUnEpG+bVYaY6edY2tmMFZK8mhFjRZw2WH6JQR70jCjiiSrG?=
 =?us-ascii?Q?u9e/g27JC0lWTFmNwJVs+PReoP1BOUkBxD2Y/MUwkinjeAoGIXV6FE8JnRzK?=
 =?us-ascii?Q?rnaD+GFmw6ldTtbgA1UaH3mF44grqU6iquY+IWmcju1fxors6PdWzP9oDBnr?=
 =?us-ascii?Q?0wre7espXb399Q0irtqIgRtbjejnzUCEgYl5kYG8av4b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9654b01-5e64-4be3-8a6d-08d9e110743b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 21:11:43.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hvojK836zXGyQAPtezFli5M3b2hIH3YppIAEVg6THJVtvlZGWNT5+8F6sHIPmLp27SezcF5z9Xu1Icwe8D1Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5494
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260122
X-Proofpoint-GUID: Lzl3h92bUsjBcfqz76wYdVNlh0HHa5Ii
X-Proofpoint-ORIG-GUID: Lzl3h92bUsjBcfqz76wYdVNlh0HHa5Ii
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If one of the MD raid participating target dax device supports
DAXDEV_RECOVERY, then it'll be declared on the whole that the
MD device is capable of DAXDEV_RECOVERY.
And only when the recovery process reaches to the target driver,
it becomes deterministic whether a certain dax address range
maybe recovered, or not.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/md/dm-table.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e43096cfe9e2..8af8a81b6172 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -844,6 +844,36 @@ static bool dm_table_supports_dax(struct dm_table *t,
 	return true;
 }
 
+/* Check whether device is capable of dax poison recovery */
+static int device_poison_recovery_capable(struct dm_target *ti,
+	struct dm_dev *dev, sector_t start, sector_t len, void *data)
+{
+	if (!dev->dax_dev)
+		return false;
+	return dax_recovery_capable(dev->dax_dev);
+}
+
+static bool dm_table_supports_poison_recovery(struct dm_table *t,
+	iterate_devices_callout_fn func)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	/* Check if any DAX target supports poison recovery */
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->type->direct_access)
+			return false;
+
+		if (ti->type->iterate_devices &&
+		    ti->type->iterate_devices(ti, func, NULL))
+			return true;
+	}
+
+	return false;
+}
+
 static int device_is_rq_stackable(struct dm_target *ti, struct dm_dev *dev,
 				  sector_t start, sector_t len, void *data)
 {
@@ -2014,6 +2044,9 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 		if (dm_table_supports_dax(t, device_not_dax_synchronous_capable))
 			set_dax_synchronous(t->md->dax_dev);
+		if (dm_table_supports_poison_recovery(t,
+					device_poison_recovery_capable))
+			set_dax_recovery(t->md->dax_dev);
 	}
 	else
 		blk_queue_flag_clear(QUEUE_FLAG_DAX, q);
-- 
2.18.4


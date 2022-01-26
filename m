Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E69649D436
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 22:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiAZVME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 16:12:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33066 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232091AbiAZVMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:12:00 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKYcSI012678;
        Wed, 26 Jan 2022 21:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hLaM827GTTNxGwAx2dc3R/WTT0IBXGaIkPOthxJHxQ0=;
 b=uFJfdxkuJ80V1fq6F/sIv+nm/z2+kLehkVG5VpRfIxE//9NOZ5cfJWOE9EYMfBSaYZgF
 fsxjVvIBLwHW+VwekFyoxlUzn8+uUb0Y9LiFprQJ7e2RYzzaMxoEiExmMv2RBzgBEaoI
 4iLUCxG3hCMnS9eD0UFQ1TBx/5mFAl5Nd1FXol1DDeWrftu153RKTj2RGFL3Ibs1IU8m
 xW+SzhPzffPdOdemZ6PbrkTkUdrrl/h+NPj886bBk2T67qz9+0Of7IJp8DPVLWCP9TSE
 lOyI/ElW7aieJWyyHANn1piv1QXZUfOLycJW27GEbaxLoI81UXAUwzmyfQT25XaLB52S Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjfux5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:11:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QL6Ue5020718;
        Wed, 26 Jan 2022 21:11:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3drbcrx82m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQCNC3UwM2opuKpkn81dC6dAlE6DufCu7r3nX92pO5Sdc6huyZCfqlcWKs/Y0/0BbM10zzq0xNbomhEQ7KOxhacx+/fUjQQaKa/XhVgK2TvhrSxx/36/8fMZq0PbWNtxRQW2Ou9LI8YAvxvB7BU5K6pOHk0OS7uU+PJprf/bk0CMZuUeWZqcHm2jIolJ+qU7ZXNjY+d9ZkN1UAYWXDVS9fLc2wqhV/3PMFJ55jPxFbNdP4piXxe5v4TB3n5f38vn2BdTY+x8GUVVYYN7PA9op7KuZao8Hd1bHt/6hSU9iDTKh+vC8/rMGX23LEyWGPAa58ddtws/YL+rTv/mwc/E0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLaM827GTTNxGwAx2dc3R/WTT0IBXGaIkPOthxJHxQ0=;
 b=mKdr0IFobkhEOQILObuXrbKpeuleNqKJkW85tSa7lvEHz6esMNx7ez+LiWkPFshr1gSMAI2BEpGkoafRnGh94ek8boGpjphBsh8y8diZHtEy2HYCFnud1iMQkxB7Ib5K9tKu2GQlwc2CFRByROlY/CeOlNrgBkxpS6bS1GQIbh6CM+TMfP6IZvdf+215yqZYzuhx6m7CQdSPOke5aHrZAF568EFpHZgtlMb8xwLQfunboX9Nv/Daz+Z9nw5GxS7raU9YdVPLE81HKPuUU8vqx0QXB3phULZKtYZP4ChQ0hggshF4gWaPBzzcxljbh44wX2Bdf31M9xEUN9SMh8SJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLaM827GTTNxGwAx2dc3R/WTT0IBXGaIkPOthxJHxQ0=;
 b=c3ksnw/bSq0arR0KEb+nsnKXRnVI2WGMS7JWBQs+Kdnfnj1XFf5UHN+EjSc1XPWVjVSYlLmz4rldtamqu4AtNKe2RuEKf/d5ykBZJcFBbrYMglYGjzbGw/3fatfwOlgwnx/4D0VoIYcCQaNWzAelxVHdcbVyhcSfl2yXU2zhzt4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM8PR10MB5494.namprd10.prod.outlook.com (2603:10b6:8:21::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Wed, 26 Jan 2022 21:11:40 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%4]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 21:11:40 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v4 2/7] dax: introduce dax device flag DAXDEV_RECOVERY
Date:   Wed, 26 Jan 2022 14:11:11 -0700
Message-Id: <20220126211116.860012-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220126211116.860012-1-jane.chu@oracle.com>
References: <20220126211116.860012-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:806:24::27) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b17c1e7-c810-4cff-a655-08d9e110726a
X-MS-TrafficTypeDiagnostic: DM8PR10MB5494:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB54941214A452F1AB32514852F3209@DM8PR10MB5494.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iRqKCRsR6KTldW4/RLjdZCOyL+ri1yx9ZuCGTPgBzbGRNZZHl8HzmpOWc8E8tadCN4P9ilT9tcAjIP2MdsQSnld3nzrYPJzh4jCa1dK7jVr6aAsnZA2dLrnoFAJqtMQP4urbu0imil91wze+S68A6QWpmChQYFwYZunvk/mQi4waFnLz1hwkm5iqVtbXmQ0qckpfXPwJpnRX1c8bvB2+Df+RdY/BtqMpV7Ju2k2oFoW3wsAAv3kLbxroqBiWVzCuVHyaD0G56Cxg8yqJHPi1fpIruMNALJsse0xSseHCVzA4SMhdDcN0IDEXGyV7mGtA8aYeYFPmKZe0BT5HzevbLDBjijMUlVxflLO448t1QtPe2zbRfcv7DVutApHjhI04M9h3xtiSSToCXuKLzIaXkcrE0r727bBuJULhid8Fx56h5+Rf1G0L3mABIB1MI8GYqZ7D0J+H3AfExP2YDvZeaEtkKFycL0ldO5TzVAupamG5D06n/NhKhAe7wiPvNJR77qm6TFMQ6LcIohoexBzwRLHKBsogVaYJENKEdEY+sBB/Ex65SHW2u6b7t9xovxPYTPKANvFVMmSMxl131JyL4q7P5hVNrN7rCEmwFCY7cO4euvrQQWWnatVB14dIyM2nLBE18tdYZiFM0ak5jCiP0XCklZtciLZC2Ih5rluFiq3ENCHOU/sWHy63hc5jGsk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(52116002)(86362001)(186003)(8676002)(6666004)(7416002)(6486002)(1076003)(8936002)(921005)(508600001)(6512007)(66476007)(2906002)(6506007)(83380400001)(2616005)(5660300002)(66556008)(36756003)(44832011)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hLH8/cBwAlhBTcGUFXV7YiS5k2/Ieqh8JU1oK7uxkbiOAs0dwzfDz/SGk48m?=
 =?us-ascii?Q?JkStB+9RPR75Dozl3CXUYtvxCev/1Pq7foDQG+i3VXgGWxTmV3nExUjbCV/r?=
 =?us-ascii?Q?JIBWs8NnolppWZmvJTqQiDk8Gw3MGIZMn7oJlATB3xQ4ak63rsnCNVZcBCJp?=
 =?us-ascii?Q?H8n2kq0KpIhYONkakwFG7PqGEAQ5phAqyREEvts+g4sVPzNQe2gOdKq6DoL+?=
 =?us-ascii?Q?d/BvSJVXdKjr8+wY4zZOHdyJHFJAZe9HMrXi7TPRyC3g15vEP2LhHxElOrNO?=
 =?us-ascii?Q?+hBahsaNF4JHuUPiNUYCN5vIkMp1SAZ15nX29EYHMDfYnj00aMfH7cWIw49C?=
 =?us-ascii?Q?yh2jCEXeN8/Y/JDv/2aHrUXvmrc/ses5I9hpPaIM/Q3uwJ508OYE7o/2OUeL?=
 =?us-ascii?Q?plQfQQveGnXpXOlAsn/OW2dt3JHhd0P9lFAmKosyVWXfPi3LJ03z6/9qPf78?=
 =?us-ascii?Q?7H1eAI2wIQPJOPLglL8WfOgTz+CKM6NoNWKobvsSiSHV1CKsCogDyma/TcQv?=
 =?us-ascii?Q?xTl80WLuF2RiCRvDp8p/b2Tvl0tQaHvAAS0S4r3/ETvdtGJpC4L7oOf/6Zd4?=
 =?us-ascii?Q?Uhq/21Do44k8Hl+M0mChIN3f3B3vumY85O0nvDNYsCxEzkwNJNzCIh0wFZ/m?=
 =?us-ascii?Q?4EQ9BTHHI14zC/62xi9ejeQGMeFocnuDTdKm07nC4WGN5td7aQNELSnBCE+4?=
 =?us-ascii?Q?JGpxPi0uLj+bOPWmdObu+SyUEvgmecfiYXMhIuUL8ppRshPLbdwvVtE6g+Lf?=
 =?us-ascii?Q?iYCcE7T/h3pjKG0NdpCCbzcjlvN7ocMbFg4Tvf/8Bxps09lTbMIMyx/0p+PF?=
 =?us-ascii?Q?gRhoD8sXcYt+Byu6ojTTN0jEsUYEGpO8bDYpmGAyZ2Pb73C/C1WYaMvhHtKf?=
 =?us-ascii?Q?7M7qV4A6/m1ZiT/5bgafBMuGDUO7twVsRTr7A7iaeHEoC0PjeukwfXDI6qGP?=
 =?us-ascii?Q?gO/LsJAj28DXSHjQdVzeCdu1G7avlW6ArQPB8ltu1VUOP4kPDYgLiXe1Oozh?=
 =?us-ascii?Q?qkzkAI+qhH/3GNr436zXxIK93KsOb8LfkAnlHGlpklV/ktD9rzLGRBF6n5l6?=
 =?us-ascii?Q?hM5gzqG1sLuziRfgy6FdfFE8zKN6spXfR0VapZTKJa8WOKPqSQZUBPiT2s0l?=
 =?us-ascii?Q?9p9RF3oNdHbzKS309xjrrwWJT2c6pNS5sI0fBzz5DBXFWWYCY+Xobu5oUDvH?=
 =?us-ascii?Q?qaZBD3He6HfU7e2ZPLlAt7+Sm4UIkls2snIhVze/VB0KnKmQgKeZKHDD6D4U?=
 =?us-ascii?Q?3skw1ydDI5wAnwSvce5a74ofnffWQblO72LupimGfgY2gD3Y1xnVh6Guubf/?=
 =?us-ascii?Q?ZNx14FSqa4njVoSDAsaMnd2yMqVadJlsUwA+KlC5a4kucICptEW/0oHEhu5R?=
 =?us-ascii?Q?V8f3OtP0PE2Uxo/RDs6qvm3+q/0v0w9b7OzLmCtxWkTdT+cPiLGikek+lWqW?=
 =?us-ascii?Q?bH9pS9WOyGof2EafxO7aglSlfDqFCMDJZOo8SXLI1RZR0YI4cFaFAlrlU4d6?=
 =?us-ascii?Q?PcZgRli5/XTASbq2/dHOiMhjJhbSJiIyVEk60Yf5b+EJEViyDduf80RhngkP?=
 =?us-ascii?Q?RX7iBTT/mIS7ekwiiUdRJV8rwKNbPsmAm2Ene7S++l4/Pm2gRilzOKwxkZJB?=
 =?us-ascii?Q?Mu8tLeD4taNwi5zUZ28lcNBIT49PHaHqmSZDsi4lg4Ac?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b17c1e7-c810-4cff-a655-08d9e110726a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 21:11:40.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvlNmQ64RxRCUzCPiwBPfStL44xNXhX3pQts/X/vm5G3pIXjkWky7xDs1gYYdpxlOEGCYAG/ZWc1OMmIEodjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5494
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260122
X-Proofpoint-GUID: W1FyW1TOqGE73TG2ekhmDeOX9a5ByR_K
X-Proofpoint-ORIG-GUID: W1FyW1TOqGE73TG2ekhmDeOX9a5ByR_K
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
 drivers/dax/super.c   | 24 ++++++++++++++++++++++++
 drivers/nvdimm/pmem.c |  1 +
 include/linux/dax.h   | 15 +++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e3029389d809..f4f607d9698b 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -109,6 +109,8 @@ enum dax_device_flags {
 	DAXDEV_NOCACHE,
 	/* handle CPU fetch exceptions during reads */
 	DAXDEV_NOMC,
+	/* flag to indicate device capable of poison recovery */
+	DAXDEV_RECOVERY,
 };
 
 /**
@@ -311,6 +313,28 @@ static void dax_destroy_inode(struct inode *inode)
 			"kill_dax() must be called before final iput()\n");
 }
 
+void set_dax_recovery(struct dax_device *dax_dev)
+{
+	set_bit(DAXDEV_RECOVERY, &dax_dev->flags);
+}
+EXPORT_SYMBOL_GPL(set_dax_recovery);
+
+bool dax_recovery_capable(struct dax_device *dax_dev)
+{
+	return test_bit(DAXDEV_RECOVERY, &dax_dev->flags);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_capable);
+
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
 static const struct super_operations dax_sops = {
 	.statfs = simple_statfs,
 	.alloc_inode = dax_alloc_inode,
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 58d95242a836..e8823813a8df 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -487,6 +487,7 @@ static int pmem_attach_disk(struct device *dev,
 	if (rc)
 		goto out_cleanup_dax;
 	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
+	set_dax_recovery(dax_dev);
 	pmem->dax_dev = dax_dev;
 
 	rc = device_add_disk(dev, disk, pmem_attribute_groups);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9fc5f99a0ae2..5449a0a81c83 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -40,6 +40,8 @@ void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
 void set_dax_synchronous(struct dax_device *dax_dev);
+void set_dax_recovery(struct dax_device *dax_dev);
+bool dax_recovery_capable(struct dax_device *dax_dev);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
@@ -87,6 +89,13 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 {
 	return !(vma->vm_flags & VM_SYNC);
 }
+static inline void set_dax_recovery(struct dax_device *dax_dev);
+{
+}
+static inline bool dax_recovery_capable(struct dax_device *dax_dev)
+{
+	return false;
+}
 #endif
 
 void set_dax_nocache(struct dax_device *dax_dev);
@@ -128,6 +137,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
+int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr);
 #else
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
@@ -155,6 +165,11 @@ static inline dax_entry_t dax_lock_page(struct page *page)
 static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
 {
 }
+
+static inline int dax_prep_recovery(struct dax_device *dax_dev, void **kaddr)
+{
+	return -EINVAL;
+}
 #endif
 
 int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-- 
2.18.4


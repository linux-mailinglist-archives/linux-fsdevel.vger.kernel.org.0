Return-Path: <linux-fsdevel+bounces-38616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEDDA04EB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DE03A125F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836AD15749A;
	Wed,  8 Jan 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VArJqSwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77B4CB5B;
	Wed,  8 Jan 2025 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299142; cv=fail; b=g/WMYDdhoHNahtmhR/VnDdU8b0q0gmew+fzQgkt9chDCuZs9tn1AQlRIieZayP2ic3k/I7iLQscWKyzdzk0HyCr3a51SL+zrSifbWcLf1j+VUTrOCP196IVAVbEhiMbgv15ysPVf2psLDtsNXyoeQl4wjAUOKLIex6r6aRoiclQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299142; c=relaxed/simple;
	bh=qt4hCXyqduC3y5OrxbXoOU7Rz+/tpTczboDXe1dcLW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KaJlvwyztn7d6Sgdot9UwBkgKFA3DpNXNTRWSR2weuYQq6qwHCQib1dZt3tvrnQzmfCi2v7YOKBYPwJEI7qVznrG3V8NXNxvhG+Gdl0aADhAunp15jcxjjxc8nf6CGTPwID2dYwmjVNlEmnguPkifpxgOS50CUY0VsCybcr22pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VArJqSwG; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRlM5CFaJXfSyui47/Ebh1Q/q2ez9pijNuOJOycaoyAllbn7eg101qWZw/pQrTGhX1WylDIQwT8F2pxyz8QKyJxINKXzE3Tk/DAz2i/i1+UWuGpQMdQ0LOQmwnXGlABOERVsHrAeWO4OKI2Rpp0MK9GS0sIlrUqgLjeoCDaOqIoigob+PHDfev2iZl4du66SvddhZPmpr+ec0oVKq0BMiIRr8o9w88muETgMo/3wnY4F67Me6eAUvXdTZ4IwZPKPSJh95mH6/FDzPlrBBMd43/F1asu4kq4zJs1ImYLxW17vkLwtNdvo/tjnerys7sGISWTkVHyYNuxffY1/rgW66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5kaGBwLUPzP7+vVwbP5LA/mDb/TH68zjJSuMHcLH/4=;
 b=YMNWa3aRN7woO2h2QDvq7lU39AFBFg8khu1kTUNbz1Bks/GvuYAVEJQs+Bagp378tmgLwK5ICnvz9MJStnjFu+1vZz9GKCmvMIoQq51FFPwcKS10/hULXWH2r7FlNC4WyrCMJYLGWjZHsW8WFA2lPyJvVP0uTmAe/2WIhW7JA9aP2krJjRYionflvo4j0kr4FCn6QSRL2Y80cJYZwL3WsWmXIt70K3OHqFVhN7xd+9OhukQAZnIYWQpBW2c/5HX0YusnFgG9ivOgE8lZxlckt0gjyATQCzk3RUELQ30fplKGtwtNV2on7qzqnpV8YikYPx8U1jMqNXVO5i/SA/YiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5kaGBwLUPzP7+vVwbP5LA/mDb/TH68zjJSuMHcLH/4=;
 b=VArJqSwGgmHaKo+vu/rt4juvgsaUoomjYstwrM8B66EhXiewzGw1vgoUGHyjoBP/WneQ+TK3BBkuWDZg1qaaJUkJ7b6Bcx/ysyRWprIwA3qQFQj/hrcsOHSgJfWGh+uJFMzXc7JMiRQ5rxozIxo063RPflGyNFOqvQQDak8DS/T9W9y9vOhRXnzshVMAg7BuKmsra8oAHsUClpZ8/miJ0UpIHAtUqBZda4aoDR+j1WyDspWnZA8kVBPanLVZyUW33kNNHhr15O5eq1ijAxiuoYkcuMYR9AtyT2mISbGC0ZdvBKO2CpZlw2tlc7EmmpkJRdw+Mr4gQtjd67KKPe0AUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Wed, 8 Jan 2025 01:18:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:18:58 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de
Subject: [RFC 1/4] mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
Date: Wed,  8 Jan 2025 12:18:45 +1100
Message-ID: <106d22a58b4971a2e41ca65d9ceb30ed81fcf727.1736299058.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
References: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0006.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 08592ede-7695-4d52-1c33-08dd2f826d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TCIn4n1t+r5D43/TIEOfbhp5zwDqxsT2y2CqYQCZ6SeDB9oEaFgLZyL9skhA?=
 =?us-ascii?Q?lbYyFJ9X7X4jMw5C4m0LVAyyg3jT7TjIdNR10M0d6Lz5O3c185DIwzaazOLS?=
 =?us-ascii?Q?/sOf4l/U23dCPuCSVbHfVVroEHAK6yOu7moHJVrQJagZHTbnNfkY6CQxhXLK?=
 =?us-ascii?Q?J/9gWO3/mdldd8+XOwS0jH9BhqLEBzjCx10sQPH9ut7vDOe3Y7kwafGv+EIh?=
 =?us-ascii?Q?k9ev6CPvAlRCRogvGRe5fXf4EyNHpRk95kBrbddc9YX56vh3oAljmbSz8bDF?=
 =?us-ascii?Q?2cxFwt8liSbt6i5s+iZR07ap6btg9JJZDyDz0vmrGdVURiuN8H3O3ECjFJcd?=
 =?us-ascii?Q?ryeAeg2/WD1E/vJlauF1DnoyMQFPo3PJ26OBQLmmql7STTvxcoSERweOJQdm?=
 =?us-ascii?Q?pO/YzNZzVLFv7+/GLbpSu1kcXC7orftaMfKIvHikuYQfGeSGGEMy4t0u+oeZ?=
 =?us-ascii?Q?bw5MMMt9ugRYKypSPXAXqpI/z6DnBFCf9IkSQA0MvL1sCWp4nQXIcbtgvNb4?=
 =?us-ascii?Q?X7lr1PV9gVaW3Ngd8XjgjRJ4ceXbFOXXzPPfpgJG2c/0E+sKf95Lb3s7VTDq?=
 =?us-ascii?Q?ikXjgOJYAHRMFJzz0NmkZJyITM6h3P14gN+FXzzrhBl3gLBHd1fmkI1RcvLv?=
 =?us-ascii?Q?0KvuXZrqfpLMpd1/T6F+VLT7kfP0z4ycHMo1/JWrTz0usumdV/Zkq034Jb6q?=
 =?us-ascii?Q?VRwaBeKwK7xN64cdmlFpABzqtBVykR3v6ddu5eBHwWh2U0yBWwgJyrRNnPsA?=
 =?us-ascii?Q?Ssqzndsuj5H3KCE/cdtW0QEFj8aqjjMlTmtui0Fb6oQ4SIzE5vTTH8esrR/+?=
 =?us-ascii?Q?IYsMzC/JUEKgYGw9NszBuU3cUXPah98xqe4SkxKXF+iJ7RgdMO4CLdBV6dgN?=
 =?us-ascii?Q?8tKtKqZ1w12++9KCXkFVQDOvyc6+GcoALW+VKplHp+xRTQ2aFyCXbQnUhHDT?=
 =?us-ascii?Q?RvvHpZykuZho9lCBKknY0fXBqsNVTzLRwQJB9MO2b1e9tBpEyplttFeN0Vw0?=
 =?us-ascii?Q?LbSdpeHkyPsR/2kACcLwAepJAJ74MPBX3TEd5dI5i2ksEuqpeXxogI/uaKgQ?=
 =?us-ascii?Q?QDtQYw+GkJO6Tq26RjGXwiXGpjAFRpnalXeF56F44RbuwrbqPWdP11u0FJrZ?=
 =?us-ascii?Q?7k0+EqAzxkU5Bkt2eDkuLhExi1TvjlASNCTkknC5TGEHCsvCpc8ICqChCFoS?=
 =?us-ascii?Q?yZirHwmqPRX6pLMvh+a3N5E76otWa6X+52ntQ/owtxVICrbxjSHF5HyvjibY?=
 =?us-ascii?Q?ltyBiy88KQWge7R0KoKcKS+05cB6m/bZUFnwxjeEa3d1PwHMn2RmadzCggYy?=
 =?us-ascii?Q?uBSaNVzsZxCSHpIuTYG5FGXLLap+bbGUYC3ALU424jMNkHSH4cqS/Yl2/6Iy?=
 =?us-ascii?Q?McCfr53BXyckT7vmRsB5OvIIuXYZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0vA05v9TUtw22ces5pGb6AqUi/GIVeGbJ0+CJzQfBLSi9t/RX9k/W0a46Cf?=
 =?us-ascii?Q?lVHfRgmc50DI8my3t9JHTyNp3zonkNw7SWmcX7iWd9rWKlNp8HO9jBdRSZBL?=
 =?us-ascii?Q?UhZdzDOg+V0f+eRPw8ZfEqfrzAfqHituxq8vX6rDBzohIYSXUNEcNVJ5T0+b?=
 =?us-ascii?Q?SclrzUsETz2Mn8ffaA3aXrPQWl++jYd8+tPsqqm+o8eO2vZN8glTlpQiU5wu?=
 =?us-ascii?Q?W319PJpNe7cEspeJ3sNxo1iEA63nFXbODJZgmJg478hat7SMYJzJiwj5Xg3i?=
 =?us-ascii?Q?sRtbWg0NyYmIT43UK+/WgiT0+QG9IeKqvRJjxLWygpK6BRlCEEqFTSM7usWT?=
 =?us-ascii?Q?gdBNbYlIrcjiNHP2sqy3YUYLFiytrhOXO3KUiZqz0zpjz4AQXV/JSjMQEfMW?=
 =?us-ascii?Q?QMhReCkmYC3kh1JIrzaPWmFR5NDZTJr8lnsnrNIhKRgc3q/4e+98m/MgECYJ?=
 =?us-ascii?Q?+fpQBf/22UyWCLFK7foLQp7FiEi5Aw3cThLo/EUr0YjiRas3aDXAfFAv+roT?=
 =?us-ascii?Q?MmqP6MSHAdxZInFL7VEFuCHLzbFcsfQh3/S63Ndi0247zRBhpy6D2+6EqVwh?=
 =?us-ascii?Q?5pUDhn9kSsnRIo8xJDwG94X1k70WpINBHQzBrWRlGzaLyZjDKKOVPjk/VCyD?=
 =?us-ascii?Q?eO3tXV3RbJA1xwFetBNNhQ0JEmgtvZVsgXrbsD75LsCDzdDoNWnx7E2320Ed?=
 =?us-ascii?Q?t+n6eYM0f2ue4a+ce3w5rpSOkmgbK/zxMkW6nz+FItj9ayNuxt69q+bM7rUT?=
 =?us-ascii?Q?1JVDrehQxOh7YIkZf0SBHl/BXRQl4CqrExhd98lLE3n7sEkV0vZ1swpq8j7G?=
 =?us-ascii?Q?xxBFHq9NS+74OYFtNF7IiUunkRPYiAH9AZiM4pugvQTIASbzp559c9YIg9nc?=
 =?us-ascii?Q?DuRcsvXzWRK+2fIGgXA4vOMH/T5AtpFOEFodfM0rYl0PeNrvgjICJdjq9vJZ?=
 =?us-ascii?Q?XKtnwRBJlg9U8o6gxqJWeG2jx51txeMIOb5bbSB8C1dgCQxPqFXvMbuIc4WH?=
 =?us-ascii?Q?Un0ByFgpMp87cBf9Ib3pgs7N9QF1RIBQr4+H5z9ut0+xgNfKQxp0S+tLohXZ?=
 =?us-ascii?Q?rF8Bff2zms1cwni1vrpA6al3GA8noWFZP8CTmTzPy0r00mLZe4tolhSL25W8?=
 =?us-ascii?Q?+tx4EkSgTGcYRJFapXskSGH11mWUcCRJSLvAQQprB8s0MkmuxVv+w1sG3L5a?=
 =?us-ascii?Q?DrdNE8V/oXgBf7J2n8YBkakY06cqmFFLCXr8ONsQv2QQZYWGP228ojkz+iby?=
 =?us-ascii?Q?u0O5kX4mCbEtFLTYqo88UASjqr6jaLB1DesIaWuNIWe33+yemRTEg1g08Fi9?=
 =?us-ascii?Q?p7VSEWQ11cI0E8FP5331SRBQaPubk0L5pCmiIrvn9M7OpNol8zt5F8YS5hua?=
 =?us-ascii?Q?KxADw4Lr2HWTcMACiPgorZHAR28V2V4W2jkIk9adle2xgROLXfY+DLook3E0?=
 =?us-ascii?Q?1izs+Ff8JlECWeOn3rn/AtkpXamzTQc/R+0mTVchyKn9UhknIOrEQDXSNZFP?=
 =?us-ascii?Q?/lZstL9LhG4pwXY9ctpfk6xGr1tdHbAhFFjExDOh+JsiPcth6XXOErkQ8ZXC?=
 =?us-ascii?Q?/IY+aoYbuiJ5E5xxRAFBotvzcp/+zgaAb077po+f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08592ede-7695-4d52-1c33-08dd2f826d9b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 01:18:58.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nD7ZH6upB4AcUY2XJzfFyiyxaWrvaCXxpFc7mThyUvtpuSzNTlh8V19k/bRndA3xzYyWMyOOIY3KTsOUC9ljag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264

The PFN_MAP flag is no longer used for anything, so remove it. The
PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been used so
also remove them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/pfn_t.h             | 10 ++--------
 tools/testing/nvdimm/test/iomap.c |  4 ----
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 76e519b..75bb77c 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -11,16 +11,10 @@
  * PFN_MAP - pfn has a dynamic page mapping established by a device driver
  */
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-#define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
-#define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
 #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
-#define PFN_MAP (1ULL << (BITS_PER_LONG_LONG - 4))
 
 #define PFN_FLAGS_TRACE \
-	{ PFN_SG_CHAIN,	"SG_CHAIN" }, \
-	{ PFN_SG_LAST,	"SG_LAST" }, \
-	{ PFN_DEV,	"DEV" }, \
-	{ PFN_MAP,	"MAP" }
+	{ PFN_DEV,	"DEV" }
 
 static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
 {
@@ -42,7 +36,7 @@ static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
 
 static inline bool pfn_t_has_page(pfn_t pfn)
 {
-	return (pfn.val & PFN_MAP) == PFN_MAP || (pfn.val & PFN_DEV) == 0;
+	return (pfn.val & PFN_DEV) == 0;
 }
 
 static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index e431372..ddceb04 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -137,10 +137,6 @@ EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
 
 pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
 {
-	struct nfit_test_resource *nfit_res = get_nfit_res(addr);
-
-	if (nfit_res)
-		flags &= ~PFN_MAP;
         return phys_to_pfn_t(addr, flags);
 }
 EXPORT_SYMBOL(__wrap_phys_to_pfn_t);
-- 
git-series 0.9.1


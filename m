Return-Path: <linux-fsdevel+bounces-52175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2466AE00E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6EF188FEEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964CF27F166;
	Thu, 19 Jun 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5mbU73t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9E266580;
	Thu, 19 Jun 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323524; cv=fail; b=jO0YEcWswZXLHXxuf2q2N+SbkqSmz30DYBMDBmsJqU8t9xliLsCklgYoMrSMk0nTUpVNgWmaVerFf4w3nzSTMCVh+7c/kRV5oDdJPyXhDpX7BZIkYZa4dUapo9ngfze3np0r8wHr/lmHQix2hycpTC8vVxZ1rKKzvppQqkjZkr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323524; c=relaxed/simple;
	bh=dOgxTegMf4jhPPrFEd0QHgnuEUqRor8z5I6JmOkIix4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9UKUBVEMGELROLqCTRPL19/rnjpHd9smoGnFNdm9pHfDW+ObZTlxAmlpCY6RANkEbOrBk729RMZg4nQvSLrvvRb62wHZJ+GBEtqN0xo1/LaJ8v31yj1yjBag0OOQZzGT18KIZtkGRygoNO0UcTwIUljdFl9iKc1UBuCgSEzBv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5mbU73t; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9vEeownxNNJd0lWMTRAzwqRKfLECboMV0uAk+y5Nc/wDh/H8r4cub/BkJcyGGwSp10T8zWgerLysdUvPxvEJGgpSl89wm2vJsLSaRwzcqRgkUkyt0Eg+IVjAX5rKcviXXo0wrIapr+0nEkIeYy2apCObGpCVVP/5ZvyxXEv/8rlQ8cBAB+WuopG1OsngVRaDmJv8kx4dGMi4LB/wH/QYfSXXuRKRyUu7eaqwr6iAKcqDMUeOB/kyYo7kaWjndGu8KiT86GYHnc8CHW+zZ2C8z1/TUfxOHPQq7/U9z21HptDtiOxCE82OuOgcU+OHbcr+pQjHf16dGcKwIX8A7Ne5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LActDMIj2/W+ZOPLTFuOnKvX2TcHYSLmWD14z8g1xdg=;
 b=Wwc0oWLoXsTbuTVCIk9HbSiOcoT1xz6XwPfZbOtK4ZUk//XKCOIM8kOSGm8J35DdO7x2U5IIc70ONfVMTRZ8gAm+2cEBLu8APNNz5Hw9F8wZYTUE8/EijFVHoI45TCBCgjBqmcoDjKipu7bhl4G5a5qiKwgthM4RClX0KMyhWfUJDUqKQTLav5XkMaJ+YH43DR7g5Hm2bJsKJTALHBO2GS1Rfd8iilAW3JAqRx1aI7/TLT+t8OaHKZ3l7EAJQsjB4mApOYaF9mcZfJNLeb+a6Q+X+1B1ch68YJ7cWEHetMhSbg7Wf/2KzWAgbPsDLaQ0nhTK6euPE5POgRm67lJ0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LActDMIj2/W+ZOPLTFuOnKvX2TcHYSLmWD14z8g1xdg=;
 b=X5mbU73tI0arE+AJvi6z6Ce9KRtH4BuUqjmqMZ/tXOih1UuxzHMo6DesPio1acKtNJhc3rf/l1t7Yjp3fELGR9/lqXdfc7vREZUwWwJmFk+E2KGoVjMuTcRRiqGO9lEtGbIQqFysZKsvQxfSJO0lBzI586LYGCshOd/AQ7FKfcpZDl/K361cp6KF++iNHe4ZVEeB7GYAQ2RxcbIPtev/wDXUVillzVnkY5J/st+xy+2/4SiCtWAZ1mFUhWVBpkiihJNvo/nd2MS/gIIFmyhGZmX2I+skFefuRu2RiseONYNlGfqLDCnzPOckOj/JpUcmLWcVwD8aFpcqDAjHaC3Wzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:58:39 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:58:39 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
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
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 04/14] mm: Convert vmf_insert_mixed() from using pte_devmap to pte_special
Date: Thu, 19 Jun 2025 18:57:56 +1000
Message-ID: <93086bd446e7bf8e4c85345613ac18f706b01f60.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0017.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::9) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: d3240cd5-ff3c-4a2e-1fac-08ddaf0f7bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xakWiqi1VR8cLKPt8UQwyzG7l2bxjjAvxYh3q5CRExtxWRqSuXSvV3fKXqLE?=
 =?us-ascii?Q?VsxfbduiT4lAt2OCewm1CuzF9vtQXmeXCzRYG16PbgfhT2Lz79XywywA0mqb?=
 =?us-ascii?Q?p2hi6DIcKRkZrZTTnogMip4rFea42O9PGIpDuwLGSqoQ4A548OT7cmt0jGwm?=
 =?us-ascii?Q?zRduu7kLIffiVa2D0R5laDwAy1W3ZsI9Bu6g84n6BoXMi8epxO7mktMsneFC?=
 =?us-ascii?Q?uXlbshqM5AmlQo/8HTno5cA+UXE9d4rssx9llNMYVvfg9HuD5S6Bw3AoBCX9?=
 =?us-ascii?Q?1Sg4KuhF3vPV3SUEe1oU0Qy4daRBHaOOZGl4B73FQ0Wznyfdh6TLOCxXQVeS?=
 =?us-ascii?Q?/wN5Sq5YrDuZQ6lFEY6lOji0K4PSCfmWkBzlveJ0WvEWEJIgoYC48ptCFOOH?=
 =?us-ascii?Q?c/Zd4OTo1HDcRrzEhcJahZjf0zsopSncisqa4Gtrh24j38LJx0i6FohlUmwK?=
 =?us-ascii?Q?cBRVOZ1q4GM89Yhz7CKSnAd/ZZLpXxvZ1WCw6hMiuYXwEBScx9BbYir/fCcO?=
 =?us-ascii?Q?yDLxUoawg+UxhZHPVUDfbod/v9dR3WbLKvd6YjZGi708dg6vowwfGWPCCSUJ?=
 =?us-ascii?Q?MnDw/BTkJN2CXcat9wy2tI0t8VqqVBqi7nRU7Xua4RV16H6YVdfXzosZoEIk?=
 =?us-ascii?Q?u86Scz4UCWFMW17C0VIPlD86juER6ZBIsd4i7gdRfGK50JKpdmtl7xshSST5?=
 =?us-ascii?Q?/xCuGIOxVn1RSNqES8Gxb6avWywLeEUT+XPC9Hyx4kWaTq1iOMUfNQkxccB7?=
 =?us-ascii?Q?Bd2PM3RAx1WaAdBHV3j9P9iHXN2cM7SpWJi4eGdGrnUjDKbyv1CD7Z27QJq7?=
 =?us-ascii?Q?mZ5Rl2zdL8QvnHtdWsWtD7CTDnOf7Ptkp+Bbzng++UHeenxL22W394gZHQuy?=
 =?us-ascii?Q?yq5v+yVgivw0qctoBDGz4bC2QNzu2I4hkaU6+y0pfsy+nJnD44NcT/ehoOds?=
 =?us-ascii?Q?gsulCfjiDqgJlCIH4aVQxZgY3kaxEoG2PhFK6qJXCdBgtocIHUaAeF2ZTGpp?=
 =?us-ascii?Q?efENFUgf7+oDEVuzpo/d85bLwpEurtJGM/Mq+p5SelCDInahycP/Hzi9+sOb?=
 =?us-ascii?Q?8wAZt1qZiAuT2Tujst31d+plQXHItgz+1TQxO5a2BMI+ldjejzBUoKRar1Nm?=
 =?us-ascii?Q?gD0NGTHTADJ0TWp/2GRqFWg/zxRpHTaKxnQAiyKNrm5MahD/j1/mu0YDEqZ/?=
 =?us-ascii?Q?vn/DQlMlC+UiEorP9VXHuN34RmGBJvWpu3J2pMqHmjP0NjwD8vbebAtilgwb?=
 =?us-ascii?Q?GkF6Z8vwJcNWTVFinNFfqQLKPOvKTE8V1V1LbJaLhOdXEvFq7mQuQfR0B10R?=
 =?us-ascii?Q?brL05mJ1wjlSsyYMaL/Vnb6JiZF2iH71Fy8xtjkx09tfY68FCOL9L3rIgnAJ?=
 =?us-ascii?Q?EXr7o5/7cgzDiSKh15LafigBujTMVlOPVp/4jjfc6ki8l3FlQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VtoQI3Uj2xUkNZb9t6DnrnNDVo4zYoZkrDlE+5Lqbxs+j+Wz7K9Hz+n0GI1N?=
 =?us-ascii?Q?AgDUMHuJAuh1qjS57Akr88yV+K0s3eKo/zU5CHYczoNxDC0mVzuCJnUE9ebh?=
 =?us-ascii?Q?4sfr6ZSsKwHGMasa01B/9bOqyxY5PHxXLYftLdez89xYzD+7w9At3ZTZ8661?=
 =?us-ascii?Q?k1NWSOUfeKPk20Z1YCzYOkIyuMWX6uP36NDIK/cVDCvKdNBhrEg4mO3xfCRG?=
 =?us-ascii?Q?flC93jsEESsgd3XoaWj7eHhZaqHAx00ajQJuMAWN3B3Dji9krHTQkuSkkQ++?=
 =?us-ascii?Q?ePeKkxZmNSc4YWVXoj4Je6UDHL8RyG406E6yvIhSO2iJkd07XYhAHexugkMB?=
 =?us-ascii?Q?3c+YR9qUQ0C8qd7BCNlO4GoDnk2FTzyXNR1uJr1eM4finQDfUOa1xU0+Ejpo?=
 =?us-ascii?Q?U+9CwiCeJHFgAwguFX0uS7qEOVxxcxw4vlTdzI94dNppZUz3NFI6U1tP4kvY?=
 =?us-ascii?Q?RajJioVMeDF1ht6L7EwSZ75lV5Nf0TJ26cpVNIh2wGaQNhEycl+caouD9rzQ?=
 =?us-ascii?Q?rHgfsaxwo1gDzIIecgx3MzZaVGoZGo6aZshYoCRerNTqOWxXz5Hff/yKRK7F?=
 =?us-ascii?Q?sU/RbGXSDGSgw0n4GYG3KojLl4vxDoljXSJYeigg1SHZ3TeWbgYgPZbWrgnY?=
 =?us-ascii?Q?6kLoq87UbuxvORQwJ9iPfB3lj5j/i7uI6CBD4cm7WhQEouJxOu8hPiQgmvex?=
 =?us-ascii?Q?0nw17aa8VHDLVUAk6OaDYv4QJKVHMP5jUNwSo47WUb8B/ayg56WBv5ulFpqf?=
 =?us-ascii?Q?IZqeQHzeOBpK7j1JFlrWmyt4UNFOeun8+e3mcgoj79khitwPIzRAS1u4A95p?=
 =?us-ascii?Q?tjN/iY4YCnRzn6GoE3Lhfq+/8ge9FVuQ+DBPFcW4rKesOZo6Z+edjElQbD6o?=
 =?us-ascii?Q?29xENqKY+N+PCq4+5Trjbv8yjsJOfy1p6kZViTLYkGhRlfr/cjstm6OoRbJ9?=
 =?us-ascii?Q?zRifXV69zFo3FBmwYPYO1nebooPZXvyI8G+8yx9wkiyONNshMdBoZfJfI06f?=
 =?us-ascii?Q?n8youJmKTMyEoCo6CaJBqg1zgirOKvJ0V46aBpJY0BlYM+I4FVagGPYjCdKn?=
 =?us-ascii?Q?3Z00miyPr96uc14qItYHGfuBICeACm+Tq1HshrXvn0posJmtKVEL5GdihdEC?=
 =?us-ascii?Q?2hpS3giLK0sO4s1pt3kKbOYjRH35UGqk+mD4AzWiG21uqJPU5H3ZamhRXD2C?=
 =?us-ascii?Q?FKZk6SU1r0bPVsJPhAiEuR+LlSBKCJXaICjaNooQB3FurVDOTZBcwHnk5wW2?=
 =?us-ascii?Q?Zykm7Hov+MOTEhzlO5mSiB0Bifib4S479IW2gKM2GHMEYyCCjo4t4QO5tKUr?=
 =?us-ascii?Q?sJvxHiPRRcsx8lFoRyp0GlM7TBp5mkNyY/vK66R25fXgRGXH99E4xLJkkwJ4?=
 =?us-ascii?Q?tnbDC8fO2NxFK2T/qbcuPRQtEl4IXmKUau2HkRe7TL7dJ9L0EJUBMV5V0HqA?=
 =?us-ascii?Q?qfiKHkxvM/OU5xEm2JLpAxvUkK+dkV9swFQ2+6+6AH13v1jfzpRRt88sWHoZ?=
 =?us-ascii?Q?qAw0ko0tzKUPYcAHdLFSRbQs5cGPRWpB06Pvn0p3VkL7o+nZD8e9j2inU2nH?=
 =?us-ascii?Q?j9IYDPueLz14PY88g77Ist/cqVC+1xV+VyzMVODI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3240cd5-ff3c-4a2e-1fac-08ddaf0f7bc0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:58:39.5206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NrmHJGpwQi5nd/wJAuQCo83vYx1CnyW+6qbFsL4ogklBVkNfNgdlGy7vlbcLo5rFNPzJ6bgHRnx0qLq1fDyPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

DAX no longer requires device PTEs as it always has a ZONE_DEVICE page
associated with the PTE that can be reference counted normally. Other users
of pte_devmap are drivers that set PFN_DEV when calling vmf_insert_mixed()
which ensures vm_normal_page() returns NULL for these entries.

There is no reason to distinguish these pte_devmap users so in order to
free up a PTE bit use pte_special instead for entries created with
vmf_insert_mixed(). This will ensure vm_normal_page() will continue to
return NULL for these pages.

Architectures that don't support pte_special also don't support pte_devmap
so those will continue to rely on pfn_valid() to determine if the page can
be mapped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/hmm.c    |  3 ---
 mm/memory.c | 20 ++------------------
 mm/vmscan.c |  2 +-
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index d0c5c35..14914da 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -302,13 +302,10 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		goto fault;
 
 	/*
-	 * Bypass devmap pte such as DAX page when all pfn requested
-	 * flags(pfn_req_flags) are fulfilled.
 	 * Since each architecture defines a struct page for the zero page, just
 	 * fall through and treat it like a normal page.
 	 */
 	if (!vm_normal_page(walk->vma, addr, pte) &&
-	    !pte_devmap(pte) &&
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			pte_unmap(ptep);
diff --git a/mm/memory.c b/mm/memory.c
index e9aa15c..97aaad9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -598,16 +598,6 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			return NULL;
 		if (is_zero_pfn(pfn))
 			return NULL;
-		if (pte_devmap(pte))
-		/*
-		 * NOTE: New users of ZONE_DEVICE will not set pte_devmap()
-		 * and will have refcounts incremented on their struct pages
-		 * when they are inserted into PTEs, thus they are safe to
-		 * return here. Legacy ZONE_DEVICE pages that set pte_devmap()
-		 * do not have refcounts. Example of legacy ZONE_DEVICE is
-		 * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
-		 */
-			return NULL;
 
 		print_bad_pte(vma, addr, pte, NULL);
 		return NULL;
@@ -2483,10 +2473,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	/* Ok, finally just insert the thing.. */
-	if (pfn_t_devmap(pfn))
-		entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
-	else
-		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
 
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
@@ -2597,8 +2584,6 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (pfn_t_devmap(pfn))
-		return true;
 	if (pfn_t_special(pfn))
 		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
@@ -2630,8 +2615,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) &&
-	    !pfn_t_devmap(pfn) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
 		struct page *page;
 
 		/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a93a1ba..85bf782 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3424,7 +3424,7 @@ static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned
 	if (!pte_present(pte) || is_zero_pfn(pfn))
 		return -1;
 
-	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
+	if (WARN_ON_ONCE(pte_special(pte)))
 		return -1;
 
 	if (!pte_young(pte) && !mm_has_notifiers(vma->vm_mm))
-- 
git-series 0.9.1


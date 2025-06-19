Return-Path: <linux-fsdevel+bounces-52172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F05AE00C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDEA1884868
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8C52676DE;
	Thu, 19 Jun 2025 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ilMM2BDH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FFB265CAC;
	Thu, 19 Jun 2025 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323508; cv=fail; b=cGkvnr05dVPesyUSPo/id2YCbVVEJcJbLK+ms0rnPO6fm6mcjCMZ7+IlV7Nys0W2RAfNIxRWjxtJzeMOTkCwqWH1k82xVrJptn44PtV+RjsFYB7YQNCkGYnzF3UhWyy0hPQ5YCSptJT9RuDgkkpL4aYqnoqkxtZfr/8ZxPEvhqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323508; c=relaxed/simple;
	bh=Y6cvCV5pceOmYWrhwMtRQYleaIt4On3IR30vt6LP8kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rk0PfF1jHWTuGPS3s0Kvlo06xFabmx5Ngl+ZwAgJvuIEcjnPr79q3DG8YrneB4sBhbdnXq1+/xBA8hqevQTFMqYuIJmEKs88LxMcDAhbct61cDzZgo+OQb0lxsCc5X/KGs/aDTs65vuxT6EJMdJB1Fzd+RxLoPgx5Ffs8aSGDyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ilMM2BDH; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suPKgvcSRlCd16jtnlVUBFqNMcmVBX1Z/EZNsGEBphzV7xas/kemKgQfz8LUd/U7lEpWxUbg3zrG72VZAkQYlsUCMB5R8x4XJ2AWuma2K7Sz5gsWC8IPncc5GnjiXa9UMHVADklWtMlSMM07COAtPZRA9HNvrRgN8GmsjyoUWu4EAMt+pWXzFNdnjutBlZ6DvhWa1lD5UEtjgnxr+eo0m6R5NZdauZHYtX6wA0cC8WmlEAeZpHRRBokREN309zpQSvMVOZPw2alqtyT2MuvOV/QI4xX6r8RlAaa+bspoiIeB6wjV1BFN2bx2C4q3lu1JhHMxSImDuhHq4Vo0P4FOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W080evjAN7uLN5xy2VvtmyhJt0DOyjwg2Bhd4+pbFu0=;
 b=H6w75NFdlQwWsWwyDu0l57b8Ml2EY9WvrXC76AUhbj9M18/EZ1Li5v4lASdGurDdodJWDYfZEx+0IbSFXFVIJUFggFScM2aYCED7D8hPhvKA2KMqRejbMQrq/8cK17LWi4iqqr4qzS6JLMOTasP1Pe4r4ygwzCHlOf2KReG66jvfeB8b4rCiqq9kbk2ddYFI6eJHjMMeKqkNsbmpdOvj3FTdfWE8IiJH0vC/Rfbgww5Lr98i3cfyfPTslkEvgsDy7slYxTD5QzUVjsTsmdstI3OaRe6STUWPoJ6mKKIcPse4EV3bpR32aiZJ8qF2bkcWWtLVKMzQX8oeMrhMHCPjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W080evjAN7uLN5xy2VvtmyhJt0DOyjwg2Bhd4+pbFu0=;
 b=ilMM2BDHMWoCZCy8oKwPb9TOXHNQ8hzyhAUvH5LgSPgLTC822NKBIdkauSwNELVTjiHZQfdHsEKSGLIo6V1CgswFRvIGKyUkc02T5CDUMBILIecA5dSkcNk6PZpBbsJt7cmNpbeKeapDg7PQVsYGQEpayCgGaUxgZl9/I0Hnel1Qi5VGgSaeEx9ETAFFsYZ2bojs1lQSZjXr4swY5zdIAWkzQkNj49R9sWy3iusCUmASg6hqo1C0R+pYcBwXHwzWZoU5f2ohpH5iuHWVCKF3XIwwppoI5WQ+3WG7EiaN9bQZ2bE9U8Ecg2Xi2WfwLkHE1COedumVjmBbXYWJRdEn6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:58:25 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:58:24 +0000
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
Subject: [PATCH v3 01/14] mm: Convert pXd_devmap checks to vma_is_dax
Date: Thu, 19 Jun 2025 18:57:53 +1000
Message-ID: <f0611f6f475f48fcdf34c65084a359aefef4cccc.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0032.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::9) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e694900-6081-4ebd-401a-08ddaf0f7302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AEX7uUNjRZ6YxQP6EqDBSgrFRp32bKRpeyOlwmW5zAWtgCxxPtW25z01ajs5?=
 =?us-ascii?Q?ZUh+dMYo4nIpbEryRfOpNZZ/NNNnqcSvB5TSQ2PwVF1ErbbMsi8t8PGxcqDf?=
 =?us-ascii?Q?D5++utwyeNUTJX/TyapoOA5nICrQkEz65rGlZ7jngnRdy7DxhUy18y0139Mc?=
 =?us-ascii?Q?8y2Ronkruj+PqELgq6XtAc7bdV426WFYc17yRyuUctKdrzcyqVxCGNdSqvQU?=
 =?us-ascii?Q?pKcSUn84YCdvAAbiKEr9bvnZs8bGIAmyLF4mtHULSL522pkBJyo954VssQrR?=
 =?us-ascii?Q?aW5t+wCUyeMuOSUPI6jFQ0pcfe7JJy5K6dTm2LJXKHPhxUOJ5QdGE8vNhkOR?=
 =?us-ascii?Q?7CKTH2WqfrGRZTCj2jMMb+vtEsmg9XI8WuQEniG7TCvc+idCRIkoDPOOhmjp?=
 =?us-ascii?Q?1ADKl3L4cNrmmXRZptYD5DU8SLN9hVgdSYnJwPzigIhjA++/pPcYCht+znQW?=
 =?us-ascii?Q?hK49qcF8JfwbXVViodmxK6bV4kO+OqNZdRghIvCsy2/NffLVobm4y5RSJG5k?=
 =?us-ascii?Q?7mHQHIguO8yWBZ4z+q5OHc6KZrGggrSqjQQeetHBg6pHv/0NatjdzZBIqLGv?=
 =?us-ascii?Q?hdDTEZNoERAbq7dUm2axQfeA7r2AZ8J0LtE13jGl/f9fBNDDEQ16JzrKH6BR?=
 =?us-ascii?Q?fz79SU5dtbU0y7BRjMW+YjSgg7I90oSWU/KbWKWnUfzjGK73rlHnimXn7e98?=
 =?us-ascii?Q?jDoAe5F5rhnzAiP5utR6BiCKbij39EJmMeQoi1UeXF06DjAqhCmJnTM4fY5v?=
 =?us-ascii?Q?xbtIs3vogSnoWQ940PHP88ExwrGALVuwBmm/cfUSWekMSWj7ocOo5qRtbkV6?=
 =?us-ascii?Q?6Ayn20Xx+gygkrdVwoNNv1UIkuloBevoVBvvH3AF8BM0v6kBJLtiJ3SQFxu4?=
 =?us-ascii?Q?nfnImiI4J5S63fAK/mD5OASNB9i4jvVMJaTy/cYHk1r1YK94I6eXQwIYKB39?=
 =?us-ascii?Q?vm6gwJr3AeXmSIveJhj3Vj5JgJiYjmzkIbpbDnmFp2IfGAzw44dsGTQMk9jj?=
 =?us-ascii?Q?xo83S1IHsVbyEC/hSaVk6MrMF3B7miYdEG6/fpa6ZqwWJc4iwvxBT2JY+gMT?=
 =?us-ascii?Q?Mf689zeAWtmvAdl33oAPrbqSyd6KA1qUSA3c6jCwGaZSBePhgpI4CR5zyMHN?=
 =?us-ascii?Q?CiUeCQJzPzMzV11MWgIECt0dgIcnm6QXQAkidN3SN5PnshMeVnSEb8BWdNjL?=
 =?us-ascii?Q?KPwcZSu7V8AQdoENijFbCBdYBhDeN3QlB4kMZ7ub38Y70cQ0x4nqUXgTdQYN?=
 =?us-ascii?Q?msgX7Ty8/iEnMNRAw53P2kQiTEooQqHah1CDU8N/N8m6zATxI/pG/zUtpe7M?=
 =?us-ascii?Q?4evvXqSMYSLnXyDvtoLbi4au5mdnTxYBFV+9ZG6vYSlXsJJH4XgA7A/eTe1o?=
 =?us-ascii?Q?rsatnrEMHsGRQuLokU81jScJruonOnWS2CcvXbh0pkAewQI+Yb27IUsGhi5b?=
 =?us-ascii?Q?biEwHreE8co=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FxcmdE41g/sRbm7Bw3enOpaLjVH3SqKa6VAQdEufswIFOxiXASjqt1nFo3WT?=
 =?us-ascii?Q?ZWrPVpGbKtFsWqkyMr+PoJ0/BLGryapMpUNMUs54XEgM1r1LnoseW+9/gWKD?=
 =?us-ascii?Q?3SmcH4junsqAMvEKzAQKk7ShwvraUUDYYkU8FE0QZYpbCWju5/A6sTB9M1Bt?=
 =?us-ascii?Q?BGWPXTCk1AqYQSau8e3iJT/F4VB3D7ItMbbT/8vH0pS14k6OWQZaX9E9P6J7?=
 =?us-ascii?Q?yd1Xws8L1S/M3dn62zKpsbZo/FiabucboPnyefxSH2lMIypOisX1GjLdIWbv?=
 =?us-ascii?Q?wjQWiZ1eqi9UN6zWWVVoRNmhEGZM37sGo0jgmuTxk86NPHJk8moX5xcWbSNr?=
 =?us-ascii?Q?OksK6ar8LxCG0RzdT+jKGBJMGV2osUC94z7VR8K4Fgu0fKK3Jvltuim0WW39?=
 =?us-ascii?Q?/oBGaiwHOcGHypIqe3aYl6G7i169f2hLU2a6yqyvhtcY/HZQajEJCp8trtS/?=
 =?us-ascii?Q?XEo1IC3eak3sXFrfYXeOQolW7V+a1EKYIsLTAhMD9gdsj5wqlj+8FsbEi0dp?=
 =?us-ascii?Q?NwY3MokBfVoRuPvkwKpeoW6fBoZJ3Ug03IEqEZ/3o5alCqYwiEvWI5CdBVgq?=
 =?us-ascii?Q?jV1B8bRMKuZqQjnCfBbmlMz9xcN5pSGe0EO44cqi2rXC5sZTd4dS/rqZatI7?=
 =?us-ascii?Q?eJlV4gI+r3Inc2CrvDVUW2yQR3a4LhvTxvFW5iW5VtCoKWA/GCjqtxNeqbtP?=
 =?us-ascii?Q?FnMeXJ1/c+R3VoMPwgKsANXK0nSOPhTzAvGPr0X5chvS770UlAcW3PdRAh3E?=
 =?us-ascii?Q?lrfiIQu1FAnMYpftmcBb0vVKltqzJiZ7h7+fT68HlShvA9FxJdPo7B87ndQI?=
 =?us-ascii?Q?CnzcZqdiT5JXBZAWinGQF3DjSZTYn0Jx+Ji+QoU0WGcZLwzwaQIVl6CDciT3?=
 =?us-ascii?Q?D9vN4is5N/xDRsshuACp/GzkO7flpJM7+IWsLzUNjIbf+YHuWjT3jN8bikQi?=
 =?us-ascii?Q?rO4RS+wx43ZUaOBAbgdybBvXD7qq60Nub4S4AxDuObpNURzvp3/9gZQo3Cra?=
 =?us-ascii?Q?mYYSaTFbLSNz0GlKLjG6OssHHrZgTeskWCzsh+CoAO800pfWyZVIGKtkA7ZM?=
 =?us-ascii?Q?s1OiG3kHQ+39v9AZjCBVItwFTX8abVI2TaaLej/70gV/aKt1dDDVKRi5EzIU?=
 =?us-ascii?Q?C8hoV54k2npMSTtHmkoJILKcStxcZUuWJJpFZMBdaP4dZ/rCvrH6P7WkT04M?=
 =?us-ascii?Q?Voa5snzwD9NgeMM88l8kNKJd0jGdG9019Y9HhUPW6RfK8ISwAxRWhk6an+9y?=
 =?us-ascii?Q?2+LbXfu3T2WU3UbAwV9EJCS9pTHitPVFwJUJ6Sjh7ttjNoHdWbJG/qte+bXS?=
 =?us-ascii?Q?EX0W6JYwyarmbHNBtH9XtcrZ18G9+UDhFpj4mQ92nABIGgHsjzQotOcvHqf7?=
 =?us-ascii?Q?hye0SzzfakjDaGIUJG2T16pqAC9L6Q1gH7wAnBa5NaKeCL4a5839ifb/kYN2?=
 =?us-ascii?Q?d4xC2zt9RNdbPI3n8sw0bbGY2Rr1OOEHC3+mZmddTD23NeUOJUD8LwjvGDIE?=
 =?us-ascii?Q?Bxtu/nXwg0X5aZM86xolZko3VGj3NbiKKz1yVUqlHOQc4XDGLPkmGMMOMwM1?=
 =?us-ascii?Q?IlI3OzBrJFBIwMz390YBjpe3rvS1pzDUSUoLik3T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e694900-6081-4ebd-401a-08ddaf0f7302
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:58:24.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hh1Np0XMnMVYmYraEY3+TeIBT6FRL4MCziavALf29LcSQo1a/07kIhXhg/AXzUNarvp0ONKglc/HbOQfFxvHnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

Currently dax is the only user of pmd and pud mapped ZONE_DEVICE
pages. Therefore page walkers that want to exclude DAX pages can check
pmd_devmap or pud_devmap. However soon dax will no longer set PFN_DEV,
meaning dax pages are mapped as normal pages.

Ensure page walkers that currently use pXd_devmap to skip DAX pages
continue to do so by adding explicit checks of the VMA instead.

Remove vma_is_dax() check from mm/userfaultfd.c as validate_move_areas()
will already skip DAX VMA's on account of them not being anonymous.

The check in userfaultfd_must_wait() is also redundant as
vma_can_userfault() should have already filtered out dax vma's.

For HMM the pud_devmap check seems unnecessary as there is no reason we
shouldn't be able to handle any leaf PUD here so remove it also.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes from v2:

 - Drop checks vma_is_dax checks in userfaultd and hmm

Changes from v1:

 - Remove vma_is_dax() check from mm/userfaultfd.c as
   validate_move_areas() will already skip DAX VMA's on account of them
   not being anonymous.
---
 fs/userfaultfd.c | 2 +-
 mm/hmm.c         | 2 +-
 mm/userfaultfd.c | 6 ------
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ef054b3..aef4e86 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -304,7 +304,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	if (!pmd_present(_pmd) || pmd_devmap(_pmd))
+	if (!pmd_present(_pmd))
 		goto out;
 
 	if (pmd_trans_huge(_pmd)) {
diff --git a/mm/hmm.c b/mm/hmm.c
index feac861..d0c5c35 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -441,7 +441,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
 
-	if (pud_leaf(pud) && pud_devmap(pud)) {
+	if (pud_leaf(pud)) {
 		unsigned long i, npages, pfn;
 		unsigned int required_fault;
 		unsigned long *hmm_pfns;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 58b3ad6..8395db2 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1818,12 +1818,6 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
 		if (ptl) {
-			if (pmd_devmap(*src_pmd)) {
-				spin_unlock(ptl);
-				err = -ENOENT;
-				break;
-			}
-
 			/* Check if we can move the pmd without splitting it. */
 			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
 			    !pmd_none(dst_pmdval)) {
-- 
git-series 0.9.1


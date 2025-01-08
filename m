Return-Path: <linux-fsdevel+bounces-38619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D7A04EBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A129188811A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73619408C;
	Wed,  8 Jan 2025 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YwIQxUwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121214F104;
	Wed,  8 Jan 2025 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299157; cv=fail; b=ddU94L6BaKNnjeq3QU7QwhEHxTqil8+b1ieZh3P8zBl2uPar2zkiybem4JCB8YYkwFLKs2rX+ENUCcbqzsxbYN7uEIOq4mLldayEG7peNUI6uQ3dlr65CxFHa0+lB/CyIbvxXXbyiwwXzX5NG9EspRmF1FHe/dR4n4nlTLxWc1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299157; c=relaxed/simple;
	bh=ujzx/WQRsMF0eBSC+IyKU+sEkbLBLr3cEoVBSozwfdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2jyQ0HEl0OSBc0YWJPoqXmWQAkrdCBCFCiYJ5wHYf9F6s4TshxNqWPxqntErY5H8tCNRSz61yFCKHPv1/SneIRzSnZ2IB7VKIkkn8d2DGtoXgn4M4uBmdkP7b2NecYMQ1FwEv240o/2ZtG4sihATu0S5yx7q0bNXLv7cXnBdYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YwIQxUwH; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wp0IYMuq113HJfM3u+GwGRShS/gQwJd+qbo5zLZ7HeMPOTlamkrKWRJP/6o4JB6Akqbpejl6wqOqs4RVS1ZJ75lE+LjrTdBlYI0KWKRcNbgin7jRLgl4E2hYsT5ZpxsQgGGwcNXqe9hLyCMF0kBXNw6UL4P4IvUo6KqSOnhru1Fg18ZiNmWEaVdneLPi+Ot1D+0GieYiRtCNFXOYWuQQW2N71eiba2Ub1w5r/ZSOjWj5OTFSvXPQqgGUtmGbrYbxq9Yesh8kuEkySd4CklhQJ6eU6eV7Nba+q4rPyZ8XkjJG1MJQGqbOATqjJPKG8ZOhAxg2U6SRU7MenE1Z6yfMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7lvzuDdKfKSwlcRCTo250cbJaCJWsopJVFrrMGY2rM=;
 b=Cckqo3qRIKBBS81qajSbEuwrxhSuhruFkUAFTgNTJRg95bIaRb0pgesf+MGF4890a8AJAHyOr9FggTZlRoADVuIr8PIZa7qtMMsQwyR9/W/V+QLU43XMwfW4+cXU/ljlh2FWTN1TljCUAWbjDSCTHFDM5fOzujILZZuQJFmNF+xq2fIoBnMGI+y3eEIHjBwU34o8sf0IOjdUsssu8nsQD5BRgmB94Krd3JYNM1hU6M2h219UgCc5zC0zPUY3+pnUrxXKQUOC2KmkjBFEfR/HTzXlInUNl3/n2Bz8Nf6YKJSIY2mKuIOhN1kE5m5MiSE/yZdyS5KUIiJpbrdLcPs3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7lvzuDdKfKSwlcRCTo250cbJaCJWsopJVFrrMGY2rM=;
 b=YwIQxUwHG3CWHg1I6n1C6VBSh+sEdB0MQH1pIMOJtyYrQaNihDeX36YbvLuruDA1Ad1pBrKVnJ25LUrPfhDCzE9BjIFxv3z3ggtlDHxqb5S5F8sYsi7qBqIFqWorhgIDoAngJreCCozvvmVVphjDVOUw2H31EurWYTv5gPKL40EyQmCN+17ncuMRWfMTYf7etivBYidrqjqiKSgN18FCx64qDr5h8nUeras4vUwuOMDwd65OtMgts1CeHoo2GMEBGjuNReHx+eyU8YXL7zcnXbj1fg1xqVdtHFAckHH+B28w5YkbNO7Kmw2KF7HbstRmMzMSzweC5ljjYBqkKCyXgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Wed, 8 Jan 2025 01:19:12 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:19:12 +0000
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
Subject: [RFC 4/4] mm: Remove include/linux/pfn_t.h
Date: Wed,  8 Jan 2025 12:18:48 +1100
Message-ID: <34dfcab0f529cb32b59e70c8bce132a9d82dc3f0.1736299058.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
References: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0044.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b9d458-6a30-4e49-1007-08dd2f8275c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PJ8zAXQoXAEVx0fHIyn22W8LcqWnECQ9D+LlVAvqgL+1ScDpXV0BITSzD89?=
 =?us-ascii?Q?LGWjpet3VvidtIUtCnnSj9ZOEdNhjDuSFklrkamlZDlwprCoC2f0wzX1Ckg/?=
 =?us-ascii?Q?yw4uIzdiwXvxkxIJhnf4lnvggxHSzuvb4Tt33TliBsQkRSB8qE3dfkvoAcjR?=
 =?us-ascii?Q?sglJ8ONRO1Bqz+UDmyrnyGzfFwFm+CiaiIftZTMSY0xYwbWZABGYuwchEZQU?=
 =?us-ascii?Q?h1TgBGD6+SnVxMjNyhklDrJGuUowMcdSG4kWHby1A7pP9Pp0ITRauEqZyfNP?=
 =?us-ascii?Q?opYUluV0BrJKXRiqBlf+1sDsABU0f8FUCSZynNG1fq6To6SxyRUwlmNOP0tA?=
 =?us-ascii?Q?sJWHE7CcTbnI0QK0EBGXvKqd6DFrRsGJOwMe204qNo795ebvJYdZesZ1+Nqe?=
 =?us-ascii?Q?QmB5eaJIQXah5UezKC2yXlB+ah2J2qIh+JU4ZPeOVT0Y5o1WvdiTYfISalUv?=
 =?us-ascii?Q?RYmn2uX0pGPc0TPi65BgpYHuJ+MxwCUOBugqZYBQfx+ePz8csRfHBnmyU5CJ?=
 =?us-ascii?Q?tSBNelskF5zYWdlIelYwFwtHL73HqBh41mzA47wVOV6nIHz7GEFm/4Mb7UI4?=
 =?us-ascii?Q?/Vbh2gLPHi2iN071gZgKi4u9CD5w1nIc+kClNIq8OC9Uxa6HK3jD9SMGMdqj?=
 =?us-ascii?Q?R3nW6tPh6JwwjMrgr21TJMapCORuOdS0qECMRJAvl2ibXKgcsngkIeK8YCYz?=
 =?us-ascii?Q?UQCLQxfhZOgn2yzS3EIQ4mFwdyJbwCWJDjGRxl1rsfd63oyZ4T1GcuowcLsZ?=
 =?us-ascii?Q?wvcjqkjzF5GAdAFbpWnfx70n8xgSFLCLmwHW1UEEgEn4MbqLc8I/cKLlYdXA?=
 =?us-ascii?Q?1JV6cJKP7Ek5NG67FcTBBQZ/J51N60lnno5o3SkKaFhJLwySNC6PxerGZhP9?=
 =?us-ascii?Q?u95s/iXw6xf/fxNW9ZLjYeU6v1SFwv2QsIZeOZgOp48HyrtV/3Svr6F9SIi2?=
 =?us-ascii?Q?s0+IzItrik4qBESKWQrVrtsEP4JKS1GT3YZA633DeRlsBWX3ToPoflwvaWsB?=
 =?us-ascii?Q?Sw78fxXogbzVX9e5yqE9T9YzAdN251zI4dogjGyxhOYi6/lLcRccwHdwXOCF?=
 =?us-ascii?Q?co/io7pAHDZ+IwPoNpwyYJJL94KgoZ7itCWQ8Xf8giFrQsa5Be7DWbXsMCSO?=
 =?us-ascii?Q?CI4HcaV6dbK3XtlqTqWdz2AmXvOuOSd94hlcf6qaMSjGTKDJQ9ZL8r99m3Sg?=
 =?us-ascii?Q?RjYGCG96iODmp+pAFgEvBcdA16cUU6zM+4xzUuNlYaoxOHFfy5uj4laiXoNh?=
 =?us-ascii?Q?31UsOWobV9PsrhaDhuJZikV9qFLdRTlOGNH3T5Q8ALvYzKh2voiB2i0R4RR5?=
 =?us-ascii?Q?wPkbRVuklE0UGDH1ux1q1fz2CyZyOlRhwSarvu2Sx9MxXpHD+HDrfWXoF88r?=
 =?us-ascii?Q?P5PPskdEr9RK6mZpbA7jh3HCJ7A0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c0HUy9jjvJ696px+5rATlcFiIxXIsVfGjzh2iPW2YiMGT98Y0UKCb+Xx9G8D?=
 =?us-ascii?Q?sO9vLIU2Ka+PM+9bOn8YBb9SJTQqNpfpE30HzaC+U2ofsXmnEvFhYGAxGpZT?=
 =?us-ascii?Q?yFwt+WFgJuKy9tcN0wK8PSkGx2NXdvrxFOFzJprtaAwvy+dXNAyUMafiCrkp?=
 =?us-ascii?Q?waEmsXZKwLvRbzYMzXse+Hh3usxofi+oN/5TGWH8LXk4VK4LYjcvJrgoDNaj?=
 =?us-ascii?Q?zHC3DuM/2KzZAgy3ClEM3pNJZWB/PBddonzRGSzmgGtPjiCnXZKe3hJTZcEy?=
 =?us-ascii?Q?4wuAqiiRM8E+TKxJbbtzFhCtJNKzQw0SKTgRXI0iOuxXheieMiMyGwm4HAFk?=
 =?us-ascii?Q?P9SL/Q6W8+gkIaYG1SA/vdXE5TJf0PkimsusvgaeH1quh0zuykQdYm6EIrU6?=
 =?us-ascii?Q?HpqkKSjtFNRI9KeMsUSHWtIVokrZM3c4WbvzqHPU4i14tYfvoD/uhk8F9HCq?=
 =?us-ascii?Q?UTzLocp9Q28DpzSKAuVu0Qk67kgt5a/I1x6eHlIsXdOtEwgMatc8oY5JhwvY?=
 =?us-ascii?Q?0PBeW8dzL6bvtcTLiAccVQK5jAgL1QddbjvW+wfpzpa87XIL/btkHL88LLmg?=
 =?us-ascii?Q?Y6NM9TSesbHlfRNk7wjqQ8HQhzVHE6wQ0oOQIeCrqa7Gnak81IMeuXs2RLGm?=
 =?us-ascii?Q?Vgoiw7XO+z59kiXt9ljqBjnFeGiDZO8Czmf2f2fxEfVVm1c8G2P7yMiNxgAm?=
 =?us-ascii?Q?3QydX9L3KB99V+dyccnX0ZONFZAjNAxP/ZwhgPPBr/DNstKLpF7bMTdcfncp?=
 =?us-ascii?Q?SC8kQ7UTZfRE5JSdKPGkdsvexIQcqZi5KQt/NiEKMaIyERndt7CB1UNzwICC?=
 =?us-ascii?Q?4QM+2uTGcUTTBrT7BLcWRW77/wB4BlhZeJj+0KEQjHnW+QMZnUY8yeYovp0U?=
 =?us-ascii?Q?I0MnGIbThj3Mmjgovv7qva6DV8e5z5DjURjeWaHUm2uWIHLGlnpTITTgiA4j?=
 =?us-ascii?Q?CzGn1dPgWIidYwSWdfpQgWwaX9OjVYKK4kt28YHy0uIMBcHEph0eOMXVhuIn?=
 =?us-ascii?Q?jfTbL+KZKsPEigZxRlvdIBS4hUkJp4zWIxKvdYAtjA+5XBRcZ2LU/KqhXMKe?=
 =?us-ascii?Q?EOrvwUrBehyIzx0w4idVUnFHbzwPe20vJuJpPi4G7eHron3ngIwVOqWyoEY0?=
 =?us-ascii?Q?UvCLzc6Ql350JLo7RzBWsZGlT7raooRjHnR7pRxxSu97h7CXwud1A+EXa8mr?=
 =?us-ascii?Q?TV8183klexpIteAy30ZMb3ZyntVSed7MAI/+trzQRfAkGh6d0u/lzNtIqWbB?=
 =?us-ascii?Q?upWWLujb8SN41VH7c7NDI69Ghfsxe2mJEX7IOpbzbAiPpfGsGnIsI7eMK6PM?=
 =?us-ascii?Q?LXljWYG+jtQgG3QbItXSG3w3KDTvZoU5Epq6nOZLCNpBhfF8fhhP3mv0SOsv?=
 =?us-ascii?Q?mDgzpbM3ZFHrfm2u8P4Jv44++7VYpCCsbcFkMxaM7SuhSUtO+L7RDagw6iK7?=
 =?us-ascii?Q?WUMV6/h/UuWHEfjogYJEB1LOm0+rWez6RUh+WIzp7PeKFGaDLk4sx0fPyACF?=
 =?us-ascii?Q?hYmmcj/5DbQXBXeese1RBSBKSnpeYu7i/WfZRXMp7qxr/MWK+gTgPByz5Wv3?=
 =?us-ascii?Q?5M/TPS31mWz3K+u0ya1QLfKm4zsHJ7Cs0ERy+rUd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b9d458-6a30-4e49-1007-08dd2f8275c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 01:19:12.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUH/Z+Wbrezqahemi0tVm1WzeHRHDvkkVhS5F6k/dZ6bDukB8MVf+5Hmgm9gmh3TypX3kfDvaWBDMMHDufS2fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264

None of the functionality in pfn_t.h is required so delete it.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/pfn.h   | 10 +-----
 include/linux/pfn_t.h | 88 +--------------------------------------------
 2 files changed, 98 deletions(-)
 delete mode 100644 include/linux/pfn_t.h

diff --git a/include/linux/pfn.h b/include/linux/pfn.h
index 14bc053..f4a74d1 100644
--- a/include/linux/pfn.h
+++ b/include/linux/pfn.h
@@ -5,16 +5,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 
-/*
- * pfn_t: encapsulates a page-frame number that is optionally backed
- * by memmap (struct page).  Whether a pfn_t has a 'struct page'
- * backing is indicated by flags in the high bits of the value.
- */
-typedef struct {
-	u64 val;
-} pfn_t;
-#endif
-
 #define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
deleted file mode 100644
index 034b5b0..0000000
--- a/include/linux/pfn_t.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_PFN_T_H_
-#define _LINUX_PFN_T_H_
-#include <linux/mm.h>
-
-/*
- * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
- * PFN_SG_CHAIN - pfn is a pointer to the next scatterlist entry
- * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
- * PFN_DEV - pfn is not covered by system memmap by default
- * PFN_MAP - pfn has a dynamic page mapping established by a device driver
- */
-#define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-
-#define PFN_FLAGS_TRACE { }
-
-static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
-{
-	pfn_t pfn_t = { .val = pfn | (flags & PFN_FLAGS_MASK), };
-
-	return pfn_t;
-}
-
-/* a default pfn to pfn_t conversion assumes that @pfn is pfn_valid() */
-static inline pfn_t pfn_to_pfn_t(unsigned long pfn)
-{
-	return __pfn_to_pfn_t(pfn, 0);
-}
-
-static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
-{
-	return __pfn_to_pfn_t(addr >> PAGE_SHIFT, flags);
-}
-
-static inline bool pfn_t_has_page(pfn_t pfn)
-{
-	return (pfn.val & PFN_DEV) == 0;
-}
-
-static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
-{
-	return pfn.val & ~PFN_FLAGS_MASK;
-}
-
-static inline struct page *pfn_t_to_page(pfn_t pfn)
-{
-	if (pfn_t_has_page(pfn))
-		return pfn_to_page(pfn_t_to_pfn(pfn));
-	return NULL;
-}
-
-static inline phys_addr_t pfn_t_to_phys(pfn_t pfn)
-{
-	return PFN_PHYS(pfn_t_to_pfn(pfn));
-}
-
-static inline pfn_t page_to_pfn_t(struct page *page)
-{
-	return pfn_to_pfn_t(page_to_pfn(page));
-}
-
-static inline int pfn_t_valid(pfn_t pfn)
-{
-	return pfn_valid(pfn_t_to_pfn(pfn));
-}
-
-#ifdef CONFIG_MMU
-static inline pte_t pfn_t_pte(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pte(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline pmd_t pfn_t_pmd(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pmd(pfn_t_to_pfn(pfn), pgprot);
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pud(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-#endif
-
-#endif /* _LINUX_PFN_T_H_ */
-- 
git-series 0.9.1


Return-Path: <linux-fsdevel+bounces-51733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A058ADAF7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD5318813F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C72F2C78;
	Mon, 16 Jun 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d9LRtS2r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACFB2F2C52;
	Mon, 16 Jun 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075137; cv=fail; b=XuZ3k+CYtm8YdO7gdyFe/KYXWUMrjOT0/cvJOfuc0wuh9tWGAZwUbQpCIAkVNZhfkCSkOUYodGqr+M7r7yhXDLTS+Xvkw8+qYm5G0FG0UErx28z7BD5gguG2vQNtBQdVtNc5BgNBSVYBcsYvue2vcyW8p7ZBn0KIOIhHpHcotY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075137; c=relaxed/simple;
	bh=nxLLxMWEjG9AzcKShQMcPSDOgQoJiP578d4Mbfi8r4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XN0ClTJmYvdlnqxHDp+KgWUUHH0iTgNO2OJwm+BxSqd6dFXbbTEbkyk34pCjXn+yo+SiUy7tNYJDWyk3eQkpLrKCVb2wR55MUcFqV0ZTSwJdUUze1MlvukvGiyyrRtpYrHohWUfiiWuD27mgRvci1aiTT7mKBE4V6q+oJ3DMNRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d9LRtS2r; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt99zHlhtn/X/6VK7yhJc0kUuxZDc/Qj1xOhZiZk6qwTPdVyfe0nsmQa3UIOFs3j6XiMgph6zb858max/1oE9iyaJbvyJhINChoBIFbnQ9ErKdJPdxexHb1rkNTFdb8tYZRTUBPHbbX+3mpp6zMXSBj7Kqmq+zICK8ZkxjSz3w1vB7EOkUqsIHF/ukAumE7Urvea7GrndcsaeCaJe6yutL9cTC9uHnT5s1cYpgzEqhML2Pg6RxW9xMygb1woqiovWRYB3g/425q1bu2besBxdxPo6X8rga3j5Rq3tam4JWcfkYMbYL7vlN2qWNn9JWxUa8BlrGvRO61tgndDnmj3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eb7SedNyqiJVFk6RAa1SW04cMPjC+VNeUeacZeAmoc=;
 b=MMnqgAYsYb0am0GwPf0jUU4fLZHZD4qVTy1qp4MmANNu5I4AGxRiuOvG97Zy6Kf7qR0BzvrDRzHvkDFIKKUwdaN/Q82b6suCBD4G+8Ikf6vmaAzAm51m0pBsKO8Gr80Q8617NJCn8Fh+kmA0K/bwg0wGvPGh5RojEhFWd8q+zpjUN4HBMOPvNCuInS5LySeKFUdm8Xags8kR5yAVLPZnxkYDg3U8IPWrSqYigcnLeg/GqO/HYpPxek4KlawOOUY3VLzBGHFJTVCckJk/kk3vlIga2SBJ0IFdB5Dj8IdZjU0u3GJRMAfxoM3ov78NI7M3oEbW/qumkA0VbuMa+QMatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eb7SedNyqiJVFk6RAa1SW04cMPjC+VNeUeacZeAmoc=;
 b=d9LRtS2r1z5g6Nxwg+AOpQcpAKjLzhAiScWZcKZufpcIMLYR5329bO2cu3MCLOyTWp515t750si1n90U/KMeJGv1iamOpLdxV+OBLq7nUxkqJE934rPm/aFHEK8KsKpEoEKxFo9zXEn0gXZNF6NFhZ4He9cj9bQcMDBLF8iWvJEmPX5QucQ9AA/2lskPBDyAS5gobD7IxcnWSr7mUeK52BI9C1cWgmTJwavSWeBdaVstgjgeYgVR4wvXtvbh2QFzajngdAvcDagDsIEgM5D9+cl2GuFjDJSh/LvGF+iAh2HKmUp7W7x51LWZ5FbjkEzp5CKQOYKayLDF3VP1XCLNlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:58:51 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:58:50 +0000
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
Subject: [PATCH v2 03/14] mm: Convert vmf_insert_mixed() from using pte_devmap to pte_special
Date: Mon, 16 Jun 2025 21:58:05 +1000
Message-ID: <5c03174d2ea76f579e4675f5fab6277f5dd91be2.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::22) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2bf0f7-f53e-4889-8bd1-08ddaccd289c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v+YdE3b7wLdiaQuF7qPQqpeAwXXd+IkSu2px6olcdQe1H1wk/gWa5UzhlWvJ?=
 =?us-ascii?Q?cnepDM2rs/z+C1chqnoZ41hxYhrr66pq5mgOu00iNHlb0td0v8dkEHqAjDiu?=
 =?us-ascii?Q?juySIQJG7Hr1DhpB5aridWhukRLMafkCOKNe6gJR69bqRZVMK2dFb6toso3w?=
 =?us-ascii?Q?BsurC1Neq/FdIqai4c/ABKWvsORBOXGhOUCyxE2Fb0wXdX/xYjf1admBStom?=
 =?us-ascii?Q?YNHit6rSjJBdZQOVy/Fslw5891/fjm/vHUrIV8aZyHnWM5kqe7Af/bQ0FgSX?=
 =?us-ascii?Q?4yIdtrqkJgot8WJ1SFLnk3WShE3ZdTvFhLR2+y2VmLnpQA+eIxg9T19d3O3z?=
 =?us-ascii?Q?yzk0ujOH8qzMzr74LKMxRcHFWcTpRmWptFVlE8qEfX9ZjDKwexVPZgzTg0LF?=
 =?us-ascii?Q?yG+tUmK8nGk9ceDmoQN1lzU/QVQ1NzwpRwNJsWzUMTli2zu5YJ01mxotU9g4?=
 =?us-ascii?Q?TihnWUpHXNpYTsUalZ4gFuq6yWW6ikkr1KZz07KPGaNop1T8pa+M7wFrlFjD?=
 =?us-ascii?Q?Qr1rJGJG1zRxp1Ni2CvCuEVe6aKvWrJpZ9YPsCm6DQAKro1jFtClyf/qUHbj?=
 =?us-ascii?Q?2jj3v4s1n27Q3z71ozZgAi8NAiDNyoiO6fQuDOFaScB1B6UndDi0vu3Av5yx?=
 =?us-ascii?Q?7sHdyyvEbEBYHz0JIxdMsNbd1HEVlOh2SZ/971PHgnHe03KRCaEs8tw4b/M+?=
 =?us-ascii?Q?snXo6BBjTRQbNHfdr3IlhaD19t5wYPYSbXNGCusw6h2H1xR6BoI7V99PJOQz?=
 =?us-ascii?Q?cy6Bl5GakAQsRbVZrLb7yXLN6RIAd5LHRIdLGKn0/BrAf6rGKZg4CF/mon98?=
 =?us-ascii?Q?RLIgmqWFDGCGiWwn6JHOiQxkhkxsFY70rDPDba+Qw+bWgsRK1XEHbnbPcTGo?=
 =?us-ascii?Q?Jkxf1aRsXZeqPTBs+c+5Vt5NMUPFhOdWZgmtpalXY1iNhQUMyMSYGwGKF3kt?=
 =?us-ascii?Q?/IWTaRPStS8YjSdegVz+NNR7rFmMdYpoRVfv8u5rcOCl/hPNBHo42iaAX0Hr?=
 =?us-ascii?Q?x3irpg8J5LD+tvfEGudjLj/LTfGBzXdCVLkWyL3R4lfu02Klz11oLEpNHGqB?=
 =?us-ascii?Q?/3yMTxvo7BQZLM07V9HDEUQdMC1fQWolpwB4uMOnXA+PUZzY8VdXpHeAX63L?=
 =?us-ascii?Q?TgiDHEhoMj/PBzG4ZwV65+vI+4tPXbcgNlhg7hG6XB7IgCt8wGEf7GPWgd/E?=
 =?us-ascii?Q?6H0tHlGyh44IKXPi6mr2gDWMbdFWmMsajai6bzvfd9Pno7tC3lFFe/M27+vD?=
 =?us-ascii?Q?EcCDyiOyWO3aO9YjGopfJwwqzXrwshDvNyd/rRpFCCmbe/K3eUcLGHYbPicE?=
 =?us-ascii?Q?2xKM8rGvL96M2YibdHqMxECXVw2xUWvlkaZoiLrPoSeRXIkp6prKI8NNY74o?=
 =?us-ascii?Q?EBAoZdYapmGL5a7EJwKShWDblCrZ5U/ockMlL76UnEBG2tS2dQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hUdBqBSFRYsmMFZjbjbVPJBNnLQxbexIBvGT1qhj4WOmaq+gXCt3nF6qn3p9?=
 =?us-ascii?Q?YpHyazk1hT90AHQnZODvUjmVIv4gjPrO3GFviNZmoAYc5jTw9xcXxJYCy2JW?=
 =?us-ascii?Q?2ReF4Prr9r4iL/a8TeNVfqKFpSaiO31J6fDOy9Q+GwvcgBTDmzlI74pGb04E?=
 =?us-ascii?Q?VVx/XNJu/NAoZTxtFmZOyfnYrq+ISQb8EbbZS3dNYFJHnErWOFN9EG56Y2A8?=
 =?us-ascii?Q?eNQ9A9RDDWksp04tb/lYLr+VC4uHwXaSzSbwWtRx+u7wARmSaVkP0ogC3RxM?=
 =?us-ascii?Q?t0TZXyupJYfrHqZL0xy3W/jyTDU4gN8g47V7D4ESEfHCuytw9jlAQ30pqg/H?=
 =?us-ascii?Q?TXopqqi2veAGBKwX+IqObu68T887/x5Y/G1VIH6NsCQ+/Ge58NT6bT7a7Gj7?=
 =?us-ascii?Q?H/ZNqpR4cjBR6iZHyucWpoQN//oNCCWZ0NJ0nOMfAWbdkgSRhBwPYMhzzN/H?=
 =?us-ascii?Q?xebv8JNXBfegcuLgA7T4WS6Wm2zkLtoQlDUAMldZKF6rISYvcrq/c7JlDYjv?=
 =?us-ascii?Q?1ytm1WMCQKL/Qys2mxNcuMAefRLcoa8Kprlqjy6Ew9d9lAqh4QVGLHrZO311?=
 =?us-ascii?Q?BhedpM9Usj3FJnjHy3qeb+Zo2PWxH4L4GesWETNxOUZUcDNfIXSdBy9mhVQB?=
 =?us-ascii?Q?xaBfvhW7CkUV6v6ICo491t89zGXwvdFD66y2mfhEwufq0WyklHXozVdic32Z?=
 =?us-ascii?Q?r2YnxLwmSXwQ9MSCC6v7XQBUemI3w8/v8BXn0ZyH+T1m2/JrPF1qmO1c3uDR?=
 =?us-ascii?Q?b0175chcfZTPNWvx1IqGYPcJK7igaXPd+vDzOVM/1lfLALRr8yUXKsR1DW3C?=
 =?us-ascii?Q?7VRYE6mx8sTAU7xEZTz5EgNSWvJqXCKdeQZJE0nccNANuf6u2BHT5IUiIXpt?=
 =?us-ascii?Q?3/x8wKmCCsEIAXZmKETs3Hb4wZLFLC1h2fcq4fzeJ9h/Mp8gyq77XV+SghrT?=
 =?us-ascii?Q?zvHtSvW1UIBNUdVxWw5A2b71dB2nxy8TyIDfCJz+kb4J5WtaMa8m63lxc8sU?=
 =?us-ascii?Q?u/cqQDl/f8OiaQciavK7JD3D2Y0WcsGX5sMp+vWP2AGIR14BItx3RgTDvG35?=
 =?us-ascii?Q?fUG5Du5oY5sm9gBa+fm/RENSyo7r7MTY3lReYHogG8RzGJQ0vrNj8KN4n2CU?=
 =?us-ascii?Q?MGipZlQLx5uZIZIi3uu44AWvp2bJ1sH7Vy0i5Tiuyo5iLkOZaDHwE+XpXB4b?=
 =?us-ascii?Q?AevyI5KbvS9qNL4PhmY2F3nvptCiS1AuCUMti40n5hsFy81QmaX7gbMODqHd?=
 =?us-ascii?Q?5/0WfkkZcMAuPrTD7BNppXzsO/BfJwIVHw457V6mj3yCPdJOaCxP0KVSEfIq?=
 =?us-ascii?Q?MLsy9wmgKNb/ZbPItdMgvzjs/lILymLYjJMfPCBUNmVM+Pi4Jfw/5wVGE0ck?=
 =?us-ascii?Q?lGqfMi+BdTbsXzP+HtLYlEYAXjEW5i7Z7UADJS+k1tTPZssUHPeAsJp3Rg9D?=
 =?us-ascii?Q?R/+yJzqkGOuY6Frr/NVELpqYr6yqVCePAhgol7S3pG7eRGY3YF50h3OYgCgc?=
 =?us-ascii?Q?g4JcVViwWIhvljtLCJWBU8S5AerHx0WaT9bjlHdWLbWUOSsMJAu4P9E60Dkh?=
 =?us-ascii?Q?pdtgaxv1EmuVgs1yHZ6F8OysnqN23N6Sd1HcTX0W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2bf0f7-f53e-4889-8bd1-08ddaccd289c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:58:50.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KI1ikL5n8xCiqOHH8qJ3h0zCUQaQJuOpHTtuq5UgPIe/7PI+P4L+HeQYC+CmLwN9n8R0Cw4SjhoM2XULAPkYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

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
index 5311753..1a3489f 100644
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
index b0cda5a..2c6eda1 100644
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


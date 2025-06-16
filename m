Return-Path: <linux-fsdevel+bounces-51735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC7BADAF8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46389173AEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E4A285C97;
	Mon, 16 Jun 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aahz0Saf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C82F4333;
	Mon, 16 Jun 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075147; cv=fail; b=MDYnotKPqjyI7eIoHMJb2SXBSNoKoTxKrYXu2q5Q9KOn6KT3N9KAR2uzoiULfv5W4ybKptt/mrZ7Xuy3TRfpmubzOR6A8QHrxHG1R7aaT9F0TIMvC3pVjbEzDSAKEMOfrMv3h1xjkTvcYZgSCIpQ9DhE51yjCrE0Y6VBmiGZy7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075147; c=relaxed/simple;
	bh=O2sVvJFeeG1iLOU1y1mchy78NkIAqYEJIQuYKqgo5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQ8amnDRg6OLgVH3sN9PHfHm+5LryiQQxkMV4TmSGDNxi2c1o4qq2LpCTQhfkWzhXV2Jl7smE+X4vw6tBfBdVkS9UlTHvyFJy7ykZ9ODTqVW7/DxM8qqmZT0o0VO3K3VdMkc1CJQK7iSt1Q83KtYHdelJYAmB99ndhMS1PGxBOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aahz0Saf; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvVvbkBdDMVbW4jVMuUqLdSstwztUo+k4747h+PiWnXStQNz37N7BU20tkce27KHCWJVysE7mejXMxnZ6/w7iJy8p/UxYaFlseP2Aap3/gKSqp9Bvh31SgkVe/u3oqS+ZLpwtggN7Zl9asT04u1q07IXnt12/7SlkO+uJuQYkSOgDjyHWpp0yq88RhawfsXzpS9Ti1XgG9a9DmE/KEDj4EyGCZDsMrlR7qxC2WX3asYAihgT2sgW6FUnJMjaMLHw8/yGTuS9TSfQviznl7JzguibqgEddIlo8VUHBSmWN9zuC2Rcg29/ycpdHOVirKPCvg/H4bjZzjeTenDIgN0LxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnZeq3cuLMjNKLSgReQcyWEK5ZP6Wk//oJbJZEIiw1Y=;
 b=KlX1zt53QdQvu7IDdbx7mLtUloDcOMqpvHFSZfPPwev96ItHvTGqotiDKm04YZC0GzI+VH2nieUt46W3nyr+9Kjlmcueo7pZ2V1AkjcPg5GDFwM6ihKGPrlxLwh2ZY/RkggP1cEW7uGt6oc74X3j34ggBwa83a8/Db+Yba+rjDoML7yY6BkZdIP6Gp+Y2xmRe3ahRU2YC6ga8q767SzIWZsun1VBBmwvlna/swLbtOJ/akCNx0/VCoIT1jWuqXkmXFp6b3NrXyUb+gTwbQIOodtSHQVFfWG/tgu0TLmjSl72mDxay/ctc0bsWYbYYkD2KW/879CCoR8y0kneW35NjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnZeq3cuLMjNKLSgReQcyWEK5ZP6Wk//oJbJZEIiw1Y=;
 b=Aahz0SafATHpa5MJHDUhc3rlKfUMJVwLPBSAfK6mnjAP9YmWRJfWJ0epGFFwGIqb5bf6AWyy+iJQFk4GMmpwNMSeVJ93bzlQhxEZXXEOUsJuvm/gVFdbS2+HLPiNf8kVngw3GuKNierF9Cln8dl5YrHfc/j7nsvZPLYsFPOo/YDz36U+zYc39etiWqg+c7ujF5qNRefvqw/c1up9MaTzP773Zu2PwqIORI2eNEHPKkmcrdxzAduFFnrqeEyfhyOCcv9+v5P3n0cs/vCORtv5NHOlXFhF8ODjI2hAh7ev9xZpWsnkozsgtriOCBwv7O/rIVaniSV6ZqYFj2p9QID/bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:59:01 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:59:01 +0000
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
Subject: [PATCH v2 05/14] mm/gup: Remove pXX_devmap usage from get_user_pages()
Date: Mon, 16 Jun 2025 21:58:07 +1000
Message-ID: <e6f00c4b64843dbc0494c5cae9cb861cf7fcd8b6.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::15) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8742ef-cb85-4184-bdc4-08ddaccd2ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99tcTeRcfoJZTarD9O08jPDzZQ9xDjkYGHj4JdmGNQNnrFHIlezK5r0+e9w0?=
 =?us-ascii?Q?8rh5W4GwdEO249VyyojYzipGouOc3pP+QXFb+icI/2k1Qoszm0Huz6E3hreI?=
 =?us-ascii?Q?x69ry3lqI2VXR49e4IztU1KfwN6y6TxDtd5Hav8fmyF68n6Ntrd2V5sDU/3/?=
 =?us-ascii?Q?TssWJW6+/NvCKGTUgjvzXwkvoVySvZ0YSyLJfVvfmB+z254Tb4FNUus3iurr?=
 =?us-ascii?Q?TfmkBI0cCNDogzQin5znnXHMA2n/KV8rpVSHuo1oyl/D+pfa++AmzPfkLBDu?=
 =?us-ascii?Q?OuTASdGehhxVXNl+noLq0Tzvhgh/vU45/gzfsYBeYNAiLuvm8L2iBNZWCqxr?=
 =?us-ascii?Q?3/miQmjlzqnJPJfh91tjApQ5EhCVfCl6yinyhYYcvMSgdnu1rLwc3GAWjoOS?=
 =?us-ascii?Q?+dZzMWKiKccfmkddosmPFtbboYukY8t84MM1t3C4PJ7/zU29qugasl3+1hZX?=
 =?us-ascii?Q?p4Mzmij+wlfIzODD0VqbTxwCK0A/CXVhlxjcx6DRosptlJEfuZg7Cq6DyyxX?=
 =?us-ascii?Q?1IYd/xdJH+DAryvAG+HRc7qtn7LRKBJI7J+CueBZ5a6UN4t1Eb6ddb+wSCV6?=
 =?us-ascii?Q?hakaI9iw6WqkAO54o+bxvOXvTllJIN4XhFNhqaAdArnKp9OXspzBoCmAG93l?=
 =?us-ascii?Q?qqAV0pWWQK6tOjgoCvbWagqfGFXuLo+y+H1ut371OVw4b2wD+OX1E6pCGvzc?=
 =?us-ascii?Q?JGX+s47YDn8UTAlomK2nKl6JTAMofKYSWIH61a76UUbEzopDSnQoYarrAAGw?=
 =?us-ascii?Q?E0vrvDuSoSwQKk4fHDdHtmXj+Oq7EvGUdq8/q3W6uZbUQW/wnBLXRDumXfhJ?=
 =?us-ascii?Q?EXwYvbgOvo+qbQzOMShNzteYB9o0aBCK+e7aVgNhT+dbarYTmO7XPA2iSQAP?=
 =?us-ascii?Q?FBEzexz77cB70C1Q2Y1LlzEHM3IgjnMQidkO7mX5UgAcMXQzoinHSnR7j3SP?=
 =?us-ascii?Q?pqhgc8g0ia0chyK8gtcUgHq4kAQve8z1zAwX2AFTm48hFO0TIOfS/4BRMhXY?=
 =?us-ascii?Q?cC6lRiciOm3UNOhc8I9MTjoMyEOqn5UPDulOfylZCeX3yEeHIDmo5BiWzuLn?=
 =?us-ascii?Q?IkibUa7CfFSH6v0tqg3ybUMbGEpQ5PwxptuOkHh9Fw0elkGFQkiV4BEIFQP8?=
 =?us-ascii?Q?JuWgNzJdO1x67HP2CSVFZlYUDVTWOjPRyX4k/kQAO4VBciHyNB32hUX+/BvO?=
 =?us-ascii?Q?QbN6EerQg1rsPZH/HqFgMKCd5yBCrFpLVB9f7k5aqWyw/R35j8gInsXePhNV?=
 =?us-ascii?Q?tGYcjyXyODM2ALmYgdea+di4XX+aBF1LITvKMwmcRyrGTqT4spu1X/DgGS9+?=
 =?us-ascii?Q?51qmF4UVKmU8tbxTVgR40MuYDotcgZxF8qE8FJMBEhewwsPs8Y1OOKSMGOLJ?=
 =?us-ascii?Q?WWIuz4L4AkK7lDbeYnU82tqPqmQBrsM7CbQLjUYilMzI1A5C2dXNZHuRIWAN?=
 =?us-ascii?Q?2M/Z4YPU9O8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lf9AnVEOSs+Gue0cOzYU5QUK9NPvCtbuQgLVQKyABSmrgmfh/hbSmDELtImQ?=
 =?us-ascii?Q?cPAVKT9x8QdEZdgfCHGvx08B8Yz/PX6R2DHJqs6jH+MfI+AATyR8exV3MLFL?=
 =?us-ascii?Q?h/MJhevm+Nce+8l7cvwlXsso+zYZiOoQrVQiSAFnJltaS6kX7eiJ6ud9z5pP?=
 =?us-ascii?Q?Xb16CsgI+fjY4x93WocXUc8tbxMcp09pTDIupkmphe/W/TcEWTIS/h0aQIIh?=
 =?us-ascii?Q?uvyNVUHR4AA63kNNTwxgC+cUduoOWTh1M6xl5ZOpec9PONyvPr0wZvAvwbWr?=
 =?us-ascii?Q?klXLNt+0DJHmlm51gQKFnS08FyueTWyTkXeHTLISaAnd0lMys9DpGYKLynBS?=
 =?us-ascii?Q?5ifrbofRfz7R6ki02WuzTjc4f6i8nM/WYQLan7k5bzI62if67k1A8WlR9erf?=
 =?us-ascii?Q?ONbZH/mIhRNr6QID1Vt3m8lJ4QjHYHVfZPz49AxN23KTBol2CYyVk7lRO6y0?=
 =?us-ascii?Q?o7kf8n3tMX38Er2GEa/wewk/rcIkwq438Gq7zWtHNmk4WFzkxPumRGtz8x8z?=
 =?us-ascii?Q?yggvbhcT+wx7BTicyr6/6fAMO0kSgCoq/09UPjMSYT2LeuC5C8iLE5bk/h52?=
 =?us-ascii?Q?mhdQKPnfDhAAMtAUkeuM/xHJChVr8P7vX64v5fHAdXSYRBHcEqRVqzxfuP7r?=
 =?us-ascii?Q?8py2CydTw1HwYQD3F6z26MuJwCYolUQoDYHYIBaMA4ors3qM58SYu4+v0/4i?=
 =?us-ascii?Q?4BdXD1adwDQN6ofbM+W3VmOU6yEOPnNFy6+3Q8ZUl9iGjunVc/GUaHmRroOH?=
 =?us-ascii?Q?MtmmaC7UiuxQ0hY1qcs+awfz7O0TqH72wW+RQzv9ChpYUrYeV+upb7d8FAoq?=
 =?us-ascii?Q?Nnk07TUBRURgIGgfXLXSnsgLBJBcyErLTxUAisSm31G9shsCacoa/l268crW?=
 =?us-ascii?Q?mg061Mtnw0fD9xBC8pQyjtiEuGCGPAvfKBdd45LKM5MLEOYzV18dU6jEDL/L?=
 =?us-ascii?Q?di61JjXqYdHjegL4sVxnpGOtgmHXUo631JpzgyfIYAly40khnfo8R9gkntzZ?=
 =?us-ascii?Q?LnGna/E7esan4bGvaGTh5EzRSLy4+qIgdEyQS+p5OMls8HWYgCEjbZ89ouWi?=
 =?us-ascii?Q?JUpppNWzybmpF0UthlgfbfVXdwoh7xC+GYA0nEs6fQftEnEXpltdY5d3jQfa?=
 =?us-ascii?Q?grq2QoGrjTa8ZYnZ+5TLcEvqPyDwl8GN2EqSuP5fk1C1NsC4EWV7vR9k8Xik?=
 =?us-ascii?Q?Rc7nVTcqmosdDNP3/+224clpEjtKba1oCPoCfEyjvDlHKp/KOT5qDwDWuvgx?=
 =?us-ascii?Q?etFmswcRVr+P80nuv6mmOYmQXYQkfOuDdyp7ZkkYTcETOnAISYMaSgsv0/TH?=
 =?us-ascii?Q?JemNJEVooQIzaCCWrjh/7hlOZWKYNRk4J58O7jd3z4xnJnMi0O7OsAtw76cc?=
 =?us-ascii?Q?Ppy6CjY3N+cJ4LR1TrbXgvYRPkXNpbLcIz3OzK3rbdRxB9E7CgaAFHYJuLdl?=
 =?us-ascii?Q?Hc/BL4ZUcj+5wcEnwYG2KC3jNDWxvDFbSTY1MMsw7Lmm847a6m/jQTVLf1NM?=
 =?us-ascii?Q?uzmqyZww13NUcb0mbXmcLrKmztO45wVIf7pEyjgils2J0zqSrto7VXM6DFvH?=
 =?us-ascii?Q?MVpLeWLw/uwZ1H5KOjlSgT0iQjGacVKt91Phm+8W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8742ef-cb85-4184-bdc4-08ddaccd2ee3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:59:01.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8K2oHTozIX/ASSWb/cmgIMfzv/Ox1AlVTcwQ40A1wr2Gi6EXIDZpYAxgV7NgNp3CntlTbjE3PFaLaq+WfdCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

GUP uses pXX_devmap() calls to see if it needs to a get a reference on
the associated pgmap data structure to ensure the pages won't go
away. However it's a driver responsibility to ensure that if pages are
mapped (ie. discoverable by GUP) that they are not offlined or removed
from the memmap so there is no need to hold a reference on the pgmap
data structure to ensure this.

Furthermore mappings with PFN_DEV are no longer created, hence this
effectively dead code anyway so can be removed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/huge_mm.h |   3 +-
 mm/gup.c                | 160 +----------------------------------------
 mm/huge_memory.c        |  40 +----------
 3 files changed, 5 insertions(+), 198 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c9..519c3f0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -473,9 +473,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return folio_order(folio) >= HPAGE_PMD_ORDER;
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
-
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct folio *huge_zero_folio;
diff --git a/mm/gup.c b/mm/gup.c
index cbe8e4b..6888e87 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -679,31 +679,9 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 		return NULL;
 
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-
-	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
-	    pud_devmap(pud)) {
-		/*
-		 * device mapped pages can only be returned if the caller
-		 * will manage the page reference count.
-		 *
-		 * At least one of FOLL_GET | FOLL_PIN must be set, so
-		 * assert that here:
-		 */
-		if (!(flags & (FOLL_GET | FOLL_PIN)))
-			return ERR_PTR(-EEXIST);
-
-		if (flags & FOLL_TOUCH)
-			touch_pud(vma, addr, pudp, flags & FOLL_WRITE);
-
-		ctx->pgmap = get_dev_pagemap(pfn, ctx->pgmap);
-		if (!ctx->pgmap)
-			return ERR_PTR(-EFAULT);
-	}
-
 	page = pfn_to_page(pfn);
 
-	if (!pud_devmap(pud) && !pud_write(pud) &&
-	    gup_must_unshare(vma, flags, page))
+	if (!pud_write(pud) && gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
 	ret = try_grab_folio(page_folio(page), 1, flags);
@@ -857,8 +835,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	page = vm_normal_page(vma, address, pte);
 
 	/*
-	 * We only care about anon pages in can_follow_write_pte() and don't
-	 * have to worry about pte_devmap() because they are never anon.
+	 * We only care about anon pages in can_follow_write_pte().
 	 */
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pte(pte, page, vma, flags)) {
@@ -866,18 +843,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto out;
 	}
 
-	if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
-		/*
-		 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
-		 * case since they are only valid while holding the pgmap
-		 * reference.
-		 */
-		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
-		if (*pgmap)
-			page = pte_page(pte);
-		else
-			goto no_page;
-	} else if (unlikely(!page)) {
+	if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
 			page = ERR_PTR(-EFAULT);
@@ -959,14 +925,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
-	if (pmd_devmap(pmdval)) {
-		ptl = pmd_lock(mm, pmd);
-		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
-		spin_unlock(ptl);
-		if (page)
-			return page;
-		return no_page_table(vma, flags, address);
-	}
 	if (likely(!pmd_leaf(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
@@ -2896,7 +2854,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
+	int ret = 0;
 	pte_t *ptep, *ptem;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
@@ -2920,16 +2878,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 			goto pte_unmap;
 
-		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
-
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
-				gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-				goto pte_unmap;
-			}
-		} else if (pte_special(pte))
+		if (pte_special(pte))
 			goto pte_unmap;
 
 		/* If it's not marked as special it must have a valid memmap. */
@@ -3001,91 +2950,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
-	unsigned long end, unsigned int flags, struct page **pages, int *nr)
-{
-	int nr_start = *nr;
-	struct dev_pagemap *pgmap = NULL;
-
-	do {
-		struct folio *folio;
-		struct page *page = pfn_to_page(pfn);
-
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
-		folio = try_grab_folio_fast(page, 1, flags);
-		if (!folio) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-		folio_set_referenced(folio);
-		pages[*nr] = page;
-		(*nr)++;
-		pfn++;
-	} while (addr += PAGE_SIZE, addr != end);
-
-	put_dev_pagemap(pgmap);
-	return addr == end;
-}
-
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-#else
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t pud, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-#endif
-
 static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, unsigned int flags, struct page **pages,
 		int *nr)
@@ -3100,13 +2964,6 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (pmd_special(orig))
 		return 0;
 
-	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pmd_leaf(orig, pmdp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pmd_page(orig);
 	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
@@ -3147,13 +3004,6 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (pud_special(orig))
 		return 0;
 
-	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pud_leaf(orig, pudp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pud_page(orig);
 	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bbc1dab..b096240 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1672,46 +1672,6 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pmd_pfn(*pmd);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pmd_lockptr(mm, pmd));
-
-	if (flags & FOLL_WRITE && !pmd_write(*pmd))
-		return NULL;
-
-	if (pmd_present(*pmd) && pmd_devmap(*pmd))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-	ret = try_grab_folio(page_folio(page), 1, flags);
-	if (ret)
-		page = ERR_PTR(ret);
-
-	return page;
-}
-
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
-- 
git-series 0.9.1


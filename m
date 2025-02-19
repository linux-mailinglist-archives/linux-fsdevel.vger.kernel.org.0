Return-Path: <linux-fsdevel+bounces-42033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DABA3B091
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D0218985A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34771B4F21;
	Wed, 19 Feb 2025 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C04A9M8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1911B3953;
	Wed, 19 Feb 2025 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941523; cv=fail; b=fuRvv5HH7jtAJqg0zJCSWbrY8GT8PnmFUmCBYXQg/btjh9U1oszF+xoISwsC03U+bxl+lVz1BaVFCKAirTRlEI+82w6h3PuprkQ6MlScFXOlIhYIlPqEhh3nfvSZlTJsuihIIAsloT1aZXc6R9d1W/00nkzhvDBlOLgBE3EvJhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941523; c=relaxed/simple;
	bh=AX6FR2rU/D3SNZ9iw06OqyPpjihnlRsUq8fvGYv+als=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0yI8KiUe1EXKsfmZtiKNCZGL3W1kNEARWUeypUWzEYFDdnhGWI7a8c1pGV84CcP+WfVJYxBOf00jQnTeUUFn6TVA3TK5AXI6I+n4x6RGfM+WDghWSwZ5axiBlVowYwd32h0/6K2mf7jPekeXKHPefWzCSd2QA3AhiLE/VxddiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C04A9M8b; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTwJGql/erpFH87NyXma5/GX1dUMgkVpjD1jnFyyDGFS6rRm2X0999MlideHlWNp5ilTtlv1kfrxve7JiKvLWlHyLAI1DhmQ7ot3tdPqmBlBOrZVYwbUN/692CfuG4a3nlcxgfwzwJzqFFfdWte6y7TFv+tZ0D1/E9PyDXkzY4gM6sUukbLL+HrX9E0ZNVDWhzO10jEfYaYK+Oeof2kfoQ/u/P3pskyWM9uwzINS/8qvp8SnzVcjIyWK+I6YsMYAIcLtaHEq7CJOh2G8jTL5WjQ+eSwfOEgwIjgvukgWyRpzHgHiqxPg1vIJaxTRM+Cs6HAmjASHWtIp3Yz/M7XbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6kKPGTMdoDN9ubKiRbTsfXxTkV3fH76JCjE7nf1IvQ=;
 b=PM7WLnM+CSLOzuFMTeUnQpTmyPY40Lo+PSptZ1NhJCHKquYqlpkIvAEri+10gHnImlpTXW5ZeJ28LOWFBtgU/im1WYu71x4XKD/+flu3QttRNKjGRI1JucRH2BPdS/VDA6xEsT7Fr2iTco0iizSNTW+iQWqIvAJ821LxATykG/6OWGvqtXBfJGLifowdSmI5eiRE3A4ewisNW5yDfqkQlBM4dF6FybZYupsYuIs0RzbSp/OHyD6DlsWjfLZedrIbp35y/FtIw8mqwG8euwkJsn2G+OCPmMUcYoRr9ZETa0fdWAtN9CwkJLIrrgA+q7wsDK7D0Y5VVpkCltdQ1/DHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6kKPGTMdoDN9ubKiRbTsfXxTkV3fH76JCjE7nf1IvQ=;
 b=C04A9M8bPcyZaR7KdjNDr9dhGRi1UxjMfIkRN4SFY/8y+Mo8A8M+AXzHGFcd3xPfHWjZyz2qnlSiCk2uc1rKbrXcZCRBZacl2JJTIid2a0xK0ZJXPQqA6jjiL9j53budJWwGs0tluHNNGoI21XNv7jm144iRJe7OQ+wof37p5KKyJVS4CFgNS/2YqBQExQIWB4Amsw3uYekbJYg+oxD7tNyQgxZQZ2e+sVvGtVsFozBRki/MRbEoks89dORKz5BJ5/Rx6eUw4Bi1z2B7JF7xd/r/TmyVy6MsUM36EOEajxEIcvhBAUDdafOwPlwNMM20hHufTZEru5IyQMOIwhWZkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 19 Feb
 2025 05:05:17 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:05:17 +0000
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
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com
Subject: [PATCH RFC v2 01/12] mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
Date: Wed, 19 Feb 2025 16:04:45 +1100
Message-ID: <5b91f54d5e608e0ba4555e6d107a58a9d7f7e2ad.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0110.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 959f831e-1f39-4119-92ca-08dd50a30079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ao8sVwtODJHL1XCoKXcVQh7wqXfWjaVSuAitGENHbnpUrgtPtTWljOGbrF0f?=
 =?us-ascii?Q?C7R0Monu18oGFJgnR4mIaGrRUz67GPhZPEwrrIu/0df8G5Kxrgkuz5z2ye11?=
 =?us-ascii?Q?07+DwxSeQUWey397/42Hdg7CfwvRcUA93z/tKFXr9N+1HUYjUuppmDBLR8qk?=
 =?us-ascii?Q?hFjcfaIBQvURLnbBwD5mbmLPV5PJnIYyWjHmmLdAlA3TFqc0pZd5DcWlawK/?=
 =?us-ascii?Q?VRRYKwfoQOBWxWkwFoWoRnQrbguKZI549CTiRPyj8UvcGn7r7gccV5yNOLqs?=
 =?us-ascii?Q?TCoXd4oH2/Fblifw5k5556dWMVhhv/LVcAFrwOp3yPVMS3RdeJhboev1BgdH?=
 =?us-ascii?Q?hJE3s5+R/u+Ijwtyiu5HvaBYzlBTOPoQADkde8h0wSZMuWgjPv6KtZcUuoUs?=
 =?us-ascii?Q?wc9mBopjXJh84sV/XQmatJEsBWEk1GeUaOXF+MEq75CbzxvXNKUwpSZLZyrs?=
 =?us-ascii?Q?EbPUhuazddfPThdfHoUj2GIisOIaD3dTwNUDTNlKNspEcyK8qgI9lZyoaMhj?=
 =?us-ascii?Q?jy67GQfJN0N210i2gueVi3ZIGK56mqgLEbllBbMiNyzKjzrjKXJXISNjHYVa?=
 =?us-ascii?Q?A7EkXsdkHBBNDM1rWmBvC8e/wsvdUmuo3rR28m+5JCZWLAyTyQ1fl1B3pmKC?=
 =?us-ascii?Q?E0w9IcoZarsVQilKZ1G91TOZlnLc8Vvjhf8rCPORFHQqIa258K30+JYUrjEY?=
 =?us-ascii?Q?2M+OpOHZakED751rNDSEeRGwcMiOHaznIjHvoqNy7dPS49fP28r+kEfmlMC8?=
 =?us-ascii?Q?eUp1W6jjicmMVa4jTeRRe3qgVCgpBOA7rIHlKiqgL9VRYRXf3VpjImwkY326?=
 =?us-ascii?Q?usG1We60+YyIFM5OzFaXP9JP/UMD30KIrXk20D9eKuL+IR1zVxLIk7+Uh0d1?=
 =?us-ascii?Q?D2ORAiE85yyoJWOnN4bL+Lu4O5QKWf5aGF3iUYyDzCNLywsCH2M95u883A1j?=
 =?us-ascii?Q?aCm+PZD8a2nxkqdB6zmUbqdrwQnKAmF8YF4UZiSHH1ZxFLqoK1bhg6BINNeW?=
 =?us-ascii?Q?I4aZ7+V6TWudJUpRKzVTrhfJl/+d+gbmiKYU7CoRFXxq/zgv97RZJoYAEOkV?=
 =?us-ascii?Q?i3mu1HMvvnOiwXOb1TmCdUhR8ql9ngDwvXbNN+2GqC3dZuLToNvxArhHjTYj?=
 =?us-ascii?Q?Zm8Higfl6OOl2+cgbSnOA0s9v37rRrX2aTfj+JnOktzYtFcN8etRC20CvhOG?=
 =?us-ascii?Q?YPgnrD/PULeQ3jiDqBr2dMS2msTxQhT/LKPJMAE+Vrfv6A0RMfk40vp8HLm7?=
 =?us-ascii?Q?TjgkTr4SkQo5LcwqFTVDskR9KE0kYSTXVKyTtR29phKgyh/PkTNLEwj59Whv?=
 =?us-ascii?Q?oZGa/7X4mWRlV/Cxihuap04jZwOshSh7fOPYzby8/YUKV0VjgQaqTyXEr1Cm?=
 =?us-ascii?Q?yn5lbxvlXwTbRjWsnQ6jDpPmkif2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqMKoGmK1dRYg50lE0tLoLsUFc5abEH4tXB0uXxqDdEXv1gLm9XWXcZyPTpv?=
 =?us-ascii?Q?e0knXOJ/NlCUTAWrMKFTPHbk+ODoj439WgYu3NanXz8RwU16eLlSYrelaumL?=
 =?us-ascii?Q?0aPW8r0LmD8N/oF6AAM4YBVwOk3kOx7SrPEki9/4YdRat8tRWlbCEE5ZL06P?=
 =?us-ascii?Q?Uv3P6bhmckrWRXDAXDdNvVCLgLcZJKOTCH/WBvVUzmNCY46a2vTUDZcD5peP?=
 =?us-ascii?Q?Hh98WMuwO4YV/h/KyztANxTR4zwvGZcDPTQ+mqWLa+UM5k3dPJrh3twGxFLW?=
 =?us-ascii?Q?eldI/twb1fActijLUq/LLIP1fcRGN5wRzIme5f0RZrKD5IIxUuUc56W2l+2q?=
 =?us-ascii?Q?AniYIL0m29/LMxDISn4NuHAQTHnFk93IlaEh6TgEyOICqfnrbhsalOhBNdC6?=
 =?us-ascii?Q?VPiYKcK0m1DOSwIU1a48jzbIkEkeTgpdkgT6vasXtLYhLOAFonJGhulhBfw+?=
 =?us-ascii?Q?mYTC1nDvrDpdu9BcsPa4il97lIELPhFOAlFA33uq7hJvrPX5zOzog+sV9rhs?=
 =?us-ascii?Q?md+kR6ty0G+71y2Ea1hmQiTuRuNb7fi4cRLRGPGWdjL5mbogW1s2o/Az0Gvk?=
 =?us-ascii?Q?k+GrpzqDtuKOFq3ohaWh6IKvM5Sl/cMQ6GgWRKXrGAQFmzlowfaFM6Q8J+Uz?=
 =?us-ascii?Q?SsBPOWEfGMHkgtaGTxxOg/uK07Bkvd3rwjZ0UzM6uqhAjjy8nUZ0udDC6swq?=
 =?us-ascii?Q?e44UBFuk5qw4vJiuubBGK0LcvUikXs3zWJUMUMAXHx+PYuWbL8J+ox89NJNY?=
 =?us-ascii?Q?UYTX8OES7NypPALJk2eztbQIXcCyezrhDiV3iGGZRoWEKGpqos9CkMiQYqA6?=
 =?us-ascii?Q?Jza/IvXYY0iud3OSGKFUWTDPdtQDdoO3SkO+YjC6EyhLSsqoax/MTzCYf1Nq?=
 =?us-ascii?Q?O0rmO9KDBmipiQA0BW77CNKmxKxvU5f5TNqoK6DM2jM0F5u+ToKpyRF5gw2S?=
 =?us-ascii?Q?TZ2v61iLgIvA6ohKUS2SY9pdNw1KjUhYqAOyNjX9GmCBuuaubnmB3JVp3bo+?=
 =?us-ascii?Q?Y6wqOgH1/Ek11vEiLtBmH8jIYnbUK2KJEobc3b62HztaLMnIW/k2MjA0uvZI?=
 =?us-ascii?Q?1b7SLfVQWQdKHY6bXxsdGbJcXZxVDVWcwKGTB9vFPmnIAm1JAmZgTh8G07fe?=
 =?us-ascii?Q?D2r4aZoSTy0VQdjTbTAbEjXIOO2dJyRRHr/zrgjos34bRz5te6q0eU+bvfJa?=
 =?us-ascii?Q?K7wIc5t9f8xN01tNxzuKH4v3RwsJxt9RQOPsvr/6rtCJxHr3iAikx+b4u7dy?=
 =?us-ascii?Q?nVBgvKPYz+mvb7geC+5j6ABT7cPqNfWYRsHQGvZgHE7b18DyHh1CmHv618BV?=
 =?us-ascii?Q?qNZ577CLB9JS5V9SjHJxhsOV3k8kaf99NhYUcIItqsJmyOjJhjCs7jmIB7EX?=
 =?us-ascii?Q?nJ7+OB+IPyT9RdQhIhtfPRq4WOs13tiA0Wo57IKita9UVJ1E9BTiIFqhA5G7?=
 =?us-ascii?Q?nc6CNpoPzESR23tS6x3MJaA/4ySq6UlZl+8jRgidMkggd4G/WdApv3txs0fn?=
 =?us-ascii?Q?HrAKqJ7xHnl7HL5ac8PUfzkRpH9fV6ZA0ckUCYCIkPYQBZtNsReeEXXt5qBk?=
 =?us-ascii?Q?aGvE9shr4F7Vjv8tIiOSE0TC4dkyvYR3TuYJwFp0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959f831e-1f39-4119-92ca-08dd50a30079
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:05:17.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqF6EMXXSa4CJFg17zpqBX2EOA/eMM/QiGO9zvrI9tC1MZm8BfTRyP0zM/48xgXAHzwRDwxjd2S9du6xOZkfPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

The PFN_MAP flag is no longer used for anything, so remove it. The
PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been used so
also remove them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pfn_t.h             | 31 +++----------------------------
 mm/memory.c                       |  2 --
 tools/testing/nvdimm/test/iomap.c |  4 ----
 3 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 2d91482..46afa12 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -5,26 +5,13 @@
 
 /*
  * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
- * PFN_SG_CHAIN - pfn is a pointer to the next scatterlist entry
- * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
  * PFN_DEV - pfn is not covered by system memmap by default
- * PFN_MAP - pfn has a dynamic page mapping established by a device driver
- * PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
- *		 get_user_pages
  */
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-#define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
-#define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
 #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
-#define PFN_MAP (1ULL << (BITS_PER_LONG_LONG - 4))
-#define PFN_SPECIAL (1ULL << (BITS_PER_LONG_LONG - 5))
 
 #define PFN_FLAGS_TRACE \
-	{ PFN_SPECIAL,	"SPECIAL" }, \
-	{ PFN_SG_CHAIN,	"SG_CHAIN" }, \
-	{ PFN_SG_LAST,	"SG_LAST" }, \
-	{ PFN_DEV,	"DEV" }, \
-	{ PFN_MAP,	"MAP" }
+	{ PFN_DEV,	"DEV" }
 
 static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
 {
@@ -46,7 +33,7 @@ static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
 
 static inline bool pfn_t_has_page(pfn_t pfn)
 {
-	return (pfn.val & PFN_MAP) == PFN_MAP || (pfn.val & PFN_DEV) == 0;
+	return (pfn.val & PFN_DEV) == 0;
 }
 
 static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
@@ -100,7 +87,7 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
 #ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
 static inline bool pfn_t_devmap(pfn_t pfn)
 {
-	const u64 flags = PFN_DEV|PFN_MAP;
+	const u64 flags = PFN_DEV;
 
 	return (pfn.val & flags) == flags;
 }
@@ -116,16 +103,4 @@ pmd_t pmd_mkdevmap(pmd_t pmd);
 pud_t pud_mkdevmap(pud_t pud);
 #endif
 #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
-
-#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
-static inline bool pfn_t_special(pfn_t pfn)
-{
-	return (pfn.val & PFN_SPECIAL) == PFN_SPECIAL;
-}
-#else
-static inline bool pfn_t_special(pfn_t pfn)
-{
-	return false;
-}
-#endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 #endif /* _LINUX_PFN_T_H_ */
diff --git a/mm/memory.c b/mm/memory.c
index 1e4424a..bdc8dce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2570,8 +2570,6 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 		return true;
 	if (pfn_t_devmap(pfn))
 		return true;
-	if (pfn_t_special(pfn))
-		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
 		return true;
 	return false;
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


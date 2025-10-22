Return-Path: <linux-fsdevel+bounces-65025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A41BF9D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 543014F3898
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 03:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E52D3739;
	Wed, 22 Oct 2025 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GpUI9tj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030002D2488;
	Wed, 22 Oct 2025 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104217; cv=fail; b=ssLajFjI6apIZZsGXJNQ5zBzzW7Jc1643c/lHk3ldpsQKNTg4lxk9d66uDi6yZ4ypcNvw9/8sktU7ifMfK1nVKgY8ig8rA3wYP2DAkO9+AlUEedztZCw5w+t6w8h/qBdjtk/hScTW1tdgYDZ93+CrabJmJgTEfIMfvusun+/xHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104217; c=relaxed/simple;
	bh=FUl8PyN6EgqDRvix6MQL15bcRb4zpRAIS7jNspHlqA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ld/m7QHdTeCmHMJUWGMnpb4636LMuEblSTWaXchS6kGfeIM0xVYg5+DxDUTBho6BTPuPYKQPTNO7EnMvL6tqwHdw3LCrOOkWJpbw/QVx3soOs7+G65tgsGKzMjQBibb/bulqRCLvxHn9Ef3eX17shkW6vfFHByOzO5a3rrKgSak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GpUI9tj/; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzmqNAsIXxpPIi7TW+Mph1HchbrdqkJRppg2Jv2uTz9zfXdkV2pkjnjeaVVr4w3/WCAPkKTw2yT3GxkFgzdo8FOLZwF0GfqNW7l4v82a4dmLcop5FVQLyNYdC/0Gkr0Lp6G4HvUyktLSqg9eY4pbSo0+iF3uvQ4wDMySwIrA4g1IU40Xmr8zr/qA/aqAvTar+Vr/RJjnHwtIjd3LiQSu8HNxNawMKKhBLzyinLObJc1UvrlALNdzuIt2PCm2p8dWr2/0HH92eeSPL/azb5pYRsCqH6vNuM2vJsvr+qkPi5KKRasbVxL7GitHzbJKenT14YymzJJlRFUkjv0IzU/Klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyUV/BSmJqn9CacHkPWlc3oLle2Rdg8sLAr/pnO+Ilo=;
 b=pSDUcL6d1QSXWycBPmz9+HHG8bvSHQUb9nunbI8TVVSqkixnD4+Rh+MR8Qo4sSh1FbA0URTHBfKn/PXu4YdZqUtwQdjaml09Q1Cu3sr1NJlZvnapEbVo8erCyxjmsOG0Q3mNBuO0hLUpaN7cJnBvhe9Hbhsk2Ypl3+HlWYpcqAHnJEXiEQkBMIa9+xKvNnua+YB8Li8tWb5Rz5zQQ8jSL9HPTLZUym2N60PFrvfWvWdhRSRerSnOAdFh/jRrRRYzO6M1g1T5SOUQgAqb/YlGSiBBEAXUsMWf/JWW1s2YPKCYUZEbQU2jd2QjDJpYJSvZxKxMa75D9kQX/i4Y4YQNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyUV/BSmJqn9CacHkPWlc3oLle2Rdg8sLAr/pnO+Ilo=;
 b=GpUI9tj/XBRUQ5MWUbSwjVhNgrVaiuAhRRLDo1pnCaxRrTfhITegidVdOsCV9buA062uin0FGyaKWYwHMZiHcXBFqHmcwVv+D60L0T2jDoH4YAUOVxUsoBP9YaDEz7M8hOSxUV4ZWmklkxUb+5KGyQRTjavMrcTtEaHWHShZhEnnD6WiRzp30+BZd5SokYCwTATGQRj6GxTw7xSJB3PTke3yANCfb3qOL2N2oR+pBOKnpenmWwjCgaouZNGd+GU6I5ODu+QpKcrhGeBQOlAnFxGi5kIiDeYh6IsbM1SwgJ01a4J259v1AdIO3Hi26Gak0/p9F/YmCyj6nEGMPwj5bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 03:36:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 03:36:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com
Cc: kernel@pankajraghav.com,
	ziy@nvidia.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Yang Shi <shy828301@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 3/4] mm/memory-failure: improve large block size folio handling.
Date: Tue, 21 Oct 2025 23:35:29 -0400
Message-ID: <20251022033531.389351-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022033531.389351-1-ziy@nvidia.com>
References: <20251022033531.389351-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:c0::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 806116f9-8dd1-4ab7-85d0-08de111c3c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P4SyNae6Rhju83hFJI9i+42YcDOOAljpZo70ZMnkx1s734+UinhUo7XPZGKv?=
 =?us-ascii?Q?ZR5ZSJBdxhOJnB7jYTdoqq8xSOAoyd/xAiDavkv99L5A6VK/gIaRtrR7EQqw?=
 =?us-ascii?Q?raGV8DxSf2x5dppw5/NZs2MlNR/0FScR1NKO4fWczuG0zWJf/9HwcD9AEyU2?=
 =?us-ascii?Q?hZHNat1Mzm0DWs00FI+CYIR8IwTSuvyNKmfjNr8HIW1OolyLrQtmpXs+BLJf?=
 =?us-ascii?Q?89Gzeb8y5XOkIzlSYfAN1jmiMonOTvzWFBqA+6+Ln2iZ54TbsP4QmNJ9PLUc?=
 =?us-ascii?Q?r6TaK1hX+sV+3RLvBx1qc28/FPkAj/vGq0I98JUz8IOiZ/1PtkmLpsrfDAVl?=
 =?us-ascii?Q?NSqb8EakZlZ2NCMKD6YMa3XkHudc//4DkV63kxTWfuC+c9wcU3QbeqMsN0Fi?=
 =?us-ascii?Q?tM1FEXAeNyyQKz7cnSazl86Q2JQ43TplbEOrKlGq02gbptb6EXnNP9lRnTJV?=
 =?us-ascii?Q?hNwLG/AKTOEwe2aDM5Y1+1rcAV7ZFxqIIGgiLuEjaa8Iv/zTsUtQ81gbdMgf?=
 =?us-ascii?Q?BxH8eYcaCKpMRkTJoqMrMh1Ht/R44Kd5hbRbv3KYxeKIS1AgrbO6b87ok2vJ?=
 =?us-ascii?Q?Z6q7oTRBKo5xPDi2Bs4OCaBXm0YVs6kMLPm8r+RAo78VonCPDNVkdgMeTenM?=
 =?us-ascii?Q?PGBxew7R5mLZ8zazekpHUrXCGuUy4mhfNIQENwrlq0iB0Mec0ujcr3lcPAtY?=
 =?us-ascii?Q?x03r2H7l3Wg5/IkmNTGSsS+VjPSAvPdYCKT/ato0pdN6ldkNCrU2DCK6o/I2?=
 =?us-ascii?Q?DIJmaxvbmN3IcA3kfLlCsQlylbQGLBT86GIHofRY4ZxkiDnk9zaP8Hot3tBa?=
 =?us-ascii?Q?ZRrtd3AziTzqoOFEAD26ATbYpLBkTijBV8guIY0esTfBhGlmm5lzldkwfwiy?=
 =?us-ascii?Q?mjMtBOi48qPm7n9QF4ZYONZCNy8GdZTygDVVHWmrUbf2omGu82l9jlEaTbpF?=
 =?us-ascii?Q?HgiJ1cySb0Vjxd0Kga7byEK9N6C5of67GOmvYdiuwOLY+mcnab/ETvUG2mTV?=
 =?us-ascii?Q?8wF3yeT7/53lnB8Vd/Of9wDpCToJNyv9QRI0XBlNsEnLH0MboRLgrmULU5q5?=
 =?us-ascii?Q?wo2mOTOdsGm8QFb0Sp5Dt55Br37lPk1Qw7Mck+e4BpIRRG+lxncZh/CZ7VcC?=
 =?us-ascii?Q?7KwS0UVa/Kmur6c0vRoLrX3yCKdZr3Cf4Bu9sIesiA0K6MkuATQd82A/0ElW?=
 =?us-ascii?Q?IOhZ8vOROga5mSYhXR7L9kMZJUE7FY1rJjrnDKe/hh9vquswTYZUK9+TTdoV?=
 =?us-ascii?Q?86CIZKJWFIr5MDgX8GchYIJYvpXwPLrdsGGHF995kwBapZEIGu1gOcdsgaRN?=
 =?us-ascii?Q?QG2OiQuTk+xFmp9mk77WUax/OvDwgZR6chhMKVdtN92mTXK1roaTYgAz8MGi?=
 =?us-ascii?Q?olVxNZhF4sEResHJ+MtzW/P+COSxXtH3JKwPHOP3VyRn/kocytgu9DBVfbvU?=
 =?us-ascii?Q?ceu8JZ4gAyd+irAmv3Q8in7knQMUhN0O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TTtYBU9IyF5H7E3537R6ql+qLKTiKhb3pHwOAAQM0vkza7AVGJo7lwuu2E15?=
 =?us-ascii?Q?aAKzv4UzEIv/hyc/dF6581+472Bj9nHLSAYIDMU/nltT6vKa8GcK/+n+RCCi?=
 =?us-ascii?Q?knMVJNjRdPMEDedB/9dcWZ0vbGtpllOdNnz9GkpUYOfm1bqAvh52nTt0OwKs?=
 =?us-ascii?Q?ajs66eP+WBumKZeFuQ0f/upucaubTVZh1ild7xBQJm5cD5jV4p1DSJEC4Vce?=
 =?us-ascii?Q?7wBA+FVND16aw2CCgfW6QNPaWm14I7+AsksqgKFdBAfHtSJG+iwQqGK2mg3z?=
 =?us-ascii?Q?jz3dIfw3xTqBp5WtM7hthJ9RRZb/z8rybhCzoh4ZpuJuFeDSazLKkRyh7a1S?=
 =?us-ascii?Q?lUhQHzjZF33sfQrYbGkxSBp/uDkyZnHSVH8THeW8ac10x0SmKWq3RI+9aliK?=
 =?us-ascii?Q?izxxNK4CGNI4DAdjHqi516nlY27TcHOEeIjP2xWpTkzIrXpsdFXI4n7hk5fd?=
 =?us-ascii?Q?161RK5MKr4tsjYR5d9hyzbWUQRQxE2OlskurZWSUcAB2XagSErhgPWQ5f/aB?=
 =?us-ascii?Q?rhCP8FUOfOa9/5yb6fv+QZV0EzBglyCKunKuirM6nxYsPkbLMJTt1yJJVfgS?=
 =?us-ascii?Q?1UIe8rYmo+CE23O44JayZ6OtTnwMzZCERuGfedr0JSdPZ2yshcuEQEoIPRLN?=
 =?us-ascii?Q?4oYE25CuHDJEhuOz64aXXDV+sU57ZeP2mI5mnuBJxWyZ/vYva4JdfW5UOB5p?=
 =?us-ascii?Q?nPYKbJnkbuvqyht+5LZUME6+2OU9d4hgA4IPB7AOpJEeO3BGiJLLGBCJEf1G?=
 =?us-ascii?Q?Fq9zB/Jmic7uaV3d8ygnWTf84zZYYDrAbr+nb9/JHNq1jfb+Hp3MsGJUC54d?=
 =?us-ascii?Q?2T0Ed63O1EZawb8VGM304FJFv/reLpoN/wsPL0dVJqy6KAJWJ1aXmG2IMz5p?=
 =?us-ascii?Q?qm6MLE9xzbjhBlEk0Tqdv96n4FesC7TzAIlvozpzvlR6c+vHl2LvL04g8M63?=
 =?us-ascii?Q?RW5Z3BQl/Ut5E69L/W+TXNxJzZD9nTeUDZPEDUV5z/QWvrYBhDkZIktPZKvU?=
 =?us-ascii?Q?gtKhjP9awb/3VpcTeL4JKuD9NxJRD4tk0PHS/WOYe0WvWJaaoAAZGsGhFdZG?=
 =?us-ascii?Q?xBH39oRgTIhzou81VxRsQeWlEDXqfZqggXnpafl/GN0gwU/Y6Qsk53je1ckq?=
 =?us-ascii?Q?HzPARYd3HIKf4A/0hnusfgtBPnzOv7xopmPbrYLH5Ncb1rBVwR5aFhnDY+79?=
 =?us-ascii?Q?HzoA3ZSch8zceJakMocgvxRWUZH+1ed89xwPsLi+GqVVHClUWnVum8qnYBAO?=
 =?us-ascii?Q?/qrtp8QKYxuLRN8GNjwiS0EaLr7D5aazCZt8jLjj9KFrCu2rGtdGF7cYLsG5?=
 =?us-ascii?Q?hqr+qEyRjt8gJRt8FY9q+k72vmdAuEDTZlaMv2zeW/K+OWoMJPWRhR4oC9Hl?=
 =?us-ascii?Q?Vo6vCExmGsL/llxeFI03+I/JNFd2x69gUlIekLpTQfz6IqGdEfiVUZP4+jwj?=
 =?us-ascii?Q?Mice4usOWEpCwzbPnB36K0bt//805VDzfuKmbL0ki55haQjEut0NBUBH0b8Z?=
 =?us-ascii?Q?NkOxvd8eGZbYwG84NfnM/ydGRJtcRAT8zbVoFpyM76tEanopcT/O3hILC9YT?=
 =?us-ascii?Q?1z/BIG3KOFSB/FwCuOMpByR0Cq/5A69d48fHm1WD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806116f9-8dd1-4ab7-85d0-08de111c3c8d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 03:36:50.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UKnwpj9MPiUeswXyOFBVEjgIxbaS0RrOysqs11p7V17Hbw9clGIpOecaEdzYXA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268

Large block size (LBS) folios cannot be split to order-0 folios but
min_order_for_folio(). Current split fails directly, but that is not
optimal. Split the folio to min_order_for_folio(), so that, after split,
only the folio containing the poisoned page becomes unusable instead.

For soft offline, do not split the large folio if its min_order_for_folio()
is not 0. Since the folio is still accessible from userspace and premature
split might lead to potential performance loss.

Suggested-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/memory-failure.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f698df156bf8..40687b7aa8be 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn, struct page *p,
  * there is still more to do, hence the page refcount we took earlier
  * is still needed.
  */
-static int try_to_split_thp_page(struct page *page, bool release)
+static int try_to_split_thp_page(struct page *page, unsigned int new_order,
+		bool release)
 {
 	int ret;
 
 	lock_page(page);
-	ret = split_huge_page(page);
+	ret = split_huge_page_to_order(page, new_order);
 	unlock_page(page);
 
 	if (ret && release)
@@ -2280,6 +2281,9 @@ int memory_failure(unsigned long pfn, int flags)
 	folio_unlock(folio);
 
 	if (folio_test_large(folio)) {
+		int new_order = min_order_for_split(folio);
+		int err;
+
 		/*
 		 * The flag must be set after the refcount is bumped
 		 * otherwise it may race with THP split.
@@ -2294,7 +2298,15 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		folio_set_has_hwpoisoned(folio);
-		if (try_to_split_thp_page(p, false) < 0) {
+		err = try_to_split_thp_page(p, new_order, /* release= */ false);
+		/*
+		 * If the folio cannot be split to order-0, kill the process,
+		 * but split the folio anyway to minimize the amount of unusable
+		 * pages.
+		 */
+		if (err || new_order) {
+			/* get folio again in case the original one is split */
+			folio = page_folio(p);
 			res = -EHWPOISON;
 			kill_procs_now(p, pfn, flags, folio);
 			put_page(p);
@@ -2621,7 +2633,17 @@ static int soft_offline_in_use_page(struct page *page)
 	};
 
 	if (!huge && folio_test_large(folio)) {
-		if (try_to_split_thp_page(page, true)) {
+		int new_order = min_order_for_split(folio);
+
+		/*
+		 * If new_order (target split order) is not 0, do not split the
+		 * folio at all to retain the still accessible large folio.
+		 * NOTE: if minimizing the number of soft offline pages is
+		 * preferred, split it to non-zero new_order like it is done in
+		 * memory_failure().
+		 */
+		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
+						       /* release= */ true)) {
 			pr_info("%#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
-- 
2.51.0



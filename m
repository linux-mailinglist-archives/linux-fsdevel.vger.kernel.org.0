Return-Path: <linux-fsdevel+bounces-42728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38887A46D0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 22:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233777A7367
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7A52253A9;
	Wed, 26 Feb 2025 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L5yaJhbc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9B25A34C;
	Wed, 26 Feb 2025 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604146; cv=fail; b=FlWdoQOTQcIh8WymMFQxA1TRVu+nrpyVj9ut6HlNLrAJKO986GO38T63j/q9sX/fFdtbfVgY1af0oaVvmvNcza0enSfglTqS7gVAv2PMLIxfCbCFhcleEuJPqLWKMoDw/8UaK7bwRmeh2ZzkGjmEiBFwRhTe9QAMd6Mq22xKaaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604146; c=relaxed/simple;
	bh=snyJKkiQO03GhaVXcljEhGVHcCS/O1YvKccNpI3c0TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lFHMH1LB6zrySaF8KMICU8yFG0WAXD+NxsT31duN+eBjdyp6xdaif49Pb3cOOhPM9wOUaSoEVjaZJ5bzNRxck2Fe6tLXkgyjZENLUnqwm2X9hQ3oRrrLMM/xet1wsvVKR6cPas4fEpzkpH4bpAnST1KW4ftjSK/bhWQCljNjUGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L5yaJhbc; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxAwyj1RBWWzcPOl8CnvEg1eD7iiDiUY7Vx91dv82VwtQxVn9tsKKD3i2bs4gB+7fx2RuCKm2xCiHSL/8J7wrbEVvpA4dvQ1KHPwy7pxGoxZXAaz3iBHJTsl9Xs6Ufnt9XuB9yt861hxwx65uM6g3vkf2QYfWh19JjUu0vhBRropQiJo4WElT9AUYYbJqt9QEV2xYJxQJIX6ql104s8vG4laUSXLHqXWa3S3k6HjiLZf7RBaypw0Nh+fKz5tNoPIcY/3Zai6HmRkq/xWUpgApbdbzqA5xQjW57Xnr/PatxBg+oDyHBOTEhF5rd2bS4t/3dcHdo4w3FRZDAbrmaTOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZTe+vj4+GDLRrlRyis+VS8JV73i92eh02I9nqzdSr4=;
 b=Pga9t47UW85pw0BMlHTD82aZG2ZrByohxV5in4YEwCmjXz+N73w8RDj/1uY7WdVsa6qX3chqQq4j1adzHS5FYKamtQtY0rrkYfhnr/2xXXaNmp4o0ICXY6rbd8yLTWSwI72FLz4zsVecKYbJ5qKBEESHqEFXPAA1egnaG/FiEUHcbViB1BuCxsri+FUSPOEnjywlEWoIZq6cajBFaVsepQ2EknO4lguT8u/hnxKpKodK5oI6PvJnX2YWzV7y+P3oRkfjY0ZDGZH2mFGRZMKLjebVmE84qZiAH8R3k/u4KTxj8lXlIDBgfOfz+uMcOs7KEyz51Vd7xmz7PBAK3zIN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZTe+vj4+GDLRrlRyis+VS8JV73i92eh02I9nqzdSr4=;
 b=L5yaJhbcCk8MA1/Ak1saN1QAhD/+cagKIJNMoXP+tYHIdhweda2CsX/q4BSfwmwsHczgUsR5/MKP1yIBQs7PV+95xNvD3+sM7UfQBmOaDH9o3RgeJCocBTqsUPqt+YV8BMwGpdKCF/jzwn947CjBQsDV0Wf2Mcrw15wRbllDF0a91p3+TKiMTNQh5wOmTe0NTUwkq8+5neHI8eT91d6EvYjosetzXt0pIYXakdfCOuqMUo8IZmPBoo5so5EY56dRcz50VgvS8zammVaL9SHvTIqkjlnk1zFXq6GvPakQGuSWo6ofpGZ5HCH6Ai/ma8YVr+qQHn/PP3bDLdu8gxStQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 21:09:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:09:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH v3 2/2] mm/shmem: use xas_try_split() in shmem_split_large_entry()
Date: Wed, 26 Feb 2025 16:08:54 -0500
Message-ID: <20250226210854.2045816-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210854.2045816-1-ziy@nvidia.com>
References: <20250226210854.2045816-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:208:23e::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: c34acc3d-dcae-4bb5-619a-08dd56a9cb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydfgA96WeLZaFN3GXE3XwY/KRs79pQw8m/GG9aSIZ80Liudgqq/tWVi0wUGW?=
 =?us-ascii?Q?KyroYu4OLMDAQUayW+FO9Y6QNi7CV0XxSxrveUa2+4L9zZXgiF/VyJLVGnU1?=
 =?us-ascii?Q?43aS8Aq0FRq1ObCKxhU4Z+wgiBderJ2XUcDz6OdXPAamsJS/UA6CC6474crx?=
 =?us-ascii?Q?LA9151ZVonaDWk5vMBBiRhyz4FLvAJzmwJj3LQZOiaCJG/qkQL7U+L8eUN14?=
 =?us-ascii?Q?rP2wpuXZuVwm1zoZDbcHp6UOpLkqBn9bIHDNUQ5pIB0ND0USbMNTMHXtBDfx?=
 =?us-ascii?Q?DzxW8FBFdrqIlVfweZ8d0qlARL4BxpqrVAcu5PUTt+G5xV3PYjH4Ha4lIbSG?=
 =?us-ascii?Q?8FNylLWke35/GPUWsEq5hlMThPZtkSAT6ty5QsD8DmNeWa//QjKL/sx5hIEN?=
 =?us-ascii?Q?CxEuJEx8Z+FZJCHUkSlq1q2ZncP3h7/ruDcSs488r3ldxfENzIK/o9mkYK2E?=
 =?us-ascii?Q?Ivv2ExPfkfAphoZKI+Md6qhbxpNB5Wg3Unb7b1x3PAdaHCnyX/dOR+dM+wOU?=
 =?us-ascii?Q?ZVIxvY7fY5a84tsWTw5nf+9a6EBME84nJyZl8FZ5xeYzZNqqKWoIYytjDD95?=
 =?us-ascii?Q?GzabuZu0uMs9QKyc5W2XOVciz785/kr7cV3ZEdmQBz2FsfcHIEiI0pRWR0oa?=
 =?us-ascii?Q?hQfEjqbZx0FM6NL0TXZqZU/31jW//6i7FytBXyRK1KMz4L2yN/tuvAUPqczc?=
 =?us-ascii?Q?t1Zi254wMc/MJ+yolfw6Sj9DRip42QcnXB0sAXeJ/tbSuylCeHBmy2ItRfRh?=
 =?us-ascii?Q?D6egWymEESLu+9Y1+ms+K5wMspHTcbQGvzI6tADWUcOiplcj/aWgnwC1m0Fc?=
 =?us-ascii?Q?uUeYz32BNqcHJgRLVetBHmxBz68dvIEgOoN/53A0fkRT/9Lhy39rAFPoO69t?=
 =?us-ascii?Q?UTJW4NPB/isr6EchKjh17/kzEPnwzyQDaiijagYtaK5oV5gQ7yGjWVBcj8kJ?=
 =?us-ascii?Q?xltGUuNIevoXeurgvtrhlk1/OD1gRWpGGk4iHh/pWoASWIPg4kqmam+USneN?=
 =?us-ascii?Q?MEYbse1W9tskRBqLzpPQtyFkFEmEgyXO1A+ev7OBchUfuxlmgt0BDfIMWdj8?=
 =?us-ascii?Q?LafQ8zSxYDlvD6mwS3B7nn5lmtDNhJLmNw+WHzh0zJVmii4XD2tHAVYhZPjC?=
 =?us-ascii?Q?lJJpyO10fM+59dMn8bU4/RIs6LGbu+VSgrDC8o6feCeuOhwVYr/MePVWD31d?=
 =?us-ascii?Q?vUcQMWWpKwC5wjWTRQnpLCYGrLqGGB4UyWsz8BPE/GO4zGdeHg27gmyR1ulk?=
 =?us-ascii?Q?wCdUQ/Z8b0OAe9JAOZfmPBOgbeoYkeVfCTpYk5SYuJCZ8FgvhCuq72bKuRSZ?=
 =?us-ascii?Q?snpatljAxlEWPkj03NkAL4VSEjIrygBrhWRn4N3HylvF7yE95HmyEGG6qPYn?=
 =?us-ascii?Q?xHQp7MDDCIrtSYSFqMZs3tHO+UEk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QrALfEJD+w+RrMLepKf7+A+HZ3lGLpX9h28eHr5QMr8X8TMbqUFgL/Vhnis5?=
 =?us-ascii?Q?wLlQATmI5TdkbLSTRgSsi9r8hlrf3yDQVVVcYoQ9AxLs1dXuToYpd331P7b6?=
 =?us-ascii?Q?TUqW8bW41KUEsrpQ51imiu2HC1NINbvZ34OatqlgdzGzuSUNbdMH4BRC9jPq?=
 =?us-ascii?Q?SwOxnGlyadzFbUVnBim3Aw34VcTBhb0+h+FjK5kJSYPmvReJQ2sT0DJCi6Hh?=
 =?us-ascii?Q?jhpmMd/sq2TgtrYx3J3IFDqKgoVbw5IXZGkdhRnqt2ZmIzckc26+shizz0vf?=
 =?us-ascii?Q?9/r2at62JqkaH92RLY35N1Cz+t34DfcK72HjSFFolebTrVT4SYwloOiogEJI?=
 =?us-ascii?Q?VS1zQWWHRqYrYDLuxKhpGK3hFFwih1nXT2C13a3Ah9KNKivXno4z0XtNBk9D?=
 =?us-ascii?Q?GSPx+J0e3xxWlBn1/KkOoLxkDMOtkw78F4y6JxZAUbqJqa5IETiD2FuVhFrd?=
 =?us-ascii?Q?pU6O12JA4QSSyjp5gA8XeJDxuGnVlqFm8MKM+dJrgv02Awz5v5+MdrLMn3Dh?=
 =?us-ascii?Q?seFgHLPQy+qjMneXNEejA/yDbMdZwlE4BLRIAi7pbrWOEbM8ejY4+hx6G1oe?=
 =?us-ascii?Q?OWQ4qlJSuGyazqpiG3Fb2yICgl540DElbHUmS1354zPbniwSqXlNCKXVwYVE?=
 =?us-ascii?Q?cHwBhm1YK7oQPH8/KQOMVOIk4XW2j7t+SL73lYciOWYj6IWH+nGwfv3bW7Hk?=
 =?us-ascii?Q?6dc53wwKiT4GVF+VndnG0ykdwbmXbaKFdYLAKuu1WWiViSRNVZjWdGaTmxdt?=
 =?us-ascii?Q?GGvG0awZDUyiZS33+Ol2ikpWgQfNhnL5uopgKvhcprAW2+QimYTaQokeT2jz?=
 =?us-ascii?Q?XdIqOvu6C/iD/JVqBxdLDcaPnT5y3uZP/5/n/31SCJAryszxskJbDFKsrsos?=
 =?us-ascii?Q?xgjqPK2Sv3UwDzE5ityHHLEaXa09jWE+sY/zxpcX++VxLaayFHqDS3SsLe6g?=
 =?us-ascii?Q?h0+Pe53xk3LJmsnS4bwmiqyrmTv1fHHgwMnsYZN1oLufzPzE8eKtZ1HEZ44b?=
 =?us-ascii?Q?HlmB94v+QKsnNAIKHCZR83p/iMxucaFV6MN+Qdfv/1RiRd+NL4TVXF/ckRqK?=
 =?us-ascii?Q?klNexuP3ahMhg7k99fsR/NhTCDRxTBoTK1LAI5gWk8FoZdN+wY1MEp6smR9R?=
 =?us-ascii?Q?O4hYiD3gngCnCuCq7WBNMpLd34g5ue3lUVcgvGUN1q7Bg7OdU2mulV9nL2ZQ?=
 =?us-ascii?Q?pROnG8BJjCujtYwr9eRhlm7G1UciCVCKkfetRqeDGQ6mkMcXwrbxJvnEaNWB?=
 =?us-ascii?Q?9QKFtfXj+7MR3lYZKPuvbdg441VQNOyJHA7a33ObRrusfsx+7jNMfZshO88P?=
 =?us-ascii?Q?+dR8N4pK1It7OJr9gINa3wBrmQq6uaBaGVZMdOEbXjwX/mqTpP3jQPDuHp05?=
 =?us-ascii?Q?i3P/PXjHHSYuwTGQd+kf6jl1pv3/paucKr2mHb5T06buTHOIvdybPao6MXxz?=
 =?us-ascii?Q?tLDMYXEWXlb4c1Gly5sckAhDS+/65nosJ/hKXFUXFb2c9zxnh2eYcwveqPfS?=
 =?us-ascii?Q?MB4B1VHu3NJcZDHlJKrjn5Dhqj5NmoHN+teYW1TjhpMDn+yVu4kv/66eJkz2?=
 =?us-ascii?Q?kDE/oslMxy3omQlMxatdedDantR5IWUyfnDTc4Rv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34acc3d-dcae-4bb5-619a-08dd56a9cb0c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:09:01.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiR6kv/7HCehPedxbSev1XIxvEyBSz+iLqM3+EzU/OUV0/yaLArNE0TuncZB6ZqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

During shmem_split_large_entry(), large swap entries are covering n slots
and an order-0 folio needs to be inserted.

Instead of splitting all n slots, only the 1 slot covered by the folio
need to be split and the remaining n-1 shadow entries can be retained with
orders ranging from 0 to n-1.  This method only requires
(n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
(n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
xas_split_alloc() + xas_split() one.

For example, to split an order-9 large swap entry (assuming XA_CHUNK_SHIFT
is 6), 1 xa_node is needed instead of 8.

xas_try_split_min_order() is used to reduce the number of calls to
xas_try_split() during split.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Mattew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 mm/shmem.c | 59 ++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b959edf15073..f08ba9718013 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2153,15 +2153,16 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
-	void *alloced_shadow = NULL;
-	int alloced_order = 0, i;
+	int split_order = 0, entry_order;
+	int i;
 
 	/* Convert user data gfp flags to xarray node gfp flags */
 	gfp &= GFP_RECLAIM_MASK;
 
 	for (;;) {
-		int order = -1, split_order = 0;
 		void *old = NULL;
+		int cur_order;
+		pgoff_t swap_index;
 
 		xas_lock_irq(&xas);
 		old = xas_load(&xas);
@@ -2170,60 +2171,56 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 			goto unlock;
 		}
 
-		order = xas_get_order(&xas);
+		entry_order = xas_get_order(&xas);
 
-		/* Swap entry may have changed before we re-acquire the lock */
-		if (alloced_order &&
-		    (old != alloced_shadow || order != alloced_order)) {
-			xas_destroy(&xas);
-			alloced_order = 0;
-		}
+		if (!entry_order)
+			goto unlock;
 
 		/* Try to split large swap entry in pagecache */
-		if (order > 0) {
-			if (!alloced_order) {
-				split_order = order;
+		cur_order = entry_order;
+		swap_index = round_down(index, 1 << entry_order);
+
+		split_order = xas_try_split_min_order(cur_order);
+
+		while (cur_order > 0) {
+			pgoff_t aligned_index =
+				round_down(index, 1 << cur_order);
+			pgoff_t swap_offset = aligned_index - swap_index;
+
+			xas_set_order(&xas, index, split_order);
+			xas_try_split(&xas, old, cur_order);
+			if (xas_error(&xas))
 				goto unlock;
-			}
-			xas_split(&xas, old, order);
 
 			/*
 			 * Re-set the swap entry after splitting, and the swap
 			 * offset of the original large entry must be continuous.
 			 */
-			for (i = 0; i < 1 << order; i++) {
-				pgoff_t aligned_index = round_down(index, 1 << order);
+			for (i = 0; i < 1 << cur_order;
+			     i += (1 << split_order)) {
 				swp_entry_t tmp;
 
-				tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
+				tmp = swp_entry(swp_type(swap),
+						swp_offset(swap) + swap_offset +
+							i);
 				__xa_store(&mapping->i_pages, aligned_index + i,
 					   swp_to_radix_entry(tmp), 0);
 			}
+			cur_order = split_order;
+			split_order = xas_try_split_min_order(split_order);
 		}
 
 unlock:
 		xas_unlock_irq(&xas);
 
-		/* split needed, alloc here and retry. */
-		if (split_order) {
-			xas_split_alloc(&xas, old, split_order, gfp);
-			if (xas_error(&xas))
-				goto error;
-			alloced_shadow = old;
-			alloced_order = split_order;
-			xas_reset(&xas);
-			continue;
-		}
-
 		if (!xas_nomem(&xas, gfp))
 			break;
 	}
 
-error:
 	if (xas_error(&xas))
 		return xas_error(&xas);
 
-	return alloced_order;
+	return entry_order;
 }
 
 /*
-- 
2.47.2



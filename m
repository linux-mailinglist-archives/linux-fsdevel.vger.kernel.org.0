Return-Path: <linux-fsdevel+bounces-41624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93701A33657
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 04:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE33167E6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 03:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26EF2066CC;
	Thu, 13 Feb 2025 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AtO1V+VF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69468205ABB;
	Thu, 13 Feb 2025 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418254; cv=fail; b=rPJtW699yGNKBZzYErY/uAVzPlVvOYR5WBYdpEFyq7dWE/8NJDssz3J4oqCq6ok/vhDK0DbITM9hzbbVggh8cwzxoR1MelOK/lbKBdG9udHc7TsY8fBTF+qcYPnDUUiDg4d/SOGS0nG0JiAOkInS9aEXULWyOmwD5j2SVyCZkT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418254; c=relaxed/simple;
	bh=y/AJt4YS/kawd8VVuzIlM0emEbnCfjMxSVPdwEQNHjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JEyLWi/QrO4QOU5Q6kKM4ZROH5scJKSF0V5wfe9tUGZsjdR2h7wTqJ5Y89DaHcsNqDiDceSwga1gEOSvk8hR6005CqFj/4UOwYj+5b9Q9jaPcIEtBamTE0cyWI09Gb2szNr9Ipo5hcqelAjO9HFq8ge2VjQEfolX+r86Aiegx8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AtO1V+VF; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5FXUbWcTkZr5xYAU76xQZQ/h6lugZWz5qVq+HHd7S1kD+Yp7cJCBx4+z5Zkj2EaBuXLXwUX1HUVExpn9shJbYN2N2HNrZvNiJZwqlW+7LNZikZCf/64GyQu/Q+64ku8mA8swLCqc348AWxn/n670bpgIhtkKWnYue9zyE0Pd9nIKPz8MHFAVAAjhUbB+NeLtg5EInORhPXBg5zF9x50trcLZ/iI7Ws1VQmj1GjMAvcOetUK8+ZfpGSukMUSEZdh/hssokWcPqdttLZrVBTyB39CVhWfIxfsTiGs4Tx2i4QgNop9gB0YgVDdY3EOAdtONp2eOnxzU6sIP/SLSQH3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8pPmk9cmC65qEEnIXqv8Or4vcMEJrsAI/eN68/fODY=;
 b=OXXXwI6XaJa3bLr/HSJNkxOH6EYgMq7Bxf6GwhwwAUl7Tgnyo538PtWwdPeVCwathPCJ6gZCp4uvamjnJ46toan8nYf6nc9fdgqGR6VGNaob6iIx9qOEIOTnYxVxQgwrhKPZ1iElcQ7XPi4hS9RarC4CssAQMfmX3zsn+75r9NyhUGDWV7UD9y96TLKJY62Ts8dGLj9/kM9Ww363xIfTJL7gXT8yEwDat+hs4avm0Yvj66ZcwOYRNA7cw36swKKuW8qM1ADy9A3AxwzewmU9xAyxhflqnvLeFCsusAyy80Zx37Ak3MMnbfrvk4RsGkXRicp0ZSJtMOXgITe5KzZpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8pPmk9cmC65qEEnIXqv8Or4vcMEJrsAI/eN68/fODY=;
 b=AtO1V+VFfUKGVfydLWeq0Nf4mUBP2d2C1+D5jG7POyW0sstFEOdLMkn1b9l1ypgT12yGFXRrDP55j6acg5LFN15k5OzjtUOQY4Y19UqLFQYS27kY70cc13UyZHCUHqIsD7N1OtJyBCqo8lpSwrVKPthZkDFW5WZ8laIYkXwyRJSv5vzHQRIajZyRYKauyw0NY8eB/T2qlGT7VBad6RbCOQ9TJ2D6FyeCUOzWvTj/O6lw5SbXL03O+zhRNRjLx3bNmx37A5fAadbgxXER39fyxL1hzEkwmKlpBGIBMipz30JoAlgj0KpglH9UTJIm173Rtry/dzFpc2Ct9/RQ4iTUgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Thu, 13 Feb 2025 03:44:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 03:44:08 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 2/2] mm/shmem: use xas_try_split() in shmem_split_large_entry().
Date: Wed, 12 Feb 2025 22:43:55 -0500
Message-ID: <20250213034355.516610-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213034355.516610-1-ziy@nvidia.com>
References: <20250213034355.516610-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:408:141::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7ebe06-6ad3-43af-15df-08dd4be0abb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I6Bl8IM0zgjgpoIi4iyWvVVZ1eW+9lCkt/CPeMXrVxBRAUbSRPyuAspxTAtI?=
 =?us-ascii?Q?htNGGsyihqeosQHXwB3Pn7wRBENBUsyw9108dLLaHKa/NBLt0fFlMCTBzNaN?=
 =?us-ascii?Q?jrjUB9Rk1kOWfoHbNj8y1gnO9ZkM8PEH/vBbktM2Z1NGGpKloqpy6qSfcGlF?=
 =?us-ascii?Q?zDCGk+oBQFQ61//1QtKBwE6S2yUhFbyBN3eJtR3g3ketNYxgG7V0/IJB6L6C?=
 =?us-ascii?Q?SCJgaWa9g0RBLvpOuZ9/4sKlWSsTbYSbQUMVlKkHcoW4hGxX9HPkf7lgLms4?=
 =?us-ascii?Q?zomT+P9t0C6rcTzYUDiknZG9nmoWpqtl1qbpKItxXceBinj2cClRr60iurax?=
 =?us-ascii?Q?q6+OR8uvsYcBMBkU+BIwrpWuug/p+wipP5/t9ZtyJJjLxvxarR+DB1qF978g?=
 =?us-ascii?Q?nH0Iz57bYBPCBEhX5npn5QPwBupQDM/glGcJkntCiNlO7irMvDlw6kHjtC/m?=
 =?us-ascii?Q?IGCrGHpXyjOMpVo8Inc2A2mksoFYiAcFNHG7qFroYEJ0b6LQYkLO50fEqv3R?=
 =?us-ascii?Q?fcXNKhfZJ6GNQiZMbnzagvbB/AsypzzEHGVfSeWL1JmqM3Y6Aa2D67/2Tnn1?=
 =?us-ascii?Q?7ooRLHjFBxM46dzvzIUPwqI5kRuDUqijN3DzbnKPEfRWutJvlFP9O3JAUVeb?=
 =?us-ascii?Q?efHTiYrN3cU6gUiJ5/of+sHGpIEEOi9tfcCsMVCfvNSqp9MK9fbPfMFKV1ra?=
 =?us-ascii?Q?Mx1nBn5xSly4NwjkBcNOQWcpZtsUZyFr3BLJZFviu6O2sXloo+zRZmQz5QwV?=
 =?us-ascii?Q?l9oIFgN6P6caOpTXPjyS5W7yfLN6DFXag8uv9J+3GWeP/oPcxQuHGeCUZsir?=
 =?us-ascii?Q?zNXi6UYeZ6nElM9Y3fTPAczn+oB2+d91swj4t08JZo62Qd5o/MNE1EmGJOu3?=
 =?us-ascii?Q?oaCyXwHDWxBzYMV3guDPe/huIHSprMxxyMC54rXTZ/b8k3XUwgqobiisGaXv?=
 =?us-ascii?Q?4mvB6E4jFK6WcBnr9s60a0sZvwYjoSEjr9ZZxCRu97lCisM5bI1AK3sapNjV?=
 =?us-ascii?Q?8WFW+JJEUadnXwIHW1VvCHOXif9hSRXGwpTLXa0LqxF0d8sLz5GNr8PcVokW?=
 =?us-ascii?Q?C6kk/cN8VHvPFh+mt9uZzHkF8VgOI+uknjRxgQW0zgBFMtlUcvrfrj/nOXDv?=
 =?us-ascii?Q?A4OD1yQDxlm8P2QHdxwCSOhz896+ytqo9crhpDZQ8+pC+y545FWcz7ljgcaK?=
 =?us-ascii?Q?SK2YvPKPDWT6GK8ES6xhuXW3GhDQrf7BaBuwaE3w/5hQtmwXfwuba59jKjhI?=
 =?us-ascii?Q?/gkleL+akXe2SOJoDRLx1ZICbbeEBYG2bz+X20WIYpmAL19/MwyKll22IZDq?=
 =?us-ascii?Q?drrdyw+18ll4GEFG7k+OLTgVjAOhIj79bsTiEP3l7/7RFDE6O8kuYsF5MuaA?=
 =?us-ascii?Q?tyYf8SS2jZhTKq3bukGZzL/Uw1f3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pu1aAhawNWxpfR39NTwNKZVyKYEBJfSY6Nr+fnunAyWEomSjpn8RLXzAkKX4?=
 =?us-ascii?Q?oaZly/rRHyiVq+vIqn5NjO0NDZ1CfC4I3nhK9v5CUQ27tt/UviZfv49ZgzOz?=
 =?us-ascii?Q?Igsjz4G6ZfNao+zDtfca+AMkqfV1T1+fyod2hUqyz/JUsVQrPNzqRuYscrQw?=
 =?us-ascii?Q?ZbfKFeIp9qLybATu+S2hxiLljosO1qqA3uB/tEfcE9eNVw5CwAdYvz7Klvjn?=
 =?us-ascii?Q?UBmKhP1/koZxEZ6kPebcSkdqMWI4Es5gib4Qp2p/Idf4ttsm0uy1Wt2kEKlE?=
 =?us-ascii?Q?9Nnv047nOlSvKp4DnXkiGuPonOZwL3KGkNUMgQPk7oGh0CydLv0dgDfCoXkE?=
 =?us-ascii?Q?k19tL5193wHchbxF3qS1X9ajR0Bo8icbb+U4BZMmIY4zVY9EHyB6/sESn+qE?=
 =?us-ascii?Q?2o58Y9u5q+MzM0AaG7G2sBl+Gr36mSsty5rM+F/IRakTYrYd39hPlZdCFbF7?=
 =?us-ascii?Q?9SoORpNu9NFNMJuGCfezqFlvBRWKKHEuG3DwLSwy4IYPDBWEFdXOBpSw7B0G?=
 =?us-ascii?Q?blO2ACpE2dsYx3TDxDS5d53h9hj8HlhsMpBV9wy3tBCfQiVyWNfsAPCiQtWa?=
 =?us-ascii?Q?QZ+kj2wOapQXYIUfWNWX8l2Mw9nwozwvrrlcarwT3q9WHhxGvD2KGvbnUf9b?=
 =?us-ascii?Q?QQRyp6uOQcaThOCl5qVZO7MA561XVrKkV9OhCwfKGUGA/17l4yufE/r55UhN?=
 =?us-ascii?Q?WZJB+fpphCMUvJ3SfyAQuIiZ8BGkoq6ff150U0BwPvHThz/fKBbb4neIPwAz?=
 =?us-ascii?Q?vaPIhbOIfQNA4EN6S1PPTY+a4H+sOEMiFAnMdIb8pbOvYFWeMU0yeD0s5D+Q?=
 =?us-ascii?Q?itGStVjFeHm3J7z/wCnudTyXFQYr4r/oOSTY4fjj+yyPIZqnkgZVu9ps7jrK?=
 =?us-ascii?Q?7lF743vnMpEz2MVVzasW4JvoOsAv9NUkHAKGPr9nN6hcNA9kLHt9DG07dzMH?=
 =?us-ascii?Q?wF/1Bo3v5DFGITGPVDQodhMqZ7vNk1xV8IlyGHVGKW45G0VWSFJzMHiP0kto?=
 =?us-ascii?Q?DoVLOkFjp+wKpONvPY7k7aQujDee1lJuxMxdxy/rakQkOGbCyFyZ3Xcl1Gu3?=
 =?us-ascii?Q?NVkFPC4+Bpvcg5KXbHnxctxl8yIimk+ZmTxAXHGR+oeJ6EZYXR1tUvxenCXQ?=
 =?us-ascii?Q?l+VAOFJPqdwlsYL+GgmiNHxl6Hvnyc9gHxW/6ZSm6bNxEJlabAEU5I8L/CGe?=
 =?us-ascii?Q?ZAI3IMapjmZ2o4rXvcystnKLkOd/xkpd4DJbC54jHyK9LM8u14KQvzlMugK8?=
 =?us-ascii?Q?+7Tpmj1oz66csKZutvb3K3/gXfesESnf1GYKpmZnE85V7p/88/UX9hIR3Xza?=
 =?us-ascii?Q?Eax03GKyFx1J3eZwVcR+rRYgqyWZSmj1706kyHymy0llFzll/5y/wZrzcV79?=
 =?us-ascii?Q?WEDWayHNrUUTpNKB1cs+kWv9lZqX2/qM44CIS/QSH29xK3VMsuX13hvN+0m5?=
 =?us-ascii?Q?LSMBq13BVpVz4DCAMJ/SNLz1qhHaPMoYMxsN5pznnHnUcO+VwhajmI47GvV7?=
 =?us-ascii?Q?s65PpCkLxnvkk9rbOKRxRhFwDhcf89QTT8VV7ARyZvt2rbLPBJ9RqdKl3SIX?=
 =?us-ascii?Q?6YTY1Fyu9y+2ysjwLoHViCj31GC7ehrHy+sKgbVZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7ebe06-6ad3-43af-15df-08dd4be0abb6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:44:08.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28aYuASFhEo6U16wM1riwEvgEE/MwUWaiH55VCmp5iSRZ3wG08QheRC7JrWIawQL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

During shmem_split_large_entry(), large swap entries are covering n slots
and an order-0 folio needs to be inserted. Instead of splitting all
n slots, only the 1 slot covered by the folio need to be split and the
remaining n-1 shadow entries can be retained with orders ranging from 0 to
n-1. This method only requires (n/XA_CHUNK_SHIFT) new xa_nodes instead of
(n % XA_CHUNK_SHIFT) * (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the
original xas_split_alloc() + xas_split() one.
For example, to split an order-9 large swap entry (assuming XA_CHUNK_SHIFT
is 6), 1 xa_node is needed instead of 8.

xas_try_split_min_order() is used to reduce the number of calls to
xas_try_split() during split.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/shmem.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 671f63063fd4..b35ba250c53d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2162,14 +2162,14 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
-	void *alloced_shadow = NULL;
-	int alloced_order = 0, i;
+	int split_order = 0;
+	int i;
 
 	/* Convert user data gfp flags to xarray node gfp flags */
 	gfp &= GFP_RECLAIM_MASK;
 
 	for (;;) {
-		int order = -1, split_order = 0;
+		int order = -1;
 		void *old = NULL;
 
 		xas_lock_irq(&xas);
@@ -2181,20 +2181,21 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 
 		order = xas_get_order(&xas);
 
-		/* Swap entry may have changed before we re-acquire the lock */
-		if (alloced_order &&
-		    (old != alloced_shadow || order != alloced_order)) {
-			xas_destroy(&xas);
-			alloced_order = 0;
-		}
-
 		/* Try to split large swap entry in pagecache */
 		if (order > 0) {
-			if (!alloced_order) {
-				split_order = order;
-				goto unlock;
+			int cur_order = order;
+
+			split_order = xas_try_split_min_order(cur_order);
+
+			while (cur_order > 0) {
+				xas_set_order(&xas, index, split_order);
+				xas_try_split(&xas, old, cur_order, GFP_NOWAIT);
+				if (xas_error(&xas))
+					goto unlock;
+				cur_order = split_order;
+				split_order =
+					xas_try_split_min_order(split_order);
 			}
-			xas_split(&xas, old, order);
 
 			/*
 			 * Re-set the swap entry after splitting, and the swap
@@ -2213,26 +2214,14 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
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
+	return split_order;
 }
 
 /*
-- 
2.47.2



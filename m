Return-Path: <linux-fsdevel+bounces-44135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF00BA633DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 05:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B142B3B0520
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 04:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD20E183CD1;
	Sun, 16 Mar 2025 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0tKUjf5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67014B06C;
	Sun, 16 Mar 2025 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742099411; cv=fail; b=JLj/m6BF9AvSLcPN2SxMf49DppuTUFizcM3cIHfLwtXME4+vT4CqaqCduPL5t2OHFevP8um+brJltWCVfDUFc/MkevD2nK3UoAo6xh99rrhtzmK1E4NYRFiCcAW4z9m7kAWsJBK+aMMulFt61Z9aGAmQydqTGnPXYrsOBZ0R77A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742099411; c=relaxed/simple;
	bh=OshTwv5mZZUzulnGcwaxjVMh86dNw98gYiXEt1iGBmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kQyIKKEGMW2RvmkLH0WlJ3SFrGLmZrTDTH6ZgMjnAYmET1xOreJzBVVnLCylDBCqWTX7Bi3GLc2kNYEKRZhRJ4CX7kGzyGPNABoCYidDTQHzrjkiHqxH1+isbp1uhYG1PHYaMNblaKcvRYTAaaAIsCn4GK/us2H7KdE4+HoI3C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0tKUjf5; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+9Up+1rTpRyZ5HC1ilQanfxlVeG59UtXEEKt13Th2Rgg6kl6sXnvJO+PGR+IZqgDkrbBOecfP4tPBtcXOUEGq3JveW4XWWMbMdP3/jxk5bztqZiwXpEGpggfF0Gt+JLYqAeSaubsgftLp2RyZBP+LxjpzkCu7uX0nbxVgT76yhehiSNcX4jbVKqxyY14EvY0eCawnQWuGmzX8PSrDw/+TmM4Z+wKx3GF8ctihX8HDKGsmTQEv8aYi0xJPYCQxlkrKTRNqYEwMJ8Gct9G1Qb8xc57NeMhjghpAbx+aZNEmMjRsBS6bDZDS9XBe8WnNRHZPcnp4axWRSDw4BNQfyDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SHU6pED30VI4i2x05K56G+ModCjzq+/3eUcWasst7Y=;
 b=Knjbvg5zgwuIRp94Fzg0XViQ+KtqJMxoXcwFwAUYlSu0ptOzPfFP4agBSYnTTZQWhZEDxzhC9I9O2tO3W5gqxHcGHgUwN4iXqxR0yIkFfQ3ZdvScTzekXOomSXbllbozwyqsUdtFRX66cZsApnic0Mp0d2vCJD/iyybSBE8KVqNcp0igJbcvOX5yHIqI8DYvK1rOjuHQdQ1ycgAUnhDkWn0TeYOYvlHVurjAEHYqJ7KSM9roB+oIf6wNfxdDIXyXoqL8gYpSPkthxcZ53Ql+hhPyAxpXA2+S2uCp+pGVR52jpveE9oz2j+ybta8rJR3mvK11okx7rdtu7G4LQGvcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SHU6pED30VI4i2x05K56G+ModCjzq+/3eUcWasst7Y=;
 b=Z0tKUjf5VnIoyCamHZsOTwdW4ndyt2W2G8VvV7GiiTMin+NlmXwylOHAFH9FIE95pQj4cnGUQrFLtv2la45yKqq5Eh4TCdnN9ljDTzlQDFKNaukgu0VN2QxN/j7rP4vS/JgPtQlJBsZS6G8kj9uZvU4qOgReORlSg4SsENR1/ocPbhSRYodCo3UGVFeNrDN0jHaKIUamgP7WVYHp44Bd9su7pnKdfGMtaoP1/l6JklUCQ7l2XAmygAtlnJ7qPbJZ+en65lZhs/diCoU/KvSE7FcfxjpH5rUHMk7nCJokv+t3gPP0zVub4fltSs4YPCwFw6HU9rXF1eDBTD09n4dUbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 04:30:07 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8511.031; Sun, 16 Mar 2025
 04:30:07 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH RFC 4/6] mm: Implement writeback for share device private pages
Date: Sun, 16 Mar 2025 15:29:27 +1100
Message-ID: <1bfac47d0477ad5f13a8daac673d4d4c415645ca.1742099301.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0087.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ca5b5b-2fed-4671-49ff-08dd64433ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ywLTXMtkeGmjxI8tpPAfHSAICttmqI1pwfPDRbrCqowJUZgXPUQa/fqmA/M?=
 =?us-ascii?Q?yrU7um5o2fPNw3v+NLO0jm9yWNpIk1/Bb69fcd1HBzjHWZgK9g8/p133vyFX?=
 =?us-ascii?Q?YDYsYUqTL2ImesOiPSBoWpKILTMAqp9fa4l2oinsY7Q5eO9wNRJFtH51ZAqP?=
 =?us-ascii?Q?EabJ89eNhdIOYVOH/1HSNwhO54UaEOFquR/izkLGAXJSN7qc28Bjub7UE5gb?=
 =?us-ascii?Q?GBfQUATtDsiQXjOFUU0VMFUCXJxAGwxjK2urKxEmSOnX+eZZoRCuhdDuwATo?=
 =?us-ascii?Q?furWA/J2McWrKA4yubKv7EvD1tj4+tvidbrkA+yYgSyon5U8iNoSafpM+zBq?=
 =?us-ascii?Q?STQ5AbBR2oLEv86jmtpnpB/uG8/QK9qm+05hiAILJX4Uh2mON0m1VLPfDvA5?=
 =?us-ascii?Q?tkvkJhNzH7ZdQGMcSSOuPGHH6HmtfMTMxCDC9APPTz0FyMjAjlDnyi05VrBZ?=
 =?us-ascii?Q?9U8d21bhjWHMp+C/aQe5QflCyoXqhM14Hl2LZgdjREV3qf0iJVTGMMdwHJaX?=
 =?us-ascii?Q?Eg3jaGtW7j/hcNHu6F9Jkqh5yz4LqqYhP32jFxeHnNgUIYKgDGAYnPmX3rWd?=
 =?us-ascii?Q?klb/p6rtxNj24m6/7vzpDutd3muaAbqDlavlNoL160R2ri3w3xWGGzQjzXkv?=
 =?us-ascii?Q?MUmk5e1HAI1oLFD/TZ8kyIehbU0JXg9nIDEnmUUmSWZyvt1PqZYpuxP8UXxv?=
 =?us-ascii?Q?qvbeD9JAGNzZeTgh9txkezvzxHz/1AVO2NdYuSEzZZGm58qsBeSOafciE5XR?=
 =?us-ascii?Q?Bhhaz9HwsqM0hNUF4RQbF+F/JBiFap3Br2A8R79xjSxNy3run2RnlmGLJstx?=
 =?us-ascii?Q?k4wYP3K/vzh9iJZ0P4uYnHWj4Ce6XlnzZzAHe0SN20AlFssmB+jDy966Da18?=
 =?us-ascii?Q?9AXP4EuDg1dL8URegJEabVhmtddKw23yz5OwgMowMKbMwy71iSWJAHwQDCrL?=
 =?us-ascii?Q?J22iG0Hlucmsnb0of8qvUbJhFgRgviTgrGPnE4qjvZOHBS5+8VnC77gub/EI?=
 =?us-ascii?Q?WnAONVnzyI6R8R73d6KVlYMBTikAlTx4RuLfMo5XZEEXokCzIDLpAvjVUpPb?=
 =?us-ascii?Q?L+esGfuzpMH7rgR3HTS4xNG3RbrujdiarC6+7nvz+gyEDyMkSLp8C7dlOT6W?=
 =?us-ascii?Q?tGUKUv1hDYwMRLK03Nav6av5AvCREnnbtbKXcRF/nti0ytb6jO1hR29BtWrN?=
 =?us-ascii?Q?vHO9gIlj35qn9bOBLe8D8RfAunbg47XIkbxyhMTZRFqi9Uc0d/O4hOZlWNwS?=
 =?us-ascii?Q?M1hNCvizCXwfmtjIch9nTEokLOOnt7oB+MVlX5M5WvGVuuZnQ4LpBwsEGpMq?=
 =?us-ascii?Q?gD34UjMMDS999iW4VXdsrpIvAo1TjWgXieJjEGYMcPhAHuHcEfHpFKxNlCxG?=
 =?us-ascii?Q?6Q/XvxYdL9Wn6X6fuP1CMcHSDi4/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oxfMNpIiggBcek0H0Ys3ybYzvZXLXqev/tIHkO3wXyY1SRyDi+ziTAd41b6y?=
 =?us-ascii?Q?xLVz1iwWhRGlWsMThUqMPrxhyDKD+m6FWrknK1SEQgHDc8GiS+6DpZsx+dO7?=
 =?us-ascii?Q?NDrTaTgBp7ZKDnxjfsPFZtrfhcuqMBLgYs4Kb7UxbJ4H6StgN7MERba6wn6P?=
 =?us-ascii?Q?6zy9bZfhST68/miFEcrec/sz3wO2RFFVSys9oXsvHx81nobJ+QmH0EXj128g?=
 =?us-ascii?Q?GzggG/jqVf52dDlEHkRP3COyPxebUj0HBRok5b3emMflQ/p95iuO0gZJRbZY?=
 =?us-ascii?Q?Oy+y0R8eG9QLsY/W/ZQFiG8cgWhJyAJ9+4MKqgZISSbnF2XIOeI16wC850K9?=
 =?us-ascii?Q?WpBJqeMA047AWzNd/97HnLjcZyK8j8kDnncdNz3WHUg3RzLW7T3G7pi/ygd4?=
 =?us-ascii?Q?tqAuiXI47+B/d8+qgF/f+DJa8+d6vn9Cen1sOb/29wQNBcNV/GE3mudtp87x?=
 =?us-ascii?Q?v1gg7hDNO5fY1cvztsw097diNpRzOa3FEiiGAHUBQ03eGxJ849Js879SOt3S?=
 =?us-ascii?Q?E3pwBfiGJ1UiXMcjbybRkOGMDX2DOCTRcUS0K7bORfowE2w1xzWpfdogGZGi?=
 =?us-ascii?Q?TyV30PPiw5ACtsEf2O/R6mjvUnwRmbYwGW3foLsXTkEhGz4V5ucNjXE3ShP9?=
 =?us-ascii?Q?CTNDebFyT99M0YIlIUhADGsj5yT+kvLieUGW0IvIsq0dVoI0/rKFOcN6aScd?=
 =?us-ascii?Q?wICl2PqLYtcIOyKy3UX3J8mzPrkAH3AvB4lQ2OHtXTyTt+AkqIJ36Z5Q3Loe?=
 =?us-ascii?Q?6S1wDWDfZMBfz0lvGihzWLryx2rnw/qnwy8OzFLEWRquASJQQIPkcv+u+wkx?=
 =?us-ascii?Q?+1lINTAYV2NqJdaztNLvroaXjeHLwEZf/c4ny0h4JYYNpN4hQXAfN4QxYuEU?=
 =?us-ascii?Q?tnCyN8+yYhGl39KrbcnNYOupzjWL0OxkfQEUBigi3T1QNaWjFqUkEorNX6Kt?=
 =?us-ascii?Q?zbaV3PSiLo3mcMCSOU0R5P32uuLG9MqmqCYzsVVZ5oupPnOMBkWeZq2kieGW?=
 =?us-ascii?Q?SxhPUdh9ajM8rkliNz+33VkT2Op004zUpzCSrakYcv+7kr6ktXkr2CYkwIq/?=
 =?us-ascii?Q?oLMpWZtUmfzWDnghLlCjtkXy+sDvP1r6iLy4u2/gnTMHTfgQd8ChFOc6KoMk?=
 =?us-ascii?Q?4KzmTOxTPVf3RdxhY2hAIph9UkTMeqExwZJS06IOP6ecp3H+4h7IbVaFHSK1?=
 =?us-ascii?Q?uLla+jHi/iWP8KvSEJ+2pTg/iHPB3q9XY7PC3LvKBaXeEf0WsRk6+VxrBc1y?=
 =?us-ascii?Q?HikptAslytMTS8x+faVMYvents5U4MmFH9JKdUx3vtw2v6XLsDoUH01xSnou?=
 =?us-ascii?Q?ws7g5JeMgTKeeD0ZNMuftgGbsnwrFVFd6iFxCVFlp68kn8wxe5vDlRgQtr/b?=
 =?us-ascii?Q?7IIPDSMW38WDalSWwxgwkxXbaPIJLfRyz7XKVVWdC1S2A66rF6TdU0eSl1RY?=
 =?us-ascii?Q?H2fMi+GlLDqRO7dXNj0Y3v9Q7T7LSFmDv313sXnDqS0PUP1ekf76aHdUyPgW?=
 =?us-ascii?Q?49ikpjEUL9PP+VWbqs4c42SBco+bEduf8eFfU/hZ3i0BqNkmT6/3xJ1PYdFD?=
 =?us-ascii?Q?M9/T321FDACEbnnonQN0+cI1BHKot6KlIPk6SZ4q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ca5b5b-2fed-4671-49ff-08dd64433ad3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 04:30:07.1856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJFoOnlKV7w0wc8PLzN0nBsfh5EJxxg/vuwozpySClR0IyvGkA1PGZ7cFM4QCh1XjalIlbY0bkl33hHJ8ytSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

Currently devices can't write to shared filebacked device private pages
and any writes will be lost. This is because when a device private
pagecache page is migrated back to the CPU the contents are always
reloaded from backing storage.

To allow data written by the device to be migrated back add a new pgmap
call, migrate_to_pagecache(), which will be called when a device private
entry is found in the page cache to copy the data back from the device
to the new pagecache page.

Because the page was clean when migrating to the device we need to
inform the filesystem that the pages needs to be writable. Drivers are
expected to do this by calling set_page_dirty() on the new page if it
was written to in the migrate_to_pagecache() callback.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/memremap.h |  2 ++-
 mm/migrate.c             |  2 +-
 mm/migrate_device.c      | 54 ++++++++++++++++++++++++++++-------------
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3f7143a..d921db2 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -89,6 +89,8 @@ struct dev_pagemap_ops {
 	 */
 	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
 
+	int (*migrate_to_pagecache)(struct page *page, struct page *newpage);
+
 	/*
 	 * Handle the memory failure happens on a range of pfns.  Notify the
 	 * processes who are using these pfns, and try to recover the data on
diff --git a/mm/migrate.c b/mm/migrate.c
index 21f92eb..c660151 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1006,7 +1006,7 @@ int fallback_migrate_folio(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode,
 		int extra_count)
 {
-	if (folio_test_dirty(src)) {
+	if (!folio_is_device_private(src) && folio_test_dirty(src)) {
 		/* Only writeback folios in full synchronous migration */
 		switch (mode) {
 		case MIGRATE_SYNC:
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 946e9fd..9aeba66 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -160,6 +160,17 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
+
+			/*
+			 * Tell the driver it may write to the PTE. Normally
+			 * page_mkwrite() would need to be called to upgrade a
+			 * read-only to writable PTE for a folio with mappings.
+			 * So the driver is responsible for marking the page dirty
+			 * with set_page_dirty() if it does actually write to
+			 * the page.
+			 */
+			mpfn |= vma->vm_flags & VM_WRITE && page->mapping ?
+				MIGRATE_PFN_WRITE : 0;
 		}
 
 		/* FIXME support THP */
@@ -240,6 +251,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 					entry = make_migration_entry_dirty(entry);
 				}
 			}
+			entry = make_migration_entry_dirty(entry);
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_present(pte)) {
 				if (pte_soft_dirty(pte))
@@ -898,14 +910,15 @@ void migrate_device_page(struct page *page)
 	int ret;
 	struct page *newpage;
 
-	WARN_ON(!is_device_private_page(page));
+	if (WARN_ON_ONCE(!is_device_private_page(page)))
+		return;
+
+	lock_page(page);
 
 	/*
-	 * We don't support writeback of dirty pages from the driver yet.
+	 * TODO: It would be nice to have the driver call some version of this
+	 * (migrate_device_range()?)  so it can expand the region.
 	 */
-	WARN_ON(PageDirty(page));
-
-	lock_page(page);
 	try_to_migrate(page_folio(page), 0);
 
 	/*
@@ -932,18 +945,27 @@ void migrate_device_page(struct page *page)
 	WARN_ON_ONCE(ret != MIGRATEPAGE_SUCCESS);
 	page->mapping = NULL;
 
-	/*
-	 * We're going to read the newpage back from disk so make it not
-	 * uptodate.
-	 */
-	ClearPageUptodate(newpage);
+	if (page->pgmap->ops->migrate_to_pagecache)
+		ret = page->pgmap->ops->migrate_to_pagecache(page, newpage);
 
-	/*
-	 * IO will unlock newpage asynchronously.
-	 */
-	folio_mapping(page_folio(newpage))->a_ops->read_folio(NULL,
-						page_folio(newpage));
-	lock_page(newpage);
+	/* Fallback to reading page from disk */
+	if (!page->pgmap->ops->migrate_to_pagecache || ret) {
+		if (WARN_ON_ONCE(PageDirty(newpage)))
+			ClearPageDirty(newpage);
+
+		/*
+		 * We're going to read the newpage back from disk so make it not
+		 * uptodate.
+		 */
+		ClearPageUptodate(newpage);
+
+		/*
+		 * IO will unlock newpage asynchronously.
+		 */
+		folio_mapping(page_folio(newpage))->a_ops->read_folio(NULL,
+							page_folio(newpage));
+		lock_page(newpage);
+	}
 
 	remove_migration_ptes(page_folio(page), page_folio(newpage), false);
 
-- 
git-series 0.9.1


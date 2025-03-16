Return-Path: <linux-fsdevel+bounces-44132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0109FA633D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 05:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4097A6BBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 04:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB28E153BE4;
	Sun, 16 Mar 2025 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciE2N5GK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFDD136358;
	Sun, 16 Mar 2025 04:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742099398; cv=fail; b=YQnw03NSFhyrD71x0JiPccexxmIZsSzt9TBg0HtKW4s1mAx6hGg5Nv7Sx9Tm7T8pcJL0NECMF62FEQwqGn99gFieowfThPLE6EmU1MpqRkU9lkMIpR64M3+Jow2ocgOErX2ANfP9+KwaycrmmoUC5rqldOku5vqOfWNkxrXaEzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742099398; c=relaxed/simple;
	bh=Q6oPmh0hqZUVl2OTH+HZhQKQqp8FYFVVck/WmPviF3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uke7tXqe8NzPQkXOpISw3iVcMxfOXJsiJTKbc415QWgQ4vhKjHjprd3sAsyeASERX/c0jOOO4T6dyCzXbjwsALfIz4C4R9eCqipGFt53QZ5K3L52qj3+2dPNxaT85gG/0cMvHX7RY1f1v0Ow0JH38AzKUciAbgSTQB5PrGM2hME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ciE2N5GK; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIQRYr719Qoht3TgY74dn/lMFY813Hy7RtaPtwbPEyMqo5Yuqho1/XY0PtRXyYqZCmR7ktddZKhRWWv/ulMs8cXOhpU3+xZitevAcx2+RSijk2AP/qnMdb6hSRy8roj9+40OAvhTxol0gsw4Cuj49dEu10x/i9N+rbXPvK/WGO+N4o93z21lNSS5dItv64j15QfB821g4ddEWD5K2I2wo5kUPtuEi9oCTG8MzpT5OdWduOMpAP0X6BbuMQiUKIX6FwjH6UupyX2ntN4/8o7dqgaa1P8UtfgRfpgsAvTHxvytDG92YYOMst6HdlXQDVCyd9RvSpOs/5ki3BGuNEs/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+S7Lx+3yaZd7C+9gB7O+ZdHUwZpN9rSDyBW0GV6rHc=;
 b=OtDt0qvjdr7/ouf+EkN7ccDPenK+yl3lcLIB8+//i8/1TmQCo3PjsLKC6hMen2YrfvRIrHAtwN3iuKmZRMWTxQu2To7mKsEYBF96ftzzbxI5GCn5h9S3uLjpnx288+r+/8gsN+Omx5AZ6kM5EVQc99RWNIhYbKgT64RJaemEfjNFcjdy5ccOZmsHvS2LIRsxlQiwntlsZiDalHllUyXm2tmDsQjVf7hlVGyCYd6rlzJiRsABDihdKUxjH8p/Z3X5FOI6N+/7eOd4ECKk40UdTv3X5XZYklcal7lykLNU8cMuLWTFftOTKaEp+tBfA8iAKz0Fc6GXnMTsZ7daYQg9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+S7Lx+3yaZd7C+9gB7O+ZdHUwZpN9rSDyBW0GV6rHc=;
 b=ciE2N5GKOWIoljw372eYNzCYacOKeMs2OD2GikngwQ/wo2EQfzE07EAlnxHX9kpVbJp1TuQuTPIBYCxSwlJVqiCpAzO9tuoBJKupO9hP132VcBh6tQ92sESZRpE41ttcF0Xywu5x+b2HhLNzdbh2ac6wvyI6NVJka6cWjAw9lJICb/msLcPWg+rUxWTLSUd0pnOvSf/+jVg9J75iVLfOF2wsyiXIU+z1xKWHe2eQ7yTAuPtn9EZYuij+zzcGHLx13zxvXzzl/uuFMCNExp80ORk84U7BrCnW2lS/d7qw0Ifhs9s9G/saDf+BWF7zZMdwN5/XAfr9LsPscuRy1t9VfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 04:29:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8511.031; Sun, 16 Mar 2025
 04:29:53 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH RFC 1/6] mm/migrate_device.c: Don't read dirty bit of non-present PTEs
Date: Sun, 16 Mar 2025 15:29:24 +1100
Message-ID: <40c47a3f2c613a2d13d1b073e2ec77859e5fdb15.1742099301.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0031.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b9fde1-c5d2-4283-7ef6-08dd644332c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kNW3d+cEq6FYHKGsZ60aYFkQ0250isS4nUSZVUff2gm1NToPMxS+firzOJ+m?=
 =?us-ascii?Q?Pf7y3w3aaGqwgj1XyBzgu734RyrJyE1SihPTGkqc7ibIZIVHXrysc0S30dAw?=
 =?us-ascii?Q?5S2w8fJ1R5b9F3poozmZG89lGRw9MoWABP1a2JnU4qKYKDJmFBBzOBFZjGfP?=
 =?us-ascii?Q?KseFYdOHZcbF5Y9lzYxoO1SSwGtXj9B13IR3QRimGzxxyjyG8/XTpLwOYEcv?=
 =?us-ascii?Q?M2Th/jVSddH5L0r52nsxQvN+cwdyVNvB4fAxE/iRe6OdeWF24ytKKtN5Idf5?=
 =?us-ascii?Q?efFLKCOYtZdlUAopsRkCwX/aIsZJLpxS3aqqt0nMTVdrmJ5HnA5OyOLyObl/?=
 =?us-ascii?Q?eZzcWA1dnqPsEhGV1JhDC1/rq29/OZyfc8ImQHZvmm+vdM9a/1rJcnyJt0J+?=
 =?us-ascii?Q?exwL5ghThQmgGLb8QuvSZYNG+JYyZN9xw1QO+PQmCxUQmLj0Ti2JCvsiX5co?=
 =?us-ascii?Q?2YwtFlUVPVA6SXuLh3i1eX/dpoCVtA2rFCe/tAnAOCUfsP6d3IC7vjzL7fWw?=
 =?us-ascii?Q?98PgrvPlwPmgwLWmPrxYl3yG5OC3w2wzHE3OSwrgyxgH9FEbxnmEgZQlXB4e?=
 =?us-ascii?Q?exN8X4x11VqhLL+ElCgT4RnVpubN/OZAxr8yZV8sb6nWOySU6r/RvxU1it5l?=
 =?us-ascii?Q?x0y5+zWAx0LtEJue2S8ht6aDp6iJ8egAccdT+fsnykbrAteBa3959ST8yPzn?=
 =?us-ascii?Q?I33aH4NqTCNmHgZFCSbrBOdYpNBYERjWUySabmB210NFlIpQk6mVuMdaiqXu?=
 =?us-ascii?Q?sTz4qzxLEEAVzT6M6y0HknNmNK1/5rTMlALyUVtelwJfJWoTvX3Pu1qQx5hU?=
 =?us-ascii?Q?7gIHgLnMvkuRhdjETer92X/bXt9kdsatSUCv3lvAoWQHA2j9VJMIKvrl2D2L?=
 =?us-ascii?Q?6qbvpwZAjhMwMh7Oq8NH5+Bf2081pRXZoeVWmntT3DioX/bSogHi5GRw3okJ?=
 =?us-ascii?Q?F/40m2yjKdgH1p57ZBEeQ5mQ/+1zHaXL3wO+a4x0q5SyV/rsi646AHCejqKz?=
 =?us-ascii?Q?ZffhmGDBVmqdgdhZaiUKDf3a7Ytl/TkS7t+Tb3+hkUDnLH16mwj9xlSy0kJx?=
 =?us-ascii?Q?hwF0g/+KRBHQJ9X5GYmSoZ9sC0HW8W9gByaYlVeKGwxBsxiHVw6InddCeglB?=
 =?us-ascii?Q?PdiNkjscaxnt7ZitRnfLkP9MkEzQkVQmJrgKboN0eMEg6mge8CMXwSZH4+YM?=
 =?us-ascii?Q?z1LnnP0zTKS6pmNqBfKX/pfbHCTqQHyq5aN4xVBLMgRoa66F4fxRmZAZBbjv?=
 =?us-ascii?Q?h4WU6HMQI901ePtA/Da4dGyQBVWuczG1APP732J+bi2LgoNYpfD39+d6/1Sv?=
 =?us-ascii?Q?byhQomTTKsAHA1QyUNPtTDJ4IH0EgqBbcbEClDhCBj+wMIDwYc2QMFdEVnJh?=
 =?us-ascii?Q?frie9epUz6GvUDFFfNNk+CDTZkXK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A9HpIbN0jvNM61Mo7VjyGSk1QTklne+eqbQ2Z9SL9O/b+qCj3TQOimbZD6Hb?=
 =?us-ascii?Q?W3UtlCZWiVZApV13JLrJssjyu/vssTV0GHaDVMGRtNnPl4XgpHOruGSVdEgk?=
 =?us-ascii?Q?YI81rVyPEGXffRfoBEfSy6jiaYzRbVb5OqYUgf0TZz3lD48nuax3BTvvNnVh?=
 =?us-ascii?Q?gYVqZKX7W8YCEs0bpAuQTx1TNBSjzi28uXsQHwG/s9CH5DBuIxAcMm7a5UjY?=
 =?us-ascii?Q?apKcPR34NlNfww/XIGFhI6noMHkhELdDy98F56dMAGPARA10FQt9SYCMHTJR?=
 =?us-ascii?Q?f8SrzG/s3mHubbaLzjR8yTrD8iW+y5C+rGoDOlXRTPr5csP0U71uZpPy3IFs?=
 =?us-ascii?Q?p/Ibe+KB+RFn/fkdwCkXXPQ46GXB1a1RTgWMkRyjXBTo/ZZDSmhe8ByYL/TR?=
 =?us-ascii?Q?X/nHHr0g9lRO3FQXlIU8FwAoOBo9VOli8Wz9bTCqwWqgvILVhqVsLY8Wd3P1?=
 =?us-ascii?Q?69kNx1V4yCmghl99QMdPxixl9WJkWDhMh35OTqOa1DDBH+DH+1LzQkRPhB80?=
 =?us-ascii?Q?x5JxC4W8LbpgrBDcYcCrAgFsTNSaWIqFaHAYRrROeohBKWVUvjXwhVvSSymP?=
 =?us-ascii?Q?te3f8S/pK/54XRkm8hYhMLoyQloRScORG1YeyIiqLTj9/cKAxy78oncdkJ7M?=
 =?us-ascii?Q?myPmw/EpJwRtfNc8svY7x+E8jOHABd3HzJJ5PBsHYDXSHTGKigg1yhxK0+TS?=
 =?us-ascii?Q?IiMN0yIC5r5LsCdl98hlk5rSVHUEtIWsSzSK8G2vQrzosEHwCpu+ZX7YFDfv?=
 =?us-ascii?Q?CQjgBpUSxdvp3tN48TxuoOBjQeGy/n7Qyun09DntyUpPej4EMPThP92xBbjY?=
 =?us-ascii?Q?Wha3v/Di7MHGL0S23Id6m8DwJ0J8q8TG4llL3r8axp3mTSdjhACX44dkTu6E?=
 =?us-ascii?Q?O6vJbbbWvl0fleYHsKaGgpD5Bm+dy6UUFnCW2/4hYdAYc5AO76AQYUDEzXP+?=
 =?us-ascii?Q?GDnm3zF8wBcjI8lXqLtgaWESa1HaSV9Tl58f5fGnpMcj7M/BCPRWzAg1hZl+?=
 =?us-ascii?Q?JP+FYqGZTLDM1gUfHsxtDQ8Q6PYrkxjz5h5E0BktoAuVZdYNdUhK9Q1/ECXn?=
 =?us-ascii?Q?IFtzoVgOPeHZRYb8PnJ8Ob7LoOY7gQ7BHJNeTvmSNHER5zhfGSRRLnIUBiki?=
 =?us-ascii?Q?75+V0Cy0xPWnGxd+aKozsvLufTK0mxIVNGuolwQMe4Mm1Ha4xulO5gaxatpO?=
 =?us-ascii?Q?UhDiD54uaCz333H2wrn6fX3xMRDR5ggtUgfT0Ayg9KHyb5WPoXQkgXKzlD0v?=
 =?us-ascii?Q?ohZGQvGuSE5hkBrnla9wUlUjCmgj92Dnfq7nksOVZruqeaYwZjeuBq8tS0w+?=
 =?us-ascii?Q?elyyvzfm6aVslW1Nqwv9VUaFLEXNajwLpkfLzSZBLZjN8oeN6NBkOjDz5xmG?=
 =?us-ascii?Q?eQj8WK6N0PkjxZTkghdsme5yBRTDrM8NwyqW3bCYVxt77qXK0gI5pyiBh5gW?=
 =?us-ascii?Q?nnPfOdeODk9Vs3h0SvkHzbjvhTC62G1vC9gBQi5W3oOyQvfsk64E2b/q4sSt?=
 =?us-ascii?Q?2OyIj+apyLzF4hsoU394GFsIvMdAu+yinWuyKN7HYGH9bPxdZGE9e+WUqi0m?=
 =?us-ascii?Q?AfLExgQ7yyfCHyvrdm6zNVg2ebBd0QRJwCpewr35?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b9fde1-c5d2-4283-7ef6-08dd644332c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 04:29:53.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCKrmeTffsYKA7lYNmXUzbIPOyf78D2TQ+q2oMKM7YZRgBy/sz4bFRkHLA62b0ijiaCkwiZNrdeRnWAILq2KvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

migrate_vma_collect_pmd() will opportunisticly install migration PTEs
if it is able to lock the migrating folio. This involves clearing the
PTE, which also requires updating page flags such as PageDirty based on
the PTE value when it was cleared.

This was fixed by fd35ca3d12cc ("mm/migrate_device.c: copy pte dirty
bit to page"). However that fix will also copy the pte dirty bit from a
non-present PTE, which is meaningless. However it so happens that on a
default x86 configuration
pte_dirty(make_writable_device_private_entry(0)) is true.

This masks issues where drivers may not be correctly setting the
destination page as dirty when migrating from a device-private page,
because effectively the device-private page is always considered dirty
if it was mapped as writable.

In practice not marking the pages correctly is unlikely to cause issues,
because currently only anonymous memory is supported for device private
pages. Therefore the dirty bit is only read when there is a swap file
that has an uptodate copy of a writable page.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Fixes: fd35ca3d12cc ("mm/migrate_device.c: copy pte dirty bit to page")
---
 mm/migrate_device.c | 15 ++++++++++-----
 mm/rmap.c           |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9cf2659..afc033b 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -215,10 +215,6 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			migrate->cpages++;
 
-			/* Set the dirty flag on the folio now the pte is gone. */
-			if (pte_dirty(pte))
-				folio_mark_dirty(folio);
-
 			/* Setup special migration page table entry */
 			if (mpfn & MIGRATE_PFN_WRITE)
 				entry = make_writable_migration_entry(
@@ -232,8 +228,17 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (pte_present(pte)) {
 				if (pte_young(pte))
 					entry = make_migration_entry_young(entry);
-				if (pte_dirty(pte))
+				if (pte_dirty(pte)) {
+					/*
+					 * Mark the folio dirty now the pte is
+					 * gone because
+					 * make_migration_entry_dirty() won't
+					 * store the dirty bit if there isn't
+					 * room.
+					 */
+					folio_mark_dirty(folio);
 					entry = make_migration_entry_dirty(entry);
+				}
 			}
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_present(pte)) {
diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4e..df88674 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2176,7 +2176,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		/* Set the dirty flag on the folio now the pte is gone. */
-		if (pte_dirty(pteval))
+		if (pte_present(pteval) && pte_dirty(pteval))
 			folio_mark_dirty(folio);
 
 		/* Update high watermark before we lower rss */
-- 
git-series 0.9.1


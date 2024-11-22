Return-Path: <linux-fsdevel+bounces-35513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C3B9D573E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F8FB232F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3A816C6B7;
	Fri, 22 Nov 2024 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FPWWbZop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205D1667DA;
	Fri, 22 Nov 2024 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239692; cv=fail; b=M1k8BpD8b8WnvgURS69+eyiUZF9MH7ebE95xF1XIoTm4yKo2OHCY4JFq0VN96wXZyhWhryBRLkzyyr6NlHazAjxT+NPB54IDrfs0Ap9SkGLwmV4810NBlvmFc8EIDNl7R6ZdKzYOMiXpzCpHoorqygOuut+gk7f1W080pKDTpz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239692; c=relaxed/simple;
	bh=cq48zLtdILuZsOSnvH3Hi+btvp1Cy3JooyYQkUZ5q1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhFK+GJbliG3U62B+QrzwWwwYqAqZuphRczuxfCXoDtw3JWadRJtCaxIrcdcTj7zVlAzGu/Pw+H3lJr3BaJZ8tOcJ9kvBgdIcK12+wQnhyrQ9LU+65ItfR2N0lHbDWQcE3uBcxlRDZ2Tbq0Qe0h6zItpLElX6bzPifpab2CayAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FPWWbZop; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjPzjwPVG+RkdHotwXs+rk+UvSi6cCWH7Py+ovslYDesIKGnjDGsdGiRfFV3lei3u6q5mmU7++7mtV4dhz9+qZsXoRqs77e4+DKXLEqGHwwoO2AejTlJJswDakMpyuUuq5AAHg+/7R5PMCwyLGx3+W6CsNzOHmqXbqATWx3ADXO1SN1TccUCA7mAhkFo2In6PGN11mrat4jz8qtuGgTgogWImkLcWXPS6e6zZPeZ4toGwShp3D9xhreqi/7XarPx2iYmjxkAkn9j59oH8/FAwnsFenb5x/sgXsYUAUrafO4Py1nh/ps3UpZPjFwIjrlswWLwZ/kUDXLQKv5NhtdAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41LuzWbsulYp/PRvvGucQX4mO89Nz3ZyduYN8QkpUTM=;
 b=FYBM7dYVa5ntezYAa2T4U9/vCpzhefD5lRr8AYFDiEybbScdj94AebJ0Bd2gjO3qrxqbm0lpxr6MlDLj/cIPLodI285anPfkL1mAps62QmaYelIecxIXAseWkFwXedU529xDlTqQOpfNdDE38v8Tw1dr6CbD3A8UlTYQ/bLUr4jFZELlksvfTTzHY2vQVmEsS/mmQr6UCyN6p4p5uHnuujdGVfGdogLjbjLnhw/eXHtRDz3WuVeE3VpNzLfwlkwdv0y4Uwf5avpwUt0K8pIGOhLdLAIieWDYNjVH73bkA+2mGxXR+D2l6j3ITHZ1gA6OBclVslpC5sszQqRIIawwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41LuzWbsulYp/PRvvGucQX4mO89Nz3ZyduYN8QkpUTM=;
 b=FPWWbZopysFhz6vWMmcnRjBsqRUKZP1kRo4DEu4Bq+bTI2/lrB0fvi2har2/b2tDgzBlXCPToCioKWG9JUYAfYiv+zEKOPiABqCXvx5lrl/KBIyvbnrhrDfbF0gJ/w2BdQcSDT3Sxb2QKaoPHlRBfXxVvHv+px0X8akqyG8EN/mkWyyNKrpP0XdZORj+JwbvWSL80Jr3eVAhOKanFOln+GdUv2DNi1G2JgrNEzd9Dg7r1onrEudPV5vcJa7Nd8LMeqefFQBvLgMQkcy0RMomzUGXPBUuL785P2CP6IzwBj5nrN8DqhOA7G1VOgovum29I7c4uJVGiEAvRuLLSjDl4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:41:27 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:41:27 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com
Subject: [PATCH v3 04/25] fs/dax: Refactor wait for dax idle page
Date: Fri, 22 Nov 2024 12:40:25 +1100
Message-ID: <ad24b361f3f327e864981d2e521ccbf989906682.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0119.ausprd01.prod.outlook.com
 (2603:10c6:10:246::15) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: b89cb45e-9681-4324-9a99-08dd0a96c7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vBDsC22s/9jYkS3kHl2ZsPXUrK/pbOQ/z09tipXFcvpu+e/bpZcmUMHW3QSo?=
 =?us-ascii?Q?afvbBwMYjEvS9CzFRRQiBnHgRKzGcvznQgUXZEHoKuM6NjHUiWoyJt2J3E/g?=
 =?us-ascii?Q?S6C5zH0L1dUmz08ifDDkfWBfucjUiDjGVDGodWNPUoNtOsmZKFIE8YlMlDws?=
 =?us-ascii?Q?e4QoJKW2ANnrVRy1espwxTyA73XHWPP7EcbvHYAPGtcN74degHg33lllaM/M?=
 =?us-ascii?Q?NjSBBalxEEvHvdA2LFyKXH4wVqA+vANy2nM+zT2wSYt0o1DQaFUiwmy9vChv?=
 =?us-ascii?Q?CwtFCxfD2BTcl6p5JksQfSVPBb1c4DSnY76GqXiI6ca9iyZar+05n7IBUeDR?=
 =?us-ascii?Q?9wZnX6IAvjneIhKiOpirlAEycJHFmnec6rCjYwUK0BFiy+2N2rIhJJqN6a9E?=
 =?us-ascii?Q?6bKqutcySPa+xD9MuJvJkBnp+VZHYxxJNplrzZRcojreOFbOSpYQOxEhlRgX?=
 =?us-ascii?Q?lmibVGLRXjtAom5568XFBvhTQMahp3DKHkg79wK3RwLvh6xb8GcNp7D2DCU1?=
 =?us-ascii?Q?E5YljIILGRBvgUbRZKgJkxR/LrhaS2F73mEiUMV4efSVz6eHTWP4RNR8hQFJ?=
 =?us-ascii?Q?V8KCtCnDagO4EXX+/305AKk4moXdgoy9nPUohKHHYZjlEabHOdFkPZMDZC9B?=
 =?us-ascii?Q?i4gPc1vlxxU5xfRfRaHtVqvp45o6yXfANGmT1wHZr3+w4YbjdWi8OdOr53t3?=
 =?us-ascii?Q?/Rba6Evx4a0kmE9ypzJjH4/EHwipGiVNYZ+dE0i/8r8ccRYFya+l2q5WxQNM?=
 =?us-ascii?Q?lYFRCivdi2ubmrDieas1w/22uDxsIaMYLpXb1Kve0rjDrFLa36RofdtMG8Pt?=
 =?us-ascii?Q?UVQQSF/kyaNfPBm6e5Tss2EdYzMJlzKy1vCFpeWYW1OEa03bjoRY1GCOyBhi?=
 =?us-ascii?Q?N5vurPGcaA1JmfC46B1S6DKYPdeWNEndWO9S7+rDfSSf7W/YQEcVWXKJ3SZA?=
 =?us-ascii?Q?FPYHuIiYZ3X8BFrOoqFjdujqLlsqGUwXFgy6nFX9CpB1HYJ9EOkv7nFV/7dg?=
 =?us-ascii?Q?Q+69fSWGx4T05XfLccpSgIts5j5qv1jGrmuS/a/DA019cAHvF/cpqXcEew2t?=
 =?us-ascii?Q?H/P/sv8bSg6alwTitF+/g8a2ZZeOKwOCXKGPQ/YFPR23rGFuhn76pBhvvMqg?=
 =?us-ascii?Q?Yi3+bOcL0WuGi8Glj/YkfrWpZ1fDuQCGUpOOfx+jdS8prOaw4BszGPmtsShE?=
 =?us-ascii?Q?ntCJHYbBZ2pxS4pU95oxMY+GPCyDGM3nTi/dvqS9CLuVg+3TtnhOokLT6yH5?=
 =?us-ascii?Q?wgNNfheo1xIghWR/K0yKKxc8oiBVEYj0R6k5w+8J4PF9m3I49BbYg7M5uEm6?=
 =?us-ascii?Q?wgmW/KjGgm1LNfCFlRcADzzl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LrcS7mIOCApa64fh6J/d+9KUHo2OE/MqUVwi4Afgpuz5ZyH0XJGnQxC2u+AT?=
 =?us-ascii?Q?cOBplEqH4Qp4vkX7RqDxQ/qEH9EsOrnlCTYaY4725TAHNFd94ROkc2G88oQ3?=
 =?us-ascii?Q?Q2dYl8XG/upiW40Wt4SfJKeedWXvd+pfUUybJ3FIL2RUXC0kkFb01+Bq5ILl?=
 =?us-ascii?Q?zdSdKn4Czbl4vmEUhPYWC/62L/W5F4Lv+h6Y+uk1LmJNles7c8HUDnJtbYry?=
 =?us-ascii?Q?WTBq+NS7YhtTtPZHtBtG4KuOfhdbx5NWORm4x5O+O10EVifzaD7C4MYTUWCk?=
 =?us-ascii?Q?odetZyF84gdJ6GMFUqyVeRQN5S9+Ty1wO2N+zZ3WWWwr28J+Y5CBPvUH4e2Y?=
 =?us-ascii?Q?YNNNRPPiCgfQnA2mswg06JUhLYULwNs8+7FoJSAER9k5fE6K+5EUghMINSCu?=
 =?us-ascii?Q?zjrUsACtOc5PpkxfZaPdCKhgSN2gAnOzF++iL2wCmvLnyLuZflnzS8iIMaYd?=
 =?us-ascii?Q?vzo2q5BligJYZJ383Jrzroqwqw4UBoVfQFSD1o6Vz95kPbiPcccgRRcdo0K/?=
 =?us-ascii?Q?nKapVfAgnolFgcrwqrjO0RYWx8V9EneqrvUpkDw+NvCdIg9DfARtDnGwQV7S?=
 =?us-ascii?Q?twOTQWH2hEMpdZW1/XWlGbXFajbaEWgFuv6elF2ssUgSbAaWODcHN/eYGH4I?=
 =?us-ascii?Q?Z81ThZRxLfW2hC1y0eDxcA9/g66NPsfY1KGkvDCF7KOxja3k1Q2HH++497D+?=
 =?us-ascii?Q?YJLZ6U2aEE2CF5EJUw2h7lwV3bfOP4A2aplLSm2Mj/IDQTclhG3jbD8IZDFH?=
 =?us-ascii?Q?yaoZkFQRhQWov1ofUGHROOitd/8Fszgb97dWFctcof3SjxIcVvoR93BR/EbY?=
 =?us-ascii?Q?PQKQe8xWLTogt3Vonblrup7W9yYcBXkYSNIKrgIqkR2NCVlV8F1oENamhllR?=
 =?us-ascii?Q?1J1JEaBD9dYnMhIKny3VxGgcxDFwjFm2QFiy1UVf3uOiwxIOIzHOSZFNwnwq?=
 =?us-ascii?Q?dlEKF/fPQD/7NsHYEkdxapUygtVJiLam9w/ArSW/WqlCggmfM/SU4+Q+YKly?=
 =?us-ascii?Q?1KkwAuymnXS2h4r3ecSp4rdRXz07aLmJdTIaVbB32Xsc0aRbZQMIZLjnhp5n?=
 =?us-ascii?Q?YcIO772cVDduxVlCjM4GYru9ACRbGaDGE3EtwbBLnvZmxL67fHdgEGJdLpKT?=
 =?us-ascii?Q?O2yQjUFeKNF2YMRcTo1G6aKl6GNFAIDj1SMGDZ87lNfC/Q4bxXTf4gpFeUt3?=
 =?us-ascii?Q?iotxv/gs6Gx3MYsSVK1bNpvjbYvtoZj+wmOoiCbq/KlrYX1VpMSej7H0ql3O?=
 =?us-ascii?Q?HlU5QJRyBJs0oUz1KX9gImoUsyvS4mRBqsu4EmeIer8D9/tEklbnWpjid7kv?=
 =?us-ascii?Q?ivTx6NddrE7iZBmprBx9/t2wAB75Epgd69L95psVzPPm2BCN4wskuy3GKLk8?=
 =?us-ascii?Q?GOGlmGEnLcYgjg8psuMeFuTxNPLDJ/wP/1NHkRCpAZlCeZ50ro6bJZ2Lu5P1?=
 =?us-ascii?Q?kdKylsoYd9XE34jKuGydxjmsl4zArSeE8V/cqO1M3E06WNSbiji8TDjwuxxV?=
 =?us-ascii?Q?LY7cDC1QLTtwsP5WmwnVZLJUVrOas9dyBOg1r8jpm7XyGEangCOA4iJQLT5t?=
 =?us-ascii?Q?1zShkCitvlin/reSy62UaYyrwrxeNRguTSXkERbT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89cb45e-9681-4324-9a99-08dd0a96c7d6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:41:27.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI5cCDec1pLcjWyBDZawH7QH6iwOF1Iqcgj7aBlDi0whYUccbeQeit737RuRreXXEWIJybBhLxPts8yEyACfzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

A FS DAX page is considered idle when its refcount drops to one. This
is currently open-coded in all file systems supporting FS DAX. Move
the idle detection to a common function to make future changes easier.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c     | 5 +----
 fs/fuse/dax.c       | 4 +---
 fs/xfs/xfs_inode.c  | 4 +---
 include/linux/dax.h | 8 ++++++++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd48..cf87c5b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3890,10 +3890,7 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) == 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(inode));
+		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
 	} while (error == 0);
 
 	return error;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 501a097..af436b5 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -676,9 +676,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, fuse_wait_dax_page(inode));
+	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
 }
 
 /* dmap_end == 0 leads to unmapping of whole file */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index bcc277f..eb12123 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2989,9 +2989,7 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
 }
 
 int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d3e332..773dfc4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -213,6 +213,14 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
+static inline int dax_wait_page_idle(struct page *page,
+				void (cb)(struct inode *),
+				struct inode *inode)
+{
+	return ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
 void dax_read_unlock(int id);
-- 
git-series 0.9.1


Return-Path: <linux-fsdevel+bounces-42817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44142A48F97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC3616F64E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2071D8A0D;
	Fri, 28 Feb 2025 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f72b0zK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112B1D61BC;
	Fri, 28 Feb 2025 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713554; cv=fail; b=qQ+u+UOiQ8PV0JN/QEiYafl2HNUGRSNpbwtUNjfb+3QcjoqvqwnkHn3WbA7/Oz5XMH5lsq34dg/wfmgWLvjMwTrKjeDH7ZLPDfmITsY1VVUxMkKSrZbL8awp4J/Kp2BhQ3DdysHVUTmBayJcwHd9wbIcMK028d/3SeZTCSSvxZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713554; c=relaxed/simple;
	bh=4Knrsm1AVwFbpU5pBM2ITNJ3OGe+USlGdgFiYAe7yrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oi3Cu1tdNSAuoX1OjCQYGFfwuedCKvDKn7ppgR1JtAPU510Qkh/Swdk1CU1cW2Mltd+1P6NRzZGGd4v9fkEAss5bK6o9Oc+raET5iPEe6gZfmjtjOHlGGRceIJByt1jW6FPhZB9gaamVYtPRCf47TMtVRnrIfcCmP42lzoBPuMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f72b0zK/; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLftpql5nBKOKOc1fmqUUu8apTQRadIkKCguU7WIov2hcuZd0oJiOE/qmKJrIFBk2ygcRnYQnO+MUhVdu+YkwEEsNArcOc0ZVygnz+OqHPY04sq/tZ9fKwkgz/N7hycgeTIG18G3qK0fuwdhRjX7ML41VuBvc03SEc4amLJ7SqZaBwKDmzuMtocPhRrYgCT6ob7udQpijzB0GYZ7uzOM45NpwUl7gz8goUyhNqQh6jPP3E43ETI7+qUF7p2qDVZ41pDw/StNcG/DOJgq+2jGbXqLjFqZ+JOjhiKBzDarDKV4hstnm1IMXLp3/66btljpV8PInFX/FJzccz7QLG5P2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqUAyvSreWQSx6y7bcA3/W+0/nsi680Xnn1rDdTp16A=;
 b=gEZAQkCcxEflP5xxFKmFv0kbPt17rN7nER+3auAC4yyQ2FKVtOOeCB0b21QMqxQLCZp3o2TN7xp/WMGdryb87a1yHoxpc3BE1YZKLhAOWgjr8mBi69BvcDLKgRSR+ceNgGokG3Jb+RkLfmm9ppGfus1v1sytsQlBJZOd0r6FL2RpCl5BH0fwJD1WH+OSnX5v+HH51oDcuyQJj9s+zS9r3dqw9BXrDr0n718a8VpY9toCQVvGq3Ms2MWLh9Gz+blQiVn8L7Md0Aq69oMeVsAQ8vIrXWS4ZxjT+i+wLsA4yjnhiZZdKbeT3s5ffkpWUXsGbHfCY85877FbkFzRrjxdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqUAyvSreWQSx6y7bcA3/W+0/nsi680Xnn1rDdTp16A=;
 b=f72b0zK/zHjJTHIIqXmy2M3qWN7fZH9Ln29YKAC9fizbC0k5bDO6vajj06FODGr/DfvQHB0iFICJLVY22vNM0jwp/WgFG/Oy/TeZHGYZKF6tD0/gLPy56IJYqpMdKaj+UcV4WHZ6+MZV8iLBjQEJHUcAowRxgXuFSwAoKSwav3rYlVFtXMXBrkIaGnKU28cnTQ6PPs2SkAX2z/2zr40lkxCwMHUtLv9euMpL4Q1PJlHqaaHeXdJUI6gEhqy3v57G2gqhukNa1EJpXGLZjJU+UunzkicE3Hs4FPDrXKRNfgCfi6HtoI1swS2/2npVjFoicakjsoZXEa2k58Qkbatksg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:30 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:30 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
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
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v9 14/20] mm/rmap: Add support for PUD sized mappings to rmap
Date: Fri, 28 Feb 2025 14:31:09 +1100
Message-ID: <248582c07896e30627d1aeaeebc6949cfd91b851.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0128.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: ceeab409-4438-4988-4925-08dd57a8879d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oeeCy5iUmCo3ajOydYaIEMK5H8pLtFYl2kfoMHPAC7ZACFgtpvSoSA489Xmz?=
 =?us-ascii?Q?p0ds9d4LTDCLjErxfA2rLg0vUvBg+OPr7Si5vmJFg+mHzIH1fqhOv7E5Y8YE?=
 =?us-ascii?Q?WMjC21OG93oBnKHl6+vTyAwfh8MGS9YaYsONuz8J2fRfASVj8PNbNyJW4S1g?=
 =?us-ascii?Q?hVBxk/FpsASI0XFD/ZUqgteNumtDPmNkEnNMwTO9h4NErN0zZTaAd/SCvtly?=
 =?us-ascii?Q?bCl2CUoPDcUlStKKuM3/dM4twhIxmh8FUdfPVnqY7q5LtyH7BTZ0Z4HyXhJb?=
 =?us-ascii?Q?9HFXUo81BHHoM8Fw2b8o2KQkqLo6Crmh6He4G3GpTmKrEZKHDQ5Vb0UDF/01?=
 =?us-ascii?Q?HxA9dZO6tEw3Z+1eiNAFIlk3lzvLzYVq4K/f29erw7lw02i4ZDvh+rWXlfvl?=
 =?us-ascii?Q?pBFvwqhoH0XeZW1fXe4bGYU+GPz4RrB67vWQHhDmHjjTHm/YGDI69madSTQ8?=
 =?us-ascii?Q?x/gLVG3ckF+PAxxq+9wq/Pty1WUyREvDBrzHZ9QbyhxbNj9XWuAioCglpB30?=
 =?us-ascii?Q?efyoje8MGypMyieqgVj0iRecoWEEzlMTEUmW2SRBo1ES/yRT4k1coeLf735E?=
 =?us-ascii?Q?IMIrNN0LUV+ak1yS27h7UByJzgoeqs7LpfRJGSn1y7ez5X3neNrR4xX92y+y?=
 =?us-ascii?Q?BHYEfOXOnlYkxZ4lyiEE3teF+h0U37SaTXmf1woxhyHPzdc8/VqZdZZMnBvL?=
 =?us-ascii?Q?nG/SYuj380nmxcZ3+ZHSuOyqModxGQstffrLZ9M97XyW54iP+obvUqirViR5?=
 =?us-ascii?Q?HZkG609t0b3pvOiYmGBYiU8TQ51dIHX1SIErf8fDb3O0EM2a7zT3xYC3lhcq?=
 =?us-ascii?Q?F7KgGHWEWEcacGveUsOX4PtaRGzLrCkN4iK9fQC7TuHKfb8gsWPDf5hVTofe?=
 =?us-ascii?Q?lFg1dGih5vjT1RvRiYor8Eb/7P2rfCVFm85qqGDjFEw5k7CpVlMXoGQSFAeZ?=
 =?us-ascii?Q?eTRq7CyYheU7SEsD9AE/nCW0tSISKpMFKUQrL3FW2ep7lmBQwKSj3RWKMScm?=
 =?us-ascii?Q?eDYBluMSWH+f1mT0chsxHWeDsFycZ9LehQyfyPbNjdWZkS8JX4YnwZmc+LPm?=
 =?us-ascii?Q?M4EJqarXzA5cjdIFAyaxW7drnUXIMIptXq81aMttVCglq43732y7q7ux2/ji?=
 =?us-ascii?Q?1mWVmRNcyR5yebX2xdE5dCPGAD+ORFNfydiMjBCbLzipiZyBzUk69imztUVz?=
 =?us-ascii?Q?EQ2FCASt9BAExog/1qw2D70Fw4XKy8wn+UWJA25tUeZxI+US/0XnWVaM5W/i?=
 =?us-ascii?Q?6ksXEP0jRYwMtiQYqrzfiNVX82/8Z+eu/ZyedIuNIj7GLo4Yyv7FKiToVLnu?=
 =?us-ascii?Q?mgH2kBxuG6jz7z51kOjAvWx7lnMQ2ggVmjzEVquHnNhlgB1bnk52t413vEEb?=
 =?us-ascii?Q?1djFsYaggRuu2w8EhTtV+7YbkscH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D4evzlrrf8XbL4GuD4fm/XG/91tcO7oOZnC0VKIMo4sUtLx5Ggxzn8LwGZ2I?=
 =?us-ascii?Q?1jIFd8VFGmtoDwsc1i+Kt0/NaTL5Jt7UwK2E2amkr55IBUfPO/wYjXdnhVrv?=
 =?us-ascii?Q?oYDddKKEqhKc+QOzsRdp5abrFkdFX5A9y5tLAOD2KEKb/IMDVsssgdtOwSKy?=
 =?us-ascii?Q?SJvSpMi9bjMJ70jsg2o/6shvrRgub1H2aAlVTIovEN0vneyRG5lRJHlg0GtO?=
 =?us-ascii?Q?So52OQb4FpisqwmVajw1Y7lsgbX6RyknAY5vEzsjQuWUtC2dijTG5H9u7+ZS?=
 =?us-ascii?Q?zB0c9jrqqf6jqcNNxZmYt/sltajdFJ5qc/E+2abNDMKW2uEkWxDWnIf73a8A?=
 =?us-ascii?Q?8MEqQUHj0fcnvvnzR9BrW8OuZHs5gEL2HOqbQz8R0pcJxh3IFERzWXqhFiKv?=
 =?us-ascii?Q?pDEKyzAmmX2xVuqFugowrAZoNKL0lf57uDdaCMyhpGVAcO6mkyAZIIPzWuxu?=
 =?us-ascii?Q?btGRh9NaMTttYo0NovHvx/HsQOM+jmYHuhbKhYvlxLyNdVGXL77CmYqo4YSc?=
 =?us-ascii?Q?zTDKpjQfaXPos4teJjxIXbVEc5XHqHVxGYWXldLjbXcuZNqSAqAwtg14p6jw?=
 =?us-ascii?Q?6cXaqhoA53hlxH7lbrbDbDpMBfwpRTeHPCSlX95tOzk/UniQAFqbo41DqcBq?=
 =?us-ascii?Q?wnqblbkuUPm9vTR4iHtLSYpIPtT399asVbfFpCfs/oYTn3FV5+5Io+VrxoBF?=
 =?us-ascii?Q?xoEz3+8mbI5Cj3F9If98f1szhzMnGoxUtCk9cik8TtDhVXe6VhV11Kp4VeIy?=
 =?us-ascii?Q?NFtfji/ma3RyXPnOP15oHekhGpLrBVTbCR2hyC2aMTFwpA2KIqnZWQ57f51N?=
 =?us-ascii?Q?QC7Y4HA6pkeohL7UJLxrNVAe9bNG5pligvRqQXKZiYEEqk7TdG0pTKbXXlGX?=
 =?us-ascii?Q?5OUYUheYOmHyalGWg+vXl4CkKQfBr+MDegKnzyNeitOq+sCz/O1mOZgNN0mN?=
 =?us-ascii?Q?7x7BMAfK1t780aJqVIXIBUuCjoY+GYBja+wRthRHnM02CMjoX6TtX3pAAfQa?=
 =?us-ascii?Q?DjqnBujbcwurSqSJZdF2mDhbgkN3ffJdUfry7H9yUgTyNxObbtbsh2oY3+rf?=
 =?us-ascii?Q?fK88TCSVd9OwA4WwujtnJt9rIgAJD7+9KSA3DiWvwloVfZf6ud5skvpjSBFG?=
 =?us-ascii?Q?xHww0jdoI8OEK3zDPaPNtgJJsV81lg8GKtNBtKpjeer/0UQyhVjKJ1BpGrVo?=
 =?us-ascii?Q?Y2K3oxwPkdeMzPxMgAbQdKd3D1uZ/Yc+EB4Kg1sUzJx7YB/3taB4ZdvNEVIS?=
 =?us-ascii?Q?Cs9/54ikDoUHXToqBnwEv6jlW60xZs5Wy3fYTnnq0y7fIcZjnNW1NofNLmPg?=
 =?us-ascii?Q?S0ZlyF7u+IbeuzAujCnKitLv71AF9QxYdK6v/3J+saGTmhJiYj1pv9g776LZ?=
 =?us-ascii?Q?SolYmKxg4elRjd9JZvrvuNcNC39QADBZXELJ9qMDfbIBtxFhu7q6CNobH72X?=
 =?us-ascii?Q?OiAiMR1JzDYKrZvR0Tv+HHsfP8gfLQ2QSOagj0LSfAKCXX61kAPaXTBQP87k?=
 =?us-ascii?Q?R9ttOk9L3SlrXeKSD1HwQ1dXTQyrEJ79VgKp7HNSIDdHM/sfXVK6sb5SvdNn?=
 =?us-ascii?Q?qQ3V1YQESB9CuZ7HOjc4jytmtWG2DH9QnguBjdKK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceeab409-4438-4988-4925-08dd57a8879d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:30.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRBxsA8DH3JtyeAS++Tt5cMwRnqEyiujCMYaWWyLHDSzoSGuLqBqyjnYyw/ubjbBsRAy7pkrDFGaJZYArtxYTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

The rmap doesn't currently support adding a PUD mapping of a
folio. This patch adds support for entire PUD mappings of folios,
primarily to allow for more standard refcounting of device DAX
folios. Currently DAX is the only user of this and it doesn't require
support for partially mapped PUD-sized folios so we don't support for
that for now.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v8:

 - Rebase on mm-unstable, only a minor conflict due to code addition
   at the same place.

Changes for v6:

 - Minor comment formatting fix
 - Add an additional check for CONFIG_TRANSPARENT_HUGEPAGE to fix a
   build breakage when CONFIG_PGTABLE_HAS_HUGE_LEAVES is not defined.

Changes for v5:

 - Fixed accounting as suggested by David.

Changes for v4:

 - New for v4, split out rmap changes as suggested by David.
---
 include/linux/rmap.h | 15 ++++++++++-
 mm/rmap.c            | 67 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 69e9a43..6abf796 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
 enum rmap_level {
 	RMAP_LEVEL_PTE = 0,
 	RMAP_LEVEL_PMD,
+	RMAP_LEVEL_PUD,
 };
 
 static inline void __folio_rmap_sanity_checks(const struct folio *folio,
@@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
 		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
 		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
 		break;
+	case RMAP_LEVEL_PUD:
+		/*
+		 * Assume that we are creating a single "entire" mapping of the
+		 * folio.
+		 */
+		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
+		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
+		break;
 	default:
 		VM_WARN_ON_ONCE(true);
 	}
@@ -251,12 +260,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_add_file_rmap_ptes(folio, page, 1, vma)
 void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_add_file_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_remove_rmap_pte(folio, page, vma) \
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_remove_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
@@ -341,6 +354,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
 		atomic_inc(&folio->_large_mapcount);
 		break;
@@ -437,6 +451,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		if (PageAnonExclusive(page)) {
 			if (unlikely(maybe_pinned))
 				return -EBUSY;
diff --git a/mm/rmap.c b/mm/rmap.c
index 333ecac..bcec867 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1269,12 +1269,19 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-				*nr_pmdmapped = folio_nr_pages(folio);
-				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				/*
+				 * We only track PMD mappings of PMD-sized
+				 * folios separately.
+				 */
+				if (level == RMAP_LEVEL_PMD)
+					*nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of a remove and another add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1420,6 +1427,13 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		case RMAP_LEVEL_PMD:
 			SetPageAnonExclusive(page);
 			break;
+		case RMAP_LEVEL_PUD:
+			/*
+			 * Keep the compiler happy, we don't support anonymous
+			 * PUD mappings.
+			 */
+			WARN_ON_ONCE(1);
+			break;
 		}
 	}
 	for (i = 0; i < nr_pages; i++) {
@@ -1613,6 +1627,27 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @vma:	The vm area in which the mapping is added
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
@@ -1642,13 +1677,16 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_dec(&folio->_large_mapcount);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED)) {
-				nr_pmdmapped = folio_nr_pages(folio);
-				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				if (level == RMAP_LEVEL_PMD)
+					nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of another remove and an add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1722,6 +1760,27 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_remove_rmap_pud - remove a PUD mapping from a page range of a folio
+ * @folio:	The folio to remove the mapping from
+ * @page:	The first page to remove
+ * @vma:	The vm area from which the mapping is removed
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_remove_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /* We support batch unmapping of PTEs for lazyfree large folios */
 static inline bool can_batch_unmap_folio_ptes(unsigned long addr,
 			struct folio *folio, pte_t *ptep)
-- 
git-series 0.9.1


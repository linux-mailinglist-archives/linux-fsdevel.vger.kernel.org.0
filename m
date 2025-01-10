Return-Path: <linux-fsdevel+bounces-38829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2B1A087E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55CA3A27C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8C20E328;
	Fri, 10 Jan 2025 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eULZS441"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9020E03D;
	Fri, 10 Jan 2025 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489004; cv=fail; b=YtrgZswa3pJYM61zbisVrpUqXj/N4PeClyTluDpjgejiZpGy9Kzn8Iz+Ewk8mbscvet74KVAYidoWV4bIPggY2AcSRQ7P/n2niF2S2X7PrJrUZdet+Ok3q4yDh1javthcAWg2iIfUHgvNTMT0e4+gMTzEz5+rN7mU2RYaA1KxZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489004; c=relaxed/simple;
	bh=taho/x8vaIaAaNdv6LexW8I/gnW2swQvlJXq8F3HsE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fz7AE+Z+ruDQf3wkngbHKHc19QN8VCiQGeHo+5VOazg6pHNlVsALkWpibkvii1SDRFwdWWxQD3Um+DRu+Xc5Pl6i8I/9PSGackz9UNiXpMIdiW2dJAgZO9BcQo7+kE+kgLLreYeqp0X5e6EQJEXdBfEPW44arNzBD5iGwkCOv8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eULZS441; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhB+KYqFDn2GL159dacHX1LaaaVtAMoiUFpmM55Dm3VWjNrPmwbKElsdHCH4ciOXOa9PbFzmtPhshvYxPc1JOphG06a8kjl+HBXKmMiJqO9gpxFzcxUFDyL7evhqKLdSDpSSML//EV3rinupkQv4YtuEibbdtARQpYfXrOYLRHZCVW5ux2wkatv5RuCfbrVkz8+OrE5Wmt8U/u6ZJ+gvfR1P8ztGwafjEyFAtiqRjp73E3S5cUUjqm5BsjxiKtSCVtycW7tCRcM59WlI0ZLfeERoeSKbujwNXSNEHlTrn9ljOUcEp8KH9KDpkX2yFgdhrs1CU8eaS2A3QGTgg1VcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BinXnIQD/KcC1vh8eYc3XhTYU6uKSyxVnlUP9l2aKs=;
 b=S5K3VhANA7cTtV5R2leWkDx3Ym6cx0VERVQnGT1lCjRCBGhy39P9wASTCSRxkYtMPFEYL0xTn9nY7B8ZJTA9xQ26Q6vs10be4Kxdz/eEwgDtoylW0QAb9Hb1llsOu4MwtoWahQB5cV5OW1wXrY++/3m+/iZdNGBQHxTsf8k60lkrapVN0jWWNLqgTfqpt/wg4Xf7zbyTZd6aBR49I38edR01aaDL9WYGsT/G2rqMRZPg3ap0gvp37iLnE32OuqgDPDRYiP8rphTy5x9nEjBQryi22V6NclgsSMbJ7XyeLOjIn5cHIqUkVzkUj9Mqv+CTadd7B63oLLg+49aR9xFFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BinXnIQD/KcC1vh8eYc3XhTYU6uKSyxVnlUP9l2aKs=;
 b=eULZS4410KRhuZ0ZLyYWWpDdT+QhM2iLN6zOpGH6310s78/3B5Hi2mzENbkqkyVoHFIhWXij+5u0XQy41aEPUBdMcn0GHap/lO5Se41HC4ZJ18UZuTMmcDkWL6Pwjp28eg43/P9b/qsJhrVeqVclgH/aGf/XT/V3HgNf2PCnDhjeZPtsasReG7T4kpYar30DHO3bQRf8XM/NzaJlFF+WFoi2akknoOaFPJLHZMnL1RXc+NbE3RC56Wxrz82ecm21XJPdUBZYvLdXLaM4/44baodCqba4FckWmrSCfYL5sIK74yJPIhpz3eBhqYeTSgpss1NYFGWpCrf1s3XHbO3rCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 06:03:17 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:03:17 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH v6 23/26] mm: Remove pXX_devmap callers
Date: Fri, 10 Jan 2025 17:00:51 +1100
Message-ID: <78cb5dce28a7895cc606e76b8e072efe18e24de1.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0110.ausprd01.prod.outlook.com
 (2603:10c6:10:246::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa00a42-ed2c-48f6-e0cf-08dd313c79c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XeET/6noL7bOiq2FMWIfbvQpSUf6kVDGxFyn1GQ5kYoqO/jXY2t3Jk3l1RrA?=
 =?us-ascii?Q?V4ajWRkpsHTOn3G3XW0u5iMZlGo6buS/c2/WlSxU3aVIlAZID+Mk+UqrWZmL?=
 =?us-ascii?Q?bETc+qWRncqWCHclY3R0xTCXbm5W2rr2lAJIo46KSGiqlKRzxzbmuEdtXMa6?=
 =?us-ascii?Q?IE9VjRfS1tFv8LOQ77UNGag4dc+jeCDb/bCrv2RHbp4MabXeeegBMkZfeuRE?=
 =?us-ascii?Q?6RU6M+ZNot8T82Zge4Ex599Gs8uRfMF9rjHZ1mlIWs3+aDAnonTJRXj7F/3L?=
 =?us-ascii?Q?7YqTcpfLhAMl32rn3L/PGCrqhTz0xziMB8yPfRhEPEr5f+VNc5r1Id6JdgxP?=
 =?us-ascii?Q?tm4jUnb/yyDU7gCrialEeseJYniFjPlPVd29KvjkRHwOSoeURUZx07gR1tpO?=
 =?us-ascii?Q?JPHAVQnAl9mBwAXxfJnnz5maylV/qX56bpgW8ggEpFRKttEYpCw7QLdvx+S2?=
 =?us-ascii?Q?90fDasgfuWpXTg0BYyt6O5E4gQAFKWb8Ep7yNsYJm4k2aBpVJj43F3IsaEbf?=
 =?us-ascii?Q?89qJfb0iyNf35TXa8Wzutt7US3ulFUzJY/ERtXKzrLuAJillTBgtpdJGlTAr?=
 =?us-ascii?Q?J6t7zXJqTYtwlt9GBZj7IDidmKxVYwucTPd8K5Gn+hyHHqS9oFsfC5sYbai3?=
 =?us-ascii?Q?2ROI2ia2BZnCwvKt2LjJCHRIlEehXrmQ/84gm0X7wQOF+UAg+RpDmC5kckkl?=
 =?us-ascii?Q?MlFP0FUemqjZTxKOqU8RvsMyS0d2hbmv0tnEjsoNYWKtVeW77gqoStjMnKHK?=
 =?us-ascii?Q?2epfHCTDSaG9mlnz+Gsld87QWVoEpCwaNEwmR65JNts2vvtwR/Hmo+16YkmO?=
 =?us-ascii?Q?bN90qe4Cn6In4ciBbfhUCeYE3zTKzVzQS+zFUB9/dF3KInYUt8T9dhjRBbmC?=
 =?us-ascii?Q?u7p9bFgKYzSQhgxBWSCv86pONLD4ctnzT+iFit43KzziE+9yJHKQz56li12c?=
 =?us-ascii?Q?+mXya3e2Nz/V/bim/6Exi9u6fDnL/feF0ESEV515oc9uZaVo4LcdXSAlljPJ?=
 =?us-ascii?Q?QfZFXXUmm7dHu9VJAOVn6eTWchFzj28hsY6zqPaJAjZW4iIzmtMhXTYrJR17?=
 =?us-ascii?Q?qJ4YM9tIr6GVdWgY0p3LXbxc3wYoTddFrTfZAYbrfBPjdQIxibcVboPEAjUl?=
 =?us-ascii?Q?r+whJSMnPFuH3i9yjZR4OCEnNrukDOULi4u12uqWHNkgGeEmDOrq8pbUUH8k?=
 =?us-ascii?Q?rESh4jZ0JQ76Ctg7WjCaiaXA9fuBh7buQKPOcjmLpSlgPkJUud5HKmY+Ia9s?=
 =?us-ascii?Q?RpaRE+H2BSwEDTIjXcqXr8bvvCDJx78FxhzyEKWUhpon4WTUv6jz0fv/bePR?=
 =?us-ascii?Q?x9+SaGfhRjoKEm305lcT6DFWlYYoSBzNLldqviiOoO9eiJ3XNihTmYWb8fJ8?=
 =?us-ascii?Q?GUhwpGX5+vRyzpiJ2IGXXxDfOgnW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v4niNmNtkeegPP6eEBiVAfFg9SVn1rh7XzgocA4sxL3XLlNPYTX0lSuM0+y2?=
 =?us-ascii?Q?jScHl+P32Cx2hV0zeSVUJItnz48YO9kqCzOb3RIjsZjSnga3e5egR5saP74r?=
 =?us-ascii?Q?FVU4KUOk61OP8mTSezTNHAqVQ5bgZudZzOQUbKO8Sws9A5P+8/sA4FdeJeC7?=
 =?us-ascii?Q?K8CFPcXKglVKcLTl+UfKIWkz1ePHRngS2i4NcZ7UkoXmJE341Rvk5qHDUp7B?=
 =?us-ascii?Q?X29QX5xSoz6WMsb9K5NECHO5jhOPuDekzbA6tgcMRUS5qm0w6CqEKCqE/mTm?=
 =?us-ascii?Q?dpaK1PunhSsZssmayJvooCiEz4wvZEKH3kh8OUpRnue2dohH0nrIof5y6Wou?=
 =?us-ascii?Q?1cRJYiCnkZmqWVD3cxNFfXcZiOB84QgWKTYYVITD5P6s/2h8PpjAcalQAS06?=
 =?us-ascii?Q?0psQbN1u2z3g96HL2WIgMARv4K47R3nYzHroCp1kmiAIDBrQZXOGpKn5u8ru?=
 =?us-ascii?Q?U8XeMVw1sMYP+NNY4HcuqoNHKfLNopKz12dvCuo0Q9/OOR8yah9MQRrhMDTf?=
 =?us-ascii?Q?Y4IAXc287L66BQ5jJishc1i9GYvJgZqlnkjiKNjacKmeNjM5Q9HL7mnW1Ujb?=
 =?us-ascii?Q?JUUwxKe+mLvlisM0I/RsOTScPYXqFISRACy0ihP+agKXzev5nH0T9oGJv6LQ?=
 =?us-ascii?Q?9W6AzyD12S2RVIFAF7TLzq7WY8TfI/bmgeey+ztiFo26oxzXG09BIubNU/lq?=
 =?us-ascii?Q?rGjhO13y9/6EUdLFHVsZxUJuDUVmuJjK2rmCV/5KIsvyb4bEPhgLr/i1mj5W?=
 =?us-ascii?Q?O3oqPqwj6jXiQk8zcJQt8GT5OzLb5adtfseMq5nsMIiV9GdkKwKWQUgEQUQK?=
 =?us-ascii?Q?JavysI5nwW0p3kN/N5DSFdvGGPxzBHZNrywpWH/HQYnlzugjLXcVrPjKNydE?=
 =?us-ascii?Q?c2yPIxClQonsb8e2A7XvwrhezufOY1gPIyYEXwlayIdlCjMIGauiZ5BMQwO0?=
 =?us-ascii?Q?sXim8i5rauxJRsPvzSNsc41C7gx1lpkJFoaWOfy2cdI1qbEQp1CrsrURJBJ6?=
 =?us-ascii?Q?sqfBu9wWLol7IsQqC1qv8FtmRuugoliNjvuLn1b6FDGCemWjANQSFHOlEroD?=
 =?us-ascii?Q?ha/D+cr6NF16CvAUHbD1MOSLKZOjc16pGXP/k/QiBpeQaqFpFthlWF0kHZou?=
 =?us-ascii?Q?5yOSW50r25Ax74HqVdP5/3J6Vy/EJ83KReVsrQs/WdbrUmEDhD3rVzYboPBI?=
 =?us-ascii?Q?RZ+dCtcOTRtB77ImbU7pascIradIbMTa6esOjdnP7WYdkHxO7Oxnljgs52y9?=
 =?us-ascii?Q?BQpcDOJKdwv5/34RK0Ku1hEXm2vUL1V0qmFUU1/Bk/l6S9FpT1p/IkFm9unE?=
 =?us-ascii?Q?qqfLr7JO9c1VOwG6VS3c8FG5neovHzoXtFAz99bBh9Fn7EEgHlO6pl8fB2vM?=
 =?us-ascii?Q?Y/7VlOaHCIOwN6tFNE0em1B7Jn0DBLx+auOOfwfoAvWfNJIzujmdLnQM0h1c?=
 =?us-ascii?Q?Ys6CLTFKwgbmtEayyIF73lCpzrPRMFIqwUunBo8BUrMA/3lhEr3Z4Cqhu6zj?=
 =?us-ascii?Q?XHi++xdieYQb9/eKK11EIiVZ59o3cihfYibjE2z+GRXLwxyMRLBBclm+tlaN?=
 =?us-ascii?Q?u2kJH3miJ5hlHkWXtlz4L3ZTsd8fX7Z1gCrbHtbf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa00a42-ed2c-48f6-e0cf-08dd313c79c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:03:17.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSvDiXq/gLExes8IGdZghgukHzbXtd207YKzC0q8BJAyKnSjBNnKLmcz7kL247sBtor6S9h5qW8qmJx16u3p0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

The devmap PTE special bit was used to detect mappings of FS DAX
pages. This tracking was required to ensure the generic mm did not
manipulate the page reference counts as FS DAX implemented it's own
reference counting scheme.

Now that FS DAX pages have their references counted the same way as
normal pages this tracking is no longer needed and can be
removed.

Almost all existing uses of pmd_devmap() are paired with a check of
pmd_trans_huge(). As pmd_trans_huge() now returns true for FS DAX pages
dropping the check in these cases doesn't change anything.

However care needs to be taken because pmd_trans_huge() also checks that
a page is not an FS DAX page. This is dealt with either by checking
!vma_is_dax() or relying on the fact that the page pointer was obtained
from a page list. This is possible because zone device pages cannot
appear in any page list due to sharing page->lru with page->pgmap.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 arch/powerpc/mm/book3s64/hash_hugepage.c |   2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c  |   3 +-
 arch/powerpc/mm/book3s64/hugetlbpage.c   |   2 +-
 arch/powerpc/mm/book3s64/pgtable.c       |  10 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c |   5 +-
 arch/powerpc/mm/pgtable.c                |   2 +-
 fs/dax.c                                 |   5 +-
 fs/userfaultfd.c                         |   2 +-
 include/linux/huge_mm.h                  |  10 +-
 include/linux/pgtable.h                  |   2 +-
 mm/gup.c                                 | 162 +------------------------
 mm/hmm.c                                 |   7 +-
 mm/huge_memory.c                         |  71 +----------
 mm/khugepaged.c                          |   2 +-
 mm/mapping_dirty_helpers.c               |   4 +-
 mm/memory.c                              |  35 +----
 mm/migrate_device.c                      |   2 +-
 mm/mprotect.c                            |   2 +-
 mm/mremap.c                              |   5 +-
 mm/page_vma_mapped.c                     |   5 +-
 mm/pagewalk.c                            |  14 +-
 mm/pgtable-generic.c                     |   7 +-
 mm/userfaultfd.c                         |   5 +-
 mm/vmscan.c                              |   5 +-
 24 files changed, 66 insertions(+), 303 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_hugepage.c b/arch/powerpc/mm/book3s64/hash_hugepage.c
index 15d6f3e..cdfd4fe 100644
--- a/arch/powerpc/mm/book3s64/hash_hugepage.c
+++ b/arch/powerpc/mm/book3s64/hash_hugepage.c
@@ -54,7 +54,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	/*
 	 * Make sure this is thp or devmap entry
 	 */
-	if (!(old_pmd & (H_PAGE_THP_HUGE | _PAGE_DEVMAP)))
+	if (!(old_pmd & H_PAGE_THP_HUGE))
 		return 0;
 
 	rflags = htab_convert_pte_flags(new_pmd, flags);
diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 988948d..82d3117 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -195,7 +195,7 @@ unsigned long hash__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!hash__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!hash__pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
@@ -227,7 +227,6 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(pmd_trans_huge(*pmdp));
-	VM_BUG_ON(pmd_devmap(*pmdp));
 
 	pmd = *pmdp;
 	pmd_clear(pmdp);
diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/book3s64/hugetlbpage.c
index 83c3361..2bcbbf9 100644
--- a/arch/powerpc/mm/book3s64/hugetlbpage.c
+++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
@@ -74,7 +74,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
 	/* Make sure this is a hugetlb entry */
-	if (old_pte & (H_PAGE_THP_HUGE | _PAGE_DEVMAP))
+	if (old_pte & H_PAGE_THP_HUGE)
 		return 0;
 
 	rflags = htab_convert_pte_flags(new_pte, flags);
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 3745425..916b4ce 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -63,7 +63,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(vma->vm_mm, pmdp));
 #endif
 	changed = !pmd_same(*(pmdp), entry);
@@ -83,7 +83,6 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
 	assert_spin_locked(pud_lockptr(vma->vm_mm, pudp));
 #endif
 	changed = !pud_same(*(pudp), entry);
@@ -205,8 +204,8 @@ pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
 {
 	pmd_t pmd;
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
-	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-		   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
+	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp)) ||
+		   !pmd_present(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, addr, pmdp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
@@ -224,8 +223,7 @@ pud_t pudp_huge_get_and_clear_full(struct vm_area_struct *vma,
 	pud_t pud;
 
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
-	VM_BUG_ON((pud_present(*pudp) && !pud_devmap(*pudp)) ||
-		  !pud_present(*pudp));
+	VM_BUG_ON(!pud_present(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, addr, pudp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 311e211..f0b606d 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1412,7 +1412,7 @@ unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!radix__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!radix__pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
@@ -1429,7 +1429,7 @@ unsigned long radix__pud_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
+	WARN_ON(!pud_trans_huge(*pudp));
 	assert_spin_locked(pud_lockptr(mm, pudp));
 #endif
 
@@ -1447,7 +1447,6 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(radix__pmd_trans_huge(*pmdp));
-	VM_BUG_ON(pmd_devmap(*pmdp));
 	/*
 	 * khugepaged calls this for normal pmd
 	 */
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 61df5ae..dfaa9fd 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -509,7 +509,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 		return NULL;
 #endif
 
-	if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		if (is_thp)
 			*is_thp = true;
 		ret_pte = (pte_t *)pmdp;
diff --git a/fs/dax.c b/fs/dax.c
index 19f444e..facddd6 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1928,7 +1928,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PTE we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (pmd_trans_huge(*vmf->pmd) || pmd_devmap(*vmf->pmd)) {
+	if (pmd_trans_huge(*vmf->pmd)) {
 		ret = VM_FAULT_NOPAGE;
 		goto unlock_entry;
 	}
@@ -2049,8 +2049,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PMD we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
-			!pmd_devmap(*vmf->pmd)) {
+	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd)) {
 		ret = 0;
 		goto unlock_entry;
 	}
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7c0bd0b..c52b91f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -304,7 +304,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	if (!pmd_present(_pmd) || pmd_devmap(_pmd))
+	if (!pmd_present(_pmd) || vma_is_dax(vmf->vma))
 		goto out;
 
 	if (pmd_trans_huge(_pmd)) {
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 3633bd3..9cb5227 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -368,8 +368,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)	\
-					|| pmd_devmap(*____pmd))	\
+		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 						false, NULL);		\
 	}  while (0)
@@ -395,8 +394,7 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
-		if (pud_trans_huge(*____pud)				\
-					|| pud_devmap(*____pud))	\
+		if (pud_trans_huge(*____pud))				\
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
@@ -419,7 +417,7 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
 		return NULL;
@@ -427,7 +425,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 94d267d..00e4a06 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1635,7 +1635,7 @@ static inline int pud_trans_unstable(pud_t *pud)
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	pud_t pudval = READ_ONCE(*pud);
 
-	if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_none(pudval) || pud_trans_huge(pudval))
 		return 1;
 	if (unlikely(pud_bad(pudval))) {
 		pud_clear_bad(pud);
diff --git a/mm/gup.c b/mm/gup.c
index d6575ed..95be530 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -678,31 +678,9 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
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
@@ -861,8 +839,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	page = vm_normal_page(vma, address, pte);
 
 	/*
-	 * We only care about anon pages in can_follow_write_pte() and don't
-	 * have to worry about pte_devmap() because they are never anon.
+	 * We only care about anon pages in can_follow_write_pte().
 	 */
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pte(pte, page, vma, flags)) {
@@ -870,18 +847,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
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
@@ -963,14 +929,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
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
 
@@ -2892,7 +2850,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
+	int ret = 0;
 	pte_t *ptep, *ptem;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
@@ -2916,16 +2874,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
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
 
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
@@ -2996,91 +2945,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
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
@@ -3095,13 +2959,6 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
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
 
@@ -3142,13 +2999,6 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
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
 
@@ -3187,8 +3037,6 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	BUILD_BUG_ON(pgd_devmap(orig));
-
 	page = pgd_page(orig);
 	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 082f7b7..285578e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -298,7 +298,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	 * fall through and treat it like a normal page.
 	 */
 	if (!vm_normal_page(walk->vma, addr, pte) &&
-	    !pte_devmap(pte) &&
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			pte_unmap(ptep);
@@ -351,7 +350,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		/*
 		 * No need to take pmd_lock here, even if some other thread
 		 * is splitting the huge pmd we will get that event through
@@ -362,7 +361,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * values.
 		 */
 		pmd = pmdp_get_lockless(pmdp);
-		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
+		if (!pmd_trans_huge(pmd))
 			goto again;
 
 		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
@@ -429,7 +428,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
 
-	if (pud_leaf(pud) && pud_devmap(pud)) {
+	if (pud_leaf(pud) && vma_is_dax(walk->vma)) {
 		unsigned long i, npages, pfn;
 		unsigned int required_fault;
 		unsigned long *hmm_pfns;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0cf1151..0d934eb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1398,10 +1398,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pmd_mkdevmap(entry);
-	else
-		entry = pmd_mkspecial(entry);
+	entry = pmd_mkspecial(entry);
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -1440,8 +1437,6 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1530,10 +1525,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pud_mkdevmap(entry);
-	else
-		entry = pud_mkspecial(entry);
+	entry = pud_mkspecial(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
@@ -1564,8 +1556,6 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1632,46 +1622,6 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
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
@@ -1823,7 +1773,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	ret = -EAGAIN;
 	pud = *src_pud;
-	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
+	if (unlikely(!pud_trans_huge(pud)))
 		goto out_unlock;
 
 	/*
@@ -2665,8 +2615,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2683,7 +2632,7 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2734,7 +2683,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
-	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
+	VM_BUG_ON(!pud_trans_huge(*pud));
 
 	count_vm_event(THP_SPLIT_PUD);
 
@@ -2767,7 +2716,7 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	if (unlikely(!pud_trans_huge(*pud)))
 		goto out;
 	__split_huge_pud_locked(vma, pud, range.start);
 
@@ -2840,8 +2789,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
-	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
-				&& !pmd_devmap(*pmd));
+	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -3058,8 +3006,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 	 * require a folio to check the PMD against. Otherwise, there
 	 * is a risk of replacing the wrong folio.
 	 */
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
+	if (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)) {
 		if (folio && folio != pmd_folio(*pmd))
 			return;
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 99dc995..aedef75 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -957,8 +957,6 @@ static inline int check_pmd_state(pmd_t *pmd)
 		return SCAN_PMD_NULL;
 	if (pmd_trans_huge(pmde))
 		return SCAN_PMD_MAPPED;
-	if (pmd_devmap(pmde))
-		return SCAN_PMD_NULL;
 	if (pmd_bad(pmde))
 		return SCAN_PMD_NULL;
 	return SCAN_SUCCEED;
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2f8829b..208b428 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -129,7 +129,7 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	/* Do not split a huge pmd, present or migrated */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
+	if (pmd_trans_huge(pmdval)) {
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
 		walk->action = ACTION_CONTINUE;
 	}
@@ -152,7 +152,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 	pud_t pudval = READ_ONCE(*pud);
 
 	/* Do not split a huge pud */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
+	if (pud_trans_huge(pudval)) {
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
 		walk->action = ACTION_CONTINUE;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 02e12b0..d39d1c5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -603,16 +603,6 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
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
@@ -690,8 +680,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 		}
 	}
 
-	if (pmd_devmap(pmd))
-		return NULL;
 	if (is_huge_zero_pmd(pmd))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
@@ -1245,8 +1233,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1282,7 +1269,7 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pud = pud_offset(src_p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+		if (pud_trans_huge(*src_pud)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
@@ -1797,7 +1784,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
@@ -1839,7 +1826,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
@@ -2454,10 +2441,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	/* Ok, finally just insert the thing.. */
-	if (pfn_t_devmap(pfn))
-		entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
-	else
-		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
 
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
@@ -2568,8 +2552,6 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (pfn_t_devmap(pfn))
-		return true;
 	if (pfn_t_special(pfn))
 		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
@@ -2601,8 +2583,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) &&
-	    !pfn_t_devmap(pfn) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
 		struct page *page;
 
 		/*
@@ -6034,7 +6015,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		pud_t orig_pud = *vmf.pud;
 
 		barrier();
-		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
+		if (pud_trans_huge(orig_pud)) {
 
 			/*
 			 * TODO once we support anonymous PUDs: NUMA case and
@@ -6075,7 +6056,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+		if (pmd_trans_huge(vmf.orig_pmd)) {
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf);
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 2209070..a721e0d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -599,7 +599,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmdp = pmd_alloc(mm, pudp, addr);
 	if (!pmdp)
 		goto abort;
-	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
+	if (pmd_trans_huge(*pmdp))
 		goto abort;
 	if (pte_alloc(mm, pmdp))
 		goto abort;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 516b1d8..31055a8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -384,7 +384,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
diff --git a/mm/mremap.c b/mm/mremap.c
index 6047341..96fff18 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -603,7 +603,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		new_pud = alloc_new_pud(vma->vm_mm, vma, new_addr);
 		if (!new_pud)
 			break;
-		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
+		if (pud_trans_huge(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
 					       old_pud, new_pud, need_rmap_locks);
@@ -625,8 +625,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		if (!new_pmd)
 			break;
 again:
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
-		    pmd_devmap(*old_pmd)) {
+		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
 					   old_pmd, new_pmd, need_rmap_locks))
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 81839a9..18eadc5 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -242,8 +242,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
-		    (pmd_present(pmde) && pmd_devmap(pmde))) {
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
@@ -258,7 +257,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
-			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
+			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e478777..6a7eb38 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -143,8 +143,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pmd_present(*pmd) &&
-			    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
+			if (pmd_present(*pmd) && pmd_trans_huge(*pmd))
 				continue;
 		}
 
@@ -210,8 +209,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pud_present(*pud) &&
-			    (pud_trans_huge(*pud) || pud_devmap(*pud)))
+			if (pud_present(*pud) && pud_trans_huge(*pud))
 				continue;
 		}
 
@@ -872,7 +870,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		 * TODO: FW_MIGRATION support for PUD migration entries
 		 * once there are relevant users.
 		 */
-		if (!pud_present(pud) || pud_devmap(pud) || pud_special(pud)) {
+		if (!pud_present(pud) || pud_special(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
 		} else if (!pud_leaf(pud)) {
@@ -884,6 +882,12 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
 		 */
 		page = pud_page(pud);
+
+		if (is_devdax_page(page)) {
+			spin_unlock(ptl);
+			goto not_found;
+		}
+
 		goto found;
 	}
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 5a882f2..567e2d0 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -139,8 +139,7 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t pmd;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-			   !pmd_devmap(*pmdp));
+	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
@@ -153,7 +152,7 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	pud_t pud;
 
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
-	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
+	VM_BUG_ON(!pud_trans_huge(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
 	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
 	return pud;
@@ -293,7 +292,7 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		*pmdvalp = pmdval;
 	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
 		goto nomap;
-	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
+	if (unlikely(pmd_trans_huge(pmdval)))
 		goto nomap;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4527c38..a03c6f1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -790,8 +790,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		 * (This includes the case where the PMD used to be THP and
 		 * changed back to none after __pte_alloc().)
 		 */
-		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
-			     pmd_devmap(dst_pmdval))) {
+		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval))) {
 			err = -EEXIST;
 			break;
 		}
@@ -1694,7 +1693,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
 		if (ptl) {
-			if (pmd_devmap(*src_pmd)) {
+			if (vma_is_dax(src_vma)) {
 				spin_unlock(ptl);
 				err = -ENOENT;
 				break;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 39886f4..b0e25d1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3366,7 +3366,7 @@ static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned
 	if (!pte_present(pte) || is_zero_pfn(pfn))
 		return -1;
 
-	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
+	if (WARN_ON_ONCE(pte_special(pte)))
 		return -1;
 
 	if (!pte_young(pte) && !mm_has_notifiers(vma->vm_mm))
@@ -3391,9 +3391,6 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 	if (!pmd_present(pmd) || is_huge_zero_pmd(pmd))
 		return -1;
 
-	if (WARN_ON_ONCE(pmd_devmap(pmd)))
-		return -1;
-
 	if (!pmd_young(pmd) && !mm_has_notifiers(vma->vm_mm))
 		return -1;
 
-- 
git-series 0.9.1


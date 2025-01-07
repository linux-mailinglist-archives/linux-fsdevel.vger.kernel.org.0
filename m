Return-Path: <linux-fsdevel+bounces-38521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515FEA03600
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF45D188243A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199961DFE23;
	Tue,  7 Jan 2025 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GynSl6C3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5F1DE4CA;
	Tue,  7 Jan 2025 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221401; cv=fail; b=JaDcv8zQWGs53eYjJ4iAtNxp0PgSc9UvO5uapdMJ/3QYNxY7APSWZzEp/ImBbMYbpS8VyyIuy18wl1j1aFDBgN9AoiUD2YDQCItGjI6a1CG0MmIQ1iRyGI/RU7/bGZ/YJh4/i8G+7qgTtJiiGx4kZeVswABwJd3XUuKUieF6T1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221401; c=relaxed/simple;
	bh=tIOOW+Nrc3D0iOSBxejuf1cwiGMgPxMrkh9/3p7R5TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BjUh5TKgmxW+L9e625URvHxaeHw1eLknnKnaSq3FTSwB3OlxhlCGYPRFD01otbMieIZdv588qlBxk3FD8UxMlfe1QhHvuvxqxk4KgPRxh2zoXdRKb+hlQ1S99Y/w4XArt3HEgy94LjdgIB4KyeXkfpSpQlzFfToHnQQ2fmFU41o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GynSl6C3; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ln4sNNUTGCA9J2EOtq4mcutSy/Ay7L5dj66cP+a7OvVi00pw5sVWlLJ66fGQkyS6HD1iK7513JZrOnqACXTaASnSOQLmgjqOZPGS8JKdcH9CJgYufmgJqm1ngdSYMhATANid8iYmOBn3epZHMF33t8J9XqhcL/MWBhfB5s7NSnCiuXbyshkNC2DDKFVPH9oL8a5f0Ry+ASM4VZ8xmf57iE3jae9++/Cxqnhvl6X6GtoooaEmFI6EX2Lm6FmRC9zOIMexYctMyuJ9Emnc7WGGewMxKq2nMO1cafQlt+WpxVDh27cNpmvYIcCxozgpDldIuSNnoSvJjMCypHKA0NzvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE5P8XNU3ah4J/7ozO76nVLgHi9O2KTRIMaPoDiVlsY=;
 b=j2iH164Nz/wkKe30QWQeWznQpJFpR/TMl2ap9bE8K4sqoUTmaDwHARk938W1NCNGP/Gp5gHjEbfS/64IGJA15c/+cbhx12Ge8sfWHVm/uzFfrrOeq+S3jWDYyedAJ9w8cpgzIySUri6LGqAi3IGW9hWStJFnJpTE+t3T+dtiMB54R0IS8ANhHirWj7oqxxUIcX0IQoVkIUxl26x7yEaCLy3LyN3wr4J7m1ogn0DUyh8PmrtrCG3kwfV+hLLzywvWXkAdtiFUmVS4v4ykRxNF5EVjoSR3fjv36TL1doRRJ6B34pDDh7g4jdaLqt+WSj3yYPfwIRMC/6Li686BajxEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE5P8XNU3ah4J/7ozO76nVLgHi9O2KTRIMaPoDiVlsY=;
 b=GynSl6C3Pfk/xtOKFZbGFv7F/92kO3YghALqGRuFuii8TMQ99ALVQystKcbSEzH7pdcf/ZGEtxiCIAmU9pet/1i7+V0P9IOQT7nP4hDTvjBEIKFPuY+eufgYNSGNPhTEd8SvwXl+TtW5BY+93SN8VqtEKLHbd8UgksR/AZV9+SD7Lb+8IarX3e5WHJ/eBGf+qOkRKNVnY/qtrM4sEuArTBsQ1X3FmN4+uoyibgbBMctJZzuMfGJAutZ1NivQCzgnQuVZ23cbFegEFpk4uG2cG5uzU2m3oAxe/gNqprHVrxgnAx+tPbpQasv1o5qwsUxBY6ZHJeNtGs0CUJEbdAWWJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:12 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:12 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
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
Subject: [PATCH v5 03/25] fs/dax: Don't skip locked entries when scanning entries
Date: Tue,  7 Jan 2025 14:42:19 +1100
Message-ID: <6d25aaaadc853ffb759d538392ff48ed108e3d50.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0041.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4f795f-6edb-4ed8-e0b3-08dd2ecd68cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?euVjFz4+bXH+q9euWir23blYX7UZfry1zSRyUGfKlmrZslWVKDBLhoubf5Hg?=
 =?us-ascii?Q?pWCrax6BjbqyZr5VJXKj0GvLrP/CCzIchGKuhW1MjKMva7nBCPMjrzrc2lSZ?=
 =?us-ascii?Q?dQc25ktuQ9tziyXz1/4gHjji+jFPqvZF135I6HSC5F5HLI8xts64mzPX0v4o?=
 =?us-ascii?Q?9ICsVMZzPXW5Zh6rMegxIA/p2Nj1l0I6AVRvljnLjLTy6vArNI5NhlH9Knuv?=
 =?us-ascii?Q?sozgprDaIbm1Hdw5V7Mx7fc4uGleglxeP0tpZiWjc/sbK5KP8nuVDDdz6MDS?=
 =?us-ascii?Q?yFdLJHrxLCVCz+OB3BR7mct2Erl9pG2vVo6I+00wFNUnF7/fpU4yhXRq4dsb?=
 =?us-ascii?Q?/KEKrpCbjVfOVqALQ3UCjUs2lIC7OKEnampfBkERYRi55lSUOIUEchYmA9tH?=
 =?us-ascii?Q?km0e+gYpqH0DFEBZDet1mfBrOsm/zbw3rYxscTlGN1Mw/f++wIStmlRencYN?=
 =?us-ascii?Q?fA2RCNI8s3ncdlthyXuLBNC5xjzPNroh51XCeM7slQmJNab19NTDxZx994l8?=
 =?us-ascii?Q?+/chLXzIgR5fmtU7OgHWPg+oSoVRYzkEgszXZ0n/8D2NMQV8ZCUDBXuL8MMk?=
 =?us-ascii?Q?U/ikfuiITWUlGs5BakFplWJXHE3EV3sYiQbV7S/lwEkDQ2oaxiVRhMbnIi1r?=
 =?us-ascii?Q?DRIrI38QQmw+0uVOFp187llOg/Z9ouNMIcgOCQFIMd7ciPXWTBRr6AWhTJ9+?=
 =?us-ascii?Q?AmO6cNBp5YwYjfQ9xVD98ta3hhc3KG/UWZ7KyskrDfrp/p9Kdb1KFl7q4Dhe?=
 =?us-ascii?Q?usE/O7LqXy2ccHYP9Qa1hYGJXUuVmQM52ve+zkCA8IVk0vJXf8YoQcJgkMyK?=
 =?us-ascii?Q?+a6JgDtGCp10KtulIh7ha+Be+Az2CXoXHfDnfXKGqLzr0YDRTzuZ5zV50sVJ?=
 =?us-ascii?Q?sj/Iy2y4hpGhhJVHydQK5VqsL7j07tNKDXKEnsETI7bheUt/pTEhrS1EFsPs?=
 =?us-ascii?Q?v8Ff7tDwIOAizfixuX/q2tBhzH8U46N8/VxZBOoLbtZdz1QY1AMLL0lS1LAY?=
 =?us-ascii?Q?X6bgbG/gNNveWI7ZV2WGVLvzXtIS0D6a6tL22SGBqO47YM2q12p6AcUKbEc2?=
 =?us-ascii?Q?JrnJYqy80AHmlhXsAfSDcJ1Omv8B8yvxI+gRTZbLob2TK5HbVyu0DdnCLqsk?=
 =?us-ascii?Q?1vTY84MFxpX5U6ui4eejUuWPEulSuR9qq0oGU7/cXyl7bIO9RSXKKSROoZ+q?=
 =?us-ascii?Q?V5yVrE4o47NGgu103ICebvC7/Dq2mi5jo6NE96DgoWyQN+ad05h9aIWE6M/K?=
 =?us-ascii?Q?7FRLmwzcBtJDdzoxyMtJbdOH1Lp8rbSECkjVvkZkoC6VIneTFsMd25gFL442?=
 =?us-ascii?Q?kLOfK7j+Wm4wVf+WkyIBLZo+KpWXs3R2I6GVpf8W4RmRyCEOQ7qCeR1EflRz?=
 =?us-ascii?Q?6amtn/5kaFFkykopAQGuD+3/RUZv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vj5t65XOdK8u4JFMkhrpJ/R3O8jNTuiINmp8u6qvY3jRiYT2xpe+XeqlmQf7?=
 =?us-ascii?Q?nW4lsmTmu0WuljemzDsUP7vq5Z10ev9QjOchicuuGlyJeJvMExBis/zIHoa5?=
 =?us-ascii?Q?BEN1+/cV0ojDAIuNNjn00F/ZSY+/8Net8BxaNCPe+b39f9HFsD4U/Y5wyySc?=
 =?us-ascii?Q?fvlmE6C0Gmy3hpmrCvsIMDgvbiEVC1sTAEgssNBhFf5ssif9ZYrjHx8gD3Zu?=
 =?us-ascii?Q?H0q6bgge3G7aPvMrl6X980bru9m9M0m15JYNApzHU4Rgkb1eQGd8LINtn7B9?=
 =?us-ascii?Q?U7zJsLFNUDckUWDGaejIFcR1DwEiorUqtp7cVbmaSqFv3IZHHAduDuBfLWnw?=
 =?us-ascii?Q?I5AT5GBPAVypSoBKDspBXou2amSjYUzy8wLp9gVsA8Egsq/f6xSBt41/r0aX?=
 =?us-ascii?Q?ol6JspJYXNP1c96rE0nCPgdPMbTuoJb5lnmnYjtjhYn6Y2RDBSwocc+rbf+2?=
 =?us-ascii?Q?kVUi7IHl5LMK9ZJUbIfcdnCL7IWLqggqae5rUsIQ22c0u8S5/62lz/4N0Dte?=
 =?us-ascii?Q?7l1k1Eoe1fEyHVSQw4MNCbPsbGyltmDcofwmthOdO221Xf2Rs7wubP+6ACkV?=
 =?us-ascii?Q?9PvnLerR3aVTX7tAuie4a0CSzWqAOwKDqWVZZnaZ/fHokp6kJtrRlIgVYyD/?=
 =?us-ascii?Q?Xzq0mMy7qZuDuoMMYL5nuD4aei6YPH6YEwyXdgTO+qJYlbMFMm0qh2w1Ot7n?=
 =?us-ascii?Q?wd+n0ZEs/2waLdwqhXkLg7aG5nrW2lArQU9OC2jbEYJF79siWWUEYRT6Qa+o?=
 =?us-ascii?Q?o6cXLoIQlYWGeXZd/cRixFCD9EtVss9P6vkcf/NqIyDEjzX4Z8Bx8YSE5ZCP?=
 =?us-ascii?Q?z/FssfpoH29nL07usP+eHe32VsO059Dfay0gtOSUhiEwnKlmC2N2yWgChM7n?=
 =?us-ascii?Q?i9Ajr7ZU0YpEgdKdc1BXbktlBtQDtA+z1zpWjzAQst9pU2N18InlCgLD070K?=
 =?us-ascii?Q?kfDE7fGXXbFgwJLcXs3hnaTPBN59bpCRd9FFKEO1lOYnjQzaizjDCPPEuNMb?=
 =?us-ascii?Q?OPaQjcdut9oU6p//im8uFOPmlXIaSbR1mXQr4WYv4QTINLpLWu8WA+D4jyVs?=
 =?us-ascii?Q?ycOhcb4guAmD5kkg02a/FUG7jvkyKr6Qo0QA04m/jx1aeJUobe5vEP7rGSCl?=
 =?us-ascii?Q?0PSFc1VuqvUUOXoNyn4r/isDVqYe8nKp2WJb2B7S0v3+18GcJv0dPC/BOBoa?=
 =?us-ascii?Q?m/L+J9/+uotiS+lAWvD7xaVh5sgnRmBB4g3+Mv9nM0X2C5qjip1xBmxnqbqi?=
 =?us-ascii?Q?XZ3qHBDnA/E9I8x+8JqswK1/SXvf2A4XNr0mlLAzlOwJvvrNIsMebIpgZjf4?=
 =?us-ascii?Q?Efzn60ltmIu83xY6v8VfuQonC3h6vM2S7pYTFeMfW4otdO0iOuvxz1fnAMGD?=
 =?us-ascii?Q?g8Ldes8HYaYVdtsZrMOTbzUq3BrSNIdWsBfsLl89Zcl4y0SpYRKqhpk0yPsU?=
 =?us-ascii?Q?IjnLRo3kaa/CaIzp4q15AJOptY90GypnlTsSOZu6g6pDaMGp+cXvWi0IMYB9?=
 =?us-ascii?Q?lyz/rU30nxHcuccfiO4UKfPoeeqaZ4GAuToG+IAw1QaElDJWZC4IVXen34iM?=
 =?us-ascii?Q?/84OTcblZWUiGyqRi73ejKxIwcWWtNM9InUaz4vu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4f795f-6edb-4ed8-e0b3-08dd2ecd68cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:12.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FweUgPhNCalKMpRdpLYKr1g5oXzGjHp3pRCY0489Hn5N7EOVpZ90jWueP8F+eDaIWvOU9oyngKKB1utDrqf0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

Several functions internal to FS DAX use the following pattern when
trying to obtain an unlocked entry:

    xas_for_each(&xas, entry, end_idx) {
	if (dax_is_locked(entry))
	    entry = get_unlocked_entry(&xas, 0);

This is problematic because get_unlocked_entry() will get the next
present entry in the range, and the next entry may not be
locked. Therefore any processing of the original locked entry will be
skipped. This can cause dax_layout_busy_page_range() to miss DMA-busy
pages in the range, leading file systems to free blocks whilst DMA
operations are ongoing which can lead to file system corruption.

Instead callers from within a xas_for_each() loop should be waiting
for the current entry to be unlocked without advancing the XArray
state so a new function is introduced to wait.

Also while we are here rename get_unlocked_entry() to
get_next_unlocked_entry() to make it clear that it may advance the
iterator state.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/dax.c | 50 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5133568..d010c10 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -206,7 +206,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry,
  *
  * Must be called with the i_pages lock held.
  */
-static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
+static void *get_next_unlocked_entry(struct xa_state *xas, unsigned int order)
 {
 	void *entry;
 	struct wait_exceptional_entry_queue ewait;
@@ -236,6 +236,37 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
 }
 
 /*
+ * Wait for the given entry to become unlocked. Caller must hold the i_pages
+ * lock and call either put_unlocked_entry() if it did not lock the entry or
+ * dax_unlock_entry() if it did. Returns an unlocked entry if still present.
+ */
+static void *wait_entry_unlocked_exclusive(struct xa_state *xas, void *entry)
+{
+	struct wait_exceptional_entry_queue ewait;
+	wait_queue_head_t *wq;
+
+	init_wait(&ewait.wait);
+	ewait.wait.func = wake_exceptional_entry_func;
+
+	while (unlikely(dax_is_locked(entry))) {
+		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
+		prepare_to_wait_exclusive(wq, &ewait.wait,
+					TASK_UNINTERRUPTIBLE);
+		xas_pause(xas);
+		xas_unlock_irq(xas);
+		schedule();
+		finish_wait(wq, &ewait.wait);
+		xas_lock_irq(xas);
+		entry = xas_load(xas);
+	}
+
+	if (xa_is_internal(entry))
+		return NULL;
+
+	return entry;
+}
+
+/*
  * The only thing keeping the address space around is the i_pages lock
  * (it's cycled in clear_inode() after removing the entries from i_pages)
  * After we call xas_unlock_irq(), we cannot touch xas->xa.
@@ -250,7 +281,7 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
 
 	wq = dax_entry_waitqueue(xas, entry, &ewait.key);
 	/*
-	 * Unlike get_unlocked_entry() there is no guarantee that this
+	 * Unlike get_next_unlocked_entry() there is no guarantee that this
 	 * path ever successfully retrieves an unlocked entry before an
 	 * inode dies. Perform a non-exclusive wait in case this path
 	 * never successfully performs its own wake up.
@@ -580,7 +611,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 retry:
 	pmd_downgrade = false;
 	xas_lock_irq(xas);
-	entry = get_unlocked_entry(xas, order);
+	entry = get_next_unlocked_entry(xas, order);
 
 	if (entry) {
 		if (dax_is_conflict(entry))
@@ -716,8 +747,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	xas_for_each(&xas, entry, end_idx) {
 		if (WARN_ON_ONCE(!xa_is_value(entry)))
 			continue;
-		if (unlikely(dax_is_locked(entry)))
-			entry = get_unlocked_entry(&xas, 0);
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
 		if (entry)
 			page = dax_busy_page(entry);
 		put_unlocked_entry(&xas, entry, WAKE_NEXT);
@@ -750,7 +780,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	void *entry;
 
 	xas_lock_irq(&xas);
-	entry = get_unlocked_entry(&xas, 0);
+	entry = get_next_unlocked_entry(&xas, 0);
 	if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
 		goto out;
 	if (!trunc &&
@@ -776,7 +806,9 @@ static int __dax_clear_dirty_range(struct address_space *mapping,
 
 	xas_lock_irq(&xas);
 	xas_for_each(&xas, entry, end) {
-		entry = get_unlocked_entry(&xas, 0);
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
+		if (!entry)
+			continue;
 		xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
 		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		put_unlocked_entry(&xas, entry, WAKE_NEXT);
@@ -940,7 +972,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	if (unlikely(dax_is_locked(entry))) {
 		void *old_entry = entry;
 
-		entry = get_unlocked_entry(xas, 0);
+		entry = get_next_unlocked_entry(xas, 0);
 
 		/* Entry got punched out / reallocated? */
 		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
@@ -1949,7 +1981,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	vm_fault_t ret;
 
 	xas_lock_irq(&xas);
-	entry = get_unlocked_entry(&xas, order);
+	entry = get_next_unlocked_entry(&xas, order);
 	/* Did we race with someone splitting entry or so? */
 	if (!entry || dax_is_conflict(entry) ||
 	    (order == 0 && !dax_is_pte_entry(entry))) {
-- 
git-series 0.9.1


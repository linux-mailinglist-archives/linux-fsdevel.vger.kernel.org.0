Return-Path: <linux-fsdevel+bounces-62454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E172B93C11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2790C16EEA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F211D5CEA;
	Tue, 23 Sep 2025 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kthWvZ6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437531B6D08
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588826; cv=fail; b=eyqW7tlmwyusnO+DjzNu9hPKyxwPpuMipk9+aJy0By1DF1qmzHBQp0Ohw/VLeZ+zF3BemM9gCT/PNVfd19l/CWxBqYWJ4NTNU9WNRzwW6VZ1x8ivdKatxcEzS8zm4jqDxfu6d7KfHQZqzPrxHM/QA8Jz5A76OJHmsMy2l2qSx6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588826; c=relaxed/simple;
	bh=grEEbsVRyfdNpyqw65bLGoZcvBUtVzIdxy1ni7k7rUA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D3rwQkd6aYGNLkiQfLKNodOAav5pw3juoglT7X3K2RleOSYi5d1k6eIyFDGgtwcO2Qe9JvS31z3NLq5QZz7dOe8X+HC8WRyPJfC6pRZv3thvknzTWFzHwoAebAcopishw4qhEDradfkbzV4Kw3himFxSioIVww0play+XcnVsvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kthWvZ6g; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJw5q/ZxmAkhbJ9HnhI5qyVWPfhC4bVzY1Sk/5BOR5iCvwSe5x30CXcG5NugZ+BgIitzwJs/s4IlSBQx9wNpg/gB9ZbRCWLUd1cECY67CrdnlpGN0Xh6q60DfcBp2momjzoxY+SCyDrlSVCHA85KCU6yHyM0LN8i4J+kMmcdzzfHE5L4hrHBoOMCCLqTQeHXNLH4s4aHKrxBzpwivGfqzlr+TiZB3pcmJo9+iGkaircy1FsKEhmsKZCXe7Fc6CfYPUy6jqwgkq9gF29Pg3jThiDks6f7wJrcUiON5zE3DU/1hsE+yB6m651lDA7wuxqtXStMw8V/BHnYG/xbquH+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnztExj7uCVzcewoN5toY9AioZIOheh+gcmvK/WnPm8=;
 b=AXiQ56Zhc6r8BuQa6pwSo+6vRuqr0I+dI7svM8KkFhsvpRFoYw7ox4QrNr/aM/6eM0tYVqNgNfJctuQG0lfcxt6i6TtGR6iu/IGjXyjTq+F5xdGalOKocHyJPKxwN/hxJIgYIi7PH5hrldjmpCr499ppUzlHP2P8sMjRf58QgEg4+uJsOtBLwV1XetNWtzIlv4yCZUFrzx03fTCo9g8fqxf5Z98DImQlZvjvoBWOXSTG4KOV3C1OTHDg+5QimTTK3d5K0VXZyJU38leKAfnXLoVL1xtSjLz+7k9eH/b/JJSwIVsDy+VvJkAQf2IeFQJG9jSJz4rLAJwYrTypZpdW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnztExj7uCVzcewoN5toY9AioZIOheh+gcmvK/WnPm8=;
 b=kthWvZ6gxDuMqRd22Yvn+bc/Tf+hmqTJAUaMinTt3Oqgx/1ya+ClLzdr+PNIxMvYdPHNdu7JB+a9MkWW09h0UA5EumZd+sf4s7EUgrkpUtqbMo2M7/zcv09ismo3YOyI1AVxCe3AwYgA03AWYPjGbhIw1XFC+KI4sxVWMP7MJFadpLHeax6mlh73aVL/xc1X42bMjUtGh9FDblWVWd0EqAUIw8WM5WabNq9X2AXOy5UUXAN4gfGpOqNXJUiGu2Wo1p/kqVATNikHpejotOdZtCFzpMmfvvLDfGcHBzRImaXBrKaFF/+9n/rmCeYDncnL9mssixFeEmVUDQoCVpwuow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 00:53:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 00:53:40 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Haiyue Wang <haiyuewa@163.com>,
	David Hildenbrand <david@redhat.com>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] cramfs: Fix incorrect physical page address calculation
Date: Tue, 23 Sep 2025 10:53:33 +1000
Message-ID: <20250923005333.3165032-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0062.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::25) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c6e1dd-4136-48bb-c621-08ddfa3ba2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZwUUZlkc3ODO9EIXP20KmbFlmyfvul2pRqgVh115yPaSWuIhmkcD2jBNzcu?=
 =?us-ascii?Q?lNEhwM+068/HAp0xyhgdzgjmw+ckgNzBfx4FKv7hIVLiusLmkrL+j3MgPtfB?=
 =?us-ascii?Q?UB8Gwwcxa+86iPqEhjIaYDYARCECf1ldQ6yE4pEz4rfdHMJ/UoqemVe4HG0L?=
 =?us-ascii?Q?2GrqUShusg6GC99Yjw2P5QVl3LV8kQ/OKBiRb0/J2y5fLNvSAkFluwc2C932?=
 =?us-ascii?Q?ty8+xf5QWWi74ZdyKmSaLYewsu1qi4vcRQGHWoIq5SAaW56YdGWcmf54pnyX?=
 =?us-ascii?Q?PPNm9pzHLkEEgYWHFO41Z0Yr8vh+QLKvifDGyKLpfTLJpNisk/TCuevTBeqq?=
 =?us-ascii?Q?FOz3SRzVFkir5LMIc6y37oW5QDGvTnZFvp7UQB3C4wezq4/CUc05IsNcGjCn?=
 =?us-ascii?Q?018rSStLHXXUssTkWse87n8eUG12PDAkID4nHC5yFSIZfnWg8pdQsYbblFt0?=
 =?us-ascii?Q?oTNqNpnR+zbmwp4LRCh6/fP0VbutJWdvnoX5AW+HkNAnMukWE8NyoU80Yfzm?=
 =?us-ascii?Q?A4fSWqaVR5U0HN27jjUwDPQWm9IM56tx54ZrF8LK+2uAi/BlKAmeB1GGSwpS?=
 =?us-ascii?Q?gwKRKbbDyacPQOyuUcx9JEsqXPeKoNJPb7ydIC9gqjK0pDMOcChWzZ25RRGu?=
 =?us-ascii?Q?TbE94RyGspgIfZXfkddxlGmxqDWF6gluE1563jhWMXx0IOu7VWtGHIXg0SEj?=
 =?us-ascii?Q?RM8xWwqEsFCJnYGXcgWzHHLYurhilFa2g0UHgOmeL1YvnHrUYg0511RclhLu?=
 =?us-ascii?Q?IyW2Uzqesy8T0ptW98ATxjdbtuX5OxoH6Wt6s8bQ2rJpXu4XjnC4QG2ew/r2?=
 =?us-ascii?Q?lTkmM5KC+9+8/9G3Xp7XJq1ofkD348KX9YAQIDccl/Rwh8YEDRS/zEJ1OR+o?=
 =?us-ascii?Q?GYnmA4xucBDCd0ZIbukSpljSbqw210CdmRgDBW/y8hnsvSPn26FwVQgMfonl?=
 =?us-ascii?Q?G0tGwP3U+9xnoz0mTEKG6WI+6pfWDluXpNz+TRjjuR1LJQg/monn5OTjTFs/?=
 =?us-ascii?Q?AR46ecplm9UY20xh+RYctvvnWu9A+yTg81w0+BRKN8PD6Lwl6AEfndn6aF5G?=
 =?us-ascii?Q?a/jtU6HJSNh9tdx5wnjzeejwHfY17d20e8Qz1fyV4qFbMYuXSAfgtpD0ozZn?=
 =?us-ascii?Q?pa7S5nGud+OBntnsckPHjxVBAqZWv6Mm5pePw/M4BdXtTfQVpnEYoYmhRshV?=
 =?us-ascii?Q?Cn1T1XkUPxVFfvnWYrgFQOrZDKK7Hl3XUNl1wQAn4ix5fI4WizwA7nP2mv8b?=
 =?us-ascii?Q?u/aVxuhspQyBss76hMObtUvV94c9Qw01AKCBj6EsL+myndvavmpnHTFTUDY1?=
 =?us-ascii?Q?9cW8MX5+XDyE87JdmVAAScK1YTAaSDgL3HljermFbpLjWmuYseRT/KYEkanX?=
 =?us-ascii?Q?/btWA3y0zkMxqjrHk2QMlVGr9tl1EiTluT0jF8EBR7PIki8pjytsbjsWECMx?=
 =?us-ascii?Q?x6glMgSn1ao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Or25mewMvtyJLRD6RHyRSfUeChnNVdxKHBlMQv44hICETSpogTN5t/YBojjw?=
 =?us-ascii?Q?yCVVcIfussDpwMDLCPqSnc1ubD2/8vz1fATp9LwMnyHiip5KGhCAee8qjcBS?=
 =?us-ascii?Q?qt12xYx2+CYeOJYaJd9F9S7NIHS2Lj4P7YvRANJJmq+qNKA4Oo+3RnzzSRFv?=
 =?us-ascii?Q?tQFutqQM8nveeqe3sH7ZR9RhWdn76aZqcIJ4FQ5db8qEPjxfWHJg+VacWVDh?=
 =?us-ascii?Q?rClxnMf5JhU+V86eWSznwfQIht46X3Uh/F2TrE7xEMx93ReyIZPEDcmHEUHn?=
 =?us-ascii?Q?gHUMRlhBA6HEqo5soow8nfG9ARCuTitjjgvKSGgEidXV2HcmhgDjRnTjDu+X?=
 =?us-ascii?Q?DCdgqdFP1rsJuQfmNNht7pAuDXqG2AifQaGeNaVqR+Z7VHcpncgWWHDuiLs/?=
 =?us-ascii?Q?4vCYEPn0U67DcoRyyUaJw1WMsLxPMz6DxaJ6AWmNiegPZD9XvYEVQeznVhbw?=
 =?us-ascii?Q?lyfq3uPunjTjziqO2oWioS8vrkqHsawhceD6eTR1fcBBQFgRRFW7B9seWOXG?=
 =?us-ascii?Q?54RA8q/BCgnKLutL+f+Mu79P4Ous8q06pg77c3oyXLPkLOc87ZKm/5lcnGDr?=
 =?us-ascii?Q?UHwL2D59SiNTpEA0X3lvHPbG5H7xcZWbHE7TBSS9Rntif+ftEjs6v2lTRnSm?=
 =?us-ascii?Q?DToqgJsmlCg9mmt1qu8f37/qdphbWKMC1x3Y+lE3rmMD3WXt/ZFOzBt9jyZa?=
 =?us-ascii?Q?4ZbhKvRZNF8zeAusi/qGYeg1aUTZWej8+wPMF3tHb4etMVfscLR7ylzm7Fhv?=
 =?us-ascii?Q?FcB2H7PJyRVoqU7KhLK7d3+Ph4taX3IyeM1wZ8fsYqcGJ4i/W9QWJCtWkjDQ?=
 =?us-ascii?Q?+cG/haN5VaCo5nJoAZrOa5KeAxO5ZI+mBIiYTZcWK66xXm0HlnlPN/Y+cMmn?=
 =?us-ascii?Q?NTIrHaF8udMdALcXLo6FxOnJdvAvnsKnn/Iwz4/LGz5zjD9qY7Buu01QTN+R?=
 =?us-ascii?Q?fvbnyTcaQ1rwxH4dU7SDMuk6/qvDehwG77gBAORT5Q0+tgiQy1E4rljdYcJt?=
 =?us-ascii?Q?XHgOJXd7CFMx/TD86DQ+l0UCBHOZbjKd8bll94FyEaOjWI7Qo4UC2o/MiAHq?=
 =?us-ascii?Q?AZ5MGhEr26gLIcy4c40FcgBWhw7G3L7iru5r5yFaRFb9PavDz5/4nz69s8if?=
 =?us-ascii?Q?8IY/4iX1LF8z9MmQbwfehuXtZJMlWnha9ovNoH1DpUUS9M6hY/YNrNlN9/jN?=
 =?us-ascii?Q?sDSBFpFsFLEPqZAzALksXBMfcUn7QvPZryV7Xzg9DJwdWrfkQa13WY4+xfD4?=
 =?us-ascii?Q?si6oKJJAkv9w3EZGbQTl9moyFF6QCFr8v6CekThSsNylisl6yZbsaE3bmm/4?=
 =?us-ascii?Q?6TRV200mKNGV/Q9/Bqi6QlWOOTNiTlcAoDzHYtVqv7QddcvBEGSLoNE9UKay?=
 =?us-ascii?Q?I6a/DepqlVDc3CgwCJgnrDv7a4cQpjccrRo0uambYDEE4MdKLt4CSckDsqsD?=
 =?us-ascii?Q?S87s7+8FV7OGma5Fd4ifC1/WJmT3At/fYg164nXF6PjNna9KlsM3p0A0RPN0?=
 =?us-ascii?Q?TzYqiXvulYGJwBma4OSjclOSSM6sP9mWUsxA0B77cGgPG+SdjbCqfqs+dMeT?=
 =?us-ascii?Q?ct9G1aIeNBSIX3bkRpqrufDBELlbuZI4Qdm2Fyh5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c6e1dd-4136-48bb-c621-08ddfa3ba2c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 00:53:39.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfO/MGXaTAac9+TP8P8ktMkHAR/U6UHC/qFdbUuWG7T5jmt4v/Dnnn0SIUbwMCsrTHardICqsGTAxvcApHkvzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283

Commit 21aa65bf82a7 ("mm: remove callers of pfn_t functionality")
incorrectly replaced the pfn with the physical address when calling
vmf_insert_mixed(). Instead the phys_to_pfn_t() call should have been
replaced with PHYS_PFN().

Found by inspection after a similar issue was noted in fuse virtio_fs.

Fixes: 21aa65bf82a7 ("mm: remove callers of pfn_t functionality")
Signed-off-by: Alistair Popple <apopple@nvidia.com>

Cc: Haiyue Wang <haiyuewa@163.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 fs/cramfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b002e9b734f9..56c8005b24a3 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -412,7 +412,7 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
 			vmf = vmf_insert_mixed(vma, vma->vm_start + off,
-					address + off);
+					PHYS_PFN(address + off));
 			if (vmf & VM_FAULT_ERROR)
 				ret = vm_fault_to_errno(vmf, 0);
 		}
-- 
2.50.1



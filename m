Return-Path: <linux-fsdevel+bounces-41915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C67A391A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B32C172467
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 03:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C11AA79C;
	Tue, 18 Feb 2025 03:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eYIJFJ1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8091B423D;
	Tue, 18 Feb 2025 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850980; cv=fail; b=MMYJ+P8QOcOjHlywFtGvA6h0zsAb47RIh0a+Aj6CGR77IJdEeqG7ktw/swziBhJSVQYV7y6iiVUdtatSQMF2DEZo1Nv2dVKT8pYhV+GlUMuTc+3R1gjCjvwHxcjm95wd/bRmEXZwPqa+ggOQkWNO1ttzDurR1kaIbjAEEbgeQbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850980; c=relaxed/simple;
	bh=PLnB2Jfrxt5Lh68I+ZZ00/WtZe6QYvPx4nB6vNbyasY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X0kQ7FKnnTd33kZeXFEZ63IqFMwEcQDBhmizTF40jcIHyFx0gQ2EVzwsOnePYOPCLkHddc2TqYQ6JyiWsezaQoLInNZmzydThVG1wCcweYvtiD+XqzP8ko56xrk6GnbHdVxiV4HIR6BNrKJiL4D04dRzQrI2nYc116Iq8ZcxKFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eYIJFJ1h; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYlc66077ZbrVPkMMi3RNnA93zTmsY2dAYkHyJVM3RKbcnkvY1mO3rq4jdODow3ZJotk6WxAfm1sVzSdMdyo+2ipk5lAJ4jAD56ORHoY7VTX0+756/7yiwHrHXvfz05fKGi0GgcOFS5d7uxEyZM78w1TyogsoQaM7zK08GuSTWx7v6DBrr3IiJYV9IDM7TW0ffMUo5bXTb9yAwjme0ukbIYrIejW+jiSeT7tk9AqivMTVCa1AFOWreweOugvA58ntjY5DpHYOuHHjjTltJEz88/9FS+jFPLHc/WOchLbul1KW8lDmCrbjuBPUkbcZyvAAfwAk05h0WapOonBF9MnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZjp39mH9a7emt54vkN8geCoCp5VBgqHEdOopdg44hE=;
 b=C6QhKDsj83Vs4Ao8NUP0E1DgU5t0i3Ozc3mBLqpWwpOyZkmelpj+wvSogtECgOywS5ufyyYhaoU2xMAD9NYbfA7bxgsSc84quMZv9z3N0PUyvn0OXjRkOl1Sip62bFoqej08bXeKf+UF6rDUkzrmMMTdnaSi1dRNv8HjVvz/tszTx7dHdCCkMABzu2E1wBARDT8huOzMDinqkQ6pPGXX8OO25wZKr4EHWnRDgrFWDkIzMgxD9VWeYLEeWM7EUoMAzrSgb4iBGRFmjyYGLrA+UfRNHLjX4FvEFu0GJiDrRHDzcRtcpYSFa1ZB2k7v9V8hIuW6wPwFFzDjqY+IRcbn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZjp39mH9a7emt54vkN8geCoCp5VBgqHEdOopdg44hE=;
 b=eYIJFJ1how2xJ0VW0gOioOKbcCk036QmzNPqET1D3GDmWNwG/JV3Cxr4iLUA/6XeuUzqvbpT13Qwgs26zzttN01N+RoV2x1lEHG4YC4fOknpkbxihggrcppYa9tVW7EOem1fbmwer2ET7ADdJZiZ6jqvQiqL2J84z1Blq58YfAoieYqgAm12dpj9ByQehGNjIgTpDjMGjuUhzYekjba2a1LEm0Cg2v1E+p73rTaB8itUKm4rIyzjmhDNEo3P7TkjlVUsSDCS0pQ7nwAkqXRG4XgxCFVXBiXbyFuQQqUSEGgOR3XAsImEyslUTzHMKV4+x4UxygNP1XTvSQEdfX9c7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 18 Feb
 2025 03:56:15 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:56:15 +0000
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
Subject: [PATCH v8 05/20] fs/dax: Create a common implementation to break DAX layouts
Date: Tue, 18 Feb 2025 14:55:21 +1100
Message-ID: <c4d381e41fc618296cee2820403c166d80599d5c.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0007.ausprd01.prod.outlook.com (2603:10c6:1::19)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7ca221-d8e4-405b-db99-08dd4fd03133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hAfXUU/Jvihq+a5Q8BkjXMG6UhISBerfU/A0tO5WHIPOAlUFi9ci9g/u5nLY?=
 =?us-ascii?Q?O0x5buBvpo/aMPR9nUnUBoDnqtdiFwXZVICFtg9HxqTj+SPPaNIANHQshwY3?=
 =?us-ascii?Q?yGyJTz8wRMSPhbbHgvGh6R9wCWG0PsBKDZmwvnnLWtPtqGWSePYyZDvHX7xT?=
 =?us-ascii?Q?p4dEWBIUqm6SLxmwrRHTHpEN8V4CHWlxtq44r8FqLo9VenD2J8B1og/zT2qE?=
 =?us-ascii?Q?IqYojUhtkSxYhGgsZUkglozbjxB5dbJbdGhAyAoPc3TdD2lDRK5awhKPh9LT?=
 =?us-ascii?Q?33r9uPP3FLSOvMMVNoiwZqPL6eoDI4lw0Qxy/+vkOwkGAw0rgR8OOva3oorx?=
 =?us-ascii?Q?jOSrR1HjOxYlce2xzassKDJJCJbukyV+CAVdfGRAhuOYUpml8ASWmgC7XEZk?=
 =?us-ascii?Q?WB1V/GTLGB2C38ucW3tJP6FC2vcWy2mjQMEnLaTlvguZ7B8jucZ6D3BMVEYP?=
 =?us-ascii?Q?DRw2H+NdVpnH6OLKyMrERCAi81ut/U1e2+tvL+RmtQ8jhKszXQd4VjXf1pjv?=
 =?us-ascii?Q?ymVMVRaRTC4P0QH3uuse9alYjfu/W3oQ2mL7bhJ7bxDdRGgX78y+4eThZiBL?=
 =?us-ascii?Q?2aDyoNZz3tjy8k8kmAqZa0+Ip/CXxfBD7QgzhVW2EL/uwiDHnOSRq+9Y772m?=
 =?us-ascii?Q?PtEgOu7b+xxfVwDAL7Ofwv9vf+VDFQ9Xd+RV1UfN8C2B1KFiByvBxwWVIe54?=
 =?us-ascii?Q?dKKF0BxK3yD22KGUHyIZAFFbumpbAqUkXzPFjpLB8TwHRFYshMkzOLYStfDK?=
 =?us-ascii?Q?UQi+j2RX9SdXzwu7c7OeAodMoHHteXVY674QewogeCk3J+gT4tdl200MEyHK?=
 =?us-ascii?Q?GNbLSFnNLx1OLcz8097DBSu9B3ZAzRPjMpxBNmHEsPpRv+npWZc2advEDhbO?=
 =?us-ascii?Q?MQ40WNO/wfltcwzBwMhvlF4xJGf50ITBvlFWpWiL1pSrKzbYt8SkhC9BFDdM?=
 =?us-ascii?Q?bVfsGwTljTKZlATC5e80zzpOy7lTdTysyrvomn9l9lM1/8qkzWDRzxp5eC1r?=
 =?us-ascii?Q?7Ze3O0o7UgqnyTN+nfpjWhSeIjN2heAuutqxJbcmp5vrwY5ZNUYq71ShqWtq?=
 =?us-ascii?Q?fChur1KZ8pK7QYc7HhhenvpbKcOqMIsVXu97SzAd41d1jWtkOKG8bwvT/Bxp?=
 =?us-ascii?Q?gRveR2W6yoCPcM7MTshFxrneFp/T9DkbHWifXuex2Goa8MwdrDpIOUmJAang?=
 =?us-ascii?Q?yhr4xon1GbXI1pYU9ya3M/HeQC3Z6ptP78qaizyJK0ZtEQMvavhUTzJTJ9we?=
 =?us-ascii?Q?d33L7TFpmBEATAxonz4MEoDC8PQ5Ea6N/3zMV7SdIJU+DUoPQHt7QKL30cWL?=
 =?us-ascii?Q?SzmgbTU3BqzyMnBKCHow4ws8gjVVuxzmZLYRNXN4b/2O9OA0Pb5Zrzulw/Z/?=
 =?us-ascii?Q?dihUv1X0VFBAR8UN3xh43CC5CNOF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6t1gOGlecVYNPW24vaO4YDgRkVuL8pBb+7+9AYl2T8eWDb4OBB05E+357YM?=
 =?us-ascii?Q?EO0Ne9Q+MJJBwEq8SichwuIyZmlVWUGnrw/nk1zLqJKk+sFsjex9n+NY5Dez?=
 =?us-ascii?Q?UqNrRfE4kSZI1vMZaxgUPk1RW0j5dCJplx5m+Kr32Y5Gooh4vehEgTlQ7TMB?=
 =?us-ascii?Q?qQsTdKmc1I+JMg2DjM3ObwvePsKJGI+9/fJDN3jEkTBjdqZ5s7n8x2rCv4xD?=
 =?us-ascii?Q?b7QkMLeCaUljXqZMMM2pYXVwAhQtBRB90FHTvVXCY+019VxSW9dEvdHS6esE?=
 =?us-ascii?Q?/x5cJHTq/YDo5tvQZMSxCxajQKVeP4xSpR5EDbaS+fFle5oS5aBRmz//MuX7?=
 =?us-ascii?Q?HqGd5TVXB9C9Clu524fXSIZCImEKXDvTdbcUuVpPJtdkbzF15guebrrBRyCa?=
 =?us-ascii?Q?08AC0J8kViBUCQoPtw8BGVJS6X/0kFB/30NJqUdm+/f+7chwlWoRSLPSY1XE?=
 =?us-ascii?Q?N9pXVvPY/TPSvpNgDfCRqZw/6qFgHb+mU2WtWvN30OsI8XWvmxx5YtLy0tRt?=
 =?us-ascii?Q?9NX1EtyamxtQArzTBAu7O7PhRIfWlKZQozqRWrnalHozYsuF58dUfDYxkwSG?=
 =?us-ascii?Q?pgZLIEazlrIeg6syXhxsLiqJaa7I8FZdE0ElnzBkZs4rOklP42rtPI6hAEUr?=
 =?us-ascii?Q?/4MVpPVaPPOfdkhpliHuzSQ0SNUHcMdgS1QJ67f2xWO+NbDZTu/V8H/4bWvw?=
 =?us-ascii?Q?kke3fa+YtQOK1LMKY6uNeTPhLybLQ+//o4ZPOGJnmBfcOX9C52REZabV5a/Q?=
 =?us-ascii?Q?CFnBfLTUFKTGfIPPWFJN21U1HY8Ab2QNhIsMOu5CknqPySxO9/r7+Vxgh6Bi?=
 =?us-ascii?Q?xC9NhapALpN3loivJ9qD/bcAXyjut+B8ESmMb6TJD5Czf1AirikvR13DqkEl?=
 =?us-ascii?Q?6SebFEWHtnI1tmSDxEj2C8giwYa6sGMvi1hzgWDpmYfI2OFupJUYXk4hZVA2?=
 =?us-ascii?Q?urOq1gpYa5fxGzmQsRjtHVi35DJmZnGe2ueBzMIaQv3FbX8OqFvLiXmXGzpQ?=
 =?us-ascii?Q?hADu0R5ZmUF0tdhRYlfZ0SQpbc9chyOdwdr+hlz025JZbX+g07ZHyY1qSKmh?=
 =?us-ascii?Q?EZ7DPn9IyT5ox7W4rYUuHhX4NCrcltXE9I7cfvSvWUU3HKi5f464Fx4MEy64?=
 =?us-ascii?Q?lJ3raFovfYibhk9Ij7C/Fl4T99NQOx+PwcVkQrvGibv0Ls3mdtBQ0nR+kGg4?=
 =?us-ascii?Q?m0MBD0VDAbQQK5wyjm02yZuCfRWKN1gKIxq9dDxmxHwp/+ZGp3EGmgZkN0Jg?=
 =?us-ascii?Q?evBy65qs/wf5QyVjGxijQ0m9QBHMW/t6zSgoZ6gv/7vcGMANOKENXmiP5z8i?=
 =?us-ascii?Q?hQ1RD1Q6NvRoTsC5IyPEA8m5sunpuna6gX2RHEwvin0j2ISQnxQ8Je8c4qDO?=
 =?us-ascii?Q?5+tLXvEe+Pdf9YreqXmoXuvc7FhUokIYLaZUkPO4j3So3nsPz00gdRx58Qg6?=
 =?us-ascii?Q?PfFzLiXHtUoNVKSdVoK5uKwQJbhP8Mth2tn3J35KrzWZRBOSurd3BBIXF/Wk?=
 =?us-ascii?Q?QsG/s83LGXS8W51TJLbMhf9EjaDYvQJ5m3mpRy7WrSCpUJ9AhKN43elevSaX?=
 =?us-ascii?Q?j9ySd4i8SFOpSt4ZHyoPGicP//m2dibop2MBND1g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7ca221-d8e4-405b-db99-08dd4fd03133
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:56:15.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAZDcC1+oq9eE/IvDFEHScZjqC9jWx6YP3ZPDDiNn4om0S6Dsdq8rrlRshse/UB/skFzVMX//YvCSnoZ4Vp8+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

Prior to freeing a block file systems supporting FS DAX must check
that the associated pages are both unmapped from user-space and not
undergoing DMA or other access from eg. get_user_pages(). This is
achieved by unmapping the file range and scanning the FS DAX
page-cache to see if any pages within the mapping have an elevated
refcount.

This is done using two functions - dax_layout_busy_page_range() which
returns a page to wait for the refcount to become idle on. Rather than
open-code this introduce a common implementation to both unmap and
wait for the page to become idle.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v7:

 - Fix smatch warning, also reported by Dan and Darrick
 - Make sure xfs_break_layouts() can return -ERESTARTSYS, reported by
   Darrick
 - Use common definition of dax_page_is_idle()
 - Removed misplaced hunk changing madvise
 - Renamed dax_break_mapping() to dax_break_layout() suggested by Dan
 - Fix now unused variables in ext4

Changes for v5:

 - Don't wait for idle pages on non-DAX mappings

Changes for v4:

 - Fixed some build breakage due to missing symbol exports reported by
   John Hubbard (thanks!).
---
 fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/inode.c     | 13 +------------
 fs/fuse/dax.c       | 27 +++------------------------
 fs/xfs/xfs_inode.c  | 26 +++++++-------------------
 fs/xfs/xfs_inode.h  |  2 +-
 include/linux/dax.h | 23 ++++++++++++++++++-----
 6 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f5fdb43..f1945aa 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -846,6 +846,39 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+static int wait_page_idle(struct page *page,
+			void (cb)(struct inode *),
+			struct inode *inode)
+{
+	return ___wait_var_event(page, dax_page_is_idle(page),
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
+/*
+ * Unmaps the inode and waits for any DMA to complete prior to deleting the
+ * DAX mapping entries for the range.
+ */
+int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
+		void (cb)(struct inode *))
+{
+	struct page *page;
+	int error = 0;
+
+	if (!dax_mapping(inode->i_mapping))
+		return 0;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
+		if (!page)
+			break;
+
+		error = wait_page_idle(page, cb, inode);
+	} while (error == 0);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(dax_break_layout);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cc1acb1..2342bac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3911,21 +3911,10 @@ static void ext4_wait_dax_page(struct inode *inode)
 
 int ext4_break_layouts(struct inode *inode)
 {
-	struct page *page;
-	int error;
-
 	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
 		return -EINVAL;
 
-	do {
-		page = dax_layout_busy_page(inode->i_mapping);
-		if (!page)
-			return 0;
-
-		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
-	} while (error == 0);
-
-	return error;
+	return dax_break_layout_inode(inode, ext4_wait_dax_page);
 }
 
 /*
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index bf6faa3..0502bf3 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -666,33 +666,12 @@ static void fuse_wait_dax_page(struct inode *inode)
 	filemap_invalidate_lock(inode->i_mapping);
 }
 
-/* Should be called with mapping->invalidate_lock held exclusively */
-static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
-				    loff_t start, loff_t end)
-{
-	struct page *page;
-
-	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
-}
-
+/* Should be called with mapping->invalidate_lock held exclusively. */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
-	bool	retry;
-	int	ret;
-
-	do {
-		retry = false;
-		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
-					       dmap_end);
-	} while (ret == 0 && retry);
-
-	return ret;
+	return dax_break_layout(inode, dmap_start, dmap_end,
+				fuse_wait_dax_page);
 }
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 1b5613d..d4f07e0 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2735,21 +2735,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	struct xfs_inode	*ip2)
 {
 	int			error;
-	bool			retry;
 	struct page		*page;
 
 	if (ip1->i_ino > ip2->i_ino)
 		swap(ip1, ip2);
 
 again:
-	retry = false;
 	/* Lock the first inode */
 	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
-	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
-	if (error || retry) {
+	error = xfs_break_dax_layouts(VFS_I(ip1));
+	if (error) {
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
-		if (error == 0 && retry)
-			goto again;
 		return error;
 	}
 
@@ -2764,7 +2760,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * for this nested lock case.
 	 */
 	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (page && page_ref_count(page) != 1) {
+	if (!dax_page_is_idle(page)) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
@@ -3008,19 +3004,11 @@ xfs_wait_dax_page(
 
 int
 xfs_break_dax_layouts(
-	struct inode		*inode,
-	bool			*retry)
+	struct inode		*inode)
 {
-	struct page		*page;
-
 	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
 
-	page = dax_layout_busy_page(inode->i_mapping);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
+	return dax_break_layout_inode(inode, xfs_wait_dax_page);
 }
 
 int
@@ -3038,8 +3026,8 @@ xfs_break_layouts(
 		retry = false;
 		switch (reason) {
 		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry);
-			if (error || retry)
+			error = xfs_break_dax_layouts(inode);
+			if (error)
 				break;
 			fallthrough;
 		case BREAK_WRITE:
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c08093a..123dfa9 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -603,7 +603,7 @@ xfs_itruncate_extents(
 	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
 }
 
-int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
+int	xfs_break_dax_layouts(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9b1ce98..a6b277f 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -207,12 +207,9 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
-static inline int dax_wait_page_idle(struct page *page,
-				void (cb)(struct inode *),
-				struct inode *inode)
+static inline bool dax_page_is_idle(struct page *page)
 {
-	return ___wait_var_event(page, page_ref_count(page) == 1,
-				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+	return page && page_ref_count(page) == 1;
 }
 
 #if IS_ENABLED(CONFIG_DAX)
@@ -228,6 +225,15 @@ static inline void dax_read_unlock(int id)
 {
 }
 #endif /* CONFIG_DAX */
+
+#if !IS_ENABLED(CONFIG_FS_DAX)
+static inline int __must_check dax_break_layout(struct inode *inode,
+			    loff_t start, loff_t end, void (cb)(struct inode *))
+{
+	return 0;
+}
+#endif
+
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
@@ -251,6 +257,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+int __must_check dax_break_layout(struct inode *inode, loff_t start,
+				loff_t end, void (cb)(struct inode *));
+static inline int __must_check dax_break_layout_inode(struct inode *inode,
+						void (cb)(struct inode *))
+{
+	return dax_break_layout(inode, 0, LLONG_MAX, cb);
+}
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1


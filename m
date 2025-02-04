Return-Path: <linux-fsdevel+bounces-40839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B6A27EBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2501886A71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05604224898;
	Tue,  4 Feb 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QhEG3U5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94922371C;
	Tue,  4 Feb 2025 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709367; cv=fail; b=m48UzXbXj8VGbIlOdsBaFoGFtbrsPxQv2gvIdy1LpCw3+GZfsbHg9E9brFLrV5iegODQ1jQuE6FNRN+kbclmjhc+YvE1wwLgEavmdvXZaDURPQZDE6f3xOo8+uMU1jVLU6QaA+REQdSdZsdQDzcNzje++eCegytKneoIOfK06Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709367; c=relaxed/simple;
	bh=VdzThaV5wlWG2lX4ejynz3X63AAYF5Xklvm9x8lPNiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l9DGlv1/QSfQRhrBUT+yA0c6guTVBobAYvpIUeXhRmJWIwk4nFM+xPFaeXgCD4tCgjTzmfun9nr38D8zh3obv5uR3fYsebQ+d/3YIWc7tYvMNVwp5sK8TGXWT+cufOepZJhqq9nPZf09ee0/GTxij9AbISHTSl6jdryjCycgNwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QhEG3U5D; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIb8upzgBc53rCsK6rOIxhSdc9WRKwYsIZCGmvXmU3Kxee/c04DCRTiHlqSTHczZn0WVBzw2tRwy+n7cVm+etMzMXCE2sWcxKIdtE2Nj15e78Bk4BLek1f7/f/KGLCWuPmhQJ4mh2c8rU3SbvM1hJBK5kh7oSdIgGIbMivd9n+5mdfRNZBJ84URZsvENql5Lf8CzHw+8aNYoiUEDkdqCkPtJXVFliXax72Y3aLGD8SKMgvnYXYvEu8hPoI+oKtWrDUZYF+1z7K7O1ZBLhgWo1RR89Ea/ZEZITekHd4jbIEjWEe0rcvcTSlU9O4pXdFwS7GsSfhBI5qTPbT+v02wDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN3974zWoQ1cF95sfJnVzGIZi2NU/qvevfsejO7+b0o=;
 b=ozn+K+fGDXU2cPqet86OvHsSZhvRXELYQTK/qU05/KD53zesOV9F2h9zgIN+5RfTEUY09H88GAmi+0Uog7LSC7i91LpsBF9gk4ye9rHgygc+Y2QD9LGpmRUZfStQzFehEugdd65Ey/+KyeROoims88xh8afRf0T8XonzR3o4apKtbh0KNgIvpFWvhP7njHTLcphcJPbEQ3OnTe/nTqGiIvvMmZURGBdQYvEu+T+/0zGExsK7E8YnsU2hQdI/jicr/lSUVzZptERIEMMHIgVByy8e29wL+9AqVA+1iREcxF4VshZcSmi6oP/8xydcVBmRIQ5y9kzmlDSddAMLzr+8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN3974zWoQ1cF95sfJnVzGIZi2NU/qvevfsejO7+b0o=;
 b=QhEG3U5DyGzr4W/XrcF6HP5MKa6mLEvli4hqcPJA1oG43sbALeZlNAXJKAOMr7DH9kFIdjLMtsLK00vNoyfcc2UoWQDpLFLr8Rz062GxHim8mcno+enEFz1957UZhdOSIa0LnjNND7SGfy4w4GqVqnh8eN1j61iq/cmfJIOSqD1HBnrDKdenje846IBS5XFwAQdktB+0gfQ7ejbVWL3PsUrcAv9WCtD92u7J3XkX7LzcNlBFH0aTSmL+m3MND/XG6UhfIizbi7D6J85d4E5GQxFSNnyQF5Rl5WbOJyb8bPgbfXpcdK3ljJjB0kjHh+kCHVFE4J5+Z4YtcRc15gZNxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:49:19 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:19 +0000
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
	loongarch@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 09/20] mm/gup: Remove redundant check for PCI P2PDMA page
Date: Wed,  5 Feb 2025 09:48:06 +1100
Message-ID: <94d782acbb52a35f15fd6738992bdcc3ff11872c.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d44e31-5da8-493d-d5b9-08dd456e28dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJVl8mKc58bGkweJ2PoqYUVLMEgWkbTa4h/ScGB6s66597ZnAZAw1ObNbuso?=
 =?us-ascii?Q?hPaoyqUUDx/blXJBygpGXtQlFuHSAowyPohcQ4IqNHQYVo03xfnXqB6/vwG0?=
 =?us-ascii?Q?Bw/AhlU3+1aN/qJqrzCGICyFz8IyBiUc3YbzoRPRVjmhN2uN2so993g97mYG?=
 =?us-ascii?Q?Jtoyh4QGxH2bV3fpH2ds7uUEX6YnLPW/sPZXt/VFS9f2s6E3t22tqeuzF7FN?=
 =?us-ascii?Q?dSwFSswGH9SK9X28ZceQfJHh+Mm5g09D0m92ASzEmyBG41pS8t2erh0Xcj0r?=
 =?us-ascii?Q?DfgS11c7Jw+H6i6eBy7HFjw3ihNFAreMR9+ARMH+llUZ7X2qUW9jQwxFKkpx?=
 =?us-ascii?Q?JeMTNFNGRb0qhbp3fTUP2LoKwU5D7CMR0Dd/ywx/fwg7AUyiojr17Nml/BZu?=
 =?us-ascii?Q?ok9fatH62itwsinEnqcfSYa+gRh+A+i5YY07BDHaLAo//hDp1ONnmSbNsumN?=
 =?us-ascii?Q?H0eEtWNAom7qx0nVYfkZbl9bLofmQXVNkgV6EDiV/jmP3uc8KIOd3nRGc/ky?=
 =?us-ascii?Q?mg9+zBvQ2y/QlY9zGOeZv4eMyfpDzQ/e1GDL4C2iV3CpePaT7qhZ/d8i+75u?=
 =?us-ascii?Q?mw3xQ2R7LaO5S9YBOQZuNhYtLdj6CaPjG/dcDQP9rPK4GUx5YPYP3L5CP1Gv?=
 =?us-ascii?Q?apQZMP7bA4x6dXke5eoQ4R99l/bEbZrp70AIbZoXrzXXFd4bw7H3sWTVCuf9?=
 =?us-ascii?Q?dcdfZ1aM0fetC+eaXDkUURwyC8x3En6HShdMUvXZU3U7UfsWHjl3EqqYT0bi?=
 =?us-ascii?Q?H7iNUx7bbgwvzohGvKN+z5LqztrkGyTo3i849w+B6G21DGBSbW27jtYFGPzC?=
 =?us-ascii?Q?c0a4LS5cWBNZ/Q7P/u1yQtAnNLGZVmJk286jiO/MAW8E0fUUsLN9Nj4N3GvO?=
 =?us-ascii?Q?kNQ9BZcj+QIHGNcojwdCke0bSygysNTFVtcfX3Su8U+/EXMkgK/eWzzLWuZf?=
 =?us-ascii?Q?NUYT71TiXIu0/Pt7q+vaMCmocCJDP+aAhX1DSNbrDQu92Ed8Vax2B5uwnuG0?=
 =?us-ascii?Q?BfGmP+lXMzo1ZkFzyFHZJak0d5rr5mkmHZ9WzR7H1YKOJuu91tAZjVx4ftCT?=
 =?us-ascii?Q?nt26XLnb/akMHw5Xyz5yYBcK3RpvA7f4QwSjDYhwUKSgb0i9oy3dskRtwC5v?=
 =?us-ascii?Q?GV76tbQqYZBjRWSJu2R61xpF23CB4s94e4+5qgraRB9YSN+wSoUgNNu9mhvm?=
 =?us-ascii?Q?EPGMt1g6qx9FIO+dhG/+as05hpkDIHK6QjnSbi59rqqXzc1O7tzJmk/OMjiI?=
 =?us-ascii?Q?gadPr+Zc/GPPF8HHTMXgpKKpThuvuZjqiYMIirRj17Is9dc0mqgQK1IT4FLE?=
 =?us-ascii?Q?mY7oBGeP9PtTiCgTbYN1H1j5n8WuOotDTtPhZwIID5GrSY68bQ+tFPAGfEJ5?=
 =?us-ascii?Q?um1aVcUPBYzNjwFiyADJ4O8QjHid?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50dh3zVZGQoAi7aOvtzpVo9n9z1wVZlSoFU2/S1Hjez6iA1HUwUDtdKHX1zc?=
 =?us-ascii?Q?RnJUeH1QCKWi0Nd/DbQKPW6E+zSAIFR+3KmECSM7jY/6OLpqtabU1WCVGWwm?=
 =?us-ascii?Q?JSERHTP7RnG9rlQ5SGNDFoCS5uojzwA2y5pYe8wSgCYvVUV3FxLTl9pYTzlC?=
 =?us-ascii?Q?YLzg5VY5Q8LvdqSo8DXYqfvEuRVt1H3Ws/v/4V1IAnr9QhJw6hzrIZP/h5kY?=
 =?us-ascii?Q?FlYaocUNohoN1wuZYFtbE/7i+oe2hwy9X+lZ4dh/FYQWm7sH775fDbUia+se?=
 =?us-ascii?Q?20S+jengw4vSaJg0hgmbWP/jDScHy99FHtdX25q5xNQrzol3xJ8YJLXS0XrE?=
 =?us-ascii?Q?BC7r5M0tvHlYSvkZ399e+jdQxze5VVqct5oatYK8cOFPSlaFvCB28ZXb508M?=
 =?us-ascii?Q?svaDxcco/ploGLi0HrG/M5NLHX+eozBjhNu0DE62w1tXA3b9mYUTmmJk3FUc?=
 =?us-ascii?Q?AZMYlZPQUjkF/Ilrn02G0ETwTLFXYY8d15ZoiABCpLPmeC3JJysKZIfyN84Z?=
 =?us-ascii?Q?Pvxkj0CmTq/+BSj3NqBJjvLM76mBmh3wRa+IJIKqFGhWY3aH5ha2hFBaP5ZE?=
 =?us-ascii?Q?JvtINoD4zFsafE51WrJSM1GbhKJ1RkyySWjxOzT0mZMH9IOw87HZhXmMuq7s?=
 =?us-ascii?Q?3RK14vHPF5njNuGEgDXLPD7KEXVxKVY4D9DAv9Bm+t21IXeSWP2a98jhKvrD?=
 =?us-ascii?Q?QTtyP5y+mtnEnqq35qOaXaesug43EhlqFPhPUbsYEon/ydrzipWHRAbcv39/?=
 =?us-ascii?Q?GaHsB7afu45ABc8o08MFHHWOVQE3SdlRrNGVfZaqGfKFG1OEUPs/48bv4xKt?=
 =?us-ascii?Q?0UjbwjAKB1SoxHy7aUNYfuqtv2ewAi/qDSPJDhN/ipMfFvGzFsOFgFwjRLSo?=
 =?us-ascii?Q?1+Mjq605NfXeFFfmOtQgsPRokr2Iwp/FVxhGzxVDZnC9wQLcSIpYtfGUId66?=
 =?us-ascii?Q?EdcxQApMp+qiksA/G2z24SfL/3U889uQ20NtCzj9AcuIEUOlVqNE1AOyEV4m?=
 =?us-ascii?Q?DBPn5sp8ichLJ/3uVdhxmnYEDeUSDnOe0pf7K6c0/vRmk0adN1EBCqUaTQFu?=
 =?us-ascii?Q?L6s7hVzOM+DaEJqy2SQXhp1KjhznQr7+dQ+Y001ou+X3aV1EuOO31u7fzlgA?=
 =?us-ascii?Q?TNgipQUM2AKukVum8DUrMhmRayNEmc/ykvOib9qfUQhakwG5SCUXVT9MdhRx?=
 =?us-ascii?Q?ky3uut3gCafbvI2nvXVIfboYTLRDr4XgHUdUjXlEbRZTxaHK8zAFlNlUz+Yd?=
 =?us-ascii?Q?sVMigFoCDrTUvETrY0tyWmd6a8lGcHAa1M9PSklu3w1B0l2Or2Agg4BMucnx?=
 =?us-ascii?Q?tydeIqYKCgry2+5mSkomA2W7jbq3ExPjMOEbH0di+/VMQqwq89cr+AESt7Gl?=
 =?us-ascii?Q?7WDVQaFuX4k7fsLkDiZ+0r1zMRdqYxjYT3QNPh19Y9pAgXWtOLLKgfsB77QJ?=
 =?us-ascii?Q?QvOjvwRTmNa81Ga/BEoakDhqhWTbIwn7cs3Rb/gavMTxwkeWqrABzYD+B3yU?=
 =?us-ascii?Q?FmfPZnWEZj3PSJ3rQvSbczbcreNBqS+ukJ4ZS2GM2VNoonjj1sEgIw7tecHd?=
 =?us-ascii?Q?bpzCHJa9sh5lG4qxIinaVNL7QhtVSymmV6ziuS2L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d44e31-5da8-493d-d5b9-08dd456e28dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:19.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHPp4zN/aMieY4pdIrX/njIOR8/eOSknt0x1CMV+iw5PUqExOOXmmZ2kd0zwxGuZcEGZzEhfY0QGlN4Gg2AHww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
check in __gup_device_huge() is redundant. Remove it

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Wiliams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3883b30..10f1ddd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3010,11 +3010,6 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
 		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio) {
 			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-- 
git-series 0.9.1


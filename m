Return-Path: <linux-fsdevel+bounces-52182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94E8AE0109
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF183AD8DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17B92857F6;
	Thu, 19 Jun 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ucd9Sel7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349C275119;
	Thu, 19 Jun 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323561; cv=fail; b=Pow9njYBQ8Mv7HeBLxmD9D4MxiVFVyfE8hC5IjHLZwAEtTBk9u9rTkxLne53tmpPB4EYutwIyWj3cIQ55vL/cNE7745Aj+j4qvdw60qHn/EXd9tWXfgQWpEmYBYoaU+uZ1Yj9ZvRjeIiULIWMxe8MyzGzns0W+sgZhtojOs1TdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323561; c=relaxed/simple;
	bh=PC4WYNvvPl78XQE+FMFfY2jfUcECITdTTWP0f9+T8TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=huSftSef9XKjvMXNsicC4omS/2iAwDWE7OBIO0HqrUL+txgfE9HhU0OpzwqEg/NzEOipPwud2k7nass0hmrFUIW3BJQPQzo/eR4qyf3+pylAqllWGPEuBjJpytwKugTzVD2wqlwfzL+pQZz9ZO7GJPvCqv9PAst7lt/Ho1g73lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ucd9Sel7; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi5ZcawfZxw3tHDGqgTFA9dbSJnBHNT9zhqRO1Yhg3wPUyziB5WfRgndooxKocNjp27cvu2n3hjoW9wZYsxjdpNY4yVN8PvQEhbFodiJASOQIYJ1zMPEDIAK7MhXOj3AeGCGnVbUHPX1YfheA9w5Z5AGQgP3pECYytd9TCSHgJV2bYCEOHGICQkCR5nmaTFmYuUnIcXTDpNuIWJryM6cVEDdzme36AZGBIhdn7KlVYKXZ3uNHNMmedtBDv/ICfnPBp00MZH9LtUDLcXPHZraptQVTjraSndYJG5fN/0fvdOBtasYRNLGHd/nMo5pepEJmLYlnNopiQIufwfFsbllHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6h7GTgzWalR5LzHBYTVX9ofphkKOXsjd7W+iqxTTs0=;
 b=ALp43NQblklcO0Pz4FuKbH+FE7XG+WrMLNrJbRvu5hYvRYQE9adkqX9k3+PsOwEmcmc+Y/dsY6KWcxdIwBDoZIvoYLZwuTIBI8Y42QZ6dlvip65R6DM0EEOWIldVslv1u2iuMB87F7jTTA5NzvxE6TeXIkcZv+nQDcHl6RYdyVkjn/tEatlT4JkprI/5nKIxdhNkfXeiPHxJzUoh9Gs6ZHX/yxHhz+2t9Y87Rd8w9zo8sYjtW3fQgG60IPj3MuSEWZA4Nv4zXGDJVcouXo3Cx0r3snoBgYTeGwA4p2a8mSRJDgByzpKFuygo66fi8dDwNsTsjuYwiN0ZR8dCDwoTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6h7GTgzWalR5LzHBYTVX9ofphkKOXsjd7W+iqxTTs0=;
 b=Ucd9Sel7eW+mjDM0vWWKUdbH7D00la+DEM3xb4GJ7rWLBY+HZQe0k3i1RNJbSuByDRIC33TtV8GhGgj5R2Ciws6mjDTCjgWa7Vva4OCCEmtsihhmAtOnYCJAXrJ3pGwCL0eQ13I2ryNqbRztUuE5NdSCRIYopn3vAUdxc/efG8OVpNZPyV901G33UGL2Juz2ODpaviF2E+TQCSEHHkDRreW43M/K5Ra8ukXFJqU8sSsRI7Zz55Z/PTqXQPJtj8edAoIVxt49LuQTGG/0h3m2LyjLY23+LATMXtDCyJlAywIXEy1s+ukuPtdtVsxtNWdXDUup90Mi6/78Y1tg2unAEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 08:59:16 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:59:16 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 12/14] mm: Remove PFN_DEV, PFN_MAP, PFN_SPECIAL, PFN_SG_CHAIN and PFN_SG_LAST
Date: Thu, 19 Jun 2025 18:58:04 +1000
Message-ID: <670b3950d70b4d97b905bb597dadfd3633de4314.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0040.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::6) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: e499ad00-de99-4aa4-59e8-08ddaf0f91b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DcMHt6KOTJ1wTc0HBH8dFlblhMi1KG/E/kQ69CY3J4+KHT00EZvYPhapE0ID?=
 =?us-ascii?Q?u93ugIpJmQEt+jH8Uw5oOjKX7PSomtXG+DZ0auJky8nBPCP11623k+h4P1da?=
 =?us-ascii?Q?rQTKZ2f4oQ0CiVeqdhNtVGdlvs6cpdDBTs0w7EQqU/VHe9pGjwL+lmZYbPRP?=
 =?us-ascii?Q?rBeNjASNE65Y7mmsT6t23h3usZiuIbQIfeP+/0KkFG//CM8RFJPFzWYnzr+y?=
 =?us-ascii?Q?dKwIgeYU6Sg1uQpis2TmMdAlvsFUuf3YzAXAesXvsyYPMBOn3L23810Ic/68?=
 =?us-ascii?Q?eZNK/uQlqoesT0/llQ1RYsLiZ2+30G5/QetI26EmtDB36WGZ4zPb4Ce2WSN5?=
 =?us-ascii?Q?lyivmxOQXFB4p9hO8m6GiS0xMLHe0iy7BcArR+ikRQMrRlKPaee8pPnNNBEA?=
 =?us-ascii?Q?ZKd6oz/a2kHB2Q34Es/SsRb3giyts80VRpJSHazCaLq6uigOj7ifBTWMtCy2?=
 =?us-ascii?Q?4KaPXvCIK+MI2m68xUM6jX7kh0DTHdMfsoVl59p6uNQxXdUxVIBPvjPAYdlV?=
 =?us-ascii?Q?Y/z9nHJ/L67yWhy5G47TGg9jZSnFvqy2tDRzVitHQpc144eUfwBg0J/8TX1L?=
 =?us-ascii?Q?/RY3NXPt3aZBv+IvhRPjS3p8kGIgY07c+DvWqQzV8gB0GZo1JIBoYvGJDu5z?=
 =?us-ascii?Q?1BSIV3eyGU1L5qzoSxp301beuZjrskTecoP1UZ7CafJkqfwGFbCIGE5cgddD?=
 =?us-ascii?Q?GDTdVJT/EtkUk31UJDQBpq955q7a5+1DgLgSJwctNCktwJ0cTiy/bwp5iFy0?=
 =?us-ascii?Q?khaL6dR7EMrvjvsf+UTDmsuaXC5XpwA/qlON5ndhVN7/dD5Svglh116MDGea?=
 =?us-ascii?Q?xaUvPE4V9lHXlIXOXItB3wSThoHt78C3m79Hg9VXcTcryrO/maHDimqpOQM6?=
 =?us-ascii?Q?aA9O3uVB5MYxwBLk0D3nE5Tsk9rxmKsq8i6msyF7iGVOJXu+h5pEMJIyOuHM?=
 =?us-ascii?Q?WOdJ7lOFXsa/6qFBokD0xaDfz/DvBKWX7Q7gNolGtd5YOJGaEMumPQZjgWgS?=
 =?us-ascii?Q?aq1WaIYC6p/3pJI75sU5S+mEicMKjdgVlWrRc/um90lW346yqvzdnN+sDKo/?=
 =?us-ascii?Q?HsrtA5VICVqjSAXeXnb6AHrGM5VP0VL+2ulD1vfJqnbvnpCz+KisAb9pcvxM?=
 =?us-ascii?Q?VfxsGl4p5Hlq5+GQNLMmlXhC7Ic4u4CpfVqfxRy23QORe+3yv1IpHNwqYuSE?=
 =?us-ascii?Q?xwSi1x3ckJjrilfnQzDtkvajeaCaoOAV0hDNEg7pk+qreha70KnGwZSdLzD2?=
 =?us-ascii?Q?upMZHr3gY/AraewLtWXueRlnF5FAf1J2GE/ds1/j4/xpQUwem+xQcN5j65dy?=
 =?us-ascii?Q?lq3BROU0D0IdYZFXxipwrlWiDHQBKJNPxuaz9DV6vFLyW7OczhUfweZmYIXK?=
 =?us-ascii?Q?MvSaTbBBH4nFssuGM1jpU3NTjmmQ3TkBnP/0TEigsz00bInHqJc6rI2i6cO/?=
 =?us-ascii?Q?clloFv13O98=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gK/hub/YpMfddxhHZ6yN8V+ZnOfNkg430w5kMnXAk07FWnb7ql4SQCoYUyL+?=
 =?us-ascii?Q?HjffIA4dAApGtSSm8KHAwlcFb636C7IVPE1kKJ/O9Et3mKqtgND13C89JtHM?=
 =?us-ascii?Q?wdkGywoSdYpOFdbmNP4+9iFS/WDK6W7F9UmMjG9CJ7wQlz/k4Ro1bO+DLo+6?=
 =?us-ascii?Q?2ZvYTyJKHIXjtn0o0eIRrwFLlq8tSTnSihtz4af/6z1SFCtGW5JbpJFvyWzP?=
 =?us-ascii?Q?W0Dz23FG8j8DmkC/pasxtHcyqFx/pjfsmQImtjJHxq+cBzlgSqTwzkw0nqCJ?=
 =?us-ascii?Q?JPgTQB3gk/hUl/VnSAl4JH4ifZowMiTsTNP/smX64eRyg0NxJTnRnyDROMJE?=
 =?us-ascii?Q?+CzmdGXbBO2EFBv3nXSNxMvnLDL/eZy38l9xPrziCMamnkfME1d4H8PO5EO5?=
 =?us-ascii?Q?IQSLA8zwkg8yHRiYpI1w4UIyop87XHuhFCLM6z+7fwrM9QI+xQBgT6Q7Sfd9?=
 =?us-ascii?Q?xIbABu2Pa90pqUFgkPogCp07TUMWmw8qzqHbp9VksIa+piDsDVWE8wX9uLei?=
 =?us-ascii?Q?Ih7Fs6YBw3KuXbfbKRLrvcWlWgMttOJ0JjC/VpgYpRf9w2lnMyn+kMDgekIb?=
 =?us-ascii?Q?TQJ/1GYcbqTevlbdRUaSaNU8VeKNBZEA2A5rjQqgX9la1dtJHoFtCe/kzQPV?=
 =?us-ascii?Q?a4dmsyq5AKVucO6fI7PuNrOHTJOIIOjj6eLjZD/IzQ5Ijx59QDaapM8jlQN9?=
 =?us-ascii?Q?VdDAPsRyUsJx17V0sFAqzVmK3r0TL8ACfdljwaBHptwEUE00sQK0oP3xrSun?=
 =?us-ascii?Q?wqI1L9RHcopMgXzzOLbyOQkFB9lYAr8oAJBpkE9Aa5cxhTnL2J8mzYYaTcWD?=
 =?us-ascii?Q?eYEP/aAcphhzbewr50pTHL8kFhDFtWBmPvGNBW4xSBYQn0zEsfR5Rk9cRxEm?=
 =?us-ascii?Q?SHhPo6fzLWlLMjUmUKvNxBNB4qZOQ9AnKrz6DHpxmC7FHubZouaCubeFODyp?=
 =?us-ascii?Q?Rz30e4HT5a3k0H73cYW0a1MJbrV1iHYB9+mSkXV/zIBdOhQY8Fa4C4B3rQef?=
 =?us-ascii?Q?HVEsipDR5pCqfZtkOmR5Ru3qEghwC/IEAWGqNB+d8dGPizkj7L5VQFHjY4Yw?=
 =?us-ascii?Q?7edrJ3v28PTTH8IY7d3wYOjQ9sZdEjbLjgjdJ4FKsjpy7hvgxcv74zMaCOqS?=
 =?us-ascii?Q?M2F9nZx6XzH3GhljCX/pH8sJk2JQLs8Mq/a5fJ9l8D8G8u4Mh5mDvsLmKI+O?=
 =?us-ascii?Q?V19uYT+Yj5NBE1XL50FBTug9XFZyZxpQEU76lPPHbm7hP/4ssgkU55sgxrYP?=
 =?us-ascii?Q?dGgZrYxYsO/o8uXAbzb1epL0BF+EXDxHN7MEbiwZURp6sON2GJsgJlKP2uaQ?=
 =?us-ascii?Q?QPfatL/7OF7nImkG7hFGO7TEBgCd8DA/4xKp8A40QD3Xrv2Ubw9JnOCzVnjt?=
 =?us-ascii?Q?BqZrA+3xRAwECPMbguVLK10ywgO+xPQjoRQ0dSIVFlOgigaddi9FF4xvLAWQ?=
 =?us-ascii?Q?rAdNYkomSlCnZ9obcTtfTcgg1dybasmqbsNLK/3ZQ43+n7R5p7VIv4I6VIug?=
 =?us-ascii?Q?kCLk47JnbIQEXhQvjUCb32nOxYFFgZEZY0Ip5YVnzN7kqHfBJsknCKe1vwaR?=
 =?us-ascii?Q?lzlpPonPduEMEg7XrDa/DF1PF3ZZbhgTjQuWvqHO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e499ad00-de99-4aa4-59e8-08ddaf0f91b6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:59:16.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7rwoVeM4wrtVOq1tXkeRVloo8wpQT35NMBacZYn3cqUrydpZKJxoejJqVTKVcJ62GLNd5tgQDw0jCdz6Yd/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

The PFN_MAP flag is no longer used for anything, so remove it.
The PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been
used so also remove them. The last user of PFN_SPECIAL was removed
by 653d7825c149 ("dcssblk: mark DAX broken, remove FS_DAX_LIMITED
support").

Users of PFN_DEV were removed earlier in this series by "mm: Remove
remaining uses of PFN_DEV".

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

I'm now tempted to squash this change into the next one that removes
pfn_t entirely, but have left it as is on the basis that squashing is
easier than unsquashing if people think otherwise.

Changes since v2:

 - Squashed the PFN_DEV removal into this

Changes since v1:

 - Moved this later in series, after PFN_DEV has been removed. This
   should solve an issue reported by Marek[1] on RISC-V (and probably
   Loongarch and others where pte_devmap() didn't imply pte_special())

[1] - https://lore.kernel.org/linux-mm/957c0d9d-2c37-4d5f-a8b8-8bf90cd0aedb@samsung.com/
---
 include/linux/pfn_t.h             | 50 +-------------------------------
 mm/memory.c                       |  2 +-
 tools/testing/nvdimm/test/iomap.c |  4 +---
 3 files changed, 2 insertions(+), 54 deletions(-)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 2d91482..2c00293 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -5,26 +5,11 @@
 
 /*
  * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
- * PFN_SG_CHAIN - pfn is a pointer to the next scatterlist entry
- * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
- * PFN_DEV - pfn is not covered by system memmap by default
- * PFN_MAP - pfn has a dynamic page mapping established by a device driver
- * PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
- *		 get_user_pages
  */
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-#define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
-#define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
-#define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
-#define PFN_MAP (1ULL << (BITS_PER_LONG_LONG - 4))
-#define PFN_SPECIAL (1ULL << (BITS_PER_LONG_LONG - 5))
 
 #define PFN_FLAGS_TRACE \
-	{ PFN_SPECIAL,	"SPECIAL" }, \
-	{ PFN_SG_CHAIN,	"SG_CHAIN" }, \
-	{ PFN_SG_LAST,	"SG_LAST" }, \
-	{ PFN_DEV,	"DEV" }, \
-	{ PFN_MAP,	"MAP" }
+	{ }
 
 static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
 {
@@ -46,7 +31,7 @@ static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
 
 static inline bool pfn_t_has_page(pfn_t pfn)
 {
-	return (pfn.val & PFN_MAP) == PFN_MAP || (pfn.val & PFN_DEV) == 0;
+	return true;
 }
 
 static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
@@ -97,35 +82,4 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
 #endif
 #endif
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline bool pfn_t_devmap(pfn_t pfn)
-{
-	const u64 flags = PFN_DEV|PFN_MAP;
-
-	return (pfn.val & flags) == flags;
-}
-#else
-static inline bool pfn_t_devmap(pfn_t pfn)
-{
-	return false;
-}
-pte_t pte_mkdevmap(pte_t pte);
-pmd_t pmd_mkdevmap(pmd_t pmd);
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
-	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
-pud_t pud_mkdevmap(pud_t pud);
-#endif
-#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
-
-#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
-static inline bool pfn_t_special(pfn_t pfn)
-{
-	return (pfn.val & PFN_SPECIAL) == PFN_SPECIAL;
-}
-#else
-static inline bool pfn_t_special(pfn_t pfn)
-{
-	return false;
-}
-#endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 #endif /* _LINUX_PFN_T_H_ */
diff --git a/mm/memory.c b/mm/memory.c
index f69e66d..f1d81ad 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2581,8 +2581,6 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (pfn_t_special(pfn))
-		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
 		return true;
 	return false;
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index e431372..ddceb04 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -137,10 +137,6 @@ EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
 
 pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
 {
-	struct nfit_test_resource *nfit_res = get_nfit_res(addr);
-
-	if (nfit_res)
-		flags &= ~PFN_MAP;
         return phys_to_pfn_t(addr, flags);
 }
 EXPORT_SYMBOL(__wrap_phys_to_pfn_t);
-- 
git-series 0.9.1


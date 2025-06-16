Return-Path: <linux-fsdevel+bounces-51744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D5ADAFC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AC03B82F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F62E427D;
	Mon, 16 Jun 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HcD61OHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFF2F2C72;
	Mon, 16 Jun 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075193; cv=fail; b=MnxHGZ0g0IxUPlrMJNeXwKN06Ryrj2R+8Pe1RZphq7JmZ33R5I19yFwmDNMM1BUk7hxVa+L8PL84RYbxHz3onH5L5rYWObzBBPPUAKA/nzrMIsVXCvBC6NRd+D5UyAUBrZ/rBXuJY0QwbtLtDK5P9959E9nyMcA8cwVltVUJjl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075193; c=relaxed/simple;
	bh=P3KQPFd6m9EHPqFcLCMPAdsW3Ad1p7+EP2D8ULq+WnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S50lah8KYIEDOCLlLojH0rQUwCYZ3jbb9H/LbO/Wx6OZV4b4zjm9PAg5wJU2owtsWbHnr3a7g6FLwmRK9R/SHTOAiWDAW/n2y7ZUjLBShYyj+Fiq+lyAFczgOBzsvqo9vnnInLsB1+rh+WInvE8xTYuEmJZ0R148WlfhSm3+Y3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HcD61OHy; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kavYcVlbUPjCZwllrYDSEXBS//wzudzmNHKbcFazgKSH/cbxHQf2IEv9J8bvh/F4DX0ZfjPyj+fl5aluP/jMmL8f9ayvnvQiV1nFZYTdAZLnT6uI9yRVbHXBbT3uatWCx8PDgxATFIauGRn9G1dY0epaRgAPTq2zc4mUWDoJ/P4GujWLX4AvxjSFiDZutDVa7pueugQO8fyZIslKy6pMdXBlFyA5HbUdaLYefi0Q37OiyVc6WAbFU3zGi+V1Nz3DQgT681/QZL/QX3kfZnY6+Ud2gWlfMFQa8a6JW+DsGmFLF6ZRXNQHuHuLL0dyqS5zs0H26bE/VjRlaefIJ3qDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRQFdhbGxrou+I/Fb2jYB0dRfGYdxiaFfCeczeYkOnQ=;
 b=NCLuSzinam5CHXg9yYMBmnuCdZJ1q7lirsj8CmIaGuW4MIioRQD0STFhn5NmKaRb3+ASOLvpeEmfskC4roXo8s1HqJu9FuI4YgcH0DR5iZXBrdlNeiLmxzv5eaBvVe4CeiaXOd/stGQE7yv3nxXatBrAx1ohvhiEU/7eNoKJ0nHAhQvGYj1YB7JIj7dmzwOWpF1D5SDcFiFoWDE/b+334e1HDn3ik2jHnG1Ovp5SnpHe3av5f8ytAsl0u1Rpt1OReHP0YaaZ2szlpM9ITh5VzFWc6YUi7k3B6OZvGgFiZzitW+ejU7aAGLdZtdvHSOSBDMNqGwDzSaPeuZw0TJ0n+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRQFdhbGxrou+I/Fb2jYB0dRfGYdxiaFfCeczeYkOnQ=;
 b=HcD61OHyU8aIdichzUzt1l3/JTq5/8AfRjOFS8A8zZCSkHm6skJ5BLVB+tg+dCWTwwTO8rXhjyURUS9hfxI5Qxa5OnhTOx+HNPI401YlMVu4PgIXOxfmj1+M64kx2sVi7XbqNGtCmMskmPJvNO/WaeifQEBvVDTdkyvEPxH197A6G35MaV0VwNnywU9qYZ1tKlGYXYuMB0onfYhKGMsvOrkJwb6ew0gcO8Q7d0X+TPdnc3R/m5Nkei4eaF6bo+EDaha0+G4VddPHxOVBL+Hazu0DTxjQ+OqssWqeaI6+vAEo38QIhpdwP/k8D//PKDVqN28r3a1boVMM7GfJ/OLNrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:59:40 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:59:40 +0000
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
Subject: [PATCH v2 13/14] mm: Remove callers of pfn_t functionality
Date: Mon, 16 Jun 2025 21:58:15 +1000
Message-ID: <657be8fef1f0d15c377ad3c420d77ca4db918013.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0087.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::20) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 06eca684-ed6d-4abd-008b-08ddaccd4654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nZHlH8N2s8wAUY4JsPr7HwzfObA+UHjtcxD7YQ06JiPVWGUgGgWcRFQ1kbbw?=
 =?us-ascii?Q?G7kkAwP1Squm0fZfz0EcNvxiD1sIbzd1gLmZ6VaWIwLYBtZ+3fd1GXmIWRd2?=
 =?us-ascii?Q?LzQS2BuiHCK3j3pNHWYvdLIKylCXhWdwdJJSJYyEk0KC/gpN/47EekKposIb?=
 =?us-ascii?Q?TA5BmkxMtm+C+FLhygSU0XBrywMf5ZWxMhve5w8WYav8rZfV5SdGjHMo4wgf?=
 =?us-ascii?Q?G5TzuPVhdjw8+0o6oQ/tc9UEcIvic66VdHw//E9iTB+FedvgmNEI2MJXUTCg?=
 =?us-ascii?Q?mbPFKISvq0/vMiLufzLA0YX219y3qrORkVcjt+Ct5aqwTReODPTohIMVySIP?=
 =?us-ascii?Q?RpHKN31VUdQiMb/1zETEB4IuchCBQcn2qrhd7fogGPrd6dIxiyqIPGyfoKLJ?=
 =?us-ascii?Q?GJ2J/OxNk/J7Ss6HEp58FIGOSbaI0RR02SayKy3Ag/EZ/Lq58d+ukJVNXy2A?=
 =?us-ascii?Q?wSf116n+qu9PSe0BSRwInDuII18bQvHH3Q4vIFhMnaBjpXAopr1JU9WiAQ4a?=
 =?us-ascii?Q?PjyNb8Il+dBZwrTGwVQjdZYz12fu8PBwof7cjfT4D1owMBitUrjscd6MAoH2?=
 =?us-ascii?Q?76N+EuldLKygQzeakciRCmPj4CkscMkdndT0JkOnPjGsZGxp8CEJUeL5359a?=
 =?us-ascii?Q?KeyldUwvVxgL52T4Fa0FyM8YRPUO2I/tq+ohGQKhiKZ7Qn2luxY974giN6C8?=
 =?us-ascii?Q?ULsNi5zZwcGGMZDvYjPIUQqjJuxr4Rn0WQbVqrlGGptuRcit/9VovVrtkMLv?=
 =?us-ascii?Q?Eiq03M+8XMfXPgW113pEdJEsWClBjk1O/4Ze4BUEpUgpMKq853vKW7N+1D4m?=
 =?us-ascii?Q?PJLu5FLDUmvIS4s6zfHQiKO9myD7bqJ/pJ6nnPl1QDHDMRSy2XkZ9rSJWKtC?=
 =?us-ascii?Q?F8FtEjXEBv+cHl++ArS3e/UfT4cbac7dV6jodrWdti8QGKY7djdXo77tM0ew?=
 =?us-ascii?Q?ys7EmPFZylREtTP5DW6qwKkJaCXvVmauAlru0N+XaOQovFVXoJMewvE5Y1hA?=
 =?us-ascii?Q?ISLyYXcHz7YZxRa7N+BrdbtUgVt2ygSxFZ/qsWPXEChvI/B0KAVsBgKA74HK?=
 =?us-ascii?Q?3WqQtwtRXtareQnapxhyK5wnuiL+1LhKMWl01o6FuHsGAkpCAmsORL+cGla6?=
 =?us-ascii?Q?EuTNfLiEKjS83OLQt0x7K7MSZhj1l5FzmhpQBhdnYDP8t4+JCYcCZADn+UDD?=
 =?us-ascii?Q?BJAoRru6sFYnvOxUt4i37Qm8tcokEmlI9Do6jP5lpJbJmXOptQeEV/I59mFw?=
 =?us-ascii?Q?6DM/xuPvlzocUg2jm02neeFODdUnyfJA1xRF5fF6UWrtwchok8WRMCIpUd+6?=
 =?us-ascii?Q?mie/ePzCLokbb2TeUYYp0jVqmPS2OenXu8UNoS+coIdHo5a2p0Jq/FeTc8y6?=
 =?us-ascii?Q?i4cY0ZqOtcmDzKsJs/XJJU1DAxW7NOZdkW3MyhWHVUtB/1Tiyiw+Sf3XAUqb?=
 =?us-ascii?Q?67W6cUpqHDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AKZJF93pNIUmwls1Pdx2IXRl6n9JyCj53kkRCu2RVV65qOj+MiNhl5asBnn1?=
 =?us-ascii?Q?qEIrFyfkzRrcWA+0+dhMp2/kNhjRDmzWLGQCLZM4LJacfELGtHC17wzcvEhb?=
 =?us-ascii?Q?CmngDInnwWaZJIHu01S6O/YmaBBB+Jmu+Nc2d5RuCNoGO6kEqE1wonDL0N6z?=
 =?us-ascii?Q?whkpS1YFKLJp3bWm94QIfdJh9IeI61cJjn2nW10Y4H8WaUEr/M3FZolBBxiM?=
 =?us-ascii?Q?a6RtRenFwk/KTzttux8D91B3xf3S16nAUAikMKZcGogC2f8VR3gtFzc32rmn?=
 =?us-ascii?Q?NLyGir8GCC1EuiTpgeaTLeKVXsWNB/Oo0J1HcOsEbVJwCAppVhwnJlsaPWQs?=
 =?us-ascii?Q?bd4bDQodBe6EVQl8cKT7rUaS2OngIItIBafGBVcVpwVkS3xUS0ur3+XpYNAh?=
 =?us-ascii?Q?JlzmLiHjia9FrIS9kM+1z0t1HNOwWK82mTNyu/lowuDbO2x7mGnnFEWBa42g?=
 =?us-ascii?Q?xztQAchZ0ZSdh8n2aR2kG546ybmvZYS37TiR3xxhrrORR4JPDB7insFOFA5p?=
 =?us-ascii?Q?jp/ljhHdcKomYgfN+RVdoAWkMSbHY6mfTj5HoDXveBXiZTH4LfRUfn3Dqmsn?=
 =?us-ascii?Q?T1KWTvgwNlEjNsEzscks3XquDwsdkLu9iLWZeSVbCRCdWVcX0jlUMyFmLx8U?=
 =?us-ascii?Q?b1GLtJZ4DrPx4kuSvwLJEil5DlTi5QUf3Gm3gnu9kr3j/eJDwwPV6Sj6vkY9?=
 =?us-ascii?Q?Z4foUL/QfQJ4wusU/7bGs2t+OUxCOOuteC7zXEYr4SfAWGiRW87+vD5qe0op?=
 =?us-ascii?Q?7kM/8L0kGH7mCsxLcwnmbgGXXYWxTsV+eViYuBJc8BwGhqZPQXgMSG5FOJgw?=
 =?us-ascii?Q?4Lm8UgQ87BmUwsgzVOPimoyQ1Hlxv42FGlF65tNf+/wt3vzgB4TGRZGmQnv4?=
 =?us-ascii?Q?+Lf14ePSleDxpdlGTMWCXMMHsXqYuWmQmIYsYMeeXCw9/x/kiytE76e+hzCb?=
 =?us-ascii?Q?dkw7d4OYOTd/8YNXsPWZZxtW7JnJwCNpahUd+HJ3Q2rfDbMyq/PttFRZLNv5?=
 =?us-ascii?Q?8rjl4ssh6L2SmLfimecXeDUsuJ82ah/AEXsFdjAOB7ffYtcvNiqaZSWGV9by?=
 =?us-ascii?Q?MAKNRxjsTT4JSt4R6K4Yfxi7yktqB9sIVlkLlRp4XBmATwteMdfBQ6+0xrUq?=
 =?us-ascii?Q?zmyQX/jq8uTv2edKp9wdbjXDK1mP+vDw6Sg/tglqZ7gQVA8HMsCuOISIxs3g?=
 =?us-ascii?Q?JSkvKyeVOqxLfXATsr36oikmyZzFTdpzrFB35UwfyFPL4j4+0XpCCUME4y7r?=
 =?us-ascii?Q?CiP1OxXLAvpkKXxZhKJbd3iq6chLEuRkLJgftRLQV4Mv429OJILQMU2TpQLL?=
 =?us-ascii?Q?YUvQ6X3PiVdOJsqIqZQ+IP1YGmAeAr+6NF6N1boVp6zvyOx3Qb8i8IB8GzHV?=
 =?us-ascii?Q?IhSxPCK3j2qFnlO82lfBsxz0qoQ55G2JG6pU2uEjBXEebCFRGPJrQBZHjNtA?=
 =?us-ascii?Q?hW6FeDa7NalO587+RT+gH8s+PIWHMYCwAe5LbmfbUIEPyCbq3r/ibzkey3G0?=
 =?us-ascii?Q?qlKjT2ravulrIvwLtotllynUf0yJPtMqq35zUIob/MKv29eG7dq1VGzjq443?=
 =?us-ascii?Q?+VUQBO3W6Wim6yRP3/vsTqTgbdDY8dMdwnTFuDc0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06eca684-ed6d-4abd-008b-08ddaccd4654
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:59:40.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQD5MabdDRTuCUinp2J/py8RH2dmP1DC/26VIq87lMzfNbNS6cIF71XaZWLsa7J/5wfw+3Ing/g0kWz1QzVfig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

All PFN_* pfn_t flags have been removed. Therefore there is no longer
a need for the pfn_t type and all uses can be replaced with normal
pfns.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

---

Changes since v1:

 - Rebased on David's cleanup[1]

[1] https://lore.kernel.org/linux-mm/20250611120654.545963-1-david@redhat.com/
---
 arch/x86/mm/pat/memtype.c                |  1 +-
 drivers/dax/device.c                     | 23 +++----
 drivers/dax/hmem/hmem.c                  |  1 +-
 drivers/dax/kmem.c                       |  1 +-
 drivers/dax/pmem.c                       |  1 +-
 drivers/dax/super.c                      |  3 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c  |  1 +-
 drivers/gpu/drm/gma500/fbdev.c           |  3 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c |  1 +-
 drivers/gpu/drm/msm/msm_gem.c            |  1 +-
 drivers/gpu/drm/omapdrm/omap_gem.c       |  6 +--
 drivers/gpu/drm/v3d/v3d_bo.c             |  1 +-
 drivers/hwtracing/intel_th/msu.c         |  3 +-
 drivers/md/dm-linear.c                   |  2 +-
 drivers/md/dm-log-writes.c               |  2 +-
 drivers/md/dm-stripe.c                   |  2 +-
 drivers/md/dm-target.c                   |  2 +-
 drivers/md/dm-writecache.c               | 11 +--
 drivers/md/dm.c                          |  2 +-
 drivers/nvdimm/pmem.c                    |  8 +--
 drivers/nvdimm/pmem.h                    |  4 +-
 drivers/s390/block/dcssblk.c             |  9 +--
 drivers/vfio/pci/vfio_pci_core.c         |  5 +-
 fs/cramfs/inode.c                        |  5 +-
 fs/dax.c                                 | 50 +++++++--------
 fs/ext4/file.c                           |  2 +-
 fs/fuse/dax.c                            |  3 +-
 fs/fuse/virtio_fs.c                      |  5 +-
 fs/xfs/xfs_file.c                        |  2 +-
 include/linux/dax.h                      |  9 +--
 include/linux/device-mapper.h            |  2 +-
 include/linux/huge_mm.h                  |  6 +-
 include/linux/mm.h                       |  4 +-
 include/linux/pfn.h                      |  9 +---
 include/linux/pfn_t.h                    | 85 +-------------------------
 mm/debug_vm_pgtable.c                    |  1 +-
 mm/huge_memory.c                         | 21 +++---
 mm/memory.c                              | 31 ++++-----
 mm/memremap.c                            |  1 +-
 mm/migrate.c                             |  1 +-
 tools/testing/nvdimm/pmem-dax.c          |  6 +-
 tools/testing/nvdimm/test/iomap.c        |  7 +--
 tools/testing/nvdimm/test/nfit_test.h    |  1 +-
 43 files changed, 109 insertions(+), 235 deletions(-)
 delete mode 100644 include/linux/pfn_t.h

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 2e79238..c092843 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -36,7 +36,6 @@
 #include <linux/debugfs.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/mm.h>
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 328231c..2bb40a6 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -4,7 +4,6 @@
 #include <linux/pagemap.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/pfn_t.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
@@ -73,7 +72,7 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 	return -1;
 }
 
-static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
+static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
 			      unsigned long fault_size)
 {
 	unsigned long i, nr_pages = fault_size / PAGE_SIZE;
@@ -89,7 +88,7 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
 			ALIGN_DOWN(vmf->address, fault_size));
 
 	for (i = 0; i < nr_pages; i++) {
-		struct folio *folio = pfn_folio(pfn_t_to_pfn(pfn) + i);
+		struct folio *folio = pfn_folio(pfn + i);
 
 		if (folio->mapping)
 			continue;
@@ -104,7 +103,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 {
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PAGE_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -125,11 +124,11 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+	return vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn),
 					vmf->flags & FAULT_FLAG_WRITE);
 }
 
@@ -140,7 +139,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PMD_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -169,11 +168,11 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_to_page(pfn)),
 				vmf->flags & FAULT_FLAG_WRITE);
 }
 
@@ -185,7 +184,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PUD_SIZE;
 
 
@@ -215,11 +214,11 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_folio_pud(vmf, page_folio(pfn_t_to_page(pfn)),
+	return vmf_insert_folio_pud(vmf, page_folio(pfn_to_page(pfn)),
 				vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5e7c53f..c18451a 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -2,7 +2,6 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include <linux/dax.h>
 #include "../bus.h"
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 584c70a..c036e4d 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -5,7 +5,6 @@
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index c8ebf4e..bee9306 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -2,7 +2,6 @@
 /* Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved. */
 #include <linux/memremap.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include "../nvdimm/pfn.h"
 #include "../nvdimm/nd.h"
 #include "bus.h"
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e16d1d4..54c480e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -7,7 +7,6 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/magic.h>
-#include <linux/pfn_t.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
@@ -148,7 +147,7 @@ enum dax_device_flags {
  * pages accessible at the device relative @pgoff.
  */
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		enum dax_access_mode mode, void **kaddr, pfn_t *pfn)
+		enum dax_access_mode mode, void **kaddr, unsigned long *pfn)
 {
 	long avail;
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 4787fee..84b2172 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -7,7 +7,6 @@
 
 
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 #include <linux/shmem_fs.h>
 #include <linux/module.h>
 
diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index 109efdc..68b825f 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -6,7 +6,6 @@
  **************************************************************************/
 
 #include <linux/fb.h>
-#include <linux/pfn_t.h>
 
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
@@ -33,7 +32,7 @@ static vm_fault_t psb_fbdev_vm_fault(struct vm_fault *vmf)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	for (i = 0; i < page_num; ++i) {
-		err = vmf_insert_mixed(vma, address, __pfn_to_pfn_t(pfn, 0));
+		err = vmf_insert_mixed(vma, address, pfn);
 		if (unlikely(err & VM_FAULT_ERROR))
 			break;
 		address += PAGE_SIZE;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index f6d37df..75f5b0e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -5,7 +5,6 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/mman.h>
-#include <linux/pfn_t.h>
 #include <linux/sizes.h>
 
 #include <drm/drm_cache.h>
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 2995e80..20bf31f 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -9,7 +9,6 @@
 #include <linux/spinlock.h>
 #include <linux/shmem_fs.h>
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 
 #include <drm/drm_prime.h>
 #include <drm/drm_file.h>
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 9df05b2..381552b 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -8,7 +8,6 @@
 #include <linux/seq_file.h>
 #include <linux/shmem_fs.h>
 #include <linux/spinlock.h>
-#include <linux/pfn_t.h>
 #include <linux/vmalloc.h>
 
 #include <drm/drm_prime.h>
@@ -371,7 +370,7 @@ static vm_fault_t omap_gem_fault_1d(struct drm_gem_object *obj,
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	return vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, 0));
+	return vmf_insert_mixed(vma, vmf->address, pfn);
 }
 
 /* Special handling for the case of faulting in 2d tiled buffers */
@@ -466,8 +465,7 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
 			pfn, pfn << PAGE_SHIFT);
 
 	for (i = n; i > 0; i--) {
-		ret = vmf_insert_mixed(vma,
-			vaddr, __pfn_to_pfn_t(pfn, 0));
+		ret = vmf_insert_mixed(vma, vaddr, pfn);
 		if (ret & VM_FAULT_ERROR)
 			break;
 		pfn += priv->usergart[fmt].stride_pfn;
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index bb78155..c41476d 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -16,7 +16,6 @@
  */
 
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 #include <linux/vmalloc.h>
 
 #include "v3d_drv.h"
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 7163950..f3a13b3 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
-#include <linux/pfn_t.h>
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
@@ -1618,7 +1617,7 @@ static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	get_page(page);
-	return vmf_insert_mixed(vmf->vma, vmf->address, page_to_pfn_t(page));
+	return vmf_insert_mixed(vmf->vma, vmf->address, page_to_pfn(page));
 }
 
 static const struct vm_operations_struct msc_mmap_ops = {
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 15538ec..73bf290 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -170,7 +170,7 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index d484e8e..679b07d 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -893,7 +893,7 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
 
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index a7dc04b..366f461 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -316,7 +316,7 @@ static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 652627a..2af5a95 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -255,7 +255,7 @@ static void io_err_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	return -EIO;
 }
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index a428e1c..d8de4a3 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -13,7 +13,6 @@
 #include <linux/dm-io.h>
 #include <linux/dm-kcopyd.h>
 #include <linux/dax.h>
-#include <linux/pfn_t.h>
 #include <linux/libnvdimm.h>
 #include <linux/delay.h>
 #include "dm-io-tracker.h"
@@ -256,7 +255,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 	int r;
 	loff_t s;
 	long p, da;
-	pfn_t pfn;
+	unsigned long pfn;
 	int id;
 	struct page **pages;
 	sector_t offset;
@@ -290,7 +289,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		r = da;
 		goto err2;
 	}
-	if (!pfn_t_has_page(pfn)) {
+	if (!pfn_valid(pfn)) {
 		wc->memory_map = NULL;
 		r = -EOPNOTSUPP;
 		goto err2;
@@ -314,13 +313,13 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 				r = daa ? daa : -EINVAL;
 				goto err3;
 			}
-			if (!pfn_t_has_page(pfn)) {
+			if (!pfn_valid(pfn)) {
 				r = -EOPNOTSUPP;
 				goto err3;
 			}
 			while (daa-- && i < p) {
-				pages[i++] = pfn_t_to_page(pfn);
-				pfn.val++;
+				pages[i++] = pfn_to_page(pfn);
+				pfn++;
 				if (!(i & 15))
 					cond_resched();
 			}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1726f0f..4b9415f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1218,7 +1218,7 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 
 static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index aa50006..05785ff 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -20,7 +20,6 @@
 #include <linux/kstrtox.h>
 #include <linux/vmalloc.h>
 #include <linux/blk-mq.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/dax.h>
@@ -242,7 +241,7 @@ static void pmem_submit_bio(struct bio *bio)
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 	sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
@@ -254,7 +253,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = pmem->virt_addr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		*pfn = PHYS_PFN(pmem->phys_addr + offset);
 
 	if (bb->count &&
 	    badblocks_check(bb, sector, num, &first_bad, &num_bad)) {
@@ -303,7 +302,7 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
 		pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
-		void **kaddr, pfn_t *pfn)
+		void **kaddr, unsigned long *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
@@ -513,7 +512,6 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 392b0b3..a48509f 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -5,7 +5,6 @@
 #include <linux/badblocks.h>
 #include <linux/memremap.h>
 #include <linux/types.h>
-#include <linux/pfn_t.h>
 #include <linux/fs.h>
 
 enum dax_access_mode;
@@ -16,7 +15,6 @@ struct pmem_device {
 	phys_addr_t		phys_addr;
 	/* when non-zero this device is hosting a 'pfn' instance */
 	phys_addr_t		data_offset;
-	u64			pfn_flags;
 	void			*virt_addr;
 	/* immutable base size of the namespace */
 	size_t			size;
@@ -31,7 +29,7 @@ struct pmem_device {
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
 static inline bool test_and_clear_pmem_poison(struct page *page)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 249ae40..94fa5ed 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -17,7 +17,6 @@
 #include <linux/blkdev.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
-#include <linux/pfn_t.h>
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/io.h>
@@ -33,7 +32,7 @@ static void dcssblk_release(struct gendisk *disk);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 
 static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
 
@@ -914,7 +913,7 @@ dcssblk_submit_bio(struct bio *bio)
 
 static long
 __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, void **kaddr, unsigned long *pfn)
 {
 	resource_size_t offset = pgoff * PAGE_SIZE;
 	unsigned long dev_sz;
@@ -923,7 +922,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
-		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset), 0);
+		*pfn = PFN_DOWN(dev_info->start + offset);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
@@ -931,7 +930,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 static long
 dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f2ad5f..31bdb91 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -20,7 +20,6 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
-#include <linux/pfn_t.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1669,12 +1668,12 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 		break;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	case PMD_ORDER:
-		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn, 0), false);
+		ret = vmf_insert_pfn_pmd(vmf, pfn, false);
 		break;
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
 	case PUD_ORDER:
-		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn, 0), false);
+		ret = vmf_insert_pfn_pud(vmf, pfn, false);
 		break;
 #endif
 	default:
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 820a664..b002e9b 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -17,7 +17,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
-#include <linux/pfn_t.h>
 #include <linux/ramfs.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -412,8 +411,8 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		for (i = 0; i < pages && !ret; i++) {
 			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
-			pfn_t pfn = phys_to_pfn_t(address + off, 0);
-			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
+			vmf = vmf_insert_mixed(vma, vma->vm_start + off,
+					address + off);
 			if (vmf & VM_FAULT_ERROR)
 				ret = vm_fault_to_errno(vmf, 0);
 		}
diff --git a/fs/dax.c b/fs/dax.c
index f4ffb69..4229513 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -20,7 +20,6 @@
 #include <linux/sched/signal.h>
 #include <linux/uio.h>
 #include <linux/vmstat.h>
-#include <linux/pfn_t.h>
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
@@ -76,9 +75,9 @@ static struct folio *dax_to_folio(void *entry)
 	return page_folio(pfn_to_page(dax_to_pfn(entry)));
 }
 
-static void *dax_make_entry(pfn_t pfn, unsigned long flags)
+static void *dax_make_entry(unsigned long pfn, unsigned long flags)
 {
-	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
+	return xa_mk_value(flags | (pfn << DAX_SHIFT));
 }
 
 static bool dax_is_locked(void *entry)
@@ -713,7 +712,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 
 		if (order > 0)
 			flags |= DAX_PMD;
-		entry = dax_make_entry(pfn_to_pfn_t(0), flags);
+		entry = dax_make_entry(0, flags);
 		dax_lock_entry(xas, entry);
 		if (xas_error(xas))
 			goto out_unlock;
@@ -1041,7 +1040,7 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
  * appropriate.
  */
 static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap_iter *iter, void *entry, pfn_t pfn,
+		const struct iomap_iter *iter, void *entry, unsigned long pfn,
 		unsigned long flags)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -1239,7 +1238,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
 static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
-		size_t size, void **kaddr, pfn_t *pfnp)
+		size_t size, void **kaddr, unsigned long *pfnp)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	int id, rc = 0;
@@ -1257,7 +1256,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 	rc = -EINVAL;
 	if (PFN_PHYS(length) < size)
 		goto out;
-	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
+	if (*pfnp & (PHYS_PFN(size)-1))
 		goto out;
 
 	rc = 0;
@@ -1361,12 +1360,12 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 {
 	struct inode *inode = iter->inode;
 	unsigned long vaddr = vmf->address;
-	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
+	unsigned long pfn = my_zero_pfn(vaddr);
 	vm_fault_t ret;
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), false);
+	ret = vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn), false);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1383,14 +1382,14 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	struct folio *zero_folio;
 	spinlock_t *ptl;
 	pmd_t pmd_entry;
-	pfn_t pfn;
+	unsigned long pfn;
 
 	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
 
 	if (unlikely(!zero_folio))
 		goto fallback;
 
-	pfn = page_to_pfn_t(&zero_folio->page);
+	pfn = page_to_pfn(&zero_folio->page);
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
 				  DAX_PMD | DAX_ZERO_PAGE);
 
@@ -1779,7 +1778,8 @@ static vm_fault_t dax_fault_return(int error)
  * insertion for now and return the pfn so that caller can insert it after the
  * fsync is done.
  */
-static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
+static vm_fault_t dax_fault_synchronous_pfnp(unsigned long *pfnp,
+					unsigned long pfn)
 {
 	if (WARN_ON_ONCE(!pfnp))
 		return VM_FAULT_SIGBUS;
@@ -1827,7 +1827,7 @@ static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
  * @pmd:	distinguish whether it is a pmd fault
  */
 static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
-		const struct iomap_iter *iter, pfn_t *pfnp,
+		const struct iomap_iter *iter, unsigned long *pfnp,
 		struct xa_state *xas, void **entry, bool pmd)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -1838,7 +1838,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	struct folio *folio;
 	int ret, err = 0;
-	pfn_t pfn;
+	unsigned long pfn;
 	void *kaddr;
 
 	if (!pmd && vmf->cow_page)
@@ -1875,16 +1875,15 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 
 	folio_ref_inc(folio);
 	if (pmd)
-		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)),
-					write);
+		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn), write);
 	else
-		ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), write);
+		ret = vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn), write);
 	folio_put(folio);
 
 	return ret;
 }
 
-static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       int *iomap_errp, const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -1996,7 +1995,7 @@ static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
 	return false;
 }
 
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -2077,7 +2076,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	return ret;
 }
 #else
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       const struct iomap_ops *ops)
 {
 	return VM_FAULT_FALLBACK;
@@ -2098,7 +2097,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
  * successfully.
  */
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *iomap_errp, const struct iomap_ops *ops)
+			unsigned long *pfnp, int *iomap_errp,
+			const struct iomap_ops *ops)
 {
 	if (order == 0)
 		return dax_iomap_pte_fault(vmf, pfnp, iomap_errp, ops);
@@ -2118,8 +2118,8 @@ EXPORT_SYMBOL_GPL(dax_iomap_fault);
  * This function inserts a writeable PTE or PMD entry into the page tables
  * for an mmaped DAX file.  It also marks the page cache entry as dirty.
  */
-static vm_fault_t
-dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
+static vm_fault_t dax_insert_pfn_mkwrite(struct vm_fault *vmf,
+					unsigned long pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
@@ -2141,7 +2141,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
-	folio = pfn_folio(pfn_t_to_pfn(pfn));
+	folio = pfn_folio(pfn);
 	folio_ref_inc(folio);
 	if (order == 0)
 		ret = vmf_insert_page_mkwrite(vmf, &folio->page, true);
@@ -2168,7 +2168,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
  * table entry.
  */
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf, unsigned int order,
-		pfn_t pfn)
+		unsigned long pfn)
 {
 	int err;
 	loff_t start = ((loff_t)vmf->pgoff) << PAGE_SHIFT;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 21df813..e6e9629 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -747,7 +747,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
 		(vmf->vma->vm_flags & VM_SHARED);
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	pfn_t pfn;
+	unsigned long pfn;
 
 	if (write) {
 		sb_start_pagefault(sb);
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 0502bf3..ac6d4c1 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -10,7 +10,6 @@
 #include <linux/dax.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
-#include <linux/pfn_t.h>
 #include <linux/iomap.h>
 #include <linux/interval_tree.h>
 
@@ -757,7 +756,7 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf, unsigned int order,
 	vm_fault_t ret;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct super_block *sb = inode->i_sb;
-	pfn_t pfn;
+	unsigned long pfn;
 	int error = 0;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_conn_dax *fcd = fc->dax;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 53c2626..aac914b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -9,7 +9,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/group_cpus.h>
-#include <linux/pfn_t.h>
 #include <linux/memremap.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
@@ -1008,7 +1007,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 				    long nr_pages, enum dax_access_mode mode,
-				    void **kaddr, pfn_t *pfn)
+				    void **kaddr, unsigned long *pfn)
 {
 	struct virtio_fs *fs = dax_get_private(dax_dev);
 	phys_addr_t offset = PFN_PHYS(pgoff);
@@ -1017,7 +1016,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
+		*pfn = fs->window_phys_addr + offset;
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 48254a7..0b2db25 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1729,7 +1729,7 @@ xfs_dax_fault_locked(
 	bool			write_fault)
 {
 	vm_fault_t		ret;
-	pfn_t			pfn;
+	unsigned long		pfn;
 
 	if (!IS_ENABLED(CONFIG_FS_DAX)) {
 		ASSERT(0);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index dcc9fcd..29eec75 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -26,7 +26,7 @@ struct dax_operations {
 	 * number of pages available for DAX at that pfn.
 	 */
 	long (*direct_access)(struct dax_device *, pgoff_t, long,
-			enum dax_access_mode, void **, pfn_t *);
+			enum dax_access_mode, void **, unsigned long *);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 	/*
@@ -241,7 +241,7 @@ static inline void dax_break_layout_final(struct inode *inode)
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		enum dax_access_mode mode, void **kaddr, pfn_t *pfn);
+		enum dax_access_mode mode, void **kaddr, unsigned long *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
@@ -255,9 +255,10 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
+			unsigned long *pfnp, int *errp,
+			const struct iomap_ops *ops);
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
-		unsigned int order, pfn_t pfn);
+		unsigned int order, unsigned long pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 void dax_delete_mapping_range(struct address_space *mapping,
 				loff_t start, loff_t end);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index cb95951..84fdc3a 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -156,7 +156,7 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  */
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode node, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 21b3f0b..35e34e6 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -37,8 +37,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
 
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
+			      bool write);
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
+			      bool write);
 vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 				bool write);
 vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c2f760..98a6069 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3527,9 +3527,9 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn);
+			unsigned long pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn);
+		unsigned long addr, unsigned long pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
 
 static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
diff --git a/include/linux/pfn.h b/include/linux/pfn.h
index 14bc053..b90ca0b 100644
--- a/include/linux/pfn.h
+++ b/include/linux/pfn.h
@@ -4,15 +4,6 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
-
-/*
- * pfn_t: encapsulates a page-frame number that is optionally backed
- * by memmap (struct page).  Whether a pfn_t has a 'struct page'
- * backing is indicated by flags in the high bits of the value.
- */
-typedef struct {
-	u64 val;
-} pfn_t;
 #endif
 
 #define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
deleted file mode 100644
index 2c00293..0000000
--- a/include/linux/pfn_t.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_PFN_T_H_
-#define _LINUX_PFN_T_H_
-#include <linux/mm.h>
-
-/*
- * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
- */
-#define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-
-#define PFN_FLAGS_TRACE \
-	{ }
-
-static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
-{
-	pfn_t pfn_t = { .val = pfn | (flags & PFN_FLAGS_MASK), };
-
-	return pfn_t;
-}
-
-/* a default pfn to pfn_t conversion assumes that @pfn is pfn_valid() */
-static inline pfn_t pfn_to_pfn_t(unsigned long pfn)
-{
-	return __pfn_to_pfn_t(pfn, 0);
-}
-
-static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
-{
-	return __pfn_to_pfn_t(addr >> PAGE_SHIFT, flags);
-}
-
-static inline bool pfn_t_has_page(pfn_t pfn)
-{
-	return true;
-}
-
-static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
-{
-	return pfn.val & ~PFN_FLAGS_MASK;
-}
-
-static inline struct page *pfn_t_to_page(pfn_t pfn)
-{
-	if (pfn_t_has_page(pfn))
-		return pfn_to_page(pfn_t_to_pfn(pfn));
-	return NULL;
-}
-
-static inline phys_addr_t pfn_t_to_phys(pfn_t pfn)
-{
-	return PFN_PHYS(pfn_t_to_pfn(pfn));
-}
-
-static inline pfn_t page_to_pfn_t(struct page *page)
-{
-	return pfn_to_pfn_t(page_to_pfn(page));
-}
-
-static inline int pfn_t_valid(pfn_t pfn)
-{
-	return pfn_valid(pfn_t_to_pfn(pfn));
-}
-
-#ifdef CONFIG_MMU
-static inline pte_t pfn_t_pte(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pte(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline pmd_t pfn_t_pmd(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pmd(pfn_t_to_pfn(pfn), pgprot);
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pud(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-#endif
-
-#endif /* _LINUX_PFN_T_H_ */
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index d84d0c4..bd8f931 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -20,7 +20,6 @@
 #include <linux/mman.h>
 #include <linux/mm_types.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include <linux/printk.h>
 #include <linux/pgtable.h>
 #include <linux/random.h>
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 642fd83..d9a76e7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -22,7 +22,6 @@
 #include <linux/mm_types.h>
 #include <linux/khugepaged.h>
 #include <linux/freezer.h>
-#include <linux/pfn_t.h>
 #include <linux/mman.h>
 #include <linux/memremap.h>
 #include <linux/pagemap.h>
@@ -1375,7 +1374,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 struct folio_or_pfn {
 	union {
 		struct folio *folio;
-		pfn_t pfn;
+		unsigned long pfn;
 	};
 	bool is_folio;
 };
@@ -1391,7 +1390,7 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (!pmd_none(*pmd)) {
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
-					  pfn_t_to_pfn(fop.pfn);
+					  fop.pfn;
 
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn) {
@@ -1414,7 +1413,7 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
 	} else {
-		entry = pmd_mkhuge(pfn_t_pmd(fop.pfn, prot));
+		entry = pmd_mkhuge(pfn_pmd(fop.pfn, prot));
 		entry = pmd_mkspecial(entry);
 	}
 	if (write) {
@@ -1442,7 +1441,8 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
+			      bool write)
 {
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1473,7 +1473,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 			return VM_FAULT_OOM;
 	}
 
-	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
+	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
 	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	error = insert_pmd(vma, addr, vmf->pmd, fop, pgprot, write,
@@ -1539,7 +1539,7 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
 
 	if (!pud_none(*pud)) {
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
-					  pfn_t_to_pfn(fop.pfn);
+					  fop.pfn;
 
 		if (write) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
@@ -1559,7 +1559,7 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		folio_add_file_rmap_pud(fop.folio, &fop.folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PUD_NR);
 	} else {
-		entry = pud_mkhuge(pfn_t_pud(fop.pfn, prot));
+		entry = pud_mkhuge(pfn_pud(fop.pfn, prot));
 		entry = pud_mkspecial(entry);
 	}
 	if (write) {
@@ -1580,7 +1580,8 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
+			      bool write)
 {
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1603,7 +1604,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
+	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
 	ptl = pud_lock(vma->vm_mm, vmf->pud);
 	insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
diff --git a/mm/memory.c b/mm/memory.c
index f1d81ad..0163d12 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -57,7 +57,6 @@
 #include <linux/export.h>
 #include <linux/delayacct.h>
 #include <linux/init.h>
-#include <linux/pfn_t.h>
 #include <linux/writeback.h>
 #include <linux/memcontrol.h>
 #include <linux/mmu_notifier.h>
@@ -2435,7 +2434,7 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 EXPORT_SYMBOL(vm_map_pages_zero);
 
 static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn, pgprot_t prot, bool mkwrite)
+			unsigned long pfn, pgprot_t prot, bool mkwrite)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, entry;
@@ -2457,7 +2456,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			 * allocation and mapping invalidation so just skip the
 			 * update.
 			 */
-			if (pte_pfn(entry) != pfn_t_to_pfn(pfn)) {
+			if (pte_pfn(entry) != pfn) {
 				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
 				goto out_unlock;
 			}
@@ -2470,7 +2469,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	/* Ok, finally just insert the thing.. */
-	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_pte(pfn, prot));
 
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
@@ -2541,8 +2540,7 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, 0), pgprot,
-			false);
+	return insert_pfn(vma, addr, pfn, pgprot, false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
@@ -2573,21 +2571,22 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_pfn);
 
-static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
+static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn,
+			bool mkwrite)
 {
-	if (unlikely(is_zero_pfn(pfn_t_to_pfn(pfn))) &&
+	if (unlikely(is_zero_pfn(pfn)) &&
 	    (mkwrite || !vm_mixed_zeropage_allowed(vma)))
 		return false;
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
+	if (is_zero_pfn(pfn))
 		return true;
 	return false;
 }
 
 static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn, bool mkwrite)
+		unsigned long addr, unsigned long pfn, bool mkwrite)
 {
 	pgprot_t pgprot = vma->vm_page_prot;
 	int err;
@@ -2598,9 +2597,9 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
+	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
+	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
 	/*
@@ -2610,7 +2609,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_valid(pfn)) {
 		struct page *page;
 
 		/*
@@ -2618,7 +2617,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * regardless of whether the caller specified flags that
 		 * result in pfn_t_has_page() == false.
 		 */
-		page = pfn_to_page(pfn_t_to_pfn(pfn));
+		page = pfn_to_page(pfn);
 		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
@@ -2653,7 +2652,7 @@ vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
 EXPORT_SYMBOL_GPL(vmf_insert_page_mkwrite);
 
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-		pfn_t pfn)
+		unsigned long pfn)
 {
 	return __vm_insert_mixed(vma, addr, pfn, false);
 }
@@ -2665,7 +2664,7 @@ EXPORT_SYMBOL(vmf_insert_mixed);
  *  the same entry was actually inserted.
  */
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn)
+		unsigned long addr, unsigned long pfn)
 {
 	return __vm_insert_mixed(vma, addr, pfn, true);
 }
diff --git a/mm/memremap.c b/mm/memremap.c
index c17e0a6..044a455 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -5,7 +5,6 @@
 #include <linux/kasan.h>
 #include <linux/memory_hotplug.h>
 #include <linux/memremap.h>
-#include <linux/pfn_t.h>
 #include <linux/swap.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
diff --git a/mm/migrate.c b/mm/migrate.c
index 8cf0f9c..ea8c74d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -35,7 +35,6 @@
 #include <linux/compat.h>
 #include <linux/hugetlb.h>
 #include <linux/gfp.h>
-#include <linux/pfn_t.h>
 #include <linux/page_idle.h>
 #include <linux/page_owner.h>
 #include <linux/sched/mm.h>
diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index c1ec099..05e763a 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -10,7 +10,7 @@
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
@@ -29,7 +29,7 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 			*kaddr = pmem->virt_addr + offset;
 		page = vmalloc_to_page(pmem->virt_addr + offset);
 		if (pfn)
-			*pfn = page_to_pfn_t(page);
+			*pfn = page_to_pfn(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
 				__func__, pmem, pgoff, page_to_pfn(page));
 
@@ -39,7 +39,7 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = pmem->virt_addr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		*pfn = PHYS_PFN(pmem->phys_addr + offset);
 
 	/*
 	 * If badblocks are present, limit known good range to the
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index ddceb04..f7e7bfe 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -8,7 +8,6 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/types.h>
-#include <linux/pfn_t.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -135,12 +134,6 @@ void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 }
 EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
 
-pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
-{
-        return phys_to_pfn_t(addr, flags);
-}
-EXPORT_SYMBOL(__wrap_phys_to_pfn_t);
-
 void *__wrap_memremap(resource_size_t offset, size_t size,
 		unsigned long flags)
 {
diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
index b00583d..b9047fb 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -212,7 +212,6 @@ void __iomem *__wrap_devm_ioremap(struct device *dev,
 void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
 		size_t size, unsigned long flags);
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
-pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags);
 void *__wrap_memremap(resource_size_t offset, size_t size,
 		unsigned long flags);
 void __wrap_devm_memunmap(struct device *dev, void *addr);
-- 
git-series 0.9.1


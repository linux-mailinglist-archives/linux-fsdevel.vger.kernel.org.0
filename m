Return-Path: <linux-fsdevel+bounces-35533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CC09D57C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99076B23CB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD621DF748;
	Fri, 22 Nov 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eh75kw0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B457168483;
	Fri, 22 Nov 2024 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239791; cv=fail; b=NFxpojHL1rS2ncoOtb+AGu1LXNUUmjqU4+083QgV3cHxSnziT7nCx4dJ4KKHo6MijcXd8LjW2yF2NP/S6YgRsuAIe2LVIeTkJS523UE0zsyR/GDQ/x8X1WXb0ukjRvdXxM1dan9FoIHZnDgVrSz1P1DuvmMk8enBmTGVtu9UfV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239791; c=relaxed/simple;
	bh=EbBLhX82VnDygAgn7lcB/AlEHQk5g0SDfbY9SI6srvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kl1f2MRJ9kJ5GhJTMiRPW1Sr9rRfAPatkJySjfKzD1eGY0sGF1IDEzWFWOOxxX/alls3U1LZi2eXzH3/yPyYMDwZlJzJrSd8TkY8YA/wiw+DKH9h/L8dsa2sxb9sojrJDVK5JSMcOR4ijXu+0WLGWERTAXYLayLWfFuaZDIyKqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eh75kw0W; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnoYf/B/xkIv1ENLsqgtDwJCqT3+eZ3tStkQGSDZDpzlk7ODBryvUJds2R2byoZwhOftLFYfouDTJVGeEZ47vNmbff0yCOnIZWjZ29n5CokPUtu7iAhwdufh/QTAe+FvSP5P2pFkWWW/KF06gl3aQm8XRxXufadL+uL6Zgwv7xa4yzDwtQivZetSIJqEyrh+iAleNBtgMAc6Io+lSuGClshFomZJm/tlXEUKK6tPoZ8i1bV0dYmNXDZIgDXDFKOvN27m27T9+E/YjA1Q6yLPneYOcb6RgRIa4TcGTKW+DQfPV0QDwrelYSjMowjAgRlwIA/akQV6GNqzRXMALLhkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ03nN5uTvXFVD/nas8UfoAyyB+o+5aCpG21hhkqAN4=;
 b=gMBiIBbAJC5ZqPQS2dK4K4DNDeFFbqtItjUcRFSLWHuVmE27NVotlsfzqXkMMNfqsgJeZxMw8U7U9gn/AKTMZfoLMtHqXWo6Sk0DYSqz10zGSKm6Go+2vIJInrs7HuNVvbjcLIRb3YAZi5o7MZBXYTQHl7gzLvKcEJdQH9J5U0FnNmOpMzE2qtqgmA8cvfctWounVvzEoX8NvZGSqWWwRyQgJRGM0A7fVkibzwepL4hZmEvAEPjJiMAWwYByZE4QxaU4KnWG4CRIZYLk/h+J3j+NHWg81z7CR5ioTcXop+1s/Hr+V1SU8UaOiG1AxEVYeH64WshgUAt9JKPtfceSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ03nN5uTvXFVD/nas8UfoAyyB+o+5aCpG21hhkqAN4=;
 b=eh75kw0Wj/Q7j9AHfYCgUT57lCYNi+8IJP0sYdjFg9BuzBAar9yoF/Mx65MsTV2j/wC87yLZ5mh/13/ubq9hrWr1JC2NcU78rnRPsWx+UYenGn8a+S0JfX2R9oF48dktISQAl5h6NSuen4450WtwHwIvUPVU+R8cRnh7mtEvFN6J1PBqiXjHzaPf8z1dXlvPCBgsAHYmc3h5fHmvCBEz8FX2uyKuGL0XFi9VD14zxYnnuG9pWHcCdUaDgo5QvDgo9tjUpHqCI1XH17JWs/FsyZfCf2TAW4TVrRDtat5Sf7Np6kvqzok9Cn9uB6gZt4NkdmJagCp2qEsFGAulZhzfIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 01:43:05 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:43:04 +0000
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
Subject: [PATCH v3 24/25] mm: Remove devmap related functions and page table bits
Date: Fri, 22 Nov 2024 12:40:45 +1100
Message-ID: <4c978d98e9082062e3d6d1195630501a62ee1d6a.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0002.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f97d95-fdf3-40ea-9517-08dd0a9701ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WsiKLD6+0uJ+7RWxqdG38d34iPTHvR2DjjGfNoVopCof1B+YfiCSNBUIPLWa?=
 =?us-ascii?Q?7mdVmiAo3uyPuNNHs6Yg+i0AC6yiZ6bCDwRzVb/NRK1ITzaMorIz3z2nhlhE?=
 =?us-ascii?Q?4N+FhLxiLTKg8l+FF26F6eT0cq4yXnHeg/xjS4+L3WLNcEYZqxC4yP4fGhB5?=
 =?us-ascii?Q?+mW8Qb0H4Rj6XRG98MzCe7dUInjlUu2uPfhG+6GVK7wJiwrGCn5cnM/RDA8x?=
 =?us-ascii?Q?VjFiXzesdp2UgVuB+u3LZl1ojas7mu2SGB+CXU9Ste7Qx5LqnuTiVnrMKLQG?=
 =?us-ascii?Q?N0dIyRxw1uLLiUAMWV5kRo2uw2JWHKkb0xjq4AyohH9zeXRRfwwk6L4sm4Vp?=
 =?us-ascii?Q?nXBULngtdv7Q3KqQLyWPA/JffvQwBuxFiTh6LkC5Fm049OtBkhGziF1WuaWu?=
 =?us-ascii?Q?e4yB0pcU2N+bjYuIC862hWfPH9IwpuYntB12Q1PC/7I5qbtFBhWkQZlwi3e+?=
 =?us-ascii?Q?e03WPrHUQugzyQl9BRZ4sCiFl5O0zrzmsIlm1gw5svCADEbR7Mg+Op/xl/W3?=
 =?us-ascii?Q?3D5Tjjrj/a4oyZPwt8Gteg1TE6aArD7bWqXJkoXQtRJrYggpG+gWjbV847Ts?=
 =?us-ascii?Q?jXquuEDf1Otv5mDtQR5k3Y/mNPtL3QwqqdRrFg6QgmlRdkdGXVd5HGbCbwgp?=
 =?us-ascii?Q?JarwGq1CSp90QHL/wkJoh19/k7nxIzRLtgTK+EhcfgONbq5ghCIRTrx8kvux?=
 =?us-ascii?Q?2UlsVoWtuu45x60uCRXjsdge5BMKcfvSbEQoEaVt/9rz2QW0CfcOGH5mKuQW?=
 =?us-ascii?Q?LPih4mddEUYLiQeQprJocTl0LX3OXO8KvO4Lslgb9eizkL0zYu2bXl+P9X4P?=
 =?us-ascii?Q?XpRcMdWB+4tMuduy0FSJHhSo082khIeB9a3k83nRiUEVs/3+nO9h/hFuqcqS?=
 =?us-ascii?Q?DP3guKyNIuRU/+v3x54Vptirc+iTwvbKruMsoS2DmTqsZ1Kczpxa9P9HgQvb?=
 =?us-ascii?Q?5Qc5JF3+HMt4o7XQCCp/St3NE6hOQGFSlGJ1I175UTe2MtZTtIgeaByoulb0?=
 =?us-ascii?Q?mAPTbkHxzjoJD5YSRtdjJAYxKkpDavVLkyR5uVI6GoGq84Qr9CY9Oylg0qM2?=
 =?us-ascii?Q?pRpouE4/AdNljT36yiTCOeuCHwgQgO1l81xYkon1C4I/mr6ZUnBxnSqUDmnr?=
 =?us-ascii?Q?1EC0DDT6nTsPEuM3RqAOIUWT1pdsGli9Awk4fffujBpN8Wo/0u1nd5ud6nrB?=
 =?us-ascii?Q?dJSPtIpsp53tJdYQjE2Oy9bWIWV/JfWFwOy3+gXPSyeZoT70/qjIlRZm3V8K?=
 =?us-ascii?Q?zZ4JHjvFWZv6wme0CYHTK1aO7UktZJyNHpR2llyVFnkMlMXI8omceVJJNNAo?=
 =?us-ascii?Q?8vQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0nDgjCJlptlfr8LdZrtPHKX9dabqksp6Zm0q3uqPyE6dgpVwb66OjLQCOwIo?=
 =?us-ascii?Q?QGIa+ZWP3RwQbNccy1zTRwlCQ+iaSaf/8f8GergF7IR9T2f2/oKNsmpCRUVi?=
 =?us-ascii?Q?GT8x9Yh5apq5HQhrx8MUBQkCelXHolTWUS2sSSFx8HlAzpGXHoNY6szHJmbS?=
 =?us-ascii?Q?UCg8LpVxbsnp+Fzy6PJeOp9R9lz7WmXuxhs6v2JKJrAQ743dFfyaj6n/cEog?=
 =?us-ascii?Q?TT0ODVDwL/XaWd027GDHcGIF7mkOTB6gxKuumyrT/cInMxJYW8ZBba9zqB3p?=
 =?us-ascii?Q?M/d36QhrENtUXMp3L65j4hdqMwbHqXUj8HhEbRgVDUsqwfkBapgYDDKWZTzd?=
 =?us-ascii?Q?A59EpWbFiLZTyuGetDgndXQ2VwMmRR3ZR433YjTG/EpmQ1NbQytTLhv/1tj9?=
 =?us-ascii?Q?FpmTzFOQb/koQ8W6QA493FML+mh6H5aHLYGRWGEglM/siY/4lcJw8YhkLflE?=
 =?us-ascii?Q?9IwBmpkjNd6TMAyya6hFugSAg09GsuxPLMTDK/dAy+W998s0KbIW3DYjxpc1?=
 =?us-ascii?Q?F8HmaO67XES0AgOhy75D6HmaLIXzvTucTE1DgzXKCcnhCuAEuuYoS9nfS8QW?=
 =?us-ascii?Q?uZcNoB9HKjlVZ7SGvbaBx5dwJHXKCUk+ZSBDl8ojaQMS9QbhXXMlcdU5S11k?=
 =?us-ascii?Q?wVQdALWvA0w/Rz45xjg1On7v834p3jypU82VxPFcjUjXpdUIjDTRaGUDV4yh?=
 =?us-ascii?Q?/9V2nEYLPDUNS7uJHgV4i6xmbLwyxt2CBB8Jf6HVVS8e2lsnkHSpEWLWauYm?=
 =?us-ascii?Q?95T168y9CjMZ908OSgl6ISGS9BwRn57zhVzwg3DxphKKXC7GjHHWyjMhQrKe?=
 =?us-ascii?Q?ABg7VO4c40N3MQIpYCxOCwtCwUrjy0MMAe9TE/J8m+2MSWxRiTXcEWHatX+T?=
 =?us-ascii?Q?FSMsD1azlWC9xgpAAkXxCbZZDdHBB0VLY0u77J+juGtNac8xUzPUCz5bGG12?=
 =?us-ascii?Q?CTSLhz4Nmt7XyxiyT7Pdi5p0r+kzByFcBzTo4QR+T4h2RhbOEnJyiB270NwZ?=
 =?us-ascii?Q?qvn7aS2GKA5+Nqx+XXdGnOHZlCJoQv1up6i0kH8dC72spUAQrO8/YFhShHp2?=
 =?us-ascii?Q?TZ6jJpVAm2BJvr1WIVMf+NV3gS2qusc3S8K7B3NOXMTc8OjlG18D+y2as5T+?=
 =?us-ascii?Q?uIKM/SqfRocT7SSNn9bKUFHoNvMBC94dy+zG0ixMFTnVljjB8DVhU0Wpbeb0?=
 =?us-ascii?Q?lhvo7Y7i6QtB1aa0ojcAonfYMaQqgwVWN/3qyVrC4ikAp2VAS4+sOt4GCnBl?=
 =?us-ascii?Q?3PuWzJjjamIypKtaNHs282lSFB/4vlJWJLwNFU28/d3YBCq66kE+0QdZ9uJg?=
 =?us-ascii?Q?RuWZtf9Q2Rznyhj9e+gmHM08ZFwm+7Uvvygp3+RQyyHcDaQEH0A25lXc9DKA?=
 =?us-ascii?Q?/mJqxwzUPOWinuw0xr26LsmDY9V1N0t52YWomQR5G9zcXnpoFp/qfLuUkilG?=
 =?us-ascii?Q?dpuCnrlJsWwXjxlgPxZ8LUnyVh6P2yvOup1IdmDfwvaxztL8nb87hHURkHAI?=
 =?us-ascii?Q?3baEWcmeaWTYXvCYzS406ByExw9Egfhpm2mWZrdyfm2oKMHRqxHyqPyagsXL?=
 =?us-ascii?Q?RlcybfounB8HkV3HS+xfv9L0FWbBOoZ3bv+YkJ77?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f97d95-fdf3-40ea-9517-08dd0a9701ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:43:04.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BDpavGxlHHDL7Ricjy8e6GUn5Rfxe0yAHc9exGMqGzwfXTCAHoO/54aMN4RIY5WSkr7DYXP/amAxdKCfCWOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

Now that DAX and all other reference counts to ZONE_DEVICE pages are
managed normally there is no need for the special devmap PTE/PMD/PUD
page table bits. So drop all references to these, freeing up a
software defined page table bit on architectures supporting it.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Will Deacon <will@kernel.org> # arm64
---
 Documentation/mm/arch_pgtable_helpers.rst     |  6 +--
 arch/arm64/Kconfig                            |  1 +-
 arch/arm64/include/asm/pgtable-prot.h         |  1 +-
 arch/arm64/include/asm/pgtable.h              | 24 +--------
 arch/powerpc/Kconfig                          |  1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  6 +--
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  7 +--
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 52 +------------------
 arch/powerpc/include/asm/book3s/64/radix.h    | 14 +-----
 arch/x86/Kconfig                              |  1 +-
 arch/x86/include/asm/pgtable.h                | 51 +-----------------
 arch/x86/include/asm/pgtable_types.h          |  5 +--
 include/linux/mm.h                            |  7 +--
 include/linux/pfn_t.h                         | 20 +-------
 include/linux/pgtable.h                       | 19 +------
 mm/Kconfig                                    |  4 +-
 mm/debug_vm_pgtable.c                         | 59 +--------------------
 mm/hmm.c                                      |  3 +-
 18 files changed, 11 insertions(+), 270 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index af24516..c88c7fa 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -30,8 +30,6 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_protnone              | Tests a PROT_NONE PTE                            |
 +---------------------------+--------------------------------------------------+
-| pte_devmap                | Tests a ZONE_DEVICE mapped PTE                   |
-+---------------------------+--------------------------------------------------+
 | pte_soft_dirty            | Tests a soft dirty PTE                           |
 +---------------------------+--------------------------------------------------+
 | pte_swp_soft_dirty        | Tests a soft dirty swapped PTE                   |
@@ -104,8 +102,6 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_protnone              | Tests a PROT_NONE PMD                            |
 +---------------------------+--------------------------------------------------+
-| pmd_devmap                | Tests a ZONE_DEVICE mapped PMD                   |
-+---------------------------+--------------------------------------------------+
 | pmd_soft_dirty            | Tests a soft dirty PMD                           |
 +---------------------------+--------------------------------------------------+
 | pmd_swp_soft_dirty        | Tests a soft dirty swapped PMD                   |
@@ -177,8 +173,6 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_write                 | Tests a writable PUD                             |
 +---------------------------+--------------------------------------------------+
-| pud_devmap                | Tests a ZONE_DEVICE mapped PUD                   |
-+---------------------------+--------------------------------------------------+
 | pud_mkyoung               | Creates a young PUD                              |
 +---------------------------+--------------------------------------------------+
 | pud_mkold                 | Creates an old PUD                               |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd9df6d..1d90ab9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,7 +38,6 @@ config ARM64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
-	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_SETUP_DMA_OPS
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2a11d0c..f7e12d6 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -17,7 +17,6 @@
 #define PTE_SWP_EXCLUSIVE	(_AT(pteval_t, 1) << 2)	 /* only for swp ptes */
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
-#define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 
 /*
  * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c329ea0..07a252b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -108,7 +108,6 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_user(pte)		(!!(pte_val(pte) & PTE_USER))
 #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
 #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
-#define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
 #define pte_tagged(pte)		((pte_val(pte) & PTE_ATTRINDX_MASK) == \
 				 PTE_ATTRINDX(MT_NORMAL_TAGGED))
 
@@ -291,11 +290,6 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
-}
-
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
@@ -593,14 +587,6 @@ static inline int pmd_trans_huge(pmd_t pmd)
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
-#endif
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
-}
-
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 #define pmd_special(pte)	(!!((pmd_val(pte) & PTE_SPECIAL)))
 static inline pmd_t pmd_mkspecial(pmd_t pmd)
@@ -1190,16 +1176,6 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 	return __ptep_set_access_flags(vma, address, (pte_t *)pmdp,
 							pmd_pte(entry), dirty);
 }
-
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PAGE_TABLE_CHECK
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8094a01..c50136f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -145,7 +145,6 @@ config PPC
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API
-	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index c3efaca..b0546d3 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -160,12 +160,6 @@ extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 extern int hash__has_transparent_hugepage(void);
 #endif
 
-static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
-{
-	BUG();
-	return pmd;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0bf6fd0..0fb5b7d 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -259,7 +259,7 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
  */
 static inline int hash__pmd_trans_huge(pmd_t pmd)
 {
-	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DEVMAP)) ==
+	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) ==
 		  (_PAGE_PTE | H_PAGE_THP_HUGE));
 }
 
@@ -281,11 +281,6 @@ extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 extern int hash__has_transparent_hugepage(void);
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline pmd_t hash__pmd_mkdevmap(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) | (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DEVMAP));
-}
-
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6d98e6f..bda0649 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -88,7 +88,6 @@
 
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
-#define _PAGE_DEVMAP		_RPAGE_SW1 /* software: ZONE_DEVICE page */
 
 /*
  * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
@@ -109,7 +108,7 @@
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
+			 _PAGE_SOFT_DIRTY)
 /*
  * user access blocked by key
  */
@@ -123,7 +122,7 @@
  */
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
+			 _PAGE_SOFT_DIRTY)
 
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
@@ -609,24 +608,6 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_SPECIAL | _PAGE_DEVMAP));
-}
-
-/*
- * This is potentially called with a pmd as the argument, in which case it's not
- * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is set.
- * That's because the bit we use for _PAGE_DEVMAP is not reserved for software
- * use in page directory entries (ie. non-ptes).
- */
-static inline int pte_devmap(pte_t pte)
-{
-	__be64 mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
-
-	return (pte_raw(pte) & mask) == mask;
-}
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	/* FIXME!! check whether this need to be a conditional */
@@ -1380,35 +1361,6 @@ static inline bool arch_needs_pgtable_deposit(void)
 }
 extern void serialize_against_pte_lookup(struct mm_struct *mm);
 
-
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	if (radix_enabled())
-		return radix__pmd_mkdevmap(pmd);
-	return hash__pmd_mkdevmap(pmd);
-}
-
-static inline pud_t pud_mkdevmap(pud_t pud)
-{
-	if (radix_enabled())
-		return radix__pud_mkdevmap(pud);
-	BUG();
-	return pud;
-}
-
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return pte_devmap(pmd_pte(pmd));
-}
-
-static inline int pud_devmap(pud_t pud)
-{
-	return pte_devmap(pud_pte(pud));
-}
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 8f55ff7..df23a82 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -264,7 +264,7 @@ static inline int radix__p4d_bad(p4d_t p4d)
 
 static inline int radix__pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (_PAGE_PTE | _PAGE_DEVMAP)) == _PAGE_PTE;
+	return (pmd_val(pmd) & _PAGE_PTE) == _PAGE_PTE;
 }
 
 static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
@@ -274,7 +274,7 @@ static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
 
 static inline int radix__pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PTE | _PAGE_DEVMAP)) == _PAGE_PTE;
+	return (pud_val(pud) & _PAGE_PTE) == _PAGE_PTE;
 }
 
 static inline pud_t radix__pud_mkhuge(pud_t pud)
@@ -315,16 +315,6 @@ static inline int radix__has_transparent_pud_hugepage(void)
 }
 #endif
 
-static inline pmd_t radix__pmd_mkdevmap(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) | (_PAGE_PTE | _PAGE_DEVMAP));
-}
-
-static inline pud_t radix__pud_mkdevmap(pud_t pud)
-{
-	return __pud(pud_val(pud) | (_PAGE_PTE | _PAGE_DEVMAP));
-}
-
 struct vmem_altmap;
 struct dev_pagemap;
 extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 16354df..6a1a06f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,7 +93,6 @@ config X86
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
-	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 4c2d080..23a993a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -308,16 +308,15 @@ static inline bool pmd_leaf(pmd_t pte)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_leaf */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pmd_val(pmd) & _PAGE_PSE) == _PAGE_PSE;
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline int pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pud_val(pud) & _PAGE_PSE) == _PAGE_PSE;
 }
 #endif
 
@@ -327,24 +326,6 @@ static inline int has_transparent_hugepage(void)
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_DEVMAP);
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static inline int pud_devmap(pud_t pud)
-{
-	return !!(pud_val(pud) & _PAGE_DEVMAP);
-}
-#else
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 static inline bool pmd_special(pmd_t pmd)
 {
@@ -368,12 +349,6 @@ static inline pud_t pud_mkspecial(pud_t pud)
 	return pud_set_flags(pud, _PAGE_SPECIAL);
 }
 #endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline pte_t pte_set_flags(pte_t pte, pteval_t set)
@@ -534,11 +509,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return pte_set_flags(pte, _PAGE_SPECIAL);
 }
 
-static inline pte_t pte_mkdevmap(pte_t pte)
-{
-	return pte_set_flags(pte, _PAGE_SPECIAL|_PAGE_DEVMAP);
-}
-
 /* See comments above mksaveddirty_shift() */
 static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
 {
@@ -610,11 +580,6 @@ static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_DIRTY);
 }
 
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pmd_set_flags(pmd, _PAGE_DEVMAP);
-}
-
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_PSE);
@@ -680,11 +645,6 @@ static inline pud_t pud_mkdirty(pud_t pud)
 	return pud_mksaveddirty(pud);
 }
 
-static inline pud_t pud_mkdevmap(pud_t pud)
-{
-	return pud_set_flags(pud, _PAGE_DEVMAP);
-}
-
 static inline pud_t pud_mkhuge(pud_t pud)
 {
 	return pud_set_flags(pud, _PAGE_PSE);
@@ -1012,13 +972,6 @@ static inline int pte_present(pte_t a)
 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
 }
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t a)
-{
-	return (pte_flags(a) & _PAGE_DEVMAP) == _PAGE_DEVMAP;
-}
-#endif
-
 #define pte_accessible pte_accessible
 static inline bool pte_accessible(struct mm_struct *mm, pte_t a)
 {
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 6f82e75..4a13b76 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -33,7 +33,6 @@
 #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
 #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
-#define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
 #ifdef CONFIG_X86_64
 #define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
@@ -117,11 +116,9 @@
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_NX	(_AT(pteval_t, 1) << _PAGE_BIT_NX)
-#define _PAGE_DEVMAP	(_AT(u64, 1) << _PAGE_BIT_DEVMAP)
 #define _PAGE_SOFTW4	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW4)
 #else
 #define _PAGE_NX	(_AT(pteval_t, 0))
-#define _PAGE_DEVMAP	(_AT(pteval_t, 0))
 #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
@@ -148,7 +145,7 @@
 #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	\
 				 _PAGE_SPECIAL | _PAGE_ACCESSED |	\
 				 _PAGE_DIRTY_BITS | _PAGE_SOFT_DIRTY |	\
-				 _PAGE_DEVMAP | _PAGE_CC | _PAGE_UFFD_WP)
+				 _PAGE_CC | _PAGE_UFFD_WP)
 #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
 #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 052f234..600a1a8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2692,13 +2692,6 @@ static inline pud_t pud_mkspecial(pud_t pud)
 }
 #endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
 
-#ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
-static inline int pte_devmap(pte_t pte)
-{
-	return 0;
-}
-#endif
-
 extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 			       spinlock_t **ptl);
 static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 2d91482..0100ad8 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -97,26 +97,6 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
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
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 static inline bool pfn_t_special(pfn_t pfn)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index fa661b2..9406de1 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1616,21 +1616,6 @@ static inline int pud_write(pud_t pud)
 }
 #endif /* pud_write */
 
-#if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || !defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return 0;
-}
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
-
 #if !defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
 	!defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 static inline int pud_trans_huge(pud_t pud)
@@ -1885,8 +1870,8 @@ typedef unsigned int pgtbl_mod_mask;
  * - It should contain a huge PFN, which points to a huge page larger than
  *   PAGE_SIZE of the platform.  The PFN format isn't important here.
  *
- * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
- *   pXd_devmap(), or hugetlb mappings).
+ * - It should cover all kinds of huge mappings (i.e. pXd_trans_huge()
+ *   or hugetlb mappings).
  */
 #ifndef pgd_leaf
 #define pgd_leaf(x)	false
diff --git a/mm/Kconfig b/mm/Kconfig
index 4c9f5ea..06f939b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1044,9 +1044,6 @@ config ARCH_HAS_CURRENT_STACK_POINTER
 	  register alias named "current_stack_pointer", this config can be
 	  selected.
 
-config ARCH_HAS_PTE_DEVMAP
-	bool
-
 config ARCH_HAS_ZONE_DMA_SET
 	bool
 
@@ -1064,7 +1061,6 @@ config ZONE_DEVICE
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
 	depends on SPARSEMEM_VMEMMAP
-	depends on ARCH_HAS_PTE_DEVMAP
 	select XARRAY_MULTI
 
 	help
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index bc748f7..cf5ff92 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -348,12 +348,6 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	vaddr &= HPAGE_PUD_MASK;
 
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
-	/*
-	 * Some architectures have debug checks to make sure
-	 * huge pud mapping are only found with devmap entries
-	 * For now test with only devmap entries.
-	 */
-	pud = pud_mkdevmap(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
 	pudp_set_wrprotect(args->mm, vaddr, args->pudp);
@@ -366,7 +360,6 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
-	pud = pud_mkdevmap(pud);
 	pud = pud_wrprotect(pud);
 	pud = pud_mkclean(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
@@ -384,7 +377,6 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
-	pud = pud_mkdevmap(pud);
 	pud = pud_mkyoung(pud);
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
@@ -693,53 +685,6 @@ static void __init pmd_protnone_tests(struct pgtable_debug_args *args)
 static void __init pmd_protnone_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
-static void __init pte_devmap_tests(struct pgtable_debug_args *args)
-{
-	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
-
-	pr_debug("Validating PTE devmap\n");
-	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
-}
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args)
-{
-	pmd_t pmd;
-
-	if (!has_transparent_hugepage())
-		return;
-
-	pr_debug("Validating PMD devmap\n");
-	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
-	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_devmap_tests(struct pgtable_debug_args *args)
-{
-	pud_t pud;
-
-	if (!has_transparent_pud_hugepage())
-		return;
-
-	pr_debug("Validating PUD devmap\n");
-	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
-	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
-}
-#else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-#else  /* CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-#else
-static void __init pte_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
-static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
-#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
-
 static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
@@ -1341,10 +1286,6 @@ static int __init debug_vm_pgtable(void)
 	pte_protnone_tests(&args);
 	pmd_protnone_tests(&args);
 
-	pte_devmap_tests(&args);
-	pmd_devmap_tests(&args);
-	pud_devmap_tests(&args);
-
 	pte_soft_dirty_tests(&args);
 	pmd_soft_dirty_tests(&args);
 	pte_swap_soft_dirty_tests(&args);
diff --git a/mm/hmm.c b/mm/hmm.c
index 285578e..2a12879 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -395,8 +395,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && \
-    defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+#if defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 static inline unsigned long pud_to_hmm_pfn_flags(struct hmm_range *range,
 						 pud_t pud)
 {
-- 
git-series 0.9.1


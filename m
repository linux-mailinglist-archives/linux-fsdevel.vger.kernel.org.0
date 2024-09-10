Return-Path: <linux-fsdevel+bounces-28982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96941972829
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0116E1F23122
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B5191F9F;
	Tue, 10 Sep 2024 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VAe7+ilB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58A191F9A;
	Tue, 10 Sep 2024 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941753; cv=fail; b=IqQUqTx8h7KeRU7tH/ZcE2sa+3+5x5JO/2OH/nCTQDbowF4lQnHQRGMTXAHZn0f1K+UoncfpklnI5Uncy7wA719JoRQ8LaeVyliI7JS1FaajICgNL+JjKvTIKk6waLwNAbO2U4nvfnK56Uc5fKz+KFUasbMHzksONQT8gAMbNvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941753; c=relaxed/simple;
	bh=qQZJ7LjvsCObk463rIVzaoMAPIn/bx4qdokv2exctIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bFO2Y+DcJ7y33IQOeqNA7FNmCOupN4uOCV2Fe2m3RzIKWCY1fR15igpsHRL/0/xUZIF2tQWyMMwe7Tq3lA4Fl2Wr8zTpW3mMyrMxgTcqscpAtV3sTuszRjFSnZJCzc//cxg5B9r29K4M7r4i9n+ayy2U/9wmb6O4E+vjymoJp4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VAe7+ilB; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bv1eMEtDlfpwxRmVVRQL/F4b6ik99OVq7gcdga8i1NwbY7/pqnBlROLHwIstTfKkE9mZdKXWZVj6WZwWHiSSOcEFyDcn0QRjjt7BFYo7t/oG9DwSt11JABEam8YUV7PSW5eD/SekKKEK5DT4wFyrCByqTHetANGFi0ju0F0GKiAWwh/gY5MVK+79EXQr+zM701cl02FujeVStqMjiqg8yZyhZfPKspQlQ/55uhGCJgpl8x5JTG/luozw6FjyKX0qNSDD8VIP7kBJc42LLdka8ULruWgaKZj8AE9ePcJp3W8XTn/VuC42s4fY981PGi/z9QnUNL5FPn48oJX+5E6+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxsaXxCobkebjzMmd7orGk+KwMiRdngzL78EWeSmELI=;
 b=Roqfms1SJmml2uoGOVR5j4x3kzRsilNcWvKcayddOyCS1c+xOgrut4Q20IEZCLICReAf99ArxyH+aiDrqkO3JTUOjT5Rrw6GNbMQomipCRCCi57zfiwf6C7PnapuD9KrgWlhr5KIgrQ+rQWIK88+3U4B24o0xQSvK6zl+oIG9AMFl8e8y4JwFRlsLpNKvrwmlLmw291KuBwYkdZnZ/KAtoNFf9W2sdFmB0WvioWt/f2Q5yeaPltMi7K4hrtrlR2rFlWNiZseFmHDsVY2d4lZqBO78FTzRJ1rQkHaAVnEy9k25M154vNwf4darjFLsMpodG1iSrwNXBXSODsr1ABHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxsaXxCobkebjzMmd7orGk+KwMiRdngzL78EWeSmELI=;
 b=VAe7+ilB6z7OvL2rlBsSW39Ih+m5CO1Hw8rsqyk7nI/yvyPGpOckJi8cOhdtkHagC0bPr/GrqCMqQ4dowNFHVofITf4Fp9VpXkQUFI1XhsnBDqpgpSsJ20X6dXJR+hwFcc66pfgulKk4MXqCJT4ce7P53gReScb7vI6A8+tNbUfK5Pc6A250QO0NTN4hO/E51xxIT6x6bhLlJsfq4s4ZKo/iz5n+uWwIpWy11p+2OF33Pga+Ifif8LX5fwb3Yiom2QbXzaG1o/IaWu3m5k0IikOZkUVEWDYLWhvuqsyoi9LL6KJq0pvyelrfrWPjry8IGBrtqlsnAdhgN1vH5yw2jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Tue, 10 Sep 2024 04:15:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:47 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH 10/12] fs/dax: Properly refcount fs dax pages
Date: Tue, 10 Sep 2024 14:14:35 +1000
Message-ID: <9f4ef8eaba4c80230904da893018ce615b5c24b2.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0082.ausprd01.prod.outlook.com
 (2603:10c6:10:110::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 611e0f79-913b-4c28-42a0-08dcd14f3ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8CiSMj5pK0SlWAHNC/J6vVfa0y5qcwlpZXjSI2KG7wipzNiQGIXjTu/Bc72u?=
 =?us-ascii?Q?srwLLmrG+2Zl4CxNuYcr6gfHTuyqj67f+aDweFhsUh+b33g2VU9hz56jOBjT?=
 =?us-ascii?Q?CD2mZjVZGMen4PyRG0C3BslGLOTP+1aM3L+hEdoIEBCe9kwpYU3WZ3t8nlFw?=
 =?us-ascii?Q?mRGpkl/7kZok20S0Kh1KxH1kF/Z8WpB8U6YXSwyvAnM19dkpE1i0ilPDA7/B?=
 =?us-ascii?Q?saXaVIaLIRjGuBuc+oDNKp7m1fa4KCKXH0gnRjJElV+INv6aARqAeRFLKp72?=
 =?us-ascii?Q?LHjs0+Tvhw6De4eH4+hInqSr9FwEPqsHDFMJJz5c89urz2gGErK9x8n181zN?=
 =?us-ascii?Q?NtSqoaYow03W+J/xPlSWCiBNcGZIK9qq5+mBnsxzGRFsxVDVQLxpi/kP64tk?=
 =?us-ascii?Q?ui2w/sA6yzvCHqrl0tka72gSXQ5lnGZ9Gu1Wsy8NiSDFyIw5IDAPcgiAfrXn?=
 =?us-ascii?Q?Wp5KQk7H+CVGY56OQru5zx5iDAg5lFMu9emmyGzkUGZI+R6Ct80jauOeifu2?=
 =?us-ascii?Q?oz97S7wwHUllFgGaiK61kMouRawJNUCnNYOjLVSx2H7ZDoD74rn1OGdQyftJ?=
 =?us-ascii?Q?hNcdMahah/bO6P4PkjkDfZeM5Zuve9Sln8wqEBjl9jjy5Rk3etjv4INgwb7K?=
 =?us-ascii?Q?U2TA/fJTAyyuNlRvbOFVlI8M7vnnBmFa+yB1S4dAQXgcuaFIxDegfR3VWU+g?=
 =?us-ascii?Q?J3cwgYV1MhsxNISF1MBvDweWfzCXOMtM6pty8g/4tx6bK4yC65rS4xpbdz37?=
 =?us-ascii?Q?mrJ3AdkWSMLMp5csn/zZ+jq91dTOHa9wS5yNTPNV63OC1tBVIcnR8ab6QqBT?=
 =?us-ascii?Q?l0ZX4orKlpwzOqLFcCUqVchmFaSRwn1QuJZeb33K39AYYzEXFxk2CyE8PRtm?=
 =?us-ascii?Q?ktXQfRohm8RoAvtl7Uec8a5tIzQH+auVlV0KAkiHfEqrSZcNh65VP631b/zO?=
 =?us-ascii?Q?1wTZ6Hp2Yf+v1E0lcAIhVpcs5WRPqBbEQiCd4NMer9O9kdi1nAQqmDVXczEB?=
 =?us-ascii?Q?ulGY8hEjbUz8nQ3utwmJTYcloy6u0Vd1nyo2BHNciQ7wOR0skyaBvRr5MZG0?=
 =?us-ascii?Q?moiJQG1Yb/TnMb4dWtuRm5gIGv1fTIpPU9yS/tYEwuG9AAeF2QKv0RVtqGAO?=
 =?us-ascii?Q?LRV2SuZnFhEkFsNmfK7L/Mb+tyWMxpKIsdRFVE1EFQM29jfh8P8fvQtuTNXD?=
 =?us-ascii?Q?5uMerCItrdqKphBIgEV1IvpQcLvD+A/YvAZ4F8MUVeQHcerm/8XOYA3mmWPZ?=
 =?us-ascii?Q?u/fQXbpnASHfh9vS343u4kW3s0IccrMa18Evby798a6Bhzm7dmsdt5ywf/TP?=
 =?us-ascii?Q?FMWl6kYGxWC3zbceL+B0CEMHJ9FPpkn6wy5ICk5SwBDbtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/t/M9I4z9PudY7sqaVCuj6nygIGp3Q1ilyeC2fjQoAl1zDORGXtBB0o1hhYP?=
 =?us-ascii?Q?dWFqCPuxE/Nzaeh+cUWs+udDBdRuPHY7SutFPEuhTCAPMkK1YphqmF2tnBWm?=
 =?us-ascii?Q?YC0vYkWgXWja9iOKj+iTIaqrN9Zllml93iP+V5krtrk7b33wnR6AtXXNw9Mo?=
 =?us-ascii?Q?b8mZQuK7r/Z1RyQ+r/B5NStaz/cMG4JPt9oXbQDfc/LEMjNx5MaKJUHVSCcX?=
 =?us-ascii?Q?tukQSQCKI43hczMQ/mLRffxGmQ3lzNGNK60e+UbjX+QHnvV4GPzYCHeOOryS?=
 =?us-ascii?Q?EcClswk+Et6ir0QwH8Ibijj19QH3qBERMJPqQlZIJLcyPrUOYjtpm6zRmSfc?=
 =?us-ascii?Q?Z4L6hGQckyMzVNxMzeQz8sSx9tPKKh5nR+lCTTbYN83nFQMJeRP13x2fNQZ2?=
 =?us-ascii?Q?M04HALyfeYo4p1JftuYJJdO1jhBn9XK8Ndq+GORfbB1Yi5khgETh+jQNTXrV?=
 =?us-ascii?Q?U52o3ll17t6p7JWzu6jd6jOMqJw7K4D5QrMpF/iciEWUQkyGy0IRgsnvDuvY?=
 =?us-ascii?Q?HHpaCzOQoY5HYhkTK2nbu9aiDOiTqQUxKBrbvZMhd0YswDt87gWqXHzvZ0xP?=
 =?us-ascii?Q?o1v3dxwY2mvdPZ2/clt9A3EXskY3REffZzadAAMlAri6N+Rzd58jGAXGfthF?=
 =?us-ascii?Q?s0JPeNkVDcZ8c1fTc+pBKuIgHuZjSxxwkdvNRp4uJBWfHDFfnunDkCy12kuB?=
 =?us-ascii?Q?3br/TacNMEC8tsIw56tX6QdMBitVKwIjb4L+PdMUaf/DvaziCyrWp5WEQMVj?=
 =?us-ascii?Q?inmvwGE1PFpW59yOKxGLAB+2Xs9KjA/KSzHeA/TJkpQoibhYtDWeAZo9jyBB?=
 =?us-ascii?Q?v3Iaf1u6A8fMaYnodyf5A/DKvk+MCfSGD1etedr9H2sdNtIiZ6Zg8+ZZV/Uc?=
 =?us-ascii?Q?FJfszhFYeecN8+9BjOv7w9S1GOPSJD7qCzcNJHOnKOjto71BmQNY/Ynb83fe?=
 =?us-ascii?Q?B4NHD5eJWfTNPH+AN/zEkJcCwyPFZCcFMMKdeU8dUisU636uqWVM0mVh58Sv?=
 =?us-ascii?Q?Tm+LYj8exoi5QOCzZGs8AVSqgtXdJWY6C/qcb9iJhRnHVfBSltJhYe7QC92r?=
 =?us-ascii?Q?mYBJQwEdoZTIERQddoFlLtphv/RJupDWqOUdXGGUXol8ZZ3q6Y0wnqjQkhg9?=
 =?us-ascii?Q?ECm8bA8kT7+NGohVy5rj9Hynx+sp4lMEEAV/4ntYc8uD2yG+CB3fuO7kzkzF?=
 =?us-ascii?Q?m37X1HrmXAOICkXmxG0hXHDdyjVWPzmHqmo4lcNI72FGxUJSO+3XC0qEoPcd?=
 =?us-ascii?Q?7uGJWS2afrT2UB9LBDoDiXRamLWi/lAsA/aEONL1CMha+UuyaXARTrBMoNrL?=
 =?us-ascii?Q?EbpCi0KT+BPgDIT1/8wEvVYDZn8khxZm4FUSobhcInwYGD20EELcbj9Nu3EJ?=
 =?us-ascii?Q?iqYEGfJto5GSwKkLEjCFGuQEP2F1NIPjCYRSaEaNtl0C204N/N+JouDQJOUs?=
 =?us-ascii?Q?7+QUnfVFBCreP8L//TlZDx2K3761NR/dQ8FTR2nsSsG+pjkxT6cOBmCk0nQ9?=
 =?us-ascii?Q?yhKCtRFxbpv+ExbqDd357QQR8O1xnsigg6q65ivL4SUCmPVK2PUzOtEro/84?=
 =?us-ascii?Q?GctPM6gXlx/BHHkC0enH0Kw04H5DkRrMpx7jXbln?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611e0f79-913b-4c28-42a0-08dcd14f3ee7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:47.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bHQ1HixT7YqhUYTDrJoaNgIXlbYoZbYsb5xx78mgcESH7YlQWps2gKTqDItZGBMoW+7JWKGk6NXYZZG7ek2nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

Currently fs dax pages are considered free when the refcount drops to
one and their refcounts are not increased when mapped via PTEs or
decreased when unmapped. This requires special logic in mm paths to
detect that these pages should not be properly refcounted, and to
detect when the refcount drops to one instead of zero.

On the other hand get_user_pages(), etc. will properly refcount fs dax
pages by taking a reference and dropping it when the page is
unpinned.

Tracking this special behaviour requires extra PTE bits
(eg. pte_devmap) and introduces rules that are potentially confusing
and specific to FS DAX pages. To fix this, and to possibly allow
removal of the special PTE bits in future, convert the fs dax page
refcounts to be zero based and instead take a reference on the page
each time it is mapped as is currently the case for normal pages.

This may also allow a future clean-up to remove the pgmap refcounting
that is currently done in mm/gup.c.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/dax/device.c       |  12 +-
 drivers/dax/super.c        |   2 +-
 drivers/nvdimm/pmem.c      |   4 +-
 fs/dax.c                   | 192 ++++++++++++++++++--------------------
 fs/fuse/virtio_fs.c        |   3 +-
 include/linux/dax.h        |   6 +-
 include/linux/mm.h         |  27 +-----
 include/linux/page-flags.h |   6 +-
 mm/gup.c                   |   9 +--
 mm/huge_memory.c           |   6 +-
 mm/internal.h              |   2 +-
 mm/memory-failure.c        |   6 +-
 mm/memory.c                |   6 +-
 mm/memremap.c              |  40 +++-----
 mm/mlock.c                 |   2 +-
 mm/mm_init.c               |   9 +--
 mm/swap.c                  |   2 +-
 17 files changed, 143 insertions(+), 191 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 9c1a729..4d3ddd1 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -126,11 +126,11 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return dax_insert_pfn(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
@@ -169,11 +169,11 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return dax_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -214,11 +214,11 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return dax_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e16d1d4..57a94a6 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -257,7 +257,7 @@ EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
 {
-	if (unlikely(!dax_write_cache_enabled(dax_dev)))
+	if (unlikely(dax_dev && !dax_write_cache_enabled(dax_dev)))
 		return;
 
 	arch_wb_cache_pmem(addr, size);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 210fb77..451cd0f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -513,7 +513,7 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = PFN_DEV;
+	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
@@ -522,7 +522,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
 			range_len(&pmem->pgmap.range);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 		bb_range.start += pmem->data_offset;
 	} else if (pmem_should_map_pages(dev)) {
@@ -532,7 +531,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
diff --git a/fs/dax.c b/fs/dax.c
index becb4a6..05f7b88 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -71,6 +71,11 @@ static unsigned long dax_to_pfn(void *entry)
 	return xa_to_value(entry) >> DAX_SHIFT;
 }
 
+static struct folio *dax_to_folio(void *entry)
+{
+	return page_folio(pfn_to_page(dax_to_pfn(entry)));
+}
+
 static void *dax_make_entry(pfn_t pfn, unsigned long flags)
 {
 	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
@@ -318,85 +323,58 @@ static unsigned long dax_end_pfn(void *entry)
  */
 #define for_each_mapped_pfn(entry, pfn) \
 	for (pfn = dax_to_pfn(entry); \
-			pfn < dax_end_pfn(entry); pfn++)
+		pfn < dax_end_pfn(entry); pfn++)
 
-static inline bool dax_page_is_shared(struct page *page)
+static void dax_device_folio_init(struct folio *folio, int order)
 {
-	return page->mapping == PAGE_MAPPING_DAX_SHARED;
-}
+	int orig_order = folio_order(folio);
+	int i;
 
-/*
- * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
- * refcount.
- */
-static inline void dax_page_share_get(struct page *page)
-{
-	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
-		/*
-		 * Reset the index if the page was already mapped
-		 * regularly before.
-		 */
-		if (page->mapping)
-			page->share = 1;
-		page->mapping = PAGE_MAPPING_DAX_SHARED;
-	}
-	page->share++;
-}
+	if (orig_order != order) {
+		struct dev_pagemap *pgmap = page_dev_pagemap(&folio->page);
 
-static inline unsigned long dax_page_share_put(struct page *page)
-{
-	return --page->share;
-}
+		for (i = 0; i < (1UL << orig_order); i++) {
+			struct page *page = folio_page(folio, i);
 
-/*
- * When it is called in dax_insert_entry(), the shared flag will indicate that
- * whether this entry is shared by multiple files.  If so, set the page->mapping
- * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
- */
-static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address, bool shared)
-{
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
+			ClearPageHead(page);
+			clear_compound_head(page);
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
-	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
+			/*
+			 * Reset pgmap which was over-written by
+			 * prep_compound_page().
+			 */
+			page_folio(page)->pgmap = pgmap;
 
-		if (shared) {
-			dax_page_share_get(page);
-		} else {
-			WARN_ON_ONCE(page->mapping);
-			page->mapping = mapping;
-			page->index = index + i++;
+			/* Make sure this isn't set to TAIL_MAPPING */
+			page->mapping = NULL;
 		}
 	}
+
+	if (order > 0) {
+		prep_compound_page(&folio->page, order);
+		if (order > 1)
+			INIT_LIST_HEAD(&folio->_deferred_list);
+	}
 }
 
-static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
+static void dax_associate_new_entry(void *entry, struct address_space *mapping,
+				pgoff_t index)
 {
-	unsigned long pfn;
+	unsigned long order = dax_entry_order(entry);
+	struct folio *folio = dax_to_folio(entry);
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
+	if (!dax_entry_size(entry))
 		return;
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		if (dax_page_is_shared(page)) {
-			/* keep the shared flag if this page is still shared */
-			if (dax_page_share_put(page) > 0)
-				continue;
-		} else
-			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
-	}
+	/*
+	 * We don't hold a reference for the DAX pagecache entry for the
+	 * page. But we need to initialise the folio so we can hand it
+	 * out. Nothing else should have a reference either.
+	 */
+	WARN_ON_ONCE(folio_ref_count(folio));
+	dax_device_folio_init(folio, order);
+	folio->mapping = mapping;
+	folio->index = index;
 }
 
 static struct page *dax_busy_page(void *entry)
@@ -406,7 +384,7 @@ static struct page *dax_busy_page(void *entry)
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (page_ref_count(page) > 1)
+		if (page_ref_count(page))
 			return page;
 	}
 	return NULL;
@@ -620,7 +598,6 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_lock_irq(xas);
 		}
 
-		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
 		dax_wake_entry(xas, entry, WAKE_ALL);
 		mapping->nrpages -= PG_PMD_NR;
@@ -743,7 +720,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
-					  pgoff_t index, bool trunc)
+				  pgoff_t index, bool trunc)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int ret = 0;
@@ -757,7 +734,6 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	    (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY) ||
 	     xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
 		goto out;
-	dax_disassociate_entry(entry, mapping, trunc);
 	xas_store(&xas, NULL);
 	mapping->nrpages -= 1UL << dax_entry_order(entry);
 	ret = 1;
@@ -894,9 +870,11 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
-		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				shared);
+		if (!shared) {
+			dax_associate_new_entry(new_entry, mapping,
+				linear_page_index(vmf->vma, vmf->address));
+		}
+
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1084,9 +1062,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 		goto out;
 	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
 		goto out;
-	/* For larger pages we need devmap */
-	if (length > 1 && !pfn_t_devmap(*pfnp))
-		goto out;
+
 	rc = 0;
 
 out_check_addr:
@@ -1189,11 +1165,14 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	struct inode *inode = iter->inode;
 	unsigned long vaddr = vmf->address;
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
+	struct page *page = pfn_t_to_page(pfn);
 	vm_fault_t ret;
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+	page_ref_inc(page);
+	ret = dax_insert_pfn(vmf, pfn, false);
+	put_page(page);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1212,8 +1191,13 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	pmd_t pmd_entry;
 	pfn_t pfn;
 
-	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
 
+	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
 	if (unlikely(!zero_folio))
 		goto fallback;
 
@@ -1221,29 +1205,23 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
 				  DAX_PMD | DAX_ZERO_PAGE);
 
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
 	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
-	if (!pmd_none(*(vmf->pmd))) {
-		spin_unlock(ptl);
-		goto fallback;
-	}
+	if (!pmd_none(*vmf->pmd))
+		goto fallback_unlock;
 
-	if (pgtable) {
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
-		mm_inc_nr_ptes(vma->vm_mm);
-	}
-	pmd_entry = mk_pmd(&zero_folio->page, vmf->vma->vm_page_prot);
+	pmd_entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
 	pmd_entry = pmd_mkhuge(pmd_entry);
-	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
+	if (pgtable)
+		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+	set_pmd_at(vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
 	spin_unlock(ptl);
 	trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
 	return VM_FAULT_NOPAGE;
 
+fallback_unlock:
+	spin_unlock(ptl);
+	mm_put_huge_zero_folio(vma->vm_mm);
+
 fallback:
 	if (pgtable)
 		pte_free(vma->vm_mm, pgtable);
@@ -1649,9 +1627,10 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
-	int err = 0;
+	int ret, err = 0;
 	pfn_t pfn;
 	void *kaddr;
+	struct page *page;
 
 	if (!pmd && vmf->cow_page)
 		return dax_fault_cow_page(vmf, iter);
@@ -1684,14 +1663,21 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-	/* insert PMD pfn */
+	page = pfn_t_to_page(pfn);
+	page_ref_inc(page);
+
 	if (pmd)
-		return vmf_insert_pfn_pmd(vmf, pfn, write);
+		ret = dax_insert_pfn_pmd(vmf, pfn, write);
+	else
+		ret = dax_insert_pfn(vmf, pfn, write);
 
-	/* insert PTE pfn */
-	if (write)
-		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	/*
+	 * Insert PMD/PTE will have a reference on the page when mapping it so
+	 * drop ours.
+	 */
+	put_page(page);
+
+	return ret;
 }
 
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
@@ -1932,6 +1918,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
 	void *entry;
 	vm_fault_t ret;
+	struct page *page;
 
 	xas_lock_irq(&xas);
 	entry = get_unlocked_entry(&xas, order);
@@ -1947,14 +1934,17 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
+	page = pfn_t_to_page(pfn);
+	page_ref_inc(page);
 	if (order == 0)
-		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
+		ret = dax_insert_pfn(vmf, pfn, true);
 #ifdef CONFIG_FS_DAX_PMD
 	else if (order == PMD_ORDER)
-		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
+		ret = dax_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
 #endif
 	else
 		ret = VM_FAULT_FALLBACK;
+	put_page(page);
 	dax_unlock_entry(&xas, entry);
 	trace_dax_insert_pfn_mkwrite(mapping->host, vmf, ret);
 	return ret;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index dd52601..f79a94d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -875,8 +875,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
-					PFN_DEV | PFN_MAP);
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 773dfc4..0f6f355 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -217,8 +217,12 @@ static inline int dax_wait_page_idle(struct page *page,
 				void (cb)(struct inode *),
 				struct inode *inode)
 {
-	return ___wait_var_event(page, page_ref_count(page) == 1,
+	int ret;
+
+	ret = ___wait_var_event(page, !page_ref_count(page),
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+
+	return ret;
 }
 
 #if IS_ENABLED(CONFIG_DAX)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 935e493..592b992 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1071,6 +1071,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+extern void prep_compound_page(struct page *page, unsigned int order);
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1394,25 +1396,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!folio_is_zone_device(folio))
-		return false;
-	return __put_devmap_managed_folio_refs(folio, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
@@ -1527,12 +1510,6 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
-	/*
-	 * For some devmap managed pages we need to catch refcount transition
-	 * from 2 to 1:
-	 */
-	if (put_devmap_managed_folio_refs(folio, 1))
-		return;
 	folio_put(folio);
 }
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 2175ebc..0326a41 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -667,12 +667,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
 
-/*
- * Different with flags above, this flag is used only for fsdax mode.  It
- * indicates that this page->mapping is now under reflink case.
- */
-#define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
-
 static __always_inline bool folio_mapping_flags(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
diff --git a/mm/gup.c b/mm/gup.c
index 5d2fc9a..798c92b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -91,8 +91,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	 * belongs to this folio.
 	 */
 	if (unlikely(page_folio(page) != folio)) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		goto retry;
 	}
 
@@ -111,8 +110,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	if (!put_devmap_managed_folio_refs(folio, refs))
-		folio_put_refs(folio, refs);
+	folio_put_refs(folio, refs);
 }
 
 /**
@@ -543,8 +541,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 	 */
 	if (unlikely((flags & FOLL_LONGTERM) &&
 		     !folio_is_longterm_pinnable(folio))) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		return NULL;
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 790041e..ab2cd4e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2017,7 +2017,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 						tlb->fullmm);
 	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2661,13 +2661,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_special_huge(vma))
+		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
 			return;
 		if (unlikely(is_pmd_migration_entry(old_pmd))) {
 			swp_entry_t entry;
 
 			entry = pmd_to_swp_entry(old_pmd);
 			folio = pfn_swap_entry_folio(entry);
+		} else if (is_huge_zero_pmd(old_pmd)) {
+			return;
 		} else {
 			page = pmd_page(old_pmd);
 			folio = page_folio(page);
diff --git a/mm/internal.h b/mm/internal.h
index b00ea45..08123c2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -680,8 +680,6 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-extern void prep_compound_page(struct page *page, unsigned int order);
-
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 96ce31e..80dd2a7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -419,18 +419,18 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
 		return 0;
-	if (pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return PUD_SHIFT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return 0;
-	if (pmd_devmap(*pmd))
+	if (pmd_trans_huge(*pmd))
 		return PMD_SHIFT;
 	pte = pte_offset_map(pmd, address);
 	if (!pte)
 		return 0;
 	ptent = ptep_get(pte);
-	if (pte_present(ptent) && pte_devmap(ptent))
+	if (pte_present(ptent))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 368e15d..cc692d6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3752,13 +3752,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
-		 * VM_PFNMAP VMA.
+		 * VM_PFNMAP VMA. FS DAX also wants ops->pfn_mkwrite called.
 		 *
 		 * We should not cow pages in a shared writeable mapping.
 		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
 		 */
-		if (!vmf->page)
+		if (!vmf->page || is_device_dax_page(vmf->page)) {
+			vmf->page = NULL;
 			return wp_pfn_shared(vmf);
+		}
 		return wp_page_shared(vmf, folio);
 	}
 
diff --git a/mm/memremap.c b/mm/memremap.c
index e885bc9..89c0c3b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,13 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->pgmap->ops ||
-			!folio->pgmap->ops->page_free))
+	struct dev_pagemap *pgmap = folio->pgmap;
+
+	if (WARN_ON_ONCE(!pgmap->ops))
+		return;
+
+	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
+			 !pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -486,24 +491,29 @@ void free_zone_device_folio(struct folio *folio)
 	 * to clear folio->mapping.
 	 */
 	folio->mapping = NULL;
-	folio->pgmap->ops->page_free(folio_page(folio, 0));
 
-	switch (folio->pgmap->type) {
+	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->pgmap);
+		pgmap->ops->page_free(folio_page(folio, 0));
+		put_dev_pagemap(pgmap);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
+		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
+	case MEMORY_DEVICE_FS_DAX:
+		wake_up_var(&folio->page);
+		break;
+
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		pgmap->ops->page_free(folio_page(folio, 0));
 		break;
 	}
 }
@@ -519,21 +529,3 @@ void zone_device_page_init(struct page *page)
 	lock_page(page);
 }
 EXPORT_SYMBOL_GPL(zone_device_page_init);
-
-#ifdef CONFIG_FS_DAX
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
-		return false;
-
-	/*
-	 * fsdax page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (folio_ref_sub_return(folio, refs) == 1)
-		wake_up_var(&folio->_refcount);
-	return true;
-}
-EXPORT_SYMBOL(__put_devmap_managed_folio_refs);
-#endif /* CONFIG_FS_DAX */
diff --git a/mm/mlock.c b/mm/mlock.c
index e3e3dc2..5352b00 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -362,6 +362,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (vma_is_dax(vma))
+		ptl = NULL;
 	if (ptl) {
 		if (!pmd_present(*pmd))
 			goto out;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3d0611e..3c32190 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1015,23 +1015,22 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
-	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
-	 * allocator which will set the page count to 1 when allocating the
-	 * page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
+	 * directly to the driver page allocator which will set the page count
+	 * to 1 when allocating the page.
 	 *
 	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
 	 * their refcount reset to one whenever they are freed (ie. after
 	 * their refcount drops to 0).
 	 */
 	switch (pgmap->type) {
+	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
 	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		break;
 	}
diff --git a/mm/swap.c b/mm/swap.c
index 6b83898..0b90b61 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -969,8 +969,6 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (put_devmap_managed_folio_refs(folio, nr_refs))
-				continue;
 			if (folio_ref_sub_and_test(folio, nr_refs))
 				free_zone_device_folio(folio);
 			continue;
-- 
git-series 0.9.1


Return-Path: <linux-fsdevel+bounces-38522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BCA0360E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70091640F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB2192B95;
	Tue,  7 Jan 2025 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PsWLvnAH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8F18A6C0;
	Tue,  7 Jan 2025 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221408; cv=fail; b=asxVx0Sf1kqLVkYOgEvzQ5JAlc4E+WTwLYhe7mT6WpVfY5npjzD3sZHiqTzE+zSZLcVkI3w5Uo0lhgAdyqFm/xLek6DAQPGz52PGNckTAumFYGXOOFi5P4CwLnDb1mWRj2QFFcgEyKyWlXvXa8s9jYcQgu7RGzQlSgDvIBeAB2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221408; c=relaxed/simple;
	bh=iQ/MpJ1U6pI36agvgLyqS7tP2UT/LMG2aEuw0cQfb6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQk9Z4W2f7auNbGMahFk5j2KdU4Lk0wPRcpH3z7hqNmCI576VrEbNFemwd22PAti0UNlu0hSTZP1qklPEjCb3dIBGIgXv9tHUfa+BKDTuUauH3EncZUvXPu/ek4yd6bbh4k4+NitEyJWjTcb60TfOCNpqfmq77QPx+CnTKuVO3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PsWLvnAH; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITQdX1bPfFKhtMbyHhCmzvd+iRcmQUSNGs5J6XIhyrLVMi0abvTlWERjKRui6z8i+mGn0rPlqpOkyqeJ2l9zDOBuKXWIJ9fS4n8MA3WrHvNkiywy1I0GDfNPLf5tvIMbOaPmxoB4PfH7Lx4OWiPEb23iUkkcH6qUyGoo9hwfTnMyFknrJ1SpTAQ+szR4EWbLRT+euxcnwL4MZwSuTRcWciuNDN+SBWT0kJ6E3i2zh0/Fhyh6R9pEvtS8l5F53GBCqGjwE8io+EUKPy+BncuXlgDw0fEfCpJ8297RKalu82iWDSar6uAXfjnPxM0BZEmOZC+Uw5eh3z5DpVz+HJySKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr+IvtDG4tlBRjnd4t0ov6kscjwRm8udTIzF1grJaok=;
 b=bJEEXueOzYqxbVFuy16xkgdVBtl+ODrHMkhE2/TAbencjmdXMfNlfySx5xvv947CwCC83U0F4xp9vPILRpGa/+rnWPQ323LHQHY8XO+0j8W6/bQ7faHFqveIKPbl1lrbdj27Rl6/3kJFnSraMxqUjhNbujC0jpvkcnt48O3MfU1bo3iVHy2bASF2fOqopOaUab0z9fVsNOHA0xetwAIK/Os1eB6LWo23NKFtW7dxwK1ByWhuoSc4L5LovFv5QmMHibfgbUaWAT0aWKTRMK9Uu581hntmg8dtcRucURVEOit/as6OGDoNBRvX3qhqLgZNSOnhYolsypLNg0VcUJP75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr+IvtDG4tlBRjnd4t0ov6kscjwRm8udTIzF1grJaok=;
 b=PsWLvnAHko998tssYOoVnI07KbNalUq6YdMdFni47TR8wamWcpq2I35fiwA1t2eVxyzUmP9dHFDdTTDZ4sOTQ7KqEXVjmvz41vukdag7tW/aoSQjBGLxI18S4mNEIIjys6xjmjyj2bHOzKieh0JaNYhwzf7hNYQKVKUWo8XUYtHB90v7r/6+ghSFBg4oNWJL+nLFSBzvW4Az09iTDD3/rNjTlqAneYlDq8WFUj4NLky6/1qpb9d0lFM1JMyJDLEjHp7c0n+COUX8g9lPhDTOe6ePENVkTLns4z+0mG3X5TnbhcCAAHYo21cP30zpo8W/Ped8WodIC7bnEeySMzdsoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:16 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:16 +0000
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
Subject: [PATCH v5 04/25] fs/dax: Refactor wait for dax idle page
Date: Tue,  7 Jan 2025 14:42:20 +1100
Message-ID: <62a85767a21fb76b548801a002a85c7831e8e25c.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0133.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: a65120a5-c783-4f1c-5405-08dd2ecd6b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V99kf3geINb1nyQ9r6J+tUlJM44KPNoNRp7ZAj0IpAcOV7wdGqAABDWVrs5N?=
 =?us-ascii?Q?5gXi6Xe8glIfDcJvzNVBvh3LmiYTAVJu/DLlr7U0OUvsKBZZ+Xr3Bn8Iftht?=
 =?us-ascii?Q?uBd49pBfjv1LaRVp4juU1yTu7jPT3qFmeXueXhMxCOLhkROCZfKv2Xv/pEfa?=
 =?us-ascii?Q?4jEoU9n+RZbzib+1O8cmS8zN4nH8KmbgtcyzoyXXt+qNIe3e5psAfX0tDbbr?=
 =?us-ascii?Q?YhV26r/WhFjOERPI76Xu0BmaEmkRzOsIjh8wAEnL/c3SXT8Yjd9zT19hkawJ?=
 =?us-ascii?Q?WVywIb+vpIWDkY2G9+yNErDiNd+cFFzVOtp0F8c+OxlMKe4A36OSFRSCMqd3?=
 =?us-ascii?Q?GvgF6T8GoC/qF24/XFNIKGb0Rcto9l8KWMeNTcCszbqtLNZlgofsoZGmar4f?=
 =?us-ascii?Q?Zbow+jt8eRbP3ob8d+q4N7ZPubz92bJTHXpj30K4I2IYmnvtPgC6ytf7WwDJ?=
 =?us-ascii?Q?7BU29Bl++pisU/a6oFtEOj31AgnkUbAzSqP9/7Fq/fBriH1gcMNwFpwVkKU/?=
 =?us-ascii?Q?B7dUee0Osk+PRspYoc63DR2FSXL59Rk1JxCfANxVtu1KZkJXlYTN7GhZhDUZ?=
 =?us-ascii?Q?MY3tVSkBHM5Tsgu6+04vOpgz3Vmkts3aG2pCqQBj+6eT3UdHslOxQkg+fKQj?=
 =?us-ascii?Q?NnlzGQWvljy0lVO78NKdKxjbqRK4zW8eH+IqdLoc6TsLa/E8BqUtpWODUQ0R?=
 =?us-ascii?Q?9pulf8cQwP/znCz6feEnHDpRBOXKtd9v+fI8RsEqNrg4JQ8LpG5+a6e1RaSo?=
 =?us-ascii?Q?S4etauIzeYJIaBUiPP4H9poTujf3meNb04KuOZz2GPmmYMhsxpGTjY+/Galk?=
 =?us-ascii?Q?nX72mCwuvRdskcxpMFwD+Cq46Tywd5xlTnRlmBdkuHbHbzRLPanX/MQBGzaU?=
 =?us-ascii?Q?AQAnaz55T65iXEHCXppZkN80HE9whmdBNakhGlJK3HKNfuEw9n2/5mZt5HK5?=
 =?us-ascii?Q?nxNuA2mQe45h3iBbqmiRt1Tm8BlFZGp8ygn5Yq83rvv2O9oqL9tEzXO+1HjV?=
 =?us-ascii?Q?BtQ1btpAE4RU7bK9Usakm605oSVneQmVVXyAAhAkJBthm+PV1hy5elLSRVvp?=
 =?us-ascii?Q?0jzA7kVZzqIFuxDJnTzU8O5PcquPf8uMlZ3DcxHSDAgq0j26aq49O0/T/ii0?=
 =?us-ascii?Q?iZe4/N7dZxeOvDWfyNgTWpZlzBKgl5Va+dA1iHYKpjecP56jBjJ10RGsKwH6?=
 =?us-ascii?Q?aol1TlRD79bdu8/YLjsuTaQahP06L1FHvHQ09/JhRXNlazduDGN0/k4jHVTg?=
 =?us-ascii?Q?EI0G+6C2mZAy4zaNayRVOLtbiPqcglGFoW8hwNVkm90F9TEcCD/D29zenZHY?=
 =?us-ascii?Q?fzfv8RznpTlKvdR5SdkcmmFu6vMDxUAOE18VPVwCb/UtjpljHM3wEUDBDOjw?=
 =?us-ascii?Q?5icdgftiVasevYwgb7AQRmLVpbVr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E+NFr9Lt4TOXz1sEI07IDhB/vbMHkzvLTDmuWtPQspBy8LUoeeY7n4+MprkO?=
 =?us-ascii?Q?CTPiBcwQARqE7HD7fxLv041PPPLqPnOKklirC5910RgrIxjMofSWL0dkxmjF?=
 =?us-ascii?Q?TqGsA6O7wAxNTTQ3aGv0ys8bA7SMPte5WBckAvfJuHRbiLcLL8Z8LA/CvZI1?=
 =?us-ascii?Q?AwGV7jVXbVeqGGH3Khn8sxpZL95p8678l62Q30Q+oro0TUC14cR4uLSDrxFS?=
 =?us-ascii?Q?U14AXemPujuFf7aW+T3/OSs47BeHlU6cpwPep8gJ8KbGymk+fFy07P+YOF7E?=
 =?us-ascii?Q?9+7p+Np5RGGzcjHNiJw2RKDtWx/MY1bx3w0Mf05+LlAm9YQXOg7kp3z5pZbU?=
 =?us-ascii?Q?0F4O8gacrCQM9gYu5Z46BvmbKsRTeSaoHJvLgK9M2cTJmL6FdLsYz4WnO4VV?=
 =?us-ascii?Q?nre/ERYzcUMF12QUHD1LU2dAhnJrUwd42KMnDXBIHhiZoDKMuXehuWnR32Y4?=
 =?us-ascii?Q?VmzRBfYHqErDhRh2IgUnJEqvIhbuK+aewi/c5GfqFj1GWgvHMI5t3FRtiOjQ?=
 =?us-ascii?Q?Ew6Guz8jGbhHgjPip+s8nO5vPLxrjBqLVvdShzuoKE0KbWd4v58tGs5ARb4d?=
 =?us-ascii?Q?ezA0/QZLAvnoXQUXA1YBk3NYlOW/v/Q47zuMAIBQV9XaQqk5HVrPJ0ygr6Ao?=
 =?us-ascii?Q?uroJ6YxqcwUkLo/kbKkox822uvRoKSlDMmOL3ikaKMcAqciPlz0xVMpOE9wi?=
 =?us-ascii?Q?aIFJTHpTExCVsYM1j/z6zDGjPQDiaaGS8X4G32MfYreCNEY9mvFOyRebfCVB?=
 =?us-ascii?Q?x3I08oaxaFTGHsZZ82X5dpQhEh/25+e2pJlO3B+1ZyFF5YfdJcA9OWwXs8tk?=
 =?us-ascii?Q?bk1sOk9UYrVrT64KiADedCxn47X+lM6YeWSTLtTVg5zkmPEx4VX1Od9eYLeJ?=
 =?us-ascii?Q?F7Dd8NIpTsjjIXafji3VgcHKm9/9iG9BjKavNMtQTlfpc0jqin2j8BEJKPBl?=
 =?us-ascii?Q?06PtNGE1ypvmt8MXvqeXPMpr5J2fEFPrt0LiTCynCggWHATAreQCPb5hUdq5?=
 =?us-ascii?Q?TwrAdCMPyyozc58Wbo57bEdvpWrmwmEf0KDPhKYFAIlPK2LkxYRM3RtjKQ0F?=
 =?us-ascii?Q?KJNddX8OLc65IDGMRwjdF5mjAV6wLCvG0PwjLg4knz2cdv0gH4zafLw0I1uo?=
 =?us-ascii?Q?tJpCbBaHXJsM2LL07z+M5SnYlgPsMcgro11+nPsQSlKRY+7swYZoOzGpCsHK?=
 =?us-ascii?Q?l30l2BoPg58CoA1cjvkbHI4JAq1TZwhSFIyVAZ+NEUG+A99nzS59sdkmiOA5?=
 =?us-ascii?Q?InXI7WUpgSf81T+N8p5x+DjnBLpqSf9Nrnc0E/LKa1EtC8r3JHHF3Vt0tCDd?=
 =?us-ascii?Q?VuXLoorafXIWdrmox+ZQ1/n7zda9bCcBFrZXckBjXDXgXZHJdrE0iyW9IO4X?=
 =?us-ascii?Q?VwQPVhcwTE/nouXboQAbpyY/rx7h011A2UvOIHX4/u3vxSzd2blXXvuY86Mu?=
 =?us-ascii?Q?KN7W0HDDL1TTbD0Ta/ASHN+onURVO7ba4FEFrcU0tg69eyzEx7zpW38GX5As?=
 =?us-ascii?Q?5EZe7l4f0tfFobJJvCS+7f7zCPFkgCENNST6MEiXtSUqX6nGnAPdENs450xW?=
 =?us-ascii?Q?oGy5PxKswUDG14ioPR+iCcc29T/rNDuH2FJv8qzz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65120a5-c783-4f1c-5405-08dd2ecd6b6c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:16.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhIhIPSN85wPD94co4a2mWGDg0VS/dT+gFXI0/W3QfI3rJdq+OeZQsMU+cks39NNeBpDPCq4pHwKViMcBEnboA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

A FS DAX page is considered idle when its refcount drops to one. This
is currently open-coded in all file systems supporting FS DAX. Move
the idle detection to a common function to make future changes easier.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c     | 5 +----
 fs/fuse/dax.c       | 4 +---
 fs/xfs/xfs_inode.c  | 4 +---
 include/linux/dax.h | 8 ++++++++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5..cc1acb1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3922,10 +3922,7 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) == 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(inode));
+		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
 	} while (error == 0);
 
 	return error;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index c5d1fea..d156c55 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -676,9 +676,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, fuse_wait_dax_page(inode));
+	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
 }
 
 /* dmap_end == 0 leads to unmapping of whole file */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c8ad260..42ea203 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3000,9 +3000,7 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
 }
 
 int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index df41a00..9b1ce98 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -207,6 +207,14 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
+static inline int dax_wait_page_idle(struct page *page,
+				void (cb)(struct inode *),
+				struct inode *inode)
+{
+	return ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
 void dax_read_unlock(int id);
-- 
git-series 0.9.1


Return-Path: <linux-fsdevel+bounces-42807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE110A48F52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757703B8402
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31E1B4F3E;
	Fri, 28 Feb 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yk+duUal"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0181B3953;
	Fri, 28 Feb 2025 03:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713506; cv=fail; b=VTsgL+vww98yaMz+dSulEn1oc76LIuSUKdGc2bWDk89tTuJ6qi09PcsN2JpCmR27Hbog+DuNlV85P2Iggph7m7pSuGsSkQoqFUYKzY7bh4z74OPV2Paie5G12wlSO1IVI5SQWdraN3IKhnxOAnOIPFASNBtqPXspRHG7H1ghcg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713506; c=relaxed/simple;
	bh=7dw6ttt/ZkMVvnYazta3TRYvaxxYzkW7WyADgK36ZlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajvcyxT2Qc2gT4xGqA6Qb+NqzLwM9DdRmKyLbuFd6NqCXUmWcds+edGLT1PL0nG2ZhktTL+1lSsB63ZhOyg4FpO75micHWq4q4zDacP1F1/g/3CDLJY6ZuRUWwWYyRpTPsEK3rfzo37bobChLNtAFCn0PJDLlAIQyor5G3tdtz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yk+duUal; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri4RFeS6YGrkOEqZ175F/ZnHVeoSgpOVyJf60Vs1eQCM5vIUWbt9w4GC25GvWdUD0OGLRyWeWlm8/CQ7wQzTdfN0aPpNuCweuvRaeO8aOFTORMuanVozQInoN6edpn7GH9aI+LQ/xWwo/Z3g9wdDittd/jXlGLulyq17aI6eHTd9qJiEDO3TOk3O5Bgnls/Nz/+iaEGZschP8CyIVnxhWxggt6KbbTCd38VcHkHLE2AO5UrpNxQL7iqiM79igjejeO1Vc7XaRly+xTrQJBT9K6gSLvGgVJyArJU2sdqbUPyg7fQyj8d8CO3wCTNhhVaY29ZF+zNTlluHFxb1X0CFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uq3O8kXTMfzu33bTQkJE6cujPJmeDvSmwlQjmGtbl0=;
 b=wV51G1VCZN6gmj9do3+M0WQokj1i0a/QOx+WKZ2lrdg+bMPkuME/pB7uJVtudMzlYGhhoMrUWMruBAhKD9Q/FB4GGoD3Uos6YVkYu5SUIxzC6kRDfAJwftqYQPPLWiduHY9qUnn4RXv+mm4Fqx+HxacPiTucISRWPtrSqxlQ+zR8/cyMcLsSDPB+e9n4wBmOXG9rciN7JO3W/fY2ot4Vl5/1grgmr2tg9pWMYm0OAAEi2ZBZnESu4eqUWaUQAKdEeecfkpWTsS6yDB8U+vWfcNWKP3K+X0k82761uXNzyzrztqD5+UkZqFxzaA4B9vcxAlXd+qMvrQzFuvCPHuWJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uq3O8kXTMfzu33bTQkJE6cujPJmeDvSmwlQjmGtbl0=;
 b=Yk+duUalhvc//f2HV7QpbUR0hPa2RbU0oNOGKVD+OEuywv1esNpK1dglkGxU4dHkVAkSettk/tXl3SU2r/KMHhXnqHQnsls4ghSykwsBeg/1kA2eXIwv+Kvge5hh0T6het5809/NTo/V5FwSXUwnNkW+UzfHUyxjyhknoLDX8EYIb79bKfr7DIVkMBX1yJnZNibz2bixqBNWQbVNjst3r+qGds/HCGEyoYy/ICCTiQMU/+anWAW6+6mC7olPXx6Fsim+I11AemTHCZekwDMMphnB3ZaPkdW4px7bN5A3gPjRaUtkRZpdExHKxN8F1FvRNL83mYuix1fCZwMragN9BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:31:42 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:31:42 +0000
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
Subject: [PATCH v9 04/20] fs/dax: Refactor wait for dax idle page
Date: Fri, 28 Feb 2025 14:30:59 +1100
Message-ID: <c2c9d269110b90224eeb1dc661ffbc1d82aa20c9.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a860d7-7e48-42f8-4808-08dd57a86aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vLorP4ItNgA3291zW5oI5epydjJIy+IaHaPo42jTQNaCZ+1iKRBN5m47KKnt?=
 =?us-ascii?Q?+yXUBGOy3awTkV4CU+h7GXLZKiCIK1PJDbkdZAkJMqg8hPhsS3eG7cGqEMmf?=
 =?us-ascii?Q?JCtPk9wUMU755ND4lcl9siG2qbcuK93cNGr8r/Adj8sCr1cVNV8c4Gfkx1uj?=
 =?us-ascii?Q?jIK4F3QmqO5y7k3MMeBZT30Jo2WjDXPEt/Tw8/2Gurw38zXqXOqEnGSk2l5E?=
 =?us-ascii?Q?FVKKke641cp10BMi26Ayt/cHR1xD12Jwue496kzT2u9vDTvPZHu8NixeHCng?=
 =?us-ascii?Q?tqsOupw7dov5eD/dJ6VCBTY0fTSfpywmmas3E2ea2NOzyHvz12JwMKN+xYrT?=
 =?us-ascii?Q?OQOVn6zmZ8wRKRKwDsW11Y1YgGO27UnuCdB1vYqk9JSAZzFZc5l/6yESWPZ8?=
 =?us-ascii?Q?KdmvAojI6g49A6N568kSpXsOGN0KVHHCXsNDNLK1fbMPpNkBWXGBux5CupV7?=
 =?us-ascii?Q?jgrxDZh4kQ2RszWUYvIpPkFfuXS/z4YFHGDRfBCbVlrZgGTYiT5H/3a2NPAn?=
 =?us-ascii?Q?2ZJ6hKvy3zIociHxKAvYjBOzwkoeOsbL/rDahdwHWsDDJVXOWDkrY/w/EBgm?=
 =?us-ascii?Q?sRC/7JCjqoeFWbHKs+iC5J6TBbGZmoV6Z3AV9u+kLSEqfH3lPNROGAxDvIAj?=
 =?us-ascii?Q?DROgOVXe+2/g2ctRe73XZuYoCws74XXR64DxYTKiCLt84+olB/+uP7NzLH/C?=
 =?us-ascii?Q?BYJqNHvXfrj0rHX+7HjcaMkfOFmduGoqYBupB7UJJ+8I3jji3yZncv5HIu2U?=
 =?us-ascii?Q?AfzHwGUrStoQYmuYuaEQU1rT1OUqNi7gkV4K1ztrg9eAmk/x08eXj7GIW9Y4?=
 =?us-ascii?Q?9DaW99SsmQIFVzMGy1F5ZkpCGJ9hH6Mnax+2+WbOUUyUetTn1yR2og64jJCO?=
 =?us-ascii?Q?yNLi2Y9vVKCLcaKBzBPSWwweY0qnpPH4QFlMPCECoGtsEtbMxVvwQIA3UhXy?=
 =?us-ascii?Q?n5sZWLnb+/fKLHE2P0Bi7t6AXu+Yi4X9iORFiGFEMxYdIVjWrmOqxRl7/bHM?=
 =?us-ascii?Q?P3ISMSdd68LDug3BQ6sqYvxkwYa1Y0IKdu0Tu+g+I4u/9oayjj3ZtjuqPq5u?=
 =?us-ascii?Q?/5HKBgrxqm4Lv5kUs4RtCJvBvICbSiFcr604otxJmUkVIlY5TM1E+k49v85g?=
 =?us-ascii?Q?MSALGnTAKIBcNMEl9seYZfeiL+Pdy8XsCkPxHJA6JiWfFmk2zOAt7m7ZLEjR?=
 =?us-ascii?Q?+oLy8RCQkS9ZzY8OQ32WANSW3ZzRpqnWzlVjpVM0QQf1KY4/2CZzA9+4cPge?=
 =?us-ascii?Q?cQI6eU34N0UrRr1K1SAPPWTKz7UkM3fzxfKlG2ga0+RPSqP8v1KBrCYolo4m?=
 =?us-ascii?Q?IsEEt2TSNdOp/6l8RgCsnZeHrFadkekelFkx8YY7WAEgJxjLuvcg6D3CByVb?=
 =?us-ascii?Q?cjujvdPhNeRElSS8aULkiNKkPqQL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2vY8fFn24+bffGt6hCujBVLwAjdwboesZAKmydlk7AQ7xa6T8leOXdu2xBMP?=
 =?us-ascii?Q?tpGJOzk/lbFohNNhtlvk8qeedBkxokkHrNw5jdX0QbOMjpOb78IIt7RjRl6N?=
 =?us-ascii?Q?vBcJDMorS4JpoO/79ktV9uXblVBV3QJ9vhogSS9lJIETuIhOREDq3ysMIsfc?=
 =?us-ascii?Q?dy2DHYgbEFrZkBpUVs7G1eqcblgcriGexB4hnGSUqgc/TDXxbdLaMuEbPnrS?=
 =?us-ascii?Q?Qez4AjOLMe6ML6L95mAXFNHS/8KEj06Ru4WJ2urGtq34sGJCdtWyFKMFx9Dz?=
 =?us-ascii?Q?+FEY6T6/ju8i4Xj8lVg6RyVJg6v2aBhG/nfZXidtmySN/l1n48m4iddH1W5/?=
 =?us-ascii?Q?9djr8DZyo5GS1qz94WtnzXAq1YU9cXcFBYWPKQOOFa4gpTxKXo5YQP4EYabP?=
 =?us-ascii?Q?ZDs4IsSKYIGQT7gG4N54emt9+4bdNgszJqZDK1M+z1VcRyYNn+Fa+TvFPIM7?=
 =?us-ascii?Q?ExbV5o3xFH08QpEt3R3RnsJcKheIB3sOnZLQvcjSxXNywBeTE4cQCq+EEZk3?=
 =?us-ascii?Q?f6f0KjJvC8rLsm44r/CLayl1kti7PhUOYCpk8rScTz4505ZAXT3Z/eGnPvm3?=
 =?us-ascii?Q?SkxDYadtr4/kIleQmc8CiUeeHIe3W5bDOuDWIgbZcdr1RggidES334HC6aYr?=
 =?us-ascii?Q?TThbN/DUZnHZJtVcZOC5yoAFBm+ris4uOJ/tfR43eCKDAHBvhSaay/KKiR2t?=
 =?us-ascii?Q?PWl9oYR6Pvffp36ltSQWUs7Xi0SykuFL1V4DvyagK9VDrTqD3+5uQVcoSzz6?=
 =?us-ascii?Q?HL7IAR19Eqss/SRpzffU0XhdbhvtwWJwEHb4v91e9KHQmQsrrYaHBzQ1/hmr?=
 =?us-ascii?Q?bbVMsGqQdNUcZ+8Wx3DE0RetagW1DgS6qXa5Hm0NSn0QrZ0we9rmdX68YdSw?=
 =?us-ascii?Q?0NlUBM2lhTmNoJe+Ie4l/XExiBDYwMA3o6XAypKdEZAEj7bNk+S7WLp2Xfto?=
 =?us-ascii?Q?olOFHJIMEF3PrqS3nK0FYlKDWaPwu6uknCaw+wogKzZkmo84xy8LhriQhcaO?=
 =?us-ascii?Q?hAqNKS9XDDxJWyju8Hy7Erpph609r3mfKl1agCDGUJvPClRgDRARhytObaWW?=
 =?us-ascii?Q?ZaXQMuC2ZzAcOFu/66zJrCBo03F4eA0xBE0n2T0x9rZnlY2QL2632KOexqRo?=
 =?us-ascii?Q?aCAOzRigiqNQv24P4WyPKxLse76HB4x+ZY0OaCoWrW+wzgUO/1v4J+hBd4dl?=
 =?us-ascii?Q?SPgN55FM9RN5poUrrXeNpGXAhOx8HCcb0RzIulsFkcXClEz/KrAjFYXDCNBY?=
 =?us-ascii?Q?lsZT+F08X6qmV+HLHzjn2ggEgYeu8rGQKuWy8ePZjf88nWbayz1ZDhb2iVz7?=
 =?us-ascii?Q?DWuciDn/b9SJ0CApJ4cdkSBBww7DR8S67rnIVLjse2YhLhxwqFtnQqxtv1ca?=
 =?us-ascii?Q?cPOAETLJD1sMGpWuTnswRaINL/5ka5UM1og5dnn86MveSnye7y1Bg6yNhRpQ?=
 =?us-ascii?Q?6a7OoJjK+CUbbFiViQJSteJT/OJBIAnXFNq4mFFIxLi8hq2GzH05eWNGFhzx?=
 =?us-ascii?Q?lTof8ZkLb9/EHMnrQ75lw0yW0cm7AVfi9So3DdRiIRuYBpz396gmNsgqxt70?=
 =?us-ascii?Q?Av+7JWCKCZEdPOJ6v6FZjGbXvuiMi2URdSaWGVxN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a860d7-7e48-42f8-4808-08dd57a86aec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:31:42.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pM+G6CnOGDCEo9dW+4G+4/iYi59urSlaE+FY9Zg5KN2kNvBPR6aFKggjarxrH2T15x+vczGE5PzypnxGwMbkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

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
index b7f805d..bf6faa3 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -677,9 +677,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, fuse_wait_dax_page(inode));
+	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
 }
 
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index b1f9f15..1b5613d 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3020,9 +3020,7 @@ xfs_break_dax_layouts(
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


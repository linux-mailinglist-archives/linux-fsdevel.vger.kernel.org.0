Return-Path: <linux-fsdevel+bounces-51742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16531ADAFAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD44D1893655
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952B52E06E6;
	Mon, 16 Jun 2025 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FtzGcqUj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A02ED858;
	Mon, 16 Jun 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075181; cv=fail; b=hhBBnz2JXCoq/MSUU9Qn8+C0CTh0WZb/yiclI1PP05qk0h2KCNMYqmHxhKvAkanNqjGemLLytUwcteEfaBQ0fVgS9g+9Ws9vzpGnijn9WQos2iPG6bdE85uXzxF86P5e4O1qCimo2szyJDpqMIe+HcRrPJ+KU4vT2aeIMogf65o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075181; c=relaxed/simple;
	bh=Vyy/GDwR6Qfz2qcRvbtVm96G2bFRr4MB7Z1v6d/PAoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxO0pSyoLFDiv2iQnRKllYZdsGOX1QGPY+WAQUHINgJ/1iheeyfUITL1w5iz7WVj7oUAXQNDb4GPQZVlvXuUC7zNYA2IJwqi93QblotOh7z4XfiGvRbe8fbVlgqJ5gdjAX2GyKDLH9Z8J2ZsQhFBzmnRhItobvYsFu1a8AsBlx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FtzGcqUj; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+W1Efh79ovFGZR65H0g7uplQjUZ9UP4I8vxUazr99wTgaKUkuy4vLtkpxqK2bKyOdmBL2UHz3EHuMHF/oDKUTMwwK6mVlUTf7NQqqahsjd11fkocmIUBETaK+XMDaSswTw6TmYgv9oidx9Urxv8iZw5GVhuIltWrhiLaMV6QOlgD4MypNd8+GW5ixGPhUsV2KAZ5HDa2ug8baphxL3xaDoyD2fKx4oBTuySruovVjn4CL6RDjivKSxTHTZChiO3+AiMSXIOwF/FI4aUSIishRVduUi3EirGsEanT87dOTdQWlhq6IVBJ6BI5e2dAh/kWjp2Rs+7FTbZrgOX3Dv0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq+hCrEltOy/wddrH1NUoy25N603ZoUbYjkzFy12mGo=;
 b=FOlw0f7OB+VB3nkDD00s3X3P2QWXbVvh9vOLoEaGiYty6uCc0q4JPHPp+akBqQczEdmqlND/UqHvnbABWDOlxPPI3IVyHeeIQRFte+VFhkXeXKqtkysUW5xTMj4EP4MSVmPK6UnPnKDnb1Af2zqu773tkQwQE42XHJU+0tyYHhrVa/BnJYrt5LKWlfDpIM43pJ2MPC6daKtDWfLhgDJFKvQTy7xuh5XvR7UpvAAeeE1mEgE0XVxgMGxXLuqQymSof+pcCZH38BCOqimMg7J+vLRUSuTpbHcn/6UQcBidOxo69lF+rhgqvh9PsHnO09+JYVcYKyB6VudD5l4mVlJURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq+hCrEltOy/wddrH1NUoy25N603ZoUbYjkzFy12mGo=;
 b=FtzGcqUjIEU/FKvJ7otLeHqOeHaU5aVvehJUIth0jqnMoeNfzTJF2sg+iiwMbqkrPBFk3UYNVUmZORvNSbJcUWdr7mDF3ZytOilk9VaxhLLqgXLt/8KRaXc8CBkacc2xt23y3gD8XrhGqC5WD1q5pQSeQZAsJ2O2yRSJQowzk5T10Lajst7MMeqVuoghfOgIazlwMIP20DYMGLoAVVfJjHt1OQhfIiHXkB+47TY5ZPaS1tVAnrw9BO7ic7t0Gi57vOrOBp3QqopQFs1oQ8fmCBbBKLvcuytpeMNdMV9Rd3qgWiGxrAucwpwClk2iKe0G3/6GeHzbFTsbyUC13TLItg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:59:36 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:59:36 +0000
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
Subject: [PATCH v2 12/14] mm: Remove PFN_MAP, PFN_SPECIAL, PFN_SG_CHAIN and PFN_SG_LAST
Date: Mon, 16 Jun 2025 21:58:14 +1000
Message-ID: <3a43a99bb4b34567bed3bfe60c9ae3533aac100d.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0130.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::11) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 49890dbc-c2ce-4a89-d53f-08ddaccd4394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cY1MznLGJjc29RWBAVVuTcYN54mLr4n68BDukAN5+OO7WWCXRfVa8RRnYUPe?=
 =?us-ascii?Q?UOorlbjZ+iXmDqSrvRzRZsCk0xF5siSbbAuX26EaU8P8eAzaduPYpufHw2xC?=
 =?us-ascii?Q?Enly7LkAmqHZgrTyM5re+JlxllRiXzp1ADgOBGZyz2iX9hLeF6JlLYUaw7Oa?=
 =?us-ascii?Q?NwEWLLTEP9o0dpZZ08OjP7m3ThaCJw/sGB7Yjas9F+rbiPs0nOBfyjXC8ffM?=
 =?us-ascii?Q?3/AgFF9PU3vGNZh87yiqoWZP9WbUufuxKZ60jIzm/V5j6tMIaQRAIEWs3XKu?=
 =?us-ascii?Q?JOLSPTPaNN5GsIZkWpu4wxa8OdwHxQ/Q6e1c1ZTxh+09kpkAYdGbGROdnl0P?=
 =?us-ascii?Q?/BUN4oc6o9mWOeJ98DIDM3WxZvyju8lLcFkyRO9Yk2LFLqDpcdyGIk8tqTPr?=
 =?us-ascii?Q?D0V4Muj4ZDqSPQjpujTVoO3IeRfKpz3Zi5Ftu2qZAsIws9oPwuKW8ucyc1eU?=
 =?us-ascii?Q?O4LsaIEKREWqywKAAXMwGeqhelKCRZUWxYfbsnM6y9N2hdtTA5Xgmq2RUH7N?=
 =?us-ascii?Q?skF2Wi2N9L2eV2SxBuGjwK7J66MHsC8PlFCaOXXrloSMGOeXl61a4KGGx0p8?=
 =?us-ascii?Q?eQDt5LknMlRpsGIaMKsjm2eKj155vjb4wZjO9GDrUSwUqLtS33wpP5nKh7OI?=
 =?us-ascii?Q?e/FPx1KfM4szAKVHur02rGA6CoqJH+2s8Wksy3Rza4LauZi1gvkaUR7DAGEE?=
 =?us-ascii?Q?xLp63lMkiRumI7Ev2Q9k9rK82KxSBSQ2OTkKseJBjtKzDaHqY9mMmP585Y9v?=
 =?us-ascii?Q?b1ZkQv9Jbvq/4VJ3DlXHijhSuKS+Yw3A3om+UuqBd5GIYD9Ft4kMp2yymMQz?=
 =?us-ascii?Q?GLfgHzMbKBIGFCr+i6/rCEBhTHo/cHyRMeGDEUqPcGWcu7sta1UgYvzrxZUE?=
 =?us-ascii?Q?hiscaaysdzLAubtly2/ixizUBuO+rHremA5/tlaG+wl+j+mFOWjeACo/tR4M?=
 =?us-ascii?Q?CcYCpnEKxW3LjdaUvoowZq8GgZMuzS2dbq7lxPTAQlpE04SVBfJi0J1A53Ip?=
 =?us-ascii?Q?jVmCscIe1Erp74J+OZkJLZm12/exj1xN2/RIxc/1fnDP9QMFCMuK7GbbVkBM?=
 =?us-ascii?Q?s07yuJRDDA9mkP89WkN8grQFkxcUv5gu7xEwmmzI7jhYdUjiIhvGS9xpkfxh?=
 =?us-ascii?Q?EQhVW1ikQKEoDtB9NIIplPOlNuwKZe6uNPH5s903PgTiS/qvVYbjoizGaSzM?=
 =?us-ascii?Q?A4PIVSLQzxfnKRIIWyRcpA8+3YgXtjCOJ27xFwV+WB19c2CLtPXsxsqThF4C?=
 =?us-ascii?Q?YIzHfHjpJVGWweW20e3s2AmrEZt/5qXApJlOfw4aCynHsoULiCYBuFaAegzV?=
 =?us-ascii?Q?/eLYTUAIylN6maUeyvJ+W/+Yxg0Hdlu9/anhH3R7GS+QrSwpAgWFy9fcfzHD?=
 =?us-ascii?Q?1fuKyCtrjB7tBc2rk0X5HZRNU12x01SxXwB/qXhapjSUAkoIq5h3yW2SBfOM?=
 =?us-ascii?Q?J2OAPyautl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D469sXoDiEtLsQcx8u+kVzINvjjVnadJJPAC9RhCmsNpe752vpqaKtHNubS1?=
 =?us-ascii?Q?wK3JvezBqY6+BRzLZ/0bwQ4dsnXqgqXW2jhaMESBTmCjEtwlna80yMjnbxvp?=
 =?us-ascii?Q?VVl7+YgIa3aBR/9JvUElC+1YVWbVC2ju9p+I3YMRHyS8Zw7D6BVpKkjeeZDy?=
 =?us-ascii?Q?yAKrJazBbp3LhfNOq9pkkBAUws9C/V/eefTw9YbWh9eC2+sK+0RCGHoRJkLT?=
 =?us-ascii?Q?FZ7ngGc8eQ0dCSA7Qu4fazpvLZOHRSvPa9YvKMCrbqH7TpEOadqfeHvsjwn6?=
 =?us-ascii?Q?8Np7V77/kz+/vqsWrtFv4htQfkwDS/DWzEkWmx3MWQrDlzTJdENfyeXTTN9K?=
 =?us-ascii?Q?RrmpFFcTrKxkKf7qZXW4cLwDmht58cooplCb0iILvfDvtRWnuUD5VvT1fwZh?=
 =?us-ascii?Q?nYzXTsWLH8idWBHp+YEGV/h5Sq/mjA+nVL0fDrZAfTtFh8Nc3K6Qt6XR3MPS?=
 =?us-ascii?Q?yx6IGIKxz8UqoSi2Ci3bF9X9R/K5xoQylarIisLS1DSD9FyGRW6ImQCZbDGJ?=
 =?us-ascii?Q?SQ8ZzgXrmiLk2hPZAbe3YG7Ut9t6xYt0MVrYuR2LCQee+6plnabxtNhuwAvA?=
 =?us-ascii?Q?NpZTQcoJPLVnwik7bdCKbd2xMb7Jdtg7lVqbhYpTYdFm5n8b3F8OqSjbMZRa?=
 =?us-ascii?Q?gHVViix/SVHR8niXcUVwGKlvxVUKdwcxjPiklFdyFAm/MdGzqq/8QOFEmlVc?=
 =?us-ascii?Q?26KVG8XXfEuxqrmYZ/G1cHwfUgeFnGisQLeiPB3IUPYzAm2242mFfUVXdRMD?=
 =?us-ascii?Q?Hf4gRQR7rVM7rqjsdCJleCmjMI45b0gUWQqFCz1OTW/ijuKYPRAYHohBeK7p?=
 =?us-ascii?Q?zX2eZslsqhh8JBBQPzAF9seRQ+mfQsU7+QoQpWgQcxifLNt5xlJsr0GEM+Ic?=
 =?us-ascii?Q?/dBJrBp+MVhI73k9WuCEMZv1nLYo69lWDRNeonjvR7UnNRAtXZ0pYe6jNHzU?=
 =?us-ascii?Q?IB2cqSdVZYbcqjDAn1KHE2uej6mbwGExQM+1WSgVy50Z0ZT3d/5BFDatV9wF?=
 =?us-ascii?Q?J1cPrNqglUC7WkJI8AhZ8uqAxKyIQ+lzYkGW0rwmBd8CFM7G0haTzo0Q7K2C?=
 =?us-ascii?Q?A8JLVp7mv3BSG9S8qYhJntPPbszOXA0jFfQT/AX2z/EhWqxoSxcbl5vHmtOH?=
 =?us-ascii?Q?PFv9G6VboiyuzePUfK1DCciE6HH3YCgWQAg8FWbYyXiVpooX6RgxSh+26Shs?=
 =?us-ascii?Q?Ksj3TF9fGUXDN2H98ZNDq60roeYcnw2oYb9b7fV/uXe9FFK1Gx5OtAOT5p47?=
 =?us-ascii?Q?v7VvF0kQ1Xly7P/TRLMYWI68KR/vgtYYDxrAVqFBC6c1I68Ax3JDtweCEq+m?=
 =?us-ascii?Q?4ZW2kOLSJW9tRwQ9qJLTb/mthSmB4nHdrDs0ehYv5calBzmf+l07cX9wi44B?=
 =?us-ascii?Q?g4SVLLASHMjxG7doSDpUJzUMahbPg9rg2ykU+kc/VuYvciIAb5MLsboWZApQ?=
 =?us-ascii?Q?+bUev+mwG45CE/welc8Evn6gECcn2GK950tzLAE4TMOaehAgjKk1AhVLehmZ?=
 =?us-ascii?Q?eAdSeGYIn+xt0R0LT3SieRx9qBGx6IRMNvibAvy4c+Qskkf6xw1WO3Gfy95h?=
 =?us-ascii?Q?g64Sc2FMC3RbIN1Wifg/FQMGY3N0JLrH+fgUl5Px?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49890dbc-c2ce-4a89-d53f-08ddaccd4394
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:59:36.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLGxET3vwyt3g6ZUxaQpxfN4F9B9jVHxS0QH158i85EBM8qMvVX9LyEtV8+7KzWFwybZmfI41OweGMHVV84IVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

The PFN_MAP flag is no longer used for anything, so remove it.
The PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been
used so also remove them. The last user of PFN_SPECIAL was removed
by 653d7825c149 ("dcssblk: mark DAX broken, remove FS_DAX_LIMITED
support").

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v1:

 - Moved this later in series, after PFN_DEV has been removed. This
   should solve an issue reported by Marek[1] on RISC-V (and probably
   Loongarch and others where pte_devmap() didn't imply pte_special())

[1] - https://lore.kernel.org/linux-mm/957c0d9d-2c37-4d5f-a8b8-8bf90cd0aedb@samsung.com/
---
 include/linux/pfn_t.h             | 27 ++-------------------------
 mm/memory.c                       |  2 --
 tools/testing/nvdimm/test/iomap.c |  4 ----
 3 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 2869095..2c00293 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -5,23 +5,11 @@
 
 /*
  * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
- * PFN_SG_CHAIN - pfn is a pointer to the next scatterlist entry
- * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
- * PFN_MAP - pfn has a dynamic page mapping established by a device driver
- * PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
- *		 get_user_pages
  */
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-#define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
-#define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
-#define PFN_MAP (1ULL << (BITS_PER_LONG_LONG - 4))
-#define PFN_SPECIAL (1ULL << (BITS_PER_LONG_LONG - 5))
 
 #define PFN_FLAGS_TRACE \
-	{ PFN_SPECIAL,	"SPECIAL" }, \
-	{ PFN_SG_CHAIN,	"SG_CHAIN" }, \
-	{ PFN_SG_LAST,	"SG_LAST" }, \
-	{ PFN_MAP,	"MAP" }
+	{ }
 
 static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
 {
@@ -43,7 +31,7 @@ static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
 
 static inline bool pfn_t_has_page(pfn_t pfn)
 {
-	return (pfn.val & PFN_MAP) == PFN_MAP;
+	return true;
 }
 
 static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
@@ -94,15 +82,4 @@ static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
 #endif
 #endif
 
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


Return-Path: <linux-fsdevel+bounces-38524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB922A03620
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62E11641DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEBE1993B2;
	Tue,  7 Jan 2025 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iooBkX9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F51E1C2B;
	Tue,  7 Jan 2025 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221416; cv=fail; b=Sl2SnQ2k0tcYaLN+wRoZwdtTAoL+p5THCdVZDFgqh5ytIQ34KBpzGiGjfioulHHhbd4H8KU5z9cL5TbfWdffENmOGCdge5lve5LGlcxWplWYpcuLBP7qAhXNjohOGAvAsfec0bZerT8vt48t/VwphMTCAjDDkIrzisszlhzMNDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221416; c=relaxed/simple;
	bh=FDleqUDEtdB1YSQa50VaPvs5gN/6lVm60NeLESWAhys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8BG9DjITMGpweTiJ18O1ju976a3+9MniA3N5Zq+q79xcISVXNBPntp4wipG1PcrNT05rwcnlDLoPtQCJ63TtuI1SsKxKGZEm++X2sjicoE+pfstIdzlqXGH06E3K7YqhX1y+YSSDJmVR97rd47+wtPtRl5WruW+h8P4lGouKPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iooBkX9g; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyPVc5tEDesJWQUF9DK8YikG7YwWNBkyMcigzoMrF5YUf86eJ3EUv2Nm/Ap58Pq+9BMUpVvLmvqsBlO4wD8VZyoJujVcbsqOhLp+Pu4nENinGkAoyIQRduyiE5sCsqFeXQw27MrSPluKGeNLqib+RWKGUhD3MHrHBLcTn8uJMTwbzzu5+Ko+oNBf7+MpxDZ10/URz0fRO3p/x4/jEG/Ai6T1eUPM3yJDbs+usjtoc6K5CSvGt1aVXr3LQgwDkX95q9R6my1RAga5NVNz/+EWINiyRHpve9hHRR5iSpzWq/p6rAiYO/dNdELNMIaHoC8h0UCM8o/UpBWT2kBj0lRraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+5E4H/DuQ0pAoXXKbxaYAoc2WqaY+EzxUHO8qCAqb8=;
 b=KZovE0PHTx2hQH7C/R3Vwf5VoRmfTMb7CwvI7Vxo2n57vpw+0ZQegsRkKOFXlqNpn/hrSBGgojW3Tex4y8+d7JNbGYt3iXGB9RpaM/FjoqJ6njEoLcPTmxo4KWQzYBKvRzhihEa8tmye+FIrY65aVkA4a0Y+IBwaxBf5+RINWAoPZywo9ZEyceJKGDOKD8TR4RVvaMN5KNgEXFidY8aJVfd6QmyzxLY9T7i8big/Szxa1exqIUTxLWyIEe3IgYMn3Uz+nLKmXvCxREJAWlSXP8N4LyyaH2/PIQ04wFXWae/M/1KFUr9h8Cv/z1kJCSfrERV/pfqR3lz+f6uodC5+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+5E4H/DuQ0pAoXXKbxaYAoc2WqaY+EzxUHO8qCAqb8=;
 b=iooBkX9guxasd99LQ0r0tDnTlVNZgkwoJWPmiVJBS/vVGwEoniO5LszLYvUggWHxyBfUt1CGsosD32atgH4LUqBSg13QI6UMtMNoMQpH/kADHwypg9YyA95X9TJsvXhmB2A+rkAX8t98xrXV3iB1Fd9rh/LWi7jbHDaqvlJfz41u0OIkR0tumiI8AqXivh5XyspNUUbUfi78ohiopLFzMbMsYebMj09XXSA7vvRqeE0br9dUJfGzdidRN3mj0dJUOVBHecty8+JZLLwOhWE2GSXHSkIPtGgNxWbqLI+eS+6QgoVcAIox7rlaOidqc8hQx0YMaApAP2LShYXN+2GwTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:25 +0000
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
Subject: [PATCH v5 06/25] fs/dax: Always remove DAX page-cache entries when breaking layouts
Date: Tue,  7 Jan 2025 14:42:22 +1100
Message-ID: <fc4ce7ac0815bc33d00ca6626925a1012473ff7a.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0113.ausprd01.prod.outlook.com
 (2603:10c6:10:246::27) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 46086938-6d30-498f-0a4d-08dd2ecd7104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sZAWhGhHkG4ZvXMkOlIErft5/lwwZCT1yz591VXcZmoPKAmzmT9ucNkcv2KG?=
 =?us-ascii?Q?HhNgdQ6zSAJkxBQaNmepnoarxaR5SRzWzXLAtFmBtyVVnKs/idw5VYbIB2Nc?=
 =?us-ascii?Q?K6+vsFbaqOxAibBrplo2+V3i+te87VKB/dETD9d7iy+ocdMH1cjFmJXelqiT?=
 =?us-ascii?Q?ZUbJzrWoNjGlYEjQrG4dm09szrhEI9zMKk7WSUc433TFpu7EjD7oomqITbXI?=
 =?us-ascii?Q?MmDvdCYDwjGZVxlIXZ3wgTnZ3ulQWpjRsGktc/i46tcgBwTFXkDYJonVKgdE?=
 =?us-ascii?Q?cnyGC/dBGtfRgrKKlCqtZN6vBpfKeflsajU1AXCPWrXLWlXNUzsDD3Bl8zec?=
 =?us-ascii?Q?GxXztoIckycgPDADfMvghEcWMWPnHfgeoLMpRWFbuvLzU8H4RPTXTs4GeGP2?=
 =?us-ascii?Q?j4M1JdFBlWrOhZMKcU+Q0BgtMY8L02HpIHVSzjIjE+DjNPpccFDXwAGjfvwF?=
 =?us-ascii?Q?U03tcBEY1yzqh/pY0FQ9vJsPdJof59AuFY7xN0gjTR2cuunZiBH2pxndNmec?=
 =?us-ascii?Q?6heKvV0F0alyObxW8XqBEmbQf58GcbkoK/3Ok4dsU14pKX746R0MK+oFoTK1?=
 =?us-ascii?Q?uVkZDwXbreW4oIWzWFLbTgezpU/vPqte6vUnNT3PO+SUeHBKUcJ8RwXjKSWD?=
 =?us-ascii?Q?X9mcxV57bJej9DYW5p/kw027WfIqOAavq1ssYNeHwdumK3YmIFOoWSXfhB22?=
 =?us-ascii?Q?tnodnpwG5Gtz2wZ+3ioLHGgWMW0qZd3qRQW9iBGhdIotRkCauApMvvnrdg9f?=
 =?us-ascii?Q?r8ctXO1yoiZ22jh7p71YjlVgtg03v0IoUFXcHlm+lPrw6HWRUUKYv1LM6ota?=
 =?us-ascii?Q?shPeUU+UJ4nL4Z6m6pDM4DQ3kjId7p4zAd+o8XPlArWkTmQjEF99faELOa4h?=
 =?us-ascii?Q?ArlI1y1S1RGJtsHDKHqdCKG0/qKif+gmCOhi40/5HpG958V0XXiojLzNPFuS?=
 =?us-ascii?Q?01URpO52ftvcid7xTc3QsuIt/lphK6D5WT1iyR+5WhwV5zS60VjDlGmDpI89?=
 =?us-ascii?Q?rT6SRkEkoP962h8VIbsRpxjO2hExPowl+BtPQ7GHdg2GLtQghnjRVlcKPC9u?=
 =?us-ascii?Q?C9e+0RoHpvUVvsAYR/yTVTHUlnJCNRrwat8m6iudNgd34NQo3F6dJcXVXAgX?=
 =?us-ascii?Q?0mKsbCiC8SdkU1PBF56v43Ey6gEFcEAuhn/Odmjdpn22rSyrtfXS1G2A7fAk?=
 =?us-ascii?Q?ncq7KGKGWHV68Cxzj0pRWq5N/nxaBFOtCcnExbDJUbrSRXcKxoKGolOC480C?=
 =?us-ascii?Q?rC7wlyFZPiBr0Ylw5hG2UFO+2tosuyLcGm+qbO70MKu2kelrgqg0KgWt+4ME?=
 =?us-ascii?Q?5keEWPXcB+O9IYiyDhXSTWZ0sLV2HzfIPD9e43tvTFhZh8jMMaOUdS/dbb67?=
 =?us-ascii?Q?GIXgLmgLpzMuoQHPNnlnzhpssXLu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LVfxsa5cUf3rfMY53+hxL39NSk+lOS6MtN2/Rv9nxGPXlFT5saV1xdvvOzyl?=
 =?us-ascii?Q?IJCmFHv8Rh6nf1VshmqFYYuCISzrYb5bQJ3MZ3V3bI3PKLUCfbPYC49m4yss?=
 =?us-ascii?Q?3JNU2mtMlOk390lsDI3Me7re3R9BRR4nHRpRW615iAa8x9qXqh0Tl4CnSYIo?=
 =?us-ascii?Q?byRPCqaAQw4E6xA5EKI+Os2wMyF9MK/wGpao9xX3TLnZaMtwrlDXKjGHD+/O?=
 =?us-ascii?Q?qkVQYZ6OJA39okT1tPWt1YcMcJi0WGPIsKPFnvjTN+Xw0X3U3sUh10v+YpiW?=
 =?us-ascii?Q?hrX3EU4yXhqz+dcLCMFtkdNegXcqChJgRz+2KlNvOtx6Ban1YV5lzGRoZ3En?=
 =?us-ascii?Q?bj2TgosotYJNuGwIyW/In5jap8HB/CouundmRR+LPDOV5/WfBEq0ipfVvBsU?=
 =?us-ascii?Q?nvjHha1nYXu13SQDOTriPNKP3/P9f8fGo3zWS+cOtWHdCnDAxVWHzj1fpGGe?=
 =?us-ascii?Q?gnWJfHbMA/c/U2S98Zhqd0E/wJE4oMrJA89RAnPxmqy+kwvUyfj+/WKmWSsm?=
 =?us-ascii?Q?3PaSYCY98Yi7cmvn/ke25Q4wAPClbB7eyPrBn7ZVSPcPtaTKbi8y/vACLiMa?=
 =?us-ascii?Q?fsaBVurXYVFsyYBYhhILQtFs3i5GWubbM4yia12OQEXRM+2QvvYqRHWWsckH?=
 =?us-ascii?Q?gCDzmTFSQmBxl9UYoII2NoMcxkiY23K1FANDotzlnSsV9VtEXYZQE1yqOtOi?=
 =?us-ascii?Q?2HwEFKZfWpmfLTdZz3yPsms5W4SXpLCdfV9+N4XRjQmkG39Zp/5kagfrAefq?=
 =?us-ascii?Q?hKVmbSw1/9AxRFEHxnjUx5CJRlEZgmSg8LNARy05cX2NjS3jBEjpLU3CPs68?=
 =?us-ascii?Q?aweiXOiBIay7AuDzX4rI++NfDP4JZWmOQRigZ+CyASBgoTI99jqY/uo7qhAZ?=
 =?us-ascii?Q?4Oxql/zo71L/uF2cdAX9riD53I9MJ3/JEyx4TpnbPujUN17wmsHl0Suo2qlV?=
 =?us-ascii?Q?iR/1NtimPJa8M0bC1P0XcrNHsd+LRDva6NpRdkaCoNRuuTydfEcYWutHnE0y?=
 =?us-ascii?Q?PrvK4ckL1QdWMhb2MbgF22riLHXMTmAVKFuvk/3UbHukaVgQEFamAWa0FQYD?=
 =?us-ascii?Q?b5M9O5VkfIUkluzT4tAlizxTDRQeT6uLCykFQFib+JE9Hw95YiSntnZrmX8Z?=
 =?us-ascii?Q?dcZj4CEhm6ZtX6Jzh3nJmdnOAeTWj7PYYif7Nycxb+74+NE6hLWDpTGtqsvI?=
 =?us-ascii?Q?2zu294ChCa65dCfwHa0zQlOnFMU6EgVChPw7fHRYFja6xatWG96RCjxhFGLd?=
 =?us-ascii?Q?sQZafokwrU8xcDH1azEM9NWWyM9VEqEUSn6COl/pjskPMK0LKqz8LNQFkFH7?=
 =?us-ascii?Q?GW3s6fFwl2l14oOFf/4HZqyC+yR5BDlAK0abtRFakOG2UL+/5YeYqifMRShe?=
 =?us-ascii?Q?BmhKSOwlYjyNVEorZ3MHVItkK9XiiLAJ/lnGF1Op4gjPQZSfABJmsGSnZizL?=
 =?us-ascii?Q?STp836XJx2LxtI24aYYMMD+5Pbv+KGCg3wNFiTSipwDQJJG3dTPEXiVmTBj6?=
 =?us-ascii?Q?HwRpEcVHGqdNjsTBDGeR6B5NUim1oX23aeOm/x1k2XUsfoKsv+gz1zp6Lz12?=
 =?us-ascii?Q?dZINnleGM07APz6bare3wowzH0+vJvMfY63GJ8a/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46086938-6d30-498f-0a4d-08dd2ecd7104
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:25.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ou0Zum6f2ZNu5zu1DPN9BtbfEmQXa27OXxKBlNm3ewcvIpWYIvLh+RfDkFZFadpJzemO0EdvtqNQOK2S7o7icg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

Prior to any truncation operations file systems call
dax_break_mapping() to ensure pages in the range are not under going
DMA. Later DAX page-cache entries will be removed by
truncate_folio_batch_exceptionals() in the generic page-cache code.

However this makes it possible for folios to be removed from the
page-cache even though they are still DMA busy if the file-system
hasn't called dax_break_mapping(). It also means they can never be
waited on in future because FS DAX will lose track of them once the
page-cache entry has been deleted.

Instead it is better to delete the FS DAX entry when the file-system
calls dax_break_mapping() as part of it's truncate operation. This
ensures only idle pages can be removed from the FS DAX page-cache and
makes it easy to detect if a file-system hasn't called
dax_break_mapping() prior to a truncate operation.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Ideally I think we would move the whole wait-for-idle logic directly
into the truncate paths. However this is difficult for a few
reasons. Each filesystem needs it's own wait callback, although a new
address space operation could address that. More problematic is that
the wait-for-idle can fail as the wait is TASK_INTERRUPTIBLE, but none
of the generic truncate paths allow for failure.

So it ends up being easier to continue to let file systems call this
and check that they behave as expected.
---
 fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.c  |  6 ++++++
 include/linux/dax.h |  2 ++
 mm/truncate.c       | 16 +++++++++++++++-
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 9c3bd07..7008a73 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,6 +845,36 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end)
+{
+	void *entry;
+	pgoff_t start_idx = start >> PAGE_SHIFT;
+	pgoff_t end_idx;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
+
+	/* If end == LLONG_MAX, all pages from start to till end of file */
+	if (end == LLONG_MAX)
+		end_idx = ULONG_MAX;
+	else
+		end_idx = end >> PAGE_SHIFT;
+
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, entry, end_idx) {
+		if (!xa_is_value(entry))
+			continue;
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
+		if (!entry)
+			continue;
+		dax_disassociate_entry(entry, mapping, true);
+		xas_store(&xas, NULL);
+		mapping->nrpages -= 1UL << dax_entry_order(entry);
+		put_unlocked_entry(&xas, entry, WAKE_ALL);
+	}
+	xas_unlock_irq(&xas);
+}
+EXPORT_SYMBOL_GPL(dax_delete_mapping_range);
+
 static int wait_page_idle(struct page *page,
 			void (cb)(struct inode *),
 			struct inode *inode)
@@ -874,6 +904,9 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 		error = wait_page_idle(page, cb, inode);
 	} while (error == 0);
 
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, start, end);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(dax_break_mapping);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 295730a..4410b42 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2746,6 +2746,12 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 		goto again;
 	}
 
+	/*
+	 * Normally xfs_break_dax_layouts() would delete the mapping entries as well so
+	 * do that here.
+	 */
+	dax_delete_mapping_range(VFS_I(ip2)->i_mapping, 0, LLONG_MAX);
+
 	return 0;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index f6583d3..ef9e02c 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -263,6 +263,8 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		unsigned int order, pfn_t pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 int __must_check dax_break_mapping(struct inode *inode, loff_t start,
diff --git a/mm/truncate.c b/mm/truncate.c
index 7c304d2..b7f51a6 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -78,8 +78,22 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 
 	if (dax_mapping(mapping)) {
 		for (i = j; i < nr; i++) {
-			if (xa_is_value(fbatch->folios[i]))
+			if (xa_is_value(fbatch->folios[i])) {
+				/*
+				 * File systems should already have called
+				 * dax_break_mapping_entry() to remove all DAX
+				 * entries while holding a lock to prevent
+				 * establishing new entries. Therefore we
+				 * shouldn't find any here.
+				 */
+				WARN_ON_ONCE(1);
+
+				/*
+				 * Delete the mapping so truncate_pagecache()
+				 * doesn't loop forever.
+				 */
 				dax_delete_mapping_entry(mapping, indices[i]);
+			}
 		}
 		goto out;
 	}
-- 
git-series 0.9.1


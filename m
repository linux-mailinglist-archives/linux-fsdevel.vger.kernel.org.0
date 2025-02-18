Return-Path: <linux-fsdevel+bounces-41924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9AA391FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867FD3B3B26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4451DD0E1;
	Tue, 18 Feb 2025 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PCZEoGed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95B1DC185;
	Tue, 18 Feb 2025 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851028; cv=fail; b=aalVVev8zHRSEgFmeFJ3Zg/fMh+2NWZL78Yla9WbEWhWTy/yVBRmnlYRwMFIeA0/hrAySCOOqqsAMw6Algm2n27XGQmNrbDz99uxC8RFJo3Pvk3zCotDvV3uxeenYx9uV8BDVRmo9xXa5r6rPUPkGJHWh6Y8fi8Gn8c2SvzIjDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851028; c=relaxed/simple;
	bh=4Knrsm1AVwFbpU5pBM2ITNJ3OGe+USlGdgFiYAe7yrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJDVeWmUaT0D0V13ADhwCTrtdv2qV1Y4hZiFvyFzt+TAzgkPIi7+SRc4eVq27IYvlLG3Qhpg2TOm1ydCF9M5J8cn38VBtnFcLdc8ZueCcaGV9GVIgK3BKWOFLkbd80hxpHfa2AD/SC4wTUw2Bi+yNV4LsF31dxhQDywoh/O5S6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PCZEoGed; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfmA+AIo6WhP3ppCoY3kmcV51YLBkuphcxeA9kkd0AWJd2pmlOWPW+loXcBOUgEEgNQJWABW7V1xh0pKqTDw14mSnAsqK8lSVIzCOLRUOnfMeYowJzr+PkjXwGH3G7dW6OWx1RDccsfQ4Mcqa0c2nc+x4gbUIE1T8gGVxog0fuk9aJOnmYR+Ma5Je8rPwDzT3ITtRPhVG4zItgDc5LNLYIZCSouyyQiOPp2JVv7/zAJJ+zajsNKNK5K+3tkjrsHYxeofZvba3x/VUheHoaZ3TZXxWybgNnPX4YoDomxvblaxjf37aAaJldNdAaz7GGovYPvxqKs+vkXkGCgrF8vd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqUAyvSreWQSx6y7bcA3/W+0/nsi680Xnn1rDdTp16A=;
 b=BbsKLp4H1XN1F4aC43+3R1cx4+eFIcVBu1IAxarU1sLlv4OJD/Th5FNtTzcFpgBnSiy7NWiIrEG6lZdKXyUwv3cqilCWp2rxHsIkTjzc/3qU36evM+XnfSDDRM8HnJaBEZkiHCX+5k4j9yujzGNx4VpFFKipg1Q1PFByAjB/XZiW3NcBdYoIycQDAz8ezpenLo8tzFlq92fCYH/kTNGXJUsMVjSblXo32VqZi1wa38WvO4V4bcE/UPsEVq3nAYzeT0cq7ISU0orheOh4RzMpagzy0Q4S4IeJKaQnTRDteIel4wfHQH56yrm3Ql8m15Yx+iZngG/ASa8xohIvNHeHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqUAyvSreWQSx6y7bcA3/W+0/nsi680Xnn1rDdTp16A=;
 b=PCZEoGedE+uoiy8USS/9KVKh8eC1ZfPiHLwZhp8R8xEmcYjhwKMPDwVCzg4aAqdvBCQfGnBqNDnr1vOFMMWl2i4Pm1/w8FF9SUZfKg8Wt9dcUdV/mfSHXmu0LFJHDyMVFM0dsVu/aZ47sJfh093+aMmac5X21tBNWhcxLTnioVUJwfmnUayN3G/HxQGfYwEh54pzMml3a1ZKFW5p42ZpMiH1UulkHFBuuKSwLezEfgsVMSe82NuXQ52vZ55VVDeS3EQlpa3lSORvZ5iXGsC9gC3dV1/7Z/8ogPgTIJq1nGlcNsRNwSzno1sB4IdhOfqACRPPzE2gOXxif+Asm+nzpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:57:04 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:57:04 +0000
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
Subject: [PATCH v8 14/20] mm/rmap: Add support for PUD sized mappings to rmap
Date: Tue, 18 Feb 2025 14:55:30 +1100
Message-ID: <56c0a4ff4b09ce1bd17da5e02a06dcaff4876bde.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0008.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 99732c97-5665-48e5-ec51-08dd4fd04e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0hgLDV27y8m80Pi8mSrVcWbxFAYTr1QAYhF5ECfbTOYOtmbSfrF3ULqkNywR?=
 =?us-ascii?Q?n/uD70WYKDtcfE/J9IWsskEBkzvVKvmEXLaiaJ65fC72FKrozpDzsjFiK6Gw?=
 =?us-ascii?Q?21k3A2BFharKEMiEIprbf1M3kv3So7q2B31Mu/4mA9hPS4ZEFWU8ijnH88xt?=
 =?us-ascii?Q?DxxDI/YRhidH+kkWeIbbMraXahBzRn4qA972qs83sR0YG3HRoxewcpU8PKhB?=
 =?us-ascii?Q?m0wn6iLj/5tlAQ+fWjfQyjbfk9xPD+U9cYPKkhMCbqT6U4rlmq4dPpGxJf0c?=
 =?us-ascii?Q?141wEBHUYWSh0cUaMNCcIX5vv3aGNz/nCoI8qT5gOD0yEjfNz02IpcL3pyT/?=
 =?us-ascii?Q?+rVO9fpMFCOlCiorhfbXM9A5mb8uV6fxCGHXy/C4O6NJb4EhBfx0N535pUzy?=
 =?us-ascii?Q?jREXNSUE1J2EJEWva0UbbHiEmAjPCIkNyqe1edkApsniyvoHscI6P8n3+BeC?=
 =?us-ascii?Q?3k1DXDvMoag2+lkiS9Jvw+XZ4LPFxhwgPY8dmQ+lNEcZJVtmULGqA2ViAV3W?=
 =?us-ascii?Q?Blbo7M7tzvySt5XXBO7jQekGdnNAcCjXI8bxbMy5eTvXBzk9q+Wd/8rJ1yDk?=
 =?us-ascii?Q?yfVHmeg5JOPtnixbVI1jW9SUa9M9blZ0G1SgV3pSZxEDlvicu4lOwlOjI5z2?=
 =?us-ascii?Q?H9ir0Kb9wkpBJMvlaHbITiOvhdzD7qoLpEgkZ2MH08xwl4Fv1vyyaC/RjgiO?=
 =?us-ascii?Q?uHAzU6dhXgPLt+noGONo0fzwlJfxFRO4inOp+e16HErBpSfH4OmijKRUwHeg?=
 =?us-ascii?Q?5kXhY/UN/ss3up1eBFZgcuiheVBYxhjGDEbON45PN0lAtNDyztsM63iGji83?=
 =?us-ascii?Q?J5Ks1FIdq/a4QhA6xxEMam8qtoQinjixnjXx2Usjkat92c23ZCfk4ymW4KlW?=
 =?us-ascii?Q?v2qEvdFvYVt8IHDHJM5I6L3SyPRMiPLT0tVayERH0AXgzeyg8oj9vlRzzIvu?=
 =?us-ascii?Q?sa+nj9R1RYXb8+EbdyOcHM1qC5xJh6U1rOty/ifs6/EAQ6OIw/17Sfa6lKBY?=
 =?us-ascii?Q?QmW8OgVYF1oK31BK9+qkl5LRk7DVD5mrp/sNef45zJsMegt51a5mkfkZxjyJ?=
 =?us-ascii?Q?16zWNOhVKcI037o7nXAjVaSNEpkEGfLvXG7iT7jkhfb3SMpaY7Go9s1L4wlK?=
 =?us-ascii?Q?bVUfqGUDuvlHNkAtqXT0Uym7zLeFsgzGyhik4mENduYfZAzMtRXtirOBzvoz?=
 =?us-ascii?Q?JGmdi9m0l5tY2MVEimvqC2XzvIClANouACEEkpU5Vn7yz9OV4dwyK1F6ABdo?=
 =?us-ascii?Q?p0G5fYxud1Oq8I/ENzRGbQBahppSVLS1OVbK30Cv9pCQYpiz+YGNnKl1t4Yf?=
 =?us-ascii?Q?YYibroeWkQqZsmr6c6TldYb+He+n8s8vx5qFAQWmVjOMULUJh/aJlZZ3JKJu?=
 =?us-ascii?Q?kLI8Ccr92oqdJaU5CCKWNGQrdr3G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cV7vX1qt1LPWLSyfGGbqPBib1O2ZyX67HTlW1EVTDIT4N2heIKIdAQFuEsuT?=
 =?us-ascii?Q?QE8x4nVHkvoxEweYBDXti7UGYEQd+R6IJJrt5VsxQQ85p+22UnrpUdqKDxWh?=
 =?us-ascii?Q?Rs3O9WUmH1dMjJ6nOynQe6v3ad67q0nPTnUJy99NhjdAq/FdGwqeSIBu2yZQ?=
 =?us-ascii?Q?6L5siC7Gq+/JMI231+nefJli+oL9O41LCFVpTuvVZTf6nzS58IP/sggzhZ4G?=
 =?us-ascii?Q?LfKHdBsje6FjgZ7UODTd1VI1Tf8Y4gIlRQG4OfN00tV+qqZsrozM5rwDd9J1?=
 =?us-ascii?Q?1KpHaBMLyQW+qOhANGrsCDuHKvIzq5GUBFxmyCDaVA8DxLoessR9k+aMtUpY?=
 =?us-ascii?Q?OicvOjDmGFSggmwooQgpfOYAm48i4jlPvkW3LyRmZrr7P4OlxUdcqkYKAnsW?=
 =?us-ascii?Q?jrwWAFoZkpOc1YdP6nIFBsEJ0t0Zh4lvbCBAd+BIAiwRv2zXU3zaoa/wrs+Y?=
 =?us-ascii?Q?oANek+8lLKogHPp9OxXzw+4j64Dxvusevm50Y0YsrXQCehUUUdshk1b9JrjI?=
 =?us-ascii?Q?0i8w+uihnP04NQO5EymdAnWyun+qMAjDguad5o9pWk9YGmqTKHWRb/G0JXn1?=
 =?us-ascii?Q?xNqJq6x0ep1BQSFpJuSv3yixOn9QDXpCQ94o8UQyNuIbtQUfsRHP+UnJ0kAD?=
 =?us-ascii?Q?yZvhRmFmdHhPkKaeetUgBEvfCZE0pQB/ps1UQSPmsrHryD13CqQ0bRGWDHJi?=
 =?us-ascii?Q?OIch7LxlBaysFYy8lxU3aaK1zy9CNXivCr9jeu+/3YW/YOaNI+RVWWZsfRHz?=
 =?us-ascii?Q?NiE6lqfmyyEcEFtD5/grXRsePsxddMmlZRQjvRWV6YQApkfx4JWgr3z+TClP?=
 =?us-ascii?Q?OutOkIws11nMRhClENK4BD9mKCdULlECKhj7gFrxC2Nr7Kj3bxmvbG88lBI9?=
 =?us-ascii?Q?RdR9HEzFIHF11iCX2iyR4fkoKXAhNYDAngZFNj80BPtlogJzwxN/CZQgegIu?=
 =?us-ascii?Q?2vIrNS2JjIl76V0ycBKdCe33GFhFh5L+fdI3H+cK4nq9mCiMK4fk5e8zEBU8?=
 =?us-ascii?Q?a46VqgALogQuQeqowu/Z+jY9gWoVBcitrg40QZpuQ/Z3vYqP8NGjgipkE6Bv?=
 =?us-ascii?Q?bvdpBVaIXO/uIYJMZqwrzox6op4f6iOcOYJIl18iXR501PfQ0SkKye0mobdc?=
 =?us-ascii?Q?WxJYcagfz6XwM7BVb4jPV8I5RLvV3ifBdefzFfY/Z8+PPmt/at5ys4IV0582?=
 =?us-ascii?Q?QVBq5qrYYCzqC6oFcbJjGiXLB0i83v9Kwde4wSK3/NvynpFjshEvHO5u5Eb4?=
 =?us-ascii?Q?e7F6Hcl/IZoC3Ru3Vocx995LritQpny5/xqCkFQqvLKOOmKefp+fto3GnrMG?=
 =?us-ascii?Q?Omx1MVvT2xyR22UUkosZUtmB5tm32vz/AwfBzGPWKF7ugMWytBzUFd8Emh4W?=
 =?us-ascii?Q?ACQ8dlpeawH2Rp1xojO9VW4xi3+xU7BiCtFtBmUrAY3JpVYi/g4nEprQAjiM?=
 =?us-ascii?Q?n7Z7QeXSdRDg5CSgcAUCD6Xn9RPOcRVLwJrJNnvmF4h1PY2LqsGywyophz+u?=
 =?us-ascii?Q?6ff3WsLI6gxjxW+ZZRzrAkJ0mEnZICrc4KP0tq/92E8KZGGgwcMn8t3RiuIq?=
 =?us-ascii?Q?cB2G2tG3RkGtdGjQA6geJDKYEszPZPuRKI8XyfRb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99732c97-5665-48e5-ec51-08dd4fd04e05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:57:03.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRnoRsqxIois+viKcMpaNBu+Y+riIJ9/PV3Lwahb1xNAmdxxGWjz22kix3Rb/mmpj5SGS/Jc2Rb4PqbdFCY0LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

The rmap doesn't currently support adding a PUD mapping of a
folio. This patch adds support for entire PUD mappings of folios,
primarily to allow for more standard refcounting of device DAX
folios. Currently DAX is the only user of this and it doesn't require
support for partially mapped PUD-sized folios so we don't support for
that for now.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v8:

 - Rebase on mm-unstable, only a minor conflict due to code addition
   at the same place.

Changes for v6:

 - Minor comment formatting fix
 - Add an additional check for CONFIG_TRANSPARENT_HUGEPAGE to fix a
   build breakage when CONFIG_PGTABLE_HAS_HUGE_LEAVES is not defined.

Changes for v5:

 - Fixed accounting as suggested by David.

Changes for v4:

 - New for v4, split out rmap changes as suggested by David.
---
 include/linux/rmap.h | 15 ++++++++++-
 mm/rmap.c            | 67 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 69e9a43..6abf796 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
 enum rmap_level {
 	RMAP_LEVEL_PTE = 0,
 	RMAP_LEVEL_PMD,
+	RMAP_LEVEL_PUD,
 };
 
 static inline void __folio_rmap_sanity_checks(const struct folio *folio,
@@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
 		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
 		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
 		break;
+	case RMAP_LEVEL_PUD:
+		/*
+		 * Assume that we are creating a single "entire" mapping of the
+		 * folio.
+		 */
+		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
+		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
+		break;
 	default:
 		VM_WARN_ON_ONCE(true);
 	}
@@ -251,12 +260,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_add_file_rmap_ptes(folio, page, 1, vma)
 void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_add_file_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_remove_rmap_pte(folio, page, vma) \
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_remove_rmap_pud(struct folio *, struct page *,
+		struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
@@ -341,6 +354,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
 		atomic_inc(&folio->_large_mapcount);
 		break;
@@ -437,6 +451,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		if (PageAnonExclusive(page)) {
 			if (unlikely(maybe_pinned))
 				return -EBUSY;
diff --git a/mm/rmap.c b/mm/rmap.c
index 333ecac..bcec867 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1269,12 +1269,19 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		atomic_add(orig_nr_pages, &folio->_large_mapcount);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-				*nr_pmdmapped = folio_nr_pages(folio);
-				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				/*
+				 * We only track PMD mappings of PMD-sized
+				 * folios separately.
+				 */
+				if (level == RMAP_LEVEL_PMD)
+					*nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of a remove and another add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1420,6 +1427,13 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		case RMAP_LEVEL_PMD:
 			SetPageAnonExclusive(page);
 			break;
+		case RMAP_LEVEL_PUD:
+			/*
+			 * Keep the compiler happy, we don't support anonymous
+			 * PUD mappings.
+			 */
+			WARN_ON_ONCE(1);
+			break;
 		}
 	}
 	for (i = 0; i < nr_pages; i++) {
@@ -1613,6 +1627,27 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
+ * @folio:	The folio to add the mapping to
+ * @page:	The first page to add
+ * @vma:	The vm area in which the mapping is added
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
@@ -1642,13 +1677,16 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
+	case RMAP_LEVEL_PUD:
 		atomic_dec(&folio->_large_mapcount);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED)) {
-				nr_pmdmapped = folio_nr_pages(folio);
-				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+				nr_pages = folio_nr_pages(folio);
+				if (level == RMAP_LEVEL_PMD)
+					nr_pmdmapped = nr_pages;
+				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of another remove and an add? */
 				if (unlikely(nr < 0))
 					nr = 0;
@@ -1722,6 +1760,27 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_remove_rmap_pud - remove a PUD mapping from a page range of a folio
+ * @folio:	The folio to remove the mapping from
+ * @page:	The first page to remove
+ * @vma:	The vm area from which the mapping is removed
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+void folio_remove_rmap_pud(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma)
+{
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
+	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 /* We support batch unmapping of PTEs for lazyfree large folios */
 static inline bool can_batch_unmap_folio_ptes(unsigned long addr,
 			struct folio *folio, pte_t *ptep)
-- 
git-series 0.9.1


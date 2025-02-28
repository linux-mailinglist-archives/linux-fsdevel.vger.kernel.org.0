Return-Path: <linux-fsdevel+bounces-42814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818E8A48F84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C5F16F6F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644911C6FE3;
	Fri, 28 Feb 2025 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H4yB8pmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857E1C5F08;
	Fri, 28 Feb 2025 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713541; cv=fail; b=S9/MvEBpPTW4k22V+VLhHKLxcGid5Q9dS2hEIF3MEiJyFoExnv7RqXk0YGnFV+mqeG1qPGC68aVJnn0x+GHGnKDoZSYYJmrOuvREYWiJpvJD6uPh2IxjjMn4Vo86TIjQArclb5Xn11iGmTSty7nSdIFUPBUE9Cwn3ltxVFqvJ28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713541; c=relaxed/simple;
	bh=CijQtpE+fZx9ngwZM5Z4hMj83c7sBirqhP7v989VJXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+6ZuHxuYMa4UPyn82/9GJ7Ncn0M3Yq3zJcPY2AKlDo3xpDZlgxip4zlCn5sn6B+ZhTqGDC/ghAOQK0XiyFGhyUIs+WFixzqkp9zBjc4S0Pc9nEGEqSP6APyZpx1C7V9BjLMJ3IUDbJdt0pAP9OhnxnBEabJjflqTmNAARrlLd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H4yB8pmI; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ro9m7QpfBUirFtQjOD4KkVA/NQsexHw+Lvld5ziEh+HqicNP1FkIEnqluc7YMmbB1M7Es51MLFaD+7y/wXNI568VGX6+ecfOFpYVmCguur3UIdM58x6iGxYVFGD+XVfpxPhXXGmyMCsHgiVx2sc3V6AK0F209KKov8q1zy9LxSMfvUT4OQys8F+r01Xp9IKzDd9RhVkVn9/+ORa0p8EzKsBYkN+TJJ2DjRC7DuGMfNIM4uriG7m2sfQ1Q5wV5gx9fRD8xNTJsZTU5XODXBkYfXzpfGoC6+lcejqJ6FyeQXsZEQPQNaeryzKDc72l8vknwqGkn1OMKWM6jbdtVbJKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srcf6zqUgBIxokzx1McHz9sw+qkphK+rkZW51E1Zzvc=;
 b=Ob2VsRABf05ySI+oQwGLanXKUxT908tDW8q7OrrS2X8ra+cjqQVuVG49xLI7uDd+yFhEJ/IKpx7DQxF9+MBL/N+4fDPSuC2sUDocs9Feaz38tzzNvy0Yb3GV0RPEOpZLj6dSmJ8P6L7gd8zkFrBYy3ZXuG3ZMNSkwTFK48CNqkK9/IhJw2hg3oYMLqpXAffzmpmCv/dc6KFPtu6hd7SdCvhFQRz8CQn/hAeZcGGV7UtNUpmlRDRQmx86KstJiYqrrZ9CFm+AWhyloao+r/TmxzvOe/hui3so0mKX8LJazer9nXoEv0xoYzc/qEUGSbIjVYrvPQaSjmc/JtvVOi8T9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srcf6zqUgBIxokzx1McHz9sw+qkphK+rkZW51E1Zzvc=;
 b=H4yB8pmIMsasBWtvDEso2Fwkvuq4lhh0jD5Pp9sxLL8MmAy6Hi+O8T7n8F/bU89IBo1DEnIMonqkm63Hn7z5bfuG/+pt1t6aF9LYIDP7XWcKgW4Aavru67xe9HWNW3jO/it2Fnb+nwZPd1jkbKvGSv63w4o9PD0Q42jR1RGDtoKbBjx/KzbFsGDsDs+Lss6Dok5HCoU1gUYUOu6zNBTd/i9nHzENxwijv4BydCAJBWppG9NyyF33nA4tEGuJpkYvkps1FD35JE4IMU2l0R60+79X4kXZgsGU1tv9JhSyBLnqOaTNA4HywYyqYzLydv4JjM7oDGNPlI/K2krwUHTYMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:16 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:16 +0000
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
	Balbir Singh <balbirs@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v9 11/20] mm: Allow compound zone device pages
Date: Fri, 28 Feb 2025 14:31:06 +1100
Message-ID: <67055d772e6102accf85161d0b57b0b3944292bf.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0113.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6f5feb-6072-4cc3-b92d-08dd57a87f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X2V4PFIPUuKKc23dkRIOEPAO+q3b/wUKemcU4sMH+QDvQyugPb5nryNzpcAm?=
 =?us-ascii?Q?rOZLAKNMmon0WCSCr2n6L+UPMexvIBS8YaHKV1Ojo+D+cgZXp+9MVuMXuA2/?=
 =?us-ascii?Q?FmuAXfEsfDM0Wh1vkGg/KEenVLBiey9b1Xq/c4zr/AaTnu5QGXmYcmiFa2xo?=
 =?us-ascii?Q?xGxGZmMy2p5S6PyYAJb0g8Su6NNUm6PbY8LGV3zYMPQp88yOPubNHQGcwODB?=
 =?us-ascii?Q?17alNfkFhbCpaisk2+SanJqVh7LCHu1cSPpMmlRTc5NajD9U/mB/lbKtICv0?=
 =?us-ascii?Q?utOW/WVVv4kYjEqbVR3TIx8KRE6fn5LYcbW44VPQpK261tmM+paD1Xojc6Z8?=
 =?us-ascii?Q?zMQDaS04rp/OyjcUxZXPA6kkGCBm61rm+nVu/BochkJHnpVY5ZnODxGKjmg8?=
 =?us-ascii?Q?8mRlRjVWklFmhBr/LGaMT1N9ZllniQNQ06VzhGCoqc6erYqeNWsSaV1CmncX?=
 =?us-ascii?Q?fTLssHHTR+Qzuk8wIGWJnyvR3GjDIrhZpPDXDzvjuGzPCNBSXY3J6/0CjkoO?=
 =?us-ascii?Q?ScZVTgCsxebRW6jjmTvWTqHIvUXnSp2KkWpnN86bON38PYkjHzm3ergjz9Hf?=
 =?us-ascii?Q?F7u156yh7LiKRRHp52WIV7s5tXo3zHvrmsMVMj+F8R967F8fzuRqLKxF8ROh?=
 =?us-ascii?Q?aTpO8WN4XMZqt8u0maxmGpVXKDPdCwcyalpDxmA8sO5GtyLIUxMU8WK4gXLZ?=
 =?us-ascii?Q?+YJUG4z0JYqiDP06IHSo95vIEgCk0cjwagumBhadt5rZkF34Gky0NAW+Ybfy?=
 =?us-ascii?Q?5d6/BEoJXlcotF5SmaFaEY1W5sYZFcLOy2vc1KzACazBKnlRHXnbsHkiD30i?=
 =?us-ascii?Q?3qdmUu+CqNJuz+bFmQN+QN6C/itz9JVMfSiOARJcTcs4xr9PK1W3OxV6hygd?=
 =?us-ascii?Q?YmxxF4vf4GPNxDbTjqOgu+27YxmD/DDvhNPuJTbqM9Qr4Saju4NF9OoIRR5U?=
 =?us-ascii?Q?F7iUQx1fmKcECWaeHOfbMrbemqV/UCklcXO237Vp62sRfdaJI9hrPbmcaLoL?=
 =?us-ascii?Q?kvrG+T+ZiJqFnNN5PsB80NRclCADLLTYrCMcB9LVxiyT3X1vdloy0inXshFQ?=
 =?us-ascii?Q?5MOIK5/dL22wcvoX0INJqsgLXgsUyoSB65Ftn912E9NaSnx7bm70cpHWtgP2?=
 =?us-ascii?Q?RLmGHQz5dsRq4Hl4aD+F33Hm2VDDaBrDypo/ogD2yXX+IVc5+E4ZsVMhr83d?=
 =?us-ascii?Q?fNJ+ljTZfDMdbHm0cgeyzSyNt2UbxwQPGG478W+1UcpUoJ+2lPTfiBZQgZn9?=
 =?us-ascii?Q?4u/10NmpxG0au1tjN4DDPchgCAkG+2xxkf2ENovbjzX+H6QyZiUt8pc2XeZW?=
 =?us-ascii?Q?x/AgZGFQ9XBHKFyvAA/TKf3wWWI2EzfIq3YM/CJKQxRj9ChhFFMNuflpvkDW?=
 =?us-ascii?Q?yE95fx2gtR8EHHqQOSeKZnVos6Zf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tM9tWhUK8swCkfP6lHXkc2EgkLvhhi1dF0M+fClT16W9BwXPCHqlhaXvUO4J?=
 =?us-ascii?Q?+e568GbDEgBlNkoNSZNiwutsEVy0+PoGT2UC3aP5j2DWmGjqpqnfRbHrLO3r?=
 =?us-ascii?Q?iw44uu6E5BK4BuAL5joY4cPddQ6Cmh1IZwPZPUZrZFOuVE5IreOAOfyPJKyV?=
 =?us-ascii?Q?KQeBIs9GWtOV+Uv+LWVrtuh1FD79pnFZRtcAO9FInAPoqLWZ3G0CbEofN2D0?=
 =?us-ascii?Q?+My8cMCWDSbyaqvpSInnCOpekqt67iSqjdExX3QPAeu+H3KrUNN/vFLKMF3M?=
 =?us-ascii?Q?FntEuZXuKjJd5ncvjWImbZ4B091eLMIt/eP6Vo/YozdtElqairFTAkckrPqo?=
 =?us-ascii?Q?iiqfxiohvgDJB1xFI1s8N8BBZUc+u/XIcrCjhVO8dMzhhBCOKJKKvPO8c6EM?=
 =?us-ascii?Q?G6VhHwyXRiCFVOtxoXyvQibbnkHXCleUMJosqw8NAEus8VNlv6AzFZTLwprx?=
 =?us-ascii?Q?nCjslzJr9QUKJlPyWsvj5N5o8Yrs9g49ABr8LpgiXXgGMF2jPAhRqePzERb1?=
 =?us-ascii?Q?NkMeJ/MwYgTZhRVmQobywZmQDDXORUCuSvX24EVYIhjGbss1UAeeMRz89G62?=
 =?us-ascii?Q?E+KvH9EfkOogZuAl6rwVDuJQFbd7kIFAF75KHKdyX7rFJ+CUzv9tEOMb4se3?=
 =?us-ascii?Q?PW4ZvBo8TTMTpBmpJWEbmOLp59OMvtGa4HsAxlIOeprKWjjIUXtC6olDRvY2?=
 =?us-ascii?Q?jr0SxtezntB8ueEHOqBsEAkOuBIpGrZQYJHCwd+8mRmfRoHFuPwmIPXKw8Ns?=
 =?us-ascii?Q?ISe2nb79kg+lXkfPSkFHM8O4J8hG67dT3RrsTfMJlvFPRiTKkh7GGEowhBhG?=
 =?us-ascii?Q?JnINDjzp+t/kN96sdxPIoYdZrEbl/eSm0tnPBlrCutYTCY+dy44aty0AZT2/?=
 =?us-ascii?Q?6NQ4Cc/Dxoz7MAv0QqLB3v290S/j1TYPqEH670xO060EET3X+tVvfuXILZGi?=
 =?us-ascii?Q?x6zkyGREA6zUfL/0+1/nCYt0UIE7ERPWO6yBZfNbKV/LhO7KchNPUvTtxm2j?=
 =?us-ascii?Q?+R/+paJ4/1CRAnAnh/oKgrnJ8P9t9aRSRxUTkzSocyX/fQWqtC7lyldDGBJu?=
 =?us-ascii?Q?vLmmfQZxMcoFu8Dhmq0kZrYK4mdJSgDDzJqDYFTUdC8Omba/3aOXMmTpMZTn?=
 =?us-ascii?Q?nV4JpGf0JNUyNesRLwWMQGj5ew8qvj9GZd2DLQUde4TxOEv9vZaHimmUw2Qp?=
 =?us-ascii?Q?8sZIaouW1CLQ3PHo8+BuogiPMDsjSz2VqiNxBjgpYGaHjsV7JA9X9cqiBQG+?=
 =?us-ascii?Q?aHC/0OkoHF7T4ynVJ50NU9eVfoK9ENlfzIYNVLZpSkVIucM0VgDmTgA0rAal?=
 =?us-ascii?Q?izcquWbvNcGt4CwgGz9mGzMVppqOcX8VCMNN3/P9U8OASDHHlN+b65lZSoCj?=
 =?us-ascii?Q?MQYS3dtbDDqocToUs4NUg+hMa+I+9lmMT95/9t+RTwnnkKm7ES3RKiA5g7Be?=
 =?us-ascii?Q?CwLHO7Ad68AEPO+AYOTQn/xowKW+EJJfF2oay5hMfVVZmuePTIDLw4vT4ap8?=
 =?us-ascii?Q?uWGO+SBBvNZkfDX6s/OWAzxh3LnclHzQU2kJSTA4T08OCSpUqP2NQcPOJN5W?=
 =?us-ascii?Q?JKUzVHtRGol7GREyyNd97vUcmRAptOkgxZLkrOrL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6f5feb-6072-4cc3-b92d-08dd57a87f73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:16.4529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKnieurFBl4CpkY2f1l+AxX3Gaeftkb8i4nBevmquQxk296cqNIWaRMpkM7AACzFXgck2EukhMucEtpB6sQpXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Zone device pages are used to represent various type of device memory
managed by device drivers. Currently compound zone device pages are
not supported. This is because MEMORY_DEVICE_FS_DAX pages are the only
user of higher order zone device pages and have their own page
reference counting.

A future change will unify FS DAX reference counting with normal page
reference counting rules and remove the special FS DAX reference
counting. Supporting that requires compound zone device pages.

Supporting compound zone device pages requires compound_head() to
distinguish between head and tail pages whilst still preserving the
special struct page fields that are specific to zone device pages.

A tail page is distinguished by having bit zero being set in
page->compound_head, with the remaining bits pointing to the head
page. For zone device pages page->compound_head is shared with
page->pgmap.

The page->pgmap field must be common to all pages within a folio, even
if the folio spans memory sections.  Therefore pgmap is the same for
both head and tail pages and can be moved into the folio and we can
use the standard scheme to find compound_head from a tail page.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes for v9:
 - Fixes from Balbir

Changes for v7:
 - Skip ZONE_DEVICE PMDs during mlock which was previously a separate
   patch.

Changes for v4:
 - Fix build breakages reported by kernel test robot

Changes since v2:

 - Indentation fix
 - Rename page_dev_pagemap() to page_pgmap()
 - Rename folio _unused field to _unused_pgmap_compound_head
 - s/WARN_ON/VM_WARN_ON_ONCE_PAGE/

Changes since v1:

 - Move pgmap to the folio as suggested by Matthew Wilcox
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  3 ++-
 drivers/pci/p2pdma.c                   |  6 +++---
 include/linux/memremap.h               |  6 +++---
 include/linux/migrate.h                |  4 ++--
 include/linux/mm_types.h               |  9 +++++++--
 include/linux/mmzone.h                 | 12 +++++++++++-
 lib/test_hmm.c                         |  3 ++-
 mm/hmm.c                               |  2 +-
 mm/memory.c                            |  4 +++-
 mm/memremap.c                          | 14 +++++++-------
 mm/migrate_device.c                    | 18 ++++++++++++------
 mm/mlock.c                             |  2 ++
 mm/mm_init.c                           |  2 +-
 13 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 1a07256..61d0f41 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -88,7 +88,8 @@ struct nouveau_dmem {
 
 static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+	return container_of(page_pgmap(page), struct nouveau_dmem_chunk,
+			    pagemap);
 }
 
 static struct nouveau_drm *page_to_drm(struct page *page)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 04773a8..19214ec 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -202,7 +202,7 @@ static const struct attribute_group p2pmem_group = {
 
 static void p2pdma_page_free(struct page *page)
 {
-	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_pgmap(page));
 	/* safe to dereference while a reference is held to the percpu ref */
 	struct pci_p2pdma *p2pdma =
 		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
@@ -1025,8 +1025,8 @@ enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 		       struct scatterlist *sg)
 {
-	if (state->pgmap != sg_page(sg)->pgmap) {
-		state->pgmap = sg_page(sg)->pgmap;
+	if (state->pgmap != page_pgmap(sg_page(sg))) {
+		state->pgmap = page_pgmap(sg_page(sg));
 		state->map = pci_p2pdma_map_type(state->pgmap, dev);
 		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
 	}
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3f7143a..0256a42 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -161,7 +161,7 @@ static inline bool is_device_private_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
+		page_pgmap(page)->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool folio_is_device_private(const struct folio *folio)
@@ -173,13 +173,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
+		page_pgmap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
 static inline bool is_device_coherent_page(const struct page *page)
 {
 	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_COHERENT;
+		page_pgmap(page)->type == MEMORY_DEVICE_COHERENT;
 }
 
 static inline bool folio_is_device_coherent(const struct folio *folio)
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 29919fa..61899ec 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -205,8 +205,8 @@ struct migrate_vma {
 	unsigned long		end;
 
 	/*
-	 * Set to the owner value also stored in page->pgmap->owner for
-	 * migrating out of device private memory. The flags also need to
+	 * Set to the owner value also stored in page_pgmap(page)->owner
+	 * for migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 * The caller should always set this field when using mmu notifier
 	 * callbacks to avoid device MMU invalidations for device private
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 369f76a..6f2d6bb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -130,8 +130,11 @@ struct page {
 			unsigned long compound_head;	/* Bit zero is set */
 		};
 		struct {	/* ZONE_DEVICE pages */
-			/** @pgmap: Points to the hosting device page map. */
-			struct dev_pagemap *pgmap;
+			/*
+			 * The first word is used for compound_head or folio
+			 * pgmap
+			 */
+			void *_unused_pgmap_compound_head;
 			void *zone_device_data;
 			/*
 			 * ZONE_DEVICE private pages are counted as being
@@ -300,6 +303,7 @@ typedef struct {
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
+ * @pgmap: Metadata for ZONE_DEVICE mappings
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
@@ -338,6 +342,7 @@ struct folio {
 	/* private: */
 				};
 	/* public: */
+				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
 			pgoff_t index;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41..8aecbbb 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1158,6 +1158,12 @@ static inline bool is_zone_device_page(const struct page *page)
 	return page_zonenum(page) == ZONE_DEVICE;
 }
 
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	VM_WARN_ON_ONCE_PAGE(!is_zone_device_page(page), page);
+	return page_folio(page)->pgmap;
+}
+
 /*
  * Consecutive zone device pages should not be merged into the same sgl
  * or bvec segment with other types of pages or if they belong to different
@@ -1173,7 +1179,7 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 		return false;
 	if (!is_zone_device_page(a))
 		return true;
-	return a->pgmap == b->pgmap;
+	return page_pgmap(a) == page_pgmap(b);
 }
 
 extern void memmap_init_zone_device(struct zone *, unsigned long,
@@ -1188,6 +1194,10 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 {
 	return true;
 }
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	return NULL;
+}
 #endif
 
 static inline bool folio_is_zone_device(const struct folio *folio)
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index e4afca8..155b18c 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -195,7 +195,8 @@ static int dmirror_fops_release(struct inode *inode, struct file *filp)
 
 static struct dmirror_chunk *dmirror_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return container_of(page_pgmap(page), struct dmirror_chunk,
+			    pagemap);
 }
 
 static struct dmirror_device *dmirror_page_to_device(struct page *page)
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229a..082f7b7 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -248,7 +248,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 * just report the PFN.
 		 */
 		if (is_device_private_entry(entry) &&
-		    pfn_swap_entry_to_page(entry)->pgmap->owner ==
+		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
diff --git a/mm/memory.c b/mm/memory.c
index d337eab..905ed2f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4316,6 +4316,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			struct dev_pagemap *pgmap;
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4340,7 +4341,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+			pgmap = page_pgmap(vmf->page);
+			ret = pgmap->ops->migrate_to_ram(vmf);
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/memremap.c b/mm/memremap.c
index 07bbe0e..68099af 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,8 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->page.pgmap->ops ||
-			!folio->page.pgmap->ops->page_free))
+	if (WARN_ON_ONCE(!folio->pgmap->ops ||
+			!folio->pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -486,12 +486,12 @@ void free_zone_device_folio(struct folio *folio)
 	 * to clear folio->mapping.
 	 */
 	folio->mapping = NULL;
-	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
+	folio->pgmap->ops->page_free(folio_page(folio, 0));
 
-	switch (folio->page.pgmap->type) {
+	switch (folio->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->page.pgmap);
+		put_dev_pagemap(folio->pgmap);
 		break;
 
 	case MEMORY_DEVICE_FS_DAX:
@@ -514,7 +514,7 @@ void zone_device_page_init(struct page *page)
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
+	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
 	set_page_count(page, 1);
 	lock_page(page);
 }
@@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(zone_device_page_init);
 #ifdef CONFIG_FS_DAX
 bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
 {
-	if (folio->page.pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
 		return false;
 
 	/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 5bd8882..7d0d64f 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -106,6 +106,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct dev_pagemap *pgmap;
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
@@ -133,9 +134,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 
 			page = pfn_swap_entry_to_page(entry);
+			pgmap = page_pgmap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    page->pgmap->owner != migrate->pgmap_owner)
+			    pgmap->owner != migrate->pgmap_owner)
 				goto next;
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
@@ -152,12 +154,16 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
 			if (page && !is_zone_device_page(page) &&
-			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
-				goto next;
-			else if (page && is_device_coherent_page(page) &&
-			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
 				goto next;
+			} else if (page && is_device_coherent_page(page)) {
+				pgmap = page_pgmap(page);
+
+				if (!(migrate->flags &
+					MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
+					pgmap->owner != migrate->pgmap_owner)
+					goto next;
+			}
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
 		}
diff --git a/mm/mlock.c b/mm/mlock.c
index cde076f..3cb72b5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -368,6 +368,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (is_huge_zero_pmd(*pmd))
 			goto out;
 		folio = pmd_folio(*pmd);
+		if (folio_is_zone_device(folio))
+			goto out;
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
 		else
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 6be9796..d0b5bef 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -998,7 +998,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
 	 * ever freed or placed on a driver-private list.
 	 */
-	page->pgmap = pgmap;
+	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
 	/*
-- 
git-series 0.9.1


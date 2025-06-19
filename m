Return-Path: <linux-fsdevel+bounces-52180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766B0AE00E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15474A1771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EDC28314D;
	Thu, 19 Jun 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AqqY5MCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C85267F5C;
	Thu, 19 Jun 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323547; cv=fail; b=eL74AWqgSqevzHK1BMwb5Zh01fv/pM3dGo9A1k5WN+yTmuS/NQV2qwMkU0mqizMh9yp+2GwUaVbWnB5TB8vu2RzHq10IsH3FsPNmTK0Ze+5D8LJS9jUxgv/bs2Sgs1ObPcmjYYjqHeWezubIjIq+XeScs6dZo5TnegzaZZONj3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323547; c=relaxed/simple;
	bh=v7VPgZcls0Fi4CbbJoPZgE0tN0QLj9YbBgH0K6ROvdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2NrOJ3H+mANFa6JabL5hlCUoHP/FSY6vfn8S/qcmj+Q8FtahB+cgIK6o643c/DER2cux1KbZr9MJM2dqFLs+R950w0F0zxF/LCk0DWpF0yMDBTUdzEX+gPf1Vu09mwIC6+8tn/iSQS8DALvq4xr2ek2obgBJP8gBcqJcdGxT5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AqqY5MCq; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtzL8EezWQ19jBf96MRmpnDap62BkBsvpHUpNvlGPs3Wh85mfCG76yZKVqRknj3obtOvgJXVVI23ywWeVDviYx3i4yK9QIyghMhMt+L+S/sm9xqF2Pe/bhc2rjaApGPdlCNMOdIP4Qj/K2r0OaStAIVqJDNzNLlwilJ/wdRMOL6Z7z2vWY/AiXnpkcDH9zn8vW1cbHRmHhHZtaFVdLNYjBzRdGaxmazxdNRadbyHcCtuQK/YPxzyphUv44x0fAQVdQiw0+c25ytxg1k1ImIORhX19PUrZ6xXtncEBFeVVtDvFC4xp36jI70tM/e2rWGSbVEJ+Ibwsq7Mile7E5uZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RhlgsKm/HCcDnF2PlGZRwe6SDVLs+gcNL5Sum8GV6E=;
 b=iqEpjSa3SReyd/8BiiWx9GLfPKvflJsIUd4cwP0Lfx+7iHTWpbCwfPHIgSyzhw2tCBlwwHtq3967JT5UnsOOnUfKxdaDKeji4w3jn44uwspFKXTUnCvxrPLhfMrGvHr3AEr5uY/NfQpHSHiVK12nZWFxPb9pEaCtFT1ah6WvuRBwvF9HaSZDGrxRf6iNKp2PFBxHppyP5HOCp4y1wSabSvizQkUt6tyhzQh4iMcj5oN52Szy/PZVJTy6LoZxZD/DtODiX0hwkoVj8qbU3+MNI23ASp+WOWt9IXjRV4wO6JIpp9Vqh/l72ZY/y/M0A+izZr6WzrJERSG+ZEUN+XjDwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RhlgsKm/HCcDnF2PlGZRwe6SDVLs+gcNL5Sum8GV6E=;
 b=AqqY5MCqJW4w6geOyT4zfcsr7ZbNMpkXM6QLhzwVUsyyfmi7ob4XhTMWjsg/hGdL7FNWpODrFIoTdTUB1vN5MRJTzIn9GlpHXpm63jvHKTofVVsAzqBdTL3vd4Kmr9aPwOOLDdHjZFUVWHRBe1wRBKeL3xCZByKuMgeDS/7rlzhlGAeauYI5G2xYnCcjIEOOzyXcutteezZR1ppfQjQR2CY7aefpA/+Jp6/KNKQgviMl0WlG4NtJJW7meMe4fDuCdOujI7JCPvq3muodBvxRcsRUKJJysPIT1zjQZtbwMagS4/mt8ANeL/2HdRfaVk2VtT/vmgRrG9+LGv9VB9IZxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:59:03 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:59:03 +0000
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
Subject: [PATCH v3 09/14] powerpc: Remove checks for devmap pages and PMDs/PUDs
Date: Thu, 19 Jun 2025 18:58:01 +1000
Message-ID: <31f63cc8dd518f9e2ec300681fe302eb4adf49b4.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0128.ausprd01.prod.outlook.com
 (2603:10c6:10:5::20) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: fa473b6a-30bc-4e44-4602-08ddaf0f89d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PN8bXvcJm8auI0BPchaSyh7srKmq2iHGYMYrxu+Elk6sB3GFK6U8QiwjXKti?=
 =?us-ascii?Q?cM4ghbj5gKn33/dBMHl4dGNAsQkfq6ZI0NUxo3epfEzKPvn4Lq+m8c5BRywP?=
 =?us-ascii?Q?0nPqmqxdpN7vU9yIlQEXj+kyI7L9e3nV/PcXN998jm0Iva8/UVogJ9C6qSZX?=
 =?us-ascii?Q?4wf1EZAD1RMUdCuqH4WTYgUj2neOtMfDYuKXrQJa8yhr1pN4T3QhWizxyeaD?=
 =?us-ascii?Q?iQlh54k4DKHDl+GYogxua5ER45xgwkXPWELKSR/ujUsm75z4atAByxCQ5spR?=
 =?us-ascii?Q?M/OLaRilzgcEV/ghaC5LybD1HR9nG63I2qN04E0FNG/tC0miZJhhHhbg/gNh?=
 =?us-ascii?Q?ujEU/Wbc3obb2U2Idv/QeMe6A1hFKy3ODMn9N9xTtaYJ4uTtLBRj383cJRRT?=
 =?us-ascii?Q?pozT0Z+2UPD2Qh9bf8YFRyW5hw2fC4NbpGxG2jWxnBlMP5ECHMdrCPpl/Uj9?=
 =?us-ascii?Q?l/ugt/5+x477tNxj2+Jj7NycGWv0VEALTz7oEauI9W0cjmO+4VasSjoVz/Ai?=
 =?us-ascii?Q?ZkEN3PIhRwLZN1B7YULvMxzWkX8E8tOzSpU2hAmhn/Ti9jpC0S7hG1wBOxv6?=
 =?us-ascii?Q?kOrvz8yxB6khVhIrawFRNJGhdQzlGQpgv2yv72PigJPKzqGcA149U8krK3az?=
 =?us-ascii?Q?zD1RmdiMBJ7PlvZHXIS7a1Tg703pju7A9aK17P6R94GwOzxudtnFhRZnNLk6?=
 =?us-ascii?Q?5x1C/V0tMDZYLZKwzpCn/TsqQK34e1/KKcWK8LwKIVBTsIzljCD1gjdi0D4q?=
 =?us-ascii?Q?melIIVJTbqnXzF5IduKTAitznfyjR8bkpQaQyGR8WL22MDqprnUAZ5hFjrWE?=
 =?us-ascii?Q?TCRa2rJuu9IUs9DbVSIzrKxs/Ts4uhsA7f1hYvasKu9rdkohOL+MVQQnrKld?=
 =?us-ascii?Q?zaSLAgbDuKNsYnoEtKzF10nSYwyQOuoJ8Bd5Gki8Zsjy+kxhOQXP2Y1r1Duj?=
 =?us-ascii?Q?ihea8jvBi7ssRnpPYF0qVE4SEem8pRQ6E+qENSwmpe/CryqM7v2qGtYsqynk?=
 =?us-ascii?Q?hr7Mhk3/huBuDpuTb7hp8S2WJS9MfCQzR59W1wGM7mT2xgfdEo5+cZ1l/Il8?=
 =?us-ascii?Q?xuiXbGFsRStpx31bneHxsYziwR8ZaDKoRwC6YvpnknLITajT4pMY84y6lmhM?=
 =?us-ascii?Q?bexy09EZ9b8Gkb7cdeEUifKr2o28NVxuZjLSNmEOZKa99pc5O9rQQB/4UOlg?=
 =?us-ascii?Q?u90ibzoyIYg0Ip6kQEbJA5CyyMhTFx6cN0VTc9BxPgySEVdrc846YYF5hTZ8?=
 =?us-ascii?Q?RIGuGYTp34+iU3ImTH4TjQi4bJJ/kPHwmUQ8jDpegQlSNOBbX4BViprY0Uou?=
 =?us-ascii?Q?lYEYD2+kF+uikibYYUwRw6KnvmsJCiOndc24yu2wK2gyTH+Ck0uUcHvYrdkk?=
 =?us-ascii?Q?EhWn+EKVEQ4JUNsxNDDWlsgjWDNgCZVjcM/2dJ88nRvwkl8LLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Uag2d4iNst98Qjvqt+yFtwsYoBjFIWW6iZlD2i49L/m7d4GgEUyaTcYDtys?=
 =?us-ascii?Q?1z9tbrv3oIOkTTbkcmmcwoXqCLEuofpdbpnY7UCosibGq1S6PMSyymIPye2W?=
 =?us-ascii?Q?Fp1e8fKFM8OdUycMjwjwuwOSbt3tAKf7PJyH6ikeK3Z0YOhrny9t1CtX0BJC?=
 =?us-ascii?Q?wuzFt8/Q1Juco3XlDvwSIYF+Yp761TbAodkrnSaFdSLGVmWf0zi0TKq6Si0v?=
 =?us-ascii?Q?BDWHIobYVEkNwapu2X2NtNe8Anmol1FVWuL0kVloGthMV9h5Y2kodDymnL6y?=
 =?us-ascii?Q?2q7cUnFuEQLU9tr6nW6Nb9vdrgkMssvuKhF4+puaa8FosLiMzS/BegnGfsjv?=
 =?us-ascii?Q?7/r5AnXRAaQthw3a7/OaLkpMHHlCElyrwnpVxHCFUTaPH5yjmK3rK0rDjPbS?=
 =?us-ascii?Q?r3c0Ia1WpPB7UiP9YPFpvJAer7jkdC1ZHAmFWjlyfs1FQjDQcPSo2Xg56UB9?=
 =?us-ascii?Q?Q31V3CwmsARaESIyQJoGR0pyq3cmL1vN6Ory496aTZyaSt7ytyNRKIb4gvIQ?=
 =?us-ascii?Q?TyTvEDstlFlL0nQFXocyPLBuEHSE0PVHQpi97U+prWTLgmda6QdTWkeTkeQb?=
 =?us-ascii?Q?3JGh8XcKhGBfH+suhpXv+mtKTPscJ8zMQ6kk9mYvfUTKZOhEkpn06JSsCros?=
 =?us-ascii?Q?oPfQSEBnWzSMWc5kN8RxAIgJC9uZKZGu7zyAM7vobGEIHikb0ck5c/j8ufMW?=
 =?us-ascii?Q?X+uaIkfg9y21z0w/+IaTzbr/V3XejCf4UK6NCsQqG3wL0mv6DWUnnYC/OI/4?=
 =?us-ascii?Q?1EfZ3zHbPlspyy80jKQqKHBtcKn5TlrsqOhU1+aKWS+VEWmTkKIrvbi//KaK?=
 =?us-ascii?Q?Jsa6GV4yj3IkLGlQtpg5HkcV8MGCJR/omYK1wwyRZ2O5h7fyu2i/gqbK9wph?=
 =?us-ascii?Q?9bEhCffM9onJsJg9qI52AoJ4Xqd34vBvHqP46xmy7ZW3rSBdAieW89tlZS8H?=
 =?us-ascii?Q?js9dIVnN/9dVEaZtNKZpFAdwS9AOOrCeGPgyYV8kM/AU+xy9vVcZaiCZ+oEE?=
 =?us-ascii?Q?8p3HJEGx8IswUwep+KyxHZB/a0o6s94KjlPRbpS+GLhH7M3odDEo8cyAnbr9?=
 =?us-ascii?Q?NtqmcV5k4FHDgDwtSYb+kn5LVmccYgvTtUyV9BGnGoPD+vfm/RkQJrOSQ8Hx?=
 =?us-ascii?Q?8OCe9nBnxCjwuPYjugUt2koDKWDXjJShTcOrb5Xb9lfqPszt9oz36xeK77Af?=
 =?us-ascii?Q?GPdWphAEjgrxrva1YWyODT/QTeB/2aKvjSJmsnwbgQS95aro1kdXe1YN1Qh9?=
 =?us-ascii?Q?ItJXRrXLMdiBHC3yPxSFoAyCG02/Ymx/rq6QdRlLkIvzJLAfFU1HnEClKOdE?=
 =?us-ascii?Q?V+LasEXvQFMKI8FNUilaqAHOXM+e/Fifgi6cbOBGtVgPToqFPxVaekMKtNd/?=
 =?us-ascii?Q?pafMXSKgxF3nE0PuKomijYygI0FBD1fElsQ+Z/JFA+Uu7q4mBQr5++mQyXEO?=
 =?us-ascii?Q?ItZqwhq3JgHHerhUxgea991Y28vT6oh3tHwruSsD19KDhrOgn/GyxF1hIEwS?=
 =?us-ascii?Q?fO2FR8dgl4BWH/qd362Xqbypu6iwSxBsUv4YpcDrTD0QEmHUZsCkzMCA/7Ub?=
 =?us-ascii?Q?wlvs0OXVsBwmAT+iXM++ndkLZ/Q2w0Z0o6rOTBzo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa473b6a-30bc-4e44-4602-08ddaf0f89d6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:59:03.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJed4KXKRZRbvrhGgKHXObuKQDtxaWg9OpTPanp90oHEw9L58aXaTXMnKOmlwEKwQdWA5Lp9NRgiqtFIvVQZKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

PFN_DEV no longer exists. This means no devmap PMDs or PUDs will be
created, so checking for them is redundant. Instead mappings of pages that
would have previously returned true for pXd_devmap() will return true for
pXd_trans_huge()

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/mm/book3s64/hash_hugepage.c |  2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c  |  3 +--
 arch/powerpc/mm/book3s64/hugetlbpage.c   |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c       | 10 ++++------
 arch/powerpc/mm/book3s64/radix_pgtable.c |  5 ++---
 arch/powerpc/mm/pgtable.c                |  2 +-
 6 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_hugepage.c b/arch/powerpc/mm/book3s64/hash_hugepage.c
index 15d6f3e..cdfd4fe 100644
--- a/arch/powerpc/mm/book3s64/hash_hugepage.c
+++ b/arch/powerpc/mm/book3s64/hash_hugepage.c
@@ -54,7 +54,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	/*
 	 * Make sure this is thp or devmap entry
 	 */
-	if (!(old_pmd & (H_PAGE_THP_HUGE | _PAGE_DEVMAP)))
+	if (!(old_pmd & H_PAGE_THP_HUGE))
 		return 0;
 
 	rflags = htab_convert_pte_flags(new_pmd, flags);
diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 988948d..82d3117 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -195,7 +195,7 @@ unsigned long hash__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!hash__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!hash__pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
@@ -227,7 +227,6 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(pmd_trans_huge(*pmdp));
-	VM_BUG_ON(pmd_devmap(*pmdp));
 
 	pmd = *pmdp;
 	pmd_clear(pmdp);
diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/book3s64/hugetlbpage.c
index 83c3361..2bcbbf9 100644
--- a/arch/powerpc/mm/book3s64/hugetlbpage.c
+++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
@@ -74,7 +74,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
 	/* Make sure this is a hugetlb entry */
-	if (old_pte & (H_PAGE_THP_HUGE | _PAGE_DEVMAP))
+	if (old_pte & H_PAGE_THP_HUGE)
 		return 0;
 
 	rflags = htab_convert_pte_flags(new_pte, flags);
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 0db01e1..b38cd0b 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -62,7 +62,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(vma->vm_mm, pmdp));
 #endif
 	changed = !pmd_same(*(pmdp), entry);
@@ -82,7 +82,6 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
 	assert_spin_locked(pud_lockptr(vma->vm_mm, pudp));
 #endif
 	changed = !pud_same(*(pudp), entry);
@@ -204,8 +203,8 @@ pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
 {
 	pmd_t pmd;
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
-	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-		   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
+	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp)) ||
+		   !pmd_present(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, addr, pmdp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
@@ -223,8 +222,7 @@ pud_t pudp_huge_get_and_clear_full(struct vm_area_struct *vma,
 	pud_t pud;
 
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
-	VM_BUG_ON((pud_present(*pudp) && !pud_devmap(*pudp)) ||
-		  !pud_present(*pudp));
+	VM_BUG_ON(!pud_present(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, addr, pudp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 9f764bc..877870d 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1426,7 +1426,7 @@ unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!radix__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!radix__pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
@@ -1443,7 +1443,7 @@ unsigned long radix__pud_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
+	WARN_ON(!pud_trans_huge(*pudp));
 	assert_spin_locked(pud_lockptr(mm, pudp));
 #endif
 
@@ -1461,7 +1461,6 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(radix__pmd_trans_huge(*pmdp));
-	VM_BUG_ON(pmd_devmap(*pmdp));
 	/*
 	 * khugepaged calls this for normal pmd
 	 */
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 61df5ae..dfaa9fd 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -509,7 +509,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 		return NULL;
 #endif
 
-	if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		if (is_thp)
 			*is_thp = true;
 		ret_pte = (pte_t *)pmdp;
-- 
git-series 0.9.1


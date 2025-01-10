Return-Path: <linux-fsdevel+bounces-38817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E3A08794
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9407A260B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A246A20B1E2;
	Fri, 10 Jan 2025 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iwVmWxqe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA9207A28;
	Fri, 10 Jan 2025 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488942; cv=fail; b=Jv7cBEoWOGp6ZnhJCvnLATT4kTxjfEXCf++Fy2JHQSOYWuaMZtH029cc+GQSHXsg8b5MsVTXvMAPCbXmbB/vvMsbOKMK6RUyGF8SKzJ1flDxBZiHgRtbSM/5Y2meLpTlXP3RWZJyXGkvKsbQD1SxOPbBw4tvKF9gaPEo6F79taA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488942; c=relaxed/simple;
	bh=ZWO5wkQ4gT6pArSvWzIa9XFRDsmGAuf7RKvqTO/MErE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBxoRjE5z7z13NQTiTpemZZbcYZ5XYhbt4hlZ//L8PICDaf6eITVsUFqcWNOdfyp9//xW6PIfB0m/4QVjAWeuT/pbvRDk2ZjfBdJJmYjiJ3fUd6iypdlB8OiUj5XvhiJdY/1ALQIxzeAFZM8yxcvT2/FbUbfMTLYmNbDuTM49BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iwVmWxqe; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru350b9gL/op0C55wApNCSqE9WBtYKwzriA117zmUdba2Pue6u4EmElTypUS8Q7z+J8J7t41uVyIkym3pNdaCKZyz/VhL3MbgxTanbjHfpVnVd38lgCnNiFfXgdFclLWMnpOr1MaRXLrlEjViKb7yYTzlLFvAdqTbJNhrroFb2kHI4nCr2AiCeOdvy5C2kpRdeeMfHOXM4WTQ6sDlRhXxP4//wNRuYdPWZQZKRgv2tubMKBevGHTc76S6I1+CLwhEqAqT5s+iALANhM8qmJ8BNTgxnUoy0BDjG5bxITN5klF0Z2qzpDbkY0BNPXicUtS3JpFmsa6XO5NBHoGUBnBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbvWzssPrT9FZMJZBSAKYh1TA5jh1lsqkg7Zp8OnHfg=;
 b=O0LSwu0LsLIOTMQt+uG1MOWtJIFY2icTTgERk414XcASer6qkEKz8CaXoBWIFtGaxRuunlNmKSifVzpShz/bkX4bJkbgnfaoaH2BDEGN2OCw/JJtCeuAix2KliNjgpMchxeJvz3eDB5+nAXNXxHmrBL8fA1xICf3J4+veNm78OjndZQ0E9CbDsxSz71EQOXU6EJBRCDwQ0nyy5V4u8fL96T3QpFtixWXXyOmKAyCzjUkNHEYIM/D6/y6UwWb0O2j/mtjM3cI0dKM9PRDelWTM981ahFBS8QPVdSM12GEMhkX2wnxobdPwnikJSySVIYZay1QmXUc/gz4pNs/eRGO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbvWzssPrT9FZMJZBSAKYh1TA5jh1lsqkg7Zp8OnHfg=;
 b=iwVmWxqegWOfuC7hs2+rIfzow4/NlrT6By1j21WIrUjolhKBS6EGWNcNwYyd/enonfbDrVsRdMI1ZJAsqegcwjZBlRyIRFjVk/CL2fw5bMx7SmfvOI2GVZEndn4OCzjCbfR4ZK0HQj2c9txNZ4+DJCk/59mP0MBFQ0EbPu4pcDtEADBrMNK8Ebiug8y/7kAZQVpr0O3U0UkBQTsR+YF6TM21T+o3xTBKRvdi+sphKr9Bl9nnY2mVgCkQkPgeXGO70vNlabVOliLjSSdV36mkiWkTRef25+L3sOiXITFa7DgwBp7058TbtHUqWl6JUr4XEDIvNfG2SFa9L90XYAgQmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:02:16 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:02:16 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 11/26] mm: Allow compound zone device pages
Date: Fri, 10 Jan 2025 17:00:39 +1100
Message-ID: <9210f90866fef17b54884130fb3e55ab410dd015.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0058.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b290ff-9d08-4d8d-7e55-08dd313c55dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nOrfakEbaXpzDiepDjtereNOtfx0yRENlWb4AuceqjizYsbWbOtuACX4WuCK?=
 =?us-ascii?Q?NwVQJgd1HV5mYW5KO6x2VL8hO1M+wRiBLWXqq/bIbjTnPPXBZ7qzWWR3N4XW?=
 =?us-ascii?Q?sUI3evBS97RmSuKo2tV7IlkkCDP0NpGkcWkMBj8jM1fciSJfCINpT7RR9S3C?=
 =?us-ascii?Q?Mcy9X6eUj+4m0X05Fu4+0omgbsURiHRVzg7Xx1ZRbucFKOxHKlkasWJlNdu4?=
 =?us-ascii?Q?C6Dfl6w4c+eu4axUSz3sGtOw88PYCp5PwViOW0UHFn+3QdeLVZhcOa/lUqqO?=
 =?us-ascii?Q?d9Yo+QAh40v/2tSxbZnCnuJXa/GdGGqz7VXES6vJPMDcSELZfvd1cQtRpfDb?=
 =?us-ascii?Q?2RLCmP49TM9RWT7qRJ6MtdltXdwuZ9LX09vAw7h0VRXcCJCrhX9HQS4qJhQs?=
 =?us-ascii?Q?Bo9OV2PBk6BUPIAkYTPZa8UzFn9/WUiyUGcuDbQwAAo+XQhZHMKZ9hrWtiAM?=
 =?us-ascii?Q?8r+CWjVerwKtaL1Btf7/rB3MCMlBGDTTGWrzx4zOVsItqOVxa51PNVVi+9CV?=
 =?us-ascii?Q?Gqa3iIorSoyalUNy0VNj7qXkB7IntQ9X+fZC1EcIbsz8Xex8QW3nyzXYXQl4?=
 =?us-ascii?Q?/inoODeuMjC4r8BB5F4Ps2TNyD3ThUUeFeQf/fnYL2gMLDDkx6n8MwSVQ0N+?=
 =?us-ascii?Q?lH5XbLMy8RJjvygigwI0OPCFvt4IHPNTvIy7eMUJCDylTbw7RgZ0K+vbiAPR?=
 =?us-ascii?Q?oUIQQ61SjYoK9B8GqnQVFPcnz0z3Sg73/0RAvbZSZBPQzT5CPyKy7Am5hLw/?=
 =?us-ascii?Q?s4AErpgCZGvYMP7RC+VSIASI1d5zEgXw/WjrZqNGFKOSbw4+ycStGBWiZBEg?=
 =?us-ascii?Q?cnbpp/0mwkJGstksx0Z2uUzS5Ggt9W8NkwtLwnah5i8mDTfv32CH/pYLMCZg?=
 =?us-ascii?Q?zqSUzzyvoWdiblwUZSbSla2LvOEIoEKk8GWrJeidH15mBh4DsIFGc9M42k0M?=
 =?us-ascii?Q?pA4WVgY6zDiN70nCwuTXn4B1nqAc5xcgTZCJjgMrtBT6kkBE5bqwWN95Ai+M?=
 =?us-ascii?Q?tob7/zgD/1BjpWZtONjRUE90yhjW4x5Qs5j7ejWZxd0r0VW5QUWn1Pa5Jcek?=
 =?us-ascii?Q?DNvlVHcSrReSmWf1XXbeoaI/uN15GZS5RaGMAnYQ2mpDG0+Nh6sRPaRNbawf?=
 =?us-ascii?Q?ZX9AWOx+ydm9kLka/2mBuEHeuMF+dHjGR926nWIxJAupwX+VS6aOqoSxFjDR?=
 =?us-ascii?Q?x49NU2PK0I34oBH2TKmgmYIAhtY4elR7Tn1r4tW/fvpds8ITGszrt1HZhdCj?=
 =?us-ascii?Q?SAHKqT8LqWP3I43BE3erxoB3CYbLZKbeYsWXue7oQhvgbgu6/tggz8UB4tKn?=
 =?us-ascii?Q?DJ/1rK9wCgIuFjeSUE9M9dYngzyvyL1qUc58+3LeUEsz89ROIGmJa4d9wBAz?=
 =?us-ascii?Q?YfUc7pXWxQl6Qlk59+L0bmTCBwqX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JgkjXOMV2Ap+P+G9mac82/2uoJF05K7aeg+CNv68h/a8tbjSfv/6sTJ0WLep?=
 =?us-ascii?Q?32FVdagtbDU9ddpMaBcME3rtKmoLL5zGYgi3DpLnQMZRGox0rt+T/vLD8yc0?=
 =?us-ascii?Q?0z8Ys2gfVxkjiqqfF/Ru16MGdHSCjPbFWHhrWZFFPTXOEKoCvX2hgzaCWNkM?=
 =?us-ascii?Q?6vbNiJqz0EO3K92WHiFGla+BS0/EhjPAtWYhZUul6YE4OncHiO7atlCKcV+W?=
 =?us-ascii?Q?TGkVD3LyMR0HIUxHyxKoJRbeXuTDnk4bK0zXPtm7jIarrgDGoPwuBovZjWZT?=
 =?us-ascii?Q?9jWDLsWKHDZz5ABavo+RsGgxlNRV1ZnohQmhQt2RiJhZ+XfJ1+HQ8m7ukmSW?=
 =?us-ascii?Q?6JBkbJTceKllfbwsDD67IBAeC8w4dx/eq1XgGsLD+IX4nZnOWMA6uwnjB0HI?=
 =?us-ascii?Q?Qx0YrLvFHV4N7XMKbJXp2vAyqOBPuOmOe4iXKxKcJgvzV1YZtyQ18L0yX1AG?=
 =?us-ascii?Q?WH/l4R4O6QIg7Jo1qsjl3ASBLYPaN9S/mG29WcpKWaC24TO/BKPQu0pzyt3e?=
 =?us-ascii?Q?hQAGbn505PATv7hM6BtJHm8uPrUnWBotZRJshy/tKMxJJO+TOnv+AXtsO8zJ?=
 =?us-ascii?Q?ZaDEG1ZUiSDrT40bUR8niGH6PmlE94Tov2g8spB+c4PzS+ZNWwlU1RofVmgU?=
 =?us-ascii?Q?JReNDgtVVLp4hDavFfJidNcJs9DcGYxyMlGGFM3FnFkxDV9kYiAZoHdlGaMO?=
 =?us-ascii?Q?jWjbigfm01cKZCMuysLOQFDNUWppOq7CEo622CMZTaLQ84VcYnGlyb1PmggL?=
 =?us-ascii?Q?PHyLlT1hJmeOc2Tt0bLetlLcvt7EdxsWHPqRL7MpdXlMItAk3AP5tfTJWlLn?=
 =?us-ascii?Q?FstUR+B5UM5NRJZev0O1GtBj8LlNmjmNbn4YAcfSQqB4zbc3Vqs8Hq5R3Het?=
 =?us-ascii?Q?koXscfRUz2mVXRk8tSAkrtDi5AxDDrA6g1OySnsoeZsMTFouMVSBCUyRGopW?=
 =?us-ascii?Q?niUtgE6jXjwzO5touqA2KFcMPFw8r6C25o8mEicjHe0yd99rhhVYYqXnE8py?=
 =?us-ascii?Q?sEb8+I6zB5mfBrfMTvRAbDIeSoXqp6BiqMkB0yvBTZE2qPxuL5z5EqpH1+ww?=
 =?us-ascii?Q?DnIP1oCoFrizOeYGgG9AwxNiVEZPuTk2nuYxjFvqSBPqR/Bo+wD8Q/mxr2Sj?=
 =?us-ascii?Q?Gr00DoVT5HyIB9lQzSfpYzejBpkKzqM8OLByNrK/mi70mbCXh+rRC62Q+hmy?=
 =?us-ascii?Q?34VqmydE7xZTxP/4uHfrw5h1ABCp7P6zbjNwj+Lln46OiiD4vbi/B8+9eVo0?=
 =?us-ascii?Q?xF8m7TRsrSjQ8luugYotZBftvqchqQ6UznG3trbpYG44XEege2q2ZfJ4Wyvq?=
 =?us-ascii?Q?BvCuvGx7jk2GMykzH7Z5xZw8g2INaZZ8V9oKb/RIODd+RkgE5oGZyLfvetcn?=
 =?us-ascii?Q?MiXnxncrco00dpPo3OVq3kXXscblDxnnWku0sjZZl0M5sVRP4jnkhCLUL095?=
 =?us-ascii?Q?G7V9dmisQK1Z5LQ7t38sX3ejZzhWh1db34pRsB3O29zCeILiFTKrdPDV/vIf?=
 =?us-ascii?Q?avtV0SFKsicpQvy+bW5akWwk3aYvIsAqzS81USWtM1wVKGskz4WCxAK96MD4?=
 =?us-ascii?Q?P8any08nRPSbKL4WTSzi2KYGc66zObBq3YiLIhBk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b290ff-9d08-4d8d-7e55-08dd313c55dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:02:16.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlKNMxbidB3/n5o4TBYMMruedXvDyY9+nGgWpnmRLs5MrrPLhcfDzu8TK/4zkMaKWbyFvuEHDgc1VdxK8IM2fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

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

The page->pgmap field is common to all pages within a memory section.
Therefore pgmap is the same for both head and tail pages and can be
moved into the folio and we can use the standard scheme to find
compound_head from a tail page.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

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
 mm/migrate_device.c                    |  7 +++++--
 mm/mm_init.c                           |  2 +-
 12 files changed, 47 insertions(+), 25 deletions(-)

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
index df8f515..54b59b8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -129,8 +129,11 @@ struct page {
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
@@ -299,6 +302,7 @@ typedef struct {
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
+ * @pgmap: Metadata for ZONE_DEVICE mappings
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
@@ -337,6 +341,7 @@ struct folio {
 	/* private: */
 				};
 	/* public: */
+				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
 			pgoff_t index;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c7ad4d6..fd492c3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1159,6 +1159,12 @@ static inline bool is_zone_device_page(const struct page *page)
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
@@ -1174,7 +1180,7 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 		return false;
 	if (!is_zone_device_page(a))
 		return true;
-	return a->pgmap == b->pgmap;
+	return page_pgmap(a) == page_pgmap(b);
 }
 
 extern void memmap_init_zone_device(struct zone *, unsigned long,
@@ -1189,6 +1195,10 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
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
index 056f2e4..ffd0c6f 100644
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
index f09f20c..06bb29e 100644
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
index 9cf2659..2209070 100644
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
@@ -151,12 +153,13 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
+			pgmap = page_pgmap(page);
 			if (page && !is_zone_device_page(page) &&
 			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
 				goto next;
 			else if (page && is_device_coherent_page(page) &&
 			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			     pgmap->owner != migrate->pgmap_owner))
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f021e63..cb73402 100644
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


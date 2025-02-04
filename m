Return-Path: <linux-fsdevel+bounces-40836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD64A27EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB89316714D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21390222596;
	Tue,  4 Feb 2025 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8e6jfOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099D222579;
	Tue,  4 Feb 2025 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709350; cv=fail; b=MmO2UxYh7mhWRNAEWFXMCQm0/IYFsYEniCVZgOweHhIU7+8TS+qaUC+Lalv5ryB6cId6bSdix4Mb0+kYYbnYt74PrJP62L6hrcXjcjyIaRnkI3IulAqYOtCipELGBaCRRXkzdUghdH9wEUaqvnb+Rg4YiFpIVN7mxS6nEYFzSvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709350; c=relaxed/simple;
	bh=ABP+Nad4KZGQwgzzkKRLhylKxDPSUVdLP3I8nPkkuXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIKwg0Znw406EymxcABrNeseBaFSIu9bJk/9vqmCEgqjoQX46516RSvnamuRaZDaSHs/+Uz8QEOxen0C1XunR/tI004KFC1nXuQK3BWtHCvlJAa9kwIOQFmZsK+zjvj8o8h7gREH+lTAUBf6JqwS//7PJ7iLcgBa5GFsnh4k/fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e8e6jfOJ; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyrPJ54kAFnl3WrPpZKUiXqUCDeFFobRVjbuTq8yT4B/vaDIByY6cTu4AbRoThgFqyCH3jRjFAesJJYyfTHx6lhfHZfE784dSIW+LLeem9y1vsAzUvYj024gbCHer068aNaBpWb/wGaBreIgF6dJS++NfBmbBLcHi5WWUjLiJ4FApoEr3HtfaGnDXwFQV/H83ymzeVQqjYWqosX1TlutY1WfiCZF4LrtZmLWRbKS6pbFFsUt/cYHNAY/frMZJq+yeN4+wTuVMpUh4Y0bKqXKxTWh1O2s9x4gqFQ7MxonmJrQUCumAU2Jfx4KYEBOT6AVFJOBEO31umsSZhVvkGSWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBSbgn8RrnR9Ey8m0wS0VZAwZBcX1gA2gBrbdayc+ls=;
 b=ku7JMOxdSrhhTYk5rClQL1VF+cPFcrK80v/EDiV4io2bGyMWM4UQCRZxzkmTs3CvXS4TbfaeAHHt1DaF2aZ3JVIMB1dFAWx/ojgZhmUvon10sNc7otJC1aukgQ3BgSSXUISIQ53AXSo5J94YAKa1ba3J8bdcz3P2oB5McmwMuzElgonsJ1vt8yfiL7Tvt5CNrkLmdPTusB/JILF2ZCZ14n0llQ2vkdf7l3nhrioACffU76fj3W8Bc2oaYzyDQR8i5ZHt+9d+D4kYf3HXMLFscI2PYLRzVfxLRGPqV1pR/8GG9jDb7BzLi3D9Lq5RWp/zC3tKH0RKAQAxCQVTCG4U1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBSbgn8RrnR9Ey8m0wS0VZAwZBcX1gA2gBrbdayc+ls=;
 b=e8e6jfOJL/BHqouzgeq/SjWa2wPMcA9BYDsJyo6HiNsM0O7RMwIcQjVMVejV13DopIXofXWwfig7egKlqserXYb49aegVQpUscW2niTeAGg6YJ7oE3PH6yS4sw2jKH5d7GJNGxNUyLa7ajm2cpJdjmwymsTLgEruA2TzhcwuRt24SEVL5bN/hZysuPSYd8PeX43ooeNt/DWftjNlhhs/AI/OFV8xTnF3it3y84gTNZ67JXmzTgD/laDe1V4aKgxHukKkDp8ZcqItivkgejkaTrO6CXF6m7UP5UfJu1HSiKaRkFwSGh6RsthscvVq/5VnSei2ZwX0JuAiD7pt8Q1HBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:49:05 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:05 +0000
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
Subject: [PATCH v7 06/20] fs/dax: Always remove DAX page-cache entries when breaking layouts
Date: Wed,  5 Feb 2025 09:48:03 +1100
Message-ID: <e493188d4668b45b87e8bf284fcb59a65e45b6e3.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0004.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fc2c59-edf6-4b58-c23c-08dd456e209f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jD/xootGSsIm9+Wf0xYFz06h/Z746pCd/GnfjJ8XLR1IBtk8POE8w6Xh3wyi?=
 =?us-ascii?Q?RVEpJfQ+61UASz7oDI39zjSpg8qERlHdTh2GoWWRggYqgCEjTLfrRxL2NA/k?=
 =?us-ascii?Q?eOva1R0obTj6BzoUpPizdtb5eZWmXHRTYUrpAWUpmzfl2elPBMKS2WKx3Bzl?=
 =?us-ascii?Q?q2cvjWWM6HdQstoWDT7Xld7ALs8ld9jEahFvSIKG+jZljabc3Jmw5ez7MUlI?=
 =?us-ascii?Q?x9wrVdr9abwcBW4MqY0PsjzcMDyULFsX7cAvOVikgL303tijaoKdZ51Mxdzh?=
 =?us-ascii?Q?lnB5+SaoOgFgHXyDzkhRBuIAecHXS6J1sBzM4Mw5T1Q5ST9yYDdXTsInHQEs?=
 =?us-ascii?Q?N1Rt1Bic7fmYlQxhJ3TKWlwXLAkQhDJUvOGahvjmrfpB4gUrK9G9vJ2bLwNB?=
 =?us-ascii?Q?6/hLRlA4EJnyrBc+6tZ1S7kZPefvyV6We5IpPx1FDuUAHgvBZPZ3KaSvH34i?=
 =?us-ascii?Q?29CT/rK0qgkzRrMXwiLF5Q+7x5Thhxrb9F/npq+8ALFtxCM6VV4VWYb8LHx0?=
 =?us-ascii?Q?JAVvxAKevP1O1HI+RVNRj6P5lef/bLpZitXh01FDk3YD6df1/G+OZmCqWamh?=
 =?us-ascii?Q?NKnWajDtnGK5D63UXLDQiQQlCxDdButm4sDxJVWvzmZFS/WcZ0piRtV4Fvz1?=
 =?us-ascii?Q?ST4b12SINHSfkMRBzncT9nb9349U/N0LdBWbIJVI8jmkZQtQ6BoJW2xqINaS?=
 =?us-ascii?Q?T5l/i7xFvcK/ZZT1LPwwulJu6uowp4mwocdnTHzHQVVTIeStLSNw8kz1k988?=
 =?us-ascii?Q?dziJIrDFWu6WRaKZ8LNaGU8/ZORVzmYyMrbFk6wws1U3UvjgPj/okA4/mGZy?=
 =?us-ascii?Q?HYh8MqV96YSavOomCx5eYxEmI9XmY3qMi+jI3vObGHcgyMds5AfpY3TkyDIo?=
 =?us-ascii?Q?V4qD5KjVJJsH4glQbTZ7pQyBN//Kje1Z7JTnjf0axjBDGw6dSY6DTld4NG5q?=
 =?us-ascii?Q?kD+hmq0b4NSuBzqyr2WQMdL0U29xmJdNl2K+EMKy/clhdG7lSZKphprPO9jh?=
 =?us-ascii?Q?rrTfnpUPKKzvwViGrDGib84l0uRaEoRjRyZQ+wqqeyVH3gbSk5V7J7Rf12Q1?=
 =?us-ascii?Q?A1+yM6ymD9yAwEUrnAHiaZQcnZo+fMx89McIOtZq+J2OsnphGI2cs57XMEA/?=
 =?us-ascii?Q?qzUZKpGWTxCgpQik4Tq0XU35E4PI1cTuZKcRGtxpR4/bYfj3SmeZU5xaeaP1?=
 =?us-ascii?Q?AxoYVpdhpwCFCTbeAhEWQFwXxUOuDeNuyWdSn+SI81yLGkk4wfGqiZGvOMjj?=
 =?us-ascii?Q?qfvuV0rdBJonnC9bzeB7cKFvwFqNbPcz0EEdiGrjYbFK5hglol+XRmy2pOBU?=
 =?us-ascii?Q?EVkbU4DfvJeNXVmdn8ZgkvDZzVVaQcbJZK1EmfvZ4HQOmMTONuZwVc1+5Kjj?=
 =?us-ascii?Q?oFkRGUYqcLjIuhLjGW++SKHHXhUO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EXENT2OeBHOpyLuHqJHw5CNHH1Joi6g7znrm1C4BBBes2nd0QUKeOtCsoy8O?=
 =?us-ascii?Q?h4R76Kz5ovJ0YWIQ8QgMkgpFiAHnauJkw1bYFTBex8+64UjNkier5b+X5kfO?=
 =?us-ascii?Q?FrwWxn0K6YoqGpkOT2kBuGpXbx3UBjJ8E3HIN0srBUJ6HsBr379bmu7VVyEH?=
 =?us-ascii?Q?8rztEMJsfK0rTKsC/Ww9a/XjN2lozJwG3rCi3YYz6agFNUVohSOkUSG0RPHX?=
 =?us-ascii?Q?ptJROJJ1+EFh4lYFXCapUBX+acf1/KWAP6ukdFtpwWaNgqG7XFGk+KyAzOzr?=
 =?us-ascii?Q?8ONQXb7QeAKvBuuKpb5xMcOl1bd/PFNgTnSl4QQWCrdfUYrlplFBLGtL3wmo?=
 =?us-ascii?Q?dVHnTmsdZFkWWrCxe+BamBGK4+Hy9f/A4DryPB8N3cCEbvWc6pe3FVHzYJNg?=
 =?us-ascii?Q?e9Ixp09DDVz8HELmEdXwfELp+KIwg/TveVyumMijc5+5JAEwIUQYxJnZV5V3?=
 =?us-ascii?Q?mqYVq3LxMxV6zzQUEec0VmRZSWOkN04c5N41bAccoeRG5l93m3sOigr2XbtF?=
 =?us-ascii?Q?8U4nJncgpgddBlUp3HIrXEli8gRn45UK5pU0FkkznSx3eUdbQ2yUm6m/Tuzf?=
 =?us-ascii?Q?nptkmvsPI2axDJ3azaqbsfqL975DEAkHsQqe/PxehascBnFwnBh9hVHKy4Gj?=
 =?us-ascii?Q?CtUwhkDPgY6VkQyrdjvxcamzED4owLOLU+b69O2Zqf3xdGmtfJgUnN4rap2W?=
 =?us-ascii?Q?SauRbogdr4pvLaRwdr5ZLwdRKhHP6NgqsLWg2Ysl0GvnKdDvUqObrxC8i84s?=
 =?us-ascii?Q?pNuC/rcJNorsylxTb79AKH4PbA7xPJLr90Kar9eGEyBmqdpLL6TJ20B3T9fr?=
 =?us-ascii?Q?0s+zt60d8zbtIaijcuV6+x8T+qO2BWEis1F/HSN6gDlavhUvsIHWH0ZDfnve?=
 =?us-ascii?Q?3w5M+kD2pWH1gp9XkuRYBXtfMTz4zbqIkaxARrIACDULt5tJUuid7Ddv7A5s?=
 =?us-ascii?Q?Rxmny4zrSsnN/6m+kEO7YYlIctsKH61CYD+8XhNS26VIJUF8oubBkqEBfhtc?=
 =?us-ascii?Q?uqBDCjbu6kz/xzP27NAO6uhiyGNLRByJCcUbPCAgDFx6IXrfyw4eatjBS9qI?=
 =?us-ascii?Q?voIBTaOSXqIi5V2NftzibPbIkhAR0nFVR3wr39geUNoAQ/MGDDr83x3geaEs?=
 =?us-ascii?Q?bAjtgEJGEcUbJuKjrKkT761BFabMXLYXXruTOJVPbCQwzGmqFI8UfrmUGWyb?=
 =?us-ascii?Q?P5GP0H6sVcLtxX30QNRAZnNJmk6IkSkQbpPr5lVKnCIL2akVIWsIx0CeQw+5?=
 =?us-ascii?Q?xDaa/llipaMbvDAC1DHV6HkteCbGaPp3HCU3ktKIeVC/oqjXE6mhEBE8UfLb?=
 =?us-ascii?Q?C1ZnJWvrYKm6i4P7CrUTuW/3a2+jCRhJXmRIlIfy8B6K8lkhJHdTVeEbDt8o?=
 =?us-ascii?Q?X5gj+/UDqhKGWDadXvsoJU+SAYcG0m3DgBBr5OxM+EJBRk/gbz69AD9x3xuU?=
 =?us-ascii?Q?3FrChnTwhDcfHAREmUT2iLBp4r3xw5lmID9zEKoJ2H/VYT+Pb+CSkqof7bEJ?=
 =?us-ascii?Q?Ep+iWQt8VQTHwkB1q9LGnzeIktPP/FgDMFGHQWN4q9lWMp7bBH8ZGlFEpdhd?=
 =?us-ascii?Q?39SgxEP5+fJNpRpc3FHBCU4cdQnbMAlnlgVbKi2L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fc2c59-edf6-4b58-c23c-08dd456e209f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:05.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT5YKdS5KwE19F3TVU42gxgzMylW2iucPWGbUPhG2Mx1LBfTjtLSoki4vVFQG2x6Cs37cTa+Rezo1R0THxhDOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v7:

 - s/dax_break_mapping/dax_break_layout/ suggested by Dan.
 - Rework dax_break_mapping() to take a NULL callback for NOWAIT
   behaviour as suggested by Dan.
---
 fs/dax.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.c  |  5 ++---
 include/linux/dax.h |  2 ++
 mm/truncate.c       | 16 +++++++++++++++-
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 710b280..39f1dc0 100644
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
@@ -856,6 +886,9 @@ static int wait_page_idle(struct page *page,
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
+ *
+ * For NOWAIT behavior, pass @cb as NULL to early-exit on first found
+ * busy page
  */
 int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
 		void (cb)(struct inode *))
@@ -870,10 +903,17 @@ int dax_break_layout(struct inode *inode, loff_t start, loff_t end,
 		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
 		if (!page)
 			break;
+		if (!cb) {
+			error = -ERESTARTSYS;
+			break;
+		}
 
 		error = wait_page_idle(page, cb, inode);
 	} while (error == 0);
 
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, start, end);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(dax_break_layout);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 62c2ae3..c9ffabe 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2732,7 +2732,6 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	struct xfs_inode	*ip2)
 {
 	int			error;
-	struct page		*page;
 
 	if (ip1->i_ino > ip2->i_ino)
 		swap(ip1, ip2);
@@ -2756,8 +2755,8 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
 	 * for this nested lock case.
 	 */
-	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (!dax_page_is_idle(page)) {
+	error = dax_break_layout(VFS_I(ip2), 0, -1, NULL);
+	if (error) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index a6b277f..2fbb262 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -255,6 +255,8 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		unsigned int order, pfn_t pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 int __must_check dax_break_layout(struct inode *inode, loff_t start,
diff --git a/mm/truncate.c b/mm/truncate.c
index e2e115a..0395e57 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -78,8 +78,22 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 
 	if (dax_mapping(mapping)) {
 		for (i = j; i < nr; i++) {
-			if (xa_is_value(fbatch->folios[i]))
+			if (xa_is_value(fbatch->folios[i])) {
+				/*
+				 * File systems should already have called
+				 * dax_break_layout_entry() to remove all DAX
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


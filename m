Return-Path: <linux-fsdevel+bounces-60160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC058B4244D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BFE3A5A44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244D311C3D;
	Wed,  3 Sep 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uZ3J9j/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663A217F33;
	Wed,  3 Sep 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911732; cv=fail; b=SDG7OjC4eI/+xg7fewvoT3aNgZlP+OpTLRghyt6T48bv4MDTEX9aNvonQvqxr9IEz/N0rpIBPBpI9M8I3qyGhNOtwZshwS2lWpaHBvAc8sC5uyumOXGqxM1a5fXRVnMbMVsD0JI2W3muSUAEyhrlNSga7StpOQzgzzihlkqx1Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911732; c=relaxed/simple;
	bh=3rTbXXWHlXw4wnML0d0xXkl/xgFyJQHrwOeH/LfsJO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uzSFKXvPTrzl6wN1AwaIn8YAzFfO+ynVdILxyEGyBcxVlwTTxZ5RxJlbIRwGsUGaSY8PrKDUiAPAJViDCyrSJ2ZeHk9Z+qbd9T0x8JNExF7MhrU0PcEuxFMcvJymqocYtrB5PA8FUyOGq4HsJPPBytddRwev7Z6+q3SXTs2HUaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uZ3J9j/7; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0ZrsfW8Ry5ZgPQERJUjCnGJ8c3HiqdybGemePB59sPVduSfNmJVfMXl0P7KSYXjO3pUEU1FEwPR6al1UXIkcJpl1e129Z3BUYWnRoQ1Hur4x0DvI7i5bmJX9dWmd8flzfjMYDIZ538tZLUHyyaYfo1Jo0RO2IUl9Tdsbaq2D2gikyM2/5puOOZudBm14x7jdAZ1EbtW9/UDY0KMim+yq+sq2VmROrS1nggecgOQ03X6RCfBf0xrM192jdRGspl5z9f9K3Z4xFO1jGQ59vJCFSt7qgwWfnbRFAQM8tPXkbZ/R6nhrBL55dC10Oi1FYPUP3jEZnyj6laRqZEj1+2ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz6xgACa6FIMSr4ghRaxTio1qAAt9b7KrV+GB/q24n4=;
 b=be/RLvU3sdOOdvzv5vQkqkWx62mF3RTp7iWGmpLGWyTCROgfVHxzE1Hk8fGyi5PDppfBdWpUb4FV/06547pzE7QZPr+cttjhmJ6mydIXW1yi5W4bwbF/0AQXDcf5l8doKVuI7OTN/zGaZkKWJAd0erftg5Jks8PKKMaEgJb8R1I4aoz9pALP9PzLloIQ3P57JWYr7oS+084tZBm6L0Y8RU1TrAckjnzxKTABFPr7KeAgTmvuqcG3GH0z0e3uio3ycoeOS1UsFQOjT6TN8R9BXkTXrb/6pt+XfcjwaskszFygjm0g/n6hH8IkwCpYNUBzWgqi+jp/WChmDisRTPlL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz6xgACa6FIMSr4ghRaxTio1qAAt9b7KrV+GB/q24n4=;
 b=uZ3J9j/7qnoXCTuTagtPoMAywaUnkCSRSOmn+IlpiT06mMhpkaD6RA73tDgRe3yI6ZILBww2K0XzA7X6lcI1Me9o8uoLB28diiEx3lTt0SCgVr/ZbuAv/8U2TgAgy1JtnA1K9a/wmBqny71DhyKRr6CQV71bb/RLOL3Pnhhdm26ZYXsQgi3fboN3bnLhwu/uIsE5JWypP0XNMTcOyJyddfG1pzypgBksaK1tKg2ZY0EZ+hz63Jo7xjrCuGvuEr5WnHx7mmYKtZmCjRHGoRhE9RmNYSSEVvx922Wo7UjoGtaO9H8m6bEHI11/ycIt6tefYhdHLAWlMyVgDIKMa2CP4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by IA0PPFDDA81179A.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 15:02:06 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 15:01:59 +0000
Date: Wed, 3 Sep 2025 12:01:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <20250903150157.GH470103@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <mafs0bjo0yffo.fsf@kernel.org>
 <20250828124320.GB7333@nvidia.com>
 <mafs0h5xmw12a.fsf@kernel.org>
 <20250902134846.GN186519@nvidia.com>
 <mafs0v7lzvd7m.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0v7lzvd7m.fsf@kernel.org>
X-ClientProxiedBy: YT4PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::20) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|IA0PPFDDA81179A:EE_
X-MS-Office365-Filtering-Correlation-Id: f55a7dc4-22c2-4fc7-edd1-08ddeafad513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5J5XtQ1QMX6LERkkwyxu/fIjaLS/VG26WO9xyLyU8GQ7b5Etvbi1cUXvtbLk?=
 =?us-ascii?Q?DtyV+TFiJ7N20HkVIXQ5KZcn9d0s1AVMrzTYH0qWB/iHoxQLO+e3unal0UJ9?=
 =?us-ascii?Q?4XsHebGlgxEj5tILT9a7y7qn7litaneEvPQ6y+mAfRQFZDs80Q2fxv3wA+n/?=
 =?us-ascii?Q?YjX/TLFtgZvDqtir5RPVeIkWNiUKHgUZvKpKhLAT7DCkhjvYxwVsJ38jHNQz?=
 =?us-ascii?Q?+qTfjDXjlLsn+Fv4mKFkg50Ur3/IZ1YqHr3Zrrdpbi2N6elRctLSTd9P7nsV?=
 =?us-ascii?Q?sxP3JUNbZRLhiJ14MBASkODhJiYV2d3qC+NOZPlqdWWGKMEE5uOkhWcXHCjD?=
 =?us-ascii?Q?Wq8C+4kRnLLbfSqtFeWwHobbDruTGbJhrf+Iq1bVTv7vomLMGpqqUpe8MucK?=
 =?us-ascii?Q?keLkN4KqMXOHXmpdfzlEpYvp0WlgG5PvTpXiETrHUnTC2hV0yDG4QbVCnPZH?=
 =?us-ascii?Q?rYGJbPVmc9vqrc2Wftz2kwmV2bJDiQcNaka3NDvnxyNHcLLi0XKdpft/SUvv?=
 =?us-ascii?Q?NAkFHXn9he5diXQ843rgWsTQbMMsNRuCKn6OHaBKLVnzS9MRzujcn1VTJnnC?=
 =?us-ascii?Q?IMznbRGiZ7iQE9Y25A46aa6qjAOH1LS6HQXSGQv6m/MZ6m0mGFZhVGRHDWQ8?=
 =?us-ascii?Q?EqZJ8QMZmzTqry3Kqr4qtOVjutEPA2vlZSYYzRAz//K4y1evR8mpldBIE0RH?=
 =?us-ascii?Q?xyctSh+TuLeOD7Zrm0wnLtfrE1U93zZYfKUoBjaVoUD78IVoUqZsTdThGWJJ?=
 =?us-ascii?Q?EO9gfecsWbrv0QSDAm1glRXHMdVH+c3IyBSREBHJl/pfWWxUEtZ2t5wm0Xr5?=
 =?us-ascii?Q?PQlMsBbvSkGPDqiq4g40hB5YSStrsSm8CdCZCG6XG7jkRe5gPbRmZmayk2hp?=
 =?us-ascii?Q?Rfo104GB/SOkmcm2ZGYHPIIDbyfA0SP377Ddzmy5Ef+K0LIad2zzdoWZwDP6?=
 =?us-ascii?Q?TVzpuwpCO6uKvg3BFqK0EAEdf8XPdDr2OJtaoz6KTKcMl4p6p6bz1DIsuLLG?=
 =?us-ascii?Q?T2c1wUlzC79lrO9apT/kCpkqb2wYfCUAWRynQHJrg7bB32MbqYG0wA96dTQs?=
 =?us-ascii?Q?spmYBnxgm6nBr6AeXXfyQyqK10wBqa3BCKA233FOTh7J20WCvHbKyuVXsT6A?=
 =?us-ascii?Q?X5Z6nezPXlTswsTxm7PQqczgh+zHpgwV+kNzWsbFO4hIo33IjJTraLj39d3V?=
 =?us-ascii?Q?qHmDmROcJwHcipMcDnIl0I/JtOta59O1NHdxSrOkVlXcj5D2Rk6SJBrkSDJ9?=
 =?us-ascii?Q?X/WKTAwnPciGAvFkrS63J5bZIvIKzn5OPy/GtgMH6y+9JpoXj0/xHllAYZ5X?=
 =?us-ascii?Q?laAtwyMCbAHnO4lLM+Sm7xLcD5iRUlaSFCcQ/lLEUQsqz03lSPITDGHyn0wA?=
 =?us-ascii?Q?7R2s1Zfo+yuHFkZftjTu48vf7s32zVuSyPUn49+iSvY3Di018q4WcRUhEI1n?=
 =?us-ascii?Q?bngEshxizVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gLM8TJzDEVzyxD8uGIVjMeimr2OvaKYeN4ae1VXH6aQO67oP9mn1zI31uqai?=
 =?us-ascii?Q?wH7PkNaryBVXL99hOGTKFcM/DJ/rlkVoKfndp8/mWdjpihjNaSWFilu3itS/?=
 =?us-ascii?Q?WRIl5draMxL4CguOe5oU+b7Mo7jIeAIjKwz81hZDgCIFxNmlDLclTQJOrEq7?=
 =?us-ascii?Q?6Al8Jw1xXun5t7Ass7lWFNHgsU5t7zMVthGgZp47MrEFzFLMCyeEVGKitgNr?=
 =?us-ascii?Q?VK+cU4dlXrWCUr3tn5KMjGg4gwU76zJ8FQ5dESC3phKZfPqWctW/uUNKuApH?=
 =?us-ascii?Q?dEtXP1KAzIaWYiG7QayZ01OYE0uwLUt2ZUJ9paV1YSt5xZVlVofy12PTWCJk?=
 =?us-ascii?Q?n+pTq+zHsJ/M5SIdcA5/y3R8odt5wZGTPo/5EBDHwWqtmhpUY569rJKRSdsh?=
 =?us-ascii?Q?aelKn3SNspk5rYZSBiaWFR7U8kwkbwld8qUYzinXDgHroj6Se3TAoiOerAOw?=
 =?us-ascii?Q?KSDXcnGAo1rjXc0el1LSzOI7pn8fPJDa34JJTxf7pvHTE5wnlGyiJ0+9dN+K?=
 =?us-ascii?Q?QWfuIe8t4nJ7/sOqPCtR60QVC3XYRJUKEK2UrZirA5Zo1mL9J+D/vUvOUNBK?=
 =?us-ascii?Q?O3VdN7gjJlEdpfXA0eaVnkWH4gncF2aIBL3Oco9lnQqQWmwCzzDleufNgf8+?=
 =?us-ascii?Q?rm15/DxMthSr1XIcgCmnruCCvwMKsuClwecLxd+hHwSQRWrCfr6RQb317Evx?=
 =?us-ascii?Q?xHaTxvBbCUon/z/pfqMBU271PrYA4eqwb2G3Yh2G4cGrx7szLIJsn1zY55Sf?=
 =?us-ascii?Q?nVKVxY+OjUMtZ8oBouyo08Rwz4CDfjJO0f9fzvE6nYuYfOJBmZZj2Xu1oGdu?=
 =?us-ascii?Q?9sQzgRQ03ZGwNe89HjxSDHlBIu94cL9eV5YYC6+T/3aWVKPRD016+rk760/n?=
 =?us-ascii?Q?AhIcuOz6cE+6PNm6MmKZUOXiJskTZ40HwUYirVWl69hd7xRD2622MMAnPER3?=
 =?us-ascii?Q?AqMDZ0WOBQ0QvNzXDjMAiqpYFBxGQqaSh3/F5bw1bg46smGyxOwqw1/kau9H?=
 =?us-ascii?Q?pWYn+vwvo957zc8HL7wowyvCWQFngQooSrSCWqwmrcwiZB4K8JrPn2m95wUw?=
 =?us-ascii?Q?OrULzmYO/zFy4JijBvZBB6uqPXx5wu9wKgeOCGXFDE+JbPqyuxFrjvwmcRNk?=
 =?us-ascii?Q?GkwW+Hwx4Yx3WPVE1RE6JcAbfhrGzUmNYV+QxSH4IBKvngoSjXGUlfs4C453?=
 =?us-ascii?Q?Oawh6Qk9nmaXMmmeLaqQcJUAtrvPJC5346ZHNbErflWA8i1nh7RekZTldxdL?=
 =?us-ascii?Q?pY7k+sbRHbl/vjS4S8cF/XprKqc9Rm0qbrvIG4xjczXDYQ3SkfTUJRy+3CIW?=
 =?us-ascii?Q?KOeaXAae3x1VfyHSReBfG/zVdS0fIoj/AceRhfjtSyZfZXARD44g0/Bn+vcw?=
 =?us-ascii?Q?GNkU0HYprlXNWVSsE+s3nYdhV0QIIp1luiHRHRh1vduZD5xU4oRGTbIdEZNX?=
 =?us-ascii?Q?InruMcjkelOXdRR7QnvaC7cCQYyLT3CUKLc7Gei1QIswldKhqo3a0/t8RKOG?=
 =?us-ascii?Q?Zaev9gnf34wiCQEjX7hC8MeeJKD+vsw3uRZdk+FRlGuBzPgzauZ4wwwMdxNY?=
 =?us-ascii?Q?7nJTETC/CFSJK39s8YQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55a7dc4-22c2-4fc7-edd1-08ddeafad513
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:01:59.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3Ty5Ofk1bJxOwK2I6uBvBZH6Vhqk14/qz8PqJ/p/CwCO/N5cenDWkk0lqRTsf+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDDA81179A

On Wed, Sep 03, 2025 at 04:10:37PM +0200, Pratyush Yadav wrote:

> > So, it could be useful, but I wouldn't use it for memfd, the vmalloc
> > approach is better and we shouldn't optimize for sparsness which
> > should never happen.
> 
> I disagree. I think we are re-inventing the same data format with minor
> variations. I think we should define extensible fundamental data formats
> first, and then use those as the building blocks for the rest of our
> serialization logic.

page, vmalloc, slab seem to me to be the fundamental units of memory
management in linux, so they should get KHO support.

If you want to preserve a known-sized array you use vmalloc and then
write out the per-list items. If it is a dictionary/sparse array then
you write an index with each item too. This is all trivial and doesn't
really need more abstraction in of itself, IMHO.

> cases can then build on top of it. For example, the preservation bitmaps
> can get rid of their linked list logic and just use KHO array to hold
> and retrieve its bitmaps. It will make the serialization simpler.

I don't think the bitmaps should, the serialization here is very
special because it is not actually preserved, it just exists for the
time while the new kernel runs in scratch and is insta freed once the
allocators start up.

> I also don't get why you think sparseness "should never happen". For
> memfd for example, you say in one of your other emails that "And again
> in real systems we expect memfd to be fully populated too." Which
> systems and use cases do you have in mind? Why do you think people won't
> want a sparse memfd?

memfd should principally be used to back VM memory, and I expect VM
memory to be fully populated. Why would it be sparse?

> All in all, I think KHO array is going to prove useful and will make
> serialization for subsystems easier. I think sparseness will also prove
> useful but it is not a hill I want to die on. I am fine with starting
> with a non-sparse array if people really insist. But I do think we
> should go with KHO array as a base instead of re-inventing the linked
> list of pages again and again.

The two main advantages I see to the kho array design vs vmalloc is
that it should be a bit faster as it doesn't establish a vmap, and it
handles unknown size lists much better.

Are these important considerations? IDK.

As I said to Chris, I think we should see more examples of what we
actually need before assuming any certain datastructure is the best
choice.

So I'd stick to simpler open coded things and go back and improve them
than start out building the wrong shared data structure.

How about have at least three luo clients that show meaningful benefit
before proposing something beyond the fundamental page, vmalloc, slab
things?

> What do you mean by "data per version"? I think there should be only one
> version of the serialized object. Multiple versions of the same thing
> will get ugly real quick.

If you want to support backwards/forwards compatability then you
probably should support multiple versions as well. Otherwise it
could become quite hard to make downgrades..

Ideally I'd want to remove the upstream code for obsolete versions
fairly quickly so I'd imagine kernels will want to generate both
versions during the transition period and then eventually newer
kernels will only accept the new version.

I've argued before that the extended matrix of any kernel version to
any other kernel version should lie with the distro/CSP making the
kernel fork. They know what their upgrade sequence will be so they can
manage any missing versions to make it work.

Upstream should do like v6.1 to v6.2 only or something similarly well
constrained. I think this is a reasonable trade off to get subsystem
maintainers to even accept this stuff at all.

> Other than that, I think this could work well. I am guessing luo_object
> stores the version and gives us a way to query it on the other side. I
> think if we are letting LUO manage supported versions, it should be
> richer than just a list of strings. I think it should include a ops
> structure for deserializing each version. That would encapsulate the
> versioning more cleanly.

Yeah, sounds about right

Jason


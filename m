Return-Path: <linux-fsdevel+bounces-59294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C56CB36FF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5F81BC1333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F72C21EE;
	Tue, 26 Aug 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OFVMUD2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74F1E5705;
	Tue, 26 Aug 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225228; cv=fail; b=gqnhXG+mh89AoSOuDSdurPFCU27mRRgmrX7n5k1Y1zDvlty2/QgQtZMBDH5E0MwMbE3TZ1DInFOVo5HAJR1itigoehnlsdYdwPXPcto3fcSPHVof/NIC36VInXi4ZWm6ZVEt015mA4ZRK657uf7IEpQdIQucviErUoQle/ygk/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225228; c=relaxed/simple;
	bh=KBp4s+wQRyQlrFFIxdjKbns4JpfuyZ0lcDBhltY/Rko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dvv0W51ba8go5Kz+tPBmlpPBGNPGSTUDCKyb/G00TfykGGf4T3AmPy97vqL03ASqs1dNGRnWzWhbPP5TrFGVmwHBHmfqlrH17N3Q9Q4D+qyBp221ZoZrChXVN0NP3qfiwlECTl4RHzVNF1qmT+WFQzr0opbu+CSBnLm9R5pQBig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OFVMUD2F; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J62Rmw61IcrfkXiHP90kateR87CUSZJ20kR0onCc4EkCuHREBbTQuo++7eHKBnMd8L9kYPaRLniA4A6/2NIdiUuibrL/4Xv27aKVkwZ5lKXBjlCS8LUOep3nj15W+lA4IQNrY6KvZDsdOyYQ4jWX9vtcEnB7DdgBZOFr+5q9aKG27sJ6idzZD5acovgqP1QxmdOVn5w3KfWMfhtjlokKYo7DKXkyFBbKFU/zZ7/z2RzorEDW0nMoFM8CAzZlg72iKcZJhy9N4hj1TFBFRRrpk+442QuURfFo0h1xn83xL2bVL4Zsy7qZO6eTXlsnIvW0avLZQBvkA02F10+RBtZIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FIkiO9F9aV0AgrQP0pNzqJtvVUstzyHdQPoIFz6Geg=;
 b=waCgXr9EN7dOl99gpgXdJXKJMeY8Fg3Y59RwZX2uQ5DNXX2bLde5isNnJiaNQCFY8rFylYcuI5MSoXKMPqzqFalfS+Xtzfv3HFSi7Cx2Pxhg4mPx7NqRnYOqJAsYVdCXMHXXS9JBKaNreJ8Be0eW92IVc/JX2iRHo1h0Jl0n3bNo+iIl1q6eNPln4x0/ir9mMZV8Ny98+d94/parVJ02Mc6uhVQT70tQnn4Ok5q1uiYLiJBtuDHeF94ceLLMC62JXBCUXV6V4jvSAApeDm9uzojBRyxmTjwUmUIGCVCBaUw9O0F6u8ygUoMVOLaS9T7VrMTsEWUTGRYKaMQZfkuAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FIkiO9F9aV0AgrQP0pNzqJtvVUstzyHdQPoIFz6Geg=;
 b=OFVMUD2FRj0l/i2LJ1B27Yluuj3mqqALfZCj9e47mgYMtw20tKwObeZcfU70apMREZtCUl+VAvIv3RYFTRHzkfDEVoUsIF8aXwKUvpWqGMvzTcFcncb1UhQevU3gxpK33YhUY+T+eqhtcFKIIWxuAgmfzluCtVccsWk53xHKK+kiMJ1Lu5586/OpNahRSAonZJyPzDXkpWlwxGLvD0e1pq6VwdNBrq16llc7HAO8M2QZoEQDp+J0kMrPSN+FOLMEWSyu2cX8QSz+o6j51eJQfWGCN8rd6XJqXdgMaQWgVEHfmtp5vsoon5PrUiSC7e4BSjen+wkoQtFGbqJaayzt5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 16:20:22 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 16:20:22 +0000
Date: Tue, 26 Aug 2025 13:20:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
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
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <20250826162019.GD2130239@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-30-pasha.tatashin@soleen.com>
X-ClientProxiedBy: BN0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:408:ee::29) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 005c5ab1-964e-4f0a-7a23-08dde4bc74b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s3mDx/KFVgMua9Uexn/kQFRgmMG/J9G7QbfEJMzZFmSubyWK0XFYnBuV1Zdx?=
 =?us-ascii?Q?EQMjhZSRLTPmqV74G+cFhVk18C55MnjiDM3bh17rcjvtHoCaeW7ftHbtX2JI?=
 =?us-ascii?Q?DZQKqntzXKBWKAh87AKhfvIc9rOOeCi+z3OfYjb/miX/NF7aT3jEbhhghM/K?=
 =?us-ascii?Q?pMRgt958Eq9ddxDyRhyiue8pPyHSV45pPtpxJMqU8lhliYw2Cgzjc/N7dcwu?=
 =?us-ascii?Q?/RfSzdsuRuDCWKQNY5ajqxkpiP1WXl/0L6lvjx4TQkZTLZiHWpreRYg1rsEF?=
 =?us-ascii?Q?suiYSjt8rDsQNdehSgrnDpc3vm2viO1hy8+d704HfCjZbmRNdHGLnQbSy5IK?=
 =?us-ascii?Q?HvliXuJDuWIuhLk1b9nZt7mbHt5Xsqpm8opJv6Cu0FHM18xsI/ZppkoQL9jY?=
 =?us-ascii?Q?BVfapBdBUYPQlLAsbOiMNBA9mYZ1llFZmQ/jyFyeL+MfoqIsR012qFU1oTXf?=
 =?us-ascii?Q?R/X8uYTH0e58+du4T7vky9BVC7HXyilck56xxkJIBrB2dae+BdxshORsHvqR?=
 =?us-ascii?Q?EGxpnXzCFX+/abhPnDvmAGLKlCyjZ0GWKKMXhZN+y6PYqcDsojuxlBu1xNlS?=
 =?us-ascii?Q?GX+/PPxEliceiREbyDBPysQzlyshqfaqxHAYY/ZMVqk8yZ4LrSbGz67p09y6?=
 =?us-ascii?Q?GgEF2Rr9+BArHp6LqlaBKfvAcMK9mZn92Tc/bGn1E3MlEVvZhX4x0d/dL7sz?=
 =?us-ascii?Q?Jw1iTPcjzKJ++dlGq3VvgqC7+jy/N5gyJedpGXs3Zr4HHtFw5QBQF1kRqtvP?=
 =?us-ascii?Q?FxoaeafGBbdLUbMkRJH8PDuXAADSb+4K+BNoyeKc0YlKMFD8pfHBpzGLPQZI?=
 =?us-ascii?Q?IWEdoXWB7XEL0iQ0KBtPa8CCcOXZcxdgCzCkbs14smfV9AhJ0lypdYg6XCQg?=
 =?us-ascii?Q?wgyh5cGk/ZvHkVnLf75AkEUU5p8mN1QYXuyfpL8bICFoJ3gk4SB1eXwcSgjV?=
 =?us-ascii?Q?PIns/z2dcLyHW+p7SGqacQO1J1VtWa/q9b+qvpaurIfrSMyy1MmfoMGRORsH?=
 =?us-ascii?Q?F9VnfJ2wrNl2pg28twnUANsQCCxqUu8DKGv3Y44STGWNCR4+XqTYWDq25+3V?=
 =?us-ascii?Q?DxLAH4BgZ23ZFZA1WlX/3SzLcOmLZg5tLan8Lo61RatTjcr8BNSkk/sA9pHq?=
 =?us-ascii?Q?Hc8eAjvZ+9cfM2yRFwJ2qI9IhvjSxeajuJRDuzJ1IwcdYp/blqerKvJw4r78?=
 =?us-ascii?Q?3cbefJ7VGzgyJQq/FKDuonHiRXpt2uoHyp6rDKoBfMSjawWmta7gt4K1tUwn?=
 =?us-ascii?Q?/jZ+UN+PhaUyO24iyqprg8puBAtP8h7LiFJTMg9mZtjrSsJJwyPxJd9iBLs1?=
 =?us-ascii?Q?c+SWX58YiauBJFBoM2eHfe7uBWdP6xMzu7N+uHl5b2y1dBlPoyfKWsBy1doY?=
 =?us-ascii?Q?YUHx686oZ5cOtfAZ9P5MDFws2YWvtjEpfxAOi+C4e5v6IbPLNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pW9R4n8DWFiHbDPdfJT0iKnX0SuYKlb5Y5lpY48Exi9TKFE6mRWo+XQVePkA?=
 =?us-ascii?Q?n3mcmNThYk0stl/0VSjiJHa5uXgY2S/WLpNCmmsxgGavGWgz2bgsVL3iPeer?=
 =?us-ascii?Q?ko0eFGQqK5O9YTWPsAXfXFLC+5R+Ws3XrOIC2hkY4Ylol/kBvkeuie1qFC28?=
 =?us-ascii?Q?2ThWqkzbqseL/MQxAlMl5+0PtrDdlWTp5+llZfqxBRLy0M0WVQlxddF4SCYd?=
 =?us-ascii?Q?jHvkfKPuj/rhJ3XSDxqp1uN/VPbl0blrk5lUNU3Haw87hJ5zh+Erp8VrgXaP?=
 =?us-ascii?Q?lZl9gtwjLjQt7ibZmCq/RBfOBTnWyYSWlbePn20d5ryaG4YlcwDxzRMO58vt?=
 =?us-ascii?Q?w9s3ZGZHt2nOaU24EniHNNoiURxgcnIi2dMywuA5F1aKb4V3F/av5RSeusMp?=
 =?us-ascii?Q?QvHJzDNAgDYUru1X3yVvLPSU3w6TWbNwRueTRPMCitLGAwAmzky7wuTczSvJ?=
 =?us-ascii?Q?OhjuxRAb43NX8htbHYZfuWKdBh6Tva9yrGNYaEd/uOiRoq2JHRWGq47gGGMv?=
 =?us-ascii?Q?a3sd7P9vt+hCfFo0Of1VkZ1Kn8LbhDi/ykJ5/ejljv1SFmqzGNgrYclyulLn?=
 =?us-ascii?Q?Pge0N9awU7rqISisz76EhqpmsHAeb63BWyoQv4EM1P2xzrVcJfbBasH20/eC?=
 =?us-ascii?Q?W93Sv9rGbi+TQ0e36phyEtqYra8iaELMP2fH+eiS+tiFtRdDeoen+PVXRZds?=
 =?us-ascii?Q?jkvnsxxLtSTCZ/DnMGNw8b1d2k9IcSAI685ufyxeOanK6NwjwLj1OLdqV0Pf?=
 =?us-ascii?Q?6KOSG2X8SLzT+8DQNr/Jw3NqDMSXY/unkR9lipwmLSRYMqF8fIucwQ2psLIf?=
 =?us-ascii?Q?s7iaYarZzREPJlZdOiLOFu2UvKjZN1Vu6nhmPrPRorJ5YxBoJ6uGg38cyBXk?=
 =?us-ascii?Q?/n+5uV8FEECyCNXjavmJb+54Pn+jXiIhEw3CwK2/I8v01dlTJ81eY87nmXGT?=
 =?us-ascii?Q?2DdJabgDXQ65iyprLeXpeNRIKg7nFYQDVYwPbjrTY+ygKPdkGu0hGdyrznll?=
 =?us-ascii?Q?GZZsluiM1tAiK1YwU9KxXM19e9AlUKd+ov45hMOYI3BA8bxz1M3hR7VZKl0P?=
 =?us-ascii?Q?eMFQJ9y4H6MGNxudAxGIQ+flU1CKrqd8ZcAX5Z/LrXZv44sbIl/MJKnRm6Pa?=
 =?us-ascii?Q?sluMYcQCCDhzDvMnItYw32O//E202UXNxL7Lnhn09AQkeN7Wp22QYoXHKW0y?=
 =?us-ascii?Q?WW1WaBXZyiwqoR3mjEqEDWWaYOziZBIdnnKkfDXBdcTy6n0el74RFGVXsjjx?=
 =?us-ascii?Q?833gXc+/aX0AaHuxvLKHQh/s6Ihsa2JQdHSzYUsO+EHjm6HIvc/05qoBQhnJ?=
 =?us-ascii?Q?+qk01n4YSuFoU64cwuGWSaau9yhYVWMZd2eQae2zpH20KypD2QtsYXIQWhad?=
 =?us-ascii?Q?/ngXOcvrfaua7iM5iAuctbpt/1LHCcaFp0n+igjtW348lEeNOV2KJ1Wbbg76?=
 =?us-ascii?Q?Dp00A6guF/LeNDgS97Gf7mM61mKRANb9bLISiNHHrMCFNgZUYY+0tX+cX5Ve?=
 =?us-ascii?Q?1EUpiiD5KrFqFz1fKP/lWBShI+vomtfFxoZkMAC/0C/CkDFqVaaNa6A6CnAW?=
 =?us-ascii?Q?+0w9lYncFK6lV2VJTzNFaBO998vadQT91ycaE5Kn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005c5ab1-964e-4f0a-7a23-08dde4bc74b3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 16:20:22.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6WK0SXLKlUcl8PtImwnJAnnMXF4AiNvMztENX9KpYJzH2OhN48+nV54kCAkWKc5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:

> +	/*
> +	 * Most of the space should be taken by preserved folios. So take its
> +	 * size, plus a page for other properties.
> +	 */
> +	fdt = memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SIZE);
> +	if (!fdt) {
> +		err = -ENOMEM;
> +		goto err_unpin;
> +	}

This doesn't seem to have any versioning scheme, it really should..

> +	err = fdt_property_placeholder(fdt, "folios", preserved_size,
> +				       (void **)&preserved_folios);
> +	if (err) {
> +		pr_err("Failed to reserve folios property in FDT: %s\n",
> +		       fdt_strerror(err));
> +		err = -ENOMEM;
> +		goto err_free_fdt;
> +	}

Yuk.

This really wants some luo helper

'luo alloc array'
'luo restore array'
'luo free array'

Which would get a linearized list of pages in the vmap to hold the
array and then allocate some structure to record the page list and
return back the u64 of the phys_addr of the top of the structure to
store in whatever.

Getting fdt to allocate the array inside the fds is just not going to
work for anything of size.

> +	for (; i < nr_pfolios; i++) {
> +		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
> +		phys_addr_t phys;
> +		u64 index;
> +		int flags;
> +
> +		if (!pfolio->foliodesc)
> +			continue;
> +
> +		phys = PFN_PHYS(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
> +		folio = kho_restore_folio(phys);
> +		if (!folio) {
> +			pr_err("Unable to restore folio at physical address: %llx\n",
> +			       phys);
> +			goto put_file;
> +		}
> +		index = pfolio->index;
> +		flags = PRESERVED_FOLIO_FLAGS(pfolio->foliodesc);
> +
> +		/* Set up the folio for insertion. */
> +		/*
> +		 * TODO: Should find a way to unify this and
> +		 * shmem_alloc_and_add_folio().
> +		 */
> +		__folio_set_locked(folio);
> +		__folio_set_swapbacked(folio);
> 
> +		ret = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
> +		if (ret) {
> +			pr_err("shmem: failed to charge folio index %d: %d\n",
> +			       i, ret);
> +			goto unlock_folio;
> +		}

[..]

> +		folio_add_lru(folio);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}

Probably some consolidation will be needed to make this less
duplicated..

But overall I think just using the memfd_luo_preserved_folio as the
serialization is entirely file, I don't think this needs anything more
complicated.

What it does need is an alternative to the FDT with versioning.

Which seems to me to be entirely fine as:

 struct memfd_luo_v0 {
    __aligned_u64 size;
    __aligned_u64 pos;
    __aligned_u64 folios;
 };

 struct memfd_luo_v0 memfd_luo_v0 = {.size = size, pos = file->f_pos, folios = folios};
 luo_store_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for this fd..>, /*version=*/0);

Which also shows the actual data needing to be serialized comes from
more than one struct and has to be marshaled in code, somehow, to a
single struct.

Then I imagine a fairly simple forwards/backwards story. If something
new is needed that is non-optional, lets say you compress the folios
list to optimize holes:

 struct memfd_luo_v1 {
    __aligned_u64 size;
    __aligned_u64 pos;
    __aligned_u64 folios_list_with_holes;
 };

Obviously a v0 kernel cannot parse this, but in this case a v1 aware
kernel could optionally duplicate and write out the v0 format as well:

 luo_store_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for this fd..>, /*version=*/0);
 luo_store_object(&memfd_luo_v1, sizeof(memfd_luo_v1), <.. identifier for this fd..>, /*version=*/1);

Then the rule is fairly simple, when the sucessor kernel goes to
deserialize it asks luo for the versions it supports:

 if (luo_restore_object(&memfd_luo_v1, sizeof(memfd_luo_v1), <.. identifier for this fd..>, /*version=*/1))
    restore_v1(&memfd_luo_v1)
 else if (luo_restore_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for this fd..>, /*version=*/0))
    restore_v0(&memfd_luo_v0)
 else
    luo_failure("Do not understand this");

luo core just manages this list of versioned data per serialized
object. There is only one version per object.

Jason


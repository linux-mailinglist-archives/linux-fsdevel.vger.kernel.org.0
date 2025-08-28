Return-Path: <linux-fsdevel+bounces-59493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EEB39D94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08D51C81754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6D30FC14;
	Thu, 28 Aug 2025 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TP+H0YiU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1E30EF61;
	Thu, 28 Aug 2025 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385012; cv=fail; b=s/2O/ljiu1Ha92bE7qih4P28iFcWE2CbdbLJJ4kQn9eaEpTcG98yPqp03Az8E5oORoAThYv3j2u8JWaD21C7Y9kDnbHMuLezQtuHBuh3YYBs2wqu/GhZJ9Gz5lwPA74jzK9DQpG5Sc8tbaNUDqv1QTk+tCm0ir9xToYCNddYkoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385012; c=relaxed/simple;
	bh=8ByEl+7ELaglsZxNEFimex86U9hcogzvfzZ/B+oHOps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tZP/WHPUIoyS7WMhzNmwOHLfWhJ8Irfqd+2oepoSx3kHcdoT81P4m3KWmg7kH1UMscWfjRLxBrcLpLkKaUIhD62G/wVzq8fREv/1POs5BJnP/lDCClYpwFXOAHBlBgYLRgY90wcgE0xJpEoQHpMVaBfGYSE6z4Hpa5u+a7cA+bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TP+H0YiU; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7Z8jbCxY2QQI23J8DEffwnW1Z2s/tiRF0k9F1HqyDnP6JRbT1NRdk41ACngpFb3v7Hthvzke4CweVgskrqjiuVHscFzeOjNdAZv9BmpS3w3YxLM+3xZSx/auXLXjO5CQxGigyklSi6IywvwEccjWyb/7eyzdwRnWH33ArVEqd/mOjyQZP55Yfg4zem2g28dxeypqxWqNLRICsJetDSwpsiDpSm9xtzaQEOjmlSqHqZWgM7wdXeGw7bNv7xZvDjY96dl8NzC+UZ6g6fqYHpGWt8ajraBW61AuzoBMohDRGfnVxRgvIbgWOTkJqZKCjqI4LB5o2pR6a6P6NLTzfkPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4iAJhPyyVzpy7B1kjeGEhll8NgACi6kl593+pExpZE=;
 b=SDVf3wph79Uyn/Jf1/LUAguKbPRrbJYD/vllVk4DSlRhMc6jujNczbzAgOoFLVbZSGqyz4SUTqiaxjvTXLbskXBGuA3a6UYO7zz5ITjUUloeE6B8dQOpNsZayLerGnE4VAS0waRxRGyATYihznKhK6Iv6i3E379VahPVJSrKdufnaOlMGywLF9CUYNv7COU3kLlDf5aT7jzhhJoroyt6dMjq8He8E8VJcnzR93BGHFwF6T2hua0/BlAqVV2EknufZJ3CXhcBiQxiCzssGgcYf8XlrYGKsMcjWy84KwJxB5uzouibjugbwyCL4jwUekADGBSyLnd6GTunfnqpMt3zVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4iAJhPyyVzpy7B1kjeGEhll8NgACi6kl593+pExpZE=;
 b=TP+H0YiU8CTIrGaOko0VSpmwJsO0Wh7Es+/lkJVdhGxDbTGkJ2VEuoOn5tD/h0I3320Yvkeh/jn4px80f4S0s6k5tChTffjTXGZwHhjUr9cyAqIzqojWE6rBlx2/BSQfpTViyFwqNLEjNrH18LLO/75MrtlXTwtv+X0o22PNNF1IsGfWkID863bogdeMZte0deJrCbaHNtsR+3Vdo7g2Xy+ZuwuAO5+aT3VNBioZkVRW/ghxkTtotYapvydjvq/qqV2GBjMV35Ylxlk2S5aQvuwbgGrpzaZ2y57ymcvJLBya1WarbO22lxUGqwE5JWyu8PAdf/IIgob2UmxSKg17fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 12:43:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 12:43:21 +0000
Date: Thu, 28 Aug 2025 09:43:20 -0300
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
Message-ID: <20250828124320.GB7333@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <mafs0bjo0yffo.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0bjo0yffo.fsf@kernel.org>
X-ClientProxiedBy: MN0P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: b52301ce-984b-48d7-f7e0-08dde6307887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tVC8k0cA87V/5JOft/h3y7ye2Lv5vfD9Y2iESmEEqgONg/pIX98VcmlTXvhN?=
 =?us-ascii?Q?LSrixX85QsWMOn1QZxAxn1LL0z5QWYJ9KJ7qmgMJBLANRpkPhH639n7p+ZhN?=
 =?us-ascii?Q?/6XRZVQvVTP9lKpbzlG567IKkEaeXfZOZ9U86pugh8KeeggaCOiJDaYU5b6Q?=
 =?us-ascii?Q?mI7uFyDRcAXMUQ8nQNCj6RPFdA3JfESauvF+cJX2L/QxVzDWpkm9aYKXK5Cd?=
 =?us-ascii?Q?yplKEngaoaL/sXveaQZel4KjTEBhscLqbejajuLbnCG2apRrlHGM1/39ssWh?=
 =?us-ascii?Q?QYZIuZf4pHFuvPaYxigUuhNSG3t0joBPCWZxeVcq1XP6BMWfvwhvhA7evm2i?=
 =?us-ascii?Q?WBoZYvuwtsIZGTPxeFfjiaJ6CuywaBrsFsmN6D+inT+kvlYmneeqs6T7Rtzz?=
 =?us-ascii?Q?KXvjxfOVNqGE2N84t5RcM3Q6G/RtB3OcPcG1O2339s7zGSnxw1C5VAKbAEHv?=
 =?us-ascii?Q?V5KzKHsVZGw/HijMyBWiP211f4ypH2MeAnNePRKInMWiSEKVw6KLned84vuG?=
 =?us-ascii?Q?0n7kURvMJ7NrPMzamCULDHGQd57gacgQ4AeGbGPdJPBlw3lib2Gc6VCMLkAe?=
 =?us-ascii?Q?SdXQYpPPej8VSMOEnADsFXklFkvnX4J5avhTHV9b5Zb6K3yWGIzaGUeeRi07?=
 =?us-ascii?Q?bVTgEn7J11BLYz4/gvbsgikm6qft/HKS5JW5LDZC4rI2owshcrzXgYfflDkB?=
 =?us-ascii?Q?mAAIp5z3t5/Q6cVbcK0yBiMsQVw5EnEyZAM0Lm3lZ5EeZRylUaX1BHkU0Whs?=
 =?us-ascii?Q?f8fSY8IOvXnrAPdckuqOKVFOU4rw41uDajxCRoQf35robeD3Zwcq4Z5IRi0O?=
 =?us-ascii?Q?XISn4ec7wEmHocXz7V/Bn8w1t+OyRrb+A33D6EoZAxfVCkT0jCDBlDak0cCW?=
 =?us-ascii?Q?oHmkI2p/bI7ot1IFrXNZlGxmqgDxUNU+CaCOgGDHyKzdH7SzQt+9O7PUrWvp?=
 =?us-ascii?Q?MexlxfeLuSy8NpKtpTjVdh8KKlt6MQhrp+sMrewrPlC1u5FEtlxThTsMRrGM?=
 =?us-ascii?Q?1bK2nE5Rkd3Q+t/WAXAupwWFuh6F6s0mxo5bJunu+gLPlNNz0lnfwJOc2ARK?=
 =?us-ascii?Q?5W7zipTFx8EPa4/bKKbjxPyWhXgylitiQQck42ZaW8tHQmsEPIXseKSISjTd?=
 =?us-ascii?Q?z3M/5Fw3DGt2RoXX19+xkwIV4PE3AveeROj8rSTCO1VJX9RIm9eq1gcvuncm?=
 =?us-ascii?Q?C5zwmv/bxyVR0NFIjuDyf++b3rTS++GO3Aem5DsrGJQ0vesh3GFEJIktjThh?=
 =?us-ascii?Q?tnxUYq3MASn+kDhFOGOQrv6t/jTdxSkE/1YIAR/sHuZy0KMkBfoWRkzpCcEX?=
 =?us-ascii?Q?EOz5k1zhcljaaOf8ut1xuevX8+JEweVgGydKuuI+q6oQCVfJxmPgzxsKoy8e?=
 =?us-ascii?Q?OZINLLRKExc7ymdsXMbXmSUfeOIfSw7LIyBC20iWrq97rT0VLvwv7Rplhstz?=
 =?us-ascii?Q?14j6pWKHWDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WG+fbHT+C0sLJ/9kBBS5Gb9P4hwEmkYDlI4z3m4T56SD1CmGePATJF7Fgf2l?=
 =?us-ascii?Q?OhQp1UgOiDyOYm+mHTfVVmvIycN3YetedAEP8x0/TiXV8fX08SNGYq8OP2s0?=
 =?us-ascii?Q?K9WAEN0qk912YxQKnCYiG6YzDboS1IxsPmveUBNPultrh231NLtYo+V1gs/h?=
 =?us-ascii?Q?atklHOIcQ/TYrv+zs9uLVsxKSmzgp0soYK/fEZqqsw7I9OWK+RCklXRzQxSX?=
 =?us-ascii?Q?PRIHoS+KgW/1ZN0OQOzlbNrymuh57ZoSdJu+b+lXV5B3EsbzdJA67NjZqwJ1?=
 =?us-ascii?Q?EAKX8bzTAY51zmOsl0JeKYYrjndOtttMvbppfNam/w6AP4wwpCNl4tIfUl4u?=
 =?us-ascii?Q?ovM4vu30GB1rrnWwSq0DHJKjhFd8gN4XP2elOAfgnzFBxW8ZSLNiizKzeWnK?=
 =?us-ascii?Q?J9MNT0g/mgvK1BPYt0sFyEwc3EZuIlxuZMGDfIE5r645tEeuq9gWrXeh0SKR?=
 =?us-ascii?Q?VmB7ejl8/eZqxb/91BnVpkBvmzOhzZmKeZyncp814hPAoIdrFTTzo33D0N9R?=
 =?us-ascii?Q?1mqYm6NoNe1Boa4wW+P7MduuelkxrdalNc52Z7tWd6TdooYvyTOhErVl/K9i?=
 =?us-ascii?Q?c4UgNsRE7W1TXSsRY4o2W1Thq9mhgfcZpwFBqdTxoCiVT+xwrsMOXGaac97K?=
 =?us-ascii?Q?byUUHkYcJeTcD5vMRq7FhQ1vu+Sfnxk7naDgUh2m7dAr0xqY8ivSYPalxjlx?=
 =?us-ascii?Q?iMA6bmhLPpOS891pphj1C9NTNf/v1R8mhdHBthMnW5RgveObw1spHJVDLxNK?=
 =?us-ascii?Q?kSuo1HibLRUiwwmgzFWxskgpyElLmxZue+1/L3zKxW8zNQIPIM8lWFy7BfFA?=
 =?us-ascii?Q?F4Yb4y9OMIOIOVyqCuu7Lhp+IUT/89q4SCqETDZnBysTEKi+Ge793W85H8vv?=
 =?us-ascii?Q?5p11M9yW3O4+O2ny9B4cBuPYbq0Hj76AVPOu8L/Voi5Ulzs3CcrjImko55Ds?=
 =?us-ascii?Q?UCz/TceqqsF/fQStTFHnOvf0h/0rDbymrB4XPt6Xt/CmbpKUInOcPDa1YdSr?=
 =?us-ascii?Q?sTCcalwmakoKQODW0Qj5iCpd86eA2IcwwClQDdBNakoOigc3ohZpx7V4P939?=
 =?us-ascii?Q?uxIgefKIi2QvFevoMjVm6GKuGDNJYMnrGM2OUKoSGHULYTDuft2vLrsOXoes?=
 =?us-ascii?Q?oyePZ7jo9Rgrz9cJNtt3thXiwLr9OKuSqw/E/bJpq9QmhiVUX6ALE5ApDy1C?=
 =?us-ascii?Q?TFFfjiwHpzOujDX9MZKsQiwmxtj5eSQEgAi5JWtcnEyodxhSjR4ciRWWHl7F?=
 =?us-ascii?Q?3zYFl+dzdXWDBSX0gWzmaOW0n3/qhv5dZahaFcbVBghR68XhuTZleYFBEdYq?=
 =?us-ascii?Q?kIt9Hb1HqRD9el/rZx4UFmRczCbAB+bW5jMvtXIONLjPcIoG9O8Z1tL/4cxb?=
 =?us-ascii?Q?5pjKNRQTnx+cbqkc26sBbBpm3jV8JObjBgTmxwZVEbtNsuETI/kjgkGgpac5?=
 =?us-ascii?Q?SJSAN81rhsbsrHwaDqB1tBzaUCTbmMZ1TD9DYSas7W2vep3237Gf2gC4igSo?=
 =?us-ascii?Q?q+KeFf/S2rjrXwYJiRIBLEeKf1oKwf5PZV0Fb0kvIxfFYYA+lFgiUvS/Mhi3?=
 =?us-ascii?Q?3fDuM6QaVRxCu5Y1d6g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52301ce-984b-48d7-f7e0-08dde6307887
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:43:21.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckt4yb03zFaBs5jkSWh7HqqXFNu/8Ph24yaZTESNlIsI2hsGYU69/JKfoB4aVJEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

On Wed, Aug 27, 2025 at 05:03:55PM +0200, Pratyush Yadav wrote:

> I think we need something a luo_xarray data structure that users like
> memfd (and later hugetlb and guest_memfd and maybe others) can build to
> make serialization easier. It will cover both contiguous arrays and
> arrays with some holes in them.

I'm not sure xarray is the right way to go, it is very complex data
structure and building a kho variation of it seems like it is a huge
amount of work.

I'd stick with simple kvalloc type approaches until we really run into
trouble.

You can always map a sparse xarray into a kvalloc linear list by
including the xarray index in each entry.

Especially for memfd where we don't actually expect any sparsity in
real uses cases there is no reason to invest a huge effort to optimize
for it..

> As I explained above, the versioning is already there. Beyond that, why
> do you think a raw C struct is better than FDT? It is just another way
> of expressing the same information. FDT is a bit more cumbersome to
> write and read, but comes at the benefit of more introspect-ability.

Doesn't have the size limitations, is easier to work list, runs
faster.

> >  luo_store_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for this fd..>, /*version=*/0);
> >  luo_store_object(&memfd_luo_v1, sizeof(memfd_luo_v1), <.. identifier for this fd..>, /*version=*/1);
> 
> I think what you describe here is essentially how LUO works currently,
> just that the mechanisms are a bit different.

The bit different is a very important bit though :)

The versioning should be first class, not hidden away as some emergent
property of registering multiple serializers or something like that.

Jason


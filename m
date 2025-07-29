Return-Path: <linux-fsdevel+bounces-56267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C799B1521F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993F718A3938
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60992989AD;
	Tue, 29 Jul 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXbJ2XrY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B364A0C;
	Tue, 29 Jul 2025 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810405; cv=fail; b=UkEygC4AZZbUtI49InMB7NK3UwkAhX9aG8KSiOI12lwXOvNy6btID5E8AgvUi2eaPdEdRtfUi1lTTqRHBgIwlj+ZVEb4bebsLGQ1jZyktSBe7XPVkkjGrK6MXAacKi195tJEAbVWdIHIcj/NMXFg+kT/5OsZA8FnNcS6NvS814c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810405; c=relaxed/simple;
	bh=EsDUHbPYBGHbtCBiYUllSo8NVOtEBcXisJIqBgMjCNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SPNg3rqgUhybtBUpBG5YhTwqFl62k5bKjlcw0hSB5bgWC2NhF+2BkgweA3JbzWXIYn/IBEetvkIZtUymGcVVoW96ct2eHWb1gPGoJuHF7NlpOzKiKsqmFk6NPuKXxMpfgZpdYXf7JpThEKiOcLAQNSaPhFpmmqBS8lz6KFHiimw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXbJ2XrY; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk9JXydu7xhdf+x3huJoVAQfowdQK5EnSTCEA585j/et/XoOlffs5z1MC8CcaQWczK19zWyHHFZIRnyfhdQDIKq2FOGq6cr18bH983RccUUiDL8s+bC5vEUzSslRVTbUIPFS49QKwrgsBWxYC/wnXQzN2bjWKNa9TU2AQJ1N+MVMbgGGvUYjM1g9GEo9386wb94xhtsQsxBqgyQm5wqvvozTWyeanrjNFOOcI8WfZvDCfbXAVL/3hcTr8XioaXAcbg1+QjzzR01gKlWmFhUyrEemM3fXVWWjj6OURzgIAspX1yXBrkerPm2ptrIMLTkUnDFqhldq9KPVevPP5OkQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47kHgJA1kkjeZL0nbbrCD0dW9hvxPVMWD9MGJuhJgrw=;
 b=BuqHmTfIu/OnSeELSNk8reUxWJhh8YP0MtHfq9v5vTcjiF2Pc5uTxFNV00X5w3fLICsbslHLhu8vZTlODTpP7V5UgT+JdilED2h/2iBHCAgzowq1cm3VxRmvt6DLI9pJUdnV64m/jeaTo8toM0jptBUCYz7Ds/8kpB6NZSCZ0SdLKrhbflxsM7wJDWpM4HI6gadZDiXMnR1WkM2XZNow1nLjhvUi4se/iYj/PR7smMm/K+mmBGzR3LnjHDd3dBIHC5yY3DV4r3aY3PxmWt8aebNcQeALTYg/YKEzqnuALHJvPRC4iOM52rgDLW2yU1s0iOd1M5TmFNKlfdUGqQbvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47kHgJA1kkjeZL0nbbrCD0dW9hvxPVMWD9MGJuhJgrw=;
 b=FXbJ2XrYg+ExMvLI0dxp9uoOyGPyrz9nODqZuCE/h5P+W1FQApUpumRLIXKiXxlEtGQYjxkm/aF+QqZE668WfpAtjAoJEn7Ntyx3osUT07JVg75yWSmdO6djDLVowERutAhOfVQWNUI86S4YB9RI96W3dh04E2aCIxsSZzAonz2FggYwE/PRnAtFB9ediZHkP8+VGuHzSPj0O4EeSJaJBIVL5rxsu06lKZG7LCHyNcu5l1cmL//5lzwnZUSM2Uu7jsNErSTvbbhzKb1M0cN+2FCK7z7xSEpy/OygG9iUc7mp2ytx4it3OHAfhIrIGenmzPGZ0GXXHNnXhNt76AiYLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 29 Jul
 2025 17:33:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Tue, 29 Jul 2025
 17:33:20 +0000
Date: Tue, 29 Jul 2025 14:33:18 -0300
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
Subject: Re: [PATCH v2 14/32] liveupdate: luo_files: add infrastructure for
 FDs
Message-ID: <20250729173318.GQ36037@nvidia.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-15-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723144649.1696299-15-pasha.tatashin@soleen.com>
X-ClientProxiedBy: YT1P288CA0035.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ff101c-9c1b-4d07-c59d-08ddcec60299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ba2Na01DYOZluWstg76uKVrdrmA2YJ4oz6DKkvm2uiKqVDQhOFQSCFnqocXD?=
 =?us-ascii?Q?dV9Q4D1xhfTJsugHkT4ZkxxnTgFU8WbeeoTyuPTqN2G4fjXEVyCgZHO17XEL?=
 =?us-ascii?Q?npCD4EKl5xWEiG8eGxo1og7yEOIc5sRr1FfpVf94b+NSqPkg6+aek8NByXyT?=
 =?us-ascii?Q?p3x5gZ9F0uPZQvuihCArDMkOxtM0mQELD+CTLBg4v76IL/1GzWebtlaUu+UH?=
 =?us-ascii?Q?6lBS1xjteCgMBkHlhSqFwP0IfQvDuP9Z7iQW4Ias0YgWF/qLWq1QrEYK2RkI?=
 =?us-ascii?Q?7lrW0Zr2zQpteJYQyCwir0H7AgDOk+i7t+BqmN2+6+3mV48GzU0e+WSPVPuS?=
 =?us-ascii?Q?zOZiJNCX/Y6H1EIA7FeZw/FhSXUsWxcgsFETV0vP7exvjsi4Ks1Hs3yMAyvY?=
 =?us-ascii?Q?DYfEOiQHpSrYJLD6CuH/BjnvaZhfG/FOHjuM6GV3B2LBix7pboZOFQ9bnHWv?=
 =?us-ascii?Q?fHo16VOhxwl6roxX+lUFvD0oJS2JzuX+NX1yb5gf2m14NrCNzC1ItgekLIS0?=
 =?us-ascii?Q?vY0vmY+eqNc4IfNReMqdoSwh/LL2S8cAUe+5lcUDOUFWOFMf2qAnMNWQHGdA?=
 =?us-ascii?Q?mO7LNmd9NdwJ8iv1IQJzL3e8bd24/v7tiCR+2eZMgQNsYZ+Y4YO3Msmt3bBI?=
 =?us-ascii?Q?BvSAbdBq3TPn2dO5omIxxFdOcimVWMZicdipG0+/sXjLUqvXHUmwzk4E8oGj?=
 =?us-ascii?Q?AfuAhKClFs+QSYJDMbVy1RLEpf70W1KQ2Ci85F4OuDEtss4vJtoL5vnzsG3O?=
 =?us-ascii?Q?U+fu51dBHEwcgn+tyVqSVmJaEWe1jjLkOUJ/Fkz38Uqz+hQoh61Nvw0n41UP?=
 =?us-ascii?Q?8jIqCB7gbvGN7iLCBItXzXkSNaPHH9aBM4iDeoIa4RIfTMyXpEDv8QX+hJyv?=
 =?us-ascii?Q?eTz5OGfM2Q3mvTpqUD3DYUQN053hYYnaPEPfxfsX7zvtN5RU0Wd4gp8L7Wme?=
 =?us-ascii?Q?gz7ze0XaVhE+n81k1wHv03O541sa8OJ+Cr5WbfY6BZ+8kJ1zPJ/6nfLG2dcm?=
 =?us-ascii?Q?4+oW1y9dS+vnjPPXLAPRTYboH3YUjrfz3smie4h9n5MRyD/misTk+nHkg0ys?=
 =?us-ascii?Q?DkutI0ufqr5X7N/8gVqOafFUTO8SJDPI67uziTUPgDWtWBZX8cqvyZtlqHYm?=
 =?us-ascii?Q?iO3ZTFroCOGdKz6e9rbO2O8d25hKoY+umkohb6GkdSpof2EGXTLgHNZRGAjN?=
 =?us-ascii?Q?cb8nqH+h7zB5zQt7BRDpPIM7P7x33fjitkt5sDZ5G90duvPRMUgCWvCiqlxW?=
 =?us-ascii?Q?4Cli1kh0i68m8g3Zs/5gj+Y9kurcJCk3uClkaTsF5JRb5epG7AQtCXHigTAy?=
 =?us-ascii?Q?c/c/dtTVZ3cpB3WnX04S2q+ggRWvSWPqzB+0ebUoEXCkRKBrfxNN1VvHUxo9?=
 =?us-ascii?Q?aIuXnlt31Iiltjhv5rs5Wh+CqXmzHyMH2XbCZf2UfkEazYfo6HMRP/yRd51Q?=
 =?us-ascii?Q?T0m+nnqF89s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w0hMWvqfWM1rSPcYZgVeRMO7fCfNVX6PSJ+5zM0rdE1h8L34liJFgHZEa2kp?=
 =?us-ascii?Q?1YA//FbGwM+6S/Zt1+w9U1GyCm8tQmMLLL+nBAF0pHvlO+6GavissohliICs?=
 =?us-ascii?Q?70y4UyufiOSMaRZsimavPAom535HX6d9/IUMqLovl6zhD1uSGMtMVjGFFz7G?=
 =?us-ascii?Q?uf7W6uHtpZdX3FmL4HW4gy4msr698e4mpoQA7hy7mUUylt3NAA8+UKyCfHOR?=
 =?us-ascii?Q?DrG+XtW4dr5t+AQkHkrc4QhG4Y+9i22C5lhZcgb2rhv1BnCJY0yw7DEdt2OA?=
 =?us-ascii?Q?4MTnKkF5rZj6toztAgmluHcLzcvTGYAiJHf6vgcYVfZyvx5BAReUGbsSDvN0?=
 =?us-ascii?Q?xdOKQgc5+zkwp3o6QNbbtFy3nvRQyTSq2u+AB398SCi3hKxtoAVMaj1dNpRZ?=
 =?us-ascii?Q?XbVa6OitY78XbC2qGHuEKOih6hf0erl3SKklFmnnUEa0bfov32Ba4LRuXu4f?=
 =?us-ascii?Q?o6zx4rFdb4syuWmRXBPNzoTGY2qfHrDAOr1biCZo/NukULSbwo0JRIt9POUA?=
 =?us-ascii?Q?X6UzoydZwzwY7ao02fAdLJzQt0SyY1fCFKb4P2N9DO2pVL+qQ6qhAhIHuO56?=
 =?us-ascii?Q?aDzBXMPkPVJMx/fpBKWyzlDFTjtneNvebul158yfdgthJtE3MRHrv1Fahn09?=
 =?us-ascii?Q?AcdCgzSadM2/ppazy0R1irKvssx9pEjfDh68/pNNfN58Bt+T7K2JFxVri0KZ?=
 =?us-ascii?Q?V9vOy4QzNNm5O0lUY5Xn76/sBXUicVf3Razei3Ffr5tUYlsZNsZT2FY7CndV?=
 =?us-ascii?Q?HtFw8Mq04BpyJxtDJFeRWAVR2UT45d56NvsBk4yhlXnii+I4JnYCc234q/j6?=
 =?us-ascii?Q?lRdXYVJlu/mN2bs1bkYDUzbzyjO5jAd3eQmKdK00j+kKxk6BoShmoVkXVhAn?=
 =?us-ascii?Q?E065ayGzPWLIIyViiiZwy7gSqnD7RwHDd/fSldS/58n0L4qvmvYE66bK6lA1?=
 =?us-ascii?Q?Y1KxIRRtlrkjpUHV712VvZNJpArfMVmFHJ/hyBs6wqcC5VnNzrP7oedQjpu8?=
 =?us-ascii?Q?DGXrzwcSuQ/dgwrJQzrPh2l5dx6hB6rZub6vtFS0/7IKd2LW3m/qNeDrls3a?=
 =?us-ascii?Q?1ZNDOx1XGS4NBCKyEfLC3xP+WWtcOoyW6DDR1LebV9+K62qbj4gOn2cn+Nos?=
 =?us-ascii?Q?9p8ZiicavFCMfj6ZHhIw+2QXAxSWkGzM2IeRKGmndbQch1wyPiWi+BQiA6D3?=
 =?us-ascii?Q?y/r1a84Mx3GSYv/92MBIICk3hZaQBXRSlF8VGBKakX6WArjNI7Tx5QaV5Mqn?=
 =?us-ascii?Q?VtjXgbKUdgvYWHgj7dG9Z3Jh+AxYaAfyFvBmA4cKg/7mbRo0C4x1AglfQilW?=
 =?us-ascii?Q?ctCIShn6DPcq/XiYDtXGqGi1t1Vyd6ndq0EbtNE7CijTuWKU1YH1jNedZBIm?=
 =?us-ascii?Q?+fA0hZcKMozGNyYhMzE0xUkUKPSX+JqJ/Sm/Ow11tVOfh+aj8AmPpzdVUo24?=
 =?us-ascii?Q?/cVMheAt+BNq2HZgU9ofZjeIKQ79tNYFGGtgX3vNSAn2Jl/2kKuMFLHnxQ08?=
 =?us-ascii?Q?CDCp6zSHTbcHXoAiobHGxJnBZd17y/JI0BchibAnbc4ybowqU2CRDof3HM0H?=
 =?us-ascii?Q?sRa/MBnr7VghtE9RPsE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ff101c-9c1b-4d07-c59d-08ddcec60299
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 17:33:20.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXBuEg3MZrW2g8mUqGUYPaoeVUMhN13Jtri3Y1bOp1I8zGnRJhOgbkUoPPh4h8pC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1

On Wed, Jul 23, 2025 at 02:46:27PM +0000, Pasha Tatashin wrote:
> +/**
> + * struct liveupdate_file_ops - Callbacks for for live-updatable files.
> + * @prepare:       Optional. Saves state for a specific file instance (@file,
> + *                 @arg) before update, potentially returning value via @data.
> + *                 Returns 0 on success, negative errno on failure.
> + * @freeze:        Optional. Performs final actions just before kernel
> + *                 transition, potentially reading/updating the handle via
> + *                 @data.
> + *                 Returns 0 on success, negative errno on failure.
> + * @cancel:        Optional. Cleans up state/resources if update is aborted
> + *                 after prepare/freeze succeeded, using the @data handle (by
> + *                 value) from the successful prepare. Returns void.
> + * @finish:        Optional. Performs final cleanup in the new kernel using the
> + *                 preserved @data handle (by value). Returns void.
> + * @retrieve:      Retrieve the preserved file. Must be called before finish.
> + * @can_preserve:  callback to determine if @file with associated context (@arg)
> + *                 can be preserved by this handler.
> + *                 Return bool (true if preservable, false otherwise).
> + */
> +struct liveupdate_file_ops {
> +	int (*prepare)(struct file *file, void *arg, u64 *data);
> +	int (*freeze)(struct file *file, void *arg, u64 *data);
> +	void (*cancel)(struct file *file, void *arg, u64 data);
> +	void (*finish)(struct file *file, void *arg, u64 data, bool reclaimed);
> +	int (*retrieve)(void *arg, u64 data, struct file **file);
> +	bool (*can_preserve)(struct file *file, void *arg);
> +};

ops structures often have an owner = THIS_MODULE

It wouldn't hurt to add it here too, and some appropriate module_get's
though I didn't try to figure what happens if userspace races a module
unload with other luo operations.

> +
> +/**
> + * struct liveupdate_file_handler - Represents a handler for a live-updatable
> + * file type.
> + * @ops:           Callback functions
> + * @compatible:    The compatibility string (e.g., "memfd-v1", "vfiofd-v1")
> + *                 that uniquely identifies the file type this handler supports.
> + *                 This is matched against the compatible string associated with
> + *                 individual &struct liveupdate_file instances.
> + * @arg:           An opaque pointer to implementation-specific context data
> + *                 associated with this file handler registration.

Why? This is not the normal way, if you want context data then
allocate a struct driver_liveupdate_file_handler and embed a normal
struct liveupdate_file_handler inside it, then use container_of.

> +	fdt_for_each_subnode(file_node_offset, luo_file_fdt_in, 0) {
> +		bool handler_found = false;
> +		u64 token;
> +
> +		node_name = fdt_get_name(luo_file_fdt_in, file_node_offset,
> +					 NULL);
> +		if (!node_name) {
> +			panic("FDT subnode at offset %d: Cannot get name\n",
> +			      file_node_offset);

I think this approach will raise lots of questions..

I'd introduce a new function "luo_deserialize_failure" that does panic
internally.

Only called by places that are parsing the FDT & related but run into
trouble that cannot be savely recovered from.

Jason


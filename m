Return-Path: <linux-fsdevel+bounces-63615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63366BC67AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 21:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099A81891209
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 19:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0C2652A6;
	Wed,  8 Oct 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L5XX8XM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F521ADCB;
	Wed,  8 Oct 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759952165; cv=fail; b=JDqNvOI4d/D4O229ICI9yHEt8dX0pXjwA/7g3sFh2mbXWN1LgERlI6HInsQfLYmNqda7Z6DFmKsjM9sFJu2Vfbdy5UzEy3YnjVkAQYh5iy33tfY4rgX3k+MiQalIWq4/P7uWeMFlMZEJYmYrMPCzlr2hhWfFkM376LdojU1oPVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759952165; c=relaxed/simple;
	bh=k+lgYAibXwQIpvIIm3ukGnNLCz5PmNROJeh8IVOxdoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gs+Pd9T6tNWHjmpopQ2GWmqyQ25U/ciuXOel8XALNtX3KIRCnHNop3Z4bdMXi0aQ17yorSpx615gpPNziUnDWbaliU6Q7zO7sV52zCVpuour6KnbF5UIH5IXYarFS4ZBzMvZexRkUA/EM15rSVl2ik2dngZBgg3cq5TR9nFa44Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L5XX8XM7; arc=fail smtp.client-ip=40.107.209.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUiz4nBG4WOkhosJVA3J3BQa/PH11kVhhNI1ZYfjc35WUz0wXhNES0yPAsjEUCTVr+HXr2mEGV5ujtmRmhr630JU9tPzf0An88RWd5U6+zsIwxrJZ65T4xDokVIngCmiRTxyQ1wbMXPKc/dJQzjsRtAEn1QMr5MmxF27YDTho1K4bU+HPfs5xSOjcLd96xysRava3dvHj0gkJ7cxTaSAd9F87udJpi8zWFV1N3FDea/kFuFKEqGnAvmA7ZiXFas7drZ9zE/aKme4q4O7EVoUyDEf72c7fKfOz5V3uOqDPVZwT3g0DcyU6RACO/LwMfZPuAU0gC7hfbelwjJwDmOZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+lgYAibXwQIpvIIm3ukGnNLCz5PmNROJeh8IVOxdoU=;
 b=TFDYcmS0Ff/yK+y98VVLNB99pIQYn1hfYpk8Qu0y0BHEEHeFgZCzSN8jVCbwovGBJm45xFBQv/AOndCn8fOWdXBVeCCtnV7jtpBDXAB0ljgCCrkC66iIUauTuoO2MXFvvda1WImM3+TTFIgD38CNT6VK6ue9gZbmK6sCe9SGR90pFpKshBxoUtKpc9MqmMUYQoz4LJUbgEQjpIQ+q25melZmxpb7Ho53dEAQbz+2K+OhHSSgauGnOW9pvQPjq4+uebsPwbr37uRVnhhII47FqkP+xN/8S9W0iBwZ4TZJwIbUMD2pKFYWwtoBq0HcZ+cJ5BcCG7TqNbAFQVcictS7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+lgYAibXwQIpvIIm3ukGnNLCz5PmNROJeh8IVOxdoU=;
 b=L5XX8XM7EslepGZ1IF/wZdFuDj0PmoN4RyyZKvEYYaRlPH2Rpyxtt7oM5bADnb3eCBlifuPqqu2GUNvE6BmSnlZhst4PMrrssYvZzxuojEQLPeowr4nfJ4NohbogUb+0D0MwuOaiCCtfTsRkC08tKSrrwLA6iLI5+2CePvogk2VsSr/OJ38kZRXIQPjiFeF1Pw7q7kD0WJ3/iXEXm8VdmsdvwvSiUU9V+HtxKuG84HiGavEO7YttsNIV9p8KGsqbzkK4rXKOtjhtaAp54VilhEn39sIFw0bHfyq9IUQu9lRT3iFYADzgdoK/oqr4pRKJta9iDA6FxjX0Zb8KUzu4cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 19:35:54 +0000
Received: from BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f]) by BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 19:35:54 +0000
Date: Wed, 8 Oct 2025 16:35:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
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
	witu@nvidia.com, hughd@google.com, chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
Message-ID: <20251008193551.GA3839422@nvidia.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhSP=ugnSJOHPGmTUPGh82wt+qnaqZAqo99EfhF-XHD5Sg@mail.gmail.com>
 <CA+CK2bAG+YAS7oSpdrZYDK0LU2mhfRuj2qTJtT-Hn8FLUbt=Dw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAG+YAS7oSpdrZYDK0LU2mhfRuj2qTJtT-Hn8FLUbt=Dw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ddbe27-ce71-463e-423b-08de06a1e550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QMql/sVp5aeTE2DQRW1hBeguhp9Z0CxkvSr94WFxRN7nqmdaTPWx/VIf41o+?=
 =?us-ascii?Q?CgiVcppLyBz2oPjR/R0sDu2bgBIIMcJ/j57B1gYvHAoOxHesEtAu3dQMpyAx?=
 =?us-ascii?Q?fqYvl1E1PLqqhsgx5F3VrV6eTxgt4sKp/v2Xzj9HldDp45I8quV466af/da0?=
 =?us-ascii?Q?eW7Uw1vjjGPTMnH/h8hA294+m4DBYhpTVpD6zjSLIzX/9laRgbqc18i5xdGo?=
 =?us-ascii?Q?CHjwkvnQgoNkoR7oh3pyyAlZotyaSd8G0trBdxx4fkDh095DQ5fEJu6hz8H+?=
 =?us-ascii?Q?tsNw43DLOyT3Evks/xBMM14kn0TCv9HtJbT67AAnN/j7Yf16hUsl+qrY9Adz?=
 =?us-ascii?Q?JCgYlMJMDDEmwKjGB1xSMintryWc6dUrNPD2K7xhSaxRMEV+bybsSmI0X59e?=
 =?us-ascii?Q?x6Za04hWM4pxvmFwSQPNvQzNQhY9uGNI6lRqaU6vjzJ9pieX4SG7lUB1IQgC?=
 =?us-ascii?Q?ueYyamQ7k8+k+GTKOL8cxbzW0GfOo4VXn+ZWs/w09WqLdnZu50+K+4RpANZt?=
 =?us-ascii?Q?QRG8LqsFg9Y91fz7Tz/Soof3BtUfKmOw6KJGfK7iofir0h7cnFIsxJGTXnJm?=
 =?us-ascii?Q?hTgIQ2uADDAKVGvv7+V9JtqHCm3nxnZ0iG3k2txQlK95ygxWyRomg/X9lj56?=
 =?us-ascii?Q?wVp6tTyIyfkUtT/eDWTZJ54dmTBDfvs4XM+vWUy2va22NrZkSgKGo5ruPlGH?=
 =?us-ascii?Q?GC27ZKqVNgOtBfCM8Won7cqlpRwFkbv7cq4WMCvYcbJQHvU1qx36xykEacXy?=
 =?us-ascii?Q?9cc4AQBB4BCdshZR5/9KOImIQgTWMNjtlLyIxRbD2CMs0U/MtYveZsBN8cRx?=
 =?us-ascii?Q?zS5txV4RlZUSgvwAnjTYiQg32JvC3s041zwemPzfJwxAHIVWwvPEG6fvzFj9?=
 =?us-ascii?Q?aqQ//+3SyKNZrzN20CxtnxiK9PC6/TFyMk05HW94qwCw6J4IJwU0ov45daPz?=
 =?us-ascii?Q?gRvlIKKdY7kaZ1vYdC0f5cb+RvFdGOmC4gV0Bimt1IJd6Ul686rIHemQ6Oso?=
 =?us-ascii?Q?JSDDUBvcLwaxuaZ27XO4WLVDrTHPlXsRz5/xvGL8kheczcZtd9w4/6Fa2BxV?=
 =?us-ascii?Q?kZjwPuXJ1OrBhIzNYLRPqzUovkNmdBm1loqnFfmOp0ZfJRoK+ntljh4mqUW4?=
 =?us-ascii?Q?3IoSZ7z8UWUSgf1hNc6ExjoFP0YUacXyxpUa1a2CgWo3BPxc5c5jwqV+qyEb?=
 =?us-ascii?Q?PgVWrpIY6AsTG8jxv7lMF9FBDZ3egnSRRGw3QqWErgg4RyZBZA8VNF7gy2PV?=
 =?us-ascii?Q?OUVAn3W7c/0542I99G1DHKX7oBsa9UH30AOLLIx23LCLhPECs+XUtNXA2xa9?=
 =?us-ascii?Q?d9INEsJzpYwm2PRvuFl+vQr6HnT8ImewtiOWktCqdLQBeQVXdNOheUP02sxr?=
 =?us-ascii?Q?f3DGjDwlMS61ItUIwmruGUmh8/Aj4B8JOht7Rlt09Sxxxry7UMPtBW93khMQ?=
 =?us-ascii?Q?mDJAozhft8eCc9AusgMtMPYmCxPpEydF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B31ShBGf8lJA+QAyPOfJBeeJdUtiiskST0AmrGJXnY9mDUcxLHZ0kcgGYFRj?=
 =?us-ascii?Q?cY3KNiQdmj30BInKuZA8ppy7z00KEq86aV1M3NmXa0GuuCXnPtGvs5AUg7tJ?=
 =?us-ascii?Q?aqlbXF9COZTguXCL1a4x+t6t6F6czdMtkicNcrznNFSVayxKVpH39Wnkii3a?=
 =?us-ascii?Q?9mdpMljk3hYxx2uX6+bT5akTFtk63Vl9zhtHITSPlld5b9Lk6EaYEFWL10wx?=
 =?us-ascii?Q?guw98rlMB1WX7A41wK9phrCmQhOO8DwR6+z+N8pHe1xLAT7enanW17PyWeth?=
 =?us-ascii?Q?tOQfNuPz2YaoZuP4lfNZCtDC1ijcm8ARLIpwAo0ssiExlzYckHcH7NYy2AIE?=
 =?us-ascii?Q?IMLCXQjnsNUFe4cB5y9xTW8IqnwQb6MZWtUYyvwGbW9Q5QXiz9ESwXcURnfb?=
 =?us-ascii?Q?GRUw2Ca1h4idkaE3hNdxVlZdTKwEou1SEblNgwvwWUO3Cxz51Vvs0R79haCp?=
 =?us-ascii?Q?QvOsZWuIB058VP+y+S159GGvU2yUFC9KfgzOvBpHZrdW77BUyt3xr1nC6Hpf?=
 =?us-ascii?Q?hB09fOOx89TGp1Q+0ki0QWdGqEFK37tzbcYQSVH7jiQy63E0fRn+5LvHFfHY?=
 =?us-ascii?Q?fQgliqxR044HytFdokayn6iG7Iv0J85ChxxC01qtC7lMu8wWU2yJfW2FsmXb?=
 =?us-ascii?Q?TZrd5e5+ndR8wzHrPTbhCj9GcCGyzYU9jQgSIGS2F35HEsJhifskTvoE2K4K?=
 =?us-ascii?Q?iveipCGJ8Cv8mrxcYt2f7C+u/EAcUZ89f694Hm/th4xEsZItyS7A/J3Id+P6?=
 =?us-ascii?Q?YJ+OdyNldbHK/rV6UXMpXH/aNsbqGjVDC1/7VY2CXguCTuvzFULC/b39O81T?=
 =?us-ascii?Q?2UKAmL6XFDN+aYJguOFUMkPZdGuKjw3cTDCOvZp6fQ1M9rSaX/4wHs+acCU1?=
 =?us-ascii?Q?VqXOUT/47wnOopDn9Eq1lsL2SPLdtUuBLcAek3T5sn4BbOw8S2woC09MWMTY?=
 =?us-ascii?Q?gD5OwpfPfNppfW0erI6AuXggH7pxydI2AAxSi/PvGBLfAM1uQrokaEeYp/4f?=
 =?us-ascii?Q?sH0rETOdGwPPEynE3nt3vsGmXlQMtyqxFDNWGVIZx0MTt39QkZrGTj7Q1FgS?=
 =?us-ascii?Q?VYoCi3ObFBFf8P8+wBDK8Ar1b5GDZ0DoUTRRlQeXSoypPoCiOOoHZZvqYdDE?=
 =?us-ascii?Q?U2+PJ1d5DSnCjPobnc9TF4OvVkz//9BDUDx+fiDqBZB69WORPcBSazGee8ls?=
 =?us-ascii?Q?bNhgkWSE6vdFW3METY6ryQO4rNhk8eqr53GHKM1rvzgTLqcCgsEcVwOGJyvl?=
 =?us-ascii?Q?57pdPSg/QoxQIXyNef1xI3ViIF59wfZI2LC5gWoSCx22hIMXM7guTjrXANVg?=
 =?us-ascii?Q?ploqT2EThmogfZMc8S/lS+uZS44ju7BdD7z9jd0v1iPQhx0f8wp2vl8K9h69?=
 =?us-ascii?Q?7iIJXNzn7mS50UBXNKw7zP8oDlaCjIUxvUKybqrPy21a+tol7TjQRGy32H3+?=
 =?us-ascii?Q?bzytdVVTMPaxpwqCfMUq80J5A07GLK2h4iVi3eoMOs3fFauh74ilINcpoew7?=
 =?us-ascii?Q?vd6qx5naQyXtfCbmXPKEqE41f7FCqPm3igiHPJi1XxCq9VMPmjaWdhVqqq3O?=
 =?us-ascii?Q?GWrrgHt3MqBUpMAIXpENNxiks83hxivrf2KArTSn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ddbe27-ce71-463e-423b-08de06a1e550
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:35:54.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyDJv+Wz4VQrLU6LfZy81J8uYpz6JDea1aiVAR6pNbosWOLDCSCT/oUc2ao3DdtD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669

On Wed, Oct 08, 2025 at 12:40:34PM -0400, Pasha Tatashin wrote:
> 1. Ordered Un-preservation
> The un-preservation of file descriptors must also be ordered and must
> occur in the reverse order of preservation. For example, if a user
> preserves a memfd first and then an iommufd that depends on it, the
> iommufd must be un-preserved before the memfd when the session is
> closed or the FDs are explicitly un-preserved.

Why?

I imagined the first to unpreserve would restore the struct file * -
that would satisfy the order.

The ioctl version that is to get back a FD would recover the struct
file and fd_install it.

Meaning preserve side is retaining a database of labels to restored
struct file *'s.

As discussed unpreserve a FD does not imply unfreeze, which is the
opposite of how preserver works.

> 2. New API to Check Preservation Status
> A new LUO API will be needed to check if a struct file is already
> preserved within a session. This is needed for dependency validation.
> The proposed function would look like this:

This doesn't seem right, the API should be more like 'luo get
serialization handle for this file *'

If it hasn't been preserved then there won't be a handle, otherwise it
should return something to allow the unpreserving side to recover this
struct file *.

That's the general use case at least, there may be some narrower use
cases where the preserver throws away the handle.

Jason


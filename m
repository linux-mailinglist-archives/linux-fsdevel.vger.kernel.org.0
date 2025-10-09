Return-Path: <linux-fsdevel+bounces-63677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE84BCA676
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEECE188B54D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E03246793;
	Thu,  9 Oct 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6WLgUnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A12EEC0;
	Thu,  9 Oct 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031565; cv=fail; b=g0q4jSUoeHDhNxd5QqgM2s36yAd35p8vcaikxiyuVfJE2fk1Ewi/7pTZbc8J2qimMAhl4TO8EyUJCTRZeQq6+N560RPWhqh7HBX+la7VwcqbpvGYHGA58ZC5n2jG5rip0wlvA9vA98xvirTQhLK95mHUInkzb4CQ5XaNWNtvVR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031565; c=relaxed/simple;
	bh=T8EnxJf+ETU3sl0JHD58WTjQOFVGAg+ZZh5eENZ/yG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pKw/Pv0eqVBMwikEbw66TCMkuMsrXIVRlrgDLdOV1g2meYHD5Y5zGfhBnJTzJjWx+Uk1oh5cTJe/0LEgDk/WY7xsv8bvE6o3suVu0rsOsEBanOzDY8OLpLy/yWkwFoU8LAQhfubp9aVl9h3ifPVzTE8WquVnHW1Z16a0uxHEDWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6WLgUnj; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb+V3yx0nWgBG2iRmUQn8OjX9DJECIuh5pLuye1WOFUxxb4CtAf/Iv96IUlFVNXAFIFpmuqlBd5jLrHxzwr9GBSfkkZ8ZTaL0/kDfmb0BonpR8lgzbcylvxCu47BX7GFW+xGlfZrytF/Z2EMfK2obhAxElPoSio4Q+1PAagvSQnkSd3MjW3rUI+0vg3B2CwoT+JlPnsgrN5v59M52f9gVytkyUgx1we0tp7BpqNZEmUQqjY/wIlyLJYF4B9IG/bmsN70ni//zZOhdihaNaMNwB1XfljwXG4l8tjz6MxlZxxZ23RqQfDL/PJydfGh8r5mJUY56B3uYqY/f4Rt7r/8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gI7fPSVGLQ0w0ltaLWf5+LezXod627CUsMz5uAp++zg=;
 b=OgwXUgaQpQpvpa3LO3evpp710YPgPFcTWTvv0Z0JJQGedNP0QadDmirXWRdjafDBv468WEyRJgbRGfxlJdN4Fwk+BpBz6/HTsLyhJW9iGy6LuKvWiKFNV70mhfvp+MR/71UdNQaGVHFKXGIc0Q1bpPEN4w2J4VFAV33SW5KcaVPdSZUW1deBACvIajy+FIvJ1QuvdR2iga5bKdAEOK8zEwwVEBQaHlgzM977rlNqszHiBAaHBTkODwHAje26+iDqQhwt8DjTdPBhSZuAR4n5n8CtR+bdgsbSMlUON3YhAjoaRfLnbRyJJ/U3I3XWKeMwNYAL7Nj7qUl3GJEbWg2U1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gI7fPSVGLQ0w0ltaLWf5+LezXod627CUsMz5uAp++zg=;
 b=D6WLgUnjBAIuKlH0o9Ok2CWINjDZe5j4Ei7JGBJ45aOrO2Xzbq+Rz2rWVfIrFK9X44sZGSyOa8QFQq4lvD78q2qsbDXFIZKwSz4//zSDARFK4aPrx8pCmWgG1t/Wd9L6lhJvCvrjeKf/3ZN0E4fTC08FXp1cnAV9Go3Qp6W35v3msO4zJSmobY1q8i1/dAcr9QVVbth35v0E+UVaNrp8wBkiPLxKUIfufGp9wiDhxnGVboZW7Ip4usBvoKxw9P7CzMI1xtz8Xt8skqf+6gl301FfNABi/TonTUnYNoumlxOEOqWixdotEB9Uy6qH2db02YQ70w0Y3F4OH/5/o6DEdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 17:39:20 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 17:39:20 +0000
Date: Thu, 9 Oct 2025 14:39:14 -0300
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
Message-ID: <20251009173914.GA3899236@nvidia.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhSP=ugnSJOHPGmTUPGh82wt+qnaqZAqo99EfhF-XHD5Sg@mail.gmail.com>
 <CA+CK2bAG+YAS7oSpdrZYDK0LU2mhfRuj2qTJtT-Hn8FLUbt=Dw@mail.gmail.com>
 <20251008193551.GA3839422@nvidia.com>
 <CA+CK2bDs1JsRCNFXkdUhdu5V-KMJXVTgETSHPvCtXKjkpD79Sw@mail.gmail.com>
 <20251009144822.GD3839422@nvidia.com>
 <CA+CK2bC_m5GRxCa1szw1v24Ssq8EnCWp4e985RJ5RRCdhztQWg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bC_m5GRxCa1szw1v24Ssq8EnCWp4e985RJ5RRCdhztQWg@mail.gmail.com>
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcad7f6-99fe-4bac-a050-08de075ac6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWRK6Rtr6SumTF+XeIgH6X8E9N8m9ydMOcytzmqzO3HYmGHW9R3fOVJgFHC4?=
 =?us-ascii?Q?sB1KX05uWKK7KDBLKA9rDiPck4AJAeXcRXX5rdZtTKzeeB2NzJRq+pAgM+vw?=
 =?us-ascii?Q?0LCvKrzh8yzxIATatlbfyjGrhpqm8OaWYPiNWmeAeWF4SN6Y+bbjrwOCPmAU?=
 =?us-ascii?Q?yyLbONXMtQwY2EGe0AmuCwbDoDZQ8h28J1HRNGtPuNZb8QYLQ0hEtpbIx3sR?=
 =?us-ascii?Q?JNnt3SO2sn9Bz2OZG1T3kSkEgYPCMw0MUxDalkjYeBZpcWmM9iTM0HFDl4FR?=
 =?us-ascii?Q?2InWmJdE1wzPUUPtrcGFghagx2jdEofi3LNLprDhzmpLTIxscWLlzgAwmzrB?=
 =?us-ascii?Q?11U4FgMzoa5bWvgWE1cRaH//nFsam8ByFIrcPkD2+2jiVD3B6WZbF7OiD0OR?=
 =?us-ascii?Q?nW7y66bnQ/irVVqsWIPWN5fCYZWul7PsqAgWyjj1X0DRzf1pwkdVLvaPSJz/?=
 =?us-ascii?Q?6vD13wRC2CY3Ak7odxMaJBqBd/GpH58K1PbiWVV7w08DiQ/bZOLyMRNrxMZt?=
 =?us-ascii?Q?F4477wRT1vjuIP45sDIDBj8vWKY2RTUDcEcghcf6RkWDi1BR8RwcOdNELkGI?=
 =?us-ascii?Q?Z8a9/d5mGrHcjUZxScjk6l5LPrK8bLqPec3DV9XXwbpydq+KnWEmvwVZlWf6?=
 =?us-ascii?Q?8ayL9hzArSwAftYHt2k7o3rt/t66TpH4eU9Ijz4UD5FiRptM9gnLihAvTL3p?=
 =?us-ascii?Q?pz+qXaQx8um4+PlZifHR2MtZX4dgbv3UkHy58LaO2f8ISJFTGtODvXYNKmcn?=
 =?us-ascii?Q?XmavBnkqhA1Bu+rsQkh+/h4i/PGozen+vDmIs1cZSwlqWr/Wn5sEREPRUIhf?=
 =?us-ascii?Q?2ft3CIgizb0yTIlEOAtRMJG7FMBpkBE8TtNELpKjYSR3WwaXXCIxuKDPZfdq?=
 =?us-ascii?Q?rHhhGJVxL0H6dlLF2Wvz/k4S7+4E4FxeVWiwPLoimhbPMKMq8pcW9uG0/I3c?=
 =?us-ascii?Q?eDWvmtJd+VQdHCDeK7Tzwm5gXveAXrAJEVzOH7fL4LevRHcd9n77KNMn2P8E?=
 =?us-ascii?Q?ZUVELcWDv3OR1OcyPmd+iQUKfxr+a7PfSHiGOmcDF68Pu8eXQ6xLSi/fGVS8?=
 =?us-ascii?Q?zPqcwGDj7x810l7Qpw3AavVXcCez2HKEN4ew/RUSoD8SgePN5kNUEe1cCRR0?=
 =?us-ascii?Q?0fITsFzW6O+jZTiGC+fBWWkRxVUgLpc+CqRwUhpSpoO/TjuORf8MJ5zknrwM?=
 =?us-ascii?Q?XRMBsCfZVdieGBdQrqTRhrx4RiR79RET0ZltwRzC2TT4chutxUTv6+GlTxfv?=
 =?us-ascii?Q?9+JAhb9BgbzaGLJ4SiTF3opRxx5GLbAM6WPuEVw1qq6E8OkRMexJ5qMsNrAX?=
 =?us-ascii?Q?nqQ4j+pHCZ8umGRTbDrL3ORm0VOMsA52krmVcQgrh+3kHLnYU5PUdenDwhmH?=
 =?us-ascii?Q?6T/vftw0nc7P/TpnSFYoOD1kk2vK6AyM4nRjTsWSL2MRn4hWxHlRQRuDFdzY?=
 =?us-ascii?Q?hVmxyAELSFmbLARMFuK1pQZHPBWO7TWA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F6FgsEMhKmqAXrHWenSL64xpGXhrC5ReonnCN3bn+bv9GwPK6Zmm+JfCLMpg?=
 =?us-ascii?Q?XdtWPn4KCBNysVBRsb5B8eugYwDjr9zQWb4XL3bG6RTbuZKB1v41R37GK7VT?=
 =?us-ascii?Q?s6t/m72RVjEZFD0YAzVSMqHrvZRIP+OfmkynklFCyGewltKj/nJ4YDEQpqBX?=
 =?us-ascii?Q?GSBSOurNZGX5ZioRbZVDrG/dkBQ3XKLkXtl1evy7J4VmT4BpwhTty+SfsBAJ?=
 =?us-ascii?Q?IPdr29UNh5Wh9Bc4BvbadpdkKuIV+hglfML7CItc9ECVoIVmTpyqc2jl/hTg?=
 =?us-ascii?Q?ufMVPupcMsx7LTGbHT9sx+B0UI8t5R6l/yZG58zSo6ZKWkQfZuCHCIaHKtB2?=
 =?us-ascii?Q?gCycmq7998HYGcn6t56Ne4vbQaBNddQJAdnjfew+3yIePRZIlV4sKgwadNG9?=
 =?us-ascii?Q?ckRnVi6dlpwzFsXXw53nEt9RZMfVSiUi+b6/enFRztRnJzyqZzyJGod+t8+V?=
 =?us-ascii?Q?i3ES/dULcD8HkNCGtJwRum5RqSzEY/JOjFkrVv+xltcllYQ7BH3jVEEbamq6?=
 =?us-ascii?Q?PoOVM70iQm6wLwOdY3AsbI/0z1yZjEEjYNQWH+CJaX2KHCBXWBNZDohhyYfN?=
 =?us-ascii?Q?RnxxEvSDpJZxyjv8HB1PbFiuMxO+QlVXhsBsluB0trChtI/zPnsPoLLn9VME?=
 =?us-ascii?Q?Awe4mTHdm6UFv89NIaj3r9TXkOCFKMiL21u1Ch8+RoUproB3s/rqLX50lx0H?=
 =?us-ascii?Q?w/K9tPEJC66RYrV9tbHYRFXPXZMCxyvDHQqONOPq4c81iMv9spe9dMdIEMXW?=
 =?us-ascii?Q?6pcg7TY1L+CUXsEoVg8807EB4MqwPN63PjElwgd4IprRthhm5w2PZfasgYu+?=
 =?us-ascii?Q?4GTno6YriQw8nxU15TTaT+J7hRAiLAwT8m14nt0RDatD9dunZ22YS476z5qu?=
 =?us-ascii?Q?3sz5Gwhfq3IOzmB8ZAiyZXGkBHt5nS48Ps25I3eVKWU6UPfbTa0Cb2Z4lDta?=
 =?us-ascii?Q?ZxBalc4sAOffzjtcF37Qd6BA9b0Rn2uPyaanacfe3t27KA/vTs8hxcJVScaM?=
 =?us-ascii?Q?OFwZcSaDeBXYtfK1Pi/M07lTBhdKKME3ZKG/YPObo9ll4teFEZR/LfbWX/SB?=
 =?us-ascii?Q?98RTTC7aJAffFEOumecfBIiC//SLswxp4GKXxBEIqQjd3+4uOJQwMJIzdSJ6?=
 =?us-ascii?Q?RJjilDP3m5hAo+OhMDq7yoVqkdutVad1RwrKN3HhCz3rIHNF0vhJQEbcRmw+?=
 =?us-ascii?Q?vDHvsOOQ4BUQu613XLdvKgSyiuVllrAUuFEGmX2c9Xz9I4BL8bu2qhaO6Chh?=
 =?us-ascii?Q?9YHDfxmn1l2gHEsvfS9K/U6AcSi2hMiSIEYa4HDrWisAFxmKdX/DAy52qJSB?=
 =?us-ascii?Q?/TeWUlxA4gtXZJdqrDa/njUGh72u4rGpxCMlFI1E6nFLi/260iKcpCXolUDV?=
 =?us-ascii?Q?rIsRXqPusMAOQD+kEqAT0S7aadOx971PSOH0HLiX+kYSFd7RrRA+zelF1FU8?=
 =?us-ascii?Q?eaMbJOixqNFvO0NdfrQ19gJ5cIPIqIInIgrrj/MkynLOr7KwkuCvxm9xAy8y?=
 =?us-ascii?Q?hegQnlkLzuiNbLwnE8Cv+ZDNc0/u4uyATswd6mTVffEiI8/55dcvgOY1dAUT?=
 =?us-ascii?Q?C5D1kFsdUiwjGyihhSwvSvPhw6i/f4oMEH/3X1yC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcad7f6-99fe-4bac-a050-08de075ac6e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 17:39:20.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDFLZiaq/t6nWEa81FU+0TH3ISZj9a3m27V7WFt0Xpjge5eFqEUmQluSAcph3YhO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

On Thu, Oct 09, 2025 at 11:01:25AM -0400, Pasha Tatashin wrote:
> In this case we can enforce strict
> ordering during retrieval. If "struct file" can be retrieved by
> anything within the kernel, then that could be any kernel process
> during boot, meaning that charging is not going to be properly applied
> when kernel allocations are performed.

Ugh, yeah, OK that's irritating and might burn us, but we did decide
on that strategy.

> > I would argue it should always cause a preservation...
> >
> > But this is still backwards, what we need is something like
> >
> > liveupdate_preserve_file(session, file, &token);
> > my_preserve_blob.file_token = token
> 
> We cannot do that, the user should have already preserved that file
> and provided us with a token to use, if that file was not preserved by
> the user it is a bug. With this proposal, we would have to generate a
> token, and it was argued that the kernel should not do that.

The token is the label used as ABI across the kexec. Each entity doing
a serialization can operate it's labels however it needs.

Here I am suggeting that when a kernel entity goes to record a struct
file in a kernel ABI structure it can get a kernel generated token for
it.

This is a different token name space than the user provided tokens
through the ioctl. A single struct file may have many entities
serializing it and possibly many tokens.

Jason


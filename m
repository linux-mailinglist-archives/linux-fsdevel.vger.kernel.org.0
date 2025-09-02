Return-Path: <linux-fsdevel+bounces-59989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC327B405CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988B01893726
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D5630C604;
	Tue,  2 Sep 2025 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AxjI/3KN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A3261593;
	Tue,  2 Sep 2025 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820934; cv=fail; b=EdAhNd8cwJuTpTxVzJnkaDF1jn5cE43dpNs381VHrO56gGsrusTZHJmCsLQR7EibwAUa7tF0m3p6nY5KOduISoNGVhiIZ1EIz1MnZtd9fL3PrdJi28J6EOwNrIxOOspA4KXoLxmNltFQozBF0ffTIHNqHQGKJrr9gGatuFumT0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820934; c=relaxed/simple;
	bh=SpbtVrjP01H3sB4w93s1l0xvriR2BukshR26Xtl65pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HO/tLQbbjcu7v+HOsRw8byxFF8vHpmH7DoTDrvnLTJGFE28opvMCGKcRCY07VLWMj3+2MP09dHczyIQ28RHiYRXtAIUSApwzSmvRrWYjCqehfQ0djU5a7c3R0CLq/kqU+LcSGKcCC90z2yaYz2sHtbgobFFlDyAyM9HZ2urSWUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AxjI/3KN; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZm3v0uJoXYs1ESOcj57rAZW3TpsUObwmaPUltrt5V1nf1ME+XB2NjQ5yUa1nlfQ47Pwu8sCzLjie0IokRI9y+aNbOGUSGJWZ0QhXgxGq3NL/tlgOvr95ZJmr/a3C6CkUdmADWb3kWu14SHpv59d/DaqKaCpbIJ+mlmGjIXUL8WRF9/z+LAUUAy+ueISsg2jbXsjTmXwzZ+CS5jF97l7VhohAiU3RRFjCrmPj5lX60msG+n6HuhlyBH5t6EQcBhwLdacrRGoUiZGFYTWDP1WIQTfVyYBbW0b83FMMspGw7NXpkoTa0JmEQtaeEOSmWt2QFYl2vv70O8XmJTbq1y/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdBvEc7GQRcvyLDLWtTW8aXd9jBRc0uKyJxw5KIjyGQ=;
 b=aKP6LvlrO8Y6lwNhdENuNr7rExulSgBHwZWFKmPOVj+vkbstR+swu7eEZ/i4zyguIBv9GwUiLprlrcx+DkeWLcnST2oIVG0/Sr5PHJ1PAUo/dy4wbCzrK+P7S5OyBO9XUMaNZE6FDLht8DOMjq+9rJhLCpPdARd40I3ixZfRXvRWedauFOYaG02xrjGFLyS7CSAtuckRjKNf7GG6gmGvue1GWbOMwv4hIIeOfd+ruJFGhoZ9TvIeAscgGs8a2c+6wqi4iCEhF+aj49lXgtzhQrsYCFiXPS4cuSvUgezHRWjC3CkLUuScURf51TXGvZXh7782EqIgwSnqf/bIy5dZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdBvEc7GQRcvyLDLWtTW8aXd9jBRc0uKyJxw5KIjyGQ=;
 b=AxjI/3KN6/HYNXL650ArOwmVvmSo6yI/UTlLfer46j9qH+I/UMO7gjlSdk74OcdyC4MPLOraRxGwFY7L6jANPoHwrFYgRpNB4RaKR2wKdqQc7gt8YAzM3qxXbPQwL7YLlGYQBp06CQqiuVciALj/Zo+DcRWR0QYnSJGNMs1j8BipYuYgaSX33GRTuCT5GcEDQh6pVVcIk3ejQOUlmdRCA1tpng9ZGQLDoFFIrN8uxp7eyd+PP5/tPH4Tfn4y+Z0dF/5YMzO2eOntc/egChCwtbZ9JIFc/sGu4IbeNoEGGmElKfZyCNs/eTgnT3dqwReMO8uzGEWWElLtHNqjw/6zZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:48:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:48:48 +0000
Date: Tue, 2 Sep 2025 10:48:46 -0300
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
Message-ID: <20250902134846.GN186519@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <mafs0bjo0yffo.fsf@kernel.org>
 <20250828124320.GB7333@nvidia.com>
 <mafs0h5xmw12a.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0h5xmw12a.fsf@kernel.org>
X-ClientProxiedBy: YT4PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e58965-b691-476b-7300-08ddea277121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?abdIctlk1fDKbFTAVuhfyjn24jVsQtdLNYFAxgOTD/e7ql4+94Rl5pqFxOtw?=
 =?us-ascii?Q?ik++dyxFsLc3PsrK03O/eqQt8HoFkALCLrKS2i/Yvoe3k2g3O6Bq17jacf5S?=
 =?us-ascii?Q?cgG1qEcX8u9AxRHr2oeF7Q/bQazc14/s/NpI36ajwjhR75HWsdkSPgDUn+g8?=
 =?us-ascii?Q?2Toqfld8MPvZzZQXCL+A/bxxA0JFXGGMLn1JO0Iaes6tYogrgsjx3YYIrdhi?=
 =?us-ascii?Q?nIueAaOVvhXVyMD5WVj1yWUskxp5njmpq0CMdSv/d9MkZNUqfXcxlloNoH6G?=
 =?us-ascii?Q?kGqC0d30vTviQ6/AL+IOWyZRhcCz5FBsSBt+rt8RO/PiQvsYG7f+5biAFrLD?=
 =?us-ascii?Q?pSaBQm3r2ob/Zibi0Y9w+wli+j1RPTRUcQTaeQX9L6Jh1ErjUNb1KDKjjiEt?=
 =?us-ascii?Q?LuGa3O6+q029kYgJKe1x3f6EJZLz3qnBJsGOeUeVvshVnHrct24zJ90W5ig/?=
 =?us-ascii?Q?7quhLR8Oqtne2SjD8F22kEP9SDUMnfYm9c9b1IAOlY3SdmnpZoez4U2ZpgPS?=
 =?us-ascii?Q?nsf5Y0TnzZ9FOhS+Pvc9rHTkCLLs7lN4Zao59Yxm6pn4y6rRuntbzwwSEQsZ?=
 =?us-ascii?Q?6B3Xx1h/XnHwpi9QJiXTQU7J9nGVs9uMhy8iiFsCkg1A7/rw8OEn8TKM3AN7?=
 =?us-ascii?Q?A5udUlX6UrBC3igDdAML+zHODjmVo1cmWKHjC3a3hzFjsjf/4IPFNBcpt7HU?=
 =?us-ascii?Q?KIPRqIptRZiaSKsb2HaQNoVnf06+Ux11+P0woEGxkZrpGAu1f+1BHCxmQOYf?=
 =?us-ascii?Q?3dmbXtMD9D0/LGnUzPcpBNDgAnRPPFUbN1yMw3PFwCzWxsMHs9y3IGSuWx5D?=
 =?us-ascii?Q?AybJuDxYiMx9h5qD2xAw2pjlD8x1XQN+GJ3/OKbVl6kcYGp06VIH6XOYJEUt?=
 =?us-ascii?Q?jbMmstSxDGcb8EWG/mlDx/Ryrx6HRs7pDRpT2GT0m8C804Hi3XwzEFH3z730?=
 =?us-ascii?Q?qlnMwgdV5/oVuEa+DHijwN5Ht1aDIvxfKw74m7N34+KAMqVUJUNH3q8uE+KJ?=
 =?us-ascii?Q?VudikDXKa1oCBPqENeNcHM6QKFwAcYqB2rPGu0la3H8uR1gNM7caiCMkTFhT?=
 =?us-ascii?Q?9L24ptrq8tfXkTJ0AxKLv7pixyrx/V6vKHYcSMVZX1mOYJCculWf8NizAszA?=
 =?us-ascii?Q?PQE2t0ED2nihxxrRYITAOfBBvDRkHBtRD2d7edPzbOetzBgusxWhww0apKge?=
 =?us-ascii?Q?5bU8phD5WKfN2ADtZOPwxLBJzqwlhvkUZxnivwHdOS10V5kUdSR5kYnr9QRI?=
 =?us-ascii?Q?2FBR4Sz/gFZNU6Wvz0NemRCNGgTadb6H4aEkp7KqZ2OxtE8FPhLbz2vtOQ63?=
 =?us-ascii?Q?G58X0X8F+CgwveNN9M5yAFvIhoaQKh+34MqzkLUA0D0ZWyxnDZXrrix2SMLj?=
 =?us-ascii?Q?jU8+UYIICjZlwOOnilChBrtw8o55g9Pn8Z/5W/r9NBNpzs3m3Yg9wLj2mKJW?=
 =?us-ascii?Q?KsutXYWElPo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F2NesRrVX2u78ppjs7NWneGNyLJli2h2orjQNwoQZGf73dDgQZ1hXyVekwf7?=
 =?us-ascii?Q?agiLRcIrGAw0hw8fbZ1R9cHG+iYK8Btf0LmvbxA0tl5fg4v5m4IuRBGjEpkD?=
 =?us-ascii?Q?IlJ2wDo/Uc7maHoyKBMhAizLGxgWBkazBPJDlmswuwq0QdmI1RQ6cDsnc08o?=
 =?us-ascii?Q?jQdh0rmqsAljBCFSYOLFGyENWuKIvsBgDtxuBH6XSiko3TzINQP+76Sdmd58?=
 =?us-ascii?Q?ZiWvPMidl02KDSLwzYy2ak4pw49o3dd11SX0/BSofpA1pdHhNAsR1ukUT3Rf?=
 =?us-ascii?Q?otvC4VlBixrhbMc0EzAW4+dsthVq4fwdhYh4hLsnDXJu7/t+9W+99exMY5K7?=
 =?us-ascii?Q?14a+AU3U6Ah6OLp8gktTgOWTGvRrUZnBJVPR29eDvFiBRT+p4x8o58hC7z8l?=
 =?us-ascii?Q?Rk/EUqpocERF8PLyNhqZy05TpB41AwvCFkR7n40Mu1N8DrvRpkFzHIzqqMog?=
 =?us-ascii?Q?FrfTzoxmMGZxxGPIDQwwH792oXfTANlyytJm083XFvVwph8RT+pT5TQmWrBq?=
 =?us-ascii?Q?vSfXoPW4zg29FEMb7fDLBgmPO+R6AoGL7e5vOHQmOLiNsx00S9R3jM+akHzo?=
 =?us-ascii?Q?oWwdm8MqSBDfJYb94bHYidYQ9TyMMby4G3gBi1K4uQh3h57VFVzCgacQR6OR?=
 =?us-ascii?Q?sNRMjKKszzZGyXlbPPhHyo5Q6sxryQftk2IU8oObkyMPJD7a8XzFgVsgznTs?=
 =?us-ascii?Q?+wwwmkYcI6Snra0T6uD8zLsmxJych2I2lOTbEHa01lxdzunQbDZO4fnuK2o9?=
 =?us-ascii?Q?gy0YjAO1IiF2a1GfEXfafn17joaGaJlNaUnFyDYLfST4ohgNzcdWy/hTYHe4?=
 =?us-ascii?Q?F6Q2wA8lQDp9WL6+6B76dCW+P6zu3w74/X9jKqgMrU+ACwCvWxKPaeFq9wTy?=
 =?us-ascii?Q?ypKIBexbebw6Mz2wX/KLv+2bYmeO9YH5W548n24Gy1BIXbFpJ2rzmBZDLi/m?=
 =?us-ascii?Q?2eeR8B0qTZ/BZg+DUs1VZZAl66lLwrbpq6kpqo7EtsIRl6+wSj+f5PgSr6yp?=
 =?us-ascii?Q?OIAhtLonqY5WakBM0j7NaWOvSFzxxRMCqVc44fcUFddhea3omER9s2xYLd8I?=
 =?us-ascii?Q?f+ivUdMZe+vVMISzv4gDJhsmYa7WZoLclg7tBaV+hQqVGYpkTUqcXHdciC8M?=
 =?us-ascii?Q?jxG02HUs4oBWWIL12LlyXdv3lePbCe2Hh3Oqe5UfPMeLwEuhd6xwLqk178EB?=
 =?us-ascii?Q?mlbodTi0wDkpwr1+Zz49VXW29NGhxAZWhqZ0v6+ngX7aMNKiWGfT/Oc2nYAW?=
 =?us-ascii?Q?uhmZtX0DBxJDfKH8966kYzBWMHfXPUXymhBO1+BKw2+Liv0CUOgCJi588bd9?=
 =?us-ascii?Q?ftQmsxby9fKmTCoBvq/LLuJAec5pjoYy8M5ox54hGWBWXJLHLjamd8JscQFZ?=
 =?us-ascii?Q?OHDJrsvsCnAf6BCgOkGYOTf0FszfMhBYjPW6zcTWFgUWANCnFOQXb8hvPpFe?=
 =?us-ascii?Q?VsUaps/AEZP8N/38CCa0GPNW8B33ATtSSGLlGgy27nMPN0WXuvoUSDMKpbZo?=
 =?us-ascii?Q?/Gs4RgLilZDJUES6eNCCV07USe9gJjFbl7VfVpOnVs28sJEa7bQ4cXNWLUcM?=
 =?us-ascii?Q?apI1xdmCxl6USzOJ2bE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e58965-b691-476b-7300-08ddea277121
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:48:48.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OjQGxfb0wtw/QXWKaAcoITr65vVZwQpIikiHYseu/7ig51FaSTnz1K3n9cZ5Zrf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286

On Mon, Sep 01, 2025 at 07:10:53PM +0200, Pratyush Yadav wrote:
> Building kvalloc on top of this becomes trivial.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/commit/?h=kho-array&id=cf4c04c1e9ac854e3297018ad6dada17c54a59af

This isn't really an array, it is a non-seekable serialization of
key/values with some optimization for consecutive keys. IMHO it is
most useful if you don't know the size of the thing you want to
serialize in advance since it has a nice dynamic append.

But if you do know the size, I think it makes more sense just to do a
preserving vmalloc and write out a linear array..

So, it could be useful, but I wouldn't use it for memfd, the vmalloc
approach is better and we shouldn't optimize for sparsness which
should never happen.

> > The versioning should be first class, not hidden away as some emergent
> > property of registering multiple serializers or something like that.
> 
> That makes sense. How about some simple changes to the LUO interfaces to
> make the version more prominent:
> 
> 	int (*prepare)(struct liveupdate_file_handler *handler,
> 		       struct file *file, u64 *data, char **compatible);

Yeah, something more integrated with the ops is better.

You could list the supported versions in the ops itself

  const char **supported_deserialize_versions;

And let the luo framework find the right versions.

But for prepare I would expect an inbetween object:

	int (*prepare)(struct liveupdate_file_handler *handler,
	    	       struct luo_object *obj, struct file *file);

And then you'd do function calls on 'obj' to store 'data' per version.

Jason


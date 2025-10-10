Return-Path: <linux-fsdevel+bounces-63782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59AFBCDAA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2F4540FBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF92F746A;
	Fri, 10 Oct 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QYLSaM/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EF2F49EA;
	Fri, 10 Oct 2025 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108488; cv=fail; b=j5wZ9TeulfmtxNLSTPCywu+s9DNAFHiPzRJNUdETshikUMzlKcM7E6ySz7Be6IPIz0EgrWatyb+NFL/6oQ+E96AIEcrKI5LERCQuSYv9VUCRB31z7J03HybswCZLxbMl3Qz1XcQ9/ST4+TFndeHovO3tuoCPU2L3wVKbFNAQ1oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108488; c=relaxed/simple;
	bh=17HaYOEDvoUIUapIDpuw5cOHd8EABCkPV2bp62Own1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eaHK7rtM7qvaJwWMdHmLyJPAmm46qcmErrIl/dYEh9GSOfxQBlkT84MP9/9zAodJlfjdMrw0+Cy9We2q2IYET/eD7lMQyMLxlKVE0ydCvsIpTSRn9A2CHrC3iH2ul3ctKK31PwQofmS/PTC1gTkYsSgB0yhJVDgkTsDMcEqV1mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QYLSaM/u; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0F4Sn82+y9FyK00rhEHvWGM/42CJVzfFkJ/9DWx58dKr2QfvFO1D69iz7liDImKLeaqAQUztAc9L/0trJSK34CjXZops3KaaLDgM4OJuXk8KZ2AWSl4z4xKx90NrbMvuEpMJxwVWAIh4Eo15td+LVfA62BE4yneWbeZVVyRcdoyl9LPqayqO0g/f+OSs60QhrXsnXuDPIjEdcmuz8MGjEPZHRpb72MHeuQxaRNuIsvapBW4ajI48F6UiHCvGlX4epFMg5zQVk2zNrEI0o3UyWXtc60usNmQfJGl1NZ1V12K0gyuq9OSHgAUH8oV4NciN39IdGhMStumQq8VyjlrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP615ldv4btyGuG76V4xh8lTPdobbmQrpkknmxUfCYg=;
 b=A83wV0qpxLgDlVjxvlzkQ01tuZ3bht876cpMLq20wFbGXmdbUtDk/iJbYeGl6LMwUn8s05vS1taHV+cI14OjHCtjx69h9PGoN7soJSTgRBA7AxMU4rh9lwwYQL1obVCNeA7feEvCq3ghzt6tADPvDft1n0eQKUAPsm6RUsub5SlkDuACmGBLOSERt/rx7Pu/7KIphPKrzNDjPE32TwKjGzi5V3VPX0YJ2EIZNwSvNS6oRa59GMvQSi9THDkqip4QeOCFyq+iYf5Lh7q4L2+TghjbQgqq56owly3CtPFXpzEEiEP+hpaiN2rh5MzprIVXIKkUCcMIz/EQRAxAH226oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP615ldv4btyGuG76V4xh8lTPdobbmQrpkknmxUfCYg=;
 b=QYLSaM/utGEIKT93QqnS4XxJ/xppRV6T2NDdkqAQRCansTECNJr5TdKJpMUnC/WNlLuTS6g+ulfqLg4P1F8N11KymTZ0byI6fkebTtNSddHKPGbjEdQP0AcCo+5yabviHVADUeCyoYxw8KmvsOk+XO5snuIYDIw+U8z54ld04k/rcf9+MKwzxUm4urLraZvy8X3WzY+kKkw/8ViG+zBXo7ov47PBNk83eZGBFzVTNK/ynykzOlYhmzVN3v20RptkmAZa4eV9INw7wHBriobRlVCOrk2pqKX01WSUxu33pp+FDiqwbcllmFifrd2bnWtY8pMoTgKdXDB6j+lHJwWRcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 15:01:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 15:01:17 +0000
Date: Fri, 10 Oct 2025 12:01:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com,
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
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org, steven.sistare@oracle.com
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
Message-ID: <20251010150116.GC3901471@nvidia.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <mafs0ms5zn0nm.fsf@kernel.org>
 <CA+CK2bB6F634HCw_N5z9E5r_LpbGJrucuFb_5fL4da5_W99e4Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bB6F634HCw_N5z9E5r_LpbGJrucuFb_5fL4da5_W99e4Q@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0255.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::8) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: a97a063f-b0db-453e-1f09-08de080ddd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lc2+Nz0cKDIle+d2DmLOLOe8z8txMer3D3fLZLlztC3riOcS9yZKbOjrpW1w?=
 =?us-ascii?Q?JE1vLQATNsbWoq4Iuc5fOvw1I8vA5Uzr/LGD+8/CY1A2QHOkb9Qre0yS8y/1?=
 =?us-ascii?Q?18xfiYTNlX6CMurp1gf7B0kBnoorRPmiqMI7VB3SP/1CuGg76Ugb2qIHtZ1C?=
 =?us-ascii?Q?7l3Yr5AbsQH1tGn9q0wzrCHZ23y5IOolHTQLEttQfvmGoch02tLmloLUHEtF?=
 =?us-ascii?Q?G2hd8W1ufAnPQlZM2iKdU4q1VDeZqMOcOoDr+xvMk3+SfANPvLvA9QLP4UYL?=
 =?us-ascii?Q?QUWJ7SEDq1jtamilePE082/T6VDR5HE4NlXrB2BXvjkgEqCKMX68EtzviP+W?=
 =?us-ascii?Q?YX9qxvpnI41FGBCUtGTXrDDBb6Ek7+ODxCpLkCkLqgOxyQr+ZRI4zMb1ET68?=
 =?us-ascii?Q?IqxWRoHvknAYlwaFR87fZjP9hqxeHMJYzTz6Ugw0MlQ+UTSwO+ZBcQwxy4Dx?=
 =?us-ascii?Q?O6KDDRZwRXkUxI1KnOl5SPkdg2wxVR7QdXh0ehZsDUVsbwucvoFqIuqqZIUg?=
 =?us-ascii?Q?uiKmqoetXVXz4zMLWFVDpCvYYhfr52mYlKYIDHhZqQBkLWT+EQNQRF6uuwAF?=
 =?us-ascii?Q?cnz4QOrsQvThYBoaS0r6rPJYNdnItItDn7HRhjvALkWk9hmPBGzt1TW2hZjh?=
 =?us-ascii?Q?F39B+9RyzNH8Ls5+ydcQq8urGuknxcW+Xyg6wC3wOAKk6ECAgos+toYNDSWC?=
 =?us-ascii?Q?TBBFaQKw9j3nAcH27L9QnTj09UKKml3K5H3FXe27gQ1x4tKa2KKwbEz9Onl3?=
 =?us-ascii?Q?Y4vlRRmdxQ0HRXuQAMcGT5yUFVetk1gs/maccebZxYqUNWiPYxwAqX9i7K92?=
 =?us-ascii?Q?uDCDBFXCvdjg0rIcdFIwEN+3xICUBDy2NBeqYAwWMWqBpDc8eLAs6oHAkQvu?=
 =?us-ascii?Q?Zuf/SwKjQfJivPS4tWD6ti9mjgijaufQ6sMjYo7C1LIE0pCyDRf/XiZfz0/q?=
 =?us-ascii?Q?EuNEV4Hn5czMDNWVu+F1lehjGa5S+6YN0VMrnChInXp2O1a4oxXs6t/wL1iy?=
 =?us-ascii?Q?bu6m8X+ESBQUsnQ3zMm3xwAsbAdEj6iTajXEqEmu1lqLH510MgIU2Ur4dE/e?=
 =?us-ascii?Q?c+pFf+xv3dkIUsRSo+6uZ/G9BFlkrW1UKusk+fA7FQIWHvGGrpccbObkrWX5?=
 =?us-ascii?Q?zC+Fed0135FsE6F9/Mg3vzIv1xbK/IZILPDlFIrQGFE2/01NIAUP97JoZGj4?=
 =?us-ascii?Q?mrd1vzvR7Y5m4zcyJDXhs7BUhCu1EUJhGZxb2ABMy8ckugDKjgEKxQYaR7g3?=
 =?us-ascii?Q?dXDsBGS250Ex1Ac+J3k0irxwsqoXd3l3b/2VB7GXMo7FSY/epn8yKuBTFgN7?=
 =?us-ascii?Q?v3zScQqIYNI+yiRQJWCjCmAl96UeOsFcEjB9tZmp2/GqeV3zQq7bXYTd7GaF?=
 =?us-ascii?Q?zuq5070LAd1W9P5eRSEVs048M+mNAuhKxQ469To6GRB+z0oUUOkb3i3EmLB8?=
 =?us-ascii?Q?mowsIT2G2oL/aTZNhLcxQySM70rwgnEW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R820zei2Ebl9TiwBoLRzS5bk3vV38nXvXXTgOpa6SxvF34KvckFI/6sTSZ5C?=
 =?us-ascii?Q?a10l2A50jb3wweOR9m4cG0NB07X3yzRxjYZDOD4Fljdqxh3YMdMG4FjGbdSe?=
 =?us-ascii?Q?A92rwngNdSM7T66f31+PjMrh4SnLSQa7oI6EanuNDMcGbCG4BEp7cBJCFXfc?=
 =?us-ascii?Q?nmpvWdcw5My17MlKhjelOgCETWzhXpWRmhe+W0vUNKg0o0yliCCjvniPmNxu?=
 =?us-ascii?Q?5QPERK0IOGJuanz7kDN5cMeiJftnnwRWgeirrPIUr1iGmgcw9SjfG46tw3Kr?=
 =?us-ascii?Q?wEU9r3qIYDvMs9Bn5HaQyu0XzNTKZCgf4V/W6lTru4niiOG8ZHf45H2NIW4c?=
 =?us-ascii?Q?Y/7DC1N/B/tjIKNyykEa/Fwi4FDiHHXUG+XkrPrHyx/DFfWN9H/2sZtQxEqF?=
 =?us-ascii?Q?OX9niXVOTu2Hm3qffF2WqtaWGFlVcN2ghE+0bTYZ9h3ROiIRDwxQ4uQWTv2K?=
 =?us-ascii?Q?NeuTBzzNgur4IMOaYpjCbKwqm/53ylgGGQzDXRJQ4ycB+gikEXLa5HsWhvnb?=
 =?us-ascii?Q?XMeJLJS/E7YGWOGYkCIYqYlRvHYyHwxWL5lVNi5tdfwhEkk1mlxcTM+7k+eR?=
 =?us-ascii?Q?0275scbyiHrAwaLSylLeYjP5JWHxpFI006HCJ/tYB4s4je8cVweNRxXwozSM?=
 =?us-ascii?Q?OzyTv0kQB7d9bAvZWsxzOk38XdmrMt3TXufXDP1dbS6nIBfBhwaiCUloZkcX?=
 =?us-ascii?Q?buSR40ywPWIAce79VB4QqiMc4AodUumoPPV8GXy2gp6dVy84FAYb6d84wqRC?=
 =?us-ascii?Q?tijfiRj+XrYZydPclkGAMzfXkJXcVP1WRXrGlHpjqhkYXoGwNGe/jYE4zKmx?=
 =?us-ascii?Q?vYMFKjd7J2yvloxbvubXgtstsxKBrl3v4WoD/0YXKnd1olCfIaaHytuQWqXG?=
 =?us-ascii?Q?Ip1MaEiwwHteAPSpKbvN4M07izZ5XHPo5tIKMTtOSIS4md+WJWtrh/h+1Rdw?=
 =?us-ascii?Q?EwOZ/H+1UDOzywJQBEr0QVQUNhApjeWY4c94OqJgTCLkjeEeaXdnL5nuNMFo?=
 =?us-ascii?Q?7PIklXSlsKsJNplNhX+fGS+v+5YjwRlFjV8dvTmLHjf5mbymnzbGq/1GsFN1?=
 =?us-ascii?Q?EcGHFYaOffnOE/YOI24qrkyeX+EoC/kmSlmKOvkhNQlnjN2pd19bTXOpM93H?=
 =?us-ascii?Q?QKb9BWWsYkl06DoHRn2PKVQdLgHI+T+OuYOBkAuQYvppSb9FIRyNkgvIk6Xc?=
 =?us-ascii?Q?vwSOxDxlMzJe+wXq+mBx2G/h4uCjrl4bJIIoIsysQUYHqmZSrnVBUYD/Fwyu?=
 =?us-ascii?Q?cdx/hyf/QyBDFmLG2Fp1GrZv4rRRrhrXB6oF1HTzFTfs6nEo5oPl3gFGfhmQ?=
 =?us-ascii?Q?rrJF6eZ3tnG0YlAwtWUZZnOpuUkadv/AFEoOsyhsKSSpu5ddJh9O6PFS60kG?=
 =?us-ascii?Q?srWyqVXQcrPdw/MdOTzMXqPVkiBS2X2QNcwX2k9GCC39rAWH9luE/fRg1lwr?=
 =?us-ascii?Q?NbLE2Hl2iejv9QQnQ4MgxEk8EhB6dmrFTw2wuHRHxS9sdIilKIipZvm9qMTE?=
 =?us-ascii?Q?CZuaHuGetwdYMO1mRP+eEWJfV2jAUgQpzWYtaWtC0C+vmgDXiIEKrf8NkJJI?=
 =?us-ascii?Q?fffzKD3JxQTS0NLYlFI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97a063f-b0db-453e-1f09-08de080ddd54
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 15:01:17.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vdio7x+0PllvQVO54H2QHfk6kwsXJPpRrrz6TM6Ubg/sB3t4VIMxM6PxT9vzsh5E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015

On Thu, Oct 09, 2025 at 07:50:12PM -0400, Pasha Tatashin wrote:
> >   This can look something like:
> >
> >   hugetlb_luo_preserve_folio(folio, ...);
> >
> >   Nice and simple.
> >
> >   Compare this with the new proposed API:
> >
> >   liveupdate_fh_global_state_get(h, &hugetlb_data);
> >   // This will have update serialized state now.
> >   hugetlb_luo_preserve_folio(hugetlb_data, folio, ...);
> >   liveupdate_fh_global_state_put(h);
> >
> >   We do the same thing but in a very complicated way.
> >
> > - When the system-wide preserve happens, the hugetlb subsystem gets a
> >   callback to serialize. It converts its runtime global state to
> >   serialized state since now it knows no more FDs will be added.
> >
> >   With the new API, this doesn't need to be done since each FD prepare
> >   already updates serialized state.
> >
> > - If there are no hugetlb FDs, then the hugetlb subsystem doesn't put
> >   anything in LUO. This is same as new API.
> >
> > - If some hugetlb FDs are not restored after liveupdate and the finish
> >   event is triggered, the subsystem gets its finish() handler called and
> >   it can free things up.
> >
> >   I don't get how that would work with the new API.
> 
> The new API isn't more complicated; It codifies the common pattern of
> "create on first use, destroy on last use" into a reusable helper,
> saving each file handler from having to reinvent the same reference
> counting and locking scheme. But, as you point out, subsystems provide
> more control, specifically they handle full creation/free instead of
> relying on file-handlers for that.

I'd say hugetlb *should* be doing the more complicated thing. We
should not have global static data for luo floating around the kernel,
this is too easily abused in bad ways.

The above "complicated" sequence forces the caller to have a fd
session handle, and "hides" the global state inside luo so the
subsystem can't just randomly reach into it whenever it likes.

This is a deliberate and violent way to force clean coding practices
and good layering.

Not sure why hugetlb pools would need another xarray??

1) Use a vmalloc and store a list of the PFNs in the pool. Pool becomes
   frozen, can't add/remove PFNs.
2) Require the users of hugetlb memory, like memfd, to
   preserve/restore the folios they are using (using their hugetlb order)
3) Just before kexec run over the PFN list and mark a bit if the folio
   was preserved by KHO or not. Make sure everything gets KHO
   preserved.

Restore puts the PFNs that were not preserved directly in the free
pool, the end user of the folio like the memfd restores and eventually
normally frees the other folios.

It is simple and fits nicely into the infrastructure here, where the
first time you trigger a global state it does the pfn list and
freezing, and the lifecycle and locking for this operation is directly
managed by luo.

The memfd, when it knows it has hugetlb folios inside it, would
trigger this.

Jason


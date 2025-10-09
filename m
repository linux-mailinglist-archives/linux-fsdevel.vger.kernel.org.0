Return-Path: <linux-fsdevel+bounces-63663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51715BC9A40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 16:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA4B44FBDC6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659B22EBB89;
	Thu,  9 Oct 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHvijA/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAA2BDC35;
	Thu,  9 Oct 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021450; cv=fail; b=oznC46TkyZXg2giWkEikZ2qjK6OKGnWHVDeld2so0XcYPno2Fe35P0u/BD1C2ErQzR310mLW3GX9dnpfJUPF/P4ijQirkqbqIC4zsCbAVrio0Yp8EEt2NQ/DmkF1wkXbWcfpFqF5tq2XQTE2jAhI3GAC8PCJ2abbozqBRPCAxL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021450; c=relaxed/simple;
	bh=dkMagJ5m+a+p+QXZdILEJud6ZWUditwMn23qIxqE3Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ot6Yxz5HX2xlFLrcFQJu4WWiN1pNsQNxfzdj9fnlc6+Iq3IQ9/cQTVJyCAtEyUZpYUbjACB9tQ0HjZHaDYu+7Ojr2Z3d9zE0RpXEgLY9Jb0cK86xse6OWE++gy+gyrQ/SNQ7HNaj8r8LaWzvHxdUNVBbeRIZqP3oFaNj02gkdh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHvijA/2; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/RFwPkC0W4FT0dg7mgRg9/hQeH8j0F1DgdlZ0jdn0ttYYVDoyORobxrr1a4weYy+YksRTkdAubv3AFU6M0ndoxmaburkA1iwRT5n92NMR+5jTP/aDDlc6VGrya+dyl4f7ElkdCaKdsP8YnZ+a8JOuqoDhRYHmvohg15Jg8I2wG/VuKSihzUlMffJgHEfmvlzFWvby55CzOT1078soyxOcLWoa7K6piTZ48xkGkLwYVxuWqcLzTgKB6IBZ3CmIZiSvqXZ9VhCHJGOBULbC6Pw4gFzhU6zWIdjjdfeyQqsWQALqe2LeUkSOIF1sNVLV0OAcxhwxm8TbnkdbebVCTACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdFDosfo8rdHls415NH0c3idlnDogr7pvuBk5z0l2gg=;
 b=Fw8YUnJ5xzHxSyqxR1Ym/O78z/xSju2cSZNa29w98WGR1zYpbnzJy62B4o0NRepk8qP68YoEqu3tzbUSiuhfA6fiNJrtpS7cJqCydUe50YAAi1+4tx6fNUgsgqA03KkkD6dycZVrdQbEmXbppo48GeJsrlk4T2W3K4gz85jfK279p7UhBdJRcFPDiEszXup/CloOLkHw6MwxEfsYotUhiFT0is4c9ltMrb4LmucLgSoS+kIeNqKW1gXJKfxHEJ9+uiKXSgZLETmXVFcQ+T6908wK3aabr8oGrkJLE5z6/vlzrOJk3XMulmhdMwjI7/GJGAJYPFC5wmQWh0FydICMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdFDosfo8rdHls415NH0c3idlnDogr7pvuBk5z0l2gg=;
 b=AHvijA/209N1g5i3U4YhHzrQPgKdPSy55WwnEg+h7BV1PSKyiQTX5YzHK46X7LCYfFZKo+io7dXc20OqzFFHlh9Bx+xaztV16vSCVW4iTZ+3zZ48SVwu9noNg63NYrxG93/whRB6lanWO6umd16HquKIZv32HDGx1TcsggyuPHTEOvAxrROLlIqouRZ6HvevkTJhGUi5TY5vs8A1ZO2A8g2K2ARinlT6luPZk2i14q0pnDRgSImzOR9juGNVkDuMSRG3JnYUZDeP/yKzxlJB/W0gvjSqn1PqbKbe7UvirdZWicwm08S3bsG/gJ7Cd+4MnsTy8KqEyE/P4kEUQn2kPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 14:50:45 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 14:50:45 +0000
Date: Thu, 9 Oct 2025 11:50:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	"yanjun.zhu" <yanjun.zhu@linux.dev>, jasonmiu@google.com,
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
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state
 monitoring
Message-ID: <20251009145043.GE3839422@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com>
 <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
 <mafs0qzvcmje2.fsf@kernel.org>
 <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adbfc4a-fa52-4347-4d9b-08de07433a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nP+gCqVP4OtR/B7K8vFGRBjMfsqRt3dVkQ4OCYo3o211oHeBjPuuehK2/arh?=
 =?us-ascii?Q?BBOTu3hJAPVb+M1vPo+vcpq4MbVmkBMnXmmWw9FUbire2ZXyZ6h8gzwYJtAZ?=
 =?us-ascii?Q?acz1skbE3o2P7Lod4s9VA+mi2bJ/nEz0JzUOgXxa4vvCpUTroL6Yjq30jKvg?=
 =?us-ascii?Q?tAAKV7AGmB5MQoJrX3YhyPN+Kigqm0mwCisuNW+AbBF7WSM0ie/XMNl4cgYA?=
 =?us-ascii?Q?nqqUBTKoxa6AIX+Gh1S2TH8EtUzAU6RCl40N0qbR65WMcEvDHTBScePw8q+1?=
 =?us-ascii?Q?1Ofyc+X2f/jV/V3L14wUpLMkqr7rHJmYaYeNkpU+6A2QMlMTxPI6zsz3UE4q?=
 =?us-ascii?Q?OVWlCebr+sJcJk/nR/rP7mapFbR80dEckklZCg875OMs/4yDBWoerb95I2KB?=
 =?us-ascii?Q?mJPIuZhSPpBRv98KEUvQHoCmM/ELXPCn1Xz0NF2phUDH2GsnzKKdtxe+ItOn?=
 =?us-ascii?Q?dX+fH67yHZvVdAnPmGN9LUsqxZzV9hGRucc+S29uNGmjF95tNprCXd9q+Coc?=
 =?us-ascii?Q?PGXcuAH7Y0KLhB9jMQ/CobGKPwqaE90OmVy19x/C+YfwBzGj0ZjCtO3N3NzO?=
 =?us-ascii?Q?mb/CuHEyi+noyCXEOk6ZWhaCFTF/Gr7mqwAIg+0vguZlggq7NJ6yTrWvdS8C?=
 =?us-ascii?Q?7lqdIpmNtTksE6kQqPiFXRCuGo6O34zB3puScvWtnzyzN69y5XcrzkwU4Ncp?=
 =?us-ascii?Q?7hgPZ83WatvM6wpG9PP3RGSUfBdxdjQHAYFuKRpC4+rg0DMo0mBkyklyuYOQ?=
 =?us-ascii?Q?EpHhOmJe2VzOhHhK1set69FH7AN3lOxl/h5n8YhMXeQd3uZIFS+WsvkolBu+?=
 =?us-ascii?Q?TNXDeAMk3hp+xcyo15G5iJOWoR3bu68flNWwSb4i8FJiYXwzndS+TNt/uZAn?=
 =?us-ascii?Q?covNCcdsOGCcInteCDN5CcNnnrbXhYLjZPKGLrxboN2zFmNgLUF77e3eaIb8?=
 =?us-ascii?Q?73KatPCJHmCdwDjctc79IAqIhL3ifPElcYYTOsRk/TubAAqVsvEATF/6n/8j?=
 =?us-ascii?Q?f8REBY9UFO/ZV+bI3r48d8dP4Gfzv+mZ0FmB8uWtXTcqJ9u9boHkUPvqhXCi?=
 =?us-ascii?Q?rZE5rYIFxWHLY7ExFrV9hVKxvFVNmvdl5VUjk5BrQqdnfGrNBFcZdG1RiL27?=
 =?us-ascii?Q?eeDXAvyuhXPEA2CK91rt0hlBE6HKoeFg8flMFPo/0vhQleF29BSIeNgB2Lmp?=
 =?us-ascii?Q?Pldpym5zfYWz21oYsJM2aQN4yA0F3ydUbg44dWoLm4pKZFaueRr2DPo3ZWFm?=
 =?us-ascii?Q?wlp44W9PW3I6Y0VABrcWyqqOkUVFaGRGJ/oUNzEQMRTmsIZ/7MLpG/fWpWoU?=
 =?us-ascii?Q?Iij/cVZglcT0XB2IqJwkF8SlhjHWvcestJS1iOFlQV46JW/MH6f2W7FWkYOS?=
 =?us-ascii?Q?C13qsE8PHZnYwfFl5hY0ORunvdtQ0NE2cDPcQgI9/cr8Kq94IU1jYsiWWiMx?=
 =?us-ascii?Q?pIM/xsE8xub8Fi47wv7N1R8tpxmIn6r/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Z/Y9UvFWtaBB+gyKR08gdNtHITlSHnXD2+mD3wMz9JlBaRn7pnyB6iITgv8?=
 =?us-ascii?Q?UhYwAF5uulh5jrVFIlu1Egi1z0SnTKPv9X5w6+BnufsSX+SOnCqK9j0p68Sd?=
 =?us-ascii?Q?nr2hzL4lGlmRevmzoLOt5LSxsW7tnYq3lawHA11NhSZIvoJBXrmXc1KX28i4?=
 =?us-ascii?Q?sjvMfIc/tF6l7zPnRnrpajpIj041mT4WZrXjLTAtid8StpN761wV18Z6LsrT?=
 =?us-ascii?Q?bSYY6+6xIO/Bmyqs7kffiBRR2in5vZmflbblJkC30VuPNOIgiXr0uQoIO2NF?=
 =?us-ascii?Q?wXcymeLS4M89dCZdAtB8DeMJXMd3K8lhcIYgR0jbBfDSzCcAo7FmJu4DZmCS?=
 =?us-ascii?Q?Hvl+J8vc/AIZ9SXi14V39SHPwzqAT8vzmaz5f82+wLPSZM05Sb5Ie349/GgJ?=
 =?us-ascii?Q?QXC8x8c9oNkiJEltkgKMZKPkut/xnwIrAbkCeBNvGmCi5fuBtTlMcRe1pSis?=
 =?us-ascii?Q?jFvM5Ba9Dl9k0GiaSafHpY2zz3017SVeoZaBOPU81p5YCf/HGxcYP9wk7Byr?=
 =?us-ascii?Q?At1tkm9N5yMDIJ2BDfGQoUqXZxbI+wepOsmUEkFpYb0e+4/xit7WVwuOJVW3?=
 =?us-ascii?Q?/996XU3P5Ur8fAe+huIGu3sfUlnExvfF5XGNEh9NF43NJTK7ufCiIpIHdhCl?=
 =?us-ascii?Q?P0P8YqDAIPSmKI+KY1peMXbLubveVIcXs2MuwUQcXs2WHOScrXH5uWyOy65K?=
 =?us-ascii?Q?CKILfUcNwsg6Dc5gCwfN2QugGLscyD+Lozh3308B5VlLdi3RmnaBRy+ta5kk?=
 =?us-ascii?Q?lA1NGPjdCTlStoFfl36gh0ZVl1MnGlCbuj/RoG/RbMKeNZ4quD4iioy7xTMF?=
 =?us-ascii?Q?w9geqOK/fTqqpqPBs4RM85UBu1oEu02/uueOqICbF8Vh5zi5fifN1wJ48ltG?=
 =?us-ascii?Q?HuwvmKqnuEuz85lUrRETfgduEKH7qjGHkOJLdAyUaj+KSVK+YfFayp7uvpq3?=
 =?us-ascii?Q?OUkUEKuZ07q5jIa1o21WfUoTGKzpWORyaDzOUN2RG6jaDA5sLf/gCpajZWC4?=
 =?us-ascii?Q?APnFA5ffu3YF3H7zjMT8dzbJj/4ZtwUiseUHhN8eAL2/QFtW7GQ3EGcGfsoU?=
 =?us-ascii?Q?1j6+TSi2ocl/HzCV5AgDhIXsVJGdfI9/v6aywRfmB1J93h+iXQkro+nEgP+B?=
 =?us-ascii?Q?FgktBi3p2GA/QOq+e0KDBkDJmdBis0MZrSuUcGEwL1SWOf7v6+9QfKXco4m1?=
 =?us-ascii?Q?lpOKF9SlwkL2yaUKDmfdsw8mFVwd0ttwlFBV9T1GvZGk1+TgOHm8QitnapFw?=
 =?us-ascii?Q?1sfPOvDflVh86+nOgEUaQkdhoL4BmnLE56ahkRvO8BJ3ExX4j7ZplIAg1YYK?=
 =?us-ascii?Q?48hU1w9nGndyNXsgQhgQhybNXb5zf2HANeuLHjdqFgpc1cWuJ7hGSKrJS1d6?=
 =?us-ascii?Q?l/cIilkGzriW8Wkqh2EAAt6FRApg8zC0qgI1bi1hYapEG/PeIhgItiQrXDIB?=
 =?us-ascii?Q?TopZIvCg/96yEMTFF/R5oTFWaAZJ9LlVdF0ZJB2Qtqvo+F1IX9+5ZdSeet5+?=
 =?us-ascii?Q?OgaKpfmH/4KYm2IsFR/YLNgwfkSepNdoQnCT7FVzWXdsaLmMnsGpOmKDtFW8?=
 =?us-ascii?Q?eDvSqy4txkSkLuncYu0nHroFTMXbpp4geGgMxlU8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adbfc4a-fa52-4347-4d9b-08de07433a25
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:50:45.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOIvtu2sXA9yqP5L5KqfFLm9SA9bkOtnTVBibvfLWcR6j2uxqxZOMKqllhGkj4+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925

On Thu, Oct 09, 2025 at 08:01:13AM -0400, Pasha Tatashin wrote:
> > > Because the window of kernel live update is short, it is difficult to statistics
> > > how many times the kernel is live updated.
> > >
> > > Is it possible to add a variable to statistics the times that the kernel is live
> > > updated?
> >
> > The kernel doesn't do the live update on its own. The process is driven
> > and sequenced by userspace. So if you want to keep statistics, you
> > should do it from your userspace (luod maybe?). I don't see any need for
> > this in the kernel.
> >
> 
> One use case I can think of is including information in kdump or the
> backtrace warning/panic messages about how many times this machine has
> been live-updated. In the past, I've seen bugs (related to memory
> corruption) that occurred only after several kexecs, not on the first
> one. 

That seems like a reasonable point, to do something like a taint where
this is recorded, visible and logged during an oops.

Jason


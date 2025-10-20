Return-Path: <linux-fsdevel+bounces-64712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C8BF1D7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED77718A0E6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8331322C9D;
	Mon, 20 Oct 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qO0Jbhva"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514742A1B2;
	Mon, 20 Oct 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970575; cv=fail; b=tFRoDcRKY32GIeG4R6N0HgOZ78u0JljSWOozn+lnPTHPDU5WWk+vSxe3JOE27a9xmWqdSHrIChAt5CZbnaUeLKSCezdPdcqGBNxKl9MY+zgajsKP7h3epj4ZzBVvch8jmFrRscBemoLXXzr9mXcp2i5cs9Uw3ZCw+2D9zQYvPq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970575; c=relaxed/simple;
	bh=q4i7oQ803OfbxZaYX7N8Z/tfkZ8WLkFiw74unFGiRgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CphrAMIH4V1mNG2x1ckRJ+hu6avdIYat3HOolXXrKx+CKqg6FpjyqHXjE3ENHkQFICKqsWNu62rZHje3WlMKi37E7Va1eXZwuJjpGvUaH5WOh0is0fLhiywkOB+RVjwvsL8hrIWCBu51zzcEyr+weRQfsgBdLnPz+dHeRXCyFlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qO0Jbhva; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyPdfwS7RCgsS5UoWtJmfoaZlsMUUzGBE8lSnQ4Qx8Xv+NfUuW7hbqu2VeiYdf0llVY/ccxGuvKLnqkjdNKqmzat+euQiNvvpU9Q0wMWaA2jPWscAo07gjLQKkg2ethFp62ucCFfooYmelKAuaNPiO5IMs/mhMkUTuZdBMm9tgClGVtiQeTtBkOryTAv/OviKCPDRI7gKcArW3lFc+ZvI/tIajGX3LQA+Pe+//FZphhOu2w8FyQcQ604I+mC+70ZqvQodpJnc19bVNNGVlXG4VpVTXuGbOhNoBMUHAUdsvpuhNEgYb+1Ruj7vDeMri1D1xzJvYfnvkZUmChMCDcRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsMmPL0B1dv21zWKq0SP3H5Pfnn4OCXqUBOCLME+SwY=;
 b=ZmUkQAniUW+TpVliRYcDGfE/949uVf3APtK2H19fQUyyqRh5DFU8P8y8CH5aXH1z17yX6nruf4mPaG5Zu1hWje9R002Y5nED5pJVVxtHoCF/yS8lwC0DGB8w+iJw0ktcvU4RV5RFZb0XIUOifm0hZnCRO/0ahKDFYGcNPG8LqeQkpDz8ueQJkfwEofX4vDJzguL8neNnyiPJI1Sm/W9vli+5mqYsPW/Tl6ck0QepCQ5s74b2UO6N3uGdWPBXxpKEsSNxaZpJgXVIlQ/r9OqzJdjpmeaojKYvQf5eK9iphFutHBHuFLJNMQYg7FNhnQqoxlqWsyeQlb254tteFgyqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsMmPL0B1dv21zWKq0SP3H5Pfnn4OCXqUBOCLME+SwY=;
 b=qO0JbhvaRJO6wC0PG8AY4xPdcVVIglhiap7bvWHvUT20wGXqdPctb3skxhOwSjCbVPR2zLzHb3jc4ryr05eZoDkQhXsx4ncACR0gDHejkU8lvfl9QhCTKZszWBg/+1W6Qp8qkjSotFmJ+47p6Fh1uQLpGjo09LsNOudlbhAq7XRLfVb18ztPui2UJk4xKpueTzHKcNtMvTeHcyZ8SiZ98k0ilP37JAw8WZFNGrHw3LgLItidkOt8WRTP6aXdOaP/+zapNHFFxZS2mwHuFtFFtF57/AJR2cb6EIlnNEu2PBY8Y5otm0uRBswXhhG9EthJkcv1PJb6RIJIXXtRH85xbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 14:29:28 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 14:29:27 +0000
Date: Mon, 20 Oct 2025 11:29:24 -0300
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
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org, steven.sistare@oracle.com
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
Message-ID: <20251020142924.GS316284@nvidia.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <mafs0ms5zn0nm.fsf@kernel.org>
 <CA+CK2bB6F634HCw_N5z9E5r_LpbGJrucuFb_5fL4da5_W99e4Q@mail.gmail.com>
 <20251010150116.GC3901471@nvidia.com>
 <mafs0bjm9lig8.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0bjm9lig8.fsf@kernel.org>
X-ClientProxiedBy: BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::19) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe638e3-dc55-4aec-8a54-08de0fe51233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jY81ke9d7g3z4y0OuOlwqPv7Mlvb3FMfeXhbvQ3T0BkcL2GGE3xiEDdO6/jM?=
 =?us-ascii?Q?xx68h+Dds+GCgWkNRSb7glTqlRZAD4GU0FRTonLF4nCXWUX69BY9dpaUVwH/?=
 =?us-ascii?Q?z6PGpDyQG9Dx1/VtuuZcbm0Bi87hP6jc5SprJLIWNG8oPsZ8UAbeRMRwjpLD?=
 =?us-ascii?Q?GqtaMVuk/Hyo3dttbai3NoWX4VsvultpXgC8dUQfPSdoUVbwDN3SSqh6v0Ae?=
 =?us-ascii?Q?GsO6QkYkfHo1uX36jlFjcDYppuRuN+vwC3rXcjTXIyOpB1uPLWxF2DuuDD4m?=
 =?us-ascii?Q?3+Mr1OXKt263nkhKkgzYHsamIHW9JqzwnSBW7lvtSL8sSum83fsaIU227OiB?=
 =?us-ascii?Q?E4wU8SUSjFSVRQxUrwB3eRiP0Nzhhcw0YLVS1W0ENBsxaDx2ilRVUesGJ8/4?=
 =?us-ascii?Q?qOLjpweXDZIbbP0BKqaDdZ3/oh71wswgDrKXtE23WRDRUuJCfFh3pDS7tsjT?=
 =?us-ascii?Q?8/BOUZ9BQzUBZ8CxJPl5sAoNkyZDHjBFaGuRSIZPmtvuuuGQLNKdI0hxFVwU?=
 =?us-ascii?Q?kA0TdTarZMMicC9hZGTW66LFGtUL8eFKT88XWalVnT7kxITKPV0C/7FAdVjM?=
 =?us-ascii?Q?xswh+c2TdYRJnx2+fyzPLg5YljaT/udBb61h9uVjPUDCSz5k2V20XBuh4RE6?=
 =?us-ascii?Q?q5D32su9xKNyb4t07nJIhd+3wMw2ZCPoBLkfP0K59Gdh8Shua3lXsrJTVu5O?=
 =?us-ascii?Q?E2O58fIKv34hCr4xjn/u9pM97BuYeczYwvtzXWs9+ELS7ol/Uvrgs2eN7L3K?=
 =?us-ascii?Q?lSFQKAbixStTS6YhWEp7h9iITsv2SbgxPG/5FqMT/zU4KnmiU4Wvx6iTJNPY?=
 =?us-ascii?Q?GJaWeLjJxgcz+jFqGGIDJS104fOCLYDTMCPIvAKnLEMAJQzUE/z5at9URbbH?=
 =?us-ascii?Q?EzPnP2Eg5QHEFQOsAzskMrrBIoT2wN8iV+NJJZjl+xXuGCCVEtEmAAfLLcke?=
 =?us-ascii?Q?+RN7i8ccDpcu+n/4J9QnmNvIXjI5bHHYwpisiuvXCrGpFYql4JkrPMlPnW6w?=
 =?us-ascii?Q?i+uuwDoxZM7JU8CpkPpu/7G1cISIgsPfdF9gFHQppd+IlCHL7DaANmNR1Jru?=
 =?us-ascii?Q?+R90h9itbC42echjppiLzdAQiHPjULjqFcWM2BtH7isnhJL9TXVPhRLSBR67?=
 =?us-ascii?Q?q/YlqRg3IyC2GGZxLYnwL0/JR7QS3h0JxGLbGBFZ+LY8gosGtWVy7aBxQkt4?=
 =?us-ascii?Q?cSbR+YaeIsRuAb3oU7YXVgFzkXdOFeIUWP1d8lBl0zWQhYzB0c8jGtgF/CTe?=
 =?us-ascii?Q?PFR5XPeTNuRjCUcb/78D68Mz+Oa3Wia7kab3J1mbaHSEbhbv8/wIZPfGX6dz?=
 =?us-ascii?Q?xDwO1tYdg0szphzvaMAZvQ8x4vZ9an44A/LpQsdi0FY9spXlhiyUOVbbVVkS?=
 =?us-ascii?Q?MFi5kZahOP24cVvr888UOGPixP/p13A44wOvRPH9g3aCTBV9Vs65Bhq2YNzZ?=
 =?us-ascii?Q?DcoYCyeF0tLdi2yMcnx+viMT8ObsBIyv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ulWhDlEwbITlISOXreuXGyvNnDPYoHUEQd8N8zYYp9Lrzqr65NVX3fROgwB?=
 =?us-ascii?Q?BDaJv4VqJ808vd/hel0NO58OrahwMrKrvUZEb7aKOT1QFwqor5JNRYpcHJ6t?=
 =?us-ascii?Q?AV0GQwfBkwISdSrRDjeXDJGWa/YxWi0f92MicnwajBZvkdKm172Ro7HLnwFa?=
 =?us-ascii?Q?M14rcu3yYXR6a5ArUYoaBe45iw0Q/0d7STfrEYUsw2mhYEuQ5+yMhJP1JZwy?=
 =?us-ascii?Q?iWreGOaq2sAL9UUNwIiy+6Ml4sLWRfNtzYTjgzbrD1hepgEhF3BVQ/ZAFa89?=
 =?us-ascii?Q?7Qz3TdXjSdzmz2oICSzXDtMhCTo0sWkz2ssSkH9C+4NpQkj2ZQm6cow4YNHG?=
 =?us-ascii?Q?xCd7RG2ciWMxAJSWq4Cfj7aebcsuM3LcvCKqTavFP1++vSHZ7Yx+txokiLEn?=
 =?us-ascii?Q?PRwkyN3ArDiHYFEAiG2Scnmd12ULYMYeHsCIwwqO7ZW25gAKsdzri6FdHxPO?=
 =?us-ascii?Q?aVf6Py72LS0NMUhx2hg8uqZXEkhg4ZUpgPIp79wzd/urQ/vo/gGttHrQJIXS?=
 =?us-ascii?Q?zvCQAUF5CznKJZwmrYJiEQ1vwnAtYZDs4RsTCbGzWokcOr1LQuIS2wvxVm9Q?=
 =?us-ascii?Q?n6wNz40Bga47AkFReEdHJDqgOhuKmstUxIlnaMPXr4aWF2WBvERE9wnCLQ2d?=
 =?us-ascii?Q?LVYjKglJ7zieyg6wd6d+nYp4dWOzhrZ7G7nuvt9wvpNAXjregcqkl2kZsE3L?=
 =?us-ascii?Q?gHFIuX2z0NOx5tDCfD7AfAdpo3XsOkdCOTAVugKwJHbWioiqrXpNXJkvffgT?=
 =?us-ascii?Q?imejGdXCu4WODrPD7bwMz2xXd9459FcQmzhxECiXoIKRFhTp6UGT97UA+13V?=
 =?us-ascii?Q?2OxRLErducnUEyJTgBWENyr8zdGREoQcIAxZgC+QX22UBfBTHvniVkJpXQla?=
 =?us-ascii?Q?2ZumGN1u+ZNRbc2IpO+n3DNteFO7FiatYWZwLvYJLAkhwzjE9YiztNfne7/m?=
 =?us-ascii?Q?y3r4IavbmxPuyHOSvAYkajY425E95xZ+TicqyXk3KEUCAxD0THBov0KMLxIP?=
 =?us-ascii?Q?Tacu2oQiUpckSJIPjTQrEIc3sTUb6gGtyRatAfo76zFCp58W264ltWm9j3hY?=
 =?us-ascii?Q?jcSaV2LT3bfIH/ZtPA1bq3YM0oXM7aXFa12ZiV+XZwZpT04K/kmPDoqbnawC?=
 =?us-ascii?Q?ddjVNxYT7cY+8m6PmmheuaQ3yucfs4OQxaZxmkNJCs5Pl598eE9ga+gcE80u?=
 =?us-ascii?Q?3YTmlL5dsLfljcCxt5zKl1GozdcXQ1frlC7QNZ6S3LfkZFPYeRgrLwv1wH6F?=
 =?us-ascii?Q?+TQZOQPVstFuJzhBqlw885zDhD4hYGAIXQV9y20s4V/d94i0rCYNKzUiMOlS?=
 =?us-ascii?Q?RWeTFoPngesi7WucS9xjnPaoidRpaQy5Ysf5QJoo8SgbjQb1mT5+o7Hcybu7?=
 =?us-ascii?Q?E8XWEjrnC9Cw2cOSVt2lEnweU7cangcDFu7HM205t3iWCaEgNFOkboU9gGpv?=
 =?us-ascii?Q?oO/BmZR8kNFAqHVL6nn3KbkDbk+p0oNru+nfrB3UiZ51i53O8sO+UMAa8VGh?=
 =?us-ascii?Q?2L0dtGN/WhPgfuT7Q0/twBZjGC64Mri9MNIItzmRXQgRaL8n4ccBA6BeDMX1?=
 =?us-ascii?Q?J5mR7cY+BI7MqkDhXTQw0+1q/z2Bi6we9/KL9yMv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe638e3-dc55-4aec-8a54-08de0fe51233
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:29:27.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PECpX9WTVRiG2LFS4ZVh8Hgl4eseTKF7mQZPw2Q4Sb7OPMA5VrMFScDDxrYgMl7s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097

On Tue, Oct 14, 2025 at 03:29:59PM +0200, Pratyush Yadav wrote:
> > 1) Use a vmalloc and store a list of the PFNs in the pool. Pool becomes
> >    frozen, can't add/remove PFNs.
> 
> Doesn't that circumvent LUO's state machine? The idea with the state
> machine was to have clear points in time when the system goes into the
> "limited capacity"/"frozen" state, which is the LIVEUPDATE_PREPARE
> event. 

I wouldn't get too invested in the FSM, it is there but it doesn't
mean every luo client has to be focused on it.

> With what you propose, the first FD being preserved implicitly
> triggers the prepare event. Same thing for unprepare/cancel operations.

Yes, this is easy to write and simple to manage.

> I am wondering if it is better to do it the other way round: prepare all
> files first, and then prepare the hugetlb subsystem at
> LIVEUPDATE_PREPARE event. At that point it already knows which pages to
> mark preserved so the serialization can be done in one go.

I think this would be slower and more complex?

> > 2) Require the users of hugetlb memory, like memfd, to
> >    preserve/restore the folios they are using (using their hugetlb order)
> > 3) Just before kexec run over the PFN list and mark a bit if the folio
> >    was preserved by KHO or not. Make sure everything gets KHO
> >    preserved.
> 
> "just before kexec" would need a callback from LUO. I suppose a
> subsystem is the place for that callback. I wrote my email under the
> (wrong) impression that we were replacing subsystems.

The file descriptors path should have luo client ops that have all
the required callbacks. This is probably an existing op.

> That makes me wonder: how is the subsystem-level callback supposed to
> access the global data? I suppose it can use the liveupdate_file_handler
> directly, but it is kind of strange since technically the subsystem and
> file handler are two different entities.

If we need such things we would need a way to link these together, but
I'm wonder if we really don't..

> Also as Pasha mentioned, 1G pages for guest_memfd will use hugetlb, and
> I'm not sure how that would map with this shared global data. memfd and
> guest_memfd will likely have different liveupdate_file_handler but would
> share data from the same subsystem. Maybe that's a problem to solve for
> later...

On preserve memfd should call into hugetlb to activate it as a hugetlb
page provider and preserve it too.

Jason


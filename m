Return-Path: <linux-fsdevel+bounces-73279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E5D144DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 507513007294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC573793B3;
	Mon, 12 Jan 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lop1p3ye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AA3793A7;
	Mon, 12 Jan 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238329; cv=fail; b=q+bjWgP1m6IcaSlo3x+HuTP+KLNWahfZ5Klq/lHDrtGFBluK6pRrRDlhOAeaKm2jUz/rf7JHL+SQYsANlwoguZyHD9db12OCGzTDx75Amd5GcBw8b9+s8T9CczS29umzjnHV4emVc50kt8WrLMHF26pmc1YtNuX/vTTYsTkf7ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238329; c=relaxed/simple;
	bh=sKEMF09cEIotIm23stxK4CQRPe7OL/GS/gge+/POFVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N7fWsy2sF54yF+gF9Fnaux61RKU+xZyEObMw9XV6Gm1Fq638mhaw8EyrBclAC8a9iy1g1hPJQlcQEHYldOZJEdh4Yt+rZiad8fRWt43lTzJbFsYQ7w283XwZWiWUznIDpEcW4fNam7neGpJryAFga4Grn0bkIhsLzQRHFeQGNSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lop1p3ye; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHNRVjOPAApMdBhlIHd+/eH3RPsrpzjFzBnmTOEyu7WdVB1T7fUOI7dlaNiQ09UHgProqSewew3ZI5XO2nIz0+Fn9ur2Tf6SLCclLQ4/M8P483DM40BPW31VrOTBRf0mVYxG6wNNqE8Csbbb1s3n7mnscyLD5hSYG0OtPaeAWz9N1DEdtp1YxDYClx+YnBYgPy23/FWkflTg4AcCBUnOhs5n7ZXYJksiRIsQR/Nkh/Uxpa79WUMRsIxnStmf3OpFb/phK61R1bfbvwKY6w55LTaG7KeU0IXLZxIjA+JqM+RFGvXjUf8huWN9xwb9LCYaBkmsDBtX3fxRy7faiNDydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1NonMAyuqhtz5oohgpHzgxpuBooO8UOVfEGv/F1F/M=;
 b=SJ9YQZe38tGkEDRP0CrBDLHZ6A8fW4fsg00QXdO+kaF8yNJ4z+em1TOTOU+DkgkY70mG6Aq3NR+Wy52dLnNrG0ShslzwE24Fqiwy/WQbHaehwZ8bt6WT2Nm8kbh135v0323jSwPgZMa0lRQ1sgIA70/0SvFT5Hyt7tRZ5K7tKi7A3bwGDwNAH11fDqnpjAEFZIjlFqBe5Fe6VY/f2jJDi4OAvUvvNFeTX1ohmTraKXWmIhPKWdh2vurk4KQeWO8PAq5wRiZrMge48e8m/v8+MWhwljH/sD/gaxT0uzV8s/kRIkNutnNyOVN9N6g1i5UYplSFkVdCWNioG4aHPycvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1NonMAyuqhtz5oohgpHzgxpuBooO8UOVfEGv/F1F/M=;
 b=Lop1p3yesGZ8w3FWfQbfypp7bf2G19LpduwTnjb054HEBjeNxj4VWqxzXqnPzgMcH0GZIC1ILbemu7QspPuD7IRTzdssds4em6NEZAn5a5HoDNdyKuQmos9HiBCFep7ZYCPqgHoC5KVl3mlZlAU4aBs9Tx4h3HuGuco5tklEJxSBVH8aHpW5lqNDBO378VU6gyYdeMcJ4QaOBssBHXxNcDm6y+XeCU97+M0eK8CpPce+AGBq+nc8FQVRWDYjEz21T4hh5zjX8xzJURXRsBz3rox4mj5EwvdWfEPs2pVlrFvn+q/2OWfP2mM+teft4WQVig9lZ8DVm193r0GSCJdDow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 17:18:42 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::bdb6:e12f:18b6:2b77]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::bdb6:e12f:18b6:2b77%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 17:18:42 +0000
Date: Mon, 12 Jan 2026 12:18:40 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
Message-ID: <aWUs8Fx2CG07F81e@yury>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
 <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: BN9PR03CA0466.namprd03.prod.outlook.com
 (2603:10b6:408:139::21) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6524cf84-b2bc-443d-05e0-08de51fea24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPi4RVJoJVvms0TKizFAJRN97ukhjYCGHKnQpNa9EcgR36ZpaNHCQTD4eepa?=
 =?us-ascii?Q?uorWYhkZBnZinRo3bJvkSj6EM6xqsTGe4BHnWaI+7JWDc/WDA6Z/lWBWUn4L?=
 =?us-ascii?Q?+rfe84HMDpx0ReRPjoQOv5MrS/FJdCxfLB1X2pDgYI/LlqzjyTausup5ITr/?=
 =?us-ascii?Q?JEzHknYYMaOlYiDSVkM0kkHmigv3upSb72ilGPMnKtxFWR92btHSvp37elh+?=
 =?us-ascii?Q?5P9WW47HWAhlrai25OJ2cACDetwYbaJG1+4ZUgWqpWUsWaJTzxMp3Oq+HuQQ?=
 =?us-ascii?Q?HJKzZCFzXLWX9SPHHW8CAfzLDdoDhmmulr9UkhH/Ypq2XLs5KqpxsSOW72lo?=
 =?us-ascii?Q?32hQkcCguDjXpHl8yW0NupZ3aquQcWNJPFygt1dI0fOe1oUQoUp8oQUx1e/m?=
 =?us-ascii?Q?Fk6fqN958UB9ecK3+Jrvq5sjFtVVr90wgMvhmVHsKuU9/9VstT8UCrRG+qoP?=
 =?us-ascii?Q?hU7JLnt+vh/tNy7xlnk7ATeI5l6jaO3TyHgPMrGGLPRGafDFzUyRgUDSHHUx?=
 =?us-ascii?Q?8BDnEWaVhVCBkkRK7UyQwzz3I75aIh4dMOmMJK2yzK7e5CYPR6GquOgXess4?=
 =?us-ascii?Q?h01YsPW4/9JMXIDClNIf6EnVbG5rxiX1o9aNO0OZPfHpd1tMr2xUItro3v5r?=
 =?us-ascii?Q?atRPtprO/tBKzeLj3W2jHLUWO2hoDKyuRM4/fEI4PqStgH89WiD0zsaejp2D?=
 =?us-ascii?Q?PvEHF3/R/pP9T4a81SiwZ/eSlcE9YMWtHCzN6RmyqdvjRflLP398A35Hnjme?=
 =?us-ascii?Q?d/eUMZzUClK8MIIRwAVvE1528H6KZxjGLY/xhCs3VxSmfPIpH3N3x7oaDeaD?=
 =?us-ascii?Q?I/lTGcKZvjCAKsJmFP5BbqCj0Tp0lil/4meARVS4A2oIwIS2s9TEBn87p7o7?=
 =?us-ascii?Q?EHkD8qRXvWCc2Qfx21+nM6rUCum6/QiAgEYsgzrm+U33T++adosiQWzoc6MG?=
 =?us-ascii?Q?XxnQGIKoyQ4562bgIY9BuvpLpaFtRp54td2Jmf1AA8899mphEOD++dcxHul9?=
 =?us-ascii?Q?4v/T2kG7rqPfsqxxwXdlcyKW7t2P9UWRpdD9GET9cl0Tt9APxrtexujKFjIQ?=
 =?us-ascii?Q?jg8z3aiiwCuvI0WXowRtB7lCMslw7Ms9LTrzEUR3fPXSgpkEOssi9f87xLPb?=
 =?us-ascii?Q?zw9OhmrYTTGYeKVgg3PL4hmRw2pEE/6XbztsLllQql9Kt8U9QSg3k/VN0Y4H?=
 =?us-ascii?Q?uBpvSVzyQqgVyFmPIKdHQcdUrBI0VE7KwN/MK4N+Cui0V9FM6htiJvLEGn5u?=
 =?us-ascii?Q?Hup7pSUrwfEUQ3Ot9mJmQMMmhuo3c6VEaJ8hx8wKg7zZoX1vC5wqdSPWVdyZ?=
 =?us-ascii?Q?YO7vpGL6SqqbdHb1YMuAZ2U99wvWrm/3hOP+i/4q1askiuYviAo7cMj1EmKb?=
 =?us-ascii?Q?edRyRAxIj/s/k6WFMMAe0JWa0wa5FUDZ3Ka3vvDTE0rsNQYkTOxjWey/MmRj?=
 =?us-ascii?Q?ukze9sFpIs/BIzECLQJ8g+KiEOFuLu6L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+v7DFt+mDAobz4bH+HiXu4ad/LfQsfwLahFWvC5UAVIVXPQpX9jF5LryHVm?=
 =?us-ascii?Q?+b/yzit0A7O8qiwL3gl/YS9ajATOR1X0bkru1LVaYrMcHm12OQNBALOCapDf?=
 =?us-ascii?Q?KkiKFJd1IdJTgZeeENYPJhi8L04HrpMKmlY8GIPrmD5j5lbXUMrQELlat8a+?=
 =?us-ascii?Q?WBE2DAHVWm1676Ixn9rqLtMAVuNv0XW+7YcZt7IxZ85pOgRv0ttzftnZjqh0?=
 =?us-ascii?Q?4fbzwV3X0ZaEPsCewcUVuThz3Oxi1xkXkZrJ2LAnvF4JJvqAMaDi4dpCfJ8R?=
 =?us-ascii?Q?+ARP6DH+mLOX1zoRBsJs0kGadGJKB3lX7q/8u3odRQBQUhAOfDbNxhyrBku1?=
 =?us-ascii?Q?loV7qYSlxqlffEU4PfeoQYS9rlukAdXPG4IYi7Q+kHfqT2iMo+SuQqbS72ug?=
 =?us-ascii?Q?W6poLgXHQX7hXM+9f8ldBYwP0Fov76e+qJErCLTgQrALR4vQdcNf/YIlBwpt?=
 =?us-ascii?Q?288oR+AWopjocHzRXQweCUCdzDk61zweQDYaSaYTls6Oq0Fd2C1QDgfzeQVT?=
 =?us-ascii?Q?1a9ZHP0z5VmfXdDsK2fIEeYu9DNiAsOQYgZHRpRGouSiHfJ4V7LhNDeKk6v2?=
 =?us-ascii?Q?/mfw3pTQH3Qi9dtLkIdWi6ApcVJq/inWGG+hpRGiO2RBrlR++mtwb7metYK8?=
 =?us-ascii?Q?ze6X7gzMmPsBhqJuFbQaUqAHSUxDIOOT8Uwx/7dTBaMJBrHg3as6zeUtaY7v?=
 =?us-ascii?Q?asKEEvg5EzmI3P5DcHm0qLq08BWexyxweLZjde8l2KYbfFliecsL+4OLuOQR?=
 =?us-ascii?Q?F+LpBQ9RgrP6vT7hDvCLAt+tlS8Y5SJOZAOo4brUVCsJlaCuHQjDuY2QJM7k?=
 =?us-ascii?Q?jlxRmy9LOR4OHVysMHnYHBJtuTSWg8Gjrbke0qv8zO0bTL6usqfZF7h4P9Th?=
 =?us-ascii?Q?Lsnw+ZFChJZ1ohb861zHsIWcjoxn9MyTtK4Fs8oRcHdKCqAfwZdEwAelTc+t?=
 =?us-ascii?Q?DcI2zyDhnn1J7+6UvAn0pOTfxD2VNtRZu6dfs6Q3uzgcAaXc2aOeD2N3XCUW?=
 =?us-ascii?Q?AdMJEbXQMOjjy9maRK+nY5uQuHo6vMQTCyuEnOaiQGBuqqe5P6A8L1DzpUJ0?=
 =?us-ascii?Q?bj/YiC7V4pn604lm0Nafcb3RxvyVfDCV5gUtsE2B9MzWjly8iaekdq6hMMDu?=
 =?us-ascii?Q?E43D9g6HC4vcjIILHOx9De7wHN6mSXvopjh+QIK/uMmGiovGbDtTpmoR9BTX?=
 =?us-ascii?Q?upKbzY48+3j67nDFLr9CitbBm3M5YzlPlND/RTkwkDAaMesQ14Onc2wgn6DM?=
 =?us-ascii?Q?ONUJAQ/u9mRLLxo87UY9gro54v3E+K81s1mDKeQ9Yk3fbXsXbsUgx9yMmjwK?=
 =?us-ascii?Q?H1gA4+tEC4Ch+2e3L8oYFBkAGC0VnlGSG3oQSIbnqZM2zujKJPiY3uL8Lg5/?=
 =?us-ascii?Q?lA5OM6LUj9ee6SSvk2Nu+9x2PjPSAYotX44u/VA7/pLUoNNjg8zLWdPkDbDg?=
 =?us-ascii?Q?u2YUsLA78E1nTKNHwMhTyvEymjOSZ36laGOTlO0AryDUqCHG1r6xxcMqp37z?=
 =?us-ascii?Q?GEim1vUGgj0wrRYmsSuwsvC/HYRLWinfNv2gUykgJYxIpK2QkhZt69G6YKyE?=
 =?us-ascii?Q?FVvSvCPU5OJZ/BKevJyXLcWDnkOC+glTdCwxeGCTrz9etKl9NT7qVg/ETi/H?=
 =?us-ascii?Q?5HZCYmUU4ECTrBBup3YqV8axETG66X2sDIlYe32h5hVpRncaTp70GDiexVe7?=
 =?us-ascii?Q?+6e3JXLCatDqhbo7sykBzf1cpuRiD5o3KUJwf8I5dw3dvMVimqkKnqq+Hynu?=
 =?us-ascii?Q?mU+8Bb45yRcRaLbGvBU4w9MNPAbvcZdvY1STnVZN0jfQ8nSSNMJB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6524cf84-b2bc-443d-05e0-08de51fea24e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:18:42.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reSFBT+GFXGQbFJYkJDNzN0G5uIKvpw3qHJTTCivLpsfvGws4tBiX8bbLkMKyvHif/Nej4LVtj/VRFgzAePdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242

On Mon, Jan 12, 2026 at 09:36:49AM -0500, Gregory Price wrote:
> On Mon, Jan 12, 2026 at 10:12:23PM +1100, Balbir Singh wrote:
> > On 1/9/26 06:37, Gregory Price wrote:
> > > This series introduces N_PRIVATE, a new node state for memory nodes 
> > > whose memory is not intended for general system consumption.  Today,
> > > device drivers (CXL, accelerators, etc.) hotplug their memory to access
> > > mm/ services like page allocation and reclaim, but this exposes general
> > > workloads to memory with different characteristics and reliability
> > > guarantees than system RAM.
> > > 
> > > N_PRIVATE provides isolation by default while enabling explicit access
> > > via __GFP_THISNODE for subsystems that understand how to manage these
> > > specialized memory regions.
> > > 
> > 
> > I assume each class of N_PRIVATE is a separate set of NUMA nodes, these
> > could be real or virtual memory nodes?
> >
> 
> This has the the topic of a long, long discussion on the CXL discord -
> how do we get extra nodes if we intend to make HPA space flexibly
> configurable by "intended use".
> 
> tl;dr:  open to discussion.  As of right now, there's no way (that I
> know of) to allocate additional NUMA nodes at boot without having some
> indication that one is needed in the ACPI table (srat touches a PXM, or
> CEDT defines a region not present in SRAT).
> 
> Best idea we have right now is to have a build config that reserves some
> extra nodes which can be used later (they're in N_POSSIBLE but otherwise
> not used by anything).
> 
> > > Design
> > > ======
> > > 
> > > The series introduces:
> > > 
> > >   1. N_PRIVATE node state (mutually exclusive with N_MEMORY)
> > 
> > We should call it N_PRIVATE_MEMORY
> >
> 
> Dan Williams convinced me to go with N_PRIVATE, but this is really a
> bikeshed topic

No it's not. To me (OK, an almost random reader in this discussion),
N_PRIVATE is a pretty confusing name. It doesn't answer the question:
private what? N_PRIVATE_MEMORY is better in that department, isn't?

But taking into account isolcpus, maybe N_ISOLMEM?

> - we could call it N_BOBERT until we find consensus.

Please give it the right name well describing the scope and purpose of
the new restriction policy before moving forward.
 
> > >   enum private_memtype {
> > >       NODE_MEM_NOTYPE,      /* No type assigned (invalid state) */
> > >       NODE_MEM_ZSWAP,       /* Swap compression target */
> > >       NODE_MEM_COMPRESSED,  /* General compressed RAM */
> > >       NODE_MEM_ACCELERATOR, /* Accelerator-attached memory */
> > >       NODE_MEM_DEMOTE_ONLY, /* Memory-tier demotion target only */
> > >       NODE_MAX_MEMTYPE,
> > >   };
> > > 
> > > These types serve as policy hints for subsystems:
> > > 
> > 
> > Do these nodes have fallback(s)? Are these nodes prone to OOM when memory is exhausted
> > in one class of N_PRIVATE node(s)?
> > 
> 
> Right now, these nodes do not have fallbacks, and even if they did the
> use of __GFP_THISNODE would prevent this.  That's intended.
> 
> In theory you could have nodes of similar types fall back to each other,
> but that feels like increased complexity for questionable value.  The
> service requested __GFP_THISNODE should be aware that it needs to manage
> fallback.

Yeah, and most GFP_THISNODE users also pass GFP_NOWARN, which makes it
looking more like an emergency feature. Maybe add a symmetric GFP_PRIVATE
flag that would allow for more flexibility, and highlight the intention
better?

> > What about page cache allocation form these nodes? Since default allocations
> > never use them, a file system would need to do additional work to allocate
> > on them, if there was ever a desire to use them. 
> 
> Yes, in-fact that is the intent.  Anything requesting memory from these
> nodes would need to be aware of how to manage them.
> 
> Similar to ZONE_DEVICE memory - which is wholly unmanaged by the page

This is quite opposite to what you are saying in the motivation
section:

  Several emerging memory technologies require kernel memory management
  services but should not be used for general allocations

So, is it completely unmanaged node, or only general allocation isolated?

Thanks,
Yury

> allocator.  There's potential for re-using some of the ZONE_DEVICE or
> HMM callback infrastructure to implement the callbacks for N_PRIVATE
> instead of re-inventing it.
> 
> > Would memory
> > migration would work between N_PRIVATE and N_MEMORY using move_pages()?
> > 
> 
> N_PRIVATE -> N_MEMORY would probably be easy and trivial, but could also
> be a controllable bit.
> 
> A side-discussion not present in these notes has been whether memtype
> should be an enum or a bitfield.
> 
> N_MEMORY -> N_PRIVATE via migrate.c would probably require some changes
> to migration_target_control and the alloc callback (in vmscan.c, see
> alloc_migrate_folio) would need to be N_PRIVATE aware.
> 
> 
> Thanks for taking a look,
> ~Gregory


Return-Path: <linux-fsdevel+bounces-57893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE7B267BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062D5620458
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5003019C5;
	Thu, 14 Aug 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dpEH6Ew5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A473019DC;
	Thu, 14 Aug 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178215; cv=fail; b=nzENBbAcOqArr0BJeZpLKVX1CuShigIHJiH+5YLXKlRH8CGnklsF+IDYDOPNw8M3+mxp0TWrWVnPj2Q9DWOIypltwrfIHzSQkQdc6bvqLRAwNp2OdNoR+d2vgUlHdbsM35t8lD/QkKRSOffwggg2oq1YiQLjFGSlafowO8n2dQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178215; c=relaxed/simple;
	bh=9NwGVCUcAGInM/nJFHS2QjUegvs0yL+7ZFpiTafWuSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mWfa/mb128crRb12Nf3WXVlCJDlPDFn5R69UM+zzjUUxDFmTknysj/aLY/SqMgETxXio4zlR8/tFak9Xv5NlG4/CXFDoOZ1DywA0RRNiwW4abVIFecuvKgl7wrgfpkOsE0b6ieM+z28ZVVPo6fDAbX1iHO8WxZyOjM6O0c9FNt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dpEH6Ew5; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZlPSjHWB5Qd+sjbT1IdPWwAr8ro89/6SprGvO7pfx1/rOtE0oUZpJI8zkYtQnbcH1el90OEAGGqvQpyQuHERhB0JfCe7Ms32QsbjAUuFLGNkUMw6+BCk6fK8RSfJ41k+4auWa6mqHHotc2NCouXHuqlrBXkluY29icxAsdG5HswLYZhbkdzC4ajvVVosO4wA4XG30Wxra05h5+jlEqG4ghMz8sT4DpPhcbx50RSov7yUx812tr3xeC0D95PixUaIk8bM/Eck50oTL586AQWWfkZhmWnIIvlu7IEuWKXyUO5ggfia7wkSR+BpRgsqtx3rHFoMk9XoRJ+AAHc88rvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaWi2Hgu8Xn6tm7LGk8SRKLPh1+z+t2fs6Pbs6V+xpQ=;
 b=hQ6s5wU/a4dPZMAOMz/tBIGKPXsngmSpUc83kC6Bn1/YuRpGfsIibkz+vT1e/oEP1CJix5H5XZIjfEaAOyeP9x5LoycOov1BulB3uaDu75+/ui8J4toLO01oQucip+VhmVCvbhT49h2TGKiSh35Obml+R6VUlxxWWD6VSlN0yscI972XIac7z2ufFV53+N7s6Sh+jbtUj3cjn9ol6s5g+SkfiogxSrceepy+ZYRNnkQkMEsPd5K14s/PrBYLnjhHxrCg+i+GED7ywSdtHpyqG2o4xMqs9+GRzown3ka2HDJKLfB8lxfXeomRoL8usuv0Fe5Ku081nxYxKw3RnzrOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaWi2Hgu8Xn6tm7LGk8SRKLPh1+z+t2fs6Pbs6V+xpQ=;
 b=dpEH6Ew5hrWfUXa0n3cpN48azlxf9vfriS48jSlDD2jh/fL6uOof26bSlVCSoWytE1VVTMV/VY3uEIX4z0jNcQ3LJRkIfqm5UPugaxmsxLnh+kuA2ZkrZfQsnvYO7MNf7EEKJUBOju0aAKQ//7IFayIDiPM2Su6BYhxul1VEIjBODzQTtU8F3O+kHTwput5wvDr+BosmJT/ReeU0cAylgfIs6XbixbfPSxv06w+8EA7dTNDgPNPJ61XVLPH10TLxo7iM4YLDDcZ+FERoZBB3qW60HGZTjokZReJESVp1NWSN1hXchmLNlEaPxsYU042cN5rJ5vd+TXWVSqYx51Whqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 13:30:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 13:30:10 +0000
Date: Thu, 14 Aug 2025 10:30:09 -0300
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
Subject: Re: [PATCH v3 08/30] kho: don't unpreserve memory during abort
Message-ID: <20250814133009.GC802098@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-9-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-9-pasha.tatashin@soleen.com>
X-ClientProxiedBy: YT4P288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: eac63462-1ef3-42cf-1346-08dddb36b11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hVrjPVA/K/SJjd9Q0XnFuunrK3VPQI/nY8d7Cd6CJrzAXPwn3ukgI0FWCt6g?=
 =?us-ascii?Q?e0aKTu138b/cFLUjh7nKwqyOV7U6YAjJ9A6uOn+Un2nJ/cECnyeKACIIsdLq?=
 =?us-ascii?Q?SJmkxzeet8F6MjEw4hYjzLFncf+4A3IqWuZfJoZjEDNaVBFy3BBjNfYZnL/1?=
 =?us-ascii?Q?1xCe729aW2RRJ83YSzNdGnCSXr/lcL4AMqQba/258jHdatwfKzInuO6IOenS?=
 =?us-ascii?Q?HNjbKoZL9zIWAQ5kShzXSVqSWMAvgs+OYJKnflsVKQtNDwrYFlZ3A6RQ66Qw?=
 =?us-ascii?Q?/MYLuKFM5qRjleNUZyE/oUiKAFFF6suVnZPzvek9iCWyHMbY3fNy62QyWvLF?=
 =?us-ascii?Q?7QyGnE1G232F5uUTxpRt+s49SnhZCAjGsvn4lk6ZUm6PoGNP9OngXaPDaySg?=
 =?us-ascii?Q?G9MVEbyUZ0UHSbegSx0QtCsCerk1+nExhC9y8TZNpL5VS/acK/WlaYTg1Tyz?=
 =?us-ascii?Q?V4iEJfTsfoKK/fFfEo48VLSb9SuU8SMdkncdXSnOoUpSwHqRm/JlVHFBvXkv?=
 =?us-ascii?Q?r1Jozk3MrlMuqRmB/KcquAQ5xJiZpFGw2pXxITbZZbFgSLWTbthC97f5cRcg?=
 =?us-ascii?Q?taW0Ulkf3oFX2x9Nqif8hi+DX4v7G/bPiMqIr0+Yf7lrZV0rmDtMC1ZpVRh+?=
 =?us-ascii?Q?wvwcIaN5AbMi1jNLlKihGBXl6ejvnpCpTL179uwKtao8Re8HUqwgxQNDwfrM?=
 =?us-ascii?Q?EYyGW94IAaq1LANhfpkhjQqCcxjzOz9wRByuzKqApjr2DUuGovo1YM1Px74p?=
 =?us-ascii?Q?CVjmtCUDW4lc3qXWfNFNc2oHamQ6tWNRpr+nS3xvyyZhNMlWWtGk188CFlfR?=
 =?us-ascii?Q?/3ZnHkDxozbJR1R+9KrS83z32rFwmV34nUbLKIL2gehpY4UV4OvP5W2ULwmQ?=
 =?us-ascii?Q?AJPqgJJnQ2cqei0P8feRgAJBJh9h2h4mPNEsunPBeBrSC23UdELTguSm5OqE?=
 =?us-ascii?Q?OFIZrnsnhfwUP2oBQNMV9UTSDc2+zBYkEK07QTqTioyQWyGk0lEzTHnKAUr4?=
 =?us-ascii?Q?PUKSQgMA5Bn7NEDrtwrSmx3kwCrLYf9yWzbqea5n1agqU5LxexCGJD4M28cr?=
 =?us-ascii?Q?h/gXVwphEGALLLKSiqppMwyeP/qVU4rk6JmOTLQrczUC56noJUPCldIijiNM?=
 =?us-ascii?Q?475pTNJ4WlCWm3Uw1n/zotQEZRplOC7Kp8sCA7GNVGzGqZ+fWe6g0W757IHs?=
 =?us-ascii?Q?G+KchoHMZR5TCJ06uUrHW6kmyJMAk7opFvs2B5kcF+JPsuSxVasLNW7hA/TZ?=
 =?us-ascii?Q?cWIs17e5TuW037hIGKMM5opRc7xhzPrrdVHa4zGIxYbgA3Nmnf6PEyBkauCD?=
 =?us-ascii?Q?/f0xeCY0RGL5x4Vr6Qo1cJPDwmEwHuDw8QBquoq5IbxhzFddFBc8SKU+zduS?=
 =?us-ascii?Q?hK5T6bSfvV+6bEFwBwwoRamzom8WG3xiqHo2h9x7+gB0qVcQ2042BAQJZ5xt?=
 =?us-ascii?Q?R3j7OkW655I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?skhr/BBQQtDN0L/xF6PZ6y+aMn4qA026N6/e9sLH7JNUGkfI0nH8Zd3BrXEa?=
 =?us-ascii?Q?dbfFa41TM1O78WQWS9W+7Bi7iOgP9aEGiPoLChBi/NB/CFMWa+fiPnpjbc5s?=
 =?us-ascii?Q?QCZ4PcU0pPvMmA/LZ+jRbwKxXEWq4U7HIv9xH1fKH+voek0CE6L1moJcNOZP?=
 =?us-ascii?Q?bPIAY5sFYEL5KvBp6Ika7apMpzqqnolixHwidDm9hcBtwKpUZVT+iABF6FuO?=
 =?us-ascii?Q?znit/K59C2hI0lfdQ/mlZLqNjF9/UDYXXvzx2sYzEmI5G4ef7xG7lE8FESFJ?=
 =?us-ascii?Q?rL8vxzWRfOXM/ch3C2LkyRR/c0bCeknmcxPXGm9UG+tR6f9nqF+iOZJQ/ONn?=
 =?us-ascii?Q?5kedcqZbAWyFcK7qc3++luTE5reKaNbSSH+JuxKcaaZIurn93I2Z8RtLADaI?=
 =?us-ascii?Q?jaXZjMYrnv5fk7G82k7ZZS56nutAXC9ZLRhcc1mU9EotpJsqoNmEmVphpaX0?=
 =?us-ascii?Q?TPwbkhkRdIPFPN9OCDx+i++2OqhD2hXYW4gJo6UQ5ZsCarzJrM8m8I7jJi7b?=
 =?us-ascii?Q?tKCKN7qc1PqiyoaDF9Sk2/7N0CqBW95TJQfe2c3UKNZ5mmjh4FmuZDSmBAth?=
 =?us-ascii?Q?Meji1aLJn3LVoq9xuu7WlrFtmxPNB0K6lIZnUw/Rb6KeqRNal0qvmn2TjVeq?=
 =?us-ascii?Q?hvdOJD9C3dK9HHygr2CbYDhsl18QKYVhrTPJgaIX2pHz1FkgD/WDFjavEd4N?=
 =?us-ascii?Q?9ernIalmO6W01omURdrv5eMze1LLLEMMjBHwh+wV/YjQwE2BKWplCl4Ta/Dg?=
 =?us-ascii?Q?KGJxvA3HQngTIyfdnZUi3aT9hb2kNRUJQuC+ZYBLtRTxVuSxdvp1D4BQiNOs?=
 =?us-ascii?Q?klEft6Ky84TMjrQ+ZQSIjuy3CQId7mwP15sVkfcXK34d4o1hEGbfrJUFPiw3?=
 =?us-ascii?Q?SKzxdKPc55QezNkClEmPaP4sDCHblSB7AK7uRlg3ArBT3XKJyfezxwTJGwt9?=
 =?us-ascii?Q?S03GI7oVTi2AoaaI6ZQQBpMY+UEJc+WWmpc0/lAcI7F5PFaQ0iGYGX0Xs2/B?=
 =?us-ascii?Q?OIFU3MRR+ErNU9+R0ebtjkUE11MdUWktmxcdYuXeYvHmLrjXEzKW942891RC?=
 =?us-ascii?Q?r0UrWnOw9PT/Z5iy8c4QAC/clJ/0YMhvD65coeAYMH/tCsVz2w7t0z1OYrwj?=
 =?us-ascii?Q?FnwBxV7kQNLQ9duijXCbD7Y+OxftXfhmdLLqs/i+qElXfGL6nrcyqHATbYx7?=
 =?us-ascii?Q?YmtzvdDzkgKlaLTdn8DiYdtWlGziQr+/BcmA/oaVRz3ErCXpSvsFVZib+IGB?=
 =?us-ascii?Q?5IWM8ROJwn5THwLYqborIV5HDAww3WeCqGKZVcMEI8I9gtJ1lOhNkqrE+Ron?=
 =?us-ascii?Q?Em8n3abkP71z8PGNXoZtb3FpRnb3LfaNTwBYgVP6ICVoEMqxkIH0JlDqaRfa?=
 =?us-ascii?Q?uPTbh7ed9TgzltHV/reuQ81uYimyTImh/memm0n0Urh8qHnv5FKvMXsVLpOG?=
 =?us-ascii?Q?JF0188tNTeY4NMIicjliZcEiPTNI/jtORildoCWjODVSc6pYuat9syVA7WSD?=
 =?us-ascii?Q?dJ5GxLyP7ScTFk3BrJkea8g8+BwJr8riBvFFTRPp0A5Bs5RxUYo7AXhG8ktv?=
 =?us-ascii?Q?PUOmSb83orqk+URsZ4E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac63462-1ef3-42cf-1346-08dddb36b11a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:30:10.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnxGlkL1O1CKf5TQNAu78IN1DOjw/U6CXTTsjmAXFdZHkTlSv5r3kRFquJIoEKfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965

On Thu, Aug 07, 2025 at 01:44:14AM +0000, Pasha Tatashin wrote:
>  static int __kho_abort(void)
>  {
> -	int err = 0;
> -	unsigned long order;
> -	struct kho_mem_phys *physxa;
> -
> -	xa_for_each(&kho_out.track.orders, order, physxa) {
> -		struct kho_mem_phys_bits *bits;
> -		unsigned long phys;
> -
> -		xa_for_each(&physxa->phys_bits, phys, bits)
> -			kfree(bits);
> -
> -		xa_destroy(&physxa->phys_bits);
> -		kfree(physxa);
> -	}
> -	xa_destroy(&kho_out.track.orders);

Now nothing ever cleans this up :\

Are you sure the issue isn't in the caller that it shouldn't be
calling kho abort until all the other stuff is cleaned up first?

I feel like this is another case of absuing globals gives an unclear
lifecycle model.

Jason


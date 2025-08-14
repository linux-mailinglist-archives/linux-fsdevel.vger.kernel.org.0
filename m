Return-Path: <linux-fsdevel+bounces-57900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1EFB268ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DA21CE72BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A55207A2A;
	Thu, 14 Aug 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IPRIPR9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31621F2C45;
	Thu, 14 Aug 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180179; cv=fail; b=DW8mepRVcEV3JyZ6LHzclDwlNqou+ySSY8DSJQ7iAzpqzRxoU+O+2TbbuFZkxHhCg3Dl9dfgiIs5GhXN35D9VJR8kCCO5ybXUU+W8pMzP31QdRqrfQP6JEoX51mLNzWxaYBret5NBd28HbNhxJggTeEzZHqhVE0+xVLXKTGaRSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180179; c=relaxed/simple;
	bh=W4YNYuarqU+YZ19gmETk1wYyFpgocIONJPD3Vnjyi2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JZIx4ppFt1xX1kD+vltXgIEm5n1DgsWLGJ44CKjhK6rqZZUOQ5LWkcG5ezVoPwR1Rug6Q2illGUFYPbsI3TfDTv7+h+9isav6jadtfJGWMIAntUxFuI8R2izQQtSOa+Wba9d2hz90GsPKsxdj4p8cjiquxj6LaOLh6O2gagv3Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IPRIPR9t; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmlSHWQ8c+JkZy79/XVjneW72a7fFxB07OglLFQV/YPaHH/iBi/uSyFNBlLUviPx56QCFBg3ShG3TaU9U2HTgVTtcjONB4NR+N4N7bqJKoZMmQP/6ce4rFTLnpJLw/zTSxgUYMuJbzu/x5zVyVmzEDvfjvj1/nfGIElNv6aMSoL+Z0mDmDDHdFaBuwQDP0UNq4xbAjyWOgAdzbloRrqGjaNhqvmL2VXkReze2fujKOdPkyH8efKO2qRNLuwmt+hVic2T3xRjOA27W7UTG/UFylmvuj6okYBrfl9/o/agkxs0dase9z5hA4hNoeD0xqlr51FSTGHFoL7lr/Uoox9TVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCRR+qficmaSKAAxzP/PqrjpL2iTV293DJwBdO7Gd6k=;
 b=D2Fe5B/iIaJKOK0VJp4SbnwlIMeXxb3f66FiLDreRM+V6GMdstiFo1lfUzze0raJhc+xMbzO/GhC51xY7+2jlH3dYD3RGu4C6aZKOO4gnZoj6QlXNOzRwAH4MZCiA8ngTghMzQAcS4U30IMGz3V1O9ujM5L2BkxGsDm9QyYFBcWc+5xMcsKht+yYNZgJkCjlLu6hj2ihwd1no+bz07G1gbkTp2b5R1ZkJYf2gSv/wx4EM4ffpA7/bXHp4sUvgCt9qltIfJzpOXkoLMjJfTivOBtaseMo0szWJEngCRm47HLuBIpSs8BiIJnQWLVGABspF4HjANd8BKsd1xWSqNeYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCRR+qficmaSKAAxzP/PqrjpL2iTV293DJwBdO7Gd6k=;
 b=IPRIPR9t4+jf+D8P8VOltPuQ9oCxKawdAhUnPnxav9ygZpht6StSv+8DRXOyvuA3/LVZflU4EM4TqM6nLm45ayHuFzKYf7zueStn1AR/9fyF4F1FdPMYXpBKhw9xPVOa+RyHTyT7iNsOqwyG/DSnhMEuDpkK/jSUkt7TmDTtEGM+bKJDpqHhWv7+xNXHZJRqZ8IEY9tygLQa8xnnZq6zHXNvQXSX356HVnGI66FEtYVTsJa+WYG/xVe93q5cAGbKiRaXVcX9ztyHmL2olzXcyE4pirHBa4yzdUrgkTwzr5nQt5a+bVb1pXaSCkD78N3XNzR1cRQ1zVjG3SI2ZQ2F0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 14:02:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 14:02:54 +0000
Date: Thu, 14 Aug 2025 11:02:52 -0300
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
Subject: Re: [PATCH v3 18/30] liveupdate: luo_files: luo_ioctl: Add ioctls
 for per-file state management
Message-ID: <20250814140252.GF802098@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-19-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807014442.3829950-19-pasha.tatashin@soleen.com>
X-ClientProxiedBy: BL1PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8fd9fb-a06d-4966-99c8-08dddb3b4357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oMiBmFvCu0QCQ+C005SPY+ownvnebSIZQZJonfxZcIVMPjeBjHivDq/h+HMd?=
 =?us-ascii?Q?WqdB5PXa+An9sAqK5bepwhI0sbqoIPaPnVap9i5ioS5BmgObrCS7ZfFITpgS?=
 =?us-ascii?Q?ARXatnZG8AQD680UrU+cAGM41wjmtMbPpkKSbciAoFoBhK4T6SDDjV3FNsb1?=
 =?us-ascii?Q?+xWAmu7BTxaNuBHJpOwql3J2sWmYuGg3p3NR4+ZgYi6Iix2ZEx4okrI/Mp3h?=
 =?us-ascii?Q?Awl10vQTxRQSaYR9jX1XVrOp01P0GyQejnrAx+BULhL1WmzvUnAd3ddlqhS3?=
 =?us-ascii?Q?3/AOJ7NEVHrqsT09D/tRPCXQPf2G7bX61H8nt1TM7jTP7qkHaLNJV0Vh2TRg?=
 =?us-ascii?Q?8hIf+zluw+zEJhHQeFn7ohFoPnpEOwEPKLm+R1rhmqMpsII3MSMHeBf1OhjN?=
 =?us-ascii?Q?+r9qaXsuDqbe0lV6rL7dzjPdUCsbGzo/hXDH/b8Bhb11SgNad067kLq6Tzm1?=
 =?us-ascii?Q?2+D8E3ggW1dohzvdr3T2oGcAJJ0Byoh6hXHJZ/8f25oi096VJMPcz1303VeR?=
 =?us-ascii?Q?JlEJYuliGXPYw+nV+ClJckjkKKxHyTJFwi7EIWzCb7YDrlk5MfXdfLJSHAEo?=
 =?us-ascii?Q?SmxrkeWAruZ88mbhZY2c+Fh7+CJM4lnXmlf103nkAF+yfIiepHXxdu+Z85wZ?=
 =?us-ascii?Q?yCHwBhstK+ZTCyb3pRyOJMpHK1A/dXOIkGr5DfPktizpu7hekP8IR42eVnhd?=
 =?us-ascii?Q?Qte59G9rDOFLP2VNIzNa5xj7NI/EV7zWPGbL6E/IMwafQ8lrBHWGAiHqfDiC?=
 =?us-ascii?Q?D1CZ6Z1prNT8glKUUuVObKHm8+mN3sY8RhEuLnP+730/pY0IxGRhAOnebBh7?=
 =?us-ascii?Q?VEo1nXrXmKTsSBshqWq0yn37REzM4DTJuBEAr6a12mhC3M6Pwxzfaev7c1sw?=
 =?us-ascii?Q?RNydvJYU2lhDVnLdHZRmXIjvTogKciWHFZs1HFwYyRMy2iKdZ7TRiaZMp4V/?=
 =?us-ascii?Q?P4WkaDgLARVlbPJ/CsRWqH4CvGuPUVrb78CJjfFqNsABPNx5T6bS9iBiuo3U?=
 =?us-ascii?Q?Rgua1lSOwCWslRbEMKvfwW6vhyXyA/fuF1x7ipdA58qofpcqj6cedfLguFS2?=
 =?us-ascii?Q?PmMCpXznBmxlzsL4ieB4Bra/hwcbvHAuIFYeG+5DMl4bQDaqePOhLI2WJGjI?=
 =?us-ascii?Q?gUEEkJXjIXRbmoWUsLEF3ZT7kpEOAjM2fp7lcBC9Azw/0ycfxsjfO52jMRdz?=
 =?us-ascii?Q?dohbQyml2UQo0uow/8fWFwMNoPug8sl+LR7eKrGqzgnET8dvWbAGrvugTYwu?=
 =?us-ascii?Q?7ROJx/3b8TbtNpvOmUIDOxYk+Ni4QPpkggX456SB5DfxNse5bpPgO4/NKx0t?=
 =?us-ascii?Q?Xm3X8/BVZy8AEQJOnaS5mNUu8vLxAQBOdmGS7kYKjkIcvrTKALHvL033lC47?=
 =?us-ascii?Q?EJhXPkE0AxCyWmbVQxLP4JQNK88Ts+F/MD2TCZECs261/gojDM/C/9ryrf9G?=
 =?us-ascii?Q?GGAQhWVEK/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s3MsgChoxW0lhutlTBgL48qPuAKQ2t8jUZaTOxuTU+DwtREuHRJVlC0NEDjF?=
 =?us-ascii?Q?2eikU6q7j2az0/iiN9zVDqb7Cyqg5vr8D47IuFZO4nRxl/9+1Un7jNwNbC/V?=
 =?us-ascii?Q?WrExTJdx8ewBHyjoxuj70zV6j2wXvz/icFs8EWMmglhxwERIIqiAWzm1pS5F?=
 =?us-ascii?Q?N1cUBacipE1cNr7CfisiHqKSBqiCiJXFCHCZhFs6oljJ9twMP394Y1va949O?=
 =?us-ascii?Q?GZzP7M7GquKi7316Ke3TT0jaXMOIyaJ9k5R2W9UDENpKZVhxFm0CRdYQFn3S?=
 =?us-ascii?Q?Atr7eQS3apybHC3kDN7gaClpRhLDSI07oL3qe9MF4fzuExr54WZ9ANdjHra4?=
 =?us-ascii?Q?VFHkGoWt/DUcTQQ/Z6Bwrx0yuUS1dAxsbZ7col6LpXKGxKi/TMuyerlk+dga?=
 =?us-ascii?Q?INAg786na65GAIgk8bQ0EKq3DJ8LHd7kyvB68WjOO4VhjzJIF5iYVeBUGE3i?=
 =?us-ascii?Q?gBiy3pRQs1MJRzzuEQxOBrRvBMLlNWgKhPN6gGHK078okyd/WrpLEbOBDa/1?=
 =?us-ascii?Q?RNXMFwrWoRpahLVZKsdK6f/dwIN5mULiNvMpqcKQ02x6bTKGaAqtLXIDyOT6?=
 =?us-ascii?Q?HKCc/pN9TMbBwllJcaoT6GdDN/ueLHzPKL5u55vZalJeR4PjksunT6oTnNxt?=
 =?us-ascii?Q?CPAmZhiM9Ot1dm5tiANyCC0n/xtNfFZHZG9dS9cglJ8rQ55b/FzjB6d8NWM7?=
 =?us-ascii?Q?sOsvXN3mR8/HPz4KN5xkkNGdFPN71NU1sbOf1HTV8Ar1BG70XCn96uf70sza?=
 =?us-ascii?Q?SC70hrn5tByk69jDrNnzRrSd3YjdC1opNxIpt5OjYIzbiWV5E/4UiSBqWQDz?=
 =?us-ascii?Q?Z1L+WO4fhhOSXHYOilGR8TTzKvEjCQdNFKAc4nUxbhl0nZ4zOWBughWGpXvz?=
 =?us-ascii?Q?agmDZcDz89Ul7/yYesT2lJBunM/8PS/Z2lftVs6KwGf8L8QGIyCu0LFKmQH4?=
 =?us-ascii?Q?B3RG8587uTN+Nii3S4cvmPCaDCi9PKlJPfhTYMnk60Xwx+O52t0u0OT/YKly?=
 =?us-ascii?Q?8IGDmkg52oPZN75NDROQYz8g4V1v3my9rgOFphhfnPokIqbrFt1BHKxLrDWm?=
 =?us-ascii?Q?j1+TC2GbOMM3UjVb7kTSNE3lONrU6o+6MhTr3ciyW58fBD67UEztcM8oPkWP?=
 =?us-ascii?Q?1iPmVmCia0+ILiW5QHNi5wofbdWs0Q39FWOKns/9KFsNK2iEav5sSWPwarM6?=
 =?us-ascii?Q?zjtE/Wrpkzamo/Ld0a+yWxl3Zs6Ts40q42Wgh4cbL68znfsR2CYdsgOcynky?=
 =?us-ascii?Q?tPFE6BJQCb5V4lH81HpCVsbT3ZWJbzj43245qIOSjj4C4MlNcwsoggAJxBE7?=
 =?us-ascii?Q?IwyMk3zXHz54yOhZmyzIDIqDu5E0kYZSpfae675BcT8VkJvm7xClp/q/UAqZ?=
 =?us-ascii?Q?+BfkSPYngwQtHs6d3e6GtKeahPyzc2QjjvT1NXSdZJZUEqCpLxQEHcXG3s28?=
 =?us-ascii?Q?bwbVVNUQeseYDXTxJvoynOcBvESONGXS4KxjN4YzGdaPZ51GgtW2LlTh29jC?=
 =?us-ascii?Q?UvwxYqKHsZgg+OsrrIzuNQ2r3xDHLjDyibKLza5GYBa1Dewg6fpBfyTabYNl?=
 =?us-ascii?Q?1XTaGMHdZXCbsyLIJM8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8fd9fb-a06d-4966-99c8-08dddb3b4357
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:02:53.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MOha3hvQ4EJrU0HN7JLqgDU8PNpj3JrRWbovUa/NP7+WYrfftJ5z8Ku5NaM+tDd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

On Thu, Aug 07, 2025 at 01:44:24AM +0000, Pasha Tatashin wrote:
> +struct liveupdate_ioctl_get_fd_state {
> +	__u32		size;
> +	__u8		incoming;
> +	__aligned_u64	token;
> +	__u32		state;
> +};

Same remark about explicit padding and checking padding for 0

> + * luo_file_get_state - Get the preservation state of a specific file.
> + * @token: The token of the file to query.
> + * @statep: Output pointer to store the file's current live update state.
> + * @incoming: If true, query the state of a restored file from the incoming
> + *            (previous kernel's) set. If false, query a file being prepared
> + *            for preservation in the current set.
> + *
> + * Finds the file associated with the given @token in either the incoming
> + * or outgoing tracking arrays and returns its current LUO state
> + * (NORMAL, PREPARED, FROZEN, UPDATED).
> + *
> + * Return: 0 on success, -ENOENT if the token is not found.
> + */
> +int luo_file_get_state(u64 token, enum liveupdate_state *statep, bool incoming)
> +{
> +	struct luo_file *luo_file;
> +	struct xarray *target_xa;
> +	int ret = 0;
> +
> +	luo_state_read_enter();

Less globals, at this point everything should be within memory
attached to the file descriptor and not in globals. Doing this will
promote good maintainable structure and not a spaghetti

Also I think a BKL design is not a good idea for new code. We've had
so many bad experiences with this pattern promoting uncontrolled
incomprehensible locking.

The xarray already has a lock, why not have reasonable locking inside
the luo_file? Probably just a refcount?

> +	target_xa = incoming ? &luo_files_xa_in : &luo_files_xa_out;
> +	luo_file = xa_load(target_xa, token);
> +
> +	if (!luo_file) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	scoped_guard(mutex, &luo_file->mutex)
> +		*statep = luo_file->state;
> +
> +out_unlock:
> +	luo_state_read_exit();

If we are using cleanup.h then use it for this too..

But it seems kind of weird, why not just

xa_lock()
xa_load()
*statep = READ_ONCE(luo_file->state);
xa_unlock()

?

> +static int luo_ioctl_set_fd_event(struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_ioctl_set_fd_event *argp = ucmd->cmd;
> +	int ret;
> +
> +	switch (argp->event) {
> +	case LIVEUPDATE_PREPARE:
> +		ret = luo_file_prepare(argp->token);
> +		break;
> +	case LIVEUPDATE_FREEZE:
> +		ret = luo_file_freeze(argp->token);
> +		break;
> +	case LIVEUPDATE_FINISH:
> +		ret = luo_file_finish(argp->token);
> +		break;
> +	case LIVEUPDATE_CANCEL:
> +		ret = luo_file_cancel(argp->token);
> +		break;

The token should be converted to a file here instead of duplicated in
each function

>  static int luo_open(struct inode *inodep, struct file *filep)
>  {
>  	if (atomic_cmpxchg(&luo_device_in_use, 0, 1))
> @@ -149,6 +191,8 @@ union ucmd_buffer {
>  	struct liveupdate_ioctl_fd_restore	restore;
>  	struct liveupdate_ioctl_get_state	state;
>  	struct liveupdate_ioctl_set_event	event;
> +	struct liveupdate_ioctl_get_fd_state	fd_state;
> +	struct liveupdate_ioctl_set_fd_event	fd_event;
>  };
>  
>  struct luo_ioctl_op {
> @@ -179,6 +223,10 @@ static const struct luo_ioctl_op luo_ioctl_ops[] = {
>  		 struct liveupdate_ioctl_get_state, state),
>  	IOCTL_OP(LIVEUPDATE_IOCTL_SET_EVENT, luo_ioctl_set_event,
>  		 struct liveupdate_ioctl_set_event, event),
> +	IOCTL_OP(LIVEUPDATE_IOCTL_GET_FD_STATE, luo_ioctl_get_fd_state,
> +		 struct liveupdate_ioctl_get_fd_state, token),
> +	IOCTL_OP(LIVEUPDATE_IOCTL_SET_FD_EVENT, luo_ioctl_set_fd_event,
> +		 struct liveupdate_ioctl_set_fd_event, token),
>  };

Keep sorted

Jason


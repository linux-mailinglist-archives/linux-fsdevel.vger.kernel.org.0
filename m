Return-Path: <linux-fsdevel+bounces-63783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA3BCDAB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18197356093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E02F7AB1;
	Fri, 10 Oct 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SR7BTQBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA32F363E;
	Fri, 10 Oct 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108542; cv=fail; b=Ikmrwh+Y8O71MwgRz0fE6srtplnHq0IYzzsxWHN2q1R/cdUQWVTtr5CxNR0nhS+CvRP1tSxSmPCmvtB5c5C/K9WoX5QYxvEpccnK5kgltJbkIyY1v/I7AScMTFq1ywwi7ctUAbMkVMMjn7hSCHq2v7l1Ns8iL5rr4XNZPtum8q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108542; c=relaxed/simple;
	bh=7BUempDXgvU/KC/HX66DemGIPH4a3QdLgmZG49vAmHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ktvfNNSC2GVhVKD1wy1u2mhl2fDB0DtqidSq3n90tK15XRRmuk6z6quxP1oIpeoH98nsQz1v4AJOVx9LcWB7aT2xT5Jgev6nOghRyZrF3aRH7mwTQfoxHfZ5bKMS+CDGm++O6Hfx02xjwrSD9ACHgc2ZQgAFWfHPLJxBiYniQUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SR7BTQBi; arc=fail smtp.client-ip=40.93.196.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsOcPkR5zapx98fpCtQjsFPnypT/FTtR3E5m56ufSd9G/F3uPU2QTmPm3/2zrbnv88y9ydIHqe5zUNOMe2expyOndyzT3nJB5E6tE0qK718tufN+66UKLbR8TnKNq3t6WexRJmkABEuaqGSmpZeIprvlkBc+N+ZO+EGamJPCL7+MehUXK4cedXFgvt1dC9qtqM4LElSqgzXGPMjw8d2g6UQ9lSZu1pgPhWCW5Is/pi6CmvZ1chduQckE3K+JX1RaRFn4DQ3hcTiIfdCAH+CojS39zCBkqf3nKPKrxkLoWqDZb4OzjyAaP91mkjG/Zjhw0QBd6RFaxI57QvAAMAe+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BUempDXgvU/KC/HX66DemGIPH4a3QdLgmZG49vAmHk=;
 b=DmtR+N7/Ubpt2fF83dQXhYzAXHaUeMuhX6GY+2RCNbKrcZCqhuWBuvhwmlJh55V7AczP80Td7o/QUCWozgZ//NMODBEBROqkxsZTdscK2UUuajahUwYCmCKfCkROxR6eNzTrPKj0HZqzfKyAyDwGdVmkz33oWIwP7DpZAgzPB9QcmsVfTGVBUIWWvZZhS00g/RItG+tDs5Kvbf6t7Ue/zThsUGdXcN8iAl6nNWOIt/ZAftYMy+tSITXUU4AK3INlzq03UYQvEbqTg0r02+KH5Ph7MGD3vPqg8Pla5xtoSKP85RwfByWHCOSL6MFM69/z2MW90cX/J8agyAj5Cw4kCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BUempDXgvU/KC/HX66DemGIPH4a3QdLgmZG49vAmHk=;
 b=SR7BTQBiVW3sBB+9o7y5fGhGMC1bks+I7PXE9wdM3e0ozPsmREauoMS38UPqOlKcvOyXbj3r7omkan2CbonS5WhFdUPBr25SF3JJHMf5MAVEEyPSm7DgumkmYjIunztLQ5Py1qmktK3JEDH6+P6czvwXPgcFhqaNK+3l3xS1yxcp4ViwStjEx9l6eaMloTq2Ox9PN43XOHFzfsDCjecR6XMmi/CPbjGYWHtgx842tT+S/zMa/44nAabTg8h+al04fZ3njqMYOOPUtoVEM9UvwJy8x5Ja7auFR4hRTeOrFDnD9DU/tdQ0Fspe1euHbWyVHLHiUxGpDvBh85ff/2Dsrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 15:02:14 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 15:02:14 +0000
Date: Fri, 10 Oct 2025 12:02:12 -0300
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
Message-ID: <20251010150212.GD3901471@nvidia.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhT_9vV-V+BBs1_=QqhCGQqHo89qWy7r5zW1ej51yHPGJA@mail.gmail.com>
 <CA+CK2bAe3yk4NocURmihcuTNPUcb2-K0JCaQQ5GJ4B58YLEwEw@mail.gmail.com>
 <20251010144248.GB3901471@nvidia.com>
 <CA+CK2bBxMpb=jXy3-i19PdBHqxLoLrMMg1sOnditOYwNe1Fr+w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBxMpb=jXy3-i19PdBHqxLoLrMMg1sOnditOYwNe1Fr+w@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0912.namprd03.prod.outlook.com
 (2603:10b6:408:107::17) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: fda06e23-49b1-44c4-af79-08de080dff13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2rq8S5iJSC6qggla+nl2VNqFbrWrPDLJxVW9AzHkP7UvhG4YgdnsuqYCMxtL?=
 =?us-ascii?Q?mRW51HWXLKk6ZCRZGDy2nymZygxx7d1EjumpEJMI7cbfivPCa/9HZvqT0cvX?=
 =?us-ascii?Q?lXmpuLJH5zfQh9sWzKozSZ7dgij75PxYx94rWGPw85Hge5tpvj0+D3zp/ND3?=
 =?us-ascii?Q?xV08m0SRTiPsvp314BR2YcfSke4jNtTE2IlEHe2nvzneg/EFVVCqMmjo1Bg8?=
 =?us-ascii?Q?47nac6COUogJ9c6KtnkYGboBkjE5ElW7KSd9dZHpQC76hH0+1sIvjEhc+CMj?=
 =?us-ascii?Q?npmx38HfOqQAz0xeFkkmS8c2kv2tV57R58ZmraBqoxe+h06amNQg3AadzQNK?=
 =?us-ascii?Q?gVL2VDIB33+MRUQoIC0CQ4baMEYPtDm/er4GlE8G6ycjmrvN5xlhR+zh01me?=
 =?us-ascii?Q?xUdjIKZrvUHLOoC74R02iq3SvO/tr4cfCKJH5I9j/AxGUYjQLz9gUKQ6KJzI?=
 =?us-ascii?Q?doP3mtQ6wH+UucHoZ4FGqmIa3fanwC+vxsqQMUXi+WUsZgTUa8JOZyIWZjCl?=
 =?us-ascii?Q?xz7Gjh1Q1L6xmy1TM4bUhU4zajrAVJtdYIEbBzz3IaSfsIq5/WVIIQnZUgc4?=
 =?us-ascii?Q?mLR15JMN2ud4RRVjCqxIXLRveCs5eOjFbdthmdCiHQqYTStEILT9ZFJB0ogh?=
 =?us-ascii?Q?W/AZP7VkTSQkvWqccVPCbEaRPM0btvtmJmg/p4xiv3J+2BZg4sBQpJu55DBT?=
 =?us-ascii?Q?O56BHfZmwd4NPOZMLjXtVVsSVLoEHNhwDC0uY9PVayHe1R2Itb0+KxvZ0NrL?=
 =?us-ascii?Q?Nd5qRmPxxd6Vk4yJHZhdSrHtJC6fXd6n/F1fu+cjoGtRKm/BQaPClGo50HVk?=
 =?us-ascii?Q?wkM8m2uCgMJyF/HDquYB45zleqY4DDoG5fhDZrkbZ6OJqvVygwVLoXZT1uu0?=
 =?us-ascii?Q?BqvNej24h7Bx9eCVb7PkPV48I0V9dlv5yHwxDGF5R29W8t/bwZYBT2l6mZZo?=
 =?us-ascii?Q?ul5G6phNXnwLTRVr9LyOpsd8Ng71IHAUENyGkSmZifLL+pDVcDyfeFGgl1Q2?=
 =?us-ascii?Q?GmzQRFNX0NgLCQ+ZpN35zwB4TGMS6qlzX3OQfoxDG9qEEoD16AGb31USNOZN?=
 =?us-ascii?Q?6O3rkecuH/hmbya1yeDXQM3C4wxmU0ZdzdZJsCOrnMB7AEqIUrhUw4iUZEQv?=
 =?us-ascii?Q?GVA3xKbsTXClRP035Ahj//ZUpYSfvrjsu6e9GglBaWlmnEz3IfqapvseUlX4?=
 =?us-ascii?Q?zWWAcnt+udYUORhUBnhtK6knJI549u+SruO7ao+ujJCtLMGUuGm38WObPsHo?=
 =?us-ascii?Q?4krxW1nVjnr1XZoKpyKK/QYKnTR+Pi95H7dSiVdBDlh7PABRuKdee+BGz4iS?=
 =?us-ascii?Q?EniPcPPzo2ysIe0GtWZMYbtKQUFpvdMZVvWcyeX6fk/Q4jCU1Zbxv3WNRU1V?=
 =?us-ascii?Q?MshzbdhmYeP5rlPcVjxBExDYQxF+T4RUxy8+z8CDJwurCNhBhewmx7+UyKeC?=
 =?us-ascii?Q?Dkz9QpTZIOpee06lPIUjgIwG47G5z/Hk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BcZv3hE+4bqapUeZqRjBm4WXpnomU9dzSPbRWzFM+I4IUz5JMRolBhJVef0u?=
 =?us-ascii?Q?AUEaWaxc1VYHk7a1OriGwSGq9vMQrk1jFkYMOWCqz+qEUFlxgvZafbtK6/nG?=
 =?us-ascii?Q?m6sk/2feCCYEJu27BgnR60wuKAxONy56kBH+6dlCmr9J5G98glh1SNipIdIC?=
 =?us-ascii?Q?dsmmf4eL1T2g9RTNHRqJ/QFbiZySS63qzlHQJzlzFx4+4WaHKJoAC3iKXOT1?=
 =?us-ascii?Q?SVd+WBVzuAkxi/wIrx0Is93+8SWf7NXuAk+3u9gB5YcQH7t6XMc/vxcRxl2/?=
 =?us-ascii?Q?frsMavyzud8PJG3vvBO+i1R6DJQiZ0k+WRzGFxXBYm7pTjaULyG3J16rlLgJ?=
 =?us-ascii?Q?MwCozLog8ytWFBsp1GCn0Eb5ZiTO/KbNLQA2Cs0OLYaSWKjkqkpTc4t2aCoj?=
 =?us-ascii?Q?wqxmU8V+FCkFSO+teAQOJ8RnJohCbuRxEp/+p8RdwEo6i6P/tUz8TU7MoUIa?=
 =?us-ascii?Q?okyRiEXeY4Q6fnxxVERNJKPhw087h6gQuEVvs7I6sTS4eDA2E8uUeEgnbGhf?=
 =?us-ascii?Q?HM9hZQU66OOVp9acbFoFhX5ifBnSGUCtR1aBRgUwLKbQls2YKYVRUydGIGSt?=
 =?us-ascii?Q?PcsfqVViQUSA2kJJm/A0zCkJeh4bxNxryh6iUHmwmwZnch31KoDBhDxZvp7e?=
 =?us-ascii?Q?we5AqpW1NeAEUIStD1JRgArVUM0FR37qsjR+pcA+mjMCFH0E14XTB/OFAx6J?=
 =?us-ascii?Q?e3LOTQ9noaEcvkqudgrS3keaPEpdqygEyjOsePJQEXI9nBOGcXoILjYY9d/c?=
 =?us-ascii?Q?ZzBC9JZgeDfEIo9V74r7yfLOcskLSkw1Wt+ylaN2VyricbOMRwSg5hT/EVdT?=
 =?us-ascii?Q?oX/Hc7up79UUj+w7CvQ6jHX3rc02Jk0ipoZ/7h18G1BmeDYc7gAhEXK4RLDm?=
 =?us-ascii?Q?thYQgSv6ZVOFt6wwYofBh08HgGhEvz/O7DToOO83uDPPYtrgx1Bi4HbXAbYs?=
 =?us-ascii?Q?cm+uOlualSJjItcYrD6KAcGOMFazAcVfbRt16kUhMg4GMULbCDNP2r9BM687?=
 =?us-ascii?Q?PZ0TM6RiwK2EOTy2z+st8vpN6C+hx9VrUrfIyZVhSadroBBlfwQSZ7fU3DSf?=
 =?us-ascii?Q?G5dhWfqFEXc4H2LS466jHFQJIe9lWgnawG0slxVGCmMVl9CACfVAdnCM0DBh?=
 =?us-ascii?Q?vNKTz7HOZ7qY02r78gnevW02oa6swospq1UInhoGpsaXtmHGuIH98eJxE77E?=
 =?us-ascii?Q?QY85RkldadYWSz5PMyRcHlMTOS3MnX8VOS5sLVpTOUikPBGHEx+saa1N1qyG?=
 =?us-ascii?Q?k89djNa/GCbh89ZsRyJZP8qbc+sHRiOUOO61tGknofM+CvRWb48k50V7lqVP?=
 =?us-ascii?Q?sAc0jf7fZ3YpvnTtGLbLDLaKAFB6QE/nGhabh6cRTtiYn0XJj90OP0eVFQog?=
 =?us-ascii?Q?wJxHBlLx5Et703cVu4b4NGMYbVO6xBrPAOcAtv1f7cKiGZR6hhDbDDcuQQBT?=
 =?us-ascii?Q?HBKXd3K1kIkXiYgUwjmkt64ZPNUVmKzbCd8L7HZLe/x7wH5YXvt1ckqlbjM2?=
 =?us-ascii?Q?pq0Nicr63U99uX3YysOPQr5/yGFoqk+O3uA4/FLHbKrtu53VPeFd3px3+521?=
 =?us-ascii?Q?1K8I1NMLdQT9o2Y68sg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda06e23-49b1-44c4-af79-08de080dff13
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 15:02:14.1856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kosf61oSxG2D+yFgkqCNcO+V13BLN/M3mNP/kYXHIElS2lQ30vvdstnTVZP8ZmRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015

On Fri, Oct 10, 2025 at 10:58:00AM -0400, Pasha Tatashin wrote:

> With that, I would assume KVM itself would drive the live update and
> would make LUO calls to preserve the resources in an orderly fashion
> and then restore them in the same order during boot.

I don't think so, it should always be sequenced by userspace, and KVM
is not the thing linked to VFIO or IOMMUFD, that's backwards.

Jason


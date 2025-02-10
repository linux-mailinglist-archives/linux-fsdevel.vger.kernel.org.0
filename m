Return-Path: <linux-fsdevel+bounces-41347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94812A2E2DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 04:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D6E16162B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 03:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B809126C02;
	Mon, 10 Feb 2025 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CiHXTsjV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA68EAF9;
	Mon, 10 Feb 2025 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158530; cv=fail; b=YxfxSSsIRHsFzsf0gAq5t8WWiL+Zf6Gk++yxx+Z8fSBrBZYiVJ9HxQjHrAPAgsWSmNaPiYpl+Y2TcIpSBndE+JyPgVpdmm7d4nzWF7QSlkZjBHHWNV+NfwMJKpArfnXRUiJUtZboTaDrHe+jJ1Yp5vnoiJNnX3VwIXlq7ghw7tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158530; c=relaxed/simple;
	bh=7M4eqT2jo5lao6Xijq66d+7dbjxdtTAQzprMEFhFLds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GyItDyL03VINXH5ythKglzH/mgONaDinEjE6QxY9wtUHFDGNoUzAFpexaa0YolpRlbjhTsrW9PgHt5EFPbgH/X83EcjW6qWkLTcDqYTFA83sgq4IdgRCQI3IpzKVk0tPwYlAdhogk47L+mxD8OSiEJsxSo/3h7s5umrRERTC2eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CiHXTsjV; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcN0WzNr9wIyVs4y4kZFAo5P0q00u5VECBkCzIPSP7scnfa79Qu1LAvszNfYVMO1R+kEKJOMi44ZTdDH4XAfxdzevapFqlIr8B1WboJV7hTIeyc4baYsFhgA8xavboCFcyW1Mw2puwtM47rr1CIRHyyMsPl2ByZ/UI0XO89EvrYW+DI+D8XRIo/uuATNWIBGifx/r2zQM3xUzzyp8CGGpViI9ShvG67kUUIrH8UZgprDxO/ExI8N/HRGq0x/zY//awV92aA10NlNhiDOGw4iMvYkaCq5qFPB1/1m8u+Nnqrmm6eCosJKDlL+9AScPqnaDwln1fb9NHL3zajHTeOP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M4eqT2jo5lao6Xijq66d+7dbjxdtTAQzprMEFhFLds=;
 b=Qt93iRBD61gpYLph7ZCt1lJazUGkwoPivXvgb728NXExInNjgeCBvmUyfOVPNNeyMnnpzVYFw/wGa4Q8pyn38t/d0jvDeXVCpzRo7zCWdyyFZnXrXAG4r6UsNoH+Sp3TQfA3PLbHPkUXf83iZA0t2ngMq+4wI8cmymy308eHQeKFYEVUkZ+TU9tXDIDfzzVKghkD/kQ1uZbv5l/iYuaw/hkYV4J/GDqnjwLmS8zeMHEIeWp2lDC7Ht6OgG7RsksWfUVTELSYjJ4VvcbXcoafsvNT8bq1Qq7JgUcRoz7+tzfq7brXpWuN1hPpdInqGhKNawvG1x/lLVkpkLiny2ygXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M4eqT2jo5lao6Xijq66d+7dbjxdtTAQzprMEFhFLds=;
 b=CiHXTsjVeUwJ1/wFwmpK2c5viEdj47dpHsIhUXCGHD8e5Jt4izPQaO6hwsa1/NqFlGPW0NuvMNiNneasISPG3+cIYIQtC41+SPSYg5eEfcAhafd6GjqjRVq4cglkG89gcsmSc77qFNPJ2Ul+8D5qqwqLNIe37IPC0DB1wd0DebEUunzndGGesYVzHkgMXeT+TVj6YaNjxl+7jCBkK9zZSxSMwV3w8eQSuFc9E/K7a9Ld3WImp0FcBvvtkb5xURbgOvWuwP6tCvDWaR6vd6W7KQzB2sbwe7FwzyNOZAeaSQvGVQQRcSGQRlAt79NuzicfrGv4mERbEeSpFGAA/ibdWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.26; Mon, 10 Feb 2025 03:35:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 03:35:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>
Subject: Re: xfs/folio splat with v6.14-rc1
Date: Sun, 09 Feb 2025 22:35:22 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
In-Reply-To: <Z6aGaYkeoveytgo_@casper.infradead.org>
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
 <Z6aGaYkeoveytgo_@casper.infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0497.namprd03.prod.outlook.com
 (2603:10b6:408:130::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 19157f7d-7f8f-4772-21ee-08dd4983f501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eCZ4Y7QkOz4HVWVPnwX1gvK2GelmsZu60Eya5hbkKUoJ+8b9hKtdG76QbNev?=
 =?us-ascii?Q?LNuVCfUGAOJnzR+mfzU8FzRDYMELsB5E/yC9eVCWye3s1JZbG7ssaFnBfJ4q?=
 =?us-ascii?Q?BaxARSwaJrjPo5yOR5g2zH1xPRCEO21D8BXOx/zfiRhXeNwi0aaMINAAldo5?=
 =?us-ascii?Q?Z0+L9G7TlMd7keHwOlJyAMPwCxbMOEMzBGSyc6WJD98eRWUCSL5YzeeRf+gx?=
 =?us-ascii?Q?RpPWqFMqS8+q5RX59acArp9QQ6hvb4vWkhroXwCf5ZG29ptOHNADq7TI+C43?=
 =?us-ascii?Q?sccH0fvzNTxNjtd9Olbe5kAVwJe5Cp57kSAdaQS5W488Y2vxgkAyE5kb7nPB?=
 =?us-ascii?Q?g9d/+4SNtbaGgBSWuYrO6gQgZOoOuG5AFUABVhrXTDFG9nOAaD0w2Zy2h2vo?=
 =?us-ascii?Q?fJDV3YM1WvyDvaKvqrYUSvLBnrUETE9prvwvgA4kYoumbpAU1sn1EJAbfLgk?=
 =?us-ascii?Q?fosNunOz/4UWtSvDByV0p7xbFt3fYrGVatgaGuHpMlAlBQ0FBm0Z4Imha/eW?=
 =?us-ascii?Q?120rrUp8abD+b16VQ2FI/qN+uamxIYSIwjTJ2fpnQot7kWEAlFmczbgVD/Qh?=
 =?us-ascii?Q?DAqR9MztoDlZgegyj7rXNdrU/FWcMvtb2vcewohnukQdKpsZN+HPvqc/hNZV?=
 =?us-ascii?Q?Yv5UqZF+e5QixTMdyZ48xC0feW6CJcHu29tTTAIWPKgEkvrkxcBRFnd6egIH?=
 =?us-ascii?Q?YyxDjAa+yezjR9gIQ1tq8KKiUh1YU8P76WucJJOwuafahHycneGwNM7Qkh6f?=
 =?us-ascii?Q?nUBIkp0KuuqOoLnl6FkSMhik8GCy3Q7le2g1bwfJ+eqDqoidj25ppDt8dtGi?=
 =?us-ascii?Q?KRp+u4GvYTjJKaFYdgRQM3t78p4zBIFWIT2OL/DhQb/+eIP4dFCEwhw1uELz?=
 =?us-ascii?Q?Ig7qhL3+VuUDj2+ilL6wCZA4xcQP2OEOs5WX2cqjz5X+Ay6gd3Kab6sI3M1W?=
 =?us-ascii?Q?hrJ1kA2ONOP+sxlZ6o5RB47ByARqsAJvwLFcJ6xMIBxU4t0b1zum9v6GH8/q?=
 =?us-ascii?Q?lF7Rvx+P6nhhbUPoNHlVgPOWXWRmI1RUrHpfQjvYPrcrUPytYpwl7ZfRhica?=
 =?us-ascii?Q?kLiYucb+eaVEuT5noZ73u5ZRkzNXxnrIt8dxwp6ZIZVK7SQcCRf3TbG97UQd?=
 =?us-ascii?Q?710bI0RtqumQAnNAgzs8Gxd2TxC/ukIdEf9zf7Ruh26KosTgRXP1s0o7sy5E?=
 =?us-ascii?Q?/0u0V2MbfRUg0uSKRfht1X6l2fn/umJF/mEun8wRGk2fdNOTOPRWzEJ4hvyK?=
 =?us-ascii?Q?nBsZPjKdhoOrEvROKJ7U79lpVi+0948v0NJbFLD7zqCdZ7D6aUBa+cBM/26f?=
 =?us-ascii?Q?XWh0oSo/q3ln+0CGxKtBA2KiY6BQX5uZDQ8+2AnERyJmr8iJlfH7aT1/rPec?=
 =?us-ascii?Q?KoVPJ35cKCrpC/6qXZ57PtuTkCsm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BrG33e/s4NOzK0B4RCuoI7XAEy9V29OQqE0az6z5mXuwyIXLwgVcboAVfgo9?=
 =?us-ascii?Q?b8pZbWWzBzsbeBICThV2pm1jnOIMnGjjRC0BK672HommE8UgoRl9iBAjiWv0?=
 =?us-ascii?Q?QYfJV114wmGurEikgZXwNjPpP1bWLVwG+oG5iFgajWQw9Q/DPd5QvOhWorOh?=
 =?us-ascii?Q?NKKgM6YY4XLu+7mnkk5gkGlzIlq9SRt4kjd+GlX/oYRAj5EKgSHg1dWTeE+O?=
 =?us-ascii?Q?5CHHE5PXcMPW0c1IBK6mLDVqQij5/zbUwNF0TEdmLM7GdVJr3J0C4tOFupUh?=
 =?us-ascii?Q?6s9pr4J6/FyQu0CEl+UtwmKhGwo4orhuKP27+TScuLimqtH+di6xg0bMAbjm?=
 =?us-ascii?Q?ms76TtrF5GFJjDODDuFIoPMchWKB59Vo5yPKesweNibJ2Yo3la9fyx1SE8zx?=
 =?us-ascii?Q?qf8FhHT9xqRU3QBzN9bvO3O9zZVp7+mEC/B9t9Qu8r3spWef7MGCsYSVTIoQ?=
 =?us-ascii?Q?tisYXyNE/ahkt+zbmGVFBg+iLOuXSHYbeY792hzosI+U/6KY9yHpIKJKNLVs?=
 =?us-ascii?Q?SfYcRPiUCCXOiVN4GCcVFPRRASAuJC0hYr3ae2EGgPzBYHj54ebKv5NaygT3?=
 =?us-ascii?Q?6wQgWFHECGu5JsjcdkIi23Af5wBxd4iLdUXvEyqQ7JpcdICPYAESoCSZU3zh?=
 =?us-ascii?Q?PIjGNk8Z89Sxlgix2NyQzfEjLxOm+M4p/mR+Y9OVzq0kVdsId4rfWhhSYEg5?=
 =?us-ascii?Q?idWFaQWbAoHBnv6jKQpbAWZNV1ibGsOrnACebFpMQiqh5Xlf7mCwB2xlidtI?=
 =?us-ascii?Q?abiVHxLjc3uDwwZ84q+uuK6518lr8XuhaF02rmsiH0f9f7iMQVJuQDYi5RSd?=
 =?us-ascii?Q?fdHiPuhh1QaHWDTPQCn4IVZZERwN1Xf++MhrVaxH0gNnz4GgtfP37Jg5Kk88?=
 =?us-ascii?Q?+DNllOt2NPs50wEV8fnJa3SOIdWvNY8Ya49I3HRbGnQK0D7BRg8aly3oWgaN?=
 =?us-ascii?Q?ev+RizbIhIUGKYil15OqQjmsf/FVV+Ocx8WD5eaccfu01NllpUlVaXqSH2Xt?=
 =?us-ascii?Q?VErCm4Hf7mqsBTPi4BFdhT2vz3DFBBunehFkLS6AR1bca54KLjeUcWSPJx9O?=
 =?us-ascii?Q?CZU7iEp1X0zO363lnWmvZzoRcI5GAqlKk6Fjif6HMuI/gI4PQsv7jpUzyOP5?=
 =?us-ascii?Q?mePEB7s5LpQBgf7GyZDKky8suVdoZRCxVJ9SiuSk+QGQYxfmQf+J0fIGrshl?=
 =?us-ascii?Q?EB82G9BWCwH/W4Yg13azbxrMVj+RYpFOJbPAFMNoopeVoUfwH5i79dXDQzft?=
 =?us-ascii?Q?+HEXGGuJEYnZpywMd4szUr82vKgPNYE6tWPycIc08rjXxjRUSDLuy27nw7OO?=
 =?us-ascii?Q?PD59/pemG5dLJ+HtnJZsL6zPJ+gk8mgNC5uxozZbV0wjXS5Hq9ZbBf66nx9y?=
 =?us-ascii?Q?d4eK8NIH9rWdCPNKjt9RZUUQruGKcnPKRSJX0uT8YkRVnW1RBVRu2087ceas?=
 =?us-ascii?Q?cvRddZwsQzbqeWVHroMdeHlVo126dB3rbP+Jrg41zJczJgG7DuanZ+xueLkl?=
 =?us-ascii?Q?wLYEBUByqWhdQM8oriP/b08ldNsyIeQtcUeSJcNS1roAYthSt7YY5KngO8pK?=
 =?us-ascii?Q?d645edNvApm2E8yIRjI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19157f7d-7f8f-4772-21ee-08dd4983f501
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 03:35:25.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBueknxA7Dz8lQT2tMW5Z5Z7n0vVg2Rl7f88wD5JNzTYtaN7xYvQTfyt1b+VwtIo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281

On 7 Feb 2025, at 17:17, Matthew Wilcox wrote:

> On Fri, Feb 07, 2025 at 04:29:36PM +0100, Christian Brauner wrote:
>> while true; do ./xfs.run.sh "generic/437"; done
>>
>> allows me to reproduce this fairly quickly.
>
> on holiday, back monday

git bisect points to commit
4817f70c25b6 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64").
Qi is cc'd.

After deselect PT_RECLAIM on v6.14-rc1, the issue is gone.
At least, no splat after running for more than 300s,
whereas the splat is usually triggered after ~20s with
PT_RECLAIM set.

--
Best Regards,
Yan, Zi


Return-Path: <linux-fsdevel+bounces-68631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAEFC623BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 04:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A9164E1A9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4A313264;
	Mon, 17 Nov 2025 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O72U+xE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DEC1EB9FA;
	Mon, 17 Nov 2025 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763349696; cv=fail; b=ZeSc3lH8CfWwok8Ojytob5M82ihsyx5RnYLRuHPRcaPsJJXiJQPcJPdro+N6Azu/RFbvTY/I9MXgAK5Ws9m+ugI310No7DM9bZsyc7qq/NS2joNrt0LSDkAGHb4eM5WW/EAQ/i6esDl26RyN82h7SIP+CXe/ivotilAelD5m1bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763349696; c=relaxed/simple;
	bh=lNKHZcLAx6ZcvE9PgZ9KOm3Iu27AzVx+CJhIahp2FuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pElX8ijAQX0VyJxZ90iMgLBL7OWrzUaEWnK7jRAgzOSoBBsuqaMV/WRhiCtNcbsfiftZ7iVXwXhjdpHY/ucyGoWkqaaNgu7hBsc47TfXvyO7o23x+03S3p01mknu6freVzO/mynYbBH3VWD6MXg676erSWmvzmsFCuMHPgtXabo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O72U+xE+; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0ZxG25jb0I7CxnZldK9rSYwNGAm9p5BgQcjSIfZEKhzKORkoErS+HgaQG4w3VnVoBbObk/YyaneNnRLe0jrRF6w+UfrRLJ6/G6g3SQZf3HnG4/B3Uoskxi1PH9vTcN/P+Ew278m78AyY8breXDinFDiVCp84u00GguMEmG4KPy305kqHebcQJ62PMASYOU0J2POj0WkTuKa27w3iNP/1Lnik3yFIqcvFNBRoEjpqb+HCQ7WQMEOwpcvrUSo+V+jKsS6o8i2qFdawIX/lYQB2ZIPPf0bP8IeEIjSbmRuaCBijQ0fLbVlx6kb4F8dU3HUWXJooRdNQCxZZIpsvHARxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vndOqI5q+dp2MCnA0TblRRSFWK1e7arUU4YF1Qfmsi0=;
 b=UYits3EJPHFkp8L16Hz7ZTvrMcZ/3tXo0HH58CXGdr6pNsuhuTjOWI+O8xYDz9obipl1/dP/o9mv9lzzmM6U9J2RNeAA4d0wfL9vgFLYayQSRWbqMhVxrbVrpjOHSt1oPeUtUUUykcOFoNTKbflhYqz2l2tbTAh91IyhNn/E/SWvSe2673Ok3hnQcOQP9AmkJGrofmxkefcAzXl59yXv2NnbW4t4VFMhERhKmiBwUHNuty5AQn+l52uzASNPuVsiwuGxqECTg/GHFm4blEfmULFO7s5kM1eyAmJkZ5ZYjJo6xNUrbdoPRSGUEN3OwEnCeGlEAjCULqziWmhBpOkO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vndOqI5q+dp2MCnA0TblRRSFWK1e7arUU4YF1Qfmsi0=;
 b=O72U+xE+ZSFhSkPdvpDqvu7F6TeY4kITbt6uwAtaAC2LMAVm1uyxFKbGugKhqgwRfG4orVcdJx6NWurGywu3TaakmBdRDLJwl8z/FBxEuNyDHFC9NZ2QsdETobJjb5JFGRhSKCyoip9LMqUxbyO7WlNVNEW4X5RsDguRjSkXLKKJuUPWjCPyvEKDlLZ8yx8pJbKrp+bH4wnmqssBihnV4JE6JntV1Qqgqu6Yl9xceMwClFe0xwXGOp8qG++Yb1Zswk74dUJue8fDKvszxW9JqcM9lF27/dCFUOXRTZQbhVUkoP4epdf3SfchWQ3/X1/svP3uJ8/fspJXqYrGfyfWaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 03:21:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 03:21:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jiaqi Yan <jiaqiyan@google.com>,
 nao.horiguchi@gmail.com, linmiaohe@huawei.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, william.roche@oracle.com, tony.luck@intel.com,
 wangkefeng.wang@huawei.com, jane.chu@oracle.com, akpm@linux-foundation.org,
 osalvador@suse.de, muchun.song@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce
 uniform_split_unmapped_folio_to_zero_order
Date: Sun, 16 Nov 2025 22:21:26 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <4C3B115F-5559-430A-A240-A6A291819818@nvidia.com>
In-Reply-To: <aRqTLmJBuvBcLYMx@hyeyoo>
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-2-jiaqiyan@google.com>
 <aRm6shtKizyrq_TA@casper.infradead.org> <aRqTLmJBuvBcLYMx@hyeyoo>
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e124c2b-36c6-4b69-418a-08de25886649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HakTxN15afcE12us9MZEvqyk+ZE+x2VA23Eh0gjpMpE1eDOiV66KjFZ5hDm8?=
 =?us-ascii?Q?Hhxpij/twQVhHabkSTePWhqjr698UAKTKI3SAHI0QV+7juyQDaThYMc2bmIB?=
 =?us-ascii?Q?rhQfyojHTbFFXvSjNoQ2nY7L/hV0/iFtRlfNknZtvV9AZoJB1syL6SiJQAqH?=
 =?us-ascii?Q?wwn1eja6AW+XgZITqraFhNt4viaMjSOqmWmvaTqwdMm3QFcy1LhFZBA/P1mB?=
 =?us-ascii?Q?7K6S1L2wlPNCIdIOIWKqKeIPENBhf80jgx5yEKDSiLYd9WEe52k1Tvrqs1lj?=
 =?us-ascii?Q?LX9nJWxtu6+wTc4IpwT8yA1xSPn7kI+9mru7xmZ4Mnx4MJszo9yogISwKpY6?=
 =?us-ascii?Q?3bwMShdtE9fx4/zKNc+wiTtZUZxXU2OhVKkzd2/P2uJ4TQyxheXAHMQk0Xvf?=
 =?us-ascii?Q?j31yJkVhNwKvuGc2ghc8Z8rXLazrrzXhdjsjDhBNWscI2+A2VGOO59ZYihey?=
 =?us-ascii?Q?pSZqA+y+Dby7DCwsHINyHiuRqD/gwaxHn0TfSpt8bcpOtQIiRAeExD9WEihL?=
 =?us-ascii?Q?0FsxyG1gWkM4uQ082fC9W4L80LOXjH4KD6ovrFiaGjHonUD94+DRozG+s1Hx?=
 =?us-ascii?Q?ZlJ3/vbt/DeTxLLBq2Dt/Fky2mMXr9+uKLr0s1mdzM9sG4S256H3X7zYe+7H?=
 =?us-ascii?Q?g+UwL7ie+5didpofrYQOCEC6b9ihJiYS5qwnRMjHUi1kbUMUv4RVldxztVBQ?=
 =?us-ascii?Q?f3c+dJWGQanI7zBr1T4l6jiTzl+fiH/Qu2xr/RxKIns52gBjEG0GKKyXyiUw?=
 =?us-ascii?Q?Yx0FKRU02qRbtg989V5g8P3q2PUpbSihGNduZlCC0tjFSoklpIVa38KXj6Xc?=
 =?us-ascii?Q?plzA9kWpjjoYaVRiu/LsuB2XjLdJ7+9I4Qk+mfTyEadnQ6LdefH87LraaNJb?=
 =?us-ascii?Q?9t4DvA7ZDDvsbCE/sgSzIFIIt6HPb1z8I9B6lqMdK2ZpmwAneMrvgJcRlq9g?=
 =?us-ascii?Q?fMvJzGQwxSd/0KuVidMPy/ouoR1ivK9FPDxdYOeBtfbCwNCGWWc0NHToihfx?=
 =?us-ascii?Q?RLGLVCCsC0ryGeLGt+zsNn4JavqYj8HpYTvcmEAO3NKbG4rkmvLtdDdHe4lA?=
 =?us-ascii?Q?VlTaYUZg1mhev3EPV6Jv9J0vREW24hmX9P2mLDlvh822o5WGuwd144xeS1zJ?=
 =?us-ascii?Q?LUqxJmp1KyQpsDmQxqFkzikCfpAcKmK9hu09fsf05ZSNa1DBgK/ohpnWqLfW?=
 =?us-ascii?Q?/u2Tneke8dMuQANFfCFYgJ/KIZz8Y7yyWKI0c7WQ5An5RDjGCKEicFr0pf4A?=
 =?us-ascii?Q?9mlOSyB6ZLsDEnaf2iU2XY6UVgDi44Ur9wajSkdFpt8bVV6m3tG9y9tb2HWX?=
 =?us-ascii?Q?NJQ2GwUkKV0jP7qIfZum+7ZIsQOwtdfi0jGFryXG//tiimdgur9+xySAmXuB?=
 =?us-ascii?Q?eAVAhKN33mqFVbMot9X+HjfqKqc2+V0/weRtjZfRpaxoWHENNwoDuqE/jGlL?=
 =?us-ascii?Q?zIdm7fkOUcDRN4v560xSMKc9bYu459Fq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T6Gsxi0qgZwZ0jV5PfIi8He0DsLGtlDkJ6kD9PGbQJiFViSN06cnFhTrdODG?=
 =?us-ascii?Q?omfzUKMb6sOXV+GYguAAM/cj9vo5mbJzzABJsFwev0UxS9FRBGTIr0kI2NqS?=
 =?us-ascii?Q?JDbEiC0GTunRASW5cKDp4xJYqH1tvX4wV958IB11otv/mugkJI5USd0D9rAN?=
 =?us-ascii?Q?3XqDxYamHmgb1NWXV27QxVOCcw7zsPNqX7Pli/a6OZUzZQtLwdgYe4k8Z2K9?=
 =?us-ascii?Q?UjyM9X+JlJR/HP+qFzdzvnsZ5SPkqlnJvkH9bWb9R2kk73jwk08N0CXlW7+8?=
 =?us-ascii?Q?ZXwQFb8y7OPBp7eKv2NWbuwNoTWB83CdlaepqzDkh9ChPpBM89B6VK+OcED6?=
 =?us-ascii?Q?3C6680iN/k65MBR1x+Q7LBDuO2OjyIwxXEOJiZ2qwfpatxeNjReNj4zoEJ/V?=
 =?us-ascii?Q?y4Sz7+LjbUf1UDrS5jZZeZmDaUDOZmxVHQTogoBfEBqoGmZk+YVXTDAefewG?=
 =?us-ascii?Q?ajELDPbKkHdsq7Of6e1zR1/sxawr8zw4T+jpY8ES2OHvF5MhbT22wlBnCNWj?=
 =?us-ascii?Q?tBAu2HJVa5Jo+a+6I+h7CxRZbNupfmxGapyCV5oLvFS/qJXKjvO0PgGGHXDr?=
 =?us-ascii?Q?Fqm7/25zN37LpB+jVY2Cv9GI2x/xC0+LxGAEKf+A/mK0r33Rm3UwD5bz76ow?=
 =?us-ascii?Q?nGw+MPsnG6wqH2U9FFAM6WSwVFh1fqPBPWYvvG1OCXiEWvaiV602WuPLua/A?=
 =?us-ascii?Q?nL6Bch1WT6HuzOuAFEcSt4Ae00TrEZA/XMsWLWlc9oi2sbNd58CoSJUMSIdy?=
 =?us-ascii?Q?dGROkNrv14Z6lyDthGivcf3MVGXqO8ivubZ/O2sUvgZivXXjkOyS23lEIgzl?=
 =?us-ascii?Q?6M7N7vfHKrk2WLwU/MznCASur0QpWIoHFTMLw4FeOSKFT8E+NcbU1cmnSjGX?=
 =?us-ascii?Q?mTYDY4QBNRW1uUlnU3q/25yLMV7v0NZSsDFQYoer7jbJ9sZTO/gbgXrlsmHP?=
 =?us-ascii?Q?lotN6Ji51Df04ljLZm2htdUrPnoCYjLFSd1Dfsmw8dRxgMksBNw1Q/YZYpus?=
 =?us-ascii?Q?xy6hQKCIkcYrdhREI8QmFEYs3qsy31dlEqiYwztHhzQd7cuByUCL0xi0OSaH?=
 =?us-ascii?Q?FQ9tdE4JlGj2R3XIkGULHsWoWr3YFiaxA0DXB5bkv3ugcb7IscKI5hbjVYv1?=
 =?us-ascii?Q?jbK2gZq4ESuzrjhkVM0A3JyFSpcS01bDLL+FyGHKPnrxdBQU3DvnCp2Bwgac?=
 =?us-ascii?Q?gb7xiqM9tFNtbgK4PqCakVIJG3E07RtcjQ4m4KYE3dhbLN2mOPnLBJNMOac2?=
 =?us-ascii?Q?MaUTyOKcMdC/X45ykkopp6yoJ7fkeRwNo/tFcHgzrNev4U5z9OIBi7xLu7Z7?=
 =?us-ascii?Q?Sx7eUUUyl6QMUXUfmIYu2naim5r/bzk/s+6aToa7zRlDNa+Y1lInB2gzghJK?=
 =?us-ascii?Q?XIUUrKqk3VGr7BU3CNu1tFtehazjh9drft5L5XQNqKGH4ZwP+jXKmrM/4wc0?=
 =?us-ascii?Q?xxYISENgFrpCKE01gesVYc6zNTXmvT94WdRv8FfaQdat5Sa7V0g+ygehuNvP?=
 =?us-ascii?Q?tw15/kwkbLflPa6G7L7P2AspBL8xC1hgAQ64WHPSUEEA6krejIVDOXBNL2EY?=
 =?us-ascii?Q?KZsZybSEcHkIE7Gry+OMZNYKIGtSElPLGeIkCg60?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e124c2b-36c6-4b69-418a-08de25886649
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 03:21:29.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPbv16O2qAZlxthKPEEXjieOyqq8HepSmGEpnHJ24GRgjsKBpIoXQRMD2zFxs6AR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

On 16 Nov 2025, at 22:15, Harry Yoo wrote:

> On Sun, Nov 16, 2025 at 11:51:14AM +0000, Matthew Wilcox wrote:
>> On Sun, Nov 16, 2025 at 01:47:20AM +0000, Jiaqi Yan wrote:
>>> Introduce uniform_split_unmapped_folio_to_zero_order, a wrapper
>>> to the existing __split_unmapped_folio. Caller can use it to
>>> uniformly split an unmapped high-order folio into 0-order folios.
>>
>> Please don't make this function exist.  I appreciate what you're trying
>> to do, but let's try to do it differently?
>>
>> When we have struct folio separately allocated from struct page,
>> splitting a folio will mean allocating new struct folios for every
>> new folio created.  I anticipate an order-0 folio will be about 80 or
>> 96 bytes.  So if we create 512 * 512 folios in a single go, that'll be
>> an allocation of 20MB.
>>
>> This is why I asked Zi Yan to create the asymmetrical folio split, so we
>> only end up creating log() of this.  In the case of a single hwpoison page
>> in an order-18 hugetlb, that'd be 19 allocations totallying 1520 bytes.
>
> Oh god, I completely overlooked this aspect when discussing this with Jiaqi.
> Thanks for raising this concern.
>
>> But since we're only doing this on free, we won't need to do folio
>> allocations at all; we'll just be able to release the good pages to the
>> page allocator and sequester the hwpoison pages.
>
> [+Cc PAGE ALLOCATOR folks]
>
> So we need an interface to free only healthy portion of a hwpoison folio.
>
> I think a proper approach to this should be to "free a hwpoison folio
> just like freeing a normal folio via folio_put() or free_frozen_pages(),
> then the page allocator will add only healthy pages to the freelist and
> isolate the hwpoison pages". Oherwise we'll end up open coding a lot,
> which is too fragile.

Why not use __split_unmaped_folio(folio, /*new_order=*/0,
								  /split_at=*/HWPoisoned_page,
								  ..., /*uniform_split=*/ false)?

If there are multiple HWPoisoned pages, just repeat.

>
> In fact, that can be done by teaching free_pages_prepare() how to handle
> the case where one or more subpages of a folio are hwpoison pages.
>
> How this should be implemented in the page allocator in memdescs world?
> Hmm, we'll want to do some kind of non-uniform split, without actually
> splitting the folio but allocating struct buddy?
>
> But... for now I think hiding this complexity inside the page allocator
> is good enough. For now this would just mean splitting a frozen page
> inside the page allocator (probably non-uniform?). We can later re-implement
> this to provide better support for memdescs.
>
> -- 
> Cheers,
> Harry / Hyeonggon


--
Best Regards,
Yan, Zi


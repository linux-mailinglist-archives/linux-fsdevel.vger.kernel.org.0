Return-Path: <linux-fsdevel+bounces-70350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D3C981F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 16:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7993A41DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6DA33343D;
	Mon,  1 Dec 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RaJPuljq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022078.outbound.protection.outlook.com [52.101.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2132C954;
	Mon,  1 Dec 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604340; cv=fail; b=TozeVpCSYHkFCY8qpY3IH4bhGE39qcEVUw6VWqe82/5lOj5Ny23dsz6/fgbUQjKSVYIdxiXnEpJdti3hXempJkELBTzZZ0BhPiSQMrRJtyjWpUPi1tJsC9xeB7UThmqtv2jOyb6wpEYClZwJzVVHm+vwWdBlLzWi8uS3sXRP/+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604340; c=relaxed/simple;
	bh=dVyTuLzNaS6//FcSTcIeDCjHcSwC4mwF1BzrvWTF/D8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pee4dTzdDoPMEZUJNQ2swAFdOeM/dSg2y1n9L7jUtYDYsXjZ6nNlIRvvsXTAav6T9tduETV4IN95Sa4xVSZ18ND/zFlXiCxwRQcfKfRKe0Ot+QxQ3akx9P1S1QQctWBTy7Zy2RrUJLhhdaxBRsKS4mjlHPJOiUrzDx0pTVhjQUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RaJPuljq; arc=fail smtp.client-ip=52.101.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqFHEVuJWbjvns/K6VaKAsvpFB6uzTKDBH16qySoyrvKy/HBVCcEgjz8YvArJvFIOF+5yk5vF1Ccu6PAsL4dONU7aJmjhCgdrFfRpiCDcWGeR/00W9NOvy0vCGZfe+dW3QtyjVEXx57rKFNzj4cll1FCxcwy50lPYRaNAFSAZGX/4uapqvKsCZiy75Fal8MYW6KtLmcSS68dkgISocMX0rNkvOTZIIQiStUJKHftQzG87WSGvgprnyKvv9+mVE1Ymmh2Zn16nW9xVIj7RLqBjuM1M1QyTBHgVfvDLjPDHKq8fPMx3aZpx0otOr+9c7jZxUsspXQg4kV3e3c/IHIdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD2S1HBeD/bedjfJuhqL+EJUmOtnnWMbqabmR8I80QE=;
 b=x605bbFBjwYbBTDzd4PKdGdefgtUaodJrfXqfjDkxFJilxp/WzOqmQxzK5QTZsI/kY6enSwJoNeLC32TNfknQOy5mwNN3i0QAlhaHe0Ty2fnxpnfL/2rZ2eCVlsghJZv7MF/l7sSwFdqcdK1lPzS2Myb/JHL9hGH1+gyI/y0OerCUToWBgin85CBhg0IWbsEaHKCKk0pQSeqJ8IkexgqDy1eg90F7nyu/4Pzj6O1bAFvI6giW5h6fPCp/TKW9XLt2Umd69QBj6w1BnUH94akDZ8x7nsIUFoEWoj6/fM5+2Y2pMxSc85jb7kE+bluO6qVp/ufr5wadkHW14v2ilJm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD2S1HBeD/bedjfJuhqL+EJUmOtnnWMbqabmR8I80QE=;
 b=RaJPuljqFoVwajI23uUbP2+O/oaWDfDRqahiz7tiOlABmlYUaJ/ZvdvijJNpu+fYzHo80I+vqv9GWHJVdM/0xX8JP3FhYsZMdrCu9gxX0ERpHNH6rJlfg3lspR+Ktjj4yF9QCTj6/VC5jO7gilsNudDIOCrGMec0d4z5cVr0b9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5849.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 15:52:13 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 15:52:13 +0000
Date: Mon, 1 Dec 2025 15:51:35 +0000
From: Gary Guo <gary@garyguo.net>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin
 <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kwilczynski@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn
 <sergeh@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v13 1/4] rust: types: Add Ownable/Owned types
Message-ID: <20251201155135.2b9c4084.gary@garyguo.net>
In-Reply-To: <20251117-unique-ref-v13-1-b5b243df1250@pm.me>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
	<20251117-unique-ref-v13-1-b5b243df1250@pm.me>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ddfebd-59cd-4508-5f17-08de30f1983d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|3122999012|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GA7e2tg/Ytoo+Hfdu50wTUInucqXqNT6ORjR17hsDx1cX5OPh9HdLWRiNSYl?=
 =?us-ascii?Q?w+cuc29LhaEck9P7o7wAuKeo1wFLiZ5bGpOK74iYJ06qZIxsOJFkJ9RWy73G?=
 =?us-ascii?Q?h0DHJH7hfZb0iqCv2S8q98186ABAmFHiZ77CjoOse5bvwKRvj6n0JBsiRzZ9?=
 =?us-ascii?Q?tTC0gEqCxzhaHGYLZ94Jgi9n5kLpnxIjtItOuePcgnmT31iT6mp8gkDul79T?=
 =?us-ascii?Q?XuP8eglImYRM1/90t4Y3vgcUgb1UBAjvbTss+33cR02r24txhiJp/O73n/0Q?=
 =?us-ascii?Q?AcgEtnbkNlCC3wF0zgbsTn5Jxl991APHUY+WXzBF40wilDMiE+hWABB1a75D?=
 =?us-ascii?Q?Adp0tV3QOyfdWQm8E09EjmUiepWdEDxH3OtC0iDy4iAPO5/Dkiph8d3PQf2x?=
 =?us-ascii?Q?LvdGcOpifOVn65Y/HrpfUzDXXg51911WKdPxvhml4+cTqgKFnLADLXel7F5l?=
 =?us-ascii?Q?liUh9Az9O4IdG8HjeHVMmJSAdvtai255V2sHG6L6vP7YDAFovRx7cxdU+XFG?=
 =?us-ascii?Q?fupDNgCmzkUxBgTwdBMcZ4QijpVAUcGPWrgJDz0nbLNml9OPDDUyfKhJ6A/s?=
 =?us-ascii?Q?hwh5vaydZU+9np5Tb0ZTkgUMACkznWMFzKRuoR1xMyDnmSOvu0ctKHdlueKY?=
 =?us-ascii?Q?0SHi3O1YDQ5hjtY4JKfjhVo+rG2zp75nJ3qWdELZ68Qb3JolwALpX59ZMalC?=
 =?us-ascii?Q?kzEQKfxSetPjKmU2QmSvC5MmT2PT8Iw1lnyRURbFHT+VgNeA21bxqmsoWzid?=
 =?us-ascii?Q?azCnYa7by93r9rfpld4w3L4UMswemVfh+rdSRqwJZtHgwDCRABe/DrLNks4N?=
 =?us-ascii?Q?P+opGnZqBqeeCQ5jtXwdEHXYuawjPgfE4E7J/ojA5dvmnxJClj0ciWL6BNVK?=
 =?us-ascii?Q?r/iruwQnHChrKECwshrVAd2sxG6Np7sOLBEvew3WqYEvbtP/P9iRHMZZVSJD?=
 =?us-ascii?Q?9bmMoJy6jjmrXPT10BVf40nOz55swW/BeJlYF5ExZBXliTVMy8vAwTY5Nmci?=
 =?us-ascii?Q?baUXOzYTxuj5m2ZWA14DUpQO5MyakKbT8D7ghlmRVIcig+vgpGQ+efZHuFQM?=
 =?us-ascii?Q?hLfRXZ8JtsBLBI+c9BuvBUd568Z3i3286PBJFmNEIdh9vfGbcQnjSSbRZAqy?=
 =?us-ascii?Q?F2yQzVVuwSU35bCI0+RoM+iuqxnlLdnnI6NmAFDsKxCKL+Tx8r+QvFQ8na5x?=
 =?us-ascii?Q?md+KUpwrfvj5AJGbIppFFU6mQGW80UxNxHV5eC6jIpIgakOwW7mSZ1LOpQIP?=
 =?us-ascii?Q?NiAOdweCx7E0U5LcJ7Vd37g6HPK6V1JKxrcEL19ANHh38SYo/zXMKBxJ63oV?=
 =?us-ascii?Q?6iwoSiwIqr+P2Fe8W0N4ScwZsTvcvCnkXsuKrkvyZoP4+DQRRoeddQan35jI?=
 =?us-ascii?Q?4gOjwlyQyuT68n25pC0B58LxzVK9pufbgl/xVhrBAzDtQB41YGXji1xQh4pe?=
 =?us-ascii?Q?LL2DF9Xz1kTwhmr11JEiyUsGVBI5OI7tLcFdF/UYQcLbOepYBOspuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(3122999012)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8xqpq/th68idGw536TGMFrQM+4K9iFxGwnwWisk1WF57vGcGvZNUtLvfVVC?=
 =?us-ascii?Q?hh97C2swgriDsnFDsEpPYxyIYZd3vX4AGE82PTgmj6vegcjBWYXR7BcVYREp?=
 =?us-ascii?Q?53A/yfNUHhJgwI1LmRSGDN5Ei678JC9smcAIeAPJUYCv4BiBNav/2bzWWjub?=
 =?us-ascii?Q?HA5+pWzi7Sw/h1ZImwho8pNgD/w4bPVuG/Cd5DVcNviNQVUMZd9AuQM48Z3z?=
 =?us-ascii?Q?tK/Ew3VpX1tvZs7wZ6TossTxWQgoxlmWwsNMxYS/YQwHQhKIkzSnT+64g5Xc?=
 =?us-ascii?Q?RxGonXGp1fbJ/gOFCn3Ef+ckkRINi/C1SakIDmwtfgUyd3p+o/ydxVi4S6Gt?=
 =?us-ascii?Q?UMRoR0ZmYk7AGD/VZ/5g+/LipPwfr1Ps3nruzj113k3q8qqnkeQNv5VJc+v6?=
 =?us-ascii?Q?4LjZ+s5XBUur6hPfMTsyIsQAUu0+dRHKRqy3vk+LpFyuYSD2LyTh2mgCSy/l?=
 =?us-ascii?Q?hAw9Qd3b45FWsLfc/KML0G/vKagtHI9cC4xoLaKiKmt3RyK62gnGVsSbpMqe?=
 =?us-ascii?Q?LaGREWrCLdY2+n/2hk3jZYGKmJUqcLZN1Ee5LMslG3dKyk935+yalM9zRcfj?=
 =?us-ascii?Q?xviAYIFabrLHrMmAwOqMrDqOeTsVWbROl/5aAD1ciSfkcoZsGnT0YNEMJvSB?=
 =?us-ascii?Q?4c4suaYIGRypt2hXUzqR5nPlPclyFwvdq+SgkfO0jeCwOdL0JweQCDwTp6p6?=
 =?us-ascii?Q?MQ6yk7Hucxz6THEU+WKiXAzN9xs+emlp2TKLygVM34GXBQ+0Rz3dTi9wOFG/?=
 =?us-ascii?Q?+jTV/Z57yZ/o01396iS7m5NCjnsso9r8L2BQL6Iuo5zDdf4/mTkDD3th/EMm?=
 =?us-ascii?Q?VNXkZNiTWwhr0Hv+ACRwPqHl6YPjVQmLkNR8Kz+0gQENBln5WQCZIFeP4CIB?=
 =?us-ascii?Q?/uPbeaHXtbCWgueddCsOM1vsfN5uFKyayA2F+6EdNtjhnk+wGfWBkIpg94SM?=
 =?us-ascii?Q?+TbQenTkRVNaOMs416B6R9doPoXk9i5IkZMlEXeJzL3tOmBwUJGi5bHnJM9D?=
 =?us-ascii?Q?ZN1T9IZ6evSHnx1YXKmzm2xKmhDaBGG1q2rKIqq8cb21KYHQm7P29KFcvyOP?=
 =?us-ascii?Q?TlvRrzkuIymIRbsNEbNsZDhyDXOoP3FgmC1IowRKt8n1ep929kJirsAD58a8?=
 =?us-ascii?Q?3zzaFaiX+9M7ddbYKos83iSWkzTAd+fve57GCVD1+0+sOef/asusk6XPUDBF?=
 =?us-ascii?Q?NMAT54BPLpEHOhqAhjD2vf5IQ3T1+hKRDuN5NjeT3FHd5+3W12vnccTXKN8p?=
 =?us-ascii?Q?Ym8gD6Ls3pNXDMEzDCMD5v3HohCEx2V5/Bf4iCmd3q1+twe5J75bm2x4dfFN?=
 =?us-ascii?Q?vzHTgSHFF9xTSmLnnfmK7kejAcW2JdM46lM4PQtfyEovMuu8BXpQ1OY/s4jF?=
 =?us-ascii?Q?9vKZRf1NjZ6JlFpbWTyeDhcc0VDfro9La7oUrypFNw7Hk+Hzql77JUg17mJS?=
 =?us-ascii?Q?lmQ14aWsJM/L8zQg2H7f8za3uB+MqWDwWqYADrR7ntsFBoxytjF3pm9B2YOW?=
 =?us-ascii?Q?RjzfnmbQWUVP/N3asYkVSRQdun5OerI9zEgaSvTheHFAN1UsCIQ/8A8mMzk8?=
 =?us-ascii?Q?i2UDiOIF9ZZ4OJa6JzQLSyxqJct0zh8i+r949KC2?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ddfebd-59cd-4508-5f17-08de30f1983d
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 15:52:13.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4kXx0u3rR3zZpOc/2BkBe44T7o86gBgAmAjb+Sd1KEUa8dhp45dCM6WuHnet5tItAL8ez3d9WYCRvhvAz3LUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5849

On Mon, 17 Nov 2025 10:07:40 +0000
Oliver Mangold <oliver.mangold@pm.me> wrote:

> From: Asahi Lina <lina+kernel@asahilina.net>
> 
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
> 
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
> 
> [ om:
>   - Split code into separate file and `pub use` it from types.rs.
>   - Make from_raw() and into_raw() public.
>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>   - Usage example/doctest for Ownable/Owned.
>   - Fixes to documentation and commit message.
> ]
> 
> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/lib.rs       |   1 +
>  rust/kernel/owned.rs     | 195 +++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/sync/aref.rs |   5 ++
>  rust/kernel/types.rs     |   2 +
>  4 files changed, 203 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 3dd7bebe7888..e0ee04330dd0 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -112,6 +112,7 @@
>  pub mod of;
>  #[cfg(CONFIG_PM_OPP)]
>  pub mod opp;
> +pub mod owned;
>  pub mod page;
>  #[cfg(CONFIG_PCI)]
>  pub mod pci;
> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> new file mode 100644
> index 000000000000..a2cdd2cb8a10
> --- /dev/null
> +++ b/rust/kernel/owned.rs
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Unique owned pointer types for objects with custom drop logic.
> +//!
> +//! These pointer types are useful for C-allocated objects which by API-contract
> +//! are owned by Rust, but need to be freed through the C API.
> +
> +use core::{
> +    mem::ManuallyDrop,
> +    ops::{Deref, DerefMut},
> +    pin::Pin,
> +    ptr::NonNull,
> +};
> +
> +/// Type allocated and destroyed on the C side, but owned by Rust.

The example given in the documentation below shows a valid way of
defining a type that's handled on the Rust side, so I think this
message is somewhat inaccurate.

Perhaps something like

	Types that specify their own way of performing allocation and
	destruction. Typically, this trait is implemented on types from
	the C side.

?

> +///
> +/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type. This
> +/// is useful when it is desirable to tie the lifetime of the reference to an owned object, rather
> +/// than pass around a bare reference. [`Ownable`] types can define custom drop logic that is
> +/// executed when the owned reference [`Owned<Self>`] pointing to the object is dropped.
> +///
> +/// Note: The underlying object is not required to provide internal reference counting, because it
> +/// represents a unique, owned reference. If reference counting (on the Rust side) is required,
> +/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be implemented.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that the [`release()`](Self::release) function frees the underlying
> +/// object in the correct way for a valid, owned object of this type.
> +///
> +/// # Examples
> +///
> +/// A minimal example implementation of [`Ownable`] and its usage with [`Owned`] looks like this:
> +///
> +/// ```
> +/// # #![expect(clippy::disallowed_names)]
> +/// # use core::cell::Cell;
> +/// # use core::ptr::NonNull;
> +/// # use kernel::sync::global_lock;
> +/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
> +/// # use kernel::types::{Owned, Ownable};
> +///
> +/// // Let's count the allocations to see if freeing works.
> +/// kernel::sync::global_lock! {
> +///     // SAFETY: we call `init()` right below, before doing anything else.
> +///     unsafe(uninit) static FOO_ALLOC_COUNT: Mutex<usize> = 0;
> +/// }
> +/// // SAFETY: We call `init()` only once, here.
> +/// unsafe { FOO_ALLOC_COUNT.init() };
> +///
> +/// struct Foo {
> +/// }
> +///
> +/// impl Foo {
> +///     fn new() -> Result<Owned<Self>, AllocError> {
> +///         // We are just using a `KBox` here to handle the actual allocation, as our `Foo` is
> +///         // not actually a C-allocated object.
> +///         let result = KBox::new(
> +///             Foo {},
> +///             flags::GFP_KERNEL,
> +///         )?;
> +///         let result = NonNull::new(KBox::into_raw(result))
> +///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");
> +///         // Count new allocation
> +///         *FOO_ALLOC_COUNT.lock() += 1;
> +///         // SAFETY: We just allocated the `Self`, thus it is valid and there cannot be any other
> +///         // Rust references. Calling `into_raw()` makes us responsible for ownership and we won't
> +///         // use the raw pointer anymore. Thus we can transfer ownership to the `Owned`.
> +///         Ok(unsafe { Owned::from_raw(result) })
> +///     }
> +/// }
> +///
> +/// // SAFETY: What out `release()` function does is safe of any valid `Self`.

I can't parse this sentence. Is "out" supposed to be a different word?

> +/// unsafe impl Ownable for Foo {
> +///     unsafe fn release(this: NonNull<Self>) {
> +///         // The `Foo` will be dropped when `KBox` goes out of scope.

I would just write `drop(unsafe { ... })` to make drop explicit instead
of commenting about the implicit drop.

> +///         // SAFETY: The [`KBox<Self>`] is still alive. We can pass ownership to the [`KBox`], as
> +///         // by requirement on calling this function, the `Self` will no longer be used by the
> +///         // caller.
> +///         unsafe { KBox::from_raw(this.as_ptr()) };
> +///         // Count released allocation
> +///         *FOO_ALLOC_COUNT.lock() -= 1;
> +///     }
> +/// }
> +///
> +/// {
> +///    let foo = Foo::new().expect("Failed to allocate a Foo. This shouldn't happen");
> +///    assert!(*FOO_ALLOC_COUNT.lock() == 1);
> +/// }
> +/// // `foo` is out of scope now, so we expect no live allocations.
> +/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
> +/// ```
> +pub unsafe trait Ownable {
> +    /// Releases the object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `this` points to a valid `Self`.
> +    /// - `*this` is no longer used after this call.
> +    unsafe fn release(this: NonNull<Self>);
> +}
> +
> +/// An owned reference to an owned `T`.
> +///
> +/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
> +/// dropped.
> +///
> +/// # Invariants
> +///
> +/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
> +/// - The instance of `T` will stay alive at least as long as the [`Owned<T>`] is alive.
> +pub struct Owned<T: Ownable> {
> +    ptr: NonNull<T>,
> +}
> +
> +// SAFETY: It is safe to send an [`Owned<T>`] to another thread when the underlying `T` is [`Send`],
> +// because of the ownership invariant. Sending an [`Owned<T>`] is equivalent to sending the `T`.
> +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
> +
> +// SAFETY: It is safe to send [`&Owned<T>`] to another thread when the underlying `T` is [`Sync`],
> +// because of the ownership invariant. Sending an [`&Owned<T>`] is equivalent to sending the `&T`.
> +unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
> +
> +impl<T: Ownable> Owned<T> {
> +    /// Creates a new instance of [`Owned`].
> +    ///
> +    /// It takes over ownership of the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `ptr` points to a valid instance of `T`.
> +    /// - Ownership of the underlying `T` can be transferred to the `Self<T>` (i.e. operations
> +    ///   which require ownership will be safe).
> +    /// - No other Rust references to the underlying object exist. This implies that the underlying
> +    ///   object is not accessed through `ptr` anymore after the function call (at least until the
> +    ///   the `Self<T>` is dropped.

Is this correct? If `Self<T>` is dropped then `T::release` is called so
the pointer should also not be accessed further?

> +    /// - The C code follows the usual shared reference requirements. That is, the kernel will never
> +    ///   mutate or free the underlying object (excluding interior mutability that follows the usual
> +    ///   rules) while Rust owns it.

The concept "interior mutability" doesn't really exist on the C side.
Also, use of interior mutability (by UnsafeCell) would be incorrect if
the type is implemented in the rust side (as this requires a
UnsafePinned).

Interior mutability means things can be mutated behind a shared
reference -- however in this case, we have a mutable reference (either
`Pin<&mut Self>` or `&mut Self`)!

Perhaps together with the next line, they could be just phrased like
this?

- The underlying object must not be accessed (read or mutated) through
  any pointer other than the created `Owned<T>`.
  Opt-out is still possbile similar to a mutable reference (e.g. by
  using p`Opaque`]). 

I think we should just tell the user "this is just a unique reference
similar to &mut". They should be able to deduce that all the `!Unpin`
that opts out from uniqueness of mutable reference applies here too.


> +    /// - In case `T` implements [`Unpin`] the previous requirement is extended from shared to
> +    ///   mutable reference requirements. That is, the kernel will not mutate or free the underlying
> +    ///   object and is okay with it being modified by Rust code.

- If `T` implements [`Unpin`], the structure must not be mutated for
  the entire lifetime of `Owned<T>`.

> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {

This needs a (rather trivial) INVARIANT comment.

> +        Self {
> +            ptr,
> +        }
> +    }
> +
> +    /// Consumes the [`Owned`], returning a raw pointer.
> +    ///
> +    /// This function does not actually relinquish ownership of the object. After calling this

Perhaps "relinquish" isn't the best word here? In my mental model
this function is pretty much relinquishing ownership as `Owned<T>` no
longer exists. It just doesn't release the object.

> +    /// function, the caller is responsible for ownership previously managed
> +    /// by the [`Owned`].
> +    pub fn into_raw(me: Self) -> NonNull<T> {
> +        ManuallyDrop::new(me).ptr
> +    }
> +
> +    /// Get a pinned mutable reference to the data owned by this `Owned<T>`.
> +    pub fn get_pin_mut(&mut self) -> Pin<&mut T> {
> +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
> +        // return a mutable reference to it.
> +        let unpinned = unsafe { self.ptr.as_mut() };
> +
> +        // SAFETY: We never hand out unpinned mutable references to the data in
> +        // `Self`, unless the contained type is `Unpin`.
> +        unsafe { Pin::new_unchecked(unpinned) }
> +    }
> +}

Best,
Gary




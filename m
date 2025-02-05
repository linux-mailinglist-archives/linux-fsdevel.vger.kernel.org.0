Return-Path: <linux-fsdevel+bounces-40895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38FEA282B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 04:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11E93A35A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 03:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493F121423F;
	Wed,  5 Feb 2025 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebdonI7f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F7944F;
	Wed,  5 Feb 2025 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725327; cv=fail; b=ZMHwIsEAw7523uDWNCSlbzkx75V7//UhYC6uKr22G0WbUtkIVnF1MDMopumvydrolzxCnMdM2+KZQ4lf6ZI3LdD3k+m9WzfIxqFiLDqlcntzgtqCRmFw6sWNOHKcsjAPqXYrvgloXnLn4SDde7Z8zc+zH/jcJbGxhwVujUFdx6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725327; c=relaxed/simple;
	bh=pEiFF+rsnyJZZvQoZJkpbYP3ABiw/IZrIcE57mAfqP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJ8L8Z0Ja+N7b1lOXH/cjLuKxr4emBeWS22EhCpTLDC6lwkWsEtv9OyOzUlb7NwOB4SDmAlHx/s45UlhbkIvsyjLKbgJHiMW59vV8YPDdoGDYpmNONtF99RlGyQraECBMVTtkWE1+gKGG/duBS+WNbte6Cbcpt1cMOvN2AOKQUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebdonI7f; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQNqwOkJdOdFIteq8LQVakqQZhlOiUXuXZ1AbFIkvuXmDmYkXm+TF5Dgijgx9GU0AdSZz241gT3E67mNmDi0IXkYz+vP4M+D9wd4cF2NGvP5I4UNFcGaRiC4pqVMYQaSTATqdDhAZIkUppWF7hW2AmwK0b0zSyLJki9PohK8rJaMO9TLMve1WJmVkvK/hHLgDxUmbkF8UBu3Sj49URavRC4tDjGXKLiq4B9JxP/+JRyo9/MXnq6W2gcOmXE9LvDcb3Lap8ePMnGwhSXvs2CjIRK+9189tXydRzMNCG6VA8wgi03SBuuYuxbrFEdPLQuUXRzcOe7JRfGh3nW+aMM29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XQPjqiXJppbtW8hBGh+rQjDNDnhYxDnte7JvurJ7t0=;
 b=Kk6X30ioIwhq+RsOnbRbQywxNVm8p8N8v/bdfpq3Xqee+n2Nx7ZoAL0lQN1cWmEeod3TnkusRA21uCR3+za4uuvDm7W5y08K/hLlE0FcKO1LExdbazzMAIq2W/mqrB/jFvxylnUQIeRfWWvucnGh/o97fxzjQlRv88Mvods66wMhycvJS2hm/+Io09dJ7ODPBHZfWtYN2armxMPV0awZn/00PH/XArN/avzh7vrIA9VhLGaCLDdlRjjDM7FMgd/eLWqpG6J563LyLTRFC6UGYVE3I8lMPlbmHcz9Tu1wP11K+LwukT97GYj/jAFZZd/PPuEdXIwOBxSMfzTrUCdjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XQPjqiXJppbtW8hBGh+rQjDNDnhYxDnte7JvurJ7t0=;
 b=ebdonI7flGzlG/zAVaIK+bBEjdqWAbIlFRci0VWzQJV3TvYNbbmUv0qFxjCVVAQsfqOusbks1sf9WnEmxBV0bobkpA8w2FBsfyOKcwVqv+6M8054dltxUVvh082u9ENYuSCjiwbpXn5ibR7tKMqq88yz5dBQdOG34FuR0+lIMIkhUo5VzsaIToNCf6LW2GQxabzv24Z1TN7JLUT7tBplQugTuBlfNPhH55oG9uLjOUcMtLTXiivWPUo9VBfPi4aT0wYJkveaG93g7sORYZbkY2xVcZF1BVGqIMMl5OQws/Yy2V63AgqpwsKDql8aSo/1st+frfPd1+EPUwUD44i94g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 03:15:23 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8398.018; Wed, 5 Feb 2025
 03:15:23 +0000
Message-ID: <d998abb2-e825-4f2b-9bd6-6a0465abf123@nvidia.com>
Date: Wed, 5 Feb 2025 14:15:13 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/20] fs/dax: Return unmapped busy pages from
 dax_layout_busy_page_range()
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
 peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
 <23432568750f099d32b473f64b7e35f0671d429e.1738709036.git-series.apopple@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <23432568750f099d32b473f64b7e35f0671d429e.1738709036.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 33aed631-0189-46b0-8b35-08dd45935472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlRxWm9iakpaY2FvcHE0M21BRjBRWk5pcmdUR3ZLci85YlBOWURNNmVkQjds?=
 =?utf-8?B?VDU1YlBwdWJaN3daUnZjc3pDTmxpblYyZ2pOY2dBM0xPTERvL1BwU2x0aHZt?=
 =?utf-8?B?VHFaOGd0RS8yZmd0RjlaQXlJdkoxcGxSSjcrRGNUQzJuekV2U1J0STFDZFhl?=
 =?utf-8?B?QjhNdENGUnNWZy9RcFdob1hxelRWQmJMVVVGcGdPUVN1c3FOMDh2citqaFdF?=
 =?utf-8?B?RGt3TFhwRy9ZTC9HbmZoZlZpNTVKZENCUGE4S0JnNUZCNlZYdDVEK0xJZFV3?=
 =?utf-8?B?U3Flais3TjdlOGRSN1ZVTkVpbkRtQ3JldU9tN3RDK0pNWDRSczl6RUl4cDVJ?=
 =?utf-8?B?dHdhdDlYS2hEUnRnSDFSdnFwZnVjZmxYTUFkcy9Jb2MrZGF4TlR2RHdwKy91?=
 =?utf-8?B?elcwb2FURm42K0ovTjhBcFdsd2I3b0JsTTlscVVRWXpOaEVFeHYyMkJlZktB?=
 =?utf-8?B?Ykk2RWlHN05lRW9YZFgwdm1vd1ZJQVNmSGRpNnhhWC9NWXRSVnBHRXFHNWJq?=
 =?utf-8?B?UU9OUGFRVzNUMlVFeFBxNndpQkdna0E3V3NPLzBoeVg4RytjOHY5SW9ta2hL?=
 =?utf-8?B?TEE5NTVvdE9uakJXRTZOVFlsM25oUkRtOWpIYWRyUTFCNmNnYU5pOEdhRFd2?=
 =?utf-8?B?eGdhOFcwK2dWK1lTZlFIeVl0TU1OWXNlcDliNTk0THByQi9mV1hveFJOcDU0?=
 =?utf-8?B?TGVlKzJwSExOTkNlZ3ExbXR5MTNZS2xWOXgvSi9NSzd5L1pMaEZxaXZmTlEr?=
 =?utf-8?B?Q2RpcEJsOGU5eWppZ0p4ajU2azhhdUcrQitFcGJRN1FaV3M5WTNRRTNMdkpW?=
 =?utf-8?B?bS94UWZBZnROVlgrQmhKMFdYcFhvc25XUURrQ2R2TU5zM1ZWV09nTWZBdHFN?=
 =?utf-8?B?eFZxTlZlc096RVhhZHp0TG9KYUhoZCtmWmpPa1U0aVhpMHlxc2VwUWpLdC9w?=
 =?utf-8?B?ZGo2Q1BleFJOVHRWNXgyTHVWNmdUTGFTaHlUVDlGYjVyZ3FESWNHQlUwYUNI?=
 =?utf-8?B?VmV2b29LS3JyNFVIVS82MWZnbDdoekp4UDB4V0MxVWpEdk5rSW0zSENueGda?=
 =?utf-8?B?WFZheUpQb2l6SWFiQWNraGJmVzNJK1pGU0RhSmxYeTkvSTBYUXdzejZyeGV3?=
 =?utf-8?B?QnR3TVBhRGRGNmZETGo3U0RZN2s2UHRZcmIyU0FUd0lIVG5rQzgreWZPUm9t?=
 =?utf-8?B?VE1LTjdzaUV0MEJ4aisxQ1FwM1hIWDlXR24yWnFuZFpEcktrVW0zRWo3VTVB?=
 =?utf-8?B?VmI1cnRXUm8xaXA4ekpqUlN6V0czelVYSkdsSmVySitZajNzYjNzVDJCeHhz?=
 =?utf-8?B?ZEpwdU5ISHA0UTNwZHFieFZudHBSTnlINTk3Tzg4MmdpbGg0Wi96SjUwYitv?=
 =?utf-8?B?RTJLRkYyUTR4NVk0N0JIeXBESEh1b1l6ODUyRUpVdkw3Tzl6cDZzWUpwOGxR?=
 =?utf-8?B?SkxnNnR5Z1pJMFRMREExNjJUaE55QVBxdDlsN2E0UTVrWk8xckxNcCtrU3Fs?=
 =?utf-8?B?Njl4VTFZTFpUcXVGa3czZHVKR0Z1U2pvREpnTWtuNFNPaGdHbjErSkNxOHpJ?=
 =?utf-8?B?ZVArS3h6S3UzVTRlQm9JOUdRems4UWpKZkRUdFBFS05KTkM5cHRwWDBUbisw?=
 =?utf-8?B?SjVsQlYxdGZWdHRkaTdTZmQvYk9GUDJBRExUSlJxNzJFeThIQnRYdXgrVGdF?=
 =?utf-8?B?Tk9jSXRtNEVXUkRwd0wwNURFcjg0L3ZFaEpxOGw5UVBqVXM5V3BhdFF2Mis2?=
 =?utf-8?B?ZHc1RUJScmtNUjBCN2NVZFJwNFNWWDIxV3hUUVhZSUF5UjZRWmpoV3c2N3FE?=
 =?utf-8?B?Q21YS1RnSy9FV0VvTGpTQjFYbW0xdmNtaFo0T2Joa3BndHdRcWRpOHdyS3Bq?=
 =?utf-8?Q?/NxUwHAF0fs9I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TERFZmVZY0UrcGU3RU5xcyt2S2pNMWJBUC9kZFphZDVYakdSTmFxVkpBa1Nq?=
 =?utf-8?B?Y2p5NHo3d1QyTUpnYWF2UlR2Y0hvL2FVWTZkSkNhdWhvUk9GQlQ1SEJGUFpW?=
 =?utf-8?B?ZitkVUhHN28zQTdDd3ZvY0NCU3h4R1BFRklSS3plU3dVTkhNYyt3Uk5uNHpu?=
 =?utf-8?B?WC80ZFNuNng4cWpyT0JaWHhzdFdFMXFYRnNtM0lSWHFhR1V2MzVINEo5R0Nq?=
 =?utf-8?B?bTlWK0tMNk42dWFQQ0l1ckhmcEkxUVNoVzNOWElHczhsWmJQR3lDQ1BOOWMv?=
 =?utf-8?B?VnN4SFFLOGxZNW5DTmFMNm5wMEhqYmVCK2oyTmJ2ZGFnQTd6dHZmT1VLL2VR?=
 =?utf-8?B?UUJMS05jd1ZBWmtUbWNHazdNNDVPUy85SDBOUEo4RS9pL09PUjNNbmJ3OGhC?=
 =?utf-8?B?V3NHYUVSUVdzbFZPTUdLalo4OXJCWUdYdFFxbkNhL2FJSGVsaVFUSFlkc2lm?=
 =?utf-8?B?ZEtwUTh1MmhteUhBVFp1cGYvRG5KZ2FGY2tVc0dkV09tNDMxZEh2RE9aenhs?=
 =?utf-8?B?Y3NpTkdvS0hWTHNkeEJXR2dLK3hHcFpic3JCNE9PaFJkei9jSjc3KzhCNzhU?=
 =?utf-8?B?TmxZV2JmUzkzblphbnMybldVSTBieTVOSGJ1Q1VXWEpjWU9xRmZzektoaWtr?=
 =?utf-8?B?TWk3M1NMWTUwckpFa1ljOERtUUJHNkVOdkFLUWlLTThPa0JUVm9SM3VHOWRB?=
 =?utf-8?B?YkZVQll5Q2dqV0FoM1JyVEYyZ1dwVXdBdStucjAvblRpZUtkYzhVT2RhVkxF?=
 =?utf-8?B?ZEJCUFYzZFBaTkRjRTRtK2taSmxJbUd1UC9RVWN3VVhkMTFrbnhFMGVIVlNL?=
 =?utf-8?B?aW9ScWRlVW1mRVZ1WEg1NVRQNFY0TExHcTl6d0tYTlByQTR6bzVBb2xzUjlX?=
 =?utf-8?B?YUlwZy9jNXlJWUFrbTNOWjZVOXBNS0l6T2szMTJrZU00RGlTekpUS3VvU1dP?=
 =?utf-8?B?aGVSSHJ1OGZZK0RkTFlFUCtWZmNKMW40SEZqeWhieTFrMUtlSmJwRVlKRFFE?=
 =?utf-8?B?ZGNnbmwyN2JBbXJiYlQrMjBBYjI3ZTE5TnJKNTljdzF6UFdxK2JMQTRqcVZh?=
 =?utf-8?B?a3pEdHllYlhWbEdKL2RpNGpkRHdWdGJsTGVHMVFzVGpjVi9mb3lEaWM5MnVp?=
 =?utf-8?B?TmQydXZWRWs5d2pZTkkvd3BWMDJpZFpyRXp0bzV3SEptbkMxek5EOHhVcHRp?=
 =?utf-8?B?STQ4djBuOUd1M1Q3MlBFYkFlcUlYMCs5YUZMSWpsSjR4ei82eC9BR2xveWJW?=
 =?utf-8?B?K0pxbEZBWFlseWV5V0MzdnZIOXA4bWVRNllFK3krblN4dVVVMmoralh1TjJO?=
 =?utf-8?B?TzFNWEhibGZtSTRNNzFTZElGTFJVbkRsOGRrUlQ4Ukl2QU93d1BhUzNQUmt5?=
 =?utf-8?B?cVVvS0JsbjdFNnl6ZGFOR29UUkRKWEJFYXNONWRwUEQ0YmxwaFNpaG1tTm45?=
 =?utf-8?B?dXFENUZJQ0diZWtGTkhiby9ZaytUQ0ZwMnhiOXJwWEtiaDArT2tlRFFZTEIy?=
 =?utf-8?B?Z0pYTnZzbFYxWk9zOHN4OVZpbHJQdGtmVWllQmM1S3NGeHNkcWdqekNaUE0v?=
 =?utf-8?B?RFUyb2IyK3dBeEZaQXk4TWJyaklGcW5jd3FPT2tGTUFobjlDaHltZnRNVVNM?=
 =?utf-8?B?dVBvWWszbGJOMnJabFlPZFZXaVYwbld6eFZ5eS9EWFByQ3lRVW5RTEZkWWcz?=
 =?utf-8?B?YXlzakdYdVgyYm5TZ2haQXJJcUJzNW00NnRudkFjMTluRVpDS1U3bUszVkNs?=
 =?utf-8?B?OTloYnY3NWhHVElrM2srbElKU1UvSUdJOTg2Z0NjcTBYQnZVMkhTNlBoZ2pn?=
 =?utf-8?B?ZDNiTG9iZWhhR3lOaUZHelRselVnQWdKN2hTdXJudVlhV05aTmJRbGtGU2Fo?=
 =?utf-8?B?M25yTzlVT0ZBWmRhQkllZmdpV0tIWDlVRUgyV1RNczd5R1pBd1NWbm40OW9r?=
 =?utf-8?B?c3BvN3JwRWEzRVd4THRXNWtNTFVSMGFaSGZOK1RoaEFDcHlWcVJNVHY0UE9s?=
 =?utf-8?B?UDMxZVMxMEZyVTZjSDA5aHdMRGRWTjNvRzVFRnRtaUlJb0lwMGlaUEhSVW5Z?=
 =?utf-8?B?dUlGNFJzY294M0h0NjNKN040bTBlR0xNaS84YXNXSXp6SmdSRFp2NzBLQWJi?=
 =?utf-8?Q?zFo1AQ55q5WssgJvJFxJH9ObZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aed631-0189-46b0-8b35-08dd45935472
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:15:23.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9mNCdT3kvaPRxQet1moohg9yeUlozD761HCXxdxaHduego9QnFRFYV7w9PmaxSZtmbXdlP3nhE63z4NPJkGiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

On 2/5/25 09:47, Alistair Popple wrote:
> dax_layout_busy_page_range() is used by file systems to scan the DAX
> page-cache to unmap mapping pages from user-space and to determine if
> any pages in the given range are busy, either due to ongoing DMA or
> other get_user_pages() usage.
> 
> Currently it checks to see the file mapping is mapped into user-space
> with mapping_mapped() and returns early if not, skipping the check for
> DMA busy pages. This is wrong as pages may still be undergoing DMA
> access even if they have subsequently been unmapped from
> user-space. Fix this by dropping the check for mapping_mapped().
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 21b4740..5133568 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -690,7 +690,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
>  	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
>  		return NULL;
>  
> -	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
> +	if (!dax_mapping(mapping))
>  		return NULL;
>  
>  	/* If end == LLONG_MAX, all pages from start to till end of file */

I think the patch should probably also add

if (mapping_mapped(mapping))
	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
But I don't think it's a blocker unmap_mapping_pages() should do the right thing internally

Acked-by: Balbir Singh <balbirs@nvidia.com>



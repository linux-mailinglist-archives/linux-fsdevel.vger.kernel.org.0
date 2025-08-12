Return-Path: <linux-fsdevel+bounces-57507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69640B22885
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3B11732FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FDE280A35;
	Tue, 12 Aug 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Xq5vXzOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013052.outbound.protection.outlook.com [52.101.127.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB6280324;
	Tue, 12 Aug 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004982; cv=fail; b=bOkRjZ+QDvqaFwGgWD+7dFXT6Hu5SeF9R4o11TIeITBc5X+PRtoDX3tuNXck4Oa16MeECw+nrcC0ROdpGubK/7xm4tRdQdqY6WjpQ7t0kyxCPV+XQEpPNQP529i6cZnTVMxV6byrJEJedtBjh9WXkI0KBZEA9hiiB8CkoOtJW+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004982; c=relaxed/simple;
	bh=1EB8b1NdfTk13Czvi0M3O562lNrOo7z+d3ktUOLanSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QzdhjZJ1MIfBYAntGNVcLHWod73Vj2AzkmZXmv10c7E+Xn1/XrSLyRe/aruVFYFpMW2ymgnsySopjEhysbeQ0vk6a3vyo1WPp1xVzexdZ1i37hKMsx/13i3gh5phPaMX39yomRwkXmKhtwpfNLCxLj2zT6Og/kCAFAWw5nqC4rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Xq5vXzOT; arc=fail smtp.client-ip=52.101.127.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utcIynnM4c563z7poikWu58ZRDVRl+2wZpmz3dKBLx9evAotly706C6acb1hg7YOP/4mAnELXHBew5zSB4QyJYAPPTYDGTq3oJkAyJWagSy37po59xN5wyYYnb+sOiZ+rJsSWuRlct/N3T7RtEfnHK1zqBheao5N+NMSukMoBoDCfCbUhOfgQMbpTaQx+Du/0e/wZ0tYATvattFkvQDE1m7l8OxM/80LKbLnOHJtXHN+o0lcy8zmxDU5Yrdto9CG//Md8tGdH68Wh/utF+8B7YuafyA9svdjWAXDDKY5wWIG7KM3KUm/anTV7C12Juekj5Qcyk2GIkJHmLpuDJBAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqmHXe9pVein9z7nd/rEZ8jJ+KJnZwt+Y9ZPbcBERFE=;
 b=tmATwDqcg4N53zlcbF1XUA2yrI6dDWl2cHdK1nmv1QzgGhL5KZIoU3WUQTMqSaFN86N+qM5ulJ5l/c53wF4v8wskhcZ7VmuCuduVvbQH49M9hOlpnqLp8oZmNSOA5E99Ov11A3+69YUqae738xPIvxMvmu1E9KpYZD2BUq6YKDoALqrvcuT1FWtHHOEmy8LLWwsWRCAFknG9QpMqgpH9wHzNuX5VbHkyOT/+N4ZzIxjdNwzpjNglkowvOzpUdknxPwU8GLYy2LbXYvItx9Xf3G5/Fp6oyLHUpv8nzMzc6xnQgWKn6LmF2f/TOCErsSGTpdKKK8zAo4hAz0fMBLv2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqmHXe9pVein9z7nd/rEZ8jJ+KJnZwt+Y9ZPbcBERFE=;
 b=Xq5vXzOTIR1ZGTQ9eMkC8o44MEx5562pEzwpxRViPEDvaQVqByopUQMp2BwHRBu/lwgiRpr/oDLEcR7aILQzoFailNe5/kl+/BMfbtLUrPtDM7sceKIalHmei2UFLo7gargnLdbVankopEe1GI95RqMXGz+icZlORS/WPVZmh1iFUF/E6IPsMAqwvPmb+JIXHUOvyEHLgNEgSbuZR2A3UKHGOygCcek5/wByIXkjWBlxfF4egbeC5MdVS5cUaHNqUprMvQMzfaDidu1neGiZ7Zien/uJxkiJqj4EshCSE7tNpZF2hG6d+NpuONiYVsyWb2uTB8Td9PZ0vyouy5xrLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KUZPR06MB8073.apcprd06.prod.outlook.com (2603:1096:d10:43::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.22; Tue, 12 Aug 2025 13:22:58 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:22:58 +0000
Message-ID: <0e01b83c-17f7-40b7-a9ba-3118b281a72d@vivo.com>
Date: Tue, 12 Aug 2025 21:22:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove redundant __GFP_NOWARN
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>,
 linux-fsdevel@vger.kernel.org, sj@kernel.org, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250812095747.121135-1-rongqianfeng@vivo.com>
 <aJs9dPMdY_W5uZdc@hyeyoo>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <aJs9dPMdY_W5uZdc@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:404:a::33) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KUZPR06MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad5eb5b-0dc4-4690-f3dc-08ddd9a35a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0JiTEtvMldnM0N2enlIemEzUjRPaVc3eWRiSkM0Qk0xdW5NZXU5SHVkbUZw?=
 =?utf-8?B?d25RQmVOQ1FNQVhRSXF0V0VCamdqczlkUnN6bk5EczZsZXJyTG03RklmN2lF?=
 =?utf-8?B?L3R6R1ZxaGZyWU5jcFJsdzFRSGV5T21vbVY1RkhXWkZCREJRdjdxYjZOV21J?=
 =?utf-8?B?bE9kTDNpcDFPWmFpN1BROExyOTcybFFJNnNmOHRRM0FGT0x5S3VpZDU1TTBJ?=
 =?utf-8?B?TzBGZ2M3aytIR2hWNzkvRWVVbjdXUXhnMm04bjVUNXVRUzJ2bm9CdTMyT2Vo?=
 =?utf-8?B?SVlOeTVGZUxEUmgyaDc1ME9USXhQL1g3VFh0ZE5Sa01GZlg5eCtuaDh5K1pT?=
 =?utf-8?B?NW5UNkFLTjNpQ2Q1ZVRWMm4xb3pwZUIvY2hHWDE3TWVLNGE2ajdRZ1pPR3Ft?=
 =?utf-8?B?OGFKNnJlQi9LalNIWTJnNUhFcStUS3RvcjlhQ0NDTzhidFJZRE5JcXhqWjZz?=
 =?utf-8?B?dElRS284NUpEVkN1V1NoWC9zL0pNSkkxTU83TmNxWkRBRmRIQmFXU2RXUm84?=
 =?utf-8?B?RW1mcDhhYXhTSHh2YnlSS090UktYSHdvS0k2d1NFNkpMWnhxMEczWHpRbXBC?=
 =?utf-8?B?eTZ3elRaSUhlUSt2SG9wS2VTUEQ5SC84cTJyWW9hL0NTY0hLeFZ1Mk82ZVdY?=
 =?utf-8?B?aDRGaXFoVm5SUVF4cEJ6dVM0QmdhSVZQalNKczRnYnYyVkZGSlNPR0h0amx1?=
 =?utf-8?B?NUU2NnFWL1J6WmptaHhEKzloY3FUTkxNVlpkejhLTzdydmFvRTJXR2lrMExR?=
 =?utf-8?B?UWU4aE5qeGFrTnM2cS9ZYjArR3pZTTFRV0czYmhNVEdDMVYwOVZCcmh5MnZq?=
 =?utf-8?B?cEprRkN6RjR2UmluUm9SNEREcGI5cE1lTWpiQ01IS2R4WFFnOVF0L2tTUlRG?=
 =?utf-8?B?MVhYSkY4WG5Td1JnSEtWYzVPTll0UW9kVWRscnFJR2Q3bUhZcVZjNytSSzVq?=
 =?utf-8?B?clNaK1JJaUZ5SGMvN2QydkQvL0xVTkpaWUIwQXJ0OTFYazdrb0duMHBBY3FJ?=
 =?utf-8?B?R2luWlJnMzdrRVRyNCtlTjlja0IxRUd1YkZvSTBmQVFDd1JpY2FNVzIxbG0v?=
 =?utf-8?B?OWwwMkhSNjFURHVzVWE0aXRVVlc5cDJmOVdnMXR2U2loN2JrWUkvVUxwVjlR?=
 =?utf-8?B?MFNXQ3drQjZoWUpuQkg4ODBsNUs3eGxaTjMzRGhPaWFXdloxZHhIcHFHVGlZ?=
 =?utf-8?B?ZlFkWExHOTk4b1NWY3ZZcHVOWVgyVEFudDNGNGZHb084UzIxNzBYSUM0QTZa?=
 =?utf-8?B?N3l1SWRjZXlSQVl3aXVvSHBCS3NCeVhya0FOZ0tFYVo3d2ZOcDRyNEZYQXZw?=
 =?utf-8?B?b3RXL1ZiMjluMTJFNDNaOEhwOXFEQUJxU3Rid3ZIdTZvY0NNZk9TU2RyVTJj?=
 =?utf-8?B?Y2I0SGFVV3ZmNXFmU0FROEdQY3I3ZWtxKy9SN0E4dnVORklpVHdtcmh0L0U3?=
 =?utf-8?B?Zk1WWjg3dGs5UlRoNlJGbCtma2s5eWR4anp0dWRQZnJ2NUJ1cXlvdHdISkht?=
 =?utf-8?B?bk1jK0ZMaysxcnBoVnpnTzZOZVQ3VUFMWnB2Um5ESGd0NDB5N3p6OGJVMUNj?=
 =?utf-8?B?Q05LUHRtK3RQZ2JJTmxOSkxpcjJCVFpxdm5NRm9Qd0VUMk9UMDM2cmlBYWtT?=
 =?utf-8?B?dWxMOFdMUm4rYlJ6MGZ6ZUFSY1gwcnFKOVVSWnVMSndCOEhyUUZhRXJkWE9q?=
 =?utf-8?B?d3BPYVZpZ0ZSRDFBUitJRUpSRlZPT2s2bE01dXZxTFVDSlBXMHIxM1ZLdDF3?=
 =?utf-8?B?N3IwR2ZpL2g2eUJka2tETndiUWF5OGVZaU9LUDdJcndFVEF4QXRFYXZqWDBs?=
 =?utf-8?B?R0Rib05ZRVFSUkVvK0ltOEJFaThTRU10eGpoVGFoNmg5em1rM2s1a3B5aUU3?=
 =?utf-8?B?TS9IS3pwcEdZUHFiNUFGVnRJclZyRWNlQkJQY0ZrbU1JdWEza215Q0VyVTB3?=
 =?utf-8?Q?JrR/JvmurG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b054UnI5Qm9YYmIwOVl2emhtY3BUNHkrR2w5eU5yWldUV3lSS0hyeWdqa2dt?=
 =?utf-8?B?czFjY1BsUnc1RGVvcm1Od2pjKzlPUkJidzF5a3dMZmZxc29ic3hldnpCeEd2?=
 =?utf-8?B?VXRwT0kvczhaS3h5V2RlU1pDOTkyQnlPUnVDejFLOTd4Q1M2cUNGZWN4L2tP?=
 =?utf-8?B?bGwrRTMxK3BkWG0wNE9JOXFjdGRCNUo5V200b2lEcVd3b1lWWG8reTBVRzBi?=
 =?utf-8?B?Z0VReTdta0hYdjliazhYRFVhMk4wUWZERzdmbDN4a0ZtOXl2OGc1N0lGVDA4?=
 =?utf-8?B?TWpVK0pjNisrQVRnNEhMNEc5V25vM1ZSOHpQNDQ5cEg5RDA4aFlpN3huckI3?=
 =?utf-8?B?MEdmME1ESVRHTERxR3Z6Sys1VTk4MXluRnFVZXh2ZEx4enIwcm5MR2ZCdWNQ?=
 =?utf-8?B?dkFqVGdBcTMreUIxN1NCVWtBR0YxbjRHc1FMN1ZZb1ZteVJoVjYxRHRDWi9z?=
 =?utf-8?B?VGQzRGxTemJwUTlIdkdjSXM3Zk9FQ3VMU2hlT2RjTFpGbC9OclpxQ09wN2x6?=
 =?utf-8?B?S2ZSWjIwWVczbzZJaG4waFJESWY0Ty9xYjFjeDhMbUZuMCtaNGFZZFpTZUlT?=
 =?utf-8?B?OGcxK3J6VlBPQU1KSHI1cG1QZ0kvaGgySEdhbVh6Q1RlY01CRDFaWjZURzkx?=
 =?utf-8?B?VE5LZCtlVEYwQ3pBVytzQURKck9IRnBrT2lYeTBDZ2RHRXF1dWU4SjFUSW84?=
 =?utf-8?B?dGd3REZ4NXlYQ1VVQ1FKdW5rN0FwakVEYmFQUDVibXhOUldNNzFSd1BBL0h5?=
 =?utf-8?B?UUw1SE1QeUMrZ2NTbnFKNStEOUllMkdSZmFrNHlNQk55NGUyMnp2a2EyZ2h2?=
 =?utf-8?B?UlF0NVZLVmxFa1prbjArcEFKTFU2czN6NkRwTW5GdWM0NFZDQncrVzlNWi8r?=
 =?utf-8?B?SEJGWEtMbGdrWFBhbzdDRm5DT3RjWk5NOXpmZjlpb0JpVytPamRpL28vYnRZ?=
 =?utf-8?B?dTAvaVVYMEZSUlpRdnhLWW5yQ3lUdXhPYTE5NkFXUzVQTlVPU2RKeDFCVTN3?=
 =?utf-8?B?UmkzcFJnVUQ4QkhZNHJnSUNLTWQwQVRiS3BLcWpodDRkQ2YwUmRPaTRZTDdU?=
 =?utf-8?B?M0hDb0dVbU96RC9vY08reUZydlBMUzd5Z3oyelpkMGdrNVkwdDRPZ2N2dHFx?=
 =?utf-8?B?M0tYRkUvSm9FaU5GTE40WU5aVWRSaVhTQ1A4cEZoZXVxUXVDbTBTUzY3Z1hW?=
 =?utf-8?B?OGl2VHpGUVpLMHlEajlCazV5dlhieFoxV0QrRmM1SFVadUVnZ0d0dzJ6eHh1?=
 =?utf-8?B?YitaM0p1d1ZCYzVyUHVpNHBCNXJXZ3VEdHk2RTRQRXZoY01qVGlielI1bVpH?=
 =?utf-8?B?ZkRxWnNxZS9yR2dKczJON05XSCtJRkVja1Y4R25vdTl3bjBUODR5bXRQeXRP?=
 =?utf-8?B?dWhZMk9VaEhCcTNjUWRhSXp0SUd3Z2FNU0kwVzlDcUh5b1d3STRGOW1MU0dJ?=
 =?utf-8?B?L0c1ckxjYWE0bTZMZSt5YUluQVZaMHBFOXpUV000OXk4bjBuT1h0K2xyYlJr?=
 =?utf-8?B?azNHcVo3MmowL3V5OW1LL0pzbktqUGNMb3dFWEZmMktQdGp5b29FTFpQeVRK?=
 =?utf-8?B?WlNqL0ZsMzlZaGdVRWw2SHJoZFBQbklRQ3A3TStqOXJlV1ljRDhJZTdOcFF5?=
 =?utf-8?B?K2o2dzlMQVYwa1pIb3JKbDlkdk1WYktyRFArbWtzemlkV2JjNDEvclhVU2dp?=
 =?utf-8?B?elRXcjNkd0xRRjlkMDczbGxiZjB5Z3ZxTWNhS1Y3Vjk3cXN5YTFKNnVLL2Jq?=
 =?utf-8?B?Sk5ZY1NZWjdzMDliMjRiQnk4N2JRUzE4dTJ1ekdTR1Znc2laWEpsUlF3YjJj?=
 =?utf-8?B?UytvbWNVUWRseTEycDEwamxZMzFsY2lsdTlTT0oyS3RFcHN6Q0JsNXVTbjEy?=
 =?utf-8?B?d0x0M1h6dWZkbTdranpvekJSc0J5bU9IZ0NVdWV4N0VzOWlVMU41THY2eGRO?=
 =?utf-8?B?d2dHeFNyaHp2ei8wYWlxa0t1TS9kK0xUdFpUN2tNaWtNOFNRTmhWbDFFcGEv?=
 =?utf-8?B?Ri9sM2FqVVp6dGdmdTZON2dVTDBjMjVhZVdnK2szWnMwNytGQkVWYkE2ZmU2?=
 =?utf-8?B?cE94Q01iU1pWWkJiWWFxTzI2SGJnMTVMVFQ2TEIyNmlEUHNQQ1hubmdsVEt6?=
 =?utf-8?Q?+FyYSwgBXVoiLU2la6QKIVcNs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad5eb5b-0dc4-4690-f3dc-08ddd9a35a88
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:22:57.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1zG1HZyl4fnc+tShvulmvUXhg7VR4gV7Q9xxvueazmEWbZkGnsdFL3Sbrogm0zMpPqi9iudihWdCrp/20R5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8073


在 2025/8/12 21:11, Harry Yoo 写道:
> [You don't often get email from harry.yoo@oracle.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Aug 12, 2025 at 05:57:46PM +0800, Qianfeng Rong wrote:
>> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
>> GFP_NOWAIT implicitly include __GFP_NOWARN.
>>
>> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
>> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
>> redundant flags across subsystems.
>>
>> No functional changes.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
> Maybe
>
> .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>                          __GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
>
> in mm/damon/paddr.c also can be cleaned up to
>
> .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>                          | __GFP_NOMEMALLOC | GFP_NOWAIT,
>
> ?
Thanks for the reminder.  I did miss one modification spot.  After checking,
I found this code section was moved to mm/damon/ops-common.c.  I'll submit
v2 immediately.

Best regards,
Qianfeng
>
> With or without that:
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>
> --
> Cheers,
> Harry / Hyeonggon
>


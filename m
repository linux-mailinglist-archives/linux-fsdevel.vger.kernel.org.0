Return-Path: <linux-fsdevel+bounces-23488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903C392D459
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C73281818
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBFF193477;
	Wed, 10 Jul 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Z19SjaWb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEE38FA0;
	Wed, 10 Jul 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622207; cv=fail; b=SXtzCVwg9Wtw9PADtFvRi9sB0PprDph10tvpfdQNefLaXAWb/n4v2ZsE/BoVhJjodZ0DhifgNiGXjd0qhwLDteYKwnDbiJbLjKsDDLsTsNTlMi4p1ktJlHjkUuWG9veyA4vc9s2fGA8N+iR2HvmZA5h3whZeemFHPEWFRPvOUdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622207; c=relaxed/simple;
	bh=EdPQ4qpjSnAqHXIEAXrzCI5bBBEz2kUyLOgIU3nxOqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n4P0OOo6k0rGqzfG0TuFvVpZ7szKlyLnNUOpnDAdDWUGqu4808o1vHV1AHLtJ0AV2earemjsQfWzVKnMAMmZzzoz6lWKTEeBzflJQrMfPiHc+gh8DzBc39W1ITaCHoHGA+kcdXBwBxd2NOPLTx/s9x4u3WcJPb3tisWcjUWeMgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Z19SjaWb; arc=fail smtp.client-ip=40.107.215.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIMnAydaXIoR9dpmP4fEoKCDJXgLhjFuJ07GZri0C8b7cIaLicfW0oFB+dOARYY8Z4wmdTmLsBu/hQXi80hktZH3X9Wxgpt2S2+PZvWtkdUm/x8ZxVSz/D+A9B5Tb24WyJ0hEJI4Pjk4uzCR6zxuIIuWPA4iesLFM6q9cow+IK9x3O2hx3iCofs5XTkgs8/tiB+a9wdazeRe7vnZwLe/rX6VJ/9q6YTUVyzaZcQw6uYmud2NIPuMj5riNabZ11/V4pyC0MUwtw0h7uL9HTlVTnocgYEz67zvBtmjqQt725ByPYpkdSiSAkEehdNiCJwVPOoqFIC2CoSP1Xtm2UHRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jEMrxlZiZIAKe7i+hA8HemsnhuyWaXMfD4VIGsfaPg=;
 b=lSu9QQazgoKxjWxFypYdmtMt7HtPiwaMpRB3xYSuwfiELislsYqNBpFa+W4W0s01WJlrqZI9m696hiKYB3Z/6d4ihiiYwDLtZzw/8SZKbRa9x2QfiHrjyvXzw6ZekKJUdQfwqiBqDiMC9IKvCXhyvZaHL3tkt36myNnf6stv3wJL9xP4ZNpV/Oqy50j8RvIkmCP71QdAZL25Oai2sXOqjEFHamOlJ/TIcq0387buRpAgJ/YoHYrxEXARTOmxikxMHYqDn1OUO9oiJYSEWpmETT2+IoaYLxBmev0vlQprpMJPC82WBe5Nl2++3YTEb3/DSARp5hHiqonuU6L4YVoy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jEMrxlZiZIAKe7i+hA8HemsnhuyWaXMfD4VIGsfaPg=;
 b=Z19SjaWbmZVW3wAR/HPL7oC99t/teoMJSRSFkWrdcBEGreqa+hT1LYlLpNtUj3sChSy9lvDlzvjtXcdh0C0AK+6LGDsS98rxb/xTaFPE8hBPCyM71h5Migg/5HOMzdkqT0MDO7t4iNN5Vn+/YrOBdJY3puguf8GBrnGvszFWLY45Sx81swJo8BPKQBzh/NZgG51p3g4l8dWSW9cw3bRKqB4AIYKwkq6kTLT9jYLjmX3txro/KdA15uxIbKG6PHT1/UJXm+/HU1YmZ6Xia9qEMiGYo5ESV7eZ75bMiE+j4S/6KLfdxsEAexIxiiJVYG1yTrTcIM0exiOxbpuzKuF7Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by JH0PR06MB6834.apcprd06.prod.outlook.com (2603:1096:990:4b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 14:36:35 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 14:36:34 +0000
Message-ID: <d70cf558-cf34-4909-a33e-58e3a10bbc0c@vivo.com>
Date: Wed, 10 Jul 2024 22:35:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support direct I/O read and write for memory
 allocated by dmabuf
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrei Vagin <avagin@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Daniel Vetter <daniel@ffwll.ch>,
 "Vetter, Daniel" <daniel.vetter@intel.com>
Cc: opensource.kernel@vivo.com
References: <20240710135757.25786-1-liulei.rjpt@vivo.com>
 <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0150.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::19) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|JH0PR06MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cd1ac3-caa1-44d4-573b-08dca0edb2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHBCTmFmb3F0SkYvdzhQckNvM1lzWmh2RGRPckhnTDBweTFLc2JhK3pBcmo2?=
 =?utf-8?B?U0NQbTRFK2pyYjRLR3hqSEJPeStMNWZWK0gybUp6NmQwdDNXMnp1c1FKd0l2?=
 =?utf-8?B?aUxFVWl1ZC9ISWhtaGtKbThIVUVDK3d4aHBtYWFBbjZpUWE3YnM3S1QxSEJJ?=
 =?utf-8?B?cjRNc3hCM3JERWFOSUdOR1JUODBpalVRc3BESnhINkdIbmcxQTRtdUlDc2E4?=
 =?utf-8?B?L1UrNmN4SzN4ejJVS2F3SDdSSjVDQ3A4MHdhM3VKU0ZHRU5teDdJZk1xTGxZ?=
 =?utf-8?B?citHOWxzYWxmaVo3dHlrLzE0VWhLVFlHSVVaVmdoeTE5MjgrWXJrTVpXcTJo?=
 =?utf-8?B?T0dJNHdRc3pIWWhaaUpvMVlBOU0wR0phcmJIbGFSVlBWYS9ESWNVKzBPMThX?=
 =?utf-8?B?NWdocEFicWp4TVBxOGhvbUhrRTRsdk5TdGMvQXp5RVNUTnRjZ2FyQkRmOHln?=
 =?utf-8?B?TnUzWGZMVE5raVh5ZnpBUUFobkE5NFBkWlV0Y1k0NzFCZ2JiYzMwNnBkaWVP?=
 =?utf-8?B?YzVOTkgzN2pjL29LRldGQjVPQzNtVkVJdytVay9LeStubm5aRmYyc2ZaVUNX?=
 =?utf-8?B?TnZUb01ndHRKWVR2dW5MRENQck1FT1FJd0s2SEZ4dVp0cFNIY3RsNmQzdGRv?=
 =?utf-8?B?NzRTYWI1MitQVGVVNXhMS1gwWi9BL3JxblRwTkUyTGYyaFpDTCtqVzZVdE1F?=
 =?utf-8?B?QmFoZC9mYWkyQm05bmVRMDZkZnQvb1QwZytuMG5GdzNVLzU1bGtLSEIycTFY?=
 =?utf-8?B?WG9uUEtFUzdYOXo1QzhyQSs3bXErODdsdEdDWml0ZGswTkExZ0U5ekE2c3hu?=
 =?utf-8?B?Z2hSNVk0cjMzNGRZODZEakJPM1E5ckNDVm85S25NYnlTK0xEZEdVNTQ5NGx4?=
 =?utf-8?B?OUQ1dERRY25EVk43ekJnZ3BXemI0bm9HZ3NnT3JhZ245TU9JZ3I4aFZMQVpK?=
 =?utf-8?B?R3FZSXlxY21abjFQcCtkRndlYU9pZ3hOWFRMN2ZJSXBxMVFqSEIwTURzekFO?=
 =?utf-8?B?V1JIdXUrQ0JLRldCTWNrbVBVRHFBZXVCaUhhR3VTQzFka0ttU3hDZDAraXlo?=
 =?utf-8?B?U0JNZHU5UWRZRTZBUnRlUnBhb1U1ZFJ6cjBwRTNnZjdmSVk1Yk5RY0IvT3V4?=
 =?utf-8?B?OFZ1MkVCZFowZEtpYXg5WFpoTFhMcGFTRWtFZUdJQk1CZ0ZiT2J6NVVZaXhp?=
 =?utf-8?B?S3pjYkRGTURubUZnQ0RZK09EdEM5d2ZkNU12MGRuSjJmc1NxaGtDMjdCQnlD?=
 =?utf-8?B?VDZnQ1V3Z1graHRXaGFLWEsvcWVtdTFyZElkaGFXK0FRM2kyU21RblUva2Uy?=
 =?utf-8?B?M3BOWHdLM2p6NVVxSlJPTjE2eFlsQ1lab1BJYytYY0VwaWNIQmtiMmtySHg0?=
 =?utf-8?B?d0VnZUVxb3JHTms4dWRQM1hDTU1iRWw2Z1YzZWhUVVVLRlY3QndaajhjV0l6?=
 =?utf-8?B?M2grbjZabjI2cm5wcUJkVyt0SytYckNSc013V2N6VUJPMTlWemZHR3hjanNk?=
 =?utf-8?B?Mkd2Q1BvRnpmamFsUzAzUE5YMWM3MXJ5ODFqVzRGR3YwSkFOcmVDM29KV202?=
 =?utf-8?B?Z0lWTkt2M1pIdFhzT1N3S1FVMExneU1ZOXcrMU1UM1lXVE9vODZBQS9rVzdL?=
 =?utf-8?B?M3B4ODRNaFowNmErQUJ3NC9wZmk0YVNvSHFIOWtPT0szUVFNZlRSV0RVckh4?=
 =?utf-8?B?Z1M5TStDMmVBekNuV1FvNXNHWWF0R1kyZHd1dXRZUWd5UXFNYlpKb25QMzNx?=
 =?utf-8?B?Y1FXY2pYQzZGR2kvTmxXbTYzbHZjZ0JzcFZpRmJud2VVUEYyV0dpV045OUkw?=
 =?utf-8?B?WFNEb1N3R21VOXdvazVBWWtVd3VYQkFoZm9RMCtsWWJaVndnRGVXTHg5Wm1M?=
 =?utf-8?B?TkRmTkE1RUZXSGtaVk5US0trMmdvYUpKYy80MVBHaWxpdVZOTURISlA1SDcr?=
 =?utf-8?Q?9mGO9GC21co=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTBwZGlRSVlWQjBURXg5TjBwNTZGdFQ2N3k5V2pPSEFwNytneS9mR3A1T1Fa?=
 =?utf-8?B?d3d0RWVmZlh3c3YweDJ2OEJlb2lEc1FXb0x6YUVyRUN5OXRhTW5GSkhjNHJZ?=
 =?utf-8?B?VFlqd1NvZGRONFVkZWM0UTZURmx0TVlyNDIrcXRiL1ZOT05xWFpCTVRsUHA0?=
 =?utf-8?B?Z3hSQ0pqWTlYTHE1Z0drSExYeURsMHdUY0xBeFBCQWlJdG83TTZnQ05rT0lF?=
 =?utf-8?B?MmxpVFFaUHlmVTNTQkQxUGtucHNueVlvSWs0ODVoV01HVmN4eWh5aWpwWklU?=
 =?utf-8?B?V0tneXk2bG1hKy9UalQwUWZUVTl5RTVTVHR5TVJSTUJBRHBIUEdzSUladEdT?=
 =?utf-8?B?T1lqOThUVU5iTnFWTEFnZk95RkNBSkZEMmcwSGNOWG8rdkFoWExLeE4zVDA3?=
 =?utf-8?B?M1lpb1IwVWoyd05KZ3dBOGkxRzZSUjFZNmthblFLM1BhMnY5ZllwZ3RGYnRp?=
 =?utf-8?B?b3dzYjVObE8vRDhLWXRVSmluZlJFZjhvRS9nRVdqWnRVdElOOEd1bjdNNTlU?=
 =?utf-8?B?cDUxYytFbDhoSGo2MEJ4OVFhcU9WVDA5U25xQU42cW1FTUhqc2gxaXV1K1ZC?=
 =?utf-8?B?RmI3eGNxMk1IbW1TMENDczZBZHRtSkFqck4wdGtVMkhsTGhnQUFwZEVIcWE5?=
 =?utf-8?B?YklXSDl2MHJXdUtYR29zdTdoSUdWVHdhSVkvWUVueDBkL2M4V2lhaUdhbkc5?=
 =?utf-8?B?bDkxcjZBU0RQUDBLaFk4Vmp0cmlZVWN1RFRSbG1wbk13MjR0L0VUQnFzdnJm?=
 =?utf-8?B?QWkwUlVKSmJtMDFBT2Q4Yk5zYnVkTnNYZmM4MERQLzMwamppRE5nTk1kRmpi?=
 =?utf-8?B?TnFxdTloWnUrWXh0YXI3TGxGaGZIZFpvREJhbTdKSWFXN2FXeWpPK24yVXNo?=
 =?utf-8?B?d1RyclNpRmF4UTlaTTJKSkc3QS9hTDFPR2wwVVRVNUpsVDFmNkpZRkE3VCtl?=
 =?utf-8?B?WGFSM3JUdWo4VGRBblN0WjNkOUZZRHh1Y2E3S0NXRkJZb1hHbEtxNkJ3Rnoz?=
 =?utf-8?B?NEJ5Uk56bTllb21KOXRGODl3a2N2SUFGU3lveGc0RmFSSTk1ditCb3kvendY?=
 =?utf-8?B?YlFNSzltYTlQK3N2Nm5CcDVvWkJBS1IrUWRCUFlaOVorck52aXVsWDF3ZTc1?=
 =?utf-8?B?WmJGNEl5ditMRW4xK3NuTG5UVzJicGJpOWk0TDVEQlZrZ3o4Yk5ZUFFsdWp6?=
 =?utf-8?B?ZVpRb2pmaGsyYmxVTUg2Q1pNYURjYnQ0WEdac3VBcHY0cUNRaWZyZlZVNURJ?=
 =?utf-8?B?ME9TZ3FveDlZbWl6WkxZWUZlSGN0ZEJ0L0Y5MGdYTWFrKzRzcnlJQUlQTkt0?=
 =?utf-8?B?VlBmcS9KREVPZ3hFT2pTazdxV05YcVRVaWVQL2hQUmd5NCtBc1J3cFF4Zk8w?=
 =?utf-8?B?RUxwUzZMbWloNHZIV042VnczRlRiN21OVmhCMWpoeE5sdVlkdVZPVEZQOUdo?=
 =?utf-8?B?L21sT1JheE56TFpJNHRNcTN5blU1akdCNG1YUzNZN2RIbFdHam1VL3M3NlR0?=
 =?utf-8?B?Q1lpZ3FMN0h2bHJZWnJBVmhoQUwwZHZEZnZwczdSRVRZSFN1dXhmT003MlJ4?=
 =?utf-8?B?UkNCNWJ3UXpaNCtlT3pzV1lMcXM2VlQwWHpJUzJ6NFc5bFR0ZlZTdWIxN3ZD?=
 =?utf-8?B?ejJrWkdtbHVwbFc2MEhIVmwzV3NzL2NlckloYkFEWlcyaEpWSFkxVEl3bW5r?=
 =?utf-8?B?OHNtR3Jyd0YyNEZDcnlLbkxUdGlUeTlVdm5wd3krWVNVZ29yUDB1cXU0MGpa?=
 =?utf-8?B?bGhqdWRWbHk3R2loOHo3NTErS1RQVE9kWS9zcWpZWE45aEtQN21vckJ5Q3hT?=
 =?utf-8?B?OTBJeGNrcjZoaHNkT3lnRHRVMHNlVnQwczJUb1FMSHFqQW9vSVI3dHNFR0Ni?=
 =?utf-8?B?NjdQNTJ3RlErdmVzemJPRE0rSUJxYXowNnltcHhaQlh1WVR5S2ZtMzdSV3dZ?=
 =?utf-8?B?SXJNYjBXY1ZCdDRIUjhxR211dCtmQWQ4dXd0WU1WUjZEN3pGTC9KdExhc1Ro?=
 =?utf-8?B?QVlEekZPbVZXZ0dLVUVMc2t0bHgxZVhTR2RvaC9kUlVqd1QvVDZRbm5iSlMz?=
 =?utf-8?B?eWdLYnBlcVlTcVV6cUt1dFZoaWtTdUhvT1hnZFA0K2NkT3lIdVNmK3FPZnpF?=
 =?utf-8?Q?3+FDg3TWkib4k1ADKpX8thJDj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cd1ac3-caa1-44d4-573b-08dca0edb2cd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:36:34.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuI/2nsrdT3cssqswfwj/RZqy0srwy1pbZ5UHv1/+krCTZJNwqo2C303F4h3G+wGITgfbUvx2+2RlBoXYHitSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6834


在 2024/7/10 22:14, Christian König 写道:
> Am 10.07.24 um 15:57 schrieb Lei Liu:
>> Use vm_insert_page to establish a mapping for the memory allocated
>> by dmabuf, thus supporting direct I/O read and write; and fix the
>> issue of incorrect memory statistics after mapping dmabuf memory.
>
> Well big NAK to that! Direct I/O is intentionally disabled on DMA-bufs.

Hello! Could you explain why direct_io is disabled on DMABUF? Is there 
any historical reason for this?

>
> We already discussed enforcing that in the DMA-buf framework and this 
> patch probably means that we should really do that.
>
> Regards,
> Christian.

Thank you for your response. With the application of AI large model 
edgeification, we urgently need support for direct_io on DMABUF to read 
some very large files. Do you have any new solutions or plans for this?

Regards,
Lei Liu.

>
>>
>> Lei Liu (2):
>>    mm: dmabuf_direct_io: Support direct_io for memory allocated by 
>> dmabuf
>>    mm: dmabuf_direct_io: Fix memory statistics error for dmabuf 
>> allocated
>>      memory with direct_io support
>>
>>   drivers/dma-buf/heaps/system_heap.c |  5 +++--
>>   fs/proc/task_mmu.c                  |  8 +++++++-
>>   include/linux/mm.h                  |  1 +
>>   mm/memory.c                         | 15 ++++++++++-----
>>   mm/rmap.c                           |  9 +++++----
>>   5 files changed, 26 insertions(+), 12 deletions(-)
>>
>


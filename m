Return-Path: <linux-fsdevel+bounces-23487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2692D3F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B9928326A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA669193465;
	Wed, 10 Jul 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QxITFXro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA30193443;
	Wed, 10 Jul 2024 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620878; cv=fail; b=oOAQBLDVF73tlx/fakwmpu+0VSjhRtmxxH5caZo+Y3GUSwF6csrDF+XFS4OZkQgl7dhyCBMAan+ASIG8Bby9PWXR724s0XVVhdXuitIVBMGp4HSKjxWijGuhLo1V8mc98qOgL/yBTqvrrDX1qVJ+qpTMnRHpuwzUWFmLn5v142g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620878; c=relaxed/simple;
	bh=USfxKGjcf/50UxVB4G+HQ1YwM4SHhsf6PbmNQzKd4Hw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FqHUAVjmW3yrnsJyttivhhFGl5IUUTmEBVtLHTjwT8Rces67i8x5SN5KdYGtcYXNtACsLlvHiDEj2tuaaQKEdjkyXK4MnZrUUy4UacOK1WoURyU+4IwMTpwAmhTXWCPyah1y0qVU2qY06jB5XQPyvagtL0LkaaI/rxqNzzAnQxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QxITFXro; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhg5CvDvcviyLeDRb+CIppRrve3pYxQt1QPJ0vyAFu1R63ZRCBTiV5UPY4z5NCFaevddP1xxzas5fn2KSYejY3dARXMiuYPumOQvRCqCTOqJSbsQCt7FYHImcOSCAqvlJ8OaOyl5TFuZJlOgkZtlL19H44DVaJZBHu+d8Pw/GRwaSKnfilvrXXDDLKyfYeN3CGaBCmmcvAGDWd24DP3bILnB1irfLmxKfbKOWIjM9pPk+g3SJNM+LSVzr08DP8viFfEdLhDdc3Ou4OMoaE6Mm2QFMf6+Ng180aLralFsslWl75t7lwz95nBunxuIoDv7GKJIT2j+p6YF302SthaNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXg/UvMrNkodY+WLZdhO7eXCazSysQEt/GjIHYiuI5k=;
 b=UHiop+MRyXG+/jwuDxll4rPto/HGjGNEo/worZO0UatmtnMS3nKnAy3aX2Elvxcc46qlJQYY8DbbJpOQC14/bau+8Yd7h1VQIFFGDNZv8yMlRMWYPeh3e4HbUGziZo9qvl3DfCP0m6E6kg7PjNyFcLrfQutvKDcDoQadhp1atqfn5VL2krcxC7C5V/RPFTTdRPNRGkt6zaT2YQnsbYfoQZ977qhKP3TNr8uErkgi92HRU+zvcTzaf94XxRTjT9ozquE+SXB8OvUzZ/PxjYE3lKcjtna1GXe9txf5lXsiLjVP31n7/zEiqC2t6WSe9LUGdVXPx7NzBw0e2mX0G55Asw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXg/UvMrNkodY+WLZdhO7eXCazSysQEt/GjIHYiuI5k=;
 b=QxITFXro642Dq2wgceuli9XmLPZmdszeuKacIhFT3IYITqQPF0kSHgFd66fdrNO4+jXoXH++uobLf7PZSY0nAP1IQjOMsTGcpMl95GyFv7eWXIb81/iUskQDjzgH76jA/5U5w4RzAfu6X6r0xoMczecHQ525pbMfdvTLWg4fy4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 14:14:28 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%3]) with mapi id 15.20.7741.027; Wed, 10 Jul 2024
 14:14:28 +0000
Message-ID: <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
Date: Wed, 10 Jul 2024 16:14:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support direct I/O read and write for memory
 allocated by dmabuf
To: Lei Liu <liulei.rjpt@vivo.com>, Sumit Semwal <sumit.semwal@linaro.org>,
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240710135757.25786-1-liulei.rjpt@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cecd69a-8f3a-47d9-bbcc-08dca0ea9c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGxQNlJjanpLektLNlFJVGJEZ3BDNjNjTHVZbGpIc3dVQWJnN0p1R1o3K1ky?=
 =?utf-8?B?Tk9XK3RibzU0NGFJdmljUmlQU1lUVytpS1B6YnhreDlpK1BiV2NVdEZVNVZG?=
 =?utf-8?B?YnVwb0g0WlVuRFpMbFU0ejRPa1VzblFWc25SQ0lVMXA2Q2E1TnMrMEZBdUZi?=
 =?utf-8?B?N0Z3Znh0NmxjcnF4OGhSVUZLcG4wb1hVSFlJV1p6Z2wwajRGSTdBcS9mRGJO?=
 =?utf-8?B?SFpxTVpoRWc0dnZmYm5wQXl1M0srbCtkTlNFZ21sdDNtK0VLQzlqME1KdnU1?=
 =?utf-8?B?OWd3YjZpTnVhYkdaZ1RoN0RaOWtRMnNJNEF4bUN1YzZPbytrZUxvTjVGZTNH?=
 =?utf-8?B?UGZMZVVvUGdURTlEY1lhc0MwZ2hmUUJyNmJxZEk3V3Z1NkFsSThzMnV5dTJS?=
 =?utf-8?B?VlVrTVpUTVFZRCtDWFJiT1hCcnJxSHFpaSs1WklDYmZFTFN5MXZwR1RhZ0lz?=
 =?utf-8?B?c2wyQWJGMTdzenNWNXJTeWJhTU1EekM0bHcvUG1XQTJOdnF5RldCV09hc3Vl?=
 =?utf-8?B?Z1RXZExLUk1mZ29LMnQ4QzBERkx3SFdhbithd21oUW45N2N4LytEUjVkQVBq?=
 =?utf-8?B?elFmV25WN3NpZ1FqSXFJZ3RHVjJhL1pVdjEzcWN0R2RwWHJZV01XYlZUMGR4?=
 =?utf-8?B?M1lwTCtZOHIxQVNIRkVDZFVGQ0tsdi9idDYzMWpKa2VDQ1hEVXNUeHZvbnNB?=
 =?utf-8?B?YmhCcGpsQlp5ZWZyVkVaK1pTMHBvNk9YZ25xZFFvTEhpZTlZU205SVRUVDNn?=
 =?utf-8?B?QjdPcW9xa3BPTG9kWCs0S1Y1NVFvQWkvTFFwWlRCNlN3WExYR1haOFZRVTVt?=
 =?utf-8?B?Wm15bmozTFI3SHZ4clh2WFNSc2ZGalBaRDVRS09wMnp2UUl5VFVKem4veE5k?=
 =?utf-8?B?dTlCRGtmalNpS3BLSHFBeGpsNis4aGphNnpydzdSelVQM1N0alUwMnk5SXJ1?=
 =?utf-8?B?WFppWExzZytOblZwV25ibjB5Qis3Qy93UC84djdMRjBPdFlGSnB1ZmxjYkdM?=
 =?utf-8?B?SUxCaFJ5cUs1NE8rTFYrU0tPNmlJVFlUVkNDOHMwMThpTTFmMTlId2FEY3Vi?=
 =?utf-8?B?a3hxZVlsb0FQWFYyT2VTa0VpWnF3NkZkamZOZ3hnUTIwWWdFS3F4a0F4bEhu?=
 =?utf-8?B?WStPc3JIVnI0NFgvM3dqQzI1N1NJeWRRVVFXMVorNThOcm5ub0htUXdjTUZO?=
 =?utf-8?B?L0pXbVRCQUllY1E3MmFZWGw0KzR1Z2t0QVo3Q2k4RnNwalg0a2ZQQWRURTVZ?=
 =?utf-8?B?ZVhSeUx3TW1IMllBamFkTXVEaENRdkdaeWZuQ3huZ2hlY2o3K3dZTGo1bDJG?=
 =?utf-8?B?eDd2Mm9RKzZwaXc2dDNRd1dWcExENURGa0xreHM1Zm9LVWlJYUtINFlPYm5T?=
 =?utf-8?B?QkdGUFVqNUpSODB4KzEzNndOeGZ0RWNkWjdiWVZER3k3K2ErUHpMQVpNQnpX?=
 =?utf-8?B?Sy9TWks5SG00MlF2YUlHZjN4V0hiekE1U1RTbUhya0w3dWUwNUFrVXUzV0No?=
 =?utf-8?B?SmFTT1FIQXRySFV1czB1cGlueTZ0elJ0Sjhrck1FeVFkQ3dsM3FOL3licGtZ?=
 =?utf-8?B?bmZXdjVYblFTdTR3WjcraHkzQWwxeVY3YmExUTFhQXdCTUlNbkdUOHZDNVpQ?=
 =?utf-8?B?VjZaeEhNY2RST2hSTjdBYjFFcTYxZTlaT2ZRVlJRT29Wb0FoWUJ0ZC9mb0dE?=
 =?utf-8?B?YlBpOENqanhQbWh3RGN4NGRua2NxdDFNdktaN1dJN3NTTW5BQURnVGFpMHUx?=
 =?utf-8?B?WXBiUXJ2c2lKVGZFOFEwSTdHcmp4d0MrZTFucUpabjR5U2lrVUo3NzdsT1dQ?=
 =?utf-8?B?bTJ6VGM2ekJHT0dzNVR4cGFBdjNXMzAyWHNSTjlOWjZ6SDM2bjFuU3hRdWFJ?=
 =?utf-8?Q?97XOFGk3hMauh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5673.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tmg1YWJWTms4RTMrSFVkcG9wK0l6ZHR2RlJOSFVVeXdwdC9UYmttNGxJNGZX?=
 =?utf-8?B?WGdXV1Z6QkRVOW1wb2NDVXFkVi82ZnhhblEva3BkTlR0aGNUdjRMdzNobDUz?=
 =?utf-8?B?UGhxMzh4UWlGYldlRFA5L3N5Q3JCUjNVd3Zha3RzU1JVeHZKWlAycUdRQ1lt?=
 =?utf-8?B?WnozUU50d09VVmtQY01YdGtHMGM1Znp6YUJaa3l1SnhhWjF1N3c3ckRSQktI?=
 =?utf-8?B?dlExSitPYWEyR0creS91TDJxalpuVEtCeGJOSXAyZ043M2luMjRjczhybTJy?=
 =?utf-8?B?SkFTMjZaOVJXNUtONGdrK2EvcnVqNWxzRGZnU0U5b1FaZzAxa1dDWThEZU5T?=
 =?utf-8?B?N3djWkhDbVdJUXpYUS9Ib2UrZVZ5V1FKNlFjOVNEcFRDaUFxTGtvaUdtbVVt?=
 =?utf-8?B?Q2FYOWVHYlhzM1VYVHQ3SVNjMzdOYlErakkwcWdsM0d3UTUwZzM0bFdHSzd2?=
 =?utf-8?B?a2dZMW9vci9lQThXTldiRDNZeXpMK0tpNFZaYjBXRlpHOER0cEpNbm82SW1G?=
 =?utf-8?B?SWdFU0o2d1hGOE5ZL1dDRFFSbnYwejNaRjBsbWZ1bEpsalBaK09aVGRTVENr?=
 =?utf-8?B?enZXNTBrQWozbHZSbEpXM0hubFdLdExRWmlGYmp3bnRWUmErRHFsVUF3S1Ri?=
 =?utf-8?B?QWlVcmd6ZVYxQ1V1SW9wY1N0UVlwMUw3MnF0UHpJVkJqWTdyLy9OVFZNZUtJ?=
 =?utf-8?B?Uk1wbWVqMnBXa05EaVA4L1RqV0FzTEVPcFAxZWRZWSs0QndDSEZnU2xsUzh4?=
 =?utf-8?B?V1A5RDdUeEJ6WW9nLzBBV0NwMnp4SWJ5VlJJaXROU1VsazBsOGphVHc1cUx1?=
 =?utf-8?B?RXFoajFFWlVIRW1JbUpzTDhONzZtbDNHZjA2Y1FHdy81aGVDdUsxcWV2MTVr?=
 =?utf-8?B?a2diUlpvUzZQL3JZQkdXeFBBU21oZHhROE1sc0hpS2Uxa3YwNytDRWZsL2Ju?=
 =?utf-8?B?WThsMmRJUDBTb1FqRDh5NzcrdDlZRDJyRThRTXhKemIvTDA0enA2ZGxPNGU5?=
 =?utf-8?B?c0Q3aFB6TnkvOFE0SEw3TTVVN3dXM1NNQ1hWSHpSMDFyR0ZHZmlYUTFzbGl2?=
 =?utf-8?B?OGhVbXl2WWNsdDNGOUw5UXhLMTJ6VWZHZXd4KzFaRG5mTUc2U0pucEoyL3M5?=
 =?utf-8?B?eHFVM0xZWlVvS1BGQXZLQmVzK2ZWaVhBc2l2SGJkYTJ1bTRLdjNnZzNWTUg1?=
 =?utf-8?B?SGhQRjdUMjFxZzNLcGRodE5QZHU1Y0dFZG01MTFYVzkrdDhiNm1TMWRMaEV1?=
 =?utf-8?B?ckdQZ2VIM3FGY09rVk5IMjh2ZTN3VjA3KzBYYWd0Wnh0RXlseWx4alRPMStH?=
 =?utf-8?B?YXBSbmhZVXhXYU1QZlZweFBYREMyV3NkTm9nU3lrV2liMkM1eGFVUWRON0E2?=
 =?utf-8?B?L1ZFYUlPQmpwNzhMNU5GNmJWZjN4b2hkVXF5dm1RMkdJeXU4R3hidm5xSGNY?=
 =?utf-8?B?OHFkZ0xMVE1IS1MyK1AwczV4cjk0NTZYK1Zvd090dmdDbGkzOTZOSTNDeWhX?=
 =?utf-8?B?VFJwcjlpN1hrbXUrZEw3a21WMVBnNXAzN3NhQVlwaHNaamVjd3NjWjlwekhh?=
 =?utf-8?B?UWFJWDdCQXlmNE9GSjNtc1JQSkgzWlpFMDg2aVV6d2tzL1UzV0ZhOVd0MUw5?=
 =?utf-8?B?SGI3aktyamV1TjdlTm9vak5qbkdIdElCMVJhWVUreHNSa3hWd09PSlFCZW8x?=
 =?utf-8?B?TkEyRXFtM1hFdithRlhWbTVOV25aVEFsZE9qNzBnS2xyZ3N4R25yNDJLZFVt?=
 =?utf-8?B?TXRFalF4bkpRclgybFpGcGphb0VOejRkNUlCZE5ya2JXNThnVmhmb1BjRHZu?=
 =?utf-8?B?cU02bDFQb3ZQL2RKUHN3TU5RVitoM1NzZmVSK2hJRkQ2WnBISDRsd3RJWWtk?=
 =?utf-8?B?NSt1VFYzSjg3Z0JtTlUyZWV3Sjl0bFI0YW9aTGNYMkJzMUZ5WjNZVXRERDZB?=
 =?utf-8?B?SC9qazdLcEozTW1mU2I1NHNPYURsWSt5Yk9CVkJlVGN1OExjdWRhRmZJcjgw?=
 =?utf-8?B?b3FzOWpUSG4xb3dBT0JVS0xnSXhOd1FERUlMcXpRTWJEaENjOEtlKzV5QWJn?=
 =?utf-8?B?SG1wdFlOZlJVQVdxVTliV255QjMxQURLVGRIUVpEUHg2VFJEWU9MdHd5QS9q?=
 =?utf-8?Q?kyVG16EdtF+cqYB4fUfd670Iu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cecd69a-8f3a-47d9-bbcc-08dca0ea9c13
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:14:28.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+xN9YAECsebkcfY9Abjo4u8mDGePX63Z3CSUfXNSRP7RmjjnvtfJWM95eOLg9Gh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

Am 10.07.24 um 15:57 schrieb Lei Liu:
> Use vm_insert_page to establish a mapping for the memory allocated
> by dmabuf, thus supporting direct I/O read and write; and fix the
> issue of incorrect memory statistics after mapping dmabuf memory.

Well big NAK to that! Direct I/O is intentionally disabled on DMA-bufs.

We already discussed enforcing that in the DMA-buf framework and this 
patch probably means that we should really do that.

Regards,
Christian.

>
> Lei Liu (2):
>    mm: dmabuf_direct_io: Support direct_io for memory allocated by dmabuf
>    mm: dmabuf_direct_io: Fix memory statistics error for dmabuf allocated
>      memory with direct_io support
>
>   drivers/dma-buf/heaps/system_heap.c |  5 +++--
>   fs/proc/task_mmu.c                  |  8 +++++++-
>   include/linux/mm.h                  |  1 +
>   mm/memory.c                         | 15 ++++++++++-----
>   mm/rmap.c                           |  9 +++++----
>   5 files changed, 26 insertions(+), 12 deletions(-)
>



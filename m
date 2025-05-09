Return-Path: <linux-fsdevel+bounces-48582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6CAB119C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD871BA17FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64212291161;
	Fri,  9 May 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vqsPHl0u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021135.outbound.protection.outlook.com [52.101.70.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F827FD57
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788830; cv=fail; b=gCfo1eJD5gRkBRKJFyF0d+CmKiXL35MNIdh6STDYFbl+npbuWg3n5bWN2bAYhhz74jSZSjbhbtPuYev9eMBvg04PxPWKZFfeMEb5oW9a0fxSk9DHXr+1KUbSO8liRI+zL2yXWIcEIGhW9TmekbAwLOn4AGO3gmTab+VI1KLrdto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788830; c=relaxed/simple;
	bh=VvUiZzCqgBWKmIJpPdI4uA/4xtk/COcz1ow9j5B5tUk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gWF++AOIZOHW3a0f8EK7AvThVQ370rBYvsJa9UP7pBwh2LBs64OJhL+Z4ZHUMomFLwt63ni3mDnwTDY1KgI26X8fEnqI8rr0b5C7wlGhYwIYGHtgcZ99kMZ1NT6TiA7FyQ6SItvy+AdYz9FR/My691LVR/mRitKeJLMD4oJSb2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=vqsPHl0u; arc=fail smtp.client-ip=52.101.70.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRLyUOrbAfcMzywqdLkUHXKYGKeb0o7wi5Bvtl2iwB9/OlReQ2S3AcENiikXQ9Il8GQXznVZNm+UtCslE9WgeNFfEnT0P2z+xsNO2v2csfIff3uL2gZHgOU/30SJ1HcfbaJnY1O9EbbVCACH7xqnA4Jk1m7+1AStDycLiIpFHYGkBOk+zNu9QOuClnmcB89jRRqy3yGzrWEbdPGJDFv+7EJ24aGKOVItvpxdYnZyWWp/Vv6jLybfKBBLK8JEcWto01sH4oeWDoLWLPIwDnZ2wHI+wbedTVPwnOzH9LR5L3ez31IzIi4bZxxSVP7UD/xt38wlftiiwfkFG6JyIGHE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTSwG7gwVXiNQAWrYsNN1OUxXfjpipfeFA9CHqpbgbk=;
 b=f3ANetCMJnk5yvUJ4h1w5YF+bo3r0Lf0ZUULEhldrAJ3zkeSmLa9hrmG8ce4eDtx00T9cFmO6V6Itzxs5dH6Ww4BMBDgpdNiJd0T903seJ5NHxKFQF0U9uwmPSF52DStMrLktsX6WXTfMWtTRld7JjJEU69HYCouXmloCTJUz92r48VsB+qzXsYISAgsMw6GtwPE4wTOf5Co/1hmbmcB83kYeU8wiJ5NUEUhz5sFI2oQVP4X3J8mvc8nNjRsxFApaKZ9RQgfHEK9XTk2OuLSnf+afJYjEy559KtmOAZ/okU9lqNVVX73D5qgzRZamaOuVjtXkMLTnyoqcRg4ESZLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTSwG7gwVXiNQAWrYsNN1OUxXfjpipfeFA9CHqpbgbk=;
 b=vqsPHl0uPCw2EXkvfEmh6yjz+bpngvysr71B230oV96Jy8xBRMRqphI3lTH3v1zOA+iFcCeTGBIq2J/rS+JcKI9TT0RTY8tWhFaLOuGoUlbPgKw57sIGw6auMT/22IY3P34/CKqhdrb3TaNrtt/cBF/wquhuX0ADdos/RIIy7fmwUkZhSuHJ8l5/k7ef+5OBDqCYXmCgDCxOI8cUJv48xD19a9Cyhk25zCyFieOqUBhANCyd+cyhEDk8PTMBUbKlbqGn7gRilRDHBM0wg1MNnCkIF0pfL3IhiQwmVHqolfeVENIpl8TI/Hu9BnBkl+jkabnP/CPE0zUtuXQ1uTczvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS4PR08MB8069.eurprd08.prod.outlook.com (2603:10a6:20b:588::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 11:07:04 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%7]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 11:07:04 +0000
Message-ID: <6f808c86-1f1b-4f61-9e58-1232e3ba0c9d@virtuozzo.com>
Date: Fri, 9 May 2025 19:06:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] propagation graph breakage by MOVE_MOUNT_SET_GROUP
 move_mount(2)
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
References: <20250509082628.GU2023217@ZenIV> <20250509082845.GV2023217@ZenIV>
 <2c1ebff3-c840-4f68-84a6-87ae6b3b4a8e@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <2c1ebff3-c840-4f68-84a6-87ae6b3b4a8e@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0080.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::20) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AS4PR08MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e3b2a5-50cd-487b-1148-08dd8ee9a175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzN4SXZUY2tUSm5sZWZPTXVNdVJTWGMzd3ZTRG40S2RiZzNJMU15dUoxaDlE?=
 =?utf-8?B?QzJYc280eHNLUTc1UEE5SXY5TjluRm5xY2FMcW5RMHozMXdwMmVWcE9pZ096?=
 =?utf-8?B?eFhINlhVMW5zS3hCWEV2dEZlK1pJb1RLVnQ3Njl2RmtWYmdwaFNzZklGTVlo?=
 =?utf-8?B?cG5xcEtlcTdZUE15SkRwVjgwSWlvbmthZUZLTkV4ZkFOMWhVMnNkNE5MYlNu?=
 =?utf-8?B?ZnQ4NG5NMVJQbnZ1V2dDaW4yYllLNU15dUlsYnJrZkZYbUFEdlRmTkdUVGhH?=
 =?utf-8?B?Z2FLMkw1ZUc4ZWpxbk56T1JGZ092QlpjTU9FajZlaE80T0tiOFdwZWdBRjdC?=
 =?utf-8?B?UG9mei9Ra3ZHVmdTRGcrcUpOUGp1QUM2L3RjdFp0VnFxODlMOUhDZkZFTEVE?=
 =?utf-8?B?R3plNjlZUExiZGh0SEZIZjZHQ2plRjY5YUdNY2UzaE9RODB1SmRKSkNLbjFs?=
 =?utf-8?B?TEtKZWYxS096eE5vMmJvUlhiMFlXcjlPTERGaklnVGJMRTNBTUxXakVmV21n?=
 =?utf-8?B?ZGN1NzZSVE1KcVdaQTlabDJ4TWRnbFNhWVNMdU5qdy85cjhJUFFWb01lTW0x?=
 =?utf-8?B?bkwrcFhaVm8wa28yQ2dNZE1LM0pQbDk3bVNSMzRpQ0NJL3Vnc0FZYXpVaEVq?=
 =?utf-8?B?WW53TCtSdkx3WHg0QVFQK3Y4bmd4OGNOTzl2c1ZMUURMb1hiNmNtZURNdGts?=
 =?utf-8?B?NWJwWVNxd2xXMS9UcHZjK2V1b2tFVzRlZGRkODltMlZFZjhoMUlpSlY4SVRL?=
 =?utf-8?B?aE96c25jb0VvMURqZmFFR3BWUTBDY1ByZHdMbThlNGVCVWFvMnZyc0VWSWFB?=
 =?utf-8?B?YVFpcHJiY2ZRcDA5dXBEVmpDcnFIZ05PaG9ydytkS3FJR0d0YkVUZUs5VXRF?=
 =?utf-8?B?MXBjSktkZ05uaUtZUGxnaEJkbjBqWjR2WDNvU0JWdStkbStJa3VzWjM1Sktv?=
 =?utf-8?B?eXF1RGdGWHkxalZmRUhuUmZYL3VESXJpRzl3a1ROUTg4SDk0Y28wQnVldHoy?=
 =?utf-8?B?eHpWY1p4SmQ5RlNQT3JPQnVuZ3Z5OXpYOThnQ2xLZm1EemwwYzROcnRtR3RM?=
 =?utf-8?B?THd5N2ZYclNsbVdabHdsazMvd3R6UWhNVVVHU2ZKOFMranlpWmdxVFoxTDh5?=
 =?utf-8?B?THB3Y1FndXhvOGQ2Z3RzWmo2Z2RpdHZncmFrUVJoenVkY1hZdnJXL29FOVh5?=
 =?utf-8?B?NGZUc29IWXdKMENZYlpEaU84VCtuMEh6cElTbWVwSnB5bjJEeVBoOGE0K1kv?=
 =?utf-8?B?NmZxNGx4ZTVtMzZBYWNEajdNYkZUVFZ1dTRtQ2NERkJ5VU9ZNGwzY0c4UlFs?=
 =?utf-8?B?d2Rqd1BKUVI2SUZMOHlKNWZSYkJzUEUzMzFCWTUvQmNpRG5HeGNzQ2gxTEha?=
 =?utf-8?B?a3c0UnExempQTzlQRVA5bDNITzBQa2tGUmZYNTFaNk52aUlnUXo5dmdEQVlM?=
 =?utf-8?B?S2M1bEpQZEg0aGxTZTVzUEYxTGt3cUhOdjhBMW5XMlJwdGhOa1l5bkdZZFVH?=
 =?utf-8?B?ZDFPRFVzOEVZUGRKTHpTbHRVRTFjejNUS0tBeDIyT2o3bWZoMmE4WVJVWWx1?=
 =?utf-8?B?Q2FuVEtNTGxOUk1COFg3VXh6OSt2VmkxRVhyT2hCT1FaaW5yaWs0RzZOcCtT?=
 =?utf-8?B?czNITDkxVEw0cGJnWGpVMThINmJrMXUyc1YxUU90bk9xdGRzL3hNSjIxMGEv?=
 =?utf-8?B?Q2FvM3VkRTg1M0ZPRjhUVmkwaGZSL1RzUFR4ME5nd3NvSEtZTW9HYis4Z0VQ?=
 =?utf-8?B?SG8rZTdESDBTajlFZUZSVXVXZVZOYlQ5b3ZBL2lVakNha3pJOTJqczJMYk1R?=
 =?utf-8?B?SHVUYmdLMkE0WFZMeWFlS2JVRXZFREUwbzdtMndSdlIzWkNvbCtiZXBmM2FV?=
 =?utf-8?B?Ukgzcnh0MEdJR3QxYWZ3cnZ6Z0RhenZMakVPR2xQZFM5YVBmZnY5YmE0Nm9k?=
 =?utf-8?Q?A2ARtpZq9bc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alJ6eFdGblFVNEVjcjhteW0vNWwwL0E1aFF6S2MyZ2xCQnpRa0F5aGEveEJN?=
 =?utf-8?B?MFZ2d2xSdE1HNmhwa2JlWWNCa29mbXRkWVZSa09PRSswQ1dCTE13c0dBS0x0?=
 =?utf-8?B?bWo1V1RkSXF5U2E3NjhYbmhqQ1BSOGY0SUdXYmtvSWNuVEg3SW84RGxkS3pZ?=
 =?utf-8?B?V3dMaTdaS0pxcWVmREFzYTNyeUdnbDJNMjNPWHdoaXFsRUFYaURTV2hac1ZV?=
 =?utf-8?B?d25HZWxCZnNLeWl2dW5JU3UydTVyM1ZrekJaam4yRzgvSUpwaUhxKy9YQ1lN?=
 =?utf-8?B?c3NYdTBCWkpveUFjeXU5eGtNclJKV3BIMzNsWnFNZWEvc3gvUDNkbjRvMDVI?=
 =?utf-8?B?OFFrdUlWLzFXTkFRUjJnWnF0LzJHM29obU1BWVFzSnNST1MzYldnRHZmOStL?=
 =?utf-8?B?c21SQjREak1UQWlyQmJTbnVMQ0E3YUp5aFlNcUxMUWJDRzROSElUYXlkVGNL?=
 =?utf-8?B?bVRzV05sRjF0aFNuYXlSOFNRRStxMlh1Y2toSEVoYkNLa3NuZnRCdno1V3dW?=
 =?utf-8?B?MnNPcEtuQy8weTV5QlZ0R01iRmJrL0RvTEdxZ0V4QlZLY3RGdS9iN0NlTStP?=
 =?utf-8?B?STlyYmY4eWZ4dmtVNUE5Ylh4L2JvOHYyQ3M4ZEY2eityWWU3NzBlQU1FallG?=
 =?utf-8?B?Q29kTDJoWmNRbXJ1MkdpNHRud0dtMS9WUmhBMmtqMm9SV1N3RFg4WTVRUDRi?=
 =?utf-8?B?TEp4ZFNaMkVGRURnVFZBMnBSQmZIZmNNYmJibGNKeWgyS2FjcUVLeXhUdlps?=
 =?utf-8?B?ZEVtOXVGS1cwY3BFVnJaSytoMzZzVkhWUWt1MTVPZ2RGK001alpNa2pzR2p5?=
 =?utf-8?B?YXJTb0pPSG1CZUxMVUpoTmhIWlhNam1PQUtISFhJMC9nTExuT0E1OURNam9G?=
 =?utf-8?B?WW5uTUU3d1FvWWt3eWdwNFBib21TZWVJeDN6ZytheGUrZDVUNUx2MHM4Qm5a?=
 =?utf-8?B?d05rM1IvL1NUQituWnJnTzNKcVFJUFlhckpLVnJKbTJLb3N5bFFhV1NZNllS?=
 =?utf-8?B?Z1U2Q2pGU0ZxTEhOMFZCclAvZ3JIMVVPMmo3Mi9NY3Y1aCtyTmtuQk1GSmt4?=
 =?utf-8?B?RTljM0dwVWhiWUZJTlZVNDJ2TzhpSWUxR0IyVHNKRGRMMG9iZjI3N2dvUVJh?=
 =?utf-8?B?SndrSlVCVmVRMENQd0JtL1FTYktaNnZQa2xZUW1DeEZXQ2pNbjFtOGtxR1RO?=
 =?utf-8?B?OXgxSXEyNXpEbU53RzF5Uk5WQURYWXB6UnZaZzczVkduOGN5OFJMUE5scExu?=
 =?utf-8?B?dE9zRGtzbXRiVXR2UVpWQWxPakh6SVYxb1NiOGwwRzUwRmxhZDBwKzd2VUNv?=
 =?utf-8?B?MFhIR3MyVEg4TDk2S0VGaG8zc2tPVjRscFJPblVvcDUzU28xMTQrcWF6dmpM?=
 =?utf-8?B?ZjZGMCthTzliSjNIQ2k4bjlyazdLd3VaYkhDdDFqQjdKWWtRRU9SU3RJdWtS?=
 =?utf-8?B?b1FVOGQxOHh5RTVrY2lHN2QzYWQwaXBQS2l5ekNDcUpFNVBoVEpDZ0hVcTE3?=
 =?utf-8?B?dVRMd2NsdWpRR1c0RkpTbmFOVVArSk9YMHQ0V1NOWkV3N2p0aTNrMXZ5T0tO?=
 =?utf-8?B?R0dTdzBEQWxZamhFaG9SSW1PWWY5UjlCZm5WcnZuMW9oWTBlSjRtazZ1bWtR?=
 =?utf-8?B?Ri90RFd4b25ET3o0NVQ4QXN2M2J2TnZiWWEyd3BJT0psb0tweUJPOGdNdjVW?=
 =?utf-8?B?NkJvRzUySVdOQzFaRWRab0ZqNS90UFJnbW9YY2owNVhSUWk5NHRpaFd1ekx4?=
 =?utf-8?B?ZzZEc0xVVHd6cDY1NXV1cWNVVDRRK2w5L2sySFZkanMrS1d3VFJXdG1rQS94?=
 =?utf-8?B?eDIwS09vNTBQWmFoeDVLL2UwMkNlMnY0dE8zNDNGU2xYVG9RMmlmUEg0dVUz?=
 =?utf-8?B?N0VQMUhIL204U2dWNzlYZUpmTU9DR3luODQ2Qkh1WHhaK0RLUVpRRFM2TVVC?=
 =?utf-8?B?bTRVZitkTVZJTjJLeUo1OXlaVkVMcVgrUWdIaEFzMkF1ZGxwMFZYVVFGTjlN?=
 =?utf-8?B?V3ZvMjFuK1ZVcHRoa3RSVWFVU09PdTluU0c5MGplVWhtVWFTRlpnUlo4dnM2?=
 =?utf-8?B?VlR5Uy9Ud2s1eklNSG55QlhiUDBkVFRiNjhzdDJDOUhZWmE5cVk0RDZ4Y25X?=
 =?utf-8?B?MEp0MDFqeVRXWjZMVlBxaWFsYndsZ1h3dGcvYTFzaFlhK21lUWlGUTB5Z0JO?=
 =?utf-8?B?Mmkrd25rQlg3L3RHWjZ6UjQwMEFaRk5RK0FoUWlWMGhkVW1Fa09VUERtNmxP?=
 =?utf-8?B?OVl6OGNSeDJFdStmclpaclVLbGxBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e3b2a5-50cd-487b-1148-08dd8ee9a175
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:07:04.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrlJHcucxiEXFv/qo9b47J+Bncgge7Yf6iL53EEcIhXuTzCM4iK1LO/vFnrrM4lSwM8R69G4CauV/tnUJQTi0RwEaJ7569EviC2ATSdptTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8069



On 5/9/25 18:59, Pavel Tikhomirov wrote:
> 
> 
> On 5/9/25 16:28, Al Viro wrote:
>> On Fri, May 09, 2025 at 09:26:28AM +0100, Al Viro wrote:
>>> AFAICS, 9ffb14ef61ba "move_mount: allow to add a mount into an existing
>>> group" breaks assertions on ->mnt_share/->mnt_slave.  For once, the data
>>> structures in question are actually documented.
>>>
>>> Documentation/filesystem/sharedsubtree.rst:
>>>          All vfsmounts in a peer group have the same ->mnt_master.  
>>> If it is
>>>     non-NULL, they form a contiguous (ordered) segment of slave list.
>>>
>>> fs/pnode.c:
>>>   * Note that peer groups form contiguous segments of slave lists.
>>>
>>> fs/namespace.c:do_set_group():
>>>          if (IS_MNT_SLAVE(from)) {
>>>                  struct mount *m = from->mnt_master;
>>>
>>>                  list_add(&to->mnt_slave, &m->mnt_slave_list);
>>>                  to->mnt_master = m;
>>>          }
>>>
>>>          if (IS_MNT_SHARED(from)) {
>>>                  to->mnt_group_id = from->mnt_group_id;
>>>                  list_add(&to->mnt_share, &from->mnt_share);
>>>                  lock_mount_hash();
>>>                  set_mnt_shared(to);
>>>                  unlock_mount_hash();
>>>          }
>>>
>>> Note that 'to' goes right after 'from' in ->mnt_share (i.e. peer group
>>> list) and into the beginning of the slave list 'from' belongs to.  IOW,
>>> contiguity gets broken if 'from' is both IS_MNT_SLAVE and IS_MNT_SHARED.
>>> Which is what happens when the peer group 'from' is in gets propagation
>>> from somewhere.
> 
> Agreed, list ordering consistency looks broken by my commit.
> 
>>>
>>> It's not hard to fix - something like
>>>
>>>          if (IS_MNT_SHARED(from)) {
>>>         to->mnt_group_id = from->mnt_group_id;
>>>                  list_add(&to->mnt_share, &from->mnt_share);
>>>         if (IS_MNT_SLAVE(from))
>>>             list_add(&to->mnt_slave, &from->mnt_slave);
>>>         to->mnt_master = from->mnt_master;
>>>                  lock_mount_hash();
>>>                  set_mnt_shared(to);
>>>                  unlock_mount_hash();
>>>          } else if (IS_MNT_SLAVE(from)) {
>>>         to->mnt_master = from->mnt_master;
>>>         list_add(&to->mnt_slave, &from->mnt_master->mnt_slave_list);
>>>     }
>>>
>>> ought to do it.
> 
> Yes it should work.
> 
> In case (IS_MNT_SLAVE(from) && !IS_MNT_SHARED(from)) we can probably 
> also do:
> 
> list_add(&to->mnt_slave, &from->mnt_slave);
> 
> as next slave after "from" is definitely not from the same shared group 
> with "from" (as it's not in a shared group) so we won't break list 
> continuity.
> 
> That will allow to simplify code change to:
> 
>          if (IS_MNT_SLAVE(from)) {
>                  struct mount *m = from->mnt_master;
> 
> -                list_add(&to->mnt_slave, &m->mnt_slave_list);
> +                list_add(&to->mnt_slave, &from->mnt_slave);
>                  to->mnt_master = m;
>          }
> 
>          if (IS_MNT_SHARED(from)) {
>                  to->mnt_group_id = from->mnt_group_id;
>                  list_add(&to->mnt_share, &from->mnt_share);
>                  lock_mount_hash();
>                  set_mnt_shared(to);
>                  unlock_mount_hash();
>          }
> 
> If I'm not missing something (didn't test yet).
> 
>>> I'm nowhere near sufficiently awake right now to put
>>> together a regression test, but unless I'm missing something subtle, it
>>> should be possible to get a fairly obvious breakage of propagate_mnt()
>>> out of that...
> 
> I managed to see weird behavior like that:
> 
> # rmdir /tmp/{A,B,C,D,E,Z}
> # unshare -m
> mkdir /tmp/{A,B,C,D,E,Z}
> mount --make-rprivate /
> mount -t tmpfs tmpfs /tmp/A
> mount --bind /tmp/A /tmp/Z
> mount --make-shared /tmp/A
> mount --bind /tmp/A /tmp/B
> mount --make-slave /tmp/B
> mount --make-shared /tmp/B
> mount --bind /tmp/B /tmp/C
> mount --bind /tmp/C /tmp/D
> mount --bind /tmp/D /tmp/E
> ./setgroup-v2 /tmp/C /tmp/Z

Note I put ./setgroup-v2 code here:
https://github.com/Snorch/linux-helpers/blob/master/mount_set_group.c

> mkdir /tmp/A/subdir
> mount -t tmpfs tmpfs /tmp/A/subdir
> 
> This creates 16 subdir mounts instead of expected 6:
> 
> cat /proc/self/mountinfo | grep /tmp/
> 1071 1065 0:109 / /tmp/A rw,relatime shared:556 - tmpfs tmpfs 
> rw,seclabel,inode64
> 1073 1065 0:109 / /tmp/Z rw,relatime shared:1040 master:556 - tmpfs 
> tmpfs rw,seclabel,inode64
> 1076 1065 0:109 / /tmp/B rw,relatime shared:1040 master:556 - tmpfs 
> tmpfs rw,seclabel,inode64
> 1077 1065 0:109 / /tmp/C rw,relatime shared:1040 master:556 - tmpfs 
> tmpfs rw,seclabel,inode64
> 1078 1065 0:109 / /tmp/D rw,relatime shared:1040 master:556 - tmpfs 
> tmpfs rw,seclabel,inode64
> 1079 1065 0:109 / /tmp/E rw,relatime shared:1040 master:556 - tmpfs 
> tmpfs rw,seclabel,inode64
> 1080 1071 0:136 / /tmp/A/subdir rw,relatime shared:1041 - tmpfs tmpfs 
> rw,seclabel,inode64
> 1081 1073 0:136 / /tmp/Z/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1082 1078 0:136 / /tmp/D/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1083 1079 0:136 / /tmp/E/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1084 1076 0:136 / /tmp/B/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1085 1077 0:136 / /tmp/C/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1086 1084 0:136 / /tmp/B/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1087 1085 0:136 / /tmp/C/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1088 1081 0:136 / /tmp/Z/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1089 1082 0:136 / /tmp/D/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1090 1083 0:136 / /tmp/E/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1142 1089 0:136 / /tmp/D/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1143 1090 0:136 / /tmp/E/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1144 1086 0:136 / /tmp/B/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1145 1087 0:136 / /tmp/C/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 1146 1088 0:136 / /tmp/Z/subdir rw,relatime shared:1042 master:1041 - 
> tmpfs tmpfs rw,seclabel,inode64
> 
> Maybe that can be converted to a regression test.
> 
>>
>> Not sufficiently awake is right - wrong address on Cc...  Anyway, bedtime
>> for me...
> 
> 
> 

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.



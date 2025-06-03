Return-Path: <linux-fsdevel+bounces-50456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB68ACC72E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48433A428E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF8230BF8;
	Tue,  3 Jun 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SattBQIW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SattBQIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F222F177;
	Tue,  3 Jun 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955612; cv=fail; b=fD+Vul7xAwRatgeF8Gw2aNLlqBcCh+McOkMoG8PimK5T/rPJMYZVNIMwjGKqqfkB030TKwCUnaJv4QpohTmrEf/9gLTDniH4F7x5ZsnYaOCFYFeCJPEEREiYyk5WLMGWgTwvskhVHemDzOB9fNDOVaa37HiHw8eIOVCobp4sTRo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955612; c=relaxed/simple;
	bh=l5ztr43gBzLqfS6ix9d/vsGqjrGPHsOUnBYNQwYOmeg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NAk4A/JVgVhhH8f1VFQ7Fdb7ZzoKhVIRVA//4bWeJ4dM0wOhGXVPP0BqQZ5gsd+y/E5NNqo4joPnbGXYn3m9FK7+WmTXsclBDMRCZktirBXLVpTYLx/rYmNaJFnNItTZW0I6oJ229UqiEkLr9CibOUXRrnCZeXDMPfsDkiWgYFc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SattBQIW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SattBQIW; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=O8jX+3A0chNRp70p9MbqbAu2p7h7PSwqNa+0KQApnSMakS7G+yWaQyWUx2QieyYF0+uONAGatlraDx4cERCUZ/atH2UouYWqeC11MgzNkaHsEOLy92oXqW/hjfyFxg731HwH3nWGfvUAEDKxkGavOVmr6QWjXkvS4KcbgCn3Y2Wxu3QKRD8a3WxANTH0Rz/cH14n15m3jvsIorciBWLbJctF2pvipZTcTs4S8tZ/nWTEkgaMUS3ysIw92Fjk4fFvMSvE520XiCetIvrD69AjWu/uGcSg1hcIu2NE6fL10nKt7DrEOYk5hWBFG1oi95T6tW/YrmlJjztVeFSzcJRS+A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5ztr43gBzLqfS6ix9d/vsGqjrGPHsOUnBYNQwYOmeg=;
 b=GiHTSkvLWdkPnuxuv7pLnq8TdQE1OxaVk3waMN2E4h+xNuSjnUVQaaKLRONm9515PvZnrSv9XXtRlFdgBm7u+hx16q0LIaOuTgRIlJee0B1D9bbhpj95xLCZg77favwr0IP4qzZYkvC+NmSFI9PqyWZbt3NlMtebyD4nMetdxSyaddFvAXt9l5i8JZaPDzJ7wR1ey23c0HRM2bJRBPD2oix7i0tOCqaotZPjAf6t5oxOGVAhQ2E7vjA13zJxaAPuboWTV1boqeYQKv4lPkVbFNqwm21q+fyWKRobi0f7ElopPisbtHtA1XhLWA+T5anFGPY9VJe0QFA0yiFNoDmG4g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5ztr43gBzLqfS6ix9d/vsGqjrGPHsOUnBYNQwYOmeg=;
 b=SattBQIWoJhTxb9vnFf6jWocFFQjc429YojXm2xCAnyVk670VH3Cwhyi80kTUvTI3LnVQ13R06xEgZp1sngDFQft8YoBZUL2zhK4AUR+qLUKoQ9Lffrisk8A/mS95TqGVyROoqLP3YwS9FxAhT60x1hqbewyvs6gk8ck9MGW+VY=
Received: from AS4P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::7)
 by AS2PR08MB8309.eurprd08.prod.outlook.com (2603:10a6:20b:554::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:00:05 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::49) by AS4P190CA0017.outlook.office365.com
 (2603:10a6:20b:5d0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Tue,
 3 Jun 2025 13:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 13:00:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCLCl+CXgG4plneNYfBFKVE+TFVHlOfuHFvoQFCaL9iauluN7ZchOQNd20o3ZMyxxM75Ys6X0qaBwrol7tki9MPwQIhJFdenCfUJBhgeDaub1XyVKjrjYBtr/fjKGY8q0qvNO75f/xvLDAj6uxe53FldNKDt1XrRtR6OBSI4hEp6921rjyB4OXSZUpkSNQmjpr9ESXACiXEW3wqUnIHmKut0WVcEsZwfMLYvPRo1bbTGbfrAnVDFVZPIYhd4HbmMhJP6iiDE2y3X7Vb6zEYHBitU7ENBBMm4HCwioJROIMCaok+dbu6UBuYJzB2iih3TO50Z5+qqx3Li//qgUkxFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5ztr43gBzLqfS6ix9d/vsGqjrGPHsOUnBYNQwYOmeg=;
 b=or3cL5q/7oE3nooqztoo7Mpw2rN3AvrKypDLkP780pjUU3giLGrFye1bt6GtjDrcM3ZGG/y4hSEByKk7DCvx2oH4cfTm+iTb1mojzsLom5rXOYpITRFwaioJds0ThKdhpdooxQhgCSZcDY62WuqAbllqQYEdwPisl9bn9hov4aDA03b2o9d+HkYDwfJP+3hvwcSSJ3ukD2iZQOxrDAL1E4kBdUJl9A0U4EFi5mQS+QeBECVIfwlRhNzWDCFkXkY+Gkd4ux3IA+Vs8IZCT9IA4+jE8lZXs5JA50xgrHP6WyJ5T8LMuoSqENldI+YYohh9mWP+bR0kUmWmSaudTwfQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5ztr43gBzLqfS6ix9d/vsGqjrGPHsOUnBYNQwYOmeg=;
 b=SattBQIWoJhTxb9vnFf6jWocFFQjc429YojXm2xCAnyVk670VH3Cwhyi80kTUvTI3LnVQ13R06xEgZp1sngDFQft8YoBZUL2zhK4AUR+qLUKoQ9Lffrisk8A/mS95TqGVyROoqLP3YwS9FxAhT60x1hqbewyvs6gk8ck9MGW+VY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV1PR08MB10421.eurprd08.prod.outlook.com (2603:10a6:150:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Tue, 3 Jun
 2025 12:59:31 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 12:59:30 +0000
Message-ID: <9878157c-07aa-4654-943f-444f5a2952d3@arm.com>
Date: Tue, 3 Jun 2025 18:29:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, anshuman.khandual@arm.com, ryan.roberts@arm.com
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
 <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
 <8fb366e2-cec2-42ba-97c4-2d927423a26e@arm.com>
 <EF500105-614C-4D06-BE7A-AFB8C855BC78@nvidia.com>
 <a3311974-30ae-42b6-9f26-45e769a67522@arm.com>
 <053ae9ec-1113-4ed8-9625-adf382070bc5@redhat.com>
 <D5EDD20A-03A2-4CEA-884F-D1E48875222B@nvidia.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <D5EDD20A-03A2-4CEA-884F-D1E48875222B@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::15) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV1PR08MB10421:EE_|AMS1EPF00000048:EE_|AS2PR08MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 59355020-6c2d-40b5-712f-08dda29e8ec7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dnN1bUF3TmE3eTZYczNRMFdaSEJJYmU5WEkrQ0VxUUpjNGUzdXZwc3JqZWVy?=
 =?utf-8?B?ZlFZZjV2NjFkNlpENzc2U0l6cWdXb1dQbDRSRXVVajFTeDVVa085UmpNSmZt?=
 =?utf-8?B?S2tsWk9HMnpMVmw1ZUZSUG8raDAvdE53RFZGak43ZG9BUS9GUFU3d1VIWnpH?=
 =?utf-8?B?NFkyQWVKdFBSQVNJaEVCNTZKRWlzQjR5eHgzVE9TbUtLdTdYRUlUSVBmSnJX?=
 =?utf-8?B?TWp2dkFudmJVd2o4RWcvei9GUU5tMUNxTDlrOFV3ajNzOTdINnpzbmZXNm1v?=
 =?utf-8?B?dEQzdFVoWjRvZ1o0VkJyZU5Ja2dpYTFLWEZnZEJxcndZbWljUzdWNUhOejFz?=
 =?utf-8?B?clNrQVZQZDl2Q3ZSaE1UK2Qwd1VTWjNxU0J2TFRWN0FhdkcyaVh1MTNrY0pH?=
 =?utf-8?B?ZWtQNUZlbXhFaW9qdDdpekFDWGpKOWtmOFgyeEw3UE1MYmx0TC9wS2tDeE8w?=
 =?utf-8?B?TFFHTm5xcVZFNzgvODRNR2tYRzhFVmxmRjVxTUZ6ajVpbXlCRC9CMTdCOGps?=
 =?utf-8?B?emF1Q0kyVkZXVVpHQlZnUW9xaW11RWM2eHJycWFlbHBOU0VjSHlRSzlKUGJy?=
 =?utf-8?B?MTZQcTEwd2hDZzk3TVRyd3RlZEcrTmYzdzF3aWJrd3lkb3RvdDJFQzZBd0NE?=
 =?utf-8?B?NnJicFliNVpKY0xIMHZqYkVJYWhjKytNVmZaWlRxZ2h6bU4zYm5MSm81Y2Rj?=
 =?utf-8?B?emkwTGNtYTcyakxNRDcvUzZhWDcrbzBCdCt1QnV4aUFkS01Db3hYdXdkZVYz?=
 =?utf-8?B?czhoTlorUnFwT0FYaTl6ZmtqYXVOd0Fxd242YkdhUXR5Z0wxdUQxWE9IQ3dy?=
 =?utf-8?B?QStLUTFJVzN0RHJQd0JMcmJtY2RnYVJONkpBcitGRTRFYU5GQkNPL21TZklL?=
 =?utf-8?B?UXdMM2tIUFFFVCs4cWdjMmRrU3hBekxybzNpY1hON1M3SU9QczdVRkV1QVJy?=
 =?utf-8?B?NDN2WW1FMnJ3OUI1TWg0SDM3bnVOMXVTRUVSTkJqVWxNNVRvN3Jib0RnMEZC?=
 =?utf-8?B?Q2JBaVJaLzFSbXJTbDdRdnAxOXNxb1ZIT3ROM2tjRE9CbGRlOW1IcDdUakk5?=
 =?utf-8?B?QUt1cGl2VWs0VDNySnJGTnk4SmpIK25FcmJhUFBkTVVvQ0g3cTBiRVlBUlFQ?=
 =?utf-8?B?Z0dtTTRYNkNvbTFUcERmRmp0eHBEbDRtL0VvUlRDV1hGNjdLWFNNTjc0aEsw?=
 =?utf-8?B?T25rWlRQRURsTkpWdUZqRTN5cXR3ZHRmMVNkaGF2Z2VQNWhMMHEwRGVEZC9n?=
 =?utf-8?B?YnZvSzcxUmJKMmZoOXZUdkpoWGtBQ3JhNjQ0QW5BZm8vRmo1alYwVTNwZUwx?=
 =?utf-8?B?N20wZE90eVdtK0o5ZWw1WUtOZjdlZ3FMRkdWbFlMeDlMUFlSZWJGS0NTVXFT?=
 =?utf-8?B?TENSZzMyamVZNjNwbzY4ZTQrRGo2dkdXUGVzbnQ3eFErU0h5TS90VTN6UEU2?=
 =?utf-8?B?R2lHd3hSazczNEs4bHFnU3p3bHhNRWVQMHlQWDlYVnNsV3RiQjMwa1B5alJ4?=
 =?utf-8?B?RjF5R2p6MENrVTVrZmhZSS9vd2VpLy9kVW1GMnVnNlJSN2xwVmswKzVHQlpl?=
 =?utf-8?B?ODM0RUFnbERFR2pMRGw2Zy9UcjZ2bTZhUGNseHNxejdjL1VMeFo0ZGZnUkkw?=
 =?utf-8?B?NXpCUHR3cmVyeEFmY2ZpYnhGSUp6cjU2bWdjTm9jRGphZFduNzZncmgyc2NO?=
 =?utf-8?B?NExZMmltaDZyeEtXM2E5VW8wTTRET1g2eXRvK2hPbnlFZGFrekh1NHlhd09G?=
 =?utf-8?B?cmYrdjRKSTNnUW5OUzgzTHZwL0VEdFB3RmtreVNLWFVtdEhsRmllOTZUY0E4?=
 =?utf-8?B?emRjS1Mvb3c2bFB1UE4vcXc3MjlPSnhsdXp3NzVRTkpRbnNTa2k2RDJFN09z?=
 =?utf-8?B?QTZFMWZreXAzMkp5SDNRZXJnOHBONDljNkUweWxXRTdHdlBFSEM4R2MwUmxr?=
 =?utf-8?Q?dEMUlK4pXJw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10421
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8c0b5682-0c8d-41cc-af32-08dda29e7a1d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|1800799024|35042699022|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjRRejlDZmxvWW9ZV3F2ZXVkNXdjUW1QbUpKRGFQSUJId0s5UWtpRUlsYm1B?=
 =?utf-8?B?M1V4eWtIdGp0Y2FmSm5pWWhhSTZkdW1iN3lWZENxRWhVNG1SOTZ0blRqV2Q1?=
 =?utf-8?B?TEpuTTlZT3ZNaTNaSmQ5SkpBdkYrYzU0NWZmNFZoWWpzRktUQTdEVHRjbWxM?=
 =?utf-8?B?YXhhVllNYzRSWnl2RWljN1U3OXlVTTBaVUtDZzR5MDJHVFN6QzRmRS81b09r?=
 =?utf-8?B?cnNTQjhidEhJaDltSG13YWs2TGJqY3RidGk1RThXWFhVbDdEUHA0bmlqOEpF?=
 =?utf-8?B?TjVHbmJIdkgyWGF6UDIrdW85b3d1emhYQ0I4K3YvbzhJbFVqYVcwVUY5MDJh?=
 =?utf-8?B?ekFGbTFqaTJQRG1yelFZVEdwREVrbU1GUU5lYnlyR0V2MDZaQVVLcnoxa1lS?=
 =?utf-8?B?dTZMN3NhOXBsSThsUDNFb3piT3ZSNmx1TVI4VEdtN1ZBMG1FY0N0U1RSSzRO?=
 =?utf-8?B?N0tjeDNXcm9rVFNVaHhNQ0FDcFFuTXNtc2JlalFEV0x6RjBhNFdVRURhYUtU?=
 =?utf-8?B?VVNsSEVxUlMzZGQ2OVRHdjZNTVJYMlh4VGlSb2JmNUE5dHMyOWkvdVM1dGV0?=
 =?utf-8?B?c1BiV1VNSEpQR1NUaEhiZWJZeE1EbUhzN1IwQmhXQmVGU1NOUkJGaHkyajRj?=
 =?utf-8?B?UXpyKzVyZkNBYmZLUUhoUytrUGhDZzl4T2hZUExRNkt6eUduVmxpMjdUODRk?=
 =?utf-8?B?UU1kYjJBaGllcjZvZlBSeGhXSi93SVV4UUU2V3pZSHZBMllCcU9BOC9NcWJP?=
 =?utf-8?B?T0wyYTZqOWNRU1VudGJySnNlN1I4SVo2aFNDS1ZWWVphSnR4Vnk2dEhQRlpR?=
 =?utf-8?B?WmZBQXhONGVRWGhhVGhONHNkNVBpcTg4QmhhUjhpd1ZOQVprSkJhU0QzWWdP?=
 =?utf-8?B?Tmx5TktQcTJBZEhCcVpjUU9US1ZXa0dEVWt5dk5nQlBoOXpTamR6eGhMWHQ0?=
 =?utf-8?B?Y3ZCbmtTbXZieVJxR09TMlExOGZEdjNzUzc4VWF5RjM4eE5ReTdxUmg5Vlds?=
 =?utf-8?B?TU4zUVp3Z1VUV3p2VHRPbnkyVUJhMTBMUkJtYmFFTkYrMlI1T3VBUGtMaC9n?=
 =?utf-8?B?OTVqeWJyemRvODVrVjdSYjg1NnRzejZoK2VGbnd0aXlJV1M0dkVXSllkNkJZ?=
 =?utf-8?B?Z2M2dFhUR1F1UVpnclBSVWZSZkE1cXd5YmQ2SmgzUkhvQS9TZFhqWTBsUHNz?=
 =?utf-8?B?R09JMCtkbHNwU1RJbG93UHZUSXJyTkZzUDdWcFhNZlFpU2cxckJ3SytlelJT?=
 =?utf-8?B?cTh6OHJOQ2Z6VGpDRkh4REloenp4ajQ1ZWJhak9MU1F4TjhZZXFzUnk2TUhq?=
 =?utf-8?B?RlZZbkZOazV3K0NFbDNhOTlHNEN3Z1BLclBWbSs5TnplVFFkSWN2UFhySlBk?=
 =?utf-8?B?bnJ4U2RLOG5aMWNrZmZYNk9GUERyNW5xVUcxR3VqRSsxbEsra1ZDNE5rMllD?=
 =?utf-8?B?NHhLNzhwRU1CTm52WG8xTExaNDFaZkdEQW8xTUQwU3VHMTJDL25qYktGcUdn?=
 =?utf-8?B?M2lORzNrczN2TVJCQmxVOHovbkNXMDAwQjg1V1owK01WckduWmg1UHo4b1Bj?=
 =?utf-8?B?QjRseGh6TGQrL01zTGRZUHRNRXpaTjZxS1FMRk9tNC9RTjF3TGZ0cGNGWnhB?=
 =?utf-8?B?Uk1IRWpEQnpvZUlVVHgwNXA1NmJuaDErWmlyTXhqMXp1cnJieUdTY2dSaWhY?=
 =?utf-8?B?L1Q2VVFqQkl2OEhSdWljRmwvYjljNVVKc0JnSm1yNlpRT2Q2R2JqMTB6Zkdh?=
 =?utf-8?B?SDA0Y2hwaE8xWGh0SWRJVGpnTmN2cmxsOEVjM29CeUF5VFlmSlJHbHdYdDBM?=
 =?utf-8?B?MFFQdVQzZ2UvU3dmRmlNYStad3hzbktvSWo2aVFSUXJEdmwvUmdZanhHMHBE?=
 =?utf-8?B?ZS8wT2lObTduM3p3V3krbzJBUHlxcXVFa1RCdG9OV0R2cjI3N2NnSGw4OEZ2?=
 =?utf-8?B?RXR5VTFhTGJLWkNWQnF0endqRzZEaFJDYXdwTXpaZUlmbVFURDQ4Wk5JR0dS?=
 =?utf-8?B?UkUwM2Z0bDJxS2g4dDBlVVRoK3l1aDlxN3Rnbm5VTCtHWThyTlBCRENHVzZn?=
 =?utf-8?Q?30wi96?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 13:00:03.9573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59355020-6c2d-40b5-712f-08dda29e8ec7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8309


On 03/06/25 5:47 pm, Zi Yan wrote:
> On 3 Jun 2025, at 3:58, David Hildenbrand wrote:
>
>> On 03.06.25 07:23, Dev Jain wrote:
>>> On 02/06/25 8:33 pm, Zi Yan wrote:
>>>> On 29 May 2025, at 23:44, Dev Jain wrote:
>>>>
>>>>> On 30/05/25 4:17 am, Zi Yan wrote:
>>>>>> On 28 May 2025, at 23:17, Dev Jain wrote:
>>>>>>
>>>>>>> On 28/05/25 10:42 pm, Zi Yan wrote:
>>>>>>>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>>>>>>>
>>>>>>>>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>>>>>>>>> Then it may happen that the computed slot already falls beyond the batch,
>>>>>>>>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>>>>>>>>> order. Thus ensure that the caller is aware of this by triggering a BUG
>>>>>>>>> when the entry is a sibling entry.
>>>>>>>> Is it possible to add a test case in lib/test_xarray.c for this?
>>>>>>>> You can compile the tests with “make -C tools/testing/radix-tree”
>>>>>>>> and run “./tools/testing/radix-tree/xarray”.
>>>>>>> Sorry forgot to Cc you.
>>>>>>> I can surely do that later, but does this patch look fine?
>>>>>> I am not sure the exact situation you are describing, so I asked you
>>>>>> to write a test case to demonstrate the issue. :)
>>>>> Suppose we have a shift-6 node having an order-9 entry => 8 - 1 = 7 siblings,
>>>>> so assume the slots are at offset 0 till 7 in this node. If xas->xa_offset is 6,
>>>>> then the code will compute order as 1 + xas->xa_node->shift = 7. So I mean to
>>>>> say that the order computation must start from the beginning of the multi-slot
>>>>> entries, that is, the non-sibling entry.
>>>> Got it. Thanks for the explanation. It will be great to add this explanation
>>>> to the commit log.
>>>>
>>>> I also notice that in the comment of xas_get_order() it says
>>>> “Called after xas_load()” and xas_load() returns NULL or an internal
>>>> entry for a sibling. So caller is responsible to make sure xas is not pointing
>>>> to a sibling entry. It is good to have a check here.
>>>>
>>>> In terms of the patch, we are moving away from BUG()/BUG_ON(), so I wonder
>>>> if there is a less disruptive way of handling this. Something like return
>>>> -EINVAL instead with modified function comments and adding a comment
>>>> at the return -EIVAL saying something like caller needs to pass
>>>> a non-sibling entry.
>>> What's the reason for moving away from BUG_ON()?
>> BUG_ON is in general a bad thing. See Documentation/process/coding-style.rst and the history on the related changes for details.
>>
>> Here, it is less critical than it looks.
>>
>> XA_NODE_BUG_ON is only active with XA_DEBUG.
>>
>> And XA_DEBUG is only defined in
>>
>> tools/testing/shared/xarray-shared.h:#define XA_DEBUG
>>
>> So IIUC, it's only active in selftests, and completely inactive in any kernel builds.
> Oh, I missed that. But that also means this patch becomes a nop in kernel

Yes, but given other places are there with XA_NODE_BUG_ON(), I believe
this patch has some value :)

> builds.
>
> Best Regards,
> Yan, Zi


Return-Path: <linux-fsdevel+bounces-44140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D4A63451
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 07:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BC03B40A0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 06:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C543A189B9C;
	Sun, 16 Mar 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="sphWW9F8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7662770B;
	Sun, 16 Mar 2025 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106672; cv=fail; b=H000bPoOBWbbUH1iwGk/gV7b07B74uJH3+x+lhrXCIPEI2zN1MzqB7WBVEqPvMXjneC8hIIjcABYBpCLpxAS6G0V9AxKVynKjkc1qNPYcqJ7sCi1iJnIE3je4fGuLHgUwxTWRluxGqBqCqDTlC09CmjEo6FAWkWF5LH2aoLL2tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106672; c=relaxed/simple;
	bh=qUmOnV+7dTQPPx+umNhxMfWjh1k7vHOVoQ51BikGuHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rXK7DV7rjySTEkxA4MKxB0RWKV65RiD24pBBRyd6SBTePzk42OCHZrHX2Gx0kLfjaMVh0Tl6HABkLAoqrNPhvqLiTA2LNuNq3i1WgkZbGYyJDMukoBZJck8DVarcylY0MJnA0nlB6ugTVR0DTZrlWhUMeSUMNpIeg9l5hvFyBf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=sphWW9F8; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO0aY5jbQgILKTwnvSvemHYDe7YJiX2I9g6KNiToknrROTLcoV6p+QM8gsJKN9DIqXh/omoaFqgRhIzVTX8X7u4NdVJlE5qknU6cOeXL+Jf922a0SqNgRDVFLBtgN9wSZMRbO+8agRkbj9SOpkavBoy52VL8rOxlZ0az40zrgAZ/IN4MruDeojsfO27fy+hh7gV/ZwSMGsTxpPdjAwt20Esi1n9ag3/rjqI3Ze3MDBbDZPjE3zOqFBgGtTXyRiNYjIZJgcMTQOWeSqR20lIB7bpBVEuo9xz2TM9AfGhopdeouUdjSeH4samMNMB8GpvbNFymhM8VDHAy4q1KeFBUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUmOnV+7dTQPPx+umNhxMfWjh1k7vHOVoQ51BikGuHk=;
 b=j/YAxBD5xmV00DxwrdnkQ+v3kj/AC7G7800+dIbHiqclj5SejojIV9SjzPRBmBPFJPEDN3jIRNlu5XinhEaQwBZ+6guG1CBi6mMeRSTdxasbxB8dSdMqeAPpo40L8uVC+jMZAP/flr7h/67lsJnnMUptciEMjuJndgV0NRUx18chMjdrsDWUYOV3TSddVb1qKBouKyjWaWbFtOyaJrXhKPamCRjE8CLINib1ZAVRfxooBYuqupTHKuIuRUoHGtnwr9NqHwRF3OO1WrErJ8ECDeAGmdBDeNDY4WeRjg5aiqyLRoF6wMZC+RLyRwWo4/00WUQxOXuy/H/QF6oVUyebzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUmOnV+7dTQPPx+umNhxMfWjh1k7vHOVoQ51BikGuHk=;
 b=sphWW9F8UQSffL1wb9zct98IvuP7MVrdHNK2DErRS3g8yh+2XrlRxSHOvAUM/NRN4T83bvmuKDv1Qx0+N2vl1kU1jO3HcXm/V+vsZ7GWhbKuW1J/jyRm26lPOz+U2uWSSe2A75j7X9cTVpZkmp6VI7xU9ZZxk18yIpsAhStOwuEXDEJFIlhlhjTrT0kQrmlzaZpb/QQ9rIu9nxjZZg1hRb+AXH8oHAmANQgEBugZWy/NSwbE0mHceTEs6kGXWL1TNAwxEz1rUVLKpC4vyITg6NgPYliqxBKgvfyohJCrjHAYewtVBiWCUBFVSQrxwNZ5dgEZ1HL26mffsQx2xmiiuA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 06:31:03 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8534.031; Sun, 16 Mar 2025
 06:31:03 +0000
From: Aditya Garg <gargaditya08@live.com>
To: =?utf-8?B?RXJuZXN0byBBLiBGZXJuw6FuZGV6?= <ernesto.mnd.fernandez@gmail.com>
CC: Ethan Carter Edwards <ethan@ethancedwards.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "tytso@mit.edu" <tytso@mit.edu>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, "sven@svenpeter.dev"
	<sven@svenpeter.dev>, "ernesto@corellium.com" <ernesto@corellium.com>,
	"willy@infradead.org" <willy@infradead.org>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Thread-Topic: [RFC PATCH 0/8] staging: apfs: init APFS module
Thread-Index: AQHblSw8K4t9osLx8E6wFBStbHPjGLN1HXuAgAAyGIA=
Date: Sun, 16 Mar 2025 06:31:03 +0000
Message-ID: <5EFFE468-D901-4E24-8C17-370DD232C019@live.com>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <20250316033133.GA4963@eaf>
In-Reply-To: <20250316033133.GA4963@eaf>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB6108:EE_
x-ms-office365-filtering-correlation-id: ff3ac025-b3c2-4f01-f551-08dd64541ff1
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|8060799006|15080799006|7092599003|461199028|12121999004|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmV4TFJOUnNTT21SanNuQk9PY1E5NFFpS3k1alFKTEptbzdBMGRHbXo2Nndk?=
 =?utf-8?B?eGptZHBodFZkbm5Zc1FldnFOcHp1dmhEeEkxU3p3L0tYYnlzM3NySGMrckVG?=
 =?utf-8?B?dzYySENRVDl5c1VxSi9ERjI2NlQxTGhhelZ4b2FMZnp2NFJUWnlQa1NLVEdX?=
 =?utf-8?B?aEpINGtveU9ieERBOHNZTlZYTnNvSWwvM3l6aFcrbzlvTlh0UER4a2lJNlFQ?=
 =?utf-8?B?L0o2ajR4RG00TkxTdVRUMFExSENPZC9ISmtDK3ZBeU1nM20yL3hPc20wcjJH?=
 =?utf-8?B?dGhpdnBZeVZ4VE5NdVVjcTlxWVNxMXhhZTRyUTBDS1lucjFCb2FrQURHWE05?=
 =?utf-8?B?dWs3N1FESVpydGFZQ0VhVWtKeXlkN0ZoR2NxUEtXT09nVDRUNHhXZ1Ryb1Q0?=
 =?utf-8?B?VGd5RDVIQyt3cEp5MjJ3VStpSkIrN09xanVRWkxzUi9hSG4vUnB0cExvcU8w?=
 =?utf-8?B?TXpSNmMxU3BGb3Y5UWlCQnB5dTAzbHdYQUhCcmtmTU5RZTF2dVhEeXovbUd5?=
 =?utf-8?B?ZWpqcG00YUhiMzgzeHFEL1BkcXdPdlpaNFJ4QUFtUERSazVBZUpXY2l5bjFF?=
 =?utf-8?B?NDU2SnZhTWVGNnBKa1lrdEdOYmtDT09YeXQ2NW1HV09vYk1tTURTaDBnSEQr?=
 =?utf-8?B?clM5Y1dBVW5DQ3lxdE9IRHA1dVk4Y1EwanpXQkpJaGdtMSt5VVliWHdvNGhV?=
 =?utf-8?B?VytDblFmR3k5UWRuaGxzN3JBbjFkcFdOeFZmYS9VUDFnaElaMDdKRDQ4ZElZ?=
 =?utf-8?B?MTRuWU1SUktuNDcxVU9WbzY2S2dzKzZBdFpvRC9zWDNJR05jL2d4QzMvejNm?=
 =?utf-8?B?azdHTERUM2dwR2FZMzI3YnJ6VDhqelRKUFJjWURIamp1MFFVeDJWT3RuZk1m?=
 =?utf-8?B?Nm40VHdhb3R1SCtyWXBnRDBja1g0TTdCay9LK1FpcjE1dzhxQ0JtU1BWaW5R?=
 =?utf-8?B?WnkzWXV6YVBEQkZnQnhOUVdBN2VXV1ZxRlBmR3daN1dpS1JmWVUzamZ5S0gv?=
 =?utf-8?B?UjhXZERITDltVzZ6WERsdUdLanI3V3pLc3dyRUdVdkdsWS9KdmVuNGdUVDBY?=
 =?utf-8?B?Y3RPQlQxUFBWN3ZkSXBjdklMSWM3bE5OOEpua0VTN1lud2lTbmtXYjRxVmJN?=
 =?utf-8?B?bmcyYWhPRmZ1SDB2aXFway9nMHpvczRVWnRpWmVJbUpDSUVCUWZZOFhPQnFH?=
 =?utf-8?B?WFI5WllOZXBCSSt6eXhTVEVjVUphUVRhVHlmUzM2eWNuam5zVW93eldldnZZ?=
 =?utf-8?B?UEdCMWlLY1F0TE9kTEFvako3RDJvSHc5cWRYQVBMY21iWWcvTkdUaDZyS25z?=
 =?utf-8?B?RDBxNW1ja1JMWjExSVBsbmgzZjJjeGlZcXpHaGFWRlpoTkJZTmk5LzRDKzJU?=
 =?utf-8?B?cEc0QUlkakNjRjU1c0UwcWl4bzh6YUtLMmpBTUdYL2NMMVBqZE9YWmdiczND?=
 =?utf-8?B?eVFjOGFJK0tHRXVMMDJrSEVKa21XUWtSTjBHRFRCcXE5L1FpT1VTTEk0LzM0?=
 =?utf-8?B?T0FXekE0Mkl4elIvb3NGeW1QRmZqNTU0V3BwTHpHdUFoVno5Zm5DM016L3lX?=
 =?utf-8?B?LzR6Zz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFgzMUtLMmM2TFFOTEhxQ2dhZURMNEM2RmtYenZWSUhEZ0VJTHdqK2dpSk1K?=
 =?utf-8?B?NGdwTWlJYnRpS0Y1Tjcxam51bXJnR3g0TUpRRnAzYzF2TU9wQzRFODA3UlJT?=
 =?utf-8?B?SUVKOEgrd1ViOFh2akt0Nm4vOS8zM2N6WHVDbVRLSkZhQkZVSUYzeGhwcmtz?=
 =?utf-8?B?WmhFd3ZveE1VZy9GZitGbnh4WlNvVGE4WWhuMU1VWjNCYmpETHh1RCtGWjJL?=
 =?utf-8?B?cHF3N2FzS2NJZm1ndW5ySTdPeVo5SmpuMzZaOFkvZVNicytSYVFtOW5DeXJC?=
 =?utf-8?B?cFB4UkVDWXBCdkxkOHFpaXNNMU1aR1Z1TVNGRVkwSjF6NWxwRkxzdjVVV1ND?=
 =?utf-8?B?clEyZ2NZd1VTRVBxOXlDbVlHSU9OMk93ZDhlZ0F4QUNobFVkY0RVbnRkbGpo?=
 =?utf-8?B?TTcwL0hienZSeFA4blJCdHIrWkNvWndxOWw0UkxSQjYvUWpSWXpTODlmQ0NS?=
 =?utf-8?B?cmdwK01VcU9ZZ0FoeTJQbDByZXdHdlllUXR0VnE5aWErc3h4RmRmZ2N0YS8w?=
 =?utf-8?B?TVlIL2FHTzg5cFh4aFVGQ2grRTltaXdsc1R5SVdnaXRjcW1yUG9YZ2QzbGh6?=
 =?utf-8?B?NFdBay9xbGI3MllUellpb1lpcGJYVE5jN3dXS3NNVXVwSXRxZklrRzZpcnhi?=
 =?utf-8?B?MVFaMXo1dldwY1YxRmtGQkdGanM2R2N3dCtLWHhxTXB3WUJldXd2VzVWdGxU?=
 =?utf-8?B?VGEwUVk1dUYrUnVtTXJHbkI1ckdEL1puUXlIUmk1TXJzVUc0UnhUeUI0SEFK?=
 =?utf-8?B?ZGwwYldHNkdmQWpyemdyTmJwZXdHa0Z1ekRYOE9uWDY2QVBOeU1mZjcwa0la?=
 =?utf-8?B?UVBwK0d0c1ZXQjZwTWhJWjVidFErZDgrYVpqNm9PL1pJYWExUk42aWdYZm5W?=
 =?utf-8?B?ejNONVZIQmpUMGl2MEh0UXY5aGFyVkxSSitQbTdBVlVaeHNkU01WeFYvSkMz?=
 =?utf-8?B?NVJMcmYzdGNUd0YyVkZ5RWhyV0UyQnJ4NTV6Ry9wRmtLSWNLUmpyQzQxZ08v?=
 =?utf-8?B?UHVxenhOUHdtUDRKbnZSVU1oRWJWYW0xWWQyOTVRKzQxQzc3bWN3cUIvY0kz?=
 =?utf-8?B?ZkVxclQ3MkUrQzBEc3BUUkUzdHZwZVc0bVhyOEJiWXBRYkhRNzJUbndRSFhq?=
 =?utf-8?B?TEx1UDZLTmZmeFhGdFFidEhWRWpFQ0xTbUJQRWw5b2RPOHBYUDJweDhRQzBj?=
 =?utf-8?B?dTJqMm5QQ253MEsrRzNwQWtXZTFVNzA5VHNVc2w4RUhhUTFFZWdWQVd1NG5s?=
 =?utf-8?B?Ni8xYi9HSElkTXlJN2FxNDRLZ3plL014blp1YW84Qk5RaEFGODE4TUhMdWdl?=
 =?utf-8?B?VENKajVmQ3crR0Z5UlFvUXYwLy9qc2dLNEVtenV2QVRuNkw4c3dLYXgyZ0Qz?=
 =?utf-8?B?UlpxSXZSaVR4VXNYc0ZlRSswbDBMdnV1b3hqbVpuTVpvZ1lXNW9nSWJoYlk0?=
 =?utf-8?B?ZTNRRTQ4R1hHcndLY1d4ZEFuS1o1akpBM1JaZFVwdGQ4dVZ4WEsvTFBIeWR6?=
 =?utf-8?B?ZU1nUGR3RlFVZDJPL3RXcitSTlpnRkdLTXhIMGhIOVVRRTRZbU1XNXJQWk5q?=
 =?utf-8?B?ekJzczhQREtLTVMxcjJILy9RcHovaGZzWU9ocmVaV3l4VlBZMitOTDVyZWdy?=
 =?utf-8?B?Y29BTXhWYXJjaGFEQVM4STkyL0wwbTJFRSt3dUhZekJ4UUZiUXpVQ2RwTHV6?=
 =?utf-8?B?OEFFNzFTOWNXT05pZm9YR3hpUm53V0pmdWJRWkJhMDhCM0NBSXlKeDduZGZK?=
 =?utf-8?Q?UK9XPCHcvu5J9HyNnJ2UWJa48vj1hpkFCgWZHK7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3CE2B9A1401E84180DFECDE398EC19D@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3ac025-b3c2-4f01-f551-08dd64541ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2025 06:31:03.1898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6108

DQoNCj4gT24gMTYgTWFyIDIwMjUsIGF0IDk6MDHigK9BTSwgRXJuZXN0byBBLiBGZXJuw6FuZGV6
IDxlcm5lc3RvLm1uZC5mZXJuYW5kZXpAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhpIEV0aGFu
LA0KPiANCj4gSSdtIGhhcHB5IHRvIHNlZSB5b3VyIGVudGh1c2lhc20gZm9yIG15IGRyaXZlciBi
dXQsIGlmIHlvdSB3YW50IHRvIGhlbHAsIEkNCj4gdGhpbmsgeW91IHNob3VsZCBzaW1wbHkgc2Vu
ZCB0aGUgY2hhbmdlcyB5b3UgaGF2ZSBpbiBtaW5kIHRvIHRoZSBvdXQtb2YtdHJlZQ0KPiByZXBv
LiBUaGF0IHdheSB5b3UnbGwgc3RhcnQgbGVhcm5pbmcgdGhlIGNvZGViYXNlIHdoaWxlIEkgY2Fu
IHJldmlldyB5b3VyDQo+IHdvcmsgYW5kIHJ1biB4ZnN0ZXN0cyBmb3IgeW91LiBGaWxlc3lzdGVt
cyBhcmUgdmVyeSBkYW5nZXJvdXMgdGhpbmdzOyBJJ3ZlDQo+IHByb2JhYmx5IGRvbmUgYSBsb3Qg
b2YgZGFtYWdlIG15c2VsZiBiYWNrIGluIHRoZSBkYXkgdHJ5aW5nIHRvIGhlbHAgb3V0IHdpdGgN
Cj4gdGhlIGhmcyBkcml2ZXJzLg0KPiANCj4gQXMgZm9yIHVwc3RyZWFtaW5nLCB0aGUgZHJpdmVy
IHN0aWxsIGhhcyBhIGZldyByb3VnaCBlZGdlcywgYnV0IEkgZG9uJ3QNCj4gdGhpbmsgdGhhdCdz
IHRoZSByZWFsIHJlYXNvbiBJIG5ldmVyIHRyaWVkIHRvIHN1Ym1pdC4gSSdtIGp1c3Qgbm8gbG9u
Z2VyDQo+IGNvbmZpZGVudCB0aGF0IGZpbGVzeXN0ZW0gY29tcGF0aWJpbGl0eSBpcyBhIHJlYXNv
bmFibGUgZ29hbCwgYW5kIEkgZG9uJ3QNCj4gZXhwZWN0IG11Y2ggaW50ZXJlc3QgZnJvbSByZXZp
ZXdlcnMuIFRoZXJlIGFyZSB0b28gbWFueSByaXNrcywgYW5kIHRvbyBtYW55DQo+IGhhcmR3YXJl
IHJlc3RyaWN0aW9ucyB0aGVzZSBkYXlzOyByZWd1bGFyIHVzZXJzIGhhdmUgbXVjaCBlYXNpZXIg
KGV2ZW4gaWYNCj4gc2xvd2VyKSB3YXlzIHRvIG1vdmUgdGhlaXIgZmlsZXMgYXJvdW5kLiBPdGhl
ciB1c2VzIGV4aXN0IG9mIGNvdXJzZSAobGlrZQ0KPiBBZGl0eWEgY2FuIGV4cGxhaW4pLCBidXQg
dGhleSBhcmUgYSBiaXQgZXNvdGVyaWMuIE9mIGNvdXJzZSBpZiB1cHN0cmVhbQ0KPiBwZW9wbGUg
ZGlzYWdyZWUsIGFuZCB0aGV5IGRvIHdhbnQgdGhlIGFwZnMgc3VwcG9ydCwgSSB3aWxsIGJlIGds
YWQgdG8NCj4gcHJlcGFyZSBhIHBhdGNoIHNlcmllcy4NCg0KQXMgZmFyIGFzIEkgY2FuIHRlbGws
IGluIGNhc2Ugb2YgdXBzdHJlYW1pbmcsIG1ha2luZyB0aGUgRlMgcmVhZG9ubHkgaXMgd29ydGgg
aXQuDQoNCldyaXRlcywgSSB3b27igJl0IGNvbW1lbnQuIE1heWJlIGFkZCBvcHRpb24gdG8gZm9y
Y2UgdGhlbSwganVzdCBsaWtlIGl0IGlzIHJuLCBvbGQganVzdCByZW1vdmUNCnRoZSB3aG9sZSBj
b2RlLiBUaGUgc2Vjb25kIG9wdGlvbiBJTU8gd291bGQgcmVxdWlyZSBxdWl0ZSBhIGxvdCBvZiB3
b3JrIGZyb20geW91ciBzaWRlLg0KDQo=


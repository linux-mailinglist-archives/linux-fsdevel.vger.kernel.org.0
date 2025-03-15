Return-Path: <linux-fsdevel+bounces-44106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13CA62806
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 08:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF55B7A3281
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF631DC9A2;
	Sat, 15 Mar 2025 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jVBE3D8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1619F416;
	Sat, 15 Mar 2025 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742023278; cv=fail; b=idWpRt7Dxaptvg7/G3jMFvOupmbLUNM29+7z5cLsa9Sz1NTZ18YFL6NpkJ1BF1nXZQTT3bn4Ap8lsQjZuV/m9b6m6REuCDexrkGqv/clWT4p9jP52DBAEJ5LJoNCRC0spIQYtsYyNU8UhYqYiYGiuzoJhc6YfWzLSB4YJG6U4JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742023278; c=relaxed/simple;
	bh=Hg8IR9m3T212o7Fo2c0cNdTvBheVnaGs1UxfnW2D+SM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aSErQdSnXuKzVM89YuEIP3X6kx5AngkFd2oCHd8PQhv1bpl0D3N4w28ioXWtIfTJEVKOCwPzl9JL556vikUaPedeD2zONNVgBulx2owV2KWsbFLzzAFwhIokiZ4d8hyiG5ijkbbPxNziMweycS1KXcsBhmXL8iWhLNR5ehEPOYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=jVBE3D8h; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8x+pLfDslwc+XmaIHcobdODttoM/LA6nhL6ZHsayvi1ZpFMOGBr9WzqHn15dmHAZlWgxV7+H+imljjm8HTC2Vbyql4aw0GaTVOYK/2dZI3mYesz259M69MpbOQ1TSOEShyiMVcr7VvBDiReEM/tkFitibUyDN+OrSf+PSu5nvQac5aRkBIXRD7mzQEaBA5t9W5cVaHnSTrkw1cgl9M2DAUfOdla+xAWOXPpcEOCme6YukBpZulfLF3rexpm4iVyoUvYOGw8ljKir6CwlYYX3J7hwCl4fxYwTsGOFw8uKo+0oA9yuwosp1ZNH4PVWEpyU5Ip+1maRDnwAOVJnjnpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg8IR9m3T212o7Fo2c0cNdTvBheVnaGs1UxfnW2D+SM=;
 b=hUD03NKqWcvbFKUZqlQ9FqKVEqHonXO93ju4ahvhSdzVtuEfGMMI92d4oNbHPuc4lx5UIvfO4tMrYSkXB9vHFLifTzhe+BHXvUbP21vpoWQC3jtwCKFsjmiQm0VGh25rcyS53Vdb/oFbsMmrQLCA9rTZnRZJDzkC/zAS5Z1KBZHNZ6q5sIi9UEBdE6VndJr6/bbyc6J+DE2m3xN1R3s9cIkNR/iFRs5papsHlUFKg4sHxm5sG3bDmw/PIZ2/JK5OMpIgAXUvNwRsFXYdG+SgqYmVzqmKl2qCDAJdJiFpfYzbpvIWNKEPc4yNSuh1MXPt7YKmZ0Ba67DdGx3WTLfrnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg8IR9m3T212o7Fo2c0cNdTvBheVnaGs1UxfnW2D+SM=;
 b=jVBE3D8hc82l9+ZMYhKp7RD4pSI3o1cSpAiKr7cs+Cqr5NxPTXN9q/PBTbTzdtPTy68/pEN/bNJefDMC77ZNZ4MNiY/W7YJZM55Ad9Aqga+y2NTYbW3Ddi4sFEvGhCoynezSMUklDb+LB5G37GD14XGQitwVQc4HQ3C3qDq6i+TuCO1CZn6Af0xs+od6EgBlDp+9oOA2v0vivlnZX8F+7K9YqFlgXqOta9OIs4Til3zvdGfMdGIYhYg4V8j+MdPtnenrzTJh/jGs5bHy6VKOFsKfekOZyQy44VycP9o2UrSZfE56QEGqtvO4XpMic7PpFJZbJlWOCdbDiwSeE1Iaaw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB6244.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Sat, 15 Mar
 2025 07:21:07 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8534.025; Sat, 15 Mar 2025
 07:21:07 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "tytso@mit.edu"
	<tytso@mit.edu>, "ernesto.mnd.fernandez@gmail.com"
	<ernesto.mnd.fernandez@gmail.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "sven@svenpeter.dev" <sven@svenpeter.dev>,
	"ernesto@corellium.com" <ernesto@corellium.com>, "willy@infradead.org"
	<willy@infradead.org>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Thread-Topic: [RFC PATCH 0/8] staging: apfs: init APFS module
Thread-Index: AQHblSw8K4t9osLx8E6wFBStbHPjGLNzyCSAgAADGIA=
Date: Sat, 15 Mar 2025 07:21:07 +0000
Message-ID: <D4E1167D-9AF8-4B1D-90FB-20F7507B595C@live.com>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <881481D8-AB70-4286-A5FB-731E5C957137@live.com>
In-Reply-To: <881481D8-AB70-4286-A5FB-731E5C957137@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB6244:EE_
x-ms-office365-filtering-correlation-id: e35ee385-cb75-4e01-1ab7-08dd6391f42c
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|12121999004|461199028|7092599003|8062599003|19110799003|8060799006|102099032|1602099012|10035399004|440099028|4302099013|3412199025|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFU5WlVHZEkyclB6TktEUnk3dmUyUnhseHBtd01PSno4a3Z0M21MZU5zRXRD?=
 =?utf-8?B?OVZHa0ZKRlRRdW53Y29zMll0dTgvOVpKSVdEcWxuaVpnSzh3dVhKWjNVQldn?=
 =?utf-8?B?eVdNRm5OTUdPUFd4M1oyVTNWUnR0TDdmVE1CQWFlUVJGUklLWll5S2dVM1hO?=
 =?utf-8?B?MkRETE9STkIxVkJiOUNqMDJja2ZoUzMxT0xIKzk5ejl3L2tlVk5GUEpXUE1H?=
 =?utf-8?B?cVJrNGhYaEVzS0c5QzZnbk1WQnFBbUNnZS9GenhyT0w0d1dxQllzdHdOMVBT?=
 =?utf-8?B?bUNjQ2VDL1J3Zk1jaFpXcWxCSTV3QUs4MGR6em83bGlwUTlSVVhZbGxXem9O?=
 =?utf-8?B?dUxLWDZZY2N4ZUVxR1pBS2pwblV3bXVqdktjVWcwRWl2Tzhtelo2ajB1aTRB?=
 =?utf-8?B?UlJnSW45TmluOVBqZjVvcWpXT1hzWUN5akFsdTQ2RjEwWlpzNnNLQU16eHY0?=
 =?utf-8?B?eFloWjR6OGhBUmk0NGpPTGY4Q3VScmRVVmUvQXExdUVRTWpueVpsS21FMzVW?=
 =?utf-8?B?OGZSNjlKM3JpNnMzSERrakxvTExTdXMycmFvZnJ1ZjdYRDJIMlp1ekI3Tmxx?=
 =?utf-8?B?Um5DeFNYOVdHY1YwY1RhMGgvT0pJc0t3TDhBUGNzTkgyMk80WHNsMVVPVDRN?=
 =?utf-8?B?NnEweG9Ka1VsNmFqNk1qUXhLSTcrVUV3T0RReTlBY215MmdaYnNPZVZYT1Fn?=
 =?utf-8?B?TkFyNXVtS0F5d3BoNVY0cmtieUw0MmdHYU94eFVEYjcrMXFrZm1pdkFFZThO?=
 =?utf-8?B?WldXOXY1MnhEK3BQZkpJRS9ENVJ5bDZqZTdLc2pFclpSYlAwYXoxOHBId3Rl?=
 =?utf-8?B?VHM3VVM5bkRwOWRjZldhNmVaRUhNSDFaeWZJd3ZJdERwQnRYVkd4QXVHaUUv?=
 =?utf-8?B?SEpJak96T3doaUc1VnNqaHZ6UWZFbW9MTFl5OWwyZURSajVCMEd4L3d3YWNz?=
 =?utf-8?B?bnUrM2pSVktUQVZVOW5RUHBTMGZQZWFhcUVJbXNURVA2UmErZE81aFcxSVpw?=
 =?utf-8?B?NEpGd2MvaFJEMUc0SE40MEg2WmRlZG02SU8waEpkSDFtemc3L1FyeXllZmIv?=
 =?utf-8?B?aCt4Nm1JVzRmY091UDU4YlQyU0hMWTJhYlFDeDRCUFM4cTU5ck1RT3dVTHlq?=
 =?utf-8?B?U0dlMTJUN0JCODNSVFJGbldMaGJoQlN1NUtEdTBoaFJaSGRUL3IwZTVzRkhQ?=
 =?utf-8?B?d1NxdHlua2ptZldjaERGT081ZHFPeDBlQjE4YVo0YzVERU93b1dUcDZtNTcr?=
 =?utf-8?B?VWJLNEdDaXhpUGNVK2V6elFnVnNBL0NUVnZVVzVUSEl0RkR2RjJ5d01RcCtl?=
 =?utf-8?B?YTZvTnJsYW5FeFVEc01LSDIyTk9pM0Z6eHBjRzdpTEtCTGQwRFN6VE9KaWU5?=
 =?utf-8?B?Y2NEQUJKcWdDVTJza3BOK3ZBem82QzFoMHIzbHFSWVNnRytUNUVIbzY2Mzl3?=
 =?utf-8?B?cGdPREpmU2J3QkpqUGhOdWpDZnB6NmpEcFNIK2J2UXNiTlFLYkVCYzVveGZu?=
 =?utf-8?B?ZWpRTlArcFdER21UVXhQbVpYM2NCUGdLUHNvME1uYmZ1alZmNHpTdWVqSFc0?=
 =?utf-8?B?dVdHRlk0d05aZnZGdGpubG1rODlRWnFPSWw4SWV3SVVBbU5taWliOU1NK04x?=
 =?utf-8?B?YjRnQTlSNnh4NEJtdFd4UGJxOE5ZRzB3TDRwd1dWcThlaFhPRDBOMWNXT1BQ?=
 =?utf-8?B?L09JQnFuUEQ4SWgvRHFFMnZtMkhiK2ZWN0ZwbDBqWFBWSzBBRmFFdWJKMWZz?=
 =?utf-8?B?V0M2ZFU3aUp1TGNibFlybDZacFZEKy9aR1NWWDZQTmdTMmJPSVF6MzJzSUta?=
 =?utf-8?B?cnRRRTNlZ1g2MTR1Z0dkQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDUwV3VneDMyV1BsNWJkSzliVzhWYTU0aVIrNmZkZGx4bDdwNjdwVExLdVc5?=
 =?utf-8?B?T25BZ2VDWXlid3hlQXgzc2JEU1c5R1UzN3NsVWlzbGpLOGpGWmJoWDJUUXYr?=
 =?utf-8?B?S0F1ZXhVMjRjZ3FENjVMLzBUM1pURENqcWhLS2VuVzVNY1NWalNNeEpJRUFS?=
 =?utf-8?B?S0FlNGhlbFpDYU4rWGtBdGRTb2lDWkJDZkVpU0cyQ3REQWw2a0R0dVZPd2lV?=
 =?utf-8?B?MmFPT1JjTEdvRmRkSmdEWFJUNTNORldDYkErMVFUcHJ1UXpLd0tEbmkwWmtN?=
 =?utf-8?B?N1B0USttR1Y5M0dFVjZPQjNLbG5rbGxWOTZ0V0hQd0lld1p5ejBiOTgzRDJQ?=
 =?utf-8?B?WVkxQURReVZBN3RxMVR4NGxQZ25ZTXpsN2JESCtPMDZBalY3b1E3MkYzUVBH?=
 =?utf-8?B?UW9XMmpNRGxHSkR5eDdHamxlR2tlbytMNzcvcnh5dUd2NWU1SENMVnBybjBR?=
 =?utf-8?B?NmhyZ3lHY0VxNUNXVmpxdEZ0TjRUTUFOenk3bUR6em5FaTFvd2FuU1JOcmRa?=
 =?utf-8?B?WXJZZ2o4VEt1di9BVjJLazRmb1h1QlZQK3R5aEVONHVtaWJKbks5ZisrVmN3?=
 =?utf-8?B?M2RCeU1qWFhFUU8rbGhRaTFMai9FdE9MUkwxVVNPQm9ORVU3UXp6NGNIMW9w?=
 =?utf-8?B?Y3djVFF1SFNJNFhoa2Mramd1SnRaR0l4NW94a2N6b2RyNkRETWgwQnM1SWda?=
 =?utf-8?B?QXpVSmVCRVp2WnA5MnQxY3JoU0J6RUd4LzA5RkhYZUZtK2Y4a0NockQ0MVI5?=
 =?utf-8?B?Nkt0WDdMVlZORHd0akVoL0VwVEhFMEhIMjJuYnoyaWJXSU1EdHRLYzEvVTVU?=
 =?utf-8?B?UHViTzg2ZmVJaHVBd0hDNTF6S3lhbXo2MTdVMjNsdDVxMU9rZStrVmkvUXhF?=
 =?utf-8?B?WVVWa0VUVEZkOG12ZUVFWUFzZmhPNWlHVkpDaWY2YTNFN2svV1FlZkxjZFJv?=
 =?utf-8?B?eFBTRk9nQks4aEZsZ25OMFlXazR5YlhLSGlCdFdxVE0zd2M0S1NtNW15VFNO?=
 =?utf-8?B?YkF2djZ1bVNlaUF6SUtLZHY3ZXFBMUdXTGZSS2dueUp5ajZFTFBYV0FBK0Vp?=
 =?utf-8?B?cEtkcGl5MkZrVS9aWHlvUlFvNEFsZ1g1WlNlT2xsZERDbkZkajdlSUtWazRu?=
 =?utf-8?B?c2VML1pFdWJrVmVhZjJVYWhTdEhMR0VqeFJMd1Z1MkorQmpEbEF3SmdIdi9E?=
 =?utf-8?B?M3hlR0k3a0kzZFdBclJ4RDRHSjA0Ulp2YVRBaVRrRDl0RmwwOFY5UzlEZ0wx?=
 =?utf-8?B?ZDNCS3BwM1M1UmNFcW5GNWNSSjN4VzUwWVJVZHBGM2c1K255UHJTRWhZcTFo?=
 =?utf-8?B?dWdzWis3SCtwcXRtRDZ3Z1pBSTJ0ZFFzd1VXS042Q0NKNnlWUGJWdmJVQTFR?=
 =?utf-8?B?YTdGN0p5OXpBVEFJRGkxclNnS3B5d0E0dkdDWDlUNGUvcWtWam80dm1MaXk3?=
 =?utf-8?B?TlBlR1NzUk5CZVRDTHRpWE5CcU9mRTBtYm5HWUNFL3kxOVF5eWcxbW1qWkpj?=
 =?utf-8?B?dGkwV3YxM3o2dGEybm14TmQrQzlGSHIxRjgzNVJwNzRhZGpiY0Z5TGs1dkhM?=
 =?utf-8?B?REpDaWxHaUtNNDY0YlRNQytUc09FMEIyMUxZczJSK3RMM2xtM3A5dkdORGFu?=
 =?utf-8?B?aUNLR2VOWmRLR1N3cEhVNG5IVHBBZVUzelQwVUw3T20zZk5KMEJSOXFUaEh6?=
 =?utf-8?B?bFBHVFJyakZqZzdOQmwzREh1WTFjTWhCNGxBNUhtdVgrMC9Ja3VaRkYvOUJD?=
 =?utf-8?Q?WhJ57AEvNGzZVvibfxBC6Q+On6noepf6/SdZ3SF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0F3A910A291714F9E1791FA2B2BC6AA@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e35ee385-cb75-4e01-1ab7-08dd6391f42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 07:21:07.3920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6244

DQoNCj4gT24gMTUgTWFyIDIwMjUsIGF0IDEyOjM54oCvUE0sIEFkaXR5YSBHYXJnIDxnYXJnYWRp
dHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gMTUgTWFyIDIwMjUsIGF0
IDM6MjfigK9BTSwgRXRoYW4gQ2FydGVyIEVkd2FyZHMgPGV0aGFuQGV0aGFuY2Vkd2FyZHMuY29t
PiB3cm90ZToNCj4+IA0KPj4gSGVsbG8gZXZlcnlvbmUsDQo+PiANCj4+IFRoaXMgaXMgYSBmb2xs
b3cgdXAgcGF0Y2hzZXQgdG8gdGhlIGRyaXZlciBJIHNlbnQgYW4gZW1haWwgYWJvdXQgYSBmZXcN
Cj4+IHdlZWtzIGFnbyBbMF0uIEkgdW5kZXJzdGFuZCB0aGlzIHBhdGNoc2V0IHdpbGwgcHJvYmFi
bHkgZ2V0IHJlamVjdGVkLCANCj4+IGJ1dCBJIHdhbnRlZCB0byByZXBvcnQgb24gd2hhdCBJIGhh
dmUgZG9uZSB0aHVzIGZhci4gSSBoYXZlIGdvdCB0aGUgDQo+PiB1cHN0cmVhbSBtb2R1bGUgaW1w
b3J0ZWQgYW5kIGJ1aWxkaW5nLCBhbmQgaXQgcGFzc2VzIHNvbWUgYmFzaWMgdGVzdHMgDQo+PiBz
byBmYXIgKEkgaGF2ZSBub3QgdHJpZWQgZ2V0dGluZyBYRlMvRlN0ZXN0cyBydW5uaW5nIHlldCku
IA0KPj4gDQo+PiBMaWtlIG1lbnRpb25lZCBlYXJsaWVyLCBzb21lIG9mIHRoZSBmaWxlcyBoYXZl
IGJlZW4gbW92ZWQgdG8gZm9saW9zLCBidXQNCj4+IGEgbGFyZ2UgbWFqb3JpdHkgb2YgdGhlbSBz
dGlsbCB1c2UgYnVmZmVyaGVhZHMuIEkgd291bGQgbGlrZSB0byBoYXZlDQo+PiB0aGVtIGNvbXBs
ZXRlbHkgcmVtb3ZlZCBiZWZvcmUgbW92ZWQgZnJvbSBzdGFnaW5nLyBpbnRvIGZzLy4NCj4+IA0K
Pj4gSSBoYXZlIHNwbGl0IGV2ZXJ5dGhpbmcgdXAgaW50byBzZXBhcmF0ZSBjb21taXRzIGFzIGJl
c3QgYXMgSSBjb3VsZC4NCj4+IE1vc3Qgb2YgdGhlIEMgZmlsZXMgcmVseSBpbiBmdW5jdGlvbnMg
ZnJvbSBvdGhlciBDIGZpbGVzLCBzbyBJIGluY2x1ZGVkDQo+PiB0aGVtIGFsbCBpbiBvbmUgcGF0
Y2gvY29tbWl0Lg0KPj4gDQo+PiBJIGFtIGN1cmlvdXMgdG8gaGVhciBldmVyeW9uZSdzIHRob3Vn
aHRzIG9uIHRoaXMgYW5kIHRvIHN0YXJ0IGdldHRpbmcNCj4+IHRoZSBiYWxsIHJvbGxpbmcgZm9y
IHRoZSBjb2RlLXJldmlldyBwcm9jZXNzLiBQbGVhc2UgZmVlbCBmcmVlIHRvDQo+PiBpbmNsdWRl
L0NDIGFueW9uZSB3aG8gbWF5IGJlIGludGVyZXN0ZWQgaW4gdGhpcyBkcml2ZXIvdGhlIHJldmll
dw0KPj4gcHJvY2Vzcy4gSSBoYXZlIGluY2x1ZGVkIGEgZmV3IHBlb3BsZSwgYnV0IGhhdmUgY2Vy
dGFpbmx5IG1pc3NlZCBvdGhlcnMuDQo+PiANCj4+IFswXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDI1MDMwNzE2NTA1NC5HQTk3NzRAZWFmLw0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5
OiBFdGhhbiBDYXJ0ZXIgRWR3YXJkcyA8ZXRoYW5AZXRoYW5jZWR3YXJkcy5jb20+DQo+IA0KPiBX
aHkgaGFzbuKAmXQgRXJuZXN0byBzaWduZWQtb2ZmIGhlcmUsIG9yIGluIGFueSBwYXRjaD8gQUZB
SUssIGhlIGlzIHRoZSBhdXRob3Igb2YgdGhlIGRyaXZlci4NCg0KSSBjYW4gYWxzbyBzZWUgeW91
ciBDb3B5cmlnaHQgYXQgc29tZSBwbGFjZXMsIHdoaWNoIEkgZGlkbid0IGZpbmQgaW4gdGhlIHVw
c3RyZWFtIHJlcG8uIERpZCB5b3UgYWRkIHNvbWUgY29kZSBjaGFuZ2U/DQoNCklNTywgaWYgeW91
IGFyZSBqdXN0IG1haW50YWluaW5nIGl0LCBkb2Vzbid0IG1lYW4geW91IGFkZCB5b3VyIGNvcHly
aWdodC4gRWc6IEkgbWFpbnRhaW4gdGhlIGFwcGxldGJkcm0gZHJpdmVyLCBidXQgSSBkaWRuJ3Qg
d3JpdGUgb3IgYWRkIGFueXRoaW5nIHNwZWNpYWwgaW4gaXQsIHNvIGl0IGRvZXNu4oCZdCBoYXZl
IG15IGNvcHlyaWdodC4NCg0KQWxzbywgZGlkIHlvdSBhc2sgRXJuZXN0byB3aGV0aGVyIGhlIHdh
bnRzIHRvIGJlIGEgY28gbWFpbnRhaW5lcj8NCg0KPj4gLS0tDQo+PiBFdGhhbiBDYXJ0ZXIgRWR3
YXJkcyAoOCk6DQo+PiAgICBzdGFnaW5nOiBhcGZzOiBpbml0IGx6ZnNlIGNvbXByZXNzaW9uIGxp
YnJhcnkgZm9yIEFQRlMNCj4+ICAgIHN0YWdpbmc6IGFwZnM6IGluaXQgdW5pY29kZS57YyxofQ0K
Pj4gICAgc3RhZ2luZzogYXBmczogaW5pdCBhcGZzX3Jhdy5oIHRvIGhhbmRsZSBvbi1kaXNrIHN0
cnVjdHVyZXMNCj4+ICAgIHN0YWdpbmc6IGFwZnM6IGluaXQgbGliemJpdG1hcC57YyxofSBmb3Ig
ZGVjb21wcmVzc2lvbg0KPj4gICAgc3RhZ2luZzogYXBmczogaW5pdCBBUEZTDQo+PiAgICBzdGFn
aW5nOiBhcGZzOiBpbml0IGJ1aWxkIHN1cHBvcnQgZm9yIEFQRlMNCj4+ICAgIHN0YWdpbmc6IGFw
ZnM6IGluaXQgVE9ETyBhbmQgUkVBRE1FLnJzdA0KPj4gICAgTUFJTlRBSU5FUlM6IGFwZnM6IGFk
ZCBlbnRyeSBhbmQgcmVsZXZhbnQgaW5mb3JtYXRpb24NCj4+IA0KPj4gTUFJTlRBSU5FUlMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNiArDQo+PiBkcml2ZXJzL3N0
YWdpbmcvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICsNCj4+IGRyaXZl
cnMvc3RhZ2luZy9hcGZzL0tjb25maWcgICAgICAgICAgICAgICAgICAgICB8ICAgMTMgKw0KPj4g
ZHJpdmVycy9zdGFnaW5nL2FwZnMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAxMCAr
DQo+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9SRUFETUUucnN0ICAgICAgICAgICAgICAgICAgfCAg
IDg3ICsNCj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL1RPRE8gICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgIDcgKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvYXBmcy5oICAgICAgICAgICAgICAg
ICAgICAgIHwgMTE5MyArKysrKysrKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvYXBmc19yYXcu
aCAgICAgICAgICAgICAgICAgIHwgMTU2NyArKysrKysrKysrKw0KPj4gZHJpdmVycy9zdGFnaW5n
L2FwZnMvYnRyZWUuYyAgICAgICAgICAgICAgICAgICAgIHwgMTE3NCArKysrKysrKw0KPj4gZHJp
dmVycy9zdGFnaW5nL2FwZnMvY29tcHJlc3MuYyAgICAgICAgICAgICAgICAgIHwgIDQ0MiArKysN
Cj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2Rpci5jICAgICAgICAgICAgICAgICAgICAgICB8IDE0
NDAgKysrKysrKysrKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvZXh0ZW50cy5jICAgICAgICAg
ICAgICAgICAgIHwgMjM3MSArKysrKysrKysrKysrKysrDQo+PiBkcml2ZXJzL3N0YWdpbmcvYXBm
cy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMTY0ICsrDQo+PiBkcml2ZXJzL3N0YWdp
bmcvYXBmcy9pbm9kZS5jICAgICAgICAgICAgICAgICAgICAgfCAyMjM1ICsrKysrKysrKysrKysr
Kw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMva2V5LmMgICAgICAgICAgICAgICAgICAgICAgIHwg
IDMzNyArKysNCj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2xpYnpiaXRtYXAuYyAgICAgICAgICAg
ICAgICB8ICA0NDIgKysrDQo+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9saWJ6Yml0bWFwLmggICAg
ICAgICAgICAgICAgfCAgIDMxICsNCj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNlL2x6ZnNl
LmggICAgICAgICAgICAgICB8ICAxMzYgKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2Uv
bHpmc2VfZGVjb2RlLmMgICAgICAgIHwgICA3NCArDQo+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9s
emZzZS9semZzZV9kZWNvZGVfYmFzZS5jICAgfCAgNjUyICsrKysrDQo+PiBkcml2ZXJzL3N0YWdp
bmcvYXBmcy9semZzZS9semZzZV9lbmNvZGUuYyAgICAgICAgfCAgMTYzICsrDQo+PiBkcml2ZXJz
L3N0YWdpbmcvYXBmcy9semZzZS9semZzZV9lbmNvZGVfYmFzZS5jICAgfCAgODI2ICsrKysrKw0K
Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHpmc2VfZW5jb2RlX3RhYmxlcy5oIHwgIDIx
OCArKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHpmc2VfZnNlLmMgICAgICAgICAg
IHwgIDIxNyArKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHpmc2VfZnNlLmggICAg
ICAgICAgIHwgIDYwNiArKysrKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHpmc2Vf
aW50ZXJuYWwuaCAgICAgIHwgIDYxMiArKysrKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpm
c2UvbHpmc2VfbWFpbi5jICAgICAgICAgIHwgIDMzNiArKysNCj4+IGRyaXZlcnMvc3RhZ2luZy9h
cGZzL2x6ZnNlL2x6ZnNlX3R1bmFibGVzLmggICAgICB8ICAgNjAgKw0KPj4gZHJpdmVycy9zdGFn
aW5nL2FwZnMvbHpmc2UvbHp2bl9kZWNvZGVfYmFzZS5jICAgIHwgIDcyMSArKysrKw0KPj4gZHJp
dmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHp2bl9kZWNvZGVfYmFzZS5oICAgIHwgICA2OCArDQo+
PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9semZzZS9senZuX2VuY29kZV9iYXNlLmMgICAgfCAgNTkz
ICsrKysNCj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNlL2x6dm5fZW5jb2RlX2Jhc2UuaCAg
ICB8ICAxMTYgKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbWVzc2FnZS5jICAgICAgICAgICAg
ICAgICAgIHwgICAyOSArDQo+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9uYW1laS5jICAgICAgICAg
ICAgICAgICAgICAgfCAgMTMzICsNCj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL25vZGUuYyAgICAg
ICAgICAgICAgICAgICAgICB8IDIwNjkgKysrKysrKysrKysrKysNCj4+IGRyaXZlcnMvc3RhZ2lu
Zy9hcGZzL29iamVjdC5jICAgICAgICAgICAgICAgICAgICB8ICAzMTUgKysrDQo+PiBkcml2ZXJz
L3N0YWdpbmcvYXBmcy9zbmFwc2hvdC5jICAgICAgICAgICAgICAgICAgfCAgNjg0ICsrKysrDQo+
PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9zcGFjZW1hbi5jICAgICAgICAgICAgICAgICAgfCAxNDMz
ICsrKysrKysrKysNCj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL3N1cGVyLmMgICAgICAgICAgICAg
ICAgICAgICB8IDIwOTkgKysrKysrKysrKysrKysNCj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL3N5
bWxpbmsuYyAgICAgICAgICAgICAgICAgICB8ICAgNzggKw0KPj4gZHJpdmVycy9zdGFnaW5nL2Fw
ZnMvdHJhbnNhY3Rpb24uYyAgICAgICAgICAgICAgIHwgIDk1OSArKysrKysrDQo+PiBkcml2ZXJz
L3N0YWdpbmcvYXBmcy91bmljb2RlLmMgICAgICAgICAgICAgICAgICAgfCAzMTU2ICsrKysrKysr
KysrKysrKysrKysrKysNCj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL3VuaWNvZGUuaCAgICAgICAg
ICAgICAgICAgICB8ICAgMjcgKw0KPj4gZHJpdmVycy9zdGFnaW5nL2FwZnMveGF0dHIuYyAgICAg
ICAgICAgICAgICAgICAgIHwgIDkxMiArKysrKysrDQo+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy94
ZmllbGQuYyAgICAgICAgICAgICAgICAgICAgfCAgMTcxICsrDQo+PiA0NSBmaWxlcyBjaGFuZ2Vk
LCAyODk4NCBpbnNlcnRpb25zKCspDQo+PiAtLS0NCj4+IGJhc2UtY29tbWl0OiA2OTVjYWNhOTM0
NWExNjBlY2Q5NjQ1YWJhYjhlNzBjZmU4NDllOWZmDQo+PiBjaGFuZ2UtaWQ6IDIwMjUwMjEwLWFw
ZnMtOWQ0NDc4Nzg1ZjgwDQo+PiANCj4+IEJlc3QgcmVnYXJkcywNCj4+IC0tIA0KPj4gRXRoYW4g
Q2FydGVyIEVkd2FyZHMgPGV0aGFuQGV0aGFuY2Vkd2FyZHMuY29tPg0KDQoNCg==


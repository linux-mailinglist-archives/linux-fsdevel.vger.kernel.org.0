Return-Path: <linux-fsdevel+bounces-48925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C55AB6024
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 02:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AD419E2FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 00:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3282C859;
	Wed, 14 May 2025 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="S8/Nx56T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010065.outbound.protection.outlook.com [52.101.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23DD17736;
	Wed, 14 May 2025 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182366; cv=fail; b=DY/iDsREIVkV2b1Xp57xJk/RJtNxr7M/cqI/Z4rMpyVCgp8/9hPJyJbS5Y148HIez/WH+EibJuHFFQaLaRWinSu6Z8ycwG9OCI2fOgt6LK9bNM4reybAdDCwYGJ1N4ejBBarHfN19acBBwPcOW9hs+W9/Gblvk2gN+RCe+FAsEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182366; c=relaxed/simple;
	bh=RsgiBWA48pl4tBZVRSStDN5aFhrx7N5+kVEZFi1Hrdw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aEM94F9hr/TQVkbqIsAgzE5WHfvWoLn9XK1MfrLzEYjqYXqUtR4U6tUCa0JOFKm1zfV8LzZjNRrd8weAvYtWgL/Lxjg5S8vY4W0aTpJvc9BYjG6l/OhDBtYZCy9Tvt8E2lZSVGRnyh2vKv/W82cFaKCxE3WnVsjjpXDQJ0/8Akg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=S8/Nx56T; arc=fail smtp.client-ip=52.101.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sz62bdH5KIGioPWHtJ3FNEpwOdLiaFpHWUhqUDMk8pgaCvLWmceJbHoB44wYWi/rzV1A+/qcVQNfo8nMxIwcApdJqWm81a7a7r66B6MGikpfz5o7ZoHtt8diFjJNOyD+KbE6os43kktZl9Be2ZyrwWam8cCq8H/CE9nESLqCn1WHQgH00RYB29xDBGOaqTghWRvpSJsBG86f5ZjoLtlohM3fElElKBfcLCY9Ob5fJ9+Qep+KL5yVxQq/R3WkR8JLIWmAycz2m/HQ5cGwpITaROw++ImwIA5/89ASFaVaWs0o2bygY3/WZBKkGO7D9J1DycD8pbhTsIds2MaeDiyznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4AK32+IdM1XDz/cpCFbnxySdzECHCqowRhRT6t4H9Q=;
 b=iXOanSIeu5oedPQoAssR0o4FdNfEF9h1HvGSivahBpldVQV5rNYewwyvjux6UDgVXNhPMKt5zs699ZS3yU4HTjVkWScrqOQAF1sivOfAgnYX7b95l9HYsNOKr7q4x4YkwchQd3c4vd9VEkaMkKQjwcBIHqKzca8wo3JSD5B0orNDJnbHXa0TZ+c5MChmMAYZbYgnhLyQ9SjV5oGe+D64bKdFmYP3p3nrNDv6zI69m3hI576sZH7Y6yvzi6kdEG+bniH7XhcGkSFnTnrSpKec6CxfdNlu8RpX2iOXn5AdWv3jsuGCCVQT30R6Zg5fuEoJzdSugv11QZSbT6nbfKLvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4AK32+IdM1XDz/cpCFbnxySdzECHCqowRhRT6t4H9Q=;
 b=S8/Nx56TOt9kldWhtRqRObIUEfSxXUhkLG/LlHiJy0QdlRrzTqv6EbsrhmFJuA4TA8sBiCS/h/KDj43lmh1AA2fieZatkAurmVQ7IEr3kdr8PGTpqFyZe/kFe/Z4/nTtVpHlhRrk9JvIGNTDljKLwkxFoIHnrNCLjExMtoxIxEwjXyN6vb/foUWwTPgVJHbQvBZ6YqKZjCbwSkOgqTJWSyBCL1D8dTI6niO8N+h2SqTi8Zjk3Da5y8mEEneXXs0925teEmlR6e0KWYf0L2dmHhAK2QG5Vu8Lc4Xtnb6j1NTQGy4vDl1/ShZsPJpwtan8S+GUl5fJ1om61psx+2j4YA==
Received: from OS3PR01MB9659.jpnprd01.prod.outlook.com (2603:1096:604:1e9::7)
 by OSZPR01MB9503.jpnprd01.prod.outlook.com (2603:1096:604:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 00:25:58 +0000
Received: from OS3PR01MB9659.jpnprd01.prod.outlook.com
 ([fe80::9458:e2d1:f571:4676]) by OS3PR01MB9659.jpnprd01.prod.outlook.com
 ([fe80::9458:e2d1:f571:4676%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 00:25:58 +0000
From: =?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>
CC: "mike@mbaynton.com" <mike@mbaynton.com>, "miklos@szeredi.hu"
	<miklos@szeredi.hu>, "amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
Subject: [PATCH] fs: allow clone_private_mount() for a path on real rootfs
Thread-Topic: [PATCH] fs: allow clone_private_mount() for a path on real
 rootfs
Thread-Index: AQHbxGbDT+OhO7ZF6EeAP0BuuYit0w==
Date: Wed, 14 May 2025 00:25:58 +0000
Message-ID: <20250514002650.118278-1-kazuma-kondo@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9659:EE_|OSZPR01MB9503:EE_
x-ms-office365-filtering-correlation-id: 2d2155c4-6914-44b7-c73f-08dd927de642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?M1JxdlZFWmVMYkwzaldqT1VOdHFaUXNyWnArZWxvejFYNU9YZXdOWFBS?=
 =?iso-2022-jp?B?ekZzMzd6Y1ZpVTYraDZxTldEazY0MEg5TVpwSzNERUJDOTdhQXVKMk8z?=
 =?iso-2022-jp?B?anhWcDNtdlNPeXM3bjIzTERjLytBUTRBUnB1aGk0YVNpUzJKTmhncWRj?=
 =?iso-2022-jp?B?TFRvOHE5dkgzZS9BNWViV3pUT3RaNXhJdkVvaFMxMEF2Y3hkNGVtTTJl?=
 =?iso-2022-jp?B?ZVdnQzc1WEYydnRDU1Jjd2EwTzJtS2NhQVZ6UHhCZ0J6RWI3aGNYYWo4?=
 =?iso-2022-jp?B?dDQxdi81NXorTHNBd0NtbmFnVzlXSWdwTDBZVitqUmxoMDh4a1NVMktl?=
 =?iso-2022-jp?B?UnNGRjMrSkhkNXlkRmM0VXZmTkY4VlRBcXpLaEE3eVUvWU0zV0xuK2dD?=
 =?iso-2022-jp?B?WmtVSEJ1WXJoazNKQXJway96VmlCSE4wcllqVi9oRzFtT3p6bzhFeFN2?=
 =?iso-2022-jp?B?Mzh1Ky9IM0ovYWxJdEs5NldOVnk5Y0h4dHhCcUN0dlRCTjM2dFY0ZmNC?=
 =?iso-2022-jp?B?S3Z5Z2xlZldFb2RRNnd5OTh5THROYzY0YkpEb1hxbWM1eWlPekpzeTBB?=
 =?iso-2022-jp?B?OWthNHg1UUlSRm0rWHdQdnNhUWVha2JPU1Mvd1BLV3h0ZnEwa1VHN2hz?=
 =?iso-2022-jp?B?aUppMmpXaUtta1hUNnRuSnN4cTNvVW5CR1RTN0RrZzliNjQrRHQ3SFQw?=
 =?iso-2022-jp?B?a1Job3VpaGVEUVpoZVJOZC8zcVlnOENXeUQwWWZ1emkvVmxhblNwSUkz?=
 =?iso-2022-jp?B?aFU5cmRqSW14V003dlZpYzVQUmRncGVxSjlDaVdWYjJNUzdrRXplNGtH?=
 =?iso-2022-jp?B?emVXNFBEV3RkNEZPMXZ1RlV3V3JvbjV2bXlKMUtjbHVTZVVDdzJMVzEy?=
 =?iso-2022-jp?B?SUxpZk9BY2hMNjZCT2Q2TE9vcWxzcWdQdjZFODFNM2JsallxVXNTU21q?=
 =?iso-2022-jp?B?Wm80NmdCNnlEVU9TOThNNFZQdGxJNE82OWpMQlR3S3ZCT3R1RHR5SlRk?=
 =?iso-2022-jp?B?VXVibmtuaGxnUkFrU2ZJYXJ5bGJaQWczbVVRenBMeGdhbGN2dm5Sb1Zi?=
 =?iso-2022-jp?B?Unl1QSs4YXZEN0NzS0xSakdRdFlqZStqRUcvVmt4UENKck13Z2pNaTJi?=
 =?iso-2022-jp?B?YVM1dXpqcFkxWFQrZzZ0ZXVlTXMwbHYyU2JJajBhRGFwYzVvaDh6T3JI?=
 =?iso-2022-jp?B?WkhSaW9jSU9ZYk56R0lWM293RWMwVHJRUWpKNURieEN1MW1ueHVjdlls?=
 =?iso-2022-jp?B?MjQ0bTlBR0VvekZGemUwZFhQbVBRK3IvVkhaOVdQRTBPMmJHRjJSRTBT?=
 =?iso-2022-jp?B?alpraDA2T0hFdmtLcG00V2Q3ekFLWWU1d3JXMTVuRTc1Vyt5ZWM3YktO?=
 =?iso-2022-jp?B?Z2RybGQvbHVOQ1gyRzJWVllTWmsweU5GQ1JYaU1MZXp5WVdQYkdIL3py?=
 =?iso-2022-jp?B?TWduQkxwRDhIUnl4cy9UZk92SEgzVlZWeUM3WUpIbTBhZzUwMXplK21L?=
 =?iso-2022-jp?B?eStnclVMRjJWVlM4akgvT3d1N2VmSDljQjFLUHQ1d2gwZmtzS2MySHpp?=
 =?iso-2022-jp?B?bk45MUFkOFlLZ1hPOHpPeXRyaVJTR1JHdkxFRGUrR1lWMkZEL2hqVXV5?=
 =?iso-2022-jp?B?WHBEUkpuYTlEcWJBRndSUVRvWHBGdDlxa0Z2UkpTd056L2Y3THZjSGJD?=
 =?iso-2022-jp?B?MzNtUkFzSkRPM3VSb0RjUGlyTlhkMHplazNBZkpUQ1hHK21MQjdNRTlQ?=
 =?iso-2022-jp?B?aEtxVnNrY2Y3SStRdDFWZXlGaXg5aGsyb3FINmEwWkMwVmJEWlFLUmxq?=
 =?iso-2022-jp?B?bkxYcVoxZG1zSDZ3YzQ2eGxpVHczNm5QSktkRTNIQWNBazdHTXdSU0hy?=
 =?iso-2022-jp?B?MXZhSnZjalpPcjZRYjViN3RYaG9mWlZDb0diaGtNdGVPanVlR29jVFAy?=
 =?iso-2022-jp?B?QkxwNSt5VlhOTXpSaUFOSHpZWnhDV0k4enJPTnBvYkVFVW1NK0lMWUlM?=
 =?iso-2022-jp?B?d3BoOElTd1JyVmsrL0tmOUpHQ09Ndnd6TEdGeUlSd2ZxZXkzakF4R001?=
 =?iso-2022-jp?B?Q05vUUJuc0NnOENMOFhINU1rQlA3akc1SExRampaVGVnUHo5UDBtckQ3?=
 =?iso-2022-jp?B?VXlMTjAydzY2UVhKclB6dTdCdlltMkpuUU9lYndYMlRsR0xGZ3VLOWNh?=
 =?iso-2022-jp?B?OXZRPQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9659.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NFZxQ1NxUjF2V0U0TWozbmpuZzBTcEtVNWRnUnlwN1BIVWdaR04wU24v?=
 =?iso-2022-jp?B?bVUvZ0MzeG4xNE1GZE9TU3UwNmdhdGZLdDBqZXVFVHRWYUVwSWRNZUds?=
 =?iso-2022-jp?B?MjVJenZodkFuaHl1MGRaTGRkUVpFelFWSUpMTXc5b29nMHpDTHcxUlNQ?=
 =?iso-2022-jp?B?MlVRNkgyZXNxY2NNNytHcEIyREFDRVo4VzY4VGlJRWt0YzRuUW5VemNM?=
 =?iso-2022-jp?B?OTlwUU1tZ21PM0xrQm90czZpUk1XS0k2TS82OWxjS3ovV0lKYlFUUDh6?=
 =?iso-2022-jp?B?VzdneXYvbUFpYTl4a00vNVpiUlpJTTUzUHpsYzVTVXNrcno5cE5zbHBS?=
 =?iso-2022-jp?B?dWJad1dwYkN1a002dGZobk5pb0d4OTNhOXpZbGE4SkV4MkxPM0dFM084?=
 =?iso-2022-jp?B?MlVmQitiMk4zRXNPaHNUQWdnMjYrTnFHY2pHSVF1cnltc3V5REl0ZTg4?=
 =?iso-2022-jp?B?NVBidGRkaDZMWjBiVVFwUEJ1cUM2M0hiLzRmN0RJRnZxa1pEM0x1azVI?=
 =?iso-2022-jp?B?N082ekhIbjFOT0xNeExxZFBwcVFSaFBrNWJqdGF6Y2tiNFBtVTJkWnR6?=
 =?iso-2022-jp?B?ektOZUtwRHdmM3VuTVhOUFV0bzZWT1d0b1lwMGpmaFJxVkV2VVlDUUVq?=
 =?iso-2022-jp?B?bkdHMU45VVY4clkwWnBNQzQ4aSs0bTdUOVh4WDVDOWQ0Qkc5YUUxaVJs?=
 =?iso-2022-jp?B?bHhNSXpCbTltNzdPZjRMNVhFZjIvZGVmSDhEVzlSczlhOVRKZHNFWlNE?=
 =?iso-2022-jp?B?dWlhMFhnMm4zU0wzYUh6Y2dkQWI2cnQ1SXpyanJoVXdZMG1uakk1ZFZI?=
 =?iso-2022-jp?B?eFJRNlN3N0pYdDlCdnRDQk0wMXgvRGNWSllSYWhyVlo1c294eVlPbWNS?=
 =?iso-2022-jp?B?VTZkSEZ6TmR6Z05PZkY1SWpyN2o2NnFadnlLS1VrdVJid2JIY0wzcTBl?=
 =?iso-2022-jp?B?U3dsQkxKeDNyQjhGZVV0Z3lDYzZ3R01ZT2VOWFlYSURxSnUxaGM3RTli?=
 =?iso-2022-jp?B?dUtvYlJNdmR0cXlhdEMvOWdZcFVFeDc5NktrRnVTRnhMeFgvUFFsaGpk?=
 =?iso-2022-jp?B?SzRmcUtPenVaeFRMODNTU1Y0Z1M2Vy9CdXdKLzlxUjNXem81K05QWHQ2?=
 =?iso-2022-jp?B?R2lHMTFiWGhuWnIyeW5NMkdjd05YT2hwMWRTbm1sOVM1a3cyRjNkMVU4?=
 =?iso-2022-jp?B?MUppbHJhUFBnNS84RFIzTVI2eFVSOTQ5ajF4Tzc5ZzlMSFFPMzAvdGR1?=
 =?iso-2022-jp?B?RTkvMytsMElqY0tKYWtwOU50ZVlYYi9sNGl3WWErOHBNZHUxT3ZFZXNw?=
 =?iso-2022-jp?B?TXIrNXlOSEtRS2JoeDEyK1BaTE5hdXJSd1RNWnpsOWhiYm5kMDZvTnRv?=
 =?iso-2022-jp?B?azloTktzQTRzMGhnaTRRUHA2YmcvbmhjcmprVTdCT056QTVPU0djYS90?=
 =?iso-2022-jp?B?VGw0UVZDSVBZUkp2RFg0T0hBeGdnTytzZ0tLTjNiZ21DSE43cHZFL2hZ?=
 =?iso-2022-jp?B?UGxYVGxxb1RxZlE2cXhueE1EZ3puZkl0aG9KQVJrcmRMWGtkZ05XZW9Q?=
 =?iso-2022-jp?B?Q0tvL1lGNmd1aEVqTThjT3ExRmJRMU5WbGVzK1c3MHpSL2owTXRaZTFy?=
 =?iso-2022-jp?B?VGQrOUJKQWoyNVlJVU9JbmU3Ymx4UXVVOHI3RldtU2NsTHBlL0p0QTFS?=
 =?iso-2022-jp?B?MnNaM2ZPRGRZaER6ZkNWZVNHY2t4bjBiSGQ4bldqY3lzQlNVSGwzaHRh?=
 =?iso-2022-jp?B?Y1RNaWNHSGRWVW5YNlU0MVNsY1RlaHFXS0hVN1c0L21scEZ5bmxja1F4?=
 =?iso-2022-jp?B?ZXFUVkx3ZTczT3NKczRoLzcvZ2E5SStoWlRUSUlVb0FTQzA4a0xiajBK?=
 =?iso-2022-jp?B?c2VmdjdyeHphNlF3T0Z4TmhtNlVDNTJrNk9lTnZFUnEwdGdLeERYbzV4?=
 =?iso-2022-jp?B?WHhYaHQwU1FULzhCc1l2STZWVnRkNHduUi90RXBxRUI1bWcyaGVWMFda?=
 =?iso-2022-jp?B?SW9UTHJ2MW5QWHgxNk1lMitzOERIUk96Ri9uUEtvWGpkNStRWEh1SEhs?=
 =?iso-2022-jp?B?NDQ1UmlicC81bk5kR0hqMllFeGRsenc5U0hLRHBpS20yTjVVVVRBdDFY?=
 =?iso-2022-jp?B?MTlUNzI3aHVVSXJqU2FFRGMwQ1JVVmR1VGhDZ2FneEJrMlNKRU9EVHI1?=
 =?iso-2022-jp?B?a0xhOEMvVTQ0UGhVR1V3UHNSVmdrUzJiaG13cWtTbGExemExTWh5NmUx?=
 =?iso-2022-jp?B?ZWIvdk8rYTIrdTlOSHJ3RlBOS01oU0RjcnQ0N2thMXZLRkowVWQ4TE1H?=
 =?iso-2022-jp?B?NzNZdllhdVpaS1BUQWJudFBTdDBoTnY3blE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9659.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2155c4-6914-44b7-c73f-08dd927de642
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 00:25:58.8035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OS0OGCc9D8BncUXuaX0WZACtkMhlvA/PxkRkuu0WyPqtghE8ooaW0AY1XVA/HcmxeHPHDPyQGTV/+mjiTbK2uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9503

Mounting overlayfs with a directory on real rootfs (initramfs)
as upperdir has failed with following message since commit [1].

  [    4.080134] overlayfs: failed to clone upperpath

Overlayfs mount uses clone_private_mount() to create internal mount
for the underlying layers.

The commit [1] made clone_private_mount() reject real rootfs because
it does not have a parent mount and is in the initial mount namespace,
that is not an anonymous mount namespace.

This issue can be fixed by relaxing the permission check
of clone_private_mount(), similar to [2].

[1] commit db04662e2f4f ("fs: allow detached mounts in clone_private_mount(=
)")
[2] commit 46f5ab762d04 ("fs: relax mount_setattr() permission checks")

Fixes: db04662e2f4f ("fs: allow detached mounts in clone_private_mount()")
Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>
---
 fs/namespace.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1b466c54a357..277dbf18e160 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2482,17 +2482,13 @@ struct vfsmount *clone_private_mount(const struct p=
ath *path)
 	if (IS_MNT_UNBINDABLE(old_mnt))
 		return ERR_PTR(-EINVAL);
=20
-	if (mnt_has_parent(old_mnt)) {
+	if (!is_mounted(&old_mnt->mnt))
+		return ERR_PTR(-EINVAL);
+
+	if (mnt_has_parent(old_mnt) || !is_anon_ns(old_mnt->mnt_ns)) {
 		if (!check_mnt(old_mnt))
 			return ERR_PTR(-EINVAL);
 	} else {
-		if (!is_mounted(&old_mnt->mnt))
-			return ERR_PTR(-EINVAL);
-
-		/* Make sure this isn't something purely kernel internal. */
-		if (!is_anon_ns(old_mnt->mnt_ns))
-			return ERR_PTR(-EINVAL);
-
 		/* Make sure we don't create mount namespace loops. */
 		if (!check_for_nsfs_mounts(old_mnt))
 			return ERR_PTR(-EINVAL);
--=20
2.49.0


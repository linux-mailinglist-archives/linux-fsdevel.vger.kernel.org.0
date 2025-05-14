Return-Path: <linux-fsdevel+bounces-48939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22808AB6627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14CC19E30C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0345B21D3F8;
	Wed, 14 May 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="hazj4NpF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010010.outbound.protection.outlook.com [52.101.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2D4B5AE;
	Wed, 14 May 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211879; cv=fail; b=Gs83hY9Qd7x2VAXapevzJZqF/cQ6jonxZCM4+oY2tD9X7KNwElljVuB98yb8H634oXi3cADfbGPxIo6lt02dO4CVkVZsQRzv0vjFC9zARQYfqq+pBIJG8CJ/XM3iWB2TgNtVUdtImjd92nbpJiZAIPkNhQD+P2w/gmclRizOZKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211879; c=relaxed/simple;
	bh=qq/xBEiyTfWnQsYmMNg7J8MO9n8bYgkynw59jX99URI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TM/aO4FqbEB9c65RTNizsdjfkuOLSQ8d1M9wsQzpZOj7qstVxnPWiWW9dnfNU1S/B+oPr5yNk4g/EyF3wQ77WZtFowILN5TmtW61W5aDaVZOqFTktUce/01QOgaLDDOn2Psste9uTtbmMP7sIsmiEeBJXcVNNGr3Amqg4IVzK5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=hazj4NpF; arc=fail smtp.client-ip=52.101.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws5mcM+i7hHzW16atlxTiDfXNp/NqN/FvXl3f286FqQ7O3rU3RWW442hy2jGJWp+N6rE7030FPjDRkY5Wd6Oja17rqesJLMmAQhrx0EYc/+rphQ0HyPffXyaBp6HoRPQZUjNvtVbVUvcEnOj9ujx/+7Z4d+MQkSXxRCBYpaGbVSr0xsiX+mPmQuhQqIdaZ3URpiNJB0gCs54PORr8mJh4cVkC+j1OLdH/umnfFYrqtrrX2JPoqHN2BQ4exzbrcDoul8yrd5ZuLqiGQIhNnptzOgp8BmtXZ1zzOjfMWoY3T8QZlYRxLuw1zl4HhxM89J7/PCw+WeOyC42HzFqIPScOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq/xBEiyTfWnQsYmMNg7J8MO9n8bYgkynw59jX99URI=;
 b=WDu3HR2hXGBKMuQNKErGJdvr/TzMkwqpJ9LBXYRpseX8dFTi98syZDEW6+QjHI13PgCmGqVqTMHUvgYs1C0dGqAKpVBUL2DmFtgY+nmIRwcvswxlSb+kDgoIuZfEYhczOvo8tjd3nZWMBS1rgxoU147xT+g3f4mFm2v7elyHmwUKF8eu++BKshFsYIeuBRhJjFCE56/1sJtrk3K/fR+UJBpPfRPpHCDLakFb87m7t/j5e8sTsZox5cI44TJSqakyqyC6ji1uCwaMPhDyBLvqv/hj+KJMKqjDPArshB3MmpHtbAYKAcPBqrfUxYCjAvGUKeCW+9LhB8RO2W90E2Y/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq/xBEiyTfWnQsYmMNg7J8MO9n8bYgkynw59jX99URI=;
 b=hazj4NpFL6VQnOiracaWVOcRrQG5Ht8/prayZidVoYZ5/CbYyml7qhozM9+FB23+dGkZ4sDIkCbEv+Pa2ul0exNoPTjciDLPU1kFA9S8kdLOh2sHZ8w5dOMBK3vnvRlDhqx7TOGH16oZjLHvSGr18c4FHf+3aQRmoMotnxj6m+gjD+95aSq6nWKbA8pQTBWfJJIUDTZIlkd9RJlfLUJMC8LI9DMlKCkan9Ot+60ypmCUm64aDvLOh1k8knawIoMKPeDXsgF9PHRlRW54XlSQo/T1VmK2HWZ/as/d56/FHwJGyL38V5GqOcGIk2xP/IVNJEmT9dgbMa+9m7uje0dpNw==
Received: from OS3PR01MB9659.jpnprd01.prod.outlook.com (2603:1096:604:1e9::7)
 by TYTPR01MB10902.jpnprd01.prod.outlook.com (2603:1096:400:39e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 08:37:54 +0000
Received: from OS3PR01MB9659.jpnprd01.prod.outlook.com
 ([fe80::9458:e2d1:f571:4676]) by OS3PR01MB9659.jpnprd01.prod.outlook.com
 ([fe80::9458:e2d1:f571:4676%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 08:37:54 +0000
From: =?utf-8?B?S09ORE8gS0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?=
	<kazuma-kondo@nec.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
	"mike@mbaynton.com" <mike@mbaynton.com>, "miklos@szeredi.hu"
	<miklos@szeredi.hu>, "amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?S09ORE8gS0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?= <kazuma-kondo@nec.com>
Subject: Re: [PATCH] fs: allow clone_private_mount() for a path on real rootfs
Thread-Topic: [PATCH] fs: allow clone_private_mount() for a path on real
 rootfs
Thread-Index: AQHbxGbDT+OhO7ZF6EeAP0BuuYit07PRazQAgABi9YA=
Date: Wed, 14 May 2025 08:37:54 +0000
Message-ID: <9138a96b-3df0-455a-9059-287a98356c4c@nec.com>
References: <20250514002650.118278-1-kazuma-kondo@nec.com>
 <20250514024342.GL2023217@ZenIV>
In-Reply-To: <20250514024342.GL2023217@ZenIV>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9659:EE_|TYTPR01MB10902:EE_
x-ms-office365-filtering-correlation-id: efd09c4c-a7c7-4edb-11e2-08dd92c29edd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXp1ajJ2dXRzTFpGZVZBK2daRVZkZFA0dEpVRTJoR3c0eitpanpqZUpGRHgz?=
 =?utf-8?B?Zi85QmljbWN4a01lVFRxOHYwT2ZDMUlEZ3Y0LzdtUTJEcW1lYTdwK2hWVzk1?=
 =?utf-8?B?dUhIVWpobzZRUXJaVzI3SmFEbTR2S0FkWHhoNjlCd1FFcnNQdzdFVW9aQ0Ra?=
 =?utf-8?B?N3B1RThlVWZDQml5WVZBYmpxOGc2RWczMTFiY1dXY1graWx6RUlILzZjNE94?=
 =?utf-8?B?OWh2WTRiMERYOGpQT0QzdmZZS3M0K1hOaWtSK3lZc1psYkpWUy9hZFZyRzBN?=
 =?utf-8?B?Z2c2Z2VLNjZkY2hnUVg4ZEg0Um1pVWdacHFKcWdCMUdCSXVtVjIxakNwMUNR?=
 =?utf-8?B?WjFORXQ2bWNmRVh4R2xWdjlYMERUSHhwTmxMS09WRU5WRFVGMERNeFp1Nm1P?=
 =?utf-8?B?bUZCV1Y5ZkpScHZHZ0M3VUFoaXNTVHhnVm1qQlUybG16bXU4YW16WkpQSEVL?=
 =?utf-8?B?dzZyaUhWdlB0VXdtZS8wYXNPQzYvLy9DRXU5eDlxOEpwSFp1amU3RG4zTFZ3?=
 =?utf-8?B?bVk2c1pvQ2dPY0liTXpxd2xJNFpJMjBiNGVKZ2RIQWNYa1BpeTJsM2VLemxX?=
 =?utf-8?B?Y0hUYzZRUDc4OURoSE1kSnA3cWNNR2JUWXJZZ3ljSjl6aGVBTjBCUVZ0QlFI?=
 =?utf-8?B?TWE4WXNyM25ENmJOWmp5aHMwRFJsS0pmazdKUHhXOTExSHMzQ1BTR2d2ZE1z?=
 =?utf-8?B?bWpBY3l0bzVxcGZGSjJKT0ZNWG00bXN6eVd2dzNjSmZTYjFBckVXeHQ4V2NK?=
 =?utf-8?B?SURGZ3dEblN6S0pibWU1MERhRzdMVnhsRG1xZmkvWFo1dmtDL1UycXc3eHdM?=
 =?utf-8?B?aUtQcGE5cUhlOUVBK2krUCsvb1RYY3Zud0Ezai91U1VXSGhsUnpERG13Wjc4?=
 =?utf-8?B?a0MxblhsL1Y1ak4rcFBrcjViVmluTDJzZUgwVEI0THJ0anBGbi9WelUyNDdo?=
 =?utf-8?B?N2RUZE0ra1dISFd4V2ROV3lNTHE5QUdKVHBBUWpIMHRwTy9vTWVXZmhxM2ox?=
 =?utf-8?B?cThJU3AvQkhEZ3oxZk9MRDh3aFBoR29OUU56SWdmWnNZVnZPK3lUVGFEZ2Y0?=
 =?utf-8?B?TlZmUjZ1U2JyT2dtLzJtMmtwenI3eWMvd0l5Z0FRTS9ZWFYzb1JlMHo5Rndx?=
 =?utf-8?B?aG1aZG9takt6eE85cUdnMENScmdBcEorZlloQ2xlMTlMZGk0cWdadWhpV2Nm?=
 =?utf-8?B?NUtBaUNuVkl5eFpuaHJ6M1NaVktCbVVUOUxMNStSWUxSZWRHN3BjdlJ4d0tK?=
 =?utf-8?B?bTl5SUdodUVwdHNTbTExTXRWSmJNQTh5ZGwxYS9KdlVuUVphZXhpTG1mdU5E?=
 =?utf-8?B?a2JDNGt2Mms0MzhhR1UzcWhzR3lyaFpkZFdpSndaUFhzakhEZmNsd3IrTW54?=
 =?utf-8?B?NVR3eGI2Q0JKY1hOZnJjeDFwRytKM05McHhvMUs5UFJVNVJHcGNUOVc4S1ZE?=
 =?utf-8?B?d2ZodzdOMlo0TjN5djBRQkY3aUphdEdTM1d0QUVRd1d3aWhOTUtxbHlnaHJD?=
 =?utf-8?B?OG5zaFVCUWE2aDE3Z01wbU91NHlycmNlcG5KZWRrZTQ5T1k0aC96b2UxZWpq?=
 =?utf-8?B?UkU1S253K0xJSXBmNmZvSFBJSGUrMXQ3dHdqY2I2Y2U3SFZWdElvTFJxY214?=
 =?utf-8?B?RFVoMXgxWGx1MXZxWmJDRkdFWVkvSGdPMWsvQnhpbHgyZVZUWlQvV2NxdTdQ?=
 =?utf-8?B?YVF6UmthS0RiNERmam9WVzlheHRtMjcxWnIzZ2NyYVpIczBjMTA2UWJhMEJ3?=
 =?utf-8?B?RHBUc0Y3WVBRWW8xVXI3YVJybHdWMFZaWmxuTG53KzdtNmN4QkZqOUZLQjkz?=
 =?utf-8?B?cm1wQ3QwTnd6Yy9tVFhCMy9OcTJtRGpPbTFGVFpGUEdEVktVREpZSjNuL1A5?=
 =?utf-8?B?Y1JBYkpmVE9JeVNVV2VyRXVEbnZGYi9WZHRZcUwrcHk0WFdKNmJPT0J5ZE1F?=
 =?utf-8?B?VjBNVGlRUm1IeUtUYmpQMC9BN1ZBYnFVSWt1TytCaGE2RGdCeXZWVFNySWlF?=
 =?utf-8?B?UERweG5yNk1nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9659.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEZqTDJITm5tZm5nSUdZZCtlcXVhVTB0MjlDa3JCdGZ1a2lMTlFqV3FjV2dj?=
 =?utf-8?B?SWg1eUl1Z0lOVTRmRXk4Umxia2NuSlc0VzdISzdEaWY2U0xXQjA1K3hvSFNi?=
 =?utf-8?B?amV1MnBZR0p6WkRQRU1vajdGeVJkWFVxRlhZR0ZpZ1NDVjBEejNNalNYQTJJ?=
 =?utf-8?B?VFdXZjR1UENWN0w1Ujd3UHdNS0FnRitpejFQckxteExGQmZibm9QVUJnQ1FB?=
 =?utf-8?B?dDFNRFl5UlBTVHVVb2ZST0hoVFA4bjMrajVyUjl3RU9FcmFxbUtLL0ZiNTNW?=
 =?utf-8?B?SlZveCtnK3BrVlF2dnBzWkxsWGMzdGZqelRncm1oSWEyR25NWFhwd3Z1TEhj?=
 =?utf-8?B?R1RVblEyV3ZUYmtwMGYyZXlLTmUvNnZmZWFPOS9iRXhCNXZ1MG5wbE8wN0k1?=
 =?utf-8?B?d002aEtNdjZKWVlTa2dPdm9BaE1sZDdzYmFzdTdNTS9ML01RU2wxVUFTalMw?=
 =?utf-8?B?anFLU0RvamdocDdYbUl0M2pBYXBROVRleHhFZ0NiUE5tbkRReXVLQW5sUVlu?=
 =?utf-8?B?TmIyU1c5QzBhMmRkNk5uR2kwRVNWdVIrd0NRWXF2RFc0bUsrbGYyRklBNHVC?=
 =?utf-8?B?WXR4aXQ0ZVVERGFLbEdleVdaNTVzSmU3WDJrNTAvbUIveWVSbEszSm1UWERM?=
 =?utf-8?B?d0k0aTFxVVVsM3htQWppWmVwTWdkNWpueXVyRkdpamhldFF1NldHRStvV2lY?=
 =?utf-8?B?WmtZdEtZOUFzeUsvZllwTkU2OHFDU01hSlUyV2JrMnMwV2V6OWgrY1N5MDV3?=
 =?utf-8?B?b3pTT0pOUENmb1FOV2h6bXhaUmVRZGdKRlRlWjRzdDlaRGhneWIzYUZkUllw?=
 =?utf-8?B?VWN6TkhiSDNLellKQ3JxMUl4ODZGa3Bwb3BSTkVPY3lLamZacUVNWVA2Wk8x?=
 =?utf-8?B?K0lqaXFQaVRidDFlQ0FDYXNWOFowczVCTjc1bFBCZlFRY2dRN0FZQk9BazdW?=
 =?utf-8?B?TWpoVEtrM0UvQWxwcWhYQVZoMGdjS25MYWljZGZlSDVoWm14VGJtd2xxVm5T?=
 =?utf-8?B?S3JyVXJhaHJnRktwUVFnQlNTeGdWUHVWMUJCUFBWbTdmRFY2bStyYnhRaFJv?=
 =?utf-8?B?aDdYcnhicEFMTklMbjJFYXBieEdSZUFRRlJCRkRxb01SejMyOE94Rno2Tmh3?=
 =?utf-8?B?TTJlN3FmaXFkaUVSQVBFN2IvRUF0VFNNam82VUhqOXF6ang0SGN4VWM2ZWlv?=
 =?utf-8?B?MVlFTnJIcDU0M1krUktxMksrWFVjNUMwb3luYWdiTFJEeU10Wm5Qbm82L3VW?=
 =?utf-8?B?czJ2MkVSUHR2Z3lqMDJGMVpiRms3YzFmcStPRWY3ckpnUmtPcFZhWnZkc3Nx?=
 =?utf-8?B?c2hXQVVTNmxlQjhrVHJrMjhYc1NQQkhJUGhpVHZ4K2ZQdkg2NzI5U3RYeDJr?=
 =?utf-8?B?NzBTN0grbnVFRm9zS0R5NWJPSEliejVFUHNqT2dWOG8zb0swUTQyaUZLMjFR?=
 =?utf-8?B?WkFWQnBZSmQzeVE2OWMwVjZuVktid1cvZGlURUJrYVlFQ3RyZWJLSHJYemVh?=
 =?utf-8?B?MTQ2R2pMNlFhc2FnUk5pUkN1UXA5RVIzSEhEdmZZMWVCR004eHRET09xcW85?=
 =?utf-8?B?SDRsM0ZvVVd0dytFUUo4cFFUNEpOelZsN3RoNE9zb0ZkWVMxaWJSS2dwN3BZ?=
 =?utf-8?B?bjl1TEZNaFhueCsxbGw5TnFzWDFZUUErdWorRG5RK2tTRTh0bXgrM2ZLbGVz?=
 =?utf-8?B?VERyeWN3RnAwejNsSHI0WklMWjFaUFlnTUd3b29naEtuK3l2RFdFVTdhZC9V?=
 =?utf-8?B?WXkycjl3NE5ibHRiMk9Ld3VYVlAzbTJYYURvNEsyRWF0V0hZcmlUWFFXdGlT?=
 =?utf-8?B?ems0L0I5U0FqQW9Nd25jWnU4QzhqVm5FdnZjdDZHZDVSK2kybWdPemJtemtS?=
 =?utf-8?B?VDVFNGlDSE5PTWVxZFMyemFsZjd5VUtkWm5IM2RGcFU5UGVrb01PeXh1MUpt?=
 =?utf-8?B?dllOODFjd2tQTG5nVExjSUdiN1hLODZuQnVseVRteCtldHhHNGJ0bUpzTGc4?=
 =?utf-8?B?dnpHRmhYWXNGZWt1YjRHSDBLcmIwd3RqaDk2YUdCS0xpWXZZQUNQN2FoMDIz?=
 =?utf-8?B?YnhlclRyK3FVVkJZamhqcWpUU29idUZjNXJneGFyMTZQUDBjeFMzTURWa1lj?=
 =?utf-8?B?dERnSHZkamx1bXFsSEZqclo5UDhzeGcxZ3ZUWlE2Yjg2cTdJT1pJazF3ZnNy?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F66D9D74D0C43D4CA5C3E519AC80FE35@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9659.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd09c4c-a7c7-4edb-11e2-08dd92c29edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 08:37:54.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJeFYnKqCN6LTA/iMM+sfxEtezcW286+54oKpaFLgTWO6ZcljpfkokmKSsaZv5adQlC/HIktW0XF/w1Dm3pHdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10902

T24gMjAyNS8wNS8xNCAxMTo0MywgQWwgVmlybyB3cm90ZToNCj4gT24gV2VkLCBNYXkgMTQsIDIw
MjUgYXQgMTI6MjU6NThBTSArMDAwMCwgS09ORE8gS0FaVU1BKOi/keiXpCDlkoznnJ8pIHdyb3Rl
Og0KPiANCj4+IEBAIC0yNDgyLDE3ICsyNDgyLDEzIEBAIHN0cnVjdCB2ZnNtb3VudCAqY2xvbmVf
cHJpdmF0ZV9tb3VudChjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCkNCj4+ICAJaWYgKElTX01OVF9V
TkJJTkRBQkxFKG9sZF9tbnQpKQ0KPj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+PiAg
DQo+PiAtCWlmIChtbnRfaGFzX3BhcmVudChvbGRfbW50KSkgew0KPj4gKwlpZiAoIWlzX21vdW50
ZWQoJm9sZF9tbnQtPm1udCkpDQo+PiArCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4+ICsN
Cj4+ICsJaWYgKG1udF9oYXNfcGFyZW50KG9sZF9tbnQpIHx8ICFpc19hbm9uX25zKG9sZF9tbnQt
Pm1udF9ucykpIHsNCj4+ICAJCWlmICghY2hlY2tfbW50KG9sZF9tbnQpKQ0KPj4gIAkJCXJldHVy
biBFUlJfUFRSKC1FSU5WQUwpOw0KPj4gIAl9IGVsc2Ugew0KPj4gLQkJaWYgKCFpc19tb3VudGVk
KCZvbGRfbW50LT5tbnQpKQ0KPj4gLQkJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPj4gLQ0K
Pj4gLQkJLyogTWFrZSBzdXJlIHRoaXMgaXNuJ3Qgc29tZXRoaW5nIHB1cmVseSBrZXJuZWwgaW50
ZXJuYWwuICovDQo+PiAtCQlpZiAoIWlzX2Fub25fbnMob2xkX21udC0+bW50X25zKSkNCj4+IC0J
CQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4+IC0NCj4+ICAJCS8qIE1ha2Ugc3VyZSB3ZSBk
b24ndCBjcmVhdGUgbW91bnQgbmFtZXNwYWNlIGxvb3BzLiAqLw0KPj4gIAkJaWYgKCFjaGVja19m
b3JfbnNmc19tb3VudHMob2xkX21udCkpDQo+PiAgCQkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7
DQo+IA0KPiBOb3QgdGhlIHJpZ2h0IHdheSB0byBkbyB0aGF0LiAgV2hhdCB3ZSB3YW50IGlzDQo+
IA0KPiAJLyogb3VycyBhcmUgYWx3YXlzIGZpbmUgKi8NCj4gCWlmICghY2hlY2tfbW50KG9sZF9t
bnQpKSB7DQo+IAkJLyogdGhleSdkIGJldHRlciBiZSBtb3VudGVkIF9zb21ld2hlcmUgKi8NCj4g
CQlpZiAoIWlzX21vdW50ZWQob2xkX21udCkpDQo+IAkJCXJldHVybiAtRUlOVkFMOw0KPiAJCS8q
IG5vIG90aGVyIHJlYWwgbmFtZXNwYWNlczsgb25seSBhbm9uICovDQo+IAkJaWYgKCFpc19hbm9u
X25zKG9sZF9tbnQtPm1udF9ucykpDQo+IAkJCXJldHVybiAtRUlOVkFMOw0KPiAJCS8qIC4uLiBh
bmQgcm9vdCBvZiB0aGF0IGFub24gKi8NCj4gCQlpZiAobW50X2hhc19wYXJlbnQob2xkX21udCkp
DQo+IAkJCXJldHVybiAtRUlOVkFMOw0KPiAJCS8qIE1ha2Ugc3VyZSB3ZSBkb24ndCBjcmVhdGUg
bW91bnQgbmFtZXNwYWNlIGxvb3BzLiAqLw0KPiAJCWlmICghY2hlY2tfZm9yX25zZnNfbW91bnRz
KG9sZF9tbnQpKQ0KPiAJCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4gCX0NCg0KSGVsbG8g
QWwgVmlybywNCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuDQpUaGF0IGNvZGUgY2FuIHNv
bHZlIG15IHByb2JsZW0sIGFuZCBpdCBzZWVtcyB0byBiZSBiZXR0ZXIhDQoNClNvLCBJIHdpbGwg
cmV2aXNlIG15IHBhdGNoIGFuZCByZXNlbmQgaXQuDQoNClRoYW5rcywNCkthenVtYSBLb25kbw==


Return-Path: <linux-fsdevel+bounces-44124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB7A62E2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3523B9B51
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA651F9A9C;
	Sat, 15 Mar 2025 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MmuEih0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558941E487;
	Sat, 15 Mar 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742049253; cv=fail; b=PdWhVRdKElwWDwPNd4nuPb836feG3WDKzDWjBbLTuUYprfy0EGGxmS5xuuAmzJFHIDdEgaZ/SjRMx51zZZOh9Vj3GDX3wUgTbgKv165m1mDRWqtIODSE4fKwiIhETiupst/CqPAVqMP22wNvVzcmu7BhDX9QJ+KvOtDBoFN3GBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742049253; c=relaxed/simple;
	bh=wD4Z3319HTyd6DBxLsq22/y+VuY3/vwyU3dqsDt3nCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jb3wyNBK8tfVseApAjLhf2aC0rz74xe52WNK3rmpXc7AJQw6ENYmrQzeScNA58EkPD7hxWc6SUmdDm3BYeKRalDEskWWwW4lF6ArDKz0FiRWAENgETjbRXVRonYKsUl7oWPpTTQSHMLsebj8JcMsuD0z7ojjkFE4ug4Y4rsBUaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MmuEih0S; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/A14tOU3rP93s41JAdUNry1PWqwrnZa9bAhnZ4LslEaXOMpwApFb1bxnwAS6fXW8Ox+kYWluCURzPQxoxJE1Ogxy8kSfAXEtVIbyfqxy7jGoSn5/wVWLYyxJwWaCkkyUSH1dGd6nA7ulqCgdU/bzNYUe9hTyLJ4/LLULtqEAKCUVD5nOEvy8pYg+UY7FBE7RC3Qu+e4qRSgQsIxmuUO72VevjYbQK0Lk29KQpivdPSS4wf1JKy3Bcr4GYxOLu0OZVfEFqpd3I8i756BX9XJuRBKDvaVnpGRT9tXOdoROgac7BdMbQ2cbUmUdGAGdDLHJk2NYk7xhr6/TaX8w6A1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD4Z3319HTyd6DBxLsq22/y+VuY3/vwyU3dqsDt3nCs=;
 b=tPnqyVnC2CNs+UC7WrrF+Y7B6bHtNE5KhWzo17+c3NhhwccKR38k1Fb/b+OrbDgSLfKV5CBNSdZWsfSHeh3Me+zYGU3sVanuou7eVjn4AoFZVqEcMIhA8S5NvUZztosDHU3OVbMtzQxRckOevBgrJPPJXEmenlGSIW2Otvy6i+UTyGOXow+Jg0Qrgtqy9Ir51YYq3gq1kt41/givxN5NgOrUkWcSxCgLP3MflDaTHx2cT+dbvCg7zDfab2oC1dX+6G71+FhymBzd3muD411apDeLR0Sb+FtZLrzEbFb+9zuKqLk0cX6PxG4vLCPCrzwDoVBKly97j8OfZ6F/d59PWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD4Z3319HTyd6DBxLsq22/y+VuY3/vwyU3dqsDt3nCs=;
 b=MmuEih0SJCLx6vb1rfPMJ/F2QqbLyf/YqpG/DtZo7fUIPdCOIEboMkVabGFir4GFbtEhTWXxgGPM3bvD9DedQAz/mS8hOsQmZjO47XKdVKb/tFrpZdwA6ayPdWW386SlA1bjOpNdGJobaUpBG29xsyn0JLDMuqXIs6UdKyX7UR09IuciElDdlfsaBpW82p8/T+lVITiP5Ww/L/ABEI8whqCV4/+RiUkwbDZLPnoXRUinlP7IeTdc32+wGsLV0l6YTkNfYpGzhqUE1qxg+F7kgy6RiP1E41bc1mUkBJtP8wEbixA8NUBI0UffXZHiuI4z1CUrKKbCXyJRcXrR+8lLKg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9651.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Sat, 15 Mar
 2025 14:34:05 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8534.025; Sat, 15 Mar 2025
 14:34:05 +0000
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
Thread-Index: AQHblSw8K4t9osLx8E6wFBStbHPjGLNzyCSAgAADGICAAHMIAIAABfw5
Date: Sat, 15 Mar 2025 14:34:05 +0000
Message-ID:
 <PN3PR01MB95972F81CBA433A1AD07816BB8DD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <881481D8-AB70-4286-A5FB-731E5C957137@live.com>
 <D4E1167D-9AF8-4B1D-90FB-20F7507B595C@live.com>
 <uzqxio7wadfe4pb7ehawqmlarxog6w2ljqtgmk7lvxyzefrfko@k327zeywozr3>
In-Reply-To: <uzqxio7wadfe4pb7ehawqmlarxog6w2ljqtgmk7lvxyzefrfko@k327zeywozr3>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9651:EE_
x-ms-office365-filtering-correlation-id: ed12db2e-4e9e-4791-2b51-08dd63ce7023
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|15080799006|8062599003|7092599003|461199028|19110799003|8060799006|102099032|1602099012|10035399004|3412199025|4302099013|440099028|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?RCtpMHZ2emx5dTdobUsyMGo5UVpEZVZhZkJ1bERNVjFxUnlJRnc0OHVNekxn?=
 =?utf-8?B?OUpha3ZkS0pTenY3V1orQnpNYmpZd3RDR25qcGNiZ2wyQ0FqUFZVckpURXZx?=
 =?utf-8?B?RElPc0RFRHQrenRrMXNoZGtyemZybHNMWVRIZzZzbm5XUCtlZEVxSkRCTGUw?=
 =?utf-8?B?SzVnNmlTeDZIc2ZuQTRBUklXUnEyUFMxaDN3NExobU1JTFNCZWN5TE5FV3c4?=
 =?utf-8?B?WDVhckZXbUkxTVNDeHlJN0MrdVBqanJQWmhQYVBqZ0FtY0dPb1pBdDNwaENF?=
 =?utf-8?B?azRyMERJTTUzTC9Rc05IYUZWeFYyNmgwbDR1djhJQ01uNkxXTjdyY1QzYU94?=
 =?utf-8?B?c0hpS3pBZ0lWOVIzTzQ5c3o0MXZXemZFMGtwQ3BLZG5MN0VGdWl3cUJid0NU?=
 =?utf-8?B?YlArVXVYV0JPUnoxZVRFMmQ1eWx5S0dpNzlOcXZSclphblVWdGxGRnFvdjRh?=
 =?utf-8?B?WUE0ekdXWHQ5K1ZJemJCa2NPUHltWVFiOWRkL2szUGQ5amhTUzRscEpSWFZB?=
 =?utf-8?B?Y2ozZitHWHhSOWFxNDd4RE1BWWtOOVhBdHFwenNEY0pyUFhQa3I4eFhhSlJR?=
 =?utf-8?B?TVEybHVoa1JaRi9lNmNZSGZxdnFHcy9La2t5MEtiZGtJQm9GcU9kT2IzZ0JX?=
 =?utf-8?B?RmhOUnhTUUZtUkdXVm54RGZhVWpaSGFKTXRicFpPUjk0OUFicGMyZVZ4Um5h?=
 =?utf-8?B?Y0wrZ1NBL1pzNFJieHZUMEtMZ3JseHBxVWI0Tlh1YVZ1dm9QK1lsR2xwVUly?=
 =?utf-8?B?OUJydXlrNlRnV1IvS1ViTmd6YTAxWjBrYzdwMVNVUG1abkhQSzNyZmhqbVBG?=
 =?utf-8?B?Y0I0WThRVFd4ZzRnUDZ3Ri8zUTNDOStaYXduMG1QMjFCclFoOEhzMEZDa3BZ?=
 =?utf-8?B?WklGeTFVMkNJWkYxaGUyWlRoaENJMlhYbGlldDBDdXg3MkVoWFlKbVRkeThz?=
 =?utf-8?B?SUFOMm5Wb1ROUUF2LzI5SCtPMGVORWZWS0NsaEk3QWVUVTdDcVZHNzNGaXJO?=
 =?utf-8?B?QW5jN3YrOUZzT0RSc1dETTF2QndORVFRalowcjVaQVFIbGcxd21yZmZJSGdx?=
 =?utf-8?B?WW12cGROTHYwUVhMRzVVVW1KSlU4TVhoNkdmbG1VdmVKdDlWME9QcnRkSHVD?=
 =?utf-8?B?VUJzMm9UT0dQcFJ6Kyt6MjJQZytoN0NVVVlPU090a0pVeHlaQkxHODFpWU9N?=
 =?utf-8?B?M3ZUR3RSOVRSTk12WndrSnNIa081TVBJTWNtdHZwTkNJeFMxZjZ0VVUzYlVz?=
 =?utf-8?B?eS90ZUJDa2V0MDFnRGNaMVNJYm1GN1ZpQ0JwTjMveDZRK1JjU0gwZ203OEpF?=
 =?utf-8?B?dk1mTHp3SkVtZDgvUmxvYktITHc5c0gvc2JneFhGdzJSb1k1eHBzLzB3UDFn?=
 =?utf-8?B?YW5KdXVoYnp3K0k3WnYwVGZjSmxISmNacGlvSXdnUXlzU1RZc2lqaUNTZm8x?=
 =?utf-8?B?U1BvNXArdHlQZ3F6UVdReFJLdE9XUlBvTmJnWEFSZEFkOTJsbVpuWWMyZmFi?=
 =?utf-8?B?WHlJd3I4T216V1hHZHRQbEVRc0Y5cEh4OW1PT3M0QzBzUlNzUTBoVjg5bVpx?=
 =?utf-8?B?SS8zTEI3cXVnb3BqNGV6b3NsL044QkVyTFF5aDF5dERJbHp6WTRuZC9Ud2ZR?=
 =?utf-8?B?LzludTlCdVNJSEJQZktkcFpCRzJucDhURVZxVXdLWE1teGJ5L0dNYmlUTmNH?=
 =?utf-8?B?dmo3dlBZT0xDTkk2WURmVkhWeS9BMXdSWGsxTWRUVkRyRllmdEMxZ3BnRXJu?=
 =?utf-8?Q?YK5Lk6bHduFdUyGmH4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SktvWURKT2pQMnhtR3lYTGVFeWF5SllId2VKL2RBeWhFYXFMUzRTT0NHOFFJ?=
 =?utf-8?B?MnU5TFRxZWs5UGFlZE9kYUtlL1BBNFE0TFp4dW1reE1VNWxCRldvUTFkZjhm?=
 =?utf-8?B?SW1kTlBJOEhmKzQrOXN5UzN4N0lUdWRUVGdhUFE2Y0pYR3Y4bkJtbWMwSWJT?=
 =?utf-8?B?NkdLSmorek9xOVNwUFMrK3NibFQyTkg4NkJyTlY1UFgzYUk4bnhqbXBmandj?=
 =?utf-8?B?VEhjdno5b29ZOW1KY0ZlSkdoN2I2K2RISndTQ3JFZU9oUm1nV0ZlbXMvc1FU?=
 =?utf-8?B?c3lwREVCY3BwOU1TL3BwU1A0dk9DcjNtcjZZTHZJN0RUTTdRN2lhVXY3aHky?=
 =?utf-8?B?Z21uUDIzWnhUQmNqVHF1UHRKak9GZDVlSzdJamNVWVFzODVReWtOaWRqTzJB?=
 =?utf-8?B?dGlGVGIzWGNpY3pOQ0JxOCtXUk9UcEFRZzEzaHRQcXpUR2F3dFZtY0JoZEty?=
 =?utf-8?B?bGNFTmo2M01YWlJTQzBFczJvUVFRczBIWVdmaE01WkQvSHBrWmhpVVVReTFs?=
 =?utf-8?B?T1pncElaUlB6Kzk5UWhERU5pSDBHbkxWdndSRjVXWnNrSHllcWxLRW1vYzJB?=
 =?utf-8?B?NWtMWGdtUFppQXBPQmFleVdZendnc3JXdDdzek9IbXRMb2JSQWtNdmlqa1NM?=
 =?utf-8?B?dXRHMnVhREZjYVl1Z2NEV0lsaUczUlM0Q3NPOGhVR2FpZ29LbFptMWJPbDFW?=
 =?utf-8?B?NHFhK3lRaFkvd0lreUNwS0pkRU50VVU5VldnUXB3NEZqTkdIZ1U4YjQwUFl0?=
 =?utf-8?B?VitGSFUyU3Q3bW9NZWN3WUpRMmhERDhBYzhCeG8rZXV1bU05d1ZxRWovN1lP?=
 =?utf-8?B?ZThTVmh3UGcrMFBhV0JNbUJ6MGlVMUlaZ3c4aGs3dGNHSzBqNm1Gb2VJeTM4?=
 =?utf-8?B?MmVlV0xkQ1pSYkl3cDZjZ0JXTjYzV2JldjR2YUMxU28wRDJNR3dhWGxZcGhu?=
 =?utf-8?B?YlUxckxtbjB0d1lUR0xTQUVEK3FQNVk1Qi91TitZM1BpcHNLZVVHYUdMWjVG?=
 =?utf-8?B?MVh5V3VuNEtzOXJkY2hrdlQwSWNXYUhGQWh0ZmEyM0FhWVhRbGdQbjM5WGFI?=
 =?utf-8?B?Z3k4MHV0RTJBbVFTTEJNaFlLQ3lwdk5JNUoraU5JSGlodGd1VTVTclJub0hq?=
 =?utf-8?B?bzFHSkxFYnl3dzAzN1hyTnBzVCtmMEtGbnJyZ3NjQnZLOUV1Ny91cGQ2a005?=
 =?utf-8?B?OWxlcTBKcFF5c0NLbnNGRmw4SWtuRkZNQnB3eGN5VWdmdWxJOFlLZm1nNjBn?=
 =?utf-8?B?TmJhQ1V2WjNBOEk1OGdteFdkdC9obHc3dzJjRG1rdWtBN1k2Y3dva2o4Y0NK?=
 =?utf-8?B?Z1ZuNElxWCtxaFRxZzhEYVpObGp1MGpyVmlDN0tlUHRzenhWbXZmdFpGOVdu?=
 =?utf-8?B?TVpCcG9GaU1haEVucmZpMGtuK25CVVY4Y0pLeFlzUlRWYmdsdnJKY2cvYjla?=
 =?utf-8?B?cGZUaFVvamsxaWpPcWtjdUFRMFFwRWdROVhKYnZaU2k5M3BsRGsvQnIyMmlQ?=
 =?utf-8?B?cFBBbXpZeDg2U0YySW9BbGVqaloxWkNpWWg2Zm5nWGhYaW1xUEc4QnJJUDda?=
 =?utf-8?B?WHowTWhuSFBUUTNzYVZzbEszeGdnZHNORzZuLzZIUmlIczgrOERDZk5BOUsv?=
 =?utf-8?Q?rDy80lGUZGqWnSG6dCfvU5qy+aXX1/iGQXd9NHhpA4Mo=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed12db2e-4e9e-4791-2b51-08dd63ce7023
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 14:34:05.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9651

DQoNCj4gT24gMTUgTWFyIDIwMjUsIGF0IDc6NDLigK9QTSwgRXRoYW4gQ2FydGVyIEVkd2FyZHMg
PGV0aGFuQGV0aGFuY2Vkd2FyZHMuY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIDI1LzAzLzE1IDA3
OjIxQU0sIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gDQo+PiANCj4+Pj4gT24gMTUgTWFyIDIwMjUs
IGF0IDEyOjM54oCvUE0sIEFkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyb3Rl
Og0KPj4+IA0KPj4+IA0KPj4+IA0KPj4+PiBPbiAxNSBNYXIgMjAyNSwgYXQgMzoyN+KAr0FNLCBF
dGhhbiBDYXJ0ZXIgRWR3YXJkcyA8ZXRoYW5AZXRoYW5jZWR3YXJkcy5jb20+IHdyb3RlOg0KPj4+
PiANCj4+Pj4gSGVsbG8gZXZlcnlvbmUsDQo+Pj4+IA0KPj4+PiBUaGlzIGlzIGEgZm9sbG93IHVw
IHBhdGNoc2V0IHRvIHRoZSBkcml2ZXIgSSBzZW50IGFuIGVtYWlsIGFib3V0IGEgZmV3DQo+Pj4+
IHdlZWtzIGFnbyBbMF0uIEkgdW5kZXJzdGFuZCB0aGlzIHBhdGNoc2V0IHdpbGwgcHJvYmFibHkg
Z2V0IHJlamVjdGVkLA0KPj4+PiBidXQgSSB3YW50ZWQgdG8gcmVwb3J0IG9uIHdoYXQgSSBoYXZl
IGRvbmUgdGh1cyBmYXIuIEkgaGF2ZSBnb3QgdGhlDQo+Pj4+IHVwc3RyZWFtIG1vZHVsZSBpbXBv
cnRlZCBhbmQgYnVpbGRpbmcsIGFuZCBpdCBwYXNzZXMgc29tZSBiYXNpYyB0ZXN0cw0KPj4+PiBz
byBmYXIgKEkgaGF2ZSBub3QgdHJpZWQgZ2V0dGluZyBYRlMvRlN0ZXN0cyBydW5uaW5nIHlldCku
DQo+Pj4+IA0KPj4+PiBMaWtlIG1lbnRpb25lZCBlYXJsaWVyLCBzb21lIG9mIHRoZSBmaWxlcyBo
YXZlIGJlZW4gbW92ZWQgdG8gZm9saW9zLCBidXQNCj4+Pj4gYSBsYXJnZSBtYWpvcml0eSBvZiB0
aGVtIHN0aWxsIHVzZSBidWZmZXJoZWFkcy4gSSB3b3VsZCBsaWtlIHRvIGhhdmUNCj4+Pj4gdGhl
bSBjb21wbGV0ZWx5IHJlbW92ZWQgYmVmb3JlIG1vdmVkIGZyb20gc3RhZ2luZy8gaW50byBmcy8u
DQo+Pj4+IA0KPj4+PiBJIGhhdmUgc3BsaXQgZXZlcnl0aGluZyB1cCBpbnRvIHNlcGFyYXRlIGNv
bW1pdHMgYXMgYmVzdCBhcyBJIGNvdWxkLg0KPj4+PiBNb3N0IG9mIHRoZSBDIGZpbGVzIHJlbHkg
aW4gZnVuY3Rpb25zIGZyb20gb3RoZXIgQyBmaWxlcywgc28gSSBpbmNsdWRlZA0KPj4+PiB0aGVt
IGFsbCBpbiBvbmUgcGF0Y2gvY29tbWl0Lg0KPj4+PiANCj4+Pj4gSSBhbSBjdXJpb3VzIHRvIGhl
YXIgZXZlcnlvbmUncyB0aG91Z2h0cyBvbiB0aGlzIGFuZCB0byBzdGFydCBnZXR0aW5nDQo+Pj4+
IHRoZSBiYWxsIHJvbGxpbmcgZm9yIHRoZSBjb2RlLXJldmlldyBwcm9jZXNzLiBQbGVhc2UgZmVl
bCBmcmVlIHRvDQo+Pj4+IGluY2x1ZGUvQ0MgYW55b25lIHdobyBtYXkgYmUgaW50ZXJlc3RlZCBp
biB0aGlzIGRyaXZlci90aGUgcmV2aWV3DQo+Pj4+IHByb2Nlc3MuIEkgaGF2ZSBpbmNsdWRlZCBh
IGZldyBwZW9wbGUsIGJ1dCBoYXZlIGNlcnRhaW5seSBtaXNzZWQgb3RoZXJzLg0KPj4+PiANCj4+
Pj4gWzBdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjUwMzA3MTY1MDU0LkdBOTc3
NEBlYWYvDQo+Pj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFdGhhbiBDYXJ0ZXIgRWR3YXJkcyA8
ZXRoYW5AZXRoYW5jZWR3YXJkcy5jb20+DQo+Pj4gDQo+Pj4gV2h5IGhhc27igJl0IEVybmVzdG8g
c2lnbmVkLW9mZiBoZXJlLCBvciBpbiBhbnkgcGF0Y2g/IEFGQUlLLCBoZSBpcyB0aGUgYXV0aG9y
IG9mIHRoZSBkcml2ZXIuDQo+PiANCj4+IEkgY2FuIGFsc28gc2VlIHlvdXIgQ29weXJpZ2h0IGF0
IHNvbWUgcGxhY2VzLCB3aGljaCBJIGRpZG4ndCBmaW5kIGluIHRoZSB1cHN0cmVhbSByZXBvLiBE
aWQgeW91IGFkZCBzb21lIGNvZGUgY2hhbmdlPw0KPiANCj4gWWVzLCB0aGVyZSB3ZXJlIHNvbWUg
c2xpZ2h0IHJlZmFjdG9ycyBpbiBzb21lIGZpbGVzIHRvIGdldCB0aGUgY29kZQ0KPiBjb21waWxp
bmcuIEkgb25seSBhZGRlZCBteSBjb3B5cmlnaHQgaW4gZmlsZXMgd2hlcmUgSSBjaGFuZ2VkIHRo
aW5ncy4gSQ0KPiBjYW4gcmVtb3ZlIHRoZW0uIEkgd2FzIG5vdCBzdXJlIHdoYXQgdG8gZG8uDQo+
IA0KPj4gDQo+PiBJTU8sIGlmIHlvdSBhcmUganVzdCBtYWludGFpbmluZyBpdCwgZG9lc24ndCBt
ZWFuIHlvdSBhZGQgeW91ciBjb3B5cmlnaHQuIEVnOiBJIG1haW50YWluIHRoZSBhcHBsZXRiZHJt
IGRyaXZlciwgYnV0IEkgZGlkbid0IHdyaXRlIG9yIGFkZCBhbnl0aGluZyBzcGVjaWFsIGluIGl0
LCBzbyBpdCBkb2VzbuKAmXQgaGF2ZSBteSBjb3B5cmlnaHQuDQo+IA0KPiBTdXJlLiBUaGF0IGlz
IGxvZ2ljYWwuIEknbGwgcmVtb3ZlIHRoZW0gaW4gdGhlIG5leHQgc2VyaWVzLg0KPiANCj4+IA0K
Pj4gQWxzbywgZGlkIHlvdSBhc2sgRXJuZXN0byB3aGV0aGVyIGhlIHdhbnRzIHRvIGJlIGEgY28g
bWFpbnRhaW5lcj8NCj4+IA0KPiANCj4gS2luZGE/IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1h
cGZzL2xpbnV4LWFwZnMtcncvaXNzdWVzLzY4I2lzc3VlY29tbWVudC0yNjA4NDAwMjcxDQo+IFNl
ZSB0aGF0IGxpbmsuIEkgZGlkIG5vdCByZWFsbHkgZ2V0IGFuIGFuc3dlciwgc28gSSBkZWNpZGVk
IHRvIHN0YXJ0IHRoZQ0KPiBwcm9jZXNzIGFueXdheXMuIElmIGhlIGRvZXMgbm90IHdhbnQgdG8g
Y28tbWFpbnRhaW4sIEkgY29tcGxldGVseQ0KPiB1bmRlcnN0YW5kLiBJIGRvbid0IHdhbnQgdG8g
YXNzdW1lIGhlIGlzIHdpbGxpbmcgdG8uIFVsdGltYXRlbHksIGl0IGlzDQo+IHVwIHRvIGhpbS4N
Cg0KSSBzZWUgdGhhdCBFcm5lc3RvIHNpZ25zIGFsbCBoaXMgY29tbWl0cywgZ2l2aW5nIHlvdSBs
ZWdhbGx5IGFuIG9wdGlvbiB0byBzaWduIG9mZiB0aGUgc2VyaWVzIG9uIGhpcyBiZWhhbGYuIEFs
c28sIHRoZSByZXBvc2l0b3J5IHRoYXQgR1BMMiBsaWNlbnNlLCBtYWtpbmcgdGhpbmdzIG1vcmUg
ZWFzaWVyLiBCdXQgZXRoaWNhbGx5LCBJIHdvdWxkIHByZWZlciB0byBoYXZlIGFuIGFjayBvciBn
byBhaGVhZCBmcm9tIGVybmVzdG8gaWYgcG9zc2libGUuIEkgbXlzZWxmIGhhdmUgYmVlbiBpbiBz
aXR1YXRpb25zIHdoZXJlIHBlb3BsZSB3cml0ZSBhIGRyaXZlciwgYW5kIGRpc2FwcGVhci4gVGhl
aXIgc2lnbiBvZmYgb24gdGhhdCBkcml2ZXIgY29tbWl0cyBhbmQgR1BMMiBsaWNlbnNlIGlzIHdo
YXQgbWFrZXMgdGhpbmdzIGxlZ2FsIHRoZW4uDQoNClNvIGluIGEgbnV0c2hlbGwsIGFsbCBjb21t
aXRzIHNob3VsZCBoYXZlIGEgc2lnbmVkLW9mZi1ieSBmcm9tIGVybmVzdG8sIGVzcGVjaWFsbHkg
d2hlbiBoZSBpcyBzaWduaW5nIHRoZSBjb21taXRzIGluIHRoZSBHaXRIdWIgcmVwb3NpdG9yeS4g
QW5kIGFuIGFjayBmcm9tIGhpbSBvbiBMS01MIHdvdWxkIGJlIGFwcHJlY2lhdGVkLg0KDQpQLlMu
IHRoaXMgaXMgbXkgaW50ZXJwcmV0YXRpb24gb2YgYWxsIHRoZSBsZWdhbCBzdHVmZiBhbmQgaXMg
Zm9sbG93ZWQgYnkgbWUgb24gTGludXgsIGFmdGVyIGFsbCB0aGVyZSBpcyBubyBjbGVhciBkb2N1
bWVudGF0aW9uIEkgaGF2ZSBlbmNvdW50ZXJlZCBpbiBzdWNoIGNhc2VzLCBidXQgdGhlIG1haW4g
dGFrZSBkZXBlbmRzIG9uIHRoZSB1cHN0cmVhbSBtYWludGFpbmVycy4NCg==


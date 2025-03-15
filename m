Return-Path: <linux-fsdevel+bounces-44125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860A0A62E3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455BD179D9E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425D2036F0;
	Sat, 15 Mar 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="N7q/l1Cq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010013.outbound.protection.outlook.com [52.103.68.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9BF202F8E;
	Sat, 15 Mar 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742049344; cv=fail; b=TpslbZa9xog4c8OIc/OhUwJ8xSQxXl0KLEN8wtHxXsFEdFc4aEJEbRdCSyOT9nTI5Db1M37qIRcLrVBH+zRJzTwv41TLBt2yb+xc++feOA+cPUPtZzmUNS59EJfhQsSGKImOET50W82hDykr8nx2ZnstFnL5slj7+sYegrqyLpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742049344; c=relaxed/simple;
	bh=S7HnThOpOZGT2ZC7I5IumboFwoObPRRXVZHQKXkBFJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PMCZE4fS1uvYsI/aW3553kJRmBo4Chm1v4qfCTd/DIORxYabJk/d3fcY3vHjkNrKdRDFn3TRN+Y04D6nscAdoCqArdD3mIeKcVEOu7hnFXjCI9vh3mV78AnlHqhRRwUEQ0+ZqKgNqnz7sMTvUaMn3FbeVv+Tkdim25GI/UqygK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=N7q/l1Cq; arc=fail smtp.client-ip=52.103.68.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjsRrJHFOA89ys5rAl3Spno3yZRB2O+BtJOw2j96LOau2Wn+vpK1kNvx696dDQHHuJYxe3fZYj2QA+wlgrhlwgR1yzLW8hNbyV+tQ2EY5V7EE626zheDbDVPDCSyhdUq8ot2xIi4VhRyfmomDDokofeNf83w1uRO6JooEhz9+EvLoBm5SOHyPAq5Xk6mZkuxzPD2lh202IXvA04aVqtZgAaC1bxSA5kr42XXxcGtRkrdSPSNSOok7d4RhQZX9B0sY21Fs5ZLQ3N/6XvhoIEy5SgCNWMKUa/3cK6s6nw4HsZzjuRa1jzjeDlyYXJgMhTnzb3pyVP+AJQlEq7V6rwpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7HnThOpOZGT2ZC7I5IumboFwoObPRRXVZHQKXkBFJ4=;
 b=sKmzdFmV/aOCfNZX5moFyABRPnE2BsdELlnjTx9U6UEK67HKR4uqr22MtWr1I8kDGdu3+cXGkP3YhqypMt51Hu2FHGrhE7me/pa5BW2k2LiyDmo0KluFqS4IiOrw6ziyWtDGeY9B4uwQwm1BxaukND9LPvLYg1avXFMlcS6Czb6ZwxVeb+ZiPVbAbaLAZk2dDGRP21VpmIIj1tlng7lZbMXUqPJLY+qVK2a25X9vl0FFP9OdHNsrmh3dJLELDwD3A8wOEQsWb0qfqxa0Fk+dMnhatWe19QDsLFdodgJ7XicyFcki0ew/VgSSqMjV3ssiH+jDSgejQCOk6v0VG9RoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7HnThOpOZGT2ZC7I5IumboFwoObPRRXVZHQKXkBFJ4=;
 b=N7q/l1CqvPE/kstFD85+DNL7horCO8iB7Cn/zmYNJc7ewHTGCHrYVNYcY510LIQWHyrflOWnRVJ8VZQpmVsFdmTS3nhYXXmJ/0XKQcc/SWvG9EgHX2hbmNbH3b7YRFroNBH3dYcW+n9qoryv01vUNintiKiq3KaQog5WMXkwjiJ2gIqhnI3VRsCaa7mfZdBawR8aieSsGEcbY7Qu3HIWAZL5yN4OVVqBo8nEStTmDrA16hNARC6xJZnzJGp3yaoZWiGtC5CqfwOBGjDW3p+J4xYSA8d4DSkxyKXSh3UwBfRmPI66WZmNucO/ykJHcAFdd//MfrQvrWoVyeVyKBokVw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9651.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Sat, 15 Mar
 2025 14:35:35 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8534.025; Sat, 15 Mar 2025
 14:35:35 +0000
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
Thread-Index: AQHblSw8K4t9osLx8E6wFBStbHPjGLNzyCSAgAADGICAAHMIAIAABmgj
Date: Sat, 15 Mar 2025 14:35:35 +0000
Message-ID:
 <PN3PR01MB95977D6D5FE261F382F8F314B8DD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
x-ms-office365-filtering-correlation-id: 9818cc46-5899-407a-e33d-08dd63cea5db
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|6072599003|15080799006|8062599003|7092599003|461199028|19110799003|8060799006|102099032|1602099012|10035399004|3412199025|4302099013|440099028|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnJlalg5WXUyMjVLbXJsbVMxa0RlSzFqZWlyQS9aY2RISEhuSTZLTEZkR0t3?=
 =?utf-8?B?N2gwbkozeCtYcEwyL2hWZjk5R3RjMnpROXdoUjduRUhqM2VHV2VuVjREdWNq?=
 =?utf-8?B?MXZaYWd6a0h4QWR0Mm54azBhN09xQWhZNWtvcnZoUDdEcTdzam1DZHZyUjRi?=
 =?utf-8?B?UXFoNnQ1ZzVCZEVvRGdZUC85bGhFcHJwUTB1QnJWSXRMellsMGpwNy84QTB1?=
 =?utf-8?B?Uy9yQU01Q3V2THVzV2ErUVMzY0VNYmJRZHZoMmwrSEs1bkFra3M5MHcyQWMx?=
 =?utf-8?B?RHdOZFAxQjVlUHlpTkZoQWpjY1lrZ0piVWRIVnlYZWdhOHRwVU9sU2dtNGQy?=
 =?utf-8?B?c0c4R1BsS3FOSzhBTm9oL0UrUjAvUDBLbTEwMDRidGhSMWxNVEhZazJobjhp?=
 =?utf-8?B?U29wK01HUWJBQmxZVVlFcmc4dEFiVUlldkN5OHp2ZXgwaXZ2WS94SUJKYnVP?=
 =?utf-8?B?ZzFpVExiSkFRdGd2Z204RnpHenUvd3lmZWwzY2UzVTJWcmxBWERHUmpucTF5?=
 =?utf-8?B?TDBockQ1OEQ5QmZhMHp2dllUbW9mWlJJWTJUQ3B0NTNDQjl4eXpFTFZZdzNW?=
 =?utf-8?B?b1BKMmEvUFJFcDRZeFdKWTU4bDJUOXdsakx6ZEpkcFBqVUtxT2Q5VjloNDlU?=
 =?utf-8?B?M01zL1E2ZWY4YzhRK2tPM1VpQnloMWN0NUVJNnY5MzVsWHU4bmtWSFk3cWRr?=
 =?utf-8?B?NUE3QW54WXZIU3JIT0QwWUxNVDA3TllCYk8vSkt4eHE4a25OcElnUXBvSjVJ?=
 =?utf-8?B?aVBhVkNtVWo1THREdEJ0QTJzRG5GVUJSdG1RcEtzMEZ3cDdHR1M5b0EwZWpJ?=
 =?utf-8?B?dmVzREFrZHdqUC92SG5vZ3Z5U2JzUmduMjJxUERVWm9lbmMrWWhFZ0FUZ2w3?=
 =?utf-8?B?U3hRV0xhUXJuQ0gvL25XaWVtWFVxeXdhU0NiMXE1L2wwYXBWOE50ODAxOXB3?=
 =?utf-8?B?a0lUV0pvNTFpcGdXMDBMT0w3dXhXYnNBVmtwZ1c0b2plM3lRR2sra3BHbWtt?=
 =?utf-8?B?V01PY1lsOUZXMGQ3c2xhUHNuelR5ZVVpWjBxOUZaL2dpclpleVNybEl4ZVpn?=
 =?utf-8?B?WXdabUY5Y1B3OVFyUkl1dFdGK0hwcldMMmNPTkk1U2Z4YVFDRWE2RXRUdVB2?=
 =?utf-8?B?UXN1UnY0SDMrRG96NGJmTFUvbklqZVVRaktMdmMxVlZlUEZISlAxa2JZMU11?=
 =?utf-8?B?WGVBSXora05EeGUrQUUwYkl1WXp0amtHODJOVmUrZEZhemNOeGlrdFZZRnk0?=
 =?utf-8?B?M2JsMTNBeHBKSkMwMkRzbWJIMjdnUTZ6VEc3emcrNVdNdW1BTUtLWmtUYlJD?=
 =?utf-8?B?NHlJemF2S0VnMzgwSDEzVlF5c1FBWjFacGdLekVPRUlHdnlIT2pDS3lmL2R3?=
 =?utf-8?B?OXJpOFRIK0pzUUFvelI4dmpFUU45cjEvZlozbXk0ZE9GM3N6Q3c2VFdvU0Fv?=
 =?utf-8?B?ckJxRFRGa2tBZHJKTDFNQ1VaajNUdzhZbDFpdU10c0xad3ZPREh2M1VyVE4y?=
 =?utf-8?B?R1VKT0p4K2s4Rm50VjVIc25lV29jQmo0M1M4UnJwK1BSTkFNVFFhWDNrSlFk?=
 =?utf-8?B?dlVKU2dSUi9xSjA3bDgyVEZLV2pBODExeWhBaWN3ZzlCTjFhSUNTNWV4ZlJZ?=
 =?utf-8?B?MDNkWDhGM0s0OEI4QVZjLzBYOTFMYlZmazM4UThmdEovMnY5NDQ0enZKd3ZQ?=
 =?utf-8?B?Z215aDNYTFp6UkZobUxhVlBCMjA2cGtSSlR0V1NYbk1FOGxJOFNYTUlMTWV0?=
 =?utf-8?Q?wkgh7rF1ANpvr2rgfD4tloCTVkOc8heljoTZx6y?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkREME1uWlp0ZmZISEtiOUh6ZVNUTW1XUi8wZ0RvTFFrclNpMnk1cmdpSyti?=
 =?utf-8?B?TU5wWlNXckk2Vm5ULzVQV2hSdnVndFlzbEZKN3RWQjNsUGdVYnRrdjBYZ3Zt?=
 =?utf-8?B?NTAreWFHYzZNdWFLUHFkOUpzdUduNUFPbnlxQVoyUk56VUpZYWhaRHRVMDZn?=
 =?utf-8?B?YzJGb3pYNGZVai9EUGEybGt4MUkwL3MvdGI4NW5qWlFPUWM5S0p6bC9DRjVJ?=
 =?utf-8?B?RklxQ0taemJWbE1kRXdENTRxbFBaNUVqeVN1WnMvMHNnUlBabnVUN1RFM3N1?=
 =?utf-8?B?OGRlU1NYbldIRHBtN0RLUXh3bU81T0QrQUxwUG5LbnA1S0JwMUcrV2h0MzA4?=
 =?utf-8?B?a21GNU13S1FaektmQjNTbmJwSUdoVnlTdGJuQXBmOEJKMWZpWkNpWEJ4bXpq?=
 =?utf-8?B?Z1crOWlsUnNLYUVSbVF5MEU2akhCWkQ2ZTVyUk4zVXQ2T3hyb3NsUFd6dDN5?=
 =?utf-8?B?TjZlTnNtQWl2NjBOUmdpRFlXTlNDQmNGRWg1QlN1YWRSTzhMUmc0Y0ZQaWFY?=
 =?utf-8?B?YUNhcVk4algrV2tHK1YxMzg1SXhVdnlvZXpacVBTTE1ZUHh0c0swbmd2dkZ2?=
 =?utf-8?B?bXBNa3lraHE2eGFGNFVLeitOTmpsVk5pOEU1dGtVOWMyaHdCWkdSYng0aDV5?=
 =?utf-8?B?ajBjcXBFVmwzWnlLdHZDOU92WVRGRTZQSzcyc2ZpMEtjcnNMRXFvOEYwSHZt?=
 =?utf-8?B?MHhzTzNPOHFuK2thckdHaXl5MjA0MXUwVG40K2dpbHV3MVRKYXJla1FycHp1?=
 =?utf-8?B?cGxnWTZQMGEyNHNOU2lrYjFncEZPZ0xReG9XMnlaRWZGb1FCa3ZZcGptckNn?=
 =?utf-8?B?cldkQyt0dXZiYm5naklyd0NMY2F5d21IZy9VQzM5ZGFXdUNxa2hHTEVTRTN2?=
 =?utf-8?B?REw0NGVYYjVCTW5UTEtacXNuTTlPWnJJTkVOcE91cDdzV1EvaGtCclJ5UGkw?=
 =?utf-8?B?YUJQYURRMmw5NmRBYmN1ZG5JZlZjdTM2YWpNaDNnQU0xUkIyd1VFS3VySGFX?=
 =?utf-8?B?WXplKzFGV2tpVGZoeSs2RFJJc0krcUdSRzBZa3VZTzhPVWo0L2x2M28yTDhE?=
 =?utf-8?B?dVpESFZtNFVCeEk1SkNSaFJRY0NiLy9FaWYrQ3BxcXBDZkJKTm1CNFRjdVhI?=
 =?utf-8?B?bmdDL3BXSEcrVE11Q0I2T1Fhb3I5U2xSdkN1UzFnUE15SUlvNnEzLzhSTkRq?=
 =?utf-8?B?UzRBaVNReEw4TmhKbWNxWjF1S1JEc2xGZ1JEeFd1bnZPM0RKL1NEQjJhUVNT?=
 =?utf-8?B?ZkNSaFhhUkFjbkQrblo4cE5ma0ZCNm9tRng3Tkt1NDJDMk1XcENWN3hxTk5O?=
 =?utf-8?B?ZVNha1dNVEo3VEhpK3VINCsxUmQwMVZycEhNdnFRbUh6UG9OaHpRTjJ0YWF4?=
 =?utf-8?B?alg4a1pxMktVMlBGWlowaWNkMm5LWnFCRTVJVExJT2hkSlV5K1lTdGtKZ0Vl?=
 =?utf-8?B?ZEhDUm5kZkhVN28vWmF6dERvTlJmTmxEeVNQaWUwN1AxZStnMXREQXRVU0Nj?=
 =?utf-8?B?YjB4L2NJQTZvN3JMZ1E0dm9WcjFmU3ZlT0FIa20vSVFFR3hOWDBpQ1JPaStI?=
 =?utf-8?B?dHh6aHhoWlJCcjNzQTN3SmphekcvMUlibXNEK1ZVWEkzSlFIZCthcmZ4YXc3?=
 =?utf-8?B?M2lOTytoajlSQTU2TkkzVlRDWW5LZVdBaC9wa0hXdVFBa25GMy80NkJ5VWt3?=
 =?utf-8?B?ZGFCMW91b2JzVzB1ODRWem92aUszTjR5OTJKSVJvODBNanJrVmw1WGl5QTVT?=
 =?utf-8?Q?KpnTTxspv3M549WAfw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9818cc46-5899-407a-e33d-08dd63cea5db
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 14:35:35.3503
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
aW5ncy4gSQ0KPiBjYW4gcmVtb3ZlIHRoZW0uIEkgd2FzIG5vdCBzdXJlIHdoYXQgdG8gZG8uDQoN
CkJ5IHRoaXMgbG9naWMsIGV2ZXJ5IGNvbnRyaWJ1dG9yIHRvIHRoZSBMaW51eCBrZXJuZWwgc2hv
dWxkIGhhdmUgdGhlaXIgY29weXJpZ2h0IG9uIHRoYXQgZHJpdmVyIDopDQo+IA0KPj4gDQo+PiBJ
TU8sIGlmIHlvdSBhcmUganVzdCBtYWludGFpbmluZyBpdCwgZG9lc24ndCBtZWFuIHlvdSBhZGQg
eW91ciBjb3B5cmlnaHQuIEVnOiBJIG1haW50YWluIHRoZSBhcHBsZXRiZHJtIGRyaXZlciwgYnV0
IEkgZGlkbid0IHdyaXRlIG9yIGFkZCBhbnl0aGluZyBzcGVjaWFsIGluIGl0LCBzbyBpdCBkb2Vz
buKAmXQgaGF2ZSBteSBjb3B5cmlnaHQuDQo+IA0KPiBTdXJlLiBUaGF0IGlzIGxvZ2ljYWwuIEkn
bGwgcmVtb3ZlIHRoZW0gaW4gdGhlIG5leHQgc2VyaWVzLg0KPiANCj4+IA0KPj4gQWxzbywgZGlk
IHlvdSBhc2sgRXJuZXN0byB3aGV0aGVyIGhlIHdhbnRzIHRvIGJlIGEgY28gbWFpbnRhaW5lcj8N
Cj4+IA0KPiANCj4gS2luZGE/IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1hcGZzL2xpbnV4LWFw
ZnMtcncvaXNzdWVzLzY4I2lzc3VlY29tbWVudC0yNjA4NDAwMjcxDQo+IFNlZSB0aGF0IGxpbmsu
IEkgZGlkIG5vdCByZWFsbHkgZ2V0IGFuIGFuc3dlciwgc28gSSBkZWNpZGVkIHRvIHN0YXJ0IHRo
ZQ0KPiBwcm9jZXNzIGFueXdheXMuIElmIGhlIGRvZXMgbm90IHdhbnQgdG8gY28tbWFpbnRhaW4s
IEkgY29tcGxldGVseQ0KPiB1bmRlcnN0YW5kLiBJIGRvbid0IHdhbnQgdG8gYXNzdW1lIGhlIGlz
IHdpbGxpbmcgdG8uIFVsdGltYXRlbHksIGl0IGlzDQo+IHVwIHRvIGhpbS4NCj4gDQo+IFRoYW5r
cywNCj4gRXRoYW4NCj4gDQo+Pj4+IC0tLQ0KPj4+PiBFdGhhbiBDYXJ0ZXIgRWR3YXJkcyAoOCk6
DQo+Pj4+ICAgc3RhZ2luZzogYXBmczogaW5pdCBsemZzZSBjb21wcmVzc2lvbiBsaWJyYXJ5IGZv
ciBBUEZTDQo+Pj4+ICAgc3RhZ2luZzogYXBmczogaW5pdCB1bmljb2RlLntjLGh9DQo+Pj4+ICAg
c3RhZ2luZzogYXBmczogaW5pdCBhcGZzX3Jhdy5oIHRvIGhhbmRsZSBvbi1kaXNrIHN0cnVjdHVy
ZXMNCj4+Pj4gICBzdGFnaW5nOiBhcGZzOiBpbml0IGxpYnpiaXRtYXAue2MsaH0gZm9yIGRlY29t
cHJlc3Npb24NCj4+Pj4gICBzdGFnaW5nOiBhcGZzOiBpbml0IEFQRlMNCj4+Pj4gICBzdGFnaW5n
OiBhcGZzOiBpbml0IGJ1aWxkIHN1cHBvcnQgZm9yIEFQRlMNCj4+Pj4gICBzdGFnaW5nOiBhcGZz
OiBpbml0IFRPRE8gYW5kIFJFQURNRS5yc3QNCj4+Pj4gICBNQUlOVEFJTkVSUzogYXBmczogYWRk
IGVudHJ5IGFuZCByZWxldmFudCBpbmZvcm1hdGlvbg0KPj4+PiANCj4+Pj4gTUFJTlRBSU5FUlMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNiArDQo+Pj4+IGRyaXZl
cnMvc3RhZ2luZy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPj4+
PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAgIDEz
ICsNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAg
IHwgICAxMCArDQo+Pj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL1JFQURNRS5yc3QgICAgICAgICAg
ICAgICAgICB8ICAgODcgKw0KPj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9UT0RPICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICA3ICsNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvYXBmcy5o
ICAgICAgICAgICAgICAgICAgICAgIHwgMTE5MyArKysrKysrKw0KPj4+PiBkcml2ZXJzL3N0YWdp
bmcvYXBmcy9hcGZzX3Jhdy5oICAgICAgICAgICAgICAgICAgfCAxNTY3ICsrKysrKysrKysrDQo+
Pj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2J0cmVlLmMgICAgICAgICAgICAgICAgICAgICB8IDEx
NzQgKysrKysrKysNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvY29tcHJlc3MuYyAgICAgICAg
ICAgICAgICAgIHwgIDQ0MiArKysNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvZGlyLmMgICAg
ICAgICAgICAgICAgICAgICAgIHwgMTQ0MCArKysrKysrKysrDQo+Pj4+IGRyaXZlcnMvc3RhZ2lu
Zy9hcGZzL2V4dGVudHMuYyAgICAgICAgICAgICAgICAgICB8IDIzNzEgKysrKysrKysrKysrKysr
Kw0KPj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAg
fCAgMTY0ICsrDQo+Pj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2lub2RlLmMgICAgICAgICAgICAg
ICAgICAgICB8IDIyMzUgKysrKysrKysrKysrKysrDQo+Pj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZz
L2tleS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAzMzcgKysrDQo+Pj4+IGRyaXZlcnMvc3Rh
Z2luZy9hcGZzL2xpYnpiaXRtYXAuYyAgICAgICAgICAgICAgICB8ICA0NDIgKysrDQo+Pj4+IGRy
aXZlcnMvc3RhZ2luZy9hcGZzL2xpYnpiaXRtYXAuaCAgICAgICAgICAgICAgICB8ICAgMzEgKw0K
Pj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9semZzZS9semZzZS5oICAgICAgICAgICAgICAgfCAg
MTM2ICsNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHpmc2VfZGVjb2RlLmMgICAg
ICAgIHwgICA3NCArDQo+Pj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNlL2x6ZnNlX2RlY29k
ZV9iYXNlLmMgICB8ICA2NTIgKysrKysNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2Uv
bHpmc2VfZW5jb2RlLmMgICAgICAgIHwgIDE2MyArKw0KPj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBm
cy9semZzZS9semZzZV9lbmNvZGVfYmFzZS5jICAgfCAgODI2ICsrKysrKw0KPj4+PiBkcml2ZXJz
L3N0YWdpbmcvYXBmcy9semZzZS9semZzZV9lbmNvZGVfdGFibGVzLmggfCAgMjE4ICsrDQo+Pj4+
IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNlL2x6ZnNlX2ZzZS5jICAgICAgICAgICB8ICAyMTcg
KysNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHpmc2VfZnNlLmggICAgICAgICAg
IHwgIDYwNiArKysrKw0KPj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9semZzZS9semZzZV9pbnRl
cm5hbC5oICAgICAgfCAgNjEyICsrKysrDQo+Pj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNl
L2x6ZnNlX21haW4uYyAgICAgICAgICB8ICAzMzYgKysrDQo+Pj4+IGRyaXZlcnMvc3RhZ2luZy9h
cGZzL2x6ZnNlL2x6ZnNlX3R1bmFibGVzLmggICAgICB8ICAgNjAgKw0KPj4+PiBkcml2ZXJzL3N0
YWdpbmcvYXBmcy9semZzZS9senZuX2RlY29kZV9iYXNlLmMgICAgfCAgNzIxICsrKysrDQo+Pj4+
IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNlL2x6dm5fZGVjb2RlX2Jhc2UuaCAgICB8ICAgNjgg
Kw0KPj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9semZzZS9senZuX2VuY29kZV9iYXNlLmMgICAg
fCAgNTkzICsrKysNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHp2bl9lbmNvZGVf
YmFzZS5oICAgIHwgIDExNiArDQo+Pj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL21lc3NhZ2UuYyAg
ICAgICAgICAgICAgICAgICB8ICAgMjkgKw0KPj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9uYW1l
aS5jICAgICAgICAgICAgICAgICAgICAgfCAgMTMzICsNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2Fw
ZnMvbm9kZS5jICAgICAgICAgICAgICAgICAgICAgIHwgMjA2OSArKysrKysrKysrKysrKw0KPj4+
PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9vYmplY3QuYyAgICAgICAgICAgICAgICAgICAgfCAgMzE1
ICsrKw0KPj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9zbmFwc2hvdC5jICAgICAgICAgICAgICAg
ICAgfCAgNjg0ICsrKysrDQo+Pj4+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL3NwYWNlbWFuLmMgICAg
ICAgICAgICAgICAgICB8IDE0MzMgKysrKysrKysrKw0KPj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBm
cy9zdXBlci5jICAgICAgICAgICAgICAgICAgICAgfCAyMDk5ICsrKysrKysrKysrKysrDQo+Pj4+
IGRyaXZlcnMvc3RhZ2luZy9hcGZzL3N5bWxpbmsuYyAgICAgICAgICAgICAgICAgICB8ICAgNzgg
Kw0KPj4+PiBkcml2ZXJzL3N0YWdpbmcvYXBmcy90cmFuc2FjdGlvbi5jICAgICAgICAgICAgICAg
fCAgOTU5ICsrKysrKysNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvdW5pY29kZS5jICAgICAg
ICAgICAgICAgICAgIHwgMzE1NiArKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+IGRyaXZlcnMv
c3RhZ2luZy9hcGZzL3VuaWNvZGUuaCAgICAgICAgICAgICAgICAgICB8ICAgMjcgKw0KPj4+PiBk
cml2ZXJzL3N0YWdpbmcvYXBmcy94YXR0ci5jICAgICAgICAgICAgICAgICAgICAgfCAgOTEyICsr
KysrKysNCj4+Pj4gZHJpdmVycy9zdGFnaW5nL2FwZnMveGZpZWxkLmMgICAgICAgICAgICAgICAg
ICAgIHwgIDE3MSArKw0KPj4+PiA0NSBmaWxlcyBjaGFuZ2VkLCAyODk4NCBpbnNlcnRpb25zKCsp
DQo+Pj4+IC0tLQ0KPj4+PiBiYXNlLWNvbW1pdDogNjk1Y2FjYTkzNDVhMTYwZWNkOTY0NWFiYWI4
ZTcwY2ZlODQ5ZTlmZg0KPj4+PiBjaGFuZ2UtaWQ6IDIwMjUwMjEwLWFwZnMtOWQ0NDc4Nzg1Zjgw
DQo+Pj4+IA0KPj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4+IC0tDQo+Pj4+IEV0aGFuIENhcnRlciBF
ZHdhcmRzIDxldGhhbkBldGhhbmNlZHdhcmRzLmNvbT4NCj4+IA0KPj4gDQo=


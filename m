Return-Path: <linux-fsdevel+bounces-44104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24108A627D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 08:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE3917E8E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EDB1A23A2;
	Sat, 15 Mar 2025 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZeNMRJfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010012.outbound.protection.outlook.com [52.103.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE019F462;
	Sat, 15 Mar 2025 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742022611; cv=fail; b=Y+yk30Q+9IINwWQKVXv1/Tgg7NA505YIyHLU/NqVuBo0DJCrqHSZVd7cz1w/mpSYk5DoD3rXIACDH/byOw9oQ9Km/Sy+xlY/JSAOQ1D9XUi0rrJ8LwZZrkkNn4FyplE7w4cgTl3R2xcQCdMtA8XQutpkfJFEvrkz5KdXrwEL+c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742022611; c=relaxed/simple;
	bh=QNTWFu9vYqAzGTpXWd5pnjWMraZGedmZPgBRSmybpl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8AoMJUFHuULthX5oxvGO9Qt0jDiAvOJOGr0I9+i+cojY1rGheAqZZd7ATxRUDCdoXir4TRFdG/ZgUEPbP5HXnskh5DEVbQcwpIQ6SpOVDjHrol5xAv7qqM+fIY1YH91nfepUvxkjE6tMGFsiRsdyGGnXW+g+s2wWRn/kfbM59k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZeNMRJfr; arc=fail smtp.client-ip=52.103.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUTKuJoPZ0OTRS7ArE4sn5PCIu18McziXxV7Gn+qGaVAwsco1hL07PQgB/ECO5mSCbeHWixtrpcn+nbJwrcGXiIwy2AVDUJwoPCPCv/GOpMwyOHxIQyqRLzv6jnKFtJmzw4UxMUpZIGUFdGXNbtJTvQwqnBkiWj9BKMgwGP5GZbb9rNSCl9jWKiz7RTVnkTWUFEeju4t7Q5PBsIFx0KXHfJE7YZxbN4OBXO9U2cQMfLJk2NXfDOFlyOcCpJTFYBvOtkaUD4zs4U2fKgvdcrD/7f6OGY0bgamnAX4FZdWSXpbTY7nBwLII4Ra4iNlykpu2Ng179Jp6I2TbbkohikzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNTWFu9vYqAzGTpXWd5pnjWMraZGedmZPgBRSmybpl4=;
 b=Ns1rGtB5N3RuRxcz4pv/ISs2ejT5jk679xoj7RtMe0MdGXMvJRNrQddGXQKBKN59/zn5q5ew7OHlvyMdOIEQTN9ywDfje3Dn2Glo26xz4YnJ2KdKpGMBNtAajWQSD2WtY6sC1O8fNMQVqyd8b9i9KMQtthOJqx+RsUZO9Eg1zfpDHdeFpk2BQ85Z4GfvHuyitfqjHdPlKF7+ymMq/tgTlmGo0QS3OyJrAWVJ10XDferLvyoTwvQr+NRND+PIA3nuw26wNRTIsNOoFU5BYf1gcgwU8W5/U2FGhtOG2zHNxYkYrslPC88GFOm1IDhG/gbQ/7JP08rfQ9rdojkVCjzioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNTWFu9vYqAzGTpXWd5pnjWMraZGedmZPgBRSmybpl4=;
 b=ZeNMRJfrDLO+XdlgrE59vAtyYYhGgf30oUFQml2oQnifaRvAy+506QmYNyzuQXxM5Ejir0p6VAOXnfRYipEwdleie/tJWpeUhO6IS05OFEG+peFd8hbOXxB0xZNbaxbffwlcHF4tahbvNQOWJrboqFEiOvKlcbiPO37VnLDY/rsHORaFvB3KqwPm3nJALJ5SWGAZ1TDnzRcyC7ipuxEaMlm2NYovWloRgm+nMq3EvJvQ0EpFbijLchYZwq9zTs733uW9PFti40mGQI6X9t7SKnPf3UqQLSEZyEX52UPUjrb8/8NKbOs3T3O/tj3OmCkksvl/JeXEjZN7QC/zPGs6gg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB8265.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Sat, 15 Mar
 2025 07:10:03 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8534.025; Sat, 15 Mar 2025
 07:10:03 +0000
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
Thread-Index: AQHblSw8K4t9osLx8E6wFBStbHPjGLNzyCSA
Date: Sat, 15 Mar 2025 07:10:03 +0000
Message-ID: <881481D8-AB70-4286-A5FB-731E5C957137@live.com>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
In-Reply-To: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB8265:EE_
x-ms-office365-filtering-correlation-id: ca8f99e8-50d9-4683-5626-08dd6390684e
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|7092599003|19110799003|8060799006|15080799006|8062599003|461199028|4302099013|12091999003|3412199025|10035399004|440099028|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXV6clkyV0tWa0NmUlErUVoxc09TbUJxekZJZHdYZVQ3TnVOeENWY21VdDQz?=
 =?utf-8?B?b0dZeE01WXRpaGU1Tk4weEZaUnVwcVU3WlB2ZTZQVEwzTWk5aGw2anlDTzJF?=
 =?utf-8?B?NHVOOFZLTVE5VU4yMGlseWc5eUJ0RlFLdGQxYldHbVJObE5kZmdaTENuRmtr?=
 =?utf-8?B?Q1V3aHcrUHdLNnlrK1l1UWdYSFZrcW1ibjNyeFFZeDZoVU5BVGkwdzZkeS9O?=
 =?utf-8?B?K0Q2ZnpNc2RxRHJwL29yNnBaa29xODlESXB6RDExYzdreVJ1SVZ3N1R5MDVh?=
 =?utf-8?B?QVhjWkVxSzR3R1BMckRicVZsUWI2SU9QQzd2T3pPWTZpVG5wdE5zci9CMGVq?=
 =?utf-8?B?MXpEb3Y5TC9WVjU3TmpOaEZKemxpYTRlVE5BVFJjcDcxWUlWQ28yRHYxek5L?=
 =?utf-8?B?eGFhZUZ0SzlpVStZVDdHMnd6MWViZEZZYmVEQW9GWExxVnRUL0JQSVVZcllZ?=
 =?utf-8?B?SHplN0orNEhsRytIT1ZoWjArYkNCUVNzM05VeU82NFJMb1BZb3k5S1ZqS1Bi?=
 =?utf-8?B?Z1pISDB5VzhGOVNuRnpVYllGS2ZMZ05zQUFENExDTDFDLytleWV6cFF6c1Jw?=
 =?utf-8?B?TnZrWjY3Q3N0OU14ZDJqdDZiNEpJd1FmTVIvdnRXT2I1NXh3YUlZQ2tOdFhs?=
 =?utf-8?B?U2xKMUVjMnVoRU1Md09ia3I5NnYySFpuVm9zbXdldCtsaS83T3p1Um1SNTJQ?=
 =?utf-8?B?V0VYZnQvZjFlenJSVzdTQUVqam1VMitIa205cGlFVnpaUGZVaHh2Vy9BVHNa?=
 =?utf-8?B?aUhFWmttaGRSYWd1bWZOYjZqcUtybHZzWCtueGFrYVd1WWxQM3J2cEQ3NTdV?=
 =?utf-8?B?ejdoNHI0cVdMa1dmT2Q3a0J6OThEWUdtWXhJWjBVOUsxNzJlZUh2TmI2MTNS?=
 =?utf-8?B?T3Rka1hvOENIaW55eXBqSkVreXplNnN6eHRoU1pIRXlzWklTUk80NnJoZS8x?=
 =?utf-8?B?RzQxRm5tZmgyNmI4VW5CelEzNGZxZnNPZnFFOU8rRHdYVzJobitXTGFLM0F2?=
 =?utf-8?B?UnF3MForWEpJVU04bjRoTCt2UE5nK3M4MGl1MjFBVjJIdTl0c09JRit5eElk?=
 =?utf-8?B?UWVreWMwd1hRNGhscjBKdCtOZWY3a3VmZUt4OU9DWHBidHJkSHFVTkkwM2xi?=
 =?utf-8?B?UUVxK1JCSWZhLzJ0c01qVFlFbktBQ0tBTkszSGlIVGtUb2hmb0xlVm53NXo0?=
 =?utf-8?B?R3NpcFE0UE41VTVyTkR4U3Y3ekI4dWFYeU9KQ0cyeFZMdGQ3VllKL0l6OVpI?=
 =?utf-8?B?MHNDdVBjR1NrWWd4S2hQb3R2NHNNVDh6Q1VXaHhqbUhORUpXRzRTSEM4ZlZU?=
 =?utf-8?B?RjU4eXZxUmhHajNUcXdTR0lDRmY4Y3dpbG9LcjIxQmNWZHNjZFFoYVZraUY0?=
 =?utf-8?B?UkZzeGRjSTFHU2J6U2tmamUwblFMVUpyV09zRjhlcUlYc0hnYVpZYTJsQU41?=
 =?utf-8?B?eEVKK01YbTFSUGRPR3g4MExaSzk4eUl6UlZwVkFVNDlUbVdPR3QzVklsUGFL?=
 =?utf-8?B?bzJURjlhdmhud2NLVVkrRjArcXFnWTNtM3I0U3EzY0Mrc0g2M1VyMHFKWHZG?=
 =?utf-8?B?aTd0VnJST051RVVvTDRGV3NrUWkvU3Q5cjltN05CUVJDOHZQbG5XaW9ZSVBy?=
 =?utf-8?B?b0N4RHJXcWNTWjlMdkdXWlVWdFZhREZHa0NXRUd6ZVZ3YnZ5QklTcEtMbXYv?=
 =?utf-8?B?S1NxSEJqa3c4Mi9FWDNpdWo0aTJ6aXA5b1cveEJndjc1QmxaMEEyRzZPOFQr?=
 =?utf-8?B?SlhQMWVFRW1GSXY5Z1RHcGdXZDVqUDMzdUFRNkIvOEtvMmwvUGFqdjExekNt?=
 =?utf-8?B?SUtnN1FBRzFYeHBHZGd2QT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTAzUTVmazZVbGdIeFhWRTZKdlNYbTNkSUxUZWh3TmgxdTFJZk1DOW82ZEp4?=
 =?utf-8?B?QVhEZlNDZW5XbE5ucTY4cERPQVZ4ZCs0OHE3RXRBbGZ0YVhTTHFyTEVROVR2?=
 =?utf-8?B?RVlWaHJnZGEzZ1VGWDc2U0IyREFWWFdPbkZCbmo5SXJFNFgrbmVJb0Q4UFdV?=
 =?utf-8?B?bG84MWxVVEF6czdxZnN0RW91ek9QeW1XSWdrY1ZvdXFTTTJBd0FNQUVPT2dL?=
 =?utf-8?B?SzM5bzd0T0tGZU9hM1hmYlRmUmlvZGF1M28zZjVCanUvOFNGRlYxWlhHLzBp?=
 =?utf-8?B?ZlhRNGtFZ3JlWEFQNUVua1FPcE1MWXVOUUh2a0h0OVdsUStGYUpNUXNseVpP?=
 =?utf-8?B?QWR6Ky83WnpqclNzN1JSd2tMMkdCdmQyRmVuNm1VVzcrRUlEcnRVeGd0NUNU?=
 =?utf-8?B?ODZBSVUxWWVkN2Jya3RVSWF0SnpCaWhaQ0d4ZnhJMXFFdm1Cdzd6L244SFMw?=
 =?utf-8?B?U2J0SGxFRzI3STNvL0lrWE9lS0Q0d1pvR2lNYldSM1ZDWlFzM3JXTTdvV211?=
 =?utf-8?B?Y1hnV0FRejFLOTQ4UEdNYkxRUzVRYXBLdUFzaytYZXBJQjRndXZWNVI4ZnBt?=
 =?utf-8?B?TTFnbWJDS2l3TFVqZHJzSXVhUHlQUXRWMkErQ0JNNW5xSkFvUnlGNzBKbnlJ?=
 =?utf-8?B?QlVnUmdGOXdWWEw5WEQvdjJCY2hyR1hhR1JMSGtEZE1LMDc2V0JXZ0Jaelhy?=
 =?utf-8?B?OU5JZk9SUy9uVW1HdlAwNWpCWVdUKytabjBsR05zb24zK1pVYVA1T3ZQQzVv?=
 =?utf-8?B?TjBYVUxvTjFzVnRISUlocjQwNUQ2cnFzRDFpTXFoWWcyN1VDdmxpOUNwT0h2?=
 =?utf-8?B?UUY1Sm5wZng1aE5rYXVEbTJvRXRDSVVTMm1pZ25wWE1OOGcrb1RNeHdQUEIr?=
 =?utf-8?B?MlZ0S0hwNW0ydW1Ec2c5ZEcxK3ZIK2ZWQUVrUUdwZHBCbmpDdkx3OEt2R2VD?=
 =?utf-8?B?YVRLbEdCVzh0OHFiazJvQnlrM0Q3L210YjVtYzlsN3JwNzJ0TWFmV3lZQlhr?=
 =?utf-8?B?N09XYVJHV29JVFJJRmVqZEtmNEp0QXg3RzVtUWgrT0hQdm1wSTJ1RlMvRzVH?=
 =?utf-8?B?Y255eFBxL1lWdnlDSkYwdm8zMDg0QXJ4eEh3aWw5eExTdUpLd1NEa3RMbUtY?=
 =?utf-8?B?VEFIbjdPL3BQQXdxcmVEVTNwWVI3bmRwREE5dmxxbmZzbENoZGRjN01IZHFD?=
 =?utf-8?B?cytjSWxnRFZUenRqV0VhdVVCVDh6RXdtYVVYSFlGZTYwZUxxWVhpNjZKWjl3?=
 =?utf-8?B?NHpHaURvcUdRLzZTMFVrS0o5S2paZjZjZC9TZkg1NGJQZDdhT2t1QjQyRm9B?=
 =?utf-8?B?bnB6WUhybU53NWxKbUZDOGxNWk9IYlluMDlKaVZsTWJCTnFvUDdUQ3U4R1E4?=
 =?utf-8?B?bzVCR2xvYzhaU2N3cUVqYVpDUCtMM3J2MENhb1RyVmdZMDJ0L21HcFFab1FE?=
 =?utf-8?B?dFFaR0tYQUgxczJMUlMvbnptd2dkVXVYNzYxM3lrZGxVZURBSG1wa0VoQklk?=
 =?utf-8?B?TTBsME9RZldpZFJkUXpaVUs2cDJuUmFrWXZLV1JNOFBSVG9RbkpCS3dZTDFO?=
 =?utf-8?B?NWVINHVBcFNGY2ZWV2N0Qlk2T3pFR2wzNlVSb2lWZU5icnhtQTN1aGRxdmE4?=
 =?utf-8?B?UjMyYVg3cldwcHhzQ1FnRFlPV0VPdWZUYUZZdnJQeDFBVFd6ckJXemxlelhX?=
 =?utf-8?B?TVA1OUxVZ3M5dmxnZm5McEtzQVZVRFVoelY0TmtpakY0eWRLUGdMeGt3cGVD?=
 =?utf-8?Q?7N8Y+kH8mE0AAppDxOiFJ/TnOUEWKNmR8yKHxUL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15D3949FA662844B81EC44284316F507@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8f99e8-50d9-4683-5626-08dd6390684e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 07:10:03.2398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8265

DQoNCj4gT24gMTUgTWFyIDIwMjUsIGF0IDM6MjfigK9BTSwgRXRoYW4gQ2FydGVyIEVkd2FyZHMg
PGV0aGFuQGV0aGFuY2Vkd2FyZHMuY29tPiB3cm90ZToNCj4gDQo+IEhlbGxvIGV2ZXJ5b25lLA0K
PiANCj4gVGhpcyBpcyBhIGZvbGxvdyB1cCBwYXRjaHNldCB0byB0aGUgZHJpdmVyIEkgc2VudCBh
biBlbWFpbCBhYm91dCBhIGZldw0KPiB3ZWVrcyBhZ28gWzBdLiBJIHVuZGVyc3RhbmQgdGhpcyBw
YXRjaHNldCB3aWxsIHByb2JhYmx5IGdldCByZWplY3RlZCwgDQo+IGJ1dCBJIHdhbnRlZCB0byBy
ZXBvcnQgb24gd2hhdCBJIGhhdmUgZG9uZSB0aHVzIGZhci4gSSBoYXZlIGdvdCB0aGUgDQo+IHVw
c3RyZWFtIG1vZHVsZSBpbXBvcnRlZCBhbmQgYnVpbGRpbmcsIGFuZCBpdCBwYXNzZXMgc29tZSBi
YXNpYyB0ZXN0cyANCj4gc28gZmFyIChJIGhhdmUgbm90IHRyaWVkIGdldHRpbmcgWEZTL0ZTdGVz
dHMgcnVubmluZyB5ZXQpLiANCj4gDQo+IExpa2UgbWVudGlvbmVkIGVhcmxpZXIsIHNvbWUgb2Yg
dGhlIGZpbGVzIGhhdmUgYmVlbiBtb3ZlZCB0byBmb2xpb3MsIGJ1dA0KPiBhIGxhcmdlIG1ham9y
aXR5IG9mIHRoZW0gc3RpbGwgdXNlIGJ1ZmZlcmhlYWRzLiBJIHdvdWxkIGxpa2UgdG8gaGF2ZQ0K
PiB0aGVtIGNvbXBsZXRlbHkgcmVtb3ZlZCBiZWZvcmUgbW92ZWQgZnJvbSBzdGFnaW5nLyBpbnRv
IGZzLy4NCj4gDQo+IEkgaGF2ZSBzcGxpdCBldmVyeXRoaW5nIHVwIGludG8gc2VwYXJhdGUgY29t
bWl0cyBhcyBiZXN0IGFzIEkgY291bGQuDQo+IE1vc3Qgb2YgdGhlIEMgZmlsZXMgcmVseSBpbiBm
dW5jdGlvbnMgZnJvbSBvdGhlciBDIGZpbGVzLCBzbyBJIGluY2x1ZGVkDQo+IHRoZW0gYWxsIGlu
IG9uZSBwYXRjaC9jb21taXQuDQo+IA0KPiBJIGFtIGN1cmlvdXMgdG8gaGVhciBldmVyeW9uZSdz
IHRob3VnaHRzIG9uIHRoaXMgYW5kIHRvIHN0YXJ0IGdldHRpbmcNCj4gdGhlIGJhbGwgcm9sbGlu
ZyBmb3IgdGhlIGNvZGUtcmV2aWV3IHByb2Nlc3MuIFBsZWFzZSBmZWVsIGZyZWUgdG8NCj4gaW5j
bHVkZS9DQyBhbnlvbmUgd2hvIG1heSBiZSBpbnRlcmVzdGVkIGluIHRoaXMgZHJpdmVyL3RoZSBy
ZXZpZXcNCj4gcHJvY2Vzcy4gSSBoYXZlIGluY2x1ZGVkIGEgZmV3IHBlb3BsZSwgYnV0IGhhdmUg
Y2VydGFpbmx5IG1pc3NlZCBvdGhlcnMuDQo+IA0KPiBbMF06IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMjAyNTAzMDcxNjUwNTQuR0E5Nzc0QGVhZi8NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEV0aGFuIENhcnRlciBFZHdhcmRzIDxldGhhbkBldGhhbmNlZHdhcmRzLmNvbT4NCg0KV2h5IGhh
c27igJl0IEVybmVzdG8gc2lnbmVkLW9mZiBoZXJlLCBvciBpbiBhbnkgcGF0Y2g/IEFGQUlLLCBo
ZSBpcyB0aGUgYXV0aG9yIG9mIHRoZSBkcml2ZXIuDQo+IC0tLQ0KPiBFdGhhbiBDYXJ0ZXIgRWR3
YXJkcyAoOCk6DQo+ICAgICAgc3RhZ2luZzogYXBmczogaW5pdCBsemZzZSBjb21wcmVzc2lvbiBs
aWJyYXJ5IGZvciBBUEZTDQo+ICAgICAgc3RhZ2luZzogYXBmczogaW5pdCB1bmljb2RlLntjLGh9
DQo+ICAgICAgc3RhZ2luZzogYXBmczogaW5pdCBhcGZzX3Jhdy5oIHRvIGhhbmRsZSBvbi1kaXNr
IHN0cnVjdHVyZXMNCj4gICAgICBzdGFnaW5nOiBhcGZzOiBpbml0IGxpYnpiaXRtYXAue2MsaH0g
Zm9yIGRlY29tcHJlc3Npb24NCj4gICAgICBzdGFnaW5nOiBhcGZzOiBpbml0IEFQRlMNCj4gICAg
ICBzdGFnaW5nOiBhcGZzOiBpbml0IGJ1aWxkIHN1cHBvcnQgZm9yIEFQRlMNCj4gICAgICBzdGFn
aW5nOiBhcGZzOiBpbml0IFRPRE8gYW5kIFJFQURNRS5yc3QNCj4gICAgICBNQUlOVEFJTkVSUzog
YXBmczogYWRkIGVudHJ5IGFuZCByZWxldmFudCBpbmZvcm1hdGlvbg0KPiANCj4gTUFJTlRBSU5F
UlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNiArDQo+IGRyaXZl
cnMvc3RhZ2luZy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPiBk
cml2ZXJzL3N0YWdpbmcvYXBmcy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAgIDEzICsN
Cj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAx
MCArDQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL1JFQURNRS5yc3QgICAgICAgICAgICAgICAgICB8
ICAgODcgKw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9UT0RPICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICA3ICsNCj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvYXBmcy5oICAgICAgICAgICAgICAg
ICAgICAgIHwgMTE5MyArKysrKysrKw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9hcGZzX3Jhdy5o
ICAgICAgICAgICAgICAgICAgfCAxNTY3ICsrKysrKysrKysrDQo+IGRyaXZlcnMvc3RhZ2luZy9h
cGZzL2J0cmVlLmMgICAgICAgICAgICAgICAgICAgICB8IDExNzQgKysrKysrKysNCj4gZHJpdmVy
cy9zdGFnaW5nL2FwZnMvY29tcHJlc3MuYyAgICAgICAgICAgICAgICAgIHwgIDQ0MiArKysNCj4g
ZHJpdmVycy9zdGFnaW5nL2FwZnMvZGlyLmMgICAgICAgICAgICAgICAgICAgICAgIHwgMTQ0MCAr
KysrKysrKysrDQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2V4dGVudHMuYyAgICAgICAgICAgICAg
ICAgICB8IDIzNzEgKysrKysrKysrKysrKysrKw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9maWxl
LmMgICAgICAgICAgICAgICAgICAgICAgfCAgMTY0ICsrDQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZz
L2lub2RlLmMgICAgICAgICAgICAgICAgICAgICB8IDIyMzUgKysrKysrKysrKysrKysrDQo+IGRy
aXZlcnMvc3RhZ2luZy9hcGZzL2tleS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAzMzcgKysr
DQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2xpYnpiaXRtYXAuYyAgICAgICAgICAgICAgICB8ICA0
NDIgKysrDQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2xpYnpiaXRtYXAuaCAgICAgICAgICAgICAg
ICB8ICAgMzEgKw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9semZzZS9semZzZS5oICAgICAgICAg
ICAgICAgfCAgMTM2ICsNCj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHpmc2VfZGVjb2Rl
LmMgICAgICAgIHwgICA3NCArDQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNlL2x6ZnNlX2Rl
Y29kZV9iYXNlLmMgICB8ICA2NTIgKysrKysNCj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvbHpmc2Uv
bHpmc2VfZW5jb2RlLmMgICAgICAgIHwgIDE2MyArKw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9s
emZzZS9semZzZV9lbmNvZGVfYmFzZS5jICAgfCAgODI2ICsrKysrKw0KPiBkcml2ZXJzL3N0YWdp
bmcvYXBmcy9semZzZS9semZzZV9lbmNvZGVfdGFibGVzLmggfCAgMjE4ICsrDQo+IGRyaXZlcnMv
c3RhZ2luZy9hcGZzL2x6ZnNlL2x6ZnNlX2ZzZS5jICAgICAgICAgICB8ICAyMTcgKysNCj4gZHJp
dmVycy9zdGFnaW5nL2FwZnMvbHpmc2UvbHpmc2VfZnNlLmggICAgICAgICAgIHwgIDYwNiArKysr
Kw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9semZzZS9semZzZV9pbnRlcm5hbC5oICAgICAgfCAg
NjEyICsrKysrDQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNlL2x6ZnNlX21haW4uYyAgICAg
ICAgICB8ICAzMzYgKysrDQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNlL2x6ZnNlX3R1bmFi
bGVzLmggICAgICB8ICAgNjAgKw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9semZzZS9senZuX2Rl
Y29kZV9iYXNlLmMgICAgfCAgNzIxICsrKysrDQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL2x6ZnNl
L2x6dm5fZGVjb2RlX2Jhc2UuaCAgICB8ICAgNjggKw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9s
emZzZS9senZuX2VuY29kZV9iYXNlLmMgICAgfCAgNTkzICsrKysNCj4gZHJpdmVycy9zdGFnaW5n
L2FwZnMvbHpmc2UvbHp2bl9lbmNvZGVfYmFzZS5oICAgIHwgIDExNiArDQo+IGRyaXZlcnMvc3Rh
Z2luZy9hcGZzL21lc3NhZ2UuYyAgICAgICAgICAgICAgICAgICB8ICAgMjkgKw0KPiBkcml2ZXJz
L3N0YWdpbmcvYXBmcy9uYW1laS5jICAgICAgICAgICAgICAgICAgICAgfCAgMTMzICsNCj4gZHJp
dmVycy9zdGFnaW5nL2FwZnMvbm9kZS5jICAgICAgICAgICAgICAgICAgICAgIHwgMjA2OSArKysr
KysrKysrKysrKw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9vYmplY3QuYyAgICAgICAgICAgICAg
ICAgICAgfCAgMzE1ICsrKw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy9zbmFwc2hvdC5jICAgICAg
ICAgICAgICAgICAgfCAgNjg0ICsrKysrDQo+IGRyaXZlcnMvc3RhZ2luZy9hcGZzL3NwYWNlbWFu
LmMgICAgICAgICAgICAgICAgICB8IDE0MzMgKysrKysrKysrKw0KPiBkcml2ZXJzL3N0YWdpbmcv
YXBmcy9zdXBlci5jICAgICAgICAgICAgICAgICAgICAgfCAyMDk5ICsrKysrKysrKysrKysrDQo+
IGRyaXZlcnMvc3RhZ2luZy9hcGZzL3N5bWxpbmsuYyAgICAgICAgICAgICAgICAgICB8ICAgNzgg
Kw0KPiBkcml2ZXJzL3N0YWdpbmcvYXBmcy90cmFuc2FjdGlvbi5jICAgICAgICAgICAgICAgfCAg
OTU5ICsrKysrKysNCj4gZHJpdmVycy9zdGFnaW5nL2FwZnMvdW5pY29kZS5jICAgICAgICAgICAg
ICAgICAgIHwgMzE1NiArKysrKysrKysrKysrKysrKysrKysrDQo+IGRyaXZlcnMvc3RhZ2luZy9h
cGZzL3VuaWNvZGUuaCAgICAgICAgICAgICAgICAgICB8ICAgMjcgKw0KPiBkcml2ZXJzL3N0YWdp
bmcvYXBmcy94YXR0ci5jICAgICAgICAgICAgICAgICAgICAgfCAgOTEyICsrKysrKysNCj4gZHJp
dmVycy9zdGFnaW5nL2FwZnMveGZpZWxkLmMgICAgICAgICAgICAgICAgICAgIHwgIDE3MSArKw0K
PiA0NSBmaWxlcyBjaGFuZ2VkLCAyODk4NCBpbnNlcnRpb25zKCspDQo+IC0tLQ0KPiBiYXNlLWNv
bW1pdDogNjk1Y2FjYTkzNDVhMTYwZWNkOTY0NWFiYWI4ZTcwY2ZlODQ5ZTlmZg0KPiBjaGFuZ2Ut
aWQ6IDIwMjUwMjEwLWFwZnMtOWQ0NDc4Nzg1ZjgwDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0t
IA0KPiBFdGhhbiBDYXJ0ZXIgRWR3YXJkcyA8ZXRoYW5AZXRoYW5jZWR3YXJkcy5jb20+DQo+IA0K
DQo=


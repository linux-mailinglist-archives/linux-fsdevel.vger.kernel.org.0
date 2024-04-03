Return-Path: <linux-fsdevel+bounces-16022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B0896F16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF641C2654D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0606146D41;
	Wed,  3 Apr 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="iTNRa10L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BC1482EE;
	Wed,  3 Apr 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148122; cv=fail; b=o+Ayt6whl0DJRaAkd4J32MNStyaFWr0XMUbzWqjuVqXt0a0+b2kb3Q3CCbjRSMTdmNYz7a0wrWLtTUpvBVeGI4bce3j2fykmzjEnyRMuwZHXxUuc68SzF78GQ5M5arfMSW8sFpxYHF1bs2Z5gFEfSqdMpNrjuyI+kxI1ZSBmvA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148122; c=relaxed/simple;
	bh=JNmOMhKMW6gx2N/JCC/m6+b9uY+PZRg8BcAUyjV3Zzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usNfo1iN9leu8C0+9PTUJGSy+36U7txR4Pl5NvtVvdspF7mV09kfQQsYEC1Cz9lGCg9/OiijwrgthMI+98W2VO+CEgawyCWMOUcDQwQPUDooyvdOMIjnRmuq26KafwgrDiXhefWtMNcFiq3p758hRliAQeYekBILV1b6DvyWF40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=iTNRa10L; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound10-205.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 03 Apr 2024 12:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOTFW3Oo4tkb7hkEJCBGDZ1z6d/ivnhaVRNVLTCHuYjYYGUIkYvEUcr7Jhd1i5/9CfVGTfGQAgNnk38mXHk48tCpQcdlMcUxNI2KzVC2JPD3pM9l/F5NQSs9JnQ/c99st9DNx6bgMdOge+yPtII+sybRowJk10yB2W99oSSkKIXgIfib6BTYZKdqgBCQVy6BFzDiXNtBe97Bcjh08Nb7wQpc0YuibhbPlCT4kb2tP92vm5zFRmaCXV1utAd4x/wp9Nn/4h622KElBIs3qhKmitvUdU/Afl+E1Od4kXuNRfza3gwoPeqCg5v3amHizbvlUOLRsvJGotHUFN2jgEf7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNmOMhKMW6gx2N/JCC/m6+b9uY+PZRg8BcAUyjV3Zzg=;
 b=mBPkpzbc4vtvh0iU96yewiUDBEnb+Zh503vY3syZrcKIgWCfx2NQXqLuG5+o3nbk0Qq9V9c+wTxGzMfoubr9p6xWcq0iuFrlWB11j9vy8sdm59fL1+zBBQ8tTcDyqHO4niCWi8Id7LI76J/FK651BkY8ilVx4UQ6tgbn7csRT6+ZQzTUtGnsDGNU7PBceG5FnaPWn90T4XuWwd5lksb81Ry1SmWGZz3X53Byy5+CqHHMs/XYYIyyP2iFPKcqPogdqdaGgmT004YtVnDmi/M31mx8KIiChOFwt71O2pPff1fJS90/YmMX7XmUzwOxqp/1/f+2+Xx13M8sF5B4KH7nbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNmOMhKMW6gx2N/JCC/m6+b9uY+PZRg8BcAUyjV3Zzg=;
 b=iTNRa10LPBKvei3xspSo5TarDeKX91uU7etDgmvgV5leBhyJCfsgxawUqZIXMgHa0BxRXmYLBrS65QJCn6bWVnlyUfWY1RqXj0m4QnMtZkZ1Zbf7l/Nc52CskySHGhBckmONdOw3VbAMKJ9KkwH7S3IPmRUw+5kBaBu1kuwHYdk=
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 SN7PR19MB6733.namprd19.prod.outlook.com (2603:10b6:806:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 12:40:07 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::8a58:247b:a09d:ede2]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::8a58:247b:a09d:ede2%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 12:40:07 +0000
From: Dongyang Li <dongyangli@ddn.com>
To: "joshi.k@samsung.com" <joshi.k@samsung.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Thread-Topic: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Thread-Index: AQHaaQmqs4xTfFwV8Umi6fEJWz7IwbFVA82AgABmiwCAAUuvgA==
Date: Wed, 3 Apr 2024 12:40:07 +0000
Message-ID: <d442fe43e7b43d9e00c168f91dcfddd5a240b366.camel@ddn.com>
References:
 <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	 <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
	 <ab32d8be16bf9fd5862e50b9a01018aa634c946a.camel@ddn.com>
	 <0c54aed5-c1f1-ef83-9da9-626fdf399731@samsung.com>
In-Reply-To: <0c54aed5-c1f1-ef83-9da9-626fdf399731@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5711:EE_|SN7PR19MB6733:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 69HXdLyo/JLRilegdfb/1Wce59KEffnILgpZVbUNyytAGnt/KZo1VOeBS0KVn09E7jRphpGvJ7kfc3yUrhWb+j+mMBypzpYLUXf6j9gGh9SyLJgrXRqSonCoxeMN78ijIhQtft4sq1RbBI05d1MqFvkHd5t1JZBXsObeHuiionTCFs1bU5hs5lDJVr9YIBFPtqZy6qajKfVZy3zWJxPkzTr/m1xoAuvCI+3apA/UdA6+nD7eIYgecDETiXyuyG7lbo9dv9R9gZDYr6CTUYAqAyPTvwUHn42/+Rm5yS8YnVo0muyxttdkjsbOe0kE86yaCXfhMNZGMWBaWHQCRIRmsB2m1k4Eb7W5FRAyGl5A+tIDwEL2mjOkElQeRWeyEX/b6q5ompplrFU+9NyOJe5g1OU6wLQEFNYZtFt/o+QPPWbMwXisNe3LgDZLQQsNdTDlT5au4GQJ+idODcjdrDp13eeGEkj7Cob66NxjD6c7qhx4YhhdVcyb6yGJ+VOL+MT68mGk1TIUvC4bg/AHPgH67TSBp8HZr33VE9s2KEPirY3Zn6b6OLui009d3J++fSeqJRcQYP+HsxuvPslPFo2OGDMTF42+LEd2dQHzRCMRIY3ydRMzKTBqAmy0wE1TpMO30ApCxZ+L8Y5Pldgz3vrdoy04SyRrGu0bnVJ55JlF2Vc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUl3empkUmo0cERCUDMwVnNYdjA3TU15TDNMeEJhMjlITjR2UmlJOTEyR0NR?=
 =?utf-8?B?RG5CNHN5MlI5ZCtQNU1pWWNjTnAxbzZXcnFCbGxYTlk3MDZFT3pNYWpyRVZD?=
 =?utf-8?B?Q284aWU0SW9sUGJzcDJGRkwvbGVzVkZibklYYTFSeVAxQjBuWlIrbU80VDRP?=
 =?utf-8?B?bWFzeUlpZCs0SnNrbHRnSWxvWW8wL2tub04rVXRuOGV0V2l1R20vRDUzN3g5?=
 =?utf-8?B?b085WURsTmRGLzlzVWVPd1I1Sk9PRGpCSVFmTjkvNkNBYUdRNkxRZ2FGQkZU?=
 =?utf-8?B?dVBmT0t4MCtiRlZkQ2NMTm16bnpvUFRKSDgzS0hjZnJNRXd4c21rU25NWFNv?=
 =?utf-8?B?aFQ3MWtZN09IZlRxZ0Nza2JLNzlSMHo2THZKek4waG5rSjR2dVRHMFkxWFMx?=
 =?utf-8?B?cXdNaGdDUlNqcUIwNitTSktLVFNkT05MZGpzU3M0U2RpejNHQmVvVGlLVks0?=
 =?utf-8?B?OVNMYWZhcGpsRWxMdXZmNDBkS20xWXNpT1dNYXJlSFAvOVBRb21rSm1say9R?=
 =?utf-8?B?UUY0Tkl1Ui9POHFMakhDQWJBVnpaRUxLcnYyaFZ3VVphc1BNU1k5eU9mZDha?=
 =?utf-8?B?TWdSd043TzNqUm9aOExSMHNNZzBaK1hOdjVLQ3dVWmFvdmQ2U2NCOWJNYk52?=
 =?utf-8?B?Y0R6VzBJUFNWQzJpVHl2R0V6dHdLcDBJWUNaTUhhRk9TY012emVHL2JVdVV5?=
 =?utf-8?B?OC9qQklUZzdwMXlQVEtDYnY0OGpMWHRwdy8rUFdvUzVUcHgvZWhyWU5ReXNB?=
 =?utf-8?B?UUl4WG9qNm80b0lvNDNCNXJqbnN5M0s2ckEvMUt5VXFyeEsxZzhnUE5Ka0dN?=
 =?utf-8?B?djFuMUpmTHNSdnUwcjlKc3gvK3lkNmw3UUVPZjhPSHZQYzNnUUh4My9QdzhK?=
 =?utf-8?B?UllsTkhBaXdHWVltWndPbERKN1pxZUhMTzk0Z1FsN3VVdkRXK2xxQ29jZXZG?=
 =?utf-8?B?NjhwVkJjYllYRk11bmVIcFNxL2RkcTQrZEprSktTVitMZW4xMEZDbStEbWxv?=
 =?utf-8?B?QmxhRDdobU9nL1BnVENmZmFsMUxwaStrZVRwSE16S25yUGhYZjR1TS9MNUdE?=
 =?utf-8?B?cEovd1VMQ2p2TVg2U0Z5cEVML1hDdklKOEZHN3pSRC9QSVlUeUlPVlBNcjhO?=
 =?utf-8?B?Uy9jRUVBVDVqQnpvNWUrZTRBd2pZd2RFM1NFTHZ4THZodFNvZzZiNjFIUHVG?=
 =?utf-8?B?WWN4c2xvMCt6RjZhSkt3amZ2SVBsV3ZCQ2NDN1p5YS9QaWtjcy96QUdoUm40?=
 =?utf-8?B?ZXplcWJOVzZYLzBNVGkwdGNGL3U0ZjRiMWIyU0EyRWg5bjRxOEY4YU8vZnRV?=
 =?utf-8?B?V2NQK3IwU1JYWFozaHYwd2lqV0JPdmhud2c2N25xc2picWRUcWZwZDNGb1lK?=
 =?utf-8?B?WFdGNWE5MDJIb2NOVDc0cTVKMWFQb2JURk9sRXlqTnFPVkhiVkVhbDFpY3BT?=
 =?utf-8?B?dHFVNTR2bmhITHVrZWUvelpIL0s5U21sQ3hMUGthZkMzVDJaVE8yeG16UUk3?=
 =?utf-8?B?dXFZT3BLRWtZVTgxdXgvZGVibm5pR3NFSThORHJ0UjlZcjU5aUViVHY5N2JZ?=
 =?utf-8?B?S2xUZ2pNc3FzM3k5a0dSRVh2QTZxc0V6K2JscGhaczFsQUFMaDlOa1YrK2NB?=
 =?utf-8?B?RDFodEZ0dThIaTVleEZuQjFCSmYvNXprN05XeU83ZXBwdFFEYXZSZmY3MEZK?=
 =?utf-8?B?eEY5MXFReHptdjFYZ3hRTGo4cDRxb05mOFdBeHJDdlNPMWR3dGN1dE1DQkJw?=
 =?utf-8?B?Q3NCbHpIeDBya3FrQmRuRFdxSjBDR01KSW1DSGJDd2VUVWgvVVovdlpFZ2hN?=
 =?utf-8?B?RXc3Tzg5TGtEWm5OTWxOTFFieVJNVUUzQnAwUlFQWmQ3TmxvT2pzbkl3WEtS?=
 =?utf-8?B?Y2d6bkdqMnRQbHRnR3R4dy9jcWVRVkJsRGZUU3gybWMyaHU2ZjlNNDZvbm1S?=
 =?utf-8?B?dGhzZ1hwVHRTQTNLMlRTZW1SQWJxdDZBR3BLZWxtSWp4ZWUrdmFwTnZZODFY?=
 =?utf-8?B?bUw2OXdPM1lVQlMrRnUxcUk3R0dQRER2MXNGMEg3M2NnRmNteFFaWENlQklz?=
 =?utf-8?B?bFJOc2ZQMnhYUnJJQ2hJVlc5S1UvRjVMblR6d1ROemNwaW50L253ZWZod1Rl?=
 =?utf-8?Q?Vqvs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <205AF38A5093534EAF5B41288D510570@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GhiqX9mKRegUUtD9S0ndxwtW32qxs74XfKT1Eb308sre5+P0EQ/INaboCfA/Vkfy+O3VeIoLTrEFPnsGrzBzcwwtoFpeubLnZnLxekY+lOhflGLS1ZDSJ5t7ECjkP6Y0UvaVsMUGlV7hQJyUUODGzFfQ/q4KKzqo3Llk5pHA8Ky5PUxH5AM5ralVk9JK3g6JJwAoR8b2IzD4FQuSD0MxooiVZE4ELNsnDsHTQoncuKHFsKDvjO5NfhJGzdtCGnfeB2nU+WHzh0DCzi4uUZTJmi4gp1wsORWnfm0qMjE72jvDKrMAP7A5krsV6/cWBkwj10rbBPa9JucelVHfROmupKyb6o8FLR2E99mqgEeGpwR9VhisRRlzuIGXCObEIeuYLw9dMZCYVwFvE8nHM1Y30JcV0egW7ClRbN/dRvsFdaBzoO9Gt4F/ZVgAXIfgVv9lJu0hQt2VtCqVwTnNL7OHWTJZgVDyr9soLWoc2dJ2p2mf4JFm3TKREErnm9dOZ0evMXlrE6xqOO6jcCEDyaJ/wRDzrcPnaT9b9rAiy6b1E+iqaFdm88QzipcFL+BXnMTyo5IV4faUpZfU/BC+7JJPGuFUVTdJ12FT/q6I+ezb0MT+U75/6gNbk86qccrT4KY7UWYSvw+4sMP+1SLkG4e+CQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cad0f7-301d-4de9-328b-08dc53db3184
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 12:40:07.3269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oBsZfP+pSecLhfZsqMy4dAT9C+0N0V1JmpUBFP1UdqKsxiL8gc9YEfal6+cySWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6733
X-BESS-ID: 1712148012-102765-12685-1752-1
X-BESS-VER: 2019.1_20240329.1832
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZmFoZAVgZQMM0o0dA0yTIx2c
	LSwsTEwtLAwiwtKSXNOMU8zTQl1TJZqTYWAEPBXEJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255307 [from 
	cloudscan12-205.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDIyOjIyICswNTMwLCBLYW5jaGFuIEpvc2hpIHdyb3RlOg0K
PiBPbiA0LzIvMjAyNCA0OjE1IFBNLCBEb25neWFuZyBMaSB3cm90ZToNCj4gPiBNYXJ0aW4sIEth
bmNoYW4sDQo+ID4gPiANCj4gPiA+IEthbmNoYW4sDQo+ID4gPiANCj4gPiA+ID4gLSBHZW5lcmlj
IHVzZXIgaW50ZXJmYWNlIHRoYXQgdXNlci1zcGFjZSBjYW4gdXNlIHRvIGV4Y2hhbmdlDQo+ID4g
PiA+IG1ldGEuDQo+ID4gPiA+IEENCj4gPiA+ID4gbmV3IGlvX3VyaW5nIG9wY29kZSBJT1JJTkdf
T1BfUkVBRC9XUklURV9NRVRBIC0gc2VlbXMgZmVhc2libGUNCj4gPiA+ID4gZm9yDQo+ID4gPiA+
IGRpcmVjdCBJTy4NCj4gPiA+IA0KPiA+ID4gWWVwLiBJJ20gaW50ZXJlc3RlZCBpbiB0aGlzIHRv
by4gUmV2aXZpbmcgdGhpcyBlZmZvcnQgaXMgbmVhciB0aGUNCj4gPiA+IHRvcA0KPiA+ID4gb2YN
Cj4gPiA+IG15IHRvZG8gbGlzdCBzbyBJJ20gaGFwcHkgdG8gY29sbGFib3JhdGUuDQo+ID4gSWYg
d2UgYXJlIGdvaW5nIHRvIGhhdmUgYSBpbnRlcmZhY2UgdG8gZXhjaGFuZ2UgbWV0YS9pbnRlZ3Jp
dHkgdG8NCj4gPiB1c2VyLQ0KPiA+IHNwYWNlLCB3ZSBjb3VsZCBhbHNvIGhhdmUgYSBpbnRlcmZh
Y2UgaW4ga2VybmVsIHRvIGRvIHRoZSBzYW1lPw0KPiANCj4gTm90IHN1cmUgaWYgSSBmb2xsb3cu
DQo+IEN1cnJlbnRseSB3aGVuIGJsay1pbnRlZ3JpdHkgYWxsb2NhdGVzL2F0dGFjaGVzIHRoZSBt
ZXRhIGJ1ZmZlciwgaXQgDQo+IGRlY2lkZXMgd2hhdCB0byBwdXQgaW4gaXQgYW5kIGhvdyB0byBn
byBhYm91dCBpbnRlZ3JpdHkgDQo+IGdlbmVyYXRpb24vdmVyaWZpY2F0aW9uLg0KPiBXaGVuIHVz
ZXItc3BhY2UgaXMgc2VuZGluZyB0aGUgbWV0YSBidWZmZXIsIGl0IHdpbGwgZGVjaWRlIHdoYXQg
dG8gDQo+IHB1dC92ZXJpZnkuIFBhc3NlZCBtZXRhIGJ1ZmZlciB3aWxsIGJlIHVzZWQgZGlyZWN0
bHksIGFuZCBibGstDQo+IGludGVncml0eSANCj4gd2lsbCBvbmx5IGZhY2lsaXRhdGUgdGhhdCB3
aXRob3V0IGRvaW5nIGFueSBpbi1rZXJuZWwgDQo+IGdlbmVyYXRpb24vdmVyaWZpY2F0aW9uLg0K
VGhpcyBpcyB3aGF0IEkgd2FzIHRyeWluZyB0byBnZXQsIGJ1dCBmb3IgaW4ta2VybmVsIHVzZXJz
IGluc3RlYWQgb2YNCnVzZXItc3BhY2UsIGhvd2V2ZXIuLi4NCj4gDQo+ID4gSXQgd291bGQgYmUg
dXNlZnVsIGZvciBzb21lIG5ldHdvcmsgZmlsZXN5c3RlbS9ibG9jayBkZXZpY2UgZHJpdmVycw0K
PiA+IGxpa2UgbmJkL2RyYmQvTlZNZS1vRiB0byB1c2UgYmxrLWludGVncml0eSBhcyBuZXR3b3Jr
IGNoZWNrc3VtLCBhbmQNCj4gPiB0aGUNCj4gPiBzYW1lIGNoZWNrc3VtIGNvdmVycyB0aGUgSS9P
IG9uIHRoZSBzZXJ2ZXIgYXMgd2VsbC4NCj4gPiANCj4gPiBUaGUgaW50ZWdyaXR5IGNhbiBiZSBn
ZW5lcmF0ZWQgb24gdGhlIGNsaWVudCBhbmQgc2VuZCBvdmVyIG5ldHdvcmssDQo+ID4gb24gc2Vy
dmVyIGJsay1pbnRlZ3JpdHkgY2FuIGp1c3Qgb2ZmbG9hZCB0byBzdG9yYWdlLg0KPiA+IFZlcmlm
eSBmb2xsb3dzIHRoZSBzYW1lIHByaW5jaXBsZTogb24gc2VydmVyIGJsay1pbnRlZ3JpdHkgZ2V0
cw0KPiA+IHRoZSBQSSBmcm9tIHN0b3JhZ2UgdXNpbmcgdGhlIGludGVyZmFjZSwgYW5kIHNlbmQg
b3ZlciBuZXR3b3JrLA0KPiA+IG9uIGNsaWVudCB3ZSBjYW4gZG8gdGhlIHVzdWFsIHZlcmlmeS4N
Cj4gPiANCj4gPiBJbiB0aGUgcGFzdCB3ZSB0cmllZCB0byBhY2hpZXZlIHRoaXMsIHRoZXJlJ3Mg
cGF0Y2ggdG8gYWRkIG9wdGlvbmFsDQo+ID4gZ2VuZXJhdGUvdmVyaWZ5IGZ1bmN0aW9ucyBhbmQg
dGhleSB0YWtlIHByaW9yaXR5IG92ZXIgdGhlIG9uZXMgZnJvbQ0KPiA+IHRoZQ0KPiA+IGludGVn
cml0eSBwcm9maWxlLCBhbmQgdGhlIG9wdGlvbmFsIGdlbmVyYXRlL3ZlcmlmeSBmdW5jdGlvbnMg
ZG9lcw0KPiA+IHRoZQ0KPiA+IG1ldGEvUEkgZXhjaGFuZ2UsIGJ1dCB0aGF0IGRpZG4ndCBnZXQg
dHJhY3Rpb24uIEl0IHdvdWxkIGJlIG11Y2gNCj4gPiBiZXR0ZXINCj4gPiBpZiB3ZSBjYW4gaGF2
ZSBhbiBiaW8gaW50ZXJmYWNlIGZvciB0aGlzLg0KPiANCj4gQW55IGxpbmsgdG8gdGhlIHBhdGNo
ZXM/DQo+IEkgYW0gbm90IHN1cmUgd2hhdCB0aGlzIGJpbyBpbnRlcmZhY2UgaXMgZm9yLiBEb2Vz
IHRoaXMgbWVhbiANCj4gdmVyaWZ5L2dlbmVyYXRlIGZ1bmN0aW9ucyB0byBiZSBzcGVjaWZpZWQg
Zm9yIGVhY2ggYmlvPw0KWWVzLCBhbmQgaXQncyBhbiBhd2t3YXJkIHdheSB0byBzYXZlIHRoZSBt
ZXRhL1BJIGJlZm9yZSB0aGUgUEkgYnVmZmVyDQpnZXRzIGZyZWVkIHJpZ2h0IGFmdGVyIHZlcmlm
eS4NCj4gTm93IGFsc28gaW4ta2VybmVsIHVzZXJzIGNhbiBhZGQgdGhlIG1ldGEgYnVmZmVyIHRv
IHRoZSBiaW8uIEl0IGlzIHVwDQo+IHRvIA0KPiB0aGUgYmlvIG93bmVyIHRvIGltcGxlbWVudCBh
bnkgY3VzdG9tIHByb2Nlc3Npbmcgb24gdGhpcyBtZXRhIGJ1ZmZlci4NClRoaXMgbWFrZXMgbWUg
cmVhbGlzZSBpZiBpbi1rZXJuZWwgdXNlciBkb2VzIGl0cyBvd24gbWV0YS9QSSBidWZmZXINCm1h
bmFnZW1lbnQgd2l0aG91dCBiaW9faW50ZWdyaXR5X3ByZXAoKSwgaXQgd29uJ3QgYmUgZnJlZWQg
YnkNCmJpb19pbnRlZ3JpdHlfZnJlZSgpIGFuZCB3ZSBjYW4gcHV0L2dldCB0byB0aGUgbWV0YS9Q
SSBidWZmZXIgYW5kIHJldXNlDQp0aGUgUEkgZGF0YS4gSSB3aWxsIGdpdmUgdGhpcyBhIHRyeS4g
VGhhbmtzDQoNCg0K


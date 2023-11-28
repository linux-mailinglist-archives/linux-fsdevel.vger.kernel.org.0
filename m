Return-Path: <linux-fsdevel+bounces-4013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9506D7FB22E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 07:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A71B20CD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 06:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A178101D8;
	Tue, 28 Nov 2023 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="SS/hQqfm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3278FE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 22:55:40 -0800 (PST)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS1DuUC028980;
	Tue, 28 Nov 2023 06:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=IieBZFm8QuVQC+B6RSDiFNtLU5vS9XHnx+HnFVXSLFQ=;
 b=SS/hQqfmENbXA+DgHaFQXxnevcdRA7Rw8GZK8ZyVVQZkYT/ZQJRi5FrWTrWFkIo12MJp
 thl8P3SIn+WlEDfRQOblVkimRiYAwJHEFZ0HYxGOlN703xL7OjRLgNlpzRyeBTKsEJ/s
 qArKhYe0kT9+0p0Qa+pe8wbXikYf+3/S4G9znpdT5EIFgAghFOd3wr+6h0NTFdHbb+Ht
 l0QjBw/HOyYO7+sJnpzfqzYHntmGbM4pyxIlXOsCjDlWPSQHuM2y/vma+oKg6GQibmAB
 fqEWb2N1fiPTd/VYEaGJFmEcCZCxwt//YNxSDjeei+LPEjRW99mcgywRH5zRnp3qohUz /g== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uk7q6thtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 06:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZoYBIPW9EIpzANi+TAY4JrdPQG9h9OQG7JM2bhS54LE4oFZeaX1K/mlU9cbTalr3T+DVIqgbl3yDXBFv8AVkTVz6czH45Vey+MH5j3UjKjCvRwHAd9B1W7C1TRMYfeXoFqwNLYLWZInYn+7Chs1IT1rKDQ7DJZ9vNASjgbG1XIzoaYkRLz8KI9PZr+SQ00XKYgxBax9Ks0BncU2ualOka1S/sDumj0REZPc/rsQFfJPpnmPe5vRqP9ShAv65gy1hus9TtW4lG+OIP67INEuocDDSmVMVH53+krYcoBy99m+frYtM9tXyfnRp5BR3vhoLePcV27IsP+HrNhNY86eoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IieBZFm8QuVQC+B6RSDiFNtLU5vS9XHnx+HnFVXSLFQ=;
 b=bBo/2XQgNeclgYlFYcRO3/2Cnf/rBwuKOtTFw4WcK4RUuShwXJGEpCMSJR2iCFaPZRSI5OF8qEfbEg58UteBG+zwI79HLGk/ayWZvcHGt2DIwnPa/F/XiuCKbchsWizR4Y5Zho/bfvhMbHnt/kp5Gt20wVZwN9GY8R9vkFqn6zEvpLKzebuN3Xm/i815GjrTChw3XLVCd4lZ5DsnxpPYEYOrmN7xKw5IrNs6ulhDNJD7MZ1vxCMOqv14enr5OZ7dLuSkJ7WzFmWJS5H/dDkbosxB848UcgAgoZ14/63xoYWa/a5wcTGuMHT48qVEcLPO8f4GHMHbiEDXc7fm7LjY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7709.apcprd04.prod.outlook.com (2603:1096:820:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 06:55:21 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 06:55:21 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>
CC: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v4 1/2] exfat: change to get file size from DataLength
Thread-Topic: [PATCH v4 1/2] exfat: change to get file size from DataLength
Thread-Index: AdoNcqiciL5m7DeAQVy9qFZcQUwgXwTU6BQAADf75FA=
Date: Tue, 28 Nov 2023 06:55:21 +0000
Message-ID: 
 <PUZPR04MB631632C69C52D59BF68FBEFB81BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB631680D4803CEE2B1A7F42F381A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd_CFaxxHnQTKYv1dL9n=Ank+tg9mMiUBH6_LVM2xkDV+A@mail.gmail.com>
In-Reply-To: 
 <CAKYAXd_CFaxxHnQTKYv1dL9n=Ank+tg9mMiUBH6_LVM2xkDV+A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7709:EE_
x-ms-office365-filtering-correlation-id: ae7ae095-22dd-4013-0f51-08dbefdefd2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wOEO9Uh7sb3rInv9uY/cQ6Uhkaasfz2eWvL4cD4pDt8QU3cRPjkaSQSZr6AVv3qPwGySnFe+CmgA88gC+pVLkrBpfkVKUFNe2DRuTdNuXpa84UvKZKQoPjJttPyWcNGdKNXdu0IgjmLsbDMEi446fAPLgXS0Jmg7aXB20HZZAM9rFkydhyW8rMhZhS+MYesmwi+jt/SxFY/VZ8dXzqc5yczSqbiPGM0E19IGgxMJO29laW7JQVRw7uYnh2n8BsnIJrMYvTd6saTP0r6IfeARUGkPHVZsPWoq/Lowqn+hOMCna7n3DnNQbRCP3zYvEkHhsSbPn+nwjq0bUPTaCuN1YFnV1vlFTNHaZe4P82Nw+2zVYQLSHL7PnIikEujm5KYGqfrYN7jiFNSHQ548WN+FeD9huJW5pcJSX19xxwwW94Vxk8k4hAqRB6qT0YTMq+NMMa9mKFRgqmw6W6wSAFTeVbtAqXoH9Z2fmGJm03DE694UN3WrNkQxcBja66l+ZuyfYJsJaRc6bZk800rdjfV3PXn9BA9KxEQVL7H4sQC7CFwAuFBIrYokhbQ0x76/js67ERlr7vLEy4XmnrCitBkY3U1O+oY8ZgQXqIhCH/rNfGEcn/fWiBYkRzp9oWEGwq4O
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(9686003)(71200400001)(53546011)(478600001)(26005)(7696005)(6506007)(5660300002)(107886003)(83380400001)(2906002)(4326008)(41300700001)(64756008)(54906003)(66446008)(66476007)(66556008)(66946007)(316002)(6916009)(8676002)(52536014)(8936002)(76116006)(38070700009)(122000001)(38100700002)(86362001)(82960400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bWtGUEdjTk9MSktqaTBVSVRqdXRMdVZFN0tRMVZzZGIyb05GY05uOTdxYWNl?=
 =?utf-8?B?L01GeEd4KzVlUy9jZlhtdWpJcHVVbVFncGlvNGlqSVRnWk1IYkxldFg4TjNW?=
 =?utf-8?B?Q1hlMFN0a1Q5R0YvL2RYWWxZTUVxWDhDeE1vZ3NUejdHYzc2TFRPL2NmSGlW?=
 =?utf-8?B?Qkl0MDdCOGRrYk9UL1ZYUityZ2RVa0ZTWjNGRUI1Z0JPVERqUkFBdndEYVR1?=
 =?utf-8?B?ZDJPKzYrNXgxQlZOUmlpWTN6R0hQeVdQcXF4TFIwbUVjUVJQWXdaQTNNTVpZ?=
 =?utf-8?B?enpGMGZsZVJCU09xd096UE1neXBVSlFHdEVKMW5IU0c0UDRsdlRCbHVtQkdG?=
 =?utf-8?B?dmhaUDA2SXhwVUROcnhTN1FxM0RjR3h0NnNwa2ZqMVkyMElEdi9INEh2eGx4?=
 =?utf-8?B?SFJBNUMvdWEwYkxWVFVnYjZ1RlFyL2Z2STVOaWFJV0FsdWgvcFVkc2NXWjJz?=
 =?utf-8?B?WExUTEJqbGZ2bGdad1VhVEw5TVVYQWptRVZXbktqeUl0dU1lbzRCUS9rc29Q?=
 =?utf-8?B?V2VHOXpQQ1JmL2JkMk82OEt0OE83VXhrQUJ2Qlo3TlJwVnlGTUxmUC9OUUs4?=
 =?utf-8?B?RWl4M1N1ejNhRUFQa1krNnhnekxDS21CSVNSS2xWWjVPTWZEbWx4Q08wNzJO?=
 =?utf-8?B?UGFyL3U4aXhWcnJCQlpRQ1Exd3dLVFZFS3ZWRURjVHMyeTd3UkxSMThtanpK?=
 =?utf-8?B?cHo3SjZ0ckhaY3VxMlNKUnRmVjVONmhYbUpIcjJlZ0N2S3B2aXZtM0tBY3l0?=
 =?utf-8?B?YzllMzV1bm9COFpibkxKNnIraDd2M3Y5N3dWM3ZUUnV6OFIzOFFkRGJ3Sklw?=
 =?utf-8?B?N1pvT05GeVZjNlRtMUsxVGEveHhHSUptaEU5bkY3YzIzZ0ZaUFU2ZnZmMm5Q?=
 =?utf-8?B?Zm55WGhGUlE4OWlEK2QrZTFGNEcyeVZkbHBLZXlRR3IvNEc1R2QyZG1HMHFG?=
 =?utf-8?B?Wm41bnVZS0JFMEhRTlF4b2hXT3dWNnNEVUFMN2s4c1JGa2NpTld4UGRaWEw3?=
 =?utf-8?B?VlpTSWFCajNSQnBjUVcrM2FKc0VxZ3BjVWVrRW9CUmRXbXh2UkthcGZwT2p1?=
 =?utf-8?B?Y0t3azVBZ2dyZTZGODdhM0k3RXVHUmVhbHFaTFcvQmQrV0FhUHMxZVY1NEFs?=
 =?utf-8?B?bXYrM21FTkhEaDRVdGllVGhBN3FMOHhXNTZQL0IzZmJIaTJjUi9aQ1Y0aUxE?=
 =?utf-8?B?TS9rY0M0ZWk2eHZNZmVQRU9oN1VBN0pnZjBnZ1I3VjArYy94SXVNZ2Jma1dQ?=
 =?utf-8?B?bXNaSTdiaE9GNCtYSFNYNFpiejBCbXpBWEpUcDBoMnIycEVrQ2g2b0ZJTnVx?=
 =?utf-8?B?MGlFaGNaZ0pZNEVwVkwreHlZa2tsOVgwNmFma29kWThPZkRRQWkvWWtOenF4?=
 =?utf-8?B?TThLcEI2KzRmMnc2c0NUb1NYN1pWWEJuRWJRS1ZzZ2hPeHVtUy9BcWdtMUVY?=
 =?utf-8?B?TldFaHBtbGpNUU51NnNSbmpLK3oveEtpNjdlcTlxVUNrMllTeEVnd1ZYRmMr?=
 =?utf-8?B?L1lZSDJTc2JrQ25VazYvdzRrV1ZkUVJoWHJGS3pCdnN5UUVDL3R3djRRNEd5?=
 =?utf-8?B?N1BkSEY2ZXZlenRGK0hsZG1OUTZ1Y0tQbmErb1NWc3BrOFdRYjA2VzlKTzBq?=
 =?utf-8?B?TlU4U2RlQlB5cmIrTEFMRjIxYlpjTVBXeDhGK3VYT2RNVWg0MGNiVENDRGhU?=
 =?utf-8?B?RmxTOVBvbU94a3lyZE42R1lLR09PME9RVWxQT1lpWlhzajZ5eUNSNCtIVnM3?=
 =?utf-8?B?RS9icVcwOWJ2T21QRHNHemgxSTJCVWRoYzc2bVgvK3I5MzlHY1dseE1mZ3ZN?=
 =?utf-8?B?eHQ5aDdIOWxuanBkUHAyLzhmYVFFT3RnaFdIS3QyQ3pOWmg1MVFYaEl3NWR5?=
 =?utf-8?B?dTFkNWFwSFRYKytINTI4OHJOVmVyOG0rdXdJc0NmMWhGT3VXbnlzUTdyRFNK?=
 =?utf-8?B?TWl2K2FVTzBPbXhtNHIvSFJvbzBNLzQ5bHoxSkE3VFdEdFpndDdZWU5qU3Jl?=
 =?utf-8?B?eHhrejUrcW5lZWxIcVNTZURhZXZWSEIzSGQ4dkVWU3dNMlFrbmNyYlRRY0pQ?=
 =?utf-8?B?QjhUR2FXbFZyV2dJSG1rTWpkZ3IrQ2pCUGd5Y011WWlZTjhUdTlEbTQ3bXIy?=
 =?utf-8?Q?35FVUNgFLSyu4BL4i3YG2JIyY?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lg7XhCiIMUVnq5MnZitcn9zyMn2oe5NADnzxudbqlo7DZTSnjUWz0L7jzr7ADJJaaWkTPrMGSJ1saggCj/OYSqZqyeQn33bPWmMbwJpa2JMCeUuSqlc/m2XeeCTdL5rSuQ6HedUcD5DamoZ7VC75oPfInVeFeI0E1m8ifmPyUsjbUgSx1TG1WFFE4peUz6WL323CKkUtUzqpLj7zr2ySRG1jrVelnSFcn5xHQ/rjb+XPXmeLEBsZQslYb/3j4tqh7tH4uIVYZFzASy+Xp8Ez3bz5YWPCwD7N9AeOznpaoEd1AAVvgVw2FWsI2Q19G2yqRP7n3+bZSWPJy/mI9cmexDY0RTOWXqoYLsA71e9Gq6nrGIVk5y6+XpbZa7CZ8bNSjYntR4fP9oSMRwT0hDOGPVvvapB3T9D5TjKYuQaZekHKcJUcfyTwx1q0BAviunbBG+Hz8qvHKmDtBLxn5Tip+0vaNOlOl6hj7IiZMfYQWMrM+M9tODWNKW1oexdmgvouHLciTR9xN/xfRhhADWwo/rYASsVIVNxSFWxOobx7yXKP1c+Bpi6BMIbxfUz420zyRMpZQFHB6BHd3WfxjQPqf1jNPHZmDUYRQpMTTU19CXEjkptaDSOYd6dXH6DImI2HUQ29YOqAdrOivupvUhWSNB54Rh8H4QYNZzVRTYqm/gVg37Pa+656dtStUnQzbc2CxxRbs1FSn1cnUSA2r6V9O2qlNmIU7IlmeJTr9oN0hk4dJ+lGG7VVVvTBnK9vx0uTtxi99mYbfNIH5biKJLsSjZrU0bpNMF24MMvsvbvniL0Kf7AjLR5L00jKJkDIS9HEL86Htup0AAjSmkJt38IXHg==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7ae095-22dd-4013-0f51-08dbefdefd2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 06:55:21.2164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40lQx3zyr9Z2U111dWTost6cOEgJbjyn35+2c7iv8dzFw47Zg3KYc7VplfK0J10HbfTPn99YCb9cBlsqJ7RO7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7709
X-Proofpoint-ORIG-GUID: 1L5VbkoR2ctHZWF4uZkXqpR1U_x8Oy3S
X-Proofpoint-GUID: 1L5VbkoR2ctHZWF4uZkXqpR1U_x8Oy3S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 1L5VbkoR2ctHZWF4uZkXqpR1U_x8Oy3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_05,2023-11-27_01,2023-05-22_02

PiBGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPiANCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAyNywgMjAyMyA4OjEyIEFNDQo+IFRvOiBNbywgWXVlemhhbmcgPFl1ZXpo
YW5nLk1vQHNvbnkuY29tPg0KPiBDYzogc2oxNTU3LnNlb0BzYW1zdW5nLmNvbTsgbGludXgtZnNk
ZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IFd1LCBBbmR5IDxBbmR5Lld1QHNvbnkuY29tPjsgQW95YW1h
LCBXYXRhcnUgKFNHQykgPFdhdGFydS5Bb3lhbWFAc29ueS5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgMS8yXSBleGZhdDogY2hhbmdlIHRvIGdldCBmaWxlIHNpemUgZnJvbSBEYXRhTGVu
Z3RoDQo+IA0KPiBbc25pcF0NCj4gPiArCW1hcF9iaChiaF9yZXN1bHQsIHNiLCBwaHlzKTsNCj4g
PiArCWlmIChidWZmZXJfZGVsYXkoYmhfcmVzdWx0KSkNCj4gPiArCQljbGVhcl9idWZmZXJfZGVs
YXkoYmhfcmVzdWx0KTsNCj4gPiArDQo+ID4gIAlpZiAoY3JlYXRlKSB7DQo+ID4gKwkJc2VjdG9y
X3QgdmFsaWRfYmxrczsNCj4gPiArDQo+ID4gKwkJdmFsaWRfYmxrcyA9IEVYRkFUX0JfVE9fQkxL
X1JPVU5EX1VQKGVpLT52YWxpZF9zaXplLCBzYik7DQo+ID4gKwkJaWYgKGlibG9jayA8IHZhbGlk
X2Jsa3MgJiYgaWJsb2NrICsgbWF4X2Jsb2NrcyA+PSB2YWxpZF9ibGtzKSB7DQo+ID4gKwkJCW1h
eF9ibG9ja3MgPSB2YWxpZF9ibGtzIC0gaWJsb2NrOw0KPiA+ICsJCQlnb3RvIGRvbmU7DQo+ID4g
KwkJfQ0KPiBJIGRvbid0IGtub3cgd2h5IHRoaXMgY2hlY2sgaXMgbmVlZGVkLiBBbmQgV2h5IGRv
IHlvdSBjYWxsDQo+IGV4ZmF0X21hcF9uZXdfYnVmZmVyKCkgYWJvdXQgPCB2YWxpZCBibG9ja3Mg
Pw0KDQpJZiBwYXJ0IG9mIGEgYmxvY2sgaGFzIGJlZW4gd3JpdHRlbiwgdGhlIHdyaXR0ZW4gcGFy
dCBuZWVkcyB0byBiZSByZWFkIG91dCBhbmQgdGhlIHVud3JpdHRlbiBwYXJ0IG5lZWRzIHRvIGJl
IHplcm9lZCBiZWZvcmUgd3JpdGluZy4NClNvIHVud3JpdHRlbiBhcmVhIGFuZCB3cml0dGVuIGFy
ZWEgbmVlZCB0byBiZSBtYXBwZWQgc2VwYXJhdGVseS4NCg0KVGhlcmUgaXMgbm8gbmVlZCB0byBj
YWxsIGV4ZmF0X21hcF9uZXdfYnVmZmVyKCkgaWYgaWJsb2NrICsgbWF4X2Jsb2NrcyA8IHZhbGlk
X2Jsa3MuDQpJIHdpbGwgdXBkYXRlIHRoZSBjb2RlLg0KDQo+ID4gKw0KPiA+ICAJCWVyciA9IGV4
ZmF0X21hcF9uZXdfYnVmZmVyKGVpLCBiaF9yZXN1bHQsIHBvcyk7DQo+ID4gIAkJaWYgKGVycikg
ew0KPiA+ICAJCQlleGZhdF9mc19lcnJvcihzYiwNCg==


Return-Path: <linux-fsdevel+bounces-4371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60E7FEF4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0D6B20C2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458004778D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LnV+Obvi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c+AGlNqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298979A;
	Thu, 30 Nov 2023 04:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701346912; x=1732882912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kHcZXIZWJWz+PinDfpIIyPEEO5nbujZZXRgKDhziyNw=;
  b=LnV+ObviwGAeOUEYxB42s2RL/VzigVQS6S4LpHh1iq5glJKjcbYq0y6v
   dnvck/ANm4RUuICAaMEMnOy6XMVTDSdGaCgh9MnE164L2cIEVWo+eVq9X
   ESk5gqscyM/E6gL6TK56symXm9LFs7w4ji0xjC4NwJao9x3qklYBrpyeX
   M1/f+2YlrsxkO7aCBvqDsnRnQx3ozr5yqW880fR+f6111gLvrXgmwNt9S
   3KxGKfDR0lTnu0skE+0CIuIS7O7/Gt181HDAQ7QET2w9Mm4liXw+MsZ7y
   RhUnKu4KfcEhQJuthD9bgdMHnTqnMzPMo6cLkFyyeylFVp70vbrd4dy/S
   w==;
X-CSE-ConnectionGUID: FJ2V5hPySvq1zPFMA3eIOQ==
X-CSE-MsgGUID: NkrQY2g/TZaqSvACv/N/Pw==
X-IronPort-AV: E=Sophos;i="6.04,239,1695657600"; 
   d="scan'208";a="3663141"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2023 20:21:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRKk8txiHmp5otQoouFsGfD3OVHMxlwvkG4xrm/zOW8lFzudiyAIHAThHQszjpX42jHOmnlW32d0iCv7giKzfWs/49q+Ox87nx+3obqsbxlcMt/j1cl1QJ2VgESQq8FPPcvQGSfSFRX6z64mo/uj+iW4m1XuQT+zEyOyHAnbWu0OEDd7emrffJoFnheyqEmL2ebbd2rh4VmiPab4zThoROTaylADeuOxsd7OUCUX9q/DLOr45+JTnCEq+bi8t64us3AejkZbcLe92STsmgM+4o8PJgB7Fv/6TrxNDrvPgyA/MKfCUkrAkq+5MJnYXgysFpFQHsG14ngz5s7L/F8ENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHcZXIZWJWz+PinDfpIIyPEEO5nbujZZXRgKDhziyNw=;
 b=TtEQMckAp/WZ0Em0yX5AO2gP6dTRKW7s768Exrv4N/ADLr4nM7WiQjZcQb9YTDuXtjoX5E73oxEUKJaI/PgpOfflodPhGmdr/lbOp0jS3qMYRNWQysqTlXz3GyeGRpezzys6i7XPk6EpiqYAGxN2hzZJ0pxbNaWdDRQGU5fmYFv9Sz4oA6N1ejEH5FhlkI7X4XCoV4RbcxYlLFtESFHbKuJMQHXP2/86SIX2vo5Q3caa575ib2z9JIfuy5FM910X1mUklHauOqd5puzKcnBO20S49HOwtURHfs+twDyOXFY3Aqy8SmyMhaNf6HRFHEc24dRy0yTKDsGtPmrPcoWt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHcZXIZWJWz+PinDfpIIyPEEO5nbujZZXRgKDhziyNw=;
 b=c+AGlNqbn4TS4ADbkULxiArv37awqbNICCbgD9OPPPfr9O/1eRBQbb3Wkq0j0miVA/nY8brtI6Q1k8QWjbYBUT58ZA+KYhZZ3KPejhCnx0/aHh2WRNO1vjp98I2F7lFG6wr41wWXfwQ4M3vC817T8v5I8f8lKBYQBPRAjm2XXuo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB8409.namprd04.prod.outlook.com (2603:10b6:303:140::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 12:21:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 12:21:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Daejun Park
	<daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Avri Altman
	<Avri.Altman@wdc.com>
Subject: Re: [PATCH v5 08/17] scsi: core: Query the Block Limits Extension VPD
 page
Thread-Topic: [PATCH v5 08/17] scsi: core: Query the Block Limits Extension
 VPD page
Thread-Index: AQHaIy1oBhIMvKhfkkiyr60v0i4KYrCSyTiA
Date: Thu, 30 Nov 2023 12:21:48 +0000
Message-ID: <19d99e61-9424-47e4-a70f-7664905615bc@wdc.com>
References: <20231130013322.175290-1-bvanassche@acm.org>
 <20231130013322.175290-9-bvanassche@acm.org>
In-Reply-To: <20231130013322.175290-9-bvanassche@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB8409:EE_
x-ms-office365-filtering-correlation-id: c00efec9-80fe-4d8f-78f6-08dbf19eed2b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LeErKDLnlwNl39rQ5Z7eYLSralVNkvijUc3eWNpgeb7TH1rmkCkv01U/ZYOC+TUb149ZgJD4mW4N4QkC9cQIwH7sl4/F1frhnuoOXMrCdCLLHMq/A6Ks3AtxOEn9ejjXzMSSI1bcSskgiIw/tWlDPwqtUfg5m3+gjf2DPvSR6F/rosUGDyAZx/cJSCuuavOZMn+5RdYwq4g1XM3umuMcjBYL6nzsgWERtXKR/ge1XLMd8iG6AkOPGROkmDSnxH87rhGO1waOKoNecZQIrHWe/QTbcXg4IcAahUN4fj+5Sy2HqEhu1+61iYJOWWbdHr/eBaaIcVxIaOeWDWxzCD6+mvCeANPOJVxPaDGaIbpS5yDYDqyvTiW605ZuWMtAy9UroWhf3O5U9o2km5hEuxRnaoNOpxsl34Avg378aGM8PYN7t/d2t+WBO/z77/ELa4/z1vEo1E/PSSbQZ/Nb+3cLJIoNttdy1aZ6ddQ19r55U+BkzrqndQT/hoOm/k1DIJyd6/DgbH5af/ioGoFyJyHhl7fEx+wDfgnA/h088vrVl8lTj4MTwqUbxoa1+xQow+scZFQLCHb7m79Pj8Z66VV4tu2O7MDukNXSwoNDCgTODpGgU1962eVkmcW8DyP0UcKYGM1MRDV0OpVR8isbuVUWMDNdTiKShJmEIj1WfClL6r23c2ldb4+yWQrShGLa+FSJNAuFE/aADajdGC9HC++wjGsXKecIyEcDP+kmVztH3ls=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(71200400001)(6506007)(6512007)(53546011)(83380400001)(5660300002)(4744005)(2906002)(41300700001)(478600001)(6486002)(110136005)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(76116006)(64756008)(54906003)(316002)(91956017)(66446008)(82960400001)(122000001)(86362001)(31696002)(38100700002)(38070700009)(36756003)(202311291699003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWFtSkp0QkxDOXZPMXRJYk9oZHJRck9odXJJTFh4S2NNUDRFL25YUDEzbldj?=
 =?utf-8?B?ajlTdFJOUFhMbHpxMWRoamtUSXRsRUdPVzZ6RlJrSzRkZjlrVENGbzI4d2FV?=
 =?utf-8?B?SGxwMkVGN2RzUkFtRmlQUzA1S1A4S1gzZVFsd1RmZ1NRVlB1bjdlRnROWEN0?=
 =?utf-8?B?Z3NUR3VVUzRaamI1QXUzdWV0M2E3ZEpTNWU5dGxCVlh2WTRldTlaMTRuVWhx?=
 =?utf-8?B?bUlLaEVmUStwelpEdWpRVVhaK2FKckN5b0duZXBIOW1xalRlYWY5QVJoRk1E?=
 =?utf-8?B?dm5Eb1lJakszdmY3QW9hdmdTazc2VDdaWDRPZ3lHcU1TZXM2U3JOQXI2T1BJ?=
 =?utf-8?B?OXIvVjNrN3daQUFPcFczbjk5ZEJsZXhnaFdpSFBTVHpBN3NVaUg3Y3pYZEdN?=
 =?utf-8?B?N0cydkd6Z1BBb3I2bkdRS1ZkcjhoV3VUcnFXMWtiakNwMjYrdjl5ZExVYXdx?=
 =?utf-8?B?QXFMU1VGVGtBOHFUL1k4a0pFaWkzUlZ4d2ZhZTdYMitnZjNWcWR2NGZXbW1C?=
 =?utf-8?B?OWhQbitteDJEYytNU3BEOWZ0cmxYTkQ5ZnRSc1Z3YjB5Qm1BakFQbWtCRTNX?=
 =?utf-8?B?K2VUMElSR043c1A0b2I3ZnV1Um91YWd4MVNNMGtHWDIzaFZWOThiRjZqNEpa?=
 =?utf-8?B?OEx5MWx3QVRQd2FZS2FJNGZPUis5UHVtVk5FU0lTdVgzdzJlRjdEMWhlbEZY?=
 =?utf-8?B?S2VnNFNSd2NockJQMHpGZXhxRXRlS3VZN2NTbVF1Wm4vQ3B3SzBZbVZtTTZD?=
 =?utf-8?B?Qk1nQ3htcVphMXdPV2k4b1MwTnVFRmRFbW15UXNUMVR6Ym5Mc1ZneWQ3eVo4?=
 =?utf-8?B?YjF2Qm8xSWF2RytsWXlNSTMra0NGSDVHL0ZNU3ZNc0FBd29acU1wdUhJSHl3?=
 =?utf-8?B?MTN3bndUenluZlk1Q2s3QWphUmQ4YVRiWHdtT3g5dFQvQldoQXp5MTl3U3po?=
 =?utf-8?B?OWtBd3FhNGRPZ3c4UUVzUFNzRFQ3eWZXYWtiV2VsNVI3d1hwU2Z0M1FoUlFy?=
 =?utf-8?B?a2h3RVBPT3hOc25pVS9YTTg0dVpxQThxWHExbmNuNEN2a2JlTHlLNSsrZDhp?=
 =?utf-8?B?NHJMWWV1ZXVJVzRCZnFFcnFZeWVGTkdyN0k0WVRmbjZpK2p5b3RFNzBBN0t4?=
 =?utf-8?B?SHdsUG13b3g4Ukg0TFJZVm5yRWJMVlpyL3Q1bk1RYWE5UmhvVUViYU0wQUtS?=
 =?utf-8?B?Nk5JVCtjNUJpV3pCVmVadkxXWHF4bzl1bFNoU3BSU2JLaFh1LzJhTXFDMVBY?=
 =?utf-8?B?bjBvRXJ5WGhWd1IzUnZaYnVqM002VTMvUjBqaFgvRXZjRWtIcVdqd21LV3M3?=
 =?utf-8?B?VGFUWUZ3aU9IM0g5cGZPZlVrNVpFcG8rNlpkSGlLbXZDMFhRY3lWMjZjUjg1?=
 =?utf-8?B?SyszMFBzM2tjMWM3c255TDZBKzlwTTRnOTJYVStubUNoTWo3VkY4Z2dCYi91?=
 =?utf-8?B?SmxOWTczeDg0bVRQU2VENzJHcTdGeG83KzQyNjdweGVQTXVtTDh1Y3pqOCsw?=
 =?utf-8?B?RWx3T3FFdU9COWZ2MmJ5L3JEb3ZVZ0pDMzFZQ3hHSXRLamFiQkRjUy9RakZx?=
 =?utf-8?B?U1VxTmRhb1N0SVliamdpbDVraVFWVWxIdkcrcys1UWx2ZU9FRGpIYUZpVDND?=
 =?utf-8?B?SkhRTFV1NFpPazNXc0piZ09aYU1VM1FoYkJja254dm91MUdmTjZsRG1nNGgx?=
 =?utf-8?B?QTlpaUdNUXIvZkZTMVFKWGpxUXNjZ0tiZkFodk43ZVlUa0RocG5TbTRsSUlW?=
 =?utf-8?B?c2tQRnJLMnBFb2l2b1M5SUZPT1pxSTl6MXpFTkJEWnRsaVdsdzNlcVVQc2or?=
 =?utf-8?B?cFoweFo3MDNEaU5YVjFlMmwrS2NLTEJaWGd5c0tzazBBRTU0V2ZsYUY3YkNZ?=
 =?utf-8?B?ODd1Z2hBcFhNeThoRXlRZVNSOTZ5YkxieHVDUlZpZDBsODJFNml1bEY5a1ZV?=
 =?utf-8?B?YzdoZ2dNZ3RkTzI4WWs3M1dPOFVNZDNzcmR6Y1V2S1FNeCsrSzRNNy9UVHdu?=
 =?utf-8?B?bHVQTEpubFFFaVZDUW11cmFqMXhIVEhTUitYdVFvMzdCMUROenZGN2RoNHBk?=
 =?utf-8?B?QzVUYXY4UXMvOW5OWFdkMVBCTHIwZ0RlOExrNnVYdyt5QzdXRUdQYWdtYXcr?=
 =?utf-8?B?eitmQkVRMWZwZ1p2d2hqMHA4YzlmYUtiL2FaUStFMmVBbW1FMVlrMlBhRnZh?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A1B27EBDF9A794AB0BF92EA73BAE006@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QADpamWyXRTgZs1+12uBUO4T2xG3yw7yFOGuBA3hUT3R8/NtQu9m4NeHP1Mugh/71eQGV6HJeHGQeY4AR8ZCQP0ytHPd7Tt9K9oxQRlXfmwsLeeG/chvj4lXAvOfjwAj4K8gWe6LShvy3of0PUvd9T+G17wFRnbu1IxHYxSfUdzlwq/heDes1oJFumAkIAVsZ/94AsS+aS4CT1fNfptRMIgu+d8ZmK0J6wPYb6se/BX2c9DyZHwO7UBlYaHxUrlzjrP5rvHfKP6SbfZMlb/O/m6FLe1YtMnOTYychjLG8xniXiQx415+8sQ8iB/1PZpCozqIN/QOwh7twHuP8FIZneP4waZ5cCnYfV6W5WBImFeIyFYqXHDunoxbhhDCxMiFHfCsZQpg2Rjudb3RoHI6I+n9Igz3WxjGWP9ABo1gKVunzOCedSDiDWg7+sdreVdXAka/a9CzWUyeLhBnWNZPSn2qxqf1qiDqp5VneYzV/M4Ean6BwKwJyZhPYVdkCUtb4Mc4BXe6y8szRTVh8QIY/83QIGNFro0jMzlJxPxdkSaYLs9mBjMQXShHmF0HHAEmSNKnlU+wzMQchdo1FTEeNPP74eodh8DxTtxpUIIcT7xalgItp3VLBg4HCijUbXw3NywacuNRj333PYDsE8XXwuStzd//25VCnWHm1hTebHqeA9s3ReAMpfDvzxP2BiESgaunbcpHOYjvGT7+sfGcTXk3rCmuKpVZWeNwxHbmLKxubfMqe709oAqft7Vtj2LTfsYQOALADFiG5uS4jPIP4jlAgbrv5knhA1JuexnyIDfxUpFV4JpkjzJQusc2fKwviQM7/GCzP3THFj0nPKlWrceV8GUV2VN2wDtpx97nVQizMS1k5pIw2/cSmpQj1vhj77alBXUiiFQVj5/ojkR4lKAZ39sAXy/xJPcws68auFE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00efec9-80fe-4d8f-78f6-08dbf19eed2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 12:21:48.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFKl69OHqdWgWiChS1NOLpxyvEKQwoKovm9P790FsG4lPnZqmgYQFOT2MBw6VkU7CV1oTPtrhZDsJSGu+jaWzLaLWNZooSw3LyXL0hrqYTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8409

T24gMzAuMTEuMjMgMDI6MzQsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc2NzaS9zZC5oIGIvZHJpdmVycy9zY3NpL3NkLmgNCj4gaW5kZXggNDA5ZGRhNTM1
MGQxLi5lNDUzOTEyMmYyYTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc2NzaS9zZC5oDQo+ICsr
KyBiL2RyaXZlcnMvc2NzaS9zZC5oDQo+IEBAIC0xNTEsNiArMTUxLDcgQEAgc3RydWN0IHNjc2lf
ZGlzayB7DQo+ICAgCXVuc2lnbmVkCXVyc3dyeiA6IDE7DQo+ICAgCXVuc2lnbmVkCXNlY3VyaXR5
IDogMTsNCj4gICAJdW5zaWduZWQJaWdub3JlX21lZGl1bV9hY2Nlc3NfZXJyb3JzIDogMTsNCj4g
Kwlib29sCQlyc2NzIDogMTsgLyogcmVkdWNlZCBzdHJlYW0gY29udHJvbCBzdXBwb3J0ICovDQoN
CkhpIEJhcnQsDQoNClN0dXBpZCBxdWVzdGlvbiwgZGlkIHlvdSBpbnRlbnRpb25hbGx5IGRvIGEg
Ym9vbGVhbiBiaXRmaWxlZD8gSSdtIGp1c3QgDQphc2tpbmcgYXMgSSd2ZSBuZXZlciBzZWVuIHNv
bWV0aGluZyBsaWtlIHRoaXMgYmVmb3JlIGFuZCBpdCBkb2Vzbid0IG1ha2UgDQp0byBtdWNoIHNl
bnNlIHRvIG1lIGVpdGhlci4NCg0KVGhhbmtzLA0KCUpvaGFubmVzDQoNCg==


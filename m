Return-Path: <linux-fsdevel+bounces-9901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC7845D19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89D81F26E08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE015F32F;
	Thu,  1 Feb 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="y5Rg0K8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A815F30B;
	Thu,  1 Feb 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804271; cv=fail; b=MUgaml+9r1HDU02Kmd6Vysxlm9ngzPMNRSIlKbHF2nvi9vV9VnTqQJrbSmb/nRWk6Kt7R+xEkfbBvinUGHJbiNf8SlVUHU4c3IuTqdscfFBe8FfIZyhYSYtR92TPQoaTztMzTB3fucam/FFum20XfcW3nLXbpUv2Tz7nTCcKAiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804271; c=relaxed/simple;
	bh=WRGKb5PkE/vxgyBWS4nR5ySH7KrFZuFAG5RZ7Xr5dQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8wIcl6m+/gPRWlP5IHIfTk2dMnHLEkFlJNWGwNOuepiqXD8i0q9hPQLrVnoJY+1i4WI4H8iXu+upVHGyv/NNfBKbdg+IG2S7a5SjGNUT47LJUbh92okDbXjVFw28zY5a3D3i9j/kFJG7FZoOzggm1h331g/dJo9eSDmsFgK1Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=y5Rg0K8g; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41]) by mx-outbound20-53.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 01 Feb 2024 16:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmIAGdlN5pBsm44OfF/ZkgiKuHMwtIH1LfNtmalzKsH9YjV3PavCd9GJf8P2V54RJLmNwdM6SYhPybJFGSCfznzR5vGa1NRRzuKMFXU5JJSYmt7rVHHtQ48GzKWHZUOTzp5pG/6ZbKLXNuvCmMHtf/R7jTBtyR4UIrnRK/301DTfgYWTkioPB7sxGV0Xv/U/qeBdoT/VXqe0uFT54aRVTohLfTN8U/EDuUeiXAKJfmrQwq/ZX3eDgQK7xieVZ1B0HmJXeoeA9lyfgRmhp/t8WXrGBJit05C8gsLm2A1ub4832d6D23aaH1C1/wTeJjZV8+D0UBpd3wx852G2+c3wZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRGKb5PkE/vxgyBWS4nR5ySH7KrFZuFAG5RZ7Xr5dQY=;
 b=hstfsmTdxcX+GKFxwuhc1Vus4WMuihhtO4rdd5b+e5AlBcWxdIps5oaO4VOOf9/hMk8gcemllWHxnF1H/QIy9pM7SCL3R8zszJQM418XM2TTFFT7vvykXDTTcYrBsnBa0v7USu+/5hV1244YNZJoPEkonIYdsQiWjA32D95yFdDrVqwHH6z8mV98MbkKJ2B6jyjhHfqrRtP70sNcwWoL73Gdj1R2kc8sf9JRsT8LO2LgWAwqG3BGsSN28m8jSj980rNRd5PjfJBI6Qz6Ko6ejzyXfi+UFKFF5HQT4sw3TMIVMFMrGJBYABw0jlGqLs/HpqNcoeP/af52lmswSblDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRGKb5PkE/vxgyBWS4nR5ySH7KrFZuFAG5RZ7Xr5dQY=;
 b=y5Rg0K8g5nzfDuQyvrN0bAPBvlTqgxcsOaBZqN3h1MPfgjYC9Hb9znjTDkInXWXc7ASngygSljgD6ZPkuHuaPRzDwg4pvIxcrVFG4BO6xgdRuRm4wnyilpU/W1UuWn6obSSrGh5yyiwJNnKvyVpvkYR3N0koJOflCGYzdp0keyE=
Received: from SJ2PR19MB7577.namprd19.prod.outlook.com (2603:10b6:a03:4d2::17)
 by MN2PR19MB3855.namprd19.prod.outlook.com (2603:10b6:208:1e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 16:16:38 +0000
Received: from SJ2PR19MB7577.namprd19.prod.outlook.com
 ([fe80::9270:8260:3771:ff45]) by SJ2PR19MB7577.namprd19.prod.outlook.com
 ([fe80::9270:8260:3771:ff45%4]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 16:16:38 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bernd.schubert@fastmail.fm>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Dharmendra
 Singh <dsingh@ddn.com>, Hao Xu <howeyxu@tencent.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Thread-Topic: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Thread-Index:
 AQHaVJp6pCpUGVTRIEOO0QTX1flKZ7D1LPKAgABh1QCAAASIgIAADU4AgAAA2QCAAAGEAIAAB+CA
Date: Thu, 1 Feb 2024 16:16:37 +0000
Message-ID: <d6322d14-9981-440d-9b93-b3e443536b9f@ddn.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
 <20240131230827.207552-2-bschubert@ddn.com>
 <CAJfpegsU25pNx9KA0+9HiVLzd2NeSLvzfbXjcFNxT9gpfogjjg@mail.gmail.com>
 <0d74c391-895c-4481-8f95-8411c706be83@fastmail.fm>
 <CAJfpegvRcpJCqMXpqdW5FtAtgO0_YTgbEkYYRHwSfH+7MxpmJA@mail.gmail.com>
 <95baad1f-c4d3-4c7c-a842-2b51e7351ca1@ddn.com>
 <CAJfpegtd1WehXkvLWfbBvFLVYO2nBgWSoq=3Zp-Kmr0spus4zQ@mail.gmail.com>
 <CAOQ4uxi-iptWYOqmsDZFkhPG03Uf=2bHqL_0570cmVOUyhtT-Q@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxi-iptWYOqmsDZFkhPG03Uf=2bHqL_0570cmVOUyhtT-Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR19MB7577:EE_|MN2PR19MB3855:EE_
x-ms-office365-filtering-correlation-id: 3ffcdaf3-cb88-46ee-8aad-08dc23412aef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H5YKHsHqLZyHzjb5kwv0LsWY3L8VUMxRb/CL3yD9qWECPQcV67bT/TPTa2a3DEZmAkLZt55Z8wT4MIjFSMPLuRYag4/5CtxBvL4lrhy//yNSgTyb3xmH6cfInMA2/OJSn/zWTewxSsISj4onswcTFGrkFnO7BvrsWNGefFSX4TMa7EGkZVMl0Hh9n5rYzyzKJ9J6CtoNWETSnrwBVlr1qvgRpnW8VLi/VojH5K6SIF2Udr7SQatJ2fvZONmn8is5JXKaneNC3Uc6VAi/urLHqd3Ef/W488iMr2lnuk34aKQuzXTm+Fy6CM9mDZW9wQe6fPSrnUIvGyegN/bZdttGn8P6RMv5BizS5RSDbE8uJdYzCBA0X1evciTvqVL1kiTaq2VflqLWdqy1COxE14HmQ7DCZZQoynr6qsGu96p5CA13jQv9NhslONg9OAiJNBiR+IJ8KWvOawNXz3Nsj2YuulD6E28mBFHLY50jkQcnWvAhWeOzsJ2zx9ZFBI3neDQds6bSLDyhdhYS0TxYoBASYPkn+Q2gMr4CZ6PQKF+OR6g7HrbCgpHkV9ZOWnxyB6eAKrO3z2ytc3iKKSY6b55DDs/u7s2kbjX69PGq/riEkAqAkWs0NPia1dK8v5TYAAKCLNNHz6yaxtCc1KdAg0h33PjbPVc3wj6lQDEhvtPR62c5AU3zjAhatfzZ6HG+rsaH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR19MB7577.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39850400004)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(2616005)(478600001)(71200400001)(6512007)(4326008)(6506007)(41300700001)(8676002)(6486002)(38100700002)(122000001)(36756003)(8936002)(316002)(66946007)(66446008)(66476007)(64756008)(66556008)(54906003)(2906002)(31686004)(5660300002)(53546011)(38070700009)(86362001)(110136005)(91956017)(76116006)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1Z4WWFTTkJxazZhZVBYM0YzWlVuMVB4dXh4T0FFUU1ta3Y4OEJXSS9Pd2VV?=
 =?utf-8?B?ZEFqQlhCUkFXSThFN0FoY3lkclI1L3hOdFJQelRKUmo4dGN5V3hlOVNkU2h2?=
 =?utf-8?B?dDRDcE1EQTdBVUZFSkNqZ2JVazNrbkRyZWRFOVNvbHdCWktOeUNtcjR5M3dK?=
 =?utf-8?B?VHdSUHRCQnprUHVPZ0NUT29yR2NzanpBOUdFRUdKL2RETnZUckNmaWwvYURJ?=
 =?utf-8?B?eDZQTzZwbjRBaWZXN3dTc0RXN3BieG9sRHh3eDdjZTBrb3dhemRtWTdDKzY3?=
 =?utf-8?B?czhpaXkxcUNjUDdmdFdHUEN5S1luVmJsNWZ0bVBYZzNHWXYvMkVrTWxLZGNR?=
 =?utf-8?B?K1FiSHlMY3RXMnRGVGowTHp1L1lKdUJrKzRYNWZ2eUIwSnNEN3pmeTEwUVAr?=
 =?utf-8?B?TmVDYWZqVXRISUtYRTFqekZ6ZmFpQ0U5RFdoVzRXL3dqVFcyV3E1ajRRS3hO?=
 =?utf-8?B?a3lPc0JIVy9ZWnBkNzJ5aWRXTUoxaHh5V245ckZJcTlqUEJtVDRiMVJjSWZp?=
 =?utf-8?B?RTBiaW15aEFDWmxSUkFXU0tySkd3NXBXdCt0azFZb1JWZSthR1JTaTEyZVM0?=
 =?utf-8?B?NWxwVDFXRjhuQ0Yxd0cxdWh4emRGYXFmbklnUElCQTlmUnlqWkx1Z0UySE4r?=
 =?utf-8?B?Zy9adjZTY0ZQcy9TQ3NqWDZvclJ1NXBacDZFRFZiYnVINk9nZXN6SmxRUVow?=
 =?utf-8?B?d2tTeVF3UlYyMmluRGk0OTV2RWxXTDZINXRXRE9BMEVYT2RNMzJHckFtQ3JR?=
 =?utf-8?B?TGorQyttRkk0ZnNqTm5rY3Q5ajQ2L3Y5dVJoZVBDdy96TUxUTG81dTk3cFlZ?=
 =?utf-8?B?NHpZQlBndnEzM3NySy9KbXNieXpjMFUrdHAzQ2pFdDBXZXdhTDJJSzdOelZ0?=
 =?utf-8?B?R2N4TEIvczQ3cG05bnVzU25Tc1FzaXJvd0FoYW1RYkxQQUYva1I3VUpya0xN?=
 =?utf-8?B?TVY3M1ZxM20vV2xRZjhkeTJGQ1YwUGxvdzZmUDdkOW5mNmxZVkxlL29NWTdo?=
 =?utf-8?B?cFhqeU9VZDFMT2dxTDBhUEg4MUJtYW4zOVFzT2Z6a3kybUJvRy9nWlp6Ni91?=
 =?utf-8?B?SVNKUjIyWitNcnRDeUY5ZVREWVFiYlhrMEprQWxlL2RneTZKbG5xMSsva3g0?=
 =?utf-8?B?OSt4NmNZSGRURFo5MGNiTHhVaEF6WS8xbFBjNFF6dzNxZmZZU3QxanF6MnBG?=
 =?utf-8?B?M0ZGbnVaWnJUMGVRcHZKaHVXQ21NM3dkUk9FR0RLUXpMRWxtZy91WHdzYlht?=
 =?utf-8?B?SUNBajhTUzkxR2ZHU0tuVDV6Ujc2R0tjdm85cWVhcUxvaEF2U0VTemJVSTZr?=
 =?utf-8?B?aWpTVjRQU29GZGhVUEpxQmdxUnlMdGgyMHZjQW52L21hZ25scERWb0poNGp6?=
 =?utf-8?B?cngyMEhOUjNQVmRtazJpSGhyUHB2RGdxVGN3SnF0aHZCcnNxRkxVVkJEMVp3?=
 =?utf-8?B?WDF0Z21LTUhjUGVZREtEallmR20xa1gyaERmWEo1V2RPR2xzNTIrVzVnQWJB?=
 =?utf-8?B?Yks4blFVTWFaQlR1MHR3N1llV1BUdnloV0lvYVJCQ3U5WjlKS1dma1BDb3Rv?=
 =?utf-8?B?ZmF1NGozQ2thUk52SFNHRlZwWTZiaUFpcXpMcmFRZDRsSFBIT2Rjek1OMG4w?=
 =?utf-8?B?a3lzQjNITTd5WDl1UGFYYmQrcHgwNStMeUJDTmx3RTRlMy9CT1EvRCtsWVFr?=
 =?utf-8?B?YklRalhEcnZhS2JoaFBqMVZMMU11REUzeWg4M09DTzdub2xjMDEwcUJRbGgw?=
 =?utf-8?B?VXhmY3ZCTFJRQXJHQmFqQnFCc0FYb0grVS9vZGJhZ3pnMnFmZStJYU1lekpJ?=
 =?utf-8?B?SW9ua1BTYUFVa01aUTJMOFYvSExDbGJWL1NwVHJmQ3ltRks0R3NLbXNHS1Fm?=
 =?utf-8?B?WkZsdlpOenRPUlo0WXNRYU5Qa3dGWDI2ZVg2ckhxWG1uTnhaNXZIeFQ5em5Q?=
 =?utf-8?B?OVByd3hPbXRlVE9QaWYwdE51R3RVb0NvNVFJL3FvY1ljVTFUcnRCQ0VVMnN3?=
 =?utf-8?B?ekVORS8xY2p0RFg5dHdnZnJwK1p0b2FsK0tUMGx6S1o4YjFkZ21vZ3FWTWI0?=
 =?utf-8?B?d05maXlrMDMwUFFWV2gvOWNIbXRONGxuRVFpdVg4bEMzeVdFWDBSNEQ3Sm16?=
 =?utf-8?Q?OUNg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4641CE1347DC94F996CB8F19B9BE371@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sLUfLdw1DyzirD7oSMQVmZx/uRE98RYDauYVb8jctWXuLQSPG4LJrDwu/cGWvLdin8i4AX+MKp2d8y7mdtxcNxmLI4hXEd+37VaES9lgqp9WklRI18WmrEcQHoC1gtPobBXZp3I8bhDUI78zjEvKjcuU4PkfN+Km/iV9uTGykZugJZzlPOcpP0lbrrKjngNXj6dM4gyBC8GPi+iIsp3NY9MMvP0sI+zXYawBlFr10OUHyBVAdnkJxkPGEZnONomMgX3yeIXKFhHBJJeM3jFowO4Ut6VC0Mk6jHoDwl0E3m+VgrGbl66MOciWxR20ZfbxQ8VPrIF5ojXkKqn612KHYimj+e/CBWa98CSuypQocAWhaYge2jUHAMcThILpzdvJMIlAvftWzr4r10XTq9mnvw225kdc8cp+ysdfJo0JIJ0CFiVo/IaeJwSilBtIUonYWk7J5UxMVGfpn+hVKB0lIaJtBTFywwc7u9dyf68F5a0OMq+9f1gm4FK7oWK95oNBNDv97gzXwz4K1QUNxmgklHGCFcmzNuD5DMJM8huivVbCSJLlAqG8Kc5tVuXHZP1dvJn1IlN7LZaHuhnrr5f6mxFxW5RtQBOtto02GWRkHhACkenLVlAzpgFRFkIdM77dMEc2klJUrhJ0LWzxTD7HJQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR19MB7577.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffcdaf3-cb88-46ee-8aad-08dc23412aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 16:16:37.9611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIuuFzMj8iVdnn0yFKUt2wMAZT9fDBRPkypaBuFKRDFgvn8Wh/PgEsldgFyYGCf/0Aq5uhUI1s35Zhxd9q6Tfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3855
X-BESS-ID: 1706804200-105173-12450-32274-1
X-BESS-VER: 2019.1_20240130.2130
X-BESS-Apparent-Source-IP: 104.47.56.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGpoZAVgZQMDnVMinV1NzczN
	zCMtHIwMDMLDHN1DTZ0CIFyDU1NFCqjQUAn1jVqEEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253914 [from 
	cloudscan12-33.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMi8xLzI0IDE2OjQ4LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gT24gVGh1LCBGZWIgMSwg
MjAyNCBhdCA1OjQz4oCvUE0gTWlrbG9zIFN6ZXJlZGkgPG1pa2xvc0BzemVyZWRpLmh1PiB3cm90
ZToNCj4+DQo+PiBPbiBUaHUsIDEgRmViIDIwMjQgYXQgMTY6NDAsIEJlcm5kIFNjaHViZXJ0IDxi
c2NodWJlcnRAZGRuLmNvbT4gd3JvdGU6DQo+Pg0KPj4+IEdpdmVuDQo+Pj4gLU4gbnVtb3BzOiB0
b3RhbCAjIG9wZXJhdGlvbnMgdG8gZG8gKGRlZmF1bHQgaW5maW5pdHkpDQo+Pj4NCj4+PiBIb3cg
bG9uZyBkbyB5b3UgdGhpbmsgSSBzaG91bGQgcnVuIGl0PyBNYXliZSBzb21ldGhpbmcgbGlrZSAz
IGhvdXJzDQo+Pj4gKC0tZHVyYXRpb249JCgzICogNjAgKiA2MCkpPw0KPj4NCj4+IEkgdXNlZCAt
TjEwMDAwMDAuICBJZiB0aGVyZSB3ZXJlIGFueSBpc3N1ZXMgdGhleSB1c3VhbGx5IHRyaWdnZXJl
ZCBtdWNoIGVhcmxpZXIuDQo+Pg0KPiANCj4gTm90ZSB0aGF0IGF0IGxlYXN0IHRoZXNlIGZzdGVz
dHMgcnVuIGZzeCBpbiBzZXZlcmFsIGNvbmZpZ3VyYXRpb25zOg0KPiANCj4gJCBncmVwIGJlZ2lu
IGBnaXQgZ3JlcCAtbCBydW5fZnN4IHRlc3RzL2dlbmVyaWMvYA0KPiB0ZXN0cy9nZW5lcmljLzA5
MTpfYmVnaW5fZnN0ZXN0IHJ3IGF1dG8gcXVpY2sNCj4gdGVzdHMvZ2VuZXJpYy8yNjM6X2JlZ2lu
X2ZzdGVzdCBydyBhdXRvIHF1aWNrDQo+IHRlc3RzL2dlbmVyaWMvNDY5Ol9iZWdpbl9mc3Rlc3Qg
YXV0byBxdWljayBwdW5jaCB6ZXJvIHByZWFsbG9jDQo+IHRlc3RzL2dlbmVyaWMvNTIxOl9iZWdp
bl9mc3Rlc3Qgc29hayBsb25nX3J3IHNtb2tldGVzdA0KPiB0ZXN0cy9nZW5lcmljLzUyMjpfYmVn
aW5fZnN0ZXN0IHNvYWsgbG9uZ19ydyBzbW9rZXRlc3QNCj4gdGVzdHMvZ2VuZXJpYy82MTY6X2Jl
Z2luX2ZzdGVzdCBhdXRvIHJ3IGlvX3VyaW5nIHN0cmVzcyBzb2FrDQo+IHRlc3RzL2dlbmVyaWMv
NjE3Ol9iZWdpbl9mc3Rlc3QgYXV0byBydyBpb191cmluZyBzdHJlc3Mgc29haw0KPiANCj4gQmVy
bmQsIHlvdSd2ZSBwcm9iYWJseSBhbHJlYWR5IHJhbiB0aGVtIGlmIHlvdSBhcmUgcnVubmluZyBh
dXRvLCBxdWljaw0KPiBvciBydyB0ZXN0IGdyb3Vwcy4NCj4gDQo+IFBvc3NpYmx5IHlvdSB3YW50
IHRvIHRyeSBhbmQgcnVuIGFsc28gdGhlIC1nIHNvYWsubG9uZ19ydyB0ZXN0cy4NCj4gDQo+IFRo
ZXkgdXNlIG5yX29wcz0kKCgxMDAwMDAwICogVElNRV9GQUNUT1IpKQ0KDQoNCkkgZGlkbid0IGNo
ZWNrIHlldCB3aGF0IGlzIHRoZSBhY3R1YWwgdmFsdWUsIGJ1dCBUSU1FX0ZBQ1RPUiBtdXN0IGJl
IA0Kc21hbGxlciB0aGFuIDEgLSB1c2luZyAiLU4xMDAwMDAwIiBpcyB0YWtpbmcgcXVpdGUgc29t
ZSB0aW1lLiBJIHNob3VsZCANCmhhdmUgc3RhcnRlZCBpbiBzY3JlZW4uIFNvbWUgb2YgdGhlIHRl
c3RzIGFyZSBtYXJrZWQgYXMgZmFpbGVkLCBsaWtlDQoNCmdlbmVyaWMvMjYzOg0KICAgICArbWFp
bjogZmlsZXN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IGZhbGxvY2F0ZSBtb2RlIA0KRkFMTE9DX0ZM
X0tFRVBfU0laRSwgZGlzYWJsaW5nIQ0KICAgICArbWFpbjogZmlsZXN5c3RlbSBkb2VzIG5vdCBz
dXBwb3J0IGZhbGxvY2F0ZSBtb2RlIA0KRkFMTE9DX0ZMX1BVTkNIX0hPTEUgfCBGQUxMT0NfRkxf
S0VFUF9TSVpFLCBkaXNhYmxpbmchDQogICAgICttYWluOiBmaWxlc3lzdGVtIGRvZXMgbm90IHN1
cHBvcnQgZmFsbG9jYXRlIG1vZGUgDQpGQUxMT0NfRkxfWkVST19SQU5HRSwgZGlzYWJsaW5nIQ0K
DQoNCkFsdGhvdWdoIHRoZSB0ZXN0IHJ1bnMNCg0KZ2VuZXJpYy80NjkgN3MgLi4uIFtub3QgcnVu
XSB4ZnNfaW8gZmFsbG9jIC1rIGZhaWxlZCAob2xkIGtlcm5lbC93cm9uZyBmcz8pDQoNCg0KZ2Vu
ZXJpYy81MjENCmdlbmVyaWMvNTIyDQotLT4gU29tZWhvdyBub3QgaW4gdGhlIG91dHB1dCBsaXN0
IGF0IGFsbC4gQWggSSBzZWUsIHRoYXQgbmVlZHMgIi1nIA0Kc29hay5sb25nX3J3Ig0KDQoNCg0K
R29pbmcgdG8gYWRkIHRoZSB0aGUgc29hay5sb25nIG9wdGlvbiB0byB0aGUgdGVzdHMgYW5kIHdp
bGwgcnVuIGFnYWluLCANCm9uY2UgY3VycmVudCBmc3ggaXMgb3Zlci4NCg0KDQpUaGFua3MsDQpC
ZXJuZA0K


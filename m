Return-Path: <linux-fsdevel+bounces-33237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455D49B5B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0208D28437E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 06:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8E1D0E35;
	Wed, 30 Oct 2024 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="R18ilEUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78D1D0F74
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268769; cv=fail; b=CHHTBTNUpFBUhcj/YohDFEF2HYu8td1/uo2/ZHF4/T7H71JbcK/9gwi9EqP/zY2R3VLISlnXkobJQGTLfvszuoL+i6DdEcLp9xRhLweRIPcG39T7+47x+kKcgO/iPL7Lhf7I9+fd88hhhvx3hKSb6NPNBZx/drxiURvcZfng+Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268769; c=relaxed/simple;
	bh=HLLAjmP0VQImJyvzcMRKGxpig8Eevi73YdUOjHllyV4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=irTlhlAr6H5Gp7JnOAf5e9bQ3FnTGAX2pGZ286JxLSOjG+s4b5MW6AVYaLaLTnxsRi4hj5fU6Y3caOXkHAVMvjdTEPAeEZfUTqFElhFArHoSLyeiFmRgjJ+e4Az9+tKY/Leq26U7QTR9zcK2lc/TRvVP7TH+JKrD9fnay5Hlj7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=R18ilEUv; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U5rtij020979;
	Wed, 30 Oct 2024 06:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=HLLAjmP0VQImJyvzcMRKGxpig8Eev
	i73YdUOjHllyV4=; b=R18ilEUvwCO5J/MdWYusrZ8Aa/NRkHfIDl8zG2QrUw8cG
	9hXq2MVhdiPSooR/u+anQDWBqE69faCD/ewVnakHgAg7/KV1JJ3oqPvecu2UVaTc
	o9zfGeXc9ZjQGjJ9cVgaajq3BLk95T6TIEg/NuHQETFafPNtekD/gBXYJFQ3hZvj
	DDywlKKpYKkZjwAzZBPw7TxQf9yTbYh+gyy9XzhlqH2rGbNadbC3YAtbcJ6oTATz
	PHK/w4QR2A9Q+5cnPj1WiPnfSvJJl4fIUBxesaZAzuJrYtp5s9EHKvieyqHQAU4n
	8QvqAiDsew3cSEDM5//4e4XLW0WaKfci0TZjNjIsA==
Received: from hk3pr03cu002.outbound.protection.outlook.com (mail-eastasiaazlp17011029.outbound.protection.outlook.com [40.93.128.29])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42k2yq8hs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 06:12:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mblONxvEn9lvPuOARpABdha9Tk/4ydvfyMhZkdYCCG4eSB3Iaw8m+wBwCLz0dwAFn0wOkPg+yjFR84VVYY9V4HBDqZd1fwbcn/SqliUUFibNRJeZCeKNoMkrmgh7zbsDWLwSOdz3SJNkXKPeYStmaUvg66pR7w3pKAeo5bkxfNZXgcfl9q2PV0z3rxZ9hycfCer5CtWRGemdEdVt0iGm9b0QfhfVb25lc7g3Y4WKK3dze6kbuxSz0ah+yMgngNOyFDycWUtLR0xOvOu6oe61WZJ+WxkzSy37xuF8GxMfayJ2xdFmpxk40lhyEJWTpmsGufOXs5bVgVdVCqVcRJa+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLLAjmP0VQImJyvzcMRKGxpig8Eevi73YdUOjHllyV4=;
 b=JPHnXM2Q7Mp093OJkHm7oYukYAmDxf23hIVtw/Ab5+/Rjbay1wZiEefvjGbQOr476RUTe0/ZygMDYqqvLo6ZOtyG9vtcPkDBHtXD0edbe7650wGK4xh7KWq7KRI3Ml+qrDw8Czaick3C1HbzS6a3IeUp3bdp7rO1pkJ9rD9c6OJUjwDRHTwe4cIXDLhLnBf816eK5O59VFsD0fyFvYEW9hv+DE7NQWZuicyBJlF3A8PIC+a+oPY+4xpled/ooOARC9tI3o6mMHDJwn1ai6NrYqch7ygacHy1mkq9EeFP9/uyRNGt+IO1aoOLyIruLtahrNIb+GWH9+FaQj138mRmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB6115.apcprd04.prod.outlook.com (2603:1096:4:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Wed, 30 Oct
 2024 06:12:22 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 06:12:21 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 5/6] exfat: code cleanup for exfat_readdir()
Thread-Topic: [PATCH v1 5/6] exfat: code cleanup for exfat_readdir()
Thread-Index: AdsE8yC3ez3tc0L+Tei8vqLbbtrSjglnt1DA
Date: Wed, 30 Oct 2024 06:12:21 +0000
Message-ID:
 <PUZPR04MB631667D3E1323318E355C7F081542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB6115:EE_
x-ms-office365-filtering-correlation-id: 68a0a6d1-bacd-47b4-2576-08dcf8a9d0fa
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWpuU3VOTWo0ZHFnajJSTkdVMjJPNER3cmRZdkhWaHc3eWttT3dhcm9Bd3FM?=
 =?utf-8?B?WXNwdHJQZTNnVGkxS3c2R2lMZ2dlVjlxeWFwV29reUNwWDRPRG5CbzEzYXRp?=
 =?utf-8?B?SUphZEZ3UWg1SmJlNkNlNlBWUUhOaE1qcDJ6YnpUdVpqRlU4WUNweitrcmxi?=
 =?utf-8?B?VUg5WVp5Q3ZHWldGSXpaSVczVkVwUWxJM1ViR3JqVlhOL3dtUWNHRzlQNHlM?=
 =?utf-8?B?cnRINHV2cE5CdU5QQ0gvUjE3b1BrNndLZy9GdHFqQW9ES1p5ZXV4V2FybGQr?=
 =?utf-8?B?ME9UMXNtSE5HZkJXWDFXYTI3RlN3YnZXTThMNFpUcWNNRVgzTFlvL2pkbGFI?=
 =?utf-8?B?ZVBIY1dreG9QOVZ5WmJ2bzNWVXMxbjdlaFpVMmJsSVU1RzNFWHdlTkE2V1B4?=
 =?utf-8?B?SG5tYVg3aS9oQzhpZWMxeFRqOHlldy84STVzZ1BvZTB4VmQweGt0a1U5OHVP?=
 =?utf-8?B?R0JuN3FCNG82QWdMcG41RFFBUWpkeFZYVk4vd2pKNUpnVTc4aFdnalJaSE8r?=
 =?utf-8?B?VUNjRzlkY0liT2puYmMyL1JNUmVzNS9ieGFkNVhpOHRUWjRROXJGRnNFM3di?=
 =?utf-8?B?NW4yc1lFeUw1WklVQnpSb053K1N2VG9sNG80akJvL0JZaHJkMDZ3Tm5BN1Fm?=
 =?utf-8?B?aXpoWHdWdEJ2UThhaVJENXR2TEVqVVE4VEowZ2gwR2hrWjkrcFZzYnRIZWEw?=
 =?utf-8?B?d2oxSFBnKy9YSXM0d2NFMGYwa2NxbjVscjhjM3R4YkZINUFuMGluSG9GTkNP?=
 =?utf-8?B?SytxUWFmb29pSVcwMVE4cFFvYzExZUlYdFl0QXhHRXdPT1Y3dDNmMXQ4cy81?=
 =?utf-8?B?eUhIYTVrRFVyam9ZWEFkZTlYRmRuK2pFbjN2T1lpcUs2QVg0SU9Eb2Q2Ykhx?=
 =?utf-8?B?OGVwQlcrdTNraDBkeElqWHVQMHlhWHkxcEZRSDIwNDJwb0pKN3JHUzkzWkpJ?=
 =?utf-8?B?S2x1eHZvTUFlcWNTWjdkUmV1NUtQS0xpZGsxbm9zeUp0TklIVlRNbFk0WXdm?=
 =?utf-8?B?c1NUZFB3ZmdlZGRDU2VUSEVyckhoeWN5MXdOaGRMNjNRZkxuQUcxR1Uvc1FY?=
 =?utf-8?B?bVJmYkFiY3N0MEZWM0NPdjU2N1M3TVZUbnU1dWk4VEh0Wmhua3NDRzZVOTRW?=
 =?utf-8?B?a0R0ZERxeVZYUDBXT1pHNXppUVZnbm9RbTFvY2gwMHNiMzFPcGU1WVZhY0kz?=
 =?utf-8?B?eEpkMDluRlNPUmprTm5rK0hBUmUzblBrMjMzSkNRaWprZmFXSll2UXFvQXdK?=
 =?utf-8?B?eFJmbTRXZHBjTFllcnNiWU9Bais0cXFvV3JDK1lXUXptcmc5UXdlVVlNQy85?=
 =?utf-8?B?MWh1SW41bkRCTzR3ZkwxSi83OXp4a29Xc1V6RkdsSWI5ZEpwbElGTFFIZ0FF?=
 =?utf-8?B?c1NzNWlaYlV6L1UrbGk5TkR5aGdWekQ5TEdYdU1sU1piSEtrVUl0TE4yMTRa?=
 =?utf-8?B?QjJCd01USFFuRkhwZnd2enBuSUhkRFJ2SVdtTVlhUmduaGhxMWFRdElMajlN?=
 =?utf-8?B?bU95NEo5UDh5Y0NQWWRuWndiZjh6am14OW80UHU1TjVNbnBlNFVIazQvSGFH?=
 =?utf-8?B?REEzbDJkVm80RnFZb2l2QzF2VjhuamEvSHZ1V0V0U0hzblZER2tSK05tcnhh?=
 =?utf-8?B?bjhhL2lUWDJWa0xWNUYvOERtQmpoZDNGMGNORnlXd0RGYTJTMGl2eC91NU5n?=
 =?utf-8?B?OHV4Nm9jWVZKcTllVXdqbmlZTjhicHh4SjFBRlJiY1hhSllhNkIxanZ0ZUg3?=
 =?utf-8?B?Ri9BRDQzRDVNZVgvVGQralZmRWNpZVozNDg5aVRCcjdWbTBBQ1VpZXBrQWRh?=
 =?utf-8?Q?UdbbPdD7Zuyz1s9RRh6fyRsEyLY0Hvn/b7Ilg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTJ3ejFoODk0NkJMdzF3WnJDYkV6WEY1R09Pb0lrc2hpeStLYTNEUFNSQUNB?=
 =?utf-8?B?Qmh5QnZEZkwyTjRMK1JkemU3R2cwYnphcEhOODRlSXNNeUQ5MURJRFI4NE1K?=
 =?utf-8?B?aE4xalkvWnZKM1IzRzQyVVlBNUV5V2ZnTjJDellXRFE2OGR2Y3N6aEVYWURZ?=
 =?utf-8?B?YUJyNHllSXdyZXZqYWtzaTJ3SzFxTFg0bHc1RmpJZU1XUkVDemdVSU53TExr?=
 =?utf-8?B?M1M3bTc0RFZVSGhUVzdPY3MxQWc2MkxiRmYxTlJ4eXBWNGxaZkxaSlcwTDhI?=
 =?utf-8?B?ZGtOd1ZRdU91WGU1dVl4cFlleE12RytlVmhleSs3SFdKZkxWbXA4dUFhL3Jh?=
 =?utf-8?B?OUlGSHJoeS9oM0pzRThwUWh2VUNmc25mMUtFMHVGYTN4UG40MGpzaFZXalM2?=
 =?utf-8?B?cEREVGx0dy92Qmp0U0pBVmgzUVFJTDFjODVyY2VmcFNPSGYrMUQ0MTFqVnVi?=
 =?utf-8?B?WVE0VzMwcGMvQXoyemc0dmVjZUZ6eXVzSzhXaGZhQ1BtNjFwd2xZWEJHMkRw?=
 =?utf-8?B?S0srQ1hobENSb2JzN3E4Ym9OZHF5SjRIK1hRRjd1NldYV2VnMm1jNHRRNzVY?=
 =?utf-8?B?Nk1YS0tkSU9CSm5Na0lwU1FNaFNaajNVNk53M1dLelNPeURTa1U1M1ZibTZt?=
 =?utf-8?B?LytVc2Iwb3R3b3pldFJoYXczSHpNSy96OTQ4RUhLSzNYNC9lZzdhdnhvUTZN?=
 =?utf-8?B?bi8raHg3MU93cFJ3dUJLOFZhMStXQ0UxN01RNU12czZMcDF0Z21UZkRuZ0pn?=
 =?utf-8?B?Q3pRZDBwWkl1Rzdoajl6UVVnSjQyWXVsclhaOVVKcjBOd2ZJeTJKRHNVZm9J?=
 =?utf-8?B?S2RDRVcrN21CczBVSlNwTkt2N3RXTk9ibW02YlhsdUVBNzRqakJPQ0h3cnhC?=
 =?utf-8?B?d2RucmQzc0NhakJUVi9wOFM2S2tCdnlFRVJOamUzaGh2Y2ZRMkRuWUEvZDZG?=
 =?utf-8?B?eFdjYS85Tk1xZ21BNzhUOVo3dThEcXJaUitwZTQ2QkVGU013UkVGZ1ZTdmlH?=
 =?utf-8?B?TXNFTTluN253UEtVUG96K1dzSXpJZXJCVFNyZ0tvNjNoakNaWG5oS1dXSUx6?=
 =?utf-8?B?VzFMVVdTU1hQQWs0NHBWY3A2aHAvQ1NxQzgybVpKeHcrcEhyeVcwdjlyY3Zh?=
 =?utf-8?B?WlQ1WjBNS2Yvc3VXWUp6NEVPeWh4NzJiSkdmdHYyMWFYWUxjSHoyK09YSXBh?=
 =?utf-8?B?bVlBOTgyZ2NQb2YwbXY0RGpkVDRwbm9IVkNwT2gxNThDZnFmcnJ1citWcUps?=
 =?utf-8?B?Z1FFZ2Q3YVA1eVordThVZ3R2VU9sU2ZxUFJjRzFQKytTYktDZEtYZkl0aGk2?=
 =?utf-8?B?TTZ1R0V1bVcva1Flb3dKbHUzUU4yZndLUkhmMUFlY0dPa0FBZEU1WmF5cnA1?=
 =?utf-8?B?VkthRzZPeVFqYzlIcVpOK3pEck1IYjVobTBtY1pHSUFYdWMvbG93Um5adHRZ?=
 =?utf-8?B?Z1lGTkRxZWZscFQvdUlXMjJGTVlZQlh1MGRPaFA2UHdpMWYxbGhMWXVXN29N?=
 =?utf-8?B?ZERIazBDSjh2cFVldmR0YzBYTE9PQmFZaU5yRjhSa2h1aFFwMWgyeDlDWFpq?=
 =?utf-8?B?OTNyQU15Tlc3VDcrZ1V5VGpWZVBkblpieDhUVE12bTQrSHVoVk1wMGh2d1RR?=
 =?utf-8?B?WFJUQmlocVA5Rysyc1FRMjdEYlBaWkJxSFROWS9ER0xONjYvMkxEdTRuQjdB?=
 =?utf-8?B?ZS9nRmN3L1pCQjFZVzNydjNjdGNFeUg4aGFRTzJ4VHpVRkN1RXAyQVJqbVN4?=
 =?utf-8?B?bFVrUWFrdzJaQk5RYUZLaytWZ0swOTRJNkdwTm96Zkx3SDZRRm0waXc1V2tK?=
 =?utf-8?B?cGFIVXNsUlBvRFRXdFNNKzJ0R1BGck9KamQwSHBZKy9MUnAxR1grWEd5UjFL?=
 =?utf-8?B?L2RVQnhlOWcvcUlDbWhqUUJGek9OUnI0RXIrbHBqTFJYdVRZNXFNVFNlbmtG?=
 =?utf-8?B?NFI0cFZlTEh4dCtTbkJDNDhmRDFkcTB3VmYva1M2U01WSHlqUVlhTWZTdFpo?=
 =?utf-8?B?eG9RcjBOMU90SDdaZjRCaXNMOHp3OTI3UDhpQ000WXNUT0kvNE9SQ2o0ZXIx?=
 =?utf-8?B?aTI3aHZXSUhWN1VTbURMdStkU3BpWjY1MlYxMUF5OVZqTU9KOWVBazlzdk8z?=
 =?utf-8?Q?X+6vGorCf1bmH6q8wVS/RSShB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L/yfX2S7sIVaSjS8GIY4WqKyfYPIcPhHZPuq+Ywo1bR3NCZQYtAFEuxXxrJ2am+I/FJHtndsGCOeDdGX7/kc0rTGYSLhEamlpZ3ODpDJyiQ5WhzAuTd2dQ1+m+XJdN8Q8QPadd2NszMFiAXyFRxWdBnTBy9UQewiI+RyZx5EXLXlT3ZsLsQFnBpXulwfxShLJXLZDPzsX7rMBOywaiTDNqImIrb7G3DXqmantwTIv9An4gtXzxx6iFYI++7lALV/gOJ6FQISb1ymMZ2wtICPbndE8yuIgtpGHoQ1TZoezoRpYeud8NkwHx/GkxoZTVsSmkZ+CbLq1o8TrpcZiNt3cgzSgDWV8WVPCug0oIq0H4lwxZupYPl4ufBoLHTRIJ4ZFJwwL69pNfkLsPrRsyILVu2Tkzj2r3Ws7/ObxAvtXRBH+qJXiu+zNpAkpq+AZOX27qYMjHwJGGwDehKkpKUoeDjh9d1fGIZ8F9G4SB4TqexiYz3HG3y5F326B92zonrCW3fBcEE2eMWqn36mPxWayZe0qIsECQgRogzE1xRNuXFqwVKPBeh8PvdDRAz0PZ8ecv+YiBzu5kjvQDQspNRAgkgylc+9kz09Z+dqs+28fndbtsGmErsb0iI9r5obm5jw
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a0a6d1-bacd-47b4-2576-08dcf8a9d0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 06:12:21.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mk8qatuFTM2hTNN1xIWGZA/nwIL4uKupxLSJ/uFdogC24kqMAXyDiI8Ieab3xkmdBvfQzVZ3Rrl3nm9vc1nPiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6115
X-Proofpoint-GUID: 0eX2Ly4VKz3s4_5Qj3yHxAYU_A2eR8hA
X-Proofpoint-ORIG-GUID: 0eX2Ly4VKz3s4_5Qj3yHxAYU_A2eR8hA
X-Sony-Outbound-GUID: 0eX2Ly4VKz3s4_5Qj3yHxAYU_A2eR8hA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_03,2024-10-29_01,2024-09-30_01

Rm9yIHRoZSByb290IGRpcmVjdG9yeSBhbmQgb3RoZXIgZGlyZWN0b3JpZXMsIHRoZSBjbHVzdGVy
cw0KYWxsb2NhdGVkIHRvIHRoZW0gY2FuIGJlIG9idGFpbmVkIGZyb20gZXhmYXRfaW5vZGVfaW5m
bywgYW5kDQp0aGVyZSBpcyBubyBuZWVkIHRvIGRpc3Rpbmd1aXNoIHRoZW0uDQoNCkFuZCB0aGVy
ZSBpcyBubyBuZWVkIHRvIGluaXRpYWxpemUgYXRpbWUvY3RpbWUvbXRpbWUvc2l6ZSBpbg0KZXhm
YXRfcmVhZGRpcigpLCBiZWNhdXNlIGV4ZmF0X2l0ZXJhdGUoKSBkb2VzIG5vdCB1c2UgdGhlbS4N
Cg0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2
aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQpSZXZpZXdl
ZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1lckBzb255LmNvbT4NCi0tLQ0KIGZzL2V4
ZmF0L2Rpci5jIHwgMjQgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZh
dC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jDQppbmRleCA2MTIyMWM1OTU0N2QuLmUyZDNhMDZmYjVl
MyAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQorKysgYi9mcy9leGZhdC9kaXIuYw0KQEAg
LTgyLDExICs4Miw4IEBAIHN0YXRpYyBpbnQgZXhmYXRfcmVhZGRpcihzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBsb2ZmX3QgKmNwb3MsIHN0cnVjdCBleGZhdF9kaXJfZW50DQogCWlmIChlaS0+dHlwZSAh
PSBUWVBFX0RJUikNCiAJCXJldHVybiAtRVBFUk07DQogDQotCWlmIChlaS0+ZW50cnkgPT0gLTEp
DQotCQlleGZhdF9jaGFpbl9zZXQoJmRpciwgc2JpLT5yb290X2RpciwgMCwgQUxMT0NfRkFUX0NI
QUlOKTsNCi0JZWxzZQ0KLQkJZXhmYXRfY2hhaW5fc2V0KCZkaXIsIGVpLT5zdGFydF9jbHUsDQot
CQkJRVhGQVRfQl9UT19DTFUoaV9zaXplX3JlYWQoaW5vZGUpLCBzYmkpLCBlaS0+ZmxhZ3MpOw0K
KwlleGZhdF9jaGFpbl9zZXQoJmRpciwgZWktPnN0YXJ0X2NsdSwNCisJCUVYRkFUX0JfVE9fQ0xV
KGlfc2l6ZV9yZWFkKGlub2RlKSwgc2JpKSwgZWktPmZsYWdzKTsNCiANCiAJZGVudHJpZXNfcGVy
X2NsdSA9IHNiaS0+ZGVudHJpZXNfcGVyX2NsdTsNCiAJbWF4X2RlbnRyaWVzID0gKHVuc2lnbmVk
IGludCltaW5fdCh1NjQsIE1BWF9FWEZBVF9ERU5UUklFUywNCkBAIC0xMzUsMjEgKzEzMiw2IEBA
IHN0YXRpYyBpbnQgZXhmYXRfcmVhZGRpcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgKmNw
b3MsIHN0cnVjdCBleGZhdF9kaXJfZW50DQogDQogCQkJbnVtX2V4dCA9IGVwLT5kZW50cnkuZmls
ZS5udW1fZXh0Ow0KIAkJCWRpcl9lbnRyeS0+YXR0ciA9IGxlMTZfdG9fY3B1KGVwLT5kZW50cnku
ZmlsZS5hdHRyKTsNCi0JCQlleGZhdF9nZXRfZW50cnlfdGltZShzYmksICZkaXJfZW50cnktPmNy
dGltZSwNCi0JCQkJCWVwLT5kZW50cnkuZmlsZS5jcmVhdGVfdHosDQotCQkJCQllcC0+ZGVudHJ5
LmZpbGUuY3JlYXRlX3RpbWUsDQotCQkJCQllcC0+ZGVudHJ5LmZpbGUuY3JlYXRlX2RhdGUsDQot
CQkJCQllcC0+ZGVudHJ5LmZpbGUuY3JlYXRlX3RpbWVfY3MpOw0KLQkJCWV4ZmF0X2dldF9lbnRy
eV90aW1lKHNiaSwgJmRpcl9lbnRyeS0+bXRpbWUsDQotCQkJCQllcC0+ZGVudHJ5LmZpbGUubW9k
aWZ5X3R6LA0KLQkJCQkJZXAtPmRlbnRyeS5maWxlLm1vZGlmeV90aW1lLA0KLQkJCQkJZXAtPmRl
bnRyeS5maWxlLm1vZGlmeV9kYXRlLA0KLQkJCQkJZXAtPmRlbnRyeS5maWxlLm1vZGlmeV90aW1l
X2NzKTsNCi0JCQlleGZhdF9nZXRfZW50cnlfdGltZShzYmksICZkaXJfZW50cnktPmF0aW1lLA0K
LQkJCQkJZXAtPmRlbnRyeS5maWxlLmFjY2Vzc190eiwNCi0JCQkJCWVwLT5kZW50cnkuZmlsZS5h
Y2Nlc3NfdGltZSwNCi0JCQkJCWVwLT5kZW50cnkuZmlsZS5hY2Nlc3NfZGF0ZSwNCi0JCQkJCTAp
Ow0KIA0KIAkJCSp1bmlfbmFtZS5uYW1lID0gMHgwOw0KIAkJCWVyciA9IGV4ZmF0X2dldF91bmlu
YW1lX2Zyb21fZXh0X2VudHJ5KHNiLCAmY2x1LCBpLA0KQEAgLTE2Niw4ICsxNDgsNiBAQCBzdGF0
aWMgaW50IGV4ZmF0X3JlYWRkaXIoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90ICpjcG9zLCBz
dHJ1Y3QgZXhmYXRfZGlyX2VudA0KIAkJCWVwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwgJmNsdSwg
aSArIDEsICZiaCk7DQogCQkJaWYgKCFlcCkNCiAJCQkJcmV0dXJuIC1FSU87DQotCQkJZGlyX2Vu
dHJ5LT5zaXplID0NCi0JCQkJbGU2NF90b19jcHUoZXAtPmRlbnRyeS5zdHJlYW0udmFsaWRfc2l6
ZSk7DQogCQkJZGlyX2VudHJ5LT5lbnRyeSA9IGRlbnRyeTsNCiAJCQlicmVsc2UoYmgpOw0KIA0K
LS0gDQoyLjQzLjANCg0K


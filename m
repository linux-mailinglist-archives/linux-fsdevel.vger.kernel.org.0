Return-Path: <linux-fsdevel+bounces-14102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBAB877A5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C3528212A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9E717557;
	Mon, 11 Mar 2024 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="GRfbg2+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFEF14296
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131135; cv=fail; b=eMyio2mCavQ1YH8yGlhsFF17wdsswCVh4DMRt/Gpx3co6FBEOxuwgTrD53R6F3BqQkXNBtFVgpfAl/um/ubZl4y/vdb5YsXxwY2AzltiksgDG+HsSXuS41gBnw3UfZ9QyFOxT7DKYzyNKDTIeWDOBUpdBbLHynIa6hY2WelLR9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131135; c=relaxed/simple;
	bh=3/6cH/wDJY98age2+HAFkkM3uEcunfDro76cGhZcCkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJ9DEI6PebOCc3tihFRFCfOiUn6toYrhQBYnTx77UXIuwya4fcFjqvIxwQjIblFbtCC+AjIJuHh4nYM99KHlFov366RMst+I1Y1FF0bcMJM+8cT2wgI3SJGxEaJvxDwbTh+MtQmPWNWvT9JuWROHvkZ0IZdiGtHxCF0DD2gKHlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=GRfbg2+j; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ANjEgS021524;
	Mon, 11 Mar 2024 04:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=3/6cH/wDJY98age2+HAFkkM3uEcunfDro76cGhZcCkg=;
 b=GRfbg2+j24h0zzcDsWddtsnVSDSkun1AbpFT2beqEGJwhSTEdSWJL/WwLaYO11cNIxLf
 tjN9qYv+BZHQ/WKe0EwfABSD61QTxSiLqgN0HNsg+mXJpD5sBuGrsPyTz8FFYDG1hr62
 WCvJ2E+DiWTV5FfpHyvIvPn2NRASB219Q97dInwkEU7cAML9hkjHSwug1z1DLXy7J2La
 d5MZaX0eSKZrl1e3jRLa4YA98bEirgsL2dH4YcoL4TTQnf913Zm6cDQkiincVrXTVPyk
 eP8YBv3yrQzBotCCWcx6SgBjsJjBCSirdzVoMgO0t7l0c1SAQpdOX9IvXxc7H67++O3T og== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wreb6sdbb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:25:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2qa7geX54anvjzvJddi+lqw+DlPf34XJDFVJD2QBhCwfBRG800DR3O5bF9uiBc/x2SDhwMywUFwR0bx9kRyU6LVXU8TxsHUeiBvnh1SBBhaz1Qv+ROisqxh20N2s7YgWnR8SNFa+vPA5GS6zm4b1sUGfX9bYG5EfxPLzsqOAk0Yo4Az65DYrT5tAQSaE+Hxiby7qS41wlkyTb1Y4JU2wN93WWyEWxxBDMPeL5qYeo/kJzxs/9XsPTjDG8VfiAcDWIv/wWgijiIE0bvZ4NKf1rC9o2AAgLp91EAPzUwNq1ZNlmlXVIL3kuq+Rqg/hY+b07ZxKEtwWTcU0QViCFyG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/6cH/wDJY98age2+HAFkkM3uEcunfDro76cGhZcCkg=;
 b=L2sW0BJEbJFz86lt2ReH3PJUrpB+r+LO4B4/PRPkwfHiBvkL2qF5g7WTwaSiva9p7rjgL9gBLwIlu5i7PXn/D+rlVL7s4wzoB0VxEm9JRGcnE/LFrPdmUVlrMwuXWmjix0Kejqg32ptoFUJtHGvFQaQLd50zl74Jdza+D8cxaSbRCIgyShjdj1QXN++7kmVG7wIVswScgw6cmdoNIm3aOzLVPTFX9zn56bLtC5vokcjB2lc0qazj1gotpKCbzndVAzqfQT3dG2oFk0ZYeclejGAO0oypgjP2o6KRpb99YmibG4t2Pbn5Sw2XeKFf5cEnrXr9oPYk/tum4eKBfRkPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by TYZPR04MB6635.apcprd04.prod.outlook.com (2603:1096:400:33f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Mon, 11 Mar
 2024 04:25:16 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd%7]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:25:16 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v3 07/10] exfat: convert exfat_find_empty_entry() to use
 dentry cache
Thread-Topic: [PATCH v3 07/10] exfat: convert exfat_find_empty_entry() to use
 dentry cache
Thread-Index: AdoLF/aVR4xCnm2LRwWLHBiF9Ra8ZhoUtfpw
Date: Mon, 11 Mar 2024 04:25:16 +0000
Message-ID: 
 <TY0PR04MB6328C063F8EAC37476F5C92D81242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|TYZPR04MB6635:EE_
x-ms-office365-filtering-correlation-id: 31f63688-bb11-4b03-a8ee-08dc41834106
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2jtiMrksGZpnm4+jifJpaIjoPI/BK2LTWVZKbeFmxOeHzD+Nxs05SuGBFsTN2yU3oCFb0jgniPK/FjtyLwcyLh3dBjOXLOzzuHQT4xCdusbFSVc8Ueab4cBGXxup7C/8HQHdnDHwcueh7Rn5uVhdKF8vxP/uZFV/JcDk3dig455asKOqWGu+T0p/3Dxb5hhsTNcMFoyqqZIZU+rlj7n5aYyoq9aO202HKsJvE93MsQJFxEf0NxIm3mobPCxU11tjft/Aoqs0MeE49CFYV+xkTsg9FqGYQthKjiE2zK5/JkZmjw/QijWWnQsGIlWwH/QIBzlx+gV1CLAM9V//1nljpJGHXNvmv4Ssa79FP9HanDZXfDEm0VLGGJzte2oH3QoVhH7ZuqZ0nmWRENuR6Vm1nx8EcSvxWFv0FCVR2w2SQw6ASFqlO78OVEiMXzIdoWO8kwB8av+GVTg/MiS4v5UasJ0ydUrsHiOHpO5pMD45LJ+hULzKM7gx0Nh47Kd/Zm+25F01ST48Xq4rAyqrmq9i34pxgm+xROpxmtassGU5nnX+EUNqBc3/6QU7Whzzd4pJFEdifXsZFtI45pAie4SkdLjGKprevQgM8eHaCxU3pZufrIKzTxzF/D1jHis0yxdVprr3LGWMSkKnM3ZbHSwas+kBdImzFNoUYJ6z1tJIyIPVtsvaTYTC3U2JzD02XpITNIQKf0hucL0WIDDw0PghOg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Wndlcm9yR2J1U3dBZVRmOEV2U0lDeEF2WFp6N25PalJIdzBZdDE0bzZaRFJn?=
 =?utf-8?B?OUpwc3NHK01maHNmdXNMN1NtSVlSRWQ3RExLWkIwd242NGZSUTVYdE1XaGlU?=
 =?utf-8?B?Ym81cDBzTktOWU5UaWpMcklDTVJoUWxHT0tHVk95UlFvT1FPWG9lQ2Mxbk1s?=
 =?utf-8?B?V0szS1Urb283Szg2Y0Q3NmMyZjJrcnMyek1zTTV2NWRZK01uekplelJ1cUM2?=
 =?utf-8?B?clFlWElhckgvcUdDVmNhNnhBRHhOTTdBdVM0cmNjMHdxQ2JrU3ZVL3AwVWFw?=
 =?utf-8?B?dE16ZUt5OERzK2hIRjN3czBoWTFiYXd2Wms5cXczazByR3k3SlMzR2drL211?=
 =?utf-8?B?dHM1NVJlRlhYL01uYzN5UzdmeTdRS3cwQUwxK0h5cCswSkoxcVNqVG1md0Zl?=
 =?utf-8?B?Vk9mbTRsaURwS2xjS2oxZFhSakdVOTBUMk1XeHRMMURDY04yWEY2Nk9EY08x?=
 =?utf-8?B?aVVzbFpBOUpjSWd1cklMNUFTQnE0SVVWRzYzdjFJL2dSK2Z3MUtFSFRiZ3BI?=
 =?utf-8?B?S0p4ZVc0V2xKeGFZN2toLzdwUFpTS0xWL1FWMkE4SGZLMmg2ZU9oblowanV3?=
 =?utf-8?B?R21aNW93NGc4SXg0MGdZQ05ET2hxZDBINmR4cmttZjhucnhkMkE4dW5XcDdT?=
 =?utf-8?B?aEl1YlBEUVVyalRSYnN0Sis3L0N5SndEQlFCRHFyQjJ0M3psS3RkeVlPYXhv?=
 =?utf-8?B?djNKc2h5NVhrNEx6bVFuMnNpcHAxejROalpRempWeFIyM2ZXSkx2S1lHSnJP?=
 =?utf-8?B?OGpON1MzQnhybzkxb0JucS9FNnZicUV0ZlRqT2pVWm1KTllvM3BKenlzZmRx?=
 =?utf-8?B?a3phcGVkZENSY0FKLzdRLzh6VHlLS2FHNy95ZDJ4RXF2a2MrYjc0ZEYvOEk1?=
 =?utf-8?B?SFdkRkZVSkJ1N0NiQWhBbzRYWDZLcU80QTVpOGgxMVFDYWNRVkJUbnBYeDU5?=
 =?utf-8?B?VWowby9ydUEwTUlsWWtrS2JMYkVRemIrNk00Q1BPSmRRUzJxdHFzbVJUcEtU?=
 =?utf-8?B?L2hPN1JmVzExRmxHWk1Nem1SL1ZGdTR3cnh2ajFzOHliTVZwS3BTQUtaY1BF?=
 =?utf-8?B?NnpNeVRxb0Q5ZE04SzBSTU5oMnFkQU8yK1k5NHZKaGVkaDVuR3ByUllEUEpR?=
 =?utf-8?B?Vmk1VVdud1NTM3NrYXVlQzJIVm55eU1Ldmg4Yjc0MHE5L2tUeDc0M3FUQ2N6?=
 =?utf-8?B?N3I4eFBlS0lHaEJ6NUZSR0l1WXZtVmpVbjJ4S3FNUTgvYVhGWCs4N2xnU2Zh?=
 =?utf-8?B?SVBDWlovM3pRejdTTjJWR1lKc0laYlgxNE5xUExnbHZDSytYcld4QzBDTlds?=
 =?utf-8?B?am5MQ1NJTnd5UkZmdERkUWVyeXNyeWRocGUrYS9xa1NpeXVPbG5QQ252NDRv?=
 =?utf-8?B?MkYxa0pzTDM1MlpBOC90TlNiWjhnZUprSlN2M0dkTll2VDBaNWZVMHNoYnRH?=
 =?utf-8?B?Z2hMYTBYbXY0anU5aDFYT0RrUVA4V2JwMzZCRkExakJXQ2lPSS9NR2hqUUo5?=
 =?utf-8?B?cVg0ZzY3aHdZRnAwWENzQW1jcHFJNFg3YUN6bU5POC9wQ2M1WmpPSElRQmdQ?=
 =?utf-8?B?dXVxdkFFZnJKbUdXRmc4NjA2eXplVmJQSlZSWENuRjJwY3BXcEdZVzV5UmUx?=
 =?utf-8?B?VmlvN0k1SWI1Z3doZmo2ZTJsa1dWOXdYZHZjbUlZR0RTK0dIWW1KM05LZWlZ?=
 =?utf-8?B?OTFrNDVxKzhoN0tPdm5oVGNocC9zNVRsU0xYKzRsVHdCYVR1MURNNG1EVytu?=
 =?utf-8?B?bnI5ODJvRGR4OG9Md2NHYTJ0aGlRNUdqdmh1Sm9UdENqdmhJYi9xS25ncjV1?=
 =?utf-8?B?bTN5MjhMUUU1L3NzRm9ENDl5cUV6Y0ZCVlgvcEFLQkVQWEEvR1VidVVyWm80?=
 =?utf-8?B?UmtoOVlMWmdUV2xMYlVOVkV2VWdjUkozM2ZvY2grbWdzZTZJaGo4RDJPMzFR?=
 =?utf-8?B?SEl5REU0WThpZWRVV2ZoUWFiTTBrcUkwM0VQZU5YSEMrMXFLOWJGK2lkZ1d3?=
 =?utf-8?B?clhreXYzNTZSQjZwTGJCeWxSUkdkWVVmWXM3L0c0SEp4L1VRU3A3bjNkRyty?=
 =?utf-8?B?SHV0WUFKOHIxNXZQeGVGcjNuWTRXVHZZcHhYNi8vRlYzYk9HTGMrd3VyUWdO?=
 =?utf-8?Q?4SKPT5XKfwElVrmov0EOa40OW?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cKgDsSvIxdJ3nqz0yCBSB1a3f0p8ngNf/bf5RKO29ozCeq60qBzt7OhjtbfFfdyZmeN1rFgXvZX2L0LBaKZPkuHTDnL8eE+rICTqaHiSVH4OxN3mqfeUWCLEdVULJAsnWos0NXgXE6rjd4YHWfVGf/N/nh2Fz5aI6DKQxWTBWdYU6eOs5eCQ2PRa/g8jLP3spPvG1l9O1Ph6gK8Da2ESLuFv/x0S3ngQYDM9o86b+eP7nZfUKff4EvgX3zAqU64OyGLtQz/U1hR9TZKho8B4+kIVStAi9RMYGf7BPWT3xxGwX6IkXTl5xfoz6OICmmGzkwuzEA9XupBVAq+frrph4lR1SRAX38Ucn2PGkWK8/VEo0yaeH8ABIej48d/EzroQYmFNbq/wOl7zYO7Lrsi8bL9+lAcBgFf5bCcf8Mzb+Kq8NAhbC6rbRvgK6LvNrE3auwrZxHV1Yv7dK5dScLDByY3X3HfThSXoRKQaBHSu479rlTtt1TR4pVPcFSjsqvNHYOSZ6LdPlUE38l9E2TNi1rEOuWnEJKCaj9zEfB7c8RKaTHildaTj9e9fgEAeF6yF9dHFhJ1SbE8DVvFeQRE1Jr9eNINnGX0sFtR4ajybTE/V82N9lPX0xwSL3zHO+0Xt
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f63688-bb11-4b03-a8ee-08dc41834106
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 04:25:16.7050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ljqLt7qB9NpnhG0yTOlpw9FQiJcBR9YHsgdXrLEBLxuzcEwXYyYtQ3fmU95xKbhKKRI+epRh/3k8Cn/w6xPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6635
X-Proofpoint-GUID: bz6bUWWDR9yjHfSuSlGRdsIj1tTkSgz9
X-Proofpoint-ORIG-GUID: bz6bUWWDR9yjHfSuSlGRdsIj1tTkSgz9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: bz6bUWWDR9yjHfSuSlGRdsIj1tTkSgz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02

QmVmb3JlIHRoaXMgY29udmVyc2lvbiwgZWFjaCBkZW50cnkgdHJhdmVyc2VkIG5lZWRzIHRvIGJl
IHJlYWQNCmZyb20gdGhlIHN0b3JhZ2UgZGV2aWNlIG9yIHBhZ2UgY2FjaGUuIFRoZXJlIGFyZSBh
dCBsZWFzdCAxNg0KZGVudHJpZXMgaW4gYSBzZWN0b3IuIFRoaXMgd2lsbCByZXN1bHQgaW4gZnJl
cXVlbnQgcGFnZSBjYWNoZQ0Kc2VhcmNoZXMuDQoNCkFmdGVyIHRoaXMgY29udmVyc2lvbiwgaWYg
YWxsIGRpcmVjdG9yeSBlbnRyaWVzIGluIGEgc2VjdG9yIGFyZQ0KdXNlZCwgdGhlIHNlY3RvciBv
bmx5IG5lZWRzIHRvIGJlIHJlYWQgb25jZS4NCg0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8g
PFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29u
eS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFtYUBzb255LmNv
bT4NCi0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgfCAxMjYgKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygr
KSwgODQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMv
ZXhmYXQvbmFtZWkuYw0KaW5kZXggMmM2ZGY0Zjk2NmY1Li43OWUzZmM5ZDZlMTkgMTAwNjQ0DQot
LS0gYS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAtMjA0LDIx
ICsyMDQsMTYgQEAgY29uc3Qgc3RydWN0IGRlbnRyeV9vcGVyYXRpb25zIGV4ZmF0X3V0ZjhfZGVu
dHJ5X29wcyA9IHsNCiAJLmRfY29tcGFyZQk9IGV4ZmF0X3V0ZjhfZF9jbXAsDQogfTsNCiANCi0v
KiB1c2VkIG9ubHkgaW4gc2VhcmNoIGVtcHR5X3Nsb3QoKSAqLw0KLSNkZWZpbmUgQ05UX1VOVVNF
RF9OT0hJVCAgICAgICAgKC0xKQ0KLSNkZWZpbmUgQ05UX1VOVVNFRF9ISVQgICAgICAgICAgKC0y
KQ0KIC8qIHNlYXJjaCBFTVBUWSBDT05USU5VT1VTICJudW1fZW50cmllcyIgZW50cmllcyAqLw0K
IHN0YXRpYyBpbnQgZXhmYXRfc2VhcmNoX2VtcHR5X3Nsb3Qoc3RydWN0IHN1cGVyX2Jsb2NrICpz
YiwNCiAJCXN0cnVjdCBleGZhdF9oaW50X2ZlbXAgKmhpbnRfZmVtcCwgc3RydWN0IGV4ZmF0X2No
YWluICpwX2RpciwNCi0JCWludCBudW1fZW50cmllcykNCisJCWludCBudW1fZW50cmllcywgc3Ry
dWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMpDQogew0KLQlpbnQgaSwgZGVudHJ5LCBudW1f
ZW1wdHkgPSAwOw0KKwlpbnQgaSwgZGVudHJ5LCByZXQ7DQogCWludCBkZW50cmllc19wZXJfY2x1
Ow0KLQl1bnNpZ25lZCBpbnQgdHlwZTsNCiAJc3RydWN0IGV4ZmF0X2NoYWluIGNsdTsNCi0Jc3Ry
dWN0IGV4ZmF0X2RlbnRyeSAqZXA7DQogCXN0cnVjdCBleGZhdF9zYl9pbmZvICpzYmkgPSBFWEZB
VF9TQihzYik7DQotCXN0cnVjdCBidWZmZXJfaGVhZCAqYmg7DQorCWludCB0b3RhbF9lbnRyaWVz
ID0gRVhGQVRfQ0xVX1RPX0RFTihwX2Rpci0+c2l6ZSwgc2JpKTsNCiANCiAJZGVudHJpZXNfcGVy
X2NsdSA9IHNiaS0+ZGVudHJpZXNfcGVyX2NsdTsNCiANCkBAIC0yMzEsNyArMjI2LDcgQEAgc3Rh
dGljIGludCBleGZhdF9zZWFyY2hfZW1wdHlfc2xvdChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0K
IAkJICogT3RoZXJ3aXNlLCBhbmQgaWYgImRlbnRyeSArIGhpbnRfZmFtcC0+Y291bnQiIGlzIGFs
c28gZXF1YWwNCiAJCSAqIHRvICJwX2Rpci0+c2l6ZSAqIGRlbnRyaWVzX3Blcl9jbHUiLCBpdCBt
ZWFucyBFTk9TUEMuDQogCQkgKi8NCi0JCWlmIChkZW50cnkgKyBoaW50X2ZlbXAtPmNvdW50ID09
IHBfZGlyLT5zaXplICogZGVudHJpZXNfcGVyX2NsdSAmJg0KKwkJaWYgKGRlbnRyeSArIGhpbnRf
ZmVtcC0+Y291bnQgPT0gdG90YWxfZW50cmllcyAmJg0KIAkJICAgIG51bV9lbnRyaWVzID4gaGlu
dF9mZW1wLT5jb3VudCkNCiAJCQlyZXR1cm4gLUVOT1NQQzsNCiANCkBAIC0yNDIsNjkgKzIzNyw0
MSBAQCBzdGF0aWMgaW50IGV4ZmF0X3NlYXJjaF9lbXB0eV9zbG90KHN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IsDQogCQlkZW50cnkgPSAwOw0KIAl9DQogDQotCXdoaWxlIChjbHUuZGlyICE9IEVYRkFU
X0VPRl9DTFVTVEVSKSB7DQorCXdoaWxlIChkZW50cnkgKyBudW1fZW50cmllcyA8IHRvdGFsX2Vu
dHJpZXMgJiYNCisJICAgICAgIGNsdS5kaXIgIT0gRVhGQVRfRU9GX0NMVVNURVIpIHsNCiAJCWkg
PSBkZW50cnkgJiAoZGVudHJpZXNfcGVyX2NsdSAtIDEpOw0KIA0KLQkJZm9yICg7IGkgPCBkZW50
cmllc19wZXJfY2x1OyBpKyssIGRlbnRyeSsrKSB7DQotCQkJZXAgPSBleGZhdF9nZXRfZGVudHJ5
KHNiLCAmY2x1LCBpLCAmYmgpOw0KLQkJCWlmICghZXApDQotCQkJCXJldHVybiAtRUlPOw0KLQkJ
CXR5cGUgPSBleGZhdF9nZXRfZW50cnlfdHlwZShlcCk7DQotCQkJYnJlbHNlKGJoKTsNCi0NCi0J
CQlpZiAodHlwZSA9PSBUWVBFX1VOVVNFRCB8fCB0eXBlID09IFRZUEVfREVMRVRFRCkgew0KLQkJ
CQludW1fZW1wdHkrKzsNCi0JCQkJaWYgKGhpbnRfZmVtcC0+ZWlkeCA9PSBFWEZBVF9ISU5UX05P
TkUpIHsNCi0JCQkJCWhpbnRfZmVtcC0+ZWlkeCA9IGRlbnRyeTsNCi0JCQkJCWhpbnRfZmVtcC0+
Y291bnQgPSBDTlRfVU5VU0VEX05PSElUOw0KLQkJCQkJZXhmYXRfY2hhaW5fc2V0KCZoaW50X2Zl
bXAtPmN1ciwNCi0JCQkJCQljbHUuZGlyLCBjbHUuc2l6ZSwgY2x1LmZsYWdzKTsNCi0JCQkJfQ0K
LQ0KLQkJCQlpZiAodHlwZSA9PSBUWVBFX1VOVVNFRCAmJg0KLQkJCQkgICAgaGludF9mZW1wLT5j
b3VudCAhPSBDTlRfVU5VU0VEX0hJVCkNCi0JCQkJCWhpbnRfZmVtcC0+Y291bnQgPSBDTlRfVU5V
U0VEX0hJVDsNCisJCXJldCA9IGV4ZmF0X2dldF9lbXB0eV9kZW50cnlfc2V0KGVzLCBzYiwgJmNs
dSwgaSwgbnVtX2VudHJpZXMpOw0KKwkJaWYgKHJldCA8IDApDQorCQkJcmV0dXJuIHJldDsNCisJ
CWVsc2UgaWYgKHJldCA9PSAwKQ0KKwkJCXJldHVybiBkZW50cnk7DQorDQorCQlkZW50cnkgKz0g
cmV0Ow0KKwkJaSArPSByZXQ7DQorDQorCQl3aGlsZSAoaSA+PSBkZW50cmllc19wZXJfY2x1KSB7
DQorCQkJaWYgKGNsdS5mbGFncyA9PSBBTExPQ19OT19GQVRfQ0hBSU4pIHsNCisJCQkJaWYgKC0t
Y2x1LnNpemUgPiAwKQ0KKwkJCQkJY2x1LmRpcisrOw0KKwkJCQllbHNlDQorCQkJCQljbHUuZGly
ID0gRVhGQVRfRU9GX0NMVVNURVI7DQogCQkJfSBlbHNlIHsNCi0JCQkJaWYgKGhpbnRfZmVtcC0+
ZWlkeCAhPSBFWEZBVF9ISU5UX05PTkUgJiYNCi0JCQkJICAgIGhpbnRfZmVtcC0+Y291bnQgPT0g
Q05UX1VOVVNFRF9ISVQpIHsNCi0JCQkJCS8qIHVudXNlZCBlbXB0eSBncm91cCBtZWFucw0KLQkJ
CQkJICogYW4gZW1wdHkgZ3JvdXAgd2hpY2ggaW5jbHVkZXMNCi0JCQkJCSAqIHVudXNlZCBkZW50
cnkNCi0JCQkJCSAqLw0KLQkJCQkJZXhmYXRfZnNfZXJyb3Ioc2IsDQotCQkJCQkJImZvdW5kIGJv
Z3VzIGRlbnRyeSglZCkgYmV5b25kIHVudXNlZCBlbXB0eSBncm91cCglZCkgKHN0YXJ0X2NsdSA6
ICV1LCBjdXJfY2x1IDogJXUpIiwNCi0JCQkJCQlkZW50cnksIGhpbnRfZmVtcC0+ZWlkeCwNCi0J
CQkJCQlwX2Rpci0+ZGlyLCBjbHUuZGlyKTsNCisJCQkJaWYgKGV4ZmF0X2dldF9uZXh0X2NsdXN0
ZXIoc2IsICZjbHUuZGlyKSkNCiAJCQkJCXJldHVybiAtRUlPOw0KLQkJCQl9DQotDQotCQkJCW51
bV9lbXB0eSA9IDA7DQotCQkJCWhpbnRfZmVtcC0+ZWlkeCA9IEVYRkFUX0hJTlRfTk9ORTsNCiAJ
CQl9DQogDQotCQkJaWYgKG51bV9lbXB0eSA+PSBudW1fZW50cmllcykgew0KLQkJCQkvKiBmb3Vu
ZCBhbmQgaW52YWxpZGF0ZSBoaW50X2ZlbXAgKi8NCi0JCQkJaGludF9mZW1wLT5laWR4ID0gRVhG
QVRfSElOVF9OT05FOw0KLQkJCQlyZXR1cm4gKGRlbnRyeSAtIChudW1fZW50cmllcyAtIDEpKTsN
Ci0JCQl9DQotCQl9DQotDQotCQlpZiAoY2x1LmZsYWdzID09IEFMTE9DX05PX0ZBVF9DSEFJTikg
ew0KLQkJCWlmICgtLWNsdS5zaXplID4gMCkNCi0JCQkJY2x1LmRpcisrOw0KLQkJCWVsc2UNCi0J
CQkJY2x1LmRpciA9IEVYRkFUX0VPRl9DTFVTVEVSOw0KLQkJfSBlbHNlIHsNCi0JCQlpZiAoZXhm
YXRfZ2V0X25leHRfY2x1c3RlcihzYiwgJmNsdS5kaXIpKQ0KLQkJCQlyZXR1cm4gLUVJTzsNCisJ
CQlpIC09IGRlbnRyaWVzX3Blcl9jbHU7DQogCQl9DQogCX0NCiANCi0JaGludF9mZW1wLT5laWR4
ID0gcF9kaXItPnNpemUgKiBkZW50cmllc19wZXJfY2x1IC0gbnVtX2VtcHR5Ow0KLQloaW50X2Zl
bXAtPmNvdW50ID0gbnVtX2VtcHR5Ow0KLQlpZiAobnVtX2VtcHR5ID09IDApDQorCWhpbnRfZmVt
cC0+ZWlkeCA9IGRlbnRyeTsNCisJaGludF9mZW1wLT5jb3VudCA9IDA7DQorCWlmIChkZW50cnkg
PT0gdG90YWxfZW50cmllcyB8fCBjbHUuZGlyID09IEVYRkFUX0VPRl9DTFVTVEVSKQ0KIAkJZXhm
YXRfY2hhaW5fc2V0KCZoaW50X2ZlbXAtPmN1ciwgRVhGQVRfRU9GX0NMVVNURVIsIDAsDQogCQkJ
CWNsdS5mbGFncyk7DQorCWVsc2UNCisJCWhpbnRfZmVtcC0+Y3VyID0gY2x1Ow0KIA0KIAlyZXR1
cm4gLUVOT1NQQzsNCiB9DQpAQCAtMzI1LDcgKzI5Miw4IEBAIHN0YXRpYyBpbnQgZXhmYXRfY2hl
Y2tfbWF4X2RlbnRyaWVzKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQogICogaWYgdGhlcmUgaXNuJ3Qg
YW55IGVtcHR5IHNsb3QsIGV4cGFuZCBjbHVzdGVyIGNoYWluLg0KICAqLw0KIHN0YXRpYyBpbnQg
ZXhmYXRfZmluZF9lbXB0eV9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KLQkJc3RydWN0IGV4
ZmF0X2NoYWluICpwX2RpciwgaW50IG51bV9lbnRyaWVzKQ0KKwkJc3RydWN0IGV4ZmF0X2NoYWlu
ICpwX2RpciwgaW50IG51bV9lbnRyaWVzLA0KKwkJc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNo
ZSAqZXMpDQogew0KIAlpbnQgZGVudHJ5Ow0KIAl1bnNpZ25lZCBpbnQgcmV0LCBsYXN0X2NsdTsN
CkBAIC0zNDQsNyArMzEyLDcgQEAgc3RhdGljIGludCBleGZhdF9maW5kX2VtcHR5X2VudHJ5KHN0
cnVjdCBpbm9kZSAqaW5vZGUsDQogCX0NCiANCiAJd2hpbGUgKChkZW50cnkgPSBleGZhdF9zZWFy
Y2hfZW1wdHlfc2xvdChzYiwgJmhpbnRfZmVtcCwgcF9kaXIsDQotCQkJCQludW1fZW50cmllcykp
IDwgMCkgew0KKwkJCQkJbnVtX2VudHJpZXMsIGVzKSkgPCAwKSB7DQogCQlpZiAoZGVudHJ5ID09
IC1FSU8pDQogCQkJYnJlYWs7DQogDQpAQCAtNTE1LDcgKzQ4Myw3IEBAIHN0YXRpYyBpbnQgZXhm
YXRfYWRkX2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIGNvbnN0IGNoYXIgKnBhdGgsDQogCX0N
CiANCiAJLyogZXhmYXRfZmluZF9lbXB0eV9lbnRyeSBtdXN0IGJlIGNhbGxlZCBiZWZvcmUgYWxs
b2NfY2x1c3RlcigpICovDQotCWRlbnRyeSA9IGV4ZmF0X2ZpbmRfZW1wdHlfZW50cnkoaW5vZGUs
IHBfZGlyLCBudW1fZW50cmllcyk7DQorCWRlbnRyeSA9IGV4ZmF0X2ZpbmRfZW1wdHlfZW50cnko
aW5vZGUsIHBfZGlyLCBudW1fZW50cmllcywgJmVzKTsNCiAJaWYgKGRlbnRyeSA8IDApIHsNCiAJ
CXJldCA9IGRlbnRyeTsgLyogLUVJTyBvciAtRU5PU1BDICovDQogCQlnb3RvIG91dDsNCkBAIC01
MjMsOCArNDkxLDEwIEBAIHN0YXRpYyBpbnQgZXhmYXRfYWRkX2VudHJ5KHN0cnVjdCBpbm9kZSAq
aW5vZGUsIGNvbnN0IGNoYXIgKnBhdGgsDQogDQogCWlmICh0eXBlID09IFRZUEVfRElSICYmICFz
YmktPm9wdGlvbnMuemVyb19zaXplX2Rpcikgew0KIAkJcmV0ID0gZXhmYXRfYWxsb2NfbmV3X2Rp
cihpbm9kZSwgJmNsdSk7DQotCQlpZiAocmV0KQ0KKwkJaWYgKHJldCkgew0KKwkJCWV4ZmF0X3B1
dF9kZW50cnlfc2V0KCZlcywgZmFsc2UpOw0KIAkJCWdvdG8gb3V0Ow0KKwkJfQ0KIAkJc3RhcnRf
Y2x1ID0gY2x1LmRpcjsNCiAJCWNsdV9zaXplID0gc2JpLT5jbHVzdGVyX3NpemU7DQogCX0NCkBA
IC01MzMsMTEgKzUwMyw2IEBAIHN0YXRpYyBpbnQgZXhmYXRfYWRkX2VudHJ5KHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIGNvbnN0IGNoYXIgKnBhdGgsDQogCS8qIGZpbGwgdGhlIGRvcyBuYW1lIGRpcmVj
dG9yeSBlbnRyeSBpbmZvcm1hdGlvbiBvZiB0aGUgY3JlYXRlZCBmaWxlLg0KIAkgKiB0aGUgZmly
c3QgY2x1c3RlciBpcyBub3QgZGV0ZXJtaW5lZCB5ZXQuICgwKQ0KIAkgKi8NCi0NCi0JcmV0ID0g
ZXhmYXRfZ2V0X2VtcHR5X2RlbnRyeV9zZXQoJmVzLCBzYiwgcF9kaXIsIGRlbnRyeSwgbnVtX2Vu
dHJpZXMpOw0KLQlpZiAocmV0KQ0KLQkJZ290byBvdXQ7DQotDQogCWV4ZmF0X2luaXRfZGlyX2Vu
dHJ5KCZlcywgdHlwZSwgc3RhcnRfY2x1LCBjbHVfc2l6ZSwgJnRzKTsNCiAJZXhmYXRfaW5pdF9l
eHRfZW50cnkoJmVzLCBudW1fZW50cmllcywgJnVuaW5hbWUpOw0KIA0KQEAgLTEwMzMsMTggKzk5
OCwxMyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFtZV9maWxlKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQogCWlmIChvbGRfZXMubnVtX2VudHJpZXMgPCBu
dW1fbmV3X2VudHJpZXMpIHsNCiAJCWludCBuZXdlbnRyeTsNCiANCi0JCW5ld2VudHJ5ID0NCi0J
CQlleGZhdF9maW5kX2VtcHR5X2VudHJ5KGlub2RlLCBwX2RpciwgbnVtX25ld19lbnRyaWVzKTsN
CisJCW5ld2VudHJ5ID0gZXhmYXRfZmluZF9lbXB0eV9lbnRyeShpbm9kZSwgcF9kaXIsIG51bV9u
ZXdfZW50cmllcywNCisJCQkJJm5ld19lcyk7DQogCQlpZiAobmV3ZW50cnkgPCAwKSB7DQogCQkJ
cmV0ID0gbmV3ZW50cnk7IC8qIC1FSU8gb3IgLUVOT1NQQyAqLw0KIAkJCWdvdG8gcHV0X29sZF9l
czsNCiAJCX0NCiANCi0JCXJldCA9IGV4ZmF0X2dldF9lbXB0eV9kZW50cnlfc2V0KCZuZXdfZXMs
IHNiLCBwX2RpciwgbmV3ZW50cnksDQotCQkJCW51bV9uZXdfZW50cmllcyk7DQotCQlpZiAocmV0
KQ0KLQkJCWdvdG8gcHV0X29sZF9lczsNCi0NCiAJCWVwbmV3ID0gZXhmYXRfZ2V0X2RlbnRyeV9j
YWNoZWQoJm5ld19lcywgRVNfSURYX0ZJTEUpOw0KIAkJKmVwbmV3ID0gKmVwb2xkOw0KIAkJaWYg
KGV4ZmF0X2dldF9lbnRyeV90eXBlKGVwbmV3KSA9PSBUWVBFX0ZJTEUpIHsNCkBAIC0xMDk0LDE5
ICsxMDU0LDE3IEBAIHN0YXRpYyBpbnQgZXhmYXRfbW92ZV9maWxlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9vbGRkaXIsDQogCWlmIChudW1fbmV3X2VudHJpZXMg
PCAwKQ0KIAkJcmV0dXJuIG51bV9uZXdfZW50cmllczsNCiANCi0JbmV3ZW50cnkgPSBleGZhdF9m
aW5kX2VtcHR5X2VudHJ5KGlub2RlLCBwX25ld2RpciwgbnVtX25ld19lbnRyaWVzKTsNCi0JaWYg
KG5ld2VudHJ5IDwgMCkNCi0JCXJldHVybiBuZXdlbnRyeTsgLyogLUVJTyBvciAtRU5PU1BDICov
DQotDQogCXJldCA9IGV4ZmF0X2dldF9kZW50cnlfc2V0KCZtb3ZfZXMsIHNiLCBwX29sZGRpciwg
b2xkZW50cnksDQogCQkJRVNfQUxMX0VOVFJJRVMpOw0KIAlpZiAocmV0KQ0KIAkJcmV0dXJuIC1F
SU87DQogDQotCXJldCA9IGV4ZmF0X2dldF9lbXB0eV9kZW50cnlfc2V0KCZuZXdfZXMsIHNiLCBw
X25ld2RpciwgbmV3ZW50cnksDQotCQkJbnVtX25ld19lbnRyaWVzKTsNCi0JaWYgKHJldCkNCisJ
bmV3ZW50cnkgPSBleGZhdF9maW5kX2VtcHR5X2VudHJ5KGlub2RlLCBwX25ld2RpciwgbnVtX25l
d19lbnRyaWVzLA0KKwkJCSZuZXdfZXMpOw0KKwlpZiAobmV3ZW50cnkgPCAwKSB7DQorCQlyZXQg
PSBuZXdlbnRyeTsgLyogLUVJTyBvciAtRU5PU1BDICovDQogCQlnb3RvIHB1dF9tb3ZfZXM7DQor
CX0NCiANCiAJZXBtb3YgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZCgmbW92X2VzLCBFU19JRFhf
RklMRSk7DQogCWVwbmV3ID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoJm5ld19lcywgRVNfSURY
X0ZJTEUpOw0KLS0gDQoyLjM0LjENCg0K


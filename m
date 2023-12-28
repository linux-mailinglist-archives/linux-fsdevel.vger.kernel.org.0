Return-Path: <linux-fsdevel+bounces-6991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4781F579
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 08:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956DC1F22697
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954DA63BA;
	Thu, 28 Dec 2023 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="oDQ0rfLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B7B63AD
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS6R6su020186;
	Thu, 28 Dec 2023 07:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=TyC+vQQqIICBII40dD0Se1D2ruIQa7MCuWeLm23agts=;
 b=oDQ0rfLTBErhOmOZ9gvjPnYjbjNxQ8UQsi9rlQgQN77285t+phTh6qZBg3l5s8An8FVm
 HGkHjArAlx3VGx1Zm0oRK2ahYHGr5lj/kwZ2nBaCuJgHsShI3+nAGXu3fjtoaOWHamRf
 rZsqux7tT3KJbbHlGUpTXfmlquG47JyRocqS4ZmkQtctEA/54TknqHGdll851XpevAN7
 pQ8kvBuclOx/HLqhy1dOsoVLoWxfPwqW4l/5ZjPCaheAIFSMS9SABbuakmwqVFZJ95YJ
 3s8yiTU3hmJ6mkiAaa2pCvdmA3LW+1PzA4xa83dG0D4bj55Bd2QIhE0sRMCTSntcqvIQ Fw== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2106.outbound.protection.outlook.com [104.47.26.106])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5nrhvafn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 07:25:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjw54EuHR8ZB2VqbgqIvlwH3Kx8dbQWNp6Ob0rMQ5MlXLJ0wLcH1I7znXxOA1wNfOOVoXw2IeguU66KfdqLOPsm+0ZUfllY+1RYXow31CenlzWN0F2thdO7APfywHQZyMBFX2JJlBvr3OyniF009M1Qty8lvjRg0tcMYfHF3U0Wx2NNYqe38nfCUCkma6g4TibnrJeNOtp2QHKI4hQxVk1LoHQc1Js0RfnxblSR3f03xxPZ5Xh0bDxBX1Km3kmiI5U6nhpqmJsb0Uc89nt35UL9aX/JgdSJaMIjCU0whQiPOEuNFZdmU59xSjFB3XvSEzNAANJwxHnZCAe5yI0r+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyC+vQQqIICBII40dD0Se1D2ruIQa7MCuWeLm23agts=;
 b=U8/82bCaTT6fJJvsn8QCqSYVhrJoWSjkukrDNN1Xqb428wb3vi5HhslYPnsIhgsHKt4M8TR9RTlAh6zz/ZCATSrY9MAzDSDwCjs3syfBfVqco1IpmXAATKomcsykMLSqaS8cdCyCsNEg45Pbbz8Y79iFP68pkdJTgD67ICpMvP04XsMxy86fVPJXBUnMxN53AOAwEsn0sjmbE8NB+M71etFUtFppnpOMEoqX7qlMEuJ9uxrch0uUt63PdYfaBwzd+orH4XrjEkY7yNowvCSk626Nb4tzBalSA8LPB9Zetg6xlDioM7Z2hw0rP6vI/Ka87de9UXTG+ii+FrjyPtaWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7206.apcprd04.prod.outlook.com (2603:1096:400:463::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 07:25:12 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 07:25:12 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: 
 =?gb2312?B?s7e72DogW1BBVENIIHYyIDA3LzEwXSBleGZhdDogY29udmVydCBleGZhdF9m?=
 =?gb2312?B?aW5kX2VtcHR5X2VudHJ5KCkgdG8gdXNlIGRlbnRyeSBjYWNoZQ==?=
Thread-Topic: [PATCH v2 07/10] exfat: convert exfat_find_empty_entry() to use
 dentry cache
Thread-Index: AQHaOV7+BgqVg6Q9502VHdrJCi75vQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Thu, 28 Dec 2023 07:25:11 +0000
Message-ID: 
 <PUZPR04MB6316F975D00E3C85E22E512E819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7206:EE_
x-ms-office365-filtering-correlation-id: 2c406c11-7e35-4cd5-1ca4-08dc077620f4
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kFTHXIfC6HyICejOCnWEjlu2wvzKffI8QH6Atg9jOkGzHEnzkY9XT4n7VYu3iYZs/arJhtiYX6oAvut+3QChbjMTnFlrvv0rIZvfT6LIhG0QQ8vXsitMoVJdxNb2DbtVTd5NarcB03e26O7zHWBYtqqAKy6hx4CixNM23eSu2xBkGToNd2RvwLydXjzigbeTs0ORXU0dqtCDedBlUBScY9AeE1ZPMQUxT28F1kiBvnjWRbytu8OyTmHetMnKjhkp07lAoSaZgSPvIi1wU87wm/NaQYL/5sP0MwUB7/+RB0xT5e8ttTBkESPJYESlJ9NxMdZsjWCZm/zp1DRUnFle0z/JMzzxk/7FTd9vmSIYy950EGCy4z9r1IX9yo6H2fx5SNG64lMho8FRMZiVmfheB9RJUhiW3nvlcf4/Ik9QAl60wkTNJDrIA1uVP/7rzlP1V4HfbrkMPZYp+3E+GGGp5j4BBdvRGifduSiminT3ptcIZc7UCfxd/9Xr7ol5hurWP4buncMBe54TjqN3ORTylV6FXHLv6IT/1krC/+IkL43kkNpMWeD+V55W5f6bqa7t05/2eiiZHADxymq6Z8YaaLDi453E7EPqDPVLKyIgKl668ZPG2feOxDtAJdx6M8NXh2KSptIFSUqIMhAzcMMO9J2STdGNFcxQ1jjnCwPZy1M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(33656002)(558084003)(224303003)(7696005)(6506007)(64756008)(71200400001)(66946007)(66476007)(66446008)(76116006)(66556008)(38070700009)(9686003)(86362001)(2906002)(82960400001)(26005)(38100700002)(107886003)(122000001)(41300700001)(5660300002)(8936002)(54906003)(316002)(478600001)(110136005)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?bFI3c3RabkJhMUtmV2lZN00ybno0MjZBTDdMQlU2cG5hc2lTWXg3YUQvalBM?=
 =?gb2312?B?V0NPbXp0UStxMm5oemZjZmp3N01GNmd1NmxoN2tnOVQ0ZUQxcmhZV1kxejdX?=
 =?gb2312?B?R0tsTGFYYUtxOTlvN1lBRmdZbUJYam0ydHdNd0pQcU5BclU0bTBjbGhRb3FY?=
 =?gb2312?B?MHdsdnVYTmkzN29SelIweW1VTGY0VmFySWpEMGRpR3M5cHRpcG5kbVNkQTlN?=
 =?gb2312?B?VFpjemhSM3p3SmhaREQvSVdLakgyMC93WllsdWVCWmRQM3hSMlVCK3gwTTB6?=
 =?gb2312?B?dGJZakwxTmJGMXFOZWVIa0Q2UTMzQm9jK2Jtb0w2UEJuT0ZEV2tsTkIwM1Vi?=
 =?gb2312?B?ZHhURzhucVh2S1R2VGtEWEhvMlpuYUJaaTFsckU0VlpvbTlzcTd5S08yVmdX?=
 =?gb2312?B?dzZGNnhlVWhyYThFeGlxdVJrcS9uVER6RlRrOUpzaGhYWGNDd3lmdUVZMGpp?=
 =?gb2312?B?NGNMenppWGFLbDhkbDV4MFJMMWtKTEhVSG5zeXA4QWYwY091V3I5T1E1ZzJS?=
 =?gb2312?B?YW85bHlJOXhDdit1QTVoeURtYjNhcnQvRDJOb0RsWUFzdzc1NkdzNDhmNzBo?=
 =?gb2312?B?MkZ1aVo0WjBSRmZoTWJvbmFlZDRIQVhacE1RZjZxUzdiRFVOdHNGOGtmYXEv?=
 =?gb2312?B?RStyaWN4UHNJemFMRldsNW9jVUIyT25sYkswc2htRHNoN0tuaGRsNys1c1Z3?=
 =?gb2312?B?dUxRcmRKcUVqWEw3NEQxc3NkMTFOcG5FNWRoeEtncW1jYlNER0FyYWlpMnFF?=
 =?gb2312?B?RGdTWUMvR1d5Y0c5V3pEMDN6aE1lQTlPNjlSWnlWM3YxNjdOL0tEUzNuN2Q2?=
 =?gb2312?B?ZGZyOFBwV1M0UHlKYlhxbGNlaXFuWnh5Tm51SUFPKzVwS2hWaDh2RzBLSGZG?=
 =?gb2312?B?clZJNGVpbThyZ2lRL1JldEd4OW5FaUFkaGtKNUJQMUE3c3hCT3pTdEY1M3Fj?=
 =?gb2312?B?dzhGdGJLUTQrODB6bXg1LzFGcnVneG5mQ3c2c0hXRXhyREc1eE1YenlxWEdy?=
 =?gb2312?B?Zm1MbXRpUktXQjdzeHVHRHhySmtSemVDcUpabFR6ekozdWN5N2xBbjJyYi94?=
 =?gb2312?B?NFB3cGpMLzRnNjcvdGloRlpERkU3Qi83RThLd0NPSjZyb1ZIUEQ1eTZHU3pY?=
 =?gb2312?B?aXJJdmx2a3BkdE1WWEZUSHlNdzdmamdORTcrYktRQm5pbDJ0U3BBSEJzb3NF?=
 =?gb2312?B?SFdJTXZCMUNoM3pndDNKVkYyUEp3Z0VrdGI5cDlXMEZUaFl4Nmw2REZJMlFj?=
 =?gb2312?B?WHcvRVJacTJsU3phUzlGc1c3QnQvb1ZUNmVDVzlsdGV2Z3c4b0QzOEFtcSt4?=
 =?gb2312?B?dzdtRDRTQ3VGT3N5Wm1BV0g5ZWViNzFSZURvRk1OY1VxcGxHSTRxSXUveUZn?=
 =?gb2312?B?TnFHUldSaVpidFJOUFRMdG5XYTFFSHl5aWp0Ukx6OWlrQ2pZTzNVaWU5ZzB0?=
 =?gb2312?B?SjVvYkZmRmFidTFrSTA1dmIwbFdESGtKdUduOW1zTnVDbm1BaGFxZW1WdVB0?=
 =?gb2312?B?RWJQWGk5bGFwSDg5WDBnVGJUcENNNldoeko3NWh6Q1NxN1BkV0FMTTVvelQy?=
 =?gb2312?B?enN1czhVVU42OGlxYm1tSFkvMVgxYTc4ZU9MaGM2OHBpaVB6dGJXNmZNN2xq?=
 =?gb2312?B?RVZYeGFLOEh1bjh4Z3lpRHdncURIVnhYeVhTVjlIaERYbHNIaXJrRC9CZm1z?=
 =?gb2312?B?OWNSTHl3N1haTlhpRnFNMGd3NFhwc0lXV0lnMDI3UnVjR09xK2VCWEpmZGJL?=
 =?gb2312?B?MlQ2Tjg3QmtGZzNoSkRmRzJNSzJNT1Njc3p6bm1GcXJFYVJMUlpiU25mYmRz?=
 =?gb2312?B?eURQSFYycW5HdUd6SFNVbW96ckZlKy9OaDFPZE41Z2dnZWQzVWpEeVkzL2dO?=
 =?gb2312?B?b09GTkFDNmNiMG9QUFlVa2YvWXMxaldBSmF1dUZJcXdiQzBST0lJbkZHK2lD?=
 =?gb2312?B?VmVTNk5JRXVRbS84elluMHBrUzNEeldEeVlTcE5tc2Flc1VVMG5TZnJqTkJy?=
 =?gb2312?B?K2lMTVR6bFUyazZqTXphOXpzNXdudXpaYlprL0VsckkzeXFqZE92ZCthSXlw?=
 =?gb2312?B?Z2xJTm9DWEordk9HdjAvckZLbnJnRnJFV01IeVNWMDFHSms1N1ZveDZUQ3FX?=
 =?gb2312?Q?yLg4xKkIcJRFRrUxhY3EB3Yys?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pzTD6sBOUa5lAE0enE8PcX9yzW1h+xys2NyY8/DPeqNs2aDvfgPt8QE1wP9V4VLs6X3hu93VrOl1sAL0pbQjwYQBCTmvGtYeoOJB5vKlGohr/O1cUKNyNiRkDLtGwMW1aoacBTBf+6CI8v39c3SPlrYb0iBki2Quck/TcAIANWxqCgt8T2O6QV9XJsPE82vx/iVlMRRqWQeI2qkbg6hFDwrf0W/lw8ME0Xt2w/P56HJKryRJHNbIkJxuAcuLkLhyfR2RIN/oCKLIiyDoJn26W5GqZgg+lsJN/w8kT8tzsPhGIa+CQEfLXYU49GTmzAc9fKfBImrlgS9jN5sxR6NgYApQSvvgWuU/HhK1U61nfZ5gNXIb3o/D4ZlrRvDpB614ax1dL3+QB4Oiz75g1qdp1GhdDzX6jPT2dZRfse97kSsFzTUpXgSUbjbx/aZBoKN2xUY4grfEP3q2sr0yn+TJrL6+9hOVb93BmsnwzE9G99UegyQcrw1JVnVu7U53kcdGY4h25LlH1wm5k/m++CMrnjDQCg0pJEXYscbjqMLYKEW7YXHRYtArhl17n4pP9ZJ0/AipjRzU1EDH7lxprVW/apmPhCK2AIQxL1TUgnEm47EodG2T2hpkNegWNbo1Y9AK
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c406c11-7e35-4cd5-1ca4-08dc077620f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 07:25:12.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnMo85NtbpjVY9r9ceV2PG8DI1t2hwTO7O6PALoZhL8UBdC1gDhercs0I9wQj/gu/IrZQlLiYoQgdQ7iOp6j8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7206
X-Proofpoint-GUID: AXZ_gTYsXjlfyUCam8n8o1UPQAYSMdzd
X-Proofpoint-ORIG-GUID: AXZ_gTYsXjlfyUCam8n8o1UPQAYSMdzd
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: AXZ_gTYsXjlfyUCam8n8o1UPQAYSMdzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

TW8sIFl1ZXpoYW5nIL2rs7e72NPKvP6hsFtQQVRDSCB2MiAwNy8xMF0gZXhmYXQ6IGNvbnZlcnQg
ZXhmYXRfZmluZF9lbXB0eV9lbnRyeSgpIHRvIHVzZSBkZW50cnkgY2FjaGWhsaGj


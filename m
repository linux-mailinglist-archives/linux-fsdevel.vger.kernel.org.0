Return-Path: <linux-fsdevel+bounces-6980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD481F53B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBF21C21BF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49C522B;
	Thu, 28 Dec 2023 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="DkBPIYgd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F544411
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS60Exs009678;
	Thu, 28 Dec 2023 06:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=AeFOmNI8RD2KZy8g8XvMr0Ah4yzcDkE6Xm6jc9YnrHc=;
 b=DkBPIYgdxPLsD5xuZACraEgjUEiOqwbHMT0YBVA52pMulFbn7wozg7meOorUwAmzq6wV
 2SWTOTdQRiFI/WCwcf1zUa/ha8y5/Win5qZPdF81SrddVwEIoPT56IhHkc3NrGYez2yN
 qp/923kjjxlRieh+HwokRn59L+buJ3VWewv3pySBY9+MOIZVQViZH7BLOq+HOvy/S6o1
 TaMU6R5SAvmBAsjz1tx1Tao26hSlaCbQeIu7ZKb8pW0DepSTCtWO2w1lV1auWzcvq65v
 RksHsAodHykoeRMbAe7M1HpZnATQWoBx7nDpce74t0Wo6XvfsfW7iv9k8pOsfX/pGXuD XQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5nrhv9uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 06:59:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR6gSSvEOs2Rx4x0tqw1UiQVMsybnn87SaAS4uvnpzlW0YpxosbLPGAfEC2QmMuZhbZqbmMCeZVG5ldd8OMd2aN0W31zFDiZ3/DSzPz7M6i4lAlRRHn3+/mLtEePtVxrPrWyXo8NSokTDZeUey8lgLWFGcZRyzBMJkWH4EBmyNsgbfMJj8CoQKUK0C8xoaQ7isIptyqIlxl4AZmEZo7nR6aOBBC26PASHt0m4bkuzQFDJpRg4q5G2JeFrML2sgBvoyu9p6HskO7s2EnG1aJqbwt1shcFvelSA1E/WsncC9gZSXge02+I+YkehUx0bwqwik5w20tsbMCfvp9b4wJI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeFOmNI8RD2KZy8g8XvMr0Ah4yzcDkE6Xm6jc9YnrHc=;
 b=iZCyI/uMx1vefj4tcaxXc3feQX1fe82O0tcaA4VVkoXpORrJh/9eIAhmJIQyOadFfb/TC5Tdl/X56qBXatXXw1ytLrdT1M934tiBcpgA8AcoCV7FpQ+22kXmXz7gqythwKVYRy8RKpzalPW/zF/ng8URl/mmlNnH3Bwgx+ieOKTQrqk1YNFNLWEICI9v/yr3oXqFDbX1uhK7jua2COR91iY2YM1I30vRkq8zT+IR7wVTtwjjn2tgtTyi7eaXobqQWs5d/nlWQukiVNRJxFmDLF0XLoSzKxvobxcAR0RjEp479SvHZg9naWaCJqtSLlYlnoU+VSQqPpmM9a0mtv4dqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6878.apcprd04.prod.outlook.com (2603:1096:820:d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 06:59:12 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 06:59:12 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v2 01/10] exfat: add __exfat_get_dentry_set() helper
Thread-Topic: [PATCH v2 01/10] exfat: add __exfat_get_dentry_set() helper
Thread-Index: Ado5WOdBS1LltrR1Q7KsnyYhMVF/uQ==
Date: Thu, 28 Dec 2023 06:59:12 +0000
Message-ID: 
 <PUZPR04MB6316B1AB6C941CF16B6C8B15819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6878:EE_
x-ms-office365-filtering-correlation-id: 165accf0-b458-497b-1724-08dc07727f6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 V58gN6SYd5/pm6GTm1xKKp9xjrcxUdCNjDmNoBhIbaWk7MjdCFpjqHEERfDgmCRyW+JydqqJOqLjrtW9lgIfOpQHt+6wXUymfLboF0tcqk0A+AAVAlunDiRfCZ04nETFGsR+0XeSTb9m2du726GDmdmZzHrszVBuXG8B1OYI14AY1AxeAliYvNORNDOdS9d9fGsnGoNDOhQRqshVZ9u0P3LYP5EvqUe3g50Qqr4HW7dgQnqBwHDOMijolPrFmcmVlhmb1dqQ9daFyDD/kIpHNIOHQpWut1887K1Y6SjVv8lrUx2oMjlV207l/9ONDAZ+SsFXL3QA4+5DKuvE7QQnBNALCUX8L7LTKxLTR4EJ/k3AxFic6dVm45iJfdmLmgmk6xWTlzCpGK/V6wwifTmcmaCT1Do26BkE2OpmUjRuN1FRHVqmef6cQ7jsh0za420DhDess+LkD1Ff+9oDi8t+SHGznDsWisbZ9yXJLVB5pdARELRiwrJoHhFR/7sq4e9OP7y9ODDjt75eabP3l5OK9eiOZA/g5iQn3cPiSp1PKD4C4Q2SmCIGx7yh0+nzn4EkrPyyi/FCRDzgEXI12zhjHLa8qr9ovUkySzRk305Eze0uB3BKUemBNFzUGchjjtrL
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(33656002)(9686003)(6506007)(71200400001)(83380400001)(7696005)(478600001)(107886003)(26005)(38100700002)(122000001)(82960400001)(41300700001)(316002)(54906003)(110136005)(66556008)(66946007)(66446008)(66476007)(64756008)(4326008)(8676002)(8936002)(52536014)(5660300002)(76116006)(2906002)(38070700009)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZTBCeE5uZlNXQjVOUUFaOEM2dVFzd0VVaFFrS0lkaFlJMW1uVytnM0pzL2Rz?=
 =?utf-8?B?a0gwYzJsbXU2aHgyNzN2WDZVT2xabWc5bmEySWwwMURjNnIxRU9ZaXRNclhG?=
 =?utf-8?B?Q1ZOSS85TjFJSm81TDFhTVRGRlFFNWd4ZTM1QXZCcXhkb2krRlM5NGRjb0JH?=
 =?utf-8?B?NkRHRzNNUFdjMHFkRkNsamVzTWowUlFyRmtTem9RbTZtWjR2U2x4TFhBQkRM?=
 =?utf-8?B?TXFlSU1FTUxqd2J0MnltdkhkK1Z6Qnhlbm93T3lPSXVkN0ZaTGZRV1ZoOHFS?=
 =?utf-8?B?YTJkUEk4NHU2Z05KNnpKYlFpYXJxKzQvN3BIQlRzWGI4ME5zb1IxeDBIWnQ2?=
 =?utf-8?B?N3FPbk9EZzZUSFV0Mml2NEQyTmNqa3JWR2xxZHA1RGg0a2dhZCtRNzBjQWRC?=
 =?utf-8?B?WGNRNk5MZTVFUHJXU2s1dS92NGJEcnNRUVpBWnJ1RWhwUXM2UEVqWE1yM01n?=
 =?utf-8?B?Z0lMdXcwYzVKMldqSG9SamxiSGRQMlZIcEFXdWQwaUszUmo1Z2lBcEZCSzVO?=
 =?utf-8?B?SUU1bjhTYnZOVzRKWFBSY1VwYlJhZHZWWXZpdWljWGxBNlpPZGtsVjgvUTlx?=
 =?utf-8?B?Q1JVL293TmhLaFZWbi80WXFWaUtsRzZUaHc0eE42MmdoRkpOYUhpQ21RTXFF?=
 =?utf-8?B?M2hGM2ZjNEd6SE1CeEt2VnAwOGw5UWxpS3VnVHJzNVhGbFZpVnY1K2Z6Vmkw?=
 =?utf-8?B?RWlDWHJoaEZxMS9ZUlhCOEQvcFpxNHIvL0tSdHNnWXVMc201UkJjR1hoODlR?=
 =?utf-8?B?TUExUWZkL2djNmJnR1dSZWl1cGpnQlNreUJLUmo1dlZlQnVHd2lnV0dNWm5t?=
 =?utf-8?B?TVFpWHA0MDYrYVo0RERRanhPTVBUYk9XeG0vV01kQWoxMjBHN2tURTZ6d3E3?=
 =?utf-8?B?eWozNlRHVnN5Tm1rTHFGOTk4NjVTcXpOUGJTNVFsODRzOWxMNi8xWTF2S2ly?=
 =?utf-8?B?UDZ5angxSFByeDJmbm9hRUxPdnNQeUp2Y3lZMzNMR1pPMTQzWFRXd1BLdVhj?=
 =?utf-8?B?L3hqRU1jUE16MkRqd2xxbW14WWNWcXc1SndUenZYQUZJUmt1eUZWZjFaUFM0?=
 =?utf-8?B?dGNJc0UrYXFYWmdEZmh2V3o1cmoydXpsSHRldFFYQTcwN212S1dDUmpPYTMv?=
 =?utf-8?B?Y1RYam03Nkh1SUNkL1lucFBZSVBQL01lRmxkVlBFY3pMUEJFbFZkQUVQaHdK?=
 =?utf-8?B?VEE4dU85T1JDOGJZZEhSdU1UVXluc0kwYzZ6Y2t6UkkxN0NaUWFMUnpMMStu?=
 =?utf-8?B?T0RiNmxONmtvMUhEZDNGU01Wb2h0WkJXcDM4K2dsVmZSSGQxSURhdkNXYXZu?=
 =?utf-8?B?eXBUMVBBQzV0Skkvemh0enJtaW5SblpBV3pxcFFGWHRnSlRtSHRlY3ZVNEx4?=
 =?utf-8?B?bTZUYzZYNGFBWXJXQUFMNVpFd2tOOUdSZytlNWUrUlhOdmQ5ZUxwa1p3ckg5?=
 =?utf-8?B?dU9HTkVqSGFNczk0Yml1WTV1Yld5Nmtwc1J5OU9hdnUrVFBGN3NZa0RIT0sx?=
 =?utf-8?B?RTZtQ1dGWGNmNWNrUHR6Zjlsb0wzMFBQVkVQenduUkZGL3ROZGg3aDA0dmky?=
 =?utf-8?B?OWVZZUk4VFM3MWpYOGdrNGtvbDlsem9VQmZmRlhIM0dCSHZNNlpTRFFwcGs0?=
 =?utf-8?B?a1dBaG04S1dtTnRSQkJma3UxdEZpN3JJVy9GRWlFaTA4NnJlKzBkenlaSTNw?=
 =?utf-8?B?bnd0MlF4aVErYm5iaEp2RitDRlJEZktmNUEyMWFCcDhnMEVtSk1kWnVoTC96?=
 =?utf-8?B?N3hVRHhveWFQd1lZbnAxTlc5K1NnWllaZzd6c1dWcWtlYnpmbFZTVTNFRlFl?=
 =?utf-8?B?cmhMNC9vU3U4dWlEOUJ1UUZaQ0xLTGNyNHZYcXhaSzhobjV5aXVYb3ZnNHZH?=
 =?utf-8?B?UkVSTWxTTEppbVpJRWdWR0tIVVB3ZWtFOFVTd1NjZVBYRFRlNFNRSkM3WkRz?=
 =?utf-8?B?bzg2bDZoVmdtdUNKOVpjT21JZ0ZvMlZKSUVNc3RzNDM4RVVZdGxJTDRMdEt1?=
 =?utf-8?B?OWdPSTBXZXEvNmIyNnh4bTA3OW91TTM1TmZndFhVT1VDelIvbmZxc3diYy8v?=
 =?utf-8?B?NU5yc1RGODU0S1I3SUh1M1dzeWhQbHFWa0NQTUl1SS9zRXhWRkRldkRoTHUr?=
 =?utf-8?Q?BlWu8m89tDIA8goekObBp7SiC?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kKkC8Nf5FYqDML5vpjKdOHP/GvkXrkPwlYBbi1eSpTFHsEleH+oVTmwBdT3PLiWBVn9verLzppOi3kBFOBzZ4VMuzhengq1p17HCeknFZIMLcir6t2g2FlGuAGdMWF8iZ2N9+1+Nf2K0clAcGaCmUeJGeBuIicdCFkocDKRmcDRqikY8YZgemnkw6OeI2leu+cAnjfOqXpzl7iIWxCCT2VLboLQRnyIhC19j9uMpZE9Zniy6r5cmEIL/HXQwfc5s8zSJJuIzDMU9z2kG7PNgir+MPIYPNNWpUHter9I1Spk2a0/HAKJvorrIELDaup0N53D3ughUmI1lyHssxnjxmGfwl3NCJrGWF5F3ImfMyKhrm3ZTIEj/lufIy6PtuJ7M6/SMruyjVZrAj+SAEt/YgZdGuydPKWNHan5ZxDmcZY8gDQVd3Grgy4UlUb2jJKi8jUbWjeW/N6sM4CaBnEdVRBJ9Hg2bmoMId+TUZkaJ96hd1Jf44ms11rmOlGn7FSFh03n93rF8TwVHOecIXg57Mk+ZB70GA1aktHxCdkHA11EH5dexMuE0cpvZgYfMbQ7wRc6UX06RC1CbiSZEYhoRpB4fTsavzebZ/givZy7K7jhKPWaayTryF1MfTmdXbyEj
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165accf0-b458-497b-1724-08dc07727f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:59:12.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buSiZvcwy7J9pAn3MJeIAbXBAZMWYwnXb5PmE236WyFzaP2zhgJ58HSS0OaDg40heyFsy5nicSgubaqSOSsghA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6878
X-Proofpoint-GUID: IqOpDK5RABb8jlXDBcjLp1MaZiuFb2W8
X-Proofpoint-ORIG-GUID: IqOpDK5RABb8jlXDBcjLp1MaZiuFb2W8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: IqOpDK5RABb8jlXDBcjLp1MaZiuFb2W8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

U2luY2UgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKSBpbnZva2VzIHRoZSB2YWxpZGF0ZSBmdW5jdGlv
bnMgb2YNCmV4ZmF0X3ZhbGlkYXRlX2VudHJ5KCksIGl0IG9ubHkgc3VwcG9ydHMgZ2V0dGluZyBh
IGRpcmVjdG9yeQ0KZW50cnkgc2V0IG9mIGFuIGV4aXN0aW5nIGZpbGUsIGRvZXNuJ3Qgc3VwcG9y
dCBnZXR0aW5nIGFuIGVtcHR5DQplbnRyeSBzZXQuDQoNClRvIHJlbW92ZSB0aGUgbGltaXRhdGlv
biwgYWRkIHRoaXMgaGVscGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhh
bmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4N
ClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KLS0t
DQogZnMvZXhmYXQvZGlyLmMgICAgICB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgMiArLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9mcy9leGZhdC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jDQppbmRleCA5ZjkyOTU4NDdhNGUuLmNl
YTkyMzFkMmZkYSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQorKysgYi9mcy9leGZhdC9k
aXIuYw0KQEAgLTc3NSw3ICs3NzUsNiBAQCBzdHJ1Y3QgZXhmYXRfZGVudHJ5ICpleGZhdF9nZXRf
ZGVudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQogfQ0KIA0KIGVudW0gZXhmYXRfdmFsaWRh
dGVfZGVudHJ5X21vZGUgew0KLQlFU19NT0RFX1NUQVJURUQsDQogCUVTX01PREVfR0VUX0ZJTEVf
RU5UUlksDQogCUVTX01PREVfR0VUX1NUUk1fRU5UUlksDQogCUVTX01PREVfR0VUX05BTUVfRU5U
UlksDQpAQCAtNzkwLDExICs3ODksNiBAQCBzdGF0aWMgYm9vbCBleGZhdF92YWxpZGF0ZV9lbnRy
eSh1bnNpZ25lZCBpbnQgdHlwZSwNCiAJCXJldHVybiBmYWxzZTsNCiANCiAJc3dpdGNoICgqbW9k
ZSkgew0KLQljYXNlIEVTX01PREVfU1RBUlRFRDoNCi0JCWlmICAodHlwZSAhPSBUWVBFX0ZJTEUg
JiYgdHlwZSAhPSBUWVBFX0RJUikNCi0JCQlyZXR1cm4gZmFsc2U7DQotCQkqbW9kZSA9IEVTX01P
REVfR0VUX0ZJTEVfRU5UUlk7DQotCQlicmVhazsNCiAJY2FzZSBFU19NT0RFX0dFVF9GSUxFX0VO
VFJZOg0KIAkJaWYgKHR5cGUgIT0gVFlQRV9TVFJFQU0pDQogCQkJcmV0dXJuIGZhbHNlOw0KQEAg
LTgzNCw3ICs4MjgsNyBAQCBzdHJ1Y3QgZXhmYXRfZGVudHJ5ICpleGZhdF9nZXRfZGVudHJ5X2Nh
Y2hlZCgNCiB9DQogDQogLyoNCi0gKiBSZXR1cm5zIGEgc2V0IG9mIGRlbnRyaWVzIGZvciBhIGZp
bGUgb3IgZGlyLg0KKyAqIFJldHVybnMgYSBzZXQgb2YgZGVudHJpZXMuDQogICoNCiAgKiBOb3Rl
IEl0IHByb3ZpZGVzIGEgZGlyZWN0IHBvaW50ZXIgdG8gYmgtPmRhdGEgdmlhIGV4ZmF0X2dldF9k
ZW50cnlfY2FjaGVkKCkuDQogICogVXNlciBzaG91bGQgY2FsbCBleGZhdF9nZXRfZGVudHJ5X3Nl
dCgpIGFmdGVyIHNldHRpbmcgJ21vZGlmaWVkJyB0byBhcHBseQ0KQEAgLTg0MiwyMiArODM2LDI0
IEBAIHN0cnVjdCBleGZhdF9kZW50cnkgKmV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKA0KICAqDQog
ICogaW46DQogICogICBzYitwX2RpcitlbnRyeTogaW5kaWNhdGVzIGEgZmlsZS9kaXINCi0gKiAg
IHR5cGU6ICBzcGVjaWZpZXMgaG93IG1hbnkgZGVudHJpZXMgc2hvdWxkIGJlIGluY2x1ZGVkLg0K
KyAqICAgbnVtX2VudHJpZXM6IHNwZWNpZmllcyBob3cgbWFueSBkZW50cmllcyBzaG91bGQgYmUg
aW5jbHVkZWQuDQorICogICAgICAgICAgICAgICAgSXQgd2lsbCBiZSBzZXQgdG8gZXMtPm51bV9l
bnRyaWVzIGlmIGl0IGlzIG5vdCAwLg0KKyAqICAgICAgICAgICAgICAgIElmIG51bV9lbnRyaWVz
IGlzIDAsIGVzLT5udW1fZW50cmllcyB3aWxsIGJlIG9idGFpbmVkDQorICogICAgICAgICAgICAg
ICAgZnJvbSB0aGUgZmlyc3QgZGVudHJ5Lg0KKyAqIG91dDoNCisgKiAgIGVzOiBwb2ludGVyIG9m
IGVudHJ5IHNldCBvbiBzdWNjZXNzLg0KICAqIHJldHVybjoNCi0gKiAgIHBvaW50ZXIgb2YgZW50
cnkgc2V0IG9uIHN1Y2Nlc3MsDQotICogICBOVUxMIG9uIGZhaWx1cmUuDQorICogICAwIG9uIHN1
Y2Nlc3MNCisgKiAgIC1lcnJvciBjb2RlIG9uIGZhaWx1cmUNCiAgKi8NCi1pbnQgZXhmYXRfZ2V0
X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQorc3RhdGljIGlu
dCBfX2V4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVz
LA0KIAkJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2Rpciwg
aW50IGVudHJ5LA0KLQkJdW5zaWduZWQgaW50IHR5cGUpDQorCQl1bnNpZ25lZCBpbnQgbnVtX2Vu
dHJpZXMpDQogew0KIAlpbnQgcmV0LCBpLCBudW1fYmg7DQogCXVuc2lnbmVkIGludCBvZmY7DQog
CXNlY3Rvcl90IHNlYzsNCiAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNi
KTsNCi0Jc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXA7DQotCWludCBudW1fZW50cmllczsNCi0JZW51
bSBleGZhdF92YWxpZGF0ZV9kZW50cnlfbW9kZSBtb2RlID0gRVNfTU9ERV9TVEFSVEVEOw0KIAlz
dHJ1Y3QgYnVmZmVyX2hlYWQgKmJoOw0KIA0KIAlpZiAocF9kaXItPmRpciA9PSBESVJfREVMRVRF
RCkgew0KQEAgLTg4MCwxMiArODc2LDE2IEBAIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1
Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCiAJCXJldHVybiAtRUlPOw0KIAllcy0+Ymhb
ZXMtPm51bV9iaCsrXSA9IGJoOw0KIA0KLQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKGVz
LCBFU19JRFhfRklMRSk7DQotCWlmICghZXhmYXRfdmFsaWRhdGVfZW50cnkoZXhmYXRfZ2V0X2Vu
dHJ5X3R5cGUoZXApLCAmbW9kZSkpDQotCQlnb3RvIHB1dF9lczsNCisJaWYgKG51bV9lbnRyaWVz
ID09IEVTX0FMTF9FTlRSSUVTKSB7DQorCQlzdHJ1Y3QgZXhmYXRfZGVudHJ5ICplcDsNCisNCisJ
CWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIEVTX0lEWF9GSUxFKTsNCisJCWlmIChl
cC0+dHlwZSAhPSBFWEZBVF9GSUxFKQ0KKwkJCWdvdG8gcHV0X2VzOw0KKw0KKwkJbnVtX2VudHJp
ZXMgPSBlcC0+ZGVudHJ5LmZpbGUubnVtX2V4dCArIDE7DQorCX0NCiANCi0JbnVtX2VudHJpZXMg
PSB0eXBlID09IEVTX0FMTF9FTlRSSUVTID8NCi0JCWVwLT5kZW50cnkuZmlsZS5udW1fZXh0ICsg
MSA6IHR5cGU7DQogCWVzLT5udW1fZW50cmllcyA9IG51bV9lbnRyaWVzOw0KIA0KIAludW1fYmgg
PSBFWEZBVF9CX1RPX0JMS19ST1VORF9VUChvZmYgKyBudW1fZW50cmllcyAqIERFTlRSWV9TSVpF
LCBzYik7DQpAQCAtOTE4LDggKzkxOCwyNyBAQCBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoc3Ry
dWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQllcy0+YmhbZXMtPm51bV9iaCsrXSA9
IGJoOw0KIAl9DQogDQorCXJldHVybiAwOw0KKw0KK3B1dF9lczoNCisJZXhmYXRfcHV0X2RlbnRy
eV9zZXQoZXMsIGZhbHNlKTsNCisJcmV0dXJuIC1FSU87DQorfQ0KKw0KK2ludCBleGZhdF9nZXRf
ZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCisJCXN0cnVjdCBz
dXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQorCQlpbnQgZW50cnks
IHVuc2lnbmVkIGludCBudW1fZW50cmllcykNCit7DQorCWludCByZXQsIGk7DQorCXN0cnVjdCBl
eGZhdF9kZW50cnkgKmVwOw0KKwllbnVtIGV4ZmF0X3ZhbGlkYXRlX2RlbnRyeV9tb2RlIG1vZGUg
PSBFU19NT0RFX0dFVF9GSUxFX0VOVFJZOw0KKw0KKwlyZXQgPSBfX2V4ZmF0X2dldF9kZW50cnlf
c2V0KGVzLCBzYiwgcF9kaXIsIGVudHJ5LCBudW1fZW50cmllcyk7DQorCWlmIChyZXQgPCAwKQ0K
KwkJcmV0dXJuIHJldDsNCisNCiAJLyogdmFsaWRhdGUgY2FjaGVkIGRlbnRyaWVzICovDQotCWZv
ciAoaSA9IEVTX0lEWF9TVFJFQU07IGkgPCBudW1fZW50cmllczsgaSsrKSB7DQorCWZvciAoaSA9
IEVTX0lEWF9TVFJFQU07IGkgPCBlcy0+bnVtX2VudHJpZXM7IGkrKykgew0KIAkJZXAgPSBleGZh
dF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQogCQlpZiAoIWV4ZmF0X3ZhbGlkYXRlX2VudHJ5
KGV4ZmF0X2dldF9lbnRyeV90eXBlKGVwKSwgJm1vZGUpKQ0KIAkJCWdvdG8gcHV0X2VzOw0KZGlm
ZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oDQppbmRl
eCBlM2IxZjhlMDIyZGYuLmQ2YzRiNzVjZGY2ZiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2V4ZmF0
X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBAIC01MDEsNyArNTAxLDcgQEAgc3Ry
dWN0IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoc3RydWN0IGV4ZmF0X2Vu
dHJ5X3NldF9jYWNoZSAqZXMsDQogCQlpbnQgbnVtKTsNCiBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9z
ZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQlzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBpbnQgZW50cnksDQotCQl1bnNpZ25l
ZCBpbnQgdHlwZSk7DQorCQl1bnNpZ25lZCBpbnQgbnVtX2VudHJpZXMpOw0KIGludCBleGZhdF9w
dXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywgaW50IHN5bmMp
Ow0KIGludCBleGZhdF9jb3VudF9kaXJfZW50cmllcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBz
dHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyKTsNCiANCi0tIA0KMi4yNS4xDQo=


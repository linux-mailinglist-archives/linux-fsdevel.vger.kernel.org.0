Return-Path: <linux-fsdevel+bounces-4841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C05804A39
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EBDDB209C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD012E55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="KlcEE5nj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9820109
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 21:29:31 -0800 (PST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B50wCUF001199;
	Tue, 5 Dec 2023 05:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=8tc1qM0Upa/KWoxJC1A4ftWC+i9gEgAD0il1sSTiDiE=;
 b=KlcEE5njgsWJztxQE+oDkMpHA3xovBAHbnagw28Y+L0s+Je+2NegK2qhJmBEu7Ar7lV6
 6k50RV3zRufLxttLW+6Mza+D8pNCtOY6IvE+DE7wA6A7IvFQCZTgKWnfnav7ji6hW7Ie
 vhdEZ5bXUpvfwfblunv5MDJ7okrHah6uWEcOkszxu7FjceF2d3Y1hNG8VRSqggu8Hvxo
 Su1sgoI8WhJCy/Abt+qMPJyg30/mecC3mZtjZiK6Smr9eaxFIyPFjeiBMHmOxmGz62Em
 5l4XPjLkGtH+thmRLzycCval5zTRfhOlWLoXCyST3050kn5MtsWHCJC6QAGjcpnQhG/n zQ== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2113.outbound.protection.outlook.com [104.47.26.113])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uqsr6ttcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 05:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5nkB23UxTAuQeoETWwmjrrbOd7Wb0ecIce4UV1CNGHL8tRmOJk6kwkWRWyyK9eJdKAAYpkPA9TVnFHPpPJRTXQc8BpJ5/pj44asHydAGSRFHJbMMzAzZtvylKwAuw2Ej+WAMLxLgq5/HVt5pZAaLeB82WQdzksU78Q/9kFo2ZvOEsk0DYGkXvSqJDRfF2vzUzbQNYpEythMid9nVuU/ThzR3V+vi33OX9fQKdHU0z+WU9CQBfcpE7RY5a34pWPevUjhKERbZIpoe/NtHTlckx+tBHRoOEBH37inygxv/0DCffG41vKEqopZoVIPbVm0czOmlklinR++wJ4CNeiOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tc1qM0Upa/KWoxJC1A4ftWC+i9gEgAD0il1sSTiDiE=;
 b=LU/b3wxS+iDCzBtHE0yuhptB465qaa7gcY2mJOLrWf1WeH6Y3GNG7S7jIOfGv6cOAhvRId5vWV02lE7dkjImkeFajC0Ay1ZYwutThvwTcU03kKeDffzwvfR9Lq70kHFKoSr6ZaG8eWjaFMykPFyT9O5rCuwoRIQB4627Jez6ikePnCq+RIwgm2c501kNDR2QGpwXbVMhu3f2+ravpjAPwEZd5EsOxiLe713u33kFqJGjy5k2MJKPUpCaEx2tLPxLCMW+Zmb720nxiGbSvDGrrhg3NJEjij0AIP8ujzm9BXogEta8a+tWCjaFifFmIZV4kG2QeC5gQR+mEnmgFh9U+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB8440.apcprd04.prod.outlook.com (2603:1096:101:23f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 05:29:08 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 05:29:08 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>
Subject: RE: [PATCH v5 1/2] exfat: change to get file size from DataLength
Thread-Topic: [PATCH v5 1/2] exfat: change to get file size from DataLength
Thread-Index: AQHaIzqwOA3CBbJcCUGm1LmnmZM7PLCaEEQAgAAaUOCAAAEcMA==
Date: Tue, 5 Dec 2023 05:29:07 +0000
Message-ID: 
 <PUZPR04MB63168390FCD5777EC9EF8EBC8185A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB6316F0640983B00CC55D903F8182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd_VDotfcAHq+4TjM6oEdb7fO-QOuO8sAftNvZGed7o_cA@mail.gmail.com>
 <PUZPR04MB6316B8BAC361A5B2A70FD5098185A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: 
 <PUZPR04MB6316B8BAC361A5B2A70FD5098185A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB8440:EE_
x-ms-office365-filtering-correlation-id: 30b9becb-f6dd-4544-84c5-08dbf5531a1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eoQuyo3M7v6Av5TGCpTwHihuO7eGP4YKglkuVtHeKwURbJCacYU9fuS0rBqfrizK49RnxEjGIG74PvZUxHNe9IzbooxY7Gvg+EUg4UkXalhheTAxOpCWv68HUyMtgXPndzyAS8BROO14axNh+IijB+lnBZSECyYvoIUMosdhIn4S4B2UW1vvnq2AAYFWRMddMhw90VLz+xxSl7vCVdR6YPZaMKXXeGpGR1wp+2DSkmYdq5CnQBDfqrw0qNrkjgA5SApNBOYuPpi+2L5nY8UOtBJ0lUa4uxcSNuyC30cinaZRfjpryK2QEjpruo53DRhu05Mxzs8VSoIwQ2mWG6NGXuyo703q9LBgjLjD79t+05YgLbodxreYl/I1fiZH3UoAletlu5qWVXyDlh6YMVQZjnpQKC96ryZMXLoQre9XwoiwTWmHJx90+tozyNVAKJoNROHihckdbwqIUH1YkzBReVBoCipkDrkzubIYjPGRsCCTlnv4HL6TRWNmkSd99QGXR05aqNIF226/E8+BSJHbZao5RgnyDVrYNoPuIQrPfC+PSzroghCvZsAazbGnMUByicZ2jjif3bzj4yH5MrJDF7Fmyp9VnHIemy18q6KEfhdnMBK9pUhtRl+lXAdYI25i
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(478600001)(9686003)(2940100002)(53546011)(6506007)(26005)(71200400001)(7696005)(316002)(110136005)(66476007)(66446008)(64756008)(54906003)(66556008)(76116006)(66946007)(55016003)(86362001)(52536014)(8676002)(41300700001)(4326008)(8936002)(38070700009)(33656002)(2906002)(5660300002)(122000001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K0VRcE1zSndBWG5qNldpYUtpbTdIWS93bWgwSU1kK0FzL0JKY3VFKzdpZ3po?=
 =?utf-8?B?bXArd2FJVW9BaEkvWm4zOUd6RFJlZW9lWi9OcFB2YVBQdG5ucnZreUtMNlpL?=
 =?utf-8?B?YnVNcjVHVWNGQ3pYK2p6dG1tS2wzUkoxTU5yVTZFMzNseWRqWU1CcnpnSUYv?=
 =?utf-8?B?azJxcWdaMFBBbGwwUGorUEYzWE9YTThGMXJJL2REbWRWKzdZdWRidHJCaDlp?=
 =?utf-8?B?UEJQRVJ0MGY0NzEzQXk5enFqUjNUclpvb3gzZ0dCRThMNXVUUEc0WTBqbWxt?=
 =?utf-8?B?VDZoSWZNdW1yRzdRZjI3MXdka0dCa2l2bTgwSnd1Q1QvazI5MTlNVVZQejBR?=
 =?utf-8?B?SkM5Y1E3clVpZkpkaTQ3Ukg1b0xVcVp1VTA0dUgvbkpXQjJhRU1EbFhob3Zz?=
 =?utf-8?B?b2lUSEM2REgrdUlvZ2R1RW9wZDN1MUJTTkhCcHMrTjhNbWZoL29GNmx2Ni9Q?=
 =?utf-8?B?RkFZMm9IK2FncW9rbVVLQmpHcVhrNEVYTSt1YmNCT2xid1g1TnBrSlkrcHBt?=
 =?utf-8?B?ckV5bTdoaUFzdE9DeGNLTWJpS3pKOXVFay84YWQ4c3VPWFk3U3A3VGxqUjBB?=
 =?utf-8?B?M1hCUkJ0alpjRnorZlQxSHlUWVlFYTM1RnI2eTAwYUw4YmV6Q1BmNlNJUU9X?=
 =?utf-8?B?ekZrZmtDT0xuR1ZsaVl6UVQwM3pBRVJwYWtzZ0hOM3U1YUw2TER2RUQxZjhq?=
 =?utf-8?B?cU1aam1xczR5aURsYWliUUVwc0MrVTB1S0IyR0pJV3pTTjU0c1BsT2RsZkhn?=
 =?utf-8?B?dXZVU0NEU1gwQWRHUVp0aTAxNERHZVFBS2RNOXIxR25MK3R1Mk81V2lvVzl1?=
 =?utf-8?B?NUNIMkdQV0hLTnpJdmV0WWEwdE1LZ3F5b3JnZWNBUmwwWWhiWUxsMHVqT1Nz?=
 =?utf-8?B?eHlXb29GQUVzVG1ndUdVMjdwVVBKZ2hNdlFwaCtNZ3JXY0ZyUlArMEFoRmtj?=
 =?utf-8?B?OEw3TU41TWxqQUh3aDlBOVIzMllpMGR6dGdUSWJFaGRRMXNMbTVydHVZSDlM?=
 =?utf-8?B?SDRZOFZKWVNBVmtUa2VwZVlJVHN0dXJIYlVHVDlhMk5RZ3RhRmJxVzQyNjZQ?=
 =?utf-8?B?N0Q3bVlpT1Z6ZXFDR25LajNvall1WUlBbHRLUFRrU2h4S2FKTUtMZGI1dkR0?=
 =?utf-8?B?aHZ3VzNDbjdrOEkyRWNWMm1xcll4cURrZm1JU2J2cCszT0dPcEwxclk3N0Vx?=
 =?utf-8?B?dzZMU1FINXdtYkg3YWpYQTJocGltdWJsQzhiSmpUTzJ2ZUJybkt5OUhNWW5y?=
 =?utf-8?B?UExib3BrZ3RnZGdaVC9BbTc5eWs1akExYmpuT3BoWTA4QkRBVzByYlVod1Ur?=
 =?utf-8?B?NHM3TmhVWkd4NTRwQ2owYUVpVWVaalZJTVpwYm9wRUlLQ04xcUJxZjErUWc3?=
 =?utf-8?B?MWF6b1FpRlNYRmZtZEM5MWpBei9iWUtXa1pVUENyYm92Zk9ZV1VRU1JPSk9X?=
 =?utf-8?B?WFQxZ0lJWjk1dnRCWnFmdmtvb1dSekp6RUZqc3R1a0w2NnlTTCtPZ0pPdUM0?=
 =?utf-8?B?ZW1mZ1oxcEMwUFZJbFBFU0xRNmZtSVVJOUM5YkVWdGduTHBxMnhRdnNkRnNN?=
 =?utf-8?B?QlRjNW9rM3djVGRtdDlUcTk2dHRyZlFRQ010VHJrdFdkdkJ0Slg3UkRBYm9L?=
 =?utf-8?B?U2tkaldDUW9BclBFTERWb2pEMmtXK3pZWjc3OWhzQmFZWUl0S1B4UzBzcHFU?=
 =?utf-8?B?ZGFIVzJUeHhDaG1FcmJnZ0FUTUtJZGgrelludHZhQzZ3b2tUTjczMm01TXE0?=
 =?utf-8?B?YUcwcDN0VjJjMmhaaFBhZEpUVUxCcjVNK1VaaFdScmVya2lQdHNpNzc3Vy9M?=
 =?utf-8?B?TW9vZU1iTWxPZ3o2d3gvUGFaMmZtbFFzRG1mTVZCdGRrdmJPZWZkYU8yZ3BL?=
 =?utf-8?B?b1d1M1o5K1k4K0tBTkIzKzZGQWFMdEJaOUgrbmt3a1JsdW9ERFZpSWZ2K3VT?=
 =?utf-8?B?Y3ExVUdWdlFYRTFsRUdDTGNpd2ZJeXVRN3V2YllGaldLa2k0WXBXWXhHK1FN?=
 =?utf-8?B?Qno1Q2xxdnFwNVVadWQ0bVhBQWVmNjdGa1VaczBPRWJsSjdmN3J3VlZwMjZY?=
 =?utf-8?B?Tms5cGdBYWllUU9oL01qN0U4SWNWaE9Pd2xGWVVSbFpBcVRSeTVEMFZBZUNk?=
 =?utf-8?Q?nGl7YMPMDa0+YGIPoQXCrlbml?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fkwU+DKy1eNjWzSc66L794sK8CiCoxunaU9wslV1PsAq2Lv/i153ENJ73TKE47gkJgYQu1nikWrqTNFDjdi7DwRmLEgaaMAaEcKNpC7V+L+iXuFkO5Sc3hdlPCEzEjebZvO2bEFhDSd/jJRbIInWaPtvMNy4aaoIKpWv1wuhMW1G0X8JFPcj0GcSzzSBkQ2cOQr5YCLIi1we2I2OZWNGtS6CTFCAH34JA6NChVxXB6iQz3kZnuYptt8jDA81wruaLmelp6dTea4gDgu/1oaONHnw+B1XqUC3jF1KfSb5F9NFbbnWXcyEqvijxL+ZiixHiOazBQqKHLD+GzHKzf4iCRp8kOHtt98yFYD7ahFVMDbLBMNLtYIhrYhSjAaTX3NGUwPEzJpuB/9FPU5Ct4jr+CmZIS6klFzzsqh9F5uBbAqSNYlOizSfta4GuiMb0drTZuGJLrbeMZWoNySNraiGJlPIVvXK9mjmqKlA9nNaZFKftlyq8/fJ9HExU3LGRI/HmFPE3YLdnRivp1vfK9QdmETHE3u7bKQbVh3VRKLU4NwUFXA9CEcQIe++IM0bUEWUfRlow39l7qsitS3O8JeQ3a7yDOF779G7TUIstx/3+IqsUVDxCSATsVv2Y9FeRYje4SqRtrknUNUk7uyWYd6NqRMK3aeXdaBrxam8ukkEjGnGjcwFV8MMICvmQM6IU0UO2aXwPoXK3iJmdvlvGiE5I7W1qdHQhFg5NZa7Rq3Sk7dFc0ESvzX5jAA0GAKQ8toWHe2pRWvJJKRWBqLLKmwfhxzky2LbcaTFEQUWxl6scVphFENschdzL5jGRCE/CWl5dDXtT6QLy5wp3G35fSLjdw==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b9becb-f6dd-4544-84c5-08dbf5531a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 05:29:07.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZq7/M/ItY07e6dh/5JMwOmftx5kdUblXY+WaZTR91VBUaVzxg/f5OJz6mFAcFTd0VbmlfAgNN7be7HG+9fypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8440
X-Proofpoint-GUID: v8Pjf3SejBlL7EfoOK7pbexpkzEBnVEE
X-Proofpoint-ORIG-GUID: v8Pjf3SejBlL7EfoOK7pbexpkzEBnVEE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: v8Pjf3SejBlL7EfoOK7pbexpkzEBnVEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2lu
amVvbkBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciA1LCAyMDIzIDExOjMw
IEFNDQo+IFRvOiBNbywgWXVlemhhbmcgPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KPiBDYzogc2ox
NTU3LnNlb0BzYW1zdW5nLmNvbTsgbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IFd1LCBB
bmR5DQo+IDxBbmR5Lld1QHNvbnkuY29tPjsgQW95YW1hLCBXYXRhcnUgKFNHQykgPFdhdGFydS5B
b3lhbWFAc29ueS5jb20+Ow0KPiBjcGdzQHNhbXN1bmcuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjUgMS8yXSBleGZhdDogY2hhbmdlIHRvIGdldCBmaWxlIHNpemUgZnJvbSBEYXRhTGVuZ3Ro
DQo+IA0KPiA+ICtzdGF0aWMgaW50IGV4ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKHN0cnVjdCBmaWxl
ICpmaWxlLCBsb2ZmX3Qgc3RhcnQsIGxvZmZfdA0KPiA+IGVuZCkNCj4gPiArew0KPiA+ICsJaW50
IGVycjsNCj4gPiArCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOw0KPiA+
ICsJc3RydWN0IGV4ZmF0X2lub2RlX2luZm8gKmVpID0gRVhGQVRfSShpbm9kZSk7DQo+ID4gKwlz
dHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IGlub2RlLT5pX21hcHBpbmc7DQo+ID4gKwlj
b25zdCBzdHJ1Y3QgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zICpvcHMgPSBtYXBwaW5nLT5hX29w
czsNCj4gPiArDQo+ID4gKwl3aGlsZSAoc3RhcnQgPCBlbmQpIHsNCj4gPiArCQl1MzIgemVyb2Zy
b20sIGxlbjsNCj4gPiArCQlzdHJ1Y3QgcGFnZSAqcGFnZSA9IE5VTEw7DQo+ID4gKw0KPiA+ICsJ
CXplcm9mcm9tID0gc3RhcnQgJiAoUEFHRV9TSVpFIC0gMSk7DQo+ID4gKwkJbGVuID0gUEFHRV9T
SVpFIC0gemVyb2Zyb207DQo+ID4gKwkJaWYgKHN0YXJ0ICsgbGVuID4gZW5kKQ0KPiA+ICsJCQls
ZW4gPSBlbmQgLSBzdGFydDsNCj4gPiArDQo+ID4gKwkJZXJyID0gb3BzLT53cml0ZV9iZWdpbihm
aWxlLCBtYXBwaW5nLCBzdGFydCwgbGVuLCAmcGFnZSwgTlVMTCk7DQo+IElzIHRoZXJlIGFueSBy
ZWFzb24gd2h5IHlvdSBkb24ndCB1c2UgYmxvY2tfd3JpdGVfYmVnaW4gYW5kDQo+IGdlbmVyaWNf
d3JpdGVfZW5kKCkgPw0KPiANCj4gVGhhbmtzLg0KDQpJZiB1c2UgYmxvY2tfd3JpdGVfYmVnaW4o
KSwgd2UgbmVlZCB0byByZW1vdmUgJ3N0YXRpYycgZnJvbSBleGZhdF9nZXRfYmxvY2soKSwNCnVz
ZSBvcHMtPndyaXRlX2JlZ2luKCkgYW5kIG9wcy0+d3JpdGVfZW5kKCkgbWFrZXMgdGhlIGZ1bmN0
aW9uIG1vcmUgZ2VuZXJpYywNCm1heWJlIHdlIGNhbiByZW5hbWUgdGhpcyBmdW5jdGlvbiB0byBn
ZW5lcmljX3dyaXRlX3plcm8oKSBhbmQgbW92ZSBpdCB0bw0KZnMvYnVmZmVyLmMuDQoNCkFuZCBl
aS0+dmFsaWRfc2l6ZSBoYWQgdXBkYXRlZCBpbiBvcHMtPndyaXRlX2VuZCgpLCBpdCBpcyB1bm5l
ZWRlZCB0byB1cGRhdGUgaW4NCnRoaXMgZnVuY3Rpb24uDQoNCj4gPiArCQlpZiAoZXJyKQ0KPiA+
ICsJCQlnb3RvIG91dDsNCj4gPiArDQo+ID4gKwkJemVyb191c2VyX3NlZ21lbnQocGFnZSwgemVy
b2Zyb20sIHplcm9mcm9tICsgbGVuKTsNCj4gPiArDQo+ID4gKwkJZXJyID0gb3BzLT53cml0ZV9l
bmQoZmlsZSwgbWFwcGluZywgc3RhcnQsIGxlbiwgbGVuLCBwYWdlLCBOVUxMKTsNCj4gPiArCQlp
ZiAoZXJyIDwgMCkNCj4gPiArCQkJZ290byBvdXQ7DQo+ID4gKwkJc3RhcnQgKz0gbGVuOw0KPiA+
ICsNCj4gPiArCQliYWxhbmNlX2RpcnR5X3BhZ2VzX3JhdGVsaW1pdGVkKG1hcHBpbmcpOw0KPiA+
ICsJCWNvbmRfcmVzY2hlZCgpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWVpLT52YWxpZF9zaXpl
ID0gZW5kOw0KPiA+ICsJbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7DQo+ID4gKw0KPiA+ICtvdXQ6
DQo+ID4gKwlyZXR1cm4gZXJyOw0KPiA+ICt9DQo=


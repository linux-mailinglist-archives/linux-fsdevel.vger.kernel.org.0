Return-Path: <linux-fsdevel+bounces-6988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA04281F547
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 08:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0473281E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C54409;
	Thu, 28 Dec 2023 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="GWsv22BC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5F3C0E
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS6oM1K017341;
	Thu, 28 Dec 2023 07:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=XQc7WilSUqGnVRhUeh5Xfm3jTDGXLHZG0DSA5X05eLE=;
 b=GWsv22BC5b3nJAsz5LlSL9uZGw4666xC3MXATTE9AUH2vd/lQTvuOTAHL7ffiHTZsrla
 ZwgyBS2bw405z/4npr66/EUncMFfhCDga97hHPWWnupbx6nKgd+hoEk8A2wylhLbyuV1
 VocWZI0IaywDlNA1NZxusNcdS+DbKLpDyOxAYCPVuc0Gg2orBHf8j79uyQ5SnUxAD+sE
 T0qpxBx2p1Ts3bXU7fGttyywK+wwwCKFF+9z9TQ8rVql75aHz1COEruuYkoTM/hIlsKO
 IwbHjI7NjRumeheeQeUcljrAf4/s3HC/c11utPit3LQpfOqwqesoA+xkZIZcGBiWi9yP Nw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5qxtbskt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 07:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iziYquhZQgy6YbPUdkvpKajW4Nnzy1ifBAioRNps9cqp6oVsKVRmCCJKqWBgwjUN8foPU5jtH5y/32oA3esajIZuHzzA2kTvTg/cYpli5i4uvnUtEBre46BoWR3HzosW++Q6fKHO/2qS77ZCQYPjmrer3j+kiZ3c5w9iYfcSA9cJr3d6bQBIDzB89wSJPOViRUWteEpu3BiywyffFW9R8mx0G6zmARQRX8rR3W1HQBp5byqo+m/I99cml6HzcBSuNg5r9X/OfC3S0j5pIja+XunK4RfTXGGTBzBZuDD+GpyMelCMFhf5ivSCxTObCVCPmDtBEEdvVZceWwj+fyx5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQc7WilSUqGnVRhUeh5Xfm3jTDGXLHZG0DSA5X05eLE=;
 b=QLemR8LALknkXp/8WjgAaX4Zeb467EtgE545HC92xXD8j4aPPjv7Aa/oEkM2WOchucwwNiwcp1Pyvman45Ln6OFVCUBRq9bJPsoHNuNsWuEAgSW6F44SMbO9Yu9rQB7oIks6h9552f0Ggt9SbhSLgJeYlsNVARlOAOpUBVLvfoY3VZWj2/6TfiCK4dXht0TpvDXXnOCZgVZbFnlYcWumcoCp1a05mC0OWhiueBfAGhRP26jlfO3mD9laGqk+oAWRZKD28Gih3yAyMrInXOEx6ccqM2v3VhmnWlHrI0gpWGOTEoYN5EiECgLAufglWNaTLdG02hA+mbPUb5GFu1pn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PUZPR04MB6959.apcprd04.prod.outlook.com (2603:1096:301:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 07:06:01 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 07:06:01 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v2 09/10] exfat: do not sync parent dir if just update
 timestamp
Thread-Topic: [PATCH v2 09/10] exfat: do not sync parent dir if just update
 timestamp
Thread-Index: Ado5XCkaXD3jsLKFSrmKxdYpGZSlCQ==
Date: Thu, 28 Dec 2023 07:06:01 +0000
Message-ID: 
 <PUZPR04MB6316DC6F496F802C9BE779D8819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PUZPR04MB6959:EE_
x-ms-office365-filtering-correlation-id: 81d43e89-79ad-403c-d258-08dc07737333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BepZ1U0YtQn/YRgaphtcLTBxBBHAezSzBSGDAwTIvkAYLbf471SFR4rOKFwFB63zb6nGYauoOEEjGHb8ldKW7gaPFV2zHRwFhr+uTlslJDEyLtkE6KegY0oT6P8A8OCl2s9KMS0uYYRbygcn6ZXgb7uZ+H1mLauh2sfEKAXOQOtDTClaDkMAa0/v/Vpv5enpnIMn6/tvChxbYbYu7H3q3q4QH3eb/8ok0Be3kVXmGQY8cDMBPAyijCf7drMI0eWREzxyjbFt80xeqGI2/e8WV0WJGSTyIA/V9Dw1SdCZC3kiPefo4fg4X9dKcYBKJavToRjT/QuWEWTkHTp0lAfsgy8ELQ100+NTj4w4bBHrgwwzBj5zRyo97j+Fshkt6EiDos6mgIX69+iokciZlwjsRgEKh/gaMkiV++9Gf7cumZzNMDREYWxkNi2tSxhAxVsK7qujenyopuvuFT4S+YipBNNjplzPizfC5FuSDs3WkNNj/uxEvSJp/jdLZo/QQNH0lnfIq2zgYyCDQbSH26gcqXxgI+R7xHvuUfwlg96QCN6bZlVmFPStPQSjXbY456nZR5IPNBWUyuo6SkaHhX2T94kD5QSiSla4wD8tnDc3375rQ8BN0JoZ0FED4JBPmJAf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(66556008)(66446008)(66476007)(76116006)(5660300002)(15650500001)(64756008)(66946007)(55016003)(4326008)(52536014)(8676002)(8936002)(316002)(54906003)(110136005)(38070700009)(9686003)(107886003)(7696005)(478600001)(71200400001)(26005)(86362001)(6506007)(33656002)(122000001)(41300700001)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bDltTU5qQjZ5bEt3bzBZdzBEMUNoUUh0M216cCtkcnA4enNQTEZIUHdKTTJw?=
 =?utf-8?B?ZHBMMEJ6ckRrcGtOYWhncEZtTm1GMUxpOUxtSWlTcWUzMWNJSlgrZVNVbi9l?=
 =?utf-8?B?ZXBFSXBZUE4yTklPR1AyT3NEbnJhMk9vUjFZK28yK2l1TzhuTEltU0NDOTd1?=
 =?utf-8?B?Z1kycGhPc20rZmtGU0tud0o2OUZkcFdSenljaXhKYS9mbkJGbTB5Nlh5N1FV?=
 =?utf-8?B?dmE2dkpvSC96cXJabzgwTkp5RlQ1SDJJUjhYS3ppaDZpWWh2dmFYZmNuSEJj?=
 =?utf-8?B?RDhzUmlrWk4wMEJOdG1XcjlaR29zaTMrYkNFNnRXZDVUUUZkQXJFOXhRaTVz?=
 =?utf-8?B?UG96TFZkS3Y0QTZwcURxNkszeE1jNk1RZ3RiS3lFcHoxcVZEeUlablJEZ1Yy?=
 =?utf-8?B?MXVOMG1XSGs5MlNIRSs5ZVVqOWtTSkFZbmk2OFp5Nmh4d2NRcjZJTVozaDVw?=
 =?utf-8?B?MDkyMHk3eDAvUldCR0FwS3VhU0FnZWo0RSt1WElGKzdCTURhOXcyUmZDK2dt?=
 =?utf-8?B?MGp2bTR3MU4yRWx2cmUxYmlDelBkcUcvczRvcmpwQ2ZVcEZ0TWJPKzYwL2hR?=
 =?utf-8?B?Y1hZTTBtWkZ1azI0cEFHLzBHTG9ibXJtY2cxMzVpZ25rK0dyTjluZnVhdmp3?=
 =?utf-8?B?bHRIQVl0SDg1VXhYK1ZzVGsrNzFhNzJNRjVnM2YxaCtMc1hIVGVmamdDZ2lt?=
 =?utf-8?B?RWxPSnN4Mkg4M3RJMXN4NGVZTlZlUU8xNnB2ZUthbVdndmJBSWxtSmFtTHVW?=
 =?utf-8?B?V2RFNUlPYmJmNGlFenVOMCtBa2E5aW15cldQZnlMdzBvZVdHNWVFWG5VWkJN?=
 =?utf-8?B?Zk5oeHpleFdqeVZsTFVCakFkVnM2SlA2WW1jZWFFeVJsQ1ZYWTYzdytHWEhG?=
 =?utf-8?B?M2RraC9XZG13Z3lsSnhxTFd5QWtRNExtSmFkWW9meFd1T0VGUmFvU3FXNGR2?=
 =?utf-8?B?ekFQbEFFMVdMWUlIVm54bDZnY09mQ2VHNmd1NFB1YjNoSGdBQ2IxSTJSV2ZQ?=
 =?utf-8?B?NjlWMHZDWnVSQ2J4aDljcEd5UzZpakNsMGJVT3NzdUpWRk5iU1dBMnRtcUtv?=
 =?utf-8?B?U09TUUUrYVhkZ1pxbExSdUQwdVBuVWc3a04zOU1lQUtMTTI1Zy9ZS3ZzUUtF?=
 =?utf-8?B?eVlVSkFjZm13OUtxcHBVb081eStCdTNvdzVpb1hHekJrNDF5WDFqRE5hRXI5?=
 =?utf-8?B?U1BWN0Nlbk5EMnNDUUhpUG9DUGZZYVNFUWkzVGpTWExZN3JFbC9mWFpieDNR?=
 =?utf-8?B?SFpiTXI3OTE0M0RjS0RPNkN6ZkN6VFpKYUNGKzlwNkpyNHJNck85Wi8zSWVM?=
 =?utf-8?B?R1VpeXhiZDRqeU9RazlIQ2M5K1hBZzcwcGF1Sjl4SEo0aFNqVlF6bEFSUzNx?=
 =?utf-8?B?cEpUVHptcEQ0eTR5RHdxTWNkZFdGSHhXMlhZM0pZNDlTeDNRVGpXN3Bta1pt?=
 =?utf-8?B?OGYxWlYvOHNCdEVuUVJ5bWZWbUVVbG5ucEVMQi9MRVY0WFVRRmVnMkN0dHF1?=
 =?utf-8?B?dklQVG1HWm1mU3RpdEZTazlQK3BEU0NSb083UEprYVI5ZTJMYWRlaWduOUtO?=
 =?utf-8?B?U0dUSnB2cVBneGRaamRMajhCWXF6dVVSRnFpaTVsR2dxbHh6S1IxUERIZGdX?=
 =?utf-8?B?YTl2dkRWVTJrd0ZzSkRUdlRmdUY2YUdTd0xtbzRKYXFQVEZuVEV6K1o2VnA4?=
 =?utf-8?B?YlpsTXBwbjkyeER5WUp3MmxGdDlZYzRRamwydEk5MitDWWp4YjluWE1PTko4?=
 =?utf-8?B?N0NtUy9wNGtKWE9IWFUwVUowS2c3VGMxSFVpejY3a3FhUm54cVora2UvQmFN?=
 =?utf-8?B?WGVXUXlBQlp2QUNZTTUweWRZNWVBUHVuRmhqWjRvWG1sWDV1dkpFMU1KNmwr?=
 =?utf-8?B?YVpRbm1zQUIrTzZKQ3hDVkxlWDZDMVZpSDNQY2E1RTZGMHRNVEQreHc3THJo?=
 =?utf-8?B?N0Zqc0xBaTFLaU5COFpPOS80Ukw3RmRJMzRPM2trK2RPYm9PVDV2THF1ejVx?=
 =?utf-8?B?VjNCbFI2alNZQ3FFRFR6R3gvb2VhdW0xZzA4a2hUSVZMT0Q0eDYzbzNrc1Yv?=
 =?utf-8?B?bzhNaVU5Z2RhRm8rSFh0TThEeWtJVVAyc0VWSXlvMEYzOFBxbDE0T1lLaFVr?=
 =?utf-8?Q?XyLjVb6sX4JSjh6lW2z8+hjY6?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ev/Spd2Y7Q971iF9kFDHJ1qDlVsfxjftw3bgFpYkA391DJF7olqTgC4Tcoay7918G2EXrDJ8CGX9Xn46QGw03BmOxV2oZnokuBKkcil3KN1mHzB4RlOOHPr4AMe+6vaDsh/ITU8gs+L0NzIBiZ3Cs/+utZrjCE9iq+ubcIqeUffnt9ByHtTxM6g464f+wzfnbouPWrvu+BSLz+jk5XQD1P1bJlx4y8vicpDooyW1ZIdUCOWERcpoHqa2Xizuryo3RmshikHjMMHofP1MSKCdqIgU21sUumYo6n5q3DUqmdW4nW/zc8khyiR/1eh6TErGJMCeu+lwQ3r/kY7jenAzu2oWMO1P1HZxWs9Nc5GvyApLhscbWz6K1no9Fs1FrShRx5sA0MRaj2dMsV73o0wUziLdetSb4Xy3nuIXIMga1+h+918EwdTnGplcl2cjx8pHCAleZpTDAr7rt/RBvdNm6JZaBcxEAjet/xcUhcfcJhX3YyVfejHlao3z+6IrNFJ0pjkCv09u+9pfxKpZv3o3UKvBDT6xiN/lSbjNDz0csNu3CTR2Y42UlHmBSShgguzW4LOZ5nsBNRa6MzgP7+8x6t46QE7Z7FdxUBAXirKILSNg5ipI23d1SXPgENqEaJ4j
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d43e89-79ad-403c-d258-08dc07737333
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 07:06:01.4777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhWhx8LspX1JLKPVyr5/x9yyR0ErB5wtbJ3i/DsESCLuJCqBGYz90eRaBBCq5XLUgjrqnRTSualtxwpaxX3g6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6959
X-Proofpoint-GUID: JY5QemxAGC9vJom_98rTG_bljFcXiw9_
X-Proofpoint-ORIG-GUID: JY5QemxAGC9vJom_98rTG_bljFcXiw9_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: JY5QemxAGC9vJom_98rTG_bljFcXiw9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

V2hlbiBzeW5jIG9yIGRpcl9zeW5jIGlzIGVuYWJsZWQsIHRoZXJlIGlzIG5vIG5lZWQgdG8gc3lu
YyB0aGUNCnBhcmVudCBkaXJlY3RvcnkncyBpbm9kZSBpZiBvbmx5IGZvciB1cGRhdGluZyBpdHMg
dGltZXN0YW1wLg0KDQoxLiBJZiBhbiB1bmV4cGVjdGVkIHBvd2VyIGZhaWx1cmUgb2NjdXJzLCB0
aGUgdGltZXN0YW1wIG9mIHRoZQ0KICAgcGFyZW50IGRpcmVjdG9yeSBpcyBub3QgdXBkYXRlZCB0
byB0aGUgc3RvcmFnZSwgd2hpY2ggaGFzIG5vDQogICBpbXBhY3Qgb24gdGhlIHVzZXIuDQoNCjIu
IFRoZSBudW1iZXIgb2Ygd3JpdGVzIHdpbGwgYmUgZ3JlYXRseSByZWR1Y2VkLCB3aGljaCBjYW4g
bm90DQogICBvbmx5IGltcHJvdmUgcGVyZm9ybWFuY2UsIGJ1dCBhbHNvIHByb2xvbmcgZGV2aWNl
IGxpZmUuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNv
bT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9u
YW1laS5jIHwgMTkgKysrKysrKystLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWku
YyBiL2ZzL2V4ZmF0L25hbWVpLmMNCmluZGV4IDc5ZTNmYzlkNmUxOS4uYjMzNDk3ODQ1YTA2IDEw
MDY0NA0KLS0tIGEvZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhmYXQvbmFtZWkuYw0KQEAg
LTU0Nyw2ICs1NDcsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X2NyZWF0ZShzdHJ1Y3QgbW50X2lkbWFw
ICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsDQogCXN0cnVjdCBleGZhdF9kaXJfZW50cnkgaW5m
bzsNCiAJbG9mZl90IGlfcG9zOw0KIAlpbnQgZXJyOw0KKwlsb2ZmX3Qgc2l6ZSA9IGlfc2l6ZV9y
ZWFkKGRpcik7DQogDQogCW11dGV4X2xvY2soJkVYRkFUX1NCKHNiKS0+c19sb2NrKTsNCiAJZXhm
YXRfc2V0X3ZvbHVtZV9kaXJ0eShzYik7DQpAQCAtNTU3LDcgKzU1OCw3IEBAIHN0YXRpYyBpbnQg
ZXhmYXRfY3JlYXRlKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRpciwN
CiANCiAJaW5vZGVfaW5jX2l2ZXJzaW9uKGRpcik7DQogCWlub2RlX3NldF9tdGltZV90b190cyhk
aXIsIGlub2RlX3NldF9jdGltZV9jdXJyZW50KGRpcikpOw0KLQlpZiAoSVNfRElSU1lOQyhkaXIp
KQ0KKwlpZiAoSVNfRElSU1lOQyhkaXIpICYmIHNpemUgIT0gaV9zaXplX3JlYWQoZGlyKSkNCiAJ
CWV4ZmF0X3N5bmNfaW5vZGUoZGlyKTsNCiAJZWxzZQ0KIAkJbWFya19pbm9kZV9kaXJ0eShkaXIp
Ow0KQEAgLTgwMSwxMCArODAyLDcgQEAgc3RhdGljIGludCBleGZhdF91bmxpbmsoc3RydWN0IGlu
b2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCiAJaW5vZGVfaW5jX2l2ZXJzaW9uKGRp
cik7DQogCXNpbXBsZV9pbm9kZV9pbml0X3RzKGRpcik7DQogCWV4ZmF0X3RydW5jYXRlX2lub2Rl
X2F0aW1lKGRpcik7DQotCWlmIChJU19ESVJTWU5DKGRpcikpDQotCQlleGZhdF9zeW5jX2lub2Rl
KGRpcik7DQotCWVsc2UNCi0JCW1hcmtfaW5vZGVfZGlydHkoZGlyKTsNCisJbWFya19pbm9kZV9k
aXJ0eShkaXIpOw0KIA0KIAljbGVhcl9ubGluayhpbm9kZSk7DQogCXNpbXBsZV9pbm9kZV9pbml0
X3RzKGlub2RlKTsNCkBAIC04MjUsNiArODIzLDcgQEAgc3RhdGljIGludCBleGZhdF9ta2Rpcihz
dHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsDQogCXN0cnVjdCBleGZh
dF9jaGFpbiBjZGlyOw0KIAlsb2ZmX3QgaV9wb3M7DQogCWludCBlcnI7DQorCWxvZmZfdCBzaXpl
ID0gaV9zaXplX3JlYWQoZGlyKTsNCiANCiAJbXV0ZXhfbG9jaygmRVhGQVRfU0Ioc2IpLT5zX2xv
Y2spOw0KIAlleGZhdF9zZXRfdm9sdW1lX2RpcnR5KHNiKTsNCkBAIC04MzUsNyArODM0LDcgQEAg
c3RhdGljIGludCBleGZhdF9ta2RpcihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlu
b2RlICpkaXIsDQogDQogCWlub2RlX2luY19pdmVyc2lvbihkaXIpOw0KIAlpbm9kZV9zZXRfbXRp
bWVfdG9fdHMoZGlyLCBpbm9kZV9zZXRfY3RpbWVfY3VycmVudChkaXIpKTsNCi0JaWYgKElTX0RJ
UlNZTkMoZGlyKSkNCisJaWYgKElTX0RJUlNZTkMoZGlyKSAmJiBzaXplICE9IGlfc2l6ZV9yZWFk
KGRpcikpDQogCQlleGZhdF9zeW5jX2lub2RlKGRpcik7DQogCWVsc2UNCiAJCW1hcmtfaW5vZGVf
ZGlydHkoZGlyKTsNCkBAIC0xMjM5LDYgKzEyMzgsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFt
ZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwNCiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IG9s
ZF9kaXItPmlfc2I7DQogCWxvZmZfdCBpX3BvczsNCiAJaW50IGVycjsNCisJbG9mZl90IHNpemUg
PSBpX3NpemVfcmVhZChuZXdfZGlyKTsNCiANCiAJLyoNCiAJICogVGhlIFZGUyBhbHJlYWR5IGNo
ZWNrcyBmb3IgZXhpc3RlbmNlLCBzbyBmb3IgbG9jYWwgZmlsZXN5c3RlbXMNCkBAIC0xMjYwLDcg
KzEyNjAsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1h
cCwNCiAJc2ltcGxlX3JlbmFtZV90aW1lc3RhbXAob2xkX2Rpciwgb2xkX2RlbnRyeSwgbmV3X2Rp
ciwgbmV3X2RlbnRyeSk7DQogCUVYRkFUX0kobmV3X2RpciktPmlfY3J0aW1lID0gY3VycmVudF90
aW1lKG5ld19kaXIpOw0KIAlleGZhdF90cnVuY2F0ZV9pbm9kZV9hdGltZShuZXdfZGlyKTsNCi0J
aWYgKElTX0RJUlNZTkMobmV3X2RpcikpDQorCWlmIChJU19ESVJTWU5DKG5ld19kaXIpICYmIHNp
emUgIT0gaV9zaXplX3JlYWQobmV3X2RpcikpDQogCQlleGZhdF9zeW5jX2lub2RlKG5ld19kaXIp
Ow0KIAllbHNlDQogCQltYXJrX2lub2RlX2RpcnR5KG5ld19kaXIpOw0KQEAgLTEyODEsMTAgKzEy
ODEsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwN
CiAJfQ0KIA0KIAlpbm9kZV9pbmNfaXZlcnNpb24ob2xkX2Rpcik7DQotCWlmIChJU19ESVJTWU5D
KG9sZF9kaXIpKQ0KLQkJZXhmYXRfc3luY19pbm9kZShvbGRfZGlyKTsNCi0JZWxzZQ0KLQkJbWFy
a19pbm9kZV9kaXJ0eShvbGRfZGlyKTsNCisJbWFya19pbm9kZV9kaXJ0eShvbGRfZGlyKTsNCiAN
CiAJaWYgKG5ld19pbm9kZSkgew0KIAkJZXhmYXRfdW5oYXNoX2lub2RlKG5ld19pbm9kZSk7DQot
LSANCjIuMjUuMQ0KDQo=


Return-Path: <linux-fsdevel+bounces-14105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA85877A5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF931F21E32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010961947E;
	Mon, 11 Mar 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CZVYWJY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42E182D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131145; cv=fail; b=RR3j/FwilTeFJI34YBotBlcvAyLVg1PRR9jY2Th5OOlBdJFMysRsVn/tiVACPgRKzgNn4R1CHfyEZLqG8UP6eOlt5yut/7L5tAT64aWgPFvWWOm8394J7e2WVzjhGi1xHCgttfOcv10DdBPbjbD3ygvqjD0/Uj4VV9XnslFVk/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131145; c=relaxed/simple;
	bh=Yzb+w1u1OfVmDuaSY0BjFftuB/fbJOqOOoUZEpAHqdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eLo4uV63+fe34TghLFd9ouzK5lqYNDdbitMx6SvVsWROfPuCCM0ieNUBAIxenY7pcJrfDc2iQ0KWsCrOMpPAbllRR4V5SblvNOde3AZ3h3x/rAxQ9+oA4RclR9kp+q7rXigm3sCejHz55DUK/Ge3ScLXF7aPyILd/OsphelLGr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CZVYWJY5; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B0MdoX032336;
	Mon, 11 Mar 2024 04:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=Yzb+w1u1OfVmDuaSY0BjFftuB/fbJOqOOoUZEpAHqdE=;
 b=CZVYWJY5Ohto8e2T5X2pX8kITCdPfYX6BkGmBf+kFAcjfRjtpltO6ODOP0u0omvRgaL2
 Fs2vp3etJtSKsikCOtcxjN6RNhqZRX2ofwqMxaFa5WUt3bFS5ovozfoqQ63CtlgliTk6
 qDZDhUvvsosvhhDZHViQ9Lsp4v/fJ2i39bZdO2X/cabz5XQIRpvQPazobztFBiH/gl7d
 apJQ2pRAlFtBn/nJ9EkkpxM3hzZNBscY0s03kJ2KhOqmNVPhevTwOeTY42DAakCvVUKb
 YnA/ZAH8GuhoqtGsfJkH+TviiTyysCBVJfIYo08V7JPERn9FQzMH43pzUswY1QFNtQbN 6Q== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wrdyk1knh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMHmug9rUXJyWqQd6RvGGEZkivopjTe6AwgibNyf2IXlBFgyVCISh/mA9EymaKmsrEND1OKz3CK7EYvC3EGlW01xSt+aBEnXEo0RztAALb3bn7iUuSR4f5GO+lNYoiMxBr3MO4MbAT9uQX0zkUbbhEj0MWkt3pmXpQMBwGQtf4zeSlHVjJZjgju9E1hWIs2X1W6uGPc5b3Tu5fFydEU5zB29Wdvg8tK/jev/O8BHpPDwFErrjNsj9ETH6IE5wyMC8v5VF3NC1nLJGvc+i/Zb6gBYXdwC+d/cBr4M9dbMNdevWBKdWSzSt4y9H/qBnlPSWwewcU9KcCS6SbQVq4VEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzb+w1u1OfVmDuaSY0BjFftuB/fbJOqOOoUZEpAHqdE=;
 b=hGx5mWotJpAAxoBUp3SpuEfaQU6XaA/S9x2uiDdHG+fe9Uwp5RzQ5v80gnA34zCal6IeS+ZL0gYh+0SDsDIhlDsM/bGDopr/z0AR/ZPA1RF8jACivm81bfpln8Tq91J1q7WiZkzOj+OY1XrZM7ip/IaJEWQ0qQJWC6r92BgE1rmSaFmLI6qux5O5XYjN5XnWevhX0qU32xSsPY2irY5rOizaoWDtw8ILkBzMMXqVSiGeUdakCjoTK70bgE7rcc2cXgBingHx738D+cY50srV6qgS+5P7Nit6VF51hygw+pKt3N3+0X4HEE0KFiARdQQoA0TjCAFIrnhQoTSipY7oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by TYZPR04MB6635.apcprd04.prod.outlook.com (2603:1096:400:33f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Mon, 11 Mar
 2024 04:25:31 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd%7]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:25:31 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v3 10/10] exfat: remove duplicate update parent dir
Thread-Topic: [PATCH v3 10/10] exfat: remove duplicate update parent dir
Thread-Index: Adj06Ci11I/FwWfHSMqug1ChQRO1bV+gzWRA
Date: Mon, 11 Mar 2024 04:25:31 +0000
Message-ID: 
 <TY0PR04MB63289A9B7B7B93685255DACB81242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|TYZPR04MB6635:EE_
x-ms-office365-filtering-correlation-id: a5cd984f-e090-4224-2606-08dc41834998
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zVtuYKwcvTAf+e0gpuSg7IpqACERKFqk/UGAFuN27Yh3Bx8FhTzrQN2UhQTZpOk9iClc9po3gT+j8tyBTnAmzVkl96ai5T3ETiIji9FbBtTrNbehIdaJ8wUo+DkRP+mkbXW8Bf4lFYEvYkX0i6q5FIzZC1SVhMdN5hFD6wW9J2dPEEgLPE1/MHmsPI75oNLTsWdcxqtbn9tnuuBk/1pNvd7sKFUqtpogX3j2cwf6YoD94wc/67oTFUtBP79YWH8zB7l+PU1UJZyJ3jyxzpvf2PYhCfVXAgjRTkVcGaQkUpwhOFIRUqllYwouqV1SwSxfxz2gNXBIk5dSx4/QGSoMtRpPAjlQ9GKHwPSIkn0gjgySzekSVvBUtgFaOrQVCpxs8rQjOVQZUEX2XYYTz7rg4My9pjzBfZ18GSV/KMM9CNwlSnZuhT2X0/Jl1nJHp+LlqbE/iPqSewY+RYuSLvKfofWiFkp9co6vVbwA8twI5SGEEimOn6uzRpPIShOtvWkMuPGkiXcoka2C/7qFVSrLVwuUL9Ky1ynfVHnj4c16AKw9kU+2XEww6afFvCVQMtQnuU/c097xbulJg30LmueB/JvJxFeDKl6u/bvRw9fqcrpbUTrHAjNWSvst+PLLW6zBYo6qgvBii1yxR8ATIFrF84A9PvNS/PC+ON0NA8mMMkEU7BvRPFkSP8E/d4MH6wFmh4eso3dwzejKkZZscuzGpg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WHE5Tmo5VHBNRVBzRVhZVVcwejU0TkY3ekJBb3R4WlcrVHY4Q1o3eC80eTdE?=
 =?utf-8?B?dVpoOXpQSDEvSlB3bXBtUUVkM2ltRStoTE44UzhqdUVjc0tkK0JnSUZ1eUtu?=
 =?utf-8?B?M3RnS2QvRFoxaEZzcVpqWmlJaDU2MEVjVmNwVU1HL2l6THJrUkdtSElXVGpn?=
 =?utf-8?B?eEhSTFJDOVJtc0xYTlF0dFFDaTBvZWdtVm5uSmdwMkt2d2VuZG5XejBlK1J6?=
 =?utf-8?B?cUhMK1JnTjAzZ0RRcWhsRGc5cmtFWWJVUkJtNWYrYzdhYTVoYWdFcUJiclVx?=
 =?utf-8?B?bGJFNCsrcWJ5UFB4am5nb0hQK0xYZ1ZDYTcwa1dHQnREa2N6UHpFNnREYWNm?=
 =?utf-8?B?dFB3N3QvSzZYWC8zYnBqZU1jMXVNYzlpdEhpa0dxS0RHSjFSellWdGp0WXZQ?=
 =?utf-8?B?OXEwb3VDNG82YXRFaEs4TnNhVW1uRlUwY0RnL3dMaDB0akxTTHdUTGZrWlQ5?=
 =?utf-8?B?ay90Q0hraFpoRW1EVzg0QXNDRGlQTHFNQjQva0JHQ1lWZWNXNUJKcUQrRFFD?=
 =?utf-8?B?ZWpaNHpxRnEvRUtEaFhQVDRMUGx4R3JyU2lVVGM1SC8wdFlVdVR3bjF4STBl?=
 =?utf-8?B?VHBzckhuVG1DVXZFaUJUUE5ObVNVSFVyNGdBOFY3aVhyRnJPbHVpekFXK2Rj?=
 =?utf-8?B?b1c3S0E2cGdoK3RIUFdlSVVVeTI5RDhMVUFRZldPajNzMXpnOWpsTHBDbS9l?=
 =?utf-8?B?TTZSS2FDWjgzbFZYMjZXem5IUjlDTGNxOGh1VFJ3bE1tNGhFanFlZGh5dWNU?=
 =?utf-8?B?b3BEcGZlSng3dTlucVpxaDJkM0lXNjFISUJ4ZVJoS2gvMjBmbzQ2djNYREtE?=
 =?utf-8?B?cVZ2Rld1VEsrN3EyVVMzNHcrTGkzamhIZDRrbWdsUjlKTTNRRDFvcERiT0Vh?=
 =?utf-8?B?ck1QQWVPL1NHanNqSXc3K29VN3BGSXQrQjMvTE1PL0JZMEhuTWhUSEFqKy9Q?=
 =?utf-8?B?dEVGWHd2N1djelpXeGp1U3J4bHZ5OG1TNUtEcFl0akR6c2VZOE1IY3U1K0o0?=
 =?utf-8?B?WVp6T1VXSlFwWm15RzB5Y2M0N010YTFGek5vVTJaSU9XZFVSdUxvd012a2NN?=
 =?utf-8?B?K2xxTlhJY0Y1SWFHdWtiYnZmbEp4UUVrSXhKK0NtTmRkTGtvU0xCaFZKdWtL?=
 =?utf-8?B?dTBOMjJuNFlkQ25ndy9Yb2tMUlNrdllRa1VoT0tDUmlMVTVOVjE5NllOYWUw?=
 =?utf-8?B?YURINVljVTNOS3BEdFMwS29OVGJmaGp4OUJvNE9IcFZEWDNDWUcxQU1IZkZN?=
 =?utf-8?B?bUJyWWoyUnY0a3UwSW1ZU1lyODVQcnQ3OFhlcStVeHg0MGFHa25LbWdVa2Rz?=
 =?utf-8?B?bnBtNXNSLzVEb3RxR3JLME9aeG02MnJzSWxuZWJzUjBHQ2V2emNWVlAwNTBs?=
 =?utf-8?B?R1I1VU5SOW1ja21aUUxWRFNlMmNJMmEvN0V1UFZoclRqS25pWkVVaTJCTVZQ?=
 =?utf-8?B?TW5GM3BSKzlyWUQrdkI1RklJK2NQZVlrOUgwNnlrNytUMmRwQWZDT0kxVytL?=
 =?utf-8?B?d3RjYWI1UUNvcTZRYW1sZTFjVXFCQ2FoV2V5Tk5ncmlPbUdKeStxRytvSno1?=
 =?utf-8?B?RHVqVUJua3UxREFWSjJkUllCMHBvaFFnTjJNYUdrZUh0WG8wUXBKbGJpM0tj?=
 =?utf-8?B?UmpzR1RJZVR4dWFMQkNtRVBTdXQxbURGVzV1U1h6NEhRZVp5OTY3UGRoR0Ev?=
 =?utf-8?B?Y3FwRWRkWXJJT1c4MXhQY1lpU3N0OENQLzhndkRpTFBFTVVYYmVwRjl5enhZ?=
 =?utf-8?B?d3ZDUU5MWk81VmJoZXZkTWx2MmFRQTdNV0NjRXdHUnNSK0NpV0lIMVN4MGwx?=
 =?utf-8?B?UU1YMm0zVFJLdWNFK1RyU1NXQ3VpVUtjeFVEczRYeU9MV0hIbmZMMy9mRDRt?=
 =?utf-8?B?S2JQRXAxcjZEaTRVV3JZWVdWRFBjNnd5QUxuY3lYb0kwUVozU2I2V0tOMVp2?=
 =?utf-8?B?WTFJSC9ERytzNE9YWWo2elEzUlM0WjRCTzBaV1d2TDRhOHpTdnM2eU9ZRFFz?=
 =?utf-8?B?K2h4dG9COHpISS9TWmRDRzNZVmFFSHFrK1ZDTWlVV1F6RVJYcUpZWWxMck9D?=
 =?utf-8?B?c3R6RTFMVWsweDVXTXc2N056dGVkNW5lYjg4YklDWGZ1Sll5QVlybEs1cjN2?=
 =?utf-8?Q?oBc9qzdmzisz258wlMxBsxCQ0?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QQQNwnE08O12OwmGyjOdgqmyKkyN6C0zHAmlcdrBTBklA0/U+azQW01JXGh+MiLuvIHQ1swAJyER06MGOiKPoeKidGOPcH0zsIldNVASjhLc2JK138Cuzb9F+uovUP/mxCedsBM1dhIk5b+KADhe9wDvR6jFpTk3/bigYhKF92MTw71ZUyIM3aqwJK0NogMlG8AP/aRPnL09v1w5ASVTfsPQJJYuyLiRDpSc26g5LtN1SnZ2UnQFJZWKp0Quaeo83M1gxjvXx7lFRrW/ds88TswuTGw/MG2DqloFSBFPqScZixUcL3gc4tzW02sTMqB/U12u6PfTGoxl4y0xjqsHVCRtpm5/fkJsoufx08BbPOHKxHDBFbjvmyWvaZ4etgQLtqrf6BwwOvEChYJ46mdqmfh/IBUxBIxQ5KzaCBYS4JKsZU/vLi4jO6KhPmR3XBmdehjNJPQC2QqJMPBEFmbmI36c0F06rwNYH0x5CMWhOVydi5jn97Y70FndGWevSqz37K4AsyLh+JnTSk26FRHaf2tp4K0nzSIUdhIhRa0TT11Fo2V2f66wBqMD+yjkPgkzhFXXAeAn6hluXcPa48mTDKoLmGNFz0lzqEViS+7w1/KWiZXfXn/2YeIlqXeJj3wD
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cd984f-e090-4224-2606-08dc41834998
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 04:25:31.0604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9v6z40WDuecgdnXjSeePtTwVzZVmfuc29nMX+6c3yVNiAK9rSpwMpp1NjjJkZXqmWRPpzTlUsQbjwhKmS+YDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6635
X-Proofpoint-GUID: 72oXybfPp7ky4HPb2-fxHbUQ0arDBjlq
X-Proofpoint-ORIG-GUID: 72oXybfPp7ky4HPb2-fxHbUQ0arDBjlq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 72oXybfPp7ky4HPb2-fxHbUQ0arDBjlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02

Rm9yIHJlbmFtaW5nLCB0aGUgZGlyZWN0b3J5IG9ubHkgbmVlZHMgdG8gYmUgdXBkYXRlZCBvbmNl
IGlmIGl0DQppcyBpbiB0aGUgc2FtZSBkaXJlY3RvcnkuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpo
YW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5
Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFA
c29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9uYW1laS5jIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZh
dC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWkuYw0KaW5kZXggYjMzNDk3ODQ1YTA2Li42MzFhZDll
OGUzMmEgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1l
aS5jDQpAQCAtMTI4MSw3ICsxMjgxLDggQEAgc3RhdGljIGludCBleGZhdF9yZW5hbWUoc3RydWN0
IG1udF9pZG1hcCAqaWRtYXAsDQogCX0NCiANCiAJaW5vZGVfaW5jX2l2ZXJzaW9uKG9sZF9kaXIp
Ow0KLQltYXJrX2lub2RlX2RpcnR5KG9sZF9kaXIpOw0KKwlpZiAobmV3X2RpciAhPSBvbGRfZGly
KQ0KKwkJbWFya19pbm9kZV9kaXJ0eShvbGRfZGlyKTsNCiANCiAJaWYgKG5ld19pbm9kZSkgew0K
IAkJZXhmYXRfdW5oYXNoX2lub2RlKG5ld19pbm9kZSk7DQotLSANCjIuMzQuMQ0KDQo=


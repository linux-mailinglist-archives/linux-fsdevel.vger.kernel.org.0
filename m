Return-Path: <linux-fsdevel+bounces-47342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43825A9C510
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CB016C5E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F623D2A3;
	Fri, 25 Apr 2025 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fl51sUpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013003.outbound.protection.outlook.com [52.101.127.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940F21D3DB
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576248; cv=fail; b=SSq4FX5/VNfFgo01vE7UHtyi5QAhElBFQ5gOCmNIAPC1ee6jw6tGHPyTtpbnxa2/28HxLO5gdPHRDOllFv0m/uneFrEDxMdfSTVoooR+27ndXbjDHQjj9b0cLAu8mI3oUV7p2Rq/FgaPM6BVFw9fcC/uVtmLmY1zz1UMzM/7Fcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576248; c=relaxed/simple;
	bh=XG7ZiQZ8gyFSPBm116xQA9ycXlkxzIdj8lOrFbT3OgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CPEe1qHRcRNi9F0Yy4ASYLLNvDYIblhrtRMhTos+VafAZoKPwbzOrf0HaB7Gb4/DexY84GeUbMEpAsQo01Heq/ZB0x1ohx+sX/4TtMzP8dww1xirxL3IvAt+Jm8K2bKah1nNyBJ15R6lvY7MD3wqv+j1snSeXfHJ/PRHoSjKgrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fl51sUpY; arc=fail smtp.client-ip=52.101.127.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6/LCg+wrIyAIL6oZU5m53dCDpbnoXews3Ggh9vquNOs+azG6el+Vq74p8qGm8mEpF5NTvicDCgkQJFoM/hJ11X2C70WOARESjMqsszUrBl7dCLFk4eEE3A1/JPpo4R3fT4ADT9z38CCSqYmuZxhg2XTyCHjqpCyc0qVH855eD4MSWQCSQnSXM+sptdq0ruOD9camYK9RThDeKTUFeS0zcFv3jzUtQ5bUFUYY3RLMxIJQKCs6sRW9UDDN4wdeijo1iCpuFT5jY01HE6wYI8NACIhDKYAe+zdGqUC1dXvy4L7I6tn2sLWRXISCztyo0jeDSKa6JdxG/Zj/XvsUTYLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG7ZiQZ8gyFSPBm116xQA9ycXlkxzIdj8lOrFbT3OgA=;
 b=tIDWpsHR8pLkuM6EJZu20gNtwcpcoEiBHJoS1U99QdW389JEAm93CLed15I/QSe5whrlGe8EIOhpKQv9IIIYjV6hnuniq9VC75uGQiLKjPuthTaux9VddAQPTxcox2bRCmkbLLKsqAU0/vv511/MxZ4d1M+BB8BmWLKhDcXkJ/dr9R+Z6YuWPvp7RgDgzyKRAnT9LRLVQtMgvRJ0hOuO7koLXRfFa2tAwN9qimYW04hcefElnTZPuGIU4dIrO53gGoGboAXJS0CjSICKCrWekPxUes9PcdhRigjqpjvoc/B1i5LoZ2i7s76pe4DpBfKHBTEHnF8Jqnwn6XwcP1r8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG7ZiQZ8gyFSPBm116xQA9ycXlkxzIdj8lOrFbT3OgA=;
 b=fl51sUpYEEBOFL6z+ZYgjm+Xn6Ia9NZrj3glrD1bVsvii4+CO/WFwTtHsrVBMJcyWqU+95mVIOn6yndMbeWIp17jxV84RokL7r8S6ZC5WNMC0VTq+czf+vUabbFV4L01mkxItKU8PqjbQUKJYasRaG4Ml3QUULa4R76d56r5r21MmQOH/bObgXY7ma1xj+kq2+z0f8CqGY+D6vn+nh6kcm9g4GaGEmGQj/zX020B3YIFiI2tjqlUoa8hBDbPvP4030AGBB0xiHqRfyDwwVG0AR+0A7DOg33YbNVfI+mxYRazFVRhaeymeN/wa92cpPm+GHdioIDktRoQYuar/4aRlw==
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by PUZPR06MB5435.apcprd06.prod.outlook.com (2603:1096:301:ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 10:17:22 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::6257:d19:a671:f4f1]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::6257:d19:a671:f4f1%6]) with mapi id 15.20.8655.033; Fri, 25 Apr 2025
 10:17:21 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "slava@dubeyko.com"
	<slava@dubeyko.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBIRlMvSEZTKyBtYWludGFpbmVyc2hpcCBhY3Rpb24gaXRlbXM=?=
Thread-Topic: HFS/HFS+ maintainership action items
Thread-Index:
 AQHbswekna2OCwxWoE2e/XeZ/ACbe7Ovn+GAgACQiQCAAAnhgIAAAEsAgANb3oCAAJkF0A==
Date: Fri, 25 Apr 2025 10:17:21 +0000
Message-ID:
 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
				 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
			 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
		 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
	 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
In-Reply-To: <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB5275:EE_|PUZPR06MB5435:EE_
x-ms-office365-filtering-correlation-id: 70dcc2d9-5489-486f-50cb-08dd83e25dba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTI2aGxnR2c1c3dUekdrcE00OUJFNVQzV1V3cUVsNWFka0V5TmxxN0t4Y2Fl?=
 =?utf-8?B?OTBxdXY2RUVzSktEcm5DVnlTMVJtRUZ5UlFjdmNXQmFyWk9sUnVITnJaWXI3?=
 =?utf-8?B?ckpVay9RTDlHYzlRSFM3ODJjaHQwNlNPL3FOOHcvbUdaQTgvOG9Fd21JQlN6?=
 =?utf-8?B?S2tKcURTY0hvdXgrZlloYW03c25aMWRoWXdSUk9LREczR3dERlJab00vTFoy?=
 =?utf-8?B?c2tQeXdkaUxPaFNBZjlSd0VXcTEzOVh5bXMrZEhLbGZ0QnpiM3p1U08zd2wx?=
 =?utf-8?B?bEtxWm53ZWVQRVFFcWoxREd5M2N0ZUYrMEJ4NU9Mc3NvL2NFNE1tVHZPUkNx?=
 =?utf-8?B?ODBQUjNIQTVWTE91bGFXZjROcXRiRitUTEoxc1FjVU96eVR0SG9lNXcyaXBH?=
 =?utf-8?B?TStadGc3NnpIdWE2bGRZSVJyS2NXT0tPb1cxQ01DMnlYR2FNMytHQzRBd2hq?=
 =?utf-8?B?U3FTSHM5QU5QV0tZYjU5ZWkvNEc0aWd0OXZsdzdIR3c2NlJtbFcyTEl1RnFr?=
 =?utf-8?B?aDh3TW1YUGpudjgxMmhJbU5tbWd5UGpkcGRiYnMxUEwzeEJzT2U3OWJBUXRX?=
 =?utf-8?B?TWxabDZaSmJ6MHdVSDllaEhyU2t2ZXBFd2dTdlBBdFYyYWJOZ2lWMm9XN0JY?=
 =?utf-8?B?WWFlUzM4RlYxeDlYS21JMmtwa3JwZ1ZYZ2ZqMmIrSVRiUStrM282NklieHNo?=
 =?utf-8?B?a3laNksrVlR2RzJoYWxzRWxtRmhIVWt3dTRLSytrZ2MrUk1wS01lQWMwemh6?=
 =?utf-8?B?SzVKYnlKaktqVmJPem1ya3hEZVVOOTVLQjk4SFBrcGt3NFB6M1A1d2Y4RGhV?=
 =?utf-8?B?VkV3VnU2Skh2bHJDU1owUTFjQms0a0hwQzdTbXNKcUlDem1zSTA5cWNHZ0hy?=
 =?utf-8?B?MFB1dE1nNkRHVEsxMm5YMXk1ZTZ2TmVNMEpjM0NjVlJmMjgyY043V042SUIx?=
 =?utf-8?B?ZEdXOC90elJGVHRLR2g2Uy9sZlhWaDFCZWF0RE1zdEZVVnJicWxzOTJEUTFD?=
 =?utf-8?B?RUhrRUFVQnRHYXp5dEgrMFc0ejZvVVVGUlFpbnBNdHRiWTQ5ekUyV0lIb1Mx?=
 =?utf-8?B?UmVrdnhxMGJIcWJPcHo0Qk9TUDRmYzVia2ltQjFYQVoyMWlpK0dqcURueWV4?=
 =?utf-8?B?YWRjK1BJckVrenY3R05xd1lDQzNOTjB6NjUxZ3JySEdPMEExb0l6eCtmYzMv?=
 =?utf-8?B?V1VRVStQTTQxZXlOeE1FKytkeHphZURsRzN0c2ZGVmI2RFJwRUZwYkg1M29Z?=
 =?utf-8?B?UU00ZDhvN2NWSCtwY2JrL0NqTkpORTRVaDJCYXZZejFTTk9WZkpCTnBaM0dZ?=
 =?utf-8?B?RTFTM0JmcjAvbEFwMVhxajVYbm1MWG43eDFUNEhkTVFLTzBJSDU5VC9haGJM?=
 =?utf-8?B?MUJUNi90NU8wc1grdkVQa3VUMUZJWFBtc0VFSnlnRkV5VC9acVVlVVNHYWlq?=
 =?utf-8?B?SWQrKytZU2M3cnRDQVYzMzZFMmkrTmpueWxnd0c0YlRMaUpuQWlPNHQ0ajZq?=
 =?utf-8?B?OGtWdDFYcSt3aFh4S2NZczdOQnVHVmxLTDFSY2VsSWFyM2tNczUyaEIzOWNq?=
 =?utf-8?B?dTMvcFI3R0ttTWgzaXg5OEdjUFV2alVCY2Z1RUV6eUZRdG4zUW4vYk1MS1Nz?=
 =?utf-8?B?Ykd1R3I4QVRBaTJmR09ObXppMGRLMTVITDc1TkMvTjJwYjhobmlVS3RxUGdW?=
 =?utf-8?B?bE9TRlJFLzlRYVJjY2NDUUN2Y1ZnMTM0SEYxZFZwNjJIZTdQNVBySW1NL0V4?=
 =?utf-8?B?YmhSRllkdzdEeGxodTJReHBEZG1zcWk4YTNIdTZ0OFlOUUxOSDJLZlE0Qlpk?=
 =?utf-8?B?MmR5ekF2V3hoYVZlNjZOajFYd2hlNmo5djMzK0VEdGhVazBTVFJvU0pmUkor?=
 =?utf-8?B?UTkweWU1QnI0d2hacWJ0czVOVmVDQnhKWmFXUzhZUjIvT2lJejZ1YTZYMUJG?=
 =?utf-8?B?cCtMZmIvVE1iKzlOOXV6a05lSVNGSHF1U3lPa3dYQU96TlFCd0xnTE5PNGg5?=
 =?utf-8?Q?tqdpyJFN9ixwiuKjnHGZ1GFCTtYXf0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVA3N0hGRDNhTkVaQ05aN1BMbStaS0UzR05KV2VEN3p5bjV2WnpnR1lkYmhL?=
 =?utf-8?B?NWN1eFoyUlkyWDNCYUJUOWxTeVpBRW85cXFxRmZHSmdqNHgrQUdEUkhWOW44?=
 =?utf-8?B?TVdJeVptWFhMU1RnczBxSFNWWk5McWQ0TVhNTG8rdWxjWU53aE93OGRVemw0?=
 =?utf-8?B?RVFBQ29FTVhjWlVOb3Rnb3cycTJxUmV6Q0dhVmxnbUNDelcxdXRSTlA2bFRT?=
 =?utf-8?B?QUJVeHBTQTNSaFNCRXBTTnJIT3BlMGFFNEdkVDJCUyttb0prQmNFUkdobGtF?=
 =?utf-8?B?NUhQVTRDOWh1WkdvaFh5VEpBaUphZ2Zad2RZcFphcVcrUUNwajdncDVFdXFK?=
 =?utf-8?B?Y0l4YWJhbTI4ZVF0QXMvVEM0aWR0NENZTytnOEgyZmJUWUJySnJ5WVlRUm9k?=
 =?utf-8?B?K25pblY4ZGpjb1V4enVIVHpMVjhoTEJ4OVdIUHhiQ2NkTWFpeHBkK3AvcHdR?=
 =?utf-8?B?akNCUmVacFlCanF1WlQvd1IweFRiY3ArODVOU0xYb095WlNKWXJrNVBLWEhn?=
 =?utf-8?B?Q0lFRktEeW5ubTV4S0wwU2RWc3d4WWFaaFlzMGs1UDFTNmdGeFQrWk01OExj?=
 =?utf-8?B?Y2pJZkwxV1VLUFlDTktaOE5qdHBKa2ZHVld0ZXltaGc3K0o1c2lFOE9iajAv?=
 =?utf-8?B?RDVEclpaYU9NWHRMQWU4aHp6bWFMTmhZWGxVL2RhSER2bm94L1dtQy9IVmht?=
 =?utf-8?B?Vnk2QjdUN0hUZ2ppcU14a1RZbUZFRUFvcXZRcmV5cVpTTElzaHNSdEtjdjIr?=
 =?utf-8?B?TE1EeW12OXFCeGNUbUYya1JST0FVenlvM1ZQNzFNcFR0NzNNZmJMZ2dsMnd1?=
 =?utf-8?B?c3c1L1dIMlFWb2RtMFVkM29CSW5HelRWWTdNbEdhMmlKZ3BkRHpvS3ZrdEk1?=
 =?utf-8?B?SDRBcStoamxWT0lmV0FCczhCQk91NjFRSWgwNnE2SGFSZjFpQXUwODZVSFFh?=
 =?utf-8?B?UDV5QjhNMnA0YnBVOFF2ZGF3MTcwbVR1TjgvakQ0eXlGak5IcEIwUVF2NExx?=
 =?utf-8?B?RmtsZ2FsUmp4YlhsK1JSVkMwWG5ROVRYdFVxQXpQa203U0VkZjE3M2lOS0N4?=
 =?utf-8?B?TEdWZ2F2ODFOQnFFUW5GdUhlQWVBYVlxQUwvVHUzTVMwL2dWY0lWSzVXYUZu?=
 =?utf-8?B?SjB4dy95emJBUXpydGE3dGNJdlFjWmhNVWJXcTRRUk1vbzBtOEp4TnRKQ3dw?=
 =?utf-8?B?Z25rejZubGJlWmlaME5Wa3ZrNG9WTnNpcXc1Yy8vZTk3dkFleXdBTkoxU0x1?=
 =?utf-8?B?bFlYZ0xKZC9vN3g2TFZ2ejIrRGpsSURNMkhlQndra0dsQXFmRVZTTm5vZlBl?=
 =?utf-8?B?aTVYQ2x2SmxHN200SWpOQm5mMDBQcDMram5vVERlSVQ3WGRrLzROV1FQSWhp?=
 =?utf-8?B?SnV0aVZDVThtWWwxQm5yVncvSzF2cjN5QklrNis5b202VmZZNEpiSXVqVWpq?=
 =?utf-8?B?c0NlVTZBelNnNnpUZVJsRUdNMTA0anY5WTBKR0xPeHBqV1Y0cU9YSWVvWFRO?=
 =?utf-8?B?REpWK2pEa0pWZjJUbFJMUjFlRndIKzdtMFk0Tm1EUGxieGkvd25zMGt0ajRF?=
 =?utf-8?B?TFJiVGM1WG9MS2RzS1FwOXFGZnArOXNNczg5ZXZRR0FDa0luUlpiTTRQdzQw?=
 =?utf-8?B?TWJDWGI0VlRreTlIYmpKUkN1T1FESUt3eFptNlZwdnNOdDRVNU1FZWlkbTg1?=
 =?utf-8?B?aE9PWXFMWC9tZkx1RFBVZC9PeWtwd0ZLYkZhN042b0RCYUpSdzgrSWI3bjUv?=
 =?utf-8?B?Q0R4OWNkeFlBRkU5d25sR3NJZGYrMzkxKytKdEZYWkRpc1g0dXdwTElsQjJN?=
 =?utf-8?B?MnUyMk9qNDVmdm1ld0ZYdjhacFBiWHZLNG82WStoN3dvckljcXlIZWdkejJD?=
 =?utf-8?B?Wkd4SklGVUZhaEVBcngvMmFZYWZSaHRXZ0U2WTQ0QkN5RUlSTk8zV3ZzcnJ5?=
 =?utf-8?B?aC9QcWp5em9ya1VRMkE3YVBiNjRXczUvQTk2UUdobVlpMWFqK1pMeDNFMGdC?=
 =?utf-8?B?bWhIZDBpWVB5UzZSM0RaTitCbzloWmZXamZnNjRiTyt6S0tUMnJVNTlPUi9u?=
 =?utf-8?B?SnliUGh5b0xlaHQ3YmE3Y2VPbEwrMEpWVk1EQ1M4cVM5T1J2djNQSTd4dkNW?=
 =?utf-8?Q?lQ6w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dcc2d9-5489-486f-50cb-08dd83e25dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 10:17:21.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVAg9t7jrto/QDq6+30MDvt9lQ0Q7XQvUdfTYYsyXYmrjyPYelMZY7NmogKcxum4BrTCVQYBkslISN5ZXyCDTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5435

SGkgU2xhdmEsDQoNCj4gU28sIHdlIG5lZWQgYXQgZmlyc3QgdG8gY2hlY2sgdGhlc2UgaXNzdWVz
LiBBbmQgaXQncyBhIGxvdCBvZiB3b3JrLiA6KQ0KDQpUaGF0J3MgYSBsb3Qgb2YgdGVzdCBmYWls
dXJlcywgcHJvYmFibHkgbWFueSBmb3IgdGhlIHNhbWUgcmVhc29uLg0KDQpBcmUgdGhlcmUgYW55
IGNoYW5nZXMgdG8geGZzdGVzdD8gSGFzIHRoaXMgYmVlbiBzZW50IHRvIHRoZSBmc3Rlc3QgbWFp
bGluZyBsaXN0Pw0KDQpJJ20gYWxzbyBwbGFubmluZyB0byBzdGFydCBkZXBsb3lpbmcgYSBsb2Nh
bCB4ZnN0ZXN0IGVudmlyb25tZW50LiA6ICkNCg0KTUJSLA0KWWFuZ3Rhbw0KDQo=


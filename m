Return-Path: <linux-fsdevel+bounces-33236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4239B5B9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4AD284330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 06:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD1E1D12E7;
	Wed, 30 Oct 2024 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="QNz/20XC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D491D0F47
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268768; cv=fail; b=SiNA/lseuZx91EpjoCtIVgp3JV3G8wd8B6IVAPmAvcBDv+4IDjFYBPLgtg+hhAdvDqXl+UFbOEbi2zikso7fjTejY1bCiPhSNwI/Z54XFCqY3NQ/9njAML5n8cC4/NnZJyMB2TTSQs3w8G6NhOjKlBDCsiqAva+JUNwDZeyXM6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268768; c=relaxed/simple;
	bh=xMehnAoOA0YVJI3CGAFLzJSQX6AE7G5cZ9Ylvy/2qVs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g+AchnW8zEeBBs8pifEN1xRyfikVvapYtKcZKk49OT9WWb+YwyVTYb1oqt6JB+HXAkbm+V/5Ymk9AAUr7dmu5t2bqTQQxxGnCgEZOcrLERu8Yg2wuddtsHP5VgrJJ0n17PnINIZH5lyFGM46IdRyooeaXVWBf9WCH6zH9bUh2U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=QNz/20XC; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U5rtik020979;
	Wed, 30 Oct 2024 06:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=xMehnAoOA0YVJI3CGAFLzJSQX6AE7
	G5cZ9Ylvy/2qVs=; b=QNz/20XCNJWp0qZ0Q4WPHd2gISmYsQ5/uVSVgsO0UOdk0
	iakUCRhJ3H7OQBqpXTB+u10xmuDFzMTUuYdqwOwIPVSxD+WMCOdsyfOO9NZafRp/
	8zbkhbeqRLBsWRssmIGFUqImDjzv9QSK6kCB5TfwhJNc9oI4/F7nJBa2AVpYLbsY
	iZ7uJ/e3vKSHzM9qlxRcZuXlypuup6Yq0n5MHJCIHIYnyQj1amFt2lyesHwPlUrk
	76Q/oHNmLT6c1i7NlCwENmMKI+lOYCN4u8fuFowIflsByznrfITM9dawCWZDd8sx
	qV2PkqhG3jDStMx27Pu7AXafVMO1hkKry7XTZ4eHw==
Received: from hk3pr03cu002.outbound.protection.outlook.com (mail-eastasiaazlp17011029.outbound.protection.outlook.com [40.93.128.29])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42k2yq8hs8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 06:12:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkB2YgmOCMsYpL5pCM1nzECXG3PC8qwZuASHSItM0Bjkk1Za1hyCUGXhkhHUFBMYYMO6CIReNH9LlP9yuMfBA4m2LDgJrDIYMPRGzboP3frGvcC2L+97tpSPywkpbCZYGzWmMZI5uDQDQ5rCGjFVegrXYIchFBW+oY5kkY1YVdQN1EXnbRSKYwqK8w8pAW5X6F+5HX+98giJHNfPYot1tFCjeVw6+ISPb6VFO9bWFokmaeIkUVkX5o8bKs/D2D9sW4wUoTjInpeoZNSwjcorDVHJAmDOd8o16t3ZxHnaY5Pb8kETFW+W1dSwnr22PAaMKwP04cDDuiBKmjseZQQx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMehnAoOA0YVJI3CGAFLzJSQX6AE7G5cZ9Ylvy/2qVs=;
 b=x34F+F3oxLRbLTSzkhuPvOUg1w6KtEIHQJs2uke2ol94G5YNVVOzX2OQUkUVD3s8M4AXkdBpak9yMt5Qs5Bq2zqQY6khoFO5ty/pmqepy42f0/GNyMEuiV2H6vs6fZm0kBQvMOVy0tkFxvbHppb2iTkf3Nrd7EmylMZUWsbmbig0udNuqwgo3N0J9RgPSwed47AdpBkfl7qBWDoBHXHHdvSCaZWEkfmaXVipPK6mSJT6nXLGXaUqEqNoo29jkyW+HTynCCZWFzYh1sn1KqUZCqfOcH/pRAnk+Ambh2NStxrvpcnxY0JYSUkF6esfYGJnvykcrhnVla+OTAQAMeT/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB6115.apcprd04.prod.outlook.com (2603:1096:4:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Wed, 30 Oct
 2024 06:12:26 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 06:12:26 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 6/6] exfat: reduce FAT chain traversal
Thread-Topic: [PATCH v1 6/6] exfat: reduce FAT chain traversal
Thread-Index: AdsE8b4RuEBQExP8QOeg0VhYfcJWAQloFkDA
Date: Wed, 30 Oct 2024 06:12:26 +0000
Message-ID:
 <PUZPR04MB6316730307BECB96E44189AA81542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB6115:EE_
x-ms-office365-filtering-correlation-id: 505e397e-5cab-4aad-63e4-08dcf8a9d3b2
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmI4cWtwZVdFMUI1T2kvUVoyK1M5MGszYnViRE1MU1YvNXNrbnh2bXRlUEYr?=
 =?utf-8?B?eUpjVGFkYjFha0RNVWJYeURKM0hiME9Ndm5ObkxXbm02ajcyVjhtQ1cwYlJ3?=
 =?utf-8?B?QW5ZOHlZbjhKVDRyMDAxaU1JZ21EUzV1czQ0S0NnSUJ5QkVzOUhiU04rZWpB?=
 =?utf-8?B?YzhETDcxUG8zRXVvNWV2dU04ZHFSRkdWMWFwQndGUFpRUzM0U05xc3FqWi9m?=
 =?utf-8?B?dUhCZGhZc21QT1pTM1R5dTcrV1o4eFMwS0xjbFdlVytXWU1aMTJLakpVQTlG?=
 =?utf-8?B?d01rRHVKbTdlNVRLS0VUem5mSjhPVHFCMVMzdmtWSC9HTW1MS0t6QXpFOXF3?=
 =?utf-8?B?c0RtK3VNd09qUzY2YlBHVXlHdlZoODBZY3FOenBMNTBkZVgrc096QWsvTUN4?=
 =?utf-8?B?TXZ6RVdCNm1xUG91cXRUMldtVENNNTA2b0N0V21ZYytIdUhHU3VGb25kMTV6?=
 =?utf-8?B?ZDB1ZFJtUXFMRlo2dWpGN3RiT1F5WHdxWDdxMlhJMkRIRUtwVEs4ZjhlVjBO?=
 =?utf-8?B?L25KTTBGdE5qVFFDNlY4SjJ4UXgrMHZRS1hkSEIxcGpiMkEzQWFJd0lZcEov?=
 =?utf-8?B?My9sRmxUUVRJQWR1UVYwTk5USWhQbytkL01BNGNONHdodXpIM1lySmt3UTg2?=
 =?utf-8?B?ZnEwTUVpTktmOVlsRy9wR1FTTC9ITXJLbE1zY3MyN3EzUzRvSllDaUpjOVlR?=
 =?utf-8?B?Y2xiRUJJdUNzT1ZJTnlIZ2U0aDlIeDFHVGk5dHc2UVdxclNuUTdCMmtwRUFG?=
 =?utf-8?B?MGZWdkw0T3RpYWJ3QnBJSWZaRVNvWGJ6MFpEdHlkYXM0OTZ6a0VJUGdnV2No?=
 =?utf-8?B?QktkVjRCdWFhNWJ3UXZ6cS9sWXFpdWJHUnhSWW90VDFRV2ZwN3owcldUR0Jo?=
 =?utf-8?B?bjcxN1RPNWU5dlMxY1VnbTJQNzJxM2J5ZjlvMDVvUFVuSUdzZDZwNUlnRE5q?=
 =?utf-8?B?R1Bxa1dkZW0veWgrTDBtZ3l6M3liRWdacnp2MTN4TGYxLzJTcU4yY2F3dlpF?=
 =?utf-8?B?ZnhiUVd4VVBqb2ZhOGhnWFFzeVpvV3o2SThHVExyUVlmRFZicTFqNFEzQUth?=
 =?utf-8?B?akk5S1JUK1lZSVkxY2JZa2ZRekZzV0ZSZ3hJdmhEUnR3dFVJS2l5Q3YrMmtJ?=
 =?utf-8?B?NCtxREZ5enYwakVIeUphOW5vQVF5cnY1S1lsUEgyWklweStsUU5DMmRJWnVv?=
 =?utf-8?B?TGhSc2FjdHZmZnhvSW1PdUgveDlyN3VISG9VM0VMOTh0RjBDd3F0bFluMFdz?=
 =?utf-8?B?bklaUm44bDBocjJRUWsrWHdjbFpzSzlTR21UMURuNU42VTZEQ3RxN0YyMFAy?=
 =?utf-8?B?RFFNbHlEdFUybXRIdzZkMTVKcktNNmVIYVVzOU94SnRZck9CRHA0dENxL253?=
 =?utf-8?B?eHZLZzBUeU1oa01pcTVmOEhzakUwdjlnWlJWRVQ3UWN6M3p6VDZCRE43eVM1?=
 =?utf-8?B?TTJYeGo1WXMrR3ZrUUcvKzFhbWRsYW1zazRrV3RLczd1UGlRcThGdEY0L3hj?=
 =?utf-8?B?VEVFV1U2c1JySEpBdWpKZC9zcEdxZXU2OTc0b21yVGl6WTVBOXlBWlljcGJy?=
 =?utf-8?B?K084WjlqMENBK05mYkpjUXdTWVBTOGh3ZCtlTW05c25BdmxNVElLV2lPK0R4?=
 =?utf-8?B?WFNvU3RDN1RoREs3OG11STlyci9OV1hvMUVYMWlaQnMxWWZJNDQvTzlzRWJE?=
 =?utf-8?B?dWgxNHFldkovQkFOalhSNjdkbm5OODlRWmFEcncrU2FhOGJqYlZHNExVaDlt?=
 =?utf-8?B?RHFqVUQwT3UyTUs1Ujk4NUFPZW41NkdWMGMvTkFUV1lmSGtyd0lHOHB4NHlu?=
 =?utf-8?Q?dAWBaCXJpPGSHsg3DnJe3wGq5jjTYZtbErsNg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkwwVDJFOC85S0NHSWNJcGtoWmhRWVJOV0RzZU5SOUF0aDh0SGVhdWMzaEpl?=
 =?utf-8?B?ZjdnZEFUSUZPTkJSb1YzRGE1STdlditQaW5tOCtiNnJ5MnZIU0pMVitrZWtm?=
 =?utf-8?B?M3lVaU54cFloVjdzbmxvZUUxZ3Uycitqbll1ZFYzZmxkSEtlci85a2JOVm1X?=
 =?utf-8?B?MUFFajlEdGdtK1E4ZTZCeTM5S3dMdVo1T3krc2NjRW5xOEpwNktuRVhJcmFD?=
 =?utf-8?B?UXdNTTBxVTJvMW5uRllEVUIra3g3OVdnZ0xkVXVpSWo0N2M3SDFLbTA1cTFR?=
 =?utf-8?B?WVR5OTZSd05PbUdyVkVHaGFNNzhJUWlhYjNJc3hDY2pqZUxsYzJwUXJUZllz?=
 =?utf-8?B?bTViK0s3MHF1TExrbVR1VUx1NEV6QzhRSmZTcy9hYjFmb2RDUkpqcGp3UHFt?=
 =?utf-8?B?VWhzRVVLL2pCbE93UGgvK3VTa3Z0SGRCWVgybUFySEZEQ1pHd3h5dFFQcXMv?=
 =?utf-8?B?SDZ3eW1hNEtjRzVlMktFWkpDdVdwZGl5YnZFLzM3Z3doekxVQUhNZE1mbVpQ?=
 =?utf-8?B?OHl1R1NRazlxMTZ2TDdNamVhZVNFeWJCN1hKczRPc0xEemtCczUxWHFBS05h?=
 =?utf-8?B?MGlKNEd4Vks3akZDb2dIdkdMWnlrTnBNMDBFcWd5OS9BcVY1cUxCaTNnbjhG?=
 =?utf-8?B?UXQybVJ2UkFrMjVnOWcxY21pY3pYWkZncVRTeTFoSm55RGkxMGVvZGhIY1Zs?=
 =?utf-8?B?NTNGUUl5L280VU1XelVVc09NS0JKdi9zZnl0S2YzS05ya2tURVpTZVZ6L3Na?=
 =?utf-8?B?cU1ORncxOTBGNmUvOG85ekNjSVhDbmx6WHdLL21OU2FFZ0dsL2NHdzFVMHU0?=
 =?utf-8?B?dkhJWkl4OXFhNWEwZzhiMDJZMldoVDd5akpWWmsvdXRwcERkVEFXcG9TV0c2?=
 =?utf-8?B?dEdlU0ZGbVoxeThqbHJRa0EyTkl6WmxGOUxpRmpURU55M0xtdHpJZTJ4NUNK?=
 =?utf-8?B?M0YyWE50MzZqN3Q2aEh5SzJpVUVVUkpYUzBmemUxUkhPL1NCaTRCMFh3NGpB?=
 =?utf-8?B?MEtRUDVyeCtuZjhyWnIyRDR0RXpMbi9FRWtpS2xXUmd0cmJzeTRtK3dMTnor?=
 =?utf-8?B?bjVPVk5jVE1SOWllLzhxN3FvY2xVQ1VCS0wzM21JZDZ6YzgxekpRalhELzh6?=
 =?utf-8?B?NWo1T25nZUFpR3JiS1ZSNGdJaXhKMzRLZXdyc2RMQUIrdEZrUzlyZmpXbVB3?=
 =?utf-8?B?THFubHNOU09mQ2JQZzhTQjcrczRTNkRrbGVJZDV6ME5lL1pLZEROOEhPdTll?=
 =?utf-8?B?S0dINmNTZ0NXbVpsKy9rVnBjTjN2djkwVzhlWC9sWXBtL2R4K3VIL3llVTlp?=
 =?utf-8?B?WDR3MlI2L0tFck9VN3VYUk1lTTBiVUFYR0NVSXc3ZlFXczJDSXpUa0N2Q1ls?=
 =?utf-8?B?RDBKWnA4a2NHU1BDZ204ZFVvb3FBVllFN0ZZRFNtR3lmd0JaaHFSVUxFSU5m?=
 =?utf-8?B?eUtvbHlST1l4RUl4aTB2SFdtcWxpRkFQY2hmUS92WG1uSzhaYlVQQ05FUTVY?=
 =?utf-8?B?Q0ZsQ2lsOUpIaUR5a0w2d1RZVUlacGpnMHVuZkRCZVVZT1R5dWxRYVE4b0tF?=
 =?utf-8?B?djJLd2pFSEgrTEt4VnE5STRmSUxBUWlOaXo2QUNXNHloVy9hbi8wbWt5d0h4?=
 =?utf-8?B?aVR0bmc2RXpkeFc3a3krZTlnTisra1ZMbGVoUk5rbTRndWQyS2Y0bkJ1bHBZ?=
 =?utf-8?B?WmhkM0lqd24yUkFIMWlONHRRb2RsY1h4NHAxc21GR2hwcjJubFM5TmJtRkph?=
 =?utf-8?B?VmRENXFPU0lBZyszYlMwRVdleEJxWTV1bG1IRTZ1WWpNRFpUa1ZLK0lrbllD?=
 =?utf-8?B?SUp4dFFTTUhpN0wzWlNhcW5MSUtqNGV1NG5oeXkrdlNBN2lieVNkeDRhVTE3?=
 =?utf-8?B?ajhEWUJGb1ZDTnhyR3EvTldHSXIvZjR1UUQ1ZlZmMTc1S1ZZMlMrMlh5cHR5?=
 =?utf-8?B?cGRWTGdVRW05Zm9yQ0t4eDBhU0kwRmFRb1owTURjMVFQMTU5ZzUxajVtdVps?=
 =?utf-8?B?OXd5aTJ6TnFiOUVKR2dYUWNyd1VySkE0d0IvYzNzdjJyb0pHNXAzVm1MaEMx?=
 =?utf-8?B?UTEwNnpNMEtYZUlCYVc2UGk2Q3RsUWRMYzJScnI5ZXRpZERUNHJYd3FvTml6?=
 =?utf-8?Q?7SzovKQsuyPjvJJwGWK/ErCYj?=
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
	3mixlnrQCtSjuvNgIPuqTWxuevjcYK1SaXMtRJyz4D0j5r1P2iJDcX9tKJDNVX7ikMm2oW6+ILKVYKbIgPX/dnzi8BXv5kp6mPrMVuM8r2BAF20IMEOftZkjj39tUImblwXu1/aqZmISTMRYt4vmRl7Rt3uEjpjdpcpVkhtNE3phEV9ji6+9xSoUQaanqYz5QRkWX+qwboD2Y0c2ZAR4xS+3KyXlC/ml/EdzuVpuIbVG18vH0Nw2K4tljiEQKE+SJeBDxmruuBDLkQvuHZcyifUFXjbpPZL8gelbHBgyKRzwC7aPg7SH+F89vItofTAieorJ3g1HhHN7VOe3dnsKA5WIt3HnGVRFkmCKZPRajVo9g+8N5KZX03O8k0D+GH+Gv4ICUHdGAqn8PGuvCwUmpaS/G1h7aQHaHCGjUDfZbIHvQEr95fJUtkyYdc7vhFHdiG8lgsmVASJ9f9xdI31tvrRLkUy1of0UJiHSWh/S0C/8TVaPhqmR1fcQW5px0dp71IVnaQOaiz96+0XVYQ4nvRyGJuhavV5n8IawNBYDw6JcjDxJxa8vLV31t1kElzzVf4SDMRBC3dWt+wSLdPWm02iv5SJ+3Yyah9uHJIdrYX2SHprmviInbKOg6OSSBk6w
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505e397e-5cab-4aad-63e4-08dcf8a9d3b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 06:12:26.4113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykbpUBajYzl6w7Sxv28UySro8oKezVaTpsJpCTvQprrYeFI+Lw7hRATkDD1k8yE3oo62RGq22h+UL2kf142OUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6115
X-Proofpoint-GUID: DL65XRzm4G86MUjqzO3eDAoXPDGMa6Px
X-Proofpoint-ORIG-GUID: DL65XRzm4G86MUjqzO3eDAoXPDGMa6Px
X-Sony-Outbound-GUID: DL65XRzm4G86MUjqzO3eDAoXPDGMa6Px
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_03,2024-10-29_01,2024-09-30_01

QmVmb3JlIHRoaXMgY29tbWl0LCAtPmRpciBhbmQgLT5lbnRyeSBvZiBleGZhdF9pbm9kZV9pbmZv
IHJlY29yZCB0aGUNCmZpcnN0IGNsdXN0ZXIgb2YgdGhlIHBhcmVudCBkaXJlY3RvcnkgYW5kIHRo
ZSBkaXJlY3RvcnkgZW50cnkgaW5kZXgNCnN0YXJ0aW5nIGZyb20gdGhpcyBjbHVzdGVyLg0KDQpU
aGUgZGlyZWN0b3J5IGVudHJ5IHNldCB3aWxsIGJlIGdvdHRlbiBkdXJpbmcgd3JpdGUtYmFjay1p
bm9kZS9ybWRpci8NCnVubGluay9yZW5hbWUuIElmIHRoZSBjbHVzdGVycyBvZiB0aGUgcGFyZW50
IGRpcmVjdG9yeSBhcmUgbm90DQpjb250aW51b3VzLCB0aGUgRkFUIGNoYWluIHdpbGwgYmUgdHJh
dmVyc2VkIGZyb20gdGhlIGZpcnN0IGNsdXN0ZXIgb2YNCnRoZSBwYXJlbnQgZGlyZWN0b3J5IHRv
IGZpbmQgdGhlIGNsdXN0ZXIgd2hlcmUgLT5lbnRyeSBpcyBsb2NhdGVkLg0KDQpBZnRlciB0aGlz
IGNvbW1pdCwgLT5kaXIgcmVjb3JkcyB0aGUgY2x1c3RlciB3aGVyZSB0aGUgZmlyc3QgZGlyZWN0
b3J5DQplbnRyeSBpbiB0aGUgZGlyZWN0b3J5IGVudHJ5IHNldCBpcyBsb2NhdGVkLCBhbmQgLT5l
bnRyeSByZWNvcmRzIHRoZQ0KZGlyZWN0b3J5IGVudHJ5IGluZGV4IGluIHRoZSBjbHVzdGVyLCBz
byB0aGF0IHRoZXJlIGlzIGFsbW9zdCBubyBuZWVkDQp0byBhY2Nlc3MgdGhlIEZBVCB3aGVuIGdl
dHRpbmcgdGhlIGRpcmVjdG9yeSBlbnRyeSBzZXQuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5n
IE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3
YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IERhbmllbCBQYWxtZXIgPGRhbmll
bC5wYWxtZXJAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAgIHwgIDUgKysrLS0NCiBm
cy9leGZhdC9uYW1laS5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCiAy
IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9mcy9leGZhdC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jDQppbmRleCBlMmQzYTA2ZmI1
ZTMuLmQxY2M1OGFhYmJlMCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQorKysgYi9mcy9l
eGZhdC9kaXIuYw0KQEAgLTE0OCw3ICsxNDgsOCBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlYWRkaXIo
c3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90ICpjcG9zLCBzdHJ1Y3QgZXhmYXRfZGlyX2VudA0K
IAkJCWVwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwgJmNsdSwgaSArIDEsICZiaCk7DQogCQkJaWYg
KCFlcCkNCiAJCQkJcmV0dXJuIC1FSU87DQotCQkJZGlyX2VudHJ5LT5lbnRyeSA9IGRlbnRyeTsN
CisJCQlkaXJfZW50cnktPmVudHJ5ID0gaTsNCisJCQlkaXJfZW50cnktPmRpciA9IGNsdTsNCiAJ
CQlicmVsc2UoYmgpOw0KIA0KIAkJCWVpLT5oaW50X2JtYXAub2ZmID0gRVhGQVRfREVOX1RPX0NM
VShkZW50cnksIHNiaSk7DQpAQCAtMjU2LDcgKzI1Nyw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfaXRl
cmF0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpDQogCWlmICgh
bmItPmxmblswXSkNCiAJCWdvdG8gZW5kX29mX2RpcjsNCiANCi0JaV9wb3MgPSAoKGxvZmZfdCll
aS0+c3RhcnRfY2x1IDw8IDMyKSB8CShkZS5lbnRyeSAmIDB4ZmZmZmZmZmYpOw0KKwlpX3BvcyA9
ICgobG9mZl90KWRlLmRpci5kaXIgPDwgMzIpIHwgKGRlLmVudHJ5ICYgMHhmZmZmZmZmZik7DQog
CXRtcCA9IGV4ZmF0X2lnZXQoc2IsIGlfcG9zKTsNCiAJaWYgKHRtcCkgew0KIAkJaW51bSA9IHRt
cC0+aV9pbm87DQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVp
LmMNCmluZGV4IDM5Mjk3ZDQ0OWRkMy4uNWY1YmJiZGRlMTk0IDEwMDY0NA0KLS0tIGEvZnMvZXhm
YXQvbmFtZWkuYw0KKysrIGIvZnMvZXhmYXQvbmFtZWkuYw0KQEAgLTI4OCw4ICsyODgsMjIgQEAg
c3RhdGljIGludCBleGZhdF9jaGVja19tYXhfZGVudHJpZXMoc3RydWN0IGlub2RlICppbm9kZSkN
CiAJcmV0dXJuIDA7DQogfQ0KIA0KLS8qIGZpbmQgZW1wdHkgZGlyZWN0b3J5IGVudHJ5Lg0KLSAq
IGlmIHRoZXJlIGlzbid0IGFueSBlbXB0eSBzbG90LCBleHBhbmQgY2x1c3RlciBjaGFpbi4NCisv
Kg0KKyAqIEZpbmQgYW4gZW1wdHkgZGlyZWN0b3J5IGVudHJ5IHNldC4NCisgKg0KKyAqIElmIHRo
ZXJlIGlzbid0IGFueSBlbXB0eSBzbG90LCBleHBhbmQgY2x1c3RlciBjaGFpbi4NCisgKg0KKyAq
IGluOg0KKyAqICAgaW5vZGU6IGlub2RlIG9mIHRoZSBwYXJlbnQgZGlyZWN0b3J5DQorICogICBu
dW1fZW50cmllczogc3BlY2lmaWVzIGhvdyBtYW55IGRlbnRyaWVzIGluIHRoZSBlbXB0eSBkaXJl
Y3RvcnkgZW50cnkgc2V0DQorICoNCisgKiBvdXQ6DQorICogICBwX2RpcjogdGhlIGNsdXN0ZXIg
d2hlcmUgdGhlIGVtcHR5IGRpcmVjdG9yeSBlbnRyeSBzZXQgaXMgbG9jYXRlZA0KKyAqICAgZXM6
IFRoZSBmb3VuZCBlbXB0eSBkaXJlY3RvcnkgZW50cnkgc2V0DQorICoNCisgKiByZXR1cm46DQor
ICogICB0aGUgZGlyZWN0b3J5IGVudHJ5IGluZGV4IGluIHBfZGlyIGlzIHJldHVybmVkIG9uIHN1
Y2NlZWRzDQorICogICAtZXJyb3IgY29kZSBpcyByZXR1cm5lZCBvbiBmYWlsdXJlDQogICovDQog
c3RhdGljIGludCBleGZhdF9maW5kX2VtcHR5X2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsDQog
CQlzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBpbnQgbnVtX2VudHJpZXMsDQpAQCAtMzgwLDcg
KzM5NCwxMCBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbmRfZW1wdHlfZW50cnkoc3RydWN0IGlub2Rl
ICppbm9kZSwNCiAJCWlub2RlLT5pX2Jsb2NrcyArPSBzYmktPmNsdXN0ZXJfc2l6ZSA+PiA5Ow0K
IAl9DQogDQotCXJldHVybiBkZW50cnk7DQorCXBfZGlyLT5kaXIgPSBleGZhdF9zZWN0b3JfdG9f
Y2x1c3RlcihzYmksIGVzLT5iaFswXS0+Yl9ibG9ja25yKTsNCisJcF9kaXItPnNpemUgLT0gZGVu
dHJ5IC8gc2JpLT5kZW50cmllc19wZXJfY2x1Ow0KKw0KKwlyZXR1cm4gZGVudHJ5ICYgKHNiaS0+
ZGVudHJpZXNfcGVyX2NsdSAtIDEpOw0KIH0NCiANCiAvKg0KQEAgLTYxMiwxNSArNjI5LDE2IEBA
IHN0YXRpYyBpbnQgZXhmYXRfZmluZChzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IHFzdHIgKnFu
YW1lLA0KIAlpZiAoZGVudHJ5IDwgMCkNCiAJCXJldHVybiBkZW50cnk7IC8qIC1lcnJvciB2YWx1
ZSAqLw0KIA0KLQlpbmZvLT5kaXIgPSBjZGlyOw0KLQlpbmZvLT5lbnRyeSA9IGRlbnRyeTsNCi0J
aW5mby0+bnVtX3N1YmRpcnMgPSAwOw0KLQ0KIAkvKiBhZGp1c3QgY2RpciB0byB0aGUgb3B0aW1p
emVkIHZhbHVlICovDQogCWNkaXIuZGlyID0gaGludF9vcHQuY2x1Ow0KIAlpZiAoY2Rpci5mbGFn
cyAmIEFMTE9DX05PX0ZBVF9DSEFJTikNCiAJCWNkaXIuc2l6ZSAtPSBkZW50cnkgLyBzYmktPmRl
bnRyaWVzX3Blcl9jbHU7DQogCWRlbnRyeSA9IGhpbnRfb3B0LmVpZHg7DQorDQorCWluZm8tPmRp
ciA9IGNkaXI7DQorCWluZm8tPmVudHJ5ID0gZGVudHJ5Ow0KKwlpbmZvLT5udW1fc3ViZGlycyA9
IDA7DQorDQogCWlmIChleGZhdF9nZXRfZGVudHJ5X3NldCgmZXMsIHNiLCAmY2RpciwgZGVudHJ5
LCBFU18yX0VOVFJJRVMpKQ0KIAkJcmV0dXJuIC1FSU87DQogCWVwID0gZXhmYXRfZ2V0X2RlbnRy
eV9jYWNoZWQoJmVzLCBFU19JRFhfRklMRSk7DQotLSANCjIuNDMuMA0KDQo=


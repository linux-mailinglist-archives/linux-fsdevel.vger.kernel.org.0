Return-Path: <linux-fsdevel+bounces-33235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D99B5B9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31CA284349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 06:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945A1D0F5C;
	Wed, 30 Oct 2024 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="kh/OG7Nl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99B1D0F47
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268762; cv=fail; b=C5qE310JKZsCOgMtgA2SBKTtSKWqrnVvJNMJuyzM1S98XXlHloZvJwtJ2WENJCZSC5BO59TWyoZIbheOY11Qoae1Z1CmI0qrt8Tw9uS9LQJJi/IKvTj7UyqS2SN6i9T67ElHp6Ugkz2UXl8LLge/90OLi1w1qwHNUd4SlTN5Y6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268762; c=relaxed/simple;
	bh=Dj9oV0VufnK1f62WhDumq5kse5Jw87jpIybm0DSdcrI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oDFuNm+yOcwFp9HojWU7zW8ekoSXjROZ0nMLJyxY671yj+jYoeMLKxdABCIOpkUmhp1ya+sKpMLM2SzGu76MV5x9KwrIiIoGO2IiKUojBvSOguDHu00pV0ZZbu2BgXZrNPAG89kAcbGupFA0VlOn82O6widxyzWNslApyClmxnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=kh/OG7Nl; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U4mBsl001183;
	Wed, 30 Oct 2024 06:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=Dj9oV0VufnK1f62WhDumq5kse5Jw8
	7jpIybm0DSdcrI=; b=kh/OG7NlifEuhoebDvGidbOXlJMOhGmz6wTSvHPmejzPe
	OV5e9l8ugtGrQvg7bHJNdzGfrhpCC8ilVYoYpq6I6rpXpbIxfLL/fVqDP96dm/Sh
	yEGop/vItXrdo/VHkSB2urRhSrU5AkijeEmbJbbGRjlKnHBifgDuNc6o1EdwNhqn
	KLPDVUdGnAeSTBJgISYh19oz/AR9pChqEhERWrZ/MAQk6RcJ1p8agVS5U+XKXIAj
	1zCx5vOmr/F5aEvWB4+gHdRGW91yOHjyrmdtP53+TW3pv0r7vmdvjT/kdXfrQSe1
	RvbyfpJvQbvjVLM2bkTFejYwb1vNJN4mWcnmg52vw==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2113.outbound.protection.outlook.com [104.47.26.113])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42k2yq8hy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 06:12:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOiOevqYX59myQMdySAIh9QaMxDDhE+JFPOTErEfgJRcEedLq21BHzfmO2kF2FKvy7mPv7WtWJm2oR5ybG/28/RyYTYWEdfveI4vgSA/QZCM+vlDCrJXMNVghucypvA1I0yZd1pv2/CDfp3yMc6KZSUeHTHpzvxe6qfSVSnFL0Od081wEXEeIWZtkDWUvd3JPcF94ziZKI+OGXSr5jbsMDfWQgU6V4KkGd6MRuJbjtQ4BIqgNw3Jq9hLWbmf84LdK6DQTBPSrp4NRsEdzTOa786gNqG22tgQFDqWsKR4O8azGzZ5d7PfZeRxtJ4ArZkYPjH1+Mccd6bhtBlWlJTypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj9oV0VufnK1f62WhDumq5kse5Jw87jpIybm0DSdcrI=;
 b=VmA8WwIFGbZZT34GQb9Y3k6+R6Ek3RusItebvZoC2hG9jH2NR+nxC1ib9FGNE7vYCgTUVDUltCeVs7n0URroslVLYQd55diwWjriz6WCH1Ng+0SHkK1YfKBouI9xO/FD+DgSQ8bT1ey1b8htGh+MhV6RS/0apBt87TsrSJL5o2n+J8JmIwtWH7V2mqOe3So/MhxIl8Xht4SZaNNVhPg7WeIBreo/F48sy5XKrSEBbBMsCA1/fP02Vfl75h758DdT62fgfFSOK49ZlERsDJY5e6QnmS2zOoiLIg34+eGPWZqutaYLvQlu4ePXR81WsRZj+XoeI4VngHL7J3tkLZeqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB6268.apcprd04.prod.outlook.com (2603:1096:400:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 06:12:17 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 06:12:17 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 4/6] exfat: remove argument 'p_dir' from exfat_add_entry()
Thread-Topic: [PATCH v1 4/6] exfat: remove argument 'p_dir' from
 exfat_add_entry()
Thread-Index: AdsAKdCLZqiXRnDsTO6ekxDSVI0J0QqZ/fqw
Date: Wed, 30 Oct 2024 06:12:17 +0000
Message-ID:
 <PUZPR04MB631608646FA99697DBBEDE8081542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB6268:EE_
x-ms-office365-filtering-correlation-id: 11718297-cf8a-476a-1cf3-08dcf8a9ce49
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkZuUkc5WnNCNnZuT2NDdDdQNnJzdGRsWHZSL1NnL3h6UndsTDRreHFPKzZr?=
 =?utf-8?B?Umt2aDhiY2RlcjcwQU04UGlJUDcrenZkeEpOYzdCZ0hINDgxQXc5YzRsYzVt?=
 =?utf-8?B?bDZzQ2xQRS8vcGt2RkV6ZzhTbElGTG1oYTZIYkR0eGJPR0trRXFFSmlKQXky?=
 =?utf-8?B?cWFNd20zSDRya2FjVkpaWEd6QXRvK3gzM3NTNFByWVpVWlc4alVjWFBRZkda?=
 =?utf-8?B?bHhWY1FlWThTMVRCYTluZXliUTBkdkY1ZkdxbENwbE9DcDFCRzkwWDFRcG9R?=
 =?utf-8?B?ZnpBcjAvTDdYUVRPb1J0S0lEdWtnY0lFdXEvNWFBRDJ5S1JacmV5K1JSU08w?=
 =?utf-8?B?cWttenRvSEFrNU5US1dDeFVndFVZNHYxRDVLR0gvcUh6TnBhVjF3OVlkUXV5?=
 =?utf-8?B?U0ljR1F1L0QxLzZ2S0FDd2dseEJkTitSYXRLVm5pZ0xidTU2VzhVUG1nWVIv?=
 =?utf-8?B?cGg3dEErTnZTaFQyS2RoUWU0SWhHbDFFa3R4VDNOaEhiVDduMk92WjZBRHpS?=
 =?utf-8?B?MFpiTVZtdTNWdFJuamlHRU5NS09VM3JEazRyTm9SMFc3TjNZcDZCRFcvSHJl?=
 =?utf-8?B?azlRcjJldlUrWlF6YWxNdkhHdTJCQTUrYWNZTjV2eXlkcENTb1VFcVpaeEk5?=
 =?utf-8?B?OWFWUy9DUmFuUGcxSWFSNUhPTlBNYy95c1VYWmFZRFRsL0NVUzZZWUhCd2lp?=
 =?utf-8?B?ejJpeHZqbHdiWWZ1alBwNW44TWNENUthOEtrSVZJL3RNMjAreWVWdmd3SUdG?=
 =?utf-8?B?YWNrNzI2ODNJN1dvZVoycVRiNUN4UE9BcWsweEYwVzNRRmQ4Nksyd0EvekZO?=
 =?utf-8?B?dHhQeFowSDJmMFArKzJkMXZMUnJZU0hoVjQ1R1p5ZkIybHRVVWFOVWJydklH?=
 =?utf-8?B?WVZjeWdMVUFMZFUzTUZXdnNycEU5UXpLcGlMODhNZkZHK0p1ck1mcmNYZllE?=
 =?utf-8?B?NE1ES3dFZ3R3eFcyQ1FoUWpvcHJxQWVSWDdaTmIwbHp4NUdvSEZDYThzSXhw?=
 =?utf-8?B?TWV6dE9QK2w4ODZOZjNDVmxka0pGTkVPYlJjNFlKZ2ZqSDB0Qk1DWFdwRFNw?=
 =?utf-8?B?Z0F6MWRkUFhxSEJCL1VkRkRncFc1NVpZWWJjSFFlbU1Lcy9DNXZEam1PaE9t?=
 =?utf-8?B?Qmw3eXE4dTJ4dUZpY3h6VjlYZDluMTc0R0c2dnR6d0swVERBc0laTVJmWmFy?=
 =?utf-8?B?T1dxVUZwTXk4NHJSSkdxWjJmdzdqU3crK2EwNmlqVWErMlYxYjFyenBtZ3Y1?=
 =?utf-8?B?UTB1aGswN3Z6YkZJVW5ic2VZS2w3RFBuTVo2d2UyVnBFVXJGd1ZtVnJ4bXk5?=
 =?utf-8?B?enBzK1B3RlZzV21oQjVqcS9HL08zRno2elhIRUp2RUFIZGhacmRaVGpsQ0VU?=
 =?utf-8?B?c1h1Nm9zSFdjREJKR2ZDaGpLT2ZMR3V6bXhpQm5hRnNBeG5ST25KOEtoR1V0?=
 =?utf-8?B?MDl4NzdLQ1ZMRkZuaFRicmRCSWIxdUFrelM4M2pnRFIxQ2thRlRNTlE0OVZZ?=
 =?utf-8?B?cUo1NzdiVGVwYlhaOVF1ZDg4MXZLYUZET2JiRDN3bnJVWCtONEJBOFJ6M01C?=
 =?utf-8?B?NDFZN2w5RlA1YllzMDhDZmk4ZTV5MVZOd3Jmd1hMYmZia20zbXR1dUxKaVY2?=
 =?utf-8?B?QkVmSTYzdyt1UlV1RW9Namp4aGhKeWQrdFNvUDI4U3JncDE5Z09pVzhWcEtn?=
 =?utf-8?B?S051Y2pYOEQrMFZKcEc4T1pRWVJqTnR1U3d4L2pKQXEzRGxxZmRRMnRPUGdw?=
 =?utf-8?B?Q3U4K1VJR2xQL3dxcjJobTVqdnNpM1NvV041SkNsSDV1dlJwUnMwZGNGaW9P?=
 =?utf-8?Q?nlsVzthiSZJ/B43NQ7BdBUJqLyhdbxBI9hqbI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlRFNGllSWV3aVIxb2R3cmVWS0hYeHR6ajVjcDdnRmkvZ1dwM0tHOW9tV0oy?=
 =?utf-8?B?cHRQYnp5bjluamQvdXJOTU0zZlVLWkdRSndyUzEyTW5jbE9NQXBlaEFudXZQ?=
 =?utf-8?B?ZVhEOUxUcTBGMzl1UGRESmc3d0c3R3NBWlNsMDdDM0lzLzRnS0xwMTZjL1FS?=
 =?utf-8?B?QW5oNXM1N0VJMzV0NzlZMXB5THlNRG1tQTZHa0FBT0RxZkhjK1VOZUtXTFln?=
 =?utf-8?B?K0c1cTdmei9xOGRDTzZIYjZTZFNLdXZqcUhlcW05OGMvWE94cGpXWGx4bnZ2?=
 =?utf-8?B?WmtwcVBZSUgyc0xvMzNBeDlGaXpzU09NRWZwM0dldWJiVTUwSmk3Q21EUVZO?=
 =?utf-8?B?dkN1ckVrTVF0d0VuK1duZTkreHJ6eGFQdWx4VUhtWWRXaElxaExNbDNXc1ND?=
 =?utf-8?B?Q3ZaUVZpTnVWMDdHWENwV2xDc2hQZ3duYTNhUnc5VGpFSERRWEZiMnVLQ0RV?=
 =?utf-8?B?WHJBeWtnVG9CRnRMcExhRDZzbjhtZS9QejA0d2pNMW1HNWZ6aUdEL3hLQ0E5?=
 =?utf-8?B?Wkd3R0pmQ0gzRzdkdFBhU0lzZHFKVmFoTXg1UFltMHAvdnEvdUxBUVRVTUJ2?=
 =?utf-8?B?TDd4MStPeU1kMUtyWWthT3ViU1NhbERQa1hLaTF1WHRMMExQZlloVFZEeitM?=
 =?utf-8?B?VTFXQk1DRURmK1Rxa0JUTCtRZzJZK3QzcGN5Vk81RUVoWjFuclVKMmF5NGdY?=
 =?utf-8?B?RU1HOWFua0U5cVNEdDhRKzFZK2xDVDIvNkFCT2tURGN1WERsTGgrZmEwV3ZJ?=
 =?utf-8?B?bVVyOGpjNUJ6OWlKQU1vSkJRTnN6QnNScURPakFxMnhUT3VTbHFFMzFFdnRF?=
 =?utf-8?B?OXFRTEpkQ1poWVdHbjZyZUsyN0NrbkxXNTlDUVR4M0U4WW5rbmtMR1NjeVY2?=
 =?utf-8?B?TFJUNkMxQXdlUHdXK2dESE5qUkgyY000b1hKYUxlY2U5NnZPbmxwY3cwd1Zx?=
 =?utf-8?B?WjNVNFlXeCtCMElnakk3Z2UrRFcxL1VZczd2YkIrV0RTZFFMaXZETUhKMmNx?=
 =?utf-8?B?WXVGUFZuN0xFcDZISWhwTGgyNk9NQjROckMyZkRrd2dkWmNxcXp3eGZOTWZl?=
 =?utf-8?B?VzE4NXA3Q3V3cDdLNlpsWE9jcGpWbUU2NExLVFhBS1AwbmxDaUVwU3BBUmlG?=
 =?utf-8?B?aFMxR3pKRC9kek9TZ09pOUR2bmlOVjdYMnBUSkY4WXBLZW5GMXQ3WU0zeXZ5?=
 =?utf-8?B?RE5EVm1DQklUU0o3Rk54Nlpwa2dITTQrcndNR3NFNkFsSkVTVUVtWU1mNFdU?=
 =?utf-8?B?eWlUcUE0YWwrUHRINmJTNzBSK3hOTDZTR2JYTjFjeHBNSXBxemRjaUVrN2d2?=
 =?utf-8?B?OElDOStKVzI5ZjNCMHJOSUxOc3VqQ09DUGZTR2hzLzYwcis4TUY5T3BjS1hk?=
 =?utf-8?B?cFV0Z1kxdHJwQld6RVlWb1RqRWpwemJVeWtJcjZlWXk0VlhQNW41b1p6YVV0?=
 =?utf-8?B?TUxvMTZpOHRMNGNvU0NRdGtzQ2VFZzRGSEJ5VHpOKzl4U1htMEZJbzlUMjky?=
 =?utf-8?B?cUVGcjgxd0lna0J6U3RTaTlSRkV5V1BWL0Q3UE9jZzV6NEg1K3ZyNXQ2STVG?=
 =?utf-8?B?akkxSGxYZ2hlaml4Y3NWYWZHd1RoSGJuZ3J0RktYNENEalZEWWRBU0o4aWtU?=
 =?utf-8?B?OXhNZE1JK2R6enZZbUpYOWRNY0ZqbC8vQUhUSkkwWVpCM1R6WDdGR2dLa0ZX?=
 =?utf-8?B?MVNKcklRTWw0QlBaY0xxRjNJMkZsbkU3bWpkbytvK1NZTGN0RHNpS2VXNDlW?=
 =?utf-8?B?QW4wQzNyZkJyNmgzcmRtQ1hjaGNoT1o0cmc4Z0NjRnpWQnJSbjYvRE1sVjNT?=
 =?utf-8?B?clN6cVk3TkZHaTFTZzFyUHFlWk9JempvMlRwL3FvdVhzOXNpVERvUitHbXNl?=
 =?utf-8?B?Yms2M1hUTWJXU0s4Y0FiVThPNDEzemJFbkRzNHpaSFRXYzBKMW5VdUhxazNk?=
 =?utf-8?B?Q3pRNS8xVkswTjBlT3ZrcmRTUkFERXNscFAxYzcyT0V5aXhVVmNmMVQrejhR?=
 =?utf-8?B?ZmQwNlJUeEpvYytiM3VHQzVVTGlTdnlnODV0V2duUWsrWElmUngycW13MjFQ?=
 =?utf-8?B?d3BObkQyOElNd1lTeWpnZ3JsbjBWWEw2YXVUQWxydGVvRWNUU1FLK0taLzhi?=
 =?utf-8?Q?T3meA+zrOtkGu+qNb7AAiz+rO?=
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
	9HkdL5U+2/SRkUD8EGaZFQxB6eZ+181tZDLF3sAxhcSugOlabn84+udbZFtGNt8I49etuQBUrk+C48RA1CrCODQ8CjsTyieQD7skSUgsNkx606YzVuWdxG4uRvh/1/zWj4ac9fpgv5DWdlp0Lqu+9xx4ZASrNHbDNYwI4D84hDuy6OzaYY59vmAI0JRdX9LPjUxq90vdE3U8DD6XljKGxqVkGBWjCKORbNvcIdUKHqtvygRgSqbADuCs4f9Sd/1JvV5AD5ynpL9fwwXZDGcRcEe9Obfr+IFS3b0upo8KLSqf3qa+Gt9dW/weMuz43x/KqYfiIsqxz3vQyDx0q3tG/oRKV3mbQhx4TF2ivbVfpWTzp/vqQyRNEinwgGQVK8QIl4TmmWESZf7nVzzxNSnNOpLGFLAgwfBvPBPTBPyzu/WqJS27410EZtR+xyABwus3CZFn9iAEu7JuWTiA3X14a027uPW6B2Ptdo78YgCKPLuJKBqbfgrjo3keqK1E8jRqpCEYW7TNs6+Ydo3JaLqHdBBMWI7MvhDhIDG83Yax3Hj2kReKsyb+y7VoHxjJN8XuGIB19k8d9tNFfL0zhlBeQ1+XUQqfC2VIqfSEWalkHNx6wKviZCauGf47V9fvVaHx
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11718297-cf8a-476a-1cf3-08dcf8a9ce49
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 06:12:17.3372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ms7B1ehGgl7Q7MDuoiGJFphLNQ1Ihxu+Vd4QRpRQMC+IacirWM88iRhLMi1ckwJKQddnPTE9l/LglFkrgXSryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6268
X-Proofpoint-ORIG-GUID: e0bJuBQhPTgOg2sYam4I48_ufhxpwInl
X-Proofpoint-GUID: e0bJuBQhPTgOg2sYam4I48_ufhxpwInl
X-Sony-Outbound-GUID: e0bJuBQhPTgOg2sYam4I48_ufhxpwInl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_03,2024-10-29_01,2024-09-30_01

VGhlIG91dHB1dCBvZiBhcmd1bWVudCAncF9kaXInIG9mIGV4ZmF0X2FkZF9lbnRyeSgpIGlzIG5v
dCB1c2VkDQppbiBlaXRoZXIgZXhmYXRfbWtkaXIoKSBvciBleGZhdF9jcmVhdGUoKSwgcmVtb3Zl
IHRoZSBhcmd1bWVudC4NCg0KQ29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlvbmFsIGNoYW5nZXMu
DQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJl
dmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KUmV2aWV3
ZWQtYnk6IERhbmllbCBQYWxtZXIgPGRhbmllbC5wYWxtZXJAc29ueS5jb20+DQotLS0NCiBmcy9l
eGZhdC9uYW1laS5jIHwgMTQgKysrKy0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVp
LmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCA5MDA2NmQ4ZWM5YTAuLjM5Mjk3ZDQ0OWRkMyAx
MDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBA
IC00NTIsOCArNDUyLDcgQEAgc3RhdGljIGlubGluZSBsb2ZmX3QgZXhmYXRfbWFrZV9pX3Bvcyhz
dHJ1Y3QgZXhmYXRfZGlyX2VudHJ5ICppbmZvKQ0KIH0NCiANCiBzdGF0aWMgaW50IGV4ZmF0X2Fk
ZF9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpwYXRoLA0KLQkJc3RydWN0
IGV4ZmF0X2NoYWluICpwX2RpciwgdW5zaWduZWQgaW50IHR5cGUsDQotCQlzdHJ1Y3QgZXhmYXRf
ZGlyX2VudHJ5ICppbmZvKQ0KKwkJdW5zaWduZWQgaW50IHR5cGUsIHN0cnVjdCBleGZhdF9kaXJf
ZW50cnkgKmluZm8pDQogew0KIAlpbnQgcmV0LCBkZW50cnksIG51bV9lbnRyaWVzOw0KIAlzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiID0gaW5vZGUtPmlfc2I7DQpAQCAtNDc2LDcgKzQ3NSw3IEBAIHN0
YXRpYyBpbnQgZXhmYXRfYWRkX2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIGNvbnN0IGNoYXIg
KnBhdGgsDQogCX0NCiANCiAJLyogZXhmYXRfZmluZF9lbXB0eV9lbnRyeSBtdXN0IGJlIGNhbGxl
ZCBiZWZvcmUgYWxsb2NfY2x1c3RlcigpICovDQotCWRlbnRyeSA9IGV4ZmF0X2ZpbmRfZW1wdHlf
ZW50cnkoaW5vZGUsIHBfZGlyLCBudW1fZW50cmllcywgJmVzKTsNCisJZGVudHJ5ID0gZXhmYXRf
ZmluZF9lbXB0eV9lbnRyeShpbm9kZSwgJmluZm8tPmRpciwgbnVtX2VudHJpZXMsICZlcyk7DQog
CWlmIChkZW50cnkgPCAwKSB7DQogCQlyZXQgPSBkZW50cnk7IC8qIC1FSU8gb3IgLUVOT1NQQyAq
Lw0KIAkJZ290byBvdXQ7DQpAQCAtNTAzLDcgKzUwMiw2IEBAIHN0YXRpYyBpbnQgZXhmYXRfYWRk
X2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsIGNvbnN0IGNoYXIgKnBhdGgsDQogCWlmIChyZXQp
DQogCQlnb3RvIG91dDsNCiANCi0JaW5mby0+ZGlyID0gKnBfZGlyOw0KIAlpbmZvLT5lbnRyeSA9
IGRlbnRyeTsNCiAJaW5mby0+ZmxhZ3MgPSBBTExPQ19OT19GQVRfQ0hBSU47DQogCWluZm8tPnR5
cGUgPSB0eXBlOw0KQEAgLTUzNiw3ICs1MzQsNiBAQCBzdGF0aWMgaW50IGV4ZmF0X2NyZWF0ZShz
dHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsDQogew0KIAlzdHJ1Y3Qg
c3VwZXJfYmxvY2sgKnNiID0gZGlyLT5pX3NiOw0KIAlzdHJ1Y3QgaW5vZGUgKmlub2RlOw0KLQlz
dHJ1Y3QgZXhmYXRfY2hhaW4gY2RpcjsNCiAJc3RydWN0IGV4ZmF0X2Rpcl9lbnRyeSBpbmZvOw0K
IAlsb2ZmX3QgaV9wb3M7DQogCWludCBlcnI7DQpAQCAtNTQ3LDggKzU0NCw3IEBAIHN0YXRpYyBp
bnQgZXhmYXRfY3JlYXRlKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRp
ciwNCiANCiAJbXV0ZXhfbG9jaygmRVhGQVRfU0Ioc2IpLT5zX2xvY2spOw0KIAlleGZhdF9zZXRf
dm9sdW1lX2RpcnR5KHNiKTsNCi0JZXJyID0gZXhmYXRfYWRkX2VudHJ5KGRpciwgZGVudHJ5LT5k
X25hbWUubmFtZSwgJmNkaXIsIFRZUEVfRklMRSwNCi0JCSZpbmZvKTsNCisJZXJyID0gZXhmYXRf
YWRkX2VudHJ5KGRpciwgZGVudHJ5LT5kX25hbWUubmFtZSwgVFlQRV9GSUxFLCAmaW5mbyk7DQog
CWlmIChlcnIpDQogCQlnb3RvIHVubG9jazsNCiANCkBAIC04MTksNyArODE1LDYgQEAgc3RhdGlj
IGludCBleGZhdF9ta2RpcihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpk
aXIsDQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBkaXItPmlfc2I7DQogCXN0cnVjdCBpbm9k
ZSAqaW5vZGU7DQogCXN0cnVjdCBleGZhdF9kaXJfZW50cnkgaW5mbzsNCi0Jc3RydWN0IGV4ZmF0
X2NoYWluIGNkaXI7DQogCWxvZmZfdCBpX3BvczsNCiAJaW50IGVycjsNCiAJbG9mZl90IHNpemUg
PSBpX3NpemVfcmVhZChkaXIpOw0KQEAgLTgyOSw4ICs4MjQsNyBAQCBzdGF0aWMgaW50IGV4ZmF0
X21rZGlyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRpciwNCiANCiAJ
bXV0ZXhfbG9jaygmRVhGQVRfU0Ioc2IpLT5zX2xvY2spOw0KIAlleGZhdF9zZXRfdm9sdW1lX2Rp
cnR5KHNiKTsNCi0JZXJyID0gZXhmYXRfYWRkX2VudHJ5KGRpciwgZGVudHJ5LT5kX25hbWUubmFt
ZSwgJmNkaXIsIFRZUEVfRElSLA0KLQkJJmluZm8pOw0KKwllcnIgPSBleGZhdF9hZGRfZW50cnko
ZGlyLCBkZW50cnktPmRfbmFtZS5uYW1lLCBUWVBFX0RJUiwgJmluZm8pOw0KIAlpZiAoZXJyKQ0K
IAkJZ290byB1bmxvY2s7DQogDQotLSANCjIuNDMuMA0KDQo=


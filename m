Return-Path: <linux-fsdevel+bounces-51832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7841ADBFE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 05:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD314188D61A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 03:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F314D1E98E3;
	Tue, 17 Jun 2025 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="oIe8Xzlh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DC8460;
	Tue, 17 Jun 2025 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750131166; cv=fail; b=WvhzdvoddW09S3R7Qy/MfHa/IUreKGO5e/TR4GC0K/uvonMLTw6B7lkT5lV3sze3YJhqkpaKoI9S9ZWL0eUZkZu92+FRI4u5ScpdCrDYGK1M+R2ve+jbEg514VYP9GfTxWFh08vVQ/iwjTT4Vukigxi9c/HEiv6LnP7HY8vFcss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750131166; c=relaxed/simple;
	bh=5NJeHPZf85bHXIJ18fPKihyNRyGBqSRrOiAN03EqxaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GOEk3WenSTp6no9256R7Tn9rvURfwXFiyffZ0BnrFen4L+vIMgvi5iGqY0XaEmyhcfdvjLC2pS/FVsLAH0SS9BxJI82gAFrUjke79I46sxnMvWPCx79q2fYbx7bNmtyob0xaJ5eJHyOL/afgMJ8BUC5yoWx2pzmRxhBGAQV2ybA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=oIe8Xzlh; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H1pQ0O010280;
	Tue, 17 Jun 2025 03:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=5NJeHPZ
	f85bHXIJ18fPKihyNRyGBqSRrOiAN03EqxaI=; b=oIe8XzlhettN0XCHmy9uvW4
	pF0wDAiChibXRXYI4zyKyvegqQFKJU6TW8m6CsU2NQYFp9OTM5mGcoF7F02cnVDA
	8gOBZvUge4PZthq/NpTXtIOduPrfVYOtT2gB6IsCuuO1MZcKFangvy0jBFHSQQqN
	/d4zISZbKp6KJ3adXyd7nKlSoh/bn6lhGEP1PqQ/3aVMz5/4WW4mb8ReX0GnKVx2
	2WTLRwKPCuI/16IbXUAUbl0HLFFxkDNHugft0nPe7OAZDgCTYxVOqRxkCw29lT9C
	On5TI6zY/5/5Ad7iYYX3qGj+sdWl1igUsn/E6uelbp8S0f9Ns4SxFcq861kChQg=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012013.outbound.protection.outlook.com [52.101.126.13])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 478yv8j2tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 03:31:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3HFXjyeDvD7YMGi+fWF7/l2fu/6xNm3FZ4pjg47TzQCAnOdcxSySIqgqP2myxGKP7scJCWCN73FyS+ygw31AQf9+TYG1TVklgnZnDPXn8qmEPaOLr+3AdnbTEwNCTYPzUAIzHNzIKG65+VQv5HBis+xbpjWGznmbzwgKJsqbBOJk9jCGIu+IdrIgkWx7MaDlBfdMn8ujthWwGmwO0rsAf5Z9ljHgJq9gGlg5NCg5NReL0DW49aLhd1w7Y+yOYpaf5Q2YhBkA3bnqJGEHce/zwqgbCrJUzZNDWBOg4PJ/5iQ8HbNIkekCGQYgCuWcpg9r7vKssmHS0oHBytPlL1ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NJeHPZf85bHXIJ18fPKihyNRyGBqSRrOiAN03EqxaI=;
 b=Vb5SO8WQdMYU8lqD8Vb07ATPXQtTN3/4QiBXv7U+wbBgeBlBOIalAOWSg7Dx9a/LyjTGUkPqkhQ39ZeKK3fCk3LaGnF+jZuFpHhcrE/iveBzycfwRmQVhrlAYleOs9NwiN3IJqfcaewnWr04uwqUMaLAgOUSA/Z5lXRki2OHNpmOCCTgSpU89xcBI9OxObuv6SxPgo6m2+VpzcTKvn4ZzXet+R82PzEBzYWOmulT0wUZJFFxWwV1z9513Eye5oGFGqFxLv1YIu+QF+HUDjat7MX/dhXlPe4saHfTXDXu++4t/zxydyOMJi04NVdnom5e1N+qf0R6dp1KLnN1dXJRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYUPR04MB6744.apcprd04.prod.outlook.com (2603:1096:400:35c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:31:52 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 03:31:52 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: =?utf-8?B?5byg5pS/5petIChaaGVuZ3h1IFpoYW5nKQ==?=
	<Zhengxu.Zhang@unisoc.com>,
        Cixi Geng <cixi.geng@linux.dev>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>
Subject: Re: [PATCH] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Topic: [PATCH] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Index: AQHb3CvFSyisR7Q+SUOzmxnGLTa10bQA2ySngASskQCAAS9Lbw==
Date: Tue, 17 Jun 2025 03:31:52 +0000
Message-ID:
 <PUZPR04MB6316B91DB1F5E14578C65C0A8173A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250613062339.27763-1-cixi.geng@linux.dev>
 <PUZPR04MB6316E8048064CB15DACDDE1B8177A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ebba6e12af06486cafa5e16a284b7d7e@BJMBX01.spreadtrum.com>
In-Reply-To: <ebba6e12af06486cafa5e16a284b7d7e@BJMBX01.spreadtrum.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYUPR04MB6744:EE_
x-ms-office365-filtering-correlation-id: 225572f0-a481-44e7-9090-08ddad4f804a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlpLcDhvam41OVNxeU5xM3NENDVsSkk5dzE1akxrL3N3MmNiL2NSSjZRc2Qy?=
 =?utf-8?B?WlJscFFHMHBXakM4QVhFZTFIWUUyNTBZN3g1OTUzMlV2ZHFaNFVZd0FuZVdZ?=
 =?utf-8?B?c2I0aFNiR1psaGs4MzM2VUlVSmJXYjJKOHhEYVFHblZHR2RyZHY1TU1Sc0JZ?=
 =?utf-8?B?czJVY2FnUWR4Yk5XbnFnM1BEVkREMlRrdWRkcnhqdEQ3UFEwTEVvanlDejdl?=
 =?utf-8?B?Z1k4dWp6ZGNteEtUL3ZpeU5pcVR1R2pEcjg1ck0wMjBqUjdnRDZGdXFQeE1W?=
 =?utf-8?B?dUJSWkZrVFQwSXBudExDRzdKdWxuY2ptblAvUmRrclJWVVFlSjU5SWtLWlll?=
 =?utf-8?B?bTNqSStjanMxSzRYdkhOVGUrbHJuc2FROXJHRlpHY3pBSDZpdjNKWThyd2xM?=
 =?utf-8?B?RGJQa0Z1WVZhdXkyclBwM3hHRkYvdkcxNDlQd21YYm5uYnYyYVpSRllOUVJH?=
 =?utf-8?B?Q25CcTNNWXU1UWFBaDhjMEZ6YktnRDNiOU9OWWg2czFGMWZUTFYydk1wRGg1?=
 =?utf-8?B?emN5NmxoZEpBbVVHWW1jWDl6WFB4Qlh2SWxEVnBVNk91a1hnSjR3OEVCU2pr?=
 =?utf-8?B?RVVpRE1IWGU2OVNsbHN4L3pmS3FtbkUrNXNpKzdnVEVwSXZkcGk1L2J4aTdn?=
 =?utf-8?B?ajE5aGM0aWZGWGkyNEt0ancvWHpSRXBJVE1QWjd4TEVlY29UVitQUmZ5eWlE?=
 =?utf-8?B?VnE5bzVxVWp4dU85ek1uL0VXQ3RXNEU0dUR0Nk9LNGxzQ2REMkRRUVBpaEpw?=
 =?utf-8?B?Q1UrZ0s3VkgvbkR3aWwvR3NZVFhCbVp6NHNWZC9UZVhEd1dVMEdET2x0R2ZN?=
 =?utf-8?B?ZUdNaDhJdnlqTkFXSk9FRWNnVjY5QkdtUXkvNTRkWXgzcTFOL3MxeWZVVTFw?=
 =?utf-8?B?dHdGM0p0aDIxRXppbkhkNmw0NGl2NVBLaHY5ek56QmRGRjU0YVMxTEgwVmNm?=
 =?utf-8?B?SGdTYmtSTlBaMnc1bitIelN2L0RGOFp4U3B1bkkrK1dmWFd5T2l2UW80SlZ1?=
 =?utf-8?B?UTVLSnA3VEpaKzlRS3AzYlBSOW9pc1FjQUQ2dW05eXluN1JxbnhvTmNhbEpO?=
 =?utf-8?B?ekF5OC9UNGNHOXNUVjdtN0lkMS9XYlpCODFrSWsvU1dkL0VlMnpVWDViNURW?=
 =?utf-8?B?Q3hFOXFlc05PemZ1WHNqUXhXVW8zbFEzc2ErN3l0bTJkWldVWW90UkZIOU9Q?=
 =?utf-8?B?QkpzQitUS0RYVXZWV2NhSWlQc1I2QlhlMHpBNDI5TTJkK2pxaVBkTkRzZHRR?=
 =?utf-8?B?a3pBbUpveVI3TmI3Wi8vbHRObDJnMzBBQzJPak1TUjJuZllrKzlQbjJBTDlN?=
 =?utf-8?B?dmVwNVdiTThVVmw4a2VydUVpV0t5UksvWWt0Y3FXVGZ4ZEl6S3Vld0FENEh2?=
 =?utf-8?B?OFQwQXdsMk5WcjVBTVF0NWRnNWtCYmJsRmYxQ003UEJ3VzVkcUljYll2UmFJ?=
 =?utf-8?B?QXFXN0xCUUtZQ0JXUlFRWXUxVnlOT2JjeXBJRVVVWDB3ZzlieEE3a0hWWmcv?=
 =?utf-8?B?V1FqeThscFJsL2tNMCtJVnovWlFWTG1saCt4YTNYTGQ2MnVRMWZDaldnc1pj?=
 =?utf-8?B?SURnbm9TQkVENDhVZ0k5MzFvd2M3ZElpd0s4SSsveS9MY3VkZUg4Sy8yUXgw?=
 =?utf-8?B?TGtYR21oMlBicU9UK0R1b2h0YlpRbXVRVWRIVk80REZJWnRjaDdQRCswQUta?=
 =?utf-8?B?UkxlR0ZUZG8rYWVUT2RRd1ZDT082ZERwZDBTN3B6TFJEQmptZjQ4UXVHbS96?=
 =?utf-8?B?UjVxVGZiV3BCbTFkcENnSnNZUjNJVGE2T3VVbUNSc3ozVVdxdnZvcGhwOGRL?=
 =?utf-8?B?OUtiQzNkdmoxNm1ubHdMOC9CY2h3VWM2QzgyY3grcUNiTmNDWFkrckhIQm16?=
 =?utf-8?B?RExveW1sL2NjNzRVUUtnR3FROFg2MExBYVMrRUh5aldjUm5iUnpweHoxQ2ZK?=
 =?utf-8?B?cTVMNUFna2k2U0dZVnR5eHVoN1BPaS9VSzI3TjJpMnd6WS9mb0crOGNlNUpS?=
 =?utf-8?B?R0RvNm1FVTBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZG1OblBrVGZXZjh0RHBlMzNlekRacnBRT29LQkM0c3lVZ2JxWUs3djBPMFQ4?=
 =?utf-8?B?bjlmemJPcWNRSkhsS1RuM1lweDJ2SjlxV1hzK045NHd2c3UreDc2TlhhbnpG?=
 =?utf-8?B?MEF0QTB3SS80NHNqQ1lXN3AwSjhSKzZBZmdRakJsNUdTYkg5L3RkZjUzVUl5?=
 =?utf-8?B?VkZWNHVETkdkUWJqS3M2U2dWOXdnbzAyWGhreFF0MGNHQTB2SXhZVWVmV0ww?=
 =?utf-8?B?QWVOYjJOQWdUbDdmdENBY2ZyYkR3cmVvd2tUbVFnTlZaK3RIUThNVFZzWGdT?=
 =?utf-8?B?Mk9hWVI2Sk4yUTZOWk1qZ3hoZmRzYU9kTVNiVC9CT1UzS3o0YmpOQUlxNk1S?=
 =?utf-8?B?VXhMa3dnb1I5dzZCVUJPN3Y3VTAyOVNSa3NlNkNjRml1cHhqQ3J3ZTJUb1dl?=
 =?utf-8?B?UWU4bkQ0MUI1UE10MlBKbkxOQW1FVmR6MklHSXg0TUw2d1FHK3Y1Y1R4WEQy?=
 =?utf-8?B?SDg4L0xROWNDdVMrZ0Q2VFpDa2ovR25rVk1XalJKTUw0ckFXYkhpMEhEUU1y?=
 =?utf-8?B?d2dCZmdLNElYN05WMU5zQUV5Ym5WMVB6MHhDWHR4UGNyN3duTnlGWUE3alN0?=
 =?utf-8?B?KzFub2dpenF3aHNoUU51UkxFbEowdkFxSzRYRG93VFcyR1JpbWRqWnhUdk9O?=
 =?utf-8?B?K2dWWjBDOE82emdHMjc0Zkw4aHpzN2ZLck16SjhoeERwQ2llSXBPN3JLMjNH?=
 =?utf-8?B?Ty9vU2FheXRpYm1UUE0yVDV0Rk01akJUNlpGaEpVVTZURjBkSWdzT2dzNHMv?=
 =?utf-8?B?Uk1OQTNnRi9IazA3UE05NXVtUnRTa0FqMWREMjFQTmdBTGZmcGh3Y3ZqM094?=
 =?utf-8?B?Y2ZGbERzQW1aT3RwYS9QT0kvSEkrclRSY0RDcW8xUUNNblR2b1czeVFkNkxF?=
 =?utf-8?B?cjRQWnFFblEwek9PYndDd09KWlRHNUNEL2N2YVJHLzZ5UGQxU1orRkZoS21W?=
 =?utf-8?B?UlVoS1I4dDVaVFpuVXFvcTFsZVBDSXVBZStUSDQ4Y2RSS3lIbnNyTThvR01K?=
 =?utf-8?B?U1pHcElvN0ErUDhKT3VXYWRhQmI0RkNnVHNUOWp4bThhbGx0YkY0MlJqeTBV?=
 =?utf-8?B?VmsrZlF3OVArNmhqMk5FeWt5YTA4Sk80MnRLNmliUjFaSGVTcy9XN0Evdit5?=
 =?utf-8?B?RkViOU5wYXlHb0IvOVJXNnZHRFdRMGVPTld3T1Ayd3VPRmNKb0h2cVZGZUtW?=
 =?utf-8?B?bnE0cUY4cjZyTU1BYnVUdlJpRHNLcndXcE9kVHZicHlKZDNwUEM3TWR4TnRS?=
 =?utf-8?B?cTFmaFBIZm4xaUFUazhvczRUVWNBQ0d2Y0hOQXl1Tzg4VU5lclAwUS9RWDZX?=
 =?utf-8?B?U29tOTlzRCt4MVloekVHOWkxOU4rUGJpRHB5d1lPamR1SGcvNWY4dEpvT2t0?=
 =?utf-8?B?SkpsU2JpS1FGRWhoSjIyZ055dGNOcThPMXZiOTBmTzJKNDloUGs1aUJ5ejhw?=
 =?utf-8?B?bU1MRklRZnFvWjR5OURZVU52ZVUyMVF0dUVmb05rNmpjVWk1ZVMycCtoeTFT?=
 =?utf-8?B?SWl5TFRIS1dMalNISXdnTzN1VmpEdWg1eENMU3NqOVRSYzduNjRkbVRFS1Jn?=
 =?utf-8?B?L2pyclp1Mkt1SC9RL1Q3Q0tQY21qV2I4amtJWlFhKzB0cktaYjNLL0M4VFk2?=
 =?utf-8?B?Qk9nZVErQkpIYXVNdjZ5Z0hURDlEdUdLSCtnRmY3OHY1c0hzcE1zUnppbEVD?=
 =?utf-8?B?dkdWNlVqMjJUMEpENXFUZHlYL05ycHFYaVZCc1V6aUk1VHNtYU41VXA5ZlNq?=
 =?utf-8?B?ZWtWVTN3NFJEV212S0R6SXI5QlRlZEx3T1Q3eWk2SHlFUjBJZW5LYzRZclht?=
 =?utf-8?B?RlJUYmgzc0w4djI2L3NDcXJ6a0YvQXk1eng2M0phVndPSTlleGxVczc5NE9S?=
 =?utf-8?B?ZktDODA5SkNZR2FxaTRKNVpnR1pSVFpXV1IvdVJWTTJQald6MWZsNlRwd0Yy?=
 =?utf-8?B?QjkzV2lsajVJQnM2eWVWMm1sdEllNFc1MG44c1hQZ2pkMUdoZDJySlNPRVQ0?=
 =?utf-8?B?MFpXSDVFamNoTzRGKzJ1RHFGOUFER3JDNU1YNUFtRXkzemEyNDJ0ZEd4cGE1?=
 =?utf-8?B?QUt0anM2ODRINE56eUcrTjNyRFRSbHJpV1pINnNwb2dOT3pRK1JlUldJTFlm?=
 =?utf-8?B?bkdTVGFyR0QwL2lSR2wyWU1EZTV4SkFoamxheTJwYXgxUUNzbFNUbURsY3pT?=
 =?utf-8?Q?RUyQ8gY3kqxfglN41MAynEg=3D?=
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
	zEmVcYo0jY35jOCqyKbEUuLO23w7YhFcl0yjwC7JcD0Z3SD0+GTP8nsaQPdXBC9E4OorO2q4UTrmofb8LMSYg/Ud0/dDZEi/9W6dp8vD4WWmW6VcCNVQUwYKHg/RbTJ9FYHH4qUrzYrEv3K3dcpVdr7vtnVIpcb4pNvyENJiDCFVp5nfZgnjfvkey0dwjr0gzBSySkw19t5/dHDcv6wcLEM/eqgXke+PDfUGYjXKo32KY8CbNi2X5zqlviiDiO29vzaH6PWvjE8Pm5duggoj6MKttM0PNa9RGxeUbhDSrlYNqAHvWeTyn2IcxSYFMXzKTHZUpTT07CpscKa5SrLmb3rQWvTXab1XTJO6bgczGQu2KtysrHuoICJsLbeKHDqPhk2ojpWB5wN4bNRsgMc3/aBha8IIksPi5N+wsdxa9jPZEEcNoNGF4AnE1vgX/qHs77tiyzRxILZBmyfJC7mgHbrnoYYt81ALK1dCJb9VHE9smDT9MkRT1X0Ap4gqKox8rp4NCB7qBv71Dfop270d7eh4JlfgRB7lCB0ZynbgGCRVqp2h/Kqo3pXX0vhQKU0hQODZayh83O9mK56N4cogqFlyq6ZxgyQRSC8omuD9bIrXIeCqwa7aYnwBIjFrhvRK
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225572f0-a481-44e7-9090-08ddad4f804a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 03:31:52.2391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5xHc/ghHsYVqppEPv6La43FrowDM4CLcHXOV194/Ld+GTJTKQeXCFos4d+eUgYkR1w5KpZmOTibsFBRm7q92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6744
X-Proofpoint-GUID: OXPlm-s3t1p6AHAdIRqrGNl1khsssb_v
X-Proofpoint-ORIG-GUID: OXPlm-s3t1p6AHAdIRqrGNl1khsssb_v
X-Authority-Analysis: v=2.4 cv=LseSymdc c=1 sm=1 tr=0 ts=6850e1af cx=c_pps a=R5E0JZfuZuOkO2CZe4yZoQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=00zDaprkgukio2GQzIoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAyOCBTYWx0ZWRfX+pCSGrp0Nc92 2jQ795JZqOLdJqQcyc+kgiqV/rk1tAsnCHdsOl0BKXYGoPcjMGm0TYijl0jI6SnhAyTsSqBiPSf BfeYelK7g2+SpK76Zg15nAtwIEx+e+pEj5jLLxIh5GWgjFy9Lf6hh3pJmFjb5Y8xb0U0onHJsFs
 SBr7Pba3gSIBnDQJb9JEM369LB5s3IaC9rD7hQVtS0aktxh0zdFhQF/8vzC74T9p/KG45iEEBBh CCYgg+83Ralh1gVwr1ORcbGEpQvqKiCWRAOfkSnzIs6L6M0pBCxEb1STLKErTQ1Qbmrc0d6Rn/w PwEAR5zLDOvZ6pQxUVyYZeIQWKrbNW5pPVXOX+kDSwksIwFnyms3HsUES+4SAG4OeS1PRt8AigD
 h+Qokd+byngxSQYz5CL3XsRq3FsbLzfE+QV78tkB+A7x3HfWblGc0YeHW9OqBORzzBwXUsAV
X-Sony-Outbound-GUID: OXPlm-s3t1p6AHAdIRqrGNl1khsssb_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01

PiA+ID4gLS0tIGEvZnMvZXhmYXQvZmlsZS5jCj4gPiA+ICsrKyBiL2ZzL2V4ZmF0L2ZpbGUuYwo+
ID4gPiBAQCAtNjI1LDcgKzYyNSw3IEBAIHN0YXRpYyBzc2l6ZV90IGV4ZmF0X2ZpbGVfd3JpdGVf
aXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsCj4gPiA+IHN0cnVjdCBpb3ZfaXRlciAqaXRlcikKPiA+
ID4KPiA+ID4gICAgICAgIGlmIChpb2NiX2lzX2RzeW5jKGlvY2IpICYmIGlvY2ItPmtpX3BvcyA+
IHBvcykgewo+ID4gPiAgICAgICAgICAgICAgICAgc3NpemVfdCBlcnIgPSB2ZnNfZnN5bmNfcmFu
Z2UoZmlsZSwgcG9zLCBpb2NiLT5raV9wb3MgLSAxLAo+ID4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlvY2ItPmtpX2ZsYWdzICYgSU9DQl9TWU5DKTsKPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoaW9jYi0+a2lfZmxhZ3MgJiBJT0NCX1NZTkMpID8gMCA6
IDEpOwo+ID4gCj4gPiBIb3cgYWJvdXQgY2FsbGluZyBnZW5lcmljX3dyaXRlX3N5bmMoKSBpbnN0
ZWFkIG9mIHZmc19mc3luY19yYW5nZSgpLCBsaWtlIGluCj4gPiBnZW5lcmljX2ZpbGVfd3JpdGVf
aXRlcigpPwo+IFRoZSBzZWNvbmQgYXJnIG9mIHZmc19mc3luY19yYW5nZSAicG9zIiBtYXliZSBj
aGFuZ2VkIGJ5IHZhbGlkX3NpemUgKGlmIHBvcyA+IHZhbGlkX3NpemUpLiAKPiBJdCBjYW4gbm90
IHJlcGxhY2UgYnkgaW9jYi0+a2lfcG9zIC0gcmV0IChyZXQgYnkgX19nZW5lcmljX2ZpbGVfd3Jp
dGVfaXRlcikuCj4gU28gY3VycmVudCB3YXkgbWF5YmUgYmV0dGVyLgoKSGVyZSB3ZSBzeW5jaHJv
bml6ZSB0aGUgYXJlYXMgd3JpdHRlbiBieSBleGZhdF9leHRlbmRfdmFsaWRfc2l6ZSgpIGFuZApf
X2dlbmVyaWNfZmlsZV93cml0ZV9pdGVyKCkgaWYgdmFsaWRfc2l6ZSA8IHBvcy4KClRoZSBsZW5n
dGhzIG9mIHRoZXNlIHR3byB3cml0ZSBhcmVhcyBhcmUgJ3Bvcy12YWxpZF9zaXplJyBhbmQgJ3Jl
dCcuCldlIGNhbiB1c2UgZ2VuZXJpY193cml0ZV9zeW5jKCkgYW5kIHBhc3MgaXQgdGhlIHN1bSBv
ZiB0aGVzZSB0d28gbGVuZ3Rocy4K77u/Ck9mIGNvdXJzZSwgcmVnYXJkbGVzcyBvZiB3aGV0aGVy
IHZhbGlkX3NpemUgPCBwb3MsIGV4ZmF0X2ZpbGVfd3JpdGVfaXRlcigpIG9ubHkgCm5lZWRzIHRv
IHJldHVybiB0aGUgbGVuZ3RoIHdyaXR0ZW4gYnkgX19nZW5lcmljX2ZpbGVfd3JpdGVfaXRlcigp
Lg==


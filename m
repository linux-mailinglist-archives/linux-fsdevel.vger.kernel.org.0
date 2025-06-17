Return-Path: <linux-fsdevel+bounces-51847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5AADC1DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 07:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CA516CEFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 05:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44328A714;
	Tue, 17 Jun 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="pEXu/OGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65927EFE9
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750138710; cv=fail; b=qxH48bdd/ZaOnK83n768cTFOIiLflN+iVRScK1Y822JzGMxvH+1qkeGTsevL+mOVpSoacj+YfpveZ6LAKjFFFtlR3/ooczHGpyzCVXBfAnekIglfgQMZHYiieZk5M5UWwE0/z2gvZsfiGVpwhi0qIFWn534/x0g7BigtuOsQj9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750138710; c=relaxed/simple;
	bh=VuUGY5urb9BvZoXpJ4TLIBy0DK+Ls+kqwDlgjUyaPzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dl/YBoZjWNxIDey2rBgoi8NdRVsFUpsjfHCv4ErAJXGWiHxZZfeI0CqsLM1y2DWm0ekvrQSinLL790tbfzdpcCBGesb3MM/SliqbmVdMpT4DIatdx5034XPaM8LQlpGDAXQhYcsQhn+moU2JXvdr566a+IH5hp8aZQgWhMhC5bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=pEXu/OGW; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H3FFjP011517;
	Tue, 17 Jun 2025 05:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=VuUGY5u
	rb9BvZoXpJ4TLIBy0DK+Ls+kqwDlgjUyaPzA=; b=pEXu/OGWsDV4LSyu+eeAAR9
	WMqEEoK3I0GxwX0pNsrMGE+V9IqySm4mQVmvN0LKSgyjfIZ3Jallx7eEtGfRBYY5
	tTangbATozg3LXhHiAxrBBB6P8AEynIxVoTpnT23ngQ7MS/GL520wvoxIHD575QV
	LpopguKk8nIMiwrGpWF3xvD2xkS7KbkWnrZnDcS3+xU4XvkhCq+d4hM/smaHoLzQ
	PRMc/tZFkcyRqd+g04mizRTMsbGxIbeSuREpz3n80jM5uoXCNQzi5t6zj/SIXjzz
	EdJgLHa7WMZF3nFfCAQOrgijXMhLno1OUp9MCqxctfX3LBSNIOzYORwJJccimMQ=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013033.outbound.protection.outlook.com [52.101.127.33])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4790e1256h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 05:38:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukdAGLD2GY/Ik6hJm3St6zAMb+uKxH8fhl2GMxs5Y7TkrsGsugtggCgiLnqCBxotFgbp+uFPbBY/WxAgtMxfNcQJKYGDQ7VMn3ekRZXtT5TuU6MoTMgJQnNHa/vlzHc4/NXFsxd+64YsU+lNoZUmEw8wPQxuJCYwLX8tjYWexbohobo/fu2/IFOA9bio6t6wMzocFozGBTGE4GYgC72K7zmB+PwGAlCoYPEdCJ5F0uPbN1b6MLKqv6uDuDsXfsXB+TTDn9MTpkUzeJLFjCCFpR2GEjm1n6LohKGhYuwJsnm1AqqY4n7bcbx5cpkd0mbzN4ylfF0dn5cbHeu7ecMDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuUGY5urb9BvZoXpJ4TLIBy0DK+Ls+kqwDlgjUyaPzA=;
 b=ltrjwvy+X8mL35ciUElxsxglpnmlxNl2XCK/bcgOn8LsNngL43v4um+v2zEPNMT7qVI+lIkWFzuoi6zavtuSrJcXRc2TBb5hJlLn0zJOoJux/tjuAnO/8wgexlGBa6D66e5QMAvXvWELAkwGhoc19xvP5mi/R1XbqotFVMC9iOq13DxKZR+EElGKovgDkdNlpdigTF0HkhJlQQLxbbhZPccZMjGZ+NNuNGFjAs6polcq0OjEm/adJ5JeZ2K+h1zpOtDlm1qMMtHOfr91L3eNTBS87kFBGejjtUVEUmseAZZ0r7VpfK324eVIH0/WTuTz2nzmrZZk4p4p6dk9gX01GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB5665.apcprd04.prod.outlook.com (2603:1096:101:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 05:38:06 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 05:38:06 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>
CC: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1] exfat: add cluster chain loop check for dir
Thread-Topic: [PATCH v1] exfat: add cluster chain loop check for dir
Thread-Index: AQHb3E98aowgY+DhSkarP/Byf+TS7bQGhzwAgABTRAs=
Date: Tue, 17 Jun 2025 05:38:06 +0000
Message-ID:
 <PUZPR04MB6316B26325B23BD49C3DC97C8173A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250613103802.619272-2-Yuezhang.Mo@sony.com>
 <CAKYAXd_TFNnbJLNsYFW4=mCzVyx1ZqhuLD58aLD5cWu2uk2+Qw@mail.gmail.com>
In-Reply-To:
 <CAKYAXd_TFNnbJLNsYFW4=mCzVyx1ZqhuLD58aLD5cWu2uk2+Qw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB5665:EE_
x-ms-office365-filtering-correlation-id: c468cde7-16de-4a12-4e60-08ddad6122b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTRWcVlYcEJZSDhIdU9BWmkvQzhMS0E5TFBZa3hCbDNrV3VKQjVpcGVoeTUr?=
 =?utf-8?B?NUpZN1dvUXZTSTJacXF6THF1eE9lbE9VSkhWUlV4UjY2N0pveUNieEhjRTlv?=
 =?utf-8?B?RDRIL1FTWWFQU1RpNXRQWStSaUlwTHNkZ3g3MytyMXBWUzRTbEZtRFpQMnky?=
 =?utf-8?B?WXBBUnJvNkdSb3p5eW1xMWJKSDVCbCtHRWVOcWlGclp4aGdDZ1BDanlrN1pq?=
 =?utf-8?B?VGxNSVQwWER5aUhOTFMydmR5WDFzcUVKck9DVVJQMkJ0UktMRjdjNWZMZFdO?=
 =?utf-8?B?K24vVlI4OWl3eGswWWhWaEs4OHcvdWlLT0p0LzQ3TExhSEpXY25lM3ZXTXdY?=
 =?utf-8?B?L3NMMXJkL2JSc3laR2dlSlBuaFVjRFNmYU5tUUdtSW1pK1ZYbW5VZCtQRHNv?=
 =?utf-8?B?UW4wTDVBU0pCaHpubG52dDZhZ1J4cm9KeTF4djJ0ZUV5cGxMYnBlSHJ2ZHRL?=
 =?utf-8?B?SmlpeERmUUgwNFNpSG5MNVJKNnRXdjRoTDduaTRQSXoxT0s1NFNlUHFWQXZ4?=
 =?utf-8?B?Sk5TOEovZVIrVzBvcGpmMmtOMTQ5Q1MwWGdNb1E2SDFFdjlGQkFsVWpJcDlB?=
 =?utf-8?B?V3VFdWVlbGY3SjZtQXJDZFF5S21VNmdSQlY4SlV1SVExeFZEQ01MdEUrZ0pi?=
 =?utf-8?B?Y2JrMS84MUxwNDdseFRwdkFTd0grSFh6RURIUUlMcGVWODVWTGNBRDdXTGlo?=
 =?utf-8?B?VC9DbDlyWnd0KzdDL3I4OTRDZmFkRFE1eUlCY0xLNHVHdzRwVCttWDQ4TGtk?=
 =?utf-8?B?alF1VzlXMkwwNDNPZHBZY25sZUcyQmZ6Tmdid0dpb245Y0NZbWc1OWdXRVlB?=
 =?utf-8?B?d3lWbkpZT0VLbXp2cTZxRDdnTWtBaWp3cFVNa24yaTVTMEIzZzhXd0VuTko0?=
 =?utf-8?B?QzBWL25MUktSamJzQ2h1dEROME8veXJ2RE5KSk4yTWVJbFA1MTNQbVMrL1hI?=
 =?utf-8?B?T1Brems0Q2RBR2VLd0pkOWx3NlErZlc1TFF3STk5SS9taElBVUR3UkZiMkZq?=
 =?utf-8?B?d0RhU0NjdVhteXllZmFoTGhoLy81Tm4wdG15elZMTytDelVTT2Z1Umh4OC9N?=
 =?utf-8?B?QkJnV1NsLzFKdEpobzR6WjliR0NLaFM4dFJNckdNTkxnektXVjdOazhRV2xH?=
 =?utf-8?B?U3N4RFpvVEpVYi9iOEd6TTNJdjk0UW9xaXY0Qno2RUVNWGI1amZvbGk1QUYw?=
 =?utf-8?B?SXJRSTdkaXd1ZURldHF5eGdqaW8yYllBdnBEVnpRVEduTldIbEI2Q1JacTho?=
 =?utf-8?B?dUJiLzB6RFVpWWcyV1VtRVNnTGhIdlE3OUJOVHllQWhxSjI2NU9ja2MyVFZF?=
 =?utf-8?B?aDZ5cUg4ZEdDblhsMDZZZ0xvbmdDZXhsSHNSK1ZXbzc4TTQwYUNFZW5wTGJ4?=
 =?utf-8?B?UTE4R0ZHUlRXcFc1b1FnSC9aeWVNREZPQzVyNjFkN0hOYXpsbTdpa2dVNy8v?=
 =?utf-8?B?cGh5eGVETUJUWFZvbWQ4SFZzMHFUeitKdThNVDVKZkpLTkVsaElOSTByL28z?=
 =?utf-8?B?eGRtaVA0T3BIaDhWOFdLc2NFdlJhNmRCcDRRdVZGUzF5amliVVc1bk9nMmhV?=
 =?utf-8?B?UVJkamUwQXNhVExDOXVoSEJBS1NoeER2OGs0Nk4vdS9PTms0Mm1DbFZYRnB1?=
 =?utf-8?B?NWZOMnYrN2orWHR6WFMvdVR5NjZhRXMzNkJsQ0FNalhJTDZvc3BOL1BQek1r?=
 =?utf-8?B?djl2SHJKWVhIZUpqNFU4aVJyeHh2dkV0SW0vUzBtV2NLaWhqSTZGMlRhT1BE?=
 =?utf-8?B?SUkxSkdBWGIyakM2MW81b0NIK0dNZjRkT0ZwMmRDNWJGNnM0QW9jRGptOUxs?=
 =?utf-8?B?bHN3eXNEVGdIenVmVU5oVys0b2ROVWtTMDBqSzI4OWtFODgyOUk4azNPODlZ?=
 =?utf-8?B?c2FjRVl3SEpxbXoxWS9ubjh6SzFMazY2QTZPeHlMbUV6T2JBZ2hBTXN3Mm5L?=
 =?utf-8?B?dDBxVmlidzFacnBYVXViMmxZWDREb0pFN3BVbElScGhxbXNsMjRrNjdwWlVZ?=
 =?utf-8?B?eSthS1FjNzF3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkhQMHF1clVKMi9Oc0VEeXFNdVk2cnRYNGRZUDBIYm9LVnR5UFdlSHMzVUd0?=
 =?utf-8?B?Z1ZpMjRnRTZlVm53S2EzdXVjUE1CSzhzVCtjRmFFaTNpUEpiTEpyamM1Z2t6?=
 =?utf-8?B?S0Q3cmZxQjVJbzhYVU9PUlBRVTQ3Q1c5dEo3Q3F6Zkc4dG42U09CcWpJbXNM?=
 =?utf-8?B?Y1VOS1A5OVJUWTVoUFR4WngyZDJxeDhNSTZUSlgxR05OSzBDbDRZY0tKVGRl?=
 =?utf-8?B?d0R1RVNrOE1WemJ1TUhqUE4zYlNwNnNYZkFPeFoxVmRmc0lPZGIzUHNGNjk1?=
 =?utf-8?B?b1Qra2N3NWFiLysyNnY1TVhTazBCU2hzN1cyNHBHUDc0K3BpRjBSWFE3dnVx?=
 =?utf-8?B?c1hnNDk0VERlQTh3aE1nSVdrSVk3eDdRbnJuWk9kY09PSWVTYVhvU1VGVmdz?=
 =?utf-8?B?S09xckh5WlVrb0hNQ3dwWEhYT3VlRldRemlwNUczUFZtcjV1T3VJekR3Mjlt?=
 =?utf-8?B?L0trbW54L0FYODNveGhLYVU4blgvNUV1THM3SnNaYUkrMkRSQk9vVEZtbVRD?=
 =?utf-8?B?aUhPTGtDUlpjVG42SUpwL1FpZjRsQ0lSOURBaGlMdHRFanF0NlFLKzg3UkV3?=
 =?utf-8?B?Ymd0R3h5bk1GeTNNSE5rQzNnOVdVS0E2QmdGQmVoWHZpbCs1dHkxZHV5Z1JV?=
 =?utf-8?B?aWloTnpOWHNkYW1oY005YTEzTW16T0Vod3NwY3hodjQxUnNHL2JWbGJWa3lX?=
 =?utf-8?B?OG9lREtZVlNsTmpBZ3V3SnFvREI5Q2QvV0FyL1FBdlZ6NmxRMXR4R3k4a2V4?=
 =?utf-8?B?aFI4eFZOUnFqMnU5enhZbVR5R2VyQU9GYVEvTEkrS2RsUEFwd0hYZGQ3Smlj?=
 =?utf-8?B?Y1dxc0FNZnVaczJua25FK0g3SkVBZ2cvNHBOYXNDbkxPWHJLYThMYnVJUU96?=
 =?utf-8?B?dThsK2hQYnFnOThwb0JvQklkTFk5WEhORWxHWHNqcVBleGo4MGtuL0dGSUZm?=
 =?utf-8?B?b0J6cjNZeUZPRlRtRkJ3eTB6UXhWMDdaVzhRbm5sMVFoSXNWZE1IL0hieUlK?=
 =?utf-8?B?YUxodXNkZldHZ2ZTekE1bW1JalVHU3hBa0VYQmovdE1FN3JVSEpDYWJyOFpi?=
 =?utf-8?B?QjZ3QWRDK25MajBTdGRDM2RnZFpRSjlRQ3lTQWpvaHBUUWlaNWp3bEhYUWt6?=
 =?utf-8?B?ZDh2S0pBcG0vRjNlWGQ0UFZjZW5aZlk1bTljanNiVGNNLzQ5SWZxaGs1WmEz?=
 =?utf-8?B?YlZJZnc3bnNuTVRCTTNZQTRsWHlnYlJBczdqWWNPR1BlbW50TWlrWm9WSTh5?=
 =?utf-8?B?WVRaS3ZwQkErRU9nQmhDcDZwVGJMV1Qxc2JGTWRvcWxrdkFheXFla0svNVVL?=
 =?utf-8?B?YWR4cW9LbUNDTGFDNytPMmZiTGd3VE1iRlBuMzhrcWFSNE04b2NvcmZlVERn?=
 =?utf-8?B?SytXTUxqZ3RKWFFPc3o5MlVnSEcvbVR1QzNwbzBFQzgwQWJIMU00ZmF4MkJQ?=
 =?utf-8?B?TXBqQ1l2dTRjc2lORGVqRnk4UUFOZ3QxRFQ1eXF5cU5BVzR0eUFtWXlEYXlC?=
 =?utf-8?B?ekRLZTg3UmZrWFlYK1FveXFzQ3lzV2QxSEVMRkxqQ2R1TDlTcW0velkwTjdm?=
 =?utf-8?B?c0JURkl6NFhKOHJweVRwcnAwTXRleTBtQWM5SEc5dlZwWjN6OUtJcWFQa0Ev?=
 =?utf-8?B?c2ExTHJDeWRnT2I3NTFHZXI5R2hjWHBBRWlnb1Rzc3BTcHo0M3Qxa0ZKbFd0?=
 =?utf-8?B?RnB2M1BjSkd6OWFLNFZGcDNPVTdGcFFCSmxwc2VWWHVXK2c0dmtqV1pmNk83?=
 =?utf-8?B?WWNCaFY5NjZsMCt0RzFCN29CU1R1Q21UdXk0NlgwRTFabFRVMk5xcjlqU0V6?=
 =?utf-8?B?aElPa21LQWRzN3BCWUJITVA4N2ZpNUU5SHU0YnQ1UHYvbDRGWnNNcmJ4ZTJV?=
 =?utf-8?B?OHB3K0FQbTREbkM4cW5keTE3S2FReWp4OHlsRk1rMjN6OHJRRTV3cDdMcFY0?=
 =?utf-8?B?WkFnL3YxajkreVJhcVhNUFZaWnNwN0JYMnNxZHpiY1dKVk5pVTlHby9aWEd4?=
 =?utf-8?B?NjU0andjVHRYSWsvaUdmRFVEQW1RZy94dmh3SmYxSlR5dml6NEhnZ1g5RXdL?=
 =?utf-8?B?NzdleU9NbDcxKzJYbjBxclJzUm1QWUZLN3dEOXU2QlVGa3ZvZ29WK1AxZ0Zk?=
 =?utf-8?B?OFpGQ204K2tPandmQzFyVUZsUWp6a3IvN0R4dnp3eEJGenlRWUxpUUZHRkFv?=
 =?utf-8?Q?ev599/IIp0H4mdUxrMbax0o=3D?=
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
	8hSX354TXvBlVv8FcLIX9W6R0dYs2zFnzwhR42dZGFT8kxw05PqnOvimDARthBSz8rbVYct6Bgor8Km1UdxuKebqQkoQ6jKAmwcouoCD3QnmubNs8XYePrNlY8fuOpYTaLN7o/ZDwbUGEer/FWZml+kNt+svYX/v8S0XglhU6luSqW3KXh8O0gXitGv1L9yvVO2nHpvhBXnORda9FdnalDWE2JSA2/1E4Ecn/Jmixt5aafcH3Qgrz04qpWRNOxccRitoc70LirbQxf/RvRNWKcc4PnROlV8jhl2226T/mB090HzuYSnez0xLlzibjr6w2wUzifDetvFSrd2oildKb3dQtp4CS8e7EF3fEjoVSe9LBgtWFcNTBPJxk+WGPJJQVNqc8XnZGUIrDLPZhriQGPrnx5yJZd/tT7ba33QXYTHER+HOtF4cly/dTS3fA3ey0ENzVfLEHQrCv60oQ+C1i8l5pr+1EqizczS55+zX2n1YzUnpX4hAK23MWOBCiOvkPlm3bLc1hSHT58hp6Cb9eVfLWcY9bWQQcjn92mK1avVeIkeyU753nzWUL9lt+KGVzKRS5TeZxVhG5bFCvJyrty2oUhx2Tz+7xwldFOGFwAC+oXpCnd/GFkIlRju4dftz
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c468cde7-16de-4a12-4e60-08ddad6122b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 05:38:06.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QF0KXSj1ElUpCe+2VE++LYoGVTkqPH6g/6laVzVXOn12yXZ+H9s1xQv8d8ei8YsPUrsAjWoYK5VJ8Wm8Uhx4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5665
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA0NCBTYWx0ZWRfX/4s0p8ELdNLr F1Z84RghB0t6curWQo8U54x599k+LUwpTHWxWnavIF3m8qiaT/U1+wKSrQgMZjkOLWRSfZWBGH8 XVX10sTfl1luMkVEUcEdv36owgGgGxHpmIQleY8SkJl7gv9yfZvn95mOSlLJCVZlEhkJXlW+WmA
 A7MM+QkzPL7UnzIkY1r7JxxI9/Qca2dXRHBOBlnDH/vAa5Fc6GLb7t9E8kqDpjc/iUVGvF/YOmi Zn7oCZgYnPCcBDpvbmYKKq66kLtXIixjEK7TiWioSkYVaXtgRAHlQd2W/nN9zLz4mdbd6KbV0zx +48/DXgpNsCO7ir9doQYKTEFDCE8WwHm8jdK74ymviINOsaTozPia5pUL1F62GawAB311+nhTBZ
 9hYLzApnaIC6MPnHLp19WivW/2gJx0ShUlnWgjyjb6JxCj8l8GESSzWM44Zd+HmPOmH25GQM
X-Proofpoint-ORIG-GUID: P33h8wUn0LxCRVGPH0R1sEHTGtGyqIU6
X-Authority-Analysis: v=2.4 cv=Xrv6OUF9 c=1 sm=1 tr=0 ts=6850ff47 cx=c_pps a=AV3VLuJWgg5JCmondQPfTw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=qW7_QmQ4r7eZBpYKyu4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P33h8wUn0LxCRVGPH0R1sEHTGtGyqIU6
X-Sony-Outbound-GUID: P33h8wUn0LxCRVGPH0R1sEHTGtGyqIU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_02,2025-06-13_01,2025-03-28_01

PiBPbiBGcmksIEp1biAxMywgMjAyNSBhdCA3OjM54oCvUE0gWXVlemhhbmcgTW8gPFl1ZXpoYW5n
Lk1vQHNvbnkuY29tPiB3cm90ZToKPiA+Cj4gPiBBbiBpbmZpbml0ZSBsb29wIG1heSBvY2N1ciBp
ZiB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnMgb2NjdXIgZHVlIHRvCj4gPiBmaWxlIHN5c3RlbSBj
b3JydXB0aW9uLgo+ID4KPiA+ICgxKSBDb25kaXRpb24gZm9yIGV4ZmF0X2NvdW50X2Rpcl9lbnRy
aWVzKCkgdG8gbG9vcCBpbmZpbml0ZWx5Lgo+ID4gICAgIC0gVGhlIGNsdXN0ZXIgY2hhaW4gaW5j
bHVkZXMgYSBsb29wLgo+ID4gICAgIC0gVGhlcmUgaXMgbm8gVU5VU0VEIGVudHJ5IGluIHRoZSBj
bHVzdGVyIGNoYWluLgo+ID4KPiA+ICgyKSBDb25kaXRpb24gZm9yIGV4ZmF0X2NyZWF0ZV91cGNh
c2VfdGFibGUoKSB0byBsb29wIGluZmluaXRlbHkuCj4gPiAgICAgLSBUaGUgY2x1c3RlciBjaGFp
biBvZiB0aGUgcm9vdCBkaXJlY3RvcnkgaW5jbHVkZXMgYSBsb29wLgo+ID4gICAgIC0gVGhlcmUg
YXJlIG5vIFVOVVNFRCBlbnRyeSBhbmQgdXAtY2FzZSB0YWJsZSBlbnRyeSBpbiB0aGUgY2x1c3Rl
cgo+ID4gICAgICAgY2hhaW4gb2YgdGhlIHJvb3QgZGlyZWN0b3J5Lgo+ID4KPiA+ICgzKSBDb25k
aXRpb24gZm9yIGV4ZmF0X2xvYWRfYml0bWFwKCkgdG8gbG9vcCBpbmZpbml0ZWx5Lgo+ID4gICAg
IC0gVGhlIGNsdXN0ZXIgY2hhaW4gb2YgdGhlIHJvb3QgZGlyZWN0b3J5IGluY2x1ZGVzIGEgbG9v
cC4KPiA+ICAgICAtIFRoZXJlIGFyZSBubyBVTlVTRUQgZW50cnkgYW5kIGJpdG1hcCBlbnRyeSBp
biB0aGUgY2x1c3RlciBjaGFpbgo+ID4gICAgICAgb2YgdGhlIHJvb3QgZGlyZWN0b3J5Lgo+ID4K
PiA+IFRoaXMgY29tbWl0IGFkZHMgY2hlY2tzIGluIGV4ZmF0X2NvdW50X251bV9jbHVzdGVycygp
IGFuZAo+ID4gZXhmYXRfY291bnRfZGlyX2VudHJpZXMoKSB0byBzZWUgaWYgdGhlIGNsdXN0ZXIg
Y2hhaW4gaW5jbHVkZXMgYSBsb29wLAo+ID4gdGh1cyBhdm9pZGluZyB0aGUgYWJvdmUgaW5maW5p
dGUgbG9vcHMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1v
QHNvbnkuY29tPgo+ID4gLS0tCj4gPiAgZnMvZXhmYXQvZGlyLmMgICAgfCAzMyArKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0KPiA+ICBmcy9leGZhdC9mYXRlbnQuYyB8IDEwICsrKysr
KysrKysKPiA+ICBmcy9leGZhdC9zdXBlci5jICB8IDMyICsrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAyMyBkZWxl
dGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZGlyLmMgYi9mcy9leGZhdC9k
aXIuYwo+ID4gaW5kZXggMzEwM2I5MzJiNjc0Li40NjcyNzFhZDRkNzEgMTAwNjQ0Cj4gPiAtLS0g
YS9mcy9leGZhdC9kaXIuYwo+ID4gKysrIGIvZnMvZXhmYXQvZGlyLmMKPiA+IEBAIC0xMTk0LDcg
KzExOTQsOCBAQCBpbnQgZXhmYXRfY291bnRfZGlyX2VudHJpZXMoc3RydWN0IHN1cGVyX2Jsb2Nr
ICpzYiwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpcikKPiA+ICB7Cj4gPiAgICAgICAgIGludCBp
LCBjb3VudCA9IDA7Cj4gPiAgICAgICAgIGludCBkZW50cmllc19wZXJfY2x1Owo+ID4gLSAgICAg
ICB1bnNpZ25lZCBpbnQgZW50cnlfdHlwZTsKPiA+ICsgICAgICAgdW5zaWduZWQgaW50IGVudHJ5
X3R5cGUgPSBUWVBFX0ZJTEU7Cj4gPiArICAgICAgIHVuc2lnbmVkIGludCBjbHVfY291bnQgPSAw
Owo+ID4gICAgICAgICBzdHJ1Y3QgZXhmYXRfY2hhaW4gY2x1Owo+ID4gICAgICAgICBzdHJ1Y3Qg
ZXhmYXRfZGVudHJ5ICplcDsKPiA+ICAgICAgICAgc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9
IEVYRkFUX1NCKHNiKTsKPiA+IEBAIC0xMjA1LDE4ICsxMjA2LDI2IEBAIGludCBleGZhdF9jb3Vu
dF9kaXJfZW50cmllcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4g
KnBfZGlyKQo+ID4gICAgICAgICBleGZhdF9jaGFpbl9kdXAoJmNsdSwgcF9kaXIpOwo+ID4KPiA+
ICAgICAgICAgd2hpbGUgKGNsdS5kaXIgIT0gRVhGQVRfRU9GX0NMVVNURVIpIHsKPiA+IC0gICAg
ICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgZGVudHJpZXNfcGVyX2NsdTsgaSsrKSB7Cj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICBlcCA9IGV4ZmF0X2dldF9kZW50cnkoc2IsICZjbHUsIGks
ICZiaCk7Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWVwKQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsKPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgIGVudHJ5X3R5cGUgPSBleGZhdF9nZXRfZW50cnlfdHlwZShlcCk7Cj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICBicmVsc2UoYmgpOwo+ID4gKyAgICAgICAgICAgICAgIGNsdV9jb3Vu
dCsrOwo+ID4gKyAgICAgICAgICAgICAgIGlmIChjbHVfY291bnQgPiBzYmktPnVzZWRfY2x1c3Rl
cnMpIHsKPiAgICAgICAgICAgICAgICAgICAgIGlmICgrK2NsdV9jb3VudCA+IHNiaS0+dXNlZF9j
bHVzdGVycykgewoKV2VsbCwgdGhhdCdzIG1vcmUgY29uY2lzZS4KCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBleGZhdF9mc19lcnJvcihzYiwgImRpciBzaXplIG9yIEZBVCBvciBiaXRtYXAg
aXMgY29ycnVwdGVkIik7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsK
PiA+ICsgICAgICAgICAgICAgICB9Cj4gPgo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYg
KGVudHJ5X3R5cGUgPT0gVFlQRV9VTlVTRUQpCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBjb3VudDsKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmIChlbnRy
eV90eXBlICE9IFRZUEVfRElSKQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b250aW51ZTsKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGNvdW50Kys7Cj4gPiArICAgICAg
ICAgICAgICAgaWYgKGVudHJ5X3R5cGUgIT0gVFlQRV9VTlVTRUQpIHsKPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBkZW50cmllc19wZXJfY2x1OyBpKyspIHsKPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXAgPSBleGZhdF9nZXRfZGVudHJ5KHNi
LCAmY2x1LCBpLCAmYmgpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAo
IWVwKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RUlPOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnRyeV90eXBlID0gZXhm
YXRfZ2V0X2VudHJ5X3R5cGUoZXApOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBicmVsc2UoYmgpOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoZW50cnlfdHlwZSA9PSBUWVBFX1VOVVNFRCkKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsKPiBJcyB0aGVyZSBhbnkgcmVhc29uIHdoeSB5b3Uga2Vl
cCBkb2luZyBsb29wIGV2ZW4gdGhvdWdoIHlvdSBmb3VuZCBhbgo+IHVudXNlZCBlbnRyeT8KClRo
ZXJlIGFyZSB1bnVzZWQgZGlyZWN0b3J5IGVudHJpZXMgd2hlbiBjYWxsaW5nIHRoaXMgZnVuYywg
YnV0IHRoZXJlCm1heSBiZSBub25lIGFmdGVyIGZpbGVzIGFyZSBjcmVhdGVkLiBUaGF0IHdpbGwg
Y2F1c2UgYSBpbmZpbml0ZSBsb29wIGluCmV4ZmF0X2NoZWNrX2Rpcl9lbXB0eSgpIGFuZCBleGZh
dF9maW5kX2Rpcl9lbnRyeSgpLgoKPiAKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKGVudHJ5X3R5cGUgIT0gVFlQRV9ESVIpCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvdW50Kys7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9Cj4gPiAgICAgICAg
ICAgICAgICAgfQo+ID4KPiA+ICAgICAgICAgICAgICAgICBpZiAoY2x1LmZsYWdzID09IEFMTE9D
X05PX0ZBVF9DSEFJTikgewo+ID4gZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMv
ZXhmYXQvZmF0ZW50LmMKPiA+IGluZGV4IDIzMDY1Zjk0OGFlNy4uMmEyNjE1Y2EzMjBmIDEwMDY0
NAo+ID4gLS0tIGEvZnMvZXhmYXQvZmF0ZW50LmMKPiA+ICsrKyBiL2ZzL2V4ZmF0L2ZhdGVudC5j
Cj4gPiBAQCAtNDkwLDUgKzQ5MCwxNSBAQCBpbnQgZXhmYXRfY291bnRfbnVtX2NsdXN0ZXJzKHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsCj4gPiAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgICpyZXRf
Y291bnQgPSBjb3VudDsKPiA+ICsKPiA+ICsgICAgICAgLyoKPiA+ICsgICAgICAgICogc2luY2Ug
ZXhmYXRfY291bnRfdXNlZF9jbHVzdGVycygpIGlzIG5vdCBjYWxsZWQsIHNiaS0+dXNlZF9jbHVz
dGVycwo+ID4gKyAgICAgICAgKiBjYW5ub3QgYmUgdXNlZCBoZXJlLgo+ID4gKyAgICAgICAgKi8K
PiA+ICsgICAgICAgaWYgKGkgPT0gc2JpLT5udW1fY2x1c3RlcnMpIHsKPiBUaGlzIGlzIGFsc28g
cmlnaHQsIEJ1dCB0byBtYWtlIGl0IG1vcmUgY2xlYXIsIHdvdWxkbid0IGl0IGJlIGJldHRlcgo+
IHRvIGRvIGNsdSAhPSBFWEZBVF9FT0ZfQ0xVU1RFUj8KCk9LLCBJIHdpbGwgYWRkIHRoaXMuCgo+
IAo+IFRoYW5rcy4KPiA+ICsgICAgICAgICAgICAgICBleGZhdF9mc19lcnJvcihzYiwgIlRoZSBj
bHVzdGVyIGNoYWluIGhhcyBhIGxvb3AiKTsKPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJ
TzsKPiA+ICsgICAgICAgfQo+ID4gKwo+ID4gICAgICAgICByZXR1cm4gMDsKPiA+ICB9Cgo=


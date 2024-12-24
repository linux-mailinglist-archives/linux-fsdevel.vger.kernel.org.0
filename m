Return-Path: <linux-fsdevel+bounces-38110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA29FC296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 22:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B895F1884541
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 21:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E75212D68;
	Tue, 24 Dec 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gdL1qoYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED141DA4E;
	Tue, 24 Dec 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735077149; cv=fail; b=XYG9M/6kbOSUNsR0ueBo7B1w3EZCrHUDiZElMFv8IqoFiWuIKOCzRbOZcyKAYu56+ID8sjxJ5Bxc8ocE9V9ZNOx6eCkSSRWmLK4UmNBud69xOM6WwHy50TcWyDER5bsqm7zqrifMJCPITp8LGWBGYRKD4OqHuUifcZqY5z/sPYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735077149; c=relaxed/simple;
	bh=fjkiiKByEz+XajS/QSsZCcYk2NpimwtlQjtHgrw3FkY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=fVYS20MDOytKgCwH+weFmRXCQr+yr7ZhHDCe1OfUPEcpwiZ06UaTL9CQfpjWFr21f94k/E8bApChzRX1wo//q8qO9T0oJOS1OWN/f4IYJs+fZHJo9kRIx4sNztZwA+b3bvMKy/YpfGp2clCLSS7tZEhM/TX1Kr6hIHqPcnm+Nrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gdL1qoYH; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOAhrDe027998;
	Tue, 24 Dec 2024 21:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=fjkiiKByEz+XajS/QSsZCcYk2NpimwtlQjtHgrw3FkY=; b=gdL1qoYH
	m9CmD0mBBEF31zDRoVV1wGL1LcUEFbX4wjdn+6XHiU6VvtthwrBhJ+vXnTMFgwlB
	SgAW/zc+rwcSNsIFyvu95E8B2iZFhODMWDasYGSfFo9r2n8eTpzzrbDCiFPWK4tg
	OESB/6AtF4ik/DhQdYvkvZJ4S2RLHZT8aedATInuYbbuFptiTi5LvxF/zdHKsPtI
	7Bv2ijdQWuXPPXS0QkfmlckxZ4tMnBhslYt/pGhNNjq4ekvG5QobFeBK2x1e9636
	H1C6H54lxg9HGkgQ1nCmrm8qtx2lTuuR9s/W3aBnFUNVy0DStb4Mg7+MUv/E4x5r
	DRH3l7Z9rEzUHg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43qhpaby9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 21:52:14 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BOLmwNx008279;
	Tue, 24 Dec 2024 21:52:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43qhpaby99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 21:52:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNyZkFicKySRFVSzra5UQO56EWiwBn1vJ0hIlh+LxkrcJC/VC3FhI9Ov574up7PPEirmJqOSN4kpJKnXXb9yOez2t4/nJm1BY4gTm8yJKQUC0Lcwv2NIsR3KWVhLZ12XY4whpiTJwrjf7oof9rV7CPxrUonOmK70R8TWaYgC24/Qq2s51bQ5o/a+0Qm0wj0f4aDn4P5dhQfW/SZS+V/I6mKHFzhmBuvDQZIu2+SODLrnUuerIx7A24oIOAZQG6PrxmzWLuz2dDJn6KPUrhAXbfmgzMvbOkQB7Gkfll0gEY6tJt7ual2t6pHei0lckenAwa0e+fPL/75cJOMIaRRs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjkiiKByEz+XajS/QSsZCcYk2NpimwtlQjtHgrw3FkY=;
 b=AN1r9y21g+hYOJfrqJzsWVVKgUmf7NWNPI56BWW/tf8gDzLyc0Ol2kqoqRf8CeL96BN4uwQn/8q/BWpigiPfTtSaFcCRRabmeHS2UcDMbheKx+dddANomcbVsEcot6Uo6ncuuEx2ES9THVNfIhfAlAOaleR8x/CTNM0ofegj4VEZWoru+jdhGF8g/0LBV8tSq1zDr47AplTLOnZTQgTWnSxl1v9Q01hdaVXJd37B5Bs5rfaIac0sR3Ux61PlxgJT0zY6f+f/1BGIUpXXdnATTkhKhigOETTG3XPuQsV+1iufQMUKYLoE77mnCDk9Rxc3Is/Qbe/vYdMNHOx6D1odgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5760.namprd15.prod.outlook.com (2603:10b6:510:280::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Tue, 24 Dec
 2024 21:52:07 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 21:52:07 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: Xiubo Li <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: Ceph and Netfslib
Thread-Index: AQHbUYXLTU7JxE5eTkerRf23TGd+kLL0fZYAgADl+oCAAJWJAA==
Date: Tue, 24 Dec 2024 21:52:06 +0000
Message-ID: <27edf000fe586ecd860c31fa30f0e17e10f4c15f.camel@ibm.com>
References: <1729f4bf15110c97e0b0590fc715d0837b9ae131.camel@ibm.com>
	 <3989572.1734546794@warthog.procyon.org.uk>
	 <3992139.1734551286@warthog.procyon.org.uk>
	 <690826facef0310d7f44cf522deeed979b6ff287.camel@ibm.com>
	 <Z2qvlXf08wuZ81bv@casper.infradead.org>
In-Reply-To: <Z2qvlXf08wuZ81bv@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5760:EE_
x-ms-office365-filtering-correlation-id: 1607910d-44b5-4642-8782-08dd246535dd
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aE9HYk9SdVJ4R0Z2bDU3a3A5L3dxWWVBOHJyZFFDUUNERVV5RTM2cG5XZlA4?=
 =?utf-8?B?T1VhM2NlQUlDc2VPU3ZYN0grc2I1VTczZkxxa0R2UGgxVGdaQldJY0hCUlFD?=
 =?utf-8?B?a0JqN1hqaExNbHNKRDdzSHhqYlNjbDRFTXJKd2tsaFp0djVpbmhKRTRDcTBV?=
 =?utf-8?B?VnV1blROb2F4U2daWGtFRzA3NDNPdU9VZ3l1aTlpbEtWOWhMZllyaXgwd1Zs?=
 =?utf-8?B?eXdpT0VENHNVR1J0Q3Z0YzZ4ajRjQ284bGM2MTVtUHgzaS9YbHN4YXk2TTVp?=
 =?utf-8?B?SW52SGtuUUxhOWtpVzZHelBxc3Q0blYydEJ3VlI5RTkwQUdTNnhWczNMaUVr?=
 =?utf-8?B?dE5RL292Sml4L1l1UHdZdW13VlpLMWN4a0xXUFpaNFUvQWp2V3l5TG1uRnMx?=
 =?utf-8?B?Y2x5ZzJYbjFmWXlQTWZRaUJUYVdNekFXb250bjNTTTVObkt4a3BtV1A1cmtE?=
 =?utf-8?B?SXowQjZleWZtQ3VPTWdtejhRTkNsdzV2Z2o5NVpaL3NaS0h1cWxzbVJuWUFP?=
 =?utf-8?B?MGJtZWs2NUJGdTVKSk9JWG9uUE4rQWRnQVp5Ui9hVDd0eEFJbGxUa0lYNDhr?=
 =?utf-8?B?blNLbjV6TWcxSit1YlVBakZzZmxuUDduQ3JhSFJmZ1E3ekQ2aGJRdlVVNVZQ?=
 =?utf-8?B?djN0andoL3JDbDQ0dlQ4VDZWOUV5eEpaQWREYWc5emorWVlDeFNLSU14blFQ?=
 =?utf-8?B?VVFlekMrdE5ZVmdlTEJ2VzFvQUora0JoQkZodzRvdDYrWldJNitadUxjQjEr?=
 =?utf-8?B?aVZ3OVJsYkhkbzQxNnRWcDBQdFJSMnU5ak41MVNScS9yM2pES1JSeTZxNkZG?=
 =?utf-8?B?MldrQ2g4NFQydDdhS2xKeG9EQk5VRkdMeW40cHZTckwxaENBN2ZINUQyVnp6?=
 =?utf-8?B?REdTdmlFU21wRW4veGJnS2NxdVJjV0k2VS9BT0JNU0dqRHlZeTdwWm9NMVVV?=
 =?utf-8?B?dUVPelBLZVFqMGlHS2VFSkxKOHk0RE1xQi9Ecmo1WUtiT2ptSUlOcEl4ODVy?=
 =?utf-8?B?RG1mM0JsSUFrRTJXNHBPOExXTUtsZ3NBMFRZMENXU0tKL3psMHltVFE2YmNP?=
 =?utf-8?B?RUU1ZU1zUWRBUFlOdThhNkpZam04NnY4RXZKNVpLRFF5Wm83NDY0Z0RDQ3B6?=
 =?utf-8?B?ZUlDM1J4V1ltNTlzcG1YV2k5L3hWVUZ5Y2d0RmhmcjZJK054VDViRWlyejhM?=
 =?utf-8?B?ZkhCYzZwdmhXL3kvNWJlNEQ2RTFabVQ2YUZMNFhHU2FlVzh1R0N6UkR0Rkt5?=
 =?utf-8?B?TFUwYjc0SGdlTWt0cUYrM0lzRGRiM1dKVzltMUM5SFpzNk9RS0xjTmYxSzl3?=
 =?utf-8?B?ZW4zWjdKeDIwYjZZV2Rzc25nRVc2bHBOT0VTTEJNSmwvM1VFT2ROb2wzdVY5?=
 =?utf-8?B?MmVSbVZRWGkrYkRFays4Vm00NkNaWFIzVWdVTmRTSm1ZY0V2SnNZODdFaG5T?=
 =?utf-8?B?Ym83MU1lemw2VmdpY3ZuNTRieXlobmphQmQ0OGpRVThTdlkrOStxMHZ1VWNs?=
 =?utf-8?B?SmpqOFhQSGRaSWlQTGRMZVlIQ2g3MjlyS2tYcDgvaGJlanNsek1FWEorWmU1?=
 =?utf-8?B?RWdCTGUxVnViSGFLMXU4NjhjODRydUJCcmdNSXpjZ1o0Vk9TR1hkelNYZ2lY?=
 =?utf-8?B?WDlLVGhEMmVZdlRPVjdUczZZbk5WbldocnVDN2NVenJqdVpPU2o2NHB1Zm45?=
 =?utf-8?B?aDBPeTUxREZ3V0xDWGV3SzM0WmJHMU54NVFOUjFFTDF0d0RYbGp1WmNsaS9L?=
 =?utf-8?B?a1JXTFVweU9MSCtVMVAreGJXTUZtVlUvb0thVFk4UHpBTnpCTlhYd1N5elVp?=
 =?utf-8?B?bUwrTi93b2VkVDlVcHVLeEwydzFQNDBRNWVhUndHbmw5TEdqL1pxbGtIY0Jz?=
 =?utf-8?B?elhseVIwZXY2ZGlHRVk3ZldienNTT0hrV0N4WjllYkxqbE84c0RCSXFySDM5?=
 =?utf-8?Q?QcoR8kDqQJ4FMhbbS91iLnS3QmLR2ivn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlZTWmxIZWM1OUNxTmNab0lXb05wV0Voc3FTK1BTZWwvRjZ5eCtKcVdvaXVq?=
 =?utf-8?B?dTNDVkF5WXlyazVTUnd4TS9pektPTUt0ZzliMkJPcDJhOWJ0RExoT1Zlczd2?=
 =?utf-8?B?bTZ5MllNVHRBaTBYcUt3aVF0NDVWTXFJeWdDVGlFV1VKeG9MYktmN29STTdV?=
 =?utf-8?B?NlJxemh0Rk1lQmdFVVN5Y3QwMUhjVGVaQnBKa3BqbXhRNUhUQjV1Q0xsM2Uv?=
 =?utf-8?B?YkNzMHBrODlGMy9mdUZwY1FNWjJZTzEyWmhENGZlcnFTUllZM2JnS2Izd1ZQ?=
 =?utf-8?B?WngzcHpoL1hpK1hIcU54QVpLbkJ1OVNCaHhGM1hsKzJnVGZ5UlV0L09abUJl?=
 =?utf-8?B?Y3VocWFXd3lJT2tRdmVwQjdPczI5YVdmNDl4QVVjelJyOXVsZ1RWd2Fja0wv?=
 =?utf-8?B?SlFzUE1Za0V3bXM1OWRjNHVVSTBHUFhTWjZsT0txcTdoSjNIcFVuci9zKzI3?=
 =?utf-8?B?ellwQWhKZE9qVER4c2lKZXlzWGZoNnFDcW91NmFvU0pyM3RxVlA2RVZrcitl?=
 =?utf-8?B?WE8vcmlzSi80UDVUYit2anltZmp0dEJQb2psVEp5SXMwcGMrUlVrZDhTRkJQ?=
 =?utf-8?B?MlVwTWFFU2xWK3lIVUF4SGJXbmlnQ0hYblN2RE13SmUyUjhETWpoSVpOaVRC?=
 =?utf-8?B?ZUROc1F5ZTN1azlpQkYzQ1V5eXhiekV2T1V0WWMvcmRyTFpuOVp3MVVySVVI?=
 =?utf-8?B?ekFIN0MwYUdPZklSTmt5NkE1eWpJUnJNbHg5US9tNktKODFnb3UwUmpncVlY?=
 =?utf-8?B?cW5KblhVcVlOQjB2TFp4MnRsK21uejlSYW93bXNDaTRlTVd6U1A3dkc1c1dw?=
 =?utf-8?B?RWp1QktySEQ3YTRrTDAwRGFkSisxV3VxNTZOekc5STcvekc5bi9PU2JTNVhL?=
 =?utf-8?B?SmR6VDl6RTkwdUNyajUwOEx6azhDcHE4bjlFY2UzYWVEL2NmSzh5eGkxenJJ?=
 =?utf-8?B?QmlleTR6bFA5N0pHOW0yR2hoVDk2QWp3UWxNUTJHd1FJbTVuVDZTWlpmVS82?=
 =?utf-8?B?QlQxZUpjYVBaUGRDd2M3emdIV0R5dkZJVk9xNXpZNmdERktXVUo1KzJmVk9X?=
 =?utf-8?B?bWhpUE9sbG5TWnJVeDRBcnI4STFCRy9KTFNscTZVK2ZIOWdXS3V4RVZpY1RT?=
 =?utf-8?B?cTVrWk5XSElCSUxHNHRjNkhjN2hJWHhvWU1qYnp5N0hPellrRGRiYUhZVStF?=
 =?utf-8?B?SStwVVlvam5BbFA3VFNlQ1M3T3prUlNrVDB6Ti9tN29ha1pHbGtZQnBubVJQ?=
 =?utf-8?B?WXdwSXhhMlFHTER3NnFTcngrM1lnMWtDU3ZISEVUM2k2UkFod0g5aW1zQ0ky?=
 =?utf-8?B?azNDa2xaVm54VWwxeENMdFRPZzVTUExrakhrcEhNOTkwOUJKWHpGb2E1d1V1?=
 =?utf-8?B?Ykc1T3RPR0VXbWJTSTVydXRGVDI4MzdvZ1JLNm92Njg5WlBXdW80OTFKY09M?=
 =?utf-8?B?Zlh4RzVPdVFBSWlYTGFvejVnN1BFOTJ0QlE4WlJjMFZFanNmMWlIRUhIbTRL?=
 =?utf-8?B?dlU3RnVYcVI4R3lyYVkvdDlwdUJvVVBGODhlcTBmR1NQWm0rRHRWU2ZVYkpa?=
 =?utf-8?B?WDNpcXNXMFoyN1hzSllLc3d0TFFzdkxEek1taVNJNm5GRlY3M3RpQ0VoL0Y0?=
 =?utf-8?B?S0NVb3A1L0EzZHdaU0VDaXAxbDYxcnd5emt6b0hvQWhEMFF2Mi8wdE9YMTFG?=
 =?utf-8?B?NUcxOHN3dTNYMVNSY1AwakFDbHFpelNiMkR4azNMdWtZV0lUNlFzZ0Jaa05a?=
 =?utf-8?B?NWdqSHlPMVc5a0IvelFFd0NaQ0xrZnhzZUVUSks1Nm9wYy9nWHQ2OUNUVG5h?=
 =?utf-8?B?aUFhWjdMSVUzR2NxdnBUOGZBaUQ4QS9TRHpBL1JDelY3MDIxS1Rud2pYd3hy?=
 =?utf-8?B?dHo5N2tUZVVJV21JZ3gxaGYxTTRTOTNheTg5VzJBTWtoY2FYNzhLM20xVHph?=
 =?utf-8?B?YVhhU25LZ1F1LzNlQTIrOEh1L3VCb1c3OTVGZlB3RXVQN1J0YlE2SEVpZGJI?=
 =?utf-8?B?VXIrTjZYSUhFdSsvWDBTQVF5UXRsK01zYmVxZmRWZDd6cFRkcnVGaUlscEoy?=
 =?utf-8?B?U09PUytDU3cvUUQ4cEk4RFRUV25XQjkzcE5VOS82cGJ4Zk5yZE1FZHVKZExm?=
 =?utf-8?B?WThnamFkb0lZUEE4VFdvMS9QYmxkSi9IeXZocU8vTjBESU81RE9RNFlzbDhi?=
 =?utf-8?Q?drq6Xd7X/eS9g7JtQUT5hO8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7D12B888E63524687DF80CFD0A3AC01@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1607910d-44b5-4642-8782-08dd246535dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 21:52:07.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0lxz8mtzDvQ9qInhHWl7jKOXgB1oTx3cuoida+La4w9lzdPRhycs/CaDr8M1eV5V85zPjMdl+KMcIottqmaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5760
X-Proofpoint-GUID: 0vU2AZDg7Pjcvl4by5JNCD0nLmHEcUlb
X-Proofpoint-ORIG-GUID: rnzECHCJDCvRUSIX1OLd0BU_uQ6mzFyW
Subject: RE: Ceph and Netfslib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240184

T24gVHVlLCAyMDI0LTEyLTI0IGF0IDEyOjU2ICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gTW9uLCBEZWMgMjMsIDIwMjQgYXQgMTE6MTM6NDdQTSArMDAwMCwgVmlhY2hlc2xhdiBE
dWJleWtvIHdyb3RlOg0KPiA+IMKgKiBPbiB3cml0ZWJhY2ssIHdlIG11c3Qgc3VibWl0IHdyaXRl
cyB0byB0aGUgb3NkIElOIFNOQVAgT1JERVIuwqANCj4gPiBTbywNCj4gPiDCoCogd2UgbG9vayBm
b3IgdGhlIGZpcnN0IGNhcHNuYXAgaW4gaV9jYXBfc25hcHMgYW5kIHdyaXRlIG91dCBwYWdlcw0K
PiA+IGluDQo+ID4gwqAqIHRoYXQgc25hcCBjb250ZXh0IF9vbmx5Xy7CoCBUaGVuIHdlIG1vdmUg
b24gdG8gdGhlIG5leHQgY2Fwc25hcCwNCj4gPiDCoCogZXZlbnR1YWxseSByZWFjaGluZyB0aGUg
ImxpdmUiIG9yICJoZWFkIiBjb250ZXh0IChpLmUuLCBwYWdlcw0KPiA+IHRoYXQNCj4gPiDCoCog
YXJlIG5vdCB5ZXQgc25hcHBlZCkgYW5kIGFyZSB3cml0aW5nIHRoZSBtb3N0IHJlY2VudGx5IGRp
cnRpZWQNCj4gPiDCoCogcGFnZXMNCj4gDQo+IFNwZWFraW5nIG9mIHdyaXRlYmFjaywgY2VwaCBk
b2Vzbid0IG5lZWQgYSB3cml0ZXBhZ2Ugb3BlcmF0aW9uLsKgDQo+IFdlJ3JlDQo+IHJlbW92aW5n
IC0+d3JpdGVwYWdlIGZyb20gZmlsZXN5c3RlbXMgaW4gZmF2b3VyIG9mIHVzaW5nIC0NCj4gPm1p
Z3JhdGVfZm9saW8NCj4gZm9yIG1pZ3JhdGlvbiBhbmQgLT53cml0ZXBhZ2VzIGZvciB3cml0ZWJh
Y2suwqAgQXMgZmFyIGFzIEkgY2FuIHRlbGwsDQo+IGZpbGVtYXBfbWlncmF0ZV9mb2xpbygpIHdp
bGwgYmUgcGVyZmVjdCBmb3IgY2VwaCAoYXMgdGhlDQo+IGNlcGhfc25hcF9jb250ZXh0DQo+IGNv
bnRhaW5zIG5vIHJlZmVyZW5jZXMgdG8gdGhlIGFkZHJlc3Mgb2YgdGhlIG1lbW9yeSkuwqAgQW5k
IGNlcGgNCj4gYWxyZWFkeQ0KPiBoYXMgYSAtPndyaXRlcGFnZXMuwqAgU28gSSB0aGluayB0aGlz
IHBhdGNoIHNob3VsZCB3b3JrLsKgIENhbiB5b3UgZ2l2ZQ0KPiBpdA0KPiBhIHRyeT8NCj4gDQoN
ClN1cmUuIExldCBtZSBzcGVuZCBzb21lIHRpbWUgZm9yIHRlc3RpbmcgaXQuDQoNClRoYW5rcywN
ClNsYXZhLg0KDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2FkZHIuYyBiL2ZzL2NlcGgvYWRkci5j
DQo+IGluZGV4IDg1OTM2ZjZkMmJmNy4uNWE1YTg3MGI2YWVlIDEwMDY0NA0KPiAtLS0gYS9mcy9j
ZXBoL2FkZHIuYw0KPiArKysgYi9mcy9jZXBoL2FkZHIuYw0KPiBAQCAtODEwLDMyICs4MTAsNiBA
QCBzdGF0aWMgaW50IHdyaXRlcGFnZV9ub3VubG9jayhzdHJ1Y3QgcGFnZSAqcGFnZSwNCj4gc3Ry
dWN0IHdyaXRlYmFja19jb250cm9sICp3YmMpDQo+IMKgCXJldHVybiBlcnI7DQo+IMKgfQ0KPiDC
oA0KPiAtc3RhdGljIGludCBjZXBoX3dyaXRlcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0
DQo+IHdyaXRlYmFja19jb250cm9sICp3YmMpDQo+IC17DQo+IC0JaW50IGVycjsNCj4gLQlzdHJ1
Y3QgaW5vZGUgKmlub2RlID0gcGFnZS0+bWFwcGluZy0+aG9zdDsNCj4gLQlCVUdfT04oIWlub2Rl
KTsNCj4gLQlpaG9sZChpbm9kZSk7DQo+IC0NCj4gLQlpZiAod2JjLT5zeW5jX21vZGUgPT0gV0Jf
U1lOQ19OT05FICYmDQo+IC0JwqDCoMKgIGNlcGhfaW5vZGVfdG9fZnNfY2xpZW50KGlub2RlKS0+
d3JpdGVfY29uZ2VzdGVkKSB7DQo+IC0JCXJlZGlydHlfcGFnZV9mb3Jfd3JpdGVwYWdlKHdiYywg
cGFnZSk7DQo+IC0JCXJldHVybiBBT1BfV1JJVEVQQUdFX0FDVElWQVRFOw0KPiAtCX0NCj4gLQ0K
PiAtCWZvbGlvX3dhaXRfcHJpdmF0ZV8yKHBhZ2VfZm9saW8ocGFnZSkpOyAvKiBbREVQUkVDQVRF
RF0gKi8NCj4gLQ0KPiAtCWVyciA9IHdyaXRlcGFnZV9ub3VubG9jayhwYWdlLCB3YmMpOw0KPiAt
CWlmIChlcnIgPT0gLUVSRVNUQVJUU1lTKSB7DQo+IC0JCS8qIGRpcmVjdCBtZW1vcnkgcmVjbGFp
bWVyIHdhcyBraWxsZWQgYnkgU0lHS0lMTC4NCj4gcmV0dXJuIDANCj4gLQkJICogdG8gcHJldmVu
dCBjYWxsZXIgZnJvbSBzZXR0aW5nIG1hcHBpbmcvcGFnZSBlcnJvcg0KPiAqLw0KPiAtCQllcnIg
PSAwOw0KPiAtCX0NCj4gLQl1bmxvY2tfcGFnZShwYWdlKTsNCj4gLQlpcHV0KGlub2RlKTsNCj4g
LQlyZXR1cm4gZXJyOw0KPiAtfQ0KPiAtDQo+IMKgLyoNCj4gwqAgKiBhc3luYyB3cml0ZWJhY2sg
Y29tcGxldGlvbiBoYW5kbGVyLg0KPiDCoCAqDQo+IEBAIC0xNTg0LDcgKzE1NTgsNiBAQCBzdGF0
aWMgaW50IGNlcGhfd3JpdGVfZW5kKHN0cnVjdCBmaWxlICpmaWxlLA0KPiBzdHJ1Y3QgYWRkcmVz
c19zcGFjZSAqbWFwcGluZywNCj4gwqBjb25zdCBzdHJ1Y3QgYWRkcmVzc19zcGFjZV9vcGVyYXRp
b25zIGNlcGhfYW9wcyA9IHsNCj4gwqAJLnJlYWRfZm9saW8gPSBuZXRmc19yZWFkX2ZvbGlvLA0K
PiDCoAkucmVhZGFoZWFkID0gbmV0ZnNfcmVhZGFoZWFkLA0KPiAtCS53cml0ZXBhZ2UgPSBjZXBo
X3dyaXRlcGFnZSwNCj4gwqAJLndyaXRlcGFnZXMgPSBjZXBoX3dyaXRlcGFnZXNfc3RhcnQsDQo+
IMKgCS53cml0ZV9iZWdpbiA9IGNlcGhfd3JpdGVfYmVnaW4sDQo+IMKgCS53cml0ZV9lbmQgPSBj
ZXBoX3dyaXRlX2VuZCwNCj4gQEAgLTE1OTIsNiArMTU2NSw3IEBAIGNvbnN0IHN0cnVjdCBhZGRy
ZXNzX3NwYWNlX29wZXJhdGlvbnMgY2VwaF9hb3BzDQo+ID0gew0KPiDCoAkuaW52YWxpZGF0ZV9m
b2xpbyA9IGNlcGhfaW52YWxpZGF0ZV9mb2xpbywNCj4gwqAJLnJlbGVhc2VfZm9saW8gPSBuZXRm
c19yZWxlYXNlX2ZvbGlvLA0KPiDCoAkuZGlyZWN0X0lPID0gbm9vcF9kaXJlY3RfSU8sDQo+ICsJ
Lm1pZ3JhdGVfZm9saW8gPSBmaWxlbWFwX21pZ3JhdGVfZm9saW8sDQo+IMKgfTsNCj4gwqANCj4g
wqBzdGF0aWMgdm9pZCBjZXBoX2Jsb2NrX3NpZ3Moc2lnc2V0X3QgKm9sZHNldCkNCg0K


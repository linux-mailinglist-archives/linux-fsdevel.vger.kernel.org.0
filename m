Return-Path: <linux-fsdevel+bounces-54376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E1AFEFE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 19:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3AE7BB902
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F7522D4C3;
	Wed,  9 Jul 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Pgo85ONs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701CFC1D;
	Wed,  9 Jul 2025 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082319; cv=fail; b=eXIoYXqEAckvAXe6SfSQ9K7NcR1vzOZ8SkEwm9fPpMal//vgl0jR1SsakH+he/rH9i7Fy+GzZzd30SdzlOI1I0CHgXE0A9IfQH3uISu5sCEJ35K6X7rrr9SzPbaXllZWG3HbX7Fok83qGlTDKGqS1QWTUohv8ikta5qCO30gYW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082319; c=relaxed/simple;
	bh=y3jJKBaqZIhog9SA3YHoNL9aaQ08TOL4TAjncZlUhjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soiKTq8tixNVJ9Sd6T9RQvP3ECgNStNId23mWEaq5dpE2bOg4vtX5hHj5OTdCslkPQwLclaLOIiHwj4LtH/Icx0oAujVgWNxk1mOZ3hQu5Es/kKD8tHbzy2t17zFZtwKZnUCwM0vRA4508YlmVHUwowLVFb8O4ZYWh0UstzbHxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Pgo85ONs; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569EUV0W021462;
	Wed, 9 Jul 2025 10:31:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=y3jJKBaqZIhog9SA3YHoNL9aaQ08TOL4TAjncZlUhjI=; b=
	Pgo85ONsq2r3lkbpBpeTJggsSRFu8Ab7y4rIz7id3LaxhommdXM4tv/M4My4Gue7
	8LEe9HBgk2Gd7vEttYTLH2eqwuykuN+KdhhSGUb4x0afejcd7OBGP30Qdn4Jl49Z
	mYbwOSJweDUU5Q0osXiXSmaQHpHHJEfzK+aOBwOSYoW+0g2W35al1lrk0rP/nlQD
	rzsMbqHXijS0Q+BOaMyMUuVwP0YeWYqsWjhFnqW0S4y69HpiJA49ZdAmuoYbCPyZ
	HuEj/f0pK/Liv0FB9h/QUvuzOfgjXJ4bhNluRvjQdKz4xdilnJmlQyy8rhGUAfCW
	8o6iPdfi9gPiHTlvKlt1Ww==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47snbj3muh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 10:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gv2Ht8sG6kaBjgNWTjvhcglk35Tjwvg/s7FWBUFftdlCm9ljvRdFbtT9kVr1ths/dDXlpxI5iHlHkxLGCwnFeqlXBsVP2+HZzf8zVkXCaaAgfydzvlJiZl+wPKwXIKW1mGDW2TMoHG5XpGjfl9DJerKw6ZrfpH128/5Wh5scpQ8yPmhT+TVpFK62wEQQBmdUpBPu+HQch5e7g1KxgwofMhZtwidIrA7l2pdnGLFy3JdBhBYvvjdvzljAIT1m0zJ+BAnNsgFbxJqAXysqJ29SxSi7qx+ZX5ROnNXuMOFehuUfqEusQfYiKDGSUgSAyxKda6y+AbGX/Rlns/Crq2x4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3jJKBaqZIhog9SA3YHoNL9aaQ08TOL4TAjncZlUhjI=;
 b=wY26MmvagzsJV02WxzvVA2ArBRUxNXPEYViUf6qjgiy0ABr3PZ08Nt+xKbM0Lj+7099gU9eSTC9HQBQ4KHWGtzKmUWGzRlcBl67D/ch9L7qKrdRAk+swBDVNiMRzdaYTUSB2TPG2fY0QhskVF9XsxuxztEUz46W096oLWbcWj1VR/M7iDnNX+0rQ2jtIK/f2RTAS1iAySzQ2Aqm5R1vywtY0UPsJ3X1txxpXQXwEZ0eeghdPONjC8nVqoDDozurIwU433RJ112DpRyG2eOgKssYx3ZDPsFzMZiApAOL/sJZyOyjLl6o5XD93rNMo33QWxNCcIgNNwxsb1sSiBhB09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH3PPFD483AE7A5.namprd15.prod.outlook.com (2603:10b6:518:1::4c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 17:31:50 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 17:31:50 +0000
From: Song Liu <songliubraving@meta.com>
To: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>,
        Tingmao Wang <m@maowtm.org>, Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>,
        Jann Horn
	<jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Topic: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Index:
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAEtZgIAARLiAgACMg4CAEH8tgIAACIOAgAB+hYCAAvcGAIAAF8IA
Date: Wed, 9 Jul 2025 17:31:50 +0000
Message-ID: <C8FA6AFF-704B-4F8D-AE88-68E6046FBE01@meta.com>
References: <127D7BC6-1643-403B-B019-D442A89BADAB@meta.com>
 <175097828167.2280845.5635569182786599451@noble.neil.brown.name>
 <20250707-kneifen-zielvereinbarungen-62c1ccdbb9c6@brauner>
 <20250707-netto-campieren-501525a7d10a@brauner>
 <40D24586-5EC7-462A-9940-425182F2972A@meta.com>
 <20250709.daHaek7ezame@digikod.net>
In-Reply-To: <20250709.daHaek7ezame@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH3PPFD483AE7A5:EE_
x-ms-office365-filtering-correlation-id: a9bc1898-ed0d-4917-7e77-08ddbf0e7d2d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGpHQjVEQ0QweUMzbmpyMlkwL0VZM3pyK0FwK0JKZE8zamg5UC90d1lkN0FC?=
 =?utf-8?B?YUF4Wmo5allEWE04bDhUOTVzQVFxbFhjNEI0cnE1WU05UUl0MnBJMDUyUEtP?=
 =?utf-8?B?ME00YktiK0lZWHpnU3JwVU45d3hPOGoxUXlYV3FYblg3NVdaSllCWmxNNWwy?=
 =?utf-8?B?WHFacDErTzJHNUVOYjRKdkVMQ1BvbnM3R2hoT29kNm1yeGlYWllUcm1OWkF1?=
 =?utf-8?B?aWg3YjZ4WVV4WXdjWWtZZE02NmZXbjZRaDA5Nkp2VW9pWlJrMnIzWXlQQWl1?=
 =?utf-8?B?SXEyUnZZS1UrYzZqajhpbU9lM1JHWFpGbitlRENWbmx3QTlRTTBXZXVkSTht?=
 =?utf-8?B?MlJmSGdQdWIyQ1BqNUJMeU5VOHJ4WEVRbzQzeFpmdmVPZzlHanl3QTVoYUg0?=
 =?utf-8?B?OGFxTUk2WDBuajNuYURoM2lXZmRpS1ROeFRxMHpmUXpZTHVBNGtKZ09GMEJD?=
 =?utf-8?B?ZzVGdnljRGxyc0RRbjg0MmVxTnhEY2JNQUhBeWlOVjBSbzI2K2dIL0NjV1gx?=
 =?utf-8?B?ZWtBeUZTdldwZngxdEpCL1NHUDAvM3N3U0h0S3lyWEVaOFdhdGpZWVBhcFRY?=
 =?utf-8?B?VnY0QlJMeUVwbE9WRi9DY29sM2JkSVkxdVk3Z054b0ZBczVMcy93ZUZFK0gw?=
 =?utf-8?B?dGdrbEdwZGY4RktrVE1KVUkrMTR5TGpDV3JmTEJ5K0c0TFpDVFpHSWtoazRO?=
 =?utf-8?B?T2FQdTQwOVR6Qi9PcDF0N05zQ1FRZmFmY1ZLZDQyc1BYTVpGa0xVNTlBcDM0?=
 =?utf-8?B?cWpGQTQzMmhGWjVjQlBCK3FBamRCZnJPd1ZjVU4yckN2ajBsbE9OZ3g5dTdH?=
 =?utf-8?B?ZGtlV285YVI0SnNzRGdVUERWeTRKWHRFcDNhT2M2VG5CMU9xRzZDbmtycFBF?=
 =?utf-8?B?UUNxY1lRZE1FVVBFaDM3Y1gwcldxRlQvOUdBNnVQdmtwWTR1UDY1S1pzTTNR?=
 =?utf-8?B?T1hlUHRMS3U4Z1NXeisyQmE4aXNTQ1kzQmhDd1cxbDdqV2xOaEVYSnJDYVAr?=
 =?utf-8?B?cm43WGxxUDBMalkwL3ZDeWg5bGpyOXlocnhIUzQ3eU1Zb3RVQjhRTW1oT25Q?=
 =?utf-8?B?NzN4ME0vUlN6eGJtSHpxZVcwRzdsZDFENEYrdGFxYWJ0aXFOMGxSWkNZWnJU?=
 =?utf-8?B?U0RBNHhqenloQTc1Y2NENjVRbkhqZWZJNXE1S0VBbXMyNTQ0TFptWWlGKzZD?=
 =?utf-8?B?UFlWM2NqK3kyL2xuNVFwS2p2V0VqaVFpZ2x4S0tUdHgra01tOWJtbnZ2dGlL?=
 =?utf-8?B?YWNyanRBMy9FUjY1c1I2ZmpTZDNVZXdSdWs5WEZuZ0FZMHdSbHpQcGNWMFpy?=
 =?utf-8?B?Z0FCQ3BsQUg3c2NTOTJveW9VYnc0STR1VklTWmRBV2hMWXYrMDdjTllyL0t0?=
 =?utf-8?B?NXRsRXR0c0ZxLzZVTDcrSHdSV1dmWC8zWk9zVC9tSXR5NURYL0VnYkpDOWFs?=
 =?utf-8?B?eVN2aE1yZ2NtWXFSY09OQ2trMkFyRlBYQ2RNb0MwZmpCYjVabXlwRllsVHRX?=
 =?utf-8?B?bVIzWlVXZ0IzWitQcmRzTmtDSHBSWmV5Umtlcm53RTNDSlRVby9PY0RTNFV2?=
 =?utf-8?B?MXd0Q3l4UHBQQjY4VXVhMGxnNE9ZNjhkSmd4WG1LM0pQV0pWeVIycFdISWY5?=
 =?utf-8?B?M2JOWmRJTEJmQkE1bjhHVWdOUnNCRTVnNytYVEVhTzhhY243bHkrVUV0akgx?=
 =?utf-8?B?S2F0bnZNNGtNOHpOYnlYUFJvNnpwMVhoYU1INnlSVFAveDRaek9ib1MwQ1ox?=
 =?utf-8?B?dWFFWHJ5cnFweFJDK3ZtRXAyV1ZMSGR4NWdRTFREOTlGR3VEK01NeFBtWi9I?=
 =?utf-8?B?MU5iVEdvdWt3K2dyc3d3RnVxcW9yTzNGWEpURzFXdFRadyt6eE9YWGROdUg0?=
 =?utf-8?B?UVJDVXI3dVB4QlhySmZ6am5IZFU5S1hKL1JNcmprWm81MkQ2aEJHNExFYTkw?=
 =?utf-8?B?MUx5WnFOQTZHU1kzYVpFMU9JM01VN0JzWDZrSGJ5QWQyNjQrYjFZRjJiZE5O?=
 =?utf-8?B?SCtlSmVvZVhnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHk5THZHRDRPelBCTFI1eU1JeTRJOEVQRHpCR1dMUkFEbzd3SXM3SDdGWU1i?=
 =?utf-8?B?WG1jYlpKRW42UTNvSHphWFd0cmtTc1dQc3RXTzd2WTU3Z0I3ZitjVWZtenM3?=
 =?utf-8?B?Nlh1Ymo5azlyUVFNa2thODlWSXdCbWxydCtQUUZWbDJqZk9hNG1tQ3ZvSzJ3?=
 =?utf-8?B?VldUazdhL1p2cGVtKzJqbkNIKzV3VFhWMk9QeTZ1OVB2K2dJQngrd0F5S2Yx?=
 =?utf-8?B?OFEraFhQWmVrbEVzRmFjVEY4VUNGVDJxdmFhMTB6aVVYcnI1em82K2dTYTRz?=
 =?utf-8?B?dmtjMXp6dGxWaS90dzFYN0RKZDFCL3ZSSUtBdGFQR3A4ZmVzSXk3TTBkdEF0?=
 =?utf-8?B?cnJCR2NZdjJFWWI0a0o2ZlNaYWlzM3VHRTRZUEZhcCs3SjRYQ1pZTXN3aVYz?=
 =?utf-8?B?emZWck81VmNpblluZ1dtNWd1d0VuaWJObFRIdkErd2RsdU5aNUFSQVFCT1RB?=
 =?utf-8?B?cUVEM2lYMEtadTVBTk5EQiswdG5yQWRrKzdVSlhQT2FrMThVN0lKbkpIR3NS?=
 =?utf-8?B?NjFMeGkzR0U3MWtnZ3pIRHpPRHNCcjcvS0xoUGNmbGEramUyNU9EU0Vzd3h0?=
 =?utf-8?B?ZExLNEhaTmFmSy9IanZ4ZlVyNEVmWk51SW53dUcwd3JWTXFHRW5nMEE3NTZz?=
 =?utf-8?B?YWt3MEVUYVMxTlZOaFA3ZFlIdEpNczZ5ZngxWlh3cmp5WTA4V2JTbVZYb1Mv?=
 =?utf-8?B?WUxUTDJ4cWVOT1NpUk5kRmY3VjNIRUFDTGRMcVlFZVJCSnBZRkZLeldBV3F4?=
 =?utf-8?B?RW50NVdiN1MrNW56NHI2aXhObUFDV3FlMThNRkk0Y2pLNTU1c2hrbmw2ZW1L?=
 =?utf-8?B?K0VvS1dyU094OXRJRW5NdDVQREFWQ0dlM1NRNGJNREhlVVdNNEdyVG9XT2pi?=
 =?utf-8?B?WXl0Qmx3SlhpMkdabEVVNk56QXJtVjAyNjFySldxeWEvNEw0Wk5uNW5RQkdl?=
 =?utf-8?B?NFVnclduRmhGZGMxZUFEZytEOXVuT1RJMm0zZDB1eXJ1anI1dUJ4c0EzSXE5?=
 =?utf-8?B?YWlBQzBiOXFHM0x6d2o4OW5mZ3dISVNDc05YOU9zMWlGL2xkYnIwaUl3dk5x?=
 =?utf-8?B?Wlh1RmdDTWY1bGk0eGRxRkt6STJkaTlHUWUzaHhJUGE5dXI4NE5SWGFNVGEy?=
 =?utf-8?B?VHpWbzZTVHhTcnArY1pGU1VHNjVOSDRNU01WaDIzS0ZaR1JqSnlWN1N5SWsv?=
 =?utf-8?B?MmNBNU5tbjZnK2g1b2dGWHdrSDVnd1lTR044eXoxL2RFcjh0MWdqcUltUnNE?=
 =?utf-8?B?WXFyY015QXJNZkJHQzUyQlVIbVBlNzJibmlxZjg0R2hSVkxtOHFkMDNVdDNa?=
 =?utf-8?B?clVCbkxtcGhNVzNEdGJ5a3Z2UzMwN3Q5eVlGTjh1WE5wamZhOU5lMzVOZkVN?=
 =?utf-8?B?VDJUMktlWmt1TEpZa3hkSnZwNTN5cW1LcFdFaGM4ZE51dm04ZjlWZ3lGWndO?=
 =?utf-8?B?Zmp6Mk5LWEFIcWxzc3R2cG0xQUVSZ21NTWRyMWpUQ0FkQzhaTG9iTll2cTIz?=
 =?utf-8?B?ekpGejZLYTNiZUg5T3lWdlpTdWQzazlLS1RDVHA3anhKUlRwNkdHRG9ES1RR?=
 =?utf-8?B?TEJ6ZzJhOXVWM2FKcDVpUkkwS290VTJRZyszZ2c2NGh5aUlVOUc4M0FoNTh6?=
 =?utf-8?B?UEkxRDQzdHY5TS9tbXZYREVSMitSZUFYRXRmSVM0cGxPVEhhaFJFMFhoTlpO?=
 =?utf-8?B?Q1hQNjl6U3dvQmpSNUdObmxGdTE2WG05S2RXV3VzbU1sNXZmcDFJeDFCMk91?=
 =?utf-8?B?a2tuRkhJVGJmZ0prSGZQeUF3UVEvVmJMYUJGVGlramVnUUsrRGdTakNwR0tv?=
 =?utf-8?B?MVhHTTh0dXU1bnp2djFmeThidUttZ3hOZzlkTmdJaEU3NTZYQnM4UFcyaFhW?=
 =?utf-8?B?VElUSnhJa2NyK210OGxQS1VYZ2NLVEhJRm1qRmI2VWQ0WjZrbUNjOUFPVzlH?=
 =?utf-8?B?WlpQOUZNNFh1SzhXMXBIaG1La1NCOU5hRXJyNGNTd0Y4clhpSVhCWDBITlFh?=
 =?utf-8?B?OGR4K21MM09zOTFwOElxQkhlblZWa1E4MzVOUU9wZTFzN0haZnNCU2JEVmhx?=
 =?utf-8?B?YTI2MlF0VXhYQ0NEUzU0MDdRRzV3bDRyL1R5WHZFVEtBRDlDcUE5aFJuQ09k?=
 =?utf-8?B?U0tzTG5jZWl1dVl1U2QzcWJpQXYwMUlNaHRJZVVyQ2I3WnhWN21zeEdZZ2dw?=
 =?utf-8?Q?x8PwRJ+5b5SvuxF7OT150vo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8734E14303CDB43833A24CA548F5389@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bc1898-ed0d-4917-7e77-08ddbf0e7d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 17:31:50.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1E8w0mgg2SM5NymAOZoUodV6QbPENdmijhC/YumdOrj6f2ARcW+OTyus+HAAHdG0gt+9Le1Id5CH+s3oSzCzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD483AE7A5
X-Proofpoint-ORIG-GUID: Wtwx-FXxLF8hmC91RR7DXR-AD-w41R_l
X-Authority-Analysis: v=2.4 cv=BqedwZX5 c=1 sm=1 tr=0 ts=686ea78c cx=c_pps a=7vtyjtHNWIjm7SETg3ckJg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=edGIuiaXAAAA:8 a=2wE9C4sftMpB3AVZw1EA:9 a=QEXdDO2ut3YA:10 a=4kyDAASA-Eebq_PzFVE6:22
X-Proofpoint-GUID: Wtwx-FXxLF8hmC91RR7DXR-AD-w41R_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE1OCBTYWx0ZWRfXwQj+ucnlnRjD uvODvVMS20i6kn6jU6yHOfARbbewKjg9mfbzQLWjxsJHtlpPAODHG2nLfqVroi9hYx5dEFNol6A kYSoVZC3NTGe8uArOoCTeO/ygVFG6zut+xjWAVxDkSmZYtQMvfpyOGcAo60SW+wqjROtP3tiwf/
 +9x6sP42bFEx56pld9RCTDfngQgYcwiZynAczBQtJHyTaI9cLDBZkr91UFHEdLPcPpiXu7lqhkh kECA2NCRKyq/JQW/XlayxbB9E+E4uJm2brwtzTOZYS886Yp+IhTJ8mmWjaK4+znY9Mf9yhvk7EV GcqFNPwXdsM0Pxtpa/TQ1FQpK/7u3qCNmxPceX2cWUZEFCOeUl6HpMDIPAHpwOC4jVS3el7AM9V
 b7jev7HVRkIYJ+7krF5OL9hcL9TIfMBmvCRGk0fRxmgIdsmBzleH7SMPTl5nKdlORZr6YqK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01

DQoNCj4gT24gSnVsIDksIDIwMjUsIGF0IDk6MDbigK9BTSwgTWlja2HDq2wgU2FsYcO8biA8bWlj
QGRpZ2lrb2QubmV0PiB3cm90ZTpcDQoNClsuLi5dDQoNCj4+IElmIG5lY2Vzc2FyeSwgd2UgaGlk
ZSDigJxyb290IiBpbnNpZGUgQGRhdGEuIFRoaXMgaXMgZ29vZC4gDQo+PiANCj4+PiBAcGF0aCB3
b3VsZCBiZSB1cGRhdGVkIHdpdGggbGF0ZXN0IGFuY2VzdG9yIHBhdGggKGUuZy4gQHJvb3QpLg0K
Pj4gDQo+PiBVcGRhdGUgQHBhdGggdG8gdGhlIGxhc3QgYW5jZXN0b3IgYW5kIGhvbGQgcHJvcGVy
IHJlZmVyZW5jZXMuIA0KPj4gSSBtaXNzZWQgdGhpcyBwYXJ0IGVhcmxpZXIuIFdpdGggdGhpcyBm
ZWF0dXJlLCB2ZnNfd2Fsa19hbmNlc3RvcnMgDQo+PiBzaG91bGQgd29yayB1c2FibGUgd2l0aCBv
cGVuLWNvZGVlZCBicGYgcGF0aCBpdGVyYXRvci4gDQo+PiANCj4+IEkgaGF2ZSBhIHF1ZXN0aW9u
IGFib3V0IHRoaXMgYmVoYXZpb3Igd2l0aCBSQ1Ugd2Fsay4gSUlVQywgUkNVIA0KPj4gd2FsayBk
b2VzIG5vdCBob2xkIHJlZmVyZW5jZSB0byBAYW5jZXN0b3Igd2hlbiBjYWxsaW5nIHdhbGtfY2Io
KS4NCj4gDQo+IEkgdGhpbmsgYSByZWZlcmVuY2UgdG8gdGhlIG1vdW50IHNob3VsZCBiZSBoZWxk
LCBidXQgbm90IG5lY2Vzc2FyaWx5IHRvDQo+IHRoZSBkZW50cnkgaWYgd2UgYXJlIHN0aWxsIGlu
IHRoZSBzYW1lIG1vdW50IGFzIHRoZSBvcmlnaW5hbCBwYXRoLg0KDQpJZiB3ZSB1cGRhdGUgQHBh
dGggYW5kIGRvIHBhdGhfcHV0KCkgYWZ0ZXIgdGhlIHdhbGssIHdlIGhhdmUgdG8gaG9sZCANCnJl
ZmVyZW5jZSB0byBib3RoIHRoZSBtbnQgYW5kIHRoZSBkZW50cnksIG5vPyANCg0KPiANCj4+IElm
IHdhbGtfY2IoKSByZXR1cm5zIGZhbHNlLCBzaGFsbCB2ZnNfd2Fsa19hbmNlc3RvcnMoKSB0aGVu
DQo+PiBncmFiIGEgcmVmZXJlbmNlIG9uIEBhbmNlc3Rvcj8gVGhpcyBmZWVscyBhIGJpdCB3ZWly
ZCB0byBtZS4NCj4gDQo+IElmIHdhbGtfY2IoKSBjaGVja3MgZm9yIGEgcm9vdCwgaXQgd2lsbCBy
ZXR1cm4gZmFsc2Ugd2hlbiB0aGUgcGF0aCB3aWxsDQo+IG1hdGNoLCBhbmQgdGhlIGNhbGxlciB3
b3VsZCBleHBlY3QgdG8gZ2V0IHRoaXMgcm9vdCBwYXRoLCByaWdodD8NCg0KSWYgdGhlIHVzZXIg
d2FudCB0byB3YWxrIHRvIHRoZSBnbG9iYWwgcm9vdCwgd2Fsa19jYigpIG1heSBub3QgDQpyZXR1
cm4gZmFsc2UgYXQgYWxsLCBJSVVDLiB3YWxrX2NiKCkgbWF5IGFsc28gcmV0dXJuIGZhbHNlIG9u
IA0Kb3RoZXIgY29uZGl0aW9ucy4gDQoNCj4gDQo+IEluIGdlbmVyYWwsIGl0J3Mgc2FmZXIgdG8g
YWx3YXlzIGhhdmUgdGhlIHNhbWUgYmVoYXZpb3Igd2hlbiBob2xkaW5nIG9yDQo+IHJlbGVhc2lu
ZyBhIHJlZmVyZW5jZS4gIEkgdGhpbmsgdGhlIGNhbGxlciBzaG91bGQgdGhlbiBhbHdheXMgY2Fs
bA0KPiBwYXRoX3B1dCgpIGFmdGVyIHZmc193YWxrX2FuY2VzdG9ycygpIHdoYXRldmVyIHRoZSBy
ZXR1cm4gY29kZSBpcy4NCj4gDQo+PiBNYXliZSDigJx1cGRhdGluZyBAcGF0aCB0byB0aGUgbGFz
dCBhbmNlc3RvcuKAnSBzaG91bGQgb25seSBhcHBseSB0bw0KPj4gTE9PS1VQX1JDVT09ZmFsc2Ug
Y2FzZT8gDQo+PiANCj4+PiBAZmxhZ3MgY291bGQgY29udGFpbiBMT09LVVBfUkNVIG9yIG5vdCwg
d2hpY2ggZW5hYmxlcyB1cyB0byBoYXZlDQo+Pj4gd2Fsa19jYigpIG5vdC1SQ1UgY29tcGF0aWJs
ZS4NCj4+PiANCj4+PiBXaGVuIHBhc3NpbmcgTE9PS1VQX1JDVSwgaWYgdGhlIGZpcnN0IGNhbGwg
dG8gdmZzX3dhbGtfYW5jZXN0b3JzKCkNCj4+PiBmYWlsZWQgd2l0aCAtRUNISUxELCB0aGUgY2Fs
bGVyIGNhbiByZXN0YXJ0IHRoZSB3YWxrIGJ5IGNhbGxpbmcNCj4+PiB2ZnNfd2Fsa19hbmNlc3Rv
cnMoKSBhZ2FpbiBidXQgd2l0aG91dCBMT09LVVBfUkNVLg0KPj4gDQo+PiANCj4+IEdpdmVuIHdl
IHdhbnQgY2FsbGVycyB0byBoYW5kbGUgLUVDSElMRCBhbmQgY2FsbCB2ZnNfd2Fsa19hbmNlc3Rv
cnMNCj4+IGFnYWluIHdpdGhvdXQgTE9PS1VQX1JDVSwgSSB0aGluayB3ZSBzaG91bGQga2VlcCBA
cGF0aCBub3QgY2hhbmdlZA0KPj4gV2l0aCBMT09LVVBfUkNVPT10cnVlLCBhbmQgb25seSB1cGRh
dGUgaXQgdG8gdGhlIGxhc3QgYW5jZXN0b3IgDQo+PiB3aGVuIExPT0tVUF9SQ1U9PWZhbHNlLg0K
PiANCj4gQXMgTmVpbCBzYWlkLCB3ZSBkb24ndCB3YW50IHRvIGV4cGxpY2l0bHkgcGFzcyBMT09L
VVBfUkNVIGFzIGEgcHVibGljDQo+IGZsYWcuICBJbnN0ZWFkLCB3YWxrX2NiKCkgc2hvdWxkIG5l
dmVyIHNsZWVwIChhbmQgdGhlbiBwb3RlbnRpYWxseSBiZQ0KPiBjYWxsZWQgdW5kZXIgUkNVIGJ5
IHRoZSB2ZnNfd2Fsa19hbmNlc3RvcnMoKSBpbXBsZW1lbnRhdGlvbikuDQoNCkhvdyBzaG91bGQg
dGhlIHVzZXIgaGFuZGxlIC1FQ0hJTEQgd2l0aG91dCBMT09LVVBfUkNVIGZsYWc/IFNheSB0aGUN
CmZvbGxvd2luZyBjb2RlIGluIGxhbmRsb2NrZWQ6DQoNCi8qIFRyeSBSQ1Ugd2FsayBmaXJzdCAq
Lw0KZXJyID0gdmZzX3dhbGtfYW5jZXN0b3JzKHBhdGgsIGxsX2NiLCBkYXRhLCBMT09LVVBfUkNV
KTsNCg0KaWYgKGVyciA9PSAtRUNISUxEKSB7DQoJc3RydWN0IHBhdGggd2Fsa19wYXRoID0gKnBh
dGg7DQoNCgkvKiByZXNldCBhbnkgZGF0YSBjaGFuZ2VkIGJ5IHRoZSB3YWxrICovDQoJcmVzZXRf
ZGF0YShkYXRhKTsNCgkNCgkvKiBub3cgZG8gcmVmLXdhbGsgKi8NCgllcnIgPSB2ZnNfd2Fsa19h
bmNlc3RvcnMoJndhbGtfcGF0aCwgbGxfY2IsIGRhdGEsIDApOw0KfQ0KDQpPciBkbyB5b3UgbWVh
biB2ZnNfd2Fsa19hbmNlc3RvcnMgd2lsbCBuZXZlciByZXR1cm4gLUVDSElMRD8NClRoZW4gd2Ug
bmVlZCB2ZnNfd2Fsa19hbmNlc3RvcnMgdG8gY2FsbCByZXNldF9kYXRhIGxvZ2ljLCByaWdodD8N
Cg0KVGhhbmtzLA0KU29uZw0KDQoNCg==


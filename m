Return-Path: <linux-fsdevel+bounces-51794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B084ADB7E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0F43AA1A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27210288C29;
	Mon, 16 Jun 2025 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RyDYwGdu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3D221D92;
	Mon, 16 Jun 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095747; cv=fail; b=oGwPPvO6druhEbhWyj6AZyORtjbxMb1sknArM8tJ5/DQLBwK0RVATgUo7rgyg0m59/4bqNhN5sSNHSPm8J284k9pGXWliiapIKCIopD7Szt5kvsWXfQg857/aSGuobV0XgAkdSbixYdKzqXnHecATQnbUQlBZQUhWWJJTicFq8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095747; c=relaxed/simple;
	bh=38BVCcmnkuInnW/CZwdffhnLAJV/Ef+I3f4gQuKonsw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=PMsu6YO95JdQIdT9kZW0G9mWIyC1+rgPE0Uv3/lncdwLiIC48u0MXihnLqjTuTx4ttaEvHEjbm0FNI/ej//VOVAPebvxISkdVKKFRl2n27GySjGHVkfKeX8JRN5DdW0q51pG1//OUI1B7Gi97MRYkCVHIOSgDo4Toa54zuSB/uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RyDYwGdu; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GA1tjT020887;
	Mon, 16 Jun 2025 17:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=38BVCcmnkuInnW/CZwdffhnLAJV/Ef+I3f4gQuKonsw=; b=RyDYwGdu
	FmgoZ+txs5DGXo7PmXPmYZTBBfLEmHjpOOfjzHhNsB+bgQ1go2yslMuKmLDAaNC7
	RtabIDfKR+qWZWjwCikGAShGlsyr/Rq60eJWh+t30ftfD+/f+I5Jkfo19g6iQW3r
	MkQn1vmqKWIC05D7G9daLGlUTsg1g0UdTV0Li3mJVgZhMBV4+KqgsKoCuHStcLZ+
	p9BI+heduibwe8zt4fnU2xam05Cm+EFbEEwTzEIQQBrw5pOyD1VYUj3X8rIXbWw+
	cqIAMi93jECm96cBbznNoD0LzpjYFUnqSwgrvCU4eMheFOqQQnn+B9LYUf5O1ZQA
	a9VJFNyZhdswOA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790tduebg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 17:42:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQHrmwmhT51/sUh/rMsgsdqmDmn9fzUYJEUW5k6MmioAVUVmoA4+6O0AChsCvPs7G2/SIqQsNnt1upwJfSnj3z49hXqY1EEXzWX5kSg5wTaUKouieZEBxFe8xIHH2GscxGJJZyZqIjE9W+SZyDOj00cjInjP0SE3QKFq5Hq4HJMIt6+1AXOhsg7bC7gi+EXORc6q9JTGY+SNoktceAtQaR06C9RqUE4yoI9D8lBAqkwN1jQLd1qSSk4EWYUUZbYwP4lYxHhYRV2eof8LCa2tScNZvxcYunBYQYlSC/1tp6X577s9YCkUwNLN/3noJGwiRp+BRlUj3FQy5oGmEB1tsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38BVCcmnkuInnW/CZwdffhnLAJV/Ef+I3f4gQuKonsw=;
 b=mAiBO2GDxP50gZ9JOVnqJJUi+wKGkxophIc77H1bfdqWVtch2A0hmbp++d/Pw8iAZv2ttJly46JBxX/M9nifWSRPgTS2k6zU4FblLVCIgWKX+DK6udQoZIDIXMJBdfEeEGeIxBuf91atEuT80zyQV861qu188OUgCX/wkIGaN4Pi1orR42kYIQ93yg/DX2oUkbVMMm/NcU+Mik/Va8yuMn1FW5N9t2y0+Kk3ADzEkKqQsvyesk2CGYeyN/7apUMbdkP7BcRdAFr/I+j12raTofMs44DY7xLRGOGVgngsyDx/Cqyn552LvCw7WZGEYZokM7luVkBLEf27DEH7pC0ORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF0C99C013A.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e06) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 17:42:22 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 17:42:22 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 1/3] [ceph] parse_longname(): strrchr()
 expects NUL-terminated string
Thread-Index: AQHb3PTK/yyYbNdB2UKS5Tzy82I0NrQGEhyA
Date: Mon, 16 Jun 2025 17:42:22 +0000
Message-ID: <615310d90c121a2c3f475b205b5be786e96d94f8.camel@ibm.com>
References: <20250614062051.GC1880847@ZenIV>
	 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20250614062257.535594-1-viro@zeniv.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF0C99C013A:EE_
x-ms-office365-filtering-correlation-id: 23c6d390-e295-4b12-611b-08ddacfd2638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVkzdmhaeERIa3dLZlRnVHJBZ1cwdEMvaFdKZXdORVVnYkdUV0JibGlweDlX?=
 =?utf-8?B?QzRPd1hpSkxGODdlRE5mSWt1VkRVRE5xYnQvRkhXRlo5Skg4dlB0WXplckFN?=
 =?utf-8?B?Y1IyK3lvTG1UYUJZbFVKY29hNHNKNW14cGFSRlJ2UjVkalBjMEk2OUN6bmVT?=
 =?utf-8?B?bGdxS0RNQUNPTVI5b2JPMHNLdVFKNHo0UjFESitiSmIzZ0d3Ly9UZEc4TDhE?=
 =?utf-8?B?Z2pkT2xjNlU1UW5tSnFQZG5ER0JQeEVjUkN3WmYvOFVCc0xvRFBhNjF2a2h3?=
 =?utf-8?B?M1VmSUZCdTNNR0xJcS9sOU5qODduaUpGUjJldXByY2U0YTFEakVVU29MM0VS?=
 =?utf-8?B?aXEwT3l3UmxyTTgrNU9rOXpxbFdsWVc4VVlEc3hEa0ZMVVVkQXFkZHZ1QlBz?=
 =?utf-8?B?bS9VSHQ4Y2liU0JnQmFXTXhFdFlGcDR6Y3pQd0xoVmV1eFNTNFJpSjQySitk?=
 =?utf-8?B?b2RlWFpaejZoZDMySG8wNnY4THFUSWhrZzBMQitYdEdnN0JJWlpKUWlOWjF5?=
 =?utf-8?B?Wnk2MCtCdUNwaEZPRVVFWUVXUklnMm1uQ3I4MmdnUzJyMmJwdTNDTFpkZUdU?=
 =?utf-8?B?azlYT0xNM1FPZExtWGVBRWRYZk5mSUFxelN1SGptdldvMmRtWVhFZk9ZcU1m?=
 =?utf-8?B?Vk04azZwQ2YzcE9vbGNaMmhFSjJ3TG5xVG1ycDdyTTNRMUFYRW1xUTRxNFV2?=
 =?utf-8?B?cC9aTXBOWi9iSjlpaUlSdE93SjlrSEJMR1NuMjcyMCtrOFhiSUM5Z0JyREx5?=
 =?utf-8?B?aDE1VFEzRVRCc3NFb2U1U2NiZWR3SndlS2x2NXJ4Yi8wUzVZK1c5OXVpN0Z4?=
 =?utf-8?B?Qk56enprRjcxRTN3cExoOWYrSzU2MHpHRkwyTXNDZ3BPVWhUbURoTG1KZjN2?=
 =?utf-8?B?dGV6OGJKQ3BVeXNRMGhmS280NkhrMjhUOTdhWjhhdlFnU2pyS1JkVXJxY1ZO?=
 =?utf-8?B?QmpHMUVycCtVSlZlRVc2Tzljek80UFVZZ1o0TFlORUR0d2NqTWpYVEJxby9D?=
 =?utf-8?B?MkJMQ2hnREU3cWtyVGJJcE5OUjRHUm1RelRpRzBjbmpXSzk2MTMxTDFFNU5B?=
 =?utf-8?B?bG1aM2VyQXNkUjIwQWZtaTNQemJoVlNZQmtyVFdGcUJSc1NWVmtQZnJNQnpn?=
 =?utf-8?B?SFZNZ01qSDdQSHFhUXQ0M1U0TUtVY2UzSXVoUlcwYXlsdENvNEhwZWhHVk5L?=
 =?utf-8?B?WUcyMkxHeHdFRHhDcmhGRFNGUUx2b1lDTGxOY1lmM1BpaXFpTldNUFUvNThF?=
 =?utf-8?B?ejR4WFEyWmszRWlDUUE3Vll3Rm1JME5hU2JmR2ZpTmpwTmg3VnFpMW51Zlkz?=
 =?utf-8?B?a21PVzhVZjlTbDNRT2lVSTYwSEVZWEh6NWFDb2lZM0JoSUMvM2U4RVFNZ2ho?=
 =?utf-8?B?cWthTU1hZzMwaFVaY2hsZG5XZmZ3QlEzbDZOVDRNd09KOGlOUk1sbDArVm1l?=
 =?utf-8?B?UHhRWG9Gbi9nYjZOWW1OVEl6bE5RVXZDejRtbXpPSW5QQUtIeDJGWFluQzdn?=
 =?utf-8?B?NU1uR2pTNE1SN1ZPV1hMMEFCL0NGNUxrNVFVR3p3T2VqclMvQmpDTllQRDhI?=
 =?utf-8?B?TmpQUTdONllYNnN1ZWNVZUprai91QlBQQkhOUzE2K3JxSW9aZHBQQ0FVSGxk?=
 =?utf-8?B?OFc1dVp1eEN6cHZXZVhNcUliOFRLU2pEaG53MnVsd3h2NGozdG1VL2pjbGlL?=
 =?utf-8?B?YzRaNXZCcS9JWnAyclg3Q2xabVZmL2lyS3JvU0x4eWliUzFOLzBITVI0RVZ3?=
 =?utf-8?B?UzRHZ2sxQ0NYcWRzZUEvZy9KTVN3eUliYTVBT3dQR3VDNU1nUWI4MVRqWWkr?=
 =?utf-8?B?dXpJdCtCUjM1ZTZSenUwWkFVZHNiNE1PczBqK3RHV3RMSk4yWHVXemdsMy96?=
 =?utf-8?B?OWxXZUhHNG05MUsvb25TL0VQUjFTMFU0cTU4Nk1Wc1hjektQVkhtWmk3QVhU?=
 =?utf-8?B?dGJoMlh5UTVUQWQ2UktBMlpuOFFDSDNDVkJWVTJFV011eHA2WGxGMjRtMlQy?=
 =?utf-8?B?b0hZS25DUGpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dC9yakpWa0dDL0lySldxeVF4cHlRMXZpalhUbjBvRCtncloxaFJSR240STVi?=
 =?utf-8?B?d2ZCMEM1MVlHczB3Kyt4UHJyaDBndkk0cWtSeHh3SzVGV2ZLZm1ybHdMRSti?=
 =?utf-8?B?eW11SDM4dW9jdnV1WDlsZHIwbEloVkNVS3JEcTlLZ0FnYWV3SFNVaW5rMDhj?=
 =?utf-8?B?YUZDMzVURXE1Sktub0RLMUlXSFJUT1pOOFhxQjdlY1ZvSmQwNmd0c1NTY29a?=
 =?utf-8?B?VVdGTmhDaXA4T1hMYzhwbnBOQWQ3eTNCdjZ5ZU41WVFPdlM5NzhobUpVSC9N?=
 =?utf-8?B?VkxaRnljVjVqRmxOTG8rWlIyWkV6cklJdzloaUZIWCtMVHlscUNFVzRuNFJm?=
 =?utf-8?B?VFFmNm5jUG5xWkRhaW1hcTV5NVR5MGxnN1NOOVpTMllvbVJPdkZhZXNzY3RP?=
 =?utf-8?B?Q1oxc0pUb1B5Q1lNRGozQVlnbkJKdHdUd2dCTC9MVHd4N0tYU2ZWMFBHRGdi?=
 =?utf-8?B?amtvWXRrTWxnWURESC9VQUhLcG1CVFNuQVFKM0ozZXRTNlVmK25BSnpWTlg1?=
 =?utf-8?B?T0xjcjRhV2pMYXdiZFR5Mk42b1kxYllROEZTUTN5MDNDc1F1cjlJMFdibUdH?=
 =?utf-8?B?R2o0ZW9iTklzTkZkc0pRYnBiSUNrV1BFRG4wSWxqNWV6WCtIL2hHemFEOU83?=
 =?utf-8?B?UVZ5dzBBSnlBa3JrNDlGZktKcHAwU1BVMnp5S1R2V1lTeks1VDlwOFBMNkRE?=
 =?utf-8?B?MVNTSVFpenJDS2ZucUNPTmJHNlBaMXo5ei9OTFpOQ3ROZnVUNGZLZmUzTHlh?=
 =?utf-8?B?NVc1YlVyOGF5c055ZzVGQnNoQ3FSa1B6Zm1kVUNpQ1FsRXIyQ294dGoxV3lC?=
 =?utf-8?B?L3R4YnBiU2dSQjkydThYb3JsZW8zN0RKOWhVaG0zT3l4NjFNNG5KRGxtb2Fr?=
 =?utf-8?B?NXdHUDlPQ2I0NVlvV0FMWFJMeVl3c2tHQVhPdkd2Sks5REEzMmtYeFJHQWpJ?=
 =?utf-8?B?ZXM0a0o5WmtDOHlzd2ozVHp0VEtqU1Z6SFRyWTBvVWxGUXhCem5wWDJQb1lt?=
 =?utf-8?B?WmZQNWt1RzhmMis2ZUZVQXBJeUh2R1dlT243bjAyVW04MXJlK1pQMjNzSGFz?=
 =?utf-8?B?RGFyakpXODkzakt5NEVMcndzYmh5QmpSWXppSksralVVQ0lqNlJhbjQzTk9i?=
 =?utf-8?B?Q2lWRjlNMkYxM3owZGNyUlVxeSs3b3B5SnJIQ1QyazdQSmpkbmE5Qk1GRTQr?=
 =?utf-8?B?QldCLzYrSnB4QUdncEo3VkdkR1FLeXArcDBRaFdMYlFrSm0xOElaUkJpSHgr?=
 =?utf-8?B?eG9XZmZ0UCsrR20zY09VRjRwWjAySHNsWWxzakJrVVBOTm1kQ2d2Vk1mNEpJ?=
 =?utf-8?B?Q0ZFazdnOFA1SGJ6WFVKbGtkYkVLZ2Y5WGkrNEc1Zkoyd3lpWXh6S20vbzhm?=
 =?utf-8?B?MWJSTnFOMERCTXZxTmhJaXYyUWFEd3E0cFdFVjNUUnJFd1Nyb1FNajZFc1Bl?=
 =?utf-8?B?NkVnaCtyWkdoQWFSc1hVUWJqTGxiL0pwcC9Rak0yTEVwc3R2UjA0UG55ZmM1?=
 =?utf-8?B?NFJUb0crbUdhTFR5QVpXWGdPMmZyV0lFWDc4dWxnLzdQUGxBdWd6MDNnZ0ZB?=
 =?utf-8?B?M0lyWXZ3OEt5YmsyZmY5d2RpZElvSEdBeTFVVm5MZjdnNkdKUWk2SEtuOTJN?=
 =?utf-8?B?cWM2MUVQdW8vRnpNRUN0eERTMHdaK0JvbXlWbHFUb3hOakk5OVhqTjExNURU?=
 =?utf-8?B?ZFJEeStOTmdRcURaR2ZpRU13WnNOWFZNbHovY0tna1BUS21UZSs5OGRsMU5S?=
 =?utf-8?B?UDdRSjgxQzlVY0dBcG5va09mYkpqa1laRFY0VHFpcXk4ZGlOZ29oa1RDM3R0?=
 =?utf-8?B?V3VOUkNkTTVFNW5SWlp1UnpVSUNwajA3R2NWamR0MmtYMDZtbWNHQ3hpQnZJ?=
 =?utf-8?B?ZVRzVSthanlYbytjM1JTeVNJVnQyTE1ObkMzeFJIQkVsRkZVRUVpTEFxb2J6?=
 =?utf-8?B?ZmhSM2hSY3FJSFhENzAybk9KM3c4WVF3OFYvQit2ZWs4ZVdJRmtGRjZ4eDZi?=
 =?utf-8?B?U3VTdWtvOTlJVW1iRXcrdmVPOGpPSUtYMFJFMmJMejlucFdUSitxbjI5SWxO?=
 =?utf-8?B?WmxIRGtMVWQ4VTlUMW12cjVSQTh0WEtoWUJNSWtmbVlFZC92UjNWNjc4ZWpp?=
 =?utf-8?B?N3FNY0RObnRJMXZoa0Z0SlBiL0UzSTlzcWhQL0xobW9IZVFxOWNZWkhVTXVv?=
 =?utf-8?Q?Tp/X/vCG7NRNZxh9buuNbHo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DBD770F92568E4CA4F61271C346ECE3@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c6d390-e295-4b12-611b-08ddacfd2638
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 17:42:22.4229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9Ahxx4DJfZgrMlpNBeRRsNsGio3djukqPDFyWOBlV/ONw+6O320jKf0/JdpHu5qcINYgejVfYUKIPyECCL28g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF0C99C013A
X-Proofpoint-ORIG-GUID: PiuRhoQhUuiEYei14vbSvdnvEv7ozbGA
X-Proofpoint-GUID: PiuRhoQhUuiEYei14vbSvdnvEv7ozbGA
X-Authority-Analysis: v=2.4 cv=c92rQQ9l c=1 sm=1 tr=0 ts=68505781 cx=c_pps a=L9yf2vioRF/+oJH3m7olGQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=drOt6m5kAAAA:8 a=VnNF1IyMAAAA:8 a=CHUNlfOHq9e8nngb4K0A:9 a=QEXdDO2ut3YA:10 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDExNSBTYWx0ZWRfX0g0vj1u947aK m4S5y5y2Ana55D0zKLSoFtaZxEXZpKo3k+JHaHVTgK1NRi40R+PIZQfdtOZsgNEHJshJxoJ9kbW sGpZ8V5oEkqr0Wy68aCnzy6a/V4XxRlbd4ASGa4sZfQ6jIVvdiaDzihVzqHhayxLeMgIGvyQLpk
 gvVU9G+VRzmwXKOG6Ewj5wfl3ks3vyd3NfuekrhAUrJnjoi+fyp8xGUFKTg4Iqz2pZJqWqFFRdb 1QQLadoLqAhieIiyZq9R78dp8GAz8Ob4UAP9JPIcUuT29cO36hq81o3efR/fbYO4Z70GMBVn/uo /2vh4GCX0gtgfMbj4rBLhiH5aHVlRMfu94oIlX+9sK3DLxsOJRadUEwnYsgGBjy/Jv1thUAiqIo
 3HxDwEXNLNXvp9mypwKFRbgOemkm6sHa2G15hUuKTkOcTsA03zJ+IzV9JoKZZh8jIG0EVoBR
Subject: Re:  [PATCH 1/3] [ceph] parse_longname(): strrchr() expects NUL-terminated
 string
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160115

T24gU2F0LCAyMDI1LTA2LTE0IGF0IDA3OjIyICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiAuLi4g
YW5kIHBhcnNlX2xvbmduYW1lKCkgaXMgbm90IGd1YXJhbnRlZWQgdGhhdC4gIFRoYXQncyB0aGUg
cmVhc29uDQo+IHdoeSBpdCB1c2VzIGttZW1kdXBfbnVsKCkgdG8gYnVpbGQgdGhlIGFyZ3VtZW50
IGZvciBrc3RydG91NjQoKTsNCj4gdGhlIHByb2JsZW0gaXMsIGtzdHJ0b3U2NCgpIGlzIG5vdCB0
aGUgb25seSB0aGluZyB0aGF0IG5lZWQgaXQuDQo+IA0KPiBKdXN0IGdldCBhIE5VTC10ZXJtaW5h
dGVkIGNvcHkgb2YgdGhlIGVudGlyZSB0aGluZyBhbmQgYmUgZG9uZQ0KPiB3aXRoIHRoYXQuLi4N
Cj4gDQo+IEZpeGVzOiBkZDY2ZGYwMDUzZWYgImNlcGg6IGFkZCBzdXBwb3J0IGZvciBlbmNyeXB0
ZWQgc25hcHNob3QgbmFtZXMiDQo+IFNpZ25lZC1vZmYtYnk6IEFsIFZpcm8gPHZpcm9AemVuaXYu
bGludXgub3JnLnVrPg0KPiAtLS0NCg0KVGhlIHBhdGNoIHNldCBsb29rcyB3ZWxsIGFuZCByZWFz
b25hYmxlLiBMZXQgbWUgc3BlbmQgc29tZSB0aW1lIGZvciB0ZXN0aW5nIGl0Lg0KSSdsbCBiZSBi
YWNrIEFTQVAuDQoNClRoYW5rcywNClNsYXZhLg0KDQo+ICBmcy9jZXBoL2NyeXB0by5jIHwgMzEg
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgv
Y3J5cHRvLmMgYi9mcy9jZXBoL2NyeXB0by5jDQo+IGluZGV4IDNiM2M0ZDhkNDAxZS4uOWM3MDYy
MjQ1ODgwIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2NyeXB0by5jDQo+ICsrKyBiL2ZzL2NlcGgv
Y3J5cHRvLmMNCj4gQEAgLTIxNSwzNSArMjE1LDMxIEBAIHN0YXRpYyBzdHJ1Y3QgaW5vZGUgKnBh
cnNlX2xvbmduYW1lKGNvbnN0IHN0cnVjdCBpbm9kZSAqcGFyZW50LA0KPiAgCXN0cnVjdCBjZXBo
X2NsaWVudCAqY2wgPSBjZXBoX2lub2RlX3RvX2NsaWVudChwYXJlbnQpOw0KPiAgCXN0cnVjdCBp
bm9kZSAqZGlyID0gTlVMTDsNCj4gIAlzdHJ1Y3QgY2VwaF92aW5vIHZpbm8gPSB7IC5zbmFwID0g
Q0VQSF9OT1NOQVAgfTsNCj4gLQljaGFyICppbm9kZV9udW1iZXI7DQo+IC0JY2hhciAqbmFtZV9l
bmQ7DQo+IC0JaW50IG9yaWdfbGVuID0gKm5hbWVfbGVuOw0KPiArCWNoYXIgKm5hbWVfZW5kLCAq
aW5vZGVfbnVtYmVyOw0KPiAgCWludCByZXQgPSAtRUlPOw0KPiAtDQo+ICsJLyogTlVMLXRlcm1p
bmF0ZSAqLw0KPiArCWNoYXIgKnN0ciBfX2ZyZWUoa2ZyZWUpID0ga21lbWR1cF9udWwobmFtZSwg
Km5hbWVfbGVuLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIXN0cikNCj4gKwkJcmV0dXJuIEVSUl9Q
VFIoLUVOT01FTSk7DQo+ICAJLyogU2tpcCBpbml0aWFsICdfJyAqLw0KPiAtCW5hbWUrKzsNCj4g
LQluYW1lX2VuZCA9IHN0cnJjaHIobmFtZSwgJ18nKTsNCj4gKwlzdHIrKzsNCj4gKwluYW1lX2Vu
ZCA9IHN0cnJjaHIoc3RyLCAnXycpOw0KPiAgCWlmICghbmFtZV9lbmQpIHsNCj4gLQkJZG91dGMo
Y2wsICJmYWlsZWQgdG8gcGFyc2UgbG9uZyBzbmFwc2hvdCBuYW1lOiAlc1xuIiwgbmFtZSk7DQo+
ICsJCWRvdXRjKGNsLCAiZmFpbGVkIHRvIHBhcnNlIGxvbmcgc25hcHNob3QgbmFtZTogJXNcbiIs
IHN0cik7DQo+ICAJCXJldHVybiBFUlJfUFRSKC1FSU8pOw0KPiAgCX0NCj4gLQkqbmFtZV9sZW4g
PSAobmFtZV9lbmQgLSBuYW1lKTsNCj4gKwkqbmFtZV9sZW4gPSAobmFtZV9lbmQgLSBzdHIpOw0K
PiAgCWlmICgqbmFtZV9sZW4gPD0gMCkgew0KPiAgCQlwcl9lcnJfY2xpZW50KGNsLCAiZmFpbGVk
IHRvIHBhcnNlIGxvbmcgc25hcHNob3QgbmFtZVxuIik7DQo+ICAJCXJldHVybiBFUlJfUFRSKC1F
SU8pOw0KPiAgCX0NCj4gIA0KPiAgCS8qIEdldCB0aGUgaW5vZGUgbnVtYmVyICovDQo+IC0JaW5v
ZGVfbnVtYmVyID0ga21lbWR1cF9udWwobmFtZV9lbmQgKyAxLA0KPiAtCQkJCSAgIG9yaWdfbGVu
IC0gKm5hbWVfbGVuIC0gMiwNCj4gLQkJCQkgICBHRlBfS0VSTkVMKTsNCj4gLQlpZiAoIWlub2Rl
X251bWJlcikNCj4gLQkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ICsJaW5vZGVfbnVtYmVy
ID0gbmFtZV9lbmQgKyAxOw0KPiAgCXJldCA9IGtzdHJ0b3U2NChpbm9kZV9udW1iZXIsIDEwLCAm
dmluby5pbm8pOw0KPiAgCWlmIChyZXQpIHsNCj4gLQkJZG91dGMoY2wsICJmYWlsZWQgdG8gcGFy
c2UgaW5vZGUgbnVtYmVyOiAlc1xuIiwgbmFtZSk7DQo+IC0JCWRpciA9IEVSUl9QVFIocmV0KTsN
Cj4gLQkJZ290byBvdXQ7DQo+ICsJCWRvdXRjKGNsLCAiZmFpbGVkIHRvIHBhcnNlIGlub2RlIG51
bWJlcjogJXNcbiIsIHN0cik7DQo+ICsJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+ICAJfQ0KPiAg
DQo+ICAJLyogQW5kIGZpbmFsbHkgdGhlIGlub2RlICovDQo+IEBAIC0yNTQsOSArMjUwLDYgQEAg
c3RhdGljIHN0cnVjdCBpbm9kZSAqcGFyc2VfbG9uZ25hbWUoY29uc3Qgc3RydWN0IGlub2RlICpw
YXJlbnQsDQo+ICAJCWlmIChJU19FUlIoZGlyKSkNCj4gIAkJCWRvdXRjKGNsLCAiY2FuJ3QgZmlu
ZCBpbm9kZSAlcyAoJXMpXG4iLCBpbm9kZV9udW1iZXIsIG5hbWUpOw0KPiAgCX0NCj4gLQ0KPiAt
b3V0Og0KPiAtCWtmcmVlKGlub2RlX251bWJlcik7DQo+ICAJcmV0dXJuIGRpcjsNCj4gIH0NCj4g
IA0KDQotLSANClZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0K


Return-Path: <linux-fsdevel+bounces-74745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPmLGjYHcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:52:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC0A4D4C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 23:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B76E594C082
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995D03E9588;
	Tue, 20 Jan 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7lK6/sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCA1A08DB
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948194; cv=fail; b=ZaFaUhpiU00FfXYdPsMTqbAL2Y+oqOUF5eyXEfqJXVPxMyrATBC7oYdyEzgJF86XlAQksLCwN/2hStnd15HsAJVYXocdpYfanDy1WEZP9SaVkrHnADSLu+ryv7w2dzrCxyF/ezRrBVTXmHihQFtTu86xz/ZQ0p6kg5kCGCgzPwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948194; c=relaxed/simple;
	bh=a8A256nBojiEr3+MEIj9i1UleMZLgB1VgzGQl+4wSTc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=T+gg/pk4a8L/h6zUfFEsLINM/I3pnIarp7CIOWLpiaLQfF5yKgOkeSo7jBXFpXA7fuZ3q2vuL7xoeQREpJS0gA2i/qs8RJSLNLClwtK3vI3dzbBwappg0XhHPMUKZ0l5/chf73ERnV5iWRLYy7K0afPIhE6ZDuIUsUESzu2+IV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l7lK6/sy; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KEldsQ010093
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=s8d+ZPFS6TO/zy3XbD1QvfOxzSWam801ANXhRwCljBs=; b=l7lK6/sy
	oBGeEIRa79+ZyzUBhbSLfTXJzbDoUo/M/EXu7D85gdMpq+gvExNEHHRdGKqCmWcL
	I0aZRpN92fZugf0kV3CSAw1TWYi5X1Hnrr+SxlM74hmnUO2bWW07RQQNLPK99fj9
	VX1QsHS7kEtuZhi6VxfXlRUf2LGm6U2qjd3dvYjYTsDRsULQ70/hHDdDHvB7sncR
	2Ao+mqPnXurb6uGl+2WU0OQUZE5q1+V5ezjJ9LIoPwnqLEfEpj5JpG1gU9hSqsFA
	HkznuW888T34SSlWo0TU3+QVUgPIp3PUCvWathSNcATkNryPIXyqyk7IBWEW2XpV
	wIF8JsiNHtqmEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk843m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:29:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KMTmet020863
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:29:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk843f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 22:29:48 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KMQuNn015244;
	Tue, 20 Jan 2026 22:29:48 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk843a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 22:29:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFGbX5jsRKSn8MzPtS+uXDZzzkGa1QfYQisSSXez4/clEcl8pHNAmftkbMwKN1oFSD1FWshsf06tbCShqHp3GG954Kg/9mTkePmhzorERjdR2KCY+fCFrDdTFFUqRFXoHhxHr5aJNYb1IZCiDG4RgMY8pOxrwuTfXDMdMBdhXMqHdVLVmmUmqBPMaW2DYqWnrfxXYZBZd865zpV3ale/Rx5cD+OD7/l2SaEeMn6feEYxPhU+UnetXQeqxxlPhuRp9pxVfug8yy1Lyvkv7OSo7cKgvyzHx2d2iHrnrqew1FXNAGWQhHaQe1TEqPu6+JfCxpnLnA/MWeuq9P/H4NseUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40APaGVCVgTKSbRXtb3BKfq2ZG12sgowEkoPGMYUJbI=;
 b=CBfA9F/bz2qQACgsSniudUAO3Gucg7kBu6E2hOYD7pkiZH6a57HdRYYsnCLLLassiJodKsjDVNTU8sZFNnvDdMymRr/xzzlN4BB4nMnH4SmKM4qR9ekd7zuKPaZ3DIZrOEY8khLsQEqPQG48g4VAKyFYMOsRIIZcA0q3BlLnMW35YvLtvufAf+ffW3JNLrgahbOIoatQhno8gkpwEzD3cau858E+Pvt6B3O5a7BHgpVkJbbFTd6p2bScOU8TdUTGIqPx4qg1LXrukn9DFo2ezbsVTRCP20xtGCNaypCR7LkmIuSJFKsM99J8IJCjYoOMBx2763UBrDJA1ufsRGRQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA5PR15MB6868.namprd15.prod.outlook.com (2603:10b6:806:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 22:29:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 22:29:45 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH] hfsplus: fix uninit-value in
 hfsplus_strcasecmp
Thread-Index: AQHcictB8pA0z9wh1keyLHmjtlMLF7VbpPeA
Date: Tue, 20 Jan 2026 22:29:45 +0000
Message-ID: <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com>
References: <20260120051114.1281285-1-kartikey406@gmail.com>
In-Reply-To: <20260120051114.1281285-1-kartikey406@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA5PR15MB6868:EE_
x-ms-office365-filtering-correlation-id: b0f1fbc1-918f-4064-10ea-08de58736a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDVPbFdiR2hxSVllRnVXSDk5Q0dIRlRLRVY4S01rakVSZW1wVndGTC9NcHlk?=
 =?utf-8?B?Z0FqVExrYWpTbmJodmoxV2hsZTM5RUhXTkVIanZrd3ZNZFE1N0l2NjNiR3Fi?=
 =?utf-8?B?UEtqTXJwRmNqY0tSYTJyQWc0Zi8wMGVaQjI4NWhlTHNoRnJFUEtTYXFUREhS?=
 =?utf-8?B?ZHlBaEpTUmdleTF4Zm0vWG9IZ0xwd1hybjlaekYvU25CL05aUFVaTmVCaktR?=
 =?utf-8?B?T2lSb3dub3lpNUpXeDZxYm5NUStyYzkzL2dXMmMyUnY0UlRkRVJtZDdaS0dI?=
 =?utf-8?B?SVRoQTM1QkluaGQxd2VGWGpFQnd5VnF5aHVWMmNVRFJETnhmRmdvdnhObWJ4?=
 =?utf-8?B?bk9RY3VMZGhleUpPeXhZYVBhUzFvalAwbGhMZURuMHoyWDllWVlTMGEwR0g3?=
 =?utf-8?B?Nzh5ZGdqNVZRcTMwZEwzeTJiT2dLTUtaNFFJZ05FZDNGS0VVNjJMNlR2cWJO?=
 =?utf-8?B?UFMxVUIxWk9PN2ZIN2FWZzNtODJLUGpWbjJRcVVkQjhDd2Fqay9qRitvNE1r?=
 =?utf-8?B?UmFWYUFCOXpSWTVyY1NzK1dSajBoaXVlM3Q4b3JCb0NBYThWVkhDRmdSY05Z?=
 =?utf-8?B?YmdQYzJlZ0J2aTBVYjlUa29MRFo5UVhWcVNCbjJXWmhNbGdEN29WWjZOdExo?=
 =?utf-8?B?eWZXOXJpLzRhcWt3USt6bmlGWTNzWFdyb0JXU2VEREY3VXVCYndBd1JjdkVQ?=
 =?utf-8?B?VW1MTU5tdEZydmNHTFA1eHdNTmhQVlorSWFYM3NCSitkUXprQTZMZ1Y5Z29H?=
 =?utf-8?B?MWhyMkhkVHd5NG1ibmpFdk9wWjZDNldKYWxFRWtBTXJ0K1VxUDVSLzgrZE5H?=
 =?utf-8?B?dmJyVXB4UTlFbllvWnd1VGtySVNid1BqR01CS0s1L0ttYm44ZDZYQzErYloy?=
 =?utf-8?B?NkxSdkw3RmQ3Z3BReDdOeDhMLysvRnVFc084RmJqWERURGFzVVBCNlZtNE9l?=
 =?utf-8?B?UE1MRkEwV0s4WkVZdUhoY0xoZmJJK3Nkc0JTL2VwV2dRaGlYOU42ZXFuVXRF?=
 =?utf-8?B?eW1VY1NHMzVlVS9hcy9vTHNQSXloay8wdCtkaUxBUis1c3cwMTZoSEY4MGRJ?=
 =?utf-8?B?L0NpbXNMY2xyUzYyTWY5QWtrRVMwTFgraVlFMzFoa3ZnVFdpN3ZrRnZ5OG03?=
 =?utf-8?B?RVltbGZTQVdqUFcwR3EyZTYvc1l6N3VpMUFlM0JaNGxYQU1YK0lQQjdnejRW?=
 =?utf-8?B?THhEUkh1MXJFK3F2K3pKZGkxb0NHVy9nNC9rakxoWHIyd3lYR29YWEpLT2Jr?=
 =?utf-8?B?YlpwYU0vS3NUVWlGQVZkckowTzBzakd5Wk53V2ovTEJ2OCtwUHc4RXJtV1NW?=
 =?utf-8?B?d1B5M3ZZS2lZMWxPWUJmaHFLcTVRcTgrYnVKMGsyZ3RWSnZOVndqRDlWaTZi?=
 =?utf-8?B?Zk5OVGJCZGt2emxrUDY1MUljT2VLMWZCREdTTjhMSTJJSHRTaXh1VTkvNUg3?=
 =?utf-8?B?U2FKZTRKcnE0c2dGcHEvWjUvdWU4RlZkcWtKZjAzVS81RFV6dkdUbHg0bXAv?=
 =?utf-8?B?MGV0SDdsRTZlQXVhaXA3ZCtYZGlCak1lVTMvbnJBSmdJa1RyTU1sUXVrYWlG?=
 =?utf-8?B?aURhSHEvQ1g3b2JnMEd2RTc0WjcxNXppdVdoZDhYN2RXTjNVSU0wSDBBOUtw?=
 =?utf-8?B?TkZkRGxOTTUzWThQOHFqb3NTdUNHaVgxS1NpVnpBa3BvcTBtb0krOEJucGV3?=
 =?utf-8?B?bUl5UzJDbExCZXRZU2NOTWNWQk1RS3U4RWdUbnV1QnZEMDdNbjhRM1M5Q3RC?=
 =?utf-8?B?QVBwNml0T00zY3FEeHBKWEo0L0IxK2dhQUgyTU1hWUVLaGgzaUxVT1lyWm1U?=
 =?utf-8?B?TkcxR0ovbHdGcTVuVHV6UTZ6WXM5NE9XbWo5bVptRzUzN0dkdEhyd0xiN0xw?=
 =?utf-8?B?NE1GOGo1eWpyZ2krSm9MOTVPTUY3VTNTQll6Q2NIRUpnYWFZbnd6RUxWT01w?=
 =?utf-8?B?M09VSHlmd1RZSmhTcUs4WVlhcC9XclBoWHp2S2JhamdnaVhFZGtYbUsrZGcr?=
 =?utf-8?B?Q2FySGxCUzJwTnlDT3hmcDB0dHcvYU9hSi9XYXZpalE5VklvLzFEL004OStW?=
 =?utf-8?B?STdsek9MK1djaUpsV1VVQ0RqNC9NSUFoSXJDSk9jRDZ5K2NyOFBJSytJMnA1?=
 =?utf-8?Q?Ej0MCBonX1Ih2vKKl0qOEla1G?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlIyNkFEL0l4d1MrU1lERHcvakdaSC9DZGxOZ3JRRE4zbzJsQWN6NU80QW9V?=
 =?utf-8?B?cHg5ZWVjQVZ3MUpLTm1ZcUFMc3dncFZlM1R1eGcwZlhQbytYM25TenR0VnpH?=
 =?utf-8?B?WnJiSnFBZkMzQmI2d1dka1BnUlV2Y0FWZWl4K25KeHh0TFFvYllRTHk5amNx?=
 =?utf-8?B?MnNaMHFPN1AxNytVeUZHN1ozbkdtS2ozMFlKcGg5VnNnL0RsKzJ5Ty9tYkdY?=
 =?utf-8?B?R3lwS3A5N3dpd29kbEV5RHJLK3hLYWxRWW1VUkE4MHVtVWxvcVpKOFd5U3la?=
 =?utf-8?B?VTBaaW1kTHB4R0xWM0J6VDlrTGRzbWtia3czeEVZTmJhMFFyQVRjelRvU3lY?=
 =?utf-8?B?aEZ6cW5UU2dLb2NiNktPb085WW9IaXZXalRxTFBJUXNha0IvcmtkT0JSTjlu?=
 =?utf-8?B?bTUvYmFBMmlrWjh5ZnR4eTdBR3drL1ZWU21kK3c5bWVrbWgxd1U4U1pkcGdi?=
 =?utf-8?B?bm91Z3AybWZLL3pNNlc5R2lnTlpyUm4vUUREcXRxQ1Q4Q0ZMU1ZhMklOL09W?=
 =?utf-8?B?eVFMeWZqWlNaNm51WG1GaUVpdUo0NGVSU0QvdnVQRlFaVWVmMjR2OUVyaUxp?=
 =?utf-8?B?TlQyTncwQnByN2YxYXhRMXhya3d4TGFsbEVPaW51OSt2OFhpMnpTTG5pY2hX?=
 =?utf-8?B?N3JOcGxMWUs4MklvVG9pWkZMTzVrQXdRYnZmdTFVUS8zOGUrSmRSM3ZrRGc1?=
 =?utf-8?B?RXFmL3pPd2tCa3pURkR3eXV1Q3AxY2gyejU2SHpiNzZLS1hQa3BlZWNnd0xx?=
 =?utf-8?B?dGRTSHM4UVNNSHB5TnJreGVQRUFTZTRnOG5tTVBNbHFleEwzQWR2STJVdUZn?=
 =?utf-8?B?WHphb3MwMTBrdEt3WWFVaGgvYUpUcnd5YnZOVXlGalc2YXVIU1BXR3JmWU9i?=
 =?utf-8?B?RC9LSDJWUk1wM1ljWlFyc0lFVS9IdXZZeHIzUzBFbHFMZGxqa3ozeU5hN28w?=
 =?utf-8?B?aFlUS1VUSnRMOTBscmIvNEVCdGFoOE5xdmV1SEFZK0FRSE8wSWJnZk9DOXVT?=
 =?utf-8?B?WTBHdnBkR3FSUEpRUVcrMUNueElRWlFIT2U0RjFGRDdKUk5XZEx0RTdHeTd0?=
 =?utf-8?B?VXlaeXBQYVdxZG1kU3VUallRVGNzRi8wZElmWVdSd1JHSTZIUEJOdlBYK3hJ?=
 =?utf-8?B?ZUZ6SjJTL2VzZ0FwdTlnaU1iMnZXVlpxdndsVHJLUWludnZaRDJ2Y1ZSTnFq?=
 =?utf-8?B?U3VJMVFpNlREYlh0R2pxN1BXaFFHNkNKSmVQUldPVitPclJvMm14Y3FiMXAw?=
 =?utf-8?B?Z29MMHJLYVQyTDI1ZVc4dDhqREU5VjRrQlZTUGRFMlFnWDcrUE9QS1gvR0Ru?=
 =?utf-8?B?OHduRm1GNnliRytKL0FrR3R4RmNnVzkwSEdxbk4wYUVqWE5ZTTNWSXNMY09w?=
 =?utf-8?B?OFhTRTdGRzVEajhRaVZ0K2psd0xyZm1jZUpjd25raEkvSitLWlFyWWlITVJW?=
 =?utf-8?B?aVVhYjZZNUpKTk5nTjVOcE9LTHBHc2cxeVN2b3FDU0s1LzMzSkhNVHAzYkJq?=
 =?utf-8?B?c2xqZDYyR2NkL080dGJmVXFlclFSS05nZVJBU2tsSk5DWXFMalljUVMvYWl4?=
 =?utf-8?B?MHhVZi9nbkJkNVZwdFVuMG9CcHBOQ2toakh3TEhmNjlGbW13UHZVMG1sMGVk?=
 =?utf-8?B?Mml6YkhVWXBLOUNVNDBXd09wZnhnNXdUbVVPcGFpR1hpa04xeElYN3RSSW9K?=
 =?utf-8?B?WlBST0p0aG1iT1UxOFFxWm54Tm5HWmJNa0dEWDgybTVPZStmZmJzS0E4ZjZv?=
 =?utf-8?B?WEdZZmdybHZ4NFptdHRsSGZIZXpuak1NUkpXcTVCZUJCZS83QW11aVVMN3Rp?=
 =?utf-8?B?cEUrNTNEelJWRVNtbFJDR0U5eE1NY093QmVBa2Z5N3dEM2RpQUl2RE5GRjZl?=
 =?utf-8?B?aEFUSXNSU3MzZExVdGFLenFoTlBIcjdYTTJaY1hVZ2FBSmJ1L3BCQjgyVmw4?=
 =?utf-8?B?Tm1nVTAwdDlxWjVBRGpPN2cyakJVKzBnNXErNFdJV01Bd29pMnh2OWIyaWlC?=
 =?utf-8?B?K2JPRERNUjVzRDlIZHJWR2hzWGRTZE1rc2swMDJDTmcxa0NxL0hTamViK2h4?=
 =?utf-8?B?cDErVDY3NTBOY2ppZXdTbyttV3RLemprY0JPejJqQm55NEVWenhKbW9ubkxT?=
 =?utf-8?B?REdwek1WS1ZheVJtU1RTd2NFNTFxbWM3dXZGQVA2QkMxYXhnekljeUxmZ3Jl?=
 =?utf-8?B?SnZyb05nL3ptT0tqS0RLQ0NLU2dzenpRaTdqZGRoZWRzYkpoQmJ2cENOWE53?=
 =?utf-8?B?aVlSTjFqalE2SHU3TWp3S2JUOE5hUXNzaVdIWmVabnRkRm51Q240bThqYUsw?=
 =?utf-8?B?cXhPSllCSFgreTZXR21xV3ZrbVNBMkJCNTNSNG5Cb3RmR3dCWTVEbHcvc0JE?=
 =?utf-8?Q?w7TIgH5h2Kv/Afgj3MISdmmO+5tl1wWA2luwe?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f1fbc1-918f-4064-10ea-08de58736a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 22:29:45.9061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mcxocLHz8RFDG4x0QpMxjlZk1pfgPpCX/STdbEyCEjo1G6yE125NrGki/tcLSkUIa9GfdmpzKaiAlpKoHQ4zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR15MB6868
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE4NSBTYWx0ZWRfX1/vfo76r47/m
 svGZzrGWBrLbsr1W0LQhxxO+ncyFtuY9fYHyEmBs8Nw3OAqP6EOMmYqU5XPpeO7me8JWAE60ZVG
 A+wpNNEnP1BIBhrPdCnHTEW5WqFO3OXV79zEeIH6Z1Ro9cUMjJnyk3sm6O3O+msPNAiqrChE+Dm
 M7xMeAt1TuhwqgcdO7E3TtOY3jwJJ+YmNsy149sy+M4DVwgHE4WUKFcHvVvuxCu35UgonzbIBET
 6QmNnHtztEZrMCJeDwLhN30eF30ZqkXHJEMuYwuMy5alQ+g+dxnCJim35daO1FFrm78b4z3jr46
 VJpbGDk5Pfj+W3T0TLD9z2ScmjRMppIyyNlQHxtEA+GRL6smf0rThPLF0hS8xxr8+4267+27KDU
 ecCcuBTYf8tAMd1+VHglOSM0WI76772ihk2jkuy1XSH4fwv+BTd4ng6EbbUtBJdNNwyGV39h3h5
 gUOKwl5l1Iwwkrr9rKA==
X-Proofpoint-ORIG-GUID: 1P7jinXOHP8-ow1i0emGpHIryzAxzo5D
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=697001dc cx=c_pps
 a=yPbt1s1ZvotafXW9/QH5sA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=pGLkceISAAAA:8 a=5YblDZH-rCfT6Q5osqUA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: T-H2-CxZm64mlj8d0v992_2GK7qWwGmJ
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D9C82CD24EAA04CBC02AF7A64E0E8F2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2601150000 definitions=main-2601200185
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-74745-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,dubeyko.com,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,reject];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,appspotmail.com:email,syzkaller.appspot.com:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1EC0A4D4C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 10:41 +0530, Deepanshu Kartikey wrote:
> Syzbot reported a KMSAN uninit-value issue in hfsplus_strcasecmp() during
> filesystem mount operations. The root cause is that hfsplus_find_cat()
> declares a local hfsplus_cat_entry variable without initialization before
> passing it to hfs_brec_read().
>=20
> If hfs_brec_read() doesn't completely fill the entire structure (e.g., wh=
en
> the on-disk data is shorter than sizeof(hfsplus_cat_entry)), the padding
> bytes in tmp.thread.nodeName remain uninitialized. These uninitialized
> bytes are then copied by hfsplus_cat_build_key_uni() into the search key,
> and subsequently accessed by hfsplus_strcasecmp() during catalog lookups,
> triggering the KMSAN warning.


Frankly speaking, I don't quite follow what is wrong with current logic from
your explanation. Only, struct hfsplus_cat_thread contains nodeName string.=
 And
hfsplus_strcasecmp() can try to compare some strings only for Catalog thread
type. But hfs_brec_read() should read namely only this type of Catalog File
record. So, I cannot imagine how likewise issue could happen. Could you exp=
lain
the issue more clearly? How uninitiliazed nodeName strings can be used for
comparison? How does it happened? Because, struct hfsplus_cat_thread is the
biggest item in hfsplus_cat_entry union. The struct hfsplus_cat_file and st=
ruct
hfsplus_cat_folder don't contain any strings and strings cannot be used for
comparison in these structures case. But struct hfsplus_cat_thread should be
read completely with the string.

>=20
> Fix this by zeroing the tmp variable before use to ensure all padding
> bytes are initialized.
>=20
> Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd80abb5b890d39261e72 =20
> Tested-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/hfsplus/catalog.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 02c1eee4a4b8..9c75d1736427 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -199,6 +199,7 @@ int hfsplus_find_cat(struct super_block *sb, u32 cnid,
>  	u16 type;
> =20
>  	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
> +	memset(&tmp, 0, sizeof(tmp));

What's about of using initialization:

hfsplus_cat_entry tmp =3D {0};

instead of using memset()?

Thanks,
Slava.

>  	err =3D hfs_brec_read(fd, &tmp, sizeof(hfsplus_cat_entry));
>  	if (err)
>  		return err;


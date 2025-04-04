Return-Path: <linux-fsdevel+bounces-45758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D34A7BDA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D83B871C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C84782D98;
	Fri,  4 Apr 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="1L/a4ODN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E8A937
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772779; cv=fail; b=gKpYqgqYRJhrNOz8uwqvHnZr6ohcMErqciVSeYfzxdKMx6z/aS/YFGAk8fPOV/Pf4eKBnwjS5ZpkjMjklcR+WttfrNUfrQTM7p7tLsYsFU7gdcyPHYiC2jzsxDfKWi7X3JyMK/duwOGgORy0+IEJLcLf0ZJ3V+QRpVzq9hVl1jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772779; c=relaxed/simple;
	bh=IRlkVZUPZOeVcLmYQzm+G4sJzYI1/ey+8poZQQcOyMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fkEe/IUTlN3x/6NOyZHiP+J3VsxXOSUHNwvwbad99JQo56nfdEQye+QZ0pss7bBcvTWbdQ8KW+QFFgVEbpKC3Rlf7VqqqN3BOIa9q2YwSg3uIpBR8cZyPshn4ybKCTsdJcz8nmW0yGnvmhP8Gk2KE/70mFA+BN1n33qtCcrFjH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=1L/a4ODN; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44]) by mx-outbound18-78.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 04 Apr 2025 13:19:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCTzT+cyJtH9auXcFErO5jKASbg3/RPhZq16QUcQicp7Pm7GMhVR1f878cFNkem8EDkYg0LBTu2gu3MTrx9cc6I6JghEY21+73ISBd2UsGY9UaVznN/Q68AKHjAw0tsDuwhwnwFAVfiJO0RvCT2lHdyIiBLXEhuyseCT6ud2sD43Ia0bx/9Whjze46btLG//l3QxrmLucO7G3lP60mq8NyRJ/sQXkquxXM01QB4plZfXFvl1dKKOd4JdrLBy1Wo6t8uaFTHlTy1uI4XCz6RT9y6GtgLKfmIFS9UtvFEWDpb6ZysCumYgky8zz8tTND2wrFKOuOMDGZxMjDMbgsFkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRlkVZUPZOeVcLmYQzm+G4sJzYI1/ey+8poZQQcOyMY=;
 b=TFJoNlyz9eckKLU2VcLCoQBRdOcT8GL8kAluU7N7EIGiCDh3PQ8YUq5xpj2Gx8NWqmFAc+cGecTgA7I8+jCYRIKpnM4IzTF9jPHp+6gZmn0Kj6DaQMhVXClh6WV6sChT8AfGgpShqcnTguHN/GALfxHFKdm2pShCz0USgDd2Se4Z7F49eIhtpuX1riQ3hxwXT0wLls/DDqIqO20KMuhjA8OZC7iTAHFRy0Yj4Ixtbn0ceOrfhLVnhQwsLoNCHOVZIyAkAGbThupTE1eNeh6pTxqztmu2edqntp358xLL5EgjCSf482a7NlPYGs8fZsofsSvx9LyJecf++Px2tLi8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRlkVZUPZOeVcLmYQzm+G4sJzYI1/ey+8poZQQcOyMY=;
 b=1L/a4ODNayIu5JkAEhytO3kefbaiN3w1G+kY9pLekrwW4RAYKMVZGuixVJ6tF+d9+XmAtZc4rqCgRpnyKtytcY6RTw4z8m808/VJ+x0MPTLn8RqjzNHSRCghyRykSrPQCAR31Y+fRho11rEwDYXwMA7oys0fnAJfusqg1Ofxl1A=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MW4PR19MB6936.namprd19.prod.outlook.com (2603:10b6:303:222::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 13:19:30 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 13:19:29 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	=?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Joanne Koong
	<joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 1/4] fuse: Make the fuse unique value a per-cpu counter
Thread-Topic: [PATCH v3 1/4] fuse: Make the fuse unique value a per-cpu
 counter
Thread-Index: AQHbpNYuTHpnMnEQjUuB4GYU/LPQDrOTdKwAgAAKC4A=
Date: Fri, 4 Apr 2025 13:19:29 +0000
Message-ID: <3d08cd8b-0827-4159-922a-4bf0ef7f8035@ddn.com>
References: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
 <20250403-fuse-io-uring-trace-points-v3-1-35340aa31d9c@ddn.com>
 <CAJfpegtBinmb_D=R0zYWF3AoXscwFugRhCMQKP_aRehq5Y_Wfg@mail.gmail.com>
In-Reply-To:
 <CAJfpegtBinmb_D=R0zYWF3AoXscwFugRhCMQKP_aRehq5Y_Wfg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|MW4PR19MB6936:EE_
x-ms-office365-filtering-correlation-id: cbf946b5-f0d9-4f1d-011a-08dd737b54c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZG5LTFRGS3Bzb2czZjVibFh0alhHS09rMkNDZHdaa1BsSHhvMWpnVFFPeHhx?=
 =?utf-8?B?RnFXRXp4UkdaSTRwK1VBWlNLM1pUSDJmYndEUFVpODdxN2tOVGNwWFVPMW9y?=
 =?utf-8?B?QUZaZVFsSmFoeWphNkFSOHgyOWgrcTVGSFdkRnRJN3lyODdaOG1iUE5ObWsx?=
 =?utf-8?B?Mk1OWFNURS9kaTVCNnQzNmErYzlxRjJRZ1h2TS96d0UrNGZEV1pCTkx2cHcw?=
 =?utf-8?B?c3ArMzlaeEpZNHVpbWV3Y2xZVlBIWWtpbWJXcU1hSitMUWE4elBkbXA4WGJV?=
 =?utf-8?B?L0xoeGtFT0pPbUh6NDhQUTFhTUFKMmdwZ3p6eWZPMk8xSzhnakYzWFQyKzJz?=
 =?utf-8?B?SVY0VUYxTkUxRnU3MTNTQ0t2c2NsOGpyYmpwOXErS1Y0MGY2Zjc5eDR3VStx?=
 =?utf-8?B?MFRJWCtia3JrbXZwT3gxZ0dxVHJNNFhqaUxrTWwzMXNmVkZqQVFvZkdNdzhD?=
 =?utf-8?B?YUVFK3A5ZGZMQlM5OG9BdGhGWiswNzFLVHJGOHkyZkFZenU5VkliQXVGQXRL?=
 =?utf-8?B?alFRTXVDS0Q2R1VPdjJWb0c4b2lTUmphQ2xxKzNXSEU2RlJNZUI1UmJtZldK?=
 =?utf-8?B?amtEWmFCSmlqTjZlRTFvYS84TlJWd1Bwd1lzZnRWTFNoYmswRVo5eC9RSUVS?=
 =?utf-8?B?bDkrYzJFTERmcVEwMUZEcXdIOFBya0FnS1ZvZ3ptbEZPN3EvMUlTRStVTzRP?=
 =?utf-8?B?UnlOblFZWHdQdEgwelZRalZNWXRudVJVYnZaN3h0SWFIaUlkaHR0V2Nxc2Ni?=
 =?utf-8?B?Tkw2ZG5PSm5HVUVrVU9VOFFTeGhHMTVFemxNczU3TmFQcHVpcU5pS2tBN1h6?=
 =?utf-8?B?aGxpRG5SZ3NKWUZYbHJlcFFobmVGaDFaOVFFTUVrUFlJdUlyOHNUWVNocWt0?=
 =?utf-8?B?L2hQTDd5YUJkaUNObjd0cGZvWFFkeTJYSFoyeThLYmZoR1JKRVZ0QkRNWmUw?=
 =?utf-8?B?SXQ5dWhwNllGQTVNSmZxZGt0Ky84NlR5ZE5lTTE4RHVpOGNxemQ5dnlXRWJB?=
 =?utf-8?B?WU93THlGWWxQblRoSTAvdUZ6bGZWUDFjTGRwNGkzcURXblo2Q1dUK3FuYnkr?=
 =?utf-8?B?MDVKQ003L08xTjFxMnVVa2w3T1BIL0hNbTBvd0dSZ3RtTjljRlA2K1J5RTRX?=
 =?utf-8?B?LzNqSWNTY1NKUnlPM1JGYjNncndDOGZqdlZHZ05lQnVMc0tuNkJPTGNBUGpq?=
 =?utf-8?B?SDIrUlZqYVJxZXdhNzVCWDBVVFZpd21lODRwcEtmSnNnZXcydVhjMnNoclZn?=
 =?utf-8?B?SGs5a1RlUVg4d3Q1NU1NZXpWekNDSEIyWDRkbmkxSUxMVUNrZ3FYd0hXWHRQ?=
 =?utf-8?B?NzRneWpEbXNnNE1jZklRNWcrU2FtZkpqR3AwY3haUWt4TnRmMCtLU1REMTBV?=
 =?utf-8?B?dDArRkhtRGF6K1pXTDV4YXVNSDZPbWJ5WmpiMmwvYjM0TEZzNks4TlU4TTk2?=
 =?utf-8?B?Y2RURThOZnN6NDlicU0wOU0raW0wK0hLS21na2NoWk0vRHpRVHlueEJUNEx6?=
 =?utf-8?B?QkovT3JIY1BrMUZzcjFXSS9ZSnRLR3BUUU93eTRFMjJXRDdFUHIvTnZSWStk?=
 =?utf-8?B?OGFQOGZHcWttSVh6MnJSand5eEh6Q2pGUGp2YlpOMmhGZjBxa01BMzh1LzV1?=
 =?utf-8?B?R2Z4cGRWcEVCTzVXRUVqM2F5aGpyTFNESG92K1lsUnl0ZVc1UWNOcDV4aTJm?=
 =?utf-8?B?M2pOUDRRU0pvdFJGcHY1dy9CbHE5bDRIbWR1d0pRV3dIZzE5TW9XU0trZXJM?=
 =?utf-8?B?SXRtdHJlenQvYmFMaUNMWUlPcmI0VXZpQkJUOCtkWitsUzhvSWh3SnJidmdE?=
 =?utf-8?B?NFZBajZsVFFpek9FNHdjS1pRanpUS1huZGJjbUVDMVVQQ2FWb2pzQnAxMERq?=
 =?utf-8?B?M2s2WTd3MEpMczV2M2Fudys4VlZPazd2UE9HZy9PMVhoenlta1hhbTJQOHIz?=
 =?utf-8?Q?ibiurONXrbISwiOUX/jCi68NzNAwDWCV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWtMWG1sRTBNN0o4ME9JQ0xoVzdPSWZwVFl3b2tYbzFoVU04ODVFZEoycUNp?=
 =?utf-8?B?RDhzWmVvOWxSQXRjRExGTDluZXVCcVpzM3FNZFhzMWFmaUE2U0wvdmxhdVhU?=
 =?utf-8?B?WkcrbkV2QW9tWERmTUR1V09WS2FoUld3L2MzRE0xSnhtVmFUMVhHUEFlRWZT?=
 =?utf-8?B?ZFpUUmNoK2xDY3NRNTZyVkZvV0Z5YUVCTlo3V0tlcVVXZWFzMG4zeXpCc3F5?=
 =?utf-8?B?K1U2Z3EzcHN6cUcrbHFlRUtXL3VDRzJFWWdSbFFrTm1rcFJrcm03c1VFMjJk?=
 =?utf-8?B?NHpZWlBrOVBERjBmZ1JNVFJPRlhXRVY3OC9FRTlrd09mSEtqY0NuOVdZMjFl?=
 =?utf-8?B?WkgrR2ZGNE1hN2NPN1l2YnVTNkVUWDkrVWJiQVlOMjcvamhyTGNCYnJ1OWFW?=
 =?utf-8?B?Y0p6STg0ZjZ0ZDNVOWN5WGJ5TDVVWEF2VHFGQnM5Qll3MW5UcWxvVk9saUJa?=
 =?utf-8?B?WVEvcG5GTGo5cHRSdkRWUmFLUWNwU3B4TENjL1N2TG1kd0lNWjBIVVRRb05t?=
 =?utf-8?B?eHhtTUQ0ZnR6QzNUOUQ4M2RNMEo5VktTNzdkdXVrVkpFRUpqdlUyVVNhdGJN?=
 =?utf-8?B?VFh5M3YrUjQzN0JncDVQT2NmSk9VcjlBclIvSWlDMzZSTVJvNStGcTk3WStk?=
 =?utf-8?B?TkwxWlhmUkZuTTVjemQ5REhxQXdibnhuODFDWUJBOGlLa2RsNzNLaDRKN1Vk?=
 =?utf-8?B?c1NRcEpnRmtTYkFKRk4xOTRXby9hbkVRRTZPd2U1VTQwRGNEbnk3dE1DMXkr?=
 =?utf-8?B?RDdxMHN3aEJCbXFDV202QjhxSkVLMjBDWCtjMURnT1pwWDZKZXpwWTdJRG1m?=
 =?utf-8?B?d0kxWDROZWh6T3N4ajFUdzRlcTlMNklCVWZDbE5uMklLYjRUMzVDUGZVNWRo?=
 =?utf-8?B?WkdhNXRtSkdIOEtQcndXL3BUT2FuTjdrY1RxWkZUTFR4K1EyV0tzUHBhWGE3?=
 =?utf-8?B?QkpmeG1CT1VzUWFXZjU2TW4zUmp5enBnOVIrUVZObmdvRm56T3M1V2RveVB1?=
 =?utf-8?B?c1pKRnhSaDFIWjdnZDhPeWFnTjJZV2VFNjF4eFlkL2RlWUpJYkxCNkVBTlNV?=
 =?utf-8?B?M25pclNWNmZ5UHpZVDlkOVppMHNBSWxTdVF5S1N1ZHhtclVtaXlQV0htem5G?=
 =?utf-8?B?a080NnpHejRCSHZrNGozRlRIMmRPNitHYlpCOWw3NEVPa0YzdjcrVm1kUi9H?=
 =?utf-8?B?RzNyMkZ5cDhlQTU4UWg0ZHRPMzZkRllvRXlPWWo1aTBpVUIyaVhlbEhZT0NH?=
 =?utf-8?B?ajFsRlI4eVFmKzlrTzU4WDNoTjIyLzlualFHd3pJMlpjVHp3VzdaSlJ3Q3JD?=
 =?utf-8?B?ZEpWVWJmYTUvbmVOZnJIQkdsek5od1g0MCtybzZRYkpjbWtGZ1Y2SmlFUFNn?=
 =?utf-8?B?VHFGMGJRTlJMMXM4YXJ3Zy95bEk4UVZQeVJEQ0piMXZ2cFdOZytKemQzbTFj?=
 =?utf-8?B?eWYyTzRUYmd6bkQvczhSRW8wMVE4ekZFS0U0YTYvQnF6SzJnNjNhZXlFNHNt?=
 =?utf-8?B?b0JWMk4rOUZWV1pkQy9Mb2o0MDJ1eGZDeTAxeU12RzVjM0VpZjBZMHlYT3o3?=
 =?utf-8?B?UUN2cTNFUU5NaEpsQS9Pc2dqTllhZUtvQ2NnVzJGN2dPQ3JFclZpbVJtUjlJ?=
 =?utf-8?B?ZEVzZnJQbGNadnpTTkFCRlBxUlNWVy9HbEdwUmk3a3JkMUpJNXpPN0N5SFJO?=
 =?utf-8?B?cEpBNVJ4ZDJhRW1ER2NicmVmYjJhZC9lS21GVVFrV0ZEWmk5bkw4cmpZN1Ay?=
 =?utf-8?B?UkJYa0RIQzBTSlZ6dC9OWjBHNG9TWlE2c2JKZmlNWFJiZ3BOQlF1cUtWcGpR?=
 =?utf-8?B?Y1lpdGExWUxwK21lckRteVRVQmNnSTROeFY5NzZ5WkV2WDE2RTZQUjRDZ3Fn?=
 =?utf-8?B?eCs2SmJ3bmJ1d0hvdGUxY0dxdGp4dDRNMFhUdEZyWHpYVm1vdVdHbXlSSFdC?=
 =?utf-8?B?WmFJOGJGeVJaUGZWQVNJR1laSldkNGpUY1dtNUdBRW45US81VlJqTjFlb243?=
 =?utf-8?B?WHh0K2dBQnNDRmdENFhkZU9PbGEvd0tWdkRKVlEvWjdIUzUvd3E5Y2V2MjRG?=
 =?utf-8?B?aktQRGNHVHd2SVFKL2FmNlpQbkJRb2hiYVpFc25zMHJTUEJmZkcrajlmdmVo?=
 =?utf-8?B?RjFmRTBFMmxoM251aXRyWWRlSTdUTndLY3ZHazNSNkl3MjlKZjlqSG8vNlZJ?=
 =?utf-8?Q?EbnTg5hBRSBW1t+LxFIYEx4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEACA80343E6CD4AA195D4C6B81B3750@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x1wrEc6NGxJgTRDZhcZwy1UVoF7R9pukxXOpJxD8g3UxFvHu38mixWZ8LcPHsrz25sA8/MxJHwrdRqz6OpAy1EQL1JmJ9jbeXeP0vaXq5KeHEEkcRLw6C+1NZyNA8txbdWEwXDbAPCbH4U0yXfwJZeN4U0HgGtUWSxskL2bx9CFcftKpFbvnsndeXSjXC2Ox9LPe8m0tgpKZ88a2902TKLbviVU7J1xIiMJZcMPV8lzCEthGodJmOibb+q39OS0vCyfS8ruRnteqeDZSPbS+PjTve5yN9ICzIpCjFJLbAQtZagxCxcny6fr4sUd13zja2lJGwlD4odv+5egRoGqDFzHZiM1ID84gX0Iu9o5gon9AcppyxqbapeWq9BvClGZmD9PPZpKmsIm7IKgMhJK6JqpxcbIWrooeuRiqcjExl+tFBOMyml6wVi9BxGSvpwPoqH8xLRQgjnTSYUdczIyRderlOIzok0Zq6/QQGVx4M3iMaZyw+n3pBibGrZlwDR+d3+q/J5CW+1UWshFaPSsJ0CIZVrjK30+PQRtrpMjH4dkoXPqkoSyKamHKeL4aJw5xwC7/SCM1o4ZOJS5SGiAzo1nLpzXKjPE66EmkVKoih0eVrWfKyHArwlm3jLJ366NLNWRpQhZvj/Uax6uCt2JNGw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf946b5-f0d9-4f1d-011a-08dd737b54c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 13:19:29.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjQB/0rdxWQYjpOTcDFYNtPMOSZr9WKrew3/2VDpkQQ3bU6x+G3DKktM1A+qKOg8qJyGbuHYQh4sj3bV8a+dcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6936
X-BESS-ID: 1743772772-104686-7666-1399-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.58.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGBsZAVgZQ0MLMyNLA2MLMwD
	TN3MLYLNk8OdnY0Mg00TLZMjk1ycREqTYWABMlodtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263646 [from 
	cloudscan21-38.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNC80LzI1IDE0OjQzLCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4gT24gVGh1LCAzIEFwciAy
MDI1IGF0IDIyOjIzLCBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+IHdyb3RlOg0K
PiANCj4+ICsvKioNCj4+ICsgKiBHZXQgdGhlIG5leHQgdW5pcXVlIElEIGZvciBhIHJlcXVlc3QN
Cj4+ICsgKi8NCj4+ICtzdGF0aWMgaW5saW5lIHU2NCBmdXNlX2dldF91bmlxdWUoc3RydWN0IGZ1
c2VfaXF1ZXVlICpmaXEpDQo+PiArew0KPj4gKyAgICAgICBpbnQgc3RlcCA9IEZVU0VfUkVRX0lE
X1NURVAgKiAodGFza19jcHUoY3VycmVudCkpOw0KPj4gKyAgICAgICB1NjQgY250ciA9IHRoaXNf
Y3B1X2luY19yZXR1cm4oKmZpcS0+cmVxY3RyKTsNCj4+ICsNCj4+ICsgICAgICAgcmV0dXJuIGNu
dHIgKiBGVVNFX1JFUV9JRF9TVEVQICogTlJfQ1BVUyArIHN0ZXA7DQo+IA0KPiBUaGlua2luZyBh
IGJpdC4uLiB0aGlzIGxvb2tzIHdyb25nLg0KPiANCj4gVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSB0
YXNrIGNvdWxkIGJlIG1pZ3JhdGVkIHRvIGEgZGlmZmVyZW50IENQVQ0KPiBiZXR3ZWVuIHRoZSB0
YXNrX2NwdSgpIGFuZCB0aGUgdGhpc19jcHVfaW5jX3JldHVybigpLCByZXN1bHRpbmcgaW4gYQ0K
PiBwb3NzaWJseSBkdXBsaWNhdGVkIHZhbHVlLg0KPiANCj4gVGhpcyBjb3VsZCBiZSBmaXhlZCB3
aXRoIGEgcHJlZW1wdF9kaXNhYmxlKCkvcHJlZW1wdF9lbmFibGUoKSBwYWlyLA0KPiBidXQgSSB0
aGluayBpdCB3b3VsZCBiZSBjbGVhbmVyIHRvIGdvIHdpdGggbXkgb3JpZ2luYWwgaWRlYSBhbmQN
Cj4gaW5pdGlhbGl6ZSB0aGUgcGVyY3B1IGNvdW50ZXJzIHRvICBDUFVJRCBhbmQgaW5jcmVtZW50
IGJ5IE5SX0NQVSAqDQo+IEZVU0VfUkVRX0lEX1NURVAgd2hlbiBmZXRjaGluZyBhIG5ldyB2YWx1
ZS4NCj4gDQoNCk9oIHJpZ2h0LCBJIGd1ZXNzIHNvbWV0aGluZyBsaWtlIHRoaXMNCg0KZGlmZiAt
LWdpdCBhL2ZzL2Z1c2UvZnVzZV9pLmggYi9mcy9mdXNlL2Z1c2VfaS5oDQppbmRleCA4MGE1MjZl
YWJhMzguLmVhYzI2ZWU2NTRjYSAxMDA2NDQNCi0tLSBhL2ZzL2Z1c2UvZnVzZV9pLmgNCisrKyBi
L2ZzL2Z1c2UvZnVzZV9pLmgNCkBAIC0xMDc0LDEwICsxMDc0LDcgQEAgc3RhdGljIGlubGluZSB2
b2lkIGZ1c2Vfc3luY19idWNrZXRfZGVjKHN0cnVjdCBmdXNlX3N5bmNfYnVja2V0ICpidWNrZXQp
DQogICovDQogc3RhdGljIGlubGluZSB1NjQgZnVzZV9nZXRfdW5pcXVlKHN0cnVjdCBmdXNlX2lx
dWV1ZSAqZmlxKQ0KIHsNCi0gICAgICAgaW50IHN0ZXAgPSBGVVNFX1JFUV9JRF9TVEVQICogKHRh
c2tfY3B1KGN1cnJlbnQpKTsNCi0gICAgICAgdTY0IGNudHIgPSB0aGlzX2NwdV9pbmNfcmV0dXJu
KCpmaXEtPnJlcWN0cik7DQotDQotICAgICAgIHJldHVybiBjbnRyICogRlVTRV9SRVFfSURfU1RF
UCAqIE5SX0NQVVMgKyBzdGVwOw0KKyAgICAgICByZXR1cm4gdGhpc19jcHVfYWRkX3JldHVybigq
ZmlxLT5yZXFjdHIsIEZVU0VfUkVRX0lEX1NURVAgKiBOUl9DUFVTKTsNCiB9DQogDQogLyoqIERl
dmljZSBvcGVyYXRpb25zICovDQpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9pbm9kZS5jIGIvZnMvZnVz
ZS9pbm9kZS5jDQppbmRleCA3ZTEwNjZjMTc0ZDAuLjQ2M2NmNzc5N2UxYiAxMDA2NDQNCi0tLSBh
L2ZzL2Z1c2UvaW5vZGUuYw0KKysrIGIvZnMvZnVzZS9pbm9kZS5jDQpAQCAtOTMwLDcgKzkzMCwx
MyBAQCBzdGF0aWMgdm9pZCBmdXNlX2lxdWV1ZV9pbml0KHN0cnVjdCBmdXNlX2lxdWV1ZSAqZmlx
LA0KICAgICAgICBtZW1zZXQoZmlxLCAwLCBzaXplb2Yoc3RydWN0IGZ1c2VfaXF1ZXVlKSk7DQog
ICAgICAgIHNwaW5fbG9ja19pbml0KCZmaXEtPmxvY2spOw0KICAgICAgICBpbml0X3dhaXRxdWV1
ZV9oZWFkKCZmaXEtPndhaXRxKTsNCisgICAgICAgaW50IGNwdTsNCisNCiAgICAgICAgZmlxLT5y
ZXFjdHIgPSBhbGxvY19wZXJjcHUodTY0KTsNCisgICAgICAgZm9yX2VhY2hfcG9zc2libGVfY3B1
KGNwdSkgew0KKyAgICAgICAgICAgICAgICpwZXJfY3B1X3B0cihmaXEtPnJlcWN0ciwgY3B1KSA9
IGNwdSAqIEZVU0VfUkVRX0lEX1NURVA7DQorICAgICAgIH0NCisNCiAgICAgICAgSU5JVF9MSVNU
X0hFQUQoJmZpcS0+cGVuZGluZyk7DQogICAgICAgIElOSVRfTElTVF9IRUFEKCZmaXEtPmludGVy
cnVwdHMpOw0KICAgICAgICBmaXEtPmZvcmdldF9saXN0X3RhaWwgPSAmZmlxLT5mb3JnZXRfbGlz
dF9oZWFkOw0KDQoNCg0KDQpGaXJzdCBuZWVkIHRvIHRlc3QgYW5kIHRoaW5rIGFib3V0IGl0IGFn
YWluIGFuZCBjdXJyZW50bHkgYnVzeQ0Kd2l0aCBzb21ldGhpbmcgZWxzZSAtIG5ldyB2ZXJzaW9u
IGZvbGxvd3MgbGF0ZXIuDQoNCg0KVGhhbmtzLA0KQmVybmQNCg==


Return-Path: <linux-fsdevel+bounces-26339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16924957CD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 07:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D1CB23A37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 05:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26132148FEB;
	Tue, 20 Aug 2024 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IMksJwLs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413A1459F6;
	Tue, 20 Aug 2024 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724132584; cv=fail; b=Q9NoGDLhdd/TCKa8QCpXESaZAtEjKnyMKgRw5XQUzRmGe/lZl+jvBbKxoLknuIUwxUhf6NzpjiifgzLxhuFdzijypdyqvPyFFpDsqie80OQDmYxSCS9E5AYSwb7sk4QTcAV9bWcXIQGptpgzyw+Z9S/9sdw/mo6+AMUI4T2YHlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724132584; c=relaxed/simple;
	bh=NrdsSrgJctQw+/GgJXpq4WrqU6IBufucYgQ5Vl12J0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u1VO4Rmen1roCRP307e1kCwnX9eAuAs5y1iYVxWz6Jx+FUJYQJKPpQjBsZ8O+qlESkvRJpynN8VDSCKUSlwDlgCADYFQxsk6VGjOxWyLB2v3RsU1y7WHjXMPG7oU5HAwzRwI+05DAfU6NS831bc7NCt5AniRO/d4At9vQBu23EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IMksJwLs; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K3Fprt032758;
	Mon, 19 Aug 2024 22:43:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=NrdsSrgJctQw+/GgJXpq4WrqU6IBufucYgQ5Vl12J0k
	=; b=IMksJwLstz+FATvDFk/KlRfXeDzNRSojcRlgZ/nmmEf940Bwu9pwB6dN+M6
	3W55Aj5/B3Ky8+dSzO7DbZuwAsKXZwRc8HlDrqnPKq6RQYVbpSJGUJhOPtFi82Vg
	a+aeknY335T9dGMpbGrqFE+lgQw1GA9zaCgexvAjJPya1MF2Q906xBxAiUwN2M1Q
	BfJK30LjCwhL2ZrlP6WNER1iBa0r3qM+7P3+Qlg9toOmtvLDz91mR0MHkR57L4M5
	9+OVz4TRblPN3I0fpauAyRex4aTVVbMcsdsn+6kueqctuwrl/4V9XHoudjC1auyt
	gxZaBupBMSrisigmbHxbQNT9cBg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 414k2q0eyp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 22:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORrHMyiuELDqGFN4IdnofqZb0KvxCd59OvUjvwePZCC2yPqh1ngjI3eRPdVmU5UwAmuBE0f8iqyfEXBXlmZPdC7xU/DysqN2r0+it+ZS/+2bXqClyKU38tdpDO6p/7x2PDsX/rNCcP6IoZfcKwK5T5h3nsgQ7E6EoOsFMNQfrDIJjzB/8ismm2l1vbo1nPrisxlTUtzw+xjlN3X5IXs6fOx6msguAD6IOQE8y4nmRf+y+xgibX1w6ZmhzkYrvzUv695+NeteOJoONGbyyQPycqisYnRlK6iEXBQq/ll0Abdx/K1AiPhyrZ5cqZ/wLhdQtlH0ul49MBdzGDzn/9GsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrdsSrgJctQw+/GgJXpq4WrqU6IBufucYgQ5Vl12J0k=;
 b=FdmL2Fvq8Sn0FRDvTTG4WdTTZ5txuvcklJxx2WuRL+FejV34gSCoP4c/4yQ8wibhWO2W0tuGewAqIqUvYFIUMXOm7SNxz9rBaqOjrcEgqCekoUQ7vNkiqYdAWxSF1vWgS+sD4s8CYhslN9eYDwk7ZSHsUozN3QCIb7up1sjEceObGGq8VHgIkJNhAAPsdbLJnyA4FgSOFPgTy2mDG249oY26mzh0BLQxz4+lAfgOs/TAvEilhNhmpLy2j4bfG2zRV23o1DeL5Ae6MujAQOUIA3gi6XlKB4IQ9ShUmO1wAWBTtSpOe57l2xBeCnVmylcndHZKShWjCx3quQc2yUDhrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB5103.namprd15.prod.outlook.com (2603:10b6:510:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 05:42:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 05:42:58 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <songliubraving@meta.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
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
        Liam Wisehart
	<liamwisehart@meta.com>, Liang Tang <lltang@meta.com>,
        Shankaran
 Gnanashanmugam <shankaran@meta.com>,
        LSM List
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index:
 AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQCAACpzAIAAg8YAgARTMQCAIJSqAIAAQmAAgACZf4CAAJu4gA==
Date: Tue, 20 Aug 2024 05:42:58 +0000
Message-ID: <3C282464-5230-4607-A477-BBA19A199681@fb.com>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
 <DB8E8B09-094E-4C32-9D3F-29C88822751A@fb.com>
In-Reply-To: <DB8E8B09-094E-4C32-9D3F-29C88822751A@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB5103:EE_
x-ms-office365-filtering-correlation-id: f018ca44-66ac-4843-d68e-08dcc0daf283
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amxqTTd2QlROWndGc2lySjVyUHJkNE9rQ2lrVUNOeHhmbFAzZU40UWc4OGZD?=
 =?utf-8?B?L1B1ZncvQjFSMURNK2RDMnhtT01tYXJSYzJMajFWUHY4cEkvOEpueFJQMnYr?=
 =?utf-8?B?T21waFhXTjUwRllNdDVnUWNEQ0dDTG1NOERwOEUvN0VEOHlCSTRsVmR3Zys0?=
 =?utf-8?B?TEFWZi9WR1lkOEJ0OWprUWNpYVNMZ3IzN25iWVY5ZmlEcVN5Z0RQZWlFNS9C?=
 =?utf-8?B?ak9vT0NTbFQyVHNCQlpJVHpPbTdqRU1UbTN2akhkeEQrT1lHL1JwUk5jdCtP?=
 =?utf-8?B?bG1rdHdZWGtLY3RxSjlFZnU5UFdtWXI0UDBvR3BXQmU1VFgzcEwvZWVQaVBa?=
 =?utf-8?B?c21kYjZSRG1GUGNRNzJyOGNuYWp5emdySUtIQzc0dHRxZmhONU9keTIxdG9X?=
 =?utf-8?B?aWUzUFFCWWM5SC9rOGl0WnNsa05QeEY4cFNWTWJheTh1dnFQZzFLVWNzczF0?=
 =?utf-8?B?anVwekxiTmkrR2ZhVTJUc3RuWU9BZER4eS9saE9UZ3JxRjlPY2NUSkF5dnlN?=
 =?utf-8?B?YnMyRWdKcFNyaTlOVnBjRkRlYzhLRG93SEROVGovUER2YzNjaUNLV2pibmYw?=
 =?utf-8?B?aHV6QzJjUzYrTnlFUC9Ram82bnJ2OGkzU0V4QzFrT1doZWxwYkVqajNHeCts?=
 =?utf-8?B?WjhDU1ZvR0hxNVBVaHV1ZTRPTG9kZFRoeE4rejFUQjZuWVMxVytBK0pIYzEv?=
 =?utf-8?B?NG15N0kvRXR5TlhqcWNValJReUVNWlVwKzFLdlZlRlpuSk5jY0JrOHhIc1VX?=
 =?utf-8?B?SUllRWV2VmVyK1VlSW4zdkZXd0NudStxUmUva2pUZ1RFOVBkajZDSms5TlVm?=
 =?utf-8?B?VEo5a1c1enZ5eGtVSFUvbGtpWEhlaVNqRnVITXlrZUprZGRnY3pmcFhpeG9j?=
 =?utf-8?B?WldxUUl4N2xFSi9xWXdqOExTMmVGaU5yLzdWZVNwK3djTktIeENuVXhBYTZu?=
 =?utf-8?B?ZkcwdVY1UFdjQ2xaYTNwNTBienkxQW5ldFJCMmZINE5XT2lDekNnY0JndTJ0?=
 =?utf-8?B?cEhrS1o0QzFCRkNLV0JOaFJMSEdsYXQyczkxb1F5bGlxWWRZcVJuVDlIbGZ2?=
 =?utf-8?B?VWo5amg4REs1cUwzNjVoTWZMUVdoSDhBSDJ0YjNHSXVsQkh0RlkycWp2a25V?=
 =?utf-8?B?ZHNiRys4RXpLN3ZnVjZSRE5kb1BqL3BzWjJSS3Z4UGlDSXJEYno0RzE4SnAy?=
 =?utf-8?B?WXlSK21TeGRkNTZjaFRuWnV1TVY5ZjcxbnZicDh2S3Foajg5L1RjTXFPWVNk?=
 =?utf-8?B?TmhMaFNVb3hmOER1T0UxS2J5eTZBSjFMeVJEdk9vY1VWUDVqeVIxa3dpTkNp?=
 =?utf-8?B?Wit6RGJFeE1JRFNVWTVxWTdHcWRsZEhsd1RvK0QzZS9WUjBPSS96Yy9XazZv?=
 =?utf-8?B?NHlzQXJWK3Z0ZlY1aG43Y2N3dThDRU9xa2NhNkF4K056ckFjUVJkbTQvZ1FX?=
 =?utf-8?B?TEFNc2p0eWpKR1pBMXdMQkZwWFVPQVU5Ri90L0RWd0F0RTBUZFdVaTlXNk5W?=
 =?utf-8?B?cWVLNVkwR1pHMmpmdnhUZWIzQnFYZGoxSm9ncjlLSnlJNkplbCtTU2k4Zmgv?=
 =?utf-8?B?M0lYRmVicXdjRVFGdXUweHRmeFVySTRpbjUxZ0JLUklBWlRzZEJ2M3ROVkhK?=
 =?utf-8?B?SW5BU3NiK1kxaER6amlBcEhWMlB6MGxubXkxYzlQSkZ6V2ZRZ3ZTWkcrNjFV?=
 =?utf-8?B?d3RudEh4Y1FURmpSQzZxRG5UL2Zqb1pCWjRCZjRYUkpxSkxoNWVYK2MyVzNM?=
 =?utf-8?B?VExsbDhnY3N0WVNPVU52eDE4VlhCRnk0R01NYnNhaEFGRXJDcnhyQXYzQ0pN?=
 =?utf-8?B?dlRXdXorZzJWNUM0d25ESEh0VUZ1cTkyRFY1UXN5dk9vQ3YrQjVGNFN6anNI?=
 =?utf-8?B?M3lJTUJtOHRrN1FlbW5ib2Q2TXg1S1dsaWJST3M1Z3RMTHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFRHWldia3NqR1lJc1c5SElZTm5wMjlLUS9PeDdoQTJHNGNOZ0h4ZFRuaVRE?=
 =?utf-8?B?aFZiUE5kS21lRFZHSnk5MWE4cDl0SWx6dTJHNjhOVVBLYjd0bk5DM005OHN0?=
 =?utf-8?B?akZiS1AzSndBR0p0dWRvS2tpL2c2aFhzTFRlZEtTV3RoREJIOWZ0ZXZFQlpa?=
 =?utf-8?B?cW14Z3BHdjVnWElEMmNXQzFvSFgrSE5GdVhhd245NXNlWHJsZFBpRy9uUDBv?=
 =?utf-8?B?SDZ0ak00ekZrT2FudjRvVVNsYjV2ZnNVcVZWdllzMmI5aUhDSmpSY3NVQ3ow?=
 =?utf-8?B?TWpHVlBxUTYxaG9mejJrUjkxbWkwWnZIWXJiRVNJaFdVUlIyT0xZM3NuTXVF?=
 =?utf-8?B?cDlmR3llY3lORzdzM3pJbVRra0VDK3ByS0ZOM004OUhNL2JUd3R5K0Z4ckg0?=
 =?utf-8?B?MjBrWWZidEszLzMxTHZac2xwdFVEZDRNUnpMa3M2WW9xUE5ES1NBaVBYVlZv?=
 =?utf-8?B?Y1B5TVZ4TlVZUklHUDNGOFc3aE84Y21qOVVmcWxmWkpCVG9ZS1lTREJvUXhO?=
 =?utf-8?B?ZTRIUHl5amp6cHNpbGUwSVFpbHRacnhTdnNTMzNXZS9uS3phMjRpamhNZDdJ?=
 =?utf-8?B?MDBBbVJ3enBHQ0JDaDFBdXNkZHdaaVRqckdFQ0NBTldHdVRZSXY3a2IyT2RR?=
 =?utf-8?B?WGNUUndOeEFnVnNKUlRxcWg0Zk9SVW5PS3EwT3pHZFhpN1J3QmxwRW5oR0FU?=
 =?utf-8?B?TnoreXNsN3hJMldSd3RWNC82ZmEzSW5hOHdTb0pRanZDWDVLU1h4QkZzNllI?=
 =?utf-8?B?UDZVMXZ4ZStDZEhHUkxyV3QrclJ2NmNHcXZpYnpTZXQ0Q3lJNzFrcnFrTFI5?=
 =?utf-8?B?QzA5aktrOUdFc1Z0WVFsS29ZRmhqQmVORXloL1poZWJLem9XRGlvL0hyYlhE?=
 =?utf-8?B?a0NIYXpLU0swVEVLRm81TWNzUU8rUkk5eE1CbWxNdmEvSTFTUkhiaStxM0E5?=
 =?utf-8?B?bFpVeVRNK1h1cHp0ZWJ1Zm5WNTFBdU04bjQxV0lvTzNoVnR6LzhKb0dXanpO?=
 =?utf-8?B?T3JyNXh3QVM2K29uUzNTb2REUmhDMlFKZzJLd1k0djdjVGdjSERYODdDSG41?=
 =?utf-8?B?cDJONGVQSmM2Mm9mM0dSLzhXbnRIcWJBTG9pZHdZOW9lQzYzTHdxTDhObTFm?=
 =?utf-8?B?MzFoa1JIWmFHaFgzK0x1SEcrdWFYWlFXS3RGbit3YTJKZFZSYUIrRjYvK3Ry?=
 =?utf-8?B?cUxycy9pQ3g1YUliYnFsZFJ1VW8vUjIwNGFqKzArbHhXU2tGTlBHSHJOT3BC?=
 =?utf-8?B?bFNwQUpSM05WSThLdjdZcWZPa0xRNHBmVTNKbEszOGdYT3BOUmpFUjFYMmV3?=
 =?utf-8?B?REFSOStOcjRVa2dUSGdvV3JwMGFXdzRPeG0vbXBwZ2dYWjEvUnI5KzA3TlZB?=
 =?utf-8?B?NTlBcnBES1RkdTR2OStTM1hFdG1GZWZQVkcvY01xRy9PMFFURDVYZzBIbG1x?=
 =?utf-8?B?RjlhYW8zTmxwNFJ6OHlxVHdqQ1JDWENBQXFRT3EvWlk2TzI0dnZQVmFBU0F2?=
 =?utf-8?B?Ryt4RWEvWWk3eC91b0NGd09EMlFza2F1cTFjcjg0OHQrUkwxZWU3Yk56VVVv?=
 =?utf-8?B?SnJaR0wyNjlGU2tkL0VYZXhqTzd4YWJmVGZyMDliTnN4bDdBeUlRakVnOFdn?=
 =?utf-8?B?M2ZLOGNKVnMxeEcxd0RaVEpwNkh6NnVUdTU3NU53NDFUcURIeXh3WWZHM0or?=
 =?utf-8?B?OHBsKytrVFlSMlExajhqb0JOeWhENVR5ekV2dk9oMmE1R1JUVWcxeWNGYVdU?=
 =?utf-8?B?bXkyUVg0ajl2RE5SdGhzLzRVRWRXSEs5djl4SExXcmkwUTBVZHZ5cnluOHNB?=
 =?utf-8?B?NVpNTk9jN1lrSjZWOTZzU3VpZ2RLK0FGM3lIdlBvV2hnTmR0MVE0c013b2Fn?=
 =?utf-8?B?Mlc1cFIrekZtZ2VnZWM3eHZKbUxkNGVtMEJZQjlRa25tN3JIak1tWXQ0ejg4?=
 =?utf-8?B?ZWpwNTR6cEpmNlAwWnlPNkhCcXJYZkNXOEFhK3pTSHI1RlI4U0svQmJjUksv?=
 =?utf-8?B?cDBmSVh6d0hKQjFkSTB4TGJoVEVXd1JEK0JEaWVQMFpSYTUyeGVDZEwxMFpj?=
 =?utf-8?B?QkRnL1BsQURhaTR3SHVsNWZzejMzd1lVaWVOVkxuUmVJQU9waldMN3VzSStz?=
 =?utf-8?B?anV4ZGx0MkVZNWtKV28xQkh3OTErTkVBS0srNHl4SHI2Tkx5cGJJbEc4TzJK?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <769AE3E415AE914882C6427A0582BC97@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f018ca44-66ac-4843-d68e-08dcc0daf283
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 05:42:58.3349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGu7kCWv1qytvoST+3GsweWw464Ewyz9iqiCgXDW1qKDRt7hywKrPeEHRKOdSqV9sl4hQ+qifXnZOCEoLQlHoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5103
X-Proofpoint-GUID: IvNF_7ji48uaIJrIO4uOJ74IYCmjPHUd
X-Proofpoint-ORIG-GUID: IvNF_7ji48uaIJrIO4uOJ74IYCmjPHUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01

SGkgQ2hyaXN0aWFuLCANCg0KPiBPbiBBdWcgMTksIDIwMjQsIGF0IDE6MjXigK9QTSwgU29uZyBM
aXUgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBDaHJpc3RpYW4sIA0K
DQpbLi4uXQ0KDQo+IElmIHlvdSBwcm92aWRlIGEgYnBmX2dldF9wYXJlbnQoKSBhcGkgZm9yIHVz
ZXJzcGFjZSB0byBjb25zdW1lIHlvdSdsbA0KPj4gZW5kIHVwIHByb3ZpZGluZyB0aGVtIHdpdGgg
YW4gYXBpIHRoYXQgaXMgZXh0cmVtbHkgZWFzeSB0byBtaXN1c2UuDQo+IA0KPiBEb2VzIHRoaXMg
bWFrZSBzZW5zZSB0byBoYXZlIGhpZ2hlciBsZXZlbCBBUEkgdGhhdCB3YWxrcyB1cCB0aGUgcGF0
aCwgDQo+IHNvIHRoYXQgaXQgdGFrZXMgbW91bnRzIGludG8gYWNjb3VudC4gSXQgY2FuIHByb2Jh
Ymx5IGJlIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gaW50IGJwZl9nZXRfcGFyZW50X3BhdGgoc3Ry
dWN0IHBhdGggKnApIHsNCj4gYWdhaW46DQo+ICAgIGlmIChwLT5kZW50cnkgPT0gcC0+bW50Lm1u
dF9yb290KSB7DQo+ICAgICAgICBmb2xsb3dfdXAocCk7DQo+ICAgICAgICBnb3RvIGFnYWluOw0K
PiAgICB9DQo+ICAgIGlmICh1bmxpa2VseShJU19ST09UKHAtPmRlbnRyeSkpKSB7DQo+ICAgICAg
ICByZXR1cm4gUEFSRU5UX1dBTEtfRE9ORTsgIA0KPiAgICB9DQo+ICAgIHBhcmVudF9kZW50cnkg
PSBkZ2V0X3BhcmVudChwLT5kZW50cnkpOw0KPiAgICBkcHV0KHAtPmRlbnRyeSk7DQo+ICAgIHAt
PmRlbnRyeSA9IHBhcmVudF9kZW50cnk7DQo+ICAgIHJldHVybiBQQVJFTlRfV0FMS19ORVhUOyAN
Cj4gfQ0KPiANCj4gVGhpcyB3aWxsIGhhbmRsZSB0aGUgbW91bnQuIEhvd2V2ZXIsIHdlIGNhbm5v
dCBndWFyYW50ZWUgZGVueS1ieS1kZWZhdWx0DQo+IHBvbGljaWVzIGxpa2UgTGFuZExvY2sgZG9l
cywgYmVjYXVzZSB0aGlzIGlzIGp1c3QgYSBidWlsZGluZyBibG9jayBvZiANCj4gc29tZSBzZWN1
cml0eSBwb2xpY2llcy4gDQoNCkkgZ3Vlc3MgdGhlIGFib3ZlIGlzIG5vdCByZWFsbHkgY2xlYXIu
IEhlcmUgaXMgYSBwcm90b3R5cGUgSSBnb3QuIA0KV2l0aCB0aGUga2VybmVsIGRpZmYgYXR0YWNo
ZWQgYmVsb3csIHdlIGFyZSBhYmxlIHRvIGRvIHNvbWV0aGluZw0KbGlrZToNCg0KU0VDKCJsc20u
cy9maWxlX29wZW4iKQ0KaW50IEJQRl9QUk9HKHRlc3RfZmlsZV9vcGVuLCBzdHJ1Y3QgZmlsZSAq
ZikNCnsNCgkvKiAuLi4gKi8NCg0KICAgICAgICBicGZfZm9yX2VhY2goZGVudHJ5LCBkZW50cnks
ICZmLT5mX3BhdGgsIEJQRl9ERU5UUllfSVRFUl9UT19ST09UKSB7DQogICAgICAgICAgICAgICAg
cmV0ID0gYnBmX2dldF9kZW50cnlfeGF0dHIoZGVudHJ5LCAidXNlci5rZnVuYyIsICZ2YWx1ZV9w
dHIpOw0KCQkvKiBkbyB3b3JrIHdpdGggdGhlIHhhdHRyIGluIHZhbHVlX3B0ciAqLw0KICAgICAg
ICB9DQoNCgkvKiAuLi4gKi8NCn0NCg0KV2l0aCB0aGlzIGhlbHBlciwgdGhlIHVzZXIgY2Fubm90
IHdhbGsgdGhlIHRyZWUgcmFuZG9tbHkuIEluc3RlYWQsIA0KdGhlIHdhbGsgaGFzIHRvIGZvbGxv
dyBzb21lIHBhdHRlcm4sIG5hbWVseSwgVE9fUk9PVCwgVE9fTU5UX1JPT1QsIA0KZXRjLiBBbmQg
aGVscGVyIG1ha2VzIHN1cmUgdGhlIHdhbGsgaXMgc2FmZS4gDQoNCkRvZXMgdGhpcyBzb2x1dGlv
biBtYWtlIHNlbnNlIHRvIHlvdT8gDQoNClRoYW5rcywNClNvbmcNCg0KDQoNClRoZSBrZXJuZWwg
ZGlmZiBiZWxvdy4gDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0gODwgPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KDQoNCmRpZmYgLS1naXQgYy9mcy9icGZfZnNfa2Z1bmNz
LmMgdy9mcy9icGZfZnNfa2Z1bmNzLmMNCmluZGV4IDNmZTlmNTllZjg2Ny4uNGIxNDAwZGVjOTg0
IDEwMDY0NA0KLS0tIGMvZnMvYnBmX2ZzX2tmdW5jcy5jDQorKysgdy9mcy9icGZfZnNfa2Z1bmNz
LmMNCkBAIC04LDYgKzgsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9mcy5oPg0KICNpbmNsdWRlIDxs
aW51eC9maWxlLmg+DQogI2luY2x1ZGUgPGxpbnV4L21tLmg+DQorI2luY2x1ZGUgPGxpbnV4L25h
bWVpLmg+DQogI2luY2x1ZGUgPGxpbnV4L3hhdHRyLmg+DQoNCiBfX2JwZl9rZnVuY19zdGFydF9k
ZWZzKCk7DQpAQCAtMTU0LDEzICsxNTUsOTEgQEAgX19icGZfa2Z1bmMgaW50IGJwZl9nZXRfZmls
ZV94YXR0cihzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciAqbmFtZV9fc3RyLA0KDQogX19i
cGZfa2Z1bmNfZW5kX2RlZnMoKTsNCg0KK3N0cnVjdCBicGZfaXRlcl9kZW50cnkgew0KKyAgICAg
ICBfX3U2NCBfX29wYXF1ZVszXTsNCit9IF9fYXR0cmlidXRlX18oKGFsaWduZWQoOCkpKTsNCisN
CitzdHJ1Y3QgYnBmX2l0ZXJfZGVudHJ5X2tlcm4gew0KKyAgICAgICBzdHJ1Y3QgcGF0aCBwYXRo
Ow0KKyAgICAgICB1bnNpZ25lZCBpbnQgZmxhZ3M7DQorfSBfX2F0dHJpYnV0ZV9fKChhbGlnbmVk
KDgpKSk7DQorDQorZW51bSB7DQorICAgICAgIC8qIGFsbCB0aGUgcGFyZW50IHBhdGhzLCB1bnRp
bCByb290ICgvKSAqLw0KKyAgICAgICBCUEZfREVOVFJZX0lURVJfVE9fUk9PVCwNCisgICAgICAg
LyogYWxsIHRoZSBwYXJlbnQgcGF0aHMsIHVudGlsIG1udCByb290ICovDQorICAgICAgIEJQRl9E
RU5UUllfSVRFUl9UT19NTlRfUk9PVCwNCit9Ow0KKw0KK19fYnBmX2tmdW5jX3N0YXJ0X2RlZnMo
KTsNCisNCitfX2JwZl9rZnVuYyBpbnQgYnBmX2l0ZXJfZGVudHJ5X25ldyhzdHJ1Y3QgYnBmX2l0
ZXJfZGVudHJ5ICppdCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IHBhdGggKnBhdGgsIHVuc2lnbmVkIGludCBmbGFncykNCit7DQorICAgICAgIHN0cnVj
dCBicGZfaXRlcl9kZW50cnlfa2VybiAqa2l0ID0gKHZvaWQqKWl0Ow0KKw0KKyAgICAgICBCVUlM
RF9CVUdfT04oc2l6ZW9mKHN0cnVjdCBicGZfaXRlcl9kZW50cnlfa2VybikgPg0KKyAgICAgICAg
ICAgICAgICAgICAgc2l6ZW9mKHN0cnVjdCBicGZfaXRlcl9kZW50cnkpKTsNCisgICAgICAgQlVJ
TERfQlVHX09OKF9fYWxpZ25vZl9fKHN0cnVjdCBicGZfaXRlcl9kZW50cnlfa2VybikgIT0NCisg
ICAgICAgICAgICAgICAgICAgIF9fYWxpZ25vZl9fKHN0cnVjdCBicGZfaXRlcl9kZW50cnkpKTsN
CisNCisgICAgICAgaWYgKGZsYWdzKQ0KKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
Kw0KKyAgICAgICBzd2l0Y2ggKGZsYWdzKSB7DQorICAgICAgIGNhc2UgQlBGX0RFTlRSWV9JVEVS
X1RPX1JPT1Q6DQorICAgICAgIGNhc2UgQlBGX0RFTlRSWV9JVEVSX1RPX01OVF9ST09UOg0KKyAg
ICAgICAgICAgICAgIGJyZWFrOw0KKyAgICAgICBkZWZhdWx0Og0KKyAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KKyAgICAgICB9DQorICAgICAgIGtpdC0+cGF0aCA9ICpwYXRoOw0KKyAg
ICAgICBwYXRoX2dldCgma2l0LT5wYXRoKTsNCisgICAgICAga2l0LT5mbGFncyA9IGZsYWdzOw0K
KyAgICAgICByZXR1cm4gMDsNCit9DQorDQorX19icGZfa2Z1bmMgc3RydWN0IGRlbnRyeSAqYnBm
X2l0ZXJfZGVudHJ5X25leHQoc3RydWN0IGJwZl9pdGVyX2RlbnRyeSAqaXQpDQorew0KKyAgICAg
ICBzdHJ1Y3QgYnBmX2l0ZXJfZGVudHJ5X2tlcm4gKmtpdCA9ICh2b2lkKilpdDsNCisgICAgICAg
c3RydWN0IGRlbnRyeSAqcGFyZW50X2RlbnRyeTsNCisNCisgICAgICAgaWYgKHVubGlrZWx5KElT
X1JPT1Qoa2l0LT5wYXRoLmRlbnRyeSkpKQ0KKyAgICAgICAgICAgICAgIHJldHVybiBOVUxMOw0K
Kw0KK2p1bXBfdXA6DQorICAgICAgIGlmIChraXQtPnBhdGguZGVudHJ5ID09IGtpdC0+cGF0aC5t
bnQtPm1udF9yb290KSB7DQorICAgICAgICAgICAgICAgaWYgKGtpdC0+ZmxhZ3MgPT0gQlBGX0RF
TlRSWV9JVEVSX1RPX01OVF9ST09UKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE5V
TEw7DQorICAgICAgICAgICAgICAgaWYgKGZvbGxvd191cCgma2l0LT5wYXRoKSkgew0KKyAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBqdW1wX3VwOw0KKyAgICAgICAgICAgICAgIH0NCisgICAg
ICAgfQ0KKyAgICAgICBwYXJlbnRfZGVudHJ5ID0gZGdldF9wYXJlbnQoa2l0LT5wYXRoLmRlbnRy
eSk7DQorICAgICAgIGRwdXQoa2l0LT5wYXRoLmRlbnRyeSk7DQorICAgICAgIGtpdC0+cGF0aC5k
ZW50cnkgPSBwYXJlbnRfZGVudHJ5Ow0KKyAgICAgICByZXR1cm4gcGFyZW50X2RlbnRyeTsNCit9
DQorDQorX19icGZfa2Z1bmMgdm9pZCBicGZfaXRlcl9kZW50cnlfZGVzdHJveShzdHJ1Y3QgYnBm
X2l0ZXJfZGVudHJ5ICppdCkNCit7DQorICAgICAgIHN0cnVjdCBicGZfaXRlcl9kZW50cnlfa2Vy
biAqa2l0ID0gKHZvaWQqKWl0Ow0KKw0KKyAgICAgICBwYXRoX3B1dCgma2l0LT5wYXRoKTsNCit9
DQorDQorX19icGZfa2Z1bmNfZW5kX2RlZnMoKTsNCisNCiBCVEZfS0ZVTkNTX1NUQVJUKGJwZl9m
c19rZnVuY19zZXRfaWRzKQ0KIEJURl9JRF9GTEFHUyhmdW5jLCBicGZfZ2V0X3Rhc2tfZXhlX2Zp
bGUsDQogICAgICAgICAgICAgS0ZfQUNRVUlSRSB8IEtGX1RSVVNURURfQVJHUyB8IEtGX1JFVF9O
VUxMKQ0KIEJURl9JRF9GTEFHUyhmdW5jLCBicGZfcHV0X2ZpbGUsIEtGX1JFTEVBU0UpDQogQlRG
X0lEX0ZMQUdTKGZ1bmMsIGJwZl9wYXRoX2RfcGF0aCwgS0ZfVFJVU1RFRF9BUkdTKQ0KLUJURl9J
RF9GTEFHUyhmdW5jLCBicGZfZ2V0X2RlbnRyeV94YXR0ciwgS0ZfU0xFRVBBQkxFIHwgS0ZfVFJV
U1RFRF9BUkdTKQ0KK0JURl9JRF9GTEFHUyhmdW5jLCBicGZfZ2V0X2RlbnRyeV94YXR0ciwgS0Zf
U0xFRVBBQkxFKSAgICAvKiBXaWxsIGZpeCB0aGlzIGxhdGVyICovDQogQlRGX0lEX0ZMQUdTKGZ1
bmMsIGJwZl9nZXRfZmlsZV94YXR0ciwgS0ZfU0xFRVBBQkxFIHwgS0ZfVFJVU1RFRF9BUkdTKQ0K
K0JURl9JRF9GTEFHUyhmdW5jLCBicGZfaXRlcl9kZW50cnlfbmV3LCBLRl9JVEVSX05FVyB8IEtG
X1RSVVNURURfQVJHUykNCitCVEZfSURfRkxBR1MoZnVuYywgYnBmX2l0ZXJfZGVudHJ5X25leHQs
IEtGX0lURVJfTkVYVCB8IEtGX1JFVF9OVUxMKQ0KK0JURl9JRF9GTEFHUyhmdW5jLCBicGZfaXRl
cl9kZW50cnlfZGVzdHJveSwgS0ZfSVRFUl9ERVNUUk9ZKQ0KIEJURl9LRlVOQ1NfRU5EKGJwZl9m
c19rZnVuY19zZXRfaWRzKQ0KDQogc3RhdGljIGludCBicGZfZnNfa2Z1bmNzX2ZpbHRlcihjb25z
dCBzdHJ1Y3QgYnBmX3Byb2cgKnByb2csIHUzMiBrZnVuY19pZCkNCg0KDQo=


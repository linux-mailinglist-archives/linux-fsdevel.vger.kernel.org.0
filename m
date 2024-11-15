Return-Path: <linux-fsdevel+bounces-34989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E766D9CF691
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 22:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63521B26AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E2F1E2315;
	Fri, 15 Nov 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="d7cSSLc7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429E12F585;
	Fri, 15 Nov 2024 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704738; cv=fail; b=RO3SnB7NmhKfZ63l7zpzIxfDRg0WsYZsBFWj5fC6q7N4GLO4OB4tZsp4zCMaIdZb+ySnjq5lY5Nkk/L0JSfaD5ADJjzn0nbV0VrF96g/NM3xh8D6URGgadBu/yuE3+y4vWcjw+t7f9WFc6rKoGefPi8TskbaypQ6DKlRa70J+aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704738; c=relaxed/simple;
	bh=lm7TeXkhMc05SjOk+OR7PxWDnnCGZ60x6Npz8AoZLX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eCb6Q8Dt09/f1O3GS6jwM9d8jMSIqZpqyewfTkMtDY1J5nqXYnayjRbt+MUTzSeQYJ0SuZR+l+CuSN55Mn1gGIsyZqhE1welyZZnUt8fWhDpreo3HNOX68/Ft5ubF2wmwvFwrpj82/3K/1KJX1wTvaxhYNf64fvlK9LdyGi4jkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=d7cSSLc7; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AFKMb9G014869;
	Fri, 15 Nov 2024 13:05:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=lm7TeXkhMc05SjOk+OR7PxWDnnCGZ60x6Npz8AoZLX0=; b=
	d7cSSLc7jxifd0wLRON7qOyLHTw2KauC6Vxx7czRAyF93FZFjrbn96wRdS5JpVNZ
	+boWzZBgjqqG2S69LRchktCfR8hxZREeMSdLoUvxoiqFEE/o6+rEcE9JUS4HqFO+
	1aDGOY1juUzDS2gstTZg/Zi0F2iq5H80MRcujSo6Ifb1wSRFr0GVN7TfOd44OVRG
	a3fWzigJ7m/xG8bsETeLoMmAmY0qpjEnGtKfLr5Bx/cGD7kFG9yeLM04Xt9rA75G
	JyALY3ZdJvpqCkwgWwI47yqT57nZ9KR1wPtqJba8gn+CMp0Cv4DzC6+N6UBUdPZN
	HQT9K/4A2zRJlbxZjcOSOQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by m0001303.ppops.net (PPS) with ESMTPS id 42x4pkm44m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 13:05:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfYbAHh7DcGHPkuemaU3iw7aPs51lOO+XfQ/T9liB0Xys8mqujwDH+kWWCPbL/0NFFdUEhaqI8e3ortwzJ77IVtQjUGYzqoBscVwkzuL0bPizV0PjZAdEdlxWijsanSYkdC2yAk4SglW1jx0QsxLKcYC8TeSvvTX4aHJI5AXtCOmYbzeYYpCk/eUFxB/UsyolPQIq4icm8FCjHqy1DRgyRgTBs1ZodREhlXBtMUaz8zHvJ0lCp4hcr2ADvg+nADrd19GO4Smjq2EP4uVcJMloAUT+19X+GqyzoZG6vmd1RQ3BAcM+2Qa7C4iYdBp/TuyeY6WapYmoZ/1eC/Yb+93KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm7TeXkhMc05SjOk+OR7PxWDnnCGZ60x6Npz8AoZLX0=;
 b=ungEqgtIlBFOw3ujLASJgmuqkwyKlQjAH6+AzmUaxpkpUB7g3aPX5vSgkUfCtICMclsyn+1hHw9Nj1m9SHcxSwk23WIeHHmoESRl/PNiC5p1LpTsc7d7aWoBQCSkDz4DV888WJjunqQYDR7fMHLjd4cRSQ+Ma+n5jj+ggLlVwG25v6zhBRiuqt3a+jXtrK+n8+J9dusZE4gn4J7QSnnYMzT9uVs6Cqn5i1VeIyGq8oqO/rNucOUyTgfqxSEVCUai8x7mS4Sc4cdojqoQegj/zIBjJGH5uH+LOm/8gSByhmezcyvvsk4m6RzRVpY/XyD7Usi5otNJAfwON83Kd8wfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BLAPR15MB4019.namprd15.prod.outlook.com (2603:10b6:208:274::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 21:05:31 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 21:05:31 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Amir
 Goldstein <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        Jeff
 Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        "gnoack@google.com"
	<gnoack@google.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
Thread-Topic: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
Thread-Index:
 AQHbNnGAryo3J6mFf0ePhnT/vr0UcrK3NqIAgAAvFgCAABuhgIAACBOAgAAGAICAAFv2AIAA1H4AgAAXZQA=
Date: Fri, 15 Nov 2024 21:05:31 +0000
Message-ID: <968F7C58-691D-4636-AA91-D0EA999EE3FD@fb.com>
References: <20241114084345.1564165-1-song@kernel.org>
 <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
 <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com>
 <CAADnVQJ1um9u4cBpAEw83CS8xZJN=iP8WXdG0Ops5oTP-_NDFg@mail.gmail.com>
 <DCE25AB7-E337-4E11-9D57-2880F822BF33@fb.com>
 <CAADnVQ+bRO+UakzouzR5OfmvJAcyOs7VqCJKiLsjnfW1xkPZOg@mail.gmail.com>
 <C7C15985-2560-4D52-ADF9-C7680AF10E90@fb.com>
 <CAADnVQK2mhS0RLN7fEpn=zuLMT0D=QFMuibLAvc42Td0eU=eaQ@mail.gmail.com>
In-Reply-To:
 <CAADnVQK2mhS0RLN7fEpn=zuLMT0D=QFMuibLAvc42Td0eU=eaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BLAPR15MB4019:EE_
x-ms-office365-filtering-correlation-id: 2a21ca3f-2b23-4a3a-3840-08dd05b93db0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEtjOEIxVHNVcjZSVStPVVN2Ym5aTDY1MXROY3paTTRVZWZKNDhzVlp2c0Zo?=
 =?utf-8?B?MFl1eWtpVDczNXZKRDBQRExtTm0zZksrRy9tWHdBbmdvOXl3QTlUcVhsVUM4?=
 =?utf-8?B?eFU5UHN1Y1ozRERyaldsbFpIU1h0NWlYQTNrTnJWcXNmUURVMWt6UGZLdE1p?=
 =?utf-8?B?cEFtT2tGM2xtRlRlTGx1ZmYxMWJUZGIzWlBnWWEzNFlkeVdYcTlhU09kZ2Vk?=
 =?utf-8?B?WHBQSHA5bnBXUFhnZmROOEJxcWJiVldCTHRKNi9LWWQ0U0QvbW1TZi9LSHVn?=
 =?utf-8?B?SytJZUJQOTRvdGhUYjFTVWZvUVZPQ3JaaGVudDdtNGdSckNjNjRkdW1uSDlN?=
 =?utf-8?B?Y3hXVGhHbG5jQTZmWG53bnphWmlCY1Y3RmhXR3VqTjgyRC9ac2ZEUlpaMU9H?=
 =?utf-8?B?TGJKMW44YzlNVGZuVCtIR1BRSVVWMUJSSDhkQUhsSXZvcnFtaEFpVk9WQm9v?=
 =?utf-8?B?SXF6S1l2cDhZaXptRkhCMWQ4eUlldnp5bEJlQXNyRnhReDk1MWM2MHI0blVL?=
 =?utf-8?B?WC9jbFpWaVI2MFB0VW1oWFEvMGt5aUVESWIzN1Q4Mi9CN3VYYlNYakdvRjAw?=
 =?utf-8?B?cWFhQlp0alpIMlFNenFwSEZKR01EOFp4azIzNk8zT05OV1gxcERuZ3FQVWg4?=
 =?utf-8?B?eDJsd3NKbW10NmdxZ09VM1l5c3ZHbGw4dGpicTZSbHFYcXpVRWVuQTVHQXRz?=
 =?utf-8?B?dXpOTkNCUDZKTkxIN0c2RE9LS0tBYi9tM3FPRUtmRjdUcW9GNk1IY2ZFQ0dQ?=
 =?utf-8?B?aFptU1NqQ3RZRHlLdUFEK1hWVFBCR1BMb0ZPQUd2ajExeUw1cy9nTEJDdWt3?=
 =?utf-8?B?M0ZoaHVvQXN5OWVpcjIxVkZxUVZXR01LWEQ5bXVlZnpOQWR2Tlg2TmorMHc3?=
 =?utf-8?B?MC83OWpiNGJHdzgrdHBaM1hpcThuU2VxRE11akdqUzNKTmYwMFEzZXhlNGpw?=
 =?utf-8?B?cWU5WVVaOXVvM09LR0J4REZOaTBHTG1OVi9VNDEyVlE2ZkZKdmQ0MHlSTmJL?=
 =?utf-8?B?Z0g0QzJ6cUZCRG8xSmpEcFdsTlpkdWxDRStxbkdDeDA3OU8ybjhZVGpHc2dJ?=
 =?utf-8?B?SFBqUHk4UU9YM0FBeFMrK1dVZXhSWVBLb3U5YlF6SGRIcG1tUU0wTVBjV2hV?=
 =?utf-8?B?VnhoOUFBeHoxTDYyaDA0eW5TYlVTTDlremxJSXBwYm9GaEw2TWdyaXFaaTcy?=
 =?utf-8?B?RVhydXVzM2xVWW5FZ0FIRDFmQnM3MXEvZVQ4Sm12R2NMNmxmc21sYklRQi9I?=
 =?utf-8?B?akhwdUp6b2ovRkhiUlBGeVFuajZScFJmcmdtZHd0K0NIdm50Q0NRVXpLVm9F?=
 =?utf-8?B?SEdTVFliM3V5dVRoVGVWOG9SWkpmQldLZkd2M0xyYmVTaG1TeU8wYnRpR3BM?=
 =?utf-8?B?TGhBdFJ6bkVSVTg4bTJLTTEzeEdGaFZjZTVvdkZKYnl6OC9oZE1BSS82a2Zs?=
 =?utf-8?B?M0ozSXJDRTJsVy9rS2tBaEdBMkM5RWpDcFhmU2JDTTJHc3BhbzV2dUxFZnUz?=
 =?utf-8?B?MWZLVDdGRnIwSzREZzVRSGZ2WjdXSlkvYjJKNnAvVWVHZU0yTlRsOXVtNmQ5?=
 =?utf-8?B?WWpxQXZTblBUaFR4TTZ1NGdMTWptU3MwbUtSVjVka2tPY1Y3RmxhVVg5ZDhk?=
 =?utf-8?B?SlBTZHd6V3hFWVdGOU5oYWRrVnVYaDNPM2pXczlCTHN0WTZDVWl2SXFrM0U2?=
 =?utf-8?B?Y08zRlZmTnBxYjhNQVFKeXFlY0p2MG85UHkzZ3hIQlhXUnFTaUdXRnZTM1o1?=
 =?utf-8?Q?vyxPisz2LvntdGuSc5Ol9htNf1lGui7WZCm55EI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0tGa3ZObGI0M1hxRHJPT2NsQ2p2ZDU3Qk5JcDdvbjllVGQrYUZlKzhNZG9L?=
 =?utf-8?B?M0hDai8vam81TlhQWEIxWTFTcjk5emFXMDBobkRtMDF3cUY4YnpLSFdHZXh0?=
 =?utf-8?B?VEJ4VGQwbGpBb3Vqam9RMmRHa0xBMm1JL012QmdmNUpoVkcydEEzdGZNTmZh?=
 =?utf-8?B?S3lERXBSZ2dnaVBHUGU3TnRHUE56WmoxTjRMbWlNZmFmRklNSG8zUDZqT3ZW?=
 =?utf-8?B?WHBSZnFNZEZlSHZUMjFFSTlBQ3cvUlBYS1Jtb2ZoSWQ3R3diUGswQmVZNzQx?=
 =?utf-8?B?ajU3SE9mTHBNaWVRa2daV0NrZXExNDZZRmF5bUV6Sm1EVTZaOFY2cXU1ZHUx?=
 =?utf-8?B?am5QMm9OTWNQSExiMDcvWWI1VUdWcmhFNHIycStEQ0xjMkVCYytaaUF5NWcr?=
 =?utf-8?B?dmpza3dPNVdkVElNNndBOG01YmUwK3lwWUdLT3d1alROeVJGYXIwU3dXcE1H?=
 =?utf-8?B?ZSs1N1dVdTF5UFJ5MEZLUFBWem5RUUtNcERSbG13ZGdienRYV1p0Z2dnTm1X?=
 =?utf-8?B?Y1NMWWJKOUJ0d1RNbm4vTnpaYVFpK3VhR1hYcUdBczl5OGU2UWo5cWMxVUZY?=
 =?utf-8?B?b00yajRneEJ3TUl2MUk5c0RzUnV6YS8rTXFndlQvdks2UGZHZ2FFNlJaSTlI?=
 =?utf-8?B?eFE0UzZHNk1weThtQlBIMTlQNGduZHNwcXZuTVpENWRPYmR6bkR1NUhUam1n?=
 =?utf-8?B?YnZZTEFrdy9iMWM4bTVBN20wWGpEZjBrOWFETUtYaWtNR3c0NjZEa0poMHNR?=
 =?utf-8?B?blpMbnpUNGoxWUFEOERmb2F4cVVKdzFXVDlLem0xTnd3a3c2dGJ0VENxT0gw?=
 =?utf-8?B?cWxoZkhwTWhLUVZUZXZXbGQ2WUFscmFyZ1ZVNFBvbkZ3VzU0K2VJT3VucU54?=
 =?utf-8?B?Y3NzSHJINTNQQmFEekFPNmlNSzRxY01vdWc0Nk9UT3lXMDFtWFZKeE1pS1Fl?=
 =?utf-8?B?SjFvMXlKYzJsSGVRRi90VGdoYzUrRW5zK001UU5hYTVhVHA5N1Y0cjQ5bDBM?=
 =?utf-8?B?MTBxSDlmaS9reHhmamVWUW9aUXhCZmhkdHhXOEZ3TVZWLzhXdURtYzJDVEdO?=
 =?utf-8?B?amptZU9aeEloTUkrdFBTMUQzUk5hTzZLcGVqVkJLY2tXcjdraFhIMWd3YmZz?=
 =?utf-8?B?NG5RWHdwV3ZYQVVLNWl3cHRKUkVRZkg0dGNDcytaQlRybFNsbURTWENVa0RJ?=
 =?utf-8?B?UUxtSStqMlVyNENLU3NmOGVoQmRRcmRqazRzV3pIUEJYS01RSXVaZTlpNkRv?=
 =?utf-8?B?VUNvTWNWVHc2cFRYRzVKWm92eThucmE2UFd3LzUwUjF2QitOWVRVOWhNVFRn?=
 =?utf-8?B?bTd5c00rYllvM0VXSm1YVmlTUFM2VWZQTTYrZFFHaFFabytQMm9EcVJQb2c5?=
 =?utf-8?B?M1N6Mm5NdUgxNVpYV0NwMmczYU8vT0czZDBOdHRWMWxMRzR1RldpL05CN1dF?=
 =?utf-8?B?UGxJSGFkTUxZUm15eWQzL3pPZHNReW9zdlNNVFZYTXpISWYrVzVPRlVMNmRr?=
 =?utf-8?B?U0dOR1RMelUxVUw3TFV2UnF4WkNmdlJwb2NYZXVRRS9nYXlpSXhPM283SCtH?=
 =?utf-8?B?d1RZSjNkK3A2Q1Y0b3dBOTFQcW54ZElMVTN1ZGJrTUxlSVJjY0w4MzNvM0xx?=
 =?utf-8?B?akNmNHVyY3FzdWphb3ZLS2VQNTJRTkVWVXBmWmp4cGw2REUzelVaQm9sUGpJ?=
 =?utf-8?B?REkraExkRFdlbXlVV2ZmMnNGUVN0UkFpb3R2YThUbkQ0QVhsM2pYeE44TXJn?=
 =?utf-8?B?d1hiSnREL3NYUi9vNlM2aFJaL0xWQ1IzRDBtWktKZVRCS2RWcHp2M25GRHNl?=
 =?utf-8?B?cU85VjIwV09XSURCMmZyTitWM0EweGVjV1gybXJsUjhpNXFjbFpzNExKS2xv?=
 =?utf-8?B?K3dLVnBOM09zY2liMWRvb01UWW95NFRNMGJHYjdyc1M0dlhvRjZ5OFlza3Fm?=
 =?utf-8?B?eVNTZTd1MlZxU1VCWW1xQnl6VExDcGgvd2VSaHJFTGozcW1FLy9rYXBiNUdK?=
 =?utf-8?B?RFQ5cFBacjZseVgwOW9uaHI0OENiNERkTlBSUjNUeUhJUXR2SWVxQWVBMG9x?=
 =?utf-8?B?VUdrcGk4QVRIRUVRVWx5Um8vb3htSVlPQms0SGFXOE5BMkY3aXM1Kzk4bFc0?=
 =?utf-8?B?VUVsU215MEFnQy82YnFNNE03azY2UDd3NkdCK3M5VUpzSjZ6RVR3c3FYN2VD?=
 =?utf-8?Q?CwK/czxClFazPHmXuAJ1LXw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <982136111313284495C47790CEE71EF4@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a21ca3f-2b23-4a3a-3840-08dd05b93db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 21:05:31.7981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jj3P1OF9QSNxbwg7klo/kM9IgsetuqAMntq/LE/ZQGaTHbi6VIANNesicxy1BSrC0NpA7Bytic9q38SsHqRgcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4019
X-Proofpoint-ORIG-GUID: L6DcXOiPmUWucWbqXFIg6nuuWpSdJUdb
X-Proofpoint-GUID: L6DcXOiPmUWucWbqXFIg6nuuWpSdJUdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDE1LCAyMDI0LCBhdCAxMTo0MeKAr0FNLCBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBOb3Yg
MTQsIDIwMjQgYXQgMTE6MDHigK9QTSBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAbWV0YS5jb20+
IHdyb3RlOg0KPj4gDQo+Pj4gDQo+Pj4gSSB0aGluayBicGYtbHNtIGhvb2sgZmlyZXMgYmVmb3Jl
IGZhbm90aWZ5LCBzbyBicGYtbHNtIHByb2cNCj4+PiBpbXBsZW1lbnRpbmcgc29tZSBzZWN1cml0
eSBwb2xpY3kgaGFzIHRvIGRlY2lkZSByaWdodA0KPj4+IGF0IHRoZSBtb21lbnQgd2hhdCB0byBk
byB3aXRoLCBzYXksIHNlY3VyaXR5X2ZpbGVfb3BlbigpLg0KPj4+IGZhbm90aWZ5IHdpdGggb3Ig
d2l0aG91dCBicGYgZmFzdHBhdGggaXMgdG9vIGxhdGUuDQo+PiANCj4+IEFjdHVhbGx5LCBmYW5v
dGlmeSBpbiBwZXJtaXNzaW9uIG1vZGUgY2FuIHN0b3AgYSBmaWxlIG9wZW4uDQo+IA0KPiBUaGUg
cHJvcG9zZWQgcGF0Y2ggMSBkaWQ6DQo+IA0KPiArLyogUmV0dXJuIHZhbHVlIG9mIGZwX2hhbmRs
ZXIgKi8NCj4gK2VudW0gZmFub3RpZnlfZmFzdHBhdGhfcmV0dXJuIHsNCj4gKyAvKiBUaGUgZXZl
bnQgc2hvdWxkIGJlIHNlbnQgdG8gdXNlciBzcGFjZSAqLw0KPiArIEZBTl9GUF9SRVRfU0VORF9U
T19VU0VSU1BBQ0UgPSAwLA0KPiArIC8qIFRoZSBldmVudCBzaG91bGQgTk9UIGJlIHNlbnQgdG8g
dXNlciBzcGFjZSAqLw0KPiArIEZBTl9GUF9SRVRfU0tJUF9FVkVOVCA9IDEsDQo+ICt9Ow0KPiAN
Cj4gSXQgbG9va2VkIGxpa2UgYSByZWFkLW9ubHkgbm90aWZpY2F0aW9uIHRvIHVzZXIgc3BhY2UN
Cj4gd2hlcmUgYnBmIHByb2cgaXMgbWVyZWx5IGEgZmlsdGVyLg0KDQpZZXAuIEFzIEFtaXIgYWxz
byBwb2ludGVkIG91dCwgdGhpcyBwYXJ0IG5lZWRzIG1vcmUgd29yayBhbmQNCmNsYXJpZmljYXRp
b25zLiANCg0KPiANCj4+IEluIGN1cnJlbnQgdXBzdHJlYW0gY29kZSwgZnNub3RpZnkgaG9vayBm
c25vdGlmeV9vcGVuX3Blcm0NCj4+IGlzIGFjdHVhbGx5IHBhcnQgb2Ygc2VjdXJpdHlfZmlsZV9v
cGVuKCkuIEl0IHdpbGwgYmUgbW92ZWQNCj4+IHRvIGRvX2RlbnRyeV9vcGVuKCksIHJpZ2h0IGFm
dGVyIHNlY3VyaXR5X2ZpbGVfb3BlbigpLiBUaGlzDQo+PiBtb3ZlIGlzIGRvbmUgYnkgMWNkYTUy
ZjFiNDYxIGluIGxpbnV4LW5leHQuDQo+IA0KPiBTZXBhcmF0aW5nIGZzbm90aWZ5IGZyb20gTFNN
IG1ha2VzIHNlbnNlLg0KPiANCj4+IEluIHByYWN0aWNlLCB3ZSBhcmUgbm90IGxpa2VseSB0byB1
c2UgQlBGIExTTSBhbmQgZmFub3RpZnkNCj4+IG9uIHRoZSBzYW1lIGhvb2sgYXQgdGhlIHNhbWUg
dGltZS4gSW5zdGVhZCwgd2UgY2FuIHVzZQ0KPj4gQlBGIExTTSBob29rcyB0byBnYXRoZXIgaW5m
b3JtYXRpb24gYW5kIHVzZSBmYW5vdGlmeSB0bw0KPj4gbWFrZSBhbGxvdy9kZW55IGRlY2lzaW9u
LCBvciB2aWNlIHZlcnNhLg0KPiANCj4gUGljayBvbmUuDQo+IElmIHRoZSBwcm9wb3NhbCBpcyBj
aGFuZ2luZyB0byBsZXQgZnNub3RpZnktYnBmIHByb2cgdG8gZGVueQ0KPiBmaWxlX29wZW4gdGhl
biBpdCdzIGEgY29tcGxldGVseSBkaWZmZXJlbnQgZGlzY3Vzc2lvbi4NCj4gDQo+IEluIHN1Y2gg
YSBjYXNlIG1ha2UgaXQgY2xlYXIgdXBmcm9udCB0aGF0IGZzbm90aWZ5IHdpbGwNCj4gcmVseSBv
biBDT05GSUdfRkFOT1RJRllfQUNDRVNTX1BFUk1JU1NJT05TIGFuZA0KDQpJIGFtIG5vdCBzdXJl
IHdoZXRoZXIgd2Ugc2hvdWxkIGxpbWl0IGZzbm90aWZ5LWJwZiB0byANCm9ubHkgd29yayB3aXRo
IENPTkZJR19GQU5PVElGWV9BQ0NFU1NfUEVSTUlTU0lPTlMuIEkgc3RpbGwgDQp0aGluayBpdCBj
YW4gYmUgdXNlZnVsIGp1c3QgYXMgYSBmaWx0ZXIuIEJ1dCBJIGd1ZXNzIHdlIGNhbg0Kc3RhcnQg
d2l0aCB0aGlzIGRlcGVuZGVuY3kuIA0KDQo+IGJwZi1sc20gcGFydCBvZiBmaWxlIGFjY2VzcyB3
aWxsIG5vdCBiZSB1c2VkLA0KPiBzaW5jZSBpbnRlcmFjdGlvbiBvZiB0d28gY2FsbGJhY2tzIGF0
IGZpbGVfb3BlbiBtYWtlcyBsaXR0bGUgc2Vuc2UuDQoNCkFncmVlZCB0aGF0IGhhdmluZyB0d28g
aG9va3Mgb24gZmlsZV9vcGVuIGRvZXNuJ3QgbWFrZSBzZW5zZS4gDQpJIHdhcyBhY3R1YWxseSB0
aGlua2luZyBhYm91dCBjb21iaW5pbmcgZnNub3RpZnktYnBmIHdpdGggDQpvdGhlciBMU00gaG9v
a3MuIEJ1dCBJIGFncmVlIHdlIHNob3VsZCBzdGFydCBhcyBzaW1wbGUgYXMNCnBvc3NpYmxlLiAN
Cg0KPiANCj4+PiBJbiBnZW5lcmFsIGZhbm90aWZ5IGlzIG5vdCBmb3Igc2VjdXJpdHkuIEl0J3Mg
bm90aWZ5aW5nDQo+Pj4gdXNlciBzcGFjZSBvZiBldmVudHMgdGhhdCBhbHJlYWR5IGhhcHBlbmVk
LCBzbyBJIGRvbid0IHNlZQ0KPj4+IGhvdyB0aGVzZSB0d28gY2FuIGJlIGNvbWJpbmVkLg0KPj4g
DQo+PiBmYW5vdGlmeSBpcyBhY3R1YWxseSB1c2VkIGJ5IEFudGlWaXJ1cyBzb2Z0d2FyZXMuIEZv
cg0KPj4gZXhhbXBsZSwgQ2FsbUFWIChodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly93d3cuY2xhbWF2Lm5ldC9fXzshIUJ0OFJaVW05YXchNHA3SkJfRThSdU5MbGR6X1RZUjA3am5X
NWtIYnI0SDJGTW05dkxiU2hLT0JNem5Yd0VTN0RsdDVfUjZCXy1ITXpnVjNRa185V0tsaG1qSFNw
WUhSaFRiMldNM2hJZyQgKSB1c2VzIGZhbm90aWZ5DQo+PiBmb3IgaXRzIExpbnV4IHZlcnNpb24g
KGl0IGFsc28gc3VwcG9ydHMgV2luZG93IGFuZCBNYWNPUykuDQo+IA0KPiBJdCdzIHJlbHlpbmcg
b24gdXNlciBzcGFjZSB0byBzZW5kIGJhY2sgRkFOT1RJRllfUEVSTV9FVkVOVFMgPw0KDQpZZXMs
IGl0IGdvZXMgYWxsIHRoZSB3YXkgdG8gYW5vdGhlciBwcm9jZXNzLCBhbmQgY29tZXMgYmFjay4g
DQoNCj4gDQo+IGZzbm90aWZ5X29wZW5fcGVybS0+ZnNub3RpZnktPnNlbmRfdG9fZ3JvdXAtPmZh
bm90aWZ5X2hhbmRsZV9ldmVudC4NCj4gDQo+IGlzIGEgcHJldHR5IGxvbmcgcGF0aCB0byBjYWxs
IGJwZiBwcm9nIGFuZA0KPiBwcmVwYXJpbmcgYSBnaWFudCAnc3RydWN0IGZhbm90aWZ5X2Zhc3Rw
YXRoX2V2ZW50Jw0KPiBpcyBub3QgZ29pbmcgdG8gZmFzdCBlaXRoZXIuDQo+IA0KPiBJZiB3ZSB3
YW50IHRvIGFjY2VsZXJhdGUgdGhhdCB3aXRoIGJwZiBpdCBuZWVkcyB0byBiZSBkb25lDQo+IHNv
b25lciB3aXRoIG5lZ2xpZ2libGUgb3ZlcmhlYWQuDQoNCkFncmVlZC4gVGhpcyBpcyBhY3R1YWxs
eSBzb21ldGhpbmcgSSBoYXZlIGJlZW4gdGhpbmtpbmcgDQpzaW5jZSB0aGUgYmVnaW5uaW5nIG9m
IHRoaXMgd29yazogU2hhbGwgaXQgYmUgZmFub3RpZnktYnBmIA0Kb3IgZnNub3RpZnktYnBmLiBH
aXZlbiB3ZSBoYXZlIG1vcmUgbWF0ZXJpYWxzLCB0aGlzIGlzIGEgDQpnb29kIHRpbWUgdG8gaGF2
ZSBicm9hZGVyIGRpc2N1c3Npb25zIG9uIHRoaXMuIA0KDQpAYWxsLCBwbGVhc2UgY2hpbWUgaW4g
d2hldGhlciB3ZSBzaG91bGQgcmVkbyB0aGlzIGFzDQpmc25vdGlmeS1icGYuIEFGQUlDVDoNCg0K
UHJvcyBvZiBmYW5vdGlmeS1icGY6IA0KLSBUaGVyZSBpcyBleGlzdGluZyB1c2VyIHNwYWNlIHRo
YXQgd2UgY2FuIGxldmVyYWdlL3JldXNlLg0KDQpQcm9zIG9mIGZzbm90aWZ5LWJwZjogDQotIEZh
c3RlciBmYXN0IHBhdGguIA0KDQpBbm90aGVyIG1ham9yIHByb3MvY29ucyBkaWQgSSBtaXNzPw0K
DQo+IA0KPj4gSSBndWVzcyBJIGRpZG4ndCBzdGF0ZSB0aGUgbW90aXZhdGlvbiBjbGVhcmx5LiBT
byBsZXQgbWUNCj4+IHRyeSBpdCBub3cuDQo+PiANCj4+IFRyYWNpbmcgaXMgYSBjcml0aWNhbCBw
YXJ0IG9mIGEgc2VjdXJpdHkgc29sdXRpb24uIFdpdGgNCj4+IExTTSwgYmxvY2tpbmcgYW4gb3Bl
cmF0aW9uIGlzIHN0cmFpZ2h0Zm9yd2FyZC4gSG93ZXZlciwNCj4+IGtub3dpbmcgd2hpY2ggb3Bl
cmF0aW9uIHNob3VsZCBiZSBibG9ja2VkIGlzIG5vdCBhbHdheXMNCj4+IGVhc3kuIEFsc28sIHNl
Y3VyaXR5IGhvb2tzIChMU00gb3IgZmFub3RpZnkpIHNpdCBpbiB0aGUNCj4+IGNyaXRpY2FsIHBh
dGggb2YgdXNlciByZXF1ZXN0cy4gSXQgaXMgdmVyeSBpbXBvcnRhbnQgdG8NCj4+IG9wdGltaXpl
IHRoZSBsYXRlbmN5IG9mIGEgc2VjdXJpdHkgaG9vay4gSWRlYWxseSwgdGhlDQo+PiB0cmFjaW5n
IGxvZ2ljIHNob3VsZCBnYXRoZXIgYWxsIHRoZSBpbmZvcm1hdGlvbiBhaGVhZA0KPj4gb2YgdGlt
ZSwgYW5kIG1ha2UgdGhlIGFjdHVhbCBob29rIGZhc3QuDQo+PiANCj4+IEZvciBleGFtcGxlLCBp
ZiBzZWN1cml0eV9maWxlX29wZW4oKSBvbmx5IG5lZWRzIHRvIHJlYWQNCj4+IGEgZmxhZyBmcm9t
IGlub2RlIGxvY2FsIHN0b3JhZ2UsIHRoZSBvdmVyaGVhZCBpcyBtaW5pbWFsDQo+PiBhbmQgcHJl
ZGljdGFibGUuIElmIHNlY3VyaXR5X2ZpbGVfb3BlbigpIGhhcyB0byB3YWxrIHRoZQ0KPj4gZGVu
dHJ5IHRyZWUsIG9yIGNhbGwgZF9wYXRoKCksIHRoZSBvdmVyaGVhZCB3aWxsIGJlDQo+PiBtdWNo
IGhpZ2hlci4gZmFub3RpZnlfZmlsZV9wZXJtKCkgcHJvdmlkZXMgYW5vdGhlcg0KPj4gbGV2ZWwg
b2Ygb3B0aW1pemF0aW9uIG92ZXIgc2VjdXJpdHlfZmlsZV9vcGVuKCkuIElmIGENCj4+IGZpbGUg
aXMgbm90IGJlaW5nIG1vbml0b3JlZCwgZmFub3RpZnkgd2lsbCBub3QgZ2VuZXJhdGUNCj4+IHRo
ZSBldmVudC4NCj4gDQo+IEkgYWdyZWUgd2l0aCBtb3RpdmF0aW9uLCBidXQgZG9uJ3Qgc2VlIHRo
aXMgaW4gdGhlIHBhdGNoZXMuDQoNCkFncmVlZC4gSSBzaG91bGQgZGVmaW5pdGVseSBkbyBiZXR0
ZXIgam9iIGluIHRoaXMuIA0KDQo+IFRoZSBvdmVyaGVhZCB0byBjYWxsIGludG8gYnBmIHByb2cg
aXMgYmlnLg0KPiBFdmVuIGlmIHByb2cgZG9lcyBub3RoaW5nIGl0J3Mgc3RpbGwgZ29pbmcgdG8g
YmUgc2xvd2VyLg0KPiANCj4+IFNlY3VyaXR5IHNvbHV0aW9ucyBob2xkIGhpZ2hlciBiYXJzIGZv
ciB0aGUgdHJhY2luZyBsb2dpYzoNCj4+IA0KPj4gLSBJdCBuZWVkcyB0byBiZSBhY2N1cmF0ZSwg
YXMgZmFsc2UgcG9zaXRpdmVzIGFuZCBmYWxzZQ0KPj4gIG5lZ2F0aXZlcyBjYW4gYmUgdmVyeSBh
bm5veWluZyBhbmQvb3IgaGFybWZ1bC4NCj4+IC0gSXQgbmVlZHMgdG8gYmUgZWZmaWNpZW50LCBh
cyBzZWN1cml0eSBkYWVtb25zIHJ1biAyNC83Lg0KPj4gDQo+PiBHaXZlbiB0aGVzZSByZXF1aXJl
bWVudHMgb2Ygc2VjdXJpdHkgc29sdXRpb25zLCBJIGJlbGlldmUNCj4+IGl0IGlzIGltcG9ydGFu
dCB0byBvcHRpbWl6ZSB0cmFjaW5nIGxvZ2ljIGFzIG11Y2ggYXMNCj4+IHBvc3NpYmxlLiBBbmQg
QlBGIGJhc2VkIGZhbm90aWZ5IGZhc3RwYXRoIGhhbmRsZXIgY2FuDQo+PiBicmluZyBub24tdHJp
dmlhbHMgYmVuZWZpdCB0byBCUEYgYmFzZWQgc2VjdXJpdHkgc29sdXRpb25zLg0KPiANCj4gRG9p
bmcgZXZlcnl0aGluZyBpbiB0aGUga2VybmVsIGlzIGNlcnRhaW5seSBmYXN0ZXIgdGhhbg0KPiBn
b2luZyBiYWNrIGFuZCBmb3J0aCB0byB1c2VyIHNwYWNlLA0KPiBidXQgYnBmLWxzbSBzaG91bGQg
YmUgYWJsZSB0byBkbyB0aGUgc2FtZSBhbHJlYWR5Lg0KPiANCj4gV2l0aG91dCBwYXRjaCAxIGFu
ZCBvbmx5IHBhdGNoZXMgNCw1IHRoYXQgYWRkIGZldyBrZnVuY3MsDQo+IGJwZi1sc20gcHJvZyB3
aWxsIGJlIGFibGUgdG8gcmVtZW1iZXIgc3VidHJlZSBkZW50cnkgYW5kDQo+IGRvIHRoZSBzYW1l
IGlzX3N1YmRpcigpIHRvIGRlbnkuDQo+IFRoZSBwYXRjaCA3IHN0YXlzIHByZXR0eSBtdWNoIGFz
LWlzLiBBbGwgaW4gYnBmLWxzbS4NCj4gQ2xvc2UgdG8gemVybyBvdmVyaGVhZCB3aXRob3V0IGxv
bmcgY2hhaW4gb2YgZnNub3RpZnkgY2FsbGJhY2tzLg0KDQpPbmUgb2YgdGhlIGFkdmFudGFnZXMg
b2YgZmFub3RpZnktYnBmIG9yIGZzbm90aWZ5LWJwZiBpcyANCnRoYXQgaXQgb25seSBjYWxscyB0
aGUgQlBGIHByb2dyYW0gZm9yIGJlaW5nIG1vbml0b3JlZA0KZmlsZXMuIE9UT0gsIEJQRiBMU00g
cHJvZ3JhbSBpcyBhbHdheXMgZ2xvYmFsLiANCg0KPiANCj4+IGZhbm90aWZ5IGFsc28gaGFzIGEg
ZmVhdHVyZSB0aGF0IExTTSBkb2Vzbid0IHByb3ZpZGUuDQo+PiBXaGVuIGEgZmlsZSBpcyBhY2Nl
c3NlZCwgdXNlciBzcGFjZSBkYWVtb24gY2FuIGdldCBhDQo+PiBmZCBvbiB0aGlzIGZpbGUgZnJv
bSBmYW5vdGlmeS4gT1RPSCwgTFNNIGNhbiBvbmx5IHNlbmQNCj4+IGFuIGlubyBvciBhIHBhdGgg
dG8gdXNlciBzcGFjZSwgd2hpY2ggaXMgbm90IGFsd2F5cw0KPj4gcmVsaWFibGUuDQo+IA0KPiBU
aGF0IHNvdW5kcyB1c2VmdWwsIGJ1dCB3ZSdyZSBtaXhpbmcgdG9vIG1hbnkgdGhpbmdzLg0KPiBJ
ZiB1c2VyIHNwYWNlIGNhcmVzIGFib3V0IGZkIGl0IHdpbGwgYmUgdXNpbmcgdGhlIGV4aXN0aW5n
DQo+IG1lY2hhbmlzbSB3aXRoIGFsbCBhY2NvbXBhbmllZCBvdmVyaGVhZC4gZnNub3RpZnktYnBm
IGNhbg0KPiBiYXJlbHkgYWNjZWxlcmF0ZSBhbnl0aGluZywgc2luY2UgdXNlciBzcGFjZSBtYWtl
cw0KPiB1bHRpbWF0ZSBkZWNpc2lvbnMuDQo+IElmIHVzZXIgc3BhY2UgaXMgbm90IGluIHRoZSBk
cml2aW5nIHNlYXQgdGhlbiBleGlzdGluZyBicGYtbHNtDQo+IHBsdXMgZmV3IGtmdW5jcyB0byBy
ZW1lbWJlciBkZW50cnkgYW5kIGNhbGwgaXNfc3ViZGlyKCkNCj4gd2lsbCBkbyB0aGUgam9iIGFu
ZCBubyBuZWVkIGZvciBwYXRjaCAxLg0KDQpJbiBtYW55IGNhc2VzLCB3ZSBvbmx5IG5lZWQgdGhl
IHVzZXIgc3BhY2UgdG8gbG9vayBpbnRvIA0KdGhlIGZpbGUgd2hlbiBuZWNlc3NhcnkuIEZvciBl
eGFtcGxlLCB3aGVuIGEgYmluYXJ5IGlzIA0KZmlyc3Qgd3JpdHRlbiwgdGhlIHVzZXIgc3BhY2Ug
ZGFlbW9uIHdpbGwgc2NhbiB0aHJvdWdoDQppdCAoZm9yIHZpcnVzLCBldGMuKSBhbmQgbWFyayBp
dCBhcyBzYWZlL2Rhbmdlcm91cyBpbiANCnNvbWUgQlBGIG1hcHMuIExhdGVyLCB3aGVuIHRoZSBm
aWxlIGlzIG9wZW5lZCBmb3IgDQpleGVjdXRpb24sIGZbc3xhXW5vdGlmeS1icGYgY2FuIG1ha2Ug
dGhlIGFsbG93L2RlbnkNCmRlY2lzaW9uIGJhc2VkIG9uIHRoZSBpbmZvcm1hdGlvbiBpbiBCUEYg
bWFwcy4gDQoNClRoYW5rcyBhZ2FpbiBmb3IgeW91ciByZXZpZXcgYW5kIGlucHV0cyENCg0KU29u
Zw0KDQoNCg0K


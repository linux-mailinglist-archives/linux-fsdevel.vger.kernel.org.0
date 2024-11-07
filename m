Return-Path: <linux-fsdevel+bounces-33947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6336C9C0EAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE70F1F27E79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBDA218336;
	Thu,  7 Nov 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BmK42F2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814E21766C;
	Thu,  7 Nov 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006817; cv=fail; b=n8d/DHiI68QZWkw43V7Qm3zsYOWdMFyZkVN8GE+lQ2eLpimHJXtcM5MYt4QQ7aYB3463aDkQtLsqDi29ShymRNhpLTBDV/InbRl+GF5zXHF8vGNqhR+yF4WPUVWl0rwLA5EiVas5ZEXAG5CyPOGb0BMAqVtWRNOC9pzeW7DmEjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006817; c=relaxed/simple;
	bh=/QPZUL9GWIBGn/5sLpO40oEN+syyaRB1Z+R6ws9W6x8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k2D2VD7jotX2xRXoq3KQh+v5w+C03a9gSpuwG2N+21zU0WlJlOlGkkgt8NxQhAFPp3fnOrVNq9XVca2knIuChVga9LzcEbVQScMqNProO0pyLvAVOzTIMnpZZy8onahQLcn9tTiPEGP3p8IuS8PevOdMPaXQ7RMIfQzfab8zook=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BmK42F2u; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImKaG029854;
	Thu, 7 Nov 2024 11:13:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=/QPZUL9GWIBGn/5sLpO40oEN+syyaRB1Z+R6ws9W6x8=; b=
	BmK42F2u/lBxkfpUby2vB5+OhZrWrt66QLrHGnp8+eimkSOps6quY9XV1lhIAHXM
	ciYGhZ+dB7XfwhtjAJPFLMxybu+ZzgilKgkZ2GbrtMGPBFjAmFxg9g2Wlacha2X2
	e0wva8ACyt+DTNz9N8VQZWclvGY3aCsxZYtBKp+Jex8oZy1qxSucYTAmWIzbYFYZ
	IuIicgHKU+Et0zVF6kSv62cvVGqGq4ef+nYpmCpNz5wytDlTaMMA4HgoK4M+Y0AM
	0GabWPKQB29HgIVD1vLE5Z3ZdJlDmtjIjf1GykPvj2dEJJZwDXCeS8NITQ4pmO6l
	FfLz4rFygwSGeGbvzBPG9Q==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by m0089730.ppops.net (PPS) with ESMTPS id 42s12w9dqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:13:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yN3nae73S7SSWnayzAiLwJTfwBkN4JNaGAT9GpLu3atIgWGQ8Qt6lyRJnwwyRs6jg5Kue7v/vFaov9Lc81YRNJN85TEufiDydQJtpDqgTXz+uA4dz1AqQ5X5xKPT6jisVOsfUGG7OWyXjOuvMU8aD5ZjJotTAjYPzsRy+MZHWTshlps+vpvZd6psCN02TOG8lyXDVppXCVfTHLfVbk6GpC36yjHvKuX2JfoeIlYmoYRrKmHnt+NXb5Q1+K5YHOYJjiyI3Sr9UJvrbf/dSvHjh/GrTsO/tGTKUq+Fevlrep5OQ/GqOrctiDP5E+3ARRRuyyVLa668HPCx1AVM1mUOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QPZUL9GWIBGn/5sLpO40oEN+syyaRB1Z+R6ws9W6x8=;
 b=JBiEVWzvxVJWBVdigtpOON/pwuH05Y2Lh2vsGBN40pg8y2mv/sbSE93LDKpKxwlN68LDy/8/i+jPmTBysR7HXQrzE0JXPFPndjh7HxlsZZXlkc9e/WRuQpM8BK01imDcDwvxVRt/KPF4HneGvmTNEEOG993AqWGuACB0Oz0Um8ZZZ6HueHwJHuvYoIBFivjThzmZ5W7TAiBIQEz+2mQ1xaVhFQ2j1BSyOeUmBHMPDGoEGcm2c0nSLY9zICDXR6k/XYmiCLEpfXWXb6xF3GlFdSxniba+3mRvv8rXzdztKCc70fnaP/SWW1IXO+2vrrS3nf9cBgzaBxURTWdPaanedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH3PR15MB6425.namprd15.prod.outlook.com (2603:10b6:610:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:13:23 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:13:23 +0000
From: Song Liu <songliubraving@meta.com>
To: Jan Kara <jack@suse.cz>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Al
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, KP
 Singh <kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Amir
 Goldstein <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 1/5] fanotify: Introduce fanotify fastpath
 handler
Thread-Topic: [RFC bpf-next fanotify 1/5] fanotify: Introduce fanotify
 fastpath handler
Thread-Index: AQHbKlgfXHE+wf5uf0Oyjn+H4c0Tg7KrsG+AgACNDgA=
Date: Thu, 7 Nov 2024 19:13:23 +0000
Message-ID: <AE6EEE9B-B84F-4097-859B-B4509F2B6AF8@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-2-song@kernel.org>
 <20241107104821.xpu45m3volgixour@quack3>
In-Reply-To: <20241107104821.xpu45m3volgixour@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH3PR15MB6425:EE_
x-ms-office365-filtering-correlation-id: 090cccda-9a83-473f-61b6-08dcff604010
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFRNZ1c5MWRQdER6dXR3UEV2NyswcVR4Uk9Pd3NXdE9yc09XakY0Q25qbFI5?=
 =?utf-8?B?SGwza0FXL3BFZ1BwNUp3VDN0cUhiODhEekRzMXE4cjBhWHI3NGJNaGVDVTRx?=
 =?utf-8?B?NHQ1TlpwZWJDSTdIdU1IeElIQXNBRVJnWFZOMzBwSUh4M2laMWRFVGtXb2Ez?=
 =?utf-8?B?NVd4RzdIMnZnbUxyT0JTM3NzMEtpdFYyMzRJUjMrb0RBQ0FVTVgrU01tWWxL?=
 =?utf-8?B?SktCRFZOVUgwbFM5ejhKT3pMRFl3VVFyRjYydlR0U2dOVXlKWXBEV3I5UXh4?=
 =?utf-8?B?cG9GRW1XOXIzbk13V0pIV3FsYWlNTjcwZzh0cEYvZ1RWejk3UnpaWitBNWtz?=
 =?utf-8?B?REJLM1VhLy9COURyS0VPV1MyRlZEZkxDd1orK2ZUN0w1YWdyRjl0WTVvS0Y2?=
 =?utf-8?B?cWdZWTJaZEY0akNxU0NiRXpFcW80L0lVMkJPZzQ5WVU5K0llV213MURCWjdC?=
 =?utf-8?B?a3BMcUR3MjBxR0FSeWhRcTJjSjdFUmtGUGp0Ly9WYXRydko1MUVGdTVoZDcz?=
 =?utf-8?B?QTU0bHkydXY2M2dnM05ZQ3A3Y2p5ZTBBRzJUM3pUR1VKRFVGTWVKeCtKYkFr?=
 =?utf-8?B?NXlpTFZTRk5SVFp5YUlZVjdpakY0aUhhRTNHMXdNMFlEMHovWE1qMlEvYXlR?=
 =?utf-8?B?cWNqVzZMZjRLM2FVQmRhU2I4NzR4UWF0d2duWVg1WTdvRzZJWUdTMS85T2JV?=
 =?utf-8?B?M2ZNSXFYbGlQMXN4YkFBOTZTMFVyOEVmWlI2OEtTTlFid0RmNzA1cDhKZjg2?=
 =?utf-8?B?N2RDZ3lURkxGd2dUc0p5RkZ1aWNGUFdMSS9PNTBFVk1MQ09qWDl2cWJBMXo0?=
 =?utf-8?B?MHV4L29LSVFyL3ZDMndtUU4wTU55N1gzeXo0RFdOQURTeHF2aHZNU2JZWVVp?=
 =?utf-8?B?NVgwQWlFMFJnN3BtcWRZN25JRXRqQ0NKbDRQWklmeW5UTVBBQTlUQ3crRGRN?=
 =?utf-8?B?S09KRThsMEJBalVUd1BpT2xTaU5rS0dReklzdVRVaWFkbFV6ZUJhL0p0eUFB?=
 =?utf-8?B?WUtleld3T2dpRytoVXBkaC9zMmRnN1ZtR2JUeEVyNkRxUFkvNFJNNnlLYVNk?=
 =?utf-8?B?cTNpeXViaEZ3M0JPTCs2ZkFjUGpEWHJYYVJoWTZWMjRHZ2xXNnZmeGszR1Jl?=
 =?utf-8?B?S0dCM0plclpJWjhjYTZBd3pZOG9rSXExeFFUdnVQciszcEpQNXZUUGhlcm5P?=
 =?utf-8?B?bHdhemMvK1hyazZwZGYzcGIrZkdPRVUvenBPeU9ndnBYdkMrRGJUOFoxQ05O?=
 =?utf-8?B?UHJYbTJudnhxTEhjekZ3b3lBeis4MFFsYXc3NFVGeFF6QlAycmZMeDZPMkUw?=
 =?utf-8?B?eWJocUpzUzRyRUZQb2UzLzNXbmFrTlZPZTVXZUp2b3BkSWJtRjQ0Q3dINlNT?=
 =?utf-8?B?eUUweVZ0R2l2aVVuTXFnOXJJbEZ1OSs0MTJDbm1LY2diakx2aWM1WlpWYkky?=
 =?utf-8?B?SkVRVTI5UllDY0toNi9jZmV0aVBYWnJTaXVPdEZHdUhBd2hNbXlZaUlhTFhS?=
 =?utf-8?B?MGFWbExLOEtjWmZzVXpad2ZTU0F1VDZ3RlhEeDJWVExOWkR1Vi9yZVhlaGZV?=
 =?utf-8?B?Tis1cFJxV1IvcHpRQUxJeEplcG1QNDhhMmZmVUtnR212VnNTbXpWc0pIN2Qr?=
 =?utf-8?B?NnBNR2h6NW12c1RIQUhFUnZVblRpd29rVzhKVklZaCtITUFOV2FkQ1BXOGtt?=
 =?utf-8?B?UUoxN1Q3cVRtaUwvRnNzcy90bnZSdzEvMHRhN1dmN0NZRElBaGVWSzJYOU1Z?=
 =?utf-8?B?UE9ybXZ4aVdWc2VtdzdhMXMzMHIxcHRXby9Nb2N4Uzc2VzNKWElSUWJPcXhJ?=
 =?utf-8?Q?9IJe6UrbYn/gEDt7T2EtGKbDg6D2sKVgtIAyc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEhMU3JnaVllaklnS25sMlA2UVRuLzZNeDN1a3NSRjFJQXJud1dtMGVFS2th?=
 =?utf-8?B?Ym1jTzVQTjJuaTRSUU9paFk3RzdFRVRiOWZVckFSV2RyY09WRk1IdHc3NFZF?=
 =?utf-8?B?SGxzUmM3bTNPZFpxeGlCN3d0S0lxVVY0NGlaTXJsN3E2dDcyMXA4bWk3UjBD?=
 =?utf-8?B?ZHpJbURDTDJ3cWpZRUVLSGxNUWRLZWNwVmN0YUw0cGNaRXFpRW9PNHZBWGFQ?=
 =?utf-8?B?V21tSUw5eUtZSGVDNEI0cmhQTUhXSHVYTzkrL056ckVkNUsxQUdzOE1sUldS?=
 =?utf-8?B?NXV3ZCtkdW5ORXowL3ZVZkdnMVh6MC94aFE2NFZHMGhuL0pkRWdyaHhCK29I?=
 =?utf-8?B?UXUvSlJOcC9ZRStXRUJKRjRtekU4aUNZeFg4ZVB1cDdhcjFlYUV0VStvMDRY?=
 =?utf-8?B?QVBUeUdPT2dRT2FpUDAwNGhZTytpZjVRcUlsL3cxWUdNa1VXbHNGQmd1U1Jj?=
 =?utf-8?B?eDlDZ3loSVlGdmFYUXBmUytoRlBueGNuWE1iZXBJSitEQW5NRXdwU0ZGWVZy?=
 =?utf-8?B?Z1IyYU44NklYd21aK3hHNThCQWJvb0czWExDVTY0MmtGaE9WMVBnVWwzdXRS?=
 =?utf-8?B?SjJKY0xtYlREMy9OeUN1UWZEMWIwWENabXNYNWF0d2NROEs3NE9WZ3FDQVhK?=
 =?utf-8?B?VkZRZnB5MnROSFlqVnl5Sk1CZlpCVFA0eEs1empadWNmVEJScGhJSzBHVjlq?=
 =?utf-8?B?MytQYkxVeldBNDgvU1dtL3FZZFBNTUhDcENuWk9yU1BEazdndmh1R1ZGY2hJ?=
 =?utf-8?B?ZmdXczUySGhQTlE3Q0tUVnhJcnQxdXg0NlVyWi8wdy9tcERpcnlxVmZyNzJQ?=
 =?utf-8?B?cktEL1R5SWMzb2xWdHZXRFZSbXNBWVRIamZ3OUgrczlFcVhvSTA2LzloeE4x?=
 =?utf-8?B?MjZqTTJZbnFFTktGNjV4QVBWWEdwZEpiM2ora3g2eUpzeUNDcXpUTm1IbGRR?=
 =?utf-8?B?UVB0WFN6cnkrYTlVYXBMc0pzeFFTRERDSHdCOTIxeG9leUwySGc3TFplSEdq?=
 =?utf-8?B?YTIrbEFrT2x6ODZZU3IzNFNCYVhCL0NBMUUzL2d2MHExMS9mcUJVSlBFOGk3?=
 =?utf-8?B?WituazFMd0hUZVZJU3VPSTBqbFpvMHR0MGRNL2tyUTFVT2RucU04M2NteDVO?=
 =?utf-8?B?Qlh2MlMvNWRDVzlTT0hCYUtiUzNmRVBKUzRzaWZBRStFR2NpWDE3QjFvd2JX?=
 =?utf-8?B?L09LWE1uQklSVDNEeERkSVhpRDE1UzVVN2toSldWOVlmOEFFaktXUVZVWStk?=
 =?utf-8?B?Z0R2RUJHdHJJQ2VFSmo1bnhMSTgya0w0RzBFVFJTTGlHaXh0SXltMGF5bTln?=
 =?utf-8?B?RU5uRjBzZ0RDUHUwNHdYa1ZoOXFvb0xjdWxwU3NTMnQ0WHhvQjJ0SVJjZGtl?=
 =?utf-8?B?VlA4NVFmTlZZVUpRbWkyMng0alV5ckFWQXFZZllxSXM1UXhCVGFoWG9mZTJT?=
 =?utf-8?B?OU1TWVBNUFlockthZ2NlaTMwRURNaG9DMlplbC9WdmovM1AyVXkwdm5ITUlZ?=
 =?utf-8?B?dXMyR2RUcXkxNC9lUG5pU3luL3V3Zi82MWtXSkJaUkV6VkEvODJCTU1lQlZu?=
 =?utf-8?B?YlVEUTl3OHluT3p1UDQvUEM5aEIvLzRseTB6bnEzQnovTU51UW8xUSswUGU3?=
 =?utf-8?B?WGRGZDlBOU9iZk1SNUVha0tYdUF4RHhsblRiMGlGWjNGL09xbmIvOFJhdDBm?=
 =?utf-8?B?azFWc3V2QlNoV29mc0FXeHlOSHJVUFlmUU5sc1VlRGt3RTNLdXlmQ1hHZC9U?=
 =?utf-8?B?WTdrYmtYak43MUNZQzBQV1NFQWthMWNUU3kvazhJOVF4YS9iY1RLWmpsUFZz?=
 =?utf-8?B?dStmVDQ2UnM2M3BqWVkzb2lZSXdwVEFCZk1ZOWw1dVVBSkZMbS8vaEJRSGw3?=
 =?utf-8?B?bnV2ZGVETnVGZXJGMVFNZXZtR2lwZU9maFFRQXFFYTlOdkMzOThqMmRYT3Vw?=
 =?utf-8?B?N1I3Q2xscUxPd1dzZERSTjdyVG5udUZTeklnVkVMalVXQlloS1dxUFlCeU53?=
 =?utf-8?B?ZFRWZE1ESWY3VDQ4dVB6TVp1TlJVNzhiOUM1YWM5dWE4NGtlOHV1SU1hM1RD?=
 =?utf-8?B?bW1KNnVwaEtjeHRjdkNRYmx6WXV3S3c5ODFTcC96MDNyNDNIWXp6T2J6aWZU?=
 =?utf-8?B?c3JlV2QzRVlJMlZic1FrRzJ3REVMUVZQUzVJMkJKRzNhZ25UUWVrbDR0enNX?=
 =?utf-8?Q?WozQjWhmEitX/mT4116XEnQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D741AFED1E94A047AFF820EFE5732413@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 090cccda-9a83-473f-61b6-08dcff604010
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 19:13:23.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGS1rdOJUXqBA0Cw+5+8nIignP8JNzOsXPLCOq3lGlHHT+evIxSEZI3nVim1vhRICJlQ4mhB9bzOL+x5pGGtdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6425
X-Proofpoint-GUID: JxVpU5ly5CUOLzqsCgOYcrwWPPnpnCww
X-Proofpoint-ORIG-GUID: JxVpU5ly5CUOLzqsCgOYcrwWPPnpnCww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDcsIDIwMjQsIGF0IDI6NDjigK9BTSwgSmFuIEthcmEgPGphY2tAc3VzZS5j
ej4gd3JvdGU6DQo+IA0KPiBPbiBUdWUgMjktMTAtMjQgMTY6MTI6NDAsIFNvbmcgTGl1IHdyb3Rl
Og0KPj4gZmFub3RpZnkgZmFzdHBhdGggaGFuZGxlciBlbmFibGVzIGhhbmRsaW5nIGZhbm90aWZ5
IGV2ZW50cyB3aXRoaW4gdGhlDQo+PiBrZXJuZWwsIGFuZCB0aHVzIHNhdmVzIGEgdHJpcCB0byB0
aGUgdXNlciBzcGFjZS4gZmFub3RpZnkgZmFzdHBhdGggaGFuZGxlcg0KPj4gY2FuIGJlIHVzZWZ1
bCBpbiBtYW55IHVzZSBjYXNlcy4gRm9yIGV4YW1wbGUsIGlmIGEgdXNlciBpcyBvbmx5IGludGVy
ZXN0ZWQNCj4+IGluIGV2ZW50cyBmb3Igc29tZSBmaWxlcyBpbiBzaWRlIGEgZGlyZWN0b3J5LCBh
IGZhc3RwYXRoIGhhbmRsZXIgY2FuIGJlDQo+PiB1c2VkIHRvIGZpbHRlciBvdXQgaXJyZWxldmFu
dCBldmVudHMuDQo+PiANCj4+IGZhbm90aWZ5IGZhc3RwYXRoIGhhbmRsZXIgaXMgYXR0YWNoZWQg
dG8gZnNub3RpZnlfZ3JvdXAuIEF0IG1vc3Qgb25lDQo+PiBmYXN0cGF0aCBoYW5kbGVyIGNhbiBi
ZSBhdHRhY2hlZCB0byBhIGZzbm90aWZ5X2dyb3VwLiBUaGUgYXR0YWNoL2RldGFjaA0KPj4gb2Yg
ZmFzdHBhdGggaGFuZGxlcnMgYXJlIGNvbnRyb2xsZWQgYnkgdHdvIG5ldyBpb2N0bHMgb24gdGhl
IGZhbm90aWZ5IGZkczoNCj4+IEZBTl9JT0NfQUREX0ZQIGFuZCBGQU5fSU9DX0RFTF9GUC4NCj4+
IA0KPj4gZmFub3RpZnkgZmFzdHBhdGggaGFuZGxlciBpcyBwYWNrYWdlZCBpbiBhIGtlcm5lbCBt
b2R1bGUuIEluIHRoZSBmdXR1cmUsDQo+PiBpdCBpcyBhbHNvIHBvc3NpYmxlIHRvIHBhY2thZ2Ug
ZmFzdHBhdGggaGFuZGxlciBpbiBhIEJQRiBwcm9ncmFtLiBTaW5jZQ0KPj4gbG9hZGluZyBtb2R1
bGVzIHJlcXVpcmVzIENBUF9TWVNfQURNSU4sIF9sb2FkaW5nXyBmYW5vdGlmeSBmYXN0cGF0aA0K
Pj4gaGFuZGxlciBpbiBrZXJuZWwgbW9kdWxlcyBpcyBsaW1pdGVkIHRvIENBUF9TWVNfQURNSU4u
IEhvd2V2ZXIsDQo+PiBub24tU1lTX0NBUF9BRE1JTiB1c2VycyBjYW4gX2F0dGFjaF8gZmFzdHBh
dGggaGFuZGxlciBsb2FkZWQgYnkgc3lzIGFkbWluDQo+PiB0byB0aGVpciBmYW5vdGlmeSBmZHMu
IFRvIG1ha2UgZmFub3RpZnkgZmFzdHBhdGggaGFuZGxlciBtb3JlIHVzZWZ1bA0KPj4gZm9yIG5v
bi1DQVBfU1lTX0FETUlOIHVzZXJzLCBhIGZhc3RwYXRoIGhhbmRsZXIgY2FuIHRha2UgYXJndW1l
bnRzIGF0DQo+PiBhdHRhY2ggdGltZS4NCj4gDQo+IEh1bSwgSSdtIG5vdCBzdXJlIEknZCBiZSBm
aW5lIGFzIGFuIHN5c2FkbWluIHRvIGFsbG93IGFyYml0YXJ5IHVzZXJzIHRvDQo+IGF0dGFjaCBh
cmJpdHJhcnkgZmlsdGVycyB0byB0aGVpciBncm91cHMuIEkgbWlnaHQgd2FudCBzb21lIGZpbHRl
cnMgZm9yDQo+IHByaXZpbGVkZ2VkIHByb2dyYW1zIHdoaWNoIGtub3cgd2hhdCB0aGV5IGFyZSBk
b2luZyAoZS5nLiBiZWNhdXNlIHRoZQ0KPiBmaWx0ZXJzIGFyZSBleHBlbnNpdmUpIGFuZCBvdGhl
ciBmaWx0ZXJzIG1heSBiZSBmaW5lIGZvciBhbnlib2R5LiBCdXQNCj4gb3ZlcmFsbCBJJ2QgdGhp
bmsgd2UnbGwgc29vbiBoaXQgcmVxdWlyZW1lbnRzIGZvciBwZXJtaXNzaW9uIGNvbnRyb2wgb3Zl
cg0KPiB3aG8gY2FuIGF0dGFjaCB3aGF0Li4uIFNvbWVib2R5IG11c3QgaGF2ZSBjcmVhdGVkIGEg
c29sdXRpb24gZm9yIHRoaXMNCj4gYWxyZWFkeT8NCg0KSSBoYXZlICJmbGFncyIgaW4gZmFub3Rp
ZnlfZmFzdHBhdGhfb3BzLiBJbiBhbiBlYXJsaWVyIHZlcnNpb24gb2YgbXkgDQpsb2NhbCBjb2Rl
LCBJIGFjdHVhbGx5IGhhdmUgIlNZU19BRE1JTl9PTkxZIiBmbGFnIHRoYXQgc3BlY2lmaWVzIHNv
bWUNCmZpbHRlcnMgYXJlIG9ubHkgYXZhaWxhYmxlIHRvIHVzZXJzIHdpdGggQ0FQX1NZU19BRE1J
Ti4gSSByZW1vdmVkIHRoaXMgDQpmbGFnIGxhdGVyIGJlZm9yZSBzZW5kaW5nIHRoZSBmaXJzdCBS
RkMgZm9yIHNpbXBsaWNpdHkuIA0KDQpUaGUgbW9kZWwgaGVyZSAoZmFzdCBwYXRoIGxvYWRlZCBp
biBrZXJuZWwgbW9kdWxlcykgaXMgc2ltaWxhciB0byANCmRpZmZlcmVudCBUQ1AgY29uZ2VzdGlv
biBjb250cm9sIGFsZ29yaXRobXMuIFJlZ3VsYXIgdXNlciBjYW4gY2hvb3NlIA0Kd2hpY2ggYWxn
b3JpdGhtIHRvIHVzZSBmb3IgZWFjaCBUQ1AgY29ubmVjdGlvbi4gVGhpcyBtb2RlbCBpcyANCnN0
cmFpZ2h0Zm9yd2FyZCBiZWNhdXNlIHRoZSBrZXJuZWwgbW9kdWxlcyBhcmUgZ2xvYmFsLiBXaXRo
IEJQRiwgd2UgDQpoYXZlIHRoZSBvcHRpb24gbm90IHRvIGFkZCB0aGUgZmFzdCBwYXRoIHRvIGEg
Z2xvYmFsIGxpc3QsIHNvIHRoYXQgDQp3aG9ldmVyIGxvYWRzIHRoZSBmYXN0IHBhdGggY2FuIGF0
dGFjaCBpdCB0byBzcGVjaWZpYyBncm91cCAoSSBkaWRuJ3QNCmluY2x1ZGUgdGhpcyBtb2RlbCBp
biB0aGUgUkZDKS4NCg0KRm9yIHRoZSBmaXJzdCB2ZXJzaW9uLCBJIHRoaW5rIGEgU1lTX0FETUlO
X09OTFkgZmxhZyB3b3VsZCBiZSBnb29kDQplbm91Z2g/DQoNClRoYW5rcywNClNvbmcNCg0KDQo=


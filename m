Return-Path: <linux-fsdevel+bounces-34870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4689CD992
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA88281792
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C9A186E26;
	Fri, 15 Nov 2024 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GhMWFK3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85000A32;
	Fri, 15 Nov 2024 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654083; cv=fail; b=DgKnqLE9GiHRwUOpMx69J93mVHqR1UaJFP1gCcpDy+//wRHBl/JW3h34s/9PATJ0OKYyZLlUaMHhO0ghOYEyBQ23lwwnJbQvh+xpyzcHKOaHp7ZsPmgK04yv9XFfQTSaAr0YMZpVxp+iPb1B16820bKjWhwd20B+asyLkRAdqWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654083; c=relaxed/simple;
	bh=eS/B9U2ub0h8bqlNpTEQYAXn3vfgbSZ+sOMCthsE1KA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qSpB0aeN+ugtRLCHd8MpStBLYbANPAKij1ZAoWm8jIujAOLubXNoqYEGdUzfSVxA18B9uCU68LbR7jlWDCx00Zk0Gm5zcLo2vomyo2FyeYzpBLgmg+4NXlT0XZQQiB7cj++SkO7aEPvtKUeKXR8a1XelOD9eSUkHS4vwltktZas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GhMWFK3B; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF6tnmD000654;
	Thu, 14 Nov 2024 23:01:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=eS/B9U2ub0h8bqlNpTEQYAXn3vfgbSZ+sOMCthsE1KA=; b=
	GhMWFK3ByfzDHiDJBDTDQTaTOcsiiPXPMLTK9j4nAByvJjUb9C6LDRq62geAF77G
	Bf3tMjWlY6+JkWdvUARM2LaFdI+KWJYa26f4W169/zsvzf0oPvUnV8nPg+g7AjXI
	B076feca3MHjk0V/kGLTqYMdYl6evBtlq3qwahBMHedJwVPDy6GU+feBCsBptRBQ
	bw22Ccgd2RtMaKcMEWX0Hvvxb0R/l+W59URH6+L7gx9ME7hIRgmNRybG8lkMkcD6
	5ISqjwIiGlPxf0w4Ky1TkD01AiMTsqyE8g6IRDOKd+bpSE1cVvq2pTjL8Yt5B0xB
	ZyEeOLa3VTYNSV5Bt64h9A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42wvf9hf8c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 23:01:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXELsUAlS37ysQDVOmsY85gwgGhyFgP1oIESj26X8k8JlzQx6kJtXfLsX0UvnowaiSzAS8ivmDKSgAVQFV6ofaYeTNBFCxhm6caQOG+MhPDMYLyQIfWM1OVc1Fq0jKYa93Vq95g7cuktCtOAU8pVB0xiR8sOnAa6bCYNCWofc2LH9AxbV2rIqYlLKcboPOgL+j9ORLMw4zPPQDZR3HZ4foRMPV/EUtIi/XnvTMx8OW1xJDSmgYVSYkPzvx6mIXue6dXEuzk3X/hLHtKMxoYfOlguZIiVdOwzLoxU1jnRVRD3zjlO5wDNIF2LWusHc+m32MN7IjsJ+v8ayGgIkAHVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS/B9U2ub0h8bqlNpTEQYAXn3vfgbSZ+sOMCthsE1KA=;
 b=fvTQK2xbsuC2upmOkEztpXbegpD8Ry0EOoSLV1qVYqmZ0fWdhgrqXNZ/PlrkXCtFYsFcd2ZFtXhsrCUYrYWcjrp7JHkSMg7OHKBkN+MwGXTfMDU6WjvYJw5u6dWilU25NLLdbHURMAw0icjZ59DYk3OZ3xg7KME7oGq6iT2xMgnDWq/hcimnKgo4i2lpbHw/zhqk7YHmS9M5T4dE6y5rxksyx0a0ewYdDghM4PZUpydYwftvhgg0g+bLyEtPTgaiBQJpMuGA+mrVNcXOj7eucQfihodCSccYB8ipDhkeFObK/sUpAN+y0tsYs7Pooc6VQIPnE1VSK9JvNoZQ746uJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4934.namprd15.prod.outlook.com (2603:10b6:806:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 07:01:15 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 07:01:15 +0000
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
 AQHbNnGAryo3J6mFf0ePhnT/vr0UcrK3NqIAgAAvFgCAABuhgIAACBOAgAAGAICAAFv2AA==
Date: Fri, 15 Nov 2024 07:01:15 +0000
Message-ID: <C7C15985-2560-4D52-ADF9-C7680AF10E90@fb.com>
References: <20241114084345.1564165-1-song@kernel.org>
 <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
 <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com>
 <CAADnVQJ1um9u4cBpAEw83CS8xZJN=iP8WXdG0Ops5oTP-_NDFg@mail.gmail.com>
 <DCE25AB7-E337-4E11-9D57-2880F822BF33@fb.com>
 <CAADnVQ+bRO+UakzouzR5OfmvJAcyOs7VqCJKiLsjnfW1xkPZOg@mail.gmail.com>
In-Reply-To:
 <CAADnVQ+bRO+UakzouzR5OfmvJAcyOs7VqCJKiLsjnfW1xkPZOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB4934:EE_
x-ms-office365-filtering-correlation-id: 7bceec0c-3f9e-40d8-ba6e-08dd05434bff
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tzl1eHc2ZVM4c2x1bVJrWGlUQ2VEVXlpWVdENzd4c000WjlVZEp2Q0R0OEtk?=
 =?utf-8?B?TW8yTndLZCtJZkVrc1VMdGVHQ09vWVJ3VndDK2FFYnQ1TFN5Ulh6RW5nYWR4?=
 =?utf-8?B?UGJmUGc2OU8wOFo5VGx0bm5TVHc3ak1DL1dydHpLbVA4dTFxcHRTSzVuSEVS?=
 =?utf-8?B?U0dCcmljRkk2bGdyQnVRcTFyN0tTMFF5WmZNdUNtWEFHa3h1VWRCRThqUzN4?=
 =?utf-8?B?M3pHdDE2eFM4NDNNSXB3dEt2eWZGM1BWVTJScURkS3Fsc3JkS2U1aGJ4Q3RQ?=
 =?utf-8?B?SHdpVXRiZjVoeER5aG1kd3JXQ3ZqdkZ0aWxmNTBuNnREUEJvQ2RMMmZwSW5z?=
 =?utf-8?B?Y2ZoZkR5dFNHK2RUQVdsSXNreDRiOTZnZ3Yyd2d1a2ovMzBNVDc4MHlmelBF?=
 =?utf-8?B?aithRUFxM2J0c280dTU5K2cwLzZZaFJuaSt6MS95akx3bFFheS9vRmVQcmxB?=
 =?utf-8?B?Mm9sUkFkN2JmNEgyUkFJQWc5YkFacHRUb2I1RlNtbUVpdWcveTlxT3hEUWNG?=
 =?utf-8?B?c3FrcDhFV1NnUnBRb2svbGpOL1RIZ0s0d0R4VHg5NnVicG10N2NQQ0xjcFpx?=
 =?utf-8?B?aVdJTnN3aUp4djFNUjE1Nkp4ZlNvbFFhYmNPNmIvM0xNV21Xc3JwR0thMHlH?=
 =?utf-8?B?VDZSWHR3SUpIclJFVllkNndXWVpzd3lTNEdSZVRoOVVBUjY4ME90OHVMMUFG?=
 =?utf-8?B?NWtRYkZCUExRWDlFckRvVlA3eFlNWUc2Sm5UQXdOdjVxVFc5OUQ5U0U2bE5X?=
 =?utf-8?B?NTdNRm5nZ0N2STJxZTY2a041QmY5eGl2YjAxS2xTTWtzUGRrUTdLU0lFYmhj?=
 =?utf-8?B?bFhBSXVWN09UUlJYWHdPWmNLZXpvSjZia1RueERlZ3pmWGo5bVgxeGVkL2Y1?=
 =?utf-8?B?dWNUcTQ0T2svU3pJV0dKbzdvVHdYTGVJMHJMbjlwaXY4SXd2QXdlejN5WnpI?=
 =?utf-8?B?d2pQV29YaTBvY2dhUmtYRklVcjVZWmJSSFJEeUd6TGJwL1Nka2tZZUY1YzJh?=
 =?utf-8?B?QkpWS3I3czdwZ3FmVDlVZ1NKc1VNNjVLVW1UYWsyZitEUzVvTmR6a2ZGbVF6?=
 =?utf-8?B?Uyt2SER1bUdCODhTLzg5QjhqaUU4ZU1GRnRyM3U0MlZOa2huK2JJeXJkS3pw?=
 =?utf-8?B?YlJlR3VCNCtscEs3WXV0bzJhamsybXZUSWtUWU1XQXpqMW1Za3VRVjNheDZN?=
 =?utf-8?B?cmZYd1YyZTFLQ3BmTFU1d1FOZHRJQzViU0FucXRZd1MyZVBTdm1oYXVFU3dO?=
 =?utf-8?B?ek8ybzFjWVZEcWx6cnljMVQ3TTdyaHBCSVBTNE9CaFJ1bEpsbXdtTHBWZG1B?=
 =?utf-8?B?L0lsdHV0NXFqc2VzOGgvNElKWStsVlJWeVdkSHBEN3RkQU5KTk9VcEFQMGY5?=
 =?utf-8?B?eXIzZGlBeU52R1NRU1BYeGw4SUROdkNMMmxVWTd6MXhlc1dWbmNYKzdGVCtI?=
 =?utf-8?B?emUzcndZZ2JLbDJNcHlXUHdyVzFBT3BsWlY0cjAzUmx5elEzU21pTG1rRjZx?=
 =?utf-8?B?bDlBWGhDdzhoTTFVNHpyUmhFUFBhSEdlWUduSnNRMmxsZjYzU2hKUGkzYWhF?=
 =?utf-8?B?Ympyelk2MDhqaTVodk01SnZxTWFicHhLL2RmQTZFSHgraHNtcVIwMGVvejZ4?=
 =?utf-8?B?SEwvTCt6T3dzZk9iUXpseGdDMWVNUDFtTEhSclo1dks5ejdyNE1FS0NySzNo?=
 =?utf-8?B?d04rNmllQWhHdmkrODQ3eHZWTk9scTNIdkV4NU1NWC9oV2RoSGtpUythTjYz?=
 =?utf-8?Q?SO6CYqBnI7MDe1VrLp3lZxDNN+S1QOyh8n5sqrI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anRXNUFzcXFENnRBZjNFbGM5cWFTUDRtUjkxTEJIN0VKaW92clZ3cnpqbUtJ?=
 =?utf-8?B?YURrSmozYngwNWNWWmFzYWpPVDRyTlI5STUwWmFTMjBoSXFjbk14K2lQZjNG?=
 =?utf-8?B?VXVsWjFXOU0rZGRablFjRGtHVGZnczZhQ0pzL2FLR3hSQW13clFMTzlJV253?=
 =?utf-8?B?ZEt1akxoYndNZlJKUEhEMzNhR3QxYVBSV1duN0psN0dIS0N3Tmg1T1FUQjhv?=
 =?utf-8?B?aXdsRzVOeFgyU2hmMXpaSW1wZWRmV01rbkdpbnEvc3M2bFR3ZjYyNnFTS3FM?=
 =?utf-8?B?aUxYUDRhMDgxdXR4bTFYdTVGWnJLOWhjY01RMDBVNHhSajF1WjNrckRtSmFJ?=
 =?utf-8?B?U0NlKzZneFBISWs0MXZodTNvalBQSm5xNkpGOGNYaXJKcmJiZ3ZXNUN0VnlS?=
 =?utf-8?B?dWRmd05TbURYcFNUc0IwcEU2cFVKcDFESEs2VDVtL0VMeGswTCtYOEZNV3U2?=
 =?utf-8?B?cGJhZ04wT0JrWkF5RjJkWmtqVWVpRk1oN2FudlF1aUlVMlhXdU5vN00yOGQr?=
 =?utf-8?B?R1BpRUZuRGdCSVRpdzRPb0FPWTBlTWxaRTYvUVVxVFdsdlVqMFVBTjNDSDdp?=
 =?utf-8?B?VHpYRURhNUZ3VXVYam1zOWQ2bWhpVVB2UEp6VEZXcndhWUpDcXB3aWlsSk9V?=
 =?utf-8?B?c2NDMzJOTDlhQTdqWUV0SE9mL09meEtsenI5czByOFBONUlZWHZ6MGxWbVB2?=
 =?utf-8?B?L2JEZEtYQWljWG9BWWxDMXM3dFc4UUF1c0ZtZ2RIeFJYejRRWEhmQVdhbThs?=
 =?utf-8?B?NHFLY3NxTDh0a09WOEpNMzVjME93emhUWnkzNzRWQUhET1RaZFdja2tSanJk?=
 =?utf-8?B?djdjVkt0ZnFaSTFTSktKeWhJdDY4SVNadkFtdzR0NnRrWXowWUFzZW5kaGdY?=
 =?utf-8?B?RXNBaXNUOGZMUHEwOVVPSUtVamFKWStqWXpKSnlOOWJNK281MFhWUG9PZ0Rv?=
 =?utf-8?B?TCtObmE1cnQ2TTlMZHpEbml2dzdCSGF3bk9tV3o5WkowNmQyeXVKTkE1RzJG?=
 =?utf-8?B?TG5GT2RrK2dOL2xRVTR1OFllQldxakc1RERmeFJmVEFaRVZBU21TMjBsZTVv?=
 =?utf-8?B?c0ZWSDhTaW5kcTh3b3hNem15cmY3dWFTRnNCVEVPb2hpTythM3FVZEpid1ZM?=
 =?utf-8?B?dmdqeGpRSzBzeFhVb05YZjRSMnlmblh5ek9XUXpGQTBIN3plcG4rR0U1cmVr?=
 =?utf-8?B?MVJEQVZoUHFKT25KWUhUMmEwdHg0Vlo4cHJXWHlKVlpKdi8vS1c0KzhDTWNT?=
 =?utf-8?B?WVQ0ZkFJaHZNbkNKWXJLTTdIenZMcTJib05OcjE3YXAvQURFQTVNQVBXdW9y?=
 =?utf-8?B?MzhOS0ZtL2FHRkxJdFg4dmVKRzZZa00rZy9FSDhITWlSZVZTL1hubUlPdmtw?=
 =?utf-8?B?NE0wSklnVkw2Zmt6NHc4cTFZVm5BMFhVUmNkSlcvQjI0ZFg0WDdXSmY5NG9o?=
 =?utf-8?B?dEJURHl2azlhc1ZtUEhHb0NaWjVySnZ6R2N3TEJ5d1lFb3ZPRUpaZlRwTS9V?=
 =?utf-8?B?dVVoR3dEMUExQm53c3pURGQ1MjNOdWpYbkhIRDdpMFRvQUNjTWpFaG04YzFy?=
 =?utf-8?B?clRodVpPYjZ1RzBBZW9ab0JsOUxzK2pmVnErU0JuM2IvZ1pCZlVQTzdKTWZa?=
 =?utf-8?B?c3pOTzNZMkVtcFU0VGhBd1Q4UFkyN3g0b1Z4akJoV2lsaFVjQlI1MDd3NFdF?=
 =?utf-8?B?Q2paY3JuQ0pYMUMxRE5YMlk3b2s0SFRVYUlyZWxXM0t4RzM5MVVJMlFoTmlx?=
 =?utf-8?B?cGNjbStOYWU4bjh4cXpQRlRoYWwzY09OS2grbWJjZzAxMmIrSWlYQnhJOHJW?=
 =?utf-8?B?dkRQcW1teElKYWxxbjVFUUdKWmVMYWVaL2M0SHBiZDZpTm5XejFmREZSWXJU?=
 =?utf-8?B?aDYwektoNzh2Y2FQTmN1N0crZFBuWkpubGVsd2kwUWtEUzAvVllyb2pqUjhV?=
 =?utf-8?B?L284NHMrTHExTzdqdXduQ2RPbmZvUG5ndzQ0NUFRWGJhVjUydkJGRGl1NjZM?=
 =?utf-8?B?UUc1QWl2MFJVZlkrZnk4cVVXZGg1Z1dVMVB4b0Rzem9DVlc3VlNWL1ZzbXdi?=
 =?utf-8?B?R0FrMzJreC91NE1neXlxRm1NK0VRcVY1ckdYbVpLb1JRQlpGYktxakIyT0RI?=
 =?utf-8?B?dVhOYmE1Wnl0Zm85VjZOdkpjVTd6MGd1Yml2OXhvRi8wSmVRMVlENWdCK2ZL?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2E081C3E2DCA449BAB9D22F09990360@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bceec0c-3f9e-40d8-ba6e-08dd05434bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 07:01:15.2190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnrkxvKBNYFlaVAKQCFj49Cd6gDKro118BeUXUpu97XIIeMi55TQyr5N9moLwyTz4+XAH27y11dvSlnHfChoyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4934
X-Proofpoint-ORIG-GUID: WnIph2bdVp959vB-e3OEfQuRP7wVCaL9
X-Proofpoint-GUID: WnIph2bdVp959vB-e3OEfQuRP7wVCaL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDE0LCAyMDI0LCBhdCA1OjMx4oCvUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiA8
YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQoNClsuLi5dDQoNCj4+PiANCj4+
PiBOb3QgeWV0Lg0KPj4+IFRoaXMgZmFub3RpZnkgYnBmIGZpbHRlcmluZyBvbmx5IHJlZHVjZXMg
dGhlIG51bWJlciBvZiBldmVudHMNCj4+PiBzZW50IHRvIHVzZXIgc3BhY2UuDQo+Pj4gSG93IGlz
IGl0IHN1cHBvc2VkIHRvIGludGVyYWN0IHdpdGggYnBmLWxzbT8NCj4+IA0KPj4gQWgsIEkgZGlk
bid0IGV4cGxhaW4gdGhpcyBwYXJ0LiBmYW5vdGlmeSticGYgZmFzdHBhdGggY2FuDQo+PiBkbyBt
b3JlIHJlZHVjaW5nIG51bWJlciBvZiBldmVudHMgc2VudCB0byB1c2VyIHNwYWNlLiBJdCBjYW4N
Cj4+IGFsc28gYmUgdXNlZCBpbiB0cmFjaW5nIHVzZSBjYXNlcy4gRm9yIGV4YW1wbGUsIHdlIGNh
bg0KPj4gaW1wbGVtZW50IGEgZmlsZXRvcCB0b29sIHRoYXQgb25seSBtb25pdG9ycyBhIHNwZWNp
ZmljDQo+PiBkaXJlY3RvcnksIGEgc3BlY2lmaWMgZGV2aWNlLCBvciBhIHNwZWNpZmljIG1vdW50
IHBvaW50Lg0KPj4gSXQgY2FuIGFsc28gcmVqZWN0IHNvbWUgZmlsZSBhY2Nlc3MgKGZhbm90aWZ5
IHBlcm1pc3Npb24NCj4+IG1vZGUpLiBJIHNob3VsZCBoYXZlIHNob3dlZCB0aGVzZSBmZWF0dXJl
cyBpbiBhIHNhbXBsZQ0KPj4gYW5kL29yIHNlbGZ0ZXN0Lg0KPiANCj4gSSBiZXQgYnBmIHRyYWNp
bmcgY2FuIGZpbGV0b3AgYWxyZWFkeS4NCj4gTm90IGFzIGVmZmljaWVudCwgYnV0IHRyYWNpbmcg
aXNuJ3QgZ29pbmcgdG8gYmUgcnVubmluZyAyNC83Lg0KPiANCj4+IA0KPj4+IFNheSwgc2VjdXJp
dHkgcG9saWN5IGFwcGxpZXMgdG8gL3Vzci9iaW4vKg0KPj4+IHNvIGxzbSBzdXBwb3NlIHRvIGFj
dCBvbiBhbGwgZmlsZXMgYW5kIHN1YmRpcnMgaW4gdGhlcmUuDQo+Pj4gSG93IGZhbm90aWZ5IGhl
bHBzID8NCj4+IA0KPj4gTFNNIGhvb2tzIGFyZSBhbHdheXMgZ2xvYmFsLiBJdCBpcyB1cCB0byB0
aGUgQlBGIHByb2dyYW0NCj4+IHRvIGZpbHRlciBvdXQgaXJyZWxldmFudCBldmVudHMuIFRoaXMg
ZmlsdGVyaW5nIGlzDQo+PiBzb21ldGltZXMgZXhwZW5zaXZlIChtYXRjaCBkX3BhdGNoKSBhbmQg
aW5hY2N1cmF0ZQ0KPj4gKG1haW50YWluIGEgbWFwIG9mIHRhcmdldCBpbm9kZXMsIGV0Yy4pLiBP
VE9ILCBmYW5vdGlmeQ0KPj4gaGFzIGJ1aWx0LWluIGZpbHRlcmluZyBiZWZvcmUgdGhlIEJQRiBw
cm9ncmFtIHRyaWdnZXJzLg0KPj4gV2hlbiBtdWx0aXBsZSBCUEYgcHJvZ3JhbXMgYXJlIG1vbml0
b3Jpbmcgb3BlbigpIGZvcg0KPj4gZGlmZmVyZW50IHN1YmRpcmVjdG9yaWVzLCBmYW5vdGlmeSBi
YXNlZCBzb2x1dGlvbiB3aWxsDQo+PiBub3QgdHJpZ2dlciBhbGwgdGhlc2UgQlBGIHByb2dyYW1z
IGZvciBhbGwgdGhlIG9wZW4oKQ0KPj4gaW4gdGhlIHN5c3RlbS4NCj4+IA0KPj4gRG9lcyB0aGlz
IGFuc3dlciB0aGUgcXVlc3Rpb25zPw0KPiANCj4gTm8uIEFib3ZlIGlzIHRvbyBtdWNoIGhhbmQg
d2F2aW5nLg0KPiANCj4gSSB0aGluayBicGYtbHNtIGhvb2sgZmlyZXMgYmVmb3JlIGZhbm90aWZ5
LCBzbyBicGYtbHNtIHByb2cNCj4gaW1wbGVtZW50aW5nIHNvbWUgc2VjdXJpdHkgcG9saWN5IGhh
cyB0byBkZWNpZGUgcmlnaHQNCj4gYXQgdGhlIG1vbWVudCB3aGF0IHRvIGRvIHdpdGgsIHNheSwg
c2VjdXJpdHlfZmlsZV9vcGVuKCkuDQo+IGZhbm90aWZ5IHdpdGggb3Igd2l0aG91dCBicGYgZmFz
dHBhdGggaXMgdG9vIGxhdGUuDQoNCkFjdHVhbGx5LCBmYW5vdGlmeSBpbiBwZXJtaXNzaW9uIG1v
ZGUgY2FuIHN0b3AgYSBmaWxlIG9wZW4uIA0KSW4gY3VycmVudCB1cHN0cmVhbSBjb2RlLCBmc25v
dGlmeSBob29rIGZzbm90aWZ5X29wZW5fcGVybQ0KaXMgYWN0dWFsbHkgcGFydCBvZiBzZWN1cml0
eV9maWxlX29wZW4oKS4gSXQgd2lsbCBiZSBtb3ZlZA0KdG8gZG9fZGVudHJ5X29wZW4oKSwgcmln
aHQgYWZ0ZXIgc2VjdXJpdHlfZmlsZV9vcGVuKCkuIFRoaXMNCm1vdmUgaXMgZG9uZSBieSAxY2Rh
NTJmMWI0NjEgaW4gbGludXgtbmV4dC4gDQoNCkluIHByYWN0aWNlLCB3ZSBhcmUgbm90IGxpa2Vs
eSB0byB1c2UgQlBGIExTTSBhbmQgZmFub3RpZnkgDQpvbiB0aGUgc2FtZSBob29rIGF0IHRoZSBz
YW1lIHRpbWUuIEluc3RlYWQsIHdlIGNhbiB1c2UgDQpCUEYgTFNNIGhvb2tzIHRvIGdhdGhlciBp
bmZvcm1hdGlvbiBhbmQgdXNlIGZhbm90aWZ5IHRvIA0KbWFrZSBhbGxvdy9kZW55IGRlY2lzaW9u
LCBvciB2aWNlIHZlcnNhLiANCg0KPiBJbiBnZW5lcmFsIGZhbm90aWZ5IGlzIG5vdCBmb3Igc2Vj
dXJpdHkuIEl0J3Mgbm90aWZ5aW5nDQo+IHVzZXIgc3BhY2Ugb2YgZXZlbnRzIHRoYXQgYWxyZWFk
eSBoYXBwZW5lZCwgc28gSSBkb24ndCBzZWUNCj4gaG93IHRoZXNlIHR3byBjYW4gYmUgY29tYmlu
ZWQuDQoNCmZhbm90aWZ5IGlzIGFjdHVhbGx5IHVzZWQgYnkgQW50aVZpcnVzIHNvZnR3YXJlcy4g
Rm9yIA0KZXhhbXBsZSwgQ2FsbUFWIChodHRwczovL3d3dy5jbGFtYXYubmV0LykgdXNlcyBmYW5v
dGlmeSANCmZvciBpdHMgTGludXggdmVyc2lvbiAoaXQgYWxzbyBzdXBwb3J0cyBXaW5kb3cgYW5k
IE1hY09TKS4NCg0KDQpJIGd1ZXNzIEkgZGlkbid0IHN0YXRlIHRoZSBtb3RpdmF0aW9uIGNsZWFy
bHkuIFNvIGxldCBtZQ0KdHJ5IGl0IG5vdy4gDQoNClRyYWNpbmcgaXMgYSBjcml0aWNhbCBwYXJ0
IG9mIGEgc2VjdXJpdHkgc29sdXRpb24uIFdpdGggDQpMU00sIGJsb2NraW5nIGFuIG9wZXJhdGlv
biBpcyBzdHJhaWdodGZvcndhcmQuIEhvd2V2ZXIsDQprbm93aW5nIHdoaWNoIG9wZXJhdGlvbiBz
aG91bGQgYmUgYmxvY2tlZCBpcyBub3QgYWx3YXlzIA0KZWFzeS4gQWxzbywgc2VjdXJpdHkgaG9v
a3MgKExTTSBvciBmYW5vdGlmeSkgc2l0IGluIHRoZSANCmNyaXRpY2FsIHBhdGggb2YgdXNlciBy
ZXF1ZXN0cy4gSXQgaXMgdmVyeSBpbXBvcnRhbnQgdG8gDQpvcHRpbWl6ZSB0aGUgbGF0ZW5jeSBv
ZiBhIHNlY3VyaXR5IGhvb2suIElkZWFsbHksIHRoZSANCnRyYWNpbmcgbG9naWMgc2hvdWxkIGdh
dGhlciBhbGwgdGhlIGluZm9ybWF0aW9uIGFoZWFkIA0Kb2YgdGltZSwgYW5kIG1ha2UgdGhlIGFj
dHVhbCBob29rIGZhc3QuIA0KDQpGb3IgZXhhbXBsZSwgaWYgc2VjdXJpdHlfZmlsZV9vcGVuKCkg
b25seSBuZWVkcyB0byByZWFkIA0KYSBmbGFnIGZyb20gaW5vZGUgbG9jYWwgc3RvcmFnZSwgdGhl
IG92ZXJoZWFkIGlzIG1pbmltYWwgDQphbmQgcHJlZGljdGFibGUuIElmIHNlY3VyaXR5X2ZpbGVf
b3BlbigpIGhhcyB0byB3YWxrIHRoZSANCmRlbnRyeSB0cmVlLCBvciBjYWxsIGRfcGF0aCgpLCB0
aGUgb3ZlcmhlYWQgd2lsbCBiZSANCm11Y2ggaGlnaGVyLiBmYW5vdGlmeV9maWxlX3Blcm0oKSBw
cm92aWRlcyBhbm90aGVyIA0KbGV2ZWwgb2Ygb3B0aW1pemF0aW9uIG92ZXIgc2VjdXJpdHlfZmls
ZV9vcGVuKCkuIElmIGEgDQpmaWxlIGlzIG5vdCBiZWluZyBtb25pdG9yZWQsIGZhbm90aWZ5IHdp
bGwgbm90IGdlbmVyYXRlIA0KdGhlIGV2ZW50LiANCg0KU2VjdXJpdHkgc29sdXRpb25zIGhvbGQg
aGlnaGVyIGJhcnMgZm9yIHRoZSB0cmFjaW5nIGxvZ2ljOg0KDQotIEl0IG5lZWRzIHRvIGJlIGFj
Y3VyYXRlLCBhcyBmYWxzZSBwb3NpdGl2ZXMgYW5kIGZhbHNlDQogIG5lZ2F0aXZlcyBjYW4gYmUg
dmVyeSBhbm5veWluZyBhbmQvb3IgaGFybWZ1bC4NCi0gSXQgbmVlZHMgdG8gYmUgZWZmaWNpZW50
LCBhcyBzZWN1cml0eSBkYWVtb25zIHJ1biAyNC83LiANCg0KR2l2ZW4gdGhlc2UgcmVxdWlyZW1l
bnRzIG9mIHNlY3VyaXR5IHNvbHV0aW9ucywgSSBiZWxpZXZlDQppdCBpcyBpbXBvcnRhbnQgdG8g
b3B0aW1pemUgdHJhY2luZyBsb2dpYyBhcyBtdWNoIGFzIA0KcG9zc2libGUuIEFuZCBCUEYgYmFz
ZWQgZmFub3RpZnkgZmFzdHBhdGggaGFuZGxlciBjYW4NCmJyaW5nIG5vbi10cml2aWFscyBiZW5l
Zml0IHRvIEJQRiBiYXNlZCBzZWN1cml0eSBzb2x1dGlvbnMuDQoNCmZhbm90aWZ5IGFsc28gaGFz
IGEgZmVhdHVyZSB0aGF0IExTTSBkb2Vzbid0IHByb3ZpZGUuIA0KV2hlbiBhIGZpbGUgaXMgYWNj
ZXNzZWQsIHVzZXIgc3BhY2UgZGFlbW9uIGNhbiBnZXQgYSANCmZkIG9uIHRoaXMgZmlsZSBmcm9t
IGZhbm90aWZ5LiBPVE9ILCBMU00gY2FuIG9ubHkgc2VuZA0KYW4gaW5vIG9yIGEgcGF0aCB0byB1
c2VyIHNwYWNlLCB3aGljaCBpcyBub3QgYWx3YXlzIA0KcmVsaWFibGUuIA0KDQpJIGhvcGUgdGhp
cyBzdGFydHMgdG8gbWFrZSBzZW5zZS4uLg0KDQpUaGFua3MsDQpTb25nDQoNCg==


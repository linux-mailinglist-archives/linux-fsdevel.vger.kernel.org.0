Return-Path: <linux-fsdevel+bounces-54428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD0BAFF9D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A97F3B31AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE45F28727A;
	Thu, 10 Jul 2025 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LOsGQoke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E691226D11;
	Thu, 10 Jul 2025 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128890; cv=fail; b=b0L9CDUI0mTDZ0NkqfEBp235IHB7/aCuFPR4m/hfI6jMUJJVhH5IpgEf4gt5/LAQTBCevFK2z8y5tfNJtp4909v6TNXs1x/RDmQrlJi1QqB4TKdgxwjwtJHuzpbGlaZ1EBOYhhSIGFrtF1v0Z5lEoIUUqhG9BnBQR64u8Ga2N7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128890; c=relaxed/simple;
	bh=nePzTSoC1wy6TF/W7+qQ1LXN8ko2V33IsW+31ulCCFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IFI7jn7rsZMXuxYUKS2ubtBXnJC3+ZuHVssm/JTIbBbNWNSvWH8Gamu6/yX0B+uzqlT+ovEYriFhfJFhYaKAW/nt7Fj+5ZqC8mEc/skqsMa7+YQQ5C83mlIsjWKtGKilVnhM+JkknH/vqkpdg7+ekuskzctpJsETPi08aBWFYAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LOsGQoke; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A6BYBo013521;
	Wed, 9 Jul 2025 23:28:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=nePzTSoC1wy6TF/W7+qQ1LXN8ko2V33IsW+31ulCCFc=; b=
	LOsGQokefg6DL07IwcIcekemNadhmQBi6J+8JyhogbuNiUU8LVcK4U0jzBNcxZGz
	OqbijBYBQj3c82yOtGla+28UXR5VkTnurtxLGgvX/4sxVqmgVWSQa7MczflOGjz5
	WJqDT2jfryQh3Qs6f2f90u88Y9+RqDBnpjVa5XpqyVE/tiCts1nzDW9ZNtGTpuj4
	Zi+vjD1VOEZ3W5LAAy9xxe7/blBHqV33c578ukTUU5Tx5jyegzKejvSVx3KTPYew
	/mk41N75NbCx2tVaw+mCbnLgLNtSjX6fKEYT1zYwh76X8HjFnjKASe+itJ9RSsl+
	cIygnG72Aodaa+ZI2KdhhA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47t81cr27h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 23:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS9jiwX69MwQgbcGGbtUwxKLBiY/yCjEmkPTkZhXYuvYpOWDUJenTlcZFvKKItzSI48DjY5J1F0nTAPIpWzxgJ0PguSt3U9TzFSqbH1lA9e93GjOkT8cvGamztcvzhkgqprHy1SLw87YE+ZGleTdMNhjtGVo4x62Xw8nev5QaNqZNXGTDhzqLgvUxC7TKLzKrMR70oKxnKDoag7YZeBVpMQ3AfP/sDkRBBqZnIrXNueKuSEzmgtR+Dh2i8JnKAq6Jz7B90qdb38GfN/D8f+EFXCFoCVzJGhP/3m/3lBUXSxy9VBl1uoDyOeKbEKg1ycQcc9q9enUzOxpmuACgDfXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nePzTSoC1wy6TF/W7+qQ1LXN8ko2V33IsW+31ulCCFc=;
 b=izBoHPjRkZjQocXAp2oyhb6lVIhdZYTJBJZfeaPZPbwbfk3zymG6zqipMYeiP25EE272OfMA91VgZ2Poik/cLB6TYreEWF8dvEKOJW+Ve65f6v3UyO4DEZE0iLjIJjYfidxhlBKBCAsX9ADwGrhFeWyxCetQQRl4RztaJ1vWBE6eRkViQu3p/DjsSGznzOT1kRUasNraVnDK74/WIk5KNf5WL3z1JVTTWSBZxizqtTkBWsK/0pEE3R0y21GPKglFyfEzAgWmRk4Bm7H5ccydBYik0kSPa6EyBuhyhnKmIG0VoQbNg2YkIU2AfoeqrscNUOu2dFBV9ib6XakPGK4Ndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA0PR15MB3887.namprd15.prod.outlook.com (2603:10b6:806:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 06:28:04 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 06:28:03 +0000
From: Song Liu <songliubraving@meta.com>
To: NeilBrown <neil@brown.name>
CC: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Christian Brauner
	<brauner@kernel.org>, Tingmao Wang <m@maowtm.org>,
        Song Liu
	<song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAEtZgIAARLiAgACMg4CAEH8tgIAACIOAgAB+hYCAAvcGAIAAF8IAgABRvgCAAAcpAIAAI/SAgABcBIA=
Date: Thu, 10 Jul 2025 06:28:03 +0000
Message-ID: <B33A07A6-6133-486D-B333-970E1C4C5CA3@meta.com>
References: <474C8D99-6946-4CFF-A925-157329879DA9@meta.com>
 <175210911389.2234665.8053137657588792026@noble.neil.brown.name>
In-Reply-To: <175210911389.2234665.8053137657588792026@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA0PR15MB3887:EE_
x-ms-office365-filtering-correlation-id: 9e27f77a-b3ce-4d47-a7f6-08ddbf7aecfb
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlRuY3NLbTE5dTZ3WVQ4d0pwc0ZPVTNnb3YrSmFZSmFIRnZ4cHB3R2J3QUd1?=
 =?utf-8?B?M3FITVFhdmoyb3lVMmY1Sk9TbkszQ3dHSW5DaEhsY1RFRDUwSXphb3lObUJP?=
 =?utf-8?B?OXJKN1A5d0djL1hkamNUSm9MZW00bDBPS1hwUHYzZGNDQUY2NjhwNG1qSytu?=
 =?utf-8?B?OFNFL1dTTFhIb1VwT0xRZml2TS8xZk5tREFnWkEvVTBmN0UvbFpnZlpPb3RH?=
 =?utf-8?B?VkNES1ppRGlEd3JDcFFNeDJ3ZTdhK0MzYjJVOVRpc2Y1QzRaVFFkM295UXRQ?=
 =?utf-8?B?b1A1ZlhmNEtJU2ZHTlZBV2s0MUUyVG1IWkM1cHRjRjBqRCs1bzA2ZVZHN0l0?=
 =?utf-8?B?L1ZDNlJDdjJmejVQc2x5QzM1NVRhOXhjcEFicDJmWFRqdklaNjBpZFlXOEEx?=
 =?utf-8?B?cG1DQXVPWXd1U3lxTHRxSWYvMXhxSEVNUW04c0JxTmVDcEdXVnFhdW90VGhz?=
 =?utf-8?B?OEdFVjlLMkZwZ2RHb1NPU25tQllzeTZzVHJOaURMRlU0WllXRDNpZWpVTnVS?=
 =?utf-8?B?UGlFM2xweDJZekpuUE9sWFBHaUx6SDRCVDBmNE94b0NlNFZpVFl3ZHh2UlV6?=
 =?utf-8?B?ZEhwanBjSUlUbDI3UFZidXUvWGUyYWQzNzZZOTZpWlBDc01jNTVjK3BqQzQw?=
 =?utf-8?B?RUFJMVRMejdmRWszUTh6Y0sycW41RGwwZUQxOUFCVmRsWmhqNFd4aC9ZU3Ja?=
 =?utf-8?B?NTBPdWhuVDBWdjlQMzFsRno1NWZNQm1MLy9YNTVIaStqNEhGemlmRldQQVRk?=
 =?utf-8?B?QzVCRkFsa2pNOExXcHhONXU3WXFkNytHSU1mcm82YXVOQjBjQkY5UmM4eUhr?=
 =?utf-8?B?aU0yTUp1RjNkbTBDVERRcDBlWERVRWdiQlU4TzAzZzJwVGJGTDE1U1ZoWjdP?=
 =?utf-8?B?YWYyWUlQMUt0aEZINjJScDlMZDNSZkgrL3ZCZmdIdjE4aUY1dVdrRTlhaXFa?=
 =?utf-8?B?K2I2T2RyRyswMCtlaEFEWUFyeXBQeEN5aHpLZ3IvQXp4SUZWRHRSLzRmZWhF?=
 =?utf-8?B?dTliaEFNTVVGTitPZXEzb1FOUDJ3Tm1XSVBUZGJvV0NwMEF5KytMMW1Ua0c3?=
 =?utf-8?B?SVlRN2d6MW5lcU1yR0Vrak4yNEp3NjcraElYWFl3eUg2SzBwVGNNbGNFK0dk?=
 =?utf-8?B?MlNKWlJkOVVWVWtPLzRXTytKVUdxOXVoVWZsdnMzcXJIcWFJZUg0K29ia0hl?=
 =?utf-8?B?RTJhczQ2UW8xb3RBaHYxd0VVUllycW9DKysreUhaU1pGYjVBNUhUU211UDNn?=
 =?utf-8?B?MlU0TllLZTdQZGorQVhZd09jdUdQc2QxUExVa3hlZzJCREpsUGZnZThLUjZH?=
 =?utf-8?B?ZU1KYVZwM1ZERDZ2N21TcmpRTXR0R2diTVNsck5jVElqZXQzWEQwSkJFT1lx?=
 =?utf-8?B?UmJXTjFTWXZqVjNWWFR1U05NeEdMK3VVT2JkMks1MkFKcVVmRXBPc0loU203?=
 =?utf-8?B?QmltR1EyeU5CM2RpNDRmZjhPWUswcGpxVXZKZEFyVDJSSUM1K2hMSDVkWmxh?=
 =?utf-8?B?ODJReWNJeE53am1sY2xlS3NLU3RwQktBS3BJd1U5V3ZJSmM2dzVYQ2N2dzZT?=
 =?utf-8?B?emJtZ2syTmEyc2x1RGpsMXQ1L3dTdDRsTTBiOVRMV3VkblE3d0dKR0J3ZTRT?=
 =?utf-8?B?SVhzVjNDbVIxaUNkRkM1V3BXTjhUcjdPYXZlZittb0pNNnY1SXRMcDdFN2x6?=
 =?utf-8?B?VE1KbG94aVY3YzZVUUNiMzdweVRYN2swYzRoTDR2VURqZG1BQ1NzMDBSSzN0?=
 =?utf-8?B?WWJaRjJBd1JqaXR3UndUQkxMK2VjQUNWeHJDY3ZOODd6SEhtcng5d2ZsYjJN?=
 =?utf-8?B?SHJZZ2NJNmxyeUloRnZzb0dLbzJweVNwQWs2TURKZGY5RHBCd2wxb3paOThM?=
 =?utf-8?B?SkR0Y1Mzd09QTDYrQUlvV252NnpNdUgveVVyVFY1SENGd1NZNFVtYUxqdVRi?=
 =?utf-8?B?ZWxrMDg2SzlEd0JSYjkvcFhCL2pqYkhXZ1pTR1ZrUklsdGlscG5GVndzemlT?=
 =?utf-8?Q?2OaARqOtLolBLG8PzcRt7aT1qwJKFo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2tDdnJMVGV6MDZYb3c0MmgvODRDTysxZnNRM1cwMnplWGlydFZ5amxFeDYv?=
 =?utf-8?B?Wk9SYlFTaThvK3hhdkxPRWFQamlza0RVTXY3bWlrK3VlZ3FRcGJVM2ZIeEx6?=
 =?utf-8?B?YURma3c0ZzBkRy9TR2ovTmdmQTR6dU1pZXVqaU5PWU13NkxYTllVRUVrQTBE?=
 =?utf-8?B?V3FyWlNaRU9OTmZsK2JxSDJzcWt0cDJNMmtHSjVtQXcrTmQwZkpxYXVIeUFU?=
 =?utf-8?B?VW9tK0xWY0VmdUl0bzhTaDR6SWxSSDArOHdKWlJaSTkwRFVPTyt2WXU0Y3hE?=
 =?utf-8?B?NE1mZjA4cGZZUVpSZTFZakZodXd2UWxJUFFtc09HMEVYeFZ5SHowWUV6L0xU?=
 =?utf-8?B?SG8rN3hIZ1VlZ1kzUTdOOXY0cGZaWjdWdE5na0dvYTZCKy81L0ZmTitPTUpN?=
 =?utf-8?B?MUdnUVhxSDh5aHhDRGNQM3Z3QldHNEhtaEE2YkNuWW00Qllnd2J3MDJGVmZx?=
 =?utf-8?B?QUpFdlVyU25iamtXaUxwRElGc3F3d3NRdDZUT2hpYlFwU0Frek4xNFZYUm9l?=
 =?utf-8?B?MzQzZncwcW50eHBRN0M4TjhtOWJKSUFMaEUydjRpMnNIMDM2dUx0MkJWT1E4?=
 =?utf-8?B?ZSs5Z3kxaEU5YUgwTmFpWThSanJQdHdHc2JjNnV1dE9aeXJDRzFXblpvTVpY?=
 =?utf-8?B?eHBPUS85azNUempEY0V2R0N5QUJSZ3RhNWRKRjVjYnpLYlJ2cDY4bHpabW9r?=
 =?utf-8?B?MVAxMlJCYUp5K0piS2ZaME5STUZJdmVWWVhGZXh3V0VhakhSNkswNWJyNjR2?=
 =?utf-8?B?M2xXWGx5SFlQVWZSOVRvZklJajV5ZWJ4TnBzMEJkTVZvZ1JIcFFkMWFqTU0r?=
 =?utf-8?B?dmI0OW9zdWhTbEJPYU9EcFQrTElhTnNKbGs5Tmxvb1Avelg2QU9VaFg1UkhO?=
 =?utf-8?B?VjAvekNkdSs0K253bDRrcjVwUWx4MldleEdSOGhmQlBscUxNUE02anJhL2V4?=
 =?utf-8?B?bFRETllQUXZveCt4elNyRzd1OSs1L2hreFl2YjJLWisyRnp0Um5iN2pmWVhU?=
 =?utf-8?B?OXlPa0o4blladE5jaEVSSTlKQnpWTzRXWCtvV1FzZmU5K2Jpa3ZRY2dNM3J3?=
 =?utf-8?B?a0J6OHdxZ25qVzNSZytVb0oxSUFETStnZ0tvcUdTQThQbXR6bHJPVVQ5Ukc2?=
 =?utf-8?B?YnZUY3VERy9xQ3l2ZnZiZnpzNVF3T0ZDYU5UT3NEaFZnT0FFa2srRkQxK2Fr?=
 =?utf-8?B?QXhNNW5EMmpTdzNIMnBDZW93c2E4VGU5ZU9VWGo5Q0JYTFpuQXRSTHdxOENS?=
 =?utf-8?B?UDBNL1ZETlBtSnhUUWNtTjZwaE5jZUR5cEYzTXBka3lBZHRFTE9rdDVmODR2?=
 =?utf-8?B?dFF5VVBhdzExbDBvMGJqMXNCYzRtSFAxSm1rZ0FMTW9ObWZoN2lwczA5RUF6?=
 =?utf-8?B?MUNYR0dNdkYyYmMzTHcrSm05eEFxZ3I3aTBmcFRtRnVjSmR2YVh1Ni9PaFRZ?=
 =?utf-8?B?T2tGaXpxYjVROVhsekdVcHI4Nkl6VmpuOFFKTkZqZUxnRGZkanN4NDIyNmt5?=
 =?utf-8?B?cHdETlpoanlrZy9Kb0F0VTJReGhaaFB4ejhsTHY4ZjRIVnlVRDhkZzR4SFIy?=
 =?utf-8?B?dEFDb1FtVUw4dW8xRzBLZDA1OFo0K0QwK3BTdnpNQXpLWU9yVGZOdVZVSHRJ?=
 =?utf-8?B?aUJrRkhwblZjcUNnaWpxWGNGcmxwZW1CcjFrTWxhRDNDM0tjUUVualZCSGNm?=
 =?utf-8?B?MjMvU2VJZjJ5bHlOZkxQQUZMaDRFOVZmTFNCWWttUXdHNzUvYWlhMjY1cVRJ?=
 =?utf-8?B?TXdGV0tNSzdJRythUWplYkZWUTloem5sQ0FKczIvVU9lY0pjZmlQd0FJSExq?=
 =?utf-8?B?Q0plaXp4UmZJZjBka1VyMEUyWXJhVnRYek9oZ2p0QXUwT25DbFRjNzYzOWln?=
 =?utf-8?B?VXYwdWZqRmhFWiswQVVYMUJqcnJwL1kxOFJla1NtT2FuaGJieTFObFlOQ095?=
 =?utf-8?B?dENYRXErbXlZbE9NZGRuSVBqWjQzRUx4b2RhNzlTSWdHTndqNUtiSDhBSTNH?=
 =?utf-8?B?eDN1U1BGS3pIM1JlUGhWUUVlY3c5TnJLbng4enFBYlZTb3ppUDRaMXJDNVhF?=
 =?utf-8?B?UDkrZXpvL3ZOcndJbVM3SWNZL2hVbCtOTDlMN3BnaEpoYkpBUis4S3p5TFJa?=
 =?utf-8?B?L095R0NpaEpMc3QyMXVqRGxEMkxaSHAyb2pseFBBblVHN3I5MGhIRUhldE12?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7A5D3C3DA36EB46891BD04908BB823C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e27f77a-b3ce-4d47-a7f6-08ddbf7aecfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 06:28:03.8858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73zWPi07F4YoXnkXfLuTgxHmNpJES+TmJFjEX+FBtiP3BwyBZHy1aCZCH6IjEW4KK3iUiIDlZ9OQZ1FMiHX5qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3887
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA1NCBTYWx0ZWRfX/0v1qCUY64hb NwrsHS9g+r2kUQjF8nG5ExjQzF81VaGsQWmmmfgYcJCsNaGPL4i+x6WrYU9eMT9egV9rpHGluSZ ntx8bwjoRQDyrL8ZBMxqfzV4NGK2GuHl2wyUm58XcgyMgioWkTBf0PALCB5oC8M58qxgPCj3rK1
 E59OeWpwGuTnnt7mBhd7wyJvUzhGJWBvhl42iDD7ZgEGRwOiZ6Vcqf25arb4SkgicwPnpi7kfTt Ozo1JxaLsINbcFen6hhqQeabfAgjtEcl+7XKHo/DXII/NQ7AzWgb7XyTpmz852s/ldT/tpHDo6x NhBLq5IEqsukzWi8FiIQsI18YZe88eXIuPaXw3lYudSEZb8rdjVtQCSpo0ybzb3mpYB2EuRvL8a
 uIzl77ddTfvMsJ5RsthrX+a8sJhuHMbWgalTUhSx6pCWcr0IY+ssrkjN6TnYwIFMZ3oHBPcS
X-Authority-Analysis: v=2.4 cv=ecA9f6EH c=1 sm=1 tr=0 ts=686f5d77 cx=c_pps a=6OJZajHV9Y36iw+II7C7og==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=1gIJvGS3JCMSx5QAlp0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9A59x1sbTyXyLNtPcnQoMKq1So6Ssp6U
X-Proofpoint-ORIG-GUID: 9A59x1sbTyXyLNtPcnQoMKq1So6Ssp6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01

DQoNCj4gT24gSnVsIDksIDIwMjUsIGF0IDU6NTjigK9QTSwgTmVpbEJyb3duIDxuZWlsQGJyb3du
Lm5hbWU+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAxMCBKdWwgMjAyNSwgU29uZyBMaXUgd3JvdGU6
DQo+PiANCj4+IA0KPj4+IE9uIEp1bCA5LCAyMDI1LCBhdCAzOjI04oCvUE0sIE5laWxCcm93biA8
bmVpbEBicm93bi5uYW1lPiB3cm90ZToNCj4+IFsuLi5dDQo+Pj4+IA0KPj4+PiBIb3cgc2hvdWxk
IHRoZSB1c2VyIGhhbmRsZSAtRUNISUxEIHdpdGhvdXQgTE9PS1VQX1JDVSBmbGFnPyBTYXkgdGhl
DQo+Pj4+IGZvbGxvd2luZyBjb2RlIGluIGxhbmRsb2NrZWQ6DQo+Pj4+IA0KPj4+PiAvKiBUcnkg
UkNVIHdhbGsgZmlyc3QgKi8NCj4+Pj4gZXJyID0gdmZzX3dhbGtfYW5jZXN0b3JzKHBhdGgsIGxs
X2NiLCBkYXRhLCBMT09LVVBfUkNVKTsNCj4+Pj4gDQo+Pj4+IGlmIChlcnIgPT0gLUVDSElMRCkg
ew0KPj4+PiBzdHJ1Y3QgcGF0aCB3YWxrX3BhdGggPSAqcGF0aDsNCj4+Pj4gDQo+Pj4+IC8qIHJl
c2V0IGFueSBkYXRhIGNoYW5nZWQgYnkgdGhlIHdhbGsgKi8NCj4+Pj4gcmVzZXRfZGF0YShkYXRh
KTsNCj4+Pj4gDQo+Pj4+IC8qIG5vdyBkbyByZWYtd2FsayAqLw0KPj4+PiBlcnIgPSB2ZnNfd2Fs
a19hbmNlc3RvcnMoJndhbGtfcGF0aCwgbGxfY2IsIGRhdGEsIDApOw0KPj4+PiB9DQo+Pj4+IA0K
Pj4+PiBPciBkbyB5b3UgbWVhbiB2ZnNfd2Fsa19hbmNlc3RvcnMgd2lsbCBuZXZlciByZXR1cm4g
LUVDSElMRD8NCj4+Pj4gVGhlbiB3ZSBuZWVkIHZmc193YWxrX2FuY2VzdG9ycyB0byBjYWxsIHJl
c2V0X2RhdGEgbG9naWMsIHJpZ2h0Pw0KPj4+IA0KPj4+IEl0IGlzbid0IGNsZWFyIHRvIG1lIHRo
YXQgdmZzX3dhbGtfYW5jZXN0b3JzKCkgbmVlZHMgdG8gcmV0dXJuIGFueXRoaW5nLg0KPj4+IEFs
bCB0aGUgY29tbXVuaWNhdGlvbiBoYXBwZW5zIHRocm91Z2ggd2Fsa19jYigpDQo+Pj4gDQo+Pj4g
d2Fsa19jYigpIGlzIGNhbGxlZCB3aXRoIGEgcGF0aCwgdGhlIGRhdGEsIGFuZCBhICJtYXlfc2xl
ZXAiIGZsYWcuDQo+Pj4gSWYgaXQgbmVlZHMgdG8gc2xlZXAgYnV0IG1heV9zbGVlcCBpcyBub3Qg
c2V0LCBpdCByZXR1cm5zICItRUNISUxEIg0KPj4+IHdoaWNoIGNhdXNlcyB0aGUgd2FsayB0byBy
ZXN0YXJ0IGFuZCB1c2UgcmVmY291bnRzLg0KPj4+IElmIGl0IHdhbnRzIHRvIHN0b3AsIGl0IHJl
dHVybnMgMC4NCj4+PiBJZiBpdCB3YW50cyB0byBjb250aW51ZSwgaXQgcmV0dXJucyAxLg0KPj4+
IElmIGl0IHdhbnRzIGEgcmVmZXJlbmNlIHRvIHRoZSBwYXRoIHRoZW4gaXQgY2FuIHVzZSAobmV3
KQ0KPj4+IHZmc19sZWdpdGltaXplX3BhdGgoKSB3aGljaCBtaWdodCBmYWlsLg0KPj4+IElmIGl0
IHdhbnRzIGEgcmVmZXJlbmNlIHRvIHRoZSBwYXRoIGFuZCBtYXlfc2xlZXAgaXMgdHJ1ZSwgaXQg
Y2FuIHVzZQ0KPj4+IHBhdGhfZ2V0KCkgd2hpY2ggd29uJ3QgZmFpbC4NCj4+PiANCj4+PiBXaGVu
IHJldHVybmluZyAtRUNISUxEIChlaXRoZXIgYmVjYXVzZSBvZiBhIG5lZWQgdG8gc2xlZXAgb3Ig
YmVjYXVzZQ0KPj4+IHZmc19sZWdpdGltaXplX3BhdGgoKSBmYWlscyksIHdhbGtfY2IoKSB3b3Vs
ZCByZXNldF9kYXRhKCkuDQo+PiANCj4+IFRoaXMgbWlnaHQgYWN0dWFsbHkgd29yay4gDQo+PiAN
Cj4+IE15IG9ubHkgY29uY2VybiBpcyB3aXRoIHZmc19sZWdpdGltaXplX3BhdGguIEl0IGlzIHBy
b2JhYmx5IHNhZmVyIGlmIA0KPj4gd2Ugb25seSBhbGxvdyB0YWtpbmcgcmVmZXJlbmNlcyB3aXRo
IG1heV9zbGVlcD09dHJ1ZSwgc28gdGhhdCBwYXRoX2dldA0KPj4gd29u4oCZdCBmYWlsLiBJbiB0
aGlzIGNhc2UsIHdlIHdpbGwgbm90IG5lZWQgd2Fsa19jYigpIHRvIGNhbGwgDQo+PiB2ZnNfbGVn
aXRpbWl6ZV9wYXRoLiBJZiB0aGUgdXNlciB3YW50IGEgcmVmZXJlbmNlLCB0aGUgd2Fsa19jYiB3
aWxsIA0KPj4gZmlyc3QgcmV0dXJuIC1FQ0hJTEQsIGFuZCBjYWxsIHBhdGhfZ2V0IHdoZW4gbWF5
X3NsZWVwIGlzIHRydWUuDQo+IA0KPiBXaGF0IGlzIHlvdXIgY29uY2VybiB3aXRoIHZmc19sZWdp
dGltaXplX3BhdGgoKSA/Pw0KPiANCj4gSSd2ZSBzaW5jZSByZWFsaXNlZCB0aGF0IGFsd2F5cyBy
ZXN0YXJ0aW5nIGluIHJlc3BvbnNlIHRvIC1FQ0hJTEQgaXNuJ3QNCj4gbmVjZXNzYXJ5IGFuZCBp
c24ndCBob3cgbm9ybWFsIHBhdGgtd2FsayB3b3Jrcy4gIFJlc3RhcnRpbmcgbWlnaHQgYmUNCj4g
bmVlZGVkLCBidXQgdGhlIGZpcnN0IHJlc3BvbnNlIHRvIC1FQ0hJTEQgaXMgdG8gdHJ5IGxlZ2l0
aW1pemVfcGF0aCgpLg0KPiBJZiB0aGF0IHN1Y2NlZWRzLCB0aGVuIGl0IGlzIHNhZmUgdG8gc2xl
ZXAuDQo+IFNvIHJldHVybmluZyAtRUNISUxEIG1pZ2h0IGp1c3QgcmVzdWx0IGluIHZmc193YWxr
X2FuY2VzdG9ycygpIGNhbGxpbmcNCj4gbGVnaXRpbWl6ZV9wYXRoKCkgYW5kIHRoZW4gY2FsbGlu
ZyB3YWxrX2NiKCkgYWdhaW4uICBXaHkgbm90IGhhdmUNCj4gd2Fsa19jYigpIGRvIHRoZSB2ZnNf
bGVnaXRpbWl6ZV9wYXRoKCkgY2FsbCAod2hpY2ggd2lsbCBhbG1vc3QgYWx3YXlzDQo+IHN1Y2Nl
ZWQgaW4gcHJhY3RpY2UpLg0KDQpBZnRlciByZWFkaW5nIHRoZSBlbWFpbHMgYW5kIHRoZSBjb2Rl
IG1vcmUsIEkgdGhpbmsgSSBtaXN1bmRlcnN0b29kIA0Kd2h5IHdlIG5lZWQgdG8gY2FsbCB2ZnNf
bGVnaXRpbWl6ZV9wYXRoKCkuIFRoZSBnb2FsIG9mIOKAnGxlZ2l0aW1pemXigJ0gDQppcyB0byBn
ZXQgYSByZWZlcmVuY2Ugb24gQHBhdGgsIHNvIGEgcmVmZXJlbmNlLWxlc3Mgd2FsayBtYXkgbm90
DQpuZWVkIGxlZ2l0aW1pemVfcGF0aCgpIGF0IGFsbC4gRG8gSSBnZXQgdGhpcyByaWdodCB0aGlz
IHRpbWU/IA0KDQpIb3dldmVyLCBJIHN0aWxsIGhhdmUgc29tZSBjb25jZXJuIHdpdGggbGVnaXRp
bWl6ZV9wYXRoOiBpdCByZXF1aXJlcw0KbV9zZXEgYW5kIHJfc2VxIHJlY29yZGVkIGF0IHRoZSBi
ZWdpbm5pbmcgb2YgdGhlIHdhbGssIGRvIHdlIHdhbnQNCnRvIHBhc3MgdGhvc2UgdG8gd2Fsa19j
YigpPyBJSVVDLCBvbmUgb2YgdGhlIHJlYXNvbiB3ZSBwcmVmZXIgYSANCmNhbGxiYWNrIGJhc2Vk
IHNvbHV0aW9uIGlzIHRoYXQgaXQgZG9lc27igJl0IGV4cG9zZSBuYW1laWRhdGEgKG9yIGENCnN1
YnNldCBvZiBpdCkuIExldHRpbmcgd2Fsa19jYiB0byBjYWxsIGxlZ2l0aW1pemVfcGF0aCBhcHBl
YXJzIHRvIA0KZGVmZWF0IHRoaXMgYmVuZWZpdCwgbm8/IA0KDQoNCkEgc2VwYXJhdGUgcXVlc3Rp
b24gYmVsb3cuIA0KDQpJIHN0aWxsIGhhdmUgc29tZSBxdWVzdGlvbiBhYm91dCBob3cgdmZzX3dh
bGtfYW5jZXN0b3JzKCkgYW5kIHRoZSANCndhbGtfY2IoKSBpbnRlcmFjdC4gTGV04oCZcyBsb29r
IGF0IHRoZSBsYW5kbG9jayB1c2UgY2FzZTogdGhlIHVzZXIgDQoobGFuZGxvY2spIGp1c3Qgd2Fu
dCB0byBsb29rIGF0IGVhY2ggYW5jZXN0b3IsIGJ1dCBkb2VzbuKAmXQgbmVlZCB0byANCnRha2Ug
YW55IHJlZmVyZW5jZXMuIHdhbGtfY2IoKSB3aWxsIGNoZWNrIEBwYXRoIGFnYWluc3QgQHJvb3Qs
IGFuZCANCnJldHVybiAwIHdoZW4gQHBhdGggaXMgdGhlIHNhbWUgYXMgQHJvb3QuIA0KDQpJSVVD
LCBpbiB0aGlzIGNhc2UsIHdlIHdpbGwgcmVjb3JkIG1fc2VxIGFuZCByX3NlcSBhdCB0aGUgYmVn
aW5uaW5nDQpvZiB2ZnNfd2Fsa19hbmNlc3RvcnMoKSwgYW5kIGNoZWNrIHRoZW0gYWdhaW5zdCBt
b3VudF9sb2NrIGFuZCANCnJlbmFtZV9sb2NrIGF0IHRoZSBlbmQgb2YgdGhlIHdhbGsuIChNYXli
ZSB3ZSBhbHNvIG5lZWQgdG8gY2hlY2sgDQp0aGVtIGF0IHNvbWUgcG9pbnRzIGJlZm9yZSB0aGUg
ZW5kIG9mIHRoZSB3YWxrPykgSWYgZWl0aGVyIHNlcQ0KY2hhbmdlZCBkdXJpbmcgdGhlIHdhbGss
IHdlIG5lZWQgdG8gcmVzdGFydCB0aGUgd2FsaywgYW5kIHRha2UNCnJlZmVyZW5jZSBvbiBlYWNo
IHN0ZXAuIERpZCBJIGdldCB0aGlzIHJpZ2h0IHNvIGZhcj8gDQoNCklmIHRoZSBhYm92ZSBpcyBy
aWdodCwgaGVyZSBhcmUgbXkgcXVlc3Rpb25zIGFib3V0IHRoZSANCnJlZmVyZW5jZS1sZXNzIHdh
bGsgYWJvdmU6IA0KDQoxLiBXaGljaCBmdW5jdGlvbiAodmZzX3dhbGtfYW5jZXN0b3JzIG9yIHdh
bGtfY2IpIHdpbGwgY2hlY2sgbV9zZXEgDQogICBhbmQgcl9zZXE/IEkgdGhpbmsgdmZzX3dhbGtf
YW5jZXN0b3JzIHNob3VsZCBjaGVjayB0aGVtLiANCjIuIFdoZW4gZWl0aGVyIHNlcSBjaGFuZ2Vz
LCB3aGljaCBmdW5jdGlvbiB3aWxsIGNhbGwgcmVzZXRfZGF0YT8NCiAgIEkgdGhpbmsgdGhlcmUg
YXJlIDMgb3B0aW9ucyBoZXJlOg0KICAyLmE6IHZmc193YWxrX2FuY2VzdG9ycyBjYWxscyByZXNl
dF9kYXRhLCB3aGljaCB3aWxsIGJlIGFub3RoZXINCiAgICAgICBjYWxsYmFjayBmdW5jdGlvbiB0
aGUgY2FsbGVyIHBhc3NlcyB0byB2ZnNfd2Fsa19hbmNlc3RvcnMuIA0KICAyLmI6IHdhbGtfY2Ig
d2lsbCBjYWxsIHJlc2V0X2RhdGEoKSwgYnV0IHdlIG5lZWQgYSBtZWNoYW5pc20gdG8NCiAgICAg
ICB0ZWxsIHdhbGtfY2IgdG8gZG8gaXQsIG1heWJlIGEg4oCccmVzdGFydOKAnSBmbGFnPw0KICAy
LmM6IENhbGxlciBvZiB2ZnNfd2Fsa19hbmNlc3RvcnMgd2lsbCBjYWxsIHJlc2V0X2RhdGEoKS4g
SW4gDQogICAgICAgdGhpcyBjYXNlLCB2ZnNfd2Fsa19hbmNlc3RvcnMgd2lsbCByZXR1cm4gLUVD
SElMRCB0byBpdHMNCiAgICAgICBjYWxsZXIuIEJ1dCBJIHRoaW5rIHRoaXMgb3B0aW9uIGlzIE5B
Q0tlZC4gDQoNCkkgdGhpbmsgdGhlIHJpZ2h0IHNvbHV0aW9uIGlzIHRvIGhhdmUgdmZzX3dhbGtf
YW5jZXN0b3JzIGNoZWNrDQptX3NlcSBhbmQgcl9zZXEsIGFuZCBoYXZlIHdhbGtfY2IgY2FsbCBy
ZXNldF9kYXRhLiBCdXQgdGhpcyBpcw0KRGlmZmVyZW50IHRvIHRoZSBwcm9wb3NhbCBhYm92ZS4g
DQoNCkRvIG15IHF1ZXN0aW9ucyBhYm92ZSBtYWtlIGFueSBzZW5zZT8gT3IgbWF5YmUgSSB0b3Rh
bGx5IA0KbWlzdW5kZXJzdG9vZCBzb21ldGhpbmc/DQoNClRoYW5rcywNClNvbmcNCg0K


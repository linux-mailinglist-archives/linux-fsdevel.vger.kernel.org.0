Return-Path: <linux-fsdevel+bounces-54404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769E5AFF4F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C4C1750FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE54423A9BD;
	Wed,  9 Jul 2025 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="suj116ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF41A23BE;
	Wed,  9 Jul 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101408; cv=fail; b=NDsGq1b/hdNvGoK/SxCVR+VBHA3uNDiQa7BoCRpF3+yVeWpph4ssF0HD65BNpSU7BnzIXkgSohPIb9DKx8h/i52/kMB8M9k9T04j9HCDS4bf0jXzqWIHEl+uGF3kgP0QI0Oty5JFwgfYqJXBN5/adJD+WJ2zA2Vyq1FJiQUpT1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101408; c=relaxed/simple;
	bh=CK4YO42AjCdjPOLDB97iY2GoMiYutb+/Xx2w+ZaYYPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lroit5uDs/hYYJhVKmAACNNc4W6IWUEbpLET3E1dSrMuxhWf1VIolPAfRmw13brIcDMX5IBA2v9VXP3gnuu3ar1T7gpZisIxba+flrxwOb2g2YMh+i4WIr2omeYxkHgXsJp8CiZIhZb9zFl0Xl5hag0hW/tJx7wtx0MIVGPqrkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=suj116ct; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569M1qu0009899;
	Wed, 9 Jul 2025 15:50:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=CK4YO42AjCdjPOLDB97iY2GoMiYutb+/Xx2w+ZaYYPk=; b=
	suj116ctDzBbn/wIeZXuG3gFxb6V8MsjDC6UyJ6rwlsKEreX0KNhk+f2BforybC+
	XiCZg1ECz1CmOe58wp0gmEgecYyfywV80vS2MRjiGP7l6Shvbv0JYvoWrgHPKoKL
	L65IZ4ALM772v1vfg2XD5LNXgpm5x/aI45aERm9qBheA8keNTXjN9k+xi+K71q8S
	m0PQ48H02n6PwAUikK9LRpdQCSnBu28pjuouPF9SgV+5kgUSFmfVKgxTQgQmyWl1
	vNAuKyiUlWmonh8rtY2fW150BOeMYNImPz4xn2l376mI7geFQtvV4+hxL6dBxkBx
	x2DBQ4NO0wyDL7mPWb9BWQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47swgb1vva-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 15:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7PA5B3uxhc1JK3empO5oTsvWUTgIr6Eoz95APQOtMzov4W7CnzZv+C2wZlrYR00qfc5AeZORaGfd3vQBf3/nzz03NhKW2Gf3/nay71+5UHgTfQNQrKzr35v54pkpO/OE/0D1QqS6c52NxJmUcQnxBpPytIQfUqt4rGwyDanv3/mVSJQPAqPTF7KPSemAYxR8D8eBbKY8CRJ27xNfVQ2Mhy81WJY0kOWFKh8rsm1+k/Alxdob/JSam6S9hmjQ6w5yTCb39H2cGaSB2ThWBwniraZVdJ21TQOAZAfoWvyw4U3d4XbgGFKJptW6X2/27p2x6mgQKSpPhkpLJN52FowSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK4YO42AjCdjPOLDB97iY2GoMiYutb+/Xx2w+ZaYYPk=;
 b=R4xtofnwPaYZZjPHApo4KYYoe0uqoNj70H1ziWUl9OiKsXs3P4prw6D7p2h2mG5OY6M9khXNEz2lJT3TU1THvvadB6Czk7QbA3jc2rm+LH4GweLMDDNTciDrrJXn47JpOY+HgJYcGmnJ7Aj/2HyYaiHFG4e6NF4FFCSMajaLTwpwQXpVbLcFFCgsTjBG95QqgVPxNEUKVWeXbO0XYxwgjBWlKhg9GQ7HBOzJBwVDuxdhlwgLkipbYTjiHX8VkN3EPC/+14x9ikhYNFnLEcy9VRwz7/CusbVcFPwtyjEhvnLTlYH2zkBoqn/FXqpqd+2BoaRt1yYPBeMtFQ5ewtnFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB5055.namprd15.prod.outlook.com (2603:10b6:510:c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 22:50:02 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 22:50:02 +0000
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
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAEtZgIAARLiAgACMg4CAEH8tgIAACIOAgAB+hYCAAvcGAIAAF8IAgABRvgCAAAcpAA==
Date: Wed, 9 Jul 2025 22:50:02 +0000
Message-ID: <474C8D99-6946-4CFF-A925-157329879DA9@meta.com>
References: <C8FA6AFF-704B-4F8D-AE88-68E6046FBE01@meta.com>
 <175209985487.2234665.6008354090530669455@noble.neil.brown.name>
In-Reply-To: <175209985487.2234665.6008354090530669455@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB5055:EE_
x-ms-office365-filtering-correlation-id: 4c2e1f77-9f2a-483c-c470-08ddbf3af0aa
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVllbnN2MjhvZXYzeHVGclpqakh4c3JwL3d3Y1dVN2g0U1lmbXo3cEdlaHA2?=
 =?utf-8?B?QWZrbXJGTG43bXJDcW9aRmNnTzUrbzA1S0hDTkRqYkFPMEtlK0NjdmhscFlU?=
 =?utf-8?B?N1hZck12Y3lXQk1zZ0JCc0lIa3F2Z3NTNjlnYzVOVGdVNFE2eFJQZFIwNCtr?=
 =?utf-8?B?Wi9xd2w5UnF0Y1RBUERLNHlSaTJ6Ri9Fc3NyL1Y2cjFXZ2MvRGZnc0J1azZX?=
 =?utf-8?B?dzNvVnB3OElFck55MkQ4V25oMkV0WlAvNitzVTM5Yi9uOW4rdkR6STJxMGRN?=
 =?utf-8?B?d1JFQzRBZ01RRE82WXUvYkxORWE4WDZhdXNFLzNmeDlHQVZyMTdTWHpoUk1l?=
 =?utf-8?B?ZllCUHNTQ3ppbmZ3ODFYNFY5Mm50UmtESU1KdWovWDNVUDNnNktha2VuOUhr?=
 =?utf-8?B?MWl1Y2E1UGhVQS9XbFBIVzAzUkQ5WnczWm9ET054WUNrSS90WEZXSk1FeEpT?=
 =?utf-8?B?QVlqVWtmYTVHUEpGWXQvblVkNDZ5SXNDOUlnWnVjbUQyeEtOWFRSbDNUUlp4?=
 =?utf-8?B?dUluYWtlczZ1VkhFdGQrVnpkTUNIRkhwU3lWRzA1THBpY3hPc216ZkJRMTNz?=
 =?utf-8?B?SC92YWZCamg2RlUycDIzZEhMaGFrZkt0ZFdFUnBDUGdSQU1Yb0RXdFJqNHRU?=
 =?utf-8?B?MjAyMFdoSjFjWnRVWWF5M3FwT1dIT2NnMTVLWk1nTEhUMXZGUjNLZ1JZZS9k?=
 =?utf-8?B?WTQ1UFNPakJkS1V2bjd5Yjd2Sm8zY0c1UEFjNW9McjJmd3FMcUVjOGxiWldp?=
 =?utf-8?B?aWNDQlRidHlLQnVyeisvR1dOeVJCd3hQckgyNkoyZGtEUGRJUTlRSUQ5OW91?=
 =?utf-8?B?YlBPSEpUWXNrb3B3SXVmcUEvbGlBT25Ma3RPYzdPV3RUY0hBNVJISlpLWTNi?=
 =?utf-8?B?L2xHT2lIR3dwYzFRZkI1TXpJcFZGbWYxUTZ5WHNCQ0E0b1Y5ZHRZUUFpRDNu?=
 =?utf-8?B?WnNaYi9wZFBNRW9kNFVqNFBQcUlOdTRJcmJkZ0dWRVB2QVlOSU9FMXJQZ3o4?=
 =?utf-8?B?b2tWVjlrL3I4VGthTVZSb2U4UFgzVDVrT0w4eHVsR2xiWDI1NUp6UlBCVUJy?=
 =?utf-8?B?dmJERmFRT3ZJWTR4L2dsWUwxUkN2d215SGdGWFhzR0lVS285UnFSY0poSWZI?=
 =?utf-8?B?WGhvR0xEdVp3ek9pNVhPVTFWM05uV0JmWGcyVUdTd011bWptNklYd2NHMmJx?=
 =?utf-8?B?ang4RCtCWDhTOUMxWFFBTk9HTyt5ZFl2U0hncmMzL251OWNkZVpsdlNJQ1A3?=
 =?utf-8?B?S0U5SitPVlRaN0Y0cGFJUThYL2tkUElxRTFScEQyVC9EVWM2SFU0dmN3eHZv?=
 =?utf-8?B?bmp1eUdUQmJvS3NZY0h1NzNnWWx0Z2ttU2wzdTZXM0RIM0tzQVJtUENOSkV3?=
 =?utf-8?B?S0huSVdPQnQ0aDZ0SjNZSnpSMnZHdDR6T3RtRlNKaHFKY0FmNzE5dk9tcm1K?=
 =?utf-8?B?QUExYWJycDg2MmFOMTVQeERZODVBNjhLcnNEU0lQaHMwSnRMY2dYVElSM0NW?=
 =?utf-8?B?Sk9FT29hbGpIRVcweHZsVHozKzEzQ2YvOCtRa0hOc3RuL2YxWHlmdUU2bVpB?=
 =?utf-8?B?QUxHSEErY1JOWEc3dGpVRXAveXNEeGgxM0ozNlh3VnRLSzRsRE5BUTlFakxn?=
 =?utf-8?B?KzRsY05VWUNyZ3gySStvYkxSd3FoT0hWeUJwMTN6WmI5cjMzQWcwMS9RVlZZ?=
 =?utf-8?B?TW9wRHYyUWI0NlRDZk9QUFdIYnFScnNhZ0lrazdyN2tTUDRlQjhMemZtaXRT?=
 =?utf-8?B?dzlMMU1PRzBLc1ppbkh3dmxNQXBaa1MrNmVlUnJHZGRXenVrTGhmalVLRjRI?=
 =?utf-8?B?MWZvUGZxVExUVi93SDBldDQvVWNEOHdnUnFpd01WWEwxRC9SbkJkMklHNDJD?=
 =?utf-8?B?SzlidmJBL1k3cDU4WnJYcmFiWmpoaCtmb1F2TUN5M3BrQnRNcEsrR1RZbnY3?=
 =?utf-8?B?ZDNqZXN2UlZGUlFrM2wvaWVkcEc4c2doS1IrajlFWHdBeWRlT2JWd2dqQkNB?=
 =?utf-8?Q?dxmsHVXkEX4z4wDeVPv9Rj2+4O0ihg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGpNSkVKOUNxdXRvK0xzbGtrR1lNV3VTM1RPaHlnTmRwNFBOUTNEU1hhdzdq?=
 =?utf-8?B?WUVoUFlObmk4RURFaWtCVDdRMnllTjA4TGNRVGhWNXdJbjVaR3RweFRHMEtv?=
 =?utf-8?B?VisxRnNvWDEvcWZIWnlvVTZmcHoyY0tSa1MyVVR0U05oR2NDWkVIaUIzSjMw?=
 =?utf-8?B?MEgyS2ZReUROM2FqRnk4V1gyQ0NPR2ZkNWZSRmV3Z3RXVW1oSmNSeWh2Zk1L?=
 =?utf-8?B?LzVnVDZSMDZlMTRLeDNEY1VPRTRhK2g3VzhESzVKY3o2UkpPRDdaRC9kZUhD?=
 =?utf-8?B?YS9TK1FLTDB5UGs1MnNnVm42ckVRY0Q1NFNadGxNNWhOM1o4RmFJQWt5WjhV?=
 =?utf-8?B?UHpnYlBweUpYbXRENitpK1FTZ1U4MUJ5VCtQVWJ2QU03MnNqZnlqWEFlM3pQ?=
 =?utf-8?B?eVZHZS9JcCs2KzJyK1AwNXpJbUxvUTgyV2hkcS9ZMGlNWlRtT1plcU1ESUlQ?=
 =?utf-8?B?c1ViL3R2RDA1V0NuMmkrbmpvNHhSSUM2cnp0Z0lBWnNLeTljb2FOSFV0TElh?=
 =?utf-8?B?NVJCNDdlbzRVRWZTdGpaRWpNeDczdk1ldm9jN3N6eGs0MHNPd1Z5Wm9SUGty?=
 =?utf-8?B?dVRKNHMzU1ArVDBjcVJXY2RPbXFqMHcvQyttamdYc0QwZHZLVVJCc2R2akJX?=
 =?utf-8?B?NGgvY1Vjcm04Z1U4WE9kakMwQUtZNWVmQzdzWndMVnBPcFRmazdtSUd6TXh6?=
 =?utf-8?B?dnM1UC9jTzdSNWIzTHN2TDNqSmZJODlwRHVPVEdXRHgwK25VOStYMVRHUTlw?=
 =?utf-8?B?VnJtRVFnaXppVWNFMXNDbHlKb2ZFekRqeWR4U1l0eE9mWjRtSWRTdmZHNGpQ?=
 =?utf-8?B?dHBQL1BRV1JybzE2U1lnbnA0Yk5KSnc0ZElhOXYxaUM0V2hTUmU2elB5L3Nu?=
 =?utf-8?B?Z0lpSk1YdlByVHBCL1gyUXg5ZGZWbkVoa1NPRVFpaVc3ZFduR3kxUzBqTlYr?=
 =?utf-8?B?TTNjL0ZKZGgzUzRpaHRWTTZUTWo4S2xRRVBYcEdWdkFlSzB6Vm9VYVVCNysy?=
 =?utf-8?B?S3ZlUmw2NEZUMkpLWkpmdHVKTW1oK090MGNDR3BYVmRSOTYyZmNrbjNVeExN?=
 =?utf-8?B?QW5JN1VKUGlqVmF3WHdEU2UrZVVuckxUb3lKNFJFb3drMTZkYTluMTNXOHVP?=
 =?utf-8?B?ZnU4UTUzN1B0R1Z6WXloczAwb3JqUEg4QzdJdmVBSGdHckF5R0dkN2dNYXAw?=
 =?utf-8?B?S1d4ZHJOT1crVGd2bkptNks2VFVxd1FsOXUxYkpod0Nsa3haV2ZrclkyT2tl?=
 =?utf-8?B?UjZCdlNYQVdDczV2aDUvWkpUSThIcDlNcTlmQzlJK0lFYW5HeDFWNUdHVDMv?=
 =?utf-8?B?Ym5IVUl0SzkvTkM4TDhUL3g4SlFyd3lEeTZZa3RMRnphU0t1VDZlTFFEL1lR?=
 =?utf-8?B?c2I5OGtwS1I0M3VDZHNNR2dUMUNoUDlWQ3FuQWpuaEp0bnZ5TTZaRjZoeDNK?=
 =?utf-8?B?OVJFNjVnNWpuaUk5dlB2SmtDbnR4d1NuYmxnMkNsN1J6Z2t0ZjRZZkJzRCt0?=
 =?utf-8?B?MVVyL01LY2NVU2ZzaVBHMTh4VlU4ZXcxcVo5a0JQR3RYTmkxRmhjVE16c2tE?=
 =?utf-8?B?TlNyUVFYWjhzYzcxTDVwNzFEWU5YQjhvRE96dmtiZW1tWnFySXovZk5jN0dq?=
 =?utf-8?B?alJoMFBIbXhLdVAybnFCMExvZ0xKbXR5V2tjY3ZTeFBEaS9WeHArV1pGZGJI?=
 =?utf-8?B?RGV5ZU1xbURVc1kxMVRMY0tHVkJZbGx6UVdQRHdqRFMyWC91bVA4UGhDU1dV?=
 =?utf-8?B?TkRiMGt4L2xlU25DU21QS0gvaTN0TWhweCtkWlNqb0NjRWxVZlpFRFprNEFH?=
 =?utf-8?B?SlRaTlhQRllWWGpMTzluZHFRaXhOaG9LT1NQc0ZjeWNUVUVPRCtmU1dlUzMy?=
 =?utf-8?B?KzZhRFYwMHQvQlF1eVJyeThQcDZzamhDSXNNRWNNNmhueTJVYjZyQ2RtWlpM?=
 =?utf-8?B?dFFHRE1kOFpxTXNiNlBSZktVTHQ0QTNqVTdRNTVPV2I4bzVsZWJhY1pIZjcx?=
 =?utf-8?B?S2hZbk9uZHBGZEJHL010UUtleFFtMnVLT1hJZ1ZjeHlCRFpUajBWcmxNRzRr?=
 =?utf-8?B?blRZYytOMFN6ZDVxcW82WGtDK3I1TGlidjZGNFhYY2kyQnlBTm1NRTlyY3R1?=
 =?utf-8?B?L2xNNGxFTFFSc2hCcE85QnFCenpUWmppYmlMd3lBYUd5elRrOGZyYjdCNWVt?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C14F76AB4C406B4E827E1B6B34D19B69@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2e1f77-9f2a-483c-c470-08ddbf3af0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 22:50:02.2605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39sXoqEcjPZA4JkFrGvS1WK9iOy9cVOPQEP8svK/l8cui8dY7qUX6MTSi71j/Kznowhi3AdGfQW2yE4DJyCDEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5055
X-Proofpoint-GUID: pUIY_gkQJQambA5wld-t-55XsRfqpc32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDIwNSBTYWx0ZWRfX4k2+xc/2dpDt oH3Ygn26sEjAepJEhCNrxejeavHKTIsKuWnahmSQvHpk/8IuK9fvIVslbeqdRGRqLXjzChhlxbZ wLCod35iVWS61GbMZo+KdIBc2/mS7gvgCMBx/TgvRwnDSqIYMWMDT2ygI2rb4zUboZXGCyGltcU
 2ogmTdLaXsbKTGDDIDayW2BaW9FxPZHSC3yVdAajf8okGH1/nsRbN99MbCPBgCAKIFDI2lS1xwV rxIQAWktYhEdhW+PmOuqtyzZW9hDESOkpm6h4IUDeb303rxuhEcBGS/Cee+qiWwOzt0yKbc3rtF z9jRm3AXDmZgiZ12y2GUBzFtBY4X9oAokgY7jJQ1Ai+EbQPROLeyzhjbHHIMBVycqBhcdLxHvkv
 mHIJJqU/JmhWD8rYu5VL9pMRRHgib/xAyD80azElMlDk0mc3rVeHs2JpYQGPZStMlXHs6uxR
X-Proofpoint-ORIG-GUID: pUIY_gkQJQambA5wld-t-55XsRfqpc32
X-Authority-Analysis: v=2.4 cv=MuxS63ae c=1 sm=1 tr=0 ts=686ef21d cx=c_pps a=fmQ0HBAHMkSHzhHxSUKfLw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=5vJOtiziVzfZeLImsZkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01

DQoNCj4gT24gSnVsIDksIDIwMjUsIGF0IDM6MjTigK9QTSwgTmVpbEJyb3duIDxuZWlsQGJyb3du
Lm5hbWU+IHdyb3RlOg0KWy4uLl0NCj4+IA0KPj4gSG93IHNob3VsZCB0aGUgdXNlciBoYW5kbGUg
LUVDSElMRCB3aXRob3V0IExPT0tVUF9SQ1UgZmxhZz8gU2F5IHRoZQ0KPj4gZm9sbG93aW5nIGNv
ZGUgaW4gbGFuZGxvY2tlZDoNCj4+IA0KPj4gLyogVHJ5IFJDVSB3YWxrIGZpcnN0ICovDQo+PiBl
cnIgPSB2ZnNfd2Fsa19hbmNlc3RvcnMocGF0aCwgbGxfY2IsIGRhdGEsIExPT0tVUF9SQ1UpOw0K
Pj4gDQo+PiBpZiAoZXJyID09IC1FQ0hJTEQpIHsNCj4+IHN0cnVjdCBwYXRoIHdhbGtfcGF0aCA9
ICpwYXRoOw0KPj4gDQo+PiAvKiByZXNldCBhbnkgZGF0YSBjaGFuZ2VkIGJ5IHRoZSB3YWxrICov
DQo+PiByZXNldF9kYXRhKGRhdGEpOw0KPj4gDQo+PiAvKiBub3cgZG8gcmVmLXdhbGsgKi8NCj4+
IGVyciA9IHZmc193YWxrX2FuY2VzdG9ycygmd2Fsa19wYXRoLCBsbF9jYiwgZGF0YSwgMCk7DQo+
PiB9DQo+PiANCj4+IE9yIGRvIHlvdSBtZWFuIHZmc193YWxrX2FuY2VzdG9ycyB3aWxsIG5ldmVy
IHJldHVybiAtRUNISUxEPw0KPj4gVGhlbiB3ZSBuZWVkIHZmc193YWxrX2FuY2VzdG9ycyB0byBj
YWxsIHJlc2V0X2RhdGEgbG9naWMsIHJpZ2h0Pw0KPiANCj4gSXQgaXNuJ3QgY2xlYXIgdG8gbWUg
dGhhdCB2ZnNfd2Fsa19hbmNlc3RvcnMoKSBuZWVkcyB0byByZXR1cm4gYW55dGhpbmcuDQo+IEFs
bCB0aGUgY29tbXVuaWNhdGlvbiBoYXBwZW5zIHRocm91Z2ggd2Fsa19jYigpDQo+IA0KPiB3YWxr
X2NiKCkgaXMgY2FsbGVkIHdpdGggYSBwYXRoLCB0aGUgZGF0YSwgYW5kIGEgIm1heV9zbGVlcCIg
ZmxhZy4NCj4gSWYgaXQgbmVlZHMgdG8gc2xlZXAgYnV0IG1heV9zbGVlcCBpcyBub3Qgc2V0LCBp
dCByZXR1cm5zICItRUNISUxEIg0KPiB3aGljaCBjYXVzZXMgdGhlIHdhbGsgdG8gcmVzdGFydCBh
bmQgdXNlIHJlZmNvdW50cy4NCj4gSWYgaXQgd2FudHMgdG8gc3RvcCwgaXQgcmV0dXJucyAwLg0K
PiBJZiBpdCB3YW50cyB0byBjb250aW51ZSwgaXQgcmV0dXJucyAxLg0KPiBJZiBpdCB3YW50cyBh
IHJlZmVyZW5jZSB0byB0aGUgcGF0aCB0aGVuIGl0IGNhbiB1c2UgKG5ldykNCj4gdmZzX2xlZ2l0
aW1pemVfcGF0aCgpIHdoaWNoIG1pZ2h0IGZhaWwuDQo+IElmIGl0IHdhbnRzIGEgcmVmZXJlbmNl
IHRvIHRoZSBwYXRoIGFuZCBtYXlfc2xlZXAgaXMgdHJ1ZSwgaXQgY2FuIHVzZQ0KPiBwYXRoX2dl
dCgpIHdoaWNoIHdvbid0IGZhaWwuDQo+IA0KPiBXaGVuIHJldHVybmluZyAtRUNISUxEIChlaXRo
ZXIgYmVjYXVzZSBvZiBhIG5lZWQgdG8gc2xlZXAgb3IgYmVjYXVzZQ0KPiB2ZnNfbGVnaXRpbWl6
ZV9wYXRoKCkgZmFpbHMpLCB3YWxrX2NiKCkgd291bGQgcmVzZXRfZGF0YSgpLg0KDQpUaGlzIG1p
Z2h0IGFjdHVhbGx5IHdvcmsuIA0KDQpNeSBvbmx5IGNvbmNlcm4gaXMgd2l0aCB2ZnNfbGVnaXRp
bWl6ZV9wYXRoLiBJdCBpcyBwcm9iYWJseSBzYWZlciBpZiANCndlIG9ubHkgYWxsb3cgdGFraW5n
IHJlZmVyZW5jZXMgd2l0aCBtYXlfc2xlZXA9PXRydWUsIHNvIHRoYXQgcGF0aF9nZXQNCndvbuKA
mXQgZmFpbC4gSW4gdGhpcyBjYXNlLCB3ZSB3aWxsIG5vdCBuZWVkIHdhbGtfY2IoKSB0byBjYWxs
IA0KdmZzX2xlZ2l0aW1pemVfcGF0aC4gSWYgdGhlIHVzZXIgd2FudCBhIHJlZmVyZW5jZSwgdGhl
IHdhbGtfY2Igd2lsbCANCmZpcnN0IHJldHVybiAtRUNISUxELCBhbmQgY2FsbCBwYXRoX2dldCB3
aGVuIG1heV9zbGVlcCBpcyB0cnVlLiANCg0KRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/IERpZCBJIG1p
c3MgYW55IGNhc2VzPyANCg0KVGhhbmtzLA0KU29uZw0KDQo=


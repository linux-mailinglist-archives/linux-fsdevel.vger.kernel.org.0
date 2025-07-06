Return-Path: <linux-fsdevel+bounces-54036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481EAAFA87F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 01:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F19174A47
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 23:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D71288526;
	Sun,  6 Jul 2025 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AOkn8Tl5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEFF510;
	Sun,  6 Jul 2025 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751846106; cv=fail; b=InxdinUiX6mBKj0dm4DdOhABv3evNev59gnMXRPTZDEEgg4CVsLmeh4gelGv/gEDGE5Z70TXowhjZreXXmaEbZcoLLeHSF9TuS45ViZJHLVSwYXBIUeGDFh9Dn5kaoEDxAMsw9VECA25NHMUdLz4dJAy+1AlIt0FSR8/hYSvRQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751846106; c=relaxed/simple;
	bh=gDqOMlOy0o3NXWjuBD6G6HzzTYgp1yd6VXCYKM3jRH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j40h5AGvSRKt6w2oe1MjgyI/A1cHwKsFSRJ85NTIflu/TAAmJWuo5fYqrPuIBXArEsJTKPyiqrF4htJ6dkOoW5T7bOUiaCSBrEsbuhZOIVEOl5+Prj/uyTcw+iL/lBwPBBvU13ZwCt28059FgAGYSGseTuAhf4cBhrSYsDKHbqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AOkn8Tl5; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566FglMA015625;
	Sun, 6 Jul 2025 16:55:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=gDqOMlOy0o3NXWjuBD6G6HzzTYgp1yd6VXCYKM3jRH0=; b=
	AOkn8Tl5pO3R4a8lrr2+NUC8LJm1NJb5tctvVwtzudyM8bf5SH6Glam3WFZr0Pc0
	jmtyNV24PccICny5h4JOR3PdBFaIkfg3aG24cm6OEqSMdB/I4VLFTd4ZtDCXTrI2
	F8g/J2AyDGmZbDcMjf7vTdQMmbkjrzbS0ifbD5AhPTzi44xtUQHBSC0CM3OzrBRj
	9TlWFCAVP3FT4wgf5q1o1eErzQj4IafImlZ9WhOsHPKX98OJe5OjYV/4EXWnxbUT
	0cAVEyGYphjbezXMbFZyUFJbNJfDztL0X63A3GFYvtyPMHgXNXp6hp3MUwqMdKTp
	Lgz8DM4lSfcFi849+vOFzQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47qv0u19by-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Jul 2025 16:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8F2GhvSw7bo32T2v5brBm7GvPBUBu2jAM20Iimv/RqAcHkbsH9CYRKb23Eg8l+WIA9gA9IZuGzajQxx7i9RuaaFVRwXOOURiOF5+jC+Z5ViSpy5iF7+PsxIvE/FgeOSRxWsg3xh7/iRFHX4QIvBLI5ZjCVIIh/O6w1o8TYYzTV5xRxHTLu3SyMDh7ltP9buNLIrbJKnAlkUVBQLT4fmlPyzFpUVZRetnzDiurcdme4EVPp/l3fTtviT28yByWGcPvfpVpOd23H7dj+VAFB2L1HDny71faZsGH+5X1l8FjK5LFNnfWk949Fl0xjlKQmUU7YTvJNXfJG8WqdJMPyc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDqOMlOy0o3NXWjuBD6G6HzzTYgp1yd6VXCYKM3jRH0=;
 b=sR63r3xgD+6y3sETQmqlWQBx0OC+jB9Qf9Fp6arOrKgxzh9Urnoz1+HU5gNayn8kpOgvcLoTUi/tnmLH09HoHnwzGonQGRmu104JMhYnRpmXt19Spr6xIVPXFIhiiph4CuuuLXHqtmv4MfEJlrIWcqPZYulaoODMdjyvuftPGoIIWD8X4IwiY8lF32AVIF8SXYgYmzcKNppTQkZgsSR+MjIlOqpQdFY5E7NGr2a+wrRfZJY72+v8keP3Oz4dPO5BJLHGlyTs4HU1pjdYkovSN++KQZMi5iureQMn9DgdvSShWwrAU4GoIPmpeOeSPUPb/3VDNtTrdwMNfMpJ1Ltdmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4620.namprd15.prod.outlook.com (2603:10b6:303:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Sun, 6 Jul
 2025 23:54:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8901.024; Sun, 6 Jul 2025
 23:54:58 +0000
From: Song Liu <songliubraving@meta.com>
To: Yonghong Song <yonghong.song@linux.dev>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "m@maowtm.org" <m@maowtm.org>, "neil@brown.name"
	<neil@brown.name>
Subject: Re: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Thread-Topic: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Thread-Index: AQHb306rkWVEwzG09UqE+pq51+4LMbQiVswAgAONS4A=
Date: Sun, 6 Jul 2025 23:54:58 +0000
Message-ID: <58FB95C4-1499-4865-8FA7-3E1F64EB5EDE@meta.com>
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-2-song@kernel.org>
 <2459c10e-d74c-4118-9b6d-c37d05ecec02@linux.dev>
In-Reply-To: <2459c10e-d74c-4118-9b6d-c37d05ecec02@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW4PR15MB4620:EE_
x-ms-office365-filtering-correlation-id: caaba356-030e-4d3b-3e65-08ddbce8838c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnE5VUFWSHQ4RkxwN1dvNWVNQzhvWXJoMDZQSzhuNnlnQlp3MFhIK01EN1o1?=
 =?utf-8?B?WWlySTM2dk5HRmFYYmt2M1VQQ0J6UE5IK01OYnQwZWNmWkFJcnRNaGdDY3Vw?=
 =?utf-8?B?aXM2SlBYd29ZR0xEaVJHN3luRWk5bGN4RTNvd05aY2xuMzF1TjB1VVRGNC9P?=
 =?utf-8?B?cVlzNTAwcTdqSDZTZTVabmhST0p3R0xiVmJpbmF2bk8rdWkwMENXVWw0QUN5?=
 =?utf-8?B?RU9rZDIvcldrd0xwOEZDS3VsYzRObnV6R3BjRk9LeXkwMHhBa01nM3huTG1t?=
 =?utf-8?B?MzcwcUEzNytZTFZPVHVuNWU4dnA4OGY0R1diWlkxVjZwTGV5Zm5OVXM3dVNG?=
 =?utf-8?B?Uno1ZkxVMm1DcE9lUGNaaHJ4RS9wOVd1RSs5aEFsc1dYcnR3Qko0RHNpNmpy?=
 =?utf-8?B?RGtLN05KQ3V4Ri9HZm9HSm1oWE1FYXRwZ2t0TTNqanJtZ3drcGVndkpSczBT?=
 =?utf-8?B?bWoyYXV3Vk0vVXNIMVozUnIxb1o5OU5waElvc2lFUkVFQUQzVDV4M1o3d3Zz?=
 =?utf-8?B?MVREdEhuNkJ2c0ZZVWpUb3B2ekRQOUxLUC9GWFZwbURGNVlLNHNaa1NCbTJW?=
 =?utf-8?B?R0F5bk1VZDBnMXpsRjFPMkNGVkNCQUhSY0xLR2NBQ1p4RnFaVlpzR0RrTENa?=
 =?utf-8?B?cDBqYm11ZHBBSHA0SjlsVkxiR01VNko1OTRuV1lwQ1lxWUlCZWd6QVRLcExP?=
 =?utf-8?B?UzYveDJweDAycEFoN2RBVFYrak5rWCtFUURpdE84VExSSE0ycm50N0pnVzln?=
 =?utf-8?B?bDFnbjNUbFMvZWZYbjd2T1JWVVBYSnk5dm4vaUptSkVHNHNFQ3RuMDBJQTNX?=
 =?utf-8?B?UG1jam5SM0dxMzZvZG9mT3FDdHdUaC9kdjV3Z3lONE1IdXUxR2ZGc282UTE3?=
 =?utf-8?B?TDFEb2c2VWc5UStOVGpxSnllL2N4Y0NiME1iRzNiVGdjOGZHMVBzdjVJWm0w?=
 =?utf-8?B?cWhQUjlyN0NBT0NiK0E5TjZuUXhNREV1eWs4NE9UcnBwcFpnK21pZ1ZWdlNB?=
 =?utf-8?B?aVhqblRwZ3BmRUVLRTdzYlFKL1hOY3ZpSklDMytqRWFlVWJuUWdmdTduT2F2?=
 =?utf-8?B?RWZFZmlYOXl4bGVjazdQNUk3ZEhzYW56YlFFaDJDa0JXc2VyUVJpWkRwVXh3?=
 =?utf-8?B?eW93RnUrc2lNTkplYjVubWo0N1JRMk90NXhRYlhlaCtiSVVmQ1NjVC9rR3pz?=
 =?utf-8?B?UGM0bzVtaWdaY0NqUHlLY3pENTVvNGljWS9qZGVvRGJvTHhVbVhTWEdvUWhK?=
 =?utf-8?B?bDNCdnJMejZPRHpVNCtJaDhuMTFjRjVYL0s2UGNySkt4RXdZbzhVS2d3V05s?=
 =?utf-8?B?Wit1eitST0pUTjJRZDZpTmlienFLM21BZzJQNUw4eXpOY2c0em0xL2Vieldh?=
 =?utf-8?B?aE9LRGkrRS9pQi80OXRPNTJ1Q0RHaTRaNjRseWZwZ00yVExrMDRocTl6ZDBr?=
 =?utf-8?B?ckhJSWtFaUlQNHBMT05xYzA2TXVQNkJXVFdiOGUyY1Z2WllzbDF5SFNjcURx?=
 =?utf-8?B?RFlrL2tMLzRDK3oyRzJKemFnOG1WZytIV1hYbjM5WEw0YjRkaVNzYmVaT0Vo?=
 =?utf-8?B?c0JsNGJBZTFxZ08rRjh2NDhFQ2M0WlZaNUFzaDlMS0xGTnl3eDFvU0JNYy84?=
 =?utf-8?B?ejNvTTgxaU9BMysvVHJBV2o4c0tPVkNZckRCT1pNMThLbHNPVThSSUxWVC93?=
 =?utf-8?B?T1FkRk5hUlBuL2pDNjBnaUoyOExIMURTbU1MSmdTNXh3S2JMRDNrV0tNTllr?=
 =?utf-8?B?UGJiVkpXRkZKKytCZTNTY0R5NVMwbG96SXI5blliWDk4b2hmdUpLTWFGbXFi?=
 =?utf-8?B?djh1Y0k1cHhDQmpsU3B6bmUwRWdUUnZJdmVLQnhSRElQZnJjOStjQVZVb3ZE?=
 =?utf-8?B?dERtVzlKV3RDaGV0cVozOUJiSHBJZXdSNlZieE00MFQ3ZDFiTnFJbi9Ca3RW?=
 =?utf-8?B?TWRlRUVpRFBDeElwYUxRWktxcndEMm1CVU00YVBUcXlDcVlqZTNoNTRDZHFl?=
 =?utf-8?B?QWMvbzE5VVdRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2lJcDYvdUxUWnZITm5BOTNmTTBpblRnZXcycXR5VkhQMXppeHIvWnNkN252?=
 =?utf-8?B?V1NlSzk3K2h5TVdlR2s0a3l0MXZSM2JkWlhaZkF6cXFwQ2E2eTNiY2ZHTzZ2?=
 =?utf-8?B?eVBOcEdBRjMzc2FnV29GRkRlOXhSd0lWSlNhVXJOOUtWd2RuK0tmbHVaWTlv?=
 =?utf-8?B?bllEMHRvVzFqaGZUc1pac00xc09ZSlRFMENDQXFVMjkrT3FWbUFNZFI5VjRW?=
 =?utf-8?B?K0Jkc3ZRdzZvMlkzV0FSU3lDdXQyckRmb3h3bFpDSUQ2cENBMlBBWFhTdWFa?=
 =?utf-8?B?WmVnV0RQK2F5KzAvbCtNcURCZXlyQkJyWXJXaEJqVW9hUmU1U21QZzVnUlFE?=
 =?utf-8?B?cjF2c0V1YVNEUE93NVZZMHk1dUcxQUhQUEpueW9pTDdPRUNEV2lINktSb1VQ?=
 =?utf-8?B?dkNGWjZlc0Z0L0hSblNhMVdtWVNDS2ZOZzg5ZEttMjhSWjdZYm54VHMwZXFh?=
 =?utf-8?B?SVN4bElCa1FkWmVLdy9tYVo1alhxdWd3WXhXcGsxeW1LR2FJakpxeCtYVEgy?=
 =?utf-8?B?U0VudkZYU1k2c202UnpVYngvbkpFdkQ1VGdUUFV6cWhuS3B3WDAyU01sNVZG?=
 =?utf-8?B?a3VPTU5JMk9QUlRram0vWEFqckVUbmluSFQySWw2MGZ6ZUNGUFJMOWh4TGRl?=
 =?utf-8?B?YWxGMG94M1BuRmFySTFxQkh6ZU1ObG15SnliRTNIc3RIQVZkWUJic1RIRE5Q?=
 =?utf-8?B?OXEzOVA0STFRREp6cy81eHc4ZGFTS1JwV21KVUl1Y0JQNGlxd2Z0TjZMTEpC?=
 =?utf-8?B?bkxjVERYNDVzZlVhRm95RXlMRVNUVldHL05WNm44TTl2Myt4clEvMUZtMEdU?=
 =?utf-8?B?OVRRdFlENmVOeGsvQm9id0plZ29WMjlBeTFja28zVEVpT0JVM2NPMXRmQUc3?=
 =?utf-8?B?NXNiZ1BzNVhyS2k4eHE3UlF6WWtSS0xsQlk3MDNEbDI3NUVXV0hodFdGRVRN?=
 =?utf-8?B?QTVKL2YvT2c1UkhOYnF6OVJ6eHNqeUFmSk4rcWFpSFdkNkkyTnVSbTVLeXVF?=
 =?utf-8?B?NFhrWTlGb1RKWlVzcTVmTFZNVlV3aUs0YW53Mnp3bWxtUWduREZTM0s3UHU1?=
 =?utf-8?B?VTJ1QnFNQWdVQVg5cElwY1lyQUNBeDV1TkwrT1NMZzFqbTNaTUJDem53RHE1?=
 =?utf-8?B?Z21Fby9XWFpIY2ZVNWh6U1RFRUVUOHE1YjVyb1ZvZ25hSXZQRDNiTVJzY2tC?=
 =?utf-8?B?N1RhZGcxMDVORW9YcHFETjdlaEE0OUFuQmpnZ1FJSzNLUVFzUFN5ek9ZUGRs?=
 =?utf-8?B?MFk3WCttUWpDVGNyc3FnU0g5bXFVclBGMUxIS2s1RjZNWFFpT1IxS3Y5YzFa?=
 =?utf-8?B?TG9IKytMMjNKOC9ZZEZucEVzMUd2ZVdnTzJtQUtOOWlvU2tESGMvUzhLckVV?=
 =?utf-8?B?ejllWTVTSmM2MzAvQkFqeFlOUVFKSmExZ25teVZOak1jM0pXM2pHN0l3SGRL?=
 =?utf-8?B?ZXJtaGYwa2ZFbmYreGZlQzZFcnVDaGVDZGpUT2dkVTJ5Z1BrL1N6cmt3L3lI?=
 =?utf-8?B?M2dyTVBiOSs0R2duOGM1T2hlZ0U3SmRyNDhEOHdiSWl3WFIwTFh5UG1nNUdj?=
 =?utf-8?B?R0JiWW9JVm1neElBR2xkeW9JS3htQ3krYitiZkdyUnFKMlBoMzFBQTEreWFr?=
 =?utf-8?B?YklmWWhCUUliMVoydC9uL0Zqbkp6UVIyMG5xS3FweDlOcURFRFhqU1ZrSkox?=
 =?utf-8?B?YVJVWEdtL2xocStLbnNKQ2tvVE5RLzhoeXpoM1pMOXN4OVhlbXJyY2pPTlBy?=
 =?utf-8?B?VjcyWGJCVjNrT3Z2N3lFUm1SdWp6WHNzSTlPWjdMQWZKVFVmeEtWa0R1M1RN?=
 =?utf-8?B?bjZLZGV0YnArWFEyMkZ6TGRHUGwwREpRUmxNVzhGcS91WVVKdDkrbmEwbkhk?=
 =?utf-8?B?QzVIQzZIZHlTMlZVUFJ3Q2QwejdnK0U4T3Y5MmRka3dqMDR3d1JZcjRIaW1u?=
 =?utf-8?B?Y1FrSFN6QWRid240Y2VqejBSZ0o4VGZXY3dMVVpVbnhJTVd4UENraU1OamtO?=
 =?utf-8?B?bDMycDRTTEhRUzZWOUtOUitIWjJnOXVhRmJUZ2dIRGNKT0p3Ty9VTGdUYVBB?=
 =?utf-8?B?MG9CMDh0ZEhhbCtUNHlINWg5VFBJZmpqaEd0VFpBN1JWNllLcTRzSHUzRjNy?=
 =?utf-8?B?MWVCZWx2YW5oU3VMbllqMm1oYzBsVS9ndXVLS1diVEhCK09TNDV3QzFGN2tG?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E90B1608235FED47A9FF0FECA9FDED40@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: caaba356-030e-4d3b-3e65-08ddbce8838c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2025 23:54:58.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4NakYcjzX3pt72LbPUmpwvfROxV6hzjxGxl1JjJD5813ZhFxowOFQa2xXLnKnbONBuij8qrEOLq8W+WNCtrkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4620
X-Proofpoint-ORIG-GUID: bbGW_pvcdSXDdWdv1vDMSmmr1N9tZ3T9
X-Authority-Analysis: v=2.4 cv=J+2q7BnS c=1 sm=1 tr=0 ts=686b0cd7 cx=c_pps a=M0FciYcAf0Byp7bZVsDZ2Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=TDcI_v9KGjxEsEc3sSIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bbGW_pvcdSXDdWdv1vDMSmmr1N9tZ3T9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDE1MSBTYWx0ZWRfX5pwchLHvTSHA 6WYx1VP98tGKO9400ufcj8YHJZaSB+V/vOJK8Ktq7EcK3o+ktIRzVL5hen74bnmfxaIzTQvt4rD rQZWTW4ZT+TtL9OSEHFnnEfllQK8efXVzp0pueHw7RRfjVi7ELKjb7JSiAoSDf2gSwYmv/E4t/a
 GUwgmQzP0dCr3cugcO/hqEu3nYsCv1sSDe7o78KnaQAnHYXawa6PrjWPeWpseR3OuE6hWBieDwc CXLYDt/sxUoBITuuVgzGCr/uumuU+wjdjhS6kIx5MmTDZxD86wmzhwTYTbpOAv+VO9/YgdkYB/a vTxyld6bfW3RcTPMz5xFeQ/IV5bh+v4akBgJCwKkGlUesdvEBjhIrx4ZaP8jzEg0oMMgcfu1g9V
 mgZZYB/ixxxuL8mvLMYL+oiGIUpoe38Jr0VBNZIpemlUxqXADTU3X9LI6603fHdmeXe09eam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01

DQoNCj4gT24gSnVsIDQsIDIwMjUsIGF0IDEwOjQw4oCvQU0sIFlvbmdob25nIFNvbmcgPHlvbmdo
b25nLnNvbmdAbGludXguZGV2PiB3cm90ZToNClsuLi5dDQo+PiArc3RhdGljIHN0cnVjdCBkZW50
cnkgKl9fcGF0aF93YWxrX3BhcmVudChzdHJ1Y3QgcGF0aCAqcGF0aCwgY29uc3Qgc3RydWN0IHBh
dGggKnJvb3QsIGludCBmbGFncykNCj4+ICB7DQo+PiAtIHN0cnVjdCBkZW50cnkgKnBhcmVudDsN
Cj4+IC0NCj4+IC0gaWYgKHBhdGhfZXF1YWwoJm5kLT5wYXRoLCAmbmQtPnJvb3QpKQ0KPj4gKyBp
ZiAocGF0aF9lcXVhbChwYXRoLCByb290KSkNCj4+ICAgZ290byBpbl9yb290Ow0KPj4gLSBpZiAo
dW5saWtlbHkobmQtPnBhdGguZGVudHJ5ID09IG5kLT5wYXRoLm1udC0+bW50X3Jvb3QpKSB7DQo+
PiAtIHN0cnVjdCBwYXRoIHBhdGg7DQo+PiArIGlmICh1bmxpa2VseShwYXRoLT5kZW50cnkgPT0g
cGF0aC0+bW50LT5tbnRfcm9vdCkpIHsNCj4+ICsgc3RydWN0IHBhdGggbmV3X3BhdGg7DQo+PiAg
LSBpZiAoIWNob29zZV9tb3VudHBvaW50KHJlYWxfbW91bnQobmQtPnBhdGgubW50KSwNCj4+IC0g
ICAgICAgJm5kLT5yb290LCAmcGF0aCkpDQo+PiArIGlmICghY2hvb3NlX21vdW50cG9pbnQocmVh
bF9tb3VudChwYXRoLT5tbnQpLA0KPj4gKyAgICAgICByb290LCAmbmV3X3BhdGgpKQ0KPj4gICBn
b3RvIGluX3Jvb3Q7DQo+PiAtIHBhdGhfcHV0KCZuZC0+cGF0aCk7DQo+PiAtIG5kLT5wYXRoID0g
cGF0aDsNCj4+IC0gbmQtPmlub2RlID0gcGF0aC5kZW50cnktPmRfaW5vZGU7DQo+PiAtIGlmICh1
bmxpa2VseShuZC0+ZmxhZ3MgJiBMT09LVVBfTk9fWERFVikpDQo+PiArIHBhdGhfcHV0KHBhdGgp
Ow0KPj4gKyAqcGF0aCA9IG5ld19wYXRoOw0KPj4gKyBpZiAodW5saWtlbHkoZmxhZ3MgJiBMT09L
VVBfTk9fWERFVikpDQo+PiAgIHJldHVybiBFUlJfUFRSKC1FWERFVik7DQo+PiAgIH0NCj4+ICAg
LyogcmFyZSBjYXNlIG9mIGxlZ2l0aW1hdGUgZGdldF9wYXJlbnQoKS4uLiAqLw0KPj4gLSBwYXJl
bnQgPSBkZ2V0X3BhcmVudChuZC0+cGF0aC5kZW50cnkpOw0KPj4gKyByZXR1cm4gZGdldF9wYXJl
bnQocGF0aC0+ZGVudHJ5KTsNCj4gDQo+IEkgaGF2ZSBzb21lIGNvbmZ1c2lvbiB3aXRoIHRoaXMg
cGF0Y2ggd2hlbiBjcm9zc2luZyBtb3VudCBib3VuZGFyeS4NCj4gDQo+IEluIGRfcGF0aC5jLCB3
ZSBoYXZlDQo+IA0KPiBzdGF0aWMgaW50IF9fcHJlcGVuZF9wYXRoKGNvbnN0IHN0cnVjdCBkZW50
cnkgKmRlbnRyeSwgY29uc3Qgc3RydWN0IG1vdW50ICptbnQsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCBzdHJ1Y3QgcGF0aCAqcm9vdCwgc3RydWN0IHByZXBlbmRfYnVmZmVyICpw
KQ0KPiB7DQo+ICAgICAgICB3aGlsZSAoZGVudHJ5ICE9IHJvb3QtPmRlbnRyeSB8fCAmbW50LT5t
bnQgIT0gcm9vdC0+bW50KSB7DQo+ICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBkZW50cnkg
KnBhcmVudCA9IFJFQURfT05DRShkZW50cnktPmRfcGFyZW50KTsNCj4gDQo+ICAgICAgICAgICAg
ICAgIGlmIChkZW50cnkgPT0gbW50LT5tbnQubW50X3Jvb3QpIHsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgbW91bnQgKm0gPSBSRUFEX09OQ0UobW50LT5tbnRfcGFyZW50KTsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbW50X25hbWVzcGFjZSAqbW50X25zOw0KPiAN
Cj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAobGlrZWx5KG1udCAhPSBtKSkgew0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVudHJ5ID0gUkVBRF9PTkNFKG1udC0+bW50X21v
dW50cG9pbnQpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbW50ID0gbTsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgICAgICAgICAvKiBHbG9iYWwgcm9vdCAqLw0K
PiAgICAgICAgICAgICAgICAgICAgICAgIG1udF9ucyA9IFJFQURfT05DRShtbnQtPm1udF9ucyk7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgLyogb3Blbi1jb2RlZCBpc19tb3VudGVkKCkgdG8g
dXNlIGxvY2FsIG1udF9ucyAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAgIGlmICghSVNfRVJS
X09SX05VTEwobW50X25zKSAmJiAhaXNfYW5vbl9ucyhtbnRfbnMpKQ0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIDE7ICAgICAgIC8vIGFic29sdXRlIHJvb3QNCj4gICAg
ICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gMjsgICAgICAgLy8gZGV0YWNoZWQgb3Igbm90IGF0dGFjaGVkIHlldA0KPiAgICAg
ICAgICAgICAgICB9DQo+IA0KPiAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoZGVudHJ5ID09
IHBhcmVudCkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgLyogRXNjYXBlZD8gKi8NCj4gICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gMzsNCj4gDQo+ICAgICAgICAgICAgICAgIHByZWZl
dGNoKHBhcmVudCk7DQo+ICAgICAgICAgICAgICAgIGlmICghcHJlcGVuZF9uYW1lKHAsICZkZW50
cnktPmRfbmFtZSkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAg
ICAgICAgIGRlbnRyeSA9IHBhcmVudDsNCj4gICAgICAgIH0NCj4gICAgICAgIHJldHVybiAwOw0K
PiB9DQo+IA0KPiBBdCB0aGUgbW91bnQgYm91bmRhcnkgYW5kIG5vdCBhdCByb290IG1vdW50LCB0
aGUgY29kZSBoYXMNCj4gZGVudHJ5ID0gUkVBRF9PTkNFKG1udC0+bW50X21vdW50cG9pbnQpOw0K
PiBtbnQgPSBtOyAvKiAnbW50JyB3aWxsIGJlIHBhcmVudCBtb3VudCAqLw0KPiBjb250aW51ZTsN
Cj4gDQo+IEFmdGVyIHRoYXQsIHdlIGhhdmUNCj4gY29uc3Qgc3RydWN0IGRlbnRyeSAqcGFyZW50
ID0gUkVBRF9PTkNFKGRlbnRyeS0+ZF9wYXJlbnQpOw0KPiBpZiAoZGVudHJ5ID09IG1udC0+bW50
Lm1udF9yb290KSB7DQo+IC8qIGFzc3VtZSB0aGlzIGlzIGZhbHNlICovDQo+IH0NCj4gLi4uDQo+
IHByZWZldGNoKHBhcmVudCk7DQo+ICAgICAgICBpZiAoIXByZXBlbmRfbmFtZShwLCAmZGVudHJ5
LT5kX25hbWUpKQ0KPiAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgIGRlbnRyeSA9IHBh
cmVudDsNCj4gDQo+IFNvIHRoZSBwcmVwZW5kX25hbWUocCwgJmRlbnRyeS0+ZF9uYW1lKSBpcyBh
Y3R1YWxseSBmcm9tIG1udC0+bW50X21vdW50cG9pbnQuDQoNCkkgYW0gbm90IHF1aXRlIGZvbGxv
d2luZyB0aGUgcXVlc3Rpb24uIEluIHRoZSBjb2RlIGJlbG93Og0KDQogICAgICAgICAgICAgICBp
ZiAoZGVudHJ5ID09IG1udC0+bW50Lm1udF9yb290KSB7DQogICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBtb3VudCAqbSA9IFJFQURfT05DRShtbnQtPm1udF9wYXJlbnQpOw0KICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgbW50X25hbWVzcGFjZSAqbW50X25zOw0KDQogICAgICAgICAg
ICAgICAgICAgICAgIGlmIChsaWtlbHkobW50ICE9IG0pKSB7DQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGVudHJ5ID0gUkVBRF9PTkNFKG1udC0+bW50X21vdW50cG9pbnQpOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1udCA9IG07DQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29udGludWU7DQovKiBXZSBlaXRoZXIgY29udGludWUsIGhlcmUgKi8NCg0K
ICAgICAgICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgICAgICAgIC8qIEdsb2Jh
bCByb290ICovDQogICAgICAgICAgICAgICAgICAgICAgIG1udF9ucyA9IFJFQURfT05DRShtbnQt
Pm1udF9ucyk7DQogICAgICAgICAgICAgICAgICAgICAgIC8qIG9wZW4tY29kZWQgaXNfbW91bnRl
ZCgpIHRvIHVzZSBsb2NhbCBtbnRfbnMgKi8NCiAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFJ
U19FUlJfT1JfTlVMTChtbnRfbnMpICYmICFpc19hbm9uX25zKG1udF9ucykpDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDE7ICAgICAgIC8vIGFic29sdXRlIHJvb3QNCiAg
ICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAyOyAgICAgICAvLyBkZXRhY2hlZCBvciBub3QgYXR0YWNoZWQgeWV0DQovKiBPciBy
ZXR1cm4gaGVyZSAqLw0KICAgICAgICAgICAgICAgfQ0KDQpTbyB3ZSB3aWxsIG5vdCBoaXQgcHJl
cGVuZF9uYW1lKCkuIERvZXMgdGhpcyBhbnN3ZXIgdGhlIA0KcXVlc3Rpb24/DQoNCj4gDQo+IElu
IHlvdXIgYWJvdmUgY29kZSwgbWF5YmUgd2Ugc2hvdWxkIHJldHVybiBwYXRoLT5kZW50cnkgaW4g
dGhlIGJlbG93IGlmIHN0YXRlbWVudD8NCj4gDQo+ICAgICAgICBpZiAodW5saWtlbHkocGF0aC0+
ZGVudHJ5ID09IHBhdGgtPm1udC0+bW50X3Jvb3QpKSB7DQo+ICAgICAgICAgICAgICAgIHN0cnVj
dCBwYXRoIG5ld19wYXRoOw0KPiANCj4gICAgICAgICAgICAgICAgaWYgKCFjaG9vc2VfbW91bnRw
b2ludChyZWFsX21vdW50KHBhdGgtPm1udCksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcm9vdCwgJm5ld19wYXRoKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIGluX3Jvb3Q7DQo+ICAgICAgICAgICAgICAgIHBhdGhfcHV0KHBhdGgpOw0KPiAgICAgICAg
ICAgICAgICAqcGF0aCA9IG5ld19wYXRoOw0KPiAgICAgICAgICAgICAgICBpZiAodW5saWtlbHko
ZmxhZ3MgJiBMT09LVVBfTk9fWERFVikpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IEVSUl9QVFIoLUVYREVWKTsNCj4gKyByZXR1cm4gcGF0aC0+ZGVudHJ5Ow0KPiAgICAgICAgfQ0K
PiAgICAgICAgLyogcmFyZSBjYXNlIG9mIGxlZ2l0aW1hdGUgZGdldF9wYXJlbnQoKS4uLiAqLw0K
PiAgICAgICAgcmV0dXJuIGRnZXRfcGFyZW50KHBhdGgtPmRlbnRyeSk7DQo+IA0KPiBBbHNvLCBj
b3VsZCB5b3UgYWRkIHNvbWUgc2VsZnRlc3RzIGNyb3NzIG1vdW50IHBvaW50cz8gVGhpcyB3aWxs
DQo+IGhhdmUgbW9yZSBjb3ZlcmFnZXMgd2l0aCBfX3BhdGhfd2Fsa19wYXJlbnQoKS4NCg0KWWVh
aCwgSSB3aWxsIHRyeSB0byBhZGQgbW9yZSB0ZXN0cyBpbiB0aGUgbmV4dCByZXZpc2lvbi4gDQoN
ClRoYW5rcywNClNvbmcNCg0K


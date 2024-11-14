Return-Path: <linux-fsdevel+bounces-34853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078669C95BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 00:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1A3281939
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8301B219A;
	Thu, 14 Nov 2024 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="X/hVgUtD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF568374CC;
	Thu, 14 Nov 2024 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625378; cv=fail; b=BECEMPdX8XXGrhT6EpAHnwYA+z8rvdKKWWqDjTSTR/EKNcHBx/mwfwmC0cGf5lIMUSJh0HltAcnqNerNWEdYOGTB9Hv0rHeLkcVBVEvZVEHn+T62o59aUMEPhVWf8qpPq0T2pBG8/KrZxyA5iegyTqB7eOzKeGsbaOk+98RG+nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625378; c=relaxed/simple;
	bh=iKt89SBVxV7GFKH1TnO1S6QeiDNvOTxv7uKrDgrBlUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T08fb9qF7efEA4TMN+EKu8Hd4aXqRoy2TWDSrNpyHApuWrsrahFlmt9Kc78l74Al9aYXD836fqJvwrmw1ahW9BYdvrqmZ+I/RffE0yZvoSVt5quyYOwUtIk7CnyZ4pqLjwD2RMXlB4vlkbT8F1ZckFDzlACscrTEv/H07l8Tj/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=X/hVgUtD; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEKoZIH004883;
	Thu, 14 Nov 2024 15:02:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=iKt89SBVxV7GFKH1TnO1S6QeiDNvOTxv7uKrDgrBlUE=; b=
	X/hVgUtDTZ6hB1a4fP8KRiK/tYOGi+nd3XLzBZeeAL4CdXXkI0cKr40lqN4EPVog
	ggpwJU/aB92mEm4y/A8h1o1P6J+T1BHSKNX701022yLNeJ9FIVLXqX9hH70G4cMe
	HEE6Y0r9rQOftzxy/i7BnSYYRxHeWf64Cz62Z5NamMGAcoXYTL7S3ByeBWmrowMX
	bB2ASEZQY492U8633AIGYdpqwUYsmEqmDaFVe1E5bQ4mxZQgLcmrD6RFuUWyFxcN
	oKH+lzA29KDMuZcaO47zUy56JGCTllhTvGESWFZnqz1lM0PJ8t32E4ED49u9jgLC
	zcDe216V7sy0cDfO2YhtIg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42wr4vh49j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 15:02:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIbRnocGENL7OVsMZrJWxljSGu+9M+OUEqcXx4OZsJ5t6FF57+4t6AFzovKZ3r6jNgz+Bks0Lti0Hl5CkGXhiCe0Y9uanHIWVp7ikcwGvCza4fI5+BrnBob/dq8KZqlDZyibkDrSzM6B1yvcZhOBEmjg9cKIopZzfm4STsYwk+Sru27sAt1Kz8s2RK4pbMNALGU3d0gj2VY/2idLidJV0aehgM3mcA4lrYZvqfd8wvIeIEi7saW+QTL0WnecdfEy+AFH2sT4zOkjm6qsJzD6KWhlgKmn46nXHuMkN47hG2029OMpdW+TnvffxUplezDGOByM7i1VwQAVWxTvciWp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKt89SBVxV7GFKH1TnO1S6QeiDNvOTxv7uKrDgrBlUE=;
 b=GNq+wyNkEy5apT2prdXILrBTHvErZWRkwQBHv0bace//0coKuB/g5rNhhNGWETrNQAVOs/gsJ0hZhitcHue5z3RQ+uOCn4vyHr1Bb/koeLkCBoGfdwk5p1IUvUbceqeRpovmRRGWK7eyIdN4Rkdcc3wSgf3a1i67PhSYpMfEdjjIllUZyP94itoKQeCCvUHvoY7lswGxQ25oaVHGYuncsndcVtZmxTzMV2yjCIuH7j50wIGeyM1MdhnrL8Kgna0QK6Nn8MUadvd7guecrTJsO10Yv6PayNssaRibzUM9AtFv+gE1+1Ju2mWzIZGm8mZ2vmUPolaF8uBZUgKiLPllzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW5PR15MB5266.namprd15.prod.outlook.com (2603:10b6:303:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 14 Nov
 2024 23:02:51 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 23:02:51 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM
 List <linux-security-module@vger.kernel.org>,
        Kernel Team
	<kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eddy Z
	<eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexander
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
Thread-Topic: [RFC/PATCH v2 bpf-next fanotify 7/7] selftests/bpf: Add test for
 BPF based fanotify fastpath handler
Thread-Index: AQHbNnGAryo3J6mFf0ePhnT/vr0UcrK3NqIAgAAvFgA=
Date: Thu, 14 Nov 2024 23:02:51 +0000
Message-ID: <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com>
References: <20241114084345.1564165-1-song@kernel.org>
 <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
In-Reply-To:
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW5PR15MB5266:EE_
x-ms-office365-filtering-correlation-id: 5d29f09c-dfe0-4e51-1915-08dd05007710
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjA2YUlmV3BSa29Qc0NHUllwbkw0YXNlTTloZkhpcGxJTzROL3gwM0JkTk9p?=
 =?utf-8?B?b3N4dEZISzVvbE9sQy9XenlhWVBtNWE3U1d0YllOQUsxN2ZTbXh0STJDUHEz?=
 =?utf-8?B?amswMUFoTjB6RmVheHFSc3RaenozN085UVlBZ1JQZ0tzK2RJTTBJUGl5YWN3?=
 =?utf-8?B?SERmbC83WlRocDBKZlVkMjU1NEZMeFhrQzJqd0pkOEtMNzE3cTFOL0hBSGJP?=
 =?utf-8?B?eGZ2aUU4YjVrWEVaY2VYQldvVkxLOEdZSW9BVElvdEIwSWZBNnJhL3lGWHpj?=
 =?utf-8?B?NzBmekRFYnFtdUF2RHJJRW1ESURuNEdxcTNlSFhzcHZrMWUydjdvV1FKUjZC?=
 =?utf-8?B?c3o2ZjlRbXFJSlRUUDRTYkNEWVhoM2F1WklCa05vUkkveVZxSU5EY290cjlU?=
 =?utf-8?B?c0FlbEIreXVCY0tmdHBtbXVMZWpYb0Nja1JMREFEeGxkdDZ0dHpqVEZpRURM?=
 =?utf-8?B?Smdhd01QSkVEZ2x5Q0N1ZWZtK0wxZEQrWlQ5L1lkU0ppckl2eFFxOGFtVFVD?=
 =?utf-8?B?d3VwK1MvVndjZFdoTkwzQ3dXRStxU1VxV3BISUtpYTFkUk9mRmpTK051VnJS?=
 =?utf-8?B?cXFKclY3bVlVRXNHQjRUeElLKzVxM3c5Qml5QkpuaXY4QTNXTDMydEhUMlNt?=
 =?utf-8?B?WTExMjVUWnZtTUhFNCtacU1zUGF1NUI0dTljNHNQelpXSHFiRzg3WEtoaURy?=
 =?utf-8?B?WU9IbjUrSjNSK2xwZEFzK2VjeVl0c0o2Y1cvdWVrUnNSZVVsTk1JbVRBTjBS?=
 =?utf-8?B?OHJWL1M5dW1vbWFUaWluU1Vvd2dLd0dYSWdjMFpBR24wOHJLR3A3czFYaVZH?=
 =?utf-8?B?TnV4K2VJajFqZ2ZNSUVJbWFlNXpvNFhsRkJaTkc5Zm13RjhZOE55VjlONnl3?=
 =?utf-8?B?K2g0c2FxK2VFMHgxenFMV1d6NjkzY1dldkMrN3creFY1OUhBcDQ0b0hwNWpo?=
 =?utf-8?B?U0huWW03T1FpNXphL1lTV0pDZFdIMDQyanRSMmJ2Rm9GaVMwNUNqK05kL3Fs?=
 =?utf-8?B?L2FpN2tRRnliTlZBaEZUT3dnZG9sOVVxWUtpVjlFU1hadW5RZDRhUWhrS21p?=
 =?utf-8?B?cUY2QXdCaERuQ2NtOWdRdEQ0VEJrS0NaaUxDbDlFY2NZQ09iLzZIU1ZwWlJX?=
 =?utf-8?B?TDJ1eXphMGZYMTR2bHRwR2Vua1pWZUpFNTA3bkdiQnovaDlYemp5SkN4QndW?=
 =?utf-8?B?ZThuM3VGWU10TlhmTUNBZjZCcUMvQXlJWkc1WXBQeU41V1FnaDRKL2pPYkRi?=
 =?utf-8?B?VjkwamxaNXZ4RlpCVEhvVU1KUW9xeVozSFJFNVFnT1dnNFR1eVBhcThvZTFE?=
 =?utf-8?B?cW5nZlRMc1Q1ZVVzQmZHS2J0MW5MOVhJUlRBSHZlSWlaY0tjSVFYeWMxWXNY?=
 =?utf-8?B?V3g0b3Y1N2FHbDVaWDRpSUZHUDFnanlIbUF5Vzh1eW5mRzVMNmFid1N6VkUw?=
 =?utf-8?B?aDdGSU9uSm9ZQm10SG1RbHdSZlJFemhtd2N2T2dMWnVjeUkxQzYxbWxFNy8y?=
 =?utf-8?B?R3JlK2syNDkycnV3MkhRQU5LOXhMZEMrVlB4emNQNzQvdkhVYlJ3QVVnNnBB?=
 =?utf-8?B?ckoyNk9KYXdYV09aTDJZWnNSL2dmWjdPSjVmdWpkUUJqamUxVkY3U2Z2cTBK?=
 =?utf-8?B?a2VPK0phVlV1QjAxbklNQTBKYXByc3A3NVcwSCsvbXpldUV2ZXJyelhLU0ta?=
 =?utf-8?B?V3pLVVlCZ1hvVS9TVUo0QXJxVnFEbG9ZTFZMYnJHcmp0UGFSQ2l2OUpyRTdY?=
 =?utf-8?B?Wk9KSWtOMHJnQlM3dVl2VklKQjhqMzhkbU5lbFVsd0tKeUdERnZsRzFlL3l6?=
 =?utf-8?Q?hx9LSx5s8Th0ofoIkbc5NPJy485lBYlkVUmyU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZklZTmxiVDVtaDlZeEJvTzFxT1VDajRuK0xqbEQ5NkpvNTM1ZkpRVHlyL3Fp?=
 =?utf-8?B?eUZ4UmVybmhkUlI1VWU5ZFgvS1RUUTNwM0YrRGtFS0hrZW5TdGVrdUsxbXBw?=
 =?utf-8?B?bnhxOWM3dWVDQ0pzdzg2TDJmOWY5THVjd1pseEdCbDVnaExQdVgzeUVOdG9B?=
 =?utf-8?B?OGJmT1I4czBqU0tEeWwrdmNYMTFuK0Q1SHJwODNoSFFyT1BPdi9GZWUzdUVJ?=
 =?utf-8?B?Q2tpWmtTdm8vVG54UTdyNmgvUVFjS1Z0a2hnMStFSWZlTUFXdnZSTmVWL0tT?=
 =?utf-8?B?R2xzV0tHU0EwYVFUQUs3Zk82c0syRmlQVU04dzZaRkdQNXRwN3FBNVhOdXY4?=
 =?utf-8?B?QXE1SjRObkhHcmV5S1pkbHRRZm5tRlhNemRRdEZKMm80Z2FIVVZhUTZLVEsw?=
 =?utf-8?B?aWRtNm95OW50cFk2Z2wvUk9ibDJIY1pscG9HRzFVZ1dsaHkrWGtIQTNHWDY1?=
 =?utf-8?B?Zk1KZXdtVUYxaGMxUGM1QjRlRzhYUHkxMXdkdmU4dmlwS2FxSFNZVjB6RGpF?=
 =?utf-8?B?a2p4R1RRT2xzWmloR0F4WmwyUjgxWCtFSENTSjRyZElTNkZlMGRsY1ZTZ0sr?=
 =?utf-8?B?UGFVRjNIVGlHTXNWem00Q2U2UkJkdWJGVGZta3ZBWHZDbzNqYmJIVWFuaDZJ?=
 =?utf-8?B?TnpZNi81OTIwUUptZDg0WDNYdDRrL0dIR0NYVTRya05NeTd6WXV0VGwvZTgx?=
 =?utf-8?B?TG9qWU45Rm5sWmh1VklQWGkrL3JYWHE2Zk0rWkxoQ1VmTUdtdFo5NkFycjZB?=
 =?utf-8?B?NEtzaWU4T1RXVDZtanBDMFFOU3pPRFJGT096MjlHbTVPZTA2ZGtONDVkYit3?=
 =?utf-8?B?MVBFUzNQNExDeW80elZPaFpmSTBER2p2eTdDQzVGZWJpTUJSTDNPak9sOURC?=
 =?utf-8?B?YTZLL1FJekNLbjFsSE9IWGx2T0ljQmtJa2tHZTNqZ0lnWnhNWE1ETnVVZ0h0?=
 =?utf-8?B?T1FCam9VbG5JWnE3U2ZHc0tRbTh4TmwwNkZmQ1RaTy9NR2ZLeUhHaGZHdFhx?=
 =?utf-8?B?d3o0bU1VbkgyY2RLUHJPYnYxZFpOZWFTUDBxMkwwYjFVbTIxSkR2R0oyWVp5?=
 =?utf-8?B?c0FVYXFScXVqUzdSekZSOVZYdGVpZzZmLzkwZ3BpVU8wajFXTExWVTdLYW9P?=
 =?utf-8?B?K2VOMHlrTFJpWGpFTVIyRGxxVkVrMGxrYlNBeFRibVVPQU9jSEh2OHFYUzdL?=
 =?utf-8?B?RUhDVGFiRktjWmRUMC9XcmlSNTFZTy9kUjNET3IwOURpeXNJT1FRbVNuWGFV?=
 =?utf-8?B?WXZiWEthUWx5WVZHaGkzc3k0THJFcFpsUFU3ZGJLNzBXYWo2NHo5VnFjLzEx?=
 =?utf-8?B?RzV0Y2ZYaXhJSWYxRXlOajA5dkpmODBndS9KcTZwbE96T2I5VnE5MEU0ZFZk?=
 =?utf-8?B?aDNYY2h6cGxTakNRVG5Qb0trUHFXTW0xaEw3SDcvRTU2VGdIRTFpTkFKbDV1?=
 =?utf-8?B?K1M4UmMrdXdzaXRWMm5NQmNQUWx1aHU5R0RWbnVmM0V4SGhtdGZuQWVodHY2?=
 =?utf-8?B?WEQ2SUs2SXVWTXFBeFoxenIrMEdzZkZXWEdCRnZIREhBaXB3NTk5MjZRNW8v?=
 =?utf-8?B?WlR0aEVwN0w4Q1BuaWlUbHg4RTNFVERoZEZNRnVhSWk0NGI0dG9FSXBmQUJ5?=
 =?utf-8?B?am9DUlhHZFd3VTBwaGE5bHIzN29tcXRYdWhmbER4RlRVd2Vjb2xBekpPT2lv?=
 =?utf-8?B?VU05a1FVdU05NjBaNmNOcmRlN3JlOElVUTJ1MTkrN0dvTWphN0NrT3pkdlVq?=
 =?utf-8?B?cUVEWjBYUG5xK3pEUFlpRllqbkI0cGd2NUk5R1g1RG5UZWF2WkNuMXM4L3dG?=
 =?utf-8?B?ZlpITEJaQWZhSUk1RDUxRGZOaW93alVCaGxaTWNuY1duL0JTYndlMHN6SXVW?=
 =?utf-8?B?RWovSXB5R01mK2c5MEx0NnNwbCtsd25BL3o0Q3hMcWZYZFN0dmVlbnVwdWxR?=
 =?utf-8?B?RHYzdDMzbnU1TDVtYlRjRklpeklRTURvdXpNQkp1VzFRc0dzYmRaR2FXMC9L?=
 =?utf-8?B?a0wwS0lvWEpyb0paM0p5SmZ1ZDg5Wjl1djc0d0RFNUhXOFFXS0VSc2RqQkZL?=
 =?utf-8?B?bzdQZE9xeWlqOWtUS0o3eStWQXZxMjhTSlFKRXpNeU5qblY5OVByOHV0VVJY?=
 =?utf-8?B?b1A4c1NpL0FXL3BqOVRsYTlPYVhIZEZxeWhQZXZETEsveWF6R1MxbjRnTXhU?=
 =?utf-8?Q?UxYeX5hWombODGncJhM64qU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <009DE397EEC84F4DA1C4744B0A5F4E35@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d29f09c-dfe0-4e51-1915-08dd05007710
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 23:02:51.2021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4ohYVljB75ZPhyjN/i1whd1Qvh0JLkS8eqqccyJG2MGLuYLBOmc9OusfCojFDH1LDOCWyb3pTqTGXrClffK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5266
X-Proofpoint-GUID: RafGeKu4VU7VwTE1lRKA6DWRsavnZBVz
X-Proofpoint-ORIG-GUID: RafGeKu4VU7VwTE1lRKA6DWRsavnZBVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDE0LCAyMDI0LCBhdCAxMjoxNOKAr1BNLCBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBOb3Yg
MTQsIDIwMjQgYXQgMTI6NDTigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToN
Cj4+IA0KPj4gKw0KPj4gKyAgICAgICBpZiAoYnBmX2lzX3N1YmRpcihkZW50cnksIHYtPmRlbnRy
eSkpDQo+PiArICAgICAgICAgICAgICAgcmV0ID0gRkFOX0ZQX1JFVF9TRU5EX1RPX1VTRVJTUEFD
RTsNCj4+ICsgICAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICAgIHJldCA9IEZBTl9GUF9SRVRf
U0tJUF9FVkVOVDsNCj4gDQo+IEl0IHNlZW1zIHRvIG1lIHRoYXQgYWxsIHRoZXNlIHBhdGNoZXMg
YW5kIGZlYXR1cmUgYWRkaXRpb25zDQo+IHRvIGZhbm90aWZ5LCBuZXcga2Z1bmNzLCBldGMgYXJl
IGRvbmUganVzdCB0byBkbyB0aGUgYWJvdmUNCj4gZmlsdGVyaW5nIGJ5IHN1YmRpciA/DQo+IA0K
PiBJZiBzbywganVzdCBoYXJkIGNvZGUgdGhpcyBsb2dpYyBhcyBhbiBleHRyYSBmbGFnIHRvIGZh
bm90aWZ5ID8NCj4gU28gaXQgY2FuIGZpbHRlciBhbGwgZXZlbnRzIGJ5IHN1YmRpci4NCj4gYnBm
IHByb2dyYW1tYWJpbGl0eSBtYWtlcyBzZW5zZSB3aGVuIGl0IG5lZWRzIHRvIGV4cHJlc3MNCj4g
dXNlciBzcGFjZSBwb2xpY3kuIEhlcmUgaXQncyBqdXN0IGEgZmlsdGVyIGJ5IHN1YmRpci4NCj4g
YnBmIGhhbW1lciBkb2Vzbid0IGxvb2sgbGlrZSB0aGUgcmlnaHQgdG9vbCBmb3IgdGhpcyB1c2Ug
Y2FzZS4NCg0KQ3VycmVudCB2ZXJzaW9uIGlzIGluZGVlZCB0YWlsb3JlZCB0b3dhcmRzIHRoZSBz
dWJ0cmVlIA0KbW9uaXRvcmluZyB1c2UgY2FzZS4gVGhpcyBpcyBtb3N0bHkgYmVjYXVzZSBmZWVk
YmFjayBvbiB2MSANCm1vc3RseSBmb2N1c2VkIG9uIHRoaXMgdXNlIGNhc2UuIFYxIGl0c2VsZiBh
Y3R1YWxseSBoYWQgc29tZQ0Kb3RoZXIgdXNlIGNhc2VzLiANCg0KSW4gcHJhY3RpY2UsIGZhbm90
aWZ5IGZhc3RwYXRoIGNhbiBiZW5lZml0IGZyb20gYnBmIA0KcHJvZ3JhbW1hYmlsaXR5LiBGb3Ig
ZXhhbXBsZSwgd2l0aCBicGYgcHJvZ3JhbW1hYmlsaXR5LCB3ZSANCmNhbiBjb21iaW5lIGZhbm90
aWZ5IGFuZCBCUEYgTFNNIGluIHNvbWUgc2VjdXJpdHkgdXNlIGNhc2VzLiANCklmIHNvbWUgc2Vj
dXJpdHkgcnVsZXMgb25seSBhcHBsaWVzIHRvIGEgZmV3IGZpbGVzLCBhIA0KZGlyZWN0b3J5LCBv
ciBhIHN1YnRyZWUsIHdlIGNhbiB1c2UgZmFub3RpZnkgdG8gb25seSBtb25pdG9yIA0KdGhlc2Ug
ZmlsZXMuIExTTSBob29rcywgc3VjaCBhcyBzZWN1cml0eV9maWxlX29wZW4oKSwgYXJlDQphbHdh
eXMgZ2xvYmFsLiBUaGUgb3ZlcmhlYWQgaXMgaGlnaGVyIGlmIHdlIGFyZSBvbmx5IA0KaW50ZXJl
c3RlZCBpbiBhIGZldyBmaWxlcy4gDQoNCkRvZXMgdGhpcyBtYWtlIHNlbnNlPw0KDQpUaGFua3Ms
DQpTb25nDQoNCg==


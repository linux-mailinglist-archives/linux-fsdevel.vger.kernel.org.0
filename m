Return-Path: <linux-fsdevel+bounces-53203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9048DAEBD0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 18:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBA51C48413
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220ED2D97AC;
	Fri, 27 Jun 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UfMxtQlb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA11C2324;
	Fri, 27 Jun 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041298; cv=fail; b=fSU6J7eYe9pKk4XdMvChPUBXBGmmOLjO5WYGJGuzT85amJ7UPZ3b4+bBuRatqcxjyYRmlEPBqND/0ByWb/+PeB/UIy8aJCnfcoGLPCgWovTEJHW1I8R9pJstglqZT16uAJI9XX3HDbvR6vqC0EEyWQrvHlqJWjwvyJnIYx4F9EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041298; c=relaxed/simple;
	bh=DXdcJV9BxPs7UrJ39znGAQrEm7WN1tratLfx1bdeHVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rVzcBvgEvkxCMglZueuHWDzCnhAONU/EFYlIkyRhr/kdB0o9eHd98exoGalWrMn01Arxgxu3xHlngfNSPi9vbOHjA5CvAU+hDxaYSW7vAw0Ir699/1zhMxw+o3xKxJMKILgTB3U78fUCR7/ffhejHu3Q5tge5szB0rTmJprZTes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UfMxtQlb; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 55REvR8B028254;
	Fri, 27 Jun 2025 09:21:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=DXdcJV9BxPs7UrJ39znGAQrEm7WN1tratLfx1bdeHVM=; b=
	UfMxtQlbc/Xk+k3sPCyhVHFHyQ1A+aVPN+laIp57cmiTHW/ffVmRKFsC43JzZNnX
	Aq5M4giMfzF20c0m5XXO2psJEfZdydUss3PB59mK5ktN3JBoPlAn6G/d/KwjuFC9
	urEzFR7Jxz6jVRSDQRSo2g0QLvhtMmSdIQn1OFP/shBpgBNcXBAN/o/AEikKKnE0
	t8SH0zMksE067OdbUu/Cgc62n2lX1BHZuw2wK39anadInbk613jnCNFbzeLx7ppT
	STv4br6jN0LbW8k15j6vKREWmeF/VyKiD/bT4XustAGMqh/yxgMg9jGTXD4kMBJA
	EO9Zb41MeytESZI9rGPhMQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	by m0001303.ppops.net (PPS) with ESMTPS id 47hkxrbru3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 09:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHoQSC1TDAR1RSM/HJFBVAHOFExybdA6wkwvWLUmFvjUDUxvv5yxn74HtqCn8icNKWeibe29NIgDd7Zu5IahOSr76h5qXIbf53q4hJKOH5N2fsoX5+NILvS9yma+2efM4iZQFXM1TO+6WrRc7nn+BU6lca0WqXlLsJPgY0MVc7jxmszSeKxBMlbr+8ZJNKMBiP8ZxLYwt/cSQ18PjUqO5L9TwkryyAnbZQH94D0rOY2qo4u9N+rmXY4C1ERugHmbKsvegnuk0KhC0Q9wlLYyZvp41UgWB7y4irqlgFPfJUyGCookEKrabo/NTv25bF8SDPJTcfg6NtuTbsarw/gXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXdcJV9BxPs7UrJ39znGAQrEm7WN1tratLfx1bdeHVM=;
 b=EA8W5FmdH3tG+3LOq7CHxYFlbTQimkfivQUiU79Ixb+G2aAQ506sadMFHnDe3dS9S4Z9StrQK+b5MM+xczQFb/g+pxF3pXRKqhEEbdVdFflNZtosLmVPsG3gQrMlZ1QhTiY/jVgKTojhu+9X1R3c+ZFIt5h4SFkBZ4eq7Ng0Fm4DDJMc0UlPrXKPWU6hCNe8ttqIALMaJM4oMSWKTJJcP6RUr1RZyDTW3atzHS6jBpbCQY5/k63c75TrZgqTYcdvhFsxCnf61+X/F4Fk77hmWBm5S2qSWXAM3LJdcspkyKwaIbjCTMIZCGAvs6Hgypd/dDOWQIDZi2Ow6cyUgD6v8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH3PR15MB6425.namprd15.prod.outlook.com (2603:10b6:610:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Fri, 27 Jun
 2025 16:20:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 16:20:58 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Song Liu <song@kernel.org>, Christian Brauner <brauner@kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eduard
	<eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexander
 Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Amir
 Goldstein <amir73il@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Daan De Meyer
	<daan.j.demeyer@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM
 List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
Thread-Topic: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
Thread-Index: AQHb5AmEhgFe3ekSf0GU20zOMbk0tbQQlMsAgAW1gwCAAB7NAIAAx7sAgAAF+AA=
Date: Fri, 27 Jun 2025 16:20:58 +0000
Message-ID: <6230B3E5-E6B7-4D79-B3A4-9A250B19B242@meta.com>
References: <20250623063854.1896364-1-song@kernel.org>
 <20250623-rebel-verlust-8fcd4cdd9122@brauner>
 <CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com>
 <CAPhsuW7JAgXUObzkMAs_B=O09uHfhkgSuFV5nvUJbsv=Fh8JyA@mail.gmail.com>
 <CAADnVQKNR1QES31HPNriYBAzmoxdG=sWyqwvDTtthROgezah3w@mail.gmail.com>
In-Reply-To:
 <CAADnVQKNR1QES31HPNriYBAzmoxdG=sWyqwvDTtthROgezah3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH3PR15MB6425:EE_
x-ms-office365-filtering-correlation-id: b52e8dbd-ea83-401b-ec95-08ddb59699ce
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkFDTnZ1bXpYUzlnWTdvdmRjZWRCeDNpcXdNa2FGWTErNHZVVWNNY0tGOUhO?=
 =?utf-8?B?K1JKQVVpREVrMW5haTdJYWkzUnB0YlFjZkF5TkNWVTdBdkE5WVFxVThDT3ZQ?=
 =?utf-8?B?SEtlenU2RGdjQ08wM3dIU3VILzZPUFpKbW15enUrSUd1anZteW9VVlM2MzJ2?=
 =?utf-8?B?UVh0dktPcDZDaTE4UVpCWW4xaFh6RnBxcEZxaFNmYzdXMDV6KzhBOTFLc2Uz?=
 =?utf-8?B?Z3kwdks3ZGhtWkZoUGpOV2w2M2Z3RU1hRXRFZzg1MEVrUGtvKzlzRUtSamFX?=
 =?utf-8?B?K1hwL3hWWEJZcDJkKzNvcm8xai9Kd1MwYnVwdUp4dGs0RjR2VEJVWUdjUjNX?=
 =?utf-8?B?NDdqK0VUODB0bElQcFZnR2ZkVTVHVlZWbk9zTGdDZ2dkV09UVjN5WW1tTDcx?=
 =?utf-8?B?YzRYbGZhQzA0RTlJRllTTXppU2ZnczFLM1ZxL1o1UmRSbG1FZnFnSFltWGUr?=
 =?utf-8?B?SzA2OHFmYkhFcnVDbDIwcVNtbUtVdCsraUtpVDVEM0RSTkJhZkpYaEhFUEIy?=
 =?utf-8?B?cXBpRWppOTdQWjlJa3VuWEF4ais3YTRrZUlzMGM0aE0yWkgwbm1MMkNtS2py?=
 =?utf-8?B?dHNNSlJJeW93VHByb21QOWgrdGhkOUFON1dCeTRDWVprOGdWbTd3dFl1cEpr?=
 =?utf-8?B?Zm85ZDVXSjRlZW1NYk0yeVM1NkR1b1JQVDNtWjJ1dlFxQnVsSTNnTGJxVWlE?=
 =?utf-8?B?OSt5OUl2UllwbDJicHBIZjg4U2gzd1UydTd0aWJQVnRYclR1eThaU2duL0dx?=
 =?utf-8?B?RzRUQ0dmb21sMlRHMTk2cDIvZmpMa1hUTFhLMnNIdXNiN2lUbFRMaWVIUnYy?=
 =?utf-8?B?ZlNzUGlEZHFZeklSRDBCd3ZKWitTajZZVVhxQ2FKWHI1VklVRVBXcktmNVZT?=
 =?utf-8?B?ZzVTMTZXYnIvSmhMVFNVU1k0dWdCVXhxTWxhZFJkVWZiUElhcTdtakRnRDE5?=
 =?utf-8?B?OG5MOFhsd2pNdjU1ZSswL0IxdFQ3VHBybm9kanBVZ3YwZlM3bGFwdk1xb3Bv?=
 =?utf-8?B?SG5vRHlBeDlnanVjRzF5a2RlVndBMGdtYXdNdzBBR1kwSVlxK1ZBdEczU0RQ?=
 =?utf-8?B?VHY1ejRXYVg4UmlLaDhMMmI4dnN6RmpPQStwZzUxSm16UVZEa3AxV2hnSzFK?=
 =?utf-8?B?Wk11ckFBZGZXVEpDdlc2VlJLTHJtSkNrNFRjZEk3YzM5WE56aXk1YU0zYUZP?=
 =?utf-8?B?d2ZlNVVKby9WZUdyWHg4ZHdyVkFjWHNlSWJwdWNJZ3cvSHNSU0VraHF1VGNl?=
 =?utf-8?B?cCt0YWtXeWZ1K2xJR243aGRObTdtVWFFMFE0M3RXaTM2djBKRnRNOGxiV1ZS?=
 =?utf-8?B?R282TFVoaVYwSTBXWXdlcEh2ZGdQZFVBN1NJSTRNVGQ5SVhPaUM4aFQvMlQ5?=
 =?utf-8?B?U2hkY1YwTUxGNkxSYWJBclBXa2tMTnR0aXpELzRGajMyMGFJK2VEUjUvWm16?=
 =?utf-8?B?b2lIcHJWL254K1IreHF5Q1puaUJuZG1RejJJR2x3MEhWNXgwUm1XcGdSdnZk?=
 =?utf-8?B?VmwwYmtYVWF6d3EybDdTV1hZYjEySmlvQW50R0pRQnZOWjRRVmxPKzJrY3gy?=
 =?utf-8?B?S2pLaUVEUkI4ZGxZZ3p6TTRBcUxZQUxwME5sYW9JR0xBd3hhYW5mU2xJUjFV?=
 =?utf-8?B?aXg4bk5OWDlPWkZkbElKZG83bkVZM0Q5em4xTnZGeGlaWDEzNlZjelJYVHlj?=
 =?utf-8?B?NUR6ZXZvcnNUUWVKanduTWE0eEFKSVBLTXBzYjh1eUhjaUVlVW5ENzZaUVhx?=
 =?utf-8?B?UUxZQ21ORk8vcE9MeWFlbmNTUS9BaWswQzA4SERZdWw2SlJNL0N6aTY1ZTFs?=
 =?utf-8?B?RExjZEVBZTNQRGYyb2FLK3hCeStrUEg2VStQTGtDYit2bkp3VDJHT3k1R2d1?=
 =?utf-8?B?bVRrUHM0NER2VERWaU1qbWsxNytmU0pDR085NUZJQVBMQ1BHalZzQ2hnaGZz?=
 =?utf-8?B?Z3pQS2R0enRnVjVIV2V6SWI5ZVFOK1lJNWQzTUlVRGNjVTZxZnZXakJac2RJ?=
 =?utf-8?Q?hC7+epDj4FapOTnVO7eveMZNJ6H1us=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2NxOUVZNVE4SWtTcWpRRlhhaWVTeW90NHV3NWYyaEpUYmVTZDFuSGUrZUhI?=
 =?utf-8?B?Umk4Vm5RZTFheCsxaDNhQ2oyRmxXbmk4MUdGdzdsM29COFE5REZiSC9hMjdj?=
 =?utf-8?B?MGFWTC83dWptT1M1OHFqSW5mcVVpblAzTmMvNmw1K3FTR0VXaGNLNUlVdTFx?=
 =?utf-8?B?VkpEamxNaUphK056aDZDbEQzdW9VbW04MWNkWThwTWNpK3dhQk94bExmek9h?=
 =?utf-8?B?SWswUVlxNjRUWmhnL2pGRWRtdWRLNFhjcmgrV0kvZys4TldxeEt0WkljZzN0?=
 =?utf-8?B?dFJWNUlBbDhWUkgyOTVpNWgxWjF2NnJvRVVUbzVmUUFkejVrRzVCaWluZzJ0?=
 =?utf-8?B?a21PbkZWTFpuMTJFNlZjR3RlMU5uUzJoSDUweklBdVA1S3gzZ1VIcCtXcVZY?=
 =?utf-8?B?b1NSa2o5enJoWVhPM1ZhcGp6Qnd5M0lNYzFGblVtbmE3ZUJINTY2L09IcTF4?=
 =?utf-8?B?VG50djAza0ZVZTNFWVk2bkI3SVdYMTkwNXUrWEp1Y29BZUgxVHBBZ0dlYTNz?=
 =?utf-8?B?b2ZKaVI3dnpvUEowZVcweEtNNE1Pc1Z2WndKVUk5c05Vdm5jb2N5djEyTzlz?=
 =?utf-8?B?eGwxemtWcU5Nc3c0di9XWUxqRi9vRENtWXJDWW9mRmpFUG45cW16aFFaTmdp?=
 =?utf-8?B?QlBWM29ieWtkczAxQXEzcVVkMC84TTk3aFBDNGc1aTFuNmZXaXdNRmlPek0y?=
 =?utf-8?B?bkJ3NDFqZHVGZXRTU0VOVkVOQ0xHYmRPeS9WVEw5b0VXTjZVZ2gzK3VwMmtm?=
 =?utf-8?B?djlJSEdLQlgyOHQvN2h2SHVha2E3amR1T2pZaWJZdDZ6S0tuaFFwUUFMQXNI?=
 =?utf-8?B?RHozTjA2dUh0WVNVZWxIWDJBQS8xUXZwaEE3YkM3bTlnYm9MOFhPNWwxNmJy?=
 =?utf-8?B?d280SlEzNGh5aEFJRGhoVVdIa29vZndGREJKVEZTUHZZNFdFck4zeFRUZWkx?=
 =?utf-8?B?SitmZjFORG9jNGplZ0Z3bkhxWWZPSXBaZlZ3K3VGdVNYZWZFVVYxV1gxRnBB?=
 =?utf-8?B?LzJiWGUwNFNxeURsU0ozOWZzYVlVLzlqcXgrL0lHWUl4dUlsMlF6M1FweWVh?=
 =?utf-8?B?ZFRGVHprM1FyM2pMWEpBczZTeU84TTdBOFpBR1F0RWNhNGVsZGNQNXZTY2dU?=
 =?utf-8?B?LzNGb29rTFkyT1FtbGR2K0c5VXMxamdxM09QRkczY1FZQ2R0aFl1dG93YndY?=
 =?utf-8?B?OElET0gvdG5ESmx4b0F3OWdlUmhMTmZvY1NuTkJnSE83cXpZajJPR0pLaVU0?=
 =?utf-8?B?WlNzS1NBYS9GTWFDUU0zSE5Pd0xiOWN1R3o0UUZVVkV6TWxwN29CcU5SY3Ro?=
 =?utf-8?B?bTZRS2JybnRwWEZacGN5dXo2aG9sZENST0xVMnhqeFU2L2hIZzZrWW9yVkxV?=
 =?utf-8?B?U3hzS3BBMStwS2JINkVPRXc3KzN1QXptRHJTak56TnljM25tZXVMRWM2VG92?=
 =?utf-8?B?cHFrZlJiLzFOTjF1ZjhyS0doRXM0aXIrWUR0TUFFWWlSUWgrL0JZMUIwSmtI?=
 =?utf-8?B?Rlc1WHkxejRqdjZBUzJESG9aZU1taFJkN3pCUzlxT3A2N2J5Y1ZUbTl5V1RN?=
 =?utf-8?B?a1hVQmMwa3FTZTg0cUFGdkUrbndHM3lvYVVDNnYxOXFCUHh6alFELzNiNUxQ?=
 =?utf-8?B?eWlRNGo0RFJ0YVJ2bXFJQVRJTFZxQStwV3RrRVplSlo2OVFtN0IwNkNvYUpO?=
 =?utf-8?B?RkVwL2J2WHVEcUprRnZiUXZPRi8yTlJNR0lPZ2NSaU1NVXBBbnpzUDRsNUpo?=
 =?utf-8?B?UEs0U01RMVdoUTJOWG1FY3ZTYVF2ZTZNZHBGemFzbDZIUXNYWDU5WE5uRHVl?=
 =?utf-8?B?UmJ6R1dEVG1CWStDRm9UMWZjTUQvNTlMMXdHdU5jaTVXc1J0NFJsZUJKZlJj?=
 =?utf-8?B?U0tQKzdaL1llcjNmMlpVQzNwb2cxUzRTSXdTL3k0UTcvdll2VUcyZUFVNW9t?=
 =?utf-8?B?NWRPOXhRZHROL1NrMCtXcDU2Tm1yZUJSQzZ6c2hPdHVPaFNTdmxrQ2txTVJm?=
 =?utf-8?B?amo5cGFVN0pNUUNscGU2SFN6M2EwbThBRU96NytkdGlDeTRBU0c0MWtWK3BE?=
 =?utf-8?B?Z1cwQWlFd3MzL2IzbzV0MUNZbWJvMnkwWEErSXdMZ2pjNXNWVk9sZ2pPYS9J?=
 =?utf-8?B?YnlzNmNsUzBJVmxaSlNIVnpqcDhSR0ZoYUNia3FlRWJmclNqNmovZ055TnBz?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74669328C1EF234788AA95232109D038@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b52e8dbd-ea83-401b-ec95-08ddb59699ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 16:20:58.6376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZStoIYOgfHXCIs3Y5XqjAs+PPCqUN5pE/UmSZhh8tNOCCmXiwoa18QAyjzwmVLHTgogEkgy3FPxbmhystw3k4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6425
X-Proofpoint-GUID: MM6ZT9Gs_zo0dzXk8qTnXNbTx3vKapfd
X-Authority-Analysis: v=2.4 cv=KIlaDEFo c=1 sm=1 tr=0 ts=685ec50f cx=c_pps a=VXqs0nH5bCPAj+PVW1y1NA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=w3aC5C5fQhQ_PLbeK7MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MM6ZT9Gs_zo0dzXk8qTnXNbTx3vKapfd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzMyBTYWx0ZWRfX+uTUPKq541iU sfvbeHHOa4dieutIgXXEaNsqxiCWu9ruzFB9f6aL5v13NDtG52Ofhkw+rMVPKcq74u379tEMnLB /oOZlCc+vdhHX1YNfYZQIEHCda1ZeWDeidNYE6KGJG8dqCK+PPLePxuMKE8pk1Kxm3bjP4umUby
 kfx+Vlg6vXMJRaS84Fmeh8MMZtqO/H4DvjOHKs/J14xsdfflCZ+nGS3CI3f2MKOm90zwl87xSo9 AGtCU1rgDZ12qA6tPiOtcil3tiVFVtu+HEaCxXB9emrHrDdiPj86OUFgTvYfSLy+94fQxqwKP+o R4/yJT1vLbIhYNWPphHsA+U5r8yhOQL4EUfU4qbJYfKokSJ0LNBT7tgMn2B0wR8I+d6RIuLoefT
 Mr6Hv5ODMNSLgjLariNjnfI11qe+AoYoYSC43pEzfnKjID4sWBuXrivqzOn/nx/+Zr9sXug8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01

DQoNCj4gT24gSnVuIDI3LCAyMDI1LCBhdCA4OjU54oCvQU0sIEFsZXhlaSBTdGFyb3ZvaXRvdiA8
YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAy
NiwgMjAyNSBhdCA5OjA04oCvUE0gU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4gd3JvdGU6DQo+
PiANCj4+IE9uIFRodSwgSnVuIDI2LCAyMDI1IGF0IDc6MTTigK9QTSBBbGV4ZWkgU3Rhcm92b2l0
b3YNCj4+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4+IFsuLi5dDQo+
Pj4gLi90ZXN0X3Byb2dzIC10IGxzbV9jZ3JvdXANCj4+PiBTdW1tYXJ5OiAxLzIgUEFTU0VELCAw
IFNLSVBQRUQsIDAgRkFJTEVEDQo+Pj4gLi90ZXN0X3Byb2dzIC10IGxzbV9jZ3JvdXANCj4+PiBT
dW1tYXJ5OiAxLzIgUEFTU0VELCAwIFNLSVBQRUQsIDAgRkFJTEVEDQo+Pj4gLi90ZXN0X3Byb2dz
IC10IGNncm91cF94YXR0cg0KPj4+IFN1bW1hcnk6IDEvOCBQQVNTRUQsIDAgU0tJUFBFRCwgMCBG
QUlMRUQNCj4+PiAuL3Rlc3RfcHJvZ3MgLXQgbHNtX2Nncm91cA0KPj4+IHRlc3RfbHNtX2Nncm91
cF9mdW5jdGlvbmFsOlBBU1M6YmluZChFVEhfUF9BTEwpIDAgbnNlYw0KPj4+IChuZXR3b3JrX2hl
bHBlcnMuYzoxMjE6IGVycm5vOiBDYW5ub3QgYXNzaWduIHJlcXVlc3RlZCBhZGRyZXNzKSBGYWls
ZWQNCj4+PiB0byBiaW5kIHNvY2tldA0KPj4+IHRlc3RfbHNtX2Nncm91cF9mdW5jdGlvbmFsOkZB
SUw6c3RhcnRfc2VydmVyIHVuZXhwZWN0ZWQgc3RhcnRfc2VydmVyOg0KPj4+IGFjdHVhbCAtMSA8
IGV4cGVjdGVkIDANCj4+PiAobmV0d29ya19oZWxwZXJzLmM6MzYwOiBlcnJubzogQmFkIGZpbGUg
ZGVzY3JpcHRvcikgZ2V0c29ja29wdChTT0xfUFJPVE9DT0wpDQo+Pj4gdGVzdF9sc21fY2dyb3Vw
X2Z1bmN0aW9uYWw6RkFJTDpjb25uZWN0X3RvX2ZkIHVuZXhwZWN0ZWQNCj4+PiBjb25uZWN0X3Rv
X2ZkOiBhY3R1YWwgLTEgPCBleHBlY3RlZCAwDQo+Pj4gdGVzdF9sc21fY2dyb3VwX2Z1bmN0aW9u
YWw6RkFJTDphY2NlcHQgdW5leHBlY3RlZCBhY2NlcHQ6IGFjdHVhbCAtMSA8IGV4cGVjdGVkIDAN
Cj4+PiB0ZXN0X2xzbV9jZ3JvdXBfZnVuY3Rpb25hbDpGQUlMOmdldHNvY2tvcHQgdW5leHBlY3Rl
ZCBnZXRzb2Nrb3B0Og0KPj4+IGFjdHVhbCAtMSA8IGV4cGVjdGVkIDANCj4+PiB0ZXN0X2xzbV9j
Z3JvdXBfZnVuY3Rpb25hbDpGQUlMOnNrX3ByaW9yaXR5IHVuZXhwZWN0ZWQgc2tfcHJpb3JpdHk6
DQo+Pj4gYWN0dWFsIDAgIT0gZXhwZWN0ZWQgMjM0DQo+Pj4gLi4uDQo+Pj4gU3VtbWFyeTogMC8x
IFBBU1NFRCwgMCBTS0lQUEVELCAxIEZBSUxFRA0KPj4+IA0KPj4+IA0KPj4+IFNvbmcsDQo+Pj4g
UGxlYXNlIGZvbGxvdyB1cCB3aXRoIHRoZSBmaXggZm9yIHNlbGZ0ZXN0Lg0KPj4+IEl0IHdpbGwg
YmUgaW4gYnBmLW5leHQgb25seS4NCj4+IA0KPj4gVGhlIGlzc3VlIGlzIGJlY2F1c2UgY2dyb3Vw
X3hhdHRyIGNhbGxzICJpcCBsaW5rIHNldCBkZXYgbG8gdXAiDQo+PiBpbiBzZXR1cCwgYW5kIGNh
bGxzICJpcCBsaW5rIHNldCBkZXYgbG8gZG93biIgaW4gY2xlYW51cC4gTW9zdA0KPj4gb3RoZXIg
dGVzdHMgb25seSBjYWxsICJpcCBsaW5rIHNldCBkZXYgbG8gdXAiLiBJT1csIGl0IGFwcGVhcnMg
dG8NCj4+IG1lIHRoYXQgY2dyb3VwX3hhdHRyIGlzIGRvaW5nIHRoZSBjbGVhbnVwIHByb3Blcmx5
LiBUbyBmaXggdGhpcywNCj4+IHdlIGNhbiBlaXRoZXIgcmVtb3ZlICJkZXYgbG8gZG93biIgZnJv
bSBjZ3JvdXBfeGF0dHIsIG9yIGFkZA0KPj4gImRldiBsbyB1cCIgdG8gbHNtX2Nncm91cHMuIERv
IHlvdSBoYXZlIGFueSBwcmVmZXJlbmNlIG9uZQ0KPj4gd2F5IG9yIGFub3RoZXI/DQo+IA0KPiBJ
dCBtZXNzZXMgd2l0aCAibG8iIHdpdGhvdXQgc3dpdGNoaW5nIG5ldG5zPyBPdWNoLg0KDQpBaCwg
SSBzZWUgdGhlIHByb2JsZW0gbm93LiANCg0KPiBOb3Qgc3VyZSB3aGF0IHRlc3RzIHlvdSBjb3Bp
ZWQgdGhhdCBjb2RlIGZyb20sDQo+IGJ1dCBhbGwgImlwIiBjb21tYW5kcywgcGluZ19ncm91cF9y
YW5nZSwgYW5kIHNvY2tldHMNCj4gZG9uJ3QgbmVlZCB0byBiZSBpbiB0aGUgdGVzdC4gSW5zdGVh
ZCBvZiB0cmlnZ2VyaW5nDQo+IHByb2dzIHRocm91Z2ggbHNtL3NvY2tldF9jb25uZWN0IGhvb2sg
Y2FuJ3QgeW91IHVzZQ0KPiBhIHNpbXBsZSBob29rIGxpa2UgbHNtL2JwZiBvciBsc20vZmlsZV9v
cGVuIHRoYXQgZG9lc24ndCByZXF1aXJlDQo+IG5ldHdvcmtpbmcgc2V0dXAgPw0KDQpZZWFoLCBs
ZXQgbWUgZml4IHRoZSB0ZXN0IHdpdGggYSBkaWZmZXJlbnQgaG9vay4gDQoNClRoYW5rcywNClNv
bmcNCg0KDQoNCg==


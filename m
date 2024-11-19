Return-Path: <linux-fsdevel+bounces-35166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DAC9D1D00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 02:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7ED528453B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 01:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2F4481B7;
	Tue, 19 Nov 2024 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Auf3JxQL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085038DFC;
	Tue, 19 Nov 2024 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978614; cv=fail; b=E6gykgi+LtqOjtaE8i30koIyKgl1QXVKEVZDfaOZHLnNS5slRmlkyjYl68abmWh0IABrxg6pUkhA8n1GFmbHmwPw3gBSId31ImxBwiv6lbOKM2wwWXCTCiqXZ1O1z1dOOAfPflLP80jFnkTVwD3c+/tnR3og4QbMDvQi9o7ML5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978614; c=relaxed/simple;
	bh=NtYbkf7zQxU6amuZp409M6VZpI1v2i/Nl3gbG9epndA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EpBaazhbac+uQCzsuxXeET/GbVcatJsiPkk3KjyWO8V0+sWDknwR0ptwvhMEGK6/Dp9CBEYwsw+QLGscIK0qNoMUjCHTvBtgCklPbYCBc8Cf15E1xwv+gEhHB5M+tvGJjTSDKvhGo4Lb6UUAyNVg5HKrtvxXql4fHMizWjBES7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Auf3JxQL; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ0XFOI002725;
	Mon, 18 Nov 2024 17:10:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=NtYbkf7zQxU6amuZp409M6VZpI1v2i/Nl3gbG9epndA=; b=
	Auf3JxQLjYb1W50q1sfYr9wvBDmWDgF9xocP+KfbpDn/P6hejM57y46yhU3JJ8fZ
	9owPwPshsbcFlWPcbBV6FHopjSfxvMr8aUVya7nph9wC3jEb+R+6/D2F6gbi4CSU
	CzmJDlPUsamdrDV7saUd6cfIucjNKvis/w0bK4xI1sEyiySIcITZiZFfsJvDGrxT
	kXNuhTk/AkkE/4pP1pBRYtKJsarCppBQ0G8qlj7Cnn05qBI8fMo42NSMhazsVCE0
	S++dgugeAUvKFaZWjZGwndx8T5PLx0W9uqEeIwp+KpMkAtRypxjLHuV4h6B+Nrmq
	aQLOjTfl+VQlUiwGNSbb0g==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 430bq8233g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 17:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilqbkXTYj9Gu6tTgBfCuo0GaKllz4DTJCP4ulrHRl/jf9tMW7Vu9fDlEONXR+A4VvBChZVDU9i0XlZC6FzN+6OgxA5LpSB7KrMm7UKT7spXSwj6D53v3QBcCclr6UTZroRpOwS1XzRGs98yYob4e+jiKK2nsLa1subIlrl9F7rC6hqH7IY8AvcJSS9LGgsjTxRozlxk9moVUYhXFasD01FC7JBTSapMCUGDlhjUAOyehGRhesK5ws+vklgGj1Op3mQ9oXgvA1Blr8yg0/r3CcrcFMBPglUrKhUqRwBbyWJvSkBTNCirK7R594zeV04HGqxAidDMsfBwjRufZOg9mkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtYbkf7zQxU6amuZp409M6VZpI1v2i/Nl3gbG9epndA=;
 b=pZHWb/5EBR1T6bGCCZ7TveuwF/u+Hjip7gnOTHVMqtuLNELkLA32CINE5yrlNXdSzoSXbKVShLR7iGj9GxAXCqlV2uwPDNznzq9uCY0bZkSv85ZZHoUhsuUNHLy9fCIUHjyPwHH4Bka7sDDx4N1lJlkxMmJ6hZKwbmfrsq5bgmc/6mIaICgSDHojp0ubO6FUO+QH0XYXmhnlotxf2cJe566ycswVrQtHKjComNZgnlLOulswmeCnf8Z27/nL1Fh5k7CaorIcq6Ac1nkXcjj2sVJkhwkzxE21mce6UAn29BSNMn9ueu6fYU6qx5oltqpV7UUxMfAhGG5Sc34tCnUbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3911.namprd15.prod.outlook.com (2603:10b6:5:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 01:10:08 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 01:10:07 +0000
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
 AQHbNnGAryo3J6mFf0ePhnT/vr0UcrK3NqIAgAAvFgCAABuhgIAACBOAgAAGAICAAFv2AIAA1H4AgAAXZQCABLMTAIAAN70AgAAQh4A=
Date: Tue, 19 Nov 2024 01:10:07 +0000
Message-ID: <C777E3FC-B3D4-4373-BE9E-52988728BD5E@fb.com>
References: <20241114084345.1564165-1-song@kernel.org>
 <20241114084345.1564165-8-song@kernel.org>
 <CAADnVQK6YyPUzQoPKkXptLHoHXJZ50A8vNPfpDAk8Jc3Z6+iRw@mail.gmail.com>
 <E5457BFD-F7B9-4077-9EAC-168DA5C271E4@fb.com>
 <CAADnVQJ1um9u4cBpAEw83CS8xZJN=iP8WXdG0Ops5oTP-_NDFg@mail.gmail.com>
 <DCE25AB7-E337-4E11-9D57-2880F822BF33@fb.com>
 <CAADnVQ+bRO+UakzouzR5OfmvJAcyOs7VqCJKiLsjnfW1xkPZOg@mail.gmail.com>
 <C7C15985-2560-4D52-ADF9-C7680AF10E90@fb.com>
 <CAADnVQK2mhS0RLN7fEpn=zuLMT0D=QFMuibLAvc42Td0eU=eaQ@mail.gmail.com>
 <968F7C58-691D-4636-AA91-D0EA999EE3FD@fb.com>
 <B3CE1128-B988-46FE-AC3B-C024C8C987CA@fb.com>
 <CAADnVQJtW=WBOmxXjfL2sWsHafHJjYh4NCWXT5Gnxk99AqBfBw@mail.gmail.com>
In-Reply-To:
 <CAADnVQJtW=WBOmxXjfL2sWsHafHJjYh4NCWXT5Gnxk99AqBfBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB3911:EE_
x-ms-office365-filtering-correlation-id: 3070afa8-14d3-4809-a051-08dd0836e886
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?USt6V0xPeDZYU1Y4MDZtTXFGMlJEN1BJb0tRcmk1R0p4Wk5FRWtyNXVTMGFM?=
 =?utf-8?B?RWRkZmdpSy94WXFIR1V3bVJEWXFMdFAyRzVsSitrV1NaRkZJUXk3NlNkQzhJ?=
 =?utf-8?B?bmd4L0xyMm0wNWVxSG9SWUx1TFJacW1iTzloWGY5cUg4YURoOUtUdlA5TjB4?=
 =?utf-8?B?dTl6aUJpRUJNb25Gai9ENzdqVmYzSzVHeml1NkN0azVXZFEvYkRuaHpsOXhn?=
 =?utf-8?B?aSszZG1hVXdLRWNCb0psUFBsQVlBRGRFdmc0ajFBWjRseVBtSXJEQWNMSEZ1?=
 =?utf-8?B?aWtMT2JlN0VEYk14YUNLNWRkL1FHY21RTlFOb05NT3VPTFNpdXJnaVFvNTRG?=
 =?utf-8?B?VEw3OXFoRVNNUVFYYlFXZWN2b1lGTDFxVGxLWEdWeStuanVLOS90YVRyZUpV?=
 =?utf-8?B?TDBUMmtwTkZxQjRwZlZPbHE3dndOZ3RXNGI0RWJmR3A3RmJmL3BKM3diMzZk?=
 =?utf-8?B?cGt1SVRINXlwMGZLTTZ1cldGdFBtNWpmcWF5eFZtaklvSzR4S3JIamZ4eHQv?=
 =?utf-8?B?MUZ6RzA2dGNwalMrL2FlbTBBZ2tIVGhhNUp5ZGwvck42a0IvdFJtTi9hYWZ2?=
 =?utf-8?B?dTZld2dzVFh0dDY2SlNPK2xtR2R4bmJrTFdVWE50VC9OOG5ReVNLT1RLakEx?=
 =?utf-8?B?UHpaU1Z3aEhwVjQ1eDc1VDhXc3RlRnE2cjJEelNQa0Q5RCtqQ1o1Nmx6VHdi?=
 =?utf-8?B?ZVZRa1RGQS9RT0xXejVSVjFmemFxUzB0blJjN0llS0dYaW0rZzZTV0lUeXNT?=
 =?utf-8?B?WXRnU01kMmlpaEVOZ2xmU0RWeDdaeVlVNTl5Y28yUHpTT3dmeUlLL2tqQlRD?=
 =?utf-8?B?VDhzdlVzUWMrMVcwanJXY2VtZWVxRGx1eUdpWFk3ZXBJUTNJZitwVFZNdEJX?=
 =?utf-8?B?RERVVW1YaXkvQVdWT29yditiTTd5ZU5IckFjRnpSUWJGL09SZ040N3JUQi9h?=
 =?utf-8?B?SjlHRjEwWHJQRjBOMHdwNnA4RkNtZ2hSV0hXVWw2c3YySnZqVXJaTHRQaTVj?=
 =?utf-8?B?dDhKOEh3WFNvMU5lL29qbk1aUlJuakRCMGtIUnRXTkJQb1ExSWd2eEtZZmZM?=
 =?utf-8?B?MCs1bnRTR1FxRUNiNjllMWdqYk5ZbGNmUXZLUUZYd0xXNFNocHFWODhpdi9z?=
 =?utf-8?B?RndHN1ZSSm1oYTRkRkZFVGh3RVl0RUkxUjVCWWtlK1BiNURaUmJYV0tVT3BX?=
 =?utf-8?B?ejFMbVlzZjJqV2FMMUhPRDl4eUs5YWw3b3AyZEtvMnUzcXlqYTlZTlFqMHYw?=
 =?utf-8?B?cUV2OU5nT2VRaVdEVWNOZEVKemhNU3hEWEJwa041WjBuaHNuWGZkZU9sdGd3?=
 =?utf-8?B?VFUvTjE5UncrcTMvSVZST09YWUhJVUZCUXkyREhxaVpwOXZBWXQwK25jQmpa?=
 =?utf-8?B?UEpuZUpFczhVc0hyZC9iMnhOck12TitMLzZGZDkwWDBGODFMNkVqS3B4MjhL?=
 =?utf-8?B?OEsrWkRobUI2b0RpZ2pWSFBmSHViVmRMYWN2b0krZFdrc2tFeUhlSGRkdnpR?=
 =?utf-8?B?d2s1bXJncytydnl0V0hYVXVqdXBPSTQrU01TYjRYbEdPUXRMZW1sdituNlkv?=
 =?utf-8?B?MzN2WmFsdnRXRFlIWFA2NTRkZE4vRXpySzVaWTI0VEZrMnJFSjdCTUtUeXNa?=
 =?utf-8?B?eEUvemlETEF6ZHBuTVViT3NCL1ZhMEZWRVNSRC9oSWdralpJUTZSdE1BdWxB?=
 =?utf-8?B?WkxwWmgxcTAvcHBTSDd1eVRSVGhBOVRjMEtJRzUxNlEzMkdtZDlTSFhwWU9F?=
 =?utf-8?B?ZkFpc1o4c1AzLzB3WC9FVk1tWVA0VjA0ZVY4M0RhT0FvQktjR3VSRjNISUx5?=
 =?utf-8?Q?ZcNm3vmWJ1YHLG+wurSZKThky3q/QH9MqGz/w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTVUOVRYQmhLNDc5Q0wxalBNakp3cXFjR2lXNFNpVXM0SlFFbzRaSW5ZMnBE?=
 =?utf-8?B?RXZoSXRENzBGRFBkY294eUg0ekJUVitQZkovbHUrZ2ZLSUxaQThpUlliYmp5?=
 =?utf-8?B?cUg0WXVIdmhPYUxmeXQydUp6TWZzcElFNHhaSVVzYVB3MnUzaEtTV0I1dng1?=
 =?utf-8?B?ell5Yk9lanVIY25jdGVCclZGZ3dWR25HZ01VMGtURXBaeG83WkVscW5nOFEv?=
 =?utf-8?B?V0dIT0tDb1ZMWFVGMnp5M2ZvNnVJUjRZWURTa2dmeTc5ejNBNEhhMlgwZE1Q?=
 =?utf-8?B?dmJWNWJ3VE84eTk5VS9MN2txa3E4SEk0UTRtcm16T0M5RS8wbjlxU0tYdEZu?=
 =?utf-8?B?Rm80VWNaUE1DSzQvMWtyNzYvdktVdmhUb0dUSUVBQ3VuMTVSakVMVHowV0Q2?=
 =?utf-8?B?UWRyaFlkanNwVFZQbHk1Ym1uNkVTSjhtWS8vTVZSYjRkVTB2VGo3M2hXbEZx?=
 =?utf-8?B?ZDQ5RVpYOU1HOFU3TWZxa2pibmttaFAwbGFTeW1OTTJmanFicGxRZTZSZ1VQ?=
 =?utf-8?B?cU5mQ2V6YzB3K0tLdUl2SVpxYkljSllwZExzdGJDTHpSN2RWRFJaY0x4a1Zo?=
 =?utf-8?B?NnM4c0k2UUo5Q0NoODJHZDFtcTJpR1p2b2dHdzZ6ZXJMSHVaakN3aWw2cDVl?=
 =?utf-8?B?Z2R1dXh4bXB0WVhCc2RScXp1bjVZRXZ6K3RuOUl0ajlZZWZnRFh2VEJVWjhs?=
 =?utf-8?B?bk9OaFNmL0lQZThWSzhJWWlIQ3hPMEVKUmkzaDMvOUhRR0pWcVZsbU8vRkY4?=
 =?utf-8?B?MEdoZ2dTMnpud0pmUHp3ME5JWHFIak9MbzJuakFJam1iMm5kZVgxODZzR1hQ?=
 =?utf-8?B?MC9yRis5enRVYUpLdndFeWxKNWtOc1JnR056dWx2cWNSRS90V2Z1QURYaUpq?=
 =?utf-8?B?Y2daVEluaXIxd3BCVUYyUVBFTDhZT2NVMTMrYzhTdW11dzJ1VjFydTVYOFV5?=
 =?utf-8?B?N2NndXVhOXJUdFBNcWF1ZzBpSkZXd2ZKNzlHWGNGbXlXL1JQdkI4bkgrelJE?=
 =?utf-8?B?aUhFVWZKOE00L2Vud0I2eHFoRHk2a3lLL2t3TG5NNHdzU3RuM3ZsbFpBODF3?=
 =?utf-8?B?R0I3WmNua2dQQ1cvMzMzNjBmOEU2R2U2MThlYXMzcjdycHdKekFuSVpNVG5E?=
 =?utf-8?B?bXlYWERGL1c1Z2xTaDNadmhBR0VqeGg0LytUWTBLKzZXQTJnRDlYMzFLbFBH?=
 =?utf-8?B?cDNwSkJxaFFPWHJiVEd1VUlVNmxrRXhKMEI5QjFVMzF4WDBQaEZMQ1ZNc0lQ?=
 =?utf-8?B?b0pRZEJBTHU2WVgxSGdmTE9xOGJ2cjJpYUJlWGNTRTFqa2tVcUFqTmZvNlls?=
 =?utf-8?B?SWpBV0hFMVgwRVVnSzFrSlJRUHM4OEtZTnd4Uk5RZ0hGdDBxeDd4MG5NeGdR?=
 =?utf-8?B?dnpOL0gwakxkMWZnSVM3T0RHUVJ6bHlxOUlQWnJyR1R5ZnQ3eFYvQ0NUM0NZ?=
 =?utf-8?B?LzFld2dMU0crNzY3TEErSitjbmxXWmd6ZHBPUlp2TE1XL2JVZWJGSExBN1FF?=
 =?utf-8?B?U3luNkZ5VEd1QmFSOVV0MEhRSnNvbHVDMERnMm13blpPR0FxL3hqVmJUaE80?=
 =?utf-8?B?TWdyZitkWjNlbmpyYmpFQ3pWNHdkL2FJdVJjNjE5NGZGMTI3WGpia1VkQW9o?=
 =?utf-8?B?akdUeTZNN3EyYlljVVlsaG1qejRYZnBJaktadTdxSUtFUWt2SmhacVFjM1Bv?=
 =?utf-8?B?STVyWGRKaUdISjRxWHR3K21DR0RhNXRhN250Ymk3clR3SVZ6MFFyOXJTUUlD?=
 =?utf-8?B?Rmt4UXV6TzY1U2REelE5eHp1T1E3NmVqQjBVdmE5THlqazJ6RytYdEY1WXo4?=
 =?utf-8?B?cXo5a2VZUksrZFg0RTg0Mm5tbW1ZTGdxR2thM3NZR2hrbXh6bjlIY0IvbmRm?=
 =?utf-8?B?Y0h1b1prMTA2WXh1ZnJoMXY4SlN5dWtxTEk0YlNYNWt3UGJHaXVWb2RqajNa?=
 =?utf-8?B?S1ZhbWxKWkcyNlpwZG1EOXg5aFYvWlMxamFnL1pxWFR6UEIvS2pvazEySWls?=
 =?utf-8?B?NTBBcWs4dGE5NjJDVTBXbEQrZDlMYlMrTGpmVGN2VGxpTmplQkM1S0FUWmdN?=
 =?utf-8?B?UHBmL2N4Wm1aN2ZaYmFEUUorWlZiZlpJcHNpRlJ2akl0TmpobVBsaCszeVdz?=
 =?utf-8?B?dnkwNmhzL3VDSlVSSzVSY3VzM29RNjJPOGQxajgwUU5EYWZoV2syUnF1UzI4?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28F8A4F80D4A104EAD0644F4C1CA5A6B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3070afa8-14d3-4809-a051-08dd0836e886
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 01:10:07.8456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7T+AiWHQDgclTtgKeic4DiCTGAwZKmPT+hFjY7I2X5z5cmL1BwzL5fOQavosIT2fMRzT2PZt23BXOzkY+B+NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3911
X-Proofpoint-ORIG-GUID: sZVcv1843GVGMGSAgudLcqhBlyyyYThz
X-Proofpoint-GUID: sZVcv1843GVGMGSAgudLcqhBlyyyYThz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

SGkgQWxleGVpLA0KDQo+IE9uIE5vdiAxOCwgMjAyNCwgYXQgNDoxMOKAr1BNLCBBbGV4ZWkgU3Rh
cm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KWy4uLl0NCj4+
PiANCj4+PiBBZ3JlZWQuIFRoaXMgaXMgYWN0dWFsbHkgc29tZXRoaW5nIEkgaGF2ZSBiZWVuIHRo
aW5raW5nDQo+Pj4gc2luY2UgdGhlIGJlZ2lubmluZyBvZiB0aGlzIHdvcms6IFNoYWxsIGl0IGJl
IGZhbm90aWZ5LWJwZg0KPj4+IG9yIGZzbm90aWZ5LWJwZi4gR2l2ZW4gd2UgaGF2ZSBtb3JlIG1h
dGVyaWFscywgdGhpcyBpcyBhDQo+Pj4gZ29vZCB0aW1lIHRvIGhhdmUgYnJvYWRlciBkaXNjdXNz
aW9ucyBvbiB0aGlzLg0KPj4+IA0KPj4+IEBhbGwsIHBsZWFzZSBjaGltZSBpbiB3aGV0aGVyIHdl
IHNob3VsZCByZWRvIHRoaXMgYXMNCj4+PiBmc25vdGlmeS1icGYuIEFGQUlDVDoNCj4+PiANCj4+
PiBQcm9zIG9mIGZhbm90aWZ5LWJwZjoNCj4+PiAtIFRoZXJlIGlzIGV4aXN0aW5nIHVzZXIgc3Bh
Y2UgdGhhdCB3ZSBjYW4gbGV2ZXJhZ2UvcmV1c2UuDQo+Pj4gDQo+Pj4gUHJvcyBvZiBmc25vdGlm
eS1icGY6DQo+Pj4gLSBGYXN0ZXIgZmFzdCBwYXRoLg0KPj4+IA0KPj4+IEFub3RoZXIgbWFqb3Ig
cHJvcy9jb25zIGRpZCBJIG1pc3M/DQo+PiANCj4+IEFkZGluZyBtb3JlIHRob3VnaHRzIG9uIHRo
aXM6IEkgdGhpbmsgaXQgbWFrZXMgbW9yZSBzZW5zZSB0bw0KPj4gZ28gd2l0aCBmYW5vdGlmeS1i
cGYuIFRoaXMgaXMgYmVjYXVzZSBvbmUgb2YgdGhlIGJlbmVmaXRzIG9mDQo+PiBmc25vdGlmeS9m
YW5vdGlmeSBvdmVyIExTTSBzb2x1dGlvbnMgaXMgdGhlIGJ1aWx0LWluIGV2ZW50DQo+PiBmaWx0
ZXJpbmcgb2YgZXZlbnRzLiBXaGlsZSB0aGlzIGNhbGwgY2hhaW4gaXMgYSBiaXQgbG9uZzoNCj4+
IA0KPj4gZnNub3RpZnlfb3Blbl9wZXJtLT5mc25vdGlmeS0+c2VuZF90b19ncm91cC0+ZmFub3Rp
ZnlfaGFuZGxlX2V2ZW50Lg0KPj4gDQo+PiBUaGVyZSBhcmUgYnVpbHQtaW4gZmlsdGVyaW5nIGlu
IGZzbm90aWZ5KCkgYW5kDQo+PiBzZW5kX3RvX2dyb3VwKCksIHNvIGxvZ2ljcyBpbiB0aGUgY2Fs
bCBjaGFpbiBhcmUgdXNlZnVsLg0KPiANCj4gZnNub3RpZnlfbWFya3MgYmFzZWQgZmlsdGVyaW5n
IGhhcHBlbnMgaW4gZnNub3RpZnkuDQo+IE5vIG5lZWQgdG8gZG8gbW9yZSBpbmRpcmVjdCBjYWxs
cyB0byBnZXQgdG8gZmFub3RpZnkuDQo+IA0KPiBJIHdvdWxkIGFkZCB0aGUgYnBmIHN0cnVjdF9v
cHMgaG9vayByaWdodCBiZWZvcmUgc2VuZF90b19ncm91cA0KPiBvciBpbnNpZGUgb2YgaXQuDQo+
IE5vdCBzdXJlIHdoZXRoZXIgZnNub3RpZnlfZ3JvdXAgY29uY2VwdCBzaG91bGQgYmUgcmV1c2Vk
DQo+IG9yIGF2b2lkZWQuDQo+IFBlciBpbm9kZSBtYXJrL21hc2sgZmlsdGVyIHNob3VsZCBzdGF5
Lg0KDQpXZSBzdGlsbCBuZWVkIGZzbm90aWZ5X2dyb3VwLiBJdCBtYXRjaGVzIGVhY2ggZmFub3Rp
ZnkgDQpmaWxlIGRlc2NyaXB0b3IuIA0KDQpNb3Zpbmcgc3RydWN0X29wcyBob29rIGluc2lkZSBz
ZW5kX3RvX2dyb3VwIGRvZXMgc2F2ZQ0KdXMgYW4gaW5kaXJlY3QgY2FsbC4gQnV0IHRoaXMgYWxz
byBtZWFucyB3ZSBuZWVkIHRvIA0KaW50cm9kdWNlIHRoZSBmYXN0cGF0aCBjb25jZXB0IHRvIGJv
dGggZnNub3RpZnkgYW5kIA0KZmFub3RpZnkuIEkgcGVyc29uYWxseSBkb24ndCByZWFsbHkgbGlr
ZSBkdXBsaWNhdGlvbnMNCmxpa2UgdGhpcyAoc2VlIHRoZSBiaWcgQlVJTERfQlVHX09OIGFycmF5
IGluIA0KZmFub3RpZnlfaGFuZGxlX2V2ZW50KS4gDQoNCk9UT0gsIG1heWJlIHRoZSBiZW5lZml0
IG9mIG9uZSBmZXdlciBpbmRpcmVjdCBjYWxsDQpqdXN0aWZpZXMgdGhlIGV4dHJhIGNvbXBsZXhp
dHkuIExldCBtZSB0aGluayBtb3JlIA0KYWJvdXQgaXQuIA0KDQo+IA0KPj4gc3RydWN0IGZhbm90
aWZ5X2Zhc3RwYXRoX2V2ZW50IGlzIGluZGVlZCBiaWcuIEJ1dCBJIHRoaW5rDQo+PiB3ZSBuZWVk
IHRvIHBhc3MgdGhlc2UgaW5mb3JtYXRpb24gdG8gdGhlIGZhc3RwYXRoIGhhbmRsZXINCj4+IGVp
dGhlciB3YXkuDQo+IA0KPiBEaXNhZ3JlZS4NCj4gVGhhdCB3YXMgdGhlIG9sZCB3YXkgb2YgaG9v
a2luZyBicGYgYml0cyBpbi4NCj4gdWFwaS9icGYuaCBpcyBmdWxsIG9mIHN1Y2ggImNvbnRleHQi
IHN0cnVjdHMuDQo+IHhwZF9tZCwgYnBmX3RjcF9zb2NrLCBldGMuDQo+IFRoZXkgcGFjayBmaWVs
ZHMgaW50byBvbmUgc3RydWN0IG9ubHkgYmVjYXVzZQ0KPiBvbGQgc3R5bGUgYnBmIGhhcyBvbmUg
aW5wdXQgYXJndW1lbnQ6IGN0eC4NCj4gc3RydWN0X29wcyBkb2Vzbid0IGhhdmUgdGhpcyBsaW1p
dGF0aW9uLg0KPiBQYXNzIHRoaW5ncyBsaWtlIHBhdGgvZGVudHJ5L2lub2RlL3doYXRldmVyIHBv
aW50ZXJzIGRpcmVjdGx5Lg0KPiBObyBuZWVkIHRvIHBhY2sgaW50byBmYW5vdGlmeV9mYXN0cGF0
aF9ldmVudC4NCg0KT0suIEkgYW0gY29udmluY2VkIG9uIHRoaXMgb25lLiBJIHdpbGwgYWRqdXN0
IHRoZQ0KY29kZSB0byByZW1vdmUgZmFub3RpZnlfZmFzdHBhdGhfZXZlbnQuIA0KDQo+IA0KPj4g
T3ZlcmFsbCwgSSB0aGluayBjdXJyZW50IGZhc3RwYXRoIGRlc2lnbiBtYWtlcyBzZW5zZSwNCj4+
IHRob3VnaCB0aGVyZSBhcmUgdGhpbmdzIHdlIG5lZWQgdG8gZml4IChhcyBBbWlyIGFuZCBBbGV4
ZWkNCj4+IHBvaW50ZWQgb3V0KS4gUGxlYXNlIGxldCBtZSBrbm93IGNvbW1lbnRzIGFuZCBzdWdn
ZXN0aW9ucw0KPj4gb24gdGhpcy4NCj4gDQo+IE9uIG9uZSBzaWRlIHlvdSdyZSBhcmd1aW5nIHRo
YXQgZXh0cmEgaW5kaXJlY3Rpb24gZm9yDQo+IGlub2RlIGxvY2FsIHN0b3JhZ2UgZHVlIHRvIGlu
b2RlLT5pX3NlY3J1aXR5IGlzIG5lZWRlZA0KPiBmb3IgcGVyZm9ybWFuY2UsDQoNClRoZSBiaWdn
ZXN0IGlzc3VlIHdpdGggaW5vZGVfbG9jYWxfc3RvcmFnZSBpbiBpX3NlY3VyaXR5IA0KaXMgbm90
IHRoZSBleHRyYSBpbmRpcmVjdGlvbiBhbmQgdGh1cyB0aGUgZXh0cmEgbGF0ZW5jeS4gDQpUaGUg
YmlnZ2VyIHByb2JsZW0gaXMsIG9uY2Ugd2UgbWFrZSBpbm9kZSBsb2NhbCBzdG9yYWdlIA0KYXZh
aWxhYmxlIHRvIHRyYWNpbmcgcHJvZ3JhbXMsIHdlIHdpbGwgbm90IGRpc2FibGUgaXQNCmF0IGJv
b3QgdGltZS4gVGhlcmVmb3JlLCB0aGUgZXh0cmEgaW5kaXJlY3Rpb24gdGhyb3VnaA0KaV9zZWN1
cml0eSBkb2Vzbid0IGdpdmUgdXMgYW55IG1lbW9yeSBzYXZpbmdzLiBJbnN0ZWFkLCANCml0IHdp
bGwgY2F1c2UgbGF0ZW5jeSBhbmQgbWVtb3J5IGZyYWdtZW50YXRpb25zLiBJT1csIA0Kd2UgYXJl
IHBheWluZyB0aGUgY29zdCBmb3Igbm8gYmVuZWZpdHMgYXQgYWxsLg0KDQo+IGJ1dCBvbiB0aGUg
b3RoZXIgc2lkZSB5b3UncmUgbm90IHdvcnJpZWQgYWJvdXQgdGhlIGRlZXANCj4gY2FsbCBzdGFj
ayBvZiBmc25vdGlmeS0+ZmFub3RpZnkgYW5kIGFyZ3VtZW50IHBhY2tpbmcNCj4gd2hpY2ggYWRk
IHdheSBtb3JlIG92ZXJoZWFkIHRoYW4gaV9zZWN1cml0eSBob3AuDQoNCkkgdGhpbmsgdGhlIGRp
ZmZlcmVuY2UgaXMgb25lIGluZGlyZWN0IGNhbGwuIEJ1dCB0aGF0IA0KbWF5IHdvcnRoIHRoZSB3
b3JrLiBJIHdpbGwgdGhpbmsgbW9yZSBhYm91dCBpdC4gQWxzbywgDQpJIHdvdWxkIHJlYWxseSBh
cHByZWNpYXRlIG90aGVyIGZvbGtzJyBpbnB1dC4gDQoNClRoYW5rcyBhZ2FpbiBmb3IgeW91ciBy
ZXZpZXchDQpTb25nDQoNCg==


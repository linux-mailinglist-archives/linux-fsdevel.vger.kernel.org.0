Return-Path: <linux-fsdevel+bounces-34847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D49C93D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 22:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FE21F23009
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 21:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1D1AE01F;
	Thu, 14 Nov 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kCl0vv+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165651ADFFD;
	Thu, 14 Nov 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618724; cv=fail; b=WmIlCXlYqm8EqBofiAwVfM9IvZRJjNrF6SLDg2Zyxhud2O8SV9T6Jcm+StJy6gXERJ7jZvVc3pEZlPs8Is5mHbPcQ8/3DY4Ka/NxzPcN+lYD9QNYEHL0GS09yz8LGKwk1Tn0A/PCj3gjioRM6LYiMP6zGWXWtB9kIcvX0DWZ+zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618724; c=relaxed/simple;
	bh=L1nChgzOGhYMvKJjq+0yELIIt5paplnURw11z6eB4Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bgKcvH75Xtu9nyJy1NW/ZPhMUYyirkSx6nrZFY/8sCwwG1tcVlRHzXh0x+v7Q1XC5AkrPZH1vIiolR0Loc8LWaDWuVtJf4JhFjKH7/lzTDEqi4Wl4JYxH3eVhp8KGQNmjW6ZXw84eYJhH3N0bBDiFcPT5Dmz9S3LmXsxfT57i94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kCl0vv+O; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AEKocra017117;
	Thu, 14 Nov 2024 13:12:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=L1nChgzOGhYMvKJjq+0yELIIt5paplnURw11z6eB4Q0=; b=
	kCl0vv+OtPhSnukUBn9lRaLXrBSlL8d9Y9H8P21O6pn7jptiDKqgfT97WJxh0Lbg
	c9EUlauhgqd0xnVUHWybrgYH1w8OG0aFlErNTV5TDLNALoNpi6oWoJJvprUnKrRN
	Wbc5wJ5qGH8iIODy+ukpWvpK5HknTJZbOBjaXMUSJad60ZZCfLLAUkGWAjSsA/yY
	bIdhxEqoWk1hqA/uo73O4C2sOqGlS7bQ5lu6PhJf1ffmL1fHKj/fXqTy7KIa39bs
	LXCQh6f6OmHqPjBEcnOTUDTBvwC8RZTUnMElDGgNSfW/VqYWLEg/z6ud5DhFL1WO
	AAppDcu1ly4Gi6yw01g4uw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by m0089730.ppops.net (PPS) with ESMTPS id 42wbt2x78b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 13:12:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMxU5iv36Rq1aRnVm4ZI+PkbaTfuSSFuHTWnWBbOqXtbXGiaDAQ1UVf1PQW6c4L0WRrtA+PBUAqveh1+h4r+VyCvfj7c+lVWd9Q+qnN6WJ34o0YBezTRbmOegE0AITlJicKAsKJ2vH2MlUpGco2U8Zz+onCdf+t53UjV/AiRC6WjjsbznWpZ1wQqPSf3vgsAFtComDGuVLSZ1vHyIHbkHgzI/ScyIru+aXe2QktXRO7ZAadjxSaqwAE4qwL3vD2DgOwjjCuZ+3IbmuqUrp6nnQaTff+jVZfVwv1s3P/HVxM/RGQDaRzpT9/Co8iZ0iTaGVyr4VUI/iZeU2EShP/F9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1nChgzOGhYMvKJjq+0yELIIt5paplnURw11z6eB4Q0=;
 b=MtFYQBT0z4sbq/5iQhkh9JPYOEH8TVamVTQFiulcqGVeH32H5kY+NEIxltJ60Ioc0+0KV33zbwDGQ/AxS3CmOp/0XgKXi+D/CmpIDxoqYsX5dmvHazuEXjD/LxLbRFAvwdpPUaXKN0Jjh1pyrwCma9z0L4Dt65sWO3oXbySUmaHfdDv4EDCX9Got0W7dupYdMZpJRJLRpXJzAib88oeOQdF1htxHN4FHMTw42uvAiSbb0cVk5RNhhMNT6gTcREPA1PfRbdPsbkjORoA9eegCL3n0pOi/tWDPAA7k7SaSk15K9JUpRxxpvLTK7GEut2ebjR47P476AnKte29FUzzv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CO1PR15MB4985.namprd15.prod.outlook.com (2603:10b6:303:e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 21:11:57 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 21:11:57 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
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
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "amir73il@gmail.com"
	<amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik
	<josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Topic: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Index: AQHbNNya8stOo5GwQE2QhVtvXBjXrrK1AUcAgAJInwA=
Date: Thu, 14 Nov 2024 21:11:57 +0000
Message-ID: <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
In-Reply-To: <20241113-sensation-morgen-852f49484fd8@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CO1PR15MB4985:EE_
x-ms-office365-filtering-correlation-id: d953c1de-d056-4d48-7662-08dd04f0f8fe
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTRybzRmUnIvZXNFcmtNdUNVS00rM3BqMmJYSjZxWVJ0NHpBeGltWUgrNUJT?=
 =?utf-8?B?NlRmVU5NMnlBSG44K0ZoMVNVTnY1SlE3R3RtcGFlZUdzOGtpODhzVEtxNVFF?=
 =?utf-8?B?MUxUaTlZRytqZmRaeVNjU1BYV3grd3V3eHh3T2o4TmNPK2M1bDZSVjRRQ1N3?=
 =?utf-8?B?SVNvK09rcVdMRm11RFVtTUNvdnE3dnN1ZWwvZkxWV1JoK0dEMXgxNE9PUHRt?=
 =?utf-8?B?YS8vR3V5NEZIamlRWGVEUmtVVG51aEtSVlR0dHFyT0dvQ3FTTWFrZGhteTAv?=
 =?utf-8?B?TlVZQ3cra1p6N284eHJaNzFLREZXUXpnWDh6SllqYkMrSit3aURrVER2WUM0?=
 =?utf-8?B?VytYSTJmaXgwQzB5dmpEbkV6dWdWL0owcmE2d3JLZFlSL29wd0tVMDhvVFJu?=
 =?utf-8?B?UE82ZTBiK1R1RWZNOGFwZTUyRURHZTNWTkY4R29FOFhYeUR3OS9vODFsUFFl?=
 =?utf-8?B?K2tjaUdOT3RtemRQVW1QVEFzNVhxYXNVZWYzeC9KSytocmpzWU1FVDBNOFVC?=
 =?utf-8?B?UEJORE9HcVZrdkxRekhuZnRSLzZPYWRqV2pnNE03YzBjS1N3VlRBQmx3Q1NJ?=
 =?utf-8?B?K3ZVdk12L1QrM1VwVEJvMnNEY2xMUzJ3MktTNU1CUzBDYlF4UUhpTExjSHA5?=
 =?utf-8?B?M3EwWFQ5Q0NRYVJUNFlWbFpOWWtpd1hSd3lOazVBWWNmKytCb1hKNGZKbWtv?=
 =?utf-8?B?U1hSZ2Y1TGNIN0RBTDNqRE5Dc2dQZFcydFVNVjBCNGMzaHRPSnA2ak1ZVVNq?=
 =?utf-8?B?QzdPNVRZcDhZQXN0ZFZZd3A3K1loMENMblJIdGxTV25rWkRBUGtFUjNueFh1?=
 =?utf-8?B?bm9mcjdLam8rcE1YSGJ0TmVOejRQR2x1cTdMdFdDb003WWJJTkN6WnR1OWdT?=
 =?utf-8?B?N3JlZnpMTFlsbWdReXFFdTRNWmMxM0htK2hac0lITys5ZEpFYWNZbG1IVS8w?=
 =?utf-8?B?YWtiSlB6SVRPUEpYUEpVYTd2cG9ncTl0amdoV0ZSNXBIZWh0RE1WdUliSlhm?=
 =?utf-8?B?Q3NmNGk3dDdJQUNKNWh0VUtJbFppWUk1bVdweGlSbnBDakZvd2VweUFKV0lZ?=
 =?utf-8?B?bjNwN3NEdEVobkR3U3BPWFlWSU9yZUZHcVhlLzZKUUhoYnNWbWRFMDVNZEdC?=
 =?utf-8?B?OGNEMUJoNHM2TDNQcHFoajJxSEFYa3MwOEV4UkYrZnNiR1JiTEd2N01pdW8x?=
 =?utf-8?B?RlMyZ1JDSThCOW1IalRtTG1MRDMrWHd2TUppeU1zblBBd3E4YzhDZ0g3cWFw?=
 =?utf-8?B?Z211dFZrNDV1N3I1NVEvN09FZG53eStPdTdQR2h1eXdMc2JIcnV5VTVnTWVt?=
 =?utf-8?B?QTRTSmNhcFNpc1NyMTZwc1lIVE5rSVpkZkJXTWVFaEJHL1YydzZNOTdETkoy?=
 =?utf-8?B?UCtoSC9ORUVNYXU3WDkwMGpnakhNQXFPTUlrTGtHZDZTZjFwVGN5T0RwOFg4?=
 =?utf-8?B?STFnVy8xcWhSa3h1dyt2TGZlbEZzZTM2U0FORy8weDhHYkljSkVDSUgwb2o4?=
 =?utf-8?B?ekFSU3dHeXh6dzRTUWFwNFdEYnAvNXVLZFRsWDkxbGF6Y3JrRVJISjl2TDQv?=
 =?utf-8?B?Uy9YdW1FR3NRUTRPSHoxWlB2UWZUMEZ2TEtIelRjODBaN0hENHdjelI3RFk2?=
 =?utf-8?B?cHh4WXBBdHJnSjR4VkhlMXZFT1IwN3ZibGZiV1QrMWltZDJFSEN1YWRoRmN3?=
 =?utf-8?B?Y3cvemFXbUd5U0YyZ0duQm92Wmh6RDRKQkV3RzlsYWFNYTBQZE5kSmkyZ0lJ?=
 =?utf-8?B?V2FlWW9YMTlRSE95NlFtWEhqRkY0ZXB1b1R6L1dZZ2lzaCttaXNvZVB2clJP?=
 =?utf-8?B?TFBtanNZb1NMT1BpaVFSRlRwYW5zTDM4U05pTjlPaUtsWEt0TlVFUUN5dmlY?=
 =?utf-8?Q?et1DzCpA85sso?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVNnaXBvK2dvUjlSM2tEWm51b2hXL0pnajBDSzlSeVVsVWtEbi80NWJ2UFBO?=
 =?utf-8?B?eWlhM25tc2UvVjF0UkU2OUt5UHB3OU8yTEFrWVJBY2xuT2lZZkZsYW95bVJ1?=
 =?utf-8?B?NWk3d1BjUEtjVTBONEszUllLVG9xOUlSei90RWJNV2duQlVJNEFMN1N6V3p1?=
 =?utf-8?B?MEVNYjJMQmhQUHV0eGhxdXRSQ3E1YnVIZ1JNZ2poNDJGekRaTTZsdUs5U2Iy?=
 =?utf-8?B?b2dqTzZmVGt0U2ZVNCtVVklHYVNoclN2ekh1QUZRUEZZMHNiZWJQckx3NCtn?=
 =?utf-8?B?QUlEc21VVFJ6cUgvNEpVQmNhNTlQbGpqSVM1blAvMWd3Z3lpVW52NmNLNzgv?=
 =?utf-8?B?VHExT2tyeks5b00xWllDQkFTaTMwUndxUyt5bG05TmdnTHBjc3hKSEZpMEV2?=
 =?utf-8?B?dTEraThpWWV0UkJFY2tXelBldHp4OGxnYU9QMDN0bDVPb3lRWi8vMGxVNlhy?=
 =?utf-8?B?T29FSms1OUdlQmM2VUhPamJSdjZqbDBPaUVHZnY4aGdXcS85SFpibHZFTE0z?=
 =?utf-8?B?MG95dUhwb29DbWtvK0k5VEx3VElnRDBhVmFmN29CNjVLUHRNOW41S0NUUCs0?=
 =?utf-8?B?cjUvRW1ibndMRXVmdmk5UWdtaURnWnhVbXRaYW95dVlCMlBoU2I3MzVWOEpK?=
 =?utf-8?B?MFFDUERhbVJwa2F4S3V2bDVTQklIWHhjclpJcHRacUJFS2lRTUM5RzF2ajFk?=
 =?utf-8?B?T3Z5VGpma3ZsMGtkcW9sRnJMVGhrSC9sYkVFNjVYYzI2STk1Q1EvLzdFaVhI?=
 =?utf-8?B?SktBRWJyaFpaaGc3UXYwZlNZMlBkMlhpaDdOR3NVTEhmNkMvYjY4dWMxL1Vw?=
 =?utf-8?B?aXRaNysvT1NxUGtTS0gyR3JnVElNK01iMmptcUpIaFVQcTE3VktJTkVqVlNE?=
 =?utf-8?B?RkYxYkh5a2s2OXdwYjllblgyNG9xODlKMFJKK0lEVTViZlQyRHgvMEVEbnYv?=
 =?utf-8?B?Nmc2WGJjN3JSV2lkYWJCT21FOVBaNzJhemFCNnowWnF2ZHgxNmM5SUtlNnJm?=
 =?utf-8?B?aWxZUnJJMlNackpKTUQzcy8yclZpa0x4ckY5ZEZWS1dsYm1VVkthcWJLVjE5?=
 =?utf-8?B?bHlLUkg2MnBvZkxvR1FBd3FCY2MzbG5EazFyL1lGazdZSlFabUZyV3R6Ly93?=
 =?utf-8?B?Z1BLNFpUUzA2RFZrN0JjTnF1U1JoQis5L2puaTBhMkVmR1BhejloMUpLeURr?=
 =?utf-8?B?c29GRmtMNW5tUFRlQnpGczJQYWxJamRGTHlicjBNb1RBcC84SXJFZ2lJN3FY?=
 =?utf-8?B?T3FCcktHbG5HTFJwM0NRVG4yNFJCRW5CUnNSMzRuS1lCQ1FxYTF2R1N0MFpL?=
 =?utf-8?B?SEpKdHFadTYzangrRkM3WW9PYm1TOVhpbFlKTENWK2VKQUd0MURNd0ZHYVQv?=
 =?utf-8?B?aWI4UXliOVVaK3ZZS0lCaTQwT2FaQW9YTG1SdkROMFBLSUdTTHpQR3N1Ynlr?=
 =?utf-8?B?OVI3WXB1eXZpQitUZmVGbW5LYm14VVkyN1BXZW51SDZwN0V0d3pLNG9ieVQr?=
 =?utf-8?B?bHBHUjdyUzY1RDlQUS9Nb3RWcm9xeEJjTE5JTXRhWFJLTmF1ODR6NDZSQXBS?=
 =?utf-8?B?djZlOXRFKytyWnVHREh0ekNzSjB4NjB3QWNZWElWeXRwekZOQTNyTVJPNkhi?=
 =?utf-8?B?WVBWU3Q3cTRZaFgxTm1ldDE4UENZZnREM2c4SlRJQ2lmTWN2YXZPbjJuOFZt?=
 =?utf-8?B?SDZta0hsTFVsQ2ZMZVJjNFRiRFZSWWhHTFAyNDBuQjFkS0V1YWZLUCtEM3J6?=
 =?utf-8?B?VWJDNmhWWWRhbWNQcHdWK0xxUXErOEM5czZydVZwNm5IR1h5aW5abEZTRFIx?=
 =?utf-8?B?ZVdoSDl1REdjOW54eWxIU2M4R1VPUDRYT1dGc2pFenJVODFzakV0eHpQcmts?=
 =?utf-8?B?a0ZjV2VJZHBXa2dieHV5SFZFdm54dkpYWHN6T2J0QXRmTExJbEdsa2F1dzNz?=
 =?utf-8?B?dENzY3FReFJ1MU1wOUdxeGM4VVN2NHlYZW5oYnVjR01hajNOMmY2SVNWWkZ2?=
 =?utf-8?B?VVBWQ3l3ZktnemRJam8rS3J6UkwremJRdGZ5anJuRTR0Q2plWE5nd1BaMnZy?=
 =?utf-8?B?NzREOWNmUjBIZmNsWGZ4dnMrRCtLL01nZkg1cjJKYUtTdmNiM2NINFJhbU5K?=
 =?utf-8?B?UXFuSnp0aHQ5cEt5b2Zoa0xZMTY5Ui8yTUJWcm5Sd1A4djVzOFdmUUZSdkRk?=
 =?utf-8?Q?UGvF6thTm1WeMg6PIK8d8Z8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A52A004F44EAAD47963CB429E1E03087@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d953c1de-d056-4d48-7662-08dd04f0f8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 21:11:57.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpkRopQ5WBNOEdIBXp5METGmv0/O31MGxPG9XMynPtBwUF4AWvSLLKPV5+LlV9pU7KavwZsxkmwpvjTJDWYwzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4985
X-Proofpoint-GUID: NPt7YTuyZPsDWTfCa619DoQMktzdfxeQ
X-Proofpoint-ORIG-GUID: NPt7YTuyZPsDWTfCa619DoQMktzdfxeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQ2hyaXN0aWFuLCANCg0KPiBPbiBOb3YgMTMsIDIwMjQsIGF0IDI6MTnigK9BTSwgQ2hyaXN0
aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4gd3JvdGU6DQoNClsuLi5dDQoNCj4+IHN0
YXRpYyBpbmxpbmUgdm9pZCBicGZfbHNtX2ZpbmRfY2dyb3VwX3NoaW0oY29uc3Qgc3RydWN0IGJw
Zl9wcm9nICpwcm9nLA0KPj4gICBicGZfZnVuY190ICpicGZfZnVuYykNCj4+IHsNCj4+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+IGluZGV4
IDM1NTk0NDYyNzljMS4uNDc5MDk3ZTRkZDViIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51
eC9mcy5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+IEBAIC03OSw2ICs3OSw3IEBA
IHN0cnVjdCBmc19jb250ZXh0Ow0KPj4gc3RydWN0IGZzX3BhcmFtZXRlcl9zcGVjOw0KPj4gc3Ry
dWN0IGZpbGVhdHRyOw0KPj4gc3RydWN0IGlvbWFwX29wczsNCj4+ICtzdHJ1Y3QgYnBmX2xvY2Fs
X3N0b3JhZ2U7DQo+PiANCj4+IGV4dGVybiB2b2lkIF9faW5pdCBpbm9kZV9pbml0KHZvaWQpOw0K
Pj4gZXh0ZXJuIHZvaWQgX19pbml0IGlub2RlX2luaXRfZWFybHkodm9pZCk7DQo+PiBAQCAtNjQ4
LDYgKzY0OSw5IEBAIHN0cnVjdCBpbm9kZSB7DQo+PiAjaWZkZWYgQ09ORklHX1NFQ1VSSVRZDQo+
PiB2b2lkICppX3NlY3VyaXR5Ow0KPj4gI2VuZGlmDQo+PiArI2lmZGVmIENPTkZJR19CUEZfU1lT
Q0FMTA0KPj4gKyBzdHJ1Y3QgYnBmX2xvY2FsX3N0b3JhZ2UgX19yY3UgKmlfYnBmX3N0b3JhZ2U7
DQo+PiArI2VuZGlmDQo+IA0KPiBTb3JyeSwgd2UncmUgbm90IGdyb3dpbmcgc3RydWN0IGlub2Rl
IGZvciB0aGlzLiBJdCBqdXN0IGtlZXBzIGdldHRpbmcNCj4gYmlnZ2VyLiBMYXN0IGN5Y2xlIHdl
IGZyZWVkIHVwIDggYnl0ZXMgdG8gc2hyaW5rIGl0IGFuZCB3ZSdyZSBub3QgZ29pbmcNCj4gdG8g
d2FzdGUgdGhlbSBvbiBzcGVjaWFsLXB1cnBvc2Ugc3R1ZmYuIFdlIGFscmVhZHkgTkFLZWQgc29t
ZW9uZSBlbHNlJ3MNCj4gcGV0IGZpZWxkIGhlcmUuDQoNClBlciBvdGhlciBkaXNjdXNzaW9ucyBp
biB0aGlzIHRocmVhZCwgSSBhbSBpbXBsZW1lbnRpbmcgdGhlIGZvbGxvd2luZzoNCg0KI2lmZGVm
IENPTkZJR19TRUNVUklUWQ0KICAgICAgICB2b2lkICAgICAgICAgICAgICAgICAgICAqaV9zZWN1
cml0eTsNCiNlbGlmIENPTkZJR19CUEZfU1lTQ0FMTA0KICAgICAgICBzdHJ1Y3QgYnBmX2xvY2Fs
X3N0b3JhZ2UgX19yY3UgKmlfYnBmX3N0b3JhZ2U7DQojZW5kaWYNCg0KSG93ZXZlciwgaXQgaXMg
YSBiaXQgdHJpY2tpZXIgdGhhbiBJIHRob3VnaHQuIFNwZWNpZmljYWxseSwgd2UgbmVlZCANCnRv
IGRlYWwgd2l0aCB0aGUgZm9sbG93aW5nIHNjZW5hcmlvczoNCiANCjEuIENPTkZJR19TRUNVUklU
WT15ICYmIENPTkZJR19CUEZfTFNNPW4gJiYgQ09ORklHX0JQRl9TWVNDQUxMPXkNCjIuIENPTkZJ
R19TRUNVUklUWT15ICYmIENPTkZJR19CUEZfTFNNPXkgJiYgQ09ORklHX0JQRl9TWVNDQUxMPXkg
YnV0IA0KICAgYnBmIGxzbSBpcyBub3QgZW5hYmxlZCBhdCBib290IHRpbWUuIA0KDQpBRkFJQ1Qs
IHdlIG5lZWQgdG8gbW9kaWZ5IGhvdyBsc20gYmxvYiBhcmUgbWFuYWdlZCB3aXRoIA0KQ09ORklH
X0JQRl9TWVNDQUxMPXkgJiYgQ09ORklHX0JQRl9MU009biBjYXNlLiBUaGUgc29sdXRpb24sIGV2
ZW4NCmlmIGl0IGdldHMgYWNjZXB0ZWQsIGRvZXNuJ3QgcmVhbGx5IHNhdmUgYW55IG1lbW9yeS4g
SW5zdGVhZCBvZiANCmdyb3dpbmcgc3RydWN0IGlub2RlIGJ5IDggYnl0ZXMsIHRoZSBzb2x1dGlv
biB3aWxsIGFsbG9jYXRlIDgNCm1vcmUgYnl0ZXMgdG8gaW5vZGUtPmlfc2VjdXJpdHkuIFNvIHRo
ZSB0b3RhbCBtZW1vcnkgY29uc3VtcHRpb24NCmlzIHRoZSBzYW1lLCBidXQgdGhlIG1lbW9yeSBp
cyBtb3JlIGZyYWdtZW50ZWQuIA0KDQpUaGVyZWZvcmUsIEkgdGhpbmsgd2Ugc2hvdWxkIHJlYWxs
eSBzdGVwIGJhY2sgYW5kIGNvbnNpZGVyIGFkZGluZw0KdGhlIGlfYnBmX3N0b3JhZ2UgdG8gc3Ry
dWN0IGlub2RlLiBXaGlsZSB0aGlzIGRvZXMgaW5jcmVhc2UgdGhlDQpzaXplIG9mIHN0cnVjdCBp
bm9kZSBieSA4IGJ5dGVzLCBpdCBtYXkgZW5kIHVwIHdpdGggbGVzcyBvdmVyYWxsDQptZW1vcnkg
Y29uc3VtcHRpb24gZm9yIHRoZSBzeXN0ZW0uIFRoaXMgaXMgd2h5LiANCg0KV2hlbiB0aGUgdXNl
ciBjYW5ub3QgdXNlIGlub2RlIGxvY2FsIHN0b3JhZ2UsIHRoZSBhbHRlcm5hdGl2ZSBpcyANCnRv
IHVzZSBoYXNoIG1hcHMgKHVzZSBpbm9kZSBwb2ludGVyIGFzIGtleSkuIEFGQUlDVCwgYWxsIGhh
c2ggbWFwcyANCmNvbWVzIHdpdGggbm9uLXRyaXZpYWwgb3ZlcmhlYWQsIGluIG1lbW9yeSBjb25z
dW1wdGlvbiwgaW4gYWNjZXNzIA0KbGF0ZW5jeSwgYW5kIGluIGV4dHJhIGNvZGUgdG8gbWFuYWdl
IHRoZSBtZW1vcnkuIE9UT0gsIGlub2RlIGxvY2FsIA0Kc3RvcmFnZSBkb2Vzbid0IGhhdmUgdGhl
c2UgaXNzdWUsIGFuZCBpcyB1c3VhbGx5IG11Y2ggbW9yZSBlZmZpY2llbnQ6IA0KIC0gbWVtb3J5
IGlzIG9ubHkgYWxsb2NhdGVkIGZvciBpbm9kZXMgd2l0aCBhY3R1YWwgZGF0YSwgDQogLSBPKDEp
IGxhdGVuY3ksIA0KIC0gcGVyIGlub2RlIGRhdGEgaXMgZnJlZWQgYXV0b21hdGljYWxseSB3aGVu
IHRoZSBpbm9kZSBpcyBldmljdGVkLiANClBsZWFzZSByZWZlciB0byBbMV0gd2hlcmUgQW1pciBt
ZW50aW9uZWQgYWxsIHRoZSB3b3JrIG5lZWRlZCB0byANCnByb3Blcmx5IG1hbmFnZSBhIGhhc2gg
bWFwLCBhbmQgSSBleHBsYWluZWQgd2h5IHdlIGRvbid0IG5lZWQgdG8gDQp3b3JyeSBhYm91dCB0
aGVzZSB3aXRoIGlub2RlIGxvY2FsIHN0b3JhZ2UuIA0KDQpCZXNpZGVzIHJlZHVjaW5nIG1lbW9y
eSBjb25zdW1wdGlvbiwgaV9icGZfc3RvcmFnZSBhbHNvIHNob3J0ZW5zIA0KdGhlIHBvaW50ZXIg
Y2hhaW4gdG8gYWNjZXNzIGlub2RlIGxvY2FsIHN0b3JhZ2UuIEJlZm9yZSB0aGlzIHNldCwgDQpp
bm9kZSBsb2NhbCBzdG9yYWdlIGlzIGF2YWlsYWJsZSBhdCANCmlub2RlLT5pX3NlY3VyaXR5K29m
ZnNldChzdHJ1Y3QgYnBmX3N0b3JhZ2VfYmxvYiktPnN0b3JhZ2UuIEFmdGVyIA0KdGhpcyBzZXQs
IGlub2RlIGxvY2FsIHN0b3JhZ2UgaXMgc2ltcGx5IGF0IGlub2RlLT5pX2JwZl9zdG9yYWdlLiAN
Cg0KQXQgdGhlIG1vbWVudCwgd2UgYXJlIHVzaW5nIGJwZiBsb2NhbCBzdG9yYWdlIHdpdGggDQp0
YXNrX3N0cnVjdC0+YnBmX3N0b3JhZ2UsIHN0cnVjdCBzb2NrLT5za19icGZfc3RvcmFnZSwgDQpz
dHJ1Y3QgY2dyb3VwLT5icGZfY2dycF9zdG9yYWdlLiBBbGwgb2YgdGhlc2UgdHVybmVkIG91dCB0
byBiZSANCnN1Y2Nlc3NmdWwgYW5kIGhlbHBlZCB1c2VycyB0byB1c2UgbWVtb3J5IG1vcmUgZWZm
aWNpZW50bHkuIEkgDQp0aGluayB3ZSBjYW4gc2VlIHRoZSBzYW1lIGJlbmVmaXRzIHdpdGggc3Ry
dWN0IGlub2RlLT5pX2JwZl9zdG9yYWdlLiANCg0KSSBob3BlIHRoZXNlIG1ha2Ugc2Vuc2UsIGFu
ZCB5b3Ugd2lsbCBjb25zaWRlciBhZGRpbmcgaV9icGZfc3RvcmFnZS4NClBsZWFzZSBsZXQgbWUg
a25vdyBpZiBhbnl0aGluZyBhYm92ZSBpcyBub3QgY2xlYXIuIA0KDQpUaGFua3MsDQpTb25nDQoN
ClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsL0NBT1E0dXhqWGpqa0tN
YTF4Y1B5eEU1dnhoMVU1b0daSld0b2ZSQ3dwLTNpa0NBNmNnZ0BtYWlsLmdtYWlsLmNvbS8NCg0K
DQo=

